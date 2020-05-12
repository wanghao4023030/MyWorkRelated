using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using log4net;

namespace CreatePatitent
{
    class PatitentClass
    {
        public string PatientID = null;
        public string AccessionNumber = null;
        public string DateWithMS = null;
        log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public string getPatientInfo()
        {
            try
            {
                string DT = GetDateWithMS();
                PatientID = "P" + DT;
                AccessionNumber = "A" + DT;
                DateWithMS = DT;
                log.Debug("Set patient information successfully. " + PatientID + " " + AccessionNumber);        
                return "true";
            }
            catch (Exception ex)
            {
                log.Debug("Set patient information failed. " ,ex);        
                return ex.ToString();
            }
        
        }
        private string GetDateWithMS()
        {
            log.Debug("GetDateWithMS type yyMMddHHmmssf: " + DateTime.Now.ToString("yyMMddHHmmssf"));
            return DateTime.Now.ToString("yyMMddHHmmssf"); 
        }
    }
}
