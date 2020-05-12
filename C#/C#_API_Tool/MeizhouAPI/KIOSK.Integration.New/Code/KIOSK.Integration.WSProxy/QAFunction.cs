using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace KIOSK.Integration.WSProxy
{
    public class MeiZhouQA
    {
        public string connectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectString"].ToString();
        public string strPatientLevel = System.Web.Configuration.WebConfigurationManager.AppSettings["PATIENT_LEVEL"].ToString();
        public string TerminalInfo;
        public string CardType;
        public string CardValue;

        //Parse the input xml data
        public void ParseInputXML(string xmlData)
        {
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.LoadXml(xmlData);
            XmlElement root = null;
            root = xmldoc.DocumentElement;

            TerminalInfo = root.SelectSingleNode("//TerminalInfo").InnerText.ToString();
            CardType = root.SelectSingleNode("//CardType").InnerText.ToString();
            CardValue = root.SelectSingleNode("//CardValue").InnerText.ToString();
        }

        public bool getPatientIDByCardInfo(string cardInfo, out string[] strArray)
        {

            DataSet ds = new DataSet();
            SqlDataAdapter adapter = new SqlDataAdapter();
            SqlConnection connection;
            SqlCommand command;
            string[] CheckInfo = cardInfo.Split(';');
            string strPid = CheckInfo[0];
            string strCardid = CheckInfo[1];
            string sql = "select distinct PatientID from wggc.dbo.vi_KIOSK_ExamInfo_Order  where PatientID = '" + strPid + "' and Optional3 = '" + strCardid + "'";
            connection = new SqlConnection(connectionString);
            connection.Open();
            command = new SqlCommand("SP_executesql", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@sql", sql);
            adapter.SelectCommand = command;
            adapter.Fill(ds, "PatientList");
            DataTable DT = ds.Tables["PatientList"];

            if (DT.Rows.Count > 0)
            {
                List<string> dataList = new List<string>();
                foreach (DataRow myrow in DT.Rows)
                {
                    dataList.Add(myrow["PatientID"].ToString());
                }

                strArray = dataList.ToArray();
                command.Dispose();
                connection.Close();
                connection.Dispose();
                ds.Dispose();
                adapter.Dispose();
                DT.Dispose();
                return true;
            }
            else
            {
                strArray = null;
                return false;
            }


        }

        public bool getACCNsByPatientID(string strPatientID,out string[] strArray)
        {

            DataSet ds = new DataSet();
            SqlDataAdapter adapter = new SqlDataAdapter();
            SqlConnection connection;
            SqlCommand command;
            string sql = "select AccessionNumber from wggc.dbo.vi_KIOSK_ExamInfo_Order  where PatientID = '" + strPatientID + "'";
            connection = new SqlConnection(connectionString);
            connection.Open();
            command = new SqlCommand("SP_executesql", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@sql", sql);
            adapter.SelectCommand = command;
            adapter.Fill(ds, "ACCNList");
            DataTable DT = ds.Tables["ACCNList"];

            if (DT.Rows.Count > 0)
            {
                List<string> dataList = new List<string>();
                foreach (DataRow myrow in DT.Rows)
                {
                    dataList.Add(myrow["AccessionNumber"].ToString());
                }

                strArray = dataList.ToArray();
                command.Dispose();
                connection.Close();
                connection.Dispose();
                ds.Dispose();
                adapter.Dispose();
                DT.Dispose();
                return true;
            }
            else 
            {
                strArray = null;
                return false;
            }


        }




        //init the xml with some element.
        public XmlDocument InitXML()
        {
            XmlDocument xmldoc = new XmlDocument();
            XmlDeclaration dec = xmldoc.CreateXmlDeclaration("1.0", "UTF-8", null);
            XmlElement root = xmldoc.CreateElement("PrintInfo");
            xmldoc.AppendChild(root);

            XmlElement ExamItems = xmldoc.CreateElement("ExamItems");
            root.AppendChild(ExamItems);

            XmlElement ExamItemsOfReg = xmldoc.CreateElement("ExamItemsOfReg");
            root.AppendChild(ExamItemsOfReg);


            return xmldoc;
        }


        //init the xml with some element.
        public void getExistPatientInfo(string Patientid, ref XmlDocument xmldoc)
        {

                DataSet ds = new DataSet();
                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlConnection connection;
                SqlCommand command;
                string sql = "select top 1 datediff(yy,Birthday,GETDATE()) as age,Birthday,Gender,NameCN,PatientType from wggc.dbo.vi_KIOSK_ExamInfo_Order where PatientID ='"+Patientid+"'";
                connection = new SqlConnection(connectionString);
                connection.Open();
                command = new SqlCommand("SP_executesql", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@sql", sql);
                adapter.SelectCommand = command;
                adapter.Fill(ds, "Patientinfo");
                DataTable DT = ds.Tables["Patientinfo"];

                XmlNode node = xmldoc.SelectSingleNode("PrintInfo");

                if (DT.Rows.Count > 0)
                {
                    XmlElement nodePrintStatus = xmldoc.CreateElement("PrintStatus");
                    nodePrintStatus.InnerText = "Ready";
                    node.AppendChild(nodePrintStatus);
                }
                else 
                {
                    XmlElement nodePrintStatus = xmldoc.CreateElement("PrintStatus");
                    nodePrintStatus.InnerText = "NotReady";
                    node.AppendChild(nodePrintStatus);
                }

                foreach (DataRow myrow in DT.Rows)
                {
                    string strPatientAge = myrow["age"].ToString();
                    string strBirthday = myrow["Birthday"].ToString();
                    string strGender = myrow["Gender"].ToString();
                    string strNameCN = myrow["NameCN"].ToString();
                    string strPatientType = myrow["PatientType"].ToString();

                    XmlElement NodePatientAge = xmldoc.CreateElement("Age");
                    NodePatientAge.InnerText = strPatientAge;
                    node.AppendChild(NodePatientAge);

                    XmlElement NodePatientBirthDay = xmldoc.CreateElement("BirthDate");
                    NodePatientBirthDay.InnerText = strBirthday;
                    node.AppendChild(NodePatientBirthDay);

                    XmlElement NodePatientGender = xmldoc.CreateElement("Gender");
                    NodePatientGender.InnerText = strGender;
                    node.AppendChild(NodePatientGender);

                    XmlElement NodePatientID = xmldoc.CreateElement("PatientID");
                    NodePatientID.InnerText = Patientid;
                    node.AppendChild(NodePatientID);

                    XmlElement NodePatientName = xmldoc.CreateElement("PatientName");
                    NodePatientName.InnerText = strNameCN;
                    node.AppendChild(NodePatientName);

                    XmlElement NodePrintState = xmldoc.CreateElement("PrintState");
                    NodePrintState.InnerText = "Ready";
                    node.AppendChild(NodePrintState);


                    XmlElement NodePatientType = xmldoc.CreateElement("PatientType");
                    NodePatientType.InnerText = strPatientType;
                    node.AppendChild(NodePatientType);

                    XmlElement NodeMessage = xmldoc.CreateElement("Message");
                    NodeMessage.InnerText = "您的报告已准备好，请稍等";
                    node.AppendChild(NodeMessage);

                    XmlElement NodePrintNumber = xmldoc.CreateElement("PrintNumber");
                    NodePrintNumber.InnerText = CardValue;
                    node.AppendChild(NodePrintNumber);


                    XmlElement NodePrintLevel = xmldoc.CreateElement("PrintLevel");
                    NodePrintLevel.InnerText = strPatientLevel;
                    node.AppendChild(NodePrintLevel);
                }
                command.Dispose();
                connection.Close();
                connection.Dispose();
                ds.Dispose();
                adapter.Dispose();
                DT.Dispose();
        }


        public void getNotExistPatientInfo(string Patientid,ref XmlDocument doc)
        {
            XmlNode node = doc.SelectSingleNode("PrintInfo");

            XmlElement nodePrintStatus = doc.CreateElement("PrintStatus");
            nodePrintStatus.InnerText = "InvalidId";
            node.AppendChild(nodePrintStatus);

            XmlElement NodePatientAge = doc.CreateElement("Age");
            node.AppendChild(NodePatientAge);

            XmlElement NodePatientBirthDay = doc.CreateElement("BirthDate");
            node.AppendChild(NodePatientBirthDay);

            XmlElement NodePatientGender = doc.CreateElement("Gender");
            node.AppendChild(NodePatientGender);

            XmlElement NodePatientID = doc.CreateElement("PatientID");
            node.AppendChild(NodePatientID);

            XmlElement NodePatientName = doc.CreateElement("PatientName");
            node.AppendChild(NodePatientName);

            XmlElement NodePrintState = doc.CreateElement("PrintState");
            NodePrintState.InnerText = "InvalidID";
            node.AppendChild(NodePrintState);

            XmlElement NodePatientType = doc.CreateElement("PatientType");
            node.AppendChild(NodePatientType);

            XmlElement NodeMessage = doc.CreateElement("Message");
            NodeMessage.InnerText = "您的卡号或身份证号不匹配";
            node.AppendChild(NodeMessage);

            XmlElement NodePrintNumber = doc.CreateElement("PrintNumber");
            NodePrintNumber.InnerText = CardValue;
            node.AppendChild(NodePrintNumber);

            XmlElement NodePrintLevel = doc.CreateElement("PrintLevel");
            NodePrintLevel.InnerText = strPatientLevel;
            node.AppendChild(NodePrintLevel);
        
        }

        public DataTable getExzamInfoFromIntegrationTableByACCN(string strAcessoinNumber)
        {
            SqlDataAdapter adapter = new SqlDataAdapter();
            SqlConnection connection;
            SqlCommand command;
            DataSet ds = new DataSet();
            string sql = "select StudyInstanceUID,PDFReportURL,AccessionNumber,ExamBodyPart,CreateDT,ExamName,ModalityName,Modality,Optional0,Optional1,Optional2,PatientType from wggc.dbo.vi_KIOSK_ExamInfo_Order where AccessionNumber = '" + strAcessoinNumber + "'";
            connection = new SqlConnection(connectionString);
            connection.Open();
            command = new SqlCommand("SP_executesql", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@sql", sql);
            adapter.SelectCommand = command;
            adapter.Fill(ds, "info");
            DataTable DT = ds.Tables["info"];

            command.Dispose();
            connection.Close();
            connection.Dispose();
            ds.Dispose();
            adapter.Dispose();
            DT.Dispose();

            return DT;
        }

        public DataTable getExamInfoFromPatientTable(string strAcessoinNumber, string Patientid, string strModalityType)
        {
            SqlDataAdapter adapter = new SqlDataAdapter();
            SqlConnection connection;
            SqlCommand command;
            DataSet ds2 = new DataSet();
            connection = new SqlConnection(connectionString);
            string sql = "select PrintStatus , ReferringDepartment from wggc.dbo.AFP_ReportInfo where AccessionNumber ='" + strAcessoinNumber + "' and PatientID='" + Patientid + "' and DeleteStatus =0 and ReportStatus =2 and ModalityType= '" + strModalityType + "' ";
            command = new SqlCommand("SP_executesql", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@sql", sql);
            adapter.SelectCommand = command;
            adapter.Fill(ds2, "reportinfo");
            DataTable DT2 = ds2.Tables["reportinfo"];

            command.Dispose();
            connection.Close();
            connection.Dispose();
            ds2.Dispose();
            adapter.Dispose();
            DT2.Dispose();
            return DT2;
        }

        public void writeExistExamInfoToXML(ref XmlDocument doc, string strAcessoinNumber , string strReportID, string strReportPath, string strExamBodyPart, string strCreateDT, string strExamName, string strModalityName, string strModalityType, string strColorType, string strPapaerSzie, string strPaperType, string strPrintStatus, string strReferringDepartment, string strPatientType)
        {
            XmlNode node = doc.SelectSingleNode("PrintInfo/ExamItems");
            XmlElement nodeExamInfo = doc.CreateElement("ExamInfo");
            node.AppendChild(nodeExamInfo);

            XmlElement nodeACCN = doc.CreateElement("AccessionNumber");
            nodeACCN.InnerText = strAcessoinNumber;
            nodeExamInfo.AppendChild(nodeACCN);

            XmlElement nodePatientType = doc.CreateElement("PatientType");
            nodePatientType.InnerText = strPatientType;
            nodeExamInfo.AppendChild(nodePatientType);

            XmlElement nodeStatusComments = doc.CreateElement("StatusComments");
            nodeACCN.InnerText = "";
            nodeExamInfo.AppendChild(nodeStatusComments);

            XmlElement nodeExamBodyPart = doc.CreateElement("ExamBodyPart");
            nodeExamBodyPart.InnerText = strExamBodyPart;
            nodeExamInfo.AppendChild(nodeExamBodyPart);

            XmlElement nodeExamDate = doc.CreateElement("ExamDate");
            nodeExamDate.InnerText = strCreateDT;
            nodeExamInfo.AppendChild(nodeExamDate);

            XmlElement nodeExamName = doc.CreateElement("ExamName");
            nodeExamName.InnerText = strExamName;
            nodeExamInfo.AppendChild(nodeExamName);

            XmlElement nodeModalityName = doc.CreateElement("ModalityName");
            nodeModalityName.InnerText = strModalityName;
            nodeExamInfo.AppendChild(nodeModalityName);

            XmlElement nodeModalityType = doc.CreateElement("ModalityType");
            nodeModalityType.InnerText = strModalityType;
            nodeExamInfo.AppendChild(nodeModalityType);

            XmlElement nodeReferringDepartment = doc.CreateElement("ReferringDepartment");
            nodeReferringDepartment.InnerText = strReferringDepartment;
            nodeExamInfo.AppendChild(nodeReferringDepartment);

            XmlElement nodeFilmInfos = doc.CreateElement("FilmInfos");
            nodeExamInfo.AppendChild(nodeFilmInfos);

            XmlElement nodeReportInfos = doc.CreateElement("ReportInfos");
            nodeExamInfo.AppendChild(nodeReportInfos);

            XmlElement nodeReportInfo = doc.CreateElement("ReportInfo");
            nodeReportInfos.AppendChild(nodeReportInfo);

            XmlElement nodeColorType = doc.CreateElement("ColorType");
            nodeColorType.InnerText = strColorType;
            nodeReportInfo.AppendChild(nodeColorType);

            XmlElement nodePapaerSzie = doc.CreateElement("PaperSize");
            nodePapaerSzie.InnerText = strPapaerSzie;
            nodeReportInfo.AppendChild(nodePapaerSzie);

            XmlElement nodePaperType = doc.CreateElement("PaperType");
            nodePaperType.InnerText = strPaperType;
            nodeReportInfo.AppendChild(nodePaperType);

            XmlElement nodeReportCount = doc.CreateElement("ReportCount");
            nodeReportCount.InnerText = "1";
            nodeReportInfo.AppendChild(nodeReportCount);

            XmlElement nodeReportID = doc.CreateElement("ReportID");
            nodeReportID.InnerText = strReportID;
            nodeReportInfo.AppendChild(nodeReportID);

            XmlElement nodeReportPath = doc.CreateElement("ReportPath");
            nodeReportPath.InnerText = strReportPath;
            nodeReportInfo.AppendChild(nodeReportPath);



            if (strPrintStatus.Equals("0"))
            {
                XmlElement nodestatus = doc.CreateElement("Status");
                nodestatus.InnerText = "Unprinted";
                nodeExamInfo.AppendChild(nodestatus);
            }

            if (strPrintStatus.Equals("1"))
            {
                XmlElement nodestatus = doc.CreateElement("Status");
                nodestatus.InnerText = "Printed";
                nodeExamInfo.AppendChild(nodestatus);
            }

            if (strPrintStatus.Equals("2"))
            {
                XmlElement nodestatus = doc.CreateElement("Status");
                nodestatus.InnerText = "DoNotPrinted";
                nodeExamInfo.AppendChild(nodestatus);
            }
        
        }


        public void writeNotExistExamInfoToXML(ref XmlDocument doc, string strAcessoinNumber, string strExamBodyPart, string strCreateDT, string strExamName, string strModalityName, string strModalityType, string strColorType, string strPapaerSzie, string strPaperType, string strPatientType)
        {
            XmlNode node = doc.SelectSingleNode("PrintInfo/ExamItemsOfReg");
            XmlElement nodeExamInfo = doc.CreateElement("ExamInfo");
            node.AppendChild(nodeExamInfo);

            XmlElement nodeACCN = doc.CreateElement("AccessionNumber");
            nodeACCN.InnerText = strAcessoinNumber;
            nodeExamInfo.AppendChild(nodeACCN);

            XmlElement nodePatientType = doc.CreateElement("PatientType");
            nodePatientType.InnerText = strPatientType;
            nodeExamInfo.AppendChild(nodePatientType);

            XmlElement nodeStatusComments = doc.CreateElement("StatusComments");
            nodeACCN.InnerText = "";
            nodeExamInfo.AppendChild(nodeStatusComments);

            XmlElement nodeExamBodyPart = doc.CreateElement("ExamBodyPart");
            nodeExamBodyPart.InnerText = strExamBodyPart;
            nodeExamInfo.AppendChild(nodeExamBodyPart);

            XmlElement nodeExamDate = doc.CreateElement("ExamDate");
            nodeExamDate.InnerText = strCreateDT;
            nodeExamInfo.AppendChild(nodeExamDate);

            XmlElement nodeExamName = doc.CreateElement("ExamName");
            nodeExamName.InnerText = strExamName;
            nodeExamInfo.AppendChild(nodeExamName);

            XmlElement nodeModalityName = doc.CreateElement("ModalityName");
            nodeModalityName.InnerText = strModalityName;
            nodeExamInfo.AppendChild(nodeModalityName);

            XmlElement nodeModalityType = doc.CreateElement("ModalityType");
            nodeModalityType.InnerText = strModalityType;
            nodeExamInfo.AppendChild(nodeModalityType);

            XmlElement nodeReferringDepartment = doc.CreateElement("ReferringDepartment");
            nodeReferringDepartment.InnerText = strModalityType;
            nodeExamInfo.AppendChild(nodeReferringDepartment);

            XmlElement nodeFilmInfos = doc.CreateElement("FilmInfos");
            nodeExamInfo.AppendChild(nodeFilmInfos);

            XmlElement nodeReportInfos = doc.CreateElement("ReportInfos");
            nodeExamInfo.AppendChild(nodeReportInfos);

            XmlElement nodeReportInfo = doc.CreateElement("ReportInfo");
            nodeReportInfos.AppendChild(nodeReportInfo);

            XmlElement nodeColorType = doc.CreateElement("ColorType");
            nodeColorType.InnerText = strColorType;
            nodeReportInfo.AppendChild(nodeColorType);

            XmlElement nodePapaerSzie = doc.CreateElement("PaperSize");
            nodePapaerSzie.InnerText = strPapaerSzie;
            nodeReportInfo.AppendChild(nodePapaerSzie);

            XmlElement nodePaperType = doc.CreateElement("PaperType");
            nodePaperType.InnerText = strPaperType;
            nodeReportInfo.AppendChild(nodePaperType);

            XmlElement nodeReportCount = doc.CreateElement("ReportCount");
            nodeReportCount.InnerText = "0";
            nodeReportInfo.AppendChild(nodeReportCount);

            XmlElement nodeReportID = doc.CreateElement("ReportID");
            nodeReportInfo.AppendChild(nodeReportID);

            XmlElement nodeReportPath = doc.CreateElement("ReportPath");
            nodeReportInfo.AppendChild(nodeReportPath);

            XmlElement nodestatus = doc.CreateElement("Status");
            nodestatus.InnerText = "Register";
            nodeExamInfo.AppendChild(nodestatus);
        
        }

    }
}