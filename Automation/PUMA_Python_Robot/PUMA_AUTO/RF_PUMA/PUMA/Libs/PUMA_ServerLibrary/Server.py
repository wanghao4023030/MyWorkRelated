# -*- coding : utf-8 -*-
'''
Designer: Ralf wang
Mail:   hao.wang@carestream.com
Date: 2020-02-10
Reviewer:
Design the server class and include related methond.
'''

null = None
import subprocess

from PUMA_ParameterAndSettings.Configurationlib import Configurationlib

settings = Configurationlib()


class Server(object):

    def __init__(self):
        self.powershell_path = settings.Serverlib_powershell_scripts_path
        self.server = settings.server

    '''
    Restart the IIS service of server with powershell remote control.
    '''
    def server_restart_IIS(self):
        """
        This function is use the powershell to restart the IIS service in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            powershell_file = self.powershell_path + "\PS_restartIIS.ps1"
            powershell_res_file = self.powershell_path + "\PS_restartIIS_result.txt"

            with open(powershell_file, 'r') as fileobject:
                content = fileobject.read()
            content = content.replace('{server}', self.server)
            output = subprocess.check_output(
                ["powershell.exe", content], stderr=subprocess.STDOUT)
            print(output.decode('GBK'))

            with open(powershell_res_file, 'r', encoding='utf-8') as fileobject:
                powershell_res = fileobject.read()

            if output.decode('GBK').replace('\r\n', '') == powershell_res.replace('\n', ''):
                print("Server.server_restart_IIS: Restart service successfully.")
                return True
            else:
                print("Server.server_restart_IIS: Restart IIS service failed.")
                return False
        except Exception as e:
            print("Server.server_restart_IIS: Fucntion execute failed.")
            print(type(e))
            raise Exception(e)

    '''
    Stop the remote server IIS Service
    '''

    def server_stop_IIS(self):
        """
        This function is use the powershell to stop the IIS service in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            powershell_file = self.powershell_path + "\PS_stopIIS.ps1"
            powershell_res_file = self.powershell_path + "\PS_stopIIS_result.txt"

            with open(powershell_file, 'r') as fileobject:
                content = fileobject.read()
            content = content.replace('{server}', self.server)
            output = subprocess.check_output(
                ["powershell.exe", content], stderr=subprocess.STDOUT)
            print(output.decode('GBK'))

            with open(powershell_res_file, 'r', encoding='utf-8') as fileobject:
                powershell_res = fileobject.read()

            if output.decode('GBK').replace('\r\n', '') == powershell_res.replace('\n', ''):
                print("Server.server_stop_IIS: Stop IIS service successfully.")
                return True
            else:
                print("Server.server_stop_IIS: Stop IIS service failed.")
                return False
        except Exception as e:
            print("Server.server_stop_IIS: Fucntion execute failed.")
            print(type(e))
            raise Exception(e)


    '''
    Start the remote server IIS Service
    '''

    def server_start_IIS(self):
        """
        This function is use the powershell to start the IIS service in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            powershell_file = self.powershell_path + "\PS_startIIS.ps1"
            powershell_res_file = self.powershell_path + "\PS_startIIS_result.txt"

            with open(powershell_file, 'r') as fileobject:
                content = fileobject.read()
            content = content.replace('{server}', self.server)
            output = subprocess.check_output(
                ["powershell.exe", content], stderr=subprocess.STDOUT)
            print(output.decode('GBK'))

            with open(powershell_res_file, 'r', encoding='utf-8') as fileobject:
                powershell_res = fileobject.read()

            if output.decode('GBK').replace('\r\n', '') == powershell_res.replace('\n', ''):
                print("Server.server_start_IIS: Start IIS service successfully.")
                return True
            else:
                print("Server.server_start_IIS: Start IIS service failed.")
                return False
        except Exception as e:
            print("Server.server_start_IIS: Fucntion execute failed.")
            print(type(e))
            raise Exception(e)

    '''
    Remote restart the PS services. 
    '''

    def server_restart_PS_services(self):
        """
        This function is use the powershell to restart the PS realted services in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            stop_result = self.server_stop_PS_services()
            start_result = self.server_start_PS_services()
            if stop_result == True and start_result == True:
                print("Server.server_restart_PS_services: Restart PS services successfully.")
                return True
            else:
                print("Server.server_restart_PS_services: Restart PS services successfully.")
                return False
        except Exception as e:
            print("Server.server_restart_PS_services: Restart PS services failed. Function execute failed.")
            print(type(e))
            raise Exception(e)


    '''
    Start the remote server PS Services
    '''
    def server_stop_PS_services(self):
        """
        This function is use the PowerShell script to stop the PS all realted services in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            powershell_file = self.powershell_path + "\PS_stopPSServices.ps1"
            powershell_res_file = self.powershell_path + "\PS_stopPSServices_result.txt"

            with open(powershell_file, 'r') as fileobject:
                content = fileobject.read()
            content = content.replace('{server}', self.server)
            output = subprocess.check_output(
                ["powershell.exe", content], stderr=subprocess.STDOUT)
            print(output.decode('GBK'))

            with open(powershell_res_file, 'r', encoding='utf-8') as fileobject:
                powershell_res = fileobject.read()

            if powershell_res.replace('\n', '') in output.decode('GBK').replace('\r\n', ''):
                print("Server.server_stop_PS_services: Stop PS services successfully.")
                return True
            else:
                print("Server.server_stop_PS_services: Stop PS services failed.")
                return False
        except Exception as e:
            print("Server.server_stop_PS_services: Fucntion execute failed.")
            print(type(e))
            raise Exception(e)

    '''
    Start the remote server PS Services
    '''
    def server_start_PS_services(self):
        """
        This function is use the PowerShell script to start the PS all realted services in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            powershell_file = self.powershell_path + "\PS_startPSServices.ps1"
            powershell_res_file = self.powershell_path + "\PS_startPSServices_result.txt"

            with open(powershell_file, 'r') as fileobject:
                content = fileobject.read()
            content = content.replace('{server}', self.server)
            output = subprocess.check_output(
                ["powershell.exe", content], stderr=subprocess.STDOUT)
            print(output.decode('GBK'))

            with open(powershell_res_file, 'r', encoding='utf-8') as fileobject:
                powershell_res = fileobject.read()

            if output.decode('GBK').replace('\r\n', '') == powershell_res.replace('\n', ''):
                print("Server.server_start_PS_services: Start PS services successfully.")
                return True
            else:
                print("Server.server_start_PS_services: Start PS services failed.")
                return False
        except Exception as e:
            print("Server.server_start_PS_services: Fucntion execute failed.")
            print(type(e))
            raise Exception(e)


    '''
    Restart the remote server service by name
    '''
    def server_restart_system_service_by_name(self, service_name):
        """
        This function is use the PowerShell script to restart system service with name in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            if self.server_service_check_with_name(service_name):
                stop_result = self.server_stop_system_service_by_name(service_name)
                start_result = self.server_start_system_service_by_name(service_name)
                if stop_result == True and start_result == True:
                    print("Server.server_restart_system_service_by_name: Restart PS services successfully.")
                    return True
                else:
                    print("Server.server_restart_system_service_by_name: Restart PS services successfully.")
                    return False
            else:
                return False

        except Exception as e:
            print("Server.server_restart_PS_services: Restart PS services failed. Function execute failed.")
            print(type(e))
            raise Exception(e)


    '''
    Stop the renmote server service by name
    '''
    def server_stop_system_service_by_name(self, service_name):
        """
        This function is use the PowerShell script to stop system service with name in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            if self.server_service_check_with_name(service_name):
                powershell_file = self.powershell_path + "\PS_stop_Services_by_name.ps1"
                powershell_check_file = self.powershell_path + "\PS_check_Services_by_name.ps1"

                with open(powershell_file, 'r') as fileobject:
                    content = fileobject.read()
                content = content.replace('{server}', self.server).replace('{servicename}', service_name)
                # try to stop
                output = subprocess.check_output(
                    ["powershell.exe", content], stderr=subprocess.STDOUT)
                print(output.decode('GBK'))

                # get service status
                with open(powershell_check_file, 'r') as fileobject:
                    content = fileobject.read()
                content = content.replace('{server}', self.server).replace('{servicename}', service_name)

                output = subprocess.check_output(
                    ["powershell.exe", content], stderr=subprocess.STDOUT)
                print(output.decode('GBK'))
                output = output.decode('GBK').lower()

                if 'stopped' in output and service_name.lower() in output and self.server.lower() in output:
                    print("Server.server_stop_system_service_by_name: Stop services [%s] successfully." % (service_name))
                    return True
                else:
                    print("Server.server_stop_system_service_by_name: Stop services [%s] failed." % (service_name))
                    return False
            else:
                return False

        except Exception as e:
            print("Server.server_stop_system_service_by_name: Fucntion execute failed.")
            print(type(e))
            raise Exception(e)


    '''
    Stop the renmote server service by name
    '''
    def server_start_system_service_by_name(self, service_name):
        """
        This function is use the PowerShell script to start system service with name in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            if self.server_service_check_with_name(service_name):
                powershell_file = self.powershell_path + "\PS_start_Services_by_name.ps1"
                powershell_check_file = self.powershell_path + "\PS_check_Services_by_name.ps1"

                with open(powershell_file, 'r') as fileobject:
                    content = fileobject.read()
                content = content.replace('{server}', self.server).replace('{servicename}', service_name)
                # try to start
                output = subprocess.check_output(
                    ["powershell.exe", content], stderr=subprocess.STDOUT)
                print(output.decode('GBK'))

                # get service status
                with open(powershell_check_file, 'r') as fileobject:
                    content = fileobject.read()
                content = content.replace('{server}', self.server).replace('{servicename}', service_name)

                output = subprocess.check_output(
                    ["powershell.exe", content], stderr=subprocess.STDOUT)
                print(output.decode('GBK'))
                output = output.decode('GBK').lower()

                if 'running' in output and service_name.lower() in output and self.server.lower() in output:
                    print("Server.server_start_service_by_name: Start services [%s] successfully." % (service_name))
                    return True
                else:
                    print("Server.server_start_service_by_name: Start services [%s] failed." % (service_name))
                    return False
            else:
                return False

        except Exception as e:
            print("Server.server_start_service_by_name: Fucntion execute failed.")
            print(type(e))
            raise Exception(e)


    '''
    Restrt the remote server PUMA PS service by name
    '''
    def server_restart_PS_service_by_name(self, service_name):
        """
        This function is use the PowerShell script to restart PS single service with name in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            if self.server_service_check_with_name(service_name):
                stop_result = self.server_stop_PS_service_by_name(service_name)
                start_result = self.server_start_PS_service_by_name(service_name)
                if stop_result == True and start_result == True:
                    print("Server.server_restart_system_service_by_name: Restart PS service [%s] successfully." %
                          service_name)
                    return True
                else:
                    print("Server.server_restart_system_service_by_name: Restart PS services [%s] successfully." %
                    service_name)
                    return False
            else:
                return False

        except Exception as e:
            print("Server.server_restart_system_service_by_name: Restart PS services [%s] failed. Function execute failed." %
                            service_name)
            print(type(e))
            raise Exception(e)

    '''
    Stop the remote server PUMA PS service by name
    '''
    def server_stop_PS_service_by_name(self, service_name):
        """
        This function is use the PowerShell script to stop PS single service with name in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            if self.server_service_check_with_name(service_name):
                powershell_file = self.powershell_path + "\PS_stopPSServic_by_name.ps1"
                powershell_check_file = self.powershell_path + "\PS_check_Services_by_name.ps1"

                with open(powershell_file, 'r') as fileobject:
                    content = fileobject.read()
                content = content.replace('{server}', self.server).replace('{servicename}', service_name)
                # try to stop
                output = subprocess.check_output(
                    ["powershell.exe", content], stderr=subprocess.STDOUT)
                print(output.decode('GBK'))

                # get service status
                with open(powershell_check_file, 'r') as fileobject:
                    content = fileobject.read()
                content = content.replace('{server}', self.server).replace('{servicename}', service_name)

                output = subprocess.check_output(
                    ["powershell.exe", content], stderr=subprocess.STDOUT)
                print(output.decode('GBK'))
                output = output.decode('GBK').lower()

                if 'stopped' in output and service_name.lower() in output and self.server.lower() in output:
                    print("Server.server_stop_PS_service_by_name: Stop services [%s] successfully." % (service_name))
                    return True
                else:
                    print("Server.server_stop_PS_service_by_name: Stop services [%s] failed." % (service_name))
                    return False
            else:
                return False

        except Exception as e:
            print("Server.server_stop_PS_service_by_name: Restart PS services [%s] failed. Function execute failed." %
                            service_name)
            print(type(e))
            raise Exception(e)


    '''
    Start the remote server PUMA PS service by name
    '''
    def server_start_PS_service_by_name(self, service_name):
        """
        This function is use the PowerShell script to start PS single service with name in remote server

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            if self.server_service_check_with_name(service_name):
                powershell_file = self.powershell_path + "\PS_startPSServic_by_name.ps1"
                powershell_check_file = self.powershell_path + "\PS_check_Services_by_name.ps1"

                with open(powershell_file, 'r') as fileobject:
                    content = fileobject.read()
                content = content.replace('{server}', self.server).replace('{servicename}', service_name)
                # try to start
                output = subprocess.check_output(
                    ["powershell.exe", content], stderr=subprocess.STDOUT)
                print(output.decode('GBK'))

                # get service status
                with open(powershell_check_file, 'r') as fileobject:
                    content = fileobject.read()
                content = content.replace('{server}', self.server).replace('{servicename}', service_name)

                output = subprocess.check_output(
                    ["powershell.exe", content], stderr=subprocess.STDOUT)
                print(output.decode('GBK'))
                output = output.decode('GBK').lower()

                if 'running' in output and service_name.lower() in output and self.server.lower() in output:
                    print("Server.server_start_PS_service_by_name: Start services [%s] successfully." % (service_name))
                    return True
                else:
                    print("Server.server_start_PS_service_by_name: Start services [%s] failed." % (service_name))
                    return False
            else:
                return False

        except Exception as e:
            print("Server.server_start_PS_service_by_name: Restart PS services [%s] failed. Function execute failed." %
                            service_name)
            print(type(e))
            raise Exception(e)



    '''
    Check the service exist or not
    '''
    def server_service_check_with_name(self, service_name):
        """
        Check the service exist in the system or not.
        :param service_name:

        :return: bool True|False

        --Ralf Wang 19005260
        """
        try:
            powershell_check_file = self.powershell_path + "\PS_check_Services_by_name.ps1"

            # get service status
            with open(powershell_check_file, 'r') as fileobject:
                content = fileobject.read()
            content = content.replace('{server}', self.server).replace('{servicename}', service_name)

            output = subprocess.check_output(
                ["powershell.exe", content], stderr=subprocess.STDOUT)
            print(output.decode('GBK'))
            output = output.decode('GBK').lower()

            if service_name.lower() in output and self.server.lower() in output:
                print("Server.server_service_check_with_name: The services [%s] exist in system." % (service_name))
                return True
            else:
                print("Server.server_service_check_with_name: THe services [%s] not exist in the system." % (service_name))
                return False
        except Exception as e:
            print("Server.server_service_check_with_name: CHeck the services [%s] and return failed message. Function execute failed. "
                  "THe services is not exist in server" %
                  service_name)
            print(type(e))
            raise Exception(e)



PS = Server()
#PS.server_restart_IIS()
#PS.server_stop_IIS()
#PS.server_start_IIS()
#PS.server_stop_PS_services()
#PS.server_start_PS_services()
#PS.server_restart_PS_services()

#PS.server_restart_system_service_by_name('MSSQL$GCPACSWS')
#PS.server_stop_system_service_by_name('MSSQL$GCPACSWS')
#PS.server_start_system_service_by_name('MSSQL$GCPACSWS')


#PS.server_stop_PS_service_by_name('ImageSuite LRU Service')
#PS.server_start_PS_service_by_name('ImageSuite LRU Service')
#PS.server_restart_PS_service_by_name('ImageSuite LRU Service')

