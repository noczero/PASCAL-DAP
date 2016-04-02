'    CURRENT STATUS:

'Sometimes freezes if x is off screen and y<0

'Most important stuff finished.

'Sleigh + presents

DECLARE SUB centre (row!, text$)
DECLARE SUB CheckHits1 ()
DECLARE SUB CheckInput ()
DECLARE SUB Dead ()
DECLARE SUB DropSantas ()
DECLARE SUB DrawLand ()
DECLARE SUB DrawSanta ()
DECLARE SUB Explode1 ()
DECLARE SUB Explode2 ()
DECLARE SUB Explode3 ()
DECLARE SUB Finish ()
DECLARE SUB MoveBall ()
DECLARE SUB PlotPath ()
DECLARE SUB Setup ()
DECLARE SUB Shoot ()

DIM SHARED Santa(96, 5)

DIM SHARED addx(20), addy(20), angle(4), capacity(4), CrossHair(50), Death$(20), dropy(50)
DIM SHARED dropx(50), fall(50), gone$(5), grounded(20), halt(4), HitAngle(20)
DIM SHARED oldangle(4), oldpower(4), oldx(50), oldy(50), power(4), SantaX(4)
DIM SHARED SantaY(4), SnowBall(50), x(20), y(20), z(10), zz(9)

DIM SHARED a, BallX, BallY, Blowup, check, Exploded, fallen, HitPoint, HitX, HitY
DIM SHARED key$, No.of.Deaths, origyadd, SantaFall, snowtime, ThrowPower, ThrowSnow, xadd
DIM SHARED yadd

RANDOMIZE TIMER
CONST PI = 3.14159
CONST pal& = 256
snowtime = 1
Blowup = 2

SCREEN 9, , 0, 0
Setup
DrawSanta
DrawLand

FOR snowdrop = 1 TO 50
dropx(snowdrop) = INT(RND * 640)
dropy(snowdrop) = INT(RND * 300)
fall(snowdrop) = INT(RND * 2) + 1
NEXT snowdrop

key$ = ""

a = 1
PUT (25 * COS(angle(a) * PI / 180) + SantaX(a), 25 * SIN(angle(a) * PI / 180) + SantaY(a) - 16), CrossHair, XOR

z(snowtime) = TIMER
PALETTE 10, 63

DO
IF TIMER > z(snowtime) + .001 THEN
FOR snowdrop = 1 TO 50
    IF gone = 1 THEN PSET (dropx(snowdrop), dropy(snowdrop)), 0
    dropy(snowdrop) = dropy(snowdrop) + fall(snowdrop)
    IF POINT(dropx(snowdrop), dropy(snowdrop)) <> 0 THEN dropy(snowdrop) = 1: dropx(snowdrop) = INT(RND * 640): fall(snowdrop) = INT(RND * 2) + 1
    PSET (dropx(snowdrop), dropy(snowdrop)), 7
    key$ = INKEY$
    IF key$ <> "" AND ThrowSnow = 0 THEN CheckInput
    IF key$ = CHR$(27) THEN END
NEXT snowdrop
IF ThrowSnow = 1 THEN MoveBall
IF Exploded = 1 THEN Explode1
IF Exploded = 2 THEN Explode2
IF Exploded = 3 THEN Explode3
gone = 1
z(snowtime) = TIMER
END IF
LOCATE 1, 70: PRINT TIME$
LOOP UNTIL key$ = CHR$(27)

SUB centre (row, text$)
    LOCATE row, 41 - LEN(text$) / 2
    PRINT text$;
END SUB

SUB CheckHits1
FOR check = 1 TO 4
    IF capacity(check) > 0 THEN
        IF HitX > SantaX(check) - 14 AND HitX < SantaX(check) + 14 THEN
            IF HitY > SantaY(check) - 27 AND HitY < SantaY(check) + 1 THEN
                capacity(check) = capacity(check) - 10
                LOCATE 42, ((check - 1) * 20) + 3
                SELECT CASE check
                    CASE 1: c = 7
                    CASE 2: c = 14
                    CASE 3: c = 12
                    CASE 4: c = 9
                END SELECT
                COLOR c
                PRINT " Capacity:"; capacity(check);
                IF capacity(check) <= 0 THEN Dead
            END IF
        END IF
    END IF
NEXT check
END SUB

