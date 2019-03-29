USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_SetPrintMode]    Script Date: 10/12/2017 14:32:19 ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_SetPrintMode') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_SetPrintMode
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  <Shiye Yang>
-- Create date: <2017-10-12>
-- Alter date: <2017-10-12>
-- Description: <For Integration Set GetPrintMode>
/*
declare @AccessionNumber nvarchar(128)='JSDR201412171320' 
declare @OutputInfo xml=''
exec sp_Integration_SetPrintMode @AccessionNumber,@OutputInfo output
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_SetPrintMode]
	@AccessionNumber nvarchar(128),
	@PrintMode int output,
	@OutputInfo xml output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL NVARCHAR(3000) = ''
	DECLARE @PatientType nvarchar(32) = ''
	DECLARE @sPrintMode nvarchar(32) = '3'
	DECLARE @Num int=0
	DECLARE @CurrentTime datetime

	-- PatientType:
	-- 1: in patient;
	-- 2: out patient;
	-- 3: emergency;
	-- 4: physical examination;
	-- 5: other.
	-- Default: print when both film and report are ready;
	-- 0: print when both film and report are ready;
	-- 1: print film only;
	-- 2: print report only;
	-- 3: print any available;
	-- 4: do not print.
	
	BEGIN TRY
		SET @AccessionNumber = LTRIM(RTRIM(ISNULL(@AccessionNumber,'')))
		IF(''<>@AccessionNumber)
		BEGIN
			SET @SQL=N'SELECT TOP 1 @Type=[PatientType]
			FROM [dbo].[T_Integration_ExamInfo]
			WHERE [AccessionNumber]=@p'
			EXEC sp_executesql @SQL , N'@p AS varchar(128),@Type AS varchar(32) OUTPUT',@p = @AccessionNumber,@Type = @PatientType OUTPUT
			
			SET @SQL=N'SELECT TOP 1 @Type=[Value]
			FROM [dbo].[T_Integration_Dictionary]
			WHERE [TagType]=''PatientType'' AND [Key]=@p'
			EXEC sp_executesql @SQL , N'@p AS varchar(128),@Type AS varchar(32) OUTPUT',@p = @PatientType,@Type = @PatientType OUTPUT

			SET @SQL=N'SELECT TOP 1 @Mode=[Key]
			FROM [dbo].[T_Integration_Dictionary]
			WHERE [TagType]=''PrintMode'' AND ([Value]=@p OR [Value]=''Other'')'
			EXEC sp_executesql @SQL , N'@p AS varchar(128),@Mode AS varchar(32) OUTPUT',@p = @PatientType,@Mode = @sPrintMode OUTPUT
		
			SET @PrintMode=CONVERT(INT,@sPrintMode)
		
			SET @SQL=N'SELECT @ICount=COUNT(0) FROM AFP_PrintMode WHERE AccessionNumber=@p'
			EXEC sp_executesql @SQL , N'@p AS varchar(128),@ICount AS int OUTPUT',@p = @AccessionNumber,@ICount = @Num OUTPUT
			
			SET @CurrentTime=GETDATE()
			
			IF @Num=0
			BEGIN
				SET @SQL=N'INSERT INTO AFP_PrintMode(AccessionNumber,PrintMode,StatusTime) VALUES(@AccNum,@Mode,@Time)'
				EXEC sp_executesql @SQL , N'@AccNum AS varchar(128),@Mode AS int,@Time AS datetime',
				@AccNum = @AccessionNumber,@Mode=@PrintMode,@Time=@CurrentTime
			END
			ELSE
			BEGIN
				SET @SQL=N'UPDATE AFP_PrintMode SET PrintMode=@Mode,StatusTime=@Time WHERE AccessionNumber=@AccNum'
				EXEC sp_executesql @SQL , N'@AccNum AS varchar(128),@Mode AS int,@Time AS datetime',
				@AccNum = @AccessionNumber,@Mode=@PrintMode,@Time=@CurrentTime
			END
		END
		
		SET @OutputInfo = '<OutputInfo>sp_Integration_SetPrintMode:Success. @AccessionNumber['+@AccessionNumber+'] @PrintMode['+@sPrintMode+']</OutputInfo>'
	END TRY
	BEGIN CATCH
		SET @OutputInfo = '<OutputInfo>sp_Integration_SetPrintMode:Fail. @AccessionNumber['+@AccessionNumber+'] @PrintMode['+@sPrintMode+']</OutputInfo>'
	END CATCH
END
