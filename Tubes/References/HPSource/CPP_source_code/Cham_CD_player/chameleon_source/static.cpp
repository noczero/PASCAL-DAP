#define STRICT
#include <windows.h>

#pragma hdrstop

#include <stdio.h>

#include "static.h"


TCHAR PropStaticStr[] ="StaticProperty";


void InitializeST(HWND hwnd,BITMAPFONT *bmf,CUSTOMDRAWTABLE *cdt,HBITMAP *background)
{

	STATIC *st;
    st = (STATIC *)HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY,sizeof(STATIC));
    st->bmf=bmf;
    st->cdt=cdt;
    st->background=background;
    st->scroll=FALSE;
    st->oldproc = (WNDPROC)SetWindowLong(hwnd, GWL_WNDPROC, (LONG)StaticSubclassProc);
    SetProp(hwnd,PropStaticStr,(HANDLE)st);

}


LRESULT CALLBACK StaticSubclassProc(HWND hwnd,UINT uMsg,WPARAM wParam,LPARAM lParam)
{
	STATIC *st=(STATIC *)GetStatic(hwnd);

	switch(uMsg)
   	{

    	case WM_PAINT:
        {
        	PAINTSTRUCT ps;
    		HDC hdc;
        	hdc = BeginPaint(hwnd, &ps);
        		DrawStatic(hwnd,st,hdc);
            EndPaint(hwnd,&ps);
        }
        break;




        case WM_SETTEXT:
        	// avoid redrawing when set text
        return 0;


        case WM_LBUTTONDOWN:
        	SendMessage(GetParent(hwnd),
            	CM_STATIC_LBUTTONDOWN,(WPARAM)hwnd,(LPARAM)GetWindowLong(hwnd,GWL_ID));
        return 0;
         
        
    	case WM_DESTROY:

    		WNDPROC oldproc = st->oldproc;
			UninitializeST(hwnd);
			//we must call the original window procedure
        return CallWindowProc(oldproc, hwnd, uMsg, wParam, lParam);

    }

        return CallWindowProc(st->oldproc, hwnd, uMsg, wParam, lParam);

}

STATIC *GetStatic(HWND hwnd)
{
	return (STATIC *)GetProp(hwnd, PropStaticStr);
}


BOOL WINAPI UninitializeST(HWND hwnd)
{

	STATIC *st = GetStatic(hwnd);
	if(!st) return 0;


	//restore the window procedure with the original one
	SetWindowLong(hwnd, GWL_WNDPROC, (LONG)st->oldproc);

	RemoveProp(hwnd, PropStaticStr);
	//finally, release the memory needed for the cool scrollbars
	HeapFree(GetProcessHeap(), 0, st);

    return TRUE;

}




void DrawStatic(HWND hwnd,STATIC *st,HDC hdc)
{

    HDC hdcmem = CreateCompatibleDC(hdc);
    HDC hdcBuffer = CreateCompatibleDC(hdc);
    HBITMAP hbmOldBuffer;
    HBITMAP hbmOld;

    RECT rect;
    GetClientRect(hwnd,&rect);

    HBITMAP hbmBuffer = CreateCompatibleBitmap(hdc,
   						rect.right,
                        rect.bottom);

    hbmOldBuffer=(HBITMAP)SelectObject(hdcBuffer, hbmBuffer);

    hbmOld=(HBITMAP)SelectObject(hdcmem,st->background[st->cdt->stdt.bitmapindex]);
    // draw background in buffer
    FillRectWithPattern(hdcBuffer,&rect,hdcmem,&st->cdt->stdt.pattern);



    int bwidth,bheight;
    // create bitmap form text
    HBITMAP hbm=DrawTextToBitmap(hdc,st->text,&st->bmf[st->cdt->stdt.fontindex],&bwidth,&bheight);
   
    // create mask of bitmap text ( transparent text)
    HBITMAP mask=CreateBitmapMask(hbm, MAKECOLORREF(st->bmf[st->cdt->stdt.fontindex].bgColor));
    SelectObject(hdcmem,mask);

    // draw mask in buffer
    BitBlt(hdcBuffer,0,0,bwidth,bheight,hdcmem,
     			0,0,SRCAND);

     SelectObject(hdcmem,hbm);
     // draw text in buffer
     BitBlt(hdcBuffer,0,0,bwidth,bheight,hdcmem,
     			0,0,SRCPAINT);

     // draw buffer on screen
     BitBlt(hdc,
  			0,
  			0,
            rect.right,
            rect.bottom,
            hdcBuffer,
            0,
            0,
            SRCCOPY);


 //restore old object an delete hdc
  	SelectObject(hdcmem, hbmOld);
   DeleteDC(hdcmem);

   //restore old object an delete hdc
   SelectObject(hdcBuffer, hbmOldBuffer);
   DeleteDC(hdcBuffer);

   //delete memory buffer
   DeleteObject(hbmBuffer);
   DeleteObject(hbm);
   DeleteObject(mask);

}



void SetStaticText(HWND hwnd,char* text)
{
    STATIC *st=(STATIC *)GetStatic(hwnd);
    if(st) {
        RECT rect;
        GetClientRect(hwnd,&rect);
        if(GetTextWidth(text,st->bmf) > rect.right) { // if need to scroll text
        	st->scroll=TRUE;
            sprintf(st->text,"%s ++ ",text);
        }
        else {
        	st->scroll=FALSE;
            strcpy(st->text,text);
        }
        InvalidateRect(hwnd,NULL,FALSE);
    }
}

BOOL ScrollStaticText(HWND hwnd)
{
	STATIC *st=GetStatic(hwnd);
    if(st->scroll) {
    	ScrollText(st->text);
       InvalidateRect(hwnd,NULL,FALSE);
       return TRUE;
    }
    return FALSE;
}

void ScrollText(char *text)
{
	if(strlen(text)>1) {
		char first[2];
    	first[0]=*text;
    	first[1]=0;
    	sprintf(text,"%s%s",text+1,first);
    }
}
