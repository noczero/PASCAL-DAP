 DECLARE SUB movepaddle (column%, row%, oldrow%)
 DECLARE SUB testshift (lup%, ldn%, rup%, rdn%)
 DECLARE FUNCTION delay! ()
 DECLARE FUNCTION testball% (col%, row%)
 SCREEN 12
 '
 'draw playing screen
 LINE (1, 1)-(639, 479), 14, B
 LINE (1, 165)-(1, 315), 0
 LINE (639, 165)-(639, 315), 0
 'draw ball and then get into array
 CIRCLE (320, 240), 4, 14
 PAINT (322, 242), 14
 DIM ball%(1 TO 38)
 GET (316, 236)-(324, 244), ball%
 'draw left paddle, get into array, and PUT right paddle on screen
 LINE (6, 6)-(13, 35), 14, BF
 DIM SHARED paddle%(1 TO 62)
 GET (6, 6)-(13, 35), paddle%
 PUT (626, 6), paddle%, PSET
 '
 esc$ = CHR$(27)
 hdir% = -6: player1% = 0: player2% = 0
 speedcomp! = delay!
 '****************** Start of main program loop *********************
 DO
   cline% = 6: oldcline% = 6: p1line% = 6: p2line% = 6: ccol% = 6
   vdir% = -2: ballhpos% = 316: ballvpos% = 236
   oldballvpos% = ballvpos%: oldballhpos% = ballhpos%
   IF hdir% < 0 THEN hdir% = -6 ELSE hdir% = 6
   '******************* Start of game play loop *********************
   DO
    'process ball movement
    t% = testball%(ballhpos%, ballvpos%)
    IF t% AND 1 THEN vdir% = vdir% * -1
    IF t% AND 2 THEN hdir% = hdir% * -1
    'plot new ball position..
    ballhpos% = ballhpos% + hdir%: ballvpos% = ballvpos% + vdir%
    'wipe old ball position
    PUT (oldballhpos%, oldballvpos%), ball%, XOR
    'score if ball is out of playing field..
    IF ballhpos% > 628 THEN
      ballhpos% = 628: SOUND 100, 1
      player1% = player1% + 1: EXIT DO
    END IF
    IF ballhpos% < 2 THEN
      ballhpos% = 2: SOUND 100, 1
      player2% = player2% + 1: EXIT DO
    END IF
    'move ball if not a score..
    PUT (ballhpos%, ballvpos%), ball%, PSET
    oldballhpos% = ballhpos%: oldballvpos% = ballvpos%
    'see if ESCape key pressed..
    a$ = INKEY$
    'check for player keypresses - move in increments of 8 screen lines
     testshift lup%, ldn%, rup%, rdn%
       IF lup% THEN                       'left shift
         oldrow% = p1line%
         IF p1line% > 13 THEN p1line% = p1line% - 8
         movepaddle 6, p1line%, oldrow%
       END IF
       IF ldn% THEN                        'left ctrl
         oldrow% = p1line%
         IF p1line% < 441 THEN p1line% = p1line% + 8
         movepaddle 6, p1line%, oldrow%
       END IF
       IF rup% THEN
         oldrow% = p2line%
         IF p2line% > 13 THEN p2line% = p2line% - 8
         movepaddle 626, p2line%, oldrow%
       END IF
       IF rdn% THEN
         oldrow% = p2line%
         IF p2line% < 441 THEN p2line% = p2line% + 8
         movepaddle 626, p2line%, oldrow%
       END IF
       'CPU delay value from delay!() function
       SOUND 32767, speedcomp!
       'if either player has more than 20 points then game over..
       IF player1% > 20 OR player2% > 20 THEN a$ = esc$
   LOOP UNTIL a$ = esc$
   '******************** End of game play loop **********************
   '
   IF a$ <> esc$ THEN
     movepaddle 6, 6, p1line%
     movepaddle 626, 6, p2line%
     PUT (316, 236), ball%, XOR
   END IF
   '
   LOCATE 3, 10: PRINT USING "###"; player1%;
   LOCATE 3, 65: PRINT USING "###"; player2%;
   SLEEP 1
   IF a$ <> esc$ THEN
     LOCATE 3, 10: PRINT SPACE$(3);
     LOCATE 3, 65: PRINT SPACE$(3);
   END IF
 LOOP UNTIL a$ = esc$
 '******************  End of main program Loop  *********************
 '
 LOCATE 14, 22: PRINT "***  Game Over  --  Press Any Key  ***";
 DO: LOOP UNTIL LEN(INKEY$)
 SCREEN 0
 END

 FUNCTION delay!
 '********** Calculates delay time for your CPU ************
 '********** so playing speed remains constant  ************
   DEF SEG = &H40
   FOR x% = 1 TO 32766
     IF test% <> PEEK(&H6C) THEN
       ticks! = ticks! + 1: test% = PEEK(&H6C)
     END IF
   NEXT x%
   DEF SEG
   delay! = ticks! / 6
 END FUNCTION

 SUB movepaddle (column%, row%, oldrow%)
 '********** Moves a player's paddle based on keyed input ************
  PUT (column%, oldrow%), paddle%, XOR
  PUT (column%, row%), paddle%, PSET
 END SUB

 FUNCTION testball% (col%, row%)
 '********** checks to see if ball has hit paddle or wall ***********
 testball% = 0: c% = col% - 3: r% = row% - 3
 'test top and bottom
 FOR x% = c% + 1 TO c% + 12
   test% = POINT(x%, r%): IF test% THEN s% = s% OR 1: EXIT FOR
   test% = POINT(x%, r% + 16): IF test% THEN s% = s% OR 1: EXIT FOR
 NEXT x%
 'test sides
 FOR x% = row% TO row% + 10
   test% = POINT(c%, x%): IF test% THEN s% = s% OR 2: EXIT FOR
   test% = POINT(c% + 16, x%): IF test% THEN s% = s% OR 2: EXIT FOR
 NEXT x%
 testball% = s%
 END FUNCTION

 SUB testshift (lup%, ldn%, rup%, rdn%)
 '******* Checks for keypresses from both left and right players *******
 '******* Player 1 uses left Shift_Key and CTRL_Key on that side *******
 '******* Player 2 uses right Shift_Key and ALT_Key on that side *******
   lup% = 0: ldn% = 0: rup% = 0: rdn% = 0
   DEF SEG = &H0
   x% = PEEK(&H417)
   y% = PEEK(&H418)
   IF x% AND 1 THEN rup% = -1
   IF x% AND 2 THEN lup% = -1
   IF y% AND 1 THEN ldn% = -1
   IF (x% AND 8) AND NOT (y% AND 2) THEN rdn% = -1
   DEF SEG
 END SUB

