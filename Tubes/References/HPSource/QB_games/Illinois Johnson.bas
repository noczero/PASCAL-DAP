' ILLINOIS JOHNSON and The 823rd Crusade
' by Brent P. Newhall (BrentN@juno.com)
' Version 1.0.0

' YES, it's another exciting adventure of the intrepid
' Illinois Johnson (TM).  This time, our hero is
' searching the Caverns of Crok (TM) for the fabled
' Lost Toga of the Ingledorfs (TM).  He'll have to
' dodge falling boulders, operate wooden elevators,
' collect charges for his Neutron Blaster 9000 (TM),
' and use his trusty horse whip!  Can he make it to the
' blue doorway on each level before his air runs out?

' [LEFT] . . Move left
' [RIGHT]  . Move right
' [UP] . . . Jump up in the direction you're facing, or
'            move elevator upwards if on one, or move
'            up whip line
' [DOWN] . . Move elevator downwards if on one, or move
'            down whip line
' [CTRL] . . (Yes, the CTRL key works!) Fire Illinois
'            Johnson's (TM) Neutron Blaster 9000 (TM);
'            must have at least one charge
' [ALT]  . . Throw whip upwards to latch onto special
'            boulders
' [ESC]  . . Quit

' You:     Wall: Û    Boulder: ì    Air sucker: 
' End-of-level doorway:     Special whip boulder: ø
' Neutron Blaster 9000 (TM) charge:     Elevator: Ñ

' Notes:
'   Aquarius (aquarius@cryogen.com) wrote the
' inspiration for this program, so thanks are due to
' hir (gender-neutral pronoun).
'   There's only two levels, just to give you an idea
' of the controls et al.  Any takers on new levels?
' Just add more DATA statements at the end of the
' program (each level is 40x24) and change the end of
' the main program loop (IF level = 2 THEN ReallyQuit).
'   There's a fake wall if you look closely....
'   In the level statements, upper case indicates a
' solid (wall, elevator); lower case a non-solid (air,
' energy charge, doorway).
'   "Falling into each level" was an accident, but I
' think it kinda adds a neat intro to the level....
'   The whole game is pretty simple; in fact there are
' no bugs that I know of.  The engine is fairly
' straightforward, so you should be able to skim
' through the code with little difficulty.  It runs
' perfectly well in QBASIC 1.x and VBDOS.  Have fun!
'   As always, suggestions, comments, criticisms,
' additions, improvements, etc. are welcome.

DEFINT A-Z ' All numeric variables are integers by default
DECLARE SUB LoadNextLevel ()
DECLARE SUB MoveBoulders (xpos, ypos)
DECLARE SUB PrintChar (arg)
                
CONST FALSE = 0, TRUE = NOT FALSE
CONST LEFT = -1, RIGHT = 1 ' For player's direction
CONST AIR.SUCKER = -6
CONST WHIP.LINE = -5, WALL.FAKE = -4 ' Walls and stuff
CONST ENERGY.CHARGE = -3, DOORWAY = -2
CONST BOULDER = 1, WALL = 2, ELEVATOR = 3, ELEV.COLUMN = 4
CONST WALL.GRAY = 5, STALACTITE = 6

SCREEN 7 ' Text display at 40x25 with 16 colors
DIM SHARED x, y, AIR
DIM SHARED grid(1 TO 40, 1 TO 24)
DIM direction$(LEFT TO RIGHT)
direction$(LEFT) = CHR$(27) ' Arrows for displaying direction
direction$(RIGHT) = CHR$(26)
direction = RIGHT
level = 0
DO
  quit = 0
  LoadNextLevel
  GOSUB PrintLevel
  ox = x: oy = y
  ENERGY = 0 ' No spare charges
  whipactive = FALSE ' Not currently using whip
  Display = TRUE: GetInput = TRUE
  level = level + 1
  DO
    GOSUB ProcessInput
    GOSUB DoAir
    GOSUB PrintAll
    i$ = INKEY$ ' Mask out INKEY$
    t! = TIMER: WHILE t! = TIMER: WEND ' Delay
    i$ = INKEY$ ' Mask out INKEY$
  LOOP UNTIL quit > 0
  IF quit <> 3 THEN ReallyQuit = quit ' Not finished level
  IF level = 2 THEN ReallyQuit = 3 ' Last level!
LOOP UNTIL ReallyQuit > 0
END

