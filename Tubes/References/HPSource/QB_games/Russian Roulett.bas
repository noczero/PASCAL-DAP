DECLARE SUB PlayAgian ()
'
'                       R U S S I A N   R O U L E T T
'
'                  Copyright (C) Averysoft Corporation 1990
'
' Russian Roulett is a game where you must use speed to push the number
' before it dissapears.  If you fail to do this, A Revolver is shot at you.
' There is one bullit in the revolver in an unknown chamber. Every time the
' gun is shot, the bullit is closer. When you finish a round correctly, the
' barrel is spun, hiding the bullit agian in an unknown chamber.  If you get
' to the bullit, and fail the round . . . B A N G ! ! !
' You never Know Where the bullit is, but the computer tells you how many
' times the gun has been shot since the barrel was spun.
'
' To run this game, press Shift+F5.
' To exit QBasic, press Alt, F, X.
'         WARNING: (SEE WARNING IN GAME)
'
DECLARE SUB Intro ()
DECLARE SUB Center2 (row%, text$)
DECLARE SUB Pause3 (Sec!, T!, S2$, Score!)
DECLARE SUB Center (row%, text$)
DECLARE SUB Pause (T!)
DECLARE SUB TimeS (T!)
COMMON SHARED T
CLS
PRINT "Sound?  (Y/N)"
PRINT : PRINT : PRINT : PRINT
COLOR 1, 4
PRINT "WARNING:"
COLOR 4, 0
PRINT "        NEVER play this game with real guns.  It is VERY dangerous."
PRINT "        It can even KILL.  NEVER Point ANY kind of gun at any person "
PRINT "        or animal."
PRINT
PRINT "        PARENTS: NEVER Leave a gun where your child can reach it,"
PRINT "                 or where they Know where it is."
PRINT "                 No matter where the weapon is, if a child knows"
PRINT "                 where it is, they will be able to get it."
PRINT "                 It is BEST to LOCK THE WEAPON UP."
DO: I$ = UCASE$(INKEY$): LOOP UNTIL I$ = "Y" OR I$ = "N"
Soud = 0
IF I$ = "Y" THEN Soud = 1
DEF fnR (S, E) = INT(RND * (E - S + 1)) + S
DIM SHARED Gun(3000), Gun2(3000), P(130, 10), Chamber(6), Shoot(50)
Intro
SCREEN 13
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,19,19,19,19,19,19,19,19,19,19,19,19,0,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,25,25,25,25,25,25,25,25,25,25,25,19,18,18,18,18,18,18,18,18,18,18,19,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0
DATA 0,0,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,19,19,19,19,19,19,19,19,19,19,19,19,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0
DATA 0,17,17,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,19,18,18,18,18,18,18,18,18,18,18,19,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0
DATA 0,17,17,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,19,19,19,19,19,19,19,19,19,19,19,19,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,0,0,0,0,24,24,0,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,0,0,0,24,24,0,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,0,24,24,0,0,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,21,21,21,21,21,21,21,21,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0

CLS
PRINT "Russian Roulett"
'PAINT (160, 100), 1, 15
FOR X = 0 TO 120
FOR Y = 0 TO 8
P(X, Y) = POINT(X, Y)
IF POINT(X, Y) <> 15 THEN PSET (X, Y), 2
IF INKEY$ = CHR$(27) THEN SYSTEM
NEXT: NEXT
'END

CLS
'54,25

LINE (0, 0)-(319, 199), 1, BF
S = 2
FOR Y = 1 TO 25 * S STEP S
FOR X = 1 TO 54 * S STEP S
READ C
IF C <> 0 THEN
          LINE (X, Y)-(X + 1, Y + 1), C, B
          END IF
IF INKEY$ = CHR$(27) THEN SYSTEM
NEXT: NEXT
GET (0, 0)-(X, Y), Gun
GET (48, 20)-(63, 27), Shoot

'Start

' 108x50
1

FOR Y = 1 TO 100 STEP 100

FOR X = 1 TO 180 STEP 1
PUT (X, Y), Gun, PSET
NEXT
IF INKEY$ = CHR$(27) THEN SYSTEM

