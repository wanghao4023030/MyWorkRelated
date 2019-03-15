USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetPatientInfo]    Script Date: 09/20/2017 13:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:<Gary,Shi>
-- Create date:<2014-08-21>
-- Alter date:<2014-12-18>
-- Description:PS1000 get patient information.
-- <param name="@TerminalInfo">Terminal IP or other info. (optional)</param>
-- <param name="@CardType">1: Bar Code; 2:IC Card; etc. (optional)</param>
-- <param name="@CardNumber">Card Number. (required)</param>
-- <param name="@ReturnType">Return Type: PATIENT_ID、ACCESSION_NUMBER、STUDY_INSTANCE_UID. (required)</param>
-- <param name="@ReturnValue">Return Value. (required)</param>
-- <param name="@PatientName">Patient Name: Chinese Name. (required)</param>
-- <param name="@Message">The message will be0 shown on the terminal screen. (optional)</param>
/*
declare @TerminalInfo nvarchar(32)='192.168.1.100'
declare @CardType nvarchar(128)='ACCESSION_NUMBER'
declare @CardNumber nvarchar(128)='GYDX201608170568' 
declare @ReturnType nvarchar(128)='PATIENT_ID'
declare @OutputInfo xml=''
exec sp_Integration_GetPatientInfo @TerminalInfo,@CardType,@CardNumber,@ReturnType,@OutputInfo output
*/

