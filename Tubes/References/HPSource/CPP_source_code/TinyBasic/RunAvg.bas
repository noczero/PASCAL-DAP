10 REM Running average, for TinyBasic, web: http://rudih.info
20 U = 0
30 C = 0
40 T = 0
50 PRINT "---Running average---"
60 PRINT "Enter number or -1 to stop";
70 INPUT U
80 C = C + 1
90 T = T + U
100 A = T / C
110 PRINT A
120 IF U >= 0 THEN GOTO 60
130 END
