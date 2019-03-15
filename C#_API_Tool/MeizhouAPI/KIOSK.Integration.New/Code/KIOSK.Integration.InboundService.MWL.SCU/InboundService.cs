using System;
using System.Diagnostics;
using System.IO;
using System.ServiceProcess;
using System.Timers;

using KIOSK.Integration.Util;
using KIOSK.Integration.Config;
using KIOSK.Integration.Log;

namespace KIOSK.Integration.InboundService.MWL.SCU
{
    public partial class InboundService : ServiceBase
    {
        #region variable definition

        /// <summary>
        /// Business deal timer
        /// </summary>
        Timer timerMainCallback;
        /// <summary>
        /// Business deal timer's lock.
        /// </summary>
        private Object timerMainCallbackLock = new object();
        /// <summary>
        /// Service's pause flag.
        /// </summary>
        private bool m_IsPaused = false;
        /// <summary>
        /// Service's stop flag.
        /// </summary>
        private bool m_IsStopped = false;
        /// <summary>
        /// Reads or writes the config information of MWL SCU service.
        /// </summary>
        private Config_InboundServiceMWLSCU m_Config_InboundServiceMWLSCU;
        /// <summary>
        /// The config information of MWL SCU service.
        /// </summary>
        private ConfigXML_InboundServiceMWLSCU m_ConfigXML_InboundServiceMWLSCU;

        #endregion

        /// <summary>
        /// When implemented in a derived class,
        /// executes when a Start command is sent to the service by the Service Control Manager (SCM)
        /// or when the operating system starts (for a service that starts automatically).
        /// Specifies actions to take when the service starts.
        /// </summary>
        /// <param name="args">Data passed by the start command.</param>
        protected override void OnStart(string[] args)
        {
            try
            {
                LogUtil.DebugLog("Enter InboundService.OnStart().");

                m_IsPaused = false;
                m_IsStopped = false;
                timerMainCallback.Enabled = true;
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("InboundService.OnStart() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Exit InboundService.OnStart().");
            }
        }

        /// <summary>
        /// When implemented in a derived class,
        /// executes when a Stop command is sent to the service by the Service Control Manager (SCM).
        /// Specifies actions to take when a service stops running.
        /// </summary>
        protected override void OnStop()
        {
            try
            {
                LogUtil.DebugLog("Enter InboundService.OnStop().");

                m_IsPaused = false;
                m_IsStopped = true;
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("InboundService.OnStop() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Exit InboundService.OnStop().");
            }
        }

        /// <summary>
        /// When implemented in a derived class,
        /// System.ServiceProcess.ServiceBase.OnContinue() runs when a Continue command is sent to the service by the Service Control Manager (SCM).
        /// Specifies actions to take when a service resumes normal functioning after being paused.
        /// </summary>
        protected override void OnContinue()
        {
            try
            {
                LogUtil.DebugLog("Enter InboundService.OnContinue().");

                m_IsPaused = false;
                m_IsStopped = false;
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("InboundService.OnContinue() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Exit InboundService.OnContinue().");
            }
        }

        /// <summary>
        /// When implemented in a derived class,
        /// executes when a Pause command is sent to the service by the Service Control Manager (SCM).
        /// Specifies actions to take when a service pauses.
        /// </summary>
        protected override void OnPause()
        {
            try
            {
                LogUtil.DebugLog("Enter InboundService.OnPause().");

                m_IsPaused = true;
                m_IsStopped = false;
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("InboundService.OnPause() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Exit InboundService.OnPause().");
            }
        }

        /// <summary>
        /// When implemented in a derived class,
        /// executes when the system is shutting down.
        /// Specifies what should happen immediately prior to the system shutting down.
        /// </summary>
        protected override void OnShutdown()
        {
            try
            {
                LogUtil.DebugLog("Enter InboundService.OnShutdown().");

                m_IsPaused = false;
                m_IsStopped = true;
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("InboundService.OnShutdown() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Exit InboundService.OnShutdown().");
            }
        }

