using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.IO;
using System.Diagnostics;
using log4net;
using System.Threading;
namespace WaterMark
{
    class WaterMarkClass
    {
        public string threadCount = ConfigurationManager.AppSettings["ThreadCount"];
        public string executePath = System.AppDomain.CurrentDomain.BaseDirectory;
        log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);


        public string AddWaterMarkByFolder(string WaterMarkPath, string PID, string ACCN)
        {
            try
            {
                CreateWaterBMP(WaterMarkPath, PID, ACCN);
                Thread.Sleep(1000);
                CopyDcmToImage(WaterMarkPath);
                AddWaterMark(WaterMarkPath);
                log.Debug("Add water mark to DICOM file successfully." +WaterMarkPath + " " + PID + " " + ACCN);
                return "true";
            }
            catch (Exception ex)
            {
                log.Error("Add Water Mark by folder failed. " + WaterMarkPath + " " + PID + " " + ACCN);
                return ex.ToString();
            }
        
        }

        //Copy watermark folder with thread count
        public string CreateFolderByThreadCount()
        {
            try
            {
                for (int i = 1; i <= Int32.Parse(threadCount); i++)
                {
                    string strFlage = DeleteFolderALl(executePath + "WaterMark" + i);
                    int count = 0;
                    while (!strFlage.Equals("true") && count < 10)
                    {
                        Thread.Sleep(10 * 1000);
                        strFlage = DeleteFolderALl(executePath + "WaterMark" + i);
                        count = count + 1;
                    }
                    if (count >= 10)
                    {
                        log.Error("Try to delete folder " + executePath + "WaterMark" + i + "failed and retry times is " + count);
                    }

                    if (strFlage.Equals("true"))
                    {
                        log.Info("Finally the folder delete successfully. " + executePath + "WaterMark" + i + " and retry times is " + count);
                    }

                    
                }

                for (int i = 1; i <= Int32.Parse(threadCount); i++)
                {

                    CopyFolderAll(executePath + "WaterMark", executePath + "WaterMark" + i);
                    Thread.Sleep(1000);
                    log.Debug("Copy watermark folder to application folder with threadcount sucessfully. " + executePath + "WaterMark to " + executePath + "WaterMark" + i);
                }
               
                return "true";
            }
            catch (Exception ex)
            {
                log.Error("Copy watermark folder to application folder with threadcount parameter failed. ",ex);
                return ex.ToString();
            }

        }


        private string CreateWaterBMP(string WaterMarkPath, string PID, string ACCN)
        {
            try { 
                    Process proc = null;
                    proc = new Process();
                    proc.StartInfo.WorkingDirectory = WaterMarkPath;
                    proc.StartInfo.FileName = "OutputText2BMP.exe";
                    proc.StartInfo.Arguments = "20 " + PID + " " + ACCN + " Demo.bmp";
                    proc.StartInfo.CreateNoWindow = true;
                    proc.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
                    proc.Start();
                    proc.WaitForExit();
                    proc.Close();
                    proc.Dispose();
                    
                    log.Debug("Create water BMP file successfully. " + WaterMarkPath + " " + proc.StartInfo.FileName.ToString() + " " + proc.StartInfo.Arguments.ToString());
                    return "true";
                }
                catch (Exception ex)
                {
                    log.Error("Create water BMP file failed. ",ex);
                    return ex.ToString();
                }

        }

        //private string CopyDcmToImage(string WaterMarkPath)
        //{
        //    try
        //    {
        //        string fileName = "sample.dcm";
        //        string sourcePath = WaterMarkPath;
        //        string targetPath = WaterMarkPath + @"images";
        //        string ImageFolderPath = WaterMarkPath + @"images";

        //        //delete the FileShare and folders in images folder
        //        try
        //        {
        //            System.IO.DirectoryInfo di = new DirectoryInfo(ImageFolderPath);
        //            foreach (FileInfo file in di.GetFiles())
        //            {
        //                file.Delete();
        //            }

        //            foreach (DirectoryInfo dir in di.GetDirectories())
        //            {
        //                dir.Delete(true);
        //            }

        //            log.Debug("Clean the files from Watermark DIOCM folder successuflly. " + ImageFolderPath);
        //        }
        //        catch (Exception ex)
        //        {
        //            log.Error("Clean the files from WaterMark DIOCM folder failed. " + ImageFolderPath,ex);
        //            return ex.ToString();
        //        }


        //        // Use Path class to manipulate file and directory paths.
        //        string sourceFile = System.IO.Path.Combine(sourcePath, fileName);
        //        string destFile = System.IO.Path.Combine(targetPath, fileName);

        //        // To copy a folder's contents to a new location:
        //        // Create a new target folder, if necessary.
        //        if (!System.IO.Directory.Exists(targetPath))
        //        {
        //            System.IO.Directory.CreateDirectory(targetPath);
        //        }

        //        // To copy a file to another location and 
        //        // overwrite the destination file if it already exists.
        //        System.IO.File.Copy(sourceFile, destFile, true);

        //        log.Debug("Copy the SAMPLE DICOM file to Images folder in WaterMark successfully. " + ImageFolderPath);
        //        return "true";

        //    }
        //    catch (Exception ex)
        //    {
        //        log.Error("Copy the SAMPLE DICOM file to Images folder in WaterMark failed.",ex);
        //        return ex.ToString();
        //    }

        //}

        private string CopyDcmToImage(string WaterMarkPath)
        {
            try
            {
                string fileName = "sample.dcm";
                string sourcePath = WaterMarkPath;
                string targetPath = WaterMarkPath + @"images";
              

                //delete the FileShare and folders in images folder
                System.IO.DirectoryInfo di = new DirectoryInfo(targetPath);
                foreach (FileInfo file in di.GetFiles())
                {
                    file.Delete();
                }
                
                log.Debug("Clean the files from Watermark DIOCM folder successuflly. " + targetPath);


                // Use Path class to manipulate file and directory paths.
                string sourceFile = System.IO.Path.Combine(sourcePath, fileName);
                string destFile = System.IO.Path.Combine(targetPath, fileName);

                // To copy a folder's contents to a new location:
                // Create a new target folder, if necessary.
                if (!System.IO.Directory.Exists(targetPath))
                {
                    System.IO.Directory.CreateDirectory(targetPath);
                }

                // To copy a file to another location and 
                // overwrite the destination file if it already exists.
                System.IO.File.Copy(sourceFile, destFile, true);

                log.Debug("Copy the SAMPLE DICOM file to Images folder in WaterMark successfully. " + targetPath);
                return "true";

            }
            catch (Exception ex)
            {
                log.Error("Copy the SAMPLE DICOM file to Images folder in WaterMark failed.", ex);
                return ex.ToString();
            }

        }

        private string AddWaterMark(string WaterMarkPath)
        {
            string ImageDCMPath = WaterMarkPath + @"images\sample.dcm";

            try
            {
                Process proc = null;
                proc = new Process();
                proc.StartInfo.WorkingDirectory = WaterMarkPath;
                proc.StartInfo.FileName = "WaterMark.exe";
                proc.StartInfo.Arguments = " " + ImageDCMPath;
                proc.StartInfo.CreateNoWindow = true;
                proc.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
                proc.Start();
                proc.WaitForExit();
                proc.Close();
                proc.Dispose();
                
                log.Debug("Add watermark information to DICOM files successfully." + ImageDCMPath);
                return "true";
            }
            catch (Exception ex)
            {
                log.Error("Add watermark information ti DICOM files failed." + ImageDCMPath,ex);
                return ex.ToString();
            }
        }

  

        //Copy watermark folder to other folder
        private string CopyFolderAll(string executePath, string DestinationPath)
        {
            try
            {
                //Now Create all of the directories
                foreach (string dirPath in Directory.GetDirectories(executePath, "*",
                    SearchOption.AllDirectories))
                    Directory.CreateDirectory(dirPath.Replace(executePath, DestinationPath));

                //Copy all the files & Replaces any files with the same name
                foreach (string newPath in Directory.GetFiles(executePath, "*.*",
                    SearchOption.AllDirectories))
                    File.Copy(newPath, newPath.Replace(executePath, DestinationPath), true);

                log.Debug("Copy all waterMark folders and files to application successfully. " + executePath + " to " + DestinationPath);
                return "true";
            }
            catch (Exception ex)
            {
                log.Error("Copy all waterMark folders and files to application successfully. " + executePath + " to " + DestinationPath,ex);
                return ex.ToString();
            }
            
        }

        //Delete all files by folder path
        private string DeleteFolderALl(string path)
        {
            System.IO.DirectoryInfo di = new DirectoryInfo(path);
            if (di.Exists)
            {
                try
                {
                    foreach (FileInfo file in di.GetFiles())
                    {
                        file.Delete();
                    }

                    foreach (DirectoryInfo dir in di.GetDirectories())
                    {
                        dir.Delete(true);
                    }

                    di.Delete(true);
                    log.Debug("Delete all folders and files from folder " + path + " successfully.");
                    return "true";
                }

                catch (Exception ex)
                {
                    log.Error("Delete all folders and files from folder " + path + " failed.", ex);
                    return ex.ToString();
                }
            }
            else
            {
                log.Info("The folders is not exist!!" + path);
                return "true";
            }
        
        }

    }
}
