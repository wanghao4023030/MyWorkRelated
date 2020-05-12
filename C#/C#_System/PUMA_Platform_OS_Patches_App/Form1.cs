using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using log4net;
using System.Threading.Tasks;
using System.Threading;
using System.Timers;

namespace PUMA_Platform_OS_Patches_App
{
    
    public partial class Form1 : Form
    {
        log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        System.Timers.Timer timer = new System.Timers.Timer(360 * 1000);   //实例化Timer类，设置间隔时间为10000毫秒； 
        Thread t = null;
        int Timercount = 0;
        int allNeedInstakkPatchesCount;

        public Form1()
        {

            InitializeComponent();
            this.FormClosing += Form1_FormClosing;
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (t == null)
            {
                //e.Cancel = true;
                //System.Windows.Forms.Application.Exit();
                System.Environment.Exit(0);
            }
            else
            {
                if (t.IsAlive)
                {
                    DialogResult = MessageBox.Show(this, "安装程序正在后台运行，强行关闭可能会造成补丁安装错误，带来不可预知的错误!\n" +
                        "我们强烈建议你等待程序运行结束后退出程序!\n" +
                        "您是否仍要退出?", "Do you still want exit... ?", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                    if (this.DialogResult == DialogResult.Yes)
                    {
                        t.Abort();
                        //System.Windows.Forms.Application.Exit();
                        System.Environment.Exit(0);
                    }
                    else
                    {
                        e.Cancel = true;
                    }
                }
            }
            
        }


        private void Form1_Load(object sender, EventArgs e)
        {

            btn_Service_Install.Enabled = false;
            lable_Service_installPatches.Text = "";

        }

        private void btn_Service_GetInfo_Click(object sender, EventArgs e)
        {
            ServiceTool ST = new ServiceTool();
            btn_Service_Install.Enabled = false;
            progressBar.Style = ProgressBarStyle.Continuous;
            progressBar.Minimum = 30;
            progressBar.Maximum = 100;


            //ServiceTool ST = new ServiceTool();
            progressBar.Value = 40;
            label_Service_OS_Info.Text = ST.getCurrentOSinfo();
            log.Info("Service:Get the current info");

            progressBar.Value = 50;
            RTB_Service_Patches_Successed.Text = ST.getSuccessedPatches();

            progressBar.Value = 60;
            string CurrentPatchesContent = RTB_Service_Patches_Successed.Text.ToLower();
            log.Info("Service:Get the installed patches list");

            progressBar.Value = 70;
            string PatchesNeedInstallString = ST.compareNeedInstallPatches(CurrentPatchesContent);

            progressBar.Value = 80;
            RTB_Service_Patches_Needed.Text = PatchesNeedInstallString.ToLower();
            progressBar.Value = 100;
            log.Info("Service:Get the needed installed patches list");

            if (RTB_Service_Patches_Needed.Text.Contains("kb"))
            {
                btn_Service_Install.Enabled = true;
            }
        }


        //private void btn_ServiceCompare_Click(object sender, EventArgs e)
        //{
        //    ServiceTool ST = new ServiceTool();
        //    string CurrentPatchesContent = RTB_Service_Patches_Successed.Text;
        //    string[] NeedInstallPatches = ST.compareNeedInstallPatches(CurrentPatchesContent);
        //    RTB_Service_Patches_Needed.Text = NeedInstallPatches.ToString();

        //}

        private void btn_Admin_GetInfo_Click(object sender, EventArgs e)
        {
            progressBar.Style = ProgressBarStyle.Continuous;
            progressBar.Minimum = 30;
            progressBar.Maximum = 100;

            progressBar.Value = 40;
            ServiceTool ST = new ServiceTool();
            progressBar.Value = 60;
            label_Admin_OS_Info.Text = ST.getCurrentOSinfo();
            progressBar.Value = 90;
            RTB_Admin_Patches_Successed.Text = ST.getSuccessedPatches();
            progressBar.Value = 100;
            log.Info("Admin: Get the installed patches list in current server.");
        }


        private void btn_Admin_Save_Click(object sender, EventArgs e)
        {
            try
            {

                string rtn = Interaction.InputBox("If you try to save the content, you will change the standard OS pathces install list. \r\n " +
                    " We suggest you do not do this operation. \r\n" +
                    "The function is design for the system and server administrator. \r\n" +
                    "Thanks", "Warning", "");
                if (rtn != "")
                {
                    if (rtn.ToLower().Equals("kiosk"))
                    {
                        AdminTool AT = new AdminTool();
                        string content = RTB_Admin_Patches_Successed.Text;
                        string filePath = AT.saveCurrentPatchesList(content);
                        MessageBox.Show("Update the information successfully!\r\n" +
                            "The file is saved to: " + filePath + "\r\n" +
                            "");
                        log.Info("Admin: Save the result to local disk: " + filePath + ".");
                    }
                    else
                    {
                        MessageBox.Show("You have no right to do that!");
                    }
                }


            }
            catch (Exception Ex)
            {
                MessageBox.Show(Ex.ToString());
                log.Info("Admin: error on save the result");
                log.Info(Ex.ToString());
            }

        }

        private void tabAdmintool_Enter(object sender, EventArgs e)
        {
            btn_Admin_Save.Visible = false;
        }

        private void RTB_Admin_Patches_Successed_TextChanged(object sender, EventArgs e)
        {
            btn_Admin_Save.Visible = true;
        }

        private void btn_Service_Install_Click(object sender, EventArgs e)
        {
            ServiceTool ST = new ServiceTool();
            btn_Service_Install.Enabled = false;
            btn_Service_GetInfo.Enabled = false;

            progressBar.Style = ProgressBarStyle.Continuous;
            progressBar.Minimum = 0;
            progressBar.Maximum = 100;
            progressBar.Value = 0;


            label_Service_OS_Info.Text = ST.getCurrentOSinfo();

            RTB_Service_Patches_Successed.Text = ST.getSuccessedPatches().ToLower();
            string CurrentPatchesContent = RTB_Service_Patches_Successed.Text.ToLower();
            string PtachesNeedInstallString = ST.compareNeedInstallPatches(CurrentPatchesContent);
            allNeedInstakkPatchesCount = ST.NeedInstallPatches.Count();

            RTB_Service_Patches_Needed.Text = PtachesNeedInstallString.ToLower();
            progressBar.Value = 10;

            log.Info("Service: Prepare to install patches.");


            //CancellationTokenSource cts = new CancellationTokenSource();
            //cts = new CancellationTokenSource();
            //TaskFactory taskFactory = new TaskFactory();
            //Task[] mytasks = new Task[1];
            //mytasks[0] = Task.Factory.StartNew(() => ST.InstallPatchesWithThread(cts.Token));

            t = new Thread(new ThreadStart(ST.InstallPatchesWithThread));
            t.Start();
            

  
            timer.Elapsed += new System.Timers.ElapsedEventHandler(GetStatus); //到达时间的时候执行事件；   
            timer.AutoReset = true;   //设置是执行一次（false）还是一直执行(true)；  
            timer.Enabled = true;     //是否执行System.Timers.Timer.Elapsed事件；   
             


            //while (ST.hasinstalledCount <= int_allpatches)
            //{

            //    lable_Service_installPatches.Text = "(" + int_allpatches + "/" + ST.hasinstalledCount + ")" +
            //    "install patches: " + ST.current_installPatchName;
            //    Thread.Sleep(5000);
            //}

            


        }

        public void GetStatus(object source, System.Timers.ElapsedEventArgs e)
        {
            ServiceTool ST = new ServiceTool();
            RTB_Service_Patches_Successed.Text = ST.getSuccessedPatches().ToLower();
            string CurrentPatchesContent = RTB_Service_Patches_Successed.Text.ToLower();
            string PtachesNeedInstallString = ST.compareNeedInstallPatches(CurrentPatchesContent);
            int surplusPatchesCount = ST.NeedInstallPatches.Count();
            lable_Service_installPatches.Text = "(" + allNeedInstakkPatchesCount.ToString() + "/" + (allNeedInstakkPatchesCount - surplusPatchesCount).ToString() + "): installing patch: "
                + ST.NeedInstallPatches[0].ToString();
            progressBar.Value = (int)((allNeedInstakkPatchesCount - surplusPatchesCount + 1) *100 / allNeedInstakkPatchesCount);
            RTB_Service_Patches_Needed.Text = PtachesNeedInstallString.ToLower();
            

            if (t.ThreadState.ToString().Equals("Stopped"))
            {
                //lable_Service_installPatches.Text = "";
                progressBar.Value = 100;
                btn_Service_Install.Enabled = true;
                timer.Stop();
                log.Info("Service: Finish to install patches");
                MessageBox.Show("已尝试尝试安装所有程序.\n" +
                    "部分补丁会因为依赖关系，未能成功安装\n" +
                    "请重启计算机，并再次运行工具进行验证\n" +
                    "如果仍有补丁没有安装成功，请重新运行此工具或手工安装。");
                
                btn_Service_GetInfo.Enabled = true;
                btn_Service_Install.Enabled = true;
            }
            else
            {
                //MessageBox.Show(t.ThreadState.ToString());
                
            }

            GC.Collect();
        }

        //private void btn_Service_Install_Click(object sender, EventArgs e)
        //{
        //    btn_Service_Install.Enabled = false;
        //    btn_Service_GetInfo.Enabled = false;

        //    progressBar.Style = ProgressBarStyle.Continuous;
        //    progressBar.Minimum = 0;
        //    progressBar.Maximum = 100;
        //    progressBar.Value = 0;
        //    ServiceTool ST = new ServiceTool();

        //    label_Service_OS_Info.Text = ST.getCurrentOSinfo();

        //    RTB_Service_Patches_Successed.Text = ST.getSuccessedPatches().ToLower();
        //    string CurrentPatchesContent = RTB_Service_Patches_Successed.Text.ToLower();
        //    string PtachesNeedInstallString = ST.compareNeedInstallPatches(CurrentPatchesContent);
        //    RTB_Service_Patches_Needed.Text = PtachesNeedInstallString.ToLower();
        //    log.Info("Service: Prepare to install patches.");

        //    progressBar.Value = 10;
        //    int int_allpatches = ST.NeedInstallPatches.Count();

        //    int count = 1;
        //    if (ST.NeedInstallPatches.Count() >= 1)
        //    {
        //        foreach (string KB_Value in ST.NeedInstallPatches)
        //        {
        //            string patch_file_name = ST.findNeedInstallPatches(KB_Value);
        //            lable_Service_installPatches.Text = "(" + int_allpatches + "/" + count + ")" +
        //                "install patches: " + KB_Value;

        //            if (patch_file_name != null)
        //            {
        //                log.Info("Service: Try to install the patch : " + KB_Value);
        //                if (ST.InstallPatchesByFileName(patch_file_name))
        //                {
        //                    string success_patches = ST.getSuccessedPatches().ToLower();
        //                    if (success_patches.Trim().ToLower().Contains(KB_Value.Trim()))
        //                    {
        //                        log.Info("Service: Install the patch : " + KB_Value + " successfully.");
        //                    }
        //                    else
        //                    {

        //                        log.Info("Service: Install the patch : " + KB_Value + " Failed.");
        //                    }

        //                    Application.DoEvents();
        //                }
        //                progressBar.Value = (90 / int_allpatches) * count;
        //                count = count + 1;
        //            }
        //            else
        //            {
        //                log.Info("Service: Patch cannot find in the folder path 'Patches' of : " + KB_Value + "");
        //            }
        //        }
        //    }
        //    else
        //    {
        //        MessageBox.Show("No patches need to install");
        //    }

        //    progressBar.Value = 100;
        //    btn_Service_Install.Enabled = true;
        //    log.Info("Service: Finish to install patches");
        //    MessageBox.Show("Try to install the patches finished.\n" +
        //        "Restart the server and start the application tool again.\n" +
        //        "Check the result and execute the operation again if need.\n");
        //    lable_Service_installPatches.Text = "";
        //    btn_Service_GetInfo.Enabled = true;
        //    btn_Service_Install.Enabled = false;
        //}
    }

    }

