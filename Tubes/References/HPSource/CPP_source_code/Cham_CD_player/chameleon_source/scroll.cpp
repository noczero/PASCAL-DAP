#define STRICT
#include <windows.h>

#pragma hdrstop


#include "scroll.h"

TCHAR ProScrollbarStr[] ="ScrollbarProperty";


LRESULT CALLBACK ScrollSubclassProc(HWND hwnd,UINT uMsg,WPARAM wParam,LPARAM lParam)
{
	SCROLLBAR *sc=(SCROLLBAR *)GetScrollbar(hwnd);

	switch(uMsg)
   	{

		case WM_PAINT:
        	if (!sc->user_draw) {	// block when user move thumb
   				int thumb_pos=GetThumbPos(hwnd);
        		DrawScrollbar(hwnd,thumb_pos,sc);
        	}
            ValidateRect(hwnd,NULL); // there is no BeginPaint and EndPaint
                                       // so must validate window to avoid
                                    // constant redrawing
   		break;

   		case WM_LBUTTONDOWN:
   			ButtonDownSB(hwnd,lParam,sc);
   		return 0; //must block this message


   		case  WM_LBUTTONUP:
   			ButtonUpSB(hwnd, lParam,sc);
   		return 0; //must block this message

		case WM_MOUSEMOVE:
			MouseMoveSB(hwnd,wParam,lParam,sc);
		break;

   		case  WM_LBUTTONDBLCLK:
            
   		return 0; //must block this message

    	case WM_DESTROY:
    	{

    		SCROLLBAR *sc=GetScrollbar(hwnd);
    		WNDPROC oldproc = sc->oldproc;
			UninitializeSB(hwnd);

			//we must call the original window procedure

			return CallWindowProc(oldproc, hwnd, uMsg, wParam, lParam);
        }
	}

  	return CallWindowProc(sc->oldproc, hwnd, uMsg, wParam, lParam);

}


int GetThumbPos(HWND hwnd)
{

	//******** convert scrollbar position in thumb position*********

    RECT rect;
    GetClientRect(hwnd,&rect);
    SCROLLINFO scrollinfo;
    scrollinfo.cbSize=sizeof(scrollinfo);
    scrollinfo.fMask=SIF_ALL;
    GetScrollInfo(hwnd,SB_CTL,&scrollinfo);

    SCROLLBAR *sc;
    sc= (SCROLLBAR *)GetScrollbar(hwnd);

    if (sc->style==SBS_VERT)
    	return MulDiv(scrollinfo.nPos-scrollinfo.nMin,
           				rect.bottom - sc->cdt->scdt.thumbLength,
                        scrollinfo.nMax-scrollinfo.nMin);
    else
    	return MulDiv(scrollinfo.nPos-scrollinfo.nMin,
           				rect.right - sc->cdt->scdt.thumbLength,
                        scrollinfo.nMax-scrollinfo.nMin);

    //******************************************************************
}


int GetScrollPosFromThumbPos(HWND hwnd, int thumb_pos)
{

	RECT rect;
    GetClientRect(hwnd,&rect);
	//******** convert thumb position in scrollbar position *********
    SCROLLINFO scrollinfo;

    scrollinfo.cbSize=sizeof(scrollinfo);
    scrollinfo.fMask=SIF_ALL;
    GetScrollInfo(hwnd,SB_CTL,&scrollinfo);
    //******************************************************************

     SCROLLBAR *sc;
     sc=(SCROLLBAR *)GetScrollbar(hwnd);

     if (sc->style==SBS_VERT)
     	return MulDiv(scrollinfo.nMax-scrollinfo.nMin,
           				thumb_pos,
                        rect.bottom-sc->cdt->scdt.thumbLength)+scrollinfo.nMin;
     else
     	return MulDiv(scrollinfo.nMax-scrollinfo.nMin,
           				thumb_pos,
                        rect.right-sc->cdt->scdt.thumbLength)+scrollinfo.nMin;

}


void SetPosSB(HWND hwnd,int pos,BOOL fRedraw)
{
 	SCROLLINFO scinfo;

    scinfo.cbSize=sizeof(scinfo);
    scinfo.fMask=SIF_POS;
    scinfo.nPos=pos;
    SetScrollInfo(hwnd,SB_CTL,&scinfo,FALSE);

    if (fRedraw)
    	RedrawWindow(hwnd,NULL,NULL,RDW_INTERNALPAINT);
}


void WINAPI InitializeSB(HWND hwnd,HBITMAP *bitmap,
			CUSTOMDRAWTABLE *cdt)


{
	SCROLLBAR *sb;

    //allocate a scrollbar structure which we
	//will use to keep track of the scrollbar data
    sb = (SCROLLBAR *)HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY,
    sizeof(SCROLLBAR));

	LONG dwSt=GetWindowLong(hwnd,GWL_STYLE);

    if ( dwSt & SBS_VERT ) { //#define SBS_VERT  0x0001L
    	sb->style=SBS_VERT;

    }
    else {
    	sb->style=SBS_HORZ;	//#define SBS_HORZ   0x0000L

    }

    // subclass scrollbar control window
    sb->oldproc = (WNDPROC)SetWindowLong(hwnd, GWL_WNDPROC, (LONG)ScrollSubclassProc);

   	sb->bitmap=bitmap;
   	sb->pushed=FALSE;
   	sb->cdt=cdt;

    SetProp(hwnd,ProScrollbarStr,(HANDLE)sb);
}



void MouseMoveSB(HWND hwnd, WPARAM wParam, LPARAM lParam,SCROLLBAR *sc)
{
	int thumb_pos;
    RECT rect,rect1;
    POINT pt;
    GetClientRect(hwnd,&rect1);

	if(wParam==MK_LBUTTON) { // LEFT MOUSE BUTTON DRAG

        GetCursorPos(&pt); 
        GetWindowRect(hwnd,&rect);

        int upper_limit;

        // calculate new thumb position
        if (sc->style==SBS_VERT) {
        	thumb_pos=pt.y - rect.top - sc->t_cur_indent;
            upper_limit=rect1.bottom - sc->cdt->scdt.thumbLength;



        }
        else {
        	thumb_pos=pt.x - rect.left - sc->t_cur_indent;
            upper_limit=rect1.right - sc->cdt->scdt.thumbLength;
        }

        if (thumb_pos <= 0)	// limit thumb position
        	thumb_pos=0;
        else
        	if (thumb_pos > upper_limit)
            	thumb_pos=upper_limit;

        DrawScrollbar(hwnd,thumb_pos,sc);
		int pos=GetScrollPosFromThumbPos(hwnd,thumb_pos);
        int oldpos=GetScrollPos(hwnd,SB_CTL);
        if (oldpos != pos) {

        	WORD message;
   	 		if(sc->style==SB_VERT)
     			message=WM_VSCROLL;
    		else
    			message= WM_HSCROLL;

        	SendMessage(GetParent(hwnd),message, MAKEWPARAM(SB_THUMBTRACK,pos),
        		(LPARAM)hwnd);
        }
    }
    else {	// HIGKLIGHT
		thumb_pos=GetThumbPos(hwnd);

        if (sc->style==SBS_VERT) {
        	rect.left=0;
            rect.top=thumb_pos;
            rect.right=rect1.right;
            rect.bottom=thumb_pos + sc->cdt->scdt.thumbLength;
        }
        else {
        	rect.left=thumb_pos;
            rect.top=0;
            rect.right=thumb_pos + sc->cdt->scdt.thumbLength;
            rect.bottom=rect1.bottom;
        }

        pt.x= LOWORD(lParam);
        pt.y= HIWORD(lParam);

     	if(PtInRect(&rect,pt)) {	// // in thumb rect
     		if(GetCapture() != hwnd) {	// block redraw
      			SetCapture(hwnd);
      			DrawScrollbar(hwnd,thumb_pos,sc);
     		}
     	}
     	else { // not in thumb rect
        	DrawScrollbar(hwnd,thumb_pos,sc);
        	ReleaseCapture();
     	}
    }
}


void ButtonDownSB(HWND hwnd, LPARAM lParam,SCROLLBAR *sc)
{
    SetForegroundWindow(GetParent(hwnd));

    RECT rect;
    GetClientRect(hwnd,&rect);

    SetCapture(hwnd);
	int thumb_pos=GetThumbPos(hwnd);
	int cur;
    int message;

    if (sc->style==SBS_VERT) {
    	message=WM_VSCROLL;
    	cur=HIWORD(lParam);
    }
    else {
    	cur=LOWORD(lParam);
    	message= WM_HSCROLL;
    }

    if(( thumb_pos < cur) && ((thumb_pos +sc->cdt->scdt.thumbLength) > cur)) //click on thumb
    {
    	sc->t_cur_indent=cur-thumb_pos;  // mouse position in thumb

        sc->pushed=TRUE;
        DrawScrollbar(hwnd,thumb_pos,sc); 
        int pos=GetScrollPos(hwnd,SB_CTL);
        SendMessage(GetParent(hwnd),message, MAKEWPARAM(SB_THUMBTRACK,pos),
        	(LPARAM)hwnd);
	}
    else { // click out of thumb
		int upper_limit;
        if (sc->style==SBS_VERT) // upper limit
        	upper_limit=rect.bottom - sc->cdt->scdt.thumbLength;
        else
        	upper_limit=rect.right-sc->cdt->scdt.thumbLength;


         //**** move when click on scrollbat shaft *********

        thumb_pos=cur-(sc->cdt->scdt.thumbLength/2);


        //****************************************************************
        sc->t_cur_indent=sc->cdt->scdt.thumbLength/2;

        if (thumb_pos <= 0) // limit position
        	thumb_pos=0;
        else
        	if (thumb_pos > upper_limit)
            	thumb_pos=upper_limit;

        sc->pushed=TRUE;

         //**** move when click on scrollbat shaft*********

        DrawScrollbar(hwnd,thumb_pos,sc);

         //****************************************************************

		int pos=GetScrollPosFromThumbPos(hwnd,thumb_pos);
        WORD notmessage;

        // ***************** ***************



         BOOL p;

         if(thumb_pos < cur) // which side of shaft
         	p=FALSE;
         else
         	p=TRUE;

   	 	if(sc->style==SB_VERT) {
            if(p) notmessage=SB_PAGEUP;
            else  notmessage=SB_PAGEDOWN;
        }
    	else {
            if(p) notmessage=SB_PAGELEFT;
            else  notmessage=SB_PAGERIGHT;
        }
        //****************************************************************

        //****  *********
        notmessage=SB_THUMBTRACK;
        //****************************************************************

        SendMessage(GetParent(hwnd),message, MAKEWPARAM(notmessage,pos),
        	 		(LPARAM)hwnd);
    }
}



void ButtonUpSB(HWND hwnd, LPARAM lParam,SCROLLBAR *sc)
{

    RECT rect;
    GetClientRect(hwnd,&rect);
    int thumb_pos=GetThumbPos(hwnd);


	if (sc->style==SBS_VERT) {
    	rect.left=0;
        rect.top=thumb_pos;
        rect.bottom=thumb_pos+sc->cdt->scdt.thumbLength;
    }
    else {
    	rect.left=thumb_pos;
        rect.top=0;
        rect.right=thumb_pos+sc->cdt->scdt.thumbLength;
    }

	POINT pt;
    pt.x= LOWORD(lParam);
    pt.y= HIWORD(lParam);

    sc->pushed=FALSE;



    int pos= GetScrollPosFromThumbPos(hwnd,thumb_pos);

    WORD message;
    if(sc->style==SB_VERT)
     	message=WM_VSCROLL;
    else
    	message= WM_HSCROLL;

   	SendMessage(GetParent(hwnd),message,
            		 MAKEWPARAM(SB_THUMBPOSITION,pos),
        	 		(LPARAM)hwnd);

     InvalidateRect(hwnd,NULL,FALSE);
    //RedrawWindow(hwnd,NULL,NULL,RDW_INTERNALPAINT);

}





