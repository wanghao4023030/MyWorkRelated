# 1 "d:\\performance\\mr1\\webclient - mr1\\puma_worklist_webhttphtml\\\\combined_Puma_worklist_WebHttpHtml.c"
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







 
 



















# 1 "d:\\performance\\mr1\\webclient - mr1\\puma_worklist_webhttphtml\\\\combined_Puma_worklist_WebHttpHtml.c" 2

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

 
 
 

                               


 
 
 





















# 2 "d:\\performance\\mr1\\webclient - mr1\\puma_worklist_webhttphtml\\\\combined_Puma_worklist_WebHttpHtml.c" 2

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


 
 


# 3 "d:\\performance\\mr1\\webclient - mr1\\puma_worklist_webhttphtml\\\\combined_Puma_worklist_WebHttpHtml.c" 2

# 1 "vuser_init.c" 1
vuser_init()
{
	return 0;
}
# 4 "d:\\performance\\mr1\\webclient - mr1\\puma_worklist_webhttphtml\\\\combined_Puma_worklist_WebHttpHtml.c" 2

# 1 "Action.c" 1
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
		"EXTRARES", 
		"Url=/Platform/Content/angular-material.css", "ENDITEM", 
		"Url=/Platform/Content/bootstrap.css", "ENDITEM", 
		"Url=/Platform/Content/bootstrap-theme.css", "ENDITEM", 
		"Url=/Platform/Content/toaster.css", "ENDITEM", 
		"Url=/Platform/Content/carestream.css", "ENDITEM", 
		"Url=/Platform/app-resources/css/login.css", "ENDITEM", 
		"Url=/Platform/Scripts/jquery-1.11.0.js", "ENDITEM", 
		"Url=/Platform/Scripts/jquery.validate.js", "ENDITEM", 
		"Url=/Platform/Scripts/jquery.validate.unobtrusive.js", "ENDITEM", 
		"Url=/Platform/Scripts/modernizr-2.6.2.js", "ENDITEM", 
		"Url=/Platform/Scripts/bootstrap.js", "ENDITEM", 
		"Url=/Platform/Scripts/respond.js", "ENDITEM", 
		"Url=/Platform/Scripts/PDF.js.1.3.91/compatibility.js", "ENDITEM", 
		"Url=/Platform/Scripts/PDF.js.1.3.91/pdf.js", "ENDITEM", 
		"Url=/Platform/Scripts/PDF.js.1.3.91/pdf.worker.js", "ENDITEM", 
		"Url=/Platform/Scripts/PDF.js.1.3.91/text_layer_builder.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-ui-router.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-ui/ui-bootstrap.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-ui/ui-bootstrap-tpls.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-cookies.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-animate.min.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-busy.min.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-aria.min.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-material/angular-material.min.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-translate.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-translate-loader-partial.js", "ENDITEM", 
		"Url=/Platform/Scripts/ng-file-upload/ng-file-upload.min.js", "ENDITEM", 
		"Url=/Platform/Scripts/ui-grid-puma.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-tree-control/angular-tree-control.js", "ENDITEM", 
		"Url=/Platform/Scripts/toaster.js", "ENDITEM", 
		"Url=/Platform/Scripts/select.min.js", "ENDITEM", 
		"Url=/Platform/Scripts/Chart.min.js", "ENDITEM", 
		"Url=/Platform/Scripts/jsBarcode/JsBarcode.all.min.js", "ENDITEM", 
		"Url=/Platform/Scripts/angular-chart/angular-chart.js", "ENDITEM", 
		"Url=/Platform/Scripts/underscore.min.js", "ENDITEM", 
		"Url=/Platform/app/common/common.module.js", "ENDITEM", 
		"Url=/Platform/app/common/behaviors/checklist-model.js", "ENDITEM", 
		"Url=/Platform/app/common/behaviors/drag-sortable.js", "ENDITEM", 
		"Url=/Platform/app/common/behaviors/dropdownMenu-changeTitle.js", "ENDITEM", 
		"Url=/Platform/app/common/behaviors/focus.js", "ENDITEM", 
		"Url=/Platform/app/common/behaviors/notAllowDot.js", "ENDITEM", 
		"Url=/Platform/app/common/behaviors/vt-enter.js", "ENDITEM", 
		"Url=/Platform/app/common/controls/drag-sortable/Sortable.js", "ENDITEM", 
		"Url=/Platform/app/common/controls/puma-confirm/puma-confirm.js", "ENDITEM", 
		"Url=/Platform/app/common/controls/puma-delete-button/puma-delete-button.js", "ENDITEM", 
		"Url=/Platform/app/common/controls/puma-multi-select/puma-multi-select.js", "ENDITEM", 
		"Url=/Platform/app/common/controls/puma-multi-select/puma-multi-select.tpl.js", "ENDITEM", 
		"Url=/Platform/app/common/controls/puma-open-dialog/open-dialog.js", "ENDITEM", 
		"Url=/Platform/app/common/controls/puma-open-dialog/puma-dialog.js", "ENDITEM", 
		"Url=/Platform/app/common/controls/puma-switch/puma-switch.js", "ENDITEM", 
		"Url=/Platform/app/common/filters/camel-case-filter.js", "ENDITEM", 
		 
		"Url=/Platform/app/common/filters/qclog-event-filter.js", "ENDITEM", 
		"Url=/Platform/app/common/utils/base64.js", "ENDITEM", 
		"Url=/Platform/app/common/utils/constants.js", "ENDITEM", 
		"Url=/Platform/app/common/utils/date.js", "ENDITEM", 
		"Url=/Platform/app/common/utils/enum.js", "ENDITEM", 
		"Url=/Platform/app/common/utils/ipAddressHandler.js", "ENDITEM", 
		"Url=/Platform/app/common/utils/kiosk.util.js", "ENDITEM", 
		"Url=/Platform/app/common/utils/loginContext.js", "ENDITEM", 
		"Url=/Platform/app/common/utils/permission.js", "ENDITEM", 
 
		"Url=/Platform/app/common/utils/webservices.js", "ENDITEM", 
		"Url=/Platform/app/common/webservices/client-tool-svc.js", "ENDITEM", 
		"Url=/Platform/app/common/webservices/configuration-svc.js", "ENDITEM", 
		"Url=/Platform/app/common/webservices/system-information-svc.js", "ENDITEM", 
		"Url=/Platform/app/login/login.js", "ENDITEM", 
		"Url=/Platform/app/login/rememberme.js", "ENDITEM", 
		"LAST");

	web_url("login-view.html", 
		"URL=http://10.184.129.108/Platform/app/login/login-view.html", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/", 
		"Snapshot=t2.inf", 
		"Mode=HTML", 
		"EXTRARES", 
		"Url=/Platform/app-resources/i18n/zh-CN/login.json", "Referer=http://10.184.129.108/Platform/", "ENDITEM", 
	 
		"Url=/Platform/fonts/icomoon.ttf?my8ecs", "Referer=http://10.184.129.108/Platform/Content/carestream.css", "ENDITEM", 
		"LAST");

	web_reg_save_param("ApiToken",
		"LB=ApiToken\=",
		"RB= path\=",
		"LAST");
	
	web_reg_save_param("AspToken",
		"LB= .AspNet.ApplicationCookie\=",
		"RB=path\=",
		"LAST");
	
	web_reg_save_param("access_token",
		"LB=access_token%22%3A%22",
		"RB=%22%2C%22token_typ",
		"LAST");

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
		"LAST");

	web_add_cookie("ApiToken={ApiToken}; DOMAIN=10.184.129.171");
	web_add_cookie(".AspNet.ApplicationCookie={AspToken}; DOMAIN=10.184.129.171");
	
	 







	web_url("login_2", 
		"URL=http://10.184.129.108/Platform//account/login", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/", 
		"Snapshot=t7.inf", 
		"Mode=HTML", 
		"LAST");

	web_url("workarea", 
		"URL=http://10.184.129.108/Platform/workarea", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/", 
		"Snapshot=t8.inf", 
		"Mode=HTML", 
		"EXTRARES", 
		"Url=Content/site.css", "ENDITEM", 
		"Url=Content/ui-bootstrap-csp.css", "ENDITEM", 
		"Url=app/common/controls/puma-switch/puma-switch.css", "ENDITEM", 
		"Url=Content/ui-grid.min.css", "ENDITEM", 
		"Url=Scripts/angular-tree-control/tree-control.css", "ENDITEM", 
		"Url=Scripts/angular-tree-control/tree-control-attribute.css", "ENDITEM", 
		"Url=Content/select.css", "ENDITEM", 
		"Url=app-resources/css/site.css", "ENDITEM", 
		"Url=app-resources/css/open-dialog.css", "ENDITEM", 
		"Url=app-resources/css/terminalmonitor.css", "ENDITEM", 
		"Url=app-resources/css/statistics.css", "ENDITEM", 
		"Url=app-resources/css/barcode.css", "ENDITEM", 
		"Url=app-resources/css/circle.css", "ENDITEM", 
		"Url=app-resources/css/worklist.css", "ENDITEM", 
		"Url=app-resources/css/adminsettings.css", "ENDITEM", 
		"Url=app-resources/css/reconciliation.css", "ENDITEM", 
		"Url=Scripts/PDF.js.1.3.91/text_layer_builder.css", "ENDITEM", 
		"Url=app/workarea/app.workarea.js", "ENDITEM", 
		"Url=app/workarea/module.workarea.js", "ENDITEM", 
		 
		"Url=app/workarea/worklist/controllers/worklist-mainbody-ctrl.js", "ENDITEM", 
		"Url=app/workarea/worklist/controllers/worklist-view-ctrl.js", "ENDITEM", 
		"Url=app/workarea/worklist/views/worklist-view.js", "ENDITEM", 
		"Url=app/workarea/reconciliation/controllers/reconciliation-list-ctrl.js", "ENDITEM", 
		"Url=app/workarea/terminalmonitor/controllers/terminalmonitor-view-ctrl.js", "ENDITEM", 
		"Url=app/workarea/adminsettings/log/controllers/qclog-ctrl.js", "ENDITEM", 
		"Url=app/workarea/adminsettings/log/views/qclog-view.js", "ENDITEM", 
		"Url=app/workarea/adminsettings/role/controllers/role-settings-ctrl.js", "ENDITEM", 
		"Url=app/workarea/adminsettings/system/controllers/systeml-setting-ctr.js", "ENDITEM", 
		"Url=app/workarea/adminsettings/user/contorllers/user-settings-ctrl.js", "ENDITEM", 
		"Url=app/workarea/statistics/controllers/statistics-ctrl.js", "ENDITEM", 
		"Url=app/workarea/webservices/adminsettings-svc.js", "ENDITEM", 
		"Url=fonts/icomoon.ttf?g2jea5", "Referer=http://10.184.129.108/Platform/Scripts/angular-tree-control/tree-control.css", "ENDITEM", 
		"Url=app/workarea/webservices/qclog-svc.js", "ENDITEM", 
		"Url=app/workarea/webservices/reconciliation-svc.js", "ENDITEM", 
		"Url=app/workarea/webservices/role-svc.js", "ENDITEM", 
		"Url=app/workarea/webservices/statistics-svc.js", "ENDITEM", 
		"Url=app/workarea/webservices/terminalmonitor-svc.js", "ENDITEM", 
		"Url=app/workarea/webservices/user-svc.js", "ENDITEM", 
		"Url=app/workarea/webservices/worklist-svc.js", "ENDITEM", 
		"Url=app/workarea/barcode/controllers/barcode-ctrl.js", "ENDITEM", 
	 
		"Url=app-resources/i18n/zh-CN/workarea.json", "ENDITEM", 
		"Url=app-resources/i18n/zh-CN/adminsettings.json", "ENDITEM", 
		"Url=app-resources/i18n/zh-CN/barcode.json", "ENDITEM", 
		"Url=app-resources/i18n/zh-CN/dicomviewer.json", "ENDITEM", 
		"Url=app-resources/i18n/zh-CN/reconciliation.json", "ENDITEM", 
		"Url=app-resources/i18n/zh-CN/statistics.json", "ENDITEM", 
		"Url=app-resources/i18n/zh-CN/terminalmonitor.json", "ENDITEM", 
		"Url=app-resources/i18n/zh-CN/worklist.json", "ENDITEM", 
		"LAST");


 web_add_auto_header("Authorization","bearer {access_token}");
 
	web_reg_save_param("status",
		"LB=",
		"RB=",
		"LAST");

	web_url("CheckLoginStatusByUser", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t13.inf", 
		"Mode=HTML", 
		"LAST");
	
	
	
	if (strstr(lr_eval_string("{status}"),"true")==0)
	    {
	    	lr_fail_trans_with_error("Login failed");
	    	lr_message("User Login website failed %s",lr_eval_string("{status}"));
	    	lr_message("User Login website failed %d",strstr(lr_eval_string("{status}"),"flase"));
	    	lr_end_transaction("User_login",2);
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
		"LAST");

	web_url("worklistcolumns", 
		"URL=http://10.184.129.108/webapi/api/worklist/worklistcolumns", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t10.inf", 
		"Mode=HTML", 
		"LAST");

 
 
 
 
 
 
 

	web_url("systemversion", 
		"URL=http://10.184.129.108/webapi/api/systemversion", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t12.inf", 
		"Mode=HTML", 
		"LAST");

	web_url("CheckLoginStatus", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t13.inf", 
		"Mode=HTML", 
		"LAST");
 
 


	web_url("terminalmonitor-template.html", 
		"URL=http://10.184.129.108/Platform/app/workarea/terminalmonitor/views/terminalmonitor-template.html", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t17.inf", 
		"Mode=HTML", 
		"EXTRARES", 
		"Url=/Platform/fonts/glyphicons-halflings-regular.woff2", "Referer=http://10.184.129.108/Platform/Content/bootstrap.css", "ENDITEM", 
		"LAST");

	web_url("terminalmonitoring", 
		"URL=http://10.184.129.108/webapi/api/terminalmonitoring", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t18.inf", 
		"Mode=HTML", 
		"LAST");

	web_url("CheckLoginStatus_5", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea", 
		"Snapshot=t19.inf", 
		"Mode=HTML", 
		"EXTRARES", 
		 
		"Url=../app-resources/images/terminalmonitor/ico_terminal.png", "Referer=http://10.184.129.108/Platform/app-resources/css/terminalmonitor.css", "ENDITEM", 
		"Url=../app-resources/images/terminalmonitor/ico_fp.png", "Referer=http://10.184.129.108/Platform/app-resources/css/terminalmonitor.css", "ENDITEM", 
		"Url=../app-resources/images/terminalmonitor/ico_bpp.png", "Referer=http://10.184.129.108/Platform/app-resources/css/terminalmonitor.css", "ENDITEM", 
		"Url=../app-resources/images/terminalmonitor/ico_cpp.png", "Referer=http://10.184.129.108/Platform/app-resources/css/terminalmonitor.css", "ENDITEM", 
		"Url=../app-resources/images/terminalmonitor/terminal_2.png", "Referer=http://10.184.129.108/Platform/workarea/terminalmonitor", "ENDITEM", 
		"Url=../app-resources/images/terminalmonitor/terminal_0.png", "Referer=http://10.184.129.108/Platform/workarea/terminalmonitor", "ENDITEM", 
		"LAST");

	lr_end_transaction("User_login",2);
	

 
 
 

