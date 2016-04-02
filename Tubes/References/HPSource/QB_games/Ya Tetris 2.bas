'=========[ YA! TETRIS v2.0 (Multi-Player) Programmed by William Yu ]==========
'
'      Release:  YA! (Yet Another) TETRIS Multi-Player Version
'                Programmed by William Yu (07-28-97)
'       Status:  99% Public Domain, please give credit where due.
'                No warranties or guaranteeds applied.
'                Use within a commercial product is STRICTLY PROHIBITED!
'   Copyrights:  TETRIS is now a property of Alexey Pajitnov's TETRIS Co.
'    Thanks to:  Phillip Jay Cohen for his "Outline Font Routine" (SUB OFONT)
'                Eric Carr for his "MultiKey" routine
'   Contact me:  E-mail: voxel@freenet.edmonton.ab.ca
'
'     Controls: Keyboard (configurable), check CONSTs
'               Joystick (1), or modify the program to support 2.
'               Only player two can use the joystick (unless changes made).
'               It's very slow, so using a joystick is not recommended.
'               You can add a second joystick, if you are knowledgable.
'               If only one player is using a joystick, it can be unfair.
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
'  MultiPlayer: I have only added two-player support, you'll have to do your
'               own modifications to adapt to 3-4 players.
'     MultiKey: Thanks to Eric Carr for his Multikey routine.
'               This allows the pieces to move more freely, but be aware
'               that it may be too sensitive.  If it is, just increase the
'               delay time.  Check CONST LoopTime!
'  Competitive: Check CONST Competitive
'               Competitive Mode (True) means that for every 2-4 lines
'               completed (for either player), then those lines will be
'               transfered to the other player's grid.  Try to flood the
'               other player's grid as fast as possible!  More fun!
'               In my version, for every 2 lines completed, 1 line gets
'               transfered to the other player's grid, for 3, 2 lines, and
'               for 4, 3 lines.  None for only 1 line completed.
'               NON-Competitive Mode (False) means the above is nullified.
'               Just play until one player folds or the game tilts.
'               Not as enjoyable as competitive mode!
'       Errors: I've noticed a few, but please do not contact me with any!
'               I'm giving up on updating this game/project.  Please try to
'               remedy the problem yourself, but good luck reading my mess!
'  Only Update: If anyone can program the computer to play against the
'               player I would be very pleased to see this!
'               There's only a few versions of Tetris that I've seen this
'               implemented in, go search on the 'net for "TRISTIX!"
'
'==============================================================================

DECLARE FUNCTION MultiKey% (KEYNUM%)
DECLARE SUB GameOver2 ()
DECLARE SUB PushDown2 (LineY%, Grid2%())
DECLARE SUB GameOver ()
DECLARE SUB SetupScreen ()
DECLARE SUB ClearKeyBoard ()
DECLARE SUB Pause (Seconds!)
DECLARE SUB CheckLines2 (GridY%, Grid2%(), Increase%)
DECLARE SUB RotatePiece (Grid%(), Block%, Cycle%, GridX%, GridY%, Char%)
DECLARE SUB PushDown (LineY%, Grid() AS INTEGER)
DECLARE SUB CheckLines (GridY%, Grid() AS INTEGER, Increase%)
DECLARE SUB CheckFit (NoFit%, Block%, Cycle%, GridX%, GridY%, Grid() AS INTEGER)
DECLARE SUB PutInGrid (Block%, Cycle%, GridX%, GridY%, Grid() AS INTEGER)
DECLARE FUNCTION AtBottom% (Block%, Cycle%, GridX%, GridY%, Grid() AS INTEGER)
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
CONST UseJoy = False     '' Use joystick (Only for player TWO)
CONST Competitive = True '' More fun!  (False = Less Fun)
CONST LoopTime! = .12    '' Slow down keyboard input
'-- Player One Keys --   '' Left-side of screen
CONST Left = 30       '' A
CONST Right = 32      '' D
CONST Rotate = 17     '' W
CONST OppRotate = 16  '' Q
CONST DropSlow = 31   '' S
CONST Drop = 45       '' X
'-- Player Two Keys --   '' Right-side of screen
CONST Left2 = 75      '' Left Arrow
CONST Right2 = 77     '' Right Arrow
CONST Rotate2 = 72    '' Up Arrow
CONST OppRotate2 = 82 '' INS Key: Counter-clockwise
CONST Drop2 = 28      '' Enter Key
CONST DropSlow2 = 80  '' Down Arrow
'--
CONST GridWidth = 10
CONST GridHeight = 20
CONST BlockWidth = 10
CONST BlockHeight = 9
CONST NextLevel = 10
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
DIM Grid(0 TO GridWidth, 0 TO GridHeight) AS INTEGER
DIM Grid2(0 TO GridWidth, 0 TO GridHeight) AS INTEGER
DIM SHARED Colour(3 * 8) AS INTEGER
DIM SHARED Shape(7 * 4 * Array) AS INTEGER
DIM OneLine(Array * 2.5) AS INTEGER
DIM SHARED StartX, StartY, EndY, EndX, NumLines, LinesLeft, Level!, Delay!
DIM SHARED StartX2, StartY2, EndY2, EndX2, Delay2!, Level2!, LinesLeft2, NumLines2

StartX = GridWidth
StartY = 10
EndX = StartX + BlockWidth * GridWidth + 1
EndY = StartY + BlockHeight * GridHeight
StartX2 = EndX + 96
StartY2 = 10
EndX2 = StartX2 + BlockWidth * GridWidth + 1
EndY2 = StartY2 + BlockHeight * GridHeight

InitVariables

IF UseJoy THEN
  JoyStickX = STICK(0)
  JoyStickY = STICK(1)
  Free = True
END IF

RANDOMIZE TIMER
'Player one init
NumLines = 0
LinesLeft = NextLevel
Level! = 0
GridX = 4
GridY = 1
Cycle = 1
Block = INT(RND * 7) + 1
InitDrop = False
NextBlock = INT(RND * 7) + 1

'Player two init
NumLines2 = 0
LinesLeft2 = NextLevel
Level! = 0
GridX2 = 4
GridY2 = 1
Cycle2 = 1
Block2 = INT(RND * 7) + 1
InitDrop2 = False
NextBlock2 = INT(RND * 7) + 1

SetupScreen  '' Draw gameplay screen

PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
ShapeArray = (NextBlock - 1) * 4 * Array + 1
PUT (EndX + 18 + BlockWidth, 30 + BlockHeight), Shape(ShapeArray), PSET

PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
ShapeArray = (NextBlock2 - 1) * 4 * Array + 1
PUT (EndX + 18 + BlockWidth, 115 + BlockHeight), Shape(ShapeArray), PSET

Delay! = .9 - (Level! * Decr!)
Delay2! = .9 - (Level! * Decr!)
IF Delay! < .02 THEN Delay! = .018
IF Delay2! < .02 THEN Delay2! = .018
T! = TIMER: T2! = TIMER: TimeLoop! = TIMER
DO
    IF InitDrop THEN
      PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
      GOSUB DropBlock
      PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
    ELSEIF TIMER - T! >= Delay! THEN
      T! = TIMER
      PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
      GOSUB DropBlock
      PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
    END IF
    IF InitDrop2 THEN
      PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
      GOSUB DropBlock2
      PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
    ELSEIF TIMER - T2! >= Delay2! THEN
      T2! = TIMER
      PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
      GOSUB DropBlock2
      PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
    END IF

    IF UseJoy THEN
      IF STICK(1) > JoyStickY + 25 THEN
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        GOSUB DropBlock2
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
      END IF
      SELECT CASE STICK(0)
        CASE IS < JoyStickX - 25
          PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
          IF MoveBlockLeft%(GridX2, GridY2, Block2, Cycle2) THEN
            CheckFit NoFit, Block2, Cycle2, GridX2 - 1, GridY2 - 1, Grid2()
            IF NOT NoFit THEN GridX2 = GridX2 - 1
          END IF
          PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        CASE IS > JoyStickX + 25
          PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
          IF MoveBlockRight%(GridX2, GridY2, Block2, Cycle2) THEN
            CheckFit NoFit, Block2, Cycle2, GridX2 + 1, GridY2 - 1, Grid2()
            IF NOT NoFit THEN GridX2 = GridX2 + 1
          END IF
          PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
      END SELECT
      A = STRIG(1)
      B = STRIG(5)
      IF Free AND A AND B = 0 THEN
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        RotatePiece Grid2(), Block2, Cycle2, GridX2, GridY2, Rotate
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        Free = False
      ELSE
        IF A = 0 AND B = 0 THEN Free = True
      END IF
      IF Free AND B AND A = 0 THEN
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        RotatePiece Grid2(), Block2, Cycle2, GridX2, GridY2, OppRotate
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        Free = False
      ELSE
        IF A = 0 AND B = 0 THEN Free = True
      END IF
    END IF
  TimeUp = False: TimeUp2 = False
  IF MultiKey(Left) = 0 THEN GoLeft = False
  IF MultiKey(Left2) = 0 THEN GoLeft2 = False
  IF MultiKey(Right) = 0 THEN GoRight = False
  IF MultiKey(Right2) = 0 THEN GoRight2 = False
  IF MultiKey(Rotate) = 0 THEN GoRotate = False
  IF MultiKey(Rotate2) = 0 THEN GoRotate2 = False
  IF MultiKey(OppRotate) = 0 THEN GoOppRotate = False
  IF MultiKey(OppRotate2) = 0 THEN GoOppRotate2 = False
  IF MultiKey(DropSlow) = 0 THEN GoDropSlow = False
  IF MultiKey(DropSlow2) = 0 THEN GoDropSlow2 = False
  IF MultiKey(Drop) = 0 THEN GoDrop = False
  IF MultiKey(Drop2) = 0 THEN GoDrop2 = False
  IF TIMER - TimeLoop! >= LoopTime! THEN TimeUp = True
  IF TIMER - TimeLoop2! >= LoopTime! THEN TimeUp2 = True
  IF TimeUp THEN TimeLoop! = TIMER
  IF TimeUp2 THEN TimeLoop2! = TIMER
    IF MultiKey(Left) THEN
      IF GoLeft = False OR TimeUp THEN
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        IF MoveBlockLeft%(GridX, GridY, Block, Cycle) THEN
          CheckFit NoFit, Block, Cycle, GridX - 1, GridY - 1, Grid()
          IF NOT NoFit THEN GridX = GridX - 1
        END IF
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        GoLeft = True
        TimeLoop! = TIMER
      END IF
    END IF
    IF MultiKey(Left2) THEN
      IF GoLeft2 = False OR TimeUp2 THEN
          PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
          IF MoveBlockLeft%(GridX2, GridY2, Block2, Cycle2) THEN
            CheckFit NoFit, Block2, Cycle2, GridX2 - 1, GridY2 - 1, Grid2()
            IF NOT NoFit THEN GridX2 = GridX2 - 1
          END IF
          PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        GoLeft2 = True
        TimeLoop2! = TIMER
      END IF
    END IF
    IF MultiKey(Right) THEN
      IF GoRight = False OR TimeUp THEN
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        IF MoveBlockRight%(GridX, GridY, Block, Cycle) THEN
          CheckFit NoFit, Block, Cycle, GridX + 1, GridY - 1, Grid()
          IF NOT NoFit THEN GridX = GridX + 1
        END IF
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        GoRight = True
        TimeLoop! = TIMER
      END IF
    END IF
    IF MultiKey(Right2) THEN
      IF GoRight2 = False OR TimeUp2 THEN
          PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
          IF MoveBlockRight%(GridX2, GridY2, Block2, Cycle2) THEN
            CheckFit NoFit, Block2, Cycle2, GridX2 + 1, GridY2 - 1, Grid2()
            IF NOT NoFit THEN GridX2 = GridX2 + 1
          END IF
          PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        GoRight2 = True
        TimeLoop2! = TIMER
      END IF
    END IF
    IF MultiKey(Rotate) THEN
      IF GoRotate = False OR TimeUp THEN
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        RotatePiece Grid(), Block, Cycle, GridX, GridY, Rotate
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        GoRotate = True
        TimeLoop! = TIMER
      END IF
    END IF
    IF MultiKey(Rotate2) THEN
      IF GoRotate2 = False OR TimeUp2 THEN
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        RotatePiece Grid2(), Block2, Cycle2, GridX2, GridY2, Rotate
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        GoRotate2 = True
        TimeLoop2! = TIMER
      END IF
    END IF
    IF MultiKey(OppRotate) THEN
      IF GoOppRotate = False OR TimeUp THEN
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        RotatePiece Grid(), Block, Cycle, GridX, GridY, OppRotate
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        GoOppRotate = True
        TimeLoop! = TIMER
      END IF
    END IF
    IF MultiKey(OppRotate2) THEN
      IF GoOppRotate2 = False OR TimeUp2 THEN
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        RotatePiece Grid2(), Block2, Cycle2, GridX2, GridY2, OppRotate
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        GoOppRotate2 = True
        TimeLoop2! = TIMER
      END IF
    END IF
    IF MultiKey(Drop) THEN
      IF GoDrop = False OR TimeUp THEN
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        InitDrop = True
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        GoDrop = True
        TimeLoop! = TIMER
      END IF
    END IF
    IF MultiKey(Drop2) THEN
      IF GoDrop2 = False OR TimeUp2 THEN
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        InitDrop2 = True
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        GoDrop2 = True
        TimeLoop2! = TIMER
      END IF
    END IF
    IF MultiKey(DropSlow) THEN
      IF GoDropSlow = False OR TimeUp THEN
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        GOSUB DropBlock
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        GoDropSlow = True
        TimeLoop! = TIMER
      END IF
    END IF
    IF MultiKey(DropSlow2) THEN
      IF GoDropSlow2 = False OR TimeUp2 THEN
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        GOSUB DropBlock2
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        GoDropSlow2 = True
        TimeLoop2! = TIMER
      END IF
    END IF
LOOP UNTIL MultiKey(1)

END
    
DropBlock:
      IF AtBottom%(Block, Cycle, GridX, GridY, Grid()) THEN
        NoFit = True
        GridY = GridY + 1
      ELSE
        CheckFit NoFit, Block, Cycle, GridX, GridY, Grid()
      END IF
      IF NoFit THEN GOSUB PlaceBlock
RETURN
DropBlock2:
      IF AtBottom%(Block2, Cycle2, GridX2, GridY2, Grid2()) THEN
        NoFit = True
        GridY2 = GridY2 + 1
      ELSE
        CheckFit NoFit, Block2, Cycle2, GridX2, GridY2, Grid2()
      END IF
      IF NoFit THEN GOSUB PlaceBlock2
RETURN


PlaceBlock:
        InitDrop = False
        GridY = GridY - 1
        PutInGrid Block, Cycle, GridX, GridY, Grid()
        PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
        IF GridY = 1 THEN CALL GameOver: END
        CheckLines GridY - 1, Grid(), Increase
        IF Increase AND Competitive THEN
          PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
          N = RND * GridWidth + 1
          C = RND * 7 + 1
          NoMore = False
          FOR L = 2 TO Increase
            IF NoMore = False THEN
              CheckFit NoFit, Block2, Cycle2, GridX2, GridY2, Grid2()
              GridY2 = GridY2 - 1
              IF NoFit THEN
                'GridY2 = GridY2 - 1
                PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
                PutInGrid Block2, Cycle2, GridX2, GridY2, Grid2()
                NoMore = True
              END IF
            END IF
            FOR I = 2 TO GridHeight
              FOR J = 1 TO GridWidth
                SWAP Grid2(J, I), Grid2(J, I - 1)
              NEXT J
              GET (StartX2 + 1, StartY2 + (I - 1) * BlockHeight)-(StartX2 + GridWidth * BlockWidth, StartY2 + (I) * BlockHeight - 1), OneLine
              PUT (StartX2 + 1, StartY + (I - 2) * BlockHeight), OneLine, PSET
            NEXT I
            FOR J = 1 TO GridWidth
              IF J <> N THEN Grid2(J, GridHeight) = 1
            NEXT J
            I = 0
            FOR X = StartX2 + 1 TO EndX2 - BlockWidth STEP BlockWidth
              I = I + 1
              IF I <> N THEN
                DrawBlock X, EndY2 - BlockHeight, (C - 1) * 3 + 1
              ELSE
                LINE (X, EndY2 - BlockHeight)-(X + BlockWidth - 1, EndY2 - 1), 0, BF
              END IF
            NEXT X
          NEXT L
          IF NoMore THEN
            'PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
            IF GridY2 = 1 THEN CALL GameOver2: END
            CheckLines2 GridY2 - 1, Grid2(), Increase2
            GridX2 = 4: GridY2 = 1
            Block2 = NextBlock2: Cycle2 = 1
            Occur2(Block2) = Occur2(Block2) + 1
            'ShowOccurence
            NextBlock2 = INT(RND * 7) + 1
            ShapeArray = (NextBlock2 - 1) * 4 * Array + 1
            PUT (EndX + 18 + BlockWidth, 115 + BlockHeight), Shape(ShapeArray), PSET
            PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
            T2! = TIMER
          ELSE
            PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
            T2! = TIMER
          END IF
        END IF
        GridX = 4: GridY = 1
        Block = NextBlock: Cycle = 1
        Occur(Block) = Occur(Block) + 1
        NumBlocks& = NumBlocks& + 1
        'ShowOccurence
        NextBlock = INT(RND * 7) + 1
        ShapeArray = (NextBlock - 1) * 4 * Array + 1
        PUT (EndX + 18 + BlockWidth, 30 + BlockHeight), Shape(ShapeArray), PSET
        T! = TIMER
        'ClearKeyBoard
