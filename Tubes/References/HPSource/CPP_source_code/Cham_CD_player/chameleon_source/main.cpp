#define STRICT
#include <windows.h>

#pragma hdrstop

#include <commctrl.h> // must link with  comctl32 library

#include <stdio.h>
#include <stdlib.h>
#include <tchar.h>
#include <Dbt.h>



#include "main.h"

#include "resource.h"


#include "cube.h"
#include "mixer.h"
#include "inikey.h"
#include "button.h"
#include "scroll.h"
#include "skin.h"
#include "static.h"
#include "listbox.h"

//---------------------------------------------------------------------------

//  Handles

HWND hMain; // main window
HWND hPrev,hPlay,hPause,hStop,hNext,hEject,hOptions,hShowPlaylist,hLockVolume,hMuteVolume; // buttons
HWND hMinimize, hClose; // system buttons
HWND hLeftAudio,hRightAudio,hMasterAudio,hPosition,hScrollPlaylist; // scrollbars
HWND hPlayTime, hTrackLength,hArtist,hAlbum,hTrack,hStatus; // static controls ( text )
HWND hPlayListDlg=NULL; // playlist dialog window
HWND hPlaylist; // List box
HWND hClosePlaylist,hEditPlaylist,hSongUp,hSongDown,hAdd,hDelete; // playlist buttons
HWND hAbout; // about dialog

HWND hEditSong,hAddSong;

HINSTANCE g_hinst;

HWND PosList[50];

int hOptionsDialog;


MCIDEVICEID  wCDPlayerID=0;

/////////////////////// SETTINGS VARIABLE/////////////////////////

BOOL SnapMove=FALSE;
BOOL snapWindow=TRUE;
BOOL showTooltip=TRUE;
BOOL keyShortcuts=TRUE;
int snapPixel=10;
int main_xpos,main_ypos;
char skinname[MAX_PATH];
char appIniFile[]="chameleo.ini";
char playlistIniFile[MAX_PATH];
int tracks_array[100];
int numOfTracks;
extern int numOfBitmaps;
extern int numOfFonts;
BOOL introPlay=FALSE;
int introPlayLen=10;
BOOL elapsedTime=TRUE;
BOOL randomIntro=FALSE;
BOOL repeat=FALSE;; // repeat playlist
BOOL playOnStart=FALSE; //
BOOL showPlaylist=TRUE;
BOOL autoplay=FALSE;
BOOL stopOnExit=TRUE;
BOOL exitOnRemove=FALSE;
BOOL alwaysOnTop=FALSE;
BOOL scrollText=TRUE;
BOOL autoSwitch=FALSE;
char drive[4];

///////////////////////////////////////////////////////////////



POINT move1;
BOOL pactive;
POINT resize;
POINT move;
BYTE b_red=164;
BYTE b_green=11;
BYTE b_blue=187;
BYTE p_red=0;
BYTE p_green=0;
BYTE p_blue=0;
BOOL patterndraw=TRUE;
//BOOL mciOpen=FALSE;
int action; // MOVE or RESIZE
BOOL blocktimer=FALSE;
BOOL isMCIopen=FALSE;
BOOL startPlay=FALSE;
BOOL endTrack=TRUE;
int oldtrack=0;
int tracklength=0;
int playtrack;
BOOL active;
BOOL CDIsLoaded=FALSE;
BOOL blockpos=FALSE;
BOOL eject=FALSE;
LONG xx=50;
LONG yy=50;
LONG zoom=100;
BOOL blockpaint=FALSE;
BOOL can_move=FALSE;
DWORD resumePosition;
BOOL pause=FALSE;
char serialstring[20];
BOOL lockLRVolume;
char temp1[1000];
BOOL block_move=FALSE;
BOOL pushed=FALSE;
BOOL minimizePlaylist=FALSE;
BOOL seek=FALSE;
int introEnd=0;


UINT wDeviceID;
HMIXER hnd_mixer;

DWORD cdVolumeControlID=0;
DWORD masterVolumeControlID=0;
DWORD cdMuteControlID=0;
DWORD lChannelVolume,rChannelVolume,lChannelVolume1,rChannelVolume1;



HWND hwndTT;
HHOOK g_hhk;



/*  Declare Windows procedure  */
LRESULT CALLBACK WindowProcedure (HWND, UINT, WPARAM, LPARAM);

/*  Make the class name into a global variable  */
char szClassName[ ] = "WindowsApp";


int WINAPI
WinMain (HINSTANCE hThisInstance,
         HINSTANCE hPrevInstance,
         LPSTR lpszArgument,
         int nFunsterStil)

{


	g_hinst=hThisInstance;


    HWND hwnd;               /* This is the handle for our window */
    MSG messages;            /* Here messages to the application are saved */
    WNDCLASSEX wincl;        /* Data structure for the windowclass */

    /* The Window structure */
    wincl.hInstance = hThisInstance;
    wincl.lpszClassName = szClassName;
    wincl.lpfnWndProc = WindowProcedure;      /* This function is called by windows */
    wincl.style = CS_DBLCLKS;                 /* Catch double-clicks */
    wincl.cbSize = sizeof (WNDCLASSEX);


    /* Use default icon and mouse-pointer */
    wincl.hIcon = LoadIcon (hThisInstance,MAKEINTRESOURCE(LARGE_ICON));
    wincl.hIconSm = LoadIcon (hThisInstance, MAKEINTRESOURCE(SMALL_ICON));
    wincl.hCursor = LoadCursor (NULL, IDC_ARROW);
    wincl.lpszMenuName = NULL;                 /* No menu */
    wincl.cbClsExtra = 0;                      /* No extra bytes after the window class */
    wincl.cbWndExtra = 0;                      /* structure or the window instance */
    wincl.hbrBackground = NULL;

    /* Register the window class, and if it fails quit the program */
    if (!RegisterClassEx (&wincl))
        return 0;


    /* The class is registered, let's create the program*/
    hwnd = CreateWindowEx (
           0,                   /* Extended possibilites for variation */
           szClassName,         /* Classname */
           "Chameleon CD Player",       /* Title Text */
           //WS_POPUP, /* default window */
           //WS_OVERLAPPEDWINDOW,
          WS_POPUP|WS_SYSMENU,
           //WS_POPUPWINDOW,
           CW_USEDEFAULT,       /* Windows decides the position */
           CW_USEDEFAULT,       /* where the window ends up on the screen */
           //50,
           //50,
           260,                 /* The programs width */
           104,                 /* and height in pixels */
           HWND_DESKTOP,        /* The window is a child-window to desktop */
           NULL,                /* No menu */
           hThisInstance,       /* Program Instance handler */
           NULL                 /* No Window Creation data */
           );


    /* Make the window visible on the screen */
    ShowWindow (hwnd, nFunsterStil);  

    /* Run the message loop. It will run until GetMessage() returns 0 */
    while (GetMessage (&messages, NULL, 0, 0))
    {
    	if (  !IsDialogMessage(hAddSong, &messages) && !IsDialogMessage(hEditSong, &messages)) {
        	/* Translate virtual-key messages into character messages */
        	TranslateMessage(&messages);
        	/* Send message to WindowProcedure */
        	DispatchMessage(&messages);
        }
    }

    /* The program return-value is 0 - The value that PostQuitMessage() gave */
    return messages.wParam;
}


/*  This function is called by the Windows function DispatchMessage()  */

LRESULT CALLBACK
WindowProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{

    switch (message)                  /* handle the messages */
    {

        case WM_CREATE:
        {
            
            hMain=hwnd;
            	 
            InitCommonControls();

         	hPrev=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE,
            7,75, 34, 20,
            hwnd, (HMENU)IDC_PREVIOUSTRACK,
            GetModuleHandle(NULL), NULL);


            hPlay=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE,
            41,75, 34, 20,
            hwnd, (HMENU)IDC_PLAY,
            GetModuleHandle(NULL), NULL);


              hPause=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE,
            75,75, 34, 20,
            hwnd, (HMENU)IDC_PAUSE,
            GetModuleHandle(NULL), NULL);

            hStop=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE,
            109,75, 34, 20,
            hwnd, (HMENU)IDC_STOP,
            GetModuleHandle(NULL), NULL);

            hNext=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE,
            143,75, 34, 20,
            hwnd, (HMENU)IDC_NEXTTRACK,
            GetModuleHandle(NULL), NULL);


             hEject=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE,
            177,75, 34, 20,
            hwnd, (HMENU)IDC_EJECT,
            GetModuleHandle(NULL), NULL);

            hShowPlaylist=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE|BS_AUTOCHECKBOX,
            216,75, 20, 20,
            hwnd, (HMENU)IDC_PLAYLIST,
            GetModuleHandle(NULL), NULL);

             hOptions=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE,
            236,75, 20, 20,
            hwnd, (HMENU)IDC_OPTIONS,
            GetModuleHandle(NULL), NULL);

            hMinimize=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE,
            230,0, 15, 14,
            hwnd, (HMENU)IDC_MINIMIZE,
            GetModuleHandle(NULL), NULL);

             hClose=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE,
            245,0,15, 14,
            hwnd, (HMENU)IDC_CLOSE,
            GetModuleHandle(NULL), NULL);

            hLockVolume=CreateWindowEx(0,"BUTTON","Klik",
            WS_CHILD | WS_VISIBLE|BS_AUTOCHECKBOX,
            0, 0, 35, 20,
            hwnd,(HMENU)IDC_LOCKVOLUME,
            GetModuleHandle(NULL), NULL);

            hMuteVolume=CreateWindowEx(0,"BUTTON","Klik",
            WS_CHILD | WS_VISIBLE|BS_AUTOCHECKBOX,
            40, 0, 35, 20,
            hwnd,(HMENU)IDC_MUTEVOLUME,
            GetModuleHandle(NULL), NULL);


           	hPlayTime=CreateWindowEx(0,"STATIC","",
            WS_CHILD | WS_VISIBLE|SS_NOTIFY|SS_SIMPLE,
            155,20,50,20,
            hwnd, (HMENU)IDC_PLAYTIME,
            //hwnd, NULL,
            GetModuleHandle(NULL), NULL);

             hArtist=CreateWindowEx(0,"STATIC","",
            WS_CHILD | WS_VISIBLE|SS_NOTIFY|SS_SIMPLE,
            10,20,80,12,
            hwnd, NULL,
            GetModuleHandle(NULL), NULL);

             hAlbum=CreateWindowEx(0,"STATIC","",
            WS_CHILD | WS_VISIBLE|SS_NOTIFY|SS_SIMPLE,
            10,35,120,12,
            hwnd, NULL,
            GetModuleHandle(NULL), NULL);

             hTrack=CreateWindowEx(0,"STATIC","",
            WS_CHILD | WS_VISIBLE|SS_NOTIFY|SS_SIMPLE,
            10,50,120,12,
            hwnd, NULL,
            GetModuleHandle(NULL), NULL);

             hTrackLength=CreateWindowEx(0,"STATIC","",
            WS_CHILD | WS_VISIBLE|SS_NOTIFY|SS_SIMPLE,
            155,50,50,20,
            hwnd, NULL,
            GetModuleHandle(NULL), NULL);


             hStatus=CreateWindowEx(0,"STATIC","",
            WS_CHILD | WS_VISIBLE|SS_NOTIFY|SS_SIMPLE,
            110,20,30,20,
            hwnd, NULL,
            GetModuleHandle(NULL), NULL);


           hPosition=CreateWindowEx(0,"SCROLLBAR","",
            WS_CHILD | WS_VISIBLE|SBS_HORZ,
            10,64, 200, 8,
            hwnd, (HMENU)IDC_PLAYPOS,
            GetModuleHandle(NULL), NULL);

            hLeftAudio=CreateWindowEx(0,"SCROLLBAR","",
            WS_CHILD | WS_VISIBLE|SBS_VERT,
            210,12, 8, 60,
            hwnd,(HMENU)IDC_LVOLUME,
            GetModuleHandle(NULL), NULL);

             hRightAudio=CreateWindowEx(0,"SCROLLBAR","",
            WS_CHILD | WS_VISIBLE|SBS_VERT,
            230,12, 8, 60,
            hwnd, (HMENU)IDC_RVOLUME,
            GetModuleHandle(NULL), NULL);

              hMasterAudio=CreateWindowEx(0,"SCROLLBAR","",
            WS_CHILD | WS_VISIBLE|SBS_VERT,
            250,12, 8, 60,
            hwnd, (HMENU)IDC_MASTERVOLUME,
            GetModuleHandle(NULL), NULL);

           

            LoadSettings(); 


            DoCreateDialogTooltip(hwnd);

            char curdir[MAX_PATH];
            GetCurrentDirectory(MAX_PATH,curdir);
            if(!LoadSkin(hwnd, curdir,skinname)) {
            	strcpy(skinname,"BASIC"); // internal skin
                LoadSkin(hwnd, curdir,skinname);
            }

            InitializeMainWindow(); // subclassing controls


            UpdateMainWindow(hwnd); // set position and size of controls
                                    
           
             hPlayListDlg = CreateDialog(GetModuleHandle(NULL),
                     	MAKEINTRESOURCE(PLAYLIST_DIALOG),hwnd, ToolDlgProc);

             if(showPlaylist)
            	if(! IsWindowVisible(hPlayListDlg))
                		ShowWindow(hPlayListDlg,SW_SHOW);
                		
    		
          HWND flag=HWND_TOP;

            if(alwaysOnTop)
            	flag=HWND_TOPMOST;

            SetWindowPos(hwnd,flag,main_xpos,
            			main_ypos,0,0,SWP_NOSIZE);

             SetMixer(); // initialize mixer device
             
            // main timer - open MCI, fill playlist , move scrollbar ...
          	 SetTimer(hwnd,IDT_CD_TIMER,200,(TIMERPROC) MyTimerProc);

        	return 0;
        }

       

        case WM_ACTIVATE:
        {

        	// prevent redrawing whole main window, just titlebar
            RECT rc; // titlebar rect
            rc.left=m_cdt[TITLEBAR].bdt.x;
            rc.top=m_cdt[TITLEBAR].bdt.y;
            rc.right=m_cdt[TITLEBAR].bdt.width;
            rc.bottom=m_cdt[TITLEBAR].bdt.height;
           // *************
              if(LOWORD(wParam)==WA_INACTIVE)
              	active=FALSE;
              else {
              	active=TRUE;
              	
           		if(minimizePlaylist) { // restore playlist dialog
               		minimizePlaylist=FALSE;
                	ShowWindow(hPlayListDlg,SW_SHOWNOACTIVATE);
            	}
             }

            InvalidateRect(hwnd,&rc,FALSE); // update titlebar
        
        }
        return 0;





        case WM_PAINT:
          {
            // paint main window ( background, titlebar(active,inactive)
        	PAINTSTRUCT ps;
    		HDC hdc;
        	hdc = BeginPaint(hwnd, &ps);
            HDC hdcmem = CreateCompatibleDC(hdc);
            HBITMAP hbmOld;

            RECT rect;
            GetClientRect(hwnd,&rect);

             hbmOld=(HBITMAP)SelectObject(hdcmem,mainbitmap[m_cdt[MAIN].main.bitmapindex]);
            // background
             BitBlt(hdc,0,
                		0,
                        rect.right,
                        rect.bottom,
                        hdcmem,
                        m_cdt[MAIN].main.bitmap.x,
                        m_cdt[MAIN].main.bitmap.y,
                        SRCCOPY);


            SelectObject(hdcmem,mainbitmap[m_cdt[TITLEBAR].bdt.bitmapindex]);
            // titlebar
            if(active)
            	BitBlt(hdc,m_cdt[TITLEBAR].bdt.x,
                				m_cdt[TITLEBAR].bdt.y,
                                m_cdt[TITLEBAR].bdt.width,
                                m_cdt[TITLEBAR].bdt.height,
                                hdcmem,
                                m_cdt[TITLEBAR].bdt.bitmap[ACTIVE].x,
                				m_cdt[TITLEBAR].bdt.bitmap[ACTIVE].y,
                                SRCCOPY);
            else
               		BitBlt(hdc,m_cdt[TITLEBAR].bdt.x,
                				m_cdt[TITLEBAR].bdt.y,
                                m_cdt[TITLEBAR].bdt.width,
                                m_cdt[TITLEBAR].bdt.height,
                                hdcmem,
                                m_cdt[TITLEBAR].bdt.bitmap[INACTIVE].x,
                				m_cdt[TITLEBAR].bdt.bitmap[INACTIVE].y,
                                SRCCOPY);

            SelectObject(hdcmem,hbmOld);
            DeleteDC(hdcmem);
            EndPaint(hwnd, &ps);
            return 0L;
          }

            case WM_DEVICECHANGE:
            {
               // support for multiple cdrom switching // NOT tested //
               // I have just one cdromdrive at home 
                
                switch(wParam) {
                    case DBT_DEVICEARRIVAL:
                    {
                        DEV_BROADCAST_HDR *pdbch = (DEV_BROADCAST_HDR *) lParam;
                        
                        if (pdbch->dbch_devicetype == DBT_DEVTYP_VOLUME) {
                            
                            DEV_BROADCAST_VOLUME *pdbcv = (DEV_BROADCAST_VOLUME *) lParam;
                            if (pdbcv->dbcv_flags == DBTF_MEDIA)
                            {
                                
                                TCHAR szDrive[4];
                                // pdbcv->unitmask contains the drive bits
                                UINT i;
                                for ( i=0; !(pdbcv->dbcv_unitmask & (1<<i)); i++);
                                    wsprintf(szDrive, _T("%c:\\"), 'A'+i);
                                    if (GetDriveType(szDrive) == DRIVE_CDROM) {
                                        if(autoSwitch) {
                                        // if enabled autoswitching
                                            blocktimer=TRUE;
                                            sprintf(drive,"%c:",szDrive[0]);
                                            if(wCDPlayerID) {
                                                stopCD(wCDPlayerID);
                                                closeCD(hwnd,&wCDPlayerID);
                                             }
                                             blocktimer=FALSE; 
                                           
                                  
                                        }
                                    }
                            
                            }
                            else {
                                // It is a network drive
                            }
                            break;
                        }
                    }
                    case DBT_DEVICEREMOVECOMPLETE:// CD drawer was opened
                       
                    break;
                }
            }
            return TRUE; 
                
            
            

         
         case WM_KEYDOWN:
         // key shortcuts for cd player (pause,play,....)
         	switch (wParam) {
            	case 0x58:	// X  play

					NotifyButton(hPlay,TRUE);
                break;

                case 0x43:	// C  pause
                	 NotifyButton(hPause,TRUE);
                break;
                case 0x56:	// V stop
                	NotifyButton(hStop,TRUE);
                break;

                case 0x59: 	// Y  previous
                	NotifyButton(hPrev,TRUE);
                break;

                case 0x5A: 	// Z  previous
                	NotifyButton(hPrev,TRUE);
                break;

                case 0x42:	// B next
                	NotifyButton(hNext,TRUE);
                break;



            }
         break;


          case WM_KEYUP:
          // key shortcuts for cd player (pause,play,....)
         	switch (wParam) {
            	case 0x58:	// X  play

					NotifyButton(hPlay,FALSE);
                break;

                case 0x43:	// C  pause
                	 NotifyButton(hPause,FALSE);
                break;
                case 0x56:	// V stop
                	NotifyButton(hStop,FALSE);
                break;

                case 0x59: 	// Y  previous
                	NotifyButton(hPrev,FALSE);
                break;

                case 0x5A: 	// Y  previous
                	NotifyButton(hPrev,FALSE);
                break;

                case 0x42:	// B next
                	NotifyButton(hNext,FALSE);
                break;



            }
         break;




         case CM_STATIC_LBUTTONDOWN:
         // switch elapsed/remaining time display
         	switch(lParam) {
            	case IDC_PLAYTIME:
                	 	elapsedTime=!elapsedTime;
                break;


            }

         break;


        case WM_HSCROLL:
			switch(LOWORD(wParam))
			{
                case SB_THUMBTRACK:
                	blockpos=TRUE; // block  moving of scrollbar
                                    // and displaying text 
                   SetScrollPos((HWND)lParam,SB_CTL,HIWORD(wParam),FALSE);
                   char t[20];
                   if(elapsedTime)
        				wsprintf(t,"%02i:%02i",HIWORD(wParam)/60,HIWORD(wParam)%60);
                   else {
                   		int pos=tracklength-HIWORD(wParam);
                        wsprintf(t,"%02i:%02i",pos/60,pos%60);
                   }
                        
        			SetStaticText(hPlayTime,t);
                break;

                 case SB_THUMBPOSITION:

                         blockpos=FALSE;
                         if(IsPlay(wCDPlayerID)) { // if playing then continue play
                         	seekCD(wCDPlayerID,getCurrentTrack(wCDPlayerID),
                         		HIWORD(wParam)/60,HIWORD(wParam)%60);
                         	playCD(wCDPlayerID);
                         }
                         else {
                         	seek=TRUE;
                             seekCD(wCDPlayerID,getCurrentTrack(wCDPlayerID),
                         		HIWORD(wParam)/60,HIWORD(wParam)%60);
                         }

                       SetScrollPos((HWND)lParam,SB_CTL,HIWORD(wParam),FALSE);
                 break;
			}

            break;

            case WM_VSCROLL:
            // volume control scrollbars

            	switch(LOWORD(wParam))
				{
                	case SB_THUMBTRACK:

                    	if((HWND)lParam==hLeftAudio || (HWND)lParam==hRightAudio) {
                        		if (lockLRVolume) {
                    				SetScrollPos(hLeftAudio,SB_CTL,HIWORD(wParam),FALSE);
                        			SetScrollPos(hRightAudio,SB_CTL,HIWORD(wParam),FALSE);
                        			InvalidateRect(hLeftAudio,NULL,FALSE);
                        			InvalidateRect(hRightAudio,NULL,FALSE);
                        		}
                        		else
                        			SetScrollPos((HWND)lParam,SB_CTL,HIWORD(wParam),FALSE);

                            if(cdVolumeControlID != 0)
                        		mixerSetVolume((HMIXEROBJ)hnd_mixer,cdVolumeControlID,2,0,
									(655-GetScrollPos(hLeftAudio,SB_CTL))*100,
                            			(655-GetScrollPos(hRightAudio,SB_CTL))*100);
                    	}

                         SetScrollPos((HWND)lParam,SB_CTL,HIWORD(wParam),FALSE);
                         if(masterVolumeControlID != 0)
                      	if((HWND)lParam==hMasterAudio)
                        	if(masterVolumeControlID != 0)
								mixerSetVolume((HMIXEROBJ)hnd_mixer,masterVolumeControlID,2,0,
									(655-GetScrollPos((HWND)lParam,SB_CTL))*100,
                            		(655-GetScrollPos((HWND)lParam,SB_CTL))*100);

                     blockpos=TRUE;
                  	sprintf(temp1,"Volume: %i",
                  		(655-GetScrollPos((HWND)lParam,SB_CTL))*100/655);
                    SetStaticText(hStatus,temp1);
                  break;

                 	case SB_THUMBPOSITION:
                        blockpos=FALSE;
                 	break;
				}


            break;

