# -*- coding : utf-8 -*-
from os import getcwd
import os
import subprocess
import time
import glob

current_path = getcwd()
sample_dicom_file_path = "sample.dcm"
sample_sp_dicom_file_folder = current_path + "\database\\"
dcmprscu_app = "dcmprscu.exe"
dcmpstat_cfg = "dcmpstat.cfg.scu"
dcmpsprt_app = "dcmpsprt.exe"
dcmprinters_cfg = "printers.cfg"

for file in os.listdir(sample_sp_dicom_file_folder):
    os.remove(os.path.join(sample_sp_dicom_file_folder, file))
time.sleep(5)

os.chdir(current_path)
subprocess.run([dcmpsprt_app, "-v", "-c", dcmpstat_cfg, "--printer", "IHEFULL",sample_dicom_file_path])

time.sleep(5)

os.chdir(sample_sp_dicom_file_folder)
dcm_list = glob.glob("SP_*.dcm")
if dcm_list.__len__() == 1:
    dcm_file = sample_sp_dicom_file_folder + dcm_list[0]
    os.chdir(current_path)
    subprocess.run([dcmprscu_app, "-d", "-v", "-c", dcmpstat_cfg,"--copies", "1", dcm_file])

time.sleep(10)
