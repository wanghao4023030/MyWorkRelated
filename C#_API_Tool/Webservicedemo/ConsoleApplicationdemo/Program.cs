using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.IO;


namespace ConsoleApplicationdemo
{
    class Program
    {
        static void Main(string[] args)
        {
            string url = "http://localhost/PerformanceTest/CreateFilmTestData.asmx/QueryResult";
            StringBuilder requestBodayParam = new StringBuilder();
            requestBodayParam.Append("<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\">");
            requestBodayParam.Append("<soapenv:Header/>");
            requestBodayParam.Append("<soapenv:Body>");
            requestBodayParam.Append("<tem:QueryResult>");
            requestBodayParam.Append("<tem:strACCN>A20180119153128269</tem:strACCN>");
            requestBodayParam.Append("</tem:QueryResult>");
            requestBodayParam.Append("</soapenv:Body>");
            requestBodayParam.Append("</soapenv:Envelope>");
            Console.WriteLine("soap requet {0}", requestBodayParam.ToString());
            Console.WriteLine();

            try
            {
                HttpWebRequest httpRequest = (HttpWebRequest)WebRequest.Create(url);
                httpRequest.Method = "POST";
                httpRequest.ContentType = "application/x-www-form-urlencoded";
                httpRequest.Headers.Clear();
                byte[] bytes = Encoding.UTF8.GetBytes(requestBodayParam.ToString());
                //httpRequest.ContentLength = requestBodayParam.ToString().Length;

                Stream reqStream = httpRequest.GetRequestStream();

                    reqStream.Write(bytes, 0, bytes.Length);
                    reqStream.Flush();
                    Console.WriteLine(reqStream.ToString());

                try
                {
                    HttpWebResponse myResponse = (HttpWebResponse)httpRequest.GetResponse();
                    {
                        StreamReader sr = new StreamReader(myResponse.GetResponseStream(), Encoding.UTF8);
                        string responseString = sr.ReadToEnd();
                        sr.Close();
                        Console.WriteLine("Response: " + responseString);
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.StackTrace);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.StackTrace);
            }

            Console.WriteLine("continue.................");
            Console.ReadKey(true);

        }
    }
}
