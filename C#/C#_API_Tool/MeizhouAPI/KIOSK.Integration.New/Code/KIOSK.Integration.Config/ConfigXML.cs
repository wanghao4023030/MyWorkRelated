using System;
using System.Xml;
using System.IO;

using KIOSK.Integration.Util;

namespace KIOSK.Integration.Config
{
    /// <summary>
    /// The base class of XML configuration file.
    /// </summary>
    public abstract class ConfigXML
    {
        /// <summary>
        /// XML file object.
        /// </summary>
        protected XmlDocument m_ConfigXml;

        /// <summary>
        /// Configuration information.
        /// </summary>
        private Config m_Config;

        /// <summary>
        /// Gets or sets configuration information.
        /// </summary>
        /// <value>Configuration information.</value>
        public Config M_Config
        {
            get
            {
                return m_Config;
            }
            set
            {
                m_Config = value;
            }
        }

        /// <summary>
        /// The file name of configuration file.
        /// </summary>
        private string m_ConfigFileName;

        /// <summary>
        /// Gets or sets the filename of configuration file.
        /// </summary>
        /// <value>The filename of configuration file.</value>
        public string M_ConfigFileName
        {
            get
            {
                return m_ConfigFileName;
            }
            set
            {
                m_ConfigFileName = value;
            }
        }

        /// <summary>
        /// Load configuration information.
        /// </summary>
        public virtual void LoadConfig()
        {
            // parameter check.
            if (M_ConfigFileName.Length <= 0)
            {
                throw new ArgumentException("Configuration File Name is a zero-length string.");
            }

            // Data validation.
            try
            {
                if (m_ConfigXml == null)
                {
                    // Load xml file
                    m_ConfigXml = new XmlDocument();
                    m_ConfigXml.Load(M_ConfigFileName);
                }
            }
            catch (Exception e)
            {
                throw new KIOSKIntegrationXmlFormatException(e.Message);
            }

            try
            {
                KIOSKIntegrationXML configXml = new KIOSKIntegrationXML(m_ConfigXml);

                // Parse xml file.
                M_Config.M_RISDBType = configXml.GetSingleNodeText("//KIOSKIntegration/RISDB/DBType");
                M_Config.M_RISDBServer = configXml.GetSingleNodeText("//KIOSKIntegration/RISDB/DBServer");
                M_Config.M_RISDBName = configXml.GetSingleNodeText("//KIOSKIntegration/RISDB/DBName");
                M_Config.M_RISDBUserName = configXml.GetSingleNodeText("//KIOSKIntegration/RISDB/DBUserName");
                M_Config.M_RISDBPassword = configXml.GetSingleNodeText("//KIOSKIntegration/RISDB/DBPassword");

                M_Config.M_PSDBServer = configXml.GetSingleNodeText("//KIOSKIntegration/PSDB/DBServer");
                M_Config.M_PSDBName = configXml.GetSingleNodeText("//KIOSKIntegration/PSDB/DBName");
                M_Config.M_PSDBUserName = configXml.GetSingleNodeText("//KIOSKIntegration/PSDB/DBUserName");
                M_Config.M_PSDBPassword = configXml.GetSingleNodeText("//KIOSKIntegration/PSDB/DBPassword");

                M_Config.M_MWLEnabled = configXml.GetSingleNodeText("//KIOSKIntegration/MWL/Enabled");
                M_Config.M_MWLNode = configXml.GetSingleNodeText("//KIOSKIntegration/MWL/Node");
                M_Config.M_MWLPort = configXml.GetSingleNodeText("//KIOSKIntegration/MWL/Port");
                M_Config.M_MWLCalledAE = configXml.GetSingleNodeText("//KIOSKIntegration/MWL/CalledAE");
                M_Config.M_MWLCallingAE = configXml.GetSingleNodeText("//KIOSKIntegration/MWL/CallingAE");
            }
            catch (Exception e)
            {
                throw new KIOSKIntegrationXmlDataException(e.Message);
            }
        }

        /// <summary>
        /// Save configuration information.
        /// </summary>
        public virtual void SaveConfig()
        {
            throw new System.NotImplementedException();
        }
    }
}