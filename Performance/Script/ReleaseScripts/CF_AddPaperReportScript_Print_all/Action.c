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
			 int LoopNumber;
			 int i = 0;




			 result = strcmp(lr_eval_string( "{randNum}"),"1");

			 //Create the accessionnumber
			str=lr_eval_string("{DateTime}{ACCNRand}");
			lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"TreatmentID_new");
			//lr_message("%s", lr_eval_string( "{TreatmentID_new}"));

                tmpSQL = " select newid()  as UID";
				lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");	
		
				SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus", 
					"ConnectionName=ConnectGCPACS", 
					"SQLStatement={SQLECSQuery1}",
					"DatasetName=MyDataset", 
					LAST );

				/****************************************************************************/
				/***Create patient and send report*****/
				/****************************************************************************/
   if (SQLresult  ==1) {

                   lr_db_getvalue("StepName=QueryReportStatus", 
								  "DatasetName=MyDataset", 
								  "Column=UID", 
								  "Row=next", 
								  "OutParam=InstanceUID", 
								  LAST ); 

				   lr_output_message("The value is: %s", lr_eval_string("{InstanceUID}") ); 


				   /*Use there two webservice to map two reports with one PID two ACC*/
				   //	web_reg_find("Text=<NotifyExamInfoResult>true</NotifyExamInfoResult>",LAST);
				   web_reg_save_param("ServiceResult","LB=<NotifyExamInfoResult>","RB=</NotifyExamInfoResult>",LAST );

				   lr_start_transaction("Create New Patient");

				/* Send the request for NotifyReportFile interface, please use GB2312 charset code*/
				   web_custom_request("web_custom_request",
							"URL=http://10.184.129.248/NotifyServer/NotifyService.asmx",
							"Method=POST",
							"TargetFrame=",
							"Resource=0",
							"Referer=http://10.184.129.248/NotifyServer/NotifyService.asmx",
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
								"<car:StudyInstanceUID>{InstanceUID}</car:StudyInstanceUID>"
								"<car:NameCN>CN{TreatmentID_new}</car:NameCN>"
								"<car:NameEN>EN{TreatmentID_new}</car:NameEN>"
								"<car:Gender>{Grender}</car:Gender>"
								"<car:Birthday></car:Birthday>"
								"<car:Modality>{Modality}</car:Modality>"
							   " <car:ModalityName>{Modality}</car:ModalityName>"
								"<car:PatientType>3</car:PatientType>"
								"<car:VisitID></car:VisitID>"
								"<car:RequestID></car:RequestID>"
								"<car:RequestDepartment>2</car:RequestDepartment>"
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
								"<car:ExamBodyPart>÷‚≤ø</car:ExamBodyPart>"
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

					lr_error_message("Create patient exam failed by using NotifyExamInfo service, please reference the service is works well or not.");

					return 0;

				};

	lr_end_transaction("Create New Patient", LR_AUTO);

	lr_think_time(5);


		tmpSQL = " insert wggc.dbo.Patient ([PatientGUID],[PatientID],[PatientName],[LocalName],[PatientBirthDate],[PatientAge],[PatientSex],[Comments],[StudyCount],[SeriesCount],[ImageCount],[LatestStudyDateTime],[patientaddress],[contactinfo],[OperateServerAE],[OperateStatus],[vip],[PhoneticName],[PatientSize],[PatientWeight],[Neutered],[Breed],[Species],[Owner],[IdCard],[Phone],[Birthday],[MedicalCard],[HomeAddress])values (NewID(),'P{TreatmentID_new}','N{TreatmentID_new}','N{TreatmentID_new}','19760118','026','F','','1','1','1',REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(varchar,GETDATE(),121),':',''),'-',''),' ',''),'.',''),null,null,'',0,0,'',null,null,null,null,null,null,null,null,null,null,null)";
	lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

	SQLresult = lr_db_executeSQLStatement("StepName=InsertPatientInfo",
		"ConnectionName=ConnectGCPACS",
		"SQLStatement={SQLECSQuery1}",
		"DatasetName=MyDataset",
		LAST );



	if (ServiceResultFlag == 0) {


			if (result == 0)  {
			lr_start_transaction("Notify File 4M");

			/*Check the http request passed or not */
			/*Use there two webservice to map two reports with one PID two ACC*/
		  //	web_reg_find("Text=<NotifyReportFileResult>true</NotifyReportFileResult>",LAST);
			web_reg_save_param("ServiceResult",					   "LB=<NotifyReportFileResult>",					   "RB=</NotifyReportFileResult>",					   LAST );

			/* Send the request for NotifyReportFile interface, please use GB2312 charset code*/

			//Send a report with size is 4M
			web_custom_request("web_custom_request",
				"URL=http://10.184.129.248/NotifyServer/NotifyService.asmx",
				"Method=POST",
				"TargetFrame=",
				"Resource=0",
				"Referer=http://10.184.129.248/NotifyServer/NotifyService.asmx",
				"Mode=HTTP",
				"EncType=application/soap+xml;charset=GB2312;",
				"Body=<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:car=\"http://carestream.org/\">"
				"<soap:Header/>"
				"<soap:Body>"
				" <car:NotifyReportFile>"
				"<car:exam>"
					"<car:CreateDT>{DateTime}</car:CreateDT>"
					"<car:UpdateDT>{DateTime}</car:UpdateDT>"
					"<car:PatientID>P{TreatmentID_new}</car:PatientID>"
					"<car:AccessionNumber>A{TreatmentID_new}</car:AccessionNumber>"
					"<car:StudyInstanceUID>{InstanceUID}</car:StudyInstanceUID>"
					"<car:NameCN>CN{TreatmentID_new}</car:NameCN>"
					"<car:NameEN>EN{TreatmentID_new}</car:NameEN>"
					"<car:Gender>{Grender}</car:Gender>"
					"<car:Birthday></car:Birthday>"
					"<car:Modality>{Modality}</car:Modality>"
				   " <car:ModalityName>{Modality}</car:ModalityName>"
					"<car:PatientType>3</car:PatientType>"
					"<car:VisitID></car:VisitID>"
					"<car:RequestID></car:RequestID>"
					"<car:RequestDepartment></car:RequestDepartment>"
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
				 "<car:reportPath>E:\\Data2\\PerformanceTest{Reportfolder}\\Performance1.pdf</car:reportPath>"
				// "<car:reportPath>D:\\1.pdf</car:reportPath>"
				"<car:reportStatus>2</car:reportStatus>"
				"</car:NotifyReportFile>"
				"</soap:Body>"
				"</soap:Envelope>",
				LAST);

			ServiceResultFlag = strcmp(lr_eval_string("{ServiceResult}"),"true");

				if (ServiceResultFlag != 0){

					lr_error_message("Add patient reports failed by using NotifyReportFile service, please reference the service is works well or not. The accn is   A%s",lr_eval_string("{TreatmentID_new}"));
					return 0;

				};

			lr_end_transaction("Notify File 4M", LR_AUTO);

				};

			// Send a report with size is 100K
			if (result != 0)  {
			lr_start_transaction("Notify File 100k");

			/*Check the http request passed or not */
			/*Use there two webservice to map two reports with one PID two ACC*/
		//	web_reg_find("Text=<NotifyReportFileResult>true</NotifyReportFileResult>",LAST);
			web_reg_save_param("ServiceResult",	"LB=<NotifyReportFileResult>", "RB=</NotifyReportFileResult>",LAST );


			/* Send the request for NotifyReportFile interface, please use GB2312 charset code*/

			web_custom_request("web_custom_request",
				"URL=http://10.184.129.248/NotifyServer/NotifyService.asmx",
				"Method=POST",
				"TargetFrame=",
				"Resource=0",
				"Referer=http://10.184.129.248/NotifyServer/NotifyService.asmx",
				"Mode=HTTP",
				"EncType=application/soap+xml;charset=GB2312;",
				"Body=<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:car=\"http://carestream.org/\">"
				"<soap:Header/>"
				"<soap:Body>"
				" <car:NotifyReportFile>"
				"<car:exam>"
					"<car:CreateDT>{DateTime}</car:CreateDT>"
					"<car:UpdateDT>{DateTime}</car:UpdateDT>"
					"<car:PatientID>P{TreatmentID_new}</car:PatientID>"
					"<car:AccessionNumber>A{TreatmentID_new}</car:AccessionNumber>"
					"<car:StudyInstanceUID>{InstanceUID}</car:StudyInstanceUID>"
					"<car:NameCN>CN{TreatmentID_new}</car:NameCN>"
					"<car:NameEN>EN{TreatmentID_new}</car:NameEN>"
					"<car:Gender>{Grender}</car:Gender>"
					"<car:Birthday></car:Birthday>"
					"<car:Modality>{Modality}</car:Modality>"
				   " <car:ModalityName>{Modality}</car:ModalityName>"
					"<car:PatientType>3</car:PatientType>"
					"<car:VisitID></car:VisitID>"
					"<car:RequestID></car:RequestID>"
					"<car:RequestDepartment></car:RequestDepartment>"
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
				 "<car:reportPath>E:\\Data\\PerformanceTest{Reportfolder}\\Performance1.pdf</car:reportPath>"
			   "<car:reportStatus>2</car:reportStatus>"
				"</car:NotifyReportFile>"
				"</soap:Body>"
				"</soap:Envelope>",
				LAST);

			ServiceResultFlag = strcmp(lr_eval_string("{ServiceResult}"),"true");

			if (ServiceResultFlag != 0){

				lr_error_message("Add patient reports failed by using NotifyReportFile service, please reference the service is works well or not. The accn is   A%s",lr_eval_string("{TreatmentID_new}"));

				return 0;

				};

			lr_end_transaction("Notify File 100k", LR_AUTO);

			};

	};



};



	lr_think_time(30);

