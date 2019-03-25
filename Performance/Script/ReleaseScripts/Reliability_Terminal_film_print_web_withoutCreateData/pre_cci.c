# 1 "d:\\scripts\\releasescripts\\reliability_terminal_film_print_web_withoutcreatedata\\\\combined_Reliability_Terminal_film_print_web_withoutCreateData.c"
# 1 "globals.h" 1


 
 
# 1 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h" 1
 
 












 











# 103 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"








































































	

 


















 
 
 
 
 


 
 
 
 
 
 














int     lr_start_transaction   (char * transaction_name);
int lr_start_sub_transaction          (char * transaction_name, char * trans_parent);
long lr_start_transaction_instance    (char * transaction_name, long parent_handle);



int     lr_end_transaction     (char * transaction_name, int status);
int lr_end_sub_transaction            (char * transaction_name, int status);
int lr_end_transaction_instance       (long transaction, int status);


 
typedef char* lr_uuid_t;
 



lr_uuid_t lr_generate_uuid();

 


int lr_generate_uuid_free(lr_uuid_t uuid);

 



int lr_generate_uuid_on_buf(lr_uuid_t buf);

   
# 263 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
int lr_start_distributed_transaction  (char * transaction_name, lr_uuid_t correlator, long timeout  );

   







int lr_end_distributed_transaction  (lr_uuid_t correlator, int status);


double lr_stop_transaction            (char * transaction_name);
double lr_stop_transaction_instance   (long parent_handle);


void lr_resume_transaction           (char * trans_name);
void lr_resume_transaction_instance  (long trans_handle);


int lr_update_transaction            (const char *trans_name);


 
void lr_wasted_time(long time);


 
int lr_set_transaction(const char *name, double duration, int status);
 
long lr_set_transaction_instance(const char *name, double duration, int status, long parent_handle);


int   lr_user_data_point                      (char *, double);
long lr_user_data_point_instance                   (char *, double, long);
 



int lr_user_data_point_ex(const char *dp_name, double value, int log_flag);
long lr_user_data_point_instance_ex(const char *dp_name, double value, long parent_handle, int log_flag);


int lr_transaction_add_info      (const char *trans_name, char *info);
int lr_transaction_instance_add_info   (long trans_handle, char *info);
int lr_dpoint_add_info           (const char *dpoint_name, char *info);
int lr_dpoint_instance_add_info        (long dpoint_handle, char *info);


double lr_get_transaction_duration       (char * trans_name);
double lr_get_trans_instance_duration    (long trans_handle);
double lr_get_transaction_think_time     (char * trans_name);
double lr_get_trans_instance_think_time  (long trans_handle);
double lr_get_transaction_wasted_time    (char * trans_name);
double lr_get_trans_instance_wasted_time (long trans_handle);
int    lr_get_transaction_status		 (char * trans_name);
int	   lr_get_trans_instance_status		 (long trans_handle);

 



int lr_set_transaction_status(int status);

 



int lr_set_transaction_status_by_name(int status, const char *trans_name);
int lr_set_transaction_instance_status(int status, long trans_handle);


typedef void* merc_timer_handle_t;
 

merc_timer_handle_t lr_start_timer();
double lr_end_timer(merc_timer_handle_t timer_handle);


 
 
 
 
 
 











 



int   lr_rendezvous  (char * rendezvous_name);
 




int   lr_rendezvous_ex (char * rendezvous_name);



 
 
 
 
 
char *lr_get_vuser_ip (void);
void   lr_whoami (int *vuser_id, char ** sgroup, int *scid);
char *	  lr_get_host_name (void);
char *	  lr_get_master_host_name (void);

 
long     lr_get_attrib_long	(char * attr_name);
char *   lr_get_attrib_string	(char * attr_name);
double   lr_get_attrib_double      (char * attr_name);

char * lr_paramarr_idx(const char * paramArrayName, unsigned int index);
char * lr_paramarr_random(const char * paramArrayName);
int    lr_paramarr_len(const char * paramArrayName);

int	lr_param_unique(const char * paramName);
int lr_param_sprintf(const char * paramName, const char * format, ...);


 
 
static void *ci_this_context = 0;






 








