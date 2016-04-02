REM **********************************************
REM            More Qbasic Software at
REM       http://www.euronet.nl/users/rkohm/
REM          Any questions? E-mail to:
REM              rkohm@euronet.nl
REM **********************************************

DECLARE SUB swapbox (which!)
DECLARE SUB check ()
DECLARE SUB game ()
DECLARE SUB move (whereto!)
DECLARE SUB fieldsetup ()
DECLARE SUB background ()

COMMON SHARED x, y, xcoor, ycoor, xold, yold, loca, sound$

CLS : SCREEN 12
xcoor = 363: ycoor = 163: loca = 1

ON KEY(10) GOSUB endofgame
KEY(10) ON

DIM SHARED square1(200), square2(200), square3(200), square4(200)
DIM SHARED square5(200), square6(200), square7(200), square8(200)
DIM SHARED square9(200), square10(200), square11(200), square12(200)
DIM SHARED square13(200), square14(200), square15(200), square16(200)
DIM SHARED box(16), theone(200)

RANDOMIZE TIMER
FOR temp = 1 TO 16
again:
 DO: place = FIX(RND * 16 + 1): LOOP UNTIL 1 <= place <= 16
 IF box(place) <> 0 THEN GOTO again
 box(place) = temp
NEXT

'FOR sed = 1 TO 16
' box(sed) = sed
'NEXT
'box(5) = 1: box(1) = 5

background
fieldsetup

DO
 game
 check
LOOP


END

endofgame:
END

SUB background
LOCATE 10, 23: PRINT "Select a background for the puzzle: (1-3)"
LOCATE 11, 28: PRINT "1. House"
LOCATE 12, 28: PRINT "2. Boat"
LOCATE 13, 28: PRINT "3. Car"
DO: user$ = INKEY$: LOOP UNTIL user$ = "1" OR user$ = "2" OR user$ = "3"
CLS
DRAW "bm280,330u176l176d176r176bh8u160l160d160r160bfp15,15h"  'square 1

SELECT CASE user$
CASE "1"
 DRAW "bl45bu10p9,15c14u70l100d70r100bhp14,14fu70c4h50g50r100h4blp4,4rh10c6u40l20d20"
 DRAW "f20u4blp6,6rbg70bd16c1u40r30d40l30bep1,1gbe20br25c2u30r30d30l30bep2,2g"
 DRAW "br83l43d23l102u23l13d31r158u31bgp2,2"
 CIRCLE (245, 200), 20, 14: PAINT (245, 200), 14, 14   'house
CASE "2"
 DRAW "bhp9,15c1u30l160d30r160bhp1,1f2"
 DRAW "bl55c14be15e35l150f35r80bhp14,14fl15u36c6u90l10d90r10bhp6,6fu10c8r50"
 LINE STEP(0, 0)-(218, 190), 8: DRAW "d70bep8,8": LINE (206, 190)-(120, 262), 8
 DRAW "r86u70d5blp8,8ru5bd100br15": CIRCLE STEP(0, 0), 5, 2: DRAW "p2,2bl30"
 CIRCLE STEP(0, 0), 5, 2: DRAW "p2,2bl30": CIRCLE STEP(0, 0), 5, 2: DRAW "p2,2"
 CIRCLE (250, 190), 15, 14: PAINT STEP(0, 0), 14, 14   'boat
CASE "3"
 DRAW "bhp9,15c2u35l160d35r160bhp2,2": CIRCLE (160, 280), 18, 8: DRAW "p8,8"
 CIRCLE (225, 280), 18, 8: DRAW "p8,8": CIRCLE (160, 280), 8, 7: DRAW "p7,7"
 CIRCLE (225, 280), 8, 7: DRAW "p7,7"
 DRAW "bm267,320c12bh40r35u30l30h20l40g20l30d30r140bh30bl5"
 DRAW "p12,12c8h15l20d15r35l2bup8,8dbl38u15l10g15r25bhp8,8fc0bu21br10h35bh"
 CIRCLE STEP(0, 0), 2, 0: DRAW "p0,0": CIRCLE (230, 190), 15, 14: DRAW "p14,14"
END SELECT

DRAW "bm112,162c15r160d160l160u160r40d160r40u160r40d160r40u40l160u40r160u40l160"