SUB CheckInput
oldangle(a) = angle(a)
oldpower(a) = power(a)
SELECT CASE key$
    CASE CHR$(0) + "H": angle(a) = angle(a) - 1   'up=i.e. anticlockwise
    CASE CHR$(0) + "M": power(a) = power(a) + 1   'left
    CASE CHR$(0) + "P": angle(a) = angle(a) + 1   'down=i.e. clockwise
    CASE CHR$(0) + "K": power(a) = power(a) - 1   'right
    'CASE CHR$(0) + "R":  'Insert
    CASE CHR$(0) + "S": power(a) = power(a) - 10  'Delete
    'CASE CHR$(0) + "G":  'Home
    CASE CHR$(0) + "O": power(a) = power(a) + 10  'end
    CASE CHR$(0) + "I": angle(a) = angle(a) - 10'  PgUp
    CASE CHR$(0) + "Q": angle(a) = angle(a) + 10  'PgDown
    CASE " ": Shoot
    CASE ELSE: EXIT SUB
END SELECT

IF angle(a) > 360 THEN angle(a) = angle(a) - 360
IF angle(a) < 0 THEN angle(a) = angle(a) + 360
IF power(a) < 0 THEN power(a) = 0

IF angle(a) <> oldangle(a) THEN
    PUT (25 * COS(oldangle(a) * PI / 180) + SantaX(a), 25 * SIN(oldangle(a) * PI / 180) + SantaY(a) - 16), CrossHair, XOR
    PUT (25 * COS(angle(a) * PI / 180) + SantaX(a), 25 * SIN(angle(a) * PI / 180) + SantaY(a) - 16), CrossHair, XOR
END IF

LOCATE 1, 1: PRINT "Angle:"; angle(a)
LOCATE 2, 1: PRINT "Power:"; power(a)
key$ = ""
END SUB

SUB Dead
'Blow up the Santa!!!

FOR r = 0 TO 19 STEP 1
IF r / 2 = INT(r / 2) THEN COLOR 4
IF r / 2 <> INT(r / 2) THEN COLOR 12
CIRCLE (SantaX(check), SantaY(check) - 12), r
z(Blowup) = TIMER
DO UNTIL TIMER >= z(Blowup) + .0000000001#: LOOP
NEXT r
FOR r = 0 TO 19 STEP 1
CIRCLE (SantaX(check), SantaY(check) - 12), r, 0
z(Blowup) = TIMER
DO UNTIL TIMER >= z(Blowup) + .0000000001#: LOOP
NEXT r
CIRCLE (SantaX(check), SantaY(check) - 12), 19, 4
PAINT (SantaX(check), SantaY(check) - 12), 4, 4
CIRCLE (SantaX(check), SantaY(check) - 12), 19, 12
PAINT (SantaX(check), SantaY(check) - 12), 12, 12
CIRCLE (SantaX(check), SantaY(check) - 12), 19, 4
PAINT (SantaX(check), SantaY(check) - 12), 0, 4
CIRCLE (SantaX(check), SantaY(check) - 12), 19, 0


SELECT CASE check
    CASE 1: c = 7
    CASE 2: c = 14
    CASE 3: c = 12
    CASE 4: c = 9
END SELECT
COLOR c

Death.style = INT(RND * 3)
SELECT CASE Death.style
    CASE 0    'Slide on
        gone$ = "              Dead              "
        FOR aa = 1 TO 10
            Death$(aa) = MID$(gone$, aa, 14)
            LOCATE 42, ((check - 1) * 20) + 3
            PRINT Death$(aa);
            z(Blowup) = TIMER
            DO UNTIL TIMER > z(Blowup) + .1: LOOP
        NEXT aa
    CASE 1    'Flash
        LOCATE 42, ((check - 1) * 20) + 3
        PRINT "              ";
        gone$ = "Dead"
        FOR aa = 1 TO 10
            LOCATE 42, ((check - 1) * 20) + 8
            IF aa / 2 = INT(aa / 2) THEN
                PRINT gone$;
            ELSE
                PRINT "    ";
            END IF
            z(Blowup) = TIMER
            DO UNTIL TIMER >= z(Blowup) + (.07 * aa): LOOP
        NEXT aa
    CASE 2    '"Spring" together
        gone$(1) = " e          a "
        gone$(2) = "D   e    a   d"
        gone$(3) = "  D  e  a  d  "
        gone$(4) = "    D ea d    "
        gone$(5) = "     Dead     "
        FOR aa = 1 TO 5
        LOCATE 42, ((check - 1) * 20) + 3
        PRINT gone$(aa);
        z(Blowup) = TIMER
        DO UNTIL TIMER > z(Blowup) + .1: LOOP
        NEXT aa
END SELECT
No.of.Deaths = No.of.Deaths + 1
IF No.of.Deaths = 3 THEN Finish
END SUB

SUB DrawLand STATIC
3 CLS
PALETTE
y = INT(RND * 290) + 9
firsty = y
count = 0

