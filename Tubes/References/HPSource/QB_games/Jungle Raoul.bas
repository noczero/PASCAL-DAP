'  Jungle Raoul in The Quest for the Sapphire Ampersand
'
'  1996          Zack Johnson (nobody@bslnet.com)
'
'  This is my first submission to ABC.
'  It isn't very well commented, but at the beginning of
'  each SUB, there's a skeletal description of what the SUB
'  does and how it works.


DEFINT A-Z
                                            ' global variables
DIM SHARED Jungle(30, 15)
DIM SHARED playerx, playery
DIM SHARED cannibal(8, 2), plant(8, 2)
DIM SHARED score, gotgun, ammo
DIM SHARED level, Raoul, tree, bush, wall, ruin, plant
DIM SHARED cannibal, jewel, ammobox, gun, gold, idol
DIM SHARED up$, dn$, rt$, lt$
DIM SHARED MethodOfDeath

DECLARE FUNCTION Rand (max)         ' return random # from 1 to max
DECLARE SUB Initialize ()           ' initialize -- duh.
DECLARE SUB delay (x AS INTEGER)    ' CPU-independent delay function
DECLARE SUB Intro ()                ' show intro screen
DECLARE SUB Instructions ()         ' instructions...
DECLARE SUB center (text$)          ' prints text$, centered.
DECLARE SUB pak ()                  ' generic "Press any Key" func.
DECLARE SUB MakeLevel ()            ' create new level.
DECLARE SUB DrawJungle ()           ' update the display of a level
DECLARE SUB PlayerMoves ()          ' get input and act accordingly
DECLARE SUB MoveEnemies ()          ' no-brain AI for enemies
DECLARE SUB YouWin ()               ' game win sequence
DECLARE SUB YouLose ()              ' game lose sequence
DECLARE SUB DeathByPlant ()         ' \___  Death
DECLARE SUB DeathByCannibal ()      ' /~~~Functions
DECLARE SUB CheckForWin ()          ' see if level is done (all baddies dead)
DECLARE SUB NextLevel ()            ' increment level and remake jungle
DECLARE SUB CheckContact ()         ' see if you share space with a baddie
DECLARE SUB Blood ()                ' groove-a-licious blood effect
                                    

Initialize

Intro

COLOR 15
LOCATE 10, 1
center ("Raoul begins his quest")
PRINT
center ("deep in the jungle...")
LOCATE 19, 1
pak

MakeLevel

CLS

DrawJungle
                                                ' main loop
WHILE (1)
  PlayerMoves
  IF level <> 5 THEN CheckForWin
  MoveEnemies
WEND

END

' Here beginneth the DATA statements wherein the levels
' (except for the first one, which is randomly generated)
' are kept.  If you want to change them, look at
' MakeLevel for the coding scheme.  Watch that you don't
' put more than 8 cannibals or more than 8 plants in a
' level, though...

                                                ' level 2 DATA

DATA "TTBTTTTTBTTT  C   TTBTBBTBBBBB"
DATA "TTTT P TTBT     TTTTTTTTTBBBJB"
DATA "TBTP G  TT     TTT     TTTBBBB"
DATA "TTT    PTT    TTT $$  TTBTBBBB"
DATA "TBTT P TT    TTTT   TTTT   BBB"
DATA "TTBT  TT      TT   TTTC   BBBB"
DATA "TTT  TT                  BBBBB"
DATA "     T     TBBBBB    T     BBB"
DATA " *       TTTBBBBTBC     T BBBB"
DATA " TTTTT    TT        B BBB   BB"
DATA " TTTTT   BBBBTT     TRWBWTB   "
DATA " BTTT   BBBTTTT    TBR  WBTB  "
DATA " B     BBTTTTT     BTW ARTB   "
DATA "   $ TTTTTTTTTTTT   TRWRWB    "
DATA "   TTTTTTTTTTTTTTTT  BBBB     "
                                                ' level 3 DATA                                    
