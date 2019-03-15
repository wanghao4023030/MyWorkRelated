using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;

using KIOSK.Integration.Log;
using KIOSK.Integration.Util;
using KIOSK.Integration.Util.DAO;


namespace KIOSK.Integration.HL7.WinForm
{
    public class CDataBaseCtrl
    {
        private string m_DBStyle;
        public string M_DBStyle
        {
            get
            {
                return m_DBStyle;
            }
            set
            {
                M_DBStyle = value;
            }
        }

        private string m_DBName;
        public string M_DBName
        {
            get
            {
                return m_DBName;
            }
            set
            {
                m_DBName = value;
            }
        }

        private string m_DBAddress;
        public string M_DBAddress
        {
            get
            {
                return m_DBAddress;
            }
            set
            {
                m_DBAddress = value;
            }
        }

        private string m_DBUser;
        public string M_DBUser
        {
            get
            {
                return m_DBUser;
            }
            set
            {
                m_DBUser = value;
            }
        }

        private string m_DBPassword;
        public string M_DBPassword
        {
            get
            {
                return m_DBPassword;
            }
            set
            {
                m_DBPassword = value;
            }
        }

        private string m_strDBConn = "";
        //********************MSSQL RIS********************
        public DBConnectionMSSQL m_DBConnectionMSSQLRIS = null;
        public SqlConnection m_SQLConRIS = null;
        public SqlTransaction m_SQLTraRIS = null;
        public DAOMSSQLWSProxy m_DAOMSSQLRIS = null;

        public void InitDBConnection()
        {
            try
            {
                if (null == m_DBConnectionMSSQLRIS)
                {
                    m_DBConnectionMSSQLRIS = new DBConnectionMSSQL();
                    m_DBConnectionMSSQLRIS.InitStrDBCon(m_DBAddress, m_DBName, m_DBUser, m_DBPassword);
                }
                if (null == m_SQLConRIS)
                {
                    m_SQLConRIS = m_DBConnectionMSSQLRIS.OpenSQLCon();
                }
                if (null == m_DAOMSSQLRIS)
                {
                    m_DAOMSSQLRIS = new DAOMSSQLWSProxy(m_SQLConRIS, m_SQLTraRIS);
                }
            }
            catch (System.Exception ex)
            {
                LogUtil.DebugLog("InitDatabase conn error,meaage = " + ex.ToString());
            }            
        }

        public SqlConnection OpenSQLCon()
        {
            m_SQLConRIS = new SqlConnection(m_strDBConn);
            m_SQLConRIS.Open();
            return m_SQLConRIS;
        }

        public void CloseSQLCon(SqlConnection scSQLCon)
        {
            if (null != scSQLCon)
            {
                scSQLCon.Dispose();
                scSQLCon.Close();
            }
        }
    }
}
