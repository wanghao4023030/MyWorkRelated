using System;
using System.Xml;
using System.IO;

using KIOSK.Integration.Util;

namespace KIOSK.Integration.Config
{
    /// <summary>
    /// XML configuration file for WS Proxy.
    /// </summary>
    public class ConfigXML_WSProxy : ConfigXML
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
                ((Config_WSProxy)M_Config).M_LogFilePath = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/Log/LogFilePath");
                if (@".\" == ((Config_WSProxy)M_Config).M_LogFilePath.Trim().Substring(0, 2))
                {
                    ((Config_WSProxy)M_Config).M_LogFilePath = Path.Combine(
                        AppDomain.CurrentDomain.BaseDirectory,
                        ((Config_WSProxy)M_Config).M_LogFilePath.Trim().Substring(2, ((Config_WSProxy)M_Config).M_LogFilePath.Trim().Length - 2)
                        );
                }

                ((Config_WSProxy)M_Config).M_LogLevel = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/Log/LogLevel");

                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/Log/LogFileKeepTime");
                if (strNodeText.Length == 0)
                {
                    strNodeText = "30";
                }
                ((Config_WSProxy)M_Config).M_LogFileKeepTime = Int32.Parse(strNodeText);

                ((Config_WSProxy)M_Config).M_XSLTPathForQueryExamInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/XSLTPathForQueryExamInfo");
                ((Config_WSProxy)M_Config).M_XSLTPathForUpdateExamInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/XSLTPathForUpdateExamInfo");
                ((Config_WSProxy)M_Config).M_PDFPhysicPath = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PDFPhysicPath");
                ((Config_WSProxy)M_Config).M_PDFFTPPath = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PDFFTPPath");

                ((Config_WSProxy)M_Config).M_WSURL_PS = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/WSURL/PS");
                ((Config_WSProxy)M_Config).M_WSURL_RISExamInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/WSURL/RISExamInfo");
                ((Config_WSProxy)M_Config).M_WSURL_RISPDFReportInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/WSURL/RISPDFReportInfo");
                ((Config_WSProxy)M_Config).M_WSURL_RISOtherInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/WSURL/RISOtherInfo");

                ((Config_WSProxy)M_Config).M_SQLForGetRISReportInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/RISDB/SQLForGetRISReportInfo");
                ((Config_WSProxy)M_Config).M_SQLForSetRISReportInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/RISDB/SQLForSetRISReportInfo");
                ((Config_WSProxy)M_Config).M_SQLForGetRISExamInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/RISDB/SQLForGetRISExamInfo");
                ((Config_WSProxy)M_Config).M_SQLForGetRISExamInfoEx = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/RISDB/SQLForGetRISExamInfoEx");

                ((Config_WSProxy)M_Config).M_SQLForSetPSExamInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PSDB/SQLForSetPSExamInfo");
                ((Config_WSProxy)M_Config).M_SQLForGetPSExamInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PSDB/SQLForGetPSExamInfo");
                ((Config_WSProxy)M_Config).M_SQLForGetPSReportInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PSDB/SQLForGetPSReportInfo");
                ((Config_WSProxy)M_Config).M_SQLForGetPSPrintMode = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PSDB/SQLForGetPSPrintMode");
                ((Config_WSProxy)M_Config).M_SQLForGetPSPatientInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PSDB/SQLForGetPSPatientInfo");
                ((Config_WSProxy)M_Config).M_SQLForUpdateTerminalInfo = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PSDB/SQLForUpdateTerminalInfo");
                ((Config_WSProxy)M_Config).M_strGetReportUrl = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PSDB/SQLForGetReportUrl");
                
                strNodeText = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/GetReportType");
                if (0 == strNodeText.Trim().Length)
                    strNodeText = "0";
                ((Config_WSProxy)M_Config).M_iGetReportType = Int32.Parse(strNodeText);

                ((Config_WSProxy)M_Config).M_strSwingReport = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/SwingGetReport");


                ((Config_WSProxy)M_Config).M_strSQLForGetUnprintedFilms = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PSDB/SQLForGetUnPrintedFilms");
                ((Config_WSProxy)M_Config).M_strSQLForUpdateFilmPrintStatus = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PSDB/SQLForUpdateFilmStatus");
                ((Config_WSProxy)M_Config).M_strSQLForUpdateReportPrintStatus = configXml.GetSingleNodeText("//KIOSKIntegration/WSProxy/PSDB/SQLForUpdateReportStatus");
            }
            catch (Exception e)
            {
                throw new KIOSKIntegrationXmlDataException(e.Message);
            }
        }
    }
}