/*
        case MM_MCINOTIFY:
        
        // notify end of song: set variable to continue with next song
        	switch(wParam)
            {
                case MCI_NOTIFY_SUCCESSFUL:
                MessageBeep(0);
		      //playCD(wCDPlayerID,0,0,0);
                   endTrack=TRUE;
                   startPlay=TRUE;
                return TRUE;

            }

        break;
*/


        case WM_COMMAND:

            switch(LOWORD(wParam))
            {
                // popup menu
            	case IDM_ABOUT:
                	hAbout=CreateDialog(GetModuleHandle(NULL),
                        	MAKEINTRESOURCE(ABOUT_DIALOG),hwnd, ToolDlgAbout);

                break;

                case IDM_ALWAYSONTOP:
                	alwaysOnTop=!alwaysOnTop;
                    if(alwaysOnTop)
                    	SetWindowPos(hMain,HWND_TOPMOST,0,0,0,0,
                    		SWP_NOMOVE|SWP_NOSIZE);
                    else
                    	SetWindowPos(hMain,HWND_NOTOPMOST,0,0,0,0,
                        	SWP_NOMOVE|SWP_NOSIZE);

                break;

                
                case IDM_SNAPWINDOWS:
                	snapWindow=!snapWindow;
                break;

                case IDM_SHOWTOOLTIP:
                      showTooltip=!showTooltip;
                break;

                case IDM_SHOWPLAYLIST:
                     if(! IsWindowVisible(hPlayListDlg))
                		ShowWindow(hPlayListDlg,SW_SHOW	);
                break;

                case  IDM_OPTIONS:
                    	hOptionsDialog=DialogBox(GetModuleHandle(NULL),
                        	MAKEINTRESOURCE(OPTIONS_DIALOG),hwnd, ToolDlgOptions);
                break;

                case IDM_PLAYONSTART:
                    playOnStart=!playOnStart;
                break;

                case IDM_EXITONREMOVE:
                     exitOnRemove=!exitOnRemove;
                break;

                case IDM_STOPONEXIT:
                      stopOnExit=!stopOnExit;
                break;

                case IDM_ELAPSEDTIME:
                      elapsedTime=!elapsedTime;
                break;

                case IDM_KEYSHORTCUTS:
                	keyShortcuts=!keyShortcuts;
                break;

                case IDM_REPEAT:
                     repeat=!repeat;
                break;

                case IDM_INTROPLAY:
                     introPlay=!introPlay;
                break;

                case IDM_RANDOMSTART:
                     randomIntro=!randomIntro;
                break;

                case IDM_INTRO5:
                     introPlayLen=5;
                break;

                case IDM_INTRO10:
                     introPlayLen=10;
                break;

                case  IDM_INTRO15:
                     introPlayLen=15;
                break;

                case IDM_INTRO30:
                     introPlayLen=30;
                break;

                case IDM_INTRO45:
                     introPlayLen=45;
                break;

                case IDM_INTRO60:
                    introPlayLen=60;
                break;

                case IDM_INTRO120:
                    introPlayLen=120;
                break;

                case IDM_EXIT:
                     SendMessage(hwnd,WM_CLOSE,0,0);
                break;
                // end popup menu

                // control buttons (play,pause, next ...)
                case IDC_PREVIOUSTRACK:
                // jump to previous song in playlist
                {

                    int track=getCurrentTrack(wCDPlayerID);
                    int index=ListBoxGetIndex(hPlaylist,(WORD)track);
					if(index >0) {
                    	index--;
                        track=ListBoxGetData(hPlaylist,index);

                    	if(IsPlay(wCDPlayerID)) { // if playling then
                    	                           // continue playling
                        	seekCD(wCDPlayerID,track,0,0);
                        	playCD(wCDPlayerID);
                        }
                        else
                        	seekCD(wCDPlayerID,track,0,0);
                    }
        

                }
                break;

            	case IDC_PLAY:
                // play 
                	if(pause) { // resume from pause
                    	int sec=MCI_TMSF_SECOND(resumePosition);
    					int min=MCI_TMSF_MINUTE(resumePosition);
            			int track=MCI_TMSF_TRACK(resumePosition);
                        seekCD(wCDPlayerID,track,min,sec);
                        playCD(wCDPlayerID);
                        pause=FALSE;
                    }
                    else {
                        int track=getCurrentTrack(wCDPlayerID);
                        // seek to start of song or continue
                        // from current position ( set with
                        //seek scrollbar)
                        if(!seek) 
                        	seekCD(wCDPlayerID,track,0,0);
                        	
                        playCD(wCDPlayerID);
                    }


                break;

                case IDC_PAUSE:
                //**pause 

                	if(pause) { // resume
                    	int sec=MCI_TMSF_SECOND(resumePosition);
    					int min=MCI_TMSF_MINUTE(resumePosition);
            			int track=MCI_TMSF_TRACK(resumePosition);
                        if(!seek) // if not new position set with scrollbar
                        	seekCD(wCDPlayerID,track,min,sec); // seek to 
                                                                 // resume position
                        playCD(wCDPlayerID);             
                        pause=FALSE;
                    }
                    else {
                        // pause cd ( remember position)
                       	pauseCD(wCDPlayerID,&resumePosition);
						pause=TRUE;
                    }

                
                break;


                case IDC_STOP:
                {
                //** stop
                	pause=FALSE;
                	int track=getCurrentTrack(wCDPlayerID);
                    stopCD(wCDPlayerID);
                    seekCD(wCDPlayerID,track,0,0); // seek at begining of track
                }
                break;

                case IDC_NEXTTRACK:
                // seek to next track
                {
                	int track=getCurrentTrack(wCDPlayerID);

                    int index=ListBoxGetIndex(hPlaylist,track);
					if(index < ListBoxGetCount(hPlaylist)-1) { // if not last track
                    	index++;                               // in playlist
                        track=ListBoxGetData(hPlaylist,index);
                    	if(IsPlay(wCDPlayerID)) { // if playing then continue playing
                            seekCD(wCDPlayerID,track,0,0);
                        	playCD(wCDPlayerID);
                        }
                        else // just seek to next track
                           seekCD(wCDPlayerID,track,0,0);
                    }
                }
                break;

                case IDC_PLAYLIST:
                    // show or hide playlist dialog
                	if(GetButtonCheckState(hShowPlaylist))
                    	ShowWindow(hPlayListDlg,SW_SHOW	);
                    else
                    	ShowWindow(hPlayListDlg,SW_HIDE	);
                        /*
                	if(! IsWindowVisible(hPlayListDlg))
                		ShowWindow(hPlayListDlg,SW_SHOW	);
                    else
                    	ShowWindow(hPlayListDlg,SW_HIDE	);
                    */

                break;

                case IDC_LOCKVOLUME:
                // lock left and right channel (move both scrollbars )
                // CD mixer line
                {

                    if (GetButtonCheckState(hLockVolume)) {
                		lockLRVolume=TRUE; // need by WM_VSCROLL to move
                		                  // both scrollbars
                    	int left=GetScrollPos(hLeftAudio,SB_CTL);
                    	int right=GetScrollPos(hRightAudio,SB_CTL);
                    	// equalize both scrollbars position
                    	int pos=(left+right)/2;
                    	SetScrollPos(hLeftAudio,SB_CTL,pos,FALSE);
                    	SetScrollPos(hRightAudio,SB_CTL,pos,FALSE);
                    	//equalize both channels
                        mixerSetVolume((HMIXEROBJ)hnd_mixer,cdVolumeControlID,2,0,
							(655-GetScrollPos(hLeftAudio,SB_CTL))*100,
                            (655-GetScrollPos(hRightAudio,SB_CTL))*100);
                        // redraw scrollbars to new positions
                        InvalidateRect(hLeftAudio,NULL,FALSE);
                        InvalidateRect(hRightAudio,NULL,FALSE);
                    }
                    else
                       lockLRVolume=FALSE;


                }
                break;

                case IDC_MUTEVOLUME:
                // mute CD volume ( CD mixer line)
                {
                	 if (GetButtonCheckState(hMuteVolume))
                  		mixerSetMute((HMIXEROBJ)hnd_mixer,cdMuteControlID,TRUE);
                     else
                        mixerSetMute((HMIXEROBJ)hnd_mixer,cdMuteControlID,FALSE);
                }

                break;

                case IDC_OPTIONS:
                // show options dialog
                    	hOptionsDialog=DialogBox(GetModuleHandle(NULL),
                        	MAKEINTRESOURCE(OPTIONS_DIALOG),hwnd, ToolDlgOptions);
                break;

                case IDC_EJECT:
                    // eject cd
                      ejectCD(wCDPlayerID);
                break;

                case IDC_MINIMIZE:
                // minimize main window and hide playlist dialog
                	if(IsWindowVisible(hPlayListDlg)) {
                		ShowWindow(hPlayListDlg,SW_HIDE);
                        minimizePlaylist=TRUE;
                    }

                    CloseWindow(hwnd);

                break;

                case IDC_CLOSE:
                    SendMessage(hwnd,WM_CLOSE,0,0);
                break;
            }

        break;


        case WM_LBUTTONDOWN:
        {

        //*******WINDOW MOVE SUPPORT ********

              move.x= LOWORD(lParam);
              move.y= HIWORD(lParam);
              
               RECT rc; // titlebar rect 
            	rc.left=m_cdt[TITLEBAR].bdt.x;
            	rc.top=m_cdt[TITLEBAR].bdt.y;
            	rc.right=rc.left+m_cdt[TITLEBAR].bdt.width;
            	rc.bottom=rc.top+m_cdt[TITLEBAR].bdt.height;

                if(PtInRect(&rc,move)){ // if mouse on titlebar
                    SnapMove=FALSE;
                    if(snapWindow) { // snap window support
                    	RECT rect,rect1;
              			GetWindowRect(hPlayListDlg,&rect);
                        GetWindowRect(hwnd,&rect1);
                        if (rect1.top < rect.bottom && rect1.bottom > rect.top)
                       		if(abs(rect1.left-rect.right) < snapPixel ||
                            	abs(rect1.right-rect.left) < snapPixel) 
                                SnapMove=TRUE; // windows are close enough


                        if (rect1.left < rect.right && rect1.right> rect.left)
                        		if(abs(rect1.top-rect.bottom) < snapPixel ||
                                	abs(rect1.bottom-rect.top) < snapPixel)
                                    SnapMove=TRUE; // windows are close enough


              			move1.x=rect.left-rect1.left;
              			move1.y=rect.top-rect1.top;

                    }

                    can_move=TRUE; // mouse on titlebar
                   	SetCapture(hwnd);
                }
                else
                	can_move=FALSE;

        }
        //***************************
        break;

        case WM_CONTEXTMENU:
            // popup menu support

    		if (!OnContextMenu(hwnd, LOWORD(lParam), HIWORD(lParam)))
        		return DefWindowProc(hwnd, message, wParam, lParam);

    	break;


        case WM_LBUTTONUP:
        	if(can_move) {
              ReleaseCapture();
              can_move=FALSE;
            }
        break;


        case WM_MOUSEMOVE:
            MSG msg;
            msg.hwnd=hwnd;
            msg.message=message;
        	SendMessage(hwndTT ,TTM_RELAYEVENT,0,(LPARAM)&msg);
        	switch(wParam)
            {
                case MK_LBUTTON:
                //******MOVE WINDOW********************
                	if(can_move) {
                   		RECT rect;
                    	RECT rect1;
                    	GetWindowRect(hwnd,&rect1);
                    	GetWindowRect(hPlayListDlg,&rect);

                		POINT pt;
                    	GetCursorPos(&pt);
                    	int x,y;
                    	x=pt.x-move.x; // new left
                    	y=pt.y-move.y; // new top

                    	if(snapWindow && !SnapMove) { 

                    		if (rect1.top < rect.bottom && rect1.bottom > rect.top) {

                        		if(abs(x-rect.right) < snapPixel) // from right
                        			x=rect.right;
                                else
                            		if(abs(x+(rect1.right-rect1.left)-rect.left) < snapPixel)
										x=rect.left-(rect1.right-rect1.left); // from left
                    		}

                        	if (rect1.left < rect.right && rect1.right> rect.left) {
                        		if(abs(y-rect.bottom) < snapPixel) // from top
                        			y=rect.bottom;
                        		else
                            		if(abs(y+(rect1.bottom-rect1.top)-rect.top) < snapPixel)
										y=rect.top-(rect1.bottom-rect1.top); // from bottom
                        	}
                    	}

                    	SetWindowPos(hwnd,NULL,x,
                    						y,
                                            0,
                                            0,
                    			SWP_NOSIZE|SWP_NOZORDER);

                    	if(SnapMove) {// move playlist window
                       		SetWindowPos(hPlayListDlg,NULL,
                        					x+move1.x,
                    						y+move1.y ,
                                            0,
                                            0,
                    				SWP_NOSIZE|SWP_NOZORDER	|SWP_NOACTIVATE	);
						}
                	}
                break;
            }

        //***********************************************

        break;

         case WM_NOTIFY:
        	OnWMNotify(lParam); // tooltip support
        return 0;


        case WM_DESTROY:
        {
        	if(wCDPlayerID) {
                if(stopOnExit)
            	   stopCD(wCDPlayerID);
        		closeCD(hwnd,&wCDPlayerID);
    		}

            UnhookWindowsHookEx(g_hhk); // tooltip support

            mixerClose(hnd_mixer);
        	SaveSettings(hwnd); // save settings
        	
        	void UninitializePlaylistWindow();
        	void UnitializeMainWindow();
            

        	 DestroyWindow(hPlayListDlg);
             hPlayListDlg=NULL;

            // delete skin bitmaps
            for (int i=0;i<numOfBitmaps;i++)
     			DeleteObject(mainbitmap[i]);

 			for (int i=0;i<numOfFonts;i++)
     			DeleteObject(fontbitmap[i]);

            for (int i=0;i<6;i++)
     			DeleteObject(pattern[i]);

            PostQuitMessage (0);

        }       /* send a WM_QUIT to the message queue */
        return 0;

        default:                      /* for messages that we don't deal with */
            return DefWindowProc (hwnd, message, wParam, lParam);
    }

    return 0;
}





VOID CALLBACK MyTimerProc(
    HWND hwnd,        /* handle of window for timer messages */
    UINT message,     /* WM_TIMER message                    */
    UINT idTimer,     /* timer identifier                    */
    DWORD dwTime)     /* current system time                 */
{

	switch (idTimer)
	{
        case IDT_CD_TIMER:
        	if(!blocktimer) // if skin changing or switching to 
            	CDTimerFunction(hwnd);  // second CDROM drive
        break;


    }
}





BOOL playCD(MCIDEVICEID  wDeviceID)
{
   

	if(!CDIsLoaded)
    	return FALSE;

	MCI_PLAY_PARMS mciPlayParms;
	//mciPlayParms.dwCallback=MAKELONG(hMain, 0);
    DWORD dwReturn;

    playtrack=getCurrentTrack( wDeviceID);
    int length=getCDTrackLength(wDeviceID,playtrack);
    int pos=getCurrentPosition(wDeviceID);

    if(introPlay) { // if intro play
        introEnd;
    	if(pos+introPlayLen < length) 
        	introEnd=pos+introPlayLen; // set end position
        else
        	introEnd=length-2; // limit to the end of song
    }
 
    dwReturn=mciSendCommand(wDeviceID, MCI_PLAY,0, 0);

            if(dwReturn != 0) {
    			char error[130];
    			if(mciGetErrorString(dwReturn ,error,128)) {
        			MessageBox(hMain,error,"MCI PLAY ERROR",MB_ICONSTOP);
            		return FALSE;
                }
        	}

    seek=FALSE;
    return TRUE;
        		
}





