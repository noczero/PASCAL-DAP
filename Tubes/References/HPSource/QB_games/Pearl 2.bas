DECLARE SUB info () : DECLARE SUB xwrite () : DECLARE SUB plan ()
info 'by Philipp Lenssen 96

CONST sp = .1, fo = 4, ba = 3, rad = 15, ml = 50, scg = 23, tyg = 13
DIM skl%(300), lt1%(300), lt2%(300), lt3%(300), lt4%(300), lt5%(300), lt6%(300)
DIM lt7%(300), c%(500), blp%(1000), shl%(70), fr1%(90), fr2%(90), fr3%(90)
DIM spz%(420), arrow%(1450), head%(500), leg1%(2425), leg2%(2425), btp%(500)
DIM btp2%(500), dev1%(1600), dev2%(1600), dev3%(1600), dev4%(1600), dev5%(1600), dev6%(1600)
DIM spy(6), cr(2), sdxo(6), sdxsp(6), sdx(6), sdy(6), wlt2(6), spx(6), nrt(scg, tyg) AS INTEGER
DIM kngu%(4000), kngd%(4000)
DIM SHARED posn, I(scg, tyg, 12, 2), t(13) AS INTEGER: DIM SHARED send AS STRING

GOSUB getready
start:

DO '_____________________________________________
IF x < x1 OR x > x2 OR neu% = 1 THEN GOSUB putall
GOSUB anim
GOSUB move
LOOP '___________________________________________

putall:
IF neu% = 1 THEN neu% = 0
IF x < x1 THEN x = x2: scr% = scr% - 1
IF x > x2 THEN x = x1: scr% = scr% + 1
CLS : PAINT (0, 0), ba, 1

IF scr% <= scg THEN
LINE (0, 465)-(639, 479), 1, BF

FOR typ% = 1 TO tyg
 
FOR nr = 1 TO nrt(scr%, typ%)
  FOR c = 1 TO 2
    cr(c) = I(scr%, typ%, nr, c)
  NEXT
  IF cr(1) = 13 THEN cr(1) = 0

SELECT CASE typ%
CASE 1: t(typ%) = 0: wlt% = 0
CASE 2: sdx(nr) = (cr(1) * ml + 6): sdy(nr) = (cr(2) * ml): sdxo(nr) = sdx(nr): sdxsp(nr) = 4: t(typ%) = 0
CASE 3: spx(nr) = (cr(1) * ml + 15): spy(nr) = (cr(2) * ml - 8): wlt2(nr) = 0: t(typ%) = 0
CASE 4: box(nr) = (cr(1) * ml + 1): boy(nr) = (cr(2) * ml): wlt6(nr) = 0: t(typ%) = 0
CASE 5: box2(nr) = (cr(1) * ml + 1): boy2(nr) = (cr(2) * ml): wlt62(nr) = 0: t(typ%) = 0
CASE 6: PUT (cr(1) * ml + 15, cr(2) * ml + 39), shl%, PSET: t(typ%) = 0
CASE 7: PUT (cr(1) * ml, cr(2) * ml), blp%, PSET
CASE 8: LINE (cr(1) * ml, cr(2) * ml)-(cr(1) * ml + 50, cr(2) * ml + 200), fo, BF
CASE 9: LINE (cr(1) * ml, cr(2) * ml)-(cr(1) * ml + 200, cr(2) * ml + 50), fo, BF
CASE 10: LINE (cr(1) * ml, 1)-(cr(1) * ml + 50, 479), fo, BF
CASE 11: LINE (0, cr(2) * ml)-(639, cr(2) * ml + 50), fo, BF
CASE 12: PUT (cr(1) * ml + 14, cr(2) * ml + 10), skl%, PSET: ascr% = scr%
CASE 13: kngx(nr) = (cr(1) * ml): wlt63(nr) = 0: t(typ%) = 0
END SELECT
NEXT

NEXT

IF scr% = scg THEN PUT (480, 50), arrow%, PSET
IF lives% = 0 THEN lives% = 3

DRAW "bm2,8"
FOR I% = 1 TO lives%
CIRCLE STEP(13, 0), 5, 1: PAINT STEP(0, 0), 9, 1
NEXT

ELSE
send = "          well done!             ": posn = 2: xwrite
send = "  thanks for playing pearl two.  ": posn = 3: xwrite
send = "       by philipp lenssen        ": posn = 7: xwrite
PLAY "mst200o3l4eefggfedccdel2el8dl2dl4eefggfedccdel2dl8cl2cl4ddecdl8efl4ecdl8efl4edcdl2<gmst200o3l2el4efggfedccdel2dl8cl2 c"
END
END IF
RETURN

move:
SELECT CASE INKEY$
 CASE CHR$(0) + "M": IF xsp < 1 THEN xsp = xsp + sp
 CASE CHR$(0) + "K": IF xsp > -1 THEN xsp = xsp - sp
 CASE CHR$(0) + "H": IF ysp > 0 THEN ysp = ysp + sp
 CASE CHR$(0) + "P": IF ysp < 0 AND ABS(ysp) > .4 THEN ysp = ysp + sp
 CASE CHR$(27): END
END SELECT

a1% = 2: a2% = 5
SELECT CASE fo
CASE POINT(x - rad - a1%, y - rad - a1%)
 IF xsp < 0 THEN xsp = xsp * -1
 IF ysp < 0 THEN ysp = ysp * -1
CASE POINT(x + rad + a1%, y - rad - a1%)
 IF xsp > 0 THEN xsp = xsp * -1
 IF ysp < 0 THEN ysp = ysp * -1
CASE POINT(x + rad + a1%, y + rad + a1%)
 IF xsp > 0 THEN xsp = xsp * -1
 IF ysp > 0 THEN ysp = ysp * -1
CASE POINT(x - rad - a1%, y + rad + a1%)
 IF xsp < 0 THEN xsp = xsp * -1
 IF ysp > 0 THEN ysp = ysp * -1
CASE POINT(x - rad - a2%, y): xsp = xsp * -1: IF ABS(xsp) < .3 THEN x = x + 1
CASE POINT(x + rad + a2%, y): xsp = xsp * -1: IF ABS(xsp) < .3 THEN x = x - 1
CASE POINT(x, y - rad - a2%): ysp = ysp * -1: IF ABS(ysp) < .3 THEN y = y + 1
CASE POINT(x, y + rad + a2%): ysp = ysp * -1: IF ABS(ysp) < .3 THEN y = y - 1
CASE ELSE: ysp = ysp + .01: nos% = 1
END SELECT

IF tx% > 0 THEN tx% = tx% - 1
IF nos% = 1 THEN
   nos% = 0
ELSEIF tx% = 0 THEN
SOUND 500, .1: tx% = 10
IF ABS(ysp) > 2.8 THEN
GOSUB boom
END IF
END IF

IF y < y1 OR y > y2 THEN
IF y < y1 THEN LINE (x - rad, y - rad)-(x + rad, y + rad), ba, BF
IF y > y2 THEN
CIRCLE (x, y + 20), 20, 1: PAINT (x, y + 15), 1, 1
FOR I% = 300 TO 200 STEP -8: SOUND I%, .1: NEXT
CIRCLE (x, y + 23), 38, 1: PAINT (x, y - 14), 1, 1
FOR I% = 200 TO 100 STEP -8: SOUND I%, .1: NEXT
LINE (x - 36, 439)-(x + 36, 464), 3, BF
END IF
GOSUB go
END IF

x = x + xsp: y = y + ysp: PUT (x - rad, y - rad), c%, PSET
RETURN

anim:
 
typ% = 1
IF nrt(scr%, typ%) > 0 THEN
t(typ%) = t(typ%) + 1
IF t(typ%) = 100 THEN t(typ%) = 0
IF t(typ%) = 1 THEN
wlt% = wlt% + 1

FOR nr = 1 TO nrt(scr%, typ%)
FOR c = 1 TO 2
  cr(c) = I(scr%, typ%, nr, c)
NEXT
ltx = (cr(1) * ml): lty = (cr(2) * ml + 20)
SELECT CASE wlt%
CASE 1, 14: PUT (ltx, lty), lt1%, PSET
CASE 2, 13: PUT (ltx, lty), lt2%, PSET
CASE 3, 12: PUT (ltx, lty), lt3%, PSET
CASE 4, 11: PUT (ltx, lty), lt4%, PSET
CASE 5, 10: PUT (ltx, lty), lt5%, PSET
CASE 6, 9: PUT (ltx, lty), lt6%, PSET
CASE 7, 8: PUT (ltx, lty), lt7%, PSET
CASE 15: wlt% = 0
END SELECT
NEXT
END IF
END IF

typ% = 2
IF nrt(scr%, typ%) > 0 THEN
IF t(typ%) < 20 THEN
   t(typ%) = t(typ%) + 1
ELSE
t(typ%) = 0

FOR nr = 1 TO nrt(scr%, typ%)
IF ABS(sdxsp(nr)) > 1 AND ABS(sdxsp(nr)) < 6 THEN
SELECT CASE INT(RND * 30) + 1
CASE 1: sdxsp(nr) = sdxsp(nr) + 1
CASE 2: sdxsp(nr) = sdxsp(nr) - 1
END SELECT
END IF

SELECT CASE INT(RND * 2) + 1
CASE 1
IF sdxsp(nr) > 0 THEN
IF sdx(nr) < sdxo(nr) + 68 THEN
sdx(nr) = sdx(nr) + sdxsp(nr)
ELSE : sdxsp(nr) = sdxsp(nr) * -1
END IF
END IF
CASE 2
IF sdxsp(nr) < 0 THEN
IF sdx(nr) > sdxo(nr) THEN
sdx(nr) = sdx(nr) + sdxsp(nr)
ELSE : sdxsp(nr) = sdxsp(nr) * -1
END IF
END IF
END SELECT

SELECT CASE INT(RND * 2) + 1
CASE 1: PUT (sdx(nr), sdy(nr) - 5), leg1%, PSET
CASE 2: PUT (sdx(nr), sdy(nr) - 7), leg2%, PSET
END SELECT
NEXT

danger% = 1
END IF
END IF

typ% = 3
IF nrt(scr%, typ%) > 0 THEN
IF t(typ%) < 13 THEN
   t(typ%) = t(typ%) + 1
ELSE
t(typ%) = 0

FOR nr = 1 TO nrt(scr%, typ%)
wlt2(nr) = wlt2(nr) + 1
IF wlt2(nr) >= 1 AND wlt2(nr) <= 30 THEN spy(nr) = spy(nr) - 4
IF wlt2(nr) >= 31 AND wlt2(nr) <= 60 THEN spy(nr) = spy(nr) + 4
IF wlt2(nr) = 61 THEN wlt2(nr) = 0
PUT (spx(nr), spy(nr)), spz%, PSET
NEXT

SELECT CASE 12
CASE POINT(x + rad + a1%, y + rad + a1%), POINT(x - rad - a1%, y + rad + a1%), POINT(x + rad + a2%, y), POINT(x, y + rad + a2%): GOSUB boom
END SELECT
END IF
END IF

typ% = 4
IF nrt(scr%, typ%) > 0 THEN
IF t(typ%) < 13 THEN
   t(typ%) = t(typ%) + 1
ELSE
t(typ%) = 0

FOR nr = 1 TO nrt(scr%, typ%)
wlt6(nr) = wlt6(nr) + 1
IF wlt6(nr) >= 1 AND wlt6(nr) <= 60 THEN box(nr) = box(nr) + 4
IF wlt6(nr) >= 61 AND wlt6(nr) <= 120 THEN box(nr) = box(nr) - 4
IF wlt6(nr) = 121 THEN wlt6(nr) = 0
PUT (box(nr), boy(nr)), btp%, PSET
NEXT
END IF
END IF

typ% = 5
IF nrt(scr%, typ%) > 0 THEN
IF t(typ%) < 13 THEN
   t(typ%) = t(typ%) + 1
ELSE
t(typ%) = 0
btt2% = btt2% + 1

FOR nr = 1 TO nrt(scr%, typ%)
wlt62(nr) = wlt62(nr) + 1
IF wlt62(nr) >= 1 AND wlt62(nr) <= 100 THEN boy2(nr) = boy2(nr) + 1
IF wlt62(nr) >= 101 AND wlt62(nr) <= 200 THEN boy2(nr) = boy2(nr) - 1
IF wlt62(nr) = 201 THEN wlt62(nr) = 0

SELECT CASE btt2%
CASE 1, 11: PUT (box2(nr), boy2(nr)), dev6%, PSET
CASE 2, 10: PUT (box2(nr), boy2(nr)), dev5%, PSET
CASE 3, 9: PUT (box2(nr), boy2(nr)), dev4%, PSET
CASE 4, 8: PUT (box2(nr), boy2(nr)), dev3%, PSET
CASE 5, 7: PUT (box2(nr), boy2(nr)), dev2%, PSET
CASE 6: PUT (box2(nr), boy2(nr)), dev1%, PSET
CASE 12: btt2% = 0
END SELECT

NEXT

danger% = 1
END IF
END IF

typ% = 6
IF nrt(scr%, typ%) > 0 THEN
t(typ%) = t(typ%) + 1
IF t(typ%) = 50 THEN t(typ%) = 0
IF t(typ%) = 1 THEN

FOR nr = 1 TO nrt(scr%, typ%)
FOR c = 1 TO 2
  cr(c) = I(scr%, typ%, nr, c)
NEXT
fiix = (cr(1) * ml + 19): fiy = (cr(2) * ml + 18)
SELECT CASE INT(RND * 3) + 1
CASE 1: PUT (fiix, fiy), fr1%, PSET
CASE 2: PUT (fiix, fiy + 2), fr2%, PSET
CASE 3: PUT (fiix, fiy + 4), fr3%, PSET
END SELECT
NEXT
END IF

SELECT CASE 15
CASE POINT(x, y + rad + a2%), POINT(x - 8, y + rad + a2%), POINT(x + 8, y + rad + a2%): GOSUB boom
END SELECT
END IF

typ% = 13
IF nrt(scr%, typ%) > 0 THEN
IF kout% = 0 THEN
IF t(typ%) < 5 THEN
   t(typ%) = t(typ%) + 1
ELSE
t(typ%) = 0

FOR nr = 1 TO nrt(scr%, typ%)
IF ysp > 0 AND y > y1 + 100 THEN PUT (kngx(nr), y - 100), kngd%, PSET
IF ysp < 0 THEN
  IF y < y1 + 100 THEN
  LINE (kngx(nr), 1)-(kngx(nr) + 110, 110), ba, BF: kout% = 1
  FOR I% = 1000 TO 2000 STEP 40: SOUND I%, .1: NEXT
  ELSE : PUT (kngx(nr), y - 100), kngu%, PSET
  END IF
END IF
IF x > kngx(nr) THEN GOSUB boom
NEXT

END IF
END IF
END IF

 IF danger% = 1 THEN
 danger% = 0
 SELECT CASE 0
 CASE POINT(x + rad + a1%, y + rad + a1%), POINT(x - rad - a1%, y + rad + a1%), POINT(x + rad + a2%, y), POINT(x, y + rad + a2%): GOSUB boom
 END SELECT
 END IF

RETURN

boom:
LINE (x - rad, y - rad)-(x + rad, y + rad), ba, BF
FOR I% = 1 TO 50 STEP 5
CIRCLE (x - 10, y - 10), I%, 11
SOUND 200 - I%, .1
NEXT

go:
lives% = lives% - 1
IF lives% = 0 THEN
send = "            game over": posn = 5: xwrite: ascr% = 1: kout% = 0
ELSEIF lives% > 0 THEN send = "        back to last skull": posn = 5: xwrite
END IF
GOSUB space
RETURN

getready:
plan
ascr% = 1: x1 = 1 + rad: x2 = 638 - rad: y1 = 1 + rad: y2 = 479 - rad - 10

FOR scr% = 1 TO scg
FOR typ% = 1 TO tyg
 DO
 nrt(scr%, typ%) = nrt(scr%, typ%) + 1
 LOOP UNTIL I(scr%, typ%, nrt(scr%, typ%), 1) + I(scr%, typ%, nrt(scr%, typ%), 2) = 0
 nrt(scr%, typ%) = nrt(scr%, typ%) - 1
NEXT
NEXT

RANDOMIZE TIMER
SCREEN 12
PAINT (1, 1), ba
DRAW "bm200,200c0s12dddr bubuu lruuuuueerrrrrrffdddddd bdbd ruuuld bdbd dddgggllllhhh uuu brp11,0bl  c0bubuu uuubr ffrrrreeblblbdllllbdrrdllhhgddfrrerrfrreuuhggll s4bdp1,0bus12c0   bgddldfudrrudeuluuddbffrlgllllheglr fdrrrru s4bgp15,0"
GET (200, 179)-(236, 227), head%
DRAW "bm300,300c0s40eeeeffbdhhgggbreefr brbebr eeffffblhhhgg reff"
GET (300, 260)-(450, 300), leg1%
DRAW "bm300,350c0s40rrrrffbdhhgggbrbrbruufr brbrbeeerrrr bdbdbdbg hhhggredd"
GET (300, 350)-(450, 390), leg2%
CLS : PAINT (0, 0), ba
PUT (200, 250), leg1%, PSET
PUT (200, 251), leg1%, AND
PUT (200, 252), leg1%, AND
PUT (257, 240), head%, PSET
GET (190, 240)-(360, 294), leg1%
PUT (200, 330), leg2%, PSET
PUT (200, 331), leg2%, AND
PUT (200, 332), leg2%, AND
PUT (257, 324), head%, PSET
GET (190, 320)-(360, 374), leg2%

LINE (93, 127)-(118, 158), fo, BF
DRAW "bm100,150s20c7 bduhuuerrfddgdll bubuufedllr s4blbhp0,7 bfbrbrbep0,7 bgblc7 s8 bdlrrld bd bddludrru bhp15,7"
GET (93, 127)-(118, 158), skl%

sr$ = "s12brc15dc14dc12dbububus4br"
LINE (25, 50)-(125, 60), fo, BF
DRAW "bm25,50" + sr$ + sr$ + sr$ + "bm110,50s12" + sr$ + sr$ + sr$
GET (25, 50)-(125, 60), lt1%
LINE (70, 50)-(80, 60), ba, BF: GET (25, 50)-(125, 60), lt2%
LINE (65, 50)-(85, 60), ba, BF: GET (25, 50)-(125, 60), lt3%
LINE (60, 50)-(90, 60), ba, BF: GET (25, 50)-(125, 60), lt4%
LINE (55, 50)-(95, 60), ba, BF: GET (25, 50)-(125, 60), lt5%
LINE (50, 50)-(100, 60), ba, BF: GET (25, 50)-(125, 60), lt6%
LINE (45, 50)-(105, 60), ba, BF: GET (25, 50)-(125, 60), lt7%

xs% = 100: ys% = 100
PAINT (1, 1), ba
CIRCLE (xs%, ys%), rad - 3, 1: PAINT STEP(0, 0), 1, 1
CIRCLE (xs% + 2, ys% - 2), rad - 6, 9: PAINT STEP(0, 0), 9, 9

CIRCLE (xs% + rad / 3, ys% - rad / 3), rad / 5, 11
CIRCLE ((xs% + rad / 3) - 1, ys% - rad / 3), rad / 5, 11
PAINT STEP(0, 0), 15, 11
GET (xs% - rad, ys% - rad)-(xs% + rad, ys% + rad), c%

wx% = 200: wy% = 200: rad2% = 25
CIRCLE (wx%, wy%), rad2%, fo: PAINT STEP(0, 0), fo, fo
CIRCLE (wx% + 8, wy% - 8), 10, 12: PAINT STEP(0, 0), 12, 12
CIRCLE (wx% + 11, wy% - 11), 3, 14: PAINT STEP(0, 0), 14, 14
GET (wx% - rad2%, wy% - rad2%)-(wx% + rad2%, wy% + rad2%), blp%

DRAW "bm200,100c" + STR$(fo) + "s20rrrrgllgrrrrhls8bdp12," + STR$(fo) + "bus20c" + STR$(fo) + "lhs4brbfp4," + STR$(fo)
GET (200, 100)-(220, 110), shl%

DRAW "bm300,200c15s20bdbdbds10fuuuedfeuuuufdddddfdddlllllluuuuddddreeufdfllbup15,15bhblp14,15"
DRAW "bm320,200c15s20bdbds10bdfuuedfddeuuuufdddfddddlllllluuuuuddddd reeffllbup15,15blbup14,15"
DRAW "bm340,200c15s10bdbdbdbdbdfuuueddddfeuuueddddedddddlllllluuuuudddddreufedds4bep14,15bgbhp15,15"
GET (300, 203)-(312, 223), fr1%
GET (320, 206)-(332, 224), fr2%
GET (340, 204)-(352, 220), fr3%

LINE (500, 310)-(500, 300), 12
LINE STEP(0, 0)-(510, 260), 12
LINE STEP(0, 0)-(520, 300), 12
LINE STEP(0, 0)-(520, 310), 12
LINE STEP(0, 0)-(500, 310), 12
PAINT STEP(1, -1), 12, 12
LINE (500, 310)-(520, 320), fo, BF
GET (500, 256)-(520, 320), spz%

LINE (500, 100)-(550, 125), fo, BF
GET (496, 100)-(554, 125), btp%
GET (500, 96)-(550, 129), btp2%

ts1$ = "bm200,200s15c0dddrdddddffffrrrreeeeuuuuuruuuluuugeee": ts2$ = "gggeehhllllllllggffhhh"
ts3$ =  _
"fffhdddlbfp2,0buc0ddduuubrfrrrferrrebrddduuu bl bdgllgfrehflll s7brbfp0,0bhbls15c0 blbl lll elhfrrfglhs7brbfp0,0bhbls15c0f bdgereddbebedduufrf bdbdbdhhgllhgg d rrrrrrrr u llllllll s7brbfp15,0bhbls15c0 rdurdurdurdurdurdurdur s7bgp0,0bhs15 lllllll s7bfp0,0c0bfs15 rrgerrfhrr" _

xk1% = 185: yk1% = 165: xk2% = 257: yk2% = 242
LINE (xk1%, yk1%)-(xk2%, yk2%), 3, BF

FOR I% = 1 TO 6
SELECT CASE I%
CASE 1: r01$ = "uhhhlfffd": l01$ = "ueeelgggd"
CASE 2: r01$ = "uuuuugdddd": l01$ = "uuuuhddddd"
CASE 3: r01$ = "eeeeuggggg": l01$ = "hhhhhdffff"
CASE 4: r01$ = "rrrellllg": l01$ = "hllllfrrr"
CASE 5: r01$ = "rffrhhhlg": l01$ = "hlgggreer"
CASE 6: r01$ = "rdfuuhlg": l01$ = "hlgddeur"
END SELECT

DRAW ts1$ + r01$ + ts2$ + l01$ + ts3$
PSET (213, 211), 15: PSET (228, 211), 15
CIRCLE (213, 211), 1, 3: CIRCLE (228, 211), 1, 3

SELECT CASE I%
CASE 1: GET (xk1%, yk1%)-(xk2%, yk2%), dev1%
CASE 2: GET (xk1%, yk1%)-(xk2%, yk2%), dev2%
CASE 3: GET (xk1%, yk1%)-(xk2%, yk2%), dev3%
CASE 4: GET (xk1%, yk1%)-(xk2%, yk2%), dev4%
CASE 5: GET (xk1%, yk1%)-(xk2%, yk2%), dev5%
CASE 6: GET (xk1%, yk1%)-(xk2%, yk2%), dev6%
END SELECT

LINE (xk1%, yk1%)-(xk2%, yk2%), 3, BF
NEXT

arrw$ = "s20c" + STR$(fo) + "bdbdrrrrrrrrrrrrrrrruufffffggggguulllllllllllllllluuuuuu bfrrrrllllddrrrrllllddrrrr breehhffeeggff bruuuu br rrdddduuuurr brp12," + STR$(fo)
DRAW "bm400,20" + arrw$: DRAW "bm400,21" + arrw$: DRAW "bm401,20" + arrw$
GET (400, 20)-(505, 70), arrow%

dwn$ = "fffddddfflllluuuuuhhhllgggdddddlllleeuuuueee"
upw$ = "dddddddfflllluuuuuuuullddddddddlllleeuuuuuuu"
kn1$ = "bm400,400s15c0eeereeeeeruuuuuueerrrrrrrrrrffddddddrfffffrffflhhffllhhlddlhuehhhgggg"
kn2$ =  _
"hhhhgggfdgluulgglleegglblbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbubup11,0c0ullrrrrbelllllluefrdurefduhhhggbhblluruuddrrrhhllurbhrrfffuuhhlllrrrffeerrrbdllgggbfeerrulbdddbdrullllbrbep15,0c0bgblblblblbhp15,0c0bububububububublblbruuuuffeeffghe bdp12,0c0 bueffeedddd bhp14,0" _

DRAW kn1$ + dwn$ + kn2$: GET (400, 322)-(502, 421), kngd%
LINE (400, 340)-(502, 430), 3, BF
DRAW kn1$ + upw$ + kn2$: GET (400, 340)-(502, 452), kngu%

CLS : PAINT (0, 0), ba
send = " pearl two: use arrows to move.  ": posn = 3: xwrite
send = "left and right is for direction, ": posn = 4: xwrite
send = "  up and down for high and low   ": posn = 5: xwrite
send = "             jumping.            ": posn = 6: xwrite

space:
scr% = ascr%: xsp = 0: ysp = 0: x = 150: y = 200
send = "     press space to continue      ": posn = 9: xwrite
DO
SELECT CASE INKEY$
CASE " ": CLS : neu% = 1: GOTO start
CASE CHR$(27): END
END SELECT
LOOP

SUB info
CLS
PRINT "Wenn die Steuerung zu trÑge ist, sollte die Tastatureinstellung"
PRINT "des Betriebssystems auf kÅrzeste Verzîgerung und schnellste"
PRINT "Wiederholungsrate eingestellt werden. Ist das Spiel insgesamt zu"
PRINT "langsam, sollte es, nachdem die Tastatureinstellung Åber das"
PRINT "Betriebssystem geladen ist, im MS-Dos Modus gestartet werden."
LOCATE 10, 1: PRINT "For best gameplay make sure the fastest keyboard"
PRINT "setting is loaded, then start the game from MS-Dos."
LOCATE 15, 1: PRINT "Comments to Jester@T-Online.de"
PRINT "Press space to continue"
DO: LOOP UNTIL INKEY$ = " "
END SUB

SUB plan
I(1, 1, 1, 1) = 6:    I(1, 1, 1, 2) = 5
I(1, 7, 1, 1) = 8:    I(1, 7, 1, 2) = 5
I(1, 7, 2, 1) = 5:    I(1, 7, 2, 2) = 5
I(1, 8, 1, 1) = 5:    I(1, 8, 1, 2) = 6
I(1, 8, 2, 1) = 8:    I(1, 8, 2, 2) = 6
I(1, 9, 1, 1) = 1:    I(1, 9, 1, 2) = 9
I(1, 9, 2, 1) = 8:    I(1, 9, 2, 2) = 9
I(1, 9, 3, 1) = 5:    I(1, 9, 3, 2) = 2
I(1, 9, 4, 1) = 5:    I(1, 9, 4, 2) = 1
I(1, 9, 5, 1) = 5:    I(1, 9, 5, 2) = 0
I(1, 9, 6, 1) = 12:   I(1, 9, 6, 2) = 9
I(1, 10, 1, 1) = 0:   I(1, 10, 1, 2) = 1
I(1, 11, 1, 1) = 1:   I(1, 11, 1, 2) = 0
I(1, 12, 1, 1) = 8:   I(1, 12, 1, 2) = 6
I(2, 6, 1, 1) = 2:    I(2, 6, 1, 2) = 7
I(2, 6, 2, 1) = 4:    I(2, 6, 2, 2) = 5
I(2, 6, 3, 1) = 6:    I(2, 6, 3, 2) = 3
I(2, 8, 1, 1) = 2:    I(2, 8, 1, 2) = 8
I(2, 8, 2, 1) = 4:    I(2, 8, 2, 2) = 6
I(2, 8, 3, 1) = 6:    I(2, 8, 3, 2) = 4
I(2, 8, 4, 1) = 6:    I(2, 8, 4, 2) = 6
I(2, 9, 1, 1) = 0:    I(2, 9, 1, 2) = 9
I(2, 9, 2, 1) = 3:    I(2, 9, 2, 2) = 9
I(2, 9, 3, 1) = 11:   I(2, 9, 3, 2) = 9
I(2, 9, 4, 1) = 13:   I(2, 9, 4, 2) = 0
I(3, 3, 1, 1) = 7:    I(3, 3, 1, 2) = 3
I(3, 8, 1, 1) = 7:    I(3, 8, 1, 2) = 4
I(3, 8, 2, 1) = 9:    I(3, 8, 2, 2) = 4
I(3, 9, 1, 1) = 0:    I(3, 9, 1, 2) = 9
I(3, 9, 2, 1) = 7:    I(3, 9, 2, 2) = 9
I(3, 9, 3, 1) = 9:    I(3, 9, 3, 2) = 4
I(4, 1, 1, 1) = 7:    I(4, 1, 1, 2) = 3
I(4, 8, 1, 1) = 3:    I(4, 8, 1, 2) = 0
I(4, 8, 2, 1) = 6:    I(4, 8, 2, 2) = 0
I(4, 9, 1, 1) = 2:    I(4, 9, 1, 2) = 9
I(4, 9, 2, 1) = 0:    I(4, 9, 2, 2) = 4
I(4, 9, 3, 1) = 3:    I(4, 9, 3, 2) = 9
I(4, 9, 4, 1) = 9:    I(4, 9, 4, 2) = 3
I(4, 9, 5, 1) = 4:    I(4, 9, 5, 2) = 9
I(5, 3, 1, 1) = 4:    I(5, 3, 1, 2) = 3
I(5, 7, 1, 1) = 5:    I(5, 7, 1, 2) = 6
I(5, 7, 2, 1) = 6:    I(5, 7, 2, 2) = 6
I(5, 7, 3, 1) = 7:    I(5, 7, 3, 2) = 6
I(5, 7, 4, 1) = 8:    I(5, 7, 4, 2) = 6
I(5, 7, 5, 1) = 9:    I(5, 7, 5, 2) = 6
I(5, 7, 6, 1) = 10:   I(5, 7, 6, 2) = 6
I(5, 7, 7, 1) = 11:   I(5, 7, 7, 2) = 6
I(5, 7, 8, 1) = 4:    I(5, 7, 8, 2) = 6
I(5, 7, 9, 1) = 4:    I(5, 7, 9, 2) = 4
I(5, 7, 10, 1) = 4:   I(5, 7, 10, 2) = 5
I(5, 9, 1, 1) = 0:    I(5, 9, 1, 2) = 3
I(6, 7, 1, 1) = 0:    I(6, 7, 1, 2) = 6
I(6, 7, 2, 1) = 2:    I(6, 7, 2, 2) = 6
I(6, 7, 3, 1) = 4:    I(6, 7, 3, 2) = 6
I(6, 7, 4, 1) = 6:    I(6, 7, 4, 2) = 6
I(6, 7, 5, 1) = 8:    I(6, 7, 5, 2) = 6
I(6, 7, 6, 1) = 10:   I(6, 7, 6, 2) = 6
I(6, 9, 1, 1) = 11:   I(6, 9, 1, 2) = 6
I(7, 2, 1, 1) = 3:    I(7, 2, 1, 2) = 5
I(7, 2, 2, 1) = 6:    I(7, 2, 2, 2) = 1
I(7, 6, 1, 1) = 2:    I(7, 6, 1, 2) = 5
I(7, 9, 1, 1) = 6:    I(7, 9, 1, 2) = 2
I(7, 9, 2, 1) = 7:    I(7, 9, 2, 2) = 2
I(7, 11, 1, 1) = 0:   I(7, 11, 1, 2) = 6
I(8, 3, 1, 1) = 8:    I(8, 3, 1, 2) = 7
I(8, 3, 2, 1) = 10:   I(8, 3, 2, 2) = 7
I(8, 9, 1, 1) = 0:    I(8, 9, 1, 2) = 6
I(8, 9, 2, 1) = 8:    I(8, 9, 2, 2) = 8
I(9, 2, 1, 1) = 7:    I(9, 2, 1, 2) = 6
I(9, 6, 1, 1) = 4:    I(9, 6, 1, 2) = 3
I(9, 8, 1, 1) = 4:    I(9, 8, 1, 2) = 4
I(9, 8, 2, 1) = 6:    I(9, 8, 2, 2) = 4
I(9, 8, 3, 1) = 12:   I(9, 8, 3, 2) = 4
I(9, 8, 4, 1) = 7:    I(9, 8, 4, 2) = 0
I(9, 9, 1, 1) = 1:    I(9, 9, 1, 2) = 8
I(9, 9, 2, 1) = 7:    I(9, 9, 2, 2) = 7
I(9, 9, 3, 1) = 4:    I(9, 9, 3, 2) = 9
I(9, 9, 4, 1) = 8:    I(9, 9, 4, 2) = 9
I(9, 9, 5, 1) = 6:    I(9, 9, 5, 2) = 4
I(9, 12, 1, 1) = 4:   I(9, 12, 1, 2) = 4
I(10, 3, 1, 1) = 8:   I(10, 3, 1, 2) = 7
I(10, 7, 1, 1) = 8:   I(10, 7, 1, 2) = 8
I(10, 7, 2, 1) = 10:  I(10, 7, 2, 2) = 8
I(10, 9, 1, 1) = 0:   I(10, 9, 1, 2) = 4
I(11, 7, 1, 1) = 4:   I(11, 7, 1, 2) = 8
I(11, 7, 2, 1) = 5:   I(11, 7, 2, 2) = 8
I(11, 7, 3, 1) = 6:   I(11, 7, 3, 2) = 8
I(11, 7, 4, 1) = 6:   I(11, 7, 4, 2) = 7
I(11, 7, 5, 1) = 6:   I(11, 7, 5, 2) = 6
I(11, 7, 6, 1) = 6:   I(11, 7, 6, 2) = 5
I(11, 7, 7, 1) = 10:  I(11, 7, 7, 2) = 5
I(12, 7, 1, 1) = 1:   I(12, 7, 1, 2) = 7
I(12, 7, 2, 1) = 2:   I(12, 7, 2, 2) = 6
I(12, 7, 3, 1) = 3:   I(12, 7, 3, 2) = 5
I(12, 7, 4, 1) = 4:   I(12, 7, 4, 2) = 4
I(12, 7, 5, 1) = 5:   I(12, 7, 5, 2) = 7
I(12, 7, 6, 1) = 6:   I(12, 7, 6, 2) = 6
I(12, 7, 7, 1) = 7:   I(12, 7, 7, 2) = 7
I(12, 7, 8, 1) = 8:   I(12, 7, 8, 2) = 4
I(12, 7, 9, 1) = 9:   I(12, 7, 9, 2) = 5
I(12, 7, 10, 1) = 10: I(12, 7, 10, 2) = 6
I(12, 7, 11, 1) = 11: I(12, 7, 11, 2) = 7
I(13, 3, 1, 1) = 6:   I(13, 3, 1, 2) = 6
I(13, 3, 2, 1) = 10:  I(13, 3, 2, 2) = 6
I(13, 7, 1, 1) = 6:   I(13, 7, 1, 2) = 7
I(13, 7, 2, 1) = 10:  I(13, 7, 2, 2) = 7
I(13, 7, 3, 1) = 8:   I(13, 7, 3, 2) = 4
I(13, 8, 1, 1) = 8:   I(13, 8, 1, 2) = 0
I(13, 9, 1, 1) = 2:   I(13, 9, 1, 2) = 8
I(13, 9, 2, 1) = 6:   I(13, 9, 2, 2) = 8
I(13, 9, 3, 1) = 10:  I(13, 9, 3, 2) = 8
I(14, 9, 1, 1) = 0:   I(14, 9, 1, 2) = 8
I(15, 4, 1, 1) = 5:   I(15, 4, 1, 2) = 8
I(15, 8, 1, 1) = 7:   I(15, 8, 1, 2) = 0
I(15, 8, 2, 1) = 7:   I(15, 8, 2, 2) = 3
I(15, 9, 1, 1) = 1:   I(15, 9, 1, 2) = 8
I(15, 9, 2, 1) = 11:  I(15, 9, 2, 2) = 8
I(16, 1, 1, 1) = 9:   I(16, 1, 1, 2) = 3
I(16, 4, 1, 1) = 6:   I(16, 4, 1, 2) = 7
I(16, 9, 1, 1) = 0:   I(16, 9, 1, 2) = 8
I(16, 9, 2, 1) = 1:   I(16, 9, 2, 2) = 1
I(16, 9, 3, 1) = 2:   I(16, 9, 3, 2) = 7
I(16, 9, 4, 1) = 3:   I(16, 9, 4, 2) = 2
I(16, 9, 5, 1) = 5:   I(16, 9, 5, 2) = 3
I(16, 9, 6, 1) = 11:  I(16, 9, 6, 2) = 3
I(17, 6, 1, 1) = 4:   I(17, 6, 1, 2) = 6
I(17, 6, 2, 1) = 7:   I(17, 6, 2, 2) = 5
I(17, 6, 3, 1) = 10:  I(17, 6, 3, 2) = 5
I(17, 9, 1, 1) = 1:   I(17, 9, 1, 2) = 8
I(17, 9, 2, 1) = 4:   I(17, 9, 2, 2) = 7
I(17, 9, 3, 1) = 7:   I(17, 9, 3, 2) = 6
I(17, 9, 4, 1) = 10:  I(17, 9, 4, 2) = 7
I(17, 11, 1, 1) = 0:  I(17, 11, 1, 2) = 3
I(18, 7, 1, 1) = 9:   I(18, 7, 1, 2) = 8
I(18, 7, 2, 1) = 10:   I(18, 7, 2, 2) = 8
I(18, 7, 3, 1) = 11:   I(18, 7, 3, 2) = 8
I(18, 8, 1, 1) = 4:   I(18, 8, 1, 2) = 0
I(18, 8, 2, 1) = 4:   I(18, 8, 2, 2) = 7
I(18, 8, 3, 1) = 12:  I(18, 8, 3, 2) = 5
I(18, 9, 1, 1) = 0:   I(18, 9, 1, 2) = 3
I(18, 9, 2, 1) = 0:   I(18, 9, 2, 2) = 7
I(19, 4, 1, 1) = 1:   I(19, 4, 1, 2) = 5
I(19, 4, 2, 1) = 6:   I(19, 4, 2, 2) = 5
I(19, 8, 1, 1) = 0:   I(19, 8, 1, 2) = 5
I(19, 9, 1, 1) = 12:  I(19, 9, 1, 2) = 5
I(20, 5, 1, 1) = 7:   I(20, 5, 1, 2) = 1
I(20, 9, 1, 1) = 0:   I(20, 9, 1, 2) = 5
I(20, 9, 2, 1) = 11:  I(20, 9, 2, 2) = 5
I(20, 12, 1, 1) = 3:  I(20, 12, 1, 2) = 5
I(21, 4, 1, 1) = 2:   I(21, 4, 1, 2) = 7
I(21, 4, 2, 1) = 6:   I(21, 4, 2, 2) = 7
I(21, 5, 1, 1) = 4:   I(21, 5, 1, 2) = 3
I(21, 5, 2, 1) = 9:   I(21, 5, 2, 2) = 1
I(21, 9, 1, 1) = 0:   I(21, 9, 1, 2) = 5
I(21, 9, 2, 1) = 11:  I(21, 9, 2, 2) = 5
I(22, 8, 1, 1) = 12:   I(22, 8, 1, 2) = 0
I(22, 8, 2, 1) = 12:   I(22, 8, 2, 2) = 3
I(22, 9, 1, 1) = 0:   I(22, 9, 1, 2) = 5
I(22, 9, 2, 1) = 2:   I(22, 9, 2, 2) = 6
I(22, 9, 3, 1) = 4:   I(22, 9, 3, 2) = 7
I(22, 9, 4, 1) = 6:   I(22, 9, 4, 2) = 8
I(22, 9, 5, 1) = 8:   I(22, 9, 5, 2) = 9
I(22, 9, 6, 1) = 12:  I(22, 9, 6, 2) = 9
I(23, 8, 1, 1) = 13:  I(23, 8, 1, 2) = 0
I(23, 8, 2, 1) = 13:  I(23, 8, 2, 2) = 3
I(23, 8, 3, 1) = 12:  I(23, 8, 3, 2) = 0
I(23, 8, 4, 1) = 12:  I(23, 8, 4, 2) = 3
I(23, 11, 1, 1) = 0:  I(23, 11, 1, 2) = 9
I(23, 13, 1, 1) = 7:  I(23, 13, 1, 2) = 0

