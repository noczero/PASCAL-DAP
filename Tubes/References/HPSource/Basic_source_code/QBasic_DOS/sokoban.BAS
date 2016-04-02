' Sokoban, for FreeBASIC QB mode/Qbasic/QB64
' web: http://rudih.info
DIM sc$(22)

' initial statements
menu:
CLS
COLOR 10, 0
LOCATE 10, 30
PRINT "---SOKOBAN---"
LOCATE 12, 5
PRINT "Arrow keys move - <esc> quits - <R> retry."
LOCATE 13, 5
PRINT "To play, cover the '*' with 'O's."
LOCATE 14, 5
PRINT "<L> load text file as level."
FOR g = 1 TO 22
    sc$(g) = ""
NEXT g
x$ = ""
WHILE x$ = ""
    x$ = INKEY$
WEND
IF x$ = "" THEN END
IF x$ = "l" OR x$ = "L" THEN
    CLS
    INPUT "file"; filen$
    OPEN filen$ FOR INPUT AS #1
    l = 1
    WHILE NOT EOF(1)
        LINE INPUT #1, sc$(l)
        l = l + 1
    WEND
    CLOSE #1
    level = 0
    GOTO lev2:
End If
level = 1

' load level
lev:
FOR g = 1 TO 22
    sc$(g) = ""
NEXT g
lev2:
IF level = 1 THEN
    sc$(1) = ""
    sc$(2) = ""
    sc$(3) = "         88888"
    sc$(4) = "         8   8"
    sc$(5) = "         8O  8"
    sc$(6) = "       888  O88"
    sc$(7) = "       8  O O 8"
    sc$(8) = "     888 8 88 8   888888"
    sc$(9) = "     8   8 88 88888  **8"
    sc$(10) = "     8 O  O          **8"
    sc$(11) = "     88888 888 8X88  **8"
    sc$(12) = "         8     888888888"
    sc$(13) = "         8888888"
END IF
IF level = 2 THEN
    sc$(1) = ""
    sc$(2) = ""
    sc$(3) = ""
    sc$(4) = ""
    sc$(5) = "     8888888888888"
    sc$(6) = "     8**  8      8"
    sc$(7) = "     8**  8 O  O 888"
    sc$(8) = "     8**  8O8888   8"
    sc$(9) = "     8**    X 88   8"
    sc$(10) = "     8**  8 8  O  88"
    sc$(11) = "     888888 88O O  8"
    sc$(12) = "       8 O  O O O  8"
    sc$(13) = "       8    8      8"
    sc$(14) = "       8888888888888"
END IF
IF level = 3 THEN
    sc$(1) = ""
    sc$(2) = ""
    sc$(3) = "         88888888"
    sc$(4) = "         8     X8"
    sc$(5) = "         8 O8O 88"
    sc$(6) = "         8 O  O8"
    sc$(7) = "  888888 88O O 8"
    sc$(8) = "  8**  8 8 O 8 888"
    sc$(9) = "  8**  888 O  O  8"
    sc$(10) = "  8**        O   8"
    sc$(11) = "  8**  88888888888"
    sc$(12) = "  8**  8"
    sc$(13) = "  888888"
END IF
IF level = 4 THEN
    sc$(1) = ""
    sc$(2) = ""
    sc$(3) = ""
    sc$(4) = "    888888"
    sc$(5) = "    8**  8  888"
    sc$(6) = "    8**  8 88X88"
    sc$(7) = "    8**  888   8"
    sc$(8) = "    8**     OO 8"
    sc$(9) = "    8**  8 8 O 8"
    sc$(10) = "    888888 8 O 8"
    sc$(11) = "       8 O 8O  8"
    sc$(12) = "       8  O8 O 8"
    sc$(13) = "       8 O  O  8"
    sc$(14) = "       8  88   8"
    sc$(15) = "       888888888"
END IF
IF level = 5 THEN
    sc$(1) = ""
    sc$(2) = ""
    sc$(3) = ""
    sc$(4) = "      8888888888"
    sc$(5) = "      8**  8   8"
    sc$(6) = "      8**      8"
    sc$(7) = "      8**  8  8888"
    sc$(8) = "     8888888  8  88"
    sc$(9) = "     8            8"
    sc$(10) = "     8  8  88  8  8"
    sc$(11) = "   8888 88  8888 88"
    sc$(12) = "   8  O  88888 8  8"
    sc$(13) = "   8 8 O  O  8 O  8"
    sc$(14) = "   8 XO  O   8   88"
    sc$(15) = "   8888 88 8888888"
    sc$(16) = "      8    8"
    sc$(17) = "      888888"
END IF
FOR g = 1 TO 22
    x = INSTR(sc$(g), "X")
    IF x > 0 THEN
        y = g
        GOTO main:
    END IF
NEXT g


' main loop
main:
found = 0
FOR g = 1 TO 22
    f = INSTR(sc$(g), "*")
    IF f > 0 THEN found = found + 1
NEXT g
IF found = 0 AND aster = 0 THEN
    CLS
    PRINT "level complete..."
    SLEEP
    IF level = 0 THEN GOTO menu:
    level = level + 1
    IF level > 5 THEN GOTO menu:
    GOTO lev:
END IF
CLS
FOR g = 1 TO 22
    PRINT sc$(g)
NEXT g
PRINT "level:"; level
user$ = ""
WHILE user$ = ""
    user$ = INKEY$
WEND
IF MID$(sc$(y), x + 1, 3) = "OO8" OR MID$(sc$(y), x - 3, 3) = "8OO" THEN aster = 0
IF MID$(sc$(y), x + 1, 3) = "O*8" OR MID$(sc$(y), x - 3, 3) = "8*O" THEN aster = 0
IF user$ = "" GOTO menu:
IF user$ = "r" OR user$ = "R" GOTO lev:
' up
IF user$ = CHR$(0) + "H" THEN
    'collision detection
    dest$ = MID$(sc$(y - 1), x, 1)
    IF MID$(sc$(y + 2), x, 1) = "O" THEN aster = 0
    IF dest$ = "8" GOTO main:
    IF dest$ = "O" THEN
        IF MID$(sc$(y - 2), x, 1) = " " OR MID$(sc$(y - 2), x, 1) = "*" THEN
            le$ = LEFT$(sc$(y), x - 1)
            IF aster = 2 THEN
                mi$ = "*"
                aster = 0
            END IF
            IF aster = 1 THEN
                mi$ = "*"
                aster = 2
            ELSE
                mi$ = " "
            END IF
            IF MID$(sc$(y - 2), x, 1) = "*" THEN aster = 1 ELSE aster = 0
            ri$ = MID$(sc$(y), x + 1, 22)
            sc$(y) = le$ + mi$ + ri$
            le$ = LEFT$(sc$(y - 1), x - 1)
            mi$ = "X"
            ri$ = MID$(sc$(y - 1), x + 1)
            sc$(y - 1) = le$ + mi$ + ri$
            le$ = LEFT$(sc$(y - 2), x - 1)
            mi$ = "O"
            ri$ = MID$(sc$(y - 2), x + 1, 22)
            sc$(y - 2) = le$ + mi$ + ri$
        ELSE
            GOTO main:
        END IF
    END IF
    IF dest$ = " " OR dest$ = "*" THEN
        le$ = LEFT$(sc$(y), x - 1)
        IF aster = 1 THEN
            mi$ = "*"
            aster = 0
        ELSE
            mi$ = " "
        END IF
        IF dest$ = "*" THEN aster = 1 ELSE aster = 0
        ri$ = MID$(sc$(y), x + 1, 22)
        sc$(y) = le$ + mi$ + ri$
        le$ = LEFT$(sc$(y - 1), x - 1)
        mi$ = "X"
        ri$ = MID$(sc$(y - 1), x + 1)
        sc$(y - 1) = le$ + mi$ + ri$
    END IF
    y = y - 1
