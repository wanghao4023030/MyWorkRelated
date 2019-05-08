using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Excel = Microsoft.Office.Interop.Excel;
using System.Windows.Forms;
using System.Reflection;

namespace DefectExcelProcesTool
{
    class ExcelObject
    {
        public string filePath { get; set; }
        public bool exist { get; set; }
        

        private Excel.Application excelApp = new Excel.Application();
        object missing = Missing.Value;

        private Excel.Workbook wb = null;
        private Excel.Worksheet ws = null;
        


        public bool AppCheck()
        {

            if (excelApp == null)
            {
                return true;
            }
            else
                {   // if equal null means EXCEL is not installed.
                    MessageBox.Show("Excel is not properly installed!\n" +
                                    "Please install the execel and run again.");
                    return false;
                }
        }

        public void initExcel() 
        {
            wb = excelApp.Workbooks.Open(filePath, false, missing, missing, missing, missing, missing, missing, missing, missing, missing, missing, missing, missing, missing);
            excelApp.Visible = false;

            //得到WorkSheet对象
            ws = (Excel.Worksheet)wb.Worksheets.get_Item(1);

            string strA1 = ws.get_Range("A1", Type.Missing).Value;
             
            excelApp.Quit();//退出
            MessageBox.Show(strA1);
        }





    }

}
