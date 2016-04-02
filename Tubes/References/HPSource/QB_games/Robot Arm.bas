REM **********************************************
REM   More Qbasic Software at the Software Page.
REM       http://www.euronet.nl/users/rkohm/
REM          Any Questions? E-mail to:
REM              rkohm@euronet.nl
REM **********************************************

DECLARE SUB menu ()
DECLARE SUB movements ()
DECLARE SUB getlevel (whichone!)
DECLARE SUB win ()
DECLARE SUB waitawhile (howlong!)
DECLARE SUB dead ()
DECLARE SUB maze ()
DECLARE SUB move (whereto!)
DECLARE SUB entercomm ()
DECLARE SUB background ()

COMMON SHARED handloca, luggage$, level, line$, times, try, comm, test$
DIM SHARED te$(1001), commands$(1000), location$(99) '88 + 11

CONST PI = 3.141592654#

ON KEY(10) GOSUB endofgame
ON KEY(1) GOSUB newlist
KEY(10) ON

CLS : SCREEN 12

level = level + 1
try = 1

menu

DO
 ERASE location$
 luggage$ = "": line$ = "": handloca = 0: times = 0
 CLS
 
 background
 getlevel level
 maze
 entercomm
 movements
LOOP

PRINT "ERROR, PROGRAMME ENDED!!!!" 'You're not supposed to come here!!
END

endofgame:
END

newlist:
ERASE commands$
comm = 1
 FOR yht = 24 TO 28
  LOCATE yht, 4: PRINT SPACE$(5): LOCATE yht, 16: PRINT SPACE$(7)
 NEXT
 IF comm - 3 > 0 THEN
  LOCATE 24, 5: PRINT comm - 3: LOCATE 24, 16: PRINT commands$(comm - 3)
 END IF
 IF comm - 2 > 0 THEN
  LOCATE 25, 5: PRINT comm - 2: LOCATE 25, 16: PRINT commands$(comm - 2)
 END IF
 IF comm - 1 > 0 THEN
  LOCATE 26, 5: PRINT comm - 1: LOCATE 26, 16: PRINT commands$(comm - 1)
 END IF
 LOCATE 27, 5: PRINT comm: LOCATE 27, 15: PRINT "*" + commands$(comm)
 LOCATE 28, 5: PRINT comm + 1: LOCATE 28, 16: PRINT commands$(comm + 1)
RETURN

SUB background
DRAW "c15bm10,20d320r40u320r40d320r40u320r40"
DRAW "d320r40u320r40d320r40u320r40d320r40u320r40d320r40u320l440d320r440"
DRAW "u40l440u40r440u40l440u40r440u40l440u40r440u40l440u40"
DRAW "h10d340r460u340l460r5bdp15,15"
DRAW "bm550,40"
DRAW "c4br50bd20l100u40r100d40bh20bl3bu5p4,4c14l40u10g15f15u10r40u10bgp14,14"
DRAW "bm550,90a2"
DRAW "c4br50bd20l100u40r100d40bh20bl3bu5p4,4c14l40u10g15f15u10r40u10bgp14,14"
DRAW "bm525,170a3"
DRAW "c4br50bd20l100u40r100d40bh20bl3bu5p4,4c14l40u10g15f15u10r40u10bgp14,14"
DRAW "bm575,170a1"
DRAW "c4br50bd20l100u40r100d40bh20bl3bu5p4,4c14l40u10g15f15u10r40u10bgp14,14"
DRAW "a0bm550,250c4br50bd20l100u40r100d40bh20bl60bd11p4,4c14"
DRAW "u15r7u7l21d7r7d15r7bhp14,14f"
DRAW "br32u22l21d22r7u7r7d7r7u11bl7u7l7d7r7bfp14,14h"
DRAW "br11bd11u22r7d7e7r7g11f11l7h7d7l7bep14,14g"
DRAW "br24 u22r15d5l8d4r6d5l6d4r8d5l15bep14,14"
DRAW "a0bm550,300c4br50bd20l100u40r100d40bh20bl60bd11p4,4c14"
DRAW "bl13 u22r7d15r8d7l15bep14,14g"
DRAW "br33 u22l15d22r15bh4bu2 u10l7d10r7bfp14,14f3"
DRAW "bd2br18 u22l15d22r15bh4bu2 u10l7d10r7bfp14,14f3"
DRAW "br3bd2 u5r10u4l10u13r15d5l10d4r10d13l15bep14,14g"
DRAW "br18 u22r15d4l8d4r6d5l6d4r8d5l15bep14,14"

DRAW "c15 bm530,350 r40d40l40u40"
DRAW "bm480,5c4r140d330l140u330bfp1,4 bm480,5c15r140d330l140u330"
DRAW "c15bm220,363d90r270u90l270"
DRAW "c15bm500,411d40r120u40l120"

LOCATE 27, 65: COLOR 4: PRINT "Level:": LOCATE 27, 74: PRINT level
LOCATE 28, 65: COLOR 4: PRINT "Attempt:": LOCATE 28, 74: PRINT try

LOCATE 24, 30: COLOR 14: PRINT "F10"; : COLOR 15: PRINT " Exit"
LOCATE 25, 30: COLOR 14: PRINT "Page Up"; : COLOR 15: PRINT " Move up one command"
LOCATE 26, 30: COLOR 14: PRINT "Page Down"; : COLOR 15: PRINT " Move down one command"
LOCATE 27, 30: COLOR 14: PRINT "Insert"; : COLOR 15: PRINT " Insert a command"
LOCATE 28, 30: COLOR 14: PRINT "Delete"; : COLOR 15: PRINT " Delete a command"
LOCATE 24, 41: COLOR 14: PRINT "F1"; : COLOR 15: PRINT " New command list"

DRAW "c15bm15,363r175d90l175u90r75dc4d88br4u88"
DRAW "bm600,400p8,15"
DRAW "c14bm15,363r175d90l175u90"
DRAW "bm480,5c14r140d330l140u330"
DRAW "c14bm220,363d90r270u90l270"
DRAW "c14bm500,411d40r120u40l120"
END SUB

SUB dead
LOCATE 1, 1: PRINT "You're dead."
DO: userinput$ = INKEY$: LOOP UNTIL userinput$ <> ""
try = try + 1
END SUB

SUB entercomm
comm = 1

DO
 FOR yht = 24 TO 28
  LOCATE yht, 4: PRINT SPACE$(5): LOCATE yht, 16: PRINT SPACE$(7)
 NEXT
 IF comm - 3 > 0 THEN
  LOCATE 24, 5: PRINT comm - 3: LOCATE 24, 16: PRINT commands$(comm - 3)
 END IF
 IF comm - 2 > 0 THEN
  LOCATE 25, 5: PRINT comm - 2: LOCATE 25, 16: PRINT commands$(comm - 2)
 END IF
 IF comm - 1 > 0 THEN
  LOCATE 26, 5: PRINT comm - 1: LOCATE 26, 16: PRINT commands$(comm - 1)
 END IF
 LOCATE 27, 5: PRINT comm: LOCATE 27, 15: PRINT "*" + commands$(comm)
 LOCATE 28, 5: PRINT comm + 1: LOCATE 28, 16: PRINT commands$(comm + 1)
 KEY(1) ON
 DO: user$ = INKEY$: LOOP UNTIL user$ <> ""
 KEY(1) OFF
 SELECT CASE user$
  CASE "4": commands$(comm) = "left": comm = comm + 1
   PAINT (550, 40), 2, 4: PLAY "l30a": waitawhile .1: PAINT (550, 40), 14, 4
  CASE "8": commands$(comm) = "up": comm = comm + 1
   PAINT (525, 185), 2, 4: PLAY "l30a": waitawhile .1: PAINT (525, 185), 14, 4
  CASE "6": commands$(comm) = "right": comm = comm + 1
   PAINT (570, 90), 2, 4: PLAY "l30a": waitawhile .1: PAINT (570, 90), 14, 4
  CASE "2": commands$(comm) = "down": comm = comm + 1
   PAINT (575, 190), 2, 4: PLAY "l30a": waitawhile .1: PAINT (575, 190), 14, 4
  CASE "t": commands$(comm) = "take": comm = comm + 1
   PAINT (515, 250), 2, 4: PAINT (545, 250), 2, 4: PAINT (565, 250), 2, 4
   PAINT (590, 250), 2, 4: PLAY "l64a": waitawhile .1
   PAINT (515, 250), 14, 4: PAINT (545, 250), 14, 4: PAINT (565, 250), 14, 4
   PAINT (590, 250), 14, 4
  CASE "l": commands$(comm) = "loose": comm = comm + 1
   PAINT (510, 300), 2, 4: PAINT (538, 300), 2, 4: PAINT (545, 300), 2, 4
   PAINT (565, 300), 2, 4: PAINT (590, 300), 2, 4: PLAY "l64a": waitawhile .1
   PAINT (510, 300), 14, 4: PAINT (538, 300), 14, 4: PAINT (545, 300), 14, 4
   PAINT (565, 300), 14, 4: PAINT (590, 300), 14, 4
  CASE "9": IF comm > 1 THEN comm = comm - 1
  CASE "3": IF comm < 999 THEN comm = comm + 1
  CASE "0"
   ERASE te$
   FOR pol = comm TO 1000
    te$(pol) = commands$(pol)
   NEXT
   commands$(comm) = "": comm = comm + 1
   FOR pol = comm TO 1000
    commands$(pol) = te$(pol - 1)
   NEXT
  CASE "."
   ERASE te$
   FOR pol = comm + 1 TO 1000
    te$(pol) = commands$(pol)
   NEXT
   FOR pol = comm TO 1000
    commands$(pol) = te$(pol + 1)
   NEXT
 END SELECT
LOOP UNTIL user$ = CHR$(13)

END SUB

SUB getlevel (whichone)
SELECT CASE whichone
CASE 1: line$ = "h00000000000999000000009j9000000009i909g9000000009k900000000999000000500000000002000000f"
CASE 2: line$ = "0000000k0000000000000j9c999999999000000000000000b000000999999999g9000000000f048000000000"
CASE 3: line$ = "0d00090k00000000e0000j9c999999999000009000h00000bi00000999999999g900000e000f04800d900000"
CASE 4: line$ = "000009j0k0009999999990090h999f0g0090e090i090099b0c0099009000900d900990999999048000900000"
CASE 5: line$ = "k099j990hfb00i00090000009000900000099999000000999900000009000900000090009000500g000c0002"
CASE 6: line$ = "ake0ahafabad000000000dgagaca0a0a000000i00000a000a0agice00000a000000aha0a0000g63a0faf00aj"
CASE 7: line$ = "9k90909d901j0i000e0i079090909090090909090900909000909009090009090h9090h09090090gf0090cb0"
CASE 8: line$ = "1909999b090790h00000c009090000090090999990900900000909i00e0000g09k09000009090d90f999909j"
CASE 9: line$ = "ak948f00g0h00900f00990j0900000090cc900000090000b999009i00099h9009099900099990bgi000e000d"
CASE 10: line$ = "00f000000000999999999009k009c0090g9jih0090900999999909e00000000b90999999999904800000d000"
CASE 11: line$ = "c0000k0f00g09099j9909009099i99090b9999h999900999909999009999c9999d5999909999029999bb000e"
CASE 12: line$ = "jc00090bfikc000090000g00000g00000090909090909h909990i090000090000050000g0000020f0090h000"
CASE 13: line$ = "999480999999999909999999999d9999999999099999kdce0000igj99999f9999999999b9999999999h99999"
CASE 14: line$ = "000900090d009h909b909009090909f90i9090909090090cd90g00009090909090k9090909095j9000900092"
CASE 15: line$ = "99999f900ak91on900g00e9p7p90900009lqm90900009d9e909090099909090j00i000a0909009a00i09d90h"
 luggage$ = "h": DRAW "bm550,370 ": DRAW "p8,15c2bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3"' key green
CASE 16: LOCATE 12, 14: PRINT "You have won all the levels!!!!!": END
END SELECT
END SUB

