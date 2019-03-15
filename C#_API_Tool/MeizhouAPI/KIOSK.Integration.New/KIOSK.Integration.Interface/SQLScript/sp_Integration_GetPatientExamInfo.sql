USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetPatientExamInfo]    Script Date: 07/26/2017 17:27:35 ******/
IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_GetPatientExamInfo') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_GetPatientExamInfo
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
DECLARE @UserHostAddress nvarchar(128) = '127.0.0.1'
DECLARE @CardType nvarchar(128) = 'PATIENT_ID'
DECLARE @CardNumber nvarchar(128) = '2946894'
exec sp_Integration_GetPatientExamInfo @UserHostAddress,@CardType,@CardNumber
*/

-- =============================================
-- Author:		<Author:Haijun Lu>
-- Create date: <Create Date:2017-1-10>
-- Description:	<Description:For 3rd query patient examinfo.>
-- =============================================
Create PROCEDURE [dbo].[sp_Integration_GetPatientExamInfo]
	-- Add the parameters for the stored procedure here
	@UserHostAddress nvarchar(32),
	@CardType nvarchar(128),
	@CardNumber nvarchar(128)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- 
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @PatientID nvarchar(128) = ''
    DECLARE @AccessionNumber nvarchar(128) = ''    
	DECLARE @FilmsCount int = 0
	DECLARE @ReportCount int = 0
	DECLARE @PatientName nvarchar(128) = ''
	DECLARE @FilmCount810 int = 0
	DECLARE @FilmCount1417 int = 0
	DECLARE @FilmCount1414 int = 0
	DECLARE @FilmCount1114 int = 0
	DECLARE @FilmCount1012 int = 0
	
	-- 获取患者姓名
	select @PatientName = PatientName from AFP_FilmInfo where FilmFlag = 0 AND DeleteStatus = 0 AND
		(('PATIENT_ID' = @CardType AND PatientID = @CardNumber) OR ('ACCESSION_NUMBER' = @CardType AND AccessionNumber = @Cardnumber))
	--获取胶片总数
	select @FilmsCount = count(*) from AFP_FilmInfo AF
	INNER JOIN AFP_PrintMode APM ON AF.AccessionNumber =APM.AccessionNumber 
	where PrintMode in (0,1,3) AND FilmFlag = 0 AND DeleteStatus = 0 AND 
	(('PATIENT_ID' = @CardType AND PatientID = @CardNumber) OR ('ACCESSION_NUMBER' = @CardType AND AF.AccessionNumber = @CardNumber))
	--获取报告总数        
	select @ReportCount = count(*) from AFP_ReportInfo AR
	INNER JOIN AFP_PrintMode APM ON AR.AccessionNumber =APM.AccessionNumber
	where PrintMode in (0,2,3) AND PrintStatus = 0 AND ReportStatus = 2 AND AAccessionNumber ='' AND AStudyInstanceUID ='' AND
	(('PATIENT_ID' = @CardType AND PatientID = @CardNumber) OR ('ACCESSION_NUMBER' = @CardType AND AR.AccessionNumber = @CardNumber))

	--获取8*10未打印胶片总数
	Select @FilmCount810 = count(*) from AFP_FilmInfo where FilmSizeID = '8INX10IN' and FilmFlag = 0 AND DeleteStatus = 0 AND 
		(('PATIENT_ID' = @CardType AND PatientID = @CardNumber) OR ('ACCESSION_NUMBER' = @CardType AND AccessionNumber = @CardNumber))
	--获取14*17未打印胶片总数
	Select @FilmCount1417 = count(*) from AFP_FilmInfo where FilmSizeID = '14INX17IN' and FilmFlag = 0 AND DeleteStatus = 0 AND 
		(('PATIENT_ID' = @CardType AND PatientID = @CardNumber) OR ('ACCESSION_NUMBER' = @CardType AND AccessionNumber = @CardNumber))
    --获取14INX14IN未打印胶片总数
	Select @FilmCount1414 = count(*) from AFP_FilmInfo where FilmSizeID = '14INX14IN' and FilmFlag = 0 AND DeleteStatus = 0 AND 
		(('PATIENT_ID' = @CardType AND PatientID = @CardNumber) OR ('ACCESSION_NUMBER' = @CardType AND AccessionNumber = @CardNumber))
	--获取11INX14IN未打印胶片总数
	Select @FilmCount1114 = count(*) from AFP_FilmInfo where FilmSizeID = '11INX14IN' and FilmFlag = 0 AND DeleteStatus = 0 AND 
		(('PATIENT_ID' = @CardType AND PatientID = @CardNumber) OR ('ACCESSION_NUMBER' = @CardType AND AccessionNumber = @CardNumber))
	--获取10INX12IN未打印胶片总数
	Select @FilmCount1012 = count(*) from AFP_FilmInfo where FilmSizeID = '10INX12IN' and FilmFlag = 0 AND DeleteStatus = 0 AND 
		(('PATIENT_ID' = @CardType AND PatientID = @CardNumber) OR ('ACCESSION_NUMBER' = @CardType AND AccessionNumber = @CardNumber))
	        
	select @PatientName as PatientName, @FilmsCount as FilmCount,@ReportCount AS ReportCount,
	       @FilmCount810 as FilmCount810,@FilmCount1417 as FilmCount1417,@FilmCount1414 as FilmCount1414,
	       @FilmCount1114 as FilmCount1114,@FilmCount1012 as FilmCount1012
END
