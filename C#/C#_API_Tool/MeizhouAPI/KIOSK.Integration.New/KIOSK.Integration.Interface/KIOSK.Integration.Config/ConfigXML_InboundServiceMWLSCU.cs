using System;
using System.Xml;
using System.IO;

using KIOSK.Integration.Util;

namespace KIOSK.Integration.Config
{
    /// <summary>
    /// XML configuration file for Inbound Service MWL SCU.
    /// </summary>
    public class ConfigXML_InboundServiceMWLSCU : ConfigXML
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
                ((Config_InboundServiceMWLSCU)M_Config).M_LogFilePath = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceMWLSCU/Log/LogFilePath");
                if (@".\" == ((Config_InboundServiceMWLSCU)M_Config).M_LogFilePath.Trim().Substring(0, 2))
                {
                    ((Config_InboundServiceMWLSCU)M_Config).M_LogFilePath = Path.Combine(
                        AppDomain.CurrentDomain.BaseDirectory,
                        ((Config_InboundServiceMWLSCU)M_Config).M_LogFilePath.Trim().Substring(2, ((Config_InboundServiceMWLSCU)M_Config).M_LogFilePath.Trim().Length - 2)
                        );
                }

                ((Config_InboundServiceMWLSCU)M_Config).M_LogLevel = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceMWLSCU/Log/LogLevel");

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceMWLSCU/Log/LogFileKeepTime");
                if (strNodeText.Length == 0)
                {
                    strNodeText = "30";
                }
                ((Config_InboundServiceMWLSCU)M_Config).M_LogFileKeepTime = Int32.Parse(strNodeText);

                ((Config_InboundServiceMWLSCU)M_Config).M_ServiceName = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceMWLSCU/ServiceName");
                ((Config_InboundServiceMWLSCU)M_Config).M_ServiceDescription = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceMWLSCU/ServiceDescription");

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceMWLSCU/ServiceWatchTime");
                if (strNodeText.Length == 0)
                {
                    strNodeText = "3";
                }
                ((Config_InboundServiceMWLSCU)M_Config).M_ServiceWatchTime = Int32.Parse(strNodeText);

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceMWLSCU/ServiceBeginTime");
                try
                {
                    strNodeText = strNodeText.Trim();
                    Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd") + " " + strNodeText);
                }
                catch
                {
                    strNodeText = "00:00:00";
                }
                ((Config_InboundServiceMWLSCU)M_Config).M_ServiceBeginTime = strNodeText;

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceMWLSCU/ServiceEndTime");
                try
                {
                    strNodeText = strNodeText.Trim();
                    Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd") + " " + strNodeText);
                }
                catch
                {
                    strNodeText = "23:59:59";
                }
                ((Config_InboundServiceMWLSCU)M_Config).M_ServiceEndTime = strNodeText;

                ((Config_InboundServiceMWLSCU)M_Config).M_Modality = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceMWLSCU/Modality");

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/InboundServiceMWLSCU/StudyTimeSpan");
                try
                {
                    strNodeText = strNodeText.Trim();
                    Convert.ToInt32(strNodeText);
                }
                catch
                {
                    strNodeText = "1";
                }
                ((Config_InboundServiceMWLSCU)M_Config).M_StudyTimeSpan = strNodeText;
            }
            catch (Exception e)
            {
                throw new KIOSKIntegrationXmlDataException(e.Message);
            }
        }
    }
}