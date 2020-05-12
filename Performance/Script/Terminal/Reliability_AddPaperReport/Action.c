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

			 result = strcmp(lr_eval_string( "{randNum}"),"1");

			str=lr_eval_string("{DateTime}");
			lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"TreatmentID_new");
			//lr_message("%s", lr_eval_string( "{TreatmentID_new}"));



                tmpSQL = " select newid()  as UID";
				lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");	
		
				SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus", 
					"ConnectionName=ConnectGCPACS", 
					"SQLStatement={SQLECSQuery1}",
					"DatasetName=MyDataset", 
					LAST );

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

					lr_fail_trans_with_error("Create patient exam failed by using NotifyExamInfo service, please reference the service is works well or not.");

				};

	lr_end_transaction("Create New Patient", LR_AUTO);


	//lr_think_time(60);
	lr_think_time(10);


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
				//"<car:reportPath>E:\\1.pdf</car:reportPath>"
				// "<car:reportPath>D:\\1.pdf</car:reportPath>"
				"<car:reportStatus>2</car:reportStatus>"
				"</car:NotifyReportFile>"
				"</soap:Body>"
				"</soap:Envelope>",
				LAST);

			ServiceResultFlag = strcmp(lr_eval_string("{ServiceResult}"),"true");

				if (ServiceResultFlag != 0){

					lr_fail_trans_with_error("Add patient reports failed by using NotifyReportFile service, please reference the service is works well or not. The accn is   A%s",lr_eval_string("{TreatmentID_new}"));

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
				//			    "<car:reportPath>E:\\1.pdf</car:reportPath>"
			   "<car:reportStatus>2</car:reportStatus>"
				"</car:NotifyReportFile>"
				"</soap:Body>"
				"</soap:Envelope>",
				LAST);

			ServiceResultFlag = strcmp(lr_eval_string("{ServiceResult}"),"true");

			if (ServiceResultFlag != 0){

				lr_fail_trans_with_error("Add patient reports failed by using NotifyReportFile service, please reference the service is works well or not. The accn is   A%s",lr_eval_string("{TreatmentID_new}"));

				};

			lr_end_transaction("Notify File 100k", LR_AUTO);

			};

	};

 	lr_think_time(10);
	//lr_think_time(30);


// 					                tmpSQL = " update  wggc.dbo.AFP_ReportInfo set  PrintStatus=1  where AccessionNumber ='A{TreatmentID_new}'  ";
// 									lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");
//
// 									SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
// 										"ConnectionName=ConnectGCPACS",
// 										"SQLStatement={SQLECSQuery1}",
// 										"DatasetName=MyDataset",
// 										LAST );


	lr_think_time(5);

};

	return 0;

}
