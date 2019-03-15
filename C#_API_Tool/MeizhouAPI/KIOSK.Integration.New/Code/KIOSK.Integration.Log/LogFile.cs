using System;
using System.IO;

namespace KIOSK.Integration.Log
{
    /// <summary>
    /// Defines methods for writing log of file type.
    /// </summary>
    public class LogFile : LogBasic
    {
        /// <summary>
        /// Initializes a new instance of the Log.File_Log class.
        /// </summary>
        public LogFile()
        {
        }

        /// <summary>
        /// The path of the log file.
        /// </summary>
        private string m_LogFilePath;

        /// <summary>
        /// Gets or sets the path of the log file.
        /// </summary>
        /// <value>The path of the log file.</value>
        public string M_LogFilePath
        {
            get
            {
                return m_LogFilePath;
            }
            set
            {
                m_LogFilePath = value;
            }
        }

        /// <summary>
        /// The name of the log file.
        /// </summary>
        private string m_LogFileName;

        /// <summary>
        /// Gets or sets the name of the log file.
        /// </summary>
        /// <value> The name of the log file.</value>
        public string M_LogFileName
        {
            get
            {
                return m_LogFileName;
            }
            set
            {
                m_LogFileName = value;
            }
        }

        /// <summary>
        /// The keep time of the log file.
        /// </summary>
        private int m_LogFileKeepTime;

        /// <summary>
        /// Gets or sets the keep time of the log file.
        /// </summary>
        /// <value>The keep time of the log file.</value>
        public int M_LogFileKeepTime
        {
            get
            {
                return m_LogFileKeepTime;
            }
            set
            {
                m_LogFileKeepTime = value;
            }
        }

        /// <summary>
        /// Write a log message.
        /// </summary>
        /// <param name="logInfo">The message that describes the log.</param>
        protected override void WriteLog(LogInfo logInfo)
        {
            // Create the subfolder
            if (!Directory.Exists(M_LogFilePath))
            {
                Directory.CreateDirectory(M_LogFilePath);
            }

            // Clear Old Log File.
            ClearOldLogFile(M_LogFilePath, M_LogFileKeepTime);

            // Generate log file's name.
            string strLogFileFullPath = Path.Combine(M_LogFilePath, M_LogFileName);
            StreamWriter swLogFile;

            // Determine whether the file is existed.
            if (File.Exists(strLogFileFullPath))
            {
                swLogFile = new StreamWriter(strLogFileFullPath, true);
            }
            else
            {
                swLogFile = File.CreateText(strLogFileFullPath);
            }

            // Record log
            swLogFile.WriteLine(logInfo.ToString());

            // Close log file
            swLogFile.Close();
        }

        /// <summary>
        /// Delete the specified number of days prior to the log file.
        /// </summary>
        /// <param name="strLogFilePath">Log file path.</param>
        /// <param name="iLogFileKeepTime">Log file keep time.</param>
        public void ClearOldLogFile(string strLogFilePath, int iLogFileKeepTime)
        {
            if ("\\" != strLogFilePath.Substring(strLogFilePath.Length - 1, 1))
            {
                strLogFilePath = strLogFilePath.Trim() + "\\";
            }

            string[] LogFileList = Directory.GetFiles(Path.GetDirectoryName(strLogFilePath), "*.log");
            foreach(string strLogFileName in LogFileList)
            {
                string strLogFileDate = Path.GetFileName(strLogFileName).Substring(0,10);
                DateTime dtLogFileDate = DateTime.Parse(strLogFileDate);

                int iTemp = DateTime.Now.Subtract(dtLogFileDate).Days;

                if (iTemp > iLogFileKeepTime)
                {
                    //Determine the log file is or not exsit.
                    if (File.Exists(strLogFileName))
                    {
                        File.Delete(strLogFileName);
                    }
                }
            }
        }
    }
}