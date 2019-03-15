PUMA_examreservation()
{
		char *str;
		char *old=".";
		char *newchar="";
		char *dest;
		int LoopNumber;
		int i;
		char temp[200];
		int ExecuteRand;
	
		/**************************************************************************/
		/********Get currentdateTime with millisecond, make it to variable. ***/
		/********The Patient examid, patientid and accession number can use it.********/
		/**************************************************************************/
	
		str=lr_eval_string("{CurrentDateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"strCurrentDateTime");
		//lr_output_message("%s",lr_eval_string("{strCurrentDateTime}"));
		
		
		LoopNumber = atoi(lr_eval_string("{RandForLoop}"));
		//lr_output_message("%d",LoopNumber);
		
		ExecuteRand = atoi(lr_eval_string("{RandForExecute}"));
		
		/*********************************************************************************************/
		/*****************Create ExamReservation             ************/
		/*********************************************************************************************/
		for(i = 1 ; i <= LoopNumber; i++)
		{
				lr_save_int(i, "EndNumber");	
				lr_save_datetime("%Y-%m-%dT%H:%M:%S", DATE_NOW + (ONE_DAY*1), "ExamReservationBegin");

				
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
				
				lr_end_transaction("Create ExamReservation", LR_AUTO);

	}

		
		
		
		lr_think_time(1);
		
		
		
		
		
		/*********************************************************************************************/
		/*****************Update the ExamReservation            ************/
		/*********************************************************************************************/

		if(ExecuteRand == 1)
		{
			for(i = 1 ; i <= LoopNumber; i++)
			{
					lr_save_int(i, "EndNumber");
					lr_save_datetime("%Y-%m-%dT%H:%M:%S", DATE_NOW + (ONE_DAY*1) + (ONE_HOUR*6), "ExamReservationBegin");
					
					
					lr_start_transaction("Update ExamReservation");
	
					web_custom_request("Update_ExamReservation",
					"URL=http://10.184.129.203/CenterInfoServer/CenterPrintService.asmx ",
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
					
					lr_end_transaction("Update ExamReservation", LR_AUTO);
	
	
			}	
		}
	return 0;
}
