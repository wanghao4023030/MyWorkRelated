You can use the tool to call the webservice NotifyExamInfo and notifyReportFile to create the patient and report.
Please config the integaration service to local database. The wggc.dbo.vi_KIOSK_ExamInfo_Order will instead of the RIS table.
All patient data will query from this table.
Please notice the column map information in integration table:
Table--> XML
PDFURL-->ReportPath
Modality-->ModalityName
ModalityName-->ModalityType
Optionl0-->ColorType
Optionl1-->PaperSize
Optionl2-->PaperType
Optionl3-->CardNumber
