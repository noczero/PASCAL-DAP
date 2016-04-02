' Squash, for FreeBasic(QB console), web: http://rudih.info
DIM rate(23)
DIM length(23) AS SINGLE
RANDOMIZE TIMER

title:
IF score > hiscore THEN hiscore = score
CLS
COLOR 14, 0
LOCATE 8, 32
PRINT "---SQUASH---"
LOCATE 10, 10
PRINT "Use arrow keys to move, space to shoot, & <Esc> to exit."
LOCATE 12, 10
PRINT "difficulty <1>,<2>,&<3>."
LOCATE 13, 10
PRINT "Hiscore: ", hiscore
x$ = ""
WHILE x$ = ""
    x$ = INKEY$
WEND
IF x$ = "" THEN END
speed! = 0.3
ratem! = 0.4
IF x$ = "3" THEN
    speed! = 0.1
    ratem! = 0.5
END IF
IF x$ = "1" THEN
    speed! = 0.6
    ratem! = 0.3
END IF
playery = 12
score = 0
FOR c = 1 TO 23
    length(c) = INT(RND * 10) + 1
    rate(c) = (RND * ratem!)
NEXT c


main:

' growing
FOR c = 1 TO 23
    IF length(c) > 78 THEN
        CLS
        LOCATE 10, 15
        COLOR 14, 0
        PRINT "Game over. Score="; score; " Press space..."
        x$ = ""
        WHILE x$ <> " "
            x$ = INKEY$
        WEND
        GOTO title:
    END IF
    length(c) = length(c) + rate(c)
NEXT c

CLS
FOR c = 1 TO 23
    lnint = INT(length(c))
    PRINT SPACE$(79 - lnint);
    COLOR 9, 0
    IF c = playery THEN COLOR 1, 0
    FOR b = 1 TO lnint
        PRINT "Û";
    NEXT b
    PRINT ""
NEXT c
COLOR 14, 0
LOCATE 24, 1
PRINT "score: "; score



delay! = TIMER + speed!
curr! = TIMER
Locate playery , 1
Print ""
WHILE curr! < delay!
    curr! = TIMER
    x$ = INKEY$
    IF x$ = "" THEN
        CLS
        LOCATE 10, 15
        COLOR 14, 0
        PRINT "Game over. Score="; score; " Press space..."
        x$ = ""
        WHILE x$ <> " "
            x$ = INKEY$
        WEND
        GOTO title:
    END IF
    IF x$ = CHR$(0) + "H" AND playery > 1 THEN
        LOCATE playery, 1
        PRINT " "
        playery = playery - 1
        GOTO main:
    END IF
    IF x$ = CHR$(0) + "P" AND playery < 23 THEN
        LOCATE playery, 1
        PRINT " "
        playery = playery + 1
        GOTO main:
    END IF
    IF x$ = " " AND length(playery) > 8 THEN
        score = score + 1
        length(playery) = length(playery) - 7
        GOTO main:
    END IF
WEND


GOTO main:
