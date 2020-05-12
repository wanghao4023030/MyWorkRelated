# -*- coding : utf-8 -*-
'''
Designer: Ralf wang
Mail:   hao.wang@carestream.com
Date: 2019-08-21
Reviewer:
Design the HoldTime class and include related methond.
'''
from datetime import datetime
from time import sleep
null = None
import pyodbc


from PUMA_ParameterAndSettings.Configurationlib import Configurationlib


settings = Configurationlib()

class HoldTime(object):

    def __init__(self):
        try:
            self.HoldTime_dict_value_mode = settings.HoldTime_dict_value_mode
            self.HoldTime_dict_mode_value = settings.HoldTime_dict_mode_value
            self.accession_number = ""
            self.HoldTime_value = ""
            self.HoldTime_type = ""
            self.set_HoldTimeee_url = settings.Notify_URL.replace('{server}', settings.server)
            self.HoldTime = ''
        except Exception as e:
            print("HoldTime object: The object init failed.")
            print(type(e))
            raise Exception(e)

    '''
    Query the exam hold flag status with accession number
    '''
    def HoldTime_get_by_accn(self, accession_number):
        """HoldTime_get_by_accn

           This function is to get the Holdflag from table wggc.dbo.AFP_PrintMode.

           return the hold flage type : on |off

           SELECT Holdflag FROM wggc.dbo.AFP_PrintMode WHere AccessionNumber = ?

           :return: value on|off

           --ralf wang 19005260
           """

        try:
            self.accession_number = accession_number
            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            cursor.execute('''SELECT Holdflag
                            FROM wggc.dbo.AFP_PrintMode 
                            WHere AccessionNumber = ?
                                       ''', [self.accession_number])
            rows = cursor.fetchall()
            conn.close()
            if len(rows) > 0:
                self.HoldTime_value = rows[0][0]
                print("HoldTime.HoldTime_get_by_accn: The database return value is: %s."
                      % (self.HoldTime_value))
                self.HoldTime_type = self.HoldTime_dict_value_mode.get(str(self.HoldTime_value))
                print("HoldTime.HoldTime_get_by_accn: The exam of %s hold flag is: [%s]."
                      % (self.accession_number, self.HoldTime_type))
                return self.HoldTime_type
            else:

                raise Exception("HoldTime.HoldTime_get_by_accn: "
                                "Cannot find the records from the afp_printmode table:  %s. \n"
                                % (self.accession_number))
                return 'N/A'

        except Exception as e:
            print("HoldTime_get_by_accn: The function execute failed or no data output.")
            print(type(e))
            raise Exception(e)


    '''
    Set the exam hold flag with accession number.
    The paramemter value should be on or off
    '''
    def HoldTime_set_by_accn(self, accession_number, HoldTime="off"):
        """HoldTime_get_by_accn

           This function is to set the Holdflag from table wggc.dbo.AFP_PrintMode.

           UPDATE wggc.dbo.AFP_PrintMode  SET HoldFlag = ? WHERE AccessionNumber = ?

           :return: value True|False

           --ralf wang 19005260
           """
        try:
            self.HoldTime_type = HoldTime
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
        except Exception as e:
            print("HoldTime.HoldTime_set_by_accn: Get the records count from wggc.dbo.AFP_Printmode failed.")
            print(type(e))
            raise Exception(e)

        if count != 1:
            raise Exception("HoldTime.HoldTime_set_by_accn: There is %s record in print mode table"
                            "of %s exam " %(count, self.accession_number))
            return False
        else:
            print("HoldTime.HoldTime_set_by_accn: Find the records in print mode table of exam: %s."
                  %(self.accession_number))
            self.HoldTime_value = self.HoldTime_dict_mode_value.get(str(self.HoldTime_type.lower()))

            if self.HoldTime_value == None:
                print("HoldTime.HoldTime_set_by_accn: No this print mode: %s."
                      % (self.HoldTime_type))
                print("HoldTime.HoldTime_set_by_accn: The exist print mode are")
                for key in self.HoldTime_dict_mode_value.keys():
                    print(key)
                return False
            else:
                try:
                    conn = pyodbc.connect(settings.db_connectString)
                    cursor = conn.cursor()
                    cursor.execute('''UPDATE wggc.dbo.AFP_PrintMode 
                                        SET HoldFlag = ?
                                        WHERE AccessionNumber = ?
                                    ''', [self.HoldTime_value, self.accession_number])
                    conn.commit()
                    cursor.execute('''SELECT HoldFlag
                        From  WGGC.dbo.AFP_PrintMode
                        WHERE AccessionNumber = ?
                    ''', [self.accession_number])
                    rows = cursor.fetchall()
                    return_value =str(rows[0][0])
                    conn.close()
                except Exception as e:
                    print("HoldTime.HoldTime_set_by_accn: Execute the update holdingtime SQL statement failed.")
                    print(type(e))
                    raise Exception(e)

                if return_value == self.HoldTime_value:
                    self.HoldTime_type = self.HoldTime_dict_value_mode.get(str(return_value))
                    print("HoldTime.HoldTime_set_by_accn: Set the hold flag successfully, "
                          "The hold flag is set to [%s] of exam %s."
                          %(self.HoldTime_type, self.accession_number))
                    return True
                else:
                    self.HoldTime_type = self.HoldTime_dict_value_mode.get(str(return_value))
                    print("HoldTime.HoldTime_set_by_accn: Set the hold flag failed.")
                    print("HoldTime.HoldTime_set_by_accn: The current hold flag is: %s."
                          %(self.HoldTime_type))
                    return False




    '''
    Wait the patient exam holding time arrived.
    This function is a simple one, it will return True 
    after time is more than the one which is big from film and report.
    '''
    def HoldTime_wait_time_arrive_by_accn(self, accession_number):
        """HoldTime_get_by_accn

        Wait the patient exam holding time arrived. This function is a simple one, it will return True
        after time is more than the one which is big from film and report.

        :return: bool value True|False

        --ralf wang 19005260
        """

        try:
            accession_number = str(accession_number)
            self.accession_number = accession_number
            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            cursor.execute('''Select PrintMode, FilmReadyTime, ReportReadyTime, FilmPrintStatus, ReportPrintStatus,HoldFlag
                                                   From wggc.dbo.AFP_ExamInfo 
                                                   WHERE AccessionNumber = ? 
                                                   ''', [accession_number])
            rows = cursor.fetchall()
            conn.close()
        except Exception as e:
            print("HoldTime.HoldTime_wait_time_arrive_by_accn: Function execute failed. Execute SQL to query the "
                  "PrintMode, FilmReadyTime, ReportReadyTime, FilmPrintStatus, ReportPrintStatus,HoldFlag "
                  " From wggc.dbo.AFP_ExamInfo failed.")
            print(type(e))
            raise Exception(e)

        try:
            if len(rows) >= 1:
                print_mode = rows[0][0]
                film_ready_time = rows[0][1]
                report_read_time = rows[0][2]
                film_print_status = rows[0][3]
                report_print_status = rows[0][4]
                hold_flage = rows[0][5]
                if hold_flage == 0:
                    print("HoldTime.HoldTime_wait_time_arrive_by_accn: The exam [%s] hold time is disable. "
                          "You can print it immediately...." %(accession_number))
                    return True
                '''Both print mode: get the max time and wait the hold time is arrived.'''
                if print_mode == 0:
                    if film_ready_time != None and report_read_time != None:
                        max_ready_time = film_ready_time if film_ready_time > report_read_time else report_read_time
                    else:
                        raise Exception("HoldTime.HoldTime_wait_time_arrive_by_accn: Exception, the film or report ready time"
                                        "is null: [%s,%s] for the exam [%s] and print mode is both."
                                        %(film_ready_time, report_read_time, accession_number))

                '''Film Only: Only check the film ready time'''
                # film only
                if print_mode == 1:
                    if film_ready_time != None:
                        max_ready_time = film_ready_time
                    else:
                        raise Exception("HoldTime.HoldTime_wait_time_arrive_by_accn: Exception, the film ready time"
                                    "is null: [%s] for this exam [%s] and print mode is film only"
                                        % (film_ready_time, accession_number))

                '''Report only: Only check the report ready time'''
                if print_mode == 2:
                    if report_read_time != None:
                        max_ready_time = report_read_time
                    else:
                        raise Exception("HoldTime.HoldTime_wait_time_arrive_by_accn: Exception, the report ready time"
                                    "is null: [%s] for this exam [%s] and print mode is report only"
                                        % (report_read_time, accession_number))

                '''Any print mode: get the max time and wait the hold time is arrived.'''
                if print_mode == 3:
                    if film_ready_time != None and report_read_time != None:
                        max_ready_time = film_ready_time if film_ready_time > report_read_time else report_read_time
                    else:
                        raise Exception("HoldTime.HoldTime_wait_time_arrive_by_accn: Exception, the film or report ready time"
                                        "is null: [%s,%s] for the exam [%s] and print mode is both."
                                        %(film_ready_time, report_read_time, accession_number))
                if print_mode == 5:
                    raise Exception("HoldTime.HoldTime_wait_time_arrive_by_accn: "
                                    "Exception, the exam [] print mode is not printed[5]."
                                    %(accession_number))

                current_time = datetime.now()
                wait_time = (max_ready_time - current_time).seconds

                if max_ready_time > current_time:
                    print(
                        "HoldTime.HoldTime_wait_time_arrive_by_accn: Sleep [%d] seconds to make print ready arrived."
                        % (wait_time + 10))

                    sleep(wait_time + 10)
                    return True
                else:
                    sleep(10)
                    print(
                        "HoldTime.HoldTime_wait_time_arrive_by_accn: The ready time has arrived."
                    )
                    return True
            else:
                print("HoldTime.HoldTime_wait_time_arrive_by_accn: There is no this exam in the system. [%s]"
                      %(accession_number))
                return False
        except Exception as e:
            print("HoldTime.HoldTime_wait_time_arrive_by_accn: function execute failed. Wait the holding time is arrived"
                  " failed.")
            print(type(e))
            raise Exception(e)

'''
**********************************************************************************************************************
                                Sample code
**********************************************************************************************************************
'''


'''
hf = HoldTime()
hf.HoldTime_get_by_accn("A20190925151339559062")
#print(hf.HoldTime_set_by_accn("A20190808102536531938", "Off"))
hf.HoldTime_wait_time_arrive_by_accn("A20190925151339559062")
'''