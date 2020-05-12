namespace TUX_DocumentProcess
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
            this.btn_Execute = new System.Windows.Forms.Button();
            this.label_help = new System.Windows.Forms.Label();
            this.txtbox_KeyWords = new System.Windows.Forms.TextBox();
            this.label_caseKeywords = new System.Windows.Forms.Label();
            this.checkBox_zip = new System.Windows.Forms.CheckBox();
            this.SuspendLayout();
            // 
            // btn_Execute
            // 
            this.btn_Execute.Location = new System.Drawing.Point(620, 297);
            this.btn_Execute.Name = "btn_Execute";
            this.btn_Execute.Size = new System.Drawing.Size(75, 23);
            this.btn_Execute.TabIndex = 0;
            this.btn_Execute.Text = "Execute";
            this.btn_Execute.UseVisualStyleBackColor = true;
            this.btn_Execute.Click += new System.EventHandler(this.button1_Click);
            // 
            // label_help
            // 
            this.label_help.AutoSize = true;
            this.label_help.Location = new System.Drawing.Point(72, 72);
            this.label_help.Name = "label_help";
            this.label_help.Size = new System.Drawing.Size(153, 13);
            this.label_help.TabIndex = 1;
            this.label_help.Text = "help and applcaition instruction";
            // 
            // txtbox_KeyWords
            // 
            this.txtbox_KeyWords.Location = new System.Drawing.Point(180, 299);
            this.txtbox_KeyWords.Name = "txtbox_KeyWords";
            this.txtbox_KeyWords.Size = new System.Drawing.Size(316, 20);
            this.txtbox_KeyWords.TabIndex = 2;
            // 
            // label_caseKeywords
            // 
            this.label_caseKeywords.AutoSize = true;
            this.label_caseKeywords.Location = new System.Drawing.Point(72, 302);
            this.label_caseKeywords.Name = "label_caseKeywords";
            this.label_caseKeywords.Size = new System.Drawing.Size(86, 13);
            this.label_caseKeywords.TabIndex = 3;
            this.label_caseKeywords.Text = "Case Key Words";
            // 
            // checkBox_zip
            // 
            this.checkBox_zip.AutoSize = true;
            this.checkBox_zip.Location = new System.Drawing.Point(516, 303);
            this.checkBox_zip.Name = "checkBox_zip";
            this.checkBox_zip.Size = new System.Drawing.Size(43, 17);
            this.checkBox_zip.TabIndex = 4;
            this.checkBox_zip.Text = "ZIP";
            this.checkBox_zip.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(765, 497);
            this.Controls.Add(this.checkBox_zip);
            this.Controls.Add(this.label_caseKeywords);
            this.Controls.Add(this.txtbox_KeyWords);
            this.Controls.Add(this.label_help);
            this.Controls.Add(this.btn_Execute);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btn_Execute;
        private System.Windows.Forms.Label label_help;
        private System.Windows.Forms.TextBox txtbox_KeyWords;
        private System.Windows.Forms.Label label_caseKeywords;
        private System.Windows.Forms.CheckBox checkBox_zip;
    }
}

