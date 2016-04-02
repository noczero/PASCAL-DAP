'================[ YA! TETRIS v1.0 Programmed by William Yu ]=================
'
'      Release:  YA! (Yet Another) TETRIS by William Yu (07-23-97)
'       Status:  99% Public Domain, please give credit where due.
'                No warranties or guaranteeds applied.
'                Use within a commercial product is STRICTLY PROHIBITED!
'   Copyrights:  TETRIS is now a property of Alexey Pajitnov's TETRIS Co.
'    Thanks to:  Phillip Jay Cohen for his "Outline Font Routine" (SUB OFONT)
'   Contact me:  E-mail: voxel@freenet.edmonton.ab.ca
'
'     Controls: Keyboard (configurable), check CONSTs
'               Joystick (1), or modify the program to support 2.
'            ** Watch for conflicting keyboard/joystick values if you
'               decide to change the keyboard values.
'               If the joystick doesn't seem to work properly, ESC the game
'               then run it again.  If it still acts up, then change the
'               increment/decrement value (20) to something larger, or
'               smaller.  Try something larger like 30 or 40.
'     Gameplay: If you've never played/seen the game before, wow, you're
'               just one of the very few.  It's a simple game, and for
'               some reason, very addictive.  You must strategically place
'               the "pieces" that fall down, to form complete lines.
'               Sounds easy enough, but as the level increases so does the
'               speed at which the "pieces" fall down.  You can rotate the
'               "pieces" clockwise/counter-clockwise and drop them onto the
'               playing field to form as many lines as possible, until the
'               game tilts, or you have filled the playing field to the
'               very top.  As each line is complete, that line then becomes
'               eliminated from the playing field, and you get points for
'               how many lines you eliminate.
'
'=============================================================================

DECLARE SUB GameOver ()
DECLARE SUB ShowOccurence ()
DECLARE SUB SetupScreen ()
DECLARE SUB ClearKeyBoard ()
DECLARE SUB Pause (Seconds!)
DECLARE SUB PushDown (LineY%)
DECLARE SUB CheckLines (GridY%)
DECLARE SUB CheckFit (NoFit%, Block%, Cycle%, GridX%, GridY%)
DECLARE SUB PutInGrid (Block%, Cycle%, GridX%, GridY%)
DECLARE FUNCTION AtBottom% (Block%, Cycle%, GridX%, GridY%)
DECLARE FUNCTION MoveBlockLeft% (GridX%, GridY%, Block%, Cycle%)
DECLARE FUNCTION MoveBlockRight% (GridX%, GridY%, Block%, Cycle%)
DECLARE SUB PutBlock (X%, Y%, Block%, Cycle%)
DECLARE SUB DrawBlock (X%, Y%, Hue%)
DECLARE SUB GetShapes ()
DECLARE SUB InitVariables ()
DECLARE SUB OFont (Text$, X%, Y%, Fore%, Back%)
DECLARE SUB DefinePalette ()
DECLARE SUB Pal (C%, R%, G%, B%)
DEFINT A-Z
'$DYNAMIC
SCREEN 13

OPTION BASE 1

CONST False = 0
CONST True = NOT False

'------------ USER Defined ------------
CONST UseJoy = False  '' Use joystick (not recommended for slow machines)
CONST Left = -75      '' Left Arrow
CONST Right = -77     '' Right Arrow
CONST Rotate = -72    '' Up Arrow
CONST OppRotate = 13  '' Enter key: Counter-clockwise
CONST Drop = 32       '' Space
CONST DropSlow = -80  '' Down Arrow
CONST GridWidth = 10
CONST GridHeight = 20
CONST BlockWidth = 11
CONST BlockHeight = 9
CONST NextLevel = 25
CONST StdScore = 50   '' Standard Score/line
CONST LevelX = 5      '' Add to Standard Score
CONST ScoreX = 0      '' Bonus Score/line
CONST Score2X = 25
CONST Score3X = 50
CONST Score4X = 100   '' Bonus Score/Tetris (4 lines)
CONST Decr! = .05     '' Decrease delay by this decrement
'--------------------------------------

CONST Array = 4 * BlockWidth * BlockHeight + 2

DIM SHARED Piece(7, 8) AS INTEGER
DIM SHARED Occur(7) AS INTEGER
DIM SHARED Grid(0 TO GridWidth, 0 TO GridHeight) AS INTEGER
DIM SHARED Colour(3 * 8) AS INTEGER
DIM SHARED Shape(7 * 4 * Array) AS INTEGER
'DIM SHARED GridX, GridY, Block,Cycle
DIM SHARED StartX, StartY, EndY, EndX, NumLines, Score&, LinesLeft, Level!, Delay!, NumBlocks&

StartX = 2 * GridWidth
StartY = 10
EndX = StartX + BlockWidth * GridWidth + 1
EndY = StartY + BlockHeight * GridHeight

InitVariables

IF UseJoy THEN
  JoyStickX = STICK(0)
  JoyStickY = STICK(1)
  Free = True
END IF

RANDOMIZE TIMER
NumLines = 0
NumBlocks& = 1
LinesLeft = NextLevel
Level! = 0
GridX = 4
GridY = 1
Cycle = 1
Block = INT(RND * 7) + 1
Occur(Block) = Occur(Block) + 1
InitDrop = False
NextBlock = INT(RND * 7) + 1

SetupScreen  '' Draw gameplay screen

PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
ShapeArray = (NextBlock - 1) * 4 * Array + 1
PUT (EndX + 20 + BlockWidth, 30 + BlockHeight), Shape(ShapeArray), PSET

Delay! = .9 - (Level! * Decr!)
IF Delay! < .02 THEN Delay! = .018
T! = TIMER
DO
  DO
    A$ = INKEY$
    IF InitDrop THEN
      A$ = ""
      PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
      GOSUB DropBlock
      PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
    ELSEIF TIMER - T! >= Delay! THEN
      T! = TIMER
      PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
      GOSUB DropBlock
      PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
    END IF
    IF UseJoy THEN
      IF STICK(1) > JoyStickY + 20 THEN A$ = CHR$(0) + "P"
      SELECT CASE STICK(0)
        CASE IS < JoyStickX - 20
          A$ = CHR$(0) + "K"
        CASE IS > JoyStickX + 20
          A$ = CHR$(0) + "M"
      END SELECT
      A = STRIG(1)
      B = STRIG(5)
      IF Free AND A AND B = 0 THEN
        A$ = CHR$(0) + "H"
        Free = False
      ELSE
        IF A = 0 AND B = 0 THEN Free = True
      END IF
      IF Free AND B AND A = 0 THEN
        A$ = CHR$(13)
        Free = False
      ELSE
        IF A = 0 AND B = 0 THEN Free = True
      END IF
    END IF
  LOOP UNTIL LEN(A$)
  IF LEN(A$) = 2 THEN Char = -ASC(RIGHT$(A$, 1)) ELSE Char = ASC(A$)
  PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle

  SELECT CASE Char
    CASE Left
      IF MoveBlockLeft%(GridX, GridY, Block, Cycle) THEN
        CheckFit NoFit, Block, Cycle, GridX - 1, GridY - 1
        IF NOT NoFit THEN GridX = GridX - 1
      END IF
    CASE Right
      IF MoveBlockRight%(GridX, GridY, Block, Cycle) THEN
        CheckFit NoFit, Block, Cycle, GridX + 1, GridY - 1
        IF NOT NoFit THEN GridX = GridX + 1
      END IF
    CASE Rotate, OppRotate
      TempCycle = Cycle
      TempX = GridX
      TempY = GridY
        SELECT CASE Cycle
          CASE 1
            IF Char = Rotate THEN Cycle = 2 ELSE Cycle = 4
            GridX = GridX + 1  ' Offset my bad programming <g>
            IF GridY - 1 = 0 THEN GridY = 1 ELSE GridY = GridY - 1
          CASE 2
            IF Char = Rotate THEN Cycle = 3 ELSE Cycle = 1
            GridX = GridX - 1
            GridY = GridY + 1
            IF GridX < 1 THEN
              IF Char = Rotate THEN
                IF Piece(Block, 4) = 1 OR Piece(Block, 8) = 1 THEN GridX = 1
              ELSE
                IF Piece(Block, 1) = 1 OR Piece(Block, 5) = 1 THEN GridX = 1
              END IF
            ELSEIF GridX + 3 > GridWidth THEN
              IF Char = Rotate THEN
                IF Piece(Block, 1) = 1 OR Piece(Block, 5) = 1 THEN GridX = GridX - 1
              ELSE
                IF Piece(Block, 4) = 1 OR Piece(Block, 8) = 1 THEN GridX = GridX - 1
              END IF
            END IF
          CASE 3
            IF Char = Rotate THEN Cycle = 4 ELSE Cycle = 2
            GridX = GridX + 1
            GridY = GridY - 1
          CASE 4
            IF Char = Rotate THEN Cycle = 1 ELSE Cycle = 3
            GridX = GridX - 1
            GridY = GridY + 1
            IF GridX < 1 THEN
              IF Char = OppRotate THEN
                IF Piece(Block, 4) = 1 OR Piece(Block, 8) = 1 THEN GridX = 1
              ELSE
                IF Piece(Block, 1) = 1 OR Piece(Block, 5) = 1 THEN GridX = 1
              END IF
            ELSEIF GridX + 3 > GridWidth THEN
              IF Char = OppRotate THEN
                IF Piece(Block, 1) = 1 OR Piece(Block, 5) = 1 THEN GridX = GridX - 1
                IF Block = 1 THEN GridX = GridX - 1   '' Oh the heck with it! :)
              ELSE
                IF Piece(Block, 4) = 1 OR Piece(Block, 8) = 1 THEN GridX = GridX - 1
                IF Block = 1 THEN GridX = GridX - 1
              END IF
            END IF
        END SELECT
        IF (GridY >= 19 AND Cycle = 2) OR (GridY >= 19 AND Cycle = 4) THEN
          NoFit = True
        ELSE
          CheckFit NoFit, Block, Cycle, GridX, GridY - 1
        END IF
      IF NoFit THEN     '' Cannot rotate, so restore previous values
        Cycle = TempCycle
        GridX = TempX
        GridY = TempY
      END IF
    CASE Drop
      InitDrop = True
    CASE DropSlow
      GOSUB DropBlock
  END SELECT
  PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
LOOP UNTIL Char = 27

END
    
DropBlock:
      IF AtBottom%(Block, Cycle, GridX, GridY) THEN
        NoFit = True
        GridY = GridY + 1
      ELSE
        CheckFit NoFit, Block, Cycle, GridX, GridY
      END IF
      IF NoFit THEN GOSUB PlaceBlock
RETURN

PlaceBlock:
        InitDrop = False
        GridY = GridY - 1
        PutInGrid Block, Cycle, GridX, GridY
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        IF GridY = 1 THEN CALL GameOver: END
        CheckLines GridY - 1
        GridX = 4: GridY = 1
        Block = NextBlock: Cycle = 1
        Occur(Block) = Occur(Block) + 1
        NumBlocks& = NumBlocks& + 1
        ShowOccurence
        NextBlock = INT(RND * 7) + 1
        ShapeArray = (NextBlock - 1) * 4 * Array + 1
        PUT (EndX + 20 + BlockWidth, 30 + BlockHeight), Shape(ShapeArray), PSET
        T! = TIMER
        ClearKeyBoard
RETURN

' No more than 7, and the pieces MUST BE at least 3 blocks in length
' Data for Style 1: Long
DATA 1,1,1,1
DATA 0,0,0,0
' Data for Style 2: L Right
DATA 1,1,1,0
DATA 0,0,1,0
' Data for Style 3: L Left
DATA 0,1,1,1
DATA 0,1,0,0
' Data for Style 4: Z Right
DATA 1,1,0,0
DATA 0,1,1,0
' Data for Style 5: Z Left
DATA 0,1,1,0
DATA 1,1,0,0
' Data for Style 6: T
DATA 1,1,1,0
DATA 0,1,0,0
' Data for Style 7: Square
DATA 0,1,1,0
DATA 0,1,1,0

REM $STATIC
FUNCTION AtBottom% (Block, Cycle, GridX, GridY)
'*************************************************************
' Function: Check if Block has reached the bottom of the well
'  Returns: True if cannot move down farther
'           False otherwise
'*************************************************************

    AtBottom% = False
      SELECT CASE Cycle
        CASE 2
          IF GridY = GridHeight - 2 THEN
            IF Piece(Block, 4) = 1 OR Piece(Block, 8) = 1 THEN AtBottom% = True
          ELSEIF GridY = GridHeight - 1 THEN AtBottom% = True
          END IF
        CASE 4
          IF GridY = GridHeight - 2 THEN
            IF Piece(Block, 1) = 1 OR Piece(Block, 5) = 1 THEN AtBottom% = True
          ELSEIF GridY = GridHeight - 1 THEN AtBottom% = True
          END IF
        CASE ELSE
          IF GridY = GridHeight + 1 AND Cycle = 1 AND Block = 1 THEN
            AtBottom% = True
          ELSEIF GridY = GridHeight AND Block = 1 AND Cycle = 1 THEN
            FOR I = 1 TO 4
              IF Piece(Block, I + 4) = 1 AND Grid(GridX - 1 + I, GridY) = 1 THEN AtBottom% = True
            NEXT I
          ELSEIF GridY = 19 AND Block = 1 AND Cycle = 3 THEN
            FOR I = 1 TO 4
              IF Piece(Block, 5 - I) = 1 AND Grid(GridX - 1 + I, GridY + 1) = 1 THEN AtBottom% = True
            NEXT I
          ELSEIF GridY = GridHeight AND Block <> 1 THEN
            AtBottom% = True
          END IF
      END SELECT

END FUNCTION

SUB CheckFit (NoFit, Block, Cycle, GridX, GridY)
'*****************************************************************
' Function: Check if Block fits into position without overlapping
'  Returns: NoFit is True if the Block cannot fit
'           NoFit is False otherwise
'*****************************************************************

    NoFit = False
    IF GridY <= GridHeight THEN
      GridY = GridY + 1
      SELECT CASE Cycle     '' Check if block fits
        CASE 1, 3
          IF Block = 1 THEN
              FOR I = 1 TO 4
                IF Cycle = 1 THEN
                  IF GridX - 1 + I < GridWidth + 1 THEN
                    IF Piece(Block, I) = 1 AND Grid(GridX - 1 + I, GridY - 1) = 1 THEN NoFit = True
                  END IF
                ELSE
                  IF GridY = GridHeight + 1 THEN
                    NoFit = True
                  ELSE
                    IF GridX - 1 + I < GridWidth + 1 THEN
                      IF Piece(Block, 5 - I) = 1 AND Grid(GridX - 1 + I, GridY) = 1 THEN NoFit = True
                    END IF
                  END IF
                END IF
                IF NoFit THEN EXIT FOR
              NEXT I
          ELSE
            FOR I = 1 TO 4
              IF Cycle = 1 THEN
                IF GridX - 1 + I < GridWidth + 1 THEN
                  IF Piece(Block, I) = 1 AND Grid(GridX - 1 + I, GridY - 1) = 1 THEN NoFit = True
                  IF GridY < GridHeight + 1 THEN IF Piece(Block, I + 4) = 1 AND Grid(GridX - 1 + I, GridY) = 1 THEN NoFit = True
                END IF
              ELSE
                IF GridX - 1 + I < GridWidth + 1 THEN
                  IF GridY < GridHeight + 1 THEN
                    IF Piece(Block, 9 - I) = 1 AND Grid(GridX - 1 + I, GridY - 1) = 1 THEN NoFit = True
                    IF Piece(Block, 5 - I) = 1 AND Grid(GridX - 1 + I, GridY) = 1 THEN NoFit = True
                  END IF
                END IF
              END IF
              IF NoFit THEN EXIT FOR
            NEXT I
          END IF
        CASE 2, 4
          FOR I = 1 TO 4
            IF Cycle = 2 THEN
              IF GridX <> 0 THEN
                IF GridY + I - 2 < GridHeight + 1 THEN
                  IF Piece(Block, I + 4) = 1 AND Grid(GridX, GridY + I - 2) = 1 THEN NoFit = True
                END IF
              END IF
              IF GridY + I - 2 < GridHeight + 1 THEN
                IF Piece(Block, I) = 1 AND Grid(GridX + 1, GridY + I - 2) = 1 THEN NoFit = True
              END IF
            ELSE
              IF GridY + I - 2 < GridHeight + 1 AND GridY > 0 THEN
                IF Piece(Block, 5 - I) = 1 AND Grid(GridX, GridY + I - 2) = 1 THEN NoFit = True
                IF GridX < GridWidth THEN
                  IF Piece(Block, 9 - I) = 1 AND Grid(GridX + 1, GridY + I - 2) = 1 THEN NoFit = True
                END IF
              END IF
            END IF
            IF NoFit THEN EXIT FOR
          NEXT I
      END SELECT
    END IF

