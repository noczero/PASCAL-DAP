'QBasic Rockwars, by Brennen Bearnes
'You play the part of the blue castle.  You've been attacked by
'the red castle, who has started sending robotic tanks equipped with
'a short range death ray at you.  Fortunately, you've been hard at work
'on your own secret weapon, a powerful catapult that can launch rocks
'all the way to the other side of the screen.

'How to play:
'A tank will start coming at you as soon as the game begins.  If the
'red castle is fairly close, then you should shoot the tank first.
'Every time you blow up a tank, the red castle sends another one,
'so sooner or later, you'll have to hit the castle.  To fire, press
'F1, and type in the angle (10-180) and velocity (0-100) you want.  Be
'sure to take the wind into account.  If the tank gets close enough,
'then you're toast.

'Brent P. Newhall did all the code for the explosions, as well as the star
'field, and a number of other small but effective changes.
'The little moon orbiting a planet in the background was done
'by Marco Koegler (and thanks to everyone else that told me how to do it).
'I figured out how to plot the projectiles from GORILLA.BAS, which I
'found on an old computer at school.

'Suggestions are welcome, and if you improve this in any way, please
'send me a copy.
'bbearnes@worldnet.att.net
'http://www.geocities.com/SiliconValley/Park/8994/

' Brent P. Newhall edited 9/30/96
' Notes: The explode code now restores the screen to how it looked prior
'        to the explosion.  I then added code to erase the bullet and
'        exploded item just after the explosion.  I also added the stars.
'        Before, you could enter an angle of zero and just wipe out
'        anything before you.  Now the angle can be no less than 10.
'        I've also cleaned up the code a bit, making it more readable,
'        less time- and memory-intensive, etc.

DECLARE SUB newTank ()
DECLARE SUB drawTank ()
DECLARE SUB newRock ()
DECLARE SUB drawRock ()
DECLARE SUB explode (green%, blue%, red%, boomX, boomY, boomSize)

CONST pi = 3.141592654#

TYPE arctype
  Radius AS INTEGER
  colr AS INTEGER
  p1 AS SINGLE
  p2 AS SINGLE
END TYPE

'Variables that control the rock
DIM SHARED rockAngle
DIM SHARED rockSpeed
DIM SHARED startRockX
DIM SHARED startRockY
DIM SHARED oldRockX
DIM SHARED oldRockY
DIM SHARED rock1exist
DIM SHARED t 'time
DIM SHARED rockX
DIM SHARED rockY
DIM SHARED startRockXvel
DIM SHARED startRockYvel
DIM SHARED gravity
DIM SHARED wind

'The castles and tank.
DIM SHARED castle2X
DIM SHARED castleX
DIM SHARED tankExist
DIM SHARED TankX
DIM SHARED oldTankX
DIM SHARED tankSpeed
DIM SHARED castleExist
DIM SHARED castle2Exist

DIM SHARED x1 AS INTEGER, y1 AS INTEGER, x2 AS INTEGER, y2 AS INTEGER
DIM SHARED ExplodeHold(1 TO 10000)  AS INTEGER

castleExist = 1
castle2Exist = 1

SCREEN 13
        
'GET the player's castle.
DIM SHARED castle%(15, 15)
LINE (5, 5)-(20, 20), 1, BF
LINE (8, 5)-(10, 7), 0, BF
LINE (12, 5)-(14, 7), 0, BF
LINE (16, 5)-(18, 7), 0, BF
LINE (10, 15)-(15, 20), 0, BF
GET (5, 5)-(20, 20), castle%
CLS

'GET the computer's castle.
DIM SHARED castle2%(15, 15)
LINE (5, 5)-(20, 20), 4, BF
LINE (8, 5)-(10, 7), 0, BF
LINE (12, 5)-(14, 7), 0, BF
LINE (16, 5)-(18, 7), 0, BF
LINE (10, 15)-(15, 20), 0, BF
GET (5, 5)-(20, 20), castle2%
CLS

'GET the tank
DIM SHARED tank%(11, 8)
LINE (2, 4)-(10, 6), 2, BF
LINE (5, 1)-(8, 4), 2, BF
LINE (1, 2)-(5, 2), 2
CIRCLE (3, 6), 2, 2
CIRCLE (8, 6), 2, 2
GET (1, 1)-(11, 8), tank%
CLS

