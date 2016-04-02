' INVASION
' Version 1.0.0, March 1997
' by Brent P. Newhall (BrentN@juno.com)

' This is a fairly simple "Independence Day in reverse" scenario.  You
' control a flying saucer (actually, a flying black ring), and try to blow up
' as much of the city as possible. :-)

' There are ten radar dishes in this game; you must destroy all of them
' before you can conquer the city.

' A small missile will be coming towards you; you can detonate it if it's
' within a small range near your ship.  A new missile will automatically be
' generated.

' ARROW KEYS --- Move alien ship
' [SPACE] ------ Zap anything below you
' [ENTER] ------ Detonate missile if close enough
' [ESC] -------- Quit

' The faster the missile, the harder the game is.

' Maximum possible score is 7000 points

' Feel free to add to or modify this code as much as you'd like, just make
' sure I still get credit for what I've done. ;-)

DEFINT A-Z
DECLARE SUB PlaceGround (xpos AS INTEGER, ypos AS INTEGER)
DECLARE SUB pal (colr AS INTEGER, red AS INTEGER, green AS INTEGER, blue AS INTEGER)

CONST MISSILEDELAY = 5
' This is just a preliminary setting until you get
' the hang of it.  Change it to 3 and the game
' suddenly gets much harder!
CONST NUMRADARS = 10

DIM alien(1 TO 100) AS INTEGER
DIM alienMask(1 TO 100) AS INTEGER
DIM SHARED worldgraph(1 TO 100, 0 TO 4)
DIM SHARED stuffgraph(1 TO 100, 1 TO 5)
DIM SHARED stuffgraphMask(1 TO 100, 1 TO 5)
DIM missile(1 TO 100)
DIM missileMask(1 TO 100)
DIM SHARED world(1 TO 20, 1 TO 20) AS INTEGER
DIM SHARED stuff(1 TO 20, 1 TO 20) AS INTEGER

RANDOMIZE TIMER
GOSUB CreateWorld
GOSUB GetGraphics
pal 50, 10, 10, 10
pal 51, 0, 0, 0
x = 1: y = 1: oldx = 1: oldy = 1
miss.x = 20: miss.y = 20
LOCATE 1, 29: PRINT "INVASION";
LOCATE 3, 30: PRINT "Score:";
LOCATE 6, 30: PRINT "Radars";
GOSUB DoScore
GOSUB DrawWorld
GOSUB DoSaucer
DO
  GOSUB DoMissile
  IF Exploding.now > 0 THEN GOSUB DoExplosion
  t! = TIMER: WHILE t! = TIMER: WEND ' Delay
  kp% = INP(&H60) ' Get keypress in kp%
  IF kp% < 100 THEN GOSUB KeyInput
LOOP UNTIL quit > 0
IF quit = 1 THEN
  LOCATE 14, 29: PRINT "QUITTER!!";
ELSEIF quit = 2 THEN
  LOCATE 14, 29: PRINT "GAME OVER";
ELSEIF quit = 3 THEN
  LOCATE 14, 29: PRINT "THE CITY";
  LOCATE 15, 29: PRINT "IS OURS!";
END IF
COLOR 15
DO: LOOP UNTIL INKEY$ = CHR$(27)
END

KeyInput:
IF kp% = 72 THEN ' [UP]
  y = y - 1
  IF y < 1 THEN y = 1
  GOSUB DoSaucer
ELSEIF kp% = 80 THEN ' [DOWN]
  y = y + 1
  IF y > 20 THEN y = 20
  GOSUB DoSaucer
ELSEIF kp% = 77 THEN ' [RIGHT]
  x = x + 1
  IF x > 20 THEN x = 20
  GOSUB DoSaucer
ELSEIF kp% = 75 THEN ' [LEFT]
  x = x - 1
  IF x < 1 THEN x = 1
  GOSUB DoSaucer
ELSEIF kp% = 29 THEN ' [CTRL]
  IF Exploding.now = 0 THEN
    Exploding.now = 1
    Exploding.x = x
    Exploding.y = y
    IF stuff(x, y) > 0 AND stuff(x, y) < 4 THEN
      Exploding.amt = 100 ' Car
    ELSEIF world(x, y) = 4 THEN
      Exploding.amt = 500 ' Radar
    ELSE
      Exploding.amt = 0
    END IF
  END IF
ELSEIF kp% = 56 THEN ' [ALT]
  IF ABS(miss.x - x) < 5 THEN
    IF ABS(miss.y - y) < 5 THEN
      PlaceGround miss.x, miss.y
      IF RND > .5 THEN miss.x = 1 ELSE miss.x = 20
      IF RND > .5 THEN miss.y = 1 ELSE miss.y = 20
      miss.cnt = 0
    END IF
  END IF
ELSEIF kp% = 1 THEN ' [ESC]
  quit = 1
END IF
RETURN

DoExplosion:
a = (Exploding.x - 1) * 10
b = (Exploding.y - 1) * 10
IF Exploding.now = 1 THEN
  Exploding.now = 2
  IF Exploding.amt = 500 THEN
    RadarGone = RadarGone + 1
    IF RadarGone = NUMRADARS THEN quit = 3
  END IF
  score = score + Exploding.amt
  GOSUB DoScore
  stuff(Exploding.x, Exploding.y) = 4
  oldx = Exploding.x
  oldy = Exploding.y
  GOSUB DoSaucer
ELSEIF Exploding.now = 5 THEN
  Exploding.now = 0
  stuff(Exploding.x, Exploding.y) = 5
  oldx = Exploding.x
  oldy = Exploding.y
  GOSUB DoSaucer
ELSE
  Exploding.now = Exploding.now + 1
END IF
RETURN

DoMissile:
miss.cnt = miss.cnt + 1
IF miss.cnt = MISSILEDELAY THEN
  miss.cnt = 0
  PlaceGround miss.x, miss.y ' Erase current missile
  IF miss.x < x THEN
    miss.x = miss.x + 1
  ELSEIF miss.x > x THEN
    miss.x = miss.x - 1
  END IF
  IF miss.y < y THEN
    miss.y = miss.y + 1
  ELSEIF miss.y > y THEN
    miss.y = miss.y - 1
  END IF
  IF miss.x = x AND miss.y = y THEN
    quit = 2
  ELSE
    a = (miss.x - 1) * 10 ' Place current missile
    b = (miss.y - 1) * 10
    PUT (a, b), missileMask, AND
    PUT (a, b), missile, OR
  END IF
END IF
RETURN

DoSaucer:
PlaceGround oldx, oldy
a = (x - 1) * 10
b = (y - 1) * 10
PUT (a, b), alienMask, AND
PUT (a, b), alien, OR
oldx = x: oldy = y
RETURN

DoScore:
LOCATE 4, 30: PRINT USING "#####"; score;
LOCATE 7, 32: PRINT USING "##"; NUMRADARS - RadarGone;
RETURN

DrawWorld:
i$ = ""
FOR j = 1 TO 20
  FOR i = 1 TO 20
    a = (i - 1) * 10
    b = (j - 1) * 10
    PUT (a, b), worldgraph(1, world(i, j))
    IF stuff(i, j) > 0 THEN
      PUT (a, b), stuffgraphMask(1, stuff(i, j)), AND
      PUT (a, b), stuffgraph(1, stuff(i, j)), OR
    END IF
  NEXT i
  IF i$ = "" THEN
    t! = TIMER: WHILE t! = TIMER: WEND
    i$ = INKEY$
  END IF
NEXT j
RETURN

CreateWorld:
world(1, 1) = 3 ' Upper-left intersection
FOR i = 2 TO 20 ' Do upper and left street
  world(i, 1) = 1
  world(1, i) = 2
NEXT i
a = 1
WHILE a < 20 ' Do left-and-right streets
  a = a + INT(RND * 3 + 3)
  IF a > 18 THEN a = 20
  FOR i = 1 TO 20
    IF world(i, a) = 2 THEN
      world(i, a) = 3
    ELSE
      world(i, a) = 1
    END IF
  NEXT i
WEND
a = 1
WHILE a < 20 ' Do up-and-down streets
  a = a + INT(RND * 3 + 3)
  IF a > 18 THEN a = 20
  FOR i = 1 TO 20
    IF world(a, i) = 1 THEN
      world(a, i) = 3
    ELSE
      world(a, i) = 2
    END IF
  NEXT i
WEND
FOR i = 1 TO 20 ' Cars
  DO
    a = INT(RND * 20 + 1)
    b = INT(RND * 20 + 1)
  LOOP UNTIL world(a, b) > 0 AND stuff(a, b) = 0
  stuff(a, b) = world(a, b)
NEXT i
FOR i = 1 TO NUMRADARS ' Radars
  DO
    a = INT(RND * 20 + 1)
    b = INT(RND * 20 + 1)
  LOOP UNTIL world(a, b) = 0
  world(a, b) = 4
NEXT i
RETURN

GetGraphics:
SCREEN 13: COLOR 12
LOCATE 25, 1: PRINT "Drawing graphics....";
CIRCLE (5, 5), 4, 8, , , 1 ' Alien
CIRCLE (5, 6), 4, 50, , , 1
CIRCLE (6, 5), 4, 50, , , 1
CIRCLE (6, 6), 4, 50, , , 1
GET (1, 1)-(10, 10), alien
LINE (1, 1)-(10, 10), 255, BF
CIRCLE (5, 5), 4, 8, , , 1
CIRCLE (5, 6), 4, 50, , , 1
CIRCLE (6, 5), 4, 50, , , 1
CIRCLE (6, 6), 4, 50, , , 1
GET (1, 1)-(10, 10), alienMask
PUT (1, 1), alienMask

LINE (1, 1)-(10, 10), 8, BF ' Plain gray
GET (1, 1)-(10, 10), worldgraph(1, 0)
PUT (1, 1), worldgraph(1, 0)

LINE (1, 1)-(10, 10), 7, BF ' Left-right street
LINE (1, 3)-(10, 8), 8, BF
LINE (1, 5)-(2, 5), 14
LINE (5, 5)-(7, 5), 14
PSET (10, 5), 14
GET (1, 1)-(10, 10), worldgraph(1, 1)
PUT (1, 1), worldgraph(1, 1)

LINE (1, 1)-(10, 10), 7, BF ' Up-down street
LINE (3, 1)-(8, 10), 8, BF
LINE (5, 1)-(5, 2), 14
LINE (5, 5)-(5, 7), 14
PSET (5, 10), 14
GET (1, 1)-(10, 10), worldgraph(1, 2)
PUT (1, 1), worldgraph(1, 2)

LINE (1, 1)-(10, 10), 7, BF ' Intersection
LINE (1, 3)-(10, 8), 8, BF
LINE (3, 1)-(8, 10), 8, BF
PSET (1, 5), 14
LINE (4, 5)-(6, 5), 14
LINE (9, 5)-(10, 5), 14
PSET (5, 1), 14
LINE (5, 4)-(5, 6), 14
LINE (5, 9)-(5, 10), 14
GET (1, 1)-(10, 10), worldgraph(1, 3)
PUT (1, 1), worldgraph(1, 3)

LINE (1, 1)-(10, 10), 8, BF ' Radar
CIRCLE (5, 6), 4, 7, , , 2 / 1
PAINT (5, 6), 7
LINE (3, 3)-(3, 9), 15
PSET (4, 2), 15: PSET (4, 10), 15
PSET (5, 6), 15
LINE (7, 3)-(7, 9), 25
GET (1, 1)-(10, 10), worldgraph(1, 4)
PUT (1, 1), worldgraph(1, 4)

LINE (2, 4)-(9, 7), 4, BF ' Left-right red car
PSET (2, 4), 14: PSET (2, 7), 14
LINE (4, 4)-(4, 7), 15
LINE (7, 5)-(7, 6), 7
PSET (9, 4), 12: PSET (9, 7), 12
GET (1, 1)-(10, 10), stuffgraph(1, 1)
LINE (1, 1)-(10, 10), 255, BF
LINE (2, 4)-(9, 7), 4, BF
PSET (2, 4), 14: PSET (2, 7), 14
LINE (4, 4)-(4, 7), 15
LINE (7, 5)-(7, 6), 7
PSET (9, 4), 12: PSET (9, 7), 12
GET (1, 1)-(10, 10), stuffgraphMask(1, 1)
PUT (1, 1), stuffgraphMask(1, 1)

LINE (4, 2)-(7, 9), 1, BF ' Up-down blue car
PSET (4, 2), 14: PSET (7, 2), 14
LINE (4, 4)-(7, 4), 15
LINE (5, 7)-(6, 7), 7
PSET (4, 9), 12: PSET (7, 9), 12
GET (1, 1)-(10, 10), stuffgraph(1, 2)
LINE (1, 1)-(10, 10), 255, BF
LINE (4, 2)-(7, 9), 1, BF
PSET (4, 2), 14: PSET (7, 2), 14
LINE (4, 4)-(7, 4), 15
LINE (5, 7)-(6, 7), 7
PSET (4, 9), 12: PSET (7, 9), 12
GET (1, 1)-(10, 10), stuffgraphMask(1, 2)
PUT (1, 1), stuffgraphMask(1, 2)

LINE (2, 4)-(9, 7), 120, BF ' Left-right green car
PSET (2, 4), 12: PSET (2, 7), 12
LINE (4, 5)-(4, 6), 7
LINE (7, 4)-(7, 7), 15
PSET (9, 4), 14: PSET (9, 7), 14
GET (1, 1)-(10, 10), stuffgraph(1, 3)
LINE (1, 1)-(10, 10), 255, BF
LINE (2, 4)-(9, 7), 120, BF
PSET (2, 4), 12: PSET (2, 7), 12
LINE (4, 5)-(4, 6), 7
LINE (7, 4)-(7, 7), 15
PSET (9, 4), 14: PSET (9, 7), 14
GET (1, 1)-(10, 10), stuffgraphMask(1, 3)
PUT (1, 1), stuffgraphMask(1, 3)

' Explosion
CIRCLE (6, 6), 4, 4, , , 1: PAINT (6, 6), 4
CIRCLE (6, 6), 3, 12, , , 1: PAINT (6, 6), 12
CIRCLE (6, 6), 2, 14, , , 1: PAINT (6, 6), 14
CIRCLE (6, 6), 1, 15, , , 1: PAINT (6, 6), 15
GET (1, 1)-(10, 10), stuffgraph(1, 4)
LINE (1, 1)-(10, 10), 255, BF
CIRCLE (6, 6), 4, 4, , , 1: PAINT (6, 6), 4
CIRCLE (6, 6), 3, 12, , , 1: PAINT (6, 6), 12
CIRCLE (6, 6), 2, 14, , , 1: PAINT (6, 6), 14
CIRCLE (6, 6), 1, 15, , , 1: PAINT (6, 6), 15
GET (1, 1)-(10, 10), stuffgraphMask(1, 4)
PUT (1, 1), stuffgraphMask(1, 4)

CIRCLE (6, 6), 4, 51, , , 1: PAINT (6, 6), 51
CIRCLE (6, 6), 4, 25, , , 1 ' Crater
CIRCLE (6, 6), 3, 20, , , 1
PSET (8, 5), 8: PSET (5, 6), 8
GET (1, 1)-(10, 10), stuffgraph(1, 5)
LINE (1, 1)-(10, 10), 255, BF
CIRCLE (6, 6), 4, 51, , , 1: PAINT (6, 6), 51
CIRCLE (6, 6), 4, 25, , , 1
CIRCLE (6, 6), 3, 20, , , 1
PSET (8, 5), 8: PSET (5, 6), 8
GET (1, 1)-(10, 10), stuffgraphMask(1, 5)
PUT (1, 1), stuffgraphMask(1, 5)

CIRCLE (6, 6), 1, 7: PSET (6, 6), 15 ' Missile
GET (1, 1)-(10, 10), missile
LINE (1, 1)-(10, 10), 255, BF
CIRCLE (6, 6), 1, 7: PSET (6, 6), 15 ' Missile
GET (1, 1)-(10, 10), missileMask
PUT (1, 1), missileMask

'END
CLS
RETURN

DEFSNG A-Z
SUB pal (colr AS INTEGER, red AS INTEGER, green AS INTEGER, blue AS INTEGER)

PALETTE colr, red + 256 * green + 65536 * blue

END SUB

DEFINT A-Z
SUB PlaceGround (xpos AS INTEGER, ypos AS INTEGER)

tempA = (xpos - 1) * 10
tempB = (ypos - 1) * 10
PUT (tempA, tempB), worldgraph(1, world(xpos, ypos)), PSET
IF stuff(xpos, ypos) > 0 THEN
  PUT (tempA, tempB), stuffgraphMask(1, stuff(xpos, ypos)), AND
  PUT (tempA, tempB), stuffgraph(1, stuff(xpos, ypos)), OR
END IF

END SUB

