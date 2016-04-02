DECLARE SUB PlayGame ()
DECLARE SUB Intro ()
CLS
SCREEN 13
COLOR 15
DIM SHARED a$(20), letloc(20), b$(20)
CALL Intro
CALL PlayGame

SUB Intro
COLOR 15
LOCATE 15, 14
PRINT "Dynamo Software"
SLEEP 1
FOR i = 30 TO 16 STEP -1
COLOR i
LOCATE 15, 14
PRINT "Dynamo Software"
start = TIMER: WHILE TIMER < (start + .05): WEND
NEXT i
COLOR 15
LOCATE 15, 14
PRINT "In Ascotiation"
LOCATE 16, 14
PRINT "     with"
SLEEP 1
FOR i = 30 TO 16 STEP -1
COLOR i
LOCATE 15, 14
PRINT "In Ascotiation"
LOCATE 16, 14
PRINT "     with     "
start = TIMER: WHILE TIMER < (start + .05): WEND
NEXT i
COLOR 15
LOCATE 15, 14
PRINT "The Awful Waffles"
SLEEP 1
FOR i = 30 TO 16 STEP -1
COLOR i
LOCATE 15, 14
PRINT "The Awful Waffles"
LOCATE 16, 14
COLOR 15
LOCATE 15, 17
PRINT "Presents"
start = TIMER: WHILE TIMER < (start + .05): WEND
NEXT i
CLS
COLOR 15
COLOR 15
LOCATE 17, 13
PRINT "Wheel of Fortune"
SLEEP 3
CLS
END SUB

SUB PlayGame
SCREEN 12
WIDTH 80, 60
COLOR 15
LOCATE 30, 37
INPUT "Name: ", Name$
RANDOMIZE TIMER
x = INT(RND * 12) + 1
ccv = 2
cv = 2
a$(1) = " BELOW SEA LEVEL ": b$(1) = "Place"
a$(2) = " RUMPUS ROOM ": b$(2) = "Place"
a$(3) = " DREAM HOUSE ": b$(3) = "Place"
a$(4) = " ELVIS PRESLEY MEMORABILIA ": b$(4) = "Thing"
a$(5) = " JAMES BOND MOVIES ": b$(5) = "Thing"
a$(6) = " ICE CREAM FACTORY ": b$(6) = "Place"
a$(7) = " PHOTOS IN THE FAMILY ALBUM ": b$(7) = "Thing"
a$(8) = " AN OLD FAMILY RECIPE ": b$(8) = "Thing"
a$(9) = " COLORING BOOK AND CRAYONS ": b$(9) = "Thing"
a$(10) = " BOY SCOUT MERIT BADGE ": b$(10) = "Thing"
a$(11) = " GOLF BAG ": b$(11) = "Thing"
a$(12) = " FAMILY PORTRAIT ": b$(12) = "Thing"
LOCATE 5, 37
PRINT b$(x)
LOCATE 12, 1
COLOR 11
PRINT STRING$(240, CHR$(219))
COLOR 15
LOCATE 13, 5
dsf$ = SPACE$(LEN(a$(x)))
cdsf$ = SPACE$(LEN(a$(x)))
FOR i = 1 TO LEN(a$(x))
IF MID$(a$(x), i, 1) <> " " THEN PRINT CHR$(219);
IF MID$(a$(x), i, 1) = " " THEN PRINT " ";
NEXT i
DO
LOCATE 40, 1
PRINT "         1) Spin"
PRINT "         2) Quit"
PRINT "         3) Solve"
DO: ans$ = INKEY$
IF ans$ = "2" THEN END
IF ans$ = "1" THEN EXIT DO
IF ans$ = "3" THEN
LOCATE 20, 1
INPUT "Solve: ", attempt$
IF UCASE$(attempt$) = LTRIM$(RTRIM$(a$(x))) THEN GOTO there
IF attempt$ <> a$(x) THEN PRINT "You Lose!!": END
END IF
LOOP
Sp = INT(RND * 10) + 1
Sp = Sp * 100
LOCATE 40, 1
PRINT "                         "
PRINT "                         "
LOCATE 10, 5
PRINT "Money:"; Money
LOCATE 30, 35
PRINT "Your Spin:"; Sp
LOCATE 35, 33
PRINT "Choose Letter: "
DO: ans$ = INKEY$
SELECT CASE ans$
CASE CHR$(65) TO CHR$(90)
let$ = ans$
EXIT DO
CASE CHR$(97) TO CHR$(122)
let$ = ans$
EXIT DO
END SELECT
LOOP
LOCATE 35, 49
PRINT UCASE$(let$)
xc = 1
FOR i = 1 TO 10
IF INSTR(xc + 1, a$(x), UCASE$(let$)) = 0 THEN EXIT FOR
IF INSTR(xc + 1, a$(x), UCASE$(let$)) > 0 THEN
zx = zx + 1
xc = INSTR(xc, a$(x), UCASE$(let$)) + 1
LOCATE 13, 5 + xc - 2
PRINT UCASE$(let$)
cv = cv + 1
END IF
Money = Money + Sp
MID$(dsf$, xc, 1) = let$
NEXT i

CSp = INT(RND * 10) + 1
CSp = CSp * 100
LOCATE 31, 35
PRINT "Computer's Spin:"; CSp
LOCATE 11, 5
PRINT "Computer's Money: ", CMoney
gh = INT(RND * 26) + 1
gh = gh + 64
LOCATE 40, 40
PRINT "Computer's Choice: "; x; CHR$(gh)
FOR i = 1 TO 10
IF INSTR(xc + 1, a$(x), CHR$(gh)) = 0 THEN EXIT FOR
IF INSTR(xc + 1, a$(x), CHR$(gh)) > 0 THEN
zx = zx + 1
xc = INSTR(xc, a$(x), CHR$(gh)) + 1
LOCATE 13, 5 + xc - 2
PRINT UCASE$(CHR$(gh))
ccv = ccv + 1
END IF
CMoney = CMoney + CSp
MID$(cdsf$, xc, 1) = CHR$(gh)
NEXT i
IF UCASE$(RTRIM$(LTRIM$(dsf$))) = RTRIM$(LTRIM$(a$(x))) THEN
COLOR 14
LOCATE 58, 30
PRINT "You Win!!"
END
END IF
IF UCASE$(RTRIM$(LTRIM$(cdsf$))) = RTRIM$(LTRIM$(a$(x))) THEN
COLOR 14
LOCATE 58, 30
PRINT "The Computer Wins!!"
END
END IF

LOOP
there:
END
END SUB

