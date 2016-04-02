'======================================================
' WHEEL OF WEALTH II  (1996)  Programmed by William Yu
'
' Yes, it's another WHEEL OF WEALTH Game.
' I programmed the brunt of the game at school, and
' patched up some graphics and added more puzzles at
' home.  Including Marge Simpson as Vanna White!
' Lots of documentation because this was my final
' project for my computer class.
'
' New additions for Version II:
'   * Programmed for QBasic in mind
'   * Featuring Marge Simpson as Vanna White
'   * Puzzles are stored in DATA statements
'   * New and improved graphics
'   * Puzzles DO NOT repeat in a single game
'   * Maximum characters reduced to 13
'
' Features for both versions:
'   - Realistic spinning wheel
'   - Up to 3 players
'   - Edit your own puzzles quick and easily
'   - BONUS Land just like Game Show!
'   - Like TV Game Show WHEEL OF FORTUNE
'
' SCORING:
'   Scoring is tallied each round, winner's score is
'   added to his previous total, losers score is not.
'   $200 is awarded to player if he solves the puzzle
'        but has no money when he solves it.
'   $250 is the cost for buying a vowel
'   $500 is awarded to player for answering the CLUE
'        correctly... refer to category "BLANK" or
'        category "CLUE"
'   Winner with the highest total in # rounds will
'   play the BONUS ROUND... no prizes though.
'
' USE WITHIN COMMERCIAL PRODUCTS OR SALE OF THIS PIECE
' OF CODE IS STRICTLY PROHIBITED.
'
' WHEEL OF FORTUNE is copyrighted by their respective
' producers and distributors, all rights reserved.
' Any similarities to the video game is strictly
' coincidental.
'======================================================
DEFINT A-Z  ' Define all numerical variables as INTEGER for more speed
DECLARE SUB BigChar (Word$, XCor%, YCor%, Colr%, Opt)
DECLARE SUB BonusLand ()
DECLARE SUB DrawGrid ()
DECLARE SUB DrawMarge (MargeX%, MargeY%)
DECLARE SUB FilterPuzzle (Puzzles$(), P%)
DECLARE SUB MainProgram (Puzzles$(), P%)
DECLARE SUB LetterInPuzzle (Letter$, Letter)
DECLARE SUB DrawWheel ()
DECLARE SUB SpinWheel ()
DECLARE SUB ColorCode (Col%)
DECLARE SUB DrawPlayers ()
DECLARE SUB ShowPlayers ()
DECLARE SUB WhoseTurn ()
DECLARE SUB ShowLeader ()
DECLARE SUB ShowMarge (L%, M%, StartX%, MargeY%, Zz%)
DECLARE SUB Pause (Secs!)

DIM SHARED Puzzles$(50)            ' Max # of Puzzles
DIM SHARED NoRepeat(50)            ' Dimension same as Max # of puzzles
DIM SHARED InCase$, InCaseVowel$   ' Consonants and Vowels kept separated
DIM SHARED TypeConst$, TypeVowel$  ' For Keyboard uses
DIM SHARED Puzz$(8)                ' Max # lines in a puzzle
DIM SHARED Money, InPuzzle, Turn, Rn, Finish, Bonus, Max
DIM SHARED PlayerMoney AS LONG
DIM SHARED P1Money AS LONG, P2Money AS LONG, P3Money AS LONG
DIM SHARED M1P AS LONG, M2P AS LONG, M3P AS LONG
DIM SHARED Spw, WheelX, WheelN, RightLeg

CONST Players = 3         ' 1-3 Players (1 Player no score tallied)
CONST Rounds = 6          ' Number of Rounds per game
                          ' CAN NOT be more than the Maximum # of puzzles
                          ' minus CLUE categories because it can not be
                          ' used in the BONUS Round

CONST False = 0           ' False = 0
CONST True = NOT False    ' True = -1

CONST DisplayMarge = True ' Play game with Marge Simpson as Vanna White.
                          ' If you don't like the delays, you can modify
                          ' the delay times for Marge Simpson's speed, or
                          ' just declare this variable as False.
CONST MD = 10             ' Marge Delay
                          ' Increase to speed Marge's walking speed
                          ' Decrease to slow Marge down

Rn = 1                    ' Round Number
WT = 1                    ' Turn = 1
Turn = WT                 ' Create another variable for swapping later
Finish = False            ' Finished Puzzle?  Nope.
Bonus = False             ' Regular round not bonus round

SCREEN 7, 0, 0, 0         ' EGA 320x200 (16 Colors)  Active/Visual Page 0

READ Max                  ' Read first DATA value of maximum puzzles

FOR I = 1 TO Max          ' Start at one
  READ Puzzles$(I)        ' Read each puzzle and store in array Puzzles$()
NEXT I                    ' Until Maximum puzzles reached

DO                        ' Repeat all this until all rounds are played
  DrawPlayers             ' CALL DrawPlayers Subroutine
  DrawGrid                ' CALL DrawGrid Subroutine

  DO
    RANDOMIZE TIMER           ' Randomly select a puzzle
    P = INT(RND * Max) + 1    ' Range from 1 to Max
    FOR R = 1 TO Max          ' But make sure it's not the same puzzle!
      IF NoRepeat(R) = P THEN Repeat = True: EXIT FOR
    NEXT R
    IF NoRepeat(R) <> P THEN Repeat = False   ' Not a repeat!
  LOOP UNTIL Repeat = False   ' Finish loop if not a repeat puzzle
  NoRepeat(Rn) = P            ' Store puzzle # so we know not to pick it again
  FilterPuzzle Puzzles$(), P  ' Parse puzzle to readable format

  DO                                ' Game Play Loop
    MainProgram Puzzles$(), P       ' CALL MainProgram (Brunt of the game)
    IF Finish THEN EXIT DO          ' Current round finished
    IF Players > 1 THEN ShowPlayers ' Make sure more than 1 player is playing
  LOOP                              ' Continue playing until puzzle is finished
 
  Rn = Rn + 1                       ' Next Round
  WT = WT + 1                       ' Whose Turn
  IF WT = Players + 1 THEN WT = 1   ' Rotate back to the first person
  Turn = WT                         ' Whose turn?
  Finish = False                    ' New round, not finished yet

  ShowLeader                 ' Show end of round leader

LOOP UNTIL Rn > Rounds       ' Continue play until all rounds are finished

' Calculate who has the greatest amount of cash!  No ties.
IF M1P > M2P THEN Winner = 1 ELSE Winner = 2
IF Winner = 2 THEN
  IF M2P > M3P THEN Winner = 2 ELSE Winner = 3
END IF
IF Winner = 1 THEN
  IF M1P > M3P THEN Winner = 1 ELSE Winner = 3
END IF

LOCATE 24, 10: PRINT "Player"; Winner; "is the winner!";
Pause 1.5

BonusLand                    ' Winner plays Bonus Round

' DATA Format works like so:
'
' First number is the maximum number of puzzles inputted by user,
' increase number if you add more puzzles into the DATA statements
'
' How Puzzles should be inputted (NOT Case sensitive).
'
' 7 lines, each line seperated by "/"
'          an empty line should be inputted with "EMPTY"
'          Maximum of 13 characters per line
' 1st line:  Category (ie. PHRASE/THING/QUOTE...etc)
' 2nd line:  Line one   of Puzzle
' 3rd line:    "  two   "    "
' 4th line:    "  three "    "
' 5th line:    "  four  "    "
' 6th line:    "  five  "    "
' 7th line:    "  six   "    "
'*8th line: CLUE for "BLANK" or "CLUE"
'
'* Only place 8th line with category "BLANK" or "CLUE"
'  Look at the DATA for reference
'
'  Player is awarded $500 for getting the correct answer!

DATA 39
DATA "PHRASE/EMPTY/  What Goes/    Up Must/EMPTY/  Come Down/EMPTY"
DATA "CLUE/EMPTY/  Rabbit's/  Tail Or/Natural Fiber/EMPTY/EMPTY/COTTON"
DATA "QUOTE/EMPTY/   Go Ahead/EMPTY/ Make My Day/EMPTY/EMPTY"
DATA "PHRASE/EMPTY/Speak Now Or/Forever Hold/ Your Peace/EMPTY/EMPTY"
DATA "PLACE/EMPTY/   Edmonton/   Alberta/   Canada/EMPTY/EMPTY"
DATA "PEOPLE/EMPTY/World Figure-/     Skating/  Champions/EMPTY/EMPTY"
DATA "STAR & ROLE/EMPTY/Jim Carrey As/EMPTY/ Ace Ventura/EMPTY/EMPTY"
DATA "PHRASE/EMPTY/ It's Not All/ Cracked Up/ As It Used/ To Be/EMPTY"
DATA "PHRASE/EMPTY/ Better Safe/EMPTY/ Than Sorry/EMPTY/EMPTY"
DATA "PHRASE/EMPTY/Shooting Fish/EMPTY/ In A Barrel/EMPTY/EMPTY"
DATA "BLANK/EMPTY/ ? Alarm/ ? Fighters/ ? Truck/EMPTY/EMPTY/FIRE"
DATA "PHRASE/EMPTY/  What Goes/   Around/ Comes Around/EMPTY/EMPTY"
DATA "BEFORE & AFTER/EMPTY/ Tooth Fairy/EMPTY/  Godmother/EMPTY/EMPTY"
DATA "BLANK/EMPTY/  ? Hornet/  ? Olives/  ? Grass/  ? Beans/EMPTY/GREEN"
DATA "PHRASE/EMPTY/Save The Best/EMPTY/   For Last/EMPTY/EMPTY"
DATA "CLUE/EMPTY/Line Through/  The Center/ Of A Circle/EMPTY/EMPTY/DIAMETER"
DATA "QUOTE/EMPTY/  To Be Or/EMPTY/  Not To Be/EMPTY/EMPTY"
DATA "QUOTE/EMPTY/ Now Is Our/ Winter of/ Discontent/EMPTY/EMPTY"
DATA "BLANK/EMPTY/     Pearl ?/Strawberry ?/ Toast And ?/EMPTY/EMPTY/JAM"
DATA "PHRASE/EMPTY/  Two Heads/  Are Better/  Than One/EMPTY/EMPTY"
DATA "PHRASE/EMPTY/ Good Things/Come To Those/ Who Wait/EMPTY/EMPTY"
DATA "PHRASE/EMPTY/  Moving To/  Greener/  Pastures/EMPTY/EMPTY"
DATA "PHRASE/EMPTY/Fair Winds &/ Following/ Seas/EMPTY/EMPTY"
DATA "PHRASE/EMPTY/  The Early/  Bird Gets/  The Worm/EMPTY/EMPTY"
DATA "CLUE/EMPTY/   Half A/ Semester Or/  Two Bits/EMPTY/EMPTY/QUARTER"
DATA "PHRASE/EMPTY/  All Roads/EMPTY/Lead To Rome/EMPTY/EMPTY"
DATA "QUOTE/EMPTY/ Better Late/EMPTY/ Than Never/EMPTY/EMPTY"
DATA "QUOTE/EMPTY/ A Thing Of/ Beauty Is A/ Joy Forever/EMPTY/EMPTY"
DATA "BLANK/EMPTY/  Fire    ?/  Dump    ?/  Garbage ?/EMPTY/EMPTY/TRUCK"
DATA "PHRASE/EMPTY/ The Stuff/ That Dreams/ Are Made Of/EMPTY/EMPTY"
DATA "CLUE/EMPTY/  South/  American/  Big Cat Or/  Luxury Car/EMPTY/JAGUAR"
DATA "PHRASE/EMPTY/ Like Taking/ Candy From/ A Baby/EMPTY/EMPTY"
DATA "PEOPLE/EMPTY/ President Of/ The United/ States of/ America/EMPTY"
DATA "BEFORE & AFTER/EMPTY/ Too Good/ To Be True/ Confessions/EMPTY/EMPTY"
DATA "BLANK/EMPTY/ ? Moon/ ? Tank/ ? of Baloney/EMPTY/EMPTY/FULL"
DATA "PHRASE/EMPTY/ Be Quiet/ You'll Wake/ Up The Dead/EMPTY/EMPTY"
DATA "PHRASE/EMPTY/  Dropping/EMPTY/ Like Flies/EMPTY/EMPTY"
DATA "BEFORE & AFTER/EMPTY/   Natural/   Spring/   Water/   Buffalo/EMPTY"
DATA "PHRASE/EMPTY/ He Who/ Laughs Last/ Laughs Best/EMPTY/EMPTY"

SUB BigChar (Word$, XCor, YCor, Colr, Opt)

' Subroutine BIGCHAR
' Purpose:   Prints the extended (BIG) character on the puzzle grid

PALETTE 6, 0    ' Hide the letter to be read in (Brown)
                ' Color selected is not used in gameplay
                ' I'm hiding the characters because it's distracting
                ' looking at each letter pop-up on the top left-hand
                ' corner of your screen.

COLOR 6         ' Color is hidden because we rarely use this color anyways
FOR L = 1 TO LEN(Word$)
  LOCATE 1, 1: PRINT MID$(Word$, L, 1)
  FOR N = 0 TO 7              ' Read Left to Right
    FOR M = 0 TO 7            ' Read Top to Bottom
      Colour = POINT(N, M)    ' Grabs the colour of the letter
      IF Colour > 0 THEN      ' if not black, then we plot the coordinates
        IF Opt = 0 THEN       '|------| Straight print, no slants
          PSET (XCor + N + (L * 8), YCor + M + M), Colr
          PSET (XCor + N + (L * 8), 1 + YCor + M + M), Colr
        ELSEIF Opt = 1 THEN   '|//////| Slant Left
          PSET (XCor + N + (L * 9), YCor + M + M + Z), Colr
          PSET (XCor + N + (L * 9), 1 + YCor + M + M + Z), Colr
        ELSEIF Opt = 2 THEN   '|\\\\\\| Slant Right
          PSET (XCor + N + (L * 9), YCor + M + M - Z), Colr
          PSET (XCor + N + (L * 9), 1 + YCor + M + M - Z), Colr
        END IF
      END IF
    NEXT M
  NEXT N
  XCor = XCor + 1
  Z = Z - 2
NEXT L

LOCATE 1, 1: PRINT " "  ' Clear letter so no one can see it!
PALETTE 6, 6            ' Restore the color to its normal value

END SUB

SUB BonusLand

  Bonus = True     ' Yes we are in Bonus round
                   ' We need this variable for SUB LetterInPuzzle

  DrawGrid         ' Display Playing Grid

  BigChar "BONUS LAND", 100, 0, 12, 0    ' Display Title

  LINE (0, 199)-(320, 150), 0, BF        ' Hide Letters on the bottom of screen

  Done = False                           ' Choose puzzle that is acceptable
  DO                                     ' Done must be True when we leave this
    DO                                   ' loop
      RANDOMIZE TIMER         ' Randomly select a puzzle
      P = INT(RND * Max) + 1
      FOR R = 1 TO Max        ' But make sure it's not the same puzzle!
        IF NoRepeat(R) = P THEN Repeat = True: EXIT FOR
      NEXT R
      IF NoRepeat(R) <> P THEN Repeat = False
    LOOP UNTIL Repeat = False
    FilterPuzzle Puzzles$(), P               ' Parse the puzzle
    IF Puzz$(1) <> "BLANK" AND Puzz$ <> "CLUE" THEN
      Done = True                            ' Bonus round <> "BLANK" or "CLUE"
    END IF
  LOOP UNTIL Done                        ' Puzzle is acceptable, continue game

' Like the TV Game Show:
'
'   R S T L N   E
'
' Letters automatically selected by computer
' Marge Simpson is disabled for this round
'
' You will be prompted to enter 3 other consonants and 1 vowel

  InCase$ = "BCDFGHJKMPQVWXYZ"      ' Missing Consonants "RSTLN"
  InCaseVowel$ = "AIOU"             ' Missing Vowel "E"
  COLOR 12: LOCATE 20, 3: PRINT "R S T L N  "; : COLOR 14: PRINT "E"
  Letters$ = "RSTLNE"               ' Letters picked automatically
  FOR A = 1 TO LEN(Letters$)        ' Display these letters on the grid
    A$ = MID$(Letters$, A, 1)       ' Start one by one
    LetterInPuzzle A$, 0            ' Place letter in puzzle
  NEXT A
  COLOR 10: LOCATE 22, 1: PRINT "Select 3 Consonants:  ";
  COLOR 12
  C = 0                             ' Select THREE Consonants
  Letters$ = ""
  DO
    DO                              ' Loop until valid input by user
      A$ = UCASE$(INPUT$(1))        ' Get users input
    LOOP UNTIL INSTR(InCase$, A$)   ' Must be a valid input
    PRINT A$; " ";                  ' Display what user typed
    C = C + 1
    Letters$ = Letters$ + A$        ' Fill Letters$ for parsing later
  LOOP UNTIL C = 3                  ' THREE Consonants selected, continue
  COLOR 10: LOCATE 23, 1: PRINT "     Select 1 Vowel:  ";
  DO
    A$ = UCASE$(INPUT$(1))             ' Get input from user
  LOOP UNTIL INSTR(InCaseVowel$, A$)   ' Must be a valid vowel
  COLOR 14: PRINT A$
  Letters$ = Letters$ + A$
  FOR A = 1 TO LEN(Letters$)           ' Parse letters choosen
    A$ = MID$(Letters$, A, 1)          ' One by one
    LetterInPuzzle A$, 0               ' Place letter in puzzle
  NEXT A

  Pause 1                              ' Give user a second to ponder
  LINE (0, 199)-(320, 150), 0, BF      ' Erase bottom of screen
  COLOR 15
  LOCATE 20, 1: PRINT "SOLVE:"
  Solve$ = ""
  Last = False
  FOR Q = 2 TO 7
    IF Puzz$(Q) <> "EMPTY" THEN
      IF RIGHT$(Puzz$(Q), 1) = "-" THEN Last = True
        IF Last = False THEN
          Solve$ = Solve$ + LTRIM$(Puzz$(Q)) + " "
        ELSE
          Solve$ = Solve$ + LTRIM$(Puzz$(Q))
          Last = False
        END IF
    END IF
  NEXT Q
  Solve$ = RTRIM$(Solve$)
  LOCATE 22, 1
  FOR Q = 1 TO LEN(Solve$)
    COLOR 14
    A = ASC(MID$(Solve$, Q, 1))
    SELECT CASE A
      CASE 38     ' & sign
        COLOR 10
        PRINT "&";
      CASE 39     ' Apostrophe
        COLOR 10
        PRINT "'";
      CASE 45
        COLOR 10
        PRINT "-";
      CASE 32
        PRINT " ";
      CASE ELSE
        PRINT "љ";
    END SELECT
  NEXT Q
  LOCATE 22, 1: COLOR 15: LINE INPUT Answer$
  LINE (0, 0)-(320, 15), 0, BF
  IF UCASE$(Answer$) = UCASE$(Solve$) THEN
    BigChar "CONGRATULATIONS", 80, 0, 12, 0
  ELSE
    BigChar "BETTER LUCK NEXT TIME", 60, 2, 12, 0
  END IF
  AllCase$ = InCase$ + InCaseVowel$
  FOR Q = 1 TO LEN(AllCase$)
    A$ = MID$(AllCase$, Q, 1)
    IF INSTR(UCASE$(Solve$), A$) THEN LetterInPuzzle A$, 0
  NEXT Q

END SUB

SUB ColorCode (Col)

' The color code of the WHEEL
' Yellow = Lose Turn
' Black  = Bankrupt
' Grey   = $5000

SELECT CASE Col
   CASE 1
     Money = 250
   CASE 2
     Money = 150
   CASE 3
     Money = 500
   CASE 4
     Money = 300
   CASE 5
     Money = 750
   CASE 6
     Money = 650
   CASE 7
     Money = 5000
   CASE 8
     Money = -1
   CASE 9
     Money = 1000
   CASE 10
     Money = 200
   CASE 11
     Money = 2500
   CASE 12
     Money = 900
   CASE 13
     Money = 350
   CASE 14
     Money = 0
END SELECT

  LOCATE 25, 18
  IF Money > 0 THEN
    PRINT "$" + LTRIM$(STR$(Money)) + "      ";
  ELSE
    IF Money = -1 THEN PRINT "BANKRUPT   ";
    IF Money = 0 THEN PRINT "LOSE TURN   ";
  END IF

END SUB

SUB DrawGrid

CLS

LINE (11, 17)-(307, 147), 7, BF      ' Background color of grid is Grey/Gray

D = 0
FOR Y = 1 TO 6              ' Draw 6x13 Puzzle grid
  Z = 0: N = 10             ' Rather confusing, no?
  D = D + 2
  FOR X = 1 TO 13
    LINE (X + N + Z, Y * 20 - 5 + D)-(X + 20 + N + Z, Y * 20 + 15 + D), 10, B
    LINE (X + N + Z + 1, Y * 20 - 5 + 1 + D)-(X + 19 + N + Z, Y * 20 + 14 + D), 2, BF
    Z = Z + 2
    N = N + 20
  NEXT X
NEXT Y

COLOR 11: LOCATE 20, 5: PRINT "B C D F G H J K L M N P    A E I"
LOCATE 22, 5: PRINT "Q R S T V W X Y Z QUIT!    O U";

InCase$ = "BCDFGHJKLMNPQRSTVWXYZ"         ' All consonants
InCaseVowel$ = "AEIOU"                    ' All vowels
TypeConst$ = InCase$                      ' Used for keyboard purposes
TypeVowel$ = InCaseVowel$                 ' Also used for keyboard purposes

END SUB

SUB DrawMarge (MargeX, MargeY)

' NOTE:  I am not a regular "Simpsons" viewer, so I don't remember what
'        Marge looks like.  I remember the hair-do though, but that
'        is about all I recall.
'
' This character I've drawn looks more like a cross between "The Joker" and
' Marge Simpson.

'===== Start Drawing Marge Simpson's Face ====='

CIRCLE (MargeX, MargeY + 43), 13, 6, , , 1.3   ' Face
PAINT (MargeX, MargeY + 47), 14, 6
CIRCLE (MargeX, MargeY + 43), 13, 8, , , 1.3
CIRCLE (MargeX + 4, MargeY + 39), 2, 15        ' Eyelids or whatever
PAINT (MargeX + 4, MargeY + 39), 15
PSET (MargeX + 5, MargeY + 39), 0              ' Eye
CIRCLE (MargeX + 5, MargeY + 48), 5, 0, 3.5, 5.2, 1 / 2    ' Sensual lips???
CIRCLE (MargeX + 5, MargeY + 47), 5, 12, 3.5, 5.2, 1 / 2   ' Scary actually
CIRCLE (MargeX + 5, MargeY + 49), 5, 12, 3.5, 5.2, 1 / 2

'===== Start Drawing Marge's Cool Hair-do ====='

CIRCLE (MargeX, MargeY), 10, 1, .1, 3          ' Top of hair
FOR Y = MargeY + 2 TO 26 + MargeY STEP 6       ' Create those cool curls
  CIRCLE (MargeX - 9, Y), 4, 1, 2, 4.2, 1.5    ' at the LEFT side of her head
  CIRCLE (MargeX + 9, Y), 4, 1, 5, 1.5, 1.5    ' Start RIGHT Side
NEXT Y
CIRCLE (MargeX, MargeY + 31), 10, 1, 2.8, .1, 1 / 3
PAINT (MargeX, MargeY + 20), 9, 1

'===== Start Drawing Marge's Sleek Dress ====='

