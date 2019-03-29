USE [WGGC]
GO

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_SaveParam') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_SaveParam
END  
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:<Shiye Yang>
-- Create date:<2018-12-14>
-- Description:
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_SaveParam]
	@RecognizeParam nvarchar (max),
	@OutputInfo xml output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL NVARCHAR(max) = ''
	DECLARE @CurrentTime datetime=GETDATE()

	BEGIN TRY
		SET @SQL='IF NOT EXISTS(SELECT ID FROM T_Integration_RecognizeParam WHERE RecognizeParam=@pRecognizeParam)
				BEGIN
					INSERT INTO T_Integration_RecognizeParam(StoredDT,RecognizeParam)
					VALUES(@pStoredDT,@pRecognizeParam)
				END'

		EXEC sp_executesql @SQL ,
		N'@pStoredDT as datetime,@pRecognizeParam as nvarchar(max)',
		@pStoredDT = @CurrentTime,@pRecognizeParam = @RecognizeParam

		SET @OutputInfo = '<OutputInfo>sp_Integration_SaveParam:Success </OutputInfo>'
	END TRY
	BEGIN CATCH
		SET @OutputInfo = '<OutputInfo>sp_Integration_SaveParam:Error</OutputInfo>'
	END CATCH
END

