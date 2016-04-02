' Console editor, for FreeBasic(QB console) 
' web: http://rudih.info

Dim Line$(8000) ' buffer array

fposy=1 ' file position
lenfile=1 ' length of file

' reset screen
Cls
posy=1
posx=1

top:
Cls
For m=1 To 24
  Print Line$((fposy-posy)+m)
Next
Locate posy,posx

' get input 
user$=""  
While user$=""
 user$=InKey$
Wend

' page up
If user$=CHR$(0) + CHR$(73) then
IF fposy >= 25 THEN
	   fposy = fposy - 24
	   posy=1
	ELSE
	  posy = 1
	  fposy = 1
	END IF
	GOTO top:
EndIf

' page down
If user$=CHR$(0) + CHR$(81) Then
	fposy=fposy+24
	If fposy>=lenfile Or fposy>=7900 Then fposy=lenfile-1
	GoTo top:
EndIf


' enter / down
If user$=CHR$(13) Or user$ = CHR$(0) + "P" Then 
	oldposx=posx
	posx=1
	posy=posy+1
	fposy=fposy+1	
	If fposy>lenfile Then lenfile = fposy
	If lenfile>7900 Then 
	 	Print "file too long"
	 	Sleep
	 	End
	EndIf
	If posy>24 Then      
		Posy=24
      GoTo top:	
	EndIf
	If user$=Chr$(0)+"P" Then
		If fposy=lenfile Then 
			lenfile=fposy+1
		EndIf
	EndIf
	If user$=Chr$(13) Then
		If posy=25 Then GoTo top:
      lenfile=lenfile+1
      For m=1 To lenfile-fposy
      	Line$(lenfile-m)=Line$(lenfile-m-1)
      Next
      If oldposx=1 Then 
      	Line$(fposy)=Line$(fposy-1)
      	Line$(fposy-1)=""
      EndIf
      If oldposx>1 Then Line$(fposy)=""
      Locate posy,1
      If posy<26 Then Print Space$(80)
	EndIf
	GoTo top:
EndIf
' f2(save)
If user$=CHR$(0) + "<"Then
	Cls 
	Input"Save as (enter cancels)";filen$
	If filen$="" Then GoTo top:
	Open filen$ For Output As #1
	For m=1 To lenfile
		Print #1,Line$(m)
	Next m
	Close #1
	GoTo top:
EndIf
' f3(load)
If user$=CHR$(0) + "=" Then 
	Cls
	Input"filename (enter cancels)";filen$
	If filen$="" Then GoTo top:
	For m=1 To 8000
		Line$(m)=""
	Next
	Open filen$ For Input As #1
	lenfile=1
	While Not Eof(1)
	 Line Input #1, Line$(lenfile) 
	 lenfile=lenfile+1
	 If lenfile>7900 Then 
	 	Print "file too long"
	 	Sleep
	 	End
	 EndIf
	Wend
	Close #1
	GoTo top:
EndIf
' f1(help)
If user$= CHR$(0) + ";" Then
	Cls
	Print " Console editor help. "
	Print " <F1> - help"
	Print " <F2> - save as"
	Print " <F3> - load"
	Print " <Esc> - exit"
	Print " Press any key..."
	Sleep
	GoTo top:
EndIf
' Esc(exit)
If user$=CHR$(27) Then
	Cls
	Print "Exit (y/n)";
	x$=""
	While x$=""
   	x$=InKey$
	wend
	If x$="Y" Or x$="y" Then End
	GoTo top:
EndIf
' backspace / left
If user$=CHR$(8) Or user$=CHR$(0) + "K" Then
	If posx=1 And posy=1 Then 
		Line$(fposy)=""
		GoTo top:
	EndIf
	If posx>1 Then
   	Locate posy,posx
   	Print" "
   	Posx=posx-1
   	LL=Len(Line$(fposy))
   	Line$(fposy)=Left$(Line$(fposy),LL-1)
	EndIf
	If posx=1 Then
		If fposy=1 Then GoTo top:
		lenfile=lenfile-1
		fposy=fposy-1
		posy=posy-1
		For m=1 To lenfile-fposy
			Line$(fposy+m)=Line$(fposy+m+1)
		Next
		Cls
		If fposy>1 Then
			For m=1 To 24
			  Print Line$((fposy-posy)+m)
		   Next		
		EndIf
	EndIf
	GoTo top:
EndIf
' up
If user$=CHR$(0) + "H" And posy<2 Then
	If fposy<2 Then GoTo top:
   fposy=fposy-1
	posx=1
	GoTo top:
EndIf
If user$=CHR$(0) + "H" And posy>1 Then
	fposy=fposy-1
	posy=posy-1
	posx=1
	GoTo top:
EndIf
' right
If user$ = CHR$(0) + "M" Then
   GoTo top:  
EndIf

If lenfile>7900 Then 
	Print "file too long"
	Sleep
	End
EndIf
If posx>79 GoTo top:
LeftL$=Left$(Line$(fposy),posx-1)
LeftL$=LeftL$+user$
Line$(fposy)=LeftL$
If posx<80 Then posx=posx+1

GoTo top: