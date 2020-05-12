# -*- coding : utf-8 -*-
'''
Designer: Ralf wang
Mail:   hao.wang@carestream.com
Date: 2019-07-19
Reviewer:
Design the patient related methond
'''

import json
from datetime import datetime

import pyodbc
import requests
from bs4 import BeautifulSoup

from PUMA_ParameterAndSettings.Configurationlib import Configurationlib

'''
Create a Patient class, all patient related method and property will design in this class
'''

settings = Configurationlib()


class Patient(object):
    def __init__(self):
        self.Status = ""
        self.CreateDT = ""
        self.UpdateDT = ""
        self.PatientID = ""
        self.AccessionNumber = ""
        self.StudyInstanceUID = ""
        self.NameCN = ""
        self.NameEN = ""
        self.Gender = ""
        self.Birthday = ""
        self.Modality = ""
        self.ModalityName = ""
        self.PatientType = ""
        self.VisitID = ""
        self.RequestID = ""
        self.RequestDepartment = ""
        self.RequestDT = ""
        self.RegisterDT = ""
        self.ExamDT = ""
        self.ReportDT = ""
        self.SubmitDT = ""
        self.ApproveDT = ""
        self.PDFReportURL = ""
        self.StudyStatus = ""
        self.OutHospitalNo = ""
        self.InHospitalNo = ""
        self.PhysicalNumber = ""
        self.ExamName = ""
        self.ExamBodyPart = ""
        self.RefferingDepartment = ""
        self.Optional0 = ""
        self.Optional1 = ""
        self.Optional2 = ""
        self.Optional3 = ""
        self.Optional4 = ""
        self.Optional5 = ""
        self.Optional6 = ""
        self.Optional7 = ""
        self.Optional8 = ""
        self.Optional9 = ""
        self.notifyserver_url = "http://%s/NotifyServer/NotifyService.asmx" % (settings.server)

    # @keyword('create patient with random information')
    def patient_create_randomly(self):
        """create patient with random information

        This function will create the patient/exam in vi_KIOSK_ExamInfo_Order table in WGGC database.

        The patient id will set as P with 20 characters which come from current date time.

        The Accession number  will set as A with 20 characters which come from current date time.

        Other information will use random value or default values.

        The function will return all exam information as json string.

        You can use robot framework json library to get any values as you want.


        --Ralf wang 19005260
        """

        '''
        Get the datetime with format, used for datatime for exam datetime columns.
        The format like: 2019-07-26 10:52:56.375252
        '''
        date_time = str(datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f'))
        '''
        Get the datetime and use for create unquie string for patientid or accession number.
        The format like: 20190726110210398652
        '''
        datetime_stamp = str(datetime.now().strftime('%Y%m%d%H%M%S'))

        self.CreateDT = date_time
        self.UpdateDT = date_time
        self.PatientID = "P" + datetime_stamp
        self.AccessionNumber = "A" + datetime_stamp
        self.StudyInstanceUID = "UID" + datetime_stamp
        self.NameCN = "CN" + datetime_stamp
        self.NameEN = "EN" + datetime_stamp
        self.Gender = settings.random_gender()
        self.Birthday = settings.random_brithday()
        self.Modality = settings.random_modality()
        self.ModalityName = settings.random_modality()
        self.PatientType = "门诊病人"
        self.VisitID = ""
        self.RequestID = ""
        self.RequestDepartment = 1
        self.RequestDT = date_time
        self.RegisterDT = date_time
        self.ExamDT = date_time
        self.ReportDT = date_time
        self.SubmitDT = date_time
        self.ApproveDT = date_time
        self.PDFReportURL = ""
        self.StudyStatus = ""
        self.OutHospitalNo = ""
        self.InHospitalNo = ""
        self.PhysicalNumber = ""
        self.ExamName = "Exam" + datetime_stamp
        self.ExamBodyPart = settings.random_bodypart()
        self.RefferingDepartment = ""
        self.Optional0 = ""
        self.Optional1 = ""
        self.Optional2 = ""
        self.Optional3 = ""
        self.Optional4 = ""
        self.Optional5 = ""
        self.Optional6 = ""
        self.Optional7 = ""
        self.Optional8 = ""
        self.Optional9 = ""
        try:
            body = self.exam_replace_parameter(settings.notifyserver_exam_body_content)
            headers = {'Content-Type': 'application/soap+xml;charset = utf-8', 'Content-Length': str(len(body))}
        except Exception as e:
            print("Patient.patient_create_randomly: Init the http body and header failed.")
            print(type(e))
            raise Exception(e)

        try:
            respose = requests.post(url=self.notifyserver_url, data=body, headers=headers)
            # print("Patient.patient_create_randomly:API response message:\n %s" % (respose.text))
        except requests.HTTPError as e:
            status_code = e.response.status_code
            print("Patient.patient_create_randomly:The Http return code is:\n " + (str(status_code)))
            print(type(e))
            raise Exception("Patient.patient_create_randomly:The Http response is: \n" + str(
                respose.content.decode('utf-8', 'ignore')))

        try:
            soup = BeautifulSoup(respose.text.encode(), "xml")
            NotifyExamInfoResult = soup.NotifyExamInfoResult.text
            if respose.status_code == 200 and NotifyExamInfoResult == 'true':
                self.Status = True
                return_content = json.dumps(self.__dict__)
                print("Patient.patient_create_randomly:Patient create successfully.\n %s" % (return_content))
                return return_content
            else:
                return False, 'N/A', 'N/A'
        except Exception as e:
            print("Patient.patient_create_randomly: Get the resopnse from the return XML files.")
            print(type(e))
            raise Exception(e)

    def patient_delete_by_pid_accn(self, pid, accn):
        """patient delete by pid accn

        This function will delete the records from wggc.dbo.vi_KIOSK_ExamInfo_Order with parameters.

        :param pid: patientID of patient or exam which you want to delete.

        :param accn: accession number of patient which you want to delete.

        :return: bool value True|False

        --Ralf wang 19005260
        """
        try:
            self.AccessionNumber = accn
            self.PatientID = pid
            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            rowsdeleted = cursor.execute('''DELETE 
                                            FROM wggc.dbo.vi_KIOSK_ExamInfo_Order
                                            WHERE PatientID = ?
                                            AND AccessionNumber = ? 
                                            ''', [self.PatientID, self.AccessionNumber]).rowcount
            conn.commit()
        except Exception as e:
            print("Patient.patient_delete_by_pid_accn: Try to delete the patient information from "
                  "table wggc.dbo.vi_KIOSK_ExamInfo_Order in database failed.")
            print(type(e))
            raise Exception(e)

        if rowsdeleted > 0:
                print("Patient.patient_delete_by_pid_accn: [%d] records will deleted." % (rowsdeleted))
                return True
        else:
                print("Patient.patient_delete_by_pid_accn: No records found.")
                return False




    def exam_replace_parameter(self, content):
        """replace exam parameter

        replace the parameters for notifyserver.exam web service;
        Use replace function change them one by one.
        The function is used for other keyword.
        Please not used it as key words in robot framework.


        --ralf wang 19005260
         """
        try:
            return_content = content \
                .replace('{CreateDT}', self.CreateDT) \
                .replace('{UpdateDT}', self.UpdateDT) \
                .replace('{PatientID}', self.PatientID) \
                .replace('{AccessionNumber}', self.AccessionNumber) \
                .replace('{StudyInstanceUID}', self.StudyInstanceUID) \
                .replace('{NameCN}', self.NameCN) \
                .replace('{NameEN}', self.NameEN) \
                .replace('{Gender}', self.Gender) \
                .replace('{Birthday}', self.Birthday) \
                .replace('{Modality}', self.Modality) \
                .replace('{ModalityName}', self.ModalityName) \
                .replace('{PatientType}', str(self.PatientType)) \
                .replace('{VisitID}', self.VisitID) \
                .replace('{RequestID}', self.RequestID) \
                .replace('{RequestDepartment}', str(self.RequestDepartment)) \
                .replace('{RequestDT}', self.RequestDT) \
                .replace('{RegisterDT}', self.RegisterDT) \
                .replace('{ExamDT}', self.ExamDT) \
                .replace('{ReportDT}', self.ReportDT) \
                .replace('{SubmitDT}', self.SubmitDT) \
                .replace('{ApproveDT}', self.ApproveDT) \
                .replace('{PDFReportURL}', self.PDFReportURL) \
                .replace('{StudyStatus}', self.StudyStatus) \
                .replace('{OutHospitalNo}', self.OutHospitalNo) \
                .replace('{InHospitalNo}', self.InHospitalNo) \
                .replace('{PhysicalNumber}', self.PhysicalNumber) \
                .replace('{ExamName}', self.ExamName) \
                .replace('{ExamBodyPart}', self.ExamBodyPart) \
                .replace('{RefferingDepartment}', self.RefferingDepartment) \
                .replace('{Optional0}', self.Optional0) \
                .replace('{Optional1}', self.Optional1) \
                .replace('{Optional2}', self.Optional2) \
                .replace('{Optional3}', self.Optional3) \
                .replace('{Optional4}', self.Optional4) \
                .replace('{Optional5}', self.Optional5) \
                .replace('{Optional6}', self.Optional6) \
                .replace('{Optional7}', self.Optional7) \
                .replace('{Optional8}', self.Optional8) \
                .replace('{Optional9}', self.Optional9) \
                .encode('UTF-8')
            return return_content
        except Exception as e:
            print("Patient.exam_replace_parameter: try tp replace the parameters failed.")
            print(type(e))
            raise Exception(e)


#*********************************Sample Code*******************************
'''
patient = Patient()
patient.patient_create_randomly()
'''