CIRCLE (MargeX + 1, MargeY + 63), 10, 1, 2, 3
LINE (MargeX - 9, MargeY + 63)-(MargeX - 9, MargeY + 112), 1
LINE (MargeX + 3, MargeY + 57)-(MargeX + 11, MargeY + 65), 1
LINE (MargeX + 3, MargeY + 57)-(MargeX - 2, MargeY + 57), 1
LINE (MargeX + 11, MargeY + 65)-(MargeX + 11, MargeY + 112), 1
LINE (MargeX + 11, MargeY + 112)-(MargeX - 9, MargeY + 112), 1
PAINT (MargeX, MargeY + 77), 9, 1
LINE (MargeX + 11, MargeY + 112)-(MargeX - 9, MargeY + 112), 8

'===== Start Drawing Marge's Lengthy Arm ====='

CIRCLE (MargeX, MargeY + 65), 5, 8, .1, 3.2
LINE (MargeX - 4, MargeY + 66)-(MargeX + 2, MargeY + 95), 8
LINE (MargeX + 5, MargeY + 66)-(MargeX + 9, MargeY + 95), 8
LINE (MargeX + 9, MargeY + 95)-(MargeX + 2, MargeY + 95), 8
PAINT (MargeX, MargeY + 80), 14, 8
CIRCLE (MargeX + 6, MargeY + 96), 4, 14
PAINT (MargeX + 6, MargeY + 96), 14
PSET (MargeX + 4, MargeY + 98), 12        ' Why draw Marge's fingers
PSET (MargeX + 7, MargeY + 99), 12        ' Too much work, just draw her
PSET (MargeX + 9, MargeY + 97), 12        ' fingernails.

'===== Start Drawing Marge's Moving Legs ====='

' Not exactly PICASSO here, but it works nonetheless.

RightLeg = RightLeg + 1                          ' Create moving legs
IF RightLeg = 3 THEN RightLeg = 0

SELECT CASE RightLeg
  CASE 0               ' Stablize leg
    LINE (MargeX - 3, MargeY + 113)-(MargeX - 3, MargeY + 130), 8
    LINE (MargeX + 4, MargeY + 113)-(MargeX + 4, MargeY + 130), 8
    LINE (MargeX + 4, MargeY + 130)-(MargeX - 3, MargeY + 130), 8
    PAINT (MargeX, MargeY + 120), 6, 8
    PAINT (MargeX, MargeY + 120), 14, 8
    CIRCLE (MargeX + 3, MargeY + 130), 7, 4, , , 1 / 3
    PAINT (MargeX + 3, MargeY + 130), 12, 4
  CASE 1               ' Right Leg in Front
    LINE (MargeX + 7, MargeY + 113)-(MargeX + 13, MargeY + 130), 8
    LINE (MargeX - 1, MargeY + 113)-(MargeX + 5, MargeY + 130), 8
    LINE (MargeX + 1, MargeY + 117)-(MargeX + 5, MargeY + 130), 8
    LINE (MargeX + 5, MargeY + 130)-(MargeX + 13, MargeY + 130), 8
    LINE (MargeX - 6, MargeY + 113)-(MargeX - 10, MargeY + 130), 8    ' Left leg behind
    LINE (MargeX, MargeY + 117)-(MargeX - 4, MargeY + 130), 8
    LINE (MargeX - 10, MargeY + 130)-(MargeX - 4, MargeY + 130), 8
  CASE 2               ' Left Leg in Front
    LINE (MargeX - 6, MargeY + 113)-(MargeX - 12, MargeY + 130), 8
    LINE (MargeX, MargeY + 117)-(MargeX - 4, MargeY + 130), 8
    LINE (MargeX + 2, MargeY + 113)-(MargeX - 4, MargeY + 130), 8
    LINE (MargeX - 12, MargeY + 130)-(MargeX - 4, MargeY + 130), 8
    LINE (MargeX + 6, MargeY + 113)-(MargeX + 12, MargeY + 130), 8    ' Right leg behind
    LINE (MargeX + 1, MargeY + 117)-(MargeX + 5, MargeY + 130), 8
    LINE (MargeX + 5, MargeY + 130)-(MargeX + 13, MargeY + 130), 8
END SELECT

IF RightLeg > 0 THEN
  PAINT (MargeX + 5, MargeY + 120), 6, 8
  PAINT (MargeX + 5, MargeY + 120), 14, 8                        ' Paint Right Leg
  CIRCLE (MargeX + 12 + RightLeg, MargeY + 130), 7, 4, , , 1 / 3 ' Draw Marge's Right Shoe
  PAINT (MargeX + 12, MargeY + 130), 12, 4

  PAINT (MargeX - 5, MargeY + 120), 6, 8
  PAINT (MargeX - 5, MargeY + 120), 14, 8             ' Paint Left Leg
  CIRCLE (MargeX - 5, MargeY + 130), 7, 4, , , 1 / 3  ' Draw Marge's Left Shoe
  PAINT (MargeX - 5, MargeY + 130), 12, 4
END IF

END SUB

SUB DrawPlayers

CLS

CIRCLE (160, 180), 180, 15, 6, 3, 1 / 4
CIRCLE (160, 160), 180, 15, 6, 3, 1 / 4
CIRCLE (160, 140), 180, 15, 6, 3, 1 / 4

LINE (113, 116)-(81, 100), 15
LINE (207, 116)-(239, 100), 15
LINE (113, 116)-(113, 135), 15
LINE (207, 116)-(207, 135), 15

PAINT (60, 140), 4, 15: PAINT (60, 120), 12, 15
PAINT (160, 130), 1, 15: PAINT (160, 110), 9, 15
PAINT (300, 140), 2, 15: PAINT (300, 120), 10, 15

CIRCLE (40, 75), 65, 15, .3, 3, 1.1
CIRCLE (280, 75), 65, 15, .3, 2.8, 1.1
CIRCLE (160, 62), 65, 15, .15, 3
PAINT (160, 75), 5, 15

'------- Draw player one! ---------'
CIRCLE (160, 45), 16, 14
PAINT (160, 45), 14
LINE (155, 58)-(130, 62), 1
LINE (165, 58)-(190, 62), 1
LINE (130, 62)-(125, 95), 1
LINE (190, 62)-(195, 95), 1
LINE (125, 95)-(130, 95), 1
LINE (130, 94)-(190, 94), 1
LINE (190, 95)-(195, 95), 1
LINE (155, 59)-(165, 59), 1
PAINT (160, 80), 1

IF Players > 1 THEN         ' This draws Player 2 is there are more than 1 player
  CIRCLE (35, 45), 16, 14
  PAINT (35, 45), 14
  LINE (30, 58)-(5, 67), 4
  LINE (40, 58)-(65, 62), 4
  LINE (5, 67)-(5, 115), 4
  LINE (65, 62)-(70, 100), 4
  LINE (70, 99)-(5, 115), 4
  LINE (30, 59)-(40, 59), 4
  PAINT (30, 80), 4
END IF
IF Players = 3 THEN         ' This draws Player 3 is there are 3 players
  CIRCLE (285, 45), 16, 14
  PAINT (285, 45), 14
  LINE (290, 58)-(315, 67), 2
  LINE (280, 58)-(265, 62), 2
  LINE (315, 67)-(315, 116), 2
  LINE (265, 62)-(260, 101), 2
  LINE (260, 101)-(315, 115), 2
  LINE (290, 59)-(280, 59), 2
  PAINT (300, 80), 2
END IF
CIRCLE (160, 140), 180, 15, 6, 3, 1 / 4

LOCATE 24, 15: COLOR 14: PRINT "Round"; Rn; "of"; Rounds;

IF Players = 1 THEN Turn = 2
BigChar "$0", 140, 119, 11, 0
BigChar "$0", 30, 130, 11, 1
BigChar "$0", 250, 126, 11, 2

PCOPY 0, 1

WhoseTurn

END SUB

SUB DrawWheel

CLS

PALETTE 15, 0
CIRCLE (160, 100), 150, 15, , , 1 / 2
CIRCLE (160, 100), 20, 15, , , 1 / 2

FOR X! = -6.2 TO 1 STEP .35
  CIRCLE (160, 100), 150, 15, X!, , 1 / 2
NEXT X!

PAINT (160, 60), 1, 15
PAINT (140, 60), 2, 15
PAINT (120, 70), 3, 15
PAINT (100, 70), 4, 15
PAINT (80, 90), 5, 15
PAINT (80, 105), 6, 15
PAINT (90, 120), 7, 15
PAINT (90, 130), 8, 15
PAINT (110, 140), 9, 15
PAINT (140, 145), 10, 15
PAINT (170, 145), 11, 15
PAINT (210, 145), 12, 15
PAINT (245, 130), 13, 15
PAINT (270, 110), 14, 15
PAINT (290, 95), 1, 15
PAINT (280, 80), 2, 15
PAINT (250, 60), 3, 15
PAINT (220, 50), 4, 15

CIRCLE (160, 100), 20, 14, , , 1 / 2
PAINT (160, 100), 15, 14
CIRCLE (160, 100), 20, 15, , , 1 / 2
CIRCLE (160, 100), 10, 0, , , 1 / 2
PAINT (160, 100), 0
PALETTE 15, 15

END SUB

SUB FilterPuzzle (Puzzles$(), P)

  Text$ = Puzzles$(P)
  A = INSTR(Text$, "/")              ' Parse each line
  Y = 20
  N = 0
  DO WHILE A                         ' Repeat until no more WORDS to filter
    N = N + 1
    T$ = UCASE$(LEFT$(Text$, A - 1)) ' Takes the /WORD/ inside backslashes
    Puzz$(N) = T$                    ' First word represents the category
    IF T$ <> "EMPTY" AND N > 1 THEN  ' Therefore we skip first word
      X = 12
      FOR I = 1 TO LEN(T$)
        IF MID$(T$, I, 1) <> " " THEN PAINT (X, Y), 15, 10
        B = ASC(MID$(T$, I, 1))
        SELECT CASE B
          CASE 38     ' & sign
            PAINT (X, Y), 14, 10
            BigChar CHR$(B), X - 2, Y, 0, 0
          CASE 39     ' Apostrophe
            PAINT (X, Y), 14, 10
            BigChar CHR$(B), X - 2, Y, 0, 0
          CASE 45     ' - sign
            PAINT (X, Y), 14, 10
            BigChar CHR$(B), X - 2, Y, 0, 0
          CASE 63     ' ? sign
            PAINT (X, Y), 14, 10
            BigChar CHR$(B), X - 2, Y, 0, 0
        END SELECT
        X = X + 23
      NEXT I
    END IF
    Text$ = MID$(Text$, A + 1, LEN(Text$))
    A = INSTR(Text$, "/")
    IF N > 1 THEN Y = Y + 22
  LOOP
    N = N + 1
    Puzz$(N) = Text$         ' Last word to be stored
    IF Text$ <> "EMPTY" AND N <> 8 THEN
      X = 22
      FOR I = 1 TO LEN(Text$)
        IF MID$(Text$, I, 1) <> " " THEN PAINT (X, Y), 15, 10
        X = X + 23
      NEXT I
    END IF

    L = LEN(Puzz$(1))   ' Centers the category on the bottom line
    L = 20 - (L / 2)    ' Calculates X position
    LOCATE 25, L: COLOR 14: PRINT Puzz$(1);

END SUB

SUB LetterInPuzzle (Letter$, Letter)

' Letter = 0  means a Consonant was selected
' Letter = 1  means a Vowel was selected

IF Letter = 1 THEN PlayerMoney = PlayerMoney - 250  ' Vowel selected

COLOR 15
N = 1                ' Start with the first line of the puzzle (which is 2)
InPuzzle = False     ' Letter is not in puzzle, must check if it is
      
IF DisplayMarge AND NOT Finish AND NOT Bonus THEN
  PCOPY 0, 2         ' Use this to save (GRID) screen image of page
  PCOPY 0, 3         ' Visual Page image
  Zz = NOT False     ' Create Up and Down Motion
  StartX = 0         ' Start Marge at the left side of screen
  MargeY = 23        ' Marge's Starting Y-Pos Coordinate
  SCREEN 7, 0, 0, 3  ' Switch visual page to 3
END IF

DO
  N = N + 1          ' Start at "N" line of puzzle
  D = D + 2
  Z = -2
  IF Puzz$(N) <> "EMPTY" THEN                 ' Only parse NON-EMPTY lines
    FOR I = 1 TO LEN(Puzz$(N))
      Z = Z + 3
      IF MID$(Puzz$(N), I, 1) = Letter$ THEN            ' Letter is in puzzle
        PAINT ((I * 20) + Z, (N * 20 - 10) + D), 14, 10 ' Light up square
        M = I * 20 + Z - 20: L = (N * 20 - 10) + D
        IF DisplayMarge AND NOT Finish AND NOT Bonus THEN
          ShowMarge L, M, StartX, MargeY, Zz     ' Display Marge
        END IF
        BigChar Letter$, (I * 20 - 11) + Z, (N * 20 - 1) - 20 + D, 0, 0
        IF DisplayMarge AND NOT Finish AND NOT Bonus THEN
          PCOPY 0, 2                             ' Save template once more
        END IF
        IF Letter = 0 THEN PlayerMoney = PlayerMoney + Money
        InPuzzle = True                          ' Letter is in Puzzle
      END IF
    NEXT I
  END IF
LOOP UNTIL N = 7

' Walk Marge out of screen
IF InPuzzle AND DisplayMarge AND NOT Finish AND NOT Bonus THEN
  FOR X = StartX TO 318 STEP MD + 2 ' Increase this delay if your CPU is slow
    Zz = NOT Zz                     ' Up and Down Motion
    DrawMarge X, MargeY + Zz        ' Draw Marge
    PCOPY 0, 3                      ' Display image on visual page 3
    PCOPY 2, 0                      ' Switch back to original (GRID) template
  NEXT X
END IF

SCREEN 7, 0, 0, 0             ' Back to normal

IF InPuzzle = False AND Bonus = False THEN ' Letter NOT in puzzle
  SOUND 1000, .5: SOUND 500, .5            ' Output annoying sound
END IF

END SUB

SUB MainProgram (Puzzles$(), P)

Start:

DO
  LOCATE 1, 2: COLOR 10: PRINT "$";
  PRINT USING "###,###"; PlayerMoney
                      
  LOCATE 2, 4: COLOR 7: PRINT "SPIN WHEEL     BUY VOWEL     SOLVE"
  LOCATE 2, 2: COLOR 12: PRINT CHR$(16); " ";
  COLOR 15: PRINT "SPIN WHEEL"
  Current = 1

  DO
    DO
      A$ = INKEY$
    LOOP UNTIL A$ <> ""
    IF LEN(A$) = 2 THEN Char = -ASC(RIGHT$(A$, 1)) ELSE Char = ASC(A$)
    SELECT CASE Char
      CASE 13        ' ENTER Pressed
        EXIT DO
      CASE -77       ' Right Arrow key pressed
        Current = Current + 1
      CASE -75       ' Left Arrow key pressed
        Current = Current - 1
      CASE 27        ' Escape key pressed
        END
    END SELECT
    LOCATE 2, 2: COLOR 7: PRINT "  SPIN WHEEL     BUY VOWEL     SOLVE"
    IF Current = 4 THEN Current = 1
    IF Current = 0 THEN Current = 3
    SELECT CASE Current
      CASE 1
        LOCATE 2, 2: COLOR 12: PRINT CHR$(16); " ";
        COLOR 15: PRINT "SPIN WHEEL"
      CASE 2
        LOCATE 2, 17: COLOR 12: PRINT CHR$(16); " ";
        COLOR 15: PRINT "BUY VOWEL"
      CASE 3
        LOCATE 2, 31: COLOR 12: PRINT CHR$(16); " ";
        COLOR 15: PRINT "SOLVE"
    END SELECT
  LOOP

  IF Current = 1 THEN SpinWheel
  IF Current = 2 THEN GOTO PickVowel
  IF Current = 3 THEN GOTO SolvePuzzle

  IF Money = 0 OR Money = -1 THEN
    IF Players = 1 THEN GOTO Start ELSE EXIT SUB
  END IF
  LOCATE 2, 1: PRINT SPACE$(40)
  LOCATE 2, 18: PRINT "$" + LTRIM$(STR$(Money))

  X = 28: Y = 149
  LINE (X, Y)-(X + 14, Y + 12), 10, B

  DO
    DO
      A$ = INKEY$
    LOOP UNTIL A$ <> ""
    IF LEN(A$) = 2 THEN Char = -ASC(RIGHT$(A$, 1)) ELSE Char = ASC(A$)
    IF Y = 165 AND X > 156 THEN
      LINE (172, Y)-(218, Y + 12), 0, B
    ELSE
      LINE (X, Y)-(X + 14, Y + 12), 0, B
    END IF
    SELECT CASE Char
      CASE 65 TO 122                     ' User typed in letter with keyboard
        Letter$ = UCASE$(CHR$(Char))
        A = INSTR(InCase$, Letter$)
        IF A THEN
          IF A <> LEN(InCase$) THEN
            InCase$ = LEFT$(InCase$, A - 1) + MID$(InCase$, A + 1, LEN(InCase$))
          ELSE
            InCase$ = LEFT$(InCase$, A - 1)
          END IF
          A = INSTR(TypeConst$, Letter$)   ' Refer to SUB DrawGrid for variable
          COLOR 3                          ' representation of TypeConst$
          IF A > 12 THEN
            LOCATE 22, (A - 12) * 2 + 3: PRINT Letter$
          ELSE
            LOCATE 20, (2 * A) + 3: PRINT Letter$
          END IF
        ELSE
          Letter$ = ""
        END IF
        IF Letter$ <> "" THEN
          LetterInPuzzle Letter$, 0
          IF Players > 1 AND InPuzzle = False THEN GOTO EndSel
          GOTO Start
        END IF
      CASE 13    ' Consonant Selected
        GOSUB SelLetter
        IF Letter$ <> "" THEN GOTO Start
      CASE 27    ' Escape Key
        END
      CASE -80   ' Down Arrow Key
        IF Y = 165 THEN Y = 149 ELSE Y = Y + 16
      CASE -77   ' Right Arrow Key
        IF X <> 204 THEN X = X + 16 ELSE X = 28
      CASE -75   ' Left Arrow Key
        IF X <> 28 THEN X = X - 16 ELSE X = 204
      CASE -72   ' Up Arrow Key
        IF Y = 149 THEN Y = 165 ELSE Y = Y - 16
    END SELECT
    IF Y = 165 AND X > 156 THEN
      LINE (172, Y)-(218, Y + 12), 10, B
      X = 172
    ELSE
      LINE (X, Y)-(X + 14, Y + 12), 10, B
    END IF
  LOOP
LOOP

PickVowel:
  IF PlayerMoney < 250 THEN    ' NOT enough money to buy vowel
    LOCATE 2, 1: PRINT SPACE$(40)
    LOCATE 2, 11: COLOR 12: PRINT "VOWEL'S COST $250"
    Pause 2
    GOTO Start
  END IF
  X = 244: Y = 149
  LINE (X, Y)-(X + 14, Y + 12), 10, B
  DO
    DO
      A$ = INKEY$
    LOOP UNTIL A$ <> ""
    IF LEN(A$) = 2 THEN Char = -ASC(RIGHT$(A$, 1)) ELSE Char = ASC(A$)
    LINE (X, Y)-(X + 14, Y + 12), 0, B
    SELECT CASE Char
      CASE 65 TO 122                     ' User typed in vowel with keyboard
        Letter$ = UCASE$(CHR$(Char))
        A = INSTR(InCaseVowel$, Letter$)
        IF A THEN
          IF A <> LEN(InCaseVowel$) THEN
            A$ = MID$(InCaseVowel$, A + 1, LEN(InCaseVowel$))
            InCaseVowel$ = LEFT$(InCaseVowel$, A - 1) + A$
          ELSE
            InCaseVowel$ = LEFT$(InCaseVowel$, A - 1)
          END IF
          A = INSTR(TypeVowel$, Letter$)   ' Refer to SUB DrawGrid for variable
          COLOR 3                          ' representation of TypeVowel$
          IF A > 3 THEN
            LOCATE 22, (A - 3) * 2 + 30: PRINT Letter$
          ELSE
            LOCATE 20, (2 * A) + 30: PRINT Letter$
          END IF
        ELSE
          Letter$ = ""
        END IF
        IF Letter$ <> "" THEN
          LetterInPuzzle Letter$, 1
          IF Players > 1 AND InPuzzle = False THEN GOTO EndSel
          GOTO Start
        END IF
      CASE 13    ' Vowel Selected
        GOSUB SelVowel
        IF Letter$ <> "" THEN GOTO Start
      CASE 27    ' Escape Key
        END
      CASE -80   ' Down Arrow Key
        IF X <> 276 THEN
          IF Y = 165 THEN Y = 149 ELSE Y = Y + 16
        END IF
      CASE -77   ' Right Arrow Key
        IF X <> 276 THEN X = X + 16 ELSE X = 244
        IF Y = 165 AND X = 276 THEN X = 244
      CASE -75   ' Left Arrow Key
        IF X <> 244 THEN X = X - 16 ELSE X = 276
      CASE -72   ' Up Arrow Key
        IF X <> 276 THEN
          IF Y = 149 THEN Y = 165 ELSE Y = Y - 16
        END IF
    END SELECT
    LINE (X, Y)-(X + 14, Y + 12), 10, B
  LOOP

SelVowel:
  IF Y = 149 THEN
    SELECT CASE X
      CASE 244
        Letter$ = "A"
      CASE 260
        Letter$ = "E"
      CASE 276
        Letter$ = "I"
    END SELECT
    COLOR 3
    LOCATE 20, (X - 244) / 16 + 32 + (X - 244) / 16: PRINT Letter$
  ELSE
    SELECT CASE X
      CASE 244
        Letter$ = "O"
      CASE 260
        Letter$ = "U"
    END SELECT
    COLOR 3
    LOCATE 22, (X - 244) / 16 + 32 + (X - 244) / 16: PRINT Letter$
  END IF
  A = INSTR(InCaseVowel$, Letter$)      ' Make sure vowel has not been picked
  IF A THEN
    A$ = MID$(InCaseVowel$, A + 1, LEN(InCaseVowel$))
    InCaseVowel$ = LEFT$(InCaseVowel$, A - 1) + A$
  ELSE
    Letter$ = ""                        ' Vowel already picked
  END IF
  IF Letter$ <> "" THEN                 ' Vowel has NOT been picked
    LetterInPuzzle Letter$, 1           ' Place vowel in puzzle
    IF Players > 1 AND InPuzzle = False THEN GOTO EndSel
  END IF
GOTO Start

SelLetter:
  IF Y = 149 THEN
    SELECT CASE X
      CASE 28
        Letter$ = "B"
      CASE 44
        Letter$ = "C"
      CASE 60
        Letter$ = "D"
      CASE 76
        Letter$ = "F"
      CASE 92
        Letter$ = "G"
      CASE 108
        Letter$ = "H"
      CASE 124
        Letter$ = "J"
      CASE 140
        Letter$ = "K"
      CASE 156
        Letter$ = "L"
      CASE 172
        Letter$ = "M"
      CASE 188
        Letter$ = "N"
      CASE 204
        Letter$ = "P"
    END SELECT
    COLOR 3
    LOCATE 20, (X - 28) / 16 + 5 + (X - 28) / 16: PRINT Letter$
  ELSE
    SELECT CASE X
      CASE 28
        Letter$ = "Q"
      CASE 44
        Letter$ = "R"
      CASE 60
        Letter$ = "S"
      CASE 76
        Letter$ = "T"
      CASE 92
        Letter$ = "V"
      CASE 108
        Letter$ = "W"
      CASE 124
        Letter$ = "X"
      CASE 140
        Letter$ = "Y"
      CASE 156
        Letter$ = "Z"
      CASE 172
        Letter$ = "QUIT"
        END
    END SELECT
    COLOR 3
    LOCATE 22, (X - 28) / 16 + 5 + ((X - 28) / 16): PRINT Letter$
  END IF
  A = INSTR(InCase$, Letter$)          ' Make sure Consonant has not been picked
  IF A THEN
    IF A <> LEN(InCase$) THEN
      InCase$ = LEFT$(InCase$, A - 1) + MID$(InCase$, A + 1, LEN(InCase$))
    ELSE
      InCase$ = LEFT$(InCase$, A - 1)
    END IF
  ELSE
    Letter$ = ""                       ' Consonant has already been picked
  END IF
  IF Letter$ <> "" THEN                ' Consonant has NOT been picked
    LetterInPuzzle Letter$, 0          ' Place consonant in puzzle
    IF Players > 1 AND InPuzzle = False THEN GOTO EndSel
  END IF
RETURN

SolvePuzzle:
  PCOPY 0, 2
  LINE (0, 199)-(320, 150), 0, BF
  LOCATE 20, 1: PRINT "SOLVE:"
  Solve$ = ""
  Last = False
  FOR Q = 2 TO 7
    IF Puzz$(Q) <> "EMPTY" THEN
      IF RIGHT$(Puzz$(Q), 1) = "-" THEN Last = True
        IF Last = False THEN
          Solve$ = Solve$ + LTRIM$(Puzz$(Q)) + " "
        ELSE
          Solve$ = Solve$ + LTRIM$(Puzz$(Q))
          Last = False
        END IF
    END IF
  NEXT Q
  Solve$ = RTRIM$(Solve$)
  A = INSTR(Solve$, "?")
  DO WHILE A
    IF A = 1 THEN
      Solve$ = MID$(Solve$, A + 2, LEN(Solve$))
    ELSE
      Solve$ = RTRIM$(LEFT$(Solve$, A - 1)) + " " + MID$(Solve$, A + 2, LEN(Solve$))
    END IF
    A = INSTR(Solve$, "?")
  LOOP
  Solve$ = LTRIM$(RTRIM$(Solve$))
  LOCATE 22, 1
  FOR Q = 1 TO LEN(Solve$)
    COLOR 14
    A = ASC(MID$(Solve$, Q, 1))
    SELECT CASE A
      CASE 38     ' & sign
        COLOR 10
        PRINT "&";
      CASE 39     ' Apostrophe
        COLOR 10
        PRINT "'";
      CASE 45
        COLOR 10
        PRINT "-";
      CASE 32
        PRINT " ";
      CASE ELSE
        PRINT "љ";
    END SELECT
  NEXT Q
  LOCATE 22, 1: COLOR 15: LINE INPUT Answer$
  IF UCASE$(Answer$) = UCASE$(Solve$) THEN
    Finish = True
    SELECT CASE Turn
      CASE 1
        IF P1Money = 0 THEN P1Money = 200
        M1P = M1P + P1Money + PlayerMoney
      CASE 2
        IF P2Money = 0 THEN P2Money = 200
        M2P = M2P + P2Money + PlayerMoney
      CASE 3
        IF P3Money = 0 THEN P3Money = 200
        M3P = M3P + P3Money + PlayerMoney
    END SELECT
    P1Money = 0: P2Money = 0: P3Money = 0
    AllCase$ = InCase$ + InCaseVowel$
    FOR Q = 1 TO LEN(AllCase$)
      A$ = MID$(AllCase$, Q, 1)
      IF INSTR(UCASE$(Solve$), A$) THEN LetterInPuzzle A$, 0
    NEXT Q
    IF Puzz$(1) = "BLANK" OR Puzz$(1) = "CLUE" THEN
      LINE (0, 199)-(320, 150), 0, BF
      LOCATE 20, 1: COLOR 10: PRINT "CLUE:"
      LOCATE 22, 1: COLOR 15: LINE INPUT Clue$
      IF UCASE$(Clue$) = Puzz$(8) THEN
        LOCATE 20, 1: PRINT "EXCELLENT!!!"
        SELECT CASE Turn
          CASE 1
            M1P = M1P + 500
          CASE 2
            M2P = M2P + 500
          CASE 3
            M3P = M3P + 500
        END SELECT
      ELSE
        LOCATE 20, 1: COLOR 10: PRINT "TOO BAD, THE CLUE WAS ";
        COLOR 12: PRINT Puzz$(8)
      END IF
     END IF
     Pause 1.5
  ELSE
    SOUND 1000, .5: SOUND 500, .5
    PCOPY 2, 0
  END IF

EndSel:
END SUB

SUB Pause (Secs!)

' Pause for specified amount of seconds, or until user hits a key,

T! = TIMER
DO
LOOP UNTIL TIMER - T! > Secs! OR INKEY$ <> ""

END SUB

SUB ShowLeader

PCOPY 1, 0   ' Restore saved image on hidden page 1 to active page 0

    Word$ = "$" + LTRIM$(STR$(M1P))
    XCor = 30 - ((LEN(Word$) - 2) * 4)
    PAINT (10, 140), 4, 15
    BigChar Word$, XCor, 130 + LEN(Word$) - 2, 11, 1
  IF Players > 1 THEN
    Word$ = "$" + LTRIM$(STR$(M2P))
    XCor = 140 - ((LEN(Word$) - 2) * 4)
    PAINT (150, 130), 1, 15
    BigChar Word$, XCor, 119, 11, 0
  END IF
  IF Players = 3 THEN
    Word$ = "$" + LTRIM$(STR$(M3P))
    XCor = 250 - ((LEN(Word$) - 2) * 2)
    PAINT (250, 140), 2, 15
    BigChar Word$, XCor, 126, 11, 2
  END IF

LOCATE 24, 13: COLOR 15: PRINT "After"; Rn - 1; "Rounds...    ";

Pause 3

END SUB

SUB ShowMarge (L, M, StartX, MargeY, Zz)
       
      PCOPY 0, 2
      IF M > StartX THEN
        S = MD                     ' Forward motion.
      ELSE
        S = -MD                    ' MOON WALK!  Backward motion.
      END IF
      FOR X = StartX TO M STEP S   ' Increase "S" delay if your CPU is slow
        Zz = NOT Zz                ' Up and Down Motion
        DrawMarge X, MargeY + Zz   ' Draw Marge!
        PCOPY 0, 3                 ' Display image on visual page 3
        PCOPY 2, 0                 ' Switch back to original (GRID) template
      NEXT X
      IF L < 80 THEN               ' Upper arm
        LINE (X - 3, 90)-(X + 20, L - 5), 8
        LINE (X + 5, 90)-(X + 25, L), 8
        LINE (X - 3, 90)-(X + 5, 90), 8
        LINE (X + 20, L - 5)-(X + 25, L), 8
        PAINT (X, 88), 6, 8
        PAINT (X, 88), 14, 8
        'CIRCLE (X + 25, L - 3), 4, 8     ' Draw her hands
        'PAINT (X + 25, L - 3), 14, 8     ' Pretty nasty looking
        'CIRCLE (X + 25, L - 3), 4, 14    '   so I'm omitting it
        DrawMarge X, MargeY + Zz          ' Draw Marge Again
        PCOPY 0, 3
        PCOPY 2, 0
      ELSE                         ' Lower arm
        LINE (X - 3, 90)-(X + 20, L + 5), 8
        LINE (X + 5, 90)-(X + 25, L), 8
        LINE (X - 3, 90)-(X + 5, 90), 8
        LINE (X + 20, L + 5)-(X + 25, L), 8
        PAINT (X + 1, 92), 6, 8
        PAINT (X + 1, 92), 14, 8
        'CIRCLE (X + 25, L + 3), 4, 8     ' Draw her hands
        'PAINT (X + 25, L + 3), 14, 8
        'CIRCLE (X + 25, L + 3), 4, 14
        DrawMarge X, MargeY + Zz          ' Draw Marge Again
        PCOPY 0, 3
        PCOPY 2, 0
      END IF
      StartX = X                   ' Save Marge's X-Position

END SUB

SUB ShowPlayers

PCOPY 0, 2  ' Save image on active page 0 to hidden page 2
PCOPY 1, 0  ' Restore image on hidden page 1 to active page 0

SELECT CASE Turn
  CASE 1
    P1Money = P1Money + PlayerMoney
    Word$ = "$" + LTRIM$(STR$(P1Money))
    XCor = 30 - ((LEN(Word$) - 2) * 4)
    PAINT (10, 140), 4, 15
    BigChar Word$, XCor, 130 + LEN(Word$) - 2, 11, 1
  CASE 2
    P2Money = P2Money + PlayerMoney
    Word$ = "$" + LTRIM$(STR$(P2Money))
    XCor = 140 - ((LEN(Word$) - 2) * 4)
    PAINT (150, 130), 1, 15
    BigChar Word$, XCor, 119, 11, 0
  CASE 3
    IF Players = 3 THEN
      P3Money = P3Money + PlayerMoney
      Word$ = "$" + LTRIM$(STR$(P3Money))
      XCor = 250 - ((LEN(Word$) - 2) * 2)
      PAINT (250, 140), 2, 15
      BigChar Word$, XCor, 126, 11, 2
    END IF
END SELECT

Turn = Turn + 1
IF Players = 2 AND Turn = 3 THEN Turn = 1
IF Players = 3 AND Turn = 4 THEN Turn = 1

LOCATE 24, 15: COLOR 14: PRINT "Round"; Rn; "of"; Rounds;

PCOPY 0, 1  ' Save hidden page 1 to active page 0

WhoseTurn

PCOPY 2, 0  ' Restore hidden page 2 to active page 0

END SUB

SUB SpinWheel

PCOPY 0, 2

IF Spw = 0 THEN    ' Wheel has not been spun yet
  DrawWheel        ' Initialize wheel
  Spw = 1          ' No need to draw wheel again
  WheelX = 1
  WheelN = 1
ELSE               ' Wheel has already been drawn for us
  PCOPY 4, 0       ' Redisplay wheel previously drawn
END IF

SELECT CASE Turn
  CASE 1
    Colr = 12
  CASE 2
    Colr = 9
  CASE 3
    Colr = 10
END SELECT

LOCATE 14, 1: COLOR Colr: PRINT CHR$(16)

LOCATE 1, 1: PRINT SPACE$(40)
LOCATE 1, 1: COLOR 15: PRINT "SPIN POWER: "; : COLOR Colr: PRINT "лллллллллл"
I = 23: M = 0
DO
  IF I < 40 AND M = 1 THEN I = I + 1: LOCATE 1, I: PRINT "л"
  IF I = 40 THEN M = 0
  T! = TIMER                   ' Pause for one hundreth of a second
  DO                           ' but more like just a tenth of one
  LOOP UNTIL TIMER - T! > .01
  IF I > 12 AND M = 0 THEN I = I - 1: LOCATE 1, I: PRINT "  "
  IF I = 12 THEN M = 1
LOOP UNTIL INKEY$ <> ""        ' Stop meter once a key is pressed

M = I - 5      ' Calculate SpinPOWER
WheelY = 1

PCOPY 0, 4

SCREEN 7, 0, 0, 4

DO
  WheelX = WheelX - 1                 ' Explaining this phenomena
  IF WheelX = 0 THEN WheelX = 14      ' I call "WHAT THE HECK IS THIS"
  PAINT (160, 60), WheelX, 15         ' can not be put into BASIC terms
  WheelX = WheelX - 1                 ' but who cares how it works, just
  IF WheelX = 0 THEN WheelX = 14      ' know that it does.
  PAINT (140, 60), WheelX, 15
  WheelX = WheelX - 1                 ' WheelX = Color  (1-14)
  IF WheelX = 0 THEN WheelX = 14      ' WheelX <> 0 or 15
  PAINT (120, 70), WheelX, 15
  WheelX = WheelX - 1                 ' Simplicity is not my style obviously
  IF WheelX = 0 THEN WheelX = 14      ' but I couldn't find another "easy"
  PAINT (100, 70), WheelX, 15         ' way to create a real looking wheel
  SOUND 37, 1
  WheelX = WheelX - 1                 ' that actually rotates properly.
  IF WheelX = 0 THEN WheelX = 14      ' Actually, it just looks like it
  PAINT (80, 90), WheelX, 15          ' rotates properly because the color
  WheelX = WheelX - 1                 ' is in sequence.
  IF WheelX = 0 THEN WheelX = 14      ' Now if anyone knows how to create
  PAINT (80, 105), WheelX, 15         ' 3-D looking wheel, GIMME GIMME!
  WheelX = WheelX - 1                 ' Well, I've tried with Rich Geldreich's
  IF WheelX = 0 THEN WheelX = 14      ' example, but couldn't grasp the
  PAINT (90, 120), WheelX, 15         ' fundamentals.
  WheelX = WheelX - 1
  IF WheelX = 0 THEN WheelX = 14
  PAINT (90, 130), WheelX, 15
  WheelX = WheelX - 1
  IF WheelX = 0 THEN WheelX = 14
  PAINT (110, 140), WheelX, 15
  WheelX = WheelX - 1
  IF WheelX = 0 THEN WheelX = 14
  PAINT (140, 145), WheelX, 15
  WheelX = WheelX - 1
  IF WheelX = 0 THEN WheelX = 14
  PAINT (170, 145), WheelX, 15
  WheelX = WheelX - 1
  IF WheelX = 0 THEN WheelX = 14
  PAINT (210, 145), WheelX, 15
  WheelX = WheelX - 1
  IF WheelX = 0 THEN WheelX = 14
  PAINT (245, 130), WheelX, 15
  WheelX = WheelX - 1
  IF WheelX = 0 THEN WheelX = 14
  PAINT (270, 110), WheelX, 15
  WheelX = WheelX - 1
  IF WheelX = 0 THEN WheelX = 14
  PAINT (290, 95), WheelX, 15
  WheelX = WheelX - 1
  IF WheelX = 0 THEN WheelX = 14
  PAINT (280, 80), WheelX, 15
  WheelX = WheelX - 1
  IF WheelX = 0 THEN WheelX = 14
  PAINT (250, 60), WheelX, 15
  WheelX = WheelX - 1
  IF WheelX = 0 THEN WheelX = 14
  PAINT (220, 50), WheelX, 15
  WheelX = WheelN
  WheelY = WheelY + 1
  WheelN = WheelN + 1
  IF WheelN = 16 THEN WheelN = 1
  Col = POINT(50, 100)  ' Where the WHEEL stops, calculate the color
  ColorCode Col         ' Mr. Computer, what is the color code?
  PCOPY 0, 4
LOOP UNTIL WheelY = M   ' Wheel spins until power is expiated
SCREEN 7, 0, 0, 0       ' Restore screen

IF Money = 0 OR Money = -1 THEN SOUND 1000, .5: SOUND 500, .5

Pause 3                 ' Pause for three whole seconds or until user
                        ' hits a key

PCOPY 2, 0
IF Money = -1 THEN PlayerMoney = 0

SELECT CASE Turn
  CASE 1
    P1Money = 0
  CASE 2
    P2Money = 0
  CASE 3
    P3Money = 0
END SELECT

END SUB

SUB WhoseTurn

SELECT CASE Turn
  CASE 1
    DO
      FOR X = 1 TO 15
        PALETTE 12, X          ' Flash color of user's turn
      NEXT X
    LOOP UNTIL INKEY$ <> ""
    PALETTE 12, 12
    PlayerMoney = P1Money
  CASE 2
    DO
      FOR X = 1 TO 15
        PALETTE 9, X
      NEXT X
    LOOP UNTIL INKEY$ <> ""
    PALETTE 9, 9
    PlayerMoney = P2Money
  CASE 3
    DO
      FOR X = 1 TO 15
        PALETTE 10, X
      NEXT X
    LOOP UNTIL INKEY$ <> ""
    PALETTE 10, 10
    PlayerMoney = P3Money
END SELECT

DO
LOOP UNTIL INKEY$ = ""

END SUB

