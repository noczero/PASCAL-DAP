'
' Creator Rpg v1.0
' By Dragonsky of Knight Productions
' Read the text file before using
'
'

DECLARE SUB getpress ()
DECLARE SUB textstart ()
DECLARE SUB newtext ()
DECLARE SUB loadtext ()
DECLARE SUB newgraphic ()
DECLARE SUB Border ()
DECLARE SUB font (text$, XStart%, ystart%, xscale%, Yscale%, style%, Clr%)
DECLARE SUB SetPal ()
DECLARE SUB MakeFont ()
DECLARE SUB FindFont ()
DIM SHARED FontBuf(0) AS STRING * 10368
CLS
SCREEN 13
FindFont
CLS
SCREEN 12
LOCATE 15, 29
COLOR 14
PRINT "A Knight Production"
SLEEP 1
SCREEN 13

CLS
SetPal
font "Creator Rpg", 20, 60, 3, 3, 2, 126
font "v1.0", 100, 110, 3, 3, 2, 0
PLAY "t80mso2d8e8f8g8a8f8b-8a16g16a8f "
getpress
FOR I = 1 TO 25
LOCATE 24, 1: PRINT ""
NEXT I



menu:
CLS
SCREEN 12
PRINT "Main Menu:"
PRINT "1. Create new Rpg game"
PRINT "2. Quit"

DO
select$ = UCASE$(INKEY$)
LOOP UNTIL select$ = "1" OR select$ = "2"
IF select$ = "1" THEN CALL newtext
IF select$ = "2" THEN END




'Creator v1,0, Dragonsky, and Knight Productions are (c)

SUB Border

FOR x% = 0 TO 32

 font "$", x% * 10, 0, 1, 1, 1, 0

 font "$", x% * 10, 190, 1, 1, 1, 0

NEXT

FOR x% = 1 TO 19

 font "$", 0, x% * 10, 1, 1, 1, 0

 font "$", 310, x% * 10, 1, 1, 1, 0

NEXT

END SUB

SUB FindFont

OPEN "basefont.dat" FOR BINARY AS #1

 IF LOF(1) < 2 THEN

  NoFile% = 1

 END IF

 ' If the file is there, load all the crap into the buffer

 IF NoFile% <> 1 THEN GET #1, , FontBuf(0)

CLOSE #1

IF NoFile% THEN

 KILL "basefont.dat"

 CLS

 SCREEN 0

 WIDTH 80

 PRINT "We couldn't find the font data file!!"

 PRINT "Luckily for you, we can make one if you want"

 PRINT "to see the demo (hint : it's worth it!)"

 PRINT

 PRINT "So, should we make the font data file?"

 PRINT "1) Yes"

 PRINT "2) No"

 INPUT Choice%

 IF Choice% <> 1 THEN

  PRINT "Fine, be that way!"

  getpress

  SYSTEM

 ELSE

  PRINT "Hit a key to make the file...it shouldn't take too long."

  PRINT "Oh yeah, don't go ballistic when you hear a beep, that's just"

  PRINT "the seventh character of 128!"

  getpress

  MakeFont

 END IF

END IF

END SUB

SUB font (text$, XStart%, ystart%, xscale%, Yscale%, style%, Clr%)



px% = XStart%  ' physical x and physical y

py% = ystart%



LHeight% = Yscale% * 8

Optimize% = 63 \ LHeight% ' Any constant math operations done multipe times

                          ' in the main loop should, well, not be done

                          ' in the main loop.





' Instead of wasting our time with all this MID$ garbage to access bytes in

' font buffer, we'll just take a PEEK directly at them.

DEF SEG = VARSEG(FontBuf(0))



 FOR h% = 1 TO LEN(text$)

  FPtr% = 81 * (ASC(MID$(text$, h%, 1)) - 1) - 1

  FOR x% = 0 TO 8

   FOR y% = 0 TO 8



    COL% = PEEK(VARPTR(FontBuf(0)) + FPtr%)

    FPtr% = FPtr% + 1

    IF COL% THEN

     SELECT CASE style%

      ' If you desire a y scale factor greater than 8, you

      ' must change the division to higher precision...very slow.

      ' Or, you could find a way around it.

      CASE 1: PSET (px%, py%), Optimize% * (py% - ystart%) + Clr%

              LINE (px%, py%)-(px%, py% + Yscale%), Optimize% * (py% - ystart%) + Clr%

      ' Notice how this style only uses 54 colors, so you can see the top

      ' of the letters where they would normally be black

      CASE 2: CIRCLE (px%, py%), Yscale%, (54 \ LHeight%) * (py% - ystart%) + Clr% + 9, , , 4

      CASE 3:  FOR sty% = px% TO px% + xscale%

                FOR sty2% = py% TO py% + Yscale%

                 PSET (sty%, sty2%), Optimize% * (sty2% - ystart%) + Clr%

                 IF POINT(sty% - 1, sty2%) = 0 THEN PSET (sty% - 1, sty2%), 63 + Clr% - 1

                 IF POINT(sty%, sty2% - 1) = 0 THEN PSET (sty%, sty2% - 1), 63 + Clr% - 1

                NEXT

               NEXT

       CASE 4: FOR sty% = px% TO px% + xscale%

                FOR sty2% = py% TO py% + Yscale%

                 PSET (sty% + .4 * sty2%, sty2%), Optimize% * (sty2% - ystart%) + Clr%

                 IF POINT((sty% - 1) + .4 * sty2%, sty2%) = 0 THEN PSET ((sty% - 1) + .4 * sty2%, sty2%), 63 + Clr% - 1

                NEXT

               NEXT



     END SELECT

    END IF

    py% = py% + Yscale%

   NEXT

  px% = px% + xscale%

  py% = ystart%

  NEXT

 NEXT h%

DEF SEG

END SUB

SUB getpress

DO

aa$ = INKEY$

LOOP UNTIL aa$ <> ""

END SUB

SUB MakeFont

OPEN "basefont.dat" FOR BINARY AS #1

' Hey, change 128 to 255 for the full font.

CLS

SCREEN 13

COLOR 16

FOR ascii% = 1 TO 255

 CLS

 PRINT CHR$(ascii%)

 FOR x = 0 TO 8

  FOR y = 0 TO 8

   pnt$ = CHR$(POINT(x, y))

   PUT #1, , pnt$

   pnt$ = ""

  NEXT

 NEXT

NEXT

CLOSE

OPEN "basefont.dat" FOR BINARY AS #1

 GET #1, , FontBuf(0)

CLOSE #1

END SUB

SUB newtext
CLS
introtext:
CLS
colour:
CLS
PRINT "What color do you want your title to be?"
PRINT "(1. red, 2. green, 3. blue, or 4. purple)"
INPUT color$
IF color$ = "1" THEN c% = 0
IF color$ = "2" THEN c% = 63
IF color$ = "3" THEN c% = 126
IF color$ = "4" THEN c% = 190
IF color$ = "" THEN GOTO colour
style:
CLS
PRINT "What style do you want your title to be?"
PRINT "(1. circular, 2. normal, or 3.italic)"
INPUT color$
IF color$ = "1" THEN S% = 2
IF color$ = "2" THEN S% = 3
IF color$ = "3" THEN S% = 4
IF color$ = "" THEN GOTO style

CLS
PRINT "Type name of title(up to 12 characters)"
3 INPUT title$
CLS
SCREEN 13
SetPal
font title$, 0, 60, 3, 3, S%, c%
getpress
isr:
CLS
SCREEN 12
COLOR 15
PRINT "Is this right?(y/n)"
INPUT r$
IF r$ = "n" OR r$ = "N" THEN GOTO introtext
IF r$ = "y" OR r$ = "Y" THEN GOTO sofar
IF r$ = "" THEN GOTO isr
GOTO isr

sofar:
CLS
PRINT "Your game so far....."
getpress
SCREEN 13
SetPal
font title$, 0, 60, 3, 3, S%, c%
getpress
GOTO music

