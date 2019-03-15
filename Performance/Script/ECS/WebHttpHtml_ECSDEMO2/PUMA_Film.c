PUMA_Film()
{
	
		/************************************************************************************************/
		//This script is to simulate the PS server Synchronize report and film information to CS server	//
		//Send the http request to web server "SynchronizeInfo".										//
		//Create by Ralf Wang 2018-03-09																//
		/************************************************************************************************/
	
		char *str;
		char *old=".";
		char *newchar="";
		char *dest;
		int LoopNumber;
		int i;
		char temp[200];
		int HTTP_RC;
	
		/**************************************************************************/
		/********Get currentdateTime with millisecond, make it to variable. ***/
		/********The Patient examid, patientid and accession number can use it.********/
		/**************************************************************************/

		//Get current datetime with millisecond with LR parameter and Remove character "."		
		str=lr_eval_string("{CurrentDateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"strCurrentDateTime");
		//lr_output_message("%s",lr_eval_string("{strCurrentDateTime}"));
		
		//Get random number and use it for "for loop"		
		LoopNumber = atoi(lr_eval_string("{RandForLoop}"));
		//lr_output_message("%d",LoopNumber);

		/*********************************************************************************************/
		/*****************Create Film             ************/
		/*********************************************************************************************/
		
		//Set the message varchar and convert it to UTF-8 type
		lr_convert_string_encoding("您胶片已经准备好，但是报告尚未审核。请到自助终端打印！",LR_ENC_SYSTEM_LOCALE, LR_ENC_UTF8, "strMessage");
		strcpy(temp,lr_eval_string("{strMessage}"));
		lr_save_string(temp,"strMessageUTF8");

		//Begin loop to send request
		for(i = 1 ; i <= LoopNumber; i++)
		{
				lr_save_int(i, "EndNumber");
				
				web_reg_save_param("HttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	LAST);
				
				lr_start_transaction("Create Film");

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
						"<json_input>{\"RowError\":\"\",\"RowState\":16,\"Table\":[{\"ExamID\":\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"PatientID\":\"P{strCurrentDateTime}{HospitalID}\",\"PatientName\":\"N{strCurrentDateTime}{HospitalID}\",\"PatientType\":\"3\",\"Modality\":\"{ExamModalityType}\",\"StatusID\":241,\"StatusMessage\":\"{strMessageUTF8}\",\"ExamCreateTime\":\"{ExamCreateTime}\",\"StatusCreateTime\":\"{StatusCreateTime}\",\"StatusUpdateTime\":null,\"PrintTime\":null,\"FilmCount\":1,\"ReportCount\":0,\"ActionID\":0,\"PrintLocation\":\"\",\"HospitalID\":\"{HospitalID}\"}],"
						"\"ItemArray\":[\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"P{strCurrentDateTime}{HospitalID}\",\"N{strCurrentDateTime}{HospitalID}\",\"3\",\"{ItemModalityType}\",241,\"{strMessageUTF8}\",\"{ExamCreateTime}\",\"{StatusCreateTime}\",null,null,1,1,0,\"\",\"{HospitalID}\"],\"HasErrors\":false}</json_input></SynchronizeInfo></soap:Body></soap:Envelope>",
						LAST);	
						
						// Get the http response status and check the value.
						HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
		
						if(HTTP_RC !=200)
						{
							lr_fail_trans_with_error("PS Synchronize create Film failed. The http return code is %d", HTTP_RC);
						}
						
						//Get the http response result and check the final value.
						if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
						{
							lr_fail_trans_with_error("PS Synchronize Create film failed. The http response content is not true!");
						}
			
				lr_end_transaction("Create Film", LR_AUTO);
		
		}
		

		lr_think_time(1);
		
		/*********************************************************************************************/
		/*****************Update the Film status to printed  *****************************************/
		/*********************************************************************************************/
		
		//Set the message varchar and convert it to UTF-8 type
		lr_convert_string_encoding("您胶片已经打印，谢谢！",LR_ENC_SYSTEM_LOCALE, LR_ENC_UTF8, "strMessage");
		strcpy(temp,lr_eval_string("{strMessage}"));
		lr_save_string(temp,"strMessageUTF8");
		
		//Begin loop to send request
		for(i = 1 ; i <= LoopNumber; i++)
		{
				lr_save_int(i, "EndNumber");
				
				web_reg_save_param("HttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	LAST);
				
				lr_start_transaction("Update Film");

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
						"<json_input>{\"RowError\":\"\",\"RowState\":16,\"Table\":[{\"ExamID\":\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"PatientID\":\"P{strCurrentDateTime}{HospitalID}\",\"PatientName\":\"N{strCurrentDateTime}{HospitalID}\",\"PatientType\":\"3\",\"Modality\":\"{ExamModalityType}\",\"StatusID\":247,\"StatusMessage\":\"{strMessageUTF8}\",\"ExamCreateTime\":\"{ExamCreateTime}\",\"StatusCreateTime\":\"{StatusCreateTime}\",\"StatusUpdateTime\":\"{StatusUpdateTime}\",\"PrintTime\":\"{PrintTime}\",\"FilmCount\":0,\"ReportCount\":1,\"ActionID\":0,\"PrintLocation\":\"\",\"HospitalID\":\"{HospitalID}\"}],\""
						"ItemArray\":[\"E{strCurrentDateTime}{EndNumber}{HospitalID}\",\"P{strCurrentDateTime}{HospitalID}\",\"N{strCurrentDateTime}{HospitalID}\",\"3\",\"{ItemModalityType}\",247,\"{strMessageUTF8}\",\"{ExamCreateTime}\",\"{StatusCreateTime}\",\"{StatusUpdateTime}\",\"{PrintTime}\",0,1,0,\"\",\"{HospitalID}\"],\"HasErrors\":false}</json_input></SynchronizeInfo></s:Body></s:Envelope>",
						LAST);
						
						// Get the http response status and check the value.
						HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
		
						if(HTTP_RC !=200)
						{
							lr_fail_trans_with_error("PS Synchronize Update film failed. The http return code is %d", HTTP_RC);
						}
						
						//Get the http response result and check the final value.
						if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
						{
							lr_fail_trans_with_error("PS Synchronize update film failed. The http response content is not true!");
						}
				
				
				lr_end_transaction("Update Film", LR_AUTO);

		}	

	return 0;
}
