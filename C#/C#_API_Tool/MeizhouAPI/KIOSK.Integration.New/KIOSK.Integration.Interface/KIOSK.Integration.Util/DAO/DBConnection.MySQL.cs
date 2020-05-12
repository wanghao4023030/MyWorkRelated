using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace KIOSK.Integration.Util.DAO
{
    /// <summary>
    /// Database connection operation class
    /// </summary>
    public class DBConnectionMySQL
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
        private MySqlConnection m_MySQLCon = null;

        /// <summary>
        /// Initialize database pool
        /// </summary>
        /// <param name="strDataSource">DataSource of database</param>
        /// <param name="strUserName">The username of database</param>
        /// <param name="strPassword">The password for access database</param>
        public void InitStrDBCon(string strDBServer, string strDBName, string strDBUserName, string strDBPassword)
        {
            m_DBConString = string.Format("Database={0};Data Source={1};User Id={2};Password={3};charset='utf8';pooling=true",
                strDBName,
                strDBServer,
                strDBUserName,
                strDBPassword);
        }

        /// <summary>
        /// Open database connection
        /// </summary>
        /// <returns>Database connection</returns>
        public MySqlConnection OpenMySQLCon()
        {
            m_MySQLCon = new MySqlConnection(m_DBConString);
            m_MySQLCon.Open();

            return m_MySQLCon;
        }

        /// <summary>
        /// Close database connection
        /// </summary>
        /// <param name="msMySQLCon">Database connection</param>
        public void CloseMySQLCon(MySqlConnection msMySQLCon)
        {
            if (null != msMySQLCon)
            {
                msMySQLCon.Dispose();
                msMySQLCon.Close();
            }
        }
    }
}
