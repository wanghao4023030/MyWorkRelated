using System;
using System.IO;
using System.Web.Services;
using System.Reflection;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Data;
using KIOSK.Integration.WSProxy;
using System.Xml;
using System.Collections.Generic;
using log4net;

namespace KIOSK.Integration.WSProxy
{
    /// <summary>
    /// Proxy 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    /// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
    /// [System.Web.Script.Services.ScriptService]
    public class WSProxy : System.Web.Services.WebService
    {
        private FunctionForEI funEI = null;

        public WSProxy()
        {
            try
            {
                WSProxyDebugInfo("WSProxy(): new FunctionForEI()\r\n");

                if (null == funEI)
                {
                    funEI = new FunctionForEI();
                }
            }
            catch (Exception ex)
            {
                WSProxyDebugInfo(string.Format("WSProxy(): Exception = {0}\r\n", ex.Message));
            }
        }

        private bool m_WSProxyDebug = false;

        private void WSProxyDebugInfo(string strMessage)
        {
            if (m_WSProxyDebug)
            {
                FileStream fsMessage = null;
                StreamWriter swMessage = null;
                string strNow = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");

                strMessage = string.IsNullOrEmpty(strMessage) ? "" : strMessage.Trim();
                strMessage = "[" + strNow + "]-" + strMessage;
                strMessage = strMessage + "\r\n";

                fsMessage = new FileStream("D:\\KIOSK.Integration.WSProxy.Debug.Info.txt", FileMode.Append | FileMode.OpenOrCreate);
                swMessage = new StreamWriter(fsMessage, System.Text.Encoding.Default);

                swMessage.Write(strMessage);

                swMessage.Close();
                swMessage.Dispose();
                swMessage = null;

                fsMessage.Close();
                fsMessage.Dispose();
                fsMessage = null;
            }
        }

        /// <summary>PS1000 or OCR Query Exam Info.</summary>
        /// <param name = "strPatientName">RIS Patient Name</param>
        /// <param name = "strPatientID">RIS Patient ID</param>
        /// <param name = "strAccessionNumber">RIS Accession number</param>
        /// <param name = "strModality">Modality</param>
        /// <param name = "strStartDT">Start date time</param>
        /// <param name = "strEndDT">End date time</param>
        /// <param name = "strExamInfoList">Returned exam information </param>
        /// <returns>true = success (match found), false = failure (no match)</returns>
        [WebMethod(Description = "PS1000 or OCR Query Exam Info.")]
        public bool QueryExamInfo(string strPatientName, string strPatientID, string strAccessionNumber, string strModality,
            string strStartDT, string strEndDT, out string strExamInfoList)
        {
            bool bReturn = false;

            strExamInfoList = "";

            try
            {
                strPatientName = string.IsNullOrEmpty(strPatientName) ? "" : strPatientName.Trim();
                strPatientID = string.IsNullOrEmpty(strPatientID) ? "" : strPatientID.Trim();
                strAccessionNumber = string.IsNullOrEmpty(strAccessionNumber) ? "" : strAccessionNumber.Trim();
                strModality = string.IsNullOrEmpty(strModality) ? "" : strModality.Trim();
                strStartDT = string.IsNullOrEmpty(strStartDT) ? "" : strStartDT.Trim();
                strEndDT = string.IsNullOrEmpty(strEndDT) ? "" : strEndDT.Trim();

                WSProxyDebugInfo(string.Format("QueryExamInfo(): PatientName = {0}, PatientID = {1}, AccessionNumber = {2}, Modality = {3}, StartDT = {4}, EndDT = {5}\r\n",
                    strPatientName, strPatientID, strAccessionNumber, strModality, strStartDT, strEndDT));

                bReturn = funEI.QueryExamInfo(strPatientID, strPatientName, strAccessionNumber, strModality, strStartDT, strEndDT, out strExamInfoList);
            }
            catch (Exception ex)
            {
                bReturn = false;
                strExamInfoList = "";

                WSProxyDebugInfo(string.Format("GetExamInfo(): Exception = {0}\r\n", ex.Message));
            }

            return bReturn;
        }