DRAW "bm530,330u176l176d176r176bh8u160l160d160r160bfp15,15h"  'square 2
DRAW "bm362,162c15r160d160l160u160r40d160r40u160r40d160r40u40l160u40r160u40l160"


DRAW "bm133,183p0,15"'bm1,1p4,15"
GET (113, 163)-(151, 201), square1
GET (153, 163)-(191, 201), square2
GET (193, 163)-(231, 201), square3
GET (233, 163)-(271, 201), square4
GET (113, 203)-(151, 241), square5
GET (153, 203)-(191, 241), square6
GET (193, 203)-(231, 241), square7
GET (233, 203)-(271, 241), square8
GET (113, 243)-(151, 281), square9
GET (153, 243)-(191, 281), square10
GET (193, 243)-(231, 281), square11
GET (233, 243)-(271, 281), square12
GET (113, 283)-(151, 321), square13
GET (153, 283)-(191, 321), square14
GET (193, 283)-(231, 321), square15
GET (233, 283)-(271, 321), square16

LOCATE 5, 20: COLOR 14: PRINT "F10"; : COLOR 15: PRINT " Exit"
LOCATE 6, 20: COLOR 14: PRINT "(Arrow keys on the Number Pad)";
COLOR 15: PRINT " Move Red Box"
LOCATE 7, 20: COLOR 14: PRINT "Enter"; : COLOR 15: PRINT " Move a piece to the empty place."

LOCATE 23, 6: PRINT "Move the pieces until you have completed the puzzle. You can only move"
LOCATE 24, 6: PRINT "pieces to the empty (black) place. "

COLOR 14: LOCATE 27, 33: PRINT "by Robin Ohm"
LINE (140, 60)-(500, 115), 15, B
LINE (30, 347)-(610, 390), 15, B
LINE (250, 413)-(355, 436), 15, B
PAINT (1, 1), 8, 15
LINE (140, 60)-(500, 115), 4, B
LINE (30, 347)-(610, 390), 4, B
LINE (250, 413)-(355, 436), 4, B
END SUB

SUB check
FOR rgt = 1 TO 16
 IF box(rgt) <> rgt THEN EXIT SUB
NEXT
COLOR 14: LOCATE 26, 5: PRINT "Congratulations!! You have completed the puzzle!!"
COLOR 4: END
END SUB

SUB fieldsetup
FOR temp = 1 TO 16
move temp
SELECT CASE box(temp)
 CASE 1: PUT (x, y), square1, PSET
 CASE 2: PUT (x, y), square2, PSET
 CASE 3: PUT (x, y), square3, PSET
 CASE 4: PUT (x, y), square4, PSET
 CASE 5: PUT (x, y), square5, PSET
 CASE 6: PUT (x, y), square6, PSET
 CASE 7: PUT (x, y), square7, PSET
 CASE 8: PUT (x, y), square8, PSET
 CASE 9: PUT (x, y), square9, PSET
 CASE 10: PUT (x, y), square10, PSET
 CASE 11: PUT (x, y), square11, PSET
 CASE 12: PUT (x, y), square12, PSET
 CASE 13: PUT (x, y), square13, PSET
 CASE 14: PUT (x, y), square14, PSET
 CASE 15: PUT (x, y), square15, PSET
 CASE 16: PUT (x, y), square16, PSET
END SELECT
NEXT
END SUB

SUB game
xold = xcoor: yold = ycoor
LINE (xcoor - 1, ycoor - 1)-(xcoor + 39, ycoor + 39), 4, B
DO: userinput$ = INKEY$: LOOP UNTIL userinput$ <> ""
SELECT CASE userinput$
CASE "8"
 IF ycoor > 163 THEN
  ycoor = ycoor - 40
  loca = loca - 4
  sound$ = "no"
 END IF
CASE "6"
  IF xcoor < 483 THEN
   xcoor = xcoor + 40
   loca = loca + 1
   sound$ = "no"
  END IF
CASE "2"
 IF ycoor < 283 THEN
  ycoor = ycoor + 40
  loca = loca + 4
  sound$ = "no"
 END IF
CASE "4"
 IF xcoor > 363 THEN
  xcoor = xcoor - 40
  loca = loca - 1
  sound$ = "no"
 END IF
CASE CHR$(13)
 SELECT CASE loca
  CASE 1
   IF box(loca + 1) = 1 THEN swapbox 1
   IF box(loca + 4) = 1 THEN swapbox 4
  CASE 2, 3
   IF box(loca - 1) = 1 THEN swapbox -1
   IF box(loca + 1) = 1 THEN swapbox 1
   IF box(loca + 4) = 1 THEN swapbox 4
  CASE 4
   IF box(loca - 1) = 1 THEN swapbox -1
   IF box(loca + 4) = 1 THEN swapbox 4
  CASE 5, 9
   IF box(loca + 1) = 1 THEN swapbox 1
   IF box(loca - 4) = 1 THEN swapbox -4
   IF box(loca + 4) = 1 THEN swapbox 4
  CASE 6, 7, 10, 11
   IF box(loca - 1) = 1 THEN swapbox -1
   IF box(loca + 1) = 1 THEN swapbox 1
   IF box(loca - 4) = 1 THEN swapbox -4
   IF box(loca + 4) = 1 THEN swapbox 4
  CASE 8, 12
   IF box(loca - 1) = 1 THEN swapbox -1
   IF box(loca - 4) = 1 THEN swapbox -4
   IF box(loca + 4) = 1 THEN swapbox 4
  CASE 13
   IF box(loca + 1) = 1 THEN swapbox 1
   IF box(loca - 4) = 1 THEN swapbox -4
  CASE 14, 15
   IF box(loca - 1) = 1 THEN swapbox -1
   IF box(loca + 1) = 1 THEN swapbox 1
   IF box(loca - 4) = 1 THEN swapbox -4
  CASE 16
   IF box(loca - 1) = 1 THEN swapbox -1
   IF box(loca - 4) = 1 THEN swapbox -4
 END SELECT
END SELECT
IF sound$ = "" THEN PLAY "L30GC"
sound$ = ""
LINE (xold - 1, yold - 1)-(xold + 39, yold + 39), 15, B
LINE (xcoor - 1, ycoor - 1)-(xcoor + 39, ycoor + 39), 4, B
END SUB

SUB move (whereto)
SELECT CASE whereto
 CASE 1: x = 363: y = 163
 CASE 2: x = 403: y = 163
 CASE 3: x = 443: y = 163
 CASE 4: x = 483: y = 163
 CASE 5: x = 363: y = 203
 CASE 6: x = 403: y = 203
 CASE 7: x = 443: y = 203
 CASE 8: x = 483: y = 203
 CASE 9: x = 363: y = 243
 CASE 10: x = 403: y = 243
 CASE 11: x = 443: y = 243
 CASE 12: x = 483: y = 243
 CASE 13: x = 363: y = 283
 CASE 14: x = 403: y = 283
 CASE 15: x = 443: y = 283
 CASE 16: x = 483: y = 283
END SELECT
END SUB

SUB swapbox (which)
sound$ = "no"
SELECT CASE which
 CASE -1: box(loca - 1) = box(loca): box(loca) = 1
 CASE 4: box(loca + 4) = box(loca): box(loca) = 1
 CASE 1: box(loca + 1) = box(loca): box(loca) = 1
 CASE -4: box(loca - 4) = box(loca): box(loca) = 1
END SELECT

DO
IF times = 0 THEN variable = loca + which
IF times = 1 THEN variable = loca

move variable
SELECT CASE box(variable)
 CASE 1: PUT (x, y), square1, PSET
 CASE 2: PUT (x, y), square2, PSET
 CASE 3: PUT (x, y), square3, PSET
 CASE 4: PUT (x, y), square4, PSET
 CASE 5: PUT (x, y), square5, PSET
 CASE 6: PUT (x, y), square6, PSET
 CASE 7: PUT (x, y), square7, PSET
 CASE 8: PUT (x, y), square8, PSET
 CASE 9: PUT (x, y), square9, PSET
 CASE 10: PUT (x, y), square10, PSET
 CASE 11: PUT (x, y), square11, PSET
 CASE 12: PUT (x, y), square12, PSET
 CASE 13: PUT (x, y), square13, PSET
 CASE 14: PUT (x, y), square14, PSET
 CASE 15: PUT (x, y), square15, PSET
 CASE 16: PUT (x, y), square16, PSET
END SELECT
times = times + 1
LOOP UNTIL times = 2
times = 0
END SUB

