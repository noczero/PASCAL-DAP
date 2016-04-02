DEFINT A-Z 'SPEED and memory saving
DECLARE SUB story ()
DECLARE SUB youdie ()
DECLARE SUB gprint (x%, y%, culler%, text$)
DECLARE SUB setpal (reg%, RED%, GREEN%, BLUE%)
DECLARE SUB drawyou (angle%) 'function that draws you at any angle
'The Horde V1.43 Final
'Code: Me, Daniel Garlans Graphics: Me, Daniel Garlans :)
'see line 549 for a little more stuff and a bug report :)
'You want the story? look in the STORY sub :)
'This was coded on a Pentium 166 with 16megs ram, a 2 meg Trident video card
'under a full-screen Win95 DOS box :) (Just press ALT+ENTER) =]
'Hmm...seems to be going slower now that the aliens are there
'well, I can't help it; Wormhole didn't need to figure out starting locations :)
'Actually, up to about 12 aliens is good  for speed, but above that the game
'stars to crawl and it's hideously hard (15+ is near impossible =])
'the fading color idea was...borrowed...from Wormhole :)
'This code is freeware but don't use it without crediting me :)
'Clean code is not something I do well, but spaghetti code is rare as well :)
'(There's always -some- sense or logic to it)
'Initalizing takes all of half a second :)
'MAJOR sections are seperated by a row of *'s (between init and game)
'IMPORTANT Sections are seperated by a row of ='s (between parts of loop)
'MINOR sections are seperated by a row of -'s (parts of parts)
'check around these dividers for a little info about the next part
SCREEN 7, , 1, 1'Screen 7 for Page Flipping... Less colors than could be wanted, but hey, you can't have everything
'I don't wanna even see this without page flipping :)
PRINT "The Horde 1.43 Final is Initalizing...."
PRINT "----Prepare for immersion----"
RANDOMIZE TIMER
PRINT "Creating and Initalizing Starfield"
CONST numstar = 20 'a lot=slower :)
TYPE star
 x AS INTEGER
 y AS INTEGER
END TYPE
DIM SHARED stars(1 TO numstar) AS star 'few for speed
FOR a = 1 TO numstar
stars(a).x = INT(RND * 320) + 1
stars(a).y = INT(RND * 200) + 1
NEXT a
'----------------------
PRINT "Drawing and Initalizing You"
'you are a sprite with 8 positions...  (Look at the compass with Cardinal and Intermediate)
'your sprite array... With integers more positions are needed yet same mem size and more speed!
DIM youu(1 TO 80)
DIM youd(1 TO 80)
DIM youl(1 TO 80)
DIM your(1 TO 80)
DIM youul(1 TO 80)
DIM youdl(1 TO 80)
DIM youur(1 TO 80)
DIM youdr(1 TO 80)
drawyou (270) 'up
GET (153, 93)-(167, 107), youu
LINE (153, 93)-(167, 107), 0, BF
drawyou (90) 'down
GET (153, 93)-(167, 107), youd
LINE (153, 93)-(167, 107), 0, BF
drawyou (180)'right
GET (153, 93)-(167, 107), your
LINE (153, 93)-(167, 107), 0, BF
drawyou (0)' left
GET (153, 93)-(167, 107), youl
LINE (153, 93)-(167, 107), 0, BF
drawyou (45) ' down-left
GET (153, 93)-(167, 107), youdl
LINE (153, 93)-(167, 107), 0, BF
drawyou (315) ' up-left
GET (153, 93)-(167, 107), youul
LINE (153, 93)-(167, 107), 0, BF
drawyou (225) 'up right
GET (153, 93)-(167, 107), youur
LINE (153, 93)-(167, 107), 0, BF
drawyou (135) 'up left
GET (153, 93)-(167, 107), youdr
LINE (152, 93)-(169, 107), 0, BF
youpow = 80
maxyoupow = 80
PRINT "Drawing and Initalizing Aliens"
'----------------------
DIM SHARED enemystr
DIM SHARED maxenemies AS INTEGER
maxenemies = 5 'difficulty level--crawling speed at more than 10
TYPE enemy
 x AS INTEGER
 y AS INTEGER
 pow AS INTEGER
 xv AS INTEGER
 yv AS INTEGER
 alive AS INTEGER '0=no 1=yes
