using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

using KIOSK.Integration.Log;
using KIOSK.Integration.Config;
using KIOSK.Integration.Util;
using System.Xml;

namespace KIOSK.Integration.Interface
{
    public class FunctionEx:Function
    {
        public int GetPrintStatus(string strAccessionNumber, string strPatientID, out string strMessage)
        {
            int iRet = 0;
            strMessage = "";
            string strSQL = "";
            DataSet dsPatientInfo = null;
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Load function.GetPrintStatus().Input parameters as follow:");
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("PatientID = " + strPatientID);

            string strTerminalInfo = "FUJI";
            string strCardType = "ACCESSION_NUMBER";
            string strReturnVal = "ACCESSION_NUMBER";
            string strOutputInfo = "";
            string strFilmStored = "";
            string strFilmPrinted = "";
            string strReportStored = "";
            string strReportPrinted = "";

            try
            {
                FunctionInitializ();
                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");
                strSQL = m_Config_WSProxy.M_SQLForGetPSPatientInfo;

                LogUtil.DebugLog("Call DAOMSSQLWSProxy.GetPSPatientInfo(), Input Parameter AS Follows:");
                LogUtil.DebugLog("SQL = " + strSQL);
                LogUtil.DebugLog("TerminalInfo = " + strTerminalInfo);
                LogUtil.DebugLog("CardType = " + strCardType);
                LogUtil.DebugLog("CardNumber = " + strAccessionNumber);
                LogUtil.DebugLog("ReturnType = " + strReturnVal);

                dsPatientInfo = m_DAOMSSQLWSProxy.GetPSPatientInfo(strSQL,
                    strTerminalInfo,
                    strCardType,
                    strAccessionNumber,
                    strReturnVal,
                    out strOutputInfo);

                if ((null != dsPatientInfo) && (dsPatientInfo.Tables[0].Rows.Count > 0))
                {
                    strFilmStored = dsPatientInfo.Tables[0].Rows[0]["FilmStoredFlag"].ToString();
                    strFilmPrinted = dsPatientInfo.Tables[0].Rows[0]["FilmPrintFlag"].ToString();
                    strReportStored = dsPatientInfo.Tables[0].Rows[0]["ReportStoredFlag"].ToString();
                    strReportPrinted = dsPatientInfo.Tables[0].Rows[0]["ReportPrintFlag"].ToString();
                    LogUtil.DebugLog("FilmStored = " + strFilmStored);
                    LogUtil.DebugLog("FilmPrinted = " + strFilmPrinted);
                    LogUtil.DebugLog("ReportStored = " + strReportStored);
                    LogUtil.DebugLog("ReportPrinted = " + strReportPrinted);

                    if ((strFilmStored == "0") && (strReportStored == "0"))
                    {
                        iRet = -1;
                    }
                    else if ((strFilmStored == "9") && (strReportStored == "9"))
                    {
                        if ((strFilmPrinted == "1") && (strReportPrinted == "1"))
                        {
                            iRet = 1;
                        }
                        else if ((strFilmPrinted == "1") && (strReportPrinted == "0"))
                        {
                            iRet = 3;
                        }
                        else if ((strFilmPrinted == "0") && (strReportPrinted == "1"))
                        {
                            iRet = 4;
                        }
                        else if ((strFilmPrinted == "0") && (strReportPrinted == "0"))
                        {
                            iRet = 0;
                        }
                    }
                    else if ((strFilmStored == "9") && (strReportStored == "0"))
                    {
                        iRet = 5;
                    }
                    else if ((strFilmStored == "0") && (strReportStored == "9"))
                    {
                        iRet = 6;
                    }
                }
                else
                {
                    iRet = -1;
                    LogUtil.ErrorLog("Function.GetPrintStatus() Return = null.");
                }
            }
            catch (System.Exception ex)
            {
                LogUtil.DebugLog("Function.GetPrintStatus() has error, Message = " + ex.ToString());
                LogUtil.InfoLog("Function.GetPrintStatus() has error, Message = " + ex.ToString());
                LogUtil.ErrorLog("Function.GetPrintStatus() has error, Message = " + ex.ToString());
                strMessage = ex.ToString();
                iRet = -1;
            }
            finally
            {
                if (null != dsPatientInfo)
                {
                    dsPatientInfo.Dispose();
                    dsPatientInfo = null;
                }
                FunctionDispose();
            }

            return iRet;
        }

        public int GetReportUrl(string strAccessionNumber, string strPatientID, out string strPDFUrl, out string strMessage)
        {
            int iRet = 0;
            strPDFUrl = "";
            strMessage = "";
            DataSet dsReport = null;
            string strSQL = "";
            string strOutputInfo = "";
            
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Load Function.GetReportUrl().Input parameters as follow:");
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("PatientID = " + strPatientID);

            try
            {
                FunctionInitializ();
                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");
                strSQL = m_Config_WSProxy.M_strGetReportUrl;

                dsReport = m_DAOMSSQLWSProxy.GetReportUrl(strSQL, strPatientID, strAccessionNumber, out strOutputInfo);
                if ((null != dsReport) && (0 < dsReport.Tables[0].Rows.Count))
                {
                    strPDFUrl = dsReport.Tables[0].Rows[0]["PDFReportUrl"].ToString();
                    LogUtil.DebugLog("Call function.GetReportUrl(),PDFReportUrl = " + strPDFUrl);
                }
                else
                {
                    LogUtil.DebugLog("Function.GetReportUrl() return null.");
                    iRet = 1;
                    strMessage = "This AccessionNumber has no report.";
                }
            }
            catch (System.Exception ex)
            {
                LogUtil.DebugLog("Function.GetReportUrl() has error,Message = " + ex.ToString());
                LogUtil.InfoLog("Function.GetReportUrl() has error,Message = " + ex.ToString());
                LogUtil.ErrorLog("Function.GetReportUrl() has error,Message = " + ex.ToString());
                strMessage = ex.ToString();
                iRet = 1;
            }
            finally
            {
                if (null != dsReport)
                {
                    dsReport.Dispose();
                    dsReport = null;
                }
                FunctionDispose();
            }

            return iRet;
        }

        public int GetPatientExamInfo(string strTermianl, string strCardType, string strCardNumber, out string strExamInfo)
        {
            int iRet = 0;
            strExamInfo = "";
            DataSet dsExam = null;
            string strVal = "<PatientExam>"
                                + "<ExamInfo>"
                                    + "<PatientName>{0}</PatientName>"
                                    + "<ReportCount>{1}</ReportCount>"
                                    + "<ImageCount>{2}</ImageCount>"
                                    + "<IN8XIN10>{3}</IN8XIN10>"
                                    + "<IN14XIN17>{4}</IN14XIN17>"
                                    + "<IN14XIN14>{5}</IN14XIN14>"
                                    + "<IN11XIN14>{6}</IN11XIN14>"
                                    + "<IN10XIN12>{7}</IN10XIN12>"
                                + "</ExamInfo>"
                            + "</PatientExam>";
            try
            {
                FunctionInitializ();
                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                string strSQL = m_Config_WSProxy.M_SQLForGetPSPatientInfo;

                LogUtil.DebugLog(string.Format("Load DAOMSSQLWSProxy.GetPatientExamInfo,Input parameters as follow:"));
                LogUtil.DebugLog(string.Format("SQL = '{0}', TermianlIP ='{0}' CardType = '{1}', CardNumber = '{2}'.", strSQL, strCardType, strCardNumber));
                dsExam = m_DAOMSSQLWSProxy.GetPatientExamInfo(strSQL, strTermianl, strCardType, strCardNumber);
                if (dsExam == null)
                {
                    LogUtil.DebugLog("Return DataSet = null.");
                }
                else
                {
                    if (dsExam.Tables[0].Rows.Count > 0)
                    {
                        LogUtil.DebugLog(string.Format("Return DataSet = '{0}', RecordCount = '{1}'.", dsExam.ToString(), dsExam.Tables[0].Rows.Count.ToString()));
                        foreach (DataRow drExamInfo in dsExam.Tables[0].Rows)
                        {
                            strVal = string.Format(strVal
                                    , drExamInfo["PatientName"].ToString().Trim()
                                    , drExamInfo["ReportCount"].ToString().Trim()
                                    , drExamInfo["FilmCount"].ToString().Trim()
                                    , drExamInfo["FilmCount810"].ToString().Trim()
                                    , drExamInfo["FilmCount1417"].ToString().Trim()
                                    , drExamInfo["FilmCount1414"].ToString().Trim()
                                    , drExamInfo["FilmCount1114"].ToString().Trim()
                                    , drExamInfo["FilmCount1012"].ToString().Trim());
                            LogUtil.DebugLog(string.Format("Patient examinfo = '{0}'.", strVal));
                        }
                        strExamInfo = strVal;
                        LogUtil.DebugLog("Function.GetPatientExamInfo() Return Value = " + strExamInfo);
                    }
                }
            }
            catch (System.Exception ex)
            {
                LogUtil.DebugLog("Function.GetPatientExamInfo() has error,Message = " + ex.ToString());
                LogUtil.InfoLog("Function.GetPatientExamInfo() has error,Message = " + ex.ToString());
                LogUtil.ErrorLog("Function.GetPatientExamInfo() has error,Message = " + ex.ToString());
                strExamInfo = ex.ToString();
                iRet = 2;
            }
            finally
            {
                if (dsExam != null)
                {
                    dsExam.Dispose();
                    dsExam = null;
                }
                FunctionDispose();
            }

            return iRet;
        }

        public int UpdateTerminalInfo(string TerminalInfo, out string errorDesc) 
        {
            int iRet = 1;
            DataSet dsResult = null;
            errorDesc = string.Empty;
            string strSQL = string.Empty;
            
            try
            {
                LogUtil.DebugLog("Start UpdateTerminalInfo.");
                LogUtil.DebugLog("Exec UpdateTerminalInfo,Input parameters:" + TerminalInfo);

                XmlDocument xd = new XmlDocument();
                xd.LoadXml(TerminalInfo);
                XmlNodeList xnl= xd.GetElementsByTagName("TerminalInfo");
                string TerminalIP = xnl.Item(0).ChildNodes[0].InnerText;
                string TerminalStatus = xnl.Item(0).ChildNodes[1].InnerText;
                string PaperPrinterStatus = xnl.Item(0).ChildNodes[2].InnerText;
                string FilmPrinterIP = xnl.Item(0).ChildNodes[3].ChildNodes[0].InnerText;
                string FilmPrinterStatus = xnl.Item(0).ChildNodes[3].ChildNodes[1].InnerText;
                string FilmPrinterPrintStatus = xnl.Item(0).ChildNodes[3].ChildNodes[2].InnerText;
                string FilmSize1 = xnl.Item(0).ChildNodes[3].ChildNodes[3].InnerText;
                string FilmType1 = xnl.Item(0).ChildNodes[3].ChildNodes[4].InnerText;
                string FilmCount1 = xnl.Item(0).ChildNodes[3].ChildNodes[5].InnerText;
                string FilmSize2 = xnl.Item(0).ChildNodes[3].ChildNodes[6].InnerText;
                string FilmType2 = xnl.Item(0).ChildNodes[3].ChildNodes[7].InnerText;
                string FilmCount2 = xnl.Item(0).ChildNodes[3].ChildNodes[8].InnerText;
                string FilmSize3 = xnl.Item(0).ChildNodes[3].ChildNodes[9].InnerText;
                string FilmType3 = xnl.Item(0).ChildNodes[3].ChildNodes[10].InnerText;
                string FilmCount3 = xnl.Item(0).ChildNodes[3].ChildNodes[11].InnerText;

                FunctionInitializ();
                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                string strOutInfo = string.Empty;
                strSQL = m_Config_WSProxy.M_SQLForUpdateTerminalInfo;

                LogUtil.DebugLog("Load DAOMSSQLWSProxy.UpdateTerminalInfo,Input parameters as follow:");
                LogUtil.DebugLog("strSQL=" + strSQL);
                LogUtil.DebugLog("TerminalIP=" + TerminalIP);
                LogUtil.DebugLog("TerminalStatus=" + TerminalStatus);
                LogUtil.DebugLog("PaperPrinterStatus=" + PaperPrinterStatus);
                LogUtil.DebugLog("FilmPrinterIP=" + FilmPrinterIP);
                LogUtil.DebugLog("FilmPrinterStatus=" + FilmPrinterStatus);
                LogUtil.DebugLog("FilmPrinterPrintStatus=" + FilmPrinterPrintStatus);
                LogUtil.DebugLog("FilmSize1=" + FilmSize1);
                LogUtil.DebugLog("FilmType1=" + FilmType1);
                LogUtil.DebugLog("FilmCount1=" + FilmCount1);
                LogUtil.DebugLog("FilmSize2=" + FilmSize2);
                LogUtil.DebugLog("FilmType2=" + FilmType2);
                LogUtil.DebugLog("FilmCount2=" + FilmCount2);
                LogUtil.DebugLog("FilmSize3=" + FilmSize3);
                LogUtil.DebugLog("FilmType3=" + FilmType3);
                LogUtil.DebugLog("FilmCount3=" + FilmCount3);

                string RunTag = string.Empty;

                dsResult = m_DAOMSSQLWSProxy.UpdateTerminalInfo(strSQL, TerminalIP, TerminalStatus, PaperPrinterStatus, FilmPrinterIP, @FilmPrinterStatus, FilmPrinterPrintStatus, FilmSize1, FilmType1, FilmCount1, FilmSize2, FilmType2, FilmCount2, FilmSize3, FilmType3, FilmCount3, out strOutInfo);
                if (dsResult == null)
                {
                    LogUtil.DebugLog("Return DataSet = null.");
                }
                else
                {
                    LogUtil.DebugLog(strOutInfo);
                    LogUtil.DebugLog(string.Format("Return DataSet = '{0}', RecordCount = '{1}'.", dsResult.ToString(), dsResult.Tables[0].Rows.Count.ToString()));
                    if (dsResult.Tables[0].Rows.Count == 1)
                    {
                        RunTag = dsResult.Tables[0].Rows[0]["RunTag"].ToString().Trim();
                        LogUtil.DebugLog(string.Format("Function.UpdateTerminalInfo() Return Value = '{0}'.", RunTag));
                    }
                }

                if (string.IsNullOrEmpty(RunTag)) 
                {
                    RunTag = "1";
                }

                iRet = Int32.Parse(RunTag.Trim());
            }
            catch(System.Exception ex)
            {
                LogUtil.ErrorLog("Function.UpdateTerminalInfo() has error,Message = " + ex.ToString());
                errorDesc = ex.ToString();
                iRet = 2;
            }
            finally 
            {
                if (dsResult != null)
                {
                    dsResult.Dispose();
                    dsResult = null;
                }
                FunctionDispose();
            }
            return iRet;
        }
    }
}