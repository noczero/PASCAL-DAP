'_|_|_|   GAMEBASE.BAS
'_|_|_|   Simple routines usable for game design.
'_|_|_|   No guarantee or warrantee given or implied.
'_|_|_|   Released   PUBLIC DOMAIN   by Kurt Kuzba.  (1/15/97)
'$DYNAMIC
TYPE spritedata: y AS INTEGER: x AS INTEGER: w AS INTEGER: h AS INTEGER
   sprite AS STRING * 100: buffer AS STRING * 100: END TYPE
TYPE setupdata: y AS INTEGER: x AS INTEGER: objdef AS INTEGER: END TYPE
DECLARE SUB levelssetup (S() AS setupdata, N%)
DECLARE SUB qbblitsprite (S AS spritedata)
DECLARE SUB qbgetsprite (S AS spritedata)
DECLARE SUB qbputsprite (S AS spritedata)
DECLARE SUB backgrounddata (S$, N%)
DECLARE SUB monsterdata (S$, N%)
DECLARE SUB playerdata (S$, N%)
DECLARE SUB levelsdata (S$, N%)
DECLARE SUB prizedata (S$, N%)
DECLARE SUB spritecolors (S$)
DECLARE SUB showlevel (L%)
DIM Lft AS INTEGER, Rgt AS INTEGER, Clm AS INTEGER, Wpn AS INTEGER
DIM player(15) AS STRING * 100, weapon(4) AS STRING * 100
DIM monster(6) AS STRING * 100, prize(6) AS STRING * 100
DIM sprite(11) AS spritedata, blast AS spritedata
DIM SHARED levdat AS STRING * 640, background(16000) AS LONG
DIM objects(10) AS setupdata
CONST front = 0: CONST back = 1: CONST climb = 2
CONST runright = 5: CONST runleft = 8
CONST standright = 11: CONST standleft = 12
CONST jumpright = 13: CONST jumpleft = 14
CONST shootright = 0: CONST shootleft = 2
FOR t% = 0 TO 14: playerdata player(t%), t%: NEXT
FOR t% = 0 TO 3: playerdata weapon(t%), t% + 15: NEXT
FOR t% = 0 TO 5: prizedata prize(t%), t%
   monsterdata monster(t%), t%: NEXT: sprite(0).w = 10
sprite(0).h = 10: FOR t% = 1 TO 10: sprite(t%) = sprite(0): NEXT
DEF SEG = &H40: POKE &H17, PEEK(&H17) AND 223: DEF SEG
SCREEN 13: GOSUB CreateLevel: Lft = 0: Rgt = 0: Clm = 0: Wpn = 0
GameOver% = 10: sprite(0).x = 180: sprite(0).y = 10: figure = front
sprite(0).sprite = player(figure): qbblitsprite sprite(0)
FOR t% = 1 TO 5: sprite(t%).y = objects(t% - 1).y
   sprite(t%).x = objects(t% - 1).x: qbgetsprite sprite(t%): NEXT
FOR t% = 6 TO 10
   sprite(t%).y = objects(t% - 1).y: sprite(t%).x = objects(t% - 1).x
   sprite(t%).sprite = prize(objects(t% - 1).objdef)
   qbblitsprite sprite(t%): NEXT
FOR Fstart% = 0 TO 100
   K$ = INKEY$: x% = sprite(0).x: y% = sprite(0).y: falling = 0
   nx% = x%: ny% = y%: Fstart% = 0: IF K$ = CHR$(27) THEN EXIT FOR
   xy% = (x% \ 10) * 32 + (y% + 3) \ 10 + 1: Feet% = xy% + 32
   IF x% < 180 THEN
      SELECT CASE ASC(MID$(levdat, Feet%))
         CASE 0, 2: falling = -1
         CASE 1, 4: falling = 0
         CASE 5: falling = ((x% MOD 10) > 0)
         CASE ELSE: falling = ((x% MOD 10) > 2)
      END SELECT
   END IF
   SELECT CASE INP(96)
      CASE 75: move$ = "RL"
      CASE 203: move$ = "SL"
      CASE 77: move$ = "RR"
      CASE 205: move$ = "SR"
      CASE 72: move$ = "CU"
      CASE 200: move$ = "SB"
      CASE 80: move$ = "CD"
      CASE 208: move$ = "SB"
      CASE 82: move$ = "SF"
   END SELECT
   SELECT CASE move$
      CASE "RL"
         w% = -1: IF y% > 9 THEN w% = (ASC(MID$(levdat, xy% - 1)) = 6)
         IF ((y% MOD 10) <> 0) OR (NOT w%) THEN
            IF falling THEN nx% = nx% + 1
            ny% = ny% - 1: figure = runleft + lr% \ 4
            lr% = (lr% + 1) MOD 12: GOSUB blitplayer
         ELSE
            IF figure <> standleft THEN
               figure = standleft: GOSUB blitplayer
            END IF: move$ = "SL"
         END IF
      CASE "SL"
         IF figure <> standleft THEN
            figure = standleft: IF falling THEN nx% = nx% + 1
            GOSUB blitplayer
         ELSE
            IF falling THEN nx% = nx% + 1: GOSUB blitplayer
         END IF
      CASE "RR"
         w% = -1: IF y% < 310 THEN w% = (ASC(MID$(levdat, xy% + 1)) = 6)
         IF ((y% MOD 10) <> 0) OR (NOT w%) THEN
            IF falling THEN nx% = nx% + 1
            ny% = ny% + 1: figure = runright + RR% \ 4
            RR% = (RR% + 1) MOD 12: GOSUB blitplayer
         ELSE
            IF figure <> standright THEN
               figure = standright: GOSUB blitplayer
            END IF: move$ = "SR"
         END IF
      CASE "SR"
         IF figure <> standright THEN
            figure = standright: IF falling THEN nx% = nx% + 1
            GOSUB blitplayer
         ELSE
            IF falling THEN nx% = nx% + 1: GOSUB blitplayer
         END IF
      CASE "CU"
         IF x% > 0 THEN
            O% = ASC(MID$(levdat, xy%)): O% = (O% = 4) + (O% = 1)
         END IF
         IF x% < 608 THEN
            b% = ASC(MID$(levdat, xy% + 32)): b% = (b% = 1) + (b% = 4)
         END IF: L% = b% + O%
         IF L% THEN
            figure = climb + CL% \ 5: CL% = (CL% + 1) MOD 15
            nx% = nx% + (nx% > 0)
            ny% = ny% + 3 - ((ny% + 3) MOD 10): GOSUB blitplayer
         ELSE
            move$ = "SB"
            IF figure <> back THEN figure = back: GOSUB blitplayer
         END IF
      CASE "CD"
         IF (x% MOD 10) <> 0 THEN
            b% = ASC(MID$(levdat, xy% + 32)): O% = ASC(MID$(levdat, xy%))
            IF (O% = 4) OR (O% = 5) OR (b% = 4) OR (b% = 5) THEN
               figure = climb + CL% \ 5: CL% = (CL% + 14) MOD 15
               nx% = nx% + 1: ny% = (ny% + 3) - ((ny% + 3) MOD 10)
               GOSUB blitplayer
            END IF
         ELSE
            b% = ASC(MID$(levdat, xy% + 32))
            IF ((b% = 2) OR (b% = 4) OR (b% = 5)) AND (x% < 180) THEN
               figure = climb + CL% \ 5: CL% = (CL% + 14) MOD 15
               nx% = nx% + 1: ny% = (ny% + 3) - ((ny% + 3) MOD 10)
               GOSUB blitplayer
            END IF
         END IF
      CASE "SB": IF falling THEN nx% = nx% + 1: figure = front
         IF figure <> back THEN figure = back: GOSUB blitplayer
      CASE "SF": IF falling THEN nx% = nx% + 1: figure = back
         IF figure <> front THEN figure = front: GOSUB blitplayer
   END SELECT: DEF SEG = &H40: sh% = PEEK(&H17): DEF SEG
   IF ((sh% AND 8) = 8) AND (INSTR("SLSR", move$) > 0) THEN
      blast = sprite(0): Yloc% = 10: fire% = shootright
      IF move$ = "SL" THEN Yloc% = -10: fire% = shootleft
      blast.y = blast.y + Yloc%: wave% = (wave% + 1) AND 1
      WAIT &H3DA, 8: WAIT &H3DA, 8, 8: SOUND RND * 1000 + 100, .3
      blast.sprite = weapon(fire% + wave%): qbblitsprite blast
      WAIT &H3DA, 8: WAIT &H3DA, 8, 8: SOUND RND * 1000 + 999, .3
      blast.sprite = blast.buffer: qbputsprite blast
   END IF
   FOR sp% = 1 TO 5: qbputsprite sprite(sp%)
      sprite(sp%).sprite = monster(objects(sp% - 1).objdef)
      qbblitsprite sprite(sp%)
      sprite(sp%).sprite = sprite(sp%).buffer: NEXT
