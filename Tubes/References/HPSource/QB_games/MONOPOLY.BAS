' ***************************************************************************
' ***                             Monopoly                                ***
' ***           based on the popular Parker Brothers board game           ***
' ***************************************************************************

' declare some subroutines and functions
DECLARE SUB shareware ()
DECLARE SUB Auction (pl%, pr%)
DECLARE SUB Buzz ()
DECLARE SUB centermain (text$)
DECLARE FUNCTION Chance (pl%)
DECLARE FUNCTION Chest (pl%)
DECLARE SUB ClearBuffer ()
DECLARE SUB ClearMain ()
DECLARE SUB ClearSub ()
DECLARE SUB CreateFile ()
DECLARE SUB DashBoard ()
DECLARE SUB Delay (hl!)
DECLARE SUB InitPlayer (pl%)
DECLARE FUNCTION LandOnAny (pl%, pr%)
DECLARE SUB LandOnProp (pl%, pr%)
DECLARE SUB LightUp (pl%, pr%, row%, col%)
DECLARE SUB LoadGame ()
DECLARE SUB MovePiece (amount%, square%, pl%)
DECLARE SUB SaveGame ()
DECLARE SUB ShowHouses ()
DECLARE SUB TitleDeed (prop%)
DECLARE SUB ThreeRR (x%, y%, z%)
DECLARE SUB TwoRR (x%, y%)
DECLARE SUB Update ()
DECLARE SUB Utilities (pl%)
DECLARE SUB WaitForKey ()
DECLARE SUB Winner (pl%)
DECLARE FUNCTION ArrayIndex% (square%)
DECLARE FUNCTION Character$ ()
DECLARE FUNCTION ConvBlock% (row%, column%, colormem%)
DECLARE FUNCTION ConvColor% (fore%, back%)
DECLARE FUNCTION DiceRoll% ()
DECLARE FUNCTION Digit% ()
DECLARE FUNCTION HouseChar$ (squ%)
DECLARE FUNCTION Opponent% (turn%)
DECLARE FUNCTION PieceMem% (sq%, pl%, colormem%)
DECLARE FUNCTION RandomNum% (min%, max%)
DECLARE FUNCTION ZeroFix$ (num%, amt%)

' define some constants
CONST TRUE = -1
CONST FALSE = 0
CONST DPURPLE = 5
CONST CYAN = 3
CONST LPURPLE = 13
CONST ORANGE = 12
CONST RED = 4
CONST YELLOW = 14
CONST GREEN = 2
CONST BLUE = 1
CONST RRSQUARE = 7
CONST UTILSQUARE = 15
CONST OTHER = 6
CONST BANK = 0
CONST GROUP = 1
CONST RR = 2
CONST UTIL = 3
CONST MAXDOUBLE = 3
CONST MAXSPACE = 40
CONST GO = -2
CONST COMM = -3
CONST INC = -4
CONST CHA = -5
CONST VIS = -6
CONST FREE = -7
CONST GOT = -8
CONST LUX = -9
CONST FPROP = 112 + 1
CONST FPLAY = 18

COMMON trash$
COMMON turn%
COMMON roll%
COMMON Houses%, hotels%

CLS

'This Program Is Shareware
shareware
SLEEP 5

' set up error catcher
ON ERROR GOTO ErrorTrap

' define some data types
TYPE property
  Title AS STRING * 20
  Short AS STRING * 3
  Cost AS INTEGER
  Rent AS INTEGER
  House1 AS INTEGER
  House2 AS INTEGER
  House3 AS INTEGER
  House4 AS INTEGER
  Hotel AS INTEGER
  HouseCost AS INTEGER
  MortValue AS INTEGER
  Style AS INTEGER
  Colour AS INTEGER
  Position AS INTEGER
  Houses AS INTEGER
  Monopoly AS INTEGER
  Owner AS INTEGER
  Mortgaged AS INTEGER
END TYPE
TYPE Player
  ID AS STRING * 8
  Piece AS STRING * 1
  Money AS INTEGER
  ChanceFree AS INTEGER
  ChestFree AS INTEGER
  Position AS INTEGER
  JailCount AS INTEGER
END TYPE

' declare some arrays and shared variables
DIM SHARED Deed(1 TO 28)  AS property
FOR c% = 1 TO 28
  READ Deed(c%).Title
  READ Deed(c%).Short
  READ Deed(c%).Cost
  READ Deed(c%).Rent
  READ Deed(c%).House1
  READ Deed(c%).House2
  READ Deed(c%).House3
  READ Deed(c%).House4
  READ Deed(c%).Hotel
  READ Deed(c%).HouseCost
  Deed(c%).MortValue = Deed(c%).Cost / 2
  READ Deed(c%).Style
  READ Deed(c%).Colour
  READ Deed(c%).Position
  Deed(c%).Houses = 0
  Deed(c%).Monopoly = FALSE
  Deed(c%).Owner = BANK
  Deed(c%).Mortgaged = FALSE
NEXT c%
DATA "Mediterranean Ave.", "MED", 60, 2, 10, 30, 90, 160, 250, 50, 1, 5, 1
DATA "Baltic Ave.", "BAL", 60, 4, 20, 60, 180, 320, 450, 50, 1, 5, 3
DATA "Reading Railroad", "REA", 200, -1, 25, 50, 100, 200, -1, -1, 2, 7, 5
DATA "Oriental Ave.", "ORI", 100, 6, 30, 90, 270, 400, 550, 50, 1, 3, 6
DATA "Vermont Ave.", "VER", 100, 6, 30, 90, 270, 400, 550, 50, 1, 3, 7
DATA "Connecticut Ave.", "CON", 120, 8, 40, 100, 300, 450, 600, 50, 1, 3, 9
DATA "St. Charles Place", "STC", 140, 10, 50, 150, 450, 625, 750, 100, 1, 13, 11
DATA "Electric Company", "ELE", 150, -1, 4, 10, -1, -1, -1, -1, 3, 15, 12
DATA "States Ave.", "STA", 140, 10, 50, 150, 450, 625, 750, 100, 1, 13, 13
DATA "Virginia Ave.", "VIR", 160, 12, 60, 180, 500, 700, 900, 100, 1, 13, 14
DATA "Pennsylvania R.R.", "PRR", 200, -1, 25, 50, 100, 200, -1, -1, 2, 7, 15
DATA "St. James Place", "STJ", 180, 14, 70, 200, 550, 750, 950, 100, 1, 12, 16
DATA "Tennessee Ave.", "TEN", 180, 14, 70, 200, 550, 750, 950, 100, 1, 12, 18
DATA "New York Ave.", "NEW", 200, 16, 80, 220, 600, 800, 1000, 100, 1, 12, 19
DATA "Kentucky Ave.", "KEN", 220, 18, 90, 250, 700, 875, 1050, 150, 1, 4, 21
DATA "Indiana Ave.", "IND", 220, 18, 90, 250, 700, 875, 1050, 150, 1, 4, 23
DATA "Illinois Ave.", "ILL", 240, 20, 100, 300, 750, 925, 1100, 150, 1, 4, 24
DATA "B. & O. Railroad", "B&O", 200, -1, 25, 50, 100, 200, -1, -1, 2, 7, 25
DATA "Atlantic Ave.", "ATL", 260, 22, 110, 330, 800, 975, 1150, 150, 1, 14, 26
DATA "Ventor Ave.", "VEN", 260, 22, 110, 330, 800, 975, 1150, 150, 1, 14, 27
DATA "Water Works", "WAT", 150, -1, 4, 10, -1, -1, -1, -1, 3, 15, 28
DATA "Marvin Gardens", "MAR", 280, 24, 120, 360, 850, 1025, 1200, 150, 1, 14, 29
DATA "Pacific Ave.", "PAC", 300, 26, 130, 390, 900, 1100, 1275, 200, 1, 2, 31
DATA "No. Carolina Ave.", "NOC", 300, 26, 130, 390, 900, 1100, 1275, 200, 1, 2, 32
DATA "Pennsylvania Ave.", "PEN", 320, 28, 150, 450, 1000, 1200, 1400, 200, 1, 2, 34
DATA "Short Line R.R.", "SHO", 200, -1, 25, 50, 100, 200, -1, -1, 2, 7, 35
DATA "Park Place", "PAR", 350, 35, 175, 500, 1100, 1300, 1500, 200, 1, 1, 37
DATA "Boardwalk", "BOA", 400, 50, 200, 600, 1400, 1700, 2000, 200, 1, 1, 39
DIM SHARED Stats(1 TO 2) AS Player
FOR c% = 1 TO 2
  Stats(c%).ID = SPACE$(8)
  Stats(c%).Piece = SPACE$(1)
  Stats(c%).Money = 1500
  Stats(c%).ChanceFree = FALSE
  Stats(c%).ChestFree = FALSE
  Stats(c%).Position = 0
  Stats(c%).JailCount = 0
NEXT c%

' set some settings
DEF SEG = &HB800
RANDOMIZE TIMER
KEY OFF
Houses% = 32
hotels% = 12
turn% = 0
trash% = Chest(0)
trash% = Chance(0)

' initialize game screen
COLOR 7, 0
CLS
PRINT "                                                        ³                       "
PRINT " FRE  KEN  CHA  IND  ILL  B&O  ATL  VEN  WAT  MAR  GOT  ³         :             "
PRINT "                                                        ³  MEDBAL ORIVENCON     "
PRINT " NEW  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  PAC  ³  STCSTAVIR STJTENNEW  "
PRINT "      ³SHAREWARE $5                $5 SHAREWARE ³       ³  KENINDILL ATLVENMAR  "
PRINT " TEN  ³                                         ³  NOC  ³  PACNOCPEN PARBOA     "
PRINT "      ³                                         ³       ³  REAPRRB&OSHO ELEWAT  "
PRINT " COM  ³                                         ³  COM  ³  *                 *  "
PRINT "      ³                                         ³       ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
PRINT " STJ  ³                                         ³  PEN  ³                       "
PRINT "      ³                                         ³       ³                       "
PRINT " PRR  ³                                         ³  SHO  ³                       "
PRINT "      ³                                         ³       ³                       "
PRINT " VIR  ³                                         ³  CHA  ³ ÚÄÄ¿ ÚÄÄ¿             "
PRINT "      ³                                         ³       ³ ³  ³+³  ³=            "
PRINT " STA  ³                                         ³  PAR  ³ ÀÄÄÙ ÀÄÄÙ             "
PRINT "      ³                                         ³       ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
PRINT " ELE  ³                                         ³  LUX  ³         :             "
PRINT "      ³SHAREWARE $5                 $5 SHAREWARE³       ³  MEDBAL ORIVENCON     "
PRINT " STC  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  BOA  ³  STCSTAVIR STJTENNEW  "
PRINT "                                                        ³  KENINDILL ATLVENMAR  "
PRINT " VIS  CON  VEN  CHA  ORI  REA  INC  BAL  COM  MED  ®GO  ³  PACNOCPEN PARBOA     "
PRINT "                                                        ³  REAPRRB&OSHO ELEWAT  "

POKE ConvBlock%(24, 57, 0), ASC("³")
POKE ConvBlock%(24, 57, 1), ConvColor%(7, 0)
POKE ConvBlock%(24, 60, 0), ASC("*")
POKE ConvBlock%(24, 60, 1), ConvColor%(7, 0)
POKE ConvBlock%(24, 78, 0), ASC("*")
POKE ConvBlock%(24, 78, 1), ConvColor%(7, 0)
POKE ConvBlock%(25, 57, 0), ASC("³")
t$ = "JAIL:               Houses:     Hotels:"
FOR c% = 1 TO LEN(t$)
  s$ = MID$(t$, c%, 1)
  POKE ConvBlock%(24, c%, 0), ASC(s$)
  POKE ConvBlock%(24, c%, 1), ConvColor%(7, 0)
NEXT c%

LOCATE 9, 1: centermain "MONOPOLY   v2.5"
COLOR 5
LOCATE 10, 1: centermain "1997 Brian Cole"
COLOR 7, 0
LOCATE 11, 1: centermain "Based on the Parker Brothers game."
DashBoard
FOR c% = 52 TO 54: POKE ConvBlock%(22, c%, 1), ConvColor%(6, 0): NEXT c%
FOR c% = 47 TO 49: POKE ConvBlock%(22, c%, 1), ConvColor%(DPURPLE, 0): NEXT c%
FOR c% = 42 TO 44: POKE ConvBlock%(22, c%, 1), ConvColor%(OTHER, 0): NEXT c%
FOR c% = 37 TO 39: POKE ConvBlock%(22, c%, 1), ConvColor%(DPURPLE, 0): NEXT c%
FOR c% = 32 TO 34: POKE ConvBlock%(22, c%, 1), ConvColor%(OTHER, 0): NEXT c%
FOR c% = 27 TO 29: POKE ConvBlock%(22, c%, 1), ConvColor%(RRSQUARE, 0): NEXT c%
FOR c% = 22 TO 24: POKE ConvBlock%(22, c%, 1), ConvColor%(CYAN, 0): NEXT c%
FOR c% = 17 TO 19: POKE ConvBlock%(22, c%, 1), ConvColor%(OTHER, 0): NEXT c%
FOR c% = 12 TO 14: POKE ConvBlock%(22, c%, 1), ConvColor%(CYAN, 0): NEXT c%
FOR c% = 7 TO 9: POKE ConvBlock%(22, c%, 1), ConvColor%(CYAN, 0): NEXT c%
FOR c% = 2 TO 4: POKE ConvBlock%(22, c%, 1), ConvColor%(OTHER, 0): NEXT c%
FOR c% = 2 TO 4: POKE ConvBlock%(20, c%, 1), ConvColor%(LPURPLE, 0): NEXT c%
FOR c% = 2 TO 4: POKE ConvBlock%(18, c%, 1), ConvColor%(UTILSQUARE, 0): NEXT c%
FOR c% = 2 TO 4: POKE ConvBlock%(16, c%, 1), ConvColor%(LPURPLE, 0): NEXT c%
FOR c% = 2 TO 4: POKE ConvBlock%(14, c%, 1), ConvColor%(LPURPLE, 0): NEXT c%
FOR c% = 2 TO 4: POKE ConvBlock%(12, c%, 1), ConvColor%(RRSQUARE, 0): NEXT c%
FOR c% = 2 TO 4: POKE ConvBlock%(10, c%, 1), ConvColor%(ORANGE, 0): NEXT c%
FOR c% = 2 TO 4: POKE ConvBlock%(8, c%, 1), ConvColor%(OTHER, 0): NEXT c%
FOR c% = 2 TO 4: POKE ConvBlock%(6, c%, 1), ConvColor%(ORANGE, 0): NEXT c%
FOR c% = 2 TO 4: POKE ConvBlock%(4, c%, 1), ConvColor%(ORANGE, 0): NEXT c%
FOR c% = 2 TO 4: POKE ConvBlock%(2, c%, 1), ConvColor%(OTHER, 0): NEXT c%
FOR c% = 7 TO 9: POKE ConvBlock%(2, c%, 1), ConvColor%(RED, 0): NEXT c%
FOR c% = 12 TO 14: POKE ConvBlock%(2, c%, 1), ConvColor%(OTHER, 0): NEXT c%
FOR c% = 17 TO 19: POKE ConvBlock%(2, c%, 1), ConvColor%(RED, 0): NEXT c%
FOR c% = 22 TO 24: POKE ConvBlock%(2, c%, 1), ConvColor%(RED, 0): NEXT c%
FOR c% = 27 TO 29: POKE ConvBlock%(2, c%, 1), ConvColor%(RRSQUARE, 0): NEXT c%
FOR c% = 32 TO 34: POKE ConvBlock%(2, c%, 1), ConvColor%(YELLOW, 0): NEXT c%
FOR c% = 37 TO 39: POKE ConvBlock%(2, c%, 1), ConvColor%(YELLOW, 0): NEXT c%
FOR c% = 42 TO 44: POKE ConvBlock%(2, c%, 1), ConvColor%(UTILSQUARE, 0): NEXT c%
FOR c% = 47 TO 49: POKE ConvBlock%(2, c%, 1), ConvColor%(YELLOW, 0): NEXT c%
FOR c% = 52 TO 54: POKE ConvBlock%(2, c%, 1), ConvColor%(OTHER, 0): NEXT c%
FOR c% = 52 TO 54: POKE ConvBlock%(4, c%, 1), ConvColor%(GREEN, 0): NEXT c%
FOR c% = 52 TO 54: POKE ConvBlock%(6, c%, 1), ConvColor%(GREEN, 0): NEXT c%
FOR c% = 52 TO 54: POKE ConvBlock%(8, c%, 1), ConvColor%(OTHER, 0): NEXT c%
FOR c% = 52 TO 54: POKE ConvBlock%(10, c%, 1), ConvColor%(GREEN, 0): NEXT c%
FOR c% = 52 TO 54: POKE ConvBlock%(12, c%, 1), ConvColor%(RRSQUARE, 0): NEXT c%
FOR c% = 52 TO 54: POKE ConvBlock%(14, c%, 1), ConvColor%(OTHER, 0): NEXT c%
FOR c% = 52 TO 54: POKE ConvBlock%(16, c%, 1), ConvColor%(BLUE, 0): NEXT c%
FOR c% = 52 TO 54: POKE ConvBlock%(18, c%, 1), ConvColor%(OTHER, 0): NEXT c%
FOR c% = 52 TO 54: POKE ConvBlock%(20, c%, 1), ConvColor%(BLUE, 0): NEXT c%

' set up the game
ClearSub
LOCATE 10, 59: PRINT "N to start new game"
LOCATE 11, 59: PRINT "L to load saved game"
LOCATE 12, 59: PRINT "X to exit"
DO
  respond$ = UCASE$(INKEY$)
