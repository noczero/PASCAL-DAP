' Wormhole
' Version 3.0.0
' by Brent P. Newhall
' This program is PUBLIC DOMAIN.  Anyone may use it however they
'   wish, provided that credit is given where it's due for coding.

' Version 1.0.0 -- Original release.
' Version 1.0.1 -- QBASIC compatibility assured, unneeded variables
'                  removed.
' Version 2.0.0 -- Longer missiles, multiple missiles, blue
'                  wormhole and discontinuities (long blue things),
'                  improved explosions, fading title, improved
'                  score handling, pause function, better graphics
'                  handling, blue good guys, history, QBASIC info.
' Version 3.0.0 -- Better stars, corrected input, energy, energy
'                  powerup, better graphics handling, more
'                  descriptive variables, bombers, fighters,
'                  kamikazes instead of original baddie, speed
'                  bonus, firepower bonus, smart bomb bonus, intro,
'                  levels

' My highest score: 11336 points and 183 aliens killed.  Beat that!

TYPE MonsterType
  x AS INTEGER
  y AS INTEGER
  degree AS INTEGER
  radius AS SINGLE
  speed AS SINGLE
  exist AS INTEGER
  dying AS INTEGER
  AlienType AS INTEGER
END TYPE
TYPE StarType
  x AS INTEGER ' World coordinates
  y AS INTEGER
  z AS INTEGER
  sx AS INTEGER ' Screen coordinates
  sy AS INTEGER
  spd AS INTEGER ' Speed
END TYPE
TYPE VertexType
  x AS SINGLE
  y AS SINGLE
END TYPE
TYPE PolygonType
  BorderColor AS INTEGER
  FilledColor AS INTEGER
  filled AS INTEGER
  lxo AS INTEGER
  lyo AS INTEGER
  NumVertices AS INTEGER
END TYPE
TYPE MissileType
  radius AS INTEGER
  x1 AS INTEGER
  y1 AS INTEGER
  x2 AS INTEGER
  y2 AS INTEGER
  angle AS INTEGER
END TYPE

CONST PI = 3.14159, DEG2RAD = PI / 180
CONST FALSE = 0, TRUE = NOT FALSE
CONST TOT.STARS = 25 ' Increase for a prettier starfield effect
CONST TOT.ALIENS = 20 ' Decrease for QBASIC
CONST NUM.ALIEN.GRAPHICS = 8
CONST TOT.ENERGY = 50

DECLARE SUB Intro ()
DECLARE SUB DrawPolygon (poly AS PolygonType, Verts() AS VertexType)
DECLARE SUB ErasePolygon (poly AS PolygonType, Verts() AS VertexType)
DECLARE SUB RotatePolygon (poly AS PolygonType, Verts() AS VertexType, angle AS INTEGER)
DECLARE SUB ScalePolygon (poly AS PolygonType, Verts() AS VertexType, factor AS SINGLE)
DECLARE SUB Add (amt, var)

DIM SHARED alien(0 TO TOT.ALIENS) AS MonsterType
DIM SHARED star(1 TO TOT.STARS) AS StarType
DIM ship AS PolygonType
DIM ShipVert(1 TO 11) AS VertexType
DIM Missile(1 TO 12) AS MissileType
DIM SHARED SinLook(0 TO 360) AS DOUBLE
DIM SHARED CosLook(0 TO 360) AS DOUBLE
DIM SHARED AlienGraph(1 TO 200, 1 TO NUM.ALIEN.GRAPHICS) AS INTEGER
DIM SHARED ExplodeGraph(1 TO 200, 1 TO 5) AS INTEGER
DIM SHARED AlienMask(1 TO 200, 1 TO NUM.ALIEN.GRAPHICS) AS INTEGER
DIM melt(3000) AS INTEGER
DIM score AS LONG ' Can go up to 2 trillion
DIM SHARED MonstSpeed AS SINGLE

Intro
GOSUB Init
DO
  GOSUB MainProgramLoop
LOOP UNTIL quit > 0
GOSUB EndOfGame
END

MainProgramLoop:
nothing$ = INKEY$ ' Mask out INKEY$
t! = TIMER: WHILE t! = TIMER: WEND ' Delay
nothing$ = INKEY$ ' Mask out INKEY$
GOSUB DoEveryone ' Take care of enemies, ship, missiles, etc.
nothing$ = INKEY$ ' Mask out INKEY$
GOSUB DoInput ' Take care of input
RETURN

DoEveryone:
GOSUB DoColors
GOSUB DoStars ' REM for QBASIC
GOSUB DoWormhole ' REM for QBASIC
GOSUB MoveShip
GOSUB DoAliens
GOSUB DoMissiles
GOSUB DoScore
GOSUB DoBonuses
RETURN

DoColors: ' Flash monster and score colors
IF Beginning THEN
  LOCATE 5, 17: PRINT "WORMHOLE";
  IF GoingUp THEN
    ScoreColor% = ScoreColor% + 1
    IF ScoreColor% = 60 THEN GoingUp = FALSE: Staying = 1
  ELSEIF Staying THEN
    Staying = Staying + 1
    IF Staying = 20 THEN Staying = 0
  ELSE
    ScoreColor% = ScoreColor% - 1
    IF ScoreColor% = 0 THEN ' Begin game
      Beginning = FALSE
      LOCATE 5, 17: PRINT "        ";
      GOSUB CreateMonster ' Create one monster to start
    END IF
  END IF
ELSE
  MonstColor% = MonstColor% + 2
  IF MonstColor% > 60 THEN MonstColor% = 0
  PALETTE 101, MonstColor%
  ScoreColor% = ScoreColor% + ScoreMoving%
  IF ScoreColor% > 50 THEN
    ScoreMoving% = -1
  ELSEIF ScoreColor% < 20 THEN
    ScoreMoving% = 1
  END IF
END IF
PALETTE 102, ScoreColor% + ScoreColor% * 256 + ScoreColor% * 65536
RETURN

DoStars:
FOR cnt% = 1 TO TOT.STARS
  PSET (star(cnt%).sx, star(cnt%).sy), 0 ' Erase star
  star(cnt%).z = star(cnt%).z - star(cnt%).spd ' Update position
  IF star(cnt%).z < 1 THEN ' Out of bounds ?
    star(cnt%).x = INT(RND * 1000) - 500 ' Create new star!
    star(cnt%).y = INT(RND * 1000) - 500
    star(cnt%).z = INT(RND * 1000) + 1
    star(cnt%).sx = 160
    star(cnt%).sy = 100
    star(cnt%).spd = INT(RND * 40) + 10
  END IF
  ' Project 3d coordinates to 2d coordinates
  star(cnt%).sx = 64 * (star(cnt%).x / star(cnt%).z) + 160
  star(cnt%).sy = 64 * (star(cnt%).y / star(cnt%).z) + 100
  ' Draw star
   PSET (star(cnt%).sx, star(cnt%).sy), (32 - star(cnt%).z / 64)
NEXT cnt%
RETURN

DoWormhole:
CIRCLE (159, 99), wormholeradius1, 0 ' Erase old circles
CIRCLE (159, 99), wormholeradius2, 0
wormholeradius1 = INT(RND * 6) ' Create new circle
wormholeradius2 = INT(RND * 6)
CIRCLE (159, 99), wormholeradius1, 9 ' Draw new circles
CIRCLE (159, 99), wormholeradius2, 1
RETURN

MoveShip:
IF moving THEN
  ErasePolygon ship, ShipVert()
  posit% = posit% + moving * ShipSpeed ' Move ship
  IF posit% < 0 THEN posit% = posit% + 360
  IF posit% > 360 THEN posit% = posit% - 360
  ship.lxo = INT(ShipRadius * CosLook(posit%)) + 159
  ship.lyo = INT(ShipRadius * SinLook(posit%)) + 99
  IF EndOfLevel THEN
    ScalePolygon ship, ShipVert(), .9
  ELSE
    IF POINT(ship.lxo, ship.lyo) >= 100 THEN ' Ran into baddie?
      cnt% = 0
      WHILE cnt% < NumAliens
        cnt% = cnt% + 1
        IF alien(cnt%).x <= ship.lxo THEN
          IF alien(cnt%).y <= ship.lyo THEN
            IF alien(cnt%).x + 10 >= ship.lxo THEN
              IF alien(cnt%).y + 10 >= ship.lyo THEN
                energy% = energy% - 10
                IF energy% < 1 THEN quit = 2
                alien(cnt%).dying = 1
              END IF
            END IF
          END IF
        END IF
      WEND
    END IF
    RotatePolygon ship, ShipVert(), moving * ShipSpeed
  END IF
  moving = 0
END IF
DrawPolygon ship, ShipVert()
RETURN

DoAliens:
ToBeKilled% = 0
FOR cnt% = 1 TO NumAliens
  IF alien(cnt%).dying THEN
    PUT (alien(cnt%).x, alien(cnt%).y), ExplodeGraph(1, alien(cnt%).dying)
  ELSE
    PUT (alien(cnt%).x, alien(cnt%).y), AlienGraph(1, alien(cnt%).AlienType)
  END IF
NEXT cnt%
m% = 0
WHILE m% < NumAliens
  m% = m% + 1 ' Loop through, 1..NumAliens
  IF alien(m%).dying < 5 THEN ' If not at end of dying
    alien(m%).radius = alien(m%).radius + alien(m%).speed
    IF alien(m%).AlienType = 1 THEN ' Kamikaze
      IF alien(m%).degree < posit% THEN ' Move towards player
        alien(m%).degree = alien(m%).degree + 1
      ELSEIF alien(m%).degree > posit% THEN
        alien(m%).degree = alien(m%).degree - 1
      END IF
    ELSEIF alien(m%).AlienType = 2 THEN ' Bomber
      IF RND > .99 THEN ' Occasionally create a new fighter
        GOSUB CreateMonster ' Create, then erase created alien
        PUT (alien(NumAliens).x, alien(NumAliens).y), AlienGraph(1, alien(NumAliens).AlienType), XOR
        alien(NumAliens).radius = alien(m%).radius + INT(RND * 11 - 5)
        alien(NumAliens).degree = alien(m%).degree + INT(RND * 7 - 3)
        IF alien(NumAliens).degree < 0 THEN
          alien(NumAliens).degree = alien(NumAliens).degree + 360
        ELSEIF alien(NumAliens).degree > 360 THEN
          alien(NumAliens).degree = alien(NumAliens).degree - 360
        END IF
        alien(NumAliens).x = INT(alien(NumAliens).radius * CosLook(alien(NumAliens).degree)) + 154
        alien(NumAliens).y = INT(alien(NumAliens).radius * SinLook(alien(NumAliens).degree)) + 94
        alien(NumAliens).AlienType = 3 ' Create fighter
        PUT (alien(NumAliens).x, alien(NumAliens).y), AlienGraph(1, alien(NumAliens).AlienType), PSET
      END IF
    END IF
    alien(m%).x = INT(alien(m%).radius * CosLook(alien(m%).degree)) + 154
    alien(m%).y = INT(alien(m%).radius * SinLook(alien(m%).degree)) + 94
    IF alien(m%).dying THEN
      alien(m%).dying = alien(m%).dying + 1
      PUT (alien(m%).x, alien(m%).y), ExplodeGraph(1, alien(m%).dying), PSET
    ELSE
      PUT (alien(m%).x, alien(m%).y), AlienMask(1, alien(m%).AlienType), AND
      PUT (alien(m%).x, alien(m%).y), AlienGraph(1, alien(m%).AlienType), OR
    END IF
    IF alien(m%).radius > 90 THEN ' Outside orbit
      IF alien(m%).AlienType = 4 THEN ' Good guy
        score = score + 250
        ToBeKilled% = m%
      ELSEIF alien(m%).AlienType > 4 THEN ' Bonus!
        MonstersKilled% = MonstersKilled% - 1
        ToBeKilled% = m%
      ELSE ' Baddie
        energy% = energy% - 5
        IF energy% < 1 THEN
          quit = 2
        ELSE
          ToBeKilled% = m%
        END IF
      END IF
    END IF
  ELSE ' At end of dying
    ToBeKilled% = m%
  END IF
WEND
IF ToBeKilled% > 0 THEN
  m% = ToBeKilled%
  ' Erase out last vestiges of monster graphic
  LINE (alien(m%).x - 4, alien(m%).y - 4)-(alien(m%).x + 14, alien(m%).y + 14), 0, BF
  GOSUB KillMonster
END IF
IF NOT Beginning THEN
  IF NumAliensThisLevel < TotAliensThisLevel THEN
    IF RND > MonstChance THEN ' Create new alien occasionally
      GOSUB CreateMonster
    END IF
  ELSEIF NumAliens = 0 THEN ' Full of monsters, all destroyed
    GOSUB EndLevel
  END IF
END IF
RETURN

EndLevel:
level = level + 1
IF level < 6 THEN
  FOR lcnt% = 1 TO 25
    GOSUB DoColors
    GOSUB DoStars
    GOSUB DoWormhole
    t! = TIMER: WHILE t! = TIMER: WEND
  NEXT lcnt%
  energy% = TOT.ENERGY ' Refill energy
  NumAliensThisLevel = 0
  Add 10, TotAliensThisLevel
  Add -.005, MonstChance
  Add .05, MonstSpeed
  EndOfLevel = TRUE
  temp = ShipRadius
  FOR ShipRadius = temp TO 0 STEP -5
    LOCATE 24, 1: PRINT ShipRadius;
    moving = 1
    GOSUB DoColors
    GOSUB DoStars
    GOSUB DoWormhole
    GOSUB MoveShip
    t! = TIMER: WHILE t! = TIMER: WEND
  NEXT ShipRadius
  ShipRadius = temp
  EndOfLevel = FALSE
  RESTORE
  FOR cnt% = 1 TO ship.NumVertices ' Reset vertices
    READ ShipVert(cnt%).x, ShipVert(cnt%).y
  NEXT cnt%
  posit% = 0
  moving = 1
  GOSUB MoveShip
ELSE ' End of game; you won!
  quit = 3
END IF
RETURN

DoMissiles:
miss% = 0
WHILE miss% < NumMissiles
  miss% = miss% + 1 ' Loop through, 1..NumMissiles
  ' Erase missile
  LINE (Missile(miss%).x1%, Missile(miss%).y1%)-(Missile(miss%).x2%, Missile(miss%).y2%), 0
  IF Missile(miss%).radius < 2 THEN ' If at center
    GOSUB KillMissile
  ELSE
    Missile(miss%).radius = Missile(miss%).radius - 3 ' Move its coordinates
    Missile(miss%).x1 = INT(Missile(miss%).radius * CosLook(Missile(miss%).angle)) + 159
    Missile(miss%).y1 = INT(Missile(miss%).radius * SinLook(Missile(miss%).angle)) + 99
    Missile(miss%).x2 = INT((Missile(miss%).radius + 3) * CosLook(Missile(miss%).angle)) + 159
    Missile(miss%).y2 = INT((Missile(miss%).radius + 3) * SinLook(Missile(miss%).angle)) + 99
    IF POINT(Missile(miss%).x1%, Missile(miss%).y1%) >= 100 THEN
      cnt% = 0 ' Hit a monster! (front end)
      WHILE cnt% < NumAliens AND alien(cnt%).dying = 0
        cnt% = cnt% + 1 ' Find hit monster
        IF Missile(miss%).x1% >= alien(cnt%).x THEN
          IF Missile(miss%).y1% >= alien(cnt%).y THEN
            IF Missile(miss%).x1% <= alien(cnt%).x + 10 THEN
              IF Missile(miss%).y1% <= alien(cnt%).y + 10 THEN
                GOSUB HitSomething
              END IF
            END IF
          END IF
        END IF
      WEND
      GOSUB KillMissile
    ELSEIF POINT(Missile(miss%).x2%, Missile(miss%).y2%) >= 100 THEN
      cnt% = 0 ' Hit a monster! (back end)
      WHILE cnt% < NumAliens AND alien(cnt%).dying = 0
        cnt% = cnt% + 1 ' Find hit monster
        IF Missile(miss%).x2% >= alien(cnt%).x THEN
          IF Missile(miss%).y2% >= alien(cnt%).y THEN
            IF Missile(miss%).x2% <= alien(cnt%).x + 10 THEN
              IF Missile(miss%).y2% <= alien(cnt%).y + 10 THEN
                GOSUB HitSomething
              END IF
            END IF
          END IF
        END IF
      WEND
      GOSUB KillMissile
    ELSE ' Draw Missile
      LINE (Missile(miss%).x1%, Missile(miss%).y1%)-(Missile(miss%).x2%, Missile(miss%).y2%), 14
    END IF
  END IF
WEND
RETURN

HitSomething:
IF alien(cnt%).AlienType > 4 THEN ' Powerup
  m% = cnt%
  SELECT CASE alien(cnt%).AlienType
    CASE 5 ' Energy
      energy% = energy% + 10
      IF energy% > TOT.ENERGY THEN energy% = TOT.ENERGY
    CASE 6 ' Firepower
      LOCATE 25, 10: PRINT CHR$(15); ' Print firepower thingy
      RateOfFire = .4 ' Quicker rate of fire
      FirepowerCnt% = 250 ' Lasts 250 ticks
      bonus = TRUE
    CASE 7 ' Speed
      LOCATE 25, 12: PRINT CHR$(19); ' Print speed thingy
      ShipSpeed = 5 ' Quicker speed around orbit
      ExtraSpeedCnt% = 250 ' Lasts 250 ticks
      bonus = TRUE
    CASE 8
      LOCATE 25, 14: PRINT CHR$(236);
      SmartBomb = TRUE
  END SELECT
  ' Erase out last vestiges of alien graphic
  LINE (alien(m%).x - 3, alien(m%).y - 3)-(alien(m%).x + 13, alien(m%).y + 13), 0, BF
  GOSUB KillMonster
ELSE
  alien(cnt%).dying = 1
END IF
RETURN

Fire:
IF TIMER > LastMissile! + RateOfFire OR NumMissiles = 0 THEN
  ' If time has passed or there are no active missiles
  IF NumMissiles < 10 THEN ' If enough missiles left
    NumMissiles = NumMissiles + 1
    Missile(NumMissiles).radius = 78 ' Put near ship
    Missile(NumMissiles).angle = posit% ' Missile Angle = Ship Angle
    score = score - 5
    IF score < 0 THEN score = 0
    LastMissile! = TIMER
  END IF
END IF
RETURN

CreateMonster:
IF NumAliens < TOT.ALIENS - 1 THEN ' If there's space
  Add 1, NumAliens ' Another monster
  alien(NumAliens).x = 154 ' First coordinates
  alien(NumAliens).y = 94
  alien(NumAliens).degree = INT(RND * 361)
  alien(NumAliens).radius = 0 ' In the middle
  alien(NumAliens).exist = TRUE
  IF RND > .95 THEN ' 5% of the time
    IF RND > .5 THEN ' Create good guy half the time
      alien(NumAliens).AlienType = 4
    ELSE ' Create bonus
      IF RND > .75 THEN ' energy 25% of the time
        alien(NumAliens).AlienType = 5
      ELSEIF RND > .75 THEN ' firepower 25% of the time
        alien(NumAliens).AlienType = 6
      ELSEIF RND > .75 THEN ' speed 25% of the time
        alien(NumAliens).AlienType = 7
      ELSE ' smart bomb rest of the time
        alien(NumAliens).AlienType = 8
      END IF
    END IF
  ELSE ' Regular bad guy rest of the time
    Add 1, NumAliensThisLevel ' Another (real, bad) alien
    IF RND > .66 THEN ' fighter 33% of the time
      alien(NumAliens).AlienType = 3
      alien(NumAliens).speed = MonstSpeed / 3
    ELSEIF RND > .8 THEN ' bomber 20% of the time
      alien(NumAliens).AlienType = 2
      alien(NumAliens).speed = MonstSpeed
    ELSE ' kamikaze rest of the time
      alien(NumAliens).AlienType = 1
      alien(NumAliens).speed = MonstSpeed
    END IF
  END IF
  PUT (alien(NumAliens).x, alien(NumAliens).y), AlienGraph(1, alien(NumAliens).AlienType), PSET
END IF
RETURN

KillMonster:
IF alien(m%).AlienType <= 3 THEN
  ' Further in, higher score
  score = score + (100 - alien(m%).radius)
  MonstersKilled% = MonstersKilled% + 1
ELSE
  score = score - 100
  IF score < 0 THEN score = 0
END IF
FOR cnt1% = m% TO NumAliens ' Copy next over current
  alien(cnt1%).x = alien(cnt1% + 1).x
  alien(cnt1%).y = alien(cnt1% + 1).y
  alien(cnt1%).degree = alien(cnt1% + 1).degree
  alien(cnt1%).radius = alien(cnt1% + 1).radius
  alien(cnt1%).dying = alien(cnt1% + 1).dying
  alien(cnt1%).exist = alien(cnt1% + 1).exist
  alien(cnt1%).AlienType = alien(cnt1% + 1).AlienType
NEXT cnt1%
NumAliens = NumAliens - 1 ' One less monster!
RETURN

KillMissile:
FOR cnt1% = miss% TO NumMissiles ' Copy next over current
  Missile(cnt1%).x1 = Missile(cnt1% + 1).x1
  Missile(cnt1%).y1 = Missile(cnt1% + 1).y1
  Missile(cnt1%).x2 = Missile(cnt1% + 1).x2
  Missile(cnt1%).y2 = Missile(cnt1% + 1).y2
  Missile(cnt1%).angle = Missile(cnt1% + 1).angle
  Missile(cnt1%).radius = Missile(cnt1% + 1).radius
NEXT cnt1%
NumMissiles = NumMissiles - 1 ' One less missile
RETURN

DoScore:
IF NOT Beginning THEN
  LOCATE 25, 1: PRINT score;
  LOCATE 25, 26: PRINT "-"; level; "-";
  LOCATE 25, 36: PRINT MonstersKilled%;
  LINE (0, 24)-(0, 174), 0
  LINE (0, 174 - energy% * 3)-(0, 174), 138
END IF
RETURN

DoInput:
kp% = INP(&H60) ' Get keypress in kp%
IF kp% < 100 THEN ' &H60 is > 100 if no keypresses
  IF kp% = 77 THEN ' [RIGHT]
    moving = -1
  ELSEIF kp% = 75 THEN ' [LEFT]
    moving = 1
  ELSEIF kp% = 57 THEN ' [SPACE]
    GOSUB Fire
  ELSEIF kp% = 25 THEN ' [P]
    GOSUB Pause
  ELSEIF kp% = 28 THEN ' [ENTER]
    IF Beginning THEN
      GoingUp = FALSE
      Staying = 0
      ScoreColor% = 1
    ELSEIF SmartBomb THEN ' If you have a smart bomb
      LOCATE 25, 14: PRINT " ";
      SmartBomb = FALSE
      FOR cnt% = 1 TO NumAliens
        IF alien(cnt%).dying < 1 THEN ' If not dying
          alien(cnt%).dying = 1 ' Kill 'em
        END IF
      NEXT cnt%
    END IF
  ELSEIF kp% = 1 THEN ' [ESC]
    quit = 1
  END IF
END IF
RETURN

DoBonuses:
IF bonus THEN
  IF FirepowerCnt% > 0 THEN
    FirepowerCnt% = FirepowerCnt% - 1
    IF FirepowerCnt% = 0 THEN
      RateOfFire = .7
      IF ExtraSpeedCnt% = 0 THEN bonus = FALSE
      LOCATE 25, 10: PRINT " ";
    END IF
  ELSEIF ExtraSpeedCnt% > 0 THEN
    ExtraSpeedCnt% = ExtraSpeedCnt% - 1
    IF ExtraSpeedCnt% = 0 THEN
      ShipSpeed = 3
      IF FirepowerCnt% = 0 THEN bonus = FALSE
      LOCATE 25, 12: PRINT " ";
    END IF
  END IF
END IF
RETURN

Pause:
IF NOT Beginning THEN
  LOCATE 5, 18: PRINT "PAUSED";
  DO: LOOP UNTIL INKEY$ <> "" ' Wait for keypress
  LOCATE 5, 18: PRINT "      ";
END IF
RETURN

Init:
SCREEN 13
RANDOMIZE TIMER

CIRCLE (5, 5), 5, 100: PAINT (5, 5), 100 ' Draw kamikaze
LINE (0, 0)-(10, 10), 100
LINE (10, 0)-(0, 10), 100
LINE (4, 5)-(6, 5), 101
LINE (5, 4)-(5, 6), 101
PSET (0, 0), 101: PSET (10, 0), 101
PSET (0, 10), 101: PSET (10, 10), 101
GET (0, 0)-(10, 10), AlienGraph(1, 1)
LINE (0, 0)-(10, 10), 255, BF ' Draw mask
CIRCLE (5, 5), 5, 100: PAINT (5, 5), 100
LINE (0, 0)-(10, 10), 100
LINE (10, 0)-(0, 10), 100
LINE (4, 5)-(6, 5), 101
LINE (5, 4)-(5, 6), 101
PSET (0, 0), 101: PSET (10, 0), 101
PSET (0, 10), 101: PSET (10, 10), 101
GET (0, 0)-(10, 10), AlienMask(1, 1)
PUT (0, 0), AlienMask(1, 1)

PUT (10, 10), AlienGraph(1, 1)
LINE (10, 15)-(20, 15), 0 ' Explosion 1
LINE (15, 10)-(16, 20), 0
LINE (14, 14)-(17, 16), 0, B
CIRCLE (15, 15), 3, 12, , , 1 / 3
PAINT (15, 15), 12
PSET (14, 13), 7
PSET (17, 17), 7
GET (8, 8)-(22, 22), ExplodeGraph(1, 1)

CIRCLE (16, 15), 4, 0 ' Explosion 2
CIRCLE (15, 15), 4, 12, , , 1 / 2
CIRCLE (15, 15), 2, 14, , , 1 / 2
PAINT (15, 15), 14
CIRCLE (13, 12), 1, 7: PSET (13, 12), 7
CIRCLE (18, 18), 1, 7: PSET (18, 18), 7
GET (8, 8)-(22, 22), ExplodeGraph(1, 2)

