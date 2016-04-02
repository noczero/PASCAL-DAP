#ifndef MYSTATIC
#define MYSTATIC


//#include "global.h"

#include "skin.h"

#define CM_STATIC_LBUTTONDOWN WM_USER+1

typedef struct {

WNDPROC 	oldproc;
HBITMAP	    *bitmap;
char 		text[200];
HBITMAP		*background;
CUSTOMDRAWTABLE *cdt;
BITMAPFONT  *bmf;
BOOL		scroll; // scroll text flag

} STATIC;

LRESULT CALLBACK StaticSubclassProc(HWND hwnd,UINT uMsg,WPARAM wParam,LPARAM lParam);

STATIC *GetStatic(HWND hwnd);
void DrawStatic(HWND hwnd,STATIC *st,HDC hdc);
void SetStaticText(HWND hwnd,char* text);
BOOL WINAPI UninitializeST(HWND hwnd);
void InitializeST(HWND hwnd,BITMAPFONT *bmf,CUSTOMDRAWTABLE *cdt,HBITMAP *background);
BOOL ScrollStaticText(HWND hwnd);
void ScrollText(char *text);



#endif
