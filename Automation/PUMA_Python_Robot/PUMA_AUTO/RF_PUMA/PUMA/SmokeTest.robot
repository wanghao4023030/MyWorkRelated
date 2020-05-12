*** Settings ***
Library           JSONLibrary
Library           Collections
Library           PUMA_ParameterAndSettings
Library           PUMA_DatabaseLibrary
Library           PUMA_FilmLibrary
Library           PUMA_HoldTimeLibrary
Library           PUMA_PatientLibrary
Library           PUMA_PlatformLibrary
Library           PUMA_PrintModeLibrary
Library           PUMA_ReportLibrary
Library           PUMA_TerminalLibrary
Library           PUMA_ServerLibrary

*** Test Cases ***
SmokeTest_001_Core_4170_01.01.01 OCR Image process failed(9).
    [Tags]    Smoke
    log    Step1 \nDescription:\n Create a patient in RIS or local table in PS.\nExpected:\n The patient can create successfully.
    ${patientinfo} =    Patient Create Randomly
    ${json_object} =    Convert String to JSON    ${patientinfo}
    ${status} =    Get Value From Json    ${json_object}    Status
    ${patientID} =    Get Value From Json    ${json_object}    PatientID
    ${Accessionnumber} =    Get Value From Json    ${json_object}    AccessionNumber
    Should Be True    ${status}[0]== True    The patient Create successfully.
    log    Step2 \n Description:\n1.Prepare a DICOM file whose patientid and accession number is same as that in step1.\n 2.The film is configured in OCR config tool in PS include PID&ACCN, but not ROI rule.\n 3.The grammar configuration should meet the DICOM file that means the film will not recognize successfully.\n Expected: \n The preparation can execute successfully.
    log    Step3\n Description:\n 1. Delete the patient information from RIS or local table in step1. \nExpected:\n The patient can delete successfully.
    ${delete_result} =    Patient Delete By Pid Accn    ${patientID}[0]    ${Accessionnumber}[0]
    Should Be True    ${delete_result} == True    The patient delete successfully.
    log    Step 4 \n Description:\n 1. Print the DICOM file(film) to PS. \nExpected:\n The DICOM file(film) can print to PS successfully.
    ${Print_res}    Film Create Film With Sample    ${patientID}[0]    ${Accessionnumber}[0]
    ${Print_Res_Json}=    Convert String to JSON    ${Print_res}
    ${Print_Result}=    Get Value From Json    ${Print_Res_Json}    Status
    Should Not Be Empty    ${Print_Result}    Film print to PS successfully.
    log    Step 5\n Description:\n 1. Wait the OCR process finished. The default time is '600'. \n2. Check the jobstatus in printer.dbo.deliveryjob table.\nNote: query the records with filmsessionlabel. \ \ \nExpected: \nThe value should be 9 means grammar configured but identify failed.
    ${Job_status} =    Get Value From Json    ${Print_Res_Json}    DeliveryJob_status
    ${Job_status} =    Convert To String    ${Job_status}[0]
    Should Be Equal As Strings    ${Job_status}    9    The film`s jobstatus in printer.dbo.DeliveryJob is 9.
    log    Step 6:\nDescription\n1. Query the records in wggc.dbo.afp_filminfo with patient id and accession number.\nExpected:\n There is no record insert into this table.
    ${Archive_Filminfo_Table_Result} =    Film Check Archive In Filminfo Table
    Should Be True    ${Archive_Filminfo_Table_Result} == False    There is no record insert into wggc.dbo.afp_filminfo table.
    log    Step 7:\nDescription:\n1. Query the records in wggc.dbo.afp_examinfo with patient id and accession number. \nExpected: \nThere is no record insert into this table.
    ${Archived_Examinfo_Table_result} =    Film Check Archive In Examinfo Table
    Should Be True    ${Archived_Examinfo_Table_result} == False    There is no record insert into wggc.dbo.afp_examinfo table.

SmokeTest_002_Core_4172_01.01.02 OCR Image process success(2).
    [Tags]    Smoke
    log    Step 1 \n Description:\n Create a patient in RIS or local table in PS.\nExpected:\n The patient can create successfully.
    ${patientinfo} =    Patient Create Randomly
    ${json_object} =    Convert String to JSON    ${patientinfo}
    ${status} =    Get Value From Json    ${json_object}    Status
    ${patientID} =    Get Value From Json    ${json_object}    PatientID
    ${Accessionnumber} =    Get Value From Json    ${json_object}    AccessionNumber
    Should Be True    ${status}[0] == True    The patient Create successfully.
    log    Step 2 \n Description:\n1.Prepare a DICOM file whose patientid and accession number is same as that in step1.\n 2.The film is configured in OCR config tool in PS include PID&ACCN, but not ROI rule.\n 3.The grammar configuration should meet the DICOM file that means the film will not recognize successfully.\n Expected: \n The preparation can execute successfully.
    log    Step 3 \n Description:\n 1. Print the DICOM file(film) to PS. \nExpected:\n The DICOM file(film) can print to PS successfully.
    ${Print_res}    Film Create Film With Sample    ${patientID}[0]    ${Accessionnumber}[0]
    ${Print_Res_Json}=    Convert String to JSON    ${Print_res}
    ${Print_Result}=    Get Value From Json    ${Print_Res_Json}    Status
    Should Not Be Empty    ${Print_Result}    Film print to PS successfully.
    log    Step 4\n Description:\n 1. Wait the OCR process finished. The default time is '600'. \n2. Check the jobstatus in printer.dbo.deliveryjob table.\nNote: query the records with filmsessionlabel. \ \ \nExpected: \nThe value should be 2 means have condifuration but indentfy successfully.
    ${Job_status} =    Get Value From Json    ${Print_Res_Json}    DeliveryJob_status
    ${Job_status} =    Convert To String    ${Job_status}[0]
    Should Be Equal As Strings    ${Job_status}    2    The film`s jobstatus in printer.dbo.DeliveryJob is 2.
    log    Step 5:\nDescription\n1. Query the records in wggc.dbo.afp_filminfo with patient id and accession number.\nExpected:\n There is new record insert into this table..
    ${Archive_Filminfo_Table_Result} =    Film Check Archive In Filminfo Table
    Should Be True    ${Archive_Filminfo_Table_Result} == True    There is new record insert into this table.
    log    Step 6:\nDescription:\n1. Query the records in wggc.dbo.afp_examinfo with patient id and accession number. \nExpected: \nThere is new record insert into this table..
    ${Archived_Examinfo_Table_result} =    Film Check Archive In Examinfo Table
    Should Be True    ${Archived_Examinfo_Table_result} == True    There is new record insert into this table.

SmokeTest_003_Core_4713_02.01.01 Report receive from web service NotifyServer.
    [Tags]    Smoke
    log    Step 1\n Description:\n1. Create a patient with an exam in RIS or local table in PS.\nExpected:\n 1. The patient with an exam can create successfully.
    ${patientinfo} =    Patient Create Randomly
    ${json_object} =    Convert String to JSON    ${patientinfo}
    ${status} =    Get Value From Json    ${json_object}    Status
    Should be True    ${status}[0]    Patient create successfully.
    ${patientID} =    Get Value From Json    ${json_object}    PatientID
    ${AccessionNumber} =    Get Value From Json    ${json_object}    AccessionNumber
    ${PatientName} =    Get Value From Json    ${json_object}    NameCN
    ${Report_type} =    Set Variable    formal
    ${File_path}=    Set Variable    E:\\PUMA_AUTO_Ref\\Cases\\SmokeTest\\4713\\Report\\Performance1.pdf,E:\\PUMA_AUTO_Ref\\Cases\\SmokeTest\\4713\\Report\\Performance1.pdf
    ${PDF_Password} =    Set Variable    ,
    Sleep    5
    ${Report_archived_Info}=    Report Create By Notifyserver Reportinfo    ${PatientName}[0]    ${patientID}[0]    ${AccessionNumber}[0]    ${Report_type}    ${File_path}
    ...    ${PDF_Password}
    ${Report_archived_Info_Json} =    Convert String to JSON    ${Report_archived_Info}
    ${Report_archived_result} =    Get Value From Json    ${Report_archived_Info_Json}    result
    Should Be True    ${Report_archived_result}[0] == True    The web service should return true or return successfully response. Th web service return 0 as true.
    Sleep    5
    log    Step 4:\n Description \n 1. Check the WGGC.dbo.AFP_ReportInfo table. \n Expected \n 1. New record can be found in AFP_ReportInfo table for received report, and the ReportStatus value should be 2.
    ${Report_StudyInstanceUID} =    Get Value From Json    ${Report_archived_Info_Json}    StudyInstanceUID
    ${Report_Check_ReportInfo_Info_Info} =    Report Check Archive In Reportinfo By UUID    ${Report_StudyInstanceUID}[0]
    ${Report_Check_ReportInfo_Info_Json}    Convert String to JSON    ${Report_Check_ReportInfo_Info_Info}
    ${Report_Check_ReportInfo_Info_Result} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    result
    ${Report_Check_ReportInfo_Info_ReportStatus} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    ReportStatus
    Should be True    ${Report_Check_ReportInfo_Info_Result}[0]    Wggc.dbo.AFP_ReportInfo table have new records of this report
    Should Be Equal As Integers    ${Report_Check_ReportInfo_Info_ReportStatus}[0]    2    The report status value in table wggc.dbo.afp_reportinfo is 2
    log    Step 5: \n Description: \n 1. Check the WGGC.dbo.AFP_PrintMode table. \n Expected: \n 1. Can find a new record in table and value should be correct. \n
    ${PrintMode_info} =    Printmode Get Info From Db By Accn    ${AccessionNumber}[0]
    ${PrintMode_info_Json} =    Convert String To Json    ${PrintMode_info}
    ${PrintMode_result} =    Get Value From Json    ${PrintMode_info_Json}    result
    ${PrintMode_value}    Get Value From Json    ${PrintMode_info_Json}    PrintMode
    Should Be True    ${PrintMode_result}
    Should Be Equal As Integers    ${PrintMode_value}[0]    0    The patient print mode is 0 for "门诊病人"
    log    Step 6: \n Description: \n 1. Check the ReportStoredFlag value in T_Integration_ExamInfo table in WGGC database for this report. \n Expected: \n 1. The ReportStoredFlag value should be 9 \n
    ${Report_ReportStoreFlag_info} =    Report Check ReportStoredFlag In T Integration ExamInfo    ${patientID}[0]    ${AccessionNumber}[0]
    ${Report_ReportStoreFlag_info_json} =    Convert String to JSON    ${Report_ReportStoreFlag_info}
    ${Report_ReportStoreFlage_info_result} =    Get Value From Json    ${Report_ReportStoreFlag_info_json}    result
    ${Report_ReportStoreFlage_value} =    Get Value From Json    ${Report_ReportStoreFlag_info_json}    ReportStoredFlag
    Should Be True    ${Report_ReportStoreFlage_info_result}[0]
    Should Be Equal As Integers    ${Report_ReportStoreFlage_value}[0]    9    The ReportStoredFlag value should be 9 in T_integration_examInfo table

SmokeTest_004_Core_4714_02.01.02 Report receive from web service PrintServer_Reportinfo
    [Tags]    Smoke
    log    Step 1\n Description:\n1. Create a patient with an exam in RIS or local table in PS.\nExpected:\n 1. The patient with an exam can create successfully.
    ${patientinfo} =    Patient Create Randomly
    ${json_object} =    Convert String to JSON    ${patientinfo}
    ${status} =    Get Value From Json    ${json_object}    Status
    Should be True    ${status}[0]    Patient create successfully.
    ${patientID} =    Get Value From Json    ${json_object}    PatientID
    ${AccessionNumber} =    Get Value From Json    ${json_object}    AccessionNumber
    ${PatientName} =    Get Value From Json    ${json_object}    NameCN
    ${Report_type} =    Set Variable    formal
    ${File_path}=    Set Variable    E:\\PUMA_AUTO_Ref\\Cases\\SmokeTest\\4714\\Report\\Performance1.pdf
    Sleep    5
    ${Report_archived_Info} =    Report Create By Printserver Reportinfo    ${PatientName}[0]    ${patientID}[0]    ${AccessionNumber}[0]    ${Report_type}    ${File_path}
    ${Report_archived_Info_Json} =    Convert String to JSON    ${Report_archived_Info}
    ${Report_archived_result} =    Get Value From Json    ${Report_archived_Info_Json}    result
    Should Be True    ${Report_archived_result}[0] == True    The web service should return true or return successfully response. Th web service return 0 as true.
    log    Step 4:\n Description \n 1. Check the WGGC.dbo.AFP_ReportInfo table. \n Expected \n 1. New record can be found in AFP_ReportInfo table for received report, and the ReportStatus value should be 2.
    ${Report_StudyInstanceUID} =    Get Value From Json    ${Report_archived_Info_Json}    StudyInstanceUID
    ${Report_Check_ReportInfo_Info_Info} =    Report Check Archive In Reportinfo By UUID    ${Report_StudyInstanceUID}[0]
    ${Report_Check_ReportInfo_Info_Json}    Convert String to JSON    ${Report_Check_ReportInfo_Info_Info}
    ${Report_Check_ReportInfo_Info_Result} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    result
    ${Report_Check_ReportInfo_Info_ReportStatus} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    ReportStatus
    Should be True    ${Report_Check_ReportInfo_Info_Result}[0]    Wggc.dbo.AFP_ReportInfo table have new records of this report
    Should Be Equal    ${Report_Check_ReportInfo_Info_ReportStatus}[0]    2    The report status value in table wggc.dbo.afp_reportinfo is 2
    Sleep    5
    log    Step 5: \n Description: \n 1. Check the WGGC.dbo.AFP_PrintMode table. \n Expected: \n 1. Can find a new record in table and value should be correct. \n
    ${PrintMode_info} =    Printmode Get Info From Db By Accn    ${AccessionNumber}[0]
    ${PrintMode_info_Json} =    Convert String To Json    ${PrintMode_info}
    ${PrintMode_result} =    Get Value From Json    ${PrintMode_info_Json}    result
    ${PrintMode_value}    Get Value From Json    ${PrintMode_info_Json}    PrintMode
    Should Be True    ${PrintMode_result}
    Should Be Equal As Integers    ${PrintMode_value}[0]    0    The patient print mode is 0 for "门诊病人"
    log    Step 6: \n Description: \n 1. Check the ReportStoredFlag value in T_Integration_ExamInfo table in WGGC database for this report. \n Expected: \n 1. The ReportStoredFlag value should be 9 \n
    ${Report_ReportStoreFlag_info} =    Report Check ReportStoredFlag In T Integration ExamInfo    ${patientID}[0]    ${AccessionNumber}[0]
    ${Report_ReportStoreFlag_info_json} =    Convert String to JSON    ${Report_ReportStoreFlag_info}
    ${Report_ReportStoreFlage_info_result} =    Get Value From Json    ${Report_ReportStoreFlag_info_json}    result
    ${Report_ReportStoreFlage_value} =    Get Value From Json    ${Report_ReportStoreFlag_info_json}    ReportStoredFlag
    Should Be True    ${Report_ReportStoreFlage_info_result}[0]
    Should Be Equal As Integers    ${Report_ReportStoreFlage_value}[0]    9    The ReportStoredFlag value should be 9 in T_integration_examInfo table