if (strcmp(lr_eval_string( "{SetStatusOfReportRand}"),"1") == 0){	
	web_reg_save_param("SetStatusOfReportWithoutExpand_unprinted",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");

		
	lr_start_transaction("SetStatusOfReportWithoutExpand_unprinted");
	
	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByStudyInstanceUID",
		"Method=POST",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"ReportPrintStatus\",\"StudyInstanceUID\":\"{ReportInstanceUID}\",\"PreStatusValue\":0,\"NewStatusValue\":0}",
		
		"LAST");
	
	lr_end_transaction("SetStatusOfReportWithoutExpand_unprinted", 2);
	
	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfReportWithoutExpand_unprinted}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfReportWithoutExpand_unprinted}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfReportWithoutExpand_unprinted fail");
	};

	lr_think_time(30);
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");
};

if (strcmp(lr_eval_string( "{SetStatusOfReportRand}"),"2") == 0){	
	
	web_reg_save_param("SetStatusOfReportWithoutExpand_printed",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");
	lr_start_transaction("SetStatusOfReportWithoutExpand_printed");

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByStudyInstanceUID",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"ReportPrintStatus\",\"StudyInstanceUID\":\"{ReportInstanceUID}\",\"PreStatusValue\":0,\"NewStatusValue\":1}",
		"LAST");
	lr_end_transaction("SetStatusOfReportWithoutExpand_printed", 2);
	
	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfReportWithoutExpand_printed}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfReportWithoutExpand_printed}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfReportWithoutExpand_printed fail");
	};

	lr_think_time(30);
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");	
};

if (strcmp(lr_eval_string( "{SetStatusOfReportRand}"),"3") == 0){	

	web_reg_save_param("SetStatusOfReportWithoutExpand_NOTprinted",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");

	lr_start_transaction("SetStatusOfReportWithoutExpand_NOTprinted");

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByStudyInstanceUID",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"ReportPrintStatus\",\"StudyInstanceUID\":\"{ReportInstanceUID}\",\"PreStatusValue\":0,\"NewStatusValue\":2}",
		"LAST");
	lr_end_transaction("SetStatusOfReportWithoutExpand_NOTprinted", 2);

	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfReportWithoutExpand_NOTprinted}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfReportWithoutExpand_NOTprinted}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfReportWithoutExpand_NOTprinted fail");
	};

	lr_think_time(30);
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");	
};

if (strcmp(lr_eval_string( "{SetStatusOfReportRand}"),"4") == 0){	
	
	web_reg_save_param("SetStatusOfReportWithExpand_unprinted",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");
	
	lr_start_transaction("SetStatusOfReportWithExpand_unprinted");

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByStudyInstanceUID",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"ReportPrintStatus\",\"StudyInstanceUID\":\"{ReportInstanceUID}\",\"PreStatusValue\":0,\"NewStatusValue\":0,\"IsExpanded\":true}",
		"LAST");
	lr_end_transaction("SetStatusOfReportWithExpand_unprinted", 2);

	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfReportWithExpand_unprinted}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfReportWithExpand_unprinted}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfReportWithExpand_unprinted fail");
	};

	lr_think_time(30);
	
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");	
	
};

