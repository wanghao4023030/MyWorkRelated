using System;
using System.IO;

using KIOSK.Integration.Util;
using KIOSK.Integration.Config;

namespace KIOSK.Integration.InboundService.RISReport.PDFGenerator
{
    partial class InboundServiceInstaller
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private System.ServiceProcess.ServiceProcessInstaller spiInboundServiceRISReportPDFGenerator;
        private System.ServiceProcess.ServiceInstaller siInboundServiceRISReportPDFGenerator;

        #region 组件设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            Config_InboundServiceRISReportPDFGenerator m_Config_InboundServiceRISReportPDFGenerator;
            ConfigXML_InboundServiceRISReportPDFGenerator m_ConfigXML_InboundServiceRISReportPDFGenerator;
            // Get filename of config.
            string strCurrentPath = AppDomain.CurrentDomain.BaseDirectory;
            string strConfigFileName = Path.Combine(strCurrentPath, KIOSKIntegrationConst.KIOSK_INTEGRATION_CONFIG_FILE);
            // Load config.
            m_ConfigXML_InboundServiceRISReportPDFGenerator = new ConfigXML_InboundServiceRISReportPDFGenerator();
            m_ConfigXML_InboundServiceRISReportPDFGenerator.M_ConfigFileName = strConfigFileName;
            m_Config_InboundServiceRISReportPDFGenerator = new Config_InboundServiceRISReportPDFGenerator();
            m_ConfigXML_InboundServiceRISReportPDFGenerator.M_Config = m_Config_InboundServiceRISReportPDFGenerator;
            m_ConfigXML_InboundServiceRISReportPDFGenerator.LoadConfig();

            this.spiInboundServiceRISReportPDFGenerator = new System.ServiceProcess.ServiceProcessInstaller();
            this.siInboundServiceRISReportPDFGenerator = new System.ServiceProcess.ServiceInstaller();
            // 
            // spiInboundServiceRISPDFGenerator
            // 
            this.spiInboundServiceRISReportPDFGenerator.Account = System.ServiceProcess.ServiceAccount.LocalSystem;
            this.spiInboundServiceRISReportPDFGenerator.Password = null;
            this.spiInboundServiceRISReportPDFGenerator.Username = null;
            this.spiInboundServiceRISReportPDFGenerator.AfterInstall += new System.Configuration.Install.InstallEventHandler(this.spiInboundServiceRISReportPDFGenerator_AfterInstall);
            // 
            // siInboundServiceRISPDFGenerator
            // 
            this.siInboundServiceRISReportPDFGenerator.Description = m_Config_InboundServiceRISReportPDFGenerator.M_ServiceDescription;
            this.siInboundServiceRISReportPDFGenerator.DisplayName = m_Config_InboundServiceRISReportPDFGenerator.M_ServiceName;
            this.siInboundServiceRISReportPDFGenerator.ServiceName = m_Config_InboundServiceRISReportPDFGenerator.M_ServiceName;
            //this.siInboundServiceRISReportPDFGenerator.Description = "KIOSK.Integration.InboundService.RISReport.PDFGenerator";
            //this.siInboundServiceRISReportPDFGenerator.DisplayName = "KIOSK.Integration.InboundService.RISReport.PDFGenerator";
            //this.siInboundServiceRISReportPDFGenerator.ServiceName = "KIOSK.Integration.InboundService.RISReport.PDFGenerator";
            this.siInboundServiceRISReportPDFGenerator.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            this.siInboundServiceRISReportPDFGenerator.AfterInstall += new System.Configuration.Install.InstallEventHandler(this.siInboundServiceRISReportPDFGenerator_AfterInstall);
            // 
            // InboundServiceInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.spiInboundServiceRISReportPDFGenerator,
            this.siInboundServiceRISReportPDFGenerator});
        }

        #endregion
    }
}