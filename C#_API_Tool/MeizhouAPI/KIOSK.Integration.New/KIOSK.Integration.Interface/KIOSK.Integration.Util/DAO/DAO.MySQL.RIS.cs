using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace KIOSK.Integration.Util.DAO
{
    public class DAOMySQLRIS
    {
        /// <summary>
        /// Database connection.
        /// </summary>
        private MySqlConnection m_MySqlCon;

        /// <summary>
        /// Gets or sets the database connection for MySQL.
        /// </summary>
        /// <value>The database connection.</value>
        public MySqlConnection M_MySqlCon
        {
            get
            {
                return m_MySqlCon;
            }
            set
            {
                m_MySqlCon = value;
            }
        }

        /// <summary>
        /// Database transaction.
        /// </summary>
        private MySqlTransaction m_MySqlTran;

        /// <summary>
        /// Gets or sets the database transaction for MySQL.
        /// </summary>
        /// <value>The database transaction.</value>
        public MySqlTransaction M_MySqlTran
        {
            get
            {
                return m_MySqlTran;
            }
            set
            {
                m_MySqlTran = value;
            }
        }

        /// <summary>
        /// ADO.Net tools class.
        /// </summary>
        private DBUtilMySQL m_DBUtilMySQL;

        /// <summary>
        /// Gets or sets the DBUtil for MSSQL.
        /// </summary>
        /// <value>The DBUtil.</value>
        public DBUtilMySQL M_DBUtilMySQL
        {
            get
            {
                return m_DBUtilMySQL;
            }
            set
            {
                m_DBUtilMySQL = value;
            }
        }

        /// <summary>
        /// Construct function.
        /// You must input database connection and database transaction,
        /// when new this class.so this construct function is privated.
        /// </summary>
        private DAOMySQLRIS()
        {
        }

        /// <summary>
        /// Construct function.
        /// </summary>
        /// <param name="scMySqlCon">Database connection</param>
        /// <param name="stMySqlTra">Database transaction</param>
        public DAOMySQLRIS(MySqlConnection scMySqlCon, MySqlTransaction stMySqlTra)
        {
            M_MySqlCon = scMySqlCon;
            M_MySqlTran = stMySqlTra;

            M_DBUtilMySQL = new DBUtilMySQL(M_MySqlCon, M_MySqlTran);
        }

        public DataSet GetRISExamInfo(string strSQL, string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStartDT, string strEndDT, out string strOutputInfo)
        {
            DataSet dsReturn = null;
            strOutputInfo = "";

            strSQL = string.Format(strSQL,
                strPatientID,
                strPatientID,
                strPatientName,
                strPatientName,
                strPatientName,
                strAccessionNumber,
                strAccessionNumber,
                strModality,
                strModality,
                strModality,
                strStartDT,
                strStartDT,
                strEndDT,
                strEndDT,
                strPatientID,
                strPatientName,
                strAccessionNumber,
                strModality,
                strStartDT,
                strEndDT);

            try
            {
                dsReturn = M_DBUtilMySQL.ExecuteDataSet(strSQL);
                strOutputInfo = "M_DBUtilMySQL.ExecuteDataSet():Success; SQL=" + strSQL;
            }
            catch (Exception ex)
            {
                if (null != dsReturn)
                {
                    dsReturn.Dispose();
                    dsReturn = null;
                }
                strOutputInfo = ex.ToString();
            }

            return dsReturn;
        }

        public DataSet GetRISReportInfo(string strSQL, string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strReportID, string strReportStatus, 
            out string strOutputInfo, out string strReportURL)
        {
            DataSet dsReturn = null;
            strOutputInfo = "";
            strReportURL = "";

            strSQL = string.Format(strSQL,
                strPatientID,
                strPatientID,
                strPatientName,
                strPatientName,
                strPatientName,
                strAccessionNumber,
                strAccessionNumber,
                strModality,
                strModality,
                strModality,
                strReportID,
                strReportID,
                strReportStatus,
                strReportStatus,
                strPatientID,
                strPatientName,
                strAccessionNumber,
                strModality,
                strReportID,
                strReportStatus);

            try
            {
                dsReturn = M_DBUtilMySQL.ExecuteDataSet(strSQL);
                strOutputInfo = "M_DBUtilMySQL.ExecuteDataSet():Success; SQL=" + strSQL;
            }
            catch (Exception ex)
            {
                if (null != dsReturn)
                {
                    dsReturn.Dispose();
                    dsReturn = null;
                }
                strOutputInfo = ex.ToString();
            }

            return dsReturn;
        }

        public bool SetRISExamInfo(string strSQL, string strPatientID, string strAccessionNumber, out string strOutputInfo)
        {
            bool bReturn = true;
            strOutputInfo = "";

            strSQL = string.Format(strSQL,
                strPatientID,
                strAccessionNumber);

            try
            {
                M_DBUtilMySQL.ExecuteNonQuery(strSQL);
                strOutputInfo = "DAOMySQLRIS.SetRISExamInfo():Success; SQL=" + strSQL;
                bReturn = true;
            }
            catch (Exception ex)
            {
                strOutputInfo = ex.ToString();
                bReturn = false;
            }

            return bReturn;
        }
    }
}