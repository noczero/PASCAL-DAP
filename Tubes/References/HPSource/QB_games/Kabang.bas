'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º                                                       º
'º                                                       º
'º    *   *            Mr. Smiley              *   *     º
'º                      (Kabang)                         º
'º   *     *                                  *     *    º
'º    *****       Made by Steve Nunnally       *****     º
'º                                                       º
'º                         º                             º
'º                        ÀÄÙ                            º
'º                                                       º
'ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
'º                                                       º
'º This time Mr. Smiley has been brainwashed by the evil º
'º Mr. Robber. You must save him and not let him blow up º
'º the city, save Mr. Smiley, good luck!!!!!!            º
'º Anyways I hope you like it. For any questions or tips º
'º e-mail at nunnally@pinn.net Please visit my homepage  º
'º http://www.pinn.net/~nunnally Thank You.              º
'º                              -Steve Nunnally          º
'º                                                       º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
'
'   This program was made by Steve Nunnally. Copyright (C) 1997
'All of this code was written by me, Steve Nunnally. DO NOT copy
'this code unless you have my permission! And you MAY NOT change
'the name in this paragraph to your name.     
'
DEFINT A-Z
DECLARE SUB Mouse (cx, dx, bx)
DECLARE SUB MousePointer (SW)
DIM SHARED a(9)
DIM SHARED over AS INTEGER
DIM SHARED mover AS INTEGER
DIM SHARED paddles AS INTEGER
DIM SHARED col(1 TO 50) AS INTEGER
DIM SHARED row(1 TO 50) AS INTEGER
DIM SHARED n AS INTEGER
DIM SHARED paddle(600)
DIM SHARED bomber(2000)
DIM SHARED bomb(600)
DIM SHARED drop AS INTEGER
DIM SHARED bombs AS INTEGER
DIM SHARED hard AS INTEGER
DIM SHARED guyhard AS INTEGER
DIM SHARED level AS INTEGER
DIM SHARED score AS INTEGER
DIM SHARED worth AS INTEGER
DIM SHARED s AS INTEGER
CLS : SCREEN 12
RANDOMIZE TIMER
'Your Paddle
LINE (30, 30)-(70, 40), 6, BF
LINE (25, 34)-(75, 45), 6, BF
LINE (27, 34)-(27, 45), 0
LINE (32, 30)-(32, 45), 0
LINE (37, 30)-(37, 45), 0
LINE (42, 30)-(42, 45), 0
LINE (47, 30)-(47, 45), 0
LINE (52, 30)-(52, 45), 0
LINE (57, 30)-(57, 45), 0
LINE (62, 30)-(62, 45), 0
LINE (67, 30)-(67, 45), 0
LINE (72, 30)-(72, 45), 0
LINE (77, 34)-(77, 45), 0
'The Bad Guy
CIRCLE (200, 30), 20, 15
PAINT (200, 30), 15
LINE (183, 20)-(217, 28), 0, BF
CIRCLE (190, 24), 3, 15
CIRCLE (210, 24), 3, 15
LINE (187, 40)-(213, 60), 15, BF
LINE (170, 55)-(230, 95), 8, BF
LINE (168, 96)-(232, 106), 6, BF
LINE (195, 40)-(206, 40), 0
LINE (180, 65)-(180, 95), 0
LINE (220, 65)-(220, 95), 0
LINE (171, 60)-(229, 65), 0, BF
LINE (171, 70)-(229, 75), 0, BF
LINE (171, 80)-(229, 85), 0, BF
'The Bomb
CIRCLE (450, 50), 53, 15, 2.6, 3.2
CIRCLE (400, 50), 15, 14: PAINT (400, 50), 14
CIRCLE (400, 50), 11, 0, 3, .1
CIRCLE (394, 44), 3, 0: CIRCLE (406, 44), 3, 0
CIRCLE (405, 23), 3, 4: PAINT (405, 23), 4
'Get the pretty pictures
GET (25, 30)-(75, 45), paddle
GET (170, 10)-(230, 106), bomber
GET (385, 20)-(415, 65), bomb
CLS
DEF SEG = VARSEG(a(0))
FOR i = 0 TO 17
 READ r
 POKE VARPTR(a(0)) + i, r
NEXT i
CALL MousePointer(0)
CALL MousePointer(3)
paddles = 3: over = 310: mover = 350: n = 0: drop = 35: q = 0: score = 0
level = 1: bombs = 11: hard = 5: guyhard = 13: worth = 1: s = 1000
GroveIt:
CLS
n = 0: q = 0: z = 0
PUT (mover, 25), bomber: PUT (over, 400), paddle
IF paddles > 1 THEN PUT (over, 430), paddle, XOR
IF paddles > 2 THEN PUT (over, 460), paddle, XOR
COLOR 15: LOCATE 1, 7: PRINT "Score :"
LOCATE 1, 15: PRINT score
GOSUB SetUp

DO
 g = over
 CALL Mouse(cx, dx, bx)
 over = dx
 IF over > 580 THEN over = 580
 IF over <> g THEN
  PUT (g, 400), paddle, XOR
  IF paddles > 1 THEN PUT (g, 430), paddle, XOR
  IF paddles > 2 THEN PUT (g, 460), paddle, XOR
  PUT (over, 400), paddle
  IF paddles > 1 THEN PUT (over, 430), paddle
  IF paddles > 2 THEN PUT (over, 460), paddle
 END IF
 y = INT(RND * guyhard) + 1
 IF y = 1 OR y = 2 THEN
  PUT (mover, 25), bomber, XOR
  IF y = 1 THEN mover = mover + 50
  IF y = 2 THEN mover = mover - 50
  IF mover < 0 THEN mover = 0
  IF mover > 550 THEN mover = 550
  PUT (mover, 25), bomber
 END IF
 z = z + 1
 IF z = drop THEN
  q = q + 1: n = n + 1
  IF q = bombs + 1 THEN GOSUB NextLevel
  IF n > 20 THEN n = 1
  IF q < bombs THEN
   row(n) = 150: col(n) = mover + 22
   PUT (col(n), row(n)), bomb
  END IF
  z = 0
 END IF
 i = 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
 i = i + 1
 IF col(i) <> 640 AND row(i) <> 479 THEN PUT (col(i), row(i)), bomb, XOR
 IF row(i) < 460 THEN row(i) = row(i) + hard
 IF POINT(col(i) + 15, row(i) + 35) = 6 OR POINT(col(i) + 16, row(i) + 35) = 6 THEN col(i) = 640: row(i) = 479: score = score + worth
 IF col(i) <> 640 AND row(i) > 434 THEN col(i) = 640: row(i) = 479: score = score + worth: GOSUB YouMissed
 IF row(i) < 460 THEN PUT (col(i), row(i)), bomb
COLOR 15: LOCATE 1, 15: PRINT score
COLOR 15: LOCATE 1, 7: PRINT "Score :"
 IF score >= s THEN
  s = s + 1000
  IF paddles < 3 THEN
   paddles = paddles + 1
   IF paddles = 2 THEN PUT (over, 430), paddle
   IF paddles = 3 THEN PUT (over, 460), paddle
  END IF
 END IF
 Pause! = TIMER
 WHILE TIMER < (Pause! + .00001 / 10000): WEND
 WAIT &H3DA, 8
LOOP

SetUp:
FOR w = 1 TO 50
 col(w) = 640
 row(w) = 479
NEXT w
RETURN

