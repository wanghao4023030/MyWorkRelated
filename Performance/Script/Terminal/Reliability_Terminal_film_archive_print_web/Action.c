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
    int LoopNumber;
    int i = 0;
	int HTTP_RC;


Action()
{

		web_set_max_html_param_len("10240");

		str=lr_eval_string("{DateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"TreatmentID_new");



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
	lr_end_transaction("Create New Patient", LR_AUTO);

	    ServiceResultFlag = strcmp(lr_eval_string("{ServiceResult}"),"true");
		if (ServiceResultFlag != 0){
						lr_fail_trans_with_error("Create patient exam failed by using NotifyExamInfo service, please reference the service is works well or not .  %s", lr_eval_string("{ServiceResult}"));
					   return 0;
				};
	
lr_think_time(60);

//*******************************************************************************************************************
// Create film data for PS to print.
//*******************************************************************************************************************

	web_reg_save_param("CreateFilmDataResult",		"LB=<CreateFilmFileResult>",		"RB=</CreateFilmFileResult>",		LAST);

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/PerformanceTest/CreateFilmTestData.asmx",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/PerformanceTest/CreateFilmTestData.asmx",
		"Mode=HTTP",
		"EncType= text/xml; charset=utf-8",
		"Body=<?xml version=\"1.0\" encoding=\"utf-8\"?>"
		"<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:wsa=\"http://schemas.xmlsoap.org/ws/2004/03/addressing\">"
		"<soap:Header><wsa:Action>http://tempuri.org/CreateFilmFile</wsa:Action>"
		"<wsa:MessageID>uuid:58f43ccc-2371-44c9-be86-2bbd97da6e17</wsa:MessageID>"
		"<wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/03/addressing/role/anonymous</wsa:Address></wsa:ReplyTo><wsa:To>http://10.184.129.108/PerformanceTest/CreateFilmTestData.asmx</wsa:To></soap:Header>"
		"<soap:Body><CreateFilmFile xmlns=\"http://tempuri.org/\">"
					   "<strfilename>A{TreatmentID_new}</strfilename>"
					   "<strDate>{strDate}</strDate>"
					   "<strtime>{strTime}</strtime>"
					   "<strPID>P{TreatmentID_new}</strPID>"
					   "<strStudyInstanceUID>StudyUID{TreatmentID_new}</strStudyInstanceUID>"
					   "<strSeriesInstanceUID>SeriesUID{TreatmentID_new}</strSeriesInstanceUID>"
					   "<strSOPInstanceID>SOP{TreatmentID_new}</strSOPInstanceID>"
					   "<strAccNo>A{TreatmentID_new}</strAccNo>"
					   "<strPatientName>PN{TreatmentID_new}</strPatientName>"
					   "<strGrender>{Grender}</strGrender>"
					   "<strModality>{Modality}</strModality>"
					   "<strBodayPart>{BodayPart}</strBodayPart>"
					   "<strDestFolder>E:\\GX Platform\\Inbox</strDestFolder>"
					   "</CreateFilmFile>"
		"</soap:Body></soap:Envelope>",
		LAST);

	HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);

	if(HTTP_RC !=200)
	{
		lr_error_message("Create film test data faile, it`s not an error. The http return %d",HTTP_RC);
		
		return 0;
	}


	ServiceResultFlag = strcmp(lr_eval_string("{CreateFilmDataResult}"),"true");

	if (ServiceResultFlag != 0)
	{
					lr_error_message("Create film test data faile, it`s not an error. The return value is not true.");

					return 0;
	};


	lr_think_time(15);

				/**************************************************************************************************************************/
				/***************************Try to print film*******************************************************************************/
				/**************************************************************************************************************************/
			//tmpSQL = " select AccessionNumber from  wggc.dbo.AFP_FilmInfo  where AccessionNumber='A{TreatmentID_new}' and DeleteStatus =0 and FilmFlag =0  and MinDensity is not null";
			tmpSQL = " select AccessionNumber from  wggc.dbo.AFP_FilmInfo  where AccessionNumber='A{TreatmentID_new}' and DeleteStatus =0 and FilmFlag =0 and MinDensity is not null";
			lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

			SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
				"ConnectionName=ConnectGCPACS",
				"SQLStatement={SQLECSQuery1}",
				"DatasetName=MyDataset",
				LAST );

		   lr_message("The result is %d",SQLresult);


			if (SQLresult!=1) {
// 								//tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='A{TreatmentID_new}'  and DeleteStatus =0  and MinDensity is not null ";
// 								tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='A{TreatmentID_new}'  and DeleteStatus =0   ";
// 								lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");
//
// 								SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
// 									"ConnectionName=ConnectGCPACS",
// 									"SQLStatement={SQLECSQuery1}",
// 									"DatasetName=MyDataset",
// 									LAST );
//
// 								lr_message("The result is %d",SQLresult);

								return 0;

			};


