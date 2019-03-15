Action()
{

	web_url("Platform", 
		"URL=http://10.184.129.208/Platform", 
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
		"Url=/Platform/app/common/filters/new-line-filter.js", ENDITEM, 
		"Url=/Platform/app/common/filters/qclog-event-filter.js", ENDITEM, 
		"Url=/Platform/app/common/utils/base64.js", ENDITEM, 
		"Url=/Platform/app/common/utils/constants.js", ENDITEM, 
		"Url=/Platform/app/common/utils/date.js", ENDITEM, 
		"Url=/Platform/app/common/utils/enum.js", ENDITEM, 
		"Url=/Platform/app/common/utils/ipAddressHandler.js", ENDITEM, 
		"Url=/Platform/app/common/utils/kiosk.util.js", ENDITEM, 
		"Url=/Platform/app/common/utils/loginContext.js", ENDITEM, 
		"Url=/Platform/app/common/utils/permission.js", ENDITEM, 
		"Url=/Platform/app/common/utils/resouces.js", ENDITEM, 
		"Url=/Platform/app/common/utils/webservices.js", ENDITEM, 
		"Url=/Platform/app/common/webservices/client-tool-svc.js", ENDITEM, 
		"Url=/Platform/app/common/webservices/configuration-svc.js", ENDITEM, 
		"Url=/Platform/app/common/webservices/system-information-svc.js", ENDITEM, 
		"Url=/Platform/app/login/login.js", ENDITEM, 
		"Url=/Platform/app/login/rememberme.js", ENDITEM, 
		LAST);

	web_url("login-view.html", 
		"URL=http://10.184.129.208/Platform/app/login/login-view.html", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/", 
		"Snapshot=t2.inf", 
		"Mode=HTML", 
		EXTRARES, 
		"Url=/Platform/app-resources/i18n/zh-CN/login.json", "Referer=http://10.184.129.208/Platform/", ENDITEM, 
		"Url=/Platform/app-resources/images/login/bg_page_logon.jpg", "Referer=http://10.184.129.208/Platform/app-resources/css/login.css", ENDITEM, 
		"Url=/Platform/fonts/icomoon.ttf?my8ecs", "Referer=http://10.184.129.208/Platform/Content/carestream.css", ENDITEM, 
		LAST);

	web_custom_request("bczuxasajur", 
		"URL=http://bczuxasajur/", 
		"Method=HEAD", 
		"Resource=0", 
		"Referer=", 
		"Snapshot=t3.inf", 
		"Mode=HTML", 
		LAST);

	web_custom_request("fbyuwbfkxhsvaz", 
		"URL=http://fbyuwbfkxhsvaz/", 
		"Method=HEAD", 
		"Resource=0", 
		"Referer=", 
		"Snapshot=t4.inf", 
		"Mode=HTML", 
		LAST);

	web_custom_request("wnrnotlql", 
		"URL=http://wnrnotlql/", 
		"Method=HEAD", 
		"Resource=0", 
		"Referer=", 
		"Snapshot=t5.inf", 
		"Mode=HTML", 
		LAST);

	lr_start_transaction("User_login");

	web_custom_request("login", 
		"URL=http://10.184.129.208/Platform/account/login", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/", 
		"Snapshot=t6.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"loginname\":\"Test1\",\"password\":\"123456\"}", 
		LAST);

	web_add_cookie("ApiToken="
		"%7B%22access_token%22%3A%22BQScJKh7ZnqAk8lU34T2zMQOgj34U-BAyk8rr4QdQibzd2MQfVi2Wnrydkqa-hvWzGgJKuNP9A3_hiFBDwdynUVnNYrfQPIZVyJCRagN8pvZWXfIFuso2RkOV9YAibLrlpe9au4faNDuN5lyCS0kQNmpCODnmlqz7Ga9westRlfYpiWHp6tBxthXj0OQdmRDY0zW5bOhhuDNwDlwU1KGFQ%22%2C%22token_type%22%3A%22bearer%22%2C%22expires_in%22%3A604799%2C%22refresh_token%22%3A%22686b5255-0841-41bc-923e-6912f069aec4%22%2C%22userName%22%3A%22Test1%22%2C%22currentRole%22%3A%22Administrator%22%2C%22strDepartments%22%3A%22%22%2C%22strModalities%22%3"
		"A%22%22%2C%22onlyReport%22%3A%22false%22%2C%22strUserPermissionList%22%3A%22CentralPrint%3A1%7CChangeHoldFlag%3A1%7CChangePrintMode%3A1%7CChangePrintStatus%3A1%7Cconfig%3A1%7CConfigRole%3A1%7CConfigSystem%3A1%7CConfigUser%3A1%7CCorrectReconciliation%3A1%7CDelete%3A1%7CPrinterMonitor%3A1%7CQCLog%3A1%7CReconciliation%3A1%7CRestoreFilm%3A1%7CStatisticsReport%3A1%7Cworklist%3A1%7C%22%7D; DOMAIN=10.184.129.208");

	web_add_cookie(".AspNet.ApplicationCookie=G6KgnNtcEOowpmitDpWE0_20ypYlAWbXyx7UiNTFT0IPQzStyKFBcDecHTA41PAoeWHAmkD4_7qKIVGPXTE496rORntrVLmrGMXMzQ-GiJ_OIBkLsC2mPBhPg1smCduGM7aAIcNmd-MvP6Dajazl4fe_vFTDq77NToz_XXhWO1JWQ5OhTMp0YEOGKA3oRToIhzltesPTfhY9My521bPUviUu59DNF-W7UguQOeBH5BDBa1Mavo9r0ENbSEKGAi98kCsz_WJ0OtlBWbr0xh9EnUgw_fsh5bcNmEtqG0A9niY47VSdbkc4MaXbcKymxgQH; DOMAIN=10.184.129.208");

	web_url("login_2", 
		"URL=http://10.184.129.208/Platform//account/login", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/", 
		"Snapshot=t7.inf", 
		"Mode=HTML", 
		LAST);

	web_url("workarea", 
		"URL=http://10.184.129.208/Platform/workarea", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/", 
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
		"Url=app/workarea/worklist/controllers/worklist-item-secondlevel-ctrl.js", ENDITEM, 
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
		"Url=fonts/icomoon.ttf?g2jea5", "Referer=http://10.184.129.208/Platform/Scripts/angular-tree-control/tree-control.css", ENDITEM, 
		"Url=app/workarea/webservices/qclog-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/reconciliation-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/role-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/statistics-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/terminalmonitor-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/user-svc.js", ENDITEM, 
		"Url=app/workarea/webservices/worklist-svc.js", ENDITEM, 
		"Url=app/workarea/barcode/controllers/barcode-ctrl.js", ENDITEM, 
		"Url=app/workarea/dicomviewer/controllers/dicom-viewer-ctrl.js", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/workarea.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/adminsettings.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/barcode.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/dicomviewer.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/reconciliation.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/statistics.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/terminalmonitor.json", ENDITEM, 
		"Url=app-resources/i18n/zh-CN/worklist.json", ENDITEM, 
		LAST);

	web_url("tableRowsPerPage", 
		"URL=http://10.184.129.208/webapi/api/tableRowsPerPage", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea", 
		"Snapshot=t9.inf", 
		"Mode=HTML", 
		LAST);

	web_url("worklistcolumns", 
		"URL=http://10.184.129.208/webapi/api/worklist/worklistcolumns", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea", 
		"Snapshot=t10.inf", 
		"Mode=HTML", 
		LAST);

	web_url("incompleteTaskEnabled", 
		"URL=http://10.184.129.208/webapi/api/systemConfiguration/incompleteTaskEnabled", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea", 
		"Snapshot=t11.inf", 
		"Mode=HTML", 
		LAST);

	web_url("systemversion", 
		"URL=http://10.184.129.208/webapi/api/systemversion", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea", 
		"Snapshot=t12.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea", 
		"Snapshot=t13.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_2", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea", 
		"Snapshot=t14.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_3", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea", 
		"Snapshot=t15.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_4", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea", 
		"Snapshot=t16.inf", 
		"Mode=HTML", 
		LAST);

	web_url("terminalmonitor-template.html", 
		"URL=http://10.184.129.208/Platform/app/workarea/terminalmonitor/views/terminalmonitor-template.html", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea", 
		"Snapshot=t17.inf", 
		"Mode=HTML", 
		EXTRARES, 
		"Url=/Platform/fonts/glyphicons-halflings-regular.woff2", "Referer=http://10.184.129.208/Platform/Content/bootstrap.css", ENDITEM, 
		LAST);

	web_url("terminalmonitoring", 
		"URL=http://10.184.129.208/webapi/api/terminalmonitoring", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea", 
		"Snapshot=t18.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_5", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea", 
		"Snapshot=t19.inf", 
		"Mode=HTML", 
		EXTRARES, 
		"Url=/favicon.ico", "Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/ico_terminal.png", "Referer=http://10.184.129.208/Platform/app-resources/css/terminalmonitor.css", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/ico_fp.png", "Referer=http://10.184.129.208/Platform/app-resources/css/terminalmonitor.css", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/ico_bpp.png", "Referer=http://10.184.129.208/Platform/app-resources/css/terminalmonitor.css", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/ico_cpp.png", "Referer=http://10.184.129.208/Platform/app-resources/css/terminalmonitor.css", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/terminal_2.png", "Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", ENDITEM, 
		"Url=../app-resources/images/terminalmonitor/terminal_0.png", "Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", ENDITEM, 
		LAST);

	lr_end_transaction("User_login",LR_AUTO);

	lr_think_time(5);

	web_url("reconciliation-list.html", 
		"URL=http://10.184.129.208/Platform/app/workarea/reconciliation/views/reconciliation-list.html", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", 
		"Snapshot=t20.inf", 
		"Mode=HTML", 
		LAST);

	web_url("getUnmatchImages", 
		"URL=http://10.184.129.208/webapi/api/reconciliation/getUnmatchImages?days=1", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", 
		"Snapshot=t21.inf", 
		"Mode=HTML", 
		LAST);

	web_url("allTerminals", 
		"URL=http://10.184.129.208/webapi/api/terminal/allTerminals", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", 
		"Snapshot=t22.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_6", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", 
		"Snapshot=t23.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_7", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", 
		"Snapshot=t24.inf", 
		"Mode=HTML", 
		EXTRARES, 
		"Url=../app-resources/Images/PS_Button/ico_toolbar_1x_selected.png", "Referer=http://10.184.129.208/Platform/app-resources/css/reconciliation.css", ENDITEM, 
		"Url=../app-resources/Images/PS_Button/ico_toolbar_2x.png", "Referer=http://10.184.129.208/Platform/app-resources/css/reconciliation.css", ENDITEM, 
		"Url=../app-resources/Images/PS_Button/ico_toolbar_fit.png", "Referer=http://10.184.129.208/Platform/app-resources/css/reconciliation.css", ENDITEM, 
		"Url=../app-resources/Images/PS_Button/Spliter.png", "Referer=http://10.184.129.208/Platform/app-resources/css/reconciliation.css", ENDITEM, 
		"Url=../app-resources/Images/PS_Button/ico_toolbar_fitTL_selected.png", "Referer=http://10.184.129.208/Platform/app-resources/css/reconciliation.css", ENDITEM, 
		"Url=../app-resources/Images/PS_Button/ico_toolbar_fitTR.png", "Referer=http://10.184.129.208/Platform/app-resources/css/reconciliation.css", ENDITEM, 
		"Url=../app-resources/Images/PS_Button/ico_toolbar_fitBL.png", "Referer=http://10.184.129.208/Platform/app-resources/css/reconciliation.css", ENDITEM, 
		"Url=../app-resources/Images/PS_Button/ico_toolbar_fitBR.png", "Referer=http://10.184.129.208/Platform/app-resources/css/reconciliation.css", ENDITEM, 
		"Url=../app-resources/Images/PS_Button/ico_upArrow.png", "Referer=http://10.184.129.208/Platform/app-resources/css/reconciliation.css", ENDITEM, 
		"Url=../app-resources/Images/PS_Button/ico_downArrow.png", "Referer=http://10.184.129.208/Platform/app-resources/css/reconciliation.css", ENDITEM, 
		"Url=//ImageSuite/RPTCache/t_1.2.840.113564.86.3.0.41.20170703162613.649.34448_1.jpg", "Referer=http://10.184.129.208/Platform/workarea/reconciliation", ENDITEM, 
		"Url=//ImageSuite/RPTCache/1.2.840.113564.86.3.0.41.20170703162613.649.34448_1.jpg", "Referer=http://10.184.129.208/Platform/workarea/reconciliation", ENDITEM, 
		LAST);

	lr_start_transaction("Terminal_monitor");

	web_url("terminalmonitoring_2", 
		"URL=http://10.184.129.208/webapi/api/terminalmonitoring", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t25.inf", 
		"Mode=HTML", 
		LAST);

	lr_end_transaction("Terminal_monitor",LR_AUTO);

	web_url("CheckLoginStatus_8", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t26.inf", 
		"Mode=HTML", 
		LAST);

	web_url("getUnmatchImages_2", 
		"URL=http://10.184.129.208/webapi/api/reconciliation/getUnmatchImages?days=1", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", 
		"Snapshot=t27.inf", 
		"Mode=HTML", 
		LAST);

	web_url("allTerminals_2", 
		"URL=http://10.184.129.208/webapi/api/terminal/allTerminals", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", 
		"Snapshot=t28.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_9", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", 
		"Snapshot=t29.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_10", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/terminalmonitor", 
		"Snapshot=t30.inf", 
		"Mode=HTML", 
		EXTRARES, 
		"Url=../app-resources/Images/PS_Button/ico_toolbar_2x_hover.png", "Referer=http://10.184.129.208/Platform/app-resources/css/reconciliation.css", ENDITEM, 
		LAST);

	lr_start_transaction("Reconlication_Film_all");

	web_url("getUnmatchImages_3", 
		"URL=http://10.184.129.208/webapi/api/reconciliation/getUnmatchImages?days=-1", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t31.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_11", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t32.inf", 
		"Mode=HTML", 
		LAST);

	lr_end_transaction("Reconlication_Film_all",LR_AUTO);

	web_url("getUnmatchReports", 
		"URL=http://10.184.129.208/webapi/api/reconciliation/getUnmatchReports?days=-1", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t33.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_12", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t34.inf", 
		"Mode=HTML", 
		LAST);

	web_url("getReport", 
		"URL=http://10.184.129.208/webapi/api/reconciliation/getReport?id=5BC8EF8589001F02268C14ED825EB276", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t35.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_13", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t36.inf", 
		"Mode=HTML", 
		LAST);

	lr_start_transaction("reconlication_report_all");

	lr_end_transaction("reconlication_report_all",LR_AUTO);

	web_url("worklist-template.html", 
		"URL=http://10.184.129.208/Platform/app/workarea/worklist/views/worklist-template.html", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t37.inf", 
		"Mode=HTML", 
		LAST);

	web_url("worklist-mainbody.html", 
		"URL=http://10.184.129.208/Platform/app/workarea/worklist/views/worklist-mainbody.html", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t38.inf", 
		"Mode=HTML", 
		LAST);

	web_url("shortcuts", 
		"URL=http://10.184.129.208/webapi/api/worklist/shortcuts?roleName=Administrator&userName=Test1", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t39.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_14", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t40.inf", 
		"Mode=HTML", 
		LAST);

	web_url("shortcuts_2", 
		"URL=http://10.184.129.208/webapi/api/worklist/shortcuts?roleName=Administrator&userName=Test1", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t41.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_15", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/reconciliation", 
		"Snapshot=t42.inf", 
		"Mode=HTML", 
		LAST);

	web_url("allTerminals_3", 
		"URL=http://10.184.129.208/webapi/api/terminal/allTerminals", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t43.inf", 
		"Mode=HTML", 
		LAST);

	web_custom_request("searchWorklist", 
		"URL=http://10.184.129.208/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t44.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"2017-07-04T21:27:11.193Z\",\"endTime\":\"2017-07-04T21:27:11.193Z\"},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		LAST);

	web_url("modalityTypes", 
		"URL=http://10.184.129.208/webapi/api/modality/modalityTypes", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t45.inf", 
		"Mode=HTML", 
		LAST);

	web_custom_request("departmentsByIds", 
		"URL=http://10.184.129.208/webapi/api/department/departmentsByIds", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t46.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body=[]", 
		LAST);

	web_url("CheckLoginStatus_16", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t47.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_17", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t48.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_18", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t49.inf", 
		"Mode=HTML", 
		LAST);

	web_url("CheckLoginStatus_19", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t50.inf", 
		"Mode=HTML", 
		LAST);

	web_url("operate-columns-template.html", 
		"URL=http://10.184.129.208/Platform/app/workarea/worklist/views/template/operate-columns-template.html", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t51.inf", 
		"Mode=HTML", 
		EXTRARES, 
		"Url=/Platform/Content/ui-grid.woff", "Referer=http://10.184.129.208/Platform/Content/ui-grid.min.css", ENDITEM, 
		LAST);

	lr_start_transaction("WorlkList_Query_randomTime");

	web_custom_request("searchWorklist_2", 
		"URL=http://10.184.129.208/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t52.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"2016-09-27T21:27:11.193Z\",\"endTime\":\"2017-07-04T21:27:11.193Z\"},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		LAST);

	lr_end_transaction("WorlkList_Query_randomTime",LR_AUTO);

	web_url("CheckLoginStatus_20", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t53.inf", 
		"Mode=HTML", 
		LAST);

	lr_think_time(18);

	web_custom_request("update2", 
		"URL=http://clients2.google.com/service/update2?cup2key=7:456915423&cup2hreq=fe64f7670d6a702479c75698c3adc8e9fa4ab043eea0deb6c7250a539330f864", 
		"Method=POST", 
		"Resource=0", 
		"Referer=", 
		"Snapshot=t54.inf", 
		"Mode=HTML", 
		"EncType=application/xml", 
		"Body=<?xml version=\"1.0\" encoding=\"UTF-8\"?><request protocol=\"3.0\" version=\"chrome-59.0.3071.104\" prodversion=\"59.0.3071.104\" requestid=\"{f9abaf83-6f37-4ed1-86b9-3c290d06ae6e}\" lang=\"zh-CN\" updaterchannel=\"\" prodchannel=\"\" os=\"win\" arch=\"x86\" nacl_arch=\"x86-64\" wow64=\"1\" domainjoined=\"0\"><hw physmemory=\"4\"/><os platform=\"Windows\" arch=\"x86_64\" version=\"6.1.7601.0\" sp=\"Service Pack 1\"/><updater autoupdatecheckenabled=\"1\" laststarted=\"0\" name=\"Omaha\" "
		"updatepolicy=\"-1\" version=\"1.3.33.5\"/><app appid=\"giekcmmlnklenlaomppkphknjmnnpneh\" version=\"0.0.0.0\" brand=\"GGLS\"><updatecheck/><ping rd=\"-2\" ping_freshness=\"\"/></app><app appid=\"gkmgaooipdjhmangpemjhigmamcehddo\" version=\"0.0.0.0\" brand=\"GGLS\"><updatecheck/><ping rd=\"-2\" ping_freshness=\"\"/></app><app appid=\"hfnkpimlhhgieaddgfemjhofmfblmnib\" version=\"0\" brand=\"GGLS\"><updatecheck/><ping rd=\"-2\" ping_freshness=\"\"/></app><app appid=\"hnimpnehoodheedghdeeijklkeaacbdc"
		"\" version=\"0.0.0.0\" brand=\"GGLS\"><updatecheck/><ping rd=\"-2\" ping_freshness=\"\"/></app><app appid=\"khaoiebndkojlmppeemjhbpbandiljpe\" version=\"0.0.0.0\" brand=\"GGLS\"><updatecheck/><ping rd=\"-2\" ping_freshness=\"\"/></app><app appid=\"llkgjffcdpffmhiakmfcdcblohccpfmo\" version=\"0.0.0.0\" brand=\"GGLS\"><updatecheck/><ping rd=\"-2\" ping_freshness=\"\"/></app><app appid=\"mimojjlkmoijpicakmndhoigimigcmbb\" version=\"0.0.0.0\" brand=\"GGLS\"><updatecheck/><ping rd=\"-2\" ping_freshness"
		"=\"\"/></app><app appid=\"npdjjkjlcidkjlamlmmdelcjbcpdjocm\" version=\"0.0.0.0\" brand=\"GGLS\"><updatecheck/><ping rd=\"-2\" ping_freshness=\"\"/></app><app appid=\"oafdbfcohdcjandcenmccfopbeklnicp\" version=\"0.0.0.0\" brand=\"GGLS\"><updatecheck/><ping rd=\"-2\" ping_freshness=\"\"/></app><app appid=\"oimompecagnajdejgnnjijobebaeigek\" version=\"1.4.8.984\" brand=\"GGLS\"><updatecheck/><ping rd=\"-2\" ping_freshness=\"\"/></app><app appid=\"ojjgnpkioondelmggbekfhllhdaimnho\" version=\"0.0.0.0\""
		" brand=\"GGLS\"><updatecheck/><ping rd=\"-2\" ping_freshness=\"\"/></app></request>", 
		LAST);

	lr_start_transaction("Worklist_Query_Today");

	web_custom_request("searchWorklist_3", 
		"URL=http://10.184.129.208/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t55.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"2017-07-04T21:32:19.263Z\",\"endTime\":\"2017-07-04T21:32:19.263Z\"},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"patientType\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		LAST);

	web_url("CheckLoginStatus_21", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t56.inf", 
		"Mode=HTML", 
		LAST);

	lr_end_transaction("Worklist_Query_Today",LR_AUTO);

	lr_start_transaction("worklist_query_LastToday");

	web_custom_request("searchWorklist_4", 
		"URL=http://10.184.129.208/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t57.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"2017-07-03T21:32:55.649Z\",\"endTime\":\"2017-07-04T21:32:55.649Z\"},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"patientType\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		LAST);

	lr_end_transaction("worklist_query_LastToday",LR_AUTO);

	web_url("CheckLoginStatus_22", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t58.inf", 
		"Mode=HTML", 
		LAST);

	lr_start_transaction("worklist_query_LastToday");

	lr_end_transaction("worklist_query_LastToday",LR_AUTO);

	lr_start_transaction("worklist_query_Lastweek");

	web_custom_request("searchWorklist_5", 
		"URL=http://10.184.129.208/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t59.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"2017-06-28T21:33:46.522Z\",\"endTime\":\"2017-07-04T21:33:46.522Z\"},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"patientType\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		LAST);

	lr_end_transaction("worklist_query_Lastweek",LR_AUTO);

	lr_start_transaction("worklist_query_LastMonth");

	web_url("CheckLoginStatus_23", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t60.inf", 
		"Mode=HTML", 
		LAST);

	web_custom_request("searchWorklist_6", 
		"URL=http://10.184.129.208/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t61.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":null,\"createDateRange\":{\"startTime\":\"2017-06-05T21:34:04.073Z\",\"endTime\":\"2017-07-04T21:34:04.073Z\"},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"patientType\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		LAST);

	web_url("CheckLoginStatus_24", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t62.inf", 
		"Mode=HTML", 
		LAST);

	lr_end_transaction("worklist_query_LastMonth",LR_AUTO);

	lr_think_time(30);

	lr_start_transaction("worklist_query_PatientName");

	web_custom_request("searchWorklist_7", 
		"URL=http://10.184.129.208/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t63.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"patientName\":null,\"patientID\":\"P20170703233549235\",\"accessionNumber\":null,\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		LAST);

	lr_end_transaction("worklist_query_PatientName",LR_AUTO);

	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		LAST);

	lr_think_time(19);

	lr_start_transaction("worklist_query_ACC");

	web_custom_request("searchWorklist_8", 
		"URL=http://10.184.129.208/webapi/api/worklist/searchWorklist", 
		"Method=POST", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t65.inf", 
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"patientName\":null,\"patientID\":null,\"accessionNumber\":\"A20170703233549235\",\"createDateRange\":{\"startTime\":null,\"endTime\":null},\"patientSex\":\"\",\"reportStatus\":\"\",\"reportPrintStatus\":\"\",\"filmPrintStatus\":\"\",\"printMode\":\"\",\"modalityType\":\"\",\"patientType\":\"\",\"department\":\"\",\"completeStatus\":null,\"pagination\":{\"pageIndex\":1,\"pageSize\":50},\"shortcutName\":\"\",\"shortcutNameCache\":\"\"}", 
		LAST);

	web_url("CheckLoginStatus_26", 
		"URL=http://10.184.129.208/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.208/Platform/workarea/worklist", 
		"Snapshot=t66.inf", 
		"Mode=HTML", 
		LAST);

	lr_end_transaction("worklist_query_ACC",LR_AUTO);

	return 0;
}