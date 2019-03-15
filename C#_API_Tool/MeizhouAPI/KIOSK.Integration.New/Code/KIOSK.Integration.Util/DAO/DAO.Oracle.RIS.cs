using System;
using System.Data;
using System.Data.OracleClient;
using System.Data.OleDb;
using System.Xml;

namespace KIOSK.Integration.Util.DAO
{
    public class DAOORACLERIS
    {
        /// <summary>
        /// Database connection for Oracle.
        /// </summary>
        private OleDbConnection m_OraCon;

        /// <summary>
        /// Gets or sets the database connection for Oracle.
        /// </summary>
        /// <value>The database connection.</value>
        public OleDbConnection M_OraCon
        {
            get
            {
                return m_OraCon;
            }
            set
            {
                m_OraCon = value;
            }
        }

        /// <summary>
        /// Database transaction for Oracle.
        /// </summary>
        private OleDbTransaction m_OraTran;

        /// <summary>
        /// Gets or sets the database transaction for Oracle.
        /// </summary>
        /// <value>The database transaction.</value>
        public OleDbTransaction M_OraTran
        {
            get
            {
                return m_OraTran;
            }
            set
            {
                m_OraTran = value;
            }
        }

        /// <summary>
        /// ADO.Net tools class.
        /// </summary>
        private DBUtilOracle m_DBUtilOracle;

        /// <summary>
        /// Gets or sets the DBUtil for Oracle.
        /// </summary>
        /// <value>The DBUtil.</value>
        public DBUtilOracle M_DBUtilOracle
        {
            get
            {
                return m_DBUtilOracle;
            }
            set
            {
                m_DBUtilOracle = value;
            }
        }

        /// <summary>
        /// Construct function.
        /// You must input database connection and database transaction,
        /// when new this class.so this construct function is privated.
        /// </summary>
        private DAOORACLERIS()
        {
        }

        /// <summary>
        /// Construct function.
        /// </summary>
        /// <param name="ocOraCon">Database connection</param>
        /// <param name="otOraTra">Database transaction</param>
        public DAOORACLERIS(OleDbConnection ocOraCon, OleDbTransaction otOraTra)
        {
            M_OraCon = ocOraCon;
            M_OraTran = otOraTra;

            M_DBUtilOracle = new DBUtilOracle(M_OraCon, M_OraTran);
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
                dsReturn = M_DBUtilOracle.ExecuteDataSet(strSQL);
                strOutputInfo = "M_DBUtilOracle.ExecuteDataSet():Success; SQL=" + strSQL;
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
                dsReturn = M_DBUtilOracle.ExecuteDataSet(strSQL);
                strOutputInfo = "M_DBUtilOracle.ExecuteDataSet():Success; SQL=" + strSQL;
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
    }
}