LOOP UNTIL respond$ = "N" OR respond$ = "L" OR respond$ = "X"
IF respond$ = "X" THEN END
IF respond$ = "L" THEN LoadGame
IF respond$ = "N" OR Stats(1).ID = SPACE$(8) THEN
  InitPlayer 1
  InitPlayer 2
END IF
POKE PieceMem%(Stats(1).Position, 1, 0), ASC(Stats(1).Piece)
POKE PieceMem%(Stats(1).Position, 1, 1), ConvColor%(7, 0)
POKE PieceMem%(Stats(2).Position, 2, 0), ASC(Stats(2).Piece)
POKE PieceMem%(Stats(2).Position, 2, 1), ConvColor%(7, 0)

' who goes first?
ClearSub
IF turn% = 0 THEN
  LOCATE 10, 59: PRINT "Who goes first?"
  LOCATE 11, 59: PRINT "Let's flip for it!"
  LOCATE 12, 59: PRINT USING "&: HEADS"; Stats(1).ID
  LOCATE 13, 59: PRINT USING "&: TAILS"; Stats(2).ID
  SLEEP 2
  result% = RandomNum%(1, 2)
  ClearSub
  IF result% = 1 THEN
    LOCATE 10, 59: PRINT "HEADS!"
    LOCATE 11, 59: PRINT USING "& goes first_."; Stats(1).ID
    turn% = 1
  ELSE
    LOCATE 10, 59: PRINT "TAILS!"
    LOCATE 11, 59: PRINT USING "& goes first_."; Stats(2).ID
    turn% = 2
  END IF
ELSE
  LOCATE 10, 59: PRINT "The saved game says"
  LOCATE 11, 59: PRINT USING "that &"; Stats(turn%).ID
  LOCATE 12, 59: PRINT "goes first."
END IF
LOCATE 13, 59: PRINT "Any key to begin."
WaitForKey

' play the game
DO
  ClearMain
  ClearSub
  IF turn% = 1 THEN
    FOR c% = 59 TO 66: POKE ConvBlock%(2, c%, 1), ConvColor%(0, 7): NEXT c%
    FOR c% = 59 TO 66: POKE ConvBlock%(18, c%, 1), ConvColor%(7, 0): NEXT c%
  ELSE
    FOR c% = 59 TO 66: POKE ConvBlock%(2, c%, 1), ConvColor%(7, 0): NEXT c%
    FOR c% = 59 TO 66: POKE ConvBlock%(18, c%, 1), ConvColor%(0, 7): NEXT c%
  END IF
  IF Stats(turn%).Position = -1 THEN
    LOCATE 10, 59: PRINT "R to roll out"
    LOCATE 11, 59: PRINT "P to pay $50"
    IF Stats(turn%).ChanceFree = TRUE OR Stats(turn%).ChestFree = TRUE THEN getout% = TRUE ELSE getout% = FALSE
    IF getout% = TRUE THEN
      LOCATE 12, 59: PRINT "F to use Get Out Free"
    END IF
    DO
      opt$ = UCASE$(INKEY$)
    LOOP UNTIL opt$ = "R" OR opt$ = "P" OR (opt$ = "F" AND getout% = TRUE)
    ClearSub
    IF opt$ = "R" THEN
      Stats(turn%).JailCount = Stats(turn%).JailCount + 1
      LOCATE 10, 59: PRINT USING "Try # out of"; Stats(turn%).JailCount
      LOCATE 11, 59: PRINT "3 to roll."
      LOCATE 12, 59: PRINT "Any key to roll."
      LOCATE 15, 61: PRINT "?"
      LOCATE 15, 66: PRINT "?"
      LOCATE 15, 69: PRINT "??"
      WaitForKey
      die1% = RandomNum%(1, 6)
      die2% = RandomNum%(1, 6)
      LOCATE 15, 61: PRINT USING "#"; die1%
      LOCATE 15, 66: PRINT USING "#"; die2%
      total% = die1% + die2%
      LOCATE 15, 69: PRINT USING "##"; total%
      ClearSub
      IF die1% = die2% THEN
        LOCATE 10, 59: PRINT "Lucky!  Moving now."
        LOCATE 11, 59: PRINT "Any key to go."
        WaitForKey
        POKE PieceMem%(-1, turn%, 0), ASC(" ")
        POKE PieceMem%(-1, turn%, 1), ConvColor%(0, 0)
        Stats(turn%).Position = 10
        MovePiece total%, -1, turn%
        mover% = LandOnAny(turn%, Stats(turn%).Position)
        Stats(turn%).JailCount = 0
      ELSEIF Stats(turn%).JailCount < 3 THEN
        LOCATE 10, 59: PRINT "Too bad."
        LOCATE 11, 59: PRINT "O for options"
        LOCATE 13, 59: PRINT "Any other to go on"
        DO
          o$ = UCASE$(INKEY$)
        LOOP UNTIL o$ <> ""
        IF o$ = "O" THEN Utilities turn%
      ELSE
        WHILE Stats(turn%).Money < 50
          LOCATE 10, 59: PRINT "Too bad; you owe $50."
          LOCATE 11, 59: PRINT "You need more money!"
          LOCATE 12, 59: PRINT "O to get some"
          LOCATE 13, 59: PRINT "B for bankruptsy"
          DO
            o$ = UCASE$(INKEY$)
          LOOP UNTIL o$ <> ""
          IF o$ = "B" THEN Winner Opponent%(turn%)
          Utilities turn%
          ClearSub
        WEND
        Stats(turn%).Money = Stats(turn%).Money - 50
        DashBoard
        LOCATE 10, 59: PRINT "You ran out of tries"
        LOCATE 11, 59: PRINT "and had to pay $50."
        LOCATE 12, 59: PRINT "Any key to go on."
        WaitForKey
        Stats(turn%).Position = 10
        POKE PieceMem%(-1, turn%, 0), ASC(" ")
        POKE PieceMem%(-1, turn%, 1), ConvColor%(0, 0)
        MovePiece total%, -1, turn%
        mover% = LandOnAny(turn%, Stats(turn%).Position)
        Stats(turn%).JailCount = 0
      END IF
    ELSEIF opt$ = "P" THEN
      WHILE Stats(turn%).Money < 50
        LOCATE 10, 59: PRINT "You owe $50."
        LOCATE 11, 59: PRINT "You need more money!"
        LOCATE 12, 59: PRINT "Any key to get some, or"
        LOCATE 13, 59: PRINT "B for bankruptsy"
        DO
          o$ = UCASE$(INKEY$)
        LOOP UNTIL o$ <> ""
        IF o$ = "B" THEN Winner Opponent%(turn%)
        Utilities turn%
        ClearSub
      WEND
      Stats(turn%).Money = Stats(turn%).Money - 50
      DashBoard
      LOCATE 10, 59: PRINT "You paid $50."
      LOCATE 11, 59: PRINT "Any key to roll."
      LOCATE 15, 61: PRINT "?"
      LOCATE 15, 66: PRINT "?"
      LOCATE 15, 69: PRINT "??"
      WaitForKey
      die1% = RandomNum%(1, 6)
      die2% = RandomNum%(1, 6)
      LOCATE 15, 61: PRINT USING "#"; die1%
      LOCATE 15, 66: PRINT USING "#"; die2%
      total% = die1% + die2%
      LOCATE 15, 69: PRINT USING "##"; total%
      ClearSub
      POKE PieceMem%(-1, turn%, 0), ASC(" ")
      POKE PieceMem%(-1, turn%, 1), ConvColor%(0, 0)
      Stats(turn%).Position = 10
      MovePiece total%, -1, turn%
      mover% = LandOnAny(turn%, Stats(turn%).Position)
      Stats(turn%).JailCount = 0
    ELSE
      IF Stats(turn%).ChanceFree = TRUE THEN
        Stats(turn%).ChanceFree = FALSE
      ELSE
        Stats(turn%).ChestFree = FALSE
      END IF
      DashBoard
      LOCATE 10, 59: PRINT "You're out of Jail!"
      LOCATE 11, 59: PRINT "Any key to roll."
      LOCATE 15, 61: PRINT "?"
      LOCATE 15, 66: PRINT "?"
      LOCATE 15, 69: PRINT "??"
      WaitForKey
      die1% = RandomNum%(1, 6)
      die2% = RandomNum%(1, 6)
      LOCATE 15, 61: PRINT USING "#"; die1%
      LOCATE 15, 66: PRINT USING "#"; die2%
      total% = die1% + die2%
      LOCATE 15, 69: PRINT USING "##"; total%
      ClearSub
      POKE PieceMem%(-1, turn%, 0), ASC(" ")
      POKE PieceMem%(-1, turn%, 1), ConvColor%(0, 0)
      Stats(turn%).Position = 10
      MovePiece total%, -1, turn%
      mover% = LandOnAny(turn%, Stats(turn%).Position)
      Stats(turn%).JailCount = 0
    END IF
  ELSE
    olddub% = 0
    doubles% = 0
    DO
      IF doubles% > olddub% THEN olddub% = olddub% + 1
      DO
        mover% = DiceRoll%
      LOOP UNTIL mover% <> 0
      ClearSub
      IF mover% = -1 THEN
        LOCATE 10, 59: PRINT "Three doubles!  You"
        LOCATE 11, 59: PRINT "are thrown in Jail!"
        MovePiece -1, -1, turn%
        LOCATE 12, 59: PRINT "O for options"
        LOCATE 13, 59: PRINT "Any other to go on"
        doubles% = 0
        olddub% = 0
        DO
          o$ = UCASE$(INKEY$)
        LOOP UNTIL o$ <> ""
        IF o$ = "O" THEN Utilities turn%
      ELSE
        MovePiece mover%, -1, turn%
        mover% = LandOnAny(turn%, Stats(turn%).Position)
        IF mover% <> -2 THEN Stats(turn%).Position = mover%
      END IF
    LOOP WHILE doubles% > olddub% AND Stats(turn%).Position <> -1
  END IF
  ShowHouses
  
  turn% = Opponent%(turn%)
LOOP

' error catcher
ErrorTrap:
IF ERR = 54 THEN
  KILL "MONOPOLY.SAV"
  RESUME
ELSE
  BEEP
  CLS
  PRINT USING "The program has encountered an unknown error (code ###) during normal"; ERR
  PRINT "execution (by no fault of your own).  Because the program was not designed"
  PRINT "to handle this error, execution must end.  However, all is not lost!  Please"
  PRINT "notify the author, Brian Cole, about this problem as described below."
  PRINT "When you have copied the necessary information, press any key to end."
  PRINT
  PRINT "E-MAIL INSTRUCTIONS:"
  PRINT "If on America Online, send to pirhana 12 -- if on the Internet, pirhana 12@aol.com"
  PRINT
  PRINT "Please, in the subject line, type `MONOPOLY.BAS Error'.  Describe what you"
  PRINT "were doing when this happened, and give the error code number.  An apology"
  PRINT "or steps for corrective action will be replied.  "
  PRINT "I will debug the program and send a fixed copy to you, as well as posting it."
  WaitForKey
  END
END IF

' figures out the array index of the specified square, or code for other
'   non-ownable square
FUNCTION ArrayIndex% (square%)
  SELECT CASE square%
  CASE 0
    ArrayIndex% = GO
  CASE 1
    ArrayIndex% = 1
  CASE 2
    ArrayIndex% = COMM
  CASE 3
    ArrayIndex% = 2
  CASE 4
    ArrayIndex% = INC
  CASE 5
    ArrayIndex% = 3
  CASE 6
    ArrayIndex% = 4
  CASE 7
    ArrayIndex% = CHA
  CASE 8
    ArrayIndex% = 5
  CASE 9
    ArrayIndex% = 6
  CASE 10
    ArrayIndex% = VIS
  CASE 11
    ArrayIndex% = 7
  CASE 12
    ArrayIndex% = 8
  CASE 13
    ArrayIndex% = 9
  CASE 14
    ArrayIndex% = 10
  CASE 15
    ArrayIndex% = 11
  CASE 16
    ArrayIndex% = 12
  CASE 17
    ArrayIndex% = COMM
  CASE 18
    ArrayIndex% = 13
  CASE 19
    ArrayIndex% = 14
  CASE 20
    ArrayIndex% = FREE
  CASE 21
    ArrayIndex% = 15
  CASE 22
    ArrayIndex% = CHA
  CASE 23
    ArrayIndex% = 16
  CASE 24
    ArrayIndex% = 17
  CASE 25
    ArrayIndex% = 18
  CASE 26
    ArrayIndex% = 19
  CASE 27
    ArrayIndex% = 20
  CASE 28
    ArrayIndex% = 21
  CASE 29
    ArrayIndex% = 22
  CASE 30
    ArrayIndex% = GOT
  CASE 31
    ArrayIndex% = 23
  CASE 32
    ArrayIndex% = 24
  CASE 33
    ArrayIndex% = COMM
  CASE 34
    ArrayIndex% = 25
  CASE 35
    ArrayIndex% = 26
  CASE 36
    ArrayIndex% = CHA
  CASE 37
    ArrayIndex% = 27
  CASE 38
    ArrayIndex% = LUX
  CASE 39
    ArrayIndex% = 28
  END SELECT
END FUNCTION

' auctions off a property
SUB Auction (pl%, pr%)
  SHARED Deed() AS property, Stats() AS Player
  TitleDeed pr%
  ClearSub
  ClearBuffer
  LOCATE 10, 59: PRINT USING "& auctions off"; Stats(pl%).ID
  LOCATE 11, 59: PRINT Deed(pr%).Title
  LOCATE 12, 59: PRINT "Any key to start."
  WaitForKey
  ClearSub
  bid% = 0
  bidder% = FALSE
  DO
    LOCATE 10, 59: PRINT USING "&: Bid starts"; Stats(pl%).ID
    LOCATE 11, 59: PRINT "at $20.  Bid?"
    LOCATE 12, 59: PRINT "(O for options)"
    opt$ = UCASE$(INKEY$)
    IF opt$ = "O" THEN
      Utilities pl%
      TitleDeed (pr%)
      ClearSub
    END IF
    IF opt$ = "Y" AND Stats(pl%).Money < 20 THEN Buzz
  LOOP UNTIL (opt$ = "Y" AND Stats(pl%).Money >= 20) OR opt$ = "N"
  ClearSub
  IF opt$ = "N" THEN
    DO
      LOCATE 10, 59: PRINT USING "&: Bid starts"; Stats(Opponent%(pl%)).ID
      LOCATE 11, 59: PRINT "at $20.  Bid?"
      LOCATE 12, 59: PRINT "(O for options)"
      op$ = UCASE$(INKEY$)
      IF op$ = "O" THEN
        Utilities Opponent%(pl%)
        TitleDeed (pr%)
        ClearSub
      END IF
      IF op$ = "Y" AND Stats(pl%).Money < 20 THEN Buzz
    LOOP UNTIL (op$ = "Y" AND Stats(Opponent%(pl%)).Money >= 20) OR op$ = "N"
    ClearSub
    IF op$ = "N" THEN
      LOCATE 10, 59: PRINT Deed(pr%).Title
      LOCATE 11, 59: PRINT "goes unbought"
      SLEEP 3
      EXIT SUB
    ELSE
      bid% = 20
      bidder% = Opponent%(pl%)
    END IF
  ELSE
    bid% = 20
    bidder% = pl%
  END IF
  DO
    ClearSub
    LOCATE 10, 59: PRINT USING "&: the bid is"; Stats(Opponent%(bidder%)).ID
    LOCATE 11, 59: PRINT USING "now at $$##_.  Bid?"; bid% + 20
    LOCATE 12, 59: PRINT "(O for options)"
    DO
      huh$ = UCASE$(INKEY$)
      IF huh$ = "O" THEN Utilities Opponent%(bidder%)
      IF huh$ = "Y" AND Stats(Opponent%(bidder%)).Money < bid% + 20 THEN Buzz
    LOOP UNTIL (huh$ = "Y" AND Stats(Opponent%(bidder%)).Money >= bid% + 20) OR huh$ = "N"
    IF huh$ = "Y" THEN
      bid% = bid% + 20
      bidder% = Opponent%(bidder%)
    END IF
  LOOP UNTIL huh$ = "N"
  ClearSub
  LOCATE 10, 59: PRINT USING "&: you got it_!"; Stats(bidder%).ID
  IF bid% > Deed(pr%).Cost THEN
    LOCATE 11, 59: PRINT USING "You overpaid $$##_."; bid% - Deed(pr%).Cost
  ELSEIF bid% < Deed(pr%).Cost THEN
    LOCATE 11, 59: PRINT USING "You saved $$##_."; Deed(pr%).Cost - bid%
  ELSE
    LOCATE 11, 59: PRINT USING "You paid exactly $$##_."; bid%
  END IF
  Stats(bidder%).Money = Stats(bidder%).Money - bid%
  Deed(pr%).Owner = bidder%
  DashBoard
END SUB

' makes a buzzing sound when a cash error is attempted
SUB Buzz
  SOUND 100, 5
END SUB

' centers text in the main viewport
SUB centermain (text$)
  blanks% = 8 + (INT(((48 - 8) - LEN(text$)) / 2))
  LOCATE CSRLIN, blanks%: PRINT text$
END SUB

' draws and uses a card from the Chance Card deck
FUNCTION Chance (pl%)
  SHARED Deed() AS property, Stats() AS Player
  STATIC chcard%
  IF pl% = 0 THEN
    chcard% = RandomNum(1, 16)
  ELSEIF pl% < 0 THEN
    chcard% = ABS(pl%)
  END IF
  IF pl% <= 0 THEN EXIT FUNCTION
  ClearMain
  ClearSub
  IF chcard% = 0 THEN chcard% = 1
  LOCATE 5, 1: centermain "CHANCE CARD"
  IF chcard% = 1 OR (chcard% = 16 AND (Stats(1).ChanceFree = TRUE OR Stats(2).ChanceFree = TRUE)) THEN
    LOCATE 7, 1: centermain "Advance to Go."
    LOCATE 8, 1: centermain "(collect $200)"
    LOCATE 10, 59: PRINT "Press any key"
    LOCATE 11, 59: PRINT "to go on."
    WaitForKey
    MovePiece -1, 0, pl%
    LOCATE 10, 59: PRINT "You are on Go."
    LOCATE 11, 59: PRINT "You earned $200."
    IF chcard% = 16 THEN chcard% = chcard% + 1
    Chance = 0
  ELSEIF chcard% = 2 THEN
    LOCATE 7, 1: centermain "Your building and loan matures."
    LOCATE 8, 1: centermain "Collect $150"
    Stats(pl%).Money = Stats(pl%).Money + 150
    DashBoard
    LOCATE 10, 59: PRINT "You earned $150."
    Chance = -2
  ELSEIF chcard% = 3 OR chcard% = 13 THEN
    LOCATE 7, 1: centermain "Advance token to the nearest Railroad"
    LOCATE 8, 1: centermain "and pay owner twice to which he is"
    LOCATE 9, 1: centermain "otherwise entitled.  If Railroad is"
    LOCATE 10, 1: centermain "unowned, you may buy it from the bank."
    LOCATE 10, 59: PRINT "Press any key."
    WaitForKey
    IF Stats(pl%).Position > 5 AND Stats(pl%).Position < 15 THEN
      dest% = 15
      Chance = 15
    ELSEIF Stats(pl%).Position > 15 AND Stats(pl%).Position < 25 THEN
      dest% = 25
      Chance = 25
    ELSEIF Stats(pl%).Position > 25 AND Stats(pl%).Position < 35 THEN
      dest% = 35
      Chance = 35
    ELSE
      dest% = 5
      Chance = 5
    END IF
    MovePiece -1, dest%, pl%
    ClearSub
    lo% = ArrayIndex%(dest%)
    IF Deed(lo%).Owner = BANK OR Deed(lo%).Owner = pl% THEN
      LandOnProp pl%, lo%
    ELSE
      payup% = (Deed(lo%).Houses * 25) * 2
      TitleDeed lo%
      WHILE Stats(pl%).Money < payup%
        LOCATE 10, 59: PRINT "You need more money!"
        LOCATE 11, 59: PRINT "O to get some"
        LOCATE 12, 59: PRINT "B for bankruptsy."
        DO
          b$ = UCASE$(INKEY$)
        LOOP UNTIL b$ <> "O" OR b$ = "B"
        IF b$ = "B" THEN Winner Opponent%(pl%)
        Utilities pl%
      WEND
      ClearSub
      Stats(pl%).Money = Stats(pl%).Money - payup%
      Stats(Opponent%(pl%)).Money = Stats(Opponent%(pl%)).Money + payup%
      LOCATE 10, 59: PRINT USING "You paid & $$##_."; Stats(Opponent%(pl%)).ID; payup%
    END IF
  ELSEIF chcard% = 4 THEN
    LOCATE 7, 1: centermain "Bank pays you dividend of $50."
    Stats(pl%).Money = Stats(pl%).Money + 50
    LOCATE 10, 59: PRINT "You earned $50."
    Chance = -2
  ELSEIF chcard% = 5 THEN
    LOCATE 7, 1: centermain "Take a walk on the Board Walk."
    LOCATE 8, 1: centermain "Advance token to Boardwalk."
    LOCATE 10, 59: PRINT "Press any key"
    LOCATE 11, 59: PRINT "to go on."
    WaitForKey
    MovePiece -1, 39, pl%
    Chance = 39
    LandOnProp pl%, ArrayIndex%(39)
  ELSEIF chcard% = 6 THEN
    LOCATE 7, 1: centermain "You have been elected"
    LOCATE 8, 1: centermain "Chairman of the Board."
    LOCATE 9, 1: centermain "Pay each player $50."
    WHILE Stats(pl%).Money < 50
      LOCATE 10, 59: PRINT "You need more money!"
      LOCATE 11, 59: PRINT "O to get some"
      LOCATE 12, 59: PRINT "B for bankruptsy."
      DO
        b$ = UCASE$(INKEY$)
      LOOP UNTIL b$ = "O" OR b$ = "B"
      IF b$ = "B" THEN Winner Opponent%(pl%)
      Utilities pl%
    WEND
    ClearSub
    Stats(pl%).Money = Stats(pl%).Money - 50
    Stats(Opponent%(pl%)).Money = Stats(Opponent%(pl%)).Money + 50
    LOCATE 10, 59: PRINT USING "You paid & _$50_."; Stats(Opponent%(pl%)).ID
    Chance = -2
  ELSEIF chcard% = 7 THEN
    LOCATE 7, 1: centermain "Advance to Illinois Avenue."
    LOCATE 10, 59: PRINT "Press any key"
    LOCATE 11, 59: PRINT "to go on."
    WaitForKey
    MovePiece -1, 24, pl%
    LandOnProp pl%, ArrayIndex%(24)
    Chance = 24
  ELSEIF chcard% = 8 THEN
    LOCATE 7, 1: centermain "Take a ride on the Reading."
    LOCATE 8, 1: centermain "If you pass Go collect $200."
    LOCATE 10, 59: PRINT "Press any key"
    LOCATE 11, 59: PRINT "to go on."
    WaitForKey
    MovePiece -1, 5, pl%
    LandOnProp pl%, ArrayIndex%(5)
    Chance = 5
  ELSEIF chcard% = 9 THEN
    LOCATE 7, 1: centermain "Go Directly to Jail."
    LOCATE 8, 1: centermain "Do Not Pass Go, Do Not Collect $200."
    LOCATE 10, 59: PRINT "Press any key"
    LOCATE 11, 59: PRINT "to go on."
    WaitForKey
    MovePiece -1, -1, pl%
    ClearSub
    LOCATE 10, 59: PRINT "You are in Jail!"
    Chance = -1
  ELSEIF chcard% = 10 THEN
    LOCATE 7, 1: centermain "Advance to St. Charles Place."
    LOCATE 8, 1: centermain "If you pass Go, collect $200."
    LOCATE 10, 59: PRINT "Press any key"
    LOCATE 11, 59: PRINT "to go on."
    WaitForKey
    MovePiece -1, 11, pl%
    LandOnProp pl%, ArrayIndex%(11)
    Chance = 11
  ELSEIF chcard% = 11 THEN
    LOCATE 7, 1: centermain "Make general repairs on"
    LOCATE 8, 1: centermain "all your property."
    LOCATE 9, 1: centermain "For each house pay $25."
    LOCATE 10, 1: centermain "For each hotel pay $100."
    payup% = 0
    FOR c% = 1 TO 28
      IF Deed(c%).Style = GROUP AND Deed(c%).Owner = pl% AND Deed(c%).Houses > 0 THEN
        IF Deed(c%).Houses >= 1 AND Deed(c%).Houses <= 4 THEN payup% = payup% + (Deed(c%).Houses * 25)
        IF Deed(c%).Houses = 5 THEN payup% = payup% + 100
      END IF
    NEXT c%
    WHILE Stats(pl%).Money < payup%
      LOCATE 10, 59: PRINT USING "You owe $$###_."; payup%
      LOCATE 11, 59: PRINT "You need more money!"
      LOCATE 12, 59: PRINT "O to get some"
      LOCATE 13, 59: PRINT "B for bankruptsy"
      DO
        opt$ = UCASE$(INKEY$)
      LOOP UNTIL opt$ = "O" OR opt$ = "B"
      IF opt$ = "B" THEN Winner Opponent%(pl%)
      Utilities pl%
    WEND
    ClearSub
    Stats(pl%).Money = Stats(pl%).Money - payup%
    DashBoard
    LOCATE 10, 59: PRINT USING "You paid $$###."; payup%
    Chance = -2
  ELSEIF chcard% = 12 THEN
    LOCATE 7, 1: centermain "Advance token to nearest utility."
    LOCATE 8, 1: centermain "If unowned, you may buy it from the bank."
    LOCATE 9, 1: centermain "If owned, throw dice and pay owner a"
    LOCATE 10, 1: centermain "total ten times the amount thrown."
    LOCATE 10, 59: PRINT "Press any key"
    LOCATE 11, 59: PRINT "to go on."
    WaitForKey
    IF Stats(pl%).Position >= 13 AND Stats(pl%).Position <= 27 THEN gohere% = 28 ELSE gohere% = 12
    MovePiece -1, gohere%, pl%
    pr% = ArrayIndex%(gohere%)
    IF Deed(pr%).Owner = BANK OR Deed(pr%).Owner = pl% THEN
      LandOnProp pl%, pr%
    ELSE
      TitleDeed pr%
      ClearSub
      LOCATE 10, 59: PRINT "Any key to roll"
      WaitForKey
      die1% = RandomNum%(1, 6)
      die2% = RandomNum%(1, 6)
      LOCATE 15, 61: PRINT USING "#"; die1%
      LOCATE 15, 66: PRINT USING "#"; die2%
      total% = die1% + die2%
      LOCATE 15, 69: PRINT USING "##"; total%
      payup% = 10 * total%
      WHILE Stats(pl%).Money < payup%
        LOCATE 10, 59: PRINT USING "You owe $$##_.   "; payup%
        LOCATE 11, 59: PRINT "You need more money!"
        LOCATE 12, 59: PRINT "O to get some"
        LOCATE 13, 59: PRINT "B for bankruptsy"
        DO
          opt$ = UCASE$(INKEY$)
        LOOP UNTIL opt$ = "O" OR opt$ = "B"
        IF opt$ = "B" THEN Winner Opponent%(pl%)
        Utilities pl%
      WEND
      ClearSub
      Stats(pl%).Money = Stats(pl%).Money - payup%
      Stats(Opponent%(pl%)).Money = Stats(Opponent%(pl%)).Money + payup%
      DashBoard
      LOCATE 10, 59: PRINT USING "You paid $$##_."; payup%
    END IF
    Chance = gohere%
  ELSEIF chcard% = 14 THEN
    LOCATE 7, 1: centermain "Pay poor tax of $15."
    WHILE Stats(pl%).Money < 15
      LOCATE 10, 59: PRINT "You owe $15."
      LOCATE 11, 59: PRINT "You need more money!"
      LOCATE 12, 59: PRINT "O to get some"
      LOCATE 13, 59: PRINT "B for bankruptsy"
      DO
        opt$ = UCASE$(INKEY$)
      LOOP UNTIL opt$ = "O" OR opt$ = "B"
      IF opt$ = "B" THEN Winner Opponent%(pl%)
      Utilities pl%
    WEND
    ClearSub
    Stats(pl%).Money = Stats(pl%).Money - 15
    DashBoard
    LOCATE 10, 59: PRINT "You paid $15."
    Chance = -2
  ELSEIF chcard% = 15 THEN
    LOCATE 7, 1: centermain "Go back 3 spaces."
    LOCATE 10, 59: PRINT "Press a key"
    LOCATE 11, 59: PRINT "to go on."
    WaitForKey
    MovePiece -3, -1, pl%
    mover% = LandOnAny(pl%, Stats(pl%).Position)
    Chance = Stats(pl%).Position
  ELSEIF chcard% = 16 AND (Stats(1).ChanceFree = FALSE AND Stats(2).ChanceFree = FALSE) THEN
    LOCATE 7, 1: centermain "Get out of Jail Free."
    LOCATE 8, 1: centermain "This card may be kept until needed."
    Stats(pl%).ChanceFree = TRUE
    DashBoard
    LOCATE 10, 59: PRINT "You got a Get Out of"
    LOCATE 11, 59: PRINT "Jail Free card!"
    Chance = -2
  END IF
  IF NOT (chcard% = 3 OR chcard% = 13 OR chcard% = 5 OR chcard% = 7 OR chcard% = 8 OR chcard% = 10 OR chcard% = 12) THEN
    DO
      LOCATE 12, 59: PRINT "O for options"
      LOCATE 13, 59: PRINT "Any other to continue"
      opt$ = UCASE$(Charcter$)
      IF opt$ = "O" THEN Utilities pl%
    LOOP UNTIL opt$ <> "O"
  END IF
  chcard% = chcard% + 1
  IF chcard% > 16 THEN chcard% = chcard% - 16
END FUNCTION

' returns the next key pressed
FUNCTION Character$
  DO
  LOOP UNTIL INKEY$ <> ""
  Character$ = INKEY$
END FUNCTION

