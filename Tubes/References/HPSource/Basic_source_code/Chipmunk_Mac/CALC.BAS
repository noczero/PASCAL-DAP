5 ' Calculator, for Chipmunk BASIC, web: http://rudih.info
10  PRINT "---Calculator---"
20  INPUT "Enter 1st number: ", num1
30  INPUT "Enter operator (+,-,*,/): ", operator$
40  INPUT "Enter 2nd number: ", num2
60  IF operator$ = "+" THEN PRINT num1 + num2
70  IF operator$ = "-" THEN PRINT num1 - num2
80  IF operator$ = "*" THEN PRINT num1 * num2
90  IF operator$ = "/" THEN PRINT num1 / num2
100 PRINT "Again (Y/N)? "
110 rep$ = ""
120 WHILE rep$ = ""
130   rep$ = INKEY$
140 WEND
150 rep$ = UCASE$(rep$)
160 IF rep$ <> "N" THEN GOTO 20