DATA "TTTBTBTTTBTTTTTTTTBTTTTTBTTTTT"
DATA "TBBTTTTTTTTTT     TTTTBTTTTBTT"
DATA "TTTTTT           BB    TTTTTBT"
DATA "TT     BB       BAAB      PTTT"
DATA "T  P  B$$B      BAAB        TT"
DATA "T     BCC         B   BB     T"
DATA "       BB     WW     BCAB     "
DATA "*             WW      CCB    T"
DATA "T        B            BB    TT"
DATA "T       BA B    B           TT"
DATA "BT      BJCB   BC B     P  TTT"
DATA "TTT      BB    B$CB       TTTT"
DATA "TBTTTT          BB      TTTBTT"
DATA "TTTBBTTTTT   P     TTTTTTBTTBT"
DATA "TTBTTBTTTTTTTTTTTTTBBTBTTTTBBT"
                                                ' level 4 DATA
DATA "TTTTTTTTTTTTTTTTBBBB  C   BT W"
DATA "TTTTTTTTT  C  TTBBB      BT WW"
DATA "TTTTTTT      TTTT   C B B TWW "
DATA "TTTTTT      TTTT        B WW$T"
DATA "TTT          TT     WWWWWWW BP"
DATA "TT     TTT       C  WRWRWW PB "
DATA "TT*   TTTT      BBBTWWWWW TP  "
DATA "TTT     TTT    BBB BB  B  B  $"
DATA "TTT             B BTWWWWW  T B"
DATA "TTTT   TTT      C B WRWRWWTT  "
DATA "TTTTT   TTTT        WWWWWWWB P"
DATA "TTTTTTT    TTT       B   BWW$T"
DATA "TTTTTTTTTT           B   TBWWB"
DATA "TTTTTTTTTTTTTTBBBC     B  BTWW"
DATA "TTTTTTTTTTTTTTTTBBBB     B  BW"
                                                ' level 5 DATA
DATA "BTBWWWWWWWWWWWWWWWWWWWWWWWWTBT"
DATA "TBW     W$$$JW  C   W      WTB"
DATA "TW   C   $$$JW      W       WT"
DATA "WWW WWWWWWWWWWW W WWWWWWWWWWWW"
DATA "W        P   W  W  WW   P    W"
DATA "W  C  W      W  W WW     WWWWW"
DATA "WWWWWWWWW  WWW WW W  C   W   W"
DATA "*            W  W    C     I W"
DATA "WWW WWWWW  WWW WWWW  C   W   W"
DATA "W     W  AA  W    WW     WWWWW"
DATA "W  C  W      W P   WW   P    W"
DATA "WWWW WWWWWWWWWW  WWWWWWWWWWWWW"
DATA "TW    P               C     WT"
DATA "BTW     W    W      W      WBT"
DATA "TBBWWWWWWWWWWWWWWWWWWWWWWWWTTB"

SUB Blood
'
'  This function is now about 8 years old.
'  It never ceases to amuse me.
'
DIM a(40)
COLOR 4: FOR r = 1 TO 500
x = INT(RND * 40) + 1
IF a(x) <> 23 THEN a(x) = a(x) + 1: LOCATE a(x), x: PRINT "€"
IF a(x) > 22 THEN GOTO bloodskip
IF r / 10 = INT(r / 10) THEN delay (1)
bloodskip:
NEXT r
END SUB

SUB center (text$)

PRINT TAB(20 - (INT(LEN(text$) / 2))); text$


END SUB

SUB CheckContact
'
'  This function simply checks to see if playerx and playery
'  correspond with any of the enemy coordinates.  If so, you
'  die.
'

FOR lop = 1 TO 8
  IF playerx = cannibal(lop, 1) AND playery = cannibal(lop, 2) THEN DeathByCannibal
  IF playerx = plant(lop, 1) AND playery = plant(lop, 2) THEN DeathByPlant
NEXT lop

END SUB

SUB CheckForWin
'
'  This checks to see if all of the enemies on a level are dead.
'
win = 1
FOR lop = 1 TO 8
  IF cannibal(lop, 1) <> 0 THEN win = 0
  IF plant(lop, 1) <> 0 THEN win = 0
NEXT lop

IF win = 1 THEN NextLevel


