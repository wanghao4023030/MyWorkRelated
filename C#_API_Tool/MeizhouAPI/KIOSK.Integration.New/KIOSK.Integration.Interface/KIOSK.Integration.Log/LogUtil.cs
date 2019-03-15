using System;

using KIOSK.Integration.Util;

namespace KIOSK.Integration.Log
{
    public static class LogUtil
    {
        /// <summary>
        /// The name of the log file that record debug message.
        /// </summary>
        private const string LOG_DEBUG = "debug.log";
        /// <summary>
        /// The name of the log file that record warning message.
        /// </summary>
        private const string LOG_INFO = "info.log";
        /// <summary>
        /// The name of the log file that record error message.
        /// </summary>
        private const string LOG_ERROR = "error.log";

        /// <summary>
        /// The lock of the debug log file.
        /// </summary>
        private static Object m_ObjLockDebugLog = new Object();
        /// <summary>
        /// The lock of the warning log file.
        /// </summary>
        private static Object m_ObjLockInfoLog = new Object();
        /// <summary>
        /// The lock of the error log file.
        /// </summary>
        private static Object m_ObjLockErrorLog = new Object();

        /// <summary>
        /// The flag of whether the Log.LogUtil class is initiated.
        /// </summary>
        private static bool m_IsInit = false;

        /// <summary>
        /// The path of the log file.
        /// </summary>
        private static string m_LogFilePath;

        /// <summary>
        /// Gets a value the path of the log file.
        /// </summary>
        /// <value>The path of the log file.</value>
        public static string M_LogFilePath
        {
            get
            {
                return m_LogFilePath;
            }
        }

        /// <summary>
        /// The path of the log file.
        /// </summary>
        private static string m_LogLevel;

        /// <summary>
        /// Gets a value the level of the log file.
        /// </summary>
        /// <value>The level of the log file. debug common warning error</value>
        public static string M_LogLevel
        {
            get
            {
                return m_LogLevel;
            }
        }

        /// <summary>
        /// The keep time of the log file.
        /// </summary>
        private static int m_LogKeepTime;

        /// <summary>
        /// Gets a value the keep time of the log file.
        /// </summary>
        /// <value>The keep time of the log file.</value>
        public static int M_LogKeepTime
        {
            get
            {
                return m_LogKeepTime;
            }
        }

        /// <summary>
        /// Initiates the Log.LogUtil class.
        /// </summary>
        /// <param name="strLogFilePath">The path of the log file.</param>
        /// <param name="strLogLevel">The log file level.</param>
        /// <param name="iLogKeepTime">The keep time of the log file.</param>
        public static void Initialize(string strLogFilePath, string strLogLevel, int iLogKeepTime)
        {
            // Determine whether the Log.LogUtil class is Initiated.
            if (m_IsInit)
            {
                return;
            }

            // Initiates the Log.LogUtil class.
            m_LogFilePath = strLogFilePath;
            m_LogLevel = strLogLevel;
            m_LogKeepTime = iLogKeepTime;

            // Sets the flag of initiation.
            m_IsInit = true;
        }

        /// <summary>
        /// Write a debug type's log message.
        /// </summary>
        /// <param name="strLogMessage">The message that describes the log.</param>
        public static void DebugLog(string strLogMessage)
        {
            // Determine whether the Log.LogUtil class is Initiated.
            if (!m_IsInit)
            {
                throw new KIOSKIntegrationLogUninitializedException();
            }

            // Sets log's information
            LogInfo logInfo = new LogInfo();

            logInfo.M_LogDateTime = DateTime.Now;
            logInfo.M_LogMessage = strLogMessage;

            // Write debug.log
            if ("DEBUG" == M_LogLevel.ToUpper())
            {
                lock (m_ObjLockDebugLog)
                {
                    LogFile lfDebugLog = new LogFile();
                    lfDebugLog.M_LogFilePath = m_LogFilePath;
                    //lfDebugLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd") + LOG_DEBUG;
                    lfDebugLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss").Substring(0, 13).Replace(" ", ".") + LOG_DEBUG;
                    lfDebugLog.M_LogFileKeepTime = m_LogKeepTime;
                    lfDebugLog.DebugLog(logInfo);
                }
            }
        }

        /// <summary>
        /// Write a info type's log message.
        /// </summary>
        /// <param name="strLogMessage">The message that describes the log.</param>
        public static void InfoLog(string strLogMessage)
        {
            // Determine whether the Log.LogUtil class is Initiated.
            if (!m_IsInit)
            {
                throw new KIOSKIntegrationLogUninitializedException();
            }

            // Sets log's information
            LogInfo logInfo = new LogInfo();

            logInfo.M_LogDateTime = DateTime.Now;
            logInfo.M_LogMessage = strLogMessage;

            // Write debug.log
            if ("DEBUG" == M_LogLevel.ToUpper())
            {
                lock (m_ObjLockDebugLog)
                {
                    LogFile lfDebugLog = new LogFile();
                    lfDebugLog.M_LogFilePath = m_LogFilePath;
                    //lfDebugLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd") + LOG_DEBUG;
                    lfDebugLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss").Substring(0, 13).Replace(" ", ".") + LOG_DEBUG;
                    lfDebugLog.M_LogFileKeepTime = m_LogKeepTime;
                    lfDebugLog.DebugLog(logInfo);
                }
            }
            // Write info.log
            if ("DEBUG" == M_LogLevel.ToUpper() || "INFO" == M_LogLevel.ToUpper())
            {
                lock (m_ObjLockInfoLog)
                {
                    LogFile lfInfoLog = new LogFile();
                    lfInfoLog.M_LogFilePath = m_LogFilePath;
                    //lfInfoLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd") + LOG_INFO;
                    lfInfoLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss").Substring(0, 13).Replace(" ", ".") + LOG_INFO;
                    lfInfoLog.M_LogFileKeepTime = m_LogKeepTime;
                    lfInfoLog.WarningLog(logInfo);
                }
            }
        }

        /// <summary>
        /// Write a error type's log message.
        /// </summary>
        /// <param name="strLogMessage">The message that describes the log.</param>
        public static void ErrorLog(string strLogMessage)
        {
            // Determine whether the Log.LogUtil class is Initiated.
            if (!m_IsInit)
            {
                throw new KIOSKIntegrationLogUninitializedException();
            }

            // Sets log's information
            LogInfo logInfo = new LogInfo();

            logInfo.M_LogDateTime = DateTime.Now;
            logInfo.M_LogMessage = strLogMessage;

            // Write debug.log
            if ("DEBUG" == M_LogLevel.ToUpper())
            {
                lock (m_ObjLockDebugLog)
                {
                    LogFile lfDebugLog = new LogFile();
                    lfDebugLog.M_LogFilePath = m_LogFilePath;
                    //lfDebugLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd") + LOG_DEBUG;
                    lfDebugLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss").Substring(0, 13).Replace(" ", ".") + LOG_DEBUG;
                    lfDebugLog.M_LogFileKeepTime = m_LogKeepTime;
                    lfDebugLog.DebugLog(logInfo);
                }
            }
            // Write info.log
            if ("DEBUG" == M_LogLevel.ToUpper() || "INFO" == M_LogLevel.ToUpper())
            {
                lock (m_ObjLockInfoLog)
                {
                    LogFile lfInfoLog = new LogFile();
                    lfInfoLog.M_LogFilePath = m_LogFilePath;
                    //lfInfoLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd") + LOG_INFO;
                    lfInfoLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss").Substring(0, 13).Replace(" ", ".") + LOG_INFO;
                    lfInfoLog.M_LogFileKeepTime = m_LogKeepTime;
                    lfInfoLog.WarningLog(logInfo);
                }
            }
            // Write error.log
            lock (m_ObjLockErrorLog)
            {
                LogFile lfErrorLog = new LogFile();
                lfErrorLog.M_LogFilePath = m_LogFilePath;
                //lfErrorLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd") + LOG_ERROR;
                lfErrorLog.M_LogFileName = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss").Substring(0, 13).Replace(" ", ".") + LOG_ERROR;
                lfErrorLog.M_LogFileKeepTime = m_LogKeepTime;
                lfErrorLog.ErrorLog(logInfo);
            }
        }
    }
}