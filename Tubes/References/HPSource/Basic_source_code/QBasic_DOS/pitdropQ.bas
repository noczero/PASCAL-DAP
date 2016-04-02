' Pit Drop, for QBasic/QB64, web: http://rudih.info
DIM mem(16) AS INTEGER
DIM score AS LONG
RANDOMIZE TIMER
hiscore = 0

title:
IF score > hiscore THEN hiscore = score
CLS
COLOR 14, 0
LOCATE 8, 30
PRINT "---PIT DROP---"
LOCATE 10, 15
PRINT "Use arrow keys to move, & <Esc> to exit."
LOCATE 12, 15
PRINT "Speed <1>,<2>,&<3>."
LOCATE 13, 15
PRINT "Hiscore: ", hiscore
x$ = ""
WHILE x$ = ""
    x$ = INKEY$
WEND
speed! = 0.07
IF x$ = "1" THEN speed! = 0.15
IF x$ = "3" THEN speed! = 0.02
IF x$ = "" THEN END
CLS
playerx = 40
y = 1
x = 33
score = 0
COLOR 11, 0
FOR y = 1 TO 24
    LOCATE y, x
    PRINT "Û           Û"
NEXT y
FOR c = 1 TO 16
    mem(c) = 33
NEXT c

main:
vb = INT(RND * 3) + 1
IF vb = 1 AND x > 1 THEN x = x - 1
IF vb = 3 AND x < 59 THEN x = x + 1
mem(1) = x
delay! = TIMER + speed!
curr! = TIMER
WHILE curr! < delay!
    curr! = TIMER
    x$ = INKEY$
    IF x$ = CHR$(0) + "K" THEN playerx = playerx - 1
    IF x$ = CHR$(0) + "M" THEN playerx = playerx + 1
    IF x$ = "" THEN GOTO title:
WEND


IF playerx <= mem(12) OR playerx > 11 + (mem(12)) THEN
    x$ = ""
    WHILE x$ = ""
        x$ = INKEY$
    WEND
    GOTO title:
END IF

FOR c = 1 TO 11
    mem(13 - c) = mem(12 - c)
NEXT c

LOCATE 12, playerx
COLOR 14, 0
PRINT ""
COLOR 11, 0
LOCATE 24, x
PRINT "Û           Û"
LOCATE 1, 2
COLOR 14, 0
PRINT "Score:", score
score = score + 1
GOTO main:
