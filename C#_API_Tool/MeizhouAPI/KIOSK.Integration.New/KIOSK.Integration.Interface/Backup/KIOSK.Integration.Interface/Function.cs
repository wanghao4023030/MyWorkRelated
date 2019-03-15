using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using System.Text;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;

using KIOSK.Integration.Config;
using KIOSK.Integration.Log;
using KIOSK.Integration.Util;
using KIOSK.Integration.Util.DAO;

namespace KIOSK.Integration.Interface
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

            LogUtil.DebugLog("XSLTPathForQueryExamInfo = " + m_Config_WSProxy.M_XSLTPathForQueryExamInfo);
            LogUtil.DebugLog("XSLTPathForUpdateExamInfo = " + m_Config_WSProxy.M_XSLTPathForUpdateExamInfo);
            LogUtil.DebugLog("PDFPhysicPath = " + m_Config_WSProxy.M_PDFPhysicPath);
            LogUtil.DebugLog("PDFFTPPath = " + m_Config_WSProxy.M_PDFFTPPath);

            LogUtil.DebugLog("WSURLForPS = " + m_Config_WSProxy.M_WSURL_PS);
            LogUtil.DebugLog("WSURLForRISExamInfo = " + m_Config_WSProxy.M_WSURL_RISExamInfo);
            LogUtil.DebugLog("WSURLForRISPDFReportInfo = " + m_Config_WSProxy.M_WSURL_RISPDFReportInfo);
            LogUtil.DebugLog("WSURLForRISOtherInfo = " + m_Config_WSProxy.M_WSURL_RISOtherInfo);

            LogUtil.DebugLog("SQLForGetRISReportInfo = " + m_Config_WSProxy.M_SQLForGetRISReportInfo);
            LogUtil.DebugLog("SQLForSetRISReportInfo = " + m_Config_WSProxy.M_SQLForSetRISReportInfo);
            LogUtil.DebugLog("SQLForGetRISExamInfo = " + m_Config_WSProxy.M_SQLForGetRISExamInfo);

            LogUtil.DebugLog("SQLForSetPSExamInfo = " + m_Config_WSProxy.M_SQLForSetPSExamInfo);
            LogUtil.DebugLog("SQLForGetPSExamInfo = " + m_Config_WSProxy.M_SQLForGetPSExamInfo);
            LogUtil.DebugLog("SQLForGetPSPrintMode = " + m_Config_WSProxy.M_SQLForGetPSPrintMode);
            LogUtil.DebugLog("SQLForGetPSPatientInfo = " + m_Config_WSProxy.M_SQLForGetPSPatientInfo);
            LogUtil.DebugLog("SQLForUpdateTerminalInfo = " + m_Config_WSProxy.M_SQLForUpdateTerminalInfo);
            LogUtil.DebugLog("GetReportType = " + m_Config_WSProxy.M_iGetReportType.ToString());

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
    }
}