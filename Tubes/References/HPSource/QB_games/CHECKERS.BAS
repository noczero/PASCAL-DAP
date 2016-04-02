'-----------------------------------------------------------------------------
'A Checkers Game That Learns From Its Mistakes:By Rich Geldreich
'(Well, it should. I did my best, if you have any comments, please write!)
'410 Market Street
'Gloucester City, New Jersey 08030
'-----------------------------------------------------------------------------


DEFINT A-Z
'-----------------------------------------------------------------------------
'Subroutines for program
'-----------------------------------------------------------------------------
DECLARE FUNCTION Bttn ()
DECLARE FUNCTION Getkey$ ()
DECLARE FUNCTION SelectPiece (Flash)
DECLARE FUNCTION JumpWay (Start, Middle)
DECLARE FUNCTION Increment (A)
DECLARE FUNCTION IsTop (P)
DECLARE FUNCTION IsLeft (P)
DECLARE FUNCTION IsRight (P)
DECLARE FUNCTION IsBottom (P)
DECLARE FUNCTION TopLeft (Position)
DECLARE FUNCTION TopRight (Position)
DECLARE FUNCTION BottomLeft (Position)
DECLARE FUNCTION BottomRight (Position)
DECLARE FUNCTION SameRow (P1, P2)
DECLARE FUNCTION SameColumn (P1, P2)
DECLARE FUNCTION Scan (Position)
DECLARE FUNCTION Joystick (Flash)
DECLARE SUB HumansMove ()
DECLARE SUB PickMove ()
DECLARE SUB DeleteBlack (P%)
DECLARE SUB DeleteRed (P)
DECLARE SUB PutChecker (P, Rd, King)
DECLARE SUB EraseChecker (P)
DECLARE SUB ComputersTurn ()
DECLARE SUB DrawBord ()
DECLARE SUB TestComputersMoves ()
DECLARE SUB CalculatePoints ()
DECLARE SUB HumansMoves ()
DECLARE SUB ScanAround (Piece, Col)
DECLARE SUB PreparePieces ()
DECLARE SUB Allmoves (Piece, C, Jumps)
DECLARE SUB update ()

'-----------------------------------------------------------------------------
'Constants
'-----------------------------------------------------------------------------

CONST True = -1, False = NOT True
CONST Red = 0, Black = 1, Null = 2
CONST Sngl = 0, Jmp = 1, King = 2

'-----------------------------------------------------------------------------
'Data Types
'-----------------------------------------------------------------------------

TYPE Piece
    Pst AS INTEGER
    King AS INTEGER
END TYPE

TYPE M
    Pce AS INTEGER
    Move AS INTEGER
END TYPE

TYPE Co
    X AS INTEGER
    Y AS INTEGER
END TYPE


'-----------------------------------------------------------------------------
'Define Global Variables
'-----------------------------------------------------------------------------

CLEAR , , 5000
DIM SHARED Reds(12) AS Piece, Blacks(12) AS Piece, NumReds, NumBlacks
DIM SHARED PosMap(12, 4), Posmoves(12), Pty(12, 4), Typ(12, 4), M(12, 4)
DIM SHARED PosMapR(12, 4), PosMovesR(12), TypR(12, 4), MR(12, 4)
DIM SHARED TempPos(4), TempNum, Temp(4), Tempn, Good(4)
DIM SHARED Piece, Move, C
DIM SHARED Xy(32) AS Co, Game
DIM SHARED K$, Aa(15), Ag(90), Bg(90)
DIM SHARED Points(13) AS DOUBLE
DIM SHARED Mem(12, 12, 4), Used(12), NotUsed(12), In, GiveUp



'-----------------------------------------------------------------------------
'Set Global Vars(Some Vars will set themselve when they are first called via
'Subs)
'Set the Game var to True if you want the all-kings version
'-----------------------------------------------------------------------------

Al = 60: Bl = 60
Game = False
In = False
PreparePieces

SCREEN 1
COLOR 0, 0
CLS
VIEW PRINT 1 TO 25

RANDOMIZE TIMER

'-----------------------------------------------------------------------------
'Draw cursor for joystick pointing
'-----------------------------------------------------------------------------

GET (0, 0)-(26, 18), Bg
DRAW "Bm160,100h5nd3r3"
GET (160, 100)-(160 - 5, 100 - 5), Aa
CLS
'-----------------------------------------------------------------------------
'Scan for data files, if exists, use them. If not, play without(completely
'dumb)
'-----------------------------------------------------------------------------

Exists = True
ON ERROR GOTO NotExists
OPEN "I", #1, "Learn.Dat"
ON ERROR GOTO 0
IF Exists THEN
    FOR A = 1 TO 12
        INPUT #1, Points(A)
    NEXT
    CLOSE
END IF
PRINT
PRINT "Checkers By Rich Geldreich 1991"
PRINT "H.A.D Data Has ";
IF Exists THEN
    PRINT "Been Loaded"
ELSE
    PRINT "Not Been Loaded"
END IF
PRINT "Heuristic Application Data(H.A.D):"
FOR A = 1 TO 12
    PRINT "Rule "; MID$(STR$(A), 2); ":"; Points(A)
NEXT
PRINT
PRINT "Please Select Input Device:"
PRINT "1. Keyboard"
PRINT "2. Joystick"
ln = CSRLIN
DO
    LOCATE ln, 1
    LINE INPUT A$
    A = VAL(A$)
LOOP UNTIL A = 1 OR A = 2
IF A = 2 THEN
    In = False
ELSE
    In = True
END IF
CLS
IF In THEN
    PRINT "Keys to use:"
    PRINT
    PRINT "Left and Right Arrows Select"
    PRINT
    PRINT "Q Quits"
    PRINT
    PRINT "T Takes Back A Selected Piece"
ELSE
    PRINT "Use Joystick(Stick 0 and 1) to"
    PRINT "Select Pieces"
    PRINT
    PRINT "Q Quits"
    PRINT
    PRINT "T Takes Back A Selected Piece"
END IF
PRINT : PRINT
PRINT "NOTE: While making a multiple jump, go"
PRINT "to the place where you want to jump to,"
PRINT "otherwise, select any illegal block if"
PRINT "you don't want to jump."
IF In THEN
    LOCATE 24, 1
    PRINT "Press a key to play";
    A$ = INPUT$(1)
ELSE
    LOCATE 24, 1
    PRINT "Click joystick to play";
    DO
    LOOP UNTIL STRIG(1)
END IF
CLS
DrawBord
update
DO
    ComputersTurn
    LOCATE 1, 12: PRINT "Red:"; NumReds; "Black:"; NumBlacks; "  "

    IF NOT GiveUp AND NumReds <> 0 THEN
        HumansMove
    END IF
    LOCATE 1, 12: PRINT "Red:"; NumReds; "Black:"; NumBlacks; "  "
LOOP UNTIL GiveUp OR NumReds = 0 OR NumBlacks = 0
CLS
IF GiveUp THEN
    PRINT "It's a tie! Well, how about that!"
    PRINT "Learned data not updated."
    END
END IF

IF NumBlacks = 0 THEN
    PRINT "I Lost! Darn!"
    FOR A = 1 TO 12
        Points(A) = Points(A) - Used(A) * 3 + NotUsed(A)
    NEXT
END IF

IF NumReds = 0 THEN
    PRINT "I Won! Great!!"
END IF
PRINT "Rule Usage Statistics"
PRINT "Used", "NotUsed"
FOR A = 1 TO 12
    PRINT MID$(STR$(A), 2); ":"; Used(A), NotUsed(A)
NEXT
OPEN "O", #1, "Learn.Dat"
FOR A = 1 TO 12
    PRINT #1, Points(A)
NEXT
CLOSE #1
PRINT "Learned Data Stored"
SOUND 2600, 22
END

NotExists:
    Exists = False
RESUME NEXT

'-----------------------------------------------------------------------------'
'Calculates all legal moves for a piece and stores in an array
'-----------------------------------------------------------------------------'
SUB Allmoves (Piece, C, Jumps)
    Posmoves(Piece) = 0
    ScanAround Piece, C
    FOR A = 0 TO TempNum - 1
        Temp(A) = TempPos(A)
        Good(A) = True
    NEXT
    Tempn = TempNum
    FOR A = 0 TO Tempn - 1
        P = Temp(A)
        SELECT CASE C
        CASE Red
            IF NOT Reds(Piece).King AND (INT(P / 4) * 4) > INT(Reds(Piece).Pst / 4) * 4 THEN
                Good(A) = False
            END IF
            IF Scan(P) = Red THEN
                Good(A) = False
            END IF
        CASE Black
            IF NOT Blacks(Piece).King AND (INT(P / 4) * 4) < INT(Blacks(Piece).Pst / 4) * 4 THEN
                Good(A) = False
            END IF
            IF Scan(P) = Black THEN
                Good(A) = False
            END IF
        END SELECT
    NEXT
    FOR A = 0 TO Tempn - 1
        IF Good(A) THEN
            S = Scan(Temp(A))
            IF S = Null AND Jumps = False THEN
                PosMap(Piece, Posmoves(Piece)) = Temp(A)
                Typ(Piece, Posmoves(Piece)) = Sngl
                SELECT CASE C
                CASE Red
                    IF (INT(Temp(A) / 4) * 4) = 0 AND Reds(Piece).King = False THEN
                        Typ(Piece, Posmoves(Piece)) = King
                    END IF
                CASE Black
                    IF (INT(Temp(A) / 4) * 4) = 28 AND Blacks(Piece).King = False THEN
                        Typ(Piece, Posmoves(Piece)) = King
                    END IF
                END SELECT
                Posmoves(Piece) = Increment(Posmoves(Piece))
            ELSE
                IF S <> Null THEN
                    IF NOT (IsTop(Temp(A)) OR IsBottom(Temp(A)) OR IsLeft(Temp(A)) OR IsRight(Temp(A))) THEN
                        SELECT CASE C
                        CASE Red
                            J = JumpWay(Reds(Piece).Pst, Temp(A))
                        CASE Black
                            J = JumpWay(Blacks(Piece).Pst, Temp(A))
                        END SELECT
                        IF Scan(J) = Null THEN
                            PosMap(Piece, Posmoves(Piece)) = J
                            Typ(Piece, Posmoves(Piece)) = Jmp
                            M(Piece, Posmoves(Piece)) = Temp(A)
                            Posmoves(Piece) = Increment(Posmoves(Piece))
                        END IF
                    END IF
                END IF
            END IF
        END IF
    NEXT
END SUB

'-----------------------------------------------------------------------------'
'Returns square on the bottom left
'-----------------------------------------------------------------------------'
FUNCTION BottomLeft (Position)
    First = INT(Position / 4) * 4
    IF (First AND 4) = 0 THEN
        BottomLeft = Position + 4
    ELSE
        BottomLeft = Position + 3
    END IF
END FUNCTION

'-----------------------------------------------------------------------------'
'Returns square on the bottom right
'-----------------------------------------------------------------------------DEFINT A-Z
FUNCTION BottomRight (Position)
    First = INT(Position / 4) * 4
    IF (First AND 4) = 0 THEN
        BottomRight = Position + 5
    ELSE
        BottomRight = Position + 4
    END IF
END FUNCTION

'-----------------------------------------------------------------------------'
'Get joysticks button status(if the button is held down, only one signal
'will be sent, "bounceless")
'-----------------------------------------------------------------------------'
FUNCTION Bttn
    STATIC Bounce
    Bttn = False
    IF STRIG(1) THEN
        IF NOT Bounce THEN
            Bounce = True
            Bttn = True
        END IF
    ELSE
        Bounce = False
    END IF
END FUNCTION

'-----------------------------------------------------------------------------'
'Major routine: looks at all possible moves for each player;gives each piece
'a score. The piece with the higest score is used for computers move. Each
'move's value is adjusted every time the computer wins or losses depending on
'how many times the computer has used that move in the actual game.
'If the computer lost, the moves it used are punished(made lower in value).
'If the computer won, the moves it used are rewarded(made higher in value).
'Note that this subroutine only calculates the points!
'-----------------------------------------------------------------------------'
SUB CalculatePoints
    DIM PosJumps(60)
    DIM PosKing(60)
    DIM PosMapS(12, 4), PosMovesS(12), TypS(12, 4), MS(12, 4)
    DIM PosMapS1(12, 4), PosMovesS1(12), TypS1(12, 4), MS1(12, 4)
   
    HumansMoves
   
    TestComputersMoves
    GiveUp = True

    FOR A = 1 TO NumBlacks
        IF Posmoves(A) > 0 THEN
            GiveUp = False
            EXIT FOR
        END IF
    NEXT
    IF NOT GiveUp THEN
        FOR A = 1 TO NumBlacks
            FOR B = 0 TO Posmoves(A) - 1
                FOR C = 1 TO 12
                    Mem(C, A, B) = False
                NEXT
                Pty(A, B) = 0
            NEXT
        NEXT

        PosJumps = 0
        FOR A = 1 TO NumReds
            FOR B = 0 TO PosMovesR(A) - 1
                IF TypR(A, B) = Jmp THEN
                    PosJumps(PosJumps) = PosMapR(A, B)
                    PosJumps = Increment(PosJumps)
                END IF
            NEXT
        NEXT
   
        PosKings = 0
        FOR A = 1 TO NumReds
            FOR B = 0 TO PosMovesR(A) - 1
                IF TypR(A, B) = King THEN
                    PosKing(PosKings) = PosMapR(A, B)
                    PosKings = Increment(PosKings)
                END IF
            NEXT
        NEXT

        ' Start of Raster Scheme
   
        FOR A = 0 TO PosJumps - 1
            FOR B = 1 TO NumBlacks
                FOR C = 0 TO Posmoves(B) - 1
                    IF PosMap(B, C) = PosJumps(A) THEN
                        Pty(B, C) = Pty(B, C) + Points(1)
                        Mem(1, B, C) = True
                    END IF
                NEXT
            NEXT
        NEXT

        FOR A = 0 TO PosKings - 1
            FOR B = 1 TO NumBlacks
                FOR C = 0 TO Posmoves(B) - 1
                    IF PosMap(B, C) = PosKing(A) THEN
                        Pty(B, C) = Pty(B, C) + Points(2)
                        Mem(2, B, C) = True
                    END IF
                NEXT
            NEXT
        NEXT

        FOR A = 1 TO NumBlacks
            FOR B = 0 TO Posmoves(A) - 1
                SELECT CASE Typ(A, B)
                CASE King
                    Pty(A, B) = Pty(A, B) + Points(3)
                    Mem(3, A, B) = True
                CASE Jmp
                    Pty(A, B) = Pty(A, B) + Points(4)
                    Mem(4, A, B) = True
                CASE Sngl
                END SELECT
            NEXT
        NEXT
        FOR A = 1 TO NumReds
            FOR B = 0 TO PosMovesR(A) - 1
                IF TypR(A, B) = Jmp THEN
                    F = Scan(MR(A, B))
                    FOR C1 = 0 TO Posmoves(C) - 1
                        Pty(C, C1) = Pty(C, C1) + Points(6)
                        Mem(6, C, C1) = True
                    NEXT
                END IF
            NEXT
        NEXT
       
        FOR A = 1 TO NumBlacks
            FOR B = 0 TO Posmoves(A) - 1
                PosMapS(A, B) = PosMap(A, B)
                TypS(A, B) = Typ(A, B)
                MS(A, B) = M(A, B)
            NEXT
            PosMovesS(A) = Posmoves(A)
        NEXT
        FOR A = 1 TO NumReds
            FOR B = 0 TO PosMovesR(A) - 1
                PosMapS1(A, B) = PosMapR(A, B)
                TypS1(A, B) = TypR(A, B)
                MS1(A, B) = MR(A, B)
            NEXT
            PosMovesS1(A) = PosMovesR(A)
        NEXT
   


        FOR A1 = 1 TO NumBlacks
            Last = Blacks(A1).Pst
            FOR B = 0 TO PosMovesS(A1) - 1
                Dest = PosMapS(A1, B)
                Blacks(A1).Pst = Dest
                IF TypS(A1, B) = Jmp THEN
                    F = Scan(MS(A1, B))
                    Mchecker = C
                    Mpos = Reds(Mchecker).Pst
                    Mking = Reds(Mchecker).King
                    DeleteRed Mchecker
                END IF
                   
                TestComputersMoves
                FOR D = 0 TO Posmoves(A1) - 1
                    SELECT CASE Typ(A1, D)
                    CASE Jmp
                        Pty(A1, D) = Pty(A1, D) + Points(11)
                        Mem(11, A1, B) = True
                    CASE King
                        Pty(A1, D) = Pty(A1, D) + Points(12)
                        Mem(12, A1, B) = True
                    CASE Sngl
                    END SELECT
               
                NEXT
                   
                HumansMoves
                FOR C1 = 1 TO NumReds
                    FOR D = 0 TO PosMovesR(C1) - 1
                        IF TypR(C1, D) = Jmp THEN
                            IF PosMapR(C1, D) = Last THEN
                                Pty(A1, B) = Pty(A1, B) + Points(8)
                                Mem(8, A1, B) = True
                            END IF
                            IF Scan(MR(C1, D)) = Black AND C = A1 THEN
                                Pty(A1, B) = Pty(A1, B) + Points(9)
                                Mem(9, A1, B) = True
                            END IF
                            IF PosMapR(C1, D) = Mpos THEN
                                Pty(A1, B) = Pty(A1, B) + Points(10)
                                Mem(10, A1, B) = True
                            END IF
                        END IF
                    NEXT D
                NEXT C1
                IF TypS(A1, B) = Jmp THEN
                    FOR Z = NumReds + 1 TO Mchecker + 1 STEP -1
                        Reds(Z).Pst = Reds(Z - 1).Pst
                        Reds(Z).King = Reds(Z - 1).King
                    NEXT Z
                    Reds(Mchecker).Pst = Mpos
                    Reds(Mchecker).King = Mking
                    NumReds = NumReds + 1
                END IF
                Blacks(A1).Pst = Last
            NEXT B
        NEXT A1
        FOR A = 1 TO NumBlacks
            FOR B = 0 TO PosMovesS(A) - 1
                SWAP PosMapS(A, B), PosMap(A, B)
                SWAP TypS(A, B), Typ(A, B)
                SWAP MS(A, B), M(A, B)
            NEXT
            SWAP PosMovesS(A), Posmoves(A)
        NEXT
        FOR A = 1 TO NumReds
            FOR B = 0 TO PosMovesS1(A) - 1
                SWAP PosMapS1(A, B), PosMapR(A, B)
                SWAP TypS1(A, B), TypR(A, B)
                SWAP MS1(A, B), MR(A, B)
            NEXT
            SWAP PosMovesS1(A), PosMovesR(A)
        NEXT
    END IF
END SUB

'-----------------------------------------------------------------------------'
'Computers turn:
'Calculates points for each piece, select piece, and handles multiple and
'single jumps
'-----------------------------------------------------------------------------'
SUB ComputersTurn
    LOCATE 24, 14: PRINT "Thinking...";
    CalculatePoints
    IF NOT GiveUp THEN
        PickMove
        LOCATE 24, 1: PRINT SPACE$(70);
        EraseChecker Blacks(Piece).Pst
        Blacks(Piece).Pst = PosMap(Piece, Move)
       
        IF NOT Blacks(Piece).King AND (INT(Blacks(Piece).Pst / 4) * 4) = 28 THEN
            Blacks(Piece).King = True
        END IF
       
       
        PutChecker Blacks(Piece).Pst, False, Blacks(Piece).King
        IF Typ(Piece, Move) = Jmp THEN
            P = Piece
            DO
                SLEEP 1
                EraseChecker Blacks(P).Pst
                T = Scan(M(P, Move))
                EraseChecker M(P, Move)
                DeleteRed C: SOUND 1000, 6
                Blacks(0).Pst = PosMap(P, Move)
                Blacks(0).King = Blacks(P).King
                PutChecker Blacks(0).Pst, False, Blacks(0).King
                IF NOT Blacks(0).King AND (INT(Blacks(0).Pst / 4) * 4) = 28 THEN
                    Blacks(0).King = True
                    PutChecker Blacks(0).Pst, False, True
                END IF
                Allmoves 0, Black, True
                IF Posmoves(0) <> 0 THEN
                    P = 0
                    Move = INT(RND(1) * Posmoves(0))
                    PutChecker Blacks(P).Pst, False, Blacks(P).King
                END IF
            LOOP UNTIL Posmoves(0) = 0
            Blacks(Piece).Pst = Blacks(0).Pst
            Blacks(Piece).King = Blacks(0).King
            PutChecker Blacks(Piece).Pst, False, Blacks(Piece).King
            IF NOT Blacks(Piece).King AND (INT(Blacks(Piece).Pst / 4) * 4) = 28 THEN
                Blacks(Piece).King = True
                PutChecker Blacks(Piece).Pst, False, True
            END IF
        END IF
    END IF
END SUB

'-----------------------------------------------------------------------------
'Deletes a black piece from piece array
'-----------------------------------------------------------------------------'
SUB DeleteBlack (P)
    FOR A = P + 1 TO NumBlacks
        Blacks(A - 1).Pst = Blacks(A).Pst
        Blacks(A - 1).King = Blacks(A).King
    NEXT
    NumBlacks = NumBlacks - 1
END SUB

'-----------------------------------------------------------------------------'
'Deletes a red piece from array
'-----------------------------------------------------------------------------'
SUB DeleteRed (P)
    FOR A = P + 1 TO NumReds
        Reds(A - 1).Pst = Reds(A).Pst
        Reds(A - 1).King = Reds(A).King
    NEXT
    NumReds = NumReds - 1
END SUB

'-----------------------------------------------------------------------------
'Draws checker board on screen
'-----------------------------------------------------------------------------
SUB DrawBord
    X = 0
    Z = 0
    FOR R = 16 TO 156 STEP 20
        FOR C = 48 TO 244 STEP 28
            LINE (C, R)-(C + 28, R + 20), 1, B
            IF X = 0 THEN
                PAINT (C + 1, R + 1), 2, 1
                X = 1
            ELSE
                X = 0
            END IF
        NEXT
        IF X = 0 THEN
            X = 1
        ELSE
            X = 0
        END IF
    NEXT
    X = 76
    W = 244
    Y = 16
    FOR Q = 0 TO 31
        Xy(Q).X = X
        Xy(Q).Y = Y
        X = X + 56
        IF X > W THEN
            Y = Y + 20
            IF Z = 0 THEN
                X = 48
                W = 216
                Z = 1
            ELSE
                Z = 0
                X = 76
                W = 244
            END IF
        END IF
    NEXT
END SUB

'-----------------------------------------------------------------------------'
'Erases(graphically) a piece off selected block
'-----------------------------------------------------------------------------'
SUB EraseChecker (P)
    X = Xy(P).X
    Y = Xy(P).Y
    LINE (X + 1, Y + 1)-(X + 27, Y + 19), 0, BF
END SUB

'-----------------------------------------------------------------------------'
'Gets a key from keyboard(turns to uppercase)
'-----------------------------------------------------------------------------'
FUNCTION Getkey$
    DO
        K$ = INKEY$
    LOOP UNTIL K$ <> ""
    Getkey$ = UCASE$(K$)
END FUNCTION

'-----------------------------------------------------------------------------'
'Handles humans move:
'Selects piece
'handles jumps and multiple jumps
'-----------------------------------------------------------------------------'
SUB HumansMove
    DO
        LOCATE 24, 14: PRINT "Select Piece";
        DO
            IF In THEN
                A = SelectPiece(-1)
            ELSE
                A = Joystick(-1)
            END IF
            IF K$ = "Q" OR K$ = "q" THEN CLS : END
            A = Scan(A)
            IF A <> Null THEN
                C1 = C
                Allmoves C1, Red, False
            END IF
        LOOP WHILE A = Null OR A <> Red OR Posmoves(C1) = 0
        LOCATE 24, 1: PRINT SPACE$(70);
        LOCATE 24, 16: PRINT "To Where?"
        DO
            IF In THEN
                A = SelectPiece(Reds(C1).Pst)
            ELSE
                A = Joystick(Reds(C1).Pst)
            END IF
            Found = False
            FOR R = 0 TO Posmoves(C1) - 1
                IF PosMap(C1, R) = A THEN
                    Found = True
                    EXIT FOR
                END IF
            NEXT
        LOOP UNTIL Found OR K$ = "T" OR K$ = "t"
    LOOP WHILE K$ = "T" OR K$ = "t"
    LOCATE 24, 1: PRINT SPACE$(70);
    EraseChecker Reds(C1).Pst
    Reds(C1).Pst = PosMap(C1, R)
    IF NOT Reds(C1).King AND (INT(Reds(C1).Pst / 4) * 4) = 0 THEN
        Reds(C1).King = True
    END IF
    PutChecker PosMap(C1, R), True, Reds(C1).King
   
    IF Typ(C1, R) = Jmp THEN
        EraseChecker M(C1, R)
        T = Scan(M(C1, R))
        DeleteBlack C: SOUND 1000, 4
        DO
            PutChecker Reds(C1).Pst, True, Reds(C1).King
            Allmoves C1, Red, True
            IF Posmoves(C1) <> 0 THEN
                LOCATE 24, 11: PRINT "Continue Your Jump";
                IF In THEN
                    A = SelectPiece(Reds(C1).Pst)
                ELSE
                    A = Joystick(Reds(C1).Pst)
                END IF
                Found = False
                FOR R1 = 0 TO Posmoves(C1) - 1
                    IF PosMap(C1, R1) = A THEN
                        Found = True
                        EXIT FOR
                    END IF
                NEXT
                IF Found THEN
                    EraseChecker Reds(C1).Pst
                    Reds(C1).Pst = A
                    IF NOT Reds(C1).King AND (INT(Reds(C1).Pst / 4) * 4) = 0 THEN
                        Reds(C1).King = True
                    END IF
                    EraseChecker M(C1, R1)
                    T = Scan(M(C1, R1))
                    DeleteBlack C: SOUND 1000, 4
                END IF
            END IF
        LOOP UNTIL NOT Found OR Posmoves(C1) = 0
        LOCATE 24, 1: PRINT SPACE$(70);
    END IF
    PutChecker Reds(C1).Pst, True, Reds(C1).King
    IF NOT Reds(C1).King AND (INT(Reds(C1).Pst / 4) * 4) = 0 THEN
        Reds(C1).King = True
        PutChecker Reds(C1).Pst, True, True
    END IF
