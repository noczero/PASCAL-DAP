' Console editor, for QuickBasic
' web: http://rudih.info

DIM line$(8000) ' buffer array

fposy = 1' file position
lenfile = 1' length of file

' reset screen
CLS
posy = 1
posx = 1

top:
CLS
FOR m = 1 TO 24
  PRINT line$((fposy - posy - 1) + m)
NEXT
IF posy >= 24 THEN PRINT line$(fposy)
LOCATE posy, posx
PRINT "Ü"

' get input
user$ = ""
WHILE user$ = ""
 user$ = INKEY$
WEND

' page up
IF user$ = CHR$(0) + CHR$(73) THEN
	IF fposy >= 25 THEN
	   fposy = fposy - 24
	   posy = 1
	ELSE
	  posy = 1
	  fposy = 1
	END IF
	GOTO top:
END IF

' page down
IF user$ = CHR$(0) + CHR$(81) THEN
	fposy = fposy + 24
	IF fposy >= lenfile OR fposy >= 7900 THEN fposy = lenfile - 1
	GOTO top:
END IF


' enter / down
IF user$ = CHR$(13) OR user$ = CHR$(0) + "P" THEN
	oldposx = posx
	posx = 1
	posy = posy + 1
	fposy = fposy + 1
	IF fposy > lenfile THEN lenfile = fposy
	IF lenfile > 7900 THEN
		PRINT "file too long"
		SLEEP
		END
	END IF
	IF posy > 23 THEN
		posy = 23
      GOTO top:
	END IF
	IF user$ = CHR$(0) + "P" THEN
		IF fposy = lenfile THEN
			lenfile = fposy + 1
		END IF
	END IF
	IF user$ = CHR$(13) THEN
		IF posy = 25 THEN GOTO top:
      lenfile = lenfile + 1
      FOR m = 1 TO lenfile - fposy
	line$(lenfile - m) = line$(lenfile - m - 1)
      NEXT
      IF oldposx = 1 THEN
	line$(fposy) = line$(fposy - 1)
	line$(fposy - 1) = ""
      END IF
      IF oldposx > 1 THEN line$(fposy) = ""
      LOCATE posy, 1
      IF posy < 26 THEN PRINT SPACE$(80)
	END IF
	GOTO top:
END IF
' f2(save)
IF user$ = CHR$(0) + "<" THEN
	CLS
	INPUT "Save as (enter cancels)"; filen$
	IF filen$ = "" THEN GOTO top:
	OPEN filen$ FOR OUTPUT AS #1
	FOR m = 1 TO lenfile
		PRINT #1, line$(m)
	NEXT m
	CLOSE #1
	GOTO top:
END IF
' f3(load)
IF user$ = CHR$(0) + "=" THEN
	CLS
	INPUT "Filename (enter cancels)"; filen$
	IF filen$ = "" THEN GOTO top:
	FOR m = 1 TO 8000
		line$(m) = ""
	NEXT
	OPEN filen$ FOR INPUT AS #1
	lenfile = 1
	WHILE NOT EOF(1)
	 LINE INPUT #1, line$(lenfile)
	 lenfile = lenfile + 1
	 IF lenfile > 7900 THEN
		PRINT "file too long"
		SLEEP
		END
	 END IF
	WEND
	CLOSE #1
	GOTO top:
END IF
' f1(help)
IF user$ = CHR$(0) + ";" THEN
	CLS
	PRINT " Console editor help. "
	PRINT " <F1> - help"
	PRINT " <F2> - save as"
	PRINT " <F3> - load"
	PRINT " <Esc> - exit"
	PRINT " Press any key..."
	SLEEP
	GOTO top:
END IF
' Esc(exit)
IF user$ = CHR$(27) THEN
	CLS
	PRINT "Exit (y/n)";
	x$ = ""
	WHILE x$ = ""
	x$ = INKEY$
	WEND
	IF x$ = "Y" OR x$ = "y" THEN END
	GOTO top:
END IF
' backspace / left
IF user$ = CHR$(8) OR user$ = CHR$(0) + "K" THEN
	IF posx = 1 AND posy = 1 THEN
		line$(fposy) = ""
		GOTO top:
	END IF
	IF posx > 1 THEN
	LOCATE posy, posx
	PRINT " "
	posx = posx - 1
	LL = LEN(line$(fposy))
	line$(fposy) = LEFT$(line$(fposy), LL - 1)
	END IF
	IF posx = 1 THEN
		IF fposy = 1 THEN GOTO top:
		lenfile = lenfile - 1
		fposy = fposy - 1
		posy = posy - 1
		FOR m = 1 TO lenfile - fposy
			line$(fposy + m) = line$(fposy + m + 1)
		NEXT
		CLS
		IF fposy > 1 THEN
			FOR m = 1 TO 24
			  PRINT line$((fposy - posy) + m)
		   NEXT
		END IF
	END IF
	GOTO top:
END IF
' up
IF user$ = CHR$(0) + "H" AND posy < 2 THEN
	IF fposy < 2 THEN GOTO top:
   fposy = fposy - 1
	posx = 1
	GOTO top:
END IF
IF user$ = CHR$(0) + "H" AND posy > 1 THEN
	fposy = fposy - 1
	posy = posy - 1
	posx = 1
	GOTO top:
END IF
' right
IF user$ = CHR$(0) + "M" THEN
   GOTO top:
END IF

IF lenfile > 7900 THEN
	PRINT "file too long"
	SLEEP
	END
END IF
IF posx > 79 GOTO top:
LeftL$ = LEFT$(line$(fposy), posx - 1)
LeftL$ = LeftL$ + user$
line$(fposy) = LeftL$
IF posx < 80 THEN posx = posx + 1

GOTO top:

