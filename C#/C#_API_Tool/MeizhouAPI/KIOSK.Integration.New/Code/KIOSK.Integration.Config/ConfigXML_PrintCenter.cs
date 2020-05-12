using System;
using System.Xml;
using System.IO;

using KIOSK.Integration.Util;

namespace KIOSK.Integration.Config
{
    /// <summary>
    /// XML configuration file for Print Center.
    /// </summary>
    public class ConfigXML_PrintCenter : ConfigXML
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

                // Parse InboundServiceRIS configuration.
                ((Config_PrintCenter)M_Config).M_LogFilePath = configXml.GetSingleNodeText("//KIOSKIntegration/PrintCenter/Log/LogFilePath");
                if (@".\" == ((Config_PrintCenter)M_Config).M_LogFilePath.Trim().Substring(0, 2))
                {
                    ((Config_PrintCenter)M_Config).M_LogFilePath = Path.Combine(
                        AppDomain.CurrentDomain.BaseDirectory,
                        ((Config_PrintCenter)M_Config).M_LogFilePath.Trim().Substring(2, ((Config_PrintCenter)M_Config).M_LogFilePath.Trim().Length - 2)
                        );
                }

                ((Config_PrintCenter)M_Config).M_LogLevel = configXml.GetSingleNodeText("//KIOSKIntegration/PrintCenter/Log/LogLevel");

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/PrintCenter/Log/LogFileKeepTime");
                if (strNodeText.Length == 0)
                {
                    strNodeText = "30";
                }
                ((Config_PrintCenter)M_Config).M_LogFileKeepTime = Int32.Parse(strNodeText);

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/PrintCenter/ExamDateBegin");
                if (strNodeText.Length == 0)
                {
                    strNodeText = "3";
                }
                ((Config_PrintCenter)M_Config).M_ExamDateBegin = strNodeText;

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/PrintCenter/ExamDateEnd");
                if (strNodeText.Length == 0)
                {
                    strNodeText = "0";
                }
                ((Config_PrintCenter)M_Config).M_ExamDateEnd = strNodeText;

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/PrintCenter/ExamTimeBegin");
                if (strNodeText.Length == 0)
                {
                    strNodeText = "00:00";
                }
                ((Config_PrintCenter)M_Config).M_ExamTimeBegin = strNodeText;

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/PrintCenter/ExamTimeEnd");
                if (strNodeText.Length == 0)
                {
                    strNodeText = "23:59";
                }
                ((Config_PrintCenter)M_Config).M_ExamTimeEnd = strNodeText;

                ((Config_PrintCenter)M_Config).M_SQLForGetPrintCenterTaskList = configXml.GetSingleNodeText("//KIOSKIntegration/PrintCenter/SQLForGetPrintCenterTaskList");
            }
            catch (Exception e)
            {
                throw new KIOSKIntegrationXmlDataException(e.Message);
            }
        }
    }
}