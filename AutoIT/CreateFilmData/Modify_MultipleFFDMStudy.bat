set number=1
set total=25


set date=0720
set time=1630

set datetime=%date%%time%


:loop

Echo %number%
set filename=%number%.dcm
Echo %filename%
set SopInstanceID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.072002%number%
set StudyInstanceUID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.07202%number%
set SeriesInstanceUID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.072002%number%
Echo %InstanceID%
copy FFDM_new.dcm %filename%

:sopInstanceID
dcmodify -m "(0008,0018)=%SopInstanceID%" %filename%

: StudyInstanceUID
dcmodify -m "(0020,000D)=%StudyInstanceUID%" %filename%

: SeriesInstanceUID
dcmodify -m "(0020,000E)=%SeriesInstanceUID%" %filename%

: Patient ID
dcmodify -m "(0010,0020)=lily%datetime%" %filename%

: AccNo
dcmodify -m "(0008,0050)=acc%datetime%" %filename%

: StudyDate
dcmodify -m "(0008,0020)=2016%date%" %filename%

: StudyTime
dcmodify -m "(0008,0030)=%time%30" %filename%

DEL %filename%.bak
move /Y %filename% .\testfiles
set /a number+=1
If %number% GTR %total% GOTO :EOF
GOTO :loop