' draws and uses a card from the Community Chest deck
FUNCTION Chest (pl%)
  SHARED Deed() AS property, Stats() AS Player
  STATIC ctcard%
  IF pl% = 0 THEN
    ctcard% = RandomNum%(1, 16)
  ELSEIF pl% < 0 THEN
    ctcard% = ABS(pl%)
  END IF
  IF pl% <= 0 THEN EXIT FUNCTION
  ClearMain
  ClearSub
  LOCATE 5, 1: centermain "COMMUNITY CHEST CARD"
  IF ctcard% = 0 THEN ctcard% = 1
  IF ctcard% = 1 THEN
    LOCATE 7, 1: centermain "Bank error in your favor."
    LOCATE 8, 1: centermain "Collect $200."
    Stats(pl%).Money = Stats(pl%).Money + 200
    DashBoard
    LOCATE 10, 59: PRINT "You earned $200."
    Chest = -2
  ELSEIF ctcard% = 2 THEN
    LOCATE 7, 1: centermain "You are assessed for street repairs."
    LOCATE 8, 1: centermain "$40 per house."
    LOCATE 9, 1: centermain "$115 per hotel."
    payup% = 0
    FOR c% = 1 TO 28
      IF Deed(c%).Style = GROUP AND Deed(c%).Owner = pl% AND Deed(c%).Houses > 0 THEN
        IF Deed(c%).Houses >= 1 AND Deed(c%).Houses <= 4 THEN payup% = payup% + (Deed(c%).Houses * 40)
        IF Deed(c%).Houses = 5 THEN payup% = payup% + 115
      END IF
    NEXT c%
    IF Stats(pl%).Money < payup% THEN
      LOCATE 10, 59: PRINT USING "You owe $$###_."; payup%
      LOCATE 11, 59: PRINT "You need more money!"
      LOCATE 12, 59: PRINT "O to get some"
      LOCATE 13, 59: PRINT "B for bankruptsy"
      DO
        opt$ = UCASE$(INKEY$)
      LOOP UNTIL opt$ = "O" OR opt$ = "B"
      IF opt$ = "B" THEN Winner Opponent%(pl%)
      Utilities pl%
      ClearSub
    END IF
    Stats(pl%).Money = Stats(pl%).Money - payup%
    DashBoard
    LOCATE 10, 59: PRINT USING "You paid $$###_."; payup%
    Chest = -2
  ELSEIF ctcard% = 3 THEN
    LOCATE 7, 1: centermain "Recieve for services $25."
    Stats(pl%).Money = Stats(pl%).Money + 25
    DashBoard
    LOCATE 10, 59: PRINT "You earned $25."
    Chest = -2
  ELSEIF ctcard% = 4 THEN
    LOCATE 7, 1: centermain "Advance to Go."
    LOCATE 8, 1: centermain "(collect $200)"
    LOCATE 10, 59: PRINT "Press any key"
    LOCATE 11, 59: PRINT "to go on."
    WaitForKey
    MovePiece -1, 0, pl%
    LOCATE 10, 59: PRINT "You are on Go."
    LOCATE 11, 59: PRINT "You earned $200."
    Chest = 0
  ELSEIF ctcard% = 5 THEN
    LOCATE 7, 1: centermain "Pay school tax of $150."
    IF Stats(pl%).Money < 150 THEN
      LOCATE 10, 59: PRINT "You owe $150."
      LOCATE 11, 59: PRINT "You need more money!"
      LOCATE 12, 59: PRINT "O to get some"
      LOCATE 13, 59: PRINT "B for bankruptsy"
      DO
        opt$ = UCASE$(INKEY$)
      LOOP UNTIL opt$ = "O" OR opt$ = "B"
      IF opt$ = "B" THEN Winner Opponent%(pl%)
      Utilities pl%
      ClearSub
    END IF
    Stats(pl%).Money = Stats(pl%).Money - 150
    DashBoard
    LOCATE 10, 59: PRINT "You paid $150."
    Chest = -2
  ELSEIF ctcard% = 6 THEN
    LOCATE 7, 1: centermain "X-mas fund matures."
    LOCATE 8, 1: centermain "Collect $100."
    Stats(pl%).Money = Stats(pl%).Money + 100
    DashBoard
    LOCATE 10, 59: PRINT "You earned $100."
    Chest = -2
  ELSEIF ctcard% = 7 THEN
    LOCATE 7, 1: centermain "Income tax refund."
    LOCATE 8, 1: centermain "Collect $20."
    Stats(pl%).Money = Stats(pl%).Money + 20
    DashBoard
    LOCATE 10, 59: PRINT "You earned $20."
    Chest = -2
  ELSEIF ctcard% = 8 THEN
    LOCATE 7, 1: centermain "You inherit $100."
    Stats(pl%).Money = Stats(pl%).Money + 100
    DashBoard
    LOCATE 10, 59: PRINT "You earned $100."
    Chest = -2
  ELSEIF ctcard% = 9 THEN
    LOCATE 7, 1: centermain "Life insurance matures."
    LOCATE 8, 1: centermain "Collect $100."
    Stats(pl%).Money = Stats(pl%).Money + 100
    DashBoard
    LOCATE 10, 59: PRINT "You earned $100."
    Chest = -2
  ELSEIF ctcard% = 10 THEN
    LOCATE 7, 1: centermain "You have won second prize"
    LOCATE 8, 1: centermain "in a beauty contest."
    LOCATE 9, 1: centermain "Collect $10."
    Stats(pl%).Money = Stats(pl%).Money + 10
    DashBoard
    LOCATE 10, 59: PRINT "You earned $10."
    Chest = -2
  ELSEIF ctcard% = 11 THEN
    LOCATE 7, 1: centermain "From sale of stock you get $45."
    Stats(pl%).Money = Stats(pl%).Money + 45
    DashBoard
    LOCATE 10, 59: PRINT "You earned $45."
    Chest = -2
  ELSEIF ctcard% = 12 AND (Stats(pl%).ChestFree = FALSE AND Stats(Opponent%(pl%)).ChestFree = FALSE) THEN
    LOCATE 7, 1: centermain "Get out of Jail Free."
    LOCATE 8, 1: centermain "This card may be kept until needed."
    Stats(pl%).ChestFree = TRUE
    DashBoard
    LOCATE 10, 59: PRINT "You got a Get Out of"
    LOCATE 11, 59: PRINT "Jail Free card!"
    Chest = -2
  ELSEIF ctcard% = 13 OR (ctcard% = 12 AND (Stats(pl%).ChestFree = TRUE OR Stats(Opponent%(pl%)).ChestFree = TRUE)) THEN
    LOCATE 7, 1: centermain "Go Directly to Jail."
    LOCATE 8, 1: centermain "Do Not Pass Go, Do Not Collect $200."
    LOCATE 10, 59: PRINT "Press any key"
    LOCATE 11, 59: PRINT "to go on."
    WaitForKey
    MovePiece -1, -1, pl%
    ClearSub
    LOCATE 10, 59: PRINT "You are in Jail!"
    IF ctcard% = 12 THEN ctcard% = ctcard% + 1
    Chest = -1
  ELSEIF ctcard% = 14 THEN
    LOCATE 7, 1: centermain "Grand opera opening."
    LOCATE 8, 1: centermain "Collect $50 from every player"
    LOCATE 9, 1: centermain "for opening night seats."
    IF Stats(Opponent%(pl%)).Money < 50 THEN
      LOCATE 10, 59: PRINT USING "&: You owe $50."; Stats(Opponent%(pl%)).ID
      LOCATE 11, 59: PRINT "You need more money!"
      LOCATE 12, 59: PRINT "O to get some"
      LOCATE 13, 59: PRINT "B for bankruptsy"
      DO
        opt$ = UCASE$(INKEY$)
      LOOP UNTIL opt$ = "O" OR opt$ = "B"
      IF opt$ = "B" THEN Winner pl%
      Utilities Opponent%(pl%)
      ClearSub
    END IF
    Stats(Opponent%(pl%)).Money = Stats(Opponent%(pl%)).Money - 50
    Stats(pl%).Money = Stats(pl%).Money + 50
    DashBoard
    LOCATE 10, 59: PRINT USING "&: You earned $50."; Stats(pl%).ID
    LOCATE 11, 59: PRINT USING "&: You paid $50."; Stats(Opponent%(pl%)).ID
    Chest = -2
  ELSEIF ctcard% = 15 THEN
    LOCATE 7, 1: centermain "Pay hospital $100."
    IF Stats(pl%).Money < 100 THEN
      LOCATE 10, 59: PRINT "You owe $100."
      LOCATE 11, 59: PRINT "You need more money!"
      LOCATE 12, 59: PRINT "O to get some"
      LOCATE 13, 59: PRINT "B for bankruptsy"
      DO
        opt$ = UCASE$(INKEY$)
      LOOP UNTIL opt$ = "O" OR opt$ = "B"
      IF opt$ = "B" THEN Winner Opponent%(pl%)
      Utilities pl%
      ClearSub
    END IF
    Stats(pl%).Money = Stats(pl%).Money - 100
    LOCATE 10, 59: PRINT "You paid $100."
    Chest = -2
  ELSEIF ctcard% = 16 THEN
    LOCATE 7, 1: centermain "Doctor's fee"
    LOCATE 8, 1: centermain "Pay $50."
    IF Stats(pl%).Money < 50 THEN
      LOCATE 10, 59: PRINT "You owe $50."
      LOCATE 11, 59: PRINT "You need more money!"
      LOCATE 12, 59: PRINT "O to get some"
      LOCATE 13, 59: PRINT "B for bankruptsy"
      DO
        opt$ = UCASE$(INKEY$)
      LOOP UNTIL opt$ = "O" OR opt$ = "B"
      IF opt$ = "B" THEN Winner Opponent%(pl%)
      Utilities pl%
      ClearSub
    END IF
    Stats(pl%).Money = Stats(pl%).Money - 50
    DashBoard
    LOCATE 10, 59: PRINT "You paid $50."
    Chest = -2
  END IF
  ctcard% = ctcard% + 1
  IF ctcard% > 16 THEN ctcard% = ctcard% - 16
  DO
    LOCATE 12, 59: PRINT "O for options"
    LOCATE 13, 59: PRINT "Any other to continue"
    opt$ = UCASE$(Charcter$)
    IF opt$ = "O" THEN Utilities pl%
  LOOP UNTIL opt$ <> "O"
END FUNCTION

' clears the keyboard buffer
SUB ClearBuffer
  SHARED trash$
  WHILE LEN(INKEY$) > 0
    trash$ = INKEY$
  WEND
END SUB

' clears the main viewport
SUB ClearMain
  FOR c% = 5 TO 19
     LOCATE c%, 8
    PRINT SPACE$(48 - 8)
  NEXT c%
END SUB

' clears sub viewport
SUB ClearSub
  FOR c% = 10 TO 13
    LOCATE c%, 58
    PRINT SPACE$((80 - 58) + 1)
  NEXT c%
  LOCATE 14, 59: PRINT "ÚÄÄ¿ ÚÄÄ¿             "
  LOCATE 15, 59: PRINT "³"
  LOCATE 15, 62: PRINT "³"
  LOCATE 15, 63: PRINT "+"
  LOCATE 15, 64: PRINT "³"
  LOCATE 15, 67: PRINT "³"
  LOCATE 15, 68: PRINT "="
  LOCATE 16, 59: PRINT "ÀÄÄÙ ÀÄÄÙ             "
END SUB

' calculate the location of a character in screen memory
FUNCTION ConvBlock% (row%, column%, colormem%)
  ConvBlock% = (((column% * 2) - 2) + ((row% * 160) - 160)) + colormem%
END FUNCTION

' calculate the screen memory code for a color
FUNCTION ConvColor% (fore%, back%)
  ConvColor% = fore% + (back% * 16)
END FUNCTION

' creates saved game file if MONOPOLY.SAV isn't found
SUB CreateFile
  OPEN "MONOPOLY.SAV" FOR RANDOM AS #1 LEN = FPROP + (FPLAY * 2) + 1
  FIELD #1, FPROP AS props$, FPLAY AS player1$, FPLAY AS player2$, 1 AS t$
  FOR c% = 1 TO 3
    LSET props$ = SPACE$(112)
    LSET player1$ = SPACE$(18)
    LSET player2$ = SPACE$(18)
    LSET t$ = SPACE$(1)
    PUT #1, c%
  NEXT c%
  CLOSE #1
END SUB

' refreshes display of the Dashboard
SUB DashBoard
  SHARED Stats() AS Player, Houses%, hotels%
  FOR c% = 1 TO 2
    IF c% = 1 THEN i% = 2 ELSE i% = 18
    IF CHR$(SCREEN(i%, 59)) = " " THEN
      LOCATE i%, 59: PRINT USING "&: $$####,"; Stats(c%).ID; Stats(c%).Money
    ELSE
      LOCATE i%, 67: PRINT USING ": $$####,"; Stats(c%).Money
    END IF
    LightUp c%, 1, i% + 1, 60
    LightUp c%, 2, i% + 1, 63
    LightUp c%, 3, i% + 5, 60
    LightUp c%, 4, i% + 1, 67
    LightUp c%, 5, i% + 1, 70
    LightUp c%, 6, i% + 1, 73
    LightUp c%, 7, i% + 2, 60
    LightUp c%, 8, i% + 5, 73
    LightUp c%, 9, i% + 2, 63
    LightUp c%, 10, i% + 2, 66
    LightUp c%, 11, i% + 5, 63
    LightUp c%, 12, i% + 2, 70
    LightUp c%, 13, i% + 2, 73
    LightUp c%, 14, i% + 2, 76
    LightUp c%, 15, i% + 3, 60
    LightUp c%, 16, i% + 3, 63
    LightUp c%, 17, i% + 3, 66
    LightUp c%, 18, i% + 5, 66
    LightUp c%, 19, i% + 3, 70
    LightUp c%, 20, i% + 3, 73
    LightUp c%, 21, i% + 5, 76
    LightUp c%, 22, i% + 3, 76
    LightUp c%, 23, i% + 4, 60
    LightUp c%, 24, i% + 4, 63
    LightUp c%, 25, i% + 4, 66
    LightUp c%, 26, i% + 5, 69
    LightUp c%, 27, i% + 4, 70
    LightUp c%, 28, i% + 4, 73
    IF Stats(c%).ChanceFree = TRUE THEN
      POKE ConvBlock%(i% + 6, 60, 1), ConvColor%(ORANGE, 0)
    ELSE
      POKE ConvBlock%(i% + 6, 60, 1), ConvColor%(0, 0)
    END IF
    IF Stats(c%).ChestFree = TRUE THEN
      POKE ConvBlock%(i% + 6, 78, 1), ConvColor%(YELLOW, 0)
    ELSE
      POKE ConvBlock%(i% + 6, 78, 1), ConvColor%(0, 0)
    END IF
    POKE ConvBlock%(i% + 6, 69, 0), ASC(Stats(c%).Piece)
    POKE ConvBlock%(i% + 6, 69, 1), ConvColor%(7, 0)
  NEXT c%
  txt$ = LTRIM$(STR$(Houses%))
  IF LEN(txt$) = 2 THEN
    POKE ConvBlock%(24, 29, 0), ASC(LEFT$(txt$, 1))
    POKE ConvBlock%(24, 29, 1), ConvColor%(7, 0)
    POKE ConvBlock%(24, 30, 0), ASC(RIGHT$(txt$, 1))
    POKE ConvBlock%(24, 30, 1), ConvColor%(7, 0)
  ELSE
    POKE ConvBlock%(24, 29, 0), ASC(txt$)
    POKE ConvBlock%(24, 29, 1), ConvColor%(7, 0)
  END IF
  txt$ = LTRIM$(STR$(hotels%))
  IF LEN(txt$) = 2 THEN
    POKE ConvBlock%(24, 41, 0), ASC(LEFT$(txt$, 1))
    POKE ConvBlock%(24, 41, 1), ConvColor%(7, 0)
    POKE ConvBlock%(24, 42, 0), ASC(RIGHT$(txt$, 1))
    POKE ConvBlock%(24, 42, 1), ConvColor%(7, 0)
  ELSE
    POKE ConvBlock%(24, 41, 0), ASC(txt$)
    POKE ConvBlock%(24, 41, 1), ConvColor%(7, 0)
  END IF
END SUB

' a high-precision SLEEP command
SUB Delay (hl!)
  old! = TIMER
  DO
  LOOP UNTIL TIMER - old! >= hl!
END SUB

' calculates the value of the dice
FUNCTION DiceRoll%
  SHARED doubles%
  ClearBuffer
  ClearMain
  ClearSub
  LOCATE 15, 61: PRINT "?"
  LOCATE 15, 66: PRINT "?"
  LOCATE 15, 69: PRINT "??"
  LOCATE 10, 59: PRINT "S for save"
  LOCATE 11, 59: PRINT "Any other key to roll"
  DO
    choice$ = INKEY$
  LOOP UNTIL choice$ <> ""
  IF UCASE$(choice$) = "S" THEN
    SaveGame
    DiceRoll% = FALSE
    EXIT FUNCTION
  END IF
  die1% = RandomNum%(1, 6)
  die2% = RandomNum%(1, 6)
  LOCATE 15, 61: PRINT USING "#"; die1%
  LOCATE 15, 66: PRINT USING "#"; die2%
  LOCATE 15, 69: PRINT USING "##"; die1% + die2%
  IF die1% = die2% THEN doubles% = doubles% + 1
  IF doubles% = 3 THEN DiceRoll% = -1 ELSE DiceRoll% = die1% + die2%
END FUNCTION

' returns last digit pressed between min% and max%, 0 if non-digit
FUNCTION Digit%
  DO
    d% = VAL(INKEY$)
  LOOP UNTIL d% <> 0
  Digit% = d%
END FUNCTION

' calculates the character equivalent of the houses (or hotels) on a
'   given property
FUNCTION HouseChar$ (squ%)
  SELECT CASE Deed(squ%).Houses
  CASE 0
    HouseChar$ = "0"
  CASE 1
    HouseChar$ = "1"
  CASE 2
    HouseChar$ = "2"
  CASE 3
    HouseChar$ = "3"
  CASE 4
    HouseChar$ = "4"
  CASE 5
    HouseChar$ = "H"
  END SELECT
END FUNCTION

' initializes a player's status information
SUB InitPlayer (pl%)
  SHARED Stats() AS Player
  ClearMain
  ClearSub
  DO
    LOCATE 10, 59: PRINT USING "Player _##_, please"; pl%
    LOCATE 11, 59: PRINT "enter your name."
    LOCATE 12, 59: INPUT trash$
    ClearSub
    IF LEN(trash$) > 8 THEN
      Stats(pl%).ID = LEFT$(trash$, 8)
    ELSE
      Stats(pl%).ID = trash$
    END IF
  LOOP UNTIL Stats(pl%).ID <> SPACE$(8)
  ClearSub
  LOCATE 10, 59: PRINT USING "&_, please"; Stats(pl%).ID
  LOCATE 11, 59: PRINT "choose a piece:"
  SELECT CASE pl%
  CASE 1
    LOCATE 12, 59: PRINT "1.  à"
    LOCATE 13, 59: PRINT "2.  é"
    DO
      opt% = Digit%
    LOOP UNTIL opt% = 1 OR opt% = 2
    IF opt% = 1 THEN Stats(pl%).Piece = "à" ELSE Stats(pl%).Piece = "é"
  CASE 2
    LOCATE 12, 59: PRINT "1.  á"
    LOCATE 13, 59: PRINT "2.  ê"
    DO
      opt% = Digit%
    LOOP UNTIL opt% = 1 OR opt% = 2
    IF opt% = 1 THEN Stats(pl%).Piece = "á" ELSE Stats(pl%).Piece = "ê"
  END SELECT
  DashBoard
END SUB

' handles landing on any space
FUNCTION LandOnAny (pl%, pr%)
  SHARED Deed() AS property, Stats() AS Player
  ClearMain
  ClearSub
  v% = ArrayIndex%(pr%)
  SELECT CASE v%
  CASE 1 TO 28
    LandOnProp pl%, v%
    LandOnAny = -2
  CASE GO
    LOCATE 10, 59: PRINT "You are on Go."
    LOCATE 11, 59: PRINT "You earned $200."
    LandOnAny = -2
  CASE COMM
    LandOnAny = Chest(pl%)
  CASE INC
    LOCATE 10, 59: PRINT "You are on Income Tax."
    LOCATE 11, 59: PRINT "F to pay $200."
    LOCATE 12, 59: PRINT "V to pay 10%."
    DO
      pay$ = UCASE$(INKEY$)
    LOOP UNTIL pay$ = "F" OR pay$ = "V"
    optv% = (Stats(pl%).Money / 10)
    FOR c% = 1 TO 28
      IF Deed(c%).Owner = pl% THEN
        SELECT CASE Deed(c%).Style
        CASE GROUP
          IF Deed(c%).Mortgaged = TRUE THEN
            optv% = optv% + INT((Deed(c%).Cost / 2) / 2)
          ELSE
            optv% = optv% + (Deed(c%).Cost / 2) + (Deed(c%).Houses * (Deed(c%).HouseCost / 2))
          END IF
        CASE RR
          IF Deed(c%).Mortgaged = TRUE THEN optv% = optv% + 100 ELSE optv% = optv% + 200
        CASE UTIL
          IF Deed(c%).Mortgaged = TRUE THEN optv% = optv% + 75 ELSE optv% = optv% + 150
        END SELECT
      END IF
    NEXT c%
    IF pay$ = "F" THEN payup% = 200 ELSE payup% = optv%
    IF 200 < optv% THEN
      best% = 200
      worst% = optv%
    ELSE
      best% = optv%
      worst% = 200
    END IF
    ClearSub
    WHILE payup% > Stats(pl%).Money
      LOCATE 10, 59: PRINT USING "You owe $$###_."; payup%
      LOCATE 11, 59: PRINT "You need more money!"
      LOCATE 12, 59: PRINT "O to get some"
      LOCATE 13, 59: PRINT "B for bankruptsy"
      DO
        o$ = UCASE$(INKEY$)
      LOOP UNTIL o$ = "O" OR o$ = "B"
      IF o$ = "B" THEN Winner Opponent%(pl%)
      Utilities pl%
      ClearSub
    WEND
    Stats(pl%).Money = Stats(pl%).Money - payup%
    DashBoard
    LOCATE 10, 59: PRINT USING "You paid $$###,_."; payup%
    IF payup% = best% THEN
      LOCATE 11, 59: PRINT USING "You saved $$###,_!"; worst% - payup%
    ELSE
      LOCATE 11, 59: PRINT USING "You wasted $$###,_!"; payup% - best%
    END IF
    LandOnAny = -2
  CASE CHA
    LandOnAny = Chance(pl%)
  CASE VIS
    LOCATE 10, 59: PRINT "You're Just Visiting"
    LOCATE 11, 59: PRINT "the Jail."
    LandOnAny = -2
  CASE FREE
    LOCATE 10, 59: PRINT "You're on Free Parking"
    LandOnAny = -2
  CASE GOT
    LOCATE 10, 59: PRINT "Uh oh!  Go To Jail!"
    LOCATE 11, 59: PRINT "Press any key"
    LOCATE 12, 59: PRINT "to go in."
    WaitForKey
    MovePiece -1, -1, pl%
    ClearSub
    LOCATE 10, 59: PRINT "You are in Jail."
    LandOnAny = -1
  CASE LUX
    WHILE Stats(pl%).Money < 75
      LOCATE 10, 59: PRINT "You owe $75."
      LOCATE 11, 59: PRINT "You need more money!"
      LOCATE 12, 59: PRINT "O to get some"
      LOCATE 13, 59: PRINT "B for bankruptsy"
      DO
        o$ = UCASE$(INKEY$)
      LOOP UNTIL o$ = "O" OR o$ = "B"
      IF o$ = "B" THEN Winner Opponent%(pl%)
      Utilities pl%
      ClearSub
    WEND
    Stats(pl%).Money = Stats(pl%).Money - 75
    DashBoard
    LOCATE 10, 59: PRINT "You're on Luxury Tax."
    LOCATE 11, 59: PRINT "You paid $75."
    LandOnAny = -2
  END SELECT
  IF v% < 1 OR NOT (v% <> CHA OR v% <> COMM) THEN
    LOCATE 12, 59: PRINT "O for options"
    LOCATE 13, 59: PRINT "Any other to go on"
    DO
      opt$ = UCASE$(INKEY$)
    LOOP UNTIL opt$ <> ""
    IF opt$ = "O" THEN Utilities pl%
  END IF
END FUNCTION

' handles landing on a property
SUB LandOnProp (pl%, pr%)
  SHARED Deed() AS property, Stats() AS Player
  ClearSub
  TitleDeed pr%
  SELECT CASE Deed(pr%).Owner
  CASE BANK
    DO
      LOCATE 10, 59: PRINT "UNOWNED"
      LOCATE 11, 59: PRINT "B to buy"
      LOCATE 12, 59: PRINT "A to auction"
      LOCATE 13, 59: PRINT "O for Options"
      opt$ = UCASE$(INKEY$)
      IF opt$ = "O" THEN Utilities pl%
      IF opt$ = "B" AND Stats(pl%).Money < Deed(pr%).Cost THEN Buzz
    LOOP UNTIL (opt$ = "B" AND Stats(pl%).Money >= Deed(pr%).Cost) OR opt$ = "A"
    ClearSub
    IF opt$ = "B" AND Stats(pl%).Money >= Deed(pr%).Cost THEN
      Stats(pl%).Money = Stats(pl%).Money - Deed(pr%).Cost
      Deed(pr%).Owner = pl%
      DashBoard
      DO
        LOCATE 10, 59: PRINT "Property Bought"
        LOCATE 11, 59: PRINT "O for Options"
        LOCATE 12, 59: PRINT "Any other to go on"
      LOOP UNTIL o$ <> "O"
    ELSE
      Auction pl%, pr%
    END IF
    Update
  CASE pl%
    LOCATE 10, 59: PRINT "You own this property"
    LOCATE 11, 59: PRINT "O for options"
    LOCATE 12, 59: PRINT "Any other to go on"
  CASE Opponent%(pl%)
    LOCATE 10, 59: PRINT USING "& owns it"; Stats(Opponent%(pl%)).ID
    SELECT CASE Deed(pr%).Style
    CASE GROUP
      IF Deed(pr%).Mortgaged = TRUE THEN
        payup% = 0
      ELSEIF Deed(pr%).Monopoly = FALSE THEN
        payup% = Deed(pr%).Rent
      ELSEIF Deed(pr%).Monopoly = TRUE AND Deed(pr%).Houses = 0 THEN
        payup% = Deed(pr%).Rent * 2
      ELSEIF Deed(pr%).Houses = 1 THEN
        payup% = Deed(pr%).House1
      ELSEIF Deed(pr%).Houses = 2 THEN
        payup% = Deed(pr%).House2
      ELSEIF Deed(pr%).Houses = 3 THEN
        payup% = Deed(pr%).House3
      ELSEIF Deed(pr%).Houses = 4 THEN
        payup% = Deed(pr%).House4
      ELSEIF Deed(pr%).Houses = 5 THEN
        payup% = Deed(pr%).Hotel
      END IF
      IF payup% = 0 THEN
        LOCATE 11, 59: PRINT "It's mortgaged!"
        LOCATE 12, 59: PRINT "O for options"
        LOCATE 13, 59: PRINT "Any other to go on"
      ELSE
        LOCATE 11, 59: PRINT USING "You owe $$###_."; payup%
        WHILE Stats(pl%).Money < payup%
          LOCATE 12, 59: PRINT "O to earn money"
          LOCATE 13, 59: PRINT "B for bankruptsy"
          DO
            opt$ = UCASE$(INKEY$)
          LOOP UNTIL opt$ = "O" OR opt$ = "B"
          IF opt$ = "B" THEN Winner Opponent%(pl%)
          Utilities pl%
        WEND
        LOCATE 12, 59: PRINT "                 "
        LOCATE 13, 59: PRINT "                 "
        Stats(pl%).Money = Stats(pl%).Money - payup%
        Stats(Opponent%(pl%)).Money = Stats(Opponent%(pl%)).Money + payup%
        DashBoard
        TitleDeed pl%
        LOCATE 11, 59: PRINT USING "You paid $$###,_."; payup%
        LOCATE 12, 59: PRINT "O for options"
        LOCATE 13, 59: PRINT "Any other to go on"
      END IF
    CASE RR
      IF Deed(pr%).Mortgaged = TRUE THEN
        payup% = 0
      ELSEIF Deed(pr%).Houses = 1 THEN
        payup% = 25 * 1
      ELSEIF Deed(pr%).Houses = 2 THEN
        payup% = 25 * 2
      ELSEIF Deed(pr%).Houses = 3 THEN
        payup% = 25 * 3
      ELSEIF Deed(pr%).Houses = 4 THEN
        payup% = 25 * 4
      END IF
      IF payup% = 0 THEN
        LOCATE 11, 59: PRINT "It's mortgaged!"
        LOCATE 12, 59: PRINT "O for options"
        LOCATE 13, 59: PRINT "Any other to go on"
      ELSE
        LOCATE 11, 59: PRINT USING "You owe $$##_."; payup%
        WHILE Stats(pl%).Money < payup%
          LOCATE 12, 59: PRINT "O to earn money"
          LOCATE 13, 59: PRINT "B for bankruptsy"
          DO
            opt$ = UCASE$(INKEY$)
          LOOP UNTIL opt$ = "O" OR opt$ = "B"
          IF opt$ = "B" THEN Winner Opponent%(pl%)
          Utilities pl%
        WEND
        LOCATE 12, 59: PRINT "                 "
        LOCATE 13, 59: PRINT "                 "
        Stats(pl%).Money = Stats(pl%).Money - payup%
        Stats(Opponent%(pl%)).Money = Stats(Opponent%(pl%)).Money + payup%
        DashBoard
        LOCATE 12, 59: PRINT "O for options"
        LOCATE 13, 59: PRINT "Any other to go on"
      END IF
    CASE UTIL
      dr% = VAL(CHR$(SCREEN(15, 69)) + CHR$(SCREEN(15, 70)))
      IF Deed(pr%).Mortgaged = TRUE THEN
        payup% = 0
      ELSEIF Deed(pr%).Houses = 1 THEN
        payup% = dr% * 4
      ELSEIF Deed(pr%).Houses = 2 THEN
        payup% = dr% * 10
      END IF
      IF payup% = 0 THEN
        LOCATE 11, 59: PRINT "It's mortgaged!"
        LOCATE 12, 59: PRINT "O for options"
        LOCATE 13, 59: PRINT "Any other to continue"
      ELSE
        LOCATE 11, 59: PRINT USING "You owe $$##_."; payup%
        WHILE Stats(pl%).Money < payup%
          LOCATE 12, 59: PRINT "O to earn money"
          LOCATE 13, 59: PRINT "B for bankruptsy"
          DO
            opt$ = UCASE$(INKEY$)
          LOOP UNTIL opt$ = "O" OR opt$ = "B"
          IF opt$ = "B" THEN Winner Opponent%(pl%)
          Utilities pl%
        WEND
        LOCATE 12, 59: PRINT "                 "
        LOCATE 13, 59: PRINT "                 "
        Stats(pl%).Money = Stats(pl%).Money - payup%
        Stats(Opponent%(pl%)).Money = Stats(Opponent%(pl%)).Money + payup%
        DashBoard
        LOCATE 12, 59: PRINT "O for options"
        LOCATE 13, 59: PRINT "Any other to continue"
      END IF
    END SELECT
  END SELECT
  DO
    o$ = UCASE$(INKEY$)
  LOOP UNTIL o$ <> ""
  IF o$ = "O" THEN Utilities pl%
END SUB

' lights up (or turns off lights) on the Dashboard
SUB LightUp (pl%, pr%, row%, col%)
  SHARED Deed() AS property
  IF Deed(pr%).Owner = pl% AND Deed(pr%).Mortgaged = FALSE THEN
    FOR c% = col% TO col% + 2: POKE ConvBlock%(row%, c%, 1), ConvColor%(Deed(pr%).Colour, 0): NEXT c%
  ELSEIF Deed(pr%).Owner = pl% AND Deed(pr%).Mortgaged = TRUE THEN
    FOR c% = col% TO col% + 2: POKE ConvBlock%(row%, c%, 1), ConvColor%(0, 7): NEXT c%
  ELSE
    FOR c% = col% TO col% + 2: POKE ConvBlock%(row%, c%, 1), ConvColor%(0, 0): NEXT c%
  END IF
END SUB

' loads a game from a save slot
SUB LoadGame
  SHARED Deed() AS property, Stats() AS Player, turn%, Houses%, hotels%
  ClearSub
  OPEN "MONOPOLY.SAV" FOR BINARY AS #1
  IF LOF(1) = 0 THEN
    CLOSE #1
    CreateFile
  ELSE
    CLOSE #1
  END IF
  OPEN "MONOPOLY.SAV" FOR RANDOM AS #1 LEN = FPROP + (FPLAY * 2) + 1
  FIELD #1, FPROP AS sprop$, FPLAY AS spl1$, FPLAY AS spl2$, 1 AS tnum$
  DO
    FOR c% = 1 TO 3
      GET #1, c%
      LOCATE c% + 9, 59
      IF sprop$ = SPACE$(FPROP) THEN
        PRINT USING "#_.  Slot empty"; c%
      ELSE
        PRINT USING "#_.  & vs &"; c%; LEFT$(spl1$, 8); LEFT$(spl2$, 8)
      END IF
    NEXT c%
    LOCATE 13, 59: PRINT "4.  Erase slot"
    LOCATE 14, 59: PRINT "5.  Never Mind"
    LOCATE 15, 59: PRINT "                      "
    LOCATE 16, 59: PRINT "                      "
    DO
      ch% = Digit%
    LOOP UNTIL ch% >= 1 AND ch% <= 5
    IF ch% <> 4 THEN EXIT DO
    LOCATE 13, 59: PRINT "4.  Go back to load"
    LOCATE 14, 59: PRINT "                      "
    DO
      ch% = Digit%
    LOOP UNTIL ch% >= 1 AND ch% <= 4
    IF ch% < 4 THEN
      GET #1, ch%
      LSET sprop$ = SPACE$(FPROP)
      LSET spl1$ = SPACE$(FPLAY)
      LSET spl2$ = SPACE$(FPLAY)
      PUT #1, ch%
    END IF
  LOOP
  IF ch% <> 5 THEN
    GET #1, ch%
    FOR c% = 1 TO 28
      d% = 1 + ((c% - 1) * 4)
      Deed(c%).Houses = VAL(MID$(sprop$, d%, 1))
      IF MID$(sprop$, d% + 1, 1) = "1" THEN Deed(c%).Monopoly = TRUE ELSE Deed(c%).Monopoly = FALSE
      Deed(c%).Owner = VAL(MID$(sprop$, d% + 2, 1))
      IF MID$(sprop$, d% + 3, 1) = "1" THEN Deed(c%).Mortgaged = TRUE ELSE Deed(c%).Mortgaged = FALSE
    NEXT c%
    Stats(1).ID = LEFT$(spl1$, 8)
    Stats(1).Piece = MID$(spl1$, 9, 1)
    IF MID$(spl1$, 10, 1) = "1" THEN Stats(1).ChanceFree = TRUE ELSE Stats(1).ChanceFree = FALSE
    IF MID$(spl1$, 11, 1) = "1" THEN Stats(1).ChestFree = TRUE ELSE Stats(1).ChestFree = FALSE
    Stats(1).Position = VAL(MID$(spl1$, 12, 2))
    Stats(1).Money = VAL(RIGHT$(spl1$, 5))
    Stats(2).ID = LEFT$(spl2$, 8)
    Stats(2).Piece = MID$(spl2$, 9, 1)
    IF MID$(spl2$, 10, 1) = "1" THEN Stats(2).ChanceFree = TRUE ELSE Stats(2).ChanceFree = FALSE
    IF MID$(spl2$, 11, 1) = "1" THEN Stats(2).ChestFree = TRUE ELSE Stats(2).ChestFree = FALSE
    Stats(2).Position = VAL(MID$(spl2$, 12, 2))
    Stats(2).Money = VAL(RIGHT$(spl2$, 5))
    turn% = VAL(tnum$)
    FOR c% = 1 TO 28
      IF Deed(c%).Style = 1 THEN
        IF Deed(c%).Houses = 5 THEN hotels% = hotels% - 1 ELSE Houses% = Houses% - Deed(c%).Houses
      END IF
    NEXT c%
  END IF
  CLOSE #1
  DashBoard
END SUB

' moves piece to specified square or specified amount
SUB MovePiece (amount%, square%, pl%)
  SHARED Stats() AS Player
  compare% = Stats(pl%).Position
  IF amount% <> -1 AND amount% = -3 THEN
    FOR c% = Stats(pl%).Position TO Stats(pl%).Position - 3 STEP -1
      POKE PieceMem%(Stats(pl%).Position, pl%, 0), ASC(" ")
      POKE PieceMem%(Stats(pl%).Position, pl%, 1), ConvColor%(0, 0)
      Stats(pl%).Position = Stats(pl%).Position - 1
      IF Stats(pl%).Position < 0 THEN Stats(pl%).Position = Stats(pl%).Position + MAXSPACE
      POKE PieceMem%(Stats(pl%).Position, pl%, 0), ASC(Stats(pl%).Piece)
      POKE PieceMem%(Stats(pl%).Position, pl%, 1), ConvColor%(7, 0)
      Delay .2
    NEXT c%
  ELSEIF amount% = -1 AND square% = -1 THEN
    POKE PieceMem%(Stats(pl%).Position, pl%, 0), ASC(" ")
    POKE PieceMem%(Stats(pl%).Position, pl%, 1), ConvColor%(0, 0)
    Stats(pl%).Position = -1
    POKE PieceMem%(Stats(pl%).Position, pl%, 0), ASC(Stats(pl%).Piece)
    POKE PieceMem%(Stats(pl%).Position, pl%, 1), ConvColor%(7, 0)
  ELSEIF amount% <> -1 THEN
    FOR c% = 1 TO amount%
      POKE PieceMem%(Stats(pl%).Position, pl%, 0), ASC(" ")
      POKE PieceMem%(Stats(pl%).Position, pl%, 1), ConvColor%(0, 0)
      Stats(pl%).Position = (Stats(pl%).Position + 1) MOD MAXSPACE
      POKE PieceMem%(Stats(pl%).Position, pl%, 0), ASC(Stats(pl%).Piece)
      POKE PieceMem%(Stats(pl%).Position, pl%, 1), ConvColor%(7, 0)
      Delay .2
    NEXT c%
  ELSEIF amount% = -1 THEN
    DO
      POKE PieceMem%(Stats(pl%).Position, pl%, 0), ASC(" ")
      POKE PieceMem%(Stats(pl%).Position, pl%, 1), ConvColor%(0, 0)
      Stats(pl%).Position = (Stats(pl%).Position + 1) MOD MAXSPACE
      POKE PieceMem%(Stats(pl%).Position, pl%, 0), ASC(Stats(pl%).Piece)
      POKE PieceMem%(Stats(pl%).Position, pl%, 1), ConvColor%(7, 0)
      Delay .2
    LOOP UNTIL Stats(pl%).Position = square%
  END IF
  IF compare% > Stats(pl%).Position AND Stats(pl%).Position > -1 THEN
    Stats(pl%).Money = Stats(pl%).Money + 200
    DashBoard
  END IF
END SUB

' calculates the opponent of the player whose turn it is
FUNCTION Opponent% (turn%)
  SELECT CASE turn%
  CASE 1
    Opponent% = 2
  CASE 2
    Opponent% = 1
  END SELECT
END FUNCTION

