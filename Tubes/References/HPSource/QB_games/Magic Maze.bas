'-----------------------------------------------------------------------
'                  MagicMaze V1.0 By: Elias Holmlid 1997
'                      "The Return Of Berra Da Ball"
'-----------------------------------------------------------------------

'Hello! Here's a little maze game that I've made.
'For everyone who have played my first game BerraDaBall this one maybe seems
'a little familiar... Take the stuff that lies around and clear the levels...
'I made this game in a day. Took about six hours, so don't expect too much :)
'One procedure slows down the game insanely much! It's in the
'beginning of the MainGame Sub. It checks if you've passed over a box. If
'you've done that, the game will end. Try to comment it and check out the
'incredible speed!

'INSTRUCTIONS:

'Maneuver your character with the arrow keys. Pause with P.
'Quit during game with Q.
'Your task is to collect all the green little dots before you crash into
'a wall...
'That's about all! Enjoy the game and make sure you get all the comments.
'-----------------------------------------------------------------------
'MailMe:holmlid@swipnet.se _or_ holmlid@hotmail.com
'-----------------------------------------------------------------------

'Defines and such

 '$DYNAMIC
 OPTION BASE 0
 DECLARE SUB IntroScreen ()
 DECLARE SUB GameMenu ()
 DECLARE SUB QuitGame ()
 DECLARE SUB PaintScreen ()
 DECLARE SUB MainGame ()
 DECLARE SUB GameOver ()
 DECLARE SUB Ending ()

 COMMON SHARED level AS INTEGER, score AS INTEGER, lives AS INTEGER
 COMMON SHARED charx AS INTEGER, chary AS INTEGER, c AS INTEGER, e AS INTEGER
 COMMON SHARED target.req AS INTEGER, charmove AS INTEGER, noise AS INTEGER

 DIM SHARED pointx(600) AS INTEGER, pointy(600) AS INTEGER
 DIM SHARED box(300) AS INTEGER, char(300) AS INTEGER, target(300) AS INTEGER
 DIM SHARED targetx(15) AS INTEGER, targety(15) AS INTEGER
 DIM SHARED end.text$(3)

 RANDOMIZE TIMER

 noise = 1 'IF YOU HATE THE SOUND, CHANGE THIS VALUE TO 0

 IntroScreen

HereItStarts:

 level = 1

 GameMenu

 CLS 'Clears the screen! What else?

'Get the graphics

 LINE (100, 100)-(110, 110), 6, BF
 LINE (100, 100)-(110, 110), 1
 LINE (110, 100)-(100, 110), 1
 GET (100, 100)-(110, 110), box
 CLS
 CIRCLE (105, 105), 2, 2
 PAINT (105, 105), 10, 2
 GET (103, 103)-(107, 107), target

 level = 1: score = 0: lives = 5

 PaintScreen 'Paints the labyrinth
 
 MainGame

 IF level = 9 THEN Ending 'The ending sucks, big time!
 IF level = 9 THEN GOTO HereItStarts
 GameOver

 GOTO HereItStarts 'Do it again!
'----------------------------------------------------------------------------
'[c] Elias Holmlid -1997

REM $STATIC
SUB Ending
 
  CLS
 
  end.text$(1) = "Yeah! You made it. Uhhh. Sorry, though. You won't find any nice ending here."
  end.text$(2) = "No 3D-rendered picture, no animations. All you can do is to press escape."
  end.text$(3) = "It will toss you back to the menu..."
  FOR a = 1 TO 3
    FOR b = 1 TO 80
      a$ = MID$(end.text$(a), b, 1)
      PRINT a$;
      FOR c = 1 TO 1000
      NEXT c
    NEXT b
    PRINT
  NEXT a

  DO UNTIL INKEY$ = CHR$(27)
  LOOP
 
  FOR a = 480 TO 0 STEP -1
    LINE (0, a)-(640, a), 6
  NEXT

END SUB

SUB GameMenu
 
  COLOR 2
  LOCATE 10, 31
  PRINT "   _MagicMaze_   "
  PRINT
  LOCATE 12, 31
  PRINT "------------------"
  LOCATE 13, 31
  PRINT "-Press 1 to begin-"
  LOCATE 14, 31
  PRINT "-Press 2 to exit!-"
  LOCATE 15, 31
  PRINT "------------------"

keyloop: 'A little keyloop. If you wait too long, the demo starts!
 
  key$ = INPUT$(1)
  IF key$ = "1" THEN EXIT SUB
  IF key$ = "2" THEN QuitGame
  GOTO keyloop

END SUB

SUB GameOver

  CLS
 
  LOCATE 14
  PRINT "   Darn! It's Game Over. You lost all your lives. You have failed your quest."
  PRINT "        But don't go hang yourself just because of it! Try again instead."
  PRINT "                   You got "; score; " points. Press Escape for menu!"
 
  DO UNTIL INKEY$ = CHR$(27): LOOP
 
  FOR choord = 0 TO 640
    LINE (choord, 0)-(choord, 480), 6
    LINE (640 - choord, 0)-(640 - choord, 480), 6
    LINE (0, 480 - choord)-(640, 480 - choord), 6
    LINE (0, choord)-(640, choord), 6
  NEXT

END SUB

SUB IntroScreen
 
  SCREEN 12
  COLOR 3
  LOCATE 14, 34: PRINT "_MagicMaze_"
  LOCATE 15, 27: PRINT "'The Return Of Berra Da Ball'"
  LOCATE 17, 23: PRINT ".By Elias Holmlid in da year of 1997."
  SLEEP 2
 
  FOR choord = 0 TO 640
    LINE (choord, 0)-(choord, 480), 6
    LINE (640 - choord, 0)-(640 - choord, 480), 6
    LINE (0, 480 - choord)-(640, 480 - choord), 6
    LINE (0, choord)-(640, choord), 6
  NEXT

END SUB

SUB MainGame
 
  DO
   FOR I = 1 TO 10000
   NEXT
    IF target.req = 0 THEN
      level = level + 1
      IF level = 9 THEN EXIT SUB
      PaintScreen
    END IF
   
    'This procedure is so fucking slow!!! AAAARRRGGGGHHHH!!! :(
   
    IF lives = 0 THEN EXIT SUB
    FOR a = 1 TO c
      IF charx >= pointx(a) AND charx <= pointx(a) + 12 AND chary >= pointy(a) AND chary < pointy(a) + 12 THEN
        lives = lives - 1: LOCATE 1, 30: PRINT "Lives: "; lives
        CIRCLE (charx, chary), 4, 0
        charx = 35: chary = 35: charmove = 0
        IF noise = 1 THEN SOUND 100, 2
        LOCATE 1, 24: PRINT "Lost a life. Press escape to continue..."
        DO UNTIL INKEY$ = CHR$(27)
        LOOP
        LOCATE 1, 24: PRINT "                                        "
        LOCATE 1, 30: PRINT "Lives: "; lives; " Score: "; score
        key$ = "0"
      END IF
    NEXT
    'End of slowness.........................................................
   
    'Did ya pick one up?
   
    FOR a = 1 TO e
      IF charx >= targetx(a) AND charx <= targetx(a) + 12 AND chary >= targety(a) AND chary <= targety(a) + 12 THEN
        score = score + 100: LOCATE 1, 41: PRINT "Score: "; score
        PUT (targetx(a), targety(a)), target, XOR
        targetx(a) = 0: targety(a) = 0
        target.req = target.req - 1
        IF noise = 1 THEN SOUND 1300, 2
      END IF
    NEXT
   
    'Key routine...

    key$ = INKEY$
    IF key$ = CHR$(113) THEN EXIT SUB
    IF key$ = CHR$(112) THEN
      LOCATE 1, 60: PRINT "Paused..."
      SLEEP
      LOCATE 1, 60: PRINT "         "
    END IF
   
    CIRCLE (charx, chary), 4, 0 'Removes our hero...
   
    IF key$ = CHR$(0) + CHR$(75) THEN charmove = 1
    IF key$ = CHR$(0) + CHR$(77) THEN charmove = 2
    IF key$ = CHR$(0) + CHR$(80) THEN charmove = 3
    IF key$ = CHR$(0) + CHR$(72) THEN charmove = 4
    IF charmove = 1 THEN charx = charx - 10 'Which direction you move.
    IF charmove = 2 THEN charx = charx + 10
    IF charmove = 3 THEN chary = chary + 10
    IF charmove = 4 THEN chary = chary - 10
   
    CIRCLE (charx, chary), 4, 9 'Draws our hero...
 
  LOOP 'Loop it!
   
END SUB

SUB PaintScreen
 
  charx = 35
  chary = 35
  charmove = 0
  CLS
  COLOR 2
  LOCATE 13, 37: PRINT "Level: "; level
  LOCATE 28, 1: PRINT "Press escape to begin..."
  DO UNTIL INKEY$ = CHR$(27)
  LOOP
  CLS
  c = 0
  PRINT TAB(30); "Lives: "; lives; : PRINT " Score: "; score
 
  FOR a = 20 TO 480 STEP 440
    FOR b = 20 TO 620 STEP 10
      c = c + 1
      pointx(c) = b
      pointy(c) = a
      PUT (b, a), box, PSET
    NEXT b
  NEXT a
 
  FOR a = 20 TO 620 STEP 600
    FOR b = 20 TO 460 STEP 10
      c = c + 1
      pointx(c) = a
      pointy(c) = b
      PUT (a, b), box, PSET
    NEXT b
  NEXT a
  IF level = 1 THEN brick.num = 20: target.req = 3
  IF level = 2 THEN brick.num = 18: target.req = 7
  IF level = 3 THEN brick.num = 17: target.req = 8
  IF level = 4 THEN brick.num = 16: target.req = 10
  IF level = 5 THEN brick.num = 14: target.req = 11
  IF level = 6 THEN brick.num = 13: target.req = 12
  IF level = 7 THEN brick.num = 12: target.req = 13
  IF level = 8 THEN brick.num = 10: target.req = 15
 
  FOR a = 30 TO 450 STEP 10
    FOR b = 40 TO 620 STEP 20
      IF INT(RND * brick.num) = 0 THEN
        PUT (b, a), box, PSET
        c = c + 1
        pointx(c) = b
        pointy(c) = a
      END IF
    NEXT b
  NEXT a
  e = 0

'This shit was hard to do! I got really frustrated, cause the the balls had
'a really bad habbit of putting themselves on top of the bricks. This should
'be fixed now, I think (hope)...

target.init:
 
  FOR a = 45 TO 435 STEP 10
    FOR b = 55 TO 605 STEP 10
      IF INT(RND * 500) = 0 THEN
        FOR d = 1 TO c
          IF b >= pointx(d) AND b <= pointx(d) + 12 AND a >= pointy(d) AND a < pointy(d) + 12 THEN GOTO EndIt
        NEXT d
      e = e + 1
      targetx(e) = b
      targety(e) = a
      IF e = target.req GOTO target.draw
EndIt:
      END IF
    NEXT b
  NEXT a
  IF e < target.req GOTO target.init

target.draw:
 
  FOR a = 1 TO e
    PUT (targetx(a), targety(a)), target, PSET
  NEXT

END SUB

SUB QuitGame
 
  SCREEN 0
 
  PRINT "Thanks for playing this little game"
  PRINT "It was completly made by Elias Holmlid"
  PRINT "MailMeHereIfYouHaveAnythingToSay:"
  PRINT "homlid@swipnet.se _or_ holmlid@hotmail.com"
  PRINT
  PRINT "See ya! :)"
  PRINT
 
  SYSTEM

END SUB

