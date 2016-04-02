10 REM Guessing game, for TinyBasic, web: http://rudih.info
20 PRINT "---Guessing game---"
30 PRINT "Enter range (1-10000, e.g. 100)";
40 INPUT R
45 D = R * 3
50 M = RND (D) + 1
55 IF M > R THEN GOTO 50
60 N = 0
70   PRINT "Enter your guess"; 
80   INPUT G
90   N = N + 1
100  IF G < M THEN PRINT "It is greater"
110  IF G > M THEN PRINT "It is less"
120  IF G <> M THEN GOTO 70 
130 PRINT "You got it in "; 
140 PRINT N; 
150 PRINT " tries."
160 END