SmokeTest_005_Core_4715_03.01.01 Report receive from Virtual Print success.
    [Tags]    Smoke
    log    Step 1\n Description:\n1. Create a patient with an exam in RIS or local table in PS.\nExpected:\n 1. The patient with an exam can create successfully.
    ${patientinfo} =    Patient Create Randomly
    ${json_object} =    Convert String to JSON    ${patientinfo}
    ${status} =    Get Value From Json    ${json_object}    Status
    Should be True    ${status}[0]    Patient create successfully.
    ${patientID} =    Get Value From Json    ${json_object}    PatientID
    ${AccessionNumber} =    Get Value From Json    ${json_object}    AccessionNumber
    ${PatientName} =    Get Value From Json    ${json_object}    NameCN
    Log    Step 2: \n Description \n 1. Configure the report OCR service in PS. \n 2. Make sure it can identify the patient report in step1. \n Expected:\n The operation can execute successfully.
    Log    Step 3: \n Description \n 1. Prepare a report of patient which create in step1. \n 2. Print the report to PS by virtul printing. \n Expected: \n 1. The report can print to PS successfully. \n
    Sleep    5
    ${Report_archived_Info} =    Report Create Report With Sample    ${patientID}[0]    ${AccessionNumber}[0]
    ${Report_archived_Info_Json} =    Convert String to JSON    ${Report_archived_Info}
    ${Report_archived_result} =    Get Value From Json    ${Report_archived_Info_Json}    Status
    Should Be True    ${Report_archived_result}[0] == True    The report can print to PS successfully.
    Sleep    10
    log    Step 4 \n \ Description \n 1. Check the WGGC.dbo.AFP_ReportInfo table. \n Expected: \n 1. New record can be found in AFP_ReportInfo table for received report, and the ReportStatus value should be 2. \n
    ${Report_Check_ReportInfo_Info_Info} =    Report Get Info From Afp Reportinfo    ${patientID}[0]    ${AccessionNumber}[0]
    ${Report_Check_ReportInfo_Info_Json}    Convert String to JSON    ${Report_Check_ReportInfo_Info_Info}
    ${Report_Check_ReportInfo_Info_Result} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    result
    ${Report_Check_ReportInfo_Info_ReportStatus} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    ReportStatus
    ${Report_Check_ReportInfo_Info_ReportPath} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    FileName
    Should be True    ${Report_Check_ReportInfo_Info_Result}[0]    Wggc.dbo.AFP_ReportInfo table have new records of this report
    Should Be Equal As Integers    ${Report_Check_ReportInfo_Info_ReportStatus}[0][0]    2    The report status value in table wggc.dbo.afp_reportinfo is 2
    Sleep    5
    Log    Step 5: \n Description:\n 1. Check the WGGC.dbo.AFP_ReportInfo table. \n Expected: \n 1. New record can be found in AFP_ReportInfo table for received report, and the printstatus value should be 0. \n
    ${Report_Check_ReportInfo_Info_PrintStatus} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    PrintStatus
    Should be True    ${Report_Check_ReportInfo_Info_Result}[0]    Wggc.dbo.AFP_ReportInfo table have new records of this report
    Should Be Equal As Integers    ${Report_Check_ReportInfo_Info_PrintStatus}[0][0]    0    The report printstatus value is 0
    Sleep    5
    Log    Step 6 \n Description: \n 1. Check the WGGC.dbo.AFP_PrintMode table \n Expected:\n 1. Can find a new record in this table and value should be correct. \n
    ${PrintMode_info} =    Printmode Get Info From Db By Accn    ${AccessionNumber}[0]
    ${PrintMode_info_Json} =    Convert String To Json    ${PrintMode_info}
    ${PrintMode_result} =    Get Value From Json    ${PrintMode_info_Json}    result
    ${PrintMode_value}    Get Value From Json    ${PrintMode_info_Json}    PrintMode
    Should Be True    ${PrintMode_result}
    Should Be Equal As Integers    ${PrintMode_value}[0]    0    The patient print mode is 0 for "门诊病人"
    Sleep    5
    log    Step 7 \n Description: \n 1. Check the ReportStoredFlag value in T_Integration_ExamInfo table in WGGC database for this report. \n Expected: \n 1. The ReportStoredFlag value should be 9 \n
    ${Report_ReportStoreFlag_info} =    Report Check ReportStoredFlag In T Integration ExamInfo    ${patientID}[0]    ${AccessionNumber}[0]
    ${Report_ReportStoreFlag_info_json} =    Convert String to JSON    ${Report_ReportStoreFlag_info}
    ${Report_ReportStoreFlage_info_result} =    Get Value From Json    ${Report_ReportStoreFlag_info_json}    result
    ${Report_ReportStoreFlage_value} =    Get Value From Json    ${Report_ReportStoreFlag_info_json}    ReportStoredFlag
    Should Be True    ${Report_ReportStoreFlage_info_result}[0]
    Should Be Equal As Integers    ${Report_ReportStoreFlage_value}[0]    9    The ReportStoredFlag value should be 9 in T_integration_examInfo table
    Sleep    5
    Log    Step 8: \n Description: \n 1. Check the records in WGGC.dbo.AFP_ExamInfo table in WGGC database for this report. \n Expected: \n1. The Report can find in the table. \n
    ${Report_exam_info} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${AccessionNumber}[0]
    ${Report_exam_info_Json} =    Convert String to JSON    ${Report_exam_info}
    ${Report_exam_info_Result} =    Get Value From Json    ${Report_exam_info_Json}    Result
    Should Be True    ${Report_exam_info_Result}[0]    The report can find in the wggc.dbo.afp_ExamInfo table.
    Sleep    5
    Log    Step 9 \n Description \n 1. Check the report in archived folder. (default is E:\\Report\\Archive.) \n Expected: \n 1.The file should exist in the folder \n
    ${Report_File_Pathc_Check_Result} =    Report Check File Exist By Path Remote    ${Report_Check_ReportInfo_Info_ReportPath}[0][0]
    Should Be True    ${Report_File_Pathc_Check_Result}    The file exist in the folder.