        /// <summary>
        /// 设置工作内存占用
        /// </summary>
        /// <param name="iMaxWorkingSet"></param>
        public static void SetWorkingSet(int iMaxWorkingSet)
        {
            try
            {
                LogUtil.DebugLog("Enter InboundService.SetWorkingSet().");

                Process.GetCurrentProcess().MaxWorkingSet = (IntPtr)iMaxWorkingSet;
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("InboundService.SetWorkingSet() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("InboundService.Exit SetWorkingSet().");
            }
        }

        /// <summary>
        /// Creates a new instance of the HIMS2.InboundService.MWL.SCU class.
        /// </summary>
        public InboundService()
        {
            try
            {
                InitializeComponent();

                //Load config of the KIOSK.Integration.Config class.
                LoadConfigAndInitializLogUtil();

                // Timer init
                timerMainCallback = new Timer();
                timerMainCallback.Interval = m_Config_InboundServiceMWLSCU.M_ServiceWatchTime * 1000;
                timerMainCallback.Enabled = true;
                timerMainCallback.Elapsed += new ElapsedEventHandler(OnTimerMainCallback);
            }
            catch (Exception ex)
            {
                LogUtil.ErrorLog("InboundService.InboundService() Error Message = " + ex.ToString());
            }
            finally
            {
                LogUtil.DebugLog("Exit InboundService.InboundService().");
            }
        }

        /// <summary>
        /// Load config of the KIOSK.Integration.InboundService.MWL.SCU class.
        /// </summary>
        private void LoadConfigAndInitializLogUtil()
        {
            // Get filename of config.
            string strCurrentPath = AppDomain.CurrentDomain.BaseDirectory;
            string strCurrentPathParent = strCurrentPath.Substring(0, strCurrentPath.LastIndexOf("\\", strCurrentPath.Length - 2) + 1);
            string strConfigFileName = Path.Combine(strCurrentPath, KIOSKIntegrationConst.KIOSK_INTEGRATION_CONFIG_FILE);

            if (!File.Exists(strConfigFileName))
            {
                strConfigFileName = Path.Combine(strCurrentPathParent, KIOSKIntegrationConst.KIOSK_INTEGRATION_CONFIG_FILE);
            }

            if (!File.Exists(strConfigFileName))
            {
                strConfigFileName = Path.Combine(strCurrentPathParent, "KIOSK.Integration.Bin");
                strConfigFileName = Path.Combine(strConfigFileName, KIOSKIntegrationConst.KIOSK_INTEGRATION_CONFIG_FILE);
            }

            // Load config.
            m_Config_InboundServiceMWLSCU = new Config_InboundServiceMWLSCU();
            m_ConfigXML_InboundServiceMWLSCU = new ConfigXML_InboundServiceMWLSCU();
            m_ConfigXML_InboundServiceMWLSCU.M_ConfigFileName = strConfigFileName;
            m_ConfigXML_InboundServiceMWLSCU.M_Config = m_Config_InboundServiceMWLSCU;
            m_ConfigXML_InboundServiceMWLSCU.LoadConfig();

            // LogUtil init.
            string strLogFilePath = "";
            if (".." == m_Config_InboundServiceMWLSCU.M_LogFilePath.Trim().Substring(0, 2))
            {
                strLogFilePath = Path.Combine(strCurrentPathParent, m_Config_InboundServiceMWLSCU.M_LogFilePath.Trim().Substring(3, m_Config_InboundServiceMWLSCU.M_LogFilePath.Trim().Length - 3));
            }
            else
            {
                strLogFilePath = m_Config_InboundServiceMWLSCU.M_LogFilePath.Trim();
            }
            LogUtil.Initialize(strLogFilePath, m_Config_InboundServiceMWLSCU.M_LogLevel, m_Config_InboundServiceMWLSCU.M_LogFileKeepTime);

            LogUtil.DebugLog("----------KIOSK.Integration.InboundService.MWL.CSU init starting.---------------------------");
            LogUtil.DebugLog("Load config and LogUtil initialize success.");
            LogUtil.DebugLog("KIOSK.Integration.Config path:" + strConfigFileName);

            LogUtil.DebugLog("LogFilePath=" + m_Config_InboundServiceMWLSCU.M_LogFilePath);
            LogUtil.DebugLog("LogLevel=" + m_Config_InboundServiceMWLSCU.M_LogLevel);
            LogUtil.DebugLog("LogFileKeepTime=" + m_Config_InboundServiceMWLSCU.M_LogFileKeepTime.ToString());

            LogUtil.DebugLog("ServiceName=" + m_Config_InboundServiceMWLSCU.M_ServiceName);
            LogUtil.DebugLog("ServiceDescription=" + m_Config_InboundServiceMWLSCU.M_ServiceDescription);
            LogUtil.DebugLog("ServiceWatchTime=" + m_Config_InboundServiceMWLSCU.M_ServiceWatchTime.ToString());
            LogUtil.DebugLog("ServiceBeginTime=" + m_Config_InboundServiceMWLSCU.M_ServiceBeginTime);
            LogUtil.DebugLog("ServiceEndTime=" + m_Config_InboundServiceMWLSCU.M_ServiceEndTime);
            LogUtil.DebugLog("Modality=" + m_Config_InboundServiceMWLSCU.M_Modality);
            LogUtil.DebugLog("StudyTimeSpan=" + m_Config_InboundServiceMWLSCU.M_StudyTimeSpan);

            LogUtil.DebugLog("----------KIOSK.Integration.InboundService.MWL.SCU init finished.---------------------------");
        }

        /// <summary>
        /// Timer response function.
        /// </summary>
        /// <param name="sender">The sender object</param>
        /// <param name="e">Event arguments</param>
        private void OnTimerMainCallback(object sender, EventArgs e)
        {
            lock (timerMainCallbackLock)
            {
                LogUtil.DebugLog("Enter InboundService.OnTimerMainCallback().");

                if (m_IsPaused || m_IsStopped)
                {
                    return;
                }

                try
                {
                    timerMainCallback.Enabled = false;
                    SetWorkingSet(750000);
                    Deal();
                }
                catch (KIOSKIntegrationException ex)
                {
                    LogUtil.ErrorLog("InboundService.OnTimerMainCallback() Error Message = " + ex.ToString());
                }
                finally
                {
                    timerMainCallback.Enabled = true;

                    LogUtil.DebugLog("Exit InboundService.OnTimerMainCallback().");
                }
            }
        }

        private void Deal()
        {
            LogUtil.DebugLog("");
            LogUtil.DebugLog("Enter InboundService.Deal().");

            bool bWSReturn = false;
            KIOSKIntegrationWSProxy.WSProxySoapClient wsProxy = null;

            try
            {
                if (null == wsProxy)
                {
                    wsProxy = new KIOSKIntegrationWSProxy.WSProxySoapClient("WSProxySoap");
                }

                LogUtil.DebugLog("Call KIOSKIntegrationWSProxy.QueryMWL().");

                int iStudyTimeSpan = 2; //Hour
                DateTime dtNow = DateTime.Now;

                string strPatientID = "";
                string strPatientName = "";
                string strAccessionNumber = "";
                string strModality = m_Config_InboundServiceMWLSCU.M_Modality.Trim();
                string strStudyDate1 = DateTime.Now.ToString("yyyyMMdd");
                string strStudyDate2 = "";
                string strStudyTimeSpan1 = DateTime.Now.AddHours(-1 * iStudyTimeSpan).ToString("HH:mm:ss") + "-" + DateTime.Now.ToString("HH:mm:ss");
                string strStudyTimeSpan2 = "";
                string strStudyStatusID = "";

                try
                {
                    iStudyTimeSpan = Convert.ToInt32(m_Config_InboundServiceMWLSCU.M_StudyTimeSpan.Trim());
                }
                catch
                {
                    iStudyTimeSpan = 2;
                }
                finally
                {
                    if (0 > iStudyTimeSpan)
                    {
                        iStudyTimeSpan = 2;
                    }
                }

                if (iStudyTimeSpan >= dtNow.Hour)
                {
                    strStudyDate1 = dtNow.ToString("yyyyMMdd");
                    strStudyDate2 = dtNow.AddDays(-1).ToString("yyyyMMdd");

                    strStudyTimeSpan1 = "00:00:00-" + dtNow.ToString("HH:mm:ss");
                    strStudyTimeSpan2 = Convert.ToDateTime("23:59:59").AddHours(dtNow.Hour - iStudyTimeSpan).ToString("HH:mm:ss") + "-24:59:59";

                    bWSReturn = wsProxy.QueryMWL(strPatientID, strPatientName,
                        strAccessionNumber, strModality, strStudyDate2, strStudyTimeSpan2, strStudyStatusID);
                }

                bWSReturn = wsProxy.QueryMWL(strPatientID, strPatientName,
                    strAccessionNumber, strModality, strStudyDate1, strStudyTimeSpan1, strStudyStatusID);

                LogUtil.DebugLog("KIOSKIntegrationWSProxy.QueryMWL() Return = " + bWSReturn.ToString());
            }
            catch (KIOSKIntegrationException ex)
            {
                LogUtil.ErrorLog("InboundService.Deal() Error Message = " + ex.ToString());
            }
            finally
            {
                if (null != wsProxy)
                {
                    wsProxy = null;
                }

                LogUtil.DebugLog("Exit InboundService.Deal().");
            }
        }
    }
}