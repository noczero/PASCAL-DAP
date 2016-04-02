' Downloaded from the QBasic Place
' http://qbplace.home.ml.org
' The one stop program shop.
'
'
'
' Land of the Past
'    by Steve Nunnally
'  nunnally@pinn.net
'
'
DIM SHARED level(1 TO 22, 1 TO 26) AS INTEGER
DIM SHARED over AS SINGLE, up AS SINGLE
DIM SHARED dir AS SINGLE, amount AS SINGLE
DIM SHARED active AS INTEGER, visual AS INTEGER
DIM SHARED angle(-32 TO 392, 1 TO 2) AS SINGLE
DIM SHARED rotate AS SINGLE
DIM SHARED gun(1000), brick.grey(400)
FOR i% = 1 TO 26
FOR A% = 1 TO 22
 READ level%(A%, i%)
NEXT A%
NEXT i%

Factor! = (ATN(1) * 8) / 360
FOR A% = 0 TO 359
  ang! = CSNG(A%) * Factor!
  angle!(A%, 1) = SIN(ang!) * .1
  angle!(A%, 2) = COS(ang!) * .1
NEXT
FOR A% = -31 TO -1
  angle!(A%, 1) = angle!(A% + 360, 1)
  angle!(A%, 2) = angle!(A% + 360, 2)
NEXT
FOR A% = 360 TO 360 + 32
  angle!(A%, 1) = angle!(A% - 360, 1)
  angle!(A%, 2) = angle!(A% - 360, 2)
NEXT

over! = 2: up! = 2: dir! = 180: amount! = 4
active% = 1: visual% = 2: rotate! = 15
CLS : SCREEN 7, , active%, visual%
GOSUB DrawScreen

DO
 key$ = INKEY$
 SELECT CASE key$
  CASE CHR$(0) + "H"
   over2! = over! - (angle!(dir!, 2) * amount!)
   up2! = up! - (angle!(dir!, 1) * amount!)
   IF level%(over2!, up2!) = 0 THEN
    over! = over2!
    up! = up2!
    GOSUB DrawScreen
   END IF
  CASE CHR$(0) + "P"
   over2! = over! + (angle!(dir!, 2) * amount!)
   up2! = up! + (angle!(dir!, 1) * amount!)
   IF level%(over2!, up2!) = 0 THEN
    over! = over2!
    up! = up2!
    GOSUB DrawScreen
   END IF
  CASE CHR$(0) + "K"
    dir! = (dir! + rotate!) MOD 360
    GOSUB DrawScreen
  CASE CHR$(0) + "M"
    dir! = (dir! + (360 - rotate!)) MOD 360
    GOSUB DrawScreen
 END SELECT
LOOP

DrawScreen:
 CLS
 drawover% = 0: door% = 0
 FOR A% = dir! + 32 TO dir! - 31 STEP -2
   StpX! = angle!(A%, 2)
   StpY! = angle!(A%, 1)
   XX! = over!
   YY! = up!
   Leng% = 0
   DO
     XX! = XX! - StpX!
     YY! = YY! - StpY!
     Leng% = Leng% + 1
     check% = level%(XX!, YY!)
   LOOP UNTIL check% <> 0
   DD% = 900 \ Leng%
   Height% = DD% + DD%
   far% = 100 - DD%
  
   LINE (drawover%, far%)-STEP(9, Height%), check%, BF
  
   drawover% = drawover% + 10
 NEXT A%
 PCOPY active%, visual%
RETURN

DATA  3,11, 3,11, 3,11, 3,11, 3,11, 3,11, 3,11, 3,11, 3,11, 3,11, 3,11
DATA 11, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3
DATA  3, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0,11
DATA 11, 0, 0, 1, 0, 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0,15, 0, 0, 3
DATA  3, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0,11
DATA 11, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 3
DATA  3, 0, 0, 1, 0, 0, 1, 0, 0, 5, 0, 0, 0,12, 0, 0, 0, 0, 0, 0 ,0,11
DATA 11, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 3
DATA  3, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0,12, 0, 0, 0, 0, 0, 0 ,0,11
DATA 11, 0, 0, 1, 0, 0, 1, 0, 0, 6, 0, 0, 0, 4,12, 4,12, 4,12, 0, 0, 3
DATA  3, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0,11
DATA 11, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3
DATA  3, 2,10, 2,10, 2,10, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0,11
DATA 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3
DATA  3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0,11
DATA 11, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3
DATA  3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4,12, 4,12, 4,12, 0 ,0,11
DATA 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,12, 0, 0, 0, 0, 0, 0, 0, 3
DATA  3, 0, 0, 7, 8, 7, 8, 7, 8, 7, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0 ,0,11
DATA 11, 0, 0, 0, 0, 0,14, 0, 0, 0, 0, 0, 0,12, 0, 0, 0, 0, 0, 0, 0, 3
DATA  3, 0, 0, 0, 0, 0,10, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0 ,0,11
DATA 11, 0, 0, 0, 0, 0,14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3
DATA  3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,15, 0 ,0,11
DATA 11, 0, 0, 0, 0, 0,14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3
DATA  3, 0, 0, 0, 0, 0,10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0,11
DATA 11, 3,11, 3,11, 3,11, 3,11, 3,11, 3,11, 3,11, 3,11, 3,11, 3,11, 3

'     1, 2, 3 ,4 ,5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20,21,22

