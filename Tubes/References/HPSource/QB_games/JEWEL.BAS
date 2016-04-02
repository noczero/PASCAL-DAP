'********************************************************
'* WARNING: CODE BELOW CONTAINS VERY ADDICTIVE GAME PLAY
'********************************************************
'*  JEWEL (ASCII Version) - Like Columns for Sega(tm)
'*   100% Public Domain - all rights relinquished
'*   Colour/Monochrome compatible!
'*
'*  This version has been 95% ported from Turbo Pascal
'*    code to BASIC by William Yu  (10-20-96)
'*  Minor alterations/optimization routines have been
'*    implemented.  Game has been ported AS IS.
'*    Not responsible for misinterpreted translation.
'*
'*  Original code for XWindows - Author Unknown
'*  Original code for TP - Jurgen Prins (???)
'*
'*  Turbo Pascal code can be found at (as of 10/96):
'*    http://www.cs.vu.nl/~jprins/ftp/src/jewel.zip
'*
'* Instructions for gameplay (as written):
'*
'*  Try to get three same colors in an horizontal,
'*  vertical or diagonal row. Switch colors with Up,
'*  move with Left & Right, force placement
'*  with Down. P is pause, Esc is quit.
'*
'* Notice: (as discovered)
'*
'*  The "clear all" jewel will clear all jews of
'*  ONE colour.  So if the "clear all" jewel lands
'*  on the colour red, it would clear all red jewels.
'*      
'********************************************************
DEFINT A-Z
DECLARE FUNCTION RandomColor% ()
DECLARE SUB InitField ()
DECLARE SUB InitVars ()
DECLARE SUB InitScreen ()
DECLARE SUB RefreshScreen ()
DECLARE FUNCTION GenerateNewBlock% ()
DECLARE FUNCTION MoveBlockDown% (col%, startRow%, endRow%, checkflag%)
DECLARE SUB SwapBlockColors ()
DECLARE SUB ForceBlockDown ()
DECLARE SUB MoveBlockLeft ()
DECLARE SUB MoveBlockRight ()
DECLARE SUB GetKeyboardEvent ()
DECLARE FUNCTION MatchesFound% ()
DECLARE SUB WriteLives ()
DECLARE SUB WriteScore ()

SCREEN 0, 0, 0, 0

CONST JewelChr = ""
CONST JewelChance = 20       ' Chance of receiving the "clear all" jewel
CONST MatchBackGround = 0
CONST MatchForeGround = 31
CONST False = 0
CONST True = NOT False
CONST Mono = False           ' <--- Playable even with monochrome display!
                             ' Change to TRUE if you don't have color.
CONST BigScreen = True       ' For WIDTH 40, 25 or for graphics mode

DIM SHARED Well(0 TO 31, 0 TO 22) AS INTEGER

DIM SHARED Colors, Rows, Cols, LeftX, RightX, TopY, BotY
DIM SHARED BlockCol, BlockEndRow, SpeedDelay!, Lives, Level
DIM SHARED IncreaseSpeed!, ScoreObtained
DIM SHARED AchievedScore AS LONG
DIM SHARED Score AS LONG
DIM SHARED Pause, Escape

'********************************
'   Initialize variables
'********************************

    IF BigScreen THEN WIDTH 40, 25

    SpeedDelay! = .5       ' Delay in seconds
    IncreaseSpeed! = .025  ' Increase speed for each ScoreObtained
    ScoreObtained = 2500   ' Speed increases with every 2500 points obtained
    AchievedScore = ScoreObtained

    Level = 100       ' Levels have not been implemented, this affects score
    Cols = 6          ' Max of 30 depending on WIDTH
    Rows = 20         ' Max of 22
    Colors = 5        ' Number of color gems used, Max of 10
    Score = 0         ' Starting score
    Lives = 3         ' How many lives remaining

