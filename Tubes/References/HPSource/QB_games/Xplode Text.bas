DEFINT A-Z
DECLARE SUB explode (w$, x, y, z)
DECLARE SUB setcolors ()
DIM SHARED xx(10000), yy(10000)
DIM SHARED xi(10000), yi(10000)
SCREEN 12
RANDOMIZE TIMER
SLEEP 1
setcolors
explode "DaViD CaLhOuN", 260, 150, 1
explode "PrEsEnTeS", 262, 150, 1
explode "SoMeThInG", 262, 150, 1
COLOR 8

SUB explode (w$, x, y, z)

COLOR 1
LOCATE 1, 1
PRINT w$

FOR y1 = 0 TO 15
 FOR x1 = 0 TO LEN(w$) * 8
  IF POINT(x1, y1) = 1 THEN
   xx(arr) = x1 + x
   yy(arr) = y1 + y
1 :
   xi(arr) = (RND * 10) - (RND * 10)
   yi(arr) = (RND * 10) - (RND * 10)
   IF xi(arr) = 0 AND yi(arr) = 0 THEN GOTO 1
   arr = arr + 1
  END IF
 NEXT
NEXT

FOR c = 0 TO arr - 1
 PSET (xx(c), yy(c)), 15
NEXT

FOR atrib = 0 TO 63
 FOR c = 1 TO 100
  WAIT 986, 8
 NEXT
 OUT &H3C8, 15
 OUT &H3C9, atrib
 OUT &H3C9, atrib
 OUT &H3C9, atrib
NEXT

IF z <> 0 THEN SLEEP z

DO UNTIL atrib <= 0
 WAIT 986, 8
 FOR c = 0 TO arr - 1
  PRESET (xx(c), yy(c))
  xx(c) = xx(c) + xi(c)
  yy(c) = yy(c) + yi(c)
  PSET (xx(c), yy(c)), 15
  IF INKEY$ <> "" THEN END
 NEXT
 aa = aa + 1
 IF a MOD 2 = 0 THEN atrib = atrib - 1
 OUT &H3C8, 15
 OUT &H3C9, atrib
 OUT &H3C9, atrib
 OUT &H3C9, atrib
LOOP
CLS

END SUB

SUB setcolors

OUT &H3C8, 1
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, 0

OUT &H3C8, 15
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, 0

END SUB

