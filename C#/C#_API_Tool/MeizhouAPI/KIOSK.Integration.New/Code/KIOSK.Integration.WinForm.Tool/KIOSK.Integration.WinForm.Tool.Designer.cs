namespace KIOSK.Integration.WinForm.Tool
{
    partial class frmToolMain
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
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.tbPassword = new System.Windows.Forms.TextBox();
            this.tbUserName = new System.Windows.Forms.TextBox();
            this.tbDBName = new System.Windows.Forms.TextBox();
            this.tbDBServer = new System.Windows.Forms.TextBox();
            this.cbDBType = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.btnQueryDB = new System.Windows.Forms.Button();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.lvDBExamInfo = new System.Windows.Forms.ListView();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.rtbSQL = new System.Windows.Forms.RichTextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.groupBox8 = new System.Windows.Forms.GroupBox();
            this.btnQueryMWL = new System.Windows.Forms.Button();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.label10 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.tbPort = new System.Windows.Forms.TextBox();
            this.tbNode = new System.Windows.Forms.TextBox();
            this.tbCalledAE = new System.Windows.Forms.TextBox();
            this.tbCallingAE = new System.Windows.Forms.TextBox();
            this.groupBox6 = new System.Windows.Forms.GroupBox();
            this.tbEndTime = new System.Windows.Forms.TextBox();
            this.tbBeginTime = new System.Windows.Forms.TextBox();
            this.label15 = new System.Windows.Forms.Label();
            this.label19 = new System.Windows.Forms.Label();
            this.label12 = new System.Windows.Forms.Label();
            this.tbAccessionNumber = new System.Windows.Forms.TextBox();
            this.label18 = new System.Windows.Forms.Label();
            this.tbModality = new System.Windows.Forms.TextBox();
            this.label11 = new System.Windows.Forms.Label();
            this.label16 = new System.Windows.Forms.Label();
            this.label14 = new System.Windows.Forms.Label();
            this.tbBeginDate = new System.Windows.Forms.TextBox();
            this.cbStudyStatusID = new System.Windows.Forms.ComboBox();
            this.tbPatientID = new System.Windows.Forms.TextBox();
            this.label13 = new System.Windows.Forms.Label();
            this.label17 = new System.Windows.Forms.Label();
            this.tbEndDate = new System.Windows.Forms.TextBox();
            this.tbPatientName = new System.Windows.Forms.TextBox();
            this.groupBox7 = new System.Windows.Forms.GroupBox();
            this.lvWorkList = new System.Windows.Forms.ListView();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.groupBox9 = new System.Windows.Forms.GroupBox();
            this.label20 = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.groupBox8.SuspendLayout();
            this.groupBox5.SuspendLayout();
            this.groupBox6.SuspendLayout();
            this.groupBox7.SuspendLayout();
            this.tabPage3.SuspendLayout();
            this.groupBox9.SuspendLayout();
            this.SuspendLayout();
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Controls.Add(this.tabPage3);
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(886, 482);
            this.tabControl1.TabIndex = 0;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.groupBox1);
            this.tabPage1.Controls.Add(this.groupBox4);
            this.tabPage1.Controls.Add(this.groupBox3);
            this.tabPage1.Controls.Add(this.groupBox2);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Size = new System.Drawing.Size(878, 456);
            this.tabPage1.TabIndex = 3;
            this.tabPage1.Text = "DB";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.tbPassword);
            this.groupBox1.Controls.Add(this.tbUserName);
            this.groupBox1.Controls.Add(this.tbDBName);
            this.groupBox1.Controls.Add(this.tbDBServer);
            this.groupBox1.Controls.Add(this.cbDBType);
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(8, 3);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(202, 156);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            // 
            // tbPassword
            // 
            this.tbPassword.Location = new System.Drawing.Point(69, 124);
            this.tbPassword.Name = "tbPassword";
            this.tbPassword.Size = new System.Drawing.Size(121, 20);
            this.tbPassword.TabIndex = 9;
            // 
            // tbUserName
            // 
            this.tbUserName.Location = new System.Drawing.Point(69, 98);
            this.tbUserName.Name = "tbUserName";
            this.tbUserName.Size = new System.Drawing.Size(121, 20);
            this.tbUserName.TabIndex = 8;
            // 
            // tbDBName
            // 
            this.tbDBName.Location = new System.Drawing.Point(69, 72);
            this.tbDBName.Name = "tbDBName";
            this.tbDBName.Size = new System.Drawing.Size(121, 20);
            this.tbDBName.TabIndex = 7;
            // 
            // tbDBServer
            // 
            this.tbDBServer.Location = new System.Drawing.Point(69, 46);
            this.tbDBServer.Name = "tbDBServer";
            this.tbDBServer.Size = new System.Drawing.Size(121, 20);
            this.tbDBServer.TabIndex = 6;
            // 
            // cbDBType
            // 
            this.cbDBType.FormattingEnabled = true;
            this.cbDBType.Items.AddRange(new object[] {
            "MSSQL",
            "ORACLE",
            "MYSQL"});
            this.cbDBType.Location = new System.Drawing.Point(69, 19);
            this.cbDBType.Name = "cbDBType";
            this.cbDBType.Size = new System.Drawing.Size(121, 21);
            this.cbDBType.TabIndex = 5;
            this.cbDBType.TextChanged += new System.EventHandler(this.cbDBType_TextChanged);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(10, 128);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(53, 13);
            this.label5.TabIndex = 4;
            this.label5.Text = "Password";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(6, 101);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(57, 13);
            this.label4.TabIndex = 3;
            this.label4.Text = "UserName";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(13, 76);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(50, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "DBName";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(10, 50);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(53, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "DBServer";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(17, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(46, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "DBType";
            // 
            // groupBox4
            // 
            this.groupBox4.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox4.Controls.Add(this.btnQueryDB);
            this.groupBox4.Location = new System.Drawing.Point(8, 398);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(862, 50);
            this.groupBox4.TabIndex = 3;
            this.groupBox4.TabStop = false;
            // 
            // btnQueryDB
            // 
            this.btnQueryDB.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.btnQueryDB.Location = new System.Drawing.Point(781, 19);
            this.btnQueryDB.Name = "btnQueryDB";
            this.btnQueryDB.Size = new System.Drawing.Size(75, 23);
            this.btnQueryDB.TabIndex = 0;
            this.btnQueryDB.Text = "QueryDB";
            this.btnQueryDB.UseVisualStyleBackColor = true;
            this.btnQueryDB.Click += new System.EventHandler(this.btnQueryDB_Click);
            // 
            // groupBox3
            // 
            this.groupBox3.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox3.Controls.Add(this.lvDBExamInfo);
            this.groupBox3.Location = new System.Drawing.Point(8, 161);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(862, 231);
            this.groupBox3.TabIndex = 2;
            this.groupBox3.TabStop = false;
            // 
            // lvDBExamInfo
            // 
            this.lvDBExamInfo.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lvDBExamInfo.GridLines = true;
            this.lvDBExamInfo.Location = new System.Drawing.Point(3, 16);
            this.lvDBExamInfo.Name = "lvDBExamInfo";
            this.lvDBExamInfo.Size = new System.Drawing.Size(856, 212);
            this.lvDBExamInfo.TabIndex = 0;
            this.lvDBExamInfo.UseCompatibleStateImageBehavior = false;
            this.lvDBExamInfo.View = System.Windows.Forms.View.Details;
            // 
            // groupBox2
            // 
            this.groupBox2.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox2.Controls.Add(this.rtbSQL);
            this.groupBox2.Controls.Add(this.label6);
            this.groupBox2.Location = new System.Drawing.Point(216, 3);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(654, 156);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            // 
            // rtbSQL
            // 
            this.rtbSQL.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.rtbSQL.Location = new System.Drawing.Point(40, 19);
            this.rtbSQL.Name = "rtbSQL";
            this.rtbSQL.Size = new System.Drawing.Size(608, 125);
            this.rtbSQL.TabIndex = 1;
            this.rtbSQL.Text = "SELECT TOP 10 * FROM vi_CSH_KIOSK_ExamInfo";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(6, 22);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(28, 13);
            this.label6.TabIndex = 0;
            this.label6.Text = "SQL";
            // 
            // tabPage2
            // 
            this.tabPage2.Controls.Add(this.groupBox8);
            this.tabPage2.Controls.Add(this.groupBox5);
            this.tabPage2.Controls.Add(this.groupBox6);
            this.tabPage2.Controls.Add(this.groupBox7);
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(878, 456);
            this.tabPage2.TabIndex = 0;
            this.tabPage2.Text = "MWL";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // groupBox8
            // 
            this.groupBox8.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox8.Controls.Add(this.btnQueryMWL);
            this.groupBox8.Location = new System.Drawing.Point(8, 398);
            this.groupBox8.Name = "groupBox8";
            this.groupBox8.Size = new System.Drawing.Size(862, 50);
            this.groupBox8.TabIndex = 3;
            this.groupBox8.TabStop = false;
            // 
            // btnQueryMWL
            // 
            this.btnQueryMWL.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnQueryMWL.Location = new System.Drawing.Point(781, 19);
            this.btnQueryMWL.Name = "btnQueryMWL";
            this.btnQueryMWL.Size = new System.Drawing.Size(75, 23);
            this.btnQueryMWL.TabIndex = 0;
            this.btnQueryMWL.Text = "QueryMWL";
            this.btnQueryMWL.UseVisualStyleBackColor = true;
            this.btnQueryMWL.Click += new System.EventHandler(this.btnQueryMWL_Click);
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.label10);
            this.groupBox5.Controls.Add(this.label9);
            this.groupBox5.Controls.Add(this.label8);
            this.groupBox5.Controls.Add(this.label7);
            this.groupBox5.Controls.Add(this.tbPort);
            this.groupBox5.Controls.Add(this.tbNode);
            this.groupBox5.Controls.Add(this.tbCalledAE);
            this.groupBox5.Controls.Add(this.tbCallingAE);
            this.groupBox5.Location = new System.Drawing.Point(8, 3);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(202, 129);
            this.groupBox5.TabIndex = 0;
            this.groupBox5.TabStop = false;
            // 
            // label10
            // 
            this.label10.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(37, 101);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(26, 13);
            this.label10.TabIndex = 3;
            this.label10.Text = "Port";
            // 
            // label9
            // 
            this.label9.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(30, 75);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(33, 13);
            this.label9.TabIndex = 2;
            this.label9.Text = "Node";
            // 
            // label8
            // 
            this.label8.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(13, 49);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(50, 13);
            this.label8.TabIndex = 1;
            this.label8.Text = "CalledAE";
            // 
            // label7
            // 
            this.label7.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(11, 23);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(52, 13);
            this.label7.TabIndex = 0;
            this.label7.Text = "CallingAE";
            // 
            // tbPort
            // 
            this.tbPort.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.tbPort.Location = new System.Drawing.Point(69, 97);
            this.tbPort.Name = "tbPort";
            this.tbPort.Size = new System.Drawing.Size(121, 20);
            this.tbPort.TabIndex = 7;
            // 
            // tbNode
            // 
            this.tbNode.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.tbNode.Location = new System.Drawing.Point(69, 71);
            this.tbNode.Name = "tbNode";
            this.tbNode.Size = new System.Drawing.Size(121, 20);
            this.tbNode.TabIndex = 6;
            // 
            // tbCalledAE
            // 
            this.tbCalledAE.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.tbCalledAE.Location = new System.Drawing.Point(69, 45);
            this.tbCalledAE.Name = "tbCalledAE";
            this.tbCalledAE.Size = new System.Drawing.Size(121, 20);
            this.tbCalledAE.TabIndex = 5;
            // 
            // tbCallingAE
            // 
            this.tbCallingAE.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.tbCallingAE.Location = new System.Drawing.Point(69, 19);
            this.tbCallingAE.Name = "tbCallingAE";
            this.tbCallingAE.Size = new System.Drawing.Size(121, 20);
            this.tbCallingAE.TabIndex = 4;
            // 
            // groupBox6
            // 
            this.groupBox6.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox6.Controls.Add(this.tbEndTime);
            this.groupBox6.Controls.Add(this.tbBeginTime);
            this.groupBox6.Controls.Add(this.label15);
            this.groupBox6.Controls.Add(this.label19);
            this.groupBox6.Controls.Add(this.label12);
            this.groupBox6.Controls.Add(this.tbAccessionNumber);
            this.groupBox6.Controls.Add(this.label18);
            this.groupBox6.Controls.Add(this.tbModality);
            this.groupBox6.Controls.Add(this.label11);
            this.groupBox6.Controls.Add(this.label16);
            this.groupBox6.Controls.Add(this.label14);
            this.groupBox6.Controls.Add(this.tbBeginDate);
            this.groupBox6.Controls.Add(this.cbStudyStatusID);
            this.groupBox6.Controls.Add(this.tbPatientID);
            this.groupBox6.Controls.Add(this.label13);
            this.groupBox6.Controls.Add(this.label17);
            this.groupBox6.Controls.Add(this.tbEndDate);
            this.groupBox6.Controls.Add(this.tbPatientName);
            this.groupBox6.Location = new System.Drawing.Point(216, 3);
            this.groupBox6.Name = "groupBox6";
            this.groupBox6.Size = new System.Drawing.Size(654, 129);
            this.groupBox6.TabIndex = 1;
            this.groupBox6.TabStop = false;
            // 
            // tbEndTime
            // 
            this.tbEndTime.Location = new System.Drawing.Point(313, 97);
            this.tbEndTime.Name = "tbEndTime";
            this.tbEndTime.Size = new System.Drawing.Size(121, 20);
            this.tbEndTime.TabIndex = 17;
            // 
            // tbBeginTime
            // 
            this.tbBeginTime.Location = new System.Drawing.Point(106, 97);
            this.tbBeginTime.Name = "tbBeginTime";
            this.tbBeginTime.Size = new System.Drawing.Size(121, 20);
            this.tbBeginTime.TabIndex = 16;
            // 
            // label15
            // 
            this.label15.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label15.AutoSize = true;
            this.label15.Location = new System.Drawing.Point(445, 23);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(75, 13);
            this.label15.TabIndex = 4;
            this.label15.Text = "StudyStatusID";
            // 
            // label19
            // 
            this.label19.AutoSize = true;
            this.label19.Location = new System.Drawing.Point(286, 101);
            this.label19.Name = "label19";
            this.label19.Size = new System.Drawing.Size(20, 13);
            this.label19.TabIndex = 8;
            this.label19.Text = "To";
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(238, 23);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(68, 13);
            this.label12.TabIndex = 1;
            this.label12.Text = "PatientName";
            // 
            // tbAccessionNumber
            // 
            this.tbAccessionNumber.Location = new System.Drawing.Point(106, 45);
            this.tbAccessionNumber.Name = "tbAccessionNumber";
            this.tbAccessionNumber.Size = new System.Drawing.Size(121, 20);
            this.tbAccessionNumber.TabIndex = 11;
            // 
            // label18
            // 
            this.label18.AutoSize = true;
            this.label18.Location = new System.Drawing.Point(43, 101);
            this.label18.Name = "label18";
            this.label18.Size = new System.Drawing.Size(57, 13);
            this.label18.TabIndex = 7;
            this.label18.Text = "StudyTime";
            // 
            // tbModality
            // 
            this.tbModality.Location = new System.Drawing.Point(313, 45);
            this.tbModality.Name = "tbModality";
            this.tbModality.Size = new System.Drawing.Size(121, 20);
            this.tbModality.TabIndex = 12;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(49, 23);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(51, 13);
            this.label11.TabIndex = 0;
            this.label11.Text = "PatientID";
            // 
            // label16
            // 
            this.label16.AutoSize = true;
            this.label16.Location = new System.Drawing.Point(43, 75);
            this.label16.Name = "label16";
            this.label16.Size = new System.Drawing.Size(57, 13);
            this.label16.TabIndex = 5;
            this.label16.Text = "StudyDate";
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Location = new System.Drawing.Point(260, 49);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(46, 13);
            this.label14.TabIndex = 3;
            this.label14.Text = "Modality";
            // 
            // tbBeginDate
            // 
            this.tbBeginDate.Location = new System.Drawing.Point(106, 71);
            this.tbBeginDate.Name = "tbBeginDate";
            this.tbBeginDate.Size = new System.Drawing.Size(121, 20);
            this.tbBeginDate.TabIndex = 14;
            // 
            // cbStudyStatusID
            // 
            this.cbStudyStatusID.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.cbStudyStatusID.FormattingEnabled = true;
            this.cbStudyStatusID.Items.AddRange(new object[] {
            "ARRIVED",
            "COMPLETED",
            "SCHEDULED",
            "STARTED"});
            this.cbStudyStatusID.Location = new System.Drawing.Point(525, 19);
            this.cbStudyStatusID.Name = "cbStudyStatusID";
            this.cbStudyStatusID.Size = new System.Drawing.Size(121, 21);
            this.cbStudyStatusID.TabIndex = 13;
            // 
            // tbPatientID
            // 
            this.tbPatientID.Location = new System.Drawing.Point(106, 19);
            this.tbPatientID.Name = "tbPatientID";
            this.tbPatientID.Size = new System.Drawing.Size(121, 20);
            this.tbPatientID.TabIndex = 9;
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(7, 49);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(93, 13);
            this.label13.TabIndex = 2;
            this.label13.Text = "AccessionNumber";
            // 
            // label17
            // 
            this.label17.AutoSize = true;
            this.label17.Location = new System.Drawing.Point(286, 75);
            this.label17.Name = "label17";
            this.label17.Size = new System.Drawing.Size(20, 13);
            this.label17.TabIndex = 6;
            this.label17.Text = "To";
            // 
            // tbEndDate
            // 
            this.tbEndDate.Location = new System.Drawing.Point(313, 71);
            this.tbEndDate.Name = "tbEndDate";
            this.tbEndDate.Size = new System.Drawing.Size(121, 20);
            this.tbEndDate.TabIndex = 15;
            // 
            // tbPatientName
            // 
            this.tbPatientName.Location = new System.Drawing.Point(313, 19);
            this.tbPatientName.Name = "tbPatientName";
            this.tbPatientName.Size = new System.Drawing.Size(121, 20);
            this.tbPatientName.TabIndex = 10;
            // 
            // groupBox7
            // 
            this.groupBox7.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox7.Controls.Add(this.lvWorkList);
            this.groupBox7.Location = new System.Drawing.Point(8, 138);
            this.groupBox7.Name = "groupBox7";
            this.groupBox7.Size = new System.Drawing.Size(862, 254);
            this.groupBox7.TabIndex = 2;
            this.groupBox7.TabStop = false;
            // 
            // lvWorkList
            // 
            this.lvWorkList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lvWorkList.GridLines = true;
            this.lvWorkList.Location = new System.Drawing.Point(3, 16);
            this.lvWorkList.Name = "lvWorkList";
            this.lvWorkList.Size = new System.Drawing.Size(856, 235);
            this.lvWorkList.TabIndex = 0;
            this.lvWorkList.UseCompatibleStateImageBehavior = false;
            this.lvWorkList.View = System.Windows.Forms.View.Details;
            // 
            // tabPage3
            // 
            this.tabPage3.Controls.Add(this.groupBox9);
            this.tabPage3.Location = new System.Drawing.Point(4, 22);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Size = new System.Drawing.Size(878, 456);
            this.tabPage3.TabIndex = 4;
            this.tabPage3.Text = "WS";
            this.tabPage3.UseVisualStyleBackColor = true;
            // 
            // groupBox9
            // 
            this.groupBox9.Controls.Add(this.textBox1);
            this.groupBox9.Controls.Add(this.label20);
            this.groupBox9.Location = new System.Drawing.Point(8, 3);
            this.groupBox9.Name = "groupBox9";
            this.groupBox9.Size = new System.Drawing.Size(862, 50);
            this.groupBox9.TabIndex = 0;
            this.groupBox9.TabStop = false;
            // 
            // label20
            // 
            this.label20.AutoSize = true;
            this.label20.Location = new System.Drawing.Point(6, 23);
            this.label20.Name = "label20";
            this.label20.Size = new System.Drawing.Size(47, 13);
            this.label20.TabIndex = 0;
            this.label20.Text = "WSURL";
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(59, 19);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(797, 20);
            this.textBox1.TabIndex = 1;
            // 
            // frmToolMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(886, 482);
            this.Controls.Add(this.tabControl1);
            this.Name = "frmToolMain";
            this.Text = "KIOSK.Integration.WinForm.Tool";
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox4.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.tabPage2.ResumeLayout(false);
            this.groupBox8.ResumeLayout(false);
            this.groupBox5.ResumeLayout(false);
            this.groupBox5.PerformLayout();
            this.groupBox6.ResumeLayout(false);
            this.groupBox6.PerformLayout();
            this.groupBox7.ResumeLayout(false);
            this.tabPage3.ResumeLayout(false);
            this.groupBox9.ResumeLayout(false);
            this.groupBox9.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox tbPassword;
        private System.Windows.Forms.TextBox tbUserName;
        private System.Windows.Forms.TextBox tbDBName;
        private System.Windows.Forms.TextBox tbDBServer;
        private System.Windows.Forms.ComboBox cbDBType;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.RichTextBox rtbSQL;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.ListView lvDBExamInfo;
        private System.Windows.Forms.Button btnQueryDB;
        private System.Windows.Forms.GroupBox groupBox8;
        private System.Windows.Forms.Button btnQueryMWL;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox tbPort;
        private System.Windows.Forms.TextBox tbNode;
        private System.Windows.Forms.TextBox tbCalledAE;
        private System.Windows.Forms.TextBox tbCallingAE;
        private System.Windows.Forms.GroupBox groupBox6;
        private System.Windows.Forms.TextBox tbEndTime;
        private System.Windows.Forms.TextBox tbBeginTime;
        private System.Windows.Forms.Label label15;
        private System.Windows.Forms.Label label19;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.TextBox tbAccessionNumber;
        private System.Windows.Forms.Label label18;
        private System.Windows.Forms.TextBox tbModality;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Label label16;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.TextBox tbBeginDate;
        private System.Windows.Forms.ComboBox cbStudyStatusID;
        private System.Windows.Forms.TextBox tbPatientID;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.Label label17;
        private System.Windows.Forms.TextBox tbEndDate;
        private System.Windows.Forms.TextBox tbPatientName;
        private System.Windows.Forms.GroupBox groupBox7;
        private System.Windows.Forms.ListView lvWorkList;
        private System.Windows.Forms.TabPage tabPage3;
        private System.Windows.Forms.GroupBox groupBox9;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Label label20;

    }
}

