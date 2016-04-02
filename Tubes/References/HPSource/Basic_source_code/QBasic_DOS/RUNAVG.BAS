' Running average, for QBasic/QuickBasic, web: http://rudih.info

CLS
PRINT "---Running average---"
DIM count AS LONG
DIM usernumber AS SINGLE
DIM answer AS SINGLE
DIM total AS SINGLE

DO WHILE (usernumber >= 0)
   INPUT "Enter number or -1 to stop: ", usernumber
   count = count + 1
   total = total + usernumber
   answer = total / count
   PRINT answer
LOOP

