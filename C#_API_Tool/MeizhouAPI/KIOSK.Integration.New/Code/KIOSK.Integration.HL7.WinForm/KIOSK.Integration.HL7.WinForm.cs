using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using System.IO;

using KIOSK.Integration.Log;
using KIOSK.Integration.Util;
using KIOSK.Integration.Config;

namespace KIOSK.Integration.HL7.WinForm
{
    public partial class FormHL7Reciew : Form
    {
        Socket HL7Socket;
        Thread ListenThread;
        byte[] recvMessage;
        CExamInfo ExamInfo = new CExamInfo();
        CDataBaseCtrl dbCtrl = null;
        private bool m_bStoped = false;
        private bool m_bPaused = false;
        private Config_HL7InboundService m_Config_InboundService_HL7 = null;
        private ConfigXML_HL7InboundService m_ConfigXML_InboundService_HL7 = null;

        private void LoadConfigAndInitializLogUtil()
        {
            // Get filename of config.
            string strCurrentPath = AppDomain.CurrentDomain.BaseDirectory;
            string strCurrentPathParent = strCurrentPath.Substring(0, strCurrentPath.LastIndexOf("\\", strCurrentPath.Length - 2) + 1);
            string strConfigFileName = Path.Combine(strCurrentPath, KIOSKIntegrationConst.KIOSK_INTEGRATION_CONFIG_FILE);

            if (!File.Exists(strConfigFileName))
            {
                strConfigFileName = Path.Combine(strCurrentPathParent, KIOSKIntegrationConst.KIOSK_INTEGRATION_CONFIG_FILE);
            }

            if (!File.Exists(strConfigFileName))
            {
                strConfigFileName = Path.Combine(strCurrentPathParent, "KIOSK.Integration.Bin");
                strConfigFileName = Path.Combine(strConfigFileName, KIOSKIntegrationConst.KIOSK_INTEGRATION_CONFIG_FILE);
            }

            // Load config.
            m_Config_InboundService_HL7 = new Config_HL7InboundService();
            m_ConfigXML_InboundService_HL7 = new ConfigXML_HL7InboundService();
            m_ConfigXML_InboundService_HL7.M_ConfigFileName = strConfigFileName;
            m_ConfigXML_InboundService_HL7.M_Config = m_Config_InboundService_HL7;
            m_ConfigXML_InboundService_HL7.LoadConfig();


            //
            if (null == dbCtrl)
            {
                dbCtrl = new CDataBaseCtrl();
            }
            dbCtrl.M_DBAddress = m_Config_InboundService_HL7.M_DBAddress;
            dbCtrl.M_DBName = m_Config_InboundService_HL7.M_DBName;
            dbCtrl.M_DBUser = m_Config_InboundService_HL7.M_DBUser;
            dbCtrl.M_DBPassword = m_Config_InboundService_HL7.M_DBPassword;
            // LogUtil init.
            string strLogFilePath = "";
            if (".." == m_Config_InboundService_HL7.M_LogFilePath.Trim().Substring(0, 2))
            {
                strLogFilePath = Path.Combine(strCurrentPathParent,
                    m_Config_InboundService_HL7.M_LogFilePath.Trim().Substring(3, m_Config_InboundService_HL7.M_LogFilePath.Trim().Length - 3));
            }
            else
            {
                strLogFilePath = m_Config_InboundService_HL7.M_LogFilePath.Trim();
            }
            LogUtil.Initialize(strLogFilePath, m_Config_InboundService_HL7.M_LogLevel, m_Config_InboundService_HL7.M_LogFileKeepTime);

            LogUtil.DebugLog("----------KIOSK.Integration.HL7InboundService init starting.--------------");
            LogUtil.DebugLog("Load config and LogUtil initialize success.");
            LogUtil.DebugLog("KIOSK.Integration.Config path:" + strConfigFileName);

            LogUtil.DebugLog("DBTyple = " + m_Config_InboundService_HL7.M_DBTyple);
            LogUtil.DebugLog("DBAddress = " + m_Config_InboundService_HL7.M_DBAddress);
            LogUtil.DebugLog("DBUserName = " + m_Config_InboundService_HL7.M_DBUser);
            LogUtil.DebugLog("DBName = " + m_Config_InboundService_HL7.M_DBName);
            LogUtil.DebugLog("ExecSQL = " + m_Config_InboundService_HL7.M_ExecSQL);

            LogUtil.DebugLog("LogFilePath=" + m_Config_InboundService_HL7.M_LogFilePath);
            LogUtil.DebugLog("LogLevel=" + m_Config_InboundService_HL7.M_LogLevel);
            LogUtil.DebugLog("LogFileKeepTime=" + m_Config_InboundService_HL7.M_LogFileKeepTime.ToString());

            LogUtil.DebugLog("HL7ServiceAddress=" + m_Config_InboundService_HL7.M_HL7IpAddress);
            LogUtil.DebugLog("HL7ServicePort=" + m_Config_InboundService_HL7.M_HL7Port.ToString());
            LogUtil.DebugLog("ListenPort=" + m_Config_InboundService_HL7.M_ListenPort);
            LogUtil.DebugLog("Protocol=" + m_Config_InboundService_HL7.M_Protocol);

            LogUtil.DebugLog("----------KIOSK.Integration.HL7InboundService init finished.---------------");
        }

        public static IPAddress GetServiceIP()
        {
            IPHostEntry ieh = Dns.GetHostByName(Dns.GetHostName());
            return ieh.AddressList[0];
        }

        private void InitSocket()
        {
            IPAddress strAddr = GetServiceIP();
            IPEndPoint iep = new IPEndPoint(strAddr, m_Config_InboundService_HL7.M_ListenPort);
            if (m_Config_InboundService_HL7.M_Protocol == "TCP")
                HL7Socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            else if (m_Config_InboundService_HL7.M_Protocol == "UDP")
                HL7Socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Udp);

            LogUtil.DebugLog("Local IPAddress = " + strAddr.ToString());
            LogUtil.DebugLog("Protocol = " + m_Config_InboundService_HL7.M_Protocol);

            recvMessage = new byte[4096];
            HL7Socket.Bind(iep);            // 绑定
            HL7Socket.Listen(2048);         // 监听
            LogUtil.DebugLog("Start Listen,wait for Client.");
        }

        private void BeginListen()
        {
            int iRecv = 0;
            while (true)
            {   
                //iRecv = 1024;
                Socket newSocket = HL7Socket.Accept();
                iRecv = newSocket.Receive(recvMessage);
                byte[] bs = null;
                LogUtil.DebugLog("Recieve Message,Message length = " + iRecv.ToString());
                if (iRecv > 0)
                {
                    string strRecv = System.Text.Encoding.UTF8.GetString(recvMessage);
                    //string strRecv = "MSH|^~|MEDAVIS|JSPH-RIS-OF|READ HIS|JSPH|20140630082104||ORM^O01|32032871|P|2.5|||AL|NE||UNICODE UTF-8"
                    //                + "\nPID|1|974829^^^MEDAVIS^PT|1736345^^^^PI|140629112800L13045|LMR^大家好||19361124|M|||集庆门凤鸣苑14幢202室^^^^^100||86425573|86425573||||||||||||||||N"
                    //                + "\nPV1|||急诊科|||||1^Default^默认|||||||||骆慧||140629112800L13045^^^^VN|||||||||||||||||||||||||20140630|||||||V"
                    //                + "\nORC|SC|10178403|2346873^MEDAVIS|1406300804190079094354|SC||1^once^^20140630082200^20140630082500^R|||165^hejn^何建宁^1234567^^^^^^^^^PN||||548385479"
                    //                + "\nOBR|1|10178403|2346873^MEDAVIS|239120071218000H^螺旋CT全腹部平扫(上腹,中腹,盆腔) 组合^medavis-RIS^lxctqfbps(szp)zh^螺旋CT全腹部平扫(上腹,中腹,盆腔) 组合^MEDAVIS|||20140630082200|20140630082500||||||||||U-ID2579336|HRI_CT31888|||||CT|O||1^once^^20140630082200^20140630082500^R|||WALK||||||20140630082200||||||N|^^^^螺旋CT室（门诊）||||239120071218000H^螺旋CT全腹部平扫(上腹,中腹,盆腔) 组合^medavis-RIS";
                    //string strRecv = "MSH|^~\\&|MEDAVIS|NJ2Y-RIS|Carestream|KIOSK|20150323133934||ORM^O01|162621|P|2.3.1|||AL|NE||UTF-8"
                    // + "\nEVN||20150323132936||||20150323132936"
                    // + "\nPID||15349^^^MEDAVIS|15349^^^MEDAVIS||LGY^liang jia yang||19571006|M|||anhui laian xian lei zhen nian tang cun he zhuang zu 6hao |||||||15349"
                    // + "\nPV1||O||||||^sun yan |||||||||||14470"
                    // + "\nORC|NW|14470^MEDAVIS|14470^MEDAVIS|14470^MEDAVIS|SC||1^once^^20150323132900||||||||||MEDAVIS_RIS^medavis RIS^RIS99"
                    // + "\nOBR|1|14470^MEDAVIS|14470^MEDAVIS|DPCTQFBPSSFXF^quan fubu ping sao ^MEDAVIS||||||||||||||U-ID14751|14470|14751||||CT|||1^once^^20150323132900||||||||||||||||^^^^CT1瀹?ZDS|1.2.276.0.37.1.281.20131014751^^Application^DICOM";

                    strRecv = strRecv.Replace("", "");
                    strRecv = strRecv.Replace("\\&", "");

                    LogUtil.DebugLog("Recieve Message value = " + strRecv);
                    string[] listMSH;
                    SetRecvVal(strRecv, out listMSH);
                    ExecSQL(ExamInfo);
                    string strReturn = "MSH|^~\\&|Carestream|KIOSK|MEDAVIS|JSPH-RIS-OF|{0}||ACK|{1}|P|2.3.1\rMSA|AA|{2}";
                    //string strVal0 = SplitStrVal(6,listMSH,false);
                    string strVal0 = string.Format("{0:yyyyMMddHHmmss}", System.DateTime.Now);

                    string strVal1 = SplitStrVal(9,listMSH,false);
                    strReturn = string.Format(strReturn, strVal0, strVal1, strVal1);

                    byte[] Head = new byte[] { 0xb };
                    byte[] body = System.Text.Encoding.UTF8.GetBytes(strReturn);
                    byte[] newByte = new byte[Head.Length + body.Length];
                    Stream sLoad = new MemoryStream();
                    sLoad.Write(Head, 0, 1);
                    sLoad.Write(body, 0, body.Length);
                    sLoad.Position = 0;
                    sLoad.Read(newByte, 0, newByte.Length);
                    strReturn = System.Text.Encoding.UTF8.GetString(newByte);

                    LogUtil.DebugLog("Return Ris message,Message as folllow:");
                    LogUtil.DebugLog("ACK Message = " + strReturn);
                    //bs = System.Text.Encoding.UTF8.GetBytes(strReturn); 
                    System.Text.UTF8Encoding utf8 = new System.Text.UTF8Encoding();
                    bs = utf8.GetBytes(strReturn);
                }
                try
                {
                    int iRet = newSocket.Send(bs);
                    LogUtil.DebugLog("ACK message send success.Send message length = " + iRet.ToString());                    
                }
                catch (System.Exception ex)
                {
                    LogUtil.DebugLog("ACK message send error,error info = " + ex.ToString());
                }                
            }
        }

        private void SetRecvVal(string strParam, out string[] listMSH)
        {
            ExamInfo.ClearExamInfo();
            string strType = "";
            string strVal = strParam;
            int iIndex = 0;
            string[] strEVN = null;
            string[] strPID = null;
            string[] strOBR = null;
            string[] strPV1 = null;
            string[] strORC = null;
            
            string[] strBlock = strParam.Split('\r');
            listMSH = strBlock[0].Split('|');
            if (strBlock[0].IndexOf("MSH", 0) >= 0)
            {
                string[] listMSHEx = strBlock[0].Split('|');
            }
            if (strBlock[1].IndexOf("EVN", 0) >= 0)
            {
                strEVN = strBlock[1].Split('|');
            }
            if (strBlock[2].IndexOf("PID", 0) >= 0)
            {
                strPID = strBlock[2].Split('|');
            }
            if (strBlock[5].IndexOf("OBR", 0) >= 0)
            {
                strOBR = strBlock[5].Split('|');
            }
            if (strBlock[3].IndexOf("PV1", 0) >= 0)
            {
            strPV1 = strBlock[3].Split('|');
            }
            if (strBlock[4].IndexOf("ORC", 0) >= 0)
            {
                strORC = strBlock[4].Split('|');
            }

            if (null != strPID)
            {
                ExamInfo.strPatientID = SplitStrVal(2, strPID, true);
                ExamInfo.strNameCN = SplitStrVal(5, strPID, false);
                ExamInfo.strGender = SplitStrVal(8, strPID, false);
            }
            if (null != strOBR)
            {
                ExamInfo.strAccessionNumber = SplitStrVal(18, strOBR, false);
                ExamInfo.strModality = SplitStrVal(24, strOBR, false);
                ExamInfo.strModalityName = SplitStrVal(19, strOBR, false);
            }
            ExamInfo.strStudyInstanceUID = "";
            ExamInfo.strNameEN = "";                
            ExamInfo.strBirthday = "";
            if (null != strPV1)
            {
                strType = SplitStrVal(2, strPV1, false);
                if (strType == "")
                {
                    ExamInfo.strPatientType = "门诊";
                }
                else if (strType == "S")
                {
                    ExamInfo.strPatientType = "住院";
                }
                else if ((0 <= SplitStrVal(3, strPID, false).IndexOf("TJ")) || (0 <= SplitStrVal(3, strPID, false).IndexOf("LGB")))
                {
                    ExamInfo.strPatientType = "体检";
                }
                else
                {
                    ExamInfo.strPatientType = "Other";
                }
            }                       
            
            ExamInfo.strVisitID = "0";
            ExamInfo.strRequestID = "";
            ExamInfo.strRequestDepartment = "";
            ExamInfo.strRequestDT = "";
            ExamInfo.strRegisterDT = "";
            ExamInfo.strExamDT = "";
            ExamInfo.strSubmitDT = "";
            ExamInfo.strApproveDT = "";
            ExamInfo.strPDFReportURL = "";
            ExamInfo.strStudyStatus = "";
            ExamInfo.strOutHospitalNo = "";
            ExamInfo.strInHospitalNo = "";
            ExamInfo.strPhysicalNo = "";
            ExamInfo.strExamName = "";
            ExamInfo.strExamBodyPart = "";
            ExamInfo.strOptional0 = "";
            ExamInfo.strOptional1 = "";
            ExamInfo.strOptional2 = "";
            ExamInfo.strOptional3 = "";
            ExamInfo.strOptional4 = "";
            ExamInfo.strOptional5 = "";
            ExamInfo.strOptional6 = "";
            ExamInfo.strOptional7 = "";
            ExamInfo.strOptional8 = "";
            ExamInfo.strOptional9 = "";

            LogUtil.DebugLog("Analysis HL7 message,Message info as follow:");
            LogUtil.DebugLog("PatientID = " + ExamInfo.strPatientID);
            LogUtil.DebugLog("AccessionNumber = " + ExamInfo.strAccessionNumber);
            LogUtil.DebugLog("StudyInstanceUID = " + ExamInfo.strStudyInstanceUID);
            LogUtil.DebugLog("NameEN = " + ExamInfo.strNameEN);
            LogUtil.DebugLog("NameCN = " + ExamInfo.strNameCN);
            LogUtil.DebugLog("Gender = " + ExamInfo.strGender);
            LogUtil.DebugLog("Birthday = " + ExamInfo.strBirthday);
            LogUtil.DebugLog("Modality = " + ExamInfo.strModality);
            LogUtil.DebugLog("ModalityName = " + ExamInfo.strModalityName);
            LogUtil.DebugLog("PatientType = " + ExamInfo.strPatientType);
            LogUtil.DebugLog("VisitID = " + ExamInfo.strVisitID);
            LogUtil.DebugLog("RequestID = " + ExamInfo.strRequestID);
            LogUtil.DebugLog("RequestDepartmen = " + ExamInfo.strRequestDepartment);
            LogUtil.DebugLog("RequestDT = " + ExamInfo.strRequestDT);
            LogUtil.DebugLog("RegisterDT = " + ExamInfo.strRegisterDT);
            LogUtil.DebugLog("ExamDT = " + ExamInfo.strExamDT);
            LogUtil.DebugLog("SubmitDT = " + ExamInfo.strSubmitDT);
            LogUtil.DebugLog("ApproveDT = " + ExamInfo.strApproveDT);
            LogUtil.DebugLog("PDFReportURL = " + ExamInfo.strPDFReportURL);
            LogUtil.DebugLog("StudyStatus = " + ExamInfo.strStudyStatus);
            LogUtil.DebugLog("OutHospitalNo = " + ExamInfo.strOutHospitalNo);
            LogUtil.DebugLog("InHospitalNo = " + ExamInfo.strInHospitalNo);
            LogUtil.DebugLog("PhysicalNo = " + ExamInfo.strPhysicalNo);
            LogUtil.DebugLog("ExamName = " + ExamInfo.strExamName);
            LogUtil.DebugLog("ExamBodyPart = " + ExamInfo.strExamBodyPart);
            LogUtil.DebugLog("Optional0 = " + ExamInfo.strOptional0);
            LogUtil.DebugLog("Optional1 = " + ExamInfo.strOptional1);
            LogUtil.DebugLog("Optional2 = " + ExamInfo.strOptional2);
            LogUtil.DebugLog("Optional3 = " + ExamInfo.strOptional3);
            LogUtil.DebugLog("Optional4 = " + ExamInfo.strOptional4);
            LogUtil.DebugLog("Optional5 = " + ExamInfo.strOptional5);
            LogUtil.DebugLog("Optional6 = " + ExamInfo.strOptional6);
            LogUtil.DebugLog("Optional7 = " + ExamInfo.strOptional7);
            LogUtil.DebugLog("Optional8 = " + ExamInfo.strOptional8);
            LogUtil.DebugLog("Optional9 = " + ExamInfo.strOptional9);
        }

