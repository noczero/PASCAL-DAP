DECLARE SUB tictactoe ()
DECLARE SUB intro ()
DECLARE SUB game ()
DECLARE SUB titlescreen ()
SCREEN 0
intro
titlescreen
2001 DATA 1,2,3,1,3,2,2,3,1,4,9,5,4,5,9,5,9,4,6,7,8,6,8,7,7,8,6,1,4,6,1,6,4,4,6,1,2,7,9,2,9,7,7,9,2,3,5,8,3,8,5,5,8,3,1,8,9,1,9,8,8,9,1,3,6,9,3,9,6,6,9,3

SUB game
RANDOMIZE TIMER
CLS
SCREEN 12
COLOR
PRINT "Welcome to the math game!"
PRINT
INPUT "What is your name"; name$
PRINT
PRINT
1010 COLOR 15
PRINT "Which game would you like to play?"
PRINT "a: Additions"
PRINT "b: Substrations"
PRINT "c: Multiplications"
PRINT "d: Divisions"
PRINT "e: Cancel"
score = 0
timed = 0
DIM gameplay AS STRING * 1
INPUT gameplay$
SELECT CASE UCASE$(gameplay$)
CASE "A"
        symbol$ = " + "
        GOSUB introgame
        GOSUB additions
        GOSUB results
CASE "B"
        symbol$ = " - "
        GOSUB introgame
        GOSUB substractions
        GOSUB results
CASE "C"
        symbol$ = " * "
        GOSUB introgame
        GOSUB multiplications
        GOSUB results
CASE "D"
        symbol$ = " / "
        GOSUB introgame
        GOSUB divisions
        GOSUB results
CASE "E"
        titlescreen
CASE ELSE
        BEEP
        GOTO 1010
END SELECT

GOSUB playagain

introgame:
PRINT
INPUT "How manu questions would you like"; question
RETURN

additions:
timeone = TIMER
format$ = "##"
REDIM reponce(1 TO question)
REDIM digitone(1 TO question)
REDIM digittwo(1 TO question)
REDIM yourreponce(1 TO question)
FOR num = 1 TO question
RANDOMIZE TIMER
digitone(num) = INT(RND * 20)
digittwo(num) = INT(RND * 15)
reponce(num) = digitone(num) + digittwo(num)
PRINT digitone(num); symbol$; digittwo(num); "="
INPUT yourreponce(num)
IF yourreponce(num) = reponce(num) THEN
        PRINT "Correct"
        score = score + 1
ELSE
        PRINT "Incorrect"
END IF
NEXT num
timetwo = TIMER
RETURN

substractions:
timeone = TIMER
format$ = "##"
REDIM reponce(1 TO question)
REDIM digitone(1 TO question)
REDIM digittwo(1 TO question)
REDIM yourreponce(1 TO question)
FOR num = 1 TO question
RANDOMIZE TIMER
digitone(num) = INT(RND * 50)
digittwo(num) = INT(RND * 15)
IF digittwo(num) > digitone(num) THEN SWAP digittwo(num), digitone(num)
reponce(num) = digitone(num) - digittwo(num)
PRINT digitone(num); symbol$; digittwo(num); "="
INPUT yourreponce(num)
IF yourreponce(num) = reponce(num) THEN
        PRINT "Correct"
        score = score + 1
ELSE
        PRINT "Incorrect"
END IF
NEXT num
timetwo = TIMER

RETURN

multiplications:
timeone = TIMER
format$ = "##"
REDIM reponce(1 TO question)
REDIM digitone(1 TO question)
REDIM digittwo(1 TO question)
REDIM yourreponce(1 TO question)
FOR num = 1 TO question
RANDOMIZE TIMER
digitone(num) = INT(RND * 12)
digittwo(num) = INT(RND * 12)
reponce(num) = digitone(num) * digittwo(num)
PRINT digitone(num); symbol$; digittwo(num); "="
INPUT yourreponce(num)
IF yourreponce(num) = reponce(num) THEN
        PRINT "Correct"
        score = score + 1
ELSE
        PRINT "Incorrect"
END IF
NEXT num
timetwo = TIMER

RETURN

