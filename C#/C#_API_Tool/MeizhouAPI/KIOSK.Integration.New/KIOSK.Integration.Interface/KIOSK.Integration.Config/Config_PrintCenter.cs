namespace KIOSK.Integration.Config
{
    /// <summary>
    /// Configuration information of PrintCenter.
    /// </summary>
    public class Config_PrintCenter : Config
    {
        /// <summary>
        /// Log file's store path.
        /// </summary>
        private string m_LogFilePath;
        /// <summary>
        /// Gets or sets log file's store path.
        /// <value>Log file's store path.</value>
        /// </summary>
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
        /// Log level.
        /// </summary>
        private string m_LogLevel;
        /// <summary>
        /// Gets or sets log level.
        /// <value>Log level.</value>
        /// </summary>
        public string M_LogLevel
        {
            get
            {
                return m_LogLevel;
            }
            set
            {
                m_LogLevel = value;
            }
        }

        /// <summary>
        /// Log file's keep time(unit:day).
        /// </summary>
        private int m_LogFileKeepTime;
        /// <summary>
        /// Gets or sets log file's keep time.
        /// <value>Log file's keep time(unit:day).</value>
        /// </summary>
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
        /// The begin that exam date.
        /// </summary>
        private string m_ExamDateBegin;
        /// <summary>
        /// Gets or sets the begin that exam date.
        /// <value>The begin that exam date.</value>
        /// </summary>
        public string M_ExamDateBegin
        {
            get
            {
                return m_ExamDateBegin;
            }
            set
            {
                m_ExamDateBegin = value;
            }
        }

        /// <summary>
        /// The end that exam date.
        /// </summary>
        private string m_ExamDateEnd;
        /// <summary>
        /// Gets or sets the end that exam date.
        /// <value>The end that exam date.</value>
        /// </summary>
        public string M_ExamDateEnd
        {
            get
            {
                return m_ExamDateEnd;
            }
            set
            {
                m_ExamDateEnd = value;
            }
        }

        /// <summary>
        /// The begin that exam time.
        /// </summary>
        private string m_ExamTimeBegin;
        /// <summary>
        /// Gets or sets the begin that exam time.
        /// <value>The begin that exam time.</value>
        /// </summary>
        public string M_ExamTimeBegin
        {
            get
            {
                return m_ExamTimeBegin;
            }
            set
            {
                m_ExamTimeBegin = value;
            }
        }

        /// <summary>
        /// The end that exam time.
        /// </summary>
        private string m_ExamTimeEnd;
        /// <summary>
        /// Gets or sets the end that exam time.
        /// <value>The end that exam time.</value>
        /// </summary>
        public string M_ExamTimeEnd
        {
            get
            {
                return m_ExamTimeEnd;
            }
            set
            {
                m_ExamTimeEnd = value;
            }
        }
        /// <summary>
        /// SQL For Get Print Center TaskList.
        /// </summary>
        private string m_SQLForGetPrintCenterTaskList;
        /// <summary>
        /// Gets or sets SQL For Get Print Center TaskList.
        /// </summary>
        public string M_SQLForGetPrintCenterTaskList
        {
            get
            {
                return m_SQLForGetPrintCenterTaskList;
            }
            set
            {
                m_SQLForGetPrintCenterTaskList = value;
            }
        }
    }
}