END IF
' down
IF user$ = CHR$(0) + "P" THEN
    'collision detection
    dest$ = MID$(sc$(y + 1), x, 1)
    IF MID$(sc$(y - 2), x, 1) = "O" THEN aster = 0
    IF dest$ = "8" GOTO main:
    IF dest$ = "O" THEN
        IF MID$(sc$(y + 2), x, 1) = " " OR MID$(sc$(y + 2), x, 1) = "*" THEN
            le$ = LEFT$(sc$(y), x - 1)
            IF aster = 2 THEN
                mi$ = "*"
                aster = 0
            END IF
            IF aster = 1 THEN
                mi$ = "*"
                aster = 2
            ELSE
                mi$ = " "
            END IF
            IF MID$(sc$(y + 2), x, 1) = "*" THEN aster = 1 ELSE aster = 0
            ri$ = MID$(sc$(y), x + 1, 22)
            sc$(y) = le$ + mi$ + ri$
            le$ = LEFT$(sc$(y + 1), x - 1)
            mi$ = "X"
            ri$ = MID$(sc$(y + 1), x + 1)
            sc$(y + 1) = le$ + mi$ + ri$
            le$ = LEFT$(sc$(y + 2), x - 1)
            mi$ = "O"
            ri$ = MID$(sc$(y + 2), x + 1, 22)
            sc$(y + 2) = le$ + mi$ + ri$
        ELSE
            GOTO main:
        END IF
    END IF
    IF dest$ = " " OR dest$ = "*" THEN
        le$ = LEFT$(sc$(y), x - 1)
        IF aster = 1 THEN
            mi$ = "*"
            aster = 0
        ELSE
            mi$ = " "
        END IF
        IF dest$ = "*" THEN aster = 1 ELSE aster = 0
        ri$ = MID$(sc$(y), x + 1, 22)
        sc$(y) = le$ + mi$ + ri$
        le$ = LEFT$(sc$(y + 1), x - 1)
        mi$ = "X"
        ri$ = MID$(sc$(y + 1), x + 1)
        sc$(y + 1) = le$ + mi$ + ri$
    END IF
    y = y + 1
END IF
' left
IF user$ = CHR$(0) + "K" THEN
    'collision detection
    dest$ = MID$(sc$(y), x - 1, 1)
    IF MID$(sc$(y), x + 2, 1) = "O" THEN aster = 0
    IF dest$ = "8" GOTO main:
    IF dest$ = "O" THEN
        IF MID$(sc$(y), x - 2, 1) = " " OR MID$(sc$(y), x - 2, 1) = "*" THEN
            le$ = LEFT$(sc$(y), x - 3)
            IF aster = 2 THEN
                mi$ = "OX*"
                aster = 0
            ELSE
                mi$ = "OX "
            END IF
            IF aster = 1 THEN
                mi$ = "OX "
                aster = 2
            ELSE
                mi$ = "OX "
            END IF
            IF MID$(sc$(y), x - 2, 1) = "*" THEN aster = 1 ELSE aster = 0
            ri$ = MID$(sc$(y), x + 1, 22)
            sc$(y) = le$ + mi$ + ri$
        ELSE
            GOTO main:
        END IF
    END IF
    IF dest$ = " " OR dest$ = "*" THEN
        le$ = LEFT$(sc$(y), x - 2)
        IF aster = 1 THEN
            mi$ = "X*"
            aster = 0
        ELSE
            mi$ = "X "
            aster = 0
        END IF
        IF dest$ = "*" THEN aster = 1 ELSE aster = 0
        ri$ = MID$(sc$(y), x + 1, 22)
        sc$(y) = le$ + mi$ + ri$
    END IF
    x = x - 1
END IF
' right
IF user$ = CHR$(0) + "M" THEN
    'collision detection
    dest$ = MID$(sc$(y), x + 1, 1)
    IF MID$(sc$(y), x - 2, 1) = "O" THEN aster = 0
    IF dest$ = "8" GOTO main:
    IF dest$ = "O" THEN
        IF MID$(sc$(y), x + 2, 1) = " " OR MID$(sc$(y), x + 2, 1) = "*" THEN
            le$ = LEFT$(sc$(y), x - 1)
            IF aster = 2 THEN
                mi$ = "*XO"
                aster = 0
            ELSE
                mi$ = " XO"
            END IF
            IF aster = 1 THEN
                mi$ = " XO"
                aster = 2
            ELSE
                mi$ = " XO"
            END IF
            IF MID$(sc$(y), x + 2, 1) = "*" THEN aster = 1 ELSE aster = 0
            ri$ = MID$(sc$(y), x + 3, 22)
            sc$(y) = le$ + mi$ + ri$
        ELSE
            GOTO main:
        END IF
    END IF
    IF dest$ = " " OR dest$ = "*" THEN
        le$ = LEFT$(sc$(y), x - 1)
        IF aster = 1 THEN
            mi$ = "*X"
            aster = 0
        ELSE
            mi$ = " X"
            aster = 0
        END IF
        IF dest$ = "*" THEN aster = 1 ELSE aster = 0
        ri$ = MID$(sc$(y), x + 2, 22)
        sc$(y) = le$ + mi$ + ri$
    END IF
    x = x + 1
END IF

GOTO main:
