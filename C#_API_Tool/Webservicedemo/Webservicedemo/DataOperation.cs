using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;

namespace namespace_DataOperation
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    //[WebService(Namespace = "http://tempuri.org/")]
    //[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    //[System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class DataOperation 
    {

        private string connectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectString"].ToString();
        public int result;


        public bool CheckDistinctResultFromTableByACCN(string strAccn){
            SqlConnection connection;
            SqlCommand command;
            string sql = "select count(*)  from wggc.dbo.afp_filminfo where accessionnumber = '" + strAccn + "' and filmflag = 0 ";
            connection = new SqlConnection(connectionString);


                connection.Open();
                command = new SqlCommand("SP_executesql", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@sql",sql);
                result = (int)command.ExecuteScalar();
                command.Dispose();
                connection.Close();
                if (result.Equals(1))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            
            
        }


    }
}
