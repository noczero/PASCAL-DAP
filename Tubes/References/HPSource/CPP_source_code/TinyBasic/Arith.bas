10 REM Arithmetic questioner, for TinyBasic, web: http://rudih.info
20 PRINT "Arithmetic Questioner - enter a negative number to quit"
30 PRINT "Set greatest number to add or subtract (1-15990)";
40 INPUT A
50 IF A <= 0 THEN END
60 PRINT "Set greatest number to multiply or divide (1-178)";
70 INPUT M
80 IF M <= 0 THEN END
90 U = 1
100 P = RND(16)
110 IF P >= 4 THEN GOTO 100
120 IF P < 2 THEN GOSUB 250
130 IF P = 2 THEN GOSUB 380
140 IF P = 3 THEN GOSUB 480
150 INPUT U
160 IF P = 0 THEN R = N + D
170 IF P = 1 THEN R = N - D
180 IF P = 2 THEN R = N * D
190 IF P = 3 THEN R = V / D
200 IF U = R THEN PRINT "Correct"
210 IF U <> R THEN PRINT "Incorrect, it's "; R
220 IF U >= 0 THEN GOTO 100
230 END
240 REM
250 REM ---SUBROUTINE ADD AND SUBTRACT---
260   S = A * 2    
270   N = RND (S)
280   IF N > A THEN GOTO 270
290   S = A * 2
300   D = RND (S)
310   IF D > A THEN GOTO 300
320   IF D >= N THEN P = 0
330   IF D >= N THEN PRINT N; " + "; D; " ";
340   IF D < N THEN P = 1
350   IF D < N THEN PRINT N; " - "; D; " ";
360   RETURN 
370 REM
380 REM ---SUBROUTINE MULTIPLY---
390   S = M * 2    
400   N = RND (S) + 1
410   IF N > M THEN GOTO 400
420   S = M * 2
430   D = RND (S) + 1
440   IF D > M THEN GOTO 430  
450   PRINT N; " * "; D; " ";
460   RETURN
470 REM
480 REM ---SUBROUTINE DIVIDE---  
490   S = M * 2    
500   N = RND (S) + 1
510   IF N > M THEN GOTO 500
520   S = M * 2
530   D = RND (S) + 1
540   IF D > M THEN GOTO 530 
550   V = N * D
560   PRINT V; " / "; D; " ";
570   RETURN
580 REM ---
590 REM [END OF PROGRAM]
