USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetReportInfo_MulReport]    Script Date: 05/16/2016 15:20:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Lu haijun>
-- Create date: <2015-4-12>
-- Description:	<Get RIS Report For Download>
-- =============================================
/*
DECLARE @PatientID nvarchar(max) = '3111064'
DECLARE @PatientName varchar(max) = ''
DECLARE @AccessionNumber varchar(max) = 'JI160517XDR1108'
DECLARE @Modality nvarchar(max) = ''
DECLARE @ReportID nvarchar(max) = ''
DECLARE @ReportStatus nvarchar(max) = ''
DECLARE @OutputInfo xml = ''
DECLARE @OutReport nvarchar(max) = ''
exec sp_Integration_GetReportInfo_MulReport @PatientID,@PatientName,@AccessionNumber,@Modality,@ReportID,@ReportStatus,@OutputInfo output,@OutReport output
select @OutputInfo,@OutReport
*/
CREATE PROCEDURE [dbo].[sp_Integration_GetReportInfo_MulReport]
	@PatientID nvarchar(max),
	@PatientName varchar(max),
	@AccessionNumber varchar(max),
	@Modality nvarchar(max),
	@ReportID nvarchar(max),
	@ReportStatus nvarchar(max),
	@OutputInfo xml output,
	@OutReport nvarchar(max) output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	SET @OutputInfo = '<OutputInfo>SP_Integration_GetReportInfo_ReportID:Success</OutputInfo>'
	SET @OutReport = ''
	
	DECLARE @DAYS INT = 7
	DECLARE @MinutesForMR int = 15 -- 2 hour
	DECLARE @MinutesForCT int = 15 -- 2 Hour
	DECLARE @minutesForDX int = 10 -- 1 Hour
	DECLARE @CurrentDT datetime = GetDate()
	DECLARE @Where nvarchar(max) = ''
	DECLARE @WhereEx nvarchar(max) = ''
	DECLARE @SQL nvarchar(max) = ''
	DECLARE @SQLEx nvarchar(max) = ''
	DECLARE @PDFReport nvarchar(max) = ''
	DECLARE @PDFReportEx nvarchar(max) = ''
	DECLARE @ReportCount int = 0
	DECLARE @ReportCountEx int = 0
	DECLARE @AccessionNumberEx nvarchar(max) = ''
	DECLARE @PDFReportAcc nvarchar(max) = ''
	
	--BEGIN TRANSACTION TGetReportInfoReportID
	BEGIN TRY
		IF (Len(@PatientID) > 0)
		BEGIN
		  SET @Where = @Where + ' AND (PatientID IN ('''+@PatientID+'''))'
		END
		IF (LEN(@PatientName) > 0)
		BEGIN
		  SET @Where = @Where + ' AND (NameCN IN ('''+@PatientName+''') OR NameEN IN ('''+@PatientName+'''))'
		END
		IF (LEN(@AccessionNumber) > 0)
		BEGIN
		  SET @Where = @Where + ' AND (AccessionNumber IN ('''+@AccessionNumber+'''))'
		END
		IF (LEN(@Modality) > 0)
		BEGIN
		  SET @Where = @Where + ' AND (Modality IN ('''+@Modality+'''))'
		END
		IF (LEN(@ReportID) > 0)
		BEGIN
		  SET @Where = @Where + ' AND ReportID IN ('''+@ReportID+''')'
		END
		IF (LEN(@ReportStatus) > 0)
		BEGIN
		  SET @Where = @Where + ' AND StudyStatus IN ('''+@ReportStatus+''')'
		END	
	
		if (LEN(@Where) > 0)
		BEGIN
			CREATE TABLE #TMPREPORT
			(
				[PatientID] [nvarchar](128) NOT NULL,
				[AccessionNumber] [nvarchar](128) NOT NULL,
				[NameCN] [nvarchar](128) NULL,
				[NameEN] [nvarchar](128) NULL,
				[Gender] [nvarchar](32) NULL,
				[Birthday] [nvarchar](32) NULL,
				[Modality] [nvarchar](32) NULL,
				[ModalityName] [nvarchar](128) NULL,
				[PatientType] [nvarchar](32) NULL,
				[ExamDT] [nvarchar](32) NULL,
				[SubmitDT] [nvarchar](32) NULL,
				[ApproveDT] [nvarchar](32) NULL,
				[PDFReportURL] [nvarchar](256) NULL,
				[StudyStatus] [nvarchar](32) NULL,
				[ReportStatus] [nvarchar](32) NULL,
				[OutHospitalNo] [nvarchar](128) NULL,
				[InHospitalNo] [nvarchar](128) NULL,
				[PhysicalNumber] [nvarchar](128) NULL,
				[ExamName] [nvarchar](256) NULL,
				[ExamBodyPart] [nvarchar](256) NULL,
				[ReportID] [nvarchar](32) NULL,
				[RequestID] [nvarchar](32) NULL
			)	
			CREATE TABLE #TMPREPORTEX
			(
				[PatientID] [nvarchar](128) NOT NULL,
				[AccessionNumber] [nvarchar](128) NOT NULL,
				[NameCN] [nvarchar](128) NULL,				
				[PDFReportURL] [nvarchar](256) NULL
			)
			-- 1\ search patient examinfo by accessionnumber
		    --
		    SET @SQL = 'INSERT INTO #TMPREPORT([PatientID],[AccessionNumber],[NameCN],[NameEN],[Gender],[Birthday],[Modality],[ModalityName],
					[PatientType],[ExamDT],[SubmitDT],[ApproveDT],[PDFReportURL],[StudyStatus],[ReportStatus],[RequestID])
				 SELECT PatientID,AccessionNumber,NameCN,NameEN,Gender,Birthday,Modality,ModalityName,PatientType,ExamDT,SubmitDT,ApproveDT,
					PDFReportURL,StudyStatus,ReportStatus,RequestID						
				 FROM OPENQUERY(RISDB, ''SELECT PatientID,AccessionNumber,NameCN,NameEN,Gender,Birthday,ModalityTypeName Modality,ModalityName,
					PatientType,ExamDT,SubmitDT,ApproveDT,PDFReportURL,StudyStatus,0 ReportStatus,RequestID 
					FROM v_report_print WHERE 1=1 AND PDFReportURL <> '''''''' AND PatientID = '''''+@PatientID+ ''''''')'
			--SELECT @SQL
			EXEC (@SQL)
			
			SET @SQL = 'INSERT INTO #TMPREPORTEX([PatientID],[AccessionNumber],[NameCN],[PDFReportURL])
					SELECT PatientID,AccessionNumber,NameCN,PDFReportURL FROM #TMPREPORT WHERE StudyStatus = ''审核'' 
					AND AccessionNumber = '''+@AccessionNumber+''''
			--SELECT @SQL
			EXEC (@SQL)	
			
			SELECT @ReportCount = count(distinct PDFReportURL) FROM #TMPREPORTEX WHERE AccessionNumber = @AccessionNumber
		
			IF (@ReportCount > 1)		-- AccessionNumber has many REPORTs
			BEGIN						
				DECLARE CursorPDF CURSOR
				FOR SELECT PDFReportURL FROM #TMPREPORT
				OPEN CursorPDF
				FETCH NEXT FROM CursorPDF INTO @PDFReport
				WHILE (@@FETCH_STATUS = 0)
				BEGIN
				  IF (@PDFReportEx = '')
					SET @PDFReportEx = @PDFReport
				  ELSE 
				    SET @PDFReportEx = @PDFReportEx + ',' + @PDFReport
				  FETCH NEXT FROM CursorPDF INTO @PDFReport
				END
				
				CLOSE CursorPDF
				DEALLOCATE CursorPDF
			END	
			ELSE IF (@ReportCount = 1)
			BEGIN
			  SELECT @PDFReport = PDFReportURL FROM #TMPREPORTEX WHERE AccessionNumber = @AccessionNumber	  
			  DELETE FROM #TMPREPORTEX
			  
			  SELECT @ReportCountEx = COUNT(DISTINCT AccessionNumber) FROM #TMPREPORT WHERE PDFReportURL = RTRIM(LTRIM(@PDFReport))
			  IF (@ReportCountEx = 1)		-- ACCESSIONNUMBER has only one REPORT
			  BEGIN
			    SET @PDFReportEx = @PDFReport
			  END
			  ELSE IF (@ReportCountEx > 1)	-- Many REPORTs with a ACCESSIONNUMBER
			  BEGIN
			    SET @SQL = 'INSERT INTO #TMPREPORTEX([PatientID],[AccessionNumber],[NameCN],[PDFReportURL])
				 SELECT [PatientID],[AccessionNumber],[NameCN],[PDFReportURL]					
				 FROM #TMPREPORT WHERE 1=1 AND PDFReportURL = '''+ @PDFReport +''''
				--SELECT @SQL
				EXEC (@SQL)
				
				DECLARE CursorPDF CURSOR
				FOR SELECT PDFReportURL,AccessionNumber FROM #TMPREPORTEX
				OPEN CursorPDF
				FETCH NEXT FROM CursorPDF INTO @PDFReport,@AccessionNumberEx
				WHILE (@@FETCH_STATUS = 0)
				BEGIN
					IF (@AccessionNumber = @AccessionNumberEx)
					BEGIN
						SET @PDFReportAcc = @PDFReport
					END
					ELSE BEGIN
						IF (@PDFReportEx = '')
							SET @PDFReportEx = 'asso://' + @AccessionNumberEx
						ELSE 
							SET @PDFReportEx = @PDFReportEx + ',' + 'asso://' + @AccessionNumberEx
					END
					
				 -- IF (@PDFReportEx = '')
				 -- BEGIN
					--IF (@AccessionNumber = @AccessionNumberEx)
					--	SET @PDFReportEx = @PDFReport
					--ELSE 
					--	SET @PDFReportEx = 'asso://' + @AccessionNumberEx
				 -- END				  
				 -- ELSE BEGIN 
					--IF (@AccessionNumber <> @AccessionNumberEx) 
					--	SET @PDFReportEx = @PDFReportEx + ',asso://' +@AccessionNumberEx-- + '/'+ @PDFReport
					--ELSE
					--	SET @PDFReportEx = @PDFReportEx + ',' + @PDFReport
				 -- END
				  FETCH NEXT FROM CursorPDF INTO @PDFReport,@AccessionNumberEx
				END
				
				CLOSE CursorPDF
				DEALLOCATE CursorPDF
				SET @PDFReportEx = @PDFReportAcc + ',' + @PDFReportEx
			  END
			END	
			SET @PDFReportEx = REPLACE(@PDFReportEx, '/razorback/RISShare/home/ftprazor/','')
			SELECT * FROM #TMPREPORT WHERE PatientID = @PatientID AND AccessionNumber = @AccessionNumber
			DROP TABLE #TMPREPORT
			DROP TABLE #TMPREPORTEX
		END
	  SET @OutputInfo = '<OutputInfo>sp_Integration_GetReportInfo_MulReport:Success PatientID['+@PatientID+'] Name['+@PatientName+']
			 AccessionNumber['+@AccessionNumber+' Modality['+@Modality+'] ReportID['+@ReportID+']</OutputInfo>'
	  SET @OutReport = @PDFReportEx
	  

	  --COMMIT TRANSACTION TGetReportInfoReportID
	END TRY
	BEGIN CATCH
		--ROLLBACK TRANSACTION TGetReportInfoReportID
		SET @OutputInfo = '<OutputInfo>SP_Integration_GetReportInfo_ReportID:Error PatientID='+@PatientID+'</OutputInfo>'
	END CATCH
END