' returns the memory location of the piece position
FUNCTION PieceMem% (sq%, pl%, colormem%)
  SELECT CASE pl%
  CASE 1
    IF sq% = 0 THEN PieceMem% = ConvBlock%(23, 55, colormem%)
    IF sq% = 1 THEN PieceMem% = ConvBlock%(23, 48, colormem%)
    IF sq% = 2 THEN PieceMem% = ConvBlock%(23, 43, colormem%)
    IF sq% = 3 THEN PieceMem% = ConvBlock%(23, 38, colormem%)
    IF sq% = 4 THEN PieceMem% = ConvBlock%(23, 33, colormem%)
    IF sq% = 5 THEN PieceMem% = ConvBlock%(23, 28, colormem%)
    IF sq% = 6 THEN PieceMem% = ConvBlock%(23, 23, colormem%)
    IF sq% = 7 THEN PieceMem% = ConvBlock%(23, 18, colormem%)
    IF sq% = 8 THEN PieceMem% = ConvBlock%(23, 13, colormem%)
    IF sq% = 9 THEN PieceMem% = ConvBlock%(23, 8, colormem%)
    IF sq% = 10 THEN PieceMem% = ConvBlock%(23, 1, colormem%)
    IF sq% = 11 THEN PieceMem% = ConvBlock%(20, 1, colormem%)
    IF sq% = 12 THEN PieceMem% = ConvBlock%(18, 1, colormem%)
    IF sq% = 13 THEN PieceMem% = ConvBlock%(16, 1, colormem%)
    IF sq% = 14 THEN PieceMem% = ConvBlock%(14, 1, colormem%)
    IF sq% = 15 THEN PieceMem% = ConvBlock%(12, 1, colormem%)
    IF sq% = 16 THEN PieceMem% = ConvBlock%(10, 1, colormem%)
    IF sq% = 17 THEN PieceMem% = ConvBlock%(8, 1, colormem%)
    IF sq% = 18 THEN PieceMem% = ConvBlock%(6, 1, colormem%)
    IF sq% = 19 THEN PieceMem% = ConvBlock%(4, 1, colormem%)
    IF sq% = 20 THEN PieceMem% = ConvBlock%(1, 1, colormem%)
    IF sq% = 21 THEN PieceMem% = ConvBlock%(1, 8, colormem%)
    IF sq% = 22 THEN PieceMem% = ConvBlock%(1, 13, colormem%)
    IF sq% = 23 THEN PieceMem% = ConvBlock%(1, 18, colormem%)
    IF sq% = 24 THEN PieceMem% = ConvBlock%(1, 23, colormem%)
    IF sq% = 25 THEN PieceMem% = ConvBlock%(1, 28, colormem%)
    IF sq% = 26 THEN PieceMem% = ConvBlock%(1, 33, colormem%)
    IF sq% = 27 THEN PieceMem% = ConvBlock%(1, 38, colormem%)
    IF sq% = 28 THEN PieceMem% = ConvBlock%(1, 43, colormem%)
    IF sq% = 29 THEN PieceMem% = ConvBlock%(1, 48, colormem%)
    IF sq% = 30 THEN PieceMem% = ConvBlock%(1, 55, colormem%)
    IF sq% = 31 THEN PieceMem% = ConvBlock%(4, 55, colormem%)
    IF sq% = 32 THEN PieceMem% = ConvBlock%(6, 55, colormem%)
    IF sq% = 33 THEN PieceMem% = ConvBlock%(8, 55, colormem%)
    IF sq% = 34 THEN PieceMem% = ConvBlock%(10, 55, colormem%)
    IF sq% = 35 THEN PieceMem% = ConvBlock%(12, 55, colormem%)
    IF sq% = 36 THEN PieceMem% = ConvBlock%(14, 55, colormem%)
    IF sq% = 37 THEN PieceMem% = ConvBlock%(16, 55, colormem%)
    IF sq% = 38 THEN PieceMem% = ConvBlock%(18, 55, colormem%)
    IF sq% = 39 THEN PieceMem% = ConvBlock%(20, 55, colormem%)
    IF sq% = -1 THEN PieceMem% = ConvBlock%(24, 8, colormem%)
  CASE 2
    IF sq% = 0 THEN PieceMem% = ConvBlock%(21, 51, colormem%)
    IF sq% = 1 THEN PieceMem% = ConvBlock%(21, 48, colormem%)
    IF sq% = 2 THEN PieceMem% = ConvBlock%(21, 43, colormem%)
    IF sq% = 3 THEN PieceMem% = ConvBlock%(21, 38, colormem%)
    IF sq% = 4 THEN PieceMem% = ConvBlock%(21, 33, colormem%)
    IF sq% = 5 THEN PieceMem% = ConvBlock%(21, 28, colormem%)
    IF sq% = 6 THEN PieceMem% = ConvBlock%(21, 23, colormem%)
    IF sq% = 7 THEN PieceMem% = ConvBlock%(21, 18, colormem%)
    IF sq% = 8 THEN PieceMem% = ConvBlock%(21, 13, colormem%)
    IF sq% = 9 THEN PieceMem% = ConvBlock%(21, 8, colormem%)
    IF sq% = 10 THEN PieceMem% = ConvBlock%(21, 5, colormem%)
    IF sq% = 11 THEN PieceMem% = ConvBlock%(20, 6, colormem%)
    IF sq% = 12 THEN PieceMem% = ConvBlock%(18, 6, colormem%)
    IF sq% = 13 THEN PieceMem% = ConvBlock%(16, 6, colormem%)
    IF sq% = 14 THEN PieceMem% = ConvBlock%(14, 6, colormem%)
    IF sq% = 15 THEN PieceMem% = ConvBlock%(12, 6, colormem%)
    IF sq% = 16 THEN PieceMem% = ConvBlock%(10, 6, colormem%)
    IF sq% = 17 THEN PieceMem% = ConvBlock%(8, 6, colormem%)
    IF sq% = 18 THEN PieceMem% = ConvBlock%(6, 6, colormem%)
    IF sq% = 19 THEN PieceMem% = ConvBlock%(4, 6, colormem%)
    IF sq% = 20 THEN PieceMem% = ConvBlock%(3, 5, colormem%)
    IF sq% = 21 THEN PieceMem% = ConvBlock%(3, 8, colormem%)
    IF sq% = 22 THEN PieceMem% = ConvBlock%(3, 13, colormem%)
    IF sq% = 23 THEN PieceMem% = ConvBlock%(3, 18, colormem%)
    IF sq% = 24 THEN PieceMem% = ConvBlock%(3, 23, colormem%)
    IF sq% = 25 THEN PieceMem% = ConvBlock%(3, 28, colormem%)
    IF sq% = 26 THEN PieceMem% = ConvBlock%(3, 33, colormem%)
    IF sq% = 27 THEN PieceMem% = ConvBlock%(3, 38, colormem%)
    IF sq% = 28 THEN PieceMem% = ConvBlock%(3, 43, colormem%)
    IF sq% = 29 THEN PieceMem% = ConvBlock%(3, 48, colormem%)
    IF sq% = 30 THEN PieceMem% = ConvBlock%(3, 51, colormem%)
    IF sq% = 31 THEN PieceMem% = ConvBlock%(4, 50, colormem%)
    IF sq% = 32 THEN PieceMem% = ConvBlock%(6, 50, colormem%)
    IF sq% = 33 THEN PieceMem% = ConvBlock%(8, 50, colormem%)
    IF sq% = 34 THEN PieceMem% = ConvBlock%(10, 50, colormem%)
    IF sq% = 35 THEN PieceMem% = ConvBlock%(12, 50, colormem%)
    IF sq% = 36 THEN PieceMem% = ConvBlock%(14, 50, colormem%)
    IF sq% = 37 THEN PieceMem% = ConvBlock%(16, 50, colormem%)
    IF sq% = 38 THEN PieceMem% = ConvBlock%(18, 50, colormem%)
    IF sq% = 39 THEN PieceMem% = ConvBlock%(20, 50, colormem%)
    IF sq% = -1 THEN PieceMem% = ConvBlock%(24, 10, colormem%)
  END SELECT
END FUNCTION

' calculate a random number in specified range
FUNCTION RandomNum% (min%, max%)
  RandomNum% = INT((RND * max%) + min%)
END FUNCTION

' saves a game to a save slot
SUB SaveGame
  ClearSub
  SHARED Deed() AS property, Stats() AS Player, turn%
  OPEN "MONOPOLY.SAV" FOR BINARY AS #1
  IF LOF(1) = 0 THEN
    CLOSE #1
    CreateFile
  ELSE
    CLOSE #1
  END IF
  OPEN "MONOPOLY.SAV" FOR RANDOM AS #1 LEN = FPROP + (FPLAY * 2) + 1
  FIELD #1, FPROP AS sprop$, FPLAY AS spl1$, FPLAY AS spl2$, 1 AS tnum$
  DO
    FOR c% = 1 TO 3
      GET #1, c%
      LOCATE c% + 9, 59
      IF sprop$ = SPACE$(FPROP) THEN
        PRINT USING "#_.  Slot empty"; c%
      ELSE
        PRINT USING "#_.  & vs &"; c%; LEFT$(spl1$, 8); LEFT$(spl2$, 8)
      END IF
    NEXT c%
    LOCATE 13, 59: PRINT "4.  Erase slot"
    LOCATE 14, 59: PRINT "5.  Never Mind"
    LOCATE 15, 59: PRINT "                      "
    LOCATE 16, 59: PRINT "                      "
    DO
      ch% = Digit%
    LOOP UNTIL ch% >= 1 AND ch% <= 5
    IF ch% <> 4 THEN EXIT DO
    LOCATE 13, 59: PRINT "4.  Go back to save"
    LOCATE 14, 59: PRINT "                      "
    DO
      ch% = Digit%
    LOOP UNTIL ch% >= 1 AND ch% <= 4
    IF ch% < 4 THEN
      GET #1, ch%
      LSET sprop$ = SPACE$(FPROP)
      LSET spl1$ = SPACE$(FPLAY)
      LSET spl2$ = SPACE$(FPLAY)
      PUT #1, ch%
    END IF
  LOOP
  IF ch% <> 5 THEN
    GET #1, ch%
    FOR c% = 1 TO 28
      d% = 1 + ((c% - 1) * 4)
      MID$(sprop$, d%, 1) = LTRIM$(STR$(Deed(c%).Houses))
      IF Deed(c%).Monopoly = TRUE THEN MID$(sprop$, d% + 1, 1) = "1" ELSE MID$(sprop$, d% + 1, 1) = "0"
      MID$(sprop$, d% + 2, 1) = LTRIM$(STR$(Deed(c%).Owner))
      IF Deed(c%).Mortgaged = TRUE THEN MID$(sprop$, d% + 3, 1) = "1" ELSE MID$(sprop$, d% + 4, 1) = "0"
    NEXT c%
    MID$(spl1$, 1, 8) = Stats(1).ID
    MID$(spl1$, 9, 1) = Stats(1).Piece
    IF Stats(1).ChanceFree = TRUE THEN MID$(spl1$, 10, 1) = "1" ELSE MID$(spl1$, 10, 1) = "0"
    IF Stats(1).ChestFree = TRUE THEN MID$(spl1$, 11, 1) = "1" ELSE MID$(spl1$, 11, 1) = "0"
    MID$(spl1$, 12, 2) = ZeroFix$(Stats(1).Position, 2)
    MID$(spl1$, 14, 5) = ZeroFix$(Stats(1).Money, 5)
    MID$(spl2$, 1, 8) = Stats(2).ID
    MID$(spl2$, 9, 1) = Stats(2).Piece
    IF Stats(2).ChanceFree = TRUE THEN MID$(spl2$, 10, 1) = "1" ELSE MID$(spl2$, 10, 1) = "0"
    IF Stats(2).ChestFree = TRUE THEN MID$(spl2$, 11, 1) = "1" ELSE MID$(spl2$, 11, 1) = "0"
    MID$(spl2$, 12, 2) = ZeroFix$(Stats(2).Position, 2)
    MID$(spl2$, 14, 5) = ZeroFix$(Stats(2).Money, 5)
    LSET tnum$ = LTRIM$(STR$(turn%))
    PUT #1, ch%
  END IF
  CLOSE #1
  DashBoard
END SUB

SUB shareware
COLOR 3
LOCATE 8, 1: centermain "              Shareware!Shareware!Shareware!Shareware!"
LOCATE 9, 1: centermain "              Shareware!Shareware!Shareware!Shareware!"
LOCATE 10, 1: centermain "              Shareware!Shareware!Shareware!Shareware!"
LOCATE 11, 1: centermain "              Shareware!Shareware!Shareware!Shareware!"
LOCATE 12, 1: centermain "              Shareware!Shareware!Shareware!Shareware!"
LOCATE 13, 1: centermain "              Shareware!Shareware!Shareware!Shareware!"
LOCATE 14, 1: centermain "              Shareware!Shareware!Shareware!Shareware!"
COLOR 7, 0
END SUB

' shows number of houses for each monopoly on the board
SUB ShowHouses
  SHARED Deed() AS property, Houses%, hotels%
  IF Deed(1).Monopoly = TRUE THEN
    POKE ConvBlock%(22, 50, 0), ASC(HouseChar$(1))
    POKE ConvBlock%(22, 50, 1), ConvColor%(7, 2)
    POKE ConvBlock%(22, 40, 0), ASC(HouseChar$(2))
    POKE ConvBlock%(22, 40, 1), ConvColor%(7, 2)
  ELSE
    POKE ConvBlock%(22, 50, 1), ConvColor%(0, 0)
    POKE ConvBlock%(22, 40, 1), ConvColor%(0, 0)
  END IF
  IF Deed(4).Monopoly = TRUE THEN
    POKE ConvBlock%(22, 25, 0), ASC(HouseChar$(4))
    POKE ConvBlock%(22, 25, 1), ConvColor%(7, 2)
    POKE ConvBlock%(22, 15, 0), ASC(HouseChar$(5))
    POKE ConvBlock%(22, 15, 1), ConvColor%(7, 2)
    POKE ConvBlock%(22, 10, 0), ASC(HouseChar$(6))
    POKE ConvBlock%(22, 10, 1), ConvColor%(7, 2)
  ELSE
    POKE ConvBlock%(22, 25, 1), ConvColor%(0, 0)
    POKE ConvBlock%(22, 15, 1), ConvColor%(0, 0)
    POKE ConvBlock%(22, 10, 1), ConvColor%(0, 0)
  END IF
  IF Deed(7).Monopoly = TRUE THEN
    POKE ConvBlock%(20, 5, 0), ASC(HouseChar$(7))
    POKE ConvBlock%(20, 5, 1), ConvColor%(7, 2)
    POKE ConvBlock%(16, 5, 0), ASC(HouseChar$(9))
    POKE ConvBlock%(16, 5, 1), ConvColor%(7, 2)
    POKE ConvBlock%(14, 5, 0), ASC(HouseChar$(10))
    POKE ConvBlock%(14, 5, 1), ConvColor%(7, 2)
  ELSE
    POKE ConvBlock%(20, 5, 1), ConvColor%(0, 0)
    POKE ConvBlock%(16, 5, 1), ConvColor%(0, 0)
    POKE ConvBlock%(14, 5, 1), ConvColor%(0, 0)
  END IF
  IF Deed(12).Monopoly = TRUE THEN
    POKE ConvBlock%(10, 5, 0), ASC(HouseChar$(12))
    POKE ConvBlock%(10, 5, 1), ConvColor%(7, 2)
    POKE ConvBlock%(6, 5, 0), ASC(HouseChar$(13))
    POKE ConvBlock%(6, 5, 1), ConvColor%(7, 2)
    POKE ConvBlock%(4, 5, 0), ASC(HouseChar$(14))
    POKE ConvBlock%(4, 5, 1), ConvColor%(7, 2)
  ELSE
    POKE ConvBlock%(10, 5, 1), ConvColor%(0, 0)
    POKE ConvBlock%(6, 5, 1), ConvColor%(0, 0)
    POKE ConvBlock%(4, 5, 1), ConvColor%(0, 0)
  END IF
  IF Deed(15).Monopoly = TRUE THEN
    POKE ConvBlock%(2, 10, 0), ASC(HouseChar$(15))
    POKE ConvBlock%(2, 10, 1), ConvColor%(7, 2)
    POKE ConvBlock%(2, 20, 0), ASC(HouseChar$(16))
    POKE ConvBlock%(2, 20, 1), ConvColor%(7, 2)
    POKE ConvBlock%(2, 25, 0), ASC(HouseChar$(17))
    POKE ConvBlock%(2, 25, 1), ConvColor%(7, 2)
  ELSE
    POKE ConvBlock%(2, 10, 1), ConvColor%(0, 0)
    POKE ConvBlock%(2, 20, 1), ConvColor%(0, 0)
    POKE ConvBlock%(2, 25, 1), ConvColor%(0, 0)
  END IF
  IF Deed(19).Monopoly = TRUE THEN
    POKE ConvBlock%(2, 35, 0), ASC(HouseChar$(19))
    POKE ConvBlock%(2, 35, 1), ConvColor%(7, 2)
    POKE ConvBlock%(2, 40, 0), ASC(HouseChar$(20))
    POKE ConvBlock%(2, 40, 1), ConvColor%(7, 2)
    POKE ConvBlock%(2, 50, 0), ASC(HouseChar$(22))
    POKE ConvBlock%(2, 50, 1), ConvColor%(7, 2)
  ELSE
    POKE ConvBlock%(2, 35, 1), ConvColor%(0, 0)
    POKE ConvBlock%(2, 40, 1), ConvColor%(0, 0)
    POKE ConvBlock%(2, 50, 1), ConvColor%(0, 0)
  END IF
  IF Deed(23).Monopoly = TRUE THEN
    POKE ConvBlock%(4, 51, 0), ASC(HouseChar$(23))
    POKE ConvBlock%(4, 51, 1), ConvColor%(7, 2)
    POKE ConvBlock%(6, 51, 0), ASC(HouseChar$(24))
    POKE ConvBlock%(6, 51, 1), ConvColor%(7, 2)
    POKE ConvBlock%(10, 51, 0), ASC(HouseChar$(25))
    POKE ConvBlock%(10, 51, 1), ConvColor%(7, 2)
  ELSE
    POKE ConvBlock%(4, 51, 1), ConvColor%(0, 0)
    POKE ConvBlock%(6, 51, 1), ConvColor%(0, 0)
    POKE ConvBlock%(10, 51, 1), ConvColor%(0, 0)
  END IF
  IF Deed(27).Monopoly = TRUE THEN
    POKE ConvBlock%(16, 51, 0), ASC(HouseChar$(27))
    POKE ConvBlock%(16, 51, 1), ConvColor%(7, 2)
    POKE ConvBlock%(20, 51, 0), ASC(HouseChar$(28))
    POKE ConvBlock%(20, 51, 1), ConvColor%(7, 2)
  ELSE
    POKE ConvBlock%(16, 51, 1), ConvColor%(0, 0)
    POKE ConvBlock%(20, 51, 1), ConvColor%(0, 0)
  END IF
  IF Houses% >= 10 THEN hou$ = LTRIM$(STR$(Houses%)) ELSE hou$ = STR$(Houses%)
  IF hotels% >= 10 THEN hot$ = LTRIM$(STR$(hotels%)) ELSE hot$ = STR$(hotels%)
  POKE ConvBlock%(24, 29, 0), ASC(LEFT$(hou$, 1))
  POKE ConvBlock%(24, 30, 0), ASC(RIGHT$(hou$, 1))
  POKE ConvBlock%(24, 41, 0), ASC(LEFT$(hot$, 1))
  POKE ConvBlock%(24, 42, 0), ASC(RIGHT$(hot$, 1))