END SUB

SUB DeathByCannibal
MethodOfDeath = 1
YouLose
END SUB

SUB DeathByPlant
MethodOfDeath = 2
YouLose
END SUB

SUB delay (x)
'
'  This snippet of code taken from some old ABC packet.
'

 t! = INT(TIMER * 100)
 DO
     IF t! <> INT(TIMER * 100) THEN
         t! = INT(TIMER * 100)
         count = count + 1
     END IF
 LOOP UNTIL count = x

END SUB

SUB DrawJungle
'
'  This sub draws the playing screen, the player, and any enemies present.
'

FOR lop = 0 TO 31
  FOR lopp = 0 TO 16
    IF lop = 0 OR lop = 31 OR lopp = 0 OR lopp = 16 THEN drawn = 219: COLOR 7: GOTO skip
      drawn = Jungle(lop, lopp)
      IF drawn = tree OR drawn = bush THEN COLOR 2
      IF drawn = gold THEN COLOR 14
      IF drawn = jewel THEN COLOR 1
      IF drawn = gun OR drawn = ammobox THEN COLOR 8
      IF drawn = wall THEN COLOR 15
      IF drawn = ruin THEN drawn = 219 + Rand(4): COLOR 15
      IF drawn = idol THEN COLOR 1
skip:
      LOCATE 1 + lopp, 5 + lop
      PRINT CHR$(drawn)

  NEXT lopp
NEXT lop

LOCATE 1 + playery, 5 + playerx
COLOR 14
PRINT CHR$(Raoul)

FOR lop = 1 TO 8
  IF cannibal(lop, 1) <> 0 THEN
    LOCATE 1 + cannibal(lop, 2), 5 + cannibal(lop, 1)
    COLOR 4
    PRINT CHR$(cannibal)
  END IF
  IF plant(lop, 1) <> 0 THEN
    LOCATE 1 + plant(lop, 2), 5 + plant(lop, 1)
    COLOR 10
    PRINT CHR$(plant)
  END IF
NEXT lop

LOCATE 19, 10: COLOR 6: PRINT "Score:"
LOCATE 19, 17: COLOR 3: PRINT score
LOCATE 19, 24: COLOR 6: PRINT "Ammo:"
LOCATE 19, 30: COLOR 3: PRINT ammo

IF gotgun = 1 THEN LOCATE 21, 13: COLOR 7: PRINT "You have a gun."
END SUB

SUB Initialize
                                               
                                                ' these lines are the
Raoul = 2                                       ' ASCII values of all the
tree = 24                                       ' printed characters.
bush = 35
wall = 219
ruin = 176
plant = 234
cannibal = 1
jewel = 4
ammobox = 22
gun = 169
gold = 36
idol = ASC("&")

                                                ' set values for
up$ = CHR$(0) + "H"                             ' arrow keys
dn$ = CHR$(0) + "P"
rt$ = CHR$(0) + "M"
lt$ = CHR$(0) + "K"

                                                ' set initial values
RANDOMIZE TIMER: SCREEN 0: WIDTH 40             ' of important stuff.
level = 1

END SUB

