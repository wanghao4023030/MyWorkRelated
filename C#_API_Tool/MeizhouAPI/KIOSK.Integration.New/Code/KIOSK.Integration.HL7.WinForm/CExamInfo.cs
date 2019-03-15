using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace KIOSK.Integration.HL7.WinForm
{
    public class CExamInfo
    {
        public string strPatientID;
        public string strAccessionNumber;
        public string strStudyInstanceUID;
        public string strNameEN;
        public string strNameCN;
        public string strGender;
        public string strBirthday;
        public string strModality;
        public string strModalityName;
        public string strPatientType;
        public string strVisitID;
        public string strRequestID;
        public string strRequestDepartment;
        public string strRequestDT;
        public string strRegisterDT;
        public string strExamDT;
        public string strSubmitDT;
        public string strApproveDT;
        public string strPDFReportURL;
        public string strStudyStatus;

        public int iReportStatus;
        public int iPDFFlag;
        public int iVerifyFilmFlag;
        public int iVerifyReportFlag;
        public int iFilmStoredFlag;
        public int iReportStoredFlag;
        public int iNotifyReportFlag;
        public int iSetPrintModeFlag;
        public int iFilmPrintFlag;
        public string strFilmPrintDoctor;
        public int iReportPrintFlag;
        public string strReportPrintDoctor;

        public string strOutHospitalNo;
        public string strInHospitalNo;
        public string strPhysicalNo;
        public string strExamName;
        public string strExamBodyPart;
        public string strOptional0;
        public string strOptional1;
        public string strOptional2;
        public string strOptional3;
        public string strOptional4;
        public string strOptional5;
        public string strOptional6;
        public string strOptional7;
        public string strOptional8;
        public string strOptional9;

        public CExamInfo()
        {
            strPatientID = "";
            strAccessionNumber = "";
            strStudyInstanceUID = "";
            strNameEN = "";
            strNameCN = "";
            strGender = "";
            strBirthday = "";
            strModality = "";
            strModalityName = "";
            strPatientType = "";
            strVisitID = "";
            strRequestID = "";
            strRequestDepartment = "";
            strRequestDT = "";
            strRegisterDT = "";
            strExamDT = "";
            strSubmitDT = "";
            strApproveDT = "";
            strPDFReportURL = "";
            strStudyStatus = "";

            iReportStatus = -10;
            iPDFFlag = -10;
            iVerifyFilmFlag = -10;
            iVerifyReportFlag = -10;
            iFilmStoredFlag = -10;
            iReportStoredFlag = -10;
            iNotifyReportFlag = -10;
            iSetPrintModeFlag = -10;
            iFilmPrintFlag = -10;
            strFilmPrintDoctor = "";
            iReportPrintFlag = -10;
            strReportPrintDoctor = "";

            strOutHospitalNo = "";
            strInHospitalNo = "";
            strPhysicalNo = "";
            strExamName = "";
            strExamBodyPart = "";
            strOptional0 = "";
            strOptional1 = "";
            strOptional2 = "";
            strOptional3 = "";
            strOptional4 = "";
            strOptional5 = "";
            strOptional6 = "";
            strOptional7 = "";
            strOptional8 = "";
            strOptional9 = "";
        }

        public void ClearExamInfo()
        {
            strPatientID = "";
            strAccessionNumber = "";
            strStudyInstanceUID = "";
            strNameEN = "";
            strNameCN = "";
            strGender = "";
            strBirthday = "";
            strModality = "";
            strModalityName = "";
            strPatientType = "";
            strVisitID = "";
            strRequestID = "";
            strRequestDepartment = "";
            strRequestDT = "";
            strRegisterDT = "";
            strExamDT = "";
            strSubmitDT = "";
            strApproveDT = "";
            strPDFReportURL = "";
            strStudyStatus = "";

            iReportStatus = -10;
            iPDFFlag = -10;
            iVerifyFilmFlag = -10;
            iVerifyReportFlag = -10;
            iFilmStoredFlag = -10;
            iReportStoredFlag = -10;
            iNotifyReportFlag = -10;
            iSetPrintModeFlag = -10;
            iFilmPrintFlag = -10;
            strFilmPrintDoctor = "";
            iReportPrintFlag = -10;
            strReportPrintDoctor = "";

            strOutHospitalNo = "";
            strInHospitalNo = "";
            strPhysicalNo = "";
            strExamName = "";
            strExamBodyPart = "";
            strOptional0 = "";
            strOptional1 = "";
            strOptional2 = "";
            strOptional3 = "";
            strOptional4 = "";
            strOptional5 = "";
            strOptional6 = "";
            strOptional7 = "";
            strOptional8 = "";
            strOptional9 = "";
        }
    }
}