SmokeTest_006_Core_4176_03.01.02 Report receive from Virtual Print failure.
    [Tags]    Smoke
    log    Step 1\n Description:\n1. Create a patient with an exam in RIS or local table in PS.\nExpected:\n 1. The patient with an exam can create successfully.
    ${patientinfo} =    Patient Create Randomly
    ${json_object} =    Convert String to JSON    ${patientinfo}
    ${status} =    Get Value From Json    ${json_object}    Status
    Should be True    ${status}[0]    Patient create successfully.
    ${patientID} =    Get Value From Json    ${json_object}    PatientID
    ${AccessionNumber} =    Get Value From Json    ${json_object}    AccessionNumber
    ${PatientName} =    Get Value From Json    ${json_object}    NameCN
    Log    Step 2: \n Description \n 1. Configure the report OCR service in PS. \n 2. Make sure it can identify the patient report in step1. \n 3. Delete the patient information of step1. \n Expected:\n The operation can execute successfully.
    ${Patient_Delete_Result} =    Patient Delete By Pid Accn    ${patientID}[0]    ${AccessionNumber}[0]
    Log    Step 3: \n Description \n 1. Prepare a report of patient which create in step1. \n 2. Print the report to PS by virtul printing. \n Expected: \n 1. The report can print to PS successfully. \n
    Sleep    5
    ${Report_archived_Info} =    Report Create Report With Sample    ${patientID}[0]    ${AccessionNumber}[0]
    ${Report_archived_Info_Json} =    Convert String to JSON    ${Report_archived_Info}
    ${Report_archived_result} =    Get Value From Json    ${Report_archived_Info_Json}    Status
    Should Be True    ${Report_archived_result}[0] == False    The report can print to PS successfully.
    Sleep    10
    log    Step 4 \n \ Description \n 1. Check the WGGC.dbo.AFP_ReportInfo table. \n Expected: \n 1. New record can be found in AFP_ReportInfo table for received report, and the ReportStatus value should be -1. \n
    ${Report_Check_ReportInfo_Info_Info} =    DB Get Wggc Dbo Afp Reportinfo By Pid    ${patientID}[0]
    ${Report_Check_ReportInfo_Info_Json}    Convert String to JSON    ${Report_Check_ReportInfo_Info_Info}
    ${Report_Check_ReportInfo_Info_Result} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    Result
    ${Report_Check_ReportInfo_Info_ReportStatus} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    ReportStatus
    ${Report_Check_ReportInfo_Info_ReportPath} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    FileName
    Should be True    ${Report_Check_ReportInfo_Info_Result}[0]    Wggc.dbo.AFP_ReportInfo table have new records of this report
    Should Be Equal As Integers    ${Report_Check_ReportInfo_Info_ReportStatus}[0]    -1    The report status value in table wggc.dbo.afp_reportinfo is -1
    Sleep    5
    Log    Step 5: \n Description:\n 1. Check the WGGC.dbo.AFP_ReportInfo table. \n Expected: \n 1. New record can be found in AFP_ReportInfo table for received report, and the printstatus value should be 0. \n
    ${Report_Check_ReportInfo_Info_PrintStatus} =    Get Value From Json    ${Report_Check_ReportInfo_Info_Json}    PrintStatus
    Should be True    ${Report_Check_ReportInfo_Info_Result}[0]    Wggc.dbo.AFP_ReportInfo table have new records of this report
    Should Be Equal As Integers    ${Report_Check_ReportInfo_Info_PrintStatus}[0]    0    The report printstatus value is 0
    Sleep    5
    Log    Step 6 \n Description: \n 1. Check the WGGC.dbo.AFP_PrintMode table \n Expected:\n 1. Cannot find a new record in this table and value should be correct. \n
    ${PrintMode_info} =    Printmode Get Info From Db By Accn    ${AccessionNumber}[0]
    ${PrintMode_info_Json} =    Convert String To Json    ${PrintMode_info}
    ${PrintMode_result} =    Get Value From Json    ${PrintMode_info_Json}    result
    ${PrintMode_value}    Get Value From Json    ${PrintMode_info_Json}    PrintMode
    Should Be True    ${PrintMode_result}[0] == False
    Sleep    5
    log    Step 7 \n Description: \n 1. Check the ReportStoredFlag value in T_Integration_ExamInfo table in WGGC database for this report. \n Expected: \n 1. Cannot find records in the table. \n
    ${Report_ReportStoreFlag_info} =    Report Check ReportStoredFlag In T Integration ExamInfo    ${patientID}[0]    ${AccessionNumber}[0]
    ${Report_ReportStoreFlag_info_json} =    Convert String to JSON    ${Report_ReportStoreFlag_info}
    ${Report_ReportStoreFlage_info_result} =    Get Value From Json    ${Report_ReportStoreFlag_info_json}    result
    Should Be True    ${Report_ReportStoreFlage_info_result}[0] == False    Cannot find the records in the database.
    Log    Step 8: \n Description: \n 1. Check the records in WGGC.dbo.AFP_ExamInfo table in WGGC database for this report. \n Expected: \n 1.Cannot find a new record in table. \n
    ${Report_exam_info} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${AccessionNumber}[0]
    ${Report_exam_info_Json} =    Convert String to JSON    ${Report_exam_info}
    ${Report_exam_info_Result} =    Get Value From Json    ${Report_exam_info_Json}    Result
    Should Be True    ${Report_exam_info_Result}[0] == False    1.Cannot find a new record in table.
    Log    Step 9 \n Description \n 1. Check the report in archived folder. (default is E:\\Report\\Archive.) \n Expected: \n 1.The file should exist in the folder \n
    ${Report_File_Pathc_Check_Result} =    Report Check File Exist By Path Remote    ${Report_Check_ReportInfo_Info_ReportPath}[0]
    Should Be True    ${Report_File_Pathc_Check_Result}    The file exist in the folder.

