using System;
using System.IO;

using KIOSK.Integration.Util;
using KIOSK.Integration.Config;

namespace KIOSK.Integration.InboundService.MWL.SCU
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

        private System.ServiceProcess.ServiceProcessInstaller spiInboundServiceMWLSCU;
        private System.ServiceProcess.ServiceInstaller siInboundServiceMWLSCU;

        #region 组件设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            Config_InboundServiceMWLSCU m_Config_InboundServiceMWLSCU;
            ConfigXML_InboundServiceMWLSCU m_ConfigXML_InboundServiceMWLSCU;
            // Get filename of config.
            string strCurrentPath = AppDomain.CurrentDomain.BaseDirectory;
            string strConfigFileName = Path.Combine(strCurrentPath, KIOSKIntegrationConst.KIOSK_INTEGRATION_CONFIG_FILE);
            // Load config.
            m_ConfigXML_InboundServiceMWLSCU = new ConfigXML_InboundServiceMWLSCU();
            m_ConfigXML_InboundServiceMWLSCU.M_ConfigFileName = strConfigFileName;
            m_Config_InboundServiceMWLSCU = new Config_InboundServiceMWLSCU();
            m_ConfigXML_InboundServiceMWLSCU.M_Config = m_Config_InboundServiceMWLSCU;
            m_ConfigXML_InboundServiceMWLSCU.LoadConfig();

            this.spiInboundServiceMWLSCU = new System.ServiceProcess.ServiceProcessInstaller();
            this.siInboundServiceMWLSCU = new System.ServiceProcess.ServiceInstaller();
            // 
            // spiInboundServiceMWLSCU
            // 
            this.spiInboundServiceMWLSCU.Account = System.ServiceProcess.ServiceAccount.LocalSystem;
            this.spiInboundServiceMWLSCU.Password = null;
            this.spiInboundServiceMWLSCU.Username = null;
            this.spiInboundServiceMWLSCU.AfterInstall += new System.Configuration.Install.InstallEventHandler(this.spiInboundServiceMWLSCU_AfterInstall);
            // 
            // siInboundServiceMWLSCU
            // 
            this.siInboundServiceMWLSCU.Description = m_Config_InboundServiceMWLSCU.M_ServiceDescription;
            this.siInboundServiceMWLSCU.DisplayName = m_Config_InboundServiceMWLSCU.M_ServiceName;
            this.siInboundServiceMWLSCU.ServiceName = m_Config_InboundServiceMWLSCU.M_ServiceName;
            //this.siInboundServiceMWLSCU.Description = "KIOSK.Integration.InboundService.MWL.SCU";
            //this.siInboundServiceMWLSCU.DisplayName = "KIOSK.Integration.InboundService.MWL.SCU";
            //this.siInboundServiceMWLSCU.ServiceName = "KIOSK.Integration.InboundService.MWL.SCU";
            this.siInboundServiceMWLSCU.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            this.siInboundServiceMWLSCU.AfterInstall += new System.Configuration.Install.InstallEventHandler(this.siInboundServiceMWLSCU_AfterInstall);
            // 
            // InboundServiceInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.spiInboundServiceMWLSCU,
            this.siInboundServiceMWLSCU});

        }

        #endregion
    }
}