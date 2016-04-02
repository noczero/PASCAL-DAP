'
'        Ninja Man!
'
'
'
'   This program was made by Steve Nunnally. Copyright (C) 1997
'All of this code was written by me, Steve Nunnally. DO NOT copy
'this code unless you have my permission! And you MAY NOT change
'the name in this paragraph to your name.      
'
DIM SHARED over AS INTEGER
DIM SHARED up AS INTEGER
DIM SHARED ninja(400)
DIM SHARED ninja.r(400)
DIM SHARED ninja.l(400)
DIM SHARED ninja.right(400)
DIM SHARED ninja.left(400)
DIM SHARED ninja.down(400)
DIM SHARED brick(400)
DIM SHARED ladder(400)
DIM SHARED rope(400)
DIM SHARED ropetop(400)
ON ERROR GOTO FellOff
CLS : SCREEN 12
DEF SEG = 0
POKE 1047, 160
DEF SEG
'Your guy from front
CIRCLE (30, 30), 5, 4: PAINT (30, 30), 4
LINE (34, 27)-(26, 27), 10
LINE (30, 35)-(30, 47), 4: LINE (30, 47)-(25, 56), 4
LINE (30, 47)-(35, 56), 4: LINE (25, 42)-(35, 42), 4
'You guy falling
CIRCLE (330, 150), 5, 4: PAINT (330, 150), 4
LINE (334, 153)-(326, 153), 10
LINE (330, 145)-(330, 133), 4: LINE (330, 133)-(325, 124), 4
LINE (330, 133)-(335, 124), 4: LINE (325, 138)-(335, 138), 4
'Your guy going right
CIRCLE (130, 30), 5, 4: PAINT (130, 30), 4
LINE (134, 27)-(127, 27), 10: LINE (127, 27)-(123, 24), 10
LINE (126, 27)-(122, 31), 10: LINE (130, 35)-(130, 47), 4
LINE (130, 47)-(125, 56), 4: LINE (130, 47)-(135, 56), 4
LINE (130, 42)-(135, 45), 4: LINE (135, 45)-(138, 40), 4
LINE (130, 42)-(135, 40), 4: LINE (135, 40)-(138, 35), 4
'Your guy going right moving feet
CIRCLE (430, 30), 5, 4: PAINT (430, 30), 4
LINE (434, 27)-(427, 27), 10: LINE (427, 27)-(423, 24), 10
LINE (426, 27)-(422, 31), 10: LINE (430, 35)-(430, 47), 4
LINE (430, 47)-(430, 56), 4: LINE (430, 42)-(435, 45), 4
LINE (435, 45)-(438, 40), 4: LINE (430, 42)-(435, 40), 4
LINE (435, 40)-(438, 35), 4
'Your guy going left
CIRCLE (230, 30), 5, 4: PAINT (230, 30), 4
LINE (226, 27)-(233, 27), 10: LINE (233, 27)-(237, 23), 10
LINE (234, 27)-(238, 31), 10: LINE (230, 35)-(230, 47), 4
LINE (230, 47)-(235, 56), 4: LINE (230, 47)-(225, 56), 4
LINE (230, 42)-(225, 45), 4: LINE (225, 45)-(222, 40), 4
LINE (230, 42)-(225, 40), 4: LINE (225, 40)-(222, 35), 4
'Your guy going left moving feet
CIRCLE (330, 30), 5, 4: PAINT (330, 30), 4
LINE (326, 27)-(333, 27), 10: LINE (333, 27)-(337, 23), 10
LINE (334, 27)-(338, 31), 10: LINE (330, 35)-(330, 47), 4
LINE (330, 47)-(330, 56), 4: LINE (330, 42)-(325, 45), 4
LINE (325, 45)-(322, 40), 4: LINE (330, 42)-(325, 40), 4
LINE (325, 40)-(322, 35), 4
'The walls and floors
LINE (520, 25)-(540, 40), 8, BF
'The ladder you use to climb
LINE (20, 125)-(20, 140), 1
LINE (40, 125)-(40, 140), 1
LINE (20, 133)-(40, 133), 1
LINE (20, 140)-(40, 140), 1
'The Climbing rope
LINE (120, 125)-(140, 140), 8, BF
LINE (127, 125)-(133, 140), 2, BF
LINE (227, 125)-(233, 140), 2, BF
'Get all the pictures to use later on
GET (22, 24)-(38, 56), ninja
GET (122, 24)-(138, 56), ninja.r
GET (222, 24)-(238, 56), ninja.l
GET (322, 24)-(338, 56), ninja.left
GET (422, 24)-(438, 56), ninja.right
GET (322, 124)-(338, 156), ninja.down
GET (520, 25)-(540, 40), brick
GET (20, 125)-(40, 140), ladder
GET (120, 125)-(140, 140), ropetop
GET (220, 125)-(240, 140), rope

CLS
l = -12: w = 30: t = 0
FOR i = 1 TO 26
  b = 0
  READ s$
   FOR t = 1 TO 29
    b = b + 1
    l = l + 21
    IF MID$(s$, b, 1) = "-" THEN PUT (l, w), brick, PSET
    IF MID$(s$, b, 1) = "#" THEN PUT (l, w), ladder, PSET
    IF MID$(s$, b, 1) = "I" THEN PUT (l, w), rope, PSET
    IF MID$(s$, b, 1) = "T" THEN PUT (l, w), ropetop, PSET
    IF MID$(s$, b, 1) = "0" THEN over = l + 2: up = w - 17
   NEXT
  l = -12: w = w + 16
NEXT

'up = 332: over = 320                 'Set main variables
PUT (over, up), ninja
picture$ = "goingup"

DO                                   'Main game loop
 key$ = INKEY$
 SELECT CASE key$                    'Get the key pressed
  CASE "6"
   IF POINT(over + 15, up + 5) <> 8 AND POINT(over + 15, up + 30) <> 8 THEN
   IF picture$ = "right" THEN PUT (over, up), ninja.r, XOR
   IF picture$ = "left" THEN PUT (over, up), ninja.l, XOR
   IF picture$ = "goingup" THEN PUT (over, up), ninja, XOR
   over = over + 3
   PUT (over, up), ninja.right
   CurrentTimer! = TIMER
   WHILE TIMER < (CurrentTimer! + 4 / 100): WEND
   PUT (over, up), ninja.right, XOR
   over = over + 3
   PUT (over, up), ninja.r
   picture$ = "right"
   END IF
  CASE "4"
   IF POINT(over - 1, up + 5) <> 8 AND POINT(over - 1, up + 30) <> 8 THEN
   IF picture$ = "right" THEN PUT (over, up), ninja.r, XOR
   IF picture$ = "left" THEN PUT (over, up), ninja.l, XOR
   IF picture$ = "goingup" THEN PUT (over, up), ninja, XOR
   over = over - 3
   PUT (over, up), ninja.left
   CurrentTimer! = TIMER
   WHILE TIMER < (CurrentTimer! + 4 / 100): WEND
   PUT (over, up), ninja.left, XOR
   over = over - 3
   PUT (over, up), ninja.l
   picture$ = "left"
   END IF
  CASE "8"
   IF POINT(over + 7, up - 3) <> 8 THEN
   IF picture$ = "right" THEN PUT (over, up), ninja.r, XOR
   IF picture$ = "left" THEN PUT (over, up), ninja.l, XOR
   IF picture$ = "goingup" THEN PUT (over, up), ninja, XOR
   up = up - 15
   PUT (over, up), ninja
   CurrentTimer! = TIMER
   WHILE TIMER < (CurrentTimer! + 10 / 100): WEND
   IF POINT(over + 7, up - 5) <> 8 THEN
   PUT (over, up), ninja, XOR
   up = up - 15
   PUT (over, up), ninja
   CurrentTimer! = TIMER
   WHILE TIMER < (CurrentTimer! + 10 / 100): WEND
   END IF
   DO
    PUT (over, up), ninja, XOR
    up = up + 1
    PUT (over, up), ninja
    CurrentTimer! = TIMER
    WHILE TIMER < (CurrentTimer! + .000000000000005# / 100): WEND
   LOOP UNTIL POINT(over + 8, up + 33) <> 0
   picture$ = "goingup"
   END IF
  CASE "7"
   IF POINT(over - 1, up - 1) <> 8 THEN
   IF picture$ = "right" THEN PUT (over, up), ninja.r, XOR
   IF picture$ = "left" THEN PUT (over, up), ninja.l, XOR
   IF picture$ = "goingup" THEN PUT (over, up), ninja, XOR
   over = over - 10: up = up - 10
   PUT (over, up), ninja.l
   CurrentTimer! = TIMER
   WHILE TIMER < (CurrentTimer! + 10 / 100): WEND
   IF POINT(over - 1, up - 1) <> 8 THEN
   PUT (over, up), ninja.l, XOR
   over = over - 10: up = up - 10
   PUT (over, up), ninja.l
   CurrentTimer! = TIMER
   WHILE TIMER < (CurrentTimer! + 10 / 100): WEND
   END IF
   fall = 1
   DO
    PUT (over, up), ninja.l, XOR
    up = up + 1
    IF POINT(over + 1, up + 5) <> 8 AND POINT(over + 1, up + 30) <> 8 THEN over = over - 1
    PUT (over, up), ninja.l
    fall = fall + 1
    CurrentTimer! = TIMER
    WHILE TIMER < (CurrentTimer! + .000000000000005# / 100): WEND
    IF fall = 40 THEN GOSUB Fell
   picture$ = "left"
   LOOP UNTIL POINT(over + 11, up + 34) <> 0
   END IF
  CASE "9"
   IF POINT(over + 16, up - 1) <> 8 THEN
   IF picture$ = "right" THEN PUT (over, up), ninja.r, XOR
   IF picture$ = "left" THEN PUT (over, up), ninja.l, XOR
   IF picture$ = "goingup" THEN PUT (over, up), ninja, XOR
   over = over + 10: up = up - 10
   PUT (over, up), ninja.r
   CurrentTimer! = TIMER
   WHILE TIMER < (CurrentTimer! + 10 / 100): WEND
   IF POINT(over + 16, up - 1) <> 8 THEN
   PUT (over, up), ninja.r, XOR
   over = over + 10: up = up - 10
   PUT (over, up), ninja.r
   CurrentTimer! = TIMER
   WHILE TIMER < (CurrentTimer! + 10 / 100): WEND
   END IF
   fall = 1
   DO
    PUT (over, up), ninja.r, XOR
    up = up + 1
    IF POINT(over + 15, up + 5) <> 8 AND POINT(over + 15, up + 30) <> 8 THEN over = over + 1
    PUT (over, up), ninja.r
    fall = fall + 1
    CurrentTimer! = TIMER
    WHILE TIMER < (CurrentTimer! + .000000000000005# / 100): WEND
    IF fall = 40 THEN GOSUB Fell
   picture$ = "right"
   LOOP UNTIL POINT(over + 5, up + 33) <> 0
   END IF
  CASE "2"
   IF POINT(over + 7, up + 33) <> 8 THEN
   IF picture$ = "right" THEN PUT (over, up), ninja.r, XOR
   IF picture$ = "left" THEN PUT (over, up), ninja.l, XOR
   IF picture$ = "goingup" THEN PUT (over, up), ninja, XOR
   up = up + 3
   PUT (over, up), ninja
   picture$ = "goingup"
   END IF
 END SELECT
 IF POINT(over + 9, up + 33) = 0 THEN
  fall = 1
  DO
   key$ = INKEY$
   IF picture$ = "right" THEN PUT (over, up), ninja.r, XOR
   IF picture$ = "left" THEN PUT (over, up), ninja.l, XOR
   IF picture$ = "goingup" THEN PUT (over, up), ninja, XOR
   up = up + 1
   fall = fall + 1
   IF key$ = "4" THEN over = over - 4: picture$ = "left"
   IF key$ = "6" THEN over = over + 4: picture$ = "right"
   IF picture$ = "right" THEN PUT (over, up), ninja.r
   IF picture$ = "left" THEN PUT (over, up), ninja.l
   IF picture$ = "goingup" THEN PUT (over, up), ninja
   CurrentTimer! = TIMER
   WHILE TIMER < (CurrentTimer! + .000000000000005# / 100): WEND
   IF fall = 25 THEN GOSUB Fell
  LOOP UNTIL POINT(over + 5, up + 33) <> 0
 END IF
LOOP

'First Level
DATA "                             "
DATA "                             "
DATA "  #           #           #  "
DATA "  #-----------#-----------#  "
DATA "  #           #           #  "
DATA "  #           #           #  "
DATA "  #           #           #  "
DATA "  --T         #         T--  "
DATA "    I         #         I    "
DATA "       #      #      #       "
DATA "  -----#      #      #-----  "
DATA "       #   -------   #       "
DATA "       #             #       "
DATA "       #             #       "
DATA "                             "
DATA "  --T-------  #  -------T--  "
DATA "    I      ---#---      I    "
DATA "    I         #         I    "
DATA "    I         #         I    "
DATA "    I ----    #    ---- I    "
DATA "    I         #         I    "
DATA "              0              "
DATA "          ---------          "
DATA "         --       --         "
DATA "        --         --        "
DATA "---------           ---------"
'Second Level
DATA "-----------------------------"
DATA "  I  I  I  I  I  I  I  I  I  "
DATA "  I  I  I  I  I  I  I  I  I  "
DATA "  I  I  I  I  I  I  I  I  I  "
DATA "  I  I  I  I  I  I  I  I  I  "
DATA "  I  I  I  I  I     I  I  I  "
DATA "  I  I     I  I     I     I  "
DATA "  I  I        I     I     0  "
DATA "  I           I         -----"
DATA "  I           I              "
DATA "  I                          "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "
DATA "                             "

FellOff:
COLOR 15: LOCATE 15, 28
PRINT "You fell off the screen"
DO
LOOP UNTIL INKEY$ = CHR$(13)
SYSTEM

Fell:
CurrentTimer! = TIMER
WHILE TIMER < (CurrentTimer! + .5 / 100): WEND
IF picture$ = "right" THEN PUT (over, up), ninja.r, XOR
IF picture$ = "left" THEN PUT (over, up), ninja.l, XOR
IF picture$ = "goingup" THEN PUT (over, up), ninja, XOR
PUT (over, up + 5), ninja.down
DO
 PUT (over, up + 5), ninja.down, XOR
 up = up + 3
 PUT (over, up + 5), ninja.down
 CurrentTimer! = TIMER
 WHILE TIMER < (CurrentTimer! + .000000005# / 100): WEND
LOOP UNTIL up >= 435
COLOR 15: LOCATE 15, 28
PRINT "You fell down and died."
DO
LOOP UNTIL INKEY$ = CHR$(13)
SYSTEM



