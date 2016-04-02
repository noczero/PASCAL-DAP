' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
DECLARE SUB win ()
DECLARE SUB lose ()
DECLARE SUB save ()
DECLARE SUB load ()
DECLARE SUB getmission ()
DECLARE SUB lastbattle ()
DECLARE SUB lastwin ()
DECLARE SUB lastlose ()
DECLARE SUB title ()
DECLARE SUB getenemy ()
DECLARE SUB stats ()
DECLARE SUB help ()
DECLARE SUB fightmenu ()
DECLARE SUB game ()
COMMON SHARED player$, ship$, gun$, hp, max.hp, score, cash, missle, dam, uop
COMMON SHARED enemy$, egun$, ehp, emissle, edam, ecash
ON ERROR GOTO errorr
CLEAR , , 1000
CALL title
showmenu:
SCREEN 13
CLS
LOCATE 6, 15: COLOR 4: PRINT "MAIN  MENU"
LOCATE 8, 16: COLOR 9: PRINT "[1] Play"
LOCATE 9, 16: PRINT "[2] Load"
LOCATE 10, 16: PRINT "[3] Help"
LOCATE 11, 16: PRINT "[4] Quit"
DO
a$ = INKEY$
IF a$ = "1" THEN GOTO GameStart
IF a$ = "2" THEN CALL load
IF a$ = "3" THEN CALL help: GOTO showmenu
IF a$ = "4" THEN LOCATE 13, 16: COLOR 14: PRINT "Good bye": COLOR 0: END
LOOP

GameStart:
LOCATE 13, 5: INPUT "What is your name: ", player$
player$ = UCASE$(LEFT$(player$, 8))
max.hp = 75: hp = max.hp
dam = 5
cash = 100
missle = 5
ship$ = "Þ฿Ý"
gun$ = "+ +"
CALL game

errorr:
CLS
SCREEN 13
DO
COLOR 4: PRINT "ERROR  ERROR  ERROR  ERROR  ERROR  ERROR"
LOOP UNTIL INKEY$ <> ""
END

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
'
SUB fightmenu
SCREEN 12
FOR x = 2 TO 27
FOR y = 1 TO 80
LOCATE x, y: COLOR 4: PRINT "ฐ"
NEXT y
NEXT x
FOR x = 1 TO 3
FOR y = 1 TO 80
LOCATE x, y: COLOR 9: PRINT "ฑ"
NEXT y
NEXT x
LOCATE 2, 26: COLOR 14: PRINT "  S T A R    F I G H T E R  "
LOCATE 28, 71: COLOR 1: PRINT "JEM GAMES"
j$ = "บ                                        บ"
LOCATE 5, 3: COLOR 15: PRINT "ษออออออออออออออออออออออออออออออออออออออออป"
LOCATE 6, 3: COLOR 15: PRINT j$
LOCATE 7, 3: COLOR 15: PRINT j$
LOCATE 8, 3: COLOR 15: PRINT j$
LOCATE 9, 3: COLOR 15: PRINT j$
LOCATE 10, 3: COLOR 15: PRINT j$
LOCATE 11, 3: COLOR 15: PRINT j$
LOCATE 12, 3: COLOR 15: PRINT j$
LOCATE 13, 3: COLOR 15: PRINT j$
LOCATE 14, 3: COLOR 15: PRINT j$
LOCATE 15, 3: COLOR 15: PRINT j$
LOCATE 16, 3: COLOR 15: PRINT "ศออออออออออออออออออออออออออออออออออออออออผ"

LOCATE 5, 63: PRINT "ษออออออออออออออป"
LOCATE 6, 63: PRINT "บHP:           บ"
LOCATE 7, 63: PRINT "บScore:        บ"
LOCATE 8, 63: PRINT "บCredits:      บ"
LOCATE 9, 63: PRINT "บMissles:      บ"
LOCATE 10, 63: PRINT "วฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ"
LOCATE 11, 63: PRINT "บ              บ"
LOCATE 12, 63: PRINT "ศออออออออออออออผ"
LOCATE 6, 67: COLOR 14: PRINT hp; "/"; max.hp: IF hp <= (max.hp / 3) THEN LOCATE 6, 67: COLOR 4: PRINT hp
LOCATE 7, 70: COLOR 14: PRINT score
LOCATE 8, 72: COLOR 14: PRINT cash
LOCATE 9, 72: COLOR 14: PRINT missle
LOCATE 11, 67: COLOR 14: PRINT player$

