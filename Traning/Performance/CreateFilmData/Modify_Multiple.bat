set number=1
set total=1999


set date=0708
set time=1300
set datetime=%date%%time%


:loop

Echo %number%
set filename=%number%.dcm
Echo %filename%
set InstanceID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.08%number%
Echo %InstanceID%
copy CT_new.dcm %filename%

:sopInstanceID
dcmodify -m "(0008,0018)=%InstanceID%" %filename%

: StudyDate
dcmodify -m "(0008,0020)=2016%date%" %filename%

: StudyTime
dcmodify -m "(0008,0030)=%time%30" %filename%

DEL %filename%.bak
move /Y %filename% .\testfiles
set /a number+=1
If %number% GTR %total% GOTO :EOF
GOTO :loop
