'Here's my take on the doom.bas program that was posted here a while ago.
'It's much clearer and more organized and a bit faster as well, I think,
'because a lot of unneccessary math has been eliminated.

DECLARE SUB CreateBackground ()
DECLARE SUB GetKeypress (Keycode%)

CONST UpArrow = -72, DnArrow = -80, LArrow = -75, RArrow = -77

RANDOMIZE TIMER
DIM Grid%(1 TO 12, 1 TO 12)
DIM STable!(0 - 31 TO 360 + 32), CTable!(0 - 31 TO 360 + 32)
PX! = 9: PY! = 11    'the starting coordinates of the player's location
Stride! = 3          'the distance covered in one "step" by the player
                     '   by pressing the up or down arrow keys
Heading% = 0         'the heading of the player (in degrees)
Turn% = 5            'number of degrees of rotation produced by
                     '   pressing the right or left arrow keys

FOR Y% = 1 TO 12
  FOR X% = 1 TO 12
    READ Grid%(X%, Y%)
  NEXT
NEXT

Factor! = (ATN(1) * 8) / 360
FOR A% = 0 TO 359
  Angle! = CSNG(A%) * Factor!
  STable!(A%) = SIN(Angle!) * .1
  CTable!(A%) = COS(Angle!) * .1
NEXT
FOR A% = -31 TO -1
  STable!(A%) = STable!(A% + 360)
  CTable!(A%) = CTable!(A% + 360)
NEXT
FOR A% = 360 TO 360 + 32
  STable!(A%) = STable!(A% - 360)
  CTable!(A%) = CTable!(A% - 360)
NEXT

SCREEN 7, , 0, 0
PRINT

PRINT
PRINT "            RAYCASTER DEMO"
PRINT
PRINT "      UP ARROW........Move Forward"
PRINT "      DOWN ARROW......Move Backward"
PRINT "      RIGHT ARROW.....Turn Right"
PRINT "      LEFT ARROW......Turn Left"
PRINT
PRINT
PRINT "            Please wait...";

CALL CreateBackground
BEEP
PRINT "        Press any key to begin...";
DO WHILE LEN(INKEY$): LOOP: DO UNTIL LEN(INKEY$): LOOP

ViewPg% = 0: WorkPg% = 1: BG1% = 2: BG2% = 3
SCREEN , , WorkPg%, ViewPg%
GOSUB ComputeView

DO 'Main loop
CALL GetKeypress(Keycode%)
SELECT CASE Keycode%
  CASE LArrow
    Heading% = (Heading% + Turn%) MOD 360
    GOSUB ComputeView
  CASE RArrow
    Heading% = (Heading% + (360 - Turn%)) MOD 360
    GOSUB ComputeView
  CASE UpArrow
    NewPX! = PX! - (STable!(Heading%) * Stride!)
    NewPY! = PY! - (CTable!(Heading%) * Stride!)
    IF Grid%(NewPX!, NewPY!) = 0 THEN
      PX! = NewPX!: PY! = NewPY!
      GOSUB ComputeView
    ELSE 'tried to walk through a wall
      SOUND 80, 1
    END IF
  CASE DnArrow
    NewPX! = PX! + (STable!(Heading%) * Stride!)
    NewPY! = PY! + (CTable!(Heading%) * Stride!)
    IF Grid%(NewPX!, NewPY!) = 0 THEN
      PX! = NewPX!: PY! = NewPY!
      GOSUB ComputeView
    ELSE 'tried to walk through a wall
      SOUND 80, 1
    END IF
  CASE 27
    EXIT DO
  CASE ELSE
    BEEP
  END SELECT
LOOP
SCREEN 0: WIDTH 80, 25
END

ComputeView:
PCOPY BG1%, WorkPg%: SWAP BG1%, BG2%
X1% = 0
FOR A% = Heading% + 32 TO Heading% - 31 STEP -1
  StepX! = STable!(A%): StepY! = CTable!(A%)
  XX! = PX!: YY! = PY!
  L% = 0
  DO
    XX! = XX! - StepX!: YY! = YY! - StepY!
    L% = L% + 1
    K% = Grid%(XX!, YY!)
  LOOP UNTIL K%
  DD% = 900 \ L%
  H% = DD% + DD%
  DT% = 100 - DD%
  LINE (X1%, DT%)-STEP(4, H%), K%, BF
  X1% = X1% + 5
NEXT
SWAP WorkPg%, ViewPg%
SCREEN , , WorkPg%, ViewPg%

RETURN

DATA  9,  1,  9,  1,  9,  1,  9,  1,  9,  1,  9,  1
DATA  1,  0,  0,  0,  0,  0,  0,  0,  0,  4,  0,  9
DATA  9,  0,  2, 10,  0,  0,  0,  0,  0, 12,  0,  1
DATA  1,  0, 10,  2,  0,  0,  0,  0,  0,  4,  0,  9
DATA  9,  0,  0,  0,  0,  0,  0,  0,  0, 12,  0,  1
DATA  1,  0,  0,  0,  0,  7,  7,  0,  0,  0,  0,  9
DATA  9,  0,  0,  0,  0,  7,  7,  0,  0,  0,  0,  1
DATA  1,  0, 13,  0,  0,  0,  0,  8,  0, 12,  0,  9
DATA  9,  0,  5,  0,  0,  0,  0,  7,  0,  4,  0,  1
DATA  1,  0, 13,  0,  0,  0,  0,  8,  0, 12,  0,  9
DATA  9,  0,  5,  0,  0,  0,  0,  7,  0,  4,  0,  1
DATA  1,  9,  1,  9,  1,  9,  1,  9,  1,  9,  1,  9

SUB CreateBackground

SCREEN , , 2, 0: CLS
' Sky
LINE (0, 0)-(319, 99), 3, BF
' Clouds
FOR Cnt% = 1 TO 10
  X% = INT(RND * 320)
  Y% = INT(RND * 80) + 10
  R% = INT(RND * 50)
  AR! = RND / 10
  CIRCLE (X%, Y%), R%, 15, , , AR!: PAINT (X%, Y%), 15
NEXT
' Sun
CIRCLE (50, 30), 10, 14: PAINT (50, 30), 14, 14
' Building (gray)
LINE (200, 20)-(220, 15), 8
LINE (220, 15)-(240, 20), 8
LINE (200, 20)-(200, 99), 8
LINE (240, 20)-(240, 99), 8
LINE (200, 99)-(240, 99), 8
PAINT (220, 50), 8
FOR Cnt% = 1 TO 20 ' Lights
  PSET (INT(RND * 38 + 201), INT(RND * 80 + 20)), 14
NEXT
LINE (200, 20)-(220, 15), 0 ' Building (border)
LINE (220, 15)-(240, 20), 0
LINE (219, 15)-(219, 99), 0
LINE (200, 20)-(200, 99), 0
LINE (240, 20)-(240, 99), 0

PCOPY 2, 3
FOR Y% = 100 TO 199
  FOR X% = 0 TO 319
    IF RND AND 1 THEN PSET (X%, Y%), 6
  NEXT
NEXT

SCREEN 7, , 3, 0
FOR Y% = 100 TO 199
  FOR X% = 0 TO 319
    IF RND AND 1 THEN PSET (X%, Y%), 6
  NEXT

NEXT

SCREEN , , 0, 0

END SUB

DEFINT A-Z
SUB GetKeypress (Keycode%) STATIC
DO: Ky$ = INKEY$: LOOP UNTIL LEN(Ky$)
Keycode% = ASC(Ky$): IF Keycode% = 0 THEN Keycode% = -ASC(MID$(Ky$, 2, 1))
END SUB






