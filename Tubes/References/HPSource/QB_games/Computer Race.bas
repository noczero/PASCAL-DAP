'Project CompuRace From the C=64; Jay Cook (jay.cook@sandh.com)
'http://www.tripod.com/~jaycook/qb.htm <-- My Qbasic Web Page
'Date: Wed 6-19-96,12:30 am, thinking about 80's, and the c64
'     and Compurace came to mind, a little nostlogia(sp)
'  Let me fill you in, because NOBODY has played this on the C64
'and the reason was is because my dad made it =) I still remember
'when he made the little car sprite and you could control it on the
'screen before the track and opponent... those were the days(I was like
' 4 or 5 so it was 1985 or 86.
'ADDED:12:30-1:10am, programmed in car grafix, thinking entering in
'  number is so mind numbing, but doesn't matter when your half asleep
'ADDED:1:15-1:35am, track and start of cars
'Problem: When text gets to bottom of screen, it moves it up
'ADDED:1:40-2:00am,  movement and lap count
'ADDED:2:10-2:50am,  collision detection of walls(and shit tired!)
'ADDED:3:10-3:25a, comp car movement and delay, finished!!!
'  cat delaying finish by pestering me =)
'Done in 135 minutes, which is 2 hours and 15 minutes!!
' 9-16-96 Mon 5:30pm: Looked over source, seems all good, so I will zip it
'6-29-97
'Added new keyboard routine
'Added page flipping
'Added sync from Eric Carr's Spinball 2.5 source
'  Ok, I have redone the keyboard routines and added other things. This game
'isn't really half bad, but now that the keyboard buffer doesn't flood, the
'computer car can be slaughtered by a lap. If I were to reprogram this, I would
'give each "O" colision coordinates, then put the whole track in an array, so
'new tracks could be made with ease. Also I would reprogram the Computer car
'AI so it would scan left and right sides of the track to see if it can turn
'or keep going straight. But all in all, it is a fun game. Also, this isn't
'the best of my programming ability. If you see the dates in my log, you will
'see this source is about a year old. Well, once again have fun and visit my
'Qbasic page: http://members.tripod.com/~jaycook/QB.HTM
'
'#### #### How to play:
'Use the num keys to move your car(white), Q to quit
'
'                                       -Jay
DEFINT A-Z
SCREEN 7
'########################## Init Stuff ########################
DIM wcu(100): 'white car up
DIM wcd(100): 'white car down
DIM wcl(100): 'white car left
DIM wcr(100): 'white car right
DIM bcu(100): 'blue car up
DIM bcd(100): 'blue car down
DIM bcl(100):  'blue car left
DIM bcr(100): 'blue car right
DIM trk(2000): 'capture bottom of screen to make track bigger
x = 187: y = 174: XA = x: YA = y: 'Start of your car
ox = 204: oy = 174: 'Start of other car
d = 1: 'Starting direction
d2 = 1: 'starting dir of comp
dly = 1000: 'delay time
GOSUB 1
GOSUB TRACK
GOSUB laps
GOSUB START
'for screen 9 support
'DIM scrn(8000): GET (0, 0)-(319, 199), scrn: SCREEN 9: PUT (0, 0), scrn: COLOR 2, 1
GOSUB GO
GOSUB main
s1 = 1: s2 = 0
main: '############################ Main Loop #########################
DO
SWAP s1, s2
SCREEN 7, , s1, s2
WAIT &H3DA, 8
YA = 0: XA = 0 'resets controls
SELECT CASE INP(96)
      CASE 1: END
      CASE 16: END
      CASE 72: GOSUB c1e: YA = y: XA = x: y = y - 3: d = 1: GOSUB c1:
      CASE 80: GOSUB c1e: YA = y: XA = x: y = y + 3: d = 2: GOSUB c1:
      CASE 75: GOSUB c1e: XA = x: YA = y: x = x - 3: d = 3: GOSUB c1:
      CASE 77: GOSUB c1e: XA = x: YA = y: x = x + 3: d = 4: GOSUB c1:
END SELECT
IF INKEY$ = "a" THEN a = a

GOSUB move
GOSUB delay
LOOP
c1e:
IF d = 1 THEN PUT (x, y), wcu
IF d = 2 THEN PUT (x, y), wcd
IF d = 3 THEN PUT (x, y), wcl
IF d = 4 THEN PUT (x, y), wcr
RETURN
c2:
'start,finish line
IF (ox > 170 AND ox < 232) AND (oy < 145 AND oy > 141) THEN l2 = l2 + 1: GOSUB laps
IF d2 = 1 THEN PUT (ox, oy), bcu
IF d2 = 2 THEN PUT (ox, oy), bcd
IF d2 = 3 THEN PUT (ox, oy), bcl
IF d2 = 4 THEN PUT (ox, oy), bcr
RETURN
c2e:
IF d2 = 1 THEN PUT (ox, oy), bcu
IF d2 = 2 THEN PUT (ox, oy), bcd
IF d2 = 3 THEN PUT (ox, oy), bcl
IF d2 = 4 THEN PUT (ox, oy), bcr
RETURN
move:
GOSUB c2e
IF n = 0 THEN d2 = 1: oy = oy - 3: IF oy < 7 THEN oy = 7: n = 1
IF n = 1 THEN d2 = 3: ox = ox - 3: IF ox < 7 THEN ox = 7: n = 2
IF n = 2 THEN d2 = 2: oy = oy + 3: IF oy > 55 THEN oy = 55: n = 3
IF n = 3 THEN d2 = 4: ox = ox + 3: IF ox > 50 THEN ox = 50: n = 4
IF n = 4 THEN d2 = 2: oy = oy + 3: IF oy > 104 THEN oy = 104: n = 5
IF n = 5 THEN d2 = 3: ox = ox - 3: IF ox < 7 THEN ox = 7: n = 6
IF n = 6 THEN d2 = 2: oy = oy + 3: IF oy > 177 THEN oy = 177: n = 7
IF n = 7 THEN d2 = 4: ox = ox + 3: IF ox > 204 THEN ox = 204: n = 0
GOSUB c2

RETURN
c1:
'start,finish line
IF (x > 170 AND x < 242) AND (y < 145 AND y > 141) THEN l1 = l1 + 1: GOSUB laps
GOSUB limits
IF d = 1 THEN PUT (x, y), wcu
IF d = 2 THEN PUT (x, y), wcd
IF d = 3 THEN PUT (x, y), wcl
IF d = 4 THEN PUT (x, y), wcr
RETURN
limits: 'screen limits for your car and If you hit wall:
IF x < 6 THEN x = 6: RETURN
IF x > 209 THEN x = 209: RETURN
IF y < 6 THEN y = 6: RETURN
IF y > 177 THEN y = 177: RETURN
IF x > 1 AND x < 46 AND y > 58 AND y < 101 THEN x = XA: y = YA: RETURN
IF x > 42 AND x < 103 AND y > 26 AND y < 46 THEN x = XA: y = YA: RETURN
IF x > 90 AND x < 174 AND y > 26 AND y < 158 THEN x = XA: y = YA: RETURN
IF x > 42 AND x < 103 AND y > 114 AND y < 158 THEN x = XA: y = YA: RETURN
RETURN

delay: 'delay for speed of game
' FOR B = 1 TO dly: NEXT B
DEF SEG = 0
POKE (1132), 0  'reset timer again
T:
IF PEEK(1132) < 1 THEN GOTO T  'If not enough time was passed goto T
RETURN

TRACK: CLS ':#################### Screen Setup ##########################
COLOR 2, 1
PRINT "OOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
PRINT "O                           O"
PRINT "O                           O"
PRINT "O                           O"
PRINT "O                           O"
PRINT "O            OOOOOOOOO      O"
PRINT "O            O       O      O"
PRINT "O            O       O      O"
PRINT "O            O       O      O"
PRINT "O            O       O      O"
PRINT "O            O       O      O"
PRINT "O            O       O      O"
PRINT "O            O       O      O"
PRINT "O            O       O      O"
PRINT "O            O       O      O"
PRINT "O            O       O      O"
PRINT "O       OOOOOO       O      O"
PRINT "O      O             O      O"
PRINT "O      O             O      O"
PRINT "O       OOOOOOOOOOOOO       O"
PRINT "O                           O"
PRINT "O                           O"
PRINT "OOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
GET (0, 160)-(230, 182), trk: PUT (0, 176), trk, PSET: 'fixes screen
COLOR 9
LOCATE 18, 32: PRINT "LAPS"
LOCATE 20, 32: PRINT "YOU    0"
LOCATE 22, 32: PRINT "ME"
RETURN
laps:
LOCATE 20, 37: COLOR 15: PRINT l1
LOCATE 22, 37: COLOR 9: PRINT l2
IF l1 > 3 THEN GOSUB WIN
IF l2 > 3 THEN GOSUB LOSE
RETURN
WIN:
LOCATE 5, 32: COLOR 15: PRINT "YOU WIN"
y = 145: GOSUB c1
END
LOSE:
LOCATE 5, 32: COLOR 9: PRINT "YOU LOSE"
oy = 145: GOSUB c2
END
GO:
LOCATE 1, 32: COLOR 9: PRINT "GET READY"
SLEEP 1
LOCATE 2, 32: COLOR 2: PRINT "GET SET"
SLEEP 1
LOCATE 3, 32: COLOR 15: PRINT "GO GO GO!"
RETURN
START:
GOSUB c1
GOSUB c2
RETURN

'############################# Grafix #########################
1 CLS
RESTORE bcu
FOR row = 1 TO 14
 FOR column = 1 TO 13
 READ picData
  PSET (column, row), picData
NEXT column
NEXT row
GET (0, 0)-(13, 14), bcu
GOTO 2
bcu:
DATA 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0
DATA 0, 9, 0, 0, 9, 9, 0, 9, 9, 0, 0, 9, 0
DATA 0, 9, 0, 9, 9, 9, 9, 0, 9, 9, 0, 9, 0
DATA 0, 9, 0, 9, 9, 9, 0, 9, 9, 9, 0, 9, 0
DATA 0, 9, 0, 9, 9, 9, 0, 9, 9, 9, 0, 9, 0
DATA 0, 0, 0, 9, 9, 9, 9, 0, 9, 9, 0, 0, 0
DATA 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0
DATA 0, 0, 0, 9, 9, 9, 0, 9, 9, 9, 0, 0, 0
DATA 9, 9, 0, 9, 9, 0, 9, 0, 9, 9, 0, 9, 9
DATA 9, 9, 0, 9, 9, 0, 9, 0, 9, 9, 0, 9, 9
DATA 9, 9, 0, 9, 9, 0, 9, 0, 9, 9, 0, 9, 9
DATA 9, 9, 0, 9, 9, 0, 0, 0, 9, 9, 0, 9, 9
DATA 0, 0, 0, 0, 9, 9, 0, 9, 9, 0, 0, 0, 0
DATA 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0
2 :
CLS
RESTORE bcd
FOR row = 1 TO 14
 FOR column = 1 TO 13
 READ picData
  PSET (column, row), picData
NEXT column
NEXT row
GET (0, 0)-(13, 14), bcd
GOTO 3
bcd:
DATA 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0
DATA 0, 0, 0, 0, 9, 9, 0, 9, 9, 0, 0, 0, 0
DATA 9, 9, 0, 9, 9, 0, 9, 0, 9, 9, 0, 9, 9
DATA 9, 9, 0, 9, 9, 0, 9, 0, 9, 9, 0, 9, 9
DATA 9, 9, 0, 9, 9, 0, 9, 0, 9, 9, 0, 9, 9
DATA 9, 9, 0, 9, 9, 0, 0, 0, 9, 9, 0, 9, 9
DATA 0, 0, 0, 9, 9, 9, 0, 9, 9, 9, 0, 0, 0
DATA 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0
DATA 0, 0, 0, 9, 9, 9, 9, 0, 9, 9, 0, 0, 0
DATA 0, 9, 0, 9, 9, 9, 0, 9, 9, 9, 0, 9, 0
DATA 0, 9, 0, 9, 9, 9, 0, 9, 9, 9, 0, 9, 0
DATA 0, 9, 0, 9, 9, 9, 9, 0, 9, 9, 0, 9, 0
DATA 0, 9, 0, 0, 9, 9, 0, 9, 9, 0, 0, 9, 0
DATA 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0
3 :
CLS
RESTORE bcl
FOR row = 1 TO 13
 FOR column = 1 TO 14
 READ picData
  PSET (column, row), picData
NEXT column
NEXT row
GET (0, 0)-(14, 13), bcl
GOTO 4
bcl:
DATA 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 0, 0
DATA 0, 9, 9, 9, 9, 0, 0, 0, 9, 9, 9, 9, 0, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0
DATA 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0
DATA 9, 9, 0, 9, 9, 0, 9, 9, 0, 0, 0, 0, 9, 9
DATA 9, 0, 9, 0, 0, 9, 9, 0, 9, 9, 9, 0, 0, 9
DATA 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 9, 9
DATA 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0
DATA 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 9, 9, 9, 9, 0, 0, 0, 9, 9, 9, 9, 0, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 0, 0
4 :
CLS
RESTORE bcr
FOR row = 1 TO 13
 FOR column = 1 TO 14
 READ picData
  PSET (column, row), picData
NEXT column
NEXT row
GET (0, 0)-(14, 13), bcr
GOTO 5
bcr:
DATA 0, 0, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 9, 9, 9, 9, 0, 0, 0, 9, 9, 9, 9, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0
DATA 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0
DATA 9, 9, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9
DATA 9, 0, 0, 9, 9, 9, 0, 9, 9, 0, 0, 9, 0, 9
DATA 9, 9, 0, 0, 0, 0, 9, 9, 0, 9, 9, 0, 9, 9
DATA 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0
DATA 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 9, 9, 9, 9, 0, 0, 0, 9, 9, 9, 9, 0
DATA 0, 0, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0

5 :
CLS
RESTORE wcu
FOR row = 1 TO 14
 FOR column = 1 TO 13
 READ picData
  PSET (column, row), picData
NEXT column
NEXT row
GET (0, 0)-(13, 14), wcu
GOTO 6
wcu:
DATA  0, 0, 0, 0, 0,15,15,15, 0, 0, 0, 0, 0
DATA  0,15, 0, 0,15,15, 0,15,15, 0, 0,15, 0
DATA  0,15, 0,15,15,15,15, 0,15,15, 0,15, 0
DATA  0,15, 0,15,15,15, 0,15,15,15, 0,15, 0
DATA  0,15, 0,15,15,15, 0,15,15,15, 0,15, 0
DATA  0, 0, 0,15,15,15,15, 0,15,15, 0, 0, 0
DATA  0, 0, 0,15,15,15,15,15,15,15, 0, 0, 0
DATA  0, 0, 0,15,15,15, 0,15,15,15, 0, 0, 0
DATA 15,15, 0,15,15, 0,15, 0,15,15, 0,15,15
DATA 15,15, 0,15,15, 0,15, 0,15,15, 0,15,15
DATA 15,15, 0,15,15, 0,15, 0,15,15, 0,15,15
DATA 15,15, 0,15,15, 0, 0, 0,15,15, 0,15,15
DATA  0, 0, 0, 0,15,15, 0,15,15, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0,15,15,15, 0, 0, 0, 0, 0
6 :
CLS
RESTORE wcd
FOR row = 1 TO 14
 FOR column = 1 TO 13
 READ picData
  PSET (column, row), picData
NEXT column
NEXT row
GET (0, 0)-(13, 14), wcd
GOTO 7
wcd:
DATA  0, 0, 0, 0, 0,15,15,15, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0,15,15, 0,15,15, 0, 0, 0, 0
DATA 15,15, 0,15,15, 0,15, 0,15,15, 0,15,15
DATA 15,15, 0,15,15, 0,15, 0,15,15, 0,15,15
DATA 15,15, 0,15,15, 0,15, 0,15,15, 0,15,15
DATA 15,15, 0,15,15, 0, 0, 0,15,15, 0,15,15
DATA  0, 0, 0,15,15,15, 0,15,15,15, 0, 0, 0
DATA  0, 0, 0,15,15,15,15,15,15,15, 0, 0, 0
DATA  0, 0, 0,15,15,15,15, 0,15,15, 0, 0, 0
DATA  0,15, 0,15,15,15, 0,15,15,15, 0,15, 0
DATA  0,15, 0,15,15,15, 0,15,15,15, 0,15, 0
DATA  0,15, 0,15,15,15,15, 0,15,15, 0,15, 0
DATA  0,15, 0, 0,15,15, 0,15,15, 0, 0,15, 0
DATA  0, 0, 0, 0, 0,15,15,15, 0, 0, 0, 0, 0
7 :
CLS
RESTORE wcl
FOR row = 1 TO 13
 FOR column = 1 TO 14
 READ picData
  PSET (column, row), picData
NEXT column
NEXT row
GET (0, 0)-(14, 13), wcl
GOTO 8
wcl:
DATA  0, 0, 0, 0, 0, 0, 0, 0,15,15,15,15, 0, 0
DATA  0,15,15,15,15, 0, 0, 0,15,15,15,15, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0,15,15,15,15,15,15,15,15,15,15, 0, 0
DATA  0,15,15,15,15,15,15,15,15,15,15,15,15, 0
DATA 15,15, 0,15,15, 0,15,15, 0, 0, 0, 0,15,15
DATA 15, 0,15, 0, 0,15,15, 0,15,15,15, 0, 0,15
DATA 15,15,15,15,15,15,15,15, 0, 0, 0, 0,15,15
DATA  0,15,15,15,15,15,15,15,15,15,15,15,15, 0
DATA  0, 0,15,15,15,15,15,15,15,15,15,15, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,15,15,15,15, 0, 0, 0,15,15,15,15, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0,15,15,15,15, 0, 0
8 :
CLS
RESTORE wcr
FOR row = 1 TO 13
 FOR column = 1 TO 14
 READ picData
  PSET (column, row), picData
NEXT column
NEXT row
GET (0, 0)-(14, 13), wcr
GOTO 9
wcr:
DATA  0, 0,15,15,15,15, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0,15,15,15,15, 0, 0, 0,15,15,15,15, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0,15,15,15,15,15,15,15,15,15,15, 0, 0
DATA  0,15,15,15,15,15,15,15,15,15,15,15,15, 0
DATA 15,15, 0, 0, 0, 0,15,15,15,15,15,15,15,15
DATA 15, 0, 0,15,15,15, 0,15,15, 0, 0,15, 0,15
DATA 15,15, 0, 0, 0, 0,15,15, 0,15,15, 0,15,15
DATA  0,15,15,15,15,15,15,15,15,15,15,15,15, 0
DATA  0, 0,15,15,15,15,15,15,15,15,15,15, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0,15,15,15,15, 0, 0, 0,15,15,15,15, 0
DATA  0, 0,15,15,15,15, 0, 0, 0, 0, 0, 0, 0, 0
9 :
CLS
RETURN

