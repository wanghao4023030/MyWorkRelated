USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_QueryParam]    Script Date: 12/14/2018 15:04:53 ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_QueryParam') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_QueryParam
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:  <Shiye Yang>
-- Create date: <2018-12-14>
-- Description: <For KIOSK Query Recognize Param>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_QueryParam]
	@Param nvarchar(max),
	@QueryInterval int,
	@ParamCount int output,
	@OutputInfo xml output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL NVARCHAR(max) = ''
	DECLARE @iNum int = 0
	DECLARE @BeforeDateTime datetime=Dateadd(S,-@QueryInterval,GETDATE())
	
	BEGIN TRY
		SET @OutputInfo = '<OutputInfo>sp_Integration_QueryParam:Success</OutputInfo>'

		SET @SQL=N'DELETE FROM T_Integration_RecognizeParam WHERE  StoredDT<=@p'
		EXEC sp_executesql @SQL , N'@p AS datetime',@p = @BeforeDateTime

		SET @SQL=N'SELECT @Num=COUNT(0) FROM T_Integration_RecognizeParam WHERE RecognizeParam=@p'
		EXEC sp_executesql @SQL , N'@p AS nvarchar(max),@Num AS int OUTPUT',@p = @Param,@Num=@iNum OUTPUT

		SET @ParamCount=@iNum
	END TRY
	BEGIN CATCH
		SET @OutputInfo = '<OutputInfo>sp_Integration_QueryParam:Error</OutputInfo>'
	END CATCH
END