SUB Instructions
CLS
COLOR 14
PRINT CHR$(Raoul);
COLOR 7
PRINT ":  ";
PRINT "I am ";
COLOR 2: PRINT "Jungle Raoul";
COLOR 7: PRINT ", the fearless"
PRINT "    explorer."
PRINT
PRINT "    You can move me around using the"
COLOR 10
PRINT "    arrow keys."
COLOR 7
PRINT
PRINT "    Press the ";
COLOR 10
PRINT ".";
COLOR 7
PRINT " key and I will stand"
PRINT "    still for a turn, letting the"
PRINT "    enemies move."
PRINT
PRINT "    Press ";
COLOR 10: PRINT "M"; : COLOR 7
PRINT ", followed by an arrow"
PRINT "    key, and I will swing my trusty"
PRINT "    machete, destroying any bushes"
PRINT "    or carnivorous plants in my way."
PRINT
PRINT "    Press ";
COLOR 10: PRINT "S"; : COLOR 7
PRINT ", followed by an arrow"
PRINT "    key, and I will shoot my gun"
PRINT "    (if, of course, I posess a gun,)"
PRINT "    which will kill any enemy."
PRINT
pak
CLS
COLOR 2
PRINT CHR$(tree);
COLOR 7: PRINT ":  Trees (impassable)"
PRINT
COLOR 2
PRINT CHR$(bush);
COLOR 7: PRINT ":  Bushes - these can be hacked away"
PRINT "    with one swipe of my machete."
PRINT
PRINT CHR$(wall);
COLOR 7: PRINT ":  Walls or Ruins (impassable)"
PRINT
COLOR 8
PRINT CHR$(gun);
COLOR 7: PRINT ",";
COLOR 8: PRINT CHR$(ammobox);
COLOR 7
PRINT ":  Gun/Box of ammo.  Boxes of ammo"
PRINT "      contain 3 shots each."
PRINT
COLOR 14: PRINT CHR$(gold);
COLOR 7: PRINT ",";
COLOR 1: PRINT CHR$(jewel);
COLOR 7
PRINT ":  Gold and Jewels - bonus points"
PRINT
COLOR 10
PRINT CHR$(plant);
COLOR 7
PRINT ":  Carnivorous Plants.  These can be"
PRINT "    killed with either a machete or"
PRINT "    a gunshot."
PRINT
COLOR 4
PRINT CHR$(cannibal);
COLOR 7
PRINT ":  Cannibals.  They can be killed"
PRINT "    only by a gunshot."
PRINT
COLOR 1
PRINT "&";
COLOR 7
PRINT ":  The Sapphire Ampersand -- The"
PRINT "    object of your quest..."
PRINT
pak
CLS
COLOR 1
center ("HINTS:")
COLOR 7
PRINT
PRINT "Once you have killed all of the"
PRINT "enemies on a level, you will move on"
PRINT "to the next level."
PRINT
PRINT "You only have one life -- make it count."
PRINT
PRINT "Ammo not used on one level carries over"
PRINT "into the next level.  Don't waste it,"
PRINT "because you'll need it."
PRINT
PRINT "Don't waste bullets on the plants --"
PRINT "they are easily dispatched with your"
PRINT "machete."
PRINT
pak
END SUB

SUB Intro
introtop:
CLS
COLOR 14
LOCATE 2, 1
PRINT TAB(4); " €€€€€€ "
PRINT TAB(4); "€€€€€€€€"
PRINT TAB(4); "€€ €€ €€"
PRINT TAB(4); "€€€€€€€€"
PRINT TAB(4); "€€€€€€€€"
PRINT TAB(4); "€€    €€"
PRINT TAB(4); "€€€  €€€"
PRINT TAB(4); " €€€€€€ "
COLOR 2
LOCATE 4, 17
PRINT "⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø"
LOCATE 5, 17
PRINT "≥  J U N G L E     ≥"
LOCATE 6, 17
PRINT "≥                  ≥"
LOCATE 7, 17
PRINT "≥       R A O U L  ≥"
LOCATE 8, 17
PRINT "¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ"
COLOR 8
LOCATE 12, 18
PRINT "in"

COLOR 1
LOCATE 15, 15
PRINT "The Quest"
LOCATE 16, 16
PRINT "for the"
LOCATE 17, 9
PRINT "Sapphire Ampersand (&)"

LOCATE 21, 3
COLOR 3: PRINT "(P)";
COLOR 5: PRINT "lay    ";
COLOR 3: PRINT "(I)";
COLOR 5: PRINT "nstructions    ";
COLOR 3: PRINT "(Q)";
COLOR 5: PRINT "uit"

                                                ' groovy gleaming text
FOR lop = 9 TO 31
  COLOR 15
  FOR lopp = 15 TO 17
    LOCATE lopp, lop
    PRINT CHR$(SCREEN(lopp, lop))
  NEXT lopp
  delay (1)
  COLOR 1
  FOR lopp = 15 TO 17
    LOCATE lopp, lop
    PRINT CHR$(SCREEN(lopp, lop))
  NEXT lopp