int getCDTrackLength(MCIDEVICEID wDeviceID,BYTE bTrack)
{

//**
    // set time format  MCI_FORMAT_MSF
    // I had problems to get correct data if MCI_FORMAT_TMSF was set
    
	
    MCI_SET_PARMS  mciSetParms;
	mciSetParms.dwTimeFormat = MCI_FORMAT_MSF;

	mciSendCommand(wDeviceID, MCI_SET,MCI_WAIT|
	MCI_SET_TIME_FORMAT, (DWORD)(LPVOID) &mciSetParms);
	
	
	MCI_STATUS_PARMS mciStatus;
	mciStatus.dwItem=MCI_STATUS_LENGTH;
	mciStatus.dwTrack=bTrack;

	mciSendCommand(wDeviceID,MCI_STATUS,MCI_WAIT|MCI_STATUS_ITEM|MCI_TRACK ,
		(DWORD) (LPMCI_STATUS_PARMS) &mciStatus);
		

	BYTE min=MCI_MSF_MINUTE(mciStatus.dwReturn);
	BYTE sec=MCI_MSF_SECOND(mciStatus.dwReturn);
  
    // set time format MCI_FORMAT_TMSF
    mciSetParms.dwTimeFormat = MCI_FORMAT_TMSF;

	mciSendCommand(wDeviceID, MCI_SET,MCI_WAIT|
	MCI_SET_TIME_FORMAT, (DWORD)(LPVOID) &mciSetParms);
	
        	
	return min*60+sec;
}


void stopCD(MCIDEVICEID  wDeviceID)
{
	mciSendCommand(wDeviceID, MCI_STOP, MCI_WAIT, 0);
   	//mciSendCommand(wDeviceID, MCI_CLOSE, 0, NULL);

}

void pauseCD(MCIDEVICEID wDeviceID,LPDWORD pausePosition)
{

   MCI_STATUS_PARMS mciStatus;
   mciSendCommand(wDeviceID, MCI_STOP,MCI_WAIT, 0);

   mciStatus.dwItem=MCI_STATUS_POSITION;
   mciSendCommand(wDeviceID,MCI_STATUS,MCI_WAIT|MCI_STATUS_ITEM,
 		(DWORD) (LPMCI_STATUS_PARMS) &mciStatus);

   *pausePosition=mciStatus.dwReturn;


}



void ejectCD(MCIDEVICEID wDeviceID)
{
//**
    
	 MCI_STATUS_PARMS mciStatus;
     mciStatus.dwItem=MCI_STATUS_READY;
     mciSendCommand(wCDPlayerID,MCI_STATUS,MCI_STATUS_ITEM|MCI_WAIT,
     	(DWORD) (LPMCI_STATUS_PARMS) &mciStatus);

	if (mciStatus.dwReturn==TRUE) {
    	mciSendCommand(wDeviceID, MCI_SET,
        MCI_SET_DOOR_OPEN|MCI_WAIT,0);
        eject=TRUE;
    }
    else
    	if(eject) {
            mciSendCommand(wDeviceID, MCI_SET,
        		MCI_SET_DOOR_CLOSED|MCI_WAIT,0);
            eject=FALSE;
        }
        else {
        	mciSendCommand(wDeviceID, MCI_SET,
        		MCI_SET_DOOR_OPEN|MCI_WAIT,0);
            eject=TRUE;
        }
}




UINT getCDNumOfTracks(MCIDEVICEID wDeviceID)
{
//**

// return number of tracks on CD

	MCI_STATUS_PARMS mciStatus;

	mciStatus.dwItem=MCI_STATUS_NUMBER_OF_TRACKS;
 	mciSendCommand(wDeviceID,MCI_STATUS,MCI_WAIT|MCI_STATUS_ITEM|MCI_TRACK ,
 		(DWORD) (LPMCI_STATUS_PARMS) &mciStatus);

    return (UINT)mciStatus.dwReturn;

}



BOOL loadCDTracks(MCIDEVICEID wDeviceID,int *tracks_array, int *nTracks)
{
//** load audio tracks into track_array ( not data tracks)
    MCI_STATUS_PARMS mciStatus;

    int count=0;
	 for(UINT i=1;i <= getCDNumOfTracks(wDeviceID);i++)
     {
        mciStatus.dwItem=MCI_CDA_STATUS_TYPE_TRACK;
        mciStatus.dwTrack=i;
        mciSendCommand(wDeviceID,MCI_STATUS,MCI_WAIT|MCI_STATUS_ITEM|MCI_TRACK ,
        (DWORD) (LPMCI_STATUS_PARMS) &mciStatus);

        if(mciStatus.dwReturn==MCI_CDA_TRACK_AUDIO)
        {
        	count++;
        	tracks_array[count-1]=i;
        }
     }
     if (count > 0)
     {
     	*nTracks=count;
     	return TRUE;
     }
     *nTracks=0; // there is no audio track on cd
     return FALSE;
}


BOOL CALLBACK ToolDlgEdit(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam)
{
    // edit playlist dialog procedure 
	switch(Message)
    {
    	case WM_INITDIALOG:
        {
    		if(!CDIsLoaded)
				return TRUE;
				
			char tmp1[100];
            char text[100];
            HANDLE hFile=OpenIniFile(playlistIniFile);

            if(GetIniKey(hFile,serialstring,"artist",text))
            	SetDlgItemText(hwnd,IDE_ARTISTNAME,text);
            else
                SetDlgItemText(hwnd,IDE_ARTISTNAME,"Unknown Artist");

            if(GetIniKey(hFile,serialstring,"title",text))
            	SetDlgItemText(hwnd,IDE_ALBUMNAME,text);
            else
                SetDlgItemText(hwnd,IDE_ALBUMNAME,"Unknown Album");


            for (int i=0;i< numOfTracks;i++) {
                sprintf(tmp1,"%i",i);
                if(!GetIniKey(hFile,serialstring,tmp1,text))
                    sprintf(tmp1,"%i. Track %i",i+1,i+1);
                else
                    sprintf(tmp1,"%i. %s",i+1,text);
            	SendDlgItemMessage(hwnd,IDL_SONGLIST,LB_ADDSTRING,0,(LPARAM) tmp1);
             }

            CloseIniFile(hFile);
        }
        return TRUE;


		case WM_COMMAND:
         	switch (HIWORD(wParam))
         	{
         		case BN_CLICKED:
            		switch(LOWORD(wParam))
            		{
                		case IDB_SETNAME:
                		{
                		  // set new name of song 
                    		int sel= SendDlgItemMessage(hwnd,IDL_SONGLIST,LB_GETCURSEL,0,0);
                    		if (sel==LB_ERR)
                    			return TRUE;
                			char text[100];
                    		char tmp1[100];
                    		GetDlgItemText(hwnd,IDE_SONGMANE,text,90);
                    		if(strlen(text)==0)
                    			return TRUE;

                    		sprintf(tmp1,"%i. %s",sel+1,text);

                    		SendDlgItemMessage(hwnd,IDL_SONGLIST,LB_DELETESTRING ,(WPARAM)sel,0);
							SendDlgItemMessage(hwnd,IDL_SONGLIST,LB_INSERTSTRING ,(WPARAM)sel,(LPARAM)tmp1);
                    		if(sel+1 < SendDlgItemMessage(hwnd,IDL_SONGLIST,LB_GETCOUNT ,0,0))
                    			sel++; // next song in list
                    		else
                    			sel=0; // first song
                			// selects next song
                    		SendDlgItemMessage(hwnd,IDL_SONGLIST,LB_SETCURSEL,sel,0);
                    		
            				SendDlgItemMessage(hwnd,IDL_SONGLIST,LB_GETTEXT,(WPARAM)sel,(LPARAM)&text);
                    		char *start= strstr(text," ");
                    		SetDlgItemText(hwnd,IDE_SONGMANE,start+1);
                    		SetFocus(GetDlgItem(hwnd,IDE_SONGMANE));
                    		SendDlgItemMessage(hwnd,IDE_SONGMANE,EM_SETSEL,0,-1);
                            
                    		
                            return TRUE;

                        }
                        



                    	case IDB_ADD_TO_PLAYLIST:
                		{
                		  // add song to playlist
                			int sel= SendDlgItemMessage(hwnd,IDL_SONGLIST,LB_GETCURSEL,0,0);
                    		if (sel==LB_ERR)
                    			return TRUE;
                    		char text[100];
                    		SendDlgItemMessage(hwnd,IDL_SONGLIST,LB_GETTEXT,(WPARAM)sel,(LPARAM)&text);

                    		ListBoxAddString(hPlaylist,text,tracks_array[sel],TRUE);
                    	}
                    	break;

						case IDB_SAVE:
                		{
                		  // save to file
                		  	if(!CDIsLoaded) {
                     			DestroyWindow(hwnd);
	                		  	return FALSE;
                		  	}

             				char tmp[20];
              				char text[100];

                    		HANDLE hFile=OpenIniFile(playlistIniFile);

                    		GetDlgItemText(hwnd,IDE_ARTISTNAME,text,90);
                    		SetIniKey(hFile,serialstring,"artist",text);
                    		SetStaticText(hArtist,text);
                    		GetDlgItemText(hwnd,IDE_ALBUMNAME,text,90);
                    		SetIniKey(hFile,serialstring,"title",text);
                    		SetStaticText(hAlbum,text);
             				for (int i=0;i< numOfTracks;i++) {
                    		SendDlgItemMessage(hwnd,IDL_SONGLIST,
                        		LB_GETTEXT,(WPARAM)i,(LPARAM)&text);
                        		char *start= strstr(text," ");

                        		sprintf(tmp,"%i",i);
                        		SetIniKey(hFile,serialstring,tmp,start+1);
                			}
                			
                			                   	 	      			
                			SaveCustomPlaylist();
                			/*
                    		sprintf(tmp,"%i",numOfTracks);
                    		SetIniKey(hFile,serialstring,"numtracks",tmp);

                            // save custom playlist
                     		int numplay=SendMessage(hPlaylist,LB_GETCOUNT,0,0);

            				if(numplay==0) {
                    			SetIniKey(hFile,serialstring,"numplay","");
                				CloseIniFile(hFile);
                        		DestroyWindow(hwnd);
                				return TRUE;
            				}

            				char *order=(char *) malloc(100);
            				order[0]=0;

            				for(int i=0;i<numplay;i++) {
            					WORD data=ListBoxGetData(hPlaylist,i);
                				sprintf(tmp,"%i ",data-1);
                				strcat(order,tmp);
            				}
            				sprintf(tmp,"%i",numplay);
            				SetIniKey(hFile,serialstring,"numplay",tmp);
            				SetIniKey(hFile,serialstring,"order",order);
            				free(order);

                			CloseIniFile(hFile);
                			*/
                			ListBoxDeleteAll(hPlaylist,FALSE);
                			FillPlaylist(hPlaylist);
                			int track=getCurrentTrack(wCDPlayerID);
            				int index=ListBoxGetIndex(hPlaylist,track);
                    		ListBoxGetText(hPlaylist,index,text);
                   	 		SetStaticText(hTrack,text);
                    		//endTrack=TRUE;
                			DestroyWindow(hwnd);
                		}
                		break;

            		}  // switch
                break; // BN_CLICKED





                case LBN_SELCHANGE:
                {
                	int sel=SendDlgItemMessage(hwnd,IDL_SONGLIST,LB_GETCURSEL,0,0);
            		char text[100];
            		SendDlgItemMessage(hwnd,IDL_SONGLIST,LB_GETTEXT,(WPARAM)sel,(LPARAM)&text);
                    char *start= strstr(text," ");
                    SetDlgItemText(hwnd,IDE_SONGMANE,start+1);
                 }
                 break;
            }  // switch

            switch(wParam) {
            	case  IDCANCEL: // escape key close dialog
                	DestroyWindow(hwnd);
                break;
            }

         return TRUE; // WM_COMMAND


         case WM_CLOSE:
         	DestroyWindow(hwnd);
         return TRUE;




    default:
            return FALSE;
    }
}



BOOL CALLBACK ToolDlgProc(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam)
{
    // playlist dialog procedure
    switch(Message)
    {

    	case WM_INITDIALOG:
        {

        	RECT rect;
            GetWindowRect(GetParent(hwnd),&rect);



            HANDLE hFile=OpenIniFile(appIniFile);
            
            // set position and size of playlist dialog
            char tmp1[10];
            char tmp2[10];
            char tmp3[10];
            char tmp4[10];
            int x,y,w,h;

            int maxWidth=GetSystemMetrics(SM_CXFULLSCREEN);
            int maxHeight=GetSystemMetrics(SM_CYFULLSCREEN);

            int minWidth=max(pl_cdt[TOPLEFT].bdt.width+
                        	pl_cdt[TOPMIDDLE].bdt.width+
                            pl_cdt[TOPRIGHT].bdt.width,
                            pl_cdt[BOTTOMLEFT].bdt.width+
                            pl_cdt[BOTTOMRIGHT].bdt.width );

            int minHeight=pl_cdt[TOPMIDDLE].bdt.height+
                            pl_cdt[BOTTOMRIGHT].bdt.height+
                            pl_cdt[PLAYLISTBOX].lbdt.ItemHeight;



            if (GetIniKey(hFile,"[playlist]","x",tmp1) &&
            	GetIniKey(hFile,"[playlist]","y",tmp2)&&
                GetIniKey(hFile,"[playlist]","w",tmp3)&&
                GetIniKey(hFile,"[playlist]","h",tmp4)) {
            	x=atoi(tmp1);
                y=atoi(tmp2);
                w=atoi(tmp3);
                h=atoi(tmp4);


                if (x < 0 || y < 0 || x > maxWidth - 30 ||
       				y > maxHeight - 30) {

            		x=20;
            		y=20;
       			}

                if(w < minWidth || h < minHeight) {
                	w=minWidth;
                    h=minHeight;
                }



            }
            else {


                if(rect.right+minWidth < maxWidth)
                	x=rect.right;
                else
                	x=rect.left-minWidth;


                if(rect.bottom +minHeight < maxHeight)
                    y=rect.bottom;
                else
                	y=rect.top-minHeight;

                w=minWidth;
                h=minHeight;
            }






            CloseIniFile(hFile);

           SetWindowPos(hwnd,NULL,x,y,w,h,SWP_NOZORDER);
           
           //  ********************


            //GetClientRect(hwnd,&rect);

           	 hPlaylist=CreateWindowEx(0,"LISTBOX","",
            WS_CHILD | WS_VISIBLE|LBS_HASSTRINGS|LBS_NOTIFY|LBS_NOINTEGRALHEIGHT,
            10,10,
             1,1,
            hwnd, NULL,
            GetModuleHandle(NULL), NULL);


            hScrollPlaylist=CreateWindowEx(0,"SCROLLBAR","",
            WS_CHILD | WS_VISIBLE|SBS_VERT,
            180,15, 8, 235,
            hwnd, NULL,
            GetModuleHandle(NULL), NULL);

            SetScrollRange(hScrollPlaylist,SB_CTL,0,20,FALSE);


             hClosePlaylist=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE,
            200,0, 20, 20,
            hwnd, (HMENU)IDC_CLOSEPLAYLIST,
            GetModuleHandle(NULL), NULL);


              hEditPlaylist=CreateWindowEx(0,"BUTTON","",
            WS_CHILD | WS_VISIBLE,
            190,75, 20, 20,
            hwnd, (HMENU)IDC_EDITPLAYLIST,
            GetModuleHandle(NULL), NULL);



            hSongUp=CreateWindowEx(0,"BUTTON","Up",
            WS_CHILD | WS_VISIBLE,
            190,100, 20, 20,
            hwnd, (HMENU)IDC_SONGUP,
            GetModuleHandle(NULL), NULL);



            hSongDown=CreateWindowEx(0,"BUTTON","Down",
            WS_CHILD | WS_VISIBLE,
            190,130, 20, 20,
            hwnd, (HMENU)IDC_SONGDOWN,
            GetModuleHandle(NULL), NULL);



            hAdd=CreateWindowEx(0,"BUTTON","Add",
            WS_CHILD | WS_VISIBLE,
            190,160, 20, 20,
            hwnd, (HMENU)IDC_ADDSONG,
            GetModuleHandle(NULL), NULL);



            hDelete=CreateWindowEx(0,"BUTTON","Dele",
            WS_CHILD | WS_VISIBLE,
            0,0, 20, 20,
            hwnd, (HMENU)IDC_DELETESONG,
            GetModuleHandle(NULL), NULL);

            InitializePlaylistWindow(); // subclassing controls

            UpdatePlaylistDialog(hwnd); // set position and size of controls
           

         }
         return FALSE;
         
        

         case WM_ACTIVATE:
         {
            
            
           if(LOWORD(wParam)==WA_ACTIVE) 
                if(IsWindowVisible(hwnd))
                    ShowWindow(hMain,SW_SHOWNA); // reactivate main window
   
          // update titlebar
         	RECT rc;
         	GetClientRect(hwnd,&rc);
            rc.bottom= pl_cdt[TOPMIDDLE].bdt.height;
            if(LOWORD(wParam)==WA_INACTIVE)
              	pactive=FALSE;
              else
              	pactive=TRUE;
            InvalidateRect(hwnd,&rc,FALSE);
            
          }
         return 0;

         

         case WM_SIZE:
         {
            // update dialog on resize
			UpdatePlaylistDialog(hwnd);
         }
         return 0;

         
         case WM_PAINT:
         {

         	PAINTSTRUCT ps;
    		HDC hdc;
        	hdc = BeginPaint(hwnd, &ps);
            PaintPlaylistDialog(hdc,hwnd);

            EndPaint(hwnd, &ps);
          }
         return 1;



         case WM_SHOWWINDOW:
            // set check state of button in main window
                     showPlaylist=(BOOL)wParam;
                     if(showPlaylist)
                     	SetButtonCheckState(hShowPlaylist,1,TRUE);
                     else
                     	SetButtonCheckState(hShowPlaylist,0,TRUE);
         return 0;
         
         
         case CM_LISTBOX_NOTIFY: // when contents of listbox is changed ( custom message)
            // set range of listbox scrollbar
            ListBoxUpdateScroll(hPlaylist,hScrollPlaylist);
            
        break;


        case WM_VSCROLL:

            switch(LOWORD(wParam))
			{
                case SB_THUMBTRACK:
                 {

                    // scroll listbox 
                  SetScrollPos((HWND)lParam,SB_CTL,HIWORD(wParam),FALSE);
                  int pos= GetScrollPos((HWND)lParam,SB_CTL);
                  SendMessage(hPlaylist,LB_SETTOPINDEX,(WPARAM)pos,0);
                   InvalidateRect(hPlaylist,NULL,FALSE);

                  }

                  break;

                 case SB_THUMBPOSITION:
                       SetScrollPos((HWND)lParam,SB_CTL,HIWORD(wParam),FALSE);
                 break;
			}

        break;

        case WM_LBUTTONDOWN:
        {
        	RECT rect;
            GetClientRect(hwnd,&rect);

        //*******WINDOW MOVE SUPPORT

              move.x= LOWORD(lParam);
              move.y= HIWORD(lParam);

              resize.x=rect.right-LOWORD(lParam);
              resize.y=rect.bottom- HIWORD(lParam);


               RECT resize_rect;

                SetCapture(hwnd);
                
                	resize_rect.left=rect.right-15; // right bottom corner
                    resize_rect.top=rect.bottom-15; // for resizing window
                    resize_rect.right=rect.right;
                    resize_rect.bottom=rect.bottom;
                	if (PtInRect(&resize_rect,move)) {
                		action=RESIZE;
                        //SetCapture(hwnd);
                    }
                    else action=MOVE;
                //}

         }
        //***************************

        return TRUE;



        case WM_MOUSEMOVE:
        	switch(wParam)
            {
                case MK_LBUTTON:
                //******MOVE WINDOW********************


                switch(action) {

                	case MOVE:
                    {
                    	POINT pt;
                        RECT rect;
                        RECT rect1;
                        //RECT rect2;
                       // GetWindowRect
                        GetWindowRect(hwnd,&rect1);
                        GetWindowRect(hMain,&rect);
						GetCursorPos(&pt);
                        int x,y;
                        x=pt.x-move.x;
                        y=pt.y-move.y;


                       if(snapWindow) {
                        	if (rect1.top < rect.bottom && rect1.bottom > rect.top) {
                        		if(abs(x-rect.right) < snapPixel)
                        			x=rect.right;
                            	else
                            		if(abs(x+(rect1.right-rect1.left)-rect.left) < snapPixel)
										x=rect.left-(rect1.right-rect1.left);
                        		}

                        	if (rect1.left < rect.right && rect1.right> rect.left) {
                        		if(abs(y-rect.bottom) < snapPixel)
                        			y=rect.bottom;
                         		else
                            		if(abs(y+(rect1.bottom-rect1.top)-rect.top) < snapPixel)
										y=rect.top-(rect1.bottom-rect1.top);
                        	}

                       }

                       SetWindowPos(hwnd,NULL,x,
                    						y,
                                            0,
                                            0,
                    			SWP_NOSIZE|SWP_NOZORDER);

                    }
                    break;

                    case RESIZE:
                    {
                    	POINT pt;
						GetCursorPos(&pt);
                    	RECT rect;
                        GetWindowRect(hwnd,&rect);

                        MapWindowPoints(NULL,hwnd,&pt,1);
                         
                        int x=pt.x+resize.y;
                        int y=pt.y+resize.y;
                        int minWidth=max(pl_cdt[TOPLEFT].bdt.width+
                        	pl_cdt[TOPMIDDLE].bdt.width+
                            pl_cdt[TOPRIGHT].bdt.width,
                            pl_cdt[BOTTOMLEFT].bdt.width+
                            pl_cdt[BOTTOMRIGHT].bdt.width );

                        int minHeight=pl_cdt[TOPMIDDLE].bdt.height+
                            pl_cdt[BOTTOMRIGHT].bdt.height+
                            pl_cdt[PLAYLISTBOX].lbdt.ItemHeight;
                        
                        if (x < minWidth )
                        	x=minWidth; // minimal width

                        if( y < minHeight)
                        	y=minHeight; // minimal height
                    	 SetWindowPos(hwnd,NULL,0,
                    						0,
                                             x,
                                            y,
                    		   	SWP_NOMOVE|SWP_NOZORDER);
                   
                    }
                    break;
                }
        //***********************************************

        	}
        return TRUE;

         case WM_LBUTTONUP:
        	if (action==MOVE || action==RESIZE)
              ReleaseCapture();
              action=0;
        return TRUE;


        case WM_COMMAND:
            switch(LOWORD(wParam))
            {


            	case IDC_SONGUP:
                {
                    // move song in playlist
                	int sel= SendMessage(hPlaylist,LB_GETCURSEL,0,0);
                    if ((sel==LB_ERR) || (sel==0)) // if not first row
                    	return TRUE;
                    char text[100];
                    SendMessage(hPlaylist,LB_GETTEXT,
                    	(WPARAM)sel,(LPARAM)&text);
                    WORD data=ListBoxGetData(hPlaylist,sel);
                    ListBoxDeleteString(hPlaylist,sel,TRUE);
					ListBoxInsertString(hPlaylist,text,sel-1,data,TRUE);
                    ListBoxSelectItem(hPlaylist,sel-1,TRUE);
                    int index=ListBoxGetIndex(hPlaylist,getCurrentTrack(wCDPlayerID));
	            	ListBoxSetActive(hPlaylist,index,TRUE);

                }
                break;

                case IDC_SONGDOWN:
                {
                	int sel= SendMessage(hPlaylist,LB_GETCURSEL,0,0);
                    int max= SendMessage(hPlaylist,LB_GETCOUNT,0,0);
                    if ((sel==LB_ERR) || (sel==max-1)) // if not last row
                    	return TRUE;
                    char text[100];
                    SendMessage(hPlaylist,LB_GETTEXT,
                    	(WPARAM)sel,(LPARAM)&text);
                    WORD data=ListBoxGetData(hPlaylist,sel);
                    ListBoxDeleteString(hPlaylist,sel,TRUE);
					ListBoxInsertString(hPlaylist,text,sel+1,data,TRUE);
                    ListBoxSelectItem(hPlaylist,sel+1,TRUE);
                    int index=ListBoxGetIndex(hPlaylist,getCurrentTrack(wCDPlayerID));
	            	ListBoxSetActive(hPlaylist,index,TRUE);

                }

                break;

                case IDC_ADDSONG:
                    // show or close add song dialog
                	if(!IsWindow(hAddSong))
                		hAddSong=CreateDialog(GetModuleHandle(NULL),
                     	MAKEINTRESOURCE(PLAYLIST_ADD_DIALOG),hMain,ToolDlgAdd );
                    else
                    	DestroyWindow(hAddSong);
                break;

                case IDC_DELETESONG:
                {
                     int sel= SendMessage(hPlaylist,LB_GETCURSEL,0,0);
                     if (sel==LB_ERR)
                    	return TRUE;
                     ListBoxDeleteString(hPlaylist,sel,TRUE);
                }

                break;


                case IDC_EDITPLAYLIST:
                    // show or close edit playlist dialog
                    if(!IsWindow(hEditSong))
                		hEditSong = CreateDialog(GetModuleHandle(NULL),
                     	MAKEINTRESOURCE(PLAYLIST_EDIT_DIALOG),hMain, ToolDlgEdit);
                    else
                    	DestroyWindow(hEditSong);
                break;

                case IDC_CLOSEPLAYLIST:
            		ShowWindow(hwnd,SW_HIDE);
            	break;

            }



            switch (HIWORD(wParam))
            {

             	case LBN_DBLCLK:
                {
                    // start playing selected song
                	int index=ListBoxGetCurSel(hPlaylist);
                    int track=ListBoxGetData(hPlaylist,index);
                    seekCD(wCDPlayerID,track,0,0);
                	playCD(wCDPlayerID);
                }
                break;

                case LBN_SELCHANGE:
                {
                    // update scrollbar
                     int start=SendMessage(hPlaylist,LB_GETTOPINDEX,0,0);
                     SetScrollPos(hScrollPlaylist,SB_CTL,start,FALSE);
                     InvalidateRect(hScrollPlaylist,NULL,FALSE);
                 }
                break;
            }

        break;

        case WM_KEYDOWN:
             switch(wParam)
             {
              	case VK_DELETE:
                {
                	int sel= SendMessage(hPlaylist,LB_GETCURSEL,0,0);
                     if (sel==LB_ERR)
                    	return TRUE;
                     ListBoxDeleteString(hPlaylist,sel,TRUE);
                     ListBoxSelectItem(hPlaylist,sel,TRUE);

                }
                break;
                
                

             }
        break;

        case WM_DESTROY:
        {



            char tmp[10];
            RECT rect;

             HANDLE hFile=OpenIniFile(appIniFile);
            GetWindowRect(hPlayListDlg,&rect);
    		sprintf(tmp,"%i",rect.left);
    		SetIniKey(hFile,"[playlist]","x",tmp);
    		sprintf(tmp,"%i",rect.top);
    		SetIniKey(hFile,"[playlist]","y",tmp);
    		sprintf(tmp,"%i",rect.right-rect.left);
    		SetIniKey(hFile,"[playlist]","w",tmp);
    		sprintf(tmp,"%i",rect.bottom-rect.top);
    		SetIniKey(hFile,"[playlist]","h",tmp);
            CloseIniFile(hFile);
            
            SaveCustomPlaylist();
/*
            // save custom playlist
        	hFile=OpenIniFile(playlistIniFile);
        	sprintf(tmp,"%i",numOfTracks);
        	SetIniKey(hFile,serialstring,"numtracks",tmp);
        	int numplay=SendMessage(hPlaylist,LB_GETCOUNT,0,0);

            if(numplay==0) {
            	SetIniKey(hFile,serialstring,"numplay","");
                CloseIniFile(hFile);
                return TRUE;
            }

            char *order=(char *) malloc(100);
            order[0]=0;


            for(int i=0;i<numplay;i++) {
            	WORD data=ListBoxGetData(hPlaylist,i);
                sprintf(tmp,"%i ",data-1);
                strcat(order,tmp);
            }
            sprintf(tmp,"%i",numplay);
            SetIniKey(hFile,serialstring,"numplay",tmp);
            SetIniKey(hFile,serialstring,"order",order);
            free(order);
            CloseIniFile(hFile);
*/

        }
        return 0;


        default:
            return FALSE;
    }
    return TRUE;
}



int getCurrentPosition(MCIDEVICEID wDeviceID)
{
	MCI_STATUS_PARMS mciStatus;
    mciStatus.dwItem=MCI_STATUS_POSITION;
   	mciSendCommand(wDeviceID,MCI_STATUS,MCI_WAIT|MCI_STATUS_ITEM,
 		(DWORD) (LPMCI_STATUS_PARMS) &mciStatus);

    return  MCI_TMSF_SECOND(mciStatus.dwReturn)+
    		MCI_TMSF_MINUTE(mciStatus.dwReturn)*60;


}

BOOL CDTimerFunction(HWND hwnd)
{
    // main timer function
    if(!wCDPlayerID) // not open MCI
        if(IsWindowVisible(hwnd)) // wait main window visibility
            if (!openCD(hwnd,&wCDPlayerID,drive)) { // open MCI
                char tmp[81];
                LoadString(g_hinst,DRIVEINUSE,tmp,80); // can't open MCI
                SetStaticText(hTrack,tmp);
                return FALSE;
            }

    MCI_STATUS_PARMS mciStatus;
    mciStatus.dwItem=MCI_STATUS_MODE;
    mciSendCommand(wCDPlayerID,MCI_STATUS,MCI_STATUS_ITEM|MCI_WAIT,
    	(DWORD) (LPMCI_STATUS_PARMS) &mciStatus);
	
	
    //watch MCI status
    
    switch (mciStatus.dwReturn) {
     	case MCI_MODE_OPEN: 
        {
        	if(CDIsLoaded) { // if CD was loaded 
        		SaveCustomPlaylist();
                if(exitOnRemove) { // if this option is set
        			KillTimer(hwnd,IDT_CD_TIMER);
        			DestroyWindow(hwnd); // close application
            		return 0;
                }
            	ListBoxDeleteAll(hPlaylist,TRUE); // clear playlist
        	}
    		CDIsLoaded=FALSE; // CD is not loaded, timer will try load again

            if (!blockpos) { // can timer write to static controls ?
            	char tmp[81];
                LoadString(g_hinst,NOTLOADED,tmp,80);
        		SetStaticText(hTrack,tmp);
        		SetStaticText(hAlbum,"");
        		SetStaticText(hArtist,"");
        		SetStaticText(hPlayTime,"");
        		SetStaticText(hTrackLength,"");
        		SetScrollPos(hPosition,SB_CTL,0,FALSE);
        		InvalidateRect(hPosition,NULL,FALSE);
        		
            }

        	oldtrack=0;
            SetStaticText(hStatus,"EJECT");


    	}
        break;

        case MCI_MODE_STOP:
        {
		
        	if(!CDIsLoaded) { // first load
                if(!LoadTracks(FALSE)) // loads cd tracks and fill playlist 
                        return FALSE;

            }
            else { // CD is loaded

            	if(!blockpos) { // not pause or blocked
                	char tmp1[100];

                	MCI_STATUS_PARMS mciPlayStatus;
    				mciPlayStatus.dwItem=MCI_STATUS_POSITION;
   					mciSendCommand(wCDPlayerID,MCI_STATUS,MCI_STATUS_ITEM|MCI_WAIT,
 						(DWORD) (LPMCI_STATUS_PARMS) &mciPlayStatus);

    				int sec=MCI_TMSF_SECOND(mciPlayStatus.dwReturn);
    				int min=MCI_TMSF_MINUTE(mciPlayStatus.dwReturn);
            		int track=MCI_TMSF_TRACK(mciPlayStatus.dwReturn);

                    if(!elapsedTime) { // show elapsed/remaining time
                    	int pos=getCDTrackLength(wCDPlayerID,track)-(min*60+sec);
                    	wsprintf(tmp1,"%02i:%02i",pos/60,pos%60);
                    }
                    else
                    	wsprintf(tmp1,"%02i:%02i",min,sec);
                    	
                    // display playtime and status
            	   	SetStaticText(hPlayTime,tmp1);
        	   	   if(pause)
            	   	   SetStaticText(hStatus,"PAUSE");
        	   	   else
                	   SetStaticText(hStatus,"STOP");
                	   
                    SetScrollPos(hPosition,SB_CTL,min*60+sec,FALSE);
                    InvalidateRect(hPosition,NULL,FALSE);

                    if (track != oldtrack) { // track if finished

                	    // set display text and seekbar range
                        tracklength=getCDTrackLength(wCDPlayerID,track);
                        // display track length
                    	wsprintf(tmp1,"%02i:%02i",tracklength/60,tracklength%60);
                    	SetStaticText(hTrackLength,tmp1);
                    	// display track name
                    	int index=ListBoxGetIndex(hPlaylist,track);
                    	ListBoxGetText(hPlaylist,index,tmp1);
                   	 	SetStaticText(hTrack,tmp1);
    
                        // set seeking bar range
                        SCROLLINFO sinfo;
    					sinfo.cbSize=sizeof(sinfo);
    					sinfo.fMask=SIF_RANGE;
        				sinfo.nMin=0;
        				sinfo.nMax=tracklength;
        				SetScrollInfo(hPosition,SB_CTL,&sinfo,FALSE);
    
            			InvalidateRect(hPosition,NULL,FALSE);
                        oldtrack=track;
     
                    }
            	} 	
        	}
        }
        break;

        case MCI_MODE_PLAY:
        {
        	if(!CDIsLoaded) // first load
            	if(!LoadTracks(TRUE))
                	return FALSE;
                	

			MCI_STATUS_PARMS mciPlayStatus;
			mciPlayStatus.dwItem=MCI_STATUS_POSITION;
   			mciSendCommand(wCDPlayerID,MCI_STATUS,MCI_STATUS_ITEM|MCI_WAIT,
 					(DWORD) (LPMCI_STATUS_PARMS) &mciPlayStatus);

			int sec=MCI_TMSF_SECOND(mciPlayStatus.dwReturn);
			int min=MCI_TMSF_MINUTE(mciPlayStatus.dwReturn);
        	int track=MCI_TMSF_TRACK(mciPlayStatus.dwReturn);
            	
            	
            if (introPlay)
           		if ((min*60+sec) >= introEnd)
           			track=0;
            	   
            int index;
            char tmp1[100];
               
            if (track != oldtrack) { // track if finished
            	if(endTrack) {
               		// find next track in playlist
              		index=ListBoxGetIndex(hPlaylist,oldtrack); // position of previous
        			if ( index < ListBoxGetCount(hPlaylist)-1 ) { // not last trask on playlist
            			index++; // next track in playlist
       	       			int newtrack=ListBoxGetData(hPlaylist,index);
              	   		if(newtrack != track) { // not continous track
                	   		seekCD(wCDPlayerID,newtrack,0,0);
                  	   		playCD(wCDPlayerID);
                    	   track=newtrack;
                  	   	}
                	}
                	else { // seek to first track in playlist
    
                    	track=ListBoxGetData(hPlaylist,0);
                        seekCD(wCDPlayerID,track,0,0);
                        if (repeat) // start play from begining of playlist
                    		playCD(wCDPlayerID);
    
                	}
            	}

            	tracklength=getCDTrackLength(wCDPlayerID,track);
	            // set new seeking bar range
	            SCROLLINFO sinfo;
				sinfo.cbSize=sizeof(sinfo);
				sinfo.fMask=SIF_RANGE;
				sinfo.nMin=0;
				sinfo.nMax=tracklength;
				SetScrollInfo(hPosition,SB_CTL,&sinfo,FALSE);
	
	            // display new track length
	        	wsprintf(tmp1,"%02i:%02i",tracklength/60,tracklength%60);
	        	SetStaticText(hTrackLength,tmp1);
	            // display new track name
	        	index=ListBoxGetIndex(hPlaylist,track);
	        	ListBoxGetText(hPlaylist,index,tmp1);
	        	SetStaticText(hTrack,tmp1);
	            ListBoxSetActive(hPlaylist,index,TRUE);
	        	oldtrack=track;
	        	//endTrack=TRUE;
                
            }
                 
         	if(!blockpos) { // not blocked
                SetStaticText(hStatus,"PLAY");
             	// scroll seekingbar
                SetScrollPos(hPosition,SB_CTL,sec+min*60,FALSE);
        		InvalidateRect(hPosition,NULL,FALSE);

                if(!elapsedTime) { //show elapsed/remaining time
                	int pos=tracklength-(min*60+sec);
                	wsprintf(tmp1,"%02i:%02i",pos/60,pos%60);
                }
                else
					wsprintf(tmp1,"%02i:%02i",min,sec);

        		SetStaticText(hPlayTime,tmp1);
    		}
                    

            endTrack=TRUE;
        }
        break;
    }

    // scroll display text
    ScrollStaticText(hTrack);
    ScrollStaticText(hArtist);
    ScrollStaticText(hAlbum);

    return TRUE;
}





BOOL FillPlaylist (HWND hwnd)
{
    // fils playlist 
	if(!CDIsLoaded)
    	return FALSE;
    
	HANDLE hFile=OpenIniFile(playlistIniFile);
    char text[200];
    char tmp1[200];
    char tmp2[200];
    char key[50];
    char *str=text;
    char *end;
    

    if(GetIniKey(hFile,serialstring,"numplay",text)) { // there is custom playlist
    	int numplay=atoi(text);
        if(GetIniKey(hFile,serialstring,"order",text)) {
        	for(int i=0;i<numplay;i++) {
            	end=strstr(str," ");
                if(end==NULL) {
           			CloseIniFile(hFile);
                	return FALSE;
                }

            	strncpy(key,str,end-str); // read order list
                key[end-str]=0;

                if ( ! GetIniKey(hFile,serialstring,key,tmp1))
                 	sprintf(tmp2,"%i. Track %i",atoi(key)+1,atoi(key)+1);

                else
                    sprintf(tmp2,"%i. %s",atoi(key)+1,tmp1);
                
            	ListBoxAddString(hwnd,tmp2,tracks_array[atoi(key)],TRUE);

               str=end+1;

            }


           	CloseIniFile(hFile);
          	return TRUE;
        }
    }

    // no custom playlist
    for(int i=0;i<numOfTracks;i++) {
    	sprintf(key,"%i",i);
        if(!GetIniKey(hFile,serialstring,key,text))
    		sprintf(tmp1,"%i. Track %i",i+1,i+1);
		else
		  sprintf(tmp1,"%i. %s",i+1,text);
    		
       ListBoxAddString(hwnd,tmp1,tracks_array[i],TRUE);
    }
	CloseIniFile(hFile);
   return TRUE;
}



BOOL IsPlay(MCIDEVICEID wDeviceID)
{

	MCI_STATUS_PARMS mciStatus;
    mciStatus.dwItem=MCI_STATUS_MODE;
    mciSendCommand(wDeviceID,MCI_STATUS,MCI_WAIT|MCI_STATUS_ITEM,
    	(DWORD) (LPMCI_STATUS_PARMS) &mciStatus);

    if (mciStatus.dwReturn==MCI_MODE_PLAY)
    	return TRUE;
    else
    	return FALSE;

}



