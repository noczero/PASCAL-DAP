' just a bit of madness from Jim Emptage of Rouge Valley Software
' a crazy game of snakes and ladders
' you do not actually play the game ..... just kind of bet on the winner
' still, it does contain a cute dice roller and some neat paint ideas
' NOT TO BE USED FOR GAMBLING
' if passed around, leave these comments in: thanks
' 75504.2526@compuserve.com


DECLARE SUB ENDER ()
DECLARE SUB jumper1 ()
DECLARE SUB jumper2 ()
DECLARE SUB updown ()
DECLARE SUB movemen ()
DECLARE SUB roll ()
DECLARE SUB dilocate ()
DEFINT A-Z
DECLARE SUB mouse (m0%, m1%, m2%, m3%)
DECLARE SUB hidemouse ()
DECLARE SUB showmouse ()
DECLARE SUB getmxy (mx%, my%)
DECLARE SUB setmxy (mx%, my%)
DECLARE SUB mborders (x%, y%, h%, v%)
DECLARE FUNCTION mbtn% ()
COMMON SHARED dr1%, dr2%, dix1, diy1, dix2, diy2, p1x, p1y, p2x, p2y, player, phit
COMMON SHARED t1x, t1y, t2x, t2y, www
99
CLEAR
RESTORE
DIM SHARED pic1(5, 5) AS INTEGER
DIM SHARED pic2(5, 5) AS INTEGER

ON ERROR GOTO errs
CLS
SCREEN 13
n = 15
xmin = 10
xmax = 310
ymin = 10
ymax = 170
FOR mx = xmin TO xmax STEP n
  FOR my = ymin TO ymax STEP n
    px = mx - (mx MOD n)
    py = my - (my MOD n)
    IF px > xmin - 1 AND py > ymin - 1 AND px < xmax + 1 AND py < ymax + 1 THEN
      LINE (px, py)-(px + n, py + n), 220, B
    END IF
  NEXT
NEXT
LINE (280, 180)-(300, 180), 1
LINE (280, 188)-(300, 188), 4
FOR mx = 15 TO 315
  FOR my = 15 TO 165
    IF POINT(mx, my) = 0 THEN
      clr = 17 + (ABS(mx - 160) + ABS(my - 100)) MOD 10
      IF clr < 22 THEN clr = (27 - clr) + 17
      PSET (mx, my), clr
    ELSE
      clr = 17 + ABS(((mx MOD 17) - (my MOD 37)) MOD 13)
      IF clr < 22 THEN clr = (30 - clr) + 17
      PSET (mx, my), clr
      
    END IF
  NEXT
NEXT
t1x = 20 * 15
t1y = 10 * 15
FOR mx = 0 TO 5
  FOR my = 0 TO 5
    pic1(mx, my) = POINT(t1x + 5 + mx, t1y + 1 + my)
  NEXT
NEXT
t2x = 20 * 15
t2y = 10 * 15
FOR mx = 0 TO 5
  FOR my = 0 TO 5
    pic2(mx, my) = POINT(t2x + 5 + mx, t2y + 9 + my)
  NEXT
NEXT

COLOR 1
LOCATE 23, 30
PRINT "ladder";
COLOR 4
LOCATE 24, 30
PRINT "snake";
TYPE squares
  x1 AS INTEGER
  y1 AS INTEGER
  x2 AS INTEGER
  y2 AS INTEGER
END TYPE
DIM SHARED sam(23) AS squares
FOR m = 1 TO 23
READ sam(m).x1: READ sam(m).y1: READ sam(m).x2: READ sam(m).y2:
  IF m < 13 THEN
    CIRCLE (sam(m).x1 * 15 + 7, sam(m).y1 * 15 + 7), 3, 1
    PAINT (sam(m).x1 * 15 + 7, sam(m).y1 * 15 + 7), 1, 1
    CIRCLE (sam(m).x2 * 15 + 7, sam(m).y2 * 15 + 7), 3, 1
    PAINT (sam(m).x2 * 15 + 7, sam(m).y2 * 15 + 7), 1, 1
    LINE (sam(m).x1 * 15 + 7, sam(m).y1 * 15 + 7)-(sam(m).x2 * 15 + 7, sam(m).y2 * 15 + 7), 1
  END IF
  IF m >= 13 THEN
    CIRCLE (sam(m).x1 * 15 + 7, sam(m).y1 * 15 + 7), 3, 4
    PAINT (sam(m).x1 * 15 + 7, sam(m).y1 * 15 + 7), 4, 4
    CIRCLE (sam(m).x2 * 15 + 7, sam(m).y2 * 15 + 7), 3, 4
    PAINT (sam(m).x2 * 15 + 7, sam(m).y2 * 15 + 7), 4, 4
    LINE (sam(m).x1 * 15 + 7, sam(m).y1 * 15 + 7)-(sam(m).x2 * 15 + 7, sam(m).y2 * 15 + 7), 4
    
  END IF
NEXT

xmin = 10
xmax = 310
ymin = 10
ymax = 170
COLOR 40
LOCATE 1, 30
PRINT "R-V-S ";
COLOR 50
PRINT "1997";
COLOR 90
LOCATE 1, 1
PRINT " ANY KEY TO START ";
WHILE INKEY$ <> ""
WEND
DO
LOOP WHILE INKEY$ = ""
COLOR 0
LOCATE 1, 1
PRINT "                  ";
CALL dilocate
LINE (20 * 15 + 5, 10 * 15 + 1)-(20 * 15 + 10, 10 * 15 + 6), 14, BF
LINE (20 * 15 + 5, 10 * 15 + 9)-(20 * 15 + 10, 10 * 15 + 14), 13, BF

p1x = 20
p1y = 10
p2x = 20
p2y = 10
DO
  CALL movemen
  IF www = 1 THEN EXIT DO
LOOP
LOCATE 25, 1
COLOR 100
PRINT " PRESS 1-AGAIN 2-QUIT";
DO
  C$ = INPUT$(1)
  IF C$ = "2" THEN CALL ENDER
  IF C$ = "1" THEN GOTO 99
LOOP

ladders:
DATA 17,10,16,9
DATA 11,10,13,8
DATA 7,10,10,6
DATA 4,9,1,7
DATA 15,9,17,7
DATA 4,8,2,6
DATA 6,7,5,3
DATA 15,7,13,4
DATA 1,5,2,4
DATA 9,5,12,2
DATA 16,5,18,3
DATA 2,3,4,2

snakes:
DATA 2,1,15,10
DATA 8,1,8,3
DATA 17,1,16,6
DATA 20,2,20,4
DATA 10,2,13,7
DATA 13,3,20,7
DATA 8,4,3,6
DATA 13,5,5,9
DATA 2,7,1,10
DATA 18,8,19,10
DATA 19,5,14,8
100
END
errs:
CLS
SCREEN 0
WIDTH 80, 25
COLOR 7
PRINT "error of unknown type ...."
PRINT "are files s&l.grh and s&l4.exe (or bas) both present?"
PRINT "all files in the current dos directory?"
PRINT
PRINT "press any key ... to exit"
WHILE INKEY$ <> ""
WEND
DO
LOOP WHILE INKEY$ = ""
RESUME 100

SUB dilocate
PSET (15, 166)
DRAW "s60dbr"
dix1 = POINT(0)
diy1 = POINT(1)
DRAW "c4blud2r2u2l2"
PSET (47, 166)
DRAW "s60dbr"
dix2 = POINT(0)
diy2 = POINT(1)
DRAW "c4blud2r2u2l2"

END SUB

SUB ENDER
CLS
SCREEN 0
WIDTH 80, 25
COLOR 7
LOCATE 5, 1
PRINT "Rouge Valley Software"
PRINT "1997"
PRINT "75504.2526@compuserve.com"
PRINT ""
PRINT "Programmed in Qbasic:  a great hobby!"
PRINT ""
PRINT "Press Any Key ..."
WHILE INKEY$ <> ""
WEND
DO
LOOP WHILE INKEY$ = ""
END
END SUB

SUB jumper1
FOR mx = 0 TO 5
  FOR my = 0 TO 5
    PSET (t1x + 5 + mx, t1y + 1 + my), pic1(mx, my)
  NEXT
NEXT
t1x = p1x * 15
t1y = p1y * 15
FOR mx = 0 TO 5
  FOR my = 0 TO 5
    pic1(mx, my) = POINT(t1x + 5 + mx, t1y + 1 + my)
    PSET (t1x + 5 + mx, t1y + 1 + my), 14
  NEXT
