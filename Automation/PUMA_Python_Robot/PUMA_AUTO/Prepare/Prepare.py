# -*- coding : utf-8 -*-
'''
Designer: Ralf wang
Mail:   hao.wang@carestream.com
Date: 2019-12-10
Reviewer:
Design the ptoject to do the prepare works for PUMA testing works.
'''
from os import getcwd
import subprocess


class Init():
    def __init__(self):
        self.powershell_app = r"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
        self.pwershell_scripts_path = getcwd() + "\\PSScripts\\"
        self.server = "10.112.20.84"

    '''
    Check the printer in the remote server
    '''
    def check_printer_exist(self, printer_name):
        powershell_file = self.pwershell_scripts_path + "CheckPrinter.ps1"
        with open(powershell_file, 'r') as fileobject:
            content = fileobject.read()
        content = content.replace('{server}', self.server).replace('{printerName}', printer_name)

        powershell_temp_file = self.pwershell_scripts_path + "temp.ps1"
        print(content)
        with open(powershell_temp_file, 'w') as fileobject:
            fileobject.write(content)

        powershell_temp_file = str(powershell_temp_file)
        cmd_string = Prepare.powershell_app + " " + powershell_temp_file
        output = subprocess.check_output(cmd_string, shell=True)
        print(output.decode("GBK"))
        if 'true' in str(output.decode('GBK')).lower():
            print("The printer exist in the server [Printer: %s, Server:%s]" % (printer_name, self.server))
            return True
        else:
            print("The printer not exist in the server [Printer:%s,Server:%s]" % (printer_name, self.server))
            return False

    '''
    Copy the folder or files to remote server.
    '''
    def copy_folder_to_dest(self, source, dest):
        powershell_file = self.pwershell_scripts_path + "CopyFoldersFiles.ps1"
        with open(powershell_file, 'r') as fileobject:
            content = fileobject.read()
        content = content.replace('{server}', self.server).replace('{source}', source).replace('{dest}', dest)

        powershell_temp_file = self.pwershell_scripts_path + "temp.ps1"
        print(content)
        with open(powershell_temp_file, 'w') as fileobject:
            fileobject.write(content)

        powershell_temp_file = str(powershell_temp_file)
        cmd_string = Prepare.powershell_app + " " + powershell_temp_file
        output = subprocess.check_output(cmd_string, shell=True)
        print(output.decode("GBK"))
        result = output.decode("GBK").splitlines()

        if 'true' in str(result[-1]).lower():
            print("copy folder or files to dest successfully [source: %s, dest:%s_%s]" % (source, self.server, dest))
            return True
        else:
            print("copy folder or files to dest failed [source: %s, dest:%s_%s]" % (source, self.server, dest))
            return False


    '''
    Execute SQL scripts by SQLCMD to remote server
    TBD
    '''

    '''
    Send the Sample
    '''

Prepare = Init()
Prepare.check_printer_exist("PDFCreator")
Prepare.copy_folder_to_dest(r"D:\Test", r"E:")