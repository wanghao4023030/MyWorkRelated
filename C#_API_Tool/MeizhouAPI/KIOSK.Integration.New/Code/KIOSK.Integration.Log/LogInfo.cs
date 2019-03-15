using System;

namespace KIOSK.Integration.Log
{
    /// <summary>
    /// Log information class.
    /// </summary>
    public class LogInfo
    {
        /// <summary>
        /// Initializes a new instance of the Log.LogInfo class.
        /// </summary>
        public LogInfo()
        {
        }

        /// <summary>
        /// Initializes a new instance of the Log.LogInfo class with a time and a message.
        /// </summary>
        /// <param name="dtLogDateTime">The time of the log record.</param>
        /// <param name="strLogMessage">The message that describes the log.</param>
        public LogInfo(DateTime dtLogDateTime, string strLogMessage)
        {
            M_LogDateTime = dtLogDateTime;
            M_LogMessage = strLogMessage;
        }

        /// <summary>
        /// The time of the log record.
        /// </summary>
        private DateTime m_LogDateTime;

        /// <summary>
        /// Gets or sets the time of the log record.
        /// </summary>
        /// <value>A System.DateTime that records the time of the log.</value>
        public DateTime M_LogDateTime
        {
            get
            {
                return m_LogDateTime;
            }
            set
            {
                m_LogDateTime = value;
            }
        }

        /// <summary>
        /// The message that describes the log.
        /// </summary>
        private string m_LogMessage;

        /// <summary>
        /// Gets or sets the message that describes the log.
        /// </summary>
        /// <value>The message that describes the log.</value>
        public string M_LogMessage
        {
            get
            {
                return m_LogMessage;
            }
            set
            {
                m_LogMessage = value;
            }
        }

        /// <summary>
        /// Creates and returns a string representation of the log information.
        /// </summary>
        /// <returns>A string representation of the log information.</returns>
        public override string ToString()
        {
            string str = "";

            str += "[";
            str += M_LogDateTime.ToString("yyyy/MM/dd HH:mm:ss.fff");
            str += "]:";
            str += M_LogMessage;

            return str;
        }
    }
}