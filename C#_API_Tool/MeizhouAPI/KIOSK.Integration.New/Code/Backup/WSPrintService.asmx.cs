using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web.Services;
using System.Xml;
using System.Web.Services.Protocols;

namespace KIOSK.Integration.WSPrintService
{
    /// <summary>
    /// Proxy 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
    // [System.Web.Script.Services.ScriptService]
    public class PrintService : System.Web.Services.WebService
    {
        /// <summary>
        /// OCR or Integration notify report information.
        /// </summary>
        /// <param name="strPatientName">Patient's Chinese name. (required)</param>
        /// <param name="strPatientID">Patient ID. (required)</param>
        /// <param name="strAccessionNumber">Accession Number. (required)</param>
        /// <param name="strStudyInstanceUID">Study Instance UID. (optional)</param>
        /// <param name="iReportStatus">0:not ready, just update Chinese name; 1:temp report; 2:formal report. (required)</param>
        /// <param name="strReportFileNameList">Report URL (PDF file ftp or http path list). (required)</param>
        /// <returns>0: Success, -1: Fail
        ///  a. the temp report has been printed, so cannot be updated with temp report;
        ///  b. formal report cannot be updated with temp report;
        ///  c. formal report has been printed, so cannot be updated.</returns>
        [WebMethod]
        public int NotifyReportInfo(string strPatientName, string strPatientID, string strAccessionNumber,
            string strStudyInstanceUID, int iReportStatus, string[] strReportFileNameList)
        {
            return 0;
        }

        /// <summary>
        /// Integration set print mode.
        /// </summary>
        /// <param name="strAccessionNumber">Accession Number. (required)</param>
        /// <param name="strStudyInstanceUID">Study Instance UID. (optional)</param>
        /// <param name="strMode">Default(Integtation or the 3rd System do not call the function): print when both film and report are ready;
        /// 0: print when both film and report are ready;
        /// 1: print film only;
        /// 2: print report only;
        /// 3: print any available;
        /// 4: do not print. (required)</param>
        /// <returns>Return value for extension.</returns>
        [WebMethod]
        public int SetPrintMode(string strAccessionNumber, string strStudyInstanceUID, int iPrintMode)
        {
            return 0;
        }
    }
}