NEXT
phit = 0
END SUB

SUB jumper2
FOR mx = 0 TO 5
  FOR my = 0 TO 5
    PSET (t2x + 5 + mx, t2y + 9 + my), pic2(mx, my)
  NEXT
NEXT
t2x = p2x * 15
t2y = p2y * 15
FOR mx = 0 TO 5
  FOR my = 0 TO 5
    pic2(mx, my) = POINT(t2x + 5 + mx, t2y + 9 + my)
    PSET (t2x + 5 + mx, t2y + 9 + my), 13
  NEXT
NEXT
phit = 0
END SUB

SUB movemen
IF chxx = 0 THEN
  t1x = p1x * 15
  t1y = p1y * 15
  FOR mx = 0 TO 5
    FOR my = 0 TO 5
      PSET (t1x + 5 + mx, t1y + 1 + my), pic1(mx, my)
    NEXT
  NEXT
END IF
SOUND 40, 1
LOCATE 24, 20
COLOR 14
PRINT "Player 1";
CALL roll
'IF p1x = 20 AND p1y = 10 THEN LINE (20 * 15 + 5, 10 * 15 + 1)-(20 * 15 + 10, 10 * 15 + 6), 0, BF
drt1 = dr1% + dr2%
FOR mover = 0 TO drt1
  t1x = p1x * 15
  t1y = p1y * 15
  FOR mx = 0 TO 5
    FOR my = 0 TO 5
      pic1(mx, my) = POINT(t1x + 5 + mx, t1y + 1 + my)
      PSET (t1x + 5 + mx, t1y + 1 + my), 14
    NEXT
  NEXT
  IF p1y = 1 AND p1x = 1 THEN
    LOCATE 1, 1
    COLOR 14
    PRINT "Winner Player 1"
    www = 1
    EXIT SUB
  END IF
  WHILE INKEY$ <> ""
  WEND
  SLEEP 1
  IF mover = drt1 THEN GOTO 2
  FOR mx = 0 TO 5
    FOR my = 0 TO 5
      PSET (t1x + 5 + mx, t1y + 1 + my), pic1(mx, my)
    NEXT
  NEXT
  p1x = p1x - 1
2
  IF p1x = 0 THEN
    p1x = 20
    p1y = p1y - 1
  END IF
NEXT mover
player = 1
CALL updown
IF phit = 1 THEN CALL jumper1
IF chxx = 0 THEN
  t2x = p2x * 15
  t2y = p2y * 15
  FOR mx = 0 TO 5
    FOR my = 0 TO 5
      PSET (t2x + 5 + mx, t2y + 9 + my), pic2(mx, my)
    NEXT
  NEXT
END IF
'IF p2x = 20 AND p2y = 10 THEN LINE (20 * 15 + 5, 10 * 15 + 9)-(20 * 15 + 10, 10 * 15 + 14), 0, BF
SOUND 40, 1
LOCATE 24, 20
COLOR 13
PRINT "Player 2";
CALL roll
drt2 = dr1% + dr2%
FOR mover = 0 TO drt2
  t2x = p2x * 15
  t2y = p2y * 15
  FOR mx = 0 TO 5
    FOR my = 0 TO 5
      pic2(mx, my) = POINT(t2x + 5 + mx, t2y + 9 + my)
      PSET (t2x + 5 + mx, t2y + 9 + my), 13
    NEXT
  NEXT
  IF p2y = 1 AND p2x = 1 THEN
    LOCATE 1, 1
    COLOR 13
    PRINT "Winner Player 2"
    www = 1
    EXIT SUB
  END IF
  
  WHILE INKEY$ <> ""
  WEND
  SLEEP 1
  IF mover = drt2 THEN GOTO 3
  FOR mx = 0 TO 5
    FOR my = 0 TO 5
      PSET (t2x + 5 + mx, t2y + 9 + my), pic2(mx, my)
    NEXT
  NEXT
  p2x = p2x - 1
3
  IF p2x = 0 THEN
    p2x = 20
    p2y = p2y - 1
  END IF
NEXT mover
chxx = 1
player = 2
CALL updown
IF phit = 1 THEN CALL jumper2
END SUB

