set number=1
set total=10
set date=0720
set time=1030
set datetime=%date%%time%

:loop

Echo %number%
set filename=CRnew_%number%.dcm
Echo %filename%

set StudyInstanceUID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.%number%
set SeriesInstanceUID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.%number%
set SOPInstanceID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.%number%

copy CR_new.dcm %filename%

: StudyDate
dcmodify -m "(0008,0020)=2017%date%" %filename%

: StudyTime
dcmodify -m "(0008,0030)=%time%30" %filename%

: Patient ID
dcmodify -m "(0010,0020)=P%datetime%" %filename%

: StudyInstanceUID
dcmodify -m "(0020,000D)=%StudyInstanceUID%" %filename%

: SeriesInstanceUID
dcmodify -m "(0020,000E)=%SeriesInstanceUID%" %filename%

: SOPInstanceUID
dcmodify -m "(0008,0018)=%SOPInstanceID%" %filename%

: AccNo
dcmodify -m "(0008,0050)=A%datetime%" %filename%

DEL %filename%.bak
move /Y %filename% .\image

set /a number+=1
If %number% GTR %total% GOTO :EOF
GOTO :loop

