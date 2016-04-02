'===========================================================================
' Subject: CAT & MOUSE LIKE GAME              Date: 05-24-97 (22:03)      
'  Author: Chris McKenzie                     Code: QB, QBasic, PDS       
'  Origin: mckenzie@calwest.net             Packet: GAMES.ABC
'===========================================================================
'look out for invisible walls
SCREEN 13

top:
 CLS
  FOR colors = 1 TO 7
   LINE (96 + colors, 0)-(96 + colors, 90), 27 - colors
   LINE (89 + colors, 0)-(89 + colors, 90), colors + 17
 NEXT colors
COLOR 17
PRINT "Finish"
DIM world(110)
RANDOMIZE TIMER
 FOR x = 1 TO 10
  FOR y = 1 TO 10
   world(y + 10 * x) = RND * 8 MOD 5
    IF world(y + 10 * x) = 1 THEN
    FOR h = 0 TO 6
     LINE (8 * x, 8 * y + h)-(8 * x + 8, 8 * y + h + 1), h + 20, BF
    NEXT h
  END IF
 NEXT y
NEXT x
world(100) = 0
 FOR x = 0 TO 60
  FOR y = 0 TO 10
  IF POINT(x, y) = 17 THEN LINE (75 + x, 100 + y)-(75 + x, 100 + y), y + 25
  NEXT y
 NEXT x
LINE (70, 95)-(128, 111), 21, B
x = 1
y = 2
xbad = 10
ybad = 10

beginning:
 h$ = INKEY$
 xbefore = x
 ybefore = y
  IF h$ = "6" AND x < 10 THEN x = x + 1
  IF h$ = "2" AND y < 10 THEN y = y + 1
  IF h$ = "4" AND x > 0 THEN x = x - 1
  IF h$ = "8" AND y > 0 THEN y = y - 1
  IF h$ = CHR$(27) THEN SYSTEM
  IF h$ <> "" THEN GOTO button
GOTO beginning

button:
  IF world(x * 10 + y) = 1 THEN
   x = xbefore
   y = ybefore
    FOR soundrand = 1 TO 50
     SOUND 37 + RND * 20, .028
    NEXT soundrand
  END IF
 LINE (8 * xbefore, 8 * ybefore)-(8 * xbefore + 8, 8 * ybefore + 8), 0, BF
  FOR fillcolor = 1 TO 4
  CIRCLE (8 * x + 4, 8 * y + 4), fillcolor, 150 - (fillcolor * 2)
 NEXT fillcolor
 xbadbefore = xbad
 ybadbefore = ybad
  IF xbad > x THEN xbad = xbad - 1
  IF xbad < x THEN xbad = xbad + 1
  IF ybad > y THEN ybad = ybad - 1
  IF ybad < y THEN ybad = ybad + 1
  IF world(xbad * 10 + ybad) = 1 THEN
   xbad = xbadbefore
   ybad = ybadbefore
  END IF

 LINE (8 * xbadbefore, 8 * ybadbefore)-(8 * xbadbefore + 8, 8 * ybadbefore + 8), 0, BF
 
  FOR fillcolor = 1 TO 4
  CIRCLE (8 * xbad + 4, 8 * ybad + 4), fillcolor, 50 - (fillcolor * 2)
 NEXT fillcolor
 
  IF x = 10 AND y = 10 THEN
   message$ = "You Win"
   GOTO last
  END IF
  
   IF x = xbad AND y = ybad THEN
   message$ = "You Lose"
   GOTO last
  END IF
GOTO beginning

last:
 CLS
 COLOR 17
 PRINT message$
  FOR r = 15 TO 25
   FOR x = 0 TO 70
    FOR y = 0 TO 10
     IF POINT(x, y) = 17 THEN LINE (3 * x + 20, 3 * y + 65)-(3 * x + 24, 3 * y + 69), y + r, BF
     IF POINT(x, y) = 17 THEN LINE (3 * x + 20, 3 * y + 65)-(3 * x + 23, 3 * y + 68), 0, B
    NEXT y
   NEXT x
  NEXT r
 LOCATE 23, 1
 COLOR 15
 PRINT "Play again?"
  FOR x = 0 TO 100
   FOR y = 173 TO 183
    IF POINT(x, y) = 15 THEN LINE (x, y)-(x, y), y - 155
   NEXT y
  NEXT x
COLOR 25
LOCATE 23, 16
PRINT "Yes    No"
choice = 1

choice1:
choice: key$ = INKEY$
 IF key$ = "6" THEN choice = choice + 1
 IF key$ = "4" THEN choice = choice - 1
 IF key$ = " " AND choice = 1 THEN SYSTEM
 IF key$ = " " AND choice = 0 THEN GOTO top
 IF choice = -1 THEN choice = 1
 IF choice = 2 THEN choice = 0
 IF choice = 0 THEN
  FOR x = 115 TO 145
   FOR y = 173 TO 185
    IF POINT(x, y) = 0 THEN LINE (x, y)-(x, y), 20
    IF POINT(x, y) = 25 THEN LINE (x, y)-(x, y), 32
   NEXT y
  NEXT x
  FOR x = 170 TO 200
   FOR y = 173 TO 185
    IF POINT(x, y) = 20 THEN LINE (x, y)-(x, y), 0
    IF POINT(x, y) = 32 THEN LINE (x, y)-(x, y), 25
   NEXT y
  NEXT x
   ELSE
    FOR x = 170 TO 200
     FOR y = 173 TO 185
      IF POINT(x, y) = 0 THEN LINE (x, y)-(x, y), 20
      IF POINT(x, y) = 25 THEN LINE (x, y)-(x, y), 32
     NEXT y
    NEXT x
  FOR x = 115 TO 145
   FOR y = 173 TO 185
    IF POINT(x, y) = 20 THEN LINE (x, y)-(x, y), 0
    IF POINT(x, y) = 32 THEN LINE (x, y)-(x, y), 25
   NEXT y
  NEXT x
END IF
GOTO choice1

