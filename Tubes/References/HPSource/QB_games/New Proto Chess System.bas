'The New Proto Chess System v2.01, for Qbasic Language.
'Copyright (c) S.D.C. Corporation, 1997.
'Game design and programming: Sebasti n Daniel Casciaro.
'Residence: Capital Federal, Buenos Aires, Argentina.
'
'Author's note:
'This game is SHAREWARE. You have my permission to copy it to anybody.
'Please send your comments to the addresses below.
'Any comments will be welcome. Thank you.
'
'E-Mail: sebastia@satlink.com
'Sebasti n Casciaro's World: http//webs.satlink.com/usuarios/s/sebastia/
'
DECLARE SUB Control ()
DECLARE SUB Jaquenegras ()
DECLARE SUB LegalesNegras ()
DECLARE SUB Enroquenegras ()
DECLARE SUB Empatevirt ()
DECLARE SUB Empate ()
DECLARE SUB Vision ()
DECLARE SUB Algoritmonegras ()
DECLARE SUB Algoritmoblancas ()
DECLARE SUB Evaluation ()
DECLARE SUB Jaquenegrasvirt ()
DECLARE SUB Transfervirt ()
DECLARE SUB Legalesnegrasvirt ()
DECLARE SUB Enroquenegrasvirt ()
DECLARE SUB Movidasnegrasvirt ()
DECLARE SUB Jaqueblancas ()
DECLARE SUB Transfer ()
DECLARE SUB Legalesblancas ()
DECLARE SUB Enroqueblancas ()

DIM SHARED tablero(1 TO 8, 1 TO 8) AS STRING
DIM SHARED tablero2(1 TO 8, 1 TO 8) AS STRING
DIM SHARED tablero3(1 TO 8, 1 TO 8) AS STRING
DIM SHARED legales(1 TO 332) AS INTEGER
DIM SHARED material(1 TO 332) AS INTEGER
DIM SHARED posicion(1 TO 332) AS INTEGER
DIM SHARED movidas(1 TO 2, -3 TO 300) AS INTEGER

tablero(1, 1) = "tb": tablero(8, 1) = "tb"
tablero(2, 1) = "cb": tablero(7, 1) = "cb"
tablero(3, 1) = "ab": tablero(6, 1) = "ab"
tablero(4, 1) = "db": tablero(5, 1) = "rb"

tablero(1, 8) = "tn": tablero(8, 8) = "tn"
tablero(2, 8) = "cn": tablero(7, 8) = "cn"
tablero(3, 8) = "an": tablero(6, 8) = "an"
tablero(4, 8) = "dn": tablero(5, 8) = "rn"

FOR a% = 1 TO 8

    tablero(a%, 2) = "pb": tablero(a%, 7) = "pn"

NEXT a%

mat2% = 32
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'Movida blanca
''''''''''''''
DO

ERASE legales, material, posicion
mov% = mov% + 1
mov50% = mov50% + 1
movi% = 1
Vision

LOCATE 16, 1
        IF mov% > 1 THEN
        rowwini$ = MID$(STR$(movidas(1, mov% - 1)), 2, 1)
        IF rowwini$ = "1" THEN xiw$ = "A"
        IF rowwini$ = "2" THEN xiw$ = "B"
        IF rowwini$ = "3" THEN xiw$ = "C"
        IF rowwini$ = "4" THEN xiw$ = "D"
        IF rowwini$ = "5" THEN xiw$ = "E"
        IF rowwini$ = "6" THEN xiw$ = "F"
        IF rowwini$ = "7" THEN xiw$ = "G"
        IF rowwini$ = "8" THEN xiw$ = "H"
        yiw$ = MID$(STR$(movidas(1, mov% - 1)), 3, 1)
        rowwfin$ = MID$(STR$(movidas(1, mov% - 1)), 4, 1)
        IF rowwfin$ = "1" THEN xfw$ = "A"
        IF rowwfin$ = "2" THEN xfw$ = "B"
        IF rowwfin$ = "3" THEN xfw$ = "C"
        IF rowwfin$ = "4" THEN xfw$ = "D"
        IF rowwfin$ = "5" THEN xfw$ = "E"
        IF rowwfin$ = "6" THEN xfw$ = "F"
        IF rowwfin$ = "7" THEN xfw$ = "G"
        IF rowwfin$ = "8" THEN xfw$ = "H"
        yfw$ = RIGHT$(STR$(movidas(1, mov% - 1)), 1)
        rowbini$ = MID$(STR$(movidas(2, mov% - 1)), 2, 1)
        IF rowbini$ = "1" THEN xib$ = "A"
        IF rowbini$ = "2" THEN xib$ = "B"
        IF rowbini$ = "3" THEN xib$ = "C"
        IF rowbini$ = "4" THEN xib$ = "D"
        IF rowbini$ = "5" THEN xib$ = "E"
        IF rowbini$ = "6" THEN xib$ = "F"
        IF rowbini$ = "7" THEN xib$ = "G"
        IF rowbini$ = "8" THEN xib$ = "H"
        yib$ = MID$(STR$(movidas(2, mov% - 1)), 3, 1)
        rowbfin$ = MID$(STR$(movidas(2, mov% - 1)), 4, 1)
        IF rowbfin$ = "1" THEN xfb$ = "A"
        IF rowbfin$ = "2" THEN xfb$ = "B"
        IF rowbfin$ = "3" THEN xfb$ = "C"
        IF rowbfin$ = "4" THEN xfb$ = "D"
        IF rowbfin$ = "5" THEN xfb$ = "E"
        IF rowbfin$ = "6" THEN xfb$ = "F"
        IF rowbfin$ = "7" THEN xfb$ = "G"
        IF rowbfin$ = "8" THEN xfb$ = "H"
        yfb$ = RIGHT$(STR$(movidas(2, mov% - 1)), 1)
        IF m1$ <> "" THEN PRINT (mov% - 1); "."; xiw$; yiw$; xfw$; yfw$, xib$; yib$; xfb$; yfb$
        END IF
       
Enroqueblancas
t1! = TIMER
t3% = t3% + t2%
Legalesblancas
Transfer
Jaqueblancas

IF jaque$ = "t" THEN

    LOCATE 17, 1
    PRINT "CHECK!"
    BEEP

END IF
   
IF legales(1) = 0 AND jaque$ = "t" THEN
  
    LOCATE 18, 1
    PRINT "0 - 1. CHECK MATE. BLACK WINS."
    END

ELSEIF legales(1) = 0 AND jaque$ = "" THEN
  
    LOCATE 18, 1
    PRINT "1/2 - 1/2. STALEMATE. WHITE HAS NO LEGAL MOVES."
    END

END IF

Empate

IF mov% > 4 AND movidas(2, mov% - 1) = movidas(2, mov% - 3) AND movidas(2, mov% - 2) = movidas(2, mov% - 4) AND movidas(1, mov% - 1) = movidas(1, mov% - 3) AND movidas(1, mov% - 2) = movidas(1, mov% - 4) THEN
  
    LOCATE 18, 1
    PRINT "1/2 - 1/2. DRAW. 3 MOVE REPETITION."
    END

END IF

'Control

mate% = -103: posi% = -14336: movi% = 0

FOR a% = 1 TO n%

    IF material(a%) > mate% OR (material(a%) = mate% AND posicion(a%) > posi%) THEN
   
        mate% = material(a%)
        posi% = posicion(a%)
        movi% = legales(a%)

    END IF
 
NEXT a%

IF mov% = 1 THEN
'    RANDOMIZE TIMER
'    ap% = INT(RND(1) * 8348 + 1)
'    IF ap% > 4253 THEN movi% = 1214
'    IF ap% > 2205 AND ap% < 4254 THEN movi% = 5254
'    IF ap% > 1181 AND ap% < 2206 THEN movi% = 8284
'    IF ap% > 669 AND ap% < 1182 THEN movi% = 6264
'    IF ap% > 413 AND ap% < 670 THEN movi% = 7273
'    IF ap% > 285 AND ap% < 414 THEN movi% = 7183
'    IF ap% > 221 AND ap% < 286 THEN movi% = 2224
'    IF ap% > 157 AND ap% < 222 THEN movi% = 5253
'    IF ap% > 93 AND ap% < 158 THEN movi% = 8283
'    IF ap% > 61 AND ap% < 94 THEN movi% = 6263
'    IF ap% > 45 AND ap% < 62 THEN movi% = 3234
'    IF ap% > 37 AND ap% < 46 THEN movi% = 7274
'    IF ap% > 29 AND ap% < 38 THEN movi% = 2113
'    IF ap% > 21 AND ap% < 30 THEN movi% = 2133
'    IF ap% > 13 AND ap% < 22 THEN movi% = 2223
'    IF ap% > 9 AND ap% < 14 THEN movi% = 4243
'    IF ap% > 5 AND ap% < 10 THEN movi% = 7163
'    IF ap% > 3 AND ap% < 6 THEN movi% = 4244
'    IF ap% > 1 AND ap% < 4 THEN movi% = 1213
'    IF ap% = 1 THEN movi% = 3233

movi% = 7163
END IF

movidas(1, mov%) = movi%
Legalesblancas

'Movida negra
'''''''''''''
m1$ = "v"
movi% = 1
Vision

LOCATE 16, 1
     
        rowwini$ = MID$(STR$(movidas(1, mov%)), 2, 1)
        IF rowwini$ = "1" THEN xiw$ = "A"
        IF rowwini$ = "2" THEN xiw$ = "B"
        IF rowwini$ = "3" THEN xiw$ = "C"
        IF rowwini$ = "4" THEN xiw$ = "D"
        IF rowwini$ = "5" THEN xiw$ = "E"
        IF rowwini$ = "6" THEN xiw$ = "F"
        IF rowwini$ = "7" THEN xiw$ = "G"
        IF rowwini$ = "8" THEN xiw$ = "H"
        yiw$ = MID$(STR$(movidas(1, mov%)), 3, 1)
        rowwfin$ = MID$(STR$(movidas(1, mov%)), 4, 1)
        IF rowwfin$ = "1" THEN xfw$ = "A"
        IF rowwfin$ = "2" THEN xfw$ = "B"
        IF rowwfin$ = "3" THEN xfw$ = "C"
        IF rowwfin$ = "4" THEN xfw$ = "D"
        IF rowwfin$ = "5" THEN xfw$ = "E"
        IF rowwfin$ = "6" THEN xfw$ = "F"
        IF rowwfin$ = "7" THEN xfw$ = "G"
        IF rowwfin$ = "8" THEN xfw$ = "H"
        yfw$ = RIGHT$(STR$(movidas(1, mov%)), 1)
        PRINT mov%; "."; xiw$; yiw$; xfw$; yfw$

Enroquenegras
LegalesNegras

Transfer
Jaquenegras

IF jaque$ = "t" THEN

    LOCATE 17, 1
    PRINT "CHECK!"
    BEEP

END IF

IF legn$ = "" AND jaque$ = "t" THEN
 
    LOCATE 18, 1
    PRINT "1 - 0. CHECK MATE. WHITE WINS."
    END

ELSEIF legn$ = "" AND jaque$ = "" THEN
 
    LOCATE 18, 1
    PRINT "1/2 - 1/2. STALEMATE. BLACK HAS NO LEGAL MOVES."
    END

END IF

Empate

IF mov% > 4 AND movidas(1, mov%) = movidas(1, mov% - 2) AND movidas(1, mov% - 1) = movidas(1, mov% - 3) AND movidas(2, mov% - 1) = movidas(2, mov% - 3) AND movidas(2, mov% - 2) = movidas(2, mov% - 4) THEN
 
    LOCATE 18, 1
    PRINT "1/2 - 1/2. DRAW. 3 MOVE REPETITION."
    END

END IF

DO
    LOCATE 19, 1

    INPUT ; "Black's Move (coordinate notation)"; m$
    IF LCASE$(LEFT$(m$, 1)) = "a" THEN xi% = 1
    IF LCASE$(LEFT$(m$, 1)) = "b" THEN xi% = 2
    IF LCASE$(LEFT$(m$, 1)) = "c" THEN xi% = 3
    IF LCASE$(LEFT$(m$, 1)) = "d" THEN xi% = 4
    IF LCASE$(LEFT$(m$, 1)) = "e" THEN xi% = 5
    IF LCASE$(LEFT$(m$, 1)) = "f" THEN xi% = 6
    IF LCASE$(LEFT$(m$, 1)) = "g" THEN xi% = 7
    IF LCASE$(LEFT$(m$, 1)) = "h" THEN xi% = 8
    yi% = VAL(MID$(m$, 2, 1))
    IF LCASE$(MID$(m$, 3, 1)) = "a" THEN xf% = 1
    IF LCASE$(MID$(m$, 3, 1)) = "b" THEN xf% = 2
    IF LCASE$(MID$(m$, 3, 1)) = "c" THEN xf% = 3
    IF LCASE$(MID$(m$, 3, 1)) = "d" THEN xf% = 4
    IF LCASE$(MID$(m$, 3, 1)) = "e" THEN xf% = 5
    IF LCASE$(MID$(m$, 3, 1)) = "f" THEN xf% = 6
    IF LCASE$(MID$(m$, 3, 1)) = "g" THEN xf% = 7
    IF LCASE$(MID$(m$, 3, 1)) = "h" THEN xf% = 8
    yf% = VAL(RIGHT$(m$, 1))

    movi% = ((xi% * 1000) + (yi% * 100) + (xf% * 10) + yf%)
    movidas(2, mov%) = movi%
    LegalesNegras

LOOP UNTIL movi% = -1

LOOP

SUB Algoritmoblancas

'MODULO ALGORITMOBLANCAS APROBADO!

SHARED xrn%, yrn%, xv%, yv%, postot%

dx% = ABS(xrn% - xv%)
dy% = ABS(yrn% - yv%)

IF dx% = dy% THEN posp% = 15 - (dx% + 1)
IF dx% <> dy% THEN posp% = 15 - (dx% + dy% + 1)

postot% = postot% + posp%

END SUB

SUB Algoritmonegras

'MODULO ALGORITMONEGRAS APROBADO!

SHARED xrb%, yrb%, xv%, yv%, postot%

dx% = ABS(xrb% - xv%)
dy% = ABS(yrb% - yv%)

IF dx% = dy% THEN posp% = 15 - (dx% + 1)
IF dx% <> dy% THEN posp% = 15 - (dx% + dy% + 1)

postot% = postot% - posp%

END SUB

SUB Control

SHARED n%

INPUT "impresora?", i$
IF i$ = "s" THEN

FOR a% = 1 TO n%

LPRINT a%; " legales:"; legales(a%), "material:"; material(a%), "posicion"; posicion(a%)
NEXT a%
ELSEIF i$ <> "s" THEN
FOR a% = 1 TO n%
PRINT a%; " legales:"; legales(a%), "material:"; material(a%), "posicion"; posicion(a%)
DO: LOOP UNTIL INKEY$ = CHR$(13)
NEXT a%
      
END IF

END SUB

SUB Empate

'MODULO EMPATE APROBADO!

SHARED mov50%, mat2%

a% = 0: b% = 0: mat% = 0

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    'experimental
    IF tablero(x%, y%) = "" THEN GOTO fine

    IF tablero(x%, y%) = "cb" THEN a% = a% + 4
    IF tablero(x%, y%) = "ab" THEN a% = a% + 5
    IF tablero(x%, y%) = "tb" OR tablero(x%, y%) = "db" OR tablero(x%, y%) = "pb" THEN a% = a% + 10
  
    IF tablero(x%, y%) = "cn" THEN b% = b% + 4
    IF tablero(x%, y%) = "an" THEN b% = b% + 5
    IF tablero(x%, y%) = "tn" OR tablero(x%, y%) = "dn" OR tablero(x%, y%) = "pn" THEN b% = b% + 10
          
    IF tablero(x%, y%) <> "" THEN mat% = mat% + 1

fine: 'experimental

NEXT y%
NEXT x%

IF a% < 10 AND b% < 10 THEN

    LOCATE 18, 1
    PRINT "1/2 - 1/2. DRAW. INSUFFICIENT MATERIAL."
    END

END IF

IF mat% <> mat2% THEN
  
    mov50% = 0
    mat2% = mat%

END IF

IF mov50% = 50 THEN

    LOCATE 18, 1
    PRINT "1/2 - 1/2. DRAW. 50 MOVES WITHOUT PROGRESS."
    END

END IF

END SUB

SUB Empatevirt

'MODULO EMPATEVIRT APROBADO!

SHARED mate%, posi%

a% = 0: b% = 0

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    IF tablero2(x%, y%) = "" THEN GOTO finev
   
    IF tablero2(x%, y%) = "cb" THEN a% = a% + 4
    IF tablero2(x%, y%) = "ab" THEN a% = a% + 5
    IF tablero2(x%, y%) = "tb" OR tablero2(x%, y%) = "db" OR tablero2(x%, y%) = "pb" THEN a% = a% + 10
 
    IF tablero2(x%, y%) = "cn" THEN b% = b% + 4
    IF tablero2(x%, y%) = "an" THEN b% = b% + 5
    IF tablero2(x%, y%) = "tn" OR tablero2(x%, y%) = "dn" OR tablero2(x%, y%) = "pn" THEN b% = b% + 10
  
finev:

NEXT y%
NEXT x%

IF a% < 10 AND b% < 10 THEN

    mate% = 0
    posi% = 0
          
END IF

END SUB

SUB Enroqueblancas

'MODULO ENROQUEBLANCAS APROBADO!

SHARED ebdama$, ebrey$

IF tablero(1, 1) <> "tb" OR tablero(5, 1) <> "rb" THEN ebdama$ = "f"
IF tablero(5, 1) <> "rb" OR tablero(8, 1) <> "tb" THEN ebrey$ = "f"

END SUB

SUB Enroquenegras

'MODULO ENROQUENEGRAS APROBADO

SHARED endama$, enrey$

IF tablero(1, 8) <> "tn" OR tablero(5, 8) <> "rn" THEN endama$ = "f"
IF tablero(5, 8) <> "rn" OR tablero(8, 8) <> "tn" THEN enrey$ = "f"

END SUB

SUB Enroquenegrasvirt

'MODULO ENROQUENEGRASVIRT APROBADO!

SHARED endama$, enrey$, endamavirt$, enreyvirt$

endamavirt$ = endama$: enreyvirt$ = enrey$

IF tablero2(1, 8) <> "tn" OR tablero2(5, 8) <> "rn" THEN endamavirt$ = "f"
IF tablero2(5, 8) <> "rn" OR tablero2(8, 8) <> "tn" THEN enreyvirt$ = "f"

END SUB

SUB Evaluation

'MODULO EVALUATION APROBADO!

SHARED matp%, xrb%, yrb%, xrn%, yrn%, xv%, yv%, postot%, mate%, posi%, po%, t1!, t2%, t3%

matp% = 0: postot% = 0

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    IF tablero3(x%, y%) = "" THEN GOTO fineva

    IF tablero3(x%, y%) = "tb" THEN matp% = matp% + 5
    IF tablero3(x%, y%) = "cb" OR tablero3(x%, y%) = "ab" THEN matp% = matp% + 3
    IF tablero3(x%, y%) = "db" THEN matp% = matp% + 9
    IF tablero3(x%, y%) = "pb" THEN matp% = matp% + 1

    IF tablero3(x%, y%) = "tn" THEN matp% = matp% - 5
    IF tablero3(x%, y%) = "cn" OR tablero3(x%, y%) = "an" THEN matp% = matp% - 3
    IF tablero3(x%, y%) = "dn" THEN matp% = matp% - 9
    IF tablero3(x%, y%) = "pn" THEN matp% = matp% - 1

    IF tablero3(x%, y%) = "rb" THEN
   
        xrb% = x%: yrb% = y%
   
    END IF

    IF tablero3(x%, y%) = "rn" THEN
  
        xrn% = x%: yrn% = y%
  
    END IF

fineva:

NEXT y%
NEXT x%

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    IF tablero3(x%, y%) = "" THEN GOTO fineva2
   
    IF tablero3(x%, y%) = "tb" OR tablero3(x%, y%) = "db" OR tablero3(x%, y%) = "rb" THEN
   
        FOR a% = (y% + 1) TO 8
       
            xv% = x%: yv% = a%
            Algoritmoblancas
            IF tablero3(x%, y%) = "rb" OR tablero3(x%, a%) <> "" THEN EXIT FOR

        NEXT a%

        FOR a% = (x% + 1) TO 8
      
            xv% = a%: yv% = y%
            Algoritmoblancas
            IF tablero3(x%, y%) = "rb" OR tablero3(a%, y%) <> "" THEN EXIT FOR

        NEXT a%
  
        FOR a% = (y% - 1) TO 1 STEP -1
      
            xv% = x%: yv% = a%
            Algoritmoblancas
            IF tablero3(x%, y%) = "rb" OR tablero3(x%, a%) <> "" THEN EXIT FOR

        NEXT a%

        FOR a% = (x% - 1) TO 1 STEP -1
      
            xv% = a%: yv% = y%
            Algoritmoblancas
            IF tablero3(x%, y%) = "rb" OR tablero3(a%, y%) <> "" THEN EXIT FOR

        NEXT a%
       
    END IF

    IF tablero3(x%, y%) = "ab" OR tablero3(x%, y%) = "db" OR tablero3(x%, y%) = "rb" OR tablero3(x%, y%) = "pb" THEN
   
        IF x% < 8 AND y% < 8 THEN
            
            a% = x%: b% = y%

            DO
           
                a% = a% + 1: b% = b% + 1
                xv% = a%: yv% = b%
               
                IF tablero3(x%, y%) = "pb" THEN
                    yr% = yrn%
                    yrn% = 8
                    Algoritmoblancas
                    yrn% = yr%
                END IF
                                              
                IF tablero3(x%, y%) <> "pb" THEN Algoritmoblancas
                                                                
                IF tablero3(x%, y%) = "rb" OR tablero3(x%, y%) = "pb" OR tablero3(a%, b%) <> "" THEN EXIT DO
               
            LOOP UNTIL a% = 8 OR b% = 8
               
        END IF
       
        IF x% > 1 AND y% < 8 THEN
           
            a% = x%: b% = y%

            DO
          
                a% = a% - 1: b% = b% + 1
                xv% = a%: yv% = b%
               
                IF tablero3(x%, y%) = "pb" THEN
                    yr% = yrn%
                    yrn% = 8
                    Algoritmoblancas
                    yrn% = yr%
                END IF
                                             
                IF tablero3(x%, y%) <> "pb" THEN Algoritmoblancas
               
                IF tablero3(x%, y%) = "rb" OR tablero3(x%, y%) = "pb" OR tablero3(a%, b%) <> "" THEN EXIT DO
              
            LOOP UNTIL a% = 1 OR b% = 8
              
        END IF
   
    END IF

    IF tablero3(x%, y%) = "ab" OR tablero3(x%, y%) = "db" OR tablero3(x%, y%) = "rb" THEN
   
        IF x% < 8 AND y% > 1 THEN
               
            a% = x%: b% = y%
            
            DO
           
                a% = a% + 1: b% = b% - 1
                xv% = a%: yv% = b%
                Algoritmoblancas
                IF tablero3(x%, y%) = "rb" OR tablero3(a%, b%) <> "" THEN EXIT DO

            LOOP UNTIL a% = 8 OR b% = 1

        END IF

        IF x% > 1 AND y% > 1 THEN
              
            a% = x%: b% = y%
           
            DO
          
                a% = a% - 1: b% = b% - 1
                xv% = a%: yv% = b%
                Algoritmoblancas
                IF tablero3(x%, y%) = "rb" OR tablero3(a%, b%) <> "" THEN EXIT DO

            LOOP UNTIL a% = 1 OR b% = 1

        END IF
       
    END IF

    IF tablero3(x%, y%) = "cb" THEN
  
        IF x% > 2 AND y% < 8 THEN
                 
            xv% = x% - 2: yv% = y% + 1
            Algoritmoblancas

        END IF

        IF x% > 1 AND y% < 7 THEN
     
            xv% = x% - 1: yv% = y% + 2
            Algoritmoblancas
     
        END IF

        IF x% < 8 AND y% < 7 THEN
                    
            xv% = x% + 1: yv% = y% + 2
            Algoritmoblancas
     
        END IF

        IF x% < 7 AND y% < 8 THEN
     
            xv% = x% + 2: yv% = y% + 1
            Algoritmoblancas
     
        END IF

        IF x% < 7 AND y% > 1 THEN
     
            xv% = x% + 2: yv% = y% - 1
            Algoritmoblancas
     
        END IF

        IF x% < 8 AND y% > 2 THEN
     
            xv% = x% + 1: yv% = y% - 2
            Algoritmoblancas
     
        END IF

        IF x% > 1 AND y% > 2 THEN
           
            xv% = x% - 1: yv% = y% - 2
            Algoritmoblancas
           
        END IF

        IF x% > 2 AND y% > 1 THEN
     
            xv% = x% - 2: yv% = y% - 1
            Algoritmoblancas
     
        END IF

    END IF

    IF tablero3(x%, y%) = "tn" OR tablero3(x%, y%) = "dn" OR tablero3(x%, y%) = "rn" THEN
  
        FOR a% = (y% + 1) TO 8
      
            xv% = x%: yv% = a%
            Algoritmonegras
            IF tablero3(x%, y%) = "rn" OR tablero3(x%, a%) <> "" THEN EXIT FOR

        NEXT a%

        FOR a% = (x% + 1) TO 8
     
            xv% = a%: yv% = y%
            Algoritmonegras
            IF tablero3(x%, y%) = "rn" OR tablero3(a%, y%) <> "" THEN EXIT FOR

        NEXT a%
 
        FOR a% = (y% - 1) TO 1 STEP -1
       
            xv% = x%: yv% = a%
            Algoritmonegras
            IF tablero3(x%, y%) = "rn" OR tablero3(x%, a%) <> "" THEN EXIT FOR

        NEXT a%
                                     
        FOR a% = (x% - 1) TO 1 STEP -1
     
            xv% = a%: yv% = y%
            Algoritmonegras
            IF tablero3(x%, y%) = "rn" OR tablero3(a%, y%) <> "" THEN EXIT FOR

        NEXT a%
      
    END IF

    IF tablero3(x%, y%) = "an" OR tablero3(x%, y%) = "dn" OR tablero3(x%, y%) = "rn" THEN
  
        IF x% < 8 AND y% < 8 THEN
           
            a% = x%: b% = y%

            DO
          
                a% = a% + 1: b% = b% + 1
                xv% = a%: yv% = b%
                Algoritmonegras
                IF tablero3(x%, y%) = "rn" OR tablero3(a%, b%) <> "" THEN EXIT DO
              
            LOOP UNTIL a% = 8 OR b% = 8
              
        END IF
      
        IF x% > 1 AND y% < 8 THEN
          
            a% = x%: b% = y%

            DO
         
                a% = a% - 1: b% = b% + 1
                xv% = a%: yv% = b%
                Algoritmonegras
                IF tablero3(x%, y%) = "rn" OR tablero3(a%, b%) <> "" THEN EXIT DO
             
            LOOP UNTIL a% = 1 OR b% = 8
             
        END IF
  
    END IF

    IF tablero3(x%, y%) = "an" OR tablero3(x%, y%) = "dn" OR tablero3(x%, y%) = "rn" OR tablero3(x%, y%) = "pn" THEN
  
        IF x% < 8 AND y% > 1 THEN
              
            a% = x%: b% = y%
           
            DO
          
                a% = a% + 1: b% = b% - 1
                xv% = a%: yv% = b%
               
                IF tablero3(x%, y%) = "pn" THEN
                    yr% = yrb%
                    yrb% = 8
                    Algoritmonegras
                    yrb% = yr%
                END IF
                                             
                IF tablero3(x%, y%) <> "pn" THEN Algoritmonegras
               
                IF tablero3(x%, y%) = "rn" OR tablero3(x%, y%) = "pn" OR tablero3(a%, b%) <> "" THEN EXIT DO

            LOOP UNTIL a% = 8 OR b% = 1

        END IF

        IF x% > 1 AND y% > 1 THEN
             
            a% = x%: b% = y%
          
            DO
         
                a% = a% - 1: b% = b% - 1
                xv% = a%: yv% = b%
               
                IF tablero3(x%, y%) = "pn" THEN
                    yr% = yrb%
                    yrb% = 8
                    Algoritmonegras
                    yrb% = yr%
                END IF
                                            
                IF tablero3(x%, y%) <> "pn" THEN Algoritmonegras
               
                IF tablero3(x%, y%) = "rn" OR tablero3(x%, y%) = "pn" OR tablero3(a%, b%) <> "" THEN EXIT DO

            LOOP UNTIL a% = 1 OR b% = 1

        END IF
      
    END IF

    IF tablero3(x%, y%) = "cn" THEN
 
        IF x% > 2 AND y% < 8 THEN
                
            xv% = x% - 2: yv% = y% + 1
            Algoritmonegras

        END IF

        IF x% > 1 AND y% < 7 THEN
    
            xv% = x% - 1: yv% = y% + 2
            Algoritmonegras
    
        END IF

        IF x% < 8 AND y% < 7 THEN
                   
            xv% = x% + 1: yv% = y% + 2
            Algoritmonegras
    
        END IF

        IF x% < 7 AND y% < 8 THEN
    
            xv% = x% + 2: yv% = y% + 1
            Algoritmonegras
    
        END IF

        IF x% < 7 AND y% > 1 THEN
    
            xv% = x% + 2: yv% = y% - 1
            Algoritmonegras
    
        END IF

        IF x% < 8 AND y% > 2 THEN
    
            xv% = x% + 1: yv% = y% - 2
            Algoritmonegras
    
        END IF

        IF x% > 1 AND y% > 2 THEN
          
            xv% = x% - 1: yv% = y% - 2
            Algoritmonegras
          
        END IF

        IF x% > 2 AND y% > 1 THEN
    
            xv% = x% - 2: yv% = y% - 1
            Algoritmonegras
    
        END IF

    END IF

fineva2:

NEXT y%
NEXT x%

IF matp% < mate% OR (matp% = mate% AND postot% < posi%) THEN

    mate% = matp%
    posi% = postot%

END IF

LOCATE 5, 25
po% = po% + 1
PRINT "ANALIZED POSITIONS    : "; po%
LOCATE 7, 25
PRINT "MATERIAL DIFFERENCE   : "; mate%
LOCATE 8, 25
PRINT "POSITIONAL DIFFERENCE : "; posi%
LOCATE 10, 25
PRINT "POSITIONAL HEURISTICS : "
LOCATE 12, 25
t2% = CINT(TIMER - t1!)
PRINT "ELAPSED MOVE TIME     : "; t2%; "s"
LOCATE 13, 25
PRINT "TOTAL ELAPSED TIME    : "; t3% + t2%; "s"

FOR a% = 1 TO ABS(posi% / 40)
LOCATE 10, (49 + a%)
IF posi% > 0 THEN PRINT "+"
IF posi% < 0 THEN PRINT "-"
NEXT a%

FOR a% = ABS(posi% / 20) TO 20
LOCATE 10, (49 + a%)
PRINT " "
NEXT a%

END SUB

SUB Jaqueblancas

'MODULO JAQUEBLANCAS APROBADO!

SHARED jaque$

jaque$ = ""

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    IF tablero2(x%, y%) = "rb" THEN
      
        xrb% = x%: yrb% = y%: EXIT FOR
  
    END IF
                     
NEXT y%
    IF xrb% <> 0 THEN EXIT FOR
NEXT x%

FOR a% = (yrb% + 1) TO 8

    IF tablero2(xrb%, a%) <> "" THEN
  
        IF tablero2(xrb%, a%) = "tn" OR tablero2(xrb%, a%) = "dn" OR tablero2(xrb%, yrb% + 1) = "rn" THEN jaque$ = "t"
        EXIT FOR
  
    END IF

NEXT a%

a% = xrb%: b% = yrb%

IF a% > 1 AND b% < 8 THEN

    DO

        a% = a% - 1: b% = b% + 1

        IF tablero2(a%, b%) <> "" THEN
      
            IF tablero2(a%, b%) = "an" OR tablero2(a%, b%) = "dn" OR tablero2(xrb% - 1, yrb% + 1) = "rn" OR tablero2(xrb% - 1, yrb% + 1) = "pn" THEN jaque$ = "t"
            EXIT DO

        END IF
                 
    LOOP UNTIL a% = 1 OR b% = 8

END IF

FOR a% = (xrb% - 1) TO 1 STEP -1

    IF tablero2(a%, yrb%) <> "" THEN
 
        IF tablero2(a%, yrb%) = "tn" OR tablero2(a%, yrb%) = "dn" OR tablero2(xrb% - 1, yrb%) = "rn" THEN jaque$ = "t"
        EXIT FOR
 
    END IF

NEXT a%

a% = xrb%: b% = yrb%

IF a% > 1 AND b% > 1 THEN

    DO

        a% = a% - 1: b% = b% - 1

        IF tablero2(a%, b%) <> "" THEN
     
            IF tablero2(a%, b%) = "an" OR tablero2(a%, b%) = "dn" OR tablero2(xrb% - 1, yrb% - 1) = "rn" THEN jaque$ = "t"
            EXIT DO

        END IF
                
    LOOP UNTIL a% = 1 OR b% = 1

END IF

FOR a% = (yrb% - 1) TO 1 STEP -1

    IF tablero2(xrb%, a%) <> "" THEN

        IF tablero2(xrb%, a%) = "tn" OR tablero2(xrb%, a%) = "dn" OR tablero2(xrb%, yrb% - 1) = "rn" THEN jaque$ = "t"
        EXIT FOR

    END IF

NEXT a%

a% = xrb%: b% = yrb%

IF a% < 8 AND b% > 1 THEN

    DO

        a% = a% + 1: b% = b% - 1

        IF tablero2(a%, b%) <> "" THEN
    
            IF tablero2(a%, b%) = "an" OR tablero2(a%, b%) = "dn" OR tablero2(xrb% + 1, yrb% - 1) = "rn" THEN jaque$ = "t"
            EXIT DO

        END IF
               
    LOOP UNTIL a% = 8 OR b% = 1

END IF

FOR a% = (xrb% + 1) TO 8

    IF tablero2(a%, yrb%) <> "" THEN

        IF tablero2(a%, yrb%) = "tn" OR tablero2(a%, yrb%) = "dn" OR tablero2(xrb% + 1, yrb%) = "rn" THEN jaque$ = "t"
        EXIT FOR

    END IF

NEXT a%

a% = xrb%: b% = yrb%

IF a% < 8 AND b% < 8 THEN

    DO

        a% = a% + 1: b% = b% + 1

        IF tablero2(a%, b%) <> "" THEN
   
            IF tablero2(a%, b%) = "an" OR tablero2(a%, b%) = "dn" OR tablero2(xrb% + 1, yrb% + 1) = "rn" OR tablero2(xrb% + 1, yrb% + 1) = "pn" THEN jaque$ = "t"
            EXIT DO

        END IF
              
    LOOP UNTIL a% = 8 OR b% = 8

END IF

IF xrb% > 2 AND yrb% < 8 THEN

    IF tablero2(xrb% - 2, yrb% + 1) = "cn" THEN jaque$ = "t"

END IF

IF xrb% > 1 AND yrb% < 7 THEN

    IF tablero2(xrb% - 1, yrb% + 2) = "cn" THEN jaque$ = "t"

END IF

IF xrb% < 8 AND yrb% < 7 THEN

    IF tablero2(xrb% + 1, yrb% + 2) = "cn" THEN jaque$ = "t"

END IF

IF xrb% < 7 AND yrb% < 8 THEN

    IF tablero2(xrb% + 2, yrb% + 1) = "cn" THEN jaque$ = "t"

END IF

IF xrb% < 7 AND yrb% > 1 THEN

    IF tablero2(xrb% + 2, yrb% - 1) = "cn" THEN jaque$ = "t"

END IF

IF xrb% < 8 AND yrb% > 2 THEN

    IF tablero2(xrb% + 1, yrb% - 2) = "cn" THEN jaque$ = "t"

END IF

IF xrb% > 1 AND yrb% > 2 THEN

    IF tablero2(xrb% - 1, yrb% - 2) = "cn" THEN jaque$ = "t"

END IF

IF xrb% > 2 AND yrb% > 1 THEN

    IF tablero2(xrb% - 2, yrb% - 1) = "cn" THEN jaque$ = "t"

END IF

END SUB

SUB Jaquenegras

'MODULO JAQUENEGRAS APROBADO!

SHARED jaque$

jaque$ = ""

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    IF tablero2(x%, y%) = "rn" THEN
    
        xrn% = x%: yrn% = y%: EXIT FOR

    END IF
                   
NEXT y%
    IF xrn% <> 0 THEN EXIT FOR
NEXT x%

FOR a% = (yrn% + 1) TO 8

    IF tablero2(xrn%, a%) <> "" THEN

        IF tablero2(xrn%, a%) = "tb" OR tablero2(xrn%, a%) = "db" OR tablero2(xrn%, yrn% + 1) = "rb" THEN jaque$ = "t"
        EXIT FOR

    END IF

NEXT a%

a% = xrn%: b% = yrn%

IF a% > 1 AND b% < 8 THEN

    DO

        a% = a% - 1: b% = b% + 1

        IF tablero2(a%, b%) <> "" THEN
    
            IF tablero2(a%, b%) = "ab" OR tablero2(a%, b%) = "db" OR tablero2(xrn% - 1, yrn% + 1) = "rb" THEN jaque$ = "t"
            EXIT DO

        END IF
               
    LOOP UNTIL a% = 1 OR b% = 8

END IF

FOR a% = (xrn% - 1) TO 1 STEP -1

    IF tablero2(a%, yrn%) <> "" THEN

        IF tablero2(a%, yrn%) = "tb" OR tablero2(a%, yrn%) = "db" OR tablero2(xrn% - 1, yrn%) = "rb" THEN jaque$ = "t"
        EXIT FOR

    END IF

NEXT a%

a% = xrn%: b% = yrn%

IF a% > 1 AND b% > 1 THEN

    DO

        a% = a% - 1: b% = b% - 1

        IF tablero2(a%, b%) <> "" THEN
   
            IF tablero2(a%, b%) = "ab" OR tablero2(a%, b%) = "db" OR tablero2(xrn% - 1, yrn% - 1) = "rb" OR tablero2(xrn% - 1, yrn% - 1) = "pb" THEN jaque$ = "t"
            EXIT DO

        END IF
              
    LOOP UNTIL a% = 1 OR b% = 1

END IF

FOR a% = (yrn% - 1) TO 1 STEP -1

    IF tablero2(xrn%, a%) <> "" THEN

        IF tablero2(xrn%, a%) = "tb" OR tablero2(xrn%, a%) = "db" OR tablero2(xrn%, yrn% - 1) = "rb" THEN jaque$ = "t"
        EXIT FOR

    END IF

NEXT a%

a% = xrn%: b% = yrn%

IF a% < 8 AND b% > 1 THEN

    DO

        a% = a% + 1: b% = b% - 1

        IF tablero2(a%, b%) <> "" THEN
  
            IF tablero2(a%, b%) = "ab" OR tablero2(a%, b%) = "db" OR tablero2(xrn% + 1, yrn% - 1) = "rb" OR tablero2(xrn% + 1, yrn% - 1) = "pb" THEN jaque$ = "t"
            EXIT DO

        END IF
             
    LOOP UNTIL a% = 8 OR b% = 1

END IF

FOR a% = (xrn% + 1) TO 8

    IF tablero2(a%, yrn%) <> "" THEN

        IF tablero2(a%, yrn%) = "tb" OR tablero2(a%, yrn%) = "db" OR tablero2(xrn% + 1, yrn%) = "rb" THEN jaque$ = "t"
        EXIT FOR

    END IF

NEXT a%

a% = xrn%: b% = yrn%

IF a% < 8 AND b% < 8 THEN

    DO

        a% = a% + 1: b% = b% + 1

        IF tablero2(a%, b%) <> "" THEN
 
            IF tablero2(a%, b%) = "ab" OR tablero2(a%, b%) = "db" OR tablero2(xrn% + 1, yrn% + 1) = "rb" THEN jaque$ = "t"
            EXIT DO

        END IF
            
    LOOP UNTIL a% = 8 OR b% = 8

END IF

IF xrn% > 2 AND yrn% < 8 THEN

    IF tablero2(xrn% - 2, yrn% + 1) = "cb" THEN jaque$ = "t"

END IF

IF xrn% > 1 AND yrn% < 7 THEN

    IF tablero2(xrn% - 1, yrn% + 2) = "cb" THEN jaque$ = "t"

END IF

IF xrn% < 8 AND yrn% < 7 THEN

    IF tablero2(xrn% + 1, yrn% + 2) = "cb" THEN jaque$ = "t"

END IF

IF xrn% < 7 AND yrn% < 8 THEN

    IF tablero2(xrn% + 2, yrn% + 1) = "cb" THEN jaque$ = "t"

END IF

IF xrn% < 7 AND yrn% > 1 THEN

    IF tablero2(xrn% + 2, yrn% - 1) = "cb" THEN jaque$ = "t"

END IF

IF xrn% < 8 AND yrn% > 2 THEN

    IF tablero2(xrn% + 1, yrn% - 2) = "cb" THEN jaque$ = "t"

END IF

IF xrn% > 1 AND yrn% > 2 THEN

    IF tablero2(xrn% - 1, yrn% - 2) = "cb" THEN jaque$ = "t"

END IF

IF xrn% > 2 AND yrn% > 1 THEN

    IF tablero2(xrn% - 2, yrn% - 1) = "cb" THEN jaque$ = "t"

END IF

END SUB

SUB Jaquenegrasvirt

'MODULO JAQUENEGRASVIRT APROBADO!

SHARED jaque$

jaque$ = ""

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    IF tablero3(x%, y%) = "rn" THEN
     
        xrn% = x%: yrn% = y%: EXIT FOR
 
    END IF
                    
NEXT y%
    IF xrn% <> 0 THEN EXIT FOR
NEXT x%

FOR a% = (yrn% + 1) TO 8

    IF tablero3(xrn%, a%) <> "" THEN
 
        IF tablero3(xrn%, a%) = "tb" OR tablero3(xrn%, a%) = "db" OR tablero3(xrn%, yrn% + 1) = "rb" THEN jaque$ = "t"
        EXIT FOR
 
    END IF

NEXT a%

a% = xrn%: b% = yrn%

IF a% > 1 AND b% < 8 THEN

    DO

        a% = a% - 1: b% = b% + 1

        IF tablero3(a%, b%) <> "" THEN
     
            IF tablero3(a%, b%) = "ab" OR tablero3(a%, b%) = "db" OR tablero3(xrn% - 1, yrn% + 1) = "rb" THEN jaque$ = "t"
            EXIT DO

        END IF
                
    LOOP UNTIL a% = 1 OR b% = 8

END IF

FOR a% = (xrn% - 1) TO 1 STEP -1

    IF tablero3(a%, yrn%) <> "" THEN

        IF tablero3(a%, yrn%) = "tb" OR tablero3(a%, yrn%) = "db" OR tablero3(xrn% - 1, yrn%) = "rb" THEN jaque$ = "t"
        EXIT FOR

    END IF

NEXT a%

a% = xrn%: b% = yrn%

IF a% > 1 AND b% > 1 THEN

    DO

        a% = a% - 1: b% = b% - 1

        IF tablero3(a%, b%) <> "" THEN
    
            IF tablero3(a%, b%) = "ab" OR tablero3(a%, b%) = "db" OR tablero3(xrn% - 1, yrn% - 1) = "rb" OR tablero3(xrn% - 1, yrn% - 1) = "pb" THEN jaque$ = "t"
            EXIT DO

        END IF
               
    LOOP UNTIL a% = 1 OR b% = 1

END IF

FOR a% = (yrn% - 1) TO 1 STEP -1

    IF tablero3(xrn%, a%) <> "" THEN

        IF tablero3(xrn%, a%) = "tb" OR tablero3(xrn%, a%) = "db" OR tablero3(xrn%, yrn% - 1) = "rb" THEN jaque$ = "t"
        EXIT FOR

    END IF

NEXT a%

a% = xrn%: b% = yrn%

IF a% < 8 AND b% > 1 THEN

    DO

        a% = a% + 1: b% = b% - 1

        IF tablero3(a%, b%) <> "" THEN
   
            IF tablero3(a%, b%) = "ab" OR tablero3(a%, b%) = "db" OR tablero3(xrn% + 1, yrn% - 1) = "rb" OR tablero3(xrn% + 1, yrn% - 1) = "pb" THEN jaque$ = "t"
            EXIT DO

        END IF
              
    LOOP UNTIL a% = 8 OR b% = 1

END IF

FOR a% = (xrn% + 1) TO 8

    IF tablero3(a%, yrn%) <> "" THEN

        IF tablero3(a%, yrn%) = "tb" OR tablero3(a%, yrn%) = "db" OR tablero3(xrn% + 1, yrn%) = "rb" THEN jaque$ = "t"
        EXIT FOR

    END IF

NEXT a%

a% = xrn%: b% = yrn%

IF a% < 8 AND b% < 8 THEN

    DO

        a% = a% + 1: b% = b% + 1

        IF tablero3(a%, b%) <> "" THEN
  
            IF tablero3(a%, b%) = "ab" OR tablero3(a%, b%) = "db" OR tablero3(xrn% + 1, yrn% + 1) = "rb" THEN jaque$ = "t"
            EXIT DO

        END IF
             
    LOOP UNTIL a% = 8 OR b% = 8

END IF

IF xrn% > 2 AND yrn% < 8 THEN

    IF tablero3(xrn% - 2, yrn% + 1) = "cb" THEN jaque$ = "t"

END IF

IF xrn% > 1 AND yrn% < 7 THEN

    IF tablero3(xrn% - 1, yrn% + 2) = "cb" THEN jaque$ = "t"

END IF

IF xrn% < 8 AND yrn% < 7 THEN

    IF tablero3(xrn% + 1, yrn% + 2) = "cb" THEN jaque$ = "t"

END IF

IF xrn% < 7 AND yrn% < 8 THEN

    IF tablero3(xrn% + 2, yrn% + 1) = "cb" THEN jaque$ = "t"

END IF

IF xrn% < 7 AND yrn% > 1 THEN

    IF tablero3(xrn% + 2, yrn% - 1) = "cb" THEN jaque$ = "t"

END IF

IF xrn% < 8 AND yrn% > 2 THEN

    IF tablero3(xrn% + 1, yrn% - 2) = "cb" THEN jaque$ = "t"

END IF

IF xrn% > 1 AND yrn% > 2 THEN

    IF tablero3(xrn% - 1, yrn% - 2) = "cb" THEN jaque$ = "t"

END IF

IF xrn% > 2 AND yrn% > 1 THEN

    IF tablero3(xrn% - 2, yrn% - 1) = "cb" THEN jaque$ = "t"

END IF

END SUB

SUB Legalesblancas

SHARED jaque$, n%, mate%, posi%, movi%, mov50%, po%, mov%, ebdama$, ebrey$

n% = 0: po% = 0

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    IF RIGHT$(tablero(x%, y%), 1) <> "b" THEN GOTO finlb:

    IF tablero(x%, y%) = "tb" OR tablero(x%, y%) = "db" OR tablero(x%, y%) = "rb" OR tablero(x%, y%) = "pb" THEN
   
        FOR a% = (y% + 1) TO 8
       
            IF RIGHT$(tablero(x%, a%), 1) = "b" OR (tablero(x%, y%) = "pb" AND tablero(x%, a%) <> "") THEN EXIT FOR
            Transfer
            tablero2(x%, a%) = tablero(x%, y%)
            tablero2(x%, y%) = ""
            IF tablero2(x%, a%) = "pb" AND a% = 8 THEN tablero2(x%, a%) = "db"
            Jaqueblancas

            IF jaque$ = "" THEN
           
                IF movi% = (x% * 1000) + (y% * 100) + (x% * 10) + a% THEN
                                                       
                    tablero(x%, a%) = tablero(x%, y%)
                    tablero(x%, y%) = ""
                    IF tablero(x%, a%) = "pb" THEN mov50% = 0
                    IF tablero(x%, a%) = "pb" AND a% = 8 THEN tablero(x%, a%) = "db"
                   
                END IF

                IF movi% = 1 THEN
               
                    n% = n% + 1
                    legales(n%) = (x% * 1000) + (y% * 100) + (x% * 10) + a%
                    Movidasnegrasvirt
                    material(n%) = mate%
                    posicion%(n%) = posi%

                END IF

            END IF

            IF tablero(x%, y%) = "rb" OR tablero(x%, y%) = "pb" OR RIGHT$(tablero(x%, a%), 1) = "n" THEN EXIT FOR
           
        NEXT a%
   
    END IF
   
    IF tablero(x%, y%) = "ab" OR tablero(x%, y%) = "db" OR tablero(x%, y%) = "rb" OR tablero(x%, y%) = "pb" THEN
   
        IF x% < 8 AND y% < 8 THEN
       
            a% = x%: b% = y%

            DO
           
                a% = a% + 1: b% = b% + 1
                IF RIGHT$(tablero(a%, b%), 1) = "b" OR (tablero(x%, y%) = "pb" AND RIGHT$(tablero(a%, b%), 1) <> "n") THEN EXIT DO
                Transfer
                tablero2(a%, b%) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                IF tablero2(a%, b%) = "pb" AND b% = 8 THEN tablero2(a%, b%) = "db"
                Jaqueblancas

                IF jaque$ = "" THEN
               
                    IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + b% THEN
                   
                        tablero(a%, b%) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        IF tablero(a%, b%) = "pb" AND b% = 8 THEN tablero(a%, b%) = "db"

                    END IF
               
                    IF movi% = 1 THEN
                   
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + (a% * 10) + b%
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                       
                    END IF
                        
                END IF
                        
                IF tablero(x%, y%) = "rb" OR tablero(x%, y%) = "pb" OR RIGHT$(tablero(a%, b%), 1) = "n" THEN EXIT DO
           
            LOOP UNTIL a% = 8 OR b% = 8

        END IF

        IF x% > 1 AND y% < 8 THEN
      
            a% = x%: b% = y%

            DO
          
                a% = a% - 1: b% = b% + 1
                IF RIGHT$(tablero(a%, b%), 1) = "b" OR (tablero(x%, y%) = "pb" AND RIGHT$(tablero(a%, b%), 1) <> "n") THEN EXIT DO
                Transfer
                tablero2(a%, b%) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                IF tablero2(a%, b%) = "pb" AND b% = 8 THEN tablero2(a%, b%) = "db"
                Jaqueblancas

                IF jaque$ = "" THEN
              
                    IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + b% THEN
                  
                        tablero(a%, b%) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        IF tablero(a%, b%) = "pb" AND b% = 8 THEN tablero(a%, b%) = "db"

                    END IF
              
                    IF movi% = 1 THEN
                  
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + (a% * 10) + b%
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                      
                    END IF
                       
                END IF
                     
                IF tablero(x%, y%) = "rb" OR tablero(x%, y%) = "pb" OR RIGHT$(tablero(a%, b%), 1) = "n" THEN EXIT DO

            LOOP UNTIL a% = 1 OR b% = 8
                            
        END IF
                            
    END IF

    IF tablero(x%, y%) = "tb" OR tablero(x%, y%) = "db" OR tablero(x%, y%) = "rb" THEN
  
        FOR a% = (x% + 1) TO 8
      
            IF RIGHT$(tablero(a%, y%), 1) = "b" THEN EXIT FOR
            Transfer
            tablero2(a%, y%) = tablero(x%, y%)
            tablero2(x%, y%) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
          
                IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + y% THEN
                                                      
                    tablero(a%, y%) = tablero(x%, y%)
                    tablero(x%, y%) = ""
                   
                END IF

                IF movi% = 1 THEN
              
                    n% = n% + 1
                    legales(n%) = (x% * 1000) + (y% * 100) + (a% * 10) + y%
                    Movidasnegrasvirt
                    material(n%) = mate%
                    posicion%(n%) = posi%

                END IF

            END IF

            IF tablero(x%, y%) = "rb" OR RIGHT$(tablero(a%, y%), 1) = "n" THEN EXIT FOR
          
        NEXT a%
  
        FOR a% = (y% - 1) TO 1 STEP -1
     
            IF RIGHT$(tablero(x%, a%), 1) = "b" THEN EXIT FOR
            Transfer
            tablero2(x%, a%) = tablero(x%, y%)
            tablero2(x%, y%) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
         
                IF movi% = (x% * 1000) + (y% * 100) + (x% * 10) + a% THEN
                                                     
                    tablero(x%, a%) = tablero(x%, y%)
                    tablero(x%, y%) = ""
                  
                END IF

                IF movi% = 1 THEN
             
                    n% = n% + 1
                    legales(n%) = (x% * 1000) + (y% * 100) + (x% * 10) + a%
                    Movidasnegrasvirt
                    material(n%) = mate%
                    posicion%(n%) = posi%

                END IF

            END IF

            IF tablero(x%, y%) = "rb" OR RIGHT$(tablero(x%, a%), 1) = "n" THEN EXIT FOR
         
        NEXT a%
   
        FOR a% = (x% - 1) TO 1 STEP -1
     
            IF RIGHT$(tablero(a%, y%), 1) = "b" THEN EXIT FOR
            Transfer
            tablero2(a%, y%) = tablero(x%, y%)
            tablero2(x%, y%) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
         
                IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + y% THEN
                                                     
                    tablero(a%, y%) = tablero(x%, y%)
                    tablero(x%, y%) = ""
                  
                END IF

                IF movi% = 1 THEN
             
                    n% = n% + 1
                    legales(n%) = (x% * 1000) + (y% * 100) + (a% * 10) + y%
                    Movidasnegrasvirt
                    material(n%) = mate%
                    posicion%(n%) = posi%

                END IF

            END IF

            IF tablero(x%, y%) = "rb" OR RIGHT$(tablero(a%, y%), 1) = "n" THEN EXIT FOR
         
        NEXT a%

    END IF

    IF tablero(x%, y%) = "ab" OR tablero(x%, y%) = "db" OR tablero(x%, y%) = "rb" THEN
  
        IF x% < 8 AND y% > 1 THEN
      
            a% = x%: b% = y%

            DO
          
                a% = a% + 1: b% = b% - 1
                IF RIGHT$(tablero(a%, b%), 1) = "b" THEN EXIT DO
                Transfer
                tablero2(a%, b%) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaqueblancas

                IF jaque$ = "" THEN
              
                    IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + b% THEN
                  
                        tablero(a%, b%) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                       
                    END IF
              
                    IF movi% = 1 THEN
                  
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + (a% * 10) + b%
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                      
                    END IF
                       
                END IF
                       
                IF tablero(x%, y%) = "rb" OR RIGHT$(tablero(a%, b%), 1) = "n" THEN EXIT DO
          
            LOOP UNTIL a% = 8 OR b% = 1

        END IF

        IF x% > 1 AND y% > 1 THEN
     
            a% = x%: b% = y%

            DO
         
                a% = a% - 1: b% = b% - 1
                IF RIGHT$(tablero(a%, b%), 1) = "b" THEN EXIT DO
                Transfer
                tablero2(a%, b%) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaqueblancas

                IF jaque$ = "" THEN
             
                    IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + b% THEN
                 
                        tablero(a%, b%) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                       
                    END IF
             
                    IF movi% = 1 THEN
                 
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + (a% * 10) + b%
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                     
                    END IF
                      
                END IF
                    
                IF tablero(x%, y%) = "rb" OR RIGHT$(tablero(a%, b%), 1) = "n" THEN EXIT DO

            LOOP UNTIL a% = 1 OR b% = 1
                           
        END IF
                           
    END IF

    IF tablero(x%, y%) = "cb" THEN
  
        IF x% > 2 AND y% < 8 THEN
      
            IF RIGHT$(tablero(x% - 2, y% + 1), 1) <> "b" THEN
          
                Transfer
                tablero2(x% - 2, y% + 1) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaqueblancas

                IF jaque$ = "" THEN
          
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% - 2) * 10) + (y% + 1) THEN
                
                        tablero(x% - 2, y% + 1) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                      
                    END IF
            
                    IF movi% = 1 THEN

                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + ((x% - 2) * 10) + (y% + 1)
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                    
                    END IF

                END IF
                 
            END IF
      
        END IF

        IF x% > 1 AND y% < 7 THEN
     
            IF RIGHT$(tablero(x% - 1, y% + 2), 1) <> "b" THEN
         
                Transfer
                tablero2(x% - 1, y% + 2) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaqueblancas

                IF jaque$ = "" THEN
         
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% - 1) * 10) + (y% + 2) THEN
               
                        tablero(x% - 1, y% + 2) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                     
                    END IF
           
                    IF movi% = 1 THEN
               
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + ((x% - 1) * 10) + (y% + 2)
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                   
                    END IF

                END IF
                
            END IF
     
        END IF

        IF x% < 8 AND y% < 7 THEN
     
            IF RIGHT$(tablero(x% + 1, y% + 2), 1) <> "b" THEN
         
                Transfer
                tablero2(x% + 1, y% + 2) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaqueblancas

                IF jaque$ = "" THEN
         
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% + 1) * 10) + (y% + 2) THEN
               
                        tablero(x% + 1, y% + 2) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                     
                    END IF
           
                    IF movi% = 1 THEN
               
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + ((x% + 1) * 10) + (y% + 2)
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                   
                    END IF

                END IF
                
            END IF
     
        END IF

        IF x% < 7 AND y% < 8 THEN
     
            IF RIGHT$(tablero(x% + 2, y% + 1), 1) <> "b" THEN
         
                Transfer
                tablero2(x% + 2, y% + 1) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaqueblancas

                IF jaque$ = "" THEN
         
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% + 2) * 10) + (y% + 1) THEN
               
                        tablero(x% + 2, y% + 1) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                     
                    END IF
           
                    IF movi% = 1 THEN
               
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + ((x% + 2) * 10) + (y% + 1)
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                   
                    END IF

                END IF
                
            END IF
     
        END IF

        IF x% < 7 AND y% > 1 THEN
     
            IF RIGHT$(tablero(x% + 2, y% - 1), 1) <> "b" THEN
         
                Transfer
                tablero2(x% + 2, y% - 1) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaqueblancas

                IF jaque$ = "" THEN
         
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% + 2) * 10) + (y% - 1) THEN
               
                        tablero(x% + 2, y% - 1) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                     
                    END IF
           
                    IF movi% = 1 THEN
               
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + ((x% + 2) * 10) + (y% - 1)
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                   
                    END IF

                END IF
                
            END IF
     
        END IF

        IF x% < 8 AND y% > 2 THEN
     
            IF RIGHT$(tablero(x% + 1, y% - 2), 1) <> "b" THEN
         
                Transfer
                tablero2(x% + 1, y% - 2) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaqueblancas

                IF jaque$ = "" THEN
         
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% + 1) * 10) + (y% - 2) THEN
               
                        tablero(x% + 1, y% - 2) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                     
                    END IF
           
                    IF movi% = 1 THEN
               
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + ((x% + 1) * 10) + (y% - 2)
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                   
                    END IF

                END IF
                
            END IF
     
        END IF

        IF x% > 1 AND y% > 2 THEN
     
            IF RIGHT$(tablero(x% - 1, y% - 2), 1) <> "b" THEN
         
                Transfer
                tablero2(x% - 1, y% - 2) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaqueblancas

                IF jaque$ = "" THEN
         
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% - 1) * 10) + (y% - 2) THEN
               
                        tablero(x% - 1, y% - 2) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                     
                    END IF
           
                    IF movi% = 1 THEN
               
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + ((x% - 1) * 10) + (y% - 2)
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                   
                    END IF

                END IF
                
            END IF
     
        END IF

        IF x% > 2 AND y% > 1 THEN
     
            IF RIGHT$(tablero(x% - 2, y% - 1), 1) <> "b" THEN
         
                Transfer
                tablero2(x% - 2, y% - 1) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaqueblancas

                IF jaque$ = "" THEN
         
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% - 2) * 10) + (y% - 1) THEN
               
                        tablero(x% - 2, y% - 1) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                     
                    END IF
           
                    IF movi% = 1 THEN
               
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + ((x% - 2) * 10) + (y% - 1)
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                   
                    END IF

                END IF
                
            END IF
     
        END IF

    END IF

    IF y% = 2 AND tablero(x%, y%) = "pb" AND tablero(x%, 3) = "" AND tablero(x%, 4) = "" THEN
  
        Transfer
        tablero2(x%, 4) = tablero(x%, y%)
        tablero2(x%, y%) = ""
        Jaqueblancas

        IF jaque$ = "" THEN
      
                    IF movi% = (x% * 1000) + (y% * 100) + (x% * 10) + 4 THEN
               
                        tablero(x%, 4) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        mov50% = 0

                    END IF
           
                    IF movi% = 1 THEN
               
                        n% = n% + 1
                        legales(n%) = (x% * 1000) + (y% * 100) + (x% * 10) + 4
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                   
                    END IF

        END IF

    END IF

    IF tablero(x%, y%) = "rb" THEN
  
        Transfer
        Jaqueblancas

        IF ebdama$ = "" AND jaque$ = "" AND tablero(4, 1) = "" AND tablero(3, 1) = "" AND tablero(2, 1) = "" THEN
  
            tablero2(4, 1) = tablero2(5, 1)
            tablero2(5, 1) = ""
            Jaqueblancas

            IF jaque$ = "" THEN

                tablero2(3, 1) = tablero2(4, 1)
                tablero2(4, 1) = tablero2(1, 1)
                tablero2(1, 1) = ""
                Jaqueblancas

                IF jaque$ = "" THEN

                    IF movi% = 5131 THEN
               
                        tablero(3, 1) = tablero(5, 1)
                        tablero(4, 1) = tablero(1, 1)
                        tablero(1, 1) = ""
                        tablero(5, 1) = ""
                   
                    END IF
           
                    IF movi% = 1 THEN
               
                        n% = n% + 1
                        legales(n%) = 5131
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                   
                    END IF
                                         
                END IF

            END IF
  
        END IF

        Transfer
        Jaqueblancas

        IF ebrey$ = "" AND jaque$ = "" AND tablero(6, 1) = "" AND tablero(7, 1) = "" THEN
 
            tablero2(6, 1) = tablero2(5, 1)
            tablero2(5, 1) = ""
            Jaqueblancas

            IF jaque$ = "" THEN

                tablero2(7, 1) = tablero2(6, 1)
                tablero2(6, 1) = tablero2(8, 1)
                tablero2(8, 1) = ""
                Jaqueblancas

                IF jaque$ = "" THEN

                    IF movi% = 5171 THEN
              
                        tablero(7, 1) = tablero(5, 1)
                        tablero(6, 1) = tablero(8, 1)
                        tablero(5, 1) = ""
                        tablero(8, 1) = ""
                  
                    END IF
          
                    IF movi% = 1 THEN
              
                        n% = n% + 1
                        legales(n%) = 5171
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                  
                    END IF

                END IF

            END IF
 
        END IF

    END IF

    IF tablero(x%, y%) = "pb" THEN
  
        IF movidas(2, mov% - 1) = 1715 AND tablero(2, 5) = "pb" THEN
      
            Transfer
            tablero2(1, 6) = "pb"
            tablero2(1, 5) = ""
            tablero2(2, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
          
                    IF movi% = 2516 THEN
             
                        tablero(1, 6) = "pb"
                        tablero(1, 5) = ""
                        tablero(2, 5) = ""
                       
                    END IF
         
                    IF movi% = 1 THEN
             
                        n% = n% + 1
                        legales(n%) = 2516
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                 
                    END IF

            END IF

        END IF
  
        IF movidas(2, mov% - 1) = 2725 AND tablero(1, 5) = "pb" THEN
     
            Transfer
            tablero2(2, 6) = "pb"
            tablero2(2, 5) = ""
            tablero2(1, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
         
                    IF movi% = 1526 THEN
            
                        tablero(2, 6) = "pb"
                        tablero(2, 5) = ""
                        tablero(1, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 1526
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF
  
        IF movidas(2, mov% - 1) = 2725 AND tablero(3, 5) = "pb" THEN
    
            Transfer
            tablero2(2, 6) = "pb"
            tablero2(3, 5) = ""
            tablero2(2, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
        
                    IF movi% = 3526 THEN
            
                        tablero(2, 6) = "pb"
                        tablero(3, 5) = ""
                        tablero(2, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 3526
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF
  
        IF movidas(2, mov% - 1) = 3735 AND tablero(2, 5) = "pb" THEN
   
            Transfer
            tablero2(3, 6) = "pb"
            tablero2(2, 5) = ""
            tablero2(3, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
       
                    IF movi% = 2536 THEN
            
                        tablero(3, 6) = "pb"
                        tablero(2, 5) = ""
                        tablero(3, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 2536
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF
  
        IF movidas(2, mov% - 1) = 3735 AND tablero(4, 5) = "pb" THEN
  
            Transfer
            tablero2(3, 6) = "pb"
            tablero2(4, 5) = ""
            tablero2(3, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
      
                    IF movi% = 4536 THEN
            
                        tablero(3, 6) = "pb"
                        tablero(4, 5) = ""
                        tablero(3, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 4536
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF
  
        IF movidas(2, mov% - 1) = 4745 AND tablero(3, 5) = "pb" THEN
  
            Transfer
            tablero2(4, 6) = "pb"
            tablero2(4, 5) = ""
            tablero2(3, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
      
                    IF movi% = 3546 THEN
            
                        tablero(4, 6) = "pb"
                        tablero(4, 5) = ""
                        tablero(3, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 3546
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF
 
        IF movidas(2, mov% - 1) = 4745 AND tablero(5, 5) = "pb" THEN
 
            Transfer
            tablero2(4, 6) = "pb"
            tablero2(5, 5) = ""
            tablero2(4, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
     
                    IF movi% = 5546 THEN
            
                        tablero(4, 6) = "pb"
                        tablero(5, 5) = ""
                        tablero(4, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 5546
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF

        IF movidas(2, mov% - 1) = 5755 AND tablero(4, 5) = "pb" THEN
 
            Transfer
            tablero2(5, 6) = "pb"
            tablero2(5, 5) = ""
            tablero2(4, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
     
                    IF movi% = 4556 THEN
            
                        tablero(5, 6) = "pb"
                        tablero(5, 5) = ""
                        tablero(4, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 4556
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF

        IF movidas(2, mov% - 1) = 5755 AND tablero(6, 5) = "pb" THEN

            Transfer
            tablero2(5, 6) = "pb"
            tablero2(6, 5) = ""
            tablero2(5, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
    
                    IF movi% = 6556 THEN
            
                        tablero(5, 6) = "pb"
                        tablero(6, 5) = ""
                        tablero(5, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 5556
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF

        IF movidas(2, mov% - 1) = 6765 AND tablero(5, 5) = "pb" THEN

            Transfer
            tablero2(6, 6) = "pb"
            tablero2(5, 5) = ""
            tablero2(6, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
    
                    IF movi% = 5566 THEN
            
                        tablero(6, 6) = "pb"
                        tablero(5, 5) = ""
                        tablero(6, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 5566
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF

        IF movidas(2, mov% - 1) = 6765 AND tablero(7, 5) = "pb" THEN

            Transfer
            tablero2(6, 6) = "pb"
            tablero2(7, 5) = ""
            tablero2(6, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
   
                    IF movi% = 7566 THEN
            
                        tablero(6, 6) = "pb"
                        tablero(7, 5) = ""
                        tablero(6, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 7566
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF

        IF movidas(2, mov% - 1) = 7775 AND tablero(6, 5) = "pb" THEN

            Transfer
            tablero2(7, 6) = "pb"
            tablero2(7, 5) = ""
            tablero2(6, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
   
                    IF movi% = 6576 THEN
            
                        tablero(7, 6) = "pb"
                        tablero(7, 5) = ""
                        tablero(6, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 6576
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF

        IF movidas(2, mov% - 1) = 7775 AND tablero(8, 5) = "pb" THEN

            Transfer
            tablero2(7, 6) = "pb"
            tablero2(8, 5) = ""
            tablero2(7, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
  
                    IF movi% = 8576 THEN
            
                        tablero(7, 6) = "pb"
                        tablero(8, 5) = ""
                        tablero(7, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
                              
                        n% = n% + 1
                        legales(n%) = 8576
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF

        IF movidas(2, mov% - 1) = 8785 AND tablero(7, 5) = "pb" THEN

            Transfer
            tablero2(8, 6) = "pb"
            tablero2(8, 5) = ""
            tablero2(7, 5) = ""
            Jaqueblancas

            IF jaque$ = "" THEN
 
                    IF movi% = 7586 THEN
            
                        tablero(8, 6) = "pb"
                        tablero(8, 5) = ""
                        tablero(7, 5) = ""
                      
                    END IF
        
                    IF movi% = 1 THEN
            
                        n% = n% + 1
                        legales(n%) = 7586
                        Movidasnegrasvirt
                        material(n%) = mate%
                        posicion%(n%) = posi%
                
                    END IF

            END IF

        END IF

    END IF

finlb:

NEXT y%
NEXT x%

END SUB

SUB LegalesNegras

SHARED jaque$, legn$, mov50%, movi%, mov%, endama$, enrey$

legn$ = ""

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    IF RIGHT$(tablero(x%, y%), 1) <> "n" THEN GOTO finln

    IF tablero(x%, y%) = "tn" OR tablero(x%, y%) = "dn" OR tablero(x%, y%) = "rn" OR tablero(x%, y%) = "pn" THEN
      
        FOR a% = (y% - 1) TO 1 STEP -1
                 
            IF RIGHT$(tablero(x%, a%), 1) = "n" OR (tablero(x%, y%) = "pn" AND tablero(x%, a%) <> "") THEN EXIT FOR
            Transfer
            tablero2(x%, a%) = tablero(x%, y%)
            tablero2(x%, y%) = ""
            IF tablero2(x%, a%) = "pn" AND a% = 1 THEN tablero2(x%, a%) = "dn"
            Jaquenegras

            IF jaque$ = "" THEN
          
                IF movi% = 1 THEN legn$ = "t"
                               
                IF movi% = (x% * 1000) + (y% * 100) + (x% * 10) + a% THEN
                                   
                    tablero(x%, a%) = tablero(x%, y%)
                    tablero(x%, y%) = ""
                    IF tablero(x%, a%) = "pn" THEN mov50% = 0
                    IF tablero(x%, a%) = "pn" AND a% = 1 THEN tablero(x%, a%) = "dn"
                    movi% = -1

                END IF
              
            END IF

            IF tablero(x%, y%) = "rn" OR tablero(x%, y%) = "pn" OR RIGHT$(tablero(x%, a%), 1) = "b" THEN EXIT FOR

        NEXT a%

    END IF

    IF tablero(x%, y%) = "an" OR tablero(x%, y%) = "dn" OR tablero(x%, y%) = "rn" OR tablero(x%, y%) = "pn" THEN
 
        IF x% < 8 AND y% > 1 THEN
     
            a% = x%: b% = y%

            DO
         
                a% = a% + 1: b% = b% - 1
                IF RIGHT$(tablero(a%, b%), 1) = "n" OR (tablero(x%, y%) = "pn" AND RIGHT$(tablero(a%, b%), 1) <> "b") THEN EXIT DO
                Transfer
                tablero2(a%, b%) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                IF tablero2(a%, b%) = "pn" AND b% = 1 THEN tablero2(a%, b%) = "dn"
                Jaquenegras

                IF jaque$ = "" THEN
              
                    IF movi% = 1 THEN legn$ = "t"
                              
                    IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + b% THEN
                                  
                        tablero(a%, b%) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        IF tablero(a%, b%) = "pn" AND b% = 1 THEN tablero(a%, b%) = "dn"
                        movi% = -1

                    END IF
                  
                END IF
                      
                IF tablero(x%, y%) = "rn" OR tablero(x%, y%) = "pn" OR RIGHT$(tablero(a%, b%), 1) = "b" THEN EXIT DO

            LOOP UNTIL a% = 8 OR b% = 1

        END IF

        IF x% > 1 AND y% > 1 THEN
    
            a% = x%: b% = y%

            DO
        
                a% = a% - 1: b% = b% - 1
                IF RIGHT$(tablero(a%, b%), 1) = "n" OR (tablero(x%, y%) = "pn" AND RIGHT$(tablero(a%, b%), 1) <> "b") THEN EXIT DO
                Transfer
                tablero2(a%, b%) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                IF tablero2(a%, b%) = "pn" AND b% = 1 THEN tablero2(a%, b%) = "dn"
                Jaquenegras

                IF jaque$ = "" THEN
             
                    IF movi% = 1 THEN legn$ = "t"
                              
                    IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + b% THEN
                                  
                        tablero(a%, b%) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        IF tablero(a%, b%) = "pn" AND b% = 1 THEN tablero(a%, b%) = "dn"
                        movi% = -1

                    END IF
                 
                END IF
                    
                IF tablero(x%, y%) = "rn" OR tablero(x%, y%) = "pn" OR RIGHT$(tablero(a%, b%), 1) = "b" THEN EXIT DO
              
            LOOP UNTIL a% = 1 OR b% = 1

        END IF
                          
    END IF

    IF tablero(x%, y%) = "tn" OR tablero(x%, y%) = "dn" OR tablero(x%, y%) = "rn" THEN
     
        FOR a% = (y% + 1) TO 8
                
            IF RIGHT$(tablero(x%, a%), 1) = "n" THEN EXIT FOR
            Transfer
            tablero2(x%, a%) = tablero(x%, y%)
            tablero2(x%, y%) = ""
            Jaquenegras

            IF jaque$ = "" THEN
         
                    IF movi% = 1 THEN legn$ = "t"
                             
                    IF movi% = (x% * 1000) + (y% * 100) + (x% * 10) + a% THEN
                                 
                        tablero(x%, a%) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF
             
            END IF

            IF tablero(x%, y%) = "rn" OR RIGHT$(tablero(x%, a%), 1) = "b" THEN EXIT FOR

        NEXT a%

        FOR a% = (x% + 1) TO 8
               
            IF RIGHT$(tablero(a%, y%), 1) = "n" THEN EXIT FOR
            Transfer
            tablero2(a%, y%) = tablero(x%, y%)
            tablero2(x%, y%) = ""
            Jaquenegras

            IF jaque$ = "" THEN
        
                    IF movi% = 1 THEN legn$ = "t"
                             
                    IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + y% THEN
                                 
                        tablero(a%, y%) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF
            
            END IF

            IF tablero(x%, y%) = "rn" OR RIGHT$(tablero(a%, y%), 1) = "b" THEN EXIT FOR

        NEXT a%
      
        FOR a% = (x% - 1) TO 1 STEP -1
              
            IF RIGHT$(tablero(a%, y%), 1) = "n" THEN EXIT FOR
            Transfer
            tablero2(a%, y%) = tablero(x%, y%)
            tablero2(x%, y%) = ""
            Jaquenegras

            IF jaque$ = "" THEN
       
                    IF movi% = 1 THEN legn$ = "t"
                             
                    IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + y% THEN
                                 
                        tablero(a%, y%) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF
           
            END IF

            IF tablero(x%, y%) = "rn" OR RIGHT$(tablero(a%, y%), 1) = "b" THEN EXIT FOR

        NEXT a%

    END IF

    IF tablero(x%, y%) = "an" OR tablero(x%, y%) = "dn" OR tablero(x%, y%) = "rn" THEN

        IF x% < 8 AND y% < 8 THEN
    
            a% = x%: b% = y%

            DO
        
                a% = a% + 1: b% = b% + 1
                IF RIGHT$(tablero(a%, b%), 1) = "n" THEN EXIT DO
                Transfer
                tablero2(a%, b%) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaquenegras

                IF jaque$ = "" THEN
             
                    IF movi% = 1 THEN legn$ = "t"
                             
                    IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + b% THEN
                                 
                        tablero(a%, b%) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF
                 
                END IF
                     
                IF tablero(x%, y%) = "rn" OR RIGHT$(tablero(a%, b%), 1) = "b" THEN EXIT DO

            LOOP UNTIL a% = 8 OR b% = 8

        END IF

        IF x% > 1 AND y% < 8 THEN
   
            a% = x%: b% = y%

            DO
       
                a% = a% - 1: b% = b% + 1
                IF RIGHT$(tablero(a%, b%), 1) = "n" THEN EXIT DO
                Transfer
                tablero2(a%, b%) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaquenegras

                IF jaque$ = "" THEN
            
                    IF movi% = 1 THEN legn$ = "t"
                             
                    IF movi% = (x% * 1000) + (y% * 100) + (a% * 10) + b% THEN
                                 
                        tablero(a%, b%) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF
                
                END IF
                   
                IF tablero(x%, y%) = "rn" OR RIGHT$(tablero(a%, b%), 1) = "b" THEN EXIT DO
             
            LOOP UNTIL a% = 1 OR b% = 8

        END IF
                         
    END IF

    IF tablero(x%, y%) = "cn" THEN

        IF x% > 2 AND y% < 8 THEN
    
            IF RIGHT$(tablero(x% - 2, y% + 1), 1) <> "n" THEN
        
                Transfer
                tablero2(x% - 2, y% + 1) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaquenegras

                IF jaque$ = "" THEN
                  
                    IF movi% = 1 THEN legn$ = "t"
                             
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% - 2) * 10) + (y% + 1) THEN
                                 
                        tablero(x% - 2, y% + 1) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF
                  
                END IF
               
            END IF
    
        END IF

        IF x% > 1 AND y% < 7 THEN
   
            IF RIGHT$(tablero(x% - 1, y% + 2), 1) <> "n" THEN
       
                Transfer
                tablero2(x% - 1, y% + 2) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaquenegras

                IF jaque$ = "" THEN
       
                    IF movi% = 1 THEN legn$ = "t"
                            
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% - 1) * 10) + (y% + 2) THEN
                                
                        tablero(x% - 1, y% + 2) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF

                END IF
              
            END IF
   
        END IF

        IF x% < 8 AND y% < 7 THEN
   
            IF RIGHT$(tablero(x% + 1, y% + 2), 1) <> "n" THEN
       
                Transfer
                tablero2(x% + 1, y% + 2) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaquenegras

                IF jaque$ = "" THEN
       
                    IF movi% = 1 THEN legn$ = "t"
                            
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% + 1) * 10) + (y% + 2) THEN
                                
                        tablero(x% + 1, y% + 2) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF

                END IF
              
            END IF
   
        END IF

        IF x% < 7 AND y% < 8 THEN
   
            IF RIGHT$(tablero(x% + 2, y% + 1), 1) <> "n" THEN
       
                Transfer
                tablero2(x% + 2, y% + 1) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaquenegras

                IF jaque$ = "" THEN
       
                    IF movi% = 1 THEN legn$ = "t"
                            
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% + 2) * 10) + (y% + 1) THEN
                                
                        tablero(x% + 2, y% + 1) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF

                END IF
              
            END IF
   
        END IF

        IF x% < 7 AND y% > 1 THEN
   
            IF RIGHT$(tablero(x% + 2, y% - 1), 1) <> "n" THEN
       
                Transfer
                tablero2(x% + 2, y% - 1) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaquenegras

                IF jaque$ = "" THEN
       
                    IF movi% = 1 THEN legn$ = "t"
                            
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% + 2) * 10) + (y% - 1) THEN
                                
                        tablero(x% + 2, y% - 1) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF

                END IF
              
            END IF
   
        END IF

        IF x% < 8 AND y% > 2 THEN
   
            IF RIGHT$(tablero(x% + 1, y% - 2), 1) <> "n" THEN
       
                Transfer
                tablero2(x% + 1, y% - 2) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaquenegras

                IF jaque$ = "" THEN
       
                    IF movi% = 1 THEN legn$ = "t"
                            
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% + 1) * 10) + (y% - 2) THEN
                                
                        tablero(x% + 1, y% - 2) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF

                END IF
              
            END IF
   
        END IF

        IF x% > 1 AND y% > 2 THEN
   
            IF RIGHT$(tablero(x% - 1, y% - 2), 1) <> "n" THEN
       
                Transfer
                tablero2(x% - 1, y% - 2) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaquenegras

                IF jaque$ = "" THEN
       
                    IF movi% = 1 THEN legn$ = "t"
                            
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% - 1) * 10) + (y% - 2) THEN
                                
                        tablero(x% - 1, y% - 2) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF

                END IF
              
            END IF
   
        END IF

        IF x% > 2 AND y% > 1 THEN
   
            IF RIGHT$(tablero(x% - 2, y% - 1), 1) <> "n" THEN
       
                Transfer
                tablero2(x% - 2, y% - 1) = tablero(x%, y%)
                tablero2(x%, y%) = ""
                Jaquenegras

                IF jaque$ = "" THEN
       
                    IF movi% = 1 THEN legn$ = "t"
                            
                    IF movi% = (x% * 1000) + (y% * 100) + ((x% - 2) * 10) + (y% - 1) THEN
                                
                        tablero(x% - 2, y% - 1) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        movi% = -1

                    END IF

                END IF
              
            END IF
   
        END IF

    END IF

    IF y% = 7 AND tablero(x%, y%) = "pn" AND tablero(x%, 6) = "" AND tablero(x%, 5) = "" THEN

        Transfer
        tablero2(x%, 5) = tablero(x%, y%)
        tablero2(x%, y%) = ""
        Jaquenegras

        IF jaque$ = "" THEN
          
                    IF movi% = 1 THEN legn$ = "t"
                            
                    IF movi% = (x% * 1000) + (y% * 100) + (x% * 10) + 5 THEN
                                
                        tablero(x%, 5) = tablero(x%, y%)
                        tablero(x%, y%) = ""
                        mov50% = 0
                        movi% = -1

                    END IF

        END IF

    END IF

    IF tablero(x%, y%) = "rn" THEN

        Transfer
        Jaquenegras

        IF endama$ = "" AND jaque$ = "" AND tablero(4, 8) = "" AND tablero(3, 8) = "" AND tablero(2, 8) = "" THEN

            tablero2(4, 8) = tablero2(5, 8)
            tablero2(5, 8) = ""
            Jaquenegras

            IF jaque$ = "" THEN

                tablero2(3, 8) = tablero2(4, 8)
                tablero2(4, 8) = tablero2(1, 8)
                tablero2(1, 8) = ""
                Jaquenegras

                IF jaque$ = "" THEN

                    IF movi% = 1 THEN legn$ = "t"
                            
                    IF movi% = 5838 THEN
                                
                        tablero(3, 8) = tablero(5, 8)
                        tablero(4, 8) = tablero(1, 8)
                        tablero(5, 8) = ""
                        tablero(1, 8) = ""
                        movi% = -1

                    END IF
                                       
                END IF

            END IF

        END IF

        Transfer
        Jaquenegras

        IF enrey$ = "" AND jaque$ = "" AND tablero(6, 8) = "" AND tablero(7, 8) = "" THEN

            tablero2(6, 8) = tablero2(5, 8)
            tablero2(5, 8) = ""
            Jaquenegras

            IF jaque$ = "" THEN

                tablero2(7, 8) = tablero2(6, 8)
                tablero2(6, 8) = tablero2(8, 8)
                tablero2(8, 8) = ""
                Jaquenegras

                IF jaque$ = "" THEN
                   
                    IF movi% = 1 THEN legn$ = "t"
                           
                    IF movi% = 5878 THEN
                               
                        tablero(7, 8) = tablero(5, 8)
                        tablero(6, 8) = tablero(8, 8)
                        tablero(5, 8) = ""
                        tablero(8, 8) = ""
                        movi% = -1

                     END IF

                END IF

            END IF

        END IF

    END IF

    IF tablero(x%, y%) = "pn" THEN

        IF movidas(1, mov%) = 1214 AND tablero(2, 4) = "pn" THEN
    
            Transfer
            tablero2(1, 3) = "pn"
            tablero2(1, 4) = ""
            tablero2(2, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
        
                    IF movi% = 1 THEN legn$ = "t"
                           
                    IF movi% = 2413 THEN
                               
                        tablero(1, 3) = "pn"
                        tablero(1, 4) = ""
                        tablero(2, 4) = ""
                        movi% = -1

                    END IF
            END IF

        END IF

        IF movidas(1, mov%) = 2224 AND tablero(1, 4) = "pn" THEN
   
            Transfer
            tablero2(2, 3) = "pn"
            tablero2(2, 4) = ""
            tablero2(1, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
       
                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 1423 THEN
                              
                        tablero(2, 3) = "pn"
                        tablero(2, 4) = ""
                        tablero(1, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 2224 AND tablero(3, 4) = "pn" THEN
  
            Transfer
            tablero2(2, 3) = "pn"
            tablero2(3, 4) = ""
            tablero2(2, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
      
                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 3423 THEN
                              
                        tablero(2, 3) = "pn"
                        tablero(3, 4) = ""
                        tablero(2, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 3234 AND tablero(2, 4) = "pn" THEN
 
            Transfer
            tablero2(3, 3) = "pn"
            tablero2(2, 4) = ""
            tablero2(3, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
     
                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 2433 THEN
                              
                        tablero(3, 3) = "pn"
                        tablero(2, 4) = ""
                        tablero(3, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 3234 AND tablero(4, 4) = "pn" THEN

            Transfer
            tablero2(3, 3) = "pn"
            tablero2(4, 4) = ""
            tablero2(3, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
    
                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 4433 THEN
                              
                        tablero(3, 3) = "pn"
                        tablero(4, 4) = ""
                        tablero(3, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 4244 AND tablero(3, 4) = "pn" THEN

            Transfer
            tablero2(4, 3) = "pn"
            tablero2(4, 4) = ""
            tablero2(3, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
    
                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 3443 THEN
                              
                        tablero(4, 3) = "pn"
                        tablero(4, 4) = ""
                        tablero(3, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 4244 AND tablero(5, 4) = "pn" THEN

            Transfer
            tablero2(4, 3) = "pn"
            tablero2(5, 4) = ""
            tablero2(4, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
   
                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 5443 THEN
                              
                        tablero(4, 3) = "pn"
                        tablero(5, 4) = ""
                        tablero(4, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 5254 AND tablero(4, 4) = "pn" THEN

            Transfer
            tablero2(5, 3) = "pn"
            tablero2(5, 4) = ""
            tablero2(4, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
   
                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 4453 THEN
                              
                        tablero(5, 3) = "pn"
                        tablero(5, 4) = ""
                        tablero(4, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 5254 AND tablero(6, 4) = "pn" THEN

            Transfer
            tablero2(5, 3) = "pn"
            tablero2(6, 4) = ""
            tablero2(5, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
  
                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 6453 THEN
                              
                        tablero(5, 3) = "pn"
                        tablero(6, 4) = ""
                        tablero(5, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 6264 AND tablero(5, 4) = "pn" THEN

            Transfer
            tablero2(6, 3) = "pn"
            tablero2(5, 4) = ""
            tablero2(6, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
  
                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 5463 THEN
                              
                        tablero(6, 3) = "pn"
                        tablero(5, 4) = ""
                        tablero(6, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 6264 AND tablero(7, 4) = "pn" THEN

            Transfer
            tablero2(6, 3) = "pn"
            tablero2(7, 4) = ""
            tablero2(6, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
 
                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 7463 THEN
                              
                        tablero(6, 3) = "pn"
                        tablero(7, 4) = ""
                        tablero(6, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 7274 AND tablero(6, 4) = "pn" THEN

            Transfer
            tablero2(7, 3) = "pn"
            tablero2(7, 4) = ""
            tablero2(6, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN
 
                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 6473 THEN
                              
                        tablero(7, 3) = "pn"
                        tablero(7, 4) = ""
                        tablero(6, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 7274 AND tablero(8, 4) = "pn" THEN

            Transfer
            tablero2(7, 3) = "pn"
            tablero2(8, 4) = ""
            tablero2(7, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN

                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 8473 THEN
                              
                        tablero(7, 3) = "pn"
                        tablero(8, 4) = ""
                        tablero(7, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

        IF movidas(1, mov%) = 8284 AND tablero(7, 4) = "pn" THEN

            Transfer
            tablero2(8, 3) = "pn"
            tablero2(8, 4) = ""
            tablero2(7, 4) = ""
            Jaquenegras

            IF jaque$ = "" THEN

                    IF movi% = 1 THEN legn$ = "t"
                          
                    IF movi% = 7483 THEN
                              
                        tablero(8, 3) = "pn"
                        tablero(8, 4) = ""
                        tablero(7, 4) = ""
                        movi% = -1

                    END IF

            END IF

        END IF

    END IF

finln:

NEXT y%
NEXT x%

END SUB

SUB Legalesnegrasvirt

SHARED jaque$, legnv$, n%, endamavirt$, enreyvirt$

legnv$ = ""

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    IF RIGHT$(tablero2(x%, y%), 1) <> "n" THEN GOTO finlnv

    IF tablero2(x%, y%) = "tn" OR tablero2(x%, y%) = "dn" OR tablero2(x%, y%) = "rn" OR tablero2(x%, y%) = "pn" THEN
       
        FOR a% = (y% - 1) TO 1 STEP -1
                  
            IF RIGHT$(tablero2(x%, a%), 1) = "n" OR (tablero2(x%, y%) = "pn" AND tablero2(x%, a%) <> "") THEN EXIT FOR
            Transfervirt
            tablero3(x%, a%) = tablero2(x%, y%)
            tablero3(x%, y%) = ""
            IF tablero3(x%, a%) = "pn" AND a% = 1 THEN tablero3(x%, a%) = "dn"
            Jaquenegrasvirt

            IF jaque$ = "" THEN
           
                legnv$ = "t"
                Evaluation
               
            END IF

            IF tablero2(x%, y%) = "rn" OR tablero2(x%, y%) = "pn" OR RIGHT$(tablero2(x%, a%), 1) = "b" THEN EXIT FOR

        NEXT a%

    END IF

    IF tablero2(x%, y%) = "an" OR tablero2(x%, y%) = "dn" OR tablero2(x%, y%) = "rn" OR tablero2(x%, y%) = "pn" THEN
  
        IF x% < 8 AND y% > 1 THEN
      
            a% = x%: b% = y%

            DO
          
                a% = a% + 1: b% = b% - 1
                IF RIGHT$(tablero2(a%, b%), 1) = "n" OR (tablero2(x%, y%) = "pn" AND RIGHT$(tablero2(a%, b%), 1) <> "b") THEN EXIT DO
                Transfervirt
                tablero3(a%, b%) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                IF tablero3(a%, b%) = "pn" AND b% = 1 THEN tablero3(a%, b%) = "dn"
                Jaquenegrasvirt

                IF jaque$ = "" THEN
               
                    legnv$ = "t"
                    Evaluation
                   
                END IF
                       
                IF tablero2(x%, y%) = "rn" OR tablero2(x%, y%) = "pn" OR RIGHT$(tablero2(a%, b%), 1) = "b" THEN EXIT DO

            LOOP UNTIL a% = 8 OR b% = 1

        END IF

        IF x% > 1 AND y% > 1 THEN
     
            a% = x%: b% = y%

            DO
         
                a% = a% - 1: b% = b% - 1
                IF RIGHT$(tablero2(a%, b%), 1) = "n" OR (tablero2(x%, y%) = "pn" AND RIGHT$(tablero2(a%, b%), 1) <> "b") THEN EXIT DO
                Transfervirt
                tablero3(a%, b%) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                IF tablero3(a%, b%) = "pn" AND b% = 1 THEN tablero3(a%, b%) = "dn"
                Jaquenegrasvirt

                IF jaque$ = "" THEN
              
                    legnv$ = "t"
                    Evaluation
                  
                END IF
                     
                IF tablero2(x%, y%) = "rn" OR tablero2(x%, y%) = "pn" OR RIGHT$(tablero2(a%, b%), 1) = "b" THEN EXIT DO
               
            LOOP UNTIL a% = 1 OR b% = 1

        END IF
                           
    END IF

    IF tablero2(x%, y%) = "tn" OR tablero2(x%, y%) = "dn" OR tablero2(x%, y%) = "rn" THEN
      
        FOR a% = (y% + 1) TO 8
                 
            IF RIGHT$(tablero2(x%, a%), 1) = "n" THEN EXIT FOR
            Transfervirt
            tablero3(x%, a%) = tablero2(x%, y%)
            tablero3(x%, y%) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
          
                legnv$ = "t"
                Evaluation
              
            END IF

            IF tablero2(x%, y%) = "rn" OR RIGHT$(tablero2(x%, a%), 1) = "b" THEN EXIT FOR

        NEXT a%

        FOR a% = (x% + 1) TO 8
                
            IF RIGHT$(tablero2(a%, y%), 1) = "n" THEN EXIT FOR
            Transfervirt
            tablero3(a%, y%) = tablero2(x%, y%)
            tablero3(x%, y%) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
         
                legnv$ = "t"
                Evaluation
             
            END IF

            IF tablero2(x%, y%) = "rn" OR RIGHT$(tablero2(a%, y%), 1) = "b" THEN EXIT FOR

        NEXT a%
       
        FOR a% = (x% - 1) TO 1 STEP -1
               
            IF RIGHT$(tablero2(a%, y%), 1) = "n" THEN EXIT FOR
            Transfervirt
            tablero3(a%, y%) = tablero2(x%, y%)
            tablero3(x%, y%) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
        
                legnv$ = "t"
                Evaluation
            
            END IF

            IF tablero2(x%, y%) = "rn" OR RIGHT$(tablero2(a%, y%), 1) = "b" THEN EXIT FOR

        NEXT a%

    END IF

    IF tablero2(x%, y%) = "an" OR tablero2(x%, y%) = "dn" OR tablero2(x%, y%) = "rn" THEN
 
        IF x% < 8 AND y% < 8 THEN
     
            a% = x%: b% = y%

            DO
         
                a% = a% + 1: b% = b% + 1
                IF RIGHT$(tablero2(a%, b%), 1) = "n" THEN EXIT DO
                Transfervirt
                tablero3(a%, b%) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN
              
                    legnv$ = "t"
                    Evaluation
                  
                END IF
                      
                IF tablero2(x%, y%) = "rn" OR RIGHT$(tablero2(a%, b%), 1) = "b" THEN EXIT DO

            LOOP UNTIL a% = 8 OR b% = 8

        END IF

        IF x% > 1 AND y% < 8 THEN
    
            a% = x%: b% = y%

            DO
        
                a% = a% - 1: b% = b% + 1
                IF RIGHT$(tablero2(a%, b%), 1) = "n" THEN EXIT DO
                Transfervirt
                tablero3(a%, b%) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN
             
                    legnv$ = "t"
                    Evaluation
                 
                END IF
                    
                IF tablero2(x%, y%) = "rn" OR RIGHT$(tablero2(a%, b%), 1) = "b" THEN EXIT DO
              
            LOOP UNTIL a% = 1 OR b% = 8

        END IF
                          
    END IF

    IF tablero2(x%, y%) = "cn" THEN
 
        IF x% > 2 AND y% < 8 THEN
     
            IF RIGHT$(tablero2(x% - 2, y% + 1), 1) <> "n" THEN
         
                Transfervirt
                tablero3(x% - 2, y% + 1) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN
                   
                    legnv$ = "t"
                    Evaluation
                   
                END IF
                
            END IF
     
        END IF

        IF x% > 1 AND y% < 7 THEN
    
            IF RIGHT$(tablero2(x% - 1, y% + 2), 1) <> "n" THEN
        
                Transfervirt
                tablero3(x% - 1, y% + 2) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN
        
                    legnv$ = "t"
                    Evaluation

                END IF
               
            END IF
    
        END IF

        IF x% < 8 AND y% < 7 THEN
    
            IF RIGHT$(tablero2(x% + 1, y% + 2), 1) <> "n" THEN
        
                Transfervirt
                tablero3(x% + 1, y% + 2) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN
        
                    legnv$ = "t"
                    Evaluation

                END IF
               
            END IF
    
        END IF

        IF x% < 7 AND y% < 8 THEN
    
            IF RIGHT$(tablero2(x% + 2, y% + 1), 1) <> "n" THEN
        
                Transfervirt
                tablero3(x% + 2, y% + 1) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN
        
                    legnv$ = "t"
                    Evaluation

                END IF
               
            END IF
    
        END IF

        IF x% < 7 AND y% > 1 THEN
    
            IF RIGHT$(tablero2(x% + 2, y% - 1), 1) <> "n" THEN
        
                Transfervirt
                tablero3(x% + 2, y% - 1) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN
        
                    legnv$ = "t"
                    Evaluation

                END IF
               
            END IF
    
        END IF

        IF x% < 8 AND y% > 2 THEN
    
            IF RIGHT$(tablero2(x% + 1, y% - 2), 1) <> "n" THEN
        
                Transfervirt
                tablero3(x% + 1, y% - 2) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN
        
                    legnv$ = "t"
                    Evaluation

                END IF
               
            END IF
    
        END IF

        IF x% > 1 AND y% > 2 THEN
    
            IF RIGHT$(tablero2(x% - 1, y% - 2), 1) <> "n" THEN
        
                Transfervirt
                tablero3(x% - 1, y% - 2) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN
        
                    legnv$ = "t"
                    Evaluation

                END IF
               
            END IF
    
        END IF

        IF x% > 2 AND y% > 1 THEN
    
            IF RIGHT$(tablero2(x% - 2, y% - 1), 1) <> "n" THEN
        
                Transfervirt
                tablero3(x% - 2, y% - 1) = tablero2(x%, y%)
                tablero3(x%, y%) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN
        
                    legnv$ = "t"
                    Evaluation

                END IF
               
            END IF
    
        END IF

    END IF

    IF y% = 7 AND tablero2(x%, y%) = "pn" AND tablero2(x%, 6) = "" AND tablero2(x%, 5) = "" THEN
 
        Transfervirt
        tablero3(x%, 5) = tablero2(x%, y%)
        tablero3(x%, y%) = ""
        Jaquenegrasvirt

        IF jaque$ = "" THEN
           
            legnv$ = "t"
            Evaluation

        END IF

    END IF

    IF tablero2(x%, y%) = "rn" THEN
 
        Transfervirt
        Jaquenegrasvirt

        IF endamavirt$ = "" AND jaque$ = "" AND tablero2(4, 8) = "" AND tablero2(3, 8) = "" AND tablero2(2, 8) = "" THEN
 
            tablero3(4, 8) = tablero3(5, 8)
            tablero3(5, 8) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN

                tablero3(3, 8) = tablero3(4, 8)
                tablero3(4, 8) = tablero3(1, 8)
                tablero3(1, 8) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN

                    legnv$ = "t"
                    Evaluation
                                        
                END IF

            END IF
 
        END IF

        Transfervirt
        Jaquenegrasvirt

        IF enreyvirt$ = "" AND jaque$ = "" AND tablero2(6, 8) = "" AND tablero2(7, 8) = "" THEN

            tablero3(6, 8) = tablero3(5, 8)
            tablero3(5, 8) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN

                tablero3(7, 8) = tablero3(6, 8)
                tablero3(6, 8) = tablero3(8, 8)
                tablero3(8, 8) = ""
                Jaquenegrasvirt

                IF jaque$ = "" THEN

                    legnv$ = "t"
                    Evaluation

                END IF

            END IF

        END IF

    END IF

    IF tablero2(x%, y%) = "pn" THEN
 
        IF legales(n%) = 1214 AND tablero2(2, 4) = "pn" THEN
     
            Transfervirt
            tablero3(1, 3) = "pn"
            tablero3(1, 4) = ""
            tablero3(2, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
         
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF
 
        IF legales(n%) = 2224 AND tablero2(1, 4) = "pn" THEN
    
            Transfervirt
            tablero3(2, 3) = "pn"
            tablero3(2, 4) = ""
            tablero3(1, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
        
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF
 
        IF legales(n%) = 2224 AND tablero2(3, 4) = "pn" THEN
   
            Transfervirt
            tablero3(2, 3) = "pn"
            tablero3(3, 4) = ""
            tablero3(2, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
       
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF
 
        IF legales(n%) = 3234 AND tablero2(2, 4) = "pn" THEN
  
            Transfervirt
            tablero3(3, 3) = "pn"
            tablero3(2, 4) = ""
            tablero3(3, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
      
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF
 
        IF legales(n%) = 3234 AND tablero2(4, 4) = "pn" THEN
 
            Transfervirt
            tablero3(3, 3) = "pn"
            tablero3(4, 4) = ""
            tablero3(3, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
     
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF
 
        IF legales(n%) = 4244 AND tablero2(3, 4) = "pn" THEN
 
            Transfervirt
            tablero3(4, 3) = "pn"
            tablero3(4, 4) = ""
            tablero3(3, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
     
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF

        IF legales(n%) = 4244 AND tablero2(5, 4) = "pn" THEN

            Transfervirt
            tablero3(4, 3) = "pn"
            tablero3(5, 4) = ""
            tablero3(4, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
    
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF

        IF legales(n%) = 5254 AND tablero2(4, 4) = "pn" THEN

            Transfervirt
            tablero3(5, 3) = "pn"
            tablero3(5, 4) = ""
            tablero3(4, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
    
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF

        IF legales(n%) = 5254 AND tablero2(6, 4) = "pn" THEN

            Transfervirt
            tablero3(5, 3) = "pn"
            tablero3(6, 4) = ""
            tablero3(5, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
   
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF

        IF legales(n%) = 6264 AND tablero2(5, 4) = "pn" THEN

            Transfervirt
            tablero3(6, 3) = "pn"
            tablero3(5, 4) = ""
            tablero3(6, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
   
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF

        IF legales(n%) = 6264 AND tablero2(7, 4) = "pn" THEN

            Transfervirt
            tablero3(6, 3) = "pn"
            tablero3(7, 4) = ""
            tablero3(6, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
  
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF

        IF legales(n%) = 7274 AND tablero2(6, 4) = "pn" THEN

            Transfervirt
            tablero3(7, 3) = "pn"
            tablero3(7, 4) = ""
            tablero3(6, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
  
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF

        IF legales(n%) = 7274 AND tablero2(8, 4) = "pn" THEN

            Transfervirt
            tablero3(7, 3) = "pn"
            tablero3(8, 4) = ""
            tablero3(7, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN
 
                    legnv$ = "t"
                    Evaluation

            END IF

        END IF

        IF legales(n%) = 8284 AND tablero2(7, 4) = "pn" THEN

            Transfervirt
            tablero3(8, 3) = "pn"
            tablero3(8, 4) = ""
            tablero3(7, 4) = ""
            Jaquenegrasvirt

            IF jaque$ = "" THEN

                    legnv$ = "t"
                    Evaluation

            END IF

        END IF

    END IF

finlnv:

NEXT y%
NEXT x%

END SUB

SUB Movidasnegrasvirt

'falta empate por 3 move rep

SHARED mate%, posi%, legnv$, jaque$

mate% = 103: posi% = 14336

Enroquenegrasvirt
Legalesnegrasvirt
Transfervirt

IF legnv$ = "" AND jaque$ = "" THEN

    mate% = 102
    posi% = 0

ELSEIF legnv$ = "" AND jaque$ = "" THEN

    mate% = 0
    posi% = 0

END IF

Empatevirt

END SUB

SUB Transfer

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    tablero2(x%, y%) = tablero(x%, y%)

NEXT y%
NEXT x%

END SUB

SUB Transfervirt

FOR x% = 1 TO 8
FOR y% = 1 TO 8

    tablero3(x%, y%) = tablero2(x%, y%)

NEXT y%
NEXT x%

END SUB

SUB Vision

'MODULO VISION APROBADO!

CLS

FOR a% = 9 TO 2 STEP -1
LOCATE 11 - a%, 10
PRINT a% - 1
LOCATE 11 - a%, 1
PRINT a% - 1
LOCATE 1, 12 - a%
PRINT UCASE$(CHR$(106 - a%))
LOCATE 10, 12 - a%
PRINT UCASE$(CHR$(106 - a%))
NEXT a%

FOR x% = 2 TO 9
FOR y% = 2 TO 9

    IF tablero(y% - 1, x% - 1) = "" THEN GOTO finv

    LOCATE (11 - x%), y% + 1

    COLOR 11
    IF tablero(y% - 1, x% - 1) = "tb" THEN PRINT "R"
    IF tablero(y% - 1, x% - 1) = "cb" THEN PRINT "N"
    IF tablero(y% - 1, x% - 1) = "ab" THEN PRINT "B"
    IF tablero(y% - 1, x% - 1) = "db" THEN PRINT "Q"
    IF tablero(y% - 1, x% - 1) = "rb" THEN PRINT "K"
    IF tablero(y% - 1, x% - 1) = "pb" THEN PRINT "P"
    COLOR 3
      
    COLOR 2
    IF tablero(y% - 1, x% - 1) = "tn" THEN PRINT "R"
    IF tablero(y% - 1, x% - 1) = "cn" THEN PRINT "N"
    IF tablero(y% - 1, x% - 1) = "an" THEN PRINT "B"
    IF tablero(y% - 1, x% - 1) = "dn" THEN PRINT "Q"
    IF tablero(y% - 1, x% - 1) = "rn" THEN PRINT "K"
    IF tablero(y% - 1, x% - 1) = "pn" THEN PRINT "P"
    COLOR 3

finv:

NEXT y%
NEXT x%
      
LOCATE 1, 25
PRINT "The New Proto Chess System v2.01 for Qbasic"
BEEP

END SUB

