using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using CSService;
using MySql.Data.MySqlClient;

namespace CSService
{
    /// <summary>
    /// Summary description for CSService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class CSService : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetPatientQRID(string strPID)
        {
            MySQLFunction mysqlobj = new MySQLFunction();
            string RTValue;
            RTValue = mysqlobj.QueryQrid(strPID);
            return RTValue;

        }
    }
}
