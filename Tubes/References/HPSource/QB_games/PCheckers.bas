'                PCheckers ver 1.1
'ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ--- ƒƒ ƒ
' A checker game that learns from its mistakes.
' This beta is equipped with
'
'     ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
'     ≥   ‹‹‹          ≥   ø ⁄                 ≥
'     ≥   ›ﬂﬁ check    ≥   ¿¬Ÿpros technology  ≥
'     ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
'
' Brought to your desktop by Chris McKenzie and Digital Reality
'
'   email:   mckenze@earthlink.net (as of 6-30-97)
'   website: http://www.geocities.com/siliconvalley/way/1790
'
'                           ATTENTION
'ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ--- ƒƒ ƒ
'To control....
'Turn numlock on             ¬ "5" CONFIRMS PLACE, DOUBLE JUMP   ¬
'                   8        ≥ NOT YET IMPLEMENTED.  [ESC] QUITS ≥
'                   ≥        ¡ PROGRAM, "V" TOGGLES VPROS.       ¡
'               4 ƒƒ≈ƒƒ 6
'                   ≥
'                   2
'
' The computer doesn't get timed when Vpros is hidden because
' it makes it the processing faster and its kind of pointless
' for the pc to be timed. When Vpros is hidden the processing
' time is cut in half.
'
' Changes from 1.O+
'
'  Processing time reduced to 1/4. You can hide Vpros while processing.
'
DECLARE SUB viewmisc ()
DECLARE SUB time ()
DECLARE SUB setup.opening ()
DECLARE SUB setup.draw ()
DECLARE SUB quit ()
DECLARE SUB process.memory ()
DECLARE SUB process.move.move ()
DECLARE SUB red.turn ()
DECLARE SUB process.move ()
DECLARE SUB process.move.jump ()
DECLARE SUB update ()

DIM SHARED red(1 TO 500)
DIM SHARED blue(1 TO 500)
DIM SHARED redcrown(1 TO 500)
DIM SHARED bluecrown(1 TO 500)
DIM SHARED board(8, 8)
DIM SHARED oldboard(8, 8)
DIM SHARED current(4)
DIM SHARED misc(10, 10)
DIM SHARED bluename(200)
DIM SHARED redname(200)

misc(4, 2) = 11
misc(5, 9) = 0
misc(5, 10) = 0
misc(6, 8) = 500
misc(6, 10) = 500
misc(7, 1) = 4
misc(7, 2) = 4
misc(9, 1) = 8
misc(9, 2) = 5

SCREEN 13
CLS
OPEN "c:\gamedbas.dat" FOR RANDOM AS #3
LOCATE 11, 13
COLOR 15
PRINT "Setting up..."
DO
 variable = variable + 1
 GET #3, variable, variablevalue
LOOP UNTIL EOF(3)
CLOSE #3
misc(8, 8) = variable

OPEN "c:\curgame.dat" FOR RANDOM AS #1
OPEN "c:\gamedbas.dat" FOR RANDOM AS #3

TYPE cboard
 location AS INTEGER
 memory AS INTEGER
 memorytransfer AS INTEGER
 check AS INTEGER
END TYPE

TYPE mboard
 blank AS INTEGER
 bad AS INTEGER
 place AS INTEGER
END TYPE

setup.opening
setup.draw

DO
 current(4) = 1
 update
 red.turn
 current(4) = 0
 update
 process.move
LOOP

SUB process.memory
IF misc(5, 4) = 1 THEN
LOCATE 28, 67
COLOR 12
PRINT misc(6, 8)
END IF

variable = 0
counter = 0

CLOSE #3
variable = misc(8, 8)

IF misc(5, 4) = 0 THEN
COLOR 15
 LOCATE 23, 64
  PRINT "Processing..."
 LOCATE 24, 63
  PRINT "Moves Processed"
ELSE
 LOCATE 24, 64
  COLOR 15
  PRINT "Processing..."
END IF

OPEN "c:\gamedbas.dat" FOR RANDOM AS #3

IF variable > 62 THEN
 DO
  count = 0
  IF misc(5, 4) = 0 THEN
  time
   LOCATE 25, 68
   COLOR 15
   PRINT counter
  END IF
FOR x% = 1 TO 8
KEY$ = INKEY$
IF KEY$ = CHR$(27) THEN
misc(2, 10) = 4
quit
END IF
IF UCASE$(KEY$) = "V" THEN
misc(5, 4) = ABS(misc(5, 4) - 1)
IF misc(5, 4) = 1 THEN
LOCATE 23, 63
PRINT "               "
COLOR 15
LOCATE 24, 63
PRINT " Processing... "'
LOCATE 25, 63
PRINT "              "
END IF
IF misc(5, 4) = 0 THEN
 COLOR 15
 LOCATE 23, 64
  PRINT "Processing..."
 LOCATE 24, 63
  PRINT "Moves Processed"
