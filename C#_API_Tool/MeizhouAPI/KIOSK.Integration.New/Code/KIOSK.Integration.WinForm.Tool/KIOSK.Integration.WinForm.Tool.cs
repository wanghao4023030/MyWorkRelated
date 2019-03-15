using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using DicomObjects;
using MySql.Data;
using MySql.Data.MySqlClient;

using KIOSK.Integration.Config;
using KIOSK.Integration.Log;
using KIOSK.Integration.Util;
using KIOSK.Integration.Util.DAO;

namespace KIOSK.Integration.WinForm.Tool
{
    public partial class frmToolMain : Form
    {
        private Function fun = null;

        private void InitializSQL()
        {
            try
            {
                if ("MYSQL" == cbDBType.Text)
                {
                    rtbSQL.Text = "SELECT * FROM vi_CSH_KIOSK_ExamInfo LIMIT 0,10";
                }
                else if ("ORACLE" == cbDBType.Text)
                {
                    rtbSQL.Text = "SELECT * FROM vi_CSH_KIOSK_ExamInfo WHERE ROWNUM <= 10";
                }
                else
                {
                    rtbSQL.Text = "SELECT TOP 10 * FROM vi_CSH_KIOSK_ExamInfo";
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        public frmToolMain()
        {
            InitializeComponent();

            try
            {
                if (null == fun)
                {
                    fun = new Function();
                }

                cbDBType.Text = fun.m_Config_WSProxy.M_RISDBType;
                tbDBServer.Text = fun.m_Config_WSProxy.M_RISDBServer;
                tbDBName.Text = fun.m_Config_WSProxy.M_RISDBName;
                tbUserName.Text = fun.m_Config_WSProxy.M_RISDBUserName;
                tbPassword.Text = fun.m_Config_WSProxy.M_RISDBPassword;

                tbCallingAE.Text = fun.m_Config_WSProxy.M_MWLCallingAE;
                tbCalledAE.Text = fun.m_Config_WSProxy.M_MWLCalledAE;
                tbNode.Text = fun.m_Config_WSProxy.M_MWLNode;
                tbPort.Text = fun.m_Config_WSProxy.M_MWLPort;

                InitializSQL();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private void btnQueryDB_Click(object sender, EventArgs e)
        {
            DataSet ds = null;
            try
            {
                ds = fun.ExcuteSQL(cbDBType.Text, tbDBServer.Text, tbDBName.Text, tbUserName.Text, tbPassword.Text, rtbSQL.Text);
                fun.DataSetToListView(lvDBExamInfo, ds);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
            finally
            {
                if (null != ds)
                {
                    ds.Dispose();
                    ds = null;
                }
            }
        }

        private void btnQueryMWL_Click(object sender, EventArgs e)
        {
            DicomQueryClass dcmQC = null;
            DicomDataSets dcmDSS = null;
            DicomDataSetClass dcmDSCResult = null;

            try
            {
                if (null == fun)
                {
                    fun = new Function();
                }

                if (null == dcmQC)
                {
                    dcmQC = new DicomQueryClass();
                }

                if (null == dcmDSCResult)
                {
                    dcmDSCResult = new DicomDataSetClass();
                }

                string strStudyDate = "";
                if (8 <= tbBeginDate.Text.Trim().Length) //yyyyMMdd
                {
                    strStudyDate = tbBeginDate.Text.Trim();

                    if (8 <= tbEndDate.Text.Trim().Length)
                    {
                        strStudyDate = strStudyDate + "-" + tbEndDate.Text.Trim();
                    }
                }

                string strStudyTime = "";
                if (5 <= tbBeginTime.Text.Trim().Length) //mm:HH:ss
                {
                    strStudyTime = tbBeginTime.Text.Trim();

                    if (5 <= tbEndTime.Text.Trim().Length)
                    {
                        strStudyTime = strStudyTime + "-" + tbEndTime.Text.Trim();
                    }
                }

                fun.InitializDicomDataSetClassForResult(dcmDSCResult,
                    tbPatientName.Text.Trim(),
                    tbPatientID.Text.Trim(),
                    tbAccessionNumber.Text.Trim(),
                    tbModality.Text.Trim(),
                    strStudyDate,
                    strStudyTime,
                    cbStudyStatusID.Text.Trim());

                dcmQC.CallingAE = tbCallingAE.Text.Trim();
                dcmQC.CalledAE = tbCalledAE.Text.Trim();
                dcmQC.Node = tbNode.Text.Trim();
                dcmQC.Port = Convert.ToInt32(tbPort.Text.Trim());
                dcmQC.Root = "WORKLIST";

                dcmDSS = dcmQC.DoRawQuery(dcmDSCResult);

                fun.DicomDataSetsToListView(lvWorkList, dcmDSS);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private void cbDBType_TextChanged(object sender, EventArgs e)
        {
            InitializSQL();
        }
    }
}