void lr_continue_on_error (int lr_continue);
char *   lr_decrypt (const char *EncodedString);


 
 
 
 
 
 



 







 















void   lr_abort (void);
void lr_exit(int exit_option, int exit_status);
void lr_abort_ex (unsigned long flags);

void   lr_peek_events (void);


 
 
 
 
 


void   lr_think_time (double secs);

 


void lr_force_think_time (double secs);


 
 
 
 
 



















int   lr_msg (char * fmt, ...);
int   lr_debug_message (unsigned int msg_class,
									    char * format,
										...);
# 502 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
void   lr_new_prefix (int type,
                                 char * filename,
                                 int line);
# 505 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
int   lr_log_message (char * fmt, ...);
int   lr_message (char * fmt, ...);
int   lr_error_message (char * fmt, ...);
int   lr_output_message (char * fmt, ...);
int   lr_vuser_status_message (char * fmt, ...);
int   lr_error_message_without_fileline (char * fmt, ...);
int   lr_fail_trans_with_error (char * fmt, ...);

 
 
 
 
 
# 528 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"

 
 
 
 
 





int   lr_next_row ( char * table);
int lr_advance_param ( char * param);



														  
														  

														  
														  

													      
 


char *   lr_eval_string (char * str);
int   lr_eval_string_ext (const char *in_str,
                                     unsigned long const in_len,
                                     char ** const out_str,
                                     unsigned long * const out_len,
                                     unsigned long const options,
                                     const char *file,
								     long const line);
# 562 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
void   lr_eval_string_ext_free (char * * pstr);

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
int lr_param_increment (char * dst_name,
                              char * src_name);
# 585 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"













											  
											  

											  
											  
											  

int	  lr_save_var (char *              param_val,
							  unsigned long const param_val_len,
							  unsigned long const options,
							  char *			  param_name);
# 609 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
int   lr_save_string (const char * param_val, const char * param_name);
int   lr_free_parameter (const char * param_name);
int   lr_save_int (const int param_val, const char * param_name);


 
 
 
 
 
 
# 676 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
void   lr_save_datetime (const char *format, int offset, const char *name);









 











 
 
 
 
 






 



char * lr_error_context_get_entry (char * key);

 



long   lr_error_context_get_error_id (void);


 
 
 

int lr_table_get_rows_num (char * param_name);

int lr_table_get_cols_num (char * param_name);

char * lr_table_get_cell_by_col_index (char * param_name, int row, int col);

char * lr_table_get_cell_by_col_name (char * param_name, int row, const char* col_name);

int lr_table_get_column_name_by_index (char * param_name, int col, 
											char * * const col_name,
											int * col_name_len);
# 737 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"

int lr_table_get_column_name_by_index_free (char * col_name);


 
 
 
 
 
 
 
 

 
 
 
 
 
 
int   lr_param_substit (char * file,
                                   int const line,
                                   char * in_str,
                                   int const in_len,
                                   char * * const out_str,
                                   int * const out_len);
# 762 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
void   lr_param_substit_free (char * * pstr);


 
# 774 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"





char *   lrfnc_eval_string (char * str,
                                      char * file_name,
                                      long const line_num);
# 782 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"


int   lrfnc_save_string ( const char * param_val,
                                     const char * param_name,
                                     const char * file_name,
                                     long const line_num);
# 788 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"

int   lrfnc_free_parameter (const char * param_name );

int lr_save_searched_string(char *buffer, long buf_size, unsigned int occurrence,
			    char *search_string, int offset, unsigned int param_val_len, 
			    char *param_name);

 
char *   lr_string (char * str);

 
# 859 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"

int   lr_save_value (char * param_val,
                                unsigned long const param_val_len,
                                unsigned long const options,
                                char * param_name,
                                char * file_name,
                                long const line_num);
# 866 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"


 
 
 
 
 











int   lr_printf (char * fmt, ...);
 
int   lr_set_debug_message (unsigned int msg_class,
                                       unsigned int swtch);
# 888 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
unsigned int   lr_get_debug_message (void);


 
 
 
 
 

void   lr_double_think_time ( double secs);
void   lr_usleep (long);


 
 
 
 
 
 




int *   lr_localtime (long offset);


