DECLARE SUB ending ()
DECLARE SUB intro ()
DECLARE SUB playgame ()
DECLARE SUB instructions ()
DECLARE SUB createmines ()
DECLARE SUB erasetank (X AS INTEGER, y AS INTEGER)    'Declare procedures
DECLARE SUB drawtank (X AS INTEGER, y AS INTEGER)

DIM SHARED minefield(1 TO 30, 1 TO 23) AS INTEGER     'mine locations
DIM a$

intro
instructions

DO
  playgame
  CLS
  INPUT "Do you want to play again? (y/n) "; a$
  IF UCASE$(LEFT$(a$, 1)) <> "Y" THEN EXIT DO
LOOP

ending
SYSTEM

SUB createmines
 
  DIM loopa AS INTEGER
  DIM bombx AS INTEGER
  DIM bomby AS INTEGER
  DIM minepoint AS INTEGER
  DIM screenpoint AS INTEGER
 
  CONST nummines = 200               'Change to make harder

  RANDOMIZE TIMER

  FOR loopx = 1 TO 30
    FOR loopy = 1 TO 23
      minefield(loopx, loopy) = 0
    NEXT loopy
  NEXT loopx
 
  FOR loopa = 1 TO nummines
    DO
      bombx = INT(RND * 29 + 1)
      bomby = INT(RND * 22 + 1)
      minepoint = minefield(bombx, bomby)
      screenpoint = SCREEN(bomby, bombx) 'same crap as LOCATE
    LOOP UNTIL ((screenpoint <> 35) AND (screenpoint <> 177)) AND (minepoint = 0) AND ((bombx <> 2) AND (bomby <> 2))
    minefield(bombx, bomby) = 1
    'LOCATE bomby, bombx   'uncomment to show bomb locations
    'PRINT "$"
  NEXT loopa

END SUB

SUB drawtank (X AS INTEGER, y AS INTEGER)
  LOCATE y, X                     'Things are slightly reversed when
  PRINT CHR$(1)                   'you draw it in text mode
END SUB

SUB ending

CLS
PRINT "1996 OmletteSoft is:"
PRINT "* Amit Jain (Omlette) - President"
PRINT "* Andre Rivera (Silky) - Programmer"
PRINT "* Chirag Mehta (Huge@$$) - We're sure he does something"
PRINT "* Ankit Shah (Speedy) - Beta Tester"
PRINT "* Rodrigo Salcedo (Julian Taim)  - Beta tester"
PRINT "* Jose Lopez (DJ 3-D IBM Mac Daddy) - Animation"
PRINT
PRINT "Too many people to give thanks to:"
PRINT "* God"
PRINT "* Our parents"
PRINT "* Many others.  Big ups to everyone.  Your names are on the web site."
PRINT
PRINT "Contact OmletteSoft at:"
PRINT "* http://pages.prodigy.com/omlettesoft/"
PRINT "* ajain@cnct.com"
PRINT "* WLKY80A@prodigy.com"

SLEEP
CLS

PRINT "  Mine Avoider is based on the Minehunt game featured in HP's Graphing"
PRINT "Calculators.  The QBasic code contained here is complete freeware.  We"
PRINT "hope you'll learn something from it, do something cooler, and show it"
PRINT "to us.  I hate saying this but, here goes:  I, AMIT JAIN, THE AUTHOR"
PRINT "OF THIS PROGRAM, AM IN NO WAY RESPONSIBLE FOR ANY DAMAGE IT DOES TO"
PRINT "YOU, YOUR COMPUTER, YOUR PETS, YOUR SANITY, etc.  It probably won't"
PRINT "harm you so calm down.  There is no warrenty on this source code,"
PRINT "either implied or otherwise.  This program is Copyright (C) 1996 Amit"
PRINT "Jain."
PRINT
PRINT "                                 -X-COM-mander Omlette"
PRINT "                                 http://pages.prodigy.com/omlettesoft/"

END SUB

SUB erasetank (X AS INTEGER, y AS INTEGER)
  LOCATE y, X                     'Things are slightly reversed when
  PRINT " "                   'you draw it in text mode
END SUB

SUB instructions

  CLS
  PRINT "  Welcome to Mine Avoider!  The latest game from 1996 OmletteSoft."
  PRINT "You are in a little tank, represented by a"; CHR$(1); ".  The"
  PRINT "object of the game is to make it to your base, which is indicated by"
  PRINT "a "; CHR$(177); ".  You receive a point for every square you cross"
  PRINT "that doesn't contain a mine.  Step on one that does, and it's all"
  PRINT "over for you.  The number of mines you are near is indicated at the"
  PRINT "top right of your screen.  Use the NUMERIC KEYPAD to move around,"
  PRINT "or press ESC to quit.  Here's a little tip:  The topmost row and the"
  PRINT "leftmost column almost never have any mines in them.  Good luck"
  DO: LOOP UNTIL INKEY$ <> ""

END SUB

SUB intro

DIM now AS SINGLE
DIM introy AS INTEGER

FOR introy = 1 TO 13
  LOCATE introy, 30
  PRINT "OmletteSoft Presents"
  now = TIMER
  waittime = .1
  WHILE (TIMER - .1) < now
  WEND
  IF introy <> 13 THEN CLS
NEXT introy
BEEP
CLS
LOCATE 13, 35
PRINT "Mine Avoider"
SLEEP

END SUB

SUB playgame

'Declare variables
DIM loopx AS INTEGER
DIM loopy  AS INTEGER                          'loop counters
DIM tankx AS INTEGER
DIM tanky AS INTEGER                           'your location
DIM basex AS INTEGER
DIM basey AS INTEGER                           'The base location
DIM score AS INTEGER
DIM nearmines AS INTEGER                              'how many mines are
                                                      'near you

CONST fieldwall$ = "##############################"  'to draw the
CONST fieldarea$ = "#лллллллллллллллллллллллллллл#"  'playing field

tankx = 2                                             'variables
tanky = 2
basex = 27
basey = 21
score = 0
nearmines = 0

CLS
PRINT fieldwall$     'Draw the playing field
FOR loopx = 2 TO 22  'Initialize inside of playing field
  PRINT fieldarea$
NEXT loopx
PRINT fieldwall$
LOCATE basey, basex        'Draw your home base
PRINT CHR$(177)

erasetank tankx, tanky     'Place everything
drawtank tankx, tanky
createmines                'Put the mines in their proper places
LOCATE 1, 50               'Your initial score
PRINT "Score: "; score

DO

  nearmines = 0            'Reset value

  FOR loopx = tankx - 1 TO tankx + 1
    FOR loopy = tanky - 1 TO tanky + 1
      IF minefield(loopx, loopy) = 1 THEN nearmines = nearmines + 1
    NEXT loopy
  NEXT loopx

  LOCATE 2, 50
  PRINT "You are near"; nearmines; "mines."

  SLEEP
  KEY(10) OFF
  erasetank tankx, tanky
  a$ = INKEY$

  SELECT CASE a$            'Handle keyboard input
    CASE "8"                'up
      IF SCREEN(tanky - 1, tankx) <> 35 THEN tanky = tanky - 1
    CASE "2"                'down
      IF SCREEN(tanky + 1, tankx) <> 35 THEN tanky = tanky + 1
    CASE "4"                'left
      IF SCREEN(tanky, tankx - 1) <> 35 THEN tankx = tankx - 1
    CASE "6"                'right
      IF SCREEN(tanky, tankx + 1) <> 35 THEN tankx = tankx + 1
    CASE "9"                'up right
      IF SCREEN(tanky - 1, tankx + 1) <> 35 THEN
        tankx = tankx + 1
        tanky = tanky - 1
      END IF
    CASE "7"                'up left
      IF SCREEN(tanky - 1, tankx - 1) <> 35 THEN
        tankx = tankx - 1
        tanky = tanky - 1
      END IF
    CASE "1"                'down left
      IF SCREEN(tanky + 1, tankx - 1) <> 35 THEN
        tankx = tankx - 1
        tanky = tanky + 1
      END IF
    CASE "3"                'down right
      IF SCREEN(tanky + 1, tankx + 1) <> 35 THEN
        tankx = tankx + 1
        tanky = tanky + 1
      END IF
  END SELECT
  KEY(10) ON

  IF minefield(tankx, tanky) = 1 THEN 'Did you trip a mine?
    
    FOR loopx = 1 TO 30                    'Draw all the mines
      FOR loopy = 1 TO 23
        IF minefield(loopx, loopy) = 1 THEN
          LOCATE loopy, loopx
          PRINT "$"
        END IF
      NEXT loopy
    NEXT loopx
   
    LOCATE tanky, tankx                     'print a dead tank
    PRINT CHR$(2)
    LOCATE 2, 50
    PRINT "Fool!  You ran into a mine!!!"
    LOCATE 3, 50
    PRINT "Press any key to continue"
    SLEEP
    EXIT SUB
 
  ELSE
   
    IF SCREEN(tanky, tankx) = 219 THEN score = score + 1
 
  END IF
 
  IF SCREEN(tanky, tankx) = 177 THEN  'Did you win?
    LOCATE tanky, tankx
    PRINT CHR$(2)
    LOCATE 2, 50
    PRINT "You made it!!!               "
    LOCATE 3, 50
    PRINT "Congratulations!!!!!"
    LOCATE 4, 50
    PRINT "Press any key to continue"
    SLEEP
    EXIT SUB
  END IF

  LOCATE 1, 50
  PRINT "Score: "; score
  drawtank tankx, tanky

LOOP UNTIL a$ = CHR$(27)
CLS
PRINT "  YOU QUITTER!!  YOU COULD HAVE AT LEAST LOST!!!!!  HOW COULD YOU JUST"
PRINT "QUIT LIKE THAT?!?!?!?!  DON'T YOU HAVE ANY BACKBONE?!?!?!?!?!?!?"
PRINT "Press any key to continue"
SLEEP

END SUB

