using System.Data;
using System.Data.SqlClient;

namespace KIOSK.Integration.Util.DAO
{
    /// <summary>
    /// ADO.Net tools.
    /// </summary>
    public class DBUtilMSSQL
    {
        /// <summary>
        /// Database connection.
        /// </summary>
        private SqlConnection m_SqlCon;

        /// <summary>
        /// Gets or sets the database connection.
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
        private SqlTransaction m_SqlTra;

        /// <summary>
        /// Gets or sets the database transaction.
        /// </summary>
        /// <value>The database transaction.</value>
        public SqlTransaction M_SqlTra
        {
            get
            {
                return m_SqlTra;
            }
            set
            {
                m_SqlTra = value;
            }
        }

        /// <summary>
        /// Construct function.
        /// </summary>
        public DBUtilMSSQL()
        {
        }

        /// <summary>
        /// Construct function.
        /// </summary>
        /// <param name="scSqlCon">Database connection</param>
        /// <param name="stSqlTra">Database transaction</param>
        public DBUtilMSSQL(SqlConnection scSqlCon, SqlTransaction stSqlTra)
        {
            m_SqlCon = scSqlCon;
            m_SqlTra = stSqlTra;
        }

        /// <summary>
        /// Execute non-query sql statement.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <returns>The number of effected records</returns>
        public int ExecuteNonQuery(string strSQL)
        {
            return ExecuteNonQuery(strSQL, CommandType.Text);
        }

        /// <summary>
        /// Execute non-query sql statement.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <returns>The number of effected records.</returns>
        public int ExecuteNonQuery(string strSQL, CommandType ctCMDType)
        {
            SqlCommand scSQLCMD = new SqlCommand(strSQL, m_SqlCon, m_SqlTra);
            scSQLCMD.CommandTimeout = 60;
            scSQLCMD.CommandType = ctCMDType;
            return scSQLCMD.ExecuteNonQuery();
        }

        /// <summary>
        /// Execute non-query sql statement.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>The number of effected records.</returns>
        public int ExecuteNonQuery(string strSQL, params SqlParameter[] spParam)
        {
            return ExecuteNonQuery(strSQL, CommandType.Text, spParam);
        }

        /// <summary>
        /// Execute non-query sql statement.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>The number of effected records.</returns>
        public int ExecuteNonQuery(string strSQL, CommandType ctCMDType, params SqlParameter[] spParam)
        {
            SqlCommand scSQLCMD = new SqlCommand(strSQL, m_SqlCon, m_SqlTra);
            scSQLCMD.CommandTimeout = 60;
            scSQLCMD.CommandType = ctCMDType;

            for (int i = 0; i < spParam.Length; i++)
            {
                scSQLCMD.Parameters.Add(spParam[i]);
            }

            return scSQLCMD.ExecuteNonQuery();
        }

        /// <summary>
        /// Execute sql statement by scalar mode.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <returns>Result object</returns>
        public object ExecuteScalar(string strSQL)
        {
            return ExecuteScalar(strSQL, CommandType.Text);
        }

        /// <summary>
        /// Execute sql statement by scalar mode
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <returns>Result object</returns>
        public object ExecuteScalar(string strSQL, CommandType ctCMDType)
        {
            SqlCommand scSQLCMD = new SqlCommand(strSQL, m_SqlCon, m_SqlTra);
            scSQLCMD.CommandTimeout = 60;
            scSQLCMD.CommandType = ctCMDType;
            return scSQLCMD.ExecuteNonQuery();
        }

        /// <summary>
        /// Execute sql statement by scalar mode.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>Result object</returns>
        public object ExecuteScalar(string strSQL, params SqlParameter[] spParam)
        {
            return ExecuteScalar(strSQL, CommandType.Text, spParam);
        }

        /// <summary>
        /// Execute sql statement by scalar mode.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>Result object</returns>
        public object ExecuteScalar(string strSQL, CommandType ctCMDType, params SqlParameter[] spParam)
        {
            SqlCommand scSQLCMD = new SqlCommand(strSQL, m_SqlCon, m_SqlTra);
            scSQLCMD.CommandTimeout = 60;
            scSQLCMD.CommandType = ctCMDType;

            for (int i = 0; i < spParam.Length; i++)
            {
                scSQLCMD.Parameters.Add(spParam[i]);
            }

            return scSQLCMD.ExecuteNonQuery();
        }

        /// <summary>
        /// Execute sql statement by SqlDataReader.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <returns>SqlDataReader</returns>
        public SqlDataReader ExecuteReader(string strSQL)
        {
            return ExecuteReader(strSQL, CommandType.Text);
        }

        /// <summary>
        /// Execute sql statement by SqlDataReader.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <returns>SqlDataReader</returns>
        public SqlDataReader ExecuteReader(string strSQL, CommandType ctCMDType)
        {
            SqlCommand scSQLCMD = new SqlCommand(strSQL, m_SqlCon, m_SqlTra);
            scSQLCMD.CommandTimeout = 60;
            scSQLCMD.CommandType = ctCMDType;
            return scSQLCMD.ExecuteReader();
        }

        /// <summary>
        /// Execute sql statement by SqlDataReader.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>SqlDataReader</returns>
        public SqlDataReader ExecuteReader(string strSQL, params SqlParameter[] spParam)
        {
            return ExecuteReader(strSQL, CommandType.Text, spParam);
        }

        /// <summary>
        /// Execute sql statement by SqlDataReader.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>SqlDataReader</returns>
        public SqlDataReader ExecuteReader(string strSQL, CommandType ctCMDType, params SqlParameter[] spParam)
        {
            SqlCommand scSQLCMD = new SqlCommand(strSQL, m_SqlCon, m_SqlTra);
            scSQLCMD.CommandTimeout = 60;
            scSQLCMD.CommandType = ctCMDType;

            for (int i = 0; i < spParam.Length; i++)
            {
                scSQLCMD.Parameters.Add(spParam[i]);
            }

            return scSQLCMD.ExecuteReader();
        }

        /// <summary>
        /// Execute sql statement by DataSet.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <returns>DataSet</returns>
        public DataSet ExecuteDataSet(string strSQL)
        {
            return ExecuteDataSet(strSQL, CommandType.Text);
        }

        /// <summary>
        /// Execute sql statement by DataSet.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <returns>DataSet</returns>
        public DataSet ExecuteDataSet(string strSQL, CommandType ctCMDType)
        {
            SqlCommand scSQLCMD = new SqlCommand(strSQL, m_SqlCon, m_SqlTra);
            scSQLCMD.CommandTimeout = 60;
            scSQLCMD.CommandType = ctCMDType;

            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = scSQLCMD;

            DataSet ds = new DataSet();
            da.Fill(ds);

            return ds;
        }

        /// <summary>
        /// Execute sql statement by DataSet.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>DataSet</returns>
        public DataSet ExecuteDataSet(string strSQL, params SqlParameter[] spParam)
        {
            return ExecuteDataSet(strSQL, CommandType.Text, spParam);
        }

        /// <summary>
        /// Execute sql statement by DataSet.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>DataSet</returns>
        public DataSet ExecuteDataSet(string strSQL, CommandType ctCMDType, params SqlParameter[] spParam)
        {
            SqlCommand scSQLCMD = new SqlCommand(strSQL, m_SqlCon, m_SqlTra);
            scSQLCMD.CommandTimeout = 60;
            scSQLCMD.CommandType = ctCMDType;

            for (int i = 0; i < spParam.Length; i++)
            {
                scSQLCMD.Parameters.Add(spParam[i]);
            }

            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = scSQLCMD;

            DataSet ds = new DataSet();
            da.Fill(ds);

            return ds;
        }
    }
}