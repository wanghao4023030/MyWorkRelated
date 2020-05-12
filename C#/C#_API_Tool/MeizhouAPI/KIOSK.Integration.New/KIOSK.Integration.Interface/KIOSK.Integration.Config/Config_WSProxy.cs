namespace KIOSK.Integration.Config
{
    /// <summary>
    /// Configuration information of WS Proxy.
    /// </summary>
    public class Config_WSProxy : Config
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

        private string m_XSLTPathForQueryExamInfo;
        public string M_XSLTPathForQueryExamInfo
        {
            get
            {
                return m_XSLTPathForQueryExamInfo;
            }
            set
            {
                m_XSLTPathForQueryExamInfo = value;
            }
        }

        private string m_XSLTPathForUpdateExamInfo;
        public string M_XSLTPathForUpdateExamInfo
        {
            get
            {
                return m_XSLTPathForUpdateExamInfo;
            }
            set
            {
                m_XSLTPathForUpdateExamInfo = value;
            }
        }

        private string m_PDFPhysicPath;
        public string M_PDFPhysicPath
        {
            get
            {
                return m_PDFPhysicPath;
            }
            set
            {
                m_PDFPhysicPath = value;
            }
        }

        private string m_PDFFTPPath;
        public string M_PDFFTPPath
        {
            get
            {
                return m_PDFFTPPath;
            }
            set
            {
                m_PDFFTPPath = value;
            }
        }

        private string m_WSURL_PS;
        public string M_WSURL_PS
        {
            get
            {
                return m_WSURL_PS;
            }
            set
            {
                m_WSURL_PS = value;
            }
        }

        private string m_WSURL_RISExamInfo;
        public string M_WSURL_RISExamInfo
        {
            get
            {
                return m_WSURL_RISExamInfo;
            }
            set
            {
                m_WSURL_RISExamInfo = value;
            }
        }

        private string m_WSURL_RISPDFReportInfo;
        public string M_WSURL_RISPDFReportInfo
        {
            get
            {
                return m_WSURL_RISPDFReportInfo;
            }
            set
            {
                m_WSURL_RISPDFReportInfo = value;
            }
        }

        private string m_WSURL_RISOtherInfo;
        public string M_WSURL_RISOtherInfo
        {
            get
            {
                return m_WSURL_RISOtherInfo;
            }
            set
            {
                m_WSURL_RISOtherInfo = value;
            }
        }

        private string m_SQLForGetRISReportInfo;
        public string M_SQLForGetRISReportInfo
        {
            get
            {
                return m_SQLForGetRISReportInfo;
            }
            set
            {
                m_SQLForGetRISReportInfo = value;
            }
        }

        private string m_SQLForSetRISReportInfo;
        public string M_SQLForSetRISReportInfo
        {
            get
            {
                return m_SQLForSetRISReportInfo;
            }
            set
            {
                m_SQLForSetRISReportInfo = value;
            }
        }

        private string m_SQLForGetRISExamInfo;
        public string M_SQLForGetRISExamInfo
        {
            get
            {
                return m_SQLForGetRISExamInfo;
            }
            set
            {
                m_SQLForGetRISExamInfo = value;
            }
        }

        private string m_SQLForGetRISExamInfoEx;
        public string M_SQLForGetRISExamInfoEx
        {
            get
            {
                return m_SQLForGetRISExamInfoEx;
            }
            set
            {
                m_SQLForGetRISExamInfoEx = value;
            }
        }

        private string m_SQLForSetPSExamInfo;
        public string M_SQLForSetPSExamInfo
        {
            get
            {
                return m_SQLForSetPSExamInfo;
            }
            set
            {
                m_SQLForSetPSExamInfo = value;
            }
        }

        private string m_SQLForGetPSExamInfo;
        public string M_SQLForGetPSExamInfo
        {
            get
            {
                return m_SQLForGetPSExamInfo;
            }
            set
            {
                m_SQLForGetPSExamInfo = value;
            }
        }

        private string m_SQLForGetPSReportInfo;
        public string M_SQLForGetPSReportInfo
        {
            get
            {
                return m_SQLForGetPSReportInfo;
            }
            set
            {
                m_SQLForGetPSReportInfo = value;
            }
        }

        private string m_SQLForGetPSPrintMode;
        public string M_SQLForGetPSPrintMode
        {
            get
            {
                return m_SQLForGetPSPrintMode;
            }
            set
            {
                m_SQLForGetPSPrintMode = value;
            }
        }

        private string m_SQLForGetPSPatientInfo;
        public string M_SQLForGetPSPatientInfo
        {
            get
            {
                return m_SQLForGetPSPatientInfo;
            }
            set
            {
                m_SQLForGetPSPatientInfo = value;
            }
        }

        private string m_SQLForUpdateTerminalInfo;
        public string M_SQLForUpdateTerminalInfo
        {
            get
            {
                return m_SQLForUpdateTerminalInfo;
            }
            set
            {
                m_SQLForUpdateTerminalInfo = value;
            }
        }

        private int m_iGetReportType;
        public int M_iGetReportType
        {
            get
            {
                return m_iGetReportType;
            }
            set
            {
                m_iGetReportType = value;
            }
        }

        private string m_strSwingReport;
        public string M_strSwingReport
        {
            get
            {
                return m_strSwingReport;
            }
            set
            {
                m_strSwingReport = value;
            }
        }

        private string m_strGetReportUrl;
        public string M_strGetReportUrl
        {
            get
            {
                return m_strGetReportUrl;
            }
            set
            {
                m_strGetReportUrl = value;
            }
        }
        // add
        private string m_strSQLForGetUnprintedFilms;
        public string M_strSQLForGetUnprintedFilms
        {
            get
            {
                return m_strSQLForGetUnprintedFilms;
            }
            set
            {
                m_strSQLForGetUnprintedFilms = value;
            }
        }

        private string m_strSQLForUpdateFilmPrintStatus;
        public string M_strSQLForUpdateFilmPrintStatus
        {
            get
            {
                return m_strSQLForUpdateFilmPrintStatus;
            }
            set
            {
                m_strSQLForUpdateFilmPrintStatus = value;
            }
        }

        private string m_strSQLForUpdateReportPrintStatus;
        public string M_strSQLForUpdateReportPrintStatus
        {
            get
            {
                return m_strSQLForUpdateReportPrintStatus;
            }
            set
            {
                m_strSQLForUpdateReportPrintStatus = value;
            }
        }
    }
}