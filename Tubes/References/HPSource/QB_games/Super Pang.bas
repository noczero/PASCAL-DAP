'          S U P E R           P A N G                                  '96
'        ÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷
'
'                                                  SHAREWARE V1.0
'                                           
'       WARNING   ! This program only run under the speed of 120-133 Mz
'                       otherwise please change the number in the sub
'                         "DELAY"
'
'
'
'   HEAD PROGRAMMER : Cheng-ning Pu
'   GRAPHIC : Cheng-ning Pu
'
'   ! Contact the programmer (pu@carib-link.net) for the double player
'   ! version
'

DECLARE SUB delay ()
ON PLAY(1) GOSUB mus

PLAY OFF
RANDOMIZE TIMER
score1 = 0
score2 = 0
DIM SHARED player1, player2, x, y
SCREEN 9
CLS
LOCATE 1, 30: PRINT "S U P E R   P A N G   !"
FOR j = 30 TO 600 STEP 10
FOR i = 1 TO 15 STEP 3
CIRCLE (j, 30), i
NEXT i
NEXT j

'FOR j = 30 TO 300 STEP 10
'FOR i = 1 TO 15 STEP 3
'CIRCLE (30, j), i
'NEXT i
'NEXT j

FOR j = 30 TO 600 STEP 10
FOR i = 1 TO 15 STEP 3
CIRCLE (j, 300), i
NEXT i
NEXT j

'FOR j = 30 TO 300 STEP 10
'FOR i = 1 TO 15 STEP 3
'CIRCLE (600, j), i
'NEXT i
'NEXT j

x = 300
y = 150
up = 0
down = 1
right = 1
r = 1
u = 1

player1 = 150
player2 = 150


LINE (60, player1)-(60, player1 + 30), 14
LINE (570, player2)-(570, player2 + 30), 14


DO
IF right = 1 THEN x = x + r ELSE x = x - r
IF down = 1 THEN y = y + u ELSE y = y - u
CIRCLE (x, y), 3, 7
IF y > 280 THEN
down = 0
up = 1
r = INT(RND * 5) + 1
END IF
IF y < 45 THEN
down = 1
up = 0
r = INT(RND * 5) + 1
END IF


IF x > 570 THEN

right = 0
u = INT(RND * 5) + 1

 

IF y < player2 OR y > player2 + 35 THEN

FOR j = 1 TO 3
FOR i = 50 TO 200 STEP 5
'SOUND i, .1
NEXT i
NEXT j

score1 = score1 + 1
LOCATE 10, 30: PRINT "PLAYER 1 WIN! "
LOCATE 11, 30: PRINT "press <SPACE>..."
SLEEP
100
k$ = INKEY$
IF k$ <> " " THEN GOTO 100
LOCATE 10, 30: PRINT "             "
LOCATE 11, 30: PRINT "               "



END IF
END IF

IF x < 60 THEN
right = 1
u = INT(RND * 5) + 1

IF y < player1 OR y > player1 + 35 THEN

FOR j = 1 TO 3
FOR i = 50 TO 200 STEP 5
'SOUND i, .1
NEXT i
NEXT j

score2 = score2 + 1
LOCATE 10, 30: PRINT "PLAYER 2 WIN"
LOCATE 11, 30: PRINT "press <space>.."
SLEEP
DO
k$ = INKEY$
LOOP UNTIL k$ = " "
LOCATE 10, 30: PRINT "             "
LOCATE 11, 30: PRINT "               "

END IF
END IF

CALL delay
CIRCLE (x, y), 3, 0

 

LOCATE 1, 1: PRINT "SCORE : "; score1
LOCATE 1, 70: PRINT "SCORE : "; score2
IF score1 = 9 OR score2 = 9 THEN
LOCATE 7, 15: PRINT "SCORE : "; score1
LOCATE 7, 59: PRINT "SCORE : "; score2
LOCATE 10, 34: PRINT "PLAYER ";
IF score1 > score2 THEN PRINT "1 WIN!" ELSE PRINT "2 WIN!"
END
END IF
k$ = INKEY$
IF k$ <> "" THEN
SELECT CASE k$
CASE CHR$(0) + "H"
'IF player1 > 45 THEN player1 = player1 - 30
CASE CHR$(0) + "P"
'IF player1 < 255 THEN player1 = player1 + 30
CASE "w", "W"
IF player2 > 45 THEN player2 = player2 - 30
CASE "S", "s"
IF player2 < 255 THEN player2 = player2 + 30
END SELECT


LINE (60, 25)-(60, 275 + 30), 0
LINE (570, 25)-(570, 275 + 30), 0


LINE (60, player1)-(60, player1 + 30), 14
LINE (570, player2)-(570, player2 + 30), 14
END IF

IF player1 > 45 AND player1 + 10 > y THEN player1 = player1 - 10
IF player1 < 255 AND player1 + 10 < y THEN player1 = player1 + 10
                               LINE (60, 25)-(60, 275 + 30), 0
                               LINE (60, player1)-(60, player1 + 30), 14
LOOP

mus:
PLAY ""
RETURN

SUB delay

FOR i = 1 TO 600

k$ = INKEY$
IF k$ <> "" THEN
SELECT CASE k$
CASE "w", "W"
'IF player1 > 45 THEN player1 = player1 - 10
CASE "S", "s"
'IF player1 < 255 THEN player1 = player1 + 10
CASE CHR$(0) + "H"
IF player2 > 45 THEN player2 = player2 - 10
CASE CHR$(0) + "P"
IF player2 < 255 THEN player2 = player2 + 10
END SELECT

LINE (60, 25)-(60, 275 + 30), 0
LINE (570, 25)-(570, 275 + 30), 0


LINE (60, player1)-(60, player1 + 30), 14
LINE (570, player2)-(570, player2 + 30), 14
END IF

IF i MOD 200 = 0 THEN
 IF player1 > 45 AND player1 + 10 > y THEN
   player1 = player1 - 10
   LINE (60, 25)-(60, 275 + 30), 0
   LINE (60, player1)-(60, player1 + 30), 14
 END IF

 IF player1 < 255 AND player1 + 10 < y THEN
   player1 = player1 + 10
   LINE (60, 25)-(60, 275 + 30), 0
   LINE (60, player1)-(60, player1 + 30), 14
 END IF
END IF

NEXT i
 

END SUB

