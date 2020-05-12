using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WaterMark;
using CreatePatitent;
using IntergrationWeb;
using SCU;
using System.Threading;
using System.Configuration;
using log4net;



namespace SimulatePrint
{
    class SimulatePrintClass
    {
        public WaterMarkClass WaterMark = new WaterMarkClass();
        public ClassSCU SCUClient = new ClassSCU();
        public IntergrationWebClass IntergrationWeb = new IntergrationWebClass();
        public PatitentClass Patient = new PatitentClass();

        static object l = new object();
        public int SleepSecond = int.Parse(ConfigurationManager.AppSettings["PrintIntervalTime"]);
        string ExecuteMode = ConfigurationManager.AppSettings["Model"];
        string ExecuteCount = ConfigurationManager.AppSettings["ExecuteCount"];
        public int PrintCount;

        log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public string init() 
        {

            try
            {
                PrintCount = 0;
                WaterMark.CreateFolderByThreadCount();
                for (int i = 1; i <= Int32.Parse(WaterMark.threadCount); i++)
                {
                    string RootFolder = WaterMark.executePath + @"WaterMark" + i + @"\SCU\";
                    int AEnumber = i;
                    SCUClient.ConfigPrinterIP(RootFolder);
                    //SCUClient.ConfigAEtitle(RootFolder, AEnumber);
                }
                log.Info("Init the thread application folder and SCU configuration.");
                return "true";
            }
            catch (Exception ex)
            {
                log.Error("Init the thread application folder and SCU configuration failed.",ex);
                return ex.ToString();
            }
            
        }


        public string SendDicom(int TaskID)
        {
            Patient.getPatientInfo();
            string patientInfo = Patient.DateWithMS;
            string result = IntergrationWeb.request_CreatePatient(patientInfo + TaskID);
            string localpath = WaterMark.executePath + @"WaterMark" + TaskID + @"\";

            try
            {
                if (result.Equals("true")) { 

                    //If add water mark to dicom image successfully.
                    string addWaterMarkFlag = WaterMark.AddWaterMarkByFolder(localpath, Patient.PatientID + TaskID, Patient.AccessionNumber + TaskID);
                    if (addWaterMarkFlag.Equals("true"))
                    {
                        SCUClient.CreateDicomFile(localpath);
                        SCUClient.SendDicomFile(localpath);
                        log.Info("Try to send the dicom to SCP  infomartion as : " + localpath + " PID: " + Patient.PatientID + TaskID + " ACCN: " + Patient.AccessionNumber + TaskID);


                        if (ExecuteMode.ToUpper().Equals("COUNT"))
                        {
                            lock (l)
                            {
                                PrintCount = PrintCount + 1;
                            }
                        }

                        Thread.Sleep(SleepSecond * 1000);
                        return "true";
                    }
                    else
                    {
                        log.Error("Add water mark to dicom failed. " + localpath + " " + Patient.PatientID + TaskID + " " + Patient.AccessionNumber + TaskID);
                        return "false";
                    }
                    
                }
                return "false";
            }
            catch (Exception ex)
            {
                log.Error("Begin send the dicom to SCP failed. Path: " + localpath + " PID: " + Patient.PatientID + TaskID + " ACCN: " + Patient.AccessionNumber + TaskID,ex);
                return ex.ToString();
            }
        
        }


    }
}
