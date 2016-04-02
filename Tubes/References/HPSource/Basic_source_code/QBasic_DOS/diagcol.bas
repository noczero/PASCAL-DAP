' Diagcol, for QBasic/FreeBasic(QB console), web: http://rudih.info

spacebar = 0
RANDOMIZE TIMER
begin:
CLS
COLOR 14, 0
PRINT "spacebar mode: ";
IF spacebar = 1 THEN PRINT "on"
IF spacebar = 0 THEN PRINT "off"
PRINT ""
PRINT "speed 1-3: ";
x$ = ""
WHILE x$ = ""
    x$ = INKEY$
WEND
IF x$ = " " AND spacebar = 1 THEN
    spacebar = 0
    GOTO begin:
END IF
IF x$ = " " AND spacebar = 0 THEN spacebar = 1
IF x$ = " " THEN GOTO begin:
speed = VAL(x$)
IF speed = 3 THEN usdel! = 0.005
IF speed = 2 THEN usdel! = 0.02
IF speed = 1 THEN usdel! = 0.1
IF speed > 3 THEN END
IF speed < 1 THEN END

reload:
CLS
rep = 0
dirt$ = "LD"
x = INT(RND * 77) + 1
y = INT(RND * 22) + 1

main:
delay! = TIMER + usdel!
curr! = TIMER
WHILE curr! < delay!
    curr! = TIMER
    x$ = INKEY$
    IF x$ = " " AND spacebar = 1 THEN
        IF col > 16 THEN col = 0
        col = col + 1
        GOTO main:
    END IF
    IF x$ = "" THEN GOTO begin:
WEND
rep = rep + 1


IF dirt$ = "LD" THEN
    y = y + 1
    x = x - 1
END IF
IF dirt$ = "LU" THEN
    y = y - 1
    x = x - 1
END IF
IF dirt$ = "RD" THEN
    y = y + 1
    x = x + 1
END IF
IF dirt$ = "RU" THEN
    y = y - 1
    x = x + 1
END IF
IF x < 2 THEN
    IF dirt$ = "LD" THEN dirt$ = "RD"
    IF dirt$ = "LU" THEN dirt$ = "RU"
END IF
IF x > 78 THEN
    IF dirt$ = "RD" THEN dirt$ = "LD"
    IF dirt$ = "RU" THEN dirt$ = "LU"
END IF
IF y < 2 THEN
    IF dirt$ = "RU" THEN dirt$ = "RD"
    IF dirt$ = "LU" THEN dirt$ = "LD"
END IF
IF y > 22 THEN
    IF dirt$ = "RD" THEN dirt$ = "RU"
    IF dirt$ = "LD" THEN dirt$ = "LU"
END IF

IF spacebar = 0 THEN
    IF col > 16 THEN col = 1
    col = col + 1
END IF
LOCATE y, x
COLOR col
PRINT "Û"
IF rep > 400 THEN GOTO reload:

GOTO main:
