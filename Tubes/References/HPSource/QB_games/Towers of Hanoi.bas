DECLARE FUNCTION MouseInit% ()
DECLARE FUNCTION TopAryNum% (n%)
DECLARE FUNCTION TopTower% (n%)
DECLARE SUB Backup ()
DECLARE SUB DrawTowers ()
DECLARE SUB Expand (x1%, y1%, x2%, y2%, tx%, ty%, sc%, cs%, clr%)
DECLARE SUB GetMouseOver (x%, ch%)
DECLARE SUB Grey ()
DECLARE SUB Help ()
DECLARE SUB MouseDriver (ax%, bx%, cx%, dx%)
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE SUB MouseStatus (lb%, rb%, xMouse%, yMouse%)
DECLARE SUB Move (one%, two%, ok%)
DECLARE SUB SelectHeight ()
DECLARE SUB SetupPuzzle ()
DECLARE SUB TitleScreen ()
DECLARE SUB TwoTone (x1%, y1%, x2%, y2%, colour1%, colour2%)
DECLARE SUB WaitLetGo ()
COMMON SHARED T#, dt$, moves&, height%, bkdn%

SCREEN 9
'Initialization for mouse
DIM SHARED Mouse$
Mouse$ = SPACE$(57)
FOR i% = 1 TO 57
  READ a$
  h$ = CHR$(VAL("&H" + a$))
  MID$(Mouse$, i%, 1) = h$
NEXT i%
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00
ms% = MouseInit%
IF NOT ms% THEN
  PRINT "Mouse not found"
  SYSTEM
END IF
                                      
REDIM SHARED Towers%(1 TO 3, 1 TO 30)
REDIM SHARED BackupAry%(1000, 2)

MouseShow

DO
  REDIM Towers%(1 TO 3, 1 TO 30)
  REDIM BackupAry%(1000, 2)
  moves& = 0
  height% = 0
  win% = 0
  TitleScreen
  DrawTowers
  SelectHeight
  SetupPuzzle
  DrawTowers
  DO
    a$ = INKEY$
    MouseStatus lb%, rb%, x%, y%
    IF lb% OR rb% THEN
      IF y% > 90 THEN
        GetMouseOver x%, ch%
        IF TopTower%(ch%) <> -1 THEN
          MouseHide
          ttype% = TopTower%(ch%)
          tary% = TopAryNum%(ch%)
          Towers%(ch%, tary%) = 0
          DrawTowers
          Towers%(ch%, tary%) = ttype%
          PCOPY 0, 1
          MouseShow
          lch% = 0
          DO
            MouseStatus lb%, rb%, x%, y%
            GetMouseOver x%, tch%
            IF tch% <> lch% THEN
              MouseHide
              PCOPY 1, 0
              z% = TopTower%(ch%)
              x1% = (95 + ((450 / 2) * (tch% - 1)) - (z% * 10))
              y1% = 80
              x2% = (95 + ((450 / 2) * (tch% - 1)) + (z% * 10))
              y2% = 95
              LINE (x1%, y1%)-(x2%, y2%), z%, BF
              x1% = (95 + ((450 / 2) * (tch% - 1)) + (z% * 5))
              x2% = (95 + ((450 / 2) * (tch% - 1)) + (z% * 10))
              TwoTone x1%, y1%, x2%, y2%, z%, 0
              x1% = (95 + ((450 / 2) * (tch% - 1)) - (z% * 10))
              x2% = (95 + ((450 / 2) * (tch% - 1)) - (z% * 5))
              TwoTone x1%, y1%, x2%, y2%, z% + 8, z%
              MouseShow
            END IF
            lch% = tch%
          LOOP WHILE lb% OR rb%
          IF ch% <> tch% THEN
            Move ch%, tch%, ok%
            IF ok% = 1 THEN moves& = moves& + 1
            IF ok% = 0 THEN SOUND 500, .1
            DrawTowers
            IF TopTower%(1) = -1 AND TopTower%(2) = -1 THEN win% = 1: EXIT DO
          ELSE
            DrawTowers
          END IF
        ELSE
          SOUND 500, .1
          WaitLetGo
        END IF
      ELSE
        IF y% > 14 AND y% < 28 THEN
          IF x% > 576 AND x% < 639 THEN
            Backup
            WaitLetGo
          END IF
        ELSEIF y% > 28 AND y% < 42 THEN
          IF x% > 576 AND x% < 639 THEN
            REDIM BackupAry%(1000, 2)
            REDIM Towers%(1 TO 3, 1 TO 30)
            SetupPuzzle
            moves& = 0
            WaitLetGo
            DrawTowers
          END IF
        ELSEIF y% > 42 AND y% < 56 THEN
          IF x% > 576 AND x% < 639 THEN
            EXIT DO
          END IF
        ELSEIF y% > 56 AND y% < 70 THEN
          IF x% > 576 AND x% < 639 THEN
            MouseHide
            SYSTEM
          END IF
        END IF
      END IF
    END IF
    IF a$ = CHR$(8) THEN Backup
    IF a$ = CHR$(0) + ";" THEN Help
  LOOP UNTIL a$ = CHR$(27)
  IF a$ = CHR$(27) THEN MouseHide: SYSTEM
  IF win% = 1 THEN
    Grey
    min% = (2 ^ height%) - 1
    txt$ = "Solved. Moves: " + LTRIM$(STR$(moves&)) + ". Minimum possible: " + LTRIM$(STR$(min%)) + "."
    SCREEN 9, , 1, 0
    LOCATE 1, 1: PRINT "Solved"
    Expand 0, 0, 47, 13, 15, 20, 13, 11, 13
    txt$ = "Moves: " + LTRIM$(STR$(moves&))
    LOCATE 1, 1: PRINT txt$;
    Expand 0, 0, ((LEN(txt$) * 8) - 1), 13, 20, 195, 3, 3, 14
    txt$ = "Minimum possible: " + LTRIM$(STR$(min%))
    LOCATE 1, 1: PRINT txt$;
    Expand 0, 0, ((LEN(txt$) * 8) - 1), 13, 20, 230, 3, 3, 14
    SCREEN 9, , 0, 0
    DO
      a$ = INKEY$
      MouseStatus lb%, rb%, x%, y%
      IF a$ = CHR$(27) THEN MouseHide: SYSTEM
      IF a$ = CHR$(0) + ";" THEN Help
    LOOP UNTIL lb% OR rb% OR a$ <> ""
    WaitLetGo
  END IF
LOOP

SYSTEM

SUB Backup
tmp% = bkdn% - 1
IF tmp% < 0 THEN tmp% = 1000
IF BackupAry%(tmp%, 0) <> 0 THEN
  BackupAry%(tmp%, 0) = 0
  Move BackupAry%(tmp%, 2), BackupAry%(tmp%, 1), ok%
  moves& = moves& - 1
  DrawTowers
  bkdn% = tmp%
END IF
END SUB

SUB DrawTowers
MouseHide
SCREEN 9, , 1, 0
CLS
LOCATE 2, 6: PRINT "Tower of Hanoi"
IF height% <> 0 THEN
  LOCATE 2, 73: PRINT "Backup"
  LOCATE 3, 73: PRINT "Restart"
  LOCATE 4, 73: PRINT "Give up"
  LOCATE 5, 73: PRINT "Exit"
  LINE (575, 13)-(633, 27), 9, B
  LINE (575, 27)-(633, 41), 9, B
  LINE (575, 41)-(633, 55), 9, B
  LINE (575, 55)-(633, 69), 9, B
