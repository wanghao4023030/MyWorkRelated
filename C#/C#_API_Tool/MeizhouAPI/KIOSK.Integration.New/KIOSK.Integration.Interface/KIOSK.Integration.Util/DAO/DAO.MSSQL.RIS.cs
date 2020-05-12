using System;
using System.Data;
using System.Data.SqlClient;
using System.Xml;

namespace KIOSK.Integration.Util.DAO
{
    public class DAOMSSQLRIS
    {
        /// <summary>
        /// Database connection.
        /// </summary>
        private SqlConnection m_SqlCon;

        /// <summary>
        /// Gets or sets the database connection for MSSQL.
        /// </summary>
        /// <value>The database connection.</value>
        public SqlConnection M_SqlCon
        {
            get
            {
                return m_SqlCon;
            }
            set
            {
                m_SqlCon = value;
            }
        }

        /// <summary>
        /// Database transaction.
        /// </summary>
        private SqlTransaction m_SqlTran;

        /// <summary>
        /// Gets or sets the database transaction for MSSQL.
        /// </summary>
        /// <value>The database transaction.</value>
        public SqlTransaction M_SqlTran
        {
            get
            {
                return m_SqlTran;
            }
            set
            {
                m_SqlTran = value;
            }
        }

        /// <summary>
        /// ADO.Net tools class.
        /// </summary>
        private DBUtilMSSQL m_DBUtilMSSQL;

        /// <summary>
        /// Gets or sets the DBUtil for MSSQL.
        /// </summary>
        /// <value>The DBUtil.</value>
        public DBUtilMSSQL M_DBUtilMSSQL
        {
            get
            {
                return m_DBUtilMSSQL;
            }
            set
            {
                m_DBUtilMSSQL = value;
            }
        }

        /// <summary>
        /// Construct function.
        /// You must input database connection and database transaction,
        /// when new this class.so this construct function is privated.
        /// </summary>
        private DAOMSSQLRIS()
        {
        }

        /// <summary>
        /// Construct function.
        /// </summary>
        /// <param name="scSqlCon">Database connection</param>
        /// <param name="stSqlTra">Database transaction</param>
        public DAOMSSQLRIS(SqlConnection scSqlCon, SqlTransaction stSqlTra)
        {
            M_SqlCon = scSqlCon;
            M_SqlTran = stSqlTra;

            M_DBUtilMSSQL = new DBUtilMSSQL(M_SqlCon, M_SqlTran);
        }

        public DataSet GetRISReportInfo(string strSQL, out string strOutputInfo)
        {
            DataSet dsReturn = null;
            strOutputInfo = "";

            SqlParameter[] spParam =
            {
                new SqlParameter("@OutputInfo", SqlDbType.NVarChar,8000)
            };

            spParam[0].DbType = DbType.Xml;
            spParam[0].Direction = ParameterDirection.Output;

            try
            {
                dsReturn = M_DBUtilMSSQL.ExecuteDataSet(strSQL, spParam);
                strOutputInfo = (string)spParam[0].Value;
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

        public void SetRISReportInfo(string strSQL, string strPatientID, string strAccessionNumber,
            string strReportID, string strPDFReportPath, out string strOutputInfo)
        {
            strOutputInfo = "";

            SqlParameter[] spParam =
            {
                new SqlParameter("@PatientID", SqlDbType.NVarChar, 8000),
                new SqlParameter("@AccessionNumber", SqlDbType.NVarChar, 8000),
                new SqlParameter("@ReportID", SqlDbType.NVarChar, 8000),
                new SqlParameter("@PDFReportPath", SqlDbType.NVarChar, 8000),
                new SqlParameter("@OutputInfo", SqlDbType.NVarChar,8000)
            };

            spParam[0].DbType = DbType.String;
            spParam[0].Direction = ParameterDirection.Input;
            spParam[0].Value = strPatientID;

            spParam[1].DbType = DbType.String;
            spParam[1].Direction = ParameterDirection.Input;
            spParam[1].Value = strAccessionNumber;

            spParam[2].DbType = DbType.String;
            spParam[2].Direction = ParameterDirection.Input;
            spParam[2].Value = strReportID;

            spParam[3].DbType = DbType.String;
            spParam[3].Direction = ParameterDirection.Input;
            spParam[3].Value = strPDFReportPath;

            spParam[4].DbType = DbType.Xml;
            spParam[4].Direction = ParameterDirection.Output;

            try
            {
                M_DBUtilMSSQL.ExecuteNonQuery(strSQL, spParam);
                strOutputInfo = (string)spParam[4].Value;
            }
            catch (Exception ex)
            {
                strOutputInfo = ex.ToString();
            }
        }

        public DataSet GetRISExamInfo(string strSQL, string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStartDT, string strEndDT, out string strOutputInfo)
        {
            DataSet dsReturn = null;
            strOutputInfo = "";

            if (0<=strSQL.Trim().ToUpper().IndexOf("SELECT"))
            {
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
                    dsReturn = M_DBUtilMSSQL.ExecuteDataSet(strSQL);
                    strOutputInfo = "M_DBUtilMSSQL.ExecuteDataSet():Success; SQL=" + strSQL;
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
            }
            else
            {
                SqlParameter[] spParam =
                {
                    new SqlParameter("@PatientID", SqlDbType.NVarChar,8000),
                    new SqlParameter("@PatientName", SqlDbType.NVarChar,8000),
                    new SqlParameter("@AccessionNumber", SqlDbType.NVarChar,8000),
                    new SqlParameter("@Modality", SqlDbType.NVarChar,8000),
                    new SqlParameter("@StartDT", SqlDbType.NVarChar,32),
                    new SqlParameter("@EndDT", SqlDbType.NVarChar,32),
                    new SqlParameter("@OutputInfo", SqlDbType.NVarChar,8000)
                };

                spParam[0].DbType = DbType.String;
                spParam[0].Direction = ParameterDirection.Input;
                spParam[0].Value = strPatientID;

                spParam[1].DbType = DbType.String;
                spParam[1].Direction = ParameterDirection.Input;
                spParam[1].Value = strPatientName;

                spParam[2].DbType = DbType.String;
                spParam[2].Direction = ParameterDirection.Input;
                spParam[2].Value = strAccessionNumber;

                spParam[3].DbType = DbType.String;
                spParam[3].Direction = ParameterDirection.Input;
                spParam[3].Value = strModality;

                spParam[4].DbType = DbType.String;
                spParam[4].Direction = ParameterDirection.Input;
                spParam[4].Value = strStartDT;

                spParam[5].DbType = DbType.String;
                spParam[5].Direction = ParameterDirection.Input;
                spParam[5].Value = strEndDT;

                spParam[6].DbType = DbType.Xml;
                spParam[6].Direction = ParameterDirection.Output;

                try
                {
                    dsReturn = M_DBUtilMSSQL.ExecuteDataSet(strSQL, spParam);
                    strOutputInfo = (string)spParam[6].Value;
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
            }

            return dsReturn;
        }

        public DataSet GetRISExamInfoEx(string strSQL, string strQueryParam, out string strOutputInfo)
        {
            DataSet dsReturn = null;
            strOutputInfo = "";

            SqlParameter[] spParam =
            {
                new SqlParameter("@QueryParam", SqlDbType.NVarChar,8000),
                new SqlParameter("@OutputInfo", SqlDbType.NVarChar,8000)
            };

            spParam[0].DbType = DbType.Xml;
            spParam[0].Direction = ParameterDirection.Input;
            spParam[0].Value = strQueryParam;

            spParam[1].DbType = DbType.Xml;
            spParam[1].Direction = ParameterDirection.Output;

            try
            {
                dsReturn = M_DBUtilMSSQL.ExecuteDataSet(strSQL, spParam);
                strOutputInfo = (string)spParam[1].Value;
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

        public DataSet GetRISReportInfo(string strSQL,string strPatientID,string strPatientName,
            string strAccessionNumber,string strModality,string strReportID,string strReportStatus,
            out string strOutputInfo,out string strReportURL)
        {
            DataSet dsReturn = null;
            strOutputInfo = "";
            strReportURL = "";

            if (0 <= strSQL.Trim().ToUpper().IndexOf("SELECT"))
            {
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
                    dsReturn = M_DBUtilMSSQL.ExecuteDataSet(strSQL);
                    strOutputInfo = "M_DBUtilMSSQL.ExecuteDataSet():Success; SQL=" + strSQL;
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
            }
            else
            {
                SqlParameter[] spParam =
                    {
                        new SqlParameter("@PatientID", SqlDbType.NVarChar,8000),
                        new SqlParameter("@PatientName", SqlDbType.NVarChar,8000),
                        new SqlParameter("@AccessionNumber", SqlDbType.NVarChar,8000),
                        new SqlParameter("@Modality", SqlDbType.NVarChar,8000),
                        new SqlParameter("@ReportID", SqlDbType.NVarChar,8000),
                        new SqlParameter("@ReportStatus", SqlDbType.NVarChar,8000),
                        new SqlParameter("@OutputInfo", SqlDbType.NVarChar,8000),
                        new SqlParameter("@OutReport", SqlDbType.NVarChar, 8000)
                    };

                spParam[0].DbType = DbType.String;
                spParam[0].Direction = ParameterDirection.Input;
                spParam[0].Value = strPatientID;

                spParam[1].DbType = DbType.String;
                spParam[1].Direction = ParameterDirection.Input;
                spParam[1].Value = strPatientName;

                spParam[2].DbType = DbType.String;
                spParam[2].Direction = ParameterDirection.Input;
                spParam[2].Value = strAccessionNumber;

                spParam[3].DbType = DbType.String;
                spParam[3].Direction = ParameterDirection.Input;
                spParam[3].Value = strModality;

                spParam[4].DbType = DbType.String;
                spParam[4].Direction = ParameterDirection.Input;
                spParam[4].Value = strReportID;

                spParam[5].DbType = DbType.String;
                spParam[5].Direction = ParameterDirection.Input;
                spParam[5].Value = strReportStatus;

                spParam[6].DbType = DbType.Xml;
                spParam[6].Direction = ParameterDirection.Output;

                spParam[7].DbType = DbType.String;
                spParam[7].Direction = ParameterDirection.Output;

                try
                {
                    dsReturn = M_DBUtilMSSQL.ExecuteDataSet(strSQL, spParam);
                    strOutputInfo = (string)spParam[6].Value;
                    strReportURL = (string)spParam[7].Value;
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
            }

            return dsReturn;
        }
    }
}