NEXT lop


getakey:
a$ = ""

WHILE a$ = ""
  a$ = INKEY$
WEND

a$ = UCASE$(a$)
IF a$ = "P" THEN CLS : EXIT SUB
IF a$ = "I" THEN Instructions: GOTO introtop
IF a$ = "Q" THEN END
GOTO getakey:


END SUB

SUB MakeLevel
'
' This sub randomly generates the first level, and reads the others
' from DATA statements.
'

                                                ' clear jungle
FOR lop = 1 TO 30
FOR lopp = 1 TO 15
Jungle(lop, lopp) = 0
NEXT lopp
NEXT lop
                                                ' clear enemies
FOR lop = 1 TO 8
  plant(lop, 1) = 0: plant(lop, 2) = 0
  cannibal(lop, 1) = 0: cannibal(lop, 2) = 0
NEXT lop


                                                ' create correct level

IF level = 1 THEN
                                                ' level 1 is generated
level1:                                         ' randomly, the rest
FOR lop = 1 TO 100                              ' are stored in data
  Jungle(Rand(30), Rand(15)) = tree               ' statements
  Jungle(Rand(30), Rand(15)) = bush
  IF lop > 96 THEN Jungle(Rand(30), Rand(15)) = gold

NEXT lop
playerx = 4
playery = 4
Jungle(4, 4) = 0
FOR lop = 1 TO 5
  plant(lop, 1) = Rand(20) + 10
  plant(lop, 2) = Rand(15)
  Jungle(plant(lop, 1), plant(lop, 2)) = 0
NEXT lop
EXIT SUB
END IF

cannibalnumber = 1
plantnumber = 1

FOR lop = 1 TO 15
  READ line$
  FOR lopp = 1 TO 30
    char$ = MID$(line$, lopp, 1)
    IF char$ = "W" THEN Jungle(lopp, lop) = wall
    IF char$ = "R" THEN Jungle(lopp, lop) = ruin
    IF char$ = "T" THEN Jungle(lopp, lop) = tree
    IF char$ = " " THEN Jungle(lopp, lop) = 0
    IF char$ = "B" THEN Jungle(lopp, lop) = bush
    IF char$ = "G" THEN Jungle(lopp, lop) = gun
    IF char$ = "$" THEN Jungle(lopp, lop) = gold
    IF char$ = "A" THEN Jungle(lopp, lop) = ammobox
    IF char$ = "J" THEN Jungle(lopp, lop) = jewel
    IF char$ = "I" THEN Jungle(lopp, lop) = idol
    IF char$ = "*" THEN playerx = lopp: playery = lop: Jungle(lopp, lop) = 0
    IF char$ = "C" THEN
      cannibal(cannibalnumber, 1) = lopp
      cannibal(cannibalnumber, 2) = lop
      cannibalnumber = cannibalnumber + 1
      Jungle(lopp, lop) = 0
    END IF
    IF char$ = "P" THEN
      plant(plantnumber, 1) = lopp
      plant(plantnumber, 2) = lop
      plantnumber = plantnumber + 1
      Jungle(lopp, lop) = 0
    END IF

  NEXT lopp
NEXT lop

END SUB

SUB MoveEnemies
'
' plants are non-sentient -- they just wander around
' cannibals are vaguely sentient -- they wander towards Raoul.
'

                                                ' move plants
FOR lop = 1 TO 8
  IF plant(lop, 1) <> 0 AND RND > .4 THEN
    xmove = Rand(3) - 2
    ymove = Rand(3) - 2
    IF xmove <> 0 AND ymove <> 0 THEN
      IF RND > .5 THEN xmove = 0 ELSE ymove = 0
    END IF
    newx = plant(lop, 1) + xmove
    newy = plant(lop, 2) + ymove
    IF newx < 1 OR newx > 30 OR newy < 1 OR newy > 15 THEN GOTO done
    IF Jungle(newx, newy) <> 0 THEN GOTO done
FOR lopp = 1 TO 8
  IF (lop <> lopp) AND newx = plant(lopp, 1) AND newy = plant(lop, 2) THEN GOTO done
