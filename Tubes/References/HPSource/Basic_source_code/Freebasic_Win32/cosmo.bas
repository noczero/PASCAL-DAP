' Cosmo fight for FreeBasic QB console setting
' web: http://rudih.info

oldhi = 0

' title menu
menu:
COLOR 10, 0
CLS
LOCATE 8, 31
PRINT "---COSMO FIGHT---"
LOCATE 10, 10
PRINT "Use arrow keys to move, & space to shoot."
LOCATE 11, 10
PRINT "1,2,3 for speeds. <Esc> to quit."
IF score > oldhi THEN oldhi = score
LOCATE 12, 10
PRINT "Hi score: "; oldhi
user$ = ""
WHILE user$ = ""
    user$ = INKEY$
WEND
IF user$ = "" THEN END
CLS
score = 0
posy = 23
posx = 40
enemy1y = 1
enemy2y = 1
enemy3y = 1
delay! = .05
IF user$ = "1" THEN delay! = .1
IF user$ = "3" THEN delay! = .04
RANDOMIZE TIMER

' main loop
main:
LOCATE 1, 2
PRINT "Score: "; score
enemytime = enemytime + 1
LOCATE posy, posx
PRINT ""
IF enemy1x = 0 THEN
	enemy1x = INT(RND * 79) + 1
	enemy1y = 1
END IF
IF enemy2x = 0 THEN
	enemy2x = INT(RND * 79) + 1
	enemy2y = 1
END IF
IF enemy3x = 0 THEN
	enemy3x = INT(RND * 79) + 1
	enemy3y = 1
END IF
LOCATE enemy1y, enemy1x
PRINT " "
LOCATE enemy2y, enemy2x
PRINT " "
LOCATE enemy3y, enemy3x
PRINT " "
IF enemytime = 10 THEN
	enemy1y = enemy1y + 1
	enemy2y = enemy2y + 1
	enemy3y = enemy3y + 1
	enemytime = 0
END IF
IF enemy1y >= bullety AND enemy1x = bulletx THEN
	LOCATE bullety, bulletx
	PRINT " "
	enemy1x = 0
	score = score + 1
	bulletx = 0
	GOTO main:
END IF
IF enemy2y >= bullety AND enemy2x = bulletx THEN
	LOCATE bullety, bulletx
	PRINT " "
	enemy2x = 0
	score = score + 1
	blluetx = 0
	GOTO main:
END IF
IF enemy3y >= bullety AND enemy3x = bulletx THEN
	LOCATE bullety, bulletx
	PRINT " "
	enemy3x = 0
	score = score + 1
	bulletx = 0
	GOTO main:
END IF
LOCATE enemy1y, enemy1x
PRINT ""
LOCATE enemy2y, enemy2x
PRINT ""
LOCATE enemy3y, enemy3x
PRINT ""
IF enemy1y = 23 OR enemy2y = 23 OR enemy3y = 23 THEN
  Cls
  LOCATE 9, 17
  Print "Game over. Score=";score;" Press space..."
  x$ = INKEY$
  WHILE x$ <> " "
	x$ = INKEY$
  WEND
  GOTO menu:
END IF

IF bulletx > 0 THEN
	LOCATE bullety, bulletx
	PRINT " "
	IF bullety = 1 THEN
		bulletx = 0
		GOTO main:
	END IF
   bullety = bullety - 1
	LOCATE bullety, bulletx
	PRINT ""
END IF
tm! = TIMER
tm2! = tm! + delay!
WHILE tm! < tm2!
    tm! = TIMER
    user$ = INKEY$
    IF user$ = CHR$(0) + "K" AND posx > 1 THEN
	LOCATE posy, posx
	PRINT " "
	posx = posx - 1
    END IF
    IF user$ = CHR$(0) + "M" AND posx < 80 THEN
	LOCATE posy, posx
	PRINT " "
	posx = posx + 1
    END IF
    IF user$ = " " THEN
	IF bulletx > 0 THEN LOCATE bullety, bulletx
	PRINT " "
	bulletx = posx
	bullety = posy - 1
    END IF
    IF user$ = "" THEN GOTO menu:
WEND

GOTO main:
' end of program