FOR Y1 = 1 TO 50
PUT (X, Y + Y1), Gun, PSET
NEXT
IF INKEY$ = CHR$(27) THEN SYSTEM

FOR X = 180 TO 1 STEP -1
PUT (X, Y + 50), Gun, PSET
NEXT
IF INKEY$ = CHR$(27) THEN SYSTEM

FOR Y1 = 51 TO 100
PUT (X, Y + Y1), Gun, PSET
NEXT
IF INKEY$ = CHR$(27) THEN SYSTEM
NEXT
Dx = 106: Dy = 75
DO
IF Dx <> X THEN S = ABS((Dy - Y) / (Dx - X)) ELSE S = 1
IF S > 1 THEN S = 1
IF X > Dx THEN : X = X - (1)
IF X < Dx THEN : X = X + (1)
IF Y > Dy THEN : Y = Y - (S)
IF Y < Dy THEN : Y = Y + (S)
PUT (X, Y), Gun, PSET
LOOP UNTIL INT(X) = INT(Dx) AND INT(Y) = INT(Dy)

FOR I = 1 TO 100
IF Soud = 1 THEN SOUND 37, .1
LINE (157, 84)-(176, 85), 18, B
LINE (157, 86)-(176, 87), 19, B
LINE (157, 88)-(176, 89), 18, B
LINE (157, 90)-(176, 91), 19, B
LINE (157, 92)-(176, 93), 18, B
IF Soud = 1 THEN SOUND 37, .1
PUT (106, 75), Gun, PSET
NEXT
IF Soud = 1 THEN SOUND 30000, 5
IF Soud = 1 THEN SOUND 40, 2

FOR I = 1 TO 20
X = fnR(100, 125)
Y = fnR(75, 100)
C = fnR(18, 30)
R = fnR(3, 8)
CIRCLE (X, Y), R, C
PAINT (X, Y), C, C
NEXT
GET (91, 65)-(199, 127), Gun2

FOR X = 85 TO -10 STEP -5
LINE (X, 83)-(X + 10, 86), 0, BF
LINE (X + 10, 83)-(X + 20, 86), 1, BF
PUT (91, 65), Gun2, PSET
IF INKEY$ <> "" THEN LINE (0, 0)-(319, 199), 1, BF: PlayAgian: GOTO Rerun
NEXT

LINE (91, 65)-(215, 127), 1, BF
PUT (106, 75), Gun, PSET

FOR I = 1 TO 50
IF Soud = 1 THEN SOUND 37, .1
LINE (157, 84)-(176, 85), 18, B
LINE (157, 86)-(176, 87), 19, B
LINE (157, 88)-(176, 89), 18, B
LINE (157, 90)-(176, 91), 19, B
LINE (157, 92)-(176, 93), 18, B
IF Soud = 1 THEN SOUND 37, .1
PUT (106, 75), Gun, PSET
IF INKEY$ <> "" THEN LINE (0, 0)-(319, 199), 1, BF: PlayAgian: GOTO Rerun
NEXT

X1 = 38: Y1 = 30
FOR Y = 0 TO 8 * 2 STEP 2
FOR X = 0 TO 120 * 2 STEP 2
C = P(X / 2, Y / 2)
IF C = 0 THEN C = 1
LINE (X + X1, Y + Y1)-(X + X1 + 2, Y + Y1 + 2), C, BF
IF INKEY$ <> "" THEN LINE (0, 0)-(319, 199), 1, BF: PlayAgian: GOTO Rerun
NEXT: NEXT


FOR I = 1 TO 50
IF Soud = 1 THEN SOUND 37, .1
LINE (157, 84)-(176, 85), 18, B
LINE (157, 86)-(176, 87), 19, B
LINE (157, 88)-(176, 89), 18, B
LINE (157, 90)-(176, 91), 19, B
LINE (157, 92)-(176, 93), 18, B
IF Soud = 1 THEN SOUND 37, .1
PUT (106, 75), Gun, PSET
IF INKEY$ <> "" THEN LINE (0, 0)-(319, 199), 1, BF: PlayAgian: GOTO Rerun
NEXT
S = TIMER
WHILE TIMER - S < 5: WEND

'Start Game
Rerun:
LINE (0, 0)-(319, 199), 1, BF
Round = 1
RANDOMIZE TIMER
         