END TYPE
DIM ali(1 TO maxenemies) AS enemy
DRAW "ta0"
DIM alien(1 TO 180)
PSET (160, 100), 8
DRAW "u8 r8 d8 l8"
FOR B = 1 TO 360 STEP 45
PSET (164, 96), 4
DRAW "TA=" + VARPTR$(B)
DRAW "u4"
NEXT B
PSET (163, 95), 3: PSET (164, 95), 3: PSET (165, 95), 3
PSET (163, 96), 3: PSET (164, 96), 3: PSET (165, 96), 3
PSET (163, 97), 3: PSET (164, 97), 3: PSET (165, 97), 3
'LINE (158, 90)-(170, 102), 8, B
GET (158, 90)-(170, 102), alien
LINE (158, 90)-(170, 102), 0, BF
PRINT "Initalizing Guns"
'----------------------
TYPE shot
 x AS INTEGER
 y AS INTEGER
 dirx AS INTEGER
 diry AS INTEGER
 who AS INTEGER '1=Alien 2=You (so your shots don't hit you)
 alive AS INTEGER
END TYPE
CONST maxshot = 14 'shots out at a time (Yours and aliens too)
CONST maxfiredelay = 4 'iterations before refire
firedelay = 0 'set to maxfiredelay at each shot-a delay
DIM shots(1 TO maxshot) AS shot
DIM shotpic(18) AS INTEGER
x = 160
y = 100
PSET (x, y), 14
PSET (x - 1, y), 12
PSET (x + 1, y), 12
PSET (x, y + 1), 12
PSET (x, y - 1), 12
GET (159, 99)-(161, 101), shotpic
PRINT "Initalizing Explosions"
'----------------------
TYPE xplo
 x AS INTEGER
 y AS INTEGER
 stage AS INTEGER
END TYPE
DIM SHARED maxplo
maxplo = 3
DIM xplosions(1 TO maxplo) AS xplo
PRINT "Initalizing Palettes"
'----------------------
setpal 1, 30, 30, 30 'Your hull
setpal 6, 63, 0, 0   'your laser
setpal 3, 63, 63, 0  'enemy lights --these do a fadecycle-
fadecol = 63
PRINT "Initalizing Globals"
'----------------------
DIM SHARED yourhealth AS INTEGER
DIM SHARED maxhealth AS INTEGER
DIM SHARED level AS INTEGER
DIM SHARED bossstr AS INTEGER
DIM SHARED gundamage AS INTEGER
DIM SHARED viewpage AS INTEGER
DIM SHARED drawpage AS INTEGER
DIM SHARED youdir
DIM SHARED shotsfired AS LONG
DIM SHARED hits AS LONG
'youdir=1=up 2=down 3=left 4=right 5=upleft 6=upright 7=downleft 8=downright
youdir = 2
viewpage = 0 'for page flipping-what you see
drawpage = 1 'for page flipping-what is being drawn
maxhealth = 20
yourhealth = maxhealth
level = 1
bossstr = 40
gundamage = 5
DIM SHARED stardirx
DIM SHARED stardiry
stardirx = 0
stardiry = -2
DIM SHARED shotdirx
DIM SHARED shotdiry
shotdirx = 0
shotdiry = 3
PRINT "Creating Background Plane" 'NOT USED-FLICKERS TERRIBLY
'----------------------
'Fixed background stars:more detail
SCREEN 7, , 2, 0
FOR a = 1 TO 5
x = INT(RND * 320) + 1
y = INT(RND * 200) + 1
PSET (x, y), 15
PSET (x - 1, y), 8
PSET (x + 1, y), 8
PSET (x, y + 1), 8
PSET (x, y - 1), 8
NEXT a
SCREEN 7, , 0, 0
PRINT "Initalizing Sine/Cosine Tables"
'----------------------
'these arn't used either :)
DIM sinelook(0 TO 360)
DIM cosinelook(0 TO 360)
DIM pi AS DOUBLE
pi = 3.1415927#
FOR a = 0 TO 360
sinelook(a) = SIN(a * (pi / 180)) 'Velocity Tables
cosinelook(a) = COS(a * (pi / 180)) 'Velocity Tables
NEXT a
PRINT "Initalization Complete"
'----------------------
story 'duhhh
'********************
CLS
youdir = 2
fadecoldir = -2
fadecol = 60
DO 'main game loop
SCREEN 7, , drawpage, viewpage 'draw the page drawn before!
'CLS
LINE (0, 0)-(320, 200), 0, BF 'MUCH better than CLS, Less/No Flicker!
'at least, it's better with pageflipped modes
'Fade Cycles
'======================
fadecol = fadecol + fadecoldir
IF fadecol < 10 OR fadecol > 60 THEN
fadecoldir = -fadecoldir
END IF
CALL setpal(3, fadecol, fadecol, 0)
'update your powerdisplay and gun counter
'----------------------
LINE (1, 200)-(1, 200 - youpow), 12
LINE (2, 200)-(2, 200 - firedelay * 4), 15 'Usually not seen :)
'check if you're dead or not
'======================
IF youpow <= 0 THEN CALL youdie 'hmmm I wonder :)
'do stars
'======================
FOR a = 1 TO numstar
'PSET (stars(a).x, stars(a).y), 0 'clear stars
stars(a).x = stars(a).x + stardirx
stars(a).y = stars(a).y + stardiry
IF stars(a).x < 0 THEN stars(a).x = 320
IF stars(a).x > 320 THEN stars(a).x = 0
IF stars(a).y < 0 THEN stars(a).y = 200
IF stars(a).y > 200 THEN stars(a).y = 0
PSET (stars(a).x, stars(a).y), 15
NEXT a
'do aliens
'======================
FOR a = 1 TO maxenemies
 IF ali(a).alive = 0 THEN
  'BEEP
  'hey, we have a free enemy space :)
  'let's add one, shall we?
  where = INT(RND * 4) + 1
  SELECT CASE where 'what wall
  CASE 1
   x = 1
   y = INT(RND * 200) + 1
   xv = INT(RND * 2) + 1
   yv = -2 + INT(RND * 4) + 1
  CASE 2
   x = 320
   y = INT(RND * 200) + 1
   xv = INT(RND * 2) + 1
   yv = -2 + INT(RND * 4) + 1
  CASE 3
   x = INT(RND * 320) + 1
   y = 1
   xv = -2 + INT(RND * 4) + 1
   yv = INT(RND * 2) + 1
  CASE 4
   x = INT(RND * 320) + 1
   y = 200
   xv = -2 + INT(RND * 4) + 1
   yv = -INT(RND * 2) + 1
   CASE ELSE  'you shouldn't be here :)
  END SELECT
  'put them values into the clicker..er..array... :)
  ali(a).x = x
  ali(a).y = y
  ali(a).xv = xv
  ali(a).yv = yv
  ali(a).alive = 1
 END IF
NEXT a
'aliens added, now draw 'em
'----------------------
FOR a = 1 TO maxenemies
 IF ali(a).alive = 1 THEN 'alive
  'BEEP
  'adding stardir is not exactly the best way but it works :)
  'this sorta moves the aliens with the stars...not perfect :)
  ali(a).x = ali(a).x + stardirx / 2
  ali(a).y = ali(a).y + stardiry / 2
  ali(a).x = ali(a).x + ali(a).xv
  ali(a).y = ali(a).y + ali(a).yv
  'bound check...whoda thunk it?
  IF ali(a).x > 300 OR ali(a).x < 1 THEN
   ali(a).alive = 0
  END IF
  IF ali(a).y > 180 OR ali(a).y < 1 THEN
   ali(a).alive = 0
  END IF
  IF ali(a).alive = 1 THEN 'still alive
   PUT (ali(a).x, ali(a).y), alien, PSET 'what's it look like? :)
  END IF
 END IF
NEXT a
'do shots
'======================
'Shots are actually started in the iteration before :)
firedelay = firedelay - 1 'delay
IF firedelay < 0 THEN firedelay = 0 'if there's a delay make new shots not there :)
'IF firedelay > 0 THEN newshot = 0 'no new shots if firedelay isn't 0
IF newshot = 1 THEN
 'call a new shot!
 shotsfired = shotsfired + 1 'I don't think I use this
 IF firedelay = 0 THEN
  FOR test = 1 TO maxshot
   IF shots(test).alive = 0 THEN
    IF newshot = 1 THEN 'Don't fill all shot spots up!
     'It might be kewl like that...one huge particle shot :)
     'constantly hitting things :)
     'free shot space
     newshot = 0 'Stop adding more shotz
     shots(test).x = 166 'the values are set to start in YOUR CENTER! :)
     shots(test).y = 106 'that's why the SHOTS.WHO is needed :)
     shots(test).who = 2 '2=you 1=alien (no aliens shots as of v1.32)
     'shotdir? is set in the movement :)
     shots(test).dirx = shotdirx 'quick and dirty...gotta love it :)
     shots(test).diry = shotdiry 'shots go somewhat faster than the stars
     shots(test).alive = 1
    END IF
   END IF
  NEXT test
 firedelay = maxfiredelay 'firedelay time!
 ELSEIF firedelay > 0 THEN
  newshot = 0 'firedelay not 0 yet
 END IF
