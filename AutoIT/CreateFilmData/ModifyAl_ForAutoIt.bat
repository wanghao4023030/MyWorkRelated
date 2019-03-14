
set date=strDate
set time=strTime

:loop

set filename=CRnew_%date%%time%.dcm

set StudyInstanceUID=strUID
set SeriesInstanceUID=strUID
set SOPInstanceID=strUID

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

: PatientName
dcmodify -m "(0010,0010)=N%date%%time%" %filename%

: Patientsex
dcmodify -m "(0010,0040)=strGrender" %filename%

: Modality
dcmodify -m "(0008,0060)=strModality" %filename%

: Modality
dcmodify -m "(0018,0015)=strBodayPart" %filename%

DEL %filename%.bak
move /Y %filename% "E:\GX Platform\Inbox"

:set /a number+=1
:If %number% GTR %total% GOTO :EOF
:GOTO :loop