divisions:
timeone = TIMER
format$ = "##"
REDIM reponce(1 TO question)
REDIM digitone(1 TO question)
REDIM digittwo(1 TO question)
REDIM yourreponce(1 TO question)
FOR num = 1 TO question
IF digittwo(num) > digitone(num) THEN SWAP digittwo(num), digitone(num)
RANDOMIZE TIMER
digitone(num) = INT(RND * 50)
digittwo(num) = INT(RND * 15)
remain = digitone(num)
DO UNTIL remain < digittwo(num)
        remain = remain - digittwo(num)
LOOP
digitone(num) = digitone(num) - remain
reponce(num) = digitone(num) / digittwo(num)
PRINT digitone(num); symbol$; digittwo(num); "="
INPUT yourreponce(num)
IF yourreponce(num) = reponce(num) THEN
        PRINT "Correct"
        score = score + 1
ELSE
        PRINT "Incorrect"
END IF
NEXT num
timetwo = TIMER

RETURN

results:
accuracy = INT(score / question * 100)
PRINT "Your accuracy is:"; accuracy; "%"
timed = timetwo - timeone

timed2 = INT(timed)
DO UNTIL timed2 < 3600
timed2 = timed2 - 3600
hour = hour + 1
LOOP

timed3 = INT(timed) - hour * 3600
DO UNTIL timed3 < 60
timed3 = timed3 - 60
minutes = minutes + 1
LOOP

timed4 = INT(timed) - (hour * 3600) - (minutes * 60)
DO UNTIL timed4 <= 0
timed4 = timed4 - 1
seconds = seconds + 1
LOOP

PRINT "Your total time is ":
PRINT hour; ":";
PRINT USING format$; minutes;
PRINT ":";
PRINT USING format$; seconds
PRINT
finalscore = INT(accuracy - 2 * timed / question)
PRINT name$; " your final score is"; finalscore
PRINT
PRINT
2010 INPUT "Would you like to see the correct awnsers (y/n)"; correct$
SELECT CASE UCASE$(correct$)
CASE "Y"
        FOR num = 1 TO question
        IF yourreponce(num) = reponce(num) THEN COLOR 3 ELSE COLOR 4
        PRINT "Question"; num; " was "; digitone(num); symbol$; digittwo(num); " = "; reponce(num); ""
        PRINT "Your awnser was "; yourreponce(num)
        PRINT
        NEXT num
        COLOR 15
CASE "N"
        RETURN
CASE ELSE
        BEEP
        GOTO 2010
END SELECT
RETURN

playagain:

1020 INPUT "Would you like to play again (y/n)"; again$
SELECT CASE UCASE$(again$)
CASE "Y"
        GOTO 1010
CASE "N"
        titlescreen
CASE ELSE
        BEEP
        GOTO 1020
END SELECT
RETURN

END SUB

SUB intro

REM Bottom of text x= 298

REM line 1

SCREEN 12
x = 91
FOR p = 1920 TO 0 STEP -1
LINE (x - 2, p / 4)-(x + 2, p / 4), 1, BF
IF p > 1000 OR p < 700 THEN
        LINE (x - 2, p / 4)-(x + 2, p / 4), 0, BF
END IF
IF p / 7 = INT(p / 7) THEN x = x + 1
NEXT p

REM line 2

x = 439
FOR p = 1920 TO 0 STEP -1
LINE (x - 2, p / 4)-(x + 2, p / 4), 1, BF
IF p > 1000 OR p < 700 THEN
        LINE (x - 2, p / 4)-(x + 2, p / 4), 0, BF
END IF
IF p / 7 = INT(p / 7) THEN x = x - 1
NEXT p

REM line 3

x = 450
FOR p = 1920 TO 0 STEP -1
LINE (x + 2, p / 4)-(x - 2, p / 4), 1, BF
IF p > 1000 OR p < 700 THEN
        LINE (x + 2, p / 4)-(x - 2, p / 4), 0, BF
END IF
NEXT p

REM line 4


p = 0
x = 376
FOR p = 0 TO 1920
LINE (x + 2, p / 4)-(x - 2, p / 4), 1, BF
IF p < 700 OR p > 1000 THEN
LINE (x + 2, p / 4)-(x - 2, p / 4), 0, BF
END IF
NEXT p

REM lines 5 and 6

