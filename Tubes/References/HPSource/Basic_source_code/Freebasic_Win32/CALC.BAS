' Calculator, for FreeBASIC, web: http://rudih.info

Dim num1 AS SINGLE
DIM num2 AS SINGLE
DIM radians AS SINGLE
Dim oplength As Integer
Dim Op As String
Dim rep As String

CLS
PRINT "---Calculator---"
DO WHILE rep <> "N"
   Input "Enter 1st number: ", num1
   INPUT "Enter operator (+,-,*,/,sqr,cos,sin,tan): ", op
   op = UCASE$(op)
   oplength = LEN(op)
   IF oplength < 2 THEN
      INPUT "Enter 2nd number: ", num2
      IF op = "+" THEN PRINT num1 + num2
      IF op = "-" THEN PRINT num1 - num2
      IF op = "*" THEN PRINT num1 * num2
      IF op = "/" THEN PRINT num1 / num2
   ELSE
      radians = 3.141593 * (num1 / 180)
      IF op = "SQR" THEN PRINT SQR(num1)
      IF op = "COS" THEN PRINT COS(radians)
      IF op = "SIN" THEN PRINT SIN(radians)
      IF op = "TAN" THEN PRINT TAN(radians)
   END IF
   PRINT "Again (Y/N)? "
   rep = ""
   WHILE rep = ""
     rep = INKEY$
   WEND
   rep = UCASE$(rep)
LOOP

