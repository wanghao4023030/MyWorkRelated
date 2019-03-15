Action()
{

	//Init the variable for script
			int NumRows1;
			int NumRows2;
			char * tmp;
			/*Process the date and time to string*/	
			char *str;
			char *old=".";
			char *newchar="";
			char *dest;
			int result; 
			int ServiceResultFlag;
			int  SQLresult; 
			char  *tmpSQL; 

		str=lr_eval_string("{DateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"TreatmentID_new");


    	lr_db_connect("StepName=Connect", 
					"ConnectionString=Data Source=10.184.129.108\\GCPACSWS;Password=sa20021224$;User ID=sa;Initial Catalog=WGGC;", 
					"ConnectionName=ConnectGCPACS", 
					"ConnectionType=SQL", 
					LAST );

	   /*Use there two webservice to map two reports with one PID two ACC*/
	   //	web_reg_find("Text=<NotifyExamInfoResult>true</NotifyExamInfoResult>",LAST);
		web_reg_save_param("ServiceResult","LB=<NotifyExamInfoResult>","RB=</NotifyExamInfoResult>",LAST );

		lr_start_transaction("Create New Patient");

				/* Send the request for NotifyReportFile interface, please use GB2312 charset code*/
				web_custom_request("web_custom_request",
					"URL=http://10.184.129.108/NotifyServer/NotifyService.asmx",
					"Method=POST",
					"TargetFrame=",
					"Resource=0",
					"Referer=http://10.184.129.108/NotifyServer/NotifyService.asmx",
					"Mode=HTTP",
					"EncType=application/soap+xml;charset=GB2312;",
					"Body=<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:car=\"http://carestream.org/\">"
					"<soap:Header/>"
					"<soap:Body>"
					" <car:NotifyExamInfo>"
					"<car:exam>"
						"<car:CreateDT>{DateTime}</car:CreateDT>"
						"<car:UpdateDT>{DateTime}</car:UpdateDT>"
						"<car:PatientID>P{TreatmentID_new}</car:PatientID>"
						"<car:AccessionNumber>A{TreatmentID_new}</car:AccessionNumber>"
						"<car:StudyInstanceUID>INS{DateTime}</car:StudyInstanceUID>"
						"<car:NameCN>CN{TreatmentID_new}</car:NameCN>"
						"<car:NameEN>EN{TreatmentID_new}</car:NameEN>"
						"<car:Gender>{Grender}</car:Gender>"
						"<car:Birthday></car:Birthday>"
						"<car:Modality>{Modality}</car:Modality>"
					   " <car:ModalityName>{Modality}</car:ModalityName>"
						"<car:PatientType>3</car:PatientType>"
						"<car:VisitID></car:VisitID>"
						"<car:RequestID></car:RequestID>"
						"<car:RequestDepartment>{department}</car:RequestDepartment>"
						"<car:RequestDT>{DateTime}</car:RequestDT>"
						"<car:RegisterDT>{DateTime}</car:RegisterDT>"
					   " <car:ExamDT>{DateTime}</car:ExamDT>"
					   " <car:ReportDT>{DateTime}</car:ReportDT>"
					   " <car:SubmitDT>{DateTime}</car:SubmitDT>"
					   " <car:ApproveDT>{DateTime}</car:ApproveDT>"
					   " <car:PDFReportURL></car:PDFReportURL>"
					   " <car:StudyStatus></car:StudyStatus>"
					  " <car:OutHospitalNo></car:OutHospitalNo>"
					  "<car:InHospitalNo></car:InHospitalNo>"
						"<car:PhysicalNumber></car:PhysicalNumber>"
						"<car:ExamName>EN{TreatmentID_new}</car:ExamName>"
						"<car:ExamBodyPart>{BodayPart}</car:ExamBodyPart>"
						"<car:Optional0></car:Optional0>"
						"<car:Optional1></car:Optional1>"
						"<car:Optional2></car:Optional2>"
						"<car:Optional3></car:Optional3>"
						"<car:Optional4></car:Optional4>"
						"<car:Optional5></car:Optional5>"
						"<car:Optional6></car:Optional6>"
						"<car:Optional7></car:Optional7>"
						"<car:Optional8></car:Optional8>"
						"<car:Optional9></car:Optional9>"
					" </car:exam>"
					"</car:NotifyExamInfo>"
					"</soap:Body>"
					"</soap:Envelope>",
					LAST);


				ServiceResultFlag = strcmp(lr_eval_string("{ServiceResult}"),"true");

				if (ServiceResultFlag != 0){

					lr_fail_trans_with_error("Create patient exam failed by using NotifyExamInfo service, please reference the service is works well or not.");

				};

	lr_end_transaction("Create New Patient", LR_AUTO);
	

	
	web_service_call( "StepName=CreateFilmFile_105",
		"SOAPMethod=CreateFilmTestData|CreateFilmTestDataSoap|CreateFilmFile",
		"ResponseParam=response",
		"Service=CreateFilmTestData",
		"ExpectedResponse=SoapResult",
		"Snapshot=t1516949821.inf",
		BEGIN_ARGUMENTS,
		"strfilename=A{TreatmentID_new}",
		"strDate={strDate}",
		"strtime={strTime}",
		"strPID=P{TreatmentID_new}",
		"strStudyInstanceUID=StudyUID{TreatmentID_new}",
		"strSeriesInstanceUID=StudyUID{TreatmentID_new}",
		"strSOPInstanceID=SOP{TreatmentID_new}",
		"strAccNo=A{TreatmentID_new}",
		"strPatientName=PN{TreatmentID_new}",
		"strGrender={Grender}",
		"strModality={Modality}",
		"strBodayPart={BodayPart}",
		"strDestFolder=E:\\GX Platform\\Inbox",
		END_ARGUMENTS,
		BEGIN_RESULT,
		"CreateFilmFileResult=Param_CreateFilmFileResult",
		END_RESULT,
		LAST);

		lr_think_time(30);
		
	web_service_call( "StepName=QueryResult_101",
		"SOAPMethod=CreateFilmTestData|CreateFilmTestDataSoap|QueryResult",
		"ResponseParam=response",
		"Service=CreateFilmTestData",
		"ExpectedResponse=SoapResult",
		"Snapshot=t1516953883.inf",
		BEGIN_ARGUMENTS,
		"strACCN=A{TreatmentID_new}",
		END_ARGUMENTS,
		BEGIN_RESULT,
		"QueryResultResult=Param_QueryResultResult",
		END_RESULT,
		LAST);

	
	
	
	
	lr_db_disconnect("StepName=Disconnect",	"ConnectionName=ConnectGCPACS", LAST );
}



