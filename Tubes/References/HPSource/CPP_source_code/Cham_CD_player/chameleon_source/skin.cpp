#define STRICT
#include <windows.h>

#pragma hdrstop

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "skin.h"


int numOfBitmaps=0;
int numOfFonts=0;

int new_numOfFonts=0;
int new_numOfBitmaps=0;


char_array main_string[24]={"main","titlebar","prev","play","pause","stop","next",
							"eject","playlist","options","lockvolume","mutevolume",
                            "minimize","close","playpos","lvolume","rvolume",
                            "mastervolume","playtime","tracklength","artist",
                            "album","track","status"};

char_array playlist_string[17]={"topleft","topmiddle","topright",
	"topfill","bottomleft","bottomfill","bottomright",
    "scrollbar","close","add","delete","edit","songup","songdown",
    "leftborder","rightborder","listbox"};



CUSTOMDRAWTABLE m_cdt[24];
CUSTOMDRAWTABLE pl_cdt[17];

CUSTOMDRAWTABLE skin_m_cdt[24];
CUSTOMDRAWTABLE skin_pl_cdt[17];

CUSTOMDRAWTABLE basic_m_cdt[24]={
	{0,0,275,116, 0, 0,0}, // main
    {0,0,275,14, 1, 0,0, 0,15},   // titlebar
    // buttons
    {16,88,22,18, 2, 0,0,0,18,0,36}, // previous
    {39,88,22,18, 2, 22,0,22,18,22,36},  // play
    {62,88,22,18, 2, 44,0,44,18,44,36},		// pause
    {85,88,22,18, 2, 66,0,66,18,66,36},	// stop
    {108,88,22,18, 2, 88,0,88,18,88,36},	// next
    {131,88,22,18, 2, 110,0,110,18,110,36},	// eject
    {164,88,22,18, 2, 132,0,132,18,132,36},	// show playlist
    {187,88,22,18, 2, 154,0,154,18,154,36 },	// show options dialog

    {237,77,7,7, 2, 177,0,177,7,177,14},	// lock volume
    {253,77,7,7, 2, 177,22,177,29,177,36},	// mute volume

    {252,3,9,9, 3, 0,0,0,9,0,18},		// minimiza
    {262,3,9,9, 3, 9,0,9,9,9,18},		// close
    // scrollbars

    {12,72,195,6, 4, 20,  0,0, 0,6, 0,12, 12,72,199,6, 0}, // song position
    {231,50,4,60, 4, 9,  20,0, 24,0, 28,0, 231,50,4,60, 0},  // left volume
    {246,50,4,60, 4,  9,  20,0, 24,0, 28,0, 246,50,4,60, 0},	// right volume
    {262,50,4,60, 4, 9, 20,0, 24,0, 28,0, 262,50,4,60, 0},	// master volume
    //text

    {55,27,44,13, 1, 0, 55,27,44,13},		// playtime
    {23,29,30,11, 0, 0, 23,29,30,11},		// track length
    {22,42,115,11, 0, 0, 22,42,115,11},		// artist
    {22,55,115,11, 0, 0, 22,55,115,11},		// album
    {112,27,150,15, 0, 0, 112,27,150,15},		// track
    {161,44,55,11, 0, 0, 161,44,55,11}		// status
    };



