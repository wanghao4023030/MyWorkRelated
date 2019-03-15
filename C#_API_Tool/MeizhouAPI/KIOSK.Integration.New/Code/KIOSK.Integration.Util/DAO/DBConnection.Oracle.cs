using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Data.OracleClient;
using System.Linq;
using System.Text;

namespace KIOSK.Integration.Util.DAO
{
    /// <summary>
    /// Database connection operation class
    /// </summary>
    public class DBConnectionOracle
    {
        /// <summary>
        /// The maximum size of database pool.
        /// </summary>
        private const int DB_MAX_POOL = 50;

        /// <summary>
        /// The minimal size of database pool.
        /// </summary>
        private const int DB_MIN_POOL = 20;

        /// <summary>
        /// Database Connection string.
        /// </summary>
        private string m_DBConString = "";

        /// <summary>
        /// Database connection object.
        /// </summary>
        private OleDbConnection m_OraCon = null;

        /// <summary>
        /// Initialize database pool
        /// </summary>
        /// <param name="strDataSource">DataSource of database</param>
        /// <param name="strUserName">The username of database</param>
        /// <param name="strPassword">The password for access database</param>
        public void InitStrDBCon(string strDBServer, string strDBName, string strDBUserName, string strDBPassword)
        {
            m_DBConString = string.Format("Provider=MSDAORA.1;Data Source={0};User Id={1};Password={2};",
                strDBName,
                strDBUserName,
                strDBPassword);
        }

        /// <summary>
        /// Open database connection
        /// </summary>
        /// <returns>Database connection</returns>
        public OleDbConnection OpenOraCon()
        {
            m_OraCon = new OleDbConnection(m_DBConString);
            m_OraCon.Open();

            return m_OraCon;
        }

        /// <summary>
        /// Close database connection
        /// </summary>
        /// <param name="ocOraCon">Database connection</param>
        public void CloseOraCon(OleDbConnection ocOraCon)
        {
            if (null != ocOraCon)
            {
                ocOraCon.Dispose();
                ocOraCon.Close();
            }
        }
    }
}
