'****************************************************************************
'*                          IDENTIFICATION                                  *
'*                                                                          *
'*                NAME:       Steven Hanov (hanovs@wchat.on.ca)             *
'*                PROGRAM:    a:\class.bas                                  *            *
'*                SCHOOL:     Cardinal Newman C. S. S.                      *
'*                TEACHER:    The teacher formerly known as Mrs. Gotovac.   *
'*                COMPUTER:   IBM/MS-DOS                                    *
'*                LANGUAGE:   QBASIC                                        *
'*                PLANET:     Earth (Sol-III)                               *
'*                PERIOD:     LATE 20th CENTURY (Gregorian Calender)        *
'*                CLASS:      DPT 3A1 Period 2                              *
'*                DATE:       96/06/12                                      *
'*                                                                          *
'****************************************************************************

'****************************************************************************
'*                       PROGRAM ANALYSIS                                   *
'*                                                                          *
'* In the 1980s, when the dinosaurs ruled the earth, we all used computers  *
'* like the Commodore 64. It was great for games, and one game I liked was  *
'* JUMPMAN (By EPYX MegaGames). This program is a re-creation of what I     *
'* remember of the game. It has four levels, and is not entirely accurate.  *
'* However, it presented a unique programming challenge that I was not      *
'* entirely confident that I could meet. But after many hours of work, both *
'* in and out of class, the project is finally completed.                   *
'*                                                                          *
'* The object of the game is to pick up all of the brown "bombs".           *
'* Occasionally, white SmartDarts will fire at you from the sides of the    *
'* screen. To move, make sure the numeric keypad is ON. The controls are    *
'* on the keypad, and should be obvious. 8, 6, 2, and 4 move up, right,     *
'* down, and left, respectively. 7 and 8, and 9 are also used to jump.      *
'*                                                                          *
'* One problem I had was speed; on a slow computer the character moves      *
'* fine, but on a fast computer the gameplay is impossible. I surmounted    *
'* this difficulty with the speed option in the introductory screen.        *
'* On the school's computers, a value of one to three should be used. This  *
'* value is used to control the speed of both the character and the         *
'* SmartDart.                                                               *
'*                                                                          *
'* Enjoy!                                                                   *
'*                                                                          *
'****************************************************************************
DECLARE SUB HighScores ()
DECLARE SUB paldef (c!, r!, g!, B!)
DECLARE SUB ClearKeyBuffer (n!)
DECLARE SUB centre (y!, t$)
DECLARE SUB UpdateScore ()
DECLARE SUB Die ()
DECLARE SUB Bullet ()
DECLARE SUB pandisplay (xp!, yp!)
DECLARE SUB DrawGuy (x!, y!)
'****************************************************************************
'*                       VARIABLE DICTIONARY                                *
'****************************************************************************
DIM SHARED graph(1000), pf(40, 25) AS STRING, snd
DIM SHARED bgraph(100), x, y, xx, xy, DontDraw, lives, dead, bombs, Points
DIM SHARED DartSpeed, GuySpeed, Delay, ResetFlag, Bonus
DIM SHARED Score(15), Name$(15), TotalScore, FileName$

'NAME ***** DESCRIPTION ************************************************
'graph()    The image of the background behind the character is stored
'           in here, using the GET and PUT graphics commands.
'bgraph()   Likewise, but with the bullet.
'pf(x,y)    The current level is stored in here using the symbols explained
'           in the data statements.
'x,y        The current co-ordinate on the screen, in 8x8 units. The screen
'           is 40 units horizontally and 25 vertically.
'xx, xy     The true, pixel co-ordinate on the screen. Range: 320,200
'DontDraw   A flag for the DrawGuy sub telling it not to call the Bullet sub
'lives      Self explanatory
'dead       A flag that lets the main program know if the bullet has
'           contacted the player.
'bombs      The number of bombs remaining on the playing field.
'points     The number of bombs the player has picked up. Whenever it's
'           displayed, its multiplied by 100. The points are reset whenever
'           the player dies to make it more challenging.
'GuySpeed   Used in the DrawGuy sub in a delay loop to slow it down.
'DartSpeed  Derived from DrawGuy. Controls dart speed.
'Delay      This flag tells the bullet sub not to delay because it is
'           being called by the DrawGuy sub, which has already delayed.
'           This makes the two objects move at the same time more smoothly.
'ResetFlag  Tells the DrawGuy and Bullet subs to re-GET the background
'           that they're on (into the GRAPH and BGRAPH) on a level change
'           or else they'd draw a chunk of the old level on the new one.
'Bonus      Contains the time bonus remaining for the level.
'TotalScore Contains the total score in the game divided by 100.
'Score()
'Name$()    Used to read and sort the high scores from disk
'FileName$  The name and location of the score file.

'****************************************************************************
'*                              MAIN                                        *
'****************************************************************************
RANDOMIZE TIMER
KEY 15, CHR$(0) + CHR$(1) 'Defines Key# 15 = Esc
'ON KEY(15) GOSUB Ending    'ANYTIME user hits escape, gosub Ending.
ON TIMER(10) GOSUB DecrementBonus   'Sets up the timer - Every ten seconds,
                                    'you loose 100 time bonus.
TIMER OFF                           'But not right now.
KEY(15) ON
lives = 6
snd = 1       'Clicking sound on movement ON
rt$ = "6"     'Define RIGHT key
lt$ = "4"            'LEFT key
UP$ = "8"            'UP key
dn$ = "2"            'DOWN key
Delay = 1            'Delay on call bullet sub.
FileName$ = "SCORES.DAT"
SCREEN 13


y = 0: x = 0
FOR s = 1 TO 25
   READ l$
   x = 0
   FOR d = 1 TO 40
      a$ = MID$(l$, d, 1)
      IF a$ = "W" THEN             'Displays in the introductory screen
         c = 15                    'graphic, which is stored in DATA.
      ELSEIF a$ = "R" THEN         'It looks just like the old C=64 game!
         c = 4
      ELSEIF a$ = "M" THEN
         c = 5                     'R=RED square, M=magenta, C=cyan,
      ELSEIF a$ = "C" THEN         'Y=yellow, G=Green,B=Blue
         c = 3
      ELSEIF a$ = "Y" THEN
         c = 14
      ELSEIF a$ = "G" THEN
         c = 2
      ELSEIF a$ = "B" THEN
         c = 1
      ELSE
         c = 0
      END IF
      LINE (x, y)-(x + 7, y + 7), c, BF
      x = x + 8
   NEXT
   y = y + 8
NEXT


WHILE INKEY$ = "": WEND   'Wait for keypress
CALL HighScores           'Display HighScores
PLAY "mbt128 O3 C16 O1 c16"
CLS
COLOR 3
centre 2, "LeapGuy"
centre 4, "By Steven Hanov"
LOCATE 6: PRINT
COLOR 5
PRINT " Movement:"
COLOR 14
PRINT " 7   8   9     Make sure your numlock"
PRINT "               key is ON.  Use 7, 8, "
PRINT " 4       6     and 9 to jump left, up,"
PRINT "               or right."
PRINT "     2    "
LOCATE 19: COLOR 2
PRINT "Choose a speed for LeapGuy,"
PRINT "from 0 (fast) to 15 (slow):";
INPUT "", GuySpeed
'IF GuySpeed = 0 THEN GuySpeed = 8
GuySpeed = GuySpeed * 100
DartSpeed = GuySpeed \ 25
IF DartSpeed = 0 THEN DartSpeed = 10

NextLevel:
FOR y = 1 TO 25                   'Reads in the next level from DATA
   READ l$                        'and stores in pf(x,y)
   IF l$ = "STOP" THEN GOTO YouWon  'UNLESS there are no more levels.
   FOR x = 1 TO 40
      pf(x, y) = MID$(l$, x, 1)
   NEXT
NEXT
READ OriginalX, OriginalY       'Starting position for JumpGuy
ClearKeyBuffer 15           'A sub that stops a really annoying problem.
Bonus = 1000