NEXT lopp
   
    LOCATE 1 + plant(lop, 2), 5 + plant(lop, 1)
    PRINT " "
    plant(lop, 1) = newx: plant(lop, 2) = newy
    LOCATE 1 + newy, 5 + newx
    COLOR 10
    PRINT CHR$(plant)
  END IF
done:
NEXT lop
                                                ' move cannibals
FOR lop = 1 TO 8

xtry = 0: ytry = 0
IF cannibal(lop, 1) <> 0 THEN
  IF playerx = cannibal(lop, 1) THEN xtry = 0
  IF playerx < cannibal(lop, 1) THEN xtry = -1
  IF playerx > cannibal(lop, 1) THEN xtry = 1
  IF playery = cannibal(lop, 2) THEN ytry = 0
  IF playery < cannibal(lop, 2) THEN ytry = -1
  IF playery > cannibal(lop, 2) THEN ytry = 1

IF xtry <> 0 AND ytry <> 0 THEN
  IF RND > .5 THEN xtry = 0 ELSE ytry = 0
END IF

newx = cannibal(lop, 1) + xtry
newy = cannibal(lop, 2) + ytry

IF Jungle(newx, newy) <> 0 THEN GOTO candone
FOR lopp = 1 TO 8
  IF (lop <> lopp) AND newx = cannibal(lopp, 1) AND newy = cannibal(lopp, 2) THEN GOTO candone
NEXT lopp



LOCATE 1 + cannibal(lop, 2), 5 + cannibal(lop, 1)
PRINT " "
cannibal(lop, 2) = newy
cannibal(lop, 1) = newx
LOCATE 1 + newy, 5 + newx
COLOR 4
PRINT CHR$(cannibal)

candone:

END IF

NEXT lop

CheckContact
EXIT SUB

END SUB

SUB NextLevel
'
' This sub increments level, calls MakeLevel, and displays the
' "between level intro" text.
'

CLS
level = level + 1
ON level - 1 GOTO intro2, intro3, intro4, intro5

intro2:
CLS
COLOR 15
LOCATE 9, 1
center ("Raoul heads eastward,")
PRINT
center ("toward the forbidding sound")
PRINT
center ("of beating drums...")
GOTO introdone:


intro3:
COLOR 15
LOCATE 9, 1
center ("Raoul emerges into a cannibal")
PRINT
center ("village, crude huts surrounding")
PRINT
center ("a weathered stone altar...")

GOTO introdone:

intro4:
COLOR 15
LOCATE 7, 1
center ("Raoul emerges from the village")
PRINT
center ("to find the entrance to what must")
PRINT
center ("surely be the final resting place")
PRINT
center ("of the fabled Sapphire Ampersand...")
GOTO introdone:

intro5:
COLOR 15
LOCATE 9, 1
center ("Raoul enters the ancient temple,")
PRINT
center ("oblivious of the dangers within.")
PRINT
center ("The Ampersand is close at hand...")

GOTO introdone:


introdone:
LOCATE 19, 1
pak
MakeLevel
CLS
DrawJungle
END SUB

SUB pak
COLOR 8
center ("Press any key...")
WHILE INKEY$ = "": WEND

END SUB

SUB PlayerMoves
'
'  This sub handles moving, chopping, and shooting.
'  It also contains the code which checks for goodies
'  (gold, jewels, gun, ammo, etc.)
'

getkey:

valid = 0
moved = 0
a$ = ""

WHILE a$ = ""
  a$ = INKEY$
WEND

IF a$ = up$ THEN valid = 1: moved = 1: xmove = 0: ymove = -1
IF a$ = dn$ THEN valid = 1: moved = 1: xmove = 0: ymove = 1
IF a$ = rt$ THEN valid = 1: moved = 1: xmove = 1: ymove = 0
IF a$ = lt$ THEN valid = 1: moved = 1: xmove = -1: ymove = 0
IF a$ = "." THEN valid = 1: moved = 0: xmove = 0: ymove = 0
IF UCASE$(a$) = "M" THEN valid = 1: GOSUB machete
IF UCASE$(a$) = "S" THEN valid = 1: GOSUB shoot
IF UCASE$(a$) = "L" THEN NextLevel
IF a$ = CHR$(27) THEN END
IF valid = 0 THEN GOTO getkey