END SUB

SUB CheckLines (GridY)
'*********************************************************
' Function: Check if user has any lines completed
'           Starts from bottom up until GridY is reached.
'  Display: Removes line and displays scores and stats
'  Returns: None
'*********************************************************

REDIM Well(20000) AS INTEGER   ' Depends on your GridWidth/BlockWidth, etc.

Y = GridHeight          '' Start from bottom up
TempLines = NumLines    '' Used as an indicator to how many lines completed
DO
  NoLine = False
  FOR J = 1 TO GridWidth
    IF Grid(J, Y) = 0 THEN NoLine = True: EXIT FOR
  NEXT J
  IF NoLine = False THEN
    FOR J = 1 TO GridWidth
      DrawBlock StartX + (J - 1) * BlockWidth + 1, StartY + (Y - 1) * BlockHeight, 22
    NEXT J
    GET (StartX + 1, StartY)-(StartX + GridWidth * BlockWidth, StartY + (Y - 1) * BlockHeight - 1), Well
    Pause .15
    LINE (StartX + 1, StartY + (Y - 1) * BlockHeight)-(StartX + GridWidth * BlockWidth, StartY + Y * BlockHeight - 1), 0, BF
    '' Cool Drop
    'FOR K = StartY TO StartY + BlockHeight
    '  PUT (StartX + 1, K), Well, PSET
    'NEXT K
    PUT (StartX + 1, StartY + BlockHeight), Well, PSET
    PushDown Y
    Y = Y + 1
  END IF
  Y = Y - 1
LOOP UNTIL Y = GridY - 1
     
'' Display all relevant scores and statistics.
IF NumLines > TempLines THEN '' If player has at least one line filled
  '' Display number of lines eliminated
  A$ = LTRIM$(STR$(NumLines))
  A$ = STRING$(4 - LEN(A$), "0") + A$
  LINE (EndX + 30, 30 + 5 * BlockHeight + 75)-(EndX + 80, 30 + 5 * BlockHeight + 82), 23, BF
  OFont A$, EndX + 46, 30 + 5 * BlockHeight + 75, 1, 3
  '' Display player score
  SELECT CASE NumLines - TempLines
    CASE 1
      Score& = Score& + ScoreX
    CASE 2
      Score& = Score& + Score2X
    CASE 3
      Score& = Score& + Score3X
    CASE 4
      Score& = Score& + Score4X
  END SELECT
  A$ = LTRIM$(STR$(Score&))
  A$ = STRING$(6 - LEN(A$), "0") + A$
  LINE (EndX + 30, 30 + 5 * BlockHeight + 15)-(EndX + 80, 30 + 5 * BlockHeight + 22), 23, BF
  OFont A$, EndX + 30, 30 + 5 * BlockHeight + 15, 1, 3
  '' Display number of lines left until next level reached
  IF NumLines >= LinesLeft THEN
    LinesLeft = LinesLeft + NextLevel
    Level! = Level! + 1
    Delay! = Delay! - Decr!
    IF Delay! < .02 THEN Delay! = .018
    A$ = LTRIM$(STR$(Level!))
    A$ = STRING$(3 - LEN(A$), "0") + A$
    LINE (EndX + 30, 30 + 5 * BlockHeight + 45)-(EndX + 80, 30 + 5 * BlockHeight + 52), 23, BF
    OFont A$, EndX + 54, 30 + 5 * BlockHeight + 45, 1, 3
  END IF
  A$ = LTRIM$(STR$(LinesLeft - NumLines))
  A$ = STRING$(4 - LEN(A$), "0") + A$
  LINE (EndX + 30, 30 + 5 * BlockHeight + 105)-(EndX + 80, 30 + 5 * BlockHeight + 112), 23, BF
  OFont A$, EndX + 46, 30 + 5 * BlockHeight + 105, 1, 3