        ///<summary>
        ///PS1000 or OCR Query Exam InfoEx.
        ///</summary>
        ///<param name = "strParam "> 
        /*
        <queryParam>
	        <patientID>P000000006</patientID>
	        <patientName>王旭</patientName>
	        <gender>女</gender>
	        <age>Age</age>
	        <patientType>住院病人</patientType>
	        <outHospitalNo>OutHospitalNo</outHospitalNo>
	        <inHospitalNo>InHospitalNo</inHospitalNo>
	        <physicalExamNo>PhysicalExamNo</physicalExamNo>
	        <accessionNumber>201105140006</accessionNumber>
	        <referringDepartment>ReferringDepartment</referringDepartment>
	        <modalityType>DR</modalityType>
	        <modalityName>DR_1</modalityName>
	        <examName>ExamName</examName>
	        <examBodypart>ExamBodypart</examBodypart>
	        <registerDT>RegisterDT</registerDT>
	        <examDT>ExamDT</examDT>
	        <submitDT>SubmitDT</submitDT>
	        <approveDT>ApproveDT</approveDT>
	        <optional0>Optional0</optional0>
	        <optional1>Optional1</optional1>
	        <optional2>Optional2</optional2>
	        <optional3>Optional3</optional3>
	        <optional4>Optional4</optional4>
	        <optional5>Optional5</optional5>
        </queryParam>
        */
        ///</param>
        ///<returns>string strExamInfoList</returns>
        [WebMethod(Description = "PS1000 or OCR Query Exam Info For PDF Report.")]
        public string QueryExamInfoEx(string strParam)
        {
            string strExamInfoList = "";

            try
            {
                strParam = string.IsNullOrEmpty(strParam) ? "" : strParam.Trim();

                WSProxyDebugInfo(string.Format("QueryExamInfoEx(): Param = {0}\r\n", strParam));

                strExamInfoList = funEI.QueryExamInfoEx(strParam);
            }
            catch (Exception ex)
            {
                strExamInfoList = "";

                WSProxyDebugInfo(string.Format("QueryExamInfoEx(): Exception = {0}\r\n", ex.Message));
            }

            return strExamInfoList;
        }

        [WebMethod(Description = "MOZI OCR Query Exam Info.")]
        public string QueryExamInfoForMOZI(string strPatientID, string strAccessionNumber, string strModality, string strStartDT, string strEndDT)
        {
            string strExamInfoList = "";
            string strPatientName = "";

            try
            {
                strPatientID = string.IsNullOrEmpty(strPatientID) ? "" : strPatientID.Trim();
                strAccessionNumber = string.IsNullOrEmpty(strAccessionNumber) ? "" : strAccessionNumber.Trim();
                strModality = string.IsNullOrEmpty(strModality) ? "" : strModality.Trim();
                strStartDT = string.IsNullOrEmpty(strStartDT) ? "" : strStartDT.Trim();
                strEndDT = string.IsNullOrEmpty(strEndDT) ? "" : strEndDT.Trim();

                WSProxyDebugInfo(string.Format("QueryExamInfoForMOZI(): PatientID = {0}, AccessionNumber = {1}, Modality = {2}, StartDT = {3}, EndDT = {4}\r\n",
                    strPatientID, strAccessionNumber, strModality, strStartDT, strEndDT));

                strExamInfoList = funEI.QueryExamInfo(strPatientID, strPatientName, strAccessionNumber, strModality, strStartDT, strEndDT);
            }
            catch (Exception ex)
            {
                strExamInfoList = "";

                WSProxyDebugInfo(string.Format("QueryExamInfoForMOZI(): Exception = {0}\r\n", ex.Message));
            }

            return strExamInfoList;
        }

        [WebMethod(Description = "MOZI OCR Update Exam Info.")]
        public string UpdateExamInfoForMOZI(string strPatientID, string strAccessionNumber, string strModality, int iType)
        {
            string strExamInfoList = "";
            string strPatientName = "";
            string strStartDT = "";
            string strEndDT = "";

            try
            {
                strPatientID = string.IsNullOrEmpty(strPatientID) ? "" : strPatientID.Trim();
                strAccessionNumber = string.IsNullOrEmpty(strAccessionNumber) ? "" : strAccessionNumber.Trim();
                strModality = string.IsNullOrEmpty(strModality) ? "" : strModality.Trim();

                WSProxyDebugInfo(string.Format("UpdateExamInfoForMOZI(): PatientID = {0}, AccessionNumber = {1}, Modality = {2}, Type = {3}\r\n",
                    strPatientID, strAccessionNumber, strModality, iType.ToString()));

                strExamInfoList = funEI.UpdateExamInfo(strPatientID, strPatientName, strAccessionNumber, strModality, strStartDT, strEndDT);
            }
            catch (Exception ex)
            {
                strExamInfoList = "";

                WSProxyDebugInfo(string.Format("UpdateExamInfoForMOZI(): Exception = {0}\r\n", ex.Message));
            }

            return strExamInfoList;
        }

        //[WebMethod(Description = "Integration Query MWL.")]
        //public bool QueryMWL(string strPatientID, string strPatientName,
        //    string strAccessionNumber, string strModality, string strStudyDate, string strStudyTime, string strStudyStatusID)
        //{
        //    bool bReturn = false;

        //    try
        //    {
        //        strPatientID = string.IsNullOrEmpty(strPatientID) ? "" : strPatientID.Trim();
        //        strPatientName = string.IsNullOrEmpty(strPatientName) ? "" : strPatientName.Trim();
        //        strAccessionNumber = string.IsNullOrEmpty(strAccessionNumber) ? "" : strAccessionNumber.Trim();
        //        strModality = string.IsNullOrEmpty(strModality) ? "" : strModality.Trim();
        //        strStudyDate = string.IsNullOrEmpty(strStudyDate) ? "" : strStudyDate.Trim();
        //        strStudyTime = string.IsNullOrEmpty(strStudyTime) ? "" : strStudyTime.Trim();
        //        strStudyStatusID = string.IsNullOrEmpty(strStudyStatusID) ? "" : strStudyStatusID.Trim();

        //        WSProxyDebugInfo(string.Format("QueryMWL(): PatientID = {0}, PatientName={1}, AccessionNumber = {2}, Modality = {3}, strStudyDate = {4}, strStudyTime = {5}, strStudyStatusID = {6}\r\n",
        //            strPatientID, strPatientName, strAccessionNumber, strModality, strStudyDate, strStudyTime, strStudyStatusID));

        //        bReturn = funEI.GetMWLExamInfo(strPatientID, strPatientName, strAccessionNumber, strModality, strStudyDate, strStudyTime, strStudyStatusID);
        //    }
        //    catch (Exception ex)
        //    {
        //        bReturn = false;

        //        WSProxyDebugInfo(string.Format("QueryMWL(): Exception = {0}\r\n", ex.Message));
        //    }

        //    return bReturn;
        //}

        /// <summary>
        /// PS1000 get patient information, convert card number, the message to display and go/no go decision.
        /// </summary>
        /// <param name="strTerminalInfo">Terminal info(IP address so far). (optional)</param>
        /// <param name="strCardType">Card Type. (optional)</param>
        /// <param name="strCardNumber">Card Number. (required)</param>
        /// <param name="strReturnType">Return Type: PATIENT_ID、ACCESSION_NUMBER、STUDY_INSTANCE_UID. (required)</param>
        /// <param name="strReturnValue">Return Value. (required)</param>
        /// <param name="strPatientName">Patient name returned from ris/ocr side. (required)</param>
        /// <param name="strMessage">The message will be shown on the terminal screen. (optional)</param>
        /// <returns>true - continue, false - discontinue.</returns>
        [WebMethod(Description = "PS1000 get patient information, convert card number, the message to display and go/no go decision.")]
        public bool GetPatientInfo(string strTerminalInfo, string strCardType, string strCardNumber, string strReturnType
            , out string strReturnValue, out string strPatientName, out string strMessage)
        {
            bool bReturn = false;

            strReturnValue = "";
            strPatientName = "";
            strMessage = "";

            //string strReturnValue = "";
            //string strPatientName = "";
            //string strMessage = "";

            try
            {
                strTerminalInfo = string.IsNullOrEmpty(strTerminalInfo) ? "" : strTerminalInfo.Trim();
                strCardType = string.IsNullOrEmpty(strCardType) ? "" : strCardType.Trim();
                strCardNumber = string.IsNullOrEmpty(strCardNumber) ? "" : strCardNumber.Trim();
                strReturnType = string.IsNullOrEmpty(strReturnType) ? "" : strReturnType.Trim();

                WSProxyDebugInfo(string.Format("GetPatientInfo(): TerminalInfo = {0}, CardType = {1}, CardNumber = {2}, ReturnType = {3}\r\n",
                    strTerminalInfo, strCardType, strCardNumber, strReturnType));

                bReturn = funEI.GetPSPatientInfo(strTerminalInfo, strCardType, strCardNumber, strReturnType, out strReturnValue, out strPatientName, out strMessage);
            }
            catch (Exception ex)
            {
                bReturn = false;
                strReturnValue = "";
                strPatientName = "";
                strMessage = "";

                WSProxyDebugInfo(string.Format("GetPatientInfo(): Exception = {0}\r\n", ex.Message));
            }

            return bReturn;
        }




