'               BBBB  L     U   U EEEEE TTTTT  AAA  N   N K  K
'               B   B L     U   U E       T   A   A NN  N K K
'               BBBB  L     U   U EEEE    T   AAAAA N N N KK
'               B   B L     U   U E       T   A   A N  NN K K
'               BBBB  LLLLL UUUUU EEEEE   T   A   A N   N K  K
'                         __________________________
'               #Û       |o|       BLUETANK       |o|       Û#
'               #Û       |-|----------------------|-|       Û#
'               #Û       |o|      is derived      |o|       Û#
'          ===  #Û  ===  |-|----------------------|-|  ===  Û#  ===
'         ==== ###Û===== |o|   from the classic   |o| =====Û### ====
'         === #####Û==== |-|----------------------|-| ====Û##### ===
'         == #######Û=== |o|      TANKBATTLE      |o| ===Û####### ==
'         == #######Û=== |-|----------------------|-| ===Û####### ==
'         === #####Û==== |o| Enjoy, Reinder Glas  |o| ====Û##### ===
'         ==== ###Û===== |-|----------------------|-| =====Û### ====
'          ===      ===  |o|glas400@hio.tem.nhl.nl|o|  ===      ===
'                         --------------------------
REM $STATIC
DEFINT A-Z

REM Make user-defined types.

TYPE BOOL
        v AS INTEGER    ' Its (v)alue.
END TYPE

TYPE TANK
        i AS INTEGER    ' Its (i)d.
        a AS BOOL       ' Is it (a)ctive?
        h AS BOOL       ' Where it (h)it by a opponent missile or tank?
        x AS INTEGER    ' Its (x) position.
        y AS INTEGER    ' Its (y) position.
        d AS INTEGER    ' Which sprite to (d)raw. (for animation effect)
        m AS INTEGER    ' Its (m)ove direction.
        s AS INTEGER    ' Its (s)peed.
END TYPE
      
TYPE MISSILE
        f AS INTEGER    ' (F)ired by TANK.i where TANK.i = f.
        a AS BOOL       ' Is it (a)ctive?
        h AS BOOL       ' Did it (h)it a opponent tank or wall?
        x AS INTEGER    ' Its (x) position.
        y AS INTEGER    ' Its (y) position.
        m AS INTEGER    ' Its (m)ove direction.
        s AS INTEGER    ' Its (s)peed.
END TYPE

TYPE GAMEPARAMETERS
        playersleft AS INTEGER  ' Current number of players.
        enemies AS INTEGER      ' Number of enemies at start.
        enemiesleft  AS INTEGER ' Current number of enemies.
        basetime AS LONG        ' Current time in seconds.
        time AS INTEGER         ' Time at start.
        timeleft AS INTEGER     ' Current time left.
        score AS LONG           ' The score.
END TYPE

REM Make functions and sub's

DECLARE FUNCTION DidMissileHitOpponentTank% (m AS MISSILE)      ' BOOL.v = %
DECLARE FUNCTION DidMissileHitWall% (m AS MISSILE)              ' BOOL.v = %
DECLARE FUNCTION DidTankHitOpponentTank% (t AS TANK)            ' BOOL.v = %
DECLARE FUNCTION DidTankHitWall% (t AS TANK)                    ' BOOL.v = %

DECLARE SUB CalcCurrentStatus ()
DECLARE SUB CenterPrint (Row%, Col%, Size%, Text$, ForeGround%, BackGround%, Allign%)
DECLARE SUB ContinueGame ()
DECLARE SUB ControlEnemies ()
DECLARE SUB ControlPlayerOne ()
DECLARE SUB DrawMissile (m AS MISSILE)
DECLARE SUB DrawTank (t AS TANK)
DECLARE SUB Exitro ()
DECLARE SUB FireMissile (t AS TANK)
DECLARE SUB InitMap ()
DECLARE SUB InitSprites ()
DECLARE SUB Intro ()
DECLARE SUB MoveMissile (m AS MISSILE)
DECLARE SUB MoveTank (t AS TANK)
DECLARE SUB Semi32BitWaveTableSound ()
DECLARE SUB SetupEnemies ()
DECLARE SUB SetupGame ()
DECLARE SUB SetupPlayer ()
DECLARE SUB ShowGameStatus ()
DECLARE SUB UpdateMissile (m AS MISSILE)
DECLARE SUB UpdateTank (t AS TANK)

REM Make consts for use in user-defined types.

CONST FALSE = 0         ' BOOL.v
CONST TRUE = NOT FALSE  ' BOOL.v

CONST PLAYER = 0        ' TANK.i AND MISSILE.f  (opponent = ENEMY)
REM ENEMY = 1 .. N      ' TANK.i AND MISSILE.f  (opponent = PLAYER)

CONST NORTH = 0         ' TANK.m AND MISSILE.m
CONST EAST = 1          ' TANK.m AND MISSILE.m
CONST SOUTH = 2         ' TANK.m AND MISSILE.m
CONST WEST = 3          ' TANK.m AND MISSILE.m

CONST TANKSPEED = 2     ' TANK.s
CONST MISSILESPEED = 10 ' MISSILE.s

REM Make consts for global use.

CONST SPRITEMEM = 121   ' The size of an array in integers to store a sprite.
CONST SPRITEWIDTH = 20  ' The width of a sprite in pixels.
CONST SPRITELENGTH = 20 ' The lenght of a sprite in pixels.

CONST MAPWIDTH = 16     ' The width of the gamemap in sprites.
CONST MAPLENGTH = 9     ' The length of the gamemap in sprites.

CONST SCREENMODE = 7    ' The screen mode where in we are playing.
CONST GAMESCREEN = 0    ' The screen page were the full game is showed.
CONST SPRITESCREEN = 1  ' The screen page were the sprites are drawed.
CONST MAPSCREEN = 2     ' The screen page with the gamemap.

CONST MAXENEMIES = 12           ' The max number of enemies.
                                ' optimized for 486DX40

DIM SHARED UP AS STRING * 2     ' CONST UP = CHR$(0) + CHR$(72)
DIM SHARED RIGHT AS STRING * 2  ' CONST RIGHT = CHR$(0) + CHR$(77)
DIM SHARED DOWN AS STRING * 2   ' CONST DOWN = CHR$(0) + CHR$(80)
DIM SHARED LEFT AS STRING * 2   ' CONST LEFT = CHR$(0) + CHR$(72)
DIM SHARED space AS STRING * 1  ' CONST SPACE = CHR$(32)
UP = CHR$(0) + CHR$(72)         ' The value of the uparrow key.
RIGHT = CHR$(0) + CHR$(77)      ' The value of the rightarrow key.
DOWN = CHR$(0) + CHR$(80)       ' The value of the downarrow key.
LEFT = CHR$(0) + CHR$(75)       ' The value of the leftarrow key.
space = CHR$(32)                ' The value of the space key.

REM Make memory to store all the sprites.

DIM SHARED bluetankn0(SPRITEMEM) AS INTEGER     ' The player's tank is
                                                ' bluetank.
DIM SHARED bluetankn1(SPRITEMEM) AS INTEGER     ' It is blue of color.
DIM SHARED bluetanke0(SPRITEMEM) AS INTEGER
DIM SHARED bluetanke1(SPRITEMEM) AS INTEGER
DIM SHARED bluetanks0(SPRITEMEM) AS INTEGER
DIM SHARED bluetanks1(SPRITEMEM) AS INTEGER
DIM SHARED bluetankw0(SPRITEMEM) AS INTEGER
DIM SHARED bluetankw1(SPRITEMEM) AS INTEGER

DIM SHARED enemytankn0(SPRITEMEM) AS INTEGER    ' The enemy tanks are
                                                ' enemytanks.
DIM SHARED enemytankn1(SPRITEMEM) AS INTEGER    ' They are green of color.
DIM SHARED enemytanke0(SPRITEMEM) AS INTEGER
DIM SHARED enemytanke1(SPRITEMEM) AS INTEGER
DIM SHARED enemytanks0(SPRITEMEM) AS INTEGER
DIM SHARED enemytanks1(SPRITEMEM) AS INTEGER
DIM SHARED enemytankw0(SPRITEMEM) AS INTEGER
DIM SHARED enemytankw1(SPRITEMEM) AS INTEGER

DIM SHARED wall(SPRITEMEM) AS INTEGER           ' Making the gamemap.
DIM SHARED explotion(SPRITEMEM) AS INTEGER      ' When a tank is hit.
DIM SHARED OldSchoolArcade(SPRITEMEM) AS INTEGER' used as exit.

REM Make memory to store the gamemap.

DIM SHARED map(MAPWIDTH, MAPLENGTH) AS INTEGER

REM Make memory for the tanks and their missiles.

DIM SHARED t(1 + MAXENEMIES) AS TANK    ' The player's tank + the enemy tanks.
DIM SHARED m(1 + MAXENEMIES) AS MISSILE ' The player's missile + the enemy
                                        ' missiles.

REM Make memory to store the gamestatus.

DIM SHARED gamestatus AS GAMEPARAMETERS ' The status of the game (score, etc).

REM Run the game.

SetupGame
Intro
SCREEN , , SPRITESCREEN, GAMESCREEN
DO WHILE TRUE
        ControlPlayerOne
        ControlEnemies
        PCOPY MAPSCREEN, SPRITESCREEN
        ContinueGame
        PCOPY SPRITESCREEN, GAMESCREENSCREEN
LOOP

MapData:                                ' Begin of the mapdata.
                                      
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,1,0,1,0,1,1,0,1,0,1,1,0,1
DATA 1,0,1,0,0,0,0,0,0,0,0,0,0,1,0,1
DATA 1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1
DATA 1,0,1,0,0,0,0,0,0,0,0,0,0,1,0,1
DATA 1,0,1,1,0,1,0,1,1,0,1,0,1,1,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,2,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

SpriteData:                             ' Begin of the spritedata.

DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 8 , 15 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 8 , 15 , 0 , 1 , 8 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 8 , 8 , 0 , 1 , 1 , 8 , 15 , 9 , 9 , 1 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 1 , 0 , 1 , 1 , 1 , 8 , 15 , 9 , 9 , 9 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 0 , 1 , 1 , 1 , 1 , 8 , 15 , 9 , 9 , 9 , 9 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 8 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 7 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 8 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 7 , 7 , 8 , 7 , 8 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 7 , 7 , 8 , 7 , 8 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 8 , 8 , 7 , 8 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 7 , 8 , 9 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 8 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 1 , 1 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 8 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 8 , 8 , 8 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 1 , 8 , 1 , 8 , 1 , 8 , 0 , 0 , 0 , 8 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 1 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 8 , 1 , 1 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 1 , 8 , 7 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 9 , 1 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 7 , 7 , 8 , 8 , 8 , 15 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 7 , 7 , 7 , 7 , 8 , 7 , 8 , 15 , 15 , 15 , 15 , 15 , 15
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 7 , 7 , 7 , 7 , 8 , 8 , 8 , 8 , 8 , 8 , 8
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 15 , 8 , 8 , 8 , 7 , 7 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 7 , 8 , 9 , 9 , 9 , 9 , 1 , 0 , 0
DATA 0 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 1 , 8 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 1 , 8 , 1 , 0 , 0 , 0 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 0 , 0 , 0 , 1 , 8 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 8 , 8 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 1 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 8 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 7 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 8 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 7 , 7 , 8 , 7 , 8 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 7 , 7 , 8 , 7 , 8 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 8 , 8 , 7 , 8 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 7 , 8 , 9 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 15 , 8 , 9 , 9 , 9 , 9 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 8 , 0 , 1 , 1 , 1 , 15 , 8 , 9 , 9 , 9 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 1 , 1 , 0 , 1 , 1 , 15 , 8 , 9 , 9 , 8 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 8 , 8 , 8 , 0 , 0 , 15 , 8 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 15 , 8 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 15 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 1 , 8 , 1 , 8 , 1 , 8 , 0 , 0 , 0 , 8 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 1 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 8 , 1 , 1 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 1 , 8 , 7 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 9 , 1 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 7 , 7 , 8 , 8 , 8 , 15 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 8 , 8 , 8 , 8 , 8 , 8 , 8 , 7 , 7 , 7 , 7 , 8 , 7 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 15 , 15 , 15 , 15 , 15 , 15 , 8 , 7 , 8 , 7 , 7 , 7 , 7 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 15 , 8 , 8 , 8 , 7 , 7 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 7 , 8 , 9 , 9 , 9 , 9 , 1 , 0 , 0
DATA 0 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 1 , 8 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 1 , 8 , 1 , 0 , 0 , 0 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 8 , 15 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 1 , 8 , 8 , 8 , 8 , 8 , 0 , 0 , 8 , 15 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 1 , 1 , 0 , 1 , 1 , 8 , 15 , 9 , 9 , 8 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 8 , 0 , 1 , 1 , 1 , 8 , 15 , 9 , 9 , 9 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 15 , 9 , 9 , 9 , 9 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 1 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 7 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 8 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 7 , 7 , 8 , 7 , 8 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 7 , 7 , 8 , 7 , 8 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 8 , 8 , 7 , 8 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 7 , 8 , 9 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 8 , 8 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 1 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 0 , 0 , 0 , 8 , 8 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 1 , 1 , 8 , 1 , 8 , 1 , 0 , 0 , 0 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 1 , 8 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 1 , 8 , 7 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 9 , 1 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 7 , 7 , 8 , 8 , 8 , 15 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 7 , 7 , 7 , 7 , 8 , 7 , 8 , 15 , 15 , 15 , 15 , 15 , 15
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 7 , 7 , 7 , 7 , 8 , 8 , 8 , 8 , 8 , 8 , 8
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 15 , 8 , 8 , 8 , 7 , 7 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 7 , 8 , 9 , 9 , 9 , 9 , 1 , 0 , 0
DATA 0 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 1 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 8 , 1 , 8 , 0 , 0 , 0 , 8 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 1 , 8 , 8 , 8 , 8 , 8 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 1 , 1 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 8 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 8 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 1 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 7 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 8 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 7 , 7 , 8 , 7 , 8 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 7 , 8 , 7 , 7 , 8 , 7 , 8 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 8 , 8 , 7 , 8 , 9 , 9 , 9 , 8 , 1 , 0
DATA 0 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 7 , 8 , 9 , 9 , 9 , 9 , 1 , 1 , 0
DATA 0 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 0 , 1 , 1 , 1 , 1 , 15 , 8 , 9 , 9 , 9 , 9 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 1 , 0 , 1 , 1 , 1 , 15 , 8 , 9 , 9 , 9 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 1 , 8 , 8 , 8 , 8 , 0 , 1 , 1 , 15 , 8 , 9 , 9 , 1 , 1 , 1 , 1 , 1 , 1 , 0
DATA 0 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 15 , 8 , 0 , 8 , 8 , 8 , 8 , 8 , 8 , 1 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 15 , 8 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 15 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 1 , 1 , 8 , 1 , 8 , 1 , 0 , 0 , 0 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 1 , 8 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 0
DATA 0 , 1 , 1 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 1 , 8 , 7 , 7 , 7 , 15 , 8 , 9 , 9 , 9 , 9 , 1 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 7 , 7 , 8 , 8 , 8 , 15 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 8 , 8 , 8 , 8 , 8 , 8 , 8 , 7 , 7 , 7 , 7 , 8 , 7 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 15 , 15 , 15 , 15 , 15 , 15 , 8 , 7 , 8 , 7 , 7 , 7 , 7 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 8 , 15 , 8 , 8 , 8 , 7 , 7 , 8 , 9 , 9 , 9 , 0 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 1 , 1 , 8 , 15 , 7 , 7 , 7 , 8 , 9 , 9 , 9 , 9 , 1 , 0 , 0
DATA 0 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 8 , 8 , 8 , 8 , 9 , 9 , 9 , 9 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 9 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 8 , 0 , 1 , 1 , 1 , 1 , 9 , 9 , 9 , 9 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 8 , 1 , 0 , 1 , 1 , 1 , 9 , 9 , 9 , 1 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 1 , 8 , 1 , 8 , 1 , 8 , 0 , 0 , 0 , 8 , 1 , 8 , 1 , 8 , 1 , 8 , 1 , 1 , 0
DATA 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14
DATA 14 , 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14
DATA 14 , 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14
DATA 14 , 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14
DATA 14 , 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14
DATA 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14
DATA 6 , 6 , 6 , 6 , 14 , 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6
DATA 6 , 6 , 6 , 6 , 14 , 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6
DATA 6 , 6 , 6 , 6 , 14 , 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6
DATA 6 , 6 , 6 , 6 , 14 , 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6
DATA 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14
DATA 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14
DATA 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14
DATA 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14
DATA 14 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14
DATA 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14 , 14
DATA 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14 , 14 , 4 , 4 , 4 , 4
DATA 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14 , 14 , 4 , 4 , 4 , 4
DATA 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14 , 14 , 4 , 4 , 4 , 4
DATA 4 , 4 , 4 , 4 , 14 , 14 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 14 , 14 , 4 , 4 , 4 , 4
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 15 , 15 , 15 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 0 , 8 , 7 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 15 , 15 , 15 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 0 , 8 , 7 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 15 , 15 , 15 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 15 , 15 , 15 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 0 , 8 , 7 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 15 , 15 , 15 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 15 , 15 , 15 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 0 , 8 , 7 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 15 , 15 , 15 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 15 , 15 , 15 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 15 , 15 , 15 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 0 , 15 , 7 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 7 , 15 , 0 , 15 , 7 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 15 , 0 , 15 , 0 , 0 , 15 , 15 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 11 , 0 , 11 , 11 , 0 , 0 , 11 , 0 , 11 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 9 , 0 , 9 , 9 , 0 , 0 , 9 , 0 , 9 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 1 , 0 , 1 , 1 , 0 , 0 , 1 , 0 , 1 , 0 , 0 , 1 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 8 , 8 , 8 , 8 , 8 , 0 , 0 , 0 , 9 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 11 , 0 , 0 , 0
DATA 0 , 0 , 15 , 15 , 0 , 15 , 15 , 15 , 0 , 15 , 0 , 15 , 0 , 1 , 9 , 11 , 15 , 11 , 9 , 1
DATA 0 , 11 , 0 , 0 , 11 , 0 , 0 , 11 , 0 , 11 , 11 , 0 , 11 , 11 , 0 , 11 , 11 , 0 , 0 , 0
DATA 0 , 0 , 9 , 0 , 9 , 0 , 0 , 9 , 9 , 9 , 9 , 0 , 9 , 9 , 0 , 9 , 9 , 0 , 0 , 0
DATA 0 , 0 , 0 , 1 , 1 , 0 , 0 , 1 , 0 , 1 , 1 , 0 , 1 , 1 , 0 , 1 , 1 , 0 , 0 , 0
DATA 0 , 8 , 8 , 0 , 0 , 8 , 8 , 8 , 0 , 8 , 0 , 8 , 0 , 0 , 8 , 0 , 8 , 8 , 8 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
DATA 0 , 0 , 15 , 0 , 0 , 15 , 0 , 0 , 15 , 15 , 0 , 15 , 0 , 15 , 15 , 0 , 15 , 15 , 15 , 0
DATA 0 , 11 , 0 , 11 , 11 , 0 , 11 , 11 , 0 , 0 , 11 , 0 , 11 , 11 , 0 , 11 , 11 , 0 , 0 , 0
DATA 0 , 9 , 9 , 9 , 9 , 9 , 0 , 9 , 0 , 0 , 9 , 9 , 9 , 9 , 0 , 9 , 9 , 9 , 0 , 0
DATA 0 , 1 , 0 , 1 , 1 , 0 , 1 , 1 , 0 , 0 , 1 , 0 , 1 , 1 , 0 , 1 , 1 , 0 , 0 , 0
DATA 0 , 8 , 0 , 8 , 8 , 0 , 8 , 0 , 8 , 8 , 8 , 0 , 8 , 8 , 8 , 0 , 8 , 8 , 8 , 0
DATA 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0

