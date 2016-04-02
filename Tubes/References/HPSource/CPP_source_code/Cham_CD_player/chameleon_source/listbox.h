#ifndef MYLISTBOX
#define MYLISTBOX

//#include <windows.h>

//#include <math.h>

//#include "global.h"

#include "skin.h"

#define CM_LISTBOX_NOTIFY WM_USER+2

typedef struct {

WNDPROC 	oldproc; // original procedure
HBITMAP		*background; // background
CUSTOMDRAWTABLE *cdt;
int			leftindent; // left text indent
int 		active; // active row ( current playling song)
BITMAPFONT  *bmf; // bitmap font

} LISTBOX;


void DrawListBox(HWND hwnd,LISTBOX *lb,HDC hdc);
BOOL InitializeLB(HWND hwnd,HBITMAP *background,CUSTOMDRAWTABLE *cdt,BITMAPFONT *bmf);
BOOL WINAPI UninitializeLB(HWND hwnd);
LISTBOX *GetListBox(HWND hwnd);
BOOL ListBoxNotifySelChange(HWND hwnd);
void ListBoxAddString(HWND hwnd, char * text,WORD data,BOOL fRedraw);
void ListBoxDeleteAll(HWND hwnd,BOOL fRedraw);
void ListBoxSelectItem(HWND hwnd,int index,BOOL fRedraw);
void ListBoxDeleteString(HWND hwnd,int index, BOOL fRedraw);
WORD ListBoxGetData(HWND hwnd,int index);
BOOL FillPlaylist (HWND hwnd);
int ListBoxGetCount(HWND hwnd);
int ListBoxGetCurSel(HWND hwnd);
int ListBoxGetIndex(HWND hwnd,WORD data);
void ListBoxInsertString(HWND hwnd, char * text,int index,WORD data, BOOL fRedraw);
void ListBoxGetText(HWND hwnd,int index, char * text);
void ListBoxContentsChangeNotify(HWND hwnd);

void ListBoxSetActive(HWND hwnd, int index,BOOL fRedraw);

void ListBoxUpdateScroll(HWND hwnd_playllst,HWND hwnd_scroll);

LRESULT CALLBACK ListBoxSubclassProc(HWND hwnd,UINT uMsg,WPARAM wParam,LPARAM lParam);



#endif