END IF
time
update
LOCATE 28, 67
COLOR 12
PRINT misc(6, 8)
END IF
    FOR y% = 2 TO 9
    LOCATE x% + 7, (y% - 1) * 2 + 61
     GET #3, x% * 8 + y% + counter * 82 - 1, cboard.memory
     IF cboard.memory - 2 = board(x%, y% - 1) THEN count = count + 1
     COLOR 7
     IF misc(5, 4) = 0 THEN
     IF (x% + 1 + y%) / 2 = (x% + 1 + y%) / 2 MOD 9 THEN COLOR 8
     IF cboard.memory - 2 = 1 THEN COLOR 1
     IF cboard.memory - 2 = 2 THEN COLOR 4
     IF cboard.memory - 2 = 3 THEN COLOR 9
     IF cboard.memory - 2 = 4 THEN COLOR 12
     PRINT "€€"
END IF
    NEXT y%
   NEXT x%
   counter = counter + 1
    IF count > 60 THEN
     misc(5, 10) = counter
     misc(9, 10) = 0
     misc(3, 1) = 1
    GOTO final
  END IF
 LOOP UNTIL EOF(3)
END IF
final:
LOCATE 23, 63
PRINT "               "
LOCATE 24, 63
PRINT "               "
LOCATE 25, 63
PRINT "               "
END SUB

SUB process.move
misc(5, 10) = -1
misc(6, 6) = 2
misc(9, 10) = 1
misc(8, 2) = 16
misc(3, 1) = 0
misc(10, 10) = 0
  FOR x% = 1 TO 8
   FOR y% = 1 TO 8
    oldboard(x%, y%) = board(x%, y%)
   NEXT y%
  NEXT x%

 current(3) = 0
reprocess:
misc(10, 10) = misc(10, 10) + 1
 process.memory
 FOR x% = 1 TO 8
  FOR y% = 1 TO 8
   mboard.bad = misc(9, 1)
   IF current(3) = 1 THEN GOTO ender1
    IF board(x%, y%) = 1 OR board(x%, y%) = 3 THEN
     misc(8, 2) = misc(8, 2) + 1
     current(1) = y%
     current(2) = x%
     IF misc(5, 10) <> -1 THEN
      GET #3, misc(8, 2) + 71 + ((misc(5, 10) - 1) * 82), CBOARD.CHECK
      IF CBOARD.CHECK = mboard.bad THEN GOTO NOMOVE
     END IF
     process.move.jump
    END IF

NOMOVE:
  NEXT y%
   NEXT x%

misc(8, 2) = 0
IF current(3) = 0 THEN
 FOR y% = 1 TO 8
  FOR x% = 1 TO 8
  mboard.bad = misc(9, 1)
  IF current(3) = 1 THEN GOTO ender1
   IF board(x%, y%) = 1 OR board(x%, y%) = 3 THEN
    misc(8, 2) = misc(8, 2) + 1
    current(1) = y%
    current(2) = x%
    IF misc(5, 10) <> -1 THEN
     GET #3, misc(8, 2) + 71 + ((misc(5, 10) - 1) * 82), CBOARD.CHECK
     IF CBOARD.CHECK = mboard.bad THEN GOTO nomove1
    END IF
    process.move.move
   END IF

nomove1:
  NEXT x%
 NEXT y%
END IF

ender1:
IF misc(10, 10) = 3 THEN
misc(2, 10) = 3
quit
END IF
IF current(3) = 0 THEN GOTO reprocess
SOUND 3700, .0228

END SUB

SUB process.move.jump
x% = current(2)
y% = current(1)
piecevalue = 1
IF board(x%, y%) = 1 THEN piecevalue = 1
IF board(x%, y%) = 3 THEN piecevalue = -1
FOR angle = piecevalue TO 1 STEP 2
 FOR side = -1 TO 1 STEP 2
  IF y% + side > 1 AND y% + side < 8 AND x% + angle * 2 < 9 AND x% + angle * 2 > 0 THEN
   IF board(x% + angle, y% + side) = 1 THEN GOTO nexter
   IF (board(x% + angle, y% + side) = 2 OR board(x% + angle, y% + side) = 4) THEN
    IF board(x% + angle * 2, y% + side * 2) = 0 THEN
    board(x% + angle * 2, y% + side * 2) = board(x%, y%)
    board(x%, y%) = 0
    board(x% + angle, y% + side) = 0
    current(3) = 1
    GOTO ender
    END IF
   END IF
  END IF

nexter:
 NEXT side
NEXT angle

ender:
END SUB