IF moved THEN
  newx = playerx + xmove
  newy = playery + ymove

  IF newx < 1 OR newx > 30 THEN valid = 0: GOTO skip1
  IF newy < 1 OR newy > 15 THEN valid = 0: GOTO skip1

  newspace = Jungle(newx, newy)
  IF newspace = tree OR newspace = bush OR newspace = wall OR newspace = ruin THEN valid = 0

skip1:

  IF valid THEN
    LOCATE 1 + playery, 5 + playerx
    PRINT " "
    playerx = newx: playery = newy
                                
    CheckContact

    LOCATE 1 + playery, 5 + playerx
    COLOR 14
    PRINT CHR$(Raoul)
    IF Jungle(playerx, playery) = gold THEN
      score = score + 10 + Rand(15)
      LOCATE 19, 17
      COLOR 3
      PRINT score
    END IF
    IF Jungle(playerx, playery) = jewel THEN
      score = score + 20 + Rand(10)
      LOCATE 19, 17
      COLOR 3
      PRINT score
    END IF
    IF Jungle(playerx, playery) = gun THEN
      gotgun = 1
      LOCATE 21, 13
      COLOR 7
      PRINT "You have a gun."
      Jungle(playerx, playery) = ammobox
    END IF
    IF Jungle(playerx, playery) = ammobox THEN
      ammo = ammo + 3
      LOCATE 19, 30
      COLOR 3
      PRINT ammo
    END IF
    IF Jungle(playerx, playery) = idol THEN
      YouWin
    END IF
    Jungle(playerx, playery) = 0
 
  END IF
END IF

EXIT SUB





machete:

a$ = ""
WHILE a$ = ""
a$ = INKEY$
WEND

valid = 0

IF a$ = up$ THEN valid = 1: xchop = 0: ychop = -1
IF a$ = dn$ THEN valid = 1: xchop = 0: ychop = 1
IF a$ = rt$ THEN valid = 1: xchop = 1: ychop = 0
IF a$ = lt$ THEN valid = 1: xchop = -1: ychop = 0

chopx = playerx + xchop
chopy = playery + ychop

IF chopx < 1 OR chopx > 30 THEN valid = 0
IF chopy < 1 OR chopy > 15 THEN valid = 0

IF valid THEN
  IF Jungle(playerx + xchop, playery + ychop) = bush THEN
    Jungle(playerx + xchop, playery + ychop) = 0
    LOCATE 1 + playery + ychop, 5 + playerx + xchop
    PRINT " "
  END IF

  FOR lop = 1 TO 8
    IF chopx = plant(lop, 1) AND chopy = plant(lop, 2) THEN
      LOCATE 1 + plant(lop, 2), 5 + plant(lop, 1)
      PRINT " "
      plant(lop, 1) = 0
      score = score + 30
      LOCATE 19, 17
      COLOR 3
      PRINT score
    END IF
  NEXT

END IF

valid = 1
RETURN

shoot:
IF gotgun = 0 OR ammo = 0 THEN RETURN
ammo = ammo - 1
LOCATE 19, 30
COLOR 3
PRINT ammo

a$ = ""
WHILE a$ = ""
a$ = INKEY$
WEND

valid = 0

IF a$ = up$ THEN valid = 1: xshot = 0: yshot = -1
IF a$ = dn$ THEN valid = 1: xshot = 0: yshot = 1
IF a$ = rt$ THEN valid = 1: xshot = 1: yshot = 0
IF a$ = lt$ THEN valid = 1: xshot = -1: yshot = 0

IF valid = 0 THEN GOTO shoot

shotx = playerx
shoty = playery
scoreadd = 0
WHILE (1)
  shotx = shotx + xshot
  shoty = shoty + yshot
  IF shotx = 0 OR shotx = 31 OR shoty = 0 OR shoty = 16 THEN GOTO doneshooting
  IF Jungle(shotx, shoty) <> 0 THEN GOTO doneshooting
  LOCATE 1 + shoty, 5 + shotx
  COLOR 15
  PRINT "˘"
  delay (1)
  FOR lop = 1 TO 8
    IF shotx = cannibal(lop, 1) AND shoty = cannibal(lop, 2) THEN
      cannibal(lop, 1) = 0: LOCATE 1 + shoty, 5 + shotx: scoreadd = 50: PRINT " ": GOTO doneshooting
    END IF
    IF shotx = plant(lop, 1) AND shoty = plant(lop, 2) THEN
      plant(lop, 1) = 0: LOCATE 1 + shoty, 5 + shotx: scoreadd = 20: PRINT " ": GOTO doneshooting
    END IF
  NEXT lop
  LOCATE 1 + shoty, 5 + shotx
  PRINT " "
WEND

doneshooting:

IF scoreadd <> 0 THEN
  score = score + scoreadd
  LOCATE 19, 17
  COLOR 3
  PRINT score
END IF

RETURN


END SUB

FUNCTION Rand (max)
'
'  I find using this easier than always typing int(rnd*whatever)+1
'


Rand = INT(RND * max) + 1

END FUNCTION

SUB YouLose
Blood
LOCATE 1, 12
COLOR 0, 4
PRINT "Press any key..."
COLOR 0, 0
WHILE INKEY$ = "": WEND
CLS
LOCATE 6, 1
IF MethodOfDeath = 1 THEN
  COLOR 4, 0
  center ("Raoul is savagely beheaded,")
  center ("chopped into pieces, and later")
  center ("eaten by the indigent cannibals.")
ELSE
  COLOR 2, 0
  center ("Raoul is strangled and absorbed")
  center ("by a fierce carnivorous plant.")
  center ("His bones litter the ground, a")
  center ("sinister testament to his")
  center ("foolishness.")
END IF
PRINT
PRINT
COLOR 3
PRINT "      Your final score:  ";
COLOR 5
PRINT score;
COLOR 3
PRINT "pts."
COLOR 7
PRINT
pak
CLS
RUN
END
END SUB

SUB YouWin
CLS
COLOR 14
LOCATE 2, 1
PRINT TAB(4); " €€€€€€ "
PRINT TAB(4); "€€€€€€€€"
PRINT TAB(4); "€€ €€ €€"
PRINT TAB(4); "€€€€€€€€"
PRINT TAB(4); "€€€€€€€€"
PRINT TAB(4); "€€    €€"
PRINT TAB(4); "€€€  €€€"
PRINT TAB(4); " €€€€€€ "
COLOR 1
LOCATE 3, 15: PRINT "      I've done it!"
LOCATE 4, 15: PRINT "I have braved the terrors"
LOCATE 5, 15: PRINT "of the jungle, and emerged"
LOCATE 6, 15: PRINT "triumphant, with the "
LOCATE 7, 15: PRINT "fabled Sapphire Ampersand"
LOCATE 8, 15: PRINT "in hand."
LOCATE 12, 10
PRINT "--------------------"
LOCATE 13, 10
PRINT "- CONGRATULATIONS! -"
LOCATE 14, 10
PRINT "--------------------"
LOCATE 18, 1
COLOR 3
PRINT "      Your final score:  ";
COLOR 5
PRINT score;
COLOR 3
PRINT "pts."
COLOR 7
PRINT

WHILE INKEY$ = ""                               ' another effects loop
FOR lop = 10 TO 30
  FOR lopp = 12 TO 14
    COLOR Rand(15)
    char$ = CHR$(SCREEN(lopp, lop))
    newchar$ = char$
    IF char$ = "-" THEN newchar$ = "\"
    IF char$ = "\" THEN newchar$ = "≥"
    IF char$ = "≥" THEN newchar$ = "/"
    IF char$ = "/" THEN newchar$ = "-"
    LOCATE lopp, lop: PRINT newchar$
  NEXT lopp
NEXT lop
delay (3)
WEND

COLOR 7
CLS
RUN
END SUB

