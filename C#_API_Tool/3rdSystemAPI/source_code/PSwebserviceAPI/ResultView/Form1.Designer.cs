namespace ResultView
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
            this.btn_log = new System.Windows.Forms.Button();
            this.rtb_logInfo = new System.Windows.Forms.RichTextBox();
            this.btn_del = new System.Windows.Forms.Button();
            this.tabControl = new System.Windows.Forms.TabControl();
            this.tabPage_3rdSystem = new System.Windows.Forms.TabPage();
            this.tabPage_GetURL = new System.Windows.Forms.TabPage();
            this.btn_URL_Copy = new System.Windows.Forms.Button();
            this.picBox_URL_Code = new System.Windows.Forms.PictureBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.richTextBox_decode = new System.Windows.Forms.RichTextBox();
            this.btn_URL_Open = new System.Windows.Forms.Button();
            this.textBox_GetURL_AuthCode = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.rtBox_GetURL = new System.Windows.Forms.RichTextBox();
            this.textBox_GetURL_ACCN = new System.Windows.Forms.TextBox();
            this.textBox_GetURL_PID = new System.Windows.Forms.TextBox();
            this.label_ACCN = new System.Windows.Forms.Label();
            this.label_PID = new System.Windows.Forms.Label();
            this.textBox_GetURL_URL = new System.Windows.Forms.TextBox();
            this.label_URL = new System.Windows.Forms.Label();
            this.btn_GetURL = new System.Windows.Forms.Button();
            this.tabPage_QRcode = new System.Windows.Forms.TabPage();
            this.label9 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.PicBox_QR_2D = new System.Windows.Forms.PictureBox();
            this.btn_QR_Copy = new System.Windows.Forms.Button();
            this.richTextBox_QR_decode = new System.Windows.Forms.RichTextBox();
            this.btn_QR_Open = new System.Windows.Forms.Button();
            this.label7 = new System.Windows.Forms.Label();
            this.textBox_QR_AuthCode = new System.Windows.Forms.TextBox();
            this.richTextBox_QRcode_Return = new System.Windows.Forms.RichTextBox();
            this.btn_GetURLCode = new System.Windows.Forms.Button();
            this.textBox_QR_PID = new System.Windows.Forms.TextBox();
            this.textBox_QR_ACCN = new System.Windows.Forms.TextBox();
            this.textBox_QR_URL = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.tabControl.SuspendLayout();
            this.tabPage_3rdSystem.SuspendLayout();
            this.tabPage_GetURL.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.picBox_URL_Code)).BeginInit();
            this.tabPage_QRcode.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.PicBox_QR_2D)).BeginInit();
            this.SuspendLayout();
            // 
            // btn_log
            // 
            this.btn_log.Location = new System.Drawing.Point(998, 33);
            this.btn_log.Name = "btn_log";
            this.btn_log.Size = new System.Drawing.Size(75, 23);
            this.btn_log.TabIndex = 0;
            this.btn_log.Text = "GetLog";
            this.btn_log.UseVisualStyleBackColor = true;
            this.btn_log.Click += new System.EventHandler(this.btn_log_Click);
            // 
            // rtb_logInfo
            // 
            this.rtb_logInfo.Location = new System.Drawing.Point(16, 33);
            this.rtb_logInfo.Name = "rtb_logInfo";
            this.rtb_logInfo.Size = new System.Drawing.Size(948, 534);
            this.rtb_logInfo.TabIndex = 1;
            this.rtb_logInfo.Text = "";
            // 
            // btn_del
            // 
            this.btn_del.Location = new System.Drawing.Point(998, 82);
            this.btn_del.Name = "btn_del";
            this.btn_del.Size = new System.Drawing.Size(75, 23);
            this.btn_del.TabIndex = 2;
            this.btn_del.Text = "Delete";
            this.btn_del.UseVisualStyleBackColor = true;
            this.btn_del.Click += new System.EventHandler(this.btn_del_Click);
            // 
            // tabControl
            // 
            this.tabControl.Controls.Add(this.tabPage_3rdSystem);
            this.tabControl.Controls.Add(this.tabPage_GetURL);
            this.tabControl.Controls.Add(this.tabPage_QRcode);
            this.tabControl.Location = new System.Drawing.Point(45, 28);
            this.tabControl.Name = "tabControl";
            this.tabControl.SelectedIndex = 0;
            this.tabControl.Size = new System.Drawing.Size(1116, 627);
            this.tabControl.TabIndex = 4;
            // 
            // tabPage_3rdSystem
            // 
            this.tabPage_3rdSystem.Controls.Add(this.rtb_logInfo);
            this.tabPage_3rdSystem.Controls.Add(this.btn_del);
            this.tabPage_3rdSystem.Controls.Add(this.btn_log);
            this.tabPage_3rdSystem.Location = new System.Drawing.Point(4, 22);
            this.tabPage_3rdSystem.Name = "tabPage_3rdSystem";
            this.tabPage_3rdSystem.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage_3rdSystem.Size = new System.Drawing.Size(1108, 601);
            this.tabPage_3rdSystem.TabIndex = 0;
            this.tabPage_3rdSystem.Text = "3rdSystem";
            this.tabPage_3rdSystem.UseVisualStyleBackColor = true;
            // 
            // tabPage_GetURL
            // 
            this.tabPage_GetURL.Controls.Add(this.btn_URL_Copy);
            this.tabPage_GetURL.Controls.Add(this.picBox_URL_Code);
            this.tabPage_GetURL.Controls.Add(this.label3);
            this.tabPage_GetURL.Controls.Add(this.label2);
            this.tabPage_GetURL.Controls.Add(this.richTextBox_decode);
            this.tabPage_GetURL.Controls.Add(this.btn_URL_Open);
            this.tabPage_GetURL.Controls.Add(this.textBox_GetURL_AuthCode);
            this.tabPage_GetURL.Controls.Add(this.label1);
            this.tabPage_GetURL.Controls.Add(this.rtBox_GetURL);
            this.tabPage_GetURL.Controls.Add(this.textBox_GetURL_ACCN);
            this.tabPage_GetURL.Controls.Add(this.textBox_GetURL_PID);
            this.tabPage_GetURL.Controls.Add(this.label_ACCN);
            this.tabPage_GetURL.Controls.Add(this.label_PID);
            this.tabPage_GetURL.Controls.Add(this.textBox_GetURL_URL);
            this.tabPage_GetURL.Controls.Add(this.label_URL);
            this.tabPage_GetURL.Controls.Add(this.btn_GetURL);
            this.tabPage_GetURL.Location = new System.Drawing.Point(4, 22);
            this.tabPage_GetURL.Name = "tabPage_GetURL";
            this.tabPage_GetURL.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage_GetURL.Size = new System.Drawing.Size(1108, 601);
            this.tabPage_GetURL.TabIndex = 1;
            this.tabPage_GetURL.Text = "QueryCloudFilmUrl";
            this.tabPage_GetURL.UseVisualStyleBackColor = true;
            // 
            // btn_URL_Copy
            // 
            this.btn_URL_Copy.Location = new System.Drawing.Point(779, 207);
            this.btn_URL_Copy.Name = "btn_URL_Copy";
            this.btn_URL_Copy.Size = new System.Drawing.Size(90, 23);
            this.btn_URL_Copy.TabIndex = 15;
            this.btn_URL_Copy.Text = "CopyURL";
            this.btn_URL_Copy.UseVisualStyleBackColor = true;
            this.btn_URL_Copy.Click += new System.EventHandler(this.btn_URL_Copy_Click);
            // 
            // picBox_URL_Code
            // 
            this.picBox_URL_Code.Location = new System.Drawing.Point(521, 379);
            this.picBox_URL_Code.Name = "picBox_URL_Code";
            this.picBox_URL_Code.Size = new System.Drawing.Size(200, 200);
            this.picBox_URL_Code.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.picBox_URL_Code.TabIndex = 14;
            this.picBox_URL_Code.TabStop = false;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(99, 275);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(103, 13);
            this.label3.TabIndex = 13;
            this.label3.Text = "ReturnURL_decode";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(99, 170);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(61, 13);
            this.label2.TabIndex = 12;
            this.label2.Text = "ReturnURL";
            // 
            // richTextBox_decode
            // 
            this.richTextBox_decode.Location = new System.Drawing.Point(215, 272);
            this.richTextBox_decode.Name = "richTextBox_decode";
            this.richTextBox_decode.Size = new System.Drawing.Size(506, 79);
            this.richTextBox_decode.TabIndex = 11;
            this.richTextBox_decode.Text = "";
            // 
            // btn_URL_Open
            // 
            this.btn_URL_Open.Location = new System.Drawing.Point(779, 167);
            this.btn_URL_Open.Name = "btn_URL_Open";
            this.btn_URL_Open.Size = new System.Drawing.Size(90, 23);
            this.btn_URL_Open.TabIndex = 10;
            this.btn_URL_Open.Text = "OpenURL";
            this.btn_URL_Open.UseVisualStyleBackColor = true;
            this.btn_URL_Open.Click += new System.EventHandler(this.btn_URL_Open_Click);
            // 
            // textBox_GetURL_AuthCode
            // 
            this.textBox_GetURL_AuthCode.Location = new System.Drawing.Point(215, 133);
            this.textBox_GetURL_AuthCode.Name = "textBox_GetURL_AuthCode";
            this.textBox_GetURL_AuthCode.Size = new System.Drawing.Size(506, 20);
            this.textBox_GetURL_AuthCode.TabIndex = 9;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(99, 136);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(84, 13);
            this.label1.TabIndex = 8;
            this.label1.Text = "ReturnKeyValue";
            // 
            // rtBox_GetURL
            // 
            this.rtBox_GetURL.Location = new System.Drawing.Point(215, 167);
            this.rtBox_GetURL.Name = "rtBox_GetURL";
            this.rtBox_GetURL.Size = new System.Drawing.Size(506, 79);
            this.rtBox_GetURL.TabIndex = 7;
            this.rtBox_GetURL.Text = "";
            // 
            // textBox_GetURL_ACCN
            // 
            this.textBox_GetURL_ACCN.Location = new System.Drawing.Point(215, 100);
            this.textBox_GetURL_ACCN.Name = "textBox_GetURL_ACCN";
            this.textBox_GetURL_ACCN.Size = new System.Drawing.Size(506, 20);
            this.textBox_GetURL_ACCN.TabIndex = 6;
            // 
            // textBox_GetURL_PID
            // 
            this.textBox_GetURL_PID.Location = new System.Drawing.Point(215, 74);
            this.textBox_GetURL_PID.Name = "textBox_GetURL_PID";
            this.textBox_GetURL_PID.Size = new System.Drawing.Size(506, 20);
            this.textBox_GetURL_PID.TabIndex = 5;
            // 
            // label_ACCN
            // 
            this.label_ACCN.AutoSize = true;
            this.label_ACCN.Location = new System.Drawing.Point(99, 107);
            this.label_ACCN.Name = "label_ACCN";
            this.label_ACCN.Size = new System.Drawing.Size(72, 13);
            this.label_ACCN.TabIndex = 4;
            this.label_ACCN.Text = "PatientACCN:";
            // 
            // label_PID
            // 
            this.label_PID.AutoSize = true;
            this.label_PID.Location = new System.Drawing.Point(99, 74);
            this.label_PID.Name = "label_PID";
            this.label_PID.Size = new System.Drawing.Size(60, 13);
            this.label_PID.TabIndex = 3;
            this.label_PID.Text = "Patiet    ID:";
            // 
            // textBox_GetURL_URL
            // 
            this.textBox_GetURL_URL.Location = new System.Drawing.Point(215, 48);
            this.textBox_GetURL_URL.Name = "textBox_GetURL_URL";
            this.textBox_GetURL_URL.Size = new System.Drawing.Size(506, 20);
            this.textBox_GetURL_URL.TabIndex = 2;
            // 
            // label_URL
            // 
            this.label_URL.AutoSize = true;
            this.label_URL.Location = new System.Drawing.Point(99, 48);
            this.label_URL.Name = "label_URL";
            this.label_URL.Size = new System.Drawing.Size(75, 13);
            this.label_URL.TabIndex = 1;
            this.label_URL.Text = "Request URL:";
            // 
            // btn_GetURL
            // 
            this.btn_GetURL.Location = new System.Drawing.Point(779, 48);
            this.btn_GetURL.Name = "btn_GetURL";
            this.btn_GetURL.Size = new System.Drawing.Size(90, 20);
            this.btn_GetURL.TabIndex = 0;
            this.btn_GetURL.Text = "GetURL";
            this.btn_GetURL.UseVisualStyleBackColor = true;
            this.btn_GetURL.Click += new System.EventHandler(this.btn_GetURL_Click);
            // 
            // tabPage_QRcode
            // 
            this.tabPage_QRcode.Controls.Add(this.label9);
            this.tabPage_QRcode.Controls.Add(this.label8);
            this.tabPage_QRcode.Controls.Add(this.PicBox_QR_2D);
            this.tabPage_QRcode.Controls.Add(this.btn_QR_Copy);
            this.tabPage_QRcode.Controls.Add(this.richTextBox_QR_decode);
            this.tabPage_QRcode.Controls.Add(this.btn_QR_Open);
            this.tabPage_QRcode.Controls.Add(this.label7);
            this.tabPage_QRcode.Controls.Add(this.textBox_QR_AuthCode);
            this.tabPage_QRcode.Controls.Add(this.richTextBox_QRcode_Return);
            this.tabPage_QRcode.Controls.Add(this.btn_GetURLCode);
            this.tabPage_QRcode.Controls.Add(this.textBox_QR_PID);
            this.tabPage_QRcode.Controls.Add(this.textBox_QR_ACCN);
            this.tabPage_QRcode.Controls.Add(this.textBox_QR_URL);
            this.tabPage_QRcode.Controls.Add(this.label6);
            this.tabPage_QRcode.Controls.Add(this.label5);
            this.tabPage_QRcode.Controls.Add(this.label4);
            this.tabPage_QRcode.Location = new System.Drawing.Point(4, 22);
            this.tabPage_QRcode.Name = "tabPage_QRcode";
            this.tabPage_QRcode.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage_QRcode.Size = new System.Drawing.Size(1108, 601);
            this.tabPage_QRcode.TabIndex = 2;
            this.tabPage_QRcode.Text = "QueryCloudFilmUrlQRcode";
            this.tabPage_QRcode.UseVisualStyleBackColor = true;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(96, 279);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(106, 13);
            this.label9.TabIndex = 15;
            this.label9.Text = "ReturnURL_decode:";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(96, 165);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(64, 13);
            this.label8.TabIndex = 14;
            this.label8.Text = "ReturnURL:";
            // 
            // PicBox_QR_2D
            // 
            this.PicBox_QR_2D.Location = new System.Drawing.Point(552, 381);
            this.PicBox_QR_2D.Name = "PicBox_QR_2D";
            this.PicBox_QR_2D.Size = new System.Drawing.Size(200, 200);
            this.PicBox_QR_2D.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.PicBox_QR_2D.TabIndex = 13;
            this.PicBox_QR_2D.TabStop = false;
            // 
            // btn_QR_Copy
            // 
            this.btn_QR_Copy.Location = new System.Drawing.Point(805, 194);
            this.btn_QR_Copy.Name = "btn_QR_Copy";
            this.btn_QR_Copy.Size = new System.Drawing.Size(87, 23);
            this.btn_QR_Copy.TabIndex = 12;
            this.btn_QR_Copy.Text = "CopyURL";
            this.btn_QR_Copy.UseVisualStyleBackColor = true;
            this.btn_QR_Copy.Click += new System.EventHandler(this.btn_QR_Copy_Click);
            // 
            // richTextBox_QR_decode
            // 
            this.richTextBox_QR_decode.Location = new System.Drawing.Point(211, 276);
            this.richTextBox_QR_decode.Name = "richTextBox_QR_decode";
            this.richTextBox_QR_decode.Size = new System.Drawing.Size(541, 86);
            this.richTextBox_QR_decode.TabIndex = 11;
            this.richTextBox_QR_decode.Text = "";
            // 
            // btn_QR_Open
            // 
            this.btn_QR_Open.Location = new System.Drawing.Point(805, 165);
            this.btn_QR_Open.Name = "btn_QR_Open";
            this.btn_QR_Open.Size = new System.Drawing.Size(87, 23);
            this.btn_QR_Open.TabIndex = 10;
            this.btn_QR_Open.Text = "OpenURL";
            this.btn_QR_Open.UseVisualStyleBackColor = true;
            this.btn_QR_Open.Click += new System.EventHandler(this.btn_QR_Open_Click);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(96, 128);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(87, 13);
            this.label7.TabIndex = 9;
            this.label7.Text = "ReturnKeyValue:";
            // 
            // textBox_QR_AuthCode
            // 
            this.textBox_QR_AuthCode.Location = new System.Drawing.Point(214, 128);
            this.textBox_QR_AuthCode.Name = "textBox_QR_AuthCode";
            this.textBox_QR_AuthCode.Size = new System.Drawing.Size(538, 20);
            this.textBox_QR_AuthCode.TabIndex = 8;
            // 
            // richTextBox_QRcode_Return
            // 
            this.richTextBox_QRcode_Return.Location = new System.Drawing.Point(211, 165);
            this.richTextBox_QRcode_Return.Name = "richTextBox_QRcode_Return";
            this.richTextBox_QRcode_Return.Size = new System.Drawing.Size(541, 92);
            this.richTextBox_QRcode_Return.TabIndex = 7;
            this.richTextBox_QRcode_Return.Text = "";
            // 
            // btn_GetURLCode
            // 
            this.btn_GetURLCode.Location = new System.Drawing.Point(805, 50);
            this.btn_GetURLCode.Name = "btn_GetURLCode";
            this.btn_GetURLCode.Size = new System.Drawing.Size(87, 23);
            this.btn_GetURLCode.TabIndex = 6;
            this.btn_GetURLCode.Text = "GetURLCode";
            this.btn_GetURLCode.UseVisualStyleBackColor = true;
            this.btn_GetURLCode.Click += new System.EventHandler(this.btn_GetURLCode_Click);
            // 
            // textBox_QR_PID
            // 
            this.textBox_QR_PID.Location = new System.Drawing.Point(214, 76);
            this.textBox_QR_PID.Name = "textBox_QR_PID";
            this.textBox_QR_PID.Size = new System.Drawing.Size(538, 20);
            this.textBox_QR_PID.TabIndex = 5;
            // 
            // textBox_QR_ACCN
            // 
            this.textBox_QR_ACCN.Location = new System.Drawing.Point(214, 102);
            this.textBox_QR_ACCN.Name = "textBox_QR_ACCN";
            this.textBox_QR_ACCN.Size = new System.Drawing.Size(538, 20);
            this.textBox_QR_ACCN.TabIndex = 4;
            // 
            // textBox_QR_URL
            // 
            this.textBox_QR_URL.Location = new System.Drawing.Point(214, 50);
            this.textBox_QR_URL.Name = "textBox_QR_URL";
            this.textBox_QR_URL.Size = new System.Drawing.Size(538, 20);
            this.textBox_QR_URL.TabIndex = 3;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(96, 79);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(57, 13);
            this.label6.TabIndex = 2;
            this.label6.Text = "Patient ID:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(96, 105);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(72, 13);
            this.label5.TabIndex = 1;
            this.label5.Text = "PatientACCN:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(96, 53);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(75, 13);
            this.label4.TabIndex = 0;
            this.label4.Text = "Request URL:";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1189, 676);
            this.Controls.Add(this.tabControl);
            this.Name = "Form1";
            this.Text = "Simulate like 3rd system";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.tabControl.ResumeLayout(false);
            this.tabPage_3rdSystem.ResumeLayout(false);
            this.tabPage_GetURL.ResumeLayout(false);
            this.tabPage_GetURL.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.picBox_URL_Code)).EndInit();
            this.tabPage_QRcode.ResumeLayout(false);
            this.tabPage_QRcode.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.PicBox_QR_2D)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btn_log;
        private System.Windows.Forms.RichTextBox rtb_logInfo;
        private System.Windows.Forms.Button btn_del;
        private System.Windows.Forms.TabControl tabControl;
        private System.Windows.Forms.TabPage tabPage_3rdSystem;
        private System.Windows.Forms.TabPage tabPage_GetURL;
        private System.Windows.Forms.Label label_URL;
        private System.Windows.Forms.Button btn_GetURL;
        private System.Windows.Forms.TextBox textBox_GetURL_URL;
        private System.Windows.Forms.Label label_PID;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.RichTextBox rtBox_GetURL;
        private System.Windows.Forms.TextBox textBox_GetURL_ACCN;
        private System.Windows.Forms.TextBox textBox_GetURL_PID;
        private System.Windows.Forms.Label label_ACCN;
        private System.Windows.Forms.TextBox textBox_GetURL_AuthCode;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.RichTextBox richTextBox_decode;
        private System.Windows.Forms.Button btn_URL_Open;
        private System.Windows.Forms.TabPage tabPage_QRcode;
        private System.Windows.Forms.RichTextBox richTextBox_QRcode_Return;
        private System.Windows.Forms.Button btn_GetURLCode;
        private System.Windows.Forms.TextBox textBox_QR_PID;
        private System.Windows.Forms.TextBox textBox_QR_ACCN;
        private System.Windows.Forms.TextBox textBox_QR_URL;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox textBox_QR_AuthCode;
        private System.Windows.Forms.Button btn_QR_Open;
        private System.Windows.Forms.RichTextBox richTextBox_QR_decode;
        private System.Windows.Forms.Button btn_QR_Copy;
        private System.Windows.Forms.PictureBox PicBox_QR_2D;
        private System.Windows.Forms.Button btn_URL_Copy;
        private System.Windows.Forms.PictureBox picBox_URL_Code;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label8;
    }
}