END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB game
CALL getenemy
CALL fightmenu
y = 19
e = 10
LOCATE 9, 19: COLOR 4: PRINT "*FIGHT*"
delay = 1000
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 9, 19: PRINT "       "
DO
a$ = INKEY$
IF a$ = "4" THEN go$ = "L"
IF a$ = "6" THEN go$ = "R"
IF a$ = " " THEN GOSUB fire
IF a$ = "+" AND missle > 0 THEN GOSUB missle
IF a$ = "P" OR a$ = "p" THEN GOSUB PAUSE
IF a$ = "Q" OR a$ = "q" THEN END
IF a$ = "{" THEN GOSUB special
CALL stats
GOSUB movement
GOSUB moveenemy
LOOP

movement:
delay = 100
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 6, y: PRINT "   "
IF go$ = "L" THEN y = y - 1
IF go$ = "R" THEN y = y + 1
IF y = 3 THEN go$ = "R": y = y + 1
IF y = 42 THEN go$ = "L": y = y - 1
LOCATE 6, y: COLOR 15: PRINT ship$
RETURN

fire:
FOR a = 1 TO 5: FOR B = 450 TO 1 STEP -80
SOUND 99 + B, .3
NEXT: NEXT
FOR x = 7 TO 15
LOCATE x, y: COLOR 4: PRINT gun$
delay = 50
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE x, y: PRINT "   "
NEXT x
LOCATE 15, y: COLOR 4: PRINT "***"
delay = 200
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 15, y: PRINT "   "
IF y = e OR y = e + 1 OR y = e + 2 OR y = e - 1 OR y = e - 2 THEN ehp = ehp - dam
score = score + 100
IF ehp <= 0 THEN CALL win
RETURN

missle:
missle = missle - 1
FOR x = 7 TO 15
LOCATE x, y + 1: COLOR 1: PRINT "Û"
delay = 200
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE x, y + 1: PRINT " "
NEXT x
LOCATE 15, y - 1: COLOR 4: PRINT "*****"
delay = 300
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 15, y - 1: PRINT "     "
IF y = e OR y = e + 1 OR y = e + 2 OR y = e + 3 OR y = e - 1 OR y = e - 2 OR y = e - 3 THEN ehp = ehp - 25
score = score + 50
IF ehp <= 0 THEN CALL win
RETURN

PAUSE:
LOCATE 9, 19: COLOR 14: PRINT "*PAUSE*"
DO: LOOP UNTIL INKEY$ <> ""
LOCATE 9, 19: PRINT "       "
RETURN

moveenemy:
RANDOMIZE TIMER
move = INT(RND * 9)
IF move = 1 THEN ego$ = "L"
IF move = 2 THEN ego$ = "R"
IF move = 5 AND emissle > 0 THEN GOSUB emissle: RETURN
IF move = 8 THEN GOSUB efire: RETURN
IF ego$ = "L" THEN LOCATE 15, e: PRINT "   ": : e = e - 1
IF ego$ = "R" THEN LOCATE 15, e: PRINT "   ": : e = e + 1
IF e = 3 THEN ego$ = "R": e = e + 1
IF e = 42 THEN ego$ = "L": e = e - 1
LOCATE 15, e: COLOR 15: PRINT enemy$
RETURN

efire:
FOR x = 14 TO 6 STEP -1
LOCATE x, e: COLOR 4: PRINT egun$
delay = 100
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE x, e: PRINT "   "
NEXT x
LOCATE 6, e: COLOR 4: PRINT "***"
delay = 200
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 6, e: PRINT "   "
IF y = e OR y = e + 1 OR y = e + 2 OR y = e - 1 OR y = e - 2 THEN hp = hp - edam
IF hp <= 0 THEN CALL lose
RETURN


emissle:
emissle = emissle - 1
FOR x = 14 TO 6
LOCATE x, e + 1: COLOR 9: PRINT "Û"
delay = 200
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE x, e + 1: PRINT " "
NEXT x
LOCATE 6, e - 1: COLOR 4: PRINT "*****"
delay = 300
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 6, e - 1: PRINT "     "
IF y = e OR y = e + 1 OR y = e + 2 OR y = e + 3 OR y = e - 1 OR y = e - 2 OR y = e - 3 THEN hp = hp - 25
IF hp <= 0 THEN CALL lose
RETURN


special:
FOR x = 7 TO 15
LOCATE x, 5: COLOR 1: PRINT "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
delay = 250
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE x, 5: COLOR 1: PRINT "                                       "
NEXT x
LOCATE 15, 5: COLOR 1: PRINT "***************************************"
delay = 200
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 15, 5: COLOR 1: PRINT "                                       "
ehp = ehp - (score / 2)
IF ehp <= 0 THEN CALL win
RETURN
END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB getenemy
findone:
RANDOMIZE TIMER
find = INT(RND * 5)
IF find = 0 THEN GOTO findone
IF find = 1 THEN
        enemy$ = "ÞÜÝ"
        egun$ = "* *"
        emissle = 0
        ehp = (dam * 2)
        edam = 5
        ecash = 25
END IF
IF find = 2 THEN
        enemy$ = "^฿^"
        egun$ = "! !"
        emissle = 2
        ehp = (dam * 3)
        edam = (hp * 5)
        ecash = 50
END IF
IF find = 3 THEN
        enemy$ = "ฎ^ฏ"
        egun$ = " I "
        emissle = 1
        ehp = (dam * 4)
        edam = (hp * 8)
        ecash = 30
END IF
IF find = 4 THEN
        enemy$ = "=o="
        egun$ = " U "
        emissle = 3
        ehp = (dam * 6)
        edam = (hp * 7)
        ecash = 35
END IF
IF find = 5 THEN
        enemy$ = "!Ü!"
        egun$ = "! !"
        emissle = 1
        ehp = (dam * 7)
        edam = (hp * 5)
        ecash = 55
END IF
END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB getmission
CLS
SCREEN 13
COLOR 15
LOCATE 2, 2: PRINT player$; ","
LOCATE 3, 1: PRINT "    We have finnished construction of"
LOCATE 4, 1: PRINT "  our top secret "; : COLOR 14: PRINT "STAR FIGHTER"; : COLOR 15: PRINT ". You have"
LOCATE 5, 1: PRINT "  been chosen by myself to piolet this"
LOCATE 6, 1: PRINT "  ship. You must intercept the Martian"
LOCATE 7, 1: PRINT "  War Ship ASAP."
 LOCATE 9, 2: PRINT "                 President A.F. Mickle"
LOCATE 10, 2: PRINT "                  Earth Defence Force"
DO: LOOP UNTIL INKEY$ <> ""
ship$ = ")์("
gun$ = " ็ "
dam = 1
max.hp = 65: hp = max.hp
missle = 0
uop = 1
CALL save
CALL lastbattle
END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB help
SCREEN 13
CLS
LOCATE 5, 15: COLOR 14: PRINT "STAR FIGHTER"
LOCATE 7, 15: COLOR 15: PRINT "[4] Move Left  "
          LOCATE 8, 15: PRINT "[6] Move Right "
          LOCATE 9, 15: PRINT "[ ] Fire Weapon"
          LOCATE 10, 15: PRINT "[+] Fire Missle"
         LOCATE 11, 15: PRINT "[P] Pause      "
         LOCATE 12, 15: PRINT "[Q] Quit       "
DO: LOOP UNTIL INKEY$ <> ""
END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB lastbattle
CLS
SCREEN 12
CALL fightmenu
bg1$ = "ÝษÛปÞ"
bg2$ = "ÛสÛสÛ"
bg3$ = "^ ^ ^"
ehp = 20
edam = 1
y = 19
e = 10
LOCATE 9, 19: COLOR 4: PRINT "*FIGHT*"
delay = 1000
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 9, 19: PRINT "       "
DO
a$ = INKEY$
IF a$ = "4" THEN go$ = "L"
IF a$ = "6" THEN go$ = "R"
IF a$ = " " THEN GOSUB fire1
IF a$ = "P" OR a$ = "p" THEN GOSUB PAUSE1
IF a$ = "Q" OR a$ = "q" THEN END
IF a$ = "|" THEN GOSUB special1
CALL stats
GOSUB movement1
GOSUB moveenemy1
LOOP

movement1:
delay = 100
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 6, y: PRINT "   "
IF go$ = "L" THEN y = y - 1
IF go$ = "R" THEN y = y + 1
IF y = 3 THEN go$ = "R": y = y + 1
IF y = 42 THEN go$ = "L": y = y - 1
LOCATE 6, y: COLOR 15: PRINT ship$
RETURN

fire1:
FOR a = 1 TO 5: FOR B = 450 TO 1 STEP -80
SOUND 99 + B, .3
NEXT: NEXT
FOR x = 7 TO 13
LOCATE x, y: COLOR 4: PRINT gun$
delay = 50
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE x, y: PRINT "   "
NEXT x
LOCATE 13, y: COLOR 4: PRINT "***"
delay = 200
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 13, y: PRINT "   "
IF y = e OR y = e + 1 OR y = e + 2 OR y = e - 1 OR y = e - 2 THEN ehp = ehp - dam
score = score + 100
IF ehp <= 0 THEN CALL lastwin
RETURN

PAUSE1:
LOCATE 9, 19: COLOR 14: PRINT "*PAUSE*"
DO: LOOP UNTIL INKEY$ <> ""
LOCATE 9, 19: PRINT "       "
RETURN

moveenemy1:
RANDOMIZE TIMER
move = INT(RND * 9)
IF move = 1 THEN ego$ = "L"
IF move = 2 THEN ego$ = "R"
IF move = 8 THEN GOSUB efire1: RETURN
IF move = 6 THEN GOSUB especial: RETURN
IF ego$ = "L" THEN LOCATE 15, e: PRINT "     ": LOCATE 14, e: PRINT "     ": LOCATE 13, e: PRINT "     ": e = e - 1
IF ego$ = "R" THEN LOCATE 15, e: PRINT "     ": LOCATE 14, e: PRINT "     ": LOCATE 13, e: PRINT "     ": e = e + 1
IF e = 3 THEN ego$ = "R": e = e + 1
IF e = 43 THEN ego$ = "L": e = e - 1
LOCATE 13, e: COLOR 15: PRINT bg1$
LOCATE 14, e: COLOR 15: PRINT bg2$
LOCATE 15, e: COLOR 15: PRINT bg3$
RETURN

efire1:
FOR x = 12 TO 6 STEP -1
LOCATE x, e: COLOR 4: PRINT egun$
delay = 100
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE x, e: PRINT "     "
NEXT x
LOCATE 6, e: COLOR 4: PRINT "*****"
delay = 200
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 6, e: PRINT "     "
IF y = e OR y = e + 1 OR y = e + 2 OR y = e - 1 OR y = e - 2 OR y = e - 3 OR y = e + 3 THEN hp = hp - edam
IF hp <= 0 THEN CALL lastlose
RETURN

especial:
FOR x = 13 TO 6 STEP -1
LOCATE x, e: COLOR 4: PRINT bg1$
LOCATE x + 1, e: COLOR 4: PRINT bg2$
LOCATE x + 2, e: COLOR 4: PRINT bg3$
delay = 50
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE x, e: COLOR 4: PRINT "     "
LOCATE x + 1, e: COLOR 4: PRINT "     "
LOCATE x + 2, e: COLOR 4: PRINT "     "
NEXT x
FOR x = 6 TO 13
LOCATE x, e: COLOR 4: PRINT bg1$
LOCATE x + 1, e: COLOR 4: PRINT bg2$
LOCATE x + 2, e: COLOR 4: PRINT bg3$
delay = 50
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE x, e: COLOR 4: PRINT "     "
LOCATE x + 1, e: COLOR 4: PRINT "     "
LOCATE x + 2, e: COLOR 4: PRINT "     "
NEXT x
RETURN
IF y = e OR y = e + 1 OR y = e + 2 OR y = e - 1 OR y = e - 2 OR y = e - 3 OR y = e + 3 THEN hp = hp - (edam + 10)
IF hp <= 0 THEN CALL lastlose

special1:
FOR x = 4 TO 39
FOR z = 8 TO 15
RANDOMIZE TIMER
crayola = INT(RND * 15)
LOCATE z, x: COLOR crayola: PRINT "*"
NEXT z
NEXT x
delay = 500
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
FOR x = 4 TO 39
FOR z = 8 TO 15
LOCATE z, x: PRINT " "
NEXT z
NEXT x
ehp = ehp = .5
IF ehp <= 0 THEN CALL lastwin
RETURN
END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB lastlose
FOR x = 1 TO 28
FOR y = 1 TO 80
LOCATE x, y: COLOR 4: PRINT "Û"
NEXT y
NEXT x
LOCATE 14, 27: COLOR 4: PRINT " You were defeated by the "
LOCATE 15, 27: COLOR 4: PRINT "     Martian War Ship     "
TIME$ = "00:00:00"
DO: LOOP UNTIL TIME$ = "00:00:03"
FOR x = 28 TO 1 STEP -1
FOR y = 80 TO 1 STEP -1
LOCATE x, y: COLOR 0: PRINT "Û"
NEXT y
NEXT x
END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB lastwin
FOR x = 1 TO 28
FOR y = 1 TO 80
LOCATE x, y: COLOR 14: PRINT "Û"
NEXT y
NEXT x
LOCATE 13, 33: PRINT "              "
LOCATE 14, 33: COLOR 15: PRINT "  YOU WON!!!  "
LOCATE 15, 33: PRINT "              "
DO: LOOP UNTIL INKEY$ <> ""
LOCATE 17, 30: PRINT " YOU BEAT THIS GAME "
DO: LOOP UNTIL INKEY$ <> ""
END
END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB load
LOCATE 13, 5: INPUT "Load who? ", loadname$
loadname$ = (UCASE$(LEFT$(loadname$, 8)) + ".sf1")
OPEN loadname$ FOR INPUT AS #1
INPUT #1, player$, ship$, gun$, hp, max.hp, score, cash, missle, dam, uop
CLOSE
IF uop = 1 THEN CALL lastbattle
CALL game
END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB lose
CLS : SCREEN 13
COLOR 4
LOCATE 3, 15: PRINT "You died!!"
RANDOMIZE TIMER
darn = INT(RND * cash)
LOCATE 4, 10: PRINT "You lost"; darn; "credits!"
hp = max.hp: cash = cash - darn: CALL save: END
END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB save
savename$ = (UCASE$(LEFT$(player$, 8)) + ".sf1")
OPEN savename$ FOR OUTPUT AS #1
WRITE #1, player$, ship$, gun$, hp, max.hp, score, cash, missle, dam, uop
CLOSE
END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB stats
COLOR 15
LOCATE 5, 63: PRINT "ษออออออออออออออป"
LOCATE 6, 63: PRINT "บHP:           บ"
LOCATE 7, 63: PRINT "บScore:        บ"
LOCATE 8, 63: PRINT "บCredits:      บ"
LOCATE 9, 63: PRINT "บMissles:      บ"
LOCATE 10, 63: PRINT "วฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ"
LOCATE 11, 63: PRINT "บ              บ"
LOCATE 12, 63: PRINT "ศออออออออออออออผ"
IF missle >= 26 THEN missle = 25
IF cash >= 2500 THEN cash = 2500
IF max.hp >= 501 THEN max.hp = 500
IF hp >= max.hp THEN hp = max.hp
IF score > 999999 THEN score = 0
LOCATE 6, 67: COLOR 14: PRINT hp; "/"; max.hp: IF hp <= (max.hp / 3) THEN LOCATE 6, 67: COLOR 4: PRINT hp
LOCATE 7, 70: COLOR 14: PRINT score
LOCATE 8, 72: COLOR 14: PRINT cash
LOCATE 9, 72: COLOR 14: PRINT missle
LOCATE 11, 67: COLOR 14: PRINT player$
END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB title
CLS
SCREEN 13
COLOR 14
FOR x = 3 TO 16
LOCATE 9, x - 2: PRINT " "
delay = 100
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 9, x - 1: COLOR 14: PRINT " S T A R"
NEXT x
FOR x = 23 TO 10 STEP -1
LOCATE x, 16: COLOR 14: PRINT "FIGHTER"
delay = 100
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE x, 16: PRINT "       "
NEXT x
LOCATE 10, 16: COLOR 14: PRINT "FIGHTER"
PLAY "o4c2g2f6e6d6o5c2o4g2f6e6d6o5c2o4g2f6e6f6d2o4c2g2f6e6d6o5c2o4g2f6e6d6o5c2o4g2f6e6f6d2"
FOR x = 16 TO 33
LOCATE 10, x: COLOR 14: PRINT "FIGHTER"
delay = 100
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 10, x: PRINT "       "
NEXT x
FOR x = 9 TO 1 STEP -1
LOCATE x, 16: COLOR 14: PRINT "S T A R"
delay = 100
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE x, 16: PRINT "       "
NEXT x
FOR x = 1 TO 200
CIRCLE (160, 100), x, 14
NEXT x
FOR x = 1 TO 200
CIRCLE (160, 100), x, 4
NEXT x
FOR x = 1 TO 200
CIRCLE (160, 100), x, 1
NEXT x
FOR x = 200 TO 1 STEP -1
CIRCLE (160, 100), x, 0
NEXT x
FOR x = 2 TO 14
LOCATE 5, x: COLOR 14: PRINT "STAR FIGHTER"
delay = 100
DO
delay = delay - 1
IF delay = 0 THEN EXIT DO
LOOP
LOCATE 5, x - 1: PRINT " "
NEXT x

END SUB

' STAR FIGHTER
'
'       This is a space shoot 'em up that I made very quickly. It's not
'       the greatest game in the world but it's fun. You control the ship
'       on the top of the battlefield. The SPACE key fires and the 4 and 6
'       keys move you back and fourth. There is a help menu if you forget.
'       There are two secrets and one Martian War Ship!!
'    
'       Please send any comments, questions, or ideas to JEM GAMES@aol.com
'    
'
'
'
'
'
'
'
'                                                                    JEM GAMES
'
'
'
'
'
'*****************************************************************************
'***Please don't edit any thing down here unless you know what you're doing***
'*****************************************************************************
SUB win
hp = max.hp
CLS : SCREEN 13
TIME$ = "00:00:00"
LOCATE 3, 16: COLOR 14: PRINT "You won!"
LOCATE 4, 7: COLOR 14: PRINT "You collected"; ecash; "credits"
cash = cash + ecash
DO: LOOP UNTIL INKEY$ <> ""
LOCATE 6, 2: COLOR 14: PRINT "Press any key to enter the Space Store"
DO: LOOP UNTIL INKEY$ <> ""
store:
CLS
SCREEN 13
COLOR 15
LOCATE 3
PRINT "What shall you buy?"
PRINT
PRINT "[1] HP Upgrade     100 "
PRINT "[2] Machine Gun    150 "
PRINT "[3] Lazer Gun      250 "
PRINT "[4] Missle         100 "
IF score >= 1000 THEN PRINT "[5] Plazma Cannon  400 "
IF score >= 1200 THEN PRINT "[6] Proton Torpedo 550 "
IF score >= 2500 THEN PRINT "[7] Particle Beam  600 "
IF score >= 2700 THEN PRINT "[8] Meek Ship      1000"
IF score >= 3000 THEN PRINT "[9] JEM Cutter     2500"
PRINT "[0] Done Shoping       "
PRINT "You have"; cash; " credits."
DO
a$ = INKEY$
IF a$ = "1" AND cash >= 100 THEN cash = cash - 100: max.hp = max.hp + 25: GOTO store
IF a$ = "2" AND cash >= 150 THEN cash = cash - 150: gun$ = "* *": dam = 8: GOTO store
IF a$ = "3" AND cash >= 250 THEN cash = cash - 250: gun$ = "| |": dam = 10: GOTO store
IF a$ = "4" AND cash >= 100 THEN cash = cash - 100: missle = missle + 1: GOTO store
IF a$ = "5" AND cash >= 400 THEN cash = cash - 400: gun$ = " บ ": dam = 13: GOTO store
IF a$ = "6" AND cash >= 550 THEN cash = cash - 550: gun$ = " ์ ": dam = 18: GOTO store
IF a$ = "7" AND cash >= 600 THEN cash = cash - 600: gun$ = " ฐ ": dam = 20: GOTO store
IF a$ = "8" AND cash >= 1000 THEN cash = cash - 1000: ship$ = "ษÜป": max.hp = 250: hp = max.hp: GOTO store
IF a$ = "9" AND cash >= 2500 THEN cash = cash - 2500: ship$ = "ว์ถ": max.hp = 350: hp = max.hp: GOTO store
IF a$ = "0" THEN EXIT DO
LOOP
CLS
LOCATE 3, 5: PRINT "Shall you save your game?(Y/N)"
DO
a$ = UCASE$(INKEY$)
IF a$ = "Y" THEN CALL save: EXIT DO
IF a$ = "N" THEN EXIT DO
LOOP
LOCATE 4, 3: PRINT "Shall you continue fighting? (Y/N)"
DO
a$ = UCASE$(INKEY$)
IF a$ = "Y" THEN EXIT DO
IF a$ = "N" THEN END
LOOP
IF score = 3500 THEN GOTO mission
CALL game

mission:
LOCATE 5, 6: PRINT "A message from Earth...."
DO: LOOP UNTIL INKEY$ <> ""
CALL getmission
END SUB