        ///// <summary>
        ///// PS1000 get patient information, convert card number, the message to display and go/no go decision.
        ///// </summary>
        ///// <param name="strTerminalInfo">Terminal info(IP address so far). (optional)</param>
        ///// <param name="strCardType">Card Type. (optional)</param>
        ///// <param name="strCardNumber">Card Number. (required)</param>
        ///// <param name="strReturnType">Return Type: PATIENT_ID、ACCESSION_NUMBER、STUDY_INSTANCE_UID. (required)</param>
        ///// <param name="strReturnValue">Return Value. (required)</param>
        ///// <param name="strPatientName">Patient name returned from ris/ocr side. (required)</param>
        ///// <param name="strMessage">The message will be shown on the terminal screen. (optional)</param>
        ///// <returns>true - continue, false - discontinue.</returns>
        //[WebMethod(Description = "PS1000 get patient information, convert card number, the message to display and go/no go decision.")]
        //public bool GetPatientInfo(string strTerminalInfo, string strCardType, string strCardNumber, string strReturnType
        //    , out string strReturnValue, out string strPatientName, out string strMessage)
        //{
        //    bool bReturn = false;

        //    strReturnValue = "";
        //    strPatientName = "";
        //    strMessage = "";

        //    //string strReturnValue = "";
        //    //string strPatientName = "";
        //    //string strMessage = "";

        //    try
        //    {
        //        strTerminalInfo = string.IsNullOrEmpty(strTerminalInfo) ? "" : strTerminalInfo.Trim();
        //        strCardType = string.IsNullOrEmpty(strCardType) ? "" : strCardType.Trim();
        //        strCardNumber = string.IsNullOrEmpty(strCardNumber) ? "" : strCardNumber.Trim();
        //        strReturnType = string.IsNullOrEmpty(strReturnType) ? "" : strReturnType.Trim();

        //        WSProxyDebugInfo(string.Format("GetPatientInfo(): TerminalInfo = {0}, CardType = {1}, CardNumber = {2}, ReturnType = {3}\r\n",
        //            strTerminalInfo, strCardType, strCardNumber, strReturnType));

        //        bReturn = funEI.GetPSPatientInfo(strTerminalInfo, strCardType, strCardNumber, strReturnType, out strReturnValue, out strPatientName, out strMessage);
        //    }
        //    catch (Exception ex)
        //    {
        //        bReturn = false;
        //        strReturnValue = "";
        //        strPatientName = "";
        //        strMessage = "";

        //        WSProxyDebugInfo(string.Format("GetPatientInfo(): Exception = {0}\r\n", ex.Message));
        //    }

        //    return bReturn;
        //}



        [WebMethod(Description = "PS1000 get patient information, convert card number, the message to display and go/no go decision.")]
        public bool GetPatientInfoGlobal(string strCardInfo,out string PrintInfo)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

