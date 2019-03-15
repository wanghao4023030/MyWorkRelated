USE [GCRIS2]
GO
/****** Object:  StoredProcedure [dbo].[sp_KIOSK_GetExamInfoEx]    Script Date: 12/29/2014 11:32:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:<Gary,Shi>
-- Create date:<2013-12-17>
-- Alter  date:<2013-12-18>
-- Description: <For KIOSK Get ExamInfo>
/***@QueryParam***
declare	@QueryParam nvarchar(max) = '<queryParam>
	<patientID>P000946746,P000833560</patientID>
	<patientName>王太玉,张三</patientName>
	<gender>男,女</gender>
	<age>Age</age>
	<patientType>门诊病人</patientType>
	<outHospitalNo>OutHospitalNo</outHospitalNo>
	<inHospitalNo>InHospitalNo</inHospitalNo>
	<physicalExamNo>PhysicalExamNo</physicalExamNo>
	<accessionNumber>JSDR201412171320,ZHDR201412190831</accessionNumber>
	<referringDepartment>ReferringDepartment</referringDepartment>
	<modalityType>MR,DR</modalityType>
	<modalityName>DR_2,JS_DR1</modalityName>
	<examName>ExamName</examName>
	<examBodypart>ExamBodypart</examBodypart>
	<registerDT>RegisterDT</registerDT>
	<examDT>ExamDT</examDT>
	<submitDT>SubmitDT</submitDT>
	<approveDT>ApproveDT</approveDT>
	<optional0>Optional0</optional0>
	<optional1>Optional1</optional1>
	<optional2>Optional2</optional2>
	<optional3>Optional3</optional3>
	<optional4>Optional4</optional4>
	<optional5>Optional5</optional5>
</queryParam>'
declare	@OutputInfo xml =''
exec sp_KIOSK_GetExamInfoEx @QueryParam,@OutputInfo output
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_KIOSK_GetExamInfoEx]
	@QueryParam xml = '',
	@OutputInfo xml output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @QueryParam = ISNULL(@QueryParam,'')
	SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfoEx:Success</OutputInfo>'

	DECLARE @PatientID nvarchar(128) = ''
	DECLARE @PatientName nvarchar(128) = ''
	DECLARE @Gender nvarchar(32) =''
	DECLARE @Age nvarchar(32) =''
	DECLARE @PatientType nvarchar(128) =''
	DECLARE @OutHospitalNo nvarchar(128) =''
	DECLARE @InHospitalNo nvarchar(128) = ''
	DECLARE @PhysicalExamNo nvarchar(128) = ''
	DECLARE @AccessionNumber nvarchar(128) =''
	DECLARE @ReferringDepartment nvarchar(128) =''
	DECLARE @ModalityType nvarchar(128) =''
	DECLARE @ModalityName nvarchar(128) =''
	DECLARE @ExamName nvarchar(max) =''
	DECLARE @ExamBodypart nvarchar(max) =''
	DECLARE @RegisterDT nvarchar(32) =''
	DECLARE @ExamDT nvarchar(32) =''
	DECLARE @SubmitDT nvarchar(32) =''
	DECLARE @ApproveDT nvarchar(32) =''
	DECLARE @Optional0 nvarchar(256) =''
	DECLARE @Optional1 nvarchar(256) =''
	DECLARE @Optional2 nvarchar(256) =''
	DECLARE @Optional3 nvarchar(256) =''
	DECLARE @Optional4 nvarchar(256) =''
	DECLARE @Optional5 nvarchar(256) =''

	DECLARE @DocumentHandle int = ''
	DECLARE @SQL nvarchar(max) = ''
	DECLARE @WHERE nvarchar(max) = ''

	BEGIN TRANSACTION TGetExamInfoEx
	BEGIN TRY
		EXEC sp_xml_preparedocument @DocumentHandle output, @QueryParam

		SELECT @PatientID=ltrim(rtrim(isnull(patientID,'')))
			,@PatientName=ltrim(rtrim(isnull(patientName,'')))
			,@Gender=ltrim(rtrim(isnull(gender,'')))
			,@Age=ltrim(rtrim(isnull(age,'')))
			,@PatientType=ltrim(rtrim(isnull(patientType,'')))
			,@OutHospitalNo=ltrim(rtrim(isnull(outHospitalNo,'')))
			,@InHospitalNo=ltrim(rtrim(isnull(inHospitalNo,'')))
			,@PhysicalExamNo=ltrim(rtrim(isnull(physicalExamNo,'')))
			,@AccessionNumber=ltrim(rtrim(isnull(accessionNumber,'')))
			,@ReferringDepartment=ltrim(rtrim(isnull(referringDepartment,'')))
			,@ModalityType=ltrim(rtrim(isnull(modalityType,'')))
			,@ModalityName=ltrim(rtrim(isnull(modalityName,'')))
			,@ExamName=ltrim(rtrim(isnull(examName,'')))
			,@ExamBodypart=ltrim(rtrim(isnull(examBodypart,'')))
			,@RegisterDT=ltrim(rtrim(isnull(registerDT,'')))
			,@ExamDT=ltrim(rtrim(isnull(examDT,'')))
			,@SubmitDT=ltrim(rtrim(isnull(submitDT,'')))
			,@ApproveDT=ltrim(rtrim(isnull(approveDT,'')))
			,@Optional0=ltrim(rtrim(isnull(optional0,'')))
			,@Optional1=ltrim(rtrim(isnull(optional1,'')))
			,@Optional2=ltrim(rtrim(isnull(optional2,'')))
			,@Optional3=ltrim(rtrim(isnull(optional3,'')))
			,@Optional4=ltrim(rtrim(isnull(optional4,'')))
			,@Optional5=ltrim(rtrim(isnull(optional5,'')))
		FROM openxml(@DocumentHandle, '/queryParam', 2) --1:attribute 2:element 3:attribute&element
		WITH
		(-- Query Condition Info
			 patientID nvarchar(128) 'patientID'
			,patientName nvarchar(128) 'patientName'
			,gender nvarchar(32) 'gender'
			,age nvarchar(32) 'age'
			,patientType nvarchar(128) 'patientType'
			,outHospitalNo nvarchar(128) 'outHospitalNo'
			,inHospitalNo nvarchar(128) 'inHospitalNo'
			,physicalExamNo nvarchar(128) 'physicalExamNo'
			,accessionNumber nvarchar(128) 'accessionNumber'
			,referringDepartment nvarchar(128) 'referringDepartment'
			,modalityType nvarchar(128) 'modalityType'
			,modalityName nvarchar(128) 'modalityName'
			,examName nvarchar(max) 'examName'
			,examBodypart nvarchar(max) 'examBodypart'
			,registerDT nvarchar(32) 'registerDT'
			,examDT nvarchar(32) 'examDT'
			,submitDT nvarchar(32) 'submitDT'
			,approveDT nvarchar(32) 'approveDT'
			,optional0 nvarchar(256) 'optional0'
			,optional1 nvarchar(256) 'optional1'
			,optional2 nvarchar(256) 'optional2'
			,optional3 nvarchar(256) 'optional3'
			,optional4 nvarchar(256) 'optional4'
			,optional5 nvarchar(256) 'optional5'
		)

		EXEC sp_xml_removedocument @DocumentHandle
		
		IF ((0 < LEN(@PatientIDs)) AND (0 < LEN(@AccessionNumbers)))
		BEGIN
			IF(0<LEN(@PatientIDs))
			BEGIN
				SET @PatientIDList = REPLACE(@PatientIDs,',',''',''')
				SET @WHERE = @WHERE+' AND (PatientID IN (''' + @PatientIDList + '''))'
			END
			IF(0<LEN(@AccessionNumbers))
			BEGIN
				SET @AccessionNumberList = REPLACE(@AccessionNumbers,',',''',''')
				SET @WHERE = @WHERE+' AND (AccessionNumber IN (''' + @AccessionNumberList + '''))'
			END
		END
		ELSE BEGIN
			IF(0<LEN(@PatientID))
			BEGIN
				SET @PatientID = REPLACE(@PatientID,',',''',''')
				SET @WHERE = @WHERE+' AND (PatientID IN (''' + @PatientID + '''))'
			END

			IF(0<LEN(@PatientName))
			BEGIN
				SET @PatientName = REPLACE(@PatientName,',',''',''')
				SET @WHERE = @WHERE+' AND (NameEN IN (''' + @PatientName + ''') OR NameCN IN (''' + @PatientName + '''))'
			END

			IF(0<LEN(@AccessionNumber))
			BEGIN
				SET @AccessionNumber = REPLACE(@AccessionNumber,',',''',''')
				SET @WHERE = @WHERE+' AND (AccessionNumber IN (''' + @AccessionNumber + '''))'
			END

			IF(0<LEN(@ModalityType))
			BEGIN
				SET @ModalityType = REPLACE(@ModalityType,',',''',''')
				SET @WHERE = @WHERE+' AND (Modality IN (''' + @ModalityType + ''') OR ModalityName IN (''' + @ModalityType + '''))'
			END

			IF(0<LEN(@ModalityType))
			BEGIN
				SET @ModalityName = REPLACE(@ModalityName,',',''',''')
				SET @WHERE = @WHERE+' AND (Modality IN (''' + @ModalityName + ''') OR ModalityName IN (''' + @ModalityName + '''))'
			END
			
			IF (0 < LEN(@ExamName))
			BEGIN
				SET @ExamName = REPLACE(@ExamName,',',''',''')
				SET @WHERE = @WHERE+' AND (ExamName IN (''' + @ExamName + '''))'
			END
			
			IF (0 < LEN(@ExamBodypart))
			BEGIN
				SET @ExamBodypart = REPLACE(@ExamBodypart,',',''',''')
				SET @WHERE = @WHERE+' AND (ExamBodyPart IN (''' + @ExamBodypart + '''))'
			END
		END

		IF(0<LEN(@AccessionNumber))
		BEGIN
			SET @SQL = 'SELECT [PatientID],[AccessionNumber],[NameEN],[NameCN],[Gender],[Birthday],[Modality],[ModalityName]
				,(CASE [PatientType] WHEN ''住院病人'' THEN ''1'' WHEN ''门诊病人'' THEN ''2'' WHEN ''急诊病人'' THEN ''3'' WHEN ''体检病人'' THEN ''4'' ELSE ''5'' END) AS [PatientType]
				,[VisitID],[RequestID],[RequestDepartment],[RequestDT],[RegisterDT],[ExamDT],[SubmitDt],[ApproveDT],[PDFReportURL],[StudyStatus]
				,[OutHospitalNo],[InHospitalNo],[PhysicalNumber],[ExamName],[ExamBodyPart]
				,[Optional0],[Optional1],[Optional2],[Optional3],[Optional4],[Optional5],[Optional6],[Optional7],[Optional8],[Optional9]
				 FROM GCRIS2.dbo.vi_KIOSK_ExamInfo_Order WHERE 1=1' + @WHERE + ' ORDER BY ExamDT DESC' 
		END
		ELSE
		BEGIN
			SET @SQL = 'SELECT [PatientID],[AccessionNumber],[NameEN],[NameCN],[Gender],[Birthday],[Modality],[ModalityName]
				,(CASE [PatientType] WHEN ''住院病人'' THEN ''1'' WHEN ''门诊病人'' THEN ''2'' WHEN ''急诊病人'' THEN ''3'' WHEN ''体检病人'' THEN ''4'' ELSE ''5'' END) AS [PatientType]
				,[VisitID],[RequestID],[RequestDepartment],[RequestDT],[RegisterDT],[ExamDT],[SubmitDt],[ApproveDT],[PDFReportURL],[StudyStatus]
				,[OutHospitalNo],[InHospitalNo],[PhysicalNumber],[ExamName],[ExamBodyPart]
				,[Optional0],[Optional1],[Optional2],[Optional3],[Optional4],[Optional5],[Optional6],[Optional7],[Optional8],[Optional9]
				 FROM GCRIS2.dbo.vi_KIOSK_ExamInfo_Patient WHERE 1=1' + @WHERE + ' ORDER BY ExamDT DESC'
		END

		--SELECT @SQL
		EXEC (@SQL)

		SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfoEx:Success PatientID['+@PatientID+'] Name['+@PatientName+'] AccessionNumber['+@AccessionNumber+'] ModalityType['+@ModalityType+'] ModalityName['+@ModalityName+']</OutputInfo>'
		COMMIT TRANSACTION TGetExamInfoEx
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION TGetExamInfoEx
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfoEx:Error PatientID['+@PatientID+'] Name['+@PatientName+'] AccessionNumber['+@AccessionNumber+'] ModalityType['+@ModalityType+'] ModalityName['+@ModalityName+']</OutputInfo>'
	END CATCH
END
GO
