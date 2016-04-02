5 ' Leap year, for Chipmunk BASIC, web: http://rudih.info
10  CLS
20  main:
30  INPUT "Enter a year or 0 to exit: ", year
40  IF year <= 0 THEN END
50  IF year MOD 100 = 0 THEN
60      GOTO 190
70    ELSE
80      GOTO 110
90  END IF
110 year = year MOD 4
120 SELECT CASE year
130 CASE 0: PRINT "That year is a leap year."
140 CASE 3: PRINT "The next year might be a leap year."
150 CASE 1 TO 2: PRINT "That year is not a leap year."
160 END SELECT:
170 GOTO 20
190 IF year MOD 400 = 0 THEN
200     PRINT "That year is a leap year."
210   ELSE
220     PRINT "Not even close to a leap year."
230 END IF
240 GOTO 20