SUB process.move.move
x% = current(2)
y% = current(1)
piecevalue = 1
IF board(x%, y%) = 1 THEN piecevalue = 1
IF board(x%, y%) = 3 THEN piecevalue = -1
FOR angle = piecevalue TO 1 STEP 2
FOR side = -1 TO 1 STEP 2
IF y% + side > 0 AND y% + side < 9 AND x% + angle > 0 AND x% + angle < 9 THEN
IF board(x% + angle, y% + side) = 1 THEN GOTO anexter
IF board(x% + angle, y% + side) = 0 THEN
'IF misc(2, 1) < 1 AND board(x% - angle, y% - side) = 0 THEN GOTO anexter
board(x% + angle, y% + side) = board(x%, y%)
board(x%, y%) = 0
current(3) = 1
GOTO aender
END IF
END IF
anexter:
NEXT side
NEXT angle
aender:
END SUB

SUB quit
CLS
CLOSE
IF misc(2, 10) = 1 THEN turnout$ = "Blue wins."
IF misc(2, 10) = 2 THEN turnout$ = "Red wins."
IF misc(2, 10) = 3 THEN turnout$ = "Blue forfeits.  So Red wins!"
IF misc(2, 10) = 4 THEN turnout$ = "Red Forfeits.  So Blue wins!"
IF misc(2, 10) = 5 THEN turnout$ = "Blue ran out of time.  So Red wins!"
IF misc(2, 10) = 6 THEN turnout$ = "Red ran out of time.  So Blue winds!"
COLOR 15
COLOR 15
PRINT turnout$
FOR x% = 320 TO 0 STEP -1
FOR y% = 4 TO 0 STEP -1
IF POINT(x%, y%) = 15 THEN LINE (x% * 2, y%)-(x% * 2 + 1, y%), 15
IF POINT(x%, y%) = 0 THEN LINE (x% * 2, y%)-(x% * 2 + 1, y%), 0
NEXT y%
NEXT x%

FOR x% = 230 TO 0 STEP -1
FOR y% = 8 TO 5 STEP -1
IF POINT(x%, y%) = 15 THEN LINE (x% * 2, y%)-(x% * 2 + 1, y%), 14
IF POINT(x%, y%) = 0 THEN LINE (x% * 2, y%)-(x% * 2 + 1, y%), 0
NEXT y%
NEXT x%

FOR x% = 230 TO 0 STEP -1
FOR y% = 12 TO 9 STEP -1
IF POINT(x%, y%) = 15 THEN LINE (x% * 2, y%)-(x% * 2 + 1, y%), 11
IF POINT(x%, y%) = 0 THEN LINE (x% * 2, y%)-(x% * 2 + 1, y%), 0
NEXT y%
NEXT x%

LINE (0, 14)-(640, 14), 8
LINE (0, 15)-(640, 15), 7
LINE (0, 16)-(640, 16), 15
LINE (0, 17)-(640, 17), 7
LINE (0, 18)-(640, 18), 8

COLOR 12
LOCATE 3, 1
place = 1
COLOR 14
PRINT "You started at:"
COLOR 13
hours$ = MKI$(misc(5, 1))
LOCATE 3, 17
PRINT hours$
info = LEN(hours$)
LOCATE 3, 17 + info
PRINT ":"
LOCATE 3, 18 + info
minutes$ = MKI$(misc(5, 2))
PRINT minutes$
info1 = LEN(minutes$)
LOCATE 3, 18 + info + info1
PRINT ":"
LOCATE 3, 19 + info + info1
seconds$ = MKI$(misc(5, 3))
PRINT seconds$
COLOR 14
LOCATE 3, 40
PRINT "And ended at:"
LOCATE 3, 54
COLOR 13
PRINT TIME$
COLOR 12
LOCATE 5, 1
PRINT "Here's the fun part..."
PRINT "I take all the mistakes from that game and put it in a BIG database."
OPEN "c:\curgame.dat" FOR RANDOM AS #1
count = misc(8, 8)
OPEN "c:\gamedbas.dat" FOR RANDOM AS #2
IF count > 18 THEN count = count - 7
'IF count > 100 THEN count = count - 2
DO
 LOCATE 7, 10
 COLOR 11
 PRINT "Recalling"; place / 82 MOD 100; "moves."
 GET #1, place, cboard.memorytransfer
 PUT #2, place + count, cboard.memorytransfer
 place = place + 1
LOOP UNTIL (EOF(1))