'I(screen, type, number, coord) = x(12)/ y(9)
'--------------------------------
'1:        bridge
'2:        spider
'3:        blade
'4:        boat
'5:        alien
'6:        fire
'7:        bowl
'8:        wall down
'9:        wall right
'10:       wall d long
'11:       wall r long
'12:       skull
'13:       king
'--------------------------------
END SUB

SUB xwrite
IF posn = 0 THEN posn = 1
  DRAW "bm30," + STR$(posn * 50)
send = LCASE$(send)

sz1$ = "s4": sz2$ = "s8": col$ = "p15,9"
FOR I% = 1 TO LEN(send)
lt$ = MID$(send, I%, 1)
SELECT CASE lt$
CASE ";": lt$ = "bubuuldrbdldebd " + sz2$ + "blbh" + col$ + "bububububu" + col$ + "bdbdbdbdbd bfbr"
CASE "?": lt$ = "bububuuullldrrdgrebgbgdrulbrbf " + sz2$ + "blblbh" + col$ + "bububububu" + col$ + "bdbdbdbdbd bfbrbr"
CASE "!": lt$ = "ubuuuuldddbddrbubulbdrbd " + sz2$ + "blbh" + col$ + "bububububu" + col$ + "bdbdbdbdbd bfbr"
CASE ":": lt$ = "bubuuldrbdbduldr " + sz2$ + "blbh" + col$ + "bububububu" + col$ + "bdbdbdbdbd bfbr"
CASE ".": lt$ = "uldrbl " + sz2$ + "br" + sz1$ + "bh" + col$ + "bf" + sz2$ + "bl"
CASE ",": lt$ = "ulddebl " + sz2$ + "br" + sz1$ + "bh" + col$ + "bf" + sz2$ + "bl"
CASE "z": lt$ = "hlueeulllfrggddrrr " + sz2$ + "blbh" + col$ + "bfbr"
CASE "y": lt$ = "huuruuglhddrddgrrr " + sz2$ + "bhbl" + col$ + "brbf"
CASE "x": lt$ = "uuheuglhdfgddeurdf " + sz2$ + "bubh" + col$ + "bfbd"
CASE "w": lt$ = "bleuuuugddulduuhddddfurdbr " + sz2$ + "bhbu" + col$ + "bdbf"
CASE "v": lt$ = "bleuuuugdddluuuhddddfrbr " + sz2$ + "blbh" + col$ + "bfbr"
CASE "u": lt$ = "uuuuulddddluuuuldddddrrr " + sz2$ + "bh" + col$ + "bf"
CASE "t": lt$ = "bluuuufuulllddeddddrbr " + sz2$ + "blbhbh" + col$ + "bfbfbr"
CASE "s": lt$ = "buuhlurrhlgdfrglfrebd " + sz2$ + "bh" + sz1$ + "bh" + col$ + "bf" + sz2$ + "bf"
CASE "r": lt$ = "uheuhlldddddruufdrbububhuldrbfbdbd " + sz2$ + "bh" + col$ + "bf"
CASE "q": lt$ = "heuuhlgdddfrrbhbluuurddgblbfbrbr " + sz2$ + "blblbh" + col$ + "bfbrbr"
CASE "p": lt$ = "bububuuhlldddddrrhurebluldrbfbdbd " + sz2$ + "blblblblbh" + col$ + "bfbrbrbrbr"
CASE "o": lt$ = "buuuuhlgdddfrebluuuldddrbf " + sz2$ + "blbh" + col$ + "bfbr"
CASE "n": lt$ = "uuuuuldhldddddruuufddr " + sz2$ + "bh" + col$ + "bf"
CASE "m": lt$ = "uuuuuldluldddddruuudrudddr " + sz2$ + "bh" + col$ + "bf"
CASE "l": lt$ = "uugluuuelldddddrrr " + sz2$ + "bh" + col$ + "bf"
CASE "k": lt$ = "uuheugguuldddddruuff " + sz2$ + "bubh" + col$ + "bdbf"
CASE "j": lt$ = "buuuuullfdddhugdfrebd " + sz2$ + "blblbh" + col$ + "bfbrbr"
CASE "i": lt$ = "huuuelllfdddgrrr " + sz2$ + "bl" + sz1$ + "bh" + col$ + "bf" + sz2$ + "br"
CASE "h": lt$ = "uuuuulddluuldddddruurddr " + sz2$ + "bh" + col$ + "bf "
CASE "g": lt$ = "uuhddluuurfuullldddddrrr " + sz2$ + "bl " + sz1$ + "bu " + col$ + "bd " + sz2$ + "br"
CASE "f": lt$ = "bububuuullldddddrrhurhurfbdbdbd " + sz2$ + "blblblbl" + sz1$ + "bu" + col$ + "bd " + sz2$ + "brbrbrbr"
CASE "e": lt$ = "uuglurulurfuullldddddrrr " + sz2$ + "bh" + col$ + "bf"
CASE "d": lt$ = "buuuuhlldddddrrebhuhdddebfbd " + sz2$ + "bhbh" + col$ + "bfbf"
CASE "c": lt$ = "uugluuurfuullldddddrrr " + sz2$ + "bh" + col$ + "bf"
CASE "b": lt$ = "buuhehlldddddrrebhbhurgbddrulbfbf " + sz2$ + "bhbu" + col$ + "bfbd"
CASE "a": lt$ = "uuuuullldddddruubuurdlbdrddr " + sz2$ + "bh" + col$ + "bf"
END SELECT

DRAW "c9s10bfs20bdbd" + lt$ + "s75brs20bubus10bh"
NEXT

posn = 1
END SUB

