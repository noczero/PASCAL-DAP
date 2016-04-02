        '         €€€€€   €€€€€ €€€€€€€€€  €€€€€€€
        '         €    €  €             € €                
        '         €     € €             € €             
        '         €     € €             €  €           
        '         €    €  €             €   €€           
        '         €€€€€   €€€           €     €€€      
        '         € €     €     €      €         €€
        '         €  €    €      €    €           €€
        '         €   €   €       €€€€           €€
        '         €    €  €€€€€€€      €€€€€€€€€€€
        '
        ' A QB car racing game by Robert Gavelin (gavelin@hem.passagen.se)
        ' Visit http://hem.passagen.se/gavelin/qbasic.htm for updates & other progs
        '
        '   Made in Sweden
        '                          * PRESS F5 TO START *
        '
        DECLARE SUB bana1 ()
        DECLARE SUB bana2 ()
        DECLARE SUB bana3 ()
        DECLARE SUB bana4 ()
        DECLARE SUB bilbana1 ()
        DECLARE SUB bilbana2 ()
        DECLARE SUB bilbana3 ()
        DECLARE SUB bilbana4 ()
        DECLARE SUB nylista ()
        DECLARE SUB konvert (tiid!)
        DECLARE SUB setcolor ()
        DECLARE SUB finish ()
        DECLARE SUB calibrate ()
        DECLARE SUB filhant ()
        DECLARE SUB intro ()
        DECLARE SUB stoppa (n!)
        DECLARE SUB options ()
        DECLARE SUB hiscore ()
        DECLARE SUB help ()
        DECLARE SUB Start ()
        DECLARE SUB gameover ()
        DECLARE SUB ritabil ()
        COMMON SHARED c, cc, x, y, dx, dy, u, varv, v, speed, totaltid, sluttid
        DIM SHARED dam AS INTEGER, ljud AS INTEGER, bana AS INTEGER
        DIM SHARED tid AS STRING * 9, dead AS INTEGER, color1 AS INTEGER, color2 AS INTEGER
        DIM SHARED max1 AS INTEGER, min1 AS INTEGER, cent1 AS INTEGER, joy AS INTEGER
        DIM SHARED postnr AS INTEGER, bannamn(1 TO 4) AS STRING
        TYPE hiscoredata
         namn AS STRING * 16
         score AS SINGLE
        END TYPE
        DIM SHARED hidata AS hiscoredata
        KEY(0) STOP
        ON KEY(8) GOSUB toggle      ' Ljud pÜ/av med F 8
        ON KEY(10) GOSUB avsluta    ' Snabbt avslut med F 10
        KEY(8) ON
        KEY(10) ON

        bannamn(1) = "Fastec Ring"
        bannamn(2) = "Springfield"
        bannamn(3) = " Bundyland "
        bannamn(4) = " Dazemaze  "

        '--- Start ---
        CLOSE
        CLS 0
        OPEN "options.rej" FOR RANDOM AS #1 LEN = 2
        CALL filhant
        OPEN "hiscore.rej" FOR RANDOM AS #2 LEN = 20
        GET #2, 1, hidata
        IF hidata.score <> 4 THEN CALL nylista
        CALL filhant
        CALL intro


startet:               'HÑr Ñr menyn
        CLS 0
        SCREEN 12
        VIEW PRINT (1) TO (30)
        mval = 1
menyst:
        CLS
        COLOR 9
        FOR lr = 4 TO 24
        LOCATE lr, 15: PRINT "€"
        NEXT lr
        FOR lk = 15 TO 65
        LOCATE 24, lk: PRINT "€"
        NEXT lk
        FOR lr = 4 TO 24
        LOCATE lr, 65: PRINT "€"
        NEXT lr
        FOR lk = 15 TO 65
        LOCATE 4, lk: PRINT "€"
        NEXT lk

        LOCATE 8, 30: PRINT " * * * R E J S * * * "
menyn:
        IF mval < 1 THEN mval = 1
        IF mval > 5 THEN mval = 5

        IF mval = 1 THEN
        COLOR 9
        LOCATE 12, 32: PRINT "o"
        ELSE
        COLOR 7
        LOCATE 12, 32: PRINT " "
        END IF
        LOCATE 12, 35: PRINT "Play game"
        IF mval = 2 THEN
        COLOR 9
        LOCATE 14, 32: PRINT "o"
        ELSE
        COLOR 7
        LOCATE 14, 32: PRINT " "
        END IF
        LOCATE 14, 35: PRINT "Options"
        IF mval = 3 THEN
        COLOR 9
        LOCATE 16, 32: PRINT "o"
        ELSE
        COLOR 7
        LOCATE 16, 32: PRINT " "
        END IF
        LOCATE 16, 35: PRINT "Hi-scores"
        IF mval = 4 THEN
        COLOR 9
        LOCATE 18, 32: PRINT "o"
        ELSE
        COLOR 7
        LOCATE 18, 32: PRINT " "
        END IF
        LOCATE 18, 35: PRINT "How to play"

        IF mval = 5 THEN
        COLOR 9
        LOCATE 20, 32: PRINT "o"
        ELSE
        COLOR 7
        LOCATE 20, 32: PRINT " "
        END IF
        LOCATE 20, 35: PRINT "Quit"

        DO
        m$ = INKEY$
        LOOP UNTIL m$ <> ""
        SELECT CASE m$
        CASE CHR$(0) + "H": IF mval > 1 THEN mval = mval - 1
        IF ljud% = 1 THEN SOUND 200, 1.5
        CASE CHR$(0) + "P": IF mval < 5 THEN mval = mval + 1
        IF ljud% = 1 THEN SOUND 200, 1.5
        CASE CHR$(13): GOTO hoppa
        END SELECT
        GOTO menyn
hoppa:
        IF mval = 1 THEN GOTO slutet
        IF mval = 2 THEN CALL options
        IF mval = 3 THEN CALL hiscore
        IF mval = 4 THEN CALL help
        IF mval = 5 THEN
        COLOR 7
        CLS 0
        SHELL "echo Thank you for playing REJS"
        SHELL "echo Visit http://hem.passagen.se/gavelin/qbasic.htm for updates & other progs "
        SHELL "echo.   "
        COLOR 0: SYSTEM
        END IF

        GOTO menyst

slutet:


        speed = 0
        v = 0
        varv = 1
        minut = 0
        dam% = 0
        u = v
        '--- Event trapping ---
        ON KEY(11) GOSUB gasa
        ON KEY(14) GOSUB bromsa
        ON KEY(13) GOSUB hoger
        ON KEY(12) GOSUB vanster
        ON STRIG(0) GOSUB gasa
        ON STRIG(4) GOSUB bromsa
        STRIG(0) OFF
        STRIG(4) OFF
        FOR n = 11 TO 14
         KEY(n) OFF
        NEXT n
        CALL filhant

Banval:
        SELECT CASE bana%
        CASE IS = 1: CALL bana1
        CASE IS = 2: CALL bana2
        CASE IS = 3: CALL bana3
        CASE IS = 4: CALL bana4
        CASE ELSE: bana% = 1: GOTO Banval
        END SELECT

        GOTO startet



        '**********************************
        '--- Rutiner vid hÑndelseinfÜng ---

gasa:
        speed = speed + 1
        IF speed > 25 THEN speed = 25
        RETURN

bromsa:
        speed = speed - 2
        IF speed < 0 THEN speed = 0
        RETURN

vanster:
        v = v - .35
        RETURN

hoger:
        v = v + .35
        RETURN



toggle:
        ljud% = ljud% + 1
        IF ljud% > 1 THEN ljud% = 0
        PUT #1, 3, ljud%
        CALL filhant
        RETURN
                                  
avsluta:
        CLS 0
        COLOR 0
        SYSTEM

        RETURN

        ' Grafik till introt
        DATA 04,04,04,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
        DATA 00,04,04,04,04,04,00,00,00,00,00,00,00,00,00,00,00,00,00,00
        DATA 00,04,04,04,04,04,04,04,04,08,08,08,08,00,00,00,00,00,00,00
        DATA 00,00,04,04,04,04,04,04,04,04,08,08,08,08,04,04,00,00,00,00
        DATA 00,00,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,00,00
        DATA 00,00,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04
        DATA 00,00,00,08,08,00,00,00,00,00,00,00,00,08,08,00,00,00,00,00
        DATA 00,00,00,08,08,00,00,00,00,00,00,00,00,08,08,00,00,00,00,00

        SUB bana1
        CALL filhant
        '--- Spelet ---
        STRIG(0) OFF
        STRIG(4) OFF
         FOR n = 11 TO 14
          KEY(n) OFF
         NEXT n
        CLS
        SCREEN 12
        VIEW SCREEN (1, 1)-(639, 420), , 0
        VIEW PRINT (29) TO (30)
        bilbana1
        x = 165
        y = 355
        c = color1%
        cc = 0
        v = 0
        speed = 0
        dam% = 0
        dead% = 0

        ritabil
        LINE (148, 310)-(152, 410), 15, BF
        CALL Start
        nolltid = TIMER       ' Starten
        starttid = TIMER
        IF joy% = 0 THEN
         FOR n = 11 TO 14
          KEY(n) ON
         NEXT n
        ELSE
         STRIG(0) ON
         STRIG(4) ON
        END IF
        CLS 2
        DO UNTIL INKEY$ = CHR$(27)       '  v

        c = color1%
        cc = 0
        u = v
        IF dead% <> 1 THEN CALL ritabil


        '--- Fartminskning ---
        IF speed > 0 THEN speed = speed - .3
        IF speed < 0 THEN speed = 0

        IF joy% = 1 THEN
         DO
          jstick% = STICK(0)
         LOOP UNTIL jstick% < max1% + 10 AND jstick% > min1% - 10
        SELECT CASE jstick%
           CASE IS > (cent1% + max1%) / 2: v = v + .25             ' Hîger / vÑnster
           CASE IS < (cent1% + min1%) / 2: v = v - .25
          END SELECT
        END IF

        '--- Ljud ---           
        s = 37 + 10 * speed
        IF ljud% = 1 THEN SOUND s, 2
        IF ljud% = 0 THEN SOUND 30000, 2

        COLOR 15
        tiden = TIMER - nolltid
        IF tiden < 1 THEN
        tid$ = STR$(minut) + "." + "00" + STR$(TIMER - nolltid)
        ELSEIF tiden < 10 THEN
        tid$ = STR$(minut) + "." + "0" + STR$(TIMER - nolltid)
        ELSEIF tiden >= 60 THEN
        minut = minut + 1
        nolltid = TIMER
        tid$ = STR$(minut) + "." + STR$(TIMER - nolltid)
        ELSE
        tid$ = STR$(minut) + "." + STR$(TIMER - nolltid)
        END IF
        IF dead% = 0 THEN LOCATE 29, 2: PRINT tid$; SPACE$(2)
        IF dead% = 2 THEN LOCATE 29, 2: PRINT stid$; SPACE$(2)
         SELECT CASE varv
          CASE IS < 5: LOCATE 29, 14: PRINT "Lap: "; varv
          CASE IS = 5: COLOR 14: LOCATE 29, 14: PRINT "Final lap "
          CASE IS > 5: COLOR 14: LOCATE 29, 14: PRINT "==FINISH=="
         END SELECT
        COLOR 15

        IF dam% > 99 THEN COLOR 4
        LOCATE 29, 25: PRINT "Damage:  "; dam%;
        LOCATE 29, 38: PRINT "%"
        LOCATE 29, 60: COLOR 9: PRINT "REJS  v1.0"
        ' ---

        c = 7
        cc = 7
        IF dead% <> 1 THEN CALL ritabil


        dx = speed * COS(v)
        dy = speed * SIN(v)
        x = x + dx
        y = y + dy

        '--- Banans utseende ---
        IF x > 625 THEN CALL gameover
        IF x < 15 THEN CALL gameover
        IF y > 405 THEN CALL gameover
        IF y < 15 THEN CALL gameover
        IF x > 95 AND x < 545 AND y > 95 AND y < 315 THEN CALL gameover
        IF x > 530 AND y > 290 THEN k = 2
        IF k = 2 AND y < 110 AND x > 530 THEN k = 1
        IF y > 300 AND x > 140 AND x < 166 AND dx >= 0 THEN varv = varv + k: k = 0
        IF y > 300 AND x > 140 AND x < 166 AND dx < 0 THEN k = 0

        LINE (148, 310)-(152, 410), 15, BF

        ' Dîd ?
        IF dead% = 1 THEN EXIT DO

        ' MÜlgÜng
        IF varv > 5 THEN
         IF dead% = 0 THEN sluttid = TIMER - starttid
         konvert sluttid
         IF dead% = 0 THEN stid$ = tid$
         dead% = 2
         KEY(11) OFF
         STRIG(0) OFF
         IF speed = 0 THEN EXIT DO
        END IF



        LOOP                                      '  ^


        SELECT CASE dead%
         CASE IS = 0: CLS 2: PRINT "                          * Game aborted *": stoppa 1
         CASE IS = 1: CLS 2: PRINT "                  You crashed and got burned to death.; GAME; OVER; ": stoppa 2
         CASE IS = 2: CALL finish
        END SELECT

        END SUB

        SUB bana2
        filhant
        '--- Spelet ---
        STRIG(0) OFF
        STRIG(4) OFF
         FOR n = 11 TO 14
          KEY(n) OFF
         NEXT n

        CLS
        SCREEN 12
        VIEW SCREEN (1, 1)-(639, 420), , 0
        VIEW PRINT (29) TO (30)
        bilbana2
        x = 165
        y = 375
        dam% = 0
        c = color1%
        cc = 0
        v = 0
        speed = 0
        dead% = 0
        CALL ritabil
        LINE (148, 320)-(152, 410), 15, BF
        CALL Start
        starttid = TIMER
        nolltid = TIMER       ' Start
        IF joy% = 0 THEN
         FOR n = 11 TO 14
          KEY(n) ON
         NEXT n
        ELSE
         STRIG(0) ON
         STRIG(4) ON
        END IF
        CLS 2
        DO UNTIL INKEY$ = CHR$(27)           '     v
        c = color1%
        cc = 0
        u = v
        CALL ritabil

        '--- Fartminskning ---
        speed = speed - .3
        IF speed < 0 THEN speed = 0

        IF joy% = 1 THEN
         DO
          jstick% = STICK(0)
         LOOP UNTIL jstick% < max1% + 10 AND jstick% > min1% - 10
          SELECT CASE jstick%
           CASE IS > (cent1% + max1%) / 2: v = v + .25              ' Hîger / vÑnster
           CASE IS < (cent1% + min1%) / 2: v = v - .25
          END SELECT
        END IF



        '--- Ljud ---
        s = 37 + 10 * speed
        IF ljud% = 1 THEN SOUND s, 2
        IF ljud% = 0 THEN SOUND 30000, 2

        c = 7
        cc = 7
        CALL ritabil
        COLOR 15
        tiden = TIMER - nolltid
        IF tiden < 1 THEN
        tid$ = STR$(minut) + "." + "00" + STR$(TIMER - nolltid)
        ELSEIF tiden < 10 THEN
        tid$ = STR$(minut) + "." + "0" + STR$(TIMER - nolltid)
        ELSEIF tiden >= 60 THEN
        minut = minut + 1
        nolltid = TIMER
        tid$ = STR$(minut) + "." + STR$(TIMER - nolltid)
        ELSE
        tid$ = STR$(minut) + "." + STR$(TIMER - nolltid)
        END IF
        IF dead% = 0 THEN LOCATE 29, 2: PRINT tid$; SPACE$(2)
        IF dead% = 2 THEN LOCATE 29, 2: PRINT stid$; SPACE$(2)
         SELECT CASE varv
          CASE IS < 5: LOCATE 29, 14: PRINT "Lap: "; varv
          CASE IS = 5: COLOR 14: LOCATE 29, 14: PRINT "Final lap "
          CASE IS > 5: COLOR 14: LOCATE 29, 14: PRINT "==FINISH=="
         END SELECT
        COLOR 15
        LOCATE 29, 25: PRINT "Damage:  "; dam%;
        IF dam% > 99 THEN COLOR 4
        LOCATE 29, 37: PRINT "%"
        LOCATE 29, 60: COLOR 9: PRINT "REJS  v1.0"
        ' ---

        dx = speed * COS(v)
        dy = speed * SIN(v)
        x = x + dx
        y = y + dy

        '--- Banans utseende ---
        IF x > 625 THEN CALL gameover
        IF x < 15 THEN CALL gameover
        IF y > 405 THEN CALL gameover
        IF y < 15 THEN CALL gameover
        IF x > 85 AND x < 195 AND y > 85 AND y < 325 THEN CALL gameover
        IF y > 265 AND x > 275 AND x < 405 THEN CALL gameover
        IF x >= 195 AND x < 555 AND y > 90 AND y < 185 THEN CALL gameover
        IF x > 485 AND x < 555 AND y >= 180 AND y < 325 THEN CALL gameover

        IF x > 530 AND y > 290 THEN k = 2
        IF k = 2 AND y < 110 AND x > 530 THEN k = 1
        IF y > 300 AND x > 140 AND x < 166 AND dx >= 0 THEN varv = varv + k: k = 0
        IF y > 300 AND x > 140 AND x < 166 AND dx < 0 THEN k = 0
        LINE (148, 320)-(152, 410), 15, BF

        ' Dîd
        IF dead% = 1 THEN EXIT DO

        ' MÜlgÜng
        IF varv > 5 THEN
         IF dead% = 0 THEN sluttid = TIMER - starttid
         konvert sluttid
         IF dead% = 0 THEN stid$ = tid$
         dead% = 2
         KEY(11) OFF
         STRIG(0) OFF
         IF speed = 0 THEN EXIT DO
        END IF


        LOOP                           '        ^

        SELECT CASE dead%
         CASE IS = 0: CLS 2: PRINT "                                    * Game aborted * ": stoppa 1
         CASE IS = 1: CLS 2: PRINT "                  You crashed and got burned to death. GAME OVER ": stoppa 2
        CASE IS = 2: CALL finish
        END SELECT

        END SUB

        SUB bana3
        filhant
        '--- Spelet ---
        STRIG(0) OFF
        STRIG(4) OFF
         FOR n = 11 TO 14
          KEY(n) OFF
         NEXT n

        CLS
        SCREEN 12
        VIEW SCREEN (1, 1)-(639, 420), , 0
        VIEW PRINT (29) TO (30)
        bilbana3
        x = 165
        y = 370
        dam% = 0
        c = color1%
        cc = 0
        v = 0
        speed = 0
        dead% = 0
        CALL ritabil
        LINE (148, 310)-(152, 410), 15, BF
        CALL Start
        starttid = TIMER
        nolltid = TIMER       ' Start
        IF joy% = 0 THEN
         FOR n = 11 TO 14
          KEY(n) ON
         NEXT n
        ELSE
         STRIG(0) ON
         STRIG(4) ON
        END IF
        CLS 2
        DO UNTIL INKEY$ = CHR$(27)           '     v
        c = color1%
        cc = 0
        u = v
        CALL ritabil

        '--- Fartminskning ---
        speed = speed - .3
        IF speed < 0 THEN speed = 0

        IF joy% = 1 THEN
         DO
          jstick% = STICK(0)
         LOOP UNTIL jstick% < max1% + 10 AND jstick% > min1% - 10
          SELECT CASE jstick%
           CASE IS > (cent1% + max1%) / 2: v = v + .25              ' Hîger / vÑnster
           CASE IS < (cent1% + min1%) / 2: v = v - .25
          END SELECT
        END IF



        '--- Ljud ---
        s = 37 + 10 * speed
        IF ljud% = 1 THEN SOUND s, 2
        IF ljud% = 0 THEN SOUND 30000, 2

        c = 7
        cc = 7
        CALL ritabil
        COLOR 15
        tiden = TIMER - nolltid
        IF tiden < 1 THEN
        tid$ = STR$(minut) + "." + "00" + STR$(TIMER - nolltid)
        ELSEIF tiden < 10 THEN
        tid$ = STR$(minut) + "." + "0" + STR$(TIMER - nolltid)
        ELSEIF tiden >= 60 THEN
        minut = minut + 1
        nolltid = TIMER
        tid$ = STR$(minut) + "." + STR$(TIMER - nolltid)
        ELSE
        tid$ = STR$(minut) + "." + STR$(TIMER - nolltid)
        END IF
        IF dead% = 0 THEN LOCATE 29, 2: PRINT tid$; SPACE$(2)
        IF dead% = 2 THEN LOCATE 29, 2: PRINT stid$; SPACE$(2)
         SELECT CASE varv
          CASE IS < 5: LOCATE 29, 14: PRINT "Lap: "; varv
          CASE IS = 5: COLOR 14: LOCATE 29, 14: PRINT "Final lap "
          CASE IS > 5: COLOR 14: LOCATE 29, 14: PRINT "==FINISH=="
         END SELECT
        COLOR 15
        LOCATE 29, 25: PRINT "Damage:  "; dam%;
        IF dam% > 99 THEN COLOR 4
        LOCATE 29, 37: PRINT "%"
        LOCATE 29, 60: COLOR 9: PRINT "REJS  v1.0"
        ' ---

        dx = speed * COS(v)
        dy = speed * SIN(v)
        x = x + dx
        y = y + dy

        '--- Banans utseende ---
        IF x > 625 THEN CALL gameover
        IF x < 15 THEN CALL gameover
        IF y > 405 THEN CALL gameover
        IF y < 15 THEN CALL gameover
        IF x > 95 AND x < 125 AND y > 95 AND y < 315 THEN CALL gameover
        IF y > 195 AND y < 215 AND x > 195 THEN CALL gameover
        IF x > 120 AND x < 535 AND y > 95 AND y < 125 THEN CALL gameover
        IF x > 120 AND x < 535 AND y > 285 AND y < 315 THEN CALL gameover

        IF x > 530 AND y > 290 THEN k = 2
        IF k = 2 AND y < 110 AND x > 530 THEN k = 1
        IF y > 300 AND x > 140 AND x < 166 AND dx >= 0 THEN varv = varv + k: k = 0
        IF y > 300 AND x > 140 AND x < 166 AND dx < 0 THEN k = 0
        LINE (148, 310)-(152, 410), 15, BF

        ' Dîd
        IF dead% = 1 THEN EXIT DO

        ' MÜlgÜng
        IF varv > 5 THEN
         IF dead% = 0 THEN sluttid = TIMER - starttid
         konvert sluttid
         IF dead% = 0 THEN stid$ = tid$
         dead% = 2
         KEY(11) OFF
         STRIG(0) OFF
         IF speed = 0 THEN EXIT DO
        END IF


        LOOP                           '        ^

        SELECT CASE dead%
         CASE IS = 0: CLS 2: PRINT "                                    * Game aborted *": stoppa 1
         CASE IS = 1: CLS 2: PRINT "                  You crashed and got burned to death. GAME OVER": stoppa 2
         CASE IS = 2: CALL finish
        END SELECT


        END SUB

        SUB bana4
        filhant
        '--- Spelet ---
        STRIG(0) OFF
        STRIG(4) OFF
         FOR n = 11 TO 14
          KEY(n) OFF
         NEXT n

        CLS
        SCREEN 12
        VIEW SCREEN (1, 1)-(639, 420), , 0
        VIEW PRINT (29) TO (30)
        bilbana4
        x = 165
        y = 380
        dam% = 0
        c = color1%
        cc = 0
        v = 0
        speed = 0
        dead% = 0
        CALL ritabil
        LINE (148, 330)-(152, 410), 15, BF
        CALL Start
        starttid = TIMER
        nolltid = TIMER       ' Start
        IF joy% = 0 THEN
         FOR n = 11 TO 14
          KEY(n) ON
         NEXT n
        ELSE
         STRIG(0) ON
         STRIG(4) ON
        END IF
        CLS 2
        DO UNTIL INKEY$ = CHR$(27)           '     v
        c = color1%
        cc = 0
        u = v
        CALL ritabil

        '--- Fartminskning ---
        speed = speed - .3
        IF speed < 0 THEN speed = 0

        IF joy% = 1 THEN
         DO
          jstick% = STICK(0)
         LOOP UNTIL jstick% < max1% + 10 AND jstick% > min1% - 10
          SELECT CASE jstick%
           CASE IS > (cent1% + max1%) / 2: v = v + .25              ' Hîger / vÑnster
           CASE IS < (cent1% + min1%) / 2: v = v - .25
          END SELECT
        END IF



        '--- Ljud ---
        s = 37 + 10 * speed
        IF ljud% = 1 THEN SOUND s, 2
        IF ljud% = 0 THEN SOUND 30000, 2

        c = 7
        cc = 7
        CALL ritabil
        COLOR 15
        tiden = TIMER - nolltid
        IF tiden < 1 THEN
        tid$ = STR$(minut) + "." + "00" + STR$(TIMER - nolltid)
        ELSEIF tiden < 10 THEN
        tid$ = STR$(minut) + "." + "0" + STR$(TIMER - nolltid)
        ELSEIF tiden >= 60 THEN
        minut = minut + 1
        nolltid = TIMER
        tid$ = STR$(minut) + "." + STR$(TIMER - nolltid)
        ELSE
        tid$ = STR$(minut) + "." + STR$(TIMER - nolltid)
        END IF
        IF dead% = 0 THEN LOCATE 29, 2: PRINT tid$; SPACE$(2)
        IF dead% = 2 THEN LOCATE 29, 2: PRINT stid$; SPACE$(2)
         SELECT CASE varv
          CASE IS < 5: LOCATE 29, 14: PRINT "Lap: "; varv
          CASE IS = 5: COLOR 14: LOCATE 29, 14: PRINT "Final lap "
          CASE IS > 5: COLOR 14: LOCATE 29, 14: PRINT "==FINISH=="
         END SELECT
        COLOR 15
        LOCATE 29, 25: PRINT "Damage:  "; dam%;
        IF dam% > 99 THEN COLOR 4
        LOCATE 29, 37: PRINT "%"
        LOCATE 29, 60: COLOR 9: PRINT "REJS  v1.0"
        ' ---

        dx = speed * COS(v)
        dy = speed * SIN(v)
        x = x + dx
        y = y + dy

        '--- Banans utseende ---
        IF x > 625 THEN CALL gameover
        IF x < 15 THEN CALL gameover
        IF y > 405 THEN CALL gameover
        IF y < 15 THEN CALL gameover

        IF x > 75 AND x < 95 AND y > 75 AND y < 335 THEN CALL gameover
        IF x > 85 AND x < 225 AND y > 315 AND y < 335 THEN CALL gameover
        IF x > 205 AND x < 225 AND y > 85 AND y < 325 THEN CALL gameover
         IF x > 205 AND x < 425 AND y > 85 AND y < 115 THEN CALL gameover
        IF x > 405 AND x < 425 AND y > 105 AND y < 335 THEN CALL gameover
        IF x > 405 AND x < 565 AND y > 315 AND y < 335 THEN CALL gameover
        IF x > 545 AND x < 565 AND y > 75 AND y < 325 THEN CALL gameover
        IF x > 305 AND x < 325 AND y > 195 AND y < 425 THEN CALL gameover
        IF x > 145 AND x < 165 AND y > 10 AND y < 245 THEN CALL gameover
        IF x > 475 AND x < 495 AND y > 10 AND y < 245 THEN CALL gameover


        IF x > 530 AND y > 290 THEN k = 2
        IF k = 2 AND y < 110 AND x > 530 THEN k = 1
        IF y > 300 AND x > 140 AND x < 166 AND dx >= 0 THEN varv = varv + k: k = 0
        IF y > 300 AND x > 140 AND x < 166 AND dx < 0 THEN k = 0
        LINE (148, 330)-(152, 410), 15, BF

        ' Dîd
        IF dead% = 1 THEN EXIT DO

        ' MÜlgÜng
        IF varv > 5 THEN
         IF dead% = 0 THEN sluttid = TIMER - starttid
         konvert sluttid
         IF dead% = 0 THEN stid$ = tid$
         dead% = 2
         KEY(11) OFF
         STRIG(0) OFF
         IF speed = 0 THEN EXIT DO
        END IF


        LOOP                           '        ^

        SELECT CASE dead%
         CASE IS = 0: CLS 2: PRINT "                                    * Game aborted *": stoppa 1
         CASE IS = 1: CLS 2: PRINT "                  You crashed and got burned to death. GAME OVER": stoppa 2
         CASE IS = 2: CALL finish
        END SELECT


        END SUB

        SUB bilbana1
        ' Kantlinjer
        LINE (0, 0)-(640, 10), 1, BF
        LINE STEP(0, 0)-(630, 420), 1, BF
        LINE STEP(0, 0)-(0, 410), 1, BF
        LINE STEP(0, 0)-(10, 0), 1, BF
        ' ôvriga linjer
        LINE (100, 100)-(530, 310), 1, BF
        PAINT (320, 60), 7, 1
        END SUB

        SUB bilbana2
        'kantlinjer
        LINE (0, 0)-(640, 10), 6, BF
        LINE STEP(0, 0)-(630, 420), 6, BF
        LINE STEP(0, 0)-(0, 410), 6, BF
        LINE STEP(0, 0)-(10, 0), 6, BF
        'îvriga linjer
        LINE (90, 90)-(190, 320), 6, BF
        LINE (280, 420)-(400, 270), 6, BF
        LINE (190, 90)-(490, 180), 6, BF
        LINE (490, 90)-(550, 320), 6, BF

        PAINT (320, 60), 7, 6
        END SUB

        SUB bilbana3
        ' Kantlinjer
        LINE (0, 0)-(640, 10), 4, BF
        LINE STEP(0, 0)-(630, 420), 4, BF
        LINE STEP(0, 0)-(0, 410), 4, BF
        LINE STEP(0, 0)-(10, 0), 4, BF
        ' ôvriga linjer
        LINE (100, 100)-(120, 310), 4, BF
        LINE (120, 310)-(530, 290), 4, BF
        LINE (100, 100)-(530, 120), 4, BF
        LINE (200, 200)-(630, 210), 4, BF
        PAINT (320, 60), 7, 4
        END SUB

        SUB bilbana4
        'kantlinjer
        LINE (0, 0)-(640, 10), 8, BF
        LINE STEP(0, 0)-(630, 420), 8, BF
        LINE STEP(0, 0)-(0, 410), 8, BF
        LINE STEP(0, 0)-(10, 0), 8, BF
        'îvriga linjer
        LINE (80, 80)-(90, 330), 8, BF
        LINE (90, 330)-(220, 320), 8, BF
        LINE (220, 320)-(210, 90), 8, BF
        LINE (210, 90)-(420, 110), 8, BF
        LINE (420, 110)-(410, 330), 8, BF
        LINE (410, 330)-(560, 320), 8, BF
        LINE (560, 320)-(550, 80), 8, BF

        LINE (310, 420)-(315, 200), 8, BF
        LINE (150, 10)-(160, 240), 8, BF
        LINE (480, 10)-(490, 240), 8, BF

        PAINT (320, 60), 7, 8

        END SUB

        SUB calibrate

        CLS 0
        COLOR 9
        FOR lr = 4 TO 24
        LOCATE lr, 15: PRINT "€"
        NEXT lr
        FOR lk = 15 TO 65
        LOCATE 24, lk: PRINT "€"
        NEXT lk
        FOR lr = 4 TO 24
        LOCATE lr, 65: PRINT "€"
        NEXT lr
        FOR lk = 15 TO 65
        LOCATE 4, lk: PRINT "€"
        NEXT lk

        LOCATE 8, 22: PRINT "Calibrate joystick   -   press ESC to skip"
        COLOR 7
        LOCATE 10, 20: PRINT "Move stick to upper left and press button"
        DO UNTIL STRIG(1) = -1 OR STRIG(5) = -1 OR STRIG(3) = -1 OR STRIG(7) = -1
        IF INKEY$ = CHR$(27) THEN GOTO calslut
        LOCATE 12, 30: PRINT STICK(0); STICK(1)

        LOOP
        min% = STICK(0)

        stoppa .5
        LOCATE 15, 20: PRINT "Move stick to lower right and press button"
        DO UNTIL STRIG(1) = -1 OR STRIG(5) = -1 OR STRIG(3) = -1 OR STRIG(7) = -1
        IF INKEY$ = CHR$(27) THEN GOTO calslut
        LOCATE 17, 30: PRINT STICK(0); STICK(1)


        LOOP
        max% = STICK(0)
        stoppa .5
        LOCATE 20, 20: PRINT "Center joystick and press button"
        DO UNTIL STRIG(1) = -1 OR STRIG(5) = -1 OR STRIG(3) = -1 OR STRIG(7) = -1
        IF INKEY$ = CHR$(27) THEN GOTO calslut
        LOCATE 22, 30: PRINT STICK(0); STICK(1)

        LOOP
        cent% = STICK(0)
        stoppa .5

        PUT #1, 7, max%
        PUT #1, 8, min%
        PUT #1, 9, cent%

        filhant
calslut:
        CLS
        END SUB

        SUB filhant
starrt:

        GET #1, 1, koll%
        IF koll% <> 8 THEN GOTO skapafil
        SEEK #1, 2
        GET #1, , joy%
        GET #1, , ljud%
        GET #1, , bana%
        GET #1, , color1%
        GET #1, , color2%
        GET #1, , max1%
        GET #1, , min1%
        GET #1, , cent1%


        GOTO slutt

skapafil:

        ' StandardvÑrden
        koll% = 8
        PUT #1, 1, koll%
        joy% = 0
        PUT #1, 2, joy%
        ljud% = 1
        PUT #1, 3, ljud%
        bana% = 1
        PUT #1, 4, bana%
        color1% = 4
        PUT #1, 5, color1%
        color2% = 2
        PUT #1, 6, color2%
        max1% = 72
        PUT #1, 7, max1%
        min1% = 2
        PUT #1, 7, min1%
        cent1% = 34
        PUT #1, 7, cent1%



        GOTO starrt
slutt:
        END SUB

        SUB finish
        SCREEN 12
        VIEW PRINT (1) TO (30)
        CLS 0
        COLOR 15
        LOCATE 4, 1: PRINT "€ € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € "
        LOCATE 5, 1: PRINT " € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € €"
        LOCATE 6, 1: PRINT "€ € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € "
        LOCATE 7, 1: PRINT " € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € €"
        LOCATE 8, 1: PRINT "€ € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € "
        LOCATE 2, 22: PRINT " T H E    F I N I S H    L I N E "
        COLOR 14: LOCATE 3, 31: PRINT bannamn(bana%): COLOR 15
        ' Kolla om tiden Ñr hiscore...
        postnr% = bana% * 10

        FOR m = postnr% TO postnr% + 10
         GET #2, m, hidata
         IF sluttid < hidata.score THEN EXIT FOR
        NEXT m
        konvert sluttid
        IF m >= postnr% + 10 THEN LOCATE 13, 15: PRINT "Your time was "; tid$
        IF m < postnr% + 9 THEN
         FOR f = postnr% + 8 TO m STEP -1
          GET #2, f, hidata
          PUT #2, (f + 1), hidata
         NEXT f
        END IF
        IF m < postnr% + 10 THEN
         LOCATE 13, 15: PRINT "Your time was "; tid$; "   That's a new hi-score!!!"
         LOCATE 15, 15: INPUT "Enter your name please:  ", hidata.namn
         hidata.score = sluttid
         PUT #2, m, hidata
        END IF

        'Visa listan
        FOR lr = 17 TO 29
        LOCATE lr, 25: PRINT "€"
        NEXT lr
        FOR lk = 25 TO 55
        LOCATE 17, lk: PRINT "€"
        NEXT lk
        FOR lr = 17 TO 29
        LOCATE lr, 55: PRINT "€"
        NEXT lr
        FOR lk = 25 TO 55
        LOCATE 29, lk: PRINT "€"
        NEXT lk
        plac% = 1
        LOCATE 18, 33: PRINT "H I - S C O R E S"
        FOR g = 19 TO 28
         GET #2, postnr%, hidata
         konvert hidata.score
         LOCATE g, 27: PRINT plac%; hidata.namn: LOCATE g, 46: PRINT tid$
         postnr% = postnr% + 1
         plac% = plac% + 1
        NEXT g


        DO UNTIL INKEY$ <> ""
        LOOP

        END SUB

        SUB gameover
        IF ljud% = 1 THEN SOUND 150, 1' BONK!
        IF dead% = 0 THEN dam% = INT(dam% + .02 * speed ^ 2)
        IF dam% > 100 THEN dam% = 100
        IF dam% = 100 THEN
        c = color1%
        cc = 0
        ritabil
        COLOR 14
        FOR p% = 1 TO 12
        snd% = p% * 100
        REM CIRCLE (x, y), .8 * p%, 4
        IF ljud% = 1 THEN SOUND snd%, .7
        IF ljud% = 0 THEN SOUND 20000, .7
        LINE (x, y)-(x + 1.5 * p%, y)
        LINE (x, y)-(x - 1.5 * p%, y)
        LINE (x, y)-(x + p%, y + p%)
        LINE (x, y)-(x - p%, y + p%)
        LINE (x, y)-(x, y + 1.5 * p%)
        LINE (x, y)-(x, y - 1.5 * p%)
        LINE (x, y)-(x - p%, y - p%)
        LINE (x, y)-(x + p%, y - p%)
        CIRCLE (x, y), .8 * p%, 4
        NEXT p%
        COLOR 4
        PRINT "                             B  O  O  M  !  !  !  !    "
        IF ljud% = 1 THEN PLAY "mf o1 l16 d p16 dddd"
        dead% = 1
        stoppa 1
        ELSE
        x = x - 2 * dx
        y = y - 2 * dy
        speed = speed - 5
        IF speed < 0 THEN speed = 0
        END IF
        END SUB

        SUB help
        CLS 0
        COLOR 9
        FOR lr = 4 TO 24
        LOCATE lr, 15: PRINT "€"
        NEXT lr
        FOR lk = 15 TO 65
        LOCATE 24, lk: PRINT "€"
        NEXT lk
        FOR lr = 4 TO 24
        LOCATE lr, 65: PRINT "€"
        NEXT lr
        FOR lk = 15 TO 65
        LOCATE 4, lk: PRINT "€"
        NEXT lk

        LOCATE 7, 32: PRINT "HOW TO PLAY"
        COLOR 7
        LOCATE 9, 22: PRINT "The object of this game is easy"
        LOCATE 10, 18: PRINT "Just try to race 5 laps as fast as you can"
        LOCATE 11, 20: PRINT "and try not to crash against the walls"
        LOCATE 12, 23: PRINT "Use numeric keypad to play"
        LOCATE 13, 23: PRINT "(Make sure NUM LOCK is on)"
        COLOR 9: LOCATE 14, 50: PRINT "JOYSTICK:"
        COLOR 9: LOCATE 15, 17: PRINT "KEYS:"
        COLOR 7: LOCATE 15, 30: PRINT "8  - accelerate"
        LOCATE 15, 50: PRINT "(button A)"
        LOCATE 16, 30: PRINT "2  - brake"
        LOCATE 16, 50: PRINT "(button B)"
        LOCATE 17, 30: PRINT "4  - turn left"
        LOCATE 17, 50: PRINT "(left)"
        LOCATE 18, 30: PRINT "6  - turn right"
        LOCATE 18, 50: PRINT "(right)"
        LOCATE 19, 30: PRINT ""
        LOCATE 20, 35: PRINT "F8   - Toggle sound"
        LOCATE 21, 35: PRINT "ESC  - Abort race"
        LOCATE 22, 35: PRINT "F10  - Quick exit"

        DO WHILE INKEY$ = ""
        LOOP
        IF ljud% = 1 THEN SOUND 200, 1.5

        END SUB

        SUB hiscore
        CLS 0
        COLOR 9
        FOR lr = 2 TO 29
        LOCATE lr, 10: PRINT "€"
        NEXT lr
        FOR lk = 10 TO 70
        LOCATE 29, lk: PRINT "€"
        NEXT lk
        FOR lr = 2 TO 29
        LOCATE lr, 70: PRINT "€"
        NEXT lr
        FOR lk = 10 TO 70
        LOCATE 2, lk: PRINT "€"
        NEXT lk

        LOCATE 4, 13: PRINT " *  *  *  T H E    H A L L    O F    F A M E  *  *  * "
        bana% = 1
        postnr% = bana% * 10
        plac% = 1
        LOCATE 6, 20: PRINT bannamn(bana%)
        COLOR 7
        FOR g = 7 TO 16
         GET #2, postnr%, hidata
         konvert hidata.score
         LOCATE g, 14: PRINT plac%; hidata.namn: LOCATE g, 33: PRINT tid$
         postnr% = postnr% + 1
         plac% = plac% + 1
        NEXT g

        bana% = 2
        postnr% = bana% * 10
        plac% = 1
        COLOR 9: LOCATE 6, 45: PRINT bannamn(bana%)
        COLOR 7
        FOR g = 7 TO 16
         GET #2, postnr%, hidata
         konvert hidata.score
         LOCATE g, 41: PRINT plac%; hidata.namn: LOCATE g, 60: PRINT tid$
         postnr% = postnr% + 1
         plac% = plac% + 1
        NEXT g

        bana% = 3
        postnr% = bana% * 10
        plac% = 1
        COLOR 9: LOCATE 18, 20: PRINT bannamn(bana%)
        COLOR 7
        FOR g = 19 TO 28
         GET #2, postnr%, hidata
         konvert hidata.score
         LOCATE g, 14: PRINT plac%; hidata.namn:  LOCATE g, 33: PRINT tid$
         postnr% = postnr% + 1
         plac% = plac% + 1
        NEXT g

        bana% = 4
        postnr% = bana% * 10
        plac% = 1
        COLOR 9: LOCATE 18, 45: PRINT bannamn(bana%)
        COLOR 7
        FOR g = 19 TO 28
         GET #2, postnr%, hidata
         konvert hidata.score
         LOCATE g, 41: PRINT plac%; hidata.namn: LOCATE g, 60: PRINT tid$
         postnr% = postnr% + 1
         plac% = plac% + 1
        NEXT g


        DO WHILE INKEY$ = ""
        LOOP
        CLS 0
        END SUB

        SUB intro
        DIM bil1(160)
        DIM bil2(160)
        SCREEN 7, 0, 1, 0
        COLOR 15, 0
        FOR s = 1 TO 15
        COLOR s
        LOCATE 12, 3: PRINT " Robert Gavelin proudly presents..."
        PCOPY 1, 0
        IF INKEY$ <> "" THEN EXIT SUB
        stoppa .08
        NEXT s
        FOR by = 1 TO 8
         FOR bx = 1 TO 20
          READ z
          PSET (bx, by), z
         NEXT bx
        NEXT by
        GET (0, 0)-(20, 8), bil1
        RESTORE
        FOR by = 1 TO 8
         FOR bx = 20 TO 1 STEP -1
          READ z
          PSET (bx, by), z
         NEXT bx
        NEXT by
        GET (0, 0)-(20, 8), bil2
        CLS

        ' kapprejs Üt hîger
        FOR x = 0 TO 350 STEP 5
         IF INKEY$ <> "" THEN EXIT SUB
         IF ljud% = 1 THEN SOUND 40 + .1 * x, .4
         IF ljud% = 0 THEN SOUND 20000, .4
         IF x < 295 THEN PUT (x, 100), bil1, PSET    ' bilen som Ñr fîre
         IF x > 45 AND x < 285 THEN PUT (1.2 * x - 45, 120), bil1, PSET  ' efter
         PCOPY 1, 0
         CLS
        NEXT x

        SOUND 20000, 4
        ' siren
        FOR a = 1 TO 14 STEP .02
        IF INKEY$ <> "" THEN EXIT SUB
        s = 2000 * SIN(a)
        IF ljud% = 1 THEN SOUND (2600 + s), .03
        IF ljud% = 0 THEN SOUND 20000, .03
        NEXT a


        ' kapprejs Üt vÑnster
        FOR x = 350 TO 0 STEP -5
         IF INKEY$ <> "" THEN EXIT SUB
         IF ljud% = 1 THEN SOUND 40 + .2 * x, .4
         IF ljud% = 0 THEN SOUND 20000, .4
         IF x < 295 THEN PUT (x, 100), bil2, PSET    ' bilen som Ñr fîre
         IF x > 45 AND x < 285 THEN PUT (1.1 * x - 45, 120), bil2, PSET  ' efter
         PCOPY 1, 0
         CLS
        NEXT x
        SOUND 20000, 10
        CLS
        PCOPY 1, 0
        ' rÑserkîrning
        FOR x = 1 TO 300 STEP 5
         IF INKEY$ <> "" THEN EXIT SUB
         IF ljud% = 1 AND x <= 200 THEN SOUND 80 + .2 * x, .25
         IF ljud% = 1 AND x > 200 THEN SOUND 120 - .5 * (x - 200), .25
         IF ljud% = 0 THEN SOUND 20000, .25
         PUT (x, 150), bil1, PSET
         PCOPY 1, 0
         CLS
        NEXT x
        SOUND 20000, 10
        CLS
        PCOPY 1, 0
        ' krock
        FOR x = 1 TO 140 STEP 5
         IF INKEY$ <> "" THEN EXIT SUB
         IF ljud% = 1 THEN SOUND 60 + .4 * x, .3
         IF ljud% = 0 THEN SOUND 20000, .3
         PUT (x, 96), bil1
         PUT (300 - x, 96), bil2
         PCOPY 1, 0
         CLS
        NEXT x
        FOR r = 1 TO 180 STEP 3
         IF INKEY$ <> "" THEN EXIT SUB
         IF ljud% = 1 THEN SOUND 100 + r, .2
         IF ljud% = 0 THEN SOUND 20000, .2
         CIRCLE (150, 96), r, 14
         PCOPY 1, 0
        NEXT r
        PLAY "mf o1"
        IF INKEY$ <> "" THEN EXIT SUB
        IF ljud% = 1 THEN PLAY "L16 ed L4 e P64 L4 <a P4 > L16 fe L32 f P8 e P8 L4 d P4"
        IF ljud% = 0 THEN stoppa .5
        ' rita logga
        COLOR 1, 15
        LOCATE 7, 1
        PRINT "                                       "
        PRINT "   €€€€€   €€€€€ €€€€€€€€€  €€€€€€€ TM "
        PRINT "   €    €  €             € €           "
        PRINT "   €     € €             € €           "
        PRINT "   €     € €             €  €          "
        PRINT "   €    €  €             €   €€        "
        PRINT "   €€€€€   €€€           €     €€€     "
        PRINT "   € €     €     €      €         €€   "
        PRINT "   €  €    €      €    €           €€  "
        PRINT "   €   €   €       €€€€           €€   "
        PRINT "   €    €  €€€€€€€      €€€€€€€€€€€    "
        PRINT "                                       "
        PRINT "     A Qbasic game by Robert Gavelin   "
        PRINT "                                       "
        LINE (0, 0)-(320, 200), 9, B
        LINE (10, 50)-(310, 160), 9, B
        PAINT (150, 15), 9, 9

        PCOPY 1, 0
        IF ljud% = 1 THEN
         IF INKEY$ <> "" THEN EXIT SUB
         IF ljud% = 1 THEN PLAY "L16 fe L4 f P64 L4 <a P64 b P4 L16 >d P64 c L32 d P8 c P8 <b P8 >d P8 L4 c P4"
         IF INKEY$ <> "" THEN EXIT SUB
         IF ljud% = 1 THEN PLAY "L16 ed L4 e P64 L4 <a P4 > L16 fe L32 f P8 e P8 L4 d P4 "
         IF INKEY$ <> "" THEN EXIT SUB
         IF ljud% = 1 THEN PLAY "L16 fe L4 f P64 L4 <a P64 b P4 L16 >d P64 c L32 d P8 c P8 <b P8 >d P8 L4 c P4"
        ELSE
         IF INKEY$ <> "" THEN EXIT SUB
         stoppa 2
        END IF


        END SUB

        SUB konvert (tiid)
        ' Konvertera sluttid till minuter, sekunder etc...
        tidmin% = INT(tiid / 60)
        tidsek% = INT(tiid - 60 * tidmin%)
        tid10% = INT((tiid - INT(tiid)) * 10)
        IF tidsek% < 10 THEN
         temp$ = "0"
        ELSE
         temp$ = ""
        END IF
        tid$ = RTRIM$(STR$(tidmin%)) + "." + RTRIM$(temp$) + LTRIM$(STR$(tidsek%)) + "." + LTRIM$(STR$(tid10%))
        'klart

        END SUB

        SUB nylista
        hidata.namn = "korrekt"
        hidata.score = 4
        PUT #2, 1, hidata
        SEEK #2, 10
        'bana 1
        hidata.namn = "Robert Gavelin": hidata.score = 40.001
        PUT #2, , hidata
        hidata.namn = "J. Villeneuve": hidata.score = 45.001
        PUT #2, , hidata
        hidata.namn = "Alain Prost": hidata.score = 50.001
        PUT #2, , hidata
        hidata.namn = "M. Schumacher": hidata.score = 55.001
        PUT #2, , hidata
        hidata.namn = "Rikard Rydell": hidata.score = 60.001
        PUT #2, , hidata
        hidata.namn = "Martin Gavelin": hidata.score = 65.001
        PUT #2, , hidata
        hidata.namn = "Simon Gavelin": hidata.score = 75.001
        PUT #2, , hidata
        hidata.namn = "Grandpa": hidata.score = 100.001
        PUT #2, , hidata
        hidata.namn = "Grandma": hidata.score = 130.001
        PUT #2, , hidata
        hidata.namn = "S. Snail": hidata.score = 180.001
        PUT #2, , hidata
        'bana 2
        hidata.namn = "Robert Gavelin": hidata.score = 50.001
        PUT #2, , hidata
        hidata.namn = "Homer Simpson": hidata.score = 55.001
        PUT #2, , hidata
        hidata.namn = "Bart Simpson": hidata.score = 60.001
        PUT #2, , hidata
        hidata.namn = "Marge Simpson": hidata.score = 65.001
        PUT #2, , hidata
        hidata.namn = "Lisa Simpson": hidata.score = 75.001
        PUT #2, , hidata
        hidata.namn = "Maggie Simpson": hidata.score = 90.001
        PUT #2, , hidata
        hidata.namn = "Ned Flanders": hidata.score = 110.001
        PUT #2, , hidata
        hidata.namn = "Barney": hidata.score = 140.001
        PUT #2, , hidata
        hidata.namn = "Smithers": hidata.score = 170.001
        PUT #2, , hidata
        hidata.namn = "mr. Burns": hidata.score = 200.001
        PUT #2, , hidata
        'bana 3
        hidata.namn = "Robert Gavelin": hidata.score = 65.001
        PUT #2, , hidata
        hidata.namn = "Al Bundy": hidata.score = 70.001
        PUT #2, , hidata
        hidata.namn = "Bud Bundy": hidata.score = 75.001
        PUT #2, , hidata
        hidata.namn = "Peggy Bundy": hidata.score = 80.001
        PUT #2, , hidata
        hidata.namn = "Kelly Bundy": hidata.score = 85.001
        PUT #2, , hidata
        hidata.namn = "Buck the dog": hidata.score = 90.001
        PUT #2, , hidata
        hidata.namn = "Lucky the dog": hidata.score = 110.001
        PUT #2, , hidata
        hidata.namn = "Jefferson": hidata.score = 140.001
        PUT #2, , hidata
        hidata.namn = "Steve": hidata.score = 170.001
        PUT #2, , hidata
        hidata.namn = "Marcy D'Arcy": hidata.score = 200.001
        PUT #2, , hidata
        'bana 4
        hidata.namn = "Robert Gavelin": hidata.score = 110.001
        PUT #2, , hidata
        hidata.namn = "Accelerator": hidata.score = 115.001
        PUT #2, , hidata
        hidata.namn = "Hypermaniac": hidata.score = 120.001
        PUT #2, , hidata
        hidata.namn = "Screamager": hidata.score = 125.001
        PUT #2, , hidata
        hidata.namn = "Teethgrinder": hidata.score = 135.001
        PUT #2, , hidata
        hidata.namn = "Brainsaw": hidata.score = 165.001
        PUT #2, , hidata
        hidata.namn = "Neck Freak": hidata.score = 200.001
        PUT #2, , hidata
        hidata.namn = "Hjalle": hidata.score = 230.001
        PUT #2, , hidata
        hidata.namn = "Heavy": hidata.score = 260.001
        PUT #2, , hidata
        hidata.namn = "looser": hidata.score = 300.001
        PUT #2, , hidata




        END SUB

        SUB options

        CLS 0
        SCREEN 12
        VIEW PRINT (1) TO (30)
        oval = 1
optst:

        COLOR 9
        FOR lr = 4 TO 24
        LOCATE lr, 15: PRINT "€"
        NEXT lr
        FOR lk = 15 TO 65
        LOCATE 24, lk: PRINT "€"
        NEXT lk
        FOR lr = 4 TO 24
        LOCATE lr, 65: PRINT "€"
        NEXT lr
        FOR lk = 15 TO 65
        LOCATE 4, lk: PRINT "€"
        NEXT lk

        LOCATE 8, 29: PRINT " * * * O P T I O N S * * * "
optionss:
        IF oval < 1 THEN oval = 1
        IF oval > 6 THEN oval = 6

        IF oval = 1 THEN
        COLOR 9
        LOCATE 12, 32: PRINT "o"
        ELSE
        COLOR 7
        LOCATE 12, 32: PRINT " "
        END IF
        LOCATE 12, 35: PRINT "Game control:  ";
        IF joy% = 0 THEN PRINT "Keypad  "
        IF joy% = 1 THEN PRINT "Joystick"

        IF oval = 2 THEN
        COLOR 9
        LOCATE 14, 32: PRINT "o"
        ELSE
        COLOR 7
        LOCATE 14, 32: PRINT " "
        END IF
        LOCATE 14, 35: PRINT "Track:  "; bannamn(bana%); SPACE$(5)

        IF oval = 3 THEN
        COLOR 9
        LOCATE 16, 32: PRINT "o"
        ELSE
        COLOR 7
        LOCATE 16, 32: PRINT " "
        END IF
        LOCATE 16, 35: PRINT "Sound:  ";
         IF ljud% = 1 THEN
         PRINT "ON "
         ELSEIF ljud% = 0 THEN
         PRINT "OFF"
         END IF

        IF oval = 4 THEN
        COLOR 9
        LOCATE 18, 32: PRINT "o"
        ELSE
        COLOR 7
        LOCATE 18, 32: PRINT " "
        END IF
        LOCATE 18, 35: PRINT "Set car colour"

        IF oval = 5 THEN
        COLOR 9
        LOCATE 20, 32: PRINT "o"
        ELSE
        COLOR 7
        LOCATE 20, 32: PRINT " "
        END IF
        LOCATE 20, 35: PRINT "Calibrate joystick"

        IF oval = 6 THEN
        COLOR 9
        LOCATE 22, 32: PRINT "o"
        ELSE
        COLOR 7
        LOCATE 22, 32: PRINT " "
        END IF
        LOCATE 22, 35: PRINT "Previous menu"


        DO
        m$ = INKEY$
        LOOP UNTIL m$ <> ""
        SELECT CASE m$
        CASE CHR$(0) + "H"
         IF oval > 1 THEN oval = oval - 1
         IF ljud% = 1 THEN SOUND 200, 1.5
        CASE CHR$(0) + "P"
         IF oval < 6 THEN oval = oval + 1
         IF ljud% = 1 THEN SOUND 200, 1.5
        CASE CHR$(13): GOTO hoppaopt
        END SELECT
        GOTO optionss