if (strcmp(lr_eval_string( "{SetStatusOfReportRand}"),"5") == 0){	
		
	web_reg_save_param("SetStatusOfReportWithExpand_printed",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");
	
	lr_start_transaction("SetStatusOfReportWithExpand_printed");

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByStudyInstanceUID",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"ReportPrintStatus\",\"StudyInstanceUID\":\"{ReportInstanceUID}\",\"PreStatusValue\":0,\"NewStatusValue\":1,\"IsExpanded\":true}",
		"LAST");
	lr_end_transaction("SetStatusOfReportWithExpand_printed", 2);

	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfReportWithExpand_printed}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfReportWithExpand_printed}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfReportWithExpand_printed fail");
	};

	lr_think_time(30);
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");	
};

if (strcmp(lr_eval_string( "{SetStatusOfReportRand}"),"6") == 0){	
	web_reg_save_param("SetStatusOfReportWithExpand_NOTprinted",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");
	
	lr_start_transaction("SetStatusOfReportWithExpand_NOTprinted");

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByStudyInstanceUID",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"ReportPrintStatus\",\"StudyInstanceUID\":\"{ReportInstanceUID}\",\"PreStatusValue\":0,\"NewStatusValue\":2,\"IsExpanded\":true}",
		"LAST");
	lr_end_transaction("SetStatusOfReportWithExpand_NOTprinted", 2);

	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfReportWithExpand_NOTprinted}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfReportWithExpand_NOTprinted}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfReportWithExpand_NOTprinted fail");
	};

	lr_think_time(30);
	
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");	
};

	lr_think_time(30);
	
 
 
 