yone = 700
xone = 0
ytwo = 960
xtwo = 150
DO UNTIL ytwo = 0 AND xone = 480
LINE (xone, yone / 4 - 2)-(xone, yone / 4 + 2), 1
LINE (xtwo - 2, ytwo / 2)-(xtwo + 2, ytwo / 2), 1, BF
IF xone <= 100 OR xone >= 200 THEN
        LINE (xone, yone / 4 - 2)-(xone, yone / 4 + 2), 0, BF
END IF
IF ytwo < 346 OR ytwo > 450 THEN
LINE (xtwo - 2, ytwo / 2)-(xtwo + 2, ytwo / 2), 0, BF
END IF
xone = xone + 1
ytwo = ytwo - 2
LOOP
LINE (149, 350 / 2)-(151, 410 / 2), 1, BF


REM circles 1 and 2

rone = 0
DO UNTIL rone = 27
rone = rone + 1
CIRCLE (125, 225), rone, 1
IF rone >= 4 THEN
        rtwo = rone - 3
        CIRCLE (125, 225), rtwo, 0
END IF
LOOP
LINE (98, (450 / 2) - rone)-(147, 450 / 2), 0, BF

REM Lines 7 and 8

xone = 681
Y = 480
xtwo = 145
DO UNTIL Y = 0
COLOR 1
LINE (xone - 2, Y)-(xone + 2, Y), 1, BF
LINE (xtwo - 2, Y)-(xtwo + 2, Y), 1, BF
IF Y >= 212 OR Y <= 175 THEN
LINE (xone - 2, Y)-(xone + 2, Y), 0, BF
LINE (xtwo - 2, Y)-(xtwo + 2, Y), 0, BF
END IF
LINE (450 + 2, 1000 / 4)-(450 - 2, 700 / 4 + 2), 1, BF
LINE (376 + 2, 1000 / 4 - 2)-(376 - 2, 700 / 4 + 2), 1, BF
Y = Y - 1
xone = xone - 1
xtwo = xtwo + 1
LOOP
LINE (450 + 2, 1000 / 4)-(450 - 2, 700 / 4 + 2), 1, BF
LINE (376 + 2, 1000 / 4 - 2)-(376 - 2, 700 / 4 + 2), 1, BF
 
REM line 9

DO UNTIL x = 6400
LINE (x / 10, 214)-(x / 10, 210), 1, BF
IF x < 1480 THEN
        LINE (x / 10, 214)-(x / 10, 210), 0
END IF
IF x > 1530 AND x < 2430 THEN
        LINE (x / 10, 214)-(x / 10, 210), 0
END IF
xone = x
WHILE xone > 2439 AND xone < 2441
        FOR d = 210 TO 214
        PSET ((2440 - 10) / 10, d), 1
        NEXT d
        FOR d = 212 TO 214
        PSET ((2440 - 20) / 10, d), 1
        NEXT d
        xone = xone + 10
WEND
IF x > 2880 AND x < 3740 THEN
        LINE (x / 10, 214)-(x / 10, 210), 0
END IF
xtwo = x
WHILE xtwo > 2879 AND xtwo < 2891
        FOR d = 212 TO 214
        PSET (2880 / 10, d), 1
        NEXT d
        FOR d = 210 TO 214
        PSET (2890 / 10, d), 1
        NEXT d
        xtwo = xtwo + 10
WEND

IF x > 3790 AND x < 4480 THEN
         LINE (x / 10, 214)-(x / 10, 210), 0
END IF
IF x > 4530 THEN
        LINE (x / 10, 214)-(x / 10, 210), 0
END IF
x = x + 1
COLOR 1
PSET (413, 212)
LINE (411, 211)-(415, 211), 1
LINE (410, 210)-(416, 210), 1
LOOP
x = 0
DO UNTIL x = 4510
LINE (x / 10, 300)-(x / 10, 320), 4, BF
x = x + 1
LOOP
xagain = 0
DO UNTIL xagain = 950
LINE (xagain / 10, 300)-(xagain / 10, 320), 0, BF
xagain = xagain + 1
LOOP
LOCATE 23, 15, 0
COLOR 1
PRINT "P   r   o   d   u   c   t   i   o   n   s"
FOR n = 1 TO 100000
NEXT n
CLS
END SUB

SUB tictactoe

