DECLARE SUB hiscore ()
'My Useful Subs
DECLARE SUB SparklePause ()
DECLARE SUB credits ()
DECLARE SUB center (row, text$)
DECLARE SUB reallydead ()
DECLARE SUB death ()
DECLARE SUB cheat ()
DECLARE SUB explode (boomx!, boomy!, size!)
DECLARE SUB deflect ()
DECLARE SUB delay ()
DECLARE SUB level (lev)
' All the subs and the main module SHARE all these values

COMMON SHARED speed#
COMMON SHARED a$
COMMON SHARED score
COMMON SHARED det
COMMON SHARED Mhz
COMMON SHARED length
COMMON SHARED curcolor
COMMON SHARED lev
COMMON SHARED x
COMMON SHARED y
COMMON SHARED direction$
COMMON SHARED tint
COMMON SHARED shot
COMMON SHARED shotx
COMMON SHARED shoty
COMMON SHARED shoted
COMMON SHARED lifetot
COMMON SHARED life
COMMON SHARED diff
COMMON SHARED tgi
'Allocating Memory for arrays
DIM SHARED init(100)
DIM shotx(2000)
DIM shoty(2000)
DIM shots(2000)
DIM shoted(2000)
DIM shotcol(2000)
DIM dir(2000)
DIM shot(2000)
DIM OX(1000), OY(1000)
' Invincibility, 1 = on 0 = off
inv = 0
' Debug Mode
debug = 0
' Life
lifetot = 10
'Starting Length
length = 2
'What color circle to start out on
curcolor = 1
'Initial Color of Fred
tint = 15
SCREEN 13
'Starting X
x = 160
'Starting Y
y = 100
'Initializing The "Tail"
FOR a = 1 TO length: OX(a) = x: OY(a) = y: NEXT a
    SCREEN 0
    WIDTH 80, 25
    COLOR 15, 0
    CLS

    center 3, "Q B a s i c   N i b b l e s  II"
    COLOR 7
    PRINT "        Here is the Sequel to Nibbles, namely Nibbles II. I have taken"
    PRINT "        the basic gameplay idea and turned it to a game that resembles"
    PRINT "        the original Nibbles in Many ways, you go around trying to pick"
    PRINT "        up numbers and go to different levels, except now it is in "
    PRINT "        a graphics mode and looks a lot better, plus there are TONS"
    PRINT "        of more levels and the code is really easy to modify, unlike"
    PRINT "        the originals. The coolest thing (I think) that Nibbles II has"
    PRINT "        is the ability to Shoot a bullet that explodes, erasing part"
    PRINT "        of the level temporarily, I love getting E-mail, so Please"
    PRINT "        Mail me at alonsoma@bvsd.k12.co.us if you are playing this "
    PRINT "        game, with comments and suggestions or questions.... ENJOY"
    center 16, "Game Controls"
    PRINT "                                       " + CHR$(24) + "                  "
    PRINT "                                     " + CHR$(27) + "   " + CHR$(26) + " "
    PRINT "                                       " + CHR$(25) + "       "
    center 20, "<SPACEBAR> To Shoot"
    PLAY "MBT160O1L8CDEDCDL4ECC"
    SparklePause

CLS
INPUT " Difficulty Level 1-100 (20 is good)? >"; speed#
INPUT " Tail Grow Increment, Too Much Can Affect Speed (3 is good)? > "; tgi
INPUT " Reset HI-SCORE (Type yes if you have never played)? > "; ssd$
IF ssd$ = "yes" THEN
OPEN "hiscore.nib" FOR OUTPUT AS #1
PRINT #1, "Bob The Destroyer"
PRINT #1, 6666
CLOSE #1
END IF
CLS
OPEN "hiscore.nib" FOR INPUT AS #1
INPUT #1, name2$
center 12, name2$
INPUT #1, score3
LOCATE 13, 37
PRINT score3
CLOSE #1

SLEEP

    speed# = speed# * 3
    speed# = (100 - speed#) * 2 + 1
eset:
    starttime# = TIMER                          ' Calculate speed of system
    FOR I = 1 TO 1000: NEXT I                 ' and do some compensation
    stoptime# = TIMER
    IF stoptime# - starttime# = 0 THEN GOTO eset
    speed# = speed# * .5 / (stoptime# - starttime#)

CLS
OPEN "hiscore.nib" FOR INPUT AS #1

SCREEN 13
    PLAY "T160O1>L20CDEDCDL10ECC"

DO


life = (lifetot - det)

LOCATE 1, 1
COLOR 15
IF debug = 1 THEN PRINT life; score; lev + 1; x; y; direction$
IF debug <> 1 THEN PRINT "Lives ="; life; " Score ="; score; "Level ="; lev + 1; ""
'Controller Loop
' I use a direction$ system that makes everything
' extremely simple to comprehend and work with
SELECT CASE INKEY$
CASE CHR$(27)
LOCATE 11, 11
COLOR 1
PRINT "GAME PAUSED"
SLEEP
init(lev) = 0
level lev
CASE "d"
curcolor = 10
CASE CHR$(0) + "H"
IF inv = 1 THEN direction$ = "up": GOTO r2
IF direction$ <> "down" THEN direction$ = "up"
CASE CHR$(0) + "P"
IF inv = 1 THEN direction$ = "down": GOTO r2
IF direction$ <> "up" THEN direction$ = "down"
CASE CHR$(0) + "K"
IF inv = 1 THEN direction$ = "left": GOTO r2
IF direction$ <> "right" THEN direction$ = "left"
CASE " "
shots = shots + 1
CASE CHR$(0) + "M"
IF inv = 1 THEN direction$ = "right": GOTO r2
IF direction$ <> "left" THEN direction$ = "right"
END SELECT
r2:
'Useing the directions to add to the X coor or Y coor
IF direction$ = "left" THEN x = x - 1
IF direction$ = "right" THEN x = x + 1
IF direction$ = "up" THEN y = y - 1
IF direction$ = "down" THEN y = y + 1

'Detecting if you have just run into a circle of the current color
' Or if you just run into something you shouldn't have, if a circle
' is detected then it then it adds 1 to the current color and sets
' it up so my level sub redraws everything when it is called again
' it also adds 2 times the current color to the length.
SELECT CASE direction$
CASE "left"
IF POINT(x - 1, y) = curcolor THEN curcolor = curcolor + 1: init(lev) = 0: length = length + (curcolor * tgi): score = score + (curcolor * 100): PLAY "MBO0L16>CCCE": GOTO r
IF inv <> 1 THEN IF POINT(x - 1, y) <> 0 THEN death
CASE "right"
IF POINT(x + 1, y) = curcolor THEN curcolor = curcolor + 1: init(lev) = 0: length = length + (curcolor * tgi): score = score + (curcolor * 100): PLAY "MBO0L16>CCCE": GOTO r
IF inv <> 1 THEN IF POINT(x + 1, y) <> 0 THEN death
CASE "up"
IF POINT(x, y - 1) = curcolor THEN curcolor = curcolor + 1: init(lev) = 0: length = length + (curcolor * tgi): score = score + (curcolor * 100): PLAY "MBO0L16>CCCE": GOTO r
IF inv <> 1 THEN IF POINT(x, y - 1) <> 0 THEN death
CASE "down"
IF POINT(x, y + 1) = curcolor THEN curcolor = curcolor + 1: init(lev) = 0: length = length + (curcolor * tgi): score = score + (curcolor * 100): PLAY "MBO0L16>CCCE": GOTO r
IF inv <> 1 THEN IF POINT(x, y + 1) <> 0 THEN death
END SELECT
r:
' If the player tries to go off screen then
' the deflect sub is called, all it does is
' If direction$ = "left" then direction$ = "right"
' Take a look at it
IF x >= 315 THEN deflect
IF x <= 5 THEN deflect
IF y >= 195 THEN deflect
IF y <= 10 THEN deflect
' My special little cheat, just got to activate invinibility and you can
' somehow trick deflect into letting you go by
' then you are rewarded by seeing a pulsating circle
IF x < -800 AND y > 800 THEN CALL cheat
' Setting the Tail
OX(0) = x: OY(0) = y



 FOR a = length TO 1 STEP -1: OX(a) = OX(a - 1): OY(a) = OY(a - 1): NEXT a: OX(0) = x: OY(0) = y


'Drawing FRED in TINT color, which is also set by the
'deflect sub
PSET (x, y), tint