BOOL CALLBACK ToolDlgAdd(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam)
{
    // add song dialog box procedure
	 switch(Message)
    {

    	case WM_INITDIALOG:
        {
    		if(!CDIsLoaded)
				return TRUE;
				
        	char tmp1[100];
            char text[100];
            HANDLE hFile=OpenIniFile(playlistIniFile);

            for (int i=0;i< numOfTracks;i++) {
                sprintf(tmp1,"%i",i);
                if(!GetIniKey(hFile,serialstring,tmp1,text))
                    sprintf(tmp1,"%i. Track %i",i+1,i+1);
                else
                    sprintf(tmp1,"%i. %s",i+1,text);

               SendDlgItemMessage(hwnd,IDL_ADD_BOX,LB_ADDSTRING,0,(LPARAM) tmp1);

             }

            CloseIniFile(hFile);
         }

        return TRUE;


        case WM_COMMAND:

        	 switch (HIWORD(wParam))
            {
            	case LBN_DBLCLK:
                {
                // add song to playlist
                	int sel= SendDlgItemMessage(hwnd,IDL_ADD_BOX,LB_GETCURSEL,0,0);
                    if (sel==LB_ERR)
                    	return TRUE;
                    char text[100];
                    SendDlgItemMessage(hwnd,IDL_ADD_BOX,LB_GETTEXT,(WPARAM)sel,(LPARAM)&text);
                    ListBoxAddString(hPlaylist,text,tracks_array[sel],TRUE);

                }
                break;

            }

         	switch(LOWORD(wParam))
            {
            	case IDB_ADD_SONG:
                {

                	int sel= SendDlgItemMessage(hwnd,IDL_ADD_BOX,LB_GETCURSEL,0,0);
                    if (sel==LB_ERR)
                    	return TRUE;
                    char text[100];
                    SendDlgItemMessage(hwnd,IDL_ADD_BOX,LB_GETTEXT,(WPARAM)sel,(LPARAM)&text);
                    ListBoxAddString(hPlaylist,text,tracks_array[sel],TRUE);

                }
                break;

                case IDB_ADD_ALL:
                {
                    // reset contents of playlist
                    int num= SendDlgItemMessage(hwnd,IDL_ADD_BOX,LB_GETCOUNT,0,0);
                    ListBoxDeleteAll(hPlaylist,TRUE);
                    for (int i=0;i<num;i++) {
                    	char text[100];
                        SendDlgItemMessage(hwnd,IDL_ADD_BOX,LB_GETTEXT,(WPARAM)i,(LPARAM)&text);
                        ListBoxAddString(hPlaylist,text,tracks_array[i],TRUE);

                    }

                }


                break;

                case IDB_CLOSE:
                      DestroyWindow(hwnd);
                break;




            }

            switch (wParam) {
             case IDCANCEL: // ESC key exit
             	DestroyWindow(hwnd);
             return TRUE;
         }


        return TRUE;


      case WM_CLOSE:
                  DestroyWindow(hwnd);
      return TRUE;

     default:
            return FALSE;

    }

}


void SaveSettings(HWND hwnd)
{
   
	RECT rect;
    GetWindowRect(hwnd,&rect);

    HANDLE hFile=OpenIniFile(appIniFile);
    
    char tmp[100];
    sprintf(tmp,"%i",rect.left);
    SetIniKey(hFile,"[position]","x",tmp);
    sprintf(tmp,"%i",rect.top);
    SetIniKey(hFile,"[position]","y",tmp);


    sprintf(tmp,"%i",stopOnExit);
    SetIniKey(hFile,"[options]","stoponexit",tmp);
    sprintf(tmp,"%i",exitOnRemove);
    SetIniKey(hFile,"[options]","exitonremove",tmp);
    sprintf(tmp,"%i",alwaysOnTop);
    SetIniKey(hFile,"[options]","alwaysontop",tmp);

    sprintf(tmp,"%i",repeat);
    SetIniKey(hFile,"[options]","repeat",tmp);
    sprintf(tmp,"%i",playOnStart);
    SetIniKey(hFile,"[options]","playonstart",tmp);
    sprintf(tmp,"%i",introPlay);
    SetIniKey(hFile,"[options]","introplay",tmp);
    sprintf(tmp,"%i",introPlayLen);
    SetIniKey(hFile,"[options]","introplaylen",tmp);
    sprintf(tmp,"%i",randomIntro);
    SetIniKey(hFile,"[options]","randomintro",tmp);
    sprintf(tmp,"%i",showPlaylist);
    SetIniKey(hFile,"[options]","showplaylist",tmp);
    sprintf(tmp,"%i",snapWindow);
    SetIniKey(hFile,"[options]","snapwindow",tmp);
    sprintf(tmp,"%i",snapPixel);
    SetIniKey(hFile,"[options]","snappixel",tmp);
    sprintf(tmp,"%i",showTooltip);
    SetIniKey(hFile,"[options]","showtooltip",tmp);
    sprintf(tmp,"%i",elapsedTime);
    SetIniKey(hFile,"[options]","elapsedtime",tmp);
    sprintf(tmp,"%i",keyShortcuts);
    SetIniKey(hFile,"[options]","keyshortcuts",tmp);
    sprintf(tmp,"%i",autoSwitch);
    SetIniKey(hFile,"[options]","autoswitch",tmp);
    
    SetIniKey(hFile,"[options]","drive",drive);


    SetIniKey(hFile,"[playlist]","playlistinifile",playlistIniFile);

    SetIniKey(hFile,"[visuals]","skin",skinname);
    
    CloseIniFile(hFile);


}

void LoadSettings()
{


 	HANDLE hFile=OpenIniFile(appIniFile);
    if(!GetIniKey(hFile,"[playlist]","playlistinifile",playlistIniFile)) {
    	strcpy(playlistIniFile,"cdplayer.ini");
    	// make your own copy of cdplayer.ini database
    	char windir[MAX_PATH+20];
    	char curdir[MAX_PATH+20];
    	GetCurrentDirectory(MAX_PATH,curdir);
    
     	GetWindowsDirectory(windir,MAX_PATH);
     	strcat(windir,"\\cdplayer.ini");
     	strcat(curdir,"\\cdplayer.ini");
     	CopyFile(windir,curdir,TRUE);
    }
    
    char tmp1[100];
    char tmp2[100];
    
    
    


    if(GetIniKey(hFile,"[options]","stoponexit",tmp1))
    	stopOnExit=atoi(tmp1);
    if(GetIniKey(hFile,"[options]","exitonremove",tmp1))
    	exitOnRemove= atoi(tmp1);
    if(GetIniKey(hFile,"[options]","alwaysontop",tmp1))
    	alwaysOnTop= atoi(tmp1);
    if(GetIniKey(hFile,"[options]","playonstart",tmp1))
    	playOnStart= atoi(tmp1);

     startPlay=playOnStart;

    if(GetIniKey(hFile,"[options]","repeat",tmp1))
    	repeat= atoi(tmp1);
    if(GetIniKey(hFile,"[options]","introplay",tmp1))
    	introPlay= atoi(tmp1);
    if(GetIniKey(hFile,"[options]","introplaylen",tmp1))
    	introPlayLen= atoi(tmp1);
     if(GetIniKey(hFile,"[options]","randomintro",tmp1))
    	randomIntro= atoi(tmp1);
     if(GetIniKey(hFile,"[options]","showplaylist",tmp1))
    	showPlaylist= atoi(tmp1);
      if(GetIniKey(hFile,"[options]","snapwindow",tmp1))
    	snapWindow= atoi(tmp1);
     if(GetIniKey(hFile,"[options]","snappixel",tmp1))
    	snapPixel= atoi(tmp1);
     if(GetIniKey(hFile,"[options]","showtooltip",tmp1))
    	showTooltip= atoi(tmp1);
     if(GetIniKey(hFile,"[options]","elapsedtime",tmp1))
    	elapsedTime= atoi(tmp1);
     if(GetIniKey(hFile,"[options]","keyshortcuts",tmp1))
    	keyShortcuts= atoi(tmp1);
	if(GetIniKey(hFile,"[options]","autoswitch",tmp1))
    	autoSwitch= atoi(tmp1);
    	
	if(!GetIniKey(hFile,"[options]","drive",drive)) {
	   FindCDROMDrives(tmp1);
	   sprintf(drive,"%c:",tmp1[0]); // take first CDROM drive
	
	}
	else {
	   sprintf(tmp2,"%s:\\",drive);
	   if(GetDriveType(tmp2) != DRIVE_CDROM) { // invalid drive (not CDROM)
	       FindCDROMDrives(tmp1);
	        sprintf(drive,"%c:",tmp1[0]); // take first CDROM drive
     }
	
	}
    	

     if(GetIniKey(hFile,"[position]","x",tmp1) &&
    	GetIniKey(hFile,"[position]","y",tmp2)) {

       	main_xpos=atoi(tmp1);
       	main_ypos=atoi(tmp2);

       	int maxWidth=GetSystemMetrics(SM_CXFULLSCREEN);
       	int maxHeight=GetSystemMetrics(SM_CYFULLSCREEN);

       	if (main_xpos < 0 || main_ypos < 0 || main_xpos > maxWidth - 30 ||
       		main_ypos > maxHeight - 30) {

            main_xpos=50;
            main_ypos=50;
       	}
     }




     if(!GetIniKey(hFile,"[visuals]","skin",skinname)) { // load skin name
     	strcpy(skinname,"BASIC"); // internal skin if no skim set in settings
        //alert("BASIC BITMAP");
     }

    CloseIniFile(hFile);
}



BOOL CALLBACK ToolDlgOptions(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam)
{
    // options dialog procedure
	 switch(Message)
    {
    	case WM_INITDIALOG:
        {
        	int fCheck;
        	if(stopOnExit)
            	fCheck=1;
            else fCheck=0;
            SendDlgItemMessage(hwnd,ID_STOPONEXIT,
                    	 BM_SETCHECK ,fCheck,0);

            if(exitOnRemove)
            	fCheck=1;
            else fCheck=0;
            SendDlgItemMessage(hwnd,ID_EXITONREMOVE,
                    	 BM_SETCHECK ,fCheck,0);

            if(alwaysOnTop)
            	fCheck=1;
            else fCheck=0;
            SendDlgItemMessage(hwnd,ID_ONTOP,
                    	 BM_SETCHECK ,fCheck,0);

             if(repeat)
            	fCheck=1;
            else fCheck=0;
            SendDlgItemMessage(hwnd,ID_REPEATPLAYLIST,
                    	 BM_SETCHECK ,fCheck,0);

             if(playOnStart)
            	fCheck=1;
            else fCheck=0;
            SendDlgItemMessage(hwnd,ID_PLAYONSTART,
                    	 BM_SETCHECK ,fCheck,0);

            if(elapsedTime)
            	fCheck=1;
            else fCheck=0;
            SendDlgItemMessage(hwnd,ID_ELAPSED,
                    	 BM_SETCHECK ,fCheck,0);

            if(introPlay)
            	fCheck=1;
            else fCheck=0;
            SendDlgItemMessage(hwnd,ID_INTROPLAY,
                    	 BM_SETCHECK ,fCheck,0);

             if(randomIntro)
            	fCheck=1;
            else fCheck=0;
            SendDlgItemMessage(hwnd,ID_INTRORANDOM,
                    	 BM_SETCHECK ,fCheck,0);


            SendDlgItemMessage(hwnd,ID_INTROLEN,
                    	 CB_ADDSTRING ,0,(LPARAM) "5");
            SendDlgItemMessage(hwnd,ID_INTROLEN,
                    	 CB_ADDSTRING ,0,(LPARAM) "10");
             SendDlgItemMessage(hwnd,ID_INTROLEN,
                    	 CB_ADDSTRING ,0,(LPARAM) "15");
            SendDlgItemMessage(hwnd,ID_INTROLEN,
                    	 CB_ADDSTRING ,0,(LPARAM) "30");
            SendDlgItemMessage(hwnd,ID_INTROLEN,
                    	 CB_ADDSTRING ,0,(LPARAM) "45");
            SendDlgItemMessage(hwnd,ID_INTROLEN,
                    	 CB_ADDSTRING ,0,(LPARAM) "60");
            SendDlgItemMessage(hwnd,ID_INTROLEN,
                    	 CB_ADDSTRING ,0,(LPARAM) "120");
                    	 
                    	 
                    	 
           

            char tmp1[100];
            sprintf(tmp1,"%i",introPlayLen);
            
                    	 
        	 SendDlgItemMessage(hwnd,ID_INTROLEN,
                    	 CB_SELECTSTRING,(WPARAM) -1,(LPARAM) tmp1);
                    	 
                    	 
                    	 
    	    char CDdrives[10];       	 
            FindCDROMDrives(CDdrives);
            for (int i=0;i<strlen(CDdrives);i++) {
                        sprintf(tmp1,"%c:",CDdrives[i]);
                         SendDlgItemMessage(hwnd,ID_DRIVE,
                    	 CB_ADDSTRING ,0,(LPARAM) tmp1);          
            
            }
            
            SendDlgItemMessage(hwnd,ID_DRIVE,
                    	 CB_SELECTSTRING,(WPARAM)-1,(LPARAM) drive);
                    	 
                    	 
    	   if(autoSwitch)
            	fCheck=1;
            else fCheck=0;
            //SendDlgItemMessage(hwnd,ID_AUTOSWITCH,
                    	 //BM_SETCHECK ,fCheck,0);
        	CheckDlgButton(hwnd,ID_AUTOSWITCH,fCheck); 
        	
        	if(strlen(CDdrives) > 1)
                EnableWindow(GetDlgItem(hwnd,ID_AUTOSWITCH),TRUE);
            else
                EnableWindow(GetDlgItem(hwnd,ID_AUTOSWITCH),FALSE); 
                               	 


            if(showTooltip)
            	fCheck=1;
            else fCheck=0;
            SendDlgItemMessage(hwnd,ID_TOOLTIP,
                    	 BM_SETCHECK ,fCheck,0);



            if(snapWindow)
            	fCheck=1;
            else fCheck=0;
            SendDlgItemMessage(hwnd,ID_SNAP,
                    	 BM_SETCHECK ,fCheck,0);

            //sprintf(tmp1,"%i",snapPixel);
            //SetDlgItemText(hwnd,ID_SNAPPIXEL,tmp1);
            SetDlgItemInt(hwnd,ID_SNAPPIXEL,snapPixel,FALSE);

             if(keyShortcuts)
            	fCheck=1;
            else fCheck=0;
            SendDlgItemMessage(hwnd,ID_KEYSHORTCUTS,
                    	 BM_SETCHECK ,fCheck,0);




           char curdir[MAX_PATH];
           char skindir[MAX_PATH];
           char skinpath[MAX_PATH];

           GetCurrentDirectory(MAX_PATH,curdir);
           
           // find skin subfolders

           sprintf(skindir,"%s\\skin\\*",curdir);
            WIN32_FIND_DATA findfile;
            HANDLE hFind;
            hFind=FindFirstFile(skindir,&findfile);

            SendDlgItemMessage(hwnd,ID_SKIN,
                    	 LB_ADDSTRING ,0,(LPARAM) "BASIC");

            if (findfile.dwFileAttributes==FILE_ATTRIBUTE_DIRECTORY)
            	if (lstrlen(findfile.cAlternateFileName)>0)
                	SendDlgItemMessage(hwnd,ID_SKIN,
                    	 LB_ADDSTRING ,0,(LPARAM)findfile.cAlternateFileName);

             while (FindNextFile(hFind,&findfile)) {
             	if (findfile.dwFileAttributes==FILE_ATTRIBUTE_DIRECTORY)
                if (lstrlen(findfile.cAlternateFileName)>0)

             		SendDlgItemMessage(hwnd,ID_SKIN,
                    	 LB_ADDSTRING ,0,(LPARAM)findfile.cAlternateFileName);
             }

              FindClose(hFind);


              	int index=SendDlgItemMessage(hwnd,ID_SKIN,
                    	 LB_FINDSTRINGEXACT  ,(WPARAM)-1,(LPARAM)skinname);
              	SendDlgItemMessage(hwnd,ID_SKIN,
                    	 LB_SETCURSEL ,index,0);

                // display current skin info
                if (strcmp(skinname,"BASIC")==0)
                	SendDlgItemMessage(hwnd,ID_SKININFO,
    					LB_ADDSTRING ,0,(LPARAM)"Internal application skin");
                else {

                	sprintf(skinpath,"%s\\skin\\%s\\Info.ini",curdir,skinname);
                	HANDLE hFile=OpenIniFile(skinpath);
                	LoadSkinInfo(hwnd, hFile);
                	CloseIniFile(hFile);
                }


        }
        return TRUE;



         case WM_COMMAND:
         	switch (LOWORD(wParam)) {
            	case ID_SKIN:
                      switch (HIWORD(wParam)) {
                       	case  LBN_SELCHANGE:
                        {
                        // select skin
                            blocktimer=TRUE;
                      		char curdir[MAX_PATH];
                      		char skinpath[MAX_PATH];
                      		GetCurrentDirectory(MAX_PATH,curdir);

                      		int sel=SendDlgItemMessage(hwnd,ID_SKIN,
                    	 		LB_GETCURSEL,0,0);

                      		SendDlgItemMessage(hwnd,ID_SKIN,
                    	 		LB_GETTEXT,(WPARAM)sel,(LPARAM)skinname);
                      		sprintf(skinpath,"%s\\skin\\%s\\Info.ini",curdir,skinname);

                            // skin info



                            SendDlgItemMessage(hwnd,ID_SKININFO,
                    	 		LB_RESETCONTENT ,0,0);



                      		if(! LoadSkin(hwnd,curdir,skinname)) { // load skin
                                strcpy(skinname,"BASIC");
                                LoadSkin(hwnd,curdir,"BASIC");
                            }

                               // update application to new skin
                                 UpdateMainWindow(hMain);
                                ListBoxDeleteAll(hPlaylist,TRUE);
                                FillPlaylist(hPlaylist);
                                UpdatePlaylistDialog(hPlayListDlg);
                            


                            // display skin info
                            if (strcmp(skinname,"BASIC")==0) {
                				SendDlgItemMessage(hwnd,ID_SKININFO,
    								LB_ADDSTRING ,0,(LPARAM)"Internal application skin");

                                    int index=SendDlgItemMessage(hwnd,ID_SKIN,
                    	 				LB_FINDSTRINGEXACT  ,(WPARAM)-1,(LPARAM)skinname);
              						SendDlgItemMessage(hwnd,ID_SKIN,
                    	 				LB_SETCURSEL ,index,0);
                            }
                            else {
                            	HANDLE hFile=OpenIniFile(skinpath);
                            	LoadSkinInfo(hwnd, hFile);
								CloseIniFile(hFile);
                            }


                        	blocktimer=FALSE;

                    	}
                        break;

                	}
                break;

                 case ID_INTROLEN:
                 	switch (HIWORD(wParam)) {
                       	case  CBN_SELCHANGE:
                        {
                    		int index=SendDlgItemMessage(hwnd,ID_INTROLEN,
                    	 		CB_GETCURSEL,0,0);
                        	char tmp1[10];
                        	SendDlgItemMessage(hwnd,ID_INTROLEN,
                    	 		CB_GETLBTEXT,index,(LPARAM)tmp1);
                        	introPlayLen=atoi(tmp1);
                        }
                        break;
                    }
                 break;
                 
                 case ID_DRIVE:
                    switch (HIWORD(wParam)) {
                    
                    
                       	case  CBN_SELCHANGE:
                        {
                            // change CDROM drive
                            int index=SendDlgItemMessage(hwnd,ID_DRIVE,
                    	 		CB_GETCURSEL,0,0);
                	 		int result=MessageBox(hwnd,"Do you want to change CDROM drive ?",
                	 		    "Change drive ?",MB_APPLMODAL|MB_ICONEXCLAMATION|
                                MB_YESNO);
                            if (result==IDYES) {
                                blocktimer=TRUE;
                               if(wCDPlayerID) {
                                    stopCD(wCDPlayerID);
                                    closeCD(hwnd,&wCDPlayerID);   
                                    
                                }   
                                 
    	                       SendDlgItemMessage(hwnd,ID_DRIVE,
                    	 		        CB_GETLBTEXT,index,(LPARAM)drive);
            	 		    blocktimer=FALSE;
                                 
                            
                            }
                            else
                                 SendDlgItemMessage(hwnd,ID_DRIVE,
                    	               CB_SELECTSTRING,(WPARAM)-1,(LPARAM) drive);
                        
                        
                        }
                        break;
                    }
                 
                 
                 break;
            }



            switch (wParam) {
             case IDCANCEL:
             	EndDialog(hwnd,hOptionsDialog);
             return TRUE;
            }


         	switch (HIWORD(wParam)) {

            	case BN_CLICKED:
                	switch(LOWORD(wParam))
                    {

                        case ID_INTRORANDOM:
                        	 randomIntro= SendDlgItemMessage(hwnd,ID_INTRORANDOM,
                    	 	BM_GETCHECK,0,0);
                        break;

                        case ID_INTROPLAY:
                             introPlay= SendDlgItemMessage(hwnd,ID_INTROPLAY,
                    	 	BM_GETCHECK,0,0);
                        break;

                        case ID_PLAYONSTART:
                              playOnStart= SendDlgItemMessage(hwnd,ID_PLAYONSTART,
                    	 	BM_GETCHECK,0,0);
                        break;

                        case ID_REPEATPLAYLIST:
                              repeat=SendDlgItemMessage(hwnd,ID_REPEATPLAYLIST,
                    	 	BM_GETCHECK,0,0);
                        break;

                        case ID_ELAPSED:
                              elapsedTime=SendDlgItemMessage(hwnd,ID_ELAPSED,
                    	 	BM_GETCHECK,0,0);
                        break;
                        
                        case ID_AUTOSWITCH:
                        	 autoSwitch= SendDlgItemMessage(hwnd,ID_AUTOSWITCH,
                    	 	BM_GETCHECK,0,0);
                        break;


                    	case IDB_OPT_OK:
                        {
                        	snapPixel=GetDlgItemInt(hwnd,ID_SNAPPIXEL,NULL,FALSE);
                			EndDialog(hwnd,hOptionsDialog);
                        }
                		break;

                		case ID_STOPONEXIT:
                			stopOnExit=SendDlgItemMessage(hwnd,ID_STOPONEXIT,
                    	 	BM_GETCHECK,0,0);
                		break;

                        case ID_EXITONREMOVE:
                			exitOnRemove=SendDlgItemMessage(hwnd,ID_EXITONREMOVE,
                    	 	BM_GETCHECK,0,0);
                		break;

                        case ID_SNAP:
                         	snapWindow=SendDlgItemMessage(hwnd,ID_SNAP,
                    	 	BM_GETCHECK,0,0);
                        break;

                        case ID_KEYSHORTCUTS:
                         	keyShortcuts=SendDlgItemMessage(hwnd,ID_KEYSHORTCUTS,
                    	 	BM_GETCHECK,0,0);
                        break;

                        case ID_TOOLTIP:
                        	showTooltip=SendDlgItemMessage(hwnd,ID_TOOLTIP,
                    	 	BM_GETCHECK,0,0);

                        break;

                		case ID_ONTOP:
                			alwaysOnTop=SendDlgItemMessage(hwnd,ID_ONTOP,
                    	 	BM_GETCHECK,0,0);

                    		if(alwaysOnTop)
								SetWindowPos(hMain,HWND_TOPMOST,0,0,0,0,
                        			SWP_NOMOVE|SWP_NOSIZE);
        					else
            					SetWindowPos(hMain,HWND_NOTOPMOST,0,0,0,0,
                        			SWP_NOMOVE|SWP_NOSIZE);

                			break;
                      }

                return TRUE;

            }
         return TRUE;

         case WM_CLOSE:
         	EndDialog(hwnd,hOptionsDialog);
         return TRUE;


    default:
            return FALSE;
    }
}




 int getCurrentTrack(MCIDEVICEID wDeviceID)
{
	MCI_STATUS_PARMS mciStatus;
    mciStatus.dwItem=MCI_STATUS_CURRENT_TRACK ;
   	mciSendCommand(wDeviceID,MCI_STATUS,MCI_WAIT|MCI_STATUS_ITEM,
 		(DWORD) (LPMCI_STATUS_PARMS) &mciStatus);

    return mciStatus.dwReturn;


}



