# -*- coding : utf-8 -*-
'''
Designer: Ralf wang
Mail:   hao.wang@carestream.com
Date: 2019-08-14
Reviewer:
Design the PrintMode class and include related methond.
'''
import json
from datetime import datetime
from suds.client import Client as WebserviceClient
null = None
import pyodbc


from PUMA_ParameterAndSettings.Configurationlib import Configurationlib

settings = Configurationlib()

class Printmode(object):
    def __init__(self):
        self.printmode_dict_value_mode = settings.Printmode_dict_value_mode
        self.printmode_dict_mode_value = settings.Printmode_dict_mode_value
        self.accession_number = ""
        self.print_mode_value = ""
        self.print_mode_type = ""
        self.set_printmode_url = settings.Notify_URL.replace('{server}', settings.server)
        self.print_mode = ''
    '''
    get the exam print mode with accn
    '''
    def printmode_get_by_accn(self, accession_number):
        try:
            self.accession_number = accession_number
            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            cursor.execute('''SELECT PrintMode
                            FROM wggc.dbo.AFP_PrintMode 
                            WHere AccessionNumber = ?
                                       ''', [self.accession_number])
            rows = cursor.fetchall()
            conn.close()
            if len(rows) > 0:
                self.print_mode_value = rows[0][0]
                print("Printmode.printmode_get_by_accn: The database return value is: %s."
                      % (self.print_mode_value))
                self.print_mode_type = self.printmode_dict_value_mode.get(str(self.print_mode_value))
                print("Printmode.printmode_get_by_accn: The exam of %s print mode is: [%s]."
                      % (self.accession_number, self.print_mode_type))
                return self.print_mode_type
            else:
                return 'N/A'
                raise Exception("Printmode.printmode_get_by_accn: Cannot find the records from the afp_printmode table:  %s. \n"
                                % (self.accession_number))
        except:
            raise Exception("Printmode.printmode_get_by_accn: Fucntion execute failed.\n")

    '''
    Set the exam print mode with the accession number.
    '''
    def printmode_set_by_accn(self, accession_number, mode="any"):

        try:
            self.print_mode = mode
            self.accession_number = accession_number

            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            cursor.execute('''Select count(*) as count
                                       From wggc.dbo.AFP_Printmode 
                                       WHERE AccessionNumber = ? 
                                       ''', [self.accession_number])
            rows = cursor.fetchall()
            conn.close()
            count = rows[0][0]
            if count != 1:
                raise Exception("Printmode.printmode_set_by_accn: There is %s record in print mode table"
                                "of %s exam " %(count, self.accession_number))
                return False
            else:
                print("Printmode.printmode_set_by_accn: Find the records in print mode table of exam: %s."
                      %(self.accession_number))
                mode_value = self.printmode_dict_mode_value.get(str(self.print_mode.lower()))

                if mode_value == None:
                    print("Printmode.printmode_set_by_accn: No this print mode: %s."
                          % (self.print_mode))
                    print("Printmode.printmode_set_by_accn: The exist print mode are")
                    for key in self.printmode_dict_mode_value.keys():
                        print(key)
                    return False
                else:
                    conn = pyodbc.connect(settings.db_connectString)
                    cursor = conn.cursor()
                    cursor.execute('''SELECT StudyInstanceUID,PrintWaitTime,ReportWaitTime
                                    From WGGC.dbo.AFP_PrintMode 
                                    WHERE AccessionNumber = ? 
                                                           ''', [self.accession_number])
                    rows = cursor.fetchall()
                    conn.close()
                    studUID = rows[0][0]
                    printwaittime = rows[0][1]
                    reportwaittime = rows[0][2]

                    client = WebserviceClient(self.set_printmode_url)
                    result = client.service.SetPrintMode(self.accession_number, studUID, mode_value, printwaittime,reportwaittime)
                    if result == 0:
                        print("Printmode.printmode_set_by_accn: Set exam print mode to [%s] successfully. "
                              %(self.printmode_dict_value_mode.get(str(mode_value))))
                        return True
                    else:
                        return False
                        raise Exception("Printmode.printmode_set_by_accn: Execute the webservice notify.setprintmode failed. ")

        except:
            print("Printmode.printmode_set_by_accn: Function execute failed. ")
            return False


    def printmode_get_info_from_db_by_accn(self, accession_number):
        """printmode_get_info_from_db_by_accn

        This function is return all data from table wggc.dbo.afp_printmode which query by accession number.
        If the query records count is 1, result is true. other will return false.

        :param accession_number: The exam accession number. It`s the primary key in the table


        :return: json string with bool result and all data.
        """
        '''
        Get the cloumn name of wggc.dbo.afp_printmode table
        '''
        conn = pyodbc.connect(settings.db_connectString)
        cursor = conn.cursor()
        cursor.execute('''SELECT COLUMN_NAME
                        FROM INFORMATION_SCHEMA.COLUMNS
                        WHERE TABLE_NAME = N'AFP_PrintMode'
                        ''')
        rows = cursor.fetchall()
        conn.close()
        table_column_name_list = []
        result_dict = {}
        for i in range(len(rows)):
            table_column_name_list.append(rows[i][0])

        '''
        Get the data which query from wggc.dbo.afp_printmode by accession number
        '''
        conn = pyodbc.connect(settings.db_connectString)
        cursor = conn.cursor()
        cursor.execute('''SELECT * 
                    FROM wggc.dbo.AFP_PrintMode 
                    WHERE AccessionNumber = ?
                        ''',[str(accession_number)])
        rows = cursor.fetchall()
        conn.close()
        printmode_value_list = []

        if len(rows) != 1:
            print("Printmode.printmode_get_info_from_db_by_accn: Data Exception for the exam "
                  "[%s] in wggc.dbo_afp_printmode table" % (str(accession_number)))
            print("Printmode.printmode_get_info_from_db_by_accn: There are [%d] records in table"
                  %(len(rows)))
            result_dict['result'] = False
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

            result_dict['result'] = True
            result_dict.update(dict(zip(table_column_name_list, printmode_value_list)))
            return json.dumps(result_dict)




'''
pm = Printmode()
pm.printmode_set_by_accn("A20190925144432852059", "Both")
'''