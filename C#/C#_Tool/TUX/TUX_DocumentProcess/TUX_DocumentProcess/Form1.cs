using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using MSWord = Microsoft.Office.Interop.Word;
using System.IO;
using System.Reflection;
using System.Diagnostics;

namespace TUX_DocumentProcess
{
    public partial class Form1 : Form
    {
        private object lable_help;

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string Keywords = txtbox_KeyWords.Text;
            bool ZipFlag = checkBox_zip.Checked;
            if (Keywords == "")
            {
                MessageBox.Show("Please Give the value for split words.");
            }
            else
            {
                btn_Execute.Enabled = false;
                CaseDoc DocProcess = new CaseDoc();
                DocProcess.GetAlldocFiles();
                DocProcess.FormatFolder();
                if (DocProcess.fileNamesList.Count >= 1)
                {
                    foreach (string filename in DocProcess.fileNamesList)
                    {
                        object orignalFilePath = Path.Combine(DocProcess.currentPath, filename);
                        string foldername = Path.GetFileNameWithoutExtension(filename);
                        foldername = Path.Combine(DocProcess.currentPath, foldername);
                        List<string> fileList = DocProcess.SplitCasesAndSaveas(Keywords, orignalFilePath, foldername);
                        if (ZipFlag)
                        {
                            foreach (string filepath in fileList)
                            {
                                //string PZipPath = @"C:\Program Files\7-Zip\7z.exe1";
                                string PZipPath = Path.Combine(Directory.GetParent(Directory.GetCurrentDirectory()).Parent.FullName, @"7-Zip");
                                PZipPath = Path.Combine(PZipPath, "7z.exe");
                                if (!File.Exists(PZipPath))
                                {
                                    MessageBox.Show("Your zip application is not exist! " + PZipPath);
                                    throw new System.ArgumentException("Your zip application is not exist! " + PZipPath);
                                }
                                //string targetCompressName = Path.Combine(foldername, filename.Split('.')[0]) + ".zip";
                                //string sourceCompressName = Path.Combine(foldername, filename);
                                string targetCompressName = filepath.Replace("doc", "zip");
                                string sourceCompressName = filepath;

                                ProcessStartInfo pCompress = new ProcessStartInfo();
                                pCompress.FileName = PZipPath;
                                pCompress.Arguments = "a -tzip \"" + targetCompressName + "\" \"" + sourceCompressName + "\" -mx=9";

                                Process x = Process.Start(pCompress);
                                x.WaitForExit();
                            }

                        }
                        

                    }

                    MessageBox.Show("Operation is finished.");
                    btn_Execute.Enabled = true;
                }
                else
                {
                    MessageBox.Show("No doc or docx files in path " + DocProcess.currentPath.ToString());
                    btn_Execute.Enabled = true;
                }
            }
            btn_Execute.Enabled = true;

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            label_help.Text = "This tool is use to process the TUX procedure and log document.\n" +
                "You can put the doc and docx documents in the same folder of this application.\n" +
                "The applcation will split the test cases with the \"key words\".\n" +
                "Each case will copy to a new doc document and name is the case title.\n" +
                "The new documents will compress with name in same folder.\n\n" +
                "Note:                             \n" +
                "1. Make sure you have install the MSWord 2013 and .net 4.0 \n" +
                "2. Make sure the application is under the D:\\work folder because the company IT privilege" +
                "will stop some bat and exe operations.\n" +
                "3. Make sure the application execute path is short. The long one will " +
                "create and zip files failed which limitted by the windows system.\n" +
                "4. Some files will process failed by lacking the privilege\n.";

            txtbox_KeyWords.Text = "(End of Test)";

            checkBox_zip.Checked = true;


                }
}
}
