DECLARE SUB PAUSE (Seconds AS SINGLE)
DECLARE SUB MIDTEXT (text$, row%, tColor%)
DECLARE SUB GETDELAY ()
'Stunt Surfer 3.3
'COPYRIGHT (C) 1996 \|/ Majesty Software Corporation
'ALL RIGHTS RESERVED.
'This game is freeware and may be distributed freely
'This game may not be sold for any price other than s&h or reasonable
'copying fees.

DECLARE SUB QUIT ()
DECLARE SUB STARTUP ()
DECLARE SUB BOX (col%, row%, ecol%, erow%)
DECLARE SUB GETKEY ()
DECLARE SUB MAJ ()
DECLARE SUB HANDLER ()
DECLARE SUB STATS (ender%)
DECLARE SUB SPLASH (col%, row%, amount%)
RANDOMIZE TIMER: DEFINT A-Z
DIM SHARED d, player$, col, up, down, jumpa, life, score, timeLeft!, blah, crown(5000), PrevGo, highScor
aa$ = "C2R80H1L78G1BE2BR20C14R20U1L15R5U1R10U50L10D50BE2P14,14BD4BR20R20L5U1L15U1R10U50L10D50BE2P14,14BU49C12R10U10H10L15G10D10R15U10R5D10R5BU3P4,12"
ab$ = "BU18C14L15H40F5U5D5E5G5F1R2F4R5F6R8F10R15E10R10E10R5D1L5D2R5D1L5G30BU5P14,14BU10C1L15U1R15U1L30G10R1E10R15C14BU1U15R15D15L15BE5P14,14BU5C11R3D1L3R3BR5R3U1L3BD7C4L10H4"
player$ = aa$ + ab$
startover:
comboMinus = 0: combo = 0: blah = 1: cheat = 0: col = 80: up = 0: down = 0: jumpa = 0
timeLeft! = 99: life = 320: score = 0
'OPEN "I", #1, "SURFER.HI": INPUT #1, highScor: CLOSE #1
IF allre = 0 THEN MAJ
SCREEN 9, 0, 0, 1
IF allre = 0 THEN STARTUP
IF allre = 0 THEN GOTO reAgain
SELECT CASE curPlay
CASE 1: player$ = player1$
CASE 2: player$ = player2$
CASE 3: player$ = player3$
CASE 4: player$ = player4$
END SELECT
COLOR 15, 11
redo:
   CLS
   timeLeft! = timeLeft! - .25
   A$ = INKEY$
   A$ = UCASE$(A$)
   IF A$ = "" THEN GOTO passinkeys
   IF A$ = CHR$(0) + "K" THEN col = col - 35: IF col < 10 THEN col = 10
   IF A$ = CHR$(0) + "M" THEN col = col + 35: IF col > 530 THEN col = 530
   IF A$ = CHR$(0) + "H" AND down = 0 AND up = 0 THEN up = 1: score = score + 5: midair = 1
   IF A$ = CHR$(0) + "P" AND down = 0 AND up = 0 THEN up = 2: score = score + 10: CLS : STATS 0: PSET (col, 230), 1: DRAW player$: HANDLER: midair = 1
   IF A$ = "0" AND up = 2 AND col = 115 AND jumpa = 80 THEN GOTO inverted
   IF A$ = "3" AND col = 45 AND down = 1 AND jumpa = 10 THEN GOTO skim
   IF A$ = "7" AND up > 0 AND col > 435 THEN GOTO bunz
   IF A$ = "5" AND col = 255 AND down = 1 AND jumpa < 40 THEN GOTO bomb
   IF A$ = "+" AND up > 0 AND col > 90 AND col < 400 AND jumpa > 20 AND jumpa < 50 THEN GOTO flashr
   IF A$ = "-" AND col = 10 AND up = 0 AND down = 0 THEN GOTO blur
   IF A$ = "*" AND up = 1 AND jumpa < 30 AND col < 150 THEN GOTO wav
   IF A$ = "-" AND col > 10 AND col < 530 AND up = 2 THEN GOTO chopp
   IF A$ = "7" AND down = 1 AND jumpa = 70 AND col <= 290 AND col >= 220 THEN GOTO mspike
   IF A$ = "1" AND down = 1 THEN GOTO saw
   IF A$ = "+" AND up = 2 AND col = 325 AND jumpa = 80 THEN GOTO sharky
   IF A$ = "/" AND up = 2 AND jumpa > 30 AND jumpa < 70 AND col > 185 THEN GOTO circleR
   IF A$ = "-" AND up = 0 AND col = 220 THEN GOTO cruise
   IF A$ = CHR$(13) AND down = 1 AND jumpa = 70 THEN GOTO tele
   IF A$ = "9" AND down = 0 AND up = 0 AND col = 185 THEN GOTO flame
   IF A$ = CHR$(27) THEN GOTO downer
   IF A$ = "4" THEN fliptype = 2: GOSUB flip
   IF A$ = "6" THEN fliptype = 1: GOSUB flip

passinkeys:
   
   IF jumpa > 190 THEN jumpa = 190
   STATS 0
   IF jumpa = 0 AND comboMinus > 0 THEN comboMinus = 0
   IF life < 1 THEN GOTO downer
   IF up = 1 THEN jumpa = jumpa + 10
   IF up = 2 THEN jumpa = jumpa + 20: IF jumpa = 100 THEN up = 0: down = 1
   IF down = 1 THEN jumpa = jumpa - 10: IF jumpa = 0 THEN down = 0: SPLASH col, 200, 3: IF combo > 1 THEN GOSUB ComboBonus
   IF jumpa = 50 THEN down = 1: up = 0
   PSET (col, 201 - jumpa), 1: DRAW player$
   HANDLER
   IF timeLeft! = 0 THEN GOTO timesup
   IF DelayPlay = 1 THEN PAUSE .05
GOTO redo

ComboBonus:
   SELECT CASE combo
   CASE 2: award = 80: combo$ = "Radical Combo": noise$ = "l12o2ccdl8e"
   CASE 3: award = 130: combo$ = "Mega Combo": noise$ = "l12o2ecefcfl6g"
   CASE 4: award = 250: combo$ = "Super Combo": noise$ = "l64o2cc+dd+eff+gg+gf+fed+dc+l12c"
   CASE 5: award = 500: combo$ = "Massive Combo": noise$ = "l64o1cc+dd+eff+gg+aa+bo2cc+dd+eff+gg+gf+fed+dc+l12c"
   CASE 6: award = 880: combo$ = "Tubular Combo": noise$ = "l64o0cc+dd+eff+gg+aa+bo1cc+dd+eff+gg+aa+bo2cc+dd+eff+gg+gf+fed+dc+l12c"
   CASE 7: award = 1500: combo$ = "Rockin' Combo": noise$ = "l64o0cc+dd+eff+gg+aa+bo1cc+dd+eff+gg+aa+bo2cc+dd+eff+gg+aa+bo3cc+dd+eff+gg+gf+fed+dc+l10c"
   CASE 8 TO 9: award = 2000: combo$ = "Wild Combo": noise$ = "l64o0cc+dd+eff+gg+aa+bo1cc+dd+eff+gg+aa+bo2cc+dd+eff+gg+aa+bo3cc+dd+eff+gg+gf+fed+dc+l10c"
   CASE 10 TO 12: award = 2650: combo$ = "Ultimate Combo": noise$ = "l64o0cc+dd+eff+gg+aa+bo1cc+dd+eff+gg+aa+bo2cc+dd+eff+gg+aa+bo3cc+dd+eff+gg+gf+fed+dc+l10c"
   CASE IS > 12: award = 3333: combo$ = "MONSTER COMBO!!!": noise$ = "l64o0cc+dd+eff+gg+aa+bo1cc+dd+eff+gg+aa+bo2cc+dd+eff+gg+aa+bo3cc+dd+eff+gg+gf+fed+dc+l10c"
   CASE ELSE: award = 0: combo$ = "Unknown Combo": noise$ = "l64"
   END SELECT
   score = score + award
   CLS : STATS 0: IF bombed = 0 THEN PSET (col, 201 - jumpa), 0: DRAW player$
   LOCATE 2, 7: COLOR 12: PRINT combo$: HANDLER: PLAY "MF" + noise$
   combo = 0
   RETURN


flip:
   IF up = 3 THEN fliptype = 2: GOTO flip2
   IF up = 0 AND down = 0 THEN GOTO flat
   Survive = INT(RND * 100) + 1 + comboMinus
   IF fliptype = 1 AND Survive > 70 THEN GOTO flat
   IF fliptype = 2 AND Survive > 60 THEN GOTO flat
   R = 0
flip2:
   IF fliptype = 1 THEN f1 = -36: f2 = -360: f3 = -36: score = score + 75: life = life - 5
   IF fliptype = 2 THEN f1 = 36: f2 = 360: f3 = 36: score = score + 110: life = life - 5
   FOR ff = f1 TO f2 STEP f3
      CLS
      STATS 0
      rt = rt + 10
      w = INT(RND * 8): w2 = 201 - w: fliper = jumpa + rt
      PSET (col, 201 - fliper), 1
      DRAW "TA" + STR$(ff) + player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50
   combo = combo + 1: rt = 0: w = 0: w2 = 0
   jumpa = fliper: down = 1: up = 0: fliper = 0
RETURN

flat:
   PLAY "MBL8O4BAGFEDC"
   IF fliptype = 1 THEN f1 = -10: f2 = -80: f3 = -10
   IF fliptype = 2 THEN f1 = 10: f2 = 130: f3 = 15
   FOR ff = f1 TO f2 STEP f3
      CLS
      STATS 0
      PSET (col, 201), 1
      DRAW "TA" + STR$(ff) + player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   CLS
   STATS 0
   HANDLER
   IF fliptype = 1 THEN SPLASH col + 20, 201, 11
   IF fliptype = 2 THEN SPLASH col - 125, 201, 11
   life = life - 60
   combo = 0: jumpa = 0: down = 0: up = 0
   GOTO redo

inverted:
   Survive = INT(RND * 100) + 1 + comboMinus
   IF Survive > 40 THEN fliptype = 1: GOTO flat
   FOR spinup = 0 TO -180 STEP -20
      CLS
      STATS 0
      PSET (115!, 60!), 0: DRAW "TA" + STR$(spinup) + player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   FOR goright = 115 TO 515 STEP 50
      CLS
      STATS 0
      PSET (goright, 60!), 0: DRAW "TA-180" + player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   CLS : STATS 0: PSET (515!, 120!), 0: DRAW "TA-180" + player$: HANDLER: SPLASH 470, 201, 8
   life = life - 10: score = score + 500
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   jumpa = 0: up = 0: down = 0: col = 515
   GOTO redo
      
bunz:
   Survive = INT(RND * 100) + 1 + comboMinus: IF Survive > 37 THEN fliptype = 1: GOTO flat
   FOR boun1 = jumpa TO 190 STEP 10
      col = col - 7
      CLS : STATS 0
      PSET (col, 200 - boun1), 0: DRAW player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   FOR boun2 = 190 TO 0 STEP -10
      col = col - 7: IF col = 10 THEN jumpa = boun2: down = 1: up = 0: EXIT FOR
      CLS : STATS 0
      PSET (col, 200 - boun2), 0: DRAW player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   life = life - 5: score = score + 415: jumpa = boun2
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   GOTO redo


flashr:
   Survive = INT(RND * 100) + 1 + comboMinus: IF Survive > 33 THEN fliptype = 1: GOTO flat
   FOR FlashUp = jumpa TO 150 STEP 10
      CLS : STATS 0
      PSET (col, 201 - FlashUp), 0: DRAW player$
      COLOR 0, 15
      HANDLER
      CLS : STATS 0
      PSET (col - 40 + INT(RND * 80), 201 - FlashUp), 0: DRAW player$
      COLOR 0, 11
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   jumpa = FlashUp: up = 0: down = 1: life = life - 5
   score = score + INT(score / 10)
   GOTO redo

mspike:
   Survive = INT(RND * 100) + 1 + comboMinus: IF Survive > 56 THEN fliptype = 1: GOTO flat
   FOR spiker1 = 1 TO 4
      jumpa = jumpa - 5
      col = col + 35
      CLS : STATS 0: PSET (col, 201 - jumpa), 0: DRAW player$: HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   FOR spiker2 = jumpa TO 0 STEP -10
      col = col + 35
      CLS : STATS 0: PSET (col, 201 - spiker2), 0: DRAW player$: HANDLER
      col = col - 35
      CLS : STATS 0: PSET (col, 201 - spiker2), 0: DRAW player$: HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   SPLASH col, 201, 2
   score = score + 325
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50: combo = combo + 1
   down = 0: up = 0: jumpa = 0
   GOTO redo

circleR:
   Survive = INT(RND * 100) + 1 + comboMinus: IF Survive > 46 THEN fliptype = 2: GOTO flat
   FOR circlo2 = 1 TO 3
      FOR circlo1 = 1 TO 4
         SELECT CASE circlo1
         CASE 1: col = col + 30: jumpa = jumpa + 30
         CASE 2: col = col - 30: jumpa = jumpa + 30
         CASE 3: col = col - 30: jumpa = jumpa - 30
         CASE 4: col = col + 30: jumpa = jumpa - 30
         END SELECT
         CLS : STATS 0
         PSET (col, jumpa), 0: DRAW player$
         HANDLER
         IF DelayPlay = 1 THEN PAUSE .05
      NEXT
   NEXT
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   life = life - 1: score = score + 320
   GOTO redo

cruise:
   Survive = INT(RND * 100) + 1 + comboMinus: IF Survive > 83 THEN fliptype = 2: GOTO flat
   FOR cruiz = col TO col + 210 STEP 35
      cruiz2 = cruiz2 + 3
      CLS : STATS 0
      PSET (cruiz, 201 - cruiz2), 0: DRAW player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   col = cruiz
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   SPLASH col, 195, 4: cruiz2 = 0: score = score + 44
   GOTO redo

wav:
   Survive = INT(RND * 100) + 1 + comboMinus: IF Survive > 74 THEN fliptype = 1: GOTO flat
   FOR wavin1 = col TO col + 140 STEP 20
      IF upere = 0 THEN upere = 20 ELSE upere = 0
      CLS : STATS 0
      PSET (wavin1, 201 - jumpa - upere), 0: DRAW player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   life = life - 5: score = score + 90: col = wavin1
   GOTO redo

tele:
   colPar = (INT(RND * 16) * 35) + 10: teleX2 = 81
   IF colPar = col THEN GOTO tele
   FOR teleX = 1 TO 71 STEP 10
      CLS : STATS 0
      PSET (col, 201 - jumpa), 0: DRAW player$
      CIRCLE (col + 50, 201 - jumpa - 65), teleX, 0
      PAINT (col + 50, 201 - jumpa - 65), 0
      teleX2 = teleX2 - 10
      PSET (colPar, 201 - jumpa), 0: DRAW player$
      CIRCLE (colPar + 50, 201 - jumpa - 65), teleX2, 0
      PAINT (colPar + 50, 201 - jumpa - 65), 0
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   col = colPar
   jumpa = jumpa - 10
   Survive = INT(RND * 100) + 1 + comboMinus: IF Survive > 75 THEN life = life - 23: PLAY "L64O1CD+ED+C"
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   GOTO redo

blur:
   Survive = INT(RND * 100) + 1 + comboMinus
   IF Survive > 85 THEN fliptype = 1: GOTO flat
   FOR blurr = 80 TO 580 STEP 100
      CLS
      u = u + 1
      STATS 0
      FOR bgo = 1 TO u
         PSET (blurr - (bgo * 50), 201!), 0: DRAW player$
      NEXT
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   life = life - 5
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   score = score + 40: col = 530
   GOTO redo

bomb:
   FOR blown1 = 2 TO 72 STEP 10
      CLS : STATS 0
      PSET (col, 201 - jumpa), 0: DRAW player$
      CIRCLE (col + 50, 201 - jumpa - 65), blown1, 3
      PAINT (col + 50, 201 - jumpa - 65), 4, 3
      CIRCLE (col + 50, 201 - jumpa - 65), blown1, 3
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   FOR blown2 = 2 TO 72 STEP 10
      CLS : STATS 0
      CIRCLE (col + 50, 201 - jumpa - 65), blown1, 3
      PAINT (col + 50, 201 - jumpa - 65), 4, 3
      CIRCLE (col + 50, 201 - jumpa - 65), blown1, 3
      CIRCLE (col + 50, 201 - jumpa - 65), blown2, 0
      PAINT (col + 50, 201 - jumpa - 65), 0
      HANDLER
   NEXT
   score = score + 999
   combo = combo + 1: bombed = 1: GOSUB ComboBonus
   GOTO downer2

saw:
   Survive = INT(RND * 100) + 1 + ComboBonus
   IF Survive > 50 THEN fliptype = 2: GOTO flat
   FOR buzz = 1 TO 4
      FOR buz = 90 TO 360 STEP 90
         CLS
         STATS 0
         PSET (col, 150!), 0: DRAW "TA" + STR$(buz) + player$
         HANDLER
         IF DelayPlay = 1 THEN PAUSE .05
      NEXT
   NEXT
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   life = life - 10: score = score + 260
   GOTO redo

flame:
   Survive = INT(RND * 100) + 1 + ComboBonus
   IF Survive > 85 THEN fliptype = 2: GOTO flat
   colf = 185
   FOR fiery = 201 TO 1 STEP -50
      CLS
      colf = colf + 70
      STATS 0: PSET (colf, fiery), 0: DRAW player$
      CIRCLE (colf, fiery), INT(RND * 3) + 2, 12
      CIRCLE (colf, fiery), INT(RND * 3) + 4, 4
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   life = life - 20: score = score + 40
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   GOTO redo
   
skim:
   Survive = INT(RND * 100) + 1 + ComboBonus
   FOR ski = 45 TO 280 STEP 35
      CLS
      STATS 0
      PSET (ski, 191!), 0: DRAW player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   IF Survive > 65 THEN fliptype = 1: col = 280: GOTO flat
   FOR ski = 315 TO 460 STEP 35
      CLS
      STATS 0
      CIRCLE (ski - 3 + INT(RND * 6), 198), INT(RND * 2) + 2, 1
      CIRCLE (ski - 3 + INT(RND * 6), 198), INT(RND * 2) + 2, 1
      CIRCLE (ski - 3 + INT(RND * 6), 198), INT(RND * 2) + 2, 1
      PSET (ski, 201!), 0: DRAW player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   CLS : STATS 0: PSET (460!, 201!), 0: DRAW player$: HANDLER
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   up = 3: col = 460: score = score + 150: life = life - 2: jumpa = 10
   SPLASH col, 201, 1
   GOSUB flip
   GOTO redo

chopp:
   Survive = INT(RND * 100) + 1 + ComboBonus: IF Survive > 100 THEN fliptype = 1: GOTO flat
   FOR ch = 1 TO 6
      CLS
      STATS 0
      IF ch = 1 OR ch = 3 OR ch = 5 THEN PSET (col + 40, 201 - (jumpa + 30)), 0
      IF ch = 2 OR ch = 4 OR ch = 6 THEN PSET (col + 40, 201 - (jumpa + 92)), 0
      IF ch = 1 OR ch = 3 OR ch = 5 THEN DRAW "TA90" + player$
      IF ch = 2 OR ch = 4 OR ch = 6 THEN DRAW "TA-90" + player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   score = score + 25: life = life - 11
   GOTO redo

sharky:
   Survive = INT(RND * 100) + 1 + ComboBonus: IF Survive > 45 THEN fliptype = 1: GOTO flat
   PLAY "MBO1L8CC#"
   FOR fallshk = 70 TO 10 STEP -20
      CLS
      STATS 0
      PSET (315, 201), 0: DRAW "C8U2E30D15F1D16L30BR5BU2P7,8BD2BL4C7R28"
      PSET (315, 201 - fallshk), 0: DRAW player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   PLAY "T255L64CDGEFDGCEDFGFGFGCDFGEFGDFGFGCEGFEDFGCFGEDCEGCFT124"
   life = life - 25: score = score + 440
   comboMinus = comboMinus + 6: IF comboMinus > 50 THEN comboMinus = 50:
   combo = combo + 1
   jump = 0: up = 0: down = 0: jumpa = 0
   GOTO redo
  
timesup:
   jumpa = 0: up = 0: down = 0: STATS 0: PSET (col, 201!), 0: DRAW player$: HANDLER
   PLAY "MFO1L8CC#"
   CLS : STATS 0: PSET (col, 201!), 0: DRAW player$ + "R4F1R4F1R4D2BH1P4,4": HANDLER
   PLAY "P4CC#P4CC#CC#CD#C#"
   FOR shark = 565 TO col STEP -35
      PLAY "MFO1L12CC#"
      CLS
      STATS 0: PSET (col, 201!), 0: DRAW player$ + "R4F1R4F1R4D2BH1P4,4"
      PSET (shark, 201!), 0: DRAW "C8U2E30D15F1D16L30BR5BU2P7,8BD2BL4C7R28"
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT

downer:
   PLAY "MBL8O4BAGFEDC"
   FOR downing = 1 TO 120 STEP 10
      CLS
      STATS 1
      PSET (col, 201 + downing), 1
      DRAW player$
      HANDLER
   IF DelayPlay = 1 THEN PAUSE .05
   NEXT
   SPLASH col, 201, 11
downer2:
   SCREEN 7
   LINE (0!, 0!)-(319!, 199!), 15, B
   LINE (2!, 2!)-(317!, 197!), 15, B
   COLOR 14, 8
   LOCATE 2, 12: PRINT "Majesty Software"
   COLOR 11
   LOCATE 5, 14: PRINT "Stunt Surfer"
   LOCATE 7, 14: PRINT "You scored:"
   IF score = 3333 THEN score = score * 2
   IF score = 666 THEN score = 0
   IF score = 12345 THEN score = score + (INT(RND * 4) * 1000)
   scplace = LEN(STR$(score)) / 2 + 3: scplace = 20 - scplace
   IF score > highScor THEN OPEN "O", #1, "SURFER.HI": PRINT #1, score: CLOSE #1
   LOCATE 10, scplace: COLOR 15: PRINT score; "Points"
   IF score < 14001 THEN LOCATE 13, 11: COLOR 11: PRINT "Which makes you:"
   SELECT CASE score
   CASE 0: are$ = "* A Komplete Klutz!!! *"
   CASE 1 TO 100: are$ = "* A Baby Boarder *"
   CASE 101 TO 500: are$ = "* A Pretty Good Surfer *"
   CASE 501 TO 1000: are$ = "* A Bodacious Rider *"
   CASE 1001 TO 2000: are$ = "* A Spectacular Stuntperson *"
   CASE 2001 TO 3500: are$ = "* A Professional Dude *"
   CASE 3501 TO 5000: are$ = "* A Show-off *"
   CASE 5001 TO 7000: are$ = "* The Grooviest Surfer Dude *"
   CASE 7001 TO 10000: are$ = "* An Ultra Rockin' Waver *"
   CASE 10001 TO 14000: are$ = "* The Ultimate Surfer Man *"
   CASE 14001 TO 20000: are$ = "* The Monstrous Wave Master *"
   CASE IS > 20000: are$ = "* Most Excellent!!!! *"
   END SELECT
   LOCATE 17, 20 - (LEN(are$) / 2)
   COLOR 12: PRINT are$: COLOR 11
   IF T$ = "T" THEN
      IF curPlay = 1 THEN LOCATE 20, 5: PRINT "Next up, Player 2...": GETKEY: score1 = score: player$ = player2$: curPlay = 2: GOTO startover
      IF curPlay = 2 THEN
         LOCATE 20, 5: PRINT "Player 1...  "; score1
         LOCATE 21, 5: PRINT "Player 2...  "; score
         LOCATE 23, 5
         IF score1 > score THEN PRINT "Player 1 WINS!!!" ELSE IF score > score1 THEN PRINT "Player 2 WINS!!!" ELSE IF score = score1 THEN PRINT "It's a TIE!!!"
      END IF
   END IF
   IF T$ = "F" THEN
      IF curPlay = 1 THEN LOCATE 20, 5: PRINT "Next up, Player 2...": GETKEY: score1 = score: player$ = player2$: curPlay = 2: GOTO startover
      IF curPlay = 2 THEN LOCATE 20, 5: PRINT "Next up, Player 3...": GETKEY: score2 = score: player$ = player3$: curPlay = 3: GOTO startover
      IF curPlay = 3 THEN LOCATE 20, 5: PRINT "Next up, Player 4...": GETKEY: score3 = score: player$ = player4$: curPlay = 4: GOTO startover
      IF curPlay = 4 THEN
      LOCATE 19, 5: PRINT "Player 1...  "; score1
         LOCATE 20, 5: PRINT "Player 2...  "; score2
         LOCATE 21, 5: PRINT "Player 3...  "; score3
         LOCATE 22, 5: PRINT "Player 4...  "; score
         LOCATE 24, 5
         IF score1 > score2 AND score1 > score3 AND score1 > score THEN PRINT "Player 1 WINS!!!";
         IF score2 > score1 AND score2 > score3 AND score2 > score THEN PRINT "Player 2 WINS!!!";
         IF score3 > score1 AND score3 > score2 AND score3 > score THEN PRINT "Player 3 WINS!!!";
         IF score4 > score1 AND score4 > score2 AND score4 > score3 THEN PRINT "Player 4 WINS!!!";
         IF score1 = score2 AND score1 = score3 AND score = score2 THEN PRINT "It's a TIE!!!";
      END IF
   END IF
   PLAY "MFO1L16CP16CCCP16CP16DP16DDDP16DP16L4E"
   GETKEY
reAgain:
   SCREEN 9, 0, 0, 1
   COLOR 8, 7
again:
   CLS : PAINT (0!, 0!), 9
   PSET (499!, 160!), 0
   y = y + 5: IF y = 365 THEN y = 5
   DRAW "TA" + STR$(y) + player$
   BOX 10, 10, 319, 189
   IF DelayPlay = 1 THEN PAUSE .01
   LOCATE 3, 3: PRINT "          Stunt Surfer 3.3"
   LOCATE 4, 3: PRINT "              Main Menu      "
   LOCATE 5, 3: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   LOCATE 6, 3: COLOR 15: PRINT "   O"; : COLOR 8: PRINT "ne Player Game"
   LOCATE 7, 3: COLOR 15: PRINT "   T"; : COLOR 8: PRINT "wo Player Showdown"
   LOCATE 8, 3: COLOR 15: PRINT "   F"; : COLOR 8: PRINT "our Player Tournament"
   LOCATE 9, 3: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   LOCATE 10, 3: COLOR 15: PRINT "   A"; : COLOR 8: PRINT "dd Delay (Faster CPUs)"
   LOCATE 11, 3: COLOR 15: PRINT "   Q"; : COLOR 8: PRINT "uit Stunt Surfer 3.3"
   LOCATE 12, 3: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   LOCATE 13, 3: PRINT "  (C)1996 \|/Majesty Software Corp."
   HANDLER
   curPlay = 1
   T$ = INKEY$: IF T$ = "" THEN GOTO again
   T$ = UCASE$(T$)
   IF T$ = CHR$(27) OR T$ = "Q" THEN QUIT
   IF T$ = "A" THEN
      IF DelayPlay = 0 THEN DelayPlay = 1: DelaySkip = 1
      IF DelayPlay = 1 AND DelaySkip = 0 THEN DelayPlay = 0
      DelaySkip = 0
   END IF
   IF T$ = "O" OR T$ = "T" OR T$ = "F" THEN sko = 2: GOTO suit
GOTO again

suit:
   CLS : PAINT (0!, 0!), 9
   PSET (499!, 160!), 0
   DRAW player$
   BOX 10, 10, 319, 189
   LOCATE 3, 3: PRINT "          Stunt Surfer 3.3"
   LOCATE 4, 3: PRINT "               Suit-up"
   LOCATE 5, 3: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   LOCATE 6, 3: PRINT " Up/Down = to change; ENTER to accept"
   LOCATE 9, 3
   SELECT CASE curPlay
   CASE 1: PRINT "             Player One"
   CASE 2: PRINT "             Player Two"
   CASE 3: PRINT "            Player Three"
   CASE 4: PRINT "            Player Four"
   END SELECT
   LOCATE 12, 3: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   LOCATE 13, 3: PRINT "  (C)1996 \|/Majesty Software Corp."
   HANDLER
   R$ = INKEY$: IF R$ = "" THEN GOTO suit
   IF R$ = CHR$(0) + "H" THEN sko = sko - 1: IF sko = 0 THEN sko = 12
   IF R$ = CHR$(0) + "P" THEN sko = sko + 1: IF sko = 13 THEN sko = 1
   IF R$ = CHR$(13) THEN
      SELECT CASE curPlay
         CASE 1: player1$ = player$
         CASE 2: player2$ = player$
         CASE 3: player3$ = player$
         CASE 4: player4$ = player$
      END SELECT
      curPlay = curPlay + 1
   END IF
   IF T$ = "O" AND curPlay = 2 THEN curPlay = 1: allre = 1: GOTO startover
   IF T$ = "T" AND curPlay = 3 THEN curPlay = 1: allre = 1: GOTO startover
   IF T$ = "F" AND curPlay = 5 THEN curPlay = 1: allre = 1: GOTO startover
   SELECT CASE sko
      CASE 1: oc = 7: ic = 15
      CASE 2: oc = 12: ic = 4
      CASE 3: oc = 7: ic = 8
      CASE 4: oc = 1: ic = 11
      CASE 5: oc = 2: ic = 10
      CASE 6: oc = 8: ic = 7
      CASE 7: oc = 5: ic = 13
      CASE 8: oc = 8: ic = 6
      CASE 9: oc = 10: ic = 2
      CASE 10: oc = 8: ic = 8
      CASE 11: oc = 13: ic = 5
      CASE 12: oc = 15: ic = 7
   END SELECT