CUSTOMDRAWTABLE basic_pl_cdt[17]={
	// top, bottom
	{0,0,25,20, 5, 0,0,0,21},	// topleft corner
    {0,0,100,20, 5, 26,0, 26,21},	// top middle
    {0,0,25,20, 5, 153,0, 153,21}, // topright corner
    {0,0,25,20, 5, 127,0, 127,21},	// top fill
    {0,0,154,38, 5, 0,42},	// bottomleft cornrt
    {0,0,25,38, 5, 38,81},	// bottom fill
    {0,0,20,38, 5, 155,42},	// bottomright corner
     //scrollbar
    {0,0,9,0, 5, 20, 82,81,91,81,100,81, 110,81,9,28, 5},	// playlist scrollbar
    //buttons
    {13,3,9,9, 5, 28,81,28,90,28,99}, // close
    {10,32,27,20, 5, 0,81,0,101,0,121},	// add
    {39,32,27,20, 5, 0,81,0,101,0,121},	// delete
    {68,32,27,20, 5, 0,81,0,101,0,121},	// edit
    {97,32,27,20, 5, 0,81,0,101,0,121},	// song up
    {126,32,27,20, 5, 0,81,0,101,0,121},	// song down
    // borders
    {0,0,9,29, 5, 64,81},	// left border
    {0,0,7,29, 5, 74,81},	// right border
    //list box
    {28,120,145,18, 5, 18,1, 0x000099,0xB10D01}	// list box
};

HBITMAP fontbitmap[20];
BITMAPFONT font[20];
HBITMAP mainbitmap[20];

HBITMAP skin_fontbitmap[20];
BITMAPFONT skin_font[20];
HBITMAP skin_mainbitmap[20];

HBITMAP pattern[6];


void FillRectWithPattern(HDC hdc, RECT *rect,HDC hdcmem,RECT *pattern)
{

// INPUT:	HDC hdc			- drawing HDC
//          RECT *rect		- HDC rect (x1,y1,x2,xy)
//          RECT *pattern	- pattern rect (x1,y1,width,height)
//
// OUTPUT: HDC hdc


    int pattern_width=pattern->right;
    int pattern_height=pattern->bottom;

	int x_length=rect->right - rect->left;
    int x_num=x_length / pattern_width;
    int x_rest=x_length % pattern_width;
    int y_length=rect->bottom - rect->top;
    int y_num=y_length / pattern_height;
    int y_rest=y_length % pattern_height;

    int i,j;
    int width,height;

    height=pattern_height;

    for (i=0;i<=y_num;i++) {
    	width=pattern_width;
    	if(i==y_num)
        	height=y_rest;
     	for (j=0;j<= x_num;j++) {
        
        	if (j== x_num)
               	width=x_rest;
        	BitBlt(hdc,
            		rect->left+pattern_width * j,
                    rect->top+pattern_height * i,
                    width,
                    height,
                    hdcmem,
                    pattern->left,
                    pattern->top,
                    SRCCOPY);
        }
    }
}


HBITMAP DrawTextToBitmap(HDC hdc,char* text,BITMAPFONT *bmf, int *bwidth, int *bheight)
{

     typedef struct
     {
     	int x;
        int y;
        int w;
     } BITMAPCHAR;

     if(strlen(text)==0) {
     	*bwidth=0;
        *bheight=0;
     	return CreateBitmap(0, 0, 1, 1, NULL);
     }



     BITMAPCHAR *drawing_array;
     int length=lstrlen(text);
     drawing_array = (BITMAPCHAR *)HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY,
     		sizeof(BITMAPCHAR) * length);
   
    int bitmap_width=0;
    char num[3];
    char chr;
    int row;
    int ind;

    *bwidth=0;

 	for (int i=0; i < length; i++) { // get char
        chr=text[i];
        row=0;
        ind=3;

        lstrcpyn(num,bmf->textmap,3);

        for(UINT j=ind;j<strlen(bmf->textmap);j++) {
        	if(bmf->textmap[j]=='\n') { // count new line
                num[0]=bmf->textmap[j+1];
                num[1]=bmf->textmap[j+2];
            	ind=j+4;
                j+=4;
                row++;
            }

            if(bmf->textmap[j]==chr) { // found char
            	drawing_array[i].x=j-ind;
                drawing_array[i].y=row;
                drawing_array[i].w=atoi(num);
                bitmap_width+=drawing_array[i].w;
                break;

            }
        }
    }


    HDC hdcmem = CreateCompatibleDC(hdc);
    HDC hdcBuffer = CreateCompatibleDC(hdc);

    HBITMAP hbmText=CreateCompatibleBitmap(hdc,bitmap_width,bmf->height);
    HBITMAP hbmOldBuffer=(HBITMAP)SelectObject(hdcBuffer,hbmText);
    HBITMAP hbmOld=(HBITMAP)SelectObject(hdcmem,bmf->bitmap);


    int pos=0;
    for (int i=0; i < length; i++) {

     	StretchBlt(hdcBuffer,
        		pos,
                0,
                drawing_array[i].w,
                bmf->height,
        		hdcmem,
     			drawing_array[i].x * drawing_array[i].w,
                drawing_array[i].y * bmf->height,
                drawing_array[i].w,
                bmf->height,
                SRCCOPY);

     	pos+=drawing_array[i].w;
    }


    *bheight=bmf->height;
    *bwidth=pos;

   SelectObject(hdcmem,hbmOld);
   DeleteDC(hdcmem);
   SelectObject(hdcBuffer,hbmOldBuffer);
   DeleteDC(hdcBuffer);

   HeapFree(GetProcessHeap(),0,drawing_array);

   return hbmText;

}


