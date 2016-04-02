' Puzzler!
' A jigsaw puzzle game by Brent P. Newhall (BrentN@juno.com)
' Version 1.0.0
' This program is PUBLIC DOMAIN.  Copy it, add to it, give it away, distribute
'   it however you like, just keep my credit and any others' credit in here.

' The purpose of this game is to have a simple jigsaw puzzle-like game that
'   can be played easily.  Extra puzzles can be added in the DrawPuzzle()
'   subroutine; just make sure to add them to the main menu and change
'   NUM.PUZZLES (everything else should adjust...).

DEFINT A-Z
DECLARE SUB DrawPuzzle (puzzlenum AS INTEGER)
DIM puzzle(210, 25), correct(210, 25)
CONST NUM.PUZZLES = 8

total = 625 ' Total number of elements per puzzle
quit = 0
DO
  GOSUB MainMenu
  GOSUB DoPuzzle
LOOP UNTIL quit > 0
END

MainMenu:
DO
  SCREEN 13: CLS ' 320x200x256
  PRINT : PRINT
  PRINT TAB(16); "Puzzler!"
  LINE (110, 5)-(190, 34), 15, B ' Box around title
  LOCATE 7, 1
  PRINT "A --- Glass of Root Beer"
  PRINT "B --- Geometric Shapes"
  PRINT "C --- Roundabouts"
  PRINT "D --- Squares!!!"
  PRINT "E --- Blocks"
  PRINT "F --- Train Track"
  PRINT "G --- Chinese Junk"
  PRINT "H --- Numeral Two"
  PRINT "F1 -- Help"
  PRINT "F2 -- Quit"
  PRINT : PRINT : PRINT "Which puzzle do you want"
  PRINT "(hit [A] to [H])?";
  DO
    DO: i$ = UCASE$(INKEY$): LOOP UNTIL i$ <> ""
  LOOP UNTIL (ASC(i$) > 64 AND ASC(i$) < 65 + NUM.PUZZLES) OR i$ = CHR$(0) + ";" OR i$ = CHR$(0) + "<"
  IF i$ = CHR$(0) + ";" THEN ' [F1]
    SCREEN 0: WIDTH 80 ' Normal text screen
    PRINT "     Welcome to Puzzler!  In this game, you can choose any one of many fun"
    PRINT "puzzles to unscramble!  First, you must choose the puzzle from the main menu."
    PRINT "You will then be shown the completed puzzle (like the picture on the front of"
    PRINT "the box).  At this point, you can either hit [B] to return to the main menu"
    PRINT "and select a different puzzle, [ESC] to quit the game, or any other key to"
    PRINT "start unscrambling the puzzle.  The screen will blank for a bit; it will be"
    PRINT "scrambling the puzzle.  You'll then be shown a grid with all the puzzle"
    PRINT "pieces (scrambled)."
    PRINT "     A flashing box will indicate your cursor's position.  You can use the"
    PRINT "cursor keys to move the box around the grid.  If you hit [ENTER], you will"
    PRINT "select a piece to be moved.  It will stay where it is until you hit [ENTER]"
    PRINT "again, at which point both that piece and the one under the cursor will be"
    PRINT "swapped.  Thus, if you were to hit [ENTER], move the cursor to the right, and"
    PRINT "hit [ENTER] again, the piece under your cursor and the one you selected will"
    PRINT "switch places.  Once you select a piece, the grid around it will glow red."
    PRINT "Don't worry if this sounds confusing.  It will all be perfectly clear when you"
    PRINT "start playing the game."
    PRINT "     Anyway, if you ever get stuck, you can always hit [H] for a hint.  This"
    PRINT "will display the completed puzzle to one side of your scrambled one.  Hit any"
    PRINT "key to remove this display.  You can also hit [ESC] to quit the game."
    PRINT "     Oh, and one more thing.  Near the bottom of the screen, the number of"
    PRINT "seconds that have passed since you began the game will be shown.  The object of"
    PRINT "the game is to finish the puzzle with the least possible score, and time is"
    PRINT "factored in.  So watch that number!!";
    LOCATE 25, 50: PRINT "Hit any key to continue....";
    DO: LOOP UNTIL INKEY$ <> ""
    SCREEN 13
  ELSEIF i$ = CHR$(0) + "<" THEN ' [F2]
    quit = 1
  END IF
LOOP UNTIL (ASC(i$) > 64 AND ASC(i$) < 65 + NUM.PUZZLES) OR quit > 0' A-H is input
RETURN

DoPuzzle:
IF quit = 0 THEN
  GOSUB DrawAndScramblePuzzle
  DO
    GOSUB DoStuff ' Main processing loop
  LOOP UNTIL quit > 0
  SELECT CASE quit
    CASE 1
      SCREEN 2: SCREEN 0
      PRINT "Cheater!"
    CASE 2 ' You won!
      LINE (0, 0)-(100, 100), 0, BF
      count = 0
      FOR j = 0 TO 80 STEP 20 ' Display correct image
        FOR i = 0 TO 80 STEP 20
          count = count + 1
          PUT (i, j), correct(1, count)
        NEXT i
      NEXT j
      LOCATE 23, 1: PRINT "You did it!";
      LOCATE 24, 1: PRINT "Congrats on beating puzzle"; STR$(puzzlenum); "!!";
      quit = 0
  END SELECT
  score = score + TheTime * 15 ' Calculate new score
  LOCATE 25, 1: PRINT "Your score is"; STR$(score); ".";
  IF quit <> 1 THEN ' Unless user wants to exit, pause
    DO: LOOP UNTIL INKEY$ <> ""
  END IF
END IF
RETURN

DrawAndScramblePuzzle:
puzzlenum = ASC(i$) - 64 ' Get actual puzzle number from ASCII code
CLS
LOCATE 25, 1: PRINT "One moment, drawing...";
RANDOMIZE TIMER
DrawPuzzle puzzlenum
count = 0
FOR j = 0 TO 80 STEP 20 ' Actually GET the puzzle
  FOR i = 0 TO 80 STEP 20
    count = count + 1
    GET (i, j)-(i + 19, j + 19), puzzle(1, count)
    GET (i, j)-(i + 19, j + 19), correct(1, count)
  NEXT i
NEXT j
LINE (0, 0)-(100, 100), 23, B
LOCATE 24, 1: PRINT "Here's the completed puzzle;";
LOCATE 25, 1: PRINT "hit any key to begin...";
DO: i$ = UCASE$(INKEY$): LOOP UNTIL i$ <> ""
GoAhead = 0
IF i$ = CHR$(27) THEN ' [ESC]
  quit = 1
ELSE
  CLS
  LOCATE 25, 1: PRINT "One moment, scrambling...";
  FOR i = 1 TO 25
    IF RND > .5 THEN ' Half the time, swap with a random piece
      rand = INT(RND * 25 + 1)
      FOR j = 1 TO 200 ' Swap the actual values in each graphic
        hold = puzzle(j, i)
        puzzle(j, i) = puzzle(j, rand)
        puzzle(j, rand) = hold
      NEXT j
    END IF
  NEXT i
  CLS : TheTime = 0: GoodSoFar = 0
  posit = 1: x = 0: y = 0
  selected = 0
  count = 0
  FOR j = 0 TO 80 STEP 20 ' Display the scrambled puzzle
    FOR i = 0 TO 80 STEP 20
      count = count + 1
      PUT (i, j), puzzle(1, count)
    NEXT i
  NEXT j
END IF
RETURN

DoStuff:
FOR j = 0 TO 80 STEP 20 ' Draw lines
  FOR i = 0 TO 80 STEP 20
    LINE (i, j)-(i + 20, j + 20), 23, B
  NEXT i
NEXT j
IF selected > 0 THEN ' If something's selected, draw the red box
  LINE (selectx, selecty)-(selectx + 20, selecty + 20), 4, B
END IF
DO
  i$ = UCASE$(INKEY$)
  IF t$ <> TIME$ THEN ' Increment TheTime every second
    t$ = TIME$: TheTime = TheTime + 1
    LOCATE 24, 1: PRINT TheTime;
  END IF
  IF t! <> TIMER THEN ' Toggle CursorColor every 1/18th of a second
    t! = TIMER
    IF CursorColor = 15 THEN CursorColor = 8 ELSE CursorColor = 15
    LINE (x, y)-(x + 20, y + 20), CursorColor, B
  END IF
LOOP UNTIL i$ <> "" ' Pause until keyhit
IF i$ = "8" OR i$ = CHR$(0) + "H" THEN ' [8] or [UP]
  IF y > 0 THEN y = y - 20: posit = posit - 5
ELSEIF i$ = "2" OR i$ = CHR$(0) + "P" THEN ' [2] or [DOWN]
  IF y < 80 THEN y = y + 20: posit = posit + 5
ELSEIF i$ = "6" OR i$ = CHR$(0) + "M" THEN ' [6] or [RIGHT]
  IF x < 80 THEN x = x + 20: posit = posit + 1
ELSEIF i$ = "4" OR i$ = CHR$(0) + "K" THEN ' [4] or [LEFT]
  IF x > 0 THEN x = x - 20: posit = posit - 1
ELSEIF i$ = "H" THEN
  score = score + 100
  count = 0
  FOR j = 0 TO 80 STEP 20
    FOR i = 0 TO 80 STEP 20
      count = count + 1
      PUT (i + 150, j), correct(1, count)
    NEXT i
  NEXT j
  LINE (150, 0)-(250, 100), 23, B
  DO
    i$ = INKEY$
    IF t$ <> TIME$ THEN
      t$ = TIME$: TheTime = TheTime + 1
      LOCATE 24, 1: PRINT TheTime;
    END IF
    IF t! <> TIMER THEN
      t! = TIMER
      IF cursor = 15 THEN cursor = 8 ELSE cursor = 15
      LINE (x, y)-(x + 20, y + 20), cursor, B
    END IF
  LOOP UNTIL i$ <> ""
  LINE (150, 0)-(250, 100), 0, BF
ELSEIF i$ = CHR$(27) THEN ' [ESC]
  quit = 1
ELSEIF i$ = CHR$(13) THEN
  IF selected > 0 THEN
    LOCATE 25, 1: PRINT "Swapping...";
    FOR j = 1 TO 200
      hold = puzzle(j, posit)
      puzzle(j, posit) = puzzle(j, selected)
      puzzle(j, selected) = hold
    NEXT j
    selected = 0
    GoodSoFar = 0
    FOR count = 1 TO 25 ' Compare the puzzle to the solved one
      FOR l = 1 TO 200 STEP 8 ' Check every 8th element
        IF puzzle(l, count) = correct(l, count) THEN
          GoodSoFar = GoodSoFar + 1
        END IF
      NEXT l
    NEXT count
    IF GoodSoFar = total THEN quit = 2 ' All the elements match!
    LINE (0, 0)-(100, 100), 0, BF
    count = 0
    FOR j = 0 TO 80 STEP 20
      FOR i = 0 TO 80 STEP 20
        count = count + 1
        PUT (i, j), puzzle(1, count)
      NEXT i
    NEXT j
    LOCATE 25, 1: PRINT "Swapped    ";
  ELSE
    selectx = x: selecty = y: selected = posit
    LOCATE 25, 1: PRINT "Selected";
  END IF
END IF
RETURN

DEFSNG A-Z
SUB DrawPuzzle (puzzlenum AS INTEGER)

' Each puzzle must fit in the following square: (0, 0)-(100, 100)
' Simply add extra CASE statements for more puzzles.