END IF

ERASE Well

END SUB

SUB ClearKeyBoard
' Clears keyboard buffer

DO: LOOP UNTIL INKEY$ = ""

END SUB

SUB DefinePalette
' Function: Changes palette scheme

' Blue
Pal 1, 0, 0, 50
Pal 2, 0, 0, 30
Pal 3, 0, 0, 20

' Red
Pal 4, 50, 0, 0
Pal 5, 30, 0, 0
Pal 6, 20, 0, 0

' Green
Pal 7, 0, 50, 0
Pal 8, 0, 30, 0
Pal 9, 0, 20, 0

' Cyan
Pal 10, 0, 50, 50
Pal 11, 0, 30, 30
Pal 12, 0, 20, 20

' Purple
Pal 13, 50, 0, 50
Pal 14, 30, 0, 30
Pal 15, 20, 0, 20

' Yellow
Pal 16, 55, 55, 0
Pal 17, 35, 35, 0
Pal 18, 25, 25, 0

' Orange
Pal 19, 63, 45, 0
Pal 20, 43, 25, 0
Pal 21, 33, 15, 0

' White
Pal 22, 55, 55, 55
Pal 23, 35, 35, 35
Pal 24, 25, 25, 25
Pal 25, 63, 63, 63

END SUB

SUB DrawBlock (X, Y, Hue)
' Function: Draw one square block at X,Y with palette Hue.

    LINE (X, Y)-(X + BlockWidth - 1, Y + BlockHeight - 1), Colour(Hue), BF
    'Bottom Shadow
    LINE (X, Y + BlockHeight - 1)-(X + BlockWidth - 1, Y + BlockHeight - 1), Colour(Hue + 2)
    LINE (X + 1, Y + BlockHeight - 2)-(X + BlockWidth - 2, Y + BlockHeight - 2), Colour(Hue + 2)
    'Right Shadow
    LINE (X + BlockWidth - 1, Y)-(X + BlockWidth - 1, Y + BlockHeight - 1), Colour(Hue + 2)
    LINE (X + BlockWidth - 2, Y + 1)-(X + BlockWidth - 2, Y + BlockHeight - 2), Colour(Hue + 2)
    'Top Shadow
    LINE (X, Y)-(X + BlockWidth - 1, Y), Colour(Hue + 1)
    LINE (X + 1, Y + 1)-(X + BlockWidth - 2, Y + 1), Colour(Hue + 1)
    'Left Shadow
    LINE (X, Y)-(X, Y + BlockHeight - 1), Colour(Hue + 1)
    LINE (X + 1, Y + 1)-(X + 1, Y + BlockHeight - 2), Colour(Hue + 1)
END SUB

SUB GameOver

SLEEP 1

LINE (StartX + 1, 0)-(StartX + 10 * BlockWidth, StartY), 0, BF
OFont "GAME OVER", StartX + 19, 1, 1, 3

FOR Y = StartY TO EndY - BlockHeight STEP BlockHeight
  Pause .018
  FOR X = StartX + 1 TO EndX - BlockWidth STEP BlockWidth
    DrawBlock X, Y, 22
  NEXT X
NEXT Y

END SUB

SUB GetShapes
' Function: Draw all shapes and store them in Shape() for easy retrieval

FOR I = 1 TO 7
  Hue = (I - 1) * 3 + 1
  StartArray = (I - 1) * 4 * Array + 1
  FOR K = 1 TO 4
    LINE (0, 0)-(4 * BlockWidth - 1, 4 * BlockHeight - 1), 0, BF
    X = 0
    Y = 0
    N = 0
    SELECT CASE K
      CASE 1
        FOR J = 1 TO 8
          IF J = 5 THEN Y = Y + BlockHeight: N = 0
          IF Piece(I, J) = 1 THEN
             DrawBlock X + (N * BlockWidth), Y, Hue
          END IF
          N = N + 1
        NEXT J
        GET (0, 0)-(4 * BlockWidth - 1, 2 * BlockHeight - 1), Shape(StartArray)
      CASE 2
        FOR J = 1 TO 4
          IF Piece(I, J) = 1 THEN DrawBlock X + BlockWidth, Y, Hue
          IF Piece(I, J + 4) = 1 THEN DrawBlock X, Y, Hue
          Y = Y + BlockHeight
        NEXT J
        GET (0, 0)-(2 * BlockWidth - 1, 4 * BlockHeight - 1), Shape(StartArray + (K - 1) * Array)
      CASE 3
        FOR J = 4 TO 1 STEP -1
          IF Piece(I, J) = 1 THEN DrawBlock X + (N * BlockWidth), Y + BlockHeight, Hue
          IF Piece(I, J + 4) = 1 THEN DrawBlock X + (N * BlockWidth), Y, Hue
          N = N + 1
        NEXT J
        GET (0, 0)-(4 * BlockWidth - 1, 2 * BlockHeight - 1), Shape(StartArray + (K - 1) * Array)
      CASE 4
        FOR J = 4 TO 1 STEP -1
          IF Piece(I, J) = 1 THEN DrawBlock X, Y, Hue
          IF Piece(I, J + 4) = 1 THEN DrawBlock X + BlockWidth, Y, Hue
          Y = Y + BlockHeight
        NEXT J
        GET (0, 0)-(2 * BlockWidth - 1, 4 * BlockHeight - 1), Shape(StartArray + (K - 1) * Array)
    END SELECT
  NEXT K
