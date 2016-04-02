' Word Scramble, for BASIC, web: http://rudih.info
CLS
DIM y(30)
PRINT "2 player word guessing game"
PRINT "Enter word to scramble:"
INPUT x$
x$ = UCASE$(x$)
xl = LEN(x$)
IF xl < 1 THEN END
RANDOMIZE TIMER
FOR a = 1 TO xl
    again: x = INT(RND * xl) + 1
    FOR b = 1 TO 30
        IF x = y(b) THEN GOTO again:
    NEXT b
    d$ = d$ + MID$(x$, x, 1)
    y(a) = x
NEXT a
CLS
PRINT "Here is the scramled word:"
PRINT d$
guess: INPUT "Enter guess"; g$
g$ = UCASE$(g$)
IF g$ <> x$ THEN GOTO guess:
PRINT "You got it!"
SLEEP