50
SCREEN 12
CLS
RANDOMIZE TIMER
PRINT
PRINT "Who will go first?"
PRINT
100 INPUT "Heads or Tails (h/t)"; cointoe$
coin = INT(RND * 10)
IF coin / 2 = INT(coin / 2) THEN coin = 1 ELSE coin = 0
SLEEP 1
turn = 0
SELECT CASE UCASE$(cointoe$)
CASE "H"
        IF coin = 1 THEN
        PRINT "Heads, you go first!"
        turn = 1
        END IF
        IF coin = 0 THEN PRINT "Tails, I go first!"
CASE "T"
        IF coin = 1 THEN PRINT "Heads, I go first!"
        IF coin = 0 THEN
        PRINT "Tails, you go first!"
        turn = 1
        END IF
CASE ELSE
        BEEP
        PRINT "Wrong input"
        GOTO 100
END SELECT
SLEEP 1.5


CLS
LINE (200, 100)-(202, 400), 1, BF
LINE (300, 100)-(302, 400), 1, BF
LINE (100, 200)-(400, 202), 1, BF
LINE (100, 300)-(400, 303), 1, BF
REDIM x(1 TO 9)  AS STRING
x$(1) = "BM150,150"
x$(2) = "BM250,150"
x$(3) = "BM350,150"
x$(4) = "BM150,250"
x$(9) = "BM250,250"
x$(5) = "BM350,250"
x$(6) = "BM150,350"
x$(7) = "BM250,350"
x$(8) = "BM350,350"


REDIM squarefill(1 TO 9) AS INTEGER
FOR zzz = 1 TO 9
squarefill(zzz) = 0
NEXT zzz
xwing$ = "NE25 NF25 NG25 NH25"


IF turn = 0 THEN
500 placeone = INT(RND * 300)
        IF placeone >= 24 THEN
                DRAW x$(9)
                DRAW xwing$
                squarefill(9) = 1
        END IF
        secondnum = 3
        mention = 1
        FOR firstnum = 1 TO 23 STEP 3
        IF placeone >= firstnum AND placeone <= secondnum AND squarefill(mention) = 0 THEN
                DRAW x$(mention)
                DRAW xwing$
                squarefill(mention) = 1
        ELSEIF placeone >= 24 THEN
                LET alsdgh = 0
        ELSE
        GOTO 500
        END IF
        mention = mention + 1
        secondnum = secondnum + 3
        NEXT firstnum
        turner = turner + 1
END IF

RANDOMIZE TIMER
        LOCATE 1, 1, 0
        PRINT "Where would you like to go?"
        PRINT "A1       A2       A3"
        PRINT
        PRINT "B1       B2       B3"
        PRINT
        PRINT "C1       C2       C3"
FOR drno = 1 TO 5
IF turn = 0 AND drno = 5 THEN GOSUB tie
300 LOCATE 7, 1
INPUT choiceone$
SELECT CASE UCASE$(choiceone$)
        CASE "A1"
                IF squarefill(1) = 1 OR squarefill(1) = -1 THEN
                        GOTO 300
                ELSE
                        CIRCLE (150, 150), 25, 1
                        squarefill(1) = -1
                END IF
        CASE "A2"
                IF squarefill(2) = 1 OR squarefill(2) = -1 THEN
                        GOTO 300
                ELSE
                        CIRCLE (250, 150), 25, 1
                        squarefill(2) = -1
                END IF
        CASE "A3"
                IF squarefill(3) = 1 OR squarefill(3) = -1 THEN
                        GOTO 300
                ELSE
                        CIRCLE (350, 150), 25, 1
                        squarefill(3) = -1
                END IF
        CASE "B1"
                IF squarefill(4) = 1 OR squarefill(4) = -1 THEN
                        GOTO 300
                ELSE
                        CIRCLE (150, 250), 25, 1
                        squarefill(4) = -1
                END IF
        CASE "B2"
                IF squarefill(9) = 1 OR squarefill(9) = -1 THEN
                        GOTO 300
                ELSE
                        CIRCLE (250, 250), 25, 1
                        squarefill(9) = -1
                END IF
        CASE "B3"
                IF squarefill(5) = 1 OR squarefill(5) = -1 THEN
                        GOTO 300
                ELSE
                        CIRCLE (350, 250), 25, 1
                        squarefill(5) = -1
                END IF
        CASE "C1"
                IF squarefill(6) = 1 OR squarefill(6) - 1 THEN
                        GOTO 300
                ELSE
                        CIRCLE (150, 350), 25, 1
                        squarefill(6) = -1
                END IF
        CASE "C2"
                IF squarefill(7) = 1 OR squarefill(7) = -1 THEN
                        GOTO 300
                ELSE
                        CIRCLE (250, 350), 25, 1
                        squarefill(7) = -1
                END IF
        CASE "C3"
                IF squarefill(8) = 1 OR squarefill(8) = -1 THEN
                        PRINT "Already filled.  Try again"
                        GOTO 300
                ELSE
                        CIRCLE (350, 350), 25, 1
                        squarefill(8) = -1
                END IF
        CASE ELSE
                GOTO 300
        END SELECT
      