END IF
'Shot Movement
'----------------------
FOR doshot = 1 TO maxshot
 still = 1';still alive...used in code :)
 IF shots(doshot).alive = 1 THEN 'a good shot we have here
  'I like ta' movit movit...I like ta' MOV it MOV it, I like ta' MOV IT!
  'da dada duh duh dun dunh oohps I'm typing... :)
  shots(doshot).x = shots(doshot).x + shots(doshot).dirx
  shots(doshot).y = shots(doshot).y + shots(doshot).diry
  'bound check!..without this the PUTs crash
  IF shots(doshot).x < 4 OR shots(doshot).x > 314 THEN
   shots(doshot).alive = 0 'kill the shot
   still = 0 'should we STILL display it?
  END IF
  IF shots(doshot).y < 4 OR shots(doshot).y > 196 THEN
   shots(doshot).alive = 0 'kill the shot
   still = 0 'should we STILL display it?
  END IF
  'draw the shot!                           
  IF still = 1 THEN 'if the shot didn't run offbounds
  PUT (shots(doshot).x, shots(doshot).y), shotpic, PSET
  END IF
  END IF
  'now to detect collisions :)
  '----------------------
  'surprisingly I got this part working in about 10 minutes :)
  'this part is horrendously nested... sorry :)
  FOR B = 1 TO maxenemies
   IF shots(doshot).x >= ali(B).x AND shots(doshot).x < ali(B).x + 12 THEN
    IF shots(doshot).y >= ali(B).y AND shots(doshot).y < ali(B).y + 12 THEN
     'Well, I do declayah: You made a hit!
      ali(B).alive = 0 'alien is busted
      shots(doshot).alive = 0 'shot is busted: no multi-hits :) (that would actually kick though)
      'add an explosion
      x = ali(B).x
      y = ali(B).y
      hits = hits + 1
      GOSUB newxplo 'Shudder: -gosub-.. look at Wormhole and many other games :)
     END IF
    END IF
   NEXT B
NEXT doshot
'======================
'check for you+alien collision
FOR a = 1 TO maxenemies
 'this part was hideous to code and still isn't perfect :)
 IF ali(a).x >= 160 AND ali(a).x <= 170 OR ali(a).x + 12 >= 160 AND ali(a).x + 12 <= 170 THEN
  IF ali(a).y >= 100 AND ali(a).y <= 110 OR ali(a).y + 12 >= 100 AND ali(a).y + 12 <= 110 THEN
   'BEEP
   'POW-you're hit!
   youpow = youpow - 5 'ouch
   '----------------------
   'reflection---not perfect but it works :)
   IF ali(a).xv < 0 THEN ali(a).xv = ali(a).xv + 4
   IF ali(a).xv > 0 THEN ali(a).xv = ali(a).xv - 4
   IF ali(a).yv < 0 THEN ali(a).xv = ali(a).yv + 4
   IF ali(a).yv > 0 THEN ali(a).xv = ali(a).yv - 4
   ali(a).xv = -(ali(a).xv + 2)'deflected -- actually,  they bounce inside you
   ali(a).yv = -(ali(a).yv + 2)'deflected -- and hurt you more (sometimes)
  END IF
 END IF
