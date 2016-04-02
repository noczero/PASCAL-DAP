DECLARE SUB Armory ()
DECLARE SUB FightMonster ()
DECLARE SUB Gameplay ()
DECLARE FUNCTION GetLevel% (e&)
DECLARE SUB Healer ()
DECLARE SUB MakeEnemy (l%)
DECLARE SUB Stats (P AS ANY)
DECLARE SUB UseMagic ()
DECLARE SUB WalkInWoods ()
DECLARE FUNCTION Weapon$ (w%)
DECLARE SUB Woods ()
'===========================================================================
'_|_|_|   THEWOODS.BAS
'_|_|_|   A simple game to demonstrate some basic principles.
'_|_|_|   No warrantee or guarantee given or implied.
'_|_|_|   PUBLIC DOMAIN   by Kurt Kuzba.  (6/19/1997)
TYPE character: Pname AS STRING * 32: hits AS LONG
   magic AS LONG: strength AS LONG: gold AS LONG
   Weapon AS INTEGER: experience AS LONG: END TYPE
DIM SHARED Player AS character, Enemy AS character
RANDOMIZE TIMER
SCREEN 0: WIDTH 80, 25: COLOR 9, 0: CLS : LOCATE 3
LOCATE , 10: PRINT "Your goal is to gain 2,000 experience."
LOCATE , 10: PRINT "Upon doing this, you will have won.   "
LOCATE , 10: PRINT "It will NOT, however, be easy.        "
LOCATE , 10: PRINT "You will meet many malevolent forces. "
COLOR 11: LOCATE 14, 1: INPUT "What is your name? ", plyr$
IF plyr$ > "" THEN
   DO: Player.Pname = plyr$: Player.hits = 30: Player.magic = 0
      Player.strength = 0: Player.gold = 100: Player.Weapon = 0
      Player.experience = 0: Gameplay
      PRINT : PRINT "Would you like to play again (YN)? ";
      DO: k$ = UCASE$(INKEY$): LOOP WHILE INSTR(" YN", k$) < 2
      PRINT k$: LOOP WHILE k$ = "Y"
END IF
PRINT : PRINT "Goodbye, then...": PRINT "Hit any key to continue."
WHILE INKEY$ > "": WEND: WHILE INKEY$ = "": WEND: SYSTEM

SUB Armory : DIM price(1 TO 8) AS INTEGER
   price(1) = 75: price(2) = 200: price(3) = 400: price(4) = 600
   price(5) = 900: price(6) = 1500: price(7) = 2500: price(8) = 4000
   DO: COLOR 10, 0: PRINT
      PRINT " Would you like to Sell or Buy a weapon (S/B/Q)? ";
      DO: k% = INSTR(" SBQ" + CHR$(13), UCASE$(INKEY$))
      LOOP WHILE k% < 2
      PRINT MID$(" SBQQ", k%, 1): PRINT
      SELECT CASE k%
         CASE 2: money% = Player.Weapon * 30
            IF money% = 0 THEN
               PRINT " You cannot sell your hands here, friend!"
            ELSE
               PRINT " I will give you"; money%; "gold for your ";
               PRINT Weapon$(Player.Weapon)
               PRINT " Is it a deal (Y/N)? ";
               DO: k% = INSTR(" YN", UCASE$(INKEY$))
               LOOP WHILE k% < 2
               PRINT MID$(" YN", k%, 1): PRINT
               IF k% = 2 THEN
                  Player.gold = Player.gold + money%
                  Player.Weapon = 0
               END IF
            END IF
         CASE 3: PRINT "--==**[  PRICES  ]**==--"
            FOR t% = 1 TO 8: PRINT STR$(t%); "->";
               PRINT LEFT$(STR$(price(t%)) + "    ", 6);
               PRINT Weapon$(t%): NEXT
            PRINT " Hit ENTER to buy nothing"
            PRINT " You have"; Player.gold; "gold."
            PRINT "Which would you buy (1-8)? ";
            DO: k% = INSTR(" 12345678" + CHR$(13), UCASE$(INKEY$))
            LOOP WHILE k% < 2
            k% = k% - 1: PRINT MID$("12345678", k%, 1)
            IF k% < 9 THEN
               money% = k% * 90
               IF money% > Player.gold THEN
                  PRINT " You can not afford "; Weapon$(k%)
               ELSE
                  PRINT " Sold! I hope that "; Weapon$(k%)
                  PRINT " will serve you well."
                  Player.gold = Player.gold - money%
                  Player.Weapon = k%
               END IF
            END IF
         CASE 4, 5: EXIT SUB
      END SELECT
   LOOP: END SUB

SUB FightMonster : level% = GetLevel%(Player.experience)
   MakeEnemy level%: menu% = 1
   WHILE (Player.hits > 0) AND (Enemy.hits > 0)
      COLOR 4, 0: PRINT
      IF menu% > 0 THEN
         PRINT " F-> Fight": PRINT " R-> Run Away"
         PRINT " S-> Surrender": PRINT " Y-> Your Stats"
         PRINT " V-> View Enemy"
      END IF
      COLOR 15, 0: PRINT Player.hits; : COLOR 5, 0: PRINT Player.Pname
      COLOR 15, 0: PRINT Enemy.hits; : COLOR 5, 0: PRINT Enemy.Pname
      COLOR 4, 0: PRINT " [ F : R : S : Y : V : ? ]=> ";
      DO: k% = INSTR(" FRSYV?", UCASE$(INKEY$)): LOOP WHILE k% < 2
      PRINT MID$(" FRSYV?", k%, 1)
      level% = GetLevel%(Player.experience)
      SELECT CASE k%
         CASE 2
            PlayerAtt! = 1 + Player.Weapon
            PlayerAtt! = PlayerAtt! * (1 + (Player.strength / 10))
            PlayerAtt! = 5 + (RND * PlayerAtt! * 5 * level%)
            PlayerDef! = 1 + (Player.strength / 100)
            EnemyAtt! = Enemy.Weapon * (1 + (Enemy.strength / 10))
            EnemyDef! = 1 + (Enemy.strength / 100)
            IF RND > .5 THEN
               PRINT " You move fast and hit first."
               hits% = PlayerAtt! / EnemyDef!
               IF hits% > Enemy.hits THEN hits% = Enemy.hits
               Enemy.hits = Enemy.hits - hits%
               PRINT " You hit for"; hits%; "points."
               Player.experience = Player.experience + hits%
               IF Enemy.hits > 0 THEN
                  hits% = EnemyAtt! / PlayerDef!
                  IF hits% > Player.hits THEN hits% = Player.hits
                  Player.hits = Player.hits - hits%
                  PRINT " You are hit for"; hits%; "points."
               END IF
            ELSE
               PRINT " You move slow and get hit first."
               hits% = EnemyAtt! / PlayerDef!
               IF hits% > Player.hits THEN hits% = Player.hits
               Player.hits = Player.hits - hits%
               PRINT " You are hit for"; hits%; "points."
               IF Player.hits > 0 THEN
                  hits% = PlayerAtt! / EnemyDef!
                  IF hits% > Enemy.hits THEN hits% = Enemy.hits
                  Enemy.hits = Enemy.hits - hits%
                  Player.experience = Player.experience + hits%
                  PRINT " You hit for"; hits%; "points."
               END IF
            END IF
            IF Enemy.hits = 0 THEN
               PRINT " You have defeated the "; Enemy.Pname
               Player.magic = Player.magic + Enemy.magic \ 10
               Player.gold = Player.gold + Enemy.gold
            END IF
            IF Player.hits = 0 THEN
               PRINT " You were defeated by a "; Enemy.Pname
            END IF
         CASE 3:
            PRINT " You manage to escape, but all your strength"
            PRINT " and magic are lost, and some experience points."
            Player.magic = 0: Player.strength = 0
            Player.experience = Player.experience * .9
            EXIT SUB
         CASE 4:
            PRINT " You give all your gold to the "; Enemy.Pname
            Player.gold = 0: EXIT SUB
         CASE 5: Stats Player
         CASE 6: Stats Enemy
         CASE 7: menu% = 1
      END SELECT: WEND: END SUB

SUB Gameplay : menu% = 1: Stats Player
   DO
      IF Player.hits > 0 THEN
         PRINT
         IF menu% > 0 THEN
            COLOR 15, 0: PRINT " W->  Woods": PRINT " H->  Healer"
            PRINT " A->  Armory": PRINT " S->  Your Stats"
            PRINT " Q->  Quit Game"
         END IF: COLOR 11, 0: LOCATE , , 0: menu% = 0
         PRINT " [ W : H : A : S : Q : ? ]=> ";
         DO: k% = INSTR(" WHASQ?", UCASE$(INKEY$)): LOOP WHILE k% < 2
         PRINT MID$(" WHASQ", k%, 1)
         SELECT CASE k%
            CASE 2: Woods
            CASE 3: Healer
            CASE 4: Armory
            CASE 5: Stats Player
            CASE 6: PRINT : PRINT "Leave the Woods (YN)? ";
               DO: k$ = UCASE$(INKEY$)
               LOOP WHILE INSTR(" YN", k$) < 2
               PRINT k$: IF k$ = "Y" THEN EXIT DO
            CASE 7: menu% = 1
         END SELECT
      ELSE
         IF Player.experience < 2000 THEN
            PRINT "Sorry... You have perished in battle."
            FOR t% = 200 TO 150 STEP -1: SOUND t%, .1: NEXT
         ELSE
            PRINT "You have defeated all enemies! You WIN!!"
            FOR t% = 100 TO 999 STEP 10: SOUND t%, .03: NEXT
            FOR t% = 1000 TO 500 STEP -10: SOUND t%, .03: NEXT
         END IF: PRINT "You had"; Player.experience; "points."
         EXIT DO
      END IF: LOOP: END SUB

FUNCTION GetLevel% (e&)
   SELECT CASE e&
      CASE IS < 100: level% = 1
      CASE 101 TO 500: level% = 2
      CASE ELSE: level% = 3
   END SELECT: GetLevel% = level%: END FUNCTION

SUB Healer : Totalhits% = Player.experience \ 10 + 30
   ToHeal% = Totalhits% - Player.hits
   IF ToHeal% <= 0 THEN
      PRINT " You do not require healing!"; CHR$(7)
   ELSE
      PRINT " Each point costs 3 gold to heal."
      PRINT " You can afford to heal"; Player.gold \ 3; "hit points."
      PRINT " You need to heal"; ToHeal%
      INPUT " How many would you heal? ", heal%
      IF heal% > ToHeal% THEN heal% = ToHeal%
      IF heal% > (Player.gold \ 3) THEN heal% = Player.gold \ 3
      Player.hits = Player.hits + heal%
      Player.gold = Player.gold - (heal% * 3)
      PRINT " I have healed you for"; heal%; "hit points."
   END IF: END SUB

SUB MakeEnemy (l%) : DIM EN(1 TO 3) AS STRING, EP(1 TO 3) AS STRING
   EP(1) = "Ferocious ": EP(2) = "Snarling ": EP(3) = "Evil "
   SELECT CASE l%
      CASE 1: EN(1) = "Squirrel": EN(2) = "Bunny": EN(3) = "Hedgehog"
      CASE 2: EN(1) = "Bear": EN(2) = "Boar": EN(3) = "Troll"
      CASE 3: EN(1) = "Demon": EN(2) = "Dragon": EN(3) = "Wizard"
   END SELECT
   Enemy.Pname = EP(l%) + EN(RND * 2 + 1)
   Enemy.hits = ((RND * 10 + 20) * l%)
   Enemy.magic = ((RND * 10 + 10) * l%)
   Enemy.strength = ((RND * 10 + 10) * l%)
   Enemy.gold = ((RND * 100 + 100) * l%)
   Enemy.Weapon = (RND * 2 + l% * 2): END SUB

SUB Stats (P AS character) : COLOR 15, 0: PRINT
   COLOR 15, 1: PRINT " Name       : "; P.Pname;
   COLOR 15, 0: PRINT : COLOR 15, 1: PRINT " Hits       :";
   PRINT LEFT$(STR$(P.hits) + SPACE$(32), 33);
   COLOR 15, 0: PRINT : COLOR 15, 1: PRINT " Magic      :";
   PRINT LEFT$(STR$(P.magic) + SPACE$(32), 33);
   COLOR 15, 0: PRINT : COLOR 15, 1: PRINT " Strength   :";
   PRINT LEFT$(STR$(P.strength) + SPACE$(32), 33);
   COLOR 15, 0: PRINT : COLOR 15, 1: PRINT " Gold       :";
   PRINT LEFT$(STR$(P.gold) + SPACE$(32), 33);
   COLOR 15, 0: PRINT : COLOR 15, 1: PRINT " Weapon     : ";
   PRINT LEFT$(Weapon$(P.Weapon) + SPACE$(32), 32);
   COLOR 15, 0: PRINT : COLOR 15, 1: PRINT " Experience :";
   PRINT LEFT$(STR$(P.experience) + SPACE$(32), 33);
   COLOR 15, 0: PRINT : END SUB

SUB UseMagic : COLOR 12, 0: PRINT : PRINT : menu% = 1
   DO
      IF menu% <> 0 THEN
         PRINT " H-> Healing Spell   (4 magic)"
         PRINT " S-> Strength Spell  (9 magic)"
         PRINT " Q-> Quit this menu"
      END IF: PRINT " You have"; Player.magic; "spell points."
      menu% = 0: PRINT " [ H : S : Q : ? ]=> ";
      DO: k% = INSTR(" HSQ?" + CHR$(13), UCASE$(INKEY$))
      LOOP WHILE k% < 2: PRINT MID$(" CST?", k%, 1): PRINT
      SELECT CASE k%
         CASE 2
            IF Player.magic < 4 THEN
               PRINT " You haven't the magic!"
            ELSE
               m% = 1 + RND * 9
               Player.magic = Player.magic - 4
               Player.hits = Player.hits + m%
               PRINT " Your spell yields"; m%; "hits."
            END IF
         CASE 3
            IF Player.magic < 9 THEN
               PRINT " You haven't the magic!"
            ELSE
               m% = 1 + RND * 9
               Player.magic = Player.magic - 9
               Player.strength = Player.strength + m%
               PRINT " Your spell yields"; m%; "strength."
            END IF
         CASE 4, 6: EXIT SUB
         CASE 5: menu% = 1
      END SELECT: LOOP: END SUB

SUB WalkInWoods
   SELECT CASE (RND * 99)
      CASE 0 TO 9: Player.gold = Player.gold + 1
         COLOR 14, 0: PRINT "You found a piece of gold!"
      CASE 10 TO 19: Player.magic = Player.magic + 1
         COLOR 13, 0: PRINT "A faerie gives you one magic!"
      CASE 20 TO 29: m% = 1 + RND * 9
         Player.hits = Player.hits + m%
         COLOR 9, 0: PRINT "A friendly Elf heals"; m%; "hit";
         IF m% = 1 THEN PRINT "!":  ELSE PRINT "s!"
      CASE 30 TO 89
         COLOR 6, 0: PRINT "The path continues before you."
      CASE ELSE: FightMonster
   END SELECT: END SUB

FUNCTION Weapon$ (w%)
   SELECT CASE w%
      CASE 0: Weapon$ = "Your Bare Hands"
      CASE 1: Weapon$ = "A Stick"
      CASE 2: Weapon$ = "A Quarterstaff"
      CASE 3: Weapon$ = "A Small Knife"
      CASE 4: Weapon$ = "A Big Knife"
      CASE 5: Weapon$ = "A Machete"
      CASE 6: Weapon$ = "A Shortsword"
      CASE 7: Weapon$ = "A Longsword"
      CASE 8: Weapon$ = "A Two-Handed Sword"
   END SELECT: END FUNCTION

SUB Woods : menu% = 1
   DO: level% = GetLevel%(Player.experience)
      IF Player.experience > 2000 THEN Player.hits = 0
      COLOR 2, 0: PRINT : IF Player.hits = 0 THEN EXIT SUB
      IF menu% <> 0 THEN
         PRINT " C-> Continue": PRINT " T-> Go to Town"
         PRINT " S-> Cast a Spell": PRINT " Y-> Your Stats"
      END IF: menu% = 0: PRINT " [ C : S : T : Y : ? ]=> ";
      DO: k% = INSTR(" CTSY?", UCASE$(INKEY$)): LOOP WHILE k% < 2
      PRINT MID$(" CSTY?", k%, 1)
      SELECT CASE k%
         CASE 2: WalkInWoods
         CASE 3: EXIT SUB
         CASE 4: UseMagic
         CASE 5: Stats Player
         CASE 6: menu% = 1
      END SELECT: LOOP: END SUB

