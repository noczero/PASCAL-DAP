' WW         WW   EEEEE   LL       CCCCC    OOOO     MM      MM   EEEEE
'  WW       WW    EE      LL      CC       OO  OO    MMMM  MMMM   EE
'   WW  W  WW     EEEE    LL     CC       OO    OO   MM MMMM MM   EEEE
'    WW W WW      EE      LL      CC       OO  OO    MM      MM   EE
'     WWWWW       EEEEE   LLLLL    CCCCC    OOOO     MM      MM   EEEEE
'
' Welcome To My Starry Demo.  This Demo Shows How Powerful DRAW Can Be.  The
' Only Graphic Statements Here Are DRAW And PSET.  PSET Is Only Used
' To Locate Coordinates And Draw The Background.  The Drawing, Sizing,
' And Rotating Are Done Using The DRAW Statement.  This Is Also A Good
' Page Flipping Demo.  It's Public Domain So Change It If You Want.
' Enjoy!

TYPE STARPOS
     X AS INTEGER
     Y AS INTEGER
     C AS INTEGER
END TYPE

DIM STARS(200) AS STARPOS

Mode = 1 ' Sets Current Sizing Mode
NEWSTAR = 1
SCREEN 7 ' Sets the Screen to EGA 320x200x16

FOR I = 1 TO 100 ' Starts a Loop from 1 To 100
STARS(I).X = INT(RND * 320) + 1
STARS(I).Y = INT(RND * 320) + 1
STARS(I).C = 8
PSET (STARS(I).X, STARS(I).Y + 1), 8  ' Makes a Grey Dot
NEXT I ' Repeat

FOR I = 101 TO 200
STARS(I).X = INT(RND * 320) + 1
STARS(I).Y = INT(RND * 320) + 1
STARS(I).C = 15
PSET (STARS(I).X, STARS(I).Y), 15
NEXT I

PCOPY 0, 1 ' Sets Video Page 1 to Current Picture

DIRECT = 1     '-
DIRECT2 = 2    ': Sets Starting Directions
DIRECT3 = 3    ':
DIRECT4 = 4    '-
X1 = 160: Y1 = 100 '-
X2 = 160: Y2 = 100 ': Sets Starting Coordinates
X3 = 160: Y3 = 100 ':
X4 = 160: Y4 = 100 '-

STAR$ = "L5R10L5U5D10U5F5H10F5E5G10E5 " 'Uses DRAW Subcommands to Draw Star.
STAR2$ = "U5D10U5L5R10L5" 'Uses DRAW to Draw Twinkle Stars
MESSAGE$ = "BL10D20U40D20R10U20D40U20BR10U20D40U20" 'Uses DRAW to Draw "HI"

DO
PCOPY 1, 0 ' Copys Video Page 1, Which I Made A StarField, to the Screen
PSET (X1, Y1), 4
IF Mode = 1 THEN size = size + 1: size2 = size2 + 1: IF size = 10 THEN Mode = 2
IF Mode = 2 THEN size = size - 1: IF size = 1 THEN Mode = 1: NEWSTAR = 1: IF HI < 4 THEN HI = HI + 1 ELSE HI = 0: size2 = 1
turn = turn + 5: IF turn > 360 THEN turn = 0 ' Turns Angle
DRAW "S" + STR$(size) + "TA" + STR$(turn) + STAR$  '-
PSET (X2, Y2), 4                                   ':Draws Stars (TA turns
DRAW "S" + STR$(size) + "TA" + STR$(turn) + STAR$  ':             it and S
PSET (X3, Y3), 4                                   ':             sizes it.)
DRAW "S" + STR$(size) + "TA" + STR$(turn) + STAR$  ':
PSET (X4, Y4), 4                                   ':
DRAW "S" + STR$(size) + "TA" + STR$(turn) + STAR$  '-
PSET (160, 100)

IF HI = 1 THEN
   DRAW "S" + STR$(FIX(size2 / 2)) + "TA0" + MESSAGE$
ELSEIF HI = 0 THEN
       DRAW "S" + STR$(size * 8) + "TA" + STR$(turn) + "C3" + STAR$
ELSEIF HI > 1 AND HI < 4 THEN
       DRAW "S" + "9" + "TA0" + MESSAGE$
END IF

IF NEWSTAR = 1 THEN TWINKLE = INT(RND * 200) + 1: NEWSTAR = 0

PSET (STARS(TWINKLE).X, STARS(TWINKLE).Y), STARS(TWINKLE).C
DRAW "S" + STR$(FIX(size / 2) + 1) + "TA0" + "C" + STR$(STARS(TWINKLE).C) + STAR2$
PSET (STARS(TWINKLE).X, STARS(TWINKLE).Y), STARS(TWINKLE).C


