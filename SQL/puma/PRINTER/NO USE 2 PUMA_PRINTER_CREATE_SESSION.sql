USE Printer
GO

DECLARE @LOOPNUMBER INT = 1
DECLARE @SessionInstanceUID VARCHAR(100)
DECLARE @CallingAE          VARCHAR(100)
DECLARE @CallingIP          VARCHAR(100)
DECLARE @CalledAE           VARCHAR(100)
DECLARE @PortNo             VARCHAR(100)
DECLARE @DATEForInstanceUID VARCHAR(100)
DECLARE @NUMBER varchar(100)

WHILE @LOOPNUMBER <= 9600000
BEGIN

SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(CONVERT(varchar,GETDATE(),121),':',''),'-',''),' ','')
SET @SessionInstanceUID     = (select top 1 [SessionInstanceUID] from printer.dbo.DeliveryJob order by newid() )

SET @NUMBER = convert(varchar,@LOOPNUMBER%10);

SET @CallingAE = 'AE12' + @NUMBER
SET @CallingIP          = '10.184.129.12' + @NUMBER
SET @CalledAE           = 'ImageSuite' + @NUMBER
SET @PortNo             = '7' + @NUMBER

INSERT   [Printer].[dbo].[Session](
	   [SessionInstanceUID],[CallingAE],[CallingIP],[CalledAE],[PortNo]
	  )
	  VALUES(
	 @SessionInstanceUID,@CallingAE,@CallingIP,@CalledAE,@PortNo
	  );


SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;