RETURN
PlaceBlock2:
        InitDrop2 = False
        GridY2 = GridY2 - 1
        PutInGrid Block2, Cycle2, GridX2, GridY2, Grid2()
        PutBlock StartX2 + (GridX2 - 1) * BlockWidth + 1, (GridY2 - 1) * BlockHeight + 1, Block2, Cycle2
        IF GridY2 = 1 THEN CALL GameOver2: END
        CheckLines2 GridY2 - 1, Grid2(), Increase
        IF Increase AND Competitive THEN
          PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
          N = RND * GridWidth + 1
          C = RND * 7 + 1
          NoMore = False
          FOR L = 2 TO Increase
            IF NoMore = False THEN
              CheckFit NoFit, Block, Cycle, GridX, GridY, Grid()
              GridY = GridY - 1
              IF NoFit THEN
                PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
                PutInGrid Block, Cycle, GridX, GridY, Grid()
                NoMore = True
              END IF
            END IF
            FOR I = 2 TO GridHeight
              FOR J = 1 TO GridWidth
                SWAP Grid(J, I), Grid(J, I - 1)
              NEXT J
              GET (StartX + 1, StartY + (I - 1) * BlockHeight)-(StartX + GridWidth * BlockWidth, StartY + (I) * BlockHeight - 1), OneLine
              PUT (StartX + 1, StartY + (I - 2) * BlockHeight), OneLine, PSET
            NEXT I
            FOR J = 1 TO GridWidth
              IF J <> N THEN Grid(J, GridHeight) = 1
            NEXT J
            I = 0
            FOR X = StartX + 1 TO EndX - BlockWidth STEP BlockWidth
              I = I + 1
              IF I <> N THEN
                DrawBlock X, EndY - BlockHeight, (C - 1) * 3 + 1
              ELSE
                LINE (X, EndY - BlockHeight)-(X + BlockWidth - 1, EndY - 1), 0, BF
              END IF
            NEXT X
          NEXT L
          IF NoMore THEN
            IF GridY = 1 THEN CALL GameOver: END
            CheckLines GridY - 1, Grid(), Increase2
            GridX = 4: GridY = 1
            Block = NextBlock: Cycle = 1
            NextBlock = INT(RND * 7) + 1
            ShapeArray = (NextBlock - 1) * 4 * Array + 1
            PUT (EndX + 18 + BlockWidth, 115 + BlockHeight), Shape(ShapeArray), PSET
            PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
            T! = TIMER
          ELSE
            PutBlock StartX + (GridX - 1) * BlockWidth + 1, (GridY - 1) * BlockHeight + 1, Block, Cycle
            T! = TIMER
          END IF
        END IF
        GridX2 = 4: GridY2 = 1
        Block2 = NextBlock2: Cycle2 = 1
        NextBlock2 = INT(RND * 7) + 1
        ShapeArray = (NextBlock2 - 1) * 4 * Array + 1
        PUT (EndX + 18 + BlockWidth, 115 + BlockHeight), Shape(ShapeArray), PSET
        T2! = TIMER
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
FUNCTION AtBottom% (Block, Cycle, GridX, GridY, Grid())
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

SUB CheckFit (NoFit, Block, Cycle, GridX, GridY, Grid() AS INTEGER)
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

SUB CheckLines (GridY, Grid(), Increase)
'*********************************************************
' Function: Check if user has any lines completed
'           Starts from bottom up until GridY is reached.
'  Display: Removes line and displays scores and stats
'  Returns: None
'*********************************************************

REDIM Well(20000) AS INTEGER   ' Depends on your GridWidth/BlockWidth, etc.

Increase = 0            '' Increases only if more than 1 line completed
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
    'Pause .15
    LINE (StartX + 1, StartY + (Y - 1) * BlockHeight)-(StartX + GridWidth * BlockWidth, StartY + Y * BlockHeight - 1), 0, BF
    PUT (StartX + 1, StartY + BlockHeight), Well, PSET
    PushDown Y, Grid()
    Y = Y + 1
  END IF
  Y = Y - 1
LOOP UNTIL Y = GridY - 1
     
'' Display all relevant scores and statistics.
IF NumLines > TempLines THEN '' If player has at least one line filled
  '' Display number of lines eliminated
  A$ = LTRIM$(STR$(NumLines))
  A$ = STRING$(3 - LEN(A$), "0") + A$
  LINE (EndX + 62, 70)-(EndX + 87, 77), 23, BF
  OFont A$, EndX + 62, 70, 1, 3
  '' More than one line completed, so throw that to the other player
  IF NumLines - TempLines > 1 THEN
    Increase = NumLines - TempLines
  END IF
  '' Number of lines left until next level reached
  IF NumLines >= LinesLeft THEN
    LinesLeft = LinesLeft + NextLevel
    Level! = Level! + 1
    Delay! = Delay! - Decr!
    IF Delay! < .02 THEN Delay! = .018
    IF Competitive THEN
      LinesLeft2 = LinesLeft2 + NextLevel
      Level2! = Level!
      Delay2! = Delay!
      IF Delay2! < .02 THEN Delay2! = .018
    END IF
  END IF
END IF

ERASE Well

END SUB

SUB CheckLines2 (GridY, Grid2(), Increase)
'*********************************************************
' Function: Check if user has any lines completed
'           Starts from bottom up until GridY is reached.
'  Display: Removes line and displays scores and stats
'  Returns: None
'*********************************************************

REDIM Well(20000) AS INTEGER   ' Depends on your GridWidth/BlockWidth, etc.

Increase = 0
Y = GridHeight          '' Start from bottom up
TempLines = NumLines2    '' Used as an indicator to how many lines completed
DO
  NoLine = False
  FOR J = 1 TO GridWidth
    IF Grid2(J, Y) = 0 THEN NoLine = True: EXIT FOR
  NEXT J
  IF NoLine = False THEN
    FOR J = 1 TO GridWidth
      DrawBlock StartX2 + (J - 1) * BlockWidth + 1, StartY2 + (Y - 1) * BlockHeight, 22
    NEXT J
    GET (StartX2 + 1, StartY2)-(StartX2 + GridWidth * BlockWidth, StartY2 + (Y - 1) * BlockHeight - 1), Well
    'Pause .15
    LINE (StartX2 + 1, StartY2 + (Y - 1) * BlockHeight)-(StartX2 + GridWidth * BlockWidth, StartY2 + Y * BlockHeight - 1), 0, BF
    PUT (StartX2 + 1, StartY2 + BlockHeight), Well, PSET
    PushDown2 Y, Grid2()
    Y = Y + 1
  END IF
  Y = Y - 1