SUB CalcCurrentStatus
        IF t(PLAYER).h.v = TRUE THEN
                gamestatus.playersleft = gamestatus.playersleft - 1
                gamestatus.enemiesleft = gamestatus.enemies
                gamestatus.basetime = TIMER
                gamestatus.timeleft = gamestatus.time
                SetupPlayer
                SetupEnemies
        END IF
        IF gamestatus.playersleft = -1 OR gamestatus.timeleft = -1 THEN
                Exitro
        END IF
        IF gamestatus.enemiesleft = 0 THEN
                IF t(PLAYER).x = 280 AND t(PLAYER).y = 140 THEN
                        gamestatus.enemies = gamestatus.enemies + 1
                        gamestatus.playersleft = gamestatus.playersleft + 1
                        IF gamestatus.enemies = 9 THEN
                                gamestatus.enemies = 8
                                gamestatus.score = gamestatus.score + 10000!
                                gamestatus.time = gamestatus.time - 10
                        END IF
                        gamestatus.enemiesleft = gamestatus.enemies
                        gamestatus.score = gamestatus.score + (gamestatus.timeleft * 1000!)
                        gamestatus.basetime = TIMER
                        gamestatus.timeleft = gamestatus.time
                        SetupPlayer
                        SetupEnemies
                END IF
        END IF
        gamestatus.score = gamestatus.score + 1
        gamestatus.timeleft = gamestatus.time - INT(TIMER - gamestatus.basetime)
END SUB

SUB CenterPrint (Row%, Col%, Size%, Text$, ForeGround%, BackGround%, Allign%)
        CONST NOALLIGN = 1
        CONST LEFT = 2
        CONST RIGHT = 3
        CONST ALL = 4

        DIM Center AS INTEGER
      
        Text$ = LEFT$(Text$, Size%)
        Center = INT((Size% - LEN(Text$)) / 2)
      
        COLOR ForeGround%, BackGround%
        SELECT CASE Allign%
        CASE NOALLIGN
                LOCATE Row%, Col% + Center
                PRINT Text$;
        CASE LEFT
                LOCATE Row%, Col%
                PRINT SPACE$(Center); Text$;
        CASE RIGHT
                LOCATE Row%, Col% + Center
                PRINT Text$; SPACE$(Size% - Center - LEN(Text$));
        CASE ALL
                LOCATE Row%, Col%
                PRINT SPACE$(Center); Text$; SPACE$(Size% - Center - LEN(Text$));
        END SELECT
        COLOR 7, 0
END SUB

SUB ContinueGame
        FOR l = 0 TO gamestatus.enemies + 1
                UpdateMissile m(l)
                UpdateTank t(l)
                CalcCurrentStatus
                DrawMissile m(l)
                DrawTank t(l)
                IF m(l).h.v = TRUE THEN
                        m(l).a.v = FALSE
                        m(l).h.v = FALSE
                END IF
                IF t(l).h.v = TRUE THEN
                        t(l).a.v = FALSE
                        t(l).h.v = FALSE
                END IF
                IF l = PLAYER THEN
                        Semi32BitWaveTableSound
                END IF
        NEXT l
        ShowGameStatus
END SUB

SUB ControlEnemies
        FOR l = 1 TO gamestatus.enemies
                SELECT CASE t(l).a.v
                CASE TRUE
                        g = INT(RND * 2) + 1
                        IF g = 1 AND t(l).x MOD SPRITEWIDTH = 0 AND t(l).y MOD SPRITELENGTH = 0 THEN
                                t(l).m = (t(l).m + INT(RND * 2)) MOD 4
                        ELSEIF g = 2 THEN
                                IF m(l).a.v = FALSE THEN
                                        IF t(l).x = t(PLAYER).x OR t(l).y = t(PLAYER).y THEN
                                                FireMissile t(l)
                                        END IF
                                END IF
                        END IF
                END SELECT
        NEXT l
END SUB

SUB ControlPlayerOne
        SELECT CASE INKEY$
        CASE UP
                t(PLAYER).m = NORD
        CASE RIGHT
                t(PLAYER).m = EAST
        CASE DOWN
                t(PLAYER).m = SOUTH
        CASE LEFT
                t(PLAYER).m = WEST
        CASE space
                IF m(PLAYER).a.v = FALSE AND t(PLAYER).a.v = TRUE THEN
                        FireMissile t(PLAYER)
                END IF
        END SELECT
END SUB

FUNCTION DidMissileHitOpponentTank% (m AS MISSILE)
        SELECT CASE m.f
        CASE PLAYER
                FOR l = 1 TO gamestatus.enemies
                         IF t(l).a.v = TRUE THEN
                                inx = ((m.x >= t(l).x) AND (m.x < t(l).x + SPRITEWIDTH))
                                iny = ((m.y >= t(l).y) AND (m.y < t(l).y + SPRITELENGTH))
                                IF inx AND iny THEN
                                        t(l).h.v = TRUE
                                        gamestatus.score = gamestatus.score + 100
                                        gamestatus.enemiesleft = gamestatus.enemiesleft - 1
                                        DidMissileHitOpponentTank% = TRUE
                                        EXIT FUNCTION
                                END IF
                        END IF
                NEXT l
                DidMissileHitOpponentTank% = FALSE
                EXIT FUNCTION
        CASE 1 TO gamestatus.enemies
                IF t(PLAYER).a.v = TRUE THEN
                        inx = ((m.x >= t(PLAYER).x) AND (m.x < t(PLAYER).x + SPRITEWIDTH))
                        iny = ((m.y >= t(PLAYER).y) AND (m.y < t(PLAYER).y + SPRITELENGTH))
                        IF inx AND iny THEN
                                t(PLAYER).h.v = TRUE
                                DidMissileHitOpponentTank% = TRUE
                                EXIT FUNCTION
                        END IF
                END IF
                DidMissileHitOpponentTank% = FALSE
                EXIT FUNCTION
        END SELECT
END FUNCTION

FUNCTION DidMissileHitWall% (m AS MISSILE)
        inx = m.x \ SPRITEWIDTH
        iny = m.y \ SPRITELENGTH
        IF map(inx, iny) = 1 THEN
                DidMissileHitWall% = TRUE
                EXIT FUNCTION
        ELSE
                DidMissileHitWall% = FALSE
                EXIT FUNCTION
        END IF
END FUNCTION

FUNCTION DidTankHitOpponentTank% (t AS TANK)
        SELECT CASE t.i
        CASE PLAYER
                FOR l = 1 TO gamestatus.enemies
                         IF t(l).a.v = TRUE THEN
                                'inx = ((t.x >= t(l).x) AND (t.x < t(l).x + SPRITEWIDTH))
                                'iny = ((t.y >= t(l).y) AND (t.y < t(l).y + SPRITELENGTH))
                                'IF inx AND iny THEN
                                inx = ABS(t.x - t(l).x)
                                iny = ABS(t.y - t(l).y)
                                IF inx < 20 AND iny < 20 THEN
                                        t(l).h.v = TRUE
                                        DidTankHitOpponentTank% = TRUE
                                        EXIT FUNCTION
                                END IF
                        END IF
                NEXT l
                DidTankHitOpponentTank% = FALSE
                EXIT FUNCTION
        CASE 1 TO gamestatus.enemies
                IF t(PLAYER).a.v = TRUE THEN
                        inx = ((t.x >= t(PLAYER).x) AND (t.x < t(PLAYER).x + SPRITEWIDTH))
                        iny = ((t.y >= t(PLAYER).y) AND (t.y < t(PLAYER).y + SPRITELENGTH))
                        IF inx AND iny THEN
                                t(PLAYER).h.v = TRUE
                                DidTankHitOpponentTank% = TRUE
                                EXIT FUNCTION
                        END IF
                END IF
                DidTankHitOpponentTank% = FALSE
                EXIT FUNCTION
        END SELECT
