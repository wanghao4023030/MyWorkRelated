namespace Get2DImage
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
            this.textBox_URL = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.textBox_PID = new System.Windows.Forms.TextBox();
            this.textBox_QRCodeScale = new System.Windows.Forms.TextBox();
            this.textBox_QRCodeError = new System.Windows.Forms.TextBox();
            this.button_getImage = new System.Windows.Forms.Button();
            this.richTextBox1 = new System.Windows.Forms.RichTextBox();
            this.pictureBox = new System.Windows.Forms.PictureBox();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox)).BeginInit();
            this.SuspendLayout();
            // 
            // textBox_URL
            // 
            this.textBox_URL.Location = new System.Drawing.Point(149, 58);
            this.textBox_URL.Name = "textBox_URL";
            this.textBox_URL.Size = new System.Drawing.Size(416, 20);
            this.textBox_URL.TabIndex = 0;
            this.textBox_URL.Text = "http://10.184.129.108/PSPrintQueryServer/QueryService.asmx";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(28, 61);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(95, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Http Request URL";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(28, 97);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(51, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "PatientID";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(28, 135);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(75, 13);
            this.label3.TabIndex = 3;
            this.label3.Text = "QRCodeScale";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(28, 187);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(104, 13);
            this.label4.TabIndex = 4;
            this.label4.Text = "QRCodeErrorCorrect";
            // 
            // textBox_PID
            // 
            this.textBox_PID.Location = new System.Drawing.Point(149, 94);
            this.textBox_PID.Name = "textBox_PID";
            this.textBox_PID.Size = new System.Drawing.Size(416, 20);
            this.textBox_PID.TabIndex = 5;
            // 
            // textBox_QRCodeScale
            // 
            this.textBox_QRCodeScale.Location = new System.Drawing.Point(149, 132);
            this.textBox_QRCodeScale.Name = "textBox_QRCodeScale";
            this.textBox_QRCodeScale.Size = new System.Drawing.Size(416, 20);
            this.textBox_QRCodeScale.TabIndex = 6;
            this.textBox_QRCodeScale.Text = "3";
            // 
            // textBox_QRCodeError
            // 
            this.textBox_QRCodeError.Location = new System.Drawing.Point(149, 180);
            this.textBox_QRCodeError.Name = "textBox_QRCodeError";
            this.textBox_QRCodeError.Size = new System.Drawing.Size(416, 20);
            this.textBox_QRCodeError.TabIndex = 7;
            this.textBox_QRCodeError.Text = "1";
            // 
            // button_getImage
            // 
            this.button_getImage.Location = new System.Drawing.Point(490, 229);
            this.button_getImage.Name = "button_getImage";
            this.button_getImage.Size = new System.Drawing.Size(75, 23);
            this.button_getImage.TabIndex = 8;
            this.button_getImage.Text = "Get2DImage";
            this.button_getImage.UseVisualStyleBackColor = true;
            this.button_getImage.Click += new System.EventHandler(this.button_getImage_Click);
            // 
            // richTextBox1
            // 
            this.richTextBox1.Location = new System.Drawing.Point(149, 278);
            this.richTextBox1.Name = "richTextBox1";
            this.richTextBox1.Size = new System.Drawing.Size(416, 181);
            this.richTextBox1.TabIndex = 9;
            this.richTextBox1.Text = "";
            this.richTextBox1.TextChanged += new System.EventHandler(this.richTextBox1_TextChanged);
            // 
            // pictureBox
            // 
            this.pictureBox.Location = new System.Drawing.Point(149, 278);
            this.pictureBox.Name = "pictureBox";
            this.pictureBox.Size = new System.Drawing.Size(416, 187);
            this.pictureBox.TabIndex = 10;
            this.pictureBox.TabStop = false;
            this.pictureBox.Click += new System.EventHandler(this.pictureBox1_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(626, 492);
            this.Controls.Add(this.pictureBox);
            this.Controls.Add(this.richTextBox1);
            this.Controls.Add(this.button_getImage);
            this.Controls.Add(this.textBox_QRCodeError);
            this.Controls.Add(this.textBox_QRCodeScale);
            this.Controls.Add(this.textBox_PID);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBox_URL);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox textBox_URL;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox textBox_PID;
        private System.Windows.Forms.TextBox textBox_QRCodeScale;
        private System.Windows.Forms.TextBox textBox_QRCodeError;
        private System.Windows.Forms.Button button_getImage;
        private System.Windows.Forms.RichTextBox richTextBox1;
        private System.Windows.Forms.PictureBox pictureBox;
    }
}

