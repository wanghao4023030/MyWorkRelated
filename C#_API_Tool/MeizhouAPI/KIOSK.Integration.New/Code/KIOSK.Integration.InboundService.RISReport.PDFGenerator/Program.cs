using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceProcess;
using System.Text;

namespace KIOSK.Integration.InboundService.RISReport.PDFGenerator
{
    static class Program
    {
        /// <summary>
        /// 应用程序的主入口点。
        /// </summary>
        static void Main()
        {
            ServiceBase[] ServicesToRun;

            // More than one user service may run within the same process.
            // To add another service to this process, change the following line to create a second service object.
            // For example:
            //
            //   ServicesToRun = new ServiceBase[] {new InboundService(), new MySecondUserService()};
            //

            ServicesToRun = new ServiceBase[] 
			{ 
				new InboundService() 
			};
            ServiceBase.Run(ServicesToRun);
        }
    }
}
