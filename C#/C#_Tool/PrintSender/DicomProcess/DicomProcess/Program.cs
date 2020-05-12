using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System.Drawing.Imaging;
using System.Drawing;
using System.IO;
using System.Diagnostics;
using System.Net;
using System.Net.Sockets;

using Dicom;
using Dicom.Imaging;
using Dicom.Printing;



using WaterMark;
using CreatePatitent;
using IntergrationWeb;
using Dicom.Network;
using Print_SCU;
using SCU;
using SimulatePrint;
using MultiThreadPrint;
using log4net;
using System.Configuration;

namespace DicomProcess
{
    class Program
    {
        static void Main(string[] args)
        {

            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
            MultiThreadPrintClass MultiThread = new MultiThreadPrintClass();
            string ExecuteLoop = ConfigurationManager.AppSettings["Loop"];
            int ExecuteLoopCount = Int32.Parse(ConfigurationManager.AppSettings["LoopCount"]);
            int ExecuteLoopDelay = Int32.Parse(ConfigurationManager.AppSettings["LoopDelay"]);
            int ExecuteCount = Int32.Parse(ConfigurationManager.AppSettings["ExecuteCount"]);
            int PrintIntervalTime = Int32.Parse(ConfigurationManager.AppSettings["PrintIntervalTime"]);

            MultiThread.StartThreadTask();



        }


    }

}

    


