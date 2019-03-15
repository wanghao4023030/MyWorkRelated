D_Patient_Reservation_Query()
{
		/************************************************************************************************/
											//
		/************************************************************************************************/
	
	char *str;
	char *old=".";
	char *newchar="";
	char *dest;
	int LoopNumber;
	int i;
	char temp[200];
	int HTTP_RC;
	int HTTP_RES_SIZE;
	char *tmpSQL;	
	int ExecuteRand;
		
	
		 
//		  // You should be able to find the MySQL DLL somewhere in your MySQL install directory.
//		  rc = lr_load_dll ("libmysql.dll");
//		  if (rc != 0) {
//		    lr_error_message("Could not load libmysql.dll");
//		    //lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
//			return 0;
//
//		  }
		 

		web_set_max_html_param_len("10240");
		
		/******************************************************************************/
		/********Get currentdateTime with millisecond, make it to variable. ***********/
		/********The Patient examid, patientid and accession number can use it.********/
		/******************************************************************************/
	
		//Get current datetime with millisecond with LR parameter and Remove character "."
		str=lr_eval_string("{CurrentDateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"strCurrentDateTime");
		//lr_output_message("%s",lr_eval_string("{strCurrentDateTime}"));
		
		
		//Get random number and use it for "for loop"
		LoopNumber = atoi(lr_eval_string("{RandForLoop}"));
		//lr_output_message("%d",LoopNumber);
		
		//Get random number and use it for "Update reservation" transaction.
		ExecuteRand = atoi(lr_eval_string("{RandForExecute}"));
	
	//Begin loop to send request
		for(i = 1 ; i <= LoopNumber; i++)
		{
				lr_save_int(i, "EndNumber");
				
				//Set the reservation exam date is tomorrow. plus one day.			
				lr_save_datetime("%Y-%m-%dT%H:%M:%S", DATE_NOW + (ONE_DAY*1), "ExamReservationBegin");

				web_reg_save_param("HttpResultCreateExamReservation","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	LAST);
				
				lr_start_transaction("Reservation Create ExamReservation");
				
						web_custom_request("Create_ExamReservation",
						"URL=http://47.98.102.85/CenterInfoServer/CenterPrintService.asmx ",
						"Method=POST",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"EncType=text/xml; charset=utf-8",
						"Body=<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"><s:Body xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><SynchronizeInfo xmlns=\"http://tempuri.org/\">"
						"<table_name>ExamReservation</table_name><table_key>ExamID</table_key><table_value>E{strCurrentDateTime}{EndNumber}{HospitalID}</table_value>"
						"<json_input>{\"RowError\":\"\",\"RowState\":16,\"Table\":[{\"ExamID\":\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"StatusID\":0,\"RequestID\":\"R{strCurrentDateTime}{EndNumber}{HospitalID}\",\"SubsysType\":1,\"PatientID\":\"P{strCurrentDateTime}{HospitalID}\",\"PatientName\":\"N{strCurrentDateTime}{HospitalID}\",\"SubsysPatientID\":\"1\",\"ExamRoom\":\"Room{HospitalID}\",\"ExamName\":\"ExamName{strCurrentDateTime}{HospitalID}\",\"ModalityType\":\"{ExamModalityType}\",\"ModalityName\":\"{ExamModalityType}\",\"ActionID\":0,\"CreateDateTime\":\"{ExamCreateTime}\",\"ModifyDateTime\":null,\"CancelDateTime\":null,\"OldResExamDateTimeBegin\":null,\"OldResExamDateTimeEnd\":null,\"ResExamDateTimeBegin\":\"{ExamReservationBegin}\",\"ResExamDateTimeEnd\":null,\"HospitalID\":\"{HospitalID}\"}],\""
						"ItemArray\":[\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",0,\"0\",1,\"P{strCurrentDateTime}{HospitalID}\",\"N{strCurrentDateTime}{HospitalID}\",\"1\",\"Room{HospitalID}\",\"\",\"{ExamModalityType}\",\"{ExamModalityType}\",0,\"{ExamCreateTime}\",null,null,null,null,\"{ExamReservationBegin}\",null,\"{HospitalID}\"],\"HasErrors\":false}</json_input></SynchronizeInfo></s:Body></s:Envelope>",
						LAST);	
						

				
				lr_end_transaction("Reservation Create ExamReservation", LR_AUTO);
				
				// Get the http response status and check the value.
				HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);

				if(HTTP_RC !=200)
				{
					lr_fail_trans_with_error("PS Synchronize create Reservation failed. The http return code is %d", HTTP_RC);
		    		//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
					return 0;
				}
				
				//Get the http response result and check the final value.
				if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResultCreateExamReservation}"),"true") != 0)
				{
					lr_fail_trans_with_error("PS Synchronize Create Reservation failed. The http response content is not true!");
		    		//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
					return 0;					
				}
				
				lr_think_time(1);
			
		}
			
					//***************************************************************************************
					//Query the Film status
					//**************************************************************************************
			
//					web_reg_save_param("HttpResult","LB=<Content><![CDATA[","RB=]></Content>",	LAST);
//					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
//					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
					
					lr_start_transaction("Reservation QueryReservation");

					web_custom_request("web_QueryReservation",
						"URL=http://47.98.102.85/KioskWechatServer/WechatServer",
						"Method=POST",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body=<xml><ToUserName><![CDATA[gh_645a789c296d]]></ToUserName>"
						"<FromUserName><![CDATA[User{strCurrentDateTime}{HospitalID}{TimeStamp}]]></FromUserName>"
						"<CreateTime>{TimeStamp}</CreateTime>"
						"<MsgType><![CDATA[event]]></MsgType>"
						"<Event><![CDATA[CLICK]]></Event>"
						"<EventKey><![CDATA[BUTTON_QUERY_EXAMRESERVATION]]></EventKey>"
						"</xml>",
						LAST);
					
					lr_end_transaction("Reservation QueryReservation", LR_AUTO);
					
					// Get the http response status and check the value.
					HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
					
//					lr_output_message("Http request is: %s", lr_eval_string("{HttpResult}") );
//					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
//					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("PS Synchronizec create PaperReport failed. The http return code is %d", HTTP_RC);
		    			//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
						return 0;						
					}
					
//					//Get the http response result and check the final value.
//					if(HTTP_RC == 200 && strlen(lr_eval_string("{realMessage}")) > 0)
//					{
//						lr_fail_trans_with_error("PS Synchronize Create Paper report failed. The http response content is not true!");
//					}
					
					//****************************************************************//
					//Check the system has send the message to WeChat//
					//****************************************************************//
					
//					 // SELECT RECORD COUNT FROM NOTIFY MESSAGE TABLE.
//				  	tmpSQL = "SELECT COUNT(*) AS ROWCOUNT FROM ECS.notificationmessage WHERE NotifyType = 0 AND OpenID = 'User{strCurrentDateTime}{HospitalID}{TimeStamp}'";
//					lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery");
//					  
//					rc = mysql_query(db_connection, lr_eval_string("{SQLECSQuery}"));
//				 	if (rc != 0) {
//					    lr_error_message("%s", mysql_error(db_connection));
//					    mysql_close(db_connection);
//					    lr_fail_trans_with_error("Query data from database failed");
//					    //lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
//				 	 }
//			
//					query_result = mysql_store_result(db_connection);
//					lr_output_message("count is: %d", mysql_num_rows(query_result));
//					
//					result_row = (char **)mysql_fetch_row(query_result);
//					lr_save_string(result_row[0], "ROWCOUNT"); 
//					lr_output_message("ROWCOUNT is: %s", lr_eval_string("{ROWCOUNT}"));
//					
//					if(strcmp(lr_eval_string("{ROWCOUNT}"),"1") != 0)
//					{
//						lr_fail_trans_with_error("QueryReservation_failed.");
//		    			//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
//						return 0;						
//					}
//
					lr_think_time(1);
					
					
					
					
					//***************************************************************************************
					//Update the Film to printed status
					//***************************************************************************************
					
					//If the random number is 1, simualte the Resevervation update operation.
		if(ExecuteRand == 1)
		{
			for(i = 1 ; i <= LoopNumber; i++)
			{
					lr_save_int(i, "EndNumber");
					
					//Set the update date time to tomorrow and plus 6 hours.
					lr_save_datetime("%Y-%m-%dT%H:%M:%S", DATE_NOW + (ONE_DAY*1) + (ONE_HOUR*6), "ExamReservationBegin");
					
					web_reg_save_param("HttpResultUpdateExamReservation","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	LAST);
				
					lr_start_transaction("Reservation Update ExamReservation");
	
							web_custom_request("Update_ExamReservation",
							"URL=http://47.98.102.85/CenterInfoServer/CenterPrintService.asmx ",
							"Method=POST",
							"TargetFrame=",
							"Resource=0",
							"Referer=",
							"Mode=HTTP",
							"EncType=text/xml; charset=utf-8",
							"Body=<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"><s:Body xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><SynchronizeInfo xmlns=\"http://tempuri.org/\">"
							"<table_name>ExamReservation</table_name><table_key>ExamID</table_key><table_value>E{strCurrentDateTime}{EndNumber}{HospitalID}</table_value>"
							"<json_input>{\"RowError\":\"\",\"RowState\":16,\"Table\":[{\"ExamID\":\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"StatusID\":0,\"RequestID\":\"R{strCurrentDateTime}{EndNumber}{HospitalID}\",\"SubsysType\":1,\"PatientID\":\"P{strCurrentDateTime}{HospitalID}\",\"PatientName\":\"N{strCurrentDateTime}{HospitalID}\",\"SubsysPatientID\":\"1\",\"ExamRoom\":\"Room{HospitalID}\",\"ExamName\":\"ExamName{strCurrentDateTime}{HospitalID}\",\"ModalityType\":\"{ExamModalityType}\",\"ModalityName\":\"{ExamModalityType}\",\"ActionID\":1,\"CreateDateTime\":\"{ExamCreateTime}\",\"ModifyDateTime\":null,\"CancelDateTime\":null,\"OldResExamDateTimeBegin\":null,\"OldResExamDateTimeEnd\":null,\"ResExamDateTimeBegin\":\"{ExamReservationBegin}\",\"ResExamDateTimeEnd\":null,\"HospitalID\":\"{HospitalID}\"}],\""
							"ItemArray\":[\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",0,\"0\",1,\"P{strCurrentDateTime}{HospitalID}\",\"N{strCurrentDateTime}{HospitalID}\",\"1\",\"Room{HospitalID}\",\"\",\"{ExamModalityType}\",\"{ExamModalityType}\",1,\"{ExamCreateTime}\",null,null,null,null,\"{ExamReservationBegin}\",null,\"{HospitalID}\"],\"HasErrors\":false}</json_input></SynchronizeInfo></s:Body></s:Envelope>",
							LAST);	
					
					lr_end_transaction("Reservation Update ExamReservation", LR_AUTO);
							
							// Get the http response status and check the value.
							HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
			
							if(HTTP_RC !=200)
							{
								lr_fail_trans_with_error("PS Synchronize update Reservation failed. The http return code is %d", HTTP_RC);
								//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
								return 0;	
							}
							
							//Get the http response result and check the final value.
							if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResultUpdateExamReservation}"),"true") != 0)
							{
								lr_fail_trans_with_error("PS Synchronize Update Reservation failed. The http response content is not true!");
		    					//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
								return 0;									
							}
					
					

			}
	
					
					
					
//					web_reg_save_param("HttpResult","LB=<Content><![CDATA[","RB=]></Content>",	LAST);
//					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
//					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
					
					lr_start_transaction("Reservation QueryReservation");

					web_custom_request("web_QueryReportFilmStatus",
						"URL=http://47.98.102.85/KioskWechatServer/WechatServer",
						"Method=POST",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body=<xml><ToUserName><![CDATA[gh_645a789c296d]]></ToUserName>"
						"<FromUserName><![CDATA[User{strCurrentDateTime}{HospitalID}{TimeStamp}]]></FromUserName>"
						"<CreateTime>{TimeStamp}</CreateTime>"
						"<MsgType><![CDATA[event]]></MsgType>"
						"<Event><![CDATA[CLICK]]></Event>"
						"<EventKey><![CDATA[BUTTON_QUERY_EXAMRESERVATION]]></EventKey>"
						"</xml>",
						LAST);
					
					lr_end_transaction("Reservation QueryReservation", LR_AUTO);
					
					// Get the http response status and check the value.
					HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
					
//					lr_output_message("Http request is: %s", lr_eval_string("{HttpResult}") );
//					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
//					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("PS Synchronizec create PaperReport failed. The http return code is %d", HTTP_RC);
						//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
						return 0;	
					}
					
//					//Get the http response result and check the final value.
//					if(HTTP_RC == 200 && strlen(lr_eval_string("{realMessage}")) < 10)
//					{
//						lr_fail_trans_with_error("PS Synchronize Create Paper report failed. The http response content is not true!");
//					}
					
//					// SELECT RECORD COUNT FROM NOTIFY MESSAGE TABLE.
//				  	tmpSQL = "SELECT COUNT(*) AS ROWCOUNT FROM ECS.notificationmessage WHERE NotifyType = 0 AND OpenID = 'User{strCurrentDateTime}{HospitalID}{TimeStamp}'";
//					lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery");
//					  
//					rc = mysql_query(db_connection, lr_eval_string("{SQLECSQuery}"));
//				 	if (rc != 0) {
//					    lr_error_message("%s", mysql_error(db_connection));
//					    mysql_close(db_connection);
//					    lr_fail_trans_with_error("Query data from database failed");
//					    //lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
//						return 0;	
//				 	 }
//			
//					query_result = mysql_store_result(db_connection);
//					lr_output_message("count is: %d", mysql_num_rows(query_result));
//					
//					result_row = (char **)mysql_fetch_row(query_result);
//					lr_save_string(result_row[0], "ROWCOUNT"); 
//					lr_output_message("ROWCOUNT is: %s", lr_eval_string("{ROWCOUNT}"));
//					
//					if(strcmp(lr_eval_string("{ROWCOUNT}"),"2") != 0)
//					{
//						lr_fail_trans_with_error("QueryReservation_failed.");
//						//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
//						return 0;	
//					}

					lr_think_time(1);

  	}
		
   	  //mysql_free_result(query_result);		

	return 0;
}