LOOP UNTIL Y = GridY2 - 1

'' Display all relevant scores and statistics.
IF NumLines2 > TempLines THEN '' If player has at least one line filled
  '' Display number of lines eliminated
  A$ = LTRIM$(STR$(NumLines2))
  A$ = STRING$(3 - LEN(A$), "0") + A$
  LINE (EndX + 62, 155)-(EndX + 87, 162), 23, BF
  OFont A$, EndX + 62, 155, 1, 3
  IF NumLines2 - TempLines > 1 THEN
    Increase = NumLines2 - TempLines
  END IF
  '' Number of lines left until next level reached
  IF NumLines2 >= LinesLeft2 THEN
    LinesLeft2 = LinesLeft2 + NextLevel
    Level2! = Level2! + 1
    Delay2! = Delay2! - Decr!
    IF Delay2! < .02 THEN Delay2! = .018
    IF Competitive THEN
      LinesLeft = LinesLeft + NextLevel
      Level! = Level2!
      Delay! = Delay2!
      IF Delay! < .02 THEN Delay! = .018
    END IF
  END IF
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
OFont "GAME OVER", StartX + 15, 1, 1, 3

FOR Y = StartY TO EndY - BlockHeight STEP BlockHeight
  Pause .018
  FOR X = StartX + 1 TO EndX - BlockWidth STEP BlockWidth
    DrawBlock X, Y, 22
  NEXT X
NEXT Y

END SUB

SUB GameOver2

SLEEP 1

LINE (StartX2 + 1, 0)-(StartX2 + 10 * BlockWidth, StartY2), 0, BF
OFont "GAME OVER", StartX2 + 15, 1, 1, 3

FOR Y = StartY2 TO EndY2 - BlockHeight STEP BlockHeight
  Pause .018
  FOR X = StartX2 + 1 TO EndX2 - BlockWidth STEP BlockWidth
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

FUNCTION MultiKey (KEYNUM)

 STATIC FIRSTIME, KEYS(), SC(), DU()

 IF FIRSTIME = 0 THEN
  DIM KEYS(0 TO 255), SC(0 TO 255), DU(0 TO 255)
  FOR E = 0 TO 127              '\
  SC(E) = E: DU(E) = 1          '|
  NEXT                          '|-ERIC CARR'S CODE--------------------\
  FOR E = 128 TO 255            '|                                     |
  SC(E) = E - 128: DU(E) = 0    '|                                     |
  NEXT                          '/                                     |
  FIRSTIME = -1                 '                                      |
 END IF
 ClearKeyBoard
 'I$ = INKEY$       ' So the keyb buffer don't get full     \routine/ \ |
 I = INP(&H60)     ' Get keyboard scan code from port 60h   \lines/  |-/
 OUT &H61, INP(&H61) OR &H82: OUT &H20, &H20       '         \!!!/   |
 KEYS(SC(I)) = DU(I) ' This says what keys are pressed        \!/    /

MultiKey = KEYS(KEYNUM)

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

SUB PushDown (LineY, Grid())
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

END SUB

SUB PushDown2 (LineY, Grid2())
' Function: Clear LineY from grid, update numlines and score

  FOR J = 1 TO GridWidth
    Grid2(J, LineY) = 0
  NEXT J

  FOR I = LineY TO 2 STEP -1
    FOR J = 1 TO GridWidth
      SWAP Grid2(J, I), Grid2(J, I - 1)
    NEXT J
  NEXT I
  NumLines2 = NumLines2 + 1

END SUB