aa$ = "C2R80H1L78G1BE2BR20C14R20U1L15R5U1R10U50L10D50BE2P14,14BD4BR20R20L5U1L15U1R10U50L10D50BE2P14,14BU49C" + STR$(oc) + "R10U10H10L15G10D10R15U10R5D10R5BU3P" + STR$(ic) + "," + STR$(oc)
ab$ = "BU18C14L15H40F5U5D5E5G5F1R2F4R5F6R8F10R15E10R10E10R5D1L5D2R5D1L5G30BU5P14,14BU10C1L15U1R15U1L30G10R1E10R15C14BU1U15R15D15L15BE5P14,14BU5C11R3D1L3R3BR5R3U1L3BD7C4L10H4"
player$ = aa$ + ab$
GOTO suit

SUB BOX (col, row, ecol, erow)

LINE (col, row)-(ecol, erow), 7, BF
LINE (col, row)-(ecol, row + 15), 3, BF
LINE (col, row + 16)-(ecol, erow), 15, B
LINE (col, row)-(ecol, row + 15), 15, B
LINE (col, erow)-(ecol, erow), 8
LINE (ecol, row + 16)-(ecol, erow), 8
LINE (col, row + 15)-(ecol, row + 15), 8
LINE (ecol, row)-(ecol, row + 15), 8


END SUB

SUB GETKEY
redogetkey:
DO: z$ = INKEY$: LOOP UNTIL z$ <> "": IF z$ = CHR$(27) THEN QUIT
IF blah = 1 AND z$ <> CHR$(13) THEN GOTO redogetkey

END SUB

SUB HANDLER
      w = INT(RND * 8): w2 = 201 - w
      LINE (0!, w2)-(639!, 349!), 1, BF
      d = d + 1: IF d = 2 THEN d = 0
      IF d = 0 THEN LINE (0!, w2 - 1)-(639!, w2 - 1), 1, , &HFF00
      IF d = 1 THEN LINE (0!, w2 - 1)-(639!, w2 - 1), 1, , &HFF90
      IF PrevGo = 0 THEN PCOPY 0, 1

END SUB

SUB MAJ
SCREEN 7, , 0, 1
 DRAW "C14R30E1R5E1R2": FOR uping = 1 TO 20: DRAW "E1U1": NEXT
 DRAW "G23L1G2L1H17G17L1H2L1H23": FOR downing = 1 TO 20: DRAW "F1D1": NEXT
 DRAW "R2F1R5": PAINT (180!, 99!), 14: DRAW "BH5C2E3U8H3G3D8F3BU4P10,2"
 GET (129!, 50!)-(230!, 101!), crown
FOR crowning = 0 TO 50
 CLS
 T = T + 1: IF T = 6 THEN PLAY "MBL16O2AO3EA": T = 0
 PUT (108!, crowning), crown
 PCOPY 0, 1
NEXT
PLAY "MBL16O3BO4EL12C#O3L2A"
SCREEN , , , 0
LOCATE 14, 17: COLOR 4: PRINT "MAJESTY"
FOR I = 1 TO 3000: NEXT
LOCATE 14, 17: COLOR 12: PRINT "MAJESTY"
GETKEY

END SUB

SUB MIDTEXT (text$, row%, tColor%)
   COLOR tColor%: LOCATE row%, 40 - INT(LEN(text$) / 2): PRINT text$
END SUB

SUB PAUSE (Seconds AS SINGLE)

    Pauser! = TIMER
    DO
        SecPauser! = TIMER - Pauser!
    LOOP UNTIL SecPauser! > Seconds

END SUB

SUB QUIT
x = 2
DO
      x = x + 10
      w = INT(RND * 8): w2 = 201 - (w + x)
      LINE (0!, w2)-(639!, 349!), 1, BF
      d = d + 1: IF d = 2 THEN d = 0
      IF d = 0 THEN LINE (0!, w2 - 1)-(639!, w2 - 1), 1, , &HFF00
      IF d = 1 THEN LINE (0!, w2 - 1)-(639!, w2 - 1), 1, , &HFF90
      PCOPY 0, 1
