'
'  THE
'        _________  ______
'       /~~~~~~~~/ /~~~~~~\                  ()
'      / /~~~~/ / / /~~\  / ____   ____     _  ___
'     / /    / / / /___/ / /~~~~\ //~~\\   // /~~~\
'    / /    / / / _~~~~ / //~~~// \\   ~  // //~~~~
'   / / _  / / / /~~\  / //   //   \\    // //
'  / /__\\/ / / /___/ / //   // _   \\  //  \\
' /  ~~~~  / /  ~~~~ / / ----^\ \\__// //    \~~~/
' ~~~~~~~~~  ~~~~~~~~  ~~~~~~ ~  ~~~~  ~      ~~~
'
'                                                 STATION
'
'    http://www.bitsmart.com/qbstation
'
'    (qbstation@hotmail.com)
'

DECLARE SUB resetter ()
DECLARE SUB theend ()
DECLARE SUB pause ()
DECLARE SUB really ()
DECLARE SUB main ()
DECLARE SUB showscrs ()
DECLARE SUB hiscores ()
DECLARE SUB set ()
DECLARE SUB ender ()
DECLARE SUB moves ()
DECLARE SUB level ()
DECLARE SUB setup ()
DIM SHARED player(100)
DIM SHARED z(11)
DIM SHARED z$(11)
DIM SHARED w(11)
DIM SHARED w$(11)
DIM SHARED slow(5000)
DIM SHARED box(24)
DIM SHARED n1(500)
DIM SHARED n2(500)

COMMON SHARED x, y, w, z, l, f, score, qwe

setup

main

SUB ender
LOCATE 10, 34
PRINT "Out of time!"
FOR tt = 1 TO 20
FOR t = 1000 TO 5000 STEP 1000
SOUND t, .2
NEXT t
NEXT tt
FOR t = 1 TO 2000
NEXT t
PUT (x, y), player
FOR t = 1 TO 4000
NEXT t

hiscores
main

END SUB

SUB hiscores
CLS
OPEN "slowdown.scr" FOR INPUT AS #1
INPUT #1, a$, a, B$, B, c$, c, d$, d, e$, e, f$, f, g$, g, h$, h, i$, i, j$, j
CLOSE

z(1) = a: z$(1) = a$
z(2) = B: z$(2) = B$
z(3) = c: z$(3) = c$
z(4) = d: z$(4) = d$
z(5) = e: z$(5) = e$
z(6) = f: z$(6) = f$
z(7) = g: z$(7) = g$
z(8) = h: z$(8) = h$
z(9) = i: z$(9) = i$
z(10) = j: z$(10) = j$

' A new score + name will be added here

z(11) = score

'find largest number

FOR y = 1 TO 10
IF z(y) < z(11) THEN dfg = 1
NEXT y
IF dfg = 1 THEN  ELSE GOTO endofsub

LOCATE 8, 29
PRINT "You got a high score!"
LOCATE 10, 29
INPUT "What is your name "; z$(11)

FOR r = 1 TO 10
n = z(1)
FOR q = 1 TO 11
IF z(q) > n THEN n = z(q)
NEXT q

FOR q = 1 TO 11
SELECT CASE z(q)
        CASE -1: GOTO nextq
        CASE n: w(r) = n
                w$(r) = z$(q)
                z(q) = -1
                q = 11
        CASE ELSE
END SELECT

nextq:
NEXT q
NEXT r

OPEN "slowdown.scr" FOR OUTPUT AS #1
WRITE #1, w$(1), w(1), w$(2), w(2), w$(3), w(3), w$(4), w(4), w$(5), w(5), w$(6), w(6), w$(7), w(7), w$(8), w(8), w$(9), w(9), w$(10), w(10)
CLOSE

endofsub:
END SUB

SUB level
LOCATE 1, 1
PRINT "Time:         "
LOCATE 1, 65
PRINT "Score:"; score
l = l + 1
f = l * 80
PUT (x, y), player
LOCATE 10, 35
PRINT "Level ", l
LOCATE 12, 35
PRINT "Time ", f
rty:
a$ = INKEY$
IF a$ = " " THEN  ELSE GOTO rty
LOCATE 10, 35
PRINT "              "
LOCATE 12, 35
PRINT "              "
x = 300
y = 170
PUT (x, y), player

p = l * 4
pp = l * 3
q = CINT(RND * 1)
IF q = 1 THEN z = p ELSE z = -p
q = CINT(RND * 1)
IF q = 1 THEN w = pp ELSE w = -pp
END SUB

SUB main
begin:
SCREEN 9, , 0, 0
CLS
FOR t = 1 TO 300
PSET (RND * 640, RND * 350), 7
NEXT t

FOR a = 1 TO 3
PUT (105 - a, 35 + a), slow, OR
NEXT a

SCREEN 9, , 0, 0

FOR x = 1 TO 150 STEP 6
PUT (x + 30, 200), n1
PUT (332 - x, 200), n2
FOR e = 1 TO 30
NEXT e
PUT (x + 30, 200), n1
PUT (332 - x, 200), n2
NEXT x
PUT (x + 30, 200), n1
PUT (332 - x, 200), n2


LOCATE 19, 21
PRINT "Press the Space Bar to begin         ..."
LOCATE 21, 19
PRINT "Press Enter to see the Slowdown score board."
LOCATE 23, 25
PRINT "Press Esc to Exit from         ."
COLOR 10
LOCATE 19, 50
PRINT "Slowdown"
LOCATE 21, 42
PRINT "Slowdown"
LOCATE 23, 48
PRINT "Slowdown"
COLOR 15

oiu:

PUT (77, 20), box
FOR x = 80 TO 550 STEP 3
PUT (x - 3, 20), box
PUT (x, 20), box
a$ = INKEY$
IF a$ = " " THEN GOTO start
IF a$ = CHR$(13) THEN GOTO hiscr
IF a$ = CHR$(27) THEN GOTO endgame
IF a$ = CHR$(0) + "D" THEN resetter
FOR q = 1 TO 5
NEXT q
NEXT x
PUT (x - 3, 20), box

PUT (550, 17), box
FOR x = 20 TO 140 STEP 3
PUT (550, x - 3), box
PUT (550, x), box
a$ = INKEY$
IF a$ = " " THEN GOTO start
IF a$ = CHR$(13) THEN GOTO hiscr
IF a$ = CHR$(27) THEN GOTO endgame
FOR q = 1 TO 5
NEXT q
NEXT x
PUT (550, x - 3), box

PUT (553, 140), box
FOR x = 550 TO 80 STEP -3
PUT (x + 3, 140), box
PUT (x, 140), box
a$ = INKEY$
IF a$ = " " THEN GOTO start
IF a$ = CHR$(13) THEN GOTO hiscr
IF a$ = CHR$(27) THEN GOTO endgame
FOR q = 1 TO 5
NEXT q
NEXT x
PUT (x + 3, 140), box

PUT (80, 143), box
FOR x = 140 TO 20 STEP -3
PUT (80, x + 3), box
PUT (80, x), box
a$ = INKEY$
IF a$ = " " THEN GOTO start
IF a$ = CHR$(13) THEN GOTO hiscr
IF a$ = CHR$(27) THEN GOTO endgame
FOR q = 1 TO 5
NEXT q
NEXT x
PUT (80, x + 3), box

GOTO oiu

hiscr:
CLS
showscrs
CLS
GOTO begin

start:

l = 0
f = 0
score = 0

here:
set
level
moves
GOTO here

endgame:
PUT STEP(0, 0), box
LOCATE 19, 21
PRINT "                                        "
LOCATE 21, 19
PRINT "                                            "
LOCATE 23, 25
PRINT "                                "
PUT (181, 200), n1
PUT (181, 200), n2


FOR x = 1 TO 1000
NEXT x

COLOR 9
LOCATE 15, 27
PRINT "Jack Thomson, January 1996"
COLOR 15
FOR x = 1 TO 5000
NEXT x

FOR y = 0 TO 352
LINE (0, y)-(640, y), 14
LINE (0, y - 1)-(640, y - 1), 0
NEXT y
CLS
END

END SUB

SUB moves
the:
t = TIMER + .05
DO
LOOP UNTIL TIMER >= t

f = f - 1
LOCATE 1, 1
PRINT "Time:"; f
IF f < 1 THEN ender
a$ = INKEY$
SELECT CASE a$
        CASE CHR$(0) + "H": w = w - 1
        CASE CHR$(0) + "P": w = w + 1
        CASE CHR$(0) + "K": z = z - 1
        CASE CHR$(0) + "M": z = z + 1
        CASE CHR$(27): really
        CASE CHR$(0) + ";": pause
        CASE ELSE
END SELECT

PUT (x, y), player
x = x + z
y = y + w

SELECT CASE x
CASE IS < 10: x = 10
              z = -z
CASE IS > 608: x = 608
               z = -z
END SELECT
SELECT CASE y
CASE IS < 25: y = 25
              w = -w
CASE IS > 319: y = 319
               w = -w
END SELECT
PUT (x, y), player

IF w = 0 THEN IF z = 0 THEN GOTO endsub
FOR t = 1 TO 50
NEXT t
GOTO the

endsub:
score = score + f

END SUB

SUB pause
uhb:
a$ = INKEY$
IF a$ = "" THEN GOTO uhb ELSE
END SUB

SUB really
SCREEN 9, , 1, 1
LOCATE 10, 15
PRINT "Do you really want to quit this game of          ?"
COLOR 10
LOCATE 10, 55
PRINT "Slowdown"
COLOR 15
ert:
a$ = INKEY$
IF UCASE$(a$) = "Y" THEN main
IF a$ = "" THEN GOTO ert ELSE
CLS
SCREEN 9, , 0, 0
END SUB

SUB resetter
CLS
LOCATE 10, 21
PRINT "Do you want to erase the high scores ?"
sdf:
a$ = UCASE$(INKEY$)
IF a$ = "" THEN GOTO sdf
IF a$ = "Y" THEN  ELSE GOTO ijn
OPEN "slowdown.scr" FOR OUTPUT AS #1
n$ = "..................."
n = 0
WRITE #1, n$, n, n$, n, n$, n, n$, n, n$, n, n$, n, n$, n, n$, n, n$, n, n$, n
CLOSE
ijn:
main
END SUB

SUB set
CLS

ll = l + 1

IF ll > 0 THEN IF ll < 5.5 THEN h = 1
IF ll > 5.5 THEN IF ll < 10.5 THEN h = 2
IF ll > 10.5 THEN IF ll < 15.5 THEN h = 3
IF ll > 15.5 THEN IF ll < 20.5 THEN h = 4
IF ll > 20.5 THEN IF ll < 25.5 THEN h = 9
IF ll > 25.5 THEN IF ll < 30.5 THEN h = 10
IF ll > 30.5 THEN IF ll < 35.5 THEN h = 15
IF ll > 35.5 THEN theend

str:

LINE (0, 15)-(640, 350), h, BF
LINE (9, 24)-(629, 339), 0, BF
FOR t = 1 TO 100
PSET ((RND * 600) + 20, (RND * 300) + 30), 15
NEXT t
w = 0
z = 0
qwe = 0
x = 300
y = 170
PUT (x, y), player

END SUB

SUB setup
SCREEN 9, , 0, 1
CLS
RANDOMIZE TIMER
LINE (0, 0)-(5, 5), 12, BF
PSET (0, 0), 4
PSET (0, 5), 4
PSET (5, 0), 4
PSET (5, 5), 4
GET (0, 0)-(5, 5), box
CLS

LINE (0, 0)-(19, 19), 4, BF
PRESET (0, 0)
PRESET (19, 0)
PRESET (19, 19)
PRESET (0, 19)
GET (0, 0)-(19, 19), player
CLS
score = 0

'SLOWDOWN
a = 55
c = -30

LINE (100 + a, 50 + c)-(50 + a, 50 + c), 8
LINE (50 + a, 50 + c)-(50 + a, 100 + c), 8
LINE (90 + a, 100 + c)-(90 + a, 130 + c), 8
LINE (90 + a, 130 + c)-(50 + a, 130 + c), 8
LINE (50 + a, 130 + c)-(50 + a, 140 + c), 8
LINE (100 + a, 90 + c)-(60 + a, 90 + c), 8
LINE (60 + a, 90 + c)-(60 + a, 60 + c), 15
LINE (60 + a, 60 + c)-(100 + a, 60 + c), 15
LINE (100 + a, 60 + c)-(100 + a, 50 + c), 15
LINE (50 + a, 100 + c)-(90 + a, 100 + c), 15
LINE (50 + a, 140 + c)-(100 + a, 140 + c), 15
LINE (100 + a, 140 + c)-(100 + a, 90 + c), 15

LINE (110 + a, 50 + c)-(120 + a, 140 + c), 8, B
LINE (120 + a, 50 + c)-(120 + a, 140 + c), 15
LINE (120 + a, 140 + c)-(110 + a, 140 + c), 15
         
LINE (130 + a, 90 + c)-(180 + a, 140 + c), 8, B
LINE (140 + a, 100 + c)-(170 + a, 130 + c), 8, B
LINE (180 + a, 90 + c)-(180 + a, 140 + c), 15
LINE (180 + a, 140 + c)-(130 + a, 140 + c), 15
LINE (170 + a, 100 + c)-(140 + a, 100 + c), 15
LINE (140 + a, 100 + c)-(140 + a, 130 + c), 15

LINE (190 + a, 90 + c)-(200 + a, 90 + c), 8
LINE (210 + a, 90 + c)-(220 + a, 90 + c), 8
LINE (230 + a, 90 + c)-(240 + a, 90 + c), 8
LINE (190 + a, 90 + c)-(190 + a, 140 + c), 8
LINE (200 + a, 130 + c)-(210 + a, 130 + c), 8
LINE (210 + a, 90 + c)-(210 + a, 130 + c), 8
LINE (230 + a, 90 + c)-(230 + a, 130 + c), 8
LINE (230 + a, 130 + c)-(220 + a, 130 + c), 8
LINE (200 + a, 90 + c)-(200 + a, 130 + c), 15
LINE (220 + a, 90 + c)-(220 + a, 130 + c), 15
LINE (240 + a, 90 + c)-(240 + a, 140 + c), 15
LINE (240 + a, 140 + c)-(190 + a, 140 + c), 15

PSET (300 + a, 50 + c), 8
DRAW "l10 d40 l40 d50"
LINE (260 + a, 100 + c)-(290 + a, 130 + c), 8, B
LINE (260 + a, 100 + c)-(290 + a, 100 + c), 15
LINE (260 + a, 100 + c)-(260 + a, 130 + c), 15
LINE (300 + a, 50 + c)-(300 + a, 140 + c), 15
LINE (300 + a, 140 + c)-(250 + a, 140 + c), 15

LINE (310 + a, 90 + c)-(360 + a, 140 + c), 8, B
LINE (320 + a, 100 + c)-(350 + a, 130 + c), 8, B
LINE (360 + a, 90 + c)-(360 + a, 140 + c), 15
LINE (360 + a, 140 + c)-(310 + a, 140 + c), 15
LINE (350 + a, 100 + c)-(320 + a, 100 + c), 15
LINE (320 + a, 100 + c)-(320 + a, 130 + c), 15

LINE (370 + a, 90 + c)-(380 + a, 90 + c), 8
LINE (390 + a, 90 + c)-(400 + a, 90 + c), 8
LINE (410 + a, 90 + c)-(420 + a, 90 + c), 8
LINE (370 + a, 90 + c)-(370 + a, 140 + c), 8
LINE (380 + a, 130 + c)-(390 + a, 130 + c), 8
LINE (390 + a, 90 + c)-(390 + a, 130 + c), 8
LINE (410 + a, 90 + c)-(410 + a, 130 + c), 8
LINE (410 + a, 130 + c)-(410 + a, 130 + c), 8
LINE (400 + a, 130 + c)-(410 + a, 130 + c), 8
LINE (380 + a, 90 + c)-(380 + a, 130 + c), 15
LINE (400 + a, 90 + c)-(400 + a, 130 + c), 15
LINE (420 + a, 90 + c)-(420 + a, 140 + c), 15
LINE (420 + a, 140 + c)-(370 + a, 140 + c), 15

LINE (430 + a, 90 + c)-(430 + a, 140 + c), 8
LINE (430 + a, 90 + c)-(480 + a, 90 + c), 8
LINE (470 + a, 100 + c)-(470 + a, 140 + c), 8
LINE (430 + a, 140 + c)-(440 + a, 140 + c), 15
LINE (440 + a, 140 + c)-(440 + a, 100 + c), 15
LINE (440 + a, 100 + c)-(470 + a, 100 + c), 15
LINE (480 + a, 90 + c)-(480 + a, 140 + c), 15
LINE (480 + a, 140 + c)-(470 + a, 140 + c), 15
GET (50 + a, 50 + c)-(480 + a, 140 + c), slow
CLS

COLOR 14
PRINT "D s g e   n   r t e   y J c   h m o "
GET (0, 0)-(300, 12), n1
CLS
PRINT " e i n d a d w i t n b   a k T o s n"
GET (0, 0)-(300, 12), n2
CLS


SCREEN 9, , 0, 0

END SUB

SUB showscrs
CLS
OPEN "slowdown.scr" FOR INPUT AS #1
INPUT #1, a$, a, B$, B, c$, c, d$, d, e$, e, f$, f, g$, g, h$, h, i$, i, j$, j
CLOSE
z(1) = a: z$(1) = a$
z(2) = B: z$(2) = B$
z(3) = c: z$(3) = c$
z(4) = d: z$(4) = d$
z(5) = e: z$(5) = e$
z(6) = f: z$(6) = f$
z(7) = g: z$(7) = g$
z(8) = h: z$(8) = h$
z(9) = i: z$(9) = i$
z(10) = j: z$(10) = j$
LINE (130, 34)-(450, 220), 8, B
LINE (129, 33)-(451, 221), 7, B
LINE (128, 32)-(452, 222), 15, B
LINE (127, 31)-(453, 223), 7, B
LINE (126, 30)-(454, 224), 8, B

LOCATE 4, 34
PRINT "High Scores"
LINE (130, 60)-(450, 60), 8
LINE (129, 61)-(451, 61), 7
LINE (128, 62)-(452, 62), 15
LINE (129, 63)-(451, 63), 7
LINE (130, 64)-(450, 64), 8

COLOR 14
LOCATE 6, 20
PRINT z$(1)
LOCATE 6, 50
PRINT z(1)
COLOR 15
FOR q = 2 TO 9
LOCATE q + 5, 20
PRINT z$(q)
LOCATE q + 5, 50
PRINT z(q)
NEXT q

LOCATE 20, 14
PRINT "Press Esc to return to the Slowdown main menu..."
COLOR 10
LOCATE 20, 41
PRINT "Slowdown"
COLOR 15

yui:
a$ = INKEY$
IF a$ = CHR$(27) THEN  ELSE GOTO yui

END SUB

SUB theend
SCREEN 9, , 0, 0
LINE (0, 15)-(640, 350), 14, BF
LINE (9, 24)-(629, 339), 0, BF
FOR t = 1 TO 100
PSET ((RND * 600) + 20, (RND * 300) + 30), 15
NEXT t

LOCATE 10, 22
PRINT "You are absolutely incredable !!!!!!"
LOCATE 12, 19
PRINT "You have just beaten the Game of Slowdown!"
LOCATE 14, 30
PRINT "CONGRADULATIONS!!!!!"

FOR tt = 1 TO 15
FOR t = 1000 TO 5000 STEP 1000
SOUND t, .2
NEXT t
NEXT tt

FOR y = 1 TO 15
FOR x = 1000 TO 3000 STEP 10
SOUND x, .05
NEXT x
NEXT y
FOR t = 1 TO 5000
NEXT t

hiscores
main

END SUB