NEXT: DEF SEG = &H40: POKE &H17, PEEK(&H17) OR 32: DEF SEG
SCREEN 0: WIDTH 80, 25: SYSTEM
CreateLevel: : showlevel 1: levelssetup objects(), 1
   FOR t% = 0 TO 4: sprite(t% + 1).h = 10: sprite(t% + 1).w = 10
      sprite(t% + 1).y = objects(t%).y
      sprite(t% + 1).x = objects(t%).x
      sprite(t% + 6).h = 10: sprite(t% + 6).w = 10
      sprite(t% + 6).y = objects(t% + 5).y
      sprite(t% + 1).x = objects(t% + 5).x: NEXT: RETURN
blitplayer: : sprite(0).sprite = sprite(0).buffer
   qbputsprite sprite(0): sprite(0).x = nx%: sprite(0).y = ny%
   sprite(0).sprite = player(figure): qbblitsprite sprite(0): RETURN
'_|_|_|   end   GAMEBASE.BAS

SUB backgrounddata (S$, N%)
   '  " " = clear   "0" = black    "1" = blue      "2" = green
   '  "3" = cyan    "4" = red      "5" = magenta   "6" = brown
   '  "7" = tan     "8" = yellow   "9" = white
   '  These colors are used with all graphics object in this prg.
   sp$ = ""
   SELECT CASE N%
      CASE 0: S$ = STRING$(100, 0): EXIT SUB
      CASE 1: sp$ = sp$ + "0665506606"  'This format is for ease
              sp$ = sp$ + " 006066550"  'of design only
              sp$ = sp$ + "  05666060"  'It is obviously more
              sp$ = sp$ + "666665560 "  'compact without having
              sp$ = sp$ + "06566600  "  'it in a visually
              sp$ = sp$ + " 065566666"  'recognizable format
              sp$ = sp$ + "  06606550"
              sp$ = sp$ + "660666560 "
              sp$ = sp$ + "65566060  "
              sp$ = sp$ + "6666560556"
      CASE 2: sp$ = sp$ + "  111111  " + "  911911  " + "  111111  "
              sp$ = sp$ + "  191191  " + "  111111  " + "  119119  "
              sp$ = sp$ + "  111111  " + "  911911  " + "  111111  "
              sp$ = sp$ + "  191191  "
      CASE 3: sp$ = sp$ + "6660666666" + "6666066660" + "6666606666"
              sp$ = sp$ + "          " + "          " + "          "
              sp$ = sp$ + "          " + "          " + "          "
              sp$ = sp$ + "          "
      CASE 4: sp$ = sp$ + "6666666666" + "6666666666" + "6000000006"
              sp$ = sp$ + "6000000006" + "6666666666" + "6000000006"
              sp$ = sp$ + "6000000006" + "6666666666" + "6000000006"
              sp$ = sp$ + "6000000006"
      CASE 5: sp$ = sp$ + "6666666666" + "  911911  " + "  111111  "
              sp$ = sp$ + "  191191  " + "  111111  " + "  119119  "
              sp$ = sp$ + "  111111  " + "  911911  " + "  111111  "
              sp$ = sp$ + "  191191  "
      CASE 6: sp$ = sp$ + "6066666606" + "6660666666" + "6666606666"
              sp$ = sp$ + "0666666066" + "6606666660" + "6666066666"
              sp$ = sp$ + "6666660666" + "6066666606" + "6660666666"
              sp$ = sp$ + "6666606666"
   END SELECT: spritecolors sp$: S$ = sp$
END SUB

SUB levelsdata (S$, N%)
   '   " " = space   "/" = up only   ";" = slide
   '   "-" = floor   "=" = ladder    "\" = trapdoor
   '   "[" = wall
   SC$ = "": S$ = STRING$(640, 0)
   SELECT CASE N%
      CASE 1        '==================================
         SC$ = SC$ + "                                "
         SC$ = SC$ + "     /----------------[=        "
         SC$ = SC$ + "-----/                [---------"
         SC$ = SC$ + "     /                          "
         SC$ = SC$ + "-----/  -----------------------/"
         SC$ = SC$ + "     /                         /"
         SC$ = SC$ + "-----/          =---------------"
         SC$ = SC$ + "     /          =               "
         SC$ = SC$ + "/-----------------------------\-"
         SC$ = SC$ + "/                             ; "
         SC$ = SC$ + "/----------        --------\----"
         SC$ = SC$ + "/                       [  ;    "
         SC$ = SC$ + "/-----------------------[  ;    "
         SC$ = SC$ + "/                       [  -----"
         SC$ = SC$ + "-------------=                  "
         SC$ = SC$ + "             =          [=      "
         SC$ = SC$ + "             =          [=      "
         SC$ = SC$ + "  ---------  =------------------"
         SC$ = SC$ + "             =                  "
         SC$ = SC$ + "--------------------------------"
   END SELECT
   FOR t% = 1 TO 640
      MID$(S$, t%) = CHR$(INSTR("/;-=\[", MID$(SC$, t%, 1))): NEXT
END SUB

SUB levelssetup (S() AS setupdata, N%)
   SELECT CASE N%
      CASE 1
         S(0).y = 150: S(0).x = 0: S(0).objdef = 1
         S(1).y = 100: S(1).x = 70: S(1).objdef = 2
         S(2).y = 200: S(2).x = 90: S(2).objdef = 3
         S(3).y = 130: S(3).x = 110: S(3).objdef = 4
         S(4).y = 270: S(4).x = 180: S(4).objdef = 5
         S(5).y = 310: S(5).x = 10: S(5).objdef = 1
         S(6).y = 140: S(6).x = 30: S(6).objdef = 2
         S(7).y = 310: S(7).x = 160: S(7).objdef = 3
         S(8).y = 0: S(8).x = 10: S(8).objdef = 4
         S(9).y = 70: S(9).x = 160: S(9).objdef = 5
   END SELECT
END SUB

SUB monsterdata (S$, N%)
   sp$ = ""
   SELECT CASE N%
      CASE 0: S$ = STRING$(100, 0): EXIT SUB
      CASE 1: sp$ = sp$ + "          " + " 8      8 " + "  8    8  "
              sp$ = sp$ + "   2222   " + " 22222222 " + "2200220022"
              sp$ = sp$ + "2222222222" + " 22200222 " + "   2222   "
              sp$ = sp$ + " 222  222 "
      CASE 2: sp$ = sp$ + "          " + "  22252   " + " 22222222 "
              sp$ = sp$ + " 2222  9  " + " 2222     " + "  22222   "
              sp$ = sp$ + "2   22222 " + "22    2222" + " 22222222 "
              sp$ = sp$ + "  222222  "
      CASE 3: sp$ = sp$ + "          " + " 9 9  9 9 " + "  955559  "
              sp$ = sp$ + "9 555555 9" + " 95855859 " + "9 555555 9"
              sp$ = sp$ + " 95888859 " + "   5555   " + "   5  5   "
              sp$ = sp$ + "  55  55  "
      CASE 4: sp$ = sp$ + "          " + "    66    " + "   666    "
              sp$ = sp$ + "   6666   " + "  60606   " + "  666666  "
              sp$ = sp$ + " 6999996  " + " 66666666 " + "   8  8   "
              sp$ = sp$ + "  88  88  "
      CASE 5: sp$ = sp$ + "          " + "   6666   " + "  617716  "
              sp$ = sp$ + "  777777  " + "   7447   " + "5555555555"
              sp$ = sp$ + "5  5555  5" + "   5555   " + "  55  55  "
              sp$ = sp$ + "555    555"
   END SELECT: spritecolors sp$: S$ = sp$
END SUB

SUB playerdata (S$, N%)
   sp$ = ""
   SELECT CASE N%
      CASE 0: sp$ = sp$ + "          " + "   4444   " + "  433334  "
              sp$ = sp$ + "  433334  " + "  444444  " + "985888858 "
              sp$ = sp$ + "9 555555 7" + "   8888   " + "   8  8   "
              sp$ = sp$ + "  88  88  "
      CASE 1: sp$ = sp$ + "          " + "   4444   " + "  444444  "
              sp$ = sp$ + "  444444  " + "  588885  " + "985588558 "
              sp$ = sp$ + "9 585585 7" + "   8888   " + "   8  8   "
              sp$ = sp$ + "  88  88  "
      CASE 2: sp$ = sp$ + "77        " + "8  4444   " + "8 444444 7"
              sp$ = sp$ + "8 444444 8" + "8858888588" + "  558855  "
              sp$ = sp$ + "  585585  " + "   888888 " + "   8    88"
              sp$ = sp$ + "  88      "
      CASE 3: sp$ = sp$ + "          " + "   4444   " + "7 444444  "
              sp$ = sp$ + "8 444444  " + "8 588885 7" + "8855885588"
              sp$ = sp$ + "  585585  " + "  888888  " + "88     8  "
              sp$ = sp$ + "        88"
      CASE 4: sp$ = sp$ + "        77" + "   4444  8" + "  444444 8"
              sp$ = sp$ + "7 444444 8" + "8 588885 8" + "8855885588"
              sp$ = sp$ + "  585585  " + " 888888   " + "88   8    "
              sp$ = sp$ + "     88   "
      CASE 5: sp$ = sp$ + "          " + "    4444  " + "   44443  "
              sp$ = sp$ + "   44443  " + "   5885   " + "   888859 "
              sp$ = sp$ + "   5558899" + "   8888   " + "888    8  "
              sp$ = sp$ + "8       88"
      CASE 6: sp$ = sp$ + "          " + "    4444  " + "   44443  "
              sp$ = sp$ + "   44443  " + "   5885   " + "   888859 "
              sp$ = sp$ + "   5558899" + "888888888 " + "8       88"
              sp$ = sp$ + "          "
      CASE 7: sp$ = sp$ + "          " + "    4444  " + "   44443  "
              sp$ = sp$ + "   44443  " + "   5885   " + "   888859 "
              sp$ = sp$ + "   5558899" + "    8888  " + "    8  8  "
              sp$ = sp$ + "    88 88 "
      CASE 8: sp$ = sp$ + "          " + "  4444    " + "  34444   "
              sp$ = sp$ + "  34444   " + "   5885   " + " 958888   "
              sp$ = sp$ + "9988555   " + "   8888   " + "  8    888"
              sp$ = sp$ + "88       8"
      CASE 9: sp$ = sp$ + "          " + "  4444    " + "  34444   "
              sp$ = sp$ + "  34444   " + "   5885   " + " 958888   "
              sp$ = sp$ + "9988555   " + " 888888888" + "88       8"
              sp$ = sp$ + "          "
     CASE 10: sp$ = sp$ + "          " + "  4444    " + "  34444   "
              sp$ = sp$ + "  34444   " + "   5885   " + " 958888   "
              sp$ = sp$ + "9988555   " + "   8888   " + "   8  8   "
              sp$ = sp$ + "  88 88   "
     CASE 11: sp$ = sp$ + "          " + "    4444  " + "   44443  "
              sp$ = sp$ + "   44443  " + "   5885   " + "   888859 "
              sp$ = sp$ + "   5558899" + "   8888   " + "    88    "
              sp$ = sp$ + "    888   "
     CASE 12: sp$ = sp$ + "          " + "  4444    " + "  34444   "
              sp$ = sp$ + "  34444   " + "   5885   " + " 958888   "
              sp$ = sp$ + "9988555   " + "    88    " + "    88    "
              sp$ = sp$ + "   888    "
     CASE 13: sp$ = sp$ + "          " + "    4444  " + "   44443  "
              sp$ = sp$ + "   44443  " + "   5885  7" + "8888888888"
              sp$ = sp$ + "7  5558   " + "   888888 " + " 8888   88"
              sp$ = sp$ + " 8        "
     CASE 14: sp$ = sp$ + "          " + "  4444    " + "  34444   "
              sp$ = sp$ + "  34444   " + "7  5885   " + "8888888888"
              sp$ = sp$ + "   8555  7" + " 888888   " + "88   8888 "
              sp$ = sp$ + "        8 "
     CASE 15: sp$ = sp$ + "        8 " + "       9 8" + "      4  9"
              sp$ = sp$ + "    8   9 " + "   9 4 4  " + "  4  9 98 "
              sp$ = sp$ + "9   4 4 8 " + "   98  8 4" + "      9  8"
              sp$ = sp$ + "        9 "
     CASE 16: sp$ = sp$ + "          " + "       9  " + "     9  4 "
              sp$ = sp$ + "   9  4  8" + "  4    8  " + " 9  4 8  8"
              sp$ = sp$ + "   9  4 8 " + "     9  4 " + "       9  "
              sp$ = sp$ + "          "
     CASE 17: sp$ = sp$ + " 8        " + "8 9       " + "9  4      "
              sp$ = sp$ + " 9   8    " + "  4 4  9  " + " 89 9  4  "
              sp$ = sp$ + " 8 4 4   9" + "4 8  89   " + "8  9      "
              sp$ = sp$ + " 9        "
     CASE 18: sp$ = sp$ + "          " + "  9       " + " 4  9     "
              sp$ = sp$ + "8  4  9   " + "  8    4  " + " 8  8 4  9"
              sp$ = sp$ + "8  4  9   " + " 4  9     " + "  9       "
              sp$ = sp$ + "          "
   END SELECT: spritecolors sp$: S$ = sp$
END SUB

SUB prizedata (S$, N%)
   sp$ = ""
   SELECT CASE N%
      CASE 0: S$ = STRING$(100, 0): EXIT SUB
      CASE 1: sp$ = sp$ + "          " + "          " + "          "
              sp$ = sp$ + "          " + " 444  444 " + "4444444444"
              sp$ = sp$ + "4444444444" + " 44444444 " + "   4444   "
              sp$ = sp$ + "    44    "
      CASE 2: sp$ = sp$ + "          " + "   8888   " + "    88    "
              sp$ = sp$ + "88  88  88" + " 88888888 " + "88  88  88"
              sp$ = sp$ + "    88    " + "    88    " + "   8888   "
              sp$ = sp$ + "    88    "
      CASE 3: sp$ = sp$ + "          " + "   2222   " + "    22    "
              sp$ = sp$ + "   2222   " + "   2222   " + "  222222  "
              sp$ = sp$ + "2222222222" + "2222222222" + " 22222222 "
              sp$ = sp$ + "   2222   "
      CASE 4: sp$ = sp$ + "          " + "    11    " + "   1111   "
              sp$ = sp$ + "  111111  " + " 11111111 " + "  111111  "
              sp$ = sp$ + "   1111   " + "    11    " + "          "
              sp$ = sp$ + "          "
      CASE 5: sp$ = sp$ + "          " + "          " + "   8888   "
              sp$ = sp$ + " 88788788 " + "8788888788" + "8788888878"
              sp$ = sp$ + "8878888788" + " 88788788 " + "   8888   "
              sp$ = sp$ + "          "
   END SELECT: spritecolors sp$: S$ = sp$
