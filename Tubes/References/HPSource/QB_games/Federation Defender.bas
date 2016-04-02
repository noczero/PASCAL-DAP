'Welcome To federation Defender This is Version 1.01
'1.0 Was Almost the same Exepet it was way to easy so
'I made It alot harder (Still a bit too easy)
'This happends to be my first Game that I have made
'And I hope you think its good most of my friends say
'It's fine but the don't like the control Oh well.
'Ya there Are a few gliches And in the next verion I
'should have them all fixed. You may say My code Is
'veary messy Well that's because I've only been programing
'for 2 Months.  I hope you enjoy it

DECLARE SUB LostGame ()
DECLARE SUB BeatGame ()
DECLARE SUB Center0 (Row!, Text$, c!)
DECLARE SUB TheStory ()
DECLARE SUB Center (Row, Text$, c)
DECLARE SUB Game1 ()
DECLARE SUB Pacman ()
DECLARE SUB BigD ()
DECLARE SUB Bye ()
DECLARE SUB DrawBye ()
DIM dot(1000)
CLEAR , , 20005

SCREEN 12
GameEnd% = 0
pacx = 320
pacy = 225
s% = 0
CONST ArraySize = 242, NumGraphics = 21
CONST Delay = 700
CONST True = -1, False = NOT True
DIM Graphic(0 TO ArraySize * NumGraphics)
BigD
CLEAR , , 20005
Pacman
CLEAR , , 20005

Count% = 2
SCREEN 13
2
CLEAR , , 20005
ON PLAY(1) GOSUB MuchMusic
doth% = 75
CLS
COLOR 15
CIRCLE (210, 120), 4, 7             'dot
PAINT (210, 120), 4, 7
GET (220, 145)-(200, 95), dot
CLS
3


LINE (62, 10)-(230, 70), 0, BF
LINE (62, 10)-(230, 70), 12, B
LINE (61, 9)-(231, 71), 4, B
LINE (60, 8)-(232, 72), 7, B
COLOR 15: LOCATE 5, 10: PRINT "F": PLAY "l30n0"
COLOR 2: LOCATE 5, 10: PRINT "F": COLOR 15: LOCATE 5, 11: PRINT "e": PLAY "l30n0"
COLOR 2: LOCATE 5, 11: PRINT "e": COLOR 15: LOCATE 5, 12: PRINT "d": PLAY "l30n0"
COLOR 2: LOCATE 5, 12: PRINT "d": COLOR 15: LOCATE 5, 13: PRINT "e": PLAY "l30n0"
COLOR 2: LOCATE 5, 13: PRINT "e": COLOR 15: LOCATE 5, 14: PRINT "r": PLAY "l30n0"
COLOR 2: LOCATE 5, 14: PRINT "r": COLOR 15: LOCATE 5, 15: PRINT "a": LOCATE 17, 15: PRINT "E": LOCATE 15, 15: PRINT "S": LOCATE 13, 15: PRINT "P": PLAY "l30n0"
COLOR 2: LOCATE 5, 15: PRINT "a": LOCATE 17, 15: PRINT "E": LOCATE 15, 15: PRINT "S": LOCATE 13, 15: PRINT "P": COLOR 15: LOCATE 5, 16: PRINT "t": LOCATE 17, 16: PRINT "x": LOCATE 15, 16: PRINT "t": LOCATE 13, 16: PRINT "l": PLAY "l30n0"
COLOR 2: LOCATE 5, 16: PRINT "t": LOCATE 17, 16: PRINT "x": LOCATE 15, 16: PRINT "t": LOCATE 13, 16: PRINT "l": COLOR 15: LOCATE 5, 17: PRINT "i": LOCATE 17, 17: PRINT "i": LOCATE 15, 17: PRINT "o": LOCATE 13, 17: PRINT "a": PLAY "l30n0"
COLOR 2: LOCATE 5, 17: PRINT "i": LOCATE 17, 17: PRINT "i": LOCATE 15, 17: PRINT "o": LOCATE 13, 17: PRINT "a": COLOR 15: LOCATE 5, 18: PRINT "o": LOCATE 17, 18: PRINT "t": LOCATE 15, 18: PRINT "r": LOCATE 13, 18: PRINT "y": PLAY "l30n0"
COLOR 2: LOCATE 5, 18: PRINT "o": LOCATE 17, 18: PRINT "t": LOCATE 15, 18: PRINT "r": LOCATE 13, 18: PRINT "y": COLOR 15: LOCATE 5, 19: PRINT "n": LOCATE 15, 19: PRINT "y": PLAY "l30n0"
COLOR 2: LOCATE 5, 19: PRINT "n": LOCATE 15, 19: PRINT "y": PLAY "l30n0"
COLOR 15: LOCATE 5, 21: PRINT "D": PLAY "L30n0"
COLOR 2: LOCATE 5, 21: PRINT "D": COLOR 15: LOCATE 5, 22: PRINT "e": PLAY "l30n0"
COLOR 2: LOCATE 5, 22: PRINT "e": COLOR 15: LOCATE 5, 23: PRINT "f": PLAY "l30n0"
COLOR 2: LOCATE 5, 23: PRINT "f": COLOR 15: LOCATE 5, 24: PRINT "e": PLAY "l30n0"
COLOR 2: LOCATE 5, 24: PRINT "e": COLOR 15: LOCATE 5, 25: PRINT "n": PLAY "l30n0"
COLOR 2: LOCATE 5, 25: PRINT "n": COLOR 15: LOCATE 5, 26: PRINT "d": PLAY "l30n0"
COLOR 2: LOCATE 5, 26: PRINT "d": COLOR 15: LOCATE 5, 27: PRINT "e": PLAY "l30n0"
COLOR 2: LOCATE 5, 27: PRINT "e": COLOR 15: LOCATE 5, 28: PRINT "r": PLAY "l30n0"
COLOR 2: LOCATE 5, 28: PRINT "r"
PUT (90, doth%), dot, PSET
PLAY ON
MBuff$ = "T150L2O3CGP16L16FEDL2>C<GP16L16FEDL2>C<GP16L16FEFL2D"
PLAY "MB X" + VARPTR$(MBuff$)

1
he:
DO
SELECT CASE INKEY$
CASE IS = CHR$(0) + "H": GOSUB up
CASE IS = CHR$(0) + "P": GOSUB down
CASE IS = CHR$(13): GOSUB retern
END SELECT
GOTO 1
down:
FOR repeat = 1 TO 3
IF doth% < 105 THEN
doth% = doth% + 5
END IF
NEXT repeat
PUT (90, doth%), dot, PSET
RETURN
up:
FOR repeat = 1 TO 3
IF doth% > 75 THEN
doth% = doth% - 5
'v% = v% - 1
END IF
NEXT
PUT (90, doth%), dot, PSET
GOTO 1
LOOP UNTIL INKEY$ = CHR$(27)
retern:
IF doth% = 75 THEN CLEAR , , 20005: CALL Game1: CLEAR , , 20005: GOTO 2
IF doth% = 90 THEN CLEAR , , 20005: CALL TheStory: CLEAR , , 20005: GOTO 2
IF doth% = 105 THEN
END IF
SCREEN 12
'Bye
SYSTEM
MuchMusic:
Count% = Count% + 1
SELECT CASE Count%
CASE 0: MBuff$ = "T150L2O3CGP16L16FEDL2>C<GP16L16FEDL2>C<GP16L16FEFL2D"
CASE 1: MBuff$ = "P16L16<GGGL2>CGP32L16FEDL2>C<GP16L16FEDL2>C<GP16L16A+"
CASE 2: MBuff$ = "AA+L1GL2G.L8<G.L16GL4A.L8A>FEDCL16CDEDP16L8"
CASE 3: MBuff$ = "<AL4BL8G.L16G"
CASE 4: MBuff$ = "L4A.L8A>FEDCGP8L4D.P8L8<G.L16GL4A.L8A>FEDCL16"
CASE 5: MBuff$ = "CDEDP16L8<A"
CASE 6: MBuff$ = "L4BP16L8>G.L16GL8>C.L16<A+L8G+.L16GL8F.L16D+L8D.L16CL1G"
CASE 7: MBuff$ = "L2G.P16L16GGGL8>CP8L16<CCCL2C.": Count% = -1
END SELECT
PLAY "MB X" + VARPTR$(MBuff$)
RETURN

SUB BeatGame
DIM Ship(900)
ON PLAY(1) GOSUB MuchMusic
PLAY ON
MBuff$ = "T150L2O3CGP16L16FEDL2>C<GP16L16FEDL2>C<GP16L16FEFL2D"
PLAY "MB X" + VARPTR$(MBuff$)
g% = 400
x% = 288
StarNum% = 300
LNum% = 1
DIM StarX(StarNum%), StarY(StarNum%), Layer(LNum%)
LINE (10, 10)-(10, 20), 3
  LINE (10, 18)-(20, 15), 3
  LINE (25, 20)-(25, 10), 3
  LINE (25, 18)-(19, 15), 3
  LINE (18, 5)-(18, 15), 2
GET (31, 28)-(2, 1), Ship
CLS
FOR l = 1 TO LNum%
IF l = 1 THEN Layer(l) = 3
IF l = 2 THEN Layer(l) = 4
DO: k$ = "R": LOOP UNTIL k$ = "L" OR k$ = "R"
IF k$ = "L" THEN Layer(l) = -Layer(l)
PRINT
NEXT l
FOR I% = 1 TO StarNum%
StarX(I%) = (RND * 619) + 1
StarY(I%) = (RND * 599) + 1
NEXT I%

DO
FOR I% = 1 TO StarNum%
PSET (StarX(I%), StarY(I%)), 0
IF I% > (StarNum% / LNum%) * CL THEN CL = CL + 1
StarX(I%) = StarX(I%) + Layer(CL)
IF StarX(I%) < 1 THEN StarX(I%) = 619: StarY(I%) = RND * 619
IF StarX(I%) > 599 THEN StarX(I%) = 1: StarY(I%) = RND * 599
c% = (CL * 4) + 19
PSET (StarX(I%), StarY(I%)), c%
NEXT I%
IF g% > 20 THEN
FOR jkjkj% = 1 TO 3
g% = g% - 2.5
PUT (x%, g%), Ship, PSET
NEXT jkjkj%
END IF
COLOR 15: LOCATE 8, 10
PRINT "Thanks to you, The Nebulatic Army has been defeated. The Vanderbelt"
PRINT "       king gave you the medal of bravery for your boldness in the"
PRINT "       destruction of The Nebulatic race.  The galaxy is safe... "
PRINT ""
PRINT "                 -- At least For Now --"
LOOP WHILE INKEY$ = ""
IF g% > 20 THEN
FOR jkjkj% = 1 TO 3
g% = g% - 2.5
PUT (x%, g%), Ship, PSET
NEXT jkjkj%
END IF

END SUB

SUB BigD
CLS
SCREEN 12
VIEW (0, 0)-(639, 479)
WINDOW (0, 0)-(200, 200)
DRAW "bl155r20d8l10g5d2r15d20g5l20u8r10e5u2l15u20e5br40"
PLAY "l4n0"
PLAY "l4n0"
DRAW "r15f5d30g5l15h5u30e5bf5bd1r5f2d24g2l5h2u24e2bu1bh5br35"
PLAY "l4n0"
DRAW "d40r10u10r10u10l10u10r15u10l25br40"
PLAY "l4n0"
DRAW "d10r8d30r9u30r8u10l25br40"
PLAY "l4n0"
DRAW "d40r5e8f8r5u40l10d10l5u10l10br40"
PLAY "l4n0"
DRAW "d40r10u10r5d10r10u40l25br10bd10d5r5u5l5bu10br30"
PLAY "l4n0"
DRAW "d40r10u10f10r5u5h15r10e5u10h5l20bf10bu5r5f3d3g3l5u9bd5bh10br40"
PLAY "l4n0"
DRAW "d40r25u10l15u5r10u10l10u5r15u10l25"
FOR I% = 0 TO 63
PALETTE 12, I%
LOCATE 6, 21
COLOR 12
PRINT TAB(19); "ÉÍÍÍÍÍÍÍÍ» ÉÍÍÍÍÍÍÍÍ» ÉÍÍÍÍÍÍÍÍ» É»      É»"
PRINT TAB(19); "ºÉÍÍÍÍÍÍÍ¼ ºÉÍÍÍÍÍÍ»º ºÉÍÍÍÍÍÍ»º ºº      ºº"
PRINT TAB(19); "ºº         ºº      ºº ºº      ºº ºº      ºº"
PRINT TAB(19); "ºÈÍÍÍ»     ºº      ºº ºÈÍÍÍÍÍÍ¼º ºÈÍÍÍÍÍÍ¼º"
PRINT TAB(19); "ÈÍÍÍ»ÈÍÍÍ» ºº      ºº º ÉÍÍÍÍÍÍ¼ ºÉÍÍÍÍÍÍ»º"
PRINT TAB(19); "    ÈÍÍÍ»º ºº      ºº º ÈÍÍ»     ºº      ºº"
PRINT TAB(19); "ÉÍÍÍÍÍÍÍ¼º ºÈÍÍÍÍÍÍ¼º ºÉÍÍ»ÈÍÍÍ» ºº      ºº"
PRINT TAB(19); "ÈÍÍÍÍÍÍÍÍ¼ ÈÍÍÍÍÍÍÍÍ¼ È¼  ÈÍÍÍÍ¼ È¼      È¼"
NEXT I%
PLAY "l64o6bagfedco5bagfedco4bagfedco3bagfedco2bagfedco1bagfedco0bagfedcl1n0"
CLS
END SUB

