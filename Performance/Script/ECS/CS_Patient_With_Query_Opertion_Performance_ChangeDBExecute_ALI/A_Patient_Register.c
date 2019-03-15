A_Patient_Register()
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
		
		int offset;
	    char * position;
	    char * search_str = "error";
	   // char * str;

	  
	  	web_set_max_html_param_len("10240");
		
		/******************************************************************************/
		/********Get currentdateTime with millisecond, make it to variable. ***********/
		/********The Patient examid, patientid and accession number can use it.********/
		/******************************************************************************/
	
		//Get current datetime with millisecond with LR parameter and Remove character "."
		str=lr_eval_string("{CurrentDateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"strCurrentDateTime");
		//lr_output_message("%s",lr_eval_string("{strCurrentDateTime}"));
		
	
		/*********************************************************************************************/
		/******************** Patient  Get2DCodeImage  ***********************************************/
		/*********************************************************************************************/
		
		web_reg_save_param("Get2DCodeImageResult","LB=<Get2DCodeImageResult>","RB=</Get2DCodeImageResult>",	LAST);
		
		lr_start_transaction("Patient operations_ Get2DCodeImage");

				web_custom_request("Get2DCodeImage",
				"URL=http://47.98.102.85/CenterInfoServer/CenterPrintService.asmx ",
				"Method=POST",
				"TargetFrame=",
				"Resource=0",
				"Referer=",
				"Mode=HTTP",
				"EncType=text/xml; charset=utf-8",
				"Body=<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:wsa=\"http://schemas.xmlsoap.org/ws/2004/03/addressing\">"
				"<soap:Header><wsa:Action>http://tempuri.org/Get2DCodeImage</wsa:Action><wsa:MessageID>uuid:81afdc9a-7c24-4600-8714-05e9250c0a31</wsa:MessageID><wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/03/addressing/role/anonymous</wsa:Address></wsa:ReplyTo><wsa:To>http://47.98.102.85/CenterInfoServer/CenterPrintService.asmx</wsa:To></soap:Header><soap:Body><Get2DCodeImage xmlns=\"http://tempuri.org/\">"
				"<hospitalID>{HospitalID}</hospitalID><patientID>P{strCurrentDateTime}{HospitalID}</patientID><qrcodeParam><QRCodeScale>1</QRCodeScale><QRCodeErrorCorrect>{QRCodeErrorCorrect}</QRCodeErrorCorrect></qrcodeParam></Get2DCodeImage></soap:Body></soap:Envelope>",
				LAST);	
	
	 lr_end_transaction("Patient operations_ Get2DCodeImage", LR_AUTO);
	
				HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
				
				if(HTTP_RC !=200)
				{
					lr_fail_trans_with_error("Get2DCodeImage from CS operations failed. The http return code is %d", HTTP_RC);
					//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
					return 0;
				}
				
				
				HTTP_RES_SIZE = strlen(lr_eval_string("{Get2DCodeImageResult}"));
				
				//Get the http response result and check the final value.
				if(HTTP_RC == 200 && strlen(lr_eval_string("{Get2DCodeImageResult}")) == 0)
				{
					lr_fail_trans_with_error("Get2DCodeImage from CS operations failed. The http response content size is %d!", HTTP_RES_SIZE);
					//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
					return 0;
				}
		
				
	

		lr_think_time(1);
		
		//*************************************************************************************
		//subscribe patient from WeChat, get the Patient OpenID;
		//*************************************************************************************
		
//	  // SELECT a single value from the database table, and print the result
//	  	tmpSQL = "SELECT ID FROM ecs.qrcodesceneinfo where PatientID = 'P{strCurrentDateTime}{HospitalID}' and HospitalID = '{HospitalID}' ;";
//		lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery");
//		  
//		rc = mysql_query(db_connection, lr_eval_string("{SQLECSQuery}"));
//	 	if (rc != 0) {
//		    lr_error_message("%s", mysql_error(db_connection));
//		    mysql_close(db_connection);
//		    lr_fail_trans_with_error("Query data from database failed");
//			//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
//			return 0;
//	 	 }
//
//		query_result = mysql_store_result(db_connection);
//		lr_output_message("count is: %d", mysql_num_rows(query_result));
//		
//		if(mysql_num_rows(query_result) != 1)
//		{
//			lr_fail_trans_with_error("There are %d rows in table ecs.qrcodesceneinfo which Patientid is: %s hospitalId is %s ",mysql_num_rows(query_result),lr_eval_string("P{strCurrentDateTime}{HospitalID}"),lr_eval_string("{HospitalID}") );
//			//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
//			return 0;
//		}
//
//		
//		
//		result_row = (char **)mysql_fetch_row(query_result);
//		lr_save_string(result_row[0], "QrsenceID"); // this parameter will be used when deleting the row.
//		lr_output_message("Order ID is: %s", lr_eval_string("{QrsenceID}"));
		
		lr_save_timestamp("Para", "DIGITS=10", LAST );
		lr_output_message(lr_eval_string("{Para}"));
		lr_save_string(lr_eval_string("{Para}"),"TimeStamp");
		
		web_reg_save_param("GetPatientQRIDResult","LB=<GetPatientQRIDResult>","RB=</GetPatientQRIDResult>",LAST);

		lr_start_transaction("GetPatientQRID");

		web_custom_request("web_custom_request",
			"URL=http://47.98.102.85/CSService/CSService.asmx ",
			"Method=POST",
			"TargetFrame=",
			"Resource=0",
			"Referer=http://47.98.102.85/CSService/CSService.asmx",
			"Mode=HTTP",
			"EncType=text/xml; charset=utf-8",
			"Body=<?xml version=\"1.0\" encoding=\"utf-8\"?>"
			"<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:wsa=\"http://schemas.xmlsoap.org/ws/2004/03/addressing\">"
			"<soap:Header><wsa:Action>http://tempuri.org/GetPatientQRID</wsa:Action><wsa:MessageID>uuid:4ba2a77e-fc41-483c-aa1a-1d71a25582f9</wsa:MessageID><wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/03/addressing/role/anonymous</wsa:Address></wsa:ReplyTo><wsa:To>http://47.98.102.85/CSService/CSService.asmx</wsa:To></soap:Header>"
			"<soap:Body><GetPatientQRID xmlns=\"http://tempuri.org/\"><strPID>P{strCurrentDateTime}{HospitalID}</strPID></GetPatientQRID></soap:Body></soap:Envelope>",
			LAST);

		lr_end_transaction("GetPatientQRID", LR_AUTO);

		str = lr_eval_string("{GetPatientQRIDResult}");
		position = (char *)strstr(str, search_str);
   		// strstr has returned the address. Now calculate * the offset from the beginning of str 
   		offset = (int)(position - str + 1);
   	
   		lr_output_message ("The string \"%s\" was found at position %d", lr_eval_string("{GetPatientQRIDResult}"), offset);
   	 
	   	if(offset == 1)
	   	{
	   		//lr_exit(//lr_exit_ITERATION_AND_CONTINUE,LR_FAIL);
	
	   		return 0;
	   	}
	
   
		lr_think_time(1);
		//***********************************************************************
		//subscribe patient from WeChat
		//***********************************************************************
  			web_reg_save_param("HttpResult","LB=<Content><![CDATA[","RB=]></Content>",	LAST);
  			
  			lr_start_transaction("Patient Subscribe_Patinet");

	  			web_custom_request("web_Subscribe_Patinet",
					"URL=http://47.98.102.85/KioskWechatServer/WechatServer",
					"Method=POST",
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					"Mode=HTTP",
					"Body=<xml><ToUserName><![CDATA[gh_645a789c296d]]></ToUserName><FromUserName><![CDATA[User{strCurrentDateTime}{HospitalID}{TimeStamp}]]></FromUserName><CreateTime>{TimeStamp}</CreateTime>"
					"<MsgType><![CDATA[event]]></MsgType><Event><![CDATA[subscribe]]></Event><EventKey><![CDATA[qrscene_{GetPatientQRIDResult}]]></EventKey>"
					"<Ticket><![CDATA[gQHx8DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyLXFwbTVoVXplWTAxVFNHZGhxMVAAAgT23aVaAwQAjScB]]></Ticket></xml>",
					LAST);
		  			
  			lr_end_transaction("Patient Subscribe_Patinet", LR_AUTO);
  			
			lr_convert_string_encoding(lr_eval_string("{HttpResult}"), LR_ENC_UTF8,LR_ENC_SYSTEM_LOCALE, "realMessage");
			lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );		
			
  			
//  	  mysql_free_result(query_result);		

  			
	return 0;
}