HBITMAP CreateBitmapMask(HBITMAP hbmColour, COLORREF crTransparent)
{
    HDC hdcMem, hdcMem2;
    HBITMAP hbmMask;
    BITMAP bm;
    // Create monochrome (1 bit) mask bitmap.
    GetObject(hbmColour, sizeof(BITMAP), &bm);
    hbmMask = CreateBitmap(bm.bmWidth, bm.bmHeight, 1, 1, NULL);
    // Get some HDCs that are compatible with the display driver
    hdcMem = CreateCompatibleDC(0);
    hdcMem2 = CreateCompatibleDC(0);
    HBITMAP hbmOld=(HBITMAP)SelectObject(hdcMem, hbmColour);
    HBITMAP hbmOld1=(HBITMAP)SelectObject(hdcMem2, hbmMask);
    // Set the background colour of the colour image to the colour
    // you want to be transparent.
    SetBkColor(hdcMem, crTransparent);
    // Copy the bits from the colour image to the B+W mask... everything
    // with the background colour ends up white while everythig else ends up
    // black...Just what we wanted.
    BitBlt(hdcMem2, 0, 0, bm.bmWidth, bm.bmHeight, hdcMem, 0, 0, SRCCOPY);
    // Take our new mask and use it to turn the transparent colour in our
    // original colour image to black so the transparency effect will
    // work right.
    BitBlt(hdcMem, 0, 0, bm.bmWidth, bm.bmHeight, hdcMem2, 0, 0, SRCINVERT);
    // Clean up.

    SelectObject(hdcMem, hbmOld);
    SelectObject(hdcMem2, hbmOld1);

    DeleteDC(hdcMem);
    DeleteDC(hdcMem2);
    return hbmMask;


}



BOOL CheckSkin(HWND hwnd,CUSTOMDRAWTABLE *cdt,int control,char *section,char *main_string,char *filename)
{

    char tmp3[200];
	switch(control) {
    	case 0: // scrollbar
			if((cdt->scdt.pattern.right == 0) || (cdt->scdt.pattern.bottom ==0)) {
    		   	sprintf(tmp3,"Pattern rect can't be 0 width or height !!!\n%s\n%s=\n\n form %s",
    			 	section,main_string,filename);
    			MessageBox(hwnd,tmp3,"Invalid skin file",
            	 	MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
    			return FALSE;
            }

            if((cdt->scdt.bitmapindex > new_numOfBitmaps-1) || (cdt->scdt.patternindex > new_numOfBitmaps-1))   {
    		   	sprintf(tmp3,"Bitmap or pattern index must be less than %i !!!\n%s\n%s=\n\n form %s",
    			 	new_numOfBitmaps,section,main_string,filename);
    			MessageBox(hwnd,tmp3,"Invalid skin file",
            	   	MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
    			return FALSE;
            }

        break;

        case 1: // static control
        	if((cdt->stdt.pattern.right == 0) || (cdt->stdt.pattern.bottom ==0)) {
    		   	sprintf(tmp3,"Pattern rect can't be 0 width or height !!!\n%s\n%s=\n\n form %s",
    			 	section,main_string,filename);
    			MessageBox(hwnd,tmp3,"Invalid skin file",
            	 	MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
    			return FALSE;
            }

            if(cdt->stdt.fontindex > new_numOfFonts-1 ) {
    		   	sprintf(tmp3,"Font index must be less than %i !!!\n%s\n%s=\n\n form %s",
    			 	new_numOfFonts,section,main_string,filename);
    			MessageBox(hwnd,tmp3,"Invalid skin file",
            	   	MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
    			return FALSE;
            }

        break;

        case 2: // top and bottom patern on playlist dialog
        		if((cdt->bdt.width == 0) || (cdt->bdt.height ==0)) {
    		   	sprintf(tmp3,"Pattern rect can't be 0 width or height !!!\n%s\n%s=\n\n form %s",
    			 	section,main_string,filename);
    			MessageBox(hwnd,tmp3,"Invalid skin file",
            	 	MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
    			return FALSE;
            }


        break;

        case 3: // list box
        		if((cdt->lbdt.bitmap.right == 0) || (cdt->lbdt.bitmap.bottom ==0)) {
    		   	sprintf(tmp3,"Pattern rect can't be 0 width or height !!!\n%s\n%s=\n\n form %s",
    			 	section,main_string,filename);
    			MessageBox(hwnd,tmp3,"Invalid skin file",
            	 	MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
    			return FALSE;
            }

            if(cdt->lbdt.fontindex > new_numOfFonts-1 ) {
    		   	sprintf(tmp3,"Font index must be less than %i !!!\n%s\n%s=\n\n form %s",
    			 	new_numOfFonts,section,main_string,filename);
    			MessageBox(hwnd,tmp3,"Invalid skin file",
            	   	MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
    			return FALSE;
            }


        break;

     }

     return TRUE;


}



BOOL FillDrawTable(char *text,CUSTOMDRAWTABLE *cdt,char *error)
{
//	INPUT:	char *text		- coordinates string
//          DRAWTABLE *dt	- DRAWTABLE structure
//
//
//	OUTPUT  DRAWTABLE *dt	- filled DRAWTABLE structure

	char *str=text;
    char *end;
    char point[200];
    char *pt=point;
    char *st;
   
    for (int i=0;i<17;i++)
    	cdt->source[i]=0;


    for (int i = 0; i < 17 ; i++) {
    	end=strstr(str,",");
        if(end==NULL) { // last number in string
    		end=strstr(str,"/");
    		if(end==NULL) // there is no comment
    			end=str+strlen(str);

            strncpy(point,str,end-str);
            point[end-str]=0;
            st=strchr(point,'#');
            if (st != NULL) {   // color code
            	pt=st+1;
                if(sscanf(pt,"%x",&cdt->source[i])==0) {
                	sprintf(error,"Invalide color value at index: %i  value: %s",i+1,point);
                    return FALSE;
                }
            }
            else {
            	if(sscanf(pt,"%i",&cdt->source[i])==0) {
                	sprintf(error,"Invalide value at index: %i  value: %s",i+1,point);
                    return FALSE;
                }

            }
            break;

        }
        strncpy(point,str,end-str);
    	point[end-str]=0;
        st=strchr(point,'#');
            if (st != NULL) {
            	pt=st+1;
                if(sscanf(pt,"%x",&cdt->source[i])==0) {
                	sprintf(error,"Invalide color value at index: %i  value: %s",i+1,point);
                    return FALSE;
                }
            }
            else {
            	if(sscanf(pt,"%i",&cdt->source[i]) ==0) {
                	sprintf(error,"Invalide value at index: %i  value: %s",i+1,point);
                    return FALSE;
                }


            }
        str=end+1;
    }
    return TRUE;

}

BOOL LoadSkin(HWND hwnd,char *curdir, char *skinname)
{
// load skin bitmaps
// on success return TRUE
// on fail return FALSE
//
//
//	INPUT:	char *curdir		current directory of application
//          char *skinname		skin name ( name of subdirectory )
//          BOOL fRedraw		flag ( TRUE redraw main window )
//
//	OUTPUT:	TRUE				on success
//			FALSE				on fail
//
//	GLOBAL VARIABLE:	HBITMAP *mainbitmap
//                      HBITMAP *fontbitmap;
//                      int numOfBitmaps;
//						int numOfFonts;
//                      BITMAPFONT *font;
//
//

        for (int i=0;i<6;i++)
        	DeleteObject(pattern[i]);

     	pattern[0]=LoadBitmap(GetModuleHandle(NULL),"PATTERN1");
    	pattern[1]=LoadBitmap(GetModuleHandle(NULL),"PATTERN2");
        pattern[2]=LoadBitmap(GetModuleHandle(NULL),"PATTERN3");
        pattern[3]=LoadBitmap(GetModuleHandle(NULL),"PATTERN4");
        pattern[4]=LoadBitmap(GetModuleHandle(NULL),"PATTERN5");
        pattern[5]=LoadBitmap(GetModuleHandle(NULL),"PATTERN6");
        

	if(strcmp(skinname,"BASIC")==0) {
    // load basic skin bitmaps from exe resource


    	for (int i=0;i<numOfBitmaps;i++)
     		DeleteObject(mainbitmap[i]);

 		for (int i=0;i<numOfFonts;i++)
     		DeleteObject(fontbitmap[i]);


    	// main bitmaps
    	mainbitmap[0]=LoadBitmap(GetModuleHandle(NULL),"MAIN");
    	mainbitmap[1]=LoadBitmap(GetModuleHandle(NULL),"TITLEBAR");
        mainbitmap[2]=LoadBitmap(GetModuleHandle(NULL),"BUTTONS");
        mainbitmap[3]=LoadBitmap(GetModuleHandle(NULL),"SYSBUTTONS");
        mainbitmap[4]=LoadBitmap(GetModuleHandle(NULL),"SCROLLBARTHUMB");
        mainbitmap[5]=LoadBitmap(GetModuleHandle(NULL),"PLEDIT");

        // font bitmaps
        fontbitmap[0]=LoadBitmap(GetModuleHandle(NULL),"BITMAPFONT1");
        fontbitmap[1]=LoadBitmap(GetModuleHandle(NULL),"BITMAPFONT2");

        // font map
        char textmap[256];
    	LoadString(GetModuleHandle(NULL),TEXTMAP1,textmap,256);

        font[0].bitmap=fontbitmap[0];
        font[0].height=11;
        font[0].bgColor=0x000000;
        strcpy(font[0].textmap,textmap);

        LoadString(GetModuleHandle(NULL),TEXTMAP2,textmap,256);
        font[1].bitmap=fontbitmap[1];
        font[1].height=15;
        font[1].bgColor=0x000000;
        strcpy(font[1].textmap,textmap);

        for (int i=0;i<24;i++)
       	 	m_cdt[i]=basic_m_cdt[i];

         for (int i=0;i<17;i++)
         	pl_cdt[i]=basic_pl_cdt[i];

        numOfBitmaps=6;
		numOfFonts=2;


        return TRUE;

    }


	char tmp[MAX_PATH];
    char tmp1[500];
    char tmp2[100];
    char tmp3[100];
   
    char error[200];



     // load advance skin
    sprintf(tmp,"%s\\skin\\%s\\Info.ini",curdir,skinname);
    HANDLE hFile=OpenIniFile(tmp);


     // bitmaps
     if(GetIniKey(hFile,"[bitmap]","num",tmp1))
     	new_numOfBitmaps=atoi(tmp1);
     else {
        	sprintf(tmp3,"Can't load:\n[bitmap]\nnum=\n\n form %s",tmp);
        	MessageBox(hwnd,tmp3,"Invalid skin file",
            MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
            CloseIniFile(hFile);
            return FALSE;
     }


     for (int i=0;i<new_numOfBitmaps;i++) {
     	sprintf(tmp2,"%i",i);
        if(GetIniKey(hFile,"[bitmap]",tmp2,tmp1))
        {
        	sprintf(tmp,"%s\\skin\\%s\\%s",curdir,skinname,tmp1);
        	skin_mainbitmap[i]=(HBITMAP)LoadImage(GetModuleHandle(NULL),tmp,IMAGE_BITMAP,
             					0,0,LR_LOADFROMFILE	);
        }
        else {
        	sprintf(tmp3,"Can't load:\n[bitmap]\n%s=",tmp2);
        	MessageBox(hwnd,tmp3,"Invalid skin file",
            MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
            CloseIniFile(hFile);
            return FALSE;
     	}

    }

     // fonts
     if(GetIniKey(hFile,"[font]","num",tmp1))
     	new_numOfFonts=atoi(tmp1);
     else {
        	sprintf(tmp3,"Can't load:\n[font]\nnum=");
        	MessageBox(hwnd,tmp3,"Invalid skin file",
            MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
            CloseIniFile(hFile);
            return FALSE;
     }

    numOfFonts=new_numOfFonts;

     for (int i=0;i<new_numOfFonts;i++) {
     	sprintf(tmp2,"%i",i);
        if(GetIniKey(hFile,"[font]",tmp2,tmp1)) {
        	sprintf(tmp,"%s\\skin\\%s\\%s.bmp",curdir,skinname,tmp1);
        	skin_fontbitmap[i]=(HBITMAP)LoadImage(GetModuleHandle(NULL),tmp,IMAGE_BITMAP,
             					0,0,LR_LOADFROMFILE	);
        	sprintf(tmp,"%s\\skin\\%s\\%s.bin",curdir,skinname,tmp1);
        	if(!InitializeFont(hwnd,skin_fontbitmap[i],tmp,&skin_font[i])) {
            	CloseIniFile(hFile);
            	return FALSE;
            }
        }
         else {
        	sprintf(tmp3,"Can't load:\n[font]\n%s=",tmp2);
        	MessageBox(hwnd,tmp3,"Invalid skin file",
            MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
            CloseIniFile(hFile);
            return FALSE;
     	}

    }


     // main window draw table
     for (int i=0;i<24;i++) {

     	if(GetIniKey(hFile,"[mainwindow]",main_string[i],tmp1)) {
        	if(!FillDrawTable(tmp1,&skin_m_cdt[i],error)) {
            	sprintf(tmp3,"Error in:\n[mainwindow]\n%s=\n\n form %s\n\n",
                    main_string[i],tmp);
                strcat(tmp3,error);
        		MessageBox(hwnd,tmp3,"Invalid skin file",
            	MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
            	CloseIniFile(hFile);
            	return FALSE;

            }
            
        }
        else {
        	sprintf(tmp3,"Can't load:\n[mainwindow]\n%s=\n\n form %s",
                    main_string[i],tmp);
        	MessageBox(hwnd,tmp3,"Invalid skin file",
            MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
            CloseIniFile(hFile);
            return FALSE;
        }
     }


     for (int i=PLAYPOS;i<MASTERVOLUME+1;i++) {
     	if(!CheckSkin(hwnd,&skin_m_cdt[i],0,"[mainwindow]",main_string[i],tmp)) {
     		CloseIniFile(hFile);
        	return FALSE;
     	}
     }


       for (int i=PLAYTIME;i<STATUS+1;i++) {
       		if(!CheckSkin(hwnd,&skin_m_cdt[i],1,"[mainwindow]",main_string[i],tmp)) {
     			CloseIniFile(hFile);
        		return FALSE;
     		}
       }

     // playlist window  draw table
     for (int i=0;i<17;i++) {

     	if(GetIniKey(hFile,"[playlist]",playlist_string[i],tmp1)) {
        	if(!FillDrawTable(tmp1,&skin_pl_cdt[i],error)) {
            	sprintf(tmp3,"Error at:\n[playlist]\n%s=\n\n form %s\n\n",
                    playlist_string[i],tmp);
                strcat(tmp3,error);
        		MessageBox(hwnd,tmp3,"Invalid skin file",
            	MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
            	CloseIniFile(hFile);
            	return FALSE;


            }
        }
        else {
        	sprintf(tmp3,"Can't load:\n[playlist]\n%s=\n\n form %s",
                    main_string[i],tmp);
        	MessageBox(hwnd,tmp3,"Invalid skin file",
            MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
            CloseIniFile(hFile);
            return FALSE;
        }
     }


	if (skin_pl_cdt[PLAYLISTBOX].lbdt.ItemHeight==0) {
    	sprintf(tmp3,"ListBox item height can't be 0 !!!!\n[playlist]\n%s=\n\n form %s",
                    playlist_string[PLAYLISTBOX],tmp);
        	MessageBox(hwnd,tmp3,"Invalid skin file",
            MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
        	CloseIniFile(hFile);
            return FALSE;

    }

    if(!CheckSkin(hwnd,&skin_pl_cdt[TOPFILL],2,"[playlist]",playlist_string[TOPFILL],tmp)) {
     	CloseIniFile(hFile);
        return FALSE;
     }

      if(!CheckSkin(hwnd,&skin_pl_cdt[BOTTOMFILL],2,"[playlist]",playlist_string[BOTTOMFILL],tmp)) {
     	CloseIniFile(hFile);
        return FALSE;
     }

      if(!CheckSkin(hwnd,&skin_pl_cdt[PLAYLISTBOX],3,"[playlist]",playlist_string[PLAYLISTBOX],tmp)) {
     	CloseIniFile(hFile);
        return FALSE;
     }

      if(!CheckSkin(hwnd,&skin_pl_cdt[PLAYLISTSCROLLBAR],0,"[playlist]",playlist_string[PLAYLISTSCROLLBAR],tmp)) {
     	CloseIniFile(hFile);
        return FALSE;
     }


    for (int i=0;i<numOfBitmaps;i++)
    	DeleteObject(mainbitmap[i]);

    for (int i=0;i<new_numOfBitmaps;i++)
        mainbitmap[i]=skin_mainbitmap[i];

        numOfBitmaps=new_numOfBitmaps;


    for (int i=0;i<numOfFonts;i++)
    	DeleteObject(fontbitmap[i]);


     for (int i=0;i<new_numOfFonts;i++) {
        fontbitmap[i]=skin_fontbitmap[i];
        font[i]= skin_font[i];
    }

     for (int i=0;i<24;i++) {
     	m_cdt[i]=skin_m_cdt[i];
     }

     for (int i=0;i<17;i++) {
     	pl_cdt[i]=skin_pl_cdt[i];
     }



    CloseIniFile(hFile);
    return TRUE;
}

BOOL InitializeFont(HWND hwnd,HBITMAP hbm, char * mapfilename,BITMAPFONT *bmfont)
{
    char *ini_string;
    char tmp[10];
    char *tmp1;
    char tmp3[500];

    	HANDLE hFile=OpenIniFile(mapfilename);

    	if (!GetIniKey(hFile,"[font]","height",tmp)) {
        	sprintf(tmp3,"Cant'load:\n[font]\nheight=\n\nfrom: %s",mapfilename);
        	MessageBox(hwnd,tmp3,"Invalid skin file",
            MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
    		CloseIniFile(hFile);
    		return FALSE;
    	}

    	bmfont->height=atoi(tmp);

        if (!GetIniKey(hFile,"[font]","bgColor",tmp)) {
                sprintf(tmp3,"Cant'load:\n[font]\nbgColor=\n\nfrom: %s",mapfilename);
        		MessageBox(hwnd,tmp3,"Invalid skin file",
            	MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
    			CloseIniFile(hFile);
    			return FALSE;
    	}

        tmp1=strchr(tmp,'#');
        if(tmp1==NULL) {
         	sprintf(tmp3,"Invalid color format:\n[font]\nbgColor=%s\n\nfrom: %s",
          	tmp,mapfilename);
          	MessageBox(hwnd,tmp3,"Invalid skin file",
            	MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
            	CloseIniFile(hFile);
          	return FALSE;
    	}

        tmp1=tmp1+1;
        if(sscanf(tmp1,"%x",&bmfont->bgColor)==0) {
        	sprintf(tmp3,"Invalid color value:\n[font]\nbgColor=%s\n\nfrom: %s",
            tmp,mapfilename);
            MessageBox(hwnd,tmp3,"Invalid skin file",
            MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
            CloseIniFile(hFile);
            return FALSE;
        }


    	DWORD dwFileSize;
    	dwFileSize=GetFileSize(hFile, NULL);
    	ini_string =(LPSTR) GlobalAlloc(GPTR, dwFileSize + 1);
    	DWORD dwRead;
    	SetFilePointer(hFile,0,NULL,FILE_BEGIN);
    	ReadFile(hFile, ini_string, dwFileSize, &dwRead, NULL);
    	ini_string[dwFileSize] = 0; // Add null terminator
        CloseIniFile(hFile);

        char *end=strstr(ini_string,"\r\n\r\n");

    	if(end==NULL || end > strstr(ini_string,"[font]")) {
    		sprintf(tmp3,"Textmap must end with 2 newlines before \n[font]\n\n%s\n in:\n %s",
            ini_string,mapfilename);
            MessageBox(hwnd,tmp3,"Invalid skin file",
            MB_APPLMODAL|MB_SETFOREGROUND|MB_ICONSTOP);
            GlobalFree(ini_string);
    		return FALSE;

    	}

         bmfont->bitmap=hbm;
    	strncpy(bmfont->textmap,ini_string,end-ini_string);
    	bmfont->textmap[end-ini_string]=0;	// nul termination
        GlobalFree(ini_string);
        return TRUE;
}

/*
BOOL DrawTextToTable(char* text,BITMAPCHAR *texttable,BITMAPFONT *bmf, int *twidth, int *theight)
{

     int length=strlen(text);

     if(length==0) {
     	*twidth=0;
        *theight=0;
     	return FALSE;
     }

     GlobalReAlloc(texttable,sizeof(BITMAPCHAR) * length,GMEM_ZEROINIT);

    char num[3];
    char chr;
    int row;
    int ind=3;


    *twidth=0;

 	for (int i=0; i < length; i++) { // get char
        chr=text[i];
        row=0;
        ind=3;

        lstrcpyn(num,bmf->textmap,3);

        for(UINT j=ind;j<strlen(bmf->textmap);j++) {
        	if(bmf->textmap[j]=='\n') { // count new line
                num[0]=bmf->textmap[j+1];
                num[1]=bmf->textmap[j+2];
            	ind=j+4;
                j+=4;
                row++;
            }

            if(bmf->textmap[j]==chr) { // found char
            	texttable[i].x=j-ind;
                texttable[i].y=row;
                texttable[i].w=atoi(num);
                *twidth+=texttable[i].w;
                break;

            }
        }
    }
    *theight=bmf->height;
    return TRUE;
}

*/



int GetTextWidth(char* text,BITMAPFONT *bmf)
{

     int length=strlen(text);

     if(length==0) {
     	return 0;
     }

    char num[3];
    char chr;
    
    int ind;
    int width=0;

 	for (int i=0; i < length; i++) { // get char
        chr=text[i];
        
        ind=3;

        lstrcpyn(num,bmf->textmap,3);

        for(UINT j=ind;j<strlen(bmf->textmap);j++) {
        	if(bmf->textmap[j]=='\n') { // count new line
                num[0]=bmf->textmap[j+1];
                num[1]=bmf->textmap[j+2];
                j+=4;
                
            }

            if(bmf->textmap[j]==chr) { // found char
                width+=atoi(num);
                break;

            }
        }
    }

    return width;
}



