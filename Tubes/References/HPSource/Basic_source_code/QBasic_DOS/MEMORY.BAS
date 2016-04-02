' Memory Game, for QBasic, http://rudih.info
' A 6*6 board with 18 letter pairs to uncover. v1.0

DIM cell(1 TO 36) AS STRING 'pairs of letters
RANDOMIZE TIMER
matchstr$ = " "
movecount = 1

'randomly fill board  ([A]065-[R]082)
FOR curc = 65 TO 82 STEP 1
 z = 0
 WHILE z = 0
   x = INT(RND * 36) + 1
   IF cell(x) = "" THEN
     cell(x) = CHR$(curc)
     z = 1
   END IF
 WEND
 z = 0
 WHILE z = 0
   x = INT(RND * 36) + 1
   IF cell(x) = "" THEN
     cell(x) = CHR$(curc)
     z = 1
   END IF
 WEND
NEXT curc

main:
GOSUB dispb:
GOSUB mmove:
move1 = move
GOSUB dispb:
GOSUB mmove:
move2 = move
GOSUB dispb:
PRINT ""
PRINT ""
IF save1$ = save2$ THEN
  PRINT "Match. ";
  matchstr$ = matchstr$ + save1$
 ELSE
  PRINT "No match. ";
END IF
move1 = 0
move2 = 0
move = 0
PRINT "Press any key to continue..."
movecount = movecount + 1
x$ = ""
WHILE x$ = ""
  x$ = INKEY$
WEND
IF LEN(matchstr$) = 19 THEN
  PRINT "Game complete! Press any key to exit..."
  SLEEP
  END
END IF
GOTO main:

'display board
dispb:
CLS
PRINT " ---MEMORY GAME---"
PRINT " Move #"; movecount
PRINT ""
PRINT "     0    1    2    3    4    5 "
PRINT ""
PRINT " 0 ";
x = 1
FOR scratch = 1 TO 36
  IF scratch = move1 THEN
    PRINT "  "; cell(scratch); "  ";
    save1$ = cell(scratch)
    GOTO skip:
  END IF
  IF scratch = move2 THEN
    PRINT "  "; cell(scratch); "  ";
    save2$ = cell(scratch)
    GOTO skip:
  END IF
  IF INSTR(matchstr$, cell(scratch)) = 0 THEN
     PRINT "  *  ";
    ELSE
     PRINT "  "; cell(scratch); "  ";
  END IF
skip:
  IF scratch MOD 6 = 0 AND scratch < 36 THEN
     PRINT ""
     PRINT ""
     PRINT x;
     x = x + 1
  END IF
NEXT scratch
RETURN

'make move
mmove:
PRINT ""
PRINT ""
INPUT "Enter x coordinate (-1 quits): "; x
IF x = -1 THEN END
INPUT "Enter y coordinate (-1 quits): "; y
IF y = -1 THEN END
move = (6 * y) + (x + 1)
RETURN

