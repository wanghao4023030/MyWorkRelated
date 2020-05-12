# -*- coding : utf-8 -*-
'''
Designer: Ralf wang
Mail:   hao.wang@carestream.com
Date: 2019-08-05
Reviewer:
Design the film class and include related methond.
'''
import glob
import json
import os
import subprocess
import time
from datetime import datetime

import pyodbc

from PUMA_ParameterAndSettings.Configurationlib import Configurationlib

'''
Init the parameters
'''
settings = Configurationlib()

class Film(object):
    def __init__(self):
        try:
            self.Status = ""
            self.PatientID = ""
            self.AccessionNumber = ""
            self.FilmSessionLable = ""
            self.DeliveryJob_status = ""

            self.WaterMark_Path = settings.watermark_path
            self.WaterMark_OutputText2BMP_path = self.WaterMark_Path + "\OutputText2BMP.exe"
            self.WaterMark_TextSize = "20"
            self.WaterMark_BMPName = "Demo.bmp"
            self.WaterMark_ImageFolder = self.WaterMark_Path + "\images"
            self.WaterMark_SampleDicom = self.WaterMark_Path + "\sample.dcm"
            self.WaterMark_App = self.WaterMark_Path + "\WaterMark.exe"
            self.WaterMark_ProcessDCM = self.WaterMark_ImageFolder + "\sample.dcm"

            self.SCU_Path = self.WaterMark_Path  + "\SCU"
            self.SCU_dcmpsprt_app = self.SCU_Path + "\dcmpsprt.exe"
            self.SCU_printers_cfg = self.SCU_Path + "\printers.cfg"
            self.SCU_dcmprscu_app = self.SCU_Path + "\dcmprscu.exe"
            self.SCU_dcmpstat_cfg = self.SCU_Path + "\dcmpstat.cfg.scu"
            self.SCU_database = self.SCU_Path + "\database"
        except Exception as e:
            print("Object Film : Init the object failed.")
            print(type(e))
            raise Exception(e)

    def film_create_film_with_sample(self, patient_id, accession_number):
        """film create film with sample

        This function will modify the sample dicom file with parameters and
        print it to PS

        :param patient_id: patientID of patient or exam which you want to print.

        :param accession_number: accession number of patient which you want to print.

        :return: film object with dict type

        --Ralf wang 19005260
        """

        '''
        datetime_stamp = str(datetime.now().strftime('%Y%m%d%H%M%S%f'))
        self.PatientID = "P" + datetime_stamp
        self.AccessionNumber = "A" + datetime_stamp
        '''
        try:
            self.PatientID = patient_id
            self.AccessionNumber = accession_number
            self.FilmSessionLable = str(datetime.now().strftime('%Y%m%d%H%M%S%f'))
        except Exception as e:
            print("Film.film_create_film_with_sample: The function execute failed. ")
            print(type(e))
            raise Exception(e)

        self._create_waterBMP()
        self._copy_sampleDciom()
        self._add_waterMark()

        self._printer_createDCM()
        self._printer_printDCM()

        for count in range(1, 31):
            time.sleep(10)
            archive_result = self._random_archive_check()

            if archive_result == 2:
                self.Status = True
                self.DeliveryJob_status = archive_result
                return_content = json.dumps(self.__dict__)
                print("Film.film_create_film_with_sample:Film archived successfully: %s" %(return_content))
                return return_content

            if archive_result == 8 or archive_result == 9:
                self.Status = False
                self.DeliveryJob_status = archive_result
                return_content = json.dumps(self.__dict__)
                print("Film.film_create_film_with_sample:Film archived failed: %s" % (return_content))
                return return_content



    def film_check_archive_in_filminfo_table(self):
        """film_check_archive_in_filminfo_table

        This function is to check the film archived in wggc.dbo.afp_filminfo table result which printed to PS.

        NOTE: This function should used after DICOM print operation and make sure the patient property:
         filmsessionlable have value!

        Select the StudyInstanceUID from printer.dbo.DeliveryJob with column FilmSessionLable. Then select the count
        of records in wggc.dbo.afp_filminfo with StudyInstanceUID

        select count(*) as count from wggc.dbo.AFP_FilmInfo where StudyInstanceUID in(
        select StudyInstanceUID from printer.dbo.DeliveryJob where FilmSessionLabel = str(self.FilmSessionLable))

        :return: bool value True|False

        --ralf wang 19005260
        """

        if self.FilmSessionLable == "":
            raise Exception("Film.film_check_archive_in_filminfo_table: The film filmsessionlable is empty."
                  "The film is not print to PS, please print a film first.")
            return False
        else:
            try:
                conn = pyodbc.connect(settings.db_connectString)
                cursor = conn.cursor()
                cursor.execute('''SELECT count(*) as count 
                                FROM wggc.dbo.AFP_FilmInfo
                                WHERE StudyInstanceUID in(
                                    SELECT StudyInstanceUID 
                                    FROM printer.dbo.DeliveryJob 
                                    WHERE FilmSessionLabel = ?)
                                            ''', [str(self.FilmSessionLable)])
                rows = cursor.fetchall()
                conn.close()

                if rows[0][0] == 1:
                    print("Film.film_check_archive_in_filminfo_table:There is [%d] records for patient[%s, %s] "
                          "and filmsessionlable is [%s]"
                          %(rows[0][0], self.PatientID, self.AccessionNumber, self.FilmSessionLable))
                    return True
                else:
                    print("Film.film_check_archive_in_filminfo_table: Data exception!")
                    print("Film.film_check_archive_in_filminfo_table:There is [%d] records for patient[%s, %s] "
                          "and filmsessionlable is [%s]"
                          % (rows[0][0], self.PatientID, self.AccessionNumber, self.FilmSessionLable))
                    return False
            except Exception as e:
                print("Film.film_check_archive_in_filminfo_table: Function execute with error: ")
                print(type(e))
                raise Exception(e)



    def film_check_archive_in_examinfo_table(self):
        """film_check_archive_in_examinfo_table

        This function is to check the film archived in wggc.dbo.afp_examinfo table result which printed to PS.

        NOTE: This function should used after DICOM print operation and make sure the patient property:
        patientid, accession number,filmsessionlable have value!

        Select the StudyInstanceUID from printer.dbo.DeliveryJob with column FilmSessionLable. Then select the count
        of records in wggc.dbo.afp_filminfo with StudyInstanceUID

        Select the count of exist films of this patient with PID and ACCN if exist.

        select count(*) as count from wggc.dbo.AFP_FilmInfo where StudyInstanceUID not in(
        select StudyInstanceUID from printer.dbo.DeliveryJob where FilmSessionLabel = str(self.FilmSessionLable))

        The imagecounts should be summary of upon.

        :return: bool value True|False

        --ralf wang 19005260
        """

        if self.FilmSessionLable == "":
            raise Exception("Film.film_check_archive_in_filminfo_table: The film filmsessionlable is empty."
                  "The film is not print to PS, please print a film first.")
            return False
        else:
            '''
            Get the film count which archived successfullly in printer database.
            '''
            try:
                conn = pyodbc.connect(settings.db_connectString)
                cursor = conn.cursor()
                cursor.execute('''SELECT count(*) as count 
                                FROM wggc.dbo.AFP_FilmInfo
                                WHERE StudyInstanceUID in (
                                    SELECT StudyInstanceUID 
                                    FROM printer.dbo.DeliveryJob 
                                    WHERE FilmSessionLabel = ? 
                                    AND JobStatus = 2)
                                            ''', [str(self.FilmSessionLable)])
                rows = cursor.fetchall()
                newfilm_count = rows[0][0]
                conn.close()
            except Exception as e:
                print("Film.film_check_archive_in_examinfo_table: "
                      "Try to get the archived film count from database failed. ")
                print(type(e))
                raise Exception(e)

            '''
            Get the exist films with patient ID, Name and FilmSessionlable
            '''
            try:
                conn = pyodbc.connect(settings.db_connectString)
                cursor = conn.cursor()
                cursor.execute('''SELECT count(*) as count 
                                FROM wggc.dbo.AFP_FilmInfo
                                WHERE StudyInstanceUID not in (
                                    SELECT StudyInstanceUID 
                                    FROM printer.dbo.DeliveryJob 
                                    WHERE FilmSessionLabel = ?)
                                AND  AccessionNumber =? 
                                AND PatientID = ?
                                ''', [str(self.FilmSessionLable), str(self.AccessionNumber), str(self.PatientID)])
                rows = cursor.fetchall()
                existfilm_count = rows[0][0]
                conn.close()
            except Exception as e:
                print("Film.film_check_archive_in_examinfo_table: "
                      "Try to get the existed film count from database failed. ")
                print(type(e))
                raise Exception(e)

            '''
            Get the image count from the examinfo table in the database.
            '''
            try:
                conn = pyodbc.connect(settings.db_connectString)
                cursor = conn.cursor()
                cursor.execute('''SELECT
                ImageCount
                FROM wggc.dbo.AFP_ExamInfo 
                WHERE AccessionNumber =? 
                AND PatientID = ? 
                 ''', [str(self.AccessionNumber), str(self.PatientID)])
                rows = cursor.fetchall()
                conn.close()
            except Exception as e:
                print("Film.film_check_archive_in_examinfo_table: "
                      "Try to get the film count from database failed. ")
                print(type(e))
                raise Exception(e)

            try:
                if len(rows) == 0:
                    print("Film.film_check_archive_in_examinfo_table: There are no film records in wggc.dbo.Examinfo "
                          "of patient [%s, %s]" %(self.AccessionNumber, self.PatientID))
                    return False
                else:
                    exam_imagecout = rows[0][0]
                    if newfilm_count == 0:
                        if exam_imagecout == existfilm_count:
                            print("Film.film_check_archive_in_examinfo_table: There are no new records archived in "
                                  "wggc.dbo.Examinfo for film of patient [%s, %s]"
                                  %(self.AccessionNumber, self.PatientID))
                            return False
                        else:
                            print("Film.film_check_archive_in_examinfo_table: Data Exception for patient [%s, %s]"
                                  % (self.AccessionNumber, self.PatientID))
                            print("Film.film_check_archive_in_examinfo_table: There are [%d] records in filminfo table "
                                  %(existfilm_count))
                            print("Film.film_check_archive_in_examinfo_table: There are [%d] imagecouts in examinfo table "
                                  % (exam_imagecout))
                            return False

                    if newfilm_count > 0:
                        if exam_imagecout == existfilm_count + newfilm_count:
                            print("Film.film_check_archive_in_examinfo_table: There are [%d] new records archived in "
                                  "wggc.dbo.Examinfo for film of patient [%s, %s]"
                                  % (newfilm_count, self.AccessionNumber, self.PatientID))
                            return True
                        else:
                            print("Film.film_check_archive_in_examinfo_table: Data Exception for patient [%s, %s]"
                                  % (self.AccessionNumber, self.PatientID))
                            print("Film.film_check_archive_in_examinfo_table: There are [%d] records in filminfo table "
                                  % (existfilm_count))
                            print(
                                "Film.film_check_archive_in_examinfo_table: There are [%d] imagecouts in examinfo table "
                                % (exam_imagecout))
                            print(
                                "Film.film_check_archive_in_examinfo_table: There are [%d] records in delivery table "
                                % (newfilm_count))
                            return False
            except Exception as e:
                print("Film.film_check_archive_in_examinfo_table: "
                      "Try to check and compare the result failed. ")
                print(type(e))
                raise Exception(e)


    '''
    This function is create the water mark bmp file. 
    The file will added to the dicm file for new one.
    '''
    def _create_waterBMP(self):
        try:
            if os.path.isdir(self.WaterMark_Path):
                if os.path.isfile(self.WaterMark_OutputText2BMP_path):
                    os.chdir(self.WaterMark_Path)
                    subprocess.run([self.WaterMark_OutputText2BMP_path, self.WaterMark_TextSize, self.PatientID, self.AccessionNumber,
                                    self.WaterMark_BMPName])
                else:
                    raise Exception("film.create_waterBMP: The WaterMark OutputText2BMP.exe not exist:\n %s " % (self.WaterMark_OutputText2BMP_path))
            else:
                raise Exception("film.create_waterBMP: The WaterMark Path is not exist:\n %s " %(self.WaterMarkPath))
        except Exception as e:
            print("film.create_waterBMP: Function execute failed. Create the watermark bmp file failed." )
            print(type(e))
            raise Exception(e)


    '''
    This methond is used to copy the sample files to a assigned folder.
    The DICM will added with wate mark.
    '''
    def _copy_sampleDciom(self):
        try:
            if os.path.isfile(self.WaterMark_SampleDicom):
                os.chdir(self.WaterMark_Path)
                os.system("copy " + '"' + self.WaterMark_SampleDicom + '" ' + '"' + self.WaterMark_ImageFolder + '"'+ " /Y")
            else:
                raise Exception("film.copy_sampleDciom: The WaterMark Sample dicom (sample.dcm) is not exist:\n %s "
                                % (self.WaterMark_SampleDicom))
        except Exception as e:
            print("film.copy_sampleDciom: Function execute failed. Copy the dicom failed to image folder failed." )
            print(type(e))
            raise Exception(e)

    '''
    This methond is used to add water mark to assigned dicom.
    The dicom will prepare to print to PS system.
    '''
    def _add_waterMark(self):
        try:
            if os.path.isfile(self.WaterMark_App):
                os.chdir(self.WaterMark_Path)
                os.system(self.WaterMark_App + ' ' + self.WaterMark_ProcessDCM )
                #print('"'+ self.WaterMark_App + '"' + ' "' + self.WaterMark_ProcessDCM + '"')
            else:
                raise Exception("film.add_waterMark: The watemark application is not exist:\n %s" % (self.WaterMark_App))
        except Exception as e:
            print("add_waterMark: Function execute failed. Add the water mark to DICOM file failed." )
            print(type(e))
            raise Exception(e)

    '''
    Clean the dicom folder and create the DICOM with DVCk tool.
    The DICOM file will print to the PS PUMA system.
    '''
    def _printer_createDCM(self):
        try:
           if os.path.isfile(self.SCU_dcmpsprt_app):
               if os.path.isfile(self.SCU_dcmpstat_cfg):
                   # Clean the dicm files folder
                   for file in os.listdir(self.SCU_database):
                       os.remove(os.path.join(self.SCU_database, file))
                    #Create the DICOM and wait to print.
                   os.chdir(self.SCU_Path)
                   subprocess.run([self.SCU_dcmpsprt_app, "-v", "-c", self.SCU_dcmpstat_cfg, "--printer", "IHEFULL",
                                   self.WaterMark_ProcessDCM])
               else:
                   raise Exception("film.filmprint_createDCM: The dcmpstat configuration file is not exist: %s \n"
                       % (self.SCU_dcmpstat_cfg))
           else:
               raise Exception("film.filmprint_createDCM: The application is not exist: %s \n" % (self.SCU_dcmpsprt_app))
        except Exception as e:
            print("film.filmprint_createDCM: Function execute failed. Create the DICOM with water mark with local tool"
                  " failed.")
            print(type(e))
            raise Exception(e)

    '''
    Print the DICOM to PS system
    '''
    def _printer_printDCM(self):
        try:
            if os.path.isfile(self.SCU_dcmprscu_app):
                if os.path.isfile(self.SCU_dcmpstat_cfg):
                    os.chdir(self.SCU_database)
                    dcm_list = glob.glob("SP_*.dcm")
                    if dcm_list.__len__() == 1:
                        dcm_file = self.SCU_database + "\\" + dcm_list[0]
                        os.chdir(self.SCU_Path)
                        subprocess.run([self.SCU_dcmprscu_app, "-d", "-v", "-c", self.SCU_dcmpstat_cfg,
                                        "--copies", "1", dcm_file, "--label", self.FilmSessionLable ])
                    else:
                        raise Exception("film.printer_printDCM: The dcm file count in database is not correct. The dcm files"
                                        " in this folder which begin with SP* is:  %s \n" % (str(dcm_list)))
                else:
                    raise Exception(
                        "film.printer_printDCM: The configuration file is not exist: %s \n" % (self.SCU_dcmpstat_cfg))
            else:
                raise Exception("film.printer_printDCM: The application dcmprscu.exe is not exist: %s \n" % (self.SCU_dcmpsprt_app))
        except Exception as e:
            print("film.printer_printDCM: Execute the function failed. Print the DICOM with water mark to PS failed.")
            print(type(e))
            raise Exception(e)


    '''
    Check the DCM archived successfully or not
    It will return the Jobstatus value in printer.dbo.deluvery table
    '''
    def _random_archive_check(self):
        try:
            conn = pyodbc.connect(settings.db_connectString)
            cursor = conn.cursor()
            cursor.execute('''SELECT JobStatus 
                            FROM printer.dbo.DeliveryJob 
                            WHERE FilmSessionLabel = ?
                            ''', [str(self.FilmSessionLable)])
            rows = cursor.fetchall()
            conn.close()
            if len(rows) != 1:
                raise Exception("Film.random_archive_check: The data is exception, there are %d records return from "
                                "printer.dbo.delivery table. \n "
                                "SELECT JobStatus FROM printer.dbo.DeliveryJob WHERE FilmSessionLabel = %s"
                                %(len(rows), self.FilmSessionLable))
            else:
                return int(rows[0][0])
        except Exception as e:
            print("Film.random_archive_check: The function execute failed. Execute the database query jobstatus"
                  " from Printer.dbo.delivery table with filmsessionLable failed."
                  )
            print(type(e))
            raise Exception(e)

'''
******************************************************************************************************************
***********************************Sample Code********************************************************************
******************************************************************************************************************
'''
'''
film = Film()
film.film_create_film_with_sample("P20190829154642669245", 'A20190829154642669245')
film.film_check_archive_in_examinfo_table()
'''