NEXT I

END SUB

SUB InitVariables
' Function: Initialize all relevant variables for gameplay

FOR I = 1 TO 7
  FOR J = 1 TO 8
    READ Piece(I, J)
  NEXT J
NEXT I

FOR I = 1 TO 3 * 8
  Colour(I) = I
NEXT I

FOR I = 1 TO 3 * 8      '' Hide what I'm doing
  Pal I, 0, 0, 0
NEXT I

GetShapes

LINE (0, 0)-(319, 199), 0, BF   '' cls

DefinePalette

END SUB

FUNCTION MoveBlockLeft% (GridX, GridY, Block, Cycle)
'****************************************************************
' Function: Check if Block can be moved one position to the left
'  Returns: True if no overlap
'           False otherwise
'****************************************************************

    MoveBlockLeft% = False
      SELECT CASE Cycle
        CASE 1  '' Horizontal, so check left side
          IF GridX <= 1 THEN
            IF Piece(Block, ABS(GridX - 2)) = 0 AND Piece(Block, ABS(GridX - 6)) = 0 THEN MoveBlockLeft% = True
          ELSE
            MoveBlockLeft% = True
          END IF
        CASE 2  '' Vertical, so check bottom side
          IF GridX <> 0 THEN
            IF GridX = 1 THEN
              NoMore = False
              FOR I = 5 TO 8
                IF Piece(Block, I) = 1 THEN NoMore = True: EXIT FOR
              NEXT I
              IF NoMore = False THEN MoveBlockLeft% = True
            ELSE
              MoveBlockLeft% = True
            END IF
          END IF
        CASE 3 '' Horizontal #2, so check right side
          IF GridX <= 1 THEN
            IF Piece(Block, GridX + 3) = 0 AND Piece(Block, GridX + 7) = 0 THEN MoveBlockLeft% = True
          ELSE
            MoveBlockLeft% = True
          END IF
        CASE 4 '' Vertical #2, so check top side
          IF GridX <> 0 THEN
            IF GridX = 1 THEN
              NoMore = False
              FOR I = 1 TO 4
                IF Piece(Block, I) = 1 THEN NoMore = True: EXIT FOR
              NEXT I
              IF NoMore = False THEN MoveBlockLeft% = True
            ELSE
              MoveBlockLeft% = True
            END IF
          END IF
      END SELECT

END FUNCTION

FUNCTION MoveBlockRight% (GridX, GridY, Block, Cycle)
'*****************************************************************
' Function: Check if Block can be moved one position to the right
'  Returns: True if no overlap
'           False otherwise
'*****************************************************************
    
   MoveBlockRight% = False
      SELECT CASE Cycle
        CASE 1  '' Horizontal, so check right side
          IF GridX + 3 >= GridWidth THEN
            IF Piece(Block, GridWidth - GridX + 1) = 0 AND Piece(Block, GridWidth - GridX + 5) = 0 THEN MoveBlockRight% = True
          ELSE
            MoveBlockRight% = True
          END IF
        CASE 2  '' Vertical, so check top side
          IF GridX <> GridWidth THEN
            IF GridX = GridWidth - 1 THEN
              NoMore = False
              FOR I = 1 TO 4
                IF Piece(Block, I) = 1 THEN NoMore = True: EXIT FOR
              NEXT I
              IF NoMore = False THEN MoveBlockRight% = True
            ELSE
              MoveBlockRight% = True
            END IF
          END IF
        CASE 3 '' Horizontal #2, so check left side
          IF GridX + 3 >= GridWidth THEN
            IF Piece(Block, ABS(GridWidth - GridX - 4)) = 0 AND Piece(Block, ABS(GridWidth - GridX - 8)) = 0 THEN MoveBlockRight% = True
          ELSE
            MoveBlockRight% = True
          END IF
        CASE 4 '' Vertical #2, so check bottom side
          IF GridX <> GridWidth THEN
            IF GridX = GridWidth - 1 THEN
              NoMore = False
              FOR I = 5 TO 8
                IF Piece(Block, I) = 1 THEN NoMore = True: EXIT FOR
              NEXT I
              IF NoMore = False THEN MoveBlockRight% = True
            ELSE
              MoveBlockRight% = True
            END IF
          END IF
      END SELECT

END FUNCTION

