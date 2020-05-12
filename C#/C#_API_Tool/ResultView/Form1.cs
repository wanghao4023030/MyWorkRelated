using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.Configuration;
using QueryCloudFilmUrl;
using QueryCloudFilmUrlForQRcode;
using ZXing;
using System.Security.Cryptography;
using System.Web;

namespace ResultView
{
    public partial class Form1 : Form
    {
        //string logPath = ConfigurationManager.AppSettings["FilePath"];
        string logPath = System.AppDomain.CurrentDomain.BaseDirectory + @"Service.log";
        
        
        public Form1()
        {
            InitializeComponent();

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            textBox_GetURL_URL.Text = "http://10.184.129.108/NotifyServer/NotifyService.asmx ";
            textBox_GetURL_PID.Text = "PID001";
            textBox_GetURL_ACCN.Text = "E001";
            textBox_GetURL_AuthCode.Text = "";

            //btn_URL_2DImage.Enabled = false;
            //btn_URL_Decode.Enabled = false;
            //picBox_URL_Code.Enabled = false;


            textBox_QR_URL.Text = "http://10.184.129.108/NotifyServer/NotifyService.asmx ";
            textBox_QR_PID.Text = "PID001";
            textBox_QR_ACCN.Text = "E001";
            //btn_QR_Open.Enabled =false;
            //btn_QR_Copy.Enabled = false;
            //PicBox_QR_2D.Enabled = false;
            

        }

        private void btn_log_Click(object sender, EventArgs e)
        {
            try
            {
                using (StreamReader sr = new StreamReader(logPath, Encoding.Default))
                {
                    string line = sr.ReadToEnd();
                    rtb_logInfo.Text = line;
                }
            }
            catch (Exception ex) {
                rtb_logInfo.Text = "Cannot get the file or the file is not exist\n" + ex.ToString() + logPath;
            }

        }

        private void btn_del_Click(object sender, EventArgs e)
        {
            rtb_logInfo.Text = "";
            try
            {
                if (File.Exists(logPath))
                {
                    File.Delete(logPath);
                }
                else
                {
                    rtb_logInfo.Text = "The file is not exist!";
                }
            }
            catch (Exception ex)
            {
                rtb_logInfo.Text = ex.ToString();
            }

        }

        private void btn_GetURL_Click(object sender, EventArgs e)
        {
            string URL = textBox_GetURL_URL.Text;
            string PID = textBox_GetURL_PID.Text;
            string ACCN = textBox_GetURL_ACCN.Text;
            string AuthCode = textBox_GetURL_AuthCode.Text;


            //Get URL
            CloudFilmUrl URLObject = new CloudFilmUrl();
            string retURL = URLObject.GetUrl(URL, ACCN,PID);
            rtBox_GetURL.Text = "ReturnURL: " + retURL;
            textBox_GetURL_AuthCode.Text =  URLObject.GetKeyValue();

            //DecryKeyValue
            string KeyValue = textBox_GetURL_AuthCode.Text;
            string DecryKeyValue = URLObject.DecryptCareImageUrl(KeyValue);

            //Decode
            string URlPre = URLObject.GetURLPre(rtBox_GetURL.Text).ToString();
            richTextBox_decode.Text = URlPre + DecryKeyValue;

            //2D image
            picBox_URL_Code.Enabled = true;
            var barcodeWriter = new BarcodeWriter();
            barcodeWriter.Format = BarcodeFormat.QR_CODE;
            barcodeWriter.Options = new ZXing.Common.EncodingOptions { Width = 200, Height = 200 };
            string newURL = rtBox_GetURL.Text.Replace("ReturnURL: ", "");
            var QRcodeImage = new Bitmap(barcodeWriter.Write(newURL));
            picBox_URL_Code.Image = QRcodeImage;

            btn_URL_Copy.Enabled = true;
            btn_URL_Open.Enabled = true;

        }

        //private void button1_Click(object sender, EventArgs e)
        //{
        //    CloudFilmUrl URLObject = new CloudFilmUrl();
        //    string KeyValue = textBox_GetURL_AuthCode.Text;
        //    string DecryKeyValue = URLObject.DecryptCareImageUrl(KeyValue);

        //    string URlPre = URLObject.GetURLPre(rtBox_GetURL.Text).ToString();
        //    richTextBox_decode.Text = URlPre + DecryKeyValue;

        //}

        private void btn_GetURLCode_Click(object sender, EventArgs e)
        {
            string URL = textBox_QR_URL.Text;
            string PID = textBox_QR_PID.Text;
            string ACCN = textBox_QR_ACCN.Text;
            
            //GetURL
            CloudFilmUrlQRCode QRCode = new CloudFilmUrlQRCode();
            string ReturnURL = QRCode.GetUrlQRCode(URL, ACCN, PID);
            richTextBox_QRcode_Return.Text = "ReturnURL: " + ReturnURL;
            textBox_QR_AuthCode.Text = QRCode.GetKeyValue();

            //Get DecryCode
            string KeyValue = textBox_QR_AuthCode.Text;
            string DecryKeyValue = QRCode.DecryptCareImageUrl(KeyValue);
            string URlPre = QRCode.GetURLPre(richTextBox_QRcode_Return.Text).ToString();
            richTextBox_QR_decode.Text = URlPre + DecryKeyValue;

            //2D image
            var barcodeWriter = new BarcodeWriter();
            barcodeWriter.Format = BarcodeFormat.QR_CODE;
            barcodeWriter.Options = new ZXing.Common.EncodingOptions { Width = 200, Height = 200 };
            string newURL = richTextBox_QRcode_Return.Text.Replace("ReturnURL: ", "");
            var QRcodeImage = new Bitmap(barcodeWriter.Write(newURL));
            PicBox_QR_2D.Image = QRcodeImage;
            PicBox_QR_2D.Enabled = true;


            btn_QR_Open.Enabled = true;
            btn_QR_Copy.Enabled = true;

        }

        //private void btn_QR_decode_Click(object sender, EventArgs e)
        //{
        //    CloudFilmUrlQRCode QRCode = new CloudFilmUrlQRCode();
        //    string KeyValue = textBox_QR_AuthCode.Text;
        //    string DecryKeyValue = QRCode.DecryptCareImageUrl(KeyValue);
        //    string URlPre = QRCode.GetURLPre(richTextBox_QRcode_Return.Text).ToString();
        //    richTextBox_QR_decode.Text = URlPre + DecryKeyValue;
        //}

        //private void btn_QR_2DImage_Click(object sender, EventArgs e)
        //{
        //    var barcodeWriter = new BarcodeWriter();
        //    barcodeWriter.Format = BarcodeFormat.QR_CODE;
        //    barcodeWriter.Options = new ZXing.Common.EncodingOptions { Width = 200, Height = 200 };
        //    string URL = richTextBox_QRcode_Return.Text.Replace("ReturnURL: ", ""); 
        //    var QRcodeImage = new Bitmap(barcodeWriter.Write(URL));
        //    PicBox_QR_2D.Image = QRcodeImage;
        //    PicBox_QR_2D.Enabled = true;

        //}



    

        private void btn_QR_Open_Click(object sender, EventArgs e)
        {
            String URl = richTextBox_QRcode_Return.Text.Replace("ReturnURL: ", "");
            System.Diagnostics.Process.Start(URl);
        }

        private void btn_QR_Copy_Click(object sender, EventArgs e)
        {
            String URl = richTextBox_QRcode_Return.Text.Replace("ReturnURL: ", "");
            Clipboard.SetText(URl);
        }

        private void btn_URL_Open_Click(object sender, EventArgs e)
        {
            String URl = rtBox_GetURL.Text.Replace("ReturnURL: ", "");
            System.Diagnostics.Process.Start(URl);
        }

        private void btn_URL_Copy_Click(object sender, EventArgs e)
        {
            String URl = rtBox_GetURL.Text.Replace("ReturnURL: ", "");
            Clipboard.SetText(URl);
        }

        private void tabPage_QRcode_Click(object sender, EventArgs e)
        {

        }

        private void btn_decrypt_Click(object sender, EventArgs e)
        {
            try
            {
                string pwd = txtbox_password.Text;
                string URL = txtbox_decrptTxt.Text;

                CloudFilmUrlQRCode QRCode = new CloudFilmUrlQRCode();
                QRCode._RetURL = URL;

                //Get DecryCode
                string KeyValue =  QRCode.GetKeyValue();
                string DecryKeyValue = QRCode.DecryptURLKey(KeyValue, pwd);
                string URlPre = QRCode.GetURLPre(URL).ToString();
                txtbox_DecryptResult.Text = URlPre + DecryKeyValue;
 
               
            }
            catch (Exception error)
            {
                txtbox_DecryptResult.Text = error.ToString();
            }
            
        }





        //private void btn_URL_2DImage_Click(object sender, EventArgs e)
        //{
        //    picBox_URL_Code.Enabled = true;
        //    var barcodeWriter = new BarcodeWriter();
        //    barcodeWriter.Format = BarcodeFormat.QR_CODE;
        //    barcodeWriter.Options = new ZXing.Common.EncodingOptions { Width = 200, Height = 200 };
        //    string URL = rtBox_GetURL.Text.Replace("ReturnURL: ","");
        //    var QRcodeImage = new Bitmap(barcodeWriter.Write(URL));
        //    picBox_URL_Code.Image = QRcodeImage;
        //}







    }
}