END SUB

'-----------------------------------------------------------------------------'
'Calculates and stores all possible human moves
'-----------------------------------------------------------------------------'
SUB HumansMoves
    FOR A = 1 TO NumReds
        Allmoves A, Reds, False
    NEXT
    FOR A = 1 TO NumReds
        FOR B = 0 TO Posmoves(A) - 1
            PosMapR(A, B) = PosMap(A, B)
            TypR(A, B) = Typ(A, B)
            MR(A, B) = M(A, B)
        NEXT
        PosMovesR(A) = Posmoves(A)
    NEXT
END SUB

'simple increment function(cuts typing time for long vars)
FUNCTION Increment (A)
    Increment = A + 1
END FUNCTION

'-----------------------------------------------------------------------------'
'Calculates if block is on bottom row
'-----------------------------------------------------------------------------'
FUNCTION IsBottom (P)
    IF P > 27 THEN
        IsBottom = True
    ELSE
        IsBottom = False
    END IF
END FUNCTION

'-----------------------------------------------------------------------------'
'Sees if block is on the left most row
'-----------------------------------------------------------------------------'
FUNCTION IsLeft (P)
    SELECT CASE P
    CASE 4, 12, 20, 28
        IsLeft = True
    CASE ELSE
        IsLeft = False
    END SELECT
END FUNCTION

'-----------------------------------------------------------------------------'
'Sees if block is on the rightmost row
'-----------------------------------------------------------------------------'
FUNCTION IsRight (P)
    SELECT CASE P
    CASE 3, 11, 19, 27
        IsRight = True
    CASE ELSE
        IsRight = False
    END SELECT
END FUNCTION

'-----------------------------------------------------------------------------'
'Sees if block is on the uppermost row
'-----------------------------------------------------------------------------'
FUNCTION IsTop (P)
    IF P < 4 THEN
        IsTop = True
    ELSE
        IsTop = False
    END IF
END FUNCTION

'-----------------------------------------------------------------------------
'Joystick routine(auto calibrating)
'-----------------------------------------------------------------------------'
FUNCTION Joystick (Flash)
    STATIC HighestX, HighestY, FirstTime
    STATIC Al, Bl
    DIM Tstart AS SINGLE
    IF FirstTime = 0 THEN
        FirstTime = -1
        HighestX = 1
        HighestY = 1
    END IF


    IF Flash <> -1 THEN
        GET (Xy(Flash).X, Xy(Flash).Y)-(Xy(Flash).X + 28, Xy(Flash).Y + 20), Ag
        Tstart = TIMER: Switch = 0
    END IF
    DO
        New = True
        PUT (Al, Bl), Aa
        DO
            Ax = STICK(0): Bx = STICK(1)
            IF Ax > HighestX THEN
                HighestX = Ax
            END IF
            IF Bx > HighestY THEN
                HighestY = Bx
            END IF
            A2 = INT(Ax * (314 / HighestX))
            B2 = INT(Bx * (194 / HighestY))
            A2 = Al + (A2 - Al) / 12: B2 = Bl + (B2 - Bl) / 12
            IF New OR Al <> A2 OR Bl <> B2 THEN
                New = False
                PUT (Al, Bl), Aa
                PUT (A2, B2), Aa: Al = A2: Bl = B2
            END IF
            IF Flash <> -1 AND TIMER - Tstart > .3 THEN
                Switch = (Switch + 1) MOD 2
                PUT (Al, Bl), Aa
                IF Switch = 1 THEN
                    PUT (Xy(Flash).X + 1, Xy(Flash).Y + 1), Bg, PSET
                ELSE
                    PUT (Xy(Flash).X, Xy(Flash).Y), Ag, PSET
                END IF
                PUT (Al, Bl), Aa
                Tstart = TIMER
            END IF
            K$ = INKEY$
            Selected = Bttn
        LOOP UNTIL Selected OR K$ <> ""
        PUT (Al, Bl), Aa
        IF Flash <> -1 THEN
            PUT (Xy(Flash).X, Xy(Flash).Y), Ag, PSET
        END IF
        IF Selected AND Bl >= 16 AND Bl <= 176 AND Al >= 48 AND Al <= 272 THEN
            Am = Al - 48
            Bm = Bl - 16
            Am = INT(Am / 28) * 28
            Bm = INT(Bm / 20) * 20
            Am = Am + 48
            Bm = Bm + 16
            SOUND 200, 1
            FOR A = 0 TO 31
                IF Xy(A).X = Am AND Xy(A).Y = Bm THEN
                    Good = True
                    EXIT FOR
                ELSE
                    Good = False
                END IF
            NEXT
        END IF
    LOOP UNTIL Good OR K$ = "T" OR K$ = "t" OR K$ = "q" OR K$ = "Q" OR K$ = " " OR K$ = CHR$(13)
    IF Good THEN
        Joystick = A
    END IF
END FUNCTION

'-----------------------------------------------------------------------------'
'Given two blocks, this sub returns the only way a jump can
'be performed(the Middle block is the piece thats being jumped, the start
'block is the starting point, and the number returned is the ending point)
'-----------------------------------------------------------------------------'
FUNCTION JumpWay (Start, Middle)
    S = INT(Start / 4) * 4
    M = INT(Middle / 4) * 4
    IF (M AND 4) = 4 THEN
        IF S < M THEN
            IF ABS(Middle - Start) = 5 THEN
                JumpWay = Middle + 4
            ELSE
                JumpWay = Middle + 3
            END IF
        ELSE
            IF ABS(Start - Middle) = 4 THEN
                JumpWay = Middle - 5
            ELSE
                JumpWay = Middle - 4
            END IF
        END IF
    ELSE
        IF S < M THEN
            IF ABS(Middle - Start) = 3 THEN
                JumpWay = Middle + 4
            ELSE
                JumpWay = Middle + 5
            END IF
        ELSE
            IF ABS(Start - Middle) = 5 THEN
                JumpWay = Middle - 4
            ELSE
                JumpWay = Middle - 3
            END IF
        END IF
    END IF
END FUNCTION

'-----------------------------------------------------------------------------
'Looks at all of the pieces scores and find highest one. If there are two or
'more that have the same score, one at random is picked.
'-----------------------------------------------------------------------------'
SUB PickMove
    DIM Pick(60) AS M
    DIM Highest AS DOUBLE
    Picks = 0
    Highest = -32000
   
   
   
    FOR A = 1 TO NumBlacks
        FOR B = 0 TO Posmoves(A) - 1
            IF Pty(A, B) > Highest THEN
                Highest = Pty(A, B)
            END IF
        NEXT
    NEXT

   
    FOR A = 1 TO NumBlacks
        FOR B = 0 TO Posmoves(A) - 1
            IF Pty(A, B) = Highest THEN
                Pick(Picks).Pce = A
                Pick(Picks).Move = B
                Picks = Increment(Picks)
            END IF
        NEXT
    NEXT
    Rand = INT(RND(1) * Picks)
    Piece = Pick(Rand).Pce
    Move = Pick(Rand).Move
   
    FOR A = 1 TO 12
        IF Mem(A, Piece, Move) THEN
            Used(A) = Used(A) + 1
        ELSE
            NotUsed(A) = NotUsed(A) + 1
        END IF
    NEXT


END SUB

'-----------------------------------------------------------------------------'
'Prepare array of both players pieces
'-----------------------------------------------------------------------------'
SUB PreparePieces
    NumReds = 12
    NumBlacks = 12
   
    FOR A = 0 TO 11
        Blacks(A + 1).Pst = A
        Blacks(A + 1).King = Game
    NEXT
    FOR A = 20 TO 31
        Reds(A - 19).Pst = A
        Reds(A - 19).King = Game
    NEXT
END SUB

'-----------------------------------------------------------------------------'
'Puts a checker on the board(graphically)
'-----------------------------------------------------------------------------'
SUB PutChecker (P, Rd, King)
    X = Xy(P).X + 14
    Y = Xy(P).Y + 10
    CIRCLE (X, Y), 10, 1
    IF Rd THEN
        PAINT (X, Y), 2, 1
    END IF
    IF King THEN
        DRAW "C1BM" + STR$(X + 2) + "," + STR$(Y + 2) + "L8U6F4E2F2E4D6L8"
    END IF
END SUB

'-----------------------------------------------------------------------------'
'Tells if the position given contains a checker or not
'-----------------------------------------------------------------------------'
FUNCTION Scan (Position)
    FoundR = False
    FOR PN = 1 TO NumReds
        IF Reds(PN).Pst = Position THEN
            FoundR = True
            C = PN
            EXIT FOR
        END IF
    NEXT
    IF FoundR <> True THEN
        FoundB = False
        FOR PN = 1 TO NumBlacks
            IF Blacks(PN).Pst = Position THEN
                FoundB = True
                C = PN
                EXIT FOR
            END IF
        NEXT
    END IF
    IF FoundR THEN
        Scan = Red
    ELSEIF FoundB THEN
        Scan = Black
    ELSE
        Scan = Null
    END IF
END FUNCTION

'-----------------------------------------------------------------------------'
'Returns all surrounding blocks for a given piece in an array
'-----------------------------------------------------------------------------'
SUB ScanAround (Piece, C)
    SELECT CASE C
    CASE Red
        Position = Reds(Piece).Pst
    CASE Black
        Position = Blacks(Piece).Pst
    END SELECT
    TempNum = 0
    IF NOT IsTop(Position) THEN
        IF NOT IsLeft(Position) THEN
            TempPos(TempNum) = TopLeft(Position)
            TempNum = Increment(TempNum)
        END IF
        IF NOT IsRight(Position) THEN
            TempPos(TempNum) = TopRight(Position)
            TempNum = Increment(TempNum)
        END IF
    END IF
    IF NOT IsBottom(Position) THEN
        IF NOT IsLeft(Position) THEN
            TempPos(TempNum) = BottomLeft(Position)
            TempNum = Increment(TempNum)
        END IF
        IF NOT IsRight(Position) THEN
            TempPos(TempNum) = BottomRight(Position)
            TempNum = Increment(TempNum)
        END IF
    END IF
END SUB

'-----------------------------------------------------------------------------'
'Keyboard block select sub
'-----------------------------------------------------------------------------'
FUNCTION SelectPiece (Flash)
    STATIC LastChoice, FirstTime
    DIM Tstart AS SINGLE
    IF FirstTime = 0 THEN
        FirstTime = -1
        LastChoice = 22
    END IF

    IF Flash <> -1 THEN
        GET (Xy(Flash).X, Xy(Flash).Y)-(Xy(Flash).X + 28, Xy(Flash).Y + 20), Ag
        Tstart = TIMER: Switch = 0
    END IF
    DO
        X = Xy(LastChoice).X
        Y = Xy(LastChoice).Y
        DO
            LINE (X, Y)-(X + 28, Y + 20), 0, B
            IF Flash <> -1 AND TIMER - Tstart > .3 THEN
                Switch = (Switch + 1) MOD 2
                IF Switch = 1 THEN
                    PUT (Xy(Flash).X + 1, Xy(Flash).Y + 1), Bg, PSET
                ELSE
                    PUT (Xy(Flash).X, Xy(Flash).Y), Ag, PSET
                END IF
                Tstart = TIMER
            END IF
            LINE (X, Y)-(X + 28, Y + 20), 1, B
            K$ = INKEY$
        LOOP UNTIL K$ <> ""
        SELECT CASE ASC(RIGHT$(K$, 1))
        CASE 75
            LastChoice = LastChoice - 1
            IF LastChoice < 0 THEN
                LastChoice = 31
            END IF
        CASE 77
            LastChoice = LastChoice + 1
            IF LastChoice > 31 THEN
                LastChoice = 0
            END IF
        CASE 13, 32
            SelectPiece = LastChoice
        END SELECT
    LOOP UNTIL K$ = "T" OR K$ = "t" OR K$ = "q" OR K$ = "Q" OR K$ = " " OR K$ = CHR$(13)
    IF Flash <> -1 THEN
        PUT (Xy(Flash).X, Xy(Flash).Y), Ag, PSET
    END IF
END FUNCTION

'-----------------------------------------------------------------------------'
'Stores all possible computers moves in array
'-----------------------------------------------------------------------------'
SUB TestComputersMoves
    FOR A = 1 TO NumBlacks
        Allmoves A, Black, False
    NEXT
END SUB

'-----------------------------------------------------------------------------DEFINT A-Z
'Tells if block on the upper left of given block
'-----------------------------------------------------------------------------'
FUNCTION TopLeft (Position)
    First = INT(Position / 4) * 4
    IF (First AND 4) = 0 THEN
        TopLeft = Position - 4
    ELSE
        TopLeft = Position - 5
    END IF
END FUNCTION

'-----------------------------------------------------------------------------'
'Gives block on the lower right of given block
'-----------------------------------------------------------------------------'
FUNCTION TopRight (Position)
    First = INT(Position / 4) * 4
    IF (First AND 4) = 0 THEN
        TopRight = Position - 3
    ELSE
        TopRight = Position - 4
    END IF
END FUNCTION

'-----------------------------------------------------------------------------'
'Puts pieces on board graphically
'-----------------------------------------------------------------------------
SUB update
    FOR A = 0 TO 31
        EraseChecker A
    NEXT
    FOR A = 1 TO NumReds
        PutChecker Reds(A).Pst, True, Reds(A).King
    NEXT
    FOR A = 1 TO NumBlacks
        PutChecker Blacks(A).Pst, False, Blacks(A).King
    NEXT
END SUB