SUB OFont (Text$, X, Y, Fore, Back)
DEF SEG = &HFFA6                              'Stores masks for letters
FOR Letter = 1 TO LEN(Text$)                  'Does each letter
Address = (8 * ASC(MID$(Text$, Letter))) + 14 'Address for start of letter
FOR Height = 0 TO 7                       'Each letter is an 8x8 pixel matrix
Mask = PEEK(Address + Height) * 128   'Address for mask of each line of letter
LINE (X + Curntx + 1, Y + Height + 1)-(X + 9 + Curntx, Y + Height + 1), Fore, , Mask
NEXT
Curntx = Curntx + 8                   'Advances X axis by 8 for next letter
NEXT                                  'Continue to next letter
DEF SEG = &HA000                      'Change to video memory
IF Back > 0 THEN                      'Background color can't be color 0
FOR V = Y TO Y + 7                    'Again, they're 8x8 pixels
FOR H = X TO (LEN(Text$) * 8) - 1 + X 'Calculates length of text in pixels
PK0& = PEEK(H + V * 320&)             'Is point at H,V = to foreground color?
PK1& = PEEK(H + 1 + (V + 1) * 320&)   'Is point at H+1, V+1 = to foreground?
PK2& = PEEK(H + 1 + V * 320&)         'Is point at H+1, V = to foreground?
PT& = H + V * 320&                    'Video memory pointer
IF PK0& <> Fore THEN                  'If this is foreground, don't overlap it
IF PK1& = Fore OR PK2& = Fore THEN POKE PT&, Back    'Put pixel into memory
END IF
NEXT H     'Next horizontal
NEXT V     'Next vertical
END IF
DEF SEG    'Put us back where
END SUB

SUB Pal (C, R, G, B)
    OUT &H3C8, C
    OUT &H3C9, R
    OUT &H3C9, G
    OUT &H3C9, B
END SUB

SUB Pause (Seconds!)

T! = TIMER
DO
LOOP UNTIL ABS(TIMER - T!) >= Seconds!

END SUB

SUB PushDown (LineY)
' Function: Clear LineY from grid, update numlines and score

  FOR J = 1 TO GridWidth
    Grid(J, LineY) = 0
  NEXT J

  FOR I = LineY TO 2 STEP -1
    FOR J = 1 TO GridWidth
      SWAP Grid(J, I), Grid(J, I - 1)
    NEXT J
  NEXT I
  NumLines = NumLines + 1
  Score& = Score& + StdScore + (Level! * LevelX)

END SUB

SUB PutBlock (X, Y, Block, Cycle)
' Function: Place Block at X,Y

   ShapeArray = (Block - 1) * 4 * Array + 1 + ((Cycle - 1) * Array)
   IF Y > 0 THEN
     PUT (X, Y), Shape(ShapeArray), XOR   '' Overlap is okay
   END IF

END SUB

SUB PutInGrid (Block, Cycle, GridX, GridY)
'*********************************************
' Function: Occupy (fill) grid with block
'  Returns: None
'*********************************************


      SELECT CASE Cycle     '' Fill grid with block
        CASE 1, 3
          IF GridY - 1 = GridHeight THEN
            FOR I = 1 TO 4
              IF Cycle = 1 THEN
                IF Piece(Block, I) = 1 THEN Grid(GridX - 1 + I, GridY - 1) = 1
              ELSE
                IF Piece(Block, 5 - I) = 1 THEN Grid(GridX - 1 + I, GridY - 1) = 1
              END IF
            NEXT I
          ELSE
            FOR I = 1 TO 4
              IF Cycle = 1 THEN
                IF Piece(Block, I) = 1 THEN Grid(GridX - 1 + I, GridY - 1) = 1
                IF Piece(Block, I + 4) = 1 THEN Grid(GridX - 1 + I, GridY) = 1
              ELSE
                IF Piece(Block, 9 - I) = 1 THEN Grid(GridX - 1 + I, GridY - 1) = 1
                IF Piece(Block, 5 - I) = 1 THEN Grid(GridX - 1 + I, GridY) = 1
              END IF
            NEXT I
          END IF
        CASE 2, 4
          FOR I = 1 TO 4
            IF Cycle = 2 THEN
              IF GridX <> 0 THEN
                IF Piece(Block, I + 4) = 1 THEN Grid(GridX, (GridY + I - 2)) = 1
              END IF
              IF Piece(Block, I) = 1 THEN Grid(GridX + 1, GridY + I - 2) = 1
            ELSE
              IF Piece(Block, 5 - I) = 1 THEN Grid(GridX, GridY + I - 2) = 1
              IF GridX <> GridHeight THEN
                IF Piece(Block, 9 - I) = 1 THEN Grid(GridX + 1, GridY + I - 2) = 1
              END IF
            END IF
          NEXT I
      END SELECT

' If you wish to do some debugging...
'FOR I = 1 TO GridHeight
'FOR J = 1 TO GridWidth
'  LOCATE I, 19 + J
'  IF Grid(J, I) = 1 THEN PRINT "X";  ELSE PRINT "O";
'NEXT J
'NEXT I

END SUB

SUB SetupScreen
' Function: Create gameplay screen

LINE (0, 0)-(StartX - 2, 199), 23, BF
LINE (EndX + 2, 0)-(319, 199), 23, BF
LINE (0, EndY + 2)-(EndX + 1, 199), 23, BF
LINE (0, 0)-(StartX - 2, 0), 25
LINE (0, 0)-(0, 199), 25
LINE (StartX, EndY + 2)-(EndX + 1, EndY + 2), 25
LINE (EndX + 2, 0)-(EndX + 2, EndY + 2), 25
LINE (EndX + 2, 0)-(319, 0), 25
LINE (StartX - 2, 1)-(StartX - 2, EndY + 2), 24
LINE (0, 199)-(319, 199), 24
LINE (319, 1)-(319, 199), 24

