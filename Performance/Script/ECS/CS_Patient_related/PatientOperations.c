PatientOperations()
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
		
	// The MySQL 5.0 C API documentation is available from:	
	// http://dev.mysql.com/doc/refman/5.0/en/c-api-functions.html
 
	// Note that this code may have problems with thread safety. 
	// It is therefore best to run each vuser as a process rather than as a thread.
  
		  int rc; // return code
		  int db_connection; // Declaractions is a bit dodgy. Should really use MYSQL defined in mysql.h
		  int query_result; // Declaractions is a bit dodgy. Should really use MYSQL_RES defined in mysql.h
		  char** result_row; // Return data as array of strings. Declaractions is a bit dodgy. Should really use MYSQL_ROW defined in mysql.h
		 
		  char *server = "10.184.129.203";
		  char *user = "sa";
		  char *password = "sa20021224$"; // very naughty to leave default root account with no password :)
		  char *database = "ECS";
		  int port = 3306; // default MySQL port
		  int unix_socket = NULL; // leave this as null
		  int flags = 0; // no flags
		 
		  // You should be able to find the MySQL DLL somewhere in your MySQL install directory.
		  rc = lr_load_dll ("libmysql.dll");
		  if (rc != 0) {
		    lr_error_message("Could not load libmysql.dll");
		    lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);

		  }
		 
		  // Allocate and initialise a new MySQL object
		  db_connection = mysql_init(NULL);
		  if (db_connection == NULL) {
		    lr_error_message("Insufficient memory init my SQL failed.");
		    lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
		  }
		 
		  // Connect to the database
		  rc = mysql_real_connect(db_connection, server, user, password, database, port, unix_socket, flags);
		  if (rc == NULL) {
		    lr_error_message("%s", mysql_error(db_connection));
		    mysql_close(db_connection);
		    lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
		  }

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
		
		
		/*********************************************************************************************/
		/******************** Patient  Get2DCodeImage  ***********************************************/
		/*********************************************************************************************/
		
		web_reg_save_param("Get2DCodeImageResult","LB=<Get2DCodeImageResult>","RB=</Get2DCodeImageResult>",	LAST);
		
		lr_start_transaction("Patient operations_ Get2DCodeImage");

				web_custom_request("Get2DCodeImage",
				"URL=http://10.184.129.203/CenterInfoServer/CenterPrintService.asmx ",
				"Method=POST",
				"TargetFrame=",
				"Resource=0",
				"Referer=",
				"Mode=HTTP",
				"EncType=text/xml; charset=utf-8",
				"Body=<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:wsa=\"http://schemas.xmlsoap.org/ws/2004/03/addressing\">"
				"<soap:Header><wsa:Action>http://tempuri.org/Get2DCodeImage</wsa:Action><wsa:MessageID>uuid:81afdc9a-7c24-4600-8714-05e9250c0a31</wsa:MessageID><wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/03/addressing/role/anonymous</wsa:Address></wsa:ReplyTo><wsa:To>http://10.184.129.203/CenterInfoServer/CenterPrintService.asmx</wsa:To></soap:Header><soap:Body><Get2DCodeImage xmlns=\"http://tempuri.org/\">"
				"<hospitalID>{HospitalID}</hospitalID><patientID>P{strCurrentDateTime}{HospitalID}</patientID><qrcodeParam><QRCodeScale>1</QRCodeScale><QRCodeErrorCorrect>{QRCodeErrorCorrect}</QRCodeErrorCorrect></qrcodeParam></Get2DCodeImage></soap:Body></soap:Envelope>",
				LAST);	
				
				HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
				
				if(HTTP_RC !=200)
				{
					lr_fail_trans_with_error("Get2DCodeImage from CS operations failed. The http return code is %d", HTTP_RC);
					return 0;
				}
				
				
				HTTP_RES_SIZE = strlen(lr_eval_string("{Get2DCodeImageResult}"));
				
				//Get the http response result and check the final value.
				if(HTTP_RC == 200 && strlen(lr_eval_string("{Get2DCodeImageResult}")) == 0)
				{
					lr_fail_trans_with_error("Get2DCodeImage from CS operations failed. The http response content size is %d!", HTTP_RES_SIZE);
					return 0;
				}
		
				
		lr_end_transaction("Patient operations_ Get2DCodeImage", LR_AUTO);

		lr_think_time(1);
		
		//*************************************************************************************
		//subscribe patient from WeChat, get the Patient OpenID;
		//*************************************************************************************
		
	  // SELECT a single value from the database table, and print the result
	  	tmpSQL = "SELECT ID FROM ecs.qrcodesceneinfo where PatientID = 'P{strCurrentDateTime}{HospitalID}' and HospitalID = '{HospitalID}' ;";
		lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery");
		  
		rc = mysql_query(db_connection, lr_eval_string("{SQLECSQuery}"));
	 	if (rc != 0) {
		    lr_error_message("%s", mysql_error(db_connection));
		    mysql_close(db_connection);
		    lr_fail_trans_with_error("Query data from database failed");
		    lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
	 	 }

		query_result = mysql_store_result(db_connection);
		lr_output_message("count is: %d", mysql_num_rows(query_result));
		
		if(mysql_num_rows(query_result) == 1)
		{
			result_row = (char **)mysql_fetch_row(query_result);
			lr_save_string(result_row[0], "QrsenceID"); // this parameter will be used when deleting the row.
  			lr_output_message("Order ID is: %s", lr_eval_string("{QrsenceID}"));
  			
  			lr_save_timestamp("Para", "DIGITS=10", LAST );
   			lr_output_message(lr_eval_string("{Para}"));
   			lr_save_string(lr_eval_string("{Para}"),"TimeStamp");
   
  			
   			//***********************************************************************
   			//subscribe patient from WeChat
  			//***********************************************************************
  			
  			lr_start_transaction("Subscribe_Patinet");

	  			web_custom_request("web_Subscribe_Patinet",
					"URL=http://10.184.129.203/KioskWechatServer/WechatServer",
					"Method=POST",
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					"Mode=HTTP",
					"Body=<xml><ToUserName><![CDATA[gh_5e1ed4b61713]]></ToUserName><FromUserName><![CDATA[User{strCurrentDateTime}{HospitalID}{TimeStamp}]]></FromUserName><CreateTime>{TimeStamp}</CreateTime>"
					"<MsgType><![CDATA[event]]></MsgType><Event><![CDATA[subscribe]]></Event><EventKey><![CDATA[qrscene_{QrsenceID}]]></EventKey>"
					"<Ticket><![CDATA[gQHx8DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyLXFwbTVoVXplWTAxVFNHZGhxMVAAAgT23aVaAwQAjScB]]></Ticket></xml>",
					LAST);
		  			
  			lr_end_transaction("Subscribe_Patinet", LR_AUTO);
  			
  			
  			LoopNumber = atoi(lr_eval_string("{RandForLoop}"));
	  		//Set the message varchar and convert it to UTF-8 type
			lr_convert_string_encoding("您报告已经审核,请到自助终端打印！",LR_ENC_SYSTEM_LOCALE, LR_ENC_UTF8, "strMessage");
			strcpy(temp,lr_eval_string("{strMessage}"));
			lr_save_string(temp,"strMessageUTF8");
	
			//Begin loop to send request
			for(i = 1 ; i <= LoopNumber; i++)
			{
					lr_save_int(i, "EndNumber");
					
					web_reg_save_param("HttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	LAST);
					
					lr_start_transaction("Create Paper report");
	
							web_custom_request("Create_PaperReport",
							"URL=http://10.184.129.203/CenterInfoServer/CenterPrintService.asmx ",
							"Method=POST",
							"TargetFrame=",
							"Resource=0",
							"Referer=",
							"Mode=HTTP",
							"EncType=text/xml; charset=utf-8",
							"Body=<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:wsa=\"http://schemas.xmlsoap.org/ws/2004/03/addressing\"><soap:Header><wsa:Action>http://tempuri.org/SynchronizeInfo</wsa:Action><wsa:MessageID>uuid:836ce98b-5d84-45e4-8a66-5499089aaf79</wsa:MessageID><wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/03/addressing/role/anonymous</wsa:Address></wsa:ReplyTo><wsa:To>http://10.184.129.203/CenterInfoServer/CenterPrintService.asmx</wsa:To></soap:Header><soap:Body>"
							"<SynchronizeInfo xmlns=\"http://tempuri.org/\">"
							"<table_name>FilmReportStatus</table_name><table_key>ExamID</table_key><table_value>E{strCurrentDateTime}{EndNumber}{HospitalID}</table_value>"
							"<json_input>{\"RowError\":\"\",\"RowState\":16,\"Table\":[{\"ExamID\":\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"PatientID\":\"P{strCurrentDateTime}{HospitalID}\",\"PatientName\":\"N{strCurrentDateTime}{HospitalID}\",\"PatientType\":\"3\",\"Modality\":\"{ExamModalityType}\",\"StatusID\":242,\"StatusMessage\":\"{strMessageUTF8}\",\"ExamCreateTime\":\"{ExamCreateTime}\",\"StatusCreateTime\":\"{StatusCreateTime}\",\"StatusUpdateTime\":null,\"PrintTime\":null,\"FilmCount\":0,\"ReportCount\":1,\"ActionID\":0,\"PrintLocation\":\"\",\"HospitalID\":\"{HospitalID}\"}],"
							"\"ItemArray\":[\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"P{strCurrentDateTime}{HospitalID}\",\"N{strCurrentDateTime}{HospitalID}\",\"3\",\"{ItemModalityType}\",242,\"{strMessageUTF8}\",\"{ExamCreateTime}\",\"{StatusCreateTime}\",null,null,0,1,0,\"\",\"{HospitalID}\"],\"HasErrors\":false}</json_input></SynchronizeInfo></soap:Body></soap:Envelope>",
							LAST);	
							
							// Get the http response status and check the value.
							HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
			
							if(HTTP_RC !=200)
							{
								lr_fail_trans_with_error("PS Synchronize create PaperReport failed. The http return code is %d", HTTP_RC);
							}
							
							//Get the http response result and check the final value.
							if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
							{
								lr_fail_trans_with_error("PS Synchronize Create Paper report failed. The http response content is not true!");
							}
				
					lr_end_transaction("Create Paper report", LR_AUTO);
					
					lr_think_time(1);
			}
			
					//***************************************************************************************
					//Query the report status
					//**************************************************************************************
			
					web_reg_save_param("HttpResult","LB=<Content><![CDATA[","RB=]></Content>",	LAST);
					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
					
					lr_start_transaction("QueryReportFilmStatus");

					web_custom_request("web_QueryReportFilmStatus",
						"URL=http://10.184.129.203/KioskWechatServer/WechatServer",
						"Method=POST",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body=<xml><ToUserName><![CDATA[gh_5e1ed4b61713]]></ToUserName>"
						"<FromUserName><![CDATA[User{strCurrentDateTime}{HospitalID}{TimeStamp}]]></FromUserName>"
						"<CreateTime>{TimeStamp}</CreateTime>"
						"<MsgType><![CDATA[event]]></MsgType>"
						"<Event><![CDATA[CLICK]]></Event>"
						"<EventKey><![CDATA[BUTTON_QUERY_REPORT]]></EventKey>"
						"</xml>",
						LAST);
					
					lr_end_transaction("QueryReportFilmStatus", LR_AUTO);
					
					// Get the http response status and check the value.
					HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
					
					lr_output_message("Http request is: %s", lr_eval_string("{HttpResult}") );
					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("PS Synchronizec create PaperReport failed. The http return code is %d", HTTP_RC);
					}
					
					//Get the http response result and check the final value.
					if(HTTP_RC == 200 && strlen(lr_eval_string("{realMessage}")) < 10)
					{
						lr_fail_trans_with_error("PS Synchronize Create Paper report failed. The http response content is not true!");
					}
					
					lr_think_time(1);
					
					//***************************************************************************************
					//Update the report to printed status
					//***************************************************************************************
					
					//Set the message varchar and convert it to UTF-8 type
					lr_convert_string_encoding("您报告已经打印，谢谢！",LR_ENC_SYSTEM_LOCALE, LR_ENC_UTF8, "strMessage");
					strcpy(temp,lr_eval_string("{strMessage}"));
					lr_save_string(temp,"strMessageUTF8");
					
					//Begin loop to send request
					for(i = 1 ; i <= LoopNumber; i++)
					{
							lr_save_int(i, "EndNumber");
							
							web_reg_save_param("HttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	LAST);
						
							lr_start_transaction("Update Paper report");
					
									web_custom_request("Update Paper report Print status",
									"URL=http://10.184.129.203/CenterInfoServer/CenterPrintService.asmx ",
									"Method=POST",
									"TargetFrame=",
									"Resource=0",
									"Referer=",
									"Mode=HTTP",
									"EncType=text/xml; charset=utf-8",
									"Body=<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"><s:Body xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><SynchronizeInfo xmlns=\"http://tempuri.org/\">"
									"<table_name>FilmReportStatus</table_name><table_key>ExamID</table_key><table_value>E{strCurrentDateTime}{EndNumber}{HospitalID}</table_value>"
									"<json_input>{\"RowError\":\"\",\"RowState\":16,\"Table\":[{\"ExamID\":\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"PatientID\":\"P{strCurrentDateTime}{HospitalID}\",\"PatientName\":\"N{strCurrentDateTime}{HospitalID}\",\"PatientType\":\"3\",\"Modality\":\"{ExamModalityType}\",\"StatusID\":248,\"StatusMessage\":\"{strMessageUTF8}\",\"ExamCreateTime\":\"{ExamCreateTime}\",\"StatusCreateTime\":\"{StatusCreateTime}\",\"StatusUpdateTime\":\"{StatusUpdateTime}\",\"PrintTime\":\"{PrintTime}\",\"FilmCount\":0,\"ReportCount\":1,\"ActionID\":0,\"PrintLocation\":\"\",\"HospitalID\":\"{HospitalID}\"}],\""
									"ItemArray\":[\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"P{strCurrentDateTime}{HospitalID}\",\"N{strCurrentDateTime}{HospitalID}\",\"3\",\"{ItemModalityType}\",248,\"{strMessageUTF8}\",\"{ExamCreateTime}\",\"{StatusCreateTime}\",\"{StatusUpdateTime}\",\"{PrintTime}\",0,1,0,\"\",\"{HospitalID}\"],\"HasErrors\":false}</json_input></SynchronizeInfo></s:Body></s:Envelope>",
									LAST);
									
									// Get the http response status and check the value.
									HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
					
									if(HTTP_RC !=200)
									{
										lr_fail_trans_with_error("PS Synchronize update PaperReport failed. The http return code is %d", HTTP_RC);
									}
									
									//Get the http response result and check the final value.
									if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
									{
										lr_fail_trans_with_error("PS Synchronize update Paper report failed. The http response content is not true!");
									}
									
							lr_end_transaction("Update Paper report", LR_AUTO);
					}
					
					
					web_reg_save_param("HttpResult","LB=<Content><![CDATA[","RB=]></Content>",	LAST);
					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
					
					lr_start_transaction("QueryReportFilmStatus");

					web_custom_request("web_QueryReportFilmStatus",
						"URL=http://10.184.129.203/KioskWechatServer/WechatServer",
						"Method=POST",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body=<xml><ToUserName><![CDATA[gh_5e1ed4b61713]]></ToUserName>"
						"<FromUserName><![CDATA[User{strCurrentDateTime}{HospitalID}{TimeStamp}]]></FromUserName>"
						"<CreateTime>{TimeStamp}</CreateTime>"
						"<MsgType><![CDATA[event]]></MsgType>"
						"<Event><![CDATA[CLICK]]></Event>"
						"<EventKey><![CDATA[BUTTON_QUERY_REPORT]]></EventKey>"
						"</xml>",
						LAST);
					
					lr_end_transaction("QueryReportFilmStatus", LR_AUTO);
					
					// Get the http response status and check the value.
					HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
					
					lr_output_message("Http request is: %s", lr_eval_string("{HttpResult}") );
					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("PS Synchronizec create PaperReport failed. The http return code is %d", HTTP_RC);
					}
					
					//Get the http response result and check the final value.
					if(HTTP_RC == 200 && strlen(lr_eval_string("{realMessage}")) < 10)
					{
						lr_fail_trans_with_error("PS Synchronize Create Paper report failed. The http response content is not true!");
					}
					
					
  			
  			
  			//If the random number is 1, simualte the Resevervation update operation.
//		if(ExecuteRand == 1)
//		{
			for(i = 1 ; i <= LoopNumber; i++)
			{
					lr_save_int(i, "EndNumber");
				
				//Set the reservation exam date is tomorrow. plus one day.			
				lr_save_datetime("%Y-%m-%dT%H:%M:%S", DATE_NOW + (ONE_DAY*1), "ExamReservationBegin");

				web_reg_save_param("HttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	LAST);
				lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
				lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
				
				lr_start_transaction("Create ExamReservation");
				
						web_custom_request("Create_ExamReservation",
						"URL=http://10.184.129.203/CenterInfoServer/CenterPrintService.asmx ",
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
						
						// Get the http response status and check the value.
						HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
		
						if(HTTP_RC !=200)
						{
							lr_fail_trans_with_error("Create_ExamReservation failed. The http return code is %d", HTTP_RC);
						}
						
						//Get the http response result and check the final value.
						if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
						{
							lr_fail_trans_with_error("Create_ExamReservation failed. The http response content is %s!",lr_eval_string("{realMessage}"));
						}
				
				lr_end_transaction("Create ExamReservation", LR_AUTO);
			}
					

			
//			web_reg_save_param("HttpResult","LB=<Content><![CDATA[","RB=]></Content>",	LAST);
//			lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
//			lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
			
			lr_start_transaction("QueryExamReservation");

					web_custom_request("QueryExamReservation",
						"URL=http://10.184.129.203/KioskWechatServer/WechatServer",
						"Method=POST",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body=<xml><ToUserName><![CDATA[gh_5e1ed4b61713]]></ToUserName>"
						"<FromUserName><![CDATA[User{strCurrentDateTime}{HospitalID}{TimeStamp}]]></FromUserName>"
						"<CreateTime>{TimeStamp}</CreateTime>"
						"<MsgType><![CDATA[event]]></MsgType>"
						"<Event><![CDATA[CLICK]]></Event>"
						"<EventKey><![CDATA[BUTTON_QUERY_EXAMRESERVATION]]></EventKey>"
						"</xml>",
						LAST);
					
					lr_end_transaction("QueryExamReservation", LR_AUTO);
					
					// Get the http response status and check the value.
					HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
					
					lr_output_message("Http request is: %s", lr_eval_string("{HttpResult}") );
					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("QueryExamReservation failed. The http return code is %d", HTTP_RC);
					}
					
//					//Get the http response result and check the final value.
//					if(HTTP_RC == 200 && strlen(lr_eval_string("{realMessage}")) < 10)
//					{
//						lr_fail_trans_with_error("QueryExamReservationd. The http response content is %s",lr_eval_string("{realMessage}"));
//					}
					
//		}


		}
		else
		{
			lr_fail_trans_with_error("There are %d rows in table ecs.qrcodesceneinfo which Patientid is: %s hospitalId is %s ",mysql_num_rows(query_result),lr_eval_string("P{strCurrentDateTime}{HospitalID}"),lr_eval_string("{HospitalID}") );
		}
		
//		
//	
  
  
   	  mysql_free_result(query_result);		
      mysql_close(db_connection);

	return 0;
}