SUB PutBlock (X, Y, Block, Cycle)
' Function: Place Block at X,Y

   ShapeArray = (Block - 1) * 4 * Array + 1 + ((Cycle - 1) * Array)
   IF Y > 0 THEN
     PUT (X, Y), Shape(ShapeArray), XOR   '' Overlap is okay
   END IF

END SUB

SUB PutInGrid (Block, Cycle, GridX, GridY, Grid())
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

END SUB

SUB RotatePiece (Grid(), Block, Cycle, GridX, GridY, Char)
     
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
          CheckFit NoFit, Block, Cycle, GridX, GridY - 1, Grid()
        END IF
      IF NoFit THEN     '' Cannot rotate, so restore previous values
        Cycle = TempCycle
        GridX = TempX
        GridY = TempY
      END IF

END SUB

SUB SetupScreen
' Function: Create gameplay screen

LINE (0, 0)-(StartX - 2, 199), 23, BF
LINE (EndX + 2, 0)-(StartX2 - 2, 199), 23, BF
LINE (0, EndY + 2)-(EndX + 1, 199), 23, BF
LINE (0, 0)-(StartX - 2, 0), 25
LINE (0, 0)-(0, 199), 25
LINE (StartX, EndY + 2)-(EndX + 1, EndY + 2), 25
LINE (EndX + 2, 0)-(EndX + 2, EndY + 2), 25
LINE (EndX + 2, 0)-(StartX2 - 2, 0), 25
LINE (StartX - 2, 1)-(StartX - 2, EndY + 2), 24
LINE (0, 199)-(319, 199), 24
LINE (319, 1)-(319, 199), 24

LINE (StartX, StartY)-(StartX, EndY), 24
LINE (StartX, EndY)-(EndX, EndY), 24
LINE (EndX, StartY)-(EndX, EndY), 24

LINE (EndX + 18, 30)-(EndX + 18 + 6 * BlockWidth, 30 + 4 * BlockHeight), 0, BF
LINE (EndX + 18, 30)-(EndX + 18 + 6 * BlockWidth, 30 + 4 * BlockHeight), 25, B
LINE (EndX + 18, 30)-(EndX + 18 + 6 * BlockWidth, 30), 24
LINE (EndX + 18, 30)-(EndX + 18, 30 + 4 * BlockHeight), 24

OFont "Lines:", EndX + 8, 70, 22, 24
OFont "000", EndX + 62, 70, 1, 3

' Player Two

LINE (StartX2 - 1, EndY2 + 2)-(318, 198), 23, BF
LINE (EndX2 + 2, 1)-(318, 198), 23, BF
LINE (StartX2 - 2, 1)-(StartX2 - 2, EndY2 + 2), 24
LINE (StartX2, EndY2 + 2)-(EndX2 + 1, EndY2 + 2), 25
LINE (EndX2 + 2, 0)-(EndX2 + 2, EndY2 + 2), 25
LINE (EndX2 + 2, 0)-(319, 0), 25

LINE (StartX2, StartY2)-(StartX2, EndY2), 24
LINE (StartX2, EndY2)-(EndX2, EndY2), 24
LINE (EndX2, StartY2)-(EndX2, EndY2), 24

LINE (EndX + 18, 115)-(EndX + 18 + 6 * BlockWidth, 115 + 4 * BlockHeight), 0, BF
LINE (EndX + 18, 115)-(EndX + 18 + 6 * BlockWidth, 115 + 4 * BlockHeight), 25, B
LINE (EndX + 18, 115)-(EndX + 18 + 6 * BlockWidth, 115), 24
LINE (EndX + 18, 115)-(EndX + 18, 115 + 4 * BlockHeight), 24

OFont "Lines:", EndX + 8, 155, 22, 24
OFont "000", EndX + 62, 155, 1, 3

OFont "YA!", EndX + 9, 3, 1, 3
OFont "TETRIS", EndX + 37, 3, 10, 12

OFont "PLAYER 1", EndX + 20, 20, 7, 9
OFont "", EndX + 8, 20, 4, 6

OFont "PLAYER 2", EndX + 9, 105, 7, 9
OFont "", EndX + 78, 105, 4, 6

END SUB