COLOR 12
PRINT "Now I close the files and delete the evidence."
CLOSE #2
CLOSE #1
KILL "c:\curgame.dat"
PRINT "Hope to be more of a challenge for you next time."
COLOR 7
SHELL "dir c:\gamedbas.dat"
FOR x = 11 TO 13
LOCATE x, 1
PRINT "                                                         "
NEXT x
LOCATE 17, 1
PRINT "                                                         "
LOCATE 14, 1
PRINT "Here's what the main Mbase looks like as of now "
LOCATE 16, 1
PRINT "You know, that's"; misc(8, 8) + place; "lines of data totaling"; (misc(8, 8) + place) / 82 MOD 1000; "moves."
SYSTEM
END SUB

SUB red.turn
misc(6, 6) = 1
y% = misc(7, 1)
x% = misc(7, 2)
LINE ((x% - 1) * 57 + 12, (y% - 1) * 57 + 12)-((x% - 1) * 57 + 69, (y% - 1) * 57 + 69), 14, B
yold = y%
xold = x%
yoldplace = y%
xoldplace = x%
beginningagain:
variable = 1
LINE ((xoldplace - 1) * 57 + 13, (yoldplace - 1) * 57 + 13)-((xoldplace - 1) * 57 + 68, (yoldplace - 1) * 57 + 68), 8, B
DO
'x% = misc(1, 9)
'y% = misc(1, 10)
time

'misc(1, 9) = x%
'misc(1, 10) = y%
KEY$ = INKEY$
IF KEY$ = CHR$(27) THEN
misc(2, 10) = 4
quit
END IF
IF KEY$ = "1" AND y% < 8 AND x% > 1 THEN
y% = y% + 1
x% = x% - 1
END IF
IF KEY$ = "2" AND y% < 8 THEN y% = y% + 1
IF KEY$ = "3" AND y% < 8 AND x% < 8 THEN
y% = y% + 1
x% = x% + 1
END IF
IF KEY$ = "4" AND x% > 1 THEN x% = x% - 1
IF KEY$ = "5" AND (board(y%, x%) = 2 OR board(y%, x%) = 4) THEN
xoldplace = x%
yoldplace = y%
GOTO donewithold
END IF
IF KEY$ = "6" AND x% < 8 THEN x% = x% + 1
IF KEY$ = "7" AND y% > 1 AND x% > 1 THEN
y% = y% - 1
x% = x% - 1
END IF
IF KEY$ = "8" AND y% > 1 THEN y% = y% - 1
IF KEY$ = "9" AND y% > 1 AND x% < 8 THEN
y% = y% - 1
x% = x% + 1
END IF
IF UCASE$(KEY$) = "V" THEN
misc(5, 4) = ABS(misc(5, 4) - 1)
update
END IF
IF KEY$ <> "" THEN
LINE ((xold - 1) * 57 + 12, (yold - 1) * 57 + 12)-((xold - 1) * 57 + 69, (yold - 1) * 57 + 69), 8, B
LINE ((x% - 1) * 57 + 12, (y% - 1) * 57 + 12)-((x% - 1) * 57 + 69, (y% - 1) * 57 + 69), 14, B
yold = y%
xold = x%
END IF
LOOP

donewithold:
IF variable = 1 THEN LINE ((xold - 1) * 57 + 13, (yold - 1) * 57 + 13)-((xold - 1) * 57 + 68, (yold - 1) * 57 + 68), 14, B
yold1 = y%
xold1 = x%
variable = 0
DO
time
KEY$ = INKEY$
IF KEY$ = CHR$(27) THEN
misc(2, 10) = 4
quit
END IF
IF KEY$ = "1" AND y% < 8 AND x% > 1 THEN
y% = y% + 1
x% = x% - 1
END IF
IF KEY$ = "2" AND y% < 8 THEN y% = y% + 1
IF KEY$ = "3" AND y% < 8 AND x% < 8 THEN
y% = y% + 1
x% = x% + 1
END IF
IF KEY$ = "4" AND x% > 1 THEN x% = x% - 1
IF KEY$ = "5" THEN GOTO donewithnew
IF KEY$ = "6" AND x% < 8 THEN x% = x% + 1
IF KEY$ = "7" AND y% > 1 AND x% > 1 THEN
y% = y% - 1
x% = x% - 1
END IF
IF KEY$ = "8" AND y% > 1 THEN y% = y% - 1
IF KEY$ = "9" AND y% > 1 AND x% < 8 THEN
y% = y% - 1
x% = x% + 1
END IF
IF UCASE$(KEY$) = "V" THEN
misc(5, 4) = ABS(misc(5, 4) - 1)
update
LINE ((xold1 - 1) * 57 + 13, (yold1 - 1) * 57 + 13)-((xold1 - 1) * 57 + 68, (yold1 - 1) * 57 + 68), 14, B
END IF
IF KEY$ <> "" THEN
LINE ((xold - 1) * 57 + 12, (yold - 1) * 57 + 12)-((xold - 1) * 57 + 69, (yold - 1) * 57 + 69), 8, B
LINE ((x% - 1) * 57 + 12, (y% - 1) * 57 + 12)-((x% - 1) * 57 + 69, (y% - 1) * 57 + 69), 14, B
yold = y%
xold = x%
END IF
LOOP
donewithnew:
xnewplace = x%
ynewplace = y%
misc(7, 1) = y%
misc(7, 2) = x%
piecevalue = board(yoldplace, xoldplace)

IF (xnewplace + ynewplace) / 2 <> (xnewplace + ynewplace) / 2 MOD 64 THEN GOTO donewithold
IF yoldplace > ynewplace THEN yfactor = -1
IF yoldplace < ynewplace THEN yfactor = 1
xredplace = (xoldplace - xnewplace) / 2 + xnewplace
IF (board(yoldplace + yfactor, xredplace) = 1 OR board(yoldplace + yfactor, xredplace) = 3) AND ((((xnewplace - xoldplace) = -2 OR (xnewplace - xoldplace) = 2) AND (ynewplace - yoldplace) = -2 AND piecevalue = 2) OR (((xnewplace - xoldplace) = -2 OR _
 (xnewplace - xoldplace) = 2) AND ((ynewplace - yoldplace) = -2 OR (ynewplace - yoldplace) = 2) AND piecevalue = 4)) AND board(ynewplace, xnewplace) = 0 THEN
board(yoldplace + yfactor, xredplace) = 0
piecevalue = board(yoldplace, xoldplace)
board(yoldplace, xoldplace) = 0
board(ynewplace, xnewplace) = piecevalue
xoldplace = x%
yoldplace = y%
yoldplace = misc(1, 1)
ynewplace = misc(1, 2)
xoldplace = misc(1, 3)
xnewplace = misc(1, 4)
update
misc(1, 1) = yoldplace
misc(1, 2) = ynewplace
misc(1, 3) = xoldplcae
misc(1, 4) = xnewplace
GOTO done
GOTO donewithold
END IF
piecevalue = board(yoldplace, xoldplace)
IF (board(ynewplace, xnewplace) = 2 OR board(ynewplace, xnewplace) = 4) THEN GOTO beginningagain
IF (xoldplace - xnewplace) > 1 OR (xoldplace - xnewplace) < -1 OR (yoldplace - ynewplace) > 1 OR ((yoldplace - ynewplace) < 0 AND piecevalue = 2) OR ((yoldplace - ynewplace) < -1 AND piecevalue = 4) OR board(ynewplace, xnewplace) = 1 THEN GOTO  _
donewithold
IF piecevalue = 2 AND ((board(yoldplace, xoldplace) = 2 OR board(yoldplace, xoldplace) = 4) AND ynewplace > yoldplace) THEN GOTO donewithold
done:
board(yoldplace, xoldplace) = 0
board(ynewplace, xnewplace) = piecevalue
misc(7, 1) = y%
misc(7, 2) = x%
LINE ((xold - 1) * 57 + 12, (yold - 1) * 57 + 12)-((xold - 1) * 57 + 69, (yold - 1) * 57 + 69), 8, B

SOUND 3700, .0228
END SUB

SUB setup.draw
SCREEN 12
LINE (0, 0)-(56, 56), 4, BF
FOR count% = 0 TO 1
FOR x% = count% TO 56 STEP 2
FOR y% = count% TO 56 STEP 2
PSET (x%, y%), 12
NEXT y%
NEXT x%
NEXT count%
CIRCLE (28, 28), 25, 3
PAINT (0, 0), 8, 3
PAINT (50, 0), 8, 3
PAINT (0, 50), 8, 3
PAINT (50, 50), 8, 3
CIRCLE (28, 28), 25, 4
GET (0, 0)-(56, 56), red
CIRCLE (28, 35), 12, 14, , , .25
PAINT (28, 35), 14, 14
LINE (15, 21)-(15, 35), 14
LINE (41, 21)-(41, 35), 14
FOR x% = 1 TO 3
LINE (x% * 8 + 12, 25)-(x% * 8 + 16, 21), 14
LINE (x% * 8 + 8, 21)-(x% * 8 + 12, 25), 14
NEXT x%
PAINT (19, 29), 14, 14
FOR count% = 0 TO 1
FOR x% = count% TO 20 STEP 2
FOR y% = count% TO 56 STEP 2
IF POINT(x%, y%) = 14 THEN PSET (x%, y%), 7
NEXT y%
NEXT x%
FOR x% = count% + 35 TO 56 STEP 2
FOR y% = count% TO 56 STEP 2
IF POINT(x%, y%) = 14 THEN PSET (x%, y%), 15
NEXT y%
NEXT x%
NEXT count%
GET (0, 0)-(56, 56), redcrown