ReDraw:
IF lives = 0 THEN          'IF the user has no life,
   TIMER OFF                          'Don't decrement the bonus anymore...
   PLAY "T128 MB O1 L4 c2 e2 g2 >c1"
   seconds = TIMER
   WHILE TIMER - seconds < 4          'Flash screen red and white for
      pandisplay 1, 0                 'four seconds.
      paldef 2, 63, 63, 63
      FOR d = 1 TO 100: NEXT
      pandisplay 0, 0                  'AND a cool earthquake effect
      paldef 2, 32, 0, 0             'with an OUT call I got from the 'Net
      FOR d = 1 TO 100: NEXT
   WEND
   paldef 2, 0, 32, 0             'Turn colour 2 from red to back to green
   PLAY "MBO3 C8 <G8 >C8 <G8 A#8 F8 A#8 F8"
   PLAY "G#8 D#8 G#8 MN G8 G#16 G"
   CALL HighScores
   END
END IF
x = 0: y = 0       'BUT if the user has a life, they can play...
bombs = 0
dead = 0
Delay = 1
CLS
FOR s = 1 TO 25                'Redraws the level stored in pf(x,y)
   FOR d = 1 TO LEN(l$)
      a$ = pf(d, s)      'YES, it is declared as a string...
      IF a$ = "=" THEN                'The girder/
         LINE (x, y)-(x + 8, y), 2
         LINE (x, y + 4)-(x + 8, y + 4), 2
         LINE (x + 2, y)-(x + 2, y + 4), 2
         LINE (x + 6, y)-(x + 6, y + 4), 2
      ELSEIF a$ = "#" THEN                   'The ladder.
         LINE (x - 4, y)-(x - 3, y + 8), 1, BF
         LINE (x - 4, y + 4)-(x + 12, y + 5), 1, BF
         LINE (x + 12, y)-(x + 11, y + 8), 1, BF
      ELSEIF a$ = "+" THEN                     'The rope
         LINE (x + 2, y)-(x + 3, y + 1), 2, BF
         LINE (x + 4, y + 2)-(x + 5, y + 3), 2, BF
         LINE (x + 2, y + 4)-(x + 3, y + 5), 2, BF
         LINE (x + 4, y + 6)-(x + 5, y + 7), 2, BF
      ELSEIF a$ = "o" THEN                      'The bomb
         CIRCLE (x + 4, y + 4), 2, 6
         bombs = bombs + 1
      END IF
      x = x + 8
   NEXT
   x = 0
   y = y + 8
NEXT
LINE (0, 290)-(320, 290), 5        'A line that won't show up I know not why


ReStart:
Points = 0
x = OriginalX
y = OriginalY
xx = x * 8
xy = y * 8
FOR s = 440 TO 600 STEP 10
   SOUND s, 1
NEXT
ResetFlag = 1
CALL DrawGuy(xx, xy)               'Displays guy for first time
ResetFlag = 0
TIMER ON                       'Turn on decrement time bonus event
CALL UpdateScore

