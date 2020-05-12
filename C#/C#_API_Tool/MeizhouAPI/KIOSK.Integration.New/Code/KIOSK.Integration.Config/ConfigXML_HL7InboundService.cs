using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.IO;

using KIOSK.Integration.Util;

namespace KIOSK.Integration.Config
{
    public class ConfigXML_HL7InboundService:ConfigXML
    {
        /// <summary>
        /// Load configuration information.
        /// </summary>
        public override void LoadConfig()
        {
            // parameter check.
            if (M_ConfigFileName.Length <= 0)
            {
                throw new ArgumentException("Configuration File Name is a zero-length string.");
            }

            try
            {
                // Load xml file.
                m_ConfigXml = new XmlDocument();
                m_ConfigXml.Load(M_ConfigFileName);
            }
            catch (Exception e)
            {
                throw new KIOSKIntegrationXmlFormatException(e.Message);
            }

            // Load base config.
            base.LoadConfig();

            try
            {
                KIOSKIntegrationXML configXml = new KIOSKIntegrationXML(m_ConfigXml);

                string strNodeText = "";

                // Parse InboundServiceMWLSCU configuration.
                ((Config_HL7InboundService)M_Config).M_LogFilePath = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceHL7/Log/LogFilePath");
                if (@".\" == ((Config_HL7InboundService)M_Config).M_LogFilePath.Trim().Substring(0, 2))
                {
                    ((Config_HL7InboundService)M_Config).M_LogFilePath = Path.Combine(
                        AppDomain.CurrentDomain.BaseDirectory,
                        ((Config_HL7InboundService)M_Config).M_LogFilePath.Trim().Substring(2, ((Config_InboundServiceMWLSCU)M_Config).M_LogFilePath.Trim().Length - 2)
                        );
                }

                ((Config_HL7InboundService)M_Config).M_LogLevel = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceHL7/Log/LogLevel");

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceHL7/Log/LogFileKeepTime");
                if (strNodeText.Length == 0)
                {
                    strNodeText = "30";
                }
                ((Config_HL7InboundService)M_Config).M_LogFileKeepTime = Int32.Parse(strNodeText);

                ((Config_HL7InboundService)M_Config).M_HL7IpAddress = configXml.GetSingleNodeText("//KIOSKIntegration/HL7/HL7IPAddress");
                ((Config_HL7InboundService)M_Config).M_HL7Port = int.Parse(configXml.GetSingleNodeText("//KIOSKIntegration/HL7/HL7Port"));
                ((Config_HL7InboundService)M_Config).M_ListenPort = int.Parse(configXml.GetSingleNodeText("//KIOSKIntegration/HL7/ListenPort"));
                ((Config_HL7InboundService)M_Config).M_Protocol = configXml.GetSingleNodeText("//KIOSKIntegration/HL7/Protocol");
                ((Config_HL7InboundService)M_Config).M_ExecSQL = configXml.GetSingleNodeText("//KIOSKIntegration/HL7/RISDB");

                ((Config_HL7InboundService)M_Config).M_DBTyple = configXml.GetSingleNodeText("//KIOSKIntegration/RISDB/DBType");
                ((Config_HL7InboundService)M_Config).M_DBAddress = configXml.GetSingleNodeText("//KIOSKIntegration/RISDB/DBServer");
                ((Config_HL7InboundService)M_Config).M_DBName = configXml.GetSingleNodeText("//KIOSKIntegration/RISDB/DBName");
                ((Config_HL7InboundService)M_Config).M_DBUser = configXml.GetSingleNodeText("//KIOSKIntegration/RISDB/DBUserName");
                ((Config_HL7InboundService)M_Config).M_DBPassword = configXml.GetSingleNodeText("//KIOSKIntegration/RISDB/DBPassword");
            }
            catch (Exception e)
            {
                throw new KIOSKIntegrationXmlDataException(e.Message);
            }
        }
    }
}
