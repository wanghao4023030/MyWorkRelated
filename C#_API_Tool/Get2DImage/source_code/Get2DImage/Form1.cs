using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Get2DImageWeb;
using System.IO;

namespace Get2DImage
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            richTextBox1.Visible = false;
            
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button_getImage_Click(object sender, EventArgs e)
        {
            
            string URL = textBox_URL.Text;
            string PID = textBox_PID.Text;
            string QRCode = textBox_QRCodeScale.Text;
            string QRError = textBox_QRCodeError.Text;
            pictureBox.Image = null;

            WebAPI web = new WebAPI();
            web.Get2DImage(URL, PID, QRCode, QRError);

            
            if (web.status == true)
            {
                richTextBox1.Visible = false;
                pictureBox.Visible = true;
                StreamReader sr = new StreamReader(web.ImagePath);
                Bitmap tempimage = (Bitmap)Bitmap.FromStream(sr.BaseStream);
                sr.Close();
                pictureBox.Image = tempimage;
            }
            if (web.status == false)
            {
                richTextBox1.Visible = true;
                pictureBox.Visible = false;
                richTextBox1.Text = web.ExMessage;
            }





            
   

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }
    }
}