PUT (10, 10), AlienGraph(1, 1), PSET ' Explosion 3
CIRCLE (15, 15), 6, 0: PAINT (15, 15), 0
CIRCLE (15, 15), 6, 4, , , 1 / 2
PAINT (15, 15), 4
CIRCLE (15, 15), 4, 14, , , 1 / 2
PAINT (15, 15), 14
PSET (10, 10), 0
CIRCLE (12, 11), 1, 8
CIRCLE (19, 19), 1, 8
GET (8, 8)-(22, 22), ExplodeGraph(1, 3)
PUT (8, 8), ExplodeGraph(1, 3)

CIRCLE (15, 15), 7, 116, , , 1 / 2 ' Explosion 4
PAINT (15, 15), 116
CIRCLE (15, 15), 4, 0, , , 1 / 2
PAINT (15, 15), 0
GET (8, 8)-(22, 22), ExplodeGraph(1, 4)
PUT (8, 8), ExplodeGraph(1, 4)

CIRCLE (15, 15), 7, 43, , , 1 / 2 ' Explosion 5
GET (8, 8)-(22, 22), ExplodeGraph(1, 5)
PUT (8, 8), ExplodeGraph(1, 5)

CIRCLE (15, 15), 5, 100, , , 1 ' Draw bomber
PAINT (15, 15), 100
CIRCLE (15, 15), 5, 101, , , 1
GET (10, 10)-(20, 20), AlienGraph(1, 2)
LINE (10, 10)-(20, 20), 255, BF ' Draw mask
CIRCLE (15, 15), 5, 100, , , 1
PAINT (15, 15), 100
CIRCLE (15, 15), 5, 101, , , 1
GET (10, 10)-(20, 20), AlienMask(1, 2)
PUT (10, 10), AlienMask(1, 2)

LINE (15, 11)-(15, 19), 101 ' Draw fighter
LINE (11, 15)-(19, 15), 101
LINE (12, 15)-(15, 12), 100
LINE (15, 12)-(18, 15), 100
LINE (12, 15)-(15, 18), 100
LINE (15, 18)-(18, 15), 100
PAINT (15, 15), 100
GET (10, 10)-(20, 20), AlienGraph(1, 3)
LINE (10, 10)-(20, 20), 255, BF
LINE (15, 11)-(15, 19), 101
LINE (11, 15)-(19, 15), 101
LINE (12, 15)-(15, 12), 100
LINE (15, 12)-(18, 15), 100
LINE (12, 15)-(15, 18), 100
LINE (15, 18)-(18, 15), 100
PAINT (15, 15), 100
GET (10, 10)-(20, 20), AlienMask(1, 3)
PUT (10, 10), AlienMask(1, 3)

CIRCLE (15, 15), 5, 104, , , 1 / 3 ' Draw good guy
PAINT (15, 15), 104
CIRCLE (15, 15), 5, 104, , , 3
LINE (15, 10)-(15, 20), 104
LINE (10, 10)-(20, 20), 104
LINE (20, 10)-(10, 20), 104
GET (10, 10)-(20, 20), AlienGraph(1, 4)
LINE (10, 10)-(20, 20), 255, BF ' Draw mask
CIRCLE (15, 15), 5, 104, , , 1 / 3
PAINT (15, 15), 104
CIRCLE (15, 15), 5, 104, , , 3
LINE (15, 10)-(15, 20), 104
LINE (10, 10)-(20, 20), 104
LINE (20, 10)-(10, 20), 104
GET (10, 10)-(20, 20), AlienMask(1, 4)
PUT (10, 10), AlienMask(1, 4)

CIRCLE (15, 15), 1, 105 ' Draw energy powerup
PAINT (15, 15), 105
CIRCLE (15, 15), 3, 105
GET (10, 10)-(20, 20), AlienGraph(1, 5)
LINE (10, 10)-(20, 20), 255, BF ' Draw mask
CIRCLE (15, 15), 1, 105
PAINT (15, 15), 105
CIRCLE (15, 15), 3, 105
GET (10, 10)-(20, 20), AlienMask(1, 5)
PUT (10, 10), AlienMask(1, 5)

LINE (12, 12)-(18, 18), 105, B ' Draw firepower powerup
LINE (12, 12)-(18, 18), 105
LINE (12, 18)-(18, 12), 105
GET (10, 10)-(20, 20), AlienGraph(1, 6)
LINE (10, 10)-(20, 20), 255, BF
LINE (12, 12)-(18, 18), 105, B
LINE (12, 12)-(18, 18), 105
LINE (12, 18)-(18, 12), 105
GET (10, 10)-(20, 20), AlienMask(1, 6)
PUT (10, 10), AlienMask(1, 6)

LINE (15, 10)-(15, 20), 105 ' Draw speed powerup
LINE (10, 15)-(20, 15), 105
LINE (14, 11)-(16, 19), 105, B
LINE (11, 14)-(19, 16), 105, B
LINE (14, 15)-(16, 15), 0
LINE (15, 14)-(15, 16), 0
GET (10, 10)-(20, 20), AlienGraph(1, 7)
LINE (10, 10)-(20, 20), 255, BF
LINE (15, 10)-(15, 20), 105 ' Draw speed powerup
LINE (10, 15)-(20, 15), 105
LINE (14, 11)-(16, 19), 105, B
LINE (11, 14)-(19, 16), 105, B
LINE (14, 15)-(16, 15), 255
LINE (15, 14)-(15, 16), 255
GET (10, 10)-(20, 20), AlienMask(1, 7)
PUT (10, 10), AlienMask(1, 7)

CIRCLE (15, 15), 3, 105, , , 1 ' Draw smart bomb
PAINT (15, 15), 105
LINE (12, 15)-(18, 15), 106
LINE (15, 12)-(15, 18), 106
GET (10, 10)-(20, 20), AlienGraph(1, 8)
LINE (10, 10)-(20, 20), 255, BF
CIRCLE (15, 15), 3, 105, , , 1
PAINT (15, 15), 105
LINE (12, 15)-(18, 15), 106
LINE (15, 12)-(15, 18), 106
GET (10, 10)-(20, 20), AlienMask(1, 8)
PUT (10, 10), AlienMask(1, 8)

PALETTE 100, 30 ' Change alien color to red
PALETTE 101, 60 ' Change alien other color to red
PALETTE 104, 3942440 ' Change good guy color to bright blue
PALETTE 105, 50 + 50 * 256 ' Change bonus color to yellow
PALETTE 106, 10 + 2560 + 655360 ' Extra color, gray

FOR cnt% = 0 TO 360 ' Initialise look-up tables
  SinLook(cnt%) = SIN(cnt% * DEG2RAD)
  CosLook(cnt%) = COS(cnt% * DEG2RAD)
NEXT cnt%

posit% = 0 ' Player's initial position = 0
ship.lxo = INT(80 * CosLook(posit%)) + 159
ship.lyo = INT(80 * SinLook(posit%)) + 99
energy% = TOT.ENERGY
score = 0
MonstersKilled% = 0
ScoreColor% = 0
ScoreMoving% = 1

FOR cnt% = 1 TO TOT.STARS ' Initialise stars
  star(cnt%).x = INT(RND * 1000) - 500
  star(cnt%).y = INT(RND * 1000) - 500
  star(cnt%).z = INT(RND * 1000) + 1
  star(cnt%).sx = 160
  star(cnt%).sy = 100
  star(cnt%).spd = INT(RND * 40) + 10
NEXT cnt%

ship.BorderColor = 53 ' Original ship color is light blue
ship.filled = FALSE ' Ship is not filled
ship.NumVertices = 11 ' 11 vertices (3 for QBASIC)
FOR cnt% = 1 TO ship.NumVertices ' Define vertices
  READ ShipVert(cnt%).x, ShipVert(cnt%).y
NEXT cnt%
ShipRadius = 80
RateOfFire = .7
ShipSpeed = 3

level = 1
NumAliensThisLevel = 0
TotAliensThisLevel = 30

MonstSpeed = .1
MonstChance = .97

PALETTE 102, 0
COLOR 102

Beginning = TRUE
GoingUp = TRUE

DrawPolygon ship, ShipVert()
RETURN

EndOfGame:
IF quit = 1 THEN ' Manual end
  SCREEN 0: WIDTH 80
  PRINT "Quitter!"
ELSEIF quit = 2 THEN ' Death
  LOCATE 12, 16: PRINT "YOU LOSE";
  SLEEP 2 ' Pause for two seconds
  done = FALSE
  cnt% = 0
  WHILE cnt% < 2000 AND NOT done
    cnt% = cnt% + 1 ' Loop 3000 times
    XX% = INT(RND * 271)
    YX% = INT(RND * 150)
    GET (XX%, YX%)-(XX% + 48, YX% + 48), melt
    PUT (XX%, YX% + 1), melt, PSET
    ' End on keyhit only after melting awhile
    IF INKEY$ <> "" THEN IF cnt% > 500 THEN done = TRUE
    ' Do an occasional delay
    IF cnt% MOD 100 = 0 THEN t! = TIMER: WHILE t! = TIMER: WEND
  WEND
  SCREEN 0: WIDTH 80 ' Normal text screen
  PRINT "You lose."
ELSEIF quit = 3 THEN ' You won!
  REM Neat animation to be added here
  ErasePolygon ship, ShipVert()
  PALETTE 14, 0 ' Erase missiles
  PALETTE 102, 0
  PALETTE 138, 0
  FOR ecnt% = 1 TO 30
    GOSUB DoStars
    r = r + 10
    CIRCLE (159, 99), wormholeradius1, 0 ' Erase old circles
    CIRCLE (159, 99), wormholeradius2, 0
    wormholeradius1 = INT(RND * 6) + r
    wormholeradius2 = INT(RND * 6) + r
    CIRCLE (159, 99), wormholeradius1, 9 ' Draw new circles
    CIRCLE (159, 99), wormholeradius2, 1
    t! = TIMER: WHILE t! = TIMER: WEND
  NEXT ecnt%
  FOR ecnt% = 1 TO 25
    t! = TIMER: WHILE t! = TIMER: WEND
  NEXT ecnt%
  SCREEN 0: WIDTH 80
  PRINT "You won!"
END IF
PRINT "You ended up with a score of"; score; "and"; MonstersKilled%; "aliens killed."
RETURN

' REM out the following 11 DATA statements for QBASIC

' Regular ship polygon
DATA 0, 0
DATA 5, -5
DATA 10, -5
DATA 5, -10
DATA 10, -10
DATA 15, -5
DATA 15, 5
DATA 10, 10
DATA 5, 10
DATA 10, 5
DATA 5, 5

' QBASIC triangular ship polygon
DATA 0, 0
DATA 10, -5
DATA 10, 5

SUB Add (amt, var)

' Adds _amt_ to var
var = var + amt

END SUB

SUB DrawPolygon (poly AS PolygonType, Verts() AS VertexType)

xo = poly.lxo
yo = poly.lyo

IF poly.filled THEN
  FOR index = 1 TO poly.NumVertices - 1
    LINE (xo + Verts(index).x, yo + Verts(index).y)-(xo + Verts(index + 1).x, yo + Verts(index + 1).y), poly.FilledColor
  NEXT index
  LINE (xo + Verts(poly.NumVertices).x, yo + Verts(poly.NumVertices).y)-(xo + Verts(1).x, yo + Verts(1).y), poly.FilledColor
  PAINT (xo, yo), poly.FilledColor
ELSE
  FOR index = 1 TO poly.NumVertices - 1
    LINE (xo + Verts(index).x, yo + Verts(index).y)-(xo + Verts(index + 1).x, yo + Verts(index + 1).y), poly.BorderColor
  NEXT index
  LINE (xo + Verts(poly.NumVertices).x, yo + Verts(poly.NumVertices).y)-(xo + Verts(1).x, yo + Verts(1).y), poly.BorderColor
END IF

END SUB

SUB ErasePolygon (poly AS PolygonType, Verts() AS VertexType)

xo = poly.lxo
yo = poly.lyo

IF poly.filled THEN
  FOR index = 1 TO poly.NumVertices - 1
    LINE (xo + Verts(index).x, yo + Verts(index).y)-(xo + Verts(index + 1).x, yo + Verts(index + 1).y), 0
  NEXT index
  LINE (xo + Verts(poly.NumVertices).x, yo + Verts(poly.NumVertices).y)-(xo + Verts(1).x, yo + Verts(1).y), 0
  PAINT (xo, yo), FilledColor
ELSE
  FOR index = 1 TO poly.NumVertices - 1
    LINE (xo + Verts(index).x, yo + Verts(index).y)-(xo + Verts(index + 1).x, yo + Verts(index + 1).y), 0
  NEXT index
  LINE (xo + Verts(poly.NumVertices).x, yo + Verts(poly.NumVertices).y)-(xo + Verts(1).x, yo + Verts(1).y), 0
END IF

END SUB

SUB Intro ()

CLS
PRINT "     One day, without warning, the heavens next to our planet opened"
PRINT "   like a flower.  Out of this wormhole came an alien delegation,"
PRINT "   their only wish to sign a treaty with us.  We sent our entire"
PRINT "   starfleet to the wormhole's mouth in this treaty's honor."
PRINT "     Then, out of that wormhole poured ships the likes of which we had"
PRINT "   never dreamed.  Our fleet was decimated; most ships were"
PRINT "   destroyed, others pulled into the wormhole to fight on the"
PRINT "   aliens' ground.  But we had made our mark: the half of their"
PRINT "   fleet remaining withdrew into the wormhole."
PRINT "     Now, you man the only spaceworthy ship left.  Your mission:"
PRINT "   destroy the aliens as they come out of the wormhole, as their"
PRINT "   weapons are useless for a small critical distance from the"
PRINT "   wormhole's mouth.  They will be defenseless unless they get"
PRINT "   past you.  Good luck!"
PRINT "     Your ship can only move in a circular orbit around the wormhole"
PRINT "   out of which the red aliens are coming.  Use the left and right"
PRINT "   arrow keys to move around, [SPACE] to fire a missile at the"
PRINT "   aliens, and [ESC] to quit.  Hit [ENTER] to bypass the"
PRINT "   beginning, and [P] to pause.  Your score is displayed in the"
PRINT "   lower left, and number of aliens destroyed in the lower right."
PRINT "   Blue ships are our ships returning; let them pass.  The brown"
PRINT "   bar on the left is your energy.  Each alien that gets by will"
PRINT "   drain your energy; let enough by and Game Over!"
LOCATE 25, 50: PRINT "Hit any key to continue....";
DO: LOOP UNTIL INKEY$ <> ""


END SUB

SUB RotatePolygon (poly AS PolygonType, Verts() AS VertexType, angle AS INTEGER)

IF angle >= 0 THEN
  si = SIN(angle * DEG2RAD)
  cs = COS(angle * DEG2RAD)
ELSE
  si = SIN((angle + 360) * DEG2RAD)
  cs = COS((angle + 360) * DEG2RAD)
END IF

FOR index = 1 TO poly.NumVertices
  rx = Verts(index).x * cs - Verts(index).y * si
  ry = Verts(index).y * cs + Verts(index).x * si
  Verts(index).x = rx
  Verts(index).y = ry
NEXT index

END SUB

SUB ScalePolygon (poly AS PolygonType, Verts() AS VertexType, factor AS SINGLE)

' Scales the polygon in _poly_ and _verts()_ by the _factor_

FOR index% = 1 TO poly.NumVertices
  Verts(index%).x = Verts(index%).x * factor
  Verts(index%).y = Verts(index%).y * factor
NEXT index%

END SUB
