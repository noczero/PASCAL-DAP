DECLARE SUB mousestatus (lb%, rb%, xMouse%, yMouse%)
DECLARE SUB MouseHide ()
DECLARE SUB MouseDriver (ax%, bx%, cx%, dx%)
DECLARE SUB MouseShow ()
DECLARE FUNCTION mouseInit% ()
DIM SHARED Mouse$
Mouse$ = SPACE$(57)
FOR i% = 1 TO 57
  READ a$
  h$ = CHR$(VAL("&H" + a$))
  MID$(Mouse$, i%, 1) = h$
NEXT i%
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00                    
CLS
ms% = mouseInit%
IF NOT ms% THEN
  PRINT "Mouse not found"
  END
END IF


5 REM ----- Start or Continue after crash -------                  
CLS
SCREEN 12
COLOR 1
x = 300
y = 200
zm = 1.3
pi = 3.14159
a = 3 * pi / 2
v = 0
g = .1
b = a

pp = 1
p(1) = 1
p(2) = 2
p(3) = 3
p(4) = 4

px(1) = 300
py(1) = 300
px(2) = 700
py(2) = 300
px(3) = 500
py(3) = 200
px(4) = 400
py(4) = 350

hzpx(1) = -800
hzpy(1) = 160
hzpx(2) = 200
hzpy(2) = 170
hzpx(3) = 300
hzpy(3) = 160
hzpx(4) = 400
hzpy(4) = 180
hzpx(5) = 500
hzpy(5) = 170
hzpx(6) = 1400
hzpy(6) = 160

GOSUB 100

10 REM -------------- MAIN LOOP ----------------
FOR d = 1 TO 90
a$ = INKEY$
mousestatus lb%, rb%, x%, y%
IF a$ <> "" THEN 15
NEXT d
FOR dd = 1 TO 100: NEXT dd
15 REM ----------------------------

 GOSUB 300
IF x > 500 THEN x = 500
IF x < 100 THEN x = 100
IF y > 400 THEN y = 400
IF y < -10 THEN y = -10




REM ----------- check stuff ------------
bm = 7: IF INT(10 * (a - 4)) = 7 THEN bm = 4
GOSUB 600

IF a$ = " " THEN GOSUB 400
IF g <= 0 THEN 20
IF y% = 479 AND zm > .9 THEN zm = zm - .05: y = y - zm / 10: SOUND 9000 * zm, 1: GOSUB 200
IF y% = 0 AND zm < 3 THEN zm = zm + .05: y = y + zm / 10: SOUND 9000 * zm, 1: GOSUB 200

20 REM ------ skipped zoom ----
IF lb% = -1 AND rb% = 0 THEN a = a + (pi / 27.5): SOUND 6000, .5: IF a > (2 * pi) THEN a = 0
IF rb% = -1 AND lb% = 0 THEN a = a - (pi / 27.5): SOUND 6300, .5: IF a < 0 THEN a = (2 * pi)
IF lb% = 0 AND rb% = 0 THEN 10
IF lb% = -1 AND rb% = -1 AND v < 9 THEN v = v + .5: SOUND 10000, .1


GOSUB 200

GOTO 10
100 REM -------- Update Ship ----------
cpx = x + 20 / zm * COS(a)
cpy = y + 20 / zm * SIN(a)
cpr = 23 / zm
sdwx = cpx
sdwy = 400 - (65 * zm)
nx = x - 2 / zm * COS(a)
ny = y - 2 / zm * SIN(a)

rbfx = x + 40 / zm * COS(a - (7 * pi / 16))
rbfy = y + 40 / zm * SIN(a - (7 * pi / 16))
rwfx = x + 20 / zm * COS(a - (3 * pi / 8))
rwfy = y + 20 / zm * SIN(a - (3 * pi / 8))
rwrx = x + 25 / zm * COS(a - (5 * pi / 8))
rwry = y + 25 / zm * SIN(a - (5 * pi / 8))
rbrx = x + 10 / zm * COS(a - (3 * pi / 4))
rbry = y + 10 / zm * SIN(a - (3 * pi / 4))
rtx = x + 12 / zm * COS(a - (7 * pi / 8))
rty = y + 12 / zm * SIN(a - (7 * pi / 8))

lbfx = x + 40 / zm * COS(a + (7 * pi / 16))
lbfy = y + 40 / zm * SIN(a + (7 * pi / 16))
lwfx = x + 20 / zm * COS(a + (3 * pi / 8))
lwfy = y + 20 / zm * SIN(a + (3 * pi / 8))
lwrx = x + 25 / zm * COS(a + (5 * pi / 8))
lwry = y + 25 / zm * SIN(a + (5 * pi / 8))
lbrx = x + 10 / zm * COS(a + (3 * pi / 4))
lbry = y + 10 / zm * SIN(a + (3 * pi / 4))
ltx = x + 12 / zm * COS(a + (7 * pi / 8))
lty = y + 12 / zm * SIN(a + (7 * pi / 8))

COLOR 5
LINE (nx, ny)-(rbfx, rbfy)
LINE (rbfx, rbfy)-(rwfx, rwfy)
COLOR 2
LINE (rwfx, rwfy)-(rwrx, rwry)
LINE (rwrx, rwry)-(rbrx, rbry)
LINE (rbrx, rbry)-(rtx, rty)
LINE (rtx, rty)-(ltx, lty)
LINE (ltx, lty)-(lbrx, lbry)
LINE (lbrx, lbry)-(lwrx, lwry)
LINE (lwrx, lwry)-(lwfx, lwfy)
COLOR 5
LINE (lwfx, lwfy)-(lbfx, lbfy)
LINE (lbfx, lbfy)-(nx, ny)
COLOR 3
CIRCLE (cpx, cpy), (cpr)

CIRCLE (sdwx, sdwy), (cpr), bm, 0, 2 * pi, .4
GOSUB 700
RETURN
200 REM -------- Clear Old Ship Position -------
COLOR 0
LINE (nx, ny)-(rbfx, rbfy)
LINE (rbfx, rbfy)-(rwfx, rwfy)
LINE (rwfx, rwfy)-(rwrx, rwry)
LINE (rwrx, rwry)-(rbrx, rbry)
LINE (rbrx, rbry)-(rtx, rty)
LINE (rtx, rty)-(ltx, lty)
LINE (ltx, lty)-(lbrx, lbry)
LINE (lbrx, lbry)-(lwrx, lwry)
LINE (lwrx, lwry)-(lwfx, lwfy)
LINE (lwfx, lwfy)-(lbfx, lbfy)
LINE (lbfx, lbfy)-(nx, ny)
CIRCLE (cpx, cpy), (cpr)
CIRCLE (sdwx, sdwy), (cpr), 0, 0, 2 * pi, .4
REM ------------- redraw ground --------------

COLOR 0
LINE (hzpx(1), hzpy(1))-(hzpx(2), hzpy(2))
LINE (hzpx(2), hzpy(2))-(hzpx(3), hzpy(3))
LINE (hzpx(3), hzpy(3))-(hzpx(4), hzpy(4))
LINE (hzpx(4), hzpy(4))-(hzpx(5), hzpy(5))
LINE (hzpx(5), hzpy(5))-(hzpx(6), hzpy(6))

LINE (0, 400)-(650, 400)
IF x >= 500 THEN GOSUB 800
IF x <= 100 THEN GOSUB 800
COLOR 7
LINE (hzpx(1), hzpy(1))-(hzpx(2), hzpy(2))
LINE (hzpx(2), hzpy(2))-(hzpx(3), hzpy(3))
LINE (hzpx(3), hzpy(3))-(hzpx(4), hzpy(4))
LINE (hzpx(4), hzpy(4))-(hzpx(5), hzpy(5))
LINE (hzpx(5), hzpy(5))-(hzpx(6), hzpy(6))

GOTO 100

300 REM -------------- Adjust Speed --------------
x = x + 3 / zm * v * COS(a) + g * (COS(b))
y = y + 3 / zm * v * SIN(a) + g: l = 0
IF INT(y) >= 390 - (65 * zm) AND bm = 7 AND g > 0 THEN msg$ = "!!! WARNING !!!!.... Ship NOT VERTICAL....!!! WARNING !!!": GOSUB 600
IF INT(y) >= 400 - (65 * zm) AND g > 0 THEN SOUND 100, 1 / zm: IF bm = 7 THEN 500
IF INT(y) >= 400 - (65 * zm) THEN g = 0: v = 0: l = 1: bm = 0: msg$ = "...........Ship has safely landed..........": GOSUB 600
IF l = 0 THEN g = g + .01 - (.01 * v)
IF g < 0 THEN g = 0
IF g > 6 THEN g = 6

IF v > 0 THEN v = v - .07: b = a
                    
GOTO 200
400 REM ------------ BEAM UP ----------

IF bm = 7 THEN msg$ = "Beam not Aligned! Must be VERTICAL.": RETURN
msg$ = "................BEAM ACTIVATED................"
GOSUB 600
FOR bmup = INT(30 / zm) TO INT((20 + sdwy - y) / zm) STEP 1
SOUND 9000 + 10 * bmup, .1
CIRCLE (x, y + bmup), (cpr), 2, 0, 2 * pi, .4
FOR pb = 1 TO 4
IF ABS(px(pb) - sdwx) < (cpr / 2) AND ABS(py(pb) - sdwy) < 5 THEN pab(pb) = 1
NEXT pb
SOUND 9000 + 10 * bmup, .1
CIRCLE (x, y + bmup), (cpr), 0, 0, 2 * pi, .4
NEXT bmup
FOR bmup = INT((20 + sdwy - y) / zm) TO INT(30 / zm) STEP -1
SOUND 9000 + 10 * bmup, .1
CIRCLE (x, y + bmup), (cpr), 2, 0, 2 * pi, .4
FOR pb = 1 TO 4
IF ABS(px(pb) - sdwx) < (cpr / 2) AND ABS(py(pb) - sdwy) < 5 THEN pab(pb) = 1
NEXT pb
SOUND 9000 + 10 * bmup, .1
CIRCLE (x, y + bmup), (cpr), 0, 0, 2 * pi, .4
NEXT bmup







RETURN

500 REM ------------ Crash -------------
msg$ = ">>>>>>>>>>>>>>>>>>>>>> CRASH <<<<<<<<<<<<<<<<<<<<<<"
GOSUB 600
COLOR 6
SOUND 100, 1
FOR c = 1 TO INT(50 / zm)

CIRCLE (x, y), (c)
NEXT c
COLOR 0
FOR c = 1 TO INT(50 / zm)
SOUND 200 * c, .1
CIRCLE (x, y), (c)
NEXT c
GOTO 5
600 REM --------- Message Update ---------
mu = mu + 1
IF mu = 100 THEN mu = 0
IF mu = 0 THEN msg$ = "                                                         "
LOCATE 28, 10
PRINT msg$
RETURN
700 REM ------------- People Update ----------


COLOR 0
pp = pp + 1: IF pp = 5 THEN pp = 1
ON p(pp) GOSUB 710, 720, 730, 740
sz = py(pp) / 30
p(pp) = p(pp) + 1: IF p(pp) = 5 THEN p(pp) = 1
IF pab(pp) = 1 THEN px(pp) = x: py(pp) = y - 12 + pp
p(pp) = p(pp) + 1: IF p(pp) = 5 THEN p(pp) = 1
IF bm = 4 AND sdwx > px(pp) THEN px(pp) = px(pp) + 1 * pp
IF bm = 4 AND sdwx < px(pp) THEN px(pp) = px(pp) - 1 * pp
IF bm = 4 AND sdwy > py(pp) THEN py(pp) = py(pp) + 1 * pp
IF bm = 4 AND sdwy < py(pp) THEN py(pp) = py(pp) - 1 * pp
IF x > 100 AND x < 500 THEN 705
IF x >= 500 THEN pmv = -1
IF x <= 100 THEN pmv = 1

px(pp) = px(pp) + pmv * ((py(pp) / 400) * v) ^ 2



705 COLOR 1
ON p(pp) GOSUB 710, 720, 730, 740
RETURN



REM --------------------------------------------------

710 CIRCLE (px(pp), py(pp)), 3 * (py(pp) / 400)
RETURN
720 CIRCLE (px(pp), py(pp)), 4 * (py(pp) / 400)

RETURN
730 CIRCLE (px(pp), py(pp)), 5 * (py(pp) / 400)

RETURN
740 CIRCLE (px(pp), py(pp)), 6 * (py(pp) / 400)
RETURN

800 REM -------------- Update Background ---------------

IF x = 500 THEN hz = -1: IF hzpx(1) <= 600 THEN RETURN
IF x = 100 THEN hz = 1: IF hzpx(6) >= 0 THEN RETURN
FOR h = 1 TO 6
hzpx(h) = hzpx(h) + .2 * (hz * v)

NEXT h

RETURN

SUB MouseDriver (ax%, bx%, cx%, dx%)
  DEF SEG = VARSEG(Mouse$)
  Mouse% = SADD(Mouse$)
  CALL Absolute(ax%, bx%, cx%, dx%, Mouse%)
END SUB

SUB MouseHide
 ax% = 2
 MouseDriver ax%, 0, 0, 0

END SUB

FUNCTION mouseInit%
  ax% = 0
  MouseDriver ax%, 0, 0, 0
  mouseInit% = ax%

END FUNCTION

SUB MouseShow
  ax% = 1
  MouseDriver ax%, 0, 0, 0

END SUB

SUB mousestatus (lb%, rb%, xMouse%, yMouse%)
  ax% = 3
  MouseDriver ax%, bx%, cx%, dx%
  lb% = ((bx% AND 1) <> 0)
  rb% = ((bx% AND 2) <> 0)
  xMouse% = cx%
  yMouse% = dx%

END SUB