int GetRandomNumber(int max)
{
 	//return (GetTickCount() % max);
    return (GetMessageTime() % max);
}



BOOL WINAPI OnContextMenu(HWND hwnd, int x, int y)
{
    RECT rc;                    // client area of window
    POINT pt = { x, y };        // location of mouse click

    // Get the bounding rectangle of the client area.

    GetClientRect(hwnd, &rc);

    // Convert the mouse position to client coordinates.

    ScreenToClient(hwnd, &pt);

    // If the position is in the client area, display a floating
    // pop-up menu.

    if (PtInRect(&rc, pt)) {

        ClientToScreen(hwnd, &pt);
        DisplayContextMenu(hwnd, pt);
        return TRUE;
    }

    // Return FALSE if no menu is displayed.
 
    return FALSE; 
} 


VOID APIENTRY DisplayContextMenu(HWND hwnd, POINT pt)
{ 
    HMENU hmenu,hSubMenu,hSubMenu1;            // top-level menu
    HMENU hmenuTrackPopup;  // pop-up menu
    UINT uFlags;
    char tmp[81];

      hmenu = CreateMenu();
        hSubMenu = CreatePopupMenu();
        	LoadString(g_hinst,IDM_ABOUT,tmp,80);
            AppendMenu(hSubMenu, MF_STRING, IDM_ABOUT, tmp);
            AppendMenu(hSubMenu, MF_SEPARATOR, 0, NULL);
            LoadString(g_hinst,IDM_SHOWPLAYLIST,tmp,80);
            AppendMenu(hSubMenu, MF_STRING, IDM_SHOWPLAYLIST, tmp);
            AppendMenu(hSubMenu, MF_SEPARATOR, 0, NULL);
            LoadString(g_hinst,IDM_OPTIONS,tmp,80);
            AppendMenu(hSubMenu, MF_STRING, IDM_OPTIONS, tmp);
            AppendMenu(hSubMenu, MF_SEPARATOR, 0, NULL);
            uFlags=MF_STRING;
            if(alwaysOnTop) uFlags=uFlags | MF_CHECKED;
            LoadString(g_hinst,IDM_ALWAYSONTOP,tmp,80);
            AppendMenu(hSubMenu, uFlags, IDM_ALWAYSONTOP, tmp);
            uFlags=MF_STRING;
            if(showTooltip) uFlags=uFlags | MF_CHECKED;
            LoadString(g_hinst,IDM_SHOWTOOLTIP,tmp,80);
            AppendMenu(hSubMenu, uFlags, IDM_SHOWTOOLTIP, tmp);
            uFlags=MF_STRING;
            if(snapWindow) uFlags=uFlags | MF_CHECKED;
            LoadString(g_hinst,IDM_SNAPWINDOWS,tmp,80);
            AppendMenu(hSubMenu, uFlags, IDM_SNAPWINDOWS, tmp);
            uFlags=MF_STRING;
            if(keyShortcuts) uFlags=uFlags | MF_CHECKED;
            LoadString(g_hinst,IDM_KEYSHORTCUTS,tmp,80);
            AppendMenu(hSubMenu, uFlags, IDM_KEYSHORTCUTS, tmp);
            AppendMenu(hSubMenu, MF_SEPARATOR, 0, NULL);
            uFlags=MF_STRING;
            if(elapsedTime) uFlags=uFlags | MF_CHECKED;
            LoadString(g_hinst,IDM_ELAPSEDTIME,tmp,80);
            AppendMenu(hSubMenu, uFlags, IDM_ELAPSEDTIME, tmp);
            uFlags=MF_STRING;
            if(playOnStart) uFlags=uFlags | MF_CHECKED;
            LoadString(g_hinst,IDM_PLAYONSTART,tmp,80);
            AppendMenu(hSubMenu, uFlags, IDM_PLAYONSTART, tmp);
            uFlags=MF_STRING;
            if(exitOnRemove) uFlags=uFlags | MF_CHECKED;
            LoadString(g_hinst,IDM_EXITONREMOVE,tmp,80);
            AppendMenu(hSubMenu, uFlags, IDM_EXITONREMOVE, tmp);
            uFlags=MF_STRING;
            if(stopOnExit) uFlags=uFlags | MF_CHECKED;
            LoadString(g_hinst,IDM_STOPONEXIT,tmp,80);
            AppendMenu(hSubMenu, uFlags, IDM_STOPONEXIT, tmp);
            uFlags=MF_STRING;
            if(repeat) uFlags=uFlags | MF_CHECKED;
            LoadString(g_hinst,IDM_REPEAT,tmp,80);
            AppendMenu(hSubMenu, uFlags, IDM_REPEAT, tmp);
            uFlags=MF_STRING;
            if(introPlay) uFlags=uFlags | MF_CHECKED;
            LoadString(g_hinst,IDM_INTROPLAY,tmp,80);
            AppendMenu(hSubMenu, uFlags, IDM_INTROPLAY, tmp);
            hSubMenu1 = CreatePopupMenu();
            	uFlags=MF_STRING;
            	if(randomIntro) uFlags=uFlags | MF_CHECKED;
                LoadString(g_hinst,IDM_RANDOMSTART,tmp,80);
            	AppendMenu(hSubMenu1, uFlags, IDM_RANDOMSTART, tmp);
            	AppendMenu(hSubMenu1, MF_SEPARATOR, 0, NULL);
                uFlags=MF_STRING;
            	if(introPlayLen==5) uFlags=uFlags | MF_CHECKED;
                AppendMenu(hSubMenu1, uFlags, IDM_INTRO5, "  5 sec");
                uFlags=MF_STRING;
            	if(introPlayLen==10) uFlags=uFlags | MF_CHECKED;
                AppendMenu(hSubMenu1, uFlags, IDM_INTRO10, " 10 sec");
                uFlags=MF_STRING;
            	if(introPlayLen==15) uFlags=uFlags | MF_CHECKED;
                AppendMenu(hSubMenu1, uFlags, IDM_INTRO15, " 15 sec");
                uFlags=MF_STRING;
            	if(introPlayLen==30) uFlags=uFlags | MF_CHECKED;
                AppendMenu(hSubMenu1, uFlags, IDM_INTRO30, " 30 sec");
                uFlags=MF_STRING;
            	if(introPlayLen==45) uFlags=uFlags | MF_CHECKED;
                AppendMenu(hSubMenu1, uFlags, IDM_INTRO45, " 45 sec");
                uFlags=MF_STRING;
            	if(introPlayLen==60) uFlags=uFlags | MF_CHECKED;
                AppendMenu(hSubMenu1, uFlags, IDM_INTRO60, " 60 sec");
                uFlags=MF_STRING;
            	if(introPlayLen==120) uFlags=uFlags | MF_CHECKED;
                AppendMenu(hSubMenu1, uFlags, IDM_INTRO120, "120 sec");
                //uFlags=MF_STRING;
            LoadString(g_hinst,IDM_INTROOPTIONS,tmp,80);
            AppendMenu(hSubMenu, MF_STRING | MF_POPUP, (UINT)hSubMenu1, tmp);
            AppendMenu(hSubMenu, MF_SEPARATOR, 0, NULL);
            LoadString(g_hinst,IDM_EXIT,tmp,80);
            AppendMenu(hSubMenu, MF_STRING, IDM_EXIT, tmp);

        AppendMenu(hmenu, MF_STRING | MF_POPUP, (UINT)hSubMenu, "&File");


    // TrackPopupMenu cannot display the top-level menu, so get
    // the handle of the first pop-up menu. 
 
    hmenuTrackPopup = GetSubMenu(hmenu, 0);
 
    // Display the floating pop-up menu. Track the right mouse 

    // button on the assumption that this function is called 
    // during WM_CONTEXTMENU processing. 
 
    TrackPopupMenu(hmenuTrackPopup,
            TPM_LEFTALIGN | TPM_RIGHTBUTTON, 
            pt.x, pt.y, 0, hwnd, NULL); 
 
    // Destroy the menu.
    DestroyMenu(hSubMenu);
    DestroyMenu(hSubMenu1);
    DestroyMenu(hmenu);
} 






BOOL CALLBACK ToolDlgAbout(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam)
{
    // about dialog procedure
	 switch(Message)
    {

    	case WM_INITDIALOG:
              SetTimer(hwnd,IDT_TIMER1,1,NULL);
        break;

        case WM_TIMER:
           
              cube.xAngle+=7;
    	   		cube.yAngle+=5;
    			cube.zAngle+=3;
              InvalidateRect(hwnd,NULL,FALSE);


        break;


        case WM_PAINT:
        {


        	PAINTSTRUCT ps;
        	HDC hdc=BeginPaint(hwnd,&ps);
            DrawAbout(hwnd,hdc);
        	EndPaint(hwnd,&ps);
        }
        break;

        case WM_LBUTTONDOWN:
            // change background color
        	 //randomize();
             srand((unsigned) GetRandomNumber(100));
             b_red=BYTE(rand() % 255);
             b_green=BYTE(rand() % 255);
             b_blue=BYTE(rand() % 255);
        break;

        case WM_LBUTTONDBLCLK:
            // change brush (solid or pattern)
        	patterndraw= !patterndraw;

        break;


        case WM_RBUTTONDOWN:
        {
            // change cube color
            srand((unsigned) GetRandomNumber(100));
        	for(int i=0;i<cube.numPoly;i++) {
            	cube.polyList[i].red= BYTE(rand() % 255);
             	cube.polyList[i].green= BYTE(rand() % 255);
              	cube.polyList[i].blue=BYTE( rand() % 255);
            }
        }
        break;

        case WM_RBUTTONDBLCLK :
            // change cube border color
             srand((unsigned) GetRandomNumber(100));
             p_red=BYTE(rand() % 255);
             p_green=BYTE(rand() % 255);
             p_blue=BYTE(rand() % 255);
        break;

        case WM_MOUSEMOVE :
        	switch (wParam) {
                // zoom in/out
             	case MK_LBUTTON	:
                if(zoom < 200)
                	zoom++;

                break;

                case MK_RBUTTON	:
                	if(zoom > 30)
                  		zoom--;
                break;


            }
           
        break;

        case WM_COMMAND:

         	switch(LOWORD(wParam))
            {

                case IDB_CLOSE:
                      DestroyWindow(hwnd);
                break;




            }
        return TRUE;



      case WM_CLOSE:
                  DestroyWindow(hwnd);
      return TRUE;

     default:
            return FALSE;

    }

    return TRUE;

}


void DrawAbout(HWND hwnd,HDC hdc)
{
    // draw about dialog

    HDC hdcBuffer=CreateCompatibleDC(hdc);

	RECT rc;
  	GetClientRect(hwnd, &rc);


    HBITMAP hbm=CreateCompatibleBitmap(hdc,rc.right,rc.bottom);
    HBITMAP hbmOld=(HBITMAP)SelectObject(hdcBuffer,hbm);

    SetMapMode(hdcBuffer, MM_ANISOTROPIC);
    SetWindowExtEx(hdcBuffer, 100, 100, NULL);
    SetViewportExtEx(hdcBuffer, rc.right, rc.bottom, NULL);

    SetMapMode(hdc, MM_ANISOTROPIC);
    SetWindowExtEx(hdc, 100, 100, NULL);
    SetViewportExtEx(hdc, rc.right, rc.bottom, NULL);
    
    

    HPEN hPen=CreatePen(PS_SOLID,1,RGB(p_red,p_green,p_blue));
    HPEN oldPen=(HPEN)SelectObject(hdcBuffer,hPen);

    HBRUSH hBrush=CreateSolidBrush(RGB(b_red,b_green,b_blue));
    HBRUSH oldBrush=(HBRUSH)SelectObject(hdcBuffer,hBrush);

    //FillRect(hdcBuffer,&rc,(HBRUSH)GetStockObject(WHITE_BRUSH));
    FillRect(hdcBuffer,&rc,hBrush);


   //rotate the 8 cube vertices
    for(int i=0;i< cube.numVertex; i++) {
      	rotateVertex(&cube.originalVertex[i],&cube.vertexList[i],
		   cube.xAngle,cube.yAngle,cube.zAngle);

      	cube.vertexList[i].x+=cube.x;
      	cube.vertexList[i].y+=cube.y;
      	cube.vertexList[i].z+=cube.z;

      	screenConvertVertex(&cube.vertexList[i],xx,yy,zoom);

    }
    

     for(int i=0;i<cube.numPoly;i++)
      	if(!backfacing(&cube.polyList[i]))
          	drawPolygon(hdcBuffer,&cube.polyList[i],i,patterndraw,pattern);
          	

	//SetBkMode(hdcBuffer,TRANSPARENT);
     SetBkColor(hdcBuffer,RGB(255,255,255));

     SetTextColor(hdcBuffer,RGB(0,0,255));

     TextOut(hdcBuffer,20,70,"Chameleon CD player",19);
     TextOut(hdcBuffer,20,78,"Author: Zoran Cindori",21);
     TextOut(hdcBuffer,20,86,"Email: zcindori@inet.hr",23);
     TextOut(hdcBuffer,20,94,"Web: http://www.inet.hr/~zcindori/",34);


     BitBlt(hdc,0,0,rc.right,rc.bottom,hdcBuffer,0,0,SRCCOPY);


     SelectObject(hdcBuffer,oldBrush);
     SelectObject(hdcBuffer,oldPen);
     SelectObject(hdcBuffer,hbmOld);
     DeleteObject(hBrush);
     DeleteObject(hPen);
     DeleteObject(hbm);
     DeleteDC(hdcBuffer);

}




void UpdatePlaylistDialog(HWND hwnd)
{
    // update position and size of all controls in playlist dialog
    RECT rect,rect1;
    GetClientRect(hwnd,&rect);


    // list box
	SetWindowPos(hPlaylist,NULL,
    			pl_cdt[LEFTBORDER].bdt.width,
                pl_cdt[TOPMIDDLE].bdt.height,
                rect.right-pl_cdt[RIGHTBORDER].bdt.width-
                	pl_cdt[PLAYLISTSCROLLBAR].bdt.width-
                    pl_cdt[LEFTBORDER].bdt.width,
            		rect.bottom-pl_cdt[BOTTOMLEFT].bdt.height-
                    pl_cdt[TOPMIDDLE].bdt.height,
               		SWP_NOZORDER|SWP_NOREDRAW);

    //  scrollbar
    SetWindowPos(hScrollPlaylist,NULL,
    			rect.right-pl_cdt[RIGHTBORDER].bdt.width-
                pl_cdt[PLAYLISTSCROLLBAR].bdt.width,
                pl_cdt[TOPMIDDLE].bdt.height,
                pl_cdt[PLAYLISTSCROLLBAR].bdt.width,
                rect.bottom-pl_cdt[BOTTOMLEFT].bdt.height-
                    pl_cdt[TOPMIDDLE].bdt.height,
               		SWP_NOZORDER|SWP_NOREDRAW);

    // add button

    SetWindowPos(hAdd,NULL,
    			pl_cdt[PLAYLISTADD].bdt.x,
                rect.bottom-pl_cdt[PLAYLISTADD].bdt.y,
                pl_cdt[PLAYLISTADD].bdt.width,
                pl_cdt[PLAYLISTADD].bdt.height,
                SWP_NOZORDER|SWP_NOREDRAW);
    // delete button
    
    SetWindowPos(hDelete,NULL,
    			pl_cdt[PLAYLISTDELETE].bdt.x,
                rect.bottom-pl_cdt[PLAYLISTDELETE].bdt.y,
                pl_cdt[PLAYLISTDELETE].bdt.width,
                pl_cdt[PLAYLISTDELETE].bdt.height,
                SWP_NOZORDER|SWP_NOREDRAW);


    // song up button
    SetWindowPos(hSongUp,NULL,
    			pl_cdt[PLAYLISTSONGUP].bdt.x,
                rect.bottom-pl_cdt[PLAYLISTSONGUP].bdt.y,
                pl_cdt[PLAYLISTSONGUP].bdt.width,
                pl_cdt[PLAYLISTSONGUP].bdt.height,
                SWP_NOZORDER|SWP_NOREDRAW);
    // song down
    SetWindowPos(hSongDown,NULL,
    			pl_cdt[PLAYLISTSONGDOWN].bdt.x,
                rect.bottom-pl_cdt[PLAYLISTSONGDOWN].bdt.y,
                pl_cdt[PLAYLISTSONGDOWN].bdt.width,
                pl_cdt[PLAYLISTSONGDOWN].bdt.height,
                SWP_NOZORDER|SWP_NOREDRAW);
    // edit playlist
    SetWindowPos(hEditPlaylist,NULL,
    			pl_cdt[PLAYLISTEDIT].bdt.x,
                rect.bottom-pl_cdt[PLAYLISTEDIT].bdt.y,
                pl_cdt[PLAYLISTEDIT].bdt.width,
                pl_cdt[PLAYLISTEDIT].bdt.height, 
                SWP_NOZORDER|SWP_NOREDRAW);
     // close button
     SetWindowPos(hClosePlaylist,NULL,
    			rect.right-pl_cdt[PLAYLISTCLOSE].bdt.x,
                pl_cdt[PLAYLISTCLOSE].bdt.y,
                pl_cdt[PLAYLISTCLOSE].bdt.width,
                pl_cdt[PLAYLISTCLOSE].bdt.height,
                SWP_NOZORDER|SWP_NOREDRAW);


     //GetWindowRect(hAdd,&rect1);
     /*
     HRGN validate;
     HRGN invalidate;
     HRGN temp1,temp2;

     invalidate=CreateRectRgnIndirect(&rect);

     GetClientRect(hAdd,&rect1);
     MapWindowPoints(hAdd,hwnd,(POINT *)&rect1,2);
     validate=CreateRectRgnIndirect(&rect1);
     CombineRgn(invalidate,invalidate,validate,RGN_DIFF	);
     DeleteObject(validate);

     GetClientRect(hDelete,&rect1);
     MapWindowPoints(hDelete,hwnd,(POINT *)&rect1,2);
     validate=CreateRectRgnIndirect(&rect1);
     CombineRgn(invalidate,invalidate,validate,RGN_DIFF	);
     DeleteObject(validate);

     GetClientRect(hSongUp,&rect1);
     MapWindowPoints(hSongUp,hwnd,(POINT *)&rect1,2);
     validate=CreateRectRgnIndirect(&rect1);
     CombineRgn(invalidate,invalidate,validate,RGN_DIFF	);
     DeleteObject(validate);

     GetClientRect(hSongDown,&rect1);
     MapWindowPoints(hSongDown,hwnd,(POINT *)&rect1,2);
     validate=CreateRectRgnIndirect(&rect1);
     CombineRgn(invalidate,invalidate,validate,RGN_DIFF	);
     DeleteObject(validate);

     GetClientRect(hPlaylist,&rect1);
     MapWindowPoints(hPlaylist,hwnd,(POINT *)&rect1,2);
     validate=CreateRectRgnIndirect(&rect1);
     CombineRgn(invalidate,invalidate,validate,RGN_DIFF	);
     DeleteObject(validate);

     GetClientRect(hEditPlaylist,&rect1);
     MapWindowPoints(hEditPlaylist,hwnd,(POINT *)&rect1,2);
     validate=CreateRectRgnIndirect(&rect1);
     CombineRgn(invalidate,invalidate,validate,RGN_DIFF	);
     DeleteObject(validate);

     GetClientRect(hClosePlaylist,&rect1);
     MapWindowPoints(hClosePlaylist,hwnd,(POINT *)&rect1,2);
     validate=CreateRectRgnIndirect(&rect1);
     CombineRgn(invalidate,invalidate,validate,RGN_DIFF	);
     DeleteObject(validate);

     GetClientRect(hScrollPlaylist,&rect1);
     MapWindowPoints(hScrollPlaylist,hwnd,(POINT *)&rect1,2);
     validate=CreateRectRgnIndirect(&rect1);
     CombineRgn(invalidate,invalidate,validate,RGN_DIFF	);
     DeleteObject(validate);

     InvalidateRgn(hwnd,invalidate,FALSE);
     */


     InvalidateRect(hwnd,NULL,FALSE);
     
     // must validate background of controls to avoid flickering

     GetClientRect(hAdd,&rect1);
     MapWindowPoints(hAdd,hwnd,(POINT *)&rect1,2);
     ValidateRect(hwnd,&rect1);

      GetClientRect(hDelete,&rect1);
     MapWindowPoints(hDelete,hwnd,(POINT *)&rect1,2);
     ValidateRect(hwnd,&rect1);

      GetClientRect(hSongUp,&rect1);
     MapWindowPoints(hSongUp,hwnd,(POINT *)&rect1,2);
     ValidateRect(hwnd,&rect1);

     GetClientRect(hSongDown,&rect1);
     MapWindowPoints(hSongDown,hwnd,(POINT *)&rect1,2);
     ValidateRect(hwnd,&rect1);

      GetClientRect(hEditPlaylist,&rect1);
     MapWindowPoints(hEditPlaylist,hwnd,(POINT *)&rect1,2);
     ValidateRect(hwnd,&rect1);

     GetClientRect(hClosePlaylist,&rect1);
     MapWindowPoints(hClosePlaylist,hwnd,(POINT *)&rect1,2);
     ValidateRect(hwnd,&rect1);

      GetClientRect(hPlaylist,&rect1);
     MapWindowPoints(hPlaylist,hwnd,(POINT *)&rect1,2);
     ValidateRect(hwnd,&rect1);

     GetClientRect(hScrollPlaylist,&rect1);
     MapWindowPoints(hScrollPlaylist,hwnd,(POINT *)&rect1,2);
     ValidateRect(hwnd,&rect1);




     RedrawWindow(hScrollPlaylist,NULL,NULL,RDW_UPDATENOW|RDW_INVALIDATE);
     RedrawWindow(hPlaylist,NULL,NULL,RDW_UPDATENOW|RDW_INVALIDATE);
     RedrawWindow(hEditPlaylist,NULL,NULL,RDW_UPDATENOW|RDW_INVALIDATE);
     RedrawWindow(hSongDown,NULL,NULL,RDW_UPDATENOW|RDW_INVALIDATE);
     RedrawWindow(hSongUp,NULL,NULL,RDW_UPDATENOW|RDW_INVALIDATE);
     RedrawWindow(hDelete,NULL,NULL,RDW_UPDATENOW|RDW_INVALIDATE);
     RedrawWindow(hAdd,NULL,NULL,RDW_UPDATENOW|RDW_INVALIDATE);
     RedrawWindow(hClosePlaylist,NULL,NULL,RDW_UPDATENOW|RDW_INVALIDATE);
     

     UpdateWindow(hwnd);

    // adjust scrollbar to new listbox size
     ListBoxUpdateScroll(hPlaylist,hScrollPlaylist);
     /*
     InvalidateRect(hPlaylist,NULL,FALSE);
     InvalidateRect(hAdd,NULL,FALSE);
     InvalidateRect(hDelete,NULL,FALSE);
     InvalidateRect(hSongUp,NULL,FALSE);
     InvalidateRect(hSongDown,NULL,FALSE);
     InvalidateRect(hEditPlaylist,NULL,FALSE);
     InvalidateRect(hClosePlaylist,NULL,FALSE);
     InvalidateRect(hScrollPlaylist,NULL,FALSE);
     */


     //UpdateWindow(hwnd);

}




void PaintPlaylistDialog(HDC hdc, HWND hwnd)
{
    // paint background of playlist dialog ( titlebar, bottom, border )
	RECT rect;
    GetClientRect(hwnd,&rect);
	HDC hdcmem = CreateCompatibleDC(hdc);
    HBITMAP hbmOld;


            RECT rect1;
        RECT rect2;


        hbmOld=(HBITMAP)SelectObject(hdcmem,mainbitmap[pl_cdt[TOPMIDDLE].bdt.bitmapindex]);

        int state;
        if(pactive)
        	state=ACTIVE;
        else
        	state=INACTIVE;


        	// left corner

             BitBlt(hdc,0,
            		0,
                    pl_cdt[TOPLEFT].bdt.width,
                    pl_cdt[TOPLEFT].bdt.height,
                    hdcmem,
                    pl_cdt[TOPLEFT].bdt.bitmap[state].x,
                    pl_cdt[TOPLEFT].bdt.bitmap[state].y,
                    SRCCOPY);
            //right ugao

            BitBlt(hdc,rect.right-pl_cdt[TOPRIGHT].bdt.width,
            		0,
                    pl_cdt[TOPRIGHT].bdt.width,
                    pl_cdt[TOPRIGHT].bdt.height,
                    hdcmem,
                    pl_cdt[TOPRIGHT].bdt.bitmap[state].x,
                    pl_cdt[TOPRIGHT].bdt.bitmap[state].y,
                    SRCCOPY);


        rect1.left=rect.right/2 - pl_cdt[TOPMIDDLE].bdt.width/2;
        rect1.top=0;
        rect1.right=rect1.left+pl_cdt[TOPMIDDLE].bdt.width;
        rect1.bottom=pl_cdt[TOPMIDDLE].bdt.height;

        // middle
        BitBlt(hdc,rect.right/2 - pl_cdt[TOPMIDDLE].bdt.width/2,
            				0,
                            pl_cdt[TOPMIDDLE].bdt.width,
                            pl_cdt[TOPMIDDLE].bdt.height,
                            hdcmem,
                            pl_cdt[TOPMIDDLE].bdt.bitmap[state].x,
                    		pl_cdt[TOPMIDDLE].bdt.bitmap[state].y,
                            SRCCOPY);

         RECT pattern;

        // left fill

        rect2.left=pl_cdt[TOPLEFT].bdt.width; // end of left corner
        rect2.top=0;
        rect2.right= rect.right/2 - pl_cdt[TOPMIDDLE].bdt.width/2; // start of middle
        rect2.bottom=pl_cdt[TOPLEFT].bdt.height; // height of left corner

        pattern.left=pl_cdt[TOPFILL].bdt.bitmap[state].x;
        pattern.top=pl_cdt[TOPFILL].bdt.bitmap[state].y;
        pattern.right=pl_cdt[TOPFILL].bdt.width;
        pattern.bottom= pl_cdt[TOPFILL].bdt.height;

        FillRectWithPattern(hdc,&rect2,hdcmem,&pattern);



        //right fill
        rect2.left=rect1.left+pl_cdt[TOPMIDDLE].bdt.width; // end of middle
        rect2.top=0;
        rect2.right= rect.right-pl_cdt[TOPRIGHT].bdt.width; // start of right corner
        rect2.bottom=pl_cdt[TOPRIGHT].bdt.height; // height of titlebar

        FillRectWithPattern(hdc,&rect2,hdcmem,&pattern);


        // left and right bottom corner

         BitBlt(hdc,0,
            		rect.bottom-pl_cdt[BOTTOMLEFT].bdt.height,
                    pl_cdt[BOTTOMLEFT].bdt.width,
                    pl_cdt[BOTTOMLEFT].bdt.height,
                    hdcmem,
                    pl_cdt[BOTTOMLEFT].bdt.bitmap[INACTIVE].x,
                    pl_cdt[BOTTOMLEFT].bdt.bitmap[INACTIVE].y,
                    SRCCOPY);



        // right corner
        BitBlt(hdc,rect.right-pl_cdt[BOTTOMRIGHT].bdt.width,
            		rect.bottom-pl_cdt[BOTTOMRIGHT].bdt.height,
                    pl_cdt[BOTTOMRIGHT].bdt.width,
                    pl_cdt[BOTTOMRIGHT].bdt.height,
                    hdcmem,
                    pl_cdt[BOTTOMRIGHT].bdt.bitmap[INACTIVE].x,
                    pl_cdt[BOTTOMRIGHT].bdt.bitmap[INACTIVE].y,
                    SRCCOPY);


        // fill
        rect2.left=pl_cdt[BOTTOMLEFT].bdt.width; // end of left corner
        rect2.top=rect.bottom-pl_cdt[BOTTOMLEFT].bdt.height;
        rect2.right= rect.right-pl_cdt[BOTTOMRIGHT].bdt.width; // start of right corner
        rect2.bottom=rect.bottom;

        pattern.left=pl_cdt[BOTTOMFILL].bdt.bitmap[INACTIVE].x;
        pattern.top=pl_cdt[BOTTOMFILL].bdt.bitmap[INACTIVE].y;
        pattern.right=pl_cdt[BOTTOMFILL].bdt.width;
        pattern.bottom= pl_cdt[BOTTOMFILL].bdt.height;

        FillRectWithPattern(hdc,&rect2,hdcmem,&pattern);


        // left border

        rect2.left=0;
        rect2.top=pl_cdt[TOPLEFT].bdt.height;
        rect2.right=rect.left+pl_cdt[LEFTBORDER].bdt.width;
        rect2.bottom=rect.bottom-pl_cdt[BOTTOMLEFT].bdt.height;
        pattern.left=pl_cdt[LEFTBORDER].bdt.bitmap[INACTIVE].x;
        pattern.top=pl_cdt[LEFTBORDER].bdt.bitmap[INACTIVE].y;
        pattern.right=pl_cdt[LEFTBORDER].bdt.width;
        pattern.bottom= pl_cdt[LEFTBORDER].bdt.height;
        FillRectWithPattern(hdc,&rect2,hdcmem,&pattern);

        //right border

        rect2.left=rect.right-pl_cdt[RIGHTBORDER].bdt.width;
        rect2.top=pl_cdt[TOPRIGHT].bdt.height;
        rect2.right=rect.right;
        rect2.bottom=rect.bottom-pl_cdt[BOTTOMRIGHT].bdt.height;
        pattern.left=pl_cdt[RIGHTBORDER].bdt.bitmap[INACTIVE].x;
        pattern.top=pl_cdt[RIGHTBORDER].bdt.bitmap[INACTIVE].y;
        pattern.right=pl_cdt[RIGHTBORDER].bdt.width;
        pattern.bottom= pl_cdt[RIGHTBORDER].bdt.height;

        FillRectWithPattern(hdc,&rect2,hdcmem,&pattern);

        SelectObject(hdcmem,hbmOld);
        DeleteDC(hdcmem);




}

void UpdateMainWindow(HWND hwnd)
{
    // set position and size of all controls in main window

	PosList[CLOSE]=hClose;
    PosList[MINIMIZE]=hMinimize;
    PosList[PREVIOUS]=hPrev;
    PosList[PLAY]=hPlay;
    PosList[PAUSE]=hPause;
    PosList[STOP]=hStop;
    PosList[NEXT]=hNext;
    PosList[EJECT]=hEject;
    PosList[OPTIONS]=hOptions;
    PosList[SHOWPLAYLIST]=hShowPlaylist;
    PosList[LOCKVOLUME]=hLockVolume;
    PosList[MUTEVOLUME]=hMuteVolume;
    PosList[PLAYPOS]=hPosition;
    PosList[LVOLUME]=hLeftAudio;
    PosList[RVOLUME]=hRightAudio;
    PosList[MASTERVOLUME]=hMasterAudio;
    PosList[PLAYTIME]=hPlayTime;
    PosList[TRACKLENGTH]=hTrackLength;
    PosList[ARTIST]=hArtist;
    PosList[ALBUM]=hAlbum;
    PosList[TRACK]=hTrack;
    PosList[STATUS]=hStatus;

    SetWindowPos(hwnd,NULL,0,0,
     			m_cdt[MAIN].main.width,
                m_cdt[MAIN].main.height,
                SWP_NOZORDER|SWP_NOMOVE);


    for (int i=2;i<24;i++) {
    	SetWindowPos(PosList[i],NULL,
     			m_cdt[i].bdt.x,
                m_cdt[i].bdt.y,
     			m_cdt[i].bdt.width,
                m_cdt[i].bdt.height,
                SWP_NOZORDER);
    }

    InvalidateRect(hwnd,NULL,TRUE);


}

void InitializeMainWindow()
{
    // subclassing controls
    
    InitializeBT(hPrev,mainbitmap,&m_cdt[PREVIOUS]);
    InitializeBT(hPlay,mainbitmap,&m_cdt[PLAY]);
    InitializeBT(hPause,mainbitmap,&m_cdt[PAUSE]);
    InitializeBT(hStop,mainbitmap,&m_cdt[STOP]);
    InitializeBT(hNext,mainbitmap,&m_cdt[NEXT]);
    InitializeBT(hEject,mainbitmap,&m_cdt[EJECT]);
    InitializeBT(hShowPlaylist,mainbitmap,&m_cdt[SHOWPLAYLIST]);
    InitializeBT(hOptions,mainbitmap,&m_cdt[OPTIONS]);
    InitializeBT(hMinimize,mainbitmap,&m_cdt[MINIMIZE]);
    InitializeBT(hClose,mainbitmap,&m_cdt[CLOSE]);
    InitializeBT(hLockVolume,mainbitmap,&m_cdt[LOCKVOLUME]);
    InitializeBT(hMuteVolume,mainbitmap,&m_cdt[MUTEVOLUME]);
    InitializeST(hPlayTime,font,&m_cdt[PLAYTIME],mainbitmap);
    InitializeST(hArtist,font,&m_cdt[ARTIST],mainbitmap);
    InitializeST(hAlbum,font,&m_cdt[ALBUM],mainbitmap);
    InitializeST(hTrack,font,&m_cdt[TRACK],mainbitmap);
    InitializeST(hTrackLength,font,&m_cdt[TRACKLENGTH],mainbitmap);
    InitializeST(hStatus,font,&m_cdt[STATUS],mainbitmap);
    InitializeSB(hPosition,mainbitmap,&m_cdt[PLAYPOS]);
    InitializeSB(hLeftAudio,mainbitmap,&m_cdt[LVOLUME]);
    InitializeSB(hRightAudio,mainbitmap,&m_cdt[RVOLUME]);
    InitializeSB(hMasterAudio,mainbitmap,&m_cdt[MASTERVOLUME]);

}

void UnitializeMainWindow()
{
    // revert subclassing
    
    UninitializeBT(hPrev);
    UninitializeBT(hPlay);
    UninitializeBT(hPause);
    UninitializeBT(hStop);
    UninitializeBT(hNext);
    UninitializeBT(hEject);
    UninitializeBT(hShowPlaylist);
    UninitializeBT(hOptions);
    UninitializeBT(hMinimize);
    UninitializeBT(hClose);
    UninitializeBT(hLockVolume);
    UninitializeBT(hMuteVolume);
    UninitializeST(hPlayTime);
    UninitializeST(hArtist);
    UninitializeST(hAlbum);
    UninitializeST(hTrack);
    UninitializeST(hTrackLength);
    UninitializeST(hStatus);
    UninitializeSB(hPosition);
    UninitializeSB(hLeftAudio);
    UninitializeSB(hRightAudio);
    UninitializeSB(hMasterAudio);

}

void InitializePlaylistWindow()
{
    // subclassing controls
 	InitializeLB(hPlaylist,mainbitmap, &pl_cdt[PLAYLISTBOX],font);
	InitializeSB(hScrollPlaylist,mainbitmap,&pl_cdt[PLAYLISTSCROLLBAR]);
 	InitializeBT(hClosePlaylist,mainbitmap,&pl_cdt[PLAYLISTCLOSE]);
	InitializeBT(hEditPlaylist,mainbitmap,&pl_cdt[PLAYLISTEDIT]);
	InitializeBT(hSongUp,mainbitmap,&pl_cdt[PLAYLISTSONGUP]);
 	InitializeBT(hSongDown,mainbitmap,&pl_cdt[PLAYLISTSONGDOWN]);
 	InitializeBT(hAdd,mainbitmap,&pl_cdt[PLAYLISTADD]);
	InitializeBT(hDelete,mainbitmap,&pl_cdt[PLAYLISTDELETE]);

}

void UninitializePlaylistWindow()
{
    // revert subclassing ( restore original procedures)
 	UninitializeLB(hPlaylist);
	UninitializeSB(hScrollPlaylist);
	UninitializeBT(hClosePlaylist);
	UninitializeBT(hEditPlaylist);
	UninitializeBT(hSongUp);
	UninitializeBT(hSongDown);
	UninitializeBT(hAdd);
	UninitializeBT(hDelete);

}



void SetMixer()
{
    // initialize mixer
    
    DWORD lChannelVolume;
    DWORD rChannelVolume;

	UINT num=mixerGetNumDevs();
    SCROLLINFO sinfo;
    if(num>0) {
        // open mixer
    	if(mixerOpen(&hnd_mixer,0,0,0,MIXER_OBJECTF_MIXER)==MMSYSERR_NOERROR) {
    	   // get line control ID for CD volume
        	if(mixerGetControlID((HMIXEROBJ)hnd_mixer,
            	MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC,
                MIXERCONTROL_CONTROLTYPE_VOLUME,&cdVolumeControlID)) {
                // get volume
                if(mixerGetVolume((HMIXEROBJ)hnd_mixer,cdVolumeControlID, 2,
						0,&lChannelVolume,&rChannelVolume)) {

                    // set scrollbar range and position
                 	sinfo.cbSize=sizeof(sinfo);
                    sinfo.fMask=SIF_RANGE|SIF_POS;
                    sinfo.nMin=0;
                    sinfo.nMax=655;
                    sinfo.nPos=655-lChannelVolume/100;
                    SetScrollInfo(hLeftAudio,SB_CTL,&sinfo,FALSE);
                    sinfo.nPos=655-rChannelVolume/100;
                    SetScrollInfo(hRightAudio,SB_CTL,&sinfo,FALSE);
                }
            }
            // get line control ID for SPEAKER volume
            if(mixerGetControlID((HMIXEROBJ)hnd_mixer,
            	MIXERLINE_COMPONENTTYPE_DST_SPEAKERS,
                MIXERCONTROL_CONTROLTYPE_VOLUME,&masterVolumeControlID)) {
                // get volume
                if(mixerGetVolume((HMIXEROBJ)hnd_mixer,masterVolumeControlID, 0,
						0,&lChannelVolume,&rChannelVolume)) {
                        // set scrollbar range and position
                        sinfo.cbSize=sizeof(sinfo);
                    	sinfo.fMask=SIF_RANGE|SIF_POS;
                    	sinfo.nMin=0;
                    	sinfo.nMax=655;
                    	sinfo.nPos=655-lChannelVolume/100;
                    	SetScrollInfo(hMasterAudio,SB_CTL,&sinfo,FALSE);
                }
            }
             // get line control ID for CD mute 
             if(mixerGetControlID((HMIXEROBJ)hnd_mixer,
            	MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC,
                MIXERCONTROL_CONTROLTYPE_MUTE,&cdMuteControlID)) {
             	if(mixerGetMute((HMIXEROBJ)hnd_mixer,cdMuteControlID))
               		SetButtonCheckState(hMuteVolume,TRUE,TRUE);
               	else
                	SetButtonCheckState(hMuteVolume,FALSE,TRUE);

             }
        }
    }
}



BOOL DoCreateDialogTooltip(HWND hwnd)
{ 

    // Ensure that the common control DLL is loaded, and create 
    // a tooltip control. 
    InitCommonControls(); 
    hwndTT = CreateWindowEx(WS_EX_TOPMOST, TOOLTIPS_CLASS, (LPSTR) NULL,
        TTS_ALWAYSTIP, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, 
        CW_USEDEFAULT, hwnd, (HMENU) NULL, GetModuleHandle(NULL), NULL);
 
    if (hwndTT == NULL)
        return FALSE;

    SendMessage(hwndTT,TTM_SETDELAYTIME,TTDT_AUTOPOP,3000);
    SendMessage(hwndTT,TTM_SETDELAYTIME,TTDT_INITIAL,1000);
    SendMessage(hwndTT,TTM_SETDELAYTIME,TTDT_RESHOW	,1000);


    // Enumerate the child windows to register them with the tooltip
    // control.

    if (!EnumChildWindows(hwnd, (WNDENUMPROC) EnumChildProc, (LPARAM)hwnd))
        return FALSE;

    // Install a hook procedure to monitor the message stream for mouse 
    // messages intended for the controls in the dialog box. 
    g_hhk = SetWindowsHookEx(WH_GETMESSAGE, GetMsgProc, 
        (HINSTANCE) NULL, GetCurrentThreadId()); 
 
    if (g_hhk == (HHOOK) NULL) 
        return FALSE;

    return TRUE; 
} 

// EmumChildProc - registers control windows with a tooltip control by
//     using the TTM_ADDTOOL message to pass the address of a 

//     TOOLINFO structure.
// Returns TRUE if successful or FALSE otherwise. 
// hwndCtrl - handle of a control window 
// lParam - application-defined value (not used)
BOOL EnumChildProc(HWND hwndCtrl, LPARAM lParam)
{
    TOOLINFO ti;
    char szClass[64];

    // Skip static controls. 
    GetClassName(hwndCtrl, szClass, sizeof(szClass));
    if (lstrcmpi(szClass, "STATIC") || GetDlgCtrlID(hwndCtrl)==IDC_PLAYTIME) {
        ti.cbSize = sizeof(TOOLINFO); 
        ti.uFlags = TTF_IDISHWND; 

        ti.hwnd = (HWND)lParam;
        ti.uId = (UINT) hwndCtrl; 
        ti.hinst = 0;
        ti.lpszText =LPSTR_TEXTCALLBACK;
        SendMessage(hwndTT, TTM_ADDTOOL, 0,
            (LPARAM) (LPTOOLINFO) &ti);
    } 
    return TRUE; 
} 

// GetMsgProc - monitors the message stream for mouse messages intended 
//     for a control window in the dialog box. 
// Returns a message-dependent value.
// nCode - hook code 
// wParam - message flag (not used) 

// lParam - address of an MSG structure 
LRESULT CALLBACK GetMsgProc(int nCode, WPARAM wParam, LPARAM lParam)
{


    MSG *lpmsg;
    lpmsg = (MSG *) lParam; 
    if (nCode < 0 || !(IsChild(hMain, lpmsg->hwnd)))
        return (CallNextHookEx(g_hhk, nCode, wParam, lParam));
 
    switch (lpmsg->message) {

        case WM_MOUSEMOVE: 
        case WM_LBUTTONDOWN: 
        case WM_LBUTTONUP: 
        case WM_RBUTTONDOWN: 
        case WM_RBUTTONUP: 
            if (hwndTT != NULL && showTooltip) {

                MSG msg;
                msg.lParam = lpmsg->lParam; 
                msg.wParam = lpmsg->wParam; 
                msg.message = lpmsg->message; 
                msg.hwnd = lpmsg->hwnd;
                SendMessage(hwndTT, TTM_RELAYEVENT, 0,
                    (LPARAM) (LPMSG) &msg);
            } 
            break; 
        default: 
            break; 
    } 
    return (CallNextHookEx(g_hhk, nCode, wParam, lParam)); 
} 


// OnWMNotify - provides the tooltip control with the appropriate text 

//     to display for a control window. This function is called by 
//     the dialog box procedure in response to a WM_NOTIFY message.
// lParam - second message parameter of the WM_NOTIFY message
VOID OnWMNotify(LPARAM lParam)
{ 
    LPTOOLTIPTEXT lpttt;
    int idCtrl;
 
    if ((((LPNMHDR) lParam)->code) == TTN_NEEDTEXT) { 
        idCtrl = GetDlgCtrlID((HWND) ((LPNMHDR) lParam)->idFrom); 
        lpttt = (LPTOOLTIPTEXT) lParam; 
 
        switch (idCtrl) {
            // loads text from resource 

            case IDC_PREVIOUSTRACK:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_PREV;
                return;

            case IDC_PLAY:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_PLAY;
                return;

            case IDC_PAUSE:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_PAUSE;
                return;

            case IDC_STOP:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_STOP;
                return;

            case IDC_NEXTTRACK:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_NEXT;
               	return;

            case IDC_EJECT:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_EJECT;
                return;

            case IDC_PLAYLIST:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_PLAYLIST;
                return;

            case IDC_OPTIONS:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_OPTIONS;
                return;

            case IDC_LOCKVOLUME:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_LOCK;
                return;

            case IDC_MUTEVOLUME:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_MUTE;
                return;

            case IDC_LVOLUME:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_LVOLUME;
                return;

            case IDC_RVOLUME:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_RVOLUME;
                return;

            case IDC_MASTERVOLUME:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_MASTER;
                return;

            case IDC_PLAYPOS:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_POS;
                return;

            case IDC_MINIMIZE:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_MINIMIZE;
                return;

            case IDC_CLOSE:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_CLOSE;
                return;

            case IDC_PLAYTIME:
            	lpttt->hinst=g_hinst;
                lpttt->lpszText=(LPSTR)T_PLAYTIME;
                return;

        }
    } 
return; 
} 


BOOL LoadTracks(BOOL noseek)
{
	if(!loadCDTracks(wCDPlayerID,tracks_array,&numOfTracks)) {
	   // if there is no audio tracks on CD
    	char tmp[81];
    	LoadString(g_hinst,NOAUDIOTRACKS,tmp,80);
    	SetStaticText(hTrack,tmp);
        //CDIsLoaded=TRUE;
        return FALSE;
    }


    DWORD serial;
    char cdromdrive[5];
        
    sprintf(cdromdrive,"%s\\",drive);
    GetVolumeInformation(cdromdrive,NULL,0,&serial,NULL,NULL,
           	NULL,0); // get serial number of cd media

    sprintf(serialstring,"[%X]",serial);
    char value[100];

    HANDLE hFile=OpenIniFile(playlistIniFile);
    // load data from database ( cdplayler.ini or other (can be customized)
    if (GetIniKey(hFile,serialstring,"artist",value))
        SetStaticText(hArtist,value);
    else {
    	char tmp[81];
    	LoadString(g_hinst,UNKNOWNARTIST,tmp,80);
    	SetStaticText(hArtist,tmp);
    }

    if (GetIniKey(hFile,serialstring,"title",value))
    	SetStaticText(hAlbum,value);
    else {
    	char tmp[81];
    	LoadString(g_hinst,UNKNOWNALBUM,tmp,80);
    	SetStaticText(hAlbum,tmp);
    }

    CloseIniFile(hFile);
    CDIsLoaded=TRUE;
    // fill playlist
    FillPlaylist(hPlaylist);
    endTrack=FALSE;

    if (noseek)
    	return TRUE;
	// seek to first track in playlist
    int track=ListBoxGetData(hPlaylist,0);
    seekCD(wCDPlayerID,(BYTE)track,0,0);
 	return TRUE;
}


void FindCDROMDrives(char *CDdrives)
{

    DWORD drives=GetLogicalDrives(); // get bitmask
    char driveletter[4];
    strcpy(CDdrives,"");
    for(int i=0;i<26;i++) {
        if( (1 << i) & drives) { // decode bitmask
                sprintf(driveletter,"%c:\\",65+i);
                if(GetDriveType(driveletter)==DRIVE_CDROM)  // DRIVE_FIXED  //DRIVE_CDROM	
                                strncat(CDdrives,driveletter,1);   
        } 
    }
}

void LoadSkinInfo(HWND hwnd,HANDLE hFile)
{
	char tmp1[MAX_PATH];
    char tmp2[MAX_PATH];

	if(GetIniKey(hFile,"[info]","author",tmp1)) {
    sprintf(tmp2,"Author: %s",tmp1);
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp2);
    }
    if(GetIniKey(hFile,"[info]","version",tmp1)) {
    sprintf(tmp2,"Version: %s",tmp1);
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp2);
    }

    if(GetIniKey(hFile,"[info]","releasedate",tmp1)) {
    sprintf(tmp2,"Date: %s",tmp1);
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp2);
    }
    if(GetIniKey(hFile,"[info]","line1",tmp1))
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp1);
    if(GetIniKey(hFile,"[info]","line2",tmp1))
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp1);
    if(GetIniKey(hFile,"[info]","line3",tmp1))
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp1);
    if(GetIniKey(hFile,"[info]","line4",tmp1))
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp1);
    if(GetIniKey(hFile,"[info]","line5",tmp1))
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp1);
    if(GetIniKey(hFile,"[info]","line6",tmp1))
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp1);
    if(GetIniKey(hFile,"[info]","line7",tmp1))
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp1);
    if(GetIniKey(hFile,"[info]","line8",tmp1))
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp1);
    if(GetIniKey(hFile,"[info]","line9",tmp1))
    SendDlgItemMessage(hwnd,ID_SKININFO,
    LB_ADDSTRING ,0,(LPARAM)tmp1);

}


BOOL openCD(HWND hwnd,MCIDEVICEID *wDeviceID,char *drive)
{
//**

	/*open a CD audio device

    If device opened successfully: set wDeviceID and return TRUE
    If unable to open device: return FALSE

    */

	DWORD dwReturn;
	MCI_OPEN_PARMS mciOpenParms;

	// Opens a CD audio device by specifying a device-type constant.
	mciOpenParms.lpstrDeviceType = (LPCSTR) MCI_DEVTYPE_CD_AUDIO;
	mciOpenParms.lpstrElementName=drive; // open selected cdrom drive  | MCI_OPEN_ELEMENT
	dwReturn = mciSendCommand(0, MCI_OPEN,MCI_WAIT| MCI_OPEN_TYPE |
                MCI_OPEN_ELEMENT| MCI_OPEN_TYPE_ID,
    			(DWORD)(LPVOID) &mciOpenParms);
	if (dwReturn==0)
    {
    	// The device opened successfully; get the device ID.
		*wDeviceID = mciOpenParms.wDeviceID;
		 MCI_SET_PARMS  mciSetParms;
         mciSetParms.dwTimeFormat = MCI_FORMAT_TMSF;
       mciSendCommand(mciOpenParms.wDeviceID, MCI_SET,
        	MCI_WAIT|MCI_SET_TIME_FORMAT, (DWORD)(LPVOID) &mciSetParms);
       
		return TRUE;
    }
    *wDeviceID=0;
    return FALSE;
}

BOOL closeCD(HWND hwnd,MCIDEVICEID *wDeviceID)
{
	DWORD dwReturn;
 	dwReturn=mciSendCommand(*wDeviceID, MCI_CLOSE, MCI_WAIT, 0);
    if(dwReturn != 0) {
    	char error[130];
    	if(mciGetErrorString(dwReturn ,error,128)) {
    		MessageBox(hwnd,error,"MCI CLOSE ERROR",MB_ICONSTOP);
    		return FALSE;
    	}
    }
    *wDeviceID=0;
 return TRUE;
}

BOOL seekCD(MCIDEVICEID  wDeviceID,int bTrack, int bMinute, int bSeconde)
{

	if(!CDIsLoaded)
    	return FALSE;
    	
    	
	MCI_SET_PARMS  mciSetParms;
	mciSetParms.dwTimeFormat = MCI_FORMAT_TMSF;

	mciSendCommand(wDeviceID, MCI_SET,MCI_WAIT|
	MCI_SET_TIME_FORMAT, (DWORD)(LPVOID) &mciSetParms);
        
    DWORD dwReturn;
	MCI_SEEK_PARMS seek;
    mciSendCommand(wCDPlayerID, MCI_STOP,MCI_WAIT,0);

    if (randomIntro && introPlay) {
     	int len=getCDTrackLength(wDeviceID,bTrack);
     	// get random start position
        int pos=GetRandomNumber(len-introPlayLen);
        seek.dwTo=MCI_MAKE_TMSF(bTrack, pos/60, pos%60, 0);
        
        dwReturn=mciSendCommand(wDeviceID, MCI_SEEK,
    		MCI_WAIT|MCI_TO, (DWORD) (LPMCI_SEEK_PARMS)&seek);
        
        
        if(dwReturn != 0) {
    			char error[130];
    			if(mciGetErrorString(dwReturn ,error,128)) {
        			MessageBox(hMain,error,"MCI SEEK ERROR",MB_ICONSTOP);
            		return FALSE;
                }
        	}

    }
    else {
    	seek.dwTo=MCI_MAKE_TMSF(bTrack, bMinute, bSeconde, 0);
        
    	dwReturn=mciSendCommand(wDeviceID, MCI_SEEK,
    		MCI_WAIT|MCI_TO, (DWORD) (LPMCI_SEEK_PARMS)&seek);
        
        
        if(dwReturn != 0) {
    			char error[130];
    			if(mciGetErrorString(dwReturn ,error,128)) {
        			MessageBox(hMain,error,"MCI SEEK ERROR",MB_ICONSTOP);
            		return FALSE;
                }
        }
    }
    //endTrack=TRUE;

    int index=ListBoxGetIndex(hPlaylist,bTrack);
    ListBoxSetActive(hPlaylist,index,TRUE);
    endTrack=FALSE;

   return TRUE;
}

BOOL NotifyButton(HWND hwnd,BOOL down)
{

	if(!keyShortcuts)
    	return 0;

    BUTTON *bt=GetButton(hwnd);
    if(!bt)
    	return 0;

    UINT message;
    if(down) {
    	message=WM_LBUTTONDOWN;
         bt->checked=TRUE;
    }
    else {
    	message=WM_LBUTTONUP;
         bt->checked=FALSE;
    }

    SendMessage(hwnd,message,MK_LBUTTON,
    	MAKELPARAM(0,0));

    return TRUE;

}


BOOL SaveCustomPlaylist()
{
		if(!CDIsLoaded)
			return FALSE;
	 // save custom playlist
    	HANDLE hFile=OpenIniFile(playlistIniFile);
    	char tmp[100];
    	sprintf(tmp,"%i",numOfTracks);
    	SetIniKey(hFile,serialstring,"numtracks",tmp);
    	int numplay=SendMessage(hPlaylist,LB_GETCOUNT,0,0);

        if(numplay==0) {
        	SetIniKey(hFile,serialstring,"numplay","");
            CloseIniFile(hFile);
            return TRUE;
        }

        char *order=(char *) malloc(100);
        order[0]=0;


       for(int i=0;i<numplay;i++) {
        	WORD data=ListBoxGetData(hPlaylist,i);
            sprintf(tmp,"%i ",data-1);
            strcat(order,tmp);
        }
        sprintf(tmp,"%i",numplay);
        SetIniKey(hFile,serialstring,"numplay",tmp);
        SetIniKey(hFile,serialstring,"order",order);
        free(order);
        CloseIniFile(hFile);
        return TRUE;

}