DO
   a$ = ""
   snd = 1                     'Click sound on (movement)
   IF jump = 0 THEN            'If not in the middle of a jump,
      ClearKeyBuffer 5         'Clear keyboard buffer,
      DO
         a$ = INKEY$           'Get the keypress,
         CALL Bullet           'Move the bullet,
         IF dead = 1 THEN GOTO ReDraw   'If the bullet killed you.
      LOOP UNTIL a$ = rt$ OR a$ = lt$ OR a$ = UP$ OR a$ = dn$ OR a$ = "4" OR a$ = "6" OR a$ = "7" OR a$ = "9" OR a$ = "N" OR a$ = CHR$(27)
   END IF
   IF jump = 2 THEN jump = 0    'Just finished a whole jump.
   IF a$ = rt$ AND x < 39 THEN   'Move right, don't go off edge.
      FOR s = 1 TO 8
         xx = xx + 1
         CALL DrawGuy(xx, xy)
      NEXT
      x = x + 1
   ELSEIF a$ = lt$ AND x > 2 THEN  'Move left, don't go off edge
      FOR s = 1 TO 8
         xx = xx - 1
         CALL DrawGuy(xx, xy)
      NEXT
      x = x - 1
   ELSEIF a$ = UP$ AND pf(x, y) = "#" THEN 'The user is on a ladder, so
      FOR s = 1 TO 8                       'move UP, (NOt JUMP) when they
         xy = xy - 1                       'press 8.
         CALL DrawGuy(xx, xy)
      NEXT
      y = y - 1
   ELSEIF a$ = dn$ AND pf(x, y + 1) = "#" THEN 'Go down a ladder.
      FOR s = 1 TO 8
         xy = xy + 1
         CALL DrawGuy(xx, xy)
      NEXT
      y = y + 1
   END IF
   IF pf(x, y) = "#" THEN jump = 0      'If they jumped onto a ladder,
   IF pf(x, y) = "=" THEN               'Stop the jump.
      FOR s = 1 TO 8
         xy = xy - 1                    'If they're right OVER a girder,
         CALL DrawGuy(xx, xy)           'Climb on top of it.
      NEXT
      y = y - 1
      jump = 0                          'And stop jump that your in middle of
   ELSEIF pf(x, y + 1) = " " AND jump = 0 AND pf(x, y) <> "#" THEN
      fell = 0                        'If you're standing on air,
      FOR d = 1 TO 2
         IF pf(x, y + 1) <> " " THEN EXIT FOR
         snd = 0
         FOR s = 1 TO 8                     'Fall up to two units.
            xy = xy + 1
            CALL DrawGuy(xx, xy)
         NEXT
         snd = 1
         y = y + 1
         fell = fell + 1
      NEXT
      IF pf(x, y + 1) = " " AND fell = 2 THEN
         CALL Die                       'If you fell two units, and you
         GOTO ReDraw                    'STILL haven't landed, you're out of
      END IF                            'luck.
   ELSEIF pf(x, y) = "+" OR pf(x, y - 1) = "+" THEN
      FOR s = 1 TO 8                   'If you're legs or torso is on a
         xy = xy - 1                   'rope, climb it.
         CALL DrawGuy(xx, xy)
      NEXT
      y = y - 1
      jump = 2
   ELSEIF pf(x, y) = "o" OR pf(x, y - 1) = "o" THEN 'On a bomb?
      PUT (xx - 8, xy - 16), graph, PSET            'Erase Jumpman
      IF pf(x, y) = "o" THEN
         pf(x, y) = " "                           'Get the bomb if under legs
         LINE (xx - 8, xy - 8)-(xx, xy - 1), 0, BF 'Erase bomb
      ELSE                                        'OR ELSE:
         pf(x, y - 1) = " "                        'Get if under torso
         LINE (xx - 16, xy - 16)-(xx - 8, xy - 8), 0, BF  'erase it
         'LINE (xx - 8, xy - 16)-(xx, xy - 1), 0, BF
      END IF
      PLAY "t128 mb o1 l32 c o4 ccc"               'Sound effect
      LINE (xx - 8, xy - 16)-(xx, xy - 1), 0, BF
      GET (xx - 8, xy - 16)-(xx + 7, xy - 1), graph  'Stores new image,
      CALL DrawGuy(xx, xy)                           'without the bomb
      Points = Points + 1                      'Draw guy on top, increase
      CALL UpdateScore                        'points, and display new points
   END IF
   IF jump = 1 THEN               'If the user's in apex of a jump,
      IF x < 38 AND x > 2 THEN    'And they're not in danger of passing edge,
         snd = 0                  'Turn movement click sound flag off
         FOR s = 1 TO 8
            xy = xy + 2           'Jump back down to earth
            xx = xx + xstep
            CALL DrawGuy(xx, xy)
         NEXT
         y = y + 2
         x = x + xstep
         snd = 0
      END IF
      jump = 2                   'Completed jump cycle
   END IF
   IF (a$ = UP$ OR a$ = "7" OR a$ = "9") AND pf(x, y) <> "#" THEN 'Jump.
      IF a$ = "9" AND x < 38 THEN       'Jump RIGHT.
         xstep = 2
      ELSEIF a$ = "7" AND x > 2 THEN    'Jump LEFT
         xstep = -2
         max = 2
      ELSE
         xstep = 0                    'Jump UP.
      END IF
      PLAY "MBT128L32ML o3 CEG>C<GEC"
      snd = 0
      FOR s = 1 TO 4
         xy = xy - 2                 'Preform exactly 1/4 the jump.
         xx = xx + xstep
         CALL DrawGuy(xx, xy)
      NEXT
      y = y - 1
      FOR s = 1 TO 4                'The next quarter
         xy = xy - 2
         xx = xx + xstep
         CALL DrawGuy(xx, xy)
      NEXT
      y = y - 1
      x = x + xstep
      snd = 1
      jump = 1
   END IF
   IF Points = bombs THEN EXIT DO      'You've won the level.
   IF a$ = "N" THEN EXIT DO          'THE SECRET ****CHEAT CODE******
   IF dead = 1 THEN GOTO ReDraw      'Restart the level.
   IF a$ = CHR$(27) THEN GOTO Ending
LOOP
PlayTunes:                             'At this point, you've passed level.
a = INT(RND * 3)
TotalScore = TotalScore + Points + Bonus
PLAY "MF"
SELECT CASE a
   CASE 0          'Picks one of these congratualatory themes.
      PLAY "O3T128MN L4C <G8 >C< G8 F8 G8 E16 F16 G16 A16 B16 >C16 D16 C1"
   CASE 1
      PLAY "O2 L4MN T200 C<G >C< G >C<G C G >L8 GF#G G# G G# A A# A A# B >C<G>C2"
   CASE 2
      PLAY "O2 L4MN MBT200MN C8 D# G8 >C< A#. G2 D#8 F D#8 F# A#2 F#8 F8 D#8 C8 <A#8 >C1"
END SELECT
GOTO NextLevel

YouWon:     'The level re-drawer will send computer here if no more levels.
TIMER OFF   'Can you smell the meatballs in this plate of spaghetti? :-)
CLS
COLOR 15
ClearKeyBuffer 15
centre 12, "*** YOU WON ***"
WHILE INKEY$ = "": WEND
CALL HighScores
END

'****************************************************************************
'*                           SUBROUTINES                                    *
'****************************************************************************
DecrementBonus:
IF Bonus > 0 THEN           'This sub gets called every 10 seconds during
   Bonus = Bonus - 100      'game play (See help on "ON TIMER()" command)
   SOUND 440, 1
   CALL UpdateScore       'Decrements time bonus
END IF
RETURN

Ending:
CLS
COLOR 14
centre 12, CHR$(2) + " Buh-Bye! " + CHR$(2)
END
RETURN

CreateNewFile:
CLOSE 1                   'Gets called by Highscores if scorefile doesn't
OPEN FileName$ FOR OUTPUT AS 1   'exist.
FOR s = 1 TO 15
   PRINT #1, "------------"      'This creates a new file
   PRINT #1, 0
NEXT
CLOSE 1
RESUME                        'And resumes where the "FILE NOT FOUND"
                              'error occured.

'This following is the intro-screen graphic.
DATA "   CCC   C CC CC CCCC    CC CC  CC  C  C"
DATA "   C C   C C C C C   C   C C C C  C CC C"
DATA "C  C C   C C   C CCCC    C   C CCCC C CC"
DATA " CC   CCC  C   C C       C   C C  C C  C"
DATA "                                        "
DATA "                        BBBBBBBBBBBB    "
DATA "            WWWW        BB        BB    "
DATA "          WWWW    WW    BB        BB    "
DATA "        RRRRRRRRRR      BB        BB    "
DATA "      RR  RRRR          BBBBBBBBBBBB    "
DATA "      WW  RRRR          BB        BB    "
DATA "          MMMM          BB        BB    "
DATA "        MMMMMMMMMM      BB        BB    "
DATA "      MM        MM      BBBBBBBBBBBB    "
DATA "    WW          WWWW    BB        BB    "
DATA "          YYYY          BB        BB    "
DATA "          YYYY          BB        BB    "
DATA "                        BBBBBBBBBBBB    "
DATA "                        BB        BB    "
DATA "    GGGGGGGGGGGGGGGGGGGGBBGGGGGGGGBB    "
DATA "    GG  GG  GG  GG  GG  BB  GG  GGBB    "
DATA "    GGGGGGGGGGGGGGGGGGGGBBBBBBBBBBBB    "
DATA "                                        "
DATA "                                        "
DATA "                                        "

'The following are the levels. After each is the staring x,y position.
' It is possible to add more before the "STOP". Each is 25 lines.


'     1234567890123456789012345678901234567890
DATA "                                        "
DATA "                                        "
DATA "                                        "
DATA " o           o           o            o "
DATA " ==#===   ====  o     o  ====   ====#== "
DATA "   #               #                #   "
DATA "   #           ====#====            #   "
DATA "   #        o      #      o         #   "
DATA "   #      ====     #    ====        #   "
DATA "   #         ======#=====           #   "
DATA " o #   o           #           o    # o "
DATA "   #               #                #   "
DATA "   #           #   #   #            #   "
DATA " ====  ===   ==#=======#==   ===   ==== "
DATA "        +      #       #      +         "
DATA "        +      #       #      +         "
DATA "               #       #                "
DATA "   #      ===================       #   "
DATA " ==#=======                 ========#== "
DATA "   #                                #   "
DATA "   #         o         o            #   "
DATA "   #                                #   "
DATA " o #           =======              # o "
DATA " ====================================== "
DATA "                                        "
DATA 20,17

DATA "                                        "
DATA "                                        "
DATA "                                        "
DATA "             o            o             "
DATA " #  o     =========#=========     o   # "
DATA " #====             #            ======# "
DATA " #   ===   #       #      #   ===     # "
DATA " #     ====#==============#====       # "
DATA " #         #              #           # "
DATA " # o    #  #       o      #    o      # "
DATA " ===   =#=============================# "
DATA "        #                             # "
DATA "        #                             # "
DATA "        #                             # "
DATA " #      #             o      #   o    # "
DATA " #=============       =======#========= "
DATA " #                           #          "
DATA " #                           #        # "
DATA " #===============          ==#========# "
DATA " #              ===          #        # "
DATA " #                ===        #        # "
DATA " #   o              === o    #        # "
DATA " ======               =========     === "
DATA "                                        "
DATA "                                        "
DATA 37,22

DATA "                                        "
DATA "                                        "
DATA "                                        "
DATA "                                        "
DATA "  o         #   o     o    #          o "
DATA " ===========#=====   ======#=========== "
DATA "            #              #            "
DATA "            #              #            "
DATA " o          #       #      #          o "
DATA " ===   =======   ===#==   =======   === "
DATA " +                  #                 + "
DATA " +                  #                 + "
DATA " +    #       o     #     o      #    + "
DATA " +   =#========   =====   =======#=   + "
DATA " +    #         o      o         #    + "
DATA " +    #                          #    + "
DATA " +    #                          #    + "
DATA " +    #         #      #         #    + "
DATA " +   ===========#======#===========   + "
DATA " +              #      #              + "
DATA "        o       #      #       o        "
DATA " o              #      #              o "
DATA " ====================================== "
DATA "                                        "
DATA "                                        "
DATA 21,13

DATA "                                        "
DATA "                                        "
DATA "                                        "
DATA "       o      o         o      o        "
DATA " =#========   ====   ====   =========#= "
DATA "  #                                  #  "
DATA "  #                                  #  "
DATA "  #   o          o            #      #  "
DATA " ========   ==================#======== "
DATA "  +     ==                    #         "
DATA "         ==                   #         "
DATA "  o       ==  o    #     o    #     o   "
DATA " ==================#=================== "
DATA "  +                #                 +  "
DATA "                   #                    "
DATA "   o         o     #     o          o   "
DATA " ========   =======#========   ======== "
DATA "  +                #                 +  "
DATA "  +   o            #             o   +  "
DATA "  +  ===   ========#=========   ===  +  "
DATA "  +                #                 +  "
DATA "  +                #                 +  "
DATA "  +o               #                o+  "
DATA " ====================================== "
DATA "                                        "
DATA 20,12
DATA "STOP"

SUB Bullet
STATIC B, PrevX, PrevY, xtep, ytep, px, py, elapsed, DontChase
IF Delay = 1 THEN             'If the sub is being not being called by the
                              'DrawGuy sub, there is no delay so it'll
                              'have to delay itself.
   elapsed = elapsed + 1      'Does so by only executing every 25th CALL
   IF elapsed < DartSpeed THEN  'or so.
      EXIT SUB
   ELSE
      elapsed = 0
   END IF
