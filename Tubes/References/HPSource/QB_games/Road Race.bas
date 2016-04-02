'        רררררררררררררררררררררררררררררררררררררררררררררררררררררררר
'        ררררררררר            Qbasic Roadrace          רררררררררר
'        רררררררררררררררר-   Akarsha V. Kumarרררררררררררררררררררר

'Namaste ! That's Indian for HI !! I'm a high school dude and I waste lottsa
'time programming in QBASIC ( My mom doesn't like it one bit tho !!)
'This was one of the first games I wrote and it works pretty neatly altho
'the code has been written in a very haphazard manner (I was very new then).
'I have absolutely no idea about how it will look in color (We in India find
'it difficult ..sob ...to afford even a mono monitor ...Boo Hoo Hoo .....).
'So please sympathise 'n do something about the color attributes I've set
'if you get wierd combinations like pink 'n orange ( Har Har ....)
'So all you Sennas out there ...... get set and go !
'Happy playing !!!

'NOTE : Runs fastest when compiled

RANDOMIZE TIMER
TIMER ON
SCREEN 1: CLS

CIRCLE (165, 85), 50, 1: PAINT (165, 85), 1
CIRCLE (160, 80), 50, 2: PAINT (160, 80), 2
LOCATE 10, 16: PRINT "ROAD RACER": SLEEP (2): CLS

LOCATE 10, 14: PRINT "PROGRAM BY :"

FOR X = 2 TO 13
LOCATE 12, X - 1: PRINT "             "
LOCATE 12, X: PRINT "AKARSHA KUMAR"
STARTIME = TIMER
DO
time = TIMER
LOOP UNTIL time - STARTIME > .1

NEXT X

FOR Y = 20 TO 14 STEP -1
LOCATE Y + 1, 11: PRINT "                     "
LOCATE Y, 11: PRINT "D.G.RUPAREL COLLEGE"
STARTIME = TIMER
DO
time = TIMER
LOOP UNTIL time - STARTIME > .1

NEXT Y

LINE (50, 50)-(250, 140), 1, B
SLEEP (1): CLS
DO
PRINT "USE THE FOLLOWING KEYS:"
PRINT : PRINT
PRINT "  LEFT AND RIGHT ARROW KEYS TO MOVE"
PRINT
PRINT "  F1 TO ACCELERATE AND F2 TO DECELERATE"
PRINT
PRINT "  Q TO QUIT ."
LOCATE 15, 5: PRINT "PRESS A KEY"
LOOP UNTIL INPUT$(1) <> ""
CLS

'Init variables
1 X = 0: Y = 10: Z = 190: A = 150: B = 195: I = 1: : SOUNDLEVEL = 1000
STARTTIME = INT(TIMER)

CAR$ = "U20 E3 R7 F3 D20 L12 E2 U15 H2 F2 R7 E2 G2 D15 F2 H2 L7"

DO

CARX = A: CARY = -50
I = (RND * 4) - 2

LOCATE 1, 31: PRINT "Time": LOCATE 1, 36: PRINT "Kms"
LOCATE 14, 1: PRINT "Speed "

10      LINE (100, 0)-(100, 200), 1: LINE (220, 0)-(220, 200), 1
'Get inputs
K$ = INKEY$
IF K$ = CHR$(0) + "K" THEN GOSUB LEFT
IF K$ = CHR$(0) + "M" THEN GOSUB RIGHT
IF UCASE$(K$) = "Q" THEN GOSUB PLAYAGAIN
ON KEY(1) GOSUB SPEEDUP
ON KEY(2) GOSUB SPEEDDOWN

'Time graph
LINE (240, 10)-(260, 190), 1, B
LINE (240, 190 - TIMETAKEN * 9 / 10)-(260, 190), 2, BF

'Distance graph
LINE (280, 10)-(300, 190), 2, B
LINE (280, 190 - (DISTANCE / 1000) * 5 * 9 / 10)-(300, 190), 1, BF

