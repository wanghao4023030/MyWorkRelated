:loop

set filename=strfilename.dcm

copy CR_new.dcm %filename%

: StudyDate
dcmodify -m "(0008,0020)=strDate" %filename%

: StudyTime
dcmodify -m "(0008,0030)=strtime" %filename%

: Patient ID
dcmodify -m "(0010,0020)=strPID" %filename%

: StudyInstanceUID
dcmodify -m "(0020,000D)=strStudyInstanceUID" %filename%

: SeriesInstanceUID
dcmodify -m "(0020,000E)=strSeriesInstanceUID" %filename%

: SOPInstanceUID
dcmodify -m "(0008,0018)=strSOPInstanceID" %filename%

: AccNo
dcmodify -m "(0008,0050)=strAccNo" %filename%

: PatientName
dcmodify -m "(0010,0010)=strPatientName" %filename%

: Patientsex
dcmodify -m "(0010,0040)=strGrender" %filename%

: Modality
dcmodify -m "(0008,0060)=strModality" %filename%

: Modality
dcmodify -m "(0018,0015)=strBodayPart" %filename%

DEL %filename%.bak
move /Y %filename% "strDestFolder"

:set /a number+=1
:If %number% GTR %total% GOTO :EOF
:GOTO :loop

