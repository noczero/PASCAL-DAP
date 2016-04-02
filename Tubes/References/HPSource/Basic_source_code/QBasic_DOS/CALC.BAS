' Calculator, for QBasic/QuickBasic, web: http://rudih.info

CLS
PRINT "---Calculator---"
DIM num1 AS SINGLE
DIM num2 AS SINGLE
DIM radians AS SINGLE

DO WHILE rep$ <> "N"
   INPUT "Enter 1st number: ", num1
   INPUT "Enter operator (+,-,*,/,sqr,cos,sin,tan): ", operator$
   operator$ = UCASE$(operator$)
   oplength = LEN(operator$)
   IF oplength < 2 THEN
      INPUT "Enter 2nd number: ", num2
      IF operator$ = "+" THEN PRINT num1 + num2
      IF operator$ = "-" THEN PRINT num1 - num2
      IF operator$ = "*" THEN PRINT num1 * num2
      IF operator$ = "/" THEN PRINT num1 / num2
   ELSE
      radians = 3.141593 * (num1 / 180)
      IF operator$ = "SQR" THEN PRINT SQR(num1)
      IF operator$ = "COS" THEN PRINT COS(radians)
      IF operator$ = "SIN" THEN PRINT SIN(radians)
      IF operator$ = "TAN" THEN PRINT TAN(radians)
   END IF
   PRINT "Again (Y/N)? "
   rep$ = ""
   WHILE rep$ = ""
     rep$ = INKEY$
   WEND
   rep$ = UCASE$(rep$)
LOOP

