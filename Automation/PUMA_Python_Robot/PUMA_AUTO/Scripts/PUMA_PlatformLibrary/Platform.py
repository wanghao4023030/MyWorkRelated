# -*- coding : utf-8 -*-
'''
Designer: Ralf wang
Mail:   hao.wang@carestream.com
Date: 2019-08-07
Reviewer:
Design the report class and include related methond.
'''

import json
from collections import OrderedDict

import requests
import re
from datetime import datetime
import pyodbc
import operator
import xmltodict
import time

null = None
from PUMA_ParameterAndSettings.Configurationlib import Configurationlib

settings = Configurationlib()


class Platform(object):

    def __init__(self):
        self.connect_string = settings.db_connectString
        self.user = ""
        self.password = ""
        self.cookies = ""
        self.auth_string = ""
        self.url = settings.Platform_URL.replace("{server}", settings.server)
        self.url_login = self.url + "/account/login"
        self.url_logout = self.url + "/account/logOff"
        self.headers = ""
        self.Platform_webapi_worklist_searchWorklist_url = settings.Platform_webapi_worklist_searchWorklist_url \
            .replace("{server}", settings.server)
        self.Platform_webapi_worklist_searchWorklist_string = settings.Platform_webapi_worklist_searchWorklist_string
        self.worklist_query_db_column = ["accessionNumber", "patientID", "patientName", "studyDate", "studyTime",
                                         "patientSex",
                                         "patientType", "holdFlag", "printMode", "examName", "bodayPart",
                                         "filmPrintStatus", "filmPrintTime", "filmDeleteStatus", "imageCount",
                                         "reportStatus", "reportPrintStatus", "reportPrintTime", "reportCount",
                                         "modality", "deleteStatus", "completeStatus", "callingAE", "reportInfos",
                                         "filmInfos"]
        self.patient_type = {'门诊病人': '2', '住院病人': '1', '体检病人': '3', '急诊病人': '4', '其他': '5'}
        self.platform_webapi_worklist_saveShortcut = \
            settings.Platform_webapi_worklist_saveShortcut.replace("{server}", settings.server)

        self.Platform_webapi_worklist_delete_shortcut_url = settings.Platform_webapi_worklist_delete_shortcut_url \
            .replace("{server}", settings.server)
        self.Platform_webapi_worklist_delete_shortcut_bodystring = \
            settings.Platform_webapi_worklist_delete_shortcut_bodystring
        self.Platform_webapi_worklist_searchWorklist_shortcut_string = \
            settings.Platform_webapi_worklist_searchWorklist_shortcut_string
        self.Platform_webapi_worklist_centralPrint_url = \
            settings.Platform_webapi_worklist_centralPrint_url.replace("{server}", settings.server)
        self.Platform_webapi_worklist_centralPrint_body_string = \
            settings.Platform_webapi_worklist_centralPrint_body_string
        self.Platform_account_check_loginStatus_url = \
            settings.Platform_account_check_loginStatus_url.replace("{server}", settings.server)
        self.Platform_webapi_worklist_printEstimateTime_url = \
            settings.Platform_webapi_worklist_printEstimateTime_url.replace("{server}", settings.server)
        self.Platform_webapi_worklist_printstatus_url = \
            settings.Platform_webapi_worklist_printstatus_url.replace("{server}", settings.server)
        self.Platform_webapi_worklist_searchWorklist_string = \
            settings.Platform_webapi_worklist_searchWorklist_string

    '''
    ************************************************************
    Login and logout
    ************************************************************
    '''

    def platform_login_user_pwd(self, user, pwd):
        """platform_login_user_pwd
        This function is use the user and password to login the platform web site. Please be sure the user is not the
        first time.

        :param user: The user name which exist in the web site.


        :param pwd: The password of the user


        :return: return boolean value and set the web headers

        -- Ralf Wang 19005260
        """
        res = requests.get(self.url)
        if res.status_code != 200:
            print("Platform.platform_login_user_pwd: The web site can not visit, please check the environment: [%s]"
                  % (self.url))
        else:
            url = self.url_login
            self.user = user
            self.password = pwd
            json_data = {"loginname": self.user, "password": self.password}
            res = requests.post(url, data=json_data)

            if res.status_code == 200:
                res_json = json.loads(res.text)
                login_message = res_json.get('Message')

                if login_message == 'LoginSuccess':
                    print("Platform.platform_login_user_pwd: The user login in successfully. [%s, %s]"
                          % (self.user, self.password))
                    self.headers = res.headers
                    self.cookies = res.headers.get('Set-Cookie')
                    print(self.cookies)
                    auth_string = re.search(r'(?<=access_token%22%3A%22)[\s\S]*(?=%22%2C%22token_type)', self.cookies)
                    self.auth_string = auth_string.group()
                    return True
                else:
                    print("Platform.platform_login_user_pwd: The user login in failed. [%s, %s]"
                          % (self.user, self.password))
                    return False

            else:
                print("Platform.platform_login_user_pwd: The user login in failed. [%s, %s]"
                      % (self.user, self.password))
                print(res.text)
                return False

    def platform_logout(self):
        """platform_logout_user_pwd
        This function is use the user and password to logout the platform web site. Please be sure the user is not the
        first time.

        :param user: The user name which exist in the web site.


        :param pwd: The password of the user


        :return: return boolean value and set the web headers

        -- Ralf Wang 19005260
        """
        res = requests.get(self.url)
        if res.status_code != 200:
            print("Platform.platform_login_user_pwd: The web site can not visit, please check the environment: [%s]"
                  % (self.url))
        else:
            url = self.url_logout
            res = requests.get(url)

            if res.status_code == 200:
                print("Platform.platform_logout: Logoff successfully.")
                # print(res.text)
                return True
            else:
                print("Platform.platform_logout: Logoff failed.]"
                      % (self.user, self.password))
                print(res.text)
                return False

    '''
    *******************************************************************************************************************
    Worklist related function
    *******************************************************************************************************************
    '''

    '''
    Query related function
    '''

    def platform_worklist_fuzzy_query_by_patientID(self, str_patientID):
        """platform_worklist_fuzzy_query_by_patientID

        Fuzzy Query the data from API and database by parameter: patientid. Compare the data count and content.
        If equal betwwen two values, return true, other return False.

        :param str_patientID:

        :return: boolean

        --Ralf Wang 19005260
        """

        result = self._worklist_search_worklist(isFuzzy=True, patientID=str_patientID)
        pagination_dict = result['pagination']
        query_count = pagination_dict['totalCount']
        page_size = pagination_dict['pageSize']
        page_count = query_count // page_size + 1
        '''
        Use api to get the first page information , get the page size and totalcount
        Vist each page data and organize the data to a list.
        '''
        worklistDto_list = []
        for i in range(page_count):
            pagination = {"pageIndex": i + 1, "pageSize": page_size}
            result_each_page = self._worklist_search_worklist(isFuzzy=True, pagination=pagination,
                                                              patientID=str_patientID)
            worklistDto_list += result_each_page["worklistDto"]

        '''
        Delete the +08:00 and T chars in reportprinttime and filmprinttime.
        Format the string for compare operation late.
        '''
        for index in range(len(worklistDto_list)):
            for key, value in worklistDto_list[index].items():
                if "+08:00" in str(worklistDto_list[index][key]):
                    new_value = str(worklistDto_list[index][key]).replace("T", " ").replace("+08:00", "")
                    if len(new_value) < 23:
                        if "." in new_value:
                            for count in range(23 - len(new_value)):
                                new_value = new_value + "0"
                        else:
                            new_value = new_value + "."
                            for count in range(23 - len(new_value)):
                                new_value = new_value + "0"
                    worklistDto_list[index][key] = new_value

        '''
        Query the data from database
        '''
        worklist_query_db_col = self.worklist_query_db_column
        sql_query = r"SELECT AccessionNumber,PatientID,PatientName,CONVERT(varchar, CreatedTime, 23) as studyDate," \
                    r"CONVERT(varchar, CreatedTime, 24) as studyTime,PatientSex,PatientType,HoldFlag," \
                    r"PrintMode,ExamName,BodyPart,FilmPrintStatus,convert(varchar, FilmPrintTime, 121)," \
                    r"DeleteStatus as filmDeleteStatus," \
                    r"ImageCount,ReportStatus,ReportPrintStatus,convert(varchar, ReportPrintTime, 121),ReportCount," \
                    r"Modalities,DeleteStatus," \
                    r"CompleteStatus,CallingAE,null as reportInfos , null as filmInfos  " \
                    r"FROM wggc.dbo.AFP_ExamInfo " \
                    r"WHERE PatientID like '%{pid}%' " \
                    r"AND DeleteStatus = 0 " \
                    r"ORDER BY CreatedTime DESC "
        sql_query = sql_query.replace("{pid}", str(str_patientID))
        conn = pyodbc.connect(self.connect_string)
        cursor = conn.cursor()
        cursor.execute(sql_query)
        rows = cursor.fetchall()
        conn.close()

        '''
        Organize the queried data to dict with the define column propery.
        The column name should consistent with the API format.
        '''
        data_from_DB = []
        for row in range(len(rows)):
            # print(rows[row])
            temp_dict = {}
            for col in range(len(rows[row])):
                key = worklist_query_db_col[col]
                value = rows[row][col]
                temp_dict[key] = value
            data_from_DB.append(temp_dict)

        '''
        compare the data between API and database:
        '''
        if len(worklistDto_list) == len(data_from_DB):
            print("Platform.platform_worklist_fuzzy_query_by_patientID: There are [%s] rows data queried out."
                  % (len(data_from_DB)))
            if operator.eq(worklistDto_list, data_from_DB):
                print("Platform.platform_worklist_fuzzy_query_by_patientID: The query data is correct!")
                return True
            else:
                for index in range(len(worklistDto_list)):
                    if operator.eq(worklistDto_list[index], data_from_DB[index]):
                        pass
                        # print("correct")
                    else:
                        for key, value in dict(worklistDto_list[index]).items():
                            if worklistDto_list[index][key] == data_from_DB[index][key]:
                                pass
                            else:
                                print("Platform.platform_worklist_fuzzy_query_by_patientID: The data is not equal!")
                                print("Platform.platform_worklist_fuzzy_query_by_patientID: From API: \n %s"
                                      % (worklistDto_list[index]))
                                print("Platform.platform_worklist_fuzzy_query_by_patientID: From database: \n %s"
                                      % (data_from_DB[index]))
                                print(key + " : [" \
                                      + worklistDto_list[index][key] + "]  -   [" + data_from_DB[index][key] + "]")
                        return False


        else:
            print("Platform.platform_worklist_fuzzy_query_by_patientID: The data count from API are [%s]."
                  % (len(worklistDto_list)))
            print("Platform.platform_worklist_fuzzy_query_by_patientID: The data count from database are [%s]."
                  % (len(data_from_DB)))
            raise Exception("Platform.platform_worklist_fuzzy_query_by_patientID: The data count is not equaled.")

    def platform_worklist_fuzzy_query_by_accn(self, str_accn):
        """platform_worklist_fuzzy_query_by_accn

        Fuzzy Query the data from API and database by parameter: accession number. Compare the data count and content.
        If equal betwwen two values, return true, other return False.

        :param accession number:

        :return: boolean

        --Ralf Wang 19005260
        """

        result = self._worklist_search_worklist(isFuzzy=True, accessionNumber=str_accn)
        pagination_dict = result['pagination']
        query_count = pagination_dict['totalCount']
        page_size = pagination_dict['pageSize']
        page_count = query_count // page_size + 1
        '''
        Use api to get the first page information , get the page size and totalcount
        Vist each page data and organize the data to a list.
        '''
        worklistDto_list = []
        for i in range(page_count):
            pagination = {"pageIndex": i + 1, "pageSize": page_size}
            result_each_page = self._worklist_search_worklist(isFuzzy=True, pagination=pagination,
                                                              accessionNumber=str_accn)
            worklistDto_list += result_each_page["worklistDto"]

        '''
        Delete the +08:00 and T chars in reportprinttime and filmprinttime.
        Format the string for compare operation late.
        '''
        for index in range(len(worklistDto_list)):
            for key, value in worklistDto_list[index].items():
                if "+08:00" in str(worklistDto_list[index][key]):
                    new_value = str(worklistDto_list[index][key]).replace("T", " ").replace("+08:00", "")
                    if len(new_value) < 23:
                        if "." in new_value:
                            for count in range(23 - len(new_value)):
                                new_value = new_value + "0"
                        else:
                            new_value = new_value + "."
                            for count in range(23 - len(new_value)):
                                new_value = new_value + "0"
                    worklistDto_list[index][key] = new_value

        '''
        Query the data from database
        '''
        worklist_query_db_col = self.worklist_query_db_column
        sql_query = r"SELECT AccessionNumber,PatientID,PatientName,CONVERT(varchar, CreatedTime, 23) as studyDate," \
                    r"CONVERT(varchar, CreatedTime, 24) as studyTime,PatientSex,PatientType,HoldFlag," \
                    r"PrintMode,ExamName,BodyPart,FilmPrintStatus,convert(varchar, FilmPrintTime, 121)," \
                    r"DeleteStatus as filmDeleteStatus," \
                    r"ImageCount,ReportStatus,ReportPrintStatus,convert(varchar, ReportPrintTime, 121),ReportCount," \
                    r"Modalities,DeleteStatus," \
                    r"CompleteStatus,CallingAE,null as reportInfos , null as filmInfos  " \
                    r"FROM wggc.dbo.AFP_ExamInfo " \
                    r"WHERE AccessionNumber like '%{accn}%' " \
                    r"AND DeleteStatus = 0 " \
                    r"ORDER BY CreatedTime DESC "
        sql_query = sql_query.replace("{accn}", str(str_accn))
        conn = pyodbc.connect(self.connect_string)
        cursor = conn.cursor()
        cursor.execute(sql_query)
        rows = cursor.fetchall()
        conn.close()

        '''
        Organize the queried data to dict with the define column propery.
        The column name should consistent with the API format.
        '''
        data_from_DB = []
        for row in range(len(rows)):
            # print(rows[row])
            temp_dict = {}
            for col in range(len(rows[row])):
                key = worklist_query_db_col[col]
                value = rows[row][col]
                temp_dict[key] = value
            data_from_DB.append(temp_dict)

        '''
        compare the data between API and database:
        '''
        if len(worklistDto_list) == len(data_from_DB):
            print("Platform.platform_worklist_fuzzy_query_by_accn: There are [%s] rows data queried out."
                  % (len(data_from_DB)))
            if operator.eq(worklistDto_list, data_from_DB):
                print("Platform.platform_worklist_fuzzy_query_by_accn: The query data is correct!")
                return True
            else:
                for index in range(len(worklistDto_list)):
                    if operator.eq(worklistDto_list[index], data_from_DB[index]):
                        pass
                        # print("correct")
                    else:
                        for key, value in dict(worklistDto_list[index]).items():
                            if worklistDto_list[index][key] == data_from_DB[index][key]:
                                pass
                            else:
                                print("Platform.platform_worklist_fuzzy_query_by_accn: The data is not equal!")
                                print("Platform.platform_worklist_fuzzy_query_by_accn: From API: \n %s"
                                      % (worklistDto_list[index]))
                                print("Platform.platform_worklist_fuzzy_query_by_accn: From database: \n %s"
                                      % (data_from_DB[index]))
                                print(key + " : [" \
                                      + worklistDto_list[index][key] + "]  -   [" + data_from_DB[index][key] + "]")
                        return False


        else:
            print("Platform.platform_worklist_fuzzy_query_by_accn: The data count from API are [%s]."
                  % (len(worklistDto_list)))
            print("Platform.platform_worklist_fuzzy_query_by_accn: The data count from database are [%s]."
                  % (len(data_from_DB)))
            raise Exception("Platform.platform_worklist_fuzzy_query_by_accn: The data count is not equaled.")

    def platform_worklist_fuzzy_query_by_patientname(self, str_patient_name):
        """platform_worklist_fuzzy_query_by_patientname

        Fuzzy Query the data from API and database by parameter: patient name. Compare the data count and content.
        If equal betwwen two values, return true, other return False.

        :param accession number:

        :return: boolean

        --Ralf Wang 19005260
        """

        result = self._worklist_search_worklist(isFuzzy=True, patientName=str_patient_name)
        pagination_dict = result['pagination']
        query_count = pagination_dict['totalCount']
        page_size = pagination_dict['pageSize']
        page_count = query_count // page_size + 1
        '''
        Use api to get the first page information , get the page size and totalcount
        Vist each page data and organize the data to a list.
        '''
        worklistDto_list = []
        for i in range(page_count):
            pagination = {"pageIndex": i + 1, "pageSize": page_size}
            result_each_page = self._worklist_search_worklist(isFuzzy=True, pagination=pagination,
                                                              patientName=str_patient_name)
            worklistDto_list += result_each_page["worklistDto"]

        '''
        Delete the +08:00 and T chars in reportprinttime and filmprinttime.
        Format the string for compare operation late.
        '''
        for index in range(len(worklistDto_list)):
            for key, value in worklistDto_list[index].items():
                if "+08:00" in str(worklistDto_list[index][key]):
                    new_value = str(worklistDto_list[index][key]).replace("T", " ").replace("+08:00", "")
                    if len(new_value) < 23:
                        if "." in new_value:
                            for count in range(23 - len(new_value)):
                                new_value = new_value + "0"
                        else:
                            new_value = new_value + "."
                            for count in range(23 - len(new_value)):
                                new_value = new_value + "0"
                    worklistDto_list[index][key] = new_value

        '''
        Query the data from database
        '''
        worklist_query_db_col = self.worklist_query_db_column
        sql_query = r"SELECT AccessionNumber,PatientID,PatientName,CONVERT(varchar, CreatedTime, 23) as studyDate," \
                    r"CONVERT(varchar, CreatedTime, 24) as studyTime,PatientSex,PatientType,HoldFlag," \
                    r"PrintMode,ExamName,BodyPart,FilmPrintStatus,convert(varchar, FilmPrintTime, 121)," \
                    r"DeleteStatus as filmDeleteStatus," \
                    r"ImageCount,ReportStatus,ReportPrintStatus,convert(varchar, ReportPrintTime, 121),ReportCount," \
                    r"Modalities,DeleteStatus," \
                    r"CompleteStatus,CallingAE,null as reportInfos , null as filmInfos  " \
                    r"FROM wggc.dbo.AFP_ExamInfo " \
                    r"WHERE PatientName like '%{Pname}%'" \
                    r"AND DeleteStatus = 0" \
                    r"ORDER BY CreatedTime DESC"
        sql_query = sql_query.replace("{Pname}", str(str_patient_name))
        conn = pyodbc.connect(self.connect_string)
        cursor = conn.cursor()
        cursor.execute(sql_query)
        rows = cursor.fetchall()
        conn.close()

        '''
        Organize the queried data to dict with the define column propery.
        The column name should consistent with the API format.
        '''
        data_from_DB = []
        for row in range(len(rows)):
            # print(rows[row])
            temp_dict = {}
            for col in range(len(rows[row])):
                key = worklist_query_db_col[col]
                value = rows[row][col]
                temp_dict[key] = value
            data_from_DB.append(temp_dict)

        '''
        compare the data between API and database:
        '''
        if len(worklistDto_list) == len(data_from_DB):
            print("Platform.platform_worklist_fuzzy_query_by_patientname: There are [%s] rows data queried out."
                  % (len(data_from_DB)))
            if operator.eq(worklistDto_list, data_from_DB):
                print("Platform.platform_worklist_fuzzy_query_by_patientname: The query data is correct!")
                return True
            else:
                for index in range(len(worklistDto_list)):
                    if operator.eq(worklistDto_list[index], data_from_DB[index]):
                        pass
                        # print("correct")
                    else:
                        for key, value in dict(worklistDto_list[index]).items():
                            if worklistDto_list[index][key] == data_from_DB[index][key]:
                                pass
                            else:
                                print("Platform.platform_worklist_fuzzy_query_by_patientname: The data is not equal!")
                                print("Platform.platform_worklist_fuzzy_query_by_patientname: From API: \n %s"
                                      % (worklistDto_list[index]))
                                print("Platform.platform_worklist_fuzzy_query_by_patientname: From database: \n %s"
                                      % (data_from_DB[index]))
                                print(key + " : [" \
                                      + worklistDto_list[index][key] + "]  -   [" + data_from_DB[index][key] + "]")
                        return False


        else:
            print("Platform.platform_worklist_fuzzy_query_by_patientname: The data count from API are [%s]."
                  % (len(worklistDto_list)))
            print("Platform.platform_worklist_fuzzy_query_by_patientname: The data count from database are [%s]."
                  % (len(data_from_DB)))
            raise Exception("Platform.platform_worklist_fuzzy_query_by_patientname: The data count is not equaled.")

    def platform_worklist_fuzzy_query_by_patienttype(self, str_patient_type):
        """platform_worklist_fuzzy_query_by_patienttype

        Query the data from API and database by parameter: patient type. Compare the data count and content.
        If equal between two values, return true, other return False.

        :param str_patient_type: such "门诊病人","住院病人"

        :return: boolean + list

        --Ralf Wang 19005260
        """
        type_list = str_patient_type.split(",")
        api_type = ""
        for index in range(len(type_list)):
            type = type_list[index]
            if type in self.patient_type.keys():
                if index == len(type_list) - 1:
                    api_type = api_type + str(self.patient_type[type])
                else:
                    api_type = api_type + str(self.patient_type[type]) + ","
            else:
                return "False", "The parameter [%s] is not exist" % type
        str_patient_type = str(api_type)
        print(str_patient_type)
        # TBD

        result = self._worklist_search_worklist(isFuzzy=True, patientType=str_patient_type)
        pagination_dict = result['pagination']
        query_count = pagination_dict['totalCount']
        page_size = pagination_dict['pageSize']
        page_count = query_count // page_size + 1
        '''
        Use api to get the first page information , get the page size and totalcount
        Vist each page data and organize the data to a list.
        '''
        worklistDto_list = []
        for i in range(page_count):
            pagination = {"pageIndex": i + 1, "pageSize": page_size}
            result_each_page = self._worklist_search_worklist(isFuzzy=True, pagination=pagination,
                                                              patientType=str_patient_type)
            worklistDto_list += result_each_page["worklistDto"]

        '''
        Delete the +08:00 and T chars in reportprinttime and filmprinttime.
        Format the string for compare operation late. 
        '''
        for index in range(len(worklistDto_list)):
            for key, value in worklistDto_list[index].items():
                if "+08:00" in str(worklistDto_list[index][key]):
                    new_value = str(worklistDto_list[index][key]).replace("T", " ").replace("+08:00", "")
                    if len(new_value) < 23:
                        if "." in new_value:
                            for count in range(23 - len(new_value)):
                                new_value = new_value + "0"
                        else:
                            new_value = new_value + "."
                            for count in range(23 - len(new_value)):
                                new_value = new_value + "0"
                    worklistDto_list[index][key] = new_value

        '''
        Query the data from database
        '''
        worklist_query_db_col = self.worklist_query_db_column
        sql_query = r"SELECT AccessionNumber,PatientID,PatientName,CONVERT(varchar, CreatedTime, 23) as studyDate," \
                    r"CONVERT(varchar, CreatedTime, 24) as studyTime,PatientSex,PatientType,HoldFlag," \
                    r"PrintMode,ExamName,BodyPart,FilmPrintStatus,convert(varchar, FilmPrintTime, 121)," \
                    r"DeleteStatus as filmDeleteStatus," \
                    r"ImageCount,ReportStatus,ReportPrintStatus,convert(varchar, ReportPrintTime, 121),ReportCount," \
                    r"Modalities,DeleteStatus," \
                    r"CompleteStatus,CallingAE,null as reportInfos , null as filmInfos  " \
                    r"FROM wggc.dbo.AFP_ExamInfo " \
                    r"WHERE PatientType in ({Ptype}) " \
                    r"AND DeleteStatus = 0 " \
                    r"ORDER BY CreatedTime DESC"
        sql_query = sql_query.replace("{Ptype}", str(str_patient_type))
        conn = pyodbc.connect(self.connect_string)
        cursor = conn.cursor()
        cursor.execute(sql_query)
        rows = cursor.fetchall()
        conn.close()

        '''
        Organize the queried data to dict with the define column propery.
        The column name should consistent with the API format.
        '''
        data_from_DB = []
        for row in range(len(rows)):
            # print(rows[row])
            temp_dict = {}
            for col in range(len(rows[row])):
                key = worklist_query_db_col[col]
                value = rows[row][col]
                temp_dict[key] = value
            data_from_DB.append(temp_dict)

        '''
        compare the data between API and database:
        '''
        if len(worklistDto_list) == len(data_from_DB):
            print("Platform.platform_worklist_fuzzy_query_by_patienttype: There are [%s] rows data queried out."
                  % (len(data_from_DB)))
            if operator.eq(worklistDto_list, data_from_DB):
                print("Platform.platform_worklist_fuzzy_query_by_patienttype: The query data is correct!")
                result = {"Result": True, "worklist_data": worklistDto_list, "Dabase_data": data_from_DB}
                return json.dumps(result)
            else:
                for index in range(len(worklistDto_list)):
                    if operator.eq(worklistDto_list[index], data_from_DB[index]):
                        pass
                        # print("correct")
                    else:
                        for key, value in dict(worklistDto_list[index]).items():
                            if worklistDto_list[index][key] == data_from_DB[index][key]:
                                pass
                            else:
                                print("Platform.platform_worklist_fuzzy_query_by_patienttype: The data is not equal!")
                                print("Platform.platform_worklist_fuzzy_query_by_patienttype: From API: \n %s"
                                      % (worklistDto_list[index]))
                                print("Platform.platform_worklist_fuzzy_query_by_patienttype: From database: \n %s"
                                      % (data_from_DB[index]))
                                print(key + " : [" \
                                      + worklistDto_list[index][key] + "]  -   [" + data_from_DB[index][key] + "]")
                        result = {"Result": False, "worklist_data": worklistDto_list, "Dabase_data": data_from_DB}
                        return json.dumps(result)
        else:
            print("Platform.platform_worklist_fuzzy_query_by_patienttype: The data count from API are [%s]."
                  % (len(worklistDto_list)))
            print("Platform.platform_worklist_fuzzy_query_by_patienttype: The data count from database are [%s]."
                  % (len(data_from_DB)))
            raise Exception("Platform.platform_worklist_fuzzy_query_by_patienttype: The data count is not equaled.")

    '''
    Shortcut related function
    '''

    def Platform_worklist_shotcut_save(self, shortcutName, isFuzzy_bool=True, delete_flage=True, **kwargs):

        api_string_dict = settings.Platform_webapi_worklist_shortcut_API_string
        dict_UserName = api_string_dict['UserName']
        dict_RoleName = api_string_dict['RoleName']
        dict_Criteria = api_string_dict['Criteria']
        dict_CreateDateRange = dict_Criteria["createDateRange"]

        if isFuzzy_bool == False:
            dict_Criteria["isFuzzy"] = False
            for argk, argv in kwargs.items():
                # init UserName
                for key, value in api_string_dict.items():
                    if argk == key:
                        api_string_dict[key] = kwargs[argk]
                for key, value in dict_Criteria.items():
                    if argk == key:
                        dict_Criteria[key] = kwargs[argk]

                for key, value in dict_CreateDateRange.items():
                    if argk == key:
                        dict_CreateDateRange[key] = kwargs[argk]
        else:
            if isFuzzy_bool == True:
                dict_Criteria["isFuzzy"] = True
                for argk, argv in kwargs.items():
                    # init UserName
                    for key, value in api_string_dict.items():
                        if argk == key:
                            api_string_dict[key] = kwargs[argk]
                    for key, value in dict_Criteria.items():
                        if argk == key:
                            dict_Criteria[key] = kwargs[argk]
                            # if argk in settings.Platform_webapi_worklist_searchWorklist_fuzzy_string:
                            #   if dict_Criteria[argk] != None:
                            #      dict_Criteria[argk] = "*" + str(dict_Criteria[argk]) + "*"
                    for key, value in dict_CreateDateRange.items():
                        if argk == key:
                            dict_CreateDateRange[key] = kwargs[argk]
            else:
                raise Exception(
                    "Platform.Platform_worklist_shotcut_save: Please give the value of parameter [isFuzzy] , True or False")

        if "patientType" in kwargs.keys():
            str_patient_type = kwargs["patientType"]
            for key, value in self.patient_type.items():
                if key in str_patient_type:
                    str_patient_type = str_patient_type.replace(key, value)
        api_string_dict["Criteria"]["patientType"] = str_patient_type

        conn = pyodbc.connect(self.connect_string)
        cursor = conn.cursor()
        user_name = api_string_dict['UserName']
        cursor.execute('''
        select UserRole from wggc.dbo.Users where UserName = ?
        ''', [user_name])
        rows = cursor.fetchall()
        conn.close()

        if len(rows) >= 1:
            api_string_dict["RoleName"] = rows[0][0]
        else:
            raise Exception("Platform.Platform_worklist_shotcut_save: No this user in the system [%s]", user_name)

        '''If the shotcut is exist and delete_flage is treu, will delte the shorcut first.'''
        shortcut_name_db = "Web_eFilmWorklistShortcut|" + shortcutName
        conn = pyodbc.connect(self.connect_string)
        cursor = conn.cursor()
        cursor.execute('''
                SELECT PropertyValue 
                FROM wggc.dbo.UserProfile  
                WHERE UserName = ? 
                AND PropertyName = ?
                ''', [user_name, shortcut_name_db])
        rows = cursor.fetchall()
        conn.close()

        """map the parameter to API string from the query data from database"""

        if len(rows) >= 1:
            if delete_flage:
                print("Platform.Platform_worklist_shotcut_save: The shortcut exist, delete as your selected.")
                self.Platform_worklist_shotcut_del_by_name(api_string_dict["UserName"], shortcutName)

        dict_Criteria["shortcutNameCache"] = shortcutName
        myheaders = {'Accept': 'application/json, text/plain, */*', 'Authorization': 'bearer ' + self.auth_string}
        url = self.platform_webapi_worklist_saveShortcut
        res = requests.post(url, json=api_string_dict, headers=myheaders)
        res_json = json.loads(res.text)
        if res_json["isSuccess"] == True:
            result = {"Result": True, "shortCutname": shortcutName}
            return result
        else:
            result = {"Result": False, "shortCutname": shortcutName, "Res message": res_json}
            return result

    def Platform_worklist_shotcut_query_by_name(self, str_user_name, str_shortcut_name):

        shortcut_name = "Web_eFilmWorklistShortcut|" + str_shortcut_name
        search_worklist_dict = settings.Platform_webapi_worklist_searchWorklist_string

        conn = pyodbc.connect(self.connect_string)
        cursor = conn.cursor()
        cursor.execute('''
        SELECT PropertyValue 
        FROM wggc.dbo.UserProfile  
        WHERE UserName = ? 
        AND PropertyName = ?
        ''', [str_user_name, shortcut_name])
        rows = cursor.fetchall()
        conn.close()

        """map the parameter to API string from the query data from database"""
        if len(rows) >= 1:
            param_dict = xmltodict.parse(rows[0][0])
            for key, value in param_dict.items():
                if isinstance(value, (dict, OrderedDict)):
                    for odkey, odvalue in value.items():
                        for skey, svalue in search_worklist_dict.items():
                            if odkey.lower() == skey.lower():
                                search_worklist_dict[skey] = odvalue

            """If the isFuzzy is true, give the * character to some API column."""
            if search_worklist_dict["isFuzzy"] == True or search_worklist_dict["isFuzzy"].lower() == "true":
                for argk, argv in search_worklist_dict.items():
                    if argk in settings.Platform_webapi_worklist_searchWorklist_fuzzy_string:
                        if search_worklist_dict[argk] != None:
                            search_worklist_dict[argk] = "*" + str(search_worklist_dict[argk]) + "*"

            # search_worklist_dict.pop("ExamName")
            # search_worklist_dict.pop("CallingAE")

            myheaders = {'Accept': 'application/json, text/plain, */*', 'Authorization': 'bearer ' + self.auth_string}
            # url = self.Platform_webapi_worklist_searchWorklist_url
            url = self.Platform_webapi_worklist_searchWorklist_url
            res = requests.post(url, json=search_worklist_dict, headers=myheaders)

            # print("resopnse is " + res.text)

            """ Get the query result page size and index, Use them to get all data"""
            pagination_dict = json.loads(res.text)['pagination']
            query_count = pagination_dict['totalCount']
            page_size = pagination_dict['pageSize']
            page_count = query_count // page_size + 1
            '''
            Use api to get the first page information , get the page size and totalcount
            Vist each page data and organize the data to a list.
            '''
            worklistDto_list = []

            try:
                for i in range(page_count):
                    pagination = {"pageIndex": i + 1, "pageSize": page_size}
                    search_worklist_dict["pagination"] = pagination

                    result_each_page = requests.post(url, json=search_worklist_dict, headers=myheaders)
                    result_each_page = json.loads(result_each_page.text)
                    worklistDto_list += result_each_page["worklistDto"]

                for index in range(len(worklistDto_list)):
                    for key, value in worklistDto_list[index].items():
                        if "+08:00" in str(worklistDto_list[index][key]):
                            new_value = str(worklistDto_list[index][key]).replace("T", " ").replace("+08:00", "")
                            if len(new_value) < 23:
                                if "." in new_value:
                                    for count in range(23 - len(new_value)):
                                        new_value = new_value + "0"
                                else:
                                    new_value = new_value + "."
                                    for count in range(23 - len(new_value)):
                                        new_value = new_value + "0"
                            worklistDto_list[index][key] = new_value

                result = json.dumps({"Result": True, "Data": worklistDto_list})
                # print(result)
                return result
            except:
                raise Exception("Platform.Platform_worklist_shotcut_query_by_name: The function execute failed.")


        else:

            raise Exception(
                "Platform.Platform_worklist_shotcut_query_by_name: No this user or shortcut  in the system [%s, %s]"
                % (str_user_name, str_shortcut_name))

    def Platform_worklist_shotcut_del_by_name(self, str_user_name, str_shortcut_name):

        shortcut_name = "Web_eFilmWorklistShortcut|" + str_shortcut_name

        conn = pyodbc.connect(self.connect_string)
        cursor = conn.cursor()
        cursor.execute('''
        SELECT PropertyValue 
        FROM wggc.dbo.UserProfile  
        WHERE UserName = ? 
        AND PropertyName = ?
        ''', [str_user_name, shortcut_name])
        rows = cursor.fetchall()
        conn.close()

        """map the parameter to API string from the query data from database"""
        if len(rows) >= 1:

            conn = pyodbc.connect(self.connect_string)
            cursor = conn.cursor()
            user_name = str_user_name

            cursor.execute('''
                    select UserRole from wggc.dbo.Users where UserName = ?
                    ''', [user_name])
            rows = cursor.fetchall()
            conn.close()

            if len(rows) >= 1:

                myheaders = {'Accept': 'application/json, text/plain, */*',
                             'Authorization': 'bearer ' + self.auth_string}
                url = self.Platform_webapi_worklist_delete_shortcut_url
                body_string = self.Platform_webapi_worklist_delete_shortcut_bodystring

                body_string["RoleName"] = rows[0][0]
                body_string["UserName"] = str_user_name
                body_string["ShortcutName"] = str_shortcut_name

                res = requests.post(url, json=body_string, headers=myheaders)
                res_json = json.loads(res.text)

                if res_json["isSuccess"] == True:
                    print(
                        "Platform.Platform_worklist_shotcut_del_by_name: The shortcut of user is deleted successfully."
                        " [%s, %s], message is [%s]" % (str_shortcut_name, str_user_name, res.text))
                    return True
                else:
                    print(
                        "Platform.Platform_worklist_shotcut_del_by_name: The shortcut of user is deleted failed."
                        " [%s, %s], response is [%s]" % (str_shortcut_name, str_user_name, res.text))
                    return True

            else:
                raise Exception("Platform.Platform_worklist_shotcut_del_by_name: No this user in the system [%s]"
                                % (str_user_name))
        else:
            raise Exception(
                "Platform.Platform_worklist_shotcut_del_by_name: No this shortcut for user in the system [%s,%s]"
                % (str_shortcut_name, str_user_name))

    '''
    Central Print related.
    '''

    def Platform_worklist_central_print(self, str_terminaid, str_userid, list_accessionNumbers, list_restinstanceids):
        result = self.Platform_worklist_central_print_get_tasks(str_terminaid, str_userid, list_accessionNumbers,
                                                                list_restinstanceids)
        if result[0] == True:
            list_tasks = result[1]
            estimate_time = self.Platform_worklist_print_estimatetime(list_tasks)
            print(estimate_time)
            loop_count = round(estimate_time * 1.5 / 5)
            print(loop_count)

            for index in range(loop_count):
                time.sleep(5)
                self.Platform_account_check_login_status()
                result = self.Platform_worklist_printstatus_check(list_tasks)
                # print(result)
                result = json.loads(result)
                # print(result["isFinishPrint"])
                # print(int(result["failedTasks"]))
                if result["isFinishPrint"] == True and int(result["failedTasks"]) == 0:
                    print("Platform.Platform_worklist_central_print: Print successfully:")
                    print(result)
                    return True, list_tasks

            result = self.Platform_worklist_printstatus_check(list_tasks)
            result = json.loads(result)
            if result["isFinishPrint"] == True and int(result["failedTasks"]) == 0:
                print("Platform.Platform_worklist_central_print: Print successfully:")
                print(result)
                return True, list_tasks
            else:
                print("Platform.Platform_worklist_central_print:print failed.")
                print(result)
                return False, list_tasks

        else:
            print("Platform.Platform_worklist_central_print: Get print tasks for central print failed.")
            print("Terminal: %s" % str_terminaid)
            print("userid: %s" % str_userid)
            print("accession numnber: %s" % str(list_accessionNumbers))
            print("restinstanceids: %s" % str(list_restinstanceids))
            print("API response: %s" % str(result))
            if isinstance(result[1], list):
                print("%d exams want to print, %d exam create the task successfully."
                      % (len(list_accessionNumbers), len(result[1])))
            else:
                print("Create the print tasks failed.")
            return False

    def platform_worklist_central_print_print_datetime_check(self, old_datetime, new_datetime):

        if new_datetime is None:
            print("platform_worklist_central_print_film_print_datetime_check: The date time is not updated. [%s,%s]"
                  % (old_datetime, new_datetime))
            return False

        if old_datetime is None:
            if isinstance(new_datetime, str):
                new_datetime = datetime.strptime(new_datetime, '%Y-%m-%d %H:%M:%S.%f')
            if isinstance(new_datetime, datetime):
                print("platform_worklist_central_print_film_print_datetime_check: The date time is updated. [%s,%s]"
                      % (old_datetime, new_datetime))
                return True
            else:
                print("platform_worklist_central_print_film_print_datetime_check: The date time is not updated. [%s,%s]"
                      % (old_datetime, new_datetime))
                return False

        if old_datetime is not None and new_datetime is not None:
            if isinstance(new_datetime, str):
                new_datetime = datetime.strptime(new_datetime, '%Y-%m-%d %H:%M:%S.%f')
            if isinstance(old_datetime, str):
                old_datetime = datetime.strptime(old_datetime, '%Y-%m-%d %H:%M:%S.%f')

            if isinstance(old_datetime, datetime) and isinstance(new_datetime, datetime):
                # print(int(new_datetime - old_datetime))
                if new_datetime > old_datetime:
                    print("platform_worklist_central_print_film_print_datetime_check: The date time is updated. [%s,%s]"
                          % (old_datetime, new_datetime))
                    return True
                else:
                    print(
                        "platform_worklist_central_print_film_print_datetime_check: The date time is not updated. [%s,%s]"
                        % (old_datetime, new_datetime))
                    return False

        # compare the datetime confirm the date time is updated

    def Platform_worklist_central_print_get_tasks(self, str_terminaid, str_userid, list_accessionNumbers,
                                                  list_restinstanceids):
        myheaders = {'Accept': 'application/json, text/plain, */*', 'Authorization': 'bearer ' + self.auth_string}
        url = self.Platform_webapi_worklist_centralPrint_url
        body_dict = self.Platform_webapi_worklist_centralPrint_body_string
        body_dict["TerminalId"] = str_terminaid
        body_dict["UserId"] = str_userid
        body_dict["AccessionNumbers"] = list_accessionNumbers
        body_dict["RestInstanceIds"] = list_restinstanceids

        res = requests.post(url, json=body_dict, headers=myheaders)
        res_list = json.loads(res.text)

        if len(res_list) == len(list_accessionNumbers):
            return_code = 0
            for index in range(len(res_list)):
                return_code = res_list[index]["returnValue"] + return_code

            if return_code == 0:
                print("Platform.Platform_worklist_central_print_get_tasks: All exams can central print.")
                return True, res_list
            else:
                print(
                    "Platform.Platform_worklist_central_print_get_tasks: There are some exam cannot print, please check.")
                for index in range(len(res_list)):
                    print(res_list[index])
                return False, res_list
        else:
            print("Platform.Platform_worklist_central_print_get_tasks: Get print task failed.")
            return False, res_list

    def Platform_worklist_print_estimatetime(self, list_taskinfo):
        url = self.Platform_webapi_worklist_printEstimateTime_url

        myheaders = {'Accept': 'application/json, text/plain, */*', 'Authorization': 'bearer ' + self.auth_string}
        res = requests.post(url, json=list_taskinfo, headers=myheaders)
        return int(res.text)

    def Platform_worklist_printstatus_check(self, list_taskinfo):
        url = self.Platform_webapi_worklist_printstatus_url
        myheaders = {'Accept': 'application/json, text/plain, */*', 'Authorization': 'bearer ' + self.auth_string}
        res = requests.post(url, json=list_taskinfo, headers=myheaders)
        result = res.text
        # print(result)
        return result

    '''
    Account Related
    '''

    def Platform_account_check_login_status(self):
        myheaders = {'Accept': 'text / html, application / xhtml + xml, application / xml;', 'Cookie': self.cookies}
        url = self.Platform_account_check_loginStatus_url
        res = requests.get(url, headers=myheaders)
        if res.text == "true":
            # print("Platform.Platform_account_check_login_status: the user login status is %s " %res.text)
            return True
        else:
            print("Platform.Platform_account_check_login_status: the user login status is %s " % res.text)
            return False

    '''
    Builtin function.
    '''

    def _worklist_search_worklist(self, **kwargs):
        ''' module inter function not the library.
        This function use the searWorklist web api to query the information from PS system.
        :param kwargs: input the parameters of API like patientID = *, patientName = * etc.
        :return: return the dict of the result from API.
        '''
        # newsettings = Configurationlib()
        settings = Configurationlib()
        search_worklist_dict = settings.Platform_webapi_worklist_searchWorklist_string
        print(search_worklist_dict)
        print(settings.Platform_webapi_worklist_searchWorklist_string)
        parameter_result = []

        for argk, argv in kwargs.items():
            for key, value in search_worklist_dict.items():
                if argk == key:
                    search_worklist_dict[key] = kwargs[argk]
                    parameter_result.append(key)

        if len(parameter_result) == len(kwargs):
            if str(search_worklist_dict['isFuzzy']).lower() == 'true':
                for argk, argv in kwargs.items():
                    if argk in settings.Platform_webapi_worklist_searchWorklist_fuzzy_string:
                        if search_worklist_dict[argk] != None:
                            search_worklist_dict[argk] = "*" + str(search_worklist_dict[argk]) + "*"
                            # print(search_worklist_dict[argk])

            self.Platform_account_check_login_status()
            # print(search_worklist_dict)
            myheaders = {'Accept': 'application/json, text/plain, */*', 'Authorization': 'bearer ' + self.auth_string,
                         'Cookie': self.cookies}
            # print(myheaders)
            url = self.Platform_webapi_worklist_searchWorklist_url
            res = requests.post(url, json=search_worklist_dict, headers=myheaders)

            return json.loads(res.text)

        else:
            for k in parameter_result:
                kwargs.pop(k)
            print(
                "Platform._worklist_search_worklist: The parameters [%s] is valid or not in the query string please check."
                % (kwargs))
            return False


'''
***********************************************Sample**********************************
'''

# platform_object = Platform()
# platform_object.platform_login_user_pwd("admin","123456")

# platform_object.platform_worklist_fuzzy_query_by_patientID("20")
# platform_object.platform_logout()


# platform_object.platform_login_user_pwd("admin","123456")

# platform_object.platform_worklist_fuzzy_query_by_accn("20")
# platform_object.platform_logout()

# platform_object.platform_worklist_fuzzy_query_by_patienttype("住院病人")


'''
terminal = Terminal()

terminal.check_terminal_status('K3_Terminal01')
webpage = Platform()

webpage.platform_login_user_pwd("admin","123456")
#time.sleep(20)
webpage.Platform_account_check_login_status()


webpage.Platform_worklist_central_print("K3_Terminal01","admin",["A20191009102342161377","A20191009102251101515","A20191009102209898137","A20191009102128913709","A20191009102047694908"],[])
#webpage.Platform_worklist_central_print("K3_Terminal01","admin",["A20191009102342161377"],[])

res = webpage.Platform_worklist_central_print_get_tasks("K3_Terminal01","admin",["A20191009102342161377","A20191009102251101515","A20191009102209898137","A20191009102128913709","A20191009102047694908"],[])
print(res)
estimate_time = webpage.Platform_worklist_print_estimatetime(res[1])
loop_count = round(estimate_time *1.5 /5)
for i in range(loop_count):
    webpage.Platform_account_check_login_status()
    webpage.Platform_worklist_printstatus_check(res[1])
    time.sleep(5)
result = webpage.Platform_worklist_printstatus_check(res[1])
if result["isFinishPrint"] == "true" and result["isFinishPrint"] == 0:
    print("Print successfully:")
else:
    print("print failed.")
'''
# webpage.Platform_worklist_get_filminfo_by_accn()
# webpage.platform_worklist_fuzzy_query_by_patientID('20')
# webpage.platform_worklist_fuzzy_query_by_accn("20")
# webpage.platform_worklist_fuzzy_query_by_patientname("20")
# result = webpage.platform_worklist_fuzzy_query_by_patienttype("门诊病人,住院病人")
# webpage.Platform_worklist_qury_by_shotcut("admin","ralf")
# webpage.platform_worklist_fuzzy_query_by_patienttype("门诊病人,住院病人")
# print(webpage.Platform_worklist_shotcut_save("shortcutName",True, UserName="admin",patientType='门诊病人,住院病人'))

# print(webpage.Platform_worklist_shotcut_del_by_name("admin", "shortcutName"))
# print(webpage.Platform_worklist_shotcut_save("ralf",isFuzzy_bool=True,delete_flage=True,patientType="门诊病人,住院病人",UserName="admin"))
# print(webpage.Platform_worklist_shotcut_query_by_name("admin", "ralf"))
