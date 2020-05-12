using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Runtime.Serialization;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using log4net;
using System.Configuration;

namespace PSwebserviceAPI
{
    

    /// <summary>
    /// Summary description for SyncToOtherSystem
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class SyncToOtherSystem : System.Web.Services.WebService
    {
        log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        //public KioskAuthHeader Authentication = new KioskAuthHeader();
        //[SoapHeader("Authentication")]
        
        [WebMethod (Description= "SynchronizeInfo")]
        public Boolean SynchronizeInfo(string table_name, string table_key,string table_value, string json_input)
        {
            //if (AuthCheck())
            //{
            //    string SynchronizeInfoResult = string.Format("table_name: {0}\n table_key: {1}\n table_value: {2}\n Json: {3}",
            //                                                  table_name ,table_key ,table_value ,json_input);

            //    log.Info(SynchronizeInfoResult);
            //    return true;
            //}
            //else
            //{
            //    string SynchronizeInfoResult = "auth failed";
            //    log.Info(SynchronizeInfoResult);
            //    return false;
            //}

            try
            {
                string SynchronizeInfoResult = string.Format("table_name: {0}\n table_key: {1}\n table_value: {2}\n Json: {3}",
                                                              table_name, table_key, table_value, json_input);

                log.Info(SynchronizeInfoResult);
                return true;
            }
            catch(Exception ex)
            {
                
                log.Info(ex.ToString());
                return false;
            }


        }

        public string pharseJson(string json_input )
        {

            string SynchronizeInfoResult = json_input;
            JObject ja = (JObject)JsonConvert.DeserializeObject(json_input);
            string RowError = ja["RowError"].ToString();
            string RowState = ja["RowState"].ToString();
            string Table = ja["Table"].ToString();
            string ItemArray = ja["ItemArray"].ToString();
            string HasErrors = ja["HasErrors"].ToString();

            JObject JoTable = (JObject)JsonConvert.DeserializeObject(Table.Replace("[", "").Replace("]", "").Replace("\r\n", "").ToString());
            string JoTable_Examid = JoTable["ExamID"].ToString();

            log.Info(JoTable_Examid);
            return JoTable_Examid;
        }




        /*Define the soap header*/
        /*check the user and password*/
        public class KioskAuthHeader : SoapHeader
        {
            public string UserId = string.Empty;
            public string UserPW = string.Empty;
        }

        public string UserID
        { 
        get {return UserID;}
        set { UserID = value; }

        }

        public string UserPW
        {
            get { return UserPW; }
            set { UserPW = value; }

        }

        //Check function

        //public bool AuthCheck()
        //{
        //    string User_ID = ConfigurationManager.AppSettings["Userid"];
        //    string User_PWD = ConfigurationManager.AppSettings["userPWD"];

        //    if (Authentication.UserId.Equals(User_ID.ToString()) && Authentication.UserPW.Equals(User_PWD.ToString()))
        //    {
        //        return true;
        //    }
        //    else
        //    {
        //        return false;
        //    }
        //}



    }
}
