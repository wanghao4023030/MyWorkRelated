PUMA_Film()
{
		char *str;
		char *old=".";
		char *newchar="";
		char *dest;
		int LoopNumber;
		int i;
		char temp[200];
	
		/**************************************************************************/
		/********Get currentdateTime with millisecond, make it to variable. ***/
		/********The Patient examid, patientid and accession number can use it.********/
		/**************************************************************************/
	
		str=lr_eval_string("{CurrentDateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"strCurrentDateTime");
		//lr_output_message("%s",lr_eval_string("{strCurrentDateTime}"));
		
		
		LoopNumber = atoi(lr_eval_string("{RandForLoop}"));
		//lr_output_message("%d",LoopNumber);
		
		
		/*********************************************************************************************/
		/*****************Create Film             ************/
		/*********************************************************************************************/
		
		lr_convert_string_encoding("您胶片已经准备好，但是报告尚未审核。请到自助终端打印！",LR_ENC_SYSTEM_LOCALE, LR_ENC_UTF8, "strMessage");
		strcpy(temp,lr_eval_string("{strMessage}"));
		lr_save_string(temp,"strMessageUTF8");
		

		
		for(i = 1 ; i <= LoopNumber; i++)
		{
				lr_save_int(i, "EndNumber");
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
				
				lr_end_transaction("Create Film", LR_AUTO);

		
		}
		
		
		
		
		lr_think_time(1);
		
		
		
		
		
		/*********************************************************************************************/
		/*****************Update the Film status to printed            ************/
		/*********************************************************************************************/
		
		lr_convert_string_encoding("您胶片已经打印，谢谢！",LR_ENC_SYSTEM_LOCALE, LR_ENC_UTF8, "strMessage");
		strcpy(temp,lr_eval_string("{strMessage}"));
		lr_save_string(temp,"strMessageUTF8");
		
		
		
		for(i = 1 ; i <= LoopNumber; i++)
		{
				lr_save_int(i, "EndNumber");
				
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
				
				lr_end_transaction("Update Film", LR_AUTO);


		}	



	
	return 0;
}