SUB roll
FOR zzz = 1 TO 5
  RANDOMIZE TIMER
  dr1% = CINT(1 + (RND * 5))
  dr2% = CINT(1 + (RND * 5))
  LINE (dix1 - 11, diy1 - 11)-(dix1 + 11, diy1 + 11), 0, BF
  LINE (dix2 - 11, diy2 - 11)-(dix2 + 11, diy2 + 11), 0, BF
  SELECT CASE dr1%
    CASE 1
      CIRCLE (dix1, diy1), 3, 4
    CASE 2
      CIRCLE (dix1, diy1 + 8), 3, 4
      CIRCLE (dix1, diy1 - 8), 3, 4
    CASE 3
      CIRCLE (dix1, diy1), 3, 4
      CIRCLE (dix1 - 8, diy1 - 8), 3, 4
      CIRCLE (dix1 + 8, diy1 + 8), 3, 4
    CASE 4
      CIRCLE (dix1 - 8, diy1 - 8), 3, 4
      CIRCLE (dix1 + 8, diy1 + 8), 3, 4
      CIRCLE (dix1 - 8, diy1 + 8), 3, 4
      CIRCLE (dix1 + 8, diy1 - 8), 3, 4
    CASE 5
      CIRCLE (dix1 - 8, diy1 - 8), 3, 4
      CIRCLE (dix1 + 8, diy1 + 8), 3, 4
      CIRCLE (dix1 - 8, diy1 + 8), 3, 4
      CIRCLE (dix1 + 8, diy1 - 8), 3, 4
      CIRCLE (dix1, diy1), 3, 4
    CASE 6
      CIRCLE (dix1 - 8, diy1 - 8), 3, 4
      CIRCLE (dix1 + 8, diy1 + 8), 3, 4
      CIRCLE (dix1 - 8, diy1 + 8), 3, 4
      CIRCLE (dix1 + 8, diy1 - 8), 3, 4
      CIRCLE (dix1 - 8, diy1), 3, 4
      CIRCLE (dix1 + 8, diy1), 3, 4
  END SELECT
  PAINT (dix1 - 11, diy1 - 11), 7, 4
  SELECT CASE dr2%
    CASE 1
      CIRCLE (dix2, diy2), 3, 4
    CASE 2
      CIRCLE (dix2, diy2 + 8), 3, 4
      CIRCLE (dix2, diy2 - 8), 3, 4
    CASE 3
      CIRCLE (dix2, diy2), 3, 4
      CIRCLE (dix2 - 8, diy2 - 8), 3, 4
      CIRCLE (dix2 + 8, diy2 + 8), 3, 4
    CASE 4
      CIRCLE (dix2 - 8, diy2 - 8), 3, 4
      CIRCLE (dix2 + 8, diy2 + 8), 3, 4
      CIRCLE (dix2 - 8, diy2 + 8), 3, 4
      CIRCLE (dix2 + 8, diy2 - 8), 3, 4
    CASE 5
      CIRCLE (dix2 - 8, diy2 - 8), 3, 4
      CIRCLE (dix2 + 8, diy2 + 8), 3, 4
      CIRCLE (dix2 - 8, diy2 + 8), 3, 4
      CIRCLE (dix2 + 8, diy2 - 8), 3, 4
      CIRCLE (dix2, diy2), 3, 4
    CASE 6
      CIRCLE (dix2 - 8, diy2 - 8), 3, 4
      CIRCLE (dix2 + 8, diy2 + 8), 3, 4
      CIRCLE (dix2 - 8, diy2 + 8), 3, 4
      CIRCLE (dix2 + 8, diy2 - 8), 3, 4
      CIRCLE (dix2 - 8, diy2), 3, 4
      CIRCLE (dix2 + 8, diy2), 3, 4
  END SELECT
  PAINT (dix2 - 11, diy2 - 11), 7, 4
  SOUND 40, 1
NEXT
END SUB

SUB updown
phit = 0
FOR nn = 1 TO 23
  IF player = 1 THEN
    IF sam(nn).x1 = p1x AND sam(nn).y1 = p1y THEN
      p1x = sam(nn).x2
      p1y = sam(nn).y2
      phit = 1
    END IF
  END IF
  IF player = 2 THEN
    IF sam(nn).x1 = p2x AND sam(nn).y1 = p2y THEN
      p2x = sam(nn).x2
      p2y = sam(nn).y2
      phit = 1
    END IF
  END IF
NEXT nn
END SUB

