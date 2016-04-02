#define STRICT
#include <windows.h>

#pragma hdrstop


#include <stdio.h>
#include <string.h>


#include "inikey.h"


HANDLE OpenIniFile(char *filename)
{
//**
    HANDLE hFile;
    hFile=CreateFile(filename,GENERIC_READ|GENERIC_WRITE,
    		FILE_SHARE_READ|FILE_SHARE_WRITE,NULL,OPEN_ALWAYS,0,NULL);
            
    return hFile;

}

void CloseIniFile(HANDLE hFile)
{
//**
 	CloseHandle(hFile);
}

BOOL GetIniKey(HANDLE hFile,const char *section, const char *key,char *value)
{
//**

   if(!strlen(section) || !strlen(key) )
	return FALSE;



    DWORD dwFileSize;
    dwFileSize=GetFileSize(hFile, NULL);
    LPSTR ini_string;
    ini_string =(LPSTR) GlobalAlloc(GPTR, dwFileSize + 1);
    DWORD dwRead;
    SetFilePointer(hFile,0,NULL,FILE_BEGIN);
    ReadFile(hFile, ini_string, dwFileSize, &dwRead, NULL);
    ini_string[dwFileSize] = 0; // Add null terminator


    char *key_str= (char*) GlobalAlloc(GPTR, strlen(key)+4);
    int key_length=sprintf(key_str,"\r\n%s=",key);

   	const char *section_begin=strstr(ini_string,section);

    if (section_begin != NULL) { // section found
    	const char *section_end=strstr(section_begin+strlen(section),"[");


       if (section_end != NULL) // if last section
            ini_string[section_end-ini_string]=0;

        const char *key_begin=strstr(section_begin+strlen(section),key_str);

        if (key_begin != NULL) {  // key found
        	const char *value_end=strstr(key_begin+key_length,"\r\n");

            if (value_end != NULL)
            	ini_string[value_end-ini_string]=0;

            strcpy(value,key_begin+key_length);


            if(strlen(value)==0)
            	return FALSE;
            GlobalFree(key_str);
            GlobalFree(ini_string);
            return TRUE;
        }
    }
    GlobalFree(key_str);
    GlobalFree(ini_string);
    value[0]=0;
    return FALSE;
}

BOOL GetIniKey1(const char * string,const char *section, const char *key,char *value)
{
//**

	LPSTR ini_string;
    ini_string =(LPSTR) GlobalAlloc(GPTR, strlen(string) + 1);
    strcpy(ini_string,string);

    char *key_str= (char*) GlobalAlloc(GPTR, strlen(key)+4);
    int key_length=sprintf(key_str,"\r\n%s=",key);

   	const char *section_begin=strstr(ini_string,section);

    if (section_begin != NULL) { // section found
    	const char *section_end=strstr(section_begin+strlen(section),"[");


       if (section_end != NULL) // last section
            ini_string[section_end-ini_string]=0;

        const char *key_begin=strstr(section_begin+strlen(section),key_str);

        if (key_begin != NULL) {  // key found
        	const char *value_end=strstr(key_begin+key_length,"\r\n");

            if (value_end != NULL)
            	ini_string[value_end-ini_string]=0;

            strcpy(value,key_begin+key_length);
            if(strlen(value)==0)
            	return FALSE;
            GlobalFree(key_str);
            GlobalFree(ini_string);
            return TRUE;
        }
    }
    GlobalFree(key_str);
    GlobalFree(ini_string);
    value[0]=0;
    return FALSE;
}

void SetIniKey(HANDLE hFile,const char *section,const char *key, const char *value)
{
//**

    DWORD dwFileSize;
    dwFileSize=GetFileSize(hFile, NULL);
    LPSTR ini_string;
    ini_string =(LPSTR) GlobalAlloc(GPTR, dwFileSize + 1);
    DWORD dwRead;
    SetFilePointer(hFile,0,NULL,FILE_BEGIN);
    ReadFile(hFile, ini_string, dwFileSize, &dwRead, NULL);
    ini_string[dwFileSize] = 0; // Add null terminator


    char *key_str= (char*) GlobalAlloc(GPTR, strlen(key)+4);
    int key_length=sprintf(key_str,"\r\n%s=",key);
    char *tren=(char*) GlobalAlloc(GPTR,
    			strlen(section)+key_length+strlen(value)+10);


    char *section_begin=strstr(ini_string,section);

    if (section_begin != NULL) {
       	char *section_end=strstr(section_begin+strlen(section),"[");

         if (section_end == NULL)
        	section_end=ini_string+strlen(ini_string);

        char *key_begin=strstr(section_begin+strlen(section),key_str);

        if ((key_begin != NULL) && (key_begin<section_end)) {
        	char *value_end=strstr(key_begin+key_length,"\r\n");

            if (value_end == NULL)
            	value_end=ini_string+strlen(ini_string);

            SetFilePointer(hFile,0,NULL,FILE_BEGIN);
            WriteFile(hFile,ini_string,key_begin-ini_string,&dwRead,NULL);
            sprintf(tren,"%s%s",key_str,value);
            WriteFile(hFile,tren,strlen(tren),&dwRead,NULL);
            WriteFile(hFile,value_end,
            			strlen(value_end),&dwRead,NULL);

             SetEndOfFile(hFile);

        }
        else { // there is no key

             SetFilePointer(hFile,0,NULL,FILE_BEGIN);
             WriteFile(hFile,ini_string,section_begin+strlen(section)-ini_string,
                       &dwRead,NULL);

            sprintf(tren,"%s%s",key_str,value);
            WriteFile(hFile,tren,strlen(tren),&dwRead,NULL);
            WriteFile(hFile,section_begin+strlen(section),
            			strlen(section_begin+strlen(section)),&dwRead,NULL);


       }
    }
    else { // there is no section

        sprintf(tren,"\r\n%s%s%s\r\n",section,key_str,value);
        WriteFile(hFile,tren,strlen(tren),&dwRead,NULL);
    }

	GlobalFree( key_str);
    GlobalFree(tren);
   	GlobalFree(ini_string);

}