END FUNCTION

FUNCTION DidTankHitWall% (t AS TANK)
        inx = t.x \ SPRITEWIDTH
        iny = t.y \ SPRITELENGTH
        SELECT CASE t.m
        CASE NORD
                SELECT CASE t.y MOD SPRITELENGTH
                CASE 0
                        SELECT CASE t.x MOD SPRITEWIDTH
                        CASE 0
                                IF map(inx, iny - 1) = 1 THEN
                                        DidTankHitWall% = TRUE
                                        EXIT FUNCTION
                                END IF
                        CASE IS > 0
                                IF map(inx, iny - 1) = 1 OR map(inx + 1, iny - 1) = 1 THEN
                                        DidTankHitWall% = TRUE
                                        EXIT FUNCTION
                                END IF
                        END SELECT
                END SELECT
                DiTankHitWall% = FALSE
                EXIT FUNCTION
        CASE EAST
                SELECT CASE t.x MOD SPRITEWIDTH
                CASE 0
                        SELECT CASE t.y MOD SPRITELENGTH
                        CASE 0
                                IF map(inx + 1, iny) = 1 THEN
                                        DidTankHitWall% = TRUE
                                        EXIT FUNCTION
                                END IF
                        CASE IS > 0
                                IF map(inx + 1, iny) = 1 OR map(inx + 1, iny + 1) = 1 THEN
                                        DidTankHitWall% = TRUE
                                        EXIT FUNCTION
                                END IF
                        END SELECT
                END SELECT
                DiTankHitWall% = FALSE
                EXIT FUNCTION
        CASE SOUTH
                SELECT CASE t.y MOD SPRITELENGTH
                CASE 0
                        SELECT CASE t.x MOD SPRITEWIDTH
                        CASE 0
                                IF map(inx, iny + 1) = 1 THEN
                                        DidTankHitWall% = TRUE
                                        EXIT FUNCTION
                                END IF
                        CASE IS > 0
                                IF map(inx, iny + 1) = 1 OR map(inx + 1, iny + 1) = 1 THEN
                                        DidTankHitWall% = TRUE
                                        EXIT FUNCTION
                                END IF
                        END SELECT
                END SELECT
                DiTankHitWall% = FALSE
                EXIT FUNCTION
        CASE WEST
                SELECT CASE t.x MOD SPRITEWIDTH
                CASE 0
                        SELECT CASE t.y MOD SPRITELENGTH
                        CASE 0
                                IF map(inx - 1, iny) = 1 THEN
                                        DidTankHitWall% = TRUE
                                        EXIT FUNCTION
                                END IF
                        CASE IS > 0
                                IF map(inx - 1, iny) = 1 OR map(inx - 1, iny + 1) = 1 THEN
                                        DidTankHitWall% = TRUE
                                        EXIT FUNCTION
                                END IF
                        END SELECT
                END SELECT
                DiTankHitWall% = FALSE
                EXIT FUNCTION
        END SELECT
END FUNCTION

SUB DrawMissile (m AS MISSILE)
        SELECT CASE m.h.v
        CASE FALSE
                SELECT CASE m.a.v
                CASE TRUE
                        SELECT CASE m.f
                        CASE PLAYER
                                SELECT CASE m.m
                                CASE NORD
                                        LINE (m.x, m.y)-(m.x + 1, m.y - 2), 14, BF
                                CASE EAST
                                        LINE (m.x, m.y)-(m.x + 2, m.y + 1), 14, BF
                                CASE SOUTH
                                        LINE (m.x, m.y)-(m.x + 1, m.y + 2), 14, BF
                                CASE WEST
                                        LINE (m.x, m.y)-(m.x - 2, m.y + 1), 14, BF
                                END SELECT
                        CASE 1 TO gamestatus.enemies
                                SELECT CASE m.m
                                CASE NORD
                                        LINE (m.x, m.y)-(m.x + 1, m.y - 2), 15, BF
                                CASE EAST
                                        LINE (m.x, m.y)-(m.x + 2, m.y + 1), 15, BF
                                CASE SOUTH
                                        LINE (m.x, m.y)-(m.x + 1, m.y + 2), 15, BF
                                CASE WEST
                                        LINE (m.x, m.y)-(m.x - 2, m.y + 1), 15, BF
                                END SELECT
                        END SELECT
                END SELECT
        END SELECT
END SUB

SUB DrawTank (t AS TANK)
        SELECT CASE t.h.v
        CASE TRUE
                PUT (t.x, t.y), explotion, PSET
        CASE FALSE
                SELECT CASE t.a.v
                CASE TRUE
                        SELECT CASE t.i
                        CASE PLAYER
                                SELECT CASE t.m
                                CASE NORD
                                        SELECT CASE t.d
                                        CASE 0
                                                PUT (t.x, t.y), bluetankn0, OR
                                        CASE 1
                                                PUT (t.x, t.y), bluetankn1, OR
                                        END SELECT
                                CASE EAST
                                        SELECT CASE t.d
                                        CASE 0
                                                PUT (t.x, t.y), bluetanke0, OR
                                        CASE 1
                                                PUT (t.x, t.y), bluetanke1, OR
                                        END SELECT
                                CASE SOUTH
                                        SELECT CASE t.d
                                        CASE 0
                                                PUT (t.x, t.y), bluetanks0, OR
                                        CASE 1
                                                PUT (t.x, t.y), bluetanks1, OR
                                        END SELECT
                                CASE WEST
                                        SELECT CASE t.d
                                        CASE 0
                                                PUT (t.x, t.y), bluetankw0, OR
                                        CASE 1
                                                PUT (t.x, t.y), bluetankw1, OR
                                        END SELECT
                                END SELECT
                        CASE 1 TO gamestatus.enemies
                                SELECT CASE t.m
                                CASE NORD
                                        SELECT CASE t.d
                                        CASE 0
                                                PUT (t.x, t.y), enemytankn0, OR
                                        CASE 1
                                                PUT (t.x, t.y), enemytankn1, OR
                                        END SELECT
                                CASE EAST
                                        SELECT CASE t.d
                                        CASE 0
                                                PUT (t.x, t.y), enemytanke0, OR
                                        CASE 1
                                                PUT (t.x, t.y), enemytanke1, OR
                                        END SELECT
                                CASE SOUTH
                                        SELECT CASE t.d
                                        CASE 0
                                                PUT (t.x, t.y), enemytanks0, OR
                                        CASE 1
                                                PUT (t.x, t.y), enemytanks1, OR
                                        END SELECT
                                CASE WEST
                                        SELECT CASE t.d
                                        CASE 0
                                                PUT (t.x, t.y), enemytankw0, OR
                                        CASE 1
                                                PUT (t.x, t.y), enemytankw1, OR
                                        END SELECT
                                END SELECT
                        END SELECT
                END SELECT
        END SELECT
END SUB

SUB Exitro
        SCREEN , , GAMESCREEN, GAMESCREEN
        FOR l = O TO 15
                COLOR l, 15 - l
                LOCATE 10, 16: PRINT "GAME  OVER"
        NEXT l
        DO WHILE INKEY$ = ""
        LOOP
        SCREEN 0
        WIDTH 80
        CenterPrint 1, 1, 80, "Thank you for playing BLUETANK", 14, 4, 4
        CenterPrint 3, 1, 80, "You can mail me at", 15, 0, 1
        CenterPrint 4, 1, 80, "glas400@hio.tem.nhl.nl", 15, 2, 1
        CenterPrint 5, 1, 80, "for ideas, bugrepport etc.", 15, 0, 1
        CenterPrint 7, 1, 80, "Reinder Glas", 15, 0, 1
        SYSTEM
END SUB

SUB FireMissile (t AS TANK)
        m(t.i).f = t.i
        m(t.i).a.v = TRUE
        m(t.i).h.v = FALSE
        m(t.i).m = t.m
        m(t.i).s = MISSILESPEED
        SELECT CASE t.m
        CASE NORD
                m(t.i).x = t.x + 9
                m(t.i).y = t.y - 1
        CASE EAST
                m(t.i).x = t.x + SPRITEWIDTH
                m(t.i).y = t.y + 9
        CASE SOUTH
                m(t.i).x = t.x + 9
                m(t.i).y = t.y + SPRITELENGTH
        CASE WEST
                m(t.i).x = t.x - 1
                m(t.i).y = t.y + 9
        END SELECT
END SUB

SUB InitMap
        RESTORE MapData
        FOR y = 0 TO MAPLENGTH - 1
                FOR x = 0 TO MAPWIDTH - 1
                        READ sprite
                        IF sprite = 1 THEN PUT (x * 20, y * 20), wall
                        IF sprite = 2 THEN PUT (x * 20, y * 20), OldSchoolArcade
                        map(x, y) = sprite
                NEXT x
        NEXT y
END SUB

SUB InitSprites
        RESTORE SpriteData
        xb = 0

        FOR l = 0 TO 7
                FOR y = 0 TO SPRITELENGTH - 1
                        FOR x = 0 TO SPRITEWIDTH - 1
                                READ k
                                PSET (xb + x, y), k
                                IF k = 1 THEN k = 2
                                IF k = 9 THEN k = 10
                                PSET (xb + x, y + 20), k
                        NEXT x
                NEXT y
        xb = xb + 20
        NEXT l

        xb = 0

        FOR l = 0 TO 2
                FOR y = 0 TO SPRITELENGTH - 1
                        FOR x = 0 TO SPRITEWIDTH - 1
                                READ k
                                PSET (xb + x, y + 40), k
                        NEXT x
                NEXT y
        xb = xb + 20
        NEXT l

        GET (0, 0)-(19, 19), bluetankn0
        GET (20, 0)-(39, 19), bluetanke0
        GET (40, 0)-(59, 19), bluetanks0
        GET (60, 0)-(79, 19), bluetankw0
        GET (80, 0)-(99, 19), bluetankn1
        GET (100, 0)-(119, 19), bluetanke1
        GET (120, 0)-(139, 19), bluetanks1
        GET (140, 0)-(159, 19), bluetankw1

        GET (0, 20)-(19, 39), enemytankn0
        GET (20, 20)-(39, 39), enemytanke0
        GET (40, 20)-(59, 39), enemytanks0
        GET (60, 20)-(79, 39), enemytankw0
        GET (80, 20)-(99, 39), enemytankn1
        GET (100, 20)-(119, 39), enemytanke1
        GET (120, 20)-(139, 39), enemytanks1
        GET (140, 20)-(159, 39), enemytankw1

        GET (0, 40)-(19, 59), wall
        GET (20, 40)-(39, 59), explotion
        GET (40, 40)-(59, 59), OldSchoolArcade
END SUB

SUB Intro
        SCREEN SCREENMODE, , GAMESCREEN, GAMESCREEN
        CLS
        COLOR 1, 0
        FOR l = 14 TO 1 STEP -1
        LOCATE l, 1
        PRINT ""
        PRINT ""
        PRINT "         º³ ³  º º³º³º³º º º³º³ ³"
        PRINT "         º º³  º º³   ³ ³ ³º º³º "
        PRINT "         º³ ³  º º³º  ³ ³º³º º³º  "
        PRINT "         º º³  º º³   ³ ³ ³º º³º "
        PRINT "         º³ ³º³º³º³º³ ³ ³ ³º º³ ³"
        PRINT "                                 "
        NEXT l
        COLOR 14, 0
        PRINT
        PRINT " MISSION : Destroy all the GREEN tanks"
        PRINT "           and rush to the"
        PRINT "           'Old School Arcade' in the"
        PRINT "           right-bottom corner.Û"
        PRINT
        PRINT
        PRINT
        PRINT
        COLOR 4, 0
        PRINT "           press fire to start"
        DO WHILE INKEY$ = ""
        LOOP
        gamestatus.basetime = TIMER
        gamestatus.time = 100
END SUB

SUB MoveMissile (m AS MISSILE)
        SELECT CASE m.m
        CASE NORD
                m.y = m.y - m.s
        CASE EAST
                m.x = m.x + m.s
        CASE SOUTH
                m.y = m.y + m.s
        CASE WEST
                m.x = m.x - m.s
        END SELECT
END SUB

SUB MoveTank (t AS TANK)
        SELECT CASE t.m
        CASE NORD
                t.y = t.y - t.s
        CASE EAST
                t.x = t.x + t.s
        CASE SOUTH
                t.y = t.y + t.s
        CASE WEST
                t.x = t.x - t.s
        END SELECT
END SUB

SUB Semi32BitWaveTableSound
        IF m(PLAYER).a.v = TRUE THEN
                SELECT CASE t(PLAYER).d
                CASE 0
                        SOUND 1150, 1
                CASE 1
                        SOUND 1000, 1
                END SELECT
        ELSE
                SELECT CASE t(PLAYER).d
                CASE 0
                        SOUND 250, 1
                CASE 1
                        SOUND 200, 1
                END SELECT
        END IF
END SUB

SUB SetupEnemies
        x = 20
        y = 20
        FOR l = 1 TO gamestatus.enemies
                t(l).i = l
                t(l).a.v = TRUE
                m(l).a.v = FALSE
                t(l).x = x
                t(l).y = y
                t(l).m = c MOD 4
                t(l).s = TANKSPEED
                t(l).d = 0
                t(l).h.v = FALSE
                IF x = 20 AND y = 20 THEN
                        x = 280
                ELSEIF x = 280 AND y = 20 THEN
                        y = 140
                ELSEIF x = 280 AND y = 140 THEN
                        x = 20
                ELSEIF x = 20 AND y = 140 THEN
                        y = 20
                END IF
        NEXT l
END SUB

SUB SetupGame
        SCREEN SCREENMODE, , GAMESCREEN, GAMESCREEN
        PRINT "loading bluetank"
       
        gamestatus.playersleft = 0
        gamestatus.enemies = 1
        gamestatus.enemiesleft = 1
        gamestatus.timeleft = 100
        gamestatus.score = 0
       
        RANDOMIZE TIMER
       
        SCREEN SCREENMODE, , SPRITESCREEN, GAMESCREEN
        InitSprites
       
        SCREEN , , MAPSCREEN, GAMESCREEN
        InitMap
       
        SetupPlayer
        SetupEnemies
END SUB

SUB SetupPlayer
        t(PLAYER).i = PLAYER
        t(PLAYER).a.v = TRUE
        m(PLAYER).a.v = FALSE
        t(PLAYER).x = 160
        t(PLAYER).y = 80
        t(PLAYER).m = EAST
        t(PLAYER).s = TANKSPEED
        t(PLAYER).d = 0
        t(PLAYER).h.v = FALSE
END SUB

SUB ShowGameStatus
        score$ = MID$(STR$(gamestatus.score), 2)
        playersleft$ = MID$(STR$(gamestatus.playersleft), 2)
        timeleft$ = MID$(STR$(gamestatus.timeleft), 2)
        LOCATE 24, 1: PRINT "LEFT: "; STRING$(2 - LEN(playersleft$), ASC("0")) + playersleft$;
        LOCATE 24, 12: PRINT "SCORE: "; STRING$(10 - LEN(score$), ASC("0")) + score$;
         LOCATE 24, 32: PRINT "TIME: "; STRING$(3 - LEN(timeleft$), ASC("0")) + timeleft$;
END SUB

SUB UpdateMissile (m AS MISSILE)
        SELECT CASE m.a.v
        CASE TRUE
                IF DidMissileHitOpponentTank%(m) = TRUE THEN
                        m.h.v = TRUE
                        EXIT SUB
                END IF
                IF DidMissileHitWall%(m) = TRUE THEN
                        m.h.v = TRUE
                        EXIT SUB
                END IF
                MoveMissile m
        END SELECT
END SUB

SUB UpdateTank (t AS TANK)
        SELECT CASE t.a.v
        CASE TRUE
                t.d = (t.d + 1) MOD 2
                IF DidTankHitOpponentTank%(t) = TRUE THEN
                        t.h.v = TRUE
                        EXIT SUB
                END IF
                IF DidTankHitWall%(t) = TRUE THEN
                        EXIT SUB
                END IF
                MoveTank t
        END SELECT
END SUB