music:
CLS
SCREEN 12
PRINT "Now you can make opening music for your game."
again:
PRINT "The scale is CDEFGAB. C being the highest, B being the lowest."
getpress
PRINT "Type in your opening tune. Press enter to hear it"
INPUT tune$
PLAY tune$
ads:
CLS
PRINT "Is this right?"
INPUT r$
IF r$ = "y" OR r$ = "Y" THEN GOTO sofar2
IF r$ = "n" OR r$ = "N" THEN GOTO music
GOTO ads
sofar2:
CLS
PRINT "Your game so far....."
getpress
SCREEN 13
SetPal
font title$, 0, 60, 3, 3, S%, c%
PLAY tune$
getpress
first:
CLS
SCREEN 12
CLS
SCREEN 12
PRINT "Now you will make the character selection screen"
getpress
names:
CLS
PRINT "Type the name of your first character"
INPUT firstchar$
PRINT "Now type in a one line description of your first character"
INPUT des1$
PRINT "Type the name of your second character"
INPUT secchar$
PRINT "Now type in a one line description of your second character "
INPUT des2$
PRINT "Type the name of your third character"
INPUT thirdchar$
PRINT "Now type in a one line description of your third character"
INPUT des3$
PRINT "Type the name of your fourth character"
INPUT forchar$
PRINT "Now type in a one line description of your fourth character"
INPUT des4$
add:
CLS
PRINT "Is this right?"
PRINT "1. "; firstchar$
PRINT des1$
PRINT "2. "; secchar$
PRINT des2$
PRINT "3. "; thirdchar$
PRINT des3$
PRINT "3. "; forchar$
PRINT des4$
INPUT x$
IF x$ = "y" OR x$ = "Y" THEN GOTO sofar3
IF x$ = "n" OR x$ = "N" THEN GOTO names
IF x$ = "" THEN GOTO names
GOTO add
sofar3:
CLS
PRINT "Your game so far....."
getpress
SCREEN 13
SetPal
font title$, 0, 60, 3, 3, S%, c%
PLAY tune$
getpress
SCREEN 12
COLOR 2
PRINT "Choose a Character"
COLOR 15
PRINT
PRINT "1. "; firstchar$
PRINT des1$
PRINT "2. "; secchar$
PRINT des2$
PRINT "3. "; thirdchar$
PRINT des3$
PRINT "3. "; forchar$
PRINT des4$
INPUT x$
IF x$ = "1" THEN name$ = firstchar$
IF x$ = "2" THEN name$ = secchar$
IF x$ = "3" THEN name$ = thirdchar$
IF x$ = "4" THEN name$ = forchar$
CLS
PRINT "You choose "; name$
getpress
CLS
PRINT "Now you will Create the scenes."
getpress
ga:
CLS
PRINT "Type the name of an enemy to put in the opening scene."
INPUT "Enemys name:"; bad$


CLS
PRINT "Type the name of an object to put in the opening scene."
INPUT "objects name: "; obj$

CLS
PRINT "Type the name of the room your character starts in."
INPUT "rooms name: "; rm1$
CLS
PRINT "Type in a one line description of the room"
INPUT der1$

CLS
PRINT "Type the name of an another enemy to put in another scene."
INPUT "Enemys name:"; bad2$

CLS
PRINT "Type the name of an another object to put in the another scene."
INPUT "objects name: "; obj2$

CLS
PRINT "Type the name of the another room your character can be in. "
INPUT "rooms name: "; rm2$
PRINT "Type in a one line description of the room"
INPUT der2$

CLS
PRINT "Type the name of a third enemy to put in another scene."
INPUT "Enemys name:"; bad3$

CLS
PRINT "Type the name of a third  object to put in the another scene."
INPUT "objects name: "; obj3$

CLS
PRINT "Type the name of the third room your character can be in. "
INPUT "rooms name: "; rm3$
PRINT "Type in a one line description of the room"
INPUT der3$


right:
CLS
PRINT "Is this right?"
PRINT "Enemy: "; bad$
PRINT "Object: "; obj$
PRINT "Starting Room: "; rm1$
PRINT
PRINT "Enemy2: "; bad2$
PRINT "Object2: "; obj2$
PRINT "Room2: "; rm2$
PRINT
PRINT "Enemy3: "; bad3$
PRINT "Object3: "; obj3$
PRINT "Room3: "; rm3$
INPUT x$
IF x$ = "y" OR x$ = "Y" THEN GOTO blaa
IF x$ = "n" OR x$ = "N" THEN GOTO ga
IF x$ = "" THEN GOTO right




GOTO right
blaa:
CLS
COLOR 15
PRINT "What weapon do you want the character to start with?"
INPUT weapon$
sofar4:
agaiin:
CLS
PRINT "Your game........"
getpress
SCREEN 13
SetPal
font title$, 0, 60, 3, 3, S%, c%
PLAY tune$
getpress
SCREEN 12
COLOR 2
PRINT "Choose a Character"
COLOR 15
PRINT "1. "; firstchar$
PRINT des1$
PRINT "2. "; secchar$
PRINT des2$
PRINT "3. "; thirdchar$
PRINT des3$
PRINT "3. "; forchar$
PRINT des4$
PRINT
INPUT x$
IF x$ = "1" THEN name$ = firstchar$
IF x$ = "2" THEN name$ = secchar$
IF x$ = "3" THEN name$ = thirdchar$
CLS
PRINT "You choose "; name$
getpress
tryu:
CLS
PRINT "You are in the "; rm1$; "........"
PRINT
PRINT "1. Attack.....   2. Take......  3.Look......."
PRINT "You are carring:"; weapon$
INPUT "What do you want to do?", com$
IF com$ = "1" THEN GOTO fight
IF com$ = "2" THEN GOTO take
IF com$ = "3" THEN GOTO look
IF com$ = "" THEN GOTO tryu
GOTO tryu

look:
PRINT "You look around the "; rm1$
PRINT der1$
INPUT x$
GOTO tryu

take:
PRINT "You try to take the "; obj$; " but the "; bad$; " is in your way!"
getpress
GOTO tryu

fight:
CLS
PRINT "1. Fight the "; bad$
PRINT "2. Run away"
INPUT x$
IF x$ = "1" THEN GOTO fightoo
IF x$ = "2" THEN GOTO tryu
GOTO fight

fightoo:
CLS
PRINT "Prepare for a fight"
INPUT b$
PRINT "A "; bad$; " approaches......"
INPUT b$
PRINT
t = 50
p = 70
START:
CLS
LET t = t - x%
PRINT "HP.............."; t
PRINT "You attack....."
INPUT f$
PRINT "You use your "; weapon$; " against it"
PLAY "T160O0L32EFGEFDC"
y% = INT(RND * 6) + 15
LET p = p - y%
COLOR 2
PRINT "you take off "; y%; "hp"
COLOR 15
PRINT
IF p < 0 THEN GOTO mondead
PRINT "The "; bad$; " has "; p; " hp left"
INPUT x$
CLS
GOTO monatt

monatt:
PRINT "The "; bad$; " attacks......."

x% = INT(RND * 6)
INPUT x$
PLAY "T160O0L32EFGEFDC"
COLOR 2
PRINT "The "; bad$; " takes off"; x%; " hp"
COLOR 15
PRINT
LET t = t - x%
PRINT "you have "; t; " hp left"
INPUT x$
IF t < 0 THEN GOTO youdead
IF t > 1 THEN GOTO START

youdead:
CLS
PRINT "The "; bad$; " killed you!"
GOTO agaiin

mondead:
INPUT x$
CLS
PRINT
PRINT "The "; bad$; " has been killed!"
PRINT "you take the "; obj$; " and go to the next room."
getpress
CLS
PRINT "You Enter the next room........"
getpress
tryu2:
CLS
PRINT "You are in the "; rm2$; "........"
PRINT
PRINT "1. Attack.....   2. Take......  3.Look......."
PRINT "You are carring:"; weapon$; ", "; obj$
INPUT "What do you want to do?", com$
IF com$ = "1" THEN GOTO fight2
IF com$ = "2" THEN GOTO take2
IF com$ = "3" THEN GOTO look2
IF com$ = "" THEN GOTO tryu2
GOTO tryu2

look2:
PRINT "You look around the "; rm2$
PRINT der1$
INPUT x$
GOTO tryu2

take2:
PRINT "You try to take the "; obj2$; " but the "; bad2$; " is in your way!"
getpress
GOTO tryu2

fight2:
CLS
PRINT "1. Fight the "; bad$
PRINT "2. Run away"
INPUT x$
IF x$ = "1" THEN GOTO fightoo2
IF x$ = "2" THEN GOTO tryu2
GOTO fight2

fightoo2:
CLS
PRINT "Prepare for a fight"
INPUT b$
PRINT "A "; bad2$; " approaches......"
INPUT b$
PRINT
t = 200
p = 70
START2:
CLS
LET t = t - x%
PRINT "HP.............."; t
PRINT "You attack....."
INPUT f$
PRINT "You use your "; weapon$; " against it "
PLAY "T160O0L32EFGEFDC"
y% = INT(RND * 6) + 15
LET p = p - y%
COLOR 2
PRINT "you take off "; y%; "hp"
COLOR 15
PRINT
IF p < 0 THEN GOTO mondead
PRINT "The "; bad$; " has "; p; " hp left"
INPUT x$
CLS
GOTO monatt2