/*******************************************************************************************/
/********************Print the report *****************************************************/
/******************************************************************************************/

 // Get accession number select AccessionNumber from wggc.dbo.AFP_ReportInfo where CreatedTime > '2017-05-25 12:58:06.210' and PrintStatus =0 and ReportStatus =2 and DeleteStatus =0 
	web_set_max_html_param_len("809400");


//                 tmpSQL = " select AccessionNumber from wggc.dbo.AFP_ReportInfo where AccessionNumber ='A{TreatmentID_new}' and ReportStatus =2 and PrintStatus=0 and DeleteStatus = 0";
// 				lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");
//
// 				SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
// 					"ConnectionName=ConnectGCPACS",
// 					"SQLStatement={SQLECSQuery1}",
// 					"DatasetName=MyDataset",
// 					LAST );
//
//                lr_message("The result is %d",SQLresult);


// 				if (SQLresult!=1) {
// // 					                tmpSQL = " update  wggc.dbo.AFP_ReportInfo set  PrintStatus=0  where AccessionNumber ='A{TreatmentID_new}' and ReportStatus =2  and DeleteStatus = 0 ";
// // 									lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");
// //
// // 									SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
// // 										"ConnectionName=ConnectGCPACS",
// // 										"SQLStatement={SQLECSQuery1}",
// // 										"DatasetName=MyDataset",
// // 										LAST );
// //
// // 									lr_message("The result is %d",SQLresult);
//
// 				};
//
//

                tmpSQL = " select AccessionNumber from wggc.dbo.AFP_ReportInfo where AccessionNumber ='A{TreatmentID_new}' and ReportStatus =2 and PrintStatus=0 and DeleteStatus = 0";
				lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");	
		
				SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus", 
					"ConnectionName=ConnectGCPACS", 
					"SQLStatement={SQLECSQuery1}",
					"DatasetName=MyDataset", 
					LAST );

				if(SQLresult != 1){
                   lr_error_message("Query report records to print from databse failed: the accessionnumber is  %s the count is %d ",lr_eval_string("A{TreatmentID_new}"),SQLresult);
				   return 0;
				};

				
		
				/* The report status is OK~~~*/
			if (SQLresult ==1) {
			
			
					lr_start_transaction("Report Update report printer info");
				
					web_add_auto_header("content-type","application/json");
					web_custom_request("Update report printerInfo",
						"URL=http://10.184.129.248/EHDUS/upload/printer/report/info?tid={TerminalID}",
						"Method=POST",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body={\"TerminalID\":null,\"PrinterID\":\"Lower\",\"Name\":\"Lower\",\"Model\":\"HP LaserJet M403n\",\"ErrorCode\":null,\"Status\":0,\"Type\":0,\"Cyan\":{\"Name\":\"Cartridge\",\"Description\":\"\",\"Level\":0},\"Magenta\":{\"Name\":\"Cartridge\",\"Description\":\"\",\"Level\":0},\"Yellow\":{\"Name\":\"Cartridge\",\"Description\":\"\",\"Level\":0},\"Black\":{\"Name\":\"BLACK\",\"Description\":\"Black Cartridge HP CF228A\",\"Level\":71},\"Tray1\":{\"DisplayName\":null,\"Name\":\"Tray 1\",\"Status\":3,\"PaperType\":0,\"PaperSize\":0},\"Tray2\":{\"DisplayName\":null,\"Name\":\"Tray 2\",\"Status\":0,\"PaperType\":0,\"PaperSize\":0}}",
						LAST);

				lr_end_transaction("Report Update report printer info", LR_AUTO);
				
				lr_think_time(5);

				lr_start_transaction("Report Update report printer info");

					web_add_auto_header("content-type","application/json");
					web_custom_request("Update report printerInfo",
						"URL=http://10.184.129.248/EHDUS/upload/printer/report/info?tid={TerminalID}",
						"Method=POST",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body={\"TerminalID\":null,\"PrinterID\":\"Upper\",\"Name\":\"Upper\",\"Model\":\"HP LaserJet M403n\",\"ErrorCode\":null,\"Status\":0,\"Type\":1,\"Cyan\":{\"Name\":\"Cartridge\",\"Description\":\"\",\"Level\":0},\"Magenta\":{\"Name\":\"Cartridge\",\"Description\":\"\",\"Level\":0},\"Yellow\":{\"Name\":\"Cartridge\",\"Description\":\"\",\"Level\":0},\"Black\":{\"Name\":\"BLACK\",\"Description\":\"Black Cartridge HP CF228A\",\"Level\":94},\"Tray1\":{\"DisplayName\":null,\"Name\":\"Tray 1\",\"Status\":3,\"PaperType\":0,\"PaperSize\":1},\"Tray2\":{\"DisplayName\":null,\"Name\":\"Tray 2\",\"Status\":0,\"PaperType\":0,\"PaperSize\":0}}",
						LAST);
				
					lr_end_transaction("Report Update report printer info", LR_AUTO);
				
					lr_think_time(5);
				
				
				
					/*
					Query the status of Terminal status .
					*/
				
					lr_start_transaction("Report TerminalStatus");
				
					web_add_auto_header("content-type","application/json");
					web_custom_request("Terminal_status",
						"URL=http://10.184.129.248/EHDPS/status?tid={TerminalID}",
						"Method=GET",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body=",
						LAST);
				
				
					lr_end_transaction("Report TerminalStatus", LR_AUTO);
				
					lr_think_time(5);
				
				
						/*
						Query the status of Terminal status .
						If Do not find the terminal name output fail.
						*/
					lr_start_transaction("Report TerminalStatus");
				
					// web_reg_find("Text={TerminalID}",  LAST );
					 web_custom_request("Terminal_status",
						"URL=http://10.184.129.248/EHDPS/status?tid={TerminalID}",
						"Method=GET",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body=",
						LAST);
				
				
					lr_end_transaction("Report TerminalStatus", LR_AUTO);
				
				//	lr_think_time(5);
				
				
					/*
					Query the report and film information by accession number.
					*/
				
// 					web_reg_save_param("ReportPath",
// 									  "LB=ReportPath\"\:\"",
// 									  "RB=\"",
// 						LAST );


					LoopNumber=0;
					
					do 
					{
					lr_think_time(6);
					LoopNumber = LoopNumber + 1;
					
					web_reg_save_param("ReportPath",
									  "LB=ReportPath\"\:\"",
									  "RB=\"",
									  "Notfound=warning",
									  LAST );
				
					lr_start_transaction("Report QueryFilmReportInfo");

					web_add_auto_header("content-type","application/json");
        			web_custom_request("Item_query",
						"URL=http://10.184.129.248/EHDPS/printtask/items?Value=A{TreatmentID_new}&Type=0&tid={TerminalID}",
//						"URL=http://10.184.129.248/EHDPS/printtask/items?Value=ACCN&Type=0&tid={TerminalID}",
						"Method=GET",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body=",
						LAST);
					
					lr_end_transaction("Report QueryFilmReportInfo", LR_AUTO);
					
					if(stricmp(lr_eval_string("{ReportPath}") ,"") ==0)
					{
				
						lr_start_transaction("Report GetReportPath_fail");
							lr_error_message("Get ReportPath failed (Times: %d). The accession number is %s,%s",LoopNumber,lr_eval_string("A{TreatmentID_new}"),lr_eval_string("{TerminalID}"));
						lr_end_transaction("Report GetReportPath_fail", LR_AUTO);
					};
				
        			
					}while(stricmp(lr_eval_string("{ReportPath}") ,"") ==0 && LoopNumber < 10);
					
					if (LoopNumber == 10) {
						
						lr_error_message("Try to get the report path  failed:Accession: %s  Terminal:  %s",lr_eval_string("A{TreatmentID_new}"),lr_eval_string("{TerminalID}"));
						return 0;
					};
				
								
					LoopNumber = 0;
				
/*				
// 						web_reg_save_param("QueryFilmReportError",
// 									  "LB=Status",
// 									  "RB=]}}",
// 						LAST );
*/
					do 
					{
					lr_think_time(6);
					LoopNumber = LoopNumber + 1;
					
					web_reg_save_param("ReportID",
									  "LB=\"ReportID\"\:\"",
									  "RB=\"\,\"ReportPath",
									  "Notfound=warning",
						LAST );

					lr_start_transaction("Report QueryFilmReportInfo");
					
					web_add_auto_header("content-type","application/json");
					web_custom_request("Item_query",
						"URL=http://10.184.129.248/EHDPS/printtask/items?Value=A{TreatmentID_new}&Type=0&tid={TerminalID}",
//						"URL=http://10.184.129.248/EHDPS/printtask/items?Value=ACCN&Type=0&tid={TerminalID}",
						"Method=GET",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body=",
						LAST);
				
				
					lr_end_transaction("Report QueryFilmReportInfo", LR_AUTO);
					
					
					if(stricmp(lr_eval_string("{ReportID}") ,"") ==0)
					{
				
						lr_start_transaction("Report GetReportID_fail");
							lr_error_message("Get ReportPath failed (Times: %d). The accession number is %s,%s",LoopNumber,lr_eval_string("A{TreatmentID_new}"),lr_eval_string("{TerminalID}"));
						lr_end_transaction("Report GetReportID_fail", LR_AUTO);
					};
				
        			
					}while(stricmp(lr_eval_string("{ReportID}") ,"") ==0 && LoopNumber < 10);
					
					if (LoopNumber == 10) {
						
						lr_error_message("Try to get the report  ID failed:Accession: %s  Terminal:  %s",lr_eval_string("A{TreatmentID_new}"),lr_eval_string("{TerminalID}"));
						return 0;
					};
				
								
					LoopNumber = 0;
				

				if (stricmp(lr_eval_string("{ReportPath}") ,"") !=0 && stricmp(lr_eval_string("{ReportID}") ,"") !=0){
			

				/*
				Simulater to download the report file.
				*/
		/*
					lr_start_transaction("Report Download File");
				
						web_url("Download File",
										"URL={ReportPath}",
										"TargetFrame=",
										"Resource=0",
										"Referer=",
										"Mode=HTTP",
							LAST);
				
				
					lr_end_transaction("Report Download File", LR_AUTO);

			*/			
				//lr_think_time(5);
				
				
				
				/*
				Create Print task.
				*/
				
					lr_start_transaction("Report Create_PrintTask");
				
					   web_reg_save_param("TaskID",
									  "LB=\"TaskId\"\:\"",
									  "RB=\"",
						LAST );

	/*				   web_reg_save_param("Taskerror",
									  "LB=Code",
									  "RB=Status",
						LAST );

		*/		
					web_add_auto_header("content-type","application/json");
				
					web_custom_request("web_custom_request",
						"URL=http://10.184.129.248/EHDPS/printtask/create?tid={TerminalID}",
						"Method=POST",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body={\"CardInfo\"\:\{\"Value\"\:\"A{TreatmentID_new} \"\,\"Type\"\:0\}\,\"RequestId\"\:null\,\"RequestDate\"\:\"{CurrentDateTime}.7211992+08:00\"\}",
						LAST);
				
				
					lr_end_transaction("Report Create_PrintTask", LR_AUTO);
				
					lr_log_message("TaskID is : %s",lr_eval_string("{TaskID}"));
					//lr_log_message("Taskerror is : %s",lr_eval_string("{Taskerror}"));
				
					lr_think_time(5);

					
					
					/*Verify create the report print task suuceesfully or not */
					if(stricmp(lr_eval_string("{TaskID}") ,"") ==0){
				
						lr_start_transaction("Create Report PrintTask Fail");
				
							lr_error_message("The system create report print task fail!: %s  From Terminal: %s and accession number  is ",lr_eval_string("{TaskID}"),lr_eval_string("{TerminalID}"),lr_eval_string("A{TreatmentID_new}"));
				
						lr_end_transaction("Create Report PrintTask Fail",LR_AUTO);

						return 0;
					}
				
					/*If create the print task successfully than start the print task transaction.*/
				
					if (stricmp(lr_eval_string("{TaskID}") ,"")!=0) {

							/*
							Start Print works.
							*/

							lr_start_transaction("Report PrintTask");

							web_add_auto_header("content-type","application/json");

							web_custom_request("web_custom_request",
											"URL=http://10.184.129.248/EHDPS/printtask/print/{TaskID}?tid={TerminalID}",
											"Method=POST",
											"TargetFrame=",
											"Resource=0",
											"Referer=",
											"Mode=HTTP",
											"Body={\"RequestId\"\:null\,\"RequestDate\"\:\"{CurrentDateTime}.8769401+08:00\"}",
											LAST);


							lr_end_transaction("Report PrintTask", LR_AUTO);

							lr_think_time(5);

						//Update report status 0 unprinted or 1 printed.
						//


							lr_start_transaction("Report Update PrintTask");

							web_add_auto_header("content-type","application/json");

							web_custom_request("web_custom_request",
											"URL=http://10.184.129.248/EHDPS/printtask/report/{TaskID}/{ReportID}/1?tid={TerminalID}",
											"Method=POST",
											"TargetFrame=",
											"Resource=0",
											"Referer=",
											"Mode=HTTP",
											"Body={\"RequestId\"\:null\,\"RequestDate\"\:\"{CurrentDateTime}.8769401+08:00\"}",
											LAST);


							lr_end_transaction("Report Update PrintTask", LR_AUTO);

							/*
							Check the print task status
							*/

							LoopNumber = 0;

							do{

									lr_think_time(10);
									LoopNumber = LoopNumber + 1;


									lr_start_transaction("Report PrintTask Status Check");

									   web_reg_save_param("TaskStatus",
														  "LB=\,\"Status\"\:",
														  "RB=\,\"",
											LAST );

										web_add_auto_header("content-type","application/json");

										web_custom_request("web_custom_request",
											"URL=http://10.184.129.248/EHDPS/printtask/status/{TaskID}?tid={TerminalID}",
											"Method=GET",
											"TargetFrame=",
											"Resource=0",
											"Referer=",
											"Mode=HTTP",
											"Body=",
											LAST);

										lr_end_transaction("Report PrintTask Status Check", LR_AUTO);

										lr_output_message("PrintStatus-------,%s",lr_eval_string("{TaskStatus}"));
										result  = stricmp(lr_eval_string("{TaskStatus}") ,"4");
										lr_output_message("Compare Result-------,%d",result);

						}while(result !=0 && LoopNumber <=12);


						if(result ==0 ){
								lr_start_transaction("Report  Print Task Correct");
								lr_think_time(1);
								lr_end_transaction("Report  Print Task Correct",LR_AUTO);


// 								tmpSQL = " update  wggc.dbo.AFP_ReportInfo set  PrintStatus=0  where AccessionNumber ='A{TreatmentID_new}' and ReportStatus =2 and  DeleteStatus = 0 ";
// 								lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");
//
// 								SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
// 									"ConnectionName=ConnectGCPACS",
// 									"SQLStatement={SQLECSQuery1}",
// 									"DatasetName=MyDataset",
// 									LAST );

						}

							if (LoopNumber >12) {
								lr_start_transaction("Report  Print Task fail");

								lr_error_message("The report task print failed! taskID: %s  From Terminal: %s",lr_eval_string("{TaskID}"),lr_eval_string("{TerminalID}"));

								lr_end_transaction("Report  Print Task fail",LR_AUTO);

								return 0;


								//Reset report status

// 								tmpSQL = " update  wggc.dbo.AFP_ReportInfo set  PrintStatus=0  where AccessionNumber ='A{TreatmentID_new}' and ReportStatus =2  and DeleteStatus = 0 ";
// 								lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");
//
// 								SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
// 									"ConnectionName=ConnectGCPACS",
// 									"SQLStatement={SQLECSQuery1}",
// 									"DatasetName=MyDataset",
// 									LAST );

							};

							lr_output_message("Try Time-------,%d",LoopNumber);

					};
			
			};

	};





	return 0;

}