LINE (0, 0)-(319, 70), 1, BF
FOR X = 106 TO 200
PUT (X, 75), Gun, PSET
NEXT

Y = 100
FOR X = -100 TO 20
'Face
CIRCLE (X + 60, Y + 5), 20, 89, , , .5
PAINT (X + 60, Y + 5), 89, 89
CIRCLE (X, Y), 60, 89, , , 1
PAINT (X, Y), 89, 89
NEXT
LINE (X + 47, Y + 38)-(X + 39, Y + 34), 19
LINE STEP(0, 0)-(X + 32, Y + 27), 19
CIRCLE (X + 26, Y - 24), 10, 19, , , .25
PAINT (X + 26, Y - 24), 15, 19
CIRCLE (X + 26, Y - 24), 4, 19, , , 3
PAINT (X + 26, Y - 24), 33, 19

GOSUB Turn

GOSUB Pause2
Center 23, "Ready"
S = TIMER
WHILE TIMER - S < 1: WEND
LINE (0, 175)-(319, 199), 1, BF
Center 23, "Set"
S = TIMER
WHILE TIMER - S < 1: WEND
Center 23, "Go!!"
S = TIMER
WHILE TIMER - S < 1: WEND
LINE (0, 175)-(319, 199), 1, BF
S = TIMER
WHILE TIMER - S < 1: WEND

IF INKEY$ = CHR$(27) THEN SYSTEM

'Main Game Start
Wat = 1.5
CR = Round

DO
IF K$ = CHR$(27) THEN SYSTEM
IF Round >= 12 THEN GOTO EndGame
IF Wat > .5 AND Round > CR THEN Wat = Wat - .1
IF Wat > .2 AND Round > 10 THEN Wat = Wat - .05
CR = Round
LINE (0, 0)-(319, 25), 0, BF
S1$ = "": S2$ = ""
FOR I = 1 TO fnR(5, 15)
LOCATE 2, 1: PRINT "Score: "; Score
Center 3, "Chamber #" + STR$(C)
Center 2, "Round #" + STR$(Round)
IF LEFT$(S1$, LEN(S2$)) <> S2$ THEN EXIT FOR
IF LEN(S1$) > LEN(S2$) + 2 THEN EXIT FOR
I$ = LTRIM$(RTRIM$(STR$((fnR(0, 9)))))
LOCATE 1, fnR(1, 30): PRINT I$
S1$ = S1$ + I$
K$ = INKEY$
IF K$ = " " THEN GOSUB Pause2
IF K$ >= "0" AND K$ <= "9" THEN S2$ = S2$ + K$: Score = Score + 10
IF K$ = CHR$(27) THEN SYSTEM
Pause3 Wat, T, S2$, Score
K$ = INKEY$
IF K$ = " " THEN GOSUB Pause2
IF K$ >= "0" AND K$ <= "9" THEN S2$ = S2$ + K$: Score = Score + 10
IF K$ = CHR$(27) THEN SYSTEM
LOCATE 1, 1: PRINT SPACE$(40)
NEXT
Pause 1.5
K$ = INKEY$
IF K$ >= "0" AND K$ <= "9" THEN S2$ = S2$ + K$
IF K$ = CHR$(27) THEN SYSTEM
GOSUB Pause2
IF S1$ = S2$ THEN
          Center 23, "Round" + STR$(Round) + " Completed"
          Score = Score + (Round * 100): Round = Round + 1
          LOCATE 1, 1: PRINT SPACE$(40)
          LOCATE 2: PRINT "Score: "; Score
          S = TIMER
          WHILE TIMER - S < 3: WEND
          GOSUB Turn
          LINE (0, 175)-(319, 199), 1, BF
          Center 23, "Ready"
          S = TIMER
          WHILE TIMER - S < 1: WEND
          LINE (0, 175)-(319, 199), 1, BF
          Center 23, "Set"
          S = TIMER
          WHILE TIMER - S < 1: WEND
          Center 23, "Go!!"
          S = TIMER
          WHILE TIMER - S < 1: WEND
          LINE (0, 175)-(319, 199), 1, BF
          S = TIMER
          WHILE TIMER - S < 1: WEND
          END IF
