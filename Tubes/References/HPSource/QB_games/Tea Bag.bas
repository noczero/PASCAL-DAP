CONST pal& = 256
DIM SHARED sprite(36, 5, 2)
DIM SHARED bullet(1)
DIM SHARED mineimg(2)
SCREEN 12
CLS

ON TIMER(1) GOSUB EndTime
TIMER ON
Stoptime = 0
DO
delay = delay + 1
LOOP UNTIL Stoptime = 1
TIMER OFF

RANDOMIZE TIMER
RESTORE
FOR a = 1 TO 4
  FOR b = 1 TO 11
    FOR c = 1 TO 17
      READ col
      PSET (c + (a * 120), b + 100), col
    NEXT c
  NEXT b
LOCATE 9, a * 14
SELECT CASE a
  CASE 1: PRINT "1. Cow"
  CASE 2: PRINT "2. Sheep"
  CASE 3: PRINT "  3. Pig"
  CASE 4: PRINT "  4. Horse"
END SELECT
NEXT a

GetPlayers:
LOCATE 12, 10: INPUT "How many players?", players
IF players > 4 OR players < 2 THEN GOTO GetPlayers

FOR a = 1 TO players
GetAnimal:
  LOCATE 12 + (2 * a), 10
  PRINT "Which animal, player"; a;
  INPUT animal(a)
  IF animal(a) < 1 OR animal(a) > 4 THEN GOTO GetAnimal
  FOR b = 1 TO 4
    IF animal(a) = animal(b) AND a <> b THEN GOTO GetAnimal
  NEXT b
  GET (1 + (animal(a) * 120), 100)-(17 + (animal(a) * 120), 111), sprite(36, a, 1)
  SELECT CASE animal(a)
    CASE 1: RESTORE CowData
    CASE 2: RESTORE SheepData
    CASE 3: RESTORE PigData
    CASE 4: RESTORE HorseData
  END SELECT
  FOR b = 1 TO 11
    FOR c = 1 TO 17
      READ col
      PSET ((animal(a) * 120) + 18 - c, b + 100), col
    NEXT c
  NEXT b
  GET (1 + (animal(a) * 120), 100)-(17 + (animal(a) * 120), 111), sprite(36, a, 2)
NEXT a

GetLives:
LOCATE 22, 10: INPUT "How many lives?", lives
IF lives > 9 THEN GOTO GetLives
LOCATE 23, 10: INPUT "Do you want squidgy hits? (Y or N)", squidgy$
SELECT CASE LCASE$(squidgy$)
  CASE "y": squidgy = 1
  CASE ELSE: squidgy = 0
END SELECT
LOCATE 25, 30: PRINT "Press a key to start"

key$ = ""
DO UNTIL key$ <> ""
key$ = INKEY$
LOOP

FOR a = 1 TO players
  x(a) = -1
  y(a) = -1
NEXT a
CLS

PALETTE 7, 0
PALETTE 12, 0
LINE (100, 100)-(105, 100), 7
LINE (101, 99)-(104, 99), 13
GET (100, 99)-(105, 100), mineimg
CLS
PALETTE
PLAY "<<l8"

LINE (0, 421)-(639, 460), 14, BF
LINE (0, 421)-(80, 425), 12, BF
LINE (559, 421)-(639, 425), 12, BF
GET (100, 425)-(105, 425), bullet

ON TIMER(1) GOSUB FlashMine

FOR a = 1 TO players
  mine(a) = 0
  lives(a) = lives
  PUT (1 + (a * 120), 465), sprite(36, a, 2)
  LOCATE 30, ((a) * 15) + 4
  PRINT lives(a);
SetUp:
  x(a) = INT(RND * 620)
  y(a) = INT(RND * 400)
  FOR b = 1 TO players
    IF x(a) >= x(b) AND x(a) <= x(b) + 17 AND y(a) >= y(b) AND y(a) <= y(b) + 11 AND a <> b THEN GOTO SetUp
  NEXT b
  movex(a) = 0
  change(a) = 0
  dir(a) = 1 + INT(RND * 2)
  PUT (x(a), y(a)), sprite(36, a, dir(a)), XOR
NEXT a

TIMER ON

