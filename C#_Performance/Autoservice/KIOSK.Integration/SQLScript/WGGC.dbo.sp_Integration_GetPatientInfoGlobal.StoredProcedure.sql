USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetPatientInfoGlobal]    Script Date: 08/09/2017 13:06:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*
declare @TerminalInfo nvarchar(128) = '::1'
declare	@Modality nvarchar(128) ='CT,MR'
declare	@CardNumber nvarchar(128) ='GYCT201508040067'
declare	@PrintLevel nvarchar(64) =''
declare	@OutputInfo xml =''
exec dbo.sp_Integration_GetPatientInfoGlobal @TerminalInfo,@Modality,@CardNumber,@PrintLevel output,@OutputInfo output
select @PrintLevel,@OutputInfo
*/

CREATE PROCEDURE [dbo].[sp_Integration_GetPatientInfoGlobal] 
	-- Add the parameters for the stored procedure here
	@TerminalInfo nvarchar(128),
	@Modality	nvarchar(128),
	@Cardnumber		nvarchar(128),
	@PrintLevel		nvarchar(64) output,
	@OutputInfo		xml output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @Modality = ISNULL(LTRIM(RTRIM(@Modality)), '')
	SET @CardNumber = ISNULL(LTRIM(RTRIM(@CardNumber)), '')
	
	DECLARE @PateintID nvarchar(128) = ''
	DECLARE @AccessionNumber nvarchar(128) = ''
	DECLARE @TermianlInfo nvarchar(128) = ''
	DECLARE @CardType	nvarchar(128) = ''
	DECLARE @ReturnType nvarchar(128) = ''
	DECLARE @Where	nvarchar(max) = ''
	DECLARE @SQL nvarchar(max) = ''
	DECLARE @PreKey nvarchar(32) = ''
	DECLARE @CardNumberEx nvarchar(128) = ''
	DECLARE @Count	int = 0
	
	IF (LEN(@Modality) > 0)
	BEGIN
	   SET @Modality = REPLACE(@Modality, ',', ''',''')
		--CREATE TABLE #PREMODALITY(
		--	FPreKey	nvarchar(32) NULL
		--)
		
		--SET @Modality = REPLACE(@Modality,',',''',''')
		--SET @WHERE = @WHERE+' AND ([Key] IN (''' + @Modality + '''))'
		--SET @SQL = 'INSERT INTO #PREMODALITY(FPreKey) SELECT [Value] FROM T_Integration_Dictionary WHERE 1 = 1 AND [TagType] = ''Pre'' ' + @WHERE
		--EXEC (@SQL)
		
		--DECLARE CurPre CURSOR
		--FOR SELECT FPreKey FROM #PREMODALITY
		--OPEN CurPre
		--FETCH NEXT FROM CurPre INTO @PreKey
		--WHILE (@@FETCH_STATUS = 0)
		--BEGIN
		--	IF ('' = @CardNumberEx)
		--	BEGIN
		--		SET @CardNumberEx = @PreKey + @CardNumber
		--	END
		--	ELSE BEGIN
		--		SET @CardNumberEx = @CardNumberEx + ',' + @PreKey + @CardNumber
		--	END
		--	FETCH NEXT FROM CurPre INTO @PreKey
		--END
		
		--CLOSE CurPre
		--DEALLOCATE CurPre
		--DROP TABLE #PREMODALITY
	END	
	--ELSE BEGIN
	--	SET @CardNumberEx = REPLACE(@CardNumber,',',''',''')
	--END
		
	-- 后续的数据查询我们目前只能假设满足条件的只有一条记录
	--SET @CardNumber = REPLACE(@CardNumberEx,',',''',''')
	SET @WHERE = ' AND ([AccessionNumber] IN (''' + @CardNumber + ''') OR [PatientID] IN (''' + @CardNumber + ''')) AND Modality IN (''' +@Modality+ ''')'
	SET @SQL = 'SELECT @a = COUNT(0) FROM T_Integration_ExamInfo WHERE 1 = 1 ' + @WHERE
	EXEC sp_executesql @SQL,N'@a int output',@Count output
	IF (0 < @Count)
	BEGIN
		SET @SQL = 'SELECT @CardType = Optional0,@PrintLevel = Value FROM T_Integration_Dictionary 
				WHERE 1 = 1 AND TagType = ''PrintLevel''
				AND [KEY] IN 
					(SELECT TOP 1 Modality FROM T_Integration_ExamInfo 
					WHERE 1 = 1 ' + @WHERE + ')'
		EXEC sp_executesql @SQL,N'@CardType nvarchar(128) output,@PrintLevel nvarchar(128) output', @CardType output,@PrintLevel output
		
		
	END
	ELSE BEGIN
		SELECT @CardType = [Optional0],@PrintLevel = [Value] FROM T_Integration_Dictionary WHERE 1 = 1 AND TagType = 'PrintLevel' AND [Key] = 'Other'
	END
	
	EXEC sp_Integration_GetPatientInfo @TerminalInfo,@CardType,@CardNumber,@PrintLevel,@OutputInfo output

END
