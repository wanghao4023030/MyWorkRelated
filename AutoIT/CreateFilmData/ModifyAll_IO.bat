
set date=0720
set time=1000
:loop

set datetime=%date%%time%
set filename=IOnew_%datetime%.dcm

:set SOPInstanceID=1.2.840.113619.2.30.1.1762369984.1613.%datetime%
set StudyInstanceUID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.%datetime%2
set SeriesInstanceUID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.%datetime%2
set SOPInstanceID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.%datetime%2

copy IO_new.dcm %filename%

: StudyDate
dcmodify -m "(0008,0020)=2016%date%" %filename%

: StudyTime
dcmodify -m "(0008,0030)=%time%30" %filename%

: Patient ID
dcmodify -m "(0010,0020)=lily%datetime%" %filename%


: Patient Name
dcmodify -m "(0010,0010)=name%datetime%" %filename%


: StudyInstanceUID
dcmodify -m "(0020,000D)=%StudyInstanceUID%" %filename%

: SeriesInstanceUID
dcmodify -m "(0020,000E)=%SeriesInstanceUID%" %filename%

: SOPInstanceUID
dcmodify -m "(0008,0018)=%SOPInstanceID%" %filename%

: AccNo
dcmodify -m "(0008,0050)=acc%datetime%" %filename%

DEL %filename%.bak

move /Y %filename% .\image

:set /a number+=1
:If %number% GTR %total% GOTO :EOF
:GOTO :loop