-- =============================================
Create PROCEDURE [dbo].[sp_Integration_GetPatientInfo]
	@TerminalInfo nvarchar(32),
	@CardType nvarchar(128),
	@CardNumber nvarchar(128),
	@ReturnType nvarchar(128),
	@OutputInfo xml output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Warning: Null value is eliminated by an aggregate or other SET operation.
	-- SET ANSI_WARNINGS OFF;

	SET @TerminalInfo = LTRIM(RTRIM(ISNULL(@TerminalInfo,'')))
	SET @CardType = LTRIM(RTRIM(ISNULL(@CardType,'')))
	SET @CardNumber = LTRIM(RTRIM(ISNULL(@CardNumber,'')))
	SET @ReturnType = UPPER(LTRIM(RTRIM(ISNULL(@ReturnType,''))))
	SET @OutputInfo = '<OutputInfo><Status>sp_Integration_GetPatientInfo:Success</Status><CardNumber>'+@CardNumber+'</CardNumber></OutputInfo>'

	DECLARE @ItemCount int =0
	DECLARE @ItemCount1 int =0
	DECLARE @ItemCount2 int = 0
	DECLARE @ItemCount3 int = 0
	DECLARE @ItemCount4 int = 0
	DECLARE @ItemCount5 int = 0
	DECLARE @ItemCountEx int = 0
	DECLARE @PrintMode int = 0
	DECLARE @FilmStoredFlag int =0
	DECLARE @ReportStoredFlag int =0
	DECLARE @FilmPrintFlag int =0
	DECLARE @ReportPrintFlag int =0
	DECLARE @MSGKey nvarchar(128) = 'aaaaa'
	DECLARE @MSGValue nvarchar(max) = ''
	DECLARE @ExamCount int = 0
	DECLARE @Days int = 90
	
	DECLARE @PatientID nvarchar(max) = ''
	DECLARE @AccessionNumber nvarchar(max) = ''
	DECLARE @PatientName nvarchar(32) = ''
	DECLARE @Gender nvarchar(16) = ''
	DECLARE @BirthDay nvarchar(64) = ''
	
	--BEGIN TRANSACTION TGetPatientInfo
	BEGIN TRY
		-- Sync	Exam status 
		DECLARE CurPatientID CURSOR
		FOR SELECT PatientID,AccessionNumber,NameCN,Gender,BirthDay FROM T_Integration_ExamInfo WHERE (PatientID = @CardNumber AND 'PATIENT_ID' = @CardType) OR (AccessionNumber = @CardNumber AND 'ACCESSION_NUMBER' = @CardType)
		OPEN CurPatientID
		FETCH NEXT FROM CurPatientID INTO @PatientID,@AccessionNumber,@PatientName,@Gender,@BirthDay
		WHILE (@@FETCH_STATUS = 0) 
		BEGIN
			IF ((@PatientID <> '') AND (@AccessionNumber <> ''))
			BEGIN
				SELECT @FilmStoredFlag = (CASE [WGGC].[dbo].[AFP_F_GetFilmPrintStatus]('',@AccessionNumber) WHEN -1 THEN 0 WHEN 2 THEN 0 ELSE 9 END)
					,@ReportStoredFlag = (CASE [WGGC].[dbo].[AFP_F_GetReportPrintStatus](@AccessionNumber) WHEN -1 THEN 0 WHEN 2 THEN 0 ELSE 9 END)
					,@FilmPrintFlag = (CASE [WGGC].[dbo].[AFP_F_GetFilmPrintStatus]('',@AccessionNumber) WHEN -1 THEN 0 WHEN 2 THEN 0 ELSE [WGGC].[dbo].[AFP_F_GetFilmPrintStatus]('',@AccessionNumber) END)
					,@ReportPrintFlag = (CASE [WGGC].[dbo].[AFP_F_GetReportPrintStatus](@AccessionNumber) WHEN -1 THEN 0 WHEN 2 THEN 0 ELSE [WGGC].[dbo].[AFP_F_GetReportPrintStatus](@AccessionNumber) END)
					
				UPDATE [WGGC].[dbo].[T_Integration_ExamInfo] 
				SET FilmStoredFlag = @FilmStoredFlag,
					ReportStoredFlag = @ReportStoredFlag,
					FilmPrintFlag = @FilmPrintFlag,
					ReportPrintFlag = @ReportPrintFlag
				WHERE (''<>@AccessionNumber) AND ([AccessionNumber]=@AccessionNumber)
			END
			FETCH NEXT FROM CurPatientID INTO @PatientID,@AccessionNumber,@PatientName,@Gender,@BirthDay
		END
		
		CLOSE CurPatientID
		DEALLOCATE CurPatientID
	
		IF ('PATIENT_ID' = @ReturnType AND 'ACCESSION_NUMBER' = @CardType)
		BEGIN
			SET @CardType = 'PATIENT_ID'
			SELECT @CardNumber = [PatientID] FROM T_Integration_ExamInfo WHERE [AccessionNumber] = @CardNumber
		END
	
		SELECT @ItemCount = COUNT(0)
		FROM [T_Integration_ExamInfo]
		WHERE (''<>@CardNumber) AND (FilmStoredFlag=9 OR ReportStoredFlag = 9)
		AND (('PATIENT_ID'=@CardType AND [PatientID]=@CardNumber) OR ('ACCESSION_NUMBER'=@CardType AND [AccessionNumber]=@CardNumber))
		
		
		IF(0>=@ItemCount)
		BEGIN
			SET @MSGKey = '*00**'
		END
		ELSE IF ('PATIENT_ID'=@CardType)
		BEGIN			
			/* 查询15天内胶片已存储\报告已发布\胶片未打印的患者 */
			SELECT @ItemCountEx = Count(0)
			FROM T_Integration_ExamInfo
			WHERE ('' <> @CardNumber)
			AND ((AccessionNumber = @CardNumber) OR (PatientID = @CardNumber))
			AND (ISNULL([FilmStoredFlag],0) = 9)			--胶片已存储
			AND (ISNULL([ReportStoredFlag],0) = 9)			--报告已存储
			AND (ISNULL(FilmPrintFlag,0) IN (-10,0))		--胶片未打印	
			AND (ISNULL(ReportPrintFlag,0) IN (-10,0))		--报告未打印
			AND DATEDIFF(DAY,T_Integration_ExamInfo.CreateDT, GETDATE()) < @Days --[T_Integration_ExamInfo].CreateDT > DATEADD(day,-7,GETDATE())  
			
			IF (@ItemCountEx > 0)
			BEGIN
				SET @MSGKey = '*9900'
			END
			ELSE BEGIN
				--只打胶片（打印模式）
				SELECT @ItemCount1 = COUNT(0)
				FROM [T_Integration_ExamInfo]
				LEFT JOIN [AFP_PrintMode] ON [T_Integration_ExamInfo].[AccessionNumber]=[AFP_PrintMode].[AccessionNumber]
				WHERE (''<>@CardNumber)
				AND ([T_Integration_ExamInfo].[PatientID]=@CardNumber)
				AND (ISNULL([T_Integration_ExamInfo].[FilmStoredFlag],0) = 9)
				AND (ISNULL([T_Integration_ExamInfo].FilmPrintFlag,0) IN (-10,0))
				AND DATEDIFF(DAY,T_Integration_ExamInfo.CreateDT, GETDATE()) < @Days --[T_Integration_ExamInfo].CreateDT>DATEADD(day,-7,GETDATE())
				AND (1 = ISNULL([AFP_PrintMode].[PrintMode],0))
				
				--只打报告（打印模式）
				SELECT @ItemCount2 = COUNT(0)
				FROM [T_Integration_ExamInfo]
				LEFT JOIN [AFP_PrintMode] ON [T_Integration_ExamInfo].[AccessionNumber]=[AFP_PrintMode].[AccessionNumber]
				WHERE (''<>@CardNumber)
				AND ([T_Integration_ExamInfo].[PatientID]=@CardNumber)
				AND (ISNULL([T_Integration_ExamInfo].ReportPrintFlag,0) IN (-10,0))
				AND (ISNULL([T_Integration_ExamInfo].[ReportStoredFlag],0) = 9)
				AND DATEDIFF(DAY,T_Integration_ExamInfo.CreateDT, GETDATE()) < @Days --[T_Integration_ExamInfo].CreateDT>DATEADD(day,-7,GETDATE())
				AND (2=ISNULL([AFP_PrintMode].[PrintMode],0))
				
				--胶片或报告分别打印 （打印模式）
				SELECT @ItemCount3 = COUNT(0)
				FROM [T_Integration_ExamInfo]
				LEFT JOIN [AFP_PrintMode] ON [T_Integration_ExamInfo].[AccessionNumber]=[AFP_PrintMode].[AccessionNumber]
				WHERE (''<>@CardNumber)
				AND ([T_Integration_ExamInfo].[PatientID]=@CardNumber)
				AND ((ISNULL([T_Integration_ExamInfo].[FilmPrintFlag],0) IN (-10,0) 
						AND ISNULL([T_Integration_ExamInfo].[FilmStoredFlag],0) = 9)
					OR (ISNULL([T_Integration_ExamInfo].[ReportPrintFlag],0) IN (-10,0) 
						AND ISNULL([T_Integration_ExamInfo].[ReportStoredFlag],0) = 9))
				--AND (ISNULL([T_Integration_ExamInfo].[ReportPrintFlag],0) = 1)
				AND DATEDIFF(DAY,T_Integration_ExamInfo.CreateDT, GETDATE()) < @Days --[T_Integration_ExamInfo].CreateDT>DATEADD(day,-7,GETDATE())
				AND (3=ISNULL([AFP_PrintMode].[PrintMode],0))
				
				--胶片报告一起打印 （打印模式）
				SELECT @ItemCount5 = COUNT(0)
				FROM [T_Integration_ExamInfo]
				LEFT JOIN [AFP_PrintMode] ON [T_Integration_ExamInfo].[AccessionNumber]=[AFP_PrintMode].[AccessionNumber]
				WHERE (''<>@CardNumber)
				AND ([T_Integration_ExamInfo].[PatientID]=@CardNumber)
				AND ((ISNULL([T_Integration_ExamInfo].[FilmPrintFlag],0) IN (-10,0) 
						AND ISNULL([T_Integration_ExamInfo].[FilmStoredFlag],0) = 9)
					AND (ISNULL([T_Integration_ExamInfo].[ReportPrintFlag],0) IN (-10,0) 
						AND ISNULL([T_Integration_ExamInfo].[ReportStoredFlag],0) = 9))
				--AND (ISNULL([T_Integration_ExamInfo].[ReportPrintFlag],0) = 1)
				AND DATEDIFF(DAY,T_Integration_ExamInfo.CreateDT, GETDATE()) < @Days --[T_Integration_ExamInfo].CreateDT>DATEADD(day,-7,GETDATE())
				AND (0=ISNULL([AFP_PrintMode].[PrintMode],0))
				
				SELECT @ItemCount4 = COUNT(0)
				FROM [T_Integration_ExamInfo]
				LEFT JOIN [AFP_PrintMode] ON [T_Integration_ExamInfo].[AccessionNumber]=[AFP_PrintMode].[AccessionNumber]
				WHERE (''<>@CardNumber)
				AND ([T_Integration_ExamInfo].[PatientID]=@CardNumber)
				AND (ISNULL([T_Integration_ExamInfo].[FilmPrintFlag],0) = 1 AND ISNULL([T_Integration_ExamInfo].[ReportPrintFlag],0) = 1)
				AND DATEDIFF(DAY,T_Integration_ExamInfo.CreateDT, GETDATE()) < @Days
				
				IF (@ItemCount1 > 0)
				BEGIN
					SET @MSGKey = '3900*'
					--SET @ItemCount = 0
				END
				ELSE BEGIN
					IF (@ItemCount2 > 0)
					BEGIN
						SET @MSGKey = '309*0'
						--SET @ItemCount = 0
					END
					ELSE BEGIN
						IF (@ItemCount3 > 0)
						BEGIN
							SET @MSGKey = 'ccccc'
							--SET @ItemCount = 0
						END
						ELSE IF (@ItemCount5 > 0) 
						BEGIN
							SET @MSGKey = '*00**'
						END
						ELSE IF (@ItemCount4 > 0)  
						BEGIN
							SET @MSGKey = '*00**'
						END
						ELSE BEGIN
							SET @MSGKey = '*00**'
							SET @ItemCount = 0
						END
					END
				END
			END                                               
		END
		ELSE IF ('ACCESSION_NUMBER'=@CardType)
		BEGIN
			SELECT @PrintMode=ISNULL([PrintMode],0)
			FROM [AFP_PrintMode]
			WHERE (''<>@CardNumber) AND ([AccessionNumber]=@CardNumber)

			IF (0=@FilmStoredFlag AND 0=@ReportStoredFlag)
			BEGIN
				SET @MSGKey = '*00**'
			END
			ELSE IF (3=@FilmPrintFlag OR 3=@ReportPrintFlag)
			BEGIN
				SET @MSGKey = '***33'
			END
			ELSE IF (@FilmPrintFlag IN (1,2) AND @ReportPrintFlag IN (1,2))
			BEGIN
				SET @MSGKey = '***'+CONVERT(nvarchar(32),@FilmPrintFlag)+CONVERT(nvarchar(32),@ReportPrintFlag)
			END
			ELSE IF (9=@FilmStoredFlag AND 9=@ReportStoredFlag AND 0=@FilmPrintFlag AND 0=@ReportPrintFlag)
			BEGIN
				SET @MSGKey = '*9900'
			END
			ELSE IF (0=@PrintMode)
			BEGIN
				IF (@FilmStoredFlag<>@ReportStoredFlag)
				BEGIN
					SET @MSGKey = '0'+CONVERT(nvarchar(32),@FilmStoredFlag)+CONVERT(nvarchar(32),@ReportStoredFlag)+'**'
				END
				ELSE IF (9=@FilmStoredFlag AND 9=@ReportStoredFlag)
				BEGIN
					SET @MSGKey = '099'+CONVERT(nvarchar(32),@FilmPrintFlag)+CONVERT(nvarchar(32),@ReportPrintFlag)
				END
			END
			ELSE IF (1=@PrintMode)
			BEGIN
				IF (0=@FilmStoredFlag)
				BEGIN
					SET @MSGKey = '10***'
				END
				ELSE IF (9=@FilmStoredFlag)
				BEGIN
					SET @MSGKey = '19*'+CONVERT(nvarchar(32),@FilmPrintFlag)+'*'
				END
			END
			ELSE IF (2=@PrintMode)
			BEGIN
				IF (0=@ReportStoredFlag)
				BEGIN
					SET @MSGKey = '2*0**'
				END
				ELSE IF (9=@ReportStoredFlag)
				BEGIN
					SET @MSGKey = '2*9*'+CONVERT(nvarchar(32),@ReportPrintFlag)
				END
			END
			ELSE IF (3=@PrintMode)
			BEGIN
				IF (9=@FilmStoredFlag AND 0=@ReportStoredFlag)
				BEGIN
					SET @MSGKey = '390'+CONVERT(nvarchar(32),@FilmPrintFlag)+'*'
				END
				ELSE IF (0=@FilmStoredFlag AND 9=@ReportStoredFlag)
				BEGIN
					SET @MSGKey = '309*'+CONVERT(nvarchar(32),@ReportPrintFlag)
				END
				ELSE IF (9=@FilmStoredFlag AND 9=@ReportStoredFlag)
				BEGIN
					SET @MSGKey = '399'+CONVERT(nvarchar(32),@FilmPrintFlag)+CONVERT(nvarchar(32),@ReportPrintFlag)
				END
			END
		END

		SELECT @MSGValue = [Value]
		FROM T_Integration_Dictionary
		WHERE ('MSG' = TagType) AND (@MSGKey=[Key] OR 'aaaaa'=[Key])

		IF(0>=@ItemCount)
		BEGIN
			SELECT '' AS PatientID
			,'' AS [AccessionNumber]
			,'' AS [StudyInstanceUID]
			,@PatientName AS NameCN
			,'' AS [NameEN]
			,@Gender AS Gender
			,@BirthDay AS BirthDay
			,'' AS [Modality]
			,'' AS [ModalityName]
			,'' AS [PatientType]
			,'' AS [VisitID]
			,'' AS [RequestID]
			,'' AS [RequestDepartment]
			,'' AS [RequestDT]
			,'' AS [RegisterDT]
			,'' AS [ExamDT]
			,'' AS [SubmitDT]
			,'' AS [ApproveDT]
			,'' AS [PDFReportURL]
			,'' AS [StudyStatus]
			,'' AS [ReportStatus]
			,'' AS [PDFFlag]
			,'' AS [PDFDT]
			,'' AS [VerifyFilmFlag]
			,'' AS [VerifyFilmDT]
			,'' AS [VerifyReportFlag]
			,'' AS [VerifyReportDT]
			,'' AS [FilmStoredFlag]
			,'' AS [FilmStoredDT]
			,'' AS [ReportStoredFlag]
			,'' AS [ReportStoredDT]
			,'' AS [NotifyReportFlag]
			,'' AS [NotifyReportDT]
			,'' AS [SetPrintModeFlag]
			,'' AS [SetPrintModeDT]
			,'' AS [FilmPrintFlag]
			,'' AS [FilmPrintDoctor]
			,'' AS [FilmPrintDT]
			,'' AS [ReportPrintFlag]
			,'' AS [ReportPrintDoctor]
			,'' AS [ReportPrintDT]
			
			,'' AS [OutHospitalNo]
			,'' AS [InHospitalNo]
			,'' AS [PhysicalNumber]
			,'' AS [ExamName]
			,'' AS [ExamBodyPart]
			
			,'' AS [Optional0]
			,'' AS [Optional1]
			,'' AS [Optional2]
			,'' AS [Optional3]
			,'' AS [Optional4]
			,'' AS [Optional5]
			,'' AS [Optional6]
			,'' AS [Optional7]
			,'' AS [Optional8]
			,'' AS [Optional9]
			,'' AS [ReturnValue]
			,@MSGValue AS [Message]
		END
		ELSE
		BEGIN
			SELECT DISTINCT [PatientID]
				,[AccessionNumber]
				,[StudyInstanceUID]
				,[NameCN]
				,[NameEN]
				,[Gender]
				,[Birthday]
				,[Modality]
				,[ModalityName]
				,[PatientType]
				,[VisitID]
				,[RequestID]
				,[RequestDepartment]
				,[RequestDT]
				,[RegisterDT]
				,[ExamDT]
				,[SubmitDT]
				,[ApproveDT]
				,[PDFReportURL]
				,[StudyStatus]
				,[ReportStatus]
				,[PDFFlag]
				,[PDFDT]
				,[VerifyFilmFlag]
				,[VerifyFilmDT]
				,[VerifyReportFlag]
				,[VerifyReportDT]
				,[FilmStoredFlag]
				,[FilmStoredDT]
				,[ReportStoredFlag]
				,[ReportStoredDT]
				,[NotifyReportFlag]
				,[NotifyReportDT]
				,[SetPrintModeFlag]
				,[SetPrintModeDT]
				,[FilmPrintFlag]
				,[FilmPrintDoctor]
				,[FilmPrintDT]
				,[ReportPrintFlag]
				,[ReportPrintDoctor]
				,[ReportPrintDT]
				
				,[OutHospitalNo]
				,[InHospitalNo]
				,[PhysicalNumber]
				,[ExamName]
				,[ExamBodyPart]
				
				,[Optional0]
				,[Optional1]
				,[Optional2]
				,[Optional3]
				,[Optional4]
				,[Optional5]
				,[Optional6]
				,[Optional7]
				,[Optional8]
				,[Optional9]
				,(CASE
					WHEN @ReturnType='PATIENT_ID' THEN [PatientID]
					WHEN @ReturnType='ACCESSION_NUMBER' THEN [AccessionNumber]
					WHEN @ReturnType='STUDY_INSTANCE_UID' THEN [StudyInstanceUID]
					ELSE '' END) AS [ReturnValue]
				,@MSGValue AS [Message]
			FROM [T_Integration_ExamInfo]
			WHERE (''<>@CardNumber)
			AND (('PATIENT_ID'=@CardType AND [PatientID]=@CardNumber AND DATEDIFF(DAY,T_Integration_ExamInfo.CreateDT, GETDATE()) < @Days) 
				OR ('ACCESSION_NUMBER'=@CardType AND [AccessionNumber]=@CardNumber))			
		END

		--COMMIT TRANSACTION TGetPatientInfo
	END TRY
	BEGIN CATCH
		--ROLLBACK TRANSACTION TGetPatientInfo
		SET @OutputInfo = '<OutputInfo><Status>sp_Integration_GetPatientInfo:Error</Status><CardNumber>'+@CardNumber+'</CardNumber></OutputInfo>'
		SELECT '' AS [PatientID]
			,'' AS [AccessionNumber]
			,'' AS [StudyInstanceUID]
			,'' AS [NameCN]
			,'' AS [NameEN]
			,'' AS [Gender]
			,'' AS [Birthday]
			,'' AS [Modality]
			,'' AS [ModalityName]
			,'' AS [PatientType]
			,'' AS [VisitID]
			,'' AS [RequestID]
			,'' AS [RequestDepartment]
			,'' AS [RequestDT]
			,'' AS [RegisterDT]
			,'' AS [ExamDT]
			,'' AS [SubmitDT]
			,'' AS [ApproveDT]
			,'' AS [PDFReportURL]
			,'' AS [StudyStatus]
			,'' AS [ReportStatus]
			,'' AS [PDFFlag]
			,'' AS [PDFDT]
			,'' AS [VerifyFilmFlag]
			,'' AS [VerifyFilmDT]
			,'' AS [VerifyReportFlag]
			,'' AS [VerifyReportDT]
			,'' AS [FilmStoredFlag]
			,'' AS [FilmStoredDT]
			,'' AS [ReportStoredFlag]
			,'' AS [ReportStoredDT]
			,'' AS [NotifyReportFlag]
			,'' AS [NotifyReportDT]
			,'' AS [SetPrintModeFlag]
			,'' AS [SetPrintModeDT]
			,'' AS [FilmPrintFlag]
			,'' AS [FilmPrintDoctor]
			,'' AS [FilmPrintDT]
			,'' AS [ReportPrintFlag]
			,'' AS [ReportPrintDoctor]
			,'' AS [ReportPrintDT]
			
			,'' AS [OutHospitalNo]
			,'' AS [InHospitalNo]
			,'' AS [PhysicalNumber]
			,'' AS [ExamName]
			,'' AS [ExamBodyPart]
			
			,'' AS [Optional0]
			,'' AS [Optional1]
			,'' AS [Optional2]
			,'' AS [Optional3]
			,'' AS [Optional4]
			,'' AS [Optional5]
			,'' AS [Optional6]
			,'' AS [Optional7]
			,'' AS [Optional8]
			,'' AS [Optional9]
			,'' AS [ReturnValue]
			,'您没有内容可打印，谢谢！' AS [Message]
	END CATCH
END

