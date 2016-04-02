#define STRICT
#include <windows.h>

#pragma hdrstop

 
#include "listbox.h"

TCHAR PropListBoxStr[] ="ListBoxProperty";


LRESULT CALLBACK ListBoxSubclassProc(HWND hwnd,UINT uMsg,WPARAM wParam,LPARAM lParam)
{

	LISTBOX *lb=(LISTBOX *)GetListBox(hwnd);

   	switch(uMsg)
   	{

       	case WM_PAINT:
        {
        PAINTSTRUCT ps;
        HDC hdc=BeginPaint(hwnd,&ps);

              DrawListBox(hwnd,lb,hdc);
        EndPaint(hwnd,&ps);
        }
        return 0;

       
        // redraw listbox
         case WM_LBUTTONDOWN:
              ListBoxNotifySelChange(hwnd);
        break;
        
        case LB_ADDSTRING:
            ListBoxContentsChangeNotify(hwnd);   
        break;
        //********
        
        // notify parent on contents change
        case LB_DELETESTRING:
            ListBoxContentsChangeNotify(hwnd);
        break;
        
        case LB_INSERTSTRING:
            ListBoxContentsChangeNotify(hwnd);
        break;
        
        case LB_RESETCONTENT :
            ListBoxContentsChangeNotify(hwnd);
        break;
        //*************************************
        case WM_KEYDOWN:


        	 switch (wParam) {

             	case VK_DELETE:
                {
                     HWND parent=GetParent(hwnd);
             			SendMessage(parent,WM_KEYDOWN,VK_DELETE,
                        0);

                }
                break;

             	 // redraw listbox
                case VK_PRIOR:
                      ListBoxNotifySelChange(hwnd);
                break;

                case VK_NEXT:
                     ListBoxNotifySelChange(hwnd);
                break;

             	case VK_UP:
                	ListBoxNotifySelChange(hwnd);
                break;

                case VK_DOWN:
                    ListBoxNotifySelChange(hwnd);
                break;

                case VK_HOME:
                     ListBoxNotifySelChange(hwnd);
                break;

                case VK_END:
                     ListBoxNotifySelChange(hwnd);
                break;
                //*******************************

                case VK_RETURN:
                {
                      HWND parent=GetParent(hwnd);
             			SendMessage(parent,WM_COMMAND,
             			MAKEWPARAM(GetWindowLong(parent,GWL_ID),LBN_DBLCLK),
                        (LPARAM)hwnd);
                }
                break;
               
             //default: // send all WM_KEYDOWN messages to parent
               // HWND parent=GetParent(hwnd);
     			//SendMessage(parent,uMsg,wParam,lParam); 
                

        	}

        break;


    	case WM_DESTROY:
    	{

    		LISTBOX *lb=GetListBox(hwnd);
    		WNDPROC oldproc = lb->oldproc;
			UninitializeLB(hwnd);

			//we must call the original window procedure
			return CallWindowProc(oldproc, hwnd, uMsg, wParam, lParam);
    	}

	}

  	return CallWindowProc(lb->oldproc, hwnd, uMsg, wParam, lParam);
}


BOOL InitializeLB(HWND hwnd,HBITMAP *background,CUSTOMDRAWTABLE *cdt,BITMAPFONT *bmf)
{
	LISTBOX *lb;

    //allocate a scrollbar structure which we
	//will use to keep track of the scrollbar data
    lb = (LISTBOX *)HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY,
    sizeof(LISTBOX));

    lb->bmf=bmf;
    lb->cdt=cdt;
   lb->background=background;

   lb->leftindent=10;

    // avoid flickeringa
    SendMessage(hwnd,WM_SETREDRAW,(WPARAM)FALSE,0);

    // subclass scrollbar control window
    lb->oldproc = (WNDPROC)SetWindowLong(hwnd, GWL_WNDPROC, (LONG)ListBoxSubclassProc);

    SetProp(hwnd,PropListBoxStr,(HANDLE)lb);
    return TRUE;
}



BOOL WINAPI UninitializeLB(HWND hwnd)
{

	LISTBOX *lb = GetListBox(hwnd);
	if(!lb) return 0;

    ListBoxDeleteAll(hwnd,FALSE);

	//restore the window procedure with the original one
	SetWindowLong(hwnd, GWL_WNDPROC, (LONG)lb->oldproc);

	RemoveProp(hwnd, PropListBoxStr);
	//finally, release the memory needed for the cool scrollbars
	HeapFree(GetProcessHeap(), 0, lb);
    return TRUE;

}

LISTBOX *GetListBox(HWND hwnd)
{
	return (LISTBOX *)GetProp(hwnd, PropListBoxStr);
}




void DrawListBox(HWND hwnd,LISTBOX *lb,HDC hdc)
{

   	HDC hdcmem = CreateCompatibleDC(hdc);
    HDC hdcBuffer = CreateCompatibleDC(hdc);
    HBITMAP hbmOldBuffer;
    HBITMAP hbmOld;

    RECT rect;
    RECT rect1;
   	GetClientRect(hwnd,&rect);

    HBITMAP hbmBuffer = CreateCompatibleBitmap(hdc,rect.right,rect.bottom);
    hbmOldBuffer=(HBITMAP)SelectObject(hdcBuffer,hbmBuffer);

   HBRUSH active=CreateSolidBrush(MAKECOLORREF(lb->cdt->lbdt.Current));
   HBRUSH select=CreateSolidBrush(MAKECOLORREF(lb->cdt->lbdt.Selected));

   hbmOld=(HBITMAP)SelectObject(hdcmem,lb->background[lb->cdt->lbdt.bitmapindex]);
  	// draw background
   FillRectWithPattern(hdcBuffer,&rect,hdcmem,&lb->cdt->lbdt.bitmap);

   int bwidth,bheight;

   int nRows=SendMessage(hwnd,LB_GETCOUNT,0,0);
   char text[50];
   int center= MulDiv(lb->cdt->lbdt.ItemHeight - lb->bmf[lb->cdt->lbdt.fontindex].height,1,2);
   //int center=0;


   RECT rc_active,rc_selected;

     // find selected row
     int nCurSel=SendMessage(hwnd,LB_GETCURSEL,0,0);
     if (nCurSel != LB_ERR) {
        SendMessage(hwnd,LB_GETITEMRECT,nCurSel,(LPARAM) &rc_selected);
        //draw background of selected row
        FillRect(hdcBuffer ,&rc_selected,select);
     }

     SendMessage(hwnd,LB_GETITEMRECT,lb->active,(LPARAM) &rc_active);
   	// draw background of active row
   	FillRect(hdcBuffer ,&rc_active,active);


      int start=SendMessage(hwnd,LB_GETTOPINDEX,0,0);


      int num=rect.bottom/lb->cdt->lbdt.ItemHeight;
      int end=min(nRows,start+num+1);

     for (int i=start;i < end;i++) {
     	SendMessage(hwnd,LB_GETTEXT,(WPARAM)i,(LPARAM)&text);
        // draw text to bitmap
        HBITMAP hbmText=DrawTextToBitmap(hdc,text,&lb->bmf[lb->cdt->lbdt.fontindex],&bwidth,&bheight);
        // create bitmap mask
        HBITMAP mask=CreateBitmapMask(hbmText,MAKECOLORREF(lb->bmf[lb->cdt->lbdt.fontindex].bgColor));
        //BITMAP mask=CreateBitmapMask(hbmText,RGB(0,109,192));
         SelectObject(hdcmem,mask);

        SendMessage(hwnd,LB_GETITEMRECT,i,(LPARAM) &rect1);
        // draw text  mask bitmap in buffer
        BitBlt(hdcBuffer,
        	lb->leftindent,
            rect1.top+center,
            bwidth,
        	bheight,
            hdcmem,
            0,
            0,
            SRCAND);

        SelectObject(hdcmem,hbmText);
         // draw text bitmap in buffer
        BitBlt(hdcBuffer,
        	lb->leftindent,
            rect1.top+center,
            bwidth,
        	bheight,
            hdcmem,
            0,
            0,
            SRCPAINT);


        SelectObject(hdcmem,hbmOld);
        DeleteObject(hbmText);
        DeleteObject(mask);
     }

     DrawFocusRect(hdcBuffer,&rc_selected);

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

   SelectObject(hdcBuffer,hbmOldBuffer);
   DeleteDC(hdcBuffer);

   DeleteObject(hbmBuffer);

   DeleteObject(select);
   DeleteObject(active);

}




BOOL ListBoxNotifySelChange(HWND hwnd)
{
 InvalidateRect(hwnd,NULL,FALSE);
 return TRUE;

}

void ListBoxAddString(HWND hwnd, char * text,WORD data,BOOL fRedraw)
{

    LISTBOX *lb=(LISTBOX *) GetListBox(hwnd);
    if(lb)
   		SendMessage(hwnd,LB_SETITEMHEIGHT,0,MAKELPARAM(lb->cdt->lbdt.ItemHeight,0));

    int nItem = SendMessage(hwnd, LB_ADDSTRING, 0,(LPARAM) text);
    SendMessage(hwnd, LB_SETITEMDATA, nItem,MAKELPARAM(data,0));
    if(fRedraw)
    	InvalidateRect(hwnd,NULL,FALSE);

}


void ListBoxDeleteAll(HWND hwnd,BOOL fRedraw)
{
	 SendMessage(hwnd, LB_RESETCONTENT, 0,0);

     if(fRedraw)
     	InvalidateRect(hwnd,NULL,FALSE);

}

void ListBoxDeleteString(HWND hwnd,int index, BOOL fRedraw)
{

    SendMessage(hwnd,LB_DELETESTRING,(WPARAM)index,0);
    if(fRedraw)
    	InvalidateRect(hwnd,NULL,FALSE);

}

void ListBoxInsertString(HWND hwnd, char * text,int index,WORD data, BOOL fRedraw)
{

    LISTBOX *lb=(LISTBOX *) GetListBox(hwnd);
    if(lb)
    	SendMessage(hwnd,LB_SETITEMHEIGHT,0,MAKELPARAM(lb->cdt->lbdt.ItemHeight,0));

    int nItem = SendMessage(hwnd, LB_INSERTSTRING,(WPARAM)index,(LPARAM) text);
    SendMessage(hwnd, LB_SETITEMDATA, nItem,MAKELPARAM(data,0));


    if(fRedraw)
    	InvalidateRect(hwnd,NULL,FALSE);

}

void ListBoxSetActive(HWND hwnd, int index,BOOL fRedraw)
{
 	LISTBOX *lb=(LISTBOX *) GetListBox(hwnd);
    if(lb)
    lb->active=index;

    if(fRedraw)
    	InvalidateRect(hwnd,NULL,FALSE);
}

void ListBoxGetText(HWND hwnd,int index, char * text)
{
 	SendMessage(hwnd,LB_GETTEXT,(WPARAM) index, (LPARAM) text);

}


int ListBoxGetCount(HWND hwnd)
{

 return SendMessage(hwnd,LB_GETCOUNT,0,0);

}

int ListBoxGetCurSel(HWND hwnd)
{
 	return SendMessage(hwnd,LB_GETCURSEL,0,0);

}

int ListBoxGetIndex(HWND hwnd,WORD data)
{
	int count=ListBoxGetCount(hwnd);
    for (int i=0;i<count;i++) {
    	if (data==ListBoxGetData(hwnd,i))
        	return i;
    }
    return -1;
}

void ListBoxSelectItem(HWND hwnd,int index,BOOL fRedraw)
{
	SendMessage(hwnd,LB_SETCURSEL,(WPARAM)index,0);
    if(fRedraw)
    InvalidateRect(hwnd,NULL,FALSE);
}

WORD ListBoxGetData(HWND hwnd,int index)
{
 	return LOWORD(SendMessage(hwnd,LB_GETITEMDATA,(WPARAM)index,0));
}

void ListBoxContentsChangeNotify(HWND hwnd)
{
    SendMessage(GetParent(hwnd),CM_LISTBOX_NOTIFY,0,0);

}

void ListBoxUpdateScroll(HWND hwnd_playllst,HWND hwnd_scroll)
{

	RECT rect;
    GetClientRect(hwnd_playllst,&rect);
    int max;
    int count=SendMessage(hwnd_playllst,LB_GETCOUNT,0,0);
    int itemheight=SendMessage(hwnd_playllst,LB_GETITEMHEIGHT,0,0);
    int p=count*itemheight-rect.bottom;

    if(p>0) {
    	//max=MulDiv(p,1,itemheight);
        max=p/itemheight+2;
	}
    	else max=0;

    SCROLLINFO sinfo;
    sinfo.cbSize=sizeof(sinfo);
    sinfo.fMask=SIF_RANGE;
    sinfo.nMin=0;
    sinfo.nMax=max;

    SetScrollInfo(hwnd_scroll,SB_CTL,&sinfo,FALSE);
    InvalidateRect(hwnd_scroll,NULL,FALSE);

}