SmokeTest_007_Core_4178_04.01.01 Terminal K3 Print Workflow with multiple films and multiple reports.
    [Tags]    Smoke
    log    Step 1 \n Description:\n 1. Configure a K3 terminal on PS. \n 2. Make sure the terminal status is ready to work. \n Expected: \n 1. The operation can execute successfully. \n
    ${Terminal_status} =    Check Terminal Status    K3_Terminal01
    Should be True    ${Terminal_status}    The termianl status is ready to print
    log    Step 2 \n Description: \n 1. Create multiple films for patientA/ExamA. \n Expected \n 1. The films can archived successfully. \n
    ${patientinfo} =    Patient Create Randomly
    ${json_object} =    Convert String to JSON    ${patientinfo}
    ${status} =    Get Value From Json    ${json_object}    Status
    ${patientID} =    Get Value From Json    ${json_object}    PatientID
    ${Accessionnumber} =    Get Value From Json    ${json_object}    AccessionNumber
    Should Be True    ${status}[0]== True    The patient Create successfully.
    ${Print_res}    Film Create Film With Sample    ${patientID}[0]    ${Accessionnumber}[0]
    ${Print_Res_Json}=    Convert String to JSON    ${Print_res}
    ${Print_Result}=    Get Value From Json    ${Print_Res_Json}    Status
    Should Be True    ${Print_Result}[0] == True    Film print to PS successfully.
    ${Print_res}    Film Create Film With Sample    ${patientID}[0]    ${Accessionnumber}[0]
    ${Print_Res_Json}=    Convert String to JSON    ${Print_res}
    ${Print_Result}=    Get Value From Json    ${Print_Res_Json}    Status
    Should Be True    ${Print_Result}[0] == True    Film print to PS successfully.
    log    Step 3 \n Description:\n 1. Create multiple reports for patientA/ExamA. \n Expected: \n 1. The reports can archived successfully. \n
    ${Report_archived_Info} =    Report Create Report With Sample    ${patientID}[0]    ${AccessionNumber}[0]
    ${Report_archived_Info_Json} =    Convert String to JSON    ${Report_archived_Info}
    ${Report_archived_result} =    Get Value From Json    ${Report_archived_Info_Json}    Status
    Should Be True    ${Report_archived_result}[0] == True    The report can print to PS successfully.
    ${Report_archived_Info} =    Report Create Report With Sample    ${patientID}[0]    ${AccessionNumber}[0]
    ${Report_archived_Info_Json} =    Convert String to JSON    ${Report_archived_Info}
    ${Report_archived_result} =    Get Value From Json    ${Report_archived_Info_Json}    Status
    Should Be True    ${Report_archived_result}[0] == True    The report can print to PS successfully.
    Log    Step 4 \n Description:\n 1. Set the print mode to both for ExamA \n Expected:\n 1. The operation can execute successfully. \n
    ${Set_Printmode} =    Printmode Set By Accn    ${AccessionNumber}[0]    both
    Should be True    ${Set_Printmode}
    sleep    10
    log    Step 5 \n Description: \n 1. Wait for the holding time of film and report has passed. \n Expected:\n 1. The operation can execute successfully. \n
    ${Holdtime_result} =    HoldTime Wait Time Arrive By Accn    ${AccessionNumber}[0]
    Should Be True    ${Holdtime_result}
    log    Step 6 \n Description: \n 1.Print the prepared films and reports with accession number on K3 terminal prepared in step1. \n Expected: \n 1. The print task should finish successfully. The status in wggc.dbo.afp_printtask should be 4. \n
    ${Termina_Print_Result} =    Terminal Print With Cardinfo    K3_Terminal01    ${AccessionNumber}[0]
    Should Be True    ${Termina_Print_Result}

SmokeTest_008_Core_4177_04.01.02 Terminal K3 Print Workflow with one film and one report.
    [Tags]    Smoke
    log    Step 1 \n Description:\n 1. Configure a K3 terminal on PS. \n 2. Make sure the terminal status is ready to work. \n Expected: \n 1. The operation can execute successfully. \n
    ${Terminal_status} =    Check Terminal Status    K3_Terminal01
    Should be True    ${Terminal_status}    The termianl status is ready to print
    log    Step 2 \n Description: \n 1. Create one film for patientB/ExamB. \n Expected \n 1. The film can archived successfully. \n
    ${patientinfo} =    Patient Create Randomly
    ${json_object} =    Convert String to JSON    ${patientinfo}
    ${status} =    Get Value From Json    ${json_object}    Status
    ${patientID} =    Get Value From Json    ${json_object}    PatientID
    ${Accessionnumber} =    Get Value From Json    ${json_object}    AccessionNumber
    Should Be True    ${status}[0]== True    The patient Create successfully.
    ${Print_res}    Film Create Film With Sample    ${patientID}[0]    ${Accessionnumber}[0]
    ${Print_Res_Json}=    Convert String to JSON    ${Print_res}
    ${Print_Result}=    Get Value From Json    ${Print_Res_Json}    Status
    Should Be True    ${Print_Result}[0] == True    Film print to PS successfully.
    log    Step 3 \n Description:\n 1. Create one report for patientB/ExamB. \n Expected: \n 1. The report can archived successfully. \n
    ${Report_archived_Info} =    Report Create Report With Sample    ${patientID}[0]    ${AccessionNumber}[0]
    ${Report_archived_Info_Json} =    Convert String to JSON    ${Report_archived_Info}
    ${Report_archived_result} =    Get Value From Json    ${Report_archived_Info_Json}    Status
    Should Be True    ${Report_archived_result}[0] == True    The report can print to PS successfully.
    Log    Step 4 \n Description:\n 1. Set the print mode to both for ExamB \n Expected:\n 1. The operation can execute successfully. \n
    ${Set_Printmode} =    Printmode Set By Accn    ${AccessionNumber}[0]    both
    Should be True    ${Set_Printmode}
    sleep    10
    log    Step 5 \n Description: \n 1. Wait for the holding time of film and report has passed. \n Expected:\n 1. The operation can execute successfully. \n
    ${Holdtime_result} =    HoldTime Wait Time Arrive By Accn    ${AccessionNumber}[0]
    Should Be True    ${Holdtime_result}
    log    Step 6 \n Description: \n 1.Print the prepared films and reports with accession number on K3 terminal prepared in step1. \n Expected: \n 1. The print task should finish successfully. The status in wggc.dbo.afp_printtask should be 4. \n
    ${Termina_Print_Result} =    Terminal Print With Cardinfo    K3_Terminal01    ${AccessionNumber}[0]
    Should Be True    ${Termina_Print_Result}

SmokeTest_009_Core_4187_04.01.03 Terminal K3 Print Workflow with one film.
    [Tags]    Smoke
    log    Step 1 \n Description:\n 1. Configure a K3 terminal on PS. \n 2. Make sure the terminal status is ready to work. \n Expected: \n 1. The operation can execute successfully. \n
    ${Terminal_status} =    Check Terminal Status    K3_Terminal01
    Should be True    ${Terminal_status}    The termianl status is ready to print
    log    Step 2 \n Description: \n 1. Create one film for patientB/ExamB. \n Expected \n 1. The film can archived successfully. \n
    ${patientinfo} =    Patient Create Randomly
    ${json_object} =    Convert String to JSON    ${patientinfo}
    ${status} =    Get Value From Json    ${json_object}    Status
    ${patientID} =    Get Value From Json    ${json_object}    PatientID
    ${Accessionnumber} =    Get Value From Json    ${json_object}    AccessionNumber
    Should Be True    ${status}[0]== True    The patient Create successfully.
    ${Print_res}    Film Create Film With Sample    ${patientID}[0]    ${Accessionnumber}[0]
    ${Print_Res_Json}=    Convert String to JSON    ${Print_res}
    ${Print_Result}=    Get Value From Json    ${Print_Res_Json}    Status
    Should Be True    ${Print_Result}[0] == True    Film print to PS successfully.
    Log    Step 3 \n Description:\n 1. Set the print mode to Film only for ExamB \n Expected:\n 1. The operation can execute successfully. \n
    Sleep    10
    ${Set_Printmode} =    Printmode Set By Accn    ${AccessionNumber}[0]    film
    Should be True    ${Set_Printmode}
    sleep    10
    log    Step 4 \n Description: \n 1. Wait for the holding time of film has passed. \n Expected:\n 1. The operation can execute successfully. \n
    ${Holdtime_result} =    HoldTime Wait Time Arrive By Accn    ${AccessionNumber}[0]
    Should Be True    ${Holdtime_result}
    log    Step 5 \n Description: \n 1.Print the prepared exam with accession number on K3 terminal prepared in step1. \n Expected: \n 1. The print task should finish successfully. The status in wggc.dbo.afp_printtask should be 4. \n
    ${Termina_Print_Result} =    Terminal Print With Cardinfo    K3_Terminal01    ${AccessionNumber}[0]
    Should Be True    ${Termina_Print_Result}

SmokeTest_010_Core_4179_05.01.01 Central Print multi patients with custom terminal
    [Tags]    Smoke
    log    Step 1 \n Description:\n 1. Configure a custom terminal on PS. \n 2. Make sure the terminal status is ready to work. \n Expected: \n 1. The operation can execute successfully. \n
    ${exam_count} =    Set Variable    5
    ${Terminal_status} =    Check Terminal Status    Customer_Terminal01
    Should be True    ${Terminal_status}    The termianl status is ready to print
    log    Step 2 \n Description: \n 1. Prepare 5 patients` exam, each has one film and one report. \n Expected: \n 1. The preparation can finish successfully. \n
    ${list_Accn}    Create List
    ${restinstanceids}    Create List
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${patientinfo} =    Patient Create Randomly
    \    ${json_object} =    Convert String to JSON    ${patientinfo}
    \    ${status} =    Get Value From Json    ${json_object}    Status
    \    ${patientID} =    Get Value From Json    ${json_object}    PatientID
    \    ${Accessionnumber} =    Get Value From Json    ${json_object}    AccessionNumber
    \    Should Be True    ${status}[0]== True    The patient Create successfully.
    \    ${Print_res}    Film Create Film With Sample    ${patientID}[0]    ${Accessionnumber}[0]
    \    ${Print_Res_Json}=    Convert String to JSON    ${Print_res}
    \    ${Print_Result}=    Get Value From Json    ${Print_Res_Json}    Status
    \    Should Be True    ${Print_Result}[0] == True    Film print to PS successfully.
    \    ${Report_archived_Info} =    Report Create Report With Sample    ${patientID}[0]    ${AccessionNumber}[0]
    \    ${Report_archived_Info_Json} =    Convert String to JSON    ${Report_archived_Info}
    \    ${Report_archived_result} =    Get Value From Json    ${Report_archived_Info_Json}    Status
    \    Should Be True    ${Report_archived_result}[0] == True    The report can print to PS successfully.
    \    log    ${AccessionNumber}[0]
    \    Append To List    ${list_Accn}    ${AccessionNumber}[0]
    log    ${list_Accn}
    ${Report_Print_DateTime_old}    Create List
    ${Film_Print_DateTime_old}    Create List
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${ACCN} =    Get From List    ${list_Accn}    ${count}
    \    ${Exmainfo_DB_Value} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${ACCN}
    \    ${json} =    Convert String to JSON    ${Exmainfo_DB_Value}
    \    ${FilmPrintTime}    Get Value From Json    ${json}    FilmPrintTime
    \    ${ReportPrintTime}=    Get Value From Json    ${json}    ReportPrintTime
    \    Append To List    ${Report_Print_DateTime_old}    ${FilmPrintTime}[0]
    \    Append To List    ${Film_Print_DateTime_old}    ${ReportPrintTime}[0]
    Log    ${Report_Print_DateTime_old}
    Log    ${Film_Print_DateTime_old}
    Log    Step 3 \n Description: \n1. Use the API to simulate the central print operation: \ \ Print the exams created in step2 with the terminal which created in step1. \n Excepted:\n 1. The API should return the successful response. \n
    ${login_result} =    Platform Login User Pwd    admin    123456
    should be true    ${login_result}
    ${centralprint_result} =    Platform Worklist Central Print    Customer_Terminal01    admin    ${list_Accn}    ${restinstanceids}
    should be true    ${centralprint_result}[0] == True
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${taksinfo}=    Get From List    ${centralprint_result}[1]    ${count}
    \    ${printtask_sn} =    Get From Dictionary    ${taksinfo}    printTaskID
    \    ${PrintTask_DB_Value} =    DB Get Wggc Dbo Afp Printtask By Sn    ${printtask_sn}
    \    ${json} =    Convert String to JSON    ${PrintTask_DB_Value}
    \    ${Printtask_status}=    Get Value From Json    ${json}    Status
    \    ${Patient_id}=    Get Value From Json    ${json}    PatientID
    \    Should Be Equal As Integers    ${Printtask_status}[0]    4    The Print task status in DB is 4
    Log    Step 4 \n Description: \n 1. Check the print task status in the wggc.dbo.afp_printtask table. \n Expected: \n 1. All print tasks should be successful and status should be 4. \n
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${ACCN} =    Get From List    ${list_Accn}    ${count}
    \    ${Exmainfo_DB_Value} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${ACCN}
    \    ${json} =    Convert String to JSON    ${Exmainfo_DB_Value}
    \    ${Filmprint_Status}=    Get Value From Json    ${json}    FilmPrintStatus
    \    ${Patient_id}=    Get Value From Json    ${json}    PatientID
    \    Should Be Equal As Integers    ${Filmprint_Status}[0]    1    The filmp rint status in DB is 1
    log    Step 5 \n Description: \n 1. Check the FilmPrintStatus of these patients in WGGC.dbo.afp_ExamInfo table. \n Expected: \n 1. The status should be printed.
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${ACCN} =    Get From List    ${list_Accn}    ${count}
    \    ${Exmainfo_DB_Value} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${ACCN}
    \    ${json} =    Convert String to JSON    ${Exmainfo_DB_Value}
    \    ${ReportPrint_Status}=    Get Value From Json    ${json}    ReportPrintStatus
    \    ${Patient_id}=    Get Value From Json    ${json}    PatientID
    \    Should Be Equal As Integers    ${ReportPrint_Status}[0]    1    The Report print status in DB is 1
    log    Step 6 \n Description: \n 1. Check the ReportPrintStatus of these patients \ in WGGC.dbo.afp_ExamInfo table. \n Expected: \n The status should be printed. \n
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${Report_Print_DateTime_orignal} =    Get From List    ${Report_Print_DateTime_old}    ${count}
    \    ${ACCN} =    Get From List    ${list_Accn}    ${count}
    \    ${Exmainfo_DB_Value} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${ACCN}
    \    ${json} =    Convert String to JSON    ${Exmainfo_DB_Value}
    \    ${ReportPrint_DateTime}=    Get Value From Json    ${json}    ReportPrintTime
    \    ${DateTime_Check_Status} =    Platform Worklist Central Print Print Datetime Check    ${Report_Print_DateTime_orignal}    ${ReportPrint_DateTime}[0]
    \    Should Be True    ${DateTime_Check_Status}    The report print status has updated
    Log    Step 7 \n Description: \n 1. Check the report print date and time in the exam table of patients. \n Expected: \n 1. The values should be updated. \ \n
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${Film_Print_DateTime_orignal} =    Get From List    ${Film_Print_DateTime_old}    ${count}
    \    ${ACCN} =    Get From List    ${list_Accn}    ${count}
    \    ${Exmainfo_DB_Value} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${ACCN}
    \    ${json} =    Convert String to JSON    ${Exmainfo_DB_Value}
    \    ${FilmPrint_DateTime}=    Get Value From Json    ${json}    FilmPrintTime
    \    ${DateTime_Check_Status} =    Platform Worklist Central Print Print Datetime Check    ${Film_Print_DateTime_orignal}    ${FilmPrint_DateTime}[0]
    \    Should Be True    ${DateTime_Check_Status}    The film print status has updated
    Log    Step 8 \n Description: \n 1. Check the Film print date and time in the exam table of patients. \n Expected: \n 1. The values should be updated. \ \n

SmokeTest_011_Core_4180_06.01.01 Central Print multi patients with standard terminal
    [Tags]    Smoke
    log    Step 1 \n Description:\n 1. Configure a custom terminal on PS. \n 2. Make sure the terminal status is ready to work. \n Expected: \n 1. The operation can execute successfully. \n
    ${exam_count} =    Set Variable    1
    ${Terminal_status} =    Check Terminal Status    K3_Terminal01
    Should be True    ${Terminal_status}    The termianl status is ready to print
    log    Step 2 \n Description: \n 1. Prepare 5 patients` exam, each has one film and one report. \n Expected: \n 1. The preparation can finish successfully. \n
    ${list_Accn}    Create List
    ${restinstanceids}    Create List
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${patientinfo} =    Patient Create Randomly
    \    ${json_object} =    Convert String to JSON    ${patientinfo}
    \    ${status} =    Get Value From Json    ${json_object}    Status
    \    ${patientID} =    Get Value From Json    ${json_object}    PatientID
    \    ${Accessionnumber} =    Get Value From Json    ${json_object}    AccessionNumber
    \    Should Be True    ${status}[0]== True    The patient Create successfully.
    \    ${Print_res}    Film Create Film With Sample    ${patientID}[0]    ${Accessionnumber}[0]
    \    ${Print_Res_Json}=    Convert String to JSON    ${Print_res}
    \    ${Print_Result}=    Get Value From Json    ${Print_Res_Json}    Status
    \    Should Be True    ${Print_Result}[0] == True    Film print to PS successfully.
    \    ${Report_archived_Info} =    Report Create Report With Sample    ${patientID}[0]    ${AccessionNumber}[0]
    \    ${Report_archived_Info_Json} =    Convert String to JSON    ${Report_archived_Info}
    \    ${Report_archived_result} =    Get Value From Json    ${Report_archived_Info_Json}    Status
    \    Should Be True    ${Report_archived_result}[0] == True    The report can print to PS successfully.
    \    log    ${AccessionNumber}[0]
    \    Append To List    ${list_Accn}    ${AccessionNumber}[0]
    log    ${list_Accn}
    ${Report_Print_DateTime_old}    Create List
    ${Film_Print_DateTime_old}    Create List
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${ACCN} =    Get From List    ${list_Accn}    ${count}
    \    ${Exmainfo_DB_Value} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${ACCN}
    \    ${json} =    Convert String to JSON    ${Exmainfo_DB_Value}
    \    ${FilmPrintTime}    Get Value From Json    ${json}    FilmPrintTime
    \    ${ReportPrintTime}=    Get Value From Json    ${json}    ReportPrintTime
    \    Append To List    ${Report_Print_DateTime_old}    ${FilmPrintTime}[0]
    \    Append To List    ${Film_Print_DateTime_old}    ${ReportPrintTime}[0]
    Log    ${Report_Print_DateTime_old}
    Log    ${Film_Print_DateTime_old}
    Log    Step 3 \n Description: \n1. Use the API to simulate the central print operation: \ \ Print the exams created in step2 with the terminal which created in step1. \n Excepted:\n 1. The API should return the successful response. \n
    ${login_result} =    Platform Login User Pwd    admin    123456
    should be true    ${login_result}
    ${centralprint_result} =    Platform Worklist Central Print    Customer_Terminal01    admin    ${list_Accn}    ${restinstanceids}
    should be true    ${centralprint_result}[0] == True
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${taksinfo}=    Get From List    ${centralprint_result}[1]    ${count}
    \    ${printtask_sn} =    Get From Dictionary    ${taksinfo}    printTaskID
    \    ${PrintTask_DB_Value} =    DB Get Wggc Dbo Afp Printtask By Sn    ${printtask_sn}
    \    ${json} =    Convert String to JSON    ${PrintTask_DB_Value}
    \    ${Printtask_status}=    Get Value From Json    ${json}    Status
    \    ${Patient_id}=    Get Value From Json    ${json}    PatientID
    \    Should Be Equal As Integers    ${Printtask_status}[0]    4    The Print task status in DB is 4
    Log    Step 4 \n Description: \n 1. Check the print task status in the wggc.dbo.afp_printtask table. \n Expected: \n 1. All print tasks should be successful and status should be 4. \n
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${ACCN} =    Get From List    ${list_Accn}    ${count}
    \    ${Exmainfo_DB_Value} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${ACCN}
    \    ${json} =    Convert String to JSON    ${Exmainfo_DB_Value}
    \    ${Filmprint_Status}=    Get Value From Json    ${json}    FilmPrintStatus
    \    ${Patient_id}=    Get Value From Json    ${json}    PatientID
    \    Should Be Equal As Integers    ${Filmprint_Status}[0]    1    The filmp rint status in DB is 1
    log    Step 5 \n Description: \n 1. Check the FilmPrintStatus of these patients in WGGC.dbo.afp_ExamInfo table. \n Expected: \n 1. The status should be printed.
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${ACCN} =    Get From List    ${list_Accn}    ${count}
    \    ${Exmainfo_DB_Value} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${ACCN}
    \    ${json} =    Convert String to JSON    ${Exmainfo_DB_Value}
    \    ${ReportPrint_Status}=    Get Value From Json    ${json}    ReportPrintStatus
    \    ${Patient_id}=    Get Value From Json    ${json}    PatientID
    \    Should Be Equal As Integers    ${ReportPrint_Status}[0]    1    The Report print status in DB is 1
    log    Step 6 \n Description: \n 1. Check the ReportPrintStatus of these patients \ in WGGC.dbo.afp_ExamInfo table. \n Expected: \n The status should be printed. \n
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${Report_Print_DateTime_orignal} =    Get From List    ${Report_Print_DateTime_old}    ${count}
    \    ${ACCN} =    Get From List    ${list_Accn}    ${count}
    \    ${Exmainfo_DB_Value} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${ACCN}
    \    ${json} =    Convert String to JSON    ${Exmainfo_DB_Value}
    \    ${ReportPrint_DateTime}=    Get Value From Json    ${json}    ReportPrintTime
    \    ${DateTime_Check_Status} =    Platform Worklist Central Print Print Datetime Check    ${Report_Print_DateTime_orignal}    ${ReportPrint_DateTime}[0]
    \    Should Be True    ${DateTime_Check_Status}    The report print status has updated
    Log    Step 7 \n Description: \n 1. Check the report print date and time in the exam table of patients. \n Expected: \n 1. The values should be updated. \ \n
    : FOR    ${count}    IN RANGE    ${exam_count}
    \    ${Film_Print_DateTime_orignal} =    Get From List    ${Film_Print_DateTime_old}    ${count}
    \    ${ACCN} =    Get From List    ${list_Accn}    ${count}
    \    ${Exmainfo_DB_Value} =    DB Get Wggc Dbo Afp Examinfo By Accn    ${ACCN}
    \    ${json} =    Convert String to JSON    ${Exmainfo_DB_Value}
    \    ${FilmPrint_DateTime}=    Get Value From Json    ${json}    FilmPrintTime
    \    ${DateTime_Check_Status} =    Platform Worklist Central Print Print Datetime Check    ${Film_Print_DateTime_orignal}    ${FilmPrint_DateTime}[0]
    \    Should Be True    ${DateTime_Check_Status}    The film print status has updated
    Log    Step 8 \n Description: \n 1. Check the Film print date and time in the exam table of patients. \n Expected: \n 1. The values should be updated. \ \n