IF DIRECT = 1 THEN X1 = X1 + 1: Y1 = Y1 - 1 '-
IF DIRECT = 2 THEN X1 = X1 + 1: Y1 = Y1 + 1 ': Determines What Direction
IF DIRECT = 3 THEN X1 = X1 - 1: Y1 = Y1 + 1 ': And Moves Star's coordinate
IF DIRECT = 4 THEN X1 = X1 - 1: Y1 = Y1 - 1 '-
IF DIRECT = 1 AND Y1 < 0 THEN DIRECT = 2    '-
IF DIRECT = 1 AND X1 > 320 THEN DIRECT = 4  ':
IF DIRECT = 2 AND X1 > 320 THEN DIRECT = 3  ': Sees if Star Goes Past
IF DIRECT = 2 AND Y1 > 200 THEN DIRECT = 1  ': And Changes Directions.
IF DIRECT = 3 AND Y1 > 200 THEN DIRECT = 4  ': The Values DIRECT, X1, And Y1
IF DIRECT = 3 AND X1 < 0 THEN DIRECT = 2    ':
IF DIRECT = 4 AND X1 < 0 THEN DIRECT = 1    ':
IF DIRECT = 4 AND Y1 < 0 THEN DIRECT = 3    '-
IF DIRECT2 = 1 THEN X2 = X2 + 1: Y2 = Y2 - 1'-
IF DIRECT2 = 2 THEN X2 = X2 + 1: Y2 = Y2 + 1':
IF DIRECT2 = 3 THEN X2 = X2 - 1: Y2 = Y2 + 1':
IF DIRECT2 = 4 THEN X2 = X2 - 1: Y2 = Y2 - 1':
IF DIRECT2 = 1 AND Y2 < 0 THEN DIRECT2 = 2  ':
IF DIRECT2 = 1 AND X2 > 320 THEN DIRECT2 = 4':
IF DIRECT2 = 2 AND X2 > 320 THEN DIRECT2 = 3':
IF DIRECT2 = 2 AND Y2 > 200 THEN DIRECT2 = 1':
IF DIRECT2 = 3 AND Y2 > 200 THEN DIRECT2 = 4':
IF DIRECT2 = 3 AND X2 < 0 THEN DIRECT2 = 2  ': Dido With the Other Three Stars
IF DIRECT2 = 4 AND X2 < 0 THEN DIRECT2 = 1  ': using DIRECT2, X2, Y2, DIRECT3
IF DIRECT2 = 4 AND Y2 < 0 THEN DIRECT2 = 3  ': and So On
IF DIRECT3 = 1 THEN X3 = X3 + 1: Y3 = Y3 - 1':
IF DIRECT3 = 2 THEN X3 = X3 + 1: Y3 = Y3 + 1':
IF DIRECT3 = 3 THEN X3 = X3 - 1: Y3 = Y3 + 1':
IF DIRECT3 = 4 THEN X3 = X3 - 1: Y3 = Y3 - 1':
IF DIRECT3 = 1 AND Y3 < 0 THEN DIRECT3 = 2  ':
IF DIRECT3 = 1 AND X3 > 320 THEN DIRECT3 = 4':
IF DIRECT3 = 2 AND X3 > 320 THEN DIRECT3 = 3':
IF DIRECT3 = 2 AND Y3 > 200 THEN DIRECT3 = 1':
IF DIRECT3 = 3 AND Y3 > 200 THEN DIRECT3 = 4':
IF DIRECT3 = 3 AND X3 < 0 THEN DIRECT3 = 2  ':
IF DIRECT3 = 4 AND X3 < 0 THEN DIRECT3 = 1  ':
IF DIRECT3 = 4 AND Y3 < 0 THEN DIRECT3 = 3  ':
IF DIRECT4 = 1 THEN X4 = X4 + 1: Y4 = Y4 - 1':
IF DIRECT4 = 2 THEN X4 = X4 + 1: Y4 = Y4 + 1':
IF DIRECT4 = 3 THEN X4 = X4 - 1: Y4 = Y4 + 1':
IF DIRECT4 = 4 THEN X4 = X4 - 1: Y4 = Y4 - 1':
IF DIRECT4 = 1 AND Y4 < 0 THEN DIRECT4 = 2  ':
IF DIRECT4 = 1 AND X4 > 320 THEN DIRECT4 = 4':
IF DIRECT4 = 2 AND X4 > 320 THEN DIRECT4 = 3':
IF DIRECT4 = 2 AND Y4 > 200 THEN DIRECT4 = 1':
IF DIRECT4 = 3 AND Y4 > 200 THEN DIRECT4 = 4':
IF DIRECT4 = 3 AND X4 < 0 THEN DIRECT4 = 2  ':
IF DIRECT4 = 4 AND X4 < 0 THEN DIRECT4 = 1  ':
IF DIRECT4 = 4 AND Y4 < 0 THEN DIRECT4 = 3  '-
FOR I = 1 TO 250: NEXT I ' Pauses for 250 Loops
LOOP UNTIL INKEY$ <> "" ' Repeats Until a Key is Pressed
END
SYSTEM

