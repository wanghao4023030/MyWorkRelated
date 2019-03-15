using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using KIOSK.Integration.Config;

namespace KIOSK.Integration.Config
{
    public class Config_HL7InboundService:Config
    {
        private string m_LogFilePath;
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

        private string m_HL7IpAddress;
        public string M_HL7IpAddress
        {
            get
            {
                return m_HL7IpAddress;
            }
            set
            {
                m_HL7IpAddress = value;
            }
        }

        private int m_HL7Port;
        public int M_HL7Port
        {
            get
            {
                return m_HL7Port;
            }
            set
            {
                m_HL7Port = value;
            }
        }

        private int m_ListenPort;
        public int M_ListenPort
        {
            get
            {
                return m_ListenPort;
            }
            set
            {
                m_ListenPort = value;
            }
        }

        private string m_Protocol;
        public string M_Protocol
        {
            get
            {
                return m_Protocol;
            }
            set
            {
                m_Protocol = value;
            }
        }

        private string m_LogLevel;
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

        private int m_LogFileKeepTime;
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

        private string m_ExecSQL;
        public string M_ExecSQL
        {
            get
            {
                return m_ExecSQL;
            }
            set
            {
                m_ExecSQL = value;
            }
        }

        private string m_DBTyple;
        public string M_DBTyple
        {
            get
            {
                return m_DBTyple;
            }
            set
            {
                m_DBTyple = value;
            }
        }

        private string m_DBAddress;
        public string M_DBAddress
        {
            get
            {
                return m_DBAddress;
            }
            set
            {
                m_DBAddress = value;
            }
        }

        private string m_DBName;
        public string M_DBName
        {
            get
            {
                return m_DBName;
            }
            set
            {
                m_DBName = value;
            }
        }

        private string m_DBUser;
        public string M_DBUser
        {
            get
            {
                return m_DBUser;
            }
            set
            {
                m_DBUser = value;
            }
        }

        private string m_DBPassword;
        public string M_DBPassword
        {
            get
            {
                return m_DBPassword;
            }
            set
            {
                m_DBPassword = value;
            }
        }
    }
}
