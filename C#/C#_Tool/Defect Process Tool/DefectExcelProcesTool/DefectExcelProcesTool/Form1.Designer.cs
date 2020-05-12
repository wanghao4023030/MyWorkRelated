namespace DefectExcelProcesTool
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
            this.label_FileName = new System.Windows.Forms.Label();
            this.textBox_FilePath = new System.Windows.Forms.TextBox();
            this.btn_FileSelect = new System.Windows.Forms.Button();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.btn_Init = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label_FileName
            // 
            this.label_FileName.AutoSize = true;
            this.label_FileName.Location = new System.Drawing.Point(78, 48);
            this.label_FileName.Name = "label_FileName";
            this.label_FileName.Size = new System.Drawing.Size(50, 13);
            this.label_FileName.TabIndex = 0;
            this.label_FileName.Text = "File path:";
            // 
            // textBox_FilePath
            // 
            this.textBox_FilePath.Location = new System.Drawing.Point(134, 45);
            this.textBox_FilePath.Name = "textBox_FilePath";
            this.textBox_FilePath.Size = new System.Drawing.Size(447, 20);
            this.textBox_FilePath.TabIndex = 1;
            // 
            // btn_FileSelect
            // 
            this.btn_FileSelect.Location = new System.Drawing.Point(587, 45);
            this.btn_FileSelect.Name = "btn_FileSelect";
            this.btn_FileSelect.Size = new System.Drawing.Size(28, 23);
            this.btn_FileSelect.TabIndex = 2;
            this.btn_FileSelect.Text = "...";
            this.btn_FileSelect.UseVisualStyleBackColor = true;
            this.btn_FileSelect.Click += new System.EventHandler(this.btn_FileSelect_Click);
            // 
            // openFileDialog
            // 
            this.openFileDialog.FileName = "openFileDialog";
            // 
            // btn_Init
            // 
            this.btn_Init.Location = new System.Drawing.Point(631, 45);
            this.btn_Init.Name = "btn_Init";
            this.btn_Init.Size = new System.Drawing.Size(75, 23);
            this.btn_Init.TabIndex = 3;
            this.btn_Init.Text = "Init File";
            this.btn_Init.UseVisualStyleBackColor = true;
            this.btn_Init.Click += new System.EventHandler(this.btn_Init_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(812, 453);
            this.Controls.Add(this.btn_Init);
            this.Controls.Add(this.btn_FileSelect);
            this.Controls.Add(this.textBox_FilePath);
            this.Controls.Add(this.label_FileName);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label_FileName;
        private System.Windows.Forms.TextBox textBox_FilePath;
        private System.Windows.Forms.Button btn_FileSelect;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.Button btn_Init;
    }
}

