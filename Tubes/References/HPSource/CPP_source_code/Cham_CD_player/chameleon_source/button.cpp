#define STRICT
#include <windows.h>

#pragma hdrstop


#include "button.h"

TCHAR PropButtonStr[] ="ButtonProperty";

void InitializeBT(HWND hwnd,HBITMAP *bitmap,CUSTOMDRAWTABLE *cdt)
{

	BUTTON *bt;
    bt=(BUTTON *)HeapAlloc(GetProcessHeap(),
    		 HEAP_ZERO_MEMORY, sizeof(BUTTON));

    LONG dwSt=GetWindowLong(hwnd,GWL_STYLE);

    if ( dwSt & BS_AUTOCHECKBOX)
    	bt->style=BS_AUTOCHECKBOX;
    else
    	bt->style=BS_PUSHBUTTON;

    bt->checked=FALSE;

    bt->oldproc = (WNDPROC)SetWindowLong(hwnd,GWL_WNDPROC,(LONG)ButtonSubclassProc);

   	bt->bitmap=bitmap;
	bt->cdt=cdt;
   	bt->pushed=FALSE;
   	SetProp(hwnd, PropButtonStr,(HANDLE)bt);
}

void ButtonDownBT(HWND hwnd,BUTTON *bt)
{
    SetForegroundWindow(GetParent(hwnd));
	SetCapture(hwnd);
    bt->pushed=TRUE;
    InvalidateRect(hwnd,NULL,FALSE);
}

void ButtonUpBT(HWND hwnd, LPARAM lParam,BUTTON *bt)
{

    RECT rect;
    GetClientRect(hwnd,&rect);

	POINT pt;
    pt.x= LOWORD(lParam);
    pt.y= HIWORD(lParam);

    ReleaseCapture();

    if(PtInRect(&rect,pt)) { // in button rect
        if(bt->style == BS_AUTOCHECKBOX)
    	   	bt->checked=!bt->checked;

        	 bt->pushed=FALSE;
    		InvalidateRect(hwnd,NULL,FALSE);
            UpdateWindow(hwnd);

        LONG ButtonID=GetWindowLong(hwnd,GWL_ID);
       //SendMessage(GetParent(hwnd),WM_COMMAND,MAKEWPARAM(ButtonID,BN_CLICKED),
       				//(LPARAM)hwnd);
         PostMessage(GetParent(hwnd),WM_COMMAND,MAKEWPARAM(ButtonID,BN_CLICKED),
       				(LPARAM)hwnd);
    }

    bt->pushed=FALSE;
	InvalidateRect(hwnd,NULL,FALSE);
    //UpdateWindow(hwnd);
}

void DrawButton(HDC  hdc,HWND hwnd,BUTTON *bt)
{

	POINT pt;
    RECT rect;
    int state;

    GetCursorPos(&pt);
    GetWindowRect(hwnd,&rect);

    if(PtInRect(&rect,pt))
    	if(bt->pushed)
    		state=PUSHED;
        else
        	state=HIGHLIGHT;
    else
    	state=NORMAL;


    if (bt->checked)
    	state=PUSHED;

   	HDC hdcmem = CreateCompatibleDC(hdc);
   	HBITMAP hbmOld=(HBITMAP)SelectObject(hdcmem,bt->bitmap[bt->cdt->bdt.bitmapindex]);

   	GetClientRect(hwnd,&rect);

    BitBlt(hdc,
        	0,
        	0,
        	rect.right,
        	rect.bottom,
        	hdcmem,
        	bt->cdt->bdt.bitmap[state].x,
            bt->cdt->bdt.bitmap[state].y,
        	SRCCOPY);


   //restore old object an delete hdc
   SelectObject(hdcmem, hbmOld);
   DeleteDC(hdcmem);

   ValidateRect(hwnd,NULL);
}


LRESULT CALLBACK ButtonSubclassProc(HWND hwnd,UINT uMsg,WPARAM wParam,LPARAM lParam)
{
  BUTTON *bt=(BUTTON *)GetButton(hwnd);

	switch(uMsg)
   	{
    	case WM_PAINT:
        {
        	PAINTSTRUCT ps;
    		HDC hdc;
        	hdc = BeginPaint(hwnd, &ps);
           	DrawButton(hdc,hwnd,bt);
            EndPaint(hwnd,&ps);
        }
        return 0;

       

        case WM_LBUTTONDOWN:
              ButtonDownBT(hwnd,bt);
        return 0;

        case WM_MOUSEMOVE:
			MouseMoveBT(hwnd,wParam,lParam);

        return 0;

        case WM_LBUTTONUP:
            ButtonUpBT(hwnd,lParam,bt);
        return 0;

        case WM_LBUTTONDBLCLK:
        	PostMessage(hwnd,WM_LBUTTONDOWN,wParam,lParam);
        return 0;


        case WM_DESTROY:
    		WNDPROC oldproc = bt->oldproc;
			UninitializeBT(hwnd);
			//we must call the original window procedure
        return CallWindowProc(oldproc, hwnd, uMsg, wParam, lParam);

     }

    return CallWindowProc(bt->oldproc, hwnd, uMsg, wParam, lParam);
}

BUTTON *GetButton(HWND hwnd)
{
	return (BUTTON *)GetProp(hwnd, PropButtonStr);
}



void MouseMoveBT(HWND hwnd, WPARAM wParam, LPARAM lParam)
{

	static BOOL block;
    RECT rect;
    POINT pt;

    GetClientRect(hwnd,&rect);
    pt.x= LOWORD(lParam);
    pt.y= HIWORD(lParam);

   if(PtInRect(&rect,pt)) { // in button rect
       	if((GetCapture()!=hwnd) || !block) { //block multiple redraw
        	SetCapture(hwnd);
            InvalidateRect(hwnd,NULL,FALSE);
            block=TRUE;
       }
    }
    else { // out of button rect
        if(wParam!=MK_LBUTTON) { // not LEFT MOUSE BUTTON DRAG
        	ReleaseCapture();
            block=FALSE;
            InvalidateRect(hwnd,NULL,FALSE);
        }
        else { // LEFT MOUSE BUTTON DRAG
        	if(block) { // block multiple redraw
               InvalidateRect(hwnd,NULL,FALSE);
               block=FALSE;
            }
        }
    }
}


BOOL SetButtonCheckState(HWND hwnd,BOOL state,BOOL fRedraw)
{

 BUTTON *bt=(BUTTON *) GetButton(hwnd);
 if(!bt) return 0;
 bt->checked=state;
 if(fRedraw)
 InvalidateRect(hwnd,NULL,FALSE);
 return TRUE;

}

BOOL GetButtonCheckState(HWND hwnd)
{

 	BUTTON *bt=(BUTTON *) GetButton(hwnd);
    if(!bt) return 0;
 	return bt->checked;

}

BOOL WINAPI UninitializeBT(HWND hwnd)
{
	BUTTON *bt = GetButton(hwnd);
	if(!bt) return 0;

	//restore the window procedure with the original one
	SetWindowLong(hwnd, GWL_WNDPROC, (LONG)bt->oldproc);

	RemoveProp(hwnd, PropButtonStr);

	//finally, release the memory needed for the cool scrollbars
	HeapFree(GetProcessHeap(), 0, bt);
	return TRUE;
}


