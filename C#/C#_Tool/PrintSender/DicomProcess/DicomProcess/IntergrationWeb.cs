using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.IO;
using System.Configuration;

namespace IntergrationWeb
{
    class IntergrationWebClass
    {

        private string[] Modality = { "CT", "CR", "MR", "DX", "IO", "KO", "MG", "NM", "OT", "PT", "RF", "US", "XA" };
        private string[] Sex = { "男", "女" };
        private string[] ExamBodyPart = { "肘部", "头部", "手部", "腿部", "背部" };
        private string PatientType = "急诊病人";
        private string HttpIP = ConfigurationManager.AppSettings["PrinterIP"];
        log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public string request_CreatePatient(string DTString)
        {

            string Datetime = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss.fff");
            string InstanceUID = Guid.NewGuid().ToString();
            Random ran = new Random();
            int n = ran.Next(Modality.Length);
            int i = ran.Next(Sex.Length);
            int j = ran.Next(ExamBodyPart.Length);

            try 
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://" + HttpIP + "/NotifyServer/NotifyService.asmx");
                request.Method = "POST";
                //request.ContentType = "application/soap+xml;charset=GB2312";
                request.ContentType = "application/soap+xml;charset=UTP-8";
                string postData = "<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:car=\"http://carestream.org/\">" +
                        "<soap:Header/>" +
                        "<soap:Body>" +
                        " <car:NotifyExamInfo>" +
                        "<car:exam>" +
                            "<car:CreateDT>" + Datetime + "</car:CreateDT>" +
                            "<car:UpdateDT>" + Datetime + "</car:UpdateDT>" +
                            "<car:PatientID>P" + DTString + "</car:PatientID>" +
                            "<car:AccessionNumber>A" + DTString + "</car:AccessionNumber>" +
                            "<car:StudyInstanceUID>" + InstanceUID + "</car:StudyInstanceUID>" +
                            "<car:NameCN>CN" + DTString + "</car:NameCN>" +
                            "<car:NameEN>EN" + DTString + "</car:NameEN>" +
                            "<car:Gender>" + Sex[i] + "</car:Gender>" +
                            "<car:Birthday></car:Birthday>" +
                            "<car:Modality>" + Modality[n] + "</car:Modality>" +
                           " <car:ModalityName>" + Modality[n] + "</car:ModalityName>" +
                            "<car:PatientType>" + PatientType + "</car:PatientType>" +
                            "<car:VisitID></car:VisitID>" +
                            "<car:RequestID></car:RequestID>" +
                            "<car:RequestDepartment>1</car:RequestDepartment>" +
                            "<car:RequestDT>" + Datetime + "</car:RequestDT>" +
                            "<car:RegisterDT>" + Datetime + "</car:RegisterDT>" +
                           " <car:ExamDT>" + Datetime + "</car:ExamDT>" +
                           " <car:ReportDT>" + Datetime + "</car:ReportDT>" +
                           " <car:SubmitDT>" + Datetime + "</car:SubmitDT>" +
                           " <car:ApproveDT>" + Datetime + "</car:ApproveDT>" +
                           " <car:PDFReportURL></car:PDFReportURL>" +
                           " <car:StudyStatus></car:StudyStatus>" +
                          " <car:OutHospitalNo></car:OutHospitalNo>" +
                          "<car:InHospitalNo></car:InHospitalNo>" +
                            "<car:PhysicalNumber></car:PhysicalNumber>" +
                            "<car:ExamName>EN" + DTString + "</car:ExamName>" +
                            "<car:ExamBodyPart>" + ExamBodyPart[j] + "</car:ExamBodyPart>" +
                            "<car:Optional0></car:Optional0>" +
                            "<car:Optional1></car:Optional1>" +
                            "<car:Optional2></car:Optional2>" +
                            "<car:Optional3></car:Optional3>" +
                            "<car:Optional4></car:Optional4>" +
                            "<car:Optional5></car:Optional5>" +
                            "<car:Optional6></car:Optional6>" +
                            "<car:Optional7></car:Optional7>" +
                            "<car:Optional8></car:Optional8>" +
                            "<car:Optional9></car:Optional9>" +
                        " </car:exam>" +
                        "</car:NotifyExamInfo>" +
                        "</soap:Body>" +
                        "</soap:Envelope>";

                byte[] bytes = Encoding.UTF8.GetBytes(postData);
                request.ContentLength = bytes.Length;

                Stream requestStream = request.GetRequestStream();
                requestStream.Write(bytes, 0, bytes.Length);

                WebResponse response = request.GetResponse();
                Stream stream = response.GetResponseStream();
                StreamReader reader = new StreamReader(stream);

                var result = reader.ReadToEnd();
                stream.Dispose();
                reader.Dispose();

                if (result.Contains("<NotifyExamInfoResult>true</NotifyExamInfoResult>"))
                {
                    log.Debug("Send request to service NotifyExamInfo and return true.");
                    return "true";
                }
                else 
                {
                    log.Error("Send request to service NotifyExamInfo and return false\n" + "request: " + postData +"\n" + result);
                    return "false";
                };

                
            }
            catch(Exception ex)
            {
                log.Error("Send request to service NotifyExamInfo crash." ,ex);
                return ex.ToString();
            }

        }
    }
}
