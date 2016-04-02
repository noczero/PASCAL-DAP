' PIPELINE.BAS  a game for personal computers with Colour Graphics Adaptor
'               or better.
'
'   Author:     Christy Gemmell
'   Version:    3.10
'   Date:       15/12/1990
'
'   Compile:    BC /O pipeline;
'   Link:       LINK pipeline,,, qb.lib;
'   IDE:        QB pipeline.bas /L qb.qlb
'   QBasic:     QBasic pipeline.bas 
'
'   Converted from Borland TurboBASIC for use with Microsoft QuickBASIC.
'   Adapted and embellished from the original TRS-80 Colour Computer program
'   by Martin Montes and the author.
'
'   $DYNAMIC
'
    DECLARE SUB ABSOLUTE (Ticks AS INTEGER, Address AS INTEGER)

    DECLARE SUB Centre (Row%, Text$)
    DECLARE SUB Continue ()
    DECLARE SUB Move (DX%, DY%)
    DECLARE SUB Pause (Ticks%)

    DIM SHARED MCode(1 TO 20) AS INTEGER
    DEF SEG = VARSEG(MCode(1))
    OffSet% = VARPTR(MCode(1))
    RESTORE Code
    FOR I% = 0 TO 39
        READ Byte%
        POKE OffSet% + I%, Byte%
    NEXT I%
    DEF SEG

    SCREEN 0: WIDTH 40: COLOR 15, 1: CLS
    LOCATE , , 0: KEY OFF: RANDOMIZE TIMER
    DIM SHARED E$(4), X0%(10), Y0%(10), HX%(30), HY%(30)
    K% = 1: L% = 3: PLAY "t240o3l8d#fgl8b-p8l8gl2b-": PLAY "mb":
    PLAY "l8t255o3bo4cdo3bo4co3abgaf#t120gbt200dp8t255o4cdecdo3bo4co3abg"
    PLAY "t120f#at200dp8t255ef#gdef#gef#g#aef#g#ag#abo4co3bo4cdeco3af#gd"
    PLAY "gbt120g": LOCATE 2, 8: PRINT "Silly Software Presents ..";
    LOCATE 10, 11: PRINT "+-----------------+";
    LOCATE 11, 11: PRINT "| P I P E L I N E |";
    LOCATE 12, 11: PRINT "+-----------------+";
    LOCATE 23, 11: PRINT "By Christy Gemmell";
    WHILE PLAY(1): WEND: PLAY "mf": COLOR 15, 0: CLS
    FOR J% = 15 TO 1 STEP -1
        FOR I% = 1 TO J%
            LOCATE L%, 9: PRINT STRING$(25, 32);
            L% = L% + K%: COLOR I%
            LOCATE L%, 9: PRINT "Do you need Instructions?";
            Pause 1
        NEXT I%
        K% = -K%
    NEXT J%

    PLAY "l64t140o3deg#f#ggc#d#edc#ccaa#g#fc#"
    DO
       COLOR 3: LOCATE 14, 18, 1
       PRINT "> "; : A$ = UCASE$(INPUT$(1))
    LOOP UNTIL A$ = "Y" OR A$ = "N"
 
    IF A$ = "Y" THEN
       WIDTH 80: COLOR 14, 6: CLS : LOCATE , , 0
       LOCATE 1, 31: PRINT "+-----------------+";
       LOCATE 2, 31: PRINT "| P I P E L I N E |";
       LOCATE 3, 31: PRINT "+-----------------+";
       LOCATE 4, 1: PRINT STRING$(80, "-"); 
       RESTORE Text
       COLOR 30: LOCATE 2, 33: PRINT "P I P E L I N E";
       COLOR 0, 3: FOR R% = 5 TO 24: LOCATE R%, 2: PRINT SPACE$(78); : NEXT
       FOR R% = 6 TO 20: READ Q$: Centre R%, Q$: NEXT: Continue
       FOR R% = 5 TO 24: LOCATE R%, 2: PRINT SPACE$(78); : NEXT
       FOR R% = 6 TO 21: READ Q$: Centre R%, Q$: NEXT: Continue
    END IF

    LOCATE , , 0
    DEF fnA% (A%) = INT((RND * A%)) * 16
    DEF fnB% (B%) = INT((RND * B%)) * 8
    E$(0) = "c2l16c0u0bu1br4r8bd2l8": E$(1) = "c2u8c0u0br2bd2d4bl4u4"
    E$(3) = "c2d8c0u0br2bu2u4bl4d4": E$(4) = "c2r16c0u0bu1bl4l8bd2r8"
    S$ = "bu2r4d4l8u4r4bd2": En$ = "bu2g2f2e2h2bd1"
    UA$ = CHR$(0) + CHR$(72): LA$ = CHR$(0) + CHR$(75)
    RA$ = CHR$(0) + CHR$(77): DA$ = CHR$(0) + CHR$(80)

    DO
        SCREEN 1: Level% = 1: Pts% = 0
        LOCATE 2, 35: PRINT "Level"; : LOCATE 4, 37: PRINT "  1";
        LOCATE 7, 35: PRINT "Score"; : LOCATE 9, 37: PRINT "  0";
        LOCATE 12, 36: PRINT "Time"; : LOCATE 14, 37: PRINT "100";
        DO
            X% = fnA%(15) + 15: Y% = fnB%(22) + 9: HX%(0) = X%: HY%(0) = Y%
            Time! = 100: LINE (2, 3)-(254, 182), 3, BF
            Ep% = 5 + INT(RND * 4) + 1
            LINE (2, 3)-(254, 182), 2, B: LINE (0, 183)-(319, 199), 0, BF
            FOR I% = 1 TO Ep%
               X0%(I%) = fnA%(14) + 23: Y0%(I%) = fnB%(21) + 5
            NEXT I%
            R$ = S$ + "br16": L$ = S$ + "bl16"
            U$ = S$ + " bu8": D$ = S$ + " bd8"
            R0$ = "br16;": FOR I% = 1 TO 14: R0$ = R0$ + R$: NEXT
            L0$ = "bl16;": FOR I% = 1 TO 13: L0$ = L0$ + L$: NEXT
            D0$ = " bd8;": FOR I% = 1 TO 20: D0$ = D0$ + D$: NEXT
            U0$ = " bu8;": FOR I% = 1 TO 19: U0$ = U0$ + U$: NEXT
            I% = 14: DRAW "c0bm15,9" + MID$(R0$, 5) + "x" + VARPTR$(S$)
            PLAY "l64o2t255egfd#d#c"
            DO
                PLAY "ccc#gc#"
                DRAW LEFT$(D0$, (I% + 7) * 20 + 1) + "x" + VARPTR$(S$)
                PLAY "dad#": IF I% = 0 THEN EXIT DO
                DRAW LEFT$(L0$, I% * 20 + 1) + "x" + VARPTR$(S$)
                PLAY "ebf"
                DRAW LEFT$(U0$, (I% + 6) * 20 + 1) + "x" + VARPTR$(S$)
                PLAY "f#o3d#o2g#"
                DRAW LEFT$(R0$, (I% - 1) * 20 + 1) + "x" + VARPTR$(S$)
                I% = I% - 2
            LOOP WHILE 1
            FOR I% = 0 TO Level%
                IF I% THEN
                   HX%(I%) = fnA%(15) + 15: HY%(I%) = fnB%(22) + 9
                END IF
                PLAY "l60o1abeo5fda"
                Place$ = "bm" + STR$(HX%(I%)) + "," + STR$(HY%(I%))
                DRAW "x" + VARPTR$(Place$) + "c2s6x" + VARPTR$(S$)
            NEXT I%
            DRAW "s4": PAINT (X%, Y%), 1, 0: PLAY "o2l61df#eg#a"
            FOR I% = 1 TO Ep%
                Place$ = "bm" + STR$(X0%(I%)) + "," + STR$(Y0%(I%))
                DRAW "c0x" + VARPTR$(Place$) + "x" + VARPTR$(En$)
                Note$ = "n" + STR$(INT(RND * 11) + 1)
                PLAY "o4l58x" + VARPTR$(Note$)
            NEXT I%
            PLAY "l62o4t250dggdg#aao3dggdaa#a#o2dggda#bb"

            DO
                I$ = INKEY$
                SELECT CASE I$
                    CASE UA$
                         Move 0, -1
                    CASE LA$
                         Move -1, 0
                    CASE RA$
                         Move 1, 0
                    CASE DA$
                         Move 0, 1
                    CASE CHR$(32)
                         PLAY "o1l64t255cdgf#c#c#c#d"
                         PAINT (HX%(0), HY%(0) + 1), 1, 0: I% = 1
                         DO WHILE I% <= Level%
                            IF POINT(HX%(I%), HY%(I%) + 1) <> 1 THEN
                               Place$ = "bm" + STR$(HX%(I%)) + "," _
                                      + STR$(HY%(I%))
                               DRAW "x" + VARPTR$(Place$)
                               FOR J% = 1 TO 27 + 2 * Level%
                                   PLAY "o5cdggb": DRAW "c2x" + VARPTR$(S$)
                                   PLAY "o4baffdc": DRAW "c1x" + VARPTR$(S$)
                               NEXT J%
                               Time! = 0: EXIT DO
                            END IF
                            I% = I% + 1
                         LOOP
                         IF I% > Level% THEN
                             FOR I% = 2 TO 4
                                 Octave$ = "o" + STR$(I%)
                                 PLAY "l32x" + VARPTR$(Octave$) + "dfgg#"
                                 PAINT (HX%(0), HY%(0) + 1), 2, 0
                                 PLAY "g#d#fc#c"
                                 PAINT (HX%(0), HY%(0) + 1), 1, 0
                             NEXT I%
                             PLAY "t192l8o1cp32cl4p32cd#l8gp32gap32al4gl2d"
                             Pts% = Pts% + INT(Time!): Level% = Level% + 1
                             LOCATE 4, 36: PRINT USING "####"; Level%;
                             LOCATE 9, 36: PRINT USING "####"; Pts%;
                         END IF
                         EXIT DO
                    CASE ELSE
                END SELECT
                IF INT(RND * 20) + 1 = 1 THEN
                   I% = INT(RND * Ep%) + 1: L% = X0%(I%): M% = Y0%(I%)
                   I$ = "bm" + STR$(L%) + "," + STR$(M%)
                   DRAW "c0x" + VARPTR$(I$) + "x" + VARPTR$(En$)
                   IF (INT(RND * 2) + 1) = 1 THEN
                      J% = SGN(X% - L%): K% = 0
                   ELSE
                      J% = 0: K% = SGN(Y% - M%)
                   END IF
                   Place$ = "m" + STR$(L% + J% * 16) + "," _
                          + STR$(M% + K% * 8)
                   DRAW "x" + VARPTR$(I$) + "c0x" + VARPTR$(Place$) _
                        + "x" + VARPTR$(En$)
                   X0%(I%) = L% + J% * 16: Y0%(I%) = M% + K% * 8
                END IF
                Pause 1: Time! = Time! - .1
                IF Time! >= 0 THEN
                   LOCATE 14, 36: PRINT USING "####"; INT(Time!);
                   Place$ = "bm" + STR$(INT(Time! * 2 + 5)) + ",185"
                   DRAW "c3x" + VARPTR$(Place$) + "r2d2l2u2"
                END IF
            LOOP UNTIL Time! < 0
        LOOP WHILE Time! > 0
        LINE (0, 185)-(320, 200), 0, BF
        LOCATE 24, 12, 1: PRINT "Another Game? > ";
        R$ = UCASE$(INPUT$(1))
    LOOP WHILE R$ = "Y"
    SCREEN 0, 0, 0: WIDTH 80: COLOR 15, 0: CLS
END

'   Centre a string of text within a screen row.
'
SUB Centre (Row%, Text$)
    LOCATE Row%, 40 - (LEN(Text$) \ 2): PRINT Text$;
END SUB

'   Prompt for a response from the user.
'
SUB Continue
    LOCATE , , 1: Centre 23, "Press <ENTER> to continue > "
    DO
       R$ = INPUT$(1)
    LOOP UNTIL R$ = CHR$(13)
    LOCATE , , 0
END SUB

'   Move in response to direction keys.
'
SUB Move (DX%, DY%)
    SHARED X%, Y%, Place$
    X% = X% + DX% * 16: Y% = Y% + DY% * 8
    IF X% < 15 THEN
       X% = 15: BEEP
    ELSEIF X% > 239 THEN
       X% = 239: BEEP
    ELSEIF Y% < 9 THEN
       Y% = 9: BEEP
    ELSEIF Y% > 177 THEN
       Y% = 177: BEEP
    ELSE
       PLAY "o4l63e"
       Place$ = "bm" + STR$(X% - DX% * 16) + "," + STR$(Y% - DY% * 8)
       DRAW "x" + VARPTR$(Place$) + E$(DX% * 2 + DY% + 2)
    END IF
END SUB

'   System-independent time delay
'
SUB Pause (Ticks%)
    DEF SEG = VARSEG(MCode(1))
    OffSet% = VARPTR(MCode(1))
    ABSOLUTE Ticks%, OffSet%
    DEF SEG
END SUB

'       Data Division.
'
Code:

DATA  &H55, &H8B, &HEC, &H51, &H52, &H06, &H8B, &H5E, &H06, &H8B   
DATA  &H0F, &HE3, &H14, &H33, &HC0, &H8E, &HC0, &H26, &HA1, &H6C
DATA  &H04, &H50, &H26, &HA1, &H6C, &H04, &H5A, &H3B, &HC2, &H74
DATA  &HF6, &HE2, &HF4, &H07, &H5A, &H59, &H5D, &HCA, &H02, &H00

Text:

DATA    "Your have been hired as the Chief Civil Engineer of"
DATA    "West Moronia and your job is to ensure that all the"
DATA    "towns and villages are provided with their supplies"
DATA    "of Natural Gas. The problem is that the countryside"
DATA    "is located on a big geological fault and is subject"
DATA    "to frequent earthquakes which fracture the pipeline"
DATA    "carrying the gas supplies.","  "
DATA    "At the beginning of each round, you will be shown a"
DATA    "map of one of your provinces, with it's chief towns"
DATA    "highlighted and the local pumping station filled in"
DATA    "with light blue. You must build a pipe joining this"
DATA    "pumping station to all the 'thirsty cities' of this"
DATA    "particular province, without any break or blockages"
DATA    "caused by earthquake activity."
DATA    "You construct the pipe using the Arrow keys to show"
DATA    "the direction in which you want it to go. Once that"
DATA    "you are confident you have a sound pipeline without"
DATA    "any breaks, hit the <SPACEBAR> to begin the flow of"
DATA    "gas through the system.","  "
DATA    "If a section is blocked due to earthquake activity,"
DATA    "the flow will look for an alternative route. If the"
DATA    "flow does not succeed in reaching all the locations"
DATA    "on the map then an alarm sounds, the 'thirsty city'"
DATA    "blinks and the game ends. If you manage to complete"
DATA    "the pipeline successfully in the time allotted, you"
DATA    "will begin the next round with a new province and a"
DATA    "new set of cities to service. a peculiarity of your"
DATA    "new homeland, incidentally, is that each successive"
DATA    "province has one more city than the last!"