CLS
LINE (0, 0)-(56, 56), 1, BF
FOR count% = 0 TO 1
FOR x% = count% TO 56 STEP 2
FOR y% = count% TO 56 STEP 2
PSET (x%, y%), 9
NEXT y%
NEXT x%
NEXT count%
CIRCLE (28, 28), 25, 2
PAINT (0, 0), 8, 2
PAINT (50, 0), 8, 2
PAINT (0, 50), 8, 2
PAINT (50, 50), 8, 2
CIRCLE (28, 28), 25, 1
GET (0, 0)-(56, 56), blue
CIRCLE (28, 35), 12, 14, , , .25
PAINT (28, 35), 14, 14
LINE (15, 21)-(15, 35), 14
LINE (41, 21)-(41, 35), 14
FOR x% = 1 TO 3
LINE (x% * 8 + 12, 25)-(x% * 8 + 16, 21), 14
LINE (x% * 8 + 8, 21)-(x% * 8 + 12, 25), 14
NEXT x%
PAINT (19, 29), 14, 14
FOR count% = 0 TO 1
FOR x% = count% TO 20 STEP 2
FOR y% = count% TO 56 STEP 2
IF POINT(x%, y%) = 14 THEN PSET (x%, y%), 7
NEXT y%
NEXT x%
FOR x% = count% + 35 TO 56 STEP 2
FOR y% = count% TO 56 STEP 2
IF POINT(x%, y%) = 14 THEN PSET (x%, y%), 15
NEXT y%
NEXT x%
NEXT count%
GET (0, 0)-(56, 56), bluecrown

CLS
FOR count% = 0 TO 1
FOR x% = count% TO 8 STEP 2
FOR y% = count% TO 3 STEP 2
board(y%, x%) = 1
NEXT y%
NEXT x%
NEXT count%
board(2, 4) = 1
FOR count% = 0 TO 1
FOR x% = count% TO 8 STEP 2
FOR y% = count% + 6 TO 8 STEP 2
board(y%, x%) = 2
NEXT y%
NEXT x%
NEXT count%
LINE (11, 11)-(469, 469), 7, BF
LINE (12, 12)-(468, 468), 8, B
LOCATE 1, 68
PRINT "Turn:"
LINE (495, 25)-(618, 55), 15, B
LOCATE 27, 68
COLOR 11
PRINT "Time"
LOCATE 28, 70
PRINT "≥"
LOCATE 28, 62
PRINT "≥"
timer$ = TIME$
hours$ = LEFT$(timer$, 2)
seconds$ = RIGHT$(timer$, 2)
secondtime$ = RIGHT$(timer$, 5)
minutes$ = LEFT$(secondtime$, 2)
hours = CVI(hours$)
minutes = CVI(minutes$)
seconds = CVI(seconds$)
misc(5, 1) = hours
misc(5, 2) = minutes
misc(5, 3) = seconds
END SUB

SUB setup.opening
CLS
LINE (25, 50)-(299, 99), 24, BF
FOR NUMER = 0 TO 12 STEP 12
FOR x% = 25 + NUMER TO 275 + NUMER STEP 25
FOR y% = 50 + NUMER TO 75 + NUMER STEP 25
FOR NUBER = 0 TO 3
LINE (x% + NUBER, y% + NUBER)-(x% + 12 - NUBER, y% + 12 - NUBER), 18 + NUBER, BF
NEXT NUBER
NEXT y%
NEXT x%
NEXT NUMER
COLOR 16
text$ = "Checkers"
PRINT text$
FOR x% = LEN(text$) * 8 TO 0 STEP -1
FOR y% = 0 TO 10
IF POINT(x%, y%) = 16 THEN
colora = POINT(x%, y%)
LINE (2 * x% + 20, 2 * y% + 20)-(2 * x% + 21, 2 * y% + 21), 16, BF
IF POINT(x% + 1, y% + 1) = 16 THEN
PSET (2 * x% + 22, 2 * y% + 21), colora
END IF
IF POINT(x% - 1, y% + 1) = 16 THEN
PSET (2 * x% + 19, 2 * y% + 21), colora
END IF
IF POINT(x% + 1, y% - 1) = 16 THEN
PSET (2 * x% + 22, 2 * y% + 20), colora
END IF
IF POINT(x% - 1, y% - 1) = 16 THEN
PSET (2 * x% + 19, 2 * y% + 20), colora
END IF
END IF
NEXT y%
NEXT x%
FOR await = 1 TO 10000
NEXT await
FOR I = 1 TO 13
FOR await = 1 TO 500
NEXT await
LOCATE 1, 14
COLOR 23
PRINT "Version 1.1"
FOR x% = LEN(text$) * 8 * 2 + 20 TO 0 STEP -1
FOR y% = 20 TO 40
IF POINT(x%, y%) > 4 THEN
IF POINT(2 * x%, 2 * y% + 20) < 31 THEN LINE (2 * x%, 2 * y% + 20)-(2 * x% + 1, 2 * y% + 21), POINT(2 * x%, 2 * y% + 20) + 1, BF
IF POINT(x% + 1, y% + 1) > 0 AND POINT(2 * x% + 2, 2 * y% + 21) < 31 THEN
PSET (2 * x% + 2, 2 * y% + 21), POINT(2 * x% + 2, 2 * y% + 21) + 1
END IF
IF POINT(x% - 1, y% + 1) > 0 AND POINT(2 * x% - 1, 2 * y% + 21) < 31 THEN
PSET (2 * x% - 1, 2 * y% + 21), POINT(2 * x% - 1, 2 * y% + 21) + 1
END IF
IF POINT(x% + 1, y% - 1) > 0 AND POINT(2 * x% + 2, 2 * y% + 20) < 31 THEN
PSET (2 * x% + 2, 2 * y% + 20), POINT(2 * x% + 2, 2 * y% + 20) + 1
END IF
IF POINT(x% - 1, y% - 1) > 0 AND POINT(2 * x% - 1, 2 * y% + 20) < 31 THEN
PSET (2 * x% - 1, 2 * y% + 20), POINT(2 * x% - 1, 2 * y% + 20) + 1
END IF
END IF
NEXT y%
NEXT x%
NEXT I

