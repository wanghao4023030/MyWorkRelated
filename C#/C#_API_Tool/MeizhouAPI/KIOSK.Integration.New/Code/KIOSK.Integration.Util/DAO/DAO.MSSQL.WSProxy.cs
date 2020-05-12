using System;
using System.Data;
using System.Data.SqlClient;
using System.Xml;

namespace KIOSK.Integration.Util.DAO
{
    public class DAOMSSQLWSProxy
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
        /// Database Util For MSSQL.
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
        public DAOMSSQLWSProxy()
        {
        }

        /// <summary>
        /// Construct function.
        /// </summary>
        /// <param name="scSqlCon">Database connection</param>
        /// <param name="stSqlTra">Database transaction</param>
        public DAOMSSQLWSProxy(SqlConnection scSqlCon, SqlTransaction stSqlTra)
        {
            M_SqlCon = scSqlCon;
            M_SqlTran = stSqlTra;

            M_DBUtilMSSQL = new DBUtilMSSQL(M_SqlCon, M_SqlTran);
        }

        public DataSet GetPSReportInfo(string strSQL, out string strOutputInfo)
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

        public void SetPSExamInfo(string strSQL,string strPatientID,string strAccessionNumber,string strStudyInstanceUID,
            string strNameEN, string strNameCN, string strGender, string strBirthday,string strModality, string strModalityName,
            string strPatientType,string strVisitID,string strRequestID,string strRequestDepartment,string strRequestDT,
            string strRegisterDT,string strExamDT,string strSubmitDT,string strApproveDT,string strPDFReportURL,string strStudyStatus,
            int iReportStatus,int iPDFFlag,int iVerifyFilmFlag,int iVerifyReportFlag,
            int iFilmStoredFlag,int iReportStoredFlag,int iNotifyReportFlag,int iSetPrintModeFlag,
            int iFilmPrintFlag,string strFilmPrintDoctor,int iReportPrintFlag,string strReportPrintDoctor,
            string strOutHospitalNo,string strInHospitalNo,string strPhysicalNumber,string strExamName,string strExamBodyPart,
            string strOptional0,string strOptional1,string strOptional2,string strOptional3,string strOptional4,
            string strOptional5,string strOptional6,string strOptional7,string strOptional8,string strOptional9,
            out string strOutputInfo)
        {
            strOutputInfo = "";

            SqlParameter[] spParam =
            {
                new SqlParameter("@PatientID", SqlDbType.NVarChar,128),
                new SqlParameter("@AccessionNumber", SqlDbType.NVarChar,128),
                new SqlParameter("@StudyInstanceUID", SqlDbType.NVarChar,128),
                new SqlParameter("@NameCN", SqlDbType.NVarChar,128),
                new SqlParameter("@NameEN", SqlDbType.NVarChar,128),
                new SqlParameter("@Gender", SqlDbType.NVarChar,32),
                new SqlParameter("@Birthday", SqlDbType.NVarChar,32),
                new SqlParameter("@Modality", SqlDbType.NVarChar,32),
                new SqlParameter("@ModalityName", SqlDbType.NVarChar,128),
                new SqlParameter("@PatientType", SqlDbType.NVarChar,32),
                new SqlParameter("@VisitID", SqlDbType.NVarChar,32),
                new SqlParameter("@RequestID", SqlDbType.NVarChar,128),
                new SqlParameter("@RequestDepartment", SqlDbType.NVarChar,128),
                new SqlParameter("@RequestDT", SqlDbType.NVarChar,32),
                new SqlParameter("@RegisterDT", SqlDbType.NVarChar,32),
                new SqlParameter("@ExamDT", SqlDbType.NVarChar,32),
                new SqlParameter("@SubmitDT", SqlDbType.NVarChar,32),
                new SqlParameter("@ApproveDT", SqlDbType.NVarChar,32),
                new SqlParameter("@PDFReportURL", SqlDbType.NVarChar,256),
                new SqlParameter("@StudyStatus", SqlDbType.NVarChar,32),
                new SqlParameter("@ReportStatus", SqlDbType.Int),
                new SqlParameter("@PDFFlag", SqlDbType.Int),
                new SqlParameter("@VerifyFilmFlag", SqlDbType.Int),
                new SqlParameter("@VerifyReportFlag", SqlDbType.Int),
                new SqlParameter("@FilmStoredFlag", SqlDbType.Int),
                new SqlParameter("@ReportStoredFlag", SqlDbType.Int),
                new SqlParameter("@NotifyReportFlag", SqlDbType.Int),
                new SqlParameter("@SetPrintModeFlag", SqlDbType.Int),
                new SqlParameter("@FilmPrintFlag", SqlDbType.Int),
                new SqlParameter("@FilmPrintDoctor", SqlDbType.NVarChar,128),
                new SqlParameter("@ReportPrintFlag", SqlDbType.Int),
                new SqlParameter("@ReportPrintDoctor", SqlDbType.NVarChar,128),

                new SqlParameter("@OutHospitalNo",SqlDbType.NVarChar,128),
                new SqlParameter("@InHospitalNo",SqlDbType.NVarChar,128),
                new SqlParameter("@PhysicalNumber",SqlDbType.NVarChar,128),
                new SqlParameter("@ExamName",SqlDbType.NVarChar,256),
                new SqlParameter("@ExamBodyPart",SqlDbType.NVarChar,256),
                new SqlParameter("@Optional0", SqlDbType.NVarChar,256),
                new SqlParameter("@Optional1", SqlDbType.NVarChar,256),
                new SqlParameter("@Optional2", SqlDbType.NVarChar,256),
                new SqlParameter("@Optional3", SqlDbType.NVarChar,256),
                new SqlParameter("@Optional4", SqlDbType.NVarChar,256),
                new SqlParameter("@Optional5", SqlDbType.NVarChar,256),
                new SqlParameter("@Optional6", SqlDbType.NVarChar,256),
                new SqlParameter("@Optional7", SqlDbType.NVarChar,256),
                new SqlParameter("@Optional8", SqlDbType.NVarChar,256),
                new SqlParameter("@Optional9", SqlDbType.NVarChar,256),
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
            spParam[2].Value = strStudyInstanceUID;

            spParam[3].DbType = DbType.String;
            spParam[3].Direction = ParameterDirection.Input;
            spParam[3].Value = strNameEN;

            spParam[4].DbType = DbType.String;
            spParam[4].Direction = ParameterDirection.Input;
            spParam[4].Value = strNameCN;

            spParam[5].DbType = DbType.String;
            spParam[5].Direction = ParameterDirection.Input;
            spParam[5].Value = strGender;

            spParam[6].DbType = DbType.String;
            spParam[6].Direction = ParameterDirection.Input;
            spParam[6].Value = strBirthday;

            spParam[7].DbType = DbType.String;
            spParam[7].Direction = ParameterDirection.Input;
            spParam[7].Value = strModality;

            spParam[8].DbType = DbType.String;
            spParam[8].Direction = ParameterDirection.Input;
            spParam[8].Value = strModalityName;

            spParam[9].DbType = DbType.String;
            spParam[9].Direction = ParameterDirection.Input;
            spParam[9].Value = strPatientType;

            spParam[10].DbType = DbType.String;
            spParam[10].Direction = ParameterDirection.Input;
            spParam[10].Value = strVisitID;

            spParam[11].DbType = DbType.String;
            spParam[11].Direction = ParameterDirection.Input;
            spParam[11].Value = strRequestID;

            spParam[12].DbType = DbType.String;
            spParam[12].Direction = ParameterDirection.Input;
            spParam[12].Value = strRequestDepartment;

            spParam[13].DbType = DbType.String;
            spParam[13].Direction = ParameterDirection.Input;
            spParam[13].Value = strRequestDT;

            spParam[14].DbType = DbType.String;
            spParam[14].Direction = ParameterDirection.Input;
            spParam[14].Value = strRegisterDT;

            spParam[15].DbType = DbType.String;
            spParam[15].Direction = ParameterDirection.Input;
            spParam[15].Value = strExamDT;

            spParam[16].DbType = DbType.String;
            spParam[16].Direction = ParameterDirection.Input;
            spParam[16].Value = strSubmitDT;

            spParam[17].DbType = DbType.String;
            spParam[17].Direction = ParameterDirection.Input;
            spParam[17].Value = strApproveDT;

            spParam[18].DbType = DbType.String;
            spParam[18].Direction = ParameterDirection.Input;
            spParam[18].Value = strPDFReportURL;

            spParam[19].DbType = DbType.String;
            spParam[19].Direction = ParameterDirection.Input;
            spParam[19].Value = strStudyStatus;

            spParam[20].DbType = DbType.Int32;
            spParam[20].Direction = ParameterDirection.Input;
            spParam[20].Value = iReportStatus;

            spParam[21].DbType = DbType.Int32;
            spParam[21].Direction = ParameterDirection.Input;
            spParam[21].Value = iPDFFlag;

            spParam[22].DbType = DbType.Int32;
            spParam[22].Direction = ParameterDirection.Input;
            spParam[22].Value = iVerifyFilmFlag;

            spParam[23].DbType = DbType.Int32;
            spParam[23].Direction = ParameterDirection.Input;
            spParam[23].Value = iVerifyReportFlag;

            spParam[24].DbType = DbType.Int32;
            spParam[24].Direction = ParameterDirection.Input;
            spParam[24].Value = iFilmStoredFlag;

            spParam[25].DbType = DbType.Int32;
            spParam[25].Direction = ParameterDirection.Input;
            spParam[25].Value = iReportStoredFlag;

            spParam[26].DbType = DbType.Int32;
            spParam[26].Direction = ParameterDirection.Input;
            spParam[26].Value = iNotifyReportFlag;

            spParam[27].DbType = DbType.Int32;
            spParam[27].Direction = ParameterDirection.Input;
            spParam[27].Value = iSetPrintModeFlag;

            spParam[28].DbType = DbType.Int32;
            spParam[28].Direction = ParameterDirection.Input;
            spParam[28].Value = iFilmPrintFlag;

            spParam[29].DbType = DbType.String;
            spParam[29].Direction = ParameterDirection.Input;
            spParam[29].Value = strFilmPrintDoctor;

            spParam[30].DbType = DbType.Int32;
            spParam[30].Direction = ParameterDirection.Input;
            spParam[30].Value = iReportPrintFlag;

            spParam[31].DbType = DbType.String;
            spParam[31].Direction = ParameterDirection.Input;
            spParam[31].Value = strReportPrintDoctor;

            spParam[32].DbType = DbType.String;
            spParam[32].Direction = ParameterDirection.Input;
            spParam[32].Value = strOutHospitalNo;

            spParam[33].DbType = DbType.String;
            spParam[33].Direction = ParameterDirection.Input;
            spParam[33].Value = strInHospitalNo;

            spParam[34].DbType = DbType.String;
            spParam[34].Direction = ParameterDirection.Input;
            spParam[34].Value = strPhysicalNumber;

            spParam[35].DbType = DbType.String;
            spParam[35].Direction = ParameterDirection.Input;
            spParam[35].Value = strExamName;

            spParam[36].DbType = DbType.String;
            spParam[36].Direction = ParameterDirection.Input;
            spParam[36].Value = strExamBodyPart;

            spParam[37].DbType = DbType.String;
            spParam[37].Direction = ParameterDirection.Input;
            spParam[37].Value = strOptional0;

            spParam[38].DbType = DbType.String;
            spParam[38].Direction = ParameterDirection.Input;
            spParam[38].Value = strOptional1;

            spParam[39].DbType = DbType.String;
            spParam[39].Direction = ParameterDirection.Input;
            spParam[39].Value = strOptional2;

            spParam[40].DbType = DbType.String;
            spParam[40].Direction = ParameterDirection.Input;
            spParam[40].Value = strOptional3;

            spParam[41].DbType = DbType.String;
            spParam[41].Direction = ParameterDirection.Input;
            spParam[41].Value = strOptional4;

            spParam[42].DbType = DbType.String;
            spParam[42].Direction = ParameterDirection.Input;
            spParam[42].Value = strOptional5;

            spParam[43].DbType = DbType.String;
            spParam[43].Direction = ParameterDirection.Input;
            spParam[43].Value = strOptional6;

            spParam[44].DbType = DbType.String;
            spParam[44].Direction = ParameterDirection.Input;
            spParam[44].Value = strOptional7;

            spParam[45].DbType = DbType.String;
            spParam[45].Direction = ParameterDirection.Input;
            spParam[45].Value = strOptional8;

            spParam[46].DbType = DbType.String;
            spParam[46].Direction = ParameterDirection.Input;
            spParam[46].Value = strOptional9;

            spParam[47].DbType = DbType.Xml;
            spParam[47].Direction = ParameterDirection.Output;

            try
            {
                M_DBUtilMSSQL.ExecuteNonQuery(strSQL, spParam);
                strOutputInfo = (string)spParam[47].Value;
            }
            catch (Exception ex)
            {
                strOutputInfo = ex.ToString();
            }
        }

        public DataSet GetPSExamInfo(string strSQL, string strPatientID, string strPatientName,
            string strAccessionNumber, string strModality, string strStartDT, string strEndDT, out string strOutputInfo)
        {
            DataSet dsReturn = null;
            strOutputInfo = "";

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

            return dsReturn;
        }

        public void UpdateReportSatus(string strSQL, string strPatientID, string strAccessionNumber,out string strInfo)
        {
            strInfo = "";
            SqlParameter[] spParam = 
            {
                new SqlParameter("@PatientID", SqlDbType.NVarChar, 128),
                new SqlParameter("@AccessionNumber", SqlDbType.NVarChar, 128),
                new SqlParameter("@OutputInfo", SqlDbType.NVarChar, 8000)
            };
            spParam[0].DbType = DbType.String;
            spParam[0].Direction = ParameterDirection.Input;
            spParam[0].Value = strPatientID;

            spParam[1].DbType = DbType.String;
            spParam[1].Direction = ParameterDirection.Input;
            spParam[1].Value = strAccessionNumber;

            spParam[2].DbType = DbType.Xml;
            spParam[2].Direction = ParameterDirection.Output;

            try
            {
                M_DBUtilMSSQL.ExecuteNonQuery(strSQL, spParam);
                strInfo = (string)spParam[2].Value;
            }
            catch (Exception ex)
            {
                strInfo = ex.ToString();
            }
        }

        public DataSet GetPSPrintMode(string strSQL, string strAccessionNumber, string strStudyInstanceUID, out string strOutputInfo)
        {
            DataSet dsReturn = null;
            strOutputInfo = "";

            SqlParameter[] spParam =
            {
                new SqlParameter("@AccessionNumber", SqlDbType.NVarChar,128),
                new SqlParameter("@StudyInstanceUID", SqlDbType.NVarChar,128),
                new SqlParameter("@OutputInfo", SqlDbType.NVarChar,8000)
            };

            spParam[0].DbType = DbType.String;
            spParam[0].Direction = ParameterDirection.Input;
            spParam[0].Value = strAccessionNumber;

            spParam[1].DbType = DbType.String;
            spParam[1].Direction = ParameterDirection.Input;
            spParam[1].Value = strStudyInstanceUID;

            spParam[2].DbType = DbType.Xml;
            spParam[2].Direction = ParameterDirection.Output;

            try
            {
                dsReturn = M_DBUtilMSSQL.ExecuteDataSet(strSQL, spParam);
                strOutputInfo = (string)spParam[2].Value;
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

        public DataSet GetPSPatientInfo(string strSQL, string strTerminalInfo, string strPatientIDType, string strPatientID,
            string strReturnType, out string strOutputInfo)
        {
            DataSet dsReturn = null;
            strOutputInfo = "";

            SqlParameter[] spParam =
            {
                new SqlParameter("@TerminalInfo", SqlDbType.NVarChar,128),
                new SqlParameter("@PatientIDType", SqlDbType.NVarChar,128),
                new SqlParameter("@PatientID", SqlDbType.NVarChar,128),
                new SqlParameter("@ReturnType", SqlDbType.NVarChar,128),
                new SqlParameter("@OutputInfo", SqlDbType.NVarChar,8000)
            };

            spParam[0].DbType = DbType.String;
            spParam[0].Direction = ParameterDirection.Input;
            spParam[0].Value = strTerminalInfo; 

            spParam[1].DbType = DbType.String;
            spParam[1].Direction = ParameterDirection.Input;
            spParam[1].Value = strPatientIDType;

            spParam[2].DbType = DbType.String;
            spParam[2].Direction = ParameterDirection.Input;
            spParam[2].Value = strPatientID;

            spParam[3].DbType = DbType.String;
            spParam[3].Direction = ParameterDirection.Input;
            spParam[3].Value = strReturnType;

            spParam[4].DbType = DbType.Xml;
            spParam[4].Direction = ParameterDirection.Output;

            try
            {
                dsReturn = M_DBUtilMSSQL.ExecuteDataSet(strSQL, spParam);
                strOutputInfo = (string)spParam[4].Value;
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

        public DataSet GetUnPrintedStudy(string strSQL, string strTerminalInfo, string strCardType, string strCardNumber, out string strOutputInfo)
        {
            DataSet dsReturn = null;
            strOutputInfo = "";

            SqlParameter[] spParam =
            {
                new SqlParameter("@TerminalInfo", SqlDbType.NVarChar,32),
                new SqlParameter("@CardType", SqlDbType.NVarChar,128),
                new SqlParameter("@CardNumber", SqlDbType.NVarChar,128),
                new SqlParameter("@OutputInfo", SqlDbType.NVarChar,8000)
            };

            spParam[0].DbType = DbType.String;
            spParam[0].Direction = ParameterDirection.Input;
            spParam[0].Value = strTerminalInfo;

            spParam[1].DbType = DbType.String;
            spParam[1].Direction = ParameterDirection.Input;
            spParam[1].Value = strCardType;

            spParam[2].DbType = DbType.String;
            spParam[2].Direction = ParameterDirection.Input;
            spParam[2].Value = strCardNumber;

            spParam[3].DbType = DbType.Xml;
            spParam[3].Direction = ParameterDirection.Output;

            try
            {
                dsReturn = M_DBUtilMSSQL.ExecuteDataSet(strSQL, spParam);
                strOutputInfo = (string)spParam[3].Value;
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

        public void SetPrintMode(string strSQL, string strAccessionNumber, out int PrintMode, out string strOutputInfo)
        {
            PrintMode = -1;
            strOutputInfo = "";
            
            SqlParameter[] spParam =
            {
                new SqlParameter("@AccessionNumber", SqlDbType.NVarChar,128),
                new SqlParameter("@PrintMode", SqlDbType.Int),
                new SqlParameter("@OutputInfo", SqlDbType.NVarChar,8000)
            };

            spParam[0].DbType = DbType.String;
            spParam[0].Direction = ParameterDirection.Input;
            spParam[0].Value = strAccessionNumber;

            spParam[1].DbType = DbType.Int32;
            spParam[1].Direction = ParameterDirection.Output;

            spParam[2].DbType = DbType.Xml;
            spParam[2].Direction = ParameterDirection.Output;

            try
            {
                M_DBUtilMSSQL.ExecuteNonQuery(strSQL, spParam);
                PrintMode = (int)spParam[1].Value;
                strOutputInfo = (string)spParam[2].Value;
            }
            catch (Exception ex)
            {
                strOutputInfo = ex.ToString();
            }
        }
    }
}