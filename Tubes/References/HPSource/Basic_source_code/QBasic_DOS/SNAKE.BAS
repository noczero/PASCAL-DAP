REM Snake Game, for BASIC, web: http://rudih.info
DIM x(500) AS INTEGER
DIM y(500) AS INTEGER
oldhi = 0

blank:
COLOR 14, 0
CLS
LOCATE 8, 35
PRINT "---SNAKE---"
LOCATE 10, 10
PRINT "In game, use arrow keys to move."
LOCATE 11, 10
PRINT "Press <1-3> for speeds, or <Esc> to quit."
IF score > oldhi THEN oldhi = score
LOCATE 12, 10
PRINT "Hi score: "; oldhi
user$ = ""
WHILE user$ = ""
    user$ = INKEY$
WEND
IF user$ = "" THEN END
delay! = .14
IF user$ = "1" THEN delay! = .26
IF user$ = "3" THEN delay! = .08
CLS
FOR count = 1 TO 500
    x(count) = 0
    y(count) = 0
NEXT count
length = 9
score = 0
posx = 40
posy = 10
dir$ = "right"
alive = 1
RANDOMIZE TIMER
fruitx = INT(RND * 79) + 1
fruity = INT(RND * 20) + 1
LOCATE 22, 1
FOR count = 1 TO 80
    PRINT "-";
NEXT count

main:
Locate 23, 2
PRINT "SNAKE - <Esc> quits - Score: "; score
IF posx = fruitx AND posy = fruity THEN
    length = length + 1
    score = score + 1
    fruitx = INT(RND * 79) + 1
    fruity = INT(RND * 21) + 1
END IF
LOCATE fruity, fruitx
PRINT "*"
x(0) = posx
y(0) = posy

FOR count = 1 TO 499
    num = 500 - count
    x(num) = x(num - 1)
    y(num) = y(num - 1)
NEXT count

oldx = x(length)
oldy = y(length)
IF oldx > 0 AND oldy > 0 THEN
    LOCATE oldy, oldx
    PRINT " "
END IF

LOCATE posy, posx
PRINT "Û"
tm! = TIMER
tm2! = tm! + delay!
WHILE tm! < tm2!
    tm! = TIMER
    user$ = INKEY$
    IF user$ = CHR$(0) + "H" THEN dir$ = "up"
    IF user$ = CHR$(0) + "P" THEN dir$ = "down"
    IF user$ = CHR$(0) + "K" THEN dir$ = "left"
    IF user$ = CHR$(0) + "M" THEN dir$ = "right"
    IF user$ = "" THEN GOTO blank:
WEND
IF dir$ = "right" THEN posx = posx + 1
IF posx > 80 THEN alive = 0
IF dir$ = "left" THEN posx = posx - 1
IF posx < 1 THEN alive = 0
IF dir$ = "up" THEN posy = posy - 1
IF posy < 1 THEN alive = 0
IF dir$ = "down" THEN posy = posy + 1
IF posy > 21 THEN alive = 0

FOR count = 0 TO length
    IF posx = x(count) AND posy = y(count) THEN alive = 0
NEXT count

IF alive = 0 THEN
    CLS
    LOCATE 10, 18
    PRINT "You died! Score: "; score; " press <space>..."
    user$ = ""
    WHILE user$ <> " "
        user$ = INKEY$
    WEND
    CLS
    GOTO blank:
END IF

GOTO main:

