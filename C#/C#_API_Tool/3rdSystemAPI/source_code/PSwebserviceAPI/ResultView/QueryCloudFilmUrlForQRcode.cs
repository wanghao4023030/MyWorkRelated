using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.IO;
using System.Xml;
using System.Security.Cryptography;
using System.Web;

namespace QueryCloudFilmUrlForQRcode
{
    class CloudFilmUrlQRCode
    {
        public string _RetURL;
        public string _KeyValue;

        public string GetUrlQRCode(string strURL, string strACCN, string strPID)
        {
            try
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(strURL);
                request.Method = "POST";
                //request.ContentType = "application/soap+xml;charset=GB2312";
                request.ContentType = "text/xml; charset=utf-8";
                string postData = "<?xml version=\"1.0\" encoding=\"utf-8\"?> " +
                                    "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:wsa=\"http://schemas.xmlsoap.org/ws/2004/03/addressing\">" +
                                    "<soap:Header><wsa:Action>http://carestream.org/QueryCloudFilmUrlForQrCode</wsa:Action><wsa:MessageID>uuid:2684249b-a3ac-4d46-8fd6-e454872d1adc</wsa:MessageID>" +
                                    "<wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/03/addressing/role/anonymous</wsa:Address></wsa:ReplyTo>" +
                                    "<wsa:To>http://10.184.129.108/NotifyServer/NotifyService.asmx</wsa:To>" +
                                    "</soap:Header><soap:Body>" +
                                    "<QueryCloudFilmUrlForQrCode xmlns=\"http://carestream.org/\"><accessionNumber>" + strACCN + "</accessionNumber>" +
                                    "<patientId>" + strPID + "</patientId></QueryCloudFilmUrlForQrCode>" +
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
                    result = GetResultNode(result);
                    _RetURL = result;
                    return result;
                }
                else {
                    string result = null;
                    stream.Dispose();
                    reader.Dispose();
                    return result;
                }

            }
            catch (Exception ex)
            {

                return ex.ToString();
            }
        }

        public string GetResultNode(string result)
        {
            try
            {
                string strResult = result;
                XmlDocument xml = new XmlDocument();
                xml.LoadXml(result);
                var root = xml.DocumentElement;

                string QueryCloudFilmUrlResult = root.InnerText;
                return QueryCloudFilmUrlResult;
  
            }
            catch (Exception ex)
            {

                return ex.ToString();
            }


        }

        public string GetKeyValue()
        {
            try
            {
                int index = _RetURL.IndexOf('=');
                string _KeyValue = _RetURL.Substring(index + 1);
                return _KeyValue;
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }

        public string DecryptCareImageUrl(string KeyValue)
        {
            //var bytes = System.Text.Encoding.UTF8.GetBytes(KeyValue);
            var bytes = HttpServerUtility.UrlTokenDecode(KeyValue);
            if (bytes == null)
            {
                return null;
            }
            var key = Encoding.UTF8.GetBytes("pdchi2002$kiosk!");
            byte[] iv;
            using (var md5 = MD5.Create())
            {
                iv = md5.ComputeHash(key);
            }
            string plantext;
            using (var aes = new RijndaelManaged())
            {
                aes.IV = iv;
                aes.Key = key;
                aes.Mode = CipherMode.CBC;
                aes.Padding = PaddingMode.PKCS7;
                var cryptoTransform = aes.CreateDecryptor();
                var resultArray = cryptoTransform.TransformFinalBlock(bytes, 0, bytes.Length);
                plantext = Encoding.UTF8.GetString(resultArray);
            }
            return plantext;
        }

        public string GetURLPre(string RetURL)
        {
            try
            {
                int index = RetURL.IndexOf('=');
                string URLPre = RetURL.Substring(0,index + 1);
                return URLPre;
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }


    }
}
