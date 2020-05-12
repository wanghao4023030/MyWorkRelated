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


				/**************************************************************************************************************************/
				/***************************Try to print film*******************************************************************************/
				/**************************************************************************************************************************/
			//tmpSQL = " select AccessionNumber from  wggc.dbo.AFP_FilmInfo  where AccessionNumber='{ACCNum}' and DeleteStatus =0 and FilmFlag =0  and MinDensity is not null";
			tmpSQL = " select AccessionNumber from  wggc.dbo.AFP_FilmInfo  where AccessionNumber='{ACCNum}' and DeleteStatus =0 and FilmFlag =0 and MinDensity is not null";
			lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

			SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
				"ConnectionName=ConnectGCPACS",
				"SQLStatement={SQLECSQuery1}",
				"DatasetName=MyDataset",
				LAST );

		   lr_message("The result is %d",SQLresult);

		   	lr_think_time(5);

			if (SQLresult!=1) {
								//tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='{ACCNum}'  and DeleteStatus =0  and MinDensity is not null ";
								tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='{ACCNum}'  and DeleteStatus =0   ";
								lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

								SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
									"ConnectionName=ConnectGCPACS",
									"SQLStatement={SQLECSQuery1}",
									"DatasetName=MyDataset",
									LAST );

								lr_message("The result is %d",SQLresult);

								return 0;

			};


		lr_think_time(5);

			tmpSQL = " select AccessionNumber from  wggc.dbo.AFP_FilmInfo  where AccessionNumber='{ACCNum}' and DeleteStatus =0 and FilmFlag =0  and MinDensity is not null";
			lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

			SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
				"ConnectionName=ConnectGCPACS",
				"SQLStatement={SQLECSQuery1}",
				"DatasetName=MyDataset",
				LAST );

			if(SQLresult!=1){
			lr_fail_trans_with_error("The film print status is not correct and Update the status by databse failed: the accessionnumber is - %s",lr_eval_string("{ACCNum}"));
			return 0;
			};




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

				LoopNumber =0 ;

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
						"Body={\"CardInfo\"\:\{\"Value\"\:\"{ACCNum}\"\,\"Type\"\:0\}\,\"RequestId\"\:null\,\"RequestDate\"\:\"{CurrentTime}.7211992+08:00\"\}",
						LAST);
	
	
					lr_end_transaction("Film Create_PrintTask", LR_AUTO);
	
	// 				lr_output_message("TaskID is : %s",lr_eval_string("{TaskID}"));
	// 				lr_output_message("time is : %d",LoopNumber);
	
					if(stricmp(lr_eval_string("{TaskID}") ,"") ==0)
					{
						lr_start_transaction("Fim GetTaskID_fail");
							lr_output_message("Create print task failed. Try again. The accession number is %s,%s,%d",lr_eval_string("{ACCNum}"),lr_eval_string("{K2Terminal}"),LoopNumber );
						lr_end_transaction("Fim GetTaskID_fail",LR_AUTO);
					};

				}while(stricmp(lr_eval_string("{TaskID}") ,"") ==0 && LoopNumber < 10 );



				if (LoopNumber == 10) {
						lr_start_transaction("Film Create_PrintTask Fail");
							lr_error_message("Try to get the Print task ID failed: %s :  %s",lr_eval_string("{ACCNum}"),lr_eval_string("{K2Terminal}"));
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

						//lr_think_time(5);


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

							lr_think_time(5);

// 							tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='{ACCNum}'  and DeleteStatus =0  and MinDensity is not null ";
							tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='{ACCNum}'  and DeleteStatus =0  ";
							lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

							SQLresult = lr_db_executeSQLStatement("StepName=UpdateFilmToUnPrinted",
								"ConnectionName=ConnectGCPACS",
								"SQLStatement={SQLECSQuery1}",
								"DatasetName=MyDataset",
								LAST );

							if(SQLresult  == LR_FAIL)
							{
								lr_exit(LR_EXIT_ITERATION_AND_CONTINUE ,LR_FAIL  );
								lr_error_message("SQL statement update the film flag to 0 failed: %s",lr_eval_string("{ACCNum}"));
							};



						}

							/* If the loopNumber is more than 12 that means the print task time out and transaction is failed.*/
								if (LoopNumber >=30) {
									lr_start_transaction("Film PrintTask_Result_Fail");
											lr_error_message("The task do not finish correct: TaskID: %s  From Terminal: %s",lr_eval_string("{TaskID}"),lr_eval_string("{K2Terminal}"));
									lr_end_transaction("Film PrintTask_Result_Fail", LR_AUTO);

									lr_think_time(5);
									tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='{ACCNum}'  and DeleteStatus =0  and MinDensity is not null ";
									lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

									SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
										"ConnectionName=ConnectGCPACS",
										"SQLStatement={SQLECSQuery1}",
										"DatasetName=MyDataset",
										LAST );
								};




				};

				lr_think_time(5);

	return 0;








	
	

}



