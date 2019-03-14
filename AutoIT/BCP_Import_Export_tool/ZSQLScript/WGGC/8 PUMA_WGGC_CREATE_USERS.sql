USE WGGC
GO

DECLARE @LOOPNUMBER INT = 1;
DECLARE @UserDBID     INT
DECLARE @UserID     VARCHAR(100)
DECLARE @UserName     VARCHAR(100)
DECLARE @Password     VARCHAR(100)
DECLARE @FullName     VARCHAR(100)
DECLARE @LocalFullName     VARCHAR(100)
DECLARE @Title     VARCHAR(100)
DECLARE @Department     VARCHAR(100)
DECLARE @UserRole     VARCHAR(100)
DECLARE @IsFirstLogin     VARCHAR(100)
DECLARE @PwdNeverExpire     VARCHAR(100)
DECLARE @PwdLastModifyTime     VARCHAR(100)
DECLARE @Modality     VARCHAR(100)


WHILE @LOOPNUMBER <= 10
BEGIN

SET @UserDBID     = (SELECT MAX(UserDBID) FROM WGGC.DBO.Users) 
SET @UserDBID = CAST(@UserDBID AS INT) + 1
SET @UserID     = 'TEST' + CAST(@LOOPNUMBER AS VARCHAR(10))
SET @UserName     = @UserID 
SET @Password     = '49CE5FB6D05148ACB66A'
SET @FullName     = ''
SET @LocalFullName     = ''
SET @Title     = ''
SET @Department     =''
SET @UserRole     = 'Administrator,Radiologist,Technician,Receptionist'
SET @IsFirstLogin     = 0
SET @PwdNeverExpire     = 1
SET @PwdLastModifyTime     = GETDATE()
SET @Modality     = NULL


INSERT WGGC.DBO.Users
( UserID,UserName, Password, FullName, LocalFullName, Title,Department, UserRole, IsFirstLogin, PwdNeverExpire, PwdLastModifyTime, Modality)
VALUES
(@UserID,@UserName, @Password, @FullName, @LocalFullName, @Title,@Department, @UserRole, @IsFirstLogin, @PwdNeverExpire, @PwdLastModifyTime, @Modality)


SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;