if (strcmp(lr_eval_string( "{SetStatusOfFilmRand}"),"1") == 0){	

	web_reg_save_param("SetStatusOfFilmWithoutExpand_unprinted",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");

	lr_start_transaction("SetStatusOfFilmWithoutExpand_unprinted");

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByAccessionNumber",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"FilmPrintStatus\",\"AccessionNumber\":\"{FilmStatusChangedACC}\",\"PreStatusValue\":0,\"NewStatusValue\":0,\"IsExpanded\":false}",
		"LAST");
	lr_end_transaction("SetStatusOfFilmWithoutExpand_unprinted", 2);

	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfFilmWithoutExpand_unprinted}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfFilmWithoutExpand_unprinted}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfFilmWithoutExpand_unprinted fail");
	};
	
	lr_think_time(30);
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");	
};

if (strcmp(lr_eval_string( "{SetStatusOfFilmRand}"),"2") == 0){	
	
	web_reg_save_param("SetStatusOfFilmWithoutExpand_printed",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");
	
	lr_start_transaction("SetStatusOfFilmWithoutExpand_printed");

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByAccessionNumber",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"FilmPrintStatus\",\"AccessionNumber\":\"{FilmStatusChangedACC}\",\"PreStatusValue\":0,\"NewStatusValue\":1,\"IsExpanded\":false}",
		"LAST");
	lr_end_transaction("SetStatusOfFilmWithoutExpand_printed", 2);

	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfFilmWithoutExpand_printed}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfFilmWithoutExpand_printed}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfFilmWithoutExpand_printed fail");
	};
	
	lr_think_time(30);
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");	
};

