# -*- coding : utf-8 -*-
'''
Designer: Ralf wang
Mail:   hao.wang@carestream.com
Date: 2019-08-05
Reviewer:
Design the terminal class and include related methond.
'''
import time
import pyodbc
import requests
from datetime import datetime

from PUMA_ParameterAndSettings.Configurationlib import Configurationlib

'''Init the parameters'''
settings = Configurationlib()

'''
Terminal object will invoke all method which user will used in the terminal.
'''


class Terminal(object):
    def __init__(self):
        self.terminal_name = ""
        self.terminal_status = ""
        self.EHDPS_status_url = "http://" + settings.server + settings.EHDPS_status_url
        self.terminal_status_info = ""
        self.EHDPS_printtask_create_url = "http://" + settings.server + settings.EHDPS_printtask_create_url
        self.EHDPS_printtask_create_info = ""
        self.EHDPS_printtask_print_url = "http://" + settings.server + settings.EHDPS_printtask_print_url
        self.EHDPS_printtask_print_info = ""
        self.EHDPS_printtask_report_getinfo_url = "http://" + settings.server + settings.EHDPS_printtask_report_getinfo_url
        self.EHDPS_printtask_report_getinfo_info = ""
        self.EHDPS_printtask_report_print_url = "http://" + settings.server + settings.EHDPS_printtask_report_print_url
        self.EHDPS_printtask_report_print_info = ""
        self.EHDPS_printtask_status_url = "http://" + settings.server + settings.EHDPS_printtask_status_url
        self.EHDPS_printtask_status_info = ""

        self.task_cardinfo = ""
        self.task_request_datetime = ""
        self.task_request_id = "null"
        self.task_taskID = ""
        self.task_status = ""
        self.task_ReportInfos = []
        self.input_type = 0
        self.task_printtask_status = ""
        self.task_printtask_status_dict = settings.EHDPS_printtask_status_dict
        self.task_estimate_time = 0

    def terminal_print_with_cardinfo(self, terminal_name, cardinfo):
        #try:
        self.terminal_name = terminal_name
        self.task_cardinfo = cardinfo.strip()

        if self.check_terminal_status(self.terminal_name) == True:
            if self.printtask_report_getinfo() == True:
                if self.printtask_create(self.task_cardinfo) == True:
                    if self.printtask_print() == True:

                        time.sleep(10)
                        self.task_estimate_time = self.printtask_get_estimatetime(self.task_taskID)
                        time.sleep(int(self.task_estimate_time) - 10)
                        if len(self.task_ReportInfos) > 0:
                            for index in range(len(self.task_ReportInfos)):
                                report_dict = self.task_ReportInfos[index]
                                report_id = report_dict.get('ReportID')
                                report_path = report_dict.get('ReportPath')
                                self.printtask_report_download(report_path)
                                self.printtask_report_print(report_id)
                                time.sleep(10)

                        time.sleep(self.task_estimate_time)

                        self.printtask_status_check()
                        if self.task_printtask_status == 4:
                            print("Terminal.terminal_print_with_cardinfo: The task %s print successfully, the "
                                  "task status is %s \n"
                                  % (self.task_taskID,
                                     self.task_printtask_status_dict.get(str(self.task_printtask_status))))
                            return True
                        else:
                            print("Terminal.terminal_print_with_cardinfo: The task %s print failed, the "
                                  "task status is %s \n"
                                  % (self.task_taskID,
                                     self.task_printtask_status_dict.get(str(self.task_printtask_status))))
                            return False
                    else:
                        print("Terminal.terminal_print_with_cardinfo: Print the task failed.\n")
                else:
                    print("Terminal.terminal_print_with_cardinfo: Create the print task failed.\n")
                    '''
                    add integration resopnse to output more information....
                    '''
            else:
                print("Terminal.terminal_print_with_cardinfo: There are no report need to print for the patient.\n")
                if self.printtask_create(self.task_cardinfo) == True:
                    if self.printtask_print() == True:

                        self.task_estimate_time = self.printtask_get_estimatetime(self.task_taskID)
                        time.sleep(self.task_estimate_time * 2)

                        self.printtask_status_check()
                        if self.task_printtask_status == 4:
                            print("Terminal.terminal_print_with_cardinfo: The task %s print successfully, the "
                                  "task status is %s \n"
                                  % (self.task_taskID,
                                     self.task_printtask_status_dict.get(str(self.task_printtask_status))))
                            return True
                        else:
                            print("Terminal.terminal_print_with_cardinfo: The task %s print failed, the "
                                  "task status is %s \n"
                                  % (self.task_taskID,
                                     self.task_printtask_status_dict.get(str(self.task_printtask_status))))
                            return False
                    else:
                        print("Terminal.terminal_print_with_cardinfo: Print the task failed.\n")

        else:
            print("Terminal.terminal_print_with_cardinfo: The terminal status is not ready, please check.\n")
        #except Exception:
            #raise Exception("Terminal.terminal_print_with_cardinfo: Function execute failed.")

    '''
    Check the terminal status.
    URL: http://10.112.13.234/EHDPS/status?tid=terminalID
    Method: Get 
    '''

    def check_terminal_status(self, terminal_name):
        self.terminal_name = terminal_name
        try:
            params_content = {'tid': self.terminal_name}
            response = requests.get(self.EHDPS_status_url, params=params_content)
        except requests.HTTPError as e:
            status_code = e.response.status_code
            raise Exception("Terminal._check_status:The http request send failed and Http return code is: "
                            + (str(status_code)))

        if response.status_code == 200:
            print("Terminal._check_terminal_status: The terminal status check and result is:\n %s"
                  % (response.content.decode('utf-8', 'ignore')))
            self.terminal_status_info = response.content.decode('utf-8', 'ignore')

            res_dict = response.json()
            if res_dict.get('Status') == 0:
                self.terminal_status = "OK"
                return True

            if res_dict.get('Status') == 1:
                self.terminal_status = "Error"
                return False

            if res_dict.get('Status') == 2:
                self.terminal_status = "Exception"
                return False
        else:
            raise Exception(
                "Terminal._check_status:The http request return code is not 200, the value is : " \
                + (str(response.status_code)))

    '''
    Check the terminal status.
    URL: :http://10.112.13.234/EHDPS/printtask/create?tid=terminalID
    Method: Post 
    '''

    def printtask_create(self, cardinfo):
        try:
            post_url = self.EHDPS_printtask_create_url + "?tid=" + self.terminal_name
            self.task_cardinfo = cardinfo
            self.task_request_datetime = str(datetime.now())

            post_json = {'CardInfo': {'Value': '' + self.task_cardinfo + '', 'Type': '' + str(self.input_type) + ''},
                         'RequestId': '' + str(self.task_request_id) + '',
                         'RequestDate': '' + self.task_request_datetime + ''}
            response = requests.post(url=post_url, json=post_json)

            print("Terminal.create_film_printtask: The terminal film print create and response is:\n %s" % (
                response.content.decode('utf-8', 'ignore')))
            self.EHDPS_printtask_create_info = response.content.decode('utf-8', 'ignore')

            if response.status_code == 200:
                res_dict = response.json()

                if res_dict.get('Status') == 0:
                    self.task_status = "OK"
                    print("Terminal.create_film_printtask: The taskID is %s" % (res_dict.get('Entity').get('TaskId')))
                    self.task_taskID = res_dict.get('Entity').get('TaskId')
                    return True

                if res_dict.get('Status') == 1:
                    self.task_status = "Error"
                    return False

                if res_dict.get('Status') == 2:
                    self.task_status = "Exception"
                    return False
            else:
                raise Exception("Terminal.create_film_printtask: The response http retrun code is not 200: "
                                + str(response.status_code))
        except Exception as e:
            raise Exception("Terminal.create_film_printtask: Fucntion execute failed. \n")

    '''
    Print the print task
    URL: http://10.112.13.234/EHDPS/printtask/print/{taskId}?tid=terminalID
    Method: Post 
    '''

    def printtask_print(self):
        try:
            post_url = self.EHDPS_printtask_print_url + self.task_taskID + "?tid=" + self.terminal_name
            post_json = {'RequestId': '' + str(self.task_request_id) + '',
                         'RequestDate': '' + self.task_request_datetime + ''}
            response = requests.post(url=post_url, json=post_json)

            print("Terminal.printtask_print: The terminal print task print response is:\n %s" % (
                response.content.decode('utf-8', 'ignore')))
            self.EHDPS_printtask_print_info = response.content.decode('utf-8', 'ignore')

            if response.status_code == 200:
                res_dict = response.json()

                if res_dict.get('Status') == 0:
                    self.task_status = "OK"
                    return True

                if res_dict.get('Status') == 1:
                    self.task_status = "Error"
                    return False

                if res_dict.get('Status') == 2:
                    self.task_status = "Exception"
                    return False
            else:
                raise Exception("Terminal.printtask_print: : The request return code is not 200. value is : %s")
        except Exception:
            raise Exception("Terminal.Terminal.printtask_print: : Fucntion execute failed.")

    '''
    Get the report information , get the rreport status, id and other information.
    URL: http://10.112.13.234/EHDPS/printtask/items?Value={cardinfo}}&Type=0?tid=terminalID
    Method: Post 
    '''

    def printtask_report_getinfo(self):
        try:
            get_url = self.EHDPS_printtask_report_getinfo_url + "?Value=" + self.task_cardinfo + "&Type=0" + "&tid=" \
                      + self.terminal_name
            response = requests.get(get_url)
            EHDPS_printtask_report_getinfo_info = response.content.decode('utf-8', 'ignore')
            print("Terminal.printtask_report_getinfo: get the report information by cardiinfo: \n"
                  + EHDPS_printtask_report_getinfo_info)

            if response.status_code == 200:
                res_dict = response.json()

                if res_dict.get('Status') == 0:
                    self.task_status = "OK"
                    entity_dict = res_dict.get('Entity')
                    examItems_list = entity_dict.get('ExamItems')

                    for exam_item_index in range(len(examItems_list)):
                        examItems_dict = examItems_list[exam_item_index]
                        status = examItems_dict.get('Status')
                        if status.upper() == "Unprinted".upper():
                            reportInfos_list = examItems_dict.get('ReportInfos')
                            for report_index in range(len(reportInfos_list)):
                                reportinfo_dict = reportInfos_list[report_index]
                                self.task_ReportInfos.append(reportinfo_dict)
                        return True

                if res_dict.get('Status') == 1:
                    self.task_status = "Error"
                    return False

                if res_dict.get('Status') == 2:
                    self.task_status = "Exception"
                    return False

        except Exception:
            print("Terminal.printtask_report_getinfo: Fucntion execute failed.")
            return False

    '''
    Download the report file.
    URL: Report URL http://10.112.20.84/ImageSuite/Web/report/pdfviewer.aspx?id=231bcaa85c974b6d805d02b6a1b6270b
    Method: get 
    '''

    def printtask_report_download(self, url):
        try:
            response = requests.get(url)
            if response.status_code == 200:
                print("Terminal.printtask_report_download: download the file successfully from: \n%s"
                      % (url))
                self.task_status = "OK"
                return True
            else:
                self.task_status = "Error"
                print("Terminal.printtask_report_download: The response return code is: %s" % (response.status_code))
                return False
        except Exception:
            raise Exception("Terminal.printtask_report_download: Fucntion execute failed.")

    '''
    Set the report print status to successfully.
    URL: :http://10.112.13.234/EHDPS/printtask/report/{taskId}/{reportId}/1?tid=terminalid
    Method: POST 
    '''

    def printtask_report_print(self, report_id):
        try:
            post_url = self.EHDPS_printtask_report_print_url + str(self.task_taskID) + "/" + str(
                report_id) + "/1?tid=" + self.terminal_name
            post_json = {'RequestId': '' + self.task_request_id + '',
                         'RequestDate': '' + self.task_request_datetime + ''}
            response = requests.post(url=post_url, json=post_json)
            self.EHDPS_printtask_report_print_info = response.content.decode('utf-8', 'ignore')
            print("Terminal.printtask_report_print: The report %s print response is:\n %s" % (
                report_id, response.content.decode('utf-8', 'ignore')))

            if response.status_code == 200:
                res_dict = response.json()

                if res_dict.get('Status') == 0:
                    self.task_status = "OK"
                    return True

                if res_dict.get('Status') == 1:
                    self.task_status = "Error"
                    return False

                if res_dict.get('Status') == 2:
                    self.task_status = "Exception"
                    return False
            else:
                raise Exception("Terminal.printtask_report_print: The request return code is not 200. value is : %s")


        except Exception:
            raise Exception("Terminal.printtask_report_print: Fucntion execute failed.")

    '''
    Check the printtask status
    URL: http://10.112.13.234/EHDPS/printtask/status/{taskId}?tid={terminalid}.
    Method: POST 
    '''

    def printtask_status_check(self):
        try:
            get_url = self.EHDPS_printtask_status_url + self.task_taskID + "?tid=" + self.terminal_name
            response = requests.get(get_url)

            self.EHDPS_printtask_status_info = response.content.decode('utf-8', 'ignore')
            print("Terminal.printtask_status_check: The terminal print task status check response is:\n %s"
                  % (self.EHDPS_printtask_status_info))

            if response.status_code == 200:
                res_dict = response.json()

                if res_dict.get('Status') == 0:
                    self.task_status = "OK"
                    entity_dict = res_dict.get('Entity')
                    self.task_printtask_status = entity_dict.get('Status')
                    return True

                if res_dict.get('Status') == 1:
                    self.task_status = "Error"
                    return False

                if res_dict.get('Status') == 2:
                    self.task_status = "Exception"
                    return False
        except Exception:
            raise Exception("Terminal.printtask_status_check: Fucntion execute failed.")

    def printtask_get_estimatetime(self, printtask_id):
        try:
            time.sleep(30)
            self.task_taskID = printtask_id
            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            cursor.execute('''SELECT EstimateTime
                            FROM WGGC.dbo.AFP_PrintTask 
                            WHere SN = ?
                                       ''', [self.task_taskID])
            rows = cursor.fetchall()
            conn.close()
            if len(rows) > 0:
                self.task_estimate_time = rows[0][0]
                print("Terminal.printtask_get_estimatetime: The estimate time is %d of task %s \n"
                      % (self.task_estimate_time, self.task_taskID))
                return rows[0][0]
            else:
                raise Exception("Terminal.printtask_get_estimatetime: Cannot find the estimate time from task %s \n"
                                % (self.task_taskID))

        except Exception:
            raise Exception("Terminal.printtask_get_estimatetime: Fuction execute failed.")


'''
***************************Debug****************************
'''
# terminal = Terminal()

# terminal.terminal_print_with_cardinfo('BVT_K2', "A20190903100232868265")


#terminal = Terminal()

#terminal.check_terminal_status('K3_Terminal01')
'''
terminal.task_cardinfo = "A20190808102536531938"



terminal.printtask_report_getinfo()

terminal.printtask_create(terminal.task_cardinfo)
terminal.printtask_print()
terminal.printtask_status_check()

for index in range(len(terminal.task_ReportInfos)):
    report_dict = terminal.task_ReportInfos[index]
    report_id = report_dict.get('ReportID')
    report_path = report_dict.get('ReportPath')
    print(report_id)
    terminal.printtask_report_download(report_path)
    time.sleep(10)
    terminal.printtask_report_print(report_id)
    print(terminal.EHDPS_printtask_report_print_info)
Terminal.printtask_status_check()
'''
