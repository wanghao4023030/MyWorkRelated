using System;
using System.Data;
using System.Collections.Generic;

using KIOSK.Integration.Log;
using System.Collections;
using System.Diagnostics;
using System.IO;

namespace KIOSK.Integration.WSProxy
{
    public class FunctionForEI : Function
    {
        static ArrayList ALValue = new ArrayList();
        static ArrayList ALTime = new ArrayList();

        private DataSet GetRISExamInfo(string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStartDT, string strEndDT)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.GetRISExamInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientID = " + strPatientID);
            LogUtil.DebugLog("PatientName = " + strPatientName);
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("Modality = " + strModality);
            LogUtil.DebugLog("StartDT = " + strStartDT);
            LogUtil.DebugLog("EndDT = " + strEndDT);

            DataSet dsReturn = null;
            CExamInfo cei = new CExamInfo();
            bool bReturn = false;
            string strSQL = "";
            string strOutputInfo = "";

            try
            {
                FunctionInitializ();

                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForGetRISExamInfo;

                if ("MYSQL" == m_Config_WSProxy.M_RISDBType.Trim().ToUpper())
                {
                    LogUtil.DebugLog("Call DAOMySQLRIS.GetRISExamInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("PatientID = " + strPatientID);
                    LogUtil.DebugLog("Name = " + strPatientName);
                    LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
                    LogUtil.DebugLog("Modality = " + strModality);
                    LogUtil.DebugLog("StartDT = " + strStartDT);
                    LogUtil.DebugLog("EndDT = " + strEndDT);

                    dsReturn = m_DAOMySQLRIS.GetRISExamInfo(strSQL,
                        strPatientID,
                        strPatientName,
                        strAccessionNumber,
                        strModality,
                        strStartDT,
                        strEndDT,
                        out strOutputInfo);

                    LogUtil.DebugLog("DAOMySQLRIS.GetRISExamInfo(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                }
                else if ("ORACLE" == m_Config_WSProxy.M_RISDBType.Trim().ToUpper())
                {
                    LogUtil.DebugLog("Call DAOORACLERIS.GetRISExamInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("PatientID = " + strPatientID);
                    LogUtil.DebugLog("Name = " + strPatientName);
                    LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
                    LogUtil.DebugLog("Modality = " + strModality);
                    LogUtil.DebugLog("StartDT = " + strStartDT);
                    LogUtil.DebugLog("EndDT = " + strEndDT);

                    dsReturn = m_DAOORACLERIS.GetRISExamInfo(strSQL,
                        strPatientID,
                        strPatientName,
                        strAccessionNumber,
                        strModality,
                        strStartDT,
                        strEndDT,
                        out strOutputInfo);

                    LogUtil.DebugLog("DAOORACLERIS.GetRISExamInfo(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                }
                else
                {
                    LogUtil.DebugLog("Call DAOMSSQLRIS.GetRISExamInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("PatientID = " + strPatientID);
                    LogUtil.DebugLog("Name = " + strPatientName);
                    LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
                    LogUtil.DebugLog("Modality = " + strModality);
                    LogUtil.DebugLog("StartDT = " + strStartDT);
                    LogUtil.DebugLog("EndDT = " + strEndDT);

                    dsReturn = m_DAOMSSQLRIS.GetRISExamInfo(strSQL,
                        strPatientID,
                        strPatientName,
                        strAccessionNumber,
                        strModality,
                        strStartDT,
                        strEndDT,
                        out strOutputInfo);

                    LogUtil.DebugLog("DAOMSSQLRIS.GetRISExamInfo(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                }

                if (null != dsReturn)
                {
                    if (0 < dsReturn.Tables[0].Rows.Count)
                    {
                        foreach (DataRow drReturn in dsReturn.Tables[0].Rows)
                        {
                            cei.CExamInfoClear();
                            if (drReturn.Table.Columns.Contains("PatientID"))
                                cei.strPatientID = drReturn["PatientID"].ToString();
                            else
                                cei.strPatientID = "";
                            if (drReturn.Table.Columns.Contains("AccessionNumber"))
                                cei.strAccessionNumber = drReturn["AccessionNumber"].ToString();
                            else
                                cei.strAccessionNumber = "";
                            if (drReturn.Table.Columns.Contains("NameEN"))
                                cei.strNameEN = drReturn["NameEN"].ToString();
                            else
                                cei.strNameEN = "";
                            if (drReturn.Table.Columns.Contains("NameCN"))
                                cei.strNameCN = drReturn["NameCN"].ToString();
                            else
                                cei.strNameCN = "";
                            if (drReturn.Table.Columns.Contains("Gender"))
                                cei.strGender = drReturn["Gender"].ToString();
                            else
                                cei.strGender = "";
                            if (drReturn.Table.Columns.Contains("Birthday"))
                                cei.strBirthday = drReturn["Birthday"].ToString();
                            else
                                cei.strBirthday = "";
                            if (drReturn.Table.Columns.Contains("Modality"))
                                cei.strModality = drReturn["Modality"].ToString();
                            else
                                cei.strModality = "";
                            if (drReturn.Table.Columns.Contains("ModalityName"))
                                cei.strModalityName = drReturn["ModalityName"].ToString();
                            else
                                cei.strModalityName = "";
                            if (drReturn.Table.Columns.Contains("PatientType"))
                                cei.strPatientType = drReturn["PatientType"].ToString();
                            else
                                cei.strPatientType = "";
                            if (drReturn.Table.Columns.Contains("VisitID"))
                                cei.strVisitID = drReturn["VisitID"].ToString();
                            else
                                cei.strVisitID = "";
                            if (drReturn.Table.Columns.Contains("RequestID"))
                                cei.strRequestID = drReturn["RequestID"].ToString();
                            else
                                cei.strRequestID = "";
                            if (drReturn.Table.Columns.Contains("RequestDepartment"))
                                cei.strRequestDepartment = drReturn["RequestDepartment"].ToString();
                            else
                                cei.strRequestDepartment = "";
                            if (drReturn.Table.Columns.Contains("RequestDT"))
                                cei.strRequestDT = drReturn["RequestDT"].ToString();
                            else
                                cei.strRequestDT = "";
                            if (drReturn.Table.Columns.Contains("RegisterDT"))
                                cei.strRegisterDT = drReturn["RegisterDT"].ToString();
                            else
                                cei.strRegisterDT = "";
                            if (drReturn.Table.Columns.Contains("ExamDT"))
                                cei.strExamDT = drReturn["ExamDT"].ToString();
                            else
                                cei.strExamDT = "";

                            if (drReturn.Table.Columns.Contains("SubmitDT"))
                                cei.strSubmitDT = drReturn["SubmitDT"].ToString();
                            else
                                cei.strSubmitDT = "";
                            if (drReturn.Table.Columns.Contains("ApproveDT"))
                                cei.strApproveDT = drReturn["ApproveDT"].ToString();
                            else
                                cei.strApproveDT = "";
                            if (drReturn.Table.Columns.Contains("PDFReportURL"))
                                cei.strPDFReportURL = drReturn["PDFReportURL"].ToString();
                            else
                                cei.strPDFReportURL = "";
                            if (drReturn.Table.Columns.Contains("StudyStatus"))
                                cei.strStudyStatus = drReturn["StudyStatus"].ToString();
                            else
                                cei.strStudyStatus = "";

                            if (drReturn.Table.Columns.Contains("OutHospitalNo"))
                                cei.strOutHospitalNo = drReturn["OutHospitalNo"].ToString();
                            else
                                cei.strOutHospitalNo = "";
                            if (drReturn.Table.Columns.Contains("InHospitalNo"))
                                cei.strInHospitalNo = drReturn["InHospitalNo"].ToString();
                            else
                                cei.strInHospitalNo = "";
                            if (drReturn.Table.Columns.Contains("PhysicalNumber"))
                                cei.strPhusicalNumber = drReturn["PhysicalNumber"].ToString();
                            else
                                cei.strPhusicalNumber = "";
                            if (drReturn.Table.Columns.Contains("ExamName"))
                                cei.strExamName = drReturn["ExamName"].ToString();
                            else
                                cei.strExamName = "";
                            if (drReturn.Table.Columns.Contains("ExamBodyPart"))
                                cei.strExamBodyPart = drReturn["ExamBodyPart"].ToString();
                            else
                                cei.strExamBodyPart = "";

                            if (drReturn.Table.Columns.Contains("Optional0"))
                                cei.strOptional0 = drReturn["Optional0"].ToString();
                            else
                                cei.strOptional0 = "";
                            if (drReturn.Table.Columns.Contains("Optional1"))
                                cei.strOptional1 = drReturn["Optional1"].ToString();
                            else
                                cei.strOptional1 = "";
                            if (drReturn.Table.Columns.Contains("Optional2"))
                                cei.strOptional2 = drReturn["Optional2"].ToString();
                            else
                                cei.strOptional2 = "";
                            if (drReturn.Table.Columns.Contains("Optional3"))
                                cei.strOptional3 = drReturn["Optional3"].ToString();
                            else
                                cei.strOptional3 = "";
                            if (drReturn.Table.Columns.Contains("Optional4"))
                                cei.strOptional4 = drReturn["Optional4"].ToString();
                            else
                                cei.strOptional4 = "";
                            if (drReturn.Table.Columns.Contains("Optional5"))
                                cei.strOptional5 = drReturn["Optional5"].ToString();
                            else
                                cei.strOptional5 = "";
                            if (drReturn.Table.Columns.Contains("Optional6"))
                                cei.strOptional6 = drReturn["Optional6"].ToString();
                            else
                                cei.strOptional6 = "";
                            if (drReturn.Table.Columns.Contains("Optional7"))
                                cei.strOptional7 = drReturn["Optional7"].ToString();
                            else
                                cei.strOptional7 = "";
                            if (drReturn.Table.Columns.Contains("Optional8"))
                                cei.strOptional8 = drReturn["Optional8"].ToString();
                            else
                                cei.strOptional8 = "";
                            if (drReturn.Table.Columns.Contains("Optional9"))
                                cei.strOptional9 = drReturn["Optional9"].ToString();
                            else
                                cei.strOptional9 = "";

                            LogUtil.DebugLog("Call Function.SetPSExamInfo().");

                            bReturn = SetPSExamInfo(cei);

                            LogUtil.DebugLog("Function.SetPSExamInfo() Return = " + bReturn.ToString());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                if (null != dsReturn)
                {
                    dsReturn.Dispose();
                    dsReturn = null;
                }

                LogUtil.ErrorLog("FunctionForEI.GetRISExamInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                FunctionDispose();

                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                LogUtil.DebugLog("FunctionForEI.GetRISExamInfo() Return = DataSet.");
                LogUtil.DebugLog("Exit FunctionForEI.GetRISExamInfo().");
            }

            return dsReturn;
        }

        private DataSet GetRISExamInfoEx(string strParam)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.GetRISExamInfoEx(), Input Parameter AS Follows:");
            LogUtil.DebugLog("Param = " + strParam);

            DataSet dsReturn = null;
            CExamInfo cei = new CExamInfo();
            bool bReturn = false;
            string strSQL = "";
            string strOutputInfo = "";

            try
            {
                FunctionInitializ();

                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForGetRISExamInfoEx;

                if ("MYSQL" == m_Config_WSProxy.M_RISDBType.Trim().ToUpper())
                {
                    LogUtil.DebugLog("Call DAOMySQLRIS.GetRISExamInfoEx(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("Param = " + strParam);

                    //dsReturn = m_DAOMySQLRIS.GetRISExamInfoEx(strSQL, strParam, out strOutputInfo);

                    LogUtil.DebugLog("DAOMySQLRIS.GetRISExamInfoEx(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                }
                else if ("ORACLE" == m_Config_WSProxy.M_RISDBType.Trim().ToUpper())
                {
                    LogUtil.DebugLog("Call DAOORACLERIS.GetRISExamInfoEx(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("Param = " + strParam);

                    //dsReturn = m_DAOORACLERIS.GetRISExamInfoEx(strSQL, strParam, out strOutputInfo);

                    LogUtil.DebugLog("DAOORACLERIS.GetRISExamInfoEx(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                }
                else
                {
                    LogUtil.DebugLog("Call DAOMSSQLRIS.GetRISExamInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("Param = " + strParam);

                    dsReturn = m_DAOMSSQLRIS.GetRISExamInfoEx(strSQL, strParam, out strOutputInfo);

                    LogUtil.DebugLog("DAOMSSQLRIS.GetRISExamInfoEx(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                }

                if (null != dsReturn)
                {
                    if (0 < dsReturn.Tables[0].Rows.Count)
                    {
                        foreach (DataRow drReturn in dsReturn.Tables[0].Rows)
                        {
                            cei.CExamInfoClear();
                            cei.strPatientID = drReturn["PatientID"].ToString();
                            cei.strAccessionNumber = drReturn["AccessionNumber"].ToString();
                            cei.strNameEN = drReturn["NameEN"].ToString();
                            cei.strNameCN = drReturn["NameCN"].ToString();
                            cei.strGender = drReturn["Gender"].ToString();
                            cei.strBirthday = drReturn["Birthday"].ToString();
                            cei.strModality = drReturn["Modality"].ToString();
                            cei.strModalityName = drReturn["ModalityName"].ToString();
                            cei.strPatientType = drReturn["PatientType"].ToString();
                            cei.strVisitID = drReturn["VisitID"].ToString();
                            cei.strRequestID = drReturn["RequestID"].ToString();
                            cei.strRequestDepartment = drReturn["RequestDepartment"].ToString();
                            cei.strRequestDT = drReturn["RequestDT"].ToString();
                            cei.strRegisterDT = drReturn["RegisterDT"].ToString();
                            cei.strExamDT = drReturn["ExamDT"].ToString();
                            cei.strSubmitDT = drReturn["SubmitDT"].ToString();
                            cei.strApproveDT = drReturn["ApproveDT"].ToString();
                            cei.strPDFReportURL = drReturn["PDFReportURL"].ToString();
                            cei.strStudyStatus = drReturn["StudyStatus"].ToString();
                            cei.strOptional0 = drReturn["Optional0"].ToString();
                            cei.strOptional1 = drReturn["Optional1"].ToString();
                            cei.strOptional2 = drReturn["Optional2"].ToString();
                            cei.strOptional3 = drReturn["Optional3"].ToString();
                            cei.strOptional4 = drReturn["Optional4"].ToString();
                            cei.strOptional5 = drReturn["Optional5"].ToString();
                            cei.strOptional6 = drReturn["Optional6"].ToString();
                            cei.strOptional7 = drReturn["Optional7"].ToString();
                            cei.strOptional8 = drReturn["Optional8"].ToString();
                            cei.strOptional9 = drReturn["Optional9"].ToString();

                            LogUtil.DebugLog("Call Function.SetPSExamInfo().");

                            bReturn = SetPSExamInfo(cei);

                            LogUtil.DebugLog("Function.SetPSExamInfo() Return = " + bReturn.ToString());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                if (null != dsReturn)
                {
                    dsReturn.Dispose();
                    dsReturn = null;
                }

                LogUtil.ErrorLog("FunctionForEI.GetRISExamInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                FunctionDispose();

                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                LogUtil.DebugLog("FunctionForEI.GetRISExamInfo() Return = DataSet.");
                LogUtil.DebugLog("Exit FunctionForEI.GetRISExamInfo().");
            }

            return dsReturn;
        }

        public bool QueryExamInfo(string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStartDT, string strEndDT, out string strExamInfoList)
        {
            if (m_Config_WSProxy.M_strSwingGetExamInfo == "0")
            {
                LogUtil.DebugLog("FunctionForEI.QueryExamInfo() return immediately,SwingGetExamInfo=" + m_Config_WSProxy.M_strSwingGetExamInfo);
                strExamInfoList = "<examInfoList />";
                return false;
            }

            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.QueryExamInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientID = " + strPatientID);
            LogUtil.DebugLog("PatientName = " + strPatientName);
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("Modality = " + strModality);
            LogUtil.DebugLog("StartDT = " + strStartDT);
            LogUtil.DebugLog("EndDT = " + strEndDT);

            bool bReturn = true;
            DataSet dsRISExamInfo = null;
            CExamInfo cei = new CExamInfo();
            string strXSLTPath = "";

            strExamInfoList = "";

            try
            {
                //1 Assignment Operator From InParam To CExamInfo;
                cei.CExamInfoClear();
                cei.strPatientID = strPatientID;
                cei.strNameEN = strPatientName;
                cei.strAccessionNumber = strAccessionNumber;
                cei.strModality = strModality;

                strXSLTPath = m_Config_WSProxy.M_XSLTPathForQueryExamInfo;

                LogUtil.DebugLog("Call FunctionForEI.GetRISExamInfo().");

                if (ALValue.Count > 0)
                {
                    //ALRemove：用于存储过期PID\Accnum和对应的存储时间
                    ArrayList ALRemoveValue = new ArrayList();
                    ArrayList ALRemoveTime = new ArrayList();

                    //查找过期PID\Accnum和对应的存储时间，并存于ALRemove中
                    for (int i = 0; i < ALValue.Count; i++)
                    {
                        string value = ALValue[i].ToString();
                        DateTime start = (DateTime)ALTime[i];
                        DateTime dt = DateTime.Now;
                        TimeSpan tSplit = dt - start;
                        int Keep = tSplit.Minutes * 60 + tSplit.Seconds;

                        if (Keep > m_Config_WSProxy.M_iQueryInterval)
                        {
                            ALRemoveValue.Add(value);
                            ALRemoveTime.Add(start);
                        }
                    }

                    //删除PID\Accnum
                    if (ALRemoveValue.Count > 0)
                    {
                        for (int i = 0; i < ALRemoveValue.Count; i++)
                        {
                            ALValue.Remove(ALRemoveValue[i]);
                        }
                    }

                    //删除存储时间
                    if (ALRemoveTime.Count > 0)
                    {
                        for (int i = 0; i < ALRemoveTime.Count; i++)
                        {
                            ALTime.Remove(ALRemoveTime[i]);
                        }
                    }
                }

                //判断调用集成的PID和AccNum，是否在Query Interval Time内已经使用，如已经使用，则禁止调用集成
                string strPIDAndPNameAndAccNumAndModality = "PatientID=" + strPatientID.Trim() + "PName=" + strPatientName.Trim() + "AccNum=" + strAccessionNumber.Trim() + "Modality=" + strModality.Trim();
                if (ALValue.Contains(strPIDAndPNameAndAccNumAndModality))
                {
                    strExamInfoList = "<examInfoList />";
                    bReturn = false;

                    LogUtil.DebugLog("Enter FunctionForEI.QueryExamInfo(), Output Parameter AS Follows:");
                    LogUtil.DebugLog(string.Format("No value in RIS, PatientID={0}, PName={1}, AccessionNumber={2}，Modality={3}.", strPatientID, strPatientName, strAccessionNumber, strModality));
                    LogUtil.DebugLog("FunctionForEI.QueryExamInfo() Return value = " + strExamInfoList);
                    LogUtil.DebugLog("Exit FunctionForEI.QueryExamInfo().");

                    return bReturn;
                }

                //2 GetRISExamInfo() From RIS To DataSet By CExamInfo;
                dsRISExamInfo = GetRISExamInfo(cei.strPatientID, cei.strNameEN, cei.strAccessionNumber, cei.strModality, strStartDT, strEndDT);

                LogUtil.DebugLog("FunctionForEI.GetRISExamInfo() Return = DataSet.");

                if (null == dsRISExamInfo || 0 >= dsRISExamInfo.Tables[0].Rows.Count)
                {
                    if ("0" != m_Config_WSProxy.M_MWLEnabled)
                    {
                        if (0 < strPatientID.Length)
                        {
                            string[] strPatientIDList = strPatientID.Split(',');

                            foreach (string strPID in strPatientIDList)
                            {
                                GetMWLExamInfo(strPID, "", "", "", "", "", "");
                            }
                        }

                        if (0 < strAccessionNumber.Length)
                        {
                            string[] strAccessionNumberList = strAccessionNumber.Split(',');

                            foreach (string strAN in strAccessionNumberList)
                            {
                                GetMWLExamInfo("", "", strAN, "", "", "", "");
                            }
                        }

                        dsRISExamInfo = GetRISExamInfo(cei.strPatientID, cei.strNameEN, cei.strAccessionNumber, cei.strModality, strStartDT, strEndDT);
                    }
                }

                if (null == dsRISExamInfo)
                {
                    ALValue.Add(strPIDAndPNameAndAccNumAndModality);
                    ALTime.Add(DateTime.Now);
                    LogUtil.DebugLog(string.Format("No value in RIS, PatientID={0}, PName={1}, AccessionNumber={2}，Modality={3}.", strPatientID, strPatientName, strAccessionNumber, strModality));
                    strExamInfoList = "<examInfoList />";
                    bReturn = false;
                }
                else
                {
                    if (dsRISExamInfo.Tables[0].Rows.Count < 1)
                    {
                        ALValue.Add(strPIDAndPNameAndAccNumAndModality);
                        ALTime.Add(DateTime.Now);
                        LogUtil.DebugLog(string.Format("No value in RIS, PatientID={0}, PName={1}, AccessionNumber={2}，Modality={3}.", strPatientID, strPatientName, strAccessionNumber, strModality));
                        strExamInfoList = "<examInfoList />";
                        bReturn = false;
                    }
                    else
                    {
                        LogUtil.DebugLog("Call Function.DataSetToXML().");

                        //3 Convert DataSet to XML.
                        strExamInfoList = DataSetToXML(dsRISExamInfo, strXSLTPath);
                    }
                }

                LogUtil.DebugLog("Function.DataSetToXML() Return = " + strExamInfoList);
            }
            catch (Exception ex)
            {
                bReturn = false;
                strExamInfoList = "";

                LogUtil.ErrorLog("FunctionForEI.QueryExamInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != dsRISExamInfo)
                {
                    dsRISExamInfo.Dispose();
                    dsRISExamInfo = null;
                }

                cei.CExamInfoClear();

                LogUtil.DebugLog("FunctionForEI.QueryExamInfo() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit FunctionForEI.QueryExamInfo().");
            }

            return bReturn;
        }

        public string QueryExamInfoEx(string strParam)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.QueryExamInfoEx(), Input Parameter AS Follows:");
            LogUtil.DebugLog("Param = " + strParam);

            bool bReturn = true;
            DataSet dsRISExamInfo = null;
            CExamInfo cei = new CExamInfo();
            string strXSLTPath = "";
            string strExamInfoList = "";

            try
            {
                //1 Assignment Operator From InParam To CExamInfo;
                cei.CExamInfoClear();

                strXSLTPath = m_Config_WSProxy.M_XSLTPathForQueryExamInfo;

                LogUtil.DebugLog("Call FunctionForEI.GetRISExamInfo().");

                //2 GetRISExamInfo() From RIS To DataSet By CExamInfo;
                dsRISExamInfo = GetRISExamInfoEx(strParam);

                LogUtil.DebugLog("FunctionForEI.GetRISExamInfoEx() Return = DataSet.");

                LogUtil.DebugLog("Call Function.DataSetToXML().");

                //3 Convert DataSet to XML.
                strExamInfoList = DataSetToXML(dsRISExamInfo, strXSLTPath);

                LogUtil.DebugLog("Function.DataSetToXML() Return = " + strExamInfoList);
            }
            catch (Exception ex)
            {
                bReturn = false;
                strExamInfoList = "";

                LogUtil.ErrorLog("FunctionForEI.QueryExamInfoEx() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != dsRISExamInfo)
                {
                    dsRISExamInfo.Dispose();
                    dsRISExamInfo = null;
                }

                cei.CExamInfoClear();

                LogUtil.DebugLog("FunctionForEI.QueryExamInfoEx() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit FunctionForEI.QueryExamInfoEx().");
            }

            return strExamInfoList;
        }

        public string QueryExamInfo(string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStartDT, string strEndDT)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.QueryExamInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientID = " + strPatientID);
            LogUtil.DebugLog("PatientName = " + strPatientName);
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("Modality = " + strModality);
            LogUtil.DebugLog("StartDT = " + strStartDT);
            LogUtil.DebugLog("EndDT = " + strEndDT);

            DataSet dsRISExamInfo = null;
            string strExamInfoList = "";
            CExamInfo cei = new CExamInfo();
            string strXSLTPath = "";

            try
            {
                //1 Assignment Operator From InParam To CExamInfo;
                cei.CExamInfoClear();
                cei.strPatientID = strPatientID;
                cei.strNameEN = strPatientName;
                cei.strAccessionNumber = strAccessionNumber;
                cei.strModality = strModality;

                strXSLTPath = m_Config_WSProxy.M_XSLTPathForQueryExamInfo;

                LogUtil.DebugLog("Call FunctionForEI.GetRISExamInfo().");

                //2 GetRISExamInfo() From RIS To DataSet By CExamInfo;
                dsRISExamInfo = GetRISExamInfo(cei.strPatientID, cei.strNameEN, cei.strAccessionNumber, cei.strModality, strStartDT, strEndDT);

                LogUtil.DebugLog("FunctionForEI.GetRISExamInfo() Return = DataSet.");


                if (null == dsRISExamInfo || 0 >= dsRISExamInfo.Tables[0].Rows.Count)
                {
                    if ("0" != m_Config_WSProxy.M_MWLEnabled)
                    {
                        if (0 < strPatientID.Length)
                        {
                            string[] strPatientIDList = strPatientID.Split(',');

                            foreach (string strPID in strPatientIDList)
                            {
                                GetMWLExamInfo(strPID, "", "", "", "", "", "");
                            }
                        }

                        if (0 < strAccessionNumber.Length)
                        {
                            string[] strAccessionNumberList = strAccessionNumber.Split(',');

                            foreach (string strAN in strAccessionNumberList)
                            {
                                GetMWLExamInfo("", "", strAN, "", "", "", "");
                            }
                        }

                        dsRISExamInfo = GetRISExamInfo(cei.strPatientID, cei.strNameEN, cei.strAccessionNumber, cei.strModality, strStartDT, strEndDT);
                    }
                }

                LogUtil.DebugLog("Call Function.DataSetToXML().");

                //3 Convert DataSet to XML.
                strExamInfoList = DataSetToXML(dsRISExamInfo, strXSLTPath);

                LogUtil.DebugLog("Function.DataSetToXML() Return = " + strExamInfoList);
            }
            catch (Exception ex)
            {
                strExamInfoList = "";

                LogUtil.ErrorLog("FunctionForEI.QueryExamInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != dsRISExamInfo)
                {
                    dsRISExamInfo.Dispose();
                    dsRISExamInfo = null;
                }

                cei.CExamInfoClear();

                LogUtil.DebugLog("FunctionForEI.QueryExamInfo() Return = " + strExamInfoList);
                LogUtil.DebugLog("Exit FunctionForEI.QueryExamInfo().");
            }

            return strExamInfoList;
        }

        public string UpdateExamInfo(string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStartDT, string strEndDT)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.UpdateExamInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientID = " + strPatientID);
            LogUtil.DebugLog("PatientName = " + strPatientName);
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("Modality = " + strModality);
            LogUtil.DebugLog("StartDT = " + strStartDT);
            LogUtil.DebugLog("EndDT = " + strEndDT);

            DataSet dsRISExamInfo = null;
            string strExamInfoList = "";
            CExamInfo cei = new CExamInfo();
            string strXSLTPath = "";

            try
            {
                //1 Assignment Operator From InParam To CExamInfo;
                cei.CExamInfoClear();
                cei.strPatientID = strPatientID;
                cei.strNameEN = strPatientName;
                cei.strAccessionNumber = strAccessionNumber;
                cei.strModality = strModality;

                strXSLTPath = m_Config_WSProxy.M_XSLTPathForUpdateExamInfo;

                LogUtil.DebugLog("Call FunctionForEI.GetRISExamInfo().");

                //2 GetRISExamInfo() From RIS To DataSet By CExamInfo;
                dsRISExamInfo = GetRISExamInfo(cei.strPatientID, cei.strNameEN, cei.strAccessionNumber, cei.strModality, strStartDT, strEndDT);

                LogUtil.DebugLog("FunctionForEI.GetRISExamInfo() Return = DataSet.");

                if (null == dsRISExamInfo || 0 >= dsRISExamInfo.Tables[0].Rows.Count)
                {
                    if ("0" != m_Config_WSProxy.M_MWLEnabled)
                    {
                        if (0 < strPatientID.Length)
                        {
                            string[] strPatientIDList = strPatientID.Split(',');

                            foreach (string strPID in strPatientIDList)
                            {
                                GetMWLExamInfo(strPID, "", "", "", "", "", "");
                            }
                        }

                        if (0 < strAccessionNumber.Length)
                        {
                            string[] strAccessionNumberList = strAccessionNumber.Split(',');

                            foreach (string strAN in strAccessionNumberList)
                            {
                                GetMWLExamInfo("", "", strAN, "", "", "", "");
                            }
                        }

                        dsRISExamInfo = GetRISExamInfo(cei.strPatientID, cei.strNameEN, cei.strAccessionNumber, cei.strModality, strStartDT, strEndDT);
                    }
                }

                LogUtil.DebugLog("Call Function.DataSetToXML().");

                //3 Convert DataSet to XML.
                strExamInfoList = DataSetToXML(dsRISExamInfo, strXSLTPath);

                LogUtil.DebugLog("Function.DataSetToXML() Return = " + strExamInfoList);
            }
            catch (Exception ex)
            {
                strExamInfoList = "";

                LogUtil.ErrorLog("FunctionForEI.UpdateExamInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != dsRISExamInfo)
                {
                    dsRISExamInfo.Dispose();
                    dsRISExamInfo = null;
                }

                cei.CExamInfoClear();

                LogUtil.DebugLog("FunctionForEI.UpdateExamInfo() Return = " + strExamInfoList);
                LogUtil.DebugLog("Exit FunctionForEI.UpdateExamInfo().");
            }

            return strExamInfoList;
        }

        private bool GetRISReportInfo(string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strReportID, string strReportStatus)
        {
            #region annotation

            //1 Call GetRISReportInfo();
            //2 Call SetRISReportInfo();
            //3 Call Function.NotifyReportInfo() By CExamInfo;
            //4 Call Function.SetPSExamInfo() By CExamInfo.

            #endregion annotation

            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.GetRISReportInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientID=" + strPatientID);
            LogUtil.DebugLog("PatientName=" + strPatientName);
            LogUtil.DebugLog("AccessionNumber=" + strAccessionNumber);
            LogUtil.DebugLog("Modality=" + strModality);
            LogUtil.DebugLog("ReportID=" + strReportID);
            LogUtil.DebugLog("ReportStatus=" + strReportStatus);

            bool bReturn = false;
            DataSet dsRISReportInfo = null;
            CExamInfo cei = new CExamInfo();
            string strSQL = "";
            string strOutputInfo = "";
            string strReportURL = "";

            try
            {
                FunctionInitializ();

                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForGetRISReportInfo;

                //1 Call GetRISReportInfo();
                if ("MYSQL" == m_Config_WSProxy.M_RISDBType.Trim().ToUpper())
                {
                    LogUtil.DebugLog("Call DAOMySQLRIS.GetRISReportInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("PatientID=" + strPatientID);
                    LogUtil.DebugLog("PatientName=" + strPatientName);
                    LogUtil.DebugLog("AccessionNumber=" + strAccessionNumber);
                    LogUtil.DebugLog("Modality=" + strModality);
                    LogUtil.DebugLog("ReportID=" + strReportID);
                    LogUtil.DebugLog("ReportStatus=" + strReportStatus);

                    dsRISReportInfo = m_DAOMySQLRIS.GetRISReportInfo(strSQL,
                        strPatientID,
                        strPatientName,
                        strAccessionNumber,
                        strModality,
                        strReportID,
                        strReportStatus,
                        out strOutputInfo,
                        out strReportURL);

                    LogUtil.DebugLog("DAOMySQLRIS.GetRISReportInfo(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                }
                else if ("ORACLE" == m_Config_WSProxy.M_RISDBType.Trim().ToUpper())
                {
                    LogUtil.DebugLog("Call DAOORACLERIS.GetRISReportInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("PatientID=" + strPatientID);
                    LogUtil.DebugLog("PatientName=" + strPatientName);
                    LogUtil.DebugLog("AccessionNumber=" + strAccessionNumber);
                    LogUtil.DebugLog("Modality=" + strModality);
                    LogUtil.DebugLog("ReportID=" + strReportID);
                    LogUtil.DebugLog("ReportStatus=" + strReportStatus);

                    dsRISReportInfo = m_DAOORACLERIS.GetRISReportInfo(strSQL,
                        strPatientID,
                        strPatientName,
                        strAccessionNumber,
                        strModality,
                        strReportID,
                        strReportStatus,
                        out strOutputInfo,
                        out strReportURL);

                    LogUtil.DebugLog("DAOORACLERIS.GetRISReportInfo(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                }
                else
                {
                    LogUtil.DebugLog("Call DAOMSSQLRIS.GetRISReportInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("PatientID=" + strPatientID);
                    LogUtil.DebugLog("PatientName=" + strPatientName);
                    LogUtil.DebugLog("AccessionNumber=" + strAccessionNumber);
                    LogUtil.DebugLog("Modality=" + strModality);
                    LogUtil.DebugLog("ReportID=" + strReportID);
                    LogUtil.DebugLog("ReportStatus=" + strReportStatus);

                    dsRISReportInfo = m_DAOMSSQLRIS.GetRISReportInfo(strSQL,
                                strPatientID,
                                strPatientName,
                                strAccessionNumber,
                                strModality,
                                strReportID,
                                strReportStatus,
                                out strOutputInfo,
                                out strReportURL);

                    LogUtil.DebugLog("DAOMSSQLRIS.GetRISReportInfo(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                    LogUtil.DebugLog("ReportURL = " + strReportURL);
                }

                if (dsRISReportInfo != null)
                {
                    LogUtil.DebugLog("Start to Download PDF Report ");

                    //2 Call SetRISReportInfo();
                    cei.CExamInfoClear();
                    cei.strPatientID = strPatientID;
                    cei.strNameCN = strPatientName;
                    cei.strAccessionNumber = strAccessionNumber;
                    foreach (DataRow drRISReportInfo in dsRISReportInfo.Tables[0].Rows)
                    {
                        string PatientID = dsRISReportInfo.Tables[0].Rows[0]["PatientID"].ToString();
                        string NameCN = dsRISReportInfo.Tables[0].Rows[0]["NameCN"].ToString();
                        string AccessionNumber = dsRISReportInfo.Tables[0].Rows[0]["AccessionNumber"].ToString();
                        string TempURL = string.Empty;
                        string strAccessionNumberChange = string.Empty;
                        strAccessionNumberChange = drRISReportInfo["AccessionNumber"].ToString();
                        cei.strStudyInstanceUID = dsRISReportInfo.Tables[0].Rows[0]["ReportID"].ToString();
                        if (string.IsNullOrEmpty(cei.strPDFReportURL.Trim()))
                        {
                            cei.strPDFReportURL = drRISReportInfo["PDFReportURL"].ToString();
                            TempURL = drRISReportInfo["PDFReportURL"].ToString();

                            if (m_Config_WSProxy.M_strGetReportFromShareFolder=="1" && !string.IsNullOrEmpty(TempURL.Trim()))
                            {
                                string sourcePath = TempURL;
                                string UserName = dsRISReportInfo.Tables[0].Rows[0]["UserName"].ToString();
                                string Password = dsRISReportInfo.Tables[0].Rows[0]["Password"].ToString();
                                string Server = dsRISReportInfo.Tables[0].Rows[0]["Server"].ToString();
                                string ShareName = dsRISReportInfo.Tables[0].Rows[0]["ShareName"].ToString();

                                string ReportName = cei.strPatientID + "_" + cei.strAccessionNumber + "_" + cei.strStudyInstanceUID + ".pdf";
                                string localPDFFolder = m_Config_WSProxy.M_PDFPhysicPath + @"\" + DateTime.Now.ToString("yyyy-MM-dd");
                                string targetPath = localPDFFolder + @"\" + ReportName;

                                if (!Directory.Exists(localPDFFolder))
                                {
                                    LogUtil.DebugLog(string.Format("Create local folder, {0}.", localPDFFolder));
                                    Directory.CreateDirectory(localPDFFolder);
                                    LogUtil.DebugLog(string.Format("Create local folder success，{0}.", localPDFFolder));
                                }

                                LogUtil.DebugLog(string.Format("Download Report From Share Folder Start.Share Path, {0}；local Path，{1}", sourcePath, targetPath));

                                string error = string.Empty;

                                if (FileCopy(sourcePath, targetPath, Server, ShareName, UserName, Password, out error) == 0)
                                {
                                    TempURL = targetPath;
                                    LogUtil.DebugLog(string.Format("Download Report From Share Folder Success.Share Path, {0}；local Path，{1}", sourcePath, targetPath));
                                }
                                else
                                {
                                    LogUtil.ErrorLog(string.Format("Download Report From Share Folder Fail.Share Path, {0}；local Path，{1}", sourcePath, targetPath));
                                    LogUtil.ErrorLog(string.Format("Download Report From Share Folder Fail.Server, {0}；ShareName，{1}；UserName，{2}；Password，{3}", Server, ShareName, UserName, Password));
                                    LogUtil.ErrorLog("Download Report From Share Folder Fail.Server," + error);
                                }
                                LogUtil.DebugLog(string.Format("Download Report From Share Folder Start.Share Path, {0}；local Path，{1}", sourcePath, targetPath));
                            }
                        }
                        else
                        {
                            cei.strPDFReportURL = cei.strPDFReportURL + "," + "asso://" + strAccessionNumberChange + "/" + strAccessionNumberChange;
                            TempURL = "asso://" + strAccessionNumberChange + "/" + strAccessionNumberChange;
                        }

                        LogUtil.DebugLog("Combine URl =" + cei.strPDFReportURL.ToString());

                        if (!string.IsNullOrEmpty(TempURL.Trim()))
                        {
                            //3 Call Function.NotifyReportInfo() By CExamInfo;
                            LogUtil.DebugLog("Call PS.Function.NotifyReportInfo().");
                            LogUtil.DebugLog("PatientName = " + NameCN);
                            LogUtil.DebugLog("PatientID = " + PatientID);
                            LogUtil.DebugLog("AccessionNumber = " + AccessionNumber);
                            LogUtil.DebugLog("StudyUID = " + cei.strStudyInstanceUID);
                            LogUtil.DebugLog("Report Status = " + cei.iReportStatus.ToString());
                            LogUtil.DebugLog("Report URl =" + TempURL.ToString());

                            string[] strReportFileNameList = TempURL.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                            cei.iReportStatus = 2; //0:not ready, just update Chinese name; 1:temp report; 2:formal report.

                            bReturn = NotifyReportInfo(NameCN, PatientID, AccessionNumber,
                                cei.strStudyInstanceUID, cei.iReportStatus, strReportFileNameList);

                            LogUtil.DebugLog("Function.NotifyReportInfo() Return = " + bReturn.ToString());
                        }
                    }

                    if (bReturn)
                    {
                        cei.iPDFFlag = 1;
                        cei.iNotifyReportFlag = 1;
                        LogUtil.DebugLog("Call Function.SetPSExamInfo().");
                        bReturn = SetPSExamInfo(cei);
                        LogUtil.DebugLog("Function.SetPSExamInfo() Return = " + bReturn.ToString());
                    }

                    LogUtil.DebugLog("Finsh Downloading PDF Report ");
                }
            }
            catch (Exception ex)
            {
                bReturn = false;

                LogUtil.ErrorLog("FunctionForEI.GetRISReportInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != dsRISReportInfo)
                {
                    dsRISReportInfo.Dispose();
                    dsRISReportInfo = null;
                }

                LogUtil.DebugLog("FunctionForEI.GetRISReportInfo() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit FunctionForEI.GetRISReportInfo().");
            }

            return bReturn;
        }

        private bool GetRISReportInfoExWS(string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strReportID, string strReportStatus)
        {
            #region annotation

            //1 Call GetHttpWebRequestBody() By PatientID & AccessionNumber;
            //2 Call Function.NotifyReportInfo() By CExamInfo;
            //3 Call Function.SetPSExamInfo() By CExamInfo.

            #endregion annotation

            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.GetRISReportInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientID=" + strPatientID);
            LogUtil.DebugLog("PatientName=" + strPatientName);
            LogUtil.DebugLog("AccessionNumber=" + strAccessionNumber);

            bool bReturn = true;
            string strHttpURL = "";
            CExamInfo cei = new CExamInfo();
            string[] strReportFileNameList = null;

            try
            {
                cei.CExamInfoClear();
                cei.strPatientID = strPatientID;
                cei.strAccessionNumber = strAccessionNumber;

                //http://localhost/GUANGZHOUHY/WSProxy.asmx/GetRISPDFReport?strPatientID={0}&amp;strPatientName={1}&amp;strAccessionNumber={2}&amp;strModality={3}&amp;strReportID={4}&amp;strReportStatus={5}
                //http://localhost/GUANGZHOUHY/WSProxy.asmx/GetRISPDFReport?strPatientID=&strPatientName=&strAccessionNumber=&strModality=&strReportID=&strReportStatus=

                strHttpURL = string.Format(m_Config_WSProxy.M_WSURL_RISPDFReportInfo,
                    cei.strPatientID,
                    cei.strNameCN,
                    cei.strAccessionNumber,
                    cei.strModality,
                    cei.strRequestID,
                    cei.strStudyStatus);

                cei.strNameCN = strPatientName;
                //cei.strStudyInstanceUID = strAccessionNumber;
                //cei.strRequestID = strReportID;
                //cei.strStudyStatus = strReportStatus;

                //1 Call GetHttpWebRequestBody() By PatientID & AccessionNumber;
                cei.strPDFReportURL = GetHttpWebRequestBody(strHttpURL);

                if (cei.strPDFReportURL.Trim().Length > 0)
                {
                    strReportFileNameList = new string[] { cei.strPDFReportURL };
                    cei.iReportStatus = 2; //0:not ready, just update Chinese name; 1:temp report; 2:formal report.

                    //2 Call Function.NotifyReportInfo() By CExamInfo;
                    if (bReturn)
                    {
                        LogUtil.DebugLog("Call Function.NotifyReportInfo().");

                        bReturn = NotifyReportInfo(cei.strNameCN, cei.strPatientID, cei.strAccessionNumber, cei.strStudyInstanceUID, cei.iReportStatus, strReportFileNameList);

                        LogUtil.DebugLog("Function.NotifyReportInfo() Return = " + bReturn.ToString());

                        cei.iPDFFlag = 1;
                        cei.iNotifyReportFlag = 1;
                    }

                    //3 Call Function.SetPSExamInfo() By CExamInfo.
                    if (bReturn)
                    {
                        LogUtil.DebugLog("Call Function.SetPSExamInfo().");

                        bReturn = SetPSExamInfo(cei);

                        LogUtil.DebugLog("Function.SetPSExamInfo() Return = " + bReturn.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                bReturn = false;

                LogUtil.ErrorLog("FunctionForEI.GetRISReportInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("FunctionForEI.GetRISReportInfo() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit FunctionForEI.GetRISReportInfo().");
            }

            return bReturn;
        }

        private bool GetRISReportInfoExGCRIS(string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strReportID, string strReportStatus)
        {
            #region annotation

            //1 Call GetRISReportInfo();
            //2 Call Function.CreatePDF();
            //3 Call Function.NotifyReportInfo() By CExamInfo;
            //4 Call Function.SetPSExamInfo() By CExamInfo.
            //5 Call SetRISReportInfoExGCRIS() From CExamInfo To RIS.

            #endregion annotation

            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.GetRISReportInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientID=" + strPatientID);
            LogUtil.DebugLog("PatientName=" + strPatientName);
            LogUtil.DebugLog("AccessionNumber=" + strAccessionNumber);
            LogUtil.DebugLog("Modality=" + strModality);
            LogUtil.DebugLog("ReportID=" + strReportID);
            LogUtil.DebugLog("ReportStatus=" + strReportStatus);

            bool bReturn = true;
            DataSet dsRISReportInfo = null;
            DataSet dsRISReportInfoItem = null;
            DataTable dtRISReportInfoItem = null;
            CExamInfo cei = new CExamInfo();
            string strPDFReportPath = "";
            string[] strReportFileNameList = null;
            string strSQL = "";
            string strOutputInfo = "";
            string strReportURL = "";

            try
            {
                FunctionInitializ();

                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForGetRISReportInfo;

                //1 Call GetRISReportInfo();
                LogUtil.DebugLog("Call DAOMSSQLRIS.GetRISReportInfo(), Input Parameter AS Follows:");
                LogUtil.DebugLog("SQL = " + strSQL);
                LogUtil.DebugLog("PatientID=" + strPatientID);
                LogUtil.DebugLog("PatientName=" + strPatientName);
                LogUtil.DebugLog("AccessionNumber=" + strAccessionNumber);
                LogUtil.DebugLog("Modality=" + strModality);
                LogUtil.DebugLog("ReportID=" + strReportID);
                LogUtil.DebugLog("ReportStatus=" + strReportStatus);

                dsRISReportInfo = m_DAOMSSQLRIS.GetRISReportInfo(strSQL,
                    strPatientID,
                    strPatientName,
                    strAccessionNumber,
                    strModality,
                    strReportID,
                    strReportStatus,
                    out strOutputInfo,
                    out strReportURL);

                LogUtil.DebugLog("DAOMSSQLRIS.GetRISReportInfo(), Output Parameter AS Follows:");
                LogUtil.DebugLog("OutputInfo = " + strOutputInfo);

                if (null == dsRISReportInfo || 0 >= dsRISReportInfo.Tables[0].Rows.Count)
                {
                    LogUtil.DebugLog("FunctionForEI.GetRISReportInfo() Return = null");
                }
                else
                {
                    cei.CExamInfoClear();
                    cei.strPatientID = dsRISReportInfo.Tables[0].Rows[0]["tRegPatient__PatientID"].ToString();
                    cei.strNameCN = dsRISReportInfo.Tables[0].Rows[0]["tRegPatient__LocalName"].ToString();
                    cei.strAccessionNumber = dsRISReportInfo.Tables[0].Rows[0]["tRegOrder__AccNo"].ToString();
                    cei.strStudyInstanceUID = dsRISReportInfo.Tables[0].Rows[0]["tRegOrder__AccNo"].ToString();
                    //2 CreatePDF();
                    if (bReturn)
                    {
                        foreach (DataRow drRISReportInfo in dsRISReportInfo.Tables[0].Rows)
                        {
                            strPDFReportPath = m_Config_WSProxy.M_PDFPhysicPath + "\\" + drRISReportInfo["tReport__ReportGuid"].ToString() + ".pdf";

                            if (0>cei.strPDFReportURL.IndexOf(strPDFReportPath))
                            {
                                LogUtil.DebugLog("Call Function.CreatePDF().");

                                if (null != dsRISReportInfoItem)
                                {
                                    dsRISReportInfoItem.Dispose();
                                    dsRISReportInfoItem = null;
                                }

                                if (null != dtRISReportInfoItem)
                                {
                                    dtRISReportInfoItem.Dispose();
                                    dtRISReportInfoItem = null;
                                }

                                dtRISReportInfoItem = dsRISReportInfo.Tables[0].Clone();
                                //dtRISReportInfoItem.Rows.Add(drRISReportInfo.ItemArray);
                                dtRISReportInfoItem.ImportRow(drRISReportInfo);

                                dsRISReportInfoItem = new DataSet();
                                dsRISReportInfoItem.Tables.Add(dtRISReportInfoItem);

                                bReturn = CreatePDF(dsRISReportInfoItem, strPDFReportPath);
                                LogUtil.DebugLog("Function.CreatePDF() Return = " + bReturn.ToString());

                                if (cei.strPDFReportURL.Length > 0)
                                {
                                    cei.strPDFReportURL = cei.strPDFReportURL + "," + strPDFReportPath;
                                }
                                else
                                {
                                    cei.strPDFReportURL = strPDFReportPath;
                                }
                            }
                        }
                        strReportFileNameList = cei.strPDFReportURL.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        cei.iReportStatus = 2;
                    }

                    //3 Call Function.NotifyReportInfo() By CExamInfo;
                    if (bReturn)
                    {
                        LogUtil.DebugLog("Call Function.NotifyReportInfo().");

                        bReturn = NotifyReportInfo(cei.strNameCN, cei.strPatientID, cei.strAccessionNumber, cei.strStudyInstanceUID, cei.iReportStatus, strReportFileNameList);

                        LogUtil.DebugLog("Function.NotifyReportInfo() Return = " + bReturn.ToString());

                        cei.iPDFFlag = 1;
                        cei.iNotifyReportFlag = 1;
                    }

                    //4 Call Function.SetPSExamInfo() By CExamInfo.
                    if (bReturn)
                    {
                        LogUtil.DebugLog("Call Function.SetPSExamInfo().");

                        bReturn = SetPSExamInfo(cei);

                        LogUtil.DebugLog("Function.SetPSExamInfo() Return = " + bReturn.ToString());
                    }

                    //5 Call SetRISReportInfoExGCRIS() From CExamInfo To RIS.
                    if (bReturn)
                    {
                        LogUtil.DebugLog("Call FunctionForPDF.SetRISReportInfo().");

                        bReturn = SetRISReportInfoExGCRIS(cei.strPatientID, cei.strAccessionNumber, strReportID, cei.strPDFReportURL);

                        LogUtil.DebugLog("FunctionForPDF.SetRISReportInfo() Return = " + bReturn.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                bReturn = false;

                LogUtil.ErrorLog("FunctionForEI.GetRISReportInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != dsRISReportInfo)
                {
                    dsRISReportInfo.Dispose();
                    dsRISReportInfo = null;
                }

                if (null != dsRISReportInfoItem)
                {
                    dsRISReportInfoItem.Dispose();
                    dsRISReportInfoItem = null;
                }

                if (null != dtRISReportInfoItem)
                {
                    dtRISReportInfoItem.Dispose();
                    dtRISReportInfoItem = null;
                }

                LogUtil.DebugLog("FunctionForEI.GetRISReportInfo() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit FunctionForEI.GetRISReportInfo().");
            }

            return bReturn;
        }

        private bool SetRISReportInfoExGCRIS(string strPatientID, string strAccessionNumber,
            string strReportID, string strPDFReportPath)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.SetRISReportInfoExGCRIS(), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientID = " + strPatientID.ToString());
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber.ToString());
            LogUtil.DebugLog("ReportID = " + strReportID);
            LogUtil.DebugLog("PDFReportPath = " + strPDFReportPath);

            bool bReturn = true;
            string strSQL = "";
            string strOutputInfo = "";

            try
            {
                FunctionInitializ();

                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForSetRISReportInfo;

                LogUtil.DebugLog("Call DAOMSSQLRIS.SetRISReportInfo(), Input Parameter AS Follows:");
                LogUtil.DebugLog("SQL = " + strSQL);
                LogUtil.DebugLog("PatientID = " + strPatientID.ToString());
                LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber.ToString());
                LogUtil.DebugLog("ReportID = " + strReportID.ToString());
                LogUtil.DebugLog("PDFReportPath = " + strPDFReportPath.ToString());

                m_DAOMSSQLRIS.SetRISReportInfo(strSQL, strPatientID, strAccessionNumber, strReportID, strPDFReportPath, out strOutputInfo);

                LogUtil.DebugLog("DAOMSSQLRIS.SetRISReportInfo(), Output Parameter AS Follows:");
                LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
            }
            catch (Exception ex)
            {
                bReturn = false;

                LogUtil.ErrorLog("FunctionForEI.SetRISReportInfoExGCRIS() Error Message = " + ex.ToString());
            }
            finally
            {
                FunctionDispose();

                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                LogUtil.DebugLog("FunctionForEI.SetRISReportInfoExGCRIS() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit FunctionForEI.SetRISReportInfoExGCRIS().");
            }

            return bReturn;
        }

        public bool NotifyReportInfo()
        {
            #region annotation

            //1 Call GetPSReportInfo();
            //2 Call GetRISReportInfo() By PatientID & strAccessionNumber;

            #endregion annotation

            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.NotifyReportInfo().");

            bool bReturn = true;
            DataSet dsReportInfo = null;
            CExamInfo cei = new CExamInfo();

            try
            {
                //1 Call GetPSReportInfo();
                LogUtil.DebugLog("Call Function.GetPSReportInfo().");

                if (null != dsReportInfo)
                {
                    dsReportInfo.Dispose();
                    dsReportInfo = null;
                }
                dsReportInfo = GetPSReportInfo();

                if (null == dsReportInfo)
                {
                    LogUtil.DebugLog("No Report need to Notify.");
                    LogUtil.DebugLog("Function.GetPSReportInfo() Return = null");
                }
                else
                {
                    LogUtil.DebugLog("Function.GetPSReportInfo() Return = " + dsReportInfo.ToString());

                    foreach (DataRow drReportInfo in dsReportInfo.Tables[0].Rows)
                    {
                        cei.CExamInfoClear();
                        cei.strPatientID = drReportInfo["PatientID"].ToString().Trim();
                        cei.strAccessionNumber = drReportInfo["AccessionNumber"].ToString().Trim();

                        //2 Call GetRISReportInfo() By PatientID & strAccessionNumber;
                        LogUtil.DebugLog("Call FunctionForEI.GetRISReportInfo().");
                        if (0 == m_Config_WSProxy.M_iGetReportType)
                        {
                            bReturn = GetRISReportInfo(cei.strPatientID, cei.strNameCN, cei.strAccessionNumber, "", "", "");
                        }
                        else if (1 == m_Config_WSProxy.M_iGetReportType)
                        {
                            bReturn = GetRISReportInfoExGCRIS(cei.strPatientID, cei.strNameCN, cei.strAccessionNumber, "", "", "");
                        }
                        else if (2 == m_Config_WSProxy.M_iGetReportType)
                            bReturn = GetRISReportInfoExWS(cei.strPatientID, cei.strNameCN, cei.strAccessionNumber, "", "", "");

                        LogUtil.DebugLog("FunctionForEI.GetRISReportInfo() Return = " + bReturn.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                bReturn = false;

                LogUtil.ErrorLog("FunctionForEI.NotifyReportInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != dsReportInfo)
                {
                    dsReportInfo.Dispose();
                    dsReportInfo = null;
                }

                cei.CExamInfoClear();

                LogUtil.DebugLog("FunctionForEI.NotifyReportInfo() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit FunctionForEI.NotifyReportInfo().");
            }

            return bReturn;
        }

        public bool GetPSPatientInfo(string strTerminalInfo, string strCardType, string strCardNumber, string strReturnType,
            out string strReturnValue, out string strPatientName, out string strMessage)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.GetPSPatientInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("TerminalInfo = " + strTerminalInfo);
            LogUtil.DebugLog("CardType = " + strCardType);
            LogUtil.DebugLog("CardNumber = " + strCardNumber);
            LogUtil.DebugLog("ReturnType = " + strReturnType);

            bool bReturn = false;
            bool blnGetReport = false;
            DataSet dsPSPatientInfo = null;
            DataSet dsPSPatientInfoEx = null;
            string strSQL = "";
            string strOutputInfo = "";

            strReturnValue = "";
            strPatientName = "";
            strMessage = "连接服务器失败，请联系管理员！";
            string strAllowPrint = string.Empty;

            try
            {
                if (m_Config_WSProxy.M_strSwingReportBefore == "1")
                {
                    GetUnPrintedReport(strTerminalInfo, strCardType, strCardNumber);
                }

                FunctionInitializ();
                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForGetPSPatientInfo;

                LogUtil.DebugLog("Call DAOMSSQLWSProxy.GetPSPatientInfo(), Input Parameter AS Follows:");
                LogUtil.DebugLog("SQL = " + strSQL);
                LogUtil.DebugLog("TerminalInfo = " + strTerminalInfo);
                LogUtil.DebugLog("CardType = " + strCardType);
                LogUtil.DebugLog("CardNumber = " + strCardNumber);
                LogUtil.DebugLog("ReturnType = " + strReturnType);

                dsPSPatientInfo = m_DAOMSSQLWSProxy.GetPSPatientInfo(strSQL,
                    strTerminalInfo,
                    strCardType,
                    strCardNumber,
                    strReturnType,
                    out strOutputInfo);

                LogUtil.DebugLog("DAOMSSQLWSProxy.GetPSPatientInfo(), Output Parameter AS Follows:");
                LogUtil.DebugLog("OutputInfo = " + strOutputInfo);

                if (null != dsPSPatientInfo)
                {
                    LogUtil.DebugLog("Return RecordCount = " + dsPSPatientInfo.Tables[0].Rows.Count.ToString());
                    if (dsPSPatientInfo.Tables[0].Rows.Count > 0)
                    {
                        strReturnValue = dsPSPatientInfo.Tables[0].Rows[0]["ReturnValue"].ToString();
                        strPatientName = dsPSPatientInfo.Tables[0].Rows[0]["NameCN"].ToString();
                        strMessage = dsPSPatientInfo.Tables[0].Rows[0]["Message"].ToString();
                        strAllowPrint = dsPSPatientInfo.Tables[0].Rows[0]["AllowPrint"].ToString();
                        LogUtil.DebugLog("Return Value = " + strReturnValue);
                        LogUtil.DebugLog("PatientName = " + strPatientName);
                        LogUtil.DebugLog("Message = " + strMessage);
                        LogUtil.DebugLog("AllowPrint = " + strAllowPrint);

                        if (strAllowPrint.Trim().Equals("1"))
                        {
                            bReturn = true;
                        }

                        if (m_Config_WSProxy.M_strSwingReportBefore == "0"  && m_Config_WSProxy.M_strSwingReport == "1")
                        {
                            LogUtil.DebugLog("Call FunctionForEI.GetRISReportInfo() After Swing.");

                            foreach (DataRow drRowNum in dsPSPatientInfo.Tables[0].Rows)
                            {
                                string strReportStored = drRowNum["ReportStoredFlag"].ToString().Trim();
                                string strPatientID = drRowNum["PatientID"].ToString().Trim();
                                string strAccessionNumber = drRowNum["AccessionNumber"].ToString().Trim();
                                LogUtil.DebugLog("ReportStored = " + strReportStored);
                                LogUtil.DebugLog("PatientID = " + strPatientID);
                                LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);

                                //下载报告
                                if (strPatientID.Trim() != "" && strAccessionNumber != "")
                                {
                                    if (0 == m_Config_WSProxy.M_iGetReportType)
                                    {
                                         if (GetRISReportInfo(strPatientID, strPatientName, strAccessionNumber, "", "", "") == true && strReportStored != "9")
                                         {
                                             blnGetReport = true;
                                         }
                                    }
                                    else if (1 == m_Config_WSProxy.M_iGetReportType)
                                    {
                                        if (GetRISReportInfoExGCRIS(strPatientID, "", strAccessionNumber, "", "", "") == true && strReportStored != "9")
                                        {
                                            blnGetReport = true;
                                        }
                                    }
                                    else if (2 == m_Config_WSProxy.M_iGetReportType)
                                    {
                                        if (GetRISReportInfoExWS(strPatientID, "", strAccessionNumber, "", "", "") == true && strReportStored != "9")
                                        {
                                            blnGetReport = true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    LogUtil.ErrorLog("FunctionForEI.GetPSPatientInfo() Return null.");
                }

                if (blnGetReport == true)
                {
                    LogUtil.DebugLog(" ");
                    LogUtil.DebugLog("Call DAOMSSQLWSProxy.GetPSPatientInfo() After Downloading New Report, Input Parameter AS Follows:");
                    LogUtil.DebugLog(" ");

                    FunctionInitializ();
                    LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                    LogUtil.DebugLog(" ");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("TerminalInfo = " + strTerminalInfo);
                    LogUtil.DebugLog("CardType = " + strCardType);
                    LogUtil.DebugLog("CardNumber = " + strCardNumber);
                    LogUtil.DebugLog("ReturnType = " + strReturnType);

                    dsPSPatientInfoEx = m_DAOMSSQLWSProxy.GetPSPatientInfo(strSQL,
                        strTerminalInfo,
                        strCardType,
                        strCardNumber,
                        strReturnType,
                        out strOutputInfo);

                    LogUtil.DebugLog("DAOMSSQLWSProxy.GetPSPatientInfo() After Downloading New Report, Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);

                    if (null != dsPSPatientInfoEx)
                    {
                        LogUtil.DebugLog("Return RecordCount After Downloading New Report = " + dsPSPatientInfoEx.Tables[0].Rows.Count.ToString());
                        if (dsPSPatientInfoEx.Tables[0].Rows.Count > 0)
                        {
                            strReturnValue = dsPSPatientInfoEx.Tables[0].Rows[0]["ReturnValue"].ToString();
                            strPatientName = dsPSPatientInfoEx.Tables[0].Rows[0]["NameCN"].ToString();
                            strMessage = dsPSPatientInfoEx.Tables[0].Rows[0]["Message"].ToString();
                            strAllowPrint = dsPSPatientInfoEx.Tables[0].Rows[0]["AllowPrint"].ToString();
                            LogUtil.DebugLog("Return Value = " + strReturnValue);
                            LogUtil.DebugLog("PatientName = " + strPatientName);
                            LogUtil.DebugLog("Message = " + strMessage);
                            LogUtil.DebugLog("AllowPrint = " + strAllowPrint);

                            if (strAllowPrint.Trim().Equals("1"))
                            {
                                bReturn = true;
                            }
                        }
                    }
                    else
                    {
                        LogUtil.ErrorLog("FunctionForEI.GetPSPatientInfo() Return Null After Downloading New Report.");
                    }
                }
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("FunctionForEI.GetPSPatientInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != dsPSPatientInfo)
                {
                    dsPSPatientInfo.Dispose();
                    dsPSPatientInfo = null;
                }

                if (null != dsPSPatientInfoEx)
                {
                    dsPSPatientInfoEx.Dispose();
                    dsPSPatientInfoEx = null;
                }

                FunctionDispose();
                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");

                LogUtil.DebugLog("FunctionForEI.GetPSPatientInfo(), Output Parameter AS Follows:");
                LogUtil.DebugLog("ReturnValue = " + strReturnValue);
                LogUtil.DebugLog("PatientName = " + strPatientName);
                LogUtil.DebugLog("Message = " + strMessage);
                LogUtil.DebugLog("FunctionForEI.GetPSPatientInfo() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit FunctionForEI.GetPSPatientInfo().");
            }

            return bReturn;
        }

        private void GetUnPrintedReport(string strTerminalInfo, string strCardType, string strCardNumber)
        {
            string strSQL = "";
            string strOutputInfo = "";
            CExamInfo cei = new CExamInfo();
            DataSet dsUnPrintedStudy = null;
            try
            {
                FunctionInitializ();
                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");
                
                //下载RIS中未打印的报告（含图像未入库的）
                strSQL = m_Config_WSProxy.M_SQLForGetUnPrintedStudy;

                LogUtil.DebugLog("Call FunctionForEI.GetUnPrintedStudy(), Input Parameter AS Follows:");
                LogUtil.DebugLog("SQL = " + strSQL);
                LogUtil.DebugLog("TerminalInfo = " + strTerminalInfo);
                LogUtil.DebugLog("CardType = " + strCardType);
                LogUtil.DebugLog("CardNumber = " + strCardNumber);

                strSQL = m_Config_WSProxy.M_SQLForGetUnPrintedStudy;

                dsUnPrintedStudy = m_DAOMSSQLWSProxy.GetUnPrintedStudy(strSQL,
                    strTerminalInfo,
                    strCardType,
                    strCardNumber,
                    out strOutputInfo);

                LogUtil.DebugLog("DAOMSSQLWSProxy.GetUnPrintedStudy(), Output Parameter AS Follows:");
                LogUtil.DebugLog("OutputInfo = " + strOutputInfo);

                if (null != dsUnPrintedStudy)
                {
                    LogUtil.DebugLog("UnPrintedStudy Return RecordCount = " + dsUnPrintedStudy.Tables[0].Rows.Count.ToString());
                    if (dsUnPrintedStudy.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow drReturn in dsUnPrintedStudy.Tables[0].Rows)
                        {
                            cei.CExamInfoClear();
                            if (drReturn.Table.Columns.Contains("PatientID"))
                                cei.strPatientID = drReturn["PatientID"].ToString();
                            else
                                cei.strPatientID = "";
                            if (drReturn.Table.Columns.Contains("AccessionNumber"))
                                cei.strAccessionNumber = drReturn["AccessionNumber"].ToString();
                            else
                                cei.strAccessionNumber = "";
                            if (drReturn.Table.Columns.Contains("NameEN"))
                                cei.strNameEN = drReturn["NameEN"].ToString();
                            else
                                cei.strNameEN = "";
                            if (drReturn.Table.Columns.Contains("NameCN"))
                                cei.strNameCN = drReturn["NameCN"].ToString();
                            else
                                cei.strNameCN = "";
                            if (drReturn.Table.Columns.Contains("Gender"))
                                cei.strGender = drReturn["Gender"].ToString();
                            else
                                cei.strGender = "";
                            if (drReturn.Table.Columns.Contains("Birthday"))
                                cei.strBirthday = drReturn["Birthday"].ToString();
                            else
                                cei.strBirthday = "";
                            if (drReturn.Table.Columns.Contains("Modality"))
                                cei.strModality = drReturn["Modality"].ToString();
                            else
                                cei.strModality = "";
                            if (drReturn.Table.Columns.Contains("ModalityName"))
                                cei.strModalityName = drReturn["ModalityName"].ToString();
                            else
                                cei.strModalityName = "";
                            if (drReturn.Table.Columns.Contains("PatientType"))
                                cei.strPatientType = drReturn["PatientType"].ToString();
                            else
                                cei.strPatientType = "";
                            if (drReturn.Table.Columns.Contains("VisitID"))
                                cei.strVisitID = drReturn["VisitID"].ToString();
                            else
                                cei.strVisitID = "";
                            if (drReturn.Table.Columns.Contains("RequestID"))
                                cei.strRequestID = drReturn["RequestID"].ToString();
                            else
                                cei.strRequestID = "";
                            if (drReturn.Table.Columns.Contains("RequestDepartment"))
                                cei.strRequestDepartment = drReturn["RequestDepartment"].ToString();
                            else
                                cei.strRequestDepartment = "";
                            if (drReturn.Table.Columns.Contains("RequestDT"))
                                cei.strRequestDT = drReturn["RequestDT"].ToString();
                            else
                                cei.strRequestDT = "";
                            if (drReturn.Table.Columns.Contains("RegisterDT"))
                                cei.strRegisterDT = drReturn["RegisterDT"].ToString();
                            else
                                cei.strRegisterDT = "";
                            if (drReturn.Table.Columns.Contains("ExamDT"))
                                cei.strExamDT = drReturn["ExamDT"].ToString();
                            else
                                cei.strExamDT = "";

                            if (drReturn.Table.Columns.Contains("SubmitDT"))
                                cei.strSubmitDT = drReturn["SubmitDT"].ToString();
                            else
                                cei.strSubmitDT = "";
                            if (drReturn.Table.Columns.Contains("ApproveDT"))
                                cei.strApproveDT = drReturn["ApproveDT"].ToString();
                            else
                                cei.strApproveDT = "";
                            if (drReturn.Table.Columns.Contains("PDFReportURL"))
                                cei.strPDFReportURL = drReturn["PDFReportURL"].ToString();
                            else
                                cei.strPDFReportURL = "";
                            if (drReturn.Table.Columns.Contains("StudyStatus"))
                                cei.strStudyStatus = drReturn["StudyStatus"].ToString();
                            else
                                cei.strStudyStatus = "";

                            if (drReturn.Table.Columns.Contains("OutHospitalNo"))
                                cei.strOutHospitalNo = drReturn["OutHospitalNo"].ToString();
                            else
                                cei.strOutHospitalNo = "";
                            if (drReturn.Table.Columns.Contains("InHospitalNo"))
                                cei.strInHospitalNo = drReturn["InHospitalNo"].ToString();
                            else
                                cei.strInHospitalNo = "";
                            if (drReturn.Table.Columns.Contains("PhysicalNumber"))
                                cei.strPhusicalNumber = drReturn["PhysicalNumber"].ToString();
                            else
                                cei.strPhusicalNumber = "";
                            if (drReturn.Table.Columns.Contains("ExamName"))
                                cei.strExamName = drReturn["ExamName"].ToString();
                            else
                                cei.strExamName = "";
                            if (drReturn.Table.Columns.Contains("ExamBodyPart"))
                                cei.strExamBodyPart = drReturn["ExamBodyPart"].ToString();
                            else
                                cei.strExamBodyPart = "";

                            if (drReturn.Table.Columns.Contains("Optional0"))
                                cei.strOptional0 = drReturn["Optional0"].ToString();
                            else
                                cei.strOptional0 = "";
                            if (drReturn.Table.Columns.Contains("Optional1"))
                                cei.strOptional1 = drReturn["Optional1"].ToString();
                            else
                                cei.strOptional1 = "";
                            if (drReturn.Table.Columns.Contains("Optional2"))
                                cei.strOptional2 = drReturn["Optional2"].ToString();
                            else
                                cei.strOptional2 = "";
                            if (drReturn.Table.Columns.Contains("Optional3"))
                                cei.strOptional3 = drReturn["Optional3"].ToString();
                            else
                                cei.strOptional3 = "";
                            if (drReturn.Table.Columns.Contains("Optional4"))
                                cei.strOptional4 = drReturn["Optional4"].ToString();
                            else
                                cei.strOptional4 = "";
                            if (drReturn.Table.Columns.Contains("Optional5"))
                                cei.strOptional5 = drReturn["Optional5"].ToString();
                            else
                                cei.strOptional5 = "";
                            if (drReturn.Table.Columns.Contains("Optional6"))
                                cei.strOptional6 = drReturn["Optional6"].ToString();
                            else
                                cei.strOptional6 = "";
                            if (drReturn.Table.Columns.Contains("Optional7"))
                                cei.strOptional7 = drReturn["Optional7"].ToString();
                            else
                                cei.strOptional7 = "";
                            if (drReturn.Table.Columns.Contains("Optional8"))
                                cei.strOptional8 = drReturn["Optional8"].ToString();
                            else
                                cei.strOptional8 = "";
                            if (drReturn.Table.Columns.Contains("Optional9"))
                                cei.strOptional9 = drReturn["Optional9"].ToString();
                            else
                                cei.strOptional9 = "";

                            GetRISReportInfo(cei);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("FunctionForEI.GetUnPrintedStudy() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != dsUnPrintedStudy)
                {
                    dsUnPrintedStudy.Dispose();
                    dsUnPrintedStudy = null;
                }

                FunctionDispose();
                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                LogUtil.DebugLog("Exit FunctionForEI.GetUnPrintedStudy().");
            }
        }

        private void GetRISReportInfo(CExamInfo cei)
        {
            cei.strPDFReportURL = string.Empty;
            string strPatientID = cei.strPatientID;
            string strPatientName = cei.strNameCN;
            string strAccessionNumber = cei.strAccessionNumber;
            string strModality = cei.strModality;
            string strReportID = cei.strStudyInstanceUID;
            string strReportStatus = cei.iReportStatus.ToString();

            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter FunctionForEI.GetRISReportInfo(CExamInfo cei), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientID=" + strPatientID);
            LogUtil.DebugLog("PatientName=" + strPatientName);
            LogUtil.DebugLog("AccessionNumber=" + strAccessionNumber);
            LogUtil.DebugLog("Modality=" + strModality);
            LogUtil.DebugLog("ReportID=" + strReportID);
            LogUtil.DebugLog("ReportStatus=" + strReportStatus);

            string strSQL = "";
            string strOutputInfo = "";
            string strReportURL = "";
            bool bReturn = false;
            DataSet dsRISReportInfo = null;

            try
            {
                FunctionInitializ();

                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForGetRISReportInfo;

                //1 Call GetRISReportInfo();
                if ("MYSQL" == m_Config_WSProxy.M_RISDBType.Trim().ToUpper())
                {
                    LogUtil.DebugLog("Call DAOMySQLRIS.GetRISReportInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("PatientID=" + strPatientID);
                    LogUtil.DebugLog("PatientName=" + strPatientName);
                    LogUtil.DebugLog("AccessionNumber=" + strAccessionNumber);
                    LogUtil.DebugLog("Modality=" + strModality);
                    LogUtil.DebugLog("ReportID=" + strReportID);
                    LogUtil.DebugLog("ReportStatus=" + strReportStatus);

                    dsRISReportInfo = m_DAOMySQLRIS.GetRISReportInfo(strSQL,
                        strPatientID,
                        strPatientName,
                        strAccessionNumber,
                        strModality,
                        strReportID,
                        strReportStatus,
                        out strOutputInfo,
                        out strReportURL);

                    LogUtil.DebugLog("DAOMySQLRIS.GetRISReportInfo(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                }
                else if ("ORACLE" == m_Config_WSProxy.M_RISDBType.Trim().ToUpper())
                {
                    LogUtil.DebugLog("Call DAOORACLERIS.GetRISReportInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("PatientID=" + strPatientID);
                    LogUtil.DebugLog("PatientName=" + strPatientName);
                    LogUtil.DebugLog("AccessionNumber=" + strAccessionNumber);
                    LogUtil.DebugLog("Modality=" + strModality);
                    LogUtil.DebugLog("ReportID=" + strReportID);
                    LogUtil.DebugLog("ReportStatus=" + strReportStatus);

                    dsRISReportInfo = m_DAOORACLERIS.GetRISReportInfo(strSQL,
                        strPatientID,
                        strPatientName,
                        strAccessionNumber,
                        strModality,
                        strReportID,
                        strReportStatus,
                        out strOutputInfo,
                        out strReportURL);

                    LogUtil.DebugLog("DAOORACLERIS.GetRISReportInfo(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                }
                else
                {
                    LogUtil.DebugLog("Call DAOMSSQLRIS.GetRISReportInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("SQL = " + strSQL);
                    LogUtil.DebugLog("PatientID=" + strPatientID);
                    LogUtil.DebugLog("PatientName=" + strPatientName);
                    LogUtil.DebugLog("AccessionNumber=" + strAccessionNumber);
                    LogUtil.DebugLog("Modality=" + strModality);
                    LogUtil.DebugLog("ReportID=" + strReportID);
                    LogUtil.DebugLog("ReportStatus=" + strReportStatus);

                    dsRISReportInfo = m_DAOMSSQLRIS.GetRISReportInfo(strSQL,
                                strPatientID,
                                strPatientName,
                                strAccessionNumber,
                                strModality,
                                strReportID,
                                strReportStatus,
                                out strOutputInfo,
                                out strReportURL);

                    LogUtil.DebugLog("DAOMSSQLRIS.GetRISReportInfo(), Output Parameter AS Follows:");
                    LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                    LogUtil.DebugLog("ReportURL = " + strReportURL);
                }

                if (dsRISReportInfo != null)
                {
                    LogUtil.DebugLog("Start to Download PDF Report ");

                    //PatrintID 转换，RIS PatientID存于T表Optional9中
                    string strPatentID = cei.strOptional9 != "" ? cei.strOptional9 : cei.strPatientID;

                    //2 Call SetRISReportInfo();
                    foreach (DataRow drRISReportInfo in dsRISReportInfo.Tables[0].Rows)
                    {
                        string TempURL = string.Empty;
                        string strAccessionNumberChange = string.Empty;
                        strAccessionNumberChange = drRISReportInfo["AccessionNumber"].ToString();
                        cei.strStudyInstanceUID = dsRISReportInfo.Tables[0].Rows[0]["ReportID"].ToString();
                        if (string.IsNullOrEmpty(cei.strPDFReportURL.Trim()))
                        {
                            cei.strPDFReportURL = drRISReportInfo["PDFReportURL"].ToString();
                            TempURL = drRISReportInfo["PDFReportURL"].ToString();

                            if (m_Config_WSProxy.M_strGetReportFromShareFolder == "1" && !string.IsNullOrEmpty(TempURL.Trim()))
                            {
                                string sourcePath = TempURL;
                                string UserName = dsRISReportInfo.Tables[0].Rows[0]["UserName"].ToString();
                                string Password = dsRISReportInfo.Tables[0].Rows[0]["Password"].ToString();
                                string Server = dsRISReportInfo.Tables[0].Rows[0]["Server"].ToString();
                                string ShareName = dsRISReportInfo.Tables[0].Rows[0]["ShareName"].ToString();

                                string ReportName = cei.strPatientID + "_" + cei.strAccessionNumber + "_" + cei.strStudyInstanceUID + ".pdf";
                                string localPDFFolder = m_Config_WSProxy.M_PDFPhysicPath + @"\" + DateTime.Now.ToString("yyyy-MM-dd");
                                string targetPath = localPDFFolder + @"\" + ReportName;

                                if (!Directory.Exists(localPDFFolder))
                                {
                                    LogUtil.DebugLog(string.Format("Create local folder, {0}.", localPDFFolder));
                                    Directory.CreateDirectory(localPDFFolder);
                                    LogUtil.DebugLog(string.Format("Create local folder success，{0}.", localPDFFolder));
                                }

                                LogUtil.DebugLog(string.Format("Download Report From Share Folder Start.Share Path, {0}；local Path，{1}", sourcePath, targetPath));

                                string error = string.Empty;

                                if (FileCopy(sourcePath, targetPath, Server, ShareName, UserName, Password, out error) == 0)
                                {
                                    TempURL = targetPath;
                                    LogUtil.DebugLog(string.Format("Download Report From Share Folder Success.Share Path, {0}；local Path，{1}", sourcePath, targetPath));
                                }
                                else
                                {
                                    LogUtil.ErrorLog(string.Format("Download Report From Share Folder Fail.Share Path, {0}；local Path，{1}", sourcePath, targetPath));
                                    LogUtil.ErrorLog(string.Format("Download Report From Share Folder Fail.Server, {0}；ShareName，{1}；UserName，{2}；Password，{3}", Server, ShareName, UserName, Password));
                                    LogUtil.ErrorLog("Download Report From Share Folder Fail.Server," + error);
                                }
                                LogUtil.DebugLog(string.Format("Download Report From Share Folder Start.Share Path, {0}；local Path，{1}", sourcePath, targetPath));
                            }
                        }
                        else
                        {
                            cei.strPDFReportURL = cei.strPDFReportURL + "," + "asso://" + strAccessionNumberChange + "/" + strAccessionNumberChange;
                            TempURL = "asso://" + strAccessionNumberChange + "/" + strAccessionNumberChange;
                        }

                        LogUtil.DebugLog("Combine URl =" + cei.strPDFReportURL.ToString());

                        if (!string.IsNullOrEmpty(TempURL.Trim()))
                        {
                            //3 Call Function.NotifyReportInfo() By CExamInfo;
                            LogUtil.DebugLog("Call PS.Function.NotifyReportInfo().");
                            LogUtil.DebugLog("PatientName = " + cei.strNameCN);
                            LogUtil.DebugLog("PatientID = " + strPatentID);
                            LogUtil.DebugLog("AccessionNumber = " + cei.strAccessionNumber);
                            LogUtil.DebugLog("StudyUID = " + cei.strStudyInstanceUID);
                            LogUtil.DebugLog("Report Status = " + cei.iReportStatus.ToString());
                            LogUtil.DebugLog("Report URl =" + TempURL.ToString());

                            string[] strReportFileNameList = TempURL.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                            cei.iReportStatus = 2; //0:not ready, just update Chinese name; 1:temp report; 2:formal report.

                            bReturn = NotifyReportInfo(cei.strNameCN, strPatentID,
                                    cei.strAccessionNumber, cei.strStudyInstanceUID, cei.iReportStatus, strReportFileNameList);

                            LogUtil.DebugLog("Function.NotifyReportInfo() Return = " + bReturn.ToString());
                        }
                    }

                    if (bReturn)
                    {
                        cei.iPDFFlag = 1;
                        cei.iNotifyReportFlag = 1;
                        LogUtil.DebugLog("Call Function.SetPSExamInfo().");
                        bReturn = SetPSExamInfo(cei);
                        LogUtil.DebugLog("Function.SetPSExamInfo() Return = " + bReturn.ToString());

                        ////GetPatentInfo存储过程已增加自动插入打印模式的功能
                        //SetPrintMode(cei.strAccessionNumber);
                    }

                    LogUtil.DebugLog("Finsh Downloading PDF Report ");
                }
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("PS.Function.GetRISReportInfo(CExamInfo cei) Error Message = " + ex.ToString());
            }
            finally
            {
                cei.CExamInfoClear();
                LogUtil.DebugLog("Exit PS.Function.GetRISReportInfo(CExamInfo cei).");
            }
        }

        private void SetPrintMode(string strAccessionNumber)
        {
            LogUtil.DebugLog("Enter Function.EI.SetPrintMode(), Input Parameter AS Follows:");
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);

            string strSQL = "";
            string strOutputInfo = "";
            int PrintMode;
            try
            {
                FunctionInitializ();
                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForSetPrintMode;

                LogUtil.DebugLog("Call DAOMSSQLWSProxy.SetPrintMode(), Input Parameter AS Follows:");
                LogUtil.DebugLog("SQL = " + strSQL);
                LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);

                m_DAOMSSQLWSProxy.SetPrintMode(strSQL,strAccessionNumber,out PrintMode,out strOutputInfo);

                LogUtil.DebugLog("DAOMSSQLWSProxy.SetPrintMode(), Output Parameter AS Follows:");
                LogUtil.DebugLog("PrintMode = " + PrintMode);
                LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("Function.EI.SetPrintMode() Error Message = " + ex.ToString());
            }
            finally
            {
                FunctionDispose();
                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                LogUtil.DebugLog("Exit Function.EI.SetPrintMode().");
            }
        }

        /// <summary>
        /// 使用net use命令远程连接目标机器，拷贝文件
        /// </summary>
        /// <param name="strSource">源文件</param>
        /// <param name="strTarget">目标文件</param>
        /// <param name="Server">目标ip</param>
        /// <param name="ShareName">远程共享名</param>
        /// <param name="Username">远程登录用户</param>
        /// <param name="Password">远程登录密码</param>
        /// <returns>拷贝成功则返回0</returns>
        private static int FileCopy(string strSource, string strTarget, string Server, string ShareName, string Username, string Password, out string error)
        {
            error = string.Empty;
            Process process = new Process();
            try
            {
                process.StartInfo.FileName = "net.exe";
                process.StartInfo.Arguments = @"use \\" + Server + @"\" + ShareName + " \"" + Password + "\" /user:\"" + Username + "\" ";
                process.StartInfo.CreateNoWindow = true;
                process.StartInfo.UseShellExecute = false;
                process.Start();
                process.WaitForExit();
                File.Copy(strSource, strTarget, true);
                
                process.Close();
            }
            catch (IOException ex)
            {
                error = ex.Message;
                return -1;
            }
            catch (Exception ex)
            {
                error = ex.Message;
                return -1;
            }
            finally
            {
                process.Dispose();
            }
            return 0;
        }
    }
}