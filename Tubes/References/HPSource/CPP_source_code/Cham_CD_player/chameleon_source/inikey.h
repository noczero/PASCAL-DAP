#ifndef INIKEY
#define INIKEY


HANDLE OpenIniFile(char *filename);
BOOL GetIniKey(HANDLE hFile,const char *section, const char *key,char *value);
void CloseIniFile(HANDLE hFile);
void SetIniKey(HANDLE hFile,const char *section,const char *key, const char *value);



#endif