LOOP UNTIL x = 202
COLOR 15, 0: CLS : PCOPY 0, 1
SYSTEM
END SUB

SUB SPLASH (col, row, amount)
PLAY "MBL54O0CC+DD+EFF+GG+GF+FED+DC+C"
FOR spl = 1 TO amount
   FOR spl2 = 1 TO 4
      CIRCLE (col - 30 + INT(RND * 170), row - INT(RND * amount * 5 + 10)), INT(RND * 2) + 1, 1
   NEXT
   w = INT(RND * 8): w2 = 201 - w
   IF amount <> 11 THEN PSET (col, 201 - jumpa), 1: DRAW player$
   LINE (0!, w2)-(639!, 349!), 1, BF
   d = d + 1: IF d = 2 THEN d = 0
   IF d = 0 THEN LINE (0!, w2 - 1)-(639!, w2 - 1), 1, , &HFF00
   IF d = 1 THEN LINE (0!, w2 - 1)-(639!, w2 - 1), 1, , &HFF90
   PCOPY 0, 1
NEXT
END SUB

SUB STARTUP
CLS : COLOR 8, 7: PAINT (0!, 0!), 9: STATS 2: PSET (80!, 201!), 0: DRAW player$: HANDLER
reee:
BOX 159, 80, 479, 269
IF mlp = 0 THEN GOTO data1
IF mlp = 1 THEN GOTO data2
IF mlp = 2 THEN GOTO data3
IF mlp = 3 THEN EXIT SUB
ee1:
IF mlp = 2 THEN COLOR 1
LOCATE 8, 22: PRINT pa$
IF mlp = 2 THEN COLOR 11
LOCATE 9, 22: PRINT pb$
LOCATE 10, 22: PRINT pc$
LOCATE 11, 22: PRINT pd$
LOCATE 12, 22: PRINT pe$
LOCATE 13, 22: PRINT pf$
COLOR 8
LOCATE 14, 22: PRINT pg$
LOCATE 15, 22: PRINT ph$
LOCATE 16, 22: PRINT pi$
LOCATE 17, 22: PRINT pj$
PCOPY 0, 1
GETKEY
GOTO reee
data1:
pa$ = "COPYRIGHT (c) 1996 Majesty Software"
pb$ = "All rights reserved. This program is"
pc$ = "freeware. It may not be sold for any"
pd$ = "prices other than shipping & handling"
pe$ = "fees or reasonable copying fees. It"
pf$ = "is protected by the United States"
pg$ = "copyright act."
ph$ = ""
pi$ = ""
pj$ = "<<< ENTER to accept; ESC to cancel >>>"
mlp = 1
GOTO ee1
data2:
pa$ = "   S       T       U       N       T"
pb$ = "   °°°° °  ° °°°° °°°° °°°° °°°° °°°"
pc$ = "   ±    ±  ± ±  ± ±    ±    ±  ± ±±±"
pd$ = "   ²²²² ²  ² ²²²  ²²²  ²²²  ²²²  ²²²"
pe$ = "      Û Û  Û Û Û  Û    Û    Û Û    "
pf$ = "   ÛÛÛÛ ÛÛÛÛ Û  Û Û    ÛÛÛÛ Û  Û ÛÛÛ"
pg$ = ""
ph$ = "             Version 3.3            "
pi$ = ""
pj$ = "** ENTER to accept; ESC to cancel **"
mlp = 2
GOTO ee1
data3:
PUT (350!, 100!), crown, PSET
pa$ = "   Credits:"
pb$ = ""
pc$ = "   Programming:"
pd$ = "   ¯ Michael Ziphrus"
pe$ = ""
pf$ = ""
pg$ = "   Testing:"
ph$ = "   ¯ Geoff Sadalanski"
pi$ = "   ¯ Michael Ziphrus"
pj$ = "   ¯ Steve Baron"
mlp = 3
GOTO ee1
END SUB

SUB STATS (ender)
   IF life > 60 THEN lifeColor = 4
   IF life < 61 THEN lifeColor = INT(RND * 2)
   IF lifeColor = 0 THEN lifeColor = 4
   IF lifeColor = 1 THEN lifeColor = 12
   IF ender = 0 OR ender = 2 THEN LINE (0!, 1!)-(life, 12!), lifeColor, BF: LINE (0!, 0!)-(life, 0!), lifeColor, , &HFF10
   IF life < 61 THEN LOCATE 1, 8: COLOR lifeColor: PRINT "Warning!"
   IF ender < 2 THEN LOCATE 1, 53: COLOR 4: PRINT "Time:"; INT(timeLeft!)
   IF ender < 2 THEN LOCATE 1, 63: PRINT "Score:"; score
   IF ender < 2 THEN LOCATE 2, 63: PRINT "Hi-Score:"; highScor
END SUB