FOR x% = 18 TO 31
LOCATE 20, 10
COLOR x%
FOR await% = 1 TO 750
IF INKEY$ = CHR$(27) THEN GOTO aaend
NEXT await%
PRINT "By Chris McKenzie"
NEXT x%

FOR await = 1 TO 1001
IF INKEY$ = CHR$(27) THEN GOTO aaend
NEXT await

FOR x% = 31 TO 18 STEP -1
LOCATE 20, 10
COLOR x%
FOR await = 1 TO 750
IF INKEY$ = CHR$(27) THEN GOTO aaend
NEXT await
PRINT "By Chris McKenzie"
NEXT x%
aaend:
SCREEN 12
END SUB

SUB time
times = 60 / 200
IF misc(6, 6) = 1 THEN
startime$ = TIME$
startsecond = VAL(RIGHT$(startime$, 2))
IF misc(6, 7) <> startsecond THEN
SOUND 7500, .0228
misc(6, 8) = misc(6, 8) - 1
END IF
IF misc(5, 4) = 0 THEN
LOCATE 28, 64
ELSE
LOCATE 28, 67
END IF
COLOR 12
PRINT misc(6, 8)

misc(6, 7) = startsecond
IF misc(6, 8) = 0 THEN
misc(2, 10) = 6
quit
END IF
END IF

IF misc(6, 6) = 2 THEN
startime$ = TIME$
startsecond = VAL(RIGHT$(startime$, 2))
IF misc(6, 9) <> startsecond THEN
SOUND 7500, .0228
misc(6, 10) = misc(6, 10) - 1
END IF
LOCATE 28, 72
COLOR 9
PRINT misc(6, 10)

IF misc(6, 10) = 0 THEN
misc(2, 10) = 5
quit
END IF
misc(6, 9) = startsecond
END IF

END SUB

SUB update
blue = 0
bluecrown = 0
red = 0
redcrown = 0

FOR a = 1 TO 8
 IF board(8, a) = 1 THEN board(8, a) = 3
 IF board(1, a) = 2 THEN board(1, a) = 4
NEXT a

FOR x% = 1 TO 8
 FOR y% = 1 TO 8
  LOCATE x% + 7, y% * 2 + 61
  COLOR 7
IF (x% + y%) / 2 = (x% + y%) / 2 MOD 9 THEN COLOR 8
 
  IF board(x%, y%) = 2 THEN
   red = red + 1
   COLOR 4
  END IF
 
  IF board(x%, y%) = 1 THEN
   blue = blue + 1
   COLOR 1
  END IF
 
  IF board(x%, y%) = 3 THEN
   bluecrown = bluecrown + 1
   COLOR 9
  END IF
 
  IF board(x%, y%) = 4 THEN
   redcrown = redcrown + 1
   COLOR 12
  END IF
 
  PRINT "€€"

 NEXT y%
NEXT x%