' The delay sub is called and well
' delay's the game
delay
' The Shooting Routine, If took it from one of my other
' games and converted it. If you push space you will fire a bullet
' which will explode on contact with any color that is not 0
' You can fire multiple bullets
' I WILL NOT EXPLAIN WHAT FOLLOWS
FOR d = 1 TO shots
PSET (shotx(d), shoty(d)), 0
NEXT d
FOR d = 1 TO shots
IF shoted(d) <> 0 THEN GOTO nsores
shoted(d) = 1
IF direction$ = "up" THEN shotx(d) = x + 1: shoty(d) = y
IF direction$ = "down" THEN shotx(d) = x - 1: shoty(d) = y
IF direction$ = "left" THEN shotx(d) = x: shoty(d) = y - 1
IF direction$ = "right" THEN shotx(d) = x + 1: shoty(d) = y + 1

shotcol(d) = 8
SELECT CASE direction$
CASE "up"
dir(d) = 1
CASE "down"
dir(d) = 2
CASE "left"
dir(d) = 3
CASE "right"
dir(d) = 4
END SELECT
nsores:
NEXT d
nores:
FOR d = 1 TO shots
IF dir(d) = 1 THEN shoty(d) = shoty(d) - 2
IF dir(d) = 2 THEN shoty(d) = shoty(d) + 2
IF dir(d) = 3 THEN shotx(d) = shotx(d) - 2
IF dir(d) = 4 THEN shotx(d) = shotx(d) + 2
SELECT CASE dir(d)
CASE 1
IF POINT(shotx(d), shoty(d) - 2) <> 0 THEN : shot(d) = 0: shoted(d) = 0: shots = shots - 1: explode shotx(d), shoty(d), 100
CASE 2
IF POINT(shotx(d), shoty(d) + 2) <> 0 THEN : shot(d) = 0: shoted(d) = 0: shots = shots - 1: explode shotx(d), shoty(d), 100
CASE 3
IF POINT(shotx(d) - 2, shoty(d)) <> 0 THEN : shot(d) = 0: shoted(d) = 0: shots = shots - 1: explode shotx(d), shoty(d), 100
CASE 4
IF POINT(shotx(d) + 2, shoty(d)) <> 0 THEN : shot(d) = 0: shoted(d) = 0: shots = shots - 1: explode shotx(d), shoty(d), 100

END SELECT
IF shotx(d) >= 320 THEN shot(d) = 0: shoted(d) = 0: shots = shots - 1: GOTO resum
IF shotx(d) <= 0 THEN shot(d) = 0: shoted(d) = 0: shots = shots - 1: GOTO resum
IF shoty(d) <= 0 THEN shot(d) = 0: shoted(d) = 0: shots = shots - 1: GOTO resum
IF shoty(d) >= 200 THEN shot(d) = 0: shoted(d) = 0: shots = shots - 1: GOTO resum
shotcol = 8
PSET (shotx(d), shoty(d)), shotcol
NEXT d
' Ahhh, that's the end of that nasty shooting routine
' Here's where the prgram resumes
resum:
' If the current color => 10 then go to the next level
' also set the current color back to 1 and length to 1

IF curcolor >= 10 THEN lev = lev + 1: curcolor = 1: length = 2: x = 160: y = 110: direction$ = "none": LOCATE 11, 11: COLOR 4: PRINT "LEVEL"; lev; "": SLEEP: SOUND 5000, 3
' Erasing Fred's Tail

PSET (OX(length), OY(length)), 0

' The Level Sub is extremely handy, you tell it
' the current level and it does everything else for you
level lev
'Back again
LOOP

SUB center (row, text$)
    LOCATE row, 41 - LEN(text$) / 2
    PRINT text$;
END SUB

SUB cheat
DO
'Just draws a stupid pulsating circle with PALLETE
FOR ctr = 1 TO 100
PALETTE (4), ctr / 2

CIRCLE (160, 100), ctr, 4
NEXT ctr

FOR ctr = 100 TO 1 STEP -1
PALETTE (4), ctr / 2
CIRCLE (160, 100), ctr, 0
FOR ct2r = 1 TO 1000
NEXT ct2r
NEXT ctr

LOOP

END SUB

