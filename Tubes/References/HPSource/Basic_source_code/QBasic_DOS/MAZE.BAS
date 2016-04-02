' Maze game, for BASIC, http://rudih.info
' -use Ezedit draw mode as a level editor

DIM lin$(100)
DIM sc$(26)

' initial statements
menu:
CLS
COLOR 10, 0
LOCATE 10, 30
PRINT "---MAZE GAME---"
LOCATE 12, 5
PRINT "arrow keys move - <esc> quits - <L>oad level from 'level.txt'"
COLOR 3, 0
x$ = ""
WHILE x$ = ""
  x$ = INKEY$
WEND
IF x$ = "" THEN END
x = 37
y = 13
xmap = 1
ymap = 1
If x$="L" Or x$="l" then
 OPEN "level.txt" FOR INPUT AS #1
 FOR a = 1 TO 100
  IF NOT EOF(1) THEN LINE INPUT #1, lin$(a)
 NEXT a
 Close 1
 level=99
 GoTo main:
EndIf
level=1
lev:
x = 37
y = 13
xmap = 1
ymap = 1
If level=1 Then
 lin$(1) = "ЩЛЩЛЩЭЛ"
 lin$(2) = "КШМШЮЭЙ"
 lin$(3) = "ШЭЭЭМ М"
END If
If level=2 Then
 lin$(1) = "ЩЛ ЩЛЩЛ ЩЭЛ"
 lin$(2) = "ШЙЩМШЮЮЭМ К"
 lin$(3) = " ШМЩЛШМ ЩЫМ"
 lin$(4) = " ЭЭЪЪЭЭЭЪМ"
END If
If level=3 Then
 lin$(1) = "ЩЫЭЛ ЩЛ ЩЭЛ"
 lin$(2) = "ШЮЛШЫЪЙ ШЛЬЛ"
 lin$(3) = "ЩМШЛШЛЬЭЭЙШЮЛ"
 lin$(4) = "ШЭЭМ ШМ ЭЪЭЪМ"
END If
' main loop
main:
GOSUB load:

nav:
LOCATE y, x
COLOR 14, 0
PRINT ""
COLOR 3, 0
user$ = ""
WHILE user$ = ""
  user$ = INKEY$
WEND
IF user$ = "" GOTO menu:
' up
IF user$ = CHR$(0) + "H" THEN
	'colision detection
	dest$ = MID$(sc$(y - 1), x, 1)
	IF dest$ = "л" GOTO nav:
	
	LOCATE y, x
	PRINT " "
	y = y - 1
END IF
' down
IF user$ = CHR$(0) + "P" THEN
		'colision detection
	dest$ = MID$(sc$(y + 1), x, 1)
	IF dest$ = "л" GOTO nav:
	
	LOCATE y, x
	PRINT " "
	y = y + 1
END IF
' left
IF user$ = CHR$(0) + "K" THEN
		'colision detection
	dest$ = MID$(sc$(y), x - 1, 1)
	IF dest$ = "л" GOTO nav:
	
	LOCATE y, x
	PRINT " "
	x = x - 1
END IF
' right
IF user$ = CHR$(0) + "M" THEN
		'colision detection
	dest$ = MID$(sc$(y), x + 1, 1)
	IF dest$ = "л" GOTO nav:
	
	LOCATE y, x
	PRINT " "
	x = x + 1
END IF
IF x > 75 THEN
	x = 5
	xmap = xmap + 1
	GOTO main:
END IF
IF x < 5 THEN
	x = 75
	xmap = xmap - 1
	GOTO main:
END IF
IF y > 21 THEN
	y = 2
	ymap = ymap + 1
	GOTO main:
END IF
IF y < 3 THEN
	y = 21
	ymap = ymap - 1
	GOTO main:
END IF
GOTO nav:

' load the screen data
load:
x$ = MID$(lin$(ymap), xmap, 1)
CLS
IF x$ = " " THEN
 LOCATE 10, 10
 PRINT "You have found the end of the maze! Press space..."
 x$ = ""
 WHILE x$ <> " "
    x$ = INKEY$
 Wend
 If level=99 Or level=3 Then GoTo menu:
 Cls
 Locate 10,10
 Print "...on to level: ";level+1
 Sleep
 level=level+1
 GoTo lev:
END IF
length = 24
IF x$ = "Ю" THEN
  sc$(1) = "                                 л       л"
  sc$(2) = "                                 л       л"
  sc$(3) = "                                 л       л"
  sc$(4) = "                                 л       л"
  sc$(5) = "                                 л       л"
  sc$(6) = "                                 л       л"
  sc$(7) = "                                 л       л"
  sc$(8) = "                                 л       л"
  sc$(9) = "                                 л       л"
  sc$(10) = "лллллллллллллллллллллллллллллллллл       ллллллллллллллллллллллллллллллллллллл"
  sc$(11) = ""
  sc$(12) = ""
  sc$(13) = ""
  sc$(14) = ""
  sc$(15) = "лллллллллллллллллллллллллллллллллл       ллллллллллллллллллллллллллллллллллллл"
  sc$(16) = "                                 л       л"
  sc$(17) = "                                 л       л"
  sc$(18) = "                                 л       л"
  sc$(19) = "                                 л       л"
  sc$(20) = "                                 л       л"
  sc$(21) = "                                 л       л"
  sc$(22) = "                                 л       л"
  sc$(23) = "                                 л       л"
  sc$(24) = "                                 л       л"
END IF
IF x$ = "Э" THEN
  sc$(1) = ""
  sc$(2) = ""
  sc$(3) = ""
  sc$(4) = ""
  sc$(5) = ""
  sc$(6) = ""
  sc$(7) = ""
  sc$(8) = ""
  sc$(9) = ""
  sc$(10) = "лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл"
  sc$(11) = ""
  sc$(12) = ""
  sc$(13) = ""
  sc$(14) = ""
  sc$(15) = "лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл"
  length = 15
END IF
IF x$ = "Ь" THEN
  sc$(1) = "                                 л       л"
  sc$(2) = "                                 л       л"
  sc$(3) = "                                 л       л"
  sc$(4) = "                                 л       л"
  sc$(5) = "                                 л       л"
  sc$(6) = "                                 л       л"
  sc$(7) = "                                 л       л"
  sc$(8) = "                                 л       л"
  sc$(9) = "                                 л       л"
  sc$(10) = "                                 л       ллллллллллллллллллллллллллллллллллл"
  sc$(11) = "                                 л"
  sc$(12) = "                                 л"
  sc$(13) = "                                 л"
  sc$(14) = "                                 л"
  sc$(15) = "                                 л       ллллллллллллллллллллллллллллллллллл"
  sc$(16) = "                                 л       л"
  sc$(17) = "                                 л       л"
  sc$(18) = "                                 л       л"
  sc$(19) = "                                 л       л"
  sc$(20) = "                                 л       л"
  sc$(21) = "                                 л       л"
  sc$(22) = "                                 л       л"
  sc$(23) = "                                 л       л"
  sc$(24) = "                                 л       л"
END IF
IF x$ = "Ы" THEN
  sc$(1) = ""
  sc$(2) = ""
  sc$(3) = ""
  sc$(4) = ""
  sc$(5) = ""
  sc$(6) = ""
  sc$(7) = ""
  sc$(8) = ""
  sc$(9) = ""
  sc$(10) = "лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл"
  sc$(11) = ""
  sc$(12) = ""
  sc$(13) = ""
  sc$(14) = ""
  sc$(15) = "лллллллллллллллллллллллллллллллллл       ллллллллллллллллллллллллллллллллллллл"
  sc$(16) = "                                 л       л"
  sc$(17) = "                                 л       л"
  sc$(18) = "                                 л       л"
  sc$(19) = "                                 л       л"
  sc$(20) = "                                 л       л"
  sc$(21) = "                                 л       л"
  sc$(22) = "                                 л       л"
  sc$(23) = "                                 л       л"
  sc$(24) = "                                 л       л"
END IF
IF x$ = "Ъ" THEN
  sc$(1) = "                                 л       л"
  sc$(2) = "                                 л       л"
  sc$(3) = "                                 л       л"
  sc$(4) = "                                 л       л"
  sc$(5) = "                                 л       л"
  sc$(6) = "                                 л       л"
  sc$(7) = "                                 л       л"
  sc$(8) = "                                 л       л"
  sc$(9) = "                                 л       л"
  sc$(10) = "лллллллллллллллллллллллллллллллллл       ллллллллллллллллллллллллллллллллллллл"
  sc$(11) = ""
  sc$(12) = ""
  sc$(13) = ""
  sc$(14) = ""
  sc$(15) = "лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл"
  length = 15
END IF
IF x$ = "Щ" THEN
  sc$(1) = ""
  sc$(2) = ""
  sc$(3) = ""
  sc$(4) = ""
  sc$(5) = ""
  sc$(6) = ""
  sc$(7) = ""
  sc$(8) = ""
  sc$(9) = ""
  sc$(10) = "                                 ллллллллллллллллллллллллллллллллллллллллллллл"
  sc$(11) = "                                 л"
  sc$(12) = "                                 л"
  sc$(13) = "                                 л"
  sc$(14) = "                                 л"
  sc$(15) = "                                 л       ллллллллллллллллллллллллллллллллллллл"
  sc$(16) = "                                 л       л"
  sc$(17) = "                                 л       л"
  sc$(18) = "                                 л       л"
  sc$(19) = "                                 л       л"
  sc$(20) = "                                 л       л"
  sc$(21) = "                                 л       л"
  sc$(22) = "                                 л       л"
  sc$(23) = "                                 л       л"
  sc$(24) = "                                 л       л"
END IF
IF x$ = "Ш" THEN
  sc$(1) = "                                 л       л"
  sc$(2) = "                                 л       л"
  sc$(3) = "                                 л       л"
  sc$(4) = "                                 л       л"
  sc$(5) = "                                 л       л"
  sc$(6) = "                                 л       л"
  sc$(7) = "                                 л       л"
  sc$(8) = "                                 л       л"
  sc$(9) = "                                 л       л"
  sc$(10) = "                                 л       ллллллллллллллллллллллллллллллллллллл"
  sc$(11) = "                                 л"
  sc$(12) = "                                 л"
  sc$(13) = "                                 л"
  sc$(14) = "                                 л"
  sc$(15) = "                                 ллллллллллллллллллллллллллллллллллллллллллллл"
  length = 15
END IF
IF x$ = "М" THEN
  sc$(1) = "                                 л       л"
  sc$(2) = "                                 л       л"
  sc$(3) = "                                 л       л"
  sc$(4) = "                                 л       л"
  sc$(5) = "                                 л       л"
  sc$(6) = "                                 л       л"
  sc$(7) = "                                 л       л"
  sc$(8) = "                                 л       л"
  sc$(9) = "                                 л       л"
  sc$(10) = "лллллллллллллллллллллллллллллллллл       л"
  sc$(11) = "                                         л"
  sc$(12) = "                                         л"
  sc$(13) = "                                         л"
  sc$(14) = "                                         л"
  sc$(15) = "лллллллллллллллллллллллллллллллллллллллллл"
  length = 15
END IF

IF x$ = "Л" THEN
  sc$(1) = ""
  sc$(2) = ""
  sc$(3) = ""
  sc$(4) = ""
  sc$(5) = ""
  sc$(6) = ""
  sc$(7) = ""
  sc$(8) = ""
  sc$(9) = ""
  sc$(10) = "лллллллллллллллллллллллллллллллллллллллллл"
  sc$(11) = "                                         л"
  sc$(12) = "                                         л"
  sc$(13) = "                                         л"
  sc$(14) = "                                         л"
  sc$(15) = "лллллллллллллллллллллллллллллллллл       л"
  sc$(16) = "                                 л       л"
  sc$(17) = "                                 л       л"
  sc$(18) = "                                 л       л"
  sc$(19) = "                                 л       л"
  sc$(20) = "                                 л       л"
  sc$(21) = "                                 л       л"
  sc$(22) = "                                 л       л"
  sc$(23) = "                                 л       л"
  sc$(24) = "                                 л       л"
END IF
IF x$ = "К" THEN
  sc$(1) = "                                 л       л"
  sc$(2) = "                                 л       л"
  sc$(3) = "                                 л       л"
  sc$(4) = "                                 л       л"
  sc$(5) = "                                 л       л"
  sc$(6) = "                                 л       л"
  sc$(7) = "                                 л       л"
  sc$(8) = "                                 л       л"
  sc$(9) = "                                 л       л"
  sc$(10) = "                                 л       л"
  sc$(11) = "                                 л       л"
  sc$(12) = "                                 л       л"
  sc$(13) = "                                 л       л"
  sc$(14) = "                                 л       л"
  sc$(15) = "                                 л       л"
  sc$(16) = "                                 л       л"
  sc$(17) = "                                 л       л"
  sc$(18) = "                                 л       л"
  sc$(19) = "                                 л       л"
  sc$(20) = "                                 л       л"
  sc$(21) = "                                 л       л"
  sc$(22) = "                                 л       л"
  sc$(23) = "                                 л       л"
  sc$(24) = "                                 л       л"
END IF
IF x$ = "Й" THEN
  sc$(1) = "                                 л       л"
  sc$(2) = "                                 л       л"
  sc$(3) = "                                 л       л"
  sc$(4) = "                                 л       л"
  sc$(5) = "                                 л       л"
  sc$(6) = "                                 л       л"
  sc$(7) = "                                 л       л"
  sc$(8) = "                                 л       л"
  sc$(9) = "                                 л       л"
  sc$(10) = "лллллллллллллллллллллллллллллллллл       л"
  sc$(11) = "                                         л"
  sc$(12) = "                                         л"
  sc$(13) = "                                         л"
  sc$(14) = "                                         л"
  sc$(15) = "лллллллллллллллллллллллллллллллллл       л"
  sc$(16) = "                                 л       л"
  sc$(17) = "                                 л       л"
  sc$(18) = "                                 л       л"
  sc$(19) = "                                 л       л"
  sc$(20) = "                                 л       л"
  sc$(21) = "                                 л       л"
  sc$(22) = "                                 л       л"
  sc$(23) = "                                 л       л"
  sc$(24) = "                                 л       л"
END If
FOR c = 1 TO length
	PRINT sc$(c)
Next
Return


