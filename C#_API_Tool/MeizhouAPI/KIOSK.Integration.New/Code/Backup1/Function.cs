using System;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.Xml.Xsl;

using MySql.Data.MySqlClient;
using C1.C1Report;
using DicomObjects;
using iTextSharp.text;

using KIOSK.Integration.Config;
using KIOSK.Integration.Log;
using KIOSK.Integration.Util;
using KIOSK.Integration.Util.DAO;


namespace KIOSK.Integration.WSProxy
{
    public class Function
    {
        #region variable definition

        /// <summary>
        /// Reads or writes the config information of KIOSK.Integration.WSProxy.
        /// </summary>
        protected Config_WSProxy m_Config_WSProxy = null;

        /// <summary>
        /// The config information of KIOSK.Integration.WSProxy.
        /// </summary>
        protected ConfigXML_WSProxy m_ConfigXML_WSProxy = null;

        //********************MSSQL RIS********************
        protected DBConnectionMSSQL m_DBConnectionMSSQLRIS = null;
        protected SqlConnection m_SQLConRIS = null;
        protected SqlTransaction m_SQLTraRIS = null;
        protected DAOMSSQLRIS m_DAOMSSQLRIS = null;

        //********************MySQL RIS********************
        protected DBConnectionMySQL m_DBConnectionMySQLRIS = null;
        protected MySqlConnection m_MySQLConRIS = null;
        protected MySqlTransaction m_MySQLTraRIS = null;
        protected DAOMySQLRIS m_DAOMySQLRIS = null;

        //********************Oracle RIS********************
        protected DBConnectionOracle m_DBConnectionOracleRIS = null;
        protected OleDbConnection m_OracleConRIS = null;
        protected OleDbTransaction m_OracleTraRIS = null;
        protected DAOORACLERIS m_DAOORACLERIS = null;

        //********************MSSQL PS********************
        protected DBConnectionMSSQL m_DBConnectionMSSQLPS = null;
        protected SqlConnection m_SQLConPS = null;
        protected SqlTransaction m_SQLTraPS = null;
        protected DAOMSSQLWSProxy m_DAOMSSQLWSProxy = null;

        #endregion

        public Function()
        {
            LoadConfigAndInitializLogUtil();
        }

        protected void LoadConfigAndInitializLogUtil()
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
            m_Config_WSProxy = new Config_WSProxy();
            m_ConfigXML_WSProxy = new ConfigXML_WSProxy();
            m_ConfigXML_WSProxy.M_ConfigFileName = strConfigFileName;
            m_ConfigXML_WSProxy.M_Config = m_Config_WSProxy;
            m_ConfigXML_WSProxy.LoadConfig();

            // LogUtil init.
            string strLogFilePath = "";
            if (".." == m_Config_WSProxy.M_LogFilePath.Trim().Substring(0, 2))
            {
                strLogFilePath = Path.Combine(strCurrentPathParent, m_Config_WSProxy.M_LogFilePath.Trim().Substring(3, m_Config_WSProxy.M_LogFilePath.Trim().Length - 3));
            }
            else
            {
                strLogFilePath = m_Config_WSProxy.M_LogFilePath.Trim();
            }
            LogUtil.Initialize(strLogFilePath, m_Config_WSProxy.M_LogLevel, m_Config_WSProxy.M_LogFileKeepTime);

            LogUtil.DebugLog("");
            LogUtil.DebugLog("----------KIOSK.Integration.WSProxy init starting.---------------------------");
            LogUtil.DebugLog("Load config and LogUtil initialize success.");
            LogUtil.DebugLog("KIOSK.Integration.WSProxy.Config path:" + strConfigFileName);

            LogUtil.DebugLog("RISDBType=" + m_Config_WSProxy.M_RISDBType);
            LogUtil.DebugLog("RISDBServer=" + m_Config_WSProxy.M_RISDBServer);
            LogUtil.DebugLog("RISDBName=" + m_Config_WSProxy.M_RISDBName);
            LogUtil.DebugLog("RISDBUserName=" + m_Config_WSProxy.M_RISDBUserName);
            //LogUtil.DebugLog("RISDBPassword=" + m_Config_WSProxy.M_RISDBPassword);

            LogUtil.DebugLog("PSDBServer=" + m_Config_WSProxy.M_PSDBServer);
            LogUtil.DebugLog("PSDBName=" + m_Config_WSProxy.M_PSDBName);
            LogUtil.DebugLog("PSDBUserName=" + m_Config_WSProxy.M_PSDBUserName);
            //LogUtil.DebugLog("PSDBPassword=" + m_Config_WSProxy.M_PSDBPassword);

            LogUtil.DebugLog("MWLEnabled=" + m_Config_WSProxy.M_MWLEnabled);
            LogUtil.DebugLog("MWLNode=" + m_Config_WSProxy.M_MWLNode);
            LogUtil.DebugLog("MWLPort=" + m_Config_WSProxy.M_MWLPort);
            LogUtil.DebugLog("MWLCalledAE=" + m_Config_WSProxy.M_MWLCalledAE);
            LogUtil.DebugLog("MWLCallingAE=" + m_Config_WSProxy.M_MWLCallingAE);

            LogUtil.DebugLog("LogFilePath=" + m_Config_WSProxy.M_LogFilePath);
            LogUtil.DebugLog("LogLevel=" + m_Config_WSProxy.M_LogLevel);
            LogUtil.DebugLog("LogFileKeepTime=" + m_Config_WSProxy.M_LogFileKeepTime);

            LogUtil.DebugLog("QueryInterval = " + m_Config_WSProxy.M_iQueryInterval.ToString());
            LogUtil.DebugLog("SwingGetExamInfo = " + m_Config_WSProxy.M_strSwingGetExamInfo);
            LogUtil.DebugLog("SwingGetReportBefore = " + m_Config_WSProxy.M_strSwingReportBefore);
            LogUtil.DebugLog("SwingGetReport = " + m_Config_WSProxy.M_strSwingReport);
            LogUtil.DebugLog("GetReportType = " + m_Config_WSProxy.M_iGetReportType.ToString());
            LogUtil.DebugLog("GetReportFromShareFolder = " + m_Config_WSProxy.M_strGetReportFromShareFolder);
            LogUtil.DebugLog("ReportType = " + m_Config_WSProxy.M_iReportType.ToString());
            LogUtil.DebugLog("PDFFTPPath = " + m_Config_WSProxy.M_PDFFTPPath);
            LogUtil.DebugLog("PDFPhysicPath = " + m_Config_WSProxy.M_PDFPhysicPath);
            LogUtil.DebugLog("XSLTPathForQueryExamInfo = " + m_Config_WSProxy.M_XSLTPathForQueryExamInfo);
            LogUtil.DebugLog("XSLTPathForUpdateExamInfo = " + m_Config_WSProxy.M_XSLTPathForUpdateExamInfo);

            LogUtil.DebugLog("WSURLForPS = " + m_Config_WSProxy.M_WSURL_PSOrNS);
            LogUtil.DebugLog("WSURLForPS = " + m_Config_WSProxy.M_WSURL_PS);
            LogUtil.DebugLog("WSURLForPS = " + m_Config_WSProxy.M_WSURL_NS);
            LogUtil.DebugLog("WSURLForRISExamInfo = " + m_Config_WSProxy.M_WSURL_RISExamInfo);
            LogUtil.DebugLog("WSURLForRISPDFReportInfo = " + m_Config_WSProxy.M_WSURL_RISPDFReportInfo);
            LogUtil.DebugLog("WSURLForRISOtherInfo = " + m_Config_WSProxy.M_WSURL_RISOtherInfo);

            LogUtil.DebugLog("SQLForGetRISReportInfo = " + m_Config_WSProxy.M_SQLForGetRISReportInfo);
            LogUtil.DebugLog("SQLForSetRISReportInfo = " + m_Config_WSProxy.M_SQLForSetRISReportInfo);
            LogUtil.DebugLog("SQLForGetRISExamInfo = " + m_Config_WSProxy.M_SQLForGetRISExamInfo);
            LogUtil.DebugLog("SQLForGetRISExamInfoEx = " + m_Config_WSProxy.M_SQLForGetRISExamInfoEx);
            LogUtil.DebugLog("SQLForGetUnPrintedStudy = " + m_Config_WSProxy.M_SQLForGetUnPrintedStudy);

            LogUtil.DebugLog("SQLForSetPSExamInfo = " + m_Config_WSProxy.M_SQLForSetPSExamInfo);
            LogUtil.DebugLog("SQLForGetPSExamInfo = " + m_Config_WSProxy.M_SQLForGetPSExamInfo);
            LogUtil.DebugLog("SQLForGetPSReportInfo = " + m_Config_WSProxy.M_SQLForGetPSReportInfo);
            LogUtil.DebugLog("SQLForGetPSPrintMode = " + m_Config_WSProxy.M_SQLForGetPSPrintMode);
            LogUtil.DebugLog("SQLForGetPSPatientInfo = " + m_Config_WSProxy.M_SQLForGetPSPatientInfo);
            LogUtil.DebugLog("SQLForUpdateReportStatus = " + m_Config_WSProxy.M_SQLForUpdateReportStatus);
            LogUtil.DebugLog("SQLForSetPrintMode = " + m_Config_WSProxy.M_SQLForSetPrintMode);
            
            LogUtil.DebugLog("----------KIOSK.Integration.WSProxy init finished.---------------------------");
        }

        protected virtual void FunctionInitializ()
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.FunctionInitializ().");

            try
            {
                LogUtil.DebugLog("DBConnectionMSSQL() Initialize For RIS, Input Parameter AS Follows:");
                LogUtil.DebugLog("RISDBType = " + m_Config_WSProxy.M_RISDBType);
                LogUtil.DebugLog("RISDBServer = " + m_Config_WSProxy.M_RISDBServer);
                LogUtil.DebugLog("RISDBName = " + m_Config_WSProxy.M_RISDBName);
                LogUtil.DebugLog("RISDBUserName = " + m_Config_WSProxy.M_RISDBUserName);
                //LogUtil.DebugLog("RISDBPassword = " + m_Config_WSProxy.M_RISDBPassword);

                if ("MYSQL" == m_Config_WSProxy.M_RISDBType.Trim().ToUpper())
                {
                    if (null == m_DBConnectionMySQLRIS)
                    {
                        m_DBConnectionMySQLRIS = new DBConnectionMySQL();
                        m_DBConnectionMySQLRIS.InitStrDBCon(
                            m_Config_WSProxy.M_RISDBServer,
                            m_Config_WSProxy.M_RISDBName,
                            m_Config_WSProxy.M_RISDBUserName,
                            m_Config_WSProxy.M_RISDBPassword);

                        LogUtil.DebugLog("DBConnectionMSSQL() Initialize For RIS Finished.");
                    }

                    if (null == m_MySQLConRIS)
                    {
                        m_MySQLConRIS = m_DBConnectionMySQLRIS.OpenMySQLCon();

                        LogUtil.DebugLog("DBConnectionMySQL.OpenMySQLCon() For RIS Finished.");
                    }

                    if (null == m_DAOMySQLRIS)
                    {
                        m_DAOMySQLRIS = new DAOMySQLRIS(m_MySQLConRIS, m_MySQLTraRIS);

                        LogUtil.DebugLog("NEW DAOMySQLRIS() Finished.");
                    }
                }
                else if ("ORACLE" == m_Config_WSProxy.M_RISDBType.Trim().ToUpper())
                {
                    if (null == m_DBConnectionOracleRIS)
                    {
                        m_DBConnectionOracleRIS = new DBConnectionOracle();
                        m_DBConnectionOracleRIS.InitStrDBCon(
                            m_Config_WSProxy.M_RISDBServer,
                            m_Config_WSProxy.M_RISDBName,
                            m_Config_WSProxy.M_RISDBUserName,
                            m_Config_WSProxy.M_RISDBPassword);

                        LogUtil.DebugLog("DBConnectionOracle() Initialize For RIS Finished.");
                    }

                    if (null == m_OracleConRIS)
                    {
                        m_OracleConRIS = m_DBConnectionOracleRIS.OpenOraCon();

                        LogUtil.DebugLog("DBConnectionOracle.OpenOraCon() For RIS Finished.");
                    }

                    if (null == m_DAOORACLERIS)
                    {
                        m_DAOORACLERIS = new DAOORACLERIS(m_OracleConRIS, m_OracleTraRIS);

                        LogUtil.DebugLog("NEW DAOORACLERIS() Finished.");
                    }
                }
                else
                {
                    if (null == m_DBConnectionMSSQLRIS)
                    {
                        m_DBConnectionMSSQLRIS = new DBConnectionMSSQL();
                        m_DBConnectionMSSQLRIS.InitStrDBCon(
                            m_Config_WSProxy.M_RISDBServer,
                            m_Config_WSProxy.M_RISDBName,
                            m_Config_WSProxy.M_RISDBUserName,
                            m_Config_WSProxy.M_RISDBPassword);

                        LogUtil.DebugLog("DBConnectionMSSQL() Initialize For RIS Finished.");
                    }

                    if (null == m_SQLConRIS)
                    {
                        m_SQLConRIS = m_DBConnectionMSSQLRIS.OpenSQLCon();

                        LogUtil.DebugLog("DBConnectionMSSQL.OpenSQLCon() For RIS Finished.");
                    }

                    if (null == m_DAOMSSQLRIS)
                    {
                        m_DAOMSSQLRIS = new DAOMSSQLRIS(m_SQLConRIS, m_SQLTraRIS);

                        LogUtil.DebugLog("NEW DAOMSSQLRIS() Finished.");
                    }
                }

                if (null == m_DBConnectionMSSQLPS)
                {
                    LogUtil.DebugLog("DBConnectionMSSQL() Initialize For PS, Input Parameter AS Follows:");
                    LogUtil.DebugLog("PSDBServer = " + m_Config_WSProxy.M_PSDBServer);
                    LogUtil.DebugLog("PSDBName = " + m_Config_WSProxy.M_PSDBName);
                    LogUtil.DebugLog("PSDBUserName = " + m_Config_WSProxy.M_PSDBUserName);
                    //LogUtil.DebugLog("PSDBPassword = " + m_Config_WSProxy.M_PSDBPassword);

                    m_DBConnectionMSSQLPS = new DBConnectionMSSQL();
                    m_DBConnectionMSSQLPS.InitStrDBCon(
                        m_Config_WSProxy.M_PSDBServer,
                        m_Config_WSProxy.M_PSDBName,
                        m_Config_WSProxy.M_PSDBUserName,
                        m_Config_WSProxy.M_PSDBPassword);

                    LogUtil.DebugLog("DBConnectionMSSQL() Initialize For PS Finished.");
                }

                if (null == m_SQLConPS)
                {
                    m_SQLConPS = m_DBConnectionMSSQLPS.OpenSQLCon();

                    LogUtil.DebugLog("DBConnectionMSSQL.OpenSQLCon() For PS Finished.");
                }

                if (null == m_DAOMSSQLWSProxy)
                {
                    m_DAOMSSQLWSProxy = new DAOMSSQLWSProxy(m_SQLConPS, m_SQLTraPS);

                    LogUtil.DebugLog("NEW DAOMSSQLWSProxy() Finished.");
                }
            }
            catch (Exception ex)
            {
                FunctionDispose();

                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                LogUtil.ErrorLog("Function.FunctionInitializ() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Exit Function.FunctionInitializ().");
            }
        }

        protected virtual void FunctionDispose()
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.FunctionDispose().");

            try
            {
                //********************MySQL RIS********************

                if (null != m_DBConnectionMySQLRIS)
                {
                    m_DBConnectionMySQLRIS.CloseMySQLCon(m_MySQLConRIS);
                    m_DBConnectionMySQLRIS = null;

                    LogUtil.DebugLog("DBConnectionMySQL.CloseSQLCon() For RIS Finished.");
                }

                if (null != m_MySQLTraRIS)
                {
                    m_MySQLTraRIS.Dispose();
                    m_MySQLTraRIS = null;

                    LogUtil.DebugLog("MySQLTraRIS.Dispose() Finished.");
                }

                if (null != m_MySQLConRIS)
                {
                    m_MySQLConRIS.Dispose();
                    m_MySQLConRIS = null;

                    LogUtil.DebugLog("MySQLConRIS.Dispose() Finished.");
                }

                if (null != m_DAOMySQLRIS)
                {
                    m_DAOMySQLRIS = null;

                    LogUtil.DebugLog("DAOMySQLRIS.Dispose() Finished.");
                }

                //********************Oracle RIS********************

                if (null != m_DBConnectionOracleRIS)
                {
                    m_DBConnectionOracleRIS.CloseOraCon(m_OracleConRIS);
                    m_DBConnectionOracleRIS = null;

                    LogUtil.DebugLog("DBConnectionOracleRIS.CloseOraCon() For RIS Finished.");
                }

                if (null != m_OracleTraRIS)
                {
                    m_OracleTraRIS.Dispose();
                    m_OracleTraRIS = null;

                    LogUtil.DebugLog("OracleTraRIS.Dispose() Finished.");
                }

                if (null != m_OracleConRIS)
                {
                    m_OracleConRIS.Dispose();
                    m_OracleConRIS = null;

                    LogUtil.DebugLog("OracleConRIS.Dispose() Finished.");
                }

                if (null != m_DAOORACLERIS)
                {
                    m_DAOORACLERIS = null;

                    LogUtil.DebugLog("DAOORACLERIS.Dispose() Finished.");
                }

                //********************MSSQL RIS********************

                if (null != m_DBConnectionMSSQLRIS)
                {
                    m_DBConnectionMSSQLRIS.CloseSQLCon(m_SQLConRIS);
                    m_DBConnectionMSSQLRIS = null;

                    LogUtil.DebugLog("DBConnectionMSSQL.CloseSQLCon() For RIS Finished.");
                }

                if (null != m_SQLTraRIS)
                {
                    m_SQLTraRIS.Dispose();
                    m_SQLTraRIS = null;

                    LogUtil.DebugLog("SQLTraRIS.Dispose() Finished.");
                }

                if (null != m_SQLConRIS)
                {
                    m_SQLConRIS.Dispose();
                    m_SQLConRIS = null;

                    LogUtil.DebugLog("SQLConRIS.Dispose() Finished.");
                }

                if (null != m_DAOMSSQLRIS)
                {
                    m_DAOMSSQLRIS = null;

                    LogUtil.DebugLog("DAOMSSQLRIS.Dispose() Finished.");
                }

                //********************MSSQL PS********************

                if (null != m_DBConnectionMSSQLPS)
                {
                    m_DBConnectionMSSQLPS.CloseSQLCon(m_SQLConPS);
                    m_DBConnectionMSSQLPS = null;

                    LogUtil.DebugLog("DBConnectionMSSQL.CloseSQLCon() For PS Finished.");
                }

                if (null != m_SQLTraPS)
                {
                    m_SQLTraPS.Dispose();
                    m_SQLTraPS = null;

                    LogUtil.DebugLog("SQLTraPS.Dispose() Finished.");
                }

                if (null != m_SQLConPS)
                {
                    m_SQLConPS.Dispose();
                    m_SQLConPS = null;

                    LogUtil.DebugLog("SQLConPS.Dispose() Finished.");
                }

                if (null != m_DAOMSSQLWSProxy)
                {
                    m_DAOMSSQLWSProxy = null;

                    LogUtil.DebugLog("DAOMSSQLWSProxy.Dispose() Finished.");
                }
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("Function.FunctionDispose() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Exit Function.FunctionDispose().");
            }
        }

        protected string DataSetToXML(DataSet ds, string strXSLTPath)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.DataSetToXML(), Input Parameter AS Follows:");
            LogUtil.DebugLog("DataSet = " + ds.ToString());
            LogUtil.DebugLog("XSLTPath = " + strXSLTPath);

            string strReturn = "";
            string strTempXML = "";

            try
            {
                strTempXML = ds.GetXml();
                using (StringReader srDocument = new StringReader(strTempXML))
                {
                    XslCompiledTransform xctDocument = new XslCompiledTransform();
                    xctDocument.Load(strXSLTPath);

                    XmlReaderSettings xrsDocument = new XmlReaderSettings();
                    xrsDocument.ConformanceLevel = ConformanceLevel.Fragment;
                    XmlReader xrDocument = XmlReader.Create(srDocument, xrsDocument);

                    XmlWriterSettings xwsDocument = new XmlWriterSettings();
                    xwsDocument.ConformanceLevel = ConformanceLevel.Fragment; ;
                    StringBuilder sbTeam = new StringBuilder();
                    XmlWriter xwDocument = XmlWriter.Create(sbTeam, xwsDocument);
                    xctDocument.Transform(xrDocument, xwDocument);

                    xwDocument.Flush();
                    xwDocument.Close();
                    xrDocument.Close();

                    strReturn = sbTeam.ToString();
                }
            }
            catch (Exception ex)
            {
                strReturn = "";

                LogUtil.ErrorLog("Function.DataSetToXML() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Function.DataSetToXML() Return = " + strReturn.ToString());
                LogUtil.DebugLog("Exit Function.DataSetToXML().");
            }

            return strReturn;
        }

        protected string JPG2PDF(string strSourceFile)
        {
            LogUtil.DebugLog(string.Format("Load Function.JPG2PDF()."));
            LogUtil.DebugLog("JPG File = " + strSourceFile);
            string strRet = "";
            try
            {
                string strDestFile = "";
                Guid pdfFileID = new Guid();
                strDestFile = m_Config_WSProxy.M_PDFFTPPath + "\\" + pdfFileID.ToString();
                if (File.Exists(strDestFile))
                    File.Delete(strDestFile);

                var document = new Document(iTextSharp.text.PageSize.A4, 0, 0, 0, 0);
                using (var stream = new FileStream(strDestFile, FileMode.Create, FileAccess.Write, FileShare.None))
                {
                    iTextSharp.text.pdf.PdfWriter.GetInstance(document, stream);
                    document.Open();
                    using (var imageStream = new FileStream(strSourceFile, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                    {
                        var image = iTextSharp.text.Image.GetInstance(imageStream);
                        if (image.Height > iTextSharp.text.PageSize.A4.Height - 0)
                        {
                            image.ScaleToFit(iTextSharp.text.PageSize.A4.Width - 0, iTextSharp.text.PageSize.A4.Height - 0);
                        }
                        else if (image.Width > iTextSharp.text.PageSize.A4.Width - 0)
                        {
                            image.ScaleToFit(iTextSharp.text.PageSize.A4.Width - 0, iTextSharp.text.PageSize.A4.Height - 0);
                        }
                        image.Alignment = iTextSharp.text.Image.ALIGN_MIDDLE;
                        document.Add(image);
                    }

                    document.Close();
                }

                if (File.Exists(strDestFile))
                    strRet = strDestFile;  
            }
            catch (System.Exception ex)
            {
                LogUtil.DebugLog("Function.JPG2PDF() has error!error imfo = " + ex.ToString());
                LogUtil.ErrorLog("Function.JPG2PDF() has error!error imfo = " + ex.ToString());
                LogUtil.InfoLog("Function.JPG2PDF() has error!error imfo = " + ex.ToString());
            }
            LogUtil.DebugLog(string.Format("Function.JPG2PDF() return value = '{0}'.", strRet));
            LogUtil.DebugLog("Exit Function.JPG2PDF().");
            return strRet;
        }

        protected string GetHttpWebRequestBody(string strURL)
        {
            /************************************************
            string strBuff = "";
            Uri httpURL = new Uri(strURL);
            //HttpWebRequest类继承于WebRequest，并没有自己的构造函数，需通过WebRequest的Creat方法建立，并进行强制的类型转换。
            HttpWebRequest httpRequest = (HttpWebRequest)WebRequest.Create(httpURL);
            //通过HttpWebRequest的GetResponse()方法建立HttpWebResponse,强制类型转换。
            HttpWebResponse httpResponse = (HttpWebResponse)httpRequest.GetResponse();  
            //GetResponseStream()方法获取HTTP响应的数据流,并尝试取得URL中所指定的网页内容。
            //若成功取得网页的内容，则以System.IO.Stream形式返回，若失败则产生ProtoclViolationException错误。在此正确的做法应将以下的代码放到一个try块中处理。这里简单处理。
            Stream streamResponse = httpResponse.GetResponseStream();
            //返回的内容是Stream形式的，所以可以利用StreamReader类获取GetResponseStream的内容，并以StreamReader类的Read方法依次读取网页源程序代码每一行的内容，直至行尾（读取的编码格式：UTF8）。
            StreamReader responseStreamReader = new StreamReader(streamResponse, Encoding.UTF8);
            strBuff = responseStreamReader.ReadToEnd();
            ************************************************/

            /************************************************
            string strResponse = new System.Net.WebClient().DownloadString(strURL);
            ************************************************/

            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.GetHttpWebRequestBody(), Input Parameter AS Follows:");
            LogUtil.DebugLog("URL = " + strURL);

            string strReturn = "";
            string strResponse = "";

            try
            {
                HttpWebRequest hwRequest = (HttpWebRequest)HttpWebRequest.Create(strURL);
                HttpWebResponse hwResponse = (HttpWebResponse)hwRequest.GetResponse();

                if (hwResponse.StatusCode == HttpStatusCode.OK)
                {
                    Stream streamResponse = hwResponse.GetResponseStream();
                    StreamReader streamReader = new StreamReader(streamResponse, Encoding.Default);
                    while ((strResponse = streamReader.ReadLine()) != null)
                    {
                        strReturn += strResponse;
                    }
                }

                XmlDocument xmlResponse = new XmlDocument();
                xmlResponse.LoadXml(strReturn);
                XmlElement rootResponse = xmlResponse.DocumentElement;
                strReturn = rootResponse.InnerText;
            }
            catch (Exception ex)
            {
                strReturn = "";

                LogUtil.ErrorLog("Function.GetHttpWebRequestBody() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Function.GetHttpWebRequestBody() Return = " + strReturn.ToString());
                LogUtil.DebugLog("Exit Function.GetHttpWebRequestBody().");
            }

            return strReturn;
        }

        protected bool CreatePDF(DataSet dsReport, string strPDFPath)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.CreatePDF(), Input Parameter AS Follows:");
            LogUtil.DebugLog("Report = DataSet.");
            LogUtil.DebugLog("PDFPath = " + strPDFPath);

            bool bReturn = true;

            try
            {
                LogUtil.DebugLog("CreatePDF Start ...");

                Byte[] bPrintTemplate = dsReport.Tables[0].Rows[0]["tPrintTemplate__TemplateInfo"] as Byte[];
                string strPrintTemplate = System.Text.Encoding.Unicode.GetString(bPrintTemplate);
                XmlDocument xdPrintTemplate = new XmlDocument();
                xdPrintTemplate.LoadXml(strPrintTemplate);
                xdPrintTemplate.Save(strPDFPath + ".xml");

                object objWYS = dsReport.Tables[0].Rows[0]["tReport__WYS_"];
                object objWYG = dsReport.Tables[0].Rows[0]["tReport__WYG_"];

                using (RichTextBox rtbWYS = new RichTextBox())
                {
                    Byte[] rtfWYS = objWYS as Byte[];
                    rtbWYS.Rtf = System.Text.Encoding.Default.GetString(rtfWYS);
                    rtbWYS.Font = new System.Drawing.Font("宋体", 12);
                    string strWYS = rtbWYS.Text;

                    var stream = new System.IO.MemoryStream();
                    rtbWYS.SaveFile(stream, RichTextBoxStreamType.RichText);
                    stream.WriteByte(0);
                    Byte[] buffer = stream.GetBuffer();

                    dsReport.Tables[0].Rows[0]["tReport__WYS"] = System.Text.Encoding.Default.GetString(buffer);
                }

                using (RichTextBox rtbWYG = new RichTextBox())
                {
                    Byte[] rtfWYS = objWYG as Byte[];
                    rtbWYG.Rtf = System.Text.Encoding.Default.GetString(rtfWYS);
                    rtbWYG.Font = new System.Drawing.Font("宋体", 12);
                    string strWYG = rtbWYG.Text;

                    var stream = new System.IO.MemoryStream();
                    rtbWYG.SaveFile(stream, RichTextBoxStreamType.RichText);
                    stream.WriteByte(0);
                    Byte[] buffer = stream.GetBuffer();

                    dsReport.Tables[0].Rows[0]["tReport__WYG"] = System.Text.Encoding.Default.GetString(buffer);
                }

                using (C1Report report = new C1Report())
                {
                    //report.Font = new C1.Win.C1Report.Util.FontHolder(new System.Drawing.Font("幼圆", 12));
                    report.Load(xdPrintTemplate, "template");
                    report.DataSource.Recordset = dsReport.Tables[0];
                    //report.RenderToFile(strPDFPath, C1.Win.C1Report.FileFormatEnum.PDFEmbedFonts);
                    //report.RenderToFile(strPDFPath, C1.Win.C1Report.FileFormatEnum.PDF);
                    report.RenderToFile(strPDFPath, C1.C1Report.FileFormatEnum.PDF);
                    report.Clear();
                    report.Dispose();
                }

                if (!File.Exists(strPDFPath))
                {
                    LogUtil.ErrorLog(strPDFPath + " not exists!");
                    LogUtil.ErrorLog("C1.Win.C1Report.C1Report RenderToFile for create PDF file is failed!");

                    bReturn = false;
                }

                LogUtil.DebugLog("CreatePDF Finish.");
            }
            catch (KIOSKIntegrationException ex)
            {
                bReturn = false;

                LogUtil.ErrorLog("Function.CreatePDF() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Function.CreatePDF() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit Function.CreatePDF().");
            }

            return bReturn;
        }

        private void InitializDicomDataSetClassForResult(DicomDataSetClass dcmDSC, string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStudyDate, string strStudyTime, string strStudyStatusID)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.InitializDicomDataSetClassForResult(), Input Parameter AS Follows:");
            LogUtil.DebugLog("DicomDataSetClass = " + dcmDSC.ToString());
            LogUtil.DebugLog("PatientID = " + strPatientID);
            LogUtil.DebugLog("PatientName = " + strPatientName);
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("Modality = " + strModality);
            LogUtil.DebugLog("StudyDate = " + strStudyDate);
            LogUtil.DebugLog("StudyTime = " + strStudyTime);
            LogUtil.DebugLog("StudyStatusID = " + strStudyStatusID);

            DicomObjects.DicomDataSetsClass dcmDSSC_SPS = new DicomDataSetsClass();
            DicomObjects.DicomDataSetsClass dcmDSSC_V = new DicomDataSetsClass();
            DicomObjects.DicomDataSetClass dcmDSC_SPS = new DicomDataSetClass();
            DicomObjects.DicomDataSetClass dcmDSC_V = new DicomDataSetClass();

            try
            {
                //Patient
                dcmDSC.Attributes.Add(0x0010, 0x0010, strPatientName);
                dcmDSC.Attributes.Add(0x0010, 0x0020, strPatientID);
                dcmDSC.Attributes.Add(0x0010, 0x0030, "");
                dcmDSC.Attributes.Add(0x0010, 0x0032, "");
                dcmDSC.Attributes.Add(0x0010, 0x1000, "");
                dcmDSC.Attributes.Add(0x0010, 0x1001, "");
                dcmDSC.Attributes.Add(0x0010, 0x0040, "");
                dcmDSC.Attributes.Add(0x0010, 0x1030, "");
                dcmDSC.Attributes.Add(0x0040, 0x3001, "");
                dcmDSC.Attributes.Add(0x0038, 0x0500, "");
                //dcmDSC.Attributes.Add(0x0010, 0x21C0, "");
                dcmDSC.Attributes.Add(0x0010, 0x2000, "");
                dcmDSC.Attributes.Add(0x0010, 0x2110, "");
                dcmDSC.Attributes.Add(0x0038, 0x0050, "");
                dcmDSC.Attributes.Add(0x0010, 0x1010, "");
                dcmDSC.Attributes.Add(0x0010, 0x1020, "");
                dcmDSC.Attributes.Add(0x0010, 0x2160, "");
                dcmDSC.Attributes.Add(0x0010, 0x2180, "");
                dcmDSC.Attributes.Add(0x0010, 0x21B0, "");
                //Scheduled Procedure Step
                dcmDSC_SPS.Attributes.Add(0x0040, 0x0001, "");
                dcmDSC_SPS.Attributes.Add(0x0040, 0x0002, strStudyDate);
                dcmDSC_SPS.Attributes.Add(0x0040, 0x0003, strStudyTime);
                dcmDSC_SPS.Attributes.Add(0x0008, 0x0060, strModality);
                dcmDSC_SPS.Attributes.Add(0x0040, 0x0006, "");
                dcmDSC_SPS.Attributes.Add(0x0040, 0x0007, "");
                dcmDSC_SPS.Attributes.Add(0x0040, 0x0010, "");
                dcmDSC_SPS.Attributes.Add(0x0040, 0x0011, "");
                dcmDSC_SPS.Attributes.Add(0x0040, 0x0012, "");
                dcmDSC_SPS.Attributes.Add(0x0040, 0x0009, "");
                dcmDSC_SPS.Attributes.Add(0x0032, 0x1070, "");
                dcmDSC_SPS.Attributes.Add(0x0040, 0x0020, "");
                dcmDSSC_SPS.Add(dcmDSC_SPS);
                dcmDSC.Attributes.Add(0x0040, 0x0100, dcmDSSC_SPS);
                //Visit
                dcmDSC.Attributes.Add(0x0038, 0x0010, "");
                dcmDSC.Attributes.Add(0x0038, 0x0300, "");
                dcmDSC_V.Attributes.Add(0x0008, 0x1150, "");
                dcmDSC_V.Attributes.Add(0x0008, 0x1155, "");
                dcmDSSC_V.Add(dcmDSC_V);
                dcmDSC.Attributes.Add(0x0008, 0x1120, dcmDSSC_V);
                dcmDSC.Attributes.Add(0x0038, 0x0008, "");
                dcmDSC.Attributes.Add(0x0038, 0x0400, "");
                //Image Service Request
                dcmDSC.Attributes.Add(0x0008, 0x0050, strAccessionNumber);
                dcmDSC.Attributes.Add(0x0032, 0x1032, "");
                dcmDSC.Attributes.Add(0x0008, 0x0090, "");
                dcmDSC.Attributes.Add(0x0032, 0x1033, "");
                //Other for Agfa MWL
                dcmDSC.Attributes.Add(0x0008, 0x0005, "");// CS,10,SpecificCharacterSet	"ISO_IR 100"
                dcmDSC.Attributes.Add(0x0020, 0x000d, "");// UI,56,StudyInstanceUID	"1.2.124.113532.58911.5035.4019.20131212.75501.471169331"
                dcmDSC.Attributes.Add(0x0032, 0x000a, strStudyStatusID);// CS,10,StudyStatusID	"COMPLETED "
                dcmDSC.Attributes.Add(0x0032, 0x1060, "");// LO,16,RequestedProcedureDescription	"Upper-Abdomen C "
                dcmDSC.Attributes.Add(0x0040, 0x1001, "");// SH,10,RequestedProcedureID	"R00819242
            }
            catch (Exception ex)
            {
                if (null != dcmDSSC_SPS)
                {
                    dcmDSSC_SPS.Clear();
                    dcmDSSC_SPS = null;

                    LogUtil.DebugLog("dcmDSSC_SPS.Clear() Finished.");
                }

                if (null != dcmDSSC_V)
                {
                    dcmDSSC_V.Clear();
                    dcmDSSC_V = null;

                    LogUtil.DebugLog("dcmDSSC_V.Clear() Finished.");
                }

                if (null != dcmDSC_SPS)
                {
                    //dcmDSC_SPS.Clear();
                    dcmDSC_SPS = null;

                    LogUtil.DebugLog("dcmDSC_SPS.Clear() Finished.");
                }

                if (null != dcmDSC_V)
                {
                    //dcmDSC_V.Clear();
                    dcmDSC_V = null;

                    LogUtil.DebugLog("dcmDSC_V.Clear() Finished.");
                }

                LogUtil.ErrorLog("Function.InitializDicomDataSetClassForResult() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Exit Function.InitializDicomDataSetClassForResult().");
            }
        }

        private DicomDataSets QueryMWL(string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStudyDate, string strStudyTime, string strStudyStatusID)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.QueryMWL(), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientID = " + strPatientID);
            LogUtil.DebugLog("PatientName = " + strPatientName);
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("Modality = " + strModality);
            LogUtil.DebugLog("StudyDate = " + strStudyDate);
            LogUtil.DebugLog("StudyTime = " + strStudyTime);
            LogUtil.DebugLog("StudyStatusID = " + strStudyStatusID);

            DicomQueryClass dcmQC = null;
            DicomDataSets dcmDSSReturn = null;
            DicomDataSet dcmDS = null;
            DicomDataSetClass dcmDSCResult = null;

            try
            {
                dcmQC = new DicomQueryClass();
                dcmDSCResult = new DicomDataSetClass();

                dcmQC.CallingAE = m_Config_WSProxy.M_MWLCallingAE.Trim();
                dcmQC.CalledAE = m_Config_WSProxy.M_MWLCalledAE.Trim();
                dcmQC.Node = m_Config_WSProxy.M_MWLNode.Trim();
                dcmQC.Port = Convert.ToInt32(m_Config_WSProxy.M_MWLPort.Trim());
                dcmQC.Root = "WORKLIST";

                InitializDicomDataSetClassForResult(dcmDSCResult,
                    strPatientID.Trim(),
                    strPatientName.Trim(),
                    strAccessionNumber.Trim(),
                    strModality.Trim(),
                    strStudyDate,
                    strStudyTime,
                    strStudyStatusID.Trim());

                dcmDSSReturn = dcmQC.DoRawQuery(dcmDSCResult);
            }
            catch (Exception ex)
            {
                if (null != dcmQC)
                {
                    //dcmQC.Clear();
                    dcmQC = null;
                }

                if (null != dcmDSSReturn)
                {
                    dcmDSSReturn.Clear();
                    dcmDSSReturn = null;
                }

                if (null != dcmDS)
                {
                    //dcmDS.Clear();
                    dcmDS = null;
                }

                if (null != dcmDSCResult)
                {
                    //dcmDSCResult.Clear();
                    dcmDSCResult = null;
                }

                LogUtil.ErrorLog("Function.QueryMWL() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Function.QueryMWL() Return = " + dcmDSSReturn.ToString());
                LogUtil.DebugLog("Exit Function.QueryMWL().");
            }

            return dcmDSSReturn;
        }

        public bool GetMWLExamInfo(string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStudyDate, string strStudyTime, string strStudyStatusID)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.GetMWLExamInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientID = " + strPatientID);
            LogUtil.DebugLog("PatientName = " + strPatientName);
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("Modality = " + strModality);
            LogUtil.DebugLog("StudyDate = " + strStudyDate);
            LogUtil.DebugLog("StudyTime = " + strStudyTime);
            LogUtil.DebugLog("StudyStatusID = " + strStudyStatusID);

            DicomDataSets dcmDSS = null;
            DicomDataSet dcmDS = null;
            DicomDataSets dcmDSSItem = null;
            DicomDataSet dcmDSItem = null;
            CExamInfo cei = new CExamInfo();
            bool bReturn = false;

            try
            {
                dcmDSS = QueryMWL(strPatientID,
                    strPatientName,
                    strAccessionNumber,
                    strModality,
                    strStudyDate,
                    strStudyTime,
                    strStudyStatusID);

                FunctionInitializ();

                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                for (int i = 1; i <= dcmDSS.Count; i++)
                {
                    dcmDS = dcmDSS[i];
                    dcmDSSItem = (DicomObjects.DicomDataSets)dcmDS.Attributes[0x0040, 0x0100].Value;//ScheduledProcedureStepSequence
                    dcmDSItem = dcmDSSItem.Item[1];

                    cei.CExamInfoClear();
                    cei.strPatientID = dcmDS.Attributes[0x0010, 0x0020].Value.ToString();
                    cei.strAccessionNumber = dcmDS.Attributes[0x0008, 0x0050].Value.ToString();
                    cei.strNameEN = dcmDS.Attributes[0x0010, 0x0010].Value.ToString();
                    cei.strNameCN = "";
                    cei.strGender = dcmDS.Attributes[0x0010, 0x0040].Value.ToString();
                    cei.strBirthday = dcmDS.Attributes[0x0010, 0x0030].Value.ToString();
                    cei.strModality = dcmDSItem.Attributes[0x0008, 0x0060].Value.ToString();
                    cei.strModalityName = "";
                    cei.strPatientType = "";
                    cei.strVisitID = "";
                    cei.strRequestID = "";
                    cei.strRequestDepartment = "";
                    cei.strRequestDT = "";
                    cei.strRegisterDT = "";
                    cei.strExamDT = "";
                    cei.strSubmitDT = "";
                    cei.strApproveDT = "";
                    cei.strPDFReportURL = "";
                    cei.strStudyStatus = dcmDS.Attributes[0x0032, 0x000a].Value.ToString();
                    cei.strOptional0 = dcmDS.Attributes[0x0020, 0x000d].Value.ToString();//StudyInstanceUID
                    cei.strOptional1 = dcmDS.Attributes[0x0040, 0x1001].Value.ToString();//RequestedProcedureID
                    cei.strOptional2 = dcmDS.Attributes[0x0032, 0x1060].Value.ToString();//RequestedProcedureDescription
                    cei.strOptional3 = dcmDSItem.Attributes[0x0040, 0x0009].Value.ToString();//ScheduledProcedureStepID
                    cei.strOptional4 = dcmDSItem.Attributes[0x0040, 0x0007].Value.ToString();//ScheduledProcedureStepDescription
                    cei.strOptional5 = dcmDSItem.Attributes[0x0040, 0x0002].Value.ToString();//ScheduledProcedureStepStartDate
                    cei.strOptional6 = dcmDSItem.Attributes[0x0040, 0x0003].Value.ToString();//ScheduledProcedureStepStartTime
                    cei.strOptional7 = dcmDSItem.Attributes[0x0040, 0x0010].Value.ToString();//ScheduledStationName
                    cei.strOptional8 = "";
                    cei.strOptional9 = "";

                    LogUtil.DebugLog("Call Function.SetPSExamInfo().");

                    bReturn = SetPSExamInfo(cei);

                    LogUtil.DebugLog("Function.SetPSExamInfo() Return = " + bReturn.ToString());
                }
            }
            catch (Exception ex)
            {
                if (null != dcmDSS)
                {
                    dcmDSS.Clear();
                    dcmDSS = null;
                }

                if (null != dcmDS)
                {
                    //dcmDS.Clear();
                    dcmDS = null;
                }

                if (null != dcmDSSItem)
                {
                    dcmDSSItem.Clear();
                    dcmDSSItem = null;
                }

                if (null != dcmDSItem)
                {
                    //dcmDSItem.Clear();
                    dcmDSItem = null;
                }

                if (null != cei)
                {
                    cei.CExamInfoClear();
                    cei = null;
                }

                LogUtil.ErrorLog("Function.GetMWLExamInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                FunctionDispose();

                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                LogUtil.DebugLog("Function.GetMWLExamInfo() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit Function.GetMWLExamInfo().");
            }

            return bReturn;
        }

        /// <summary>
        /// Set print mode for specified study.
        /// </summary>
        /// <param name="strAccessionNumber">RIS Accession number. (required)</param>
        /// <param name="strStudyInstanceUID">RIS Study Instance UID. (optional)</param>
        /// <param name="iPrintMode">
        /// Default: print when both film and report are ready;
        /// 0: print when both film and report are ready;
        /// 1: print film only;
        /// 2: print report only;
        /// 3: print any available;
        /// 4: do not print. (required)
        /// </param>
        /// <returns>true or false.</returns>
        public bool SetPrintMode(string strAccessionNumber, string strStudyInstanceUID, int iPrintMode)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.SetPrintMode(), Input Parameter AS Follows:");
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("StudyInstanceUID = " + strStudyInstanceUID);
            LogUtil.DebugLog("PrintMode = " + iPrintMode.ToString());

            bool bReturn = true;
            int iWSReturn = 0;
            PS1000.PrintService wsPS1000 = null;
            NotifyService.NotifyService ns = null;
            try
            {
                LogUtil.DebugLog("PrintService.Url = " + m_Config_WSProxy.M_WSURL_PS);
                LogUtil.DebugLog("NotifyService.Url = " + m_Config_WSProxy.M_WSURL_NS);

                //0:success, -1:exception, -2:accession number is null or empty.
                if (m_Config_WSProxy.M_WSURL_PSOrNS == "0")
                {
                    LogUtil.DebugLog("Call PrintService.SetPrintMode(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
                    LogUtil.DebugLog("StudyInstanceUID = " + strStudyInstanceUID);
                    LogUtil.DebugLog("PrintMode = " + iPrintMode.ToString());

                    if (null == wsPS1000)
                    {
                        wsPS1000 = new PS1000.PrintService();
                    }
                    wsPS1000.Url = m_Config_WSProxy.M_WSURL_PS;
                    iWSReturn = wsPS1000.SetPrintMode(strAccessionNumber, strStudyInstanceUID, iPrintMode);
                    LogUtil.DebugLog("PrintService.SetPrintMode() Return = " + iWSReturn.ToString());
                }
                else if (m_Config_WSProxy.M_WSURL_PSOrNS == "1")
                {
                    LogUtil.DebugLog("Call NotifyService.SetPrintMode(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
                    LogUtil.DebugLog("StudyInstanceUID = " + strStudyInstanceUID);
                    LogUtil.DebugLog("PrintMode = " + iPrintMode.ToString());

                    if (null == ns)
                    {
                        ns = new NotifyService.NotifyService();
                    }
                    ns.Url = m_Config_WSProxy.M_WSURL_NS;
                    iWSReturn = ns.SetPrintMode(strAccessionNumber, strStudyInstanceUID, iPrintMode);
                    LogUtil.DebugLog("NotifyService.SetPrintMode() Return = " + iWSReturn.ToString());
                }

                if (0 != iWSReturn)
                {
                    bReturn = false;
                }
            }
            catch (Exception ex)
            {
                bReturn = false;

                LogUtil.ErrorLog("Function.SetPrintMode() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != wsPS1000)
                {
                    wsPS1000.Dispose();
                    wsPS1000 = null;
                }

                if (null != ns)
                {
                    ns.Dispose();
                    ns = null;
                }

                LogUtil.DebugLog("Function.SetPrintMode() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit Function.SetPrintMode().");
            }

            return bReturn;
        }

        /// <summary>
        /// Notify report information.
        /// </summary>
        /// <param name="strPatientName">Patient's chinese name. (optional)</param>
        /// <param name="strPatientID">Patient ID. (optional)</param>
        /// <param name="strAccessionNumber">RIS Accession number. (required)</param>
        /// <param name="strStudyInstanceUID">RIS Study Instance UID. (optional)</param>
        /// <param name="iReportStatus">RIS report status: 0-not ready, just update chinese name, 1-temp report, 2-formal report. (required)</param>
        /// <param name="strReportFileNameList">RIS Report URL(PDF file)</param>
        /// <returns>true or false.</returns>
        public bool NotifyReportInfo(string strPatientName, string strPatientID, string strAccessionNumber, string strStudyInstanceUID,
            int iReportStatus, string[] strReportFileNameList)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.NotifyReportInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("PatientName = " + strPatientName);
            LogUtil.DebugLog("PatientID = " + strPatientID);
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("StudyInstanceUID = " + strStudyInstanceUID);
            LogUtil.DebugLog("ReportStatus = " + iReportStatus.ToString());
            LogUtil.DebugLog("ReportFileNameList = " + strReportFileNameList.ToString());

            bool bReturn = true;
            int iWSReturn = 0;
            PS1000.PrintService wsPS1000 = null;
            NotifyService.NotifyService ns = null;

            try
            {
                LogUtil.DebugLog("PrintService.Url = " + m_Config_WSProxy.M_WSURL_PS);
                LogUtil.DebugLog("NotifyService.Url = " + m_Config_WSProxy.M_WSURL_NS);

                //0:success, 
                //-1:the temp report has been printed so can not be updated with temp report, 
                //-2:the formal report has been printed so that can not be updated, 
                //-3:unknown error, 
                //-4:Fail to download.
                if (m_Config_WSProxy.M_WSURL_PSOrNS == "0")
                {
                    LogUtil.DebugLog("Call PrintService.NotifyReportInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("PatientName = " + strPatientName);
                    LogUtil.DebugLog("PatientID = " + strPatientID);
                    LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
                    LogUtil.DebugLog("StudyInstanceUID = " + strStudyInstanceUID);
                    LogUtil.DebugLog("ReportStatus = " + iReportStatus.ToString());
                    LogUtil.DebugLog("ReportFileNameList = " + strReportFileNameList.ToString());

                    if (null == wsPS1000)
                    {
                        wsPS1000 = new PS1000.PrintService();
                    }
                    wsPS1000.Url = m_Config_WSProxy.M_WSURL_PS;
                    iWSReturn = wsPS1000.NotifyReportInfo(strPatientName, strPatientID, strAccessionNumber, strStudyInstanceUID, iReportStatus, strReportFileNameList);
                    LogUtil.DebugLog("PrintService.NotifyReportInfo() Return = " + iWSReturn.ToString());
                }
                else if (m_Config_WSProxy.M_WSURL_PSOrNS == "1")
                {
                    LogUtil.DebugLog("Call NotifyService.NotifyReportInfo(), Input Parameter AS Follows:");
                    LogUtil.DebugLog("PatientName = " + strPatientName);
                    LogUtil.DebugLog("PatientID = " + strPatientID);
                    LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
                    LogUtil.DebugLog("StudyInstanceUID = " + strStudyInstanceUID);
                    LogUtil.DebugLog("ReportStatus = " + iReportStatus.ToString());
                    LogUtil.DebugLog("ReportFileNameList = " + strReportFileNameList.ToString());

                    if (null == ns)
                    {
                        ns = new NotifyService.NotifyService();
                    }
                    ns.Url = m_Config_WSProxy.M_WSURL_NS;
                    iWSReturn = ns.NotifyReportInfo(strPatientName, strPatientID, strAccessionNumber, strStudyInstanceUID, iReportStatus, strReportFileNameList);
                    LogUtil.DebugLog("NotifyService.NotifyReportInfo() Return = " + iWSReturn.ToString());
                }
                if (0 != iWSReturn)
                {
                    bReturn = false;
                }
            }
            catch (Exception ex)
            {
                bReturn = false;

                LogUtil.ErrorLog("Function.NotifyReportInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != wsPS1000)
                {
                    wsPS1000.Dispose();
                    wsPS1000 = null;
                }

                if (null != ns)
                {
                    ns.Dispose();
                    ns = null;
                }

                LogUtil.DebugLog("Function.NotifyReportInfo() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit Function.NotifyReportInfo().");
            }

            return bReturn;
        }

        protected DataSet GetPSPrintMode(string strAccessionNumber, string strStudyInstanceUID)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.GetPSPrintMode(), Input Parameter AS Follows:");
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("StudyInstanceUID = " + strStudyInstanceUID);

            DataSet dsReturn = null;
            string strSQL = "";
            string strOutputInfo = "";

            try
            {
                FunctionInitializ();

                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForGetPSPrintMode;

                LogUtil.DebugLog("Call DAOMSSQLWSProxy.GetPSPrintMode(), Input Parameter AS Follows:");
                LogUtil.DebugLog("SQL = " + strSQL);
                LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
                LogUtil.DebugLog("StudyInstanceUID = " + strStudyInstanceUID);

                dsReturn = m_DAOMSSQLWSProxy.GetPSPrintMode(strSQL,
                    strAccessionNumber,
                    strStudyInstanceUID,
                    out strOutputInfo);

                LogUtil.DebugLog("DAOMSSQLWSProxy.GetPSPrintMode(), Output Parameter AS Follows:");
                LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                if (null == dsReturn)
                {
                    LogUtil.DebugLog("DAOMSSQLWSProxy.GetPSPrintMode() Return = null");
                }
                else
                {
                    LogUtil.DebugLog("DAOMSSQLWSProxy.GetPSPrintMode() Return = " + dsReturn.ToString());
                }
            }
            catch (Exception ex)
            {
                if (null != dsReturn)
                {
                    dsReturn.Dispose();
                    dsReturn = null;
                }

                LogUtil.ErrorLog("Function.GetPSPrintMode() Error Message = " + ex.ToString());
            }
            finally
            {
                FunctionDispose();

                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                LogUtil.DebugLog("Function.GetPSPrintMode() Return = DataSet.");
                LogUtil.DebugLog("Exit Function.GetPSPrintMode().");
            }

            return dsReturn;
        }

        protected DataSet GetPSReportInfo()
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.GetPSReportInfo().");

            DataSet dsReturn = null;
            string strSQL = "";
            string strOutputInfo = "";

            try
            {
                FunctionInitializ();

                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForGetPSReportInfo;

                LogUtil.DebugLog("Call DAOMSSQLWSProxy.GetPSReportInfo(), Input Parameter AS Follows:");
                LogUtil.DebugLog("SQL = " + strSQL);

                dsReturn = m_DAOMSSQLWSProxy.GetPSReportInfo(strSQL, out strOutputInfo);

                LogUtil.DebugLog("DAOMSSQLWSProxy.GetPSReportInfo(), Output Parameter AS Follows:");
                LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
                if (null == dsReturn)
                {
                    LogUtil.DebugLog("DAOMSSQLWSProxy.GetPSReportInfo() Return = null");
                }
                else
                {
                    LogUtil.DebugLog("DAOMSSQLWSProxy.GetPSReportInfo() Return = " + dsReturn.ToString());
                }
            }
            catch (Exception ex)
            {
                if (null != dsReturn)
                {
                    dsReturn.Dispose();
                    dsReturn = null;
                }

                LogUtil.ErrorLog("Function.GetPSReportInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                FunctionDispose();

                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                if (null == dsReturn)
                {
                    LogUtil.DebugLog("Function.GetPSReportInfo() Return = null");
                }
                else
                {
                    LogUtil.DebugLog("Function.GetPSReportInfo() Return = " + dsReturn.ToString());
                }
                LogUtil.DebugLog("Exit Function.GetPSReportInfo().");
            }

            return dsReturn;
        }

        protected bool SetPSExamInfo(CExamInfo cei)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.SetPSExamInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("ExamInfo = " + cei.ToString());

            bool bReturn = true;
            string strSQL = "";
            string strOutputInfo = "";

            try
            {
                FunctionInitializ();

                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForSetPSExamInfo;

                LogUtil.DebugLog("Call DAOMSSQLWSProxy.SetPSExamInfo(), Input Parameter AS Follows:");
                LogUtil.DebugLog("SQL = " + strSQL);
                LogUtil.DebugLog("PatientID = " + cei.strPatientID.Trim());
                LogUtil.DebugLog("AccessionNumber = " + cei.strAccessionNumber.Trim());
                LogUtil.DebugLog("StudyInstanceUID = " + cei.strStudyInstanceUID.Trim());
                LogUtil.DebugLog("NameEN = " + cei.strNameEN.Trim());
                LogUtil.DebugLog("NameCN = " + cei.strNameCN.Trim());
                LogUtil.DebugLog("Gender = " + cei.strGender.Trim());
                LogUtil.DebugLog("Birthday = " + cei.strBirthday.Trim());
                LogUtil.DebugLog("Modality = " + cei.strModality.Trim());
                LogUtil.DebugLog("ModalityName = " + cei.strModalityName.Trim());
                LogUtil.DebugLog("PatientType = " + cei.strPatientType.Trim());
                LogUtil.DebugLog("VisitID = " + cei.strVisitID.Trim());
                LogUtil.DebugLog("RequestID = " + cei.strRequestID.Trim());
                LogUtil.DebugLog("RequestDepartment = " + cei.strRequestDepartment.Trim());
                LogUtil.DebugLog("RequestDT = " + cei.strRequestDT.Trim());
                LogUtil.DebugLog("RegisterDT = " + cei.strRegisterDT.Trim());
                LogUtil.DebugLog("ExamDT = " + cei.strExamDT.Trim());
                LogUtil.DebugLog("SubmitDT = " + cei.strSubmitDT.Trim());
                LogUtil.DebugLog("ApproveDT = " + cei.strApproveDT.Trim());
                LogUtil.DebugLog("PDFReportURL = " + cei.strPDFReportURL.Trim());
                LogUtil.DebugLog("StudyStatus = " + cei.strStudyStatus.Trim());
                LogUtil.DebugLog("ReportStatus = " + cei.iReportStatus.ToString());
                LogUtil.DebugLog("PDFFlag = " + cei.iPDFFlag.ToString());
                LogUtil.DebugLog("VerifyFilmFlag = " + cei.iVerifyFilmFlag.ToString());
                LogUtil.DebugLog("VerifyReportFlag = " + cei.iVerifyReportFlag.ToString());
                LogUtil.DebugLog("FilmStoredFlag = " + cei.iFilmStoredFlag.ToString());
                LogUtil.DebugLog("ReportStoredFlag = " + cei.iReportStoredFlag.ToString());
                LogUtil.DebugLog("NotifyReportFlag = " + cei.iNotifyReportFlag.ToString());
                LogUtil.DebugLog("SetPrintModeFlag = " + cei.iSetPrintModeFlag.ToString());
                LogUtil.DebugLog("FilmPrintFlag = " + cei.iFilmPrintFlag.ToString());
                LogUtil.DebugLog("FilmPrintDoctor = " + cei.strFilmPrintDoctor.Trim());
                LogUtil.DebugLog("ReportPrintFlag = " + cei.iReportPrintFlag.ToString());
                LogUtil.DebugLog("ReportPrintDoctor = " + cei.strReportPrintDoctor.Trim());

                LogUtil.DebugLog("OutHospitalNo = " + cei.strOutHospitalNo.Trim());
                LogUtil.DebugLog("InHospital = " + cei.strInHospitalNo.Trim());
                LogUtil.DebugLog("PhsicalNumber = " + cei.strPhusicalNumber.Trim());
                LogUtil.DebugLog("ExamName = " + cei.strExamName.Trim());
                LogUtil.DebugLog("ExamBodyPart = " + cei.strExamBodyPart.Trim());

                LogUtil.DebugLog("Optional0 = " + cei.strOptional0.Trim());
                LogUtil.DebugLog("Optional1 = " + cei.strOptional1.Trim());
                LogUtil.DebugLog("Optional2 = " + cei.strOptional2.Trim());
                LogUtil.DebugLog("Optional3 = " + cei.strOptional3.Trim());
                LogUtil.DebugLog("Optional4 = " + cei.strOptional4.Trim());
                LogUtil.DebugLog("Optional5 = " + cei.strOptional5.Trim());
                LogUtil.DebugLog("Optional6 = " + cei.strOptional6.Trim());
                LogUtil.DebugLog("Optional7 = " + cei.strOptional7.Trim());
                LogUtil.DebugLog("Optional8 = " + cei.strOptional8.Trim());
                LogUtil.DebugLog("Optional9 = " + cei.strOptional9.Trim());

                m_DAOMSSQLWSProxy.SetPSExamInfo(strSQL,
                    cei.strPatientID.Trim(),
                    cei.strAccessionNumber.Trim(),
                    cei.strStudyInstanceUID.Trim(),
                    cei.strNameEN.Trim(),
                    cei.strNameCN.Trim(),
                    cei.strGender.Trim(),
                    cei.strBirthday.Trim(),
                    cei.strModality.Trim(),
                    cei.strModalityName.Trim(),
                    cei.strPatientType.Trim(),
                    cei.strVisitID.Trim(),
                    cei.strRequestID.Trim(),
                    cei.strRequestDepartment.Trim(),
                    cei.strRequestDT.Trim(),
                    cei.strRegisterDT.Trim(),
                    cei.strExamDT.Trim(),
                    cei.strSubmitDT.Trim(),
                    cei.strApproveDT.Trim(),
                    cei.strPDFReportURL.Trim(),
                    cei.strStudyStatus.Trim(),
                    cei.iReportStatus,
                    cei.iPDFFlag,
                    cei.iVerifyFilmFlag,
                    cei.iVerifyReportFlag,
                    cei.iFilmStoredFlag,
                    cei.iReportStoredFlag,
                    cei.iNotifyReportFlag,
                    cei.iSetPrintModeFlag,
                    cei.iFilmPrintFlag,
                    cei.strFilmPrintDoctor.Trim(),
                    cei.iReportPrintFlag,
                    cei.strReportPrintDoctor.Trim(),

                    cei.strOutHospitalNo.Trim(),
                    cei.strInHospitalNo.Trim(),
                    cei.strPhusicalNumber.Trim(),
                    cei.strExamName.Trim(),
                    cei.strExamBodyPart.Trim(),

                    cei.strOptional0.Trim(),
                    cei.strOptional1.Trim(),
                    cei.strOptional2.Trim(),
                    cei.strOptional3.Trim(),
                    cei.strOptional4.Trim(),
                    cei.strOptional5.Trim(),
                    cei.strOptional6.Trim(),
                    cei.strOptional7.Trim(),
                    cei.strOptional8.Trim(),
                    cei.strOptional9.Trim(),
                    out strOutputInfo);

                LogUtil.DebugLog("DAOMSSQLWSProxy.SetPSExamInfo(), Output Parameter AS Follows:");
                LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
            }
            catch (Exception ex)
            {
                bReturn = false;

                LogUtil.ErrorLog("Function.SetPSExamInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                FunctionDispose();

                LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                LogUtil.DebugLog("Function.SetPSExamInfo() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit Function.SetPSExamInfo().");
            }

            return bReturn;
        }

        protected bool SetPSExamInfoEx(CExamInfo cei)
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.SetPSExamInfoEx(), Input Parameter AS Follows:");
            LogUtil.DebugLog("ExamInfo = " + cei.ToString());

            bool bReturn = true;
            string strSQL = "";
            string strOutputInfo = "";

            try
            {
                FunctionInitializ();

                LogUtil.DebugLog("Call Function.FunctionInitializ() Finished.");

                strSQL = m_Config_WSProxy.M_SQLForSetPSExamInfo;

                LogUtil.DebugLog("Call DAOMSSQLWSProxy.SetPSExamInfo(), Input Parameter AS Follows:");
                LogUtil.DebugLog("SQL = " + strSQL);
                LogUtil.DebugLog("PatientID = " + cei.strPatientID.Trim());
                LogUtil.DebugLog("AccessionNumber = " + cei.strAccessionNumber.Trim());
                LogUtil.DebugLog("StudyInstanceUID = " + cei.strStudyInstanceUID.Trim());
                LogUtil.DebugLog("NameEN = " + cei.strNameEN.Trim());
                LogUtil.DebugLog("NameCN = " + cei.strNameCN.Trim());
                LogUtil.DebugLog("Gender = " + cei.strGender.Trim());
                LogUtil.DebugLog("Birthday = " + cei.strBirthday.Trim());
                LogUtil.DebugLog("Modality = " + cei.strModality.Trim());
                LogUtil.DebugLog("ModalityName = " + cei.strModalityName.Trim());
                LogUtil.DebugLog("PatientType = " + cei.strPatientType.Trim());
                LogUtil.DebugLog("VisitID = " + cei.strVisitID.Trim());
                LogUtil.DebugLog("RequestID = " + cei.strRequestID.Trim());
                LogUtil.DebugLog("RequestDepartment = " + cei.strRequestDepartment.Trim());
                LogUtil.DebugLog("RequestDT = " + cei.strRequestDT.Trim());
                LogUtil.DebugLog("RegisterDT = " + cei.strRegisterDT.Trim());
                LogUtil.DebugLog("ExamDT = " + cei.strExamDT.Trim());
                LogUtil.DebugLog("SubmitDT = " + cei.strSubmitDT.Trim());
                LogUtil.DebugLog("ApproveDT = " + cei.strApproveDT.Trim());
                LogUtil.DebugLog("PDFReportURL = " + cei.strPDFReportURL.Trim());
                LogUtil.DebugLog("StudyStatus = " + cei.strStudyStatus.Trim());
                LogUtil.DebugLog("ReportStatus = " + cei.iReportStatus.ToString());
                LogUtil.DebugLog("PDFFlag = " + cei.iPDFFlag.ToString());
                LogUtil.DebugLog("VerifyFilmFlag = " + cei.iVerifyFilmFlag.ToString());
                LogUtil.DebugLog("VerifyReportFlag = " + cei.iVerifyReportFlag.ToString());
                LogUtil.DebugLog("FilmStoredFlag = " + cei.iFilmStoredFlag.ToString());
                LogUtil.DebugLog("ReportStoredFlag = " + cei.iReportStoredFlag.ToString());
                LogUtil.DebugLog("NotifyReportFlag = " + cei.iNotifyReportFlag.ToString());
                LogUtil.DebugLog("SetPrintModeFlag = " + cei.iSetPrintModeFlag.ToString());
                LogUtil.DebugLog("FilmPrintFlag = " + cei.iFilmPrintFlag.ToString());
                LogUtil.DebugLog("FilmPrintDoctor = " + cei.strFilmPrintDoctor.Trim());
                LogUtil.DebugLog("ReportPrintFlag = " + cei.iReportPrintFlag.ToString());
                LogUtil.DebugLog("ReportPrintDoctor = " + cei.strReportPrintDoctor.Trim());

                LogUtil.DebugLog("OutHospitalNo = " + cei.strOutHospitalNo.Trim());
                LogUtil.DebugLog("InHospital = " + cei.strInHospitalNo.Trim());
                LogUtil.DebugLog("PhsicalNumber = " + cei.strPhusicalNumber.Trim());
                LogUtil.DebugLog("ExamName = " + cei.strExamName.Trim());
                LogUtil.DebugLog("ExamBodyPart = " + cei.strExamBodyPart.Trim());

                LogUtil.DebugLog("Optional0 = " + cei.strOptional0.Trim());
                LogUtil.DebugLog("Optional1 = " + cei.strOptional1.Trim());
                LogUtil.DebugLog("Optional2 = " + cei.strOptional2.Trim());
                LogUtil.DebugLog("Optional3 = " + cei.strOptional3.Trim());
                LogUtil.DebugLog("Optional4 = " + cei.strOptional4.Trim());
                LogUtil.DebugLog("Optional5 = " + cei.strOptional5.Trim());
                LogUtil.DebugLog("Optional6 = " + cei.strOptional6.Trim());
                LogUtil.DebugLog("Optional7 = " + cei.strOptional7.Trim());
                LogUtil.DebugLog("Optional8 = " + cei.strOptional8.Trim());
                LogUtil.DebugLog("Optional9 = " + cei.strOptional9.Trim());

                m_DAOMSSQLWSProxy.SetPSExamInfo(strSQL,
                    cei.strPatientID.Trim(),
                    cei.strAccessionNumber.Trim(),
                    cei.strStudyInstanceUID.Trim(),
                    cei.strNameEN.Trim(),
                    cei.strNameCN.Trim(),
                    cei.strGender.Trim(),
                    cei.strBirthday.Trim(),
                    cei.strModality.Trim(),
                    cei.strModalityName.Trim(),
                    cei.strPatientType.Trim(),
                    cei.strVisitID.Trim(),
                    cei.strRequestID.Trim(),
                    cei.strRequestDepartment.Trim(),
                    cei.strRequestDT.Trim(),
                    cei.strRegisterDT.Trim(),
                    cei.strExamDT.Trim(),
                    cei.strSubmitDT.Trim(),
                    cei.strApproveDT.Trim(),
                    cei.strPDFReportURL.Trim(),
                    cei.strStudyStatus.Trim(),
                    cei.iReportStatus,
                    cei.iPDFFlag,
                    cei.iVerifyFilmFlag,
                    cei.iVerifyReportFlag,
                    cei.iFilmStoredFlag,
                    cei.iReportStoredFlag,
                    cei.iNotifyReportFlag,
                    cei.iSetPrintModeFlag,
                    cei.iFilmPrintFlag,
                    cei.strFilmPrintDoctor.Trim(),
                    cei.iReportPrintFlag,
                    cei.strReportPrintDoctor.Trim(),

                    cei.strOutHospitalNo.Trim(),
                    cei.strInHospitalNo.Trim(),
                    cei.strPhusicalNumber.Trim(),
                    cei.strExamName.Trim(),
                    cei.strExamBodyPart.Trim(),

                    cei.strOptional0.Trim(),
                    cei.strOptional1.Trim(),
                    cei.strOptional2.Trim(),
                    cei.strOptional3.Trim(),
                    cei.strOptional4.Trim(),
                    cei.strOptional5.Trim(),
                    cei.strOptional6.Trim(),
                    cei.strOptional7.Trim(),
                    cei.strOptional8.Trim(),
                    cei.strOptional9.Trim(),
                    out strOutputInfo);

                LogUtil.DebugLog("DAOMSSQLWSProxy.SetPSExamInfo(), Output Parameter AS Follows:");
                LogUtil.DebugLog("OutputInfo = " + strOutputInfo);
            }
            catch (Exception ex)
            {
                bReturn = false;

                LogUtil.ErrorLog("Function.SetPSExamInfoEx() Error Message = " + ex.ToString());
            }
            finally
            {
                //FunctionDispose();

                //LogUtil.DebugLog("Call Function.FunctionDispose() Finished.");
                LogUtil.DebugLog("Function.SetPSExamInfoEx() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit Function.SetPSExamInfoEx().");
            }

            return bReturn;
        }

        public bool NotifyStudyInfo(string strAccessionNumber, string strStudyInstanceUID, int iStudyType, int iStatus)
        {
            #region annotation

            //1 Assignment Operator From InParam To CExamInfo;
            //2 Call GetPSPrintMode() By AccessionNumber;
            //3 Call PS1000.SetPrintMode();
            //4 Call SetPSExamInfo() By CExamInfo.

            #endregion annotation

            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter Function.NotifyStudyInfo(), Input Parameter AS Follows:");
            LogUtil.DebugLog("AccessionNumber = " + strAccessionNumber);
            LogUtil.DebugLog("StudyInstanceUID = " + strStudyInstanceUID);
            LogUtil.DebugLog("StudyType = " + iStudyType.ToString());
            LogUtil.DebugLog("Status = " + iStatus.ToString());

            bool bReturn = true;
            CExamInfo cei = new CExamInfo();
            DataSet dsPrintMode = null;
            int iPrintMode = 0;
            int iSetPrintModeFlag = 0;

            try
            {
                //1 Assignment Operator From InParam To CExamInfo;
                cei.CExamInfoClear();
                cei.strAccessionNumber = strAccessionNumber;
                cei.strStudyInstanceUID = strStudyInstanceUID;

                //Status: 0-unprinted,1-Printed,2-do not need to printed,3-printing,9-stored.
                //StudyType: 1-Film, 2-Report.
                if (9 == iStatus)   // stored
                {
                    if (1 == iStudyType)
                    {
                        cei.iFilmStoredFlag = iStatus;
                    }
                    else if (2 == iStudyType)
                    {
                        cei.iReportStoredFlag = iStatus;
                    }

                    //2 Call GetPSPrintMode() By AccessionNumber;
                    LogUtil.DebugLog("Call Function.GetPSPrintMode().");

                    dsPrintMode = GetPSPrintMode(cei.strAccessionNumber, cei.strStudyInstanceUID);

                    if (null == dsPrintMode)
                    {
                        LogUtil.DebugLog("Function.GetPSPrintMode() Return = null");
                    }
                    else if (null != dsPrintMode & 0 < dsPrintMode.Tables[0].Rows.Count)
                    {
                        LogUtil.DebugLog("Function.GetPSPrintMode() Return = DataSet.");

                        iPrintMode = Convert.ToInt32(dsPrintMode.Tables[0].Rows[0]["PrintMode"].ToString());
                        iSetPrintModeFlag = Convert.ToInt32(dsPrintMode.Tables[0].Rows[0]["SetPrintModeFlag"].ToString());
                        LogUtil.DebugLog("Field SetPrintModeFlag value = " + iSetPrintModeFlag.ToString());
                        //if (1 != iSetPrintModeFlag)
                        //{
                            //3 Call PS1000.SetPrintMode();
                            LogUtil.DebugLog("Call Function.SetPrintMode().");

                            bReturn = SetPrintMode(cei.strAccessionNumber, cei.strStudyInstanceUID, iPrintMode);

                            LogUtil.DebugLog("Function.SetPrintMode() Return = " + bReturn.ToString());

                            if (bReturn)
                            {
                                cei.iSetPrintModeFlag = 1;
                            }
                        //}
                    }
                }
                else if (-10 == iStatus)
                {
                    if (1 == iStudyType)
                    {
                        cei.iFilmStoredFlag = -10;          // 解除胶片归档关系
                    }
                    else if (2 == iStudyType)
                    {
                        cei.iReportStoredFlag = -10;
                    }
                }
                else
                {
                    if (1 == iStudyType)
                    {
                        cei.iFilmPrintFlag = iStatus;
                    }
                    else if (2 == iStudyType)
                    {
                        cei.iReportPrintFlag = iStatus;
                    }
                }

                //4 Call SetPSExamInfo() By CExamInfo.
                LogUtil.DebugLog("Call Function.SetPSExamInfo().");

                bReturn = SetPSExamInfo(cei);

                LogUtil.DebugLog("Function.SetPSExamInfo() Return = " + bReturn.ToString());
            }
            catch (Exception ex)
            {
                bReturn = false;

                LogUtil.ErrorLog("Function.NotifyStudyInfo() Error Message = " + ex.ToString());
            }
            finally
            {
                cei.CExamInfoClear();

                LogUtil.DebugLog("Function.NotifyStudyInfo() Return = " + bReturn.ToString());
                LogUtil.DebugLog("Exit Function.NotifyStudyInfo().");
            }

            return bReturn;
        }
    }
}