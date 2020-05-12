using System;
using System.CodeDom;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Data;
using System.Data.OracleClient;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.Serialization;
using System.Reflection;
using System.Text;
using System.Windows.Forms;
using Microsoft.CSharp;

using DicomObjects;
using MySql.Data;
using MySql.Data.MySqlClient;

using KIOSK.Integration.Config;
using KIOSK.Integration.Log;
using KIOSK.Integration.Util;
using KIOSK.Integration.Util.DAO;

namespace KIOSK.Integration.WinForm.Tool
{
    public class Function
    {
        #region variable definition

        /// <summary>
        /// Reads or writes the config information of KIOSK.Integration.WSProxy.
        /// </summary>
        public Config_WSProxy m_Config_WSProxy = null;

        /// <summary>
        /// The config information of KIOSK.Integration.WSProxy.
        /// </summary>
        public ConfigXML_WSProxy m_ConfigXML_WSProxy = null;

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

        #endregion

        public Function()
        {
            LoadConfigAndInitializLogUtil();
        }

        public void LoadConfigAndInitializLogUtil()
        {
            string strCurrentPath = "";
            string strCurrentPathParent = "";
            string strConfigFileName = "";

            try
            {
                // Get filename of config.
                strCurrentPath = AppDomain.CurrentDomain.BaseDirectory;
                strCurrentPathParent = strCurrentPath.Substring(0, strCurrentPath.LastIndexOf("\\", strCurrentPath.Length - 2) + 1);
                strConfigFileName = Path.Combine(strCurrentPath, KIOSKIntegrationConst.KIOSK_INTEGRATION_CONFIG_FILE);

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
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        public void FunctionInitializ(string strDBType, string strDBServer, string strDBName,
            string strUserName, string strPassword)
        {
            try
            {
                if ("MYSQL" == strDBType)
                {
                    if (null == m_DBConnectionMySQLRIS)
                    {
                        m_DBConnectionMySQLRIS = new DBConnectionMySQL();
                        m_DBConnectionMySQLRIS.InitStrDBCon(strDBServer, strDBName, strUserName, strPassword);
                    }

                    if (null == m_MySQLConRIS)
                    {
                        m_MySQLConRIS = m_DBConnectionMySQLRIS.OpenMySQLCon();
                    }

                    if (null == m_DAOMySQLRIS)
                    {
                        m_DAOMySQLRIS = new DAOMySQLRIS(m_MySQLConRIS, m_MySQLTraRIS);
                    }
                }
                else if ("ORACLE" == strDBType)
                {
                    if (null == m_DBConnectionOracleRIS)
                    {
                        m_DBConnectionOracleRIS = new DBConnectionOracle();
                        m_DBConnectionOracleRIS.InitStrDBCon(strDBServer, strDBName, strUserName, strPassword);
                    }

                    if (null == m_OracleConRIS)
                    {
                        m_OracleConRIS = m_DBConnectionOracleRIS.OpenOraCon();
                    }

                    if (null == m_DAOORACLERIS)
                    {
                        m_DAOORACLERIS = new DAOORACLERIS(m_OracleConRIS, m_OracleTraRIS);
                    }
                }
                else
                {
                    if (null == m_DBConnectionMSSQLRIS)
                    {
                        m_DBConnectionMSSQLRIS = new DBConnectionMSSQL();
                        m_DBConnectionMSSQLRIS.InitStrDBCon(strDBServer, strDBName, strUserName, strPassword);
                    }

                    if (null == m_SQLConRIS)
                    {
                        m_SQLConRIS = m_DBConnectionMSSQLRIS.OpenSQLCon();
                    }

                    if (null == m_DAOMSSQLRIS)
                    {
                        m_DAOMSSQLRIS = new DAOMSSQLRIS(m_SQLConRIS, m_SQLTraRIS);
                    }
                }
            }
            catch (Exception ex)
            {
                FunctionDispose();

                MessageBox.Show(ex.ToString());
            }
        }

        public virtual void FunctionDispose()
        {
            try
            {
                //********************MySQL RIS********************

                if (null != m_DBConnectionMySQLRIS)
                {
                    m_DBConnectionMySQLRIS.CloseMySQLCon(m_MySQLConRIS);
                    m_DBConnectionMySQLRIS = null;
                }

                if (null != m_MySQLTraRIS)
                {
                    m_MySQLTraRIS.Dispose();
                    m_MySQLTraRIS = null;
                }

                if (null != m_MySQLConRIS)
                {
                    m_MySQLConRIS.Dispose();
                    m_MySQLConRIS = null;
                }

                if (null != m_DAOMySQLRIS)
                {
                    m_DAOMySQLRIS = null;
                }

                //********************Oracle RIS********************

                if (null != m_DBConnectionOracleRIS)
                {
                    m_DBConnectionOracleRIS.CloseOraCon(m_OracleConRIS);
                    m_DBConnectionOracleRIS = null;
                }

                if (null != m_OracleTraRIS)
                {
                    m_OracleTraRIS.Dispose();
                    m_OracleTraRIS = null;
                }

                if (null != m_OracleConRIS)
                {
                    m_OracleConRIS.Dispose();
                    m_OracleConRIS = null;
                }

                if (null != m_DAOORACLERIS)
                {
                    m_DAOORACLERIS = null;
                }

                //********************MSSQL RIS********************

                if (null != m_DBConnectionMSSQLRIS)
                {
                    m_DBConnectionMSSQLRIS.CloseSQLCon(m_SQLConRIS);
                    m_DBConnectionMSSQLRIS = null;
                }

                if (null != m_SQLTraRIS)
                {
                    m_SQLTraRIS.Dispose();
                    m_SQLTraRIS = null;
                }

                if (null != m_SQLConRIS)
                {
                    m_SQLConRIS.Dispose();
                    m_SQLConRIS = null;
                }

                if (null != m_DAOMSSQLRIS)
                {
                    m_DAOMSSQLRIS = null;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        public void DataSetToListView(ListView lv, DataSet ds)
        {
            try
            {
                lv.Clear();
                lv.Columns.Clear();

                lv.GridLines = true;
                lv.FullRowSelect = true;
                lv.MultiSelect = false;
                lv.Scrollable = true;
                lv.View = View.Details;
                lv.HeaderStyle = ColumnHeaderStyle.Clickable;

                if (ds != null)
                {
                    int iRowCount = ds.Tables[0].Rows.Count;
                    int iColumnCount = ds.Tables[0].Columns.Count;

                    lv.Clear();
                    //为listview添加columnname
                    for (int i = 0; i < iColumnCount; i++)
                    {
                        string strColumnName = ds.Tables[0].Columns[i].ColumnName;
                        lv.Columns.Add(strColumnName, 100, HorizontalAlignment.Center);
                    }

                    //循环每一行
                    for (int i = 0; i < iRowCount; i++)
                    {
                        string strItemName = ds.Tables[0].Rows[i][0].ToString();

                        ListViewItem lvItem = new ListViewItem(strItemName, i);

                        //循环每一列
                        for (int j = 1; j < iColumnCount; j++)
                        {
                            lvItem.SubItems.Add(ds.Tables[0].Rows[i][j].ToString());
                        }

                        //将整理好的item加入到listview
                        lv.Items.Add(lvItem);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        public void DicomDataSetsToListView(ListView lv, DicomDataSets dcmDSS)
        {
            try
            {
                lv.Clear();
                lv.Columns.Clear();

                lv.GridLines = true;
                lv.FullRowSelect = true;
                lv.MultiSelect = false;
                lv.Scrollable = true;
                lv.View = View.Details;
                lv.HeaderStyle = ColumnHeaderStyle.Clickable;

                //Patient
                lv.Columns.Add("0x0010, 0x0010", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x0020", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x0030", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x0032", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x1000", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x1001", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x0040", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x1030", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0040, 0x3001", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0038, 0x0500", 100, HorizontalAlignment.Center);
                //lv.Columns.Add("0x0010, 0x21C0", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x2000", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x2110", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0038, 0x0050", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x1010", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x1020", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x2160", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x2180", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0010, 0x21B0", 100, HorizontalAlignment.Center);
                //Scheduled Procedure Step
                lv.Columns.Add("0x0040, 0x0001", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0040, 0x0002", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0040, 0x0003", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0008, 0x0060", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0040, 0x0006", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0040, 0x0007", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0040, 0x0010", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0040, 0x0011", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0040, 0x0012", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0040, 0x0009", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0032, 0x1070", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0040, 0x0020", 100, HorizontalAlignment.Center);
                //Visit
                lv.Columns.Add("0x0038, 0x0010", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0038, 0x0300", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0008, 0x1150", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0008, 0x1155", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0038, 0x0008", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0038, 0x0400", 100, HorizontalAlignment.Center);
                //Image Service Request
                lv.Columns.Add("0x0008, 0x0050", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0032, 0x1032", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0008, 0x0090", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0032, 0x1033", 100, HorizontalAlignment.Center);
                //Other for Agfa MWL
                lv.Columns.Add("0x0008, 0x0005", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0020, 0x000d", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0032, 0x000a", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0032, 0x1060", 100, HorizontalAlignment.Center);
                lv.Columns.Add("0x0040, 0x1001", 100, HorizontalAlignment.Center);

                if (null != dcmDSS)
                {
                    for (int i = 1; i <= dcmDSS.Count; i++)
                    {
                        if (null != dcmDSS[i])
                        {
                            DicomDataSets dcmDSSItem = null;
                            DicomDataSet dcmDSItem = null;

                            ListViewItem lvItem = new ListViewItem();

                            //Patient
                            lvItem.Text = dcmDSS[i].Attributes[0x0010, 0x0010].Value.ToString(); //PatientsName
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x0020].Value.ToString());//PatientID
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x0030].Value.ToString());//PatientsBirthDate
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x0032].Value.ToString());//PatientsBirthTime
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x1000].Value.ToString());//OtherPatientIDs
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x1001].Value.ToString());//OtherPatientNames
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x0040].Value.ToString());//PatientsSex
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x1030].Value.ToString());//PatientsWeight
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0040, 0x3001].Value.ToString());//ConfidentialityConstraintOnPatientDataDescription
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0038, 0x0500].Value.ToString());//PatientState
                            //lviWorklist.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x21C0].Value.ToString());//PregnancyStatus
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x2000].Value.ToString());//MedicalAlerts
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x2110].Value.ToString());//ContrasAllergies
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0038, 0x0050].Value.ToString());//SpecialNeeds
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x1010].Value.ToString());//PatientsAge
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x1020].Value.ToString());//PatientsSize
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x2160].Value.ToString());//EthnicGroup
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x2180].Value.ToString());//Occupation
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0010, 0x21B0].Value.ToString());//AdditionalPatientHistory
                            //Scheduled Procedure Step
                            dcmDSSItem = (DicomObjects.DicomDataSets)dcmDSS[i].Attributes[0x0040, 0x0100].Value;//ScheduledProcedureStepSequence
                            dcmDSItem = dcmDSSItem.Item[1];
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0040, 0x0001].Value.ToString());//ScheduledStationAETitle
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0040, 0x0002].Value.ToString());//ScheduledProcedureStepStartDate
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0040, 0x0003].Value.ToString());//ScheduledProcedureStepStartTime
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0008, 0x0060].Value.ToString());//Modality
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0040, 0x0006].Value.ToString());//ScheduledPerformingPhysiciansName
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0040, 0x0007].Value.ToString());//ScheduledProcedureStepDescription
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0040, 0x0010].Value.ToString());//ScheduledStationName
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0040, 0x0011].Value.ToString());//ScheduledProcedureStepLocation
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0040, 0x0012].Value.ToString());//PreMedication
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0040, 0x0009].Value.ToString());//ScheduledProcedureStepID
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0032, 0x1070].Value.ToString());//RequestContrastAgent
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0040, 0x0020].Value.ToString());//ScheduledProcedureStepStatus
                            //Visit
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0038, 0x0010].Value.ToString());//AdmissionID
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0038, 0x0300].Value.ToString());//CurrentPatientLocation
                            dcmDSSItem = (DicomObjects.DicomDataSets)dcmDSS[i].Attributes[0x0008, 0x1120].Value;//ReferencedPatientSequence
                            dcmDSItem = dcmDSSItem.Item[1];
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0008, 0x1150].Value.ToString());//ReferencedSOPClassUID
                            lvItem.SubItems.Add(dcmDSItem.Attributes[0x0008, 0x1155].Value.ToString());//ReferencedSOPInstanceUID
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0038, 0x0008].Value.ToString());//VisitStatusID
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0038, 0x0400].Value.ToString());//PatientsInstitutionResidence
                            //Image Service Request
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0008, 0x0050].Value.ToString());//AccessionNumber
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0032, 0x1032].Value.ToString());//RequestingPhysician
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0008, 0x0090].Value.ToString());//RequestingPhysicianName
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0032, 0x1033].Value.ToString());//RequestingService
                            //Other for Agfa MWL
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0008, 0x0005].Value.ToString());// CS,10,SpecificCharacterSet	"ISO_IR 100"
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0020, 0x000d].Value.ToString());// UI,56,StudyInstanceUID	"1.2.124.113532.58911.5035.4019.20131212.75501.471169331"
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0032, 0x000a].Value.ToString());// CS,10,StudyStatusID	"COMPLETED "
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0032, 0x1060].Value.ToString());// LO,16,RequestedProcedureDescription	"Upper-Abdomen C "
                            lvItem.SubItems.Add(dcmDSS[i].Attributes[0x0040, 0x1001].Value.ToString());// SH,10,RequestedProcedureID	"R00819242 

                            lv.Items.Add(lvItem);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        public DataSet ExcuteSQL(string strDBType,string strDBServer, string strDBName,
            string strUserName, string strPassword, string strSQL)
        {
            DataSet dsReturn = null;

            try
            {
                FunctionInitializ(strDBType, strDBServer, strDBName, strUserName, strPassword);

                if ("MYSQL" == strDBType)
                {
                    dsReturn = m_DAOMySQLRIS.M_DBUtilMySQL.ExecuteDataSet(strSQL);
                }
                else if ("ORACLE" == strDBType)
                {
                    dsReturn = m_DAOORACLERIS.M_DBUtilOracle.ExecuteDataSet(strSQL);
                }
                else
                {
                    dsReturn = m_DAOMSSQLRIS.M_DBUtilMSSQL.ExecuteDataSet(strSQL);
                }
            }
            catch (Exception ex)
            {
                if (null != dsReturn)
                {
                    dsReturn.Dispose();
                    dsReturn = null;
                }

                MessageBox.Show(ex.ToString());
            }
            finally
            {
                FunctionDispose();
            }

            return dsReturn;
        }

        public void InitializDicomDataSetClassForResult(DicomDataSetClass dcmDSC, string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStudyDate, string strStudyTime, string strStudyStatusID)
        {
            DicomObjects.DicomDataSetsClass dcmDSSC_SPS = new DicomDataSetsClass();
            DicomObjects.DicomDataSetsClass dcmDSSC_V = new DicomDataSetsClass();
            DicomObjects.DicomDataSetClass dcmDSC_SPS = new DicomDataSetClass();
            DicomObjects.DicomDataSetClass dcmDSC_V = new DicomDataSetClass();

            try
            {
                //Patient
                dcmDSC.Attributes.Add(0x0010, 0x0010, strPatientID);
                dcmDSC.Attributes.Add(0x0010, 0x0020, strPatientName);
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
                }

                if (null != dcmDSSC_V)
                {
                    dcmDSSC_V.Clear();
                    dcmDSSC_V = null;
                }

                if (null != dcmDSC_SPS)
                {
                    //dcmDSC_SPS.Clear();
                    dcmDSC_SPS = null;
                }

                if (null != dcmDSC_V)
                {
                    //dcmDSC_V.Clear();
                    dcmDSC_V = null;
                }

                MessageBox.Show(ex.ToString());
            }
        }

        public DicomDataSets QueryMWL(string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStudyDate, string strStudyTime, string strStudyStatusID)
        {
            DicomQueryClass dcmQC = null;
            DicomDataSets dcmDSSReturn = null;
            DicomDataSetClass dcmDSCResult = null;

            try
            {
                dcmDSCResult = new DicomDataSetClass();
                InitializDicomDataSetClassForResult(dcmDSCResult,
                    strPatientID.Trim(),
                    strPatientName.Trim(),
                    strAccessionNumber.Trim(),
                    strModality.Trim(),
                    strStudyDate,
                    strStudyTime,
                    strStudyStatusID.Trim());

                dcmQC = new DicomQueryClass();
                dcmQC.CallingAE = m_Config_WSProxy.M_MWLCallingAE.Trim();
                dcmQC.CalledAE = m_Config_WSProxy.M_MWLCalledAE.Trim();
                dcmQC.Node = m_Config_WSProxy.M_MWLNode.Trim();
                dcmQC.Port = Convert.ToInt32(m_Config_WSProxy.M_MWLPort.Trim());
                dcmQC.Root = "WORKLIST";

                dcmDSSReturn = dcmQC.DoRawQuery(dcmDSCResult);
            }
            catch (Exception ex)
            {
                if (null != dcmDSSReturn)
                {
                    dcmDSSReturn.Clear();
                    dcmDSSReturn = null;
                }

                MessageBox.Show(ex.ToString());
            }
            finally
            {
                if (null != dcmQC)
                {
                    //dcmQC.Clear();
                    dcmQC = null;
                }

                if (null != dcmDSCResult)
                {
                    //dcmDSCResult.Clear();
                    dcmDSCResult = null;
                }
            }

            return dcmDSSReturn;
        }
    }
}