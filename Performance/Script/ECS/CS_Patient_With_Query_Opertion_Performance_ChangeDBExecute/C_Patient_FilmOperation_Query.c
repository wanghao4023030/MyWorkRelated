//C_Patient_FilmOperation_Query()
//{
//		/************************************************************************************************/
//											//
//		/************************************************************************************************/
//	
//	char *str;
//	char *old=".";
//	char *newchar="";
//	char *dest;
//	int LoopNumber;
//	int i;
//	char temp[200];
//	int HTTP_RC;
//	int HTTP_RES_SIZE;
//	char *tmpSQL;	
//	int ExecuteRand;
//		
//	
//		web_set_max_html_param_len("10240");
//		
//		/******************************************************************************/
//		/********Get currentdateTime with millisecond, make it to variable. ***********/
//		/********The Patient examid, patientid and accession number can use it.********/
//		/******************************************************************************/
//	
//		//Get current datetime with millisecond with LR parameter and Remove character "."
//		str=lr_eval_string("{CurrentDateTime}");
//		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"strCurrentDateTime");
//		//lr_output_message("%s",lr_eval_string("{strCurrentDateTime}"));
//		
//		
//		//Get random number and use it for "for loop"
//		LoopNumber = atoi(lr_eval_string("{RandForLoop}"));
//		//lr_output_message("%d",LoopNumber);
//		
//	
//		//Set the message varchar and convert it to UTF-8 type
//		lr_convert_string_encoding("您胶片已经准备好，但是报告尚未审核。请到自助终端打印！",LR_ENC_SYSTEM_LOCALE, LR_ENC_UTF8, "strMessage");
//		strcpy(temp,lr_eval_string("{strMessage}"));
//		lr_save_string(temp,"strMessageUTF8");
//
//		//Begin loop to send request
//		for(i = 1 ; i <= LoopNumber; i++)
//		{
//				lr_save_int(i, "EndNumber");
//				
//				web_reg_save_param("HttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	LAST);
//				
//				lr_start_transaction("Film Create Film");
//
//						web_custom_request("Create_PaperReport",
//						"URL=http://47.98.102.85/CenterInfoServer/CenterPrintService.asmx ",
//						"Method=POST",
//						"TargetFrame=",
//						"Resource=0",
//						"Referer=",
//						"Mode=HTTP",
//						"EncType=text/xml; charset=utf-8",
//						"Body=<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:wsa=\"http://schemas.xmlsoap.org/ws/2004/03/addressing\"><soap:Header><wsa:Action>http://tempuri.org/SynchronizeInfo</wsa:Action><wsa:MessageID>uuid:836ce98b-5d84-45e4-8a66-5499089aaf79</wsa:MessageID><wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/03/addressing/role/anonymous</wsa:Address></wsa:ReplyTo><wsa:To>http://47.98.102.85/CenterInfoServer/CenterPrintService.asmx</wsa:To></soap:Header><soap:Body>"
//						"<SynchronizeInfo xmlns=\"http://tempuri.org/\">"
//						"<table_name>FilmReportStatus</table_name><table_key>ExamID</table_key><table_value>E{strCurrentDateTime}{EndNumber}{HospitalID}</table_value>"
//						"<json_input>{\"RowError\":\"\",\"RowState\":16,\"Table\":[{\"ExamID\":\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"PatientID\":\"P{strCurrentDateTime}{HospitalID}\",\"PatientName\":\"N{strCurrentDateTime}{HospitalID}\",\"PatientType\":\"3\",\"Modality\":\"{ExamModalityType}\",\"StatusID\":241,\"StatusMessage\":\"{strMessageUTF8}\",\"ExamCreateTime\":\"{ExamCreateTime}\",\"StatusCreateTime\":\"{StatusCreateTime}\",\"StatusUpdateTime\":null,\"PrintTime\":null,\"FilmCount\":1,\"ReportCount\":0,\"ActionID\":0,\"PrintLocation\":\"\",\"HospitalID\":\"{HospitalID}\"}],"
//						"\"ItemArray\":[\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"P{strCurrentDateTime}{HospitalID}\",\"N{strCurrentDateTime}{HospitalID}\",\"3\",\"{ItemModalityType}\",241,\"{strMessageUTF8}\",\"{ExamCreateTime}\",\"{StatusCreateTime}\",null,null,1,1,0,\"\",\"{HospitalID}\"],\"HasErrors\":false}</json_input></SynchronizeInfo></soap:Body></soap:Envelope>",
//						LAST);	
//
//				lr_end_transaction("Film Create Film", LR_AUTO);
//				
//				// Get the http response status and check the value.
//				HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
//
//				if(HTTP_RC !=200)
//				{
//					lr_fail_trans_with_error("PS Synchronize create Film failed. The http return code is %d", HTTP_RC);
//					lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
//					return 0;
//				}
//				
//				//Get the http response result and check the final value.
//				if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
//				{
//					lr_fail_trans_with_error("PS Synchronize Create film failed. The http response content is not true!");
//					lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
//					return 0;
//				}
//		
//		}
//			
//			
//			
//					//***************************************************************************************
//					//Query the Film status
//					//**************************************************************************************
//			
////					web_reg_save_param("HttpResult","LB=<Content><![CDATA[","RB=]></Content>",	LAST);
////					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
////					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
//					
//					lr_start_transaction("Film QueryReportFilmStatus");
//
//					web_custom_request("web_QueryReportFilmStatus",
//						"URL=http://47.98.102.85/KioskWechatServer/WechatServer",
//						"Method=POST",
//						"TargetFrame=",
//						"Resource=0",
//						"Referer=",
//						"Mode=HTTP",
//						"Body=<xml><ToUserName><![CDATA[gh_645a789c296d]]></ToUserName>"
//						"<FromUserName><![CDATA[User{strCurrentDateTime}{HospitalID}{TimeStamp}]]></FromUserName>"
//						"<CreateTime>{TimeStamp}</CreateTime>"
//						"<MsgType><![CDATA[event]]></MsgType>"
//						"<Event><![CDATA[CLICK]]></Event>"
//						"<EventKey><![CDATA[BUTTON_QUERY_REPORT]]></EventKey>"
//						"</xml>",
//						LAST);
//					
//					lr_end_transaction("Film QueryReportFilmStatus", LR_AUTO);
//					
//					// Get the http response status and check the value.
//					HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
//					
////					lr_output_message("Http request is: %s", lr_eval_string("{HttpResult}") );
////					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
////					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
//	
//					if(HTTP_RC !=200)
//					{
//						lr_fail_trans_with_error("Query Film status failed. The http return code is %d", HTTP_RC);
//						lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
//						return 0;
//					}
//					
////					//Get the http response result and check the final value.
////					if(HTTP_RC == 200 && strlen(lr_eval_string("{realMessage}")) > 0)
////					{
////						lr_fail_trans_with_error("PS Synchronize Create Paper report failed. The http response content is not true!");
////					}
//					
//					//****************************************************************//
//					//Check the system has send the message to WeChat//
//					//****************************************************************//
//					
////					 // SELECT RECORD COUNT FROM NOTIFY MESSAGE TABLE.
////				  	tmpSQL = "SELECT COUNT(*) AS ROWCOUNT FROM ECS.notificationmessage WHERE NotifyType = 0 AND OpenID = 'User{strCurrentDateTime}{HospitalID}{TimeStamp}'";
////					lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery");
////					  
////					rc = mysql_query(db_connection, lr_eval_string("{SQLECSQuery}"));
////				 	if (rc != 0) {
////					    lr_error_message("%s", mysql_error(db_connection));
////					    mysql_close(db_connection);
////					    lr_fail_trans_with_error("Query data from database failed");
////					   	lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
////						return 0;
////				 	 }
////			
////					query_result = mysql_store_result(db_connection);
////					lr_output_message("count is: %d", mysql_num_rows(query_result));
////					
////					result_row = (char **)mysql_fetch_row(query_result);
////					lr_save_string(result_row[0], "ROWCOUNT"); 
////					lr_output_message("ROWCOUNT is: %s", lr_eval_string("{ROWCOUNT}"));
////					
////					if(strcmp(lr_eval_string("{ROWCOUNT}"),"1") != 0)
////					{
////						lr_fail_trans_with_error("Film QueryReportFilmStatus_failed.");
////						lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
////						return 0;
////					}
////
//
//					//lr_think_time(1);
//					
//					
//					
//					
//					//***************************************************************************************
//					//Update the Film to printed status
//					//***************************************************************************************
//					
//					//Set the message varchar and convert it to UTF-8 type
//				lr_convert_string_encoding("您胶片已经打印，谢谢！",LR_ENC_SYSTEM_LOCALE, LR_ENC_UTF8, "strMessage");
//				strcpy(temp,lr_eval_string("{strMessage}"));
//				lr_save_string(temp,"strMessageUTF8");
//				
//				//Begin loop to send request
//				for(i = 1 ; i <= LoopNumber; i++)
//				{
//						lr_save_int(i, "EndNumber");
//						
//						web_reg_save_param("HttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	LAST);
//						
//						lr_start_transaction("Film Update Film");
//		
//								web_custom_request("Update Paper report Print status",
//								"URL=http://47.98.102.85/CenterInfoServer/CenterPrintService.asmx ",
//								"Method=POST",
//								"TargetFrame=",
//								"Resource=0",
//								"Referer=",
//								"Mode=HTTP",
//								"EncType=text/xml; charset=utf-8",
//								"Body=<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"><s:Body xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><SynchronizeInfo xmlns=\"http://tempuri.org/\">"
//								"<table_name>FilmReportStatus</table_name><table_key>ExamID</table_key><table_value>E{strCurrentDateTime}{EndNumber}{HospitalID}</table_value>"
//								"<json_input>{\"RowError\":\"\",\"RowState\":16,\"Table\":[{\"ExamID\":\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"PatientID\":\"P{strCurrentDateTime}{HospitalID}\",\"PatientName\":\"N{strCurrentDateTime}{HospitalID}\",\"PatientType\":\"3\",\"Modality\":\"{ExamModalityType}\",\"StatusID\":247,\"StatusMessage\":\"{strMessageUTF8}\",\"ExamCreateTime\":\"{ExamCreateTime}\",\"StatusCreateTime\":\"{StatusCreateTime}\",\"StatusUpdateTime\":\"{StatusUpdateTime}\",\"PrintTime\":\"{PrintTime}\",\"FilmCount\":0,\"ReportCount\":1,\"ActionID\":0,\"PrintLocation\":\"\",\"HospitalID\":\"{HospitalID}\"}],\""
//								"ItemArray\":[\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"P{strCurrentDateTime}{HospitalID}\",\"N{strCurrentDateTime}{HospitalID}\",\"3\",\"{ItemModalityType}\",247,\"{strMessageUTF8}\",\"{ExamCreateTime}\",\"{StatusCreateTime}\",\"{StatusUpdateTime}\",\"{PrintTime}\",0,1,0,\"\",\"{HospitalID}\"],\"HasErrors\":false}</json_input></SynchronizeInfo></s:Body></s:Envelope>",
//								LAST);
//		
//						lr_end_transaction("Film Update Film", LR_AUTO);
//						
//						// Get the http response status and check the value.
//						HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
//		
//						if(HTTP_RC !=200)
//						{
//							lr_fail_trans_with_error("PS Synchronize Update film failed. The http return code is %d", HTTP_RC);
//							lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
//							return 0;
//						}
//						
//						//Get the http response result and check the final value.
//						if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
//						{
//							lr_fail_trans_with_error("PS Synchronize update film failed. The http response content is not true!");
//							lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
//							return 0;
//						}
//		
//				}	
//					
//					
//					
////					web_reg_save_param("HttpResult","LB=<Content><![CDATA[","RB=]></Content>",	LAST);
////					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
////					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
//					
//					lr_start_transaction("Film QueryReportFilmStatus");
//
//					web_custom_request("web_QueryReportFilmStatus",
//						"URL=http://47.98.102.85/KioskWechatServer/WechatServer",
//						"Method=POST",
//						"TargetFrame=",
//						"Resource=0",
//						"Referer=",
//						"Mode=HTTP",
//						"Body=<xml><ToUserName><![CDATA[gh_645a789c296d]]></ToUserName>"
//						"<FromUserName><![CDATA[User{strCurrentDateTime}{HospitalID}{TimeStamp}]]></FromUserName>"
//						"<CreateTime>{TimeStamp}</CreateTime>"
//						"<MsgType><![CDATA[event]]></MsgType>"
//						"<Event><![CDATA[CLICK]]></Event>"
//						"<EventKey><![CDATA[BUTTON_QUERY_REPORT]]></EventKey>"
//						"</xml>",
//						LAST);
//					
//					lr_end_transaction("Film QueryReportFilmStatus", LR_AUTO);
//					
//					// Get the http response status and check the value.
//					HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
//					
//					lr_output_message("Http request is: %s", lr_eval_string("{HttpResult}") );
//					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
//					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
//	
//					if(HTTP_RC !=200)
//					{
//						lr_fail_trans_with_error("Query film status failed. The http return code is %d", HTTP_RC);
//						lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
//						return 0;
//					}
//					
////					//Get the http response result and check the final value.
////					if(HTTP_RC == 200 && strlen(lr_eval_string("{realMessage}")) < 10)
////					{
////						lr_fail_trans_with_error("PS Synchronize Create Paper report failed. The http response content is not true!");
////					}
//					
//					// SELECT RECORD COUNT FROM NOTIFY MESSAGE TABLE.
////				  	tmpSQL = "SELECT COUNT(*) AS ROWCOUNT FROM ECS.notificationmessage WHERE NotifyType = 0 AND OpenID = 'User{strCurrentDateTime}{HospitalID}{TimeStamp}'";
////					lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery");
////					  
////					rc = mysql_query(db_connection, lr_eval_string("{SQLECSQuery}"));
////				 	if (rc != 0) {
////					    lr_error_message("%s", mysql_error(db_connection));
////					    mysql_close(db_connection);
////					    lr_fail_trans_with_error("Query data from database failed");
////					    lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
////						return 0;
////				 	 }
////			
////					query_result = mysql_store_result(db_connection);
////					lr_output_message("count is: %d", mysql_num_rows(query_result));
////					
////					result_row = (char **)mysql_fetch_row(query_result);
////					lr_save_string(result_row[0], "ROWCOUNT"); 
////					lr_output_message("ROWCOUNT is: %s", lr_eval_string("{ROWCOUNT}"));
////					
////					if(strcmp(lr_eval_string("{ROWCOUNT}"),"2") != 0)
////					{
////						lr_fail_trans_with_error("Film QueryReportFilmStatus_failed.");
////						lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
////						return 0;
////					}
//
//					//lr_think_time(1);
//					
//  
////   	  mysql_free_result(query_result);		
//
//
//	return 0;
//}