SUB credits
SCREEN 12
COLOR 2
PRINT " Executive Producer: Lucas Alonso "
COLOR 1
PRINT " Producer: Lucas Alonso "
COLOR 4
PRINT " Quality Assurance: Lucas Alonso"
COLOR 5
PRINT " Lead Programmer: Lucas Alonso "
COLOR 6
PRINT " Senior Programmer: Alonso"
COLOR 10
PRINT " Junior Programmer: Lucas Alonso "
COLOR 9
PRINT " Debugger: Lucas Alonso"
COLOR 1
PRINT " Level Designers:"
PRINT " Lucas Alonso, Dana Nelson"
COLOR 3
PRINT " Lead Tester: Roldan Melcon"
COLOR 4
PRINT " Testers:"
PRINT " Dana Nelson"
COLOR 14
PRINT " Helping The Programmer Remember Stuff Team:"
PRINT " Roldan Melcon"
COLOR 5
PRINT " Feed The Programmer Team:"
PRINT " Roldan Melcon"
COLOR 3
PRINT " If you ingore all the BS up there, The Guy That Did EVERTHING:"
PRINT " Lucas Alonso"

PRINT " PLEASE E-MAIL ME FOR UPDATES OF THIS GAME: 2 PLAYER SUPPORT MORE LEVEL ECT ECT"
PRINT " E-MAIL ME AT alonsoma@bvsd.k12.co.us"
hiscore
SLEEP
SLEEP
SLEEP
END

END SUB

SUB death
PLAY "MBO0L32EFGEFDC"'die
LOCATE 11, 11
COLOR 4
PRINT " Sammy Dies: HA HA"
LOCATE 12, 11
PRINT " Press Any Key To Continue"
SLEEP
det = det + 1
life = (lifetot - det)
score = score - 1000
IF life = 0 THEN reallydead
direction$ = "none"
curcolor = 1
init(lev) = 0
length = 2
x = 160
y = 110
IF lev = 9 THEN x = 100
IF lev = 10 THEN x = 100

CLS
END SUB

SUB deflect
SELECT CASE direction$
' This is a very handy sub, reverses the direction you are going
' and alters it slighty so you won't run into yourself
CASE "up"
direction$ = "down"
IF inv <> 1 THEN x = x + 1
tint = 1
CASE "down"
direction$ = "up"
IF inv <> 1 THEN x = x - 1
tint = 3
CASE "left"
direction$ = "right"
IF inv <> 1 THEN y = y + 1
tint = 2
CASE "right"
direction$ = "left"
IF inv <> 1 THEN y = y - 1
tint = 4
END SELECT
END SUB

SUB delay
FOR a# = 1 TO speed# - (length * 1.5): NEXT a#
END SUB

SUB explode (boomx, boomy, size)
' Just a standard exploding routine, nothing spectacular
size = 20
FOR rad = 1 TO size
CIRCLE (boomx, boomy), rad, 4
FOR ctr = 1 TO 100
NEXT ctr
NEXT rad
FOR ctr = 1 TO 100
NEXT ctr
IF POINT(enemyx, enemyy) = 4 THEN enemyflag = 1
FOR rad = size TO 1 STEP -1
CIRCLE (boomx, boomy), rad, 0
FOR ctr = 1 TO 100
NEXT ctr

NEXT rad
END SUB

SUB hiscore
CLS
CLOSE
OPEN "hiscore.nib" FOR INPUT AS #1
INPUT #1, name$
INPUT #1, score2
CLOSE #1
IF score > score2 THEN
PRINT " YOU HAVE AN AMAZING SCORE"
PRINT " PREPARE TO BE IMORTALIZED"
PRINT " PRESS ANY KEY TWICE TO CONTINUE"
SLEEP

INPUT "Your Name? >"; name$
OPEN "hiscore.nib" FOR OUTPUT AS #1
PRINT #1, name$
PRINT #1, score
CLOSE #1
END IF

END SUB

SUB level (lev)
' My most handy sub
' You tell it waht level to make
'and it draws it on the screen, you can add
' new levels with incredible ease just create a new CASE statment
' and copy and exsisting into it then modify the graphics part
SELECT CASE lev
CASE 0
IF init(0) <> 1 THEN
CLS
init(0) = 1
RANDOMIZE TIMER
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor

END IF
CASE 1
IF init(1) <> 1 THEN
CLS
init(1) = 1

LINE (70, 100)-(230, 100), 15
RANDOMIZE TIMER
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor

END IF
CASE 2
IF init(2) <> 1 THEN
CLS
init(2) = 1

PSET (80, 100), 15
DRAW "c15"
DRAW "U70 D70 R50"
DRAW "c0 r30"
DRAW "c15 u70 r50 d70 u40 l 50"
RANDOMIZE TIMER
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor

END IF
CASE 3
IF init(3) <> 1 THEN
CLS
init(3) = 1

LINE (100, 100)-(200, 200), 233
LINE (100, 100)-(50, 50), 123
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF
CASE 4
IF init(4) <> 1 THEN
CLS
init(4) = 1

LINE (0, 0)-(319, 0), 84
LINE (0, 199)-(319, 199), 55
LINE (319, 199)-(319, 0), 133
LINE (0, 0)-(0, 199), 212
LINE (50, 50)-(50, 150), 54
LINE (270, 50)-(270, 150), 89
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor

END IF
CASE 5
IF init(5) <> 1 THEN
CLS
init(5) = 1
CIRCLE (160, 100), 50, 43, , 6
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF
CASE 6
IF init(6) <> 1 THEN
CLS
init(6) = 1
LINE (10, 0)-(100, 100), 2, , &H66
LINE (100, 100)-(0, 200), 4, , &H66
LINE (320, 200)-(220, 100), 4, , &H66
LINE (220, 100)-(320, 0), 2, , &H66
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF
CASE 7
IF init(7) <> 1 THEN
CLS
init(7) = 1
LINE (160, 0)-(160, 80), 2
LINE (160, 120)-(160, 200), 3
LINE (0, 100)-(140, 100), 4
LINE (180, 100)-(320, 100), 1
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF

CASE 8
IF init(8) <> 1 THEN
CLS
IF r2d2 <> 1 THEN
DIM xtl2(10)
DIM ytl(10)
DIM xtl(10)
DIM ytl2(10)
 
RANDOMIZE TIMER
xtl(1) = INT(RND * 320)
ytl(1) = INT(RND * 200)
xtl2(1) = INT(RND * 320)
ytl2(1) = INT(RND * 200)
xtl(2) = INT(RND * 320)
ytl(2) = INT(RND * 200)
xtl2(2) = INT(RND * 320)
ytl2(2) = INT(RND * 200)
xtl(3) = INT(RND * 320)
ytl(3) = INT(RND * 200)
xtl2(3) = INT(RND * 320)
ytl2(3) = INT(RND * 200)
r2d2 = 1
END IF
LINE (xtl(1), ytl(1))-(xtl2(1), ytl2(1)), INT(RND * 200)
LINE (xtl(2), ytl(2))-(xtl2(2), ytl2(2)), INT(RND * 200)
LINE (xtl(3), ytl(3))-(xtl2(3), ytl2(3)), INT(RND * 200)

init(8) = 1
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF
CASE 9
IF init(9) <> 1 THEN
CLS
init(9) = 1
RANDOMIZE TIMER
LINE (100, 100)-(130, 0), INT(RND * 200) + 1
LINE (200, 100)-(130, 0), INT(RND * 200) + 1
LINE (171, 100)-(171, 150), INT(RND * 200) + 1
LINE (129, 100)-(129, 150), INT(RND * 200) + 1
LINE (100, 100)-(200, 100), INT(RND * 200) + 1
LINE (129, 100)-(171, 100), INT(RND * 200) + 1
LINE (129, 150)-(171, 150), INT(RND * 200) + 1

lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF


CASE 10
IF init(10) <> 1 THEN
CLS
init(10) = 1
RANDOMIZE TIMER
COLOR 15
CIRCLE (160, 150), 50, 15
CIRCLE (160, 77), 36, 15
CIRCLE (160, 27), 25, 15
CIRCLE (150, 20), 3, INT(RND * 200)
CIRCLE (170, 20), 3, INT(RND * 200)
PSET (160, 27), 0
DRAW "d4"
DRAW "C2 l2 r4 h2 g2"
LINE (150, 38)-(170, 38)


lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF

CASE 11
IF init(11) <> 1 THEN
CLS
init(11) = 1
RANDOMIZE TIMER
CIRCLE (160, 100), 40, INT(RND * 200), , , .1
CIRCLE (250, 100), 40, INT(RND * 200), , , .5
CIRCLE (50, 100), 40, INT(RND * 200), , , .3
LINE (160, 100)-(200, 200)


lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF

CASE 12
IF init(12) <> 1 THEN
CLS
init(12) = 1
FOR ctr = 1 TO 40
PSET (INT(RND * 320), INT(RND * 200)), INT(RND * 200)
NEXT ctr


lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF

CASE 13
IF init(13) <> 1 THEN
CLS
init(13) = 1
LINE (0, 0)-(100, 100), INT(RND * 200), B
LINE (319, 0)-(219, 100), INT(RND * 200), B
LINE (319, 199)-(219, 100), INT(RND * 200), B
LINE (0, 199)-(100, 100), INT(RND * 200), B


lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF

CASE 14
IF init(14) <> 1 THEN
CLS
init(14) = 1
FOR r = .1 TO .9 STEP .4
CIRCLE (160, 100), 70, INT(RND * 200), , , r * 2
NEXT r
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF

CASE 15
IF init(15) <> 1 THEN
CLS
init(15) = 1

CIRCLE (160, 100), 100, INT(RND * 200)

lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF

CASE 16
IF init(16) <> 1 THEN
CLS
init(16) = 1
LINE (0, 100)-(160, 0), INT(RND * 200)
LINE (160, 0)-(320, 100), INT(RND * 200)
LINE (0, 100)-(160, 200), INT(RND * 200)
LINE (160, 200)-(320, 100), INT(RND * 200)


lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF

CASE 17
IF init(17) <> 1 THEN
CLS
init(17) = 1

CIRCLE (160, 100), 100, INT(RND * 200)
CIRCLE (160, 100), 50, INT(RND * 200)

lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF

CASE 18
IF init(18) <> 1 THEN
CLS
init(18) = 1
LOCATE 2, 15
COLOR 5
PRINT "A NEW HOPE"
COLOR 1
LOCATE 10, 9
PRINT "THE EMPIRE STRIKES BACK"
LOCATE 20, 11
COLOR 2
PRINT "RETURN OF THE JEDI"
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF

CASE 19
IF init(19) <> 1 THEN
CLS
init(19) = 1
CIRCLE (110, 100), 40, 3
CIRCLE (210, 100), 40, 3
LINE (148, 90)-(172, 90), 5
LINE (148, 91)-(172, 91), 5
LINE (148, 92)-(172, 92), 5

lx = INT(RND * 24) + 2
ly = INT(RND * 34) + 3
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF


CASE 20
IF init(20) <> 1 THEN
CLS
init(20) = 1
CIRCLE (160, 100), 20, 212, 1
CIRCLE (160, 100), 50, 65, .9
CIRCLE (160, 100), 70, 144, .8
LINE (0, 100)-(70, 100)
LINE (320, 100)-(250, 100)
lx = INT(RND * 24) + 2
ly = INT(RND * 38) + 1
LOCATE lx, ly
COLOR curcolor
PRINT curcolor
END IF
CASE ELSE
credits
END SELECT
END SUB

SUB reallydead
CLS
LOCATE 11, 16
COLOR 1
PRINT "GAME OVER"
LOCATE 12, 16
COLOR 10
PRINT "TRY AGAIN"
FOR ctr = 1 TO 300
NEXT ctr
hiscore
CLS
END

END SUB

SUB SparklePause
  
    COLOR 4, 0
    a$ = "*    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    "
    IF INKEY$ = "n" OR INKEY$ = "N" THEN
    END IF
    WHILE INKEY$ <> "": WEND   'Clear keyboard buffer

    WHILE INKEY$ = ""
        FOR a = 1 TO 5
            LOCATE 1, 1                             'print horizontal sparkles
            PRINT MID$(a$, a, 80);
            LOCATE 22, 1
            PRINT MID$(a$, 6 - a, 80);

            FOR B = 2 TO 21                         'Print Vertical sparkles
                C = (a + B) MOD 5
                IF C = 1 THEN
                    LOCATE B, 80
                    PRINT "*";
                    LOCATE 23 - B, 1
                    PRINT "*";
                ELSE
                    LOCATE B, 80
                    PRINT " ";
                    LOCATE 23 - B, 1
                    PRINT " ";
                END IF
            NEXT B
        NEXT a
    WEND

END SUB