if (strcmp(lr_eval_string( "{SetStatusOfFilmRand}"),"3") == 0){	

	web_reg_save_param("SetStatusOfFilmWithoutExpand_NOTprinte",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");
	
	lr_start_transaction("SetStatusOfFilmWithoutExpand_NOTprinte");

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByAccessionNumber",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"FilmPrintStatus\",\"AccessionNumber\":\"{FilmStatusChangedACC}\",\"PreStatusValue\":0,\"NewStatusValue\":2,\"IsExpanded\":false}",
		"LAST");
	lr_end_transaction("SetStatusOfFilmWithoutExpand_NOTprinte", 2);

	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfFilmWithoutExpand_NOTprinte}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfFilmWithoutExpand_NOTprinte}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfFilmWithoutExpand_NOTprinte fail");
	};
	
	lr_think_time(30);
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");	
};

if (strcmp(lr_eval_string( "{SetStatusOfFilmRand}"),"4") == 0){	

	web_reg_save_param("SetStatusOfFilmWithExpand_unprinted",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");	
	
	lr_start_transaction("SetStatusOfFilmWithExpand_unprinted");

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByAccessionNumber",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"FilmPrintStatus\",\"AccessionNumber\":\"{FilmStatusChangedACC}\",\"PreStatusValue\":0,\"NewStatusValue\":0,\"IsExpanded\":true}",
		"LAST");
	lr_end_transaction("SetStatusOfFilmWithExpand_unprinted", 2);

	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfFilmWithExpand_unprinted}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfFilmWithExpand_unprinted}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfFilmWithExpand_unprinted fail");
	};
	
	lr_think_time(30);
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");	
};

if (strcmp(lr_eval_string( "{SetStatusOfFilmRand}"),"5") == 0){	

	
	web_reg_save_param("SetStatusOfFilmWithExpand_printed",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");
	
	lr_start_transaction("SetStatusOfFilmWithExpand_printed");

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByAccessionNumber",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"FilmPrintStatus\",\"AccessionNumber\":\"{FilmStatusChangedACC}\",\"PreStatusValue\":0,\"NewStatusValue\":1,\"IsExpanded\":true}",
		"LAST");
	lr_end_transaction("SetStatusOfFilmWithExpand_printed", 2);


	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfFilmWithExpand_printed}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfFilmWithExpand_printed}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfFilmWithExpand_printed fail");
	};
	
	lr_think_time(30);
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");	
};

if (strcmp(lr_eval_string( "{SetStatusOfFilmRand}"),"6") == 0){	

	web_reg_save_param("SetStatusOfFilmWithExpand_NOTprinted",
		"LB=\"isSucceed\":",
		"RB=\,\"workItem\"",
		"LAST");
	
	
	lr_start_transaction("SetStatusOfFilmWithExpand_NOTprinted");

	web_custom_request("web_custom_request",
		"URL=http://10.184.129.108/webapi/api/worklist/UpdateStatusByAccessionNumber",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=http://10.184.129.108/Platform/workarea/worklist",
		"Mode=HTML", 
		"EncType=application/json;charset=UTF-8", 
		"Body={\"StatusType\":\"FilmPrintStatus\",\"AccessionNumber\":\"{FilmStatusChangedACC}\",\"PreStatusValue\":0,\"NewStatusValue\":2,\"IsExpanded\":true}",
		"LAST");
	lr_end_transaction("SetStatusOfFilmWithExpand_NOTprinted", 2);

	lr_log_message("The result is:  %s", lr_eval_string("{SetStatusOfFilmWithExpand_NOTprinted}"));
	
	if(strcmp(lr_eval_string("{SetStatusOfFilmWithExpand_NOTprinted}"),"true") != 0)
	{
		lr_fail_trans_with_error("SetStatusOfFilmWithExpand_NOTprinted fail");
	};
	
	lr_think_time(30);
	
	web_url("CheckLoginStatus_25", 
		"URL=http://10.184.129.108/Platform/Account/CheckLoginStatus", 
		"Resource=0", 
		"Referer=http://10.184.129.108/Platform/workarea/worklist", 
		"Snapshot=t64.inf", 
		"Mode=HTML", 
		"LAST");	
};
	
	lr_think_time(30);
	


};
	
	return 0;
}
# 5 "d:\\performance\\mr1\\webclient - mr1\\puma_worklist_webhttphtml\\\\combined_Puma_worklist_WebHttpHtml.c" 2

# 1 "vuser_end.c" 1
vuser_end()
{
	return 0;
}
# 6 "d:\\performance\\mr1\\webclient - mr1\\puma_worklist_webhttphtml\\\\combined_Puma_worklist_WebHttpHtml.c" 2