            try
            {
                log.Info("The request info is: " + strCardInfo);

                MeiZhouQA QA = new MeiZhouQA();
                string connectionString = QA.connectionString;
                string strPatientLevel = QA.strPatientLevel;
                int intThinkTime = int.Parse(System.Web.Configuration.WebConfigurationManager.AppSettings["THINKTIME"].ToString());

                log.Info("The Connectstring  is: " + connectionString);
                log.Info("The PatientLevel is: " + strPatientLevel);
                log.Info("The ThinkTime is: " + intThinkTime);

                QA.ParseInputXML(strCardInfo);
                string[] accnArray = null;
                string[] PidArray = null;
                string strCardValue = QA.CardValue;
                string Patientid = null;

                XmlDocument doc = new XmlDocument();
                doc = QA.InitXML();
                log.Info("InitXML successfully");


            if (strPatientLevel.Equals("PATIENT_ID"))
            {
                log.Info("Start query with PatientID print level");

                Patientid = strCardValue.Trim();
                bool PatientExistFlag = QA.getACCNsByPatientID(Patientid, out accnArray);

                if (PatientExistFlag)
                {
                    QA.getExistPatientInfo(Patientid, ref doc);
                    log.Info("The patient is exist and ID is " + Patientid);
                }

                if (!PatientExistFlag)
                {
                    QA.getNotExistPatientInfo(Patientid, ref doc);
                    log.Error("The patient is not exist and ID is " + Patientid);

                }


                if (PatientExistFlag)
                {
                    foreach (string strAcessoinNumber in accnArray)
                    {
                        DataTable DT = QA.getExzamInfoFromIntegrationTableByACCN(strAcessoinNumber);
                        if (DT.Rows.Count > 0)
                        {
                            log.Info("Get the exam information from DB by accession number" + strAcessoinNumber);
                            foreach (DataRow myrow in DT.Rows)
                            {
                                string strReportID = myrow["StudyInstanceUID"].ToString();
                                string strReportPath = myrow["PDFReportURL"].ToString();
                                string strExamBodyPart = myrow["ExamBodyPart"].ToString();
                                string strCreateDT = myrow["CreateDT"].ToString();
                                string strExamName = myrow["ExamName"].ToString();
                                string strModalityName = myrow["ModalityName"].ToString();
                                string strModalityType = myrow["Modality"].ToString();
                                string strColorType = myrow["Optional0"].ToString();
                                string strPapaerSzie = myrow["Optional1"].ToString();
                                string strPaperType = myrow["Optional2"].ToString();
                                string strPatientType = myrow["PatientType"].ToString();
                                DataTable DT2;
                                DT2 = QA.getExamInfoFromPatientTable(strAcessoinNumber, Patientid, strModalityType);
                                if (DT2.Rows.Count > 0)
                                {
                                    foreach (DataRow myrow2 in DT2.Rows)
                                    {
                                        string strPrintStatus = myrow2["PrintStatus"].ToString();
                                        string strReferringDepartment = myrow2["ReferringDepartment"].ToString();
                                        QA.writeExistExamInfoToXML(ref doc, strAcessoinNumber, strReportID, strReportPath, strExamBodyPart, strCreateDT, strExamName, strModalityName, strModalityType, strColorType, strPapaerSzie, strPaperType, strPrintStatus, strReferringDepartment, strPatientType);
                                    }
                                }

                                if (DT2.Rows.Count <= 0)
                                {
                                    QA.writeNotExistExamInfoToXML(ref doc, strAcessoinNumber, strExamBodyPart, strCreateDT, strExamName, strModalityName, strModalityType, strColorType, strPapaerSzie, strPaperType, strPatientType);
                                    log.Info("Write the exist exam infomation to XML which accession number is " + strAcessoinNumber);

                                }
                            }
                        }
                    }
                }
            }


            if (strPatientLevel.Equals("CARD_ID"))
            {
                log.Info("Start query with CardID print level");

                if (QA.getPatientIDByCardInfo(strCardValue, out PidArray))
                {
                    log.Info("Execute getPatientIDByCardInfo.");
                    foreach (string strPatientid in PidArray)
                    {
                        bool PatientExistFlag = QA.getACCNsByPatientID(strPatientid, out accnArray);
                        if (PatientExistFlag)
                        {
                            QA.getExistPatientInfo(strPatientid, ref doc);
                            log.Info("Patient is exist!");
                        }
                        if (!PatientExistFlag)
                        {
                            QA.getNotExistPatientInfo(strPatientid, ref doc);
                            log.Error("Patient is not exist!");

                        }
                        if (PatientExistFlag)
                        {
                            foreach (string strAcessoinNumber in accnArray)
                            {
                                DataTable DT = QA.getExzamInfoFromIntegrationTableByACCN(strAcessoinNumber);
                                log.Info("Execute getExzamInfoFromIntegrationTableByACCN function!");

                                if (DT.Rows.Count > 0)
                                {
                                    foreach (DataRow myrow in DT.Rows)
                                    {
                                        string strReportID = myrow["StudyInstanceUID"].ToString();
                                        string strReportPath = myrow["PDFReportURL"].ToString();
                                        string strExamBodyPart = myrow["ExamBodyPart"].ToString();
                                        string strCreateDT = myrow["CreateDT"].ToString();
                                        string strExamName = myrow["ExamName"].ToString();
                                        string strModalityName = myrow["ModalityName"].ToString();
                                        string strModalityType = myrow["Modality"].ToString();
                                        string strColorType = myrow["Optional0"].ToString();
                                        string strPapaerSzie = myrow["Optional1"].ToString();
                                        string strPaperType = myrow["Optional2"].ToString();
                                        string strPatientType = myrow["PatientType"].ToString();
                                        
                                        DataTable DT2;
                                        DT2 = QA.getExamInfoFromPatientTable(strAcessoinNumber, strPatientid, strModalityType);
                                        if (DT2.Rows.Count > 0)
                                        {
                                            foreach (DataRow myrow2 in DT2.Rows)
                                            {
                                                string strPrintStatus = myrow2["PrintStatus"].ToString();
                                                string strReferringDepartment = myrow2["ReferringDepartment"].ToString();
                                                QA.writeExistExamInfoToXML(ref doc, strAcessoinNumber, strReportID, strReportPath, strExamBodyPart, strCreateDT, strExamName, strModalityName, strModalityType, strColorType, strPapaerSzie, strPaperType, strPrintStatus, strReferringDepartment, strPatientType);

                                                log.Info("Write exist exam information to XML which accession number is " + strAcessoinNumber);
                                            }
                                        }

                                        if (DT2.Rows.Count <= 0)
                                        {
                                            QA.writeNotExistExamInfoToXML(ref doc, strAcessoinNumber, strExamBodyPart, strCreateDT, strExamName, strModalityName, strModalityType, strColorType, strPapaerSzie, strPaperType, strPatientType);
                                            log.Info("Write not exist exam information to XML which accession number is " + strAcessoinNumber);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else 
                {
                    QA.getNotExistPatientInfo(strCardValue, ref doc);
                }
            }


                    System.Threading.Thread.Sleep(1000 * intThinkTime);
                    PrintInfo = doc.OuterXml;
                    log.Info("Final return XML file :" + PrintInfo.ToString());
                    return true;
            }
            catch (Exception ex)
            {
                log.Error(ex.ToString());
                PrintInfo = "";
                return false;
            }
     }


        /// <summary>
        /// PS1000 notify study info.
        /// </summary>
        /// <param name="strAccessionNumber">RIS Accession number. (required)</param>
        /// <param name="strStudyInstanceUID">RIS StudyInstanceUID. (optional)</param>
        /// <param name="iStudyType">Study Type：1-Film, 2-Report. (required)</param>
        /// <param name="iStatus">Status：0-unprinted,1-Printed, 2-do not printed,3-printing,9-stored. (required)</param>
        /// <returns>Return value for extension.</returns>
        [WebMethod(Description = "PS1000 notify study info.")]
        public int NotifyStudyInfo(string strAccessionNumber, string strStudyInstanceUID, int iStudyType, int iStatus)
        {
            int iReturn = Convert.ToInt32(true);

            try
            {
                strAccessionNumber = string.IsNullOrEmpty(strAccessionNumber) ? "" : strAccessionNumber.Trim();
                strStudyInstanceUID = string.IsNullOrEmpty(strStudyInstanceUID) ? "" : strStudyInstanceUID.Trim();

                WSProxyDebugInfo(string.Format("NotifyStudyInfo(): AccessionNumber = {0}, StudyInstanceUID = {1}, StudyType = {2}, Status = {3}\r\n",
                    strAccessionNumber, strStudyInstanceUID, iStudyType, iStatus));

                iReturn = Convert.ToInt32(funEI.NotifyStudyInfo(strAccessionNumber, strStudyInstanceUID, iStudyType, iStatus));
            }
            catch (Exception ex)
            {
                iReturn = -1;

                WSProxyDebugInfo(string.Format("NotifyStudyInfo(): Exception = {0}\r\n", ex.Message));
            }

            return iReturn;
        }

        [WebMethod(Description = "Integration or 3rd System Notify Report Information To PS1000.")]
        public bool NotifyReportInfo()
        {
            bool bReturn = false;

            try
            {
                bReturn = funEI.NotifyReportInfo();
            }
            catch (Exception ex)
            {
                bReturn = false;

                WSProxyDebugInfo(string.Format("NotifyReportInfo(): Exception = {0}\r\n", ex.Message));
            }

            return bReturn;
        }

        [WebMethod (Description = "Integration Version Info.")]
        public string GetVersion()
        {
            string strRet = "NULL";

            Assembly ass = Assembly.GetExecutingAssembly();

            FileVersionInfo fvi = FileVersionInfo.GetVersionInfo(ass.Location);
            strRet = fvi.FileVersion;

            return strRet;
        }

    }
}