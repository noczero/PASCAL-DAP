SCREEN 0, 0: WIDTH 80: COLOR 7, 0, 0
DEFINT A-Z
CW = 0
HW = 0
START:
RANDOMIZE TIMER
N = 23
DUMB = 0
CLS
GOSUB SHOWMATCHES
PRINT
PRINT "           ******************** "; : COLOR 4, 0: PRINT "23 MATCHES GAME"; : COLOR 7, 0: PRINT " ********************"
PRINT "           **                                                     **"
PRINT "           **   Each turn, you may take away 1, 2, or 3 matches.  **"
PRINT "           **   The player stuck with the last match loses.       **"
PRINT "           **                                                     **"
PRINT "           **   Choose <"; : COLOR 4, 0: PRINT "D"; : COLOR 7, 0: PRINT ">unce, <"; : COLOR 4, 0: PRINT "S"; : COLOR 7, 0: PRINT ">mart, or <";
COLOR 4, 0: PRINT "G"; : COLOR 7, 0: PRINT ">enius Computer.    **"
PRINT "           **                                                     **"
PRINT "           *********************************************************"
DO
K$ = UCASE$(INKEY$)
IF K$ = CHR$(27) THEN CLS : END
IF K$ = "D" THEN DUMB = 1: EXIT DO
IF K$ = "S" THEN DUMB = 2: EXIT DO
IF K$ = "G" THEN EXIT DO
LOOP
CLS
LOCATE 10
PRINT "           *********************************************************"
PRINT "           **                                                     **"
PRINT "           **        Who moves first? <"; : COLOR 4, 0: PRINT "Y"; : COLOR 7, 0: PRINT ">ou, <"; : COLOR 4, 0: PRINT "C"; : COLOR 7, 0: PRINT ">omputer.          **"
PRINT "           **                                                     **"
PRINT "           *********************************************************"
DO
K$ = UCASE$(INKEY$)
IF K$ = CHR$(27) THEN CLS : END
IF K$ = "Y" THEN FIRST = 1: EXIT DO
IF K$ = "C" THEN FIRST = 0: EXIT DO
LOOP
IF FIRST = 0 THEN GOTO COMMOVE
GOSUB SHOWMATCHES
GOTO GETMOVE
SHOWMATCHES:
CLS
PRINT
PRINT "    ";
COLOR 4, 0
FOR A = 1 TO 2
PRINT
PRINT "    ";
FOR X = 1 TO N
PRINT " ²²";
NEXT X
NEXT A
COLOR 7, 0
PRINT
PRINT "    ";
FOR X = 1 TO N
PRINT " ²²";
NEXT X
PRINT
PRINT "    ";
COLOR 7, 0
FOR A = 1 TO 8
FOR X = 1 TO N
PRINT " ÛÛ";
NEXT X
PRINT
PRINT "    ";
NEXT A
RETURN
GETMOVE:
GETNUM:
PRINT
PRINT "     You have"; : COLOR 4, 0: PRINT N; : COLOR 7, 0: PRINT "matches left."
INPUT "     How many do you want to remove (1, 2, or 3)? ", R$
R = INT(ABS(VAL(R$)))
IF R >= N OR R < 1 OR R > 3 THEN
  PRINT
  COLOR 4, 0
  PRINT "     Illegal number. Try again!"
  COLOR 7, 0
  GOTO GETNUM
END IF
N = N - R
GOTO COMMOVE
COMMOVE:
CLS
CR = INT(RND * 3) + 1
IF (N = 20) + (N = 16) + (N = 12) + (N = 8) + (N = 4) THEN CR = 3
IF (N = 23) + (N = 19) + (N = 15) + (N = 11) + (N = 7) + (N = 3) THEN CR = 2
IF (N = 22) + (N = 18) + (N = 14) + (N = 10) + (N = 6) + (N = 2) + (N = 1) THEN CR = 1
IF DUMB > 0 THEN GOSUB COMDUMB
N = N - CR
IF N = 0 THEN GOTO COMLOSE
GOSUB SHOWMATCHES
PRINT
PRINT "     The Computer removes"; : COLOR 4, 0: PRINT CR; : COLOR 7, 0: PRINT "matches."
IF N = 1 THEN GOTO YOULOSE
GOTO GETMOVE
YOULOSE:
PRINT
PRINT "     You have the last match, You lose!"
CW = CW + 1
GOTO DONE
COMLOSE:
N = 1
GOSUB SHOWMATCHES
PRINT
PRINT "     The Computer has the last match, It loses!"
HW = HW + 1
GOTO DONE
DONE:
PRINT
PRINT "     You have won"; : COLOR 4, 0: PRINT HW;
COLOR 7, 0: PRINT "game(s), Computer has won"; : COLOR 4, 0: PRINT CW;
COLOR 7, 0: PRINT "game(s)."
PRINT
PRINT "     <"; : COLOR 4, 0: PRINT "Q"; : COLOR 7, 0: PRINT ">uit or any other key to play again..."
K$ = UCASE$(INPUT$(1))
IF K$ = "Q" OR K$ = CHR$(27) THEN CLS : END ELSE GOTO START
COMDUMB:
CR = INT(RND * 3) + 1
IF N = 4 THEN CR = 3
IF N = 3 THEN CR = 2
IF N = 2 THEN CR = 1
IF N = 1 THEN CR = 1
IF DUMB = 1 THEN RETURN
IF N = 6 OR N = 10 THEN CR = 1
IF N = 7 OR N = 11 THEN CR = 2
IF N = 8 OR N = 12 THEN CR = 3
RETURN