int   lr_send_port (long port);


# 964 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"



struct _lr_declare_identifier{
	char signature[24];
	char value[128];
};

int   lr_pt_abort (void);

void vuser_declaration (void);






# 993 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"


# 1005 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
















 
 
 
 
 







int    _lr_declare_transaction   (char * transaction_name);


 
 
 
 
 







int   _lr_declare_rendezvous  (char * rendezvous_name);

 
 
 
 
 

 
int lr_enable_ip_spoofing();
int lr_disable_ip_spoofing();


 




int lr_convert_string_encoding(char *sourceString, char *fromEncoding, char *toEncoding, char *paramName);





 
 

















# 5 "globals.h" 2

# 1 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/web_api.h" 1
 







# 1 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/as_web.h" 1
 






















































 




 








 
 
 

  int
	web_add_filter(
		const char *		mpszArg,
		...
	);									 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int
	web_add_auto_filter(
		const char *		mpszArg,
		...
	);									 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
	
  int
	web_add_auto_header(
		const char *		mpszHeader,
		const char *		mpszValue);

  int
	web_add_header(
		const char *		mpszHeader,
		const char *		mpszValue);
  int
	web_add_cookie(
		const char *		mpszCookie);
  int
	web_cleanup_auto_headers(void);
  int
	web_cleanup_cookies(void);
  int
	web_concurrent_end(
		const char * const	mpszReserved,
										 
		...								 
	);
  int
	web_concurrent_start(
		const char * const	mpszConcurrentGroupName,
										 
										 
		...								 
										 
	);
  int
	web_create_html_param(
		const char *		mpszParamName,
		const char *		mpszLeftDelim,
		const char *		mpszRightDelim);
  int
	web_create_html_param_ex(
		const char *		mpszParamName,
		const char *		mpszLeftDelim,
		const char *		mpszRightDelim,
		const char *		mpszNum);
  int
	web_custom_request(
		const char *		mpszReqestName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_disable_keep_alive(void);
  int
	web_enable_keep_alive(void);
  int
	web_find(
		const char *		mpszStepName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_get_int_property(
		const int			miHttpInfoType);
  int
	web_image(
		const char *		mpszStepName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_image_check(
		const char *		mpszName,
		...);
  int
	web_java_check(
		const char *		mpszName,
		...);
  int
	web_link(
		const char *		mpszStepName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

	
  int
	web_global_verification(
		const char *		mpszArg1,
		...);							 
										 
										 
										 
										 
										 

  int
	web_reg_find(
		const char *		mpszArg1,
		...);							 
										 
										 
										 
										 
										 
										 
										 
				
  int
	web_reg_save_param(
		const char *		mpszParamName,
		...);							 
										 
										 
										 
										 
										 
										 

  int
	web_convert_param(
		const char * 		mpszParamName, 
										 
		...);							 
										 
										 


										 

										 
  int
	web_remove_auto_filter(
		const char *		mpszArg,
		...
	);									 
										 
				
  int
	web_remove_auto_header(
		const char *		mpszHeaderName,
		...);							 
										 



  int
	web_remove_cookie(
		const char *		mpszCookie);

  int
	web_save_header(
		const char *		mpszType,	 
		const char *		mpszName);	 
  int
	web_set_certificate(
		const char *		mpszIndex);
  int
	web_set_certificate_ex(
		const char *		mpszArg1,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_set_connections_limit(
		const char *		mpszLimit);
  int
	web_set_max_html_param_len(
		const char *		mpszLen);
  int
	web_set_max_retries(
		const char *		mpszMaxRetries);
  int
	web_set_proxy(
		const char *		mpszProxyHost);
  int
	web_set_proxy_bypass(
		const char *		mpszBypass);
  int
	web_set_secure_proxy(
		const char *		mpszProxyHost);
  int
	web_set_sockets_option(
		const char *		mpszOptionID,
		const char *		mpszOptionValue
	);
  int
	web_set_option(
		const char *		mpszOptionID,
		const char *		mpszOptionValue,
		...								 
	);
  int
	web_set_timeout(
		const char *		mpszWhat,
		const char *		mpszTimeout);
  int
	web_set_user(
		const char *		mpszUserName,
		const char *		mpszPwd,
		const char *		mpszHost);

  int
	web_sjis_to_euc_param(
		const char *		mpszParamName,
										 
		const char *		mpszParamValSjis);
										 

  int
	web_submit_data(
		const char *		mpszStepName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_submit_form(
		const char *		mpszStepName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										  
										 
										 
										 
										 
										 
										  
										 
										 
										 
										 
										 
										 
										 
										  
										 
										 
										 
										 
										 
										  
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_url(
		const char *		mpszUrlName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int 
	web_set_proxy_bypass_local(
		const char * mpszNoLocal
		);

  int 
	web_cache_cleanup(void);

  int
	web_create_html_query(
		const char* mpszStartQuery,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int 
	web_create_radio_button_param(
		const char *NameFiled,
		const char *NameAndVal,
		const char *ParamName
		);

  int
	web_convert_from_formatted(
		const char * mpszArg1,
		...);							 
										 
										 
										 
										 
										 
										
  int
	web_convert_to_formatted(
		const char * mpszArg1,
		...);							 
										 
										 
										 
										 
										 

  int
	web_reg_save_param_ex(
		const char * mpszParamName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int
	web_reg_save_param_xpath(
		const char * mpszParamName,
		...);							
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 










# 596 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/as_web.h"


# 609 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/as_web.h"



























# 647 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/as_web.h"

 
 
 


  int
	FormSubmit(
		const char *		mpszFormName,
		...);
  int
	InitWebVuser(void);
  int
	SetUser(
		const char *		mpszUserName,
		const char *		mpszPwd,
		const char *		mpszHost);
  int
	TerminateWebVuser(void);
  int
	URL(
		const char *		mpszUrlName);
























# 715 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/as_web.h"



 
 
 






# 10 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/web_api.h" 2












 






 











  int
	web_reg_add_cookie(
		const char *		mpszCookie,
		...);							 
										 

  int
	web_report_data_point(
		const char *		mpszEventType,
		const char *		mpszEventName,
		const char *		mpszDataPointName,
		const char *		mpszLAST);	 
										 
										 
										 

  int
	web_text_link(
		const char *		mpszStepName,
		...);

  int
	web_element(
		const char *		mpszStepName,
		...);

  int
	web_image_link(
		const char *		mpszStepName,
		...);

  int
	web_static_image(
		const char *		mpszStepName,
		...);

  int
	web_image_submit(
		const char *		mpszStepName,
		...);

  int
	web_button(
		const char *		mpszStepName,
		...);

  int
	web_edit_field(
		const char *		mpszStepName,
		...);

  int
	web_radio_group(
		const char *		mpszStepName,
		...);

  int
	web_check_box(
		const char *		mpszStepName,
		...);

  int
	web_list(
		const char *		mpszStepName,
		...);

  int
	web_text_area(
		const char *		mpszStepName,
		...);

  int
	web_map_area(
		const char *		mpszStepName,
		...);

  int
	web_eval_java_script(
		const char *		mpszStepName,
		...);

  int
	web_reg_dialog(
		const char *		mpszArg1,
		...);

  int
	web_reg_cross_step_download(
		const char *		mpszArg1,
		...);

  int
	web_browser(
		const char *		mpszStepName,
		...);

  int
	web_control(
		const char *		mpszStepName,
		...);

  int
	web_set_rts_key(
		const char *		mpszArg1,
		...);

  int
	web_save_param_length(
		const char * 		mpszParamName,
		...);

  int
	web_save_timestamp_param(
		const char * 		mpszParamName,
		...);

  int
	web_load_cache(
		const char *		mpszStepName,
		...);							 
										 

  int
	web_dump_cache(
		const char *		mpszStepName,
		...);							 
										 
										 

  int
	web_reg_find_in_log(
		const char *		mpszArg1,
		...);							 
										 
										 

  int
	web_get_sockets_info(
		const char *		mpszArg1,
		...);							 
										 
										 
										 
										 

  int
	web_add_cookie_ex(
		const char *		mpszArg1,
		...);							 
										 
										 
										 

  int
	web_hook_java_script(
		const char *		mpszArg1,
		...);							 
										 
										 
										 





 
 
 


# 6 "globals.h" 2

# 1 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrw_custom_body.h" 1
 





# 7 "globals.h" 2


# 1 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrw_custom_body.h" 1
 





# 9 "globals.h" 2

# 1 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h" 1
 










 
# 77 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  int
soap_request(
				char * pFirstArg,
				...
			);


 




























 






 
# 238 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  int
web_service_call(
					char * pFirstArg,	
					...
				);



 
# 272 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  int
web_service_set_security(
					char * pFirstArg,	
					...
				);

 
# 305 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  char*
web_service_wait_for_event(
					char * pFirstArg,	
					...
 
				);

 






  int
web_service_cancel_security();

 
# 334 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  int
wsdl_wsi_validation (
					 char * pFirstArg,	
					...
				);

 
# 380 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  int
web_service_set_security_saml(
					char * pFirstArg,	
					...
				);


 






  int
web_service_cancel_security_saml();

 
# 412 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"

  int
jms_send_message_queue(
					    const char * StepName,
						const char * SentMessage,
						const char * SendQueueName);



  int
jms_receive_message_queue(
						  const char * StepName,
						  const char * ReceiveQueueName);


  int
jms_send_receive_message_queue(
					const char * StepName,
					const char * SentMessage,
					const char * SendQueueName,
					const char * ReceiveQueueName);


  int
jms_publish_message_topic(
					   const char * StepName,
					   const char * SentMessage,
					   const char * SendTopicName);


  int
jms_receive_message_topic(
						  const char * StepName,
						  const char * SubscriptionName,
						  const char * ReceiveTopicName);

  int
jms_subscribe_topic(
					const char * StepName,
					const char * SubscriptionName,
					const char * SendTopicName);

  int
jms_set_general_property(
						 const char * StepName,
					const char * Name,
					const char * Value);

  int
jms_set_message_property(
						 const char * StepName,
						const char * name,
						const char * value);

						
 











  int
soa_xml_validate (
					char * pFirstArg,	
					...
				  );

  int
lr_db_connect (
					char * pFirstArg,	
					...
				  );
  int
lr_db_disconnect (
					char * pFirstArg,	
					...
				  );
  int
lr_db_executeSQLStatement (
					char * pFirstArg,	
					...
				  );


  int
lr_db_dataset_action (
					char * pFirstArg,	
					...
				  );

  int
lr_checkpoint (
					char * pFirstArg,	
					...
				  );

  int
lr_db_getvalue (
					char * pFirstArg,	
					...
				  );


# 10 "globals.h" 2

 
 

char *str_replace(char *dest,char *src,const char *olderstr,const char *newstr,int len){

	char *needle;
	char *tmp;
	
	if(strcmp(olderstr,newstr)==0){
		return src;
	}
	
	dest = src;

	while((needle = (char *) strstr(dest,olderstr)) && (needle -dest <= len)){
		tmp = (char*)malloc(strlen(dest)+(strlen(newstr)-strlen(olderstr))+1);
		strncpy(tmp,dest,needle-dest);
		tmp[needle-dest]='\0';
		strcat(tmp,newstr);
		strcat(tmp,needle+strlen(olderstr));
		dest = (char *)strdup(tmp);
		free(tmp);
		
	}

	return dest;
}

# 1 "d:\\scripts\\releasescripts\\reliability_terminal_film_print_web_withoutcreatedata\\\\combined_Reliability_Terminal_film_print_web_withoutCreateData.c" 2



# 1 "vuser_init.c" 1
vuser_init()
{
	    	lr_db_connect("StepName=Connect", 
					"ConnectionString=Data Source=10.184.129.108\\GCPACSWS;Password=sa20021224$;User ID=sa;Initial Catalog=WGGC;", 
					"ConnectionName=ConnectGCPACS", 
					"ConnectionType=SQL", 
					"LAST" );
	return 0;
}
# 4 "d:\\scripts\\releasescripts\\reliability_terminal_film_print_web_withoutcreatedata\\\\combined_Reliability_Terminal_film_print_web_withoutCreateData.c" 2

# 1 "Action.c" 1
	 
	int NumRows1;
	int NumRows2;
	char * tmp;
			 	
	char *str;
	char *old=".";
	char *newchar="";
	char *dest;
	int result; 
	int ServiceResultFlag;
	int  SQLresult; 
	char  *tmpSQL; 
    int LoopNumber;
    int i = 0;
	int HTTP_RC;


Action()
{

		web_set_max_html_param_len("10240");

		str=lr_eval_string("{DateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"TreatmentID_new");


				 
				 
				 
			 
			tmpSQL = " select AccessionNumber from  wggc.dbo.AFP_FilmInfo  where AccessionNumber='{ACCNum}' and DeleteStatus =0 and FilmFlag =0 and MinDensity is not null";
			lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

			SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
				"ConnectionName=ConnectGCPACS",
				"SQLStatement={SQLECSQuery1}",
				"DatasetName=MyDataset",
				"LAST" );

		   lr_message("The result is %d",SQLresult);

		   	lr_think_time(5);

			if (SQLresult!=1) {
								 
								tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='{ACCNum}'  and DeleteStatus =0   ";
								lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

								SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
									"ConnectionName=ConnectGCPACS",
									"SQLStatement={SQLECSQuery1}",
									"DatasetName=MyDataset",
									"LAST" );

								lr_message("The result is %d",SQLresult);

								return 0;

			};


		lr_think_time(5);

			tmpSQL = " select AccessionNumber from  wggc.dbo.AFP_FilmInfo  where AccessionNumber='{ACCNum}' and DeleteStatus =0 and FilmFlag =0  and MinDensity is not null";
			lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

			SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
				"ConnectionName=ConnectGCPACS",
				"SQLStatement={SQLECSQuery1}",
				"DatasetName=MyDataset",
				"LAST" );

			if(SQLresult!=1){
			lr_fail_trans_with_error("The film print status is not correct and Update the status by databse failed: the accessionnumber is - %s",lr_eval_string("{ACCNum}"));
			return 0;
			};




				 
				lr_start_transaction("Film TerminalStatus");

					web_add_auto_header("content-type","application/json");
					web_custom_request("web_custom_request",
						"URL=http://10.184.129.108/EHDPS/status?tid={K2Terminal}",
						"Method=GET",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body=",
						"LAST");

				lr_end_transaction("Film TerminalStatus", 2);

				LoopNumber =0 ;

				 

				do
				{
					lr_think_time(5);
					LoopNumber = LoopNumber + 1;
	
					web_reg_save_param("TaskID",
									  "LB=\"TaskId\"\:\"",
									  "RB=\"",
									  "Notfound=warning",
									  "LAST" );
	
					lr_start_transaction("Film Create_PrintTask");
	
					web_add_auto_header("content-type","application/json");
	
					web_custom_request("web_custom_request",
						"URL=http://10.184.129.108/EHDPS/printtask/create?tid={K2Terminal}",
						"Method=POST",
						"TargetFrame=",
						"Resource=0",
						"Referer=",
						"Mode=HTTP",
						"Body={\"CardInfo\"\:\{\"Value\"\:\"{ACCNum}\"\,\"Type\"\:0\}\,\"RequestId\"\:null\,\"RequestDate\"\:\"{CurrentTime}.7211992+08:00\"\}",
						"LAST");
	
	
					lr_end_transaction("Film Create_PrintTask", 2);
	
	 
	 
	
					if(stricmp(lr_eval_string("{TaskID}") ,"") ==0)
					{
						lr_start_transaction("Fim GetTaskID_fail");
							lr_output_message("Create print task failed. Try again. The accession number is %s,%s,%d",lr_eval_string("{ACCNum}"),lr_eval_string("{K2Terminal}"),LoopNumber );
						lr_end_transaction("Fim GetTaskID_fail",2);
					};

				}while(stricmp(lr_eval_string("{TaskID}") ,"") ==0 && LoopNumber < 10 );



				if (LoopNumber == 10) {
						lr_start_transaction("Film Create_PrintTask Fail");
							lr_error_message("Try to get the Print task ID failed: %s :  %s",lr_eval_string("{ACCNum}"),lr_eval_string("{K2Terminal}"));
						lr_end_transaction("Film Create_PrintTask Fail",2);
						return 0;
				};

				LoopNumber = 0;

				if (stricmp(lr_eval_string("{TaskID}") ,"") !=0) {


						 
						lr_start_transaction("Film PrintTask");

						web_add_auto_header("content-type","application/json");

						web_custom_request("web_custom_request",
										"URL=http://10.184.129.108/EHDPS/printtask/print/{TaskID}?tid={K2Terminal}",
										"Method=POST",
										"TargetFrame=",
										"Resource=0",
										"Referer=",
										"Mode=HTTP",
										"Body={\"RequestId\"\:null\,\"RequestDate\"\:\"{CurrentTime}.8769401+08:00\"}",
										"LAST");


						lr_end_transaction("Film PrintTask", 2);

						 


						 

						LoopNumber = 0;

						do{
								lr_think_time(10);
								LoopNumber = LoopNumber + 1;
								   web_reg_save_param("TaskStatus",
													  "LB=\,\"Status\"\:",
													  "RB=\,\"",
										"LAST" );

						lr_start_transaction("Film_PrintStatus_CheckService");

									web_add_auto_header("content-type","application/json");
									web_custom_request("web_custom_request",
										"URL=http://10.184.129.108/EHDPS/printtask/status/{TaskID}?tid={K2Terminal}",
										"Method=GET",
										"TargetFrame=",
										"Resource=0",
										"Referer=",
										"Mode=HTTP",
										"Body=",
										"LAST");

						lr_end_transaction("Film_PrintStatus_CheckService", 2);

						lr_output_message("PrintStatus in DataBase-------,%s",lr_eval_string("{TaskStatus}"));
									result  = stricmp(lr_eval_string("{TaskStatus}") ,"4");
						lr_output_message("PrintStatus Check result-------,%d",result);

						}while(result !=0 && LoopNumber <30);


						lr_output_message("PrintStatus-------,%d",LoopNumber);

						 
						if (result==0) {

							lr_start_transaction("Film PrintTask_Result_Correct");
							lr_think_time(1);
							lr_end_transaction("Film PrintTask_Result_Correct", 2);

							lr_think_time(5);

 
							tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='{ACCNum}'  and DeleteStatus =0  ";
							lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

							SQLresult = lr_db_executeSQLStatement("StepName=UpdateFilmToUnPrinted",
								"ConnectionName=ConnectGCPACS",
								"SQLStatement={SQLECSQuery1}",
								"DatasetName=MyDataset",
								"LAST" );

							if(SQLresult  == 1)
							{
								lr_exit(2 ,1  );
								lr_error_message("SQL statement update the film flag to 0 failed: %s",lr_eval_string("{ACCNum}"));
							};



						}

							 
								if (LoopNumber >=30) {
									lr_start_transaction("Film PrintTask_Result_Fail");
											lr_error_message("The task do not finish correct: TaskID: %s  From Terminal: %s",lr_eval_string("{TaskID}"),lr_eval_string("{K2Terminal}"));
									lr_end_transaction("Film PrintTask_Result_Fail", 2);

									lr_think_time(5);
									tmpSQL = "update wggc.dbo.AFP_FilmInfo  set FilmFlag=0  where AccessionNumber ='{ACCNum}'  and DeleteStatus =0  and MinDensity is not null ";
									lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery1");

									SQLresult = lr_db_executeSQLStatement("StepName=QueryReportStatus",
										"ConnectionName=ConnectGCPACS",
										"SQLStatement={SQLECSQuery1}",
										"DatasetName=MyDataset",
										"LAST" );
								};




				};

				lr_think_time(5);

	return 0;








	
	

}



# 5 "d:\\scripts\\releasescripts\\reliability_terminal_film_print_web_withoutcreatedata\\\\combined_Reliability_Terminal_film_print_web_withoutCreateData.c" 2

# 1 "vuser_end.c" 1
vuser_end()
{
		lr_db_disconnect("StepName=Disconnect",	"ConnectionName=ConnectGCPACS", "LAST" );
	return 0;
}
# 6 "d:\\scripts\\releasescripts\\reliability_terminal_film_print_web_withoutcreatedata\\\\combined_Reliability_Terminal_film_print_web_withoutCreateData.c" 2