hoppaopt:
        IF oval = 1 THEN
         SELECT CASE joy%
          CASE IS = 1: joy% = 0
          CASE IS = 0: joy% = 1
         END SELECT

        stoppa .1

        ELSEIF oval = 2 THEN
         bana% = bana% + 1
         IF bana% > 4 THEN bana% = 1
        stoppa .1


        ELSEIF oval = 3 THEN
         ljud% = ljud% + 1
         IF ljud% > 1 THEN ljud% = 0
        stoppa .1

        ELSEIF oval = 4 THEN
        CALL setcolor
        ELSEIF oval = 5 THEN
        CALL calibrate

        ELSEIF oval = 6 THEN GOTO slutopt
        END IF

        PUT #1, 2, joy%
        PUT #1, , ljud%
        PUT #1, , bana%
        PUT #1, , color1%
        PUT #1, , color2%
        filhant

        GOTO optst
slutopt:


        PUT #1, 2, joy%
        PUT #1, , ljud%
        PUT #1, , bana%
        PUT #1, , color1%
        PUT #1, , color2%
        CALL filhant

        END SUB

        SUB ritabil
        CONST pi = 3.141592654#
        COLOR c

        rx = COS(u)         ' Parallell
        ry = SIN(u)
        kx = COS(u + .5 * pi)     ' VinkelrÑt
        KY = SIN(u + .5 * pi)
        pettx = x + 8 * rx
        petty = y + 8 * ry
        ptvax = x - 8 * rx
        ptvay = y - 8 * ry
        REM LINE (pettx, petty)-(ptvax, ptvay)
        ptrex = ptvax + 4 * kx
        ptrey = ptvay + 4 * KY
        pfyrx = pettx + 2 * kx
        pfyry = petty + 2 * KY
        pfemx = ptvax - 4 * kx
        pfemy = ptvay - 4 * KY
        psexx = pettx - 2 * kx
        psexy = petty - 2 * KY

        LINE (ptrex, ptrey)-(pfyrx, pfyry)
        LINE (ptrex, ptrey)-(pfemx, pfemy)
        LINE (psexx, psexy)-(pfyrx, pfyry)
        LINE (psexx, psexy)-(pfemx, pfemy)

        LINE (x + 3 * rx + 1 * kx, y + 3 * ry + 1 * KY)-(x + 3 * rx - 1 * kx, y + 3 * ry - 1 * KY)
        LINE (x + 3 * rx + 1 * kx, y + 3 * ry + 1 * KY)-(x - 4 * rx + 2 * kx, y - 4 * ry + 2 * KY)
        LINE (x - 4 * rx + 2 * kx, y - 4 * ry + 2 * KY)-(x - 4 * rx - 2 * kx, y - 4 * ry - 2 * KY)
        LINE (x - 4 * rx - 2 * kx, y - 4 * ry - 2 * KY)-(x + 3 * rx - 1 * kx, y + 3 * ry - 1 * KY)

        ' --- dÑck ---
        LINE (x - 4 * rx + 4 * kx, y - 4 * ry + 4 * KY)-STEP(-3 * rx, -3 * ry), cc
        LINE (x - 4 * rx - 4 * kx, y - 4 * ry - 4 * KY)-STEP(-3 * rx, -3 * ry), cc
        LINE (x - 4 * rx + 5 * kx, y - 4 * ry + 5 * KY)-STEP(-3 * rx, -3 * ry), cc
        LINE (x - 4 * rx - 5 * kx, y - 4 * ry - 5 * KY)-STEP(-3 * rx, -3 * ry), cc
        LINE (x + 7 * rx + 3 * kx, y + 7 * ry + 3 * KY)-STEP(-2 * rx, -2 * ry), cc
        LINE (x + 7 * rx - 3 * kx, y + 7 * ry - 3 * KY)-STEP(-2 * rx, -2 * ry), cc
        LINE (x + 7 * rx + 4 * kx, y + 7 * ry + 4 * KY)-STEP(-2 * rx, -2 * ry), cc
        LINE (x + 7 * rx - 4 * kx, y + 7 * ry - 4 * KY)-STEP(-2 * rx, -2 * ry), cc


        END SUB

        SUB setcolor
cstart:
        CLS
        COLOR 9
        FOR lr = 4 TO 24
        LOCATE lr, 15: PRINT "€"
        NEXT lr
        FOR lk = 15 TO 65
        LOCATE 24, lk: PRINT "€"
        NEXT lk
        FOR lr = 4 TO 24
        LOCATE lr, 65: PRINT "€"
        NEXT lr
        FOR lk = 15 TO 65
        LOCATE 4, lk: PRINT "€"
        NEXT lk
         
         COLOR 9
         LOCATE 8, 25: PRINT "Press ENTER to change colour"
         LOCATE 9, 29: PRINT "Press ESC when ready"
         x = 320
         y = 240
         CIRCLE (320, 240), 25, 7
         PAINT (320, 240), 7, 7

        DO UNTIL INKEY$ = CHR$(27)
         u = u + .25
         c = color1%
         cc = 0
         ritabil
         stoppa .2
         c = 7
         cc = 7
         ritabil
         tryck$ = INKEY$
         IF tryck$ = CHR$(27) THEN
          EXIT DO
         ELSEIF tryck$ = CHR$(13) THEN
          IF ljud% = 1 THEN SOUND 200, 1.5
          color1% = color1% + 1
          IF color1% > 15 THEN color1% = 1
          IF color1% = 7 THEN color1% = 9
         ELSE
         END IF
        LOOP
        SOUND 200, 1.5
         PUT #1, 5, color1%
        CLS
        END SUB

        SUB Start
        COLOR 15
        LOCATE , 25: PRINT "Get ready to REJS !! "
        IF ljud% = 1 THEN SOUND 37, 30
        stoppa (1.5)
        PLAY "o3"
        PLAY "l4"
        PLAY "mf"
        COLOR 4
        FOR kl = 1 TO 80
        LOCATE 29, kl: PRINT "€"
        NEXT kl
        IF ljud% = 1 THEN PLAY "c"
        stoppa 1
        COLOR 14
        FOR kl = 1 TO 80
        LOCATE 29, kl: PRINT "€"
        NEXT kl
        IF ljud% = 1 THEN PLAY "c"
        stoppa 1
        COLOR 10
        FOR kl = 1 TO 80
        LOCATE 29, kl: PRINT "€"
        NEXT kl
        IF ljud% = 1 THEN PLAY "o4l2c"
        stoppa 1

        END SUB

        SUB stoppa (n!)
        tidnoll = TIMER
        DO WHILE difftid < n
        difftid = TIMER - tidnoll
        LOOP
        END SUB

