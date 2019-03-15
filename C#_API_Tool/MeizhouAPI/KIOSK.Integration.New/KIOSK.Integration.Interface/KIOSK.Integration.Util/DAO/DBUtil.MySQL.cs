using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace KIOSK.Integration.Util.DAO
{
    /// <summary>
    /// ADO.Net tools.
    /// </summary>
    public class DBUtilMySQL
    {
        /// <summary>
        /// Database connection.
        /// </summary>
        private MySqlConnection m_MySqlCon;

        /// <summary>
        /// Gets or sets the database connection.
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
        private MySqlTransaction m_MySqlTra;

        /// <summary>
        /// Gets or sets the database transaction.
        /// </summary>
        /// <value>The database transaction.</value>
        public MySqlTransaction M_MySqlTra
        {
            get
            {
                return m_MySqlTra;
            }
            set
            {
                m_MySqlTra = value;
            }
        }

        /// <summary>
        /// Construct function.
        /// </summary>
        public DBUtilMySQL()
        {
        }

        /// <summary>
        /// Construct function.
        /// </summary>
        /// <param name="scMySqlCon">Database connection</param>
        /// <param name="stMySqlTra">Database transaction</param>
        public DBUtilMySQL(MySqlConnection scMySqlCon, MySqlTransaction stMySqlTra)
        {
            m_MySqlCon = scMySqlCon;
            m_MySqlTra = stMySqlTra;
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
            MySqlCommand scMySQLCMD = new MySqlCommand(strSQL, m_MySqlCon, m_MySqlTra);
            scMySQLCMD.CommandTimeout = 60;
            scMySQLCMD.CommandType = ctCMDType;
            return scMySQLCMD.ExecuteNonQuery();
        }

        /// <summary>
        /// Execute non-query sql statement.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>The number of effected records.</returns>
        public int ExecuteNonQuery(string strSQL, params MySqlParameter[] spParam)
        {
            return ExecuteNonQuery(strSQL, CommandType.Text, spParam);
            //return ExecuteNonQuery(strSQL, CommandType.StoredProcedure, spParam);
        }

        /// <summary>
        /// Execute non-query sql statement.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>The number of effected records.</returns>
        public int ExecuteNonQuery(string strSQL, CommandType ctCMDType, params MySqlParameter[] spParam)
        {
            MySqlCommand scMySQLCMD = new MySqlCommand(strSQL, m_MySqlCon, m_MySqlTra);
            scMySQLCMD.CommandTimeout = 60;
            scMySQLCMD.CommandType = ctCMDType;

            for (int i = 0; i < spParam.Length; i++)
            {
                scMySQLCMD.Parameters.Add(spParam[i]);
            }

            return scMySQLCMD.ExecuteNonQuery();
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
            MySqlCommand scMySQLCMD = new MySqlCommand(strSQL, m_MySqlCon, m_MySqlTra);
            scMySQLCMD.CommandTimeout = 60;
            scMySQLCMD.CommandType = ctCMDType;
            return scMySQLCMD.ExecuteNonQuery();
        }

        /// <summary>
        /// Execute sql statement by scalar mode.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>Result object</returns>
        public object ExecuteScalar(string strSQL, params MySqlParameter[] spParam)
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
        public object ExecuteScalar(string strSQL, CommandType ctCMDType, params MySqlParameter[] spParam)
        {
            MySqlCommand scMySQLCMD = new MySqlCommand(strSQL, m_MySqlCon, m_MySqlTra);
            scMySQLCMD.CommandTimeout = 60;
            scMySQLCMD.CommandType = ctCMDType;

            for (int i = 0; i < spParam.Length; i++)
            {
                scMySQLCMD.Parameters.Add(spParam[i]);
            }

            return scMySQLCMD.ExecuteNonQuery();
        }

        /// <summary>
        /// Execute sql statement by SqlDataReader.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <returns>SqlDataReader</returns>
        public MySqlDataReader ExecuteReader(string strSQL)
        {
            return ExecuteReader(strSQL, CommandType.Text);
        }

        /// <summary>
        /// Execute sql statement by SqlDataReader.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <returns>SqlDataReader</returns>
        public MySqlDataReader ExecuteReader(string strSQL, CommandType ctCMDType)
        {
            MySqlCommand scMySQLCMD = new MySqlCommand(strSQL, m_MySqlCon, m_MySqlTra);
            scMySQLCMD.CommandTimeout = 60;
            scMySQLCMD.CommandType = ctCMDType;
            return scMySQLCMD.ExecuteReader();
        }

        /// <summary>
        /// Execute sql statement by SqlDataReader.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>SqlDataReader</returns>
        public MySqlDataReader ExecuteReader(string strSQL, params MySqlParameter[] spParam)
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
        public MySqlDataReader ExecuteReader(string strSQL, CommandType ctCMDType, params MySqlParameter[] spParam)
        {
            MySqlCommand scMySQLCMD = new MySqlCommand(strSQL, m_MySqlCon, m_MySqlTra);
            scMySQLCMD.CommandTimeout = 60;
            scMySQLCMD.CommandType = ctCMDType;

            for (int i = 0; i < spParam.Length; i++)
            {
                scMySQLCMD.Parameters.Add(spParam[i]);
            }

            return scMySQLCMD.ExecuteReader();
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
            MySqlCommand scMySQLCMD = new MySqlCommand(strSQL, m_MySqlCon, m_MySqlTra);
            scMySQLCMD.CommandTimeout = 60;
            scMySQLCMD.CommandType = ctCMDType;

            MySqlDataAdapter da = new MySqlDataAdapter();
            da.SelectCommand = scMySQLCMD;

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
        public DataSet ExecuteDataSet(string strSQL, params MySqlParameter[] spParam)
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
        public DataSet ExecuteDataSet(string strSQL, CommandType ctCMDType, params MySqlParameter[] spParam)
        {
            MySqlCommand scMySQLCMD = new MySqlCommand(strSQL, m_MySqlCon, m_MySqlTra);
            scMySQLCMD.CommandTimeout = 60;
            scMySQLCMD.CommandType = ctCMDType;

            for (int i = 0; i < spParam.Length; i++)
            {
                scMySQLCMD.Parameters.Add(spParam[i]);
            }

            MySqlDataAdapter da = new MySqlDataAdapter();
            da.SelectCommand = scMySQLCMD;

            DataSet ds = new DataSet();
            da.Fill(ds);

            return ds;
        }
    }
}