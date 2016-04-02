DECLARE SUB putsquare (num!, char$)
DECLARE SUB doturn ()
DECLARE SUB goturn ()
'Text Tic Tac Toe
'
'4/30/97 By: - Nick Kochakian -
'
'For people who can't get enough of it...
'
'This program is still buggy if you can fix some or all of them that would
'be great!
'
'If you have any comments, questions, or bug fixes please e-mail me at:
'nickk@worldnet.att.net
'
'Note: This game is best played with the num pad. The squares are configured
'      to work best (and easiest) with it! Make shure NUM LOCK is on!


RANDOMIZE TIMER

youwin = 0
compwin = 0

CLS

PRINT "Which do you want to be?"
PRINT "(Push X or O)"
PRINT ""
DO
a$ = INKEY$
a$ = UCASE$(a$)
LOOP UNTIL a$ = "X" OR a$ = "O"

you$ = a$

IF you$ = "X" THEN other$ = "O"
IF you$ = "O" THEN other$ = "X"

DIM SHARED turn

gofirst = INT(RND * 2) + 1
turn = gofirst

'1 - You
'2 - Computer

'DIM SHARED a1$
'DIM SHARED a2$
'DIM SHARED a3$
'DIM SHARED a4$
'DIM SHARED a5$
'DIM SHARED a6$
'DIM SHARED a7$
'DIM SHARED a8$
'DIM SHARED a9$

playtttagain:
CLS
a1$ = "o"
a2$ = "o"
a3$ = "o"
a4$ = "o"
a5$ = "o"
a6$ = "o"
a7$ = "o"
a8$ = "o"
a9$ = "o"

b1$ = "o"
b2$ = "o"
b3$ = "o"
b4$ = "o"
b5$ = "o"
b6$ = "o"
b7$ = "o"
b8$ = "o"
b9$ = "o"

'o = open
'c = closed


CLS

'7³ 8 ³9
'ÄÅÄÄÄÅÄ
'4³ 5 ³6
'ÄÅÄÄÄÅÄ
'1³ 2 ³3

PRINT " ³   ³                   7³ 8 ³9"
PRINT "ÄÅÄÄÄÅÄ                  ÄÅÄÄÄÅÄ"
PRINT " ³   ³                   4³ 5 ³6"
PRINT "ÄÅÄÄÄÅÄ                  ÄÅÄÄÄÅÄ"
PRINT " ³   ³                   1³ 2 ³3"
PRINT ""
PRINT "You: " + you$
PRINT "Computer: " + other$
'9,1 --- Right here

LOCATE 15, 1
PRINT "Your wins: "; youwin
PRINT "Computer wins: "; compwin
DO
a$ = INKEY$
a$ = UCASE$(a$)
CALL goturn
GOSUB seeifwin:
'IF b1$ = "c" AND b2$ = "c" AND b3$ = "c" AND b4$ = "c" AND b5$ = "c" AND b6$ = "c" AND b7$ = "c" AND b8$ = "c" AND b9$ = "c" THEN LOCATE 10, 1: PRINT "No one wins": GOTO playagain:
IF turn = 1 THEN GOSUB doyourturn: turn = 2
IF turn = 2 THEN GOSUB doturn: turn = 1
GOSUB seeifwin:
LOOP UNTIL a$ = "Q"

END

doturn:

IF turn = 2 THEN

'IF b1$ = "c" AND b2$ = "c" AND b3$ = "c" AND b4$ = "c" AND b5$ = "c" AND b6$ = "c" AND b7$ = "c" AND b8$ = "c" AND b9$ = "c" THEN LOCATE 10, 1: PRINT "No one wins": GOTO playagain:

gotur$ = "y"

IF a1$ = "c1" AND a2$ = "c1" THEN tur = 3: gotur$ = "n"
IF a1$ = "c1" AND a3$ = "c1" THEN tur = 2: gotur$ = "n"
IF a2$ = "c1" AND a3$ = "c1" THEN tur = 1: gotur$ = "n"

IF a1$ = "c1" AND a4$ = "c1" THEN tur = 7: gotur$ = "n"
IF a1$ = "c1" AND a7$ = "c1" THEN tur = 4: gotur$ = "n"
IF a7$ = "c1" AND a4$ = "c1" THEN tur = 1: gotur$ = "n"