'The tank firing.
DIM SHARED tank2%(11, 8)
LINE (2, 4)-(10, 6), 2, BF
LINE (5, 1)-(8, 4), 2, BF
LINE (1, 1)-(5, 3), 2
CIRCLE (3, 6), 2, 2
CIRCLE (8, 6), 2, 2
GET (1, 1)-(11, 8), tank2%
CLS

'The center of the planet
planetX = 180: planetY = 45
'Draw the planet
FOR circ% = 1 TO 8
 CIRCLE (planetX, planetY), circ%, 9
 CIRCLE (planetX, planetY + 1), circ%, 9
NEXT circ%
LINE (planetX - 8, planetY)-(planetX + 8, planetY), 4
LINE (planetX - 8, planetY - 2)-(planetX + 8, planetY - 2), 12
LINE (planetX - 7, planetY - 3)-(planetX + 7, planetY - 3), 12
LINE (planetX - 5, planetY - 5)-(planetX + 5, planetY - 5), 4
LINE (planetX - 8, planetY + 3)-(planetX + 8, planetY + 3), 4
LINE (planetX - 6, planetY + 5)-(planetX + 6, planetY + 5), 4
CIRCLE (planetX + 2, planetY + 4), 2, 4
CIRCLE (planetX + 2, planetY + 4), 1, 4
CIRCLE (planetX + 3, planetY + 4), 1, 4

'Draw the ground
LINE (0, 175)-(320, 175), 10
PAINT (0, 176), 10, 1

'PUT the castles
castleX = 15
PUT (castleX, 159), castle%
RANDOMIZE TIMER
castle2X = INT(RND * 175) + 175
IF castle2X >= 285 THEN castle2X = 285
PUT (castle2X, 159), castle2%

'The code to make the moon "orbit" the planet was done by Marco Koegler
orbitRadius = 30 'Radius of the orbit
moonAngle = 0 'Initialize the moons angle
oldMoonX = planetX + 75: oldMoonY = planetY

gravity = 9.8

'Display stars
FOR cnt% = 1 TO 75
  PSET (INT(RND * 319), INT(RND * 120) + 30), INT(RND * 15 + 15)
NEXT cnt%

DO
  moonAngle = moonAngle + .5
  IF moonAngle = 360 THEN moonAngle = 0
  theta = moonAngle * (pi / 180)
  moonX = planetX + orbitRadius * (COS(theta))
  moonY = planetY - orbitRadius * (SIN(theta))
 
  'Erase old moon
  CIRCLE (oldMoonX, oldMoonY), 2, 0
  
  'Draw new moon
  CIRCLE (moonX, moonY), 2, 8
  oldMoonX = moonX: oldMoonY = moonY

  ptime! = TIMER: WHILE ptime! = TIMER: WEND ' Pause

  K$ = INKEY$
  IF LEN(K$) = 2 THEN
    SELECT CASE ASC(RIGHT$(K$, 1))
    CASE 59 'F1
      IF rock1exist = 0 THEN
        newRock
      END IF
    END SELECT
  ELSEIF LEN(K$) = 1 THEN
    SELECT CASE ASC(K$)
      CASE 27: quit = 1
    END SELECT
  END IF
 
  IF rock1exist = 1 THEN
    drawRock
  END IF

  IF tankExist = 0 AND castle2Exist = 1 THEN
    newTank
  ELSEIF tankExist = 1 THEN
    drawTank
  END IF

  IF castleExist = 0 THEN
    '"Melt" the screen and end the game if the player loses.
    quit = 2
  ELSEIF castle2Exist = 0 AND tankExist = 0 THEN
    'If the red castle and tank are both blown up, then end the game.
    quit = 3
  END IF

LOOP UNTIL quit > 0

IF quit = 2 THEN
  '"Melt" the screen and end the game if the player loses.
  LOCATE 8, 15: PRINT "you lose"
  LOCATE 9, 14: PRINT "the end"
  SLEEP 1
  DIM melt%(3000)
  FOR RR = 1 TO 3000
    RANDOMIZE TIMER
    XX = INT(RND * 271)
    RANDOMIZE TIMER
    YX = INT(RND * 150)
    GET (XX, YX)-(XX + 48, YX + 48), melt%
    PUT (XX, YX + 1), melt%, PSET
    IF INKEY$ = CHR$(27) THEN END
  NEXT RR
ELSEIF quit = 3 THEN
  'If the red castle and tank are both blown up, then end the game.
  LOCATE 15, 15: PRINT "you win"
END IF

END

SUB drawRock

oldRockX = rockX
oldRockY = rockY

'Calculate the next position of the rock
rockX = startRockX + (startRockXvel * t) + (.5 * (wind / 5) * t ^ 2)
rockY = startRockY + ((-1 * (startRockYvel * t)) + (.5 * gravity * t ^ 2)) * (200 / 350)

IF rockY >= 174 THEN
  'Do an explosion when the rock hits the "ground".
  rock1exist = 0
  green% = 20
  blue% = 0
  boomX = rockX
  boomY = rockY
  boomSize = 6
  explode green%, blue%, red%, boomX, boomY, boomSize
  CIRCLE (oldRockX, oldRockY), 1, 0 ' Erase rock
ELSEIF rockY >= 159 AND rockX >= castle2X AND rockX <= castle2X + 15 THEN
  'Do an explosion when the rock hits the enemy castle.
  IF castle2Exist = 1 THEN
    rock1exist = 0
    castle2Exist = 0
    green% = 0
    blue% = 0
    boomX = rockX
    boomY = rockY
    boomSize = 50
    explode green%, blue%, red%, boomX, boomY, boomSize
    CIRCLE (oldRockX, oldRockY), 1, 0 ' Erase rock
    PUT (castle2X, 159), castle2% ' Erase enemy castle
  END IF
ELSEIF rockY >= 167 AND rockX >= TankX AND rockX <= TankX + 10 THEN
  'Do an explosion if rock hits the tank.
  tankExist = 0
  rock1exist = 0
  green% = 20
  blue% = 0
  boomX = TankX
  boomY = rockY
  boomSize = 30
  explode green%, blue%, red%, boomX, boomY, boomSize
  CIRCLE (oldRockX, oldRockY), 1, 0 ' Erase rock
  PUT (INT(TankX), 167), tank%, XOR ' Erase tank
END IF

IF rockX >= 319 OR rockX <= 1 THEN
 rock1exist = 0
 CIRCLE (oldRockX, oldRockY), 1, 0
END IF

IF rock1exist = 1 THEN
 CIRCLE (oldRockX, oldRockY), 1, 0
 CIRCLE (rockX, rockY), 1, 12
ELSEIF rock1exist = 0 THEN
 rockX = 0
 rockY = 0
END IF

t = t + .1

END SUB

SUB drawTank

'Move the tank, or if the tank is close enough, blow up the player's
'castle.
tankSpeed = .5
IF TankX > castleX + 60 THEN
  'Make the tank try to avoid the rocks (doesn't work very well, but can
  'make the game a little more challenging).
  IF TankX - rockX < 20 AND TankX - rockX > -1 THEN
    tankSpeed = -.8
  END IF
  oldTankX = TankX
  TankX = TankX - tankSpeed
ELSEIF TankX <= castleX + 60 THEN
  PUT (INT(TankX), 167), tank2%, PSET
  SLEEP 1
  PALETTE 95, 60
  LINE (INT(TankX) - 2, 167)-(castleX + 15, 162), 95
  FOR cnt% = 1 TO 30
    PALETTE 95, INT(RND * 30 + 30)
    ptime! = TIMER: WHILE ptime! = TIMER: WEND ' Pause
  NEXT cnt%
  PALETTE 95, 0
  tankExist = 0
  green% = 0
  blue% = 30
  boomX = castleX + 15
  boomY = 162
  boomSize = 50
  explode green%, blue%, red%, boomX, boomY, boomSize
  castleExist = 0
END IF

PUT (INT(oldTankX), 167), tank%, XOR
PUT (INT(TankX), 167), tank%, PSET

END SUB

SUB explode (green%, blue%, red%, boomX, boomY, boomSize)

'This code started as EXPLODE.BAS by Brent P. Newhall.  I've only made a
'few minor changes.  The comments are all his.

''I was thinking about that "I need fire and an exploding graphic" post
''and came up with this simple explosion program.  Any suggestions,
''comments, etc. are welcome with open arms.

''NOTES: There are two lines that do not wrap properly; you'll be able to
''find them easily.  Also, NumArcs is set to 100, which does an
''acceptable explosion on my 486DX2/50 with 8 megs of RAM.  You Pentium
''people should be able to get a much nicer explosion if you set NumArcs
''equal to 1000 or so.

''The program sets colors 100 to 131 to varying shades of red, orange,
''and yellow for the explosive effect, with the nice side-effect that
'you can theoretically do several explosions at once.

NumArcs = 65
DIM arc(1 TO NumArcs) AS arctype
RANDOMIZE TIMER
FOR cnt% = 1 TO NumArcs ' Initialise
  arc(cnt%).Radius = 0
  arc(cnt%).p1 = RND * 5.8
  arc(cnt%).p2 = arc(cnt%).p1 + (RND / 2)
  arc(cnt%).colr = INT(RND * 5 + 100)
NEXT cnt%
red% = 63 ' Start it deep red
FOR cnt% = 100 TO 130 ' Change colors
  PALETTE cnt%, red% + 256 * green% + 65536 * blue%
  IF cnt% <= 114 THEN ' Lower red, increase yellow
    red% = red% - 2
    green% = green% + 2
  ELSE ' Lower red and yellow
    red% = red% - 2
    green% = green% - 2
  END IF
NEXT cnt%
PALETTE 131, 0
TimeCnt% = 0
x1 = boomX - boomSize
IF x1 < 0 THEN x1 = 0
y1 = boomY - boomSize
IF y1 < 0 THEN y1 = 0
x2 = boomX + boomSize
IF x2 > 319 THEN x2 = 319
y2 = boomY + boomSize
IF y2 > 199 THEN y2 = 199
GET (x1, y1)-(x2, y2), ExplodeHold(1)
DO
  TimeCnt% = TimeCnt% + 1
  FOR CurrArc% = 1 TO NumArcs
    IF arc(CurrArc%).Radius > 4 THEN ' Erase previous arc
      CIRCLE (boomX, boomY), arc(CurrArc%).Radius - 5, 0, arc(CurrArc%).p1, arc(CurrArc%).p2
    END IF
    IF arc(CurrArc%).Radius = 0 THEN ' Not yet alive
      ' About 30% of the time, create a new arc
      IF RND > .7 THEN arc(CurrArc%).Radius = 1
    ELSEIF arc(CurrArc%).colr = 131 THEN ' Dead
      REM Do Nothing
    ELSE
      arc(CurrArc%).Radius = arc(CurrArc%).Radius + 1 ' Increase radius
      arc(CurrArc%).colr = arc(CurrArc%).colr + 1 ' Increase color
      ' Draw arc
      CIRCLE (boomX, boomY), arc(CurrArc%).Radius, arc(CurrArc%).colr, arc(CurrArc%).p1, arc(CurrArc%).p2
    END IF
  NEXT CurrArc%
  t! = TIMER: WHILE t! = TIMER: WEND ' Pause
  IF TimeCnt% >= boomSize THEN quitExplode = 1
LOOP UNTIL quitExplode > 0
PUT (x1, y1), ExplodeHold(1), PSET

END SUB

SUB newRock

'initialize the wind, and tell the player.
RANDOMIZE TIMER: windirec = RND * 2:
LOCATE 1, 1: PRINT SPC(30);
IF windirec <= 1 THEN
 RANDOMIZE TIMER: wind = RND * -10
 LOCATE 1, 1: PRINT "wind: "; wind; "<-"
ELSEIF windirec > 1 THEN
 RANDOMIZE TIMER: wind = RND * 10
 LOCATE 1, 1: PRINT "wind:"; wind; "-> "
END IF


'Get player input for angle and velocity, and initialize the rock.
'Velocity can range from 0 to 100, and angle can be inbetween 10 and 180.

LOCATE 2, 1: PRINT "Angle:   "
DO
  LOCATE 2, 7: PRINT "    ";
  LOCATE 2, 7: INPUT "", rockAngle
LOOP UNTIL rockAngle >= 10 AND rockAngle <= 180
LOCATE 3, 1: PRINT "Velocity:   "
DO
  LOCATE 3, 10: PRINT "    ";
  LOCATE 3, 10: INPUT "", rockSpeed
LOOP UNTIL rockSpeed >= 0 AND rockSpeed <= 100
    
LINE (1, 1)-(50, 50), 0
startRockX = castleX + 6
startRockY = 157
oldRockX = startRockX
oldRockY = startRockY
rock1exist = 1

rockAngle = rockAngle / 180 * pi
startRockXvel = COS(rockAngle) * rockSpeed
startRockYvel = SIN(rockAngle) * rockSpeed

t = 0

drawRock

END SUB

SUB newTank

'Initialize tank.
tankExist = 1
TankX = castle2X - 12
oldTankX = castle2X - 12

PUT (castle2X, 159), castle2%, PSET

drawTank

END SUB