END IF
IF ResetFlag = 1 THEN B = 0     'Player has started new level. Reread
IF B = 0 OR dead = 1 THEN          'The background or if first time called.
   IF INT(RND * 500) <> 99 THEN EXIT SUB  'Makes bullets come OCCASIONALLY
   elapsed = 0                           'NOt one after another.
   DontChase = 0
   B = 1
   a = INT(RND * 2)           'Come from top or left side?
   IF a = 0 THEN          'If side,
      px = 2
      py = INT(RND * 180) + 2
      xtep = .2               'Y step value,
      ytep = 0                              'X step value
   ELSE
      px = INT(RND * 290) + 2   'If top....
      py = 2
      xtep = 0
      ytep = .2
   END IF
   PrevX = px
   PrevY = py
   GET (px, py)-(px + 1, py + 1), bgraph  'Gets background behind bullet
END IF                                   'so it doesn't erase what's behind.
px = px + xtep                        'Move it horiz or vert..
py = py + ytep
PUT (PrevX, PrevY), bgraph, PSET   'Erase bullet and put back what was there.
PrevX = px                        'The previous position saved for the next
PrevY = py                        'time.
GET (px, py)-(px + 1, py + 1), bgraph   'Saves background again.
LINE (px, py)-(px + 1, py + 1), 15, B   'Draws bullet
cx = px \ 8 + 1                        'Calculates the "text" (8x8) position
cy = py \ 8 + 1                        'of the bullet
IF cx = x AND cy = y THEN           'If same as guy's position, smite him.
   CALL Die
   EXIT SUB
END IF
IF x < cx OR y < cy THEN d = -1      'IF the bullet is on same line as
IF y > cy OR x > cx THEN d = 1       'guy, AND it has not already changed
IF cx = x AND DontChase = 0 THEN     'course, swerve directly to him.
   ytep = d
   xtep = 0
   DontChase = 1                     'But it can only do it once.
SOUND 400, 1: SOUND 1000, 1
END IF
IF cy = y AND DontChase = 0 THEN       'Same, but for vertically.
   ytep = 0
   xtep = d
   DontChase = 1
SOUND 400, 1: SOUND 1000, 1
END IF
IF PrevX > 290 OR PrevY > 180 OR PrevX < 2 OR PrevY < 2 THEN
   PUT (PrevX, PrevY), bgraph, PSET
   PrevX = 0
   PrevY = 0                   'If offscreen, erase everything and
   px = 0                      'prepare to start a new instance of the
   py = 0                      'bullet on the next call. (B=0)
   B = 0
END IF
END SUB

SUB centre (y, t$)
'Centres something on the screen at the line Y

LOCATE y, 20 - LEN(t$) / 2
PRINT t$;


END SUB

SUB ClearKeyBuffer (n)

'Clears the keyboard buffer by repeatedly reading in keys.

FOR s = 1 TO n
   a$ = INKEY$
NEXT

END SUB

SUB Die
        
         DontDraw = 1  'Stop the bullet movement (in DrawGuy calls)
         snd = 0                    'No click sound on movement.
         FOR i = xy TO 200 STEP 3
            CALL DrawGuy(xx, i)       'Make him fall.
            SOUND 400 + (200 - i), .4
         NEXT
         snd = 1
         SLEEP 1
         DontDraw = 0
         PLAY "t200o3 MF MN L4 c2ccc2d#ddcc<b>c"
         lives = lives - 1
         dead = 1              'Set death flag
   
END SUB

SUB DrawGuy (x, y)
STATIC a, B, PrevX, PrevY
FOR s = 1 TO GuySpeed: NEXT     'Delays for fast computers.
IF ResetFlag = 1 THEN B = 0     'If next level reread background
px = x - 8
py = y - 16
IF B = 0 THEN           'If first time called, read background
   B = 1                'behind the guy with GET so he doesn't erase it
   PrevX = px           'or leave trails.
   PrevY = py
   GET (px, py)-(px + 15, py + 15), graph
END IF
PUT (PrevX, PrevY), graph, PSET     'Put background back, erase guy
PrevX = px
PrevY = py
GET (px, py)-(px + 15, py + 15), graph    'Get background at next position
a = a + .5                    'Move legs
IF a = 4 THEN a = 0
LINE (px + 3, py)-(px + 5, py + 2), 15, BF
LINE (px + 2, py + 3)-(px + 6, py + 6), 4, BF    'Draws guy
LINE (px + 4, py + 6)-(px + 4 - a, py + 13), 5
LINE (px + 4, py + 5)-(px + 5 + a, py + 13), 5
LINE (px + 4 - a, py + 14)-(px + 4 - a + 1, py + 15), 15, BF
LINE (px + 4, py + 14)-(px + 5 + a + 1, py + 15), 15, BF

IF DontDraw = 0 THEN
   Delay = 0              'Calls the bullet sub and tells it not to delay
   CALL Bullet            'because we've already delayed.
   Delay = 1
END IF

IF snd = 1 THEN SOUND 10000, .1    'The infamous click sound.


END SUB

SUB HighScores
ON ERROR GOTO CreateNewFile  'If file doesn't exist, branch there.
CLS

OPEN FileName$ FOR INPUT AS 1
ON ERROR GOTO 0
FOR s = 1 TO 15
   INPUT #1, Name$(s)             'REad in scores
   INPUT #1, Score(s)
NEXT
CLOSE 1
FOR outside = 1 TO 15
   FOR inside = outside + 1 TO 15            'A bubble sort, just for you,
      IF Score(outside) < Score(inside) THEN 'Mrs. Gotovac.
         SWAP Score(outside), Score(inside)
         SWAP Name$(outside), Name$(inside)
      END IF
   NEXT
NEXT


PLAY "T128 O2 L4 MS MB G8>C8 G8 G8 <G8>C8 G8 G8 <G8>C8 D16 E16 F8 E16 D16 C2"
COLOR 14
centre 2, "High Scores"
COLOR 3
PRINT : PRINT
FOR s = 1 TO 15
   LOCATE s + 3, 10
   PRINT Name$(s); TAB(22); Score(s); "  "
NEXT
LINE (68, 4)-(236, 144), 4, B
LINE (68, 20)-(236, 20), 4
ClearKeyBuffer 15
IF TotalScore * 100 > Score(1) THEN
   COLOR 14
   centre 20, CHR$(2) + " NEW HIGH SCORE " + CHR$(2)
   PRINT
   INPUT "Please enter your name: ", n$
   n$ = LEFT$(n$, 12)
   FOR s = 14 TO 1 STEP -1
      Name$(s + 1) = Name$(s)
      Score(s + 1) = Score(s)
   NEXT
   Name$(1) = n$
   Score(1) = TotalScore * 100
   OPEN FileName$ FOR OUTPUT AS 1
   FOR s = 1 TO 15
      LOCATE s + 3, 10
      PRINT Name$(s); TAB(22); Score(s); "   "
      PRINT #1, Name$(s)
      PRINT #1, Score(s)
   NEXT
   LINE (68, 4)-(236, 144), 4, B
   CLOSE 1
END IF




WHILE INKEY$ = "": WEND

END SUB

SUB paldef (c, r, g, B)
   'Redefines a colour to be another custom colour.
  
   OUT &H3C8, c
   OUT &H3C9, r
   OUT &H3C9, g
   OUT &H3C9, B

END SUB

SUB pandisplay (xp, yp)
'Makes the display instantly jump for earthquake effect.

OUT &H3D4, 12: OUT &H3D5, yp
OUT &H3D4, 13: OUT &H3D5, xp
END SUB

SUB UpdateScore

'Updates the scoreboard.

LOCATE 25, 1
COLOR 2: PRINT "Lives:";
COLOR 14: PRINT lives;
COLOR 2: PRINT TAB(11); "Points:";
COLOR 14: PRINT Points * 100;
COLOR 2: PRINT TAB(24); "Bonus:";
COLOR 14: PRINT Bonus; "   ";

END SUB

