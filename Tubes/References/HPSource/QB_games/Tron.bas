SCREEN 12
RANDOMIZE TIMER
a = TIMER
DO
c = c + .5
B = TIMER
LOOP WHILE B - 1 < a
csw = c
abf:
INPUT "1 oder 2 Spieler?"; n
IF n > 2 OR n < 1 THEN GOTO abf
abf2:
INPUT "Feine(1) oder grobe(2) Steuerung"; ste
IF ste > 2 OR ste < 1 THEN GOTO abf2
KEY 15, CHR$(0) + CHR$(30)
KEY 16, CHR$(0) + CHR$(32)
ON KEY(12) GOSUB li2
ON KEY(13) GOSUB re2
ON KEY(15) GOSUB li1
ON KEY(16) GOSUB re1
KEY(12) ON
KEY(13) ON
KEY(15) ON
KEY(16) ON
c1 = 4
c2 = 2
cr = 8
level1:
CLS
GOSUB rand
x1 = 100
x2 = 540
y1 = 220
y2 = 220
ri1 = 1
ri2 = 3
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level1
level2:
CLS
GOSUB rand
LINE (300, 50)-(340, 400), cr, BF
LINE (50, 200)-(600, 240), cr, BF
x1 = 30
x2 = 600
y1 = 400
y2 = 400
ri1 = 0
ri2 = 0
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level2
level3:
CLS
GOSUB rand
FOR j = 100 TO 540 STEP 5
LINE (j, 100)-(j, 340), cr
NEXT
x1 = 30
x2 = 600
y1 = 400
y2 = 400
ri1 = 1
ri2 = 3
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level3
level4:
CLS
GOSUB rand
cm = 1
GOSUB muster1
x1 = 50
x2 = 570
y1 = 400
y2 = 100
ri1 = 0
ri2 = 2
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level4
level5:
CLS
GOSUB rand
FOR j = 50 TO 600 STEP 40
FOR k = 50 TO 400 STEP 40
LINE (j, k)-(j + 20, k), cr
LINE (j + 30, k)-(j + 30, k + 20), cr
LINE (j + 30, k + 30)-(j + 10, k + 30), cr
LINE (j, k + 10)-(j, k + 30), cr
NEXT: NEXT
x1 = 15
x2 = 625
y1 = 15
y2 = 15
ri1 = 1
ri2 = 3
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level5
level6:
CLS
GOSUB rand
FOR j = 50 TO 600 STEP 30
FOR k = 50 TO 400 STEP 30
LINE (j - 10, k)-(j + 10, k), cr
LINE (j, k + 20)-(j + 20, k + 20), cr
LINE (j + 10, k - 10)-(j + 10, k + 10), cr
LINE (j, k + 10)-(j, k + 30), cr
NEXT: NEXT
x1 = 15
x2 = 625
y1 = 15
y2 = 15
ri1 = 1
ri2 = 3
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level6
level7:
CLS
FOR j = 0 TO 200 STEP 50
LINE (j, j)-(640 - j, 440 - j), cr, BF
LINE (j + 10, j + 10)-(630 - j, 430 - j), 0, BF
NEXT
LINE (50, 200)-(620, 240), 0, BF
LINE (300, 50)-(340, 420), 0, BF
x1 = 20
x2 = 620
y1 = 220
y2 = 220
ri1 = 1
ri2 = 3
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level7
level8:
CLS
GOSUB rand
GOSUB muster2
x1 = 50
x2 = 570
y1 = 400
y2 = 100
ri1 = 0
ri2 = 2
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level8
level9:
CLS
PAINT (100, 100), cr
FOR j = 10 TO 630 STEP 4
LINE (j, 10)-(j + 1, 430), 0, B
NEXT
FOR j = 10 TO 430 STEP 4
LINE (10, j)-(630, j + 1), 0, B
NEXT
x1 = 26
y1 = 20
x2 = 602
y2 = 420
ri1 = 2
ri2 = 0
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level9
level10:
CLS
LINE (0, 0)-(640, 440), cr, BF
LINE (50, 50)-(590, 390), 0, BF
LINE (70, 70)-(410, 210), cr, BF
LINE (430, 70)-(570, 210), cr, BF
LINE (70, 230)-(410, 370), cr, BF
LINE (430, 230)-(570, 370), cr, BF
x1 = 90
x2 = 550
y1 = 220
y2 = 220
ri1 = 1
ri2 = 3
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level10
level11:
CLS
CIRCLE (320, 220), 210, cr
PAINT (10, 10), cr
x1 = 319
y1 = 220
x2 = 321
y2 = 220
ri1 = 3
ri2 = 1
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level11
level12:
FOR k = 200 TO 400 STEP 50
CLS
GOSUB rand
FOR j = 0 TO k
xp = CINT(RND * 620) + 10
yp = CINT(RND * 420) + 10
CIRCLE (xp, yp), (k - 150) / 50, cm
NEXT
x1 = 100
x2 = 540
y2 = 220
y1 = 220
ri1 = 1
ri2 = 3
GOSUB abfrage
NEXT
level13:
CLS
PAINT (100, 100), cr
FOR j = 10 TO 630 STEP 16
LINE (j, 10)-(j + 1, 430), 0, B
NEXT
FOR j = 10 TO 430 STEP 16
LINE (10, j)-(630, j + 1), 0, B
NEXT
x1 = 26
y1 = 20
x2 = 602
y2 = 420
ri1 = 2
ri2 = 0
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level13
level14:
CLS
GOSUB rand
FOR j = 0 TO 500
xp = CINT(RND * 620) + 10
yp = CINT(RND * 420) + 10
CIRCLE (xp, yp), 1, INT(j / 500 * 15)
NEXT
x1 = 100
x2 = 540
y2 = 220
y1 = 220
ri1 = 1
ri2 = 3
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level14
level15:
GOSUB rand
FOR j = 0 TO 500
xp = CINT(RND * 620) + 10
yp = CINT(RND * 420) + 10
LINE (xp, yp)-(xp + 10, yp), cr
xp = CINT(RND * 620) + 10
yp = CINT(RND * 420) + 10
LINE (xp, yp)-(xp, yp + 10), cr
NEXT
x1 = 100
x2 = 540
y2 = 220
y1 = 220
ri1 = 1
ri2 = 3
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level15
level16:
CLS
PAINT (10, 10), cr
CIRCLE (200, 220), 80, 0
PAINT (200, 220), 0
CIRCLE (400, 220), 80, 0
PAINT (400, 220), 0
FOR j = 150 TO 290 STEP 8
LINE (200, j)-(400, j + 1), 0, BF
NEXT
x1 = 200
x2 = 400
y1 = 290
y2 = 150
ri1 = 0
ri2 = 2
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level16
level17:
FOR t = 5 TO 1 STEP -1
CLS
PAINT (10, 10), cr
LINE (100, 100)-(540, 200), 0, BF
LINE (100, 300)-(200, 400), 0, BF
LINE (148, 200)-(148 + t, 300), 0, BF
LINE (540, 300)-(440, 400), 0, BF
LINE (488, 200)-(488 + t, 300), 0, BF
x1 = 102
x2 = 538
y1 = 398
y2 = 398
ri1 = 0
ri2 = 0
GOSUB abfrage
NEXT
level18:
GOSUB rand
FOR j = 0 TO 100
xp = CINT(RND * 620) + 10
yp = CINT(RND * 420) + 10
LINE (xp, yp)-(xp + 20, yp), cr
xp = CINT(RND * 620) + 10
yp = CINT(RND * 420) + 10
LINE (xp, yp)-(xp, yp + 20), cr
NEXT
x1 = 100
x2 = 540
y2 = 220
y1 = 220
ri1 = 1
ri2 = 3
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level18
level19:
CLS
PAINT (10, 10), 8
CIRCLE (420, 220), 200, 0
PAINT (420, 220), 0
CIRCLE (420, 220), 180, 8
PAINT (420, 220), 8
LINE (220, 220)-(240, 420), 0, BF
x1 = 220
x2 = 225
y1 = 400
y2 = 400
ri1 = 0
ri2 = 0
GOSUB abfrage
IF nochma = 1 THEN nochma = 0: GOTO level19
level20:
CLS
GOSUB rand
LOCATE 10, 10
PRINT "TRON. Programmed by Thomas Hirsch."
LOCATE 12, 15
PRINT "Quoppyreit 1996 Quaxx Cooporation"
LOCATE 14, 20
PRINT "Have Fun!"
x1 = 218
x2 = x1 + 5
y1 = 156
y2 = y1
ri1 = 3
ri2 = 1
GOSUB abfrage
SYSTEM
abfrage:
DO
LINE (x1, y1)-(x1, y1), c1
IF n = 2 THEN LINE (x2, y2)-(x2, y2), c2
IF ri1 = 0 THEN y1 = y1 - 1
IF ri1 = 1 THEN x1 = x1 + 1
IF ri1 = 2 THEN y1 = y1 + 1
IF ri1 = 3 THEN x1 = x1 - 1
IF ste = 1 THEN
IF ri1 = .5 THEN y1 = y1 - 1: x1 = x1 + 1
IF ri1 = 1.5 THEN x1 = x1 + 1: y1 = y1 + 1
IF ri1 = 2.5 THEN y1 = y1 + 1: x1 = x1 - 1
IF ri1 = 3.5 THEN x1 = x1 - 1: y1 = y1 - 1
END IF
IF n = 2 THEN
IF ri2 = 0 THEN y2 = y2 - 1
IF ri2 = 1 THEN x2 = x2 + 1
IF ri2 = 2 THEN y2 = y2 + 1
IF ri2 = 3 THEN x2 = x2 - 1
IF ste = 1 THEN
IF ri2 = .5 THEN y2 = y2 - 1: x2 = x2 + 1
IF ri2 = 1.5 THEN x2 = x2 + 1: y2 = y2 + 1
IF ri2 = 2.5 THEN y2 = y2 + 1: x2 = x2 - 1
IF ri2 = 3.5 THEN x2 = x2 - 1: y2 = y2 - 1
END IF
END IF
IF n = 2 THEN
IF POINT(x1, y1) <> 0 AND POINT(x2, y2) <> 0 THEN GOSUB beidebumm: RETURN
IF POINT(x2, y2) <> 0 THEN GOSUB bumm2: RETURN
END IF
IF POINT(x1, y1) <> 0 THEN GOSUB bumm1: RETURN
FOR j = 0 TO csw / 6: NEXT
LOOP