endcount = INT(RND * 21) + 40
FOR x = 0 TO 639
count = count + 1

IF count = endcount THEN change = INT(RND * 5): count = 0: endcount = INT(RND * 21) + 40

yadd = INT(RND * 9)
SELECT CASE change
    CASE 0
        SELECT CASE yadd
            CASE 0, 1: y = y - 1
            CASE 7, 8: y = y + 1
        END SELECT
    CASE 1
        SELECT CASE yadd
            CASE 0, 1: y = y - 2
            CASE 2, 3: y = y - 1
            CASE 7, 8: y = y + 1
        END SELECT
    CASE 2
        SELECT CASE yadd
            CASE 0, 1: y = y - 3
            CASE 2, 3, 4: y = y - 2
            CASE 5: y = y - 1
        END SELECT
    CASE 3
        SELECT CASE yadd
            CASE 0, 1: y = y + 3
            CASE 2, 3, 4: y = y + 2
            CASE 5: y = y + 1
        END SELECT
    CASE 4
        SELECT CASE yadd
            CASE 0, 1: y = y + 2
            CASE 2, 3: y = y + 1
            CASE 7, 8: y = y - 1
        END SELECT
END SELECT

IF y > 280 THEN y = y - 2
IF y < 50 THEN y = y + 3

PSET (x, y), 15
PSET (x, y + 1), 15
PSET (x, y + 2), 15
PSET (x, y + 3), 15
NEXT x
PAINT (320, 340), 15, 15

SCREEN 9, , 1, 0
CLS
PCOPY 0, 1
SCREEN 9, , 0, 0

LINE (0, 300)-(639, 349), 0, BF
LINE (3, 303)-(636, 346), 1, BF

LOCATE 40, 35
PRINT "Good land?"
key$ = ""
DO UNTIL key$ <> ""
key$ = INKEY$
LOOP
SELECT CASE key$
    CASE "n", "N": GOTO 3
    CASE ELSE
END SELECT

LINE (3, 303)-(636, 346), 1, BF

FOR x = 1 TO 4
SELECT CASE x
    CASE 1: c = 7
    CASE 2: c = 14
    CASE 3: c = 12
    CASE 4: c = 9
END SELECT
COLOR c
LOCATE 40, ((x - 1) * 20) + 5
PRINT " Player"; x
LOCATE 42, ((x - 1) * 20) + 3
PRINT " Capacity:"; capacity(x);
NEXT x

PALETTE
PALETTE 13, 63
DropSantas
END SUB

SUB DrawSanta STATIC
LINE (100, 98)-(100, 102), 13
LINE (98, 100)-(102, 100), 13
LINE (99, 99)-(101, 101), 0, BF
GET (98, 98)-(102, 102), CrossHair
CLS
CIRCLE (100, 100), 3, 13
PAINT (100, 100), 15, 13
GET (97, 97)-(103, 103), SnowBall
CLS
CIRCLE (100, 100), 7, 4
PAINT (100, 100), 4, 4
LINE (91, 97)-(109, 99), 4, BF
LINE (95, 104)-(105, 107), 4, BF
LINE (100, 105)-(100, 107), 11
CIRCLE (100, 95), 5, 13
PAINT (100, 95), 15, 13
CIRCLE (100, 94), 3, 12
PAINT (100, 94), 12, 12
PSET (98, 94), 11
PSET (102, 94), 11
LINE (88, 97)-(90, 98), 13, BF
LINE (110, 97)-(112, 98), 13, BF
LINE (93, 108)-(99, 110), 8, BF
LINE (101, 108)-(107, 110), 8, BF
CIRCLE (100, 92), 4, 4, PI * 2, PI
LINE (96, 92)-(104, 92), 4
PAINT (100, 91), 4, 4
CIRCLE (100, 88), 1, 13
PAINT (100, 88), 15, 13
LINE (94, 103)-(106, 103), 13
GET (87, 87)-(113, 110), Santa(96, 1)
LINE (94, 103)-(106, 103), 14
GET (87, 87)-(113, 110), Santa(96, 2)
LINE (94, 103)-(106, 103), 12
GET (87, 87)-(113, 110), Santa(96, 3)
LINE (94, 103)-(106, 103), 9
GET (87, 87)-(113, 110), Santa(96, 4)
END SUB

SUB DropSantas
PALETTE 11, 0
PlaceSantas = INT(RND * 2)
IF PlaceSantas = 0 THEN    'Place 1 by 1
    z = TIMER
    FOR a = 1 TO 4
1       SantaY(a) = 1
        SantaX(a) = INT(RND * 613) + 13
        DO UNTIL POINT(SantaX(a), SantaY(a)) <> 0
            SantaY(a) = SantaY(a) + 1
        LOOP
        IF POINT(SantaX(a), SantaY(a)) <> 15 THEN GOTO 1
        FOR b = 1 TO 4
            IF a <> b THEN
                IF SantaX(a) < SantaX(b) + 26 AND SantaX(a) > SantaX(b) - 23 THEN GOTO 1
            END IF
        NEXT b
        'SOUND 80 + (a * 29), 2
        PUT (SantaX(a) - 13, SantaY(a) - 23), Santa(96, a), OR
        IF a < 4 THEN DO UNTIL TIMER >= z + 1: LOOP: z = TIMER
    NEXT a
END IF

IF PlaceSantas = 1 THEN       'Drop Santas from the sky
    FOR a = 1 TO 4
        halt(a) = 0
2       SantaX(a) = INT(RND * 613) + 13
        FOR b = 1 TO 4
            IF a <> b THEN IF SantaX(a) < SantaX(b) + 26 AND SantaX(a) > SantaX(b) - 26 THEN GOTO 2
        NEXT b
        SantaY(a) = 25
        PUT (SantaX(a) - 13, SantaY(a) - 23), Santa(96, a), OR
    NEXT a
    total = 0
    DO
    FOR a = 1 TO 4
        PUT (SantaX(a) - 13, SantaY(a) - 23), Santa(96, a), XOR
        IF halt(a) = 0 THEN
            SantaY(a) = SantaY(a) + 2
            IF POINT(SantaX(a), SantaY(a)) <> 0 THEN halt(a) = 1: total = total + 1
        END IF
        PUT (SantaX(a) - 13, SantaY(a) - 23), Santa(96, a), OR
    NEXT a
    LOOP UNTIL total = 4
END IF
END SUB

SUB Explode1
PALETTE 10, 63
BallType = 1
fallen = 0
SELECT CASE BallType
    CASE 1     'Normal, splatty type
        FOR flake = 1 TO 20
            x(flake) = HitX
            y(flake) = HitY
            addx(flake) = INT(RND * 7)
            addy(flake) = INT(RND * 10)
            HitAngle(flake) = INT(RND * 180) + 180
            addx(flake) = addx(flake) * COS(HitAngle(flake) * PI / 180)
            addy(flake) = addy(flake) * SIN(HitAngle(flake) * PI / 180)
            grounded(flake) = 0
        NEXT flake
      
    CASE 2     'Abnormal, explosive things
        FOR radius = 1 TO 30 STEP 2
        CIRCLE (BallX, BallY), radius, 12
        PAINT (BallX, BallY), 12, 12
        CIRCLE (BallX, BallY), radius, 0
        PAINT (BallX, BallY), 0, 0
        NEXT radius
END SELECT
Exploded = 2
END SUB

SUB Explode2
FOR flake = 1 TO 20
    IF grounded(flake) = 0 THEN
        oldx(flake) = x(flake)
        oldy(flake) = y(flake)
        x(flake) = x(flake) + addx(flake)
        y(flake) = y(flake) + addy(flake)
        addy(flake) = addy(flake) + 1.1
        IF POINT(x(flake), y(flake)) <> 0 AND POINT(x(flake), y(flake)) <> 7 AND POINT(x(flake), y(flake)) <> 10 THEN
            grounded(flake) = 1
            fallen = fallen + 1
            DO
                y(flake) = y(flake) - 1
            LOOP UNTIL POINT(x(flake), y(flake)) = 0 OR x(flake) < 0 OR x(flake) > 639
            IF POINT(x(flake) - 1, y(flake) + 1) = 0 AND POINT(x(flake) + 1, y(flake) + 1) = 0 THEN
                move = INT(RND * 2)
                IF move = 0 THEN x(flake) = x(flake) - 1
                IF move = 1 THEN x(flake) = x(flake) + 1
                DO
                    y(flake) = y(flake) + 1
                LOOP UNTIL POINT(x(flake), y(flake)) <> 0 AND POINT(x(flake), y(flake)) <> 7
                y(flake) = y(flake) - 1
            END IF
        END IF
        PSET (x(flake), y(flake)), 10
        PSET (oldx(flake), oldy(flake)), 0
        IF grounded(flake) = 1 THEN PSET (x(flake), y(flake)), 15
    END IF
NEXT flake
IF fallen = 20 THEN Exploded = 3
END SUB

SUB Explode3
CheckHits1
5 a = a + 1
IF a = 5 THEN a = 1
IF capacity(a) <= 0 THEN GOTO 5
SELECT CASE a
    CASE 1: c = 7
    CASE 2: c = 14
    CASE 3: c = 12
    CASE 4: c = 9
END SELECT
COLOR c
PUT (25 * COS(angle(a) * PI / 180) + SantaX(a), 25 * SIN(angle(a) * PI / 180) + SantaY(a) - 16), CrossHair, XOR
LOCATE 1, 1: PRINT "Angle:"; angle(a)
LOCATE 2, 1: PRINT "Power:"; power(a)
Exploded = 0
END SUB

SUB Finish
FOR tum = 1 TO 4
    IF capacity(tum) > 0 THEN
        SELECT CASE tum
            CASE 1: c = 7: winner$ = "1"
            CASE 2: c = 14: winner$ = "2"
            CASE 3: c = 12: winner$ = "3"
            CASE 4: c = 9: winner$ = "4"
        END SELECT
    END IF
NEXT tum
CLS
COLOR c
centre 21, "Player " + winner$ + " is the winner!"
END
END SUB

SUB MoveBall
IF BallY > 3 AND BallX > 3 AND BallX < 637 THEN PUT (BallX - 3, BallY - 3), SnowBall, XOR
BallX = BallX + (xadd / 2)
BallY = BallY + (yadd / 2)
yadd = yadd + 1.6

IF BallX > 0 AND BallX < 640 THEN
IF BallX <= HitX AND xadd < 0 THEN ThrowSnow = 0: Exploded = 1: EXIT SUB
IF BallX >= HitX AND xadd > 0 THEN ThrowSnow = 0: Exploded = 1: EXIT SUB
END IF

IF BallX < 0 OR BallX > 640 THEN
    ThrowSnow = 0
7   a = a + 1
    IF a = 5 THEN a = 1
    IF capacity(a) <= 0 THEN GOTO 7
    SELECT CASE a
        CASE 1: c = 7
        CASE 2: c = 14
        CASE 3: c = 12
        CASE 4: c = 9
    END SELECT
    COLOR c
    PUT (25 * COS(angle(a) * PI / 180) + SantaX(a), 25 * SIN(angle(a) * PI / 180) + SantaY(a) - 16), CrossHair, XOR
    LOCATE 1, 1: PRINT "Angle:"; angle(a)
    LOCATE 2, 1: PRINT "Power:"; power(a)
    Exploded = 0
    EXIT SUB
END IF
IF BallY > 3 AND BallX > 3 AND BallX < 637 THEN PUT (BallX - 3, BallY - 3), SnowBall, XOR
END SUB

SUB PlotPath
contact = 0
DO
IF ThrowPower = 0 THEN GOTO 4
BallX = BallX + (xadd / ThrowPower)
BallY = BallY + (yadd / ThrowPower)
yadd = yadd + (3.2 / ThrowPower)
4
IF contact = 0 THEN
    IF POINT(BallX, BallY) = 0 OR POINT(BallX, BallY) = 7 THEN contact = 1
END IF
IF BallY > 0 THEN
    IF contact = 1 THEN
        IF POINT(BallX, BallY) <> 0 AND POINT(BallX, BallY) <> 7 THEN EXIT DO
    END IF
END IF
IF BallX < 0 OR BallX > 640 THEN EXIT DO
LOOP
HitPoint = POINT(HitX, HitY)
HitX = BallX
HitY = BallY
yadd = origyadd
END SUB

SUB Setup STATIC
WIDTH 80, 43
CLS
FOR col = 0 TO 15
PALETTE col, 0
NEXT col

FOR a = 1 TO 4
power(a) = 0
angle(a) = 270
capacity(a) = 10
NEXT a

END SUB

SUB Shoot
PUT (25 * COS(angle(a) * PI / 180) + SantaX(a), 25 * SIN(angle(a) * PI / 180) + SantaY(a) - 16), CrossHair, XOR
IF power(a) = 0 THEN xadd = 0: yadd = 0
BallX = SantaX(a)
BallY = SantaY(a) - 12
xadd = power(a) * COS(angle(a) * PI / 180)
yadd = power(a) * SIN(angle(a) * PI / 180)
origyadd = yadd
ThrowPower = power(a)

PlotPath

BallX = SantaX(a)
BallY = SantaY(a) - 12

BallX = BallX + (xadd / 4)
BallY = BallY + (yadd / 4)
yadd = yadd + .8

IF BallX > 3 AND BallX < 637 AND BallY > 3 AND BallY < 297 THEN PUT (BallX - 3, BallY - 3), SnowBall, XOR
ThrowSnow = 1
END SUB

