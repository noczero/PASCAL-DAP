'===========================================================================
' Subject: TETRIS CLONE (TEXT VERSION)        Date: 06-29-97 (22:30)      
'  Author: Joshua Dickerson                   Code: QB, QBasic, PDS       
'  Origin: comp.lang.basic.misc             Packet: GAMES.ABC
'===========================================================================
DEFINT A-Z
'Retro_V presents TETRIS.BAS!
'
'Instructions:
'Standard rules of Tetris apply..
'Turn on the NumLock key and use the number pad to control piece.
'Controls are 4 Left, 6 Right, 2 Drop piece by one row early, and 5 to Rotate.
'
'Graphics version coming soon..

DECLARE SUB UpdateStats (CurPiece)
DECLARE SUB PrintNextPiece (NextPiece)
DECLARE SUB MakePlayingField ()
DECLARE SUB PlayPiece ()
DECLARE SUB Menu ()
DECLARE SUB DropPiece ()
DECLARE SUB DisplayPiece (DisplayFlag)
DECLARE FUNCTION Collided ()
DECLARE SUB CheckForLines ()
DECLARE SUB MovePiece (Right)
DECLARE SUB RotatePiece ()
DECLARE SUB GamePlayMainLoop ()
DECLARE SUB FillPlayingField ()
DECLARE SUB DisplayStatsBox ()
DECLARE SUB DisplayPlayingArea ()
DECLARE SUB DisplayScoreBoard ()
DECLARE SUB DisplayNextBox ()
DECLARE SUB DisplayLevelBox ()
DECLARE SUB DisplayHeightBox ()
DECLARE SUB DisplayBackGround ()

RANDOMIZE TIMER
DIM SHARED Piece(7, 4, 4) AS STRING * 1
DIM SHARED pLength(7), pWidth(7), fColor(7), bColor(7)
DIM SHARED CurPiece, PieceColor, Row, Col, Lines, GameOver, Score&, GameTypeA
DIM SHARED LevelDelay!, Level, Success, Height

FOR i = 1 TO 7
	READ pLength(i), pWidth(i), fColor(i), bColor(i)
	FOR J = 1 TO pLength(i)
		FOR K = 1 TO pWidth(i)
			READ Piece(i, J, K)
		NEXT
	NEXT
NEXT

WIDTH 40

Menu
MakePlayingField
GamePlayMainLoop

IF Success THEN
	LOCATE 12, 17
	COLOR 15, 0
	PRINT "Success!"
 ELSE
	FOR i = 500 TO 100 STEP -5
		SOUND INT(i * RND) + 100, .1
	NEXT
	COLOR 11, 3
	FOR i = 21 TO 2 STEP -1
		LOCATE i, 16
		PRINT STRING$(10, "ß");
	NEXT


	LOCATE 12, 17
	COLOR 15, 3
	PRINT "GameOver"
END IF

END

DATA 2, 3, 9, 1, "þ","þ","þ", " ","þ"," ", 2, 3, 10, 2, "þ", "þ", "þ", " "
DATA " ", "þ", 2, 3, 11, 3, "þ", "þ", " ", " ", "þ", "þ", 2, 2, 12, 4, "þ"
DATA "þ", "þ", "þ", 2, 3, 13, 5, " ", "þ", "þ", "þ", "þ", " ", 2, 3, 14, 6
DATA "þ", "þ", "þ", "þ", " ", " ", 1, 4, 15, 7, "þ", "þ", "þ", "þ"

SUB CheckForLines
	FOR i = 1 TO pLength(CurPiece)
		IF Row + i > 1 THEN
			LineFormed = -1
			FOR J = 1 TO 10
								IF SCREEN(Row + i, J + 15) = 32 THEN LineFormed = 0
			NEXT
			IF LineFormed THEN
				FOR J = 1 TO 20
					SOUND INT(500 * RND) + 100, .1
				NEXT
				Removed = Removed + 1
				FOR J = Row + i TO 3 STEP -1
					LOCATE J, 16
					FOR K = 1 TO 10
												cCode = SCREEN(J - 1, K + 15, 1)
												COLOR cCode MOD 16, INT(cCode / 16)
												PRINT CHR$(SCREEN(J - 1, K + 15));
					NEXT
				NEXT
				LOCATE 2, 16
				COLOR 0, 0
				PRINT SPACE$(10);
			END IF
		END IF
	NEXT
	
	IF Removed THEN
		IF GameTypeA THEN
			Lines = Lines - Removed
			IF Lines < 1 THEN
				Lines = 0
				Success = -1
			END IF
		ELSE
			Lines = Lines + Removed
			IF Lines > 99 THEN
				Lines = 99
				Success = -1
			END IF
			IF INT(Lines / 10) > Level THEN
				Level = INT(Lines / 10)
				LOCATE 17, 36
				COLOR 7, 0
				PRINT Level
				LevelDelay! = 1 / (Level + 1)
				SOUND 5000, 1
				SOUND 4000, 1
			END IF
		END IF
	
		LOCATE 1, 23
		COLOR 10, 0
		PRINT Lines
		LOCATE 6, 34
		Score& = Score& + 500 * 2 ^ Removed
		COLOR 7
		PRINT USING "######"; Score&
	END IF
END SUB

FUNCTION Collided
	IF Row + pLength(CurPiece) < 21 THEN
		FOR i = 1 TO pLength(CurPiece)
			IF Row + i > 0 THEN
				FOR J = 1 TO pWidth(CurPiece)
										IF SCREEN(Row + i + 1, Col + J + 14) <> 32 AND Piece(CurPiece, i, J) <> " " THEN
												IF i < pLength(CurPiece) THEN
														IF Piece(CurPiece, i + 1, J) = " " THEN Collided = -1
						ELSE
							Collided = -1
						END IF
					END IF
				NEXT
			END IF
		NEXT
	ELSE
		Collided = -1
	END IF
END FUNCTION

SUB DisplayHeightBox
	COLOR 14, 0
	LOCATE 20, 33
	PRINT "ÚÄÄÄÄÄÄ¿"
	LOCATE 21, 33
	PRINT "³      ³"
	LOCATE 22, 33
	PRINT "³      ³"
	LOCATE 23, 33
	PRINT "ÀÄÄÄÄÄÄÙ"
	
	COLOR 12, 0
	LOCATE 21, 34
	PRINT "Height"
	LOCATE 22, 39
	PRINT USING "#"; Height;
END SUB

SUB DisplayLevelBox
	COLOR 11, 0

	LOCATE 15, 34
	PRINT "ÚÄÄÄÄÄ¿"
	LOCATE 16, 34
	PRINT "³     ³"
	LOCATE 17, 34
	PRINT "³     ³"
	LOCATE 18, 34
	PRINT "ÀÄÄÄÄÄÙ"

	COLOR 14
	LOCATE 16, 35
	PRINT "Level"
	LOCATE 17, 37
	PRINT USING "#"; Level;
END SUB

SUB DisplayNextBox
	COLOR 13, 0

	LOCATE 8, 35
	PRINT "ÚÄÄÄÄ¿"
	FOR i = 1 TO 5
		LOCATE 8 + i, 35
		PRINT "³    ³"
	NEXT
	LOCATE 14, 35
	PRINT "ÀÄÄÄÄÙ"
	
	COLOR 10
	LOCATE 9, 36
	PRINT "Next"
END SUB

SUB DisplayPiece (DisplayFlag)
		IF DisplayFlag THEN COLOR fColor(CurPiece), bColor(CurPiece) ELSE COLOR 0, 0
	
	FOR i = 1 TO pLength(CurPiece)
		IF Row + i > 1 THEN
			FOR J = 1 TO pWidth(CurPiece)
				IF Piece(CurPiece, i, J) <> " " THEN
					LOCATE Row + i, Col + J + 14
										IF DisplayFlag THEN PRINT Piece(CurPiece, i, J);  ELSE PRINT " ";
				END IF
			NEXT
		END IF
	NEXT
END SUB

SUB DisplayPlayingArea
	COLOR 7, 0
	
	LOCATE 1, 16
	PRINT "Lines -"; Lines
	
	COLOR 15, 0
	FOR J = 2 TO 21
		LOCATE J, 15
		PRINT "Û          Û"
	NEXT
	LOCATE 22, 15
	PRINT STRING$(12, "Û");
END SUB

SUB DisplayScoreBoard
	COLOR 12, 0
	LOCATE 2, 33
	PRINT "ÚÄÄÄÄÄÄ¿"
	FOR i = 3 TO 6
		LOCATE i, 33
		PRINT "³      ³"
	NEXT
	LOCATE 7, 33
	PRINT "ÀÄÄÄÄÄÄÙ"
	
	COLOR 5, 0
	LOCATE 3, 34
	PRINT "Top:"
	LOCATE 4, 34
	PRINT USING "######"; top
	
	COLOR 4, 0
	LOCATE 5, 34
	PRINT "Score:"
	LOCATE 6, 34
	PRINT "     0"
END SUB

SUB DisplayStatsBox
	COLOR 7, 0
	LOCATE 1, 1
	IF GameTypeA THEN PRINT "A-Type" ELSE PRINT "B-Type"
 
	COLOR 2, 0
	PRINT "ÚÄÄÄÄÄÄÄÄÄÄ¿"
	PRINT "³Statistics³"
	FOR i = 1 TO 19
		PRINT "³          ³"
	NEXT
	PRINT "ÀÄÄÄÄÄÄÄÄÄÄÙ"
	FOR i = 1 TO 7
		COLOR fColor(i), bColor(i)
		FOR J = 1 TO pLength(i)
			FOR K = 1 TO pWidth(i)
				IF Piece(i, J, K) <> " " THEN
					LOCATE J + 3 * i, 1 + K
					PRINT Piece(i, J, K);
				END IF
			NEXT
		NEXT
		COLOR 12, 0
		LOCATE 1 + i * 3, 8
		PRINT "-  0"
	NEXT
END SUB

SUB DropPiece
	DisplayPiece (0)
	Row = Row + 1
	DisplayPiece (-1)
END SUB

SUB FillPlayingField
	FOR i = 22 - Height TO 21
		LOCATE i, 16
		x = 0
		FOR J = 1 TO 10
			IF RND > .4 AND x < 9 THEN
				x = x + 1
				RndClr = INT(RND * 7) + 1
				COLOR fColor(RndClr), bColor(RndClr)
				PRINT "þ";
			ELSE
				COLOR 0, 0
				PRINT " ";
			END IF
		NEXT
	NEXT
END SUB

SUB GamePlayMainLoop
	NextPiece = INT(RND * 7) + 1
	
	DO
		CurPiece = NextPiece
		Row = 1 - pLength(NextPiece)
		Col = 5
 
		UpdateStats (CurPiece)
 
		NextPiece = INT(7 * RND) + 1
		
		PrintNextPiece (NextPiece)

		IF NOT Collided THEN
			PlayPiece
			SOUND 100, 1
			CheckForLines
			DO
			LOOP UNTIL INKEY$ = ""
		ELSE
			DropPiece
			GameOver = -1
		END IF
	LOOP UNTIL GameOver OR Success
END SUB

SUB MakePlayingField
	COLOR 0, 0
	CLS

	DisplayStatsBox
	DisplayPlayingArea
	DisplayScoreBoard
	DisplayNextBox
	DisplayLevelBox
	
	IF GameTypeA THEN
		DisplayHeightBox
		FillPlayingField
	END IF
END SUB

SUB Menu
	GameTypeA = -1
	Level = 0
	Height = 0

	CLS

	PRINT "Use Number Pad to select."
	PRINT "Press ENTER to play"
	PRINT
	PRINT " Type:              Level:"
	PRINT "ÚÄÄÄÄÄÄÄ¿          ÚÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄ¿"
	PRINT "³ A-Type³          ³0³1³2³3³4³5³6³7³8³9³"
	PRINT "³ B-Type³          ÀÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÙ"
	PRINT "ÀÄÄÄÄÄÄÄÙ"

	LOCATE 6, 2
	COLOR 9
	PRINT ">";
	LOCATE 6, 21
	COLOR 0, 7
	PRINT "0";

	DO
		A$ = INPUT$(1)
		IF A$ = "8" OR A$ = "2" THEN
			COLOR 7, 0
			LOCATE 7 + GameTypeA, 2
			PRINT " ";
			GameTypeA = -1 - GameTypeA
			LOCATE 7 + GameTypeA, 2
			COLOR 9
			PRINT ">";
		END IF
	
				IF (A$ = "4" AND Level > 0) OR (A$ = "6" AND Level < 9) THEN
			COLOR 7, 0
			LOCATE 6, Level * 2 + 21
			PRINT USING "#"; Level
						IF A$ = "4" THEN Level = Level - 1 ELSE Level = Level + 1
			COLOR 0, 7
			LOCATE 6, Level * 2 + 21
			PRINT USING "#"; Level
		END IF
	LOOP UNTIL A$ = CHR$(13)
	
	LevelDelay! = 1 / (Level + 1)
	IF GameTypeA THEN
		LOCATE 8, 21
		COLOR 7, 0
		PRINT "Height:"
		LOCATE 9, 20
		PRINT "ÚÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄ¿"
		LOCATE 10, 20
		PRINT "³0³1³2³3³4³5³6³7³8³9³"
		LOCATE 11, 20
		PRINT "ÀÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÙ"

		LOCATE 10, 21
		COLOR 0, 7
		PRINT "0";
		Lines = 24
		
		DO
			A$ = INPUT$(1)
						IF (A$ = "4" AND Height > 0) OR A$ = "6" AND Height < 9 THEN
				COLOR 7, 0
				LOCATE 10, Height * 2 + 21
				PRINT USING "#"; Height
								IF A$ = "4" THEN Height = Height - 1 ELSE Height = Height + 1
				COLOR 0, 7
				LOCATE 10, Height * 2 + 21
				PRINT USING "#"; Height
			END IF
		LOOP UNTIL A$ = CHR$(13)
	END IF
END SUB

SUB MovePiece (Right)
		IF (NOT Right AND Col > 1) OR (Right AND Col + pWidth(CurPiece) < 11) THEN
		FOR i = 1 TO pLength(CurPiece)
			IF Row + i > 1 THEN
				FOR J = 1 TO pWidth(CurPiece)
					IF Right THEN
												A = SCREEN(Row + i, Col + J + 15)
					ELSE
												A = SCREEN(Row + i, Col + J + 13)
					END IF
										IF A <> 32 AND Piece(CurPiece, i, J) <> " " THEN
						IF Right THEN
														IF J < pWidth(CurPiece) THEN
																IF Piece(CurPiece, i, J + 1) = " " THEN Collision = -1
							ELSE
																Collision = -1
							END IF
						ELSE
							IF J > 1 THEN
																IF Piece(CurPiece, i, J - 1) = " " THEN Collision = -1
							ELSE
																Collision = -1
							END IF
						END IF
					END IF
				NEXT
			END IF
		NEXT
		
		IF NOT Collision THEN
			SOUND 1000, .3
			DisplayPiece (0)
			IF Right THEN Col = Col + 1 ELSE Col = Col - 1
			DisplayPiece (-1)
		END IF
	END IF
END SUB

SUB PlayPiece
	DO
		DropPiece
		t! = TIMER
		DO
			A$ = INKEY$
			
			IF A$ <> "" THEN
				IF A$ = "4" THEN MovePiece (0)
				IF A$ = "6" THEN MovePiece (-1)
				IF A$ = "5" THEN RotatePiece
			END IF
		LOOP UNTIL A$ = "2" OR TIMER > t! + LevelDelay!
	LOOP UNTIL Collided
END SUB

SUB PrintNextPiece (NextPiece)
	FOR i = 1 TO 4
		COLOR 0, 0
		LOCATE 9 + i, 36
		PRINT "    "
	NEXT
	COLOR fColor(NextPiece), bColor(NextPiece)
	FOR i = 1 TO pLength(NextPiece)
		FOR J = 1 TO pWidth(NextPiece)
			IF Piece(NextPiece, i, J) <> " " THEN
				LOCATE 9 + i, 35 + J
				PRINT Piece(NextPiece, i, J);
			END IF
		NEXT
	NEXT
END SUB

SUB RotatePiece
	DIM Temp(4, 4) AS STRING * 1
	
	IF Col + pLength(CurPiece) <= 11 THEN
		FOR i = pWidth(CurPiece) TO 1 STEP -1
			K = K + 1
			FOR J = 1 TO pLength(CurPiece)
				Temp(i, J) = Piece(CurPiece, J, K)
			NEXT
		NEXT
	
		IF NOT Collision THEN
			DisplayPiece (0)
	
			FOR i = 1 TO 4
				FOR J = 1 TO 4
					Piece(CurPiece, i, J) = Temp(i, J)
				NEXT
			NEXT

			Row = Row + (pLength(CurPiece) - pWidth(CurPiece))
			SWAP pLength(CurPiece), pWidth(CurPiece)
	
			DisplayPiece (-1)
			SOUND 900, .3
		END IF
	END IF
END SUB

SUB UpdateStats (CurPiece) STATIC
	DIM Stats(7)
	
	Stat(CurPiece) = Stat(CurPiece) + 1
	LOCATE 1 + CurPiece * 3, 9
	COLOR 12, 0
	PRINT USING "###"; Stat(CurPiece)
END SUB

