using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using namespace_DataOperation;
using nameSpace_FodlerFileOperation;
using System.Diagnostics;
using System.Threading;
using log4net;

namespace Webservicedemo
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class CreateFilmTestData : System.Web.Services.WebService
    {
        private static log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
   

        [WebMethod]
        public bool QueryResult(string strACCN)
        {
            DataOperation DataObject = new DataOperation();
            bool flag;
            flag = DataObject.CheckDistinctResultFromTableByACCN(strACCN);
            if (flag)
            {
                log.Info("The film " + strACCN + "  has archived successfully!");
            }
            else
            {
                log.Error("The film " + strACCN + "  has archived failed!");
            }

            return flag;
        }

        [WebMethod]
        public string CreateFilmFile(string strfilename, string strDate, string strtime, string strPID, string strStudyInstanceUID, string strSeriesInstanceUID, string strSOPInstanceID, string strAccNo, string strPatientName, string strGrender, string strModality, string strBodayPart, string strDestFolder)
        {
            string strCurrentFolderPath, strExecuteBatpath, strExecuteBatNewPath, strDICOMPath,strAPPPath;
            string strNewBatPath, strNewDicomPath, strNewAPPPath;
            //get current folder
            strCurrentFolderPath = System.AppDomain.CurrentDomain.BaseDirectory;

            #region Copy the files and applications 
            //create a mew temp folder by accn
            string tempFolder = System.IO.Path.Combine(strCurrentFolderPath, strAccNo);
            System.IO.Directory.CreateDirectory(tempFolder);

            Random ran = new Random();
            int waitMiseSeconds = ran.Next(1000, 10000);
          
                //Copy the sample bat and dicom file to temp folder
                strExecuteBatpath = System.IO.Path.Combine(strCurrentFolderPath, @"Sample.bat");
                strDICOMPath = System.IO.Path.Combine(strCurrentFolderPath, @"CR_new.dcm");
                strAPPPath = System.IO.Path.Combine(strCurrentFolderPath, @"dcmodify.exe");
                strNewBatPath = System.IO.Path.Combine(tempFolder, @"Sample.bat");
                strNewDicomPath = System.IO.Path.Combine(tempFolder, @"CR_new.dcm");
                strNewAPPPath = System.IO.Path.Combine(tempFolder, @"dcmodify.exe");
                bool copyflag;
                copyflag = true;
                while (copyflag) {
                     try 
                    {
                        System.IO.File.Copy(strExecuteBatpath, strNewBatPath);
                        copyflag = false;
                    }
                    catch (Exception)
                     {
                         Thread.Sleep(waitMiseSeconds);
                         log.Warn("Copy sampleBat file failed.");
                         copyflag = true;
                    }
                }
                log.Info("Copy sampleBat file successfully.");

                copyflag = true;
                while (copyflag) {
                     try 
                    {
                        System.IO.File.Copy(strDICOMPath, strNewDicomPath);
                        copyflag = false;
                    }
                    catch (Exception)
                     {
                         Thread.Sleep(waitMiseSeconds);
                         log.Warn("Copy sample DICOM  file failed.");
                         copyflag = true;
                    }
                }
                log.Info("Copy sample DICOM  file successfully.");


                copyflag = true;
                while (copyflag) {
                     try 
                    {
                        System.IO.File.Copy(strAPPPath, strNewAPPPath);
                        copyflag = false;
                    }
                    catch (Exception)
                     {
                         Thread.Sleep(waitMiseSeconds);
                         log.Warn("Copy DCMModify application failed.");
                         copyflag = true;
                    }
                }

                log.Info("Copy DCMModify application successfully.");

            #endregion

            //Get the patient exist or not 
            DataOperation DataObject = new DataOperation();
            bool flag;
            flag = DataObject.CheckDistinctResultFromTableByACCN(strAccNo);
            if (flag == false)
            {
                #region bat text process
                try
                {
                    string BatText = System.IO.File.ReadAllText(strNewBatPath);
                    BatText = BatText.Replace("strfilename", strfilename);
                    BatText = BatText.Replace("strDate", strDate);
                    BatText = BatText.Replace("strtime", strtime);
                    BatText = BatText.Replace("strPID", strPID);
                    BatText = BatText.Replace("strStudyInstanceUID", strStudyInstanceUID);
                    BatText = BatText.Replace("strSeriesInstanceUID", strSeriesInstanceUID);
                    BatText = BatText.Replace("strSOPInstanceID", strSOPInstanceID);
                    BatText = BatText.Replace("strAccNo", strAccNo);
                    BatText = BatText.Replace("strPatientName", strPatientName);
                    BatText = BatText.Replace("strGrender", strGrender);
                    BatText = BatText.Replace("strModality", strModality);
                    BatText = BatText.Replace("strBodayPart", strBodayPart);
                    BatText = BatText.Replace("strDestFolder", strDestFolder);
                    strExecuteBatNewPath = System.IO.Path.Combine(tempFolder, strAccNo + " .bat");
                    System.IO.File.WriteAllText(strExecuteBatNewPath, BatText);
                }
                catch(Exception ex)
                {
                    log.Error("Create execute bat file to modify dicm file failed.",ex);
                    return "Write bat file failed";
                }
                #endregion

                #region Execute the bat file
                try
                {
                    Process proc = null;
                    proc = new Process();
                    proc.StartInfo.WorkingDirectory = tempFolder;
                    proc.StartInfo.FileName = strAccNo + " .bat";
                    proc.StartInfo.CreateNoWindow = true;
                    proc.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
                    proc.Start();
                    proc.WaitForExit();
                    proc.Close();
                }
                catch(Exception ex)
                {
                    log.Error("Execute bat file to modify dicm file failed.", ex);
                    return "execute bat file failed.";
                }
                #endregion 

                Thread.Sleep(10000);

                #region delete the related files and folder
                
                bool deletFlag;

                deletFlag = true;
                while (deletFlag)
                {
                    try
                    {
                        System.IO.File.Delete(strExecuteBatNewPath);
                        deletFlag = false;
                    }
                    catch (Exception)
                    {
                        Thread.Sleep(waitMiseSeconds);
                        log.Warn("Delete modify bat file (" + strExecuteBatNewPath + " .bat) failed.will try again");
                        deletFlag = true;
                    }
                }

                log.Info("Delete " + strExecuteBatNewPath + " successfully");

                deletFlag = true;
                while (deletFlag)
                {
                    try
                    {
                        System.IO.File.Delete(strNewBatPath);
                        deletFlag = false;
                    }
                    catch (Exception)
                    {
                        Thread.Sleep(waitMiseSeconds);
                        log.Warn("Delete sample modify bat file(" + strNewBatPath + " ) failed.will try again");
                        deletFlag = true;
                    }
                }
                log.Info("Delete " + strNewBatPath + " successfully");


                deletFlag = true;
                while (deletFlag)
                {
                    try
                    {
                        System.IO.File.Delete(strNewDicomPath);
                        deletFlag = false;
                    }
                    catch (Exception)
                    {
                        Thread.Sleep(waitMiseSeconds);
                        log.Warn("Delete sample DICOM file(" + strNewDicomPath + " ) failed.will try again");
                        deletFlag = true;
                    }
                }

                log.Info("Delete " + strNewDicomPath + " successfully");

                deletFlag = true;
                while (deletFlag)
                {
                    try
                    {
                        System.IO.File.Delete(strNewAPPPath);
                        deletFlag = false;
                    }
                    catch (Exception)
                    {
                        Thread.Sleep(waitMiseSeconds);
                        log.Warn("Delete application file(" + strNewAPPPath + " ) failed.will try again");
                        deletFlag = true;
                    }
                }

                log.Info("Delete " + strNewAPPPath + " successfully");

                deletFlag = true;
                while (deletFlag)
                {
                    try
                    {
                        System.IO.Directory.Delete(tempFolder);
                        deletFlag = false;
                    }
                    catch (Exception ex)
                    {
                        Thread.Sleep(waitMiseSeconds);
                        log.Error("Delete temp folder  " + tempFolder + " failed.",ex);
                        deletFlag = true;
                    }
                }
                


                if (System.IO.Directory.Exists(tempFolder))
                {
                    log.Error("Delete " + tempFolder + " failed");
                    
                }
                else
                {
                    log.Info("Create new dicom file to PS successfully.");
                    
                }
                
                #endregion

                Thread.Sleep(10000);
                
                bool rt_flag;
                rt_flag = DataObject.CheckDistinctResultFromTableByACCN(strAccNo);
                int intervalCount = 0;
                
                while (intervalCount < 3 && rt_flag == false)
                {
                    intervalCount = intervalCount + 1;
                    rt_flag = DataObject.CheckDistinctResultFromTableByACCN(strAccNo);
                }

                if(rt_flag)
                {
                    log.Info("Archive new Film to PS successfully.");
                    return "true";
                }
                else
                {
                    log.Error("Archive new Film to PS failed.");
                    return "false";                
                }

            }
            log.Warn("The PS has exist the film record(accession number is " + strAccNo + " ) in database,please change the accession and try again.");

            return "record exist! The accession number is:" + strAccNo;

        }
           

        }
    
}
