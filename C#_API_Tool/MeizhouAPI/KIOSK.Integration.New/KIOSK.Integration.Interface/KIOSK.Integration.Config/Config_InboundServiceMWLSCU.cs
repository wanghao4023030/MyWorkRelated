namespace KIOSK.Integration.Config
{
    /// <summary>
    /// Configuration information of Inbound Service MWL SCU.
    /// </summary>
    public class Config_InboundServiceMWLSCU : Config
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
        /// The windows service's name of this instance.
        /// </summary>
        private string m_ServiceName;
        /// <summary>
        /// Gets or sets the windows service's name of this instance.
        /// </summary>
        /// <value>The windows service's name of this instance.</value>
        public string M_ServiceName
        {
            get
            {
                return m_ServiceName;
            }
            set
            {
                m_ServiceName = value;
            }
        }

        /// <summary>
        /// The windows service's description of this instance.
        /// </summary>
        private string m_ServiceDescription;
        /// <summary>
        /// Gets or sets the windows service's description of this instance.
        /// </summary>
        /// <value>The windows service's description of this instance.</value>
        public string M_ServiceDescription
        {
            get
            {
                return m_ServiceDescription;
            }
            set
            {
                m_ServiceDescription = value;
            }
        }

        /// <summary>
        /// The interval of watch time.
        /// </summary>
        private int m_ServiceWatchTime;
        /// <summary>
        /// Gets or sets the interval of watch time.
        /// <value>The interval of watch time.</value>
        /// </summary>
        public int M_ServiceWatchTime
        {
            get
            {
                return m_ServiceWatchTime;
            }
            set
            {
                m_ServiceWatchTime = value;
            }
        }

        /// <summary>
        /// The begin that watch time.
        /// </summary>
        private string m_ServiceBeginTime;
        /// <summary>
        /// Gets or sets the begin that watch time.
        /// <value>The begin that watch time.</value>
        /// </summary>
        public string M_ServiceBeginTime
        {
            get
            {
                return m_ServiceBeginTime;
            }
            set
            {
                m_ServiceBeginTime = value;
            }
        }

        /// <summary>
        /// The end that watch time.
        /// </summary>
        private string m_ServiceEndTime;
        /// <summary>
        /// Gets or sets the end that watch time.
        /// <value>The end that watch time.</value>
        /// </summary>
        public string M_ServiceEndTime
        {
            get
            {
                return m_ServiceEndTime;
            }
            set
            {
                m_ServiceEndTime = value;
            }
        }

        /// <summary>
        /// Query MWL Study Modality.
        /// </summary>
        private string m_Modality;
        /// <summary>
        /// Gets or sets MWL Study Modality.
        /// </summary>
        public string M_Modality
        {
            get
            {
                return m_Modality;
            }
            set
            {
                m_Modality = value;
            }
        }

        /// <summary>
        /// Query MWL Study Time Span.
        /// </summary>
        private string m_StudyTimeSpan;
        /// <summary>
        /// Gets or sets Query MWL Study Time Span.
        /// </summary>
        public string M_StudyTimeSpan
        {
            get
            {
                return m_StudyTimeSpan;
            }
            set
            {
                m_StudyTimeSpan = value;
            }
        }
    }
}