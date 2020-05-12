#ifndef _GLOBALS_H
#define _GLOBALS_H
//--------------------------------------------------------------------
// Include Files
#include "lrun.h"
#include "web_api.h"
#include "lrw_custom_body.h"
#include "as_web.h"
#include "lrw_custom_body.h"
#include "wssoap.h"
//--------------------------------------------------------------------
// Global Variables

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
#endif // _GLOBALS_H
