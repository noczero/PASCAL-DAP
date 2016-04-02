#ifndef MYSCROLL
#define MYSCROLL

#include "skin.h"

typedef struct {

WNDPROC 	oldproc; 	// old procedure, need for subclassing
LONG			style;	//SB_HORZ / SB_VERT
HBITMAP	    *bitmap; // thumb bitmap
CUSTOMDRAWTABLE *cdt;
int			t_cur_indent; // need for moving thumb
BOOL		pushed; // thumb state
BOOL		user_draw; // block application drawing when user move thumb
int			thumb_pos;
HBITMAP		*background; // pattern ( background)
} SCROLLBAR;


void ButtonUpSB(HWND hwnd, LPARAM lParam,SCROLLBAR *sc);
void SetPosSB(HWND hwnd,int pos,BOOL fRedraw);
void MouseMoveSB(HWND hwnd, WPARAM wParam, LPARAM lParam,SCROLLBAR *sc);
void ButtonDownSB(HWND hwnd, LPARAM lParam,SCROLLBAR *sc);
void WINAPI InitializeSB(HWND hwnd,HBITMAP *bitmap,CUSTOMDRAWTABLE *cdt);
BOOL WINAPI UninitializeSB(HWND hwnd);
SCROLLBAR *GetScrollbar(HWND hwnd);
void DrawScrollbar(HWND hwnd,int thumb_pos,SCROLLBAR *sc);
int GetThumbPos(HWND hwnd);
int GetScrollPosFromThumbPos(HWND hwnd, int thumb_pos);


#endif
