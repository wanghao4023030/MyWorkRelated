PUMA_examreservation()
{
		/************************************************************************************************/
		//This script is to simulate the PS server Synchronize Reservation information to CS server	//
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
		int ExecuteRand;
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
		
		//Get random number and use it for "Update reservation" transaction.
		ExecuteRand = atoi(lr_eval_string("{RandForExecute}"));
		
		/*********************************************************************************************/
		/*****************************************Create ExamReservation******************************/
		/*********************************************************************************************/
		
		//Begin loop to send request
		for(i = 1 ; i <= LoopNumber; i++)
		{
				lr_save_int(i, "EndNumber");
				
				//Set the reservation exam date is tomorrow. plus one day.			
				lr_save_datetime("%Y-%m-%dT%H:%M:%S", DATE_NOW + (ONE_DAY*1), "ExamReservationBegin");

				web_reg_save_param("HttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	LAST);
				
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
							lr_fail_trans_with_error("PS Synchronize create Reservation failed. The http return code is %d", HTTP_RC);
						}
						
						//Get the http response result and check the final value.
						if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
						{
							lr_fail_trans_with_error("PS Synchronize Create Reservation failed. The http response content is not true!");
						}
				
				lr_end_transaction("Create ExamReservation", LR_AUTO);

	}


		lr_think_time(1);
		
		/*********************************************************************************************/
		/***************************Update the ExamReservation ***************************************/
		/*********************************************************************************************/

		//If the random number is 1, simualte the Resevervation update operation.
		if(ExecuteRand == 1)
		{
			for(i = 1 ; i <= LoopNumber; i++)
			{
					lr_save_int(i, "EndNumber");
					
					//Set the update date time to tomorrow and plus 6 hours.
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
							
							// Get the http response status and check the value.
							HTTP_RC = web_get_int_property(HTTP_INFO_RETURN_CODE);
			
							if(HTTP_RC !=200)
							{
								lr_fail_trans_with_error("PS Synchronize update Reservation failed. The http return code is %d", HTTP_RC);
							}
							
							//Get the http response result and check the final value.
							if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
							{
								lr_fail_trans_with_error("PS Synchronize Update Reservation failed. The http response content is not true!");
							}
					
					lr_end_transaction("Update ExamReservation", LR_AUTO);

			}
		}
		
	return 0;
}