        private string SplitStrVal(int iIndex, string[] strList, bool bFirst)
        {
            string strRet = "";
            string strVal = "";
            strVal = strList[iIndex].ToString();
            int iVal = strVal.IndexOf("^");
            if (iVal > 0)
            {
                byte[] subbyte = System.Text.Encoding.Default.GetBytes(strVal);
                if (bFirst)
                {
                    strRet = System.Text.Encoding.Default.GetString(subbyte, 0, iVal);
                }
                else
                {                    
                    strRet = System.Text.Encoding.Default.GetString(subbyte, 4, subbyte.Length - 4);
                }
            }
            else if (0 <= strVal.IndexOf("U-ID"))
            {
                strRet = strVal.Substring(4, strVal.Length - 4);
            }
            else
            {
                strRet = strVal;
            }
            return strRet;
        }

        private string ExecSQL(CExamInfo curExamInfo)
        {
            string strRet = "";
            LogUtil.DebugLog("Call function ExecSQL().");
            LogUtil.DebugLog("Call DAOMSSQLWSProxy.SetPSExamInfo().Input Param as follow:");
            LogUtil.DebugLog("SQL = " + m_Config_InboundService_HL7.M_ExecSQL);
            LogUtil.DebugLog("PatientID = " + curExamInfo.strPatientID.Trim());
            LogUtil.DebugLog("AccessionNumber = " + curExamInfo.strAccessionNumber.Trim());
            LogUtil.DebugLog("StudyInstanceUID = " + curExamInfo.strStudyInstanceUID.Trim());
            LogUtil.DebugLog("NameEN = " + curExamInfo.strNameEN.Trim());
            LogUtil.DebugLog("NameCN = " + curExamInfo.strNameCN.Trim());
            LogUtil.DebugLog("Gender = " + curExamInfo.strGender.Trim());
            LogUtil.DebugLog("Birthday = " + curExamInfo.strBirthday.Trim());
            LogUtil.DebugLog("Modality = " + curExamInfo.strModality.Trim());
            LogUtil.DebugLog("ModalityName = " + curExamInfo.strModalityName.Trim());
            LogUtil.DebugLog("PatientType = " + curExamInfo.strPatientType.Trim());
            LogUtil.DebugLog("VisitID = " + curExamInfo.strVisitID.Trim());
            LogUtil.DebugLog("RequestID = " + curExamInfo.strRequestID.Trim());
            LogUtil.DebugLog("RequestDepartment = " + curExamInfo.strRequestDepartment.Trim());
            LogUtil.DebugLog("RequestDT = " + curExamInfo.strRequestDT.Trim());
            LogUtil.DebugLog("RegisterDT = " + curExamInfo.strRegisterDT.Trim());
            LogUtil.DebugLog("ExamDT = " + curExamInfo.strExamDT.Trim());
            LogUtil.DebugLog("SubmitDT = " + curExamInfo.strSubmitDT.Trim());
            LogUtil.DebugLog("ApproveDT = " + curExamInfo.strApproveDT.Trim());
            LogUtil.DebugLog("PDFReportURL = " + curExamInfo.strPDFReportURL.Trim());
            LogUtil.DebugLog("StudyStatus = " + curExamInfo.strStudyStatus.Trim());


            LogUtil.DebugLog("OutHospitalNo = " + curExamInfo.strOutHospitalNo.Trim());
            LogUtil.DebugLog("InHospital = " + curExamInfo.strInHospitalNo.Trim());
            LogUtil.DebugLog("PhsicalNumber = " + curExamInfo.strPhysicalNo.Trim());
            LogUtil.DebugLog("ExamName = " + curExamInfo.strExamName.Trim());
            LogUtil.DebugLog("ExamBodyPart = " + curExamInfo.strExamBodyPart.Trim());

            LogUtil.DebugLog("Optional0 = " + curExamInfo.strOptional0.Trim());
            LogUtil.DebugLog("Optional1 = " + curExamInfo.strOptional1.Trim());
            LogUtil.DebugLog("Optional2 = " + curExamInfo.strOptional2.Trim());
            LogUtil.DebugLog("Optional3 = " + curExamInfo.strOptional3.Trim());
            LogUtil.DebugLog("Optional4 = " + curExamInfo.strOptional4.Trim());
            LogUtil.DebugLog("Optional5 = " + curExamInfo.strOptional5.Trim());
            LogUtil.DebugLog("Optional6 = " + curExamInfo.strOptional6.Trim());
            LogUtil.DebugLog("Optional7 = " + curExamInfo.strOptional7.Trim());
            LogUtil.DebugLog("Optional8 = " + curExamInfo.strOptional8.Trim());
            LogUtil.DebugLog("Optional9 = " + curExamInfo.strOptional9.Trim());
            try
            {
                string strOutputInfo = "";
                dbCtrl.m_DAOMSSQLRIS.SetPSExamInfo(m_Config_InboundService_HL7.M_ExecSQL,
                        curExamInfo.strPatientID.Trim(),
                        curExamInfo.strAccessionNumber.Trim(),
                        curExamInfo.strStudyInstanceUID.Trim(),
                        curExamInfo.strNameEN.Trim(),
                        curExamInfo.strNameCN.Trim(),
                        curExamInfo.strGender.Trim(),
                        curExamInfo.strBirthday.Trim(),
                        curExamInfo.strModality.Trim(),
                        curExamInfo.strModalityName.Trim(),
                        curExamInfo.strPatientType.Trim(),
                        curExamInfo.strVisitID.Trim(),
                        curExamInfo.strRequestID.Trim(),
                        curExamInfo.strRequestDepartment.Trim(),
                        curExamInfo.strRequestDT.Trim(),
                        curExamInfo.strRegisterDT.Trim(),
                        curExamInfo.strExamDT.Trim(),
                        curExamInfo.strSubmitDT.Trim(),
                        curExamInfo.strApproveDT.Trim(),
                        curExamInfo.strPDFReportURL.Trim(),
                        curExamInfo.strStudyStatus.Trim(),
                        curExamInfo.iReportStatus,
                        curExamInfo.iPDFFlag,
                        curExamInfo.iVerifyFilmFlag,
                        curExamInfo.iVerifyReportFlag,
                        curExamInfo.iFilmStoredFlag,
                        curExamInfo.iReportStoredFlag,
                        curExamInfo.iNotifyReportFlag,
                        curExamInfo.iSetPrintModeFlag,
                        curExamInfo.iFilmPrintFlag,
                        curExamInfo.strFilmPrintDoctor.Trim(),
                        curExamInfo.iReportPrintFlag,
                        curExamInfo.strReportPrintDoctor.Trim(),

                        curExamInfo.strOutHospitalNo.Trim(),
                        curExamInfo.strInHospitalNo.Trim(),
                        curExamInfo.strPhysicalNo.Trim(),
                        curExamInfo.strExamName.Trim(),
                        curExamInfo.strExamBodyPart.Trim(),

                        curExamInfo.strOptional0.Trim(),
                        curExamInfo.strOptional1.Trim(),
                        curExamInfo.strOptional2.Trim(),
                        curExamInfo.strOptional3.Trim(),
                        curExamInfo.strOptional4.Trim(),
                        curExamInfo.strOptional5.Trim(),
                        curExamInfo.strOptional6.Trim(),
                        curExamInfo.strOptional7.Trim(),
                        curExamInfo.strOptional8.Trim(),
                        curExamInfo.strOptional9.Trim(),
                        out strOutputInfo);
                strRet = strOutputInfo;
                LogUtil.DebugLog("DAOMSSQLWSProxy.SetPSExamInfo(), Output Parameter AS Follows:");
                LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
            }
            catch (System.Exception ex)
            {
                LogUtil.ErrorLog("Function.SetPSExamInfo() Error Message = " + ex.ToString());
            }
            finally
            {                
                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                LogUtil.DebugLog("Function.SetPSExamInfo() Return = " + strRet.ToString());
                LogUtil.DebugLog("Exit Function.SetPSExamInfo().");
            }            

            return strRet;
        }

        public FormHL7Reciew()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ListenThread = new Thread(new ThreadStart(BeginListen));
            ListenThread.Start();
        }

        private void FormHL7Reciew_SizeChanged(object sender, EventArgs e)
        {
            if (this.WindowState == FormWindowState.Minimized)
            {
                this.Visible = false;
                this.ntfHL7.Visible = true;
            }
        }

        private void FormHL7Reciew_Load(object sender, EventArgs e)
        {
            LoadConfigAndInitializLogUtil();
            dbCtrl.InitDBConnection();
            InitSocket();

            this.Visible = false;
            this.ntfHL7.Visible = true;
            button1_Click(this, null);
        }

        private void ntfHL7_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            this.Visible = true;
            this.WindowState = FormWindowState.Normal;
        }

        private void btnCLose_Click(object sender, EventArgs e)
        {
            if (dbCtrl != null)
            {
                dbCtrl = null;
            }

            if (null != ExamInfo)
            {
                ExamInfo = null;
            }
            
            if (null != HL7Socket)
            {                
                //HL7Socket.Disconnect(true);
                HL7Socket.Close();
                HL7Socket.Dispose();
            }
            if (null != ListenThread)
            {
                ListenThread.Abort();
            }
            this.Close();
        }

        private void FormHL7Reciew_FormClosing(object sender, FormClosingEventArgs e)
        {
            btnCLose_Click(this, null);
        }
    }
}
