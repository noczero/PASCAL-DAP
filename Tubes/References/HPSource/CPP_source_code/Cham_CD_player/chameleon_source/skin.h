#ifndef SKIN
#define SKIN


#include "inikey.h"
#include "resource.h"


// titlebar
#define INACTIVE 0
#define ACTIVE 1


#define NORMAL 0
#define PUSHED 1
#define HIGHLIGHT 2

#define MAKECOLORREF(rgb) ( (DWORD) ((DWORD)(BYTE)(rgb)<<16 ) | \
				                ((WORD) (BYTE)(rgb >> 8)<<8 ) | \
                                ( (BYTE)(rgb >> 16)) )
                                
                                
#define TOPLEFT 0
#define	TOPMIDDLE 1
#define TOPRIGHT 2
#define TOPFILL 3
#define BOTTOMLEFT 4
#define BOTTOMFILL  5
#define BOTTOMRIGHT 6
#define PLAYLISTSCROLLBAR 7
#define	PLAYLISTCLOSE 8
#define PLAYLISTADD 9
#define PLAYLISTDELETE 10
#define PLAYLISTEDIT 11
#define PLAYLISTSONGUP 12
#define PLAYLISTSONGDOWN 13
#define LEFTBORDER 14
#define RIGHTBORDER 15
#define PLAYLISTBOX 16

#define MAIN 0
#define TITLEBAR 1
#define PREVIOUS 2
#define PLAY 3
#define PAUSE 4
#define STOP 5
#define NEXT 6
#define EJECT 7
#define SHOWPLAYLIST 8
#define OPTIONS 9
#define LOCKVOLUME 10
#define MUTEVOLUME 11
#define MINIMIZE 12
#define CLOSE 13

#define PLAYPOS 14
#define LVOLUME 15
#define RVOLUME 16
#define MASTERVOLUME 17

#define PLAYTIME 18
#define TRACKLENGTH 19
#define ARTIST 20
#define ALBUM 21
#define TRACK 22
#define STATUS 23



typedef char char_array[50];

extern char_array main_string[24];
extern char_array playlist_string[17];




 typedef struct
     {
     	int x; // x position in text bitmap
        int y; // y position in text bitmap
        int w; // width of char in trxt bitmap
     } BITMAPCHAR;

typedef struct
{
    HBITMAP bitmap;
    int bgColor;
    char textmap[255];
    int height;
} BITMAPFONT;

typedef struct
{
	LONG x;
    LONG y;
    LONG width;
    LONG height;
    LONG bitmapindex;
    POINT bitmap[3];
} BUTTONDRAWTABLE;

typedef struct
{
	LONG x;
    LONG y;
    LONG width;
    LONG height;
    LONG bitmapindex;
    LONG thumbLength;
    POINT bitmap[3];
    RECT pattern;
    LONG patternindex;
} SCROLLBARDRAWTABLE;

typedef struct
{
	RECT bitmap;
    LONG bitmapindex;
    LONG ItemHeight;
    LONG fontindex;
    LONG Current;
    LONG Selected;

} LISTBOXDRAWTABLE;

typedef struct
{
	LONG x;
    LONG y;
    LONG width;
    LONG height;
    LONG bitmapindex;
    POINT bitmap;
} MAINWINDOW;

typedef struct
{
	LONG x;
    LONG y;
    LONG width;
    LONG height;
    LONG fontindex;
    LONG bitmapindex;
    RECT pattern;
} STATICTEXT;

typedef union {
	LONG	source[17];
	BUTTONDRAWTABLE bdt;
    SCROLLBARDRAWTABLE scdt;
    LISTBOXDRAWTABLE lbdt;
    MAINWINDOW main;
    STATICTEXT stdt;
} CUSTOMDRAWTABLE;


extern CUSTOMDRAWTABLE m_cdt[24];
extern CUSTOMDRAWTABLE pl_cdt[17];
extern CUSTOMDRAWTABLE skin_m_cdt[24];
extern CUSTOMDRAWTABLE skin_pl_cdt[17];
extern CUSTOMDRAWTABLE basic_m_cdt[24];
extern CUSTOMDRAWTABLE basic_pl_cdt[17];
extern HBITMAP fontbitmap[20];  //font bitmap
extern BITMAPFONT font[20];
extern HBITMAP mainbitmap[20]; // main bitmap
extern HBITMAP skin_fontbitmap[20];
extern BITMAPFONT skin_font[20];
extern HBITMAP skin_mainbitmap[20];
extern HBITMAP pattern[6];


BOOL FillDrawTable(char *text,CUSTOMDRAWTABLE *cdt,char *error);
void FillRectWithPattern(HDC hdc, RECT *rect,HDC hdcmem, RECT *pattern);
HBITMAP DrawTextToBitmap(HDC hdc,char* text,BITMAPFONT *bmf, int *bwidth, int *bheight);
HBITMAP CreateBitmapMask(HBITMAP hbmColour, COLORREF crTransparent);
int GetTextWidth(char* text,BITMAPFONT *bmf);
BOOL InitializeFont(HWND hwnd,HBITMAP hbm, char * mapfilename,BITMAPFONT *bmfont);
BOOL LoadSkin(HWND hwnd,char * curdir, char *skinname);
BOOL CheckSkin(HWND hwnd,CUSTOMDRAWTABLE *cdt,int control,char *section,char *main_string,char *filename);



#endif