monatt2:
PRINT "The "; bad2$; " attacks......."

x% = INT(RND * 6)
INPUT x$
PLAY "T160O0L32EFGEFDC"
COLOR 2
PRINT "The "; bad$; " takes off"; x%; " hp"
COLOR 15
PRINT
LET t = t - x%
PRINT "you have "; t; " hp left"
INPUT x$
IF t < 0 THEN GOTO youdead2
IF t > 1 THEN GOTO START2

youdead2:
CLS
PRINT "The "; bad$; " killed you!"
GOTO agaiin

mondead2:
INPUT x$
CLS
PRINT
PRINT "The "; bad2$; " has been killed!"
PRINT "you take the "; obj2$; " and go to the next room."
getpress

CLS
PRINT "You enter the last room........"
tryu3:
CLS
PRINT "You are in the "; rm3$; "........"
PRINT
PRINT "1. Attack.....   2. Take......  3.Look......."
PRINT "You are carring: "; weapon$; ", "; obj$; ", "; obj2$
INPUT "What do you want to do?", com$
IF com$ = "1" THEN GOTO fight3
IF com$ = "2" THEN GOTO take3
IF com$ = "3" THEN GOTO look3
IF com$ = "" THEN GOTO tryu3
GOTO tryu3

look3:
PRINT "You look around the "; rm3$
PRINT der3$
INPUT x$
GOTO tryu

take3:
PRINT "You try to take the "; obj3$; " but the "; bad3$; " is in your way!"
getpress
GOTO tryu3

fight3:
CLS
PRINT "1. Fight the "; bad3$
PRINT "2. Run away"
INPUT x$
IF x$ = "1" THEN GOTO fightoo3
IF x$ = "2" THEN GOTO tryu3
GOTO fight3

fightoo3:
CLS
PRINT "Prepare for a fight"
INPUT b$
PRINT "A "; bad$; " approaches......"
INPUT b$
PRINT
t = 50
p = 70
START3:
CLS
LET t = t - x%
PRINT "HP.............."; t
PRINT "You attack....."
INPUT f$
PRINT "You use your "; weapon$; " against it "
PLAY "T160O0L32EFGEFDC"
y% = INT(RND * 6) + 15
LET p = p - y%
COLOR 2
PRINT "you take off "; y%; "hp"
COLOR 15
PRINT
IF p < 0 THEN GOTO mondead3
PRINT "The "; bad3$; " has "; p; " hp left"
INPUT x$
CLS
GOTO monatt3

monatt3:
PRINT "The "; bad3$; " attacks......."

x% = INT(RND * 6)
INPUT x$
PLAY "T160O0L32EFGEFDC"
COLOR 2
PRINT "The "; bad3$; " takes off"; x%; " hp"
COLOR 15
PRINT
LET t = t - x%
PRINT "you have "; t; " hp left"
INPUT x$
IF t < 0 THEN GOTO youdead3
IF t > 1 THEN GOTO START3

youdead3:
CLS
PRINT "The "; bad3$; " killed you!"
GOTO agaiin

mondead3:
INPUT x$
CLS
PRINT
PRINT "The "; bad3$; " has been killed!"
PRINT "you take the "; obj3$
PRINT "You Win......"
getpress

PRINT
CLS
SCREEN 13
SetPal
font "The End", 20, 60, 3, 3, 3, 0
getpress
CLS
7 END
END SUB

SUB SetPal

FOR x% = 1 TO 63

 OUT &H3C8, x%

 OUT &H3C9, x%

 OUT &H3C9, 0

 OUT &H3C9, 0

NEXT

FOR x% = 64 TO 126

 OUT &H3C8, x%

 OUT &H3C9, 0

 OUT &H3C9, x%

 OUT &H3C9, 0

NEXT

FOR x% = 127 TO 189

 OUT &H3C8, x%

 OUT &H3C9, 0

 OUT &H3C9, 0

 OUT &H3C9, x%

NEXT

FOR x% = 190 TO 252

 OUT &H3C8, x%

 OUT &H3C9, x%

 OUT &H3C9, 0

 OUT &H3C9, x%

NEXT

FOR x% = 253 TO 255

 OUT &H3C8, x%

 OUT &H3C9, x%

 OUT &H3C9, x%

 OUT &H3C9, x%

NEXT



END SUB