'Text$ = "YA TETRIS"
'FOR I = 1 TO LEN(Text$)
'  OFont MID$(Text$, I, 1), 4, 10 + (I - 1) * 10, 22, 24
'NEXT I

OFont "YA!", EndX + 12, 10, 1, 3
OFont "TETRIS", EndX + 42, 10, 10, 12

LINE (EndX + 105, 5)-(EndX + 180, 22), 25, B
LINE (EndX + 105, 5)-(EndX + 180, 5), 24
LINE (EndX + 105, 5)-(EndX + 105, 22), 24
OFont "STANDARD", EndX + 110, 10, 4, 6

LINE (EndX + 25, 30 + 5 * BlockHeight + 12)-(EndX + 83, 30 + 5 * BlockHeight + 25), 25, B
LINE (EndX + 25, 30 + 5 * BlockHeight + 12)-(EndX + 83, 30 + 5 * BlockHeight + 12), 24
LINE (EndX + 25, 30 + 5 * BlockHeight + 12)-(EndX + 25, 30 + 5 * BlockHeight + 25), 24
OFont "Score", EndX + 30, 30 + 5 * BlockHeight, 25, 24

LINE (EndX + 25, 30 + 5 * BlockHeight + 42)-(EndX + 83, 30 + 5 * BlockHeight + 55), 25, B
LINE (EndX + 25, 30 + 5 * BlockHeight + 42)-(EndX + 83, 30 + 5 * BlockHeight + 42), 24
LINE (EndX + 25, 30 + 5 * BlockHeight + 42)-(EndX + 25, 30 + 5 * BlockHeight + 55), 24
OFont "Level", EndX + 30, 30 + 5 * BlockHeight + 30, 25, 24

LINE (EndX + 25, 30 + 5 * BlockHeight + 72)-(EndX + 83, 30 + 5 * BlockHeight + 85), 25, B
LINE (EndX + 25, 30 + 5 * BlockHeight + 72)-(EndX + 83, 30 + 5 * BlockHeight + 72), 24
LINE (EndX + 25, 30 + 5 * BlockHeight + 72)-(EndX + 25, 30 + 5 * BlockHeight + 85), 24
OFont "Lines", EndX + 30, 30 + 5 * BlockHeight + 60, 25, 24

LINE (EndX + 25, 30 + 5 * BlockHeight + 102)-(EndX + 83, 30 + 5 * BlockHeight + 115), 25, B
LINE (EndX + 25, 30 + 5 * BlockHeight + 102)-(EndX + 83, 30 + 5 * BlockHeight + 102), 24
LINE (EndX + 25, 30 + 5 * BlockHeight + 102)-(EndX + 25, 30 + 5 * BlockHeight + 115), 24
OFont "Left", EndX + 30, 30 + 5 * BlockHeight + 90, 25, 24
OFont "000000", EndX + 30, 30 + 5 * BlockHeight + 15, 1, 3
A$ = LTRIM$(STR$(Level!))
A$ = STRING$(3 - LEN(A$), "0") + A$
OFont A$, EndX + 54, 30 + 5 * BlockHeight + 45, 1, 3
OFont "0000", EndX + 46, 30 + 5 * BlockHeight + 75, 1, 3
A$ = LTRIM$(STR$(LinesLeft))
A$ = STRING$(4 - LEN(A$), "0") + A$
OFont A$, EndX + 46, 30 + 5 * BlockHeight + 105, 1, 3

ShowOccurence

LINE (EndX + 20, 30)-(EndX + 20 + 6 * BlockWidth, 30 + 4 * BlockHeight), 0, BF
LINE (EndX + 20, 30)-(EndX + 20 + 6 * BlockWidth, 30 + 4 * BlockHeight), 25, B
LINE (EndX + 20, 30)-(EndX + 20 + 6 * BlockWidth, 30), 24
LINE (EndX + 20, 30)-(EndX + 20, 30 + 4 * BlockHeight), 24

LINE (StartX, StartY)-(StartX, EndY), 24
LINE (StartX, EndY)-(EndX, EndY), 24
LINE (EndX, StartY)-(EndX, EndY), 24

END SUB

SUB ShowOccurence
' Function: Display block statistics

L = EndY - 30  '' Length of line

LINE (EndX + 110, 30)-(EndX + 200, EndY), 23, BF

FOR I = 1 TO 7
  LINE (EndX + 110 + (I - 1) * 10, EndY)-(EndX + 115 + (I - 1) * 10, EndY - Occur(I) / NumBlocks& * L), (I - 1) * 3 + 1, BF
  LINE (EndX + 110 + (I - 1) * 10, EndY)-(EndX + 110 + (I - 1) * 10, EndY - Occur(I) / NumBlocks& * L), (I - 1) * 3 + 2
  LINE (EndX + 110 + (I - 1) * 10, EndY - Occur(I) / NumBlocks& * L)-(EndX + 115 + (I - 1) * 10, EndY - Occur(I) / NumBlocks& * L), (I - 1) * 3 + 2
  LINE (EndX + 115 + (I - 1) * 10, EndY)-(EndX + 115 + (I - 1) * 10, EndY - Occur(I) / NumBlocks& * L), (I - 1) * 3 + 3
NEXT I

END SUB

