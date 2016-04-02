'
'    Save the little smilies! Eat them all! Good Luck!
'
'
'   This program was made by Steve Nunnally. Copyright (C) 1997
'All of this code was written by me, Steve Nunnally. DO NOT copy
'this code unless you have my permission! And you MAY NOT change
'the name in this paragraph to your name.   
'
DECLARE SUB MakeLevel ()
CLS : SCREEN 12: RANDOMIZE TIMER
DIM SHARED tail.o(1 TO 9999) AS INTEGER
DIM SHARED tail.u(1 TO 9999) AS INTEGER
DIM SHARED tail.d(1 TO 9999) AS INTEGER
DIM SHARED nothing(100)
DIM SHARED face(100)
DIM SHARED tail.f(100)
DIM SHARED tail.b(100)
DIM SHARED tail.l(100)
DIM SHARED tail.r(100)
DIM SHARED block(150)
DIM SHARED smiley(100)
DIM SHARED dir AS INTEGER
DIM SHARED up AS INTEGER
DIM SHARED over AS INTEGER
DIM SHARED life AS INTEGER
DIM SHARED level AS INTEGER
DIM SHARED points AS INTEGER
DIM SHARED speed AS INTEGER
DIM SHARED length AS INTEGER
DIM SHARED w AS INTEGER
DIM SHARED t AS INTEGER
DIM SHARED n AS INTEGER
DIM SHARED z AS INTEGER
DIM SHARED v AS INTEGER
DIM SHARED l(1 TO 40) AS STRING
DIM SHARED inc AS INTEGER

0 INPUT "Speed(1-10)"; Wit
IF Wit = 1 THEN
        Wit = 60000
ELSEIF Wit = 2 THEN
        Wit = 50000
ELSEIF Wit = 3 THEN
        Wit = 40000
ELSEIF Wit = 4 THEN
        Wit = 30000
ELSEIF Wit = 5 THEN
        Wit = 25000
ELSEIF Wit = 6 THEN
        Wit = 20000
ELSEIF Wit = 7 THEN
        Wit = 15000
ELSEIF Wit = 8 THEN
        Wit = 10000
ELSEIF Wit = 9 THEN
        Wit = 5000
ELSEIF Wit = 10 THEN
        Wit = 0
ELSE
        GOTO 0
END IF

CLS

'Smiley
CIRCLE (120, 20), 3, 10: PAINT (120, 20), 10: CIRCLE (120, 20), 2, 0, 3.5, 5.5
CIRCLE (119, 18), 0, 0: CIRCLE (121, 18), 0, 0
'Head
CIRCLE (20, 20), 3, 14: PAINT (20, 20), 14
'Tail.Down
LINE (37, 23)-(43, 23), 14: LINE (37, 23)-(40, 17), 14
LINE (40, 17)-(43, 23), 14: PAINT (40, 20), 14
'Tail.Up
LINE (77, 17)-(83, 17), 14: LINE (77, 17)-(80, 23), 14
LINE (83, 17)-(80, 23), 14: PAINT (80, 20), 14
'Tail.Left
LINE (57, 17)-(57, 23), 14: LINE (57, 17)-(63, 20), 14
LINE (57, 23)-(63, 20), 14: PAINT (60, 20), 14
'Tail.Right
LINE (103, 23)-(103, 17), 14: LINE (103, 23)-(97, 20), 14
LINE (103, 17)-(97, 20), 14: PAINT (100, 20), 14
'Block
LINE (137, 17)-(143, 23), 12, BF
'Get the pictures
GET (17, 17)-(23, 23), face
GET (37, 17)-(43, 23), tail.b
GET (57, 17)-(63, 23), tail.l
GET (77, 17)-(83, 23), tail.f
GET (97, 17)-(103, 23), tail.r
GET (117, 17)-(123, 23), smiley
GET (17, 107)-(23, 113), nothing
GET (137, 17)-(143, 23), block
level = 10: points = 0: life = 5
length = 5: n = 1: z = 0: v = level
CALL MakeLevel
Continue:

DO
 FOR I = 1 TO Wit
 NEXT

 v = level
 LOCATE 1, 1
 PRINT "     Level:"; level; "   Points:"; points; "   Lives:"; life

 IF n <> z THEN
  DO
   x = ((INT(RND * 48) + 1) * 7) + 26
   y = ((INT(RND * 40) + 1) * 7) + 32
   IF x = 33 THEN x = 40
   IF y = 39 THEN y = 46
  LOOP UNTIL MID$(l((y - 32) / 7), (x - 26) / 7, 1) <> "*"
 END IF
 PUT (x, y), smiley, PSET
 z = n
 w = w + 1
 IF w = 10000 THEN
  w = 1 + length
  g = 9999 - length
  FOR I = 1 TO length
   g = g + 1
   tail.o(I) = tail.o(g)
   tail.u(I) = tail.u(g)
   tail.d(I) = tail.d(g)
  NEXT I
 END IF

 tail.u(w) = up: tail.o(w) = over: tail.d(w) = dir
 o = over: u = up

 IF dir = 24 AND POINT(over - 3, up + 3) <> 0 AND POINT(over - 3, up + 3) <> 10 THEN GOSUB HitSomething
 IF dir = 25 AND POINT(over + 3, up - 3) <> 0 AND POINT(over + 3, up - 3) <> 10 THEN GOSUB HitSomething
 IF dir = 26 AND POINT(over + 9, up + 3) <> 0 AND POINT(over + 9, up + 3) <> 10 THEN GOSUB HitSomething
 IF dir = 34 AND POINT(over + 3, up + 9) <> 0 AND POINT(over + 3, up + 9) <> 10 THEN GOSUB HitSomething
 IF dir = 24 THEN over = over - 7
 IF dir = 25 THEN up = up - 7
 IF dir = 26 THEN over = over + 7
 IF dir = 34 THEN up = up + 7

 PUT (over, up), face, PSET
 t = t + 1
 IF t > 1 THEN
  PUT (tail.o(w - length), tail.u(w - length)), nothing, PSET
  IF tail.d((w - length) + 1) = 24 THEN
   PUT (tail.o((w - length) + 1), tail.u((w - length) + 1)), tail.l, PSET
  END IF
  IF tail.d((w - length) + 1) = 26 THEN
   PUT (tail.o((w - length) + 1), tail.u((w - length) + 1)), tail.r, PSET
  END IF
  IF tail.d((w - length) + 1) = 25 THEN
   PUT (tail.o((w - length) + 1), tail.u((w - length) + 1)), tail.f, PSET
  END IF
  IF tail.d((w - length) + 1) = 34 THEN
   PUT (tail.o((w - length) + 1), tail.u((w - length) + 1)), tail.b, PSET
  END IF
 END IF

 key$ = INKEY$
 SELECT CASE key$
  CASE CHR$(0) + "H": IF dir <> 34 THEN dir = 25
  CASE CHR$(0) + "P": IF dir <> 25 THEN dir = 34
  CASE CHR$(0) + "K": IF dir <> 26 THEN dir = 24
  CASE CHR$(0) + "M": IF dir <> 24 THEN dir = 26
 END SELECT

 IF over = x AND up = y THEN
  n = n + 1
  length = length + inc
  t = -inc + 1
  points = points + 100
 END IF

 IF n = 11 THEN
  level = level + 1: life = life + 2
  length = 5: n = 1: z = 0
  MakeLevel
  GOSUB Continue
 END IF

 FOR f! = 1 TO speed
  WAIT &H3DA, 8
 NEXT f!
LOOP UNTIL key$ = CHR$(27)
END

HitSomething:
 life = life - 1
 points = points - 200
 IF life = 0 THEN GOSUB Lost
 LOCATE 11, 20: PRINT "Press  Enter"
 WHILE INKEY$ <> CHR$(13): WEND
 LOCATE 11, 20: PRINT "            "
MakeLevel
GOSUB Continue

Lost:
SYSTEM

SUB MakeLevel
CLS

IF level = 1 THEN
 dir = 25: speed = 91: w = 1: t = -length: z = n - 1: inc = 5
 FOR I = 1 TO 38
  l$(I + 1) = "*                                              *"
 NEXT I
 l$(20) = "*     S       *******************              *"
 l$(1) = "************************************************"
 l$(40) = "************************************************"
END IF

IF level = 2 THEN
 dir = 25: speed = 81: w = 1: t = -length: z = n - 1: inc = 6
 FOR I = 1 TO 32
  l$(I + 4) = "*             *                  *             *"
 NEXT I
 l$(30) = "*             *         S        *             *"
 l$(1) = "************************************************"
 l$(2) = "*                                              *"
 l$(3) = "*                                              *"
 l$(4) = "*                                              *"
 l$(37) = "*                                              *"
 l$(38) = "*                                              *"
 l$(39) = "*                                              *"
 l$(40) = "************************************************"
END IF

IF level = 3 THEN
 dir = 26: speed = 71: w = 1: t = -length: z = n - 1: inc = 7
 FOR I = 1 TO 38
  l$(I + 1) = "*                                              *"
 NEXT I
 l$(1) = "************************************************"
 l$(8) = "*          **                      **          *"
 l$(9) = "*          **                      **          *"
 l$(18) = "*       **                            **       *"
 l$(19) = "*       **                            **       *"
 l$(20) = "*        ***                        ***        *"
 l$(21) = "*          **                      **          *"
 l$(22) = "*           **                    **           *"
 l$(23) = "*            ***                ***            *"
 l$(24) = "*              **              **              *"
 l$(25) = "*               *****      *****               *"
 l$(26) = "*                   ********                   *"
 l$(33) = "*    S                                         *"
 l$(40) = "************************************************"
END IF

IF level = 4 THEN
 dir = 24: speed = 71: w = 1: t = -length: z = n - 1: inc = 7
 FOR I = 1 TO 38
  l$(I + 1) = "*                                              *"
 NEXT I
 l$(1) = "************************************************"
 l$(20) = "* * * * * * * * * * * * * * * * * * * * * * * **"
 l$(38) = "*                                        S     *"
 l$(40) = "************************************************"
END IF

IF level = 5 THEN
 dir = 34: speed = 71: w = 1: t = -length: z = n - 1: inc = 8
 FOR I = 1 TO 38
  l$(I + 1) = "*                                              *"
 NEXT I
 FOR I = 1 TO 36
  MID$(l$(I + 2), I + 6, 1) = "*"
 NEXT I
 l$(1) = "************************************************"
 MID$(l$(2), 4, 1) = "S"
 l$(40) = "************************************************"
END IF

IF level = 6 THEN
 dir = 25: speed = 71: w = 1: t = -length: z = n - 1: inc = 8
 FOR I = 1 TO 38
  l$(I + 1) = "*                                              *"
 NEXT I
 FOR I = 1 TO 34
  l$(I + 3) = "*   *   *   *   *   *  **  *   *   *   *   *   *"
 NEXT I
 l$(1) = "************************************************"
 l$(34) = "*   *   *   *   * S *  **  *   *   *   *   *   *"
 l$(40) = "************************************************"
END IF

IF level = 7 THEN
 dir = 26: speed = 61: w = 1: t = -length: z = n - 1: inc = 8
 FOR I = 1 TO 17
  l$(I + 1) = "*          *           *           *           *"
 NEXT I
 FOR I = 1 TO 17
  l$(I + 22) = "*          *           *           *           *"
 NEXT I
 l$(1) = "************************************************"
 l$(21) = "*     S                                        *"
 l$(40) = "************************************************"
END IF

IF level = 8 THEN
 dir = 26: speed = 71: w = 1: t = -length: z = n - 1: inc = 8
 FOR I = 1 TO 38
  l$(I + 1) = "*                                              *"
 NEXT I
 l$(1) = "************************************************"
 l$(4) = "*   S                                          *"
 l$(13) = "* * * * * * * * * * * * * * * * * * * * * * * **"
 l$(20) = "** * * * * * * * * * * * * * * * * * * * * * * *"
 l$(27) = "* * * * * * * * * * * * * * * * * * * * * * * **"
 l$(40) = "************************************************"
END IF

IF level = 9 THEN
 dir = 25: speed = 61: w = 1: t = -length: z = n - 1: inc = 9
 FOR I = 1 TO 38
  l$(I + 1) = "*          *           **           *          *"
 NEXT I
 l$(1) = "************************************************"
  l$(8) = "*          *                        *          *"
 l$(32) = "*                      **     S                *"
 l$(40) = "************************************************"
END IF

IF level = 10 THEN
 dir = 25: speed = 71: w = 1: t = -length: z = n - 1: inc = 9
 FOR I = 1 TO 38
  l$(I + 1) = "*                                              *"
 NEXT I
  l$(1) = "************************************************"
  l$(5) = "*   ****************************************   *"
 l$(10) = "*   ******************    ******************   *"
 l$(11) = "*                    *    *                    *"
 l$(12) = "*                    *    *                    *"
 l$(13) = "*                    *    *                    *"
 l$(14) = "*                    *    *                    *"
 l$(15) = "*   *************    *    *    *************   *"
 l$(16) = "*               *    *    *    *               *"
 l$(17) = "*               *    *    *    *               *"
 l$(18) = "*               *    *    *    *               *"
 l$(19) = "*               *    *    *    *               *"
 l$(20) = "*   ********    *    *    *    *    ********   *"
 l$(21) = "*          *    *    *    *    *    *          *"
 l$(22) = "*          *    *    *    *    *    *          *"
 l$(23) = "*          *    *    *    *    *    *          *"
 l$(24) = "*          *    *    *    *    *    *          *"
 l$(25) = "*   ***    *    *    *    *    *    *    ***   *"
 l$(26) = "*     *    *    *    *    *    *    *    *     *"
 l$(27) = "*     *    *    *    *    *    *    *    *     *"
 l$(28) = "*     *    *    *    *    *    *    *    *     *"
 l$(29) = "*     *    *    *    *    *    *    *    *     *"
 FOR I = 1 TO 6
  l$(I + 29) = "*   * *    *    *    *    *    *    *    * *   *"
 NEXT I
 l$(38) = "*                       S                      *"
 l$(40) = "************************************************"
END IF

IF level = 11 THEN
 dir = 26: speed = 71: w = 1: t = -length: z = n - 1: inc = 10
 FOR I = 1 TO 38
  l$(I + 1) = "*                                              *"
 NEXT I
 FOR I = 4 TO 36 STEP 8
  l$(I) = "*      *****************************************"
 NEXT I
 FOR I = 8 TO 40 STEP 8
  l$(I) = "*****************************************      *"
 NEXT I
 l$(1) = "************************************************"
 l$(2) = "*   S                                          *"
 l$(40) = "************************************************"
END IF

IF level = 12 THEN
 dir = 25: speed = 71: w = 1: t = -length: z = n - 1: inc = 11
 FOR I = 1 TO 38
  l$(I + 1) = "*                                              *"
 NEXT I
 FOR I = 5 TO 15
  l$(I + 1) = "*  *                  *  *                  *  *"
 NEXT I
 FOR I = 23 TO 33
  l$(I + 1) = "*  *                  *  *                  *  *"
 NEXT I
  l$(1) = "************************************************"
  l$(4) = "*    ****************      ****************    *"
 l$(18) = "*    ****************      ****************    *"
 l$(22) = "*    ****************      ****************    *"
 l$(36) = "*    ****************   S  ****************    *"
 l$(40) = "************************************************"
END IF

IF level = 13 THEN
 dir = 26: speed = 71: w = 1: t = -length: z = n - 1: inc = 11
 FOR I = 1 TO 38
  l$(I + 1) = "*                                              *"
 NEXT I
 FOR I = 1 TO 36
  l$(I + 2) = "*                      *                       *"
 NEXT I
 FOR I = 1 TO 36
  MID$(l$(I + 2), I + 6, 1) = "*"
 NEXT I
 k = 2
 FOR I = 41 TO 6 STEP -1
  k = k + 1
  MID$(l$(k), I, 1) = "*"
 NEXT I
  l$(1) = "************************************************"
 l$(20) = "*  ******************************************  *"
 MID$(l$(39), 4, 1) = "S"
 l$(40) = "************************************************"
END IF

IF level = 14 THEN
 dir = 25: speed = 71: w = 1: t = -length: z = n - 1: inc = 11
 FOR I = 1 TO 38
  l$(I + 1) = "*                                              *"
 NEXT I
 FOR I = 1 TO 34
  l$(I + 3) = "*                      *                       *"
 NEXT I
 FOR I = 1 TO 38 STEP 3
  l$(I + 1) = "*   ****************************************   *"
 NEXT I
  l$(1) = "************************************************"
 l$(38) = "*                                              *"
 l$(39) = "* S ****************************************   *"
 l$(40) = "************************************************"
END IF

IF level = 15 THEN
 dir = 25: speed = 81: w = 1: t = -length: z = n - 1: inc = 9
 FOR I = 1 TO 38
  l$(I + 1) = "*    *           *           *           *     *"
 NEXT I
 FOR I = 1 TO 38 STEP 2
  l$(I + 2) = "*          *           *           *           *"
 NEXT I
 l$(1) = "************************************************"
 l$(20) = "* * * * * * * * * * * * * * * * * * * * * * * **"
 MID$(l$(37), 4, 1) = "S"
 l$(40) = "************************************************"
END IF

IF level = 16 THEN
 LOCATE 11, 22: PRINT "YOU  WON"
 WHILE INKEY$ <> CHR$(13): WEND
 LOCATE 11, 22: PRINT "        "
 SYSTEM
END IF

IF level <> v THEN
 LOCATE 11, 16: PRINT "You Beat This Level!"
 WHILE INKEY$ <> CHR$(13): WEND
 LOCATE 11, 16: PRINT "                    "
END IF

FOR j = 1 TO 40
 FOR e = 1 TO 48
  IF MID$(l$(j), e, 1) = "*" THEN PUT ((e * 7) + 26, (j * 7) + 32), block
  IF MID$(l$(j), e, 1) = "S" THEN over = ((e * 7) + 26): up = ((j * 7) + 32)
 NEXT e
NEXT j

speed = speed / 2


END SUB

