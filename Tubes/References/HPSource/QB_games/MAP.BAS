DECLARE SUB EndGame ()
DECLARE SUB WFK ()
DECLARE SUB MU ()
DECLARE SUB MR ()
DECLARE SUB MD ()
DECLARE SUB ML ()
DECLARE SUB PrintScreen ()
DIM SHARED map(12, 31), x, y, cc, NOC, dx, dy: SCREEN 13
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,1,1,1,1,1,0,0,0,0,0,1,2,1,1,1,1,1,2,0,0,0,0,0,0,0,0,0,2,1
DATA 1,0,1,2,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,1,1,1,1,1,0,1,0,1,0,1,1
DATA 1,0,1,1,1,1,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,1,2,0,1,0,1,0,1,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1,1,1,1,1,1,0,1,1,0,1,2,1,0,1,1
DATA 1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,2,0,0,0,0,1,0,1,1,0,1,1,1,0,1,1
DATA 1,0,0,0,0,0,0,0,0,2,1,0,1,0,1,1,1,1,1,0,1,0,2,1,0,0,2,1,0,1,1
DATA 1,0,1,1,1,1,1,1,1,0,1,0,1,0,0,0,0,0,1,0,1,0,1,1,1,1,1,1,0,1,1
DATA 1,0,1,2,4,0,0,0,0,0,1,0,1,0,1,2,1,2,1,0,1,0,0,0,0,0,0,0,0,2,1
DATA 1,0,1,1,1,1,1,1,1,1,1,0,1,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,0,1
DATA 1,2,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,3,2,1,2,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,11,27
FOR r1 = 1 TO 12: FOR r2 = 1 TO 31: READ map(r1, r2): NEXT r2: NEXT r1
READ dx
READ dy
LET x = 2: LET y = 2
PrintScreen

SUB EndGame
PRINT "YOU WIN!!!!!!"
END

END SUB

SUB MD
IF map(x + 1, y) = 0 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET x = x + 1
   LOCATE x, y
   COLOR 9: PRINT CHR$(2)
   GOTO AfterMD
END IF
IF map(x + 1, y) = 1 OR map(x + 1, y) = 3 THEN GOTO AfterMD
IF map(x + 1, y) = 2 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET x = x + 1
   LET map(x, y) = 0
   LET cc = cc + 1
   IF cc = NOC THEN EndGame
   LOCATE x, y: COLOR 9: PRINT CHR$(2)
END IF
IF map(x + 1, y) = 4 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET x = x + 1
   LET map(x, y) = 0
   LET map(dx, dy) = 0
   LOCATE dx, dy: PRINT CHR$(0)
   LOCATE x, y: PRINT CHR$(2)
END IF
AfterMD:
END SUB

SUB ML
IF map(x, y - 1) = 0 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET y = y - 1
   LOCATE x, y
   COLOR 9: PRINT CHR$(2)
   GOTO AfterML
END IF
IF map(x, y - 1) = 1 OR map(x + 1, y) = 3 THEN GOTO AfterML
IF map(x, y - 1) = 2 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET y = y - 1
   LOCATE x, y: COLOR 9: PRINT CHR$(2)
   LET map(x, y) = 0
   LET cc = cc + 1
   IF cc = NOC THEN EndGame
   LOCATE x, y: COLOR 9: PRINT CHR$(2)
END IF
IF map(x, y - 1) = 4 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET y = y - 1
   LET map(x, y) = 0
   LET map(dx, dy) = 0
   LOCATE dx, dy: PRINT CHR$(0)
   LOCATE x, y: PRINT CHR$(2)
END IF
AfterML:
END SUB

SUB MR
IF map(x, y + 1) = 0 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET y = y + 1
   LOCATE x, y
   COLOR 9: PRINT CHR$(2)
   GOTO AfterMR
END IF
IF map(x, y + 1) = 1 OR map(x + 1, y) = 3 THEN GOTO AfterMR
IF map(x, y + 1) = 2 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET y = y + 1
   LET map(x, y) = 0
   LET cc = cc + 1
   IF cc = NOC THEN EndGame
   LOCATE x, y: COLOR 9: PRINT CHR$(2)
END IF
IF map(x, y + 1) = 4 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET y = y + 1
   LET map(x, y) = 0
   LET map(dx, dy) = 0
   LOCATE dx, dy: PRINT CHR$(0)
   LOCATE x, y: PRINT CHR$(2)
END IF
AfterMR:
END SUB

SUB MU
IF map(x - 1, y) = 0 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET x = x - 1
   LOCATE x, y
   COLOR 9: PRINT CHR$(2)
   GOTO AfterMU
END IF
IF map(x - 1, y) = 1 OR map(x + 1, y) = 3 THEN GOTO AfterMU
IF map(x - 1, y) = 2 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET x = x - 1
   LET map(x, y) = 0
   LET cc = cc + 1
   IF cc = NOC THEN EndGame
   LOCATE x, y: COLOR 9: PRINT CHR$(2)
END IF
IF map(x - 1, y) = 4 THEN
   LOCATE x, y: PRINT CHR$(0)
   LET x = x - 1
   LET map(x, y) = 0
   LET map(dx, dy) = 0
   LOCATE dx, dy: PRINT CHR$(0)
   LOCATE x, y: PRINT CHR$(2)
END IF
AfterMU:
END SUB

SUB PrintScreen
FOR p1 = 1 TO 12
   FOR p2 = 1 TO 31
      LOCATE p1, p2
      IF map(p1, p2) = 0 THEN PRINT CHR$(0)
      IF map(p1, p2) = 1 THEN COLOR 15: PRINT CHR$(219)
      IF map(p1, p2) = 2 THEN COLOR 14: LET NOC = NOC + 1: PRINT CHR$(15)
      IF map(p1, p2) = 3 THEN COLOR 4: PRINT CHR$(182)
      IF map(p1, p2) = 4 THEN COLOR 13: PRINT CHR$(22)
   NEXT p2
NEXT p1
LOCATE x, y
COLOR 9
PRINT CHR$(2)
LET SwX = 11
LET SwY = 27
WFK
END SUB

SUB WFK
DO
   LET Ky$ = INKEY$
   IF Ky$ = "8" THEN MU
   IF Ky$ = "6" THEN MR
   IF Ky$ = "2" THEN MD
   IF Ky$ = "4" THEN ML
LOOP
END SUB

