# -*- coding : utf-8 -*-
'''
Designer: Ralf wang
Mail:   hao.wang@carestream.com
Date: 2019-08-07
Reviewer:
Design the report class and include related methond.
'''

import hashlib
import json
import os
import subprocess
import time
# import win32api
# import win32print
import uuid
from datetime import datetime

import pyodbc
import reportlab.pdfbase.ttfonts as pdfttfonts
from reportlab.lib.pagesizes import A4
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfgen import canvas
from suds.client import Client

from PUMA_ParameterAndSettings.Configurationlib import Configurationlib
from PUMA_PatientLibrary import Patient

settings = Configurationlib()
pdfmetrics.registerFont(pdfttfonts.TTFont('ms song', 'ms song.ttf'))


class Report(object):
    def __init__(self):
        try:
            self.Status = ""
            self.server = settings.server
            self.patient_id = ""
            self.accession_number = ""
            self.report_file = settings.report_file
            self.report_template_file = settings.report_template_file
            self.pdf_report_folder = settings.pdf_report_folder
            self.pdf_report_path = ""
            self.PS_report_shared_folder = settings.PS_report_shared_folder.replace("{server}", settings.server)
            self.powershell_path = settings.report_powershell_path
            self.default_printer = settings.report_default_printer
            self.report_check_file_path = ""
            self.notify_server_url = settings.Notify_URL.replace("{server}", settings.server)
            self.print_server_url = settings.PrintService_URL.replace("{server}", settings.server)
            self.reportstatus_mode_value = settings.Reportstatus_mode_value
            self.Reportstatus_value_mode = settings.Reportstatus_value_mode
        except Exception as e:
            print("PUMA_ReportLibrary: object Report init failed.")
            print(type(e))
            raise Exception(e)

    def report_create_report_with_sample(self, patientid, accessionnumber):
        """report create report with sample

        Print the report which created by template repleace with PID, ACCN
        It will check it archived successfully or not

        :param patientid: patientID of report which you want to replace.

        :param accessionnumber: accession number of report which you want to repleace.

        :return: json string include status value: True|False

        --Ralf wang 19005260
        """
        try:
            self.patient_id = patientid
            self.accession_number = accessionnumber

            report_exist_UID = self._get_exist_report_instanceUID(patientid, accessionnumber)

            self._create_report_with_template()
            self._print_report_from_template()

            for count in range(1, 13):
                time.sleep(10)
                if self._archive_check(patientid, accessionnumber, report_exist_UID):
                    self.Status = True
                    return_content = json.dumps(self.__dict__)
                    print("Report achived successfully. %s" % (return_content))
                    return return_content

            if self._archive_check(patientid, accessionnumber, report_exist_UID) is not True:
                print("Report archived failed.")
                self.Status = False
                return_content = json.dumps(self.__dict__)
                print("Report achived failed. %s" % (return_content))
                return return_content
        except Exception as e:
            print("Report.report_create_report_with_sample: Function execute failed.")
            print(type(e))
            raise Exception(e)

    def report_check_file_exist_by_path_local(self, file_path):
        """report_check_file_exist_by_path_local

        This function to check the file exist in the local disk or can access from the local machine
        include the wait to printed or printed report.

        Make sure the file path is shared or python have priviledge to get it!

        :param file_path: The file path which you want to check

        :return: bool True|False

        --ralf wang 19005260
        """

        try:
            self.report_check_file_path = file_path
            if os.path.isfile(self.report_check_file_path):
                print("Report.report_check_file_exist_by_path: The file is exist: %s" % (self.report_check_file_path))
                return True
            else:
                print(
                    "Report.report_check_file_exist_by_path: The file is not exist: %s" % (self.report_check_file_path))
                return False
        except Exception as e:
            print("Report.report_check_file_exist_by_path: Function execute failed.")
            print(type(e))
            raise Exception(e)

    def report_check_file_exist_by_path_remote(self, file_path):
        """report_check_file_exist_by_path_remote

        This function to check the file exist in file_path which in the PS server. We will get the report archived path
        such as in the E:\Report\Archive\*.pdf and check whether the file is exist or not.

        We will used the power shell commond to release the function.


        :param file_path: The file path which you want to check in PS system

        :return: bool True|False

        --ralf wang 19005260
        """

        powershell_file = self.powershell_path + "\PS_Check_File_Exist.ps1"
        with open(powershell_file, 'r') as fileobject:
            content = fileobject.read()

        content = content.replace('{server}', self.server).replace('{file_path}', file_path)
        print(file_path)

        powershell_temp_file = self.powershell_path + r"\PS_Check_File_Exist_temp.ps1"
        with open(powershell_temp_file, 'w') as fileobject:
            fileobject.write(content)

        print(str(powershell_temp_file))
        powershell_temp_file = str(powershell_temp_file)

        cmd_string = r"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " + powershell_temp_file
        print(cmd_string)
        output = subprocess.check_output(cmd_string, shell=False)
        print(output)
        print("Report.report_check_file_exist_by_path_remote: Message come from powershell: %s" % output)

        #os.remove(str(powershell_temp_file))

        if 'true' in str(output.decode('UTF-8')).lower():
            print("Report.report_check_file_exist_by_path_remote: The file is exsit in the PS system [%s]."
                  % file_path)
            return True
        else:
            print("Report.report_check_file_exist_by_path_remote: The file is not exsit in the PS system [%s]."
                  % file_path)
            return False


    def report_create_by_notifyserver_reportinfo(self, patient_name, patient_id, accessionNumber, report_status_info,
                                                 file_path_list, pdf_PWD_list):
        """report_create_by_notifyserver_reportinfo

        This function is use the web service[NotifyReportInfo] of NotifyServer to send the PDF report to PS.
        The report will archived to system without report OCR service.

        Note: The API reportFileName and pdfPassword is array type is to compatible the old system. Please archived one
        report every time. Make sure the report OCR support multiple report!

        :param patient_id: string patient id

        :param patient_name: string patient name

        :param accessionNumber: string exam accession number

        :param report_status: string the report type {'not ready'|'temporary'|'formal'}

        :param file_path: string the report files paths. Make sure the PS server can get the file with paireadmin user.
        suggest use the file in PS disk. example: "path1, path2,......"

        :param pdf_PWD: string the report password if have. Example: "pwd1, pwd2,....."

        :return: Return dict information with function result and all param information.

        Example:

        ${patientinfo} =    Patient Create Randomly

        ${json_object} =    Convert String to JSON    ${patientinfo}

        ${status} =    Get Value From Json    ${json_object}    Status

        Should be True    ${status}[0]    Patient create successfully.

        ${patientID} =    Get Value From Json    ${json_object}    PatientID

        ${AccessionNumber} =    Get Value From Json    ${json_object}    AccessionNumber

        ${PatientName} =    Get Value From Json    ${json_object}    NameCN

        ${Report_type} =    Set Variable    formal

        ${File_path}=     Set Variable    E:\\PUMA_AUTO_Ref\\Cases\\SmokeTest\\4713\\Report\\Performance1.pdf,E:\\PUMA_AUTO_Ref\\Cases\\SmokeTest\\4713\\Report\\Performance1.pdf

        ${PDF_Password} =     Set Variable    ,

        Report Create By Notifyserver Reportinfo    ${PatientName}[0]    ${patientID}[0]    ${AccessionNumber}[0]    ${Report_type}    ${File_path}    ${PDF_Password}


        --ralf wang 19005260
        """
        try:
            webservice_client = Client(self.notify_server_url)
            # print(webservice_client)
            report_status = self.reportstatus_mode_value.get(str(report_status_info).lower())
            if report_status is None:
                print("Report.report_create_by_notifyserver_reportinfo: No this report type [%s]"
                      % (str(report_status_info)))
                print(
                    "Report.report_create_by_notifyserver_reportinfo: report status type should be the key in the dict %s"
                    % (str(self.reportstatus_mode_value)))
                return_content = json.dumps({'result': False, 'patient_name': patient_name, 'patient_id': patient_id,
                                             'accessionNumber': accessionNumber, 'StudyInstanceUID': None,
                                             'report_type': report_status_info, 'report_pats': file_path_list,
                                             'PDF-password': pdf_PWD_list})
                return return_content
            else:
                report_status_int = int(report_status)
                uuid_string = str(uuid.uuid4())
                reportfile_arr = webservice_client.factory.create('ArrayOfString')
                reportfile_arr.string = file_path_list.split(",")

                pdf_PWD_arr = webservice_client.factory.create('ArrayOfString')
                pdf_PWD_arr.string = pdf_PWD_list.split(",")

                # print(patient_name, patient_id, accessionNumber,uuid_string ,report_status_int, reportfile_arr, pdf_PWD_arr)
                result = webservice_client.service.NotifyReportInfo(patient_name, patient_id, accessionNumber,
                                                                    uuid_string,
                                                                    report_status_int, reportfile_arr, pdf_PWD_arr)
                if result == 0:
                    return_content = json.dumps({'result': True, 'patient_name': patient_name, 'patient_id': patient_id,
                                                 'accessionNumber': accessionNumber, 'StudyInstanceUID': uuid_string,
                                                 'report_type': report_status_info, 'report_pats': file_path_list,
                                                 'PDF-password': pdf_PWD_list})

                    print("Report.report_create_by_notifyserver_reportinfo: Report Archived successfully!")
                    return return_content
                else:
                    return_content = json.dumps(
                        {'result': False, 'patient_name': patient_name, 'patient_id': patient_id,
                         'accessionNumber': accessionNumber, 'StudyInstanceUID': uuid_string,
                         'report_type': report_status_info, 'report_pats': file_path_list,
                         'PDF-password': pdf_PWD_list})
                    print(
                        "Report.report_create_by_notifyserver_reportinfo: Report Archived failed! Service return value %d"
                        % result)
                    return return_content
        except Exception as e:
            print("Report.report_create_by_notifyserver_reportinfo: Function execute failed.")
            print(type(e))
            raise Exception(e)

    def report_create_by_printserver_reportinfo(self, patient_name, patient_id, accessionNumber, report_status_info,
                                                file_path_list):
        """report_create_by_printserver_reportinfo

        This function is use the web service[NotifyReportInfo] of PrintServer to send the PDF report to PS.
        The report will archived to system without report OCR service.

        Note: The API reportFileName and pdfPassword is array type is to compatible the old system. Please archived one
        report every time. Make sure the report OCR support multiple report!

        :param patient_id: string patient id

        :param patient_name: string patient name

        :param accessionNumber: string exam accession number

        :param report_status: string the report type {'not ready'|'temporary'|'formal'}

        :param file_path: string the report files paths. Make sure the PS server can get the file with paireadmin user.
        suggest use the file in PS disk. example: "path1, path2,......"

        :return: Return dict information with function result and all param information.

        Example:

        log	Step 1\n Description:\n1. Create a patient with an exam in RIS or local table in PS.\nExpected:\n 1. The patient with an exam can create successfully.

        ${patientinfo} =	Patient Create Randomly

        ${json_object} =	Convert String to JSON	${patientinfo}

        ${status} =	Get Value From Json	${json_object}	Status

        Should be True	${status}[0]	Patient create successfully.

        ${patientID} =	Get Value From Json	${json_object}	PatientID

        ${AccessionNumber} =	Get Value From Json	${json_object}	AccessionNumber

        ${PatientName} =	Get Value From Json	${json_object}	NameCN

        ${Report_type} =	Set Variable	formal

        ${File_path}=	Set Variable	E:\\PUMA_AUTO_Ref\\Cases\\SmokeTest\\4713\\Report\\Performance1.pdf,E:\\PUMA_AUTO_Ref\\Cases\\SmokeTest\\4713\\Report\\Performance1.pdf

        ${Report_archived_Info} =	Report Create By Printserver Reportinfo	${PatientName}[0]	${patientID}[0]	${AccessionNumber}[0]	${Report_type}	${File_path}



        --ralf wang 19005260
        """

        try:
            webservice_client = Client(self.print_server_url)
            report_status = self.reportstatus_mode_value.get(str(report_status_info).lower())

            if report_status is None:
                print("Report.report_create_by_printserver_reportinfo: No this report type [%s]"
                      % (str(report_status_info)))
                print(
                    "Report.report_create_by_printserver_reportinfo: report status type should be the key in the dict %s"
                    % (str(self.reportstatus_mode_value)))
                return_content = json.dumps({'result': False, 'patient_name': patient_name, 'patient_id': patient_id,
                                             'accessionNumber': accessionNumber, 'StudyInstanceUID': None,
                                             'report_type': report_status_info, 'report_pats': file_path_list,
                                             })
                return return_content
            else:
                report_status_int = int(report_status)
                uuid_string = str(uuid.uuid4())
                reportfile_arr = webservice_client.factory.create('ArrayOfString')
                reportfile_arr.string = file_path_list.split(",")

                # print(patient_name, patient_id, accessionNumber,uuid_string ,report_status_int, reportfile_arr, pdf_PWD_arr)
                result = webservice_client.service.NotifyReportInfo(patient_name, patient_id, accessionNumber,
                                                                    uuid_string,
                                                                    report_status_int, reportfile_arr)
                if result == 0:
                    return_content = json.dumps({'result': True, 'patient_name': patient_name, 'patient_id': patient_id,
                                                 'accessionNumber': accessionNumber, 'StudyInstanceUID': uuid_string,
                                                 'report_type': report_status_info, 'report_pats': file_path_list,
                                                 })

                    print("Report.report_create_by_printserver_reportinfo: Report Archived successfully!")
                    return return_content
                else:
                    return_content = json.dumps(
                        {'result': False, 'patient_name': patient_name, 'patient_id': patient_id,
                         'accessionNumber': accessionNumber, 'StudyInstanceUID': uuid_string,
                         'report_type': report_status_info, 'report_pats': file_path_list,
                         })
                    print(
                        "Report.report_create_by_printserver_reportinfo: Report Archived failed! Service return value %d"
                        % result)
                    return return_content
        except Exception as e:
            print("Report.report_create_by_printserver_reportinfo: Function execute failed.")
            print(type(e))
            raise Exception(e)

    def report_check_archive_in_reportinfo_by_UUID(self, StudyInstanceUID):

        """Report_check_archive_in_reportinfo_by_UUID

        This function is used to report information insert to table wggc.dbo.afp_reportinfo after report print
        to PS system with the studyUID.

        :param StudyInstanceUID: The parameter is the studyinstanUID which used in NotifyReportInfo or  NotifyReportfile
        API of Notifyserver or print server. Not the real value in database. The parameter will process with MD5.


        :return: Json string with result and  other information.

        Ralf wang 19005260
        """

        try:
            result_dict = {}
            md5_object = hashlib.md5()
            md5_object.update(StudyInstanceUID.encode())
            StudyInstanceUID = md5_object.hexdigest().upper()
            # print(StudyInstanceUID)
            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            cursor.execute('''SELECT ReportStatus
                                FROM wggc.dbo.AFP_ReportInfo 
                                WHERE StudyInstanceUID = ?
                                ''', [str(StudyInstanceUID)])
            rows = cursor.fetchall()
            conn.close()
            if len(rows) != 1:
                print("Report.Report_check_archive_by_studyUID: Data Exception! There are [%d] records in "
                      "the wggc.dbo.AFP_Reportinfo Table with StudyInstanceUID: [%s]"
                      % (len(rows), StudyInstanceUID))
                result_dict['result'] = False
                return json.dumps(result_dict)
            else:
                str_ReportStatus = str(rows[0][0])
                if str_ReportStatus == '2':
                    print(
                        "Report.Report_check_archive_by_studyUID: The report archived successfully and the ReportStatus value "
                        "in wggc.dbo.afp_reportinfo is [%s]" % (str_ReportStatus))
                    result_dict['result'] = True
                    result_dict['ReportStatus'] = str_ReportStatus
                    return json.dumps(result_dict)
                else:
                    print(
                        "Report.Report_check_archive_by_studyUID: The report archived failed and the ReportStatus value "
                        "in wggc.dbo.afp_reportinfo is [%s]" % (str_ReportStatus))
                    result_dict['result'] = False
                    result_dict['ReportStatus'] = str_ReportStatus
                    return json.dumps(result_dict)
        except Exception as e:
            print("Report.Report_check_archive_by_studyUID: Function execute failed.")
            print(type(e))
            raise Exception(e)

    def report_check_ReportStoredFlag_in_T_Integration_ExamInfo(self, patientID, accession_number):
        """report_check_ReportStoredFlag_in_T_Integration_ExamInfo

        This function is to query the reportStatusFlag value from wggc.dbo.T_Integration_ExamInfo table.
        If queried record count will return True else return False.

        :param patientID: The report patient ID which print or archived in the PS.


        :param accession_number: The report accession number which printed or archived in the PS


        :return: json type with bool and int data like {"result": true, "ReportStoredFlag": 9}

        --Ralf Wang 19005260
        """

        try:
            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            cursor.execute('''SELECT ReportStoredFlag
                                        FROM wggc.dbo.T_Integration_ExamInfo 
                                        WHERE PatientID = ? and AccessionNumber = ?
                                        ''', [str(patientID), str(accession_number)])
            rows = cursor.fetchall()
            conn.close()
            result_dict = {}
            if len(rows) != 1:
                print("Report.report_check_ReportStoredFlag_in_T_Integration_ExamInfo: Data Exception for the patient "
                      "[%s, %s]" % (str(patientID), str(accession_number)))
                result_dict['result'] = False
                return json.dumps(result_dict)
            else:
                print(
                    "Report.report_check_ReportStoredFlag_in_T_Integration_ExamInfo: Get the ReportStoredFlag of patient "
                    "[%s, %s] correct and value is %s" % (str(patientID), str(accession_number), str(rows[0][0])))
                result_dict['result'] = True
                result_dict['ReportStoredFlag'] = rows[0][0]
                return json.dumps(result_dict)
        except Exception as e:
            print("Report.report_check_ReportStoredFlag_in_T_Integration_ExamInfo: Function execute failed.")
            print(type(e))
            raise Exception(e)

    def report_get_info_from_afp_reportinfo(self, patientid, accession_number):
        """report_get_info_from_afp_reportinfo

        This function is return all database data query from wggc.dbo.afp_reportinfo with PID ana ACCN.
        If no data return , return false. if data count >=1 return true with data

        :param patientid: The exam patient id.

        :param accession_number: The exam accession number.


        :return: json string with bool result and all query data

        -- Ralf Wang 19005260
        """
        '''
        Get the cloumn name of wggc.dbo.afp_printmode table
        '''
        try:
            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            cursor.execute('''SELECT COLUMN_NAME
                            FROM INFORMATION_SCHEMA.COLUMNS
                            WHERE TABLE_NAME = N'AFP_ReportInfo'
                            ''')
            rows = cursor.fetchall()
            conn.close()
            table_column_name_list = []
            result_dict = {}
            for i in range(len(rows)):
                table_column_name_list.append(rows[i][0])

            print(table_column_name_list)
            '''
            Get the data which query from wggc.dbo.afp_printmode by accession number
            '''
            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            cursor.execute('''SELECT * 
                        FROM wggc.dbo.AFP_ReportInfo 
                        WHERE AccessionNumber = ? 
                        AND Patientid = ? 
                        ORDER BY CreatedTime DESC
                            ''', [str(accession_number), str(patientid)])
            rows = cursor.fetchall()
            conn.close()
            reportinfo_value_list = []

            if len(rows) < 1:
                print("Report.report_get_info_from_afp_reportinfo: Data Exception for the exam "
                      "[%s] in wggc.dbo_afp_reportinfo table" % (str(accession_number)))
                print("Report.report_get_info_from_afp_reportinfo:: There are [%d] records in table"
                      % (len(rows)))
                result_dict['result'] = False
                return json.dumps(result_dict)
            else:
                '''
                Merage column name and date to dict
                '''
                all_value_list = []
                row_value_list = []
                for rowindex in range(len(rows)):
                    for colindex in range(len(rows[rowindex])):
                        value = rows[rowindex][colindex]
                        if isinstance(value, datetime):
                            value = str(value)
                        row_value_list.append(value)
                    all_value_list.append(row_value_list)

                new_value_list = list(zip(*all_value_list))

                result_dict['result'] = True
                result_dict.update(dict(zip(table_column_name_list, new_value_list)))
                print(result_dict)
                return json.dumps(result_dict)
        except Exception as e:
            print("Report.report_get_info_from_afp_reportinfo: Function execute failed.")
            print(type(e))
            raise Exception(e)

    '''
    This methond will repleace the PID and ACCN content with report class property.
    Create a new report with the parameters.
    '''

    def _create_report_with_template(self):
        try:
            if os.path.isfile(self.report_template_file):
                with open(self.report_template_file, "r", encoding='UTF-8') as report_template_file:
                    content = report_template_file.read()
                    report_template_file.close()

                content = content.replace("PID", self.patient_id).replace("ACCN", self.accession_number)
                with open(self.report_file, "w+", encoding='UTF-8') as report_file:
                    report_file.write(content)
                    report_file.close()
            else:
                raise Exception(
                    "PUMA_ReportLibrary.create_report_with_sample:  The template report files is not exist: \n %s"
                    % (self.report_template_file))
        except Exception as e:
            print("PUMA_ReportLibrary.create_report_with_sample: Function execute failed.")
            print(type(e))
            raise Exception(e)

    '''
    Print the parameted report file to default printer.
    The default printer is set in the configuration file
    '''

    def _print_report_from_template(self):
        try:
            if os.path.isfile(self.report_file):
                # Jenkins cannot execute this code successfully, will try to use other function
                '''
                default_printer = win32print.GetDefaultPrinter()
                if default_printer != self.default_printer:
                    print("PUMA_ReportLibrary.print_report_from_template:"
                          "The default printer is not PDFCreator! Will reset.")
                    win32print.SetDefaultPrinter(self.default_printer)

                
                result = win32api.ShellExecute(0, "Print", self.report_file, None, ".", 0)
                print("PUMA_ReportLibrary.print_report_from_template: Win32print result is %d", result)
                '''
                self._convert_report_to_PDF()
                self._copy_file_to_share_folder(self.pdf_report_path, self.PS_report_shared_folder)
            else:
                raise Exception("PUMA_ReportLibrary.print_report_from_template: The report file is not exist: \n %s"
                                % (self.report_file))
        except Exception as e:
            print("PUMA_ReportLibrary.print_report_from_template: Function execute failed.")
            print(type(e))
            raise Exception(e)

    '''
    THis methond is to check the report archived to PS successfully or not.
    Query the data from database and return bool value.
    '''

    def _archive_check(self, patient_id, accession_number, exist_UID):

        '''
        if str(exist_UID)[-2] == ',':
            str_exist_UID = str(exist_UID)[-2] = ""
        else:
            str_exist_UID = str(exist_UID)
        '''
        try:
            str_exist_UID = str(exist_UID).replace(",)", ")")

            if len(exist_UID) > 0:
                sql_text = "Select ReportStatus From wggc.dbo.AFP_ReportInfo  " \
                           "WHERE StudyInstanceUID not in " + str_exist_UID + \
                           " AND PatientID = '" + str(patient_id) + "'" + \
                           " AND AccessionNumber = '" + str(accession_number) + "'"
                print(sql_text)
                # conn = pyodbc.connect('DRIVER={SQL Server}; SERVER=10.112.20.84\GCPACSWS;DATABASE=wggc; UID=sa;PWD=sa20021224$')
                conn = pyodbc.connect(settings.db_connectString)
                cursor = conn.cursor()
                cursor.execute(sql_text)
                rows = cursor.fetchall()
                conn.close()
                print(rows)
                if len(rows) == 1:
                    if rows[0][0] == 2:
                        print("PUMA_ReportLibrary._archive_check: Report achived successfully.")
                        return True
                    else:
                        return False
                else:
                    return False
            else:
                conn = pyodbc.connect(settings.db_connectString)
                cursor = conn.cursor()
                cursor.execute('''Select ReportStatus
                                               From wggc.dbo.AFP_ReportInfo 
                                               WHERE PatientID = ? 
                                               AND AccessionNumber = ?
                                               ''', [patient_id, accession_number])
                rows = cursor.fetchall()
                conn.close()
                if len(rows) == 1:
                    if rows[0][0] == 2:
                        print("PUMA_ReportLibrary._archive_check: Report achived successfully.")
                        return True
                    else:
                        return False
                else:
                    return False
        except Exception as e:
            print("PUMA_ReportLibrary._archive_check: Function execute failed.")
            print(type(e))
            raise Exception(e)

    '''Notice, get the exist report UID'''

    def _get_exist_report_instanceUID(self, patient_id="", accession_number=""):
        try:
            sql_txt = "Select StudyInstanceUID From wggc.dbo.AFP_ReportInfo WHERE "
            if patient_id != "":
                sql_txt = sql_txt + "PatientID = '" + patient_id + "' "
                if accession_number != "":
                    sql_txt = sql_txt + "AND AccessionNumber = '" + accession_number + "' "
            else:
                sql_txt = sql_txt + "AccessionNumber = '" + accession_number + "' "
                if accession_number == "":
                    raise Exception("PUMA_ReportLibrary._get_exist_report_instanceUID: "
                                    "The patientid and accession number cannot empty at same time.")

            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            cursor.execute(sql_txt)
            rows = cursor.fetchall()
            conn.close()
            instanceUID_tuple = ()
            if len(rows) >= 1:
                for index in range(len(rows)):
                    instanceUID_tuple += tuple(str(rows[index][0]).split("#$%"))
            return instanceUID_tuple
        except Exception as e:
            print("PUMA_ReportLibrary._get_exist_report_instanceUID: Function execute failed.")
            print(type(e))
            raise Exception(e)

    def _convert_report_to_PDF(self):
        '''
        Convert the exist report file to PDF file
        :return:
        '''
        try:
            self._clean_PDFfiles()
            ptr = open(self.report_file, "r", encoding="UTF-8")
            content = ptr.read()
            ptr.close()
            line_count = 0

            pdf_report_path = self.pdf_report_folder + str(self.patient_id)[0:15] + ".pdf"
            canvas_obj = canvas.Canvas(pdf_report_path)
            canvas_obj.setFont("ms song", 10)
            canvas_obj.setPageSize(A4)

            for text in content.split("\n"):
                #print(text)
                canvas_obj.drawString(15, 800 - line_count * 1.5, text)
                line_count += 10
            canvas_obj.showPage()
            canvas_obj.save()

            if os.path.isfile(pdf_report_path):
                print("PUMA_ReportLibrary._convert_report_to_PDF: "
                      "The PDF file create successfully. [%s]" % pdf_report_path)
                self.pdf_report_path = pdf_report_path
                return True
            else:
                print("PUMA_ReportLibrary._convert_report_to_PDF: "
                      "The PDF file create failed. [%s]" % pdf_report_path)
                return False
        except Exception as e:
            print("PUMA_ReportLibrary._convert_report_to_PDF: Function execute failed.")
            print(type(e))
            raise Exception(e)


    def _clean_PDFfiles(self):
        '''
        Clean the PDF files in report sample folder
        :return: N/A
        '''
        try:
            for root, dirs, files in os.walk(self.pdf_report_folder):
                for name in files:
                    if name.endswith(".pdf"):
                        os.remove(os.path.join(root, name))
                        print("Delete File: " + os.path.join(root, name))
        except Exception as e:
            print("PUMA_ReportLibrary._clean_PDFfiles: Function execute failed.")
            print(type(e))
            raise Exception("PUMA_ReportLibrary._clean_PDFfiles: Function execute failed." + e)

    def _copy_file_to_share_folder(self, source, shared):
        '''
        Copy a file to net work shared folder
        :param source:
        :param shared:
        :return:
        '''
        try:
            if os.path.isfile(source):
                #cmd_text = "net use " + os.path.join(shared,'') + " /user:administrator"
                #print(cmd_text)
                #output = subprocess.check_output(cmd_text, stdout=subprocess.STDOUT, shell=True)

                cmd_shared_folder_path = r"\\"
                path_words_list = str(shared).split("\\")
                print(path_words_list)
                for index in range(len(path_words_list)):
                    path_words = path_words_list[index]
                    if path_words != "" and index < len(path_words_list)-1:
                        cmd_shared_folder_path = cmd_shared_folder_path + path_words + '\\'

                cmd_shared_folder_path = cmd_shared_folder_path + path_words_list[-1]


                cmd_text = "net use " + cmd_shared_folder_path + " /user:administrator"
                output = subprocess.check_output(cmd_text, shell=False)

                #output = os.system("net use " + cmd_shared_folder_path + " /user:administrator" )
                print(output.decode('GBK'))

                if "命令成功完成" in output.decode('GBK'):
                    #cmd_copy_text = "copy " + source + " " + shared + "\\" + " /Y"
                    #print(cmd_copy_text)
                    output = subprocess.check_output(["copy", source, shared + "\\","/Y"],  shell=True)
                    print(output.decode("GBK"))

                    if "已复制" in output.decode("GBK"):
                        print("PUMA_ReportLibrary._copy_file_to_share_folder: "
                              "The file copy successfully.")
                        return True
                    else:
                        raise Exception("PUMA_ReportLibrary._copy_file_to_share_folder: "
                              "The file copy failed.[%s] to [%s]" % source, shared)
                        return False
                else:
                    raise Exception("PUMA_ReportLibrary._copy_file_to_share_folder: "
                                    "The shared folder is not exist! [%s] or you have no rigt to vist the folder"
                                    % shared)
            else:
                raise Exception("PUMA_ReportLibrary._copy_file_to_share_folder: "
                                "The file is not exist! [%s] " % source)
        except Exception as e:
            print("PUMA_ReportLibrary._copy_file_to_share_folder: Function execute failed.")
            print(type(e))
            raise Exception(e)