IF K$ = CHR$(27) THEN SYSTEM
IF S1$ <> S2$ THEN
          Center 23, "Round" + STR$(Round) + " Failed"
          Center 3, "Chamber #" + STR$(C)
          S = TIMER
          WHILE TIMER - S < 3: WEND
          GOSUB Fire
          LINE (0, 175)-(319, 199), 1, BF
          Center 23, "Ready"
          S = TIMER
          WHILE TIMER - S < 1: WEND
          LINE (0, 175)-(319, 199), 1, BF
          Center 23, "Set"
          S = TIMER
          WHILE TIMER - S < 1: WEND
          Center 23, "Go!!"
          S = TIMER
          WHILE TIMER - S < 1: WEND
          LINE (0, 175)-(319, 199), 1, BF
          LINE (0, 175)-(319, 199), 1, BF
          END IF
LOOP



Turn:
FOR I = 1 TO fnR(10, 50)
IF Soud = 1 THEN SOUND 37, .1
LINE (251, 84)-(270, 85), 18, B
LINE (251, 86)-(270, 87), 19, B
LINE (251, 88)-(270, 89), 18, B
LINE (251, 90)-(270, 91), 19, B
LINE (251, 92)-(270, 93), 18, B
IF Soud = 1 THEN SOUND 37, .1
PUT (200, 75), Gun, PSET
NEXT
FOR I = 1 TO 6
Chamber(I) = 0
NEXT
Chamber(fnR(1, 6)) = 1
Chamber = fnR(1, 6)
C = 1
IF Chamber / 2 = INT(Chamber / 2) THEN
          LINE (251, 84)-(270, 85), 18, B
          LINE (251, 86)-(270, 87), 19, B
          LINE (251, 88)-(270, 89), 18, B
          LINE (251, 90)-(270, 91), 19, B
          LINE (251, 92)-(270, 93), 18, B
          END IF
IF Chamber / 2 <> INT(Chamber / 2) THEN PUT (200, 75), Gun, PSET
RETURN

Fire:

GOSUB Shoot

IF Chamber(Chamber) = 0 THEN
          IF Soud = 1 THEN SOUND 40, 3
          Chamber = Chamber + 1: C = C + 1
          IF Chamber = 7 THEN Chamber = 1
          IF Chamber / 2 <> INT(Chamber / 2) THEN : PUT (200, 75), Gun, PSET
          IF Chamber / 2 = INT(Chamber / 2) THEN
                    LINE (251, 84)-(270, 85), 18, B
                    LINE (251, 86)-(270, 87), 19, B
                    LINE (251, 88)-(270, 89), 18, B
                    LINE (251, 90)-(270, 91), 19, B
                    LINE (251, 92)-(270, 93), 18, B
                    END IF
          GOTO Ret:
          END IF
Chamber = Chamber + 1: C = C + 1
IF Chamber / 2 <> INT(Chamber / 2) THEN PUT (200, 75), Gun, PSET
          IF Chamber / 2 = INT(Chamber / 2) THEN
          LINE (251, 84)-(270, 85), 18, B
          LINE (251, 86)-(270, 87), 19, B
          LINE (251, 88)-(270, 89), 18, B
          LINE (251, 90)-(270, 91), 19, B
          LINE (251, 92)-(270, 93), 18, B
          END IF
IF Soud = 1 THEN SOUND 37, 1: SOUND 38, 1: SOUND 39, 1: SOUND 40, 1
PUT (185, 65), Gun2, PSET
Pause .7
GOSUB Shoot2
LINE (184, 64)-(319, 127), 1, BF
PUT (200, 75), Gun, PSET
Y = 92
FOR X = 200 TO 50 STEP -1
LINE (X, Y - 3)-(X + 5, Y + 3), 1, BF
CIRCLE (X, Y), 2, 0
NEXT
PUT (200, 75), Gun, PSET
FOR I = 1 TO 100
X = fnR(46, 97)
Y = fnR(81, 106)
R = fnR(1, 3)
C = fnR(39, 42)
CIRCLE (X, Y), R, C
PAINT (X, Y), C, C
NEXT

CLS
Center 12, "G A M E   O V E R"
WHILE INKEY$ <> "": WEND
I$ = INPUT$(1)

PlayAgian
GOTO Rerun

Ret:
GOSUB Shoot2
RETURN

EndGame:
CLS
Center 12, "Y O U   W O N"
Center 15, "Congrats'!  You have Completed Russian Roulett"
Center 16, "~~~Alive!~~~"
I$ = INPUT$(1)
PlayAgian
GOTO Rerun


Shoot:
LINE (255, 100)-(258, 101), 1, BF
LINE (259, 100)-(260, 101), 24, BF
Pause .25
RETURN

Shoot2:
PUT (248, 95), Shoot, PSET
RETURN

Pause2:
LINE (0, 175)-(319, 199), 1, BF
Center 23, "Press any Key to Continue"
I$ = INPUT$(1)
LINE (0, 175)-(319, 199), 1, BF
RETURN

100
X1 = 160: Y1 = 100
BACK = POINT(X1, Y1)
DO
PSET (X1, Y1), 0
I$ = UCASE$(INKEY$)
IF I$ = CHR$(0) + "H" THEN PSET (X1, Y1), BACK: Y1 = Y1 - 1: BACK = POINT(X1, Y1)
IF I$ = CHR$(0) + "P" THEN PSET (X1, Y1), BACK: Y1 = Y1 + 1: BACK = POINT(X1, Y1)
IF I$ = CHR$(0) + "K" THEN PSET (X1, Y1), BACK: X1 = X1 - 1: BACK = POINT(X1, Y1)
IF I$ = CHR$(0) + "M" THEN PSET (X1, Y1), BACK: X1 = X1 + 1: BACK = POINT(X1, Y1)
LOCATE 1, 1: PRINT X1; Y1
LOOP

DEFINT A-Z
'Center:
'  Centers text on given row
SUB Center (row, text$)
    LOCATE row, 21 - LEN(text$) / 2
    PRINT text$;
END SUB

'Center:
'  Centers text on given row
SUB Center2 (row, text$)
    LOCATE row, 41 - LEN(text$) / 2
    PRINT text$;
END SUB

DEFSNG A-Z
SUB Intro
CLS
COLOR 5, 1
Center2 2, "R U S S I A N   R O U L E T T"
Center2 4, "Copyright (C) Averysoft Corporation 1990"
COLOR 3, 0
Center2 6, "Russian Roulett is a game where you must use speed to push the number"
Center2 7, "before it dissapears.  If you fail to do this, A Revolver is shot at you."
Center2 8, "There is one bullit in the revolver in an unknown chamber. Every time the"
Center2 9, "gun is shot, the bullit is closer. When you finish a round correctly, the"
Center2 10, "barrel is spun, hiding the bullit agian in an unknown chamber.  If you get"
Center2 11, "to the bullit, and fail the round . . . B A N G ! ! !"
Center2 12, "You never Know Where the bullit is, but the computer tells you how many"
Center2 13, "times the gun has been shot since the barrel was spun."
Center2 15, "Press any Key to Continue."
I$ = INPUT$(1)
IF I$ = CHR$(27) THEN SYSTEM
END SUB

SUB Pause (T)
S = TIMER: DO: LOOP UNTIL TIMER - S > T
END SUB

SUB Pause3 (Sec, T, S2$, Score)
S = TIMER
DO
K$ = INKEY$
IF K$ <> "" THEN GOSUB P4
LOOP UNTIL TIMER - S > Sec
GOTO Ret2
P4:
IF K$ = " " THEN GOSUB Pause4
IF K$ >= "0" AND K$ <= "9" THEN S2$ = S2$ + K$: Score = Score + 10
IF K$ = CHR$(27) THEN SYSTEM
RETURN
Pause4:
LINE (0, 175)-(319, 199), 1, BF
Center 23, "Press any Key to Continue"
I$ = INPUT$(1)
LINE (0, 175)-(319, 199), 1, BF
RETURN
Ret2:
END SUB

SUB PlayAgian
CLS
PRINT "Play Again? (Y or N)"
DO
SELECT CASE UCASE$(INKEY$)
CASE "Y": EXIT SUB
CASE "N": SYSTEM
CASE CHR$(27): SYSTEM
END SELECT
LOOP
END SUB