SELECT CASE puzzlenum
  CASE 1
    ' Glass of Root Beer
    colr = 15: colr2 = 6
    LINE (10, 10)-(90, 90), colr, B
    LINE (11, 20)-(89, 74), colr2, B
    LINE (10, 75)-(90, 90), colr, BF
    LINE (30, 30)-(30, 75), colr
    LINE (70, 30)-(70, 75), colr
    LINE (29, 29)-(29, 74), colr2
    LINE (31, 29)-(31, 74), colr2
    PSET (30, 29), colr2
    LINE (69, 29)-(69, 74), colr2
    LINE (71, 29)-(71, 74), colr2
    PSET (70, 29), colr2
    PAINT (50, 50), colr2
  CASE 2
    ' Geometric Shapes
    colr = 2
    CIRCLE (20, 20), 4, colr
    LINE (38, 18)-(42, 22), colr, B
    CIRCLE (60, 20), 8, colr
    LINE (76, 16)-(84, 24), colr, B
    LINE (17, 57)-(43, 63), colr, B
    LINE (70, 50)-(90, 90), colr, B
    LINE (10, 90)-(50, 90), colr
  CASE 3
    ' Roundabouts
    colr = 80
    CIRCLE (50, 50), 10, colr
    CIRCLE (50, 50), 35, colr
    CIRCLE (25, 25), 20, colr
    CIRCLE (75, 25), 20, colr
    CIRCLE (25, 75), 20, colr
    CIRCLE (75, 75), 20, colr
  CASE 4
    ' Squares!!!
    colr = 48
    'LINE (0, 0)-(100, 100), 23, B
    LINE (45, 50)-(85, 90), colr, B
    LINE (10, 23)-(55, 68), colr, B
    LINE (33, 38)-(45, 50), colr, B
    LINE (50, 10)-(75, 35), colr, B
    LINE (55, 85)-(95, 95), colr, B
  CASE 5
    ' Blocks
    colr = 80
    LINE (47, 47)-(53, 53), colr, B
    LINE (38, 38)-(62, 62), colr, B
    LINE (17, 17)-(23, 23), colr, B
    LINE (78, 18)-(82, 22), colr, B
    LINE (18, 78)-(22, 82), colr, B
    LINE (77, 77)-(83, 83), colr, B
  CASE 6
    ' Train Track
    colr = 7
    CIRCLE (58, 25), 15, colr
    LINE (45, 20)-(75, 40), 0, BF
    CIRCLE (10, 10), 5, colr
    LINE (6, 10)-(14, 14), 0, BF
    LINE (5, 10)-(5, 81), colr
    LINE (15, 10)-(15, 40), colr
    CIRCLE (20, 40), 5, colr
    LINE (16, 35)-(24, 40), 0, BF
    LINE (25, 40)-(25, 20), colr
    CIRCLE (45, 20), 20, colr
    LINE (26, 20)-(45, 40), 0, BF
    LINE (45, 37)-(45, 20), colr
    LINE (70, 18)-(80, 28), colr
    LINE (81, 28)-(81, 55), colr
    CIRCLE (75, 55), 5, colr
    LINE (70, 50)-(77, 58), 0, BF
    LINE (77, 50)-(79, 53), 0, BF
    LINE (75, 59)-(45, 59), colr
    CIRCLE (45, 65), 7, colr
    LINE (45, 60)-(52, 75), 0, BF
    LINE (45, 72)-(70, 72), colr
    CIRCLE (70, 80), 10, colr
    LINE (60, 73)-(66, 89), 0, BF
    LINE (70, 88)-(15, 88), colr
    CIRCLE (12, 82), 7, colr
    LINE (6, 75)-(19, 83), 0, BF
    LINE (15, 81)-(19, 87), 0, BF
  CASE 7
    ' Junk
    colr = 6
    LINE (5, 80)-(95, 80), colr                   ' Main Sail
    LINE (5, 80)-(55, 25), colr                   ' ditto
    LINE (50, 30)-(95, 80), colr                  ' ditto
    PAINT (55, 40), colr                          ' ditto
    LINE (40, 10)-(40, 40), colr                  ' Top Sail
    LINE (40, 10)-(55, 25), colr                  ' ditto
    PAINT (50, 22), colr                          ' ditto
    LINE (90, 80)-(75, 95), colr                  ' Bottom
    LINE (25, 95)-(75, 95), colr                  ' ditto
    LINE (15, 85)-(25, 95), colr                  ' ditto
    LINE (15, 85)-(35, 85), colr                  ' ditto
    LINE (35, 85)-(35, 81), colr                  ' ditto
    PAINT (80, 85), colr                          ' ditto
  CASE 8
    ' Numeral Two
    colr = 9
    LINE (65, 45)-(15, 95), colr
    LINE (15, 95)-(80, 95), colr
    LINE (80, 95)-(95, 80), colr
    LINE (95, 80)-(60, 80), colr
    LINE (60, 80)-(95, 45), colr
    LINE (95, 45)-(60, 10), colr
    LINE (60, 10)-(30, 10), colr
    LINE (30, 10)-(10, 30), colr
    LINE (10, 30)-(30, 50), colr
    LINE (30, 50)-(50, 50), colr
    LINE (50, 50)-(30, 30), colr
    LINE (30, 30)-(50, 30), colr
    LINE (50, 30)-(65, 45), colr
    PAINT (30, 90), colr
END SELECT

END SUB

