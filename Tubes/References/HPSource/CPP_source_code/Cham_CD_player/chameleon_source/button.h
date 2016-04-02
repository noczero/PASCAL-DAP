#ifndef MYBUTTON
#define MYBUTTON

//#include <windows.h>

//#include "global.h"

#include "skin.h"



typedef struct {
WNDPROC 	oldproc; 	// old procedure, need for subclassing
HBITMAP	    *bitmap;	//  pointer on array of bitmaps
CUSTOMDRAWTABLE	*cdt;
BOOL		pushed;	//
LONG		style; // BS_PUSHBUTTON / BS_AUTO3STATE
BOOL		checked;

} BUTTON;


void DrawButton(HDC hdc,HWND hwnd,BUTTON *bt);
void ButtonDownBT(HWND hwnd,BUTTON *bt);
void ButtonUpBT(HWND hwnd, LPARAM lParam,BUTTON *bt);
void InitializeBT(HWND hwnd,HBITMAP *bitmap,CUSTOMDRAWTABLE *cdt);
BUTTON *GetButton(HWND hwnd);
void MouseMoveBT(HWND hwnd, WPARAM wParam, LPARAM lParam);
BOOL WINAPI UninitializeBT(HWND hwnd);
BOOL SetButtonCheckState(HWND hwnd,BOOL state,BOOL fRedraw);
BOOL GetButtonCheckState(HWND hwnd);


LRESULT CALLBACK ButtonSubclassProc(HWND hwnd,UINT uMsg,WPARAM wParam,LPARAM lParam);


#endif