SmokeTest_0012_Core_4181_07.01.01 Worklist workflow fuzzy query by patientid
    [Tags]    Smoke
    log    Step 1 \n Description \n 1. Prepare some patients /exams in PS system. \n Expected: \n 1. The preparation can finish successfully. \n
    log    Step 2 \n Description: \n 1. Use the fuzzy query API to simalute the fuzzy query operation with patient id. \n Expected: \n The records count and information should be correct. \n
    ${login_result} =    Platform Login User Pwd    admin    123456
    Should Be True    ${login_result}
    ${Query_result} =    Platform Worklist Fuzzy Query By PatientID    20
    Should Be True    ${Query_result}    The query result is correct.
    ${logoff_status} =    Platform Logout
    Should Be True    ${logoff_status}

SmokeTest_0013_Core_4182_07.01.02 Worklist workflow fuzzy query by accession number.
    [Tags]    Smoke
    log    Step 1 \n Description \n 1. Prepare some patients /exams in PS system. \n Expected: \n 1. The preparation can finish successfully. \n
    log    Step 2 \n Description: \n 1. Use the fuzzy query API to simalute the fuzzy query operation with patient`s accession number. \n Expected: \n The records count and information should be correct. \n
    ${login_result} =    Platform Login User Pwd    admin    123456
    Should Be True    ${login_result}
    ${Query_result_accn} =    Platform Worklist Fuzzy Query By Accn    20
    Should Be True    ${Query_result_accn}    The query result is correct.
    ${logoff_status} =    Platform Logout
    Should Be True    ${logoff_status}

SmokeTest_0014_Core_4183_07.01.03 Worklist workflow fuzzy query by patient name.
    [Tags]    Smoke
    log    Step 1 \n Description \n 1. Prepare some patients /exams in PS system. \n Expected: \n 1. The preparation can finish successfully. \n
    log    Step 2 \n Description: \n 1. Use the fuzzy query API to simalute the fuzzy query operation with patient`s accession number. \n Expected: \n The records count and information should be correct. \n
    ${login_result} =    Platform Login User Pwd    admin    123456
    Should Be True    ${login_result}
    ${Query_result} =    Platform Worklist Fuzzy Query By Patientname    20
    Should Be True    ${Query_result}    The query result is correct.
    ${logoff_status} =    Platform Logout
    Should Be True    ${logoff_status}

SmokeTest_0015_Core_4184_07.01.04 Worklist workflow create a short cut with condition of patient type.
    [Tags]    Smoke
    log    Step 1 \n Description: \n 1. Prepare some patients/exams in PS system. \n Expected: \n 1. The preparation can finish successfully. \n
    log    Step 2 \n Description:\n 1.Clear the query condition with API in worklist. \n Expected Result:\n 1. The operation can execute successfully. \n
    log    Step 3 \n Description: \n 1. Use the query API to query all records of one patient type. \n Expected:\n 1. The query result should be correct. \n
    ${login_result} =    Platform Login User Pwd    admin    123456
    Should Be True    ${login_result}
    ${Query_result} =    Platform Worklist Fuzzy Query By Patienttype    门诊病人,住院病人
    ${Json_result} =    Convert String to JSON    ${Query_result}
    ${Result}=    Get Value From Json    ${Json_result}    Result
    Should Be True    ${Result}[0]
    ${query_data} =    Get Value From Json    ${Json_result}    worklist_data
    Log    ${query_data}
    log    Step 4 \n Description: \n 1. Use API to add a shortcut with name like 'patienttype'. \n Expected: \n 1. The shortcut should add and save successfully. \n
    ${Save_shortCut_result} =    Platform Worklist Shotcut Save    ralf    isFuzzy_bool=True    patientType=门诊病人,住院病人    UserName=admin
    Should Be True    ${Save_shortCut_result}[Result] == True    The shorcut save successuflly
    log    Step 5 \n Description：\n 1. Use API to simulate the operations as click the shortcut to query data. \n Expected:\n 1. The data should same with step2.
    ${Shortcut_Query_String} =    Platform Worklist Shotcut Query By Name    admin    ralf
    ${ShortCut_Query_Json} =    Convert String to JSON    ${Shortcut_Query_String}
    ${data}=    Get Value From Json    ${ShortCut_Query_Json}    Data
    ${query_data} =    Convert To String    ${query_data}
    ${data} =    Convert To String    ${data}
    log    ${query_data} =
    log    ${data}
    Should Be Equal As Strings    ${query_data}    ${data}
    ${logoff_status} =    Platform Logout
    Should Be True    ${logoff_status}
