using System.Data.SqlClient;

namespace KIOSK.Integration.Util.DAO
{
    /// <summary>
    /// Database connection operation class.
    /// </summary>
    public class DBConnectionMSSQL
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
        private SqlConnection m_SqlCon = null;

        /// <summary>
        /// Initialize database pool.
        /// </summary>
        /// <param name="strDBServer">Database server</param>
        /// <param name="strDBName">Database name</param>
        /// <param name="strDBUserName">The user name of database</param>
        /// <param name="strDBPassword">The password for access database</param>
        public void InitStrDBCon(string strDBServer, string strDBName, string strDBUserName, string strDBPassword)
        {
            m_DBConString = string.Format("Data Source={0};Initial Catalog={1};Persist Security Info=True;User ID={2};Pwd={3}",
                strDBServer,
                strDBName,
                strDBUserName,
                strDBPassword);
        }

        /// <summary>
        /// Open database connection.
        /// </summary>
        /// <returns>Database connection</returns>
        public SqlConnection OpenSQLCon()
        {
            m_SqlCon = new SqlConnection(m_DBConString);
            m_SqlCon.Open();
            return m_SqlCon;
        }

        /// <summary>
        /// Close database connection.
        /// </summary>
        /// <param name="scSQLCon">Database connection</param>
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