DECLARE SUB main ()
DECLARE SUB intro2 ()
DECLARE SUB intro ()
DIM SHARED Xcolor, Ocolor, BoardColor
  Xcolor = 4: Ocolor = 4: BoardColor = 4
  CLS
    COLOR 11
    LOCATE 11, 30
    COLOR 11
    PRINT "∞±≤€€€€€€€€€€€€€€≤±∞"
    COLOR 3
    PRINT "                             ∞±≤€€€€€€€€€€€€€€≤±∞"
    LOCATE , 30
    COLOR 11
    PRINT "∞±≤€ Jim Fallon €≤±∞"
    COLOR 3
    PRINT "                             ∞±≤€€€€€€€€€€€€€€≤±∞"
    COLOR 11
    PRINT "                             ∞±≤€€€€€€€€€€€€€€≤±∞"
    COLOR 15
    PRINT "                                  PRESENTS:"
    DO: LOOP UNTIL INKEY$ <> ""
     CLS

intro
 '------------------------
CLS

COLOR 4, 9: LOCATE 5, 15: PRINT SPC(10); : COLOR 4, 8: LOCATE 5, 5: PRINT "PLAYER 1";
COLOR 4, 9: LOCATE 7, 15: PRINT SPC(10); : COLOR 4, 8: LOCATE 7, 5: PRINT "PLAYER 2";
COLOR 4, 9: LOCATE 9, 15: PRINT SPC(10); : COLOR 4, 8: LOCATE 9, 5: PRINT "Password";
LOCATE 12, 13: PRINT "press escape to begin"
index = 1
DO
FOR x = 1 TO 3
LOCATE 3 + (x * 2), 15: COLOR 3, 9: PRINT RIGHT$(itemp$(x), 9)
NEXT x

DO: : COLOR 23, 9: DO: a$ = INKEY$:
     IF LEN(itemp$(index)) > 9 THEN
     LOCATE 3 + (2 * index), 24
     ELSE LOCATE 3 + (2 * index), 15 + LEN(itemp$(index))
     END IF
     PRINT "_": LOOP UNTIL a$ <> "": COLOR 3, 9

  IF a$ = CHR$(13) OR a$ = CHR$(9) THEN index = index + 1
  IF index > 3 THEN index = 1
  IF a$ = CHR$(8) AND LEN(itemp$(index)) <> 0 THEN
                IF index = 3 THEN LET password$ = LEFT$(password$, LEN(password$) - 1)
                itemp$(index) = LEFT$(itemp$(index), LEN(itemp$(index)) - 1)
  END IF
COLOR 4, 9: LOCATE 5, 15: PRINT SPC(10);
 COLOR 4, 9: LOCATE 7, 15: PRINT SPC(10);
 COLOR 4, 9: LOCATE 9, 15: PRINT SPC(10);

LOOP UNTIL a$ <> ""

 IF a$ = CHR$(27) THEN EXIT DO
 IF a$ <> CHR$(8) AND a$ <> CHR$(13) AND a$ <> CHR$(9) THEN
        FOR x = 1 TO 2
        IF index = x THEN
             LET itemp$(x) = itemp$(x) + a$
             END IF
             NEXT x
        IF index = 3 THEN
             LET itemp$(index) = itemp$(index) + "*"
             LET password$ = password$ + UCASE$(a$)
             END IF
 END IF
LOOP
Player$(1) = itemp$(1)
Player$(2) = itemp$(2)
 '------------------------
DO
SCREEN 13
LINE (200, 20)-(295, 190), 9, B
LOCATE 4, 27: PRINT "         "
LOCATE 6, 27: PRINT "         "
LOCATE 4, 27: PRINT Player$(1); playx
LOCATE 6, 27: PRINT Player$(2); playo
LOCATE 8, 27: PRINT "Tie"; playt
LOCATE 14, 27: COLOR 3: PRINT "["; : COLOR 9: PRINT "O"; : COLOR 3: PRINT "]ptions"

'set varables
FOR i = 1 TO 9
 flag$(i) = ""
NEXT i
winner$ = ""
show = 0

  LOCATE 5, 6: PRINT "1"
  LOCATE 5, 15: PRINT "2"
  LOCATE 5, 23: PRINT "3"
  LOCATE 15, 6: PRINT "4"
  LOCATE 15, 15: PRINT "5"
  LOCATE 15, 23: PRINT "6"
  LOCATE 22, 6: PRINT "7"
  LOCATE 22, 15: PRINT "8"
  LOCATE 22, 23: PRINT "9"
  
 LINE (50, 5)-(53, 171), 20, BF
 LINE (125, 5)-(128, 171), 20, BF
LINE (0, 50)-(176, 53), 20, BF
LINE (0, 125)-(176, 128), 20, BF

 LINE (50, 5)-(52, 170), BoardColor, BF
 LINE (125, 5)-(127, 170), BoardColor, BF
LINE (0, 50)-(175, 52), BoardColor, BF
LINE (0, 125)-(175, 127), BoardColor, BF


DO
IF Player = 1 THEN Player = 2 ELSE Player = 1
LOCATE 23, 1: COLOR 40:
  IF Player$(Player) <> "" THEN
    PRINT Player$(Player)
    ELSE PRINT "Player "; Player
  END IF
DO: a$ = INKEY$: LOOP UNTIL a$ <> "" AND a$ <> CHR$(13) AND a$ <> " "
IF a$ = "o" THEN intro2: main
IF a$ = CHR$(27) THEN
CLS : LOCATE 10, 25: PRINT "goodbye."
a$ = INPUT$(1): SYSTEM
END IF

a = VAL(a$)
IF a$ = "o" THEN
IF Player = 1 THEN Player = 2 ELSE Player = 1
END IF

IF flag$(a) <> "" AND a$ <> "o" THEN
            BEEP
            COLOR 7
            LOCATE 20, 25: PRINT "Already"
            LOCATE 21, 25: PRINT "Occupied"
             SLEEP 1
            LOCATE 20, 25: PRINT "       "
            LOCATE 21, 25: PRINT "        "
            IF Player = 1 THEN Player = 2 ELSE Player = 1
            ELSE

IF Player = 1 THEN
              flag$(a) = "x"
              END IF
IF Player = 2 THEN
              flag$(a) = "o"
              END IF
         END IF

 FOR i = 1 TO 9

  IF i = 1 THEN L = 0: t = 0
  IF i = 2 THEN L = 0: t = 75
  IF i = 3 THEN L = 0: t = 150
  IF i = 4 THEN L = 75: t = 0
  IF i = 5 THEN L = 75: t = 75
  IF i = 6 THEN L = 75: t = 150
  IF i = 7 THEN L = 150: t = 0
  IF i = 8 THEN L = 150: t = 75
  IF i = 9 THEN L = 150: t = 150
 IF flag$(i) = "x" THEN
 xa = L + 5: xb = L + 20: ya = t + 7: yb = t + 22
 LINE (ya, xa)-(yb, xb), 20
 LINE (ya, xa + 1)-(yb, xb + 1), 20
 LINE (ya, xb)-(yb, xa), 20
 LINE (ya, xb + 1)-(yb, xa + 1), 20

 LINE (ya - 1, xa)-(yb - 1, xb), Xcolor
 LINE (ya - 1, xa + 1)-(yb - 1, xb + 1), Xcolor4
 LINE (ya - 1, xb)-(yb - 1, xa), Xcolor
 LINE (ya - 1, xb + 1)-(yb - 1, xa + 1), Xcolor
END IF

IF flag$(i) = "o" THEN
COLOR 20
CIRCLE (t + 15, L + 13), 10:
COLOR Ocolor
 FOR w = 9 TO 10: CIRCLE (t + 14, L + 12), w: NEXT w
END IF

NEXT i

IF flag$(1) = flag$(2) AND flag$(2) = flag$(3) AND flag$(3) <> "" THEN winner$ = flag$(1): show = 1
IF flag$(4) = flag$(5) AND flag$(5) = flag$(6) AND flag$(6) <> "" THEN winner$ = flag$(4): show = 2
IF flag$(7) = flag$(8) AND flag$(8) = flag$(9) AND flag$(9) <> "" THEN winner$ = flag$(7): show = 3
IF flag$(1) = flag$(4) AND flag$(4) = flag$(7) AND flag$(7) <> "" THEN winner$ = flag$(1): show = 4
IF flag$(2) = flag$(5) AND flag$(5) = flag$(8) AND flag$(8) <> "" THEN winner$ = flag$(2): show = 5
IF flag$(3) = flag$(6) AND flag$(6) = flag$(9) AND flag$(9) <> "" THEN winner$ = flag$(3): show = 6
IF flag$(1) = flag$(5) AND flag$(5) = flag$(9) AND flag$(9) <> "" THEN winner$ = flag$(1): show = 7
IF flag$(3) = flag$(5) AND flag$(5) = flag$(7) AND flag$(7) <> "" THEN winner$ = flag$(3): show = 8
IF winner$ <> "" THEN EXIT DO
tie = 0
FOR i = 1 TO 9
IF flag$(i) = "" THEN LET tie = 1
NEXT i
IF tie = 0 THEN EXIT DO
LOOP

COLOR 9
IF show = 1 THEN LINE (0, 25)-(200, 25)
IF show = 2 THEN LINE (0, 85)-(200, 85)
IF show = 3 THEN LINE (0, 150)-(200, 150)
IF show = 4 THEN LINE (25, 0)-(25, 200)
IF show = 5 THEN LINE (85, 0)-(85, 200)
IF show = 6 THEN LINE (150, 200)-(150, 200)
IF show = 7 THEN LINE (0, 0)-(185, 175)
IF show = 8 THEN LINE (185, 0)-(0, 175)
IF show = 0 THEN
LOCATE 10, 25: PRINT "We Have A Tie!!"
ELSE
LOCATE 10, 25: PRINT "The Winner is ";
LOCATE 11, 30: PRINT UCASE$(winner$)
COLOR 9
END IF

IF winner$ = "x" THEN playx = playx + 1
IF winner$ = "o" THEN playo = playo + 1
IF winner$ = "" THEN playt = playt + 1
'show stats
a$ = INPUT$(1)
LOCATE 10, 25: PRINT "              "
LOCATE 11, 25: PRINT "              "
LINE (200, 20)-(295, 190), 9, B
COLOR 3
LOCATE 4, 27: PRINT "         "
LOCATE 6, 27: PRINT "         "
LOCATE 4, 27: IF Player$(1) <> "" THEN PRINT Player$(1); playx
LOCATE 6, 27: IF Player$(2) <> "" THEN PRINT Player$(2); playo
LOCATE 8, 27: PRINT "Tie"; playt
LOCATE 14, 27: COLOR : PRINT "["; : COLOR 9: PRINT "O"; : COLOR 3: PRINT "]ptions"
a$ = INPUT$(1)
CLS
LOOP

SUB intro
CLS
x = 4
COLOR x
word$ = "a Fallon creation..."

DO WHILE F <= LEN(word$)
F = F + 1
letter$ = MID$(word$, F, 1)
 FOR come = 1 + F TO 10 + F
 LOCATE come - F, come: PRINT letter$
  FOR td = 1 TO 500: NEXT td
 COLOR 0: LOCATE come - F, come: PRINT " "
 COLOR x
 NEXT come
 LOCATE 10, 10 + F: PRINT letter$
LOOP


FOR y = 1 TO 10
FOR td = 1 TO 1000: NEXT td
LOCATE y + 3, 15: PRINT "         "
IF y = 7 THEN LOCATE y + 3, 15: PRINT "llon creation..."

LOCATE y + 4, 15: PRINT "TicTacToe"
NEXT y
key$ = INPUT$(1)
CLS
END SUB

'      Hi, This is a game I made for a school project last year. 
'   I know it's only Tic Tac Toe but it's a fun game to play and most
'   people downloading this game only want it for the source code. The code
'   is not commented at all, because I just started commenting my programs
'   recently. Well I hope you find this game useful, feel free to snipe any
'   code from it.
'
'  Please Email me if you have any cool games you have made or if you have
'  any questions at Jambot@Msn.com or Ranbrook@AOL.com
'
' 
'
SUB intro2
DIM item$(10)
DIM itemg$(10)

item$(1) = "Sound"
item$(2) = "Colors"
item$(3) = "High Scores"
item$(4) = "About"
item$(5) = "Back to game"
flag = 1: x = 1:
SCREEN 0: CLS

DO
FOR i = 1 TO 5
 IF flag = i THEN COLOR 3, 9 ELSE COLOR 3, 0
 LOCATE 4 + i, 4
 PRINT item$(i)
NEXT i
DO: a$ = INKEY$: LOOP UNTIL a$ <> ""

IF a$ = "8" OR a$ = CHR$(0) + CHR$(72) THEN flag = flag - 1
IF a$ = "2" OR a$ = CHR$(0) + CHR$(80) THEN flag = flag + 1
IF flag = 0 THEN flag = 5
IF flag = 6 THEN flag = 1
IF a$ = CHR$(13) THEN
                 SELECT CASE flag
            CASE 1
SCREEN 13: CLS
LINE (0, 0)-(300, 200), 24, BF
LINE (10, 10)-(290, 10), 7
LINE (10, 10)-(10, 190), 7
LINE (290, 10)-(290, 190), 18
LINE (10, 190)-(290, 190), 18
    '    [B]          Move without plotting  [N]    Plot and return
    '    U[n]         Up                     E[n]   Diagonally up and right
    '    D[n]         Down                   F[n]   Diagonally down and right
    '    L[n]         Left                   G[n]   Diagonally down and left
    '    R[n]         Right                  H[n]   Diagonally up and left
    '    M[{+|-}]x,y  Move to point x,y

DRAW "bm 51,45 l4 d3 r4 d3 l4 bm56,45 g1 d4 f1 r3 e1 u4 h1 l3 bm 62,45 d5 f1 r2 e1 u5 bm69,51 u6 m73,51 u6 bm 75,45 d6 r2 e1 u4 h1 l3"
indexb = 1
DO
IF indexb = 1 THEN
x = 20: y = 46: H = 10: L = 12: p = 0
DO
IF p = 0 THEN p = 1 ELSE p = 0

IF p = 1 THEN
 LINE (x, y)-(x + L, y + H), 19, BF
 COLOR 17: LINE (x, y)-(x + L, y): LINE (x, y)-(x, y + H)
 COLOR 27: LINE (x + L, y)-(x + L, y + H): LINE (x, y + H)-(x + L, y + H)
COLOR 4: LINE (x + 1, y + 1)-(x + L - 2, y + H - 2)
         LINE (x + 2, y + 1)-(x + L - 1, y + H - 2)
         LINE (x + 2, y + H - 2)-(x + L - 2, y + 2)
         LINE (x + 1, y + H - 2)-(x + L - 3, y + 2)
END IF
IF p = 0 THEN
 LINE (x, y)-(x + L, y + H), 24, BF
 COLOR 7: LINE (x, y)-(x + L, y): LINE (x, y)-(x, y + H)
 COLOR 17: LINE (x + L, y)-(x + L, y + H): LINE (x, y + H)-(x + L, y + H)
COLOR 4: LINE (x + 2, y + H / 2)-(x + H / 2, y + H - 2)
         LINE (x + 3, y + H / 2)-(x + H / 2 + 1, y + H - 2)
         LINE (x + H / 2, y + H - 1)-(x + H, y + 1)
         LINE (x + H / 2 + 1, y + H - 1)-(x + H + 1, y + 1)
END IF
COLOR 4
LOCATE 16, 5: PRINT "not available yet"
DO: a$ = INKEY$:
IF p = 0 THEN
FOR v = 1 TO 10: SOUND v * 200, .1: NEXT v
END IF
LOOP UNTIL a$ <> ""
LOOP UNTIL a$ = CHR$(27)
indexb = indexb + 1
END IF
IF a$ = CHR$(27) THEN : CLS : SCREEN 0: EXIT DO:
LOOP
                


            CASE 2
                   CLS : SCREEN 13: x = 1: y = 0
                   FOR c = 1 TO 180
                   y = y + 1:
                     IF y = 24 THEN
                       IF x = 1 OR x = 2 OR x = 3 OR x = 4 THEN x = x + 3 ELSE x = x + 4
                       y = 1
                       END IF
                   COLOR c: LOCATE y, x: PRINT c
                   NEXT c
                   LOCATE 25, 5: COLOR 1: PRINT "([X],[O],or [B]oard) =>": choice$ = INPUT$(1)
                   LOCATE 25, 5: COLOR 1: INPUT "(1-255) =>", col
                   IF UCASE$(choice$) = "B" THEN BoardColor = col
                   IF UCASE$(choice$) = "X" THEN Xcolor = col
                   IF UCASE$(choice$) = "O" THEN Ocolor = col
                   SCREEN 0: CLS

            CASE 3
            CASE 4
    CLS : SCREEN 12
    COLOR 11
    LOCATE 11, 30
    COLOR 11
    PRINT "∞±≤€€€€€€€€€€€€€€≤±∞"
    COLOR 3
    PRINT "                             ∞±≤€€€€€€€€€€€€€€≤±∞"
    LOCATE , 30
    COLOR 11
    PRINT "∞±≤€ Jim Fallon €≤±∞"
    COLOR 3
    PRINT "                             ∞±≤€€€€€€€€€€€€€€≤±∞"
    COLOR 11
    PRINT "                             ∞±≤€€€€€€€€€€€€€€≤±∞"
    COLOR 15
    PRINT "                                  PRESENTS:"
    DO: LOOP UNTIL INKEY$ <> ""
     intro
     CLS : SCREEN 0
    
            CASE 5
                 EXIT DO
                 END SELECT
                 END IF
LOOP
SCREEN 13: CLS

END SUB

SUB main
  IF colorx = 0 THEN colorx = 4
  LOCATE 5, 6: PRINT "1"
  LOCATE 5, 15: PRINT "2"
  LOCATE 5, 23: PRINT "3"
  LOCATE 15, 6: PRINT "4"
  LOCATE 15, 15: PRINT "5"
  LOCATE 15, 23: PRINT "6"
  LOCATE 22, 6: PRINT "7"
  LOCATE 22, 15: PRINT "8"
  LOCATE 22, 23: PRINT "9"

 LINE (50, 5)-(53, 171), 20, BF
 LINE (125, 5)-(128, 171), 20, BF
LINE (0, 50)-(176, 53), 20, BF
LINE (0, 125)-(176, 128), 20, BF

 LINE (50, 5)-(52, 170), BoardColor, BF
 LINE (125, 5)-(127, 170), BoardColor, BF
LINE (0, 50)-(175, 52), BoardColor, BF
LINE (0, 125)-(175, 127), BoardColor, BF

END SUB

