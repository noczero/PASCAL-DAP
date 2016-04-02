'/=========================================================\`
' Minesweeper for DOS                (C) David Joffe (1993) `
' { QuickBASIC 4.5 : "QB /L" }              dj1@pixie.co.za `
'                 http://www.geocities.com/SoHo/Lofts/2018/ `
'                                                           `
'  I wrote this program back when I was in high school.     `
'  At that stage I had been programming less than a year,   `
'  and the inexperience shows here. That is to say, the     `
'  program is an uncommented mess of spaghetti code :-).    `
'  Still, I thought some people might find this useful,     `
'  fun or inspiring (I hope :)                              `
'                                                           '
'  I have quite long since moved on to more advanced and    `
'  professional programming, but I think I had the most     `
'  programming fun during my BASIC programming days :-).    `
'                                    - David, (March 1997)  `
'-----------------------------------------------------------'
'  Note: [April 1997] I'm adding some comments :)           '
'-----------------------------------------------------------'
'  Another note: [Later in April 1997]                      '
'  I've modified the program so that it can run under QB4.5.'
'  Now it won't work on PDS 7.1! Oh well. The PDS version   '
'  will be available at my webpage.                         '
'-----------------------------------------------------------'
'  Oh yes; my best time is 8 seconds :)                     '
'  For simplicity's sake I won't distribute the high score  '
'  file. The program will create a default one.             '
'\=========================================================/`


'=== Set default data type to integer for fastest processing
DEFINT A-Z

'=== Functions
'=== Draw a 3D-looking rectangle on the screen, I think
DECLARE SUB BoxDraw (x1, y1, x2, y2, status, height)

'=== Turn mouse cursor on
DECLARE SUB mon ()

'=== Turn mouse cursor off
DECLARE SUB moff ()

'=== First-time-round comments :)
'93/04/18            Mine-sweeper!

'$INCLUDE: 'QB.BI'

'=== Initialize the random number generator with the value of TIMER
RANDOMIZE TIMER

'=== Allocate arrays
DIM SHARED m AS RegTypeX
DIM grid(9, 9), status(9, 9)
DIM pics(1 TO 600), Bugle(1 TO 130), digits(1 TO 1000), sun(1 TO 800)
DIM Quit(1 TO 130), About(1 TO 130), temp(1 TO 6000), YesNo(1 TO 130)
DIM ok(1 TO 40), numbers(1 TO 1200), bombs(700), fillx(100), filly(100)
DIM ClearX(8), ClearY(8), nxt(1 TO 40), prev(1 TO 40)

'=== Determine if mouse driver is present
CALL INTERRUPTX(&H33, m, m)
IF NOT m.ax THEN
	PRINT "No Microsoft Compatible Mouse Driver detected."
	END
END IF

'=== Initialize screen (320x200x16)
'    The ON ERROR handler will be used if the person's hardware setup
'    is not capable of this mode
ON ERROR GOTO NoEGA
SCREEN 7: CLS
ON ERROR GOTO 0

'=== Load high-score list
'    Creates default one if one not found
'IF DIR$("mines.his") = "" THEN GOSUB MakeNewFile
ON ERROR GOTO HighScoreFileNotFound
OPEN "mines.his" FOR INPUT AS #1
CLOSE
ON ERROR GOTO 0
OPEN "r", #1, "mines.his", 16
	FIELD #1, 16 AS score$
	GET #1, 1
	Num$ = RTRIM$(LTRIM$(STR$(CVI(RIGHT$(score$, 2)))))
	sname$ = LEFT$(score$, 14): score$ = SPACE$(3 - (LEN(Num$))) + Num$
	score = VAL(score$)
CLOSE

GOTO PastNoFileErrorHandling

HighScoreFileNotFound:
  CLOSE
  GOSUB MakeNewFile
RESUME NEXT

PastNoFileErrorHandling:

'=== Read graphics PUT image data
FOR i = 1 TO 106: READ Bugle(i): NEXT i
FOR i = 1 TO 107: READ About(i): NEXT i
FOR i = 1 TO 121: READ Quit(i): NEXT i
FOR i = 1 TO 105: READ YesNo(i): NEXT i
FOR i = 1 TO 700: READ digits(i): NEXT i
FOR i = 1 TO 594: READ pics(i): NEXT i
FOR i = 1 TO 29: READ ok(i): NEXT i
FOR i = 1 TO 989: READ numbers(i): NEXT i
FOR i = 1 TO 733: READ sun(i): NEXT i
FOR i = 1 TO 8: READ ClearX(i), ClearY(i): NEXT i
FOR i = 1 TO 21: READ nxt(i): NEXT i
FOR i = 1 TO 21: READ prev(i): NEXT i

'=== Draw the screen
LINE (0, 0)-(319, 199), 7, BF
BoxDraw 0, 0, 319, 199, 1, 3
BoxDraw 13, 12, 306, 27, 0, 3
LINE (16, 15)-(303, 15), 0
LINE (16, 24)-(303, 24), 0
BoxDraw 13, 41, 146, 174, 0, 3
BoxDraw 159, 41, 306, 78, 0, 3
BoxDraw 159, 87, 306, 174, 0, 3
BoxDraw 167, 93, 298, 142, 1, 3
LINE (182, 102)-(281, 113), 0, BF
BoxDraw 182, 102, 281, 113, 0, 1
COLOR 10: LOCATE 14, 24: PRINT "Best Time:"
BoxDraw 172, 117, 291, 130, 1, 2
BoxDraw 212, 125, 243, 138, 1, 2
LINE (174, 119)-(289, 128), 0, BF
LINE (214, 127)-(241, 136), 0, BF
PSET (212, 129), 8
COLOR 12: LOCATE 16, 23: PRINT sname$
COLOR 9:  LOCATE 17, 28: PRINT score$
PUT (267, 151), Bugle, PSET
PUT (171, 151), Quit, PSET
PUT (219, 151), About, PSET
BoxDraw 263, 147, 298, 169, 1, 3
BoxDraw 215, 147, 250, 169, 1, 3
BoxDraw 167, 147, 202, 169, 1, 3
BoxDraw 220, 47, 245, 72, 1, 3
LINE (174, 50)-(207, 69), 0, BF
BoxDraw 174, 50, 207, 69, 0, 1
LINE (258, 50)-(291, 69), 0, BF
BoxDraw 258, 50, 291, 69, 0, 1

COLOR 13 ' 13=Purple
LOCATE 3, 3: PRINT "        --- MineSweeper ---         "
PUT (223, 50), sun, PSET

'=== Initialize grid data
GOSUB ClearTheGrid

'=== Turn mouse cursor display on
mon

'********************************************* [BEGIN: MAIN LOOP ] ***
'
Game:
zt$ = TIME$
GameLoop:
	IF move = 2 THEN GOSUB TimeCheck
	GOSUB RegularCheck
	GOSUB MouseCheck
GOTO GameLoop
'*********************************************** [END: MAIN LOOP ] ***


'=== Get mouse button-press and screen position data
MGet:
	m.ax = 3: CALL INTERRUPTX(&H33, m, m)
	x = m.cx: y = m.dx

	'=== The value of "ax" and "ay" are integer values that, if the
	'    mouse is somewhere in the grid, will hold values from 1 up
	'    to 8. I.e., this is the integer index to the grid array
	ax = (x - 29) \ 32 + 1
	ay = (y - 43) \ 16 + 1
	IF x <= 28 THEN ax = 0
	IF y <= 42 THEN ay = 0
RETURN


'=== Routine to perform a delay.
Delay:
'=== This IF condition is here to prevent the unlikely event of the Delay
'    subroutine looping forever if it happens to be called as midnight
'    ticks over; (or something like that)
	IF TIMER > 86398 THEN
LessThan10:
		IF TIMER > 10 THEN GOTO LessThan10
	ELSE
		s! = TIMER + .5
sf:
		f! = TIMER: IF f! < s! THEN GOTO sf
	END IF
RETURN


'=== Wait for the user to let go of all mouse buttons
'    I suppose it should use a WHILE .. WEND
WaitForRelease:
	GOSUB MGet
	IF m.bx <> 0 THEN GOTO WaitForRelease
RETURN

'=== Check various keyboard and button inputs
RegularCheck:
	'=== CHR$(27) is the ESC key
	IF INKEY$ = CHR$(27) THEN GOSUB RoutineForQuit

	GOSUB MGet

	'=== No mouse buttons down
	IF m.bx = 0 THEN RETURN

	'=== Clicked on the sun, for new game
	IF x >= 444 AND x <= 480 AND y >= 49 AND y <= 68 THEN GOTO NewGame

	'=== Check for any of the three major buttons
	IF y >= 150 AND y <= 164 THEN

		'=== Bugle button
		IF x >= 532 AND x <= 584 THEN
			moff
			BoxDraw 263, 147, 298, 169, 0, 3
			mon
			PLAY "O1L3D"
			GOSUB Delay: moff: BoxDraw 263, 147, 298, 169, 1, 3: mon
		END IF

		'=== Quit button
		IF x >= 340 AND x <= 392 THEN GOSUB RoutineForQuit

		'=== Help button
		IF x >= 434 AND x <= 488 THEN GOSUB AboutRoutine

	END IF
RETURN

MouseCheck:

	'=== Get mouse info
	GOSUB MGet

	'=== If you're pressing right mouse button and you're in the grid
	IF ax <= 8 AND ax >= 1 AND ay >= 1 AND ay <= 8 AND m.bx = 2 THEN
		IF status(ax, ay) = 1 THEN RETURN
		IF status(ax, ay) = 0 THEN status(ax, ay) = 2: Num = 1: GOTO Label6
		IF status(ax, ay) = 2 THEN status(ax, ay) = 3: Num = 2: GOTO Label6
		IF status(ax, ay) = 3 THEN status(ax, ay) = 0: Num = 0
Label6:

		'=== Calculate number of bombs unmarked, to show on the LED display
		numbombs = 10
		FOR i = 1 TO 8
			FOR j = 1 TO 8
				IF status(i, j) = 2 THEN numbombs = numbombs - 1
		NEXT j, i
		moff

		numbombs$ = RTRIM$(LTRIM$(STR$(numbombs)))
		IF numbombs < 0 THEN digitnum$ = RIGHT$(numbombs$, LEN(numbombs$) - 1)
		IF numbombs < 0 THEN numbombs$ = "-" + STRING$(2 - (LEN(digitnum$)), "0") + digitnum$ ELSE numbombs$ = STRING$(3 - (LEN(numbombs$)), "0") + numbombs$

		FOR i = 1 TO 3
			'=== If number is negative
			IF MID$(numbombs$, i, 1) = "-" THEN
				NumB = 681
			ELSE
				NumB = VAL(MID$(numbombs$, i, 1)) * 68 + 1
			END IF
			PUT (i * 10 + 167, 52), digits(NumB), PSET
		NEXT i
		IF Num = 0 THEN
			LINE ((ax - 1) * 16 + 16, (ay - 1) * 16 + 44)-((ax - 1) * 16 + 31, (ay - 1) * 16 + 59), 7, BF
			BoxDraw ((ax - 1) * 16 + 16), (ay - 1) * 16 + 44, (ax - 1) * 16 + 31, (ay - 1) * 16 + 59, 1, 2
			mon
			GOSUB WaitForRelease: RETURN
		END IF
		PUT ((ax - 1) * 16 + 16, (ay - 1) * 16 + 44), pics((Num - 1) * 132 + 1), PSET
		mon
		GOSUB WaitForRelease
	END IF

	'=== If you're pressing left mouse button and you're in the grid
	IF ax <= 8 AND ax >= 1 AND ay >= 1 AND ay <= 8 AND m.bx = 1 THEN
		PUT (223, 50), sun(205), PSET
		IF status(ax, ay) = 0 THEN
			moff
			LINE ((ax - 1) * 16 + 16, (ay - 1) * 16 + 44)-((ax - 1) * 16 + 31, (ay - 1) * 16 + 59), 7, BF
			mon
		END IF
WaitReleaseLoop:
			tax = ax: tay = ay
			GOSUB MGet
			IF ax <> tax OR ay <> tay THEN GOSUB RestoreOld: GOSUB DrawNew
			IF move = 2 THEN GOSUB TimeCheck
			IF m.bx = 0 THEN GOTO Reveal
		GOTO WaitReleaseLoop
Reveal:
		moff
		PUT (223, 50), sun, PSET
		mon
		IF ax > 8 OR ax < 1 OR ay > 8 OR ay < 1 THEN GOSUB RestoreOld: RETURN
		IF status(ax, ay) <> 0 THEN GOSUB RestoreOld: RETURN
		IF grid(ax, ay) = -1 THEN
			IF move = 1 THEN
Lebel:
				num1 = INT(RND * 8) + 1: num2 = INT(RND * 8) + 1
				IF grid(num1, num2) = -1 THEN GOTO Lebel
				grid(num1, num2) = -1: grid(ax, ay) = 0
				GOSUB InitNums
				GOTO Labal
			END IF
			moff
			PUT ((ax - 1) * 16 + 16, (ay - 1) * 16 + 44), pics(3 * 132 + 1), PSET
			FOR i = 1 TO 8
				FOR j = 1 TO 8
					IF i = ax AND j = ay THEN GOTO LabelG
					IF grid(i, j) <> -1 AND status(i, j) = 2 THEN PUT ((i - 1) * 16 + 16, (j - 1) * 16 + 44), pics(4 * 132 + 1), PSET
					IF grid(i, j) = -1 THEN PUT ((i - 1) * 16 + 16, (j - 1) * 16 + 44), pics(2 * 132 + 1), PSET
LabelG:
			NEXT j, i
			PUT (223, 50), sun(613), PSET
			mon
			PLAY "o1l64dcco0bgfcgdfcdcedcecdcfcgecdccdc"
			GOTO DeadLoop
		END IF
Labal:
		moff
		LINE ((ax - 1) * 16 + 16, (ay - 1) * 16 + 44)-((ax - 1) * 16 + 31, (ay - 1) * 16 + 59), 7, BF
		IF grid(ax, ay) <> 0 THEN PUT ((ax - 1) * 16 + 16, (ay - 1) * 16 + 44), numbers((grid(ax, ay) - 1) * 132 + 1), PSET
		LINE ((ax - 1) * 16 + 31, (ay - 1) * 16 + 44)-((ax - 1) * 16 + 31, (ay - 1) * 16 + 59), 8
		LINE ((ax - 1) * 16 + 16, (ay - 1) * 16 + 59)-((ax - 1) * 16 + 31, (ay - 1) * 16 + 59), 8
		IF grid(ax, ay) = 0 THEN GOSUB FillArea
		mon
		status(ax, ay) = 1: move = 2
		count = 0
		FOR i = 1 TO 8
			FOR j = 1 TO 8
				IF grid(i, j) <> -1 AND status(i, j) = 1 THEN count = count + 1
		NEXT j, i
		IF count = 54 THEN GOTO YouHaveWon
	END IF
RETURN

RestoreOld:
	IF tax > 8 OR tax < 1 OR tay < 1 OR tay > 8 THEN RETURN
	IF status(tax, tay) <> 0 THEN RETURN
	moff
	BoxDraw ((tax - 1) * 16 + 16), (tay - 1) * 16 + 44, (tax - 1) * 16 + 31, (tay - 1) * 16 + 59, 1, 2
	mon
RETURN

DrawNew:
	IF ax > 8 OR ax < 1 OR ay < 1 OR ay > 8 THEN RETURN
	IF status(ax, ay) <> 0 THEN RETURN
	moff
	LINE ((ax - 1) * 16 + 16, (ay - 1) * 16 + 44)-((ax - 1) * 16 + 31, (ay - 1) * 16 + 59), 7, BF
	mon
RETURN

RoutineForQuit:

	'=== Show button press action
	moff
	BoxDraw 167, 147, 202, 169, 0, 3
	mon
	GOSUB Delay
	moff
	BoxDraw 167, 147, 202, 169, 1, 3

	'=== Draw "Are you sure" dialog
	GET (111, 74)-(201, 111), temp
	LINE (111, 74)-(201, 111), 7, BF
	BoxDraw 111, 74, 201, 111, 1, 3
	COLOR 12: LOCATE 11, 17: PRINT " Quit? "
	BoxDraw 127, 79, 184, 88, 0, 1
	BoxDraw 128, 94, 148, 104, 1, 1
	BoxDraw 163, 94, 183, 104, 1, 1
	PUT (130, 96), YesNo, PSET
	PUT (165, 96), YesNo(68), PSET
	mon
QuitLoop:
	a$ = UCASE$(INKEY$)
	GOSUB MGet
	IF move = 2 THEN GOSUB TimeCheck
	IF (x >= 256 AND x <= 290 AND y >= 94 AND y <= 102 AND m.bx <> 0) OR (a$ = "Y") THEN
		moff
		BoxDraw 128, 94, 148, 104, 0, 1: mon: GOSUB Delay: moff
		SCREEN 0: WIDTH 80, 25: CLS : COLOR 15, 1
		PRINT "€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€"
		PRINT "€                       "; : COLOR 14, 0: PRINT "€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€"; : COLOR 15, 1: PRINT "                    €"
		PRINT "€        "; : COLOR 14, 0: PRINT "€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€"; : COLOR 13, 0: PRINT " €≤±∞ Thank you for playing ∞±≤€ "; : COLOR 14, 0: PRINT "€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€"; : COLOR 15, 1: PRINT "        €"
		PRINT "€        "; : COLOR 14, 0: PRINT "€              €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€           €"; : COLOR 15, 1: PRINT "        €"
		PRINT "€        "; : COLOR 14, 0: PRINT "€"; : COLOR 12, 0: PRINT "      “ƒ“ƒ“ ˛          ÷ƒƒƒ∑                                "; : COLOR 14, 0: PRINT "€"; : COLOR 15, 1: PRINT "        €"
		PRINT "€        "; : COLOR 14, 0: PRINT "€"; : COLOR 12, 0: PRINT "  ‹‹  ∫ – ∫ ∑ “ƒ“ ÷ƒ∑  ”ƒƒƒ∑ “   “ ÷ƒ∑ ÷ƒ∑ “ƒ∑ ÷ƒ∑ “ƒ∑  ‹‹  "; : COLOR 14, 0: PRINT "€"; : COLOR 15, 1: PRINT "        €"
		PRINT "€        "; : COLOR 14, 0: PRINT "€"; : COLOR 12, 0: PRINT "  ﬂﬂ  –   – – – – ”ƒ   ”ƒƒƒΩ ”ƒ–ƒΩ ”ƒ  ”ƒ  «ƒΩ ”ƒ  –    ﬂﬂ  "; : COLOR 14, 0: PRINT "€"; : COLOR 15, 1: PRINT "        €"
		PRINT "€        "; : COLOR 14, 0: PRINT "€"; : COLOR 12, 0: PRINT "                            for DOS        –                "; : COLOR 14, 0: PRINT "€"; : COLOR 15, 1: PRINT "        €"
		PRINT "€        "; : COLOR 14, 0: PRINT "€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€"; : COLOR 15, 1: PRINT "        €"
		PRINT "€                                                                              €"
		PRINT "€    This program is Public Domain Software, so feel free to distribute it.    €"
		PRINT "€  Please send me any comments or suggestions you may have. If you find any    €"
		PRINT "€  errors then please tell me about them. If you found that you really         €"
		PRINT "€  enjoyed this game then feel free to send me a donation.                     €"
		PRINT "€                                                                              €"
		PRINT "€     "; : COLOR 1, 0: PRINT "≤≤±±∞∞"; : COLOR 14, 0: PRINT "    David Joffe,        "; : COLOR 1: PRINT "∞∞±±≤≤"; : COLOR 15, 1: PRINT "            e-mail:  dj1@pixie.co.za €"
		PRINT "€     "; : COLOR 1, 0: PRINT "≤≤±±∞∞"; : COLOR 14, 0: PRINT "    DJ Software,        "; : COLOR 1: PRINT "∞∞±±≤≤"; : COLOR 15, 1: PRINT "  www.geocities.com/SoHo/Lofts/2018/ €"
		PRINT "€     "; : COLOR 1, 0: PRINT "≤≤±±∞∞"; : COLOR 14, 0: PRINT "    My address was in   "; : COLOR 1: PRINT "∞∞±±≤≤"; : COLOR 15, 1: PRINT "            ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹     €"
		PRINT "€     "; : COLOR 1, 0: PRINT "≤≤±±∞∞"; : COLOR 14, 0: PRINT "    this box, please    "; : COLOR 1: PRINT "∞∞±±≤≤"; : COLOR 15, 1: PRINT "            €"; : COLOR 13, 0: PRINT "ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ"; : COLOR 15, 1: PRINT "€     €"
		PRINT "€     "; : COLOR 1, 0: PRINT "≤≤±±∞∞"; : COLOR 14, 0: PRINT "    e-mail me for       "; : COLOR 1: PRINT "∞∞±±≤≤"; : COLOR 15, 1: PRINT "            €"; : COLOR 12, 0: PRINT "     Goodbye!     "; : COLOR 15, 1: PRINT "€     €"
		PRINT "€     "; : COLOR 1, 0: PRINT "≤≤±±∞∞"; : COLOR 14, 0: PRINT "    snail-mail contact  "; : COLOR 1: PRINT "∞∞±±≤≤"; : COLOR 15, 1: PRINT "            €"; : COLOR 13, 0: PRINT "‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹"; : COLOR 15, 1: PRINT "€     €"
		PRINT "€     "; : COLOR 1, 0: PRINT "≤≤±±∞∞"; : COLOR 14, 0: PRINT "    info.               "; : COLOR 1: PRINT "∞∞±±≤≤"; : COLOR 15, 1: PRINT "            ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ     €"
		PRINT "€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€"
		END
	END IF
	IF (x >= 326 AND x <= 362 AND y >= 94 AND y <= 102 AND m.bx <> 0) OR (a$ = "N") THEN
		moff
		BoxDraw 163, 94, 183, 104, 0, 1: mon
		GOSUB Delay: moff
		PUT (111, 74), temp, PSET: mon
		RETURN
	END IF
GOTO QuitLoop

'=== Routine for handling the Help Screens
AboutRoutine:

	'=== Show "?" button press action (I think)
	moff
	BoxDraw 215, 147, 250, 169, 0, 3
	mon
	GOSUB Delay
	moff
	BoxDraw 215, 147, 250, 169, 1, 3

	'=== Store what's under this area of screen in the array "temp"
	GET (159, 41)-(306, 174), temp

	LINE (159, 41)-(306, 174), 7, BF
	BoxDraw 164, 41, 306, 174, 1, 3
	LINE (170, 47)-(300, 168), 0, BF
	BoxDraw 170, 47, 300, 168, 0, 1
	COLOR 12
	LOCATE 7, 23: PRINT "---------------"
	GOSUB Page1
	COLOR 12
	LOCATE 21, 23: PRINT "---------------"

	LINE (197, 140)-(273, 158), 7, BF
	BoxDraw 197, 140, 273, 158, 1, 2

	BoxDraw 207, 145, 221, 153, 1, 1
	PUT (210, 147), ok, PSET

	BoxDraw 252, 145, 264, 153, 1, 1
	PUT (254, 147), nxt, PSET

	LINE (234, 145)-(246, 153), 8, B
	PUT (236, 147), prev, PSET
	mon
	Page = 1
Label:
	a$ = INKEY$
	IF a$ <> "" THEN GOTO QuitRoute
	abouttrue = 1
	IF move = 2 THEN GOSUB TimeCheck
	abouttrue = 0
	GOSUB MGet
	IF m.bx = 0 THEN GOTO Label
	IF x >= 414 AND y >= 145 AND x <= 438 AND y <= 151 THEN
QuitRoute:
		moff
		BoxDraw 207, 145, 221, 153, 0, 1
		mon
		GOSUB Delay
		moff
		PUT (159, 41), temp, PSET
		mon
		RETURN
	END IF

	'=== This is if the user goes one screen forward
	IF x >= 504 AND y >= 145 AND x <= 524 AND y <= 151 AND Page <> 13 THEN
		moff
		BoxDraw 252, 145, 264, 153, 0, 1
		mon
		GOSUB Delay
		Page = Page + 1
		IF Page > 13 THEN Page = 13
		moff
		COLOR 15

		'=== Show relevant screen
		ON Page GOSUB Page1, Page2, Page3, Page4, Page5, Page6, Page7, Page8, Page9, Page10, Page11, Page12, Page13

		IF Page <> 13 THEN BoxDraw 252, 145, 264, 153, 1, 1 ELSE LINE (252, 145)-(264, 153), 8, B
		IF Page = 2 THEN BoxDraw 234, 145, 246, 153, 1, 1
		mon
	END IF
	'=== This is if the user goes one screen backward. This could have
	'    been merged relatively effectively with the IF..ENDIF block just
	'    above, but I guess this is my beginner-ness showing through
	IF x >= 468 AND y >= 145 AND x <= 488 AND y <= 151 AND Page <> 1 THEN
		moff
		BoxDraw 234, 145, 246, 153, 0, 1
		mon
		GOSUB Delay
		Page = Page - 1

		'=== More beginnerness showing through: Note the condition for
		'    this block's IF. It already checks "Page <> 1",
		'    so the following condition should never become true
		IF Page < 1 THEN Page = 1

		moff
		COLOR 15

		'=== Show relevant screen
		ON Page GOSUB Page1, Page2, Page3, Page4, Page5, Page6, Page7, Page8, Page9, Page10, Page11, Page12, Page13

		IF Page <> 1 THEN BoxDraw 234, 145, 246, 153, 1, 1 ELSE LINE (234, 145)-(246, 153), 8, B
		IF Page = 12 THEN BoxDraw 252, 145, 264, 153, 1, 1
		mon
	END IF
GOTO Label

'=== The Help Screens
Page1:
	COLOR 11
	LOCATE 8, 23: PRINT "€€€€€€€€€€€€€€€": COLOR 15
	LOCATE , 23: PRINT "ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ": COLOR 9
	LOCATE , 23: PRINT "⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø"
	LOCATE , 23: PRINT "≥ "; : COLOR 10: PRINT "MineSweeper"; : COLOR 9: PRINT " ≥": COLOR 9
	LOCATE , 23: PRINT "¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ": COLOR 14
	LOCATE , 23: PRINT " *  for DOS  * ": COLOR 15
	LOCATE , 23: PRINT "‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹": COLOR 11
	LOCATE , 23: PRINT "€€€€€€€€€€€€€€€": COLOR 9
	LOCATE , 23: PRINT "€€€€€€€€€€€€€€€": COLOR 1
	LOCATE , 23: PRINT "€€€€€€€€€€€€€€€"
	RETURN
Page2:
	COLOR 14
	LOCATE 8, 23: PRINT "ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ": COLOR 11
	LOCATE , 23: PRINT "Windows version": COLOR 15
	LOCATE , 23: PRINT " Robert Donner "
	LOCATE , 23: PRINT "&  Curt Johnson"
	LOCATE , 23: PRINT "               ": COLOR 11
	LOCATE , 23: PRINT "DOS version by:": COLOR 15
	LOCATE , 23: PRINT "  David Joffe  ": COLOR 14
	LOCATE , 23: PRINT "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ": COLOR 13
	LOCATE , 23: PRINT " DJ - Software ": COLOR 14
	LOCATE , 23: PRINT "‹‹‹‹‹‹‹‹ "; : COLOR 13: PRINT "1993 "; : COLOR 14: PRINT "‹"
RETURN
Page3:
	GOSUB Print8
	COLOR 11
	LOCATE , 23: PRINT "   In the grid "
	LOCATE , 23: PRINT "to your left   "
	LOCATE , 23: PRINT "are hidden ten "
	LOCATE , 23: PRINT "bombs.         ": COLOR 10
	LOCATE , 23: PRINT "   The aim is  "
	LOCATE , 23: PRINT "to find out the"
	LOCATE , 23: PRINT "location of all"
	LOCATE , 23: PRINT "ten bombs.     "
	GOSUB Prnt
RETURN
Page4:
	GOSUB Print8
	COLOR 11
	LOCATE , 23: PRINT "   To reveal   "
	LOCATE , 23: PRINT "what is hidden "
	LOCATE , 23: PRINT "under a block, "
	LOCATE , 23: PRINT "click on it    "
	LOCATE , 23: PRINT "with the left  "
	LOCATE , 23: PRINT "mouse button.  ": COLOR 10
	LOCATE , 23: PRINT "   If it is a  "
	LOCATE , 23: PRINT "bomb then    -"
	GOSUB Prnt
RETURN
Page5:
	GOSUB Print8
	COLOR 10
	LOCATE , 23: PRINT "you are dead,  "
	LOCATE , 23: PRINT "& the locations"
	LOCATE , 23: PRINT "of all ten of  "
	LOCATE , 23: PRINT "the bombs will "
	LOCATE , 23: PRINT "be revealed.   ": COLOR 11
	LOCATE , 23: PRINT "               "
	LOCATE , 23: PRINT "   If it is not"
	LOCATE , 23: PRINT "a bomb, then -"
	GOSUB Prnt
RETURN
Page6:
	GOSUB Print8
	COLOR 11
	LOCATE , 23: PRINT "a number will  "
	LOCATE , 23: PRINT "appear which is"
	LOCATE , 23: PRINT "the number of  "
	LOCATE , 23: PRINT "bombs in the   "
	LOCATE , 23: PRINT "surrounding    "
	LOCATE , 23: PRINT "eight squares. ": COLOR 10
	LOCATE , 23: PRINT "   If there are"
	LOCATE , 23: PRINT "no bombs in  -"
	GOSUB Prnt
RETURN
Page7:
	GOSUB Print8
	COLOR 10
	LOCATE , 23: PRINT "the surrounding"
	LOCATE , 23: PRINT "eight squares  "
	LOCATE , 23: PRINT "then a blank   "
	LOCATE , 23: PRINT "will appear and"
	LOCATE , 23: PRINT "any surrounding"
	LOCATE , 23: PRINT "blanks will be "
	LOCATE , 23: PRINT "cleared auto-  "
	LOCATE , 23: PRINT "matically.     "
	GOSUB Prnt
RETURN
Page8:
	GOSUB Print8
	COLOR 11
	LOCATE , 23: PRINT "   If you would"
	LOCATE , 23: PRINT "like to mark a "
	LOCATE , 23: PRINT "block that you "
	LOCATE , 23: PRINT "know has a bomb"
	LOCATE , 23: PRINT "underneath it, "
	LOCATE , 23: PRINT "click on it    "
	LOCATE , 23: PRINT "with the right "
	LOCATE , 23: PRINT "mouse button.  "
	GOSUB Prnt
RETURN
Page9:
	GOSUB Print8
	COLOR 10
	LOCATE , 23: PRINT "  The digital  "
	LOCATE , 23: PRINT "display on the "
	LOCATE , 23: PRINT "left, which    "
	LOCATE , 23: PRINT "tells you how  "
	LOCATE , 23: PRINT "many bombs you "
	LOCATE , 23: PRINT "have left, will"
	LOCATE , 23: PRINT "then decrease  "
	LOCATE , 23: PRINT "by one.        "
	GOSUB Prnt
RETURN
Page10:
	GOSUB Print8
	COLOR 11
	LOCATE , 23: PRINT "   If you are  "
	LOCATE , 23: PRINT "uncertain about"
	LOCATE , 23: PRINT "whether or not "
	LOCATE , 23: PRINT "a certain block"
	LOCATE , 23: PRINT "has a bomb then"
	LOCATE , 23: PRINT "click the right"
	LOCATE , 23: PRINT "mouse button on"
	LOCATE , 23: PRINT "it twice to  -"
	GOSUB Prnt
RETURN
Page11:
	GOSUB Print8
	COLOR 11
	LOCATE , 23: PRINT "mark it with a "
	LOCATE , 23: PRINT "question mark. "
	LOCATE , 23: PRINT "               ": COLOR 10
	LOCATE , 23: PRINT "   To make a   "
	LOCATE , 23: PRINT "beeping noise, "
	LOCATE , 23: PRINT "click on the   "
	LOCATE , 23: PRINT "bugle icon.    "
	LOCATE , 23: PRINT "               "
	GOSUB Prnt
RETURN
Page12:
	GOSUB Print8
	COLOR 11
	LOCATE , 23: PRINT "   To start a  "
	LOCATE , 23: PRINT "new game, click"
	LOCATE , 23: PRINT "on the yellow  "
	LOCATE , 23: PRINT "face.          ": COLOR 10
	LOCATE , 23: PRINT "   Your game is"
	LOCATE , 23: PRINT "timed and the  "
	LOCATE , 23: PRINT "fastest time is"
	LOCATE , 23: PRINT "stored.        "
	GOSUB Prnt
RETURN
Page13:
	GOSUB Print8
	COLOR 15
	LOCATE , 23: PRINT "  This program "
	LOCATE , 23: PRINT "was written in "
	LOCATE , 23: PRINT "Microsoft      "
	LOCATE , 23: PRINT "QuickBASIC 7.1 "
	LOCATE , 23: PRINT "               ": COLOR 14
	LOCATE , 23: PRINT "  Enjoy!       "
	LOCATE , 23: PRINT "               ": COLOR 11
	LOCATE , 23: PRINT "  - David Joffe"
	GOSUB Prnt
RETURN

'=== For the above Help Screens, this draws the pretty colorful stripes
'    *above* the text. Not sure why I called it Print8
Print8:
	LOCATE 8, 23
	COLOR 12: PRINT "Õ"; : COLOR 4: PRINT "Õ"; : COLOR 12: PRINT "Õ";
	COLOR 14: PRINT "Õ"; : COLOR 12: PRINT "Õ"; : COLOR 4: PRINT "Õ";
	COLOR 12: PRINT "Õ"; : COLOR 14: PRINT "Õ"; : COLOR 12: PRINT "Õ";
	COLOR 4: PRINT "Õ"; : COLOR 12: PRINT "Õ"; : COLOR 14: PRINT "Õ";
	COLOR 12: PRINT "Õ"; : COLOR 4: PRINT "Õ"; : COLOR 12: PRINT "Õ"
RETURN

'=== For the above Help Screens, this draws the pretty colorful stripes
'    *below* the text. Not sure why I called it Prnt
Prnt:
	LOCATE , 23
	COLOR 12: PRINT "Õ"; : COLOR 4: PRINT "Õ"; : COLOR 12: PRINT "Õ";
	COLOR 14: PRINT "Õ"; : COLOR 12: PRINT "Õ"; : COLOR 4: PRINT "Õ";
	COLOR 12: PRINT "Õ"; : COLOR 14: PRINT "Õ"; : COLOR 12: PRINT "Õ";
	COLOR 4: PRINT "Õ"; : COLOR 12: PRINT "Õ"; : COLOR 14: PRINT "Õ";
	COLOR 12: PRINT "Õ"; : COLOR 4: PRINT "Õ"; : COLOR 12: PRINT "Õ"
RETURN

'=== Create a new high-score list with name "Anonymous" and score 999
MakeNewFile:
	OPEN "r", #1, "mines.his", 16
		FIELD #1, 16 AS score$
		LSET score$ = "Anonymous     Á" + CHR$(3)
		PUT #1, 1
	CLOSE
RETURN

ClearTheGrid:
	'=== Initialize variables for game
	countfill = 0
	speed = -1
	bombs = 10
	move = 1
	ERASE grid, status

	moff
	PUT (223, 50), sun, PSET
	PUT (177, 52), digits, PSET: PUT (187, 52), digits(69), PSET
	PUT (197, 52), digits, PSET: PUT (261, 52), digits, PSET
	PUT (271, 52), digits, PSET: PUT (281, 52), digits, PSET

	'=== Random the bomb positions
	FOR i = 1 TO 10
Label2:
		num1 = INT(RND * 8) + 1
		num2 = INT(RND * 8) + 1
		'=== If this position already a bomb, random another position
		IF grid(num1, num2) = -1 THEN GOTO Label2
		grid(num1, num2) = -1
	NEXT i

	'=== Fill in the bomb-count-of-surrounding-squares data
	GOSUB InitNums

	LINE (16, 44)-(143, 171), 7, BF

	'=== Draw the un-touched grid
	FOR i = 1 TO 8
		FOR j = 1 TO 8
			BoxDraw ((i - 1) * 16 + 16), (j - 1) * 16 + 44, (i - 1) * 16 + 31, (j - 1) * 16 + 59, 1, 2
	NEXT j, i

	mon
RETURN

'=== Handler for if you don't have appropriate hardware
NoEGA:
	SCREEN 0: WIDTH 80, 25: CLS
	PRINT "Sorry - you need an EGA or VGA adapter to play:-"
	PRINT "   DJ - MineSweeper!"
END

'=== Using the grid with just knowledge of where the bombs are,
'    generate the numbers that show how many bombs surround a square
InitNums:
	FOR i = 1 TO 8
		FOR j = 1 TO 8
			Num = 0
			IF grid(i, j) = -1 THEN GOTO Label3
			FOR k = -1 TO 1
				FOR l = -1 TO 1
					IF k = 0 AND l = 0 THEN GOTO Label4
					IF grid(i + k, j + l) = -1 THEN Num = Num + 1
Label4:
				NEXT l, k
			grid(i, j) = Num: Num = 0
Label3:
	NEXT j, i
RETURN

'=== You're dead!
DeadLoop:
	move = 1
	GOSUB RegularCheck
GOTO DeadLoop

TimeCheck:
	t$ = TIME$
	IF t$ = zt$ THEN RETURN

	'=== Stop updating if person takes really long
	IF speed = 999 THEN RETURN

	zt$ = t$
	speed = speed + 1: speed$ = RTRIM$(LTRIM$(STR$(speed)))
	speed$ = STRING$(3 - (LEN(speed$)), "0") + speed$

	' Draw LED display showing current time taken
	IF abouttrue <> 1 THEN
		moff
		FOR i = 1 TO 3
			PUT (i * 10 + 251, 52), digits(VAL(MID$(speed$, i, 1)) * 68 + 1), PSET
		NEXT i
		mon
	END IF
RETURN

NewGame:
	'=== Draw button-press action
	moff
	BoxDraw 220, 47, 245, 72, 0, 3
	mon

	GOSUB Delay

	moff
	BoxDraw 220, 47, 245, 72, 1, 3
	mon

	'=== Initialize the grid data
	GOSUB ClearTheGrid
GOTO Game

'=== Routine for, er, well, if you win.
YouHaveWon:
	moff

	' Draw smiley face sun
	PUT (223, 50), sun(409), PSET
	PUT (177, 52), digits, PSET
	PUT (187, 52), digits, PSET
	PUT (197, 52), digits, PSET

	' Show all bombs
	FOR i = 1 TO 8
		FOR j = 1 TO 8
			IF grid(i, j) = -1 THEN
				PUT ((i - 1) * 16 + 16, (j - 1) * 16 + 44), pics, PSET
			END IF
	NEXT j, i

	COLOR 12: LOCATE 16, 23: PRINT sname$
	COLOR 9:  LOCATE 17, 28: PRINT score$

	IF speed < 0 THEN speed = 0
	IF speed > score THEN mon: GOTO DeadLoop

	'=== If you got a high-score, prompt the user to enter his name:

	Num$ = RTRIM$(LTRIM$(STR$(speed)))
	score$ = SPACE$(3 - (LEN(Num$))) + Num$
	LOCATE 17, 28: PRINT score$
	COLOR 14: LOCATE 16, 23: PRINT "_             "
	sname$ = ""
	mon
	'=== Simple routine to get user input:
GetNameLoop:
	a$ = INKEY$
	IF LEN(a$) = 2 THEN GOTO GetNameLoop
	IF a$ = "" THEN GOTO GetNameLoop
	IF a$ = CHR$(8) THEN IF sname$ = "" THEN GOTO GetNameLoop ELSE sname$ = LEFT$(sname$, LEN(sname$) - 1): moff: LOCATE 16, 23: PRINT sname$ + "_ ": mon: GOTO GetNameLoop
	IF a$ = CHR$(13) THEN GOTO WriteName
	IF LEN(sname$) = 13 THEN GOTO GetNameLoop
	sname$ = sname$ + a$: moff: LOCATE 16, 23: PRINT sname$ + "_": mon
GOTO GetNameLoop

'=== Save high-score file with sname$ and the value in speed
WriteName:
	OPEN "r", #1, "mines.his", 16
		FIELD #1, 16 AS score$
		LSET score$ = sname$ + STRING$(14 - LEN(sname$), 32) + MKI$(speed)
		PUT #1, 1
	CLOSE

	' Update the high-score on the screen
	moff
	COLOR 12: LOCATE 16, 23: PRINT sname$ + " "
	mon
GOTO DeadLoop

FillArea:
	fcount = 0: ERASE fillx, filly
	fillx(0) = ax: filly(0) = ay
	status(ax, ay) = 1
	moff
	LINE ((ax - 1) * 16 + 16, (ay - 1) * 16 + 44)-((ax - 1) * 16 + 31, (ay - 1) * 16 + 59), 8, B
	LINE ((ax - 1) * 16 + 16, (ay - 1) * 16 + 44)-((ax - 1) * 16 + 30, (ay - 1) * 16 + 58), 7, BF
	z = 0
FillLoop:
	FOR i = 1 TO 8
		fx = fillx(z): fy = filly(z)
		fx = fx + ClearX(i): fy = fy + ClearY(i)
		IF fx < 1 OR fx > 8 OR fy < 1 OR fy > 8 THEN GOTO NextI
		IF grid(fx, fy) <> 0 THEN
			IF status(fx, fy) <> 2 THEN
				PUT ((fx - 1) * 16 + 16, (fy - 1) * 16 + 44), numbers((grid(fx, fy) - 1) * 132 + 1), PSET
				LINE ((fx - 1) * 16 + 31, (fy - 1) * 16 + 44)-((fx - 1) * 16 + 31, (fy - 1) * 16 + 59), 8
				LINE ((fx - 1) * 16 + 16, (fy - 1) * 16 + 59)-((fx - 1) * 16 + 31, (fy - 1) * 16 + 59), 8
				status(fx, fy) = 1
			END IF
			GOTO NextI
		END IF
		FOR j = 1 TO fcount
			IF fx = fillx(j) AND fy = filly(j) THEN GOTO NextI
		NEXT j
		fcount = fcount + 1: fillx(fcount) = fx: filly(fcount) = fy
NextI:
	NEXT i
	z = z + 1
	IF z <= fcount THEN
		IF status(fillx(z), filly(z)) <> 2 THEN
			LINE ((fillx(z) - 1) * 16 + 16, (filly(z) - 1) * 16 + 44)-((fillx(z) - 1) * 16 + 31, (filly(z) - 1) * 16 + 59), 8, B
			LINE ((fillx(z) - 1) * 16 + 16, (filly(z) - 1) * 16 + 44)-((fillx(z) - 1) * 16 + 30, (filly(z) - 1) * 16 + 58), 7, BF
			status(fillx(z), filly(z)) = 1
		END IF
		GOTO FillLoop
	END IF
	mon
RETURN


'=== Image data
'    Created by a simple drawing program I wrote that can output in
'    DATA format for images using PUT

DATA 28,15,,,,,,,,,,,64,,64,,64,,,,96,,96,,96,,,,112
DATA ,112,,112,,,,124,8192,124,8192,124,8192,,,-129,-7937,-129,-7937
DATA -129,-7937,,,-129,-7937,-129,-7937,-129,-7937,,,-129,-7937,-129
DATA -7937,-129,-7937,,,-16260,8204,-16260,8204,-16260,8204,,,-32655
DATA 6,-32655,6,-32655,6,,,97,2,97,2,97,2,,,-32703,6,-32703,6,-32703
DATA 6,,,-256,252,-256,252,-256,252
DATA 28,15,,,,,,,,,-256,240,-256,240,,,-256,240,-255,248,1,
DATA ,,-255,248,-253,252,2,,,,-16381,24,-16381,28,2,16,,,-32765
DATA 24,-16381,28,2,16,,,-32765,24,-16383,60,1,32,,,1,56,768,248,768
DATA 192,,,768,240,3840,240,3072,,,,3840,,3840,,2048,,,,2048
DATA ,,,,,,,,,3840,,3840,,,,3840,,7936,128,4096,,,,7936,,3840
DATA 28,15,,,,,,,,,,,,,-32705,,-32705,,,,,,-16288,,-16288
DATA ,,,,,-16288,,-16288,,,,,,-16288,6,-16288,6,,,,,-16288
DATA 6,-16288,6,,,,,-16288,54,-16288,54,,,,,-16288,-32713,-16288
DATA -32713,,,,,-16288,6,-16288,6,,,,,-9888,182,-9888,182,,,
DATA ,-9888,182,-9888,182,,,,,-9886,24758,-9886,24758,,,,,-9887
DATA 24758,-9887,24758,,,,,-4289,-16333,-4289,-16333,,,,,12288,,12288
DATA 17,7,,,,,,,,17664,239,,17664,239,,17664,8,,17664,8,,32000
DATA 143,,32000,143,,4352,1,,4352,1,,4352,239,,4352,239,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,17,7,,,,,,,
DATA 4352,56,,4352,56,,6400,68,,6400,68,,5376,68,,5376,68,,4864,68
DATA ,4864,68,,4352,56,,4352,56
DATA 8,16,,32382,,15420,,-32383,,-15421,,-15421,,-15421,,-32383
DATA ,,,,,-32383,,-15421,,-15421,,-15421,,-32383,,15420,,32382
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,8,16,,,,257,,771,,771,,771,,771,,257,,,,,,257,,771
DATA ,771,,771,,771,,257,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,8,16,,32382,,15420,,257,,771,,771
DATA ,771,,257,,31868,,15420,,-32640,,-16192,,-16192,,-16192,
DATA -32640,,15420,,32382,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,8,16,,32382,,15420,,257,,771,,771,,771
DATA ,257,,31868,,15420,,257,,771,,771,,771,,257,,15420,,32382
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,8,16,,,,-32383,,-15421,,-15421,,-15421,,-15421,,-32383,
DATA 31868,,15420,,257,,771,,771,,771,,771,,257,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,8,16,,32382
DATA ,15420,,-32640,,-16192,,-16192,,-16192,,-32640,,32382,,15420
DATA ,257,,771,,771,,771,,257,,15420,,32382,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,8,16,,,,-32640
DATA ,-16192,,-16192,,-16192,,-16192,,-32640,,15934,,15420,,-32383
DATA ,-15421,,-15421,,-15421,,-32383,,15420,,32382,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,8,16,,32382
DATA ,15420,,257,,771,,771,,771,,257,,,,,,257,,771,,771,
DATA 771,,257,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,8,16,,32382,,15420,,-32383,,-15421,,-15421
DATA ,-15421,,-32383,,15934,,31868,,-32383,,-15421,,-15421,,-15421
DATA ,-32383,,15420,,32382,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,8,16,,32382,,15420,,-32383,,-15421,
DATA -15421,,-15421,,-32383,,15934,,31868,,257,,771,,771,,771,
DATA 257,,15420,,32382,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,8,16,,,,,,,,,,,,,,,,32382,,15420
DATA 16,16,-1,-1,-1,-1,-257,-257,-257,-1,-769,-769,-769,960,-769,-769,-769
DATA 960,31998,31998,31999,961,31996,31996,31999,963,31992,31992,31999
DATA 966,31984,31984,31999,960,31999,31999,31999,960,31999,31999,31999
DATA 960,31999,31999,31999,960,15614,15614,15614,960,3320,3320,3320,960
DATA -769,-769,-769,960,192,192,192,-1,128,128,128,-1,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,16,16,-1,-1,-1,-1
DATA -257,-257,-257,-1,-769,-769,-769,960,-769,-769,-769,960,15612,15612
DATA 15612,960,-25351,-25351,-25351,960,-13069,-13069,-13069,960,-13069
DATA -13069,-13069,960,-25345,-25345,-25345,960,15615,15615,15615,960,31998
DATA 31998,31998,960,-769,-769,-769,960,31998,31998,31998,960,-769,-769
DATA -769,960,192,192,192,-1,128,128,128,-1,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,16,16,-257,-257,-257,256,-257
DATA -257,-257,256,-257,-257,-257,256,-258,-258,-258,256,-2338,-2338,-2338
DATA 256,12008,12008,12008,256,7923,7923,7923,259,3810,3810,3810,258,640
DATA 640,640,256,3808,3808,3808,256,7920,7920,7920,256,12008,12008,12008
DATA 256,-2338,-2338,-2338,256,-258,-258,-258,256,-257,-257,-257,256,
DATA ,,-1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,16,16,,,-257,-1,,,-257,-1,,,-257,-1,,,-258,-2,,,-2338
DATA -2082,,,12008,12264,3,3,7923,8179,2,2,3810,4066,,,640,896,,
DATA 3808,4064,,,7920,8176,,,12008,12264,,,-2338,-2082,,,-258,-2
DATA ,,-257,-1,,,,-1,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,16,16,-257,-257,-257,256,-1889,-1889,-257,1888
DATA -3953,-3953,-257,3376,-7482,-7482,-258,6424,-14654,-14654,-290,12556
DATA 3808,3808,32494,24838,7920,7920,-265,-16125,3808,3808,-12573,-32511
DATA 640,640,-15741,-16126,3808,3808,-4377,24838,3824,3824,32510,12556
DATA 1760,1760,16124,6424,-7482,-7482,-258,3376,-3954,-3954,-258,1888,-1889
DATA -1889,-257,256,,,,-1
DATA 9,5,155,155,155,,-32662,-32662,-32662,,-32663,-32663,-32663,,-32662
DATA -32662,-32662,,155,155,155,,,,,,,,
DATA 16,16,-1,-1,-1,,-1,-1,-1,,-1,-1,-1,,-1,32766,32766,,-1,32764,32764
DATA ,-1,32760,32760,,-1,32752,32752,,-1,32766,32766,,-1,32766,32766
DATA ,-1,32766,32766,,-1,32766,32766,,-1,32766,32766,,-1,16380,16380
DATA ,-1,4080,4080,,-1,-1,-1,,-1,-1,-1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,16,16,-1,-1,-1,,-1,-1,-1,
DATA -1,-1,-1,,8184,-1,8184,,4080,16380,4080,,-14365,-8197,-14365,
DATA -6173,-5,-6173,,-14361,-2073,-14361,0,4095,-4097,4095,,8188,8191
DATA 8188,,-8,-4,-8,,-2061,-5,-2061,,992,-1025,992,,992,992,992,,-1
DATA -1,-1,,-1,-1,-1,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,16,16,-1,-1,-1,,-1,-1,-1,,-1,-1,-1,,8176,8176
DATA -1,,4064,4064,12280,,-12313,-12313,-4121,,-12289,-12289,-4097,
DATA -12289,-12289,-4097,,8188,8188,-8193,,-12289,-12289,-4097,,-12289
DATA -12289,-4097,,-12313,-12313,-4097,,4064,4064,-4113,,8176,8176,8176
DATA ,-1,-1,-1,,-1,-1,-1,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,16,16,-1,-1,-1,,-1,-1,-1,,-1,-1,-1,,-4097
DATA -28673,-28673,,-4097,4095,4095,,-20481,4094,4094,,28671,20476,20476
DATA ,-4098,-12296,-12296,,-4099,-12303,-12303,,-4101,-12317,-12317
DATA ,-4105,-12345,-12345,,-2049,1920,1920,,14208,1920,1920,,-12289
DATA -12289,-12289,,-1,-1,-1,,-1,-1,-1,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,16,16,-1,-1,-1,,-1,-1,-1,
DATA -1,-1,-1,,-2049,2016,-2049,-4065,6128,2016,6128,4112,-6153,-6169
DATA -6153,16,-9,-25,-9,16,-1,8160,-1,-8161,16368,4080,16368,12288,-2049
DATA -14337,-2049,12288,-2049,-6145,-2049,4096,-2049,-14361,-2049,12312
DATA -4113,4064,-4113,-8177,8176,8176,8176,,-1,-1,-1,,-1,-1,-1,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,16,16
DATA -1,-1,-1,,-1,-1,-1,,-1,-1,-1,,8176,-8193,8176,-16369,4064,12280
DATA 4064,8216,-12345,-12297,-12345,48,-49,-17,-49,32,8136,-17,8136,-8153
DATA 4032,12264,4032,8232,-14393,-10249,-14393,4144,-6193,-2065,-6193,4128
DATA -14393,-2057,-14393,12336,4064,-4113,4064,-8177,8176,8176,8176,,-1
DATA -1,-1,,-1,-1,-1,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,16,16,-1,-1,-1,,-1,-1,-1,,-1,-1,-1,,1984,-2049
DATA -2049,-4033,1984,14320,14320,12336,-12337,-4145,-4145,8192,-28673
DATA -4097,-4097,24576,-24577,-8193,-8193,16384,8191,-8193,-8193,-16384
DATA 16383,-16385,-16385,-32768,16382,-16385,-16385,-32767,32766,32767
DATA 32767,1,16376,-16385,-16385,-32761,16376,16376,16376,,-1,-1,-1,
DATA -1,-1,-1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,16,16,-1,-1,-1,,-1,-1,-1,,-1,-1,-1,,8184,8184,-1,-8185
DATA 4080,4080,-1,4104,-14365,-14365,-1,8208,-14365,-14365,-1,8208,4080
DATA 4080,-1,-8181,2016,2016,-1,2064,-7225,-7225,-1,1056,-3121,-3121,-1
DATA 1056,-7225,-7225,-1,5160,2016,2016,-1,-6121,4080,4080,-1,4104,-1,-1
DATA -1,,-1,-1,-1
DATA 20,20,-1,-16,-3841,-1,240,,2046,-272,-4089,2046,240,,504,-1552,-3847
DATA -1543,496,248,240,-2064,-3842,-265,2032,254,224,-4240,28927,-17,3952
DATA 255,192,-8400,-20225,-33,8112,-32513,192,-9168,-20237,-3108,7344,-32525
DATA 128,-17392,-12045,-3140,15568,-16141,128,-16624,-12033,-65,16336,-16129
DATA 128,-16624,-12033,-65,16336,-16129,128,-16624,-12033,-65,16336,-16129
DATA 128,-16624,-12033,-65,16336,-16129,128,-17648,-12035,-581,15312,-16131
DATA 192,-9424,-20227,-549,7088,-32515,192,-8912,-20229,-1059,7600,-32517
DATA 224,-4496,28679,2030,3696,7,240,-2064,-3842,-265,2032,254,504,-1552
DATA -3847,-1543,496,248,2046,-272,-4089,2046,240,,-1,-16,-3841,-1,240
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,20,20,-1,-16,-3841,-1,240,,2046
DATA -272,-4089,2046,240,,504,-1552,-3847,-1543,496,248,240,-2064,-3842
DATA -265,2032,254,224,-4240,28927,-17,3952,255,192,-9168,-20381,25564
DATA 7344,-32669,192,-9168,-20381,25564,7344,-32669,128,-17392,-12189,25532
DATA 15568,-16285,128,-16624,-12033,-65,16336,-16129,128,-16624,-12033
DATA -65,16336,-16129,128,-16624,-12033,-65,16336,-16129,128,-16624,-12033
DATA -65,16336,-16129,128,-16624,-12129,-24641,16336,-16225,192,-8400,-20465
DATA 4063,8112,-32753,192,-8400,-20465,4063,8112,-32753,224,-4240,28831
DATA -24593,3952,159,240,-2064,-3842,-265,2032,254,504,-1552,-3847,-1543
DATA 496,248,2046,-272,-4089,2046,240,,-1,-16,-3841,-1,240,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,20,20,-1,-16,-3841,-1,240,,2046,-272,-4089
DATA 2046,240,,504,-1552,-3847,-1543,496,248,240,-2064,-3842,-265,2032
DATA 254,224,-4240,28927,-17,3952,255,192,-12240,-20384,24784,4272,-32672
DATA 192,-16336,12288,192,48,0,128,-24560,20576,24736,8272,16480,128,-24560
DATA 20576,24736,8272,16480,128,-20464,-12048,-3920,12496,-16144,128,-16624
DATA -12033,-65,16336,-16129,128,-16624,-12033,-65,16336,-16129,128,-17648
DATA -12035,-581,15312,-16131,192,-9424,-20227,-549,7088,-32515,192,-8912
DATA -20229,-1059,7600,-32517,224,-4496,28679,2030,3696,7,240,-2064,-3842
DATA -265,2032,254,504,-1552,-3847,-1543,496,248,2046,-272,-4089,2046,240
DATA ,-1,-16,-3841,-1,240,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
DATA ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,20,20,-1,-16
DATA -3841,-1,240,,2046,-272,-4089,2046,240,,504,-1552,-3847,-1543,496
DATA 248,240,-2064,-3842,-265,2032,254,224,-4240,28927,-17,3952,255,192
DATA -8912,-20373,27613,7600,-32661,192,-8656,-20233,-2082,7856,-32521
DATA 128,-17136,-12181,27581,15824,-16277,128,-16624,-12033,-65,16336,-16129
DATA 128,-16624,-12033,-65,16336,-16129,128,-16624,-12033,-65,16336,-16129
DATA 128,-16624,-12033,-65,16336,-16129,128,-16624,-12273,4031,16336,-16369
DATA 192,-8656,-20233,-2082,7856,-32521,192,-8912,-20229,-1059,7600,-32517
DATA 224,-4752,28923,-1043,3440,251,240,-2064,-3842,-265,2032,254,504,-1552
DATA -3847,-1543,496,248,2046,-272,-4089,2046,240,,-1,-16,-3841,-1,240
DATA -1,,1,,,-1,,1,-1,-1,1,-1,-1,1,1,1

DATA 9,5,-32517,-32517,-32517,,-32519,-32519,-32519,,-32640,-32640,-32640
DATA ,-32519,-32519,-32519,,-32517,-32517,-32517

DATA 9,5,-32529,-32529,-32529,,-32561,-32561,-32561,,-32640,-32640,-32640
DATA ,-32561,-32561,-32561,,-32529,-32529,-32529

SUB BoxDraw (x1, y1, x2, y2, status, height)
	IF status = 0 THEN cul1 = 8: cul2 = 15
	IF status = 1 THEN cul1 = 15: cul2 = 8
	FOR i = 0 TO height - 1
		LINE (x1, y1 + i)-(x2 - i, y1 + i), cul1
		LINE (x1 + i, y1)-(x1 + i, y2 - i), cul1
		LINE (x1 + i + 1, y2 - i)-(x2, y2 - i), cul2
		LINE (x2 - i, y1 + i + 1)-(x2 - i, y2), cul2
	NEXT i
END SUB

SUB moff
m.ax = 2: CALL INTERRUPTX(&H33, m, m)
END SUB

SUB mon
m.ax = 1: CALL INTERRUPTX(&H33, m, m)
END SUB

