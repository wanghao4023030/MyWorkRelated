using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data.SqlClient;
using System.Data;

namespace CSService
{
    public class MySQLFunction
    {
        private string connectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectString"].ToString();

        public string QueryQrid(string strPatientID)
        {
            //MySQLHelper MySqlObj = new MySQLHelper();
            MySqlConnection myconn = null;
            MySqlCommand mycom = null;
            myconn = new MySqlConnection(connectionString);

            try
            {
                myconn.Open();
                mycom = myconn.CreateCommand();
                mycom.CommandText = "select id FROM ecs.qrcodesceneinfo where patientid = '" + strPatientID + "'; ";

                MySqlDataAdapter adap = new MySqlDataAdapter(mycom);
                DataSet ds = new DataSet();
                adap.Fill(ds);
                myconn.Close();
                ds.Dispose();

                if (ds.Tables.Count != 1)
                {
                    return "error";
                }
                else
                {
                    return ds.Tables[0].Rows[0][0].ToString();
                }
            }
            catch (Exception ex)
            {
                return "error " + ex.ToString();
            }

        }

    }
}