# ***********************************************Sample*******************************************************''
'''
report = Report()

patient = Patient()
response = patient.patient_create_randomly()
myjson = json.loads(response)
PID = myjson["PatientID"]
ACCN = myjson["AccessionNumber"]
report.report_create_report_with_sample(PID, ACCN)



# report = Report()

# report._get_exist_report_instanceUID(patient_id="P20190924140239208696", accession_number="A20190924140239208696")
# report.report_create_report_with_sample("P20190924140239208696","A20190924140239208696")
# time.sleep(10)
# report._archive_check("P20190924140239208696", "A20190924140239208696")


print(report.report_check_file_exist_by_path_remote("E:\\Report\Archive\\20190906\\A20190906204051801198_204059_899d9e041ad44e619911762400e505b7.pdf"))


report.report_get_info_from_afp_reportinfo("P20190902143333810747", "A20190902143333810747")


conn = pyodbc.connect(settings.db_connectString)
cursor = conn.cursor()
cursor.execute(SELECT top 2 * 
                    FROM wggc.dbo.AFP_PrintMode 
                    )
rows = cursor.fetchall()
conn.close()

all_value_list = []
row_value_list = []
for rowindex in range(len(rows)):
    for colindex in range(len(rows[rowindex])):
        value = rows[rowindex][colindex]
        if isinstance(value, datetime):
            value = str(value)
        row_value_list.append(value)
    all_value_list.append(row_value_list)


print(all_value_list)

print(list(zip(*all_value_list)))


Example
report = Report()
patient = Patient()
response = patient.patient_create_randomly()

response_json = json.loads(response, object_hook=lambda d: namedtuple('json_patient', d.keys())(*d.values()))
print(response_json)
report.report_create_by_printserver_reportinfo('CN20190830183432749767','P20190830183432749767','A20190830183432749767','formal',"E:\\PUMA_AUTO_Ref\\Cases\\SmokeTest\\4713\\Report\\Performance1.pdf,E:\\PUMA_AUTO_Ref\\Cases\\SmokeTest\\4713\\Report\\Performance2.pdf",)

film = Film()
film.film_create_film_with_sample(response_json.PatientID, response_json.AccessionNumber)


report = Report()
report.report_create_by_notifyserver_reportinfo(
    'CN20190830183432749767','P20190830183432749767','A20190830183432749767','formal',"E:\\PUMA_AUTO_Ref\\Cases\\SmokeTest\\4713\\Report\\Performance1.pdf,E:\\PUMA_AUTO_Ref\\Cases\\SmokeTest\\4713\\Report\\Performance2.pdf",
    ",")
#report.report_create_report_with_sample("11111","22222")
'''