IF a1$ = "c1" AND a5$ = "c1" THEN tur = 9: gotur$ = "n"
IF a1$ = "c1" AND a9$ = "c1" THEN tur = 5: gotur$ = "n"
IF a5$ = "c1" AND a9$ = "c1" THEN tur = 1: gotur$ = "n"

IF a7$ = "c1" AND a5$ = "c1" THEN tur = 3: gotur$ = "n"
IF a7$ = "c1" AND a3$ = "c1" THEN tur = 5: gotur$ = "n"
IF a3$ = "c1" AND a5$ = "c1" THEN tur = 7: gotur$ = "n"

IF a4$ = "c1" AND a5$ = "c1" THEN tur = 6: gotur$ = "n"
IF a5$ = "c1" AND a6$ = "c1" THEN tur = 4: gotur$ = "n"
IF a4$ = "c1" AND a6$ = "c1" THEN tur = 5: gotur$ = "n"

IF a7$ = "c1" AND a9$ = "c1" THEN tur = 8: gotur$ = "n"
IF a7$ = "c1" AND a8$ = "c1" THEN tur = 9: gotur$ = "n"
IF a9$ = "c1" AND a8$ = "c1" THEN tur = 7: gotur$ = "n"

'1³ 2 ³3
'ÄÅÄÄÄÅÄ
'4³ 5 ³6
'ÄÅÄÄÄÅÄ
'7³ 8 ³9
IF a2$ = "c1" AND a8$ = "c1" THEN tur = 5: gotur$ = "n"
IF a5$ = "c1" AND a8$ = "c1" THEN tur = 2: gotur$ = "n"
IF a2$ = "c1" AND a5$ = "c1" THEN tur = 8: gotur$ = "n"

IF a3$ = "c1" AND a6$ = "c1" THEN tur = 9: gotur$ = "n"
IF a3$ = "c1" AND a9$ = "c1" THEN tur = 6: gotur$ = "n"
IF a6$ = "c1" AND a9$ = "c1" THEN tur = 3: gotur$ = "n"

GOSUB seeifwin:

redoturn2:

IF gotur$ = "y" THEN tur = INT(RND * 9) + 1

gotur$ = "y"

IF tur = 1 AND a1$ = "o" THEN a1$ = "c2": b1$ = "c": CALL putsquare(1, other$): GOSUB seeifwin: RETURN
IF tur = 2 AND a2$ = "o" THEN a2$ = "c2": b2$ = "c": CALL putsquare(2, other$): GOSUB seeifwin: RETURN
IF tur = 3 AND a3$ = "o" THEN a3$ = "c2": b3$ = "c": CALL putsquare(3, other$): GOSUB seeifwin: RETURN
IF tur = 4 AND a4$ = "o" THEN a4$ = "c2": b4$ = "c": CALL putsquare(4, other$): GOSUB seeifwin: RETURN
IF tur = 5 AND a5$ = "o" THEN a5$ = "c2": b5$ = "c": CALL putsquare(5, other$): GOSUB seeifwin: RETURN
IF tur = 6 AND a6$ = "o" THEN a6$ = "c2": b6$ = "c": CALL putsquare(6, other$): GOSUB seeifwin: RETURN
IF tur = 7 AND a7$ = "o" THEN a7$ = "c2": b7$ = "c": CALL putsquare(7, other$): GOSUB seeifwin: RETURN
IF tur = 8 AND a8$ = "o" THEN a8$ = "c2": b8$ = "c": CALL putsquare(8, other$): GOSUB seeifwin: RETURN
IF tur = 9 AND a9$ = "o" THEN a9$ = "c2": b9$ = "c": CALL putsquare(9, other$): GOSUB seeifwin: RETURN

GOTO redoturn2:

END IF

RETURN

doyourturn:
LOCATE 10, 1: PRINT "Press a number 1-9 to make your mark... Or press Q to quit"

redomeyou:
DO
a$ = INKEY$
a$ = UCASE$(a$)
LOOP UNTIL a$ = "1" OR a$ = "2" OR a$ = "3" OR a$ = "4" OR a$ = "5" OR a$ = "6" OR a$ = "7" OR a$ = "8" OR a$ = "9" OR a$ = "Q"
IF a$ = "Q" THEN END
IF a$ = "1" AND a1$ = "o" THEN a1$ = "c1": b1$ = "c": CALL putsquare(1, you$): LOCATE 10, 1: COLOR 0: PRINT "Press a number 1-9 to make your mark... Or press Q to quit": COLOR 7: GOSUB seeifwin: RETURN
IF a$ = "2" AND a2$ = "o" THEN a2$ = "c1": b2$ = "c": CALL putsquare(2, you$): LOCATE 10, 1: COLOR 0: PRINT "Press a number 1-9 to make your mark... Or press Q to quit": COLOR 7: GOSUB seeifwin: RETURN
IF a$ = "3" AND a3$ = "o" THEN a3$ = "c1": b3$ = "c": CALL putsquare(3, you$): LOCATE 10, 1: COLOR 0: PRINT "Press a number 1-9 to make your mark... Or press Q to quit": COLOR 7: GOSUB seeifwin: RETURN
IF a$ = "4" AND a4$ = "o" THEN a4$ = "c1": b4$ = "c": CALL putsquare(4, you$): LOCATE 10, 1: COLOR 0: PRINT "Press a number 1-9 to make your mark... Or press Q to quit": COLOR 7: GOSUB seeifwin: RETURN
IF a$ = "5" AND a5$ = "o" THEN a5$ = "c1": b5$ = "c": CALL putsquare(5, you$): LOCATE 10, 1: COLOR 0: PRINT "Press a number 1-9 to make your mark... Or press Q to quit": COLOR 7: GOSUB seeifwin: RETURN
IF a$ = "6" AND a6$ = "o" THEN a6$ = "c1": b6$ = "c": CALL putsquare(6, you$): LOCATE 10, 1: COLOR 0: PRINT "Press a number 1-9 to make your mark... Or press Q to quit": COLOR 7: GOSUB seeifwin: RETURN
IF a$ = "7" AND a7$ = "o" THEN a7$ = "c1": b7$ = "c": CALL putsquare(7, you$): LOCATE 10, 1: COLOR 0: PRINT "Press a number 1-9 to make your mark... Or press Q to quit": COLOR 7: GOSUB seeifwin: RETURN
IF a$ = "8" AND a8$ = "o" THEN a8$ = "c1": b8$ = "c": CALL putsquare(8, you$): LOCATE 10, 1: COLOR 0: PRINT "Press a number 1-9 to make your mark... Or press Q to quit": COLOR 7: GOSUB seeifwin: RETURN
IF a$ = "9" AND a9$ = "o" THEN a9$ = "c1": b9$ = "c": CALL putsquare(9, you$): LOCATE 10, 1: COLOR 0: PRINT "Press a number 1-9 to make your mark... Or press Q to quit": COLOR 7: GOSUB seeifwin: RETURN
GOSUB seeifwin:
LOCATE 11, 1: PRINT "That square is all ready used!": SLEEP 2: LOCATE 11, 1: COLOR 0: PRINT "That square is all ready used!": COLOR 7: GOTO redomeyou:
RETURN

seeifwin:
IF a1$ = "c2" AND a2$ = "c2" AND a3$ = "c2" THEN LOCATE 10, 1: PRINT "Computer wins": compwin = compwin + 1: GOTO playagain:
IF a7$ = "c1" AND a5$ = "c1" AND a3$ = "c1" THEN LOCATE 10, 1: PRINT "YOU WIN!!!": youwin = youwin + 1:   GOTO playagain:
IF a7$ = "c2" AND a5$ = "c2" AND a3$ = "c2" THEN LOCATE 10, 1: PRINT "Computer wins": compwin = compwin + 1: GOTO playagain:
IF a2$ = "c2" AND a5$ = "c2" AND a8$ = "c2" THEN LOCATE 10, 1: PRINT "Computer wins": compwin = compwin + 1: GOTO playagain:
IF a1$ = "c1" AND a2$ = "c1" AND a3$ = "c1" THEN LOCATE 10, 1: PRINT "YOU WIN!!!": youwin = youwin + 1:   GOTO playagain:
IF a1$ = "c2" AND a2$ = "c2" AND a3$ = "c2" THEN LOCATE 10, 1: PRINT "Computer wins": compwin = compwin + 1: GOTO playagain:
IF b1$ = "c" AND b2$ = "c" AND b3$ = "c" AND b4$ = "c" AND b5$ = "c" AND b6$ = "c" AND b7$ = "c" AND b8$ = "c" AND b9$ = "c" THEN LOCATE 10, 1: PRINT "No one wins": GOTO playagain:

IF a1$ = "c1" AND a4$ = "c1" AND a7$ = "c1" THEN LOCATE 10, 1: PRINT "YOU WIN!!!": youwin = youwin + 1:   GOTO playagain:
IF a1$ = "c2" AND a4$ = "c2" AND a7$ = "c2" THEN LOCATE 10, 1: PRINT "Computer wins": compwin = compwin + 1: GOTO playagain:
IF a4$ = "c1" AND a5$ = "c1" AND a6$ = "c1" THEN LOCATE 10, 1: PRINT "YOU WIN!!!": youwin = youwin + 1:   GOTO playagain:
IF a4$ = "c2" AND a5$ = "c2" AND a6$ = "c2" THEN LOCATE 10, 1: PRINT "Computer wins": compwin = compwin + 1: GOTO playagain:
IF a7$ = "c1" AND a8$ = "c1" AND a9$ = "c1" THEN LOCATE 10, 1: PRINT "YOU WIN!!!": youwin = youwin + 1:   GOTO playagain:
IF a7$ = "c2" AND a8$ = "c2" AND a9$ = "c2" THEN LOCATE 10, 1: PRINT "Computer wins": compwin = compwin + 1: GOTO playagain:
IF a2$ = "c1" AND a5$ = "c1" AND a8$ = "c1" THEN LOCATE 10, 1: PRINT "YOU WIN!!!": youwin = youwin + 1:   GOTO playagain:
IF a2$ = "c2" AND a5$ = "c2" AND a8$ = "c2" THEN LOCATE 10, 1: PRINT "Computer wins": compwin = compwin + 1: GOTO playagain:
IF a3$ = "c1" AND a6$ = "c1" AND a9$ = "c1" THEN LOCATE 10, 1: PRINT "YOU WIN!!!": youwin = youwin + 1:   GOTO playagain:
IF a3$ = "c2" AND a6$ = "c2" AND a9$ = "c2" THEN LOCATE 10, 1: PRINT "Computer wins": compwin = compwin + 1: GOTO playagain:
IF a1$ = "c1" AND a5$ = "c1" AND a9$ = "c1" THEN LOCATE 10, 1: PRINT "YOU WIN!!!": youwin = youwin + 1:   GOTO playagain:
IF a1$ = "c2" AND a5$ = "c2" AND a9$ = "c2" THEN LOCATE 10, 1: PRINT "Computer wins": compwin = compwin + 1: GOTO playagain:
IF a7$ = "c1" AND a5$ = "c1" AND a3$ = "c1" THEN LOCATE 10, 1: PRINT "YOU WIN!!!": youwin = youwin + 1:  GOTO playagain:
IF a7$ = "c2" AND a5$ = "c2" AND a3$ = "c2" THEN LOCATE 10, 1: PRINT "Computer wins": compwin = compwin + 1: GOTO playagain:

RETURN

playagain:
PRINT "Play again? (Y/N)"
DO
a$ = INKEY$
a$ = UCASE$(a$)
LOOP UNTIL a$ = "Y" OR a$ = "N"
IF a$ = "N" THEN CLS : END
IF a$ = "Y" THEN GOTO playtttagain:

END

SUB goturn
IF turn = 1 THEN LOCATE 9, 1: PRINT "Your turn      "
IF turn = 2 THEN LOCATE 9, 1: PRINT "Computer's turn"
END SUB

SUB putsquare (num, char$)
RANDOMIZE TIMER

IF num = 7 THEN
LOCATE 1, 1: PRINT char$
END IF

IF num = 8 THEN
LOCATE 1, 4: PRINT char$
END IF

IF num = 9 THEN
LOCATE 1, 7: PRINT char$
END IF

IF num = 4 THEN
LOCATE 3, 1: PRINT char$
END IF

IF num = 5 THEN
LOCATE 3, 4: PRINT char$
END IF

IF num = 6 THEN
LOCATE 3, 7: PRINT char$
END IF

IF num = 1 THEN
LOCATE 5, 1: PRINT char$
END IF

IF num = 2 THEN
LOCATE 5, 4: PRINT char$
END IF

IF num = 3 THEN
LOCATE 5, 7: PRINT char$
END IF

END SUB

