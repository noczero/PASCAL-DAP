'                                   Jay Cook 
'
'                                   Fire Pit
'
' -=- How to play:
'    What you have to do in Fire Pit is move your guy around using the Num
' keys or the arrow keys, and get to door by avoiding the fire. Q quits, and
' S turns off sound.
' -=- This is old source and fairly shotty programing, but it is a fun game.
'  If I were to rewrite this, the biggest change I would add is putting the
'  fire into an array and then I could add a graphic to it. Do whatever you
'  want to it, I am not setting up any legal crap except I am not responsible
'  for what happens to your computer, whether it catches on fire or so on. =)
'
' Enjoy!
'
DEFINT A-Z: 'Speeds up game
RANDOMIZE TIMER
SCREEN 9
DIM fr1(100)' Guy grfx in memory
DIM dr1(100)' Door grfx in memory
sn = 1'sound on
GOSUB sprt: 'get the door and guy graphic

1
CLS
gm = 0 'godmode off
S = 0 'starting number of how many times you moved
nfb = 10 'number of blocks thrown out everytime you move
nsb = 50 'how many blocks are thrown out at the begining
'setting up the screen
  COLOR 8: FOR xz = 1 TO 80: LOCATE 1, xz: PRINT "±": NEXT xz
  COLOR 8: FOR xz = 1 TO 80: LOCATE 21, xz: PRINT "±": NEXT xz
  LOCATE 1, 36
  COLOR 12:  PRINT "Fire  Pit"
  LOCATE 21, 36
  COLOR 9:  PRINT "Jay  Cook"
  LOCATE 22, 33
COLOR 7: PRINT "Use arrow keys to move guy to door and avoid fire, Q to quit, S for Sound On/Off"

'Put door and guy at start pos
 COLOR 6: x2 = INT(RND * 77) + 2: y2 = INT(RND * 19) + 2: LOCATE y2, x2:
COLOR 9: x = INT(RND * 77) + 2: y = INT(RND * 19) + 2: LOCATE y, x:

' puts the first 50 blocks on the screen
 DO
 n = n + 1
 COLOR 4: x1 = INT(RND * 78) + 2: y1 = INT(RND * 19) + 2: LOCATE y1, x1: PRINT "²"
 LOOP UNTIL n = nsb: n = 0
LOCATE y, x: PRINT " "

' Main loop
  DO
  a$ = UCASE$(INKEY$) ' puts input in upper-case
  YA = 0: XA = 0 'resets controls
 'moves guy with arrows or num keys,erases previos grfx, then goes to mv(to place blocks)
   IF a$ = CHR$(0) + CHR$(72) THEN LOCATE y, x: PRINT " ": : YA = y: XA = x: y = y - 1: GOSUB mv
   IF a$ = CHR$(0) + CHR$(80) THEN LOCATE y, x: PRINT " ": : YA = y: XA = x: y = y + 1: GOSUB mv
   IF a$ = CHR$(0) + CHR$(75) THEN LOCATE y, x: PRINT " ": : XA = x: YA = y: x = x - 1: GOSUB mv
   IF a$ = CHR$(0) + CHR$(77) THEN LOCATE y, x: PRINT " ": : XA = x: YA = y: x = x + 1: GOSUB mv
   IF a$ = "8" THEN LOCATE y, x: PRINT " ": : YA = y: XA = x: y = y - 1: GOSUB mv
   IF a$ = "2" THEN LOCATE y, x: PRINT " ": : YA = y: XA = x: y = y + 1: GOSUB mv
   IF a$ = "4" THEN LOCATE y, x: PRINT " ": : XA = x: YA = y: x = x - 1: GOSUB mv
   IF a$ = "6" THEN LOCATE y, x: PRINT " ": : XA = x: YA = y: x = x + 1: GOSUB mv
 'secret code
   IF a$ = "G" THEN gd = 1
   IF a$ = "O" THEN IF gd = 1 THEN gd = 2
   IF a$ = "D" THEN IF gd = 2 THEN gd = 0: GOSUB godmode
 'sound and quit toggle
   IF a$ = "S" THEN GOSUB snd
   IF a$ = "Q" THEN CLS : GOTO qt
 ' screen limits
   IF x > 78 THEN x = 78
   IF x < 2 THEN x = 2
   IF y > 20 THEN y = 20
   IF y < 2 THEN y = 2
 'if you hit a block
   IF gm = 0 AND SCREEN(y, x) = 178 THEN GOSUB wall
 'if you hit a door
   IF SCREEN(y, x) = 239 THEN GOSUB win
   PUT (x * 8 - 8, y * 14 - 14), fr1, PSET
   IF y = y2 AND x = x2 THEN GOSUB win
  PUT (x2 * 8 - 8, y2 * 14 - 14), dr1, PSET
LOOP

mv: ' if desides if sound on or off
IF sn = 0 THEN GOTO ns1: 'nosound
IF sn = 1 THEN GOTO s1: 'sound

s1: ' sound for stepping/moving
 SOUND 40, 500 / 10000

ns1: 'if sound off then just goto wall
 S = S + 1 'adds 1 every time you move(for end)

'throws out random walls in area
 DO
 n = n + 1
 COLOR 4: x1 = INT(RND * 78) + 2: y1 = INT(RND * 19) + 2: LOCATE y1, x1: PRINT "²"
 LOOP UNTIL n = nfb: n = 0
 RETURN

snd: 'turn sound on if off or sound off if on
  IF sn = 0 THEN sn = 1: RETURN
  IF sn = 1 THEN sn = 0: RETURN
  RETURN

wall: 'if you die, hit a wall
 COLOR 12:
 LOCATE 5, 36
 PRINT " You Lose"
 IF sn = 1 THEN GOSUB lsnd:
 GOSUB pl: 'goes to play again?
 CLS : GOTO qt' if no, then ends
 RETURN

win: 'if you win
 LOCATE 5, 37
 PUT (x2 * 8 - 8, y2 * 14 - 14), dr1, PSET
 COLOR 12: PRINT "You Win"
 IF sn = 1 THEN GOSUB wsnd:
 GOSUB pl: 'goes to play again?
 CLS : GOTO qt' if no, then ends

pl: 'asks if you want to play again, counts up moves
 LOCATE 2, 35
 COLOR 9:  PRINT "Play Again?"
 LOCATE 3, 38
 COLOR 13: PRINT "<Y/N>"
 LOCATE 4, 32
 COLOR 7:  PRINT "You made"; S; "moves"
 'loop for question
  DO
  B$ = INKEY$
  IF B$ = "Y" THEN GOTO 1
  IF B$ = "y" THEN GOTO 1
  IF B$ = "N" THEN CLS : GOTO qt
  IF B$ = "n" THEN CLS : GOTO qt
  LOOP

wsnd: ' if sound on, will play little tune if you win
  PLAY "A13B31d13a13"
  FOR i% = 440 TO 1000 STEP 5
  SOUND i%, i% / 10000
  NEXT i%
  RETURN

lsnd: 'if sound on, will play little tune if died
  PLAY "a20d20c25 "
  RETURN

godmode: ' if you entered in the secret code, turn it on or off
  COLOR 12: IF gm = 1 THEN gm = 0: : LOCATE 1, 36: PRINT "Fire  Pit": GOSUB gs1: RETURN
  COLOR 9: IF gm = 0 THEN gm = 1: LOCATE 1, 36: PRINT "GOD  MODE": GOSUB gs2
  RETURN
gs1: ' if sound on, then plays tune for entering code, turning godmode on
  IF sn = 0 THEN RETURN
  PLAY "g35f35e35d35c35a35"
  RETURN
gs2: ' if sound on, then plays tune for entering code, turning godmode off
  IF sn = 0 THEN RETURN
  PLAY "a35b35c35d35e35f35g35"
  RETURN
qt: ' goes to close screen if quits
  CLS
  SCREEN 0
  COLOR 12
  PRINT "Thanks for playing Fire Pit"
  COLOR 9
  PRINT "By: Jay Cook, (jay.cook@sandh.com)"
  PRINT "Visit my little Qbasic Page at http://members.tripod.com/~jaycook/qb.htm"
  COLOR 4
  PRINT "Ver 1.2"
  COLOR 15
  PRINT
  PRINT "Ver 1 (12-15-95)- Without Graphics, done in 30 min in school out of boredom"
  PRINT "Ver 1.1 (4-5-96)- EGA Graphics and sound,cheats,2 hours(This Version)"
  PRINT "Ver 1.2 (5-19-96)- 2 days after Birthday, clean-up and lable code "
  PRINT
  COLOR 12
  PRINT
  PRINT
  COLOR 15
  CLEAR
  END

sprt: ' gets sprites
RESTORE fire1
FOR row = 1 TO 13
 FOR column = 1 TO 8
  READ picData
  PSET (column, row), picData
 NEXT column
NEXT row
GET (1, 0)-(8 - 0, 13 - 0), fr1
GOTO 2
fire1:
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 0, 6, 6, 0, 0, 0
DATA 0, 0, 6,12,12, 6, 0, 0
DATA 0, 0, 6,12,12, 6, 0, 0
DATA 0, 4, 4, 4, 4, 4, 4, 0
DATA 4, 4, 4, 4, 4, 4, 4, 4
DATA 4, 4, 4, 4, 4, 4, 4, 4
DATA 4, 0, 1, 8, 8, 1, 0, 4
DATA 2, 0, 9, 9, 9, 9, 0,12
DATA 0, 0, 9, 9, 1, 9, 0, 0
DATA 0, 9, 9, 0, 0, 9, 9, 0
DATA 0, 9, 9, 0, 0, 9, 9, 0
DATA 8, 8, 0, 0, 0, 0, 8, 8
2
CLS
RESTORE door1
FOR row = 1 TO 13
 FOR column = 1 TO 8
  READ picData
  PSET (column, row), picData
NEXT column
NEXT row
GET (1, 0)-(8 - 0, 13 - 0), dr1
GOTO 4
door1:
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 6, 6, 6, 6, 0, 0
DATA 0, 6, 0, 7, 0, 7, 6, 0
DATA 4, 6, 0, 7, 0, 7, 6, 6
DATA 4, 6, 0, 7, 0, 7, 4, 6
DATA 6, 6, 0, 7, 0, 7, 6, 4
DATA 6, 6, 6, 6, 4, 6, 6, 6
DATA 6, 4, 6, 4, 6, 7, 8, 6
DATA 6, 4, 6, 6, 6, 8, 8, 6
DATA 6, 6, 4, 6, 6, 6, 6, 6
DATA 4, 6, 4, 6, 6, 4, 6, 6
DATA 0, 6, 6, 6, 4, 4, 6, 0
4
CLS
RETURN

