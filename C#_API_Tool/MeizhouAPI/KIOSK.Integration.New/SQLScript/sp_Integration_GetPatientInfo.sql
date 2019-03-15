USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetPatientInfo]    Script Date: 10/16/2017 1:17:49 AM ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_GetPatientInfo') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_GetPatientInfo
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:<Shiye Yang>
-- Create date:<2017-05-18>
-- Alter date:<2017-05-18>
-- Description:PS1000 get patient information.
-- <param name="@TerminalInfo">Terminal IP or other info. (optional)</param>
-- <param name="@CardType">1: Bar Code; 2:IC Card; etc. (optional)</param>
-- <param name="@CardNumber">Card Number. (required)</param>
-- <param name="@ReturnType">Return Type: PATIENT_ID、ACCESSION_NUMBER、STUDY_INSTANCE_UID. (required)</param>
-- <param name="@ReturnValue">Return Value. (required)</param>
-- <param name="@PatientName">Patient Name: Chinese Name. (required)</param>
-- <param name="@Message">The message will be shown on the terminal screen. (optional)</param>
/*
declare @TerminalInfo nvarchar(32)='192.168.1.100'
declare @CardType nvarchar(128)='ACCESSION_NUMBER'
declare @CardNumber nvarchar(128)='JSDR201412171320' 
declare @ReturnType nvarchar(128)='ACCESSION_NUMBER'
declare @OutputInfo xml=''
exec sp_Integration_GetPatientInfo @TerminalInfo,@CardType,@CardNumber,@ReturnType,@OutputInfo output
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_GetPatientInfo]
	@TerminalInfo nvarchar(32),
	@CardType nvarchar(128),
	@CardNumber nvarchar(128),
	@ReturnType nvarchar(128),
	@OutputInfo xml output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @PrintMode int = 0
	DECLARE @FilmStoredFlag int =0
	DECLARE @ReportStoredFlag int =0
	DECLARE @FilmPrintFlag int =0
	DECLARE @ReportPrintFlag int =0
	DECLARE @MSGKey nvarchar(200) = ''
	DECLARE @MSGValue nvarchar(2000) = ''
	DECLARE @MSGAllowKey nvarchar(200) = ''
	DECLARE @MSGAllowValue nvarchar(2000) = ''
	DECLARE @MSGCount int = 0
	DECLARE @SQL NVARCHAR(3000) = ''
	DECLARE @AllowPrint int = 0
	DECLARE @AllowPrintCount int = 0
	DECLARE @AllowAccessionNumbers varchar(2000)
	DECLARE @TipColumn nvarchar(10) = 'AllowTime'	--配置项：提示信息获取字段名，AllowTime、MSGValue
	DECLARE @PrintStatusSynchronization int=0		--配置项；打印状态同步，0：关闭，1：开启。使用PatientID取片时，建议开启同步
	DECLARE @TimeLimit int = 0						--配置项；0，不启用时间限制；1，优先判断时间限制；2，当病人满足打印时，再判断是否满足时间限制
	DECLARE @TimePerference int = 0					--当@TimeLimit=1时，等于0，不满足时间限制要求，等于1，满足时间限制要求
	DECLARE @FilterColumn nvarchar(20) = ''
	DECLARE @Count AS int=0
	DECLARE @Tip nvarchar(2000) = ''
	DECLARE @AllowTime datetime
	DECLARE @yy varchar(10)=''
	DECLARE @mm varchar(10)=''
	DECLARE @dd varchar(10)=''
	DECLARE @hh varchar(10)=''
	DECLARE @mi varchar(10)=''

	BEGIN TRY
		BEGIN TRAN
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetPatientInfo:Success</OutputInfo>'
		SET @TerminalInfo = LTRIM(RTRIM(ISNULL(@TerminalInfo,'')))
		SET @CardType = LTRIM(RTRIM(ISNULL(@CardType,'')))
		SET @CardNumber = LTRIM(RTRIM(ISNULL(@CardNumber,'')))
		SET @ReturnType = UPPER(LTRIM(RTRIM(ISNULL(@ReturnType,''))))
		SET @FilterColumn=Replace(@CardType,'_','')

		IF(@TimeLimit=1 AND @PrintStatusSynchronization=0 AND @CardNumber<>'')
		BEGIN
			--有没有满足打印时间要求的检查
			SET @SQL=N'SELECT @iCount=COUNT(1) FROM AFP_View_StudyAllowPrintTime WHERE Allowtime<=GetDate() AND '+ @FilterColumn +'=@p'
			EXEC sp_executesql @SQL , N'@p AS varchar(100),@iCount AS int OUTPUT',@p = @CardNumber,@iCount=@Count OUTPUT
			
			IF (@Count=0)
			BEGIN
				SET @TimePerference=0
				--获取提示信息的数量
				SET @SQL=N'SELECT @iCount=COUNT(0) FROM (SELECT DISTINCT '+ @TipColumn +' FROM AFP_View_StudyAllowPrintTime WHERE '+ @FilterColumn +'=@p) T'
				EXEC sp_executesql @SQL , N'@p AS varchar(100),@iCount AS int OUTPUT',@p = @CardNumber,@iCount=@Count OUTPUT
				
				IF (@Count=0)
				BEGIN
					SET @MSGValue='没有您的胶片和报告，请联系管理员！'
				END
				ELSE IF (@Count=1)
				BEGIN
					--获取提示信息
					SET @SQL=N'SELECT @Time='+ @TipColumn +' FROM (SELECT DISTINCT '+ @TipColumn +' FROM AFP_View_StudyAllowPrintTime WHERE '+ @FilterColumn +'=@p) T'
					EXEC sp_executesql @SQL , N'@p AS varchar(100),@Time AS nvarchar(2000) OUTPUT',@p = @CardNumber,@Time=@Tip OUTPUT

					IF(@TipColumn='AllowTime')
					BEGIN
						SET @AllowTime=@Tip
						SET @yy = DATENAME(YY,@AllowTime)
						SET @mm = DATENAME(MM,@AllowTime)
						SET @dd = DATENAME(DD,@AllowTime)
						SET @hh = DATENAME(HH,@AllowTime)
						SET @mi = DATENAME(MI,@AllowTime)
						SET @MSGValue='请在'+@yy+'年'+@mm+'月'+@dd+'日'+@hh+'时'+@mi+'分后领取胶片和报告！'
					END
					ELSE IF(@TipColumn='MSGValue')
					BEGIN
						SET @MSGValue=@Tip
					END
				END
				ELSE IF (@Count>1)
				BEGIN
					SET @MSGValue='您的胶片和报告正在复核中！'
				END
			END
			ELSE
			BEGIN
				SET @TimePerference=1
			END
		END

		IF(@TimeLimit IN (0,2) OR @TimePerference=1 OR (@TimeLimit=1 AND @PrintStatusSynchronization=1))
		BEGIN
			IF (@CardType='PATIENT_ID' AND @CardNumber<>'')
			BEGIN
				SET @SQL=N'DECLARE @PatientID nvarchar(128)
				DECLARE @AccessionNumber nvarchar(128)
				DECLARE @FilmStoredFlag int
				DECLARE @ReportStoredFlag int
				DECLARE @FilmPrintFlag int
				DECLARE @ReportPrintFlag int
				DECLARE @PrintMode int
				DECLARE @AllowPrintFlag int
				DECLARE @MSGKey nvarchar(10)
				DECLARE @MSGValue nvarchar(200)
				DECLARE @Printing int
			
				SET @Printing=0
				SET @AllowCount=0
				SET @AccessionNumbers=''''
				SET @Key=''''
				SET @Value=''''
				SET @AllowKey=''''
				SET @AllowValue=''''
			
				DECLARE Patient CURSOR
				FOR SELECT PatientID,AccessionNumber FROM T_Integration_ExamInfo WHERE PatientID = @p
				OPEN Patient
				FETCH NEXT FROM Patient INTO @PatientID,@AccessionNumber
				WHILE (@@FETCH_STATUS = 0) 
				BEGIN
					IF (@Printing=0 AND @PatientID <> '''' AND @AccessionNumber <> '''')
					BEGIN
						EXEC sp_Integration_GetPrintStatusAndPrintMode @AccessionNumber,@FilmStoredFlag OUTPUT,@ReportStoredFlag OUTPUT,@FilmPrintFlag OUTPUT,@ReportPrintFlag OUTPUT,@PrintMode OUTPUT
					
						EXEC sp_Integration_GetAllowPrint @AccessionNumber,@FilmStoredFlag,@ReportStoredFlag,@FilmPrintFlag,@ReportPrintFlag,@PrintMode,
												@AllowPrintFlag OUTPUT,@MSGKey OUTPUT,@MSGValue OUTPUT

						IF (@FilmPrintFlag=3 OR @ReportPrintFlag=3)
						BEGIN
							SET @Allow = 0
							SET @AllowCount = 0
							SET @Printing = 1
							SET @Key=@MSGKey
							SET @Value=@MSGValue
							break
						END

						IF (@Printing=0)
						BEGIN
							IF (@Key='''')
							BEGIN
								SET @Key=@MSGKey
							END
							ELSE IF (CHARINDEX(@MSGKey,@Key,1)=0)
							BEGIN
								SET @Key=@Key +''^^''+@MSGKey
							END

							IF (@Value='''')
							BEGIN
								SET @Value=@MSGValue
							END
							ELSE IF (CHARINDEX(@MSGValue,@Value,1)=0)
							BEGIN
								SET @Value=@Value +''^^''+@MSGValue
							END

							IF (@AllowPrintFlag=1)
							BEGIN
								SET @Allow = 1
								SET @AllowCount = @AllowCount + 1

								IF (@AccessionNumbers='''')
								BEGIN
									SET @AccessionNumbers=@AccessionNumber
								END
								ELSE
								BEGIN
									SET @AccessionNumbers=@AccessionNumbers +'',''+@AccessionNumber
								END

								IF (@AllowKey='''')
								BEGIN
									SET @AllowKey=@MSGKey
								END
								ELSE IF (CHARINDEX(@MSGKey,@AllowKey,1)=0)
								BEGIN
									SET @AllowKey=@AllowKey +''^^''+@MSGKey
								END

								IF (@AllowValue='''')
								BEGIN
									SET @AllowValue=@MSGValue
								END
								ELSE IF (CHARINDEX(@MSGValue,@AllowValue,1)=0)
								BEGIN
									SET @AllowValue=@AllowValue +''^^''+@MSGValue
								END
							END
						END
					END
					FETCH NEXT FROM Patient INTO @PatientID,@AccessionNumber
				END
		
				CLOSE Patient
				DEALLOCATE Patient'
				EXEC sp_executesql @SQL, 
				N'@p AS varchar(100),@Allow AS int OUTPUT,@AllowCount AS int OUTPUT,
				@Key AS varchar(200) OUTPUT,@Value AS varchar(2000) OUTPUT,@AccessionNumbers AS varchar(2000) OUTPUT,
				@AllowKey AS varchar(200) OUTPUT,@AllowValue AS varchar(2000) OUTPUT',
				@p = @CardNumber,@Allow=@AllowPrint OUTPUT,@AllowCount=@AllowPrintCount OUTPUT,
				@Key=@MSGKey OUTPUT,@Value=@MSGValue OUTPUT,@AccessionNumbers=@AllowAccessionNumbers OUTPUT,
				@AllowKey=@MSGAllowKey OUTPUT,@AllowValue=@MSGAllowValue OUTPUT

				IF (@AllowPrintCount=0)
				BEGIN
					SELECT @MSGCount=COUNT(0) FROM Func_Integration_SplitString (@MSGValue,'^^')
					IF (@MSGCount>1)
					BEGIN
						SET @MSGKey = 'DDDDD'
						SET @MSGValue='您没有可打印的胶片和报告，请稍后再试！'
					END
				END
				ELSE IF (@AllowPrintCount>=1)
				BEGIN
					SELECT @MSGCount=COUNT(0) FROM Func_Integration_SplitString (@MSGAllowValue,'^^')
					IF (@MSGCount=1)
					BEGIN
						SET @MSGValue=@MSGAllowValue
					END
					IF (@MSGCount>1)
					BEGIN
						SET @MSGKey = 'EEEEE'
						SET @MSGValue='您有胶片或报告可打印，请稍等！'
					END
				END                        
			END
			ELSE IF (@CardType='ACCESSION_NUMBER' AND @CardNumber<>'')
			BEGIN
				EXEC sp_Integration_GetPrintStatusAndPrintMode @CardNumber,@FilmStoredFlag OUTPUT,@ReportStoredFlag OUTPUT,@FilmPrintFlag OUTPUT,@ReportPrintFlag OUTPUT,@PrintMode OUTPUT

				EXEC sp_Integration_GetAllowPrint @CardNumber,@FilmStoredFlag,@ReportStoredFlag,@FilmPrintFlag,@ReportPrintFlag,@PrintMode,
												@AllowPrint OUTPUT,@MSGKey OUTPUT,@MSGValue OUTPUT
				IF (@AllowPrint=1)
				BEGIN
					SET @AllowAccessionNumbers=@CardNumber
				END
			END
		END

		IF(@TimeLimit=1 AND @PrintStatusSynchronization=1 AND @CardNumber<>'')
		BEGIN
			--有没有满足打印时间要求的检查
			SET @SQL=N'SELECT @iCount=COUNT(1) FROM AFP_View_StudyAllowPrintTime WHERE PrintStatus=0 AND Allowtime<=GetDate() AND '+ @FilterColumn +'=@p'
			EXEC sp_executesql @SQL , N'@p AS varchar(100),@iCount AS int OUTPUT',@p = @CardNumber,@iCount=@Count OUTPUT
			
			IF (@Count=0)
			BEGIN
				SET @AllowPrint=0
				--获取提示信息的数量
				SET @SQL=N'SELECT @iCount=COUNT(0) FROM (SELECT DISTINCT '+ @TipColumn +' FROM AFP_View_StudyAllowPrintTime WHERE PrintStatus=0 AND '+ @FilterColumn +'=@p) T'
				EXEC sp_executesql @SQL , N'@p AS varchar(100),@iCount AS int OUTPUT',@p = @CardNumber,@iCount=@Count OUTPUT
				
				IF (@Count=0)
				BEGIN
					SET @MSGValue='没有您的胶片和报告，请联系管理员！'
				END
				ELSE IF (@Count=1)
				BEGIN
					--获取提示信息
					SET @SQL=N'SELECT @Time='+ @TipColumn +' FROM (SELECT DISTINCT '+ @TipColumn +' FROM AFP_View_StudyAllowPrintTime WHERE PrintStatus=0 AND '+ @FilterColumn +'=@p) T'
					EXEC sp_executesql @SQL , N'@p AS varchar(100),@Time AS nvarchar(2000) OUTPUT',@p = @CardNumber,@Time=@Tip OUTPUT
					
					IF(@TipColumn='AllowTime')
					BEGIN
						SET @AllowTime=@Tip
						SET @yy = DATENAME(YY,@AllowTime)
						SET @mm = DATENAME(MM,@AllowTime)
						SET @dd = DATENAME(DD,@AllowTime)
						SET @hh = DATENAME(HH,@AllowTime)
						SET @mi = DATENAME(MI,@AllowTime)
						SET @MSGValue='请在'+@yy+'年'+@mm+'月'+@dd+'日'+@hh+'时'+@mi+'分后领取胶片和报告！'
					END
					ELSE IF(@TipColumn='MSGValue')
					BEGIN
						SET @MSGValue=@Tip
					END
				END
				ELSE IF (@Count>1)
				BEGIN
					SET @MSGValue='您的胶片和报告正在复核中！'
				END
			END
		END
		
		IF(@TimeLimit=2 AND @AllowPrint=1)
		BEGIN
			--有没有满足打印时间要求的检查
			SET @SQL=N'SELECT @iCount=COUNT(1) FROM AFP_View_StudyAllowPrintTime 
			WHERE Allowtime<=GetDate() AND AccessionNumber IN (SELECT value FROM  Func_Integration_SplitString(@p,'',''))'
			EXEC sp_executesql @SQL , N'@p AS varchar(100),@iCount AS int OUTPUT',@p = @AllowAccessionNumbers,@iCount=@Count OUTPUT
			
			IF (@Count=0)
			BEGIN
				SET @AllowPrint=0
				--获取提示信息的数量
				SET @SQL=N'SELECT @iCount=COUNT(0) FROM (SELECT DISTINCT '+ @TipColumn +' FROM AFP_View_StudyAllowPrintTime 
				        WHERE AccessionNumber IN (SELECT value FROM  Func_Integration_SplitString(@p,'',''))) T'
				EXEC sp_executesql @SQL , N'@p AS varchar(100),@iCount AS int OUTPUT',@p = @AllowAccessionNumbers,@iCount=@Count OUTPUT
				
				IF (@Count=1)
				BEGIN
					--获取提示信息
					SET @SQL=N'SELECT @Time='+ @TipColumn +' FROM (SELECT DISTINCT '+ @TipColumn +' FROM AFP_View_StudyAllowPrintTime 
				        WHERE AccessionNumber IN (SELECT value FROM  Func_Integration_SplitString(@p,'',''))) T'
					EXEC sp_executesql @SQL , N'@p AS varchar(100),@Time AS nvarchar(2000) OUTPUT',@p = @AllowAccessionNumbers,@Time=@Tip OUTPUT

					IF(@TipColumn='AllowTime')
					BEGIN
						SET @AllowTime=@Tip
						SET @yy = DATENAME(YY,@AllowTime)
						SET @mm = DATENAME(MM,@AllowTime)
						SET @dd = DATENAME(DD,@AllowTime)
						SET @hh = DATENAME(HH,@AllowTime)
						SET @mi = DATENAME(MI,@AllowTime)
						SET @MSGValue='请在'+@yy+'年'+@mm+'月'+@dd+'日'+@hh+'时'+@mi+'分后领取胶片和报告！'
					END
					ELSE IF(@TipColumn='MSGValue')
					BEGIN
						SET @MSGValue=@Tip
					END
				END
				ELSE
				BEGIN
					SET @MSGValue='您的胶片和报告正在复核中！'
				END
			END
		END

		IF (@AllowPrint=0)
		BEGIN
			IF(@MSGValue='')
			BEGIN
				SET @MSGValue='没有您的胶片和报告，请联系管理员！'
			END

			SELECT '' AS [ReturnValue]
			,@MSGValue AS [Message]
			,@AllowPrint AS AllowPrint
			,'' AS [PatientID]
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
			
		END
		ELSE IF (@AllowPrint=1)
		BEGIN
			IF(@CardNumber<>'')
			BEGIN
				SET @SQL=N'SELECT DISTINCT [PatientID]
					,[AccessionNumber]
					,[FilmStoredFlag]
					,[ReportStoredFlag]
					,[FilmPrintFlag]
					,[ReportPrintFlag]
					,(CASE
						WHEN @Type=''PATIENT_ID'' THEN [PatientID]
						WHEN @Type=''ACCESSION_NUMBER'' THEN [AccessionNumber]
						WHEN @Type=''STUDY_INSTANCE_UID'' THEN [StudyInstanceUID]
						ELSE '''' END) AS [ReturnValue]
					,@MSG AS [Message]
					,@Allow AS [AllowPrint]
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
					,[FilmStoredDT]
					,[ReportStoredDT]
					,[NotifyReportFlag]
					,[NotifyReportDT]
					,[SetPrintModeFlag]
					,[SetPrintModeDT]
					,[FilmPrintDoctor]
					,[FilmPrintDT]
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
				FROM [T_Integration_ExamInfo]'

				IF (@CardType='PATIENT_ID'AND @AllowPrintCount=1)
				BEGIN
					SET @SQL = @SQL + N' WHERE [AccessionNumber]=@p'
				END
				ELSE IF (@CardType='PATIENT_ID'AND @AllowPrintCount>1)
				BEGIN
					SET @SQL = @SQL + N' WHERE [AccessionNumber] IN (SELECT value FROM  Func_Integration_SplitString(@p,'',''))'
				END
				ELSE IF (@CardType='ACCESSION_NUMBER')
				BEGIN
					SET @SQL = @SQL + N' WHERE [AccessionNumber]=@p'
				END

				EXEC sp_executesql @SQL , N'@p AS varchar(100),@Type AS varchar(128),@MSG AS varchar(max),@Allow AS int',
				@p = @AllowAccessionNumbers,@Type=@ReturnType,@MSG=@MSGValue,@Allow=@AllowPrint
			END
		END

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		SET @AllowPrint=0
		SET @MSGValue='系统错误，请重试！'

		SELECT '' AS [ReturnValue]
		,@MSGValue AS [Message]
		,@AllowPrint AS AllowPrint
		,'' AS [PatientID]
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

		SET @OutputInfo = '<OutputInfo>sp_Integration_GetPatientInfo:Error</OutputInfo>'
	END CATCH
END