SUB Bye
VIEW (0, 0)-(639, 479)
DO
IF flip% = 0 THEN
flip% = 1
j% = 64
FOR I% = 0 TO 63 STEP 2
j% = j% - 2
PALETTE 6, j%
PALETTE 7, I%
LINE (0, 0)-(639, 479), 6, BF
COLOR 7
DrawBye
NEXT I%
ELSE
flip% = 0
j% = 64
FOR I% = 0 TO 63 STEP 2
j% = j% - 2
PALETTE 7, j%
PALETTE 6, I%
LINE (0, 0)-(639, 479), 6, BF
COLOR 7
DrawBye
NEXT I%
END IF
LOOP WHILE INKEY$ = ""
END SUB

SUB Center (Row, Text$, c)
COLOR c
LOCATE Row, 20 - (LEN(Text$) / 2)
PRINT Text$
COLOR 15
END SUB

SUB Center0 (Row, Text$, c)
COLOR c
LOCATE Row, 40 - (LEN(Text$) / 2)
PRINT Text$
COLOR 15
END SUB

SUB DrawBye
LOCATE 15, 2: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ": LOCATE 15, 33: PRINT "ÛÛÛÛÛÛÛÛ": LOCATE 15, 50: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
LOCATE 14, 2: PRINT "ÛÛÛÛ": LOCATE 14, 17: PRINT "ÛÛÛ": LOCATE 14, 32: PRINT "ÛÛÛÛ": LOCATE 14, 38: PRINT "ÛÛÛÛ": LOCATE 14, 50: PRINT "ÛÛÛÛ"
LOCATE 16, 2: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ": LOCATE 16, 34: PRINT "ÛÛÛÛÛÛ": LOCATE 16, 50: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
LOCATE 13, 2: PRINT "ÛÛÛÛ": LOCATE 13, 17: PRINT "ÛÛÛÛÛÛÛ": LOCATE 13, 31: PRINT "ÛÛÛÛ": LOCATE 13, 39: PRINT "ÛÛÛÛ": LOCATE 13, 50: PRINT "ÛÛÛÛ"
LOCATE 17, 2: PRINT "ÛÛÛÛ": LOCATE 17, 17: PRINT "ÛÛÛ": LOCATE 17, 35: PRINT "ÛÛÛÛ": LOCATE 17, 50: PRINT "ÛÛÛÛ"
LOCATE 12, 2: PRINT "ÛÛÛÛ": LOCATE 12, 21: PRINT "ÛÛÛ": LOCATE 12, 30: PRINT "ÛÛÛÛ": LOCATE 12, 40: PRINT "ÛÛÛÛ": LOCATE 12, 50: PRINT "ÛÛÛÛ"
LOCATE 18, 2: PRINT "ÛÛÛÛ": LOCATE 18, 17: PRINT "ÛÛÛÛÛÛÛ": LOCATE 18, 35: PRINT "ÛÛÛÛ": LOCATE 18, 50: PRINT "ÛÛÛÛ"
LOCATE 11, 2: PRINT "ÛÛÛÛ": LOCATE 11, 21: PRINT "ÛÛÛ": LOCATE 11, 29: PRINT "ÛÛÛÛ": LOCATE 11, 41: PRINT "ÛÛÛÛ": LOCATE 11, 50: PRINT "ÛÛÛÛ"
LOCATE 19, 2: PRINT "ÛÛÛÛ": LOCATE 19, 20: PRINT "ÛÛÛÛ": LOCATE 19, 35: PRINT "ÛÛÛÛ": LOCATE 19, 50: PRINT "ÛÛÛÛ"
LOCATE 10, 2: PRINT "ÛÛÛÛ": LOCATE 10, 18: PRINT "ÛÛÛÛÛÛ": LOCATE 10, 28: PRINT "ÛÛÛÛ": LOCATE 10, 42: PRINT "ÛÛÛÛ": LOCATE 10, 50: PRINT "ÛÛÛÛ"
LOCATE 20, 2: PRINT "ÛÛÛÛ": LOCATE 20, 20: PRINT "ÛÛÛÛ": LOCATE 20, 35: PRINT "ÛÛÛÛ": LOCATE 20, 50: PRINT "ÛÛÛÛ"
LOCATE 9, 2: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ": LOCATE 9, 27: PRINT "ÛÛÛÛ": LOCATE 9, 43: PRINT "ÛÛÛÛ": LOCATE 9, 50: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
LOCATE 21, 2: PRINT "ÛÛÛÛ": LOCATE 21, 18: PRINT "ÛÛÛÛÛÛ": LOCATE 21, 35: PRINT "ÛÛÛÛ": LOCATE 21, 50: PRINT "ÛÛÛÛ"
LOCATE 8, 2: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ": LOCATE 8, 26: PRINT "ÛÛÛÛ": LOCATE 8, 44: PRINT "ÛÛÛÛ": LOCATE 8, 50: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
LOCATE 22, 2: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ": LOCATE 22, 35: PRINT "ÛÛÛÛ": LOCATE 22, 50: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
LOCATE 23, 2: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ": LOCATE 23, 35: PRINT "ÛÛÛÛ": LOCATE 23, 50: PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
END SUB

SUB Game1
DIM Ship(900)
DIM Enemy(900)
DIM shot(800)
DIM Eshot(800)
RANDOMIZE TIMER
leveltoggle% = 1
life% = 2
raguExtraChunky:
'Varable Settings
etoggle% = 2
PeashooterFX$ = "l64o1cdefgabagfedc"
DrunkFX$ = "l64o1abababababo0cdcdcdcdcd"
HomingFX$ = "l64o1abo0cdo1abo0cdo1abo0cdo1abo0cdo1abo0cdo1ab"
LaserFX$ = "l64 o6bgec o5bgec o2be o0gc"
ShotFX$ = "l64 o5ec o6bgec o5bgec o2bgec o0bgec"
ex% = 30                                         'Enemy shot Left & right
ey% = 60                                         'Enemyshot up & down
g% = 312                                         'Up & Down
x% = 288                                         'Left & right
rc% = 0
v% = 1
l% = 15                                          'Enemy up & down
r% = 20                                          'Enemy left & right
d% = 30                                     'Shot up & down
f% = 60                                         'Shot left & right
pee% = 0
ts% = 800
MasterLeveltoggle% = 1
hit% = 0
EnemyLife% = 3
hitshot = 0
die% = 0
'ewt% = RND * 3 + 1                               'Random EWT
IF leveltoggle% = 1 THEN
ewt% = 3                                        'Enemy Weapon Type:
ELSEIF leveltoggle% = 2 THEN
ewt% = 2
ELSEIF leveltoggle% = 3 OR leveltoggle% = 4 THEN
ewt% = 1
ELSEIF leveltoggle% > 4 THEN
ewt% = 4
EnemyLife% = 4
ELSE
ewt% = 4
END IF
                                                 '1 = Class I laser
                                                 '2 = Peashooter
                                                 '3 = RS-1 "Drunk" torpedo
                                                 '4 = RS-2 "Homing torpedo
SCREEN 12
                                                 'Enemy Shot Code:
PALETTE 14, 63
IF ewt% = 1 THEN
LINE (2, 10)-(2, 45), 4                           'Laser
GET (1, 1)-(3, 50), Eshot                        'Laser
ELSEIF Ewt2% = 1 THEN
LINE (2, 10)-(2, 45), 4
GET (1, 1)-(3, 50), Eshot
ELSEIF ewt% = 3 OR ewt% = 4 OR Ewt2% = 1 THEN
CIRCLE (210, 120), 3, 7                          'Torpedoes
ELSEIF ewt% = 2 THEN
CIRCLE (210, 120), 2, 7                          'Peashooter
PAINT (210, 120), 2, 7                           'Peashooter
END IF
IF ewt% = 4 OR Ewt2% = 1 THEN
PAINT (210, 120), 3, 7                           'Homing torpedo
ELSEIF ewt% = 3 THEN
PAINT (210, 120), 5, 7                           'Drunk torpedo
ELSE
END IF
IF ewt% = 2 OR ewt% = 3 OR ewt% = 4 OR Ewt2% = 1 THEN
GET (220, 130)-(200, 110), Eshot                 'Everything but laser
ELSE
END IF
'PUT (30, 50), Eshot, PSET
CLS

LINE (10, 10)-(10, 20), 3                        'This draws the ship
LINE (10, 18)-(20, 15), 3
LINE (25, 20)-(25, 10), 3
LINE (25, 18)-(19, 15), 3
LINE (18, 5)-(18, 15), 2
GET (31, 28)-(2, 1), Ship

PALETTE 14, 63                                   'This draws the enemy
CIRCLE (545, 120), 8, 7
PAINT (545, 120), 14, 7
GET (555, 130)-(535, 80), Enemy

SCREEN 12
LINE (2, 5)-(2, 40), 3                           'This draws the shot
GET (1, 70)-(2, 1), shot
PUT (30, 50), shot, PSET
CLS

LINE (15, 432)-(600, 15), 0, BF
LINE (11, 433)-(517, 11), 7, B

PUT (x%, g%), Ship, PSET

7
IF k% = 2 THEN
New% = f% - 40
New1% = 20
LINE (New%, New1%)-STEP(90, 90), 0, BF
PUT (x%, g%), Ship, PSET
k% = 0
END IF
IF die% = 1 THEN
die% = 0
New% = 520
New1% = 100
LINE (New%, New1%)-STEP(50, 50), 0, BF
PUT (x%, g%), Ship, PSET
END IF
IF Ek% = 1 THEN
Enew% = ex%
Enew1% = ey%
LINE (Enew%, Enew1%)-STEP(30, 50), 0, BF: ex% = 30: ey% = 60: Ek% = 0
PUT (x%, g%), Ship, PSET
END IF
COLOR 15: LOCATE 2, 67: PRINT "  INFO BAR"      'The Change I made for the Info bar
LOCATE 3, 66: PRINT "--------------"
LINE (541, 76)-(611, 90), 14, BF
LOCATE 7, 67: PRINT " Enemy Life"
LOCATE 10, 67: PRINT "  Lives:"; life%
DO

SELECT CASE INKEY$
CASE IS = CHR$(0) + "H": GOSUB Raise
CASE IS = CHR$(0) + "P": GOSUB Lower
CASE IS = CHR$(0) + "K": GOSUB Left
CASE IS = CHR$(0) + "M": GOSUB Right
CASE IS = " "
IF NOT k% = 1 THEN GOSUB fire
CASE IS = CHR$(27): GOSUB ending
END SELECT

IF d% < 20 THEN d% = g% - 5: k% = 2
IF k% = 2 THEN d% = g% - 5
IF k% = 1 THEN GOTO 56
GOTO 23

Raise:          
        IF g% > 90 THEN
        FOR l = 1 TO 2
        g% = g% - 4
        PUT (x%, g%), Ship, PSET
        NEXT
        END IF
        PUT (x%, g%), Ship, PSET
        RETURN
GOTO 23

Lower:
        IF g% < 370 THEN
        FOR l = 1 TO 2
        g% = g% + 4
        PUT (x%, g%), Ship, PSET
        NEXT
        END IF
        PUT (x%, g%), Ship, PSET
        RETURN
GOTO 23

Right:
        IF x% < 480 THEN
        FOR l = 1 TO 2
        x% = x% + 4
        PUT (x%, g%), Ship, PSET
        NEXT
        END IF
        PUT (x%, g%), Ship, PSET
        RETURN
GOTO 23

Left:
        IF x% > 20 THEN
        FOR l = 1 TO 2
        x% = x% - 4
        PUT (x%, g%), Ship, PSET
        NEXT
        END IF
        PUT (x%, g%), Ship, PSET
        RETURN
GOTO 23

overshot:
RETURN

fire:
        PLAY "MB X" + VARPTR$(ShotFX$)
        IF barreltoggle% = 0 THEN
        barreltoggle% = 1
        ELSE
        barreltoggle% = 0
        END IF
        IF fire% = 6 THEN GOSUB overshot:
        IF k% = 1 THEN GOTO 56
        fire% = fire% + 1
        d% = g% - 5
        f% = x%
        IF barreltoggle% = 0 THEN f% = f% + 26
        IF barreltoggle% = 1 THEN f% = f% + 4
        k% = 1
56
        IF d% < 20 THEN k% = 2: PRINT shot: GOTO 7
        d% = d% - 8
        PUT (f%, d%), shot, PSET
        h% = f%
        hight% = d%
        hi% = r% + 38

        IF h% > hi% - 37 AND h% < hi% - 19 AND d% < 65 AND d% > 35 THEN
        hit% = hit% + 1: hitshot% = 1: d% = g% - 5: die% = 1
        END IF
        IF hit% = EnemyLife% THEN
        GOSUB Ending2
        END IF
        IF hit% = 2 AND hitshot% = 1 THEN
        hitshot% = 0
        k% = 2
        FOR I% = 46 TO 30 STEP -1
        PALETTE 14, I%
        PLAY "l32n0"
        FOR j% = 1 TO 30
        die% = 0
        New% = 520
        New1% = 100
        NEXT j%
        NEXT I%
        END IF
        IF hit% = 3 AND hitshot% = 1 THEN
        hitshot% = 0
        k% = 2
        FOR I% = 30 TO 0 STEP -1
        PALETTE 14, I%
        PLAY "l32n0"
        FOR j% = 1 TO 30
        die% = 0
        New% = 520
        New1% = 100
        NEXT j%
        NEXT I%
        END IF
        IF hit% = 1 AND hitshot% = 1 THEN
        hitshot% = 0
        k% = 2
        FOR I% = 63 TO 46 STEP -1
        PALETTE 14, I%
        PLAY "l32n0"
        FOR j% = 1 TO 30
        die% = 0
        New% = 520
        New1% = 100
        NEXT j%
        NEXT I%
        END IF
        GOSUB 23
LOOP UNTIL INKEY$ = CHR$(27)

23                                               'Enemy AI
        PUT (r%, l%), Enemy, PSET
IF v% = 1 THEN GOTO 76
IF v% = 2 THEN GOTO 67

76
        IF r% > 20 OR r% < 480 THEN
        r% = r% + 2
        PUT (r%, l%), Enemy, PSET
        END IF
        IF r% = 480 THEN v% = 2
        IF ewt% = 1 THEN
        IF x% < r% - 6 AND x% > r% - 14 THEN Eshot% = 1    'Laser
        ELSE
        IF leveltoggle% < 5 THEN cool% = RND * 200                                  'Random, everything but laser
        IF leveltoggle% = 5 THEN cool% = RND * 100
        IF cool% = 7 THEN Eshot% = 1                       'Random, everything but laser
        'cool% = cool% + 1                                 'Everything but laser
        'IF cool% = 200 THEN Eshot% = 1                    'Everything but laser
        END IF
        IF Eshot% = 1 THEN GOSUB Enemyshot                 'Everything
GOTO 7

67
        IF r% > 20 THEN
        r% = r% - 2
        PUT (r%, l%), Enemy, PSET
        END IF
        IF r% = 24 THEN v% = 1
        IF r% = 400 THEN v% = 2
        IF ewt% = 1 THEN
        IF x% < r% - 6 AND x% > r% - 14 THEN Eshot% = 1  'Laser
        ELSE
        cool% = RND * 200                                  'Random, everything but laser
        IF cool% = 7 THEN Eshot% = 1                       'Random, everything but laser
        'cool% = cool% + 1                               'Everything but laser
        'IF cool% < 200 THEN Eshot% = 0                  'Everything but laser
        'IF cool% = 200 THEN Eshot% = 1                  'Everything but laser
        END IF
        IF Eshot% = 1 THEN GOSUB Enemyshot               'Everything
GOTO 7

ending:
PRINT "Do You Want To Exit Y/N"
A$ = UCASE$(INPUT$(1))
IF A$ = "N" THEN GOTO 7
IF A$ = "Y" THEN GOTO 10 ELSE GOSUB ending

Ending2:
DO
rc% = rc% + 1
rr% = RND * 20 + r%
rl% = RND * 20 + l% + 30
PSET (rr%, rl%), 0
LOOP UNTIL rc% = 600
CLS
FOR I% = 1 TO 63
PALETTE 10, I%
LOCATE 10, 20
COLOR 10
PRINT TAB(21); "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
PRINT TAB(21); "º                                 º"
PRINT TAB(21); "º    You have beaten level"; leveltoggle%; "!!!  º"
PRINT TAB(21); "º                                 º"
PRINT TAB(21); "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
NEXT I%
PLAY "l2n0"
Keyy$ = UCASE$(INPUT$(1))
FOR d% = 63 TO 1 STEP -1
PALETTE 10, d%
LOCATE 10, 20
COLOR 10
PRINT TAB(21); "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
PRINT TAB(21); "º                                 º"
PRINT TAB(21); "º    You have beaten level"; leveltoggle%; "!!!  º "
PRINT TAB(21); "º                                 º"
PRINT TAB(21); "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
NEXT d%
IF leveltoggle% = 7 THEN
BeatGame: GOTO 10
ELSE leveltoggle% = leveltoggle% + 1: GOTO raguExtraChunky
END IF
Enemyshot:
IF loser% = 4 THEN GOTO winner
loser% = 4
IF ewt% = 1 THEN
PLAY "MB X" + VARPTR$(LaserFX$)                  'Laser
ELSEIF ewt% = 2 THEN
PLAY "MB X" + VARPTR$(PeashooterFX$)             'Peashooter
ELSEIF ewt% = 3 THEN
PLAY "MB X" + VARPTR$(DrunkFX$)                  'Drunk torpedo
ELSEIF ewt% = 4 THEN
PLAY "MB X" + VARPTR$(HomingFX$)                 'Homing missile
END IF
ex% = r%
IF ewt% = 2 THEN
ee% = (x% - r%) / 150                            'Peashooter
ef% = (g% - l%) / 150                            'Peashooter
ELSE
END IF
ab = 100
winner:
IF etoggle% = 1 THEN
etoggle% = 2
ELSEIF etoggle% = 2 THEN
etoggle% = 0
ELSE
etoggle% = 1
END IF
IF etoggle% = 1 OR etoggle% = 2 THEN ec% = 4
IF etoggle% = 0 THEN ec% = 0
IF loser% = 0 THEN ec% = 0
IF etoggle% = 0 THEN
FOR s% = 1 TO 2
ab = ab - .5
IF ab < 14 THEN EXIT FOR
IF ewt% = 4 THEN
ee% = (x% - ex%) / ab                            'Homing torpedo
ef% = (g% - ey%) / ab                            'Homing torpedo > the first IF a few lines down is also homing
ELSEIF ewt% = 3 THEN
ee% = (x% - r%) / 150                            'Drunk torpedo
ef% = (g% - l%) / 150                            'Drunk torpedo
ELSEIF ewt% = 1 THEN
ee% = 0                                          'Laser > the third IF is everything but laser
ef% = 8                                          'Laser > the fourth IF is laser
ELSE
END IF
IF leveltoggle% = 4 THEN
FOR hilow% = 1 TO 2
ex% = ex% + ee%
ey% = ey% + ef%
PUT (ex%, ey%), Eshot, PSET
NEXT hilow%
ELSE
ex% = ex% + ee%
ey% = ey% + ef%
PUT (ex%, ey%), Eshot, PSET
END IF
NEXT s%
loser% = 4
IF ab < 12 OR ey% > 360 OR ex% < 25 OR ex% > 475 THEN etoggle% = 0: loser% = 0: Eshot% = 0: cool% = 0: Ek% = 1
IF ewt% = 2 OR ewt% = 3 OR ewt% = 4 THEN
IF ex% > x% - 10 AND ex% < x% + 22 AND ey% > g% - 15 AND ey% < g% + 10 THEN GOTO 777
ELSE
IF ex% > x% AND ex% < x% + 22 AND ey% > g% - 38 AND ey% < g% + 10 THEN GOTO 777
END IF
END IF
GOTO 7
777 :
IF ewt% = 1 THEN
LINE (x% - 55, g% - 55)-(x% + 45, g% + 45), 0, BF
ELSE
LINE (x% - 15, g% - 15)-(x% + 45, g% + 45), 0, BF
END IF
DO
IF q% = 0 THEN
q% = 1: c% = 4
ELSEIF q% = 1 THEN
q% = 2: c% = 4
ELSEIF q% = 2 THEN
q% = 0: c% = 15
END IF
pee% = pee% + 1
CIRCLE (x% + 15, g% + 15), 15, 7
PAINT (x% + 15, g% + 15), c%, 7
LOOP UNTIL pee% = 150
DO
rc% = rc% + 1
rx% = RND * 40 + x%
rg% = RND * 40 + g%
PSET (rx%, rg%), 0
LOOP UNTIL rc% = 8000
CLS
life% = life% - 1
IF life% < 0 THEN
FOR I% = 1 TO 63
PALETTE 10, I%
LOCATE 10, 20
COLOR 10
PRINT TAB(21); "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
PRINT TAB(21); "º                                 º"
PRINT TAB(21); "º    ): You have been killed :(   º"
PRINT TAB(21); "º                                 º"
PRINT TAB(21); "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
NEXT I%
PLAY "l2n0"
Keyy$ = UCASE$(INPUT$(1))
FOR d% = 63 TO 1 STEP -1
PALETTE 10, d%
LOCATE 10, 20
COLOR 10
PRINT TAB(21); "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
PRINT TAB(21); "º                                 º"
PRINT TAB(21); "º    ): You have been killed :(   º"
PRINT TAB(21); "º                                 º"
PRINT TAB(21); "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
NEXT d%
LostGame
GOTO 10
ELSE
GOTO raguExtraChunky
END IF
10
SCREEN 13
END SUB

SUB LostGame
DIM Ship(900)
g% = 400
x% = 288
Taps$ = "o2l2cl4cl1fl2cl4fl1al2cl4facfacfl1al2al4al1o3co2l2al4fl1cl2cl4cl1f"
StarNum% = 300
LNum% = 1
DIM StarX(StarNum%), StarY(StarNum%), Layer(LNum%)
LINE (10, 10)-(10, 20), 3
  LINE (10, 18)-(20, 15), 3
  LINE (25, 20)-(25, 10), 3
  LINE (25, 18)-(19, 15), 3
  LINE (18, 5)-(18, 15), 2
GET (31, 28)-(2, 1), Ship

CLS
FOR l = 1 TO LNum%
IF l = 1 THEN Layer(l) = 3
IF l = 2 THEN Layer(l) = 4
DO: k$ = "R": LOOP UNTIL k$ = "L" OR k$ = "R"
IF k$ = "L" THEN Layer(l) = -Layer(l)
PRINT
NEXT l
PLAY "MB X" + VARPTR$(Taps$)
FOR I% = 1 TO StarNum%
StarX(I%) = (RND * 619) + 1
StarY(I%) = (RND * 599) + 1
NEXT I%

DO
FOR I% = 1 TO StarNum%
PSET (StarX(I%), StarY(I%)), 0
IF I% > (StarNum% / LNum%) * CL THEN CL = CL + 1
StarX(I%) = StarX(I%) + Layer(CL)
IF StarX(I%) < 1 THEN StarX(I%) = 619: StarY(I%) = RND * 619
IF StarX(I%) > 599 THEN StarX(I%) = 1: StarY(I%) = RND * 599
c% = (CL * 4) + 19
PSET (StarX(I%), StarY(I%)), c%
NEXT I%
IF g% > 20 AND boom% = 0 THEN
FOR jkjkj% = 1 TO 3
g% = g% - 2.5
PUT (x%, g%), Ship, PSET
NEXT jkjkj%
END IF
IF g% < 50 AND boom% = 0 THEN
DO
IF q% = 0 THEN
q% = 1: c% = 4
ELSEIF q% = 1 THEN
q% = 2: c% = 4
ELSEIF q% = 2 THEN
q% = 0: c% = 15
END IF
pee% = pee% + 1
CIRCLE (x% + 15, g% + 15), 15, 7
PAINT (x% + 15, g% + 15), c%, 7
LOOP UNTIL pee% = 150
DO
rc% = rc% + 1
rx% = RND * 40 + x%
rg% = RND * 40 + g%
PSET (rx%, rg%), 0
LOOP UNTIL rc% = 8500
boom% = 1
END IF


COLOR 15: LOCATE 8, 10
PRINT "I am disappointed with your utter failure in the Nebulatic battle."
PRINT "       I've seen janitors do better (Space Quest, Moron). In World War II,"
PRINT "       a bad pilot was considered a dead one. Guess where that puts you on"
PRINT "       the top ten list!"
PRINT ""
PRINT "                                   Press <ESC> To Continue"
LOOP UNTIL INKEY$ = CHR$(27)
IF g% > 20 THEN
FOR jkjkj% = 1 TO 3
g% = g% - 2.5
PUT (x%, g%), Ship, PSET
NEXT jkjkj%
END IF
GameEnd% = 1
END SUB

SUB Pacman
SCREEN 12
DIM Ship(900)
DIM shot(800)
LINE (10, 10)-(10, 20), 3                        'This draws the ship
LINE (10, 18)-(20, 15), 3
LINE (25, 20)-(25, 10), 3
LINE (25, 18)-(19, 15), 3
LINE (18, 5)-(18, 15), 2
GET (31, 28)-(2, 1), Ship
CLS
LINE (2, 5)-(2, 40), 3
GET (1, 70)-(2, 1), shot
CLS
barney$ = "o2l6gel3gl6gel3gl6ao2l6gel3gl6gel3gl6a"
pacx = 320
pacy = 240
h% = 420
g% = 420
x% = 320
s% = 0
CONST ArraySize = 242, NumGraphics = 21
CONST Delay = 700
CONST True = -1, False = NOT True
DIM Graphic(0 TO ArraySize * NumGraphics)
GOSUB MakeData
CLS
PLAY "MB X" + VARPTR$(barney$)
DO
FOR Frame = 0 TO 6 STEP 2
PUT (pacx, pacy), Graphic(Frame * ArraySize), PSET
FOR Stall = 0 TO Delay: NEXT
IF pacx < 384 THEN pacx = pacx + 3
NEXT
IF pacx > 195 AND pacx < 225 THEN GOSUB xwing
IF pacx > 225 THEN GOSUB firing
FOR Frame = 6 TO 0 STEP -2
PUT (pacx, pacy), Graphic(Frame * ArraySize), PSET
FOR Stall = 0 TO Delay: NEXT
IF pacx < 386 THEN pacx = pacx + 3
NEXT
IF pacx > 195 AND pacx < 225 THEN GOSUB xwing
IF pacx > 225 THEN GOSUB firing
IF pacx = 386 THEN NumTurns = 0
IF pacx = 10 OR pacy = 10 THEN
s% = s% + 1
LOCATE 1, 8: PRINT s%
END IF
IF pacx > 195 AND pacx < 225 THEN GOSUB xwing
IF pacx > 225 THEN GOSUB firing
LOOP
GOTO ends
MakeData:
FOR pacx = 1 TO 10
CIRCLE (20, 20), pacx, 14
CIRCLE (21, 20), pacx, 14
NEXT pacx
LINE (20, 14)-STEP(2, 1), 0, BF
GOSUB SaveGraphic
LINE (20, 20)-(31, 20), 0
GOSUB SaveGraphic
LINE (20, 20)-(31, 19), 0
LINE (20, 20)-(31, 21), 0
GOSUB SaveGraphic
LINE (20, 20)-(31, 18), 0
LINE (20, 20)-(31, 22), 0
GOSUB SaveGraphic
LINE (20, 20)-(31, 17), 0
LINE (20, 20)-(31, 23), 0
GOSUB SaveGraphic
LINE (20, 20)-(31, 16), 0
LINE (20, 20)-(31, 24), 0
GOSUB SaveGraphic
LINE (20, 20)-(31, 15), 0
LINE (20, 20)-(31, 25), 0
GOSUB SaveGraphic
SaveGraphic:
GET (6, 11)-(32, 29), Graphic(Offset)
Offset = Offset + ArraySize
RETURN
xwing:
IF tea% = 1 THEN GOTO tee
tea% = 1
GOSUB MMusic
tee:
IF g% > 360 THEN
FOR l = 1 TO 2
g% = g% - 4
PUT (x%, g%), Ship, PSET
NEXT
END IF
PUT (x%, g%), Ship, PSET
RETURN
firing:
IF h% < 255 THEN GOTO ends
IF tick% = 1 THEN GOTO ticke
tick% = 1
h% = g% + 12
ticke:
h% = h% - 15
PUT (x%, h%), shot, PSET
RETURN
MMusic:
Count% = Count% + 1
MBuff$ = "T150L2O2CGP16L16FEDL2>C<GP16L16FEDL2>C<GP16L16FEFL2D"
PLAY "MB X" + VARPTR$(MBuff$)
RETURN
ends:
CIRCLE (320, 240), 40, 12
DRAW "P4,12"
DRAW "BM0,0 P8,12"
FOR I = 2 TO 100
CIRCLE (320, 240), I, 14
CIRCLE (320, 240), I, 0
NEXT I
FOR I = 100 TO 410
'IF i = 290 THEN GOSUB MMusic
CIRCLE (320, 240), I, 14
CIRCLE (320, 240), (I - 99) * 2, 15
CIRCLE (320, 240), I - 2, 0
CIRCLE (320, 240), ((I - 99) * 2) - 2, 0
NEXT I
END SUB