//			lr_think_time(10);
//
// 			tmpSQL = " select AccessionNumber from  wggc.dbo.AFP_FilmInfo  where AccessionNumber='A{TreatmentID_new}' and DeleteStatus =0 and FilmFlag =0  and MinDensity is not null";
// 			lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");
//
// 			SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
// 				"ConnectionName=ConnectGCPACS",
// 				"SQLStatement={SQLECSQuery1}",
// 				"DatasetName=MyDataset",
// 				LAST );
//
// 			if(SQLresult!=1){
// 			lr_fail_trans_with_error("The film print status is not correct and Update the status by databse failed: the accessionnumber is - %s",lr_eval_string("A{TreatmentID_new}"));
// 			return 0;
// 			};




				/*Check the Film Terminal  status */
				lr_start_transaction("Film TerminalStatus");

					web_add_auto_header("content-type","application/json");
					web_custom_request("web_custom_request",
						"URL=http://10.184.129.108/EHDPS/status?tid={K2Terminal}",
						"Method=GET",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body=",
						LAST);

				lr_end_transaction("Film TerminalStatus", LR_AUTO);


				lr_think_time(5);


				/*Create the film print task*/

				do
				{
				lr_think_time(5);
				LoopNumber = LoopNumber + 1;

				web_reg_save_param("TaskID",
								  "LB=\"TaskId\"\:\"",
								  "RB=\"",
								  "Notfound=warning",
								  LAST );

				lr_start_transaction("Film Create_PrintTask");

				web_add_auto_header("content-type","application/json");

				web_custom_request("web_custom_request",
					"URL=http://10.184.129.108/EHDPS/printtask/create?tid={K2Terminal}",
					"Method=POST",
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					"Mode=HTTP",
					"Body={\"CardInfo\"\:\{\"Value\"\:\"A{TreatmentID_new}\"\,\"Type\"\:0\}\,\"RequestId\"\:null\,\"RequestDate\"\:\"{CurrentTime}.7211992+08:00\"\}",
					LAST);


				lr_end_transaction("Film Create_PrintTask", LR_AUTO);

// 				lr_output_message("TaskID is : %s",lr_eval_string("{TaskID}"));
// 				lr_output_message("time is : %d",LoopNumber);

				if(stricmp(lr_eval_string("{TaskID}") ,"") ==0)
				{
					lr_start_transaction("Fim GetTaskID_fail");
						lr_error_message("Create print task failed. Try again. The accession number is %s,%s",lr_eval_string("A{TreatmentID_new}"),lr_eval_string("{K2Terminal}"));
					lr_end_transaction("Fim GetTaskID_fail",LR_AUTO);
				};

				}while(stricmp(lr_eval_string("{TaskID}") ,"") ==0 && LoopNumber < 10 );



				if (LoopNumber == 10) {
						lr_start_transaction("Film Create_PrintTask Fail");
							lr_error_message("Try to get the Print task ID failed: %s :  %s",lr_eval_string("A{TreatmentID_new}"),lr_eval_string("{K2Terminal}"));
						lr_end_transaction("Film Create_PrintTask Fail",LR_AUTO);
						return 0;
				};

				LoopNumber = 0;

				if (stricmp(lr_eval_string("{TaskID}") ,"") !=0) {


						/* Start the print task*/
						lr_start_transaction("Film PrintTask");

						web_add_auto_header("content-type","application/json");

						web_custom_request("web_custom_request",
										"URL=http://10.184.129.108/EHDPS/printtask/print/{TaskID}?tid={K2Terminal}",
										"Method=POST",
										"TargetFrame=",
										"Resource=0",
										"Referer=",
										"Mode=HTTP",
										"Body={\"RequestId\"\:null\,\"RequestDate\"\:\"{CurrentTime}.8769401+08:00\"}",
										LAST);


						lr_end_transaction("Film PrintTask", LR_AUTO);

						lr_think_time(5);


						/*Check the status in print task table, wait the task print successfully or time out.*/

						LoopNumber = 0;

						do{
								lr_think_time(10);
								LoopNumber = LoopNumber + 1;
								   web_reg_save_param("TaskStatus",
													  "LB=\,\"Status\"\:",
													  "RB=\,\"",
										LAST );

						lr_start_transaction("Film_PrintStatus_CheckService");

									web_add_auto_header("content-type","application/json");
									web_custom_request("web_custom_request",
										"URL=http://10.184.129.108/EHDPS/printtask/status/{TaskID}?tid={K2Terminal}",
										"Method=GET",
										"TargetFrame=",
										"Resource=0",
										"Referer=",
										"Mode=HTTP",
										"Body=",
										LAST);

						lr_end_transaction("Film_PrintStatus_CheckService", LR_AUTO);

						lr_output_message("PrintStatus in DataBase-------,%s",lr_eval_string("{TaskStatus}"));
									result  = stricmp(lr_eval_string("{TaskStatus}") ,"4");
						lr_output_message("PrintStatus Check result-------,%d",result);

						}while(result !=0 && LoopNumber <30);

						lr_output_message("PrintStatus-------,%d",LoopNumber);

						/*If the resilt is 0 that means the tasks print successfully.*/
						if (result==0) {
							lr_start_transaction("Film PrintTask_Result_Correct");
							lr_think_time(1);
							lr_end_transaction("Film PrintTask_Result_Correct", LR_AUTO);

// 							tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='A{TreatmentID_new}'  and DeleteStatus =0  and MinDensity is not null ";
// 							lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");
//
// 							SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
// 								"ConnectionName=ConnectGCPACS",
// 								"SQLStatement={SQLECSQuery1}",
// 								"DatasetName=MyDataset",
// 								LAST );


						}

							/* If the loopNumber is more than 12 that means the print task time out and transaction is failed.*/
								if (LoopNumber >=30) {
									lr_start_transaction("Film PrintTask_Result_Fail");
											lr_error_message("The task do not finish correct: TaskID: %s  From Terminal: %s",lr_eval_string("{TaskID}"),lr_eval_string("{K2Terminal}"));
									lr_end_transaction("Film PrintTask_Result_Fail", LR_AUTO);


// 									tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='A{TreatmentID_new}'  and DeleteStatus =0  and MinDensity is not null ";
// 									lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");
//
// 									SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
// 										"ConnectionName=ConnectGCPACS",
// 										"SQLStatement={SQLECSQuery1}",
// 										"DatasetName=MyDataset",
// 										LAST );
								};




				};

				lr_think_time(5);

	return 0;








	
	

}