'Speedometer
LINE (50, 50)-(75, 200), 1, BF
LINE (50, 200 - SPEED * 10)-(75, 200 - SPEED * 10), 2

IF CARY > 200 THEN GOTO 20 'Check if obstacle car has moved out of screen

IF SPEED = 0 THEN CARY = CARY - 3 ' If your speed=0 then move obstacle in opp. direction

KEY(1) ON: KEY(2) ON

LINE (95, X)-(100, X - 95), 1, BF         ' --
LINE (95, Y)-(100, Y - 5), 1, BF          '   |
LINE (95, Z)-(100, Z - 95), 1, BF         '   |__ Draw side lines
                                          '   |
LINE (220, X)-(225, X - 95), 1, BF        '   |
LINE (220, Y)-(225, Y - 10), 1, BF        ' --
LINE (220, Z)-(225, Z - 95), 1, BF        '

'Draw Finishline
IF FINISH$ = "WIN" THEN LINE (100, FINISHLINE)-(220, FINISHLINE + 10), 2, BF
PSET (A, 195)
DRAW CAR$

LINE (CARX, CARY)-(CARX + 20, CARY + 35), 1, BF: LINE (CARX + 5, CARY + 10)-(CARX + 15, CARY + 30), 2, BF
LINE (CARX + 5, CARY + 7)-(CARX + 15, CARY + 10), 0, BF

STARTIME = TIMER
DO
time = TIMER
LOOP UNTIL time - STARTIME > .01

LOCATE 1, 1: PRINT "Speed :"; INT(SPEED * 10)
LOCATE 2, 1: PRINT "Crashes :"; CRASH
LOCATE 3, 1: PRINT "Kms :"; 40 - INT(DISTANCE / 1000)
LOCATE 4, 1: PRINT "Time :"; 200 - TIMETAKEN

SOUND (SOUNDLEVEL), .03 ' create that irritating noise

LINE (95, X)-(100, X - 95), 0, BF
LINE (95, Y)-(100, Y - 5), 0, BF
LINE (95, Z)-(100, Z - 95), 0, BF

LINE (220, X)-(225, X - 95), 0, BF
LINE (220, Y)-(225, Y - 10), 0, BF
LINE (220, Z)-(225, Z - 95), 0, BF

IF Z > 240 THEN Z = 0  '
IF Y > 240 THEN Y = 0  ' Check if sidelines move out
IF X > 240 THEN X = 0  '


X = X + SPEED: Y = Y + SPEED: Z = Z + SPEED

LINE (A + 5, 175)-(A + 15, 195), 0, BF ' erase car

'Erase obstacle
LINE (CARX, CARY)-(CARX + 20, CARY + 35), 0, BF: LINE (CARX + 5, CARY + 10)-(CARX + 15, CARY + 30), 0, BF
LINE (CARX + 5, CARY + 7)-(CARX + 15, CARY + 10), 0, BF

'Erase Finishline
IF FINISH$ = "WIN" THEN LINE (100, FINISHLINE)-(220, FINISHLINE + 10), 0, BF

DISTANCE = DISTANCE + SPEED
SYSTEMTIME = INT(TIMER)
TIMETAKEN = SYSTEMTIME - STARTTIME
CARY = CARY + SPEED / 2
CARX = CARX + I
IF FINISH$ = "WIN" THEN FINISHLINE = FINISHLINE + SPEED
IF 200 - TIMETAKEN = 0 THEN LOCATE 11, 16: PRINT "TIME UP": BEEP: SLEEP (2): : STATUS$ = "LOSE": GOSUB PLAYAGAIN
IF FINISHLINE >= 170 THEN LOCATE 11, 13: GOSUB VICTORY
IF 40 - INT(DISTANCE / 1000) <= 0 THEN : FINISH$ = "WIN"
IF CARX > 190 OR CARX < 100 THEN I = I * -1
IF CARY = 190 THEN GOTO 20
IF CARY > 135 AND CARY < 195 AND CARX >= A - 25 AND CARX <= A + 15 THEN SOUND (190), 1: GOSUB CARCRASH: CRASH = CRASH + 1:  ELSE GOTO 10

20 LOOP UNTIL CRASH = 10
LOCATE 11, 13: PRINT "CAR DAMAGED !": BEEP: SLEEP (2): : STATUS$ = "LOSE": GOSUB PLAYAGAIN

'Routines to move car ; decrease & increase speeds

LEFT:
IF A = 100 THEN RETURN
LINE (A - 2, 197)-(A + 17, 160), 0, BF
A = A - 10
PSET (A, 195): DRAW CAR$
LINE (A - 2, 197)-(A + 17, 160), 0, BF
RETURN

RIGHT:
IF A = 200 THEN RETURN
LINE (A - 2, 197)-(A + 17, 160), 0, BF
A = A + 10
PSET (A, 195): DRAW CAR$
LINE (A - 2, 197)-(A + 17, 160), 0, BF
RETURN

SPEEDUP:
IF SPEED >= 15 THEN RETURN
SPEED = SPEED + .1
SOUNDLEVEL = SOUNDLEVEL + 10
RETURN
 
SPEEDDOWN:
IF SPEED <= 0 THEN RETURN
SPEED = SPEED - .1
SOUNDLEVEL = SOUNDLEVEL - 10
RETURN

'Now THIS is the STUPID subroutine .
'I didn't want to complicate the program (for myself).
'So I copied the main subroutine once again and made the crash subroutine .
'NOW don't blame me ! I was new then remember ! I'm too lazy to change it now.

CARCRASH:

KEY(1) STOP: KEY(2) STOP

DO

LINE (100, 0)-(100, 200), 1: LINE (220, 0)-(220, 200), 1

LINE (A - 30, B + 25)-(A + 30, B - 25), 0, BF

LINE (240, 10)-(260, 190), 1, B
LINE (240, 190 - TIMETAKEN * 9 / 10)-(260, 190), 2, BF

LINE (280, 10)-(300, 190), 2, B
LINE (280, 190 - (DISTANCE / 1000) * 5 * 9 / 10)-(300, 190), 1, BF

LINE (50, 50)-(75, 200), 1, BF
LINE (50, 200 - SPEED * 10)-(75, 200 - SPEED * 10), 2

LINE (95, X)-(100, X - 95), 0, BF
LINE (95, Y)-(100, Y - 5), 0, BF
LINE (95, Z)-(100, Z - 95), 0, BF

LINE (220, X)-(225, X - 95), 0, BF
LINE (220, Y)-(225, Y - 10), 0, BF
LINE (220, Z)-(225, Z - 95), 0, BF

IF FINISH$ = "WIN" THEN LINE (100, FINISHLINE)-(220, FINISHLINE + 10), 0, BF

IF Z > 240 THEN Z = 0
IF Y > 240 THEN Y = 0
IF X > 240 THEN X = 0

IF SPEED >= 0 THEN X = X + SPEED: Y = Y + SPEED: Z = Z + SPEED: SPEED = SPEED - .1
LINE (A + 5, 175)-(A + 15, 195), 0, BF

LINE (CARX, CARY)-(CARX + 20, CARY + 35), 0, BF: LINE (CARX + 5, CARY + 10)-(CARX + 15, CARY + 30), 0, BF
LINE (CARX + 5, CARY + 7)-(CARX + 15, CARY + 10), 0, BF

IF 50 - INT(DISTANCE / 1000) <= 0 THEN FINISH$ = "WIN"
IF 200 - TIMETAKEN = 0 THEN LOCATE 11, 16: PRINT "TIME UP": BEEP: SLEEP (2): STATUS$ = "LOSE": GOSUB PLAYAGAIN
CARY = CARY - 3
DISTANCE = DISTANCE + SPEED
SYSTEMTIME = INT(TIMER)
TIMETAKEN = SYSTEMTIME - STARTTIME

LINE (95, X)-(100, X - 95), 1, BF
LINE (95, Y)-(100, Y - 5), 1, BF
LINE (95, Z)-(100, Z - 95), 1, BF

LINE (220, X)-(225, X - 95), 1, BF
LINE (220, Y)-(225, Y - 10), 1, BF
LINE (220, Z)-(225, Z - 95), 1, BF

IF FINISH$ = "WIN" THEN LINE (100, FINISHLINE)-(220, FINISHLINE + 10), 2, BF

'Rotate car
DRAW "TA=" + VARPTR$(ANGLE)
PSET (A, B)
DRAW CAR$

LINE (CARX, CARY)-(CARX + 20, CARY + 35), 1, BF: LINE (CARX + 5, CARY + 10)-(CARX + 15, CARY + 30), 2, BF
LINE (CARX + 5, CARY + 7)-(CARX + 15, CARY + 10), 0, BF

STARTIME = TIMER
DO
time = TIMER
LOOP UNTIL time - STARTIME > .01

LOCATE 1, 1: PRINT "Speed :"; INT(SPEED * 10)
LOCATE 2, 1: PRINT "Crashes :"; CRASH
LOCATE 3, 1: PRINT "Kms :"; 40 - INT(DISTANCE / 1000)
LOCATE 4, 1: PRINT "Time :"; 200 - TIMETAKEN
SOUND (SOUNDLEVEL), .03

IF A > 190 THEN A = 190
IF A < 130 THEN A = 130

'Determine direction of spin and centre car if it spins out of road
IF CARX <= A - 15 THEN ANGLE = ANGLE - SPEED ELSE ANGLE = ANGLE + SPEED
B = B - SPEED * .05: IF ANGLE <= -360 OR ANGLE >= 355 THEN ANGLE = 0

IF FINISHLINE >= 200 THEN GOSUB VICTORY
IF SPEED < 0 THEN SOUNDLEVEL = 440
SOUNDLEVEL = SOUNDLEVEL - 10

LOOP UNTIL SPEED <= 0 AND CARY < -50
LOCATE 1, 1: PRINT "Speed : 0"
SLEEP (2)
SOUNDLEVEL = 1000
SPEED = 0: ANGLE = 0: B = 195: CLS
RETURN

VICTORY:
KEY(12) STOP: KEY(13) STOP: KEY(1) STOP: KEY(2) STOP

SPEED = 0
FOR I = 200 TO 0 STEP -1
LINE (A - 2, I)-(A + 17, I + 30), 0, BF
PSET (A, I): DRAW CAR$
STARTIME = TIMER
DO
time = TIMER
LOOP UNTIL time - STARTIME > .005

NEXT I
CLS
CIRCLE (165, 85), 50, 1: PAINT (165, 85), 1
CIRCLE (160, 80), 50, 2: PAINT (160, 80), 2
LOCATE 10, 16: PRINT " YOU WIN !!":
PLAY "MFo3L8ED+ED+Eo2Bo3DCL2o2A": SLEEP (1)

SYSTEM

PLAYAGAIN:
50 CLS : LOCATE 11, 13: INPUT "QUIT ?(Y/N)"; ANS$: ANS$ = UCASE$(ANS$)
IF ANS$ = "N" THEN
CLS
IF STATUS$ = "LOSE" THEN GOTO 1 ELSE RETURN
END IF
IF ANS$ = "Y" THEN
SCREEN 2: SCREEN 0: CLS
LOCATE 10, 25: PRINT "This game was written in QuickBasic"
LOCATE 11, 22: PRINT "You are free to distribute it as you like."
LOCATE 12, 28: PRINT "Do send in comments at:"
LOCATE 13, 27: PRINT "avkumar@giasbm01.vsnl.net.in"

LOCATE 15, 30: PRINT "Thanks for playing..."
DO: LOOP UNTIL INKEY$ <> ""
CLS : SYSTEM

ELSE GOTO 50
END IF