rand:
LINE (0, 0)-(640, 440), cr, BF
LINE (10, 10)-(630, 430), 0, BF
RETURN

muster1:
LINE (30, 20)-(40, 30), cm
LINE -(30, 40), cm
LINE -(20, 30), cm
LINE -(30, 20), cm
DIM mus(127)
GET (20, 20)-(40, 40), mus
FOR j = 20 TO 600 STEP 40
FOR k = 20 TO 400 STEP 40
PUT (j, k), mus, PSET
NEXT: NEXT
RETURN
muster2:
CIRCLE (30, 30), 10, 14
PAINT (30, 30), 14
CIRCLE (26, 26), 2, 0
CIRCLE (34, 26), 2, 0
LINE (23, 33)-(26, 35), 0
LINE -(34, 35), 0
LINE -(37, 33), 0
GET (20, 20)-(40, 40), mus
FOR j = 20 TO 600 STEP 40
FOR k = 20 TO 400 STEP 40
PUT (j, k), mus, PSET
NEXT: NEXT
RETURN



'STOP     hIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIer

li1:
ri1 = ri1 - .5 * ste
IF ri1 < 0 THEN ri1 = 3.5 - (ste - 1) * .5
RETURN
li2:
ri2 = ri2 - .5 * ste
IF ri2 < 0 THEN ri2 = 3.5 - (ste - 1) * .5
RETURN
re1:
ri1 = ri1 + .5 * ste
IF ri1 > 3.5 THEN ri1 = 0
RETURN
re2:
ri2 = ri2 + .5 * ste
IF ri2 > 3.5 THEN ri2 = 0
RETURN

bumm1:
xb = x1
yb = y1
GOSUB explo
IF n = 2 THEN
LOCATE 28, 1: PRINT "Spieler 2 hat gewonnen!"
p2 = p2 + 1
END IF
do:loop while inkey$=""
RETURN
bumm2:
xb = x2
yb = y2
GOSUB explo
LOCATE 28, 1: PRINT "Spieler 1 hat gewonnen!"
p1 = p1 + 1
do:loop while inkey$=""
RETURN
beidebumm:
xb = x1
yb = y1
GOSUB explo
xb = x2
yb = y2
GOSUB explo
LOCATE 28, 1: PRINT "Beide Spieler sind zerst”rt. Level wiederholen!"
nochma = 1
do:loop while inkey$=""
RETURN

explo:
FOR j = 0 TO 20 + csw / 50 STEP 2
CIRCLE (xb, yb), j, 4
CIRCLE (xb, yb), j + 1, 14
NEXT
RETURN



