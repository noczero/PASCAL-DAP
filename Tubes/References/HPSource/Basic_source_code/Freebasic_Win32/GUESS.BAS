' Guessing game, for FreeBASIC, web: http://rudih.info

DIM range AS INTEGER
DIM guess AS INTEGER
DIM numguess AS INTEGER
DIM magicnumber AS INTEGER
Dim x As String

CLS
PRINT "---Guessing game---"
INPUT "Enter range (1-32000, e.g. 1000): ", range
RANDOMIZE TIMER
magicnumber = INT(RND * range) + 1
numguess = 0
DO WHILE (guess <> magicnumber AND guess >= 0)
   INPUT "Enter your guess, or -1 to exit: ", guess
   numguess = numguess + 1
   IF guess < magicnumber THEN PRINT "It is greater"
   IF guess > magicnumber THEN PRINT "It is less"
LOOP
IF guess = magicnumber THEN PRINT "You got it in"; numguess; " tries."
x=""
While x=""
   x=InKey$
Wend
