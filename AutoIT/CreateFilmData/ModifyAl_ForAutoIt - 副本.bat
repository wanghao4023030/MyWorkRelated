
set date=strdate
set time=strTime

:loop

set filename=CRnew_%date%%time%.dcm

set StudyInstanceUID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.%date%%time%
set SeriesInstanceUID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.%date%%time%
set SOPInstanceID=2.16.840.1.113662.5.8796818449476.121423489.1.1.3101.%date%%time%

copy CR_new.dcm %filename%

: StudyDate
dcmodify -m "(0008,0020)=%date%" %filename%

: StudyTime
dcmodify -m "(0008,0030)=%time%" %filename%

: Patient ID
dcmodify -m "(0010,0020)=P%date%%time%" %filename%

: StudyInstanceUID
dcmodify -m "(0020,000D)=%StudyInstanceUID%" %filename%

: SeriesInstanceUID
dcmodify -m "(0020,000E)=%SeriesInstanceUID%" %filename%

: SOPInstanceUID
dcmodify -m "(0008,0018)=%SOPInstanceID%" %filename%

: AccNo
dcmodify -m "(0008,0050)=A%date%%time%" %filename%

DEL %filename%.bak
move /Y %filename% .\image

:set /a number+=1
:If %number% GTR %total% GOTO :EOF
:GOTO :loop