mboard.bad = misc(9, 1)
mboard.blank = misc(9, 2)
misc(4, 1) = bluecrown + blue
IF misc(4, 1) < misc(4, 2) THEN
IF misc(9, 10) = 1 THEN
 FOR x% = 1 TO 8
   FOR y% = 0 TO 7
   cboard.location = oldboard(x%, y% + 1) + 2
   PUT #1, 8 * x% + y% + (misc(5, 9) * 82), cboard.location
  NEXT y%
 NEXT x%
FOR x% = 1 TO 16
 PUT #1, x% + 71 + (misc(5, 9) * 82), mboard.blank
NEXT x%
 PUT #1, 72 + (misc(5, 9) * 82), mboard.bad
misc(5, 9) = misc(5, 9) + 1
END IF

IF misc(5, 10) <> -1 THEN
'  FOR x% = 0 TO 18
'   GET #3, 73 + x% + ((misc(5, 10) - 1) * 82), mboard.place
'   IF mboard.place <> mboard.bad THEN PUT #3, 73 + x% + ((misc(5, 10) - 1) * 82), mboard.blank
'  NEXT x%

IF misc(3, 1) = 1 THEN
FOR x% = 0 TO 18
 GET #3, 73 + x% + ((misc(5, 10) - 1) * 82), mboard.place
 IF mboard.place = mboard.bad THEN GOTO nextx
 IF mboard.place <> mboard.bad THEN PUT #3, 73 + x% + ((misc(5, 10) - 1) * 82), mboard.bad
 GOTO endx

nextx:
 NEXT x%

endx:
END IF
END IF
END IF

misc(4, 2) = bluecrown + blue

COLOR 9
 LOCATE 18, 63
  PRINT "Blue - "; blue
 LOCATE 19, 63
  PRINT "  Kings -"; bluecrown

COLOR 12
 LOCATE 21, 63
  PRINT "Red  - "; red
 LOCATE 22, 63
  PRINT "  Kings -"; redcrown

IF red + redcrown = 0 THEN
 misc(2, 10) = 1
 quit
END IF

IF blue + bluecrown = 0 THEN
 misc(2, 10) = 2
 quit
END IF

FOR count% = 1 TO 2
 FOR x% = count% TO 8 STEP 2
  FOR y% = count% TO 8 STEP 2
   IF board(y%, x%) = 0 THEN
    LINE ((x% - 1) * 57 + 12, (y% - 1) * 57 + 12)-((x% - 1) * 57 + 69, (y% - 1) * 57 + 69), 8, BF
   END IF
   IF board(y%, x%) = 1 THEN
    PUT ((x% - 1) * 57 + 12, (y% - 1) * 57 + 12), blue, PSET
   END IF
   IF board(y%, x%) = 2 THEN
    PUT ((x% - 1) * 57 + 12, (y% - 1) * 57 + 12), red, PSET
   END IF
   IF board(y%, x%) = 3 THEN
    PUT ((x% - 1) * 57 + 12, (y% - 1) * 57 + 12), bluecrown, PSET
   END IF
   IF board(y%, x%) = 4 THEN
    PUT ((x% - 1) * 57 + 12, (y% - 1) * 57 + 12), redcrown, PSET
   END IF
  NEXT y%
 NEXT x%
NEXT count%

LINE (496, 26)-(617, 54), 0, BF

IF current(4) = 0 THEN
LOCATE 3, 63
COLOR 1
PRINT "Blue"
FOR x% = 537 TO 496 STEP -1
FOR y% = 26 TO 54
IF POINT(x%, y%) = 1 THEN
PSET (x%, y%), 0
LINE (2 * (x% - 496) + 522, y%)-(2 * (x% - 496) + 523, y%), 9
END IF
NEXT y%
NEXT x%
END IF

IF current(4) = 1 THEN
LOCATE 3, 63
COLOR 4
PRINT "Red"
FOR x% = 537 TO 496 STEP -1
FOR y% = 26 TO 54
IF POINT(x%, y%) = 4 THEN
PSET (x%, y%), 0
LINE (2 * (x% - 496) + 532, y%)-(2 * (x% - 496) + 533, y%), 12
END IF
NEXT y%
NEXT x%
END IF

COLOR 15
LOCATE 7, 63
PRINT "V"
COLOR 11
LOCATE 7, 64
PRINT "Pros is"
COLOR 12
IF misc(5, 4) = 1 THEN
LOCATE 7, 72
PRINT "hidden"
LOCATE 28, 63
PRINT "               "
LOCATE 27, 72
PRINT " "
END IF
IF misc(5, 4) = 0 THEN
LOCATE 7, 72
PRINT "shown "
LOCATE 27, 72
COLOR 11
PRINT "s"
LOCATE 28, 69
PRINT "         "
LOCATE 28, 78
PRINT "≥"
LOCATE 28, 70
PRINT "≥"
END IF
END SUB

