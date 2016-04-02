' Castle, for FreeBasic QB mode & QBasic, http://rudih.info

'declations
DIM sc$(18)
DIM room(10, 10)
'main menu for accessing the game
menu:
RANDOMIZE TIMER 'for the program
CLS
COLOR 10, 0
LOCATE 10, 30
PRINT "---CASTLE---"
LOCATE 12, 20
PRINT "In game, use arrow keys to move."
COLOR 3, 0
x$ = ""
WHILE x$ = ""
    x$ = INKEY$
WEND
'esc exits
IF x$ = "" THEN END
'generate random dungeon
FOR x = 1 TO 10
    FOR y = 1 TO 10
        room(x, y) = INT(RND * 9) + 1
    NEXT y
NEXT x
x=Int(Rnd*10)+1
y=Int(Rnd*10)+1
room(x,y)=99
' initalize variables
x = 20
y = 9
xmap = INT(RND * 10) + 1
ymap = INT(RND * 10) + 1
gp = 0
playerhp = 15
keys = 0
armour = 0
knife = 0

' main loop
main:
obx = 18
oby = 9
GOSUB load:
'navigation
nav:
COLOR 14, 0
LOCATE y, x
PRINT ""
LOCATE oby, obx
PRINT object$
COLOR 3, 0
user$ = ""
WHILE user$ = ""
    user$ = INKEY$
WEND
IF user$ = "" GOTO menu:
' up
IF user$ = CHR$(0) + "H" THEN
    'collision detection
    dest$ = MID$(sc$(y - 1), x, 1)
    IF dest$ = "€" GOTO nav:
    IF dest$ = "ƒ" THEN
        IF ymap = 1 THEN GOTO nav:
        y = 17
        ymap = ymap - 1
        GOTO main:
    END IF
    LOCATE y, x
    PRINT " "
    y = y - 1
END IF
' down
IF user$ = CHR$(0) + "P" THEN
    'collision detection
    dest$ = MID$(sc$(y + 1), x, 1)
    IF dest$ = "€" GOTO nav:
    IF dest$ = "ƒ" THEN
        IF ymap = 10 THEN GOTO nav:
        y = 2
        ymap = ymap + 1
        GOTO main:
    END IF
    LOCATE y, x
    PRINT " "
    y = y + 1
END IF
' left
IF user$ = CHR$(0) + "K" THEN
    'collision detection
    dest$ = MID$(sc$(y), x - 1, 1)
    IF dest$ = "€" GOTO nav:
    IF dest$ = "≥" THEN
        IF xmap = 1 THEN GOTO nav:
        x = 33
        xmap = xmap - 1
        GOTO main:
    END IF
    LOCATE y, x
    PRINT " "
    x = x - 1
END IF
' right
IF user$ = CHR$(0) + "M" THEN
    'collision detection
    dest$ = MID$(sc$(y), x + 1, 1)
    IF dest$ = "€" GOTO nav:
    IF dest$ = "≥" THEN
        IF xmap = 10 THEN GOTO nav:
        x = 2
        xmap = xmap + 1
        GOTO main:
    END IF
    LOCATE y, x
    PRINT " "
    x = x + 1
END IF
'key
IF object$ = "k" AND x = obx AND y = oby THEN
    LOCATE 19, 1
    FOR c = 1 TO 3
        PRINT SPACE$(60)
    NEXT c
    LOCATE 19, 1
    keys = keys + 1
    PRINT "Keys="; keys
    object$ = ""
    room(xmap, ymap) = 0
END IF
'end
IF object$ = "E" AND x = obx AND y = oby THEN
    CLS
    LOCATE 10, 10
    PRINT "THE END. Press space..."
    x$ = ""
    WHILE x$ <> " "
        x$ = INKEY$
    WEND
    GOTO menu:
END IF
'chest
IF object$ = "C" AND x = obx AND y = oby THEN
    LOCATE 19, 1
    FOR c = 1 TO 3
        PRINT SPACE$(60)
    NEXT c
    LOCATE 19, 1
    IF keys > 0 THEN
        PRINT "You opened the chest."
        chest = INT(RND * 3) + 1
        IF chest = 1 THEN
            PRINT "You find a potion(+5HP)."
            playerhp = playerhp + 5
        END IF
        IF chest = 2 THEN
            PRINT "You find armour."
            armour = 1
        END IF
        IF chest = 3 THEN
            PRINT "You find a knife."
            knife = 1
        END IF
        keys = keys - 1
        PRINT "Keys="; keys
        room(xmap, ymap) = 4
        object$ = "c"
    ELSE
        PRINT "The chest is locked."
        PRINT "Keys="; keys
    END IF
END IF
'money
IF object$ = "$" AND x = obx AND y = oby THEN
    gp = gp + 1
    LOCATE 19, 1
    FOR c = 1 TO 3
        PRINT SPACE$(60)
    NEXT c
    LOCATE 19, 1
    PRINT "GP="; gp
    object$ = ""
    room(xmap, ymap) = 0
END IF
'prisoner
IF object$ = "P" AND x = obx AND y = oby THEN
    LOCATE 19, 1
    FOR c = 1 TO 3
        PRINT SPACE$(60)
    NEXT c
    LOCATE 19, 1
    PRINT "Buy <p>otion(3GP), <a>rmour(5GP), or <k>nife(10GP)?"
    x$ = ""
    WHILE x$ = ""
        x$ = INKEY$
    WEND
    IF x$ = "P" OR x$ = "p" THEN
        IF gp > 2 THEN
            PRINT "You buy the potion(+5HP)."
            playerhp = playerhp + 5
            gp = gp - 3
        ELSE
            PRINT "Insufficient funds. GP="; gp
        END IF
    END IF
    IF x$ = "A" OR x$ = "a" THEN
        IF gp > 4 THEN
            PRINT "You buy the armour."
            armour = 1
            gp = gp - 5
        ELSE
            PRINT "Insufficient funds. GP="; gp
        END IF
    END IF
    IF x$ = "K" OR x$ = "k" THEN
        IF gp > 4 THEN
            PRINT "You buy the knife."
            knife = 1
            gp = gp - 10
        ELSE
            PRINT "Insufficient funds. GP="; gp
        END IF
    END IF
END IF
'combat
IF object$ = "Î" OR object$ = "" OR object$ = "ù" OR object$ = "" THEN
    LOCATE oby, obx
    PRINT " "
    'tracking
    IF x < obx THEN obx = obx - 1
    IF x > obx THEN obx = obx + 1
    IF y < oby THEN oby = oby - 1
    IF y > oby THEN oby = oby + 1
    'if their paths cross...
    IF oby = y AND obx = x THEN
        LOCATE 19, 1
        FOR c = 1 TO 3
            PRINT SPACE$(60)
        NEXT c
        LOCATE 19, 1
        damage = (RND * 3) + 1
        IF turn = 0 THEN
            PRINT "You attack the "; nam$; "."
            IF knife = 1 THEN
                damage = damage + 2
                PRINT "Knife caused +2"
            END IF
            enemyhp = enemyhp - damage
            IF enemyhp < 0 THEN
                gp = gp + 1
                PRINT "You have killed the "; nam$; "."
                PRINT "HP="; playerhp
                PRINT "GP="; gp
                object$ = ""
                room(xmap, ymap) = 0
                GOTO nav:
            END IF
            turn = 1
            GOTO nav:
        END IF
        IF turn = 1 THEN
            PRINT "The "; nam$; " attacks."
            IF armour = 1 THEN
                damage = damage * .7
                PRINT "Armour reduced damage."
            End If
            playerhp = playerhp - damage
            PRINT "HP="; playerhp
            IF playerhp < 0 THEN
                LOCATE 19, 1
                PRINT "You have been killed. Game over. Press space..."
                PRINT "HP="; playerhp
                x$ = ""
                WHILE x$ <> " "
                    x$ = INKEY$
                WEND
                GOTO menu:
            END IF
            turn = 0
            GOTO nav:
        END IF
    END IF
END IF


GOTO nav:

'loads the main screen
load:
enemyhp = 0
CLS
sc$(1) = "⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø"
sc$(2) = "≥±±±±€€                    €€±±±±≥"
sc$(3) = "≥±±±±€€                    €€±±±±≥"
sc$(4) = "≥€€€€€€                    €€€€€€≥"
sc$(5) = "≥                                ≥"
sc$(6) = "≥                                ≥"
sc$(7) = "≥                                ≥"
sc$(8) = "≥                                ≥"
sc$(9) = "≥                                ≥"
sc$(10) = "≥                                ≥"
sc$(11) = "≥                                ≥"
sc$(12) = "≥                                ≥"
sc$(13) = "≥                                ≥"
sc$(14) = "≥                                ≥"
sc$(15) = "≥€€€€€€                    €€€€€€≥"
sc$(16) = "≥±±±±€€                    €€±±±±≥"
sc$(17) = "≥±±±±€€                    €€±±±±≥"
sc$(18) = "¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ"
FOR c = 1 TO 18
    PRINT sc$(c)
NEXT

'inventory
PRINT "x="; xmap; " y="; ymap; " gp="; gp; " hp="; playerhp
PRINT "inventory: ";
IF armour = 1 THEN PRINT "-armour ";
IF knife = 1 THEN PRINT "-knife";
PRINT " keys="; keys

If room(xmap, ymap) = 0 Then object$ = "" 'blank
IF room(xmap, ymap) = 1 THEN object$ = "$" 'gp
IF room(xmap, ymap) = 2 THEN object$ = "k" 'key
IF room(xmap, ymap) = 3 THEN object$ = "C" 'chest locked
IF room(xmap, ymap) = 4 THEN object$ = "c" 'chest unlocked
IF room(xmap, ymap) = 5 THEN object$ = "P" 'prisoner
IF room(xmap, ymap) = 6 THEN
    enemyhp = 3
    object$ = "Î"
    nam$ = "snake"
END IF
IF room(xmap, ymap) = 7 THEN
    enemyhp = 6
    object$ = ""
    nam$ = "goblin"
END IF
IF room(xmap, ymap) = 8 THEN
    enemyhp = 10
    object$ = "ù"
    nam$ = "skeleton"
END IF
IF room(xmap, ymap) = 9 THEN
    enemyhp = 18
    object$ = ""
    nam$ = "ogre"
END IF
IF room(xmap, ymap) = 99 THEN object$ = "E" 'end
RETURN