SCROLLBAR *GetScrollbar(HWND hwnd)
{
	return (SCROLLBAR *)GetProp(hwnd, ProScrollbarStr);
}


BOOL WINAPI UninitializeSB(HWND hwnd)
{


	SCROLLBAR *sb = GetScrollbar(hwnd);
	if(!sb) return 0;

	//restore the window procedure with the original one
	SetWindowLong(hwnd, GWL_WNDPROC, (LONG)sb->oldproc);

	RemoveProp(hwnd, ProScrollbarStr);

	//finally, release the memory needed for the cool scrollbars
	HeapFree(GetProcessHeap(), 0, sb);
    return TRUE;
}

void DrawScrollbar(HWND hwnd,int thumb_pos,SCROLLBAR *sc)
 {

	POINT pt;
    RECT rect;
    BYTE state;

    GetCursorPos(&pt);
    GetWindowRect(hwnd,&rect);

    if (sc->style==SBS_VERT) {
    	rect.top+=thumb_pos;
        rect.bottom=rect.top+sc->cdt->scdt.thumbLength;
    }
    else {
    	rect.left+=thumb_pos;
        rect.right=rect.left+sc->cdt->scdt.thumbLength;
    }

    if(sc->pushed)
    	state=PUSHED;
    else
    	if(PtInRect(&rect,pt))
        	state=HIGHLIGHT;
        else
        	state=NORMAL;


 	HDC hdc=GetDC(hwnd);
    HDC hdcmem = CreateCompatibleDC(hdc);
   	HDC hdcBuffer = CreateCompatibleDC(hdc);
    HBITMAP hbmOldBuffer;
    HBITMAP hbmOld;

   	GetClientRect(hwnd,&rect);

   	HBITMAP hbmBuffer = CreateCompatibleBitmap(hdc,rect.right,rect.bottom);
    hbmOldBuffer=(HBITMAP)SelectObject(hdcBuffer,hbmBuffer);
   hbmOld=(HBITMAP)SelectObject(hdcmem,mainbitmap[sc->cdt->scdt.patternindex]);

   // draw background in buffer
   FillRectWithPattern(hdcBuffer,&rect,hdcmem,&sc->cdt->scdt.pattern);




    int thumb_pos_x, thumb_pos_y;
    int thumb_x, thumb_y;

    if (sc->style == SBS_VERT) {
    	thumb_pos_x=0;
    	thumb_pos_y=thumb_pos;
        thumb_x=rect.right;
        thumb_y=sc->cdt->scdt.thumbLength;
    }
    else {
    	thumb_pos_x=thumb_pos;
    	thumb_pos_y=0;
        thumb_x=sc->cdt->scdt.thumbLength;
        thumb_y=rect.bottom;
    }



     // draw thumb in buffer

      hbmOld=(HBITMAP)SelectObject(hdcmem,sc->bitmap[sc->cdt->scdt.bitmapindex]);
     BitBlt(hdcBuffer,
        	thumb_pos_x,
        	thumb_pos_y,
        	thumb_x,
        	thumb_y,
        	hdcmem,
        	sc->cdt->scdt.bitmap[state].x,
            sc->cdt->scdt.bitmap[state].y,
        	SRCCOPY);

     // draw buffer on scerrn
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

   ReleaseDC(hwnd,hdc);

   ValidateRect(hwnd,NULL);

}
