USE [GCRIS2]
GO
/****** Object:  StoredProcedure [dbo].[sp_KIOSK_SetReportInfo]    Script Date: 12/29/2014 11:32:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  <Gary Shi>
-- Create date: <2014-08-30>
-- Alter date: <2014-12-18>
-- Description:<For KIOSK Set ReportInfo.>
-- =============================================
CREATE PROCEDURE [dbo].[sp_KIOSK_SetReportInfo]
	@PatientID nvarchar(max),
	@AccessionNumber nvarchar(max),
	@ReportID nvarchar(max),
	@PDFReportPath nvarchar(max),
	@OutputInfo xml output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Warning: Null value is eliminated by an aggregate or other SET operation.
	-- SET ANSI_WARNINGS OFF;

	SET @PDFReportPath = LTRIM(RTRIM(ISNULL(@PDFReportPath,'')))
	SET @OutputInfo = '<OutputInfo>sp_KIOSK_SetReportInfo:Success</OutputInfo>'
	--SET @AccessionNumber='ZHDR201412190831'

	BEGIN TRANSACTION TKIOSKSetReportInfo
	BEGIN TRY
		UPDATE [dbo].[tReport] SET [IsPrint]=1
		FROM [dbo].[tReport] rep
		INNER JOIN [dbo].[tRegProcedure] pro ON rep.[ReportGuid] = pro.[ReportGuid]
		INNER JOIN [dbo].[tRegOrder] ord ON pro.[OrderGuid]=ord.[OrderGuid]
		WHERE ord.[AccNo]=@AccessionNumber

		SET @OutputInfo = '<OutputInfo>sp_KIOSK_SetReportInfo:Success AccessionNumber['+@AccessionNumber+']</OutputInfo>'
		COMMIT TRANSACTION TKIOSKSetReportInfo
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION TKIOSKSetReportInfo
		SET @OutputInfo = '<OutputInfo>sp_KIOSK_SetReportInfo:Error AccessionNumber['+@AccessionNumber+']</OutputInfo>'
	END CATCH
END
GO