PrintAll:
IF Display THEN
  Display = FALSE
  LOCATE oy, ox: PrintChar grid(ox, oy) ' Display player's old posit.
  LOCATE y, x: COLOR 15: PRINT CHR$(1); ' Display player
  oy = y: ox = x
  LOCATE 25, 5: PRINT direction$(direction);
  LOCATE 25, 10: PRINT "Air:"; AIR;
  LOCATE 25, 20: PRINT "Energy:"; ENERGY;
  LOCATE 25, 32: PRINT "Level"; level;
  GOSUB CheckPhysics
END IF
RETURN

ProcessInput:
IF GetInput THEN
  kp% = INP(&H60) ' Get keypress in kp%
  IF kp% < 100 THEN ' &H60 is > 100 if no keypresses
    IF kp% = 77 THEN ' [RIGHT]
      direction = RIGHT
      GOSUB MoveLeftOrRight
    ELSEIF kp% = 75 THEN ' [LEFT]
      direction = LEFT
      GOSUB MoveLeftOrRight
    ELSEIF kp% = 72 THEN ' [UP]
      GOSUB InputUp
    ELSEIF kp% = 80 THEN ' [DOWN]
      IF grid(x, y + 2) = ELEV.COLUMN THEN ' We're extended
        Display = TRUE
        y = y + 1
        grid(x, y) = -1
        grid(x, y + 1) = ELEVATOR ' Move elevator down
        LOCATE y + 1, x: PrintChar ELEVATOR ' Display
      ELSEIF grid(x, y - 1) = WHIP.LINE THEN ' On whip
        IF grid(x, y + 1) < 1 THEN ' Have space below us
          Display = TRUE
          grid(x, y) = WHIP.LINE
          y = y + 1
        END IF
      END IF
    ELSEIF kp% = 29 THEN ' [CTRL]
      IF ENERGY > 0 THEN
        IF direction = LEFT THEN
          changex = -1
        ELSE ' direction = RIGHT
          changex = 1
        END IF
        IF grid(x + changex, y) > 0 THEN ' Something to zap?
          FOR cnt = 1 TO 5
            IF RND > .75 THEN
              COLOR 4 ' Red 25% of the time
            ELSEIF RND > .75 THEN
              COLOR 14 ' Yellow 25% of the time
            ELSEIF RND > .75 THEN
              COLOR 12 ' Bright red 25% of the time
            ELSE
              COLOR 8 ' Gray rest of the time
            END IF
            LOCATE y, x + changex: PRINT CHR$(15); ' Display star
            t! = TIMER: WHILE t! = TIMER: WEND ' Delay
          NEXT cnt
          grid(x + changex, y) = -1 ' Zap!
          LOCATE y, x + changex: PrintChar -1 ' Display
          IF grid(x + changex, y - 1) = BOULDER THEN ' Boulder?
            MoveBoulders x + changex, y - 1
          END IF
          ENERGY = ENERGY - 1
          Display = TRUE
        END IF
      END IF ' energy > 0
    ELSEIF kp% = 56 THEN ' [ALT]
      GOSUB InputWhip
    ELSEIF kp% = 1 THEN ' [ESC]
      quit = 1
    END IF
  END IF
END IF
RETURN

MoveLeftOrRight:
IF grid(x + direction, y) < 1 THEN ' Not walking into wall
  Display = TRUE
  IF grid(x, y) <> WALL.FAKE THEN
    IF grid(x, y) <> AIR.SUCKER THEN
      grid(x, y) = -1
    END IF
  END IF
  IF whipactive THEN
    whipactive = FALSE
    xpos = x: ypos = y - 1
    done = FALSE
    DO
      IF grid(xpos, ypos) = WHIP.LINE THEN
        grid(xpos, ypos) = -1 ' Erase whip line
        LOCATE ypos, xpos: PrintChar -1
        ypos = ypos - 1 ' Move up further
      ELSE
        done = TRUE
      END IF
    LOOP UNTIL done
  END IF
  x = x + direction
  IF grid(x, y) = ENERGY.CHARGE THEN
    ENERGY = ENERGY + 1
  ELSEIF grid(x, y) = DOORWAY THEN
    quit = 3
  END IF
END IF
RETURN

InputUp:
IF grid(x, y + 1) = ELEVATOR THEN ' On elevator
  IF grid(x, y - 1) < 1 THEN ' Air above you
    Display = TRUE
    y = y - 1
    grid(x, y + 1) = ELEVATOR ' Move elevator up
    grid(x, y + 2) = ELEV.COLUMN ' Add column
    LOCATE y + 1, x: PrintChar ELEVATOR
    LOCATE y + 2, x: PrintChar ELEV.COLUMN
  END IF
ELSEIF grid(x, y - 1) = WHIP.LINE THEN
  Display = TRUE
  grid(x, y - 1) = -1 ' Remove whip
  y = y - 1 ' Move up
ELSE ' Jump
  IF direction = RIGHT THEN
    IF grid(x + 1, y) > 0 THEN ' Air at target position
      IF grid(x + 1, y - 1) < 1 THEN ' Something to land on
        Display = TRUE
        x = x + 1
        y = y - 1
      END IF
    END IF
  ELSE ' direction = LEFT
    IF grid(x - 1, y) > 0 THEN ' Air at target position
      IF grid(x - 1, y - 1) < 1 THEN ' Something to land on
        Display = TRUE
        x = x - 1
        y = y - 1
      END IF
    END IF
  END IF
END IF ' Elevator/Jump
RETURN

InputWhip:
IF NOT whipactive THEN
  xpos = x: ypos = y - 1
  done = FALSE
  DO
    IF grid(xpos, ypos) = STALACTITE THEN
      whipactive = TRUE: done = TRUE
      FOR cnt = y - 1 TO ypos + 1 STEP -1
        grid(xpos, cnt) = WHIP.LINE
        LOCATE cnt, xpos: PrintChar WHIP.LINE
        t! = TIMER: WHILE t! = TIMER: WEND ' Delay
      NEXT cnt
    ELSEIF grid(xpos, ypos) > 0 THEN
      done = TRUE
    ELSE
      ypos = ypos - 1
    END IF
  LOOP UNTIL done
END IF
RETURN

DoAir:
IF t$ <> TIME$ THEN ' A new second!
  t$ = TIME$
  IF SuckingAir THEN
    AIR = AIR - 5
  ELSE
    AIR = AIR - 1
  END IF
  IF AIR < 1 THEN quit = 2 ' Out of air!
  Display = TRUE
END IF
RETURN

CheckPhysics: ' Handle physics after new display (i.e. falling)
GetInput = TRUE ' To handle all ELSEs
IF grid(x, y + 1) < 1 THEN ' Let him fall!
  IF grid(x, y - 1) <> WHIP.LINE THEN ' Not on whip
    Display = TRUE
    y = y + 1
    IF grid(x, y) = ENERGY.CHARGE THEN
      ENERGY = ENERGY + 1
    ELSEIF grid(x, y) = DOORWAY THEN
      quit = 3
    END IF
  END IF
END IF
IF grid(x - 1, y - 1) = BOULDER THEN ' Boulder near...
  IF grid(x - 1, y) < 0 THEN ' Nothing beneath it
    Display = TRUE
    GetInput = FALSE
    MoveBoulders x - 1, y - 1
  END IF
END IF
IF grid(x + 1, y - 1) = BOULDER THEN ' Boulder near...
  IF grid(x + 1, y) < 0 THEN ' Nothing beneath it
    Display = TRUE
    GetInput = FALSE
    MoveBoulders x + 1, y - 1
  END IF
END IF
IF grid(x, y) = AIR.SUCKER THEN
  SuckingAir = TRUE
ELSE
  SuckingAir = FALSE
END IF
RETURN

PrintLevel: ' Straightforward
CLS ' Extra line for status at top
FOR row = 1 TO 24
  FOR col = 1 TO 40
    PrintChar grid(col, row)
  NEXT col
NEXT row
RETURN

DATA 3, 3, 60: REM x, y starting coordinates, air
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBaaaaAaaaaaaaaaaaaaaaaaaaFFFFFaBaaaaaBB"
DATA "BBaaaaAaaaaaaaaaaaaaaaaaaaaaaaaaBaaaaaBB"
DATA "BBaaaaAaaaaaaaaaaaaaaaaaaaaaaaaaBaaaaaBB"
DATA "BBaaaaAaaaaaaaaaaaaaaaBBBBaaaaaaBaaaaaBB"
DATA "BBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaBaacaaBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBaaaBBBBBBBBBBBBBBB"
DATA "BBaaaaaaaaaaaaaaaAaaaaaaBBaaaaaaaaaaaaBB"
DATA "BBaaaaaaaaaaaaaaaaaaaaaBBBaaaaaaaaaaaaBB"
DATA "BBaaBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBaaaaaaaaaaaaaaaaaaaaaBBaaaaaaaaaaaaaBB"
DATA "BBaaaaaaaaaaaaaaaaaaadaeeaadaadadaadaaBB"
DATA "BBCCBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEBB"
DATA "BBEEBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBEEBB"
DATA "BBEEBBEEBBBEEBBBEEEBBEBBBEBBEEEEEBBBEEBB"
DATA "BBEEBBEBEBBEBEBBEBBBBEEBBEBBBBEBBBBBEEBB"
DATA "BBEEBBEEBBBEEBBBEEBBBEBEBEBBBBEBBBBBEEBB"
DATA "BBEEBBEBEBBEBEBBEBBBBEBBEEBBBBEBBBBBEEBB"
DATA "BBEEBBEEBBBEBEBBEEEBBEBBBEBBBBEBBBBBEEBB"
DATA "BBEEBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBEEBB"
DATA "BBEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"

DATA 7, 3, 60: REM x, y starting coordinates, air
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBaaaaaaFFFFFFFFaaaaaaaaaaaaBBBBBBBBBBBB"
DATA "BBaaaaaaaaaaaaaaaaaaaaaaaaaaBBBBBBBBBBBB"
DATA "BBaaaaaaaaaaaaaaaaaaaaaaaaaaBBBBBBBBBBBB"
DATA "BBaaaaaaaaaaaaaaaaaaaaaaaaaaBBBBBBBBBBBB"
DATA "BBaaaaaaaaaaaaaaaaaaaaaaaaaaBBBBBBBBBBBB"
DATA "BBBBBBaaaaaaaaaaaaAaaaaaaaaaBBBBBBBBBBBB"
DATA "BBaaaBaaaaaaaaaaaaAaaaaaaaaaBBBBBBBBBBBB"
DATA "BBacaBaaaaaaaaaaaaaaaaaaaaaaBBBBBBBBBBBB"
DATA "BBBBBBBBBggggggBBBBBBBEaaaEBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBEaaaEBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBEaaaEBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBEaaaEBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBEaddEBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBCBBBBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
DATA "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"

SUB LoadNextLevel

READ x, y, AIR
FOR lin = 1 TO 24
  READ a$
  FOR letter = 1 TO 40
    ascii% = ASC(MID$(a$, letter, 1)) ' Conversion:
    IF ascii% >= 97 THEN ' Lower case
      grid(letter, lin) = -(ascii - 97) ' Convert to negative
    ELSEIF ascii% >= 65 THEN ' Upper case
      grid(letter, lin) = ascii - 64 ' Convert to positive
    END IF
  NEXT letter
NEXT lin

END SUB

SUB MoveBoulders (xpos, ypos)

' This routine moves the current boulder, and calls itself for
' the one above, if necessary.

grid(xpos, ypos + 1) = BOULDER
grid(xpos, ypos) = -1
LOCATE ypos + 1, xpos: PrintChar BOULDER ' Display new boulder
LOCATE ypos, xpos: PrintChar -1
IF grid(xpos, ypos - 1) = BOULDER THEN
  MoveBoulders xpos, ypos - 1 ' Recursion
END IF

END SUB

SUB PrintChar (arg)

SELECT CASE arg
  CASE AIR.SUCKER: COLOR 1: PRINT CHR$(19);
  CASE WHIP.LINE: COLOR 6: PRINT CHR$(179);
  CASE ENERGY.CHARGE: COLOR 14: PRINT CHR$(15);
  CASE DOORWAY: COLOR 9: PRINT CHR$(21);
  CASE -1: PRINT " ";
  CASE 0: PRINT " ";
  CASE BOULDER: COLOR 15: PRINT CHR$(236);
  CASE WALL.FAKE: COLOR 7: PRINT CHR$(219);
  CASE WALL: COLOR 7: PRINT CHR$(219);
  CASE WALL.GRAY: COLOR 8: PRINT CHR$(219);
  CASE ELEVATOR: COLOR 6: PRINT CHR$(209);
  CASE ELEV.COLUMN: COLOR 6: PRINT CHR$(179);
  CASE STALACTITE: COLOR 7: PRINT CHR$(248);
  CASE ELSE: PRINT " ";
END SELECT

END SUB

