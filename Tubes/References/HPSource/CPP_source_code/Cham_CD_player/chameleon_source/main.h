
#define IDT_TIMER1 9000
#define IDT_CD_TIMER 9001

#define IDC_PLAY 600
#define IDC_PAUSE 601
#define IDC_STOP 602
#define IDC_NEXTTRACK 603
#define IDC_PREVIOUSTRACK 604
#define IDC_EJECT 605
#define IDC_PLAYLIST 606
#define IDC_OPTIONS 607
#define IDC_LOCKVOLUME 608
#define IDC_MUTEVOLUME 609


#define IDC_PLAYPOS 700
#define IDC_LVOLUME 701
#define IDC_RVOLUME 702
#define IDC_MASTERVOLUME 703

#define IDC_SONGUP	800
#define IDC_SONGDOWN  801
#define IDC_ADDSONG   802
#define IDC_DELETESONG 803
#define IDC_EDITPLAYLIST 804
#define IDC_CLOSEPLAYLIST 805
#define IDC_MINIMIZE 806
#define IDC_CLOSE 807
#define IDC_PLAYTIME 808

#define MOVE 1
#define RESIZE 2




void LoadSkinInfo(HWND hwnd,HANDLE hFile);


BOOL LoadTracks(BOOL noseek);

void SetMixer();
void PaintPlaylistDialog(HDC hdc, HWND hwnd);
void UpdatePlaylistDialog(HWND hwnd);
void UpdateMainWindow(HWND hwnd);
void InitializeMainWindow();
void UnitializeMainWindow();
void InitializePlaylistWindow();
void UninitializePlaylistWindow();
void SaveSettings(HWND hwnd);

BOOL WINAPI OnContextMenu(HWND hwnd, int x, int y) ;
BOOL CALLBACK ToolDlgProc(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK ToolDlgEdit(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK ToolDlgOptions(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK ToolDlgAbout(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam);
VOID CALLBACK MyTimerProc(HWND hwnd,UINT message,UINT idTimer,DWORD dwTime);
BOOL CALLBACK ToolDlgAdd(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam);
void DrawAbout(HWND hwnd,HDC hdc);
BOOL CDTimerFunction(HWND hwnd);
int GetRandomNumber(int max);
void LoadSettings();
VOID APIENTRY DisplayContextMenu(HWND hwnd, POINT pt);
void FindCDROMDrives(char *CDDrives);

BOOL DoCreateDialogTooltip(HWND hwnd) ;
BOOL EnumChildProc(HWND hwndCtrl, LPARAM lParam);
LRESULT CALLBACK GetMsgProc(int nCode, WPARAM wParam, LPARAM lParam);
VOID OnWMNotify(LPARAM lParam);

BOOL openCD(HWND hwnd,MCIDEVICEID *wDeviceID,char *drive);
BOOL closeCD(HWND hwnd,MCIDEVICEID *wDeviceID);


BOOL playCD(MCIDEVICEID  wDeviceID);
int getCDTrackLength(MCIDEVICEID wDeviceID,BYTE bTrack);
void stopCD(MCIDEVICEID  wDeviceID);
void pauseCD(MCIDEVICEID  wDeviceID,LPDWORD pausePosition);
void ejectCD(MCIDEVICEID wDeviceID);
int getCurrentPosition(MCIDEVICEID wDeviceID);
UINT getCDNumOfTracks(MCIDEVICEID wDeviceID);
BOOL loadCDTracks(MCIDEVICEID wDeviceID,int *tracks_array, int *nTracks);

BOOL seekCD(MCIDEVICEID  wDeviceID,int bTrack, int bMinute, int bSeconde);

BOOL FindCDROMDrive(char *driveletter);

int getCurrentTrack(MCIDEVICEID wDeviceID);
BOOL IsPlay(MCIDEVICEID wDeviceID);

BOOL NotifyButton(HWND hwnd,BOOL down);

BOOL SaveCustomPlaylist();