END SUB

' help calculate amount of RRs owned
SUB ThreeRR (x%, y%, z%)
  SHARED Deed() AS property
  IF Deed(x%).Owner = Deed(y%).Owner AND Deed(x%).Owner = Deed(z%).Owner AND Deed(x%).Owner <> BANK THEN
    Deed(x%).Houses = 3
    Deed(y%).Houses = 3
    Deed(z%).Houses = 3
  END IF
END SUB

' displays title deed
SUB TitleDeed (prop%)
  SHARED Deed() AS property
  COLOR 7, 0
  ClearMain
  LOCATE 5, 24: PRINT "Title Deed"
  LOCATE 7, 1: centermain RTRIM$(Deed(prop%).Title)
  SELECT CASE Deed(prop%).Style
  CASE GROUP
    LOCATE 8, 27: PRINT USING "Rent _$  ##"; Deed(prop%).Rent
    LOCATE 9, 24: PRINT USING "1 House   ###"; Deed(prop%).House1
    LOCATE 10, 23: PRINT USING "2 Houses   ###"; Deed(prop%).House2
    LOCATE 11, 23: PRINT USING "3 Houses  ####"; Deed(prop%).House3
    LOCATE 12, 23: PRINT USING "4 Houses  ####"; Deed(prop%).House4
    LOCATE 13, 26: PRINT USING "Hotel  ####"; Deed(prop%).Hotel
    LOCATE 14, 20: PRINT USING "Houses Cost   ###"; Deed(prop%).HouseCost
    LOCATE 15, 17: PRINT USING "Mortgage Value   ###"; Deed(prop%).MortValue
    LOCATE 17, 27: PRINT USING "Cost   ###"; Deed(prop%).Cost
  CASE RR
    LOCATE 8, 14: PRINT USING "If 1 RR is owned _$  ##"; Deed(prop%).House1
    LOCATE 9, 13: PRINT USING "If 2 RR are owned    ##"; Deed(prop%).House2
    LOCATE 10, 13: PRINT USING "If 3 RR are owned   ###"; Deed(prop%).House3
    LOCATE 11, 13: PRINT USING "If 4 RR are owned   ###"; Deed(prop%).House4
    LOCATE 12, 17: PRINT USING "Mortgage Value   ###"; Deed(prop%).MortValue
    LOCATE 14, 27: PRINT USING "Cost   ###"; Deed(prop%).Cost
  CASE UTIL
    LOCATE 8, 13: PRINT "If 1 util is owned, roll x 4"
    LOCATE 9, 11: PRINT "If 2 util are owned, roll x 10"
    LOCATE 10, 17: PRINT USING "Mortgage Value   ###"; Deed(prop%).MortValue
    LOCATE 12, 27: PRINT USING "Cost   ###"; Deed(prop%).Cost
  END SELECT
END SUB

' help calculate amount of RRs owned
SUB TwoRR (x%, y%)
  SHARED Deed() AS property
  IF Deed(x%).Owner = Deed(y%).Owner AND Deed(x%).Owner <> BANK THEN
    Deed(x%).Houses = 2
    Deed(y%).Houses = 2
  END IF
END SUB

' update property information
SUB Update
  SHARED Deed() AS property
  IF Deed(1).Owner = Deed(2).Owner AND Deed(1).Owner <> BANK THEN
    Deed(1).Monopoly = TRUE
    Deed(2).Monopoly = TRUE
  ELSE
    Deed(1).Monopoly = FALSE
    Deed(2).Monopoly = FALSE
  END IF
  IF Deed(4).Owner = Deed(5).Owner AND Deed(4).Owner = Deed(6).Owner AND Deed(4).Owner <> BANK THEN
    Deed(4).Monopoly = TRUE
    Deed(5).Monopoly = TRUE
    Deed(6).Monopoly = TRUE
  ELSE
    Deed(4).Monopoly = FALSE
    Deed(5).Monopoly = FALSE
    Deed(6).Monopoly = FALSE
  END IF
  IF Deed(7).Owner = Deed(9).Owner AND Deed(7).Owner = Deed(10).Owner AND Deed(7).Owner <> BANK THEN
    Deed(7).Monopoly = TRUE
    Deed(9).Monopoly = TRUE
    Deed(10).Monopoly = TRUE
  ELSE
    Deed(7).Monopoly = FALSE
    Deed(9).Monopoly = FALSE
    Deed(10).Monopoly = FALSE
  END IF
  IF Deed(12).Owner = Deed(13).Owner AND Deed(12).Owner = Deed(14).Owner AND Deed(12).Owner <> BANK THEN
    Deed(12).Monopoly = TRUE
    Deed(13).Monopoly = TRUE
    Deed(14).Monopoly = TRUE
  ELSE
    Deed(12).Monopoly = FALSE
    Deed(13).Monopoly = FALSE
    Deed(14).Monopoly = FALSE
  END IF
  IF Deed(15).Owner = Deed(16).Owner AND Deed(15).Owner = Deed(17).Owner AND Deed(15).Owner <> BANK THEN
    Deed(15).Monopoly = TRUE
    Deed(16).Monopoly = TRUE
    Deed(17).Monopoly = TRUE
  ELSE
    Deed(15).Monopoly = FALSE
    Deed(16).Monopoly = FASLE
    Deed(17).Monopoly = FALSE
  END IF
  IF Deed(19).Owner = Deed(20).Owner AND Deed(19).Owner = Deed(22).Owner AND Deed(19).Owner <> BANK THEN
    Deed(19).Monopoly = TRUE
    Deed(20).Monopoly = TRUE
    Deed(22).Monopoly = TRUE
  ELSE
    Deed(19).Monopoly = FALSE
    Deed(20).Monopoly = FALSE
    Deed(22).Monopoly = FALSE
  END IF
  IF Deed(23).Owner = Deed(24).Owner AND Deed(23).Owner = Deed(25).Owner AND Deed(25).Owner <> BANK THEN
    Deed(23).Monopoly = TRUE
    Deed(24).Monopoly = TRUE
    Deed(25).Monopoly = TRUE
  ELSE
    Deed(23).Monopoly = FALSE
    Deed(24).Monopoly = FASLE
    Deed(25).Monopoly = FALSE
  END IF
  IF Deed(27).Owner = Deed(28).Owner AND Deed(27).Owner <> BANK THEN
    Deed(27).Monopoly = TRUE
    Deed(28).Monopoly = TRUE
  ELSE
    Deed(27).Monopoly = FALSE
    Deed(28).Monopoly = FALSE
  END IF
  IF Deed(8).Owner = Deed(21).Owner AND Deed(8).Owner <> BANK THEN
    Deed(8).Houses = 2
    Deed(21).Houses = 2
  ELSEIF Deed(8).Owner = Deed(21).Owner AND Deed(8).Owner = BANK THEN
    Deed(8).Houses = 0
    Deed(21).Houses = 0
  ELSE
    IF Deed(8).Owner <> BANK THEN Deed(8).Houses = 1 ELSE Deed(8).Houses = 0
    IF Deed(21).Owner <> BANK THEN Deed(21).Houses = 1 ELSE Deed(21).Houses = 0
  END IF
  IF Deed(3).Owner = Deed(11).Owner AND Deed(18).Owner = Deed(26).Owner AND Deed(3).Owner = Deed(18).Owner AND Deed(3).Owner = BANK THEN
    Deed(3).Houses = 0
    Deed(11).Houses = 0
    Deed(18).Houses = 0
    Deed(26).Houses = 0
  END IF
  IF Deed(3).Owner <> BANK THEN
    Deed(3).Houses = 1
  ELSEIF Deed(11).Owner <> BANK THEN
    Deed(11).Houses = 1
  ELSEIF Deed(18).Owner <> BANK THEN
    Deed(18).Houses = 1
  ELSEIF Deed(26).Owner <> BANK THEN
    Deed(26).Houses = 1
  END IF
  TwoRR 3, 11
  TwoRR 3, 18
  TwoRR 3, 26
  TwoRR 11, 18
  TwoRR 11, 26
  TwoRR 18, 26
  ThreeRR 11, 18, 26
  ThreeRR 3, 18, 26
  ThreeRR 3, 11, 26
  ThreeRR 3, 11, 18
  IF Deed(3).Owner = Deed(11).Owner AND Deed(18).Owner = Deed(26).Owner AND Deed(3).Owner = Deed(18).Owner AND Deed(3).Owner <> BANK THEN
    Deed(3).Houses = 4
    Deed(11).Houses = 4
    Deed(18).Houses = 4
    Deed(26).Houses = 4
  END IF
END SUB

' lets you buy/sell houses, mortgage/unmortgage property
SUB Utilities (pl%)
  SHARED Deed() AS property, Stats() AS Player, Houses%, hotels%
  DO
    ClearMain
    ClearSub
    LOCATE 10, 59: PRINT "M to mortgage"
    LOCATE 11, 59: PRINT "U to unmortgage"
    LOCATE 12, 59: PRINT "B to buy houses"
    LOCATE 13, 59: PRINT "S to sell houses"
    LOCATE 14, 59: PRINT "E to exit        "
    LOCATE 15, 59: PRINT "                 "
    LOCATE 16, 59: PRINT "                 "
    DO
      o$ = UCASE$(INKEY$)
    LOOP UNTIL o$ = "M" OR o$ = "U" OR o$ = "B" OR o$ = "S" OR o$ = "E"
    IF o$ = "E" THEN
      EXIT DO
    ELSEIF o$ = "M" THEN
      FOR c% = 1 TO 28
        row% = 5 + ((c% - 1) MOD 14)
        IF c% <= 14 THEN col% = 11 ELSE col% = 40
        IF Deed(c%).Owner = pl% AND Deed(c%).Mortgaged = FALSE AND (Deed(c%).Style = GROUP IMP Deed(c%).Houses = 0) THEN
          LOCATE row%, col%: PRINT USING "## \ \"; c%; Deed(c%).Short
        END IF
      NEXT c%
      LOCATE 19, 25: PRINT "29. END"
      DO
        ClearSub
        LOCATE 10, 59: PRINT "Enter the number"
        LOCATE 11, 59: PRINT "of your"
        LOCATE 12, 59: INPUT "selection: ", di$
        di% = VAL(di$)
      LOOP UNTIL di% >= 1 AND di% <= 29
      IF di% <> 29 THEN
        IF Deed(di%).Owner = pl% AND Deed(di%).Mortgaged = FALSE THEN
          Deed(di%).Mortgaged = TRUE
          Stats(pl%).Money = Stats(pl%).Money + Deed(di%).MortValue
        END IF
      END IF
    ELSEIF o$ = "U" THEN
      FOR c% = 1 TO 28
        row% = 5 + ((c% - 1) MOD 14)
        IF c% <= 14 THEN col% = 11 ELSE col% = 40
        IF Deed(c%).Owner = pl% AND Deed(c%).Mortgaged = TRUE THEN
          LOCATE row%, col%: PRINT USING "## \ \"; c%; Deed(c%).Short
        END IF
      NEXT c%
      LOCATE 19, 25: PRINT "29. END"
      DO
        ClearSub
        LOCATE 10, 59: PRINT "Enter the number"
        LOCATE 11, 59: PRINT "of your"
        LOCATE 12, 59: INPUT "selection: ", di$
        di% = VAL(di$)
      LOOP UNTIL di% >= 1 AND di% <= 29
      IF di% <> 29 THEN
        IF Stats(pl%).Money >= Deed(di%).MortValue + (Deed(di%).MortValue * 10 / 100) THEN
          Deed(di%).Mortgaged = FALSE
          Stats(pl%).Money = Stats(pl%).Money - (Deed(di%).MortValue + (Deed(di%).MortValue * 10 / 100))
        ELSEIF Stats(pl%).Money < Deed(di%).MortValue + (Deed(di%).MortValue * 10 / 100) THEN
          ClearSub
          LOCATE 10, 59: PRINT USING "You don't have ###_!"; Deed(di%).MortValue + (Deed(di%).MortValue * 10 / 100)
          SLEEP 3
        END IF
      END IF
    ELSEIF o$ = "B" THEN
      ClearSub
      IF Deed(1).Owner = pl% AND Deed(1).Monopoly = TRUE AND Deed(1).Houses < 5 AND (Deed(1).Mortgaged = FALSE AND Deed(2).Mortgaged = FALSE) THEN LOCATE 7, 18: PRINT "1     MED/BAL"
      IF Deed(4).Owner = pl% AND Deed(4).Monopoly = TRUE AND Deed(4).Houses < 5 AND (Deed(4).Mortgaged = FALSE AND Deed(5).Mortgaged = FALSE AND Deed(6).Mortgaged = FALSE) THEN LOCATE 8, 18: PRINT "2 ORI/VEN/CON"
      IF Deed(7).Owner = pl% AND Deed(7).Monopoly = TRUE AND Deed(7).Houses < 5 AND (Deed(7).Mortgaged = FALSE AND Deed(9).Mortgaged = FALSE AND Deed(10).Mortgaged = FALSE) THEN LOCATE 9, 18: PRINT "3 STC/STA/VIR"
      IF Deed(12).Owner = pl% AND Deed(12).Monopoly = TRUE AND Deed(12).Houses < 5 AND (Deed(12).Mortgaged = FALSE AND Deed(13).Mortgaged = FALSE AND Deed(14).Mortgaged = FALSE) THEN LOCATE 10, 18: PRINT "4 STJ/TEN/NEW"
      IF Deed(15).Owner = pl% AND Deed(15).Monopoly = TRUE AND Deed(15).Houses < 5 AND (Deed(15).Mortgaged = FALSE AND Deed(16).Mortgaged = FALSE AND Deed(17).Mortgaged = FALSE) THEN LOCATE 11, 18: PRINT "5 KEN/IND/ILL"
      IF Deed(19).Owner = pl% AND Deed(19).Monopoly = TRUE AND Deed(19).Houses < 5 AND (Deed(19).Mortgaged = FALSE AND Deed(20).Mortgaged = FALSE AND Deed(22).Mortgaged = FALSE) THEN LOCATE 12, 18: PRINT "6 ATL/VEN/MAR"
      IF Deed(23).Owner = pl% AND Deed(23).Monopoly = TRUE AND Deed(23).Houses < 5 AND (Deed(23).Mortgaged = FALSE AND Deed(24).Mortgaged = FALSE AND Deed(25).Mortgaged = FALSE) THEN LOCATE 13, 18: PRINT "7 PAC/NOC/PEN"
      IF Deed(27).Owner = pl% AND Deed(27).Monopoly = TRUE AND Deed(27).Houses < 5 AND (Deed(27).Mortgaged = FALSE AND Deed(28).Mortgaged = FALSE) THEN LOCATE 14, 18: PRINT "8 PAR/BOA"
      LOCATE 15, 18: PRINT "9 END"
      LOCATE 10, 59: PRINT "Choose the monopoly."
      DO
        di% = Digit%
      LOOP UNTIL di% >= 1 AND di% <= 9
      IF di% = 1 AND (Deed(1).Owner <> pl% OR Deed(1).Monopoly = FALSE OR Deed(1).Houses = 5) THEN
        di% = 9
      ELSEIF di% = 1 THEN
        x% = 1
        y% = 2
      END IF
      IF di% = 2 AND (Deed(4).Owner <> pl% OR Deed(4).Monopoly = FALSE OR Deed(4).Houses = 5) THEN
        di% = 9
      ELSEIF di% = 2 THEN
        x% = 4
        y% = 5
        z% = 6
      END IF
      IF di% = 3 AND (Deed(7).Owner <> pl% OR Deed(7).Monopoly = FALSE OR Deed(7).Houses = 5) THEN
        di% = 9
      ELSEIF di% = 3 THEN
        x% = 7
        y% = 9
        z% = 10
      END IF
      IF di% = 4 AND (Deed(12).Owner <> pl% OR Deed(12).Monopoly = FALSE OR Deed(12).Houses = 5) THEN
        di% = 9
      ELSEIF di% = 4 THEN
        x% = 12
        y% = 13
        z% = 14
      END IF
      IF di% = 5 AND (Deed(15).Owner <> pl% OR Deed(15).Monopoly = FALSE OR Deed(15).Houses = 5) THEN
        di% = 9
      ELSEIF di% = 5 THEN
        x% = 15
        y% = 16
        z% = 17
      END IF
      IF di% = 6 AND (Deed(19).Owner <> pl% OR Deed(19).Monopoly = FALSE OR Deed(19).Houses = 5) THEN
        di% = 9
      ELSEIF di% = 6 THEN
        x% = 19
        y% = 20
        z% = 22
      END IF
      IF di% = 7 AND (Deed(23).Owner <> pl% OR Deed(23).Monopoly = FALSE OR Deed(23).Houses = 5) THEN
        di% = 9
      ELSEIF di% = 7 THEN
        x% = 23
        y% = 24
        z% = 25
      END IF
      IF di% = 8 AND (Deed(27).Owner <> pl% OR Deed(27).Monopoly = FALSE OR Deed(27).Houses = 5) THEN
        di% = 9
      ELSEIF di% = 8 THEN
        x% = 27
        y% = 28
      END IF
      IF di% = 1 OR di% = 8 THEN
        ClearSub
        IF Deed(x%).Houses < 4 THEN
          maxi% = 8 - (Deed(x%).Houses + Deed(y%).Houses)
          IF Stats(pl%).Money < maxi% * Deed(x%).HouseCost THEN maxi% = Stats(pl%).Money \ Deed(pl%).HouseCost
          IF maxi% > Houses% THEN maxi% = Houses%
          LOCATE 10, 59: PRINT USING "Houses: $$### each"; Deed(x%).HouseCost
          LOCATE 11, 59: PRINT USING "You can buy up to ##"; maxi%
          DO
            LOCATE 12, 59: PRINT "                "
            LOCATE 12, 59: INPUT "How many? ", h%
          LOOP UNTIL h% >= 0 AND h% <= maxi%
          Stats(pl%).Money = Stats(pl%).Money - (h% * Deed(x%).HouseCost)
          Houses% = Houses% - h%
          WHILE h% > 0
            IF Deed(x%).Houses > Deed(y%).Houses THEN
              Deed(y%).Houses = Deed(y%).Houses + 1
            ELSE
              Deed(x%).Houses = Deed(x%).Houses + 1
            END IF
            h% = h% - 1
          WEND
          
        ELSE
          maxi% = 2 - ((Deed(x%).Houses - 4) + (Deed(y%).Houses - 4))
          IF Stats(pl%).Money < maxi% * Deed(x%).HouseCost THEN maxi% = Stats(pl%).Money \ Deed(x%).HouseCost
          IF maxi% > hotels% THEN maxi% = hotels%
          LOCATE 10, 59: PRINT USING "Hotels: $$### each"; Deed(di%).HouseCost
          LOCATE 11, 59: PRINT USING "You can buy up to #"; maxi%
          DO
            LOCATE 12, 59: PRINT "                  "
            LOCATE 12, 59: INPUT "How many? "; h%
          LOOP UNTIL h% >= 0 AND h% <= maxi%
          Stats(pl%).Money = Stats(pl%).Money - (h% * Deed(x%).HouseCost)
          hotels% = hotels% - h%
          Houses% = Houses% + (h% * 4)
          WHILE h% > 0
            IF Deed(x%).Houses > Deed(y%).Houses THEN
              Deed(y%).Houses = Deed(y%).Houses + 1
            ELSE
              Deed(x%).Houses = Deed(x%).Houses + 1
            END IF
            h% = h% - 1
          WEND
        END IF
      ELSEIF di% >= 2 AND di% <= 8 THEN
        ClearSub
        IF Deed(x%).Houses < 4 THEN
          maxi% = 12 - (Deed(x%).Houses + Deed(y%).Houses + Deed(z%).Houses)
          IF Stats(pl%).Money < maxi% * Deed(x%).HouseCost THEN maxi% = Stats(pl%).Money \ Deed(x%).HouseCost
          IF maxi% > Houses% THEN maxi% = Houses%
          LOCATE 10, 59: PRINT USING "Houses cost $$###"; Deed(x%).HouseCost
          LOCATE 11, 59: PRINT USING "You can buy up to ##"; maxi%
          DO
            LOCATE 12, 59: PRINT "                "
            LOCATE 12, 59: INPUT "How many? ", h%
          LOOP UNTIL h% >= 0 AND h% <= maxi%
          Stats(pl%).Money = Stats(pl%).Money - (h% * Deed(x%).HouseCost)
          Houses% = Houses% - h%
          WHILE h% > 0
            IF Deed(x%).Houses = Deed(y%).Houses AND Deed(x%).Houses > Deed(z%).Houses THEN
              Deed(z%).Houses = Deed(z%).Houses + 1
            ELSEIF Deed(x%).Houses > Deed(y%).Houses THEN
              Deed(y%).Houses = Deed(y%).Houses + 1
            ELSE
              Deed(x%).Houses = Deed(x%).Houses + 1
            END IF
            h% = h% - 1
          WEND
          
        ELSE
          maxi% = 3 - ((Deed(x%).Houses - 4) + (Deed(y%).Houses - 4) + (Deed(z%).Houses - 4))
          IF Stats(pl%).Money < maxi% * Deed(x%).HouseCost THEN maxi% = Stats(pl%).Money \ Deed(x%).HouseCost
          IF maxi% > hotels% THEN maxi% = hotels%
          LOCATE 10, 59: PRINT USING "Hotels cost $$###"; Deed(x%).HouseCost
          LOCATE 11, 59: PRINT USING "You can buy up to #"; maxi%
          DO
            LOCATE 12, 59: PRINT "               "
            LOCATE 12, 59: INPUT "How many? ", h%
          LOOP UNTIL h% >= 0 AND h% <= maxi%
          Stats(pl%).Money = Stats(pl%).Money - (h% * Deed(x%).HouseCost)
          hotels% = hotels% - h%
          Houses% = Houses% + (h% * 4)
          WHILE h% > 0
            IF Deed(x%).Houses = Deed(y%).Houses AND Deed(x%).Houses > Deed(z%).Houses THEN
              Deed(z%).Houses = Deed(z%).Houses + 1
            ELSEIF Deed(x%).Houses > Deed(y%).Houses THEN
              Deed(y%).Houses = Deed(y%).Houses + 1
            ELSE
              Deed(x%).Houses = Deed(x%).Houses + 1
            END IF
            h% = h% - 1
          WEND
        END IF
      END IF
    ELSEIF o$ = "S" THEN
      ClearSub
      IF Deed(1).Owner = pl% AND Deed(1).Monopoly = TRUE AND Deed(1).Houses > 0 AND (Deed(1).Mortgaged = FALSE AND Deed(2).Mortgaged = FALSE) THEN LOCATE 7, 18: PRINT "1     MED/BAL"
      IF Deed(4).Owner = pl% AND Deed(4).Monopoly = TRUE AND Deed(4).Houses > 0 AND (Deed(4).Mortgaged = FALSE AND Deed(5).Mortgaged = FALSE AND Deed(6).Mortgaged = FALSE) THEN LOCATE 8, 18: PRINT "2 ORI/VEN/CON"
      IF Deed(7).Owner = pl% AND Deed(7).Monopoly = TRUE AND Deed(7).Houses > 0 AND (Deed(7).Mortgaged = FALSE AND Deed(9).Mortgaged = FALSE AND Deed(10).Mortgaged = FALSE) THEN LOCATE 9, 18: PRINT "3 STC/STA/VIR"
      IF Deed(12).Owner = pl% AND Deed(12).Monopoly = TRUE AND Deed(12).Houses > 0 AND (Deed(12).Mortgaged = FALSE AND Deed(13).Mortgaged = FALSE AND Deed(14).Mortgaged = FALSE) THEN LOCATE 10, 18: PRINT "4 STJ/TEN/NEW"
      IF Deed(15).Owner = pl% AND Deed(15).Monopoly = TRUE AND Deed(15).Houses > 0 AND (Deed(15).Mortgaged = FALSE AND Deed(16).Mortgaged = FALSE AND Deed(17).Mortgaged = FALSE) THEN LOCATE 11, 18: PRINT "5 KEN/IND/ILL"
      IF Deed(19).Owner = pl% AND Deed(19).Monopoly = TRUE AND Deed(19).Houses > 0 AND (Deed(19).Mortgaged = FALSE AND Deed(20).Mortgaged = FALSE AND Deed(22).Mortgaged = FALSE) THEN LOCATE 12, 18: PRINT "6 ATL/VEN/MAR"
      IF Deed(23).Owner = pl% AND Deed(23).Monopoly = TRUE AND Deed(23).Houses > 0 AND (Deed(23).Mortgaged = FALSE AND Deed(24).Mortgaged = FALSE AND Deed(25).Mortgaged = FALSE) THEN LOCATE 13, 18: PRINT "7 PAC/NOC/PEN"
      IF Deed(27).Owner = pl% AND Deed(27).Monopoly = TRUE AND Deed(27).Houses > 0 AND (Deed(27).Mortgaged = FALSE AND Deed(28).Mortgaged = FALSE) THEN LOCATE 14, 18: PRINT "8 PAR/BOA"
      LOCATE 15, 18: PRINT "9 END"
      LOCATE 10, 59: PRINT "Choose the monopoly."
      DO
        di% = Digit%
      LOOP UNTIL di% >= 1 AND di% <= 9
      IF di% = 1 AND (Deed(1).Owner <> pl% OR Deed(1).Monopoly = FALSE OR Deed(4).Houses = 0) THEN
        di% = 9
      ELSEIF di% = 1 THEN
        x% = 1
        y% = 2
      END IF
      IF di% = 2 AND (Deed(4).Owner <> pl% OR Deed(4).Monopoly = FALSE OR Deed(6).Houses = 0) THEN
        di% = 9
      ELSEIF di% = 2 THEN
        x% = 4
        y% = 5
        z% = 6
      END IF
      IF di% = 3 AND (Deed(7).Owner <> pl% OR Deed(7).Monopoly = FALSE OR Deed(10).Houses = 0) THEN
        di% = 9
      ELSEIF di% = 3 THEN
        x% = 7
        y% = 9
        z% = 10
      END IF
      IF di% = 4 AND (Deed(12).Owner <> pl% OR Deed(12).Monopoly = FALSE OR Deed(14).Houses = 0) THEN
        di% = 9
      ELSEIF di% = 4 THEN
        x% = 12
        y% = 13
        z% = 14
      END IF
      IF di% = 5 AND (Deed(15).Owner <> pl% OR Deed(15).Monopoly = FALSE OR Deed(17).Houses = 0) THEN
        di% = 9
      ELSEIF di% = 5 THEN
        x% = 15
        y% = 16
        z% = 17
      END IF
      IF di% = 6 AND (Deed(19).Owner <> pl% OR Deed(19).Monopoly = FALSE OR Deed(22).Houses = 0) THEN
        di% = 9
      ELSEIF di% = 6 THEN
        x% = 19
        y% = 20
        z% = 22
      END IF
      IF di% = 7 AND (Deed(23).Owner <> pl% OR Deed(23).Monopoly = FALSE OR Deed(25).Houses = 0) THEN
        di% = 9
      ELSEIF di% = 7 THEN
        x% = 23
        y% = 24
        z% = 25
      END IF
      IF di% = 8 AND (Deed(27).Owner <> pl% OR Deed(27).Monopoly = FALSE OR Deed(28).Houses = 0) THEN
        di% = 9
      ELSEIF di% = 8 THEN
        x% = 27
        y% = 28
      END IF

      IF di% = 1 OR di% = 8 THEN
        ClearSub
        IF Deed(x%).Houses <= 4 THEN
          maxi% = Deed(x%).Houses + Deed(y%).Houses
          LOCATE 10, 59: PRINT USING "Houses: $$### each"; Deed(x%).HouseCost
          LOCATE 11, 59: PRINT USING "You can sell up to ##"; maxi%
          DO
            LOCATE 12, 59: PRINT "                "
            LOCATE 12, 59: INPUT "How many? "; h%
          LOOP UNTIL h% >= 0 AND h% <= maxi%
          Stats(pl%).Money = Stats(pl%).Money + (h% * Deed(x%).HouseCost)
          Houses% = Houses% + h%
          WHILE h% > 0
            IF Deed(y%).Houses < Deed(x%).Houses THEN
              Deed(x%).Houses = Deed(x%).Houses - 1
            ELSE
              Deed(y%).Houses = Deed(y%).Houses - 1
            END IF
            h% = h% - 1
          WEND
          
        ELSE
          maxi% = (Deed(x%).Houses - 4) + (Deed(y%).Houses - 4)
          IF Houses% < maxi * 4 THEN maxi% = Houses% \ 4
          LOCATE 10, 59: PRINT USING "Hotels: $$### each"; Deed(di%).HouseCost
          LOCATE 11, 59: PRINT USING "You can sell up to #"; maxi%
          DO
            LOCATE 12, 59: PRINT "                  "
            LOCATE 12, 59: INPUT "How many? "; h%
          LOOP UNTIL h% >= 0 AND h% <= maxi%
          Stats(pl%).Money = Stats(pl%).Money + (h% * Deed(x%).HouseCost)
          hotels% = hotels% + h%
          Houses% = Houses% - (h% * 4)
          WHILE h% > 0
            IF Deed(y%).Houses > Deed(x%).Houses THEN
              Deed(x%).Houses = Deed(x%).Houses - 1
            ELSE
              Deed(y%).Houses = Deed(y%).Houses - 1
            END IF
            h% = h% - 1
          WEND
        END IF
      ELSEIF di% >= 2 AND di% <= 8 THEN
        ClearSub
        IF Deed(x%).Houses <= 4 THEN
          maxi% = Deed(x%).Houses + Deed(y%).Houses + Deed(z%).Houses
          LOCATE 10, 59: PRINT USING "Houses cost $$###"; Deed(x%).HouseCost
          LOCATE 11, 59: PRINT USING "You can sell up to ##"; maxi%
          DO
            LOCATE 12, 59: PRINT "                "
            LOCATE 12, 59: INPUT "How many? ", h%
          LOOP UNTIL h% >= 0 AND h% <= maxi%
          Stats(pl%).Money = Stats(pl%).Money + (h% * Deed(x%).HouseCost)
          Houses% = Houses% + h%
          WHILE h% > 0
            IF Deed(z%).Houses = Deed(y%).Houses AND Deed(z%).Houses < Deed(x%).Houses THEN
              Deed(x%).Houses = Deed(x%).Houses - 1
            ELSEIF Deed(z%).Houses < Deed(y%).Houses THEN
              Deed(y%).Houses = Deed(y%).Houses - 1
            ELSE
              Deed(z%).Houses = Deed(z%).Houses - 1
            END IF
            h% = h% - 1
          WEND
          
        ELSE
          maxi% = (Deed(x%).Houses - 4) + (Deed(y%).Houses - 4) + (Deed(z%).Houses - 4)
          IF Houses% < maxi% * 4 THEN maxi% = Houses% \ 4
          LOCATE 10, 59: PRINT USING "Hotels cost $$###"; Deed(x%).HouseCost
          LOCATE 11, 59: PRINT USING "You can sell up to #"; maxi%
          DO
            LOCATE 12, 59: PRINT "               "
            LOCATE 12, 59: INPUT "How many? ", h%
          LOOP UNTIL h% >= 0 AND h% <= maxi%
          Stats(pl%).Money = Stats(pl%).Money + (h% * Deed(x%).HouseCost)
          hotels% = hotels% + h%
          Houses% = Houses% - (h% * 4)
              WHILE h% > 0
            IF Deed(z%).Houses = Deed(y%).Houses AND Deed(z%).Houses > Deed(x%).Houses THEN
              Deed(x%).Houses = Deed(x%).Houses - 1
            ELSEIF Deed(z%).Houses > Deed(y%).Houses THEN
              Deed(y%).Houses = Deed(y%).Houses - 1
            ELSE
              Deed(z%).Houses = Deed(z%).Houses - 1
            END IF
            h% = h% - 1
          WEND
        END IF
      END IF
    END IF

    DashBoard
    ShowHouses
  LOOP UNTIL o$ = "E"
  ClearSub
END SUB

' wait for keypress
SUB WaitForKey
  SLEEP
  trash$ = INKEY$
END SUB

' gives the `you win' message
SUB Winner (pl%)
  SHARED Deed() AS property, Stats() AS Player
  ClearSub
  ClearMain
  Stats(Opponent%(pl%)).Money = 0
  FOR c% = 1 TO 28
    IF Deed(c%).Owner = Opponent%(pl%) THEN Deed(c%).Owner = BANK
  NEXT c%
  DashBoard
  LOCATE 10, 59: PRINT USING "& is bankrupt_."; Stats(Opponent%(pl%)).ID
  LOCATE 11, 59: PRINT USING "Congrats_, &_,"; Stats(pl%).ID
  LOCATE 12, 59: PRINT "you win!"
  LOCATE 13, 59: PRINT "Thanks for playing!"
  END
END SUB

' turns num% to a string of length amt%
FUNCTION ZeroFix$ (num%, amt%)
  temp$ = LTRIM$(STR$(num%))
  DO UNTIL LEN(temp$) = amt%
    temp$ = "0" + temp$
  LOOP
  ZeroFix$ = temp$
END FUNCTION