SUB hlptext
'
'                             R O B O T 3.2
'                            ---------------
'                             by Robin Ohm
'RULES:
'
'Maybe It's wise to print this information!!!
'
'In this game there are 15 levels. (Maybe a few more or less) If you have
'won all the levels, you win the game.
'To win a level you only have to bring the CROSS to the END using the
'robotarm. To control the robotarm you'll have to write a program.
'If you have won all the levels you win the game.
'
'
'THE COMMANDS YOU CAN GIVE TO THE ROBOTARM:
'
'To give a command to the robotarm you have to press a key. These are the
'keys on the number pad. (The block of numbers on your right)
'
'ALWAYS MAKE SURE NUMLOCK IS ON!!!!!
'-----------------------------------
'
'(arrow keys on the number pad)
'-up: the robotarm moves up one square.
'-down: the robotarm moves down one square.
'-left: the robotarm move one square to the left.
'-right: (guess what) the robotarm moves one square to the right.
'
'(the keys 't' and 'l')
'-take: the robotarm takes what is in front of him. For example a key
'or the cross.
'-loose: the robotarm puts whatever he's carrying in front of him.
' You can also use this to unlock doors and bring the CROSS to END.
'
'First you have to write the programme using the commands above. The robot-
'arm won't immediatly react if you press a key. If you think you're ready
'you just press ENTER and the robotarm starts executing the programme you
'have written.
'
'
'OBJECTS IN THE MAZE:
'
'Wall: A grey square. If you hit a wall you're dead immediatly.
'Mine: If you hit a mine, you're dead too.
'Robotarm: The robotarm you can control. It has light- and dark-blue colors.
'Keys: There are red, yellow, green and blue keys. Keys are used to open
' doors. With a red key you can open red doors, etc... But be careful!!
' You can only use keys one time!!!
' To pick up a key you have to point the hand of the robotarm to the key and
' give the command "take". The arm will now take the key. In the
' bottom-right corner of the screen in the black square you will see a
' key appear. In that square you can see what you are carrying. You can only
' carry one thing at a time.
'Doors: There are red, yellow, green and blue doors and can be opened by a
' key of the same color. To open a door you have to point the hand of the
' robotarm to the door and give te command "loose". The door and the key
' you were carrying are gone and you have returned to the same position.
'Cross: If you want to win the level you'll have to bring the cross to
' the square which says END. You can pick up the cross the same way as you do
' with keys.
'END: This is the point you have to deliver the cross to. To deliver the
' cross you only have to this:
' - pick up the cross (see: Cross)
' - point the hand of the robotarm to END and give the command: "loose". If
'   all goes well you have now won the level and can start with the next
'   one.
'
'
'TESTLEVEL:
'
'Maybe you don't understand the rules totally, so I'll give you the solution
'to the first level.
'If you still have questions, just send an e-mail to rkohm@euronet.nl
'
'- Start Qbasic and load robotv32.bas
'- Press SHIFT + F5
'- Select "1" from the menu.
'- Give the following commands:
'
'  l,l,l,u,u,u,u,u,t,d,d,d,d,r,r,u,lo,d,r,r,d,d,r,r,r,r,r,t,u,u,u,u,u,u,l
'  l,l,d,lo,d,t,u,l,l,d,d,l,l,u,lo
'
'(l = arrow left on the number pad)
'(r = arrow right on the number pad)
'(u = arrow up on the number pad)
'(d = arrow down on the number pad)
'
'(t = press the 't' (from 'take') )
'(lo = press the 'l' (from 'loose') )
'                                       
'
'CORRECTING MISTAKES:
'
'If you make a mistake while you are writing the program for the robot-arm,
'you can correct them with the following keys:
'
'ALWAYS USE THE KEYS ON THE NUMBER PAD AND MAKE SURE NUMLOCK IS ON!!!
'--------------------------------------------------------------------
'
'PageUp: Move up one command in the list.
'PageDown: Move down one command in the list.
'Insert: Insert a blank line.
'Delete: Delete the line.
'F1: Forget the old list and start a new one.
'
'NOTE: Deleting and inserting a line takes a few moments, especially on slow
'computers. So only press Insert or Delete once if you want to delete or
'insert only one line!!
END SUB

SUB maze
'OPEN "c:\qbasic\robot\levels.dat" FOR INPUT AS #1
'LINE INPUT #1, line$
'CLOSE #1

FOR tempor = 1 TO 88
 location$(tempor) = MID$(line$, tempor, 1)
NEXT

FOR tempor = 1 TO 88
SELECT CASE location$(tempor)
CASE "0": move tempor: DRAW "bh19p0,15bf19"
CASE "1": move tempor: DRAW "bh19p0,15bf19"
 DRAW "a2p3,15 c1bl5u19r10d19l10bep1,1a0"'end 1
CASE "2": move tempor: DRAW "bh19p0,15bf19"
 DRAW "a0p3,15 c1bl5u19r10d19l10bep1,1a0"'end 2
CASE "3": move tempor: DRAW "bh19p0,15bf19"
 DRAW "a1p3,15 c1bl5u19r10d19l10bep1,1a0"'end 3
CASE "4": move tempor: DRAW "bh19p0,15bf19"
 DRAW "a3p3,15 c1bl5u19r10d19l10bep1,1a0"'end 4
CASE "5": move tempor: DRAW "bh19p0,15bf19": handloca = tempor
 DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
CASE "6": move tempor: DRAW "bh19p0,15bf19": handloca = tempor
 DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
CASE "7": move tempor: DRAW "bh19p0,15bf19": handloca = tempor
 DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
CASE "8": move tempor: DRAW "bh19p0,15bf19": handloca = tempor
 DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
CASE "9": move tempor: DRAW "bh19p0,15bf19": DRAW "p8,15"'wall
CASE "a": move tempor: DRAW "bh19p0,15bf19"
 DRAW "p4,15d4": CIRCLE STEP(0, 0), 10, 0     'bomb
 DRAW "p0,0r3u12l6d5r3bu4p0,0uc7u2er2erfrf2r3fc14bu3u2ebf3bleerbg3bd2ffdbh3blddg"
CASE "b": move tempor: DRAW "bh19p0,15bf19"
 DRAW "p8,15c4bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3" ' key red
CASE "c": move tempor: DRAW "bh19p0,15bf19"                  'door red
 DRAW "p8,15c7bd19l10u30r20d30nl10bh3u10l14d10r14bu24l14d10r14u10bup4,7bg5p7,7bd15p7,7c8bh6uld"
CASE "d": move tempor: DRAW "bh19p0,15bf19"
 DRAW "p8,15c1bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3" ' key blue
CASE "e": move tempor: DRAW "bh19p0,15bf19"                  'door blue
 DRAW "p8,15c7bd19l10u30r20d30nl10bh3u10l14d10r14bu24l14d10r14u10bup1,7bg5p7,7bd15p7,7c8bh6uld"
CASE "f": move tempor: DRAW "bh19p0,15bf19"
 DRAW "p8,15c14bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3" ' key yellow
CASE "g": move tempor: DRAW "bh19p0,15bf19"                   'door yellow
 DRAW "p8,15c7bd19l10u30r20d30nl10bh3u10l14d10r14bu24l14d10r14u10bup14,7bg5p7,7bd15p7,7c8bh6uld"
CASE "h": move tempor: DRAW "bh19p0,15bf19"
 DRAW "p8,15c2bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3" ' key green
CASE "i": move tempor: DRAW "bh19p0,15bf19"                  'door green
 DRAW "p8,15c7bd19l10u30r20d30nl10bh3u10l14d10r14bu24l14d10r14u10bup2,7bg5p7,7bd15p7,7c8bh6uld"