NEXT a
'do keypresses
'======================
v$ = UCASE$(RIGHT$(INKEY$, 1))
'you wouldn't belive how annoying this next part was :)
'I had to do a LOT of reversing variables and letters... ick
SELECT CASE v$
CASE "D" 'die -- debug key/alternate quit button :)
youpow = 0
CASE " " 'space for fire
'Fuh-HIRE!
newshot = 1 'yuppers, this is simple-check back in the "do shots" part
CASE CHR$(27)
END
CASE "P" 'don't fiddle with any of these without a backup
stardirx = 0
stardiry = -2
shotdirx = 0
shotdiry = 3
youdir = 2
CASE "H" 'you'd regret it :) well...maybe not but hey; sounds kewl..
stardirx = 0
stardiry = 2
shotdirx = 0
shotdiry = -3
youdir = 1
CASE "M"
stardirx = -2
stardiry = 0
shotdirx = 3
shotdiry = 0
youdir = 4
CASE "K"
youdir = 3
stardirx = 2
stardiry = 0
shotdirx = -3
shotdiry = 0
CASE "2"
youdir = 2
stardirx = 0
stardiry = -2
shotdirx = 0
shotdiry = 3
CASE "8"
youdir = 1
stardirx = 0
stardiry = 2
shotdirx = 0
shotdiry = -3
CASE "6"
youdir = 4
stardirx = -2
stardiry = 0
shotdirx = 3
shotdiry = 0
CASE "4"
youdir = 3
stardirx = 2
stardiry = 0
shotdirx = -3
shotdiry = 0
CASE "3"
youdir = 8
stardirx = -2
stardiry = -2
shotdirx = 3
shotdiry = 3
CASE "9"
youdir = 6
stardirx = -2
stardiry = 2
shotdirx = 3
shotdiry = -3
CASE "7"
youdir = 5
stardirx = 2
stardiry = 2
shotdirx = -3
shotdiry = -3
CASE "1"
youdir = 7
stardirx = 2
stardiry = -2
shotdirx = -3
shotdiry = 3
END SELECT
'the numeric keypad allows more directions but I think the regular keypad
'is fine... NUMLOCK must be on to use the keypad :)
'do explosions
'======================
FOR a = 1 TO maxplo 'only 3 explosions: for speed and you wouldn't notice
 IF xplosions(a).x <> 0 THEN 'crazy results without this :)
 xplosions(a).x = xplosions(a).x + stardiry 'this dosn't work right :)
 xplosions(a).y = xplosions(a).y + stardiry 'who cares? looks good :)
 'actually; doesn't work like I wanted it to
 x = xplosions(a).x
 y = xplosions(a).y
 s = xplosions(a).stage 'copy these variables for less array accessing
 CIRCLE (x, y), s, 14 'expanding yellow circle
 CIRCLE (x, y), 10, 6, , , s 'shrinking horizontaly circle
 FOR B = 1 TO 15 'little particles-hard to notice at first but you can "sense" 'em :)
 x2 = -6 + INT(RND * 12) + 1
 y2 = -6 + INT(RND * 12) + 1
 PSET (x + x2, y + y2), 15
 NEXT B
 xplosions(a).stage = xplosions(a).stage + 1 'increase
 IF xplosions(a).stage = 10 THEN xplosions(a).x = 0 'if it's too high, cancel!
 END IF
NEXT a
'do you...drawing anyway :)(
'======================
'youdir=1=up 2=down 3=left 4=right 5=upleft 6=upright 7=downleft 8=downright
SELECT CASE youdir 'Maybe not the fastest code but easiest to modify & understand
CASE 1 'I picked good names for the GET arrays, try to figure them out :)
PUT (160, 100), youu, PSET
CASE 2
PUT (160, 100), youd, PSET
CASE 3
PUT (160, 100), youl, PSET
CASE 4
PUT (160, 100), your, PSET
CASE 5
PUT (160, 100), youul, PSET
CASE 6
PUT (160, 100), youur, PSET
CASE 7
PUT (160, 100), youdl, PSET
CASE 8
PUT (160, 100), youdr, PSET
END SELECT
WAIT &H3DA, 8      'keep same max speed
WAIT &H3DA, 8, 8   'but I never mentioned MINIMUM speed :)
SWAP drawpage, viewpage 'flip the draw/view pointers
LOOP 'and start all this over again!
END
'======================
newxplo:
'add an explosion
'i don't use GOSUBS much but this is more for flexibility
'and I didn't want to keep adding code
yes = 0
FOR a = 1 TO maxplo
 IF xplosions(a).x = 0 AND yes = 0 THEN 'alive
  yes = 1
  xplosions(a).x = x 'X and Y were set in the shot collision part
  xplosions(a).y = y
  xplosions(a).stage = 1
 END IF
NEXT a
RETURN
'**********************
'Wheeooo-this is line 549!!!
'Hey'yall: Copyright time :)
'the game is done...the dream is here... (modified floyd =])
'All code here Copyright (C) 1996 Daniel Garlans
'The origional Wormhole idea was done by...er...Glen Blankenship was it? :)
'I don't remember... sorry :) Any other copyrights are respected!
'You may use parts of this, but the graphics are mine and only mine :)
'take the graphics and die =]
'remember to give me credit!
'Bug Report:
'Well, the bugs are few, thankfully =]
'First, occasionally any aliens hitting you from bottom right area
'blow up before hitting you... (yaay), sometimes you get pointless explosions
'here and there for no apparent reason; usually always on the edges of the screen.
'Some things like explosion movement are weird, and many other things are
'weird but work :) Good lord, line 564...
'Well, time to sign off-c-ya 'round :)
'ps: sorry for any spelling errors!

