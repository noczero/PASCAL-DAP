' Downloaded from the QBasic Place
' http://qbplace.home.ml.org
' The one stop program shop.
'
DIM skier(1000)
DIM flag1(1000)
DIM flag2(1000)
DIM trad(1000)
RANDOMIZE TIMER
x = 150
y = 100
upp1 = 180: upp2 = 0

SCREEN 13
LINE (1, 1)-(11, 11), , BF
LINE (4, 2)-(4, 10), 1
LINE (8, 2)-(8, 10), 1
CIRCLE (6, 5), 3, 4
PAINT (6, 5), 4
CIRCLE (6, 5), 1, 9
PAINT (6, 5), 9
LINE (2, 2)-(2, 7), 7
LINE (10, 2)-(10, 7), 7
GET (1, 1)-(11, 11), skier
CLS
LINE (1, 1)-(7, 11), , BF
LINE (2, 2)-(2, 10), 7
LINE (6, 2)-(6, 10), 7
LINE (2, 2)-(6, 4), 12, BF
GET (1, 1)-(7, 11), flag1
LINE (1, 1)-(7, 11), , BF
LINE (2, 2)-(2, 10), 7
LINE (6, 2)-(6, 10), 7
LINE (2, 2)-(6, 4), 9, BF
GET (1, 1)-(7, 11), flag2

LINE (1, 1)-(12, 16), , BF
LINE (6, 1)-(2, 12), 190
LINE (6, 1)-(10, 12), 190
LINE (2, 12)-(11, 12), 190
PAINT (6, 4), 190
LINE (5, 13)-(7, 15), 8, BF
GET (1, 1)-(12, 16), trad
CLS

PAINT (1, 1), 26
LINE (90 + 2, 6 + 2)-(230 - 2, 193 - 2), 24, B
LINE (90 + 1, 6 + 1)-(230 - 1, 193 - 1), 22, B
LINE (90, 6)-(230, 193), 20, B
LINE (93, 9)-(227, 190), 15, BF

10
IF upp1 < 10 THEN
flags = 2: upp1 = 180
LINE (93, 9)-(227, 19), , BF
END IF
IF upp2 < 10 THEN
flags = 1: upp2 = 180
LINE (93, 9)-(227, 19), , BF
END IF
IF upp3 < 10 THEN
tree = 0: upp3 = 175
LINE (93, 9)-(227, 25), , BF
END IF

raktrad = raktrad + 1
IF raktrad > 1000 THEN tree = 1: raktrad = 0


IF flags = 1 THEN rand1 = INT(RND * 100) + 1: flags = 3
IF flags = 3 THEN upp1 = upp1 - .08: PUT (rand1 + 110, upp1), flag1, PSET
IF flags = 2 THEN rand2 = INT(RND * 100) + 1: flags = 4
IF flags = 4 THEN upp2 = upp2 - .08: PUT (rand2 + 110, upp2), flag2, PSET
IF tree = 1 THEN tree = 2
IF tree = 2 THEN upp3 = upp3 - .08: PUT (rand3 + 110, upp3), trad, PSET
IF tree = 0 THEN rand3 = INT(RND * 100) + 1



IF POINT(x + 10, y + 10) = 190 THEN
x = x - 1
y = y - 1
lod = 0
move = 0
END IF
IF POINT(x, y) = 190 THEN
x = x + 1
y = y - 1
lod = 0
move = 0
END IF



IF POINT(x, y) = 24 THEN
x = x + 1
y = y + 1
move = 0
lod = 0
END IF
IF POINT(x + 10, y + 10) = 24 THEN
y = y - 1
x = x - 1
move = 0
lod = 0
END IF




PUT (x, y), skier, PSET
SELECT CASE INKEY$
CASE CHR$(0) + "H": lod = lod - 1
IF lod < -2 THEN lod = -2
CASE CHR$(0) + "P": lod = lod + 1
IF lod > 2 THEN lod = 2
CASE CHR$(0) + "K": move = move - 1
IF move < -2 THEN move = -2
CASE CHR$(0) + "M": move = move + 1
IF move > 2 THEN move = 2

END SELECT
IF NOT move = 0 OR NOT lod = 0 THEN GOTO 500
GOTO 10


500
IF move = -1 THEN x = x - .04
IF move = -2 THEN x = x - .06
IF move = 1 THEN x = x + .04
IF move = 2 THEN x = x + .06
IF lod = -1 THEN y = y - .04
IF lod = -2 THEN y = y - .06
IF lod = 1 THEN y = y + .02
IF lod = 2 THEN y = y + .04
GOTO 10

