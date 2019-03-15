using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.IO;
using System.Configuration;
using System.Xml.Linq;
using System.Xml;

namespace Get2DImageWeb
{
    class WebAPI
    {
        public string APIString = null;
        public string ImagePath = null;
        public bool status = false;
        public string ExMessage = null;

        public void Get2DImage(string strURL,string strPID,string strQRCodeScale,string strQRCodeErrorCorrect)
        {
            try
            {
                string webRetrunString = Get2DCodeImage(strURL,strPID,strQRCodeScale,strQRCodeErrorCorrect);
                if (status == true)
                {

                    getResultNode(webRetrunString);

                    if (status == true && APIString != "")
                    {

                        Create2DImageFile(APIString);
                    }
                }
                
            }
            catch (Exception ex)
            {
                status = false;
                ExMessage = ex.Message.ToString();
            }



        }

        public string Get2DCodeImage(string strURL,string strPID,string strQRCodeScale,string strQRCodeErrorCorrect)
        {
            try
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(strURL);
                request.Method = "POST";
                //request.ContentType = "application/soap+xml;charset=GB2312";
                request.ContentType = "text/xml; charset=utf-8";
                string postData =   "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:wsa=\"http://schemas.xmlsoap.org/ws/2004/03/addressing\">" +
                                    "<soap:Header><wsa:Action>http://tempuri.org/Get2DCodeImage</wsa:Action>" +
                                    "<wsa:MessageID>uuid:efa86bd6-ef43-4b9a-af0d-6780db7cf075</wsa:MessageID>" +
                                    "<wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/03/addressing/role/anonymous</wsa:Address></wsa:ReplyTo>" +
                                    "<wsa:To>http://10.184.129.108/PSPrintQueryServer/QueryService.asmx</wsa:To></soap:Header>" +
                                    "<soap:Body>" +
                                    "<Get2DCodeImage xmlns=\"http://tempuri.org/\">" +
                                    "<patientID>" + strPID + "</patientID>" +
                                    "<qrcodeParam><QRCodeScale>" + strQRCodeScale +"</QRCodeScale>" +
                                    "<QRCodeErrorCorrect>" + strQRCodeErrorCorrect + "</QRCodeErrorCorrect>" +
                                    "</qrcodeParam></Get2DCodeImage>" +
                                    "</soap:Body></soap:Envelope>";

                byte[] bytes = Encoding.UTF8.GetBytes(postData);
                request.ContentLength = bytes.Length;

                Stream requestStream = request.GetRequestStream();
                requestStream.Write(bytes, 0, bytes.Length);

                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                Stream stream = response.GetResponseStream();
                StreamReader reader = new StreamReader(stream);

                if (response.StatusCode == HttpStatusCode.OK)
                {


                    var result = reader.ReadToEnd();
                    stream.Dispose();
                    reader.Dispose();
                    status = true;
                    ExMessage = result;
                    return result;
                }
                else {
                    string result = null;
                    stream.Dispose();
                    reader.Dispose();
                    status = false;
                    ExMessage = result;
                    return result;
                }

            }
            catch (Exception ex)
            {
                ExMessage = ex.ToString();
                return ex.ToString();
            }

        }

        public string getResultNode(string result)
        {
            try
            {
                string strResult = result;
                XmlDocument xml = new XmlDocument();
                xml.LoadXml(result);
                var root = xml.DocumentElement;

                APIString = root.InnerText;
                if (APIString != "")
                {
                    status = true;
                    return root.InnerText;
                }
                else
                {
                    status = false;
                    ExMessage = "Web Return content is empty.\n " + result; 
                    return ExMessage;
                }
                
            }
            catch (Exception ex)
            { 
                status= false;
                ExMessage = ex.ToString();
                return "false";
            }
            
            
        }

        public string Create2DImageFile(string strAPIString)
        {
            try
            {

                byte[] data = Convert.FromBase64String(strAPIString);
                string decodeString = Encoding.UTF8.GetString(data);
                string currentpath = Directory.GetCurrentDirectory();
                string strImagePath = Path.Combine(currentpath, "2Dimage.bmp");
                if (File.Exists(strImagePath))
                {
                    File.Delete(strImagePath);
                }

                using (FileStream fs = File.Create(strImagePath))
                {
                    fs.Write(data,0,data.Length);
                }
                

                ImagePath = strImagePath;
                ExMessage = "Create 2D image file successfully";
                return "true";

            }
            catch (Exception ex)
            { 
                status= false;
                ExMessage = ex.ToString();
                return "false";
            }
        }



    }
}
