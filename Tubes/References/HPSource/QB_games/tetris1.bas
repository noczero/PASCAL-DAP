'===========================================================================
' Subject: GW-TETRIS (TEXT VERSION)           Date: 02-24-97 (16:00)      
'  Author: Sjoerd Verweij                     Code: QB, QBasic, PDS       
'  Origin: harryst@castel.nl                Packet: GAMES.ABC
'===========================================================================
   '*** GW-TETRIS versie 3 *** KIJK/BINAIR SuperLiner *** door Sjoerd Verweij
   SCREEN 0, 1: WIDTH 40: KEY OFF: COLOR 15, 0: CLS : CLEAR : DEFINT A-Z: E$ = CHR$(219)
   PRINT "Score", , , , "Lijn", , " 0", , "Next", , , , , , , , , , "Level", , " 0", , "(c) 1992"
   FOR I = 1 TO 23: LOCATE I, 13: PRINT E$; : COLOR 0: PRINT STRING$(12, E$); : COLOR 15
   PRINT E$; : NEXT I: PRINT "  Stats", "GW-Tetris 3 "; STRING$(14, E$); "Sjoerd Verweij";
   READ N: DIM P$(N, 4), R(N, 4, 4, 4), Q(N), H(N, 4), B(N, 4), A(24), M(N), F$(3), D(3), C(4)
   FOR I = 1 TO 3: READ F$(I), D(I): NEXT: FOR I = 1 TO 4: READ C(I): NEXT
   FOR H = 1 TO N: READ W$: Q(H) = LEN(W$) / 16: FOR I = 1 TO Q(H): READ K$
   RANDOMIZE -TIMER * RND: FOR G = 1 TO LEN(K$)
   P$(H, I) = P$(H, I) + CHR$(C(VAL(MID$(K$, G, 1)))): NEXT: FOR J = 1 TO 4
   IF (INSTR(MID$(W$, (I - 1) * 16 + (J - 1) * 4 + 1, 4), "1") > 0) THEN H(H, I) = H(H, I) + 1
   FOR K = 1 TO 4: C$ = MID$(W$, (I - 1) * 16 + (J - 1) * 4 + K, 1)
   R(H, I, J, K) = VAL(C$): IF C$ = "1" AND B(H, I) < K THEN B(H, I) = K
   NEXT K, J, I, H: T# = 1.5: RANDOMIZE -TIMER: B1 = 5
24 B = B1: X = 2: Y = 6: S = 1: GOSUB 49: B2 = B: B1 = INT(RND * N) + 1: B = B1: GOSUB 48: B = B2: Y = 0: X = 20
   SC! = SC! + Q(B) * INT(RND * 15): COLOR 15: LOCATE 2, 1: PRINT SC!; : M(B) = M(B) + 1
   IF M(B) / 5 = M(B) \ 5 AND M(B) < 100 THEN COLOR B: LOCATE 23 - M(B) / 5, B + 27: PRINT E$;
27 Y = Y + 1: T1! = TIMER: GOSUB 48: WHILE T1! + T# > TIMER
   Z$ = INKEY$: IF LEN(Z$) > 1 THEN Z = ASC(RIGHT$(Z$, 1)) - 70 ELSE Z = ASC(Z$ + CHR$(0)) - 23
   IF Z = -10 THEN O = 0: U = S: W = X: V = Y - 1: WHILE O = 0: V = V + 1: GOSUB 45: WEND: Y = V - 1: T1! = T1! - 3
   IF Z = 10 THEN T1! = T1! - 3
   IF Z = 5 THEN GOSUB 41 ELSE IF Z = 9 THEN GOSUB 42 ELSE IF Z = 7 THEN GOSUB 44
   WEND: U = S: V = Y + 1: W = X: GOSUB 45: IF O = 0 THEN 27
   ON (Y > 1) + 1 GOTO 39: GOSUB 48: FOR I = 0 TO H(B, S) - 1: FOR J = 0 TO B(B, S) - 1
   A(Y + I) = A(Y + I) + R(B, S, I + 1, J + 1) * (2 ^ (X + J - 14)): NEXT J, I: M = 0: FOR H = Y TO 23
   IF A(H) = 4095 THEN GOSUB 50: M = M + 1: SC! = SC! + INT(RND * 100)
   NEXT: IF M < 2 THEN 24
   COLOR 15: LOCATE 15, 1: PRINT F$(M - 1); : SC! = SC! + D(M - 1): NU! = TIMER
   WHILE TIMER < NU! + 1.25: WEND: LOCATE 15, 1: PRINT SPC(10); : GOTO 24
39 CLS : COLOR 14, 0: PRINT "Volgens mij ben je dood! Nog eens?": I$ = INPUT$(1)
   IF I$ = "j" OR I$ = "J" THEN RUN ELSE WIDTH 80: CLS : KEY ON: END
41 U = S: V = Y: W = X - 1: GOSUB 45: X = X + (O = 0): GOSUB 48: RETURN
42 U = S + 1: IF U > Q(B) THEN U = 1
   V = Y: W = X: GOSUB 45: S = -(O = 0) + (S AND (S < Q(B) OR O = 1)): GOSUB 48: RETURN
44 U = S: V = Y: W = X + 1: GOSUB 45: X = X - (O = 0): GOSUB 48: RETURN
45 GOSUB 49: O = -(W > 27 - B(B, S)) - (W < 14): FOR I = 0 TO H(B, U) - 1: FOR J = 0 TO B(B, U) - 1
   IF R(B, U, I + 1, J + 1) = 1 AND SCREEN(V + I, W + J, 1) > 0 THEN O = 1
   NEXT J, I: RETURN
48 COLOR B: LOCATE Y, X: PRINT P$(B, S); : COLOR 15: RETURN
49 COLOR 0: LOCATE Y, X: PRINT P$(B, S); : COLOR 15: RETURN
50 D = D + 1: FOR I = H TO 2 STEP -1: A(I) = A(I - 1): FOR J = 14 TO 25: LOCATE I, J
   COLOR SCREEN(I - 1, J, 1): PRINT E$; : NEXT J, I: SOUND 1000, 1: LOCATE 4, 1: COLOR 15
   PRINT D; : IF D / 20 = D \ 20 THEN T# = T# * .7: SOUND 2000, 2: L = L + 1: LOCATE 11, 1: PRINT L
   ON (L > 3 AND D / 15 = D \ 15) + 1 GOTO 56: FOR I = 2 TO 23: FOR J = 14 TO 25: LOCATE I, J
   COLOR SCREEN(I + 1, J, 1): PRINT E$; : NEXT: A(I) = A(I + 1): NEXT: SOUND 100, 1: COLOR 0
   LOCATE 23, 14: IF L < 8 THEN PRINT STRING$(12, E$);
56 RETURN: DATA 7,DOUBLE,150,TRIPLE,300,TETRIS,900,28,219,29,31
   DATA 1100110000000000,2243322,11110000000000001000100010001000,2222,2432432432,0100111000000000100011001000000011100100000000000100110001000000,12433222,243224332,2224332,1243322432
   DATA 1110100000000000110001000100000000101110000000001000100011000000,22243332,22432432,1124333222,24324322,1110001000000000010001001100000010001110000000001100100010000000,222432,1243243322,243222,224332432
   DATA 01101100000000001000110001000000,122433322,24322432,11000110000000000100110010000000,224322,12433224332