END IF
TwoTone 19, 301, 619, 307, 6, 14
FOR i% = 1 TO 3
  LINE (90 + ((450 / 2) * (i% - 1)), 100)-(100 + ((450 / 2) * (i% - 1)), 300), 7, BF
  TwoTone (94 + ((450 / 2) * (i% - 1))), 100, (100 + ((450 / 2) * (i% - 1))), 300, 7, 8
  LINE (97 + ((450 / 2) * (i% - 1)), 100)-(100 + ((450 / 2) * (i% - 1)), 300), 8, BF
  LINE (90 + ((450 / 2) * (i% - 1)), 100)-(90 + ((450 / 2) * (i% - 1)), 300), 15
  FOR z% = 1 TO 20
    IF Towers%(i%, z%) <> 0 THEN
      x1% = (95 + ((450 / 2) * (i% - 1)) - (Towers%(i%, z%) * 10))
      y1% = 301 - (z% * 15)
      x2% = (95 + ((450 / 2) * (i% - 1)) + (Towers%(i%, z%) * 10))
      y2% = 300 - ((z% - 1) * 15)
      LINE (x1%, y1%)-(x2%, y2%), Towers%(i%, z%), BF
      x1% = (95 + ((450 / 2) * (i% - 1)) + (Towers%(i%, z%) * 5))
      x2% = (95 + ((450 / 2) * (i% - 1)) + (Towers%(i%, z%) * 10))
      TwoTone x1%, y1%, x2%, y2%, Towers%(i%, z%), 0
      x1% = (95 + ((450 / 2) * (i% - 1)) - (Towers%(i%, z%) * 10))
      x2% = (95 + ((450 / 2) * (i% - 1)) - (Towers%(i%, z%) * 5))
      TwoTone x1%, y1%, x2%, y2%, Towers%(i%, z%) + 8, Towers%(i%, z%)
    END IF
  NEXT z%
NEXT i%
LOCATE 23, 6: PRINT "Moves:"; moves&;
FOR i% = 1 TO height%
  LINE (20 - (i% * 2), (i% * 2) + 10)-(20 + (i% * 2), (i% * 2) + 12), i%, BF
NEXT i%
PCOPY 1, 0
SCREEN 9, , 0, 0
MouseShow
END SUB

SUB Expand (x1%, y1%, x2%, y2%, tx%, ty%, sc%, cs%, clr%)
MouseHide
REDIM Store%(x2% - x1%, y2% - y1%)
FOR x% = x1% TO x2%
  FOR y% = y1% TO y2%
    Store%(x%, y%) = POINT(x%, y%)
  NEXT y%
NEXT x%
SCREEN 9, , 0, 0
FOR x% = x1% TO x2%
  FOR y% = y1% TO y2%
    'FOR i% = 0 TO cs%
    '  IF Store%(x%, y%) <> 0 THEN CIRCLE (((x% * sc%) + (sc% / 2)) + tx%, ((y% * sc%) + (sc% / 2)) + ty%), i%, clr%
    'NEXT i%
    IF Store%(x%, y%) <> 0 THEN
      x1l% = (((x% * sc%) + (sc% / 2)) + tx%) - (cs% / 2)
      y1l% = (((y% * sc%) + (sc% / 2)) + ty%) - (cs% / 2)
      x2l% = (((x% * sc%) + (sc% / 2)) + tx%) + (cs% / 2)
      y2l% = (((y% * sc%) + (sc% / 2)) + ty%) + (cs% / 2)
      LINE (x1l%, y1l%)-(x2l%, y2l%), clr%, BF
    END IF
  NEXT y%
NEXT x%
SCREEN 9, , 1, 0
ERASE Store%
MouseShow
END SUB

SUB GetMouseOver (x%, ch%)
ch% = 3
IF x% < 213 THEN
  ch% = 1
ELSEIF x% < 426 THEN
  ch% = 2
END IF
END SUB

SUB Grey
MouseHide
SCREEN 9, , 1, 0
PCOPY 0, 1
FOR B% = 0 TO 640 STEP 2
  LINE (B%, 0)-(B%, 350), 0, , &H5555
NEXT
FOR B% = 0 TO 640 STEP 2
  LINE (B%, 0)-(B%, 350), 0, , &HAAAA
NEXT
SCREEN 9, , 0, 0
PCOPY 1, 0
MouseShow
END SUB

SUB Help
WaitLetGo
MouseHide
PCOPY 0, 1
CLS
LOCATE 5
PRINT "Tower of Hanoi - Help"
PRINT
PRINT "There are three spikes, the leftmost of which has a number of rings placed on"
PRINT "top of it. The aim of the game is to arrange these rings from smallest to"
PRINT "largest on the rightmost spike. However; you can only move a ring onto an"
PRINT "empty spike or one with a larger ring on the top of the pile. To move a ring"
PRINT "onto another spike, simply drag it using the mouse. If you make a mistake and"
PRINT "need to go back a move, click the 'backup' button or press <BKSP> on the"
PRINT "keyboard. If you have made a total mess and want to start again, click"
PRINT "'restart'. If you want to go back to the title screen, click 'give up'. This"
PRINT "will abandon your current game. Clicking the 'exit' button or pressing <ESC>"
PRINT "exits the program. The program will detect when you have finished and will"
PRINT "tell you how you did. You can bring up this help at any time by pressing <F1>."
PRINT
PRINT "Click mouse to exit help..."
MouseShow
DO
  a$ = INKEY$
  MouseStatus lb%, rb%, x%, y%
  IF a$ = CHR$(27) THEN MouseHide: SYSTEM
LOOP UNTIL lb% OR rb% OR a$ <> ""
WaitLetGo
MouseHide
PCOPY 1, 0
MouseShow
END SUB

SUB MouseDriver (ax%, bx%, cx%, dx%)
  DEF SEG = VARSEG(Mouse$)
  Mouse% = SADD(Mouse$)
  CALL Absolute(ax%, bx%, cx%, dx%, Mouse%)
END SUB

SUB MouseHide
 ax% = 2
 MouseDriver ax%, 0, 0, 0
END SUB

FUNCTION MouseInit%
  ax% = 0
  MouseDriver ax%, 0, 0, 0
  MouseInit% = ax%
END FUNCTION

SUB MouseShow
  ax% = 1
  MouseDriver ax%, 0, 0, 0
END SUB

SUB MouseStatus (lb%, rb%, xMouse%, yMouse%)
  ax% = 3
  MouseDriver ax%, bx%, cx%, dx%
  lb% = ((bx% AND 1) <> 0)
  rb% = ((bx% AND 2) <> 0)
  'If screen mode is 7 then divide cx% by 2
  'IF cx% <> 0 THEN cx% = cx% / 2
  'If screen mode is 0 then divide cx% and dx% by 8
  'cx% = cx% / 2
  xMouse% = cx%
  yMouse% = dx%
END SUB

SUB Move (one%, two%, ok%)
ok% = 1
ttype% = TopTower%(one%)
tary% = TopAryNum%(one%)
IF ttype% < TopTower%(two%) OR TopTower%(two%) = -1 THEN
  Towers%(one%, tary%) = 0
  Towers%(two%, (TopAryNum%(two%) + 1)) = ttype%
  BackupAry%(bkdn%, 0) = 1
  BackupAry%(bkdn%, 1) = one%
  BackupAry%(bkdn%, 2) = two%
  bkdn% = bkdn% + 1
  IF bkdn% > 1000 THEN bkdn% = 0
ELSE
  ok% = 0
END IF
END SUB

SUB SelectHeight
MouseHide
LOCATE 4, 6: PRINT "Select height:  1  2  3  4  5  6  7  8  9 10";
s% = 240 / 10
FOR x% = 160 TO 400 - s% STEP s%
  LINE (x%, 41)-(x% + s%, 56), 9, B
NEXT x%
MouseShow
DO
  a$ = INKEY$
  MouseStatus lb%, rb%, x%, y%
  IF lb% OR rb% THEN
    IF y% > 42 AND y% < 56 THEN
      IF x% > 160 AND x% < 400 THEN
        cx% = ((x% - 160) \ (8 * 3)) + 1
        WaitLetGo
        MouseStatus lb%, rb%, x%, y%
        lcx% = ((x% - 160) \ (8 * 3)) + 1
        IF cx% = lcx% THEN
          height% = cx%
          EXIT DO
        END IF
      END IF
    END IF
  END IF
  IF a$ = CHR$(27) THEN SYSTEM
  IF a$ = CHR$(0) + ";" THEN Help
LOOP
END SUB

SUB SetupPuzzle
n% = height%
FOR i% = 1 TO n%
  Towers%(1, i%) = n%
  n% = n% - 1
NEXT i%
END SUB

SUB TitleScreen
MouseHide
CLS
SCREEN 9, , 1, 0
CLS
FOR i% = 1 TO 9
  TwoTone (500 - (i% * 90)), ((i% * 70) - 80), (500 + (i% * 90)), ((i% * 70) - 10), i%, 0
NEXT i%
PCOPY 1, 0
LOCATE 1, 1: PRINT "Tower"
Expand 0, 0, 40, 13, 20, 20, 12, 10, 7
LOCATE 1, 1: PRINT "of"
Expand 0, 0, 15, 13, 100, 145, 7, 5, 13
LOCATE 1, 1: PRINT "Hanoi"
Expand 0, 0, 40, 13, 220, 155, 10, 8, 14
LOCATE 1, 1: PRINT "Start"
Expand 0, 0, 40, 13, 20, 255, 2, 2, 15
LOCATE 1, 1: PRINT "Help"
Expand 0, 0, 31, 13, 20, 285, 2, 2, 15
LOCATE 1, 1: PRINT "Exit"
Expand 0, 0, 31, 13, 20, 315, 2, 2, 15
SCREEN 9, , 0, 0
LINE (15, 255)-(105, 283), 9, B
LINE (15, 283)-(105, 315), 9, B
LINE (15, 315)-(105, 344), 9, B
MouseShow
DO
  a$ = INKEY$
  MouseStatus lb%, rb%, x%, y%
  IF a$ = CHR$(27) THEN MouseHide: SYSTEM
  IF a$ = CHR$(0) + ";" THEN Help
  IF lb% OR rb% THEN
    IF x% > 15 AND x% < 105 THEN
      IF y% > 255 AND y% < 283 THEN   'Start button clicked
        EXIT DO
      END IF
    END IF
    IF x% > 15 AND x% < 105 THEN
      IF y% > 283 AND y% < 315 THEN   'Help button clicked
        Help
      END IF
    END IF
    IF x% > 15 AND x% < 105 THEN
      IF y% > 315 AND y% < 344 THEN   'Exit button clicked
        MouseHide
        SYSTEM
      END IF
    END IF
  END IF
LOOP
END SUB

FUNCTION TopAryNum% (n%)
FOR i% = 20 TO 1 STEP -1
  IF Towers%(n%, i%) <> 0 THEN TopAryNum% = i%: EXIT FUNCTION
NEXT i%
TopAryNum% = 0
END FUNCTION

FUNCTION TopTower% (n%)
FOR i% = 20 TO 1 STEP -1
  IF Towers%(n%, i%) <> 0 THEN TopTower% = Towers%(n%, i%): EXIT FUNCTION
NEXT i%
TopTower% = -1
END FUNCTION

SUB TwoTone (x1%, y1%, x2%, y2%, colour1%, colour2%)
LINE (x1%, y1%)-(x2%, y2%), colour1%, BF
FOR B% = x1% TO x2% STEP 2
  LINE (B%, y1%)-(B%, y2%), colour2%, , &H5555
NEXT
FOR B% = x1% + 1 TO x2% STEP 2
  LINE (B%, y1%)-(B%, y2%), colour2%, , &HAAAA
NEXT
END SUB

SUB WaitLetGo
DO
  MouseStatus lb%, rb%, x%, y%
LOOP WHILE lb% OR rb%
END SUB

