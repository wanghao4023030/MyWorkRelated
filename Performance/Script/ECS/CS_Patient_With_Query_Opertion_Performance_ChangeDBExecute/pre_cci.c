# 1 "d:\\ecs\\cs_patient_with_query_opertion_performance_changedbexecute\\\\combined_CS_Patient_With_Query_Opertion_Performance_ChangeDBExecute.c"
# 1 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h" 1
 
 












 











# 103 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"






















































		


		typedef unsigned size_t;
	
	
        
	

















	

 



















 
 
 
 
 


 
 
 
 
 
 














int     lr_start_transaction   (char * transaction_name);
int lr_start_sub_transaction          (char * transaction_name, char * trans_parent);
long lr_start_transaction_instance    (char * transaction_name, long parent_handle);
int   lr_start_cross_vuser_transaction		(char * transaction_name, char * trans_id_param); 



int     lr_end_transaction     (char * transaction_name, int status);
int lr_end_sub_transaction            (char * transaction_name, int status);
int lr_end_transaction_instance       (long transaction, int status);
int   lr_end_cross_vuser_transaction	(char * transaction_name, char * trans_id_param, int status);


 
typedef char* lr_uuid_t;
 



lr_uuid_t lr_generate_uuid();

 


int lr_generate_uuid_free(lr_uuid_t uuid);

 



int lr_generate_uuid_on_buf(lr_uuid_t buf);

   
# 273 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
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
# 512 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
void   lr_new_prefix (int type,
                                 char * filename,
                                 int line);
# 515 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
int   lr_log_message (char * fmt, ...);
int   lr_message (char * fmt, ...);
int   lr_error_message (char * fmt, ...);
int   lr_output_message (char * fmt, ...);
int   lr_vuser_status_message (char * fmt, ...);
int   lr_error_message_without_fileline (char * fmt, ...);
int   lr_fail_trans_with_error (char * fmt, ...);

 
 
 
 
 
# 539 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"

 
 
 
 
 





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
# 573 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
void   lr_eval_string_ext_free (char * * pstr);

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
int lr_param_increment (char * dst_name,
                              char * src_name);
# 596 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"













											  
											  

											  
											  
											  

int	  lr_save_var (char *              param_val,
							  unsigned long const param_val_len,
							  unsigned long const options,
							  char *			  param_name);
# 620 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
int   lr_save_string (const char * param_val, const char * param_name);



int   lr_set_custom_error_message (const char * param_val, ...);

int   lr_remove_custom_error_message ();


int   lr_free_parameter (const char * param_name);
int   lr_save_int (const int param_val, const char * param_name);
int   lr_save_timestamp (const char * tmstampParam, ...);
int   lr_save_param_regexp (const char *bufferToScan, unsigned int bufSize, ...);

int   lr_convert_double_to_integer (const char *source_param_name, const char * target_param_name);
int   lr_convert_double_to_double (const char *source_param_name, const char *format_string, const char * target_param_name);

 
 
 
 
 
 
# 699 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
void   lr_save_datetime (const char *format, int offset, const char *name);









 











 
 
 
 
 






 



char * lr_error_context_get_entry (char * key);

 



long   lr_error_context_get_error_id (void);


 
 
 

int lr_table_get_rows_num (char * param_name);

int lr_table_get_cols_num (char * param_name);

char * lr_table_get_cell_by_col_index (char * param_name, int row, int col);

char * lr_table_get_cell_by_col_name (char * param_name, int row, const char* col_name);

int lr_table_get_column_name_by_index (char * param_name, int col, 
											char * * const col_name,
											size_t * col_name_len);
# 760 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"

int lr_table_get_column_name_by_index_free (char * col_name);

 
 
 
 
# 775 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
int   lr_zip (const char* param1, const char* param2);
int   lr_unzip (const char* param1, const char* param2);

 
 
 
 
 
 
 
 

 
 
 
 
 
 
int   lr_param_substit (char * file,
                                   int const line,
                                   char * in_str,
                                   size_t const in_len,
                                   char * * const out_str,
                                   size_t * const out_len);
# 799 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
void   lr_param_substit_free (char * * pstr);


 
# 811 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"





char *   lrfnc_eval_string (char * str,
                                      char * file_name,
                                      long const line_num);
# 819 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"


int   lrfnc_save_string ( const char * param_val,
                                     const char * param_name,
                                     const char * file_name,
                                     long const line_num);
# 825 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"

int   lrfnc_free_parameter (const char * param_name );







typedef struct _lr_timestamp_param
{
	int iDigits;
}lr_timestamp_param;

extern const lr_timestamp_param default_timestamp_param;

int   lrfnc_save_timestamp (const char * param_name, const lr_timestamp_param* time_param);

int lr_save_searched_string(char * buffer, long buf_size, unsigned int occurrence,
			    char * search_string, int offset, unsigned int param_val_len, 
			    char * param_name);

 
char *   lr_string (char * str);

 
# 926 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"

int   lr_save_value (char * param_val,
                                unsigned long const param_val_len,
                                unsigned long const options,
                                char * param_name,
                                char * file_name,
                                long const line_num);
# 933 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"


 
 
 
 
 











int   lr_printf (char * fmt, ...);
 
int   lr_set_debug_message (unsigned int msg_class,
                                       unsigned int swtch);
# 955 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
unsigned int   lr_get_debug_message (void);


 
 
 
 
 

void   lr_double_think_time ( double secs);
void   lr_usleep (long);


 
 
 
 
 
 




int *   lr_localtime (long offset);


int   lr_send_port (long port);


# 1031 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"



struct _lr_declare_identifier{
	char signature[24];
	char value[128];
};

int   lr_pt_abort (void);

void vuser_declaration (void);






# 1060 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"


# 1072 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/lrun.h"
















 
 
 
 
 







int    _lr_declare_transaction   (char * transaction_name);


 
 
 
 
 







int   _lr_declare_rendezvous  (char * rendezvous_name);

 
 
 
 
 


typedef int PVCI;






typedef int VTCERR;









PVCI   vtc_connect(char * servername, int portnum, int options);
VTCERR   vtc_disconnect(PVCI pvci);
VTCERR   vtc_get_last_error(PVCI pvci);
VTCERR   vtc_query_column(PVCI pvci, char * columnName, int columnIndex, char * *outvalue);
VTCERR   vtc_query_row(PVCI pvci, int rowIndex, char * **outcolumns, char * **outvalues);
VTCERR   vtc_send_message(PVCI pvci, char * column, char * message, unsigned short *outRc);
VTCERR   vtc_send_if_unique(PVCI pvci, char * column, char * message, unsigned short *outRc);
VTCERR   vtc_send_row1(PVCI pvci, char * columnNames, char * messages, char * delimiter, unsigned char sendflag, unsigned short *outUpdates);
VTCERR   vtc_update_message(PVCI pvci, char * column, int index , char * message, unsigned short *outRc);
VTCERR   vtc_update_message_ifequals(PVCI pvci, char * columnName, int index,	char * message, char * ifmessage, unsigned short 	*outRc);
VTCERR   vtc_update_row1(PVCI pvci, char * columnNames, int index , char * messages, char * delimiter, unsigned short *outUpdates);
VTCERR   vtc_retrieve_message(PVCI pvci, char * column, char * *outvalue);
VTCERR   vtc_retrieve_messages1(PVCI pvci, char * columnNames, char * delimiter, char * **outvalues);
VTCERR   vtc_retrieve_row(PVCI pvci, char * **outcolumns, char * **outvalues);
VTCERR   vtc_rotate_message(PVCI pvci, char * column, char * *outvalue, unsigned char sendflag);
VTCERR   vtc_rotate_messages1(PVCI pvci, char * columnNames, char * delimiter, char * **outvalues, unsigned char sendflag);
VTCERR   vtc_rotate_row(PVCI pvci, char * **outcolumns, char * **outvalues, unsigned char sendflag);
VTCERR   vtc_increment(PVCI pvci, char * column, int index , int incrValue, int *outValue);
VTCERR   vtc_clear_message(PVCI pvci, char * column, int index , unsigned short *outRc);
VTCERR   vtc_clear_column(PVCI pvci, char * column, unsigned short *outRc);
VTCERR   vtc_ensure_index(PVCI pvci, char * column, unsigned short *outRc);
VTCERR   vtc_drop_index(PVCI pvci, char * column, unsigned short *outRc);
VTCERR   vtc_clear_row(PVCI pvci, int rowIndex, unsigned short *outRc);
VTCERR   vtc_create_column(PVCI pvci, char * column,unsigned short *outRc);
VTCERR   vtc_column_size(PVCI pvci, char * column, int *size);
void   vtc_free(char * msg);
void   vtc_free_list(char * *msglist);

VTCERR   lrvtc_connect(char * servername, int portnum, int options);
VTCERR   lrvtc_disconnect();
VTCERR   lrvtc_query_column(char * columnName, int columnIndex);
VTCERR   lrvtc_query_row(int columnIndex);
VTCERR   lrvtc_send_message(char * columnName, char * message);
VTCERR   lrvtc_send_if_unique(char * columnName, char * message);
VTCERR   lrvtc_send_row1(char * columnNames, char * messages, char * delimiter, unsigned char sendflag);
VTCERR   lrvtc_update_message(char * columnName, int index , char * message);
VTCERR   lrvtc_update_message_ifequals(char * columnName, int index, char * message, char * ifmessage);
VTCERR   lrvtc_update_row1(char * columnNames, int index , char * messages, char * delimiter);
VTCERR   lrvtc_retrieve_message(char * columnName);
VTCERR   lrvtc_retrieve_messages1(char * columnNames, char * delimiter);
VTCERR   lrvtc_retrieve_row();
VTCERR   lrvtc_rotate_message(char * columnName, unsigned char sendflag);
VTCERR   lrvtc_rotate_messages1(char * columnNames, char * delimiter, unsigned char sendflag);
VTCERR   lrvtc_rotate_row(unsigned char sendflag);
VTCERR   lrvtc_increment(char * columnName, int index , int incrValue);
VTCERR   lrvtc_noop();
VTCERR   lrvtc_clear_message(char * columnName, int index);
VTCERR   lrvtc_clear_column(char * columnName); 
VTCERR   lrvtc_ensure_index(char * columnName); 
VTCERR   lrvtc_drop_index(char * columnName); 
VTCERR   lrvtc_clear_row(int rowIndex);
VTCERR   lrvtc_create_column(char * columnName);
VTCERR   lrvtc_column_size(char * columnName);



 
 
 
 
 

 
int lr_enable_ip_spoofing();
int lr_disable_ip_spoofing();


 




int lr_convert_string_encoding(char * sourceString, char * fromEncoding, char * toEncoding, char * paramName);
int lr_read_file(const char *filename, const char *outputParam, int continueOnError);


 
int lr_db_connect (char * pFirstArg, ...);
int lr_db_disconnect (char * pFirstArg,	...);
int lr_db_executeSQLStatement (char * pFirstArg, ...);
int lr_db_dataset_action(char * pFirstArg, ...);
int lr_checkpoint(char * pFirstArg,	...);
int lr_db_getvalue(char * pFirstArg, ...);







 
 



















# 1 "d:\\ecs\\cs_patient_with_query_opertion_performance_changedbexecute\\\\combined_CS_Patient_With_Query_Opertion_Performance_ChangeDBExecute.c" 2

# 1 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/SharedParameter.h" 1



 
 
 
 
# 100 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/SharedParameter.h"






typedef int PVCI2;






typedef int VTCERR2;


 
 
 

 
extern PVCI2    vtc_connect(char *servername, int portnum, int options);
extern VTCERR2  vtc_disconnect(PVCI2 pvci);
extern VTCERR2  vtc_get_last_error(PVCI2 pvci);

 
extern VTCERR2  vtc_query_column(PVCI2 pvci, char *columnName, int columnIndex, char **outvalue);
extern VTCERR2  vtc_query_row(PVCI2 pvci, int columnIndex, char ***outcolumns, char ***outvalues);
extern VTCERR2  vtc_send_message(PVCI2 pvci, char *column, char *message, unsigned short *outRc);
extern VTCERR2  vtc_send_if_unique(PVCI2 pvci, char *column, char *message, unsigned short *outRc);
extern VTCERR2  vtc_send_row1(PVCI2 pvci, char *columnNames, char *messages, char *delimiter,  unsigned char sendflag, unsigned short *outUpdates);
extern VTCERR2  vtc_update_message(PVCI2 pvci, char *column, int index , char *message, unsigned short *outRc);
extern VTCERR2  vtc_update_message_ifequals(PVCI2 pvci, char	*columnName, int index,	char *message, char	*ifmessage,	unsigned short 	*outRc);
extern VTCERR2  vtc_update_row1(PVCI2 pvci, char *columnNames, int index , char *messages, char *delimiter, unsigned short *outUpdates);
extern VTCERR2  vtc_retrieve_message(PVCI2 pvci, char *column, char **outvalue);
extern VTCERR2  vtc_retrieve_messages1(PVCI2 pvci, char *columnNames, char *delimiter, char ***outvalues);
extern VTCERR2  vtc_retrieve_row(PVCI2 pvci, char ***outcolumns, char ***outvalues);
extern VTCERR2  vtc_rotate_message(PVCI2 pvci, char *column, char **outvalue, unsigned char sendflag);
extern VTCERR2  vtc_rotate_messages1(PVCI2 pvci, char *columnNames, char *delimiter, char ***outvalues, unsigned char sendflag);
extern VTCERR2  vtc_rotate_row(PVCI2 pvci, char ***outcolumns, char ***outvalues, unsigned char sendflag);
extern VTCERR2	vtc_increment(PVCI2 pvci, char *column, int index , int incrValue, int *outValue);
extern VTCERR2  vtc_clear_message(PVCI2 pvci, char *column, int index , unsigned short *outRc);
extern VTCERR2  vtc_clear_column(PVCI2 pvci, char *column, unsigned short *outRc);

extern VTCERR2  vtc_clear_row(PVCI2 pvci, int rowIndex, unsigned short *outRc);

extern VTCERR2  vtc_create_column(PVCI2 pvci, char *column,unsigned short *outRc);
extern VTCERR2  vtc_column_size(PVCI2 pvci, char *column, int *size);
extern VTCERR2  vtc_ensure_index(PVCI2 pvci, char *column, unsigned short *outRc);
extern VTCERR2  vtc_drop_index(PVCI2 pvci, char *column, unsigned short *outRc);

extern VTCERR2  vtc_noop(PVCI2 pvci);

 
extern void vtc_free(char *msg);
extern void vtc_free_list(char **msglist);

 


 




 




















 




 
 
 

extern VTCERR2  lrvtc_connect(char *servername, int portnum, int options);
extern VTCERR2  lrvtc_disconnect();
extern VTCERR2  lrvtc_query_column(char *columnName, int columnIndex);
extern VTCERR2  lrvtc_query_row(int columnIndex);
extern VTCERR2  lrvtc_send_message(char *columnName, char *message);
extern VTCERR2  lrvtc_send_if_unique(char *columnName, char *message);
extern VTCERR2  lrvtc_send_row1(char *columnNames, char *messages, char *delimiter,  unsigned char sendflag);
extern VTCERR2  lrvtc_update_message(char *columnName, int index , char *message);
extern VTCERR2  lrvtc_update_message_ifequals(char *columnName, int index, char 	*message, char *ifmessage);
extern VTCERR2  lrvtc_update_row1(char *columnNames, int index , char *messages, char *delimiter);
extern VTCERR2  lrvtc_retrieve_message(char *columnName);
extern VTCERR2  lrvtc_retrieve_messages1(char *columnNames, char *delimiter);
extern VTCERR2  lrvtc_retrieve_row();
extern VTCERR2  lrvtc_rotate_message(char *columnName, unsigned char sendflag);
extern VTCERR2  lrvtc_rotate_messages1(char *columnNames, char *delimiter, unsigned char sendflag);
extern VTCERR2  lrvtc_rotate_row(unsigned char sendflag);
extern VTCERR2  lrvtc_increment(char *columnName, int index , int incrValue);
extern VTCERR2  lrvtc_clear_message(char *columnName, int index);
extern VTCERR2  lrvtc_clear_column(char *columnName);
extern VTCERR2  lrvtc_clear_row(int rowIndex);
extern VTCERR2  lrvtc_create_column(char *columnName);
extern VTCERR2  lrvtc_column_size(char *columnName);
extern VTCERR2  lrvtc_ensure_index(char *columnName);
extern VTCERR2  lrvtc_drop_index(char *columnName);

extern VTCERR2  lrvtc_noop();

 
 
 

                               


 
 
 





















# 2 "d:\\ecs\\cs_patient_with_query_opertion_performance_changedbexecute\\\\combined_CS_Patient_With_Query_Opertion_Performance_ChangeDBExecute.c" 2

# 1 "globals.h" 1



 
 

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
	spdy_custom_request(
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
	web_set_pac(
		const char *		mpszPacUrl);
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
	spdy_submit_data(
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
	spdy_url(
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
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int
	web_reg_save_param_json(
		const char * mpszParamName,
		...);							
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int
	web_reg_save_param_regexp(
		 const char * mpszParamName,
		 ...);							
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int
	web_js_run(
		const char * mpszCode,
		...);							
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int
	web_js_reset(void);

  int
	web_convert_date_param(
		const char * 		mpszParamName,
		...);










# 769 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/as_web.h"


# 782 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/as_web.h"



























# 820 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/as_web.h"

 
 
 


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
























# 888 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/as_web.h"


  int
	web_rest(
		const char *		mpszReqestName,
		...);							 
										 
										 
										 
										 

  int
web_stream_open(
	const char *		mpszArg1,
	...
);
  int
	web_stream_wait(
		const char *		mpszArg1,
		...
	);

  int
	web_stream_close(
		const char *		mpszArg1,
		...
	);

  int
web_stream_play(
	const char *		mpszArg1,
	...
	);

  int
web_stream_pause(
	const char *		mpszArg1,
	...
	);

  int
web_stream_seek(
	const char *		mpszArg1,
	...
	);

  int
web_stream_get_param_int(
	const char*			mpszStreamID,
	const int			miStateType
	);

  double
web_stream_get_param_double(
	const char*			mpszStreamID,
	const int			miStateType
	);

  int
web_stream_get_param_string(
	const char*			mpszStreamID,
	const int			miStateType,
	const char*			mpszParameterName
	);

  int
web_stream_set_param_int(
	const char*			mpszStreamID,
	const int			miStateType,
	const int			miStateValue
	);

  int
web_stream_set_param_double(
	const char*			mpszStreamID,
	const int			miStateType,
	const double		mdfStateValue
	);

 
 
 






# 9 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/web_api.h" 2

















 







 














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
										 
										 
										 

 
 
 
 
 
 
 
 
 
 
 
 
  int
	web_reg_async_attributes(
		const char *		mpszArg,
		...
	);

 
 
 
 
 
 
  int
	web_sync(
		 const char *		mpszArg1,
		 ...
	);

 
 
 
 
  int
	web_stop_async(
		const char *		mpszArg1,
		...
	);

 
 
 
 
 

 
 
 

typedef enum WEB_ASYNC_CB_RC_ENUM_T
{
	WEB_ASYNC_CB_RC_OK,				 

	WEB_ASYNC_CB_RC_ABORT_ASYNC_NOT_ERROR,
	WEB_ASYNC_CB_RC_ABORT_ASYNC_ERROR,
										 
										 
										 
										 
	WEB_ASYNC_CB_RC_ENUM_COUNT
} WEB_ASYNC_CB_RC_ENUM;

 
 
 

typedef enum WEB_CONVERS_CB_CALL_REASON_ENUM_T
{
	WEB_CONVERS_CB_CALL_REASON_BUFFER_RECEIVED,
	WEB_CONVERS_CB_CALL_REASON_END_OF_TASK,

	WEB_CONVERS_CB_CALL_REASON_ENUM_COUNT
} WEB_CONVERS_CB_CALL_REASON_ENUM;

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

typedef
int														 
	(*RequestCB_t)();

typedef
int														 
	(*ResponseBodyBufferCB_t)(
		  const char *		aLastBufferStr,
		  int				aLastBufferLen,
		  const char *		aAccumulatedStr,
		  int				aAccumulatedLen,
		  int				aHttpStatusCode);

typedef
int														 
	(*ResponseCB_t)(
		  const char *		aResponseHeadersStr,
		  int				aResponseHeadersLen,
		  const char *		aResponseBodyStr,
		  int				aResponseBodyLen,
		  int				aHttpStatusCode);

typedef
int														 
	(*ResponseHeadersCB_t)(
		  int				aHttpStatusCode,
		  const char *		aAccumulatedHeadersStr,
		  int				aAccumulatedHeadersLen);



 
 
 

typedef enum WEB_CONVERS_UTIL_RC_ENUM_T
{
	WEB_CONVERS_UTIL_RC_OK,
	WEB_CONVERS_UTIL_RC_CONVERS_NOT_FOUND,
	WEB_CONVERS_UTIL_RC_TASK_NOT_FOUND,
	WEB_CONVERS_UTIL_RC_INFO_NOT_FOUND,
	WEB_CONVERS_UTIL_RC_INFO_UNAVIALABLE,
	WEB_CONVERS_UTIL_RC_INVALID_ARGUMENT,

	WEB_CONVERS_UTIL_RC_ENUM_COUNT
} WEB_CONVERS_UTIL_RC_ENUM;

 
 
 

  int					 
	web_util_set_request_url(
		  const char *		aUrlStr);

  int					 
	web_util_set_request_body(
		  const char *		aRequestBodyStr);

  int					 
	web_util_set_formatted_request_body(
		  const char *		aRequestBodyStr);


 
 
 
 
 

 
 
 
 
 

 
 
 
 
 
 
 
 

 
 
  int
web_websocket_connect(
		 const char *	mpszArg1,
		 ...
		 );


 
 
 
 
 																						
  int
web_websocket_send(
	   const char *		mpszArg1,
		...
	   );

 
 
 
 
 
 
  int
web_websocket_close(
		const char *	mpszArg1,
		...
		);

 
typedef
void														
(*OnOpen_t)(
			  const char* connectionID,  
			  const char * responseHeader,  
			  int length  
);

typedef
void														
(*OnMessage_t)(
	  const char* connectionID,  
	  int isbinary,  
	  const char * data,  
	  int length  
	);

typedef
void														
(*OnError_t)(
	  const char* connectionID,  
	  const char * message,  
	  int length  
	);

typedef
void														
(*OnClose_t)(
	  const char* connectionID,  
	  int isClosedByClient,  
	  int code,  
	  const char* reason,  
	  int length  
	 );
 
 
 
 
 





# 7 "globals.h" 2

# 1 "lrw_custom_body.h" 1
 




# 8 "globals.h" 2


# 1 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h" 1
 










 
# 77 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  int
soap_request(
				char * pFirstArg,
				...
			);


 






























 






 
# 240 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  int
web_service_call(
					char * pFirstArg,	
					...
				);



 
# 278 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  int
web_service_set_security(
					char * pFirstArg,	
					...
				);

 
# 311 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  char*
web_service_wait_for_event(
					char * pFirstArg,	
					...
 
				);

 






  int
web_service_cancel_security();

 
# 340 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  int
wsdl_wsi_validation (
					 char * pFirstArg,	
					...
				);

 
# 386 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"


  int
web_service_set_security_saml(
					char * pFirstArg,	
					...
				);


 






  int
web_service_cancel_security_saml();

 
# 418 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/wssoap.h"

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

  int
web_service_set_option (
					const char *		mpszOptionID,	
					const char *		mpszOptionValue
				  );


# 10 "globals.h" 2


# 1 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/time.h" 1

 








# 1 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/stddef.h" 1













typedef unsigned int uintptr_t;








typedef int intptr_t;








typedef int ptrdiff_t;





typedef unsigned short wchar_t;




typedef long time_t;




typedef long clock_t;




typedef wchar_t wint_t;
typedef wchar_t wctype_t;




typedef char *	va_list;



 





# 11 "C:\\Program Files (x86)\\HP\\LoadRunner\\include/time.h" 2




struct tm
{
  int	tm_sec;
  int	tm_min;
  int	tm_hour;
  int	tm_mday;
  int	tm_mon;
  int	tm_year;
  int	tm_wday;
  int	tm_yday;
  int	tm_isdst;
};








char	  *_asctime_r(struct tm *_tblock, void *_p);


clock_t clock(void);
double	  _difftime32(time_t _time2, time_t _time1);
time_t _mktime32(struct tm *_timeptr);
time_t _time32(time_t *_timer);
char	  *asctime(const struct tm *_tblock);
char	  *_ctime32(const time_t *_time);
struct tm *_gmtime32(const time_t *_timer);
struct tm *_localtime32(const time_t *_timer);
unsigned int   strftime(char *_s, size_t _maxsize, char *_fmt, struct tm *_t);



# 12 "globals.h" 2


	int rc;  
	int db_connection;  
	int query_result;  
	char** result_row;  
	char *server = "10.184.129.203";
	char *user = "sa";
	char *password = "sa20021224$";  
	char *database = "ECS";
	int port = 3306;  
	int unix_socket = 0;  
	int flags = 0;  

char *str_replace(char *dest,char *src,const char *olderstr,const char *newstr,size_t len){

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
 
 


# 3 "d:\\ecs\\cs_patient_with_query_opertion_performance_changedbexecute\\\\combined_CS_Patient_With_Query_Opertion_Performance_ChangeDBExecute.c" 2


# 1 "vuser_init.c" 1
vuser_init()
{
		 
	   
	  rc = ci_load_dll(ci_this_context,("libmysql.dll"));
	  if (rc != 0) {
	    lr_error_message("Could not load libmysql.dll");
	     
	    return 0;

	  }
		 
	   
	  db_connection = mysql_init(0);
	  if (db_connection == 0) {
	    lr_error_message("Insufficient memory init my SQL failed.");
	     
	    return 0;
	  }
	 
	   
	  rc = mysql_real_connect(db_connection, server, user, password, database, port, unix_socket, flags);
	  if (rc == 0) {
	     
	    lr_fail_trans_with_error("%s",mysql_error(db_connection) );
	    mysql_close(db_connection);
	     
	    return 0;
	  }
	
	return 0;
}
# 5 "d:\\ecs\\cs_patient_with_query_opertion_performance_changedbexecute\\\\combined_CS_Patient_With_Query_Opertion_Performance_ChangeDBExecute.c" 2

# 1 "A_Patient_Register.c" 1
A_Patient_Register()
{
		 
											 
		 
	
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
	  
	  	web_set_max_html_param_len("10240");
		
		 
		 
		 
		 
	
		 
		str=lr_eval_string("{CurrentDateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"strCurrentDateTime");
		 
		
	
		 
		 
		 
		
		web_reg_save_param("Get2DCodeImageResult","LB=<Get2DCodeImageResult>","RB=</Get2DCodeImageResult>",	"LAST");
		
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
				"LAST");	
				
				HTTP_RC = web_get_int_property(1);
				
				if(HTTP_RC !=200)
				{
					lr_fail_trans_with_error("Get2DCodeImage from CS operations failed. The http return code is %d", HTTP_RC);
					lr_exit(2,1);
					return 0;
				}
				
				
				HTTP_RES_SIZE = strlen(lr_eval_string("{Get2DCodeImageResult}"));
				
				 
				if(HTTP_RC == 200 && strlen(lr_eval_string("{Get2DCodeImageResult}")) == 0)
				{
					lr_fail_trans_with_error("Get2DCodeImage from CS operations failed. The http response content size is %d!", HTTP_RES_SIZE);
					lr_exit(2,1);
					return 0;
				}
		
				
		lr_end_transaction("Patient operations_ Get2DCodeImage", 2);

		 
		
		 
		 
		 
		
	   
	  	tmpSQL = "SELECT ID FROM ecs.qrcodesceneinfo where PatientID = 'P{strCurrentDateTime}{HospitalID}' and HospitalID = '{HospitalID}' ;";
		lr_save_string(lr_eval_string(tmpSQL),"SQLECSQuery");
		  
		rc = mysql_query(db_connection, lr_eval_string("{SQLECSQuery}"));
	 	if (rc != 0) {
		    lr_error_message("%s", mysql_error(db_connection));
		    mysql_close(db_connection);
		    lr_fail_trans_with_error("Query data from database failed");
			lr_exit(2,1);
			return 0;
	 	 }

		query_result = mysql_store_result(db_connection);
		lr_output_message("count is: %d", mysql_num_rows(query_result));
		
		if(mysql_num_rows(query_result) != 1)
		{
			lr_fail_trans_with_error("There are %d rows in table ecs.qrcodesceneinfo which Patientid is: %s hospitalId is %s ",mysql_num_rows(query_result),lr_eval_string("P{strCurrentDateTime}{HospitalID}"),lr_eval_string("{HospitalID}") );
			lr_exit(2,1);
			return 0;
		}

		
		
		result_row = (char **)mysql_fetch_row(query_result);
		lr_save_string(result_row[0], "QrsenceID");  
		lr_output_message("Order ID is: %s", lr_eval_string("{QrsenceID}"));
		
		lr_save_timestamp("Para", "DIGITS=10", "LAST" );
		lr_output_message(lr_eval_string("{Para}"));
		lr_save_string(lr_eval_string("{Para}"),"TimeStamp");
   
		
		 
		 
		 
  			web_reg_save_param("HttpResult","LB=<Content><![CDATA[","RB=]></Content>",	"LAST");
  			
  			lr_start_transaction("Patient Subscribe_Patinet");

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
					"LAST");
		  			
  			lr_end_transaction("Patient Subscribe_Patinet", 2);
  			
			lr_convert_string_encoding(lr_eval_string("{HttpResult}"), "utf-8",0, "realMessage");
			lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );		
			
  			
  	  mysql_free_result(query_result);		

  			
	return 0;
}
# 6 "d:\\ecs\\cs_patient_with_query_opertion_performance_changedbexecute\\\\combined_CS_Patient_With_Query_Opertion_Performance_ChangeDBExecute.c" 2

# 1 "B_Patient_ReportOperation_Query.c" 1
B_Patient_ReportOperation_Query()
{
		 
											 
		 
	
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
		
	
		web_set_max_html_param_len("10240");
		
		 
		 
		 
		 
	
		 
		str=lr_eval_string("{CurrentDateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"strCurrentDateTime");
		 
		
		
		 
		LoopNumber = atoi(lr_eval_string("{RandForLoop}"));
		 
		
	
  			LoopNumber = atoi(lr_eval_string("{RandForLoop}"));
	  		 
			lr_convert_string_encoding("您报告已经审核,请到自助终端打印！",0, "utf-8", "strMessage");
			strcpy(temp,lr_eval_string("{strMessage}"));
			lr_save_string(temp,"strMessageUTF8");
	
			 
			for(i = 1 ; i <= LoopNumber; i++)
			{
					lr_save_int(i, "EndNumber");
					
					web_reg_save_param("CreateReportHttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	"LAST");
					
					lr_start_transaction("Report Create Paper report");
	
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
							"LAST");	
							
		
					lr_end_transaction("Report Create Paper report", 2);
					
					 
					HTTP_RC = web_get_int_property(1);
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("PS Synchronize create PaperReport failed. The http return code is %d", HTTP_RC);
						lr_exit(2,1);
						return 0;
					}
					
					 
					if(HTTP_RC == 200 && strcmp(lr_eval_string("{CreateReportHttpResult}"),"true") != 0)
					{
						lr_fail_trans_with_error("PS Synchronize Create Paper report failed. The http response content is not true!");
						lr_exit(2,1);
						return 0;
					}
					
					 
			}
			
			
			
					 
					 
					 
			
 
 
 
					
					lr_start_transaction("Report QueryReportFilmStatus");

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
						"LAST");
					
					lr_end_transaction("Report QueryReportFilmStatus", 2);
					
					 
					HTTP_RC = web_get_int_property(1);
					
 
 
 
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("PS Synchronizec create PaperReport failed. The http return code is %d", HTTP_RC);
						lr_exit(2,1);
						return 0;
					}
					
 
 
 
 
 
					
					 
					 
					 
					
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


					 
					
					
					
					
					 
					 
					 
					
					 
					lr_convert_string_encoding("您报告已经打印，谢谢！",0, "utf-8", "strMessage");
					strcpy(temp,lr_eval_string("{strMessage}"));
					lr_save_string(temp,"strMessageUTF8");
					
					 
					for(i = 1 ; i <= LoopNumber; i++)
					{
							lr_save_int(i, "EndNumber");
							
							web_reg_save_param("HttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	"LAST");
						
							lr_start_transaction("Report Update Paper report");
					
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
									"LAST");
									
							lr_end_transaction("Report Update Paper report", 2);
							
							 
							HTTP_RC = web_get_int_property(1);
			
							if(HTTP_RC !=200)
							{
								lr_fail_trans_with_error("PS Synchronize update PaperReport failed. The http return code is %d", HTTP_RC);
								lr_exit(2,1);
								return 0;
							}
							
							 
							if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
							{
								lr_fail_trans_with_error("PS Synchronize update Paper report failed. The http response content is not true!");
								lr_exit(2,1);
								return 0;
							}
					}
					
					
					
					
 
 
 
					
					lr_start_transaction("Report QueryReportFilmStatus");

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
						"LAST");
					
					lr_end_transaction("Report QueryReportFilmStatus", 2);
					
					 
					HTTP_RC = web_get_int_property(1);
					
					lr_output_message("Http request is: %s", lr_eval_string("{HttpResult}") );
					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), "utf-8",0, "realMessage");
					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("PS Synchronizec create PaperReport failed. The http return code is %d", HTTP_RC);
						lr_exit(2,1);
						return 0;
					}
					
 
 
 
 
 
					
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


					 

   	   

	return 0;
}
# 7 "d:\\ecs\\cs_patient_with_query_opertion_performance_changedbexecute\\\\combined_CS_Patient_With_Query_Opertion_Performance_ChangeDBExecute.c" 2

# 1 "C_Patient_FilmOperation_Query.c" 1
C_Patient_FilmOperation_Query()
{
		 
											 
		 
	
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
		
	
		web_set_max_html_param_len("10240");
		
		 
		 
		 
		 
	
		 
		str=lr_eval_string("{CurrentDateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"strCurrentDateTime");
		 
		
		
		 
		LoopNumber = atoi(lr_eval_string("{RandForLoop}"));
		 
		
	
		 
		lr_convert_string_encoding("您胶片已经准备好，但是报告尚未审核。请到自助终端打印！",0, "utf-8", "strMessage");
		strcpy(temp,lr_eval_string("{strMessage}"));
		lr_save_string(temp,"strMessageUTF8");

		 
		for(i = 1 ; i <= LoopNumber; i++)
		{
				lr_save_int(i, "EndNumber");
				
				web_reg_save_param("HttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	"LAST");
				
				lr_start_transaction("Film Create Film");

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
						"LAST");	

				lr_end_transaction("Film Create Film", 2);
				
				 
				HTTP_RC = web_get_int_property(1);

				if(HTTP_RC !=200)
				{
					lr_fail_trans_with_error("PS Synchronize create Film failed. The http return code is %d", HTTP_RC);
					lr_exit(2,1);
					return 0;
				}
				
				 
				if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
				{
					lr_fail_trans_with_error("PS Synchronize Create film failed. The http response content is not true!");
					lr_exit(2,1);
					return 0;
				}
		
		}
			
			
			
					 
					 
					 
			
 
 
 
					
					lr_start_transaction("Film QueryReportFilmStatus");

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
						"LAST");
					
					lr_end_transaction("Film QueryReportFilmStatus", 2);
					
					 
					HTTP_RC = web_get_int_property(1);
					
 
 
 
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("Query Film status failed. The http return code is %d", HTTP_RC);
						lr_exit(2,1);
						return 0;
					}
					
 
 
 
 
 
					
					 
					 
					 
					
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

					 
					
					
					
					
					 
					 
					 
					
					 
				lr_convert_string_encoding("您胶片已经打印，谢谢！",0, "utf-8", "strMessage");
				strcpy(temp,lr_eval_string("{strMessage}"));
				lr_save_string(temp,"strMessageUTF8");
				
				 
				for(i = 1 ; i <= LoopNumber; i++)
				{
						lr_save_int(i, "EndNumber");
						
						web_reg_save_param("HttpResult","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	"LAST");
						
						lr_start_transaction("Film Update Film");
		
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
								"LAST");
		
						lr_end_transaction("Film Update Film", 2);
						
						 
						HTTP_RC = web_get_int_property(1);
		
						if(HTTP_RC !=200)
						{
							lr_fail_trans_with_error("PS Synchronize Update film failed. The http return code is %d", HTTP_RC);
							lr_exit(2,1);
							return 0;
						}
						
						 
						if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResult}"),"true") != 0)
						{
							lr_fail_trans_with_error("PS Synchronize update film failed. The http response content is not true!");
							lr_exit(2,1);
							return 0;
						}
		
				}	
					
					
					
 
 
 
					
					lr_start_transaction("Film QueryReportFilmStatus");

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
						"LAST");
					
					lr_end_transaction("Film QueryReportFilmStatus", 2);
					
					 
					HTTP_RC = web_get_int_property(1);
					
					lr_output_message("Http request is: %s", lr_eval_string("{HttpResult}") );
					lr_convert_string_encoding(lr_eval_string("{HttpResult}"), "utf-8",0, "realMessage");
					lr_output_message("Http request is: %s", lr_eval_string("{realMessage}") );
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("Query film status failed. The http return code is %d", HTTP_RC);
						lr_exit(2,1);
						return 0;
					}
					
 
 
 
 
 
					
					 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

					 
					
  
 


	return 0;
}
# 8 "d:\\ecs\\cs_patient_with_query_opertion_performance_changedbexecute\\\\combined_CS_Patient_With_Query_Opertion_Performance_ChangeDBExecute.c" 2

# 1 "D_Patient_Reservation_Query.c" 1
D_Patient_Reservation_Query()
{
		 
											 
		 
	
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
		
	
		 
		   
		  rc = ci_load_dll(ci_this_context,("libmysql.dll"));
		  if (rc != 0) {
		    lr_error_message("Could not load libmysql.dll");
		    lr_exit(2,1);
			return 0;

		  }
		 

		web_set_max_html_param_len("10240");
		
		 
		 
		 
		 
	
		 
		str=lr_eval_string("{CurrentDateTime}");
		lr_save_string(str_replace(dest, str, old, newchar,strlen(str)),"strCurrentDateTime");
		 
		
		
		 
		LoopNumber = atoi(lr_eval_string("{RandForLoop}"));
		 
		
		 
		ExecuteRand = atoi(lr_eval_string("{RandForExecute}"));
	
	 
		for(i = 1 ; i <= LoopNumber; i++)
		{
				lr_save_int(i, "EndNumber");
				
				 
				lr_save_datetime("%Y-%m-%dT%H:%M:%S", 0 + (86400*1), "ExamReservationBegin");

				web_reg_save_param("HttpResultCreateExamReservation","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	"LAST");
				
				lr_start_transaction("Reservation Create ExamReservation");
				
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
						"LAST");	
						

				
				lr_end_transaction("Reservation Create ExamReservation", 2);
				
				 
				HTTP_RC = web_get_int_property(1);

				if(HTTP_RC !=200)
				{
					lr_fail_trans_with_error("PS Synchronize create Reservation failed. The http return code is %d", HTTP_RC);
		    		lr_exit(2,1);
					return 0;
				}
				
				 
				if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResultCreateExamReservation}"),"true") != 0)
				{
					lr_fail_trans_with_error("PS Synchronize Create Reservation failed. The http response content is not true!");
		    		lr_exit(2,1);
					return 0;					
				}
			
		}
			
					 
					 
					 
			
 
 
 
					
					lr_start_transaction("Reservation QueryReservation");

					web_custom_request("web_QueryReservation",
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
						"LAST");
					
					lr_end_transaction("Reservation QueryReservation", 2);
					
					 
					HTTP_RC = web_get_int_property(1);
					
 
 
 
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("PS Synchronizec create PaperReport failed. The http return code is %d", HTTP_RC);
		    			lr_exit(2,1);
						return 0;						
					}
					
 
 
 
 
 
					
					 
					 
					 
					
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
					 
					
					
					
					
					 
					 
					 
					
					 
		if(ExecuteRand == 1)
		{
			for(i = 1 ; i <= LoopNumber; i++)
			{
					lr_save_int(i, "EndNumber");
					
					 
					lr_save_datetime("%Y-%m-%dT%H:%M:%S", 0 + (86400*1) + (3600*6), "ExamReservationBegin");
					
					web_reg_save_param("HttpResultUpdateExamReservation","LB=<SynchronizeInfoResult>","RB=</SynchronizeInfoResult>",	"LAST");
				
					lr_start_transaction("Reservation Update ExamReservation");
	
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
							"LAST");	
							
							 
							HTTP_RC = web_get_int_property(1);
			
							if(HTTP_RC !=200)
							{
								lr_fail_trans_with_error("PS Synchronize update Reservation failed. The http return code is %d", HTTP_RC);
								lr_exit(2,1);
								return 0;	
							}
							
							 
							if(HTTP_RC == 200 && strcmp(lr_eval_string("{HttpResultUpdateExamReservation}"),"true") != 0)
							{
								lr_fail_trans_with_error("PS Synchronize Update Reservation failed. The http response content is not true!");
		    					lr_exit(2,1);
								return 0;									
							}
					
					lr_end_transaction("Reservation Update ExamReservation", 2);

			}
	
					
					
					
 
 
 
					
					lr_start_transaction("Reservation QueryReservation");

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
						"<EventKey><![CDATA[BUTTON_QUERY_EXAMRESERVATION]]></EventKey>"
						"</xml>",
						"LAST");
					
					lr_end_transaction("Reservation QueryReservation", 2);
					
					 
					HTTP_RC = web_get_int_property(1);
					
 
 
 
	
					if(HTTP_RC !=200)
					{
						lr_fail_trans_with_error("PS Synchronizec create PaperReport failed. The http return code is %d", HTTP_RC);
						lr_exit(2,1);
						return 0;	
					}
					
 
 
 
 
 
					
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

					 

  	}
		
   	   

	return 0;
}
# 9 "d:\\ecs\\cs_patient_with_query_opertion_performance_changedbexecute\\\\combined_CS_Patient_With_Query_Opertion_Performance_ChangeDBExecute.c" 2

# 1 "vuser_end.c" 1
vuser_end()
{
	mysql_close(db_connection);
	return 0;
}
# 10 "d:\\ecs\\cs_patient_with_query_opertion_performance_changedbexecute\\\\combined_CS_Patient_With_Query_Opertion_Performance_ChangeDBExecute.c" 2