'*********************************

    InitScreen
    WHILE (Lives > 0)
        InitField
        WriteLives
        RefreshScreen
        WHILE (GenerateNewBlock) AND (NOT Escape)
            RefreshScreen
            WHILE MoveBlockDown(BlockCol, BlockEndRow - 2, BlockEndRow, True) AND (NOT Escape)
                BlockEndRow = BlockEndRow + 1
                RefreshScreen
                T! = TIMER
                DO
                    GetKeyboardEvent
                LOOP UNTIL TIMER - T! >= SpeedDelay! AND (NOT Pause)
            WEND
            DO
            LOOP UNTIL NOT MatchesFound
        WEND
        Lives = Lives - 1
        SpeedDelay! = .5
    WEND
    WriteScore

END

SUB ForceBlockDown

    WHILE MoveBlockDown(BlockCol, BlockEndRow - 2, BlockEndRow, True)
        BlockEndRow = BlockEndRow + 1
    WEND

END SUB

FUNCTION GenerateNewBlock

    RANDOMIZE TIMER
    midCol = (Cols / 2) + 1
    IF Well(midCol, 3) <> 0 THEN
      GenerateNewBlock = False
    ELSE
        IF INT(RND * JewelChance) = 0 THEN
            FOR I = 1 TO 3
              Well(midCol, I) = 24
            NEXT I
        ELSE
            FOR I = 1 TO 3
              Well(midCol, I) = RandomColor
            NEXT I
        END IF
        GenerateNewBlock = True
    END IF
    BlockCol = midCol
    BlockEndRow = 3

END FUNCTION

SUB GetKeyboardEvent

  Ch$ = INKEY$
  IF LEN(Ch$) THEN
      IF LEN(Ch$) = 2 THEN Ch = -(ASC(RIGHT$(Ch$, 1))) ELSE Ch = ASC(UCASE$(Ch$))
      SELECT CASE Ch
        CASE -72
          SwapBlockColors
          RefreshScreen
        CASE -80
          ForceBlockDown
          RefreshScreen
        CASE -75
          MoveBlockLeft
          RefreshScreen
        CASE -77
          MoveBlockRight
          RefreshScreen
        CASE 27
          Escape = True
        CASE 80
          Pause = NOT Pause
      END SELECT
  END IF

END SUB

SUB InitField

    FOR row = 1 TO Rows
        FOR col = 1 TO Cols
            Well(col, row) = 0
        NEXT col
    NEXT row

END SUB

SUB InitScreen

    COLOR 6
    IF BigScreen THEN MidPoint = 20 ELSE MidPoint = 40

    TopY = ((25 - Rows) / 2)
    BotY = TopY + Rows - 1
    LeftX = MidPoint - Cols
    RightX = MidPoint - 1 + Cols

    LOCATE TopY - 1, LeftX
    PRINT STRING$(Cols * 2 + 1, CHR$(196));

    LOCATE BotY + 1, LeftX
    PRINT STRING$(Cols * 2 + 1, CHR$(196));
   
    FOR y = TopY - 1 TO BotY + 1
        LOCATE y, LeftX - 1
        PRINT CHR$(179);
        LOCATE y, RightX + 1
        PRINT CHR$(179);
    NEXT y
    LOCATE TopY - 1, MidPoint - 1 - Cols
    PRINT CHR$(218);
    LOCATE TopY - 1, MidPoint + Cols
    PRINT CHR$(191);
    LOCATE BotY + 1, MidPoint - 1 - Cols
    PRINT CHR$(192);
    LOCATE BotY + 1, MidPoint + Cols
    PRINT CHR$(217);

END SUB

SUB InitVars

' Moved to main program

END SUB

FUNCTION MatchesFound

DIM MatchField(0 TO 31, 0 TO 22)  AS INTEGER

    Found = False

    '(* initialize the Matchfield *)
    FOR J = 1 TO Rows
        FOR I = 1 TO Cols
            MatchField(I, J) = MatchBackGround
        NEXT I
    NEXT J

    IF Well(BlockCol, BlockEndRow) = 24 THEN  '(* we have a jewel here! *)
        IF BlockEndRow < Rows THEN
            Colour = Well(BlockCol, BlockEndRow + 1)
            FOR J = 1 TO Rows
                FOR I = 1 TO Cols
                    IF (Well(I, J) = Colour) OR (Well(I, J) = 24) THEN MatchField(I, J) = MatchForeGround
                NEXT I
            NEXT J
        ELSE
            FOR BlockRow = BlockEndRow TO BlockEndRow - 2 STEP -1
                MatchField(BlockCol, BlockRow) = MatchForeGround
            NEXT BlockRow
        END IF
        Found = True
    ELSE
        FOR BlockRow = BlockEndRow TO BlockEndRow - 2 STEP -1
            Colour = Well(BlockCol, BlockRow)

            '(* Look for vertical matches, first downwards, then upwards *)
            J = BlockRow + 1
            WHILE ((J <= Rows) AND (Well(BlockCol, J) = Colour))
                J = J + 1
            WEND
            J = J - 1
            Endmatch = J
            WHILE ((J >= 1) AND (Well(BlockCol, J) = Colour))
                J = J - 1
            WEND
            Startmatch = J + 1
            IF (Endmatch - Startmatch > 1) AND (Colour <> 0) THEN
                FOR J = Startmatch TO Endmatch
                    MatchField(BlockCol, J) = MatchForeGround
                NEXT J
                Found = True
            END IF

            '(* Look for horizontal matches, first rightwards, then to the left*)
            I = BlockCol + 1
            WHILE ((I <= Cols) AND (Well(I, BlockRow) = Colour))
                I = I + 1
            WEND
            I = I - 1
            Endmatch = I
            WHILE ((I >= 1) AND (Well(I, BlockRow) = Colour))
                I = I - 1
            WEND
            Startmatch = I + 1
            IF (Endmatch - Startmatch > 1) AND (Colour <> 0) THEN
                FOR I = Startmatch TO Endmatch
                    MatchField(I, BlockRow) = MatchForeGround
                NEXT I
                Found = True
            END IF

            '(* look for diagonal matches, first rightdownwards, then leftup *)
            J = BlockRow + 1
                I = BlockCol + 1
            WHILE ((J <= Rows) AND (I <= Cols) AND (Well(I, J) = Colour))
                I = I + 1
                J = J + 1
            WEND
            I = I - 1
            J = J - 1
            Endmatch = I
            WHILE ((J >= 1) AND (I >= 1) AND (Well(I, J) = Colour))
                I = I - 1
                J = J - 1
            WEND
                Startmatch = I + 1
            IF (Endmatch - Startmatch > 1) AND (Colour <> 0) THEN
                FOR I = Startmatch TO Endmatch
                    MatchField(I, I - (BlockCol - BlockRow)) = MatchForeGround
                NEXT I
                Found = True
            END IF

            '(* look for diagonal matches, first leftdownwards, then rightup *)
            J = BlockRow + 1
            I = BlockCol - 1
            WHILE ((J <= Rows) AND (I >= 1) AND (Well(I, J) = Colour))
                I = I - 1
                J = J + 1
            WEND
            I = I + 1
            J = J - 1
            Endmatch = I
            WHILE ((J >= 1) AND (I <= Cols) AND (Well(I, J) = Colour))
                I = I + 1
                J = J - 1
            WEND
            Startmatch = I - 1
            IF (Startmatch - Endmatch > 1) AND (Colour <> 0) THEN
                FOR I = Startmatch TO Endmatch STEP -1
                    MatchField(I, (BlockCol + BlockRow) - I) = MatchForeGround
                NEXT I
                Found = True
            END IF
        NEXT BlockRow

    END IF

    '(* handle the first row (there are no blocks above to move down) *)
    FOR I = 1 TO Cols
        IF MatchField(I, 1) = MatchForeGround THEN Well(I, 1) = 0
    NEXT I

    '(* scan Matchfield and move at each encounter upper blocks down *)
    FOR J = 2 TO Rows
        FOR I = 1 TO Cols
            IF MatchField(I, J) = MatchForeGround THEN
                MV = MoveBlockDown(I, 1, J - 1, False)
                'ForceBlockDown
                IF (I = BlockCol) AND (BlockEndRow < Rows) THEN BlockEndRow = BlockEndRow + 1
                RefreshScreen
                Score = Score + (10000 / Level)
                IF (Score > AchievedScore) THEN
                  AchievedScore = AchievedScore + ScoreObtained
                  IF (SpeedDelay! > .1) THEN SpeedDelay! = SpeedDelay! - IncreaseSpeed!
                END IF
            END IF
        NEXT I
    NEXT J

    MatchesFound = Found

END FUNCTION

FUNCTION MoveBlockDown (col, startRow, endRow, checkflag)
   
    IF endRow = Rows THEN
        MoveBlockDown = False
    ELSE
        IF checkflag AND (Well(col, endRow + 1) <> 0) THEN
            MoveBlockDown = False
        ELSE
            FOR I = endRow + 1 TO startRow + 1 STEP -1
                Well(col, I) = Well(col, I - 1)
            NEXT I
            Well(col, startRow) = 0
            MoveBlockDown = True
        END IF
    END IF

END FUNCTION

SUB MoveBlockLeft

    IF BlockCol > 1 THEN
        IF (Well(BlockCol - 1, BlockEndRow) = 0) AND (Well(BlockCol - 1, BlockEndRow - 1) = 0) AND (Well(BlockCol - 1, BlockEndRow - 2) = 0) THEN
            BlockCol = BlockCol - 1
            FOR I = BlockEndRow - 2 TO BlockEndRow
                Well(BlockCol, I) = Well(BlockCol + 1, I)
                Well(BlockCol + 1, I) = 0
            NEXT I
        END IF
    END IF

END SUB

SUB MoveBlockRight

    IF BlockCol < Cols THEN
        IF (Well(BlockCol + 1, BlockEndRow) = 0) AND (Well(BlockCol + 1, BlockEndRow - 1) = 0) AND (Well(BlockCol + 1, BlockEndRow - 2) = 0) THEN
            BlockCol = BlockCol + 1
            FOR I = BlockEndRow - 2 TO BlockEndRow
                Well(BlockCol, I) = Well(BlockCol - 1, I)
                Well(BlockCol - 1, I) = 0
            NEXT I
        END IF
    END IF

END SUB

FUNCTION RandomColor

    RANDOMIZE TIMER
    SELECT CASE INT(RND * Colors)
        CASE 0
          RandomColor = 1
        CASE 1
          RandomColor = 2
        CASE 2
          RandomColor = 4
        CASE 3
          RandomColor = 7
        CASE 4
          RandomColor = 14
        CASE 5
          RandomColor = 11
        CASE 6
          RandomColor = 13
        CASE 7
          RandomColor = 9
        CASE 8
          RandomColor = 12
        CASE 9
          RandomColor = 15
    END SELECT

END FUNCTION

SUB RefreshScreen

    row = 1
    col = 1
    x = LeftX
    y = TopY
    WHILE (y <= BotY)
        WHILE (x < RightX)
            LOCATE y, x
            IF NOT Mono THEN
              COLOR Well(col, row)
              PRINT JewelChr;
            ELSE
              IF Well(col, row) = 0 THEN
                PRINT "  "
              ELSE
                  PRINT CHR$(Well(col, row) + 64);
              END IF
            END IF
            x = x + 2
            col = col + 1
        WEND
        y = y + 1
        row = row + 1
        x = LeftX
        col = 1
    WEND
    COLOR 5
    LOCATE TopY - 1, LeftX + 1
    PRINT Score;

END SUB

SUB SwapBlockColors

    I = Well(BlockCol, BlockEndRow - 2)
    Well(BlockCol, BlockEndRow - 2) = Well(BlockCol, BlockEndRow - 1)
    Well(BlockCol, BlockEndRow - 1) = Well(BlockCol, BlockEndRow)
    Well(BlockCol, BlockEndRow) = I

END SUB

SUB WriteLives

    COLOR 5
    LOCATE TopY - 1, RightX - 1
    PRINT Lives;

END SUB

SUB WriteScore

    WIDTH 80
    COLOR 7
    PRINT "Jewel for DOS - Converted from Pascal code to BASIC by William Yu (10/96)"
    COLOR 2
    PRINT "Total score : "; Score
    COLOR 7
    PRINT

END SUB

