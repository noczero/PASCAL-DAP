
REM Star Gazing
REM By Ben McGaughey

CLS
PRINT "Fly a ship program."
PRINT
PRINT "0-9 = velosity (0 is no thruster)"
PRINT "Right and Left arrows incerease and decrease velosity."
PRINT "Up and Down arrows to move vertically."
PRINT "S = Stop the verticle movement."
PRINT "ESC = End"
WHILE INKEY$ = "": WEND
SCREEN 8, 0, 3, 0
DIM arr1(150), arr2(150)
FOR a = 0 TO 149
READ arr1(a)
NEXT a

FOR a = 0 TO 149
READ arr2(a)
NEXT a

FOR a = 0 TO 149
PSET (x, y), arr1(a)
PSET (x + 25, y), arr2(a)
x = x + 1
IF x = 25 THEN x = 0: y = y + 1
NEXT a

GET (0, 0)-(24, 5), arr1(0)
GET (25, 0)-(49, 5), arr2(0)

CLS
SCREEN 8, 0, 2, 2

TYPE vertex
 x AS INTEGER
 y AS INTEGER
 c AS INTEGER
END TYPE

DIM star(100) AS vertex

RANDOMIZE TIMER
FOR i = 0 TO 20
star(i).x = (RND * 640) + 1
star(i).y = (RND * 200) + 1
star(i).c = (RND * 2) + 1
IF star(i).c = 1 THEN star(i).c = 8
IF star(i).c = 2 THEN star(i).c = 7
IF star(i).c = 3 THEN star(i).c = 7
PSET (star(i).x, star(i).y), star(i).c
NEXT i

g = 100

WHILE kbd$ = ""
1
kbd$ = INKEY$
SCREEN 8, 0, 2, 2

FOR i = 0 TO 20
star(i).x = star(i).x - 10
PSET (star(i).x, star(i).y), star(i).c
IF star(i).x < 0 THEN
   star(i).x = 640
   star(i).y = (RND * 200) + 1
END IF
NEXT i

SCREEN 8, 0, 2, 2': PCOPY 1, 2

PUT (f, g), arr2(0), AND
PUT (f, g), arr1(0), XOR
IF f + velosity <= 614 THEN f = f + velosity
IF uv = 1 THEN
   IF g < 189 THEN g = g + vvelosity
   IF g < 189 AND vvelosity = 0 THEN g = g + 1
   IF gostop = 1 THEN
      IF vvelosity > 0 THEN vvelosity = vvelosity - 1
      IF vvelosity = 0 THEN gostop = 0: uv = 0
   END IF
END IF
IF uv = 2 THEN
   IF g > vvelosity THEN g = g - vvelosity
   IF g > 1 AND vvelosity = 0 THEN g = g - 1
   IF gostop = 1 THEN
      IF vvelosity > 0 THEN vvelosity = vvelosity - 1
      IF vvelosity = 0 THEN gostop = 0: uv = 0
   END IF
END IF
IF velosity = 0 AND f > 1 THEN f = f - 2

SCREEN 8, 0, 0, 0:  PCOPY 2, 0
PCOPY 1, 2
'Awsome code that does away with flicker! (WAIT)
WAIT &H3DA, 8
WEND

SELECT CASE kbd$
 CASE CHR$(0) + "P"
   IF uv = 0 THEN uv = 1
   IF uv = 2 THEN
   IF vvelosity > 0 THEN vvelosity = vvelosity - 1
   IF vvelosity = 0 THEN uv = 1
   END IF
   IF uv = 1 AND vvelosity < 9 THEN vvelosity = vvelosity + 1
   GOTO 1
 CASE CHR$(0) + "H"
   IF uv = 0 THEN uv = 2
   IF uv = 1 THEN
   IF vvelosity > 0 THEN vvelosity = vvelosity - 1
   IF vvelosity = 0 THEN uv = 2
   END IF
   IF uv = 2 AND vvelosity < 9 THEN vvelosity = vvelosity + 1
   GOTO 1
 CASE CHR$(0) + "M"
   IF velosity < 9 THEN velosity = velosity + 1
   GOTO 1
 CASE CHR$(0) + "K"
   IF velosity > 0 THEN velosity = velosity - 1
   GOTO 1
 CASE "s", "S"
   gostop = 1
   GOTO 1
 CASE "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
   velosity = VAL(kbd$)
   GOTO 1
 CASE CHR$(27)
   GOTO nono
 CASE ELSE
   GOTO 1
END SELECT

nono:

WHILE INKEY$ = "": WEND
SCREEN 0: WIDTH 80
END

'     1   2   3   4   5   6   7   8   9   0   1   2   3   4   5   6   7   8   9 0   1   2   3   4   5
DATA 000,000,000,000,008,008,008,007,007,007,007,007,000,000,000,000,000,000,000,000,000,000,000,000,000
DATA 000,008,008,008,008,008,007,014,007,007,014,007,007,007,007,007,007,007,007,000,000,000,000,000,000
DATA 008,008,008,008,008,007,007,007,007,007,007,007,007,007,007,007,007,007,007,007,007,007,007,007,007
DATA 000,000,000,000,000,000,007,007,007,007,007,000,000,000,000,000,000,000,000,000,000,000,000,000,000
DATA 000,000,000,000,000,000,000,007,007,007,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000
DATA 004,004,004,004,004,014,014,007,007,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000

DATA 015,015,015,015,000,000,000,000,000,000,000,000,015,015,015,015,015,015,015,015,015,015,015,015,015
DATA 015,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,015,015,015,015,015,015
DATA 000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000
DATA 015,015,015,015,015,015,000,000,000,000,000,015,015,015,015,015,015,015,015,015,015,015,015,015,015
DATA 015,015,015,015,015,015,015,000,000,000,015,015,015,015,015,015,015,015,015,015,015,015,015,015,015
DATA 000,000,000,000,000,000,000,000,000,015,015,015,015,015,015,015,015,015,015,015,015,015,015,015,015