CASE "j": move tempor: DRAW "bh19p0,15bf19"     'endpoint
 DRAW "p8,15c4bd10bl18u20r10d4l5d4r4d4l4d4r5d4l10bep4,4gbr13u20r10d20l4u15l2d15l4bep4,4gbr13u20r6f4d12g4l6be4buu10r3d10l3bgp4,4"
CASE "k": move tempor: DRAW "bh19p0,15bf19"     'cross
 DRAW "p8,15c4bl5g10f5e10f10e5h10e10h5g10h10g5f10brp4,4"
CASE "l": move tempor: DRAW "bh19p0,15bf19"
 DRAW "a0p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 1
CASE "m": move tempor: DRAW "bh19p0,15bf19"
 DRAW "a1p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 2
CASE "n": move tempor: DRAW "bh19p0,15bf19"
 DRAW "a2p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 3
CASE "o": move tempor: DRAW "bh19p0,15bf19"
 DRAW "a3p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 4
CASE "p": move tempor: DRAW "bh19p0,15bf19"
 DRAW "a0p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 1
CASE "q": move tempor: DRAW "bh19p0,15bf19"
 DRAW "a1p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 2
END SELECT
NEXT
END SUB

SUB menu
again:
CLS
COLOR 1: LOCATE 12, 33: PRINT "Your choice? (1-4)"
COLOR 2: LOCATE 13, 33: PRINT "1. Play a game"
COLOR 4: LOCATE 14, 33: PRINT "2. Instructions"
COLOR 14: LOCATE 15, 33: PRINT "3. About this game"
COLOR 6: LOCATE 16, 33: PRINT "4. Enter a password for a level."
COLOR 10: LOCATE 17, 33: PRINT "5. Exit"

DO: choice$ = INKEY$: LOOP UNTIL choice$ <> ""

SELECT CASE VAL(choice$)
CASE 1: EXIT SUB
CASE 2:
 CLS
 COLOR 2: LOCATE 12, 20: PRINT "I put the rules in a Sub called hlptext. If you want to"
 COLOR 2: LOCATE 13, 20: PRINT "read the rules, you have to do this:"
 COLOR 4: LOCATE 15, 20: PRINT "- Press F10 and Enter (You will return to QBASIC)"
 COLOR 14: LOCATE 16, 20: PRINT "- Press F2"
 COLOR 1: LOCATE 17, 20: PRINT "- Select 'hlptext' and press Enter."
 DO: LOOP UNTIL INKEY$ <> ""
 GOTO again
CASE 3
 CLS
 COLOR 1: LOCATE 3, 30: PRINT " Robot Version 3.2"
 COLOR 2: LOCATE 4, 30: PRINT "Created by Robin Ohm"
 COLOR 4: LOCATE 5, 30: PRINT "Completed: 14-9-1996"
 COLOR 14: LOCATE 7, 1
 PRINT "If you have a question about this game, just send an e-mail to rkohm@euronet.nl"
 LOCATE 8, 1: PRINT "More BASIC Software at:"
 LOCATE 9, 1: PRINT "http://www.euronet.nl/users/rkohm/"
 DO: LOOP UNTIL INKEY$ <> ""
 COLOR 15
 GOTO again
CASE 4
 CLS : INPUT "Enter password: ", password$
 SELECT CASE VAL(password$)
  CASE FIX(ATN(TAN(PI / 2.004312)) * 9954205)
   PRINT "Password for level 2.": level = 2
  CASE FIX(ATN(COS(PI / 5.643)) * 76120967)
   PRINT "Password for level 3.": level = 3
  CASE FIX(ATN(SIN(PI / 38.7743)) * 1116528679)
   PRINT "Password for level 4.": level = 4
  CASE FIX(ATN(ATN(PI / 42.8664)) * 1105218562)
   PRINT "Password for level 5.": level = 5
  CASE FIX(TAN(PI / 39.954) * 999421075)
   PRINT "Password for level 6.": level = 6
  CASE FIX(ATN(PI / 45.87) * 894321765)
   PRINT "Password for level 7.": level = 7
  CASE FIX(COS(PI / 40) * 34569247)
   PRINT "Password for level 8.": level = 8
  CASE FIX(SIN(COS(PI / 40)) * 85431858)
   PRINT "Password for level 9.": level = 9
  CASE FIX(COS(SIN(PI / 40)) * 63628747)
   PRINT "Password for level 10.": level = 10
  CASE FIX(COS(TAN(PI / 35.9855)) * 63628747)
   PRINT "Password for level 11.": level = 11
  CASE FIX(TAN(COS(PI / 5.643)) * 76120967)
   PRINT "Password for level 12.": level = 12
  CASE FIX(COS(COS(PI / 5.643)) * 76120967)
   PRINT "Password for level 13.": level = 13
  CASE FIX(SIN(SIN(PI / 5.643)) * 76120967)
   PRINT "Password for level 14.": level = 14
  CASE FIX(TAN(TAN(PI / 5.643)) * 76120967)
   PRINT "Password for level 15.": level = 15
  CASE ELSE
   PRINT "Wrong password. Acces denied."
   DO: LOOP UNTIL INKEY$ <> "": GOTO again
 END SELECT
 DO: LOOP UNTIL INKEY$ <> ""
CASE 5
 END
CASE ELSE
 GOTO again
END SELECT
END SUB

SUB move (whereto)
SELECT CASE whereto
CASE 1: g$ = "30,40"
CASE 2: g$ = "70,40"
CASE 3: g$ = "110,40"
CASE 4: g$ = "150,40"
CASE 5: g$ = "190,40"
CASE 6: g$ = "230,40"
CASE 7: g$ = "270,40"
CASE 8: g$ = "310,40"
CASE 9: g$ = "350,40"
CASE 10: g$ = "390,40"
CASE 11: g$ = "430,40"
CASE 12: g$ = "30,80"
CASE 13: g$ = "70,80"
CASE 14: g$ = "110,80"
CASE 15: g$ = "150,80"
CASE 16: g$ = "190,80"
CASE 17: g$ = "230,80"
CASE 18: g$ = "270,80"
CASE 19: g$ = "310,80"
CASE 20: g$ = "350,80"
CASE 21: g$ = "390,80"
CASE 22: g$ = "430,80"
CASE 23: g$ = "30,120"
CASE 24: g$ = "70,120"
CASE 25: g$ = "110,120"
CASE 26: g$ = "150,120"
CASE 27: g$ = "190,120"
CASE 28: g$ = "230,120"
CASE 29: g$ = "270,120"
CASE 30: g$ = "310,120"
CASE 31: g$ = "350,120"
CASE 32: g$ = "390,120"
CASE 33: g$ = "430,120"
CASE 34: g$ = "30,160"
CASE 35: g$ = "70,160"
CASE 36: g$ = "110,160"
CASE 37: g$ = "150,160"
CASE 38: g$ = "190,160"
CASE 39: g$ = "230,160"
CASE 40: g$ = "270,160"
CASE 41: g$ = "310,160"
CASE 42: g$ = "350,160"
CASE 43: g$ = "390,160"
CASE 44: g$ = "430,160"
CASE 45: g$ = "30,200"
CASE 46: g$ = "70,200"
CASE 47: g$ = "110,200"
CASE 48: g$ = "150,200"
CASE 49: g$ = "190,200"
CASE 50: g$ = "230,200"
CASE 51: g$ = "270,200"
CASE 52: g$ = "310,200"
CASE 53: g$ = "350,200"
CASE 54: g$ = "390,200"
CASE 55: g$ = "430,200"
CASE 56: g$ = "30,240"
CASE 57: g$ = "70,240"
CASE 58: g$ = "110,240"
CASE 59: g$ = "150,240"
CASE 60: g$ = "190,240"
CASE 61: g$ = "230,240"
CASE 62: g$ = "270,240"
CASE 63: g$ = "310,240"
CASE 64: g$ = "350,240"
CASE 65: g$ = "390,240"
CASE 66: g$ = "430,240"
CASE 67: g$ = "30,280"
CASE 68: g$ = "70,280"
CASE 69: g$ = "110,280"
CASE 70: g$ = "150,280"
CASE 71: g$ = "190,280"
CASE 72: g$ = "230,280"
CASE 73: g$ = "270,280"
CASE 74: g$ = "310,280"
CASE 75: g$ = "350,280"
CASE 76: g$ = "390,280"
CASE 77: g$ = "430,280"
CASE 78: g$ = "30,320"
CASE 79: g$ = "70,320"
CASE 80: g$ = "110,320"
CASE 81: g$ = "150,320"
CASE 82: g$ = "190,320"
CASE 83: g$ = "230,320"
CASE 84: g$ = "270,320"
CASE 85: g$ = "310,320"
CASE 86: g$ = "350,320"
CASE 87: g$ = "390,320"
CASE 88: g$ = "430,320"
END SELECT

g$ = "bm" + g$
DRAW "x" + VARPTR$(g$)
END SUB

SUB movements
FOR temp = 1 TO 1000
waitawhile .2
 IF temp > 1000 THEN dead: EXIT SUB
 FOR yht = 24 TO 28
  LOCATE yht, 4: PRINT SPACE$(5): LOCATE yht, 16: PRINT SPACE$(7)
 NEXT
 IF temp - 3 > 0 THEN
  LOCATE 24, 5: PRINT temp - 3: LOCATE 24, 16: PRINT commands$(temp - 3)
 END IF
 IF temp - 2 > 0 THEN
  LOCATE 25, 5: PRINT temp - 2: LOCATE 25, 16: PRINT commands$(temp - 2)
 END IF
 IF temp - 1 > 0 THEN
  LOCATE 26, 5: PRINT temp - 1: LOCATE 26, 16: PRINT commands$(temp - 1)
 END IF
 LOCATE 27, 5: PRINT temp: LOCATE 27, 15: PRINT "*" + commands$(temp)
 LOCATE 28, 5: PRINT temp + 1: LOCATE 28, 16: PRINT commands$(temp + 1)

 SELECT CASE commands$(temp)
  CASE "": times = times + 1
   IF times > 10 THEN dead: EXIT SUB
  CASE "up"
   IF handloca - 11 <= 0 THEN dead: EXIT SUB
   IF location$(handloca - 11) <> "0" AND location$(handloca) <> "7" THEN dead: EXIT SUB
   move handloca: DRAW "bh19p0,15bf19"
   handloca = handloca - 11              'new handlocation
    SELECT CASE location$(handloca + 11) 'still the old one
     CASE "5"
      DRAW "a0p3,15bl5bd19c1u38r10d38l10bep1,1a0" 'straight 1
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
      location$(handloca) = "5": location$(handloca + 11) = "p"
     CASE "6"
      DRAW "a0p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 1
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
      location$(handloca) = "5": location$(handloca + 11) = "l"
     CASE "7"
      move handloca: DRAW "bh19p0,15bf19"
      IF location$(handloca - 1) = "q" OR location$(handloca - 1) = "l" OR location$(handloca - 1) = "o" OR location$(handloca - 1) = "4" THEN
       DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
       location$(handloca) = "8": location$(handloca + 11) = "0"
      ELSEIF location$(handloca + 1) = "q" OR location$(handloca + 1) = "n" OR location$(handloca + 1) = "m" OR location$(handloca + 1) = "3" THEN
       DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
       location$(handloca) = "6": location$(handloca + 11) = "0"
      ELSE
       DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
       location$(handloca) = "7": location$(handloca + 11) = "0"
      END IF
     CASE "8"
      DRAW "a1p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 2
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
      location$(handloca) = "5": location$(handloca + 11) = "m"
     CASE ELSE: PRINT "ERROR, PROGRAMME TERMINATED!!!": END
    END SELECT
   CASE "left"
    IF handloca = 1 OR handloca = 12 OR handloca = 23 THEN dead: EXIT SUB
    IF handloca = 34 OR handloca = 45 OR handloca = 56 THEN dead: EXIT SUB
    IF handloca = 67 OR handloca = 78 OR handloca = 89 THEN dead: EXIT SUB
    IF location$(handloca - 1) <> "0" AND location$(handloca) <> "8" THEN dead: EXIT SUB
    move handloca: DRAW "bh19p0,15bf19"
    handloca = handloca - 1
    SELECT CASE location$(handloca + 1)
     CASE "5"
      DRAW "a2p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 3
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
      location$(handloca) = "6": location$(handloca + 1) = "n"
     CASE "6"
      DRAW "a1p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 2
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
      location$(handloca) = "6": location$(handloca + 1) = "q"
     CASE "7"
      DRAW "a1p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 2
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
      location$(handloca) = "6": location$(handloca + 1) = "m"
     CASE "8"
      move handloca: DRAW "bh19p0,15bf19"
      IF handloca > 11 THEN
       IF location$(handloca - 11) = "p" OR location$(handloca - 11) = "n" OR location$(handloca - 11) = "o" OR location$(handloca - 11) = "1" THEN
        DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
        location$(handloca) = "7": location$(handloca + 1) = "0"
       ELSEIF location$(handloca + 11) = "p" OR location$(handloca + 11) = "l" OR location$(handloca + 11) = "m" OR location$(handloca + 11) = "2" THEN
        DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
        location$(handloca) = "5": location$(handloca + 1) = "0"
       ELSE
        DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
        location$(handloca) = "8": location$(handloca + 1) = "0"
       END IF
      ELSEIF handloca <= 11 THEN
       IF location$(handloca + 11) = "p" OR location$(handloca + 11) = "l" OR location$(handloca + 11) = "m" OR location$(handloca + 11) = "2" THEN
        DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
        location$(handloca) = "5": location$(handloca + 1) = "0"
       ELSE
        DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
        location$(handloca) = "8": location$(handloca + 1) = "0"
       END IF
      END IF
     CASE ELSE: PRINT "ERROR, PROGRAMME TERMINATED!!!": END
     END SELECT
   CASE "right"
    IF handloca = 11 OR handloca = 22 OR handloca = 33 THEN dead: EXIT SUB
    IF handloca = 44 OR handloca = 55 OR handloca = 66 THEN dead: EXIT SUB
    IF handloca = 77 OR handloca = 88 THEN dead: EXIT SUB
    IF location$(handloca + 1) <> "0" AND location$(handloca) <> "6" THEN dead: EXIT SUB
    move handloca: DRAW "bh19p0,15bf19"
    handloca = handloca + 1
    SELECT CASE location$(handloca - 1)
     CASE "5"
      DRAW "a3p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 4
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
      location$(handloca) = "8": location$(handloca - 1) = "o"
     CASE "6"
      move handloca: DRAW "bh19p0,15bf19"
      IF handloca > 11 THEN
       IF location$(handloca - 11) = "p" OR location$(handloca - 11) = "n" OR location$(handloca - 11) = "o" OR location$(handloca - 11) = "1" THEN
        DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
        location$(handloca) = "7": location$(handloca - 1) = "0"
       ELSEIF location$(handloca + 11) = "p" OR location$(handloca + 11) = "l" OR location$(handloca + 11) = "m" OR location$(handloca + 11) = "2" THEN
        DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
        location$(handloca) = "5": location$(handloca - 1) = "0"
       ELSE
        DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
        location$(handloca) = "6": location$(handloca - 1) = "0"
       END IF
      ELSEIF handloca <= 11 THEN
       IF location$(handloca + 11) = "p" OR location$(handloca + 11) = "l" OR location$(handloca + 11) = "m" OR location$(handloca + 11) = "2" THEN
        DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
        location$(handloca) = "5": location$(handloca - 1) = "0"
       ELSE
        DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
        location$(handloca) = "6": location$(handloca - 1) = "0"
       END IF
      END IF
     CASE "7"
      DRAW "a0p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 1
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
      location$(handloca) = "8": location$(handloca - 1) = "l"
     CASE "8"
      DRAW "a1p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 2
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
      location$(handloca) = "8": location$(handloca - 1) = "q"
     CASE ELSE: PRINT "ERROR, PROGRAMME TERMINATED!!!": END
     END SELECT
   CASE "down"
    IF handloca + 11 > 88 THEN dead: EXIT SUB
    IF location$(handloca + 11) <> "0" AND location$(handloca) <> "5" THEN dead: EXIT SUB
    move handloca: DRAW "bh19p0,15bf19"
    handloca = handloca + 11
    SELECT CASE location$(handloca - 11)
     CASE "5"
      move handloca: DRAW "bh19p0,15bf19"
      IF location$(handloca - 1) = "q" OR location$(handloca - 1) = "l" OR location$(handloca - 1) = "o" OR location$(handloca - 1) = "4" THEN
       DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
       location$(handloca) = "8": location$(handloca - 11) = "0"
      ELSEIF location$(handloca + 1) = "q" OR location$(handloca + 1) = "n" OR location$(handloca + 1) = "m" OR location$(handloca + 1) = "3" THEN
       DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
       location$(handloca) = "6": location$(handloca - 11) = "0"
      ELSE
       DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
       location$(handloca) = "5": location$(handloca - 11) = "0"
      END IF
     CASE "6"
      DRAW "a3p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 4
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
      location$(handloca) = "7": location$(handloca - 11) = "o"
     CASE "7"
      DRAW "a0p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 1
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
      location$(handloca) = "7": location$(handloca - 11) = "p"
     CASE "8"
      DRAW "a2p3,15 bl5c1bu19d24r24u10l14u14l10bfp1,1a0"'corner 3
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
      location$(handloca) = "7": location$(handloca - 11) = "n"
     CASE ELSE: PRINT "ERROR, PROGRAMME TERMINATED!!!": END
     END SELECT
   CASE "take"
    IF luggage$ <> "" THEN dead: EXIT SUB
    move handloca: DRAW "bh19p0,15bf19"
    SELECT CASE location$(handloca)
     CASE "5"
      IF handloca <= 11 THEN dead: EXIT SUB
      SELECT CASE location$(handloca - 11)
       CASE "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "c", "e": dead: EXIT SUB
       CASE "g", "i", "j", "l", "m", "n", "o", "p", "q": dead: EXIT SUB
      END SELECT
      DRAW "a0p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 1
      move handloca - 11: DRAW "bh19p0,15bf19"
      DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
      waitawhile .5
      move handloca - 11: DRAW "bh19p0,15bf19"
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
      IF location$(handloca - 11) <> "0" THEN
       luggage$ = location$(handloca - 11)
      END IF
      location$(handloca - 11) = "0"
     CASE "6"
      SELECT CASE handloca
       CASE 12, 23, 34, 45, 56, 67, 78: dead: EXIT SUB
       CASE ELSE
        SELECT CASE location$(handloca - 1)
         CASE "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "c", "e": dead: EXIT SUB
         CASE "g", "i", "j", "l", "m", "n", "o", "p", "q": dead: EXIT SUB
        END SELECT
        DRAW "a1p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 2
        move handloca - 1: DRAW "bh19p0,15bf19"
        DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
        waitawhile .5
        move handloca - 1: DRAW "bh19p0,15bf19"
        move handloca: DRAW "bh19p0,15bf19"
        DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
        IF location$(handloca - 1) <> "0" THEN
         luggage$ = location$(handloca - 1)
        END IF
        location$(handloca - 1) = "0"
      END SELECT
     CASE "7"
      IF handloca + 11 > 88 THEN dead: EXIT SUB
      SELECT CASE location$(handloca + 11)
       CASE "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "c", "e": dead: EXIT SUB
       CASE "g", "i", "j", "l", "m", "n", "o", "p", "q": dead: EXIT SUB
      END SELECT
      DRAW "a0p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 1
      move handloca + 11: DRAW "bh19p0,15bf19"
      DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
      waitawhile .5
      move handloca + 11: DRAW "bh19p0,15bf19"
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
      IF location$(handloca + 11) <> "0" THEN
       luggage$ = location$(handloca + 11)
      END IF
      location$(handloca + 11) = "0"
     CASE "8"
      SELECT CASE handloca
       CASE 11, 22, 33, 44, 55, 66, 77, 88: dead: EXIT SUB
       CASE ELSE
        SELECT CASE location$(handloca + 1)
         CASE "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "c", "e": dead: EXIT SUB
         CASE "g", "i", "j", "l", "m", "n", "o", "p", "q": dead: EXIT SUB
        END SELECT
        DRAW "a1p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 2
        move handloca + 1: DRAW "bh19p0,15bf19"
        DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
        waitawhile .5
        move handloca + 1: DRAW "bh19p0,15bf19"
        move handloca: DRAW "bh19p0,15bf19"
        DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
        IF location$(handloca + 1) <> "0" THEN
         luggage$ = location$(handloca + 1)
        END IF
        location$(handloca + 1) = "0"
      END SELECT
     END SELECT
      IF luggage$ <> "" THEN
       DRAW "bm550,370bh19p0,15bf19"
       SELECT CASE luggage$
        CASE "b": DRAW "p8,15c4bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3"' key red
        CASE "d": DRAW "p8,15c1bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3"' key blue
        CASE "f": DRAW "p8,15c14bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3"' key yellow
        CASE "h": DRAW "p8,15c2bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3"' key green
        CASE "k": DRAW "p8,15c4bl5g10f5e10f10e5h10e10h5g10h10g5f10brp4,4"'cross
        CASE ELSE: PRINT "ERROR, PROGRAMME TERMINATED!!!": END
       END SELECT
      END IF
   CASE "loose"
    IF luggage$ = "" THEN dead: EXIT SUB
    move handloca: DRAW "bh19p0,15bf19"
    SELECT CASE location$(handloca)
     CASE "5"
      IF handloca <= 11 THEN dead: EXIT SUB
      SELECT CASE location$(handloca - 11)
       CASE "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "d": dead: EXIT SUB
       CASE "f", "h", "k", "l", "m", "n", "o", "p", "q": dead: EXIT SUB
      END SELECT
      DRAW "a0p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 1
      move handloca - 11: DRAW "bh19p0,15bf19"
      DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
      waitawhile .5
      DRAW "bm550,370bh19p0,15bf19"
      move handloca - 11: DRAW "bh19p0,15bf19"
      SELECT CASE location$(handloca - 11)
       CASE "0"
        SELECT CASE luggage$
         CASE "b": DRAW "p8,15c4bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca - 11) = luggage$ ' key red
         CASE "d": DRAW "p8,15c1bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca - 11) = luggage$  ' key blue
         CASE "f": DRAW "p8,15c14bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca - 11) = luggage$ ' key yellow
         CASE "h": DRAW "p8,15c2bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca - 11) = luggage$ ' key green
         CASE "k": DRAW "p8,15c4bl5g10f5e10f10e5h10e10h5g10h10g5f10brp4,4": location$(handloca - 11) = luggage$ 'cross
        END SELECT
       CASE "c": location$(handloca - 11) = "0": IF luggage$ <> "b" THEN dead: EXIT SUB
       CASE "e": location$(handloca - 11) = "0": IF luggage$ <> "d" THEN dead: EXIT SUB
       CASE "g": location$(handloca - 11) = "0": IF luggage$ <> "f" THEN dead: EXIT SUB
       CASE "i": location$(handloca - 11) = "0": IF luggage$ <> "h" THEN dead: EXIT SUB
       CASE "j": location$(handloca - 11) = "0": IF luggage$ <> "k" THEN dead: EXIT SUB
        move handloca: DRAW "bh19p0,15bf19"
        DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
        win              ' YOU WIN!!!!
        EXIT SUB
      END SELECT
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a0bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 1
      luggage$ = ""
    CASE "6"
     IF handloca = 1 OR handloca = 12 OR handloca = 23 THEN dead: EXIT SUB
     IF handloca = 34 OR handloca = 45 OR handloca = 56 THEN dead: EXIT SUB
     IF handloca = 67 OR handloca = 78 THEN dead: EXIT SUB
     SELECT CASE location$(handloca - 1)
      CASE "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "d": dead: EXIT SUB
      CASE "f", "h", "k", "l", "m", "n", "o", "p", "q": dead: EXIT SUB
     END SELECT
     DRAW "a1p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 2
     move handloca - 1: DRAW "bh19p0,15bf19"
     DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
     waitawhile .5
     DRAW "bm550,370bh19p0,15bf19"
     move handloca - 1: DRAW "bh19p0,15bf19"
     SELECT CASE location$(handloca - 1)
      CASE "0"
       SELECT CASE luggage$
        CASE "b": DRAW "p8,15c4bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca - 1) = luggage$ ' key red
        CASE "d": DRAW "p8,15c1bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca - 1) = luggage$  ' key blue
        CASE "f": DRAW "p8,15c14bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca - 1) = luggage$ ' key yellow
        CASE "h": DRAW "p8,15c2bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca - 1) = luggage$ ' key green
        CASE "k": DRAW "p8,15c4bl5g10f5e10f10e5h10e10h5g10h10g5f10brp4,4": location$(handloca - 1) = luggage$ 'cross
       END SELECT
      CASE "c": location$(handloca - 1) = "0": IF luggage$ <> "b" THEN dead: EXIT SUB
      CASE "e": location$(handloca - 1) = "0": IF luggage$ <> "d" THEN dead: EXIT SUB
      CASE "g": location$(handloca - 1) = "0": IF luggage$ <> "f" THEN dead: EXIT SUB
      CASE "i": location$(handloca - 1) = "0": IF luggage$ <> "h" THEN dead: EXIT SUB
      CASE "j": location$(handloca - 1) = "0": IF luggage$ <> "k" THEN dead: EXIT SUB
       move handloca: DRAW "bh19p0,15bf19"
       DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
       win  ' YOU WIN!!!!
       EXIT SUB
     END SELECT
     move handloca: DRAW "bh19p0,15bf19"
     DRAW "a1bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 2
     luggage$ = ""
    CASE "7"
      IF handloca > 77 THEN dead: EXIT SUB
      SELECT CASE location$(handloca + 11)
       CASE "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "d": dead: EXIT SUB
       CASE "f", "h", "k", "l", "m", "n", "o", "p", "q": dead: EXIT SUB
      END SELECT
      DRAW "a0p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 1
      move handloca + 11: DRAW "bh19p0,15bf19"
      DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
      waitawhile .5
      DRAW "bm550,370bh19p0,15bf19"
      move handloca + 11: DRAW "bh19p0,15bf19"
      SELECT CASE location$(handloca + 11)
       CASE "0"
        SELECT CASE luggage$
         CASE "b": DRAW "p8,15c4bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca + 11) = luggage$ ' key red
         CASE "d": DRAW "p8,15c1bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca + 11) = luggage$  ' key blue
         CASE "f": DRAW "p8,15c14bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca + 11) = luggage$ ' key yellow
         CASE "h": DRAW "p8,15c2bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca + 11) = luggage$ ' key green
         CASE "k": DRAW "p8,15c4bl5g10f5e10f10e5h10e10h5g10h10g5f10brp4,4": location$(handloca + 11) = luggage$ 'cross
        END SELECT
       CASE "c": location$(handloca + 11) = "0": IF luggage$ <> "b" THEN dead: EXIT SUB
       CASE "e": location$(handloca + 11) = "0": IF luggage$ <> "d" THEN dead: EXIT SUB
       CASE "g": location$(handloca + 11) = "0": IF luggage$ <> "f" THEN dead: EXIT SUB
       CASE "i": location$(handloca + 11) = "0": IF luggage$ <> "h" THEN dead: EXIT SUB
       CASE "j": location$(handloca + 11) = "0": IF luggage$ <> "k" THEN dead: EXIT SUB
        move handloca: DRAW "bh19p0,15bf19"
        DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
        win  ' YOU WIN!!!!
        EXIT SUB
      END SELECT
      move handloca: DRAW "bh19p0,15bf19"
      DRAW "a2bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 3
      luggage$ = ""
    CASE "8"
     IF handloca = 11 OR handloca = 22 THEN dead: EXIT SUB
     IF handloca = 33 OR handloca = 44 OR handloca = 55 THEN dead: EXIT SUB
     IF handloca = 66 OR handloca = 77 OR handloca = 88 THEN dead: EXIT SUB
     SELECT CASE location$(handloca + 1)
      CASE "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "d": dead: EXIT SUB
      CASE "f", "h", "k", "l", "m", "n", "o", "p", "q": dead: EXIT SUB
     END SELECT
     DRAW "a1p3,15bl5bd19c1u38r10d38l10bep1,1a0"'straight 2
     move handloca + 1: DRAW "bh19p0,15bf19"
     DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
     waitawhile .5
     DRAW "bm550,370bh19p0,15bf19"
     move handloca + 1: DRAW "bh19p0,15bf19"
     SELECT CASE location$(handloca + 1)
      CASE "0"
       SELECT CASE luggage$
        CASE "b": DRAW "p8,15c4bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca + 1) = luggage$' key red
        CASE "d": DRAW "p8,15c1bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca + 1) = luggage$ ' key blue
        CASE "f": DRAW "p8,15c14bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca + 1) = luggage$' key yellow
        CASE "h": DRAW "p8,15c2bd2u8e4h4g4f4bu2ubd5d18u2nr2u2nru2nr3": location$(handloca + 1) = luggage$' key green
        CASE "k": DRAW "p8,15c4bl5g10f5e10f10e5h10e10h5g10h10g5f10brp4,4": location$(handloca + 1) = luggage$'cross
       END SELECT
      CASE "c": location$(handloca + 1) = "0": IF luggage$ <> "b" THEN dead: EXIT SUB
      CASE "e": location$(handloca + 1) = "0": IF luggage$ <> "d" THEN dead: EXIT SUB
      CASE "g": location$(handloca + 1) = "0": IF luggage$ <> "f" THEN dead: EXIT SUB
      CASE "i": location$(handloca + 1) = "0": IF luggage$ <> "h" THEN dead: EXIT SUB
      CASE "j": location$(handloca + 1) = "0": IF luggage$ <> "k" THEN dead: EXIT SUB
       move handloca: DRAW "bh19p0,15bf19"
       DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
       win  ' YOU WIN!!!!
       EXIT SUB
     END SELECT
     move handloca: DRAW "bh19p0,15bf19"
     DRAW "a3bd19bl5p3,15c1u15c8h5u5e5d5r10u5f5d5g5l10bup8,8bdc1r10d15l10bep1,1a0"'hand 4
     luggage$ = ""
   END SELECT
END SELECT
NEXT
dead: EXIT SUB
END SUB

SUB waitawhile (howlong)      ' wait <howlong> seconds
thetime = TIMER
DO
LOOP UNTIL TIMER >= thetime + howlong
END SUB

SUB win
LOCATE 1, 1: PRINT "You win!!!"
IF level + 1 <> 16 THEN
 LOCATE 2, 1: PRINT "The password for level"; level + 1; "is: ";
  SELECT CASE level
   CASE 1: PRINT FIX(ATN(TAN(PI / 2.004312)) * 9954205)
   CASE 2: PRINT FIX(ATN(COS(PI / 5.643)) * 76120967)
   CASE 3: PRINT FIX(ATN(SIN(PI / 38.7743)) * 1116528679)
   CASE 4: PRINT FIX(ATN(ATN(PI / 42.8664)) * 1105218562)
   CASE 5: PRINT FIX(TAN(PI / 39.954) * 999421075)
   CASE 6: PRINT FIX(ATN(PI / 45.87) * 894321765)
   CASE 7: PRINT FIX(COS(PI / 40) * 34569247)
   CASE 8: PRINT FIX(SIN(COS(PI / 40)) * 85431858)
   CASE 9: PRINT FIX(COS(SIN(PI / 40)) * 63628747)
   CASE 10: PRINT FIX(COS(TAN(PI / 35.9855)) * 63628747)
   CASE 11: PRINT FIX(TAN(COS(PI / 5.643)) * 76120967)
   CASE 12: PRINT FIX(COS(COS(PI / 5.643)) * 76120967)
   CASE 13: PRINT FIX(SIN(SIN(PI / 5.643)) * 76120967)
   CASE 14: PRINT FIX(TAN(TAN(PI / 5.643)) * 76120967)
  END SELECT
END IF

DO: userinput$ = INKEY$: LOOP UNTIL userinput$ <> ""
level = level + 1
try = 1
END SUB

