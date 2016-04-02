' Leap year, for FreeBASIC, web: http://rudih.info

Dim Year As Integer

CLS
main:
INPUT "Enter a year or 0 to exit: ", year
IF year <= 0 THEN END
IF year MOD 100 = 0 THEN
    GOTO centurycalc:
  ELSE
    GOTO regularcalc:
END IF

regularcalc:
year = year MOD 4
SELECT CASE year
CASE 0: PRINT "That year is a leap year."
CASE 3: PRINT "The next year might be a leap year."
CASE 1 TO 2: PRINT "That year is not a leap year."
END SELECT:
GOTO main:

centurycalc:
IF year MOD 400 = 0 THEN
    PRINT "That year is a leap year."
  ELSE
    PRINT "Not even close to a leap year."
END IF
GOTO main:

