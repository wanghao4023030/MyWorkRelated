USE [WGGC]
GO
/****** Object:  UserDefinedFunction [dbo].[Func_Integration_SplitString]    Script Date: 5/18/2017 4:10:19 PM ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('Func_Integration_SplitString') and xtype='TF') 
BEGIN  
	DROP Function Func_Integration_SplitString
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Shiye Yang>
-- Create date: <2017-04-13>
-- Alter date: <2017-04-13>
-- Description: receive string,return table
-- =============================================
CREATE FUNCTION [dbo].[Func_Integration_SplitString](@str nvarchar(4000),@separtor varchar(10))  
  RETURNS @temp TABLE(value nvarchar(40))  
AS    
BEGIN  
	DECLARE @i int 
	 
	SET  @str=rtrim(ltrim(@str))  
	SET  @i=charindex(@separtor,@str)  
   
	WHILE   @i>=1  
	BEGIN  
		INSERT @temp VALUES(left(@str,@i-1))  
		set  @str=substring(@str,@i+1,len(@str)-@i)  
		set  @i=charindex(@separtor,@str)  
	END  
    
	IF @str<>''    
	INSERT @temp VALUES(@str)
	  
	RETURN    
END