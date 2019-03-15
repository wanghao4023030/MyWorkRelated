namespace KIOSK.Integration.Config
{
    /// <summary>
    /// Configuration information base class.
    /// </summary>
    public abstract class Config
    {
        /// <summary>
        /// RIS Database Type: MSSQL MYSQL ORACLE.
        /// </summary>
        private string m_RISDBType;
        /// <summary>
        /// Gets or sets RIS database type.
        /// <value>RIS Database type.</value>
        /// </summary>
        public string M_RISDBType
        {
            get
            {
                return m_RISDBType;
            }
            set
            {
                m_RISDBType = value;
            }
        }

        /// <summary>
        /// RIS Database server's name or ip address.
        /// </summary>
        private string m_RISDBServer;
        /// <summary>
        /// Gets or sets RIS database server's name or ip address.
        /// <value>RIS Database server's name or ip address.</value>
        /// </summary>
        public string M_RISDBServer
        {
            get
            {
                return m_RISDBServer;
            }
            set
            {
                m_RISDBServer = value;
            }
        }

        /// <summary>
        /// RIS Database's name.
        /// </summary>
        private string m_RISDBName;
        /// <summary>
        /// Gets or sets RIS database's name.
        /// <value>RIS Database's name.</value>
        /// </summary>
        public string M_RISDBName
        {
            get
            {
                return m_RISDBName;
            }
            set
            {
                m_RISDBName = value;
            }
        }

        /// <summary>
        /// RIS Database's user name.
        /// </summary>
        private string m_RISDBUserName;
        /// <summary>
        /// Gets or sets RIS database's user name.
        /// <value>RIS Database's user name.</value>
        /// </summary>
        public string M_RISDBUserName
        {
            get
            {
                return m_RISDBUserName;
            }
            set
            {
                m_RISDBUserName = value;
            }
        }

        /// <summary>
        /// RIS Database's access password.
        /// </summary>
        private string m_RISDBPassword;
        /// <summary>
        /// Gets or sets RIS database's access password.
        /// <value>RIS Database's access password.</value>
        /// </summary>
        public string M_RISDBPassword
        {
            get
            {
                return m_RISDBPassword;
            }
            set
            {
                m_RISDBPassword = value;
            }
        }

        /// <summary>
        /// PS Database server's name or ip address.
        /// </summary>
        private string m_PSDBServer;
        /// <summary>
        /// Gets or sets PS database server's name or ip address.
        /// <value>PS Database server's name or ip address.</value>
        /// </summary>
        public string M_PSDBServer
        {
            get
            {
                return m_PSDBServer;
            }
            set
            {
                m_PSDBServer = value;
            }
        }

        /// <summary>
        /// PS Database's name.
        /// </summary>
        private string m_PSDBName;
        /// <summary>
        /// Gets or sets PS database's name.
        /// <value>PS Database's name.</value>
        /// </summary>
        public string M_PSDBName
        {
            get
            {
                return m_PSDBName;
            }
            set
            {
                m_PSDBName = value;
            }
        }

        /// <summary>
        /// PS Database's user name.
        /// </summary>
        private string m_PSDBUserName;
        /// <summary>
        /// Gets or sets PS database's user name.
        /// <value>PS Database's user name.</value>
        /// </summary>
        public string M_PSDBUserName
        {
            get
            {
                return m_PSDBUserName;
            }
            set
            {
                m_PSDBUserName = value;
            }
        }

        /// <summary>
        /// PS Database's access password.
        /// </summary>
        private string m_PSDBPassword;
        /// <summary>
        /// Gets or sets PS database's access password.
        /// <value>PS Database's access password.</value>
        /// </summary>
        public string M_PSDBPassword
        {
            get
            {
                return m_PSDBPassword;
            }
            set
            {
                m_PSDBPassword = value;
            }
        }

        /// <summary>
        /// MWL Enabled: 0 or 1.
        /// </summary>
        private string m_MWLEnabled;
        /// <summary>
        /// Gets or sets MWL Enabled.
        /// <value>MWL Enabled Flag.</value>
        /// </summary>
        public string M_MWLEnabled
        {
            get
            {
                return m_MWLEnabled;
            }
            set
            {
                m_MWLEnabled = value;
            }
        }

        /// <summary>
        /// MWL SCU Node.
        /// </summary>
        private string m_MWLNode;
        /// <summary>
        /// Gets or sets MWL SCU Node.
        /// </summary>
        public string M_MWLNode
        {
            get
            {
                return m_MWLNode;
            }
            set
            {
                m_MWLNode = value;
            }
        }

        /// <summary>
        /// MWL SCU Port.
        /// </summary>
        private string m_MWLPort;
        /// <summary>
        /// Gets or sets MWL SCU Port.
        /// </summary>
        public string M_MWLPort
        {
            get
            {
                return m_MWLPort;
            }
            set
            {
                m_MWLPort = value;
            }
        }

        /// <summary>
        /// MWL SCU CalledAE
        /// </summary>
        private string m_MWLCalledAE;
        /// <summary>
        /// Gets or sets MWL SCU CalledAE.
        /// <value>MWL SCU CalledAE.</value>
        /// </summary>
        public string M_MWLCalledAE
        {
            get
            {
                return m_MWLCalledAE;
            }
            set
            {
                m_MWLCalledAE = value;
            }
        }

        /// <summary>
        /// MWL SCU CallingAE.
        /// </summary>
        private string m_MWLCallingAE;
        /// <summary>
        /// Gets or sets MWL SCU CallingAE.
        /// <value>MWL SCU CallingAE.</value>
        /// </summary>
        public string M_MWLCallingAE
        {
            get
            {
                return m_MWLCallingAE;
            }
            set
            {
                m_MWLCallingAE = value;
            }
        }
    }
}