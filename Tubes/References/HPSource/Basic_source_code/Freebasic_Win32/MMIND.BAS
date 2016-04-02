' Master Mind, for FreeBasic QB mode, http://rudih.info
' The player has 9 attempts to guess a 4 digit combination
' with indication of white for correct digit and black for
' correct place and digit. The digits are 1-6.

DIM digit(4) AS INTEGER
DIM user(4) AS INTEGER

' generate combination
RANDOMIZE TIMER
FOR x = 1 TO 4
  digit(x) = INT(RND * 6) + 1
NEXT x

' print messages on screen
CLS
PRINT " ---Mastermind---"
PRINT "Key in 4 digits from 1 to 6 to crack a secret code."
PRINT "White=correct digit. Black=correct digit and place."
PRINT "You have 9 attempts. <Esc> quits."

' program main loop
main:
attemptnum = 1
WHILE blkcount < 4
 GOSUB getinput:
 GOSUB feedback:
 attemptnum = attemptnum + 1
 IF attemptnum = 10 AND blkcount <> 4 THEN
   PRINT "You lose. It was:";
   GOSUB dispcombo:
   PRINT "Press any key to exit..."
   SLEEP
   END
 END IF
WEND
PRINT "You got it! Press any key to exit..."
SLEEP
END

' disp combo
dispcombo:
FOR x = 1 TO 4
 PRINT digit(x);
NEXT x
PRINT ""
RETURN

' get guess input from user
getinput:
PRINT " Attempt#";
PRINT attemptnum;
PRINT ": ";
FOR x = 1 TO 4
  inplab: y$ = ""
  WHILE y$ = ""
    y$ = INKEY$
  WEND
  IF y$ = "" THEN END
  user(x) = VAL(y$)
  if user(x)>6 or user(x)<1 then goto inplab:
  PRINT y$; " ";
NEXT x
RETURN

' Provide feedback about guess
feedback:
FOR x = 1 TO 4
 IF user(x) = digit(x) THEN blkcount = blkcount + 1
 FOR y = 1 TO 4
    IF user(x) = digit(y) THEN
      whtcount = whtcount + 1
      y = 4
    END IF
 NEXT y
NEXT x
PRINT " - ";
PRINT "Black ="; blkcount;
PRINT " White ="; whtcount
IF blkcount < 4 THEN blkcount = 0
whtcount = 0
RETURN

