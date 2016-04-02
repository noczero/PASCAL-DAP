'   *   *             *   *           *         *      *
'        *      *      ***STARBALL***   * *       *      *
' *       *       *       *        *            *               *

'  Programmed by Gunne Ekelin 1997.   (Metroid music by Jonas Thulin)
'  Player one operates his pad with the number keys "4", "5" and "6".
'  "4" moves left, "5" stops and "6" moves right.
'  Player two operates with the "a", "s" and "d" buttons.
'  "a" moves left, "s" stops and "d" mover right.
' You can set the speed in the "start" sub, change the value on speed.



DECLARE SUB paus ()
DECLARE SUB start ()
DECLARE SUB dod ()
DECLARE SUB nerve ()
DECLARE SUB upve ()
DECLARE SUB nerho ()
DECLARE SUB upho ()
SCREEN 13
DIM SHARED padd1(300)
DIM SHARED padd2(300)
DIM SHARED boll(200)
DIM SHARED bild1(10000)
DIM SHARED bild2(10000)
DIM SHARED bild3(10000)
DIM SHARED dirc
DIM SHARED dird
DIM SHARED paf
DIM SHARED a
DIM SHARED b
DIM SHARED c
DIM SHARED d
DIM SHARED x
DIM SHARED y
DIM SHARED PO1%
DIM SHARED PO2%
DIM SHARED z
DIM SHARED e
DIM SHARED K$
DIM SHARED speed
DIM SHARED check
DIM SHARED ron
DEF SEG = 0: keylock = PEEK(1047): POKE 1047, 96

LOCATE 2, 2
PRINT "LOADING GRAPHICS........"
DRAW "c14r40e5h2l46g2f5bu6bl3c43r46f1g4l40h4C42br1R46g3l40h3"
PAINT STEP(10, 2), 41, 42
GET (155, 93)-(205, 100), padd1
CLS
PSET (205, 90), 0
DRAW "a2c14r40e5h2l46g2f5bu6bl3c43r46f1g4l40h4C42br1R46g3l40h3"
PAINT STEP(-10, -2), 41, 42
GET (160, 90)-(210, 97), padd2
CIRCLE (100, 100), 5, 54
PAINT (100, 100), 15, 54
GET (95, 95)-(105, 105), boll
CLS
PLAY "mbl50o5gcgfddeccdgeegceegcgfddeceegcgfdddecc"
FOR t = 1 TO 500
RANDOMIZE TIMER
x = (RND * 300) + 10
y = (RND * 180) + 10
q = INT(RND * 50) + 1
PSET (x, y), 1
IF q = 1 OR q = 2 OR q = 3 THEN PSET (x + 1, y + 1), 15
IF q = 4 THEN
 PSET (x, y), 15
 LINE (x, y - 1)-(x, y - 3), 1
 LINE (x + 1, y)-(x + 3, y), 1
 LINE (x, y + 1)-(x, y + 3), 1
 LINE (x - 1, y)-(x - 3, y), 1
END IF
NEXT t
GET (10, 10)-(210, 100), bild1
GET (10, 100)-(210, 190), bild2
GET (210, 10)-(310, 190), bild3
LOCATE 5, 1
PRINT "                STAR BALL"
PRINT
PRINT "          To control the paddles"
PRINT
PRINT "            use a,s,d VS 4,5,6"
FOR t = 1 TO 10
a = a + 1
b = b - 1
LINE (b + 10, b + 10)-(a + 310, a + 190), b + 26, B
NEXT t
PLAY "mbT200L5O1F#O2F#O1F#O2L5G#G#L5O1F#O2F#O1F#O2L5G#G#"
PLAY "mbT200L5O1EO2F#O1EO2L5G#G#L5O1EO2F#O1EO2L5G#G#"
PLAY "mbT200L5O1F#O2F#O1F#O2L5G#G#L5O1F#O2F#O1F#O2L5G#G#"
PLAY "mbT200L5O1EO2F#O1EO2L5G#G#L5O1EO2F#O1EO2L5G#G#"
CALL start

SUB dod
FOR z = 3 TO 9 STEP .2
SOUND 120 + z ^ 4, .1
NEXT z
PUT (10, 10), bild1, PSET
PUT (10, 100), bild2, PSET
PUT (210, 10), bild3, PSET
LOCATE 6, 10
IF check = 1 THEN
PRINT "-=:PLAYER ONE SCORES:=-"
ELSE PRINT "-=:PLAYER TWO SCORES:=-"
END IF
LOCATE 20, 17
PRINT "GET READY"
ron = ron + 1
SLEEP
IF ron < 10 THEN CALL start:
POKE 1047, keylock
SYSTEM
END SUB

SUB nerho
PUT (c, d), boll, OR
nerho:
PUT (c, d), boll, XOR
c = c + dirc
d = d + dird
K$ = INKEY$
PUT (c, d), boll
PUT (a, b), padd1, OR
PUT (x, y), padd2, OR
FOR t = 1 TO speed: NEXT t
IF K$ = CHR$(27) THEN CALL paus
IF K$ = "4" THEN z = 1
IF K$ = "5" THEN z = 0
IF K$ = "6" THEN z = 2
IF z = 1 THEN PUT (a, b), padd1, XOR: a = a - paf
IF z = 2 THEN PUT (a, b), padd1, XOR: a = a + paf
IF K$ = "a" OR K$ = "A" THEN e = 1
IF K$ = "s" OR K$ = "S" THEN e = 0
IF K$ = "d" OR K$ = "D" THEN e = 2
IF e = 1 THEN PUT (x, y), padd2, XOR: x = x - paf
IF e = 2 THEN PUT (x, y), padd2, XOR: x = x + paf
IF a > 260 THEN a = a - paf: z = 0
IF a < 10 THEN a = a + paf: z = 0
IF x > 260 THEN x = x - paf: e = 0
IF x < 10 THEN x = x + paf: e = 0
IF d > 170 AND d < 173 AND c > a + 5 AND c < a + 35 THEN SOUND 333, .1: CALL upho
IF d > 170 AND d < 173 AND c > a - 8 AND c < a + 6 THEN SOUND 333, .1: dirc = dirc - .3: dird = dird + .3: CALL upho
IF d > 170 AND d < 173 AND c > a + 34 AND c < a + 48 THEN SOUND 333, .1: dirc = dirc + .3: dird = dird - .3: CALL upho
IF dird > 2.5 THEN dird = 2.1
IF dird < .2 THEN dird = .25
IF dirc < .2 THEN dirc = .25
IF dirc > 2.5 THEN dirc = 2.1
IF c > 297 THEN SOUND 333, .1: CALL nerve
IF d > 179 THEN PO2% = PO2% + 1: check = 2: CALL dod
GOTO nerho:

END SUB

SUB nerve
PUT (c, d), boll, OR
nerve:
PUT (c, d), boll, XOR
c = c - dirc
d = d + dird
K$ = INKEY$
PUT (c, d), boll
PUT (a, b), padd1, OR
PUT (x, y), padd2, OR
FOR t = 1 TO speed: NEXT t
IF K$ = CHR$(27) THEN CALL paus
IF K$ = "4" THEN z = 1
IF K$ = "5" THEN z = 0
IF K$ = "6" THEN z = 2
IF z = 1 THEN PUT (a, b), padd1, XOR: a = a - paf
IF z = 2 THEN PUT (a, b), padd1, XOR: a = a + paf
IF K$ = "a" OR K$ = "A" THEN e = 1
IF K$ = "s" OR K$ = "S" THEN e = 0
IF K$ = "d" OR K$ = "D" THEN e = 2
IF e = 1 THEN PUT (x, y), padd2, XOR: x = x - paf
IF e = 2 THEN PUT (x, y), padd2, XOR: x = x + paf
IF a > 260 THEN a = a - paf: z = 0
IF a < 10 THEN a = a + paf: z = 0
IF x > 260 THEN x = x - paf: e = 0
IF x < 10 THEN x = x + paf: e = 0
IF d > 170 AND d < 173 AND c > a + 5 AND c < a + 35 THEN SOUND 333, .1: CALL upve
IF d > 170 AND d < 173 AND c > a - 8 AND c < a + 6 THEN SOUND 333, .1: dirc = dirc + .3: dird = dird - .3: CALL upve
IF d > 170 AND d < 173 AND c > a + 34 AND c < a + 48 THEN SOUND 333, .1: dirc = dirc - .3: dird = dird + .3: CALL upve
IF dird > 2.5 THEN dird = 2.1
IF dird < .2 THEN dird = .25
IF dirc < .2 THEN dirc = .25
IF dirc > 2.5 THEN dirc = 2.1
IF c < 13 THEN SOUND 333, .1: CALL nerho
IF d > 179 THEN PO2% = PO2% + 1: check = 2: CALL dod
GOTO nerve:

END SUB

SUB paus
e = 0
z = 0
pong1$ = "POINT"
pong2$ = "POINT"
IF PO2% > 1 OR PO2% = 0 THEN pong2$ = "POINTS"
IF PO1% > 1 OR PO1% = 0 THEN pong1$ = "POINTS"
LOCATE 5, 1
PRINT "            -=:GAME PAUSED:=-"
LOCATE 9, 1
PRINT "                 ROUND"; ron
LOCATE 12, 1
PRINT "           PLAYER ONE"; PO1%; pong1$
PRINT
PRINT "           PLAYER TWO"; PO2%; pong2$
LOCATE 19, 1
PRINT "         PUSH SPACEBAR TO RESUME,"
PRINT
PRINT "             ESCAPE TO QUIT."
FOR t = 1 TO 10
ty = ty + 1
yt = yt - 1
LINE (yt + 10, yt + 10)-(ty + 310, ty + 190), yt + 26, B
NEXT t
DO
K$ = INKEY$
IF K$ = CHR$(27) THEN END
IF K$ = " " THEN EXIT DO
LOOP
PUT (10, 10), bild1, PSET
PUT (10, 100), bild2, PSET
PUT (210, 10), bild3, PSET
PUT (c, d), boll, XOR
END SUB

SUB start
a = 100
b = 180
x = 200
y = 13
c = 100
d = 150
speed = 75     ' <=====  Change this to make the game go slower or faster.
paf = 1.5
dirc = 1
dird = 1
PUT (10, 10), bild1, PSET
PUT (10, 100), bild2, PSET
PUT (210, 10), bild3, PSET
CALL upho
END SUB

SUB upho
PUT (c, d), boll, OR
upho:
PUT (c, d), boll, XOR
c = c + dirc
d = d - dird
K$ = INKEY$
PUT (c, d), boll
PUT (a, b), padd1, OR
PUT (x, y), padd2, OR
FOR t = 1 TO speed: NEXT t
IF K$ = CHR$(27) THEN CALL paus
IF K$ = "4" THEN z = 1
IF K$ = "5" THEN z = 0
IF K$ = "6" THEN z = 2
IF z = 1 THEN PUT (a, b), padd1, XOR: a = a - paf
IF z = 2 THEN PUT (a, b), padd1, XOR: a = a + paf
IF K$ = "a" THEN e = 1
IF K$ = "s" THEN e = 0
IF K$ = "d" THEN e = 2
IF e = 1 THEN PUT (x, y), padd2, XOR: x = x - paf
IF e = 2 THEN PUT (x, y), padd2, XOR: x = x + paf
IF a > 260 THEN a = a - paf: z = 0
IF a < 10 THEN a = a + paf: z = 0
IF x > 260 THEN x = x - paf: e = 0
IF x < 10 THEN x = x + paf: e = 0
IF d < 20 AND d > 17 AND c > x + 5 AND c < x + 35 THEN SOUND 333, .1: CALL nerho
IF d < 20 AND d < 17 AND c > x - 8 AND c < x + 6 THEN SOUND 333, .1: dirc = dirc - .3: dird = dird + .3: CALL nerho
IF d < 20 AND d < 17 AND c > x + 34 AND c < x + 48 THEN SOUND 333, .1: dirc = dirc + .3: dird = dird - .3: CALL nerho
IF dird > 2.5 THEN dird = 2.1
IF dird < .2 THEN dird = .25
IF dirc < .2 THEN dirc = .25
IF dirc > 2.5 THEN dirc = 2.1
IF c > 297 THEN SOUND 333, .1: CALL upve
IF d < 11 THEN PO1% = PO1% + 1: check = 1: CALL dod
GOTO upho:
END SUB

SUB upve
PUT (c, d), boll, OR
upve:
PUT (c, d), boll, XOR
c = c - dirc
d = d - dird
K$ = INKEY$
PUT (c, d), boll
PUT (a, b), padd1, OR
PUT (x, y), padd2, OR
FOR t = 1 TO speed: NEXT t
IF K$ = CHR$(27) THEN CALL paus
IF K$ = "4" THEN z = 1
IF K$ = "5" THEN z = 0
IF K$ = "6" THEN z = 2
IF z = 1 THEN PUT (a, b), padd1, XOR: a = a - paf
IF z = 2 THEN PUT (a, b), padd1, XOR: a = a + paf
IF K$ = "a" OR K$ = "A" THEN e = 1
IF K$ = "s" OR K$ = "S" THEN e = 0
IF K$ = "d" OR K$ = "D" THEN e = 2
IF e = 1 THEN PUT (x, y), padd2, XOR: x = x - paf
IF e = 2 THEN PUT (x, y), padd2, XOR: x = x + paf
IF a > 260 THEN a = a - paf: z = 0
IF a < 10 THEN a = a + paf: z = 0
IF x > 260 THEN x = x - paf: e = 0
IF x < 10 THEN x = x + paf: e = 0
IF d < 20 AND d > 17 AND c > x + 5 AND c < x + 35 THEN SOUND 333, .1: CALL nerve
IF d < 20 AND d < 17 AND c > x - 8 AND c < x + 6 THEN SOUND 333, .1: dirc = dirc + .3: dird = dird - .3: CALL nerve
IF d < 20 AND d < 17 AND c > x + 34 AND c < x + 48 THEN SOUND 333, .1: dirc = dirc - .3: dird = dird + .3: CALL nerve
IF dird > 2.5 THEN dird = 2.1
IF dird < .2 THEN dird = .25
IF dirc < .2 THEN dirc = .25
IF dirc > 2.5 THEN dirc = 2.1
IF c < 13 THEN SOUND 333, .1: CALL upho
IF d < 11 THEN PO1% = PO1% + 1: check = 1: CALL dod
GOTO upve:

END SUB

