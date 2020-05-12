using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace KIOSK.Integration.Interface
{
    /// <summary>
    /// Summary description for Interface
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Interface : System.Web.Services.WebService
    {
        private FunctionEx Fun = null;

        public Interface()
        {
            if (null == Fun)
            {
                Fun = new FunctionEx();
            }
        }

        [WebMethod(Description = "3rd PS Get Film/Report print status.Return: -1:don’t find data; 0:film&report ready; 1:printed(film&report); 2:printing; 3:film printed report unprint; 4:report printed film unprint;5:Film ready report unready;6:Film unready report ready. ")]
        public int GetPrintStatus(string strAccessionNumber, string strPatientID
            , out string strMessage)
        {
            int iRet = 0;
            strMessage = "";

            iRet = Fun.GetPrintStatus(strAccessionNumber, strPatientID, out strMessage);
            return iRet;
        }

        [WebMethod(Description = "3rf PS get patient examinfo.")]
        public int GetPatientExamInfo(string strTerminalInfo, string strCardType, string strCardNumber, out string strExamInfo)
        {
            int iRet = 0;
            strExamInfo = "";
            if (string.IsNullOrEmpty(strCardType) || string.IsNullOrEmpty(strCardNumber))
                return 1;
            iRet = Fun.GetPatientExamInfo(strTerminalInfo, strCardType, strCardNumber, out strExamInfo);
            return iRet;
        }

        [WebMethod(Description = "3rd PS Get PDF Report Url.")]
        public int GetReportUrl(string strAccessionNumber, string strPatientID
            , out string strPDFUrl, out string strMessage)
        {
            int iRet = 0;
            strPDFUrl = "";
            strMessage = "";

            iRet = Fun.GetReportUrl(strAccessionNumber, strPatientID, out strPDFUrl, out strMessage);
            return iRet;
        }

        [WebMethod]
        public int ReciveTerminalInfo(string TerminalInfo,out string errorDesc)
        {
            int iRet = 0;
            errorDesc = string.Empty;
//            TerminalInfo = @"<TerminalInfo>
//                                <IP>172.19.52.211</IP>
//                                <Status>0</Status>
//                                <PaperPrinterStatus>0</PaperPrinterStatus>
//                                <FilmPrinter>
//                                    <IP>127.0.0.2</IP>
//                                    <Status>0</Status>
//                                    <PrintStatus>0</PrintStatus>
//                                    <FilmSize1>0</FilmSize1>
//                                    <FilmType1>0</FilmType1>
//                                    <FilmCount1>98</FilmCount1>
//                                    <FilmSize2>1</FilmSize2>
//                                    <FilmType2>0</FilmType2>
//                                    <FilmCount2>98</FilmCount2>
//                                    <FilmSize3>2</FilmSize3>
//                                    <FilmType3>0</FilmType3>
//                                    <FilmCount3>98</FilmCount3>
//                                </FilmPrinter>
//                            </TerminalInfo>";
            //TerminalInfo = "<?xml version=\"1.0\" encoding=\"utf-16\"?><TerminalInfo><IP>192.168.125.30</IP><Status>0</Status><PaperPrinterStatus>0</PaperPrinterStatus><FilmPrinter><IP>192.168.125.33</IP><Status>8</Status><PrintStatus>1</PrintStatus><FilmSize1>-1</FilmSize1><FilmType1>-1</FilmType1><FilmCount1>174</FilmCount1><FilmSize2>0</FilmSize2><FilmType2>0</FilmType2><FilmCount2>0</FilmCount2><FilmSize3>0</FilmSize3><FilmType3>0</FilmType3><FilmCount3>0</FilmCount3></FilmPrinter></TerminalInfo>";
            if (string.IsNullOrEmpty(TerminalInfo.Trim()))
                return 1;
            iRet = Fun.UpdateTerminalInfo(TerminalInfo, out errorDesc);
            return 0;
        }
    }
}
