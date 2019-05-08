using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace DefectExcelProcesTool
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }


        private void btn_FileSelect_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();

            openFileDialog.Title = "Select File";
            openFileDialog.Filter = "all files(*.*)|*.*";
            openFileDialog.FilterIndex = 1;
            //openFileDialog.InitialDirectory = System.IO.Directory.GetCurrentDirectory();
            openFileDialog.RestoreDirectory = true;
            openFileDialog.Multiselect = false;
            openFileDialog.CheckFileExists = true;

            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                string localFilePath = openFileDialog.FileName.ToString();
                textBox_FilePath.Text = localFilePath;

            }
        }
           
        private void btn_Init_Click(object sender, EventArgs e)
        {
            ExcelObject app = new ExcelObject();
            app.filePath = @textBox_FilePath.Text.ToString();
            MessageBox.Show(app.filePath);



        }

        



    }
}
