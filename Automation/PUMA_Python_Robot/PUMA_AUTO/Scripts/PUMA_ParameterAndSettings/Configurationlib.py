# -*- coding : utf-8 -*-
'''
Designer: Ralf wang
Mail:   hao.wang@carestream.com
Date: 2019-07-24
Reviewer:
Oragnize all the parameters and configurations in Json file.
Design the fucntions to offer the Configurationlib and parameters.
'''
import json
import os
from collections import namedtuple
import random
from datetime import datetime, timedelta
null = None
file_path = 'C:\Program Files (x86)\Python37\Lib\site-packages\PUMA_ParameterAndSettings\configuration.json'


class Configurationlib(object):
    def __init__(self):
        if os.path.isfile(file_path):
            with open(file_path, 'r') as fileobject:
                data = fileobject.read()
                try:
                    json_obj = json.loads(data, object_hook=lambda d: namedtuple('json_obj', d.keys())(*d.values()))
                except Exception as e:
                    raise Exception("Configurationlib:  Load the configuration to Json failed.\n ")
                    raise Exception("Configurationlib:  File is:  %s" % (file_path))

                self.server = json_obj.server
                self.modality = eval(json_obj.modality)
                self.bodypart = eval(json_obj.bodypart)
                self.grender = eval(json_obj.grender)
                self.notifyserver_exam_body_content = json_obj.notifyserver_exam_body_content
                self.watermark_path = json_obj.watermark_path
                self.db_connectString = json_obj.db_connectString
                self.db_driver = json_obj.db_driver
                self.db_server = json_obj.db_server
                self.db_default_database = json_obj.db_default_database
                self.db_uid = json_obj.db_uid
                self.db_pwd = json_obj.db_pwd
                self.report_template_file = json_obj.report_template_file
                self.report_file = json_obj.report_file
                self.report_default_printer = json_obj.report_default_printer
                self.report_powershell_path = json_obj.report_powershell_path

                self.Reportstatus_mode_value = eval(json_obj.Reportstatus_mode_value)
                self.Reportstatus_value_mode = eval(json_obj.Reportstatus_value_mode)

                self.EHDPS_status_url = json_obj.EHDPS_status_url
                self.EHDPS_printtask_create_url = json_obj.EHDPS_printtask_create_url
                self.EHDPS_printtask_print_url = json_obj.EHDPS_printtask_print_url
                self.EHDPS_printtask_report_getinfo_url = json_obj.EHDPS_printtask_report_getinfo_url
                self.EHDPS_printtask_report_print_url = json_obj.EHDPS_printtask_report_print_url
                self.EHDPS_printtask_status_url = json_obj.EHDPS_printtask_status_url
                self.EHDPS_printtask_status_dict = eval(json_obj.EHDPS_printtask_status_dict)
                self.EHDUS_upload_report_upload_url = json_obj.EHDUS_upload_report_upload_url
                self.Printmode_dict_mode_value = eval(json_obj.Printmode_dict_mode_value)
                self.Printmode_dict_value_mode = eval(json_obj.Printmode_dict_value_mode)
                self.Integration_URL = json_obj.Integration_URL
                self.Notify_URL = json_obj.Notify_URL
                self.PrintService_URL = json_obj.PrintService_URL
                self.HoldTime_dict_mode_value = eval(json_obj.HoldTime_dict_mode_value)
                self.HoldTime_dict_value_mode = eval(json_obj.HoldTime_dict_value_mode)

                self.Platform_URL = json_obj.Platform_URL
                self.Platform_webapi_worklist_searchWorklist_url = json_obj.Platform_webapi_worklist_searchWorklist_url
                self.Platform_webapi_worklist_searchWorklist_string = eval(json_obj.Platform_webapi_worklist_searchWorklist_string)
                self.Platform_webapi_worklist_searchWorklist_fuzzy_string = eval(json_obj.Platform_webapi_worklist_searchWorklist_fuzzy_string)
                #self.Platform_webapi_worklist_searchWorklist_patienttype = eval(json_obj.Platform_webapi_worklist_searchWorklist_patienttype)
                self.Platform_webapi_worklist_shortcut_API_string = eval(json_obj.Platform_webapi_worklist_shortcut_API_string)
                self.Platform_webapi_worklist_saveShortcut = json_obj.Platform_webapi_worklist_saveShortcut
                self.Platform_webapi_worklist_delete_shortcut_url = json_obj.Platform_webapi_worklist_delete_shortcut_url
                self.Platform_webapi_worklist_delete_shortcut_bodystring = eval(json_obj.Platform_webapi_worklist_delete_shortcut_bodystring)
                self.Platform_webapi_worklist_searchWorklist_shortcut_string = eval(json_obj.Platform_webapi_worklist_searchWorklist_shortcut_string)
                self.Platform_webapi_worklist_filmsinfo_accn_url = json_obj.Platform_webapi_worklist_filmsinfo_accn_url
                self.Platform_webapi_worklist_centralPrint_url = json_obj.Platform_webapi_worklist_centralPrint_url
                self.Platform_webapi_worklist_centralPrint_body_string = eval(json_obj.Platform_webapi_worklist_centralPrint_body_string)
                self.Platform_account_check_loginStatus_url = json_obj.Platform_account_check_loginStatus_url
                self.Platform_webapi_worklist_printEstimateTime_url = json_obj.Platform_webapi_worklist_printEstimateTime_url
                self.Platform_webapi_worklist_printstatus_url = json_obj.Platform_webapi_worklist_printstatus_url
        else:
            raise Exception("File Error", "The file %s is not exist." % (file_path))

    '''
    Random return a modality
    '''

    def random_modality(self):
        modality = self.modality[random.randint(0, len(self.modality) - 1)]
        return modality

    '''
    Random return a bodypart
    '''

    def random_bodypart(self):
        modality_type = self.bodypart[random.randint(0, len(self.bodypart) - 1)]
        return modality_type

    '''
    Random return a gender
    '''

    def random_gender(self):
        grender = self.grender[random.randint(0, len(self.grender) - 1)]
        return grender

    '''
    Random return a brithday
    '''

    def random_brithday(self):
        random_number = random.randint(0, 100)
        random_days = random_number * 365
        brithday = (datetime.now() - timedelta(days=random_days)).strftime('%Y-%m-%d')
        return brithday

    '''
    return the content with string type.
    '''

    def get_notifyserver_exam_body_content(self):
        ret = self.notifyserver_exam_body_content
        return ret

    def test(self):
        pass