DO
  key$ = ""
  key$ = INKEY$
  IF key$ <> "" THEN
    IF lives(1) > 0 THEN
      SELECT CASE key$
        CASE "\", "|": movex(1) = movex(1) - 5
        CASE "z", "Z"
          IF fire(1) = 1 THEN PUT (firex(1), firey(1)), bullet, XOR
          fire(1) = 1
          firey(1) = y(1) + 6
          IF dir(1) = 1 THEN firex(1) = x(1) - 6: firedir(1) = -1
          IF dir(1) = 2 THEN firex(1) = x(1) + 17: firedir(1) = 1
          IF firex(1) >= 0 THEN PUT (firex(1), firey(1)), bullet, XOR
          IF firex(1) < 0 THEN fire(1) = 0
        CASE "x", "X": movex(1) = movex(1) + 5
        CASE "c", "C"
          IF y(1) < 409 THEN
            IF mine(1) = 1 THEN PUT (minex(1), miney(1)), mineimg, XOR
            mine(1) = 1
            minex(1) = x(1) + 7
            miney(1) = y(1) + 11
            PUT (minex(1), miney(1)), mineimg, XOR
          END IF
      END SELECT
    END IF
    IF lives(2) > 0 THEN
      SELECT CASE key$
        CASE "1": movex(2) = movex(2) - 5
        CASE "2"
          IF fire(2) = 1 THEN PUT (firex(2), firey(2)), bullet, XOR
          fire(2) = 1
          firey(2) = y(2) + 6
          IF dir(2) = 1 THEN firex(2) = x(2) - 6: firedir(2) = -1
          IF dir(2) = 2 THEN firex(2) = x(2) + 17: firedir(2) = 1
          IF firex(2) >= 0 THEN PUT (firex(2), firey(2)), bullet, XOR
          IF firex(2) < 0 THEN fire(2) = 0
        CASE "3": movex(2) = movex(2) + 5
        CASE CHR$(13)
          IF y(2) < 409 THEN
            IF mine(2) = 1 THEN PUT (minex(2), miney(2)), mineimg, XOR
            mine(2) = 1
            minex(2) = x(2) + 7
            miney(2) = y(2) + 11
            PUT (minex(2), miney(2)), mineimg, XOR
          END IF
      END SELECT
    END IF
    IF lives(3) > 0 THEN
      SELECT CASE key$
        CASE "m", "M": movex(3) = movex(3) - 5
        CASE ",", "<"
          IF fire(3) = 1 THEN PUT (firex(3), firey(3)), bullet, XOR
          fire(3) = 1
          firey(3) = y(3) + 6
          IF dir(3) = 1 THEN firex(3) = x(3) - 6: firedir(3) = -1
          IF dir(3) = 2 THEN firex(3) = x(3) + 17: firedir(3) = 1
          IF firex(3) >= 0 THEN PUT (firex(3), firey(3)), bullet, XOR
          IF firex(3) < 0 THEN fire(3) = 0
        CASE ".", ">": movex(3) = movex(3) + 5
        CASE "/", "?"
          IF y(3) < 409 THEN
            IF mine(3) = 1 THEN PUT (minex(3), miney(3)), mineimg, XOR
            mine(3) = 1
            minex(3) = x(3) + 7
            miney(3) = y(3) + 11
            PUT (minex(3), miney(3)), mineimg, XOR
          END IF
      END SELECT
    END IF
    IF lives(4) > 0 THEN
      SELECT CASE key$
        CASE "r", "R": movex(4) = movex(4) - 5
        CASE "t", "T"
          IF fire(4) = 1 THEN PUT (firex(4), firey(4)), bullet, XOR
          fire(4) = 1
          firey(4) = y(4) + 6
          IF dir(4) = 1 THEN firex(4) = x(4) - 6: firedir(4) = -1
          IF dir(4) = 2 THEN firex(4) = x(4) + 17: firedir(4) = 1
          IF firex(4) >= 0 THEN PUT (firex(4), firey(4)), bullet, XOR
          IF firex(4) < 0 THEN fire(4) = 0
        CASE "y", "Y": movex(4) = movex(4) + 5
        CASE "u", "U"
          IF y(4) < 409 THEN
            IF mine(4) = 1 THEN PUT (minex(4), miney(4)), mineimg, XOR
            mine(4) = 1
            minex(4) = x(4) + 7
            miney(4) = y(4) + 11
            PUT (minex(4), miney(4)), mineimg, XOR
          END IF
      END SELECT
    END IF
    IF key$ = CHR$(27) THEN END
  END IF
  FOR a = 1 TO players
    IF lives(a) > 0 THEN
      PUT (x(a), y(a)), sprite(36, a, dir(a)), XOR
      x(a) = x(a) + movex(a)
      IF movex(a) < oldmovex(a) THEN dir(a) = 1
      IF movex(a) > oldmovex(a) THEN dir(a) = 2
      IF x(a) < 0 OR x(a) > 622 THEN
        IF x(a) < 0 THEN x(a) = 0
        IF x(a) > 622 THEN x(a) = 622
        movex(a) = -movex(a)
      END IF
      movex(a) = movex(a) / 1.04
      IF movex(a) > 10 THEN movex(a) = 10
      y(a) = y(a) + change(a)
      change(a) = change(a) + .5
      IF y(a) < 0 THEN
        y(a) = 0
        change(a) = -change(a)
      END IF
      IF y(a) >= 409 THEN
        y(a) = 409
        IF x(a) > 80 AND x(a) < 542 THEN
          change(a) = -change(a) + 1.5
        ELSE
          change(a) = -change(a) - 1
        END IF
        IF change(a) < -19 THEN change(a) = -19
      END IF
      IF squidgy = 1 THEN
        FOR shs = 1 TO players
          IF x(a) >= x(shs) - 17 AND x(a) <= x(shs) + 17 AND y(a) >= y(shs) - 11 AND y(a) <= y(shs) + 11 AND a <> shs THEN
            change(a) = -change(a)
            change(shs) = -change(shs)
            SWAP movex(a), movex(shs)
          END IF
        NEXT shs
      END IF
      FOR d = 1 TO players
        IF mine(d) = 1 THEN
          IF a = d AND miney(d) < 419 THEN GOTO NoOuch
          IF x(a) >= minex(d) - 17 AND x(a) <= minex(d) + 6 AND y(a) >= miney(d) - 11 AND y(a) <= miney(d) + 2 THEN
            c = a
            IF lives(a) = 1 THEN PUT (x(a), y(a)), sprite(36, a, dir(a)), XOR
            GOSUB HitAnimal
            PUT (minex(d), miney(d)), mineimg, XOR
            mine(d) = 0
          END IF
        END IF
NoOuch:
      NEXT d
      IF lives(a) > 0 THEN PUT (x(a), y(a)), sprite(36, a, dir(a)), XOR
      oldmovex(a) = movex(a)
    END IF
    IF fire(a) = 1 THEN
      PUT (firex(a), firey(a)), bullet, XOR
      firex(a) = firex(a) + (5 * firedir(a))
      SELECT CASE firedir(a)
        CASE -1
          FOR c = 1 TO 4
            IF firex(a) >= x(c) AND firex(a) <= x(c) + 17 AND firey(a) >= y(c) AND firey(a) <= y(c) + 11 AND a <> c THEN
              GOSUB HitAnimal
              fire(a) = 0
              EXIT FOR
            END IF
          NEXT c
          IF firex(a) < 0 THEN fire(a) = 0
        CASE 1
          FOR c = 1 TO 4
            IF firex(a) + 6 >= x(c) AND firex(a) + 6 <= x(c) + 17 AND firey(a) >= y(c) AND firey(a) <= y(c) + 11 AND a <> c THEN
              GOSUB HitAnimal
              fire(a) = 0
              EXIT FOR
            END IF
          NEXT c
          IF firex(a) + 6 > 640 THEN fire(a) = 0
      END SELECT
    END IF
    IF fire(a) = 1 THEN PUT (firex(a), firey(a)), bullet, XOR
    IF mine(a) = 1 THEN
      PUT (minex(a), miney(a)), mineimg, XOR
      IF miney(a) < 419 THEN miney(a) = miney(a) + 3
      IF miney(a) > 419 THEN miney(a) = 419
      PUT (minex(a), miney(a)), mineimg, XOR
    END IF
    FOR count = 0 TO delay * .004 * (5 - players)
    NEXT count
  NEXT a
LOOP
END

HitAnimal:
  PLAY "mbc"
  lives(c) = lives(c) - 1
  LOCATE 30, ((c) * 15) + 4
  PRINT lives(c);
  IF lives(c) = 0 THEN
    PUT (x(c), y(c)), sprite(36, c, dir(c)), XOR
    x(c) = 640
    y(c) = 480
  END IF
  RETURN

FlashMine:
  IF minepal = 0 THEN PALETTE 13, 60 + (40 * pal&) + (40 * pal& ^ 2): minepal = 1: RETURN
  IF minepal = 1 THEN PALETTE 13, 60: minepal = 0: RETURN

EndTime:
  Stoptime = 1
  RETURN

CowData:
DATA 0,0,0,0,6,0,6,6,6,6,6,6,6,6,6,6,0
DATA 0,0,0,6,6,6,15,6,6,6,6,6,15,6,6,6,6
DATA 0,0,15,6,6,6,15,15,6,6,6,6,15,6,6,6,6
DATA 15,15,15,0,6,6,15,15,15,6,6,15,15,6,15,6,6
DATA 15,15,15,15,6,6,6,15,15,6,6,15,15,15,15,6,6
DATA 0,0,0,15,15,6,15,15,15,15,6,15,15,15,15,6,6
DATA 0,0,0,8,15,15,15,15,15,15,15,15,15,15,15,15,8
DATA 0,0,0,0,8,15,8,8,8,8,8,8,8,8,15,8,0
DATA 0,0,0,0,0,8,0,0,0,0,0,0,0,0,8,0,0
DATA 0,0,0,0,0,8,0,0,0,0,0,0,0,0,8,0,0
DATA 0,0,0,0,0,8,0,0,0,0,0,0,0,0,8,0,0
SheepData:
DATA 0,0,0,0,0,15,15,15,15,15,15,15,15,15,15,15,0
DATA 0,0,0,0,15,15,15,15,15,15,15,15,15,15,15,15,15
DATA 0,0,0,0,15,15,15,15,15,15,15,15,15,15,15,15,15
DATA 0,0,7,7,15,15,15,15,15,15,15,15,15,15,15,15,15
DATA 0,7,0,7,15,15,15,15,15,15,15,15,15,15,15,15,15
DATA 7,7,7,7,15,15,15,15,15,15,15,15,15,15,15,15,15
DATA 7,7,7,7,15,15,15,15,15,15,15,15,15,15,15,15,15
DATA 0,0,0,0,0,15,15,15,15,15,15,15,15,15,15,15,0
DATA 0,0,0,0,0,0,7,7,0,0,0,0,0,7,7,0,0
DATA 0,0,0,0,0,0,7,7,0,0,0,0,0,7,7,0,0
DATA 0,0,0,0,0,0,7,7,0,0,0,0,0,7,7,0,0
PigData:
DATA 0,0,0,0,0,0,0,12,12,12,12,12,12,12,12,0,0
DATA 0,0,0,0,12,0,12,12,12,12,12,12,12,12,12,12,0
DATA 0,0,0,12,12,12,12,12,12,12,12,12,12,12,12,12,12
DATA 0,0,12,0,12,12,12,12,12,12,12,12,12,12,12,12,12
DATA 12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
DATA 12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
DATA 0,0,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
DATA 0,0,0,0,0,12,12,12,12,12,12,12,12,12,12,12,0
DATA 0,0,0,0,0,0,12,12,12,12,12,12,12,12,12,0,0
DATA 0,0,0,0,0,0,12,12,0,0,0,0,0,12,12,0,0
DATA 0,0,0,0,0,0,12,12,0,0,0,0,0,12,12,0,0
HorseData:
DATA 0,0,0,0,6,6,6,6,0,0,0,0,6,6,6,0,0
DATA 0,0,6,6,6,6,6,6,6,6,6,6,6,6,6,6,0
DATA 0,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
DATA 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
DATA 6,0,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
DATA 6,6,6,0,6,6,6,6,6,6,6,6,6,6,6,6,6
DATA 0,6,6,0,0,6,6,6,0,0,0,0,0,6,6,6,0
DATA 0,6,6,0,0,0,6,0,0,0,0,0,0,0,6,0,0
DATA 0,6,6,0,0,0,6,0,0,0,0,0,0,0,6,0,0
DATA 0,0,0,0,0,0,6,0,0,0,0,0,0,0,6,0,0
DATA 0,0,0,0,0,0,6,0,0,0,0,0,0,0,6,0,0