SUB TheStory
SCREEN 12
CLS
A% = 25
k% = 25
StarNum% = 150
LNum% = 2
DIM StarX(StarNum%), StarY(StarNum%), Layer(LNum%)
FOR l = 1 TO LNum%
IF l = 1 THEN Layer(l) = 3
IF l = 2 THEN Layer(l) = 4
DO: k$ = "R": LOOP UNTIL k$ = "L" OR k$ = "R"
IF k$ = "L" THEN Layer(l) = -Layer(l)
PRINT
NEXT l
'PLAY ON
'PRINT "Music? [Y/N]";
'WHILE A$ <> "Y" AND A$ <> "N": A$ = "Y": WEND
'IF A$ = "Y" THEN MBuff$ = "T150L2O3CGP16L16FEDL2>C<GP16L16FEDL2>C<GP16L16FEFL2D"
'PLAY "MB X" + VARPTR$(MBuff$)
SCREEN 12
FOR I% = 1 TO StarNum%
StarX(I%) = (RND * 619) + 1
StarY(I%) = (RND * 599) + 1
NEXT I%
DO

IF A% > 1 THEN
A% = A% - 1
LOCATE A%, 25: PRINT "Federation Defender"
B% = A% + 1
LOCATE B%, 25: PRINT "                                  "
END IF
IF A% < 2 THEN
LOCATE A%, 25: PRINT "                                  "
IF s% = 0 THEN
LOCATE 10, 1
A$ = "     You are the defender of a long time war galaxy. You must defeat the"
B$ = "evil aliens from planet Nebulats. Until now, the nebulatic creatures have"
c$ = "been winning the war, but now the planet Vanderbet (your home planet) is"
d$ = "launching an all-out strike against them. You are the Alpha leader, and"
e$ = "your job is to defeat the front lines of the Nebulatic army. Your ship"
f$ = "is equipped with Class III Lasers, but can interface with Nebulatic"
g$ = "weapons."
h$ = "Press <Spacebar> To Continue"
FOR w = 1 TO LEN(A$): SOUND 200, .1: LOCATE 10, 4: PRINT LEFT$(A$, w): FOR q = 1 TO 500: NEXT q: NEXT
FOR w = 1 TO LEN(B$): SOUND 200, .1: LOCATE 11, 4: PRINT LEFT$(B$, w): FOR q = 1 TO 500: NEXT q: NEXT
FOR w = 1 TO LEN(c$): SOUND 200, .1: LOCATE 12, 4: PRINT LEFT$(c$, w): FOR q = 1 TO 500: NEXT q: NEXT
FOR w = 1 TO LEN(d$): SOUND 200, .1: LOCATE 13, 4: PRINT LEFT$(d$, w): FOR q = 1 TO 500: NEXT q: NEXT
FOR w = 1 TO LEN(e$): SOUND 200, .1: LOCATE 14, 4: PRINT LEFT$(e$, w): FOR q = 1 TO 500: NEXT q: NEXT
FOR w = 1 TO LEN(f$): SOUND 200, .1: LOCATE 15, 4: PRINT LEFT$(f$, w): FOR q = 1 TO 500: NEXT q: NEXT
FOR w = 1 TO LEN(g$): SOUND 200, .1: LOCATE 16, 4: PRINT LEFT$(g$, w): FOR q = 1 TO 500: NEXT q: NEXT
COLOR 14: SOUND 440, 1: FOR q = 1 TO 500: NEXT q
FOR w = 1 TO LEN(h$): SOUND 240 + w, 1: LOCATE 17, 46: PRINT LEFT$(h$, w): FOR q = 1 TO 500: NEXT q: NEXT
PRINT "                                                                                                 "
s% = 1
END IF
END IF
IF s% = 2 THEN
LOCATE 10, 1: PRINT "                                                                                                            "
PRINT "                                                                                                                         "
PRINT "                                                                                                                    "
PRINT "                                                                                                                  "
PRINT "                                                                                                                       "
LOCATE 16, 20: PRINT " The Story is not done              "
END IF
CL = 1
FOR I% = 1 TO StarNum%
PSET (StarX(I%), StarY(I%)), 0
IF I% > (StarNum% / LNum%) * CL THEN CL = CL + 1
StarX(I%) = StarX(I%) + Layer(CL)
IF StarX(I%) < 1 THEN StarX(I%) = 619: StarY(I%) = RND * 619
IF StarX(I%) > 599 THEN StarX(I%) = 1: StarY(I%) = RND * 599
c% = (CL * 4) + 19
PSET (StarX(I%), StarY(I%)), c%
NEXT I%
PLAY ON
LOOP UNTIL INKEY$ = " "
GOTO 28

'MuchMusic:
Count% = Count% + 1
SELECT CASE Count%
CASE 0: MBuff$ = "T150L2O3CGP16L16FEDL2>C<GP16L16FEDL2>C<GP16L16FEFL2D"
CASE 1: MBuff$ = "P16L16<GGGL2>CGP32L16FEDL2>C<GP16L16FEDL2>C<GP16L16A+"
CASE 2: MBuff$ = "AA+L1GL2G.L8<G.L16GL4A.L8A>FEDCL16CDEDP16L8"
CASE 3: MBuff$ = "<AL4BL8G.L16G"
CASE 4: MBuff$ = "L4A.L8A>FEDCGP8L4D.P8L8<G.L16GL4A.L8A>FEDCL16"
CASE 5: MBuff$ = "CDEDP16L8<A"
CASE 6: MBuff$ = "L4BP16L8>G.L16GL8>C.L16<A+L8G+.L16GL8F.L16D+L8D.L16CL1G"
CASE 7: MBuff$ = "L2G.P16L16GGGL8>CP8L16<CCCL2C.": Count% = -1
END SELECT
'PLAY "MB X" + VARPTR$(MBuff$)
RETURN
28
SCREEN 13
END SUB