END SUB

SUB qbblitsprite (S AS spritedata)
   SC& = &HA000: SG& = VARSEG(S.sprite): Of& = VARPTR(S.sprite)
   BG& = VARSEG(S.buffer): BF& = VARPTR(S.buffer)
   wide& = S.y + S.w - 1: high& = S.x + S.h - 1: sp& = 0
   FOR x& = S.x TO high&
      IF (x& > -1) AND (x& < 200) THEN
         vert& = x& * 320: FOR y& = S.y TO wide&
            IF (y& > -1) AND (y& < 320) THEN
               DEF SEG = SG&: sd% = PEEK(Of& + sp&)
               DEF SEG = SC&: bd% = PEEK(BO& + vert& + y&)
               IF sd% <> 0 THEN POKE vert& + y&, sd%
               DEF SEG = BG&: POKE (BF& + sp&), bd%
            END IF: sp& = sp& + 1: NEXT
      ELSE : sp& = sp& + S.w
      END IF: NEXT: DEF SEG
END SUB

SUB qbgetsprite (S AS spritedata)
   SC& = &HA000: SG& = VARSEG(S.sprite): Of& = VARPTR(S.sprite)
   wide& = S.y + S.w - 1: high& = S.x + S.h - 1: sp& = 0
   FOR x& = S.x TO high&
      IF (x& > -1) AND (x& < 200) THEN
         vert& = x& * 320: FOR y& = S.y TO wide&
            IF (y& > -1) AND (y& < 320) THEN
               DEF SEG = SC&: sd% = PEEK(vert& + y&)
               DEF SEG = SG&: POKE Of& + sp&, sd%
            END IF: sp& = sp& + 1: NEXT
      ELSE : sp& = sp& + S.w
      END IF: NEXT: DEF SEG
END SUB

SUB qbputsprite (S AS spritedata)
   SC& = &HA000: SG& = VARSEG(S.sprite): Of& = VARPTR(S.sprite)
   wide& = S.y + S.w - 1: high& = S.x + S.h - 1: sp& = 0
   FOR x& = S.x TO high&
      IF (x& > -1) AND (x& < 200) THEN
         vert& = x& * 320: FOR y& = S.y TO wide&
            IF (y& > -1) AND (y& < 320) THEN
               DEF SEG = SG&: sd% = PEEK(Of& + sp&)
               DEF SEG = SC&: POKE vert& + y&, sd%
            END IF: sp& = sp& + 1: NEXT
      ELSE : sp& = sp& + S.w
      END IF: NEXT: DEF SEG
END SUB

SUB showlevel (L%)
   DIM SC(7) AS STRING * 100, b AS spritedata
   FOR t% = 0 TO 6: backgrounddata SC(t%), t%: NEXT
   b.w = 10: b.h = 10: levelsdata levdat, L%
   FOR t% = 0 TO 639: b.y = (t% MOD 32) * 10: b.x = (t% \ 32) * 10
      b.sprite = SC(ASC(MID$(levdat, t% + 1))): qbputsprite b: NEXT
   GET (0, 0)-(319, 199), background
END SUB

SUB spritecolors (S$)
   REDIM SC(1 TO 11) AS INTEGER: SC(1) = 0: SC(2) = 177: sp$ = ""
   SC(3) = 9: SC(4) = 10: SC(5) = 11: SC(6) = 4: SC(7) = 5
   SC(8) = 6: SC(9) = 89: SC(10) = 14: SC(11) = 15: L% = LEN(S$)
   FOR t% = 1 TO L%
      MID$(S$, t%, 1) = CHR$(SC(INSTR(" 0123456789", MID$(S$, t%, 1))))
   NEXT: ERASE SC
END SUB

