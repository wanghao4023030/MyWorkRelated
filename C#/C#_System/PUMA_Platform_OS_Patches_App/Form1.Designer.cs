namespace PUMA_Platform_OS_Patches_App
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btn_Service_GetInfo = new System.Windows.Forms.Button();
            this.tabMain = new System.Windows.Forms.TabControl();
            this.tabServicetool = new System.Windows.Forms.TabPage();
            this.btn_Service_Install = new System.Windows.Forms.Button();
            this.progressBar = new System.Windows.Forms.ProgressBar();
            this.label_Service_Patches_Installed = new System.Windows.Forms.Label();
            this.label_Service_Patches_Needed = new System.Windows.Forms.Label();
            this.RTB_Service_Patches_Needed = new System.Windows.Forms.RichTextBox();
            this.label_Service_OS_Info = new System.Windows.Forms.Label();
            this.lable_Service_Server_Info = new System.Windows.Forms.Label();
            this.RTB_Service_Patches_Successed = new System.Windows.Forms.RichTextBox();
            this.tabAdmintool = new System.Windows.Forms.TabPage();
            this.label1 = new System.Windows.Forms.Label();
            this.progressBar_Admin = new System.Windows.Forms.ProgressBar();
            this.btn_Admin_Save = new System.Windows.Forms.Button();
            this.label_Admin_OS_Info = new System.Windows.Forms.Label();
            this.label_Admin_Server_Info = new System.Windows.Forms.Label();
            this.RTB_Admin_Patches_Successed = new System.Windows.Forms.RichTextBox();
            this.btn_Admin_GetInfo = new System.Windows.Forms.Button();
            this.lable_Service_installPatches = new System.Windows.Forms.Label();
            this.tabMain.SuspendLayout();
            this.tabServicetool.SuspendLayout();
            this.tabAdmintool.SuspendLayout();
            this.SuspendLayout();
            // 
            // btn_Service_GetInfo
            // 
            this.btn_Service_GetInfo.Location = new System.Drawing.Point(621, 22);
            this.btn_Service_GetInfo.Name = "btn_Service_GetInfo";
            this.btn_Service_GetInfo.Size = new System.Drawing.Size(82, 28);
            this.btn_Service_GetInfo.TabIndex = 0;
            this.btn_Service_GetInfo.Text = "GetInfo";
            this.btn_Service_GetInfo.UseVisualStyleBackColor = true;
            this.btn_Service_GetInfo.Click += new System.EventHandler(this.btn_Service_GetInfo_Click);
            // 
            // tabMain
            // 
            this.tabMain.Controls.Add(this.tabServicetool);
            this.tabMain.Controls.Add(this.tabAdmintool);
            this.tabMain.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tabMain.Location = new System.Drawing.Point(13, 3);
            this.tabMain.Name = "tabMain";
            this.tabMain.SelectedIndex = 0;
            this.tabMain.Size = new System.Drawing.Size(1117, 803);
            this.tabMain.TabIndex = 1;
            // 
            // tabServicetool
            // 
            this.tabServicetool.Controls.Add(this.lable_Service_installPatches);
            this.tabServicetool.Controls.Add(this.btn_Service_Install);
            this.tabServicetool.Controls.Add(this.progressBar);
            this.tabServicetool.Controls.Add(this.label_Service_Patches_Installed);
            this.tabServicetool.Controls.Add(this.label_Service_Patches_Needed);
            this.tabServicetool.Controls.Add(this.RTB_Service_Patches_Needed);
            this.tabServicetool.Controls.Add(this.label_Service_OS_Info);
            this.tabServicetool.Controls.Add(this.lable_Service_Server_Info);
            this.tabServicetool.Controls.Add(this.RTB_Service_Patches_Successed);
            this.tabServicetool.Controls.Add(this.btn_Service_GetInfo);
            this.tabServicetool.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tabServicetool.Location = new System.Drawing.Point(4, 33);
            this.tabServicetool.Name = "tabServicetool";
            this.tabServicetool.Padding = new System.Windows.Forms.Padding(3);
            this.tabServicetool.Size = new System.Drawing.Size(1109, 766);
            this.tabServicetool.TabIndex = 0;
            this.tabServicetool.Text = "ServiceTool";
            this.tabServicetool.UseVisualStyleBackColor = true;
            // 
            // btn_Service_Install
            // 
            this.btn_Service_Install.Location = new System.Drawing.Point(621, 92);
            this.btn_Service_Install.Name = "btn_Service_Install";
            this.btn_Service_Install.Size = new System.Drawing.Size(82, 28);
            this.btn_Service_Install.TabIndex = 11;
            this.btn_Service_Install.Text = "Install";
            this.btn_Service_Install.UseVisualStyleBackColor = true;
            this.btn_Service_Install.Click += new System.EventHandler(this.btn_Service_Install_Click);
            // 
            // progressBar
            // 
            this.progressBar.BackColor = System.Drawing.SystemColors.Window;
            this.progressBar.Location = new System.Drawing.Point(29, 195);
            this.progressBar.Name = "progressBar";
            this.progressBar.Size = new System.Drawing.Size(674, 21);
            this.progressBar.Style = System.Windows.Forms.ProgressBarStyle.Continuous;
            this.progressBar.TabIndex = 10;
            // 
            // label_Service_Patches_Installed
            // 
            this.label_Service_Patches_Installed.AutoSize = true;
            this.label_Service_Patches_Installed.BackColor = System.Drawing.Color.Transparent;
            this.label_Service_Patches_Installed.Location = new System.Drawing.Point(26, 230);
            this.label_Service_Patches_Installed.Name = "label_Service_Patches_Installed";
            this.label_Service_Patches_Installed.Size = new System.Drawing.Size(115, 17);
            this.label_Service_Patches_Installed.TabIndex = 9;
            this.label_Service_Patches_Installed.Text = "Installed Patches";
            // 
            // label_Service_Patches_Needed
            // 
            this.label_Service_Patches_Needed.AutoSize = true;
            this.label_Service_Patches_Needed.BackColor = System.Drawing.Color.Transparent;
            this.label_Service_Patches_Needed.Location = new System.Drawing.Point(26, 372);
            this.label_Service_Patches_Needed.Name = "label_Service_Patches_Needed";
            this.label_Service_Patches_Needed.Size = new System.Drawing.Size(137, 17);
            this.label_Service_Patches_Needed.TabIndex = 8;
            this.label_Service_Patches_Needed.Text = "Need Install Patches";
            // 
            // RTB_Service_Patches_Needed
            // 
            this.RTB_Service_Patches_Needed.Location = new System.Drawing.Point(29, 404);
            this.RTB_Service_Patches_Needed.Name = "RTB_Service_Patches_Needed";
            this.RTB_Service_Patches_Needed.Size = new System.Drawing.Size(674, 127);
            this.RTB_Service_Patches_Needed.TabIndex = 7;
            this.RTB_Service_Patches_Needed.Text = "";
            // 
            // label_Service_OS_Info
            // 
            this.label_Service_OS_Info.AutoSize = true;
            this.label_Service_OS_Info.BackColor = System.Drawing.Color.Transparent;
            this.label_Service_OS_Info.Location = new System.Drawing.Point(26, 52);
            this.label_Service_OS_Info.Name = "label_Service_OS_Info";
            this.label_Service_OS_Info.Size = new System.Drawing.Size(102, 17);
            this.label_Service_OS_Info.TabIndex = 5;
            this.label_Service_OS_Info.Text = "OS Information";
            // 
            // lable_Service_Server_Info
            // 
            this.lable_Service_Server_Info.AutoSize = true;
            this.lable_Service_Server_Info.Location = new System.Drawing.Point(26, 28);
            this.lable_Service_Server_Info.Name = "lable_Service_Server_Info";
            this.lable_Service_Server_Info.Size = new System.Drawing.Size(124, 17);
            this.lable_Service_Server_Info.TabIndex = 4;
            this.lable_Service_Server_Info.Text = "Server Information";
            // 
            // RTB_Service_Patches_Successed
            // 
            this.RTB_Service_Patches_Successed.Location = new System.Drawing.Point(29, 271);
            this.RTB_Service_Patches_Successed.Name = "RTB_Service_Patches_Successed";
            this.RTB_Service_Patches_Successed.Size = new System.Drawing.Size(674, 92);
            this.RTB_Service_Patches_Successed.TabIndex = 3;
            this.RTB_Service_Patches_Successed.Text = "";
            // 
            // tabAdmintool
            // 
            this.tabAdmintool.Controls.Add(this.label1);
            this.tabAdmintool.Controls.Add(this.progressBar_Admin);
            this.tabAdmintool.Controls.Add(this.btn_Admin_Save);
            this.tabAdmintool.Controls.Add(this.label_Admin_OS_Info);
            this.tabAdmintool.Controls.Add(this.label_Admin_Server_Info);
            this.tabAdmintool.Controls.Add(this.RTB_Admin_Patches_Successed);
            this.tabAdmintool.Controls.Add(this.btn_Admin_GetInfo);
            this.tabAdmintool.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tabAdmintool.Location = new System.Drawing.Point(4, 33);
            this.tabAdmintool.Name = "tabAdmintool";
            this.tabAdmintool.Padding = new System.Windows.Forms.Padding(3);
            this.tabAdmintool.Size = new System.Drawing.Size(1109, 766);
            this.tabAdmintool.TabIndex = 1;
            this.tabAdmintool.Text = "AdminTool";
            this.tabAdmintool.UseVisualStyleBackColor = true;
            this.tabAdmintool.Enter += new System.EventHandler(this.tabAdmintool_Enter);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.Transparent;
            this.label1.Location = new System.Drawing.Point(31, 261);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(115, 17);
            this.label1.TabIndex = 12;
            this.label1.Text = "Installed Patches";
            // 
            // progressBar_Admin
            // 
            this.progressBar_Admin.BackColor = System.Drawing.SystemColors.Window;
            this.progressBar_Admin.Location = new System.Drawing.Point(34, 206);
            this.progressBar_Admin.Name = "progressBar_Admin";
            this.progressBar_Admin.Size = new System.Drawing.Size(684, 32);
            this.progressBar_Admin.Style = System.Windows.Forms.ProgressBarStyle.Continuous;
            this.progressBar_Admin.TabIndex = 11;
            // 
            // btn_Admin_Save
            // 
            this.btn_Admin_Save.Location = new System.Drawing.Point(633, 57);
            this.btn_Admin_Save.Name = "btn_Admin_Save";
            this.btn_Admin_Save.Size = new System.Drawing.Size(85, 26);
            this.btn_Admin_Save.TabIndex = 10;
            this.btn_Admin_Save.Text = "Save";
            this.btn_Admin_Save.UseVisualStyleBackColor = true;
            this.btn_Admin_Save.Click += new System.EventHandler(this.btn_Admin_Save_Click);
            // 
            // label_Admin_OS_Info
            // 
            this.label_Admin_OS_Info.AutoSize = true;
            this.label_Admin_OS_Info.BackColor = System.Drawing.Color.Transparent;
            this.label_Admin_OS_Info.Location = new System.Drawing.Point(31, 57);
            this.label_Admin_OS_Info.Name = "label_Admin_OS_Info";
            this.label_Admin_OS_Info.Size = new System.Drawing.Size(102, 17);
            this.label_Admin_OS_Info.TabIndex = 9;
            this.label_Admin_OS_Info.Text = "OS Information";
            // 
            // label_Admin_Server_Info
            // 
            this.label_Admin_Server_Info.AutoSize = true;
            this.label_Admin_Server_Info.Location = new System.Drawing.Point(31, 33);
            this.label_Admin_Server_Info.Name = "label_Admin_Server_Info";
            this.label_Admin_Server_Info.Size = new System.Drawing.Size(124, 17);
            this.label_Admin_Server_Info.TabIndex = 8;
            this.label_Admin_Server_Info.Text = "Server Information";
            // 
            // RTB_Admin_Patches_Successed
            // 
            this.RTB_Admin_Patches_Successed.Location = new System.Drawing.Point(34, 293);
            this.RTB_Admin_Patches_Successed.Name = "RTB_Admin_Patches_Successed";
            this.RTB_Admin_Patches_Successed.Size = new System.Drawing.Size(684, 220);
            this.RTB_Admin_Patches_Successed.TabIndex = 7;
            this.RTB_Admin_Patches_Successed.Text = "";
            this.RTB_Admin_Patches_Successed.TextChanged += new System.EventHandler(this.RTB_Admin_Patches_Successed_TextChanged);
            // 
            // btn_Admin_GetInfo
            // 
            this.btn_Admin_GetInfo.Location = new System.Drawing.Point(633, 21);
            this.btn_Admin_GetInfo.Name = "btn_Admin_GetInfo";
            this.btn_Admin_GetInfo.Size = new System.Drawing.Size(85, 29);
            this.btn_Admin_GetInfo.TabIndex = 6;
            this.btn_Admin_GetInfo.Text = "GetInfo";
            this.btn_Admin_GetInfo.UseVisualStyleBackColor = true;
            this.btn_Admin_GetInfo.Click += new System.EventHandler(this.btn_Admin_GetInfo_Click);
            // 
            // lable_Service_installPatches
            // 
            this.lable_Service_installPatches.AutoSize = true;
            this.lable_Service_installPatches.Location = new System.Drawing.Point(26, 175);
            this.lable_Service_installPatches.Name = "lable_Service_installPatches";
            this.lable_Service_installPatches.Size = new System.Drawing.Size(119, 17);
            this.lable_Service_installPatches.TabIndex = 12;
            this.lable_Service_installPatches.Text = "Install Patches.....";
            // 
            // Form1
            // 
            this.AllowDrop = true;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(770, 604);
            this.Controls.Add(this.tabMain);
            this.Name = "Form1";
            this.Text = "PUMA_Server_OS_Patches_Check";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.tabMain.ResumeLayout(false);
            this.tabServicetool.ResumeLayout(false);
            this.tabServicetool.PerformLayout();
            this.tabAdmintool.ResumeLayout(false);
            this.tabAdmintool.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btn_Service_GetInfo;
        private System.Windows.Forms.TabControl tabMain;
        private System.Windows.Forms.TabPage tabServicetool;
        private System.Windows.Forms.TabPage tabAdmintool;
        private System.Windows.Forms.RichTextBox RTB_Service_Patches_Successed;
        private System.Windows.Forms.Label lable_Service_Server_Info;
        private System.Windows.Forms.Label label_Service_OS_Info;
        private System.Windows.Forms.Label label_Admin_OS_Info;
        private System.Windows.Forms.Label label_Admin_Server_Info;
        private System.Windows.Forms.RichTextBox RTB_Admin_Patches_Successed;
        private System.Windows.Forms.Button btn_Admin_GetInfo;
        private System.Windows.Forms.Button btn_Admin_Save;
        private System.Windows.Forms.RichTextBox RTB_Service_Patches_Needed;
        private System.Windows.Forms.Label label_Service_Patches_Needed;
        private System.Windows.Forms.Label label_Service_Patches_Installed;
        private System.Windows.Forms.ProgressBar progressBar;
        private System.Windows.Forms.ProgressBar progressBar_Admin;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btn_Service_Install;
        private System.Windows.Forms.Label lable_Service_installPatches;
    }
}

