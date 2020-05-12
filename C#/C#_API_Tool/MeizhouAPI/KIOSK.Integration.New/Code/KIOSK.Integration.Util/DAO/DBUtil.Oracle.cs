using System.Data;
using System.Data.OracleClient;
using System.Data.OleDb;
using System;

namespace KIOSK.Integration.Util.DAO
{
    /// <summary>
    /// ADO.Net tools.
    /// </summary>
    public class DBUtilOracle
    {
        /// <summary>
        /// Database connection.
        /// </summary>
        private OleDbConnection m_OraCon;

        /// <summary>
        /// Gets or sets the database connection.
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
        /// Database transaction.
        /// </summary>
        private OleDbTransaction m_OraTra;

        /// <summary>
        /// Gets or sets the database transaction.
        /// </summary>
        /// <value>The database transaction.</value>
        public OleDbTransaction M_OraTra
        {
            get
            {
                return m_OraTra;
            }
            set
            {
                m_OraTra = value;
            }
        }

        /// <summary>
        /// Construct function.
        /// </summary>
        public DBUtilOracle()
        {
        }

        /// <summary>
        /// Construct function.
        /// </summary>
        /// <param name="ocOraCon">Database connection</param>
        /// <param name="otOraTra">Database transaction</param>
        public DBUtilOracle(OleDbConnection ocOraCon, OleDbTransaction otOraTra)
        {
            m_OraCon = ocOraCon;
            m_OraTra = otOraTra;
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
            OleDbCommand ocOraCMD = new OleDbCommand(strSQL, m_OraCon, m_OraTra);
            ocOraCMD.CommandType = ctCMDType;
            return ocOraCMD.ExecuteNonQuery();
        }

        /// <summary>
        /// Execute non-query sql statement.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="spParam">Command parameters</param>
        /// <returns>The number of effected records.</returns>
        public int ExecuteNonQuery(string strSQL, params OracleParameter[] spParam)
        {
            return ExecuteNonQuery(strSQL, CommandType.Text, spParam);
        }

        /// <summary>
        /// Execute non-query sql statement.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <param name="opParam">Command parameters</param>
        /// <returns>The number of effected records.</returns>
        public int ExecuteNonQuery(string strSQL, CommandType ctCMDType, params OracleParameter[] opParam)
        {
            OleDbCommand ocOraCMD = new OleDbCommand(strSQL, m_OraCon, m_OraTra);
            ocOraCMD.CommandType = ctCMDType;

            for (int i = 0; i < opParam.Length; i++)
            {
                ocOraCMD.Parameters.Add(opParam[i]);
            }

            return ocOraCMD.ExecuteNonQuery();
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
            OleDbCommand ocOraCMD = new OleDbCommand(strSQL, m_OraCon, m_OraTra);
            ocOraCMD.CommandType = ctCMDType;
            return ocOraCMD.ExecuteNonQuery();
        }

        /// <summary>
        /// Execute sql statement by scalar mode.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="opParam">Command parameters</param>
        /// <returns>Result object</returns>
        public object ExecuteScalar(string strSQL, params OracleParameter[] opParam)
        {
            return ExecuteScalar(strSQL, CommandType.Text, opParam);
        }

        /// <summary>
        /// Execute sql statement by scalar mode.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <param name="opParam">Command parameters</param>
        /// <returns>Result object</returns>
        public object ExecuteScalar(string strSQL, CommandType ctCMDType, params OracleParameter[] opParam)
        {
            OleDbCommand ocOraCMD = new OleDbCommand(strSQL, m_OraCon, m_OraTra);
            ocOraCMD.CommandType = ctCMDType;

            for (int i = 0; i < opParam.Length; i++)
            {
                ocOraCMD.Parameters.Add(opParam[i]);
            }

            return ocOraCMD.ExecuteNonQuery();
        }

        /// <summary>
        /// Execute sql statement by SqlDataReader.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <returns>SqlDataReader</returns>
        public OleDbDataReader ExecuteReader(string strSQL)
        {
            return ExecuteReader(strSQL, CommandType.Text);
        }

        /// <summary>
        /// Execute sql statement by SqlDataReader.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <returns>SqlDataReader</returns>
        public OleDbDataReader ExecuteReader(string strSQL, CommandType ctCMDType)
        {
            OleDbCommand ocOraCMD = new OleDbCommand(strSQL, m_OraCon, m_OraTra);
            ocOraCMD.CommandType = ctCMDType;
            return ocOraCMD.ExecuteReader();
        }

        /// <summary>
        /// Execute sql statement by SqlDataReader.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="opParam">Command parameters</param>
        /// <returns>SqlDataReader</returns>
        public OleDbDataReader ExecuteReader(string strSQL, params OracleParameter[] opParam)
        {
            return ExecuteReader(strSQL, CommandType.Text, opParam);
        }

        /// <summary>
        /// Execute sql statement by SqlDataReader.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <param name="opParam">Command parameters</param>
        /// <returns>SqlDataReader</returns>
        public OleDbDataReader ExecuteReader(string strSQL, CommandType ctCMDType, params OracleParameter[] opParam)
        {
            OleDbCommand ocOraCMD = new OleDbCommand(strSQL, m_OraCon, m_OraTra);
            ocOraCMD.CommandType = ctCMDType;

            for (int i = 0; i < opParam.Length; i++)
            {
                ocOraCMD.Parameters.Add(opParam[i]);
            }

            return ocOraCMD.ExecuteReader();
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
            OleDbCommand ocOraCMD = new OleDbCommand(strSQL, m_OraCon, m_OraTra);
            ocOraCMD.CommandType = ctCMDType;

            OleDbDataAdapter da = new OleDbDataAdapter(ocOraCMD);  

            DataSet ds = new DataSet();
            da.Fill(ds);

            return ds;
        }

        /// <summary>
        /// Execute sql statement by DataSet.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="opParam">Command parameters</param>
        /// <returns>DataSet</returns>
        public DataSet ExecuteDataSet(string strSQL, params OracleParameter[] opParam)
        {
            return ExecuteDataSet(strSQL, CommandType.Text, opParam);
        }

        /// <summary>
        /// Execute sql statement by DataSet.
        /// </summary>
        /// <param name="strSQL">Sql statement</param>
        /// <param name="ctCMDType">Command type</param>
        /// <param name="opParam">Command parameters</param>
        /// <returns>DataSet</returns>
        public DataSet ExecuteDataSet(string strSQL, CommandType ctCMDType, params OracleParameter[] opParam)
        {
            OleDbCommand ocOraCMD = new OleDbCommand(strSQL, m_OraCon, m_OraTra);
            ocOraCMD.CommandType = ctCMDType;

            for (int i = 0; i < opParam.Length; i++)
            {
                ocOraCMD.Parameters.Add(opParam[i]);
            }

            OleDbDataAdapter da = new OleDbDataAdapter(ocOraCMD);

            DataSet ds = new DataSet();
            da.Fill(ds);

            return ds;
        }
    }
}