YouMissed:
COLOR 15: LOCATE 1, 15: PRINT score
COLOR 15: LOCATE 1, 7: PRINT "Score :"
LOCATE 20, 25: PRINT "   You Missed   "
LOCATE 21, 25: PRINT "Click Left Button"
IF paddles = 1 THEN PUT (over, 400), paddle, XOR
IF paddles = 1 THEN paddles = 0
IF paddles = 2 THEN paddles = 1
IF paddles = 3 THEN paddles = 2
IF paddles = 0 THEN SYSTEM
IF paddles = 1 THEN PUT (over, 430), paddle, XOR
IF paddles = 2 THEN PUT (over, 460), paddle, XOR
level = level - 1
IF level < 0 THEN level = 0
DO
 g = over
 CALL Mouse(cx, dx, bx)
 over = dx
 IF over > 580 THEN over = 580
 IF over <> g THEN
  PUT (g, 400), paddle, XOR
  IF paddles > 1 THEN PUT (g, 430), paddle, XOR
  IF paddles > 2 THEN PUT (g, 460), paddle, XOR
  PUT (over, 400), paddle
  IF paddles > 1 THEN PUT (over, 430), paddle
  IF paddles > 2 THEN PUT (over, 460), paddle
 END IF
LOOP UNTIL bx = 1
LOCATE 20, 25: PRINT "                 "
LOCATE 21, 25: PRINT "                 "
GOSUB NextLevel2

NextLevel:
COLOR 15: LOCATE 1, 15: PRINT score
COLOR 15: LOCATE 1, 7: PRINT "Score :"
LOCATE 21, 25: PRINT "Click Left Button"
DO
 g = over
 CALL Mouse(cx, dx, bx)
 over = dx
 IF over > 580 THEN over = 580
 IF over <> g THEN
  PUT (g, 400), paddle, XOR
  IF paddles > 1 THEN PUT (g, 430), paddle, XOR
  IF paddles > 2 THEN PUT (g, 460), paddle, XOR
  PUT (over, 400), paddle
  IF paddles > 1 THEN PUT (over, 430), paddle
  IF paddles > 2 THEN PUT (over, 460), paddle
 END IF
LOOP UNTIL bx = 1
LOCATE 21, 25: PRINT "                 "
NextLevel2:
IF level = 9 THEN drop = 1: level = 9: bombs = 201: hard = 28: guyhard = 2: worth = 65
IF level = 8 THEN drop = 2: level = 9: bombs = 151: hard = 28: guyhard = 2: worth = 65
IF level = 7 THEN drop = 4: level = 8: bombs = 126: hard = 23: guyhard = 4: worth = 50
IF level = 6 THEN drop = 6: level = 7: bombs = 71: hard = 18: guyhard = 6: worth = 35
IF level = 5 THEN drop = 10: level = 6: bombs = 56: hard = 15: guyhard = 7: worth = 25
IF level = 4 THEN drop = 15: level = 5: bombs = 41: hard = 12: guyhard = 8: worth = 20
IF level = 3 THEN drop = 15: level = 4: bombs = 26: hard = 10: guyhard = 9: worth = 10
IF level = 2 THEN drop = 20: level = 3: bombs = 21: hard = 9: guyhard = 10: worth = 5
IF level = 1 THEN drop = 25: level = 2: bombs = 16: hard = 7: guyhard = 11: worth = 2
IF level = 0 THEN drop = 35: level = 1: bombs = 11: hard = 5: guyhard = 13: worth = 1
GOSUB GroveIt

DATA &HB8,&H00,&H00   :
DATA &H55             :
DATA &H8B,&HEC        :
DATA &HCD,&H33        :
DATA &H92             :
DATA &H8B,&H5E,&H06   :
DATA &H89,&H07        :
DATA &H5D             :
DATA &HCA,&H02,&H00   :

SUB Mouse (cx, dx, bx)
 POKE VARPTR(a(4)), &H92
CALL absolute(cx, VARPTR(a(0)))
    cx = cx '/ 8                
 POKE VARPTR(a(4)), &H91
CALL absolute(dx, VARPTR(a(0)))
    dx = dx '/ 8                
 POKE VARPTR(a(4)), &H93
CALL absolute(bx, VARPTR(a(0)))
END SUB

SUB MousePointer (SW)
 POKE VARPTR(a(0)) + 1, SW
CALL absolute(c, VARPTR(a(0)))
END SUB

