#define STRICT
#include <windows.h>

#pragma hdrstop

#include <mmsystem.h>   // must link with winmm library

#include "mixer.h"

BOOL mixerGetControlID(HMIXEROBJ hmxobj,DWORD ComponentType,
						DWORD dwControlType,DWORD *ControlID)
{
// get control identifier of the desired control

	MIXERLINE s_mixerLineInfo;

    s_mixerLineInfo.cbStruct=sizeof(s_mixerLineInfo);
    s_mixerLineInfo.dwComponentType=ComponentType;

   	if(mixerGetLineInfo(hmxobj,&s_mixerLineInfo,
    	MIXER_GETLINEINFOF_COMPONENTTYPE)!=MMSYSERR_NOERROR) {
        *ControlID=0;
    	return FALSE;
    }

    MIXERLINECONTROLS s_mixerLineControls;
    MIXERCONTROL s_mixerControls;

    s_mixerLineControls.cbStruct=sizeof(s_mixerLineControls);
    s_mixerLineControls.dwLineID=s_mixerLineInfo.dwLineID;
    s_mixerLineControls.cControls=s_mixerLineInfo.cControls;
	s_mixerLineControls.dwControlType=dwControlType;
    s_mixerLineControls.cbmxctrl=sizeof(s_mixerControls);
    s_mixerLineControls.pamxctrl=&s_mixerControls;

    if(mixerGetLineControls(hmxobj,&s_mixerLineControls,
     	MIXER_GETLINECONTROLSF_ONEBYTYPE)==MMSYSERR_NOERROR) {
        *ControlID= s_mixerLineControls.pamxctrl[0].dwControlID;
        return TRUE;
    }
    else
     	*ControlID=0;

    return FALSE;

}


void mixerSetVolume(HMIXEROBJ hmxobj,DWORD ControlID, DWORD Channels,
	DWORD MultipleItems,DWORD lChannel, DWORD rChannel)
{
	MIXERCONTROLDETAILS s_mixerControlDetails;
   	MIXERCONTROLDETAILS_UNSIGNED s_mixerControlVolume[3];


    s_mixerControlDetails.cbStruct=sizeof(s_mixerControlDetails);
    s_mixerControlDetails.dwControlID=ControlID;
    s_mixerControlDetails.cChannels=Channels;
    s_mixerControlDetails.cMultipleItems=MultipleItems;
    s_mixerControlDetails.cbDetails=sizeof(s_mixerControlVolume);
    s_mixerControlDetails.paDetails=s_mixerControlVolume;

    s_mixerControlVolume[1].dwValue=lChannel;
    s_mixerControlVolume[0].dwValue=rChannel;

    mixerSetControlDetails(hmxobj,&s_mixerControlDetails,
        		MIXER_OBJECTF_HMIXER|MIXER_SETCONTROLDETAILSF_VALUE);


}

BOOL mixerGetVolume(HMIXEROBJ hmxobj,DWORD ControlID, DWORD Channels,
	DWORD MultipleItems,LPDWORD lChannel, LPDWORD rChannel)

{

	MIXERCONTROLDETAILS s_mixerControlDetails;
   	MIXERCONTROLDETAILS_UNSIGNED s_mixerControlVolume[2];

    s_mixerControlDetails.cbStruct=sizeof(s_mixerControlDetails);
    s_mixerControlDetails.dwControlID=ControlID;
    s_mixerControlDetails.cChannels=Channels;
    s_mixerControlDetails.cMultipleItems=MultipleItems;
    s_mixerControlDetails.cbDetails=sizeof(s_mixerControlVolume);
    s_mixerControlDetails.paDetails=s_mixerControlVolume;


    if(mixerGetControlDetails(hmxobj,&s_mixerControlDetails,
        		MIXER_OBJECTF_HMIXER|
                MIXER_GETCONTROLDETAILSF_VALUE)==MMSYSERR_NOERROR) {

    	*lChannel=s_mixerControlVolume[1].dwValue;
    	*rChannel=s_mixerControlVolume[0].dwValue;
        return TRUE;
    }
    else {
       *lChannel=0;
       *rChannel=0;
       return FALSE;
    }
}


void mixerSetMute(HMIXEROBJ hmxobj,DWORD ControlID,BOOL mute)
{

	MIXERCONTROLDETAILS s_mixerControlDetails;
   	MIXERCONTROLDETAILS_BOOLEAN s_mixerControlMute;


    s_mixerControlDetails.cbStruct=sizeof(s_mixerControlDetails);
    s_mixerControlDetails.dwControlID=ControlID;
   	s_mixerControlDetails.cChannels=1;
    s_mixerControlDetails.cMultipleItems=0;
    s_mixerControlDetails.cbDetails=sizeof(s_mixerControlMute);
    s_mixerControlDetails.paDetails=&s_mixerControlMute;

    s_mixerControlMute.fValue=mute;

    mixerSetControlDetails(hmxobj,&s_mixerControlDetails,
        		MIXER_OBJECTF_HMIXER|MIXER_SETCONTROLDETAILSF_VALUE);

}


BOOL mixerGetMute(HMIXEROBJ hmxobj,DWORD ControlID)
{

	MIXERCONTROLDETAILS s_mixerControlDetails;
   	MIXERCONTROLDETAILS_BOOLEAN s_mixerControlMute;

     s_mixerControlDetails.cbStruct=sizeof(s_mixerControlDetails);
     s_mixerControlDetails.dwControlID=ControlID;
     s_mixerControlDetails.cChannels=1; 	// UNIFORM CONTROL
     s_mixerControlDetails.cMultipleItems=0;
     s_mixerControlDetails.cbDetails=sizeof(s_mixerControlMute);

    s_mixerControlDetails.paDetails=&s_mixerControlMute;

    mixerGetControlDetails(hmxobj,&s_mixerControlDetails,
        		MIXER_OBJECTF_MIXER|MIXER_GETCONTROLDETAILSF_VALUE);

    return s_mixerControlMute.fValue;

}