turnlame = 0
SLEEP 1
LOCATE 7, 3
PRINT "  "
RESTORE 2001
FOR knot = 1 TO 24
READ a, b, c
IF squarefill(a) + squarefill(b) + squarefill(c) = -3 THEN GOSUB win
NEXT knot
IF drno = 5 THEN GOSUB tie


RESTORE 2001
FOR mrsno = 1 TO 24
READ d, e, f
IF squarefill(d) + squarefill(e) = 2 AND squarefill(f) = 0 THEN
DRAW x$(f)
DRAW xwing$
squarefill(f) = 1
turnlame = 1
END IF
NEXT mrsno

RESTORE 2001
FOR mistressno = 1 TO 24
READ g, h, i
IF squarefill(g) + squarefill(h) = -2 AND squarefill(i) = 0 AND turnlame = 0 THEN
DRAW x$(i)
DRAW xwing$
squarefill(i) = 1
turnlame = 1
END IF
NEXT mistressno

IF turnlame = 0 THEN
400 place = INT(RND * 8) + 1
    IF squarefill(place) = 0 THEN
        SLEEP 1
        DRAW x$(place)
        DRAW xwing$
        squarefill(place) = 1
    ELSE
        GOTO 400
    END IF
END IF

RESTORE 2001
FOR knoted = 1 TO 24
READ a, b, c
IF squarefill(a) + squarefill(b) + squarefill(c) = 3 THEN GOSUB lose
NEXT knoted
NEXT drno
STOP

lose:
SLEEP 1
SCREEN 7
CLS
FOR new = 1 TO 1500
LOCATE 1, 1, 0
COLOR new / 100
PRINT "You lose!"
NEXT new
SLEEP 1.5
GOSUB again
RETURN

win:
SLEEP 1
SCREEN 7
CLS
FOR n = 0 TO 1500
COLOR n / 100
LOCATE 1, 1, 0
COLOR n / 100
PRINT "You win!"
NEXT n
SLEEP 1.5
GOSUB again
RETURN

tie:
SLEEP 1
SCREEN 7
CLS
FOR n = 0 TO 1500
COLOR n / 100
LOCATE 1, 1, 0
PRINT "Tie game!"
NEXT n
SLEEP 1.5
GOSUB again
RETURN

again:
600 INPUT "Try again (y/n)"; againer$
SELECT CASE UCASE$(againer$)
CASE "Y"
        GOTO 50
CASE "N"
        PRINT "Thank you for playing"
        SLEEP 1
        'STOP
CASE ELSE
        BEEP
        GOTO 600
END SELECT
RETURN
END SUB

SUB titlescreen
RANDOMIZE TIMER
CLS
SCREEN 7
123 LINE (90, 48)-(230, 110), , BF
LINE (92, 50)-(228, 108), 0, BF
LOCATE 6, 18, 0
PRINT "Welcome"
LOCATE 8, 14, 0
PRINT "a: Tic-tac-toe"
LOCATE 10, 15, 0
PRINT "b: Math game"
LOCATE 12, 17, 0
PRINT "q: Quit"
LOCATE 25, 1, 0
PRINT "Written by Jon Miller"
SLEEP 1
78 prog$ = INKEY$
IF prog$ = "" THEN GOTO 78

SELECT CASE UCASE$(prog$)
CASE "A"
        tictactoe
CASE "B"
        game
CASE "Q"
        END
CASE ELSE
        GOTO 78
END SELECT
END SUB

