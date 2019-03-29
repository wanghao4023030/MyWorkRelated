USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetAllowPrint]    Script Date: 5/18/2017 3:21:50 PM ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_GetAllowPrint') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_GetAllowPrint
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:<Shiye Yang>
-- Create date:<2017-05-18>
-- Alter date:<2017-08-25>
-- Description:Get Film And Report Status,Get Print Mode.
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_GetAllowPrint]
	@AccessionNumber nvarchar(128),
	@FilmStoredFlag int,
	@ReportStoredFlag int,
	@FilmPrintFlag int,
	@ReportPrintFlag int,
	@PrintMode int,
	@AllowPrint int output,
	@MSGKey nvarchar(10) output,
	@MSGValue nvarchar(200) output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL NVARCHAR(3000) = ''
	DECLARE @StudyPrintStatus int = 1		--0：可以打印，或者有打印模式但尚未准备好的数据；1：打印中，已打印,或者无打印模式的数据

	SET @AllowPrint = 0
	SET @MSGKey = ''
	SET @MSGValue = ''

	--@FilmStoredFlag(0，9),@ReportStoredFlag(0，9)；0，未归档；9，已归档
	--@FilmPrintFlag（0，1，2，3）,@ReportPrintFlag（0，1，2，3）；0，未打印；1，已打印；2，不打印；3，打印中

	IF (@PrintMode=0)
	BEGIN
		IF(@FilmStoredFlag=0 AND @ReportStoredFlag=0)
		BEGIN
			SET @MSGValue='您的胶片和报告尚未准备好，请稍后再试！'
			SET @StudyPrintStatus = 0
		END
		ELSE IF(@FilmStoredFlag=9 AND @ReportStoredFlag=0)
		BEGIN
			SET @MSGValue='您的胶片已经完成，但报告尚未准备好，请稍后再试！'
			SET @StudyPrintStatus = 0
		END
		ELSE IF(@FilmStoredFlag=0 AND @ReportStoredFlag=9)
		BEGIN
			SET @MSGValue='您的报告已经完成，但胶片尚未准备好，请稍后再试！'
			SET @StudyPrintStatus = 0
		END
		ELSE IF(@FilmPrintFlag=3 OR @ReportPrintFlag=3)
		BEGIN
			SET @MSGValue='您的胶片和报告正在打印中！'
			SET @StudyPrintStatus = 1
		END
		ELSE IF((@FilmPrintFlag=1 OR @FilmPrintFlag=2) AND (@ReportPrintFlag=1 OR @ReportPrintFlag=2))
		BEGIN
			SET @MSGValue='您的胶片和报告已经打印！'
			SET @StudyPrintStatus = 1
		END
		ELSE IF(@FilmPrintFlag =0 AND @ReportPrintFlag =0)
		BEGIN
			SET @MSGValue='您有胶片和报告可打印，请稍等！'
			SET @StudyPrintStatus = 0
			SET @AllowPrint = 1
		END
		ELSE IF((@FilmPrintFlag=1 OR @FilmPrintFlag=2) AND @ReportPrintFlag=0)
		BEGIN
			SET @MSGValue='您的胶片和报告已经准备好，但胶片已经打印。请稍等！'
			SET @StudyPrintStatus = 0
			SET @AllowPrint = 1
		END
		ELSE IF(@FilmPrintFlag=0 AND (@ReportPrintFlag=1 OR @ReportPrintFlag=2))
		BEGIN
			SET @MSGValue='您的胶片和报告已经准备好，但报告已经打印。请稍等！'
			SET @StudyPrintStatus = 0
			SET @AllowPrint = 1
		END
	END
	ELSE IF (@PrintMode=1)
	BEGIN
		IF(@FilmStoredFlag=0 AND @ReportStoredFlag=9)
		BEGIN
			SET @MSGValue='您的胶片尚未准备好，请稍后再试！'
			SET @StudyPrintStatus = 1
		END
		ELSE IF(@FilmStoredFlag=0)
		BEGIN
			SET @MSGValue='您的胶片尚未准备好，请稍后再试！'
			SET @StudyPrintStatus = 0
		END
		ELSE IF(@FilmPrintFlag=3)
		BEGIN
			SET @MSGValue='您的胶片正在打印中！'
			SET @StudyPrintStatus = 1
		END
		ELSE IF(@FilmPrintFlag=1 OR @FilmPrintFlag=2)
		BEGIN
			SET @MSGValue='您的胶片已经打印！'
			SET @StudyPrintStatus=1
		END
		ELSE IF(@FilmPrintFlag =0)
		BEGIN
			SET @MSGValue='您有胶片可打印，请稍等！'
			SET @StudyPrintStatus = 0
			SET @AllowPrint = 1
		END
	END
	ELSE IF (@PrintMode=2)
	BEGIN
		IF(@ReportStoredFlag=0 AND @FilmStoredFlag=9)
		BEGIN
			SET @MSGValue='您的报告尚未准备好，请稍后再试！'
			SET @StudyPrintStatus = 1
		END
		ELSE IF(@ReportStoredFlag=0)
		BEGIN
			SET @MSGValue='您的报告尚未准备好，请稍后再试！'
			SET @StudyPrintStatus = 0
		END
		ELSE IF(@ReportPrintFlag=3)
		BEGIN
			SET @MSGValue='您的报告正在打印中！'
			SET @StudyPrintStatus = 1
		END
		ELSE IF(@ReportPrintFlag=1 OR @ReportPrintFlag=2)
		BEGIN
			SET @MSGValue='您的报告已经打印！'
			SET @StudyPrintStatus=1
		END
		ELSE IF(@ReportPrintFlag =0)
		BEGIN
			SET @MSGValue='您有报告可打印，请稍等！'
			SET @StudyPrintStatus = 0
			SET @AllowPrint = 1
		END
	END
	ELSE IF (@PrintMode=3)
	BEGIN
		IF(@FilmStoredFlag=0 AND @ReportStoredFlag=0)
		BEGIN
			SET @MSGValue='您的胶片报告尚未准备好，请稍后再试！'
			SET @StudyPrintStatus = 0
		END
		ELSE IF((@FilmStoredFlag=9 AND @FilmPrintFlag=3) OR (@ReportStoredFlag=9 AND @ReportPrintFlag=3))
		BEGIN
			SET @MSGValue='您的胶片或报告正在打印中！'
			SET @StudyPrintStatus = 1
		END
		ELSE IF((@FilmStoredFlag=9 AND (@FilmPrintFlag=1 OR @FilmPrintFlag=2)) AND (@ReportStoredFlag=9 AND (@ReportPrintFlag=1 OR @ReportPrintFlag=2)))
		BEGIN
			SET @MSGValue='您的胶片报告已经打印！'
			SET @StudyPrintStatus=1
		END
		ELSE IF(@ReportStoredFlag=0 AND (@FilmStoredFlag=9 AND (@FilmPrintFlag=1 OR @FilmPrintFlag=2)))
		BEGIN
			SET @MSGValue='您的胶片已经打印，报告尚未准备好，请稍后再试！'
			SET @StudyPrintStatus = 0
		END
		ELSE IF(@FilmStoredFlag=0 AND (@ReportStoredFlag=9 AND (@ReportPrintFlag=1 OR @ReportPrintFlag=2)))
		BEGIN
			SET @MSGValue='您的报告已经打印，胶片尚未准备好，请稍后再试！'
			SET @StudyPrintStatus = 0
		END
		ELSE IF((@FilmStoredFlag=9 AND @FilmPrintFlag =0) OR (@ReportStoredFlag=9 AND @ReportPrintFlag =0))
		BEGIN
			SET @MSGValue='您有胶片或报告可打印，请稍等！'
			SET @StudyPrintStatus = 0
			SET @AllowPrint = 1
		END
	END
	ELSE
	BEGIN
		SET @StudyPrintStatus = 1
	END

	SET @SQL=N'UPDATE T_Integration_ExamInfo SET PrintStatus=@Status WHERE AccessionNumber=@p'
	EXEC sp_executesql @SQL , N'@p AS varchar(128),@Status AS int',@p = @AccessionNumber,@Status =@StudyPrintStatus
END
