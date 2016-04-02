#ifndef MIXER
#define MIXER


void mixerSetVolume(HMIXEROBJ hmxobj,DWORD ControlID, DWORD Channels,
	DWORD MultipleItems,DWORD lChannel, DWORD rChannel);

BOOL mixerGetVolume(HMIXEROBJ hmxobj,DWORD ControlID, DWORD Channels,
	DWORD MultipleItems,LPDWORD lChannel, LPDWORD rChannel);

BOOL mixerGetControlID(HMIXEROBJ hmxobj,DWORD ComponentType,
						DWORD dwControlType,DWORD *ControlID);

void mixerSetMute(HMIXEROBJ hmxobj,DWORD ControlID,BOOL mute);
BOOL mixerGetMute(HMIXEROBJ hmxobj,DWORD ControlID);


#endif
