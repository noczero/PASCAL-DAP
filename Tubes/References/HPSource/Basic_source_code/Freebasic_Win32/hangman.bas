' Hangman, for Basic, http://rudih.info
DIM words$(200)
DIM pic$(6)
words$(1) = "red"
words$(2) = "yellow"
words$(3) = "blue"
words$(4) = "morning"
words$(5) = "circle"
words$(6) = "square"
words$(7) = "triangle"
words$(8) = "heart"
words$(9) = "orange"
words$(10) = "banana"
words$(11) = "moon"
words$(12) = "sun"
words$(13) = "fast"
words$(14) = "slow"
words$(15) = "hair"
words$(16) = "leaf"
words$(17) = "sand"
words$(18) = "reason"
words$(19) = "thought"
words$(20) = "logic"
RANDOMIZE TIMER
l = 20
New:
pic$(1) = ""
pic$(2) = "|"
pic$(3) = "|"
pic$(4) = "|"
pic$(5) = "|"
pic$(6) = "|____"
a = INT(RND * (l)) + 1
word$ = words$(a)
word$ = UCASE$(word$)
leng = LEN(word$)
att = 1
usercomb$ = ""
disp$ = ""
olddisp$ = ""
FOR a = 1 TO leng
  disp$ = disp$ + "-"
NEXT a

main:
IF olddisp$ = disp$ THEN
	att = att + 1
	IF att = 2 THEN pic$(1) = " __"
   IF att = 3 THEN pic$(2) = pic$(2) + "  |"
   IF att = 4 THEN pic$(3) = pic$(3) + "  O"
   IF att = 5 THEN pic$(4) = pic$(4) + " -"
   IF att = 6 THEN pic$(4) = pic$(4) + "|"
   IF att = 7 THEN pic$(4) = pic$(4) + "-"
   IF att = 8 THEN pic$(5) = pic$(5) + " /"
   IF att = 9 THEN pic$(5) = pic$(5) + " \"
END IF
CLS
PRINT disp$
PRINT "used: "; usercomb$
FOR a = 1 TO 6
	PRINT pic$(a)
NEXT
IF att = 9 THEN
	PRINT "You lose! It was: "; word$
	PRINT "Press space..."
	a$ = ""
	WHILE a$ <> " "
		a$ = INKEY$
	WEND
	GOTO New:
END IF
PRINT "<F1> load word list."
PRINT "Press a letter. <Esc> quits."
user$ = ""
WHILE user$ = ""
	user$ = INKEY$
WEND
IF user$ = "" THEN END
IF user$ = CHR$(0) + ";" THEN
	 INPUT "file"; filen$
    OPEN filen$ FOR INPUT AS #1
    l = 0
    WHILE NOT EOF(1) AND l < 199
	  l = l + 1
	LINE INPUT #1, words$(l)
    WEND
    CLOSE #1
    GOTO New:
END IF
user$ = UCASE$(user$)
usercomb$ = usercomb$ + user$
olddisp$ = disp$
disp$ = ""
FOR a = 1 TO leng
	x$ = MID$(word$, a, 1)
	FOR b = 1 TO LEN(usercomb$)
		y$ = MID$(usercomb$, b, 1)
		IF x$ = y$ THEN
			disp$ = disp$ + x$
			b = 99:
		END IF
	NEXT
   IF x$ <> y$ THEN disp$ = disp$ + "-"
NEXT a
IF word$ = disp$ THEN
	PRINT word$
	PRINT "You got it! Press space..."
	a$ = ""
	WHILE a$ <> " "
		a$ = INKEY$
	WEND
	GOTO New:
END IF
GOTO main:

