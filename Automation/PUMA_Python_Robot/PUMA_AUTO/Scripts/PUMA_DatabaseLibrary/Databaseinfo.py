# -*- coding : utf-8 -*-
'''
Designer: Ralf wang
Mail:   hao.wang@carestream.com
Date: 2019-09-05
Reviewer:
Design the Databaseinfo class and include related methond.
'''
import json
from datetime import datetime
from decimal import Decimal

import pyodbc
from PUMA_ParameterAndSettings.Configurationlib import Configurationlib

settings = Configurationlib()

class Databaseinfo(object):

    def __init__(self):
        self.connect_string = settings.db_connectString

    def DB_get_wggc_dbo_afp_examinfo_by_accn(self, accession_number):
        """DB_get_wggc_dbo_afp_examinfo_by_accn
        This function is query the data with accnession number from table wggc.dbp.afp_examinfo in database.
        The data will order by create time desc as default.
        The each column data will organize as list and map to dict with column name to return.


        :param accession_number:  The exam accession number as parameter to query.


        :return:  dict as json string to return.
        """

        conn = pyodbc.connect(self.connect_string)
        cursor = conn.cursor()
        cursor.execute('''SELECT COLUMN_NAME
                         FROM INFORMATION_SCHEMA.COLUMNS
                         WHERE TABLE_NAME = N'AFP_ExamInfo'
                         ''')
        rows = cursor.fetchall()
        conn.close()
        table_column_name_list = []
        result_dict = {}
        for i in range(len(rows)):
            table_column_name_list.append(rows[i][0])

        '''
        Get the data which query from wggc.dbo.AFP_ExamInfo by accession number
        '''
        conn = pyodbc.connect(settings.db_connectString)
        cursor = conn.cursor()
        cursor.execute('''SELECT * 
                     FROM wggc.dbo.AFP_ExamInfo 
                     WHERE AccessionNumber = ?
                     ORDER BY CreatedTime desc
                         ''', [str(accession_number)])
        rows = cursor.fetchall()
        conn.close()
        printmode_value_list = []

        if len(rows) != 1:
            print("Databaseinfo.DB_get_wggc_dbo_afp_examinfo_by_accn: Data Exception for the exam "
                  "[%s] in wggc.dbo.AFP_ExamInfo table" % (str(accession_number)))
            print("Databaseinfo.DB_get_wggc_dbo_afp_examinfo_by_accn: There are [%d] records in table"
                  % (len(rows)))
            result_dict['Result'] = False
            return json.dumps(result_dict)
        else:
            '''
            Merage column name and date to dict
            '''
            for i in range(len(rows[0])):
                value = rows[0][i]
                if isinstance(value, datetime):
                    value = str(value)

                printmode_value_list.append(value)
            result_dict['Result'] = True
            result_dict.update(dict(zip(table_column_name_list, printmode_value_list)))
            return json.dumps(result_dict)

    def DB_get_wggc_dbo_afp_printtask_by_sn(self, sn):
        """DB_get_wggc_dbo_afp_printtask_by_sn
        This function is query the data with SN from table wggc.dbp.afp_printtask in database.
        The data will order by create time desc as default.
        The each column data will organize as list and map to dict with column name to return.


        :param SN:  The exam print task sn as parameter to query.


        :return:  dict as json string to return.
        """

        conn = pyodbc.connect(self.connect_string)
        cursor = conn.cursor()
        cursor.execute('''SELECT COLUMN_NAME
                         FROM INFORMATION_SCHEMA.COLUMNS
                         WHERE TABLE_NAME = N'AFP_PrintTask'
                         ''')
        rows = cursor.fetchall()
        conn.close()
        table_column_name_list = []
        result_dict = {}
        for i in range(len(rows)):
            table_column_name_list.append(rows[i][0])

        '''
        Get the data which query from wggc.dbo.AFP_ExamInfo by accession number
        '''
        conn = pyodbc.connect(settings.db_connectString)
        cursor = conn.cursor()
        cursor.execute('''SELECT * 
                     FROM wggc.dbo.AFP_PrintTask 
                     WHERE SN = ?
                     ORDER BY SN desc
                         ''', [str(sn)])
        rows = cursor.fetchall()
        conn.close()
        print(rows)
        printtask_value_list = []

        if len(rows) != 1:
            print("Databaseinfo.DB_get_wggc_dbo_afp_printtask_by_sn: Data Exception for the exam "
                  "[%s] in wggc.dbo.AFP_PrintTask table" % (str(sn)))
            print("Databaseinfo.DB_get_wggc_dbo_afp_printtask_by_sn: There are [%d] records in table"
                  % (len(rows)))
            result_dict['Result'] = False
            return json.dumps(result_dict)
        else:
            '''
            Merage column name and date to dict
            '''
            for i in range(len(rows[0])):
                value = rows[0][i]
                if isinstance(value, datetime):
                    value = str(value)
                    value = value[0:len(value)-3]
                if isinstance(value, Decimal):
                    value = int(value)

                printtask_value_list.append(value)

            result_dict['Result'] = True
            result_dict.update(dict(zip(table_column_name_list, printtask_value_list)))
            return json.dumps(result_dict)


    def DB_get_wggc_dbo_afp_reportinfo_by_pid(self, patientid):
        """DB_get_wggc_dbo_afp_reportinfo_by_pid
        This function is query the data with patientid from table wggc.dbp.afp_reportinfo in database.
        The data will order by create time desc as default.
        The each column data will organize as list and map to dict with column name to return.


        :param accession_number:  The exam patientid as parameter to query.


        :return:  dict as json string to return.
        """

        conn = pyodbc.connect(self.connect_string)
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

        '''
        Get the data which query from wggc.dbo.AFP_ExamInfo by accession number
        '''
        conn = pyodbc.connect(settings.db_connectString)
        cursor = conn.cursor()
        cursor.execute('''SELECT * 
                     FROM wggc.dbo.AFP_ReportInfo 
                     WHERE PatientID = ?
                     ORDER BY CreatedTime desc
                         ''', [str(patientid)])
        rows = cursor.fetchall()
        conn.close()
        printmode_value_list = []

        if len(rows) != 1:
            print("Databaseinfo.DB_get_wggc_dbo_afp_reportinfo_by_pid: Data Exception for the exam "
                  "[%s] in wggc.dbo.AFP_ExamInfo table" % (str(patientid)))
            print("Databaseinfo.DB_get_wggc_dbo_afp_reportinfo_by_pid: There are [%d] records in table"
                  % (len(rows)))
            result_dict['Result'] = False
            return json.dumps(result_dict)
        else:
            '''
            Merage column name and date to dict
            '''
            for i in range(len(rows[0])):
                value = rows[0][i]
                if isinstance(value, datetime):
                    value = str(value)

                printmode_value_list.append(value)

            result_dict['Result'] = True
            result_dict.update(dict(zip(table_column_name_list, printmode_value_list)))
            return json.dumps(result_dict)


    def DB_worklist_fuzzy_query_by_pid(self, patientid):
        pass



'''
****************************************Sample Code************************************
'''
#dbinfo = Databaseinfo()
#print(dbinfo.DB_get_wggc_dbo_afp_examinfo_by_accn("A20190426150326481"))
#print(dbinfo.DB_get_wggc_dbo_afp_printtask_by_sn(1994))