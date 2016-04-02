


'                      Dennis Rodman Basketball Challenge v1.0
'                                       By
'                                Dominick Aguilar
'                     Sorry, no intro screen, just the lame game
'      Instructions: Squat Down to increase power       /\
'      ------------  Move Arm to change angle       < NumPad >
'                                                       \/
'                   Ball inflation is just a little extra variation
'                             E-Mail BCase10582@aol.com
'
'NOTE: DELAY loop can be altered (see below)
'
SCREEN 12
CLS
pi = 3.14159: score = 0: hs = 0
mx = 14: my = 285: a = pi / 4: kx = 24: ky = 380: jjp = 0: v = 20
COLOR 1

CIRCLE (25, 300), 10, 6: PAINT (25, 300), 6, 6
LINE (15, 305)-(35, 295), 0: PAINT (22, 300), 2, 0
LINE (23, 310)-(27, 320), 6, BF
CIRCLE (25, 325), 5, 15: PAINT (25, 325), 15, 15
LINE (20, 327)-(30, 350), 15, BF
LINE (20, 352)-(30, 360), 3, BF
LINE (20, 361)-(30, 361), 6
CIRCLE (25, 307), 2, 14
LINE (20, 400)-(22, 405), 12, BF
LINE (20, 400)-(27, 405), 12
LINE (28, 403)-(35, 405), 12, BF
DIM man(3000): GET (14, 285)-(36, 365), man
DIM shoe(100): GET (19, 400)-(35, 410), shoe


LINE (608, 100)-(609, 200), 15, B
LINE (610, 160)-(622, 170), 8, BF
LINE (615, 170)-(622, 409), 8, BF
LINE (558, 160)-(598, 161), 6, B
LINE (0, 411)-(625, 412), 14, B
LINE (598, 162)-(607, 170), 4
LINE (598, 162)-(607, 162), 4
2 COLOR 15: LOCATE 10, 10: INPUT "Enter Ball Inflation pressure (1-20)", e
LOCATE 10, 10:    PRINT "                                           "
 IF e < 1 OR e > 20 THEN 2
 e = (e + 78) / 100

3 a$ = INKEY$: IF a$ = "" THEN 3
4 IF a$ = " " THEN jjp = 1
IF jjp = 1 THEN v = v + 1: a$ = "8"
LINE (0, 200)-(70, 400), 0, BF
IF a$ = "2" AND kx < 45 THEN kx = kx + 2: ky = ky + 1: my = my + 2
IF a$ = "8" AND kx > 24 THEN kx = kx - 2: ky = ky - 1: my = my - 2
IF a$ = "4" AND a < pi / 2.5 THEN a = a + pi / 180
IF a$ = "6" AND a > pi / 8 THEN a = a - pi / 180
PUT (mx, my), man, PSET
PUT (19, 400), shoe, PSET

CIRCLE (kx, ky), 2, 6
LINE (20, my + 77)-(kx - 1, ky), 6: LINE (30, my + 77)-(kx + 1, ky), 6
LINE (kx - 1, ky)-(23, 400), 6: LINE (kx + 1, ky)-(26, 403), 6
LINE (25, my + 42)-(25 + 40 * COS(a), my + 42 - 40 * SIN(a)), 6
LINE (25 + 40 * COS(a), my + 42 - 40 * SIN(a))-(25 + 40 * COS(a + pi / 4), my + 42 - 40 * SIN(a + pi / 4)), 6
xs = 25 + 40 * COS(a + pi / 4): ys = my + 42 - 40 * SIN(a + pi / 4)
CIRCLE (xs, ys), 8, 6
IF ky <= 380 AND jjp = 1 THEN CIRCLE (xs, ys), 8, 0: jjp = 0: GOTO 5
IF jjp = 1 THEN 4
GOTO 3
5 COLOR 15
 ac = 0:  t = 0: vc = 0
10 REM
LINE (558, 160)-(598, 161), 6, B
LINE (598, 162)-(607, 170), 4
LINE (598, 162)-(607, 162), 4
t = t + .006: REM ------------- CHANGE .007 to .009 or .01 IF STILL TOO SLOW
REM -----------    DELAY IS HERE --------
FOR d = 1 TO 20: NEXT d
xx = 30 * (v * t * COS(a))
x = xs + xx
yy = -30 * (v * t * SIN(a) - (16 * t ^ 2))
y = ys + yy
IF y > 160 THEN sc = 2
IF y < 160 THEN sc = 0

IF v < .2 THEN msg$ = "Next!": GOTO 2000
IF INT(y) >= 400 THEN GOSUB 400: GOTO 10
IF INT(x) >= 590 AND y > 105 THEN GOSUB 100: GOTO 10
IF INT(x) > 650 THEN msg$ = "LOST BALL!": score = 0: GOTO 2000
IF INT(x) <= 0 THEN GOSUB 200: GOTO 10
 IF sc = 2 AND ABS(INT(x - 604)) < 6 AND ABS(INT(y - 160)) < 5 THEN SOUND 100, .7: ys = y: v = v * .7 * e: xs = x: : t = 0: GOTO 10
 IF sc = 2 AND ABS(INT(x - 558)) < 4 AND ABS(INT(y - 160)) < 6 THEN SOUND 120, .7: ys = y: v = v * .7 * e: xs = x: : t = 0: GOTO 10
 IF sc = 2 AND INT(x) >= 558 AND INT(x) <= 602 AND ABS(INT(y - 160)) < 10 THEN scc = 2
 IF scc = 2 AND ABS(INT(y - 160)) > 10 THEN score = score + 2: scc = 0: FOR d = 1 TO 10: SOUND 3000 * d, .4: NEXT d
 IF score > hs THEN hs = score

50 REM

COLOR 0: CIRCLE (xc, yc), (8)
xc = x: yc = y
COLOR 6: CIRCLE (xc, yc), (8)
COLOR 15
LOCATE 27, 5: PRINT "Score"; score, "High Score: "; hs
GOTO 10
100 REM
xs = 600 + (600 - xs)
a = pi - a

RETURN
200 REM
xs = 10 - xs
a = pi - a
IF x < 60 THEN CIRCLE (xc, yc), 8, 0: msg$ = "Shoot Again!": GOTO 2000
RETURN
400 REM
t = 0: v = vc + v * e: a = a + ac: xs = x: ys = y: vc = 0: ac = 0
SOUND 50, .6
RETURN
2000 : REM ---- Messages
LOCATE 10, 10: PRINT msg$
DO: LOOP UNTIL INKEY$ <> ""
LOCATE 10, 10: PRINT "                                           "
v = 20: a = pi / 4
LINE (25, my + 42)-(25 + 40 * COS(a), my + 42 - 40 * SIN(a)), 0
LINE (25 + 40 * COS(a), my + 42 - 40 * SIN(a))-(25 + 40 * COS(a + pi / 4), my + 42 - 40 * SIN(a + pi / 4)), 0
IF msg$ = "LOST BALL!" THEN score = 0: GOTO 2
ra = INT(RND(1) * 3) + 1: a = a + ra * (pi / 157)
 GOTO 3

