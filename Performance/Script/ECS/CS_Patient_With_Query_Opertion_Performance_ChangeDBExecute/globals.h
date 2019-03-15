#ifndef _GLOBALS_H
#define _GLOBALS_H

//--------------------------------------------------------------------
// Include Files
#include "lrun.h"
#include "web_api.h"
#include "lrw_custom_body.h"
#include "as_web.h"
#include "wssoap.h"
#include "SharedParameter.h"
#include "time.h"

	int rc; // return code
	int db_connection; // Declaractions is a bit dodgy. Should really use MYSQL defined in mysql.h
	int query_result; // Declaractions is a bit dodgy. Should really use MYSQL_RES defined in mysql.h
	char** result_row; // Return data as array of strings. Declaractions is a bit dodgy. Should really use MYSQL_ROW defined in mysql.h
	char *server = "10.184.129.203";
	char *user = "sa";
	char *password = "sa20021224$"; // very naughty to leave default root account with no password :)
	char *database = "ECS";
	int port = 3306; // default MySQL port
	int unix_socket = NULL; // leave this as null
	int flags = 0; // no flags

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
//--------------------------------------------------------------------
// Global Variables

#endif // _GLOBALS_H
