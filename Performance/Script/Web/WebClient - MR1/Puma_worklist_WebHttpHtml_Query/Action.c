Action()
{
	int result;
	
	char Status;
	web_set_max_html_param_len("90000");

	web_url("Platform", 
		"URL=http://10.184.129.108/Platform", 
		"Resource=0", 
		"RecContentType=text/html", 
		"Referer=", 
		"Snapshot=t1.inf", 
		"Mode=HTML", 
		EXTRARES, 
		"Url=/Platform/Content/angular-material.css", ENDITEM, 
		"Url=/Platform/Content/bootstrap.css", ENDITEM, 
		"Url=/Platform/Content/bootstrap-theme.css", ENDITEM, 
		"Url=/Platform/Content/toaster.css", ENDITEM, 
		"Url=/Platform/Content/carestream.css", ENDITEM, 
		"Url=/Platform/app-resources/css/login.css", ENDITEM, 
		"Url=/Platform/Scripts/jquery-1.11.0.js", ENDITEM, 
		"Url=/Platform/Scripts/jquery.validate.js", ENDITEM, 
		"Url=/Platform/Scripts/jquery.validate.unobtrusive.js", ENDITEM, 
		"Url=/Platform/Scripts/modernizr-2.6.2.js", ENDITEM, 
		"Url=/Platform/Scripts/bootstrap.js", ENDITEM, 
		"Url=/Platform/Scripts/respond.js", ENDITEM, 
		"Url=/Platform/Scripts/PDF.js.1.3.91/compatibility.js", ENDITEM, 
		"Url=/Platform/Scripts/PDF.js.1.3.91/pdf.js", ENDITEM, 
		"Url=/Platform/Scripts/PDF.js.1.3.91/pdf.worker.js", ENDITEM, 
		"Url=/Platform/Scripts/PDF.js.1.3.91/text_layer_builder.js", ENDITEM, 
		"Url=/Platform/Scripts/angular.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-ui-router.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-ui/ui-bootstrap.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-ui/ui-bootstrap-tpls.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-cookies.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-animate.min.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-busy.min.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-aria.min.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-material/angular-material.min.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-translate.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-translate-loader-partial.js", ENDITEM, 
		"Url=/Platform/Scripts/ng-file-upload/ng-file-upload.min.js", ENDITEM, 
		"Url=/Platform/Scripts/ui-grid-puma.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-tree-control/angular-tree-control.js", ENDITEM, 
		"Url=/Platform/Scripts/toaster.js", ENDITEM, 
		"Url=/Platform/Scripts/select.min.js", ENDITEM, 
		"Url=/Platform/Scripts/Chart.min.js", ENDITEM, 
		"Url=/Platform/Scripts/jsBarcode/JsBarcode.all.min.js", ENDITEM, 
		"Url=/Platform/Scripts/angular-chart/angular-chart.js", ENDITEM, 
		"Url=/Platform/Scripts/underscore.min.js", ENDITEM, 
		"Url=/Platform/app/common/common.module.js", ENDITEM, 
		"Url=/Platform/app/common/behaviors/checklist-model.js", ENDITEM, 
		"Url=/Platform/app/common/behaviors/drag-sortable.js", ENDITEM, 
		"Url=/Platform/app/common/behaviors/dropdownMenu-changeTitle.js", ENDITEM, 
		"Url=/Platform/app/common/behaviors/focus.js", ENDITEM, 
		"Url=/Platform/app/common/behaviors/notAllowDot.js", ENDITEM, 
		"Url=/Platform/app/common/behaviors/vt-enter.js", ENDITEM, 
		"Url=/Platform/app/common/controls/drag-sortable/Sortable.js", ENDITEM, 
		"Url=/Platform/app/common/controls/puma-confirm/puma-confirm.js", ENDITEM, 
		"Url=/Platform/app/common/controls/puma-delete-button/puma-delete-button.js", ENDITEM, 
		"Url=/Platform/app/common/controls/puma-multi-select/puma-multi-select.js", ENDITEM, 
		"Url=/Platform/app/common/controls/puma-multi-select/puma-multi-select.tpl.js", ENDITEM, 
		"Url=/Platform/app/common/controls/puma-open-dialog/open-dialog.js", ENDITEM, 
		"Url=/Platform/app/common/controls/puma-open-dialog/puma-dialog.js", ENDITEM, 
		"Url=/Platform/app/common/controls/puma-switch/puma-switch.js", ENDITEM, 
		"Url=/Platform/app/common/filters/camel-case-filter.js", ENDITEM, 
		//"Url=/Platform/app/common/filters/new-line-filter.js", ENDITEM, 
		"Url=/Platform/app/common/filters/qclog-event-filter.js", ENDITEM, 
		"Url=/Platform/app/common/utils/base64.js", ENDITEM, 
		"Url=/Platform/app/common/utils/constants.js", ENDITEM, 
		"Url=/Platform/app/common/utils/date.js", ENDITEM, 
		"Url=/Platform/app/common/utils/enum.js", ENDITEM, 
		"Url=/Platform/app/common/utils/ipAddressHandler.js", ENDITEM, 
		"Url=/Platform/app/common/utils/kiosk.util.js", ENDITEM, 
		"Url=/Platform/app/common/utils/loginContext.js", ENDITEM, 
		"Url=/Platform/app/common/utils/permission.js", ENDITEM, 
//		"Url=/Platform/app/common/utils/resouces.js", ENDITEM, 
		"Url=/Platform/app/common/utils/webservices.js", ENDITEM, 
		"Url=/Platform/app/common/webservices/client-tool-svc.js", ENDITEM, 
		"Url=/Platform/app/common/webservices/configuration-svc.js", ENDITEM, 
		"Url=/Platform/app/common/webservices/system-information-svc.js", ENDITEM, 
		"Url=/Platform/app/login/login.js", ENDITEM, 
		"Url=/Platform/app/login/rememberme.js", ENDITEM, 
		LAST);

	web_url("login-view.html", 
		"URL=http://10.184.129.108/Platform/app/login/login-view.html", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/", 
		"Snapshot=t2.inf", 
		"Mode=HTML", 
		EXTRARES, 
		"Url=/Platform/app-resources/i18n/zh-CN/login.json", "Referer=http://10.184.129.108/Platform/", ENDITEM, 
	//	"Url=/Platform/app-resources/images/login/bg_page_logon.jpg", "Referer=http://10.184.129.108/Platform/app-resources/css/login.css", ENDITEM, 
		"Url=/Platform/fonts/icomoon.ttf?my8ecs", "Referer=http://10.184.129.108/Platform/Content/carestream.css", ENDITEM, 
		LAST);

	web_reg_save_param("ApiToken",
		"LB=ApiToken\=",
		"RB= path\=",
		LAST);
	
	web_reg_save_param("AspToken",
		"LB= .AspNet.ApplicationCookie\=",
		"RB=path\=",
		LAST);
	
	web_reg_save_param("access_token",
		"LB=access_token%22%3A%22",
		"RB=%22%2C%22token_typ",
		LAST);

	lr_start_transaction("User_login");

	web_custom_request("login", 
		"URL=http://10.184.129.108/Platform/account/login", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/", 
		"Snapshot=t6.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"loginname\":\"{UserName}\",\"password\":\"123456\"}", 
		LAST);

	web_add_cookie("ApiToken={ApiToken}; DOMAIN=10.184.129.171");
	web_add_cookie(".AspNet.ApplicationCookie={AspToken}; DOMAIN=10.184.129.171");
	
	/*
	web_add_cookie("ApiToken="
		"%7B%22access_token%22%3A%22BQScJKh7ZnqAk8lU34T2zMQOgj34U-BAyk8rr4QdQibzd2MQfVi2Wnrydkqa-hvWzGgJKuNP9A3_hiFBDwdynUVnNYrfQPIZVyJCRagN8pvZWXfIFuso2RkOV9YAibLrlpe9au4faNDuN5lyCS0kQNmpCODnmlqz7Ga9westRlfYpiWHp6tBxthXj0OQdmRDY0zW5bOhhuDNwDlwU1KGFQ%22%2C%22token_type%22%3A%22bearer%22%2C%22expires_in%22%3A604799%2C%22refresh_token%22%3A%22686b5255-0841-41bc-923e-6912f069aec4%22%2C%22userName%22%3A%22{UserName}%22%2C%22currentRole%22%3A%22Administrator%22%2C%22strDepartments%22%3A%22%22%2C%22strModalities%22%3"
		"A%22%22%2C%22onlyReport%22%3A%22false%22%2C%22strUserPermissionList%22%3A%22CentralPrint%3A1%7CChangeHoldFlag%3A1%7CChangePrintMode%3A1%7CChangePrintStatus%3A1%7Cconfig%3A1%7CConfigRole%3A1%7CConfigSystem%3A1%7CConfigUser%3A1%7CCorrectReconciliation%3A1%7CDelete%3A1%7CPrinterMonitor%3A1%7CQCLog%3A1%7CReconciliation%3A1%7CRestoreFilm%3A1%7CStatisticsReport%3A1%7Cworklist%3A1%7C%22%7D; DOMAIN=10.184.129.171");

	web_add_cookie(".AspNet.ApplicationCookie=G6KgnNtcEOowpmitDpWE0_20ypYlAWbXyx7UiNTFT0IPQzStyKFBcDecHTA41PAoeWHAmkD4_7qKIVGPXTE496rORntrVLmrGMXMzQ-GiJ_OIBkLsC2mPBhPg1smCduGM7aAIcNmd-MvP6Dajazl4fe_vFTDq77NToz_XXhWO1JWQ5OhTMp0YEOGKA3oRToIhzltesPTfhY9My521bPUviUu59DNF-W7UguQOeBH5BDBa1Mavo9r0ENbSEKGAi98kCsz_WJ0OtlBWbr0xh9EnUgw_fsh5bcNmEtqG0A9niY47VSdbkc4MaXbcKymxgQH; DOMAIN=10.184.129.171");
*/

	web_url("login_2", 
		"URL=http://10.184.129.108/Platform//account/login", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/", 
		"Snapshot=t7.inf", 
		"Mode=HTML", 
		LAST);

	web_url("workarea", 
		"URL=http://10.184.129.108/Platform/workarea", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/", 
		"Snapshot=t8.inf", 
		"Mode=HTML", 
		EXTRARES, 
		"Url=Content/site.css", ENDITEM, 
		"Url=Content/ui-bootstrap-csp.css", ENDITEM, 
		"Url=app/common/controls/puma-switch/puma-switch.css", ENDITEM, 
		"Url=Content/ui-grid.min.css", ENDITEM, 
		"Url=Scripts/angular-tree-control/tree-control.css", ENDITEM, 
		"Url=Scripts/angular-tree-control/tree-control-attribute.css", ENDITEM, 
		"Url=Content/select.css", ENDITEM, 
		"Url=app-resources/css/site.css", ENDITEM, 
		"Url=app-resources/css/open-dialog.css", ENDITEM, 
		"Url=app-resources/css/terminalmonitor.css", ENDITEM, 
		"Url=app-resources/css/statistics.css", ENDITEM, 
		"Url=app-resources/css/barcode.css", ENDITEM, 
		"Url=app-resources/css/circle.css", ENDITEM, 
		"Url=app-resources/css/worklist.css", ENDITEM, 
		"Url=app-resources/css/adminsettings.css", ENDITEM, 
		"Url=app-resources/css/reconciliation.css", ENDITEM, 
		"Url=Scripts/PDF.js.1.3.91/text_layer_builder.css", ENDITEM, 
		"Url=app/workarea/app.workarea.js", ENDITEM, 
		"Url=app/workarea/module.workarea.js", ENDITEM, 
		//"Url=app/workarea/worklist/controllers/worklist-item-secondlevel-ctrl.js", ENDITEM, 
		"Url=app/workarea/worklist/controllers/worklist-mainbody-ctrl.js", ENDITEM, 
		"Url=app/workarea/worklist/controllers/worklist-view-ctrl.js", ENDITEM, 
		"Url=app/workarea/worklist/views/worklist-view.js", ENDITEM, 
		"Url=app/workarea/reconciliation/controllers/reconciliation-list-ctrl.js", ENDITEM, 
		"Url=app/workarea/terminalmonitor/controllers/terminalmonitor-view-ctrl.js", ENDITEM, 
		"Url=app/workarea/adminsettings/log/controllers/qclog-ctrl.js", ENDITEM, 
		"Url=app/workarea/adminsettings/log/views/qclog-view.js", ENDITEM, 
		"Url=app/workarea/adminsettings/role/controllers/role-settings-ctrl.js", ENDITEM, 
		"Url=app/workarea/adminsettings/system/controllers/systeml-setting-ctr.js", ENDITEM, 
		"Url=app/workarea/adminsettings/user/contorllers/user-settings-ctrl.js", ENDITEM, 
		"Url=app/workarea/statistics/controllers/statistics-ctrl.js", ENDITEM, 
		"Url=app/workarea/webservices/adminsettings-svc.js", ENDITEM, 
		"Url=fonts/icomoon.ttf?g2jea5", "Referer=http://10.184.129.108/Platform/Scripts/angular-tree-control/tree-control.css", ENDITEM, 
		"Url=app/workarea/webservices/qclog-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/reconciliation-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/role-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/statistics-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/terminalmonitor-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/user-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/worklist-svc.js", ENDITEM, 
		"Url=app/workarea/barcode/controllers/barcode-ctrl.js", ENDITEM, 
	//	"Url=app/workarea/dicomviewer/controllers/dicom-viewer-ctrl.js", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/workarea.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/adminsettings.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/barcode.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/dicomviewer.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/reconciliation.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/statistics.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/terminalmonitor.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/worklist.json", ENDITEM, 
		LAST);


 web_add_auto_header("Authorization","bearer {access_token}");
 
	web_reg_save_param("status",
		"LB=",
		"RB=",
		LAST);

	web_url("CheckLoginStatusByUser", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t13.inf", 
		"Mode=HTML", 
		LAST);
	
	
	
	if (strstr(lr_eval_string("{status}"),"true")==0)
	    {
	    	lr_fail_trans_with_error("Login failed");
	    	lr_message("User Login website failed %s",lr_eval_string("{status}"));
	    	lr_message("User Login website failed %d",strstr(lr_eval_string("{status}"),"flase"));
	    	lr_end_transaction("User_login",LR_AUTO);
	    	return 0;
	    };
	    
	if (strstr(lr_eval_string("{status}"),"true")!=0)
	    {
	    	
	    	lr_message("User Login website successfully: %s",lr_eval_string("{status}"));
 
 
	web_url("tableRowsPerPage", 
		"URL=http://10.184.129.108/webapi/api/tableRowsPerPage", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t9.inf", 
		"Mode=HTML", 
		LAST);

	web_url("worklistcolumns", 
		"URL=http://10.184.129.108/webapi/api/worklist/worklistcolumns", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t10.inf", 
		"Mode=HTML", 
		LAST);

//	web_url("incompleteTaskEnabled", 
//		"URL=http://10.184.129.108/webapi/api/systemConfiguration/incompleteTaskEnabled", 
//		"Resource=0", 
//		"Referer=http://10.184.129.108/Platform/workarea", 
//		"Snapshot=t11.inf", 
//		"Mode=HTML", 
//		LAST);

	web_url("systemversion", 
		"URL=http://10.184.129.108/webapi/api/systemversion", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t12.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t13.inf", 
		"Mode=HTML", 
		LAST);
 
 
	web_url("workarea-app-container.html", 
		"URL=http://10.184.129.108/Platform/app/workarea/framework/workarea-app-container.html", 
		"Resource=0", 
		"RecContentType=text/html", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t5.inf", 
		"Mode=HTML", 
		LAST);

	web_url("terminalmonitor-template.html", 
		"URL=http://10.184.129.108/Platform/app/workarea/terminalmonitor/views/terminalmonitor-template.html", 
		"Resource=0", 
		"RecContentType=text/html", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t6.inf", 
		"Mode=HTML", 
		EXTRARES, 
		"Url=/Platform/app-resources/images/terminalmonitor/terminal_0.png", "Referer=http://10.184.129.108/Platform/workarea/terminalmonitor", ENDITEM, 
		"Url=/Platform/app-resources/images/terminalmonitor/terminal_2.png", "Referer=http://10.184.129.108/Platform/workarea/terminalmonitor", ENDITEM, 
		"Url=/Platform/app-resources/images/terminalmonitor/ico_terminal.png", "Referer=http://10.184.129.108/Platform/workarea/terminalmonitor", ENDITEM, 
		"Url=/Platform/app-resources/images/terminalmonitor/ico_fp.png", "Referer=http://10.184.129.108/Platform/workarea/terminalmonitor", ENDITEM, 
		"Url=/Platform/app-resources/images/terminalmonitor/ico_cpp.png", "Referer=http://10.184.129.108/Platform/workarea/terminalmonitor", ENDITEM, 
		"Url=/Platform/app-resources/images/terminalmonitor/ico_bpp.png", "Referer=http://10.184.129.108/Platform/workarea/terminalmonitor", ENDITEM, 
		LAST);
	    	

//	web_url("terminalmonitoring", 
//		"URL=http://10.184.129.108/webapi/api/terminalmonitoring", 
//		"Resource=0", 
//		"Referer=http://10.184.129.108/Platform/workarea", 
//		"Snapshot=t18.inf", 
//		"Mode=HTML", 
//		LAST);

	    	
	web_custom_request("terminalmonitoring",
		"URL=http://10.184.129.108/webapi/api/terminalmonitoring?userId={UserName} ",
		"Method=GET",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Mode=HTML",
		"Body=http://10.184.129.108/Platform/workarea",
		LAST);
	    	
	    	
	    	
	web_url("CheckLoginStatus_5", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t19.inf", 
		"Mode=HTML", 
		EXTRARES, 
		//"Url=/favicon.ico", "Referer=http://10.184.129.108/Platform/workarea/terminalmonitor", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/ico_terminal.png", "Referer=http://10.184.129.108/Platform/app-resources/css/terminalmonitor.css", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/ico_fp.png", "Referer=http://10.184.129.108/Platform/app-resources/css/terminalmonitor.css", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/ico_bpp.png", "Referer=http://10.184.129.108/Platform/app-resources/css/terminalmonitor.css", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/ico_cpp.png", "Referer=http://10.184.129.108/Platform/app-resources/css/terminalmonitor.css", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/terminal_2.png", "Referer=http://10.184.129.108/Platform/workarea/terminalmonitor", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/terminal_0.png", "Referer=http://10.184.129.108/Platform/workarea/terminalmonitor", ENDITEM, 
		LAST);

	lr_end_transaction("User_login",LR_AUTO);
	

	lr_think_time(10);
	
//	/////**************************************************************
//	//// *****************Worklist Query****************
//	//// **************************************************************
	

	
	
	if (strcmp(lr_eval_string( "{WorklistQueryRand}"),"1") == 0){
	
		lr_start_transaction("WorlkList_Query_randomTime");
	
		web_custom_request("searchWorklist_2", 
			"URL=http://10.184.129.108/webapi/api/worklist/searchWorklist", 
			"Method=POST", 
			"Resource=0", 
			"Referer=http://10.184.129.108/Platform/workarea/worklist", 
			"Snapshot=t52.inf", 
			"Mode=HTML", 
			"EncType=application/json;charset=UTF-8", 
			//"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"{RandomDate}-01T00:00:00.193Z\",\"endTime\":\"2020-07-04T23:59:59.193Z\"},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
			"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"{RandomDate}-01T00:00:00.641Z\",\"endTime\":\"2020-07-04T23:59:59.193Z\"},\"shortcutDateRange\":0,\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50}}", 
			
			LAST);
	
		lr_end_transaction("WorlkList_Query_randomTime",LR_AUTO);
		
		web_url("CheckLoginStatus_20", 
			"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
			"Resource=0", 
			"Referer=http://10.184.129.108/Platform/workarea/worklist", 
			"Snapshot=t53.inf", 
			"Mode=HTML", 
			LAST);
	
		lr_think_time(10);
	};
	
if (strcmp(lr_eval_string( "{WorklistQueryRand}"),"2") == 0){	

	lr_start_transaction("Worklist_Query_Today");

	web_custom_request("searchWorklist_3", 
		"URL=http://10.184.129.108/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t55.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		//"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"{DateToday}T00:00:00.263Z\",\"endTime\":\"{DateToday}T23:52:19.263Z\"},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"patientType\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"{DateToday}T00:00:00.263Z\",\"endTime\":\"{DateToday}T23:52:19.263Z\"},\"shortcutDateRange\":0,\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50}}", 
		LAST);

	web_url("CheckLoginStatus", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t56.inf", 
		"Mode=HTML", 
		LAST);

	lr_end_transaction("Worklist_Query_Today",LR_AUTO);

	lr_think_time(10);
	
	web_url("CheckLoginStatus", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t56.inf", 
		"Mode=HTML", 
		LAST);
	};
	
	if (strcmp(lr_eval_string( "{WorklistQueryRand}"),"3") == 0){
		
	lr_save_datetime("%Y-%m-%d", DATE_NOW - (ONE_DAY*2), "LastTwoTime");
	lr_log_message("The Time is %s", lr_eval_string("{LastTwoTime}"));

	lr_start_transaction("worklist_query_LastTwoToday");

	web_custom_request("searchWorklist_4", 
		"URL=http://10.184.129.108/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t57.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		//"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"{LastTwoTime}T00:00:00.649Z\",\"endTime\":\"{DateToday}T23:59:59.649Z\"},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"patientType\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"{LastTwoTime}T00:00:00.649Z\",\"endTime\":\"{DateToday}T23:59:59.649Z\"},\"shortcutDateRange\":0,\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50}}", 
		LAST);

	lr_end_transaction("worklist_query_LastTwoToday",LR_AUTO);
	
	lr_think_time(10);

	web_url("CheckLoginStatus_22", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t58.inf", 
		"Mode=HTML", 
		LAST);
	};
	
	if (strcmp(lr_eval_string( "{WorklistQueryRand}"),"4") == 0){
	
	lr_save_datetime("%Y-%m-%d", DATE_NOW - (ONE_DAY*7), "Lastweek");
	lr_log_message("The Time is %s", lr_eval_string("{Lastweek}"));

	lr_think_time(10);

	lr_start_transaction("worklist_query_Lastweek");

	web_custom_request("searchWorklist_5", 
		"URL=http://10.184.129.108/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t59.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		//"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"{Lastweek}T00:00:00.522Z\",\"endTime\":\"{DateToday}T23:59:59.522Z\"},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"patientType\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"{Lastweek}T00:00:00.522Z\",\"endTime\":\"{DateToday}T23:59:59.522Z\"},\"shortcutDateRange\":0,\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50}}", 
		LAST);

	lr_end_transaction("worklist_query_Lastweek",LR_AUTO);
	
	
	web_url("CheckLoginStatus", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t56.inf", 
		"Mode=HTML", 
		LAST);
	
	lr_think_time(10);
	};
	
	
	if (strcmp(lr_eval_string( "{WorklistQueryRand}"),"5") == 0){
	
	lr_save_datetime("%Y-%m-%d", DATE_NOW - (ONE_DAY*31), "LastMonth");
	lr_log_message("The Time is %s", lr_eval_string("{LastMonth}"));
	
	lr_start_transaction("worklist_query_LastMonth");

	web_custom_request("searchWorklist_6", 
		"URL=http://10.184.129.108/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t61.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		//"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"{LastMonth}T00:00:00.073Z\",\"endTime\":\"{DateToday}T23:59:59.073Z\"},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"patientType\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"{LastMonth}T00:00:00.073Z\",\"endTime\":\"{DateToday}T23:59:59.073Z\"},\"shortcutDateRange\":0,\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50}}", 
		LAST);

	lr_end_transaction("worklist_query_LastMonth",LR_AUTO);
	
	lr_think_time(10);
		
	web_url("CheckLoginStatus_24", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t62.inf", 
		"Mode=HTML", 
		LAST);

	lr_think_time(10);
	};
	
	if (strcmp(lr_eval_string( "{WorklistQueryRand}"),"6") == 0){

	lr_start_transaction("worklist_query_Patient_PID");

	web_custom_request("searchWorklist_7", 
		"URL=http://10.184.129.108/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t63.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		//"Body={\"patientName\":null,\"patientID\":\"{Patient_PID}\",\"accessionNumber\":null,\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		"Body={\"patientName\":null,\"patientID\":\"{Patient_PID}\",\"accessionNumber\":null,\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"shortcutDateRange\":0,\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50}}", 
		LAST);

	lr_end_transaction("worklist_query_Patient_PID",LR_AUTO);

	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		LAST);

	lr_think_time(10);
	
	
	};
	
	
	if (strcmp(lr_eval_string( "{WorklistQueryRand}"),"7") == 0){
	lr_start_transaction("worklist_query_Patient_PatientName");

	web_custom_request("worklist_query_Patient_PatientName", 
		"URL=http://10.184.129.108/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t63.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		//"Body={\"patientName\":\"{PatientName}\",\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50}}",
		"Body={\"patientName\":\"{PatientName}\",\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"shortcutDateRange\":0,\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50}}", 
		LAST);

	lr_end_transaction("worklist_query_Patient_PatientName",LR_AUTO);

	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		LAST);

	lr_think_time(10);
	

	};
	
	if (strcmp(lr_eval_string( "{WorklistQueryRand}"),"8") == 0){

	lr_start_transaction("worklist_query_ACC");

	web_custom_request("searchWorklist_8", 
		"URL=http://10.184.129.108/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t65.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		//"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":\"{Patient_ACCN}\",\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":\"{Patient_ACCN}\",\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"shortcutDateRange\":0,\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50}}", 
		LAST);

	lr_end_transaction("worklist_query_ACC",LR_AUTO);
	
	web_url("CheckLoginStatus_26", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t66.inf", 
		"Mode=HTML", 
		LAST);
	
	
	lr_think_time(10);
	
	};
	
	
//	lr_think_time(10);



//	////////////////////////////////////
//	///////Query all and get next page//
//	///////////////////////////////////
//	
//if (strcmp(lr_eval_string( "{QueryAllRand}"),"1") == 0){
//	lr_start_transaction("Query ALL");
//
//		web_custom_request("searchWorklist", 
//		"URL=http://10.184.129.108/webapi/api/worklist/searchWorklist", 
//		"Method=POST", 
//		"Resource=0", 
//		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
//		"Snapshot=t44.inf", 
//		"Mode=HTML", 
//		"EncType=application/json;charset=UTF-8", 
//		//"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
//		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"shortcutDateRange\":\"\",\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50}}", 
//		LAST);
//	lr_end_transaction("Query ALL", LR_AUTO);
//
//	
//	lr_think_time(10);
//	
//	web_url("CheckLoginStatus_25", 
//		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
//		"Resource=0", 
//		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
//		"Snapshot=t64.inf", 
//		"Mode=HTML", 
//		LAST);	
//	
//	lr_start_transaction("Query ALL_secondPage");
//		web_custom_request("searchWorklist", 
//		"URL=http://10.184.129.108/webapi/api/worklist/searchWorklist", 
//		"Method=POST", 
//		"Resource=0", 
//		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
//		"Snapshot=t44.inf", 
//		"Mode=HTML", 
//		"EncType=application/json;charset=UTF-8", 
//		//"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":2,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
//		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"shortcutDateRange\":\"\",\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":2,\"pageSize\":50}}", 
//		LAST);
//	lr_end_transaction("Query ALL_secondPage", LR_AUTO);
//
//	web_url("CheckLoginStatus_25", 
//		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
//		"Resource=0", 
//		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
//		"Snapshot=t64.inf", 
//		"Mode=HTML", 
//		LAST);
//
//	
//	lr_think_time(10);
//
//	lr_start_transaction("Query ALL_ThirdPage");
//		web_custom_request("searchWorklist", 
//		"URL=http://10.184.129.108/webapi/api/worklist/searchWorklist", 
//		"Method=POST", 
//		"Resource=0", 
//		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
//		"Snapshot=t44.inf", 
//		"Mode=HTML", 
//		"EncType=application/json;charset=UTF-8", 
//		//"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":3,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
//		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"shortcutDateRange\":\"\",\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":3,\"pageSize\":50}}", 
//		LAST);
//	
//	lr_end_transaction("Query ALL_ThirdPage", LR_AUTO);
//
//	
//	lr_think_time(10);
//
//	web_url("CheckLoginStatus_25", 
//		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
//		"Resource=0", 
//		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
//		"Snapshot=t64.inf", 
//		"Mode=HTML", 
//		LAST);	
//};

};
	
	return 0;
}