DEFSNG A-Z
SUB drawyou (angle%)
PSET (160, 100), 0
DRAW "TA=" + VARPTR$(angle%)
DRAW "bu2c1l5g2f2r5d3e3c4u4bl1c5d4bu5c1h2d3bd1bl3u0d2bl1bl3bu1c6l1 "

END SUB

DEFINT A-Z
SUB gprint (x, y, culler, text$)
DEF SEG = &HFFA6        ' ROM segment for character shape table
 XX% = x
 FOR Char% = 1 TO LEN(text$)
  Addr% = 8 * ASC(MID$(text$, Char%, 1)) + 14
  FOR Ln% = 0 TO 7
    LineFormat% = CVI(CHR$(0) + CHR$(PEEK(Addr% + Ln%)))
    YY% = y + Ln%
    LINE (XX%, YY%)-(XX% + 7, YY%), culler, , LineFormat%
  NEXT
  XX% = XX% + 8
 NEXT
 DEF SEG


END SUB

SUB setpal (reg%, RED%, GREEN%, BLUE%)
  OUT &H3C8, reg%
  OUT &H3C9, RED%
  OUT &H3C9, GREEN%
  OUT &H3C9, BLUE%
END SUB

SUB story
LOCATE 24
PRINT "It has been 2 years since the"
PRINT "last of the aliens from the "
PRINT "wormhole were repelled."
PRINT "We thought it was safe. But,"
PRINT "two weeks ago a message was "
PRINT "recived from a space drone"
PRINT "that an alien fleet was found."
PRINT "The aliens are back."
PRINT "This time you're in a specially"
PRINT "fitted Scout Runner with plasma"
PRINT "particle guns."
PRINT "--press any key to continue--"
WHILE INKEY$ = "": WEND
PRINT "The guns require a breif cooldown"
PRINT "period between shots, during which"
PRINT "your only defense is your hull armor."
PRINT "You can withstand about 10-15"
PRINT "collisions, and that's about it."
PRINT "The aliens are smart and will"
PRINT "run at high speed to evade your"
PRINT "shots once you hit them."
PRINT "For now the enemy ships are unarmed,"
PRINT "but the constant stream of them is"
PRINT "more than dangerous enough."
PRINT "Prepare for immersion in...."
PRINT
PRINT
COLOR 14: PRINT "        The Horde"
COLOR 15: PRINT "--press any key to continue--"
WHILE INKEY$ = "": WEND
PRINT "Instructions:"
PRINT "Press SPACE to fire"
PRINT "the numeric keypad"
PRINT "allows diagonal directions as"
PRINT "well as regular directions, and"
PRINT "the regular keypad does the "
PRINT "obvious directions."
PRINT "Press ESC to quit, or D to "
PRINT "kill yourself and quit."
PRINT "The red bar on the right is"
PRINT "hull strength, and the gun"
PRINT "cooling level is shown with "
PRINT "the white bar, which vanishes"
PRINT "when you can fire again."
PRINT "Oh yeah, the guns have a"
PRINT "force beam to keep them"
PRINT "level with you, no matter what"
PRINT "direction you're facing."
COLOR 15: PRINT "--press any key to play--"
WHILE INKEY$ = "": WEND


END SUB

SUB youdie
CALL setpal(1, 63, 63, 63)
CALL setpal(2, 63, 63, 0)
SCREEN 7, , 0, 0
LINE (0, 0)-(320, 200), 1, BF
c = 63
FOR a = 0 TO 200 STEP 2
CALL setpal(1, c, c, c)
c = c - 1
IF c < 0 THEN c = 0
CIRCLE (160, 100), a, 2
CIRCLE (161, 101), a, 2
CIRCLE (159, 101), a, 2
CIRCLE (159, 100), a, 2
CIRCLE (161, 100), a, 2
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
NEXT a
CLS
LOCATE 12, 10
PRINT "You have failed...."
PRINT "Shots fired:"; shotsfired
PRINT "Kills------:"; hits
PRINT "Misses-----:"; shotsfired - hits
IF shotsfired = 0 THEN shotsfired = 1
IF hits = 0 THEN hits = 1

'PRINT "Accuracy---:"; INT(shotsfired); "%" 'not sure how to show accuracy

END


END SUB

