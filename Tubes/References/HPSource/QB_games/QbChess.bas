'============================================================================
' Program: Warlord x.1 a one ply chess program
' Saved as LORDX1.BAS
' Written by: Wm.H.Rogers               Email at: wrogers824@aol.com
' See the end of the program for additional comments... B.R.
' In this program the computer is not aggressive in taking pieces that are
' available but will run away first.
'============================================================================
  DEFINT A-Z                            'makes everything run faster
  KEY OFF                               'erase bottom line
  COLOR 0, 3                            'set Initializeial color
  CLS                                   'clear the screen
  DIM ChessBoard(120), Index(19), CentControl(120), Capture(6) 'needed arrays
  DIM A$(16), B$(13)                    'needed arrays for graphics
  GOTO Initialize                       'go Initializeialize the game
'------------------- In check subroutine ------------------------------------
Incheck:                                'first we find our king
  FOR I = 21 TO 98                      'search squares
    IF ChessBoard(I) * Side = King THEN K = I 'if king is there save it in K
  NEXT                                  'next square
'------------------- Attackers and defenders --------------------------------
Attackers:
  Check = True                          'set incheck flag to check
  R = K                                 'put king position in R
'------------------- Look for checking by pawns -----------------------------
  IF ChessBoard(R + 9 * L) * Side = -Pawn GOTO IC4'if in check by pawn exit
  IF ChessBoard(R + 11 * L) * Side = -Pawn GOTO IC4'if in check by pawn exit
'------------------- Look for checking by knights ---------------------------
  FOR I = 9 TO 16                       'directions for knights
    K = R                               'restore king's position
    K = K + Index(I)                    'get knights position
    IF ChessBoard(K) * Side = -Knight GOTO IC4 'if in check by knight exit
  NEXT I                                'next position
  K = R                                 'restore king's position
'------------------- Look for checking by bishops ---------------------------
  FOR I = 1 TO 4                        'directions for bishops
    FOR J = 1 TO 7                      'steps in each direction
      K = K + Index(I)                  'get bishops position
      IF ChessBoard(K) = 99 THEN        'is position off the board
        J = 7                           'end steps in this direction
        GOTO IC1                        'try next direction
      END IF
      IF ChessBoard(K) * Side > 0 THEN  'is color of man computer's
        J = 7                           'end step in this direction
        GOTO IC1                        'try next direction
      END IF
      IF ChessBoard(K) * Side = -Bishop GOTO IC4 'if in check by bishop exit
      IF ChessBoard(K) * Side < 0 THEN  'is position another enemy ?
        J = 7                           'end step in this direction
     END IF
IC1:
    NEXT J                              'next step
    K = R                               'reset king's position
  NEXT I                                'next direction
  K = R                                 'reset king's position
'-------------------- Look for checking by rooks ----------------------------
  FOR I = 5 TO 8                        'directions for rooks
    FOR J = 1 TO 7                      'steps in each direction
      K = K + Index(I)                  'get rook's position
      IF ChessBoard(K) = 99 THEN        'is position off the board
        J = 7                           'end step in this direction
        GOTO IC2                        'try next direction
      END IF
      IF ChessBoard(K) * Side > 0 THEN  'is color of man computer's
        J = 7                           'end steps in this direction
        GOTO IC2                        'try next direction
      END IF
      IF ChessBoard(K) * Side = -Rook GOTO IC4 'if in check by rook exit
      IF ChessBoard(K) * Side < 0 THEN  'is position another enemy?
        J = 7
      END IF
IC2:
    NEXT J                              'next step
    K = R                               'reset king's position
  NEXT I                                'next direction
  K = R                                 'reset king's position
'-------------------- Look for checking by queen ----------------------------
  FOR I = 1 TO 8                        'directions for queen's
    FOR J = 1 TO 7                      'step in each direction
      K = K + Index(I)                  'get queen's position
      IF ChessBoard(K) = 99 THEN        'is position off the board
        J = 7                           'end step in this direction
        GOTO IC3                        'try next direction
      END IF
      IF ChessBoard(K) * Side > 0 THEN  'is color of man computers
        J = 7                           'end steps in this direction
        GOTO IC3                        'try next direction
      END IF
      IF ChessBoard(K) * Side = -Queen GOTO IC4 'in check by queen ?
      IF ChessBoard(K) * Side < 0 THEN  'is position another enemy ?
        J = 7                           'end steps in this direction
      END IF
IC3:
    NEXT J                              'next step
    K = R                               'reset king's position
  NEXT I                                'next direction
  K = R                                 'reset king's position
'-------------------- Look for checking by king -----------------------------
  FOR I = 1 TO 8                        'directions for kings
    K = R                               'reset king's position
    K = K + Index(I)                    'get position
    IF ChessBoard(K) * Side = -King GOTO IC4 'in check by enemy king exit
  NEXT                                  'next direction
  Check = False                         'if here we are not in check
IC4:
  RETURN                                'end of incheck subroutine
'-------------------- Evaluation Subroutine ---------------------------------
Evaluate:
  GOSUB Incheck                         'gosub king in check
  IF Check = True THEN RETURN           'if king is in check we can't move
  F = Sqrs: T = C                       'save computer's from-to position
  GOSUB GetFromPos                      'get ascii from coordinates
  GOSUB GetToPos                        'get ascii to coordinates
  LOCATE 3, 61                          'print position of current move
  PRINT E$;                             'print from-to of man being moved
'-------------------- From here we get position control ---------------------
  Points = CentControl(C)               'points for center control
'-------------------- Developement stratagies if out of book ----------------
'----- on the first move. This came before I learned how to make books.------
IF M > 1 THEN GOTO Ev1                  'out of book 1st move
  IF C = 64 THEN Points = Points + 5    'points for center squares
  IF C = 65 THEN Points = Points + 5    'points for center squares
Ev1:
  IF M > 9 THEN GOTO Ev2                'if move > 9 skip development points
  IF Sqrs > 90 THEN Points = Points + 20 'push back row for developement
  IF P = Knight THEN Points = Points + 3 'push knights points
  IF P = Rook AND CC$ = "Y" THEN        'if man is a rook and we have not
    Points = Points - 5                 'castled yet - penalize
  END IF
  IF P = Queen THEN Points = Points - 2 'don't move queen in early game
'-------------------- Develope pawn structures ------------------------------
Ev2:
IF P <> Pawn THEN GOTO Ev3              'if not pawn skip
  Points = Points + 2                   'points for moving pawns
  IF ChessBoard(C - 11) = Side * Pawn THEN 'build pawn chains
    Points = Points + 5
  END IF
  IF ChessBoard(C - 9) = Side * Pawn THEN 'build pawn chains
    Points = Points + 5
  END IF
  IF ChessBoard(C + 9) = Side * Pawn THEN 'build pawn chains
    Points = Points + 5
  END IF
  IF ChessBoard(C + 11) = Side * Pawn THEN 'build pawn chains
    Points = Points + 5
  END IF
'-------------------- Don't move king pawns ---------------------------------
  IF ChessBoard(Sqrs - 9) = Side * King THEN 'if pawn by our king don't move
    Points = Points - 5
  END IF
  IF ChessBoard(Sqrs - 10) = Side * King THEN 'if pawn by our king don't move
    Points = Points - 10
  END IF
  IF ChessBoard(Sqrs - 11) = Side * King THEN 'if pawn by our king don't move
    Points = Points - 5
  END IF
  IF Sqrs = 31 THEN Points = Points + 5 'push outside edge pawns
  IF Sqrs = 38 THEN Points = Points + 5 'push outside edge pawns
'-------------------- Develope rooks ----------------------------------------
Ev3:
  IF P <> Rook THEN GOTO Ev6            'if not rook the skip
  IF C < 40 THEN Points = Points + 2    'points 4 rook in enemy territory
  FOR J = 5 TO 8                        'start directions for rooks
    I = C                               'set I to rooks position
Ev4:
    I = I + Index(J)                    'get new position for rook
    IF ChessBoard(I) = 0 THEN GOTO Ev4  'if empty get next position
    IF ChessBoard(I) = 99 THEN GOTO Ev5 'if off board get next direction
    IF ChessBoard(I) * Side < 0 THEN GOTO Ev5 'if enemy man get next direction
    IF ChessBoard(I) * Side <> Rook THEN GOTO Ev5 'if not rook next direction
    Points = Points + 10                'points for rook protecting rook
    J = 8                               'end of search directions
Ev5:
  NEXT J                                'get next direction
'-------------------- some extra logic --------------------------------------
Ev6:
  IF P = King THEN Points = Points - 2  'don't move king
  IF C = Z1 THEN Points = Points - 5    'don't move to last square again
  IF CK = 1 THEN Points = 250           'points for castling
'-------------------- Capture exchange evaluator ----------------------------
  Points = Points + Capture(ABS(E))     'enemy man captured points
  K = C:                                'set man on move incheck pos
  GOSUB Attackers                       'gosub incheck
  IF Check = False THEN GOTO Ev7        'if man not in check skip swapoff
  Points = Points - Capture(P)          'computer man captured
  ATT = ABS(ChessBoard(K))              'save enemy position of checking man
  K = C                                 'set man incheck pos
  Side = -Side                          'switch sides
  L = 1                                 'used for pawns
  GOSUB Attackers                       'see if man protected
  IF Check = True THEN
    Points = Points + C(ATT)            'recapture points
  END IF
  Side = -Side                          'switch sides back to normal
'---------- the next two functions are only used in a one ply game ----------
'------------------- See if enemy king is in check --------------------------
Ev7:
  Side = -Side                          'switch sides
  L = 1                                 'used for pawns
  GOSUB Incheck                         'see if enemy king is in check
  Side = -Side                          'switch sides again
  L = -1                                'used for pawns
  IF Check = True THEN                  'if in check the give points
    Points = Points + 10                'enemy king in check points
  END IF
'-------------------- See if our queen is in danger -------------------------
  IF P = Queen THEN GOTO Ev9            'if queen skip
  FOR I = 21 TO 99                      'search squares
   IF ChessBoard(I) * Side = Queen THEN K = I 'if found queen save position
  NEXT                                  'next square
 IF K < 99 THEN GOSUB Attackers         'if queen found see if incheck
 IF Check = True THEN Points = Points - 50'penalty for queen in danger
'-------------------- Final move selector based on scores -------------------
Ev9:
  LOCATE 3, 65                          'locate current move
  PRINT Points;                         'print score of current move
  IF Points >= Best THEN GOTO Ev10      'if best move so far save it
  LOCATE 3, 61                          'locate move display
  PRINT "         ";                    'erase it as it is not best
  RETURN                                'return to move generator
Ev10:                 
  FF = Sqrs                             'save best position from
  TT = C                                'save best position to
  Best = Points                         'save best score so far
  RETURN                                'return to move generator
'--------- Opening Book -----------------------------------------------
Books:
  Side = -Side                          'switch sides
  L = -1                                'switch pawn logic
  IF K$ = "W" THEN GOTO Bk1             'if computer is white skip
  M = M + 1                             'increment move counter
  LOCATE 16, 58                         'locate move location
  PRINT M; "         ";                 'print current move
Bk1:
  IF BI$ = "N" THEN GOTO GenMoves       'if no more books skip
  BK$ = "*"                             'set start flag for book moves
  N = 0                                 'set blank space counter
  FOR K = 20 TO 90 STEP 10              'scan chess board
    FOR J = 1 TO 8                      'scan chess board
      IF ChessBoard(K + J) = 0 THEN     'is square empty ?
        N = N + 1: GOTO Bk4             'count space
      END IF
      IF N = 0 THEN GOTO Bk2            'this means we found a man
      N$ = STR$(N)                      'store blank squares counter
      BK$ = BK$ + RIGHT$(N$, LEN(N$) - 1) 'put results in book string
      N = 0                             'reset space counter
Bk2:
      I = ChessBoard(K + J)             'get contents of square
      IF I < 0 THEN GOTO Bk3            'if black skip
      BK$ = BK$ + B$(I)                 'store white man in book string
      GOTO Bk4                          'try next step
Bk3:
      BK$ = BK$ + B$(I + 14)            'store black man in book string
Bk4:
    NEXT J                              'next step
  NEXT K                                'next direction
  N$ = STR$(M)                          'get move number
  BK$ = BK$ + "*" + RIGHT$(N$, LEN(N$) - 1) 'set end flag & store move number
Bk5:
  READ D$                               'read book data
  IF D$ = "END" THEN                    'if we are at the end
    BI$ = "N"                           'the set books to "N"o more
    GOTO GenMoves                       'out of book so goto to genmoves
  END IF
  D1$ = LEFT$(D$, 1)                    'read data
  IF D1$ <> "*" THEN GOTO Bk5           'our books start with a "*"
  IF BK$ <> D$ THEN GOTO Bk5            'compare with boardscan
4100 TP = 0                             'will hold book optional move %
4101 RD = (RNIndex(1) * 100)            'generate a random number
Bk6:
  READ D$, N$                           'get next data
  D1$ = LEFT$(N$, 1)                    'check left side
  IF D1$ = "*" THEN GOTO Bk7            'if "*" then goto execute
  IF N$ = "END" THEN GOTO Bk7           'if "end" goto execute
  PC = VAL(N$)                          'save optinal percent number
  TP = TP + PC                          'add it to TP
  IF RD > TP THEN GOTO Bk6              'is random > our number - try again
Bk7:
  X1$ = RIGHT$(D$, 4)                   'used to convert to numbers that
  X1 = ASC(X1$) - 64                    'the computer can use to make
  Y1$ = RIGHT$(D$, 3)                   'the required move indicated by
  Y1 = ASC(Y1$) - 48                    'our opening book data
  X2$ = RIGHT$(D$, 2)
  X2 = ASC(X2$) - 64
  Y2$ = RIGHT$(D$, 1)
  Y2 = ASC(Y2$) - 48
  IF Side = White THEN                  'convert for white moves
    X1 = 9 - X1
    Y1 = 9 - Y1
    X2 = 9 - X2
    Y2 = 9 - Y2
  END IF
  F = 10 * Y1 + 10 + X1                 'convert to from to format
  T = 10 * Y2 + 10 + X2
  LOCATE 3, 61                          '
  PRINT "Book";                         'print move on top of screen
  GOTO Ex6                              'goto execute moves
'--------- Move Generator ----------------------------------------------
GenMoves:
  MC = 0                                'set move counter to zero
  FOR Sqrs = 21 TO 98                   'start move square search
    IF ChessBoard(Sqrs) = 0 THEN GOTO Gm12 'if square is empty next square
    IF ChessBoard(Sqrs) = 99 THEN GOTO Gm12 'if square is off board next square
    IF ChessBoard(Sqrs) * Side < 0 THEN GOTO Gm12 'if it is not our man next square
    P1 = ChessBoard(Sqrs)               'save piece
    ChessBoard(Sqrs) = 0                'remove piece from board
    C = Sqrs                            'save current square
    P = ABS(P1)                         'get absolute value of man
    W = From(P)                         'get starting move direction
    X2 = Too(P)                         'get ending move direction
    Z = Steps(P)                        'get steps in each direction
    IF P = Pawn THEN GOTO Gm3           'if piece is a pawn goto pawn moves
    FOR D = W TO X2                     'get first direction
      FOR N = 1 TO Z                    'get first step
        C = C + Index(D)                'look at new square
        IF ChessBoard(C) = 99 THEN GOTO Gm2 'if off the board get next direction
        IF ChessBoard(C) * Side > 0 THEN GOTO Gm2 'if our man is there get next direction
        IF ChessBoard(C) = 0 THEN GOTO Gm1 'if square is empty goto make move
        IF ChessBoard(C) * Side < 0 THEN N = Z 'if square is enemy man no more steps
Gm1:
        E = ChessBoard(C)               'save contents of new square
        ChessBoard(C) = P1              'put computer man there
        GOSUB Evaluate                  'gosub incheck and evaluate move
        ChessBoard(C) = E               'restore squares original contents
      NEXT N                            'try next direction
Gm2:
      C = Sqrs                          'restore pieces original position
    NEXT D                              'try next direction
    IF P <> King THEN GOTO Gm11         'if not king then skip
'-------------------- Castling checker for computer -------------------------
    IF CC$ = "N" THEN GOTO Gm11         'if Comp can not castle then skip
    ChessBoard(Sqrs) = P1               'get king's position
    GOSUB Incheck                       'see if king is in check
    IF Check = True THEN GOTO Gm11      'if he is we can not castle
    IF Side = White THEN GOTO Cc2       'go to white side castle
'-------------------- Black castling testing --------------------------------
    IF CR$ = "N" THEN GOTO Cc1          'if castle right = N try left
'-------------------- Black castle right test -------------------------------
    IF ChessBoard(96) <> 0 THEN GOTO Cc1 'if not empty try other side
    IF ChessBoard(97) <> 0 THEN GOTO Cc1 'if not empty try other side
    K = 96                              'set square's position
    GOSUB Attackers                     'see if square is attacked
    IF Check = True THEN GOTO Cc1       'square is attacked so no castle
    K = 97                              'set square's position
    GOSUB Attackers                     'see if square is attacked
    IF Check = True THEN GOTO Cc1       'square is attacked so no castle
    CK = 1                              'set castling flag for evaluation
    Sqrs = 95                           'set move from
    C = 97                              'set move to
    GOSUB Evaluate                      'evaluate and put in move list
    CK = 0                              'reset castling flag
    GOTO Gm11                           'goto next move
'-------------------- Black castle left test --------------------------------
Cc1:
   IF ChessBoard(92) <> 0 THEN GOTO Gm11 'if not empty goto next move
   IF ChessBoard(93) <> 0 THEN GOTO Gm11 'if not empty goto next move
   IF ChessBoard(94) <> 0 THEN GOTO Gm11 'if not empty goto next move
   K = 92                               'set square's position
   GOSUB Attackers                      'see if square is attacked
   IF Check = True THEN GOTO Gm11       'if incheck goto next move
   K = 93                               'set square's position
   GOSUB Attackers                      'see if square is attacked
   IF Check = True THEN GOTO Gm11       'if incheck goto next move
   K = 94                               'set square's position
   GOSUB Attackers                      'see if square is attacked
   IF Check = True THEN GOTO Gm11       'if incheck goto next move
   CK = 1                               'set castling flag for evaluation
   Sqrs = 95                            'set move from
   C = 93                               'set move to
   GOSUB Evaluate                       'evaluate and put in move list
   CK = 0                               'reset castle flag
   GOTO Gm11                            'goto next move
'-------------------- White castle right test -------------------------------
Cc2:
   IF CR$ = "N" THEN GOTO Cc3           'if we can't castle right go left
   IF ChessBoard(95) <> 0 THEN GOTO Cc3 'if square not empty try left
   IF ChessBoard(96) <> 0 THEN GOTO Cc2 'if square not empty try left
   IF ChessBoard(97) <> 0 THEN GOTO Cc3 'if square not empty try left
   K = 95                               'set square's position
   GOSUB Attackers                      'see if square is attacked
   IF Check = True THEN GOTO Cc3        'if attacked then try left
   K = 96                               'set square's position
   GOSUB Attackers                      'see if square is attacked
   IF Check = True THEN GOTO Cc3        'if attacked then try left
   K = 97                               'set square's position
   GOSUB Attackers                      'see if square is attacked
   IF Check = True THEN GOTO Cc3        'if attacked then try left
   CK = 1                               'set castling flag for evaluation
   Sqrs = 94                            'set move from
   C = 96                               'set move to
   GOSUB Evaluate                       'evaluate and put in move list
   CK = 0                               'reset castle flag
   GOTO Gm11                            'goto next move
'-------------------- White castle left test --------------------------------
Cc3:
   IF ChessBoard(93) <> 0 THEN GOTO Gm11 'if not empty goto next move
   IF ChessBoard(92) <> 0 THEN GOTO Gm11 'if not empty goto next move
   K = 93                               'set square's position
   GOSUB Attackers                      'see if square is attacked
   IF Check = True THEN GOTO Gm11       'if attacked goto next move
   K = 92                               'set square's position
   GOSUB Attackers                      'see if square is attacked
   IF Check = True THEN GOTO Gm11       'if attacked goto next move
   CK = 1                               'set castling flag for evaluation
   Sqrs = 94                            'set move from
   C = 92                               'set move to
   GOSUB Evaluate                       'evaluate and put in move list
   CK = 0                               'reset castle flag
   GOTO Gm11                            'goto next move
'------------------- Pawn move generator ------------------------------------
Gm3:                                    'try capture moves first
   D = W                                'get first direction
   FOR N = 1 TO 2                       'get step
     C = C + Index(D)                   'get new square
     IF ChessBoard(C) = 99 THEN GOTO Gm8 'if off board next direction
     IF ChessBoard(C) * Side > 0 THEN GOTO Gm8 'if our man there next move
     IF C <> HP THEN GOTO Gm4           'if square not "ep" skip
     IF ChessBoard(HP + 10) = Side * -Pawn THEN
       EP = HP + 10                     'save enpassant square
       E = ChessBoard(EP)               'get contents of square
       ChessBoard(EP) = 0               'set square to empty
       ChessBoard(C) = P1               'place our pawn
       GOSUB Evaluate                   'evaluate move
       ChessBoard(C) = 0                'reset chess board
       ChessBoard(EP) = E               'put enpassant pawn back
       ELSE GOTO Gm4                    'if not legal goto next move
     END IF
Gm4:
     IF ChessBoard(C) = 0 THEN GOTO Gm8 'if square empty next direction
Gm5:
     IF C > 30 THEN
       GOTO Gm8                         'if moving to king row make a queen
       E = ChessBoard(C)                'save board contents
       ChessBoard(C) = Side * Queen     'put a new queen there
       GOSUB Evaluate                   'evauluate move
       ChessBoard(C) = E                'restore board contents
       GOTO Gm8                         'goto next move
     END IF
'-------------------- Make regular moves here -------------------------------
     E = ChessBoard(C)                  'save board contents
     ChessBoard(C) = P1                 'put our man there
     GOSUB Evaluate                     'evauluate move
     ChessBoard(C) = E                  'restore board contents
Gm8:
     C = Sqrs                           'reset to original position
     D = D + 1                          'change to next direction
   NEXT N                               'make next move
'---------- now we try regular moves ----------------------------------------
   FOR N = 1 TO 2                       'start direction loop
     C = C + Index(D)                   'get first direction
     IF ChessBoard(C) <> 0 THEN         'if is not empty then
       N = 2                            'no more moves in this direction
       GOTO Gm10                        'try next direction
     END IF
     IF C < 30 THEN                     'if moving to king row make a queen
       E = ChessBoard(C)                'save board contents
       ChessBoard(C) = Side * Queen     'put a new queen there
       GOSUB Evaluate                   'evauluate move
       ChessBoard(C) = E                'restore board contents
       GOTO Gm11                        'get next direction
     END IF
Gm9:
       E = ChessBoard(C)                'save board contents
       ChessBoard(C) = P1               'put our man there
       GOSUB Evaluate                   'evauluate move
       ChessBoard(C) = E                'restore board contents
       IF Sqrs < 80 THEN N = 2          'if not on back no double moves
Gm10:
   NEXT N                               'next direction
Gm11:
   ChessBoard(Sqrs) = P1                'put man back on main board
Gm12:
  NEXT Sqrs                             'make next computer move
'---------- EXECUTE MOVES  --------------------------------------------------
  IF Best = -400 THEN                   'if Best score is still -400
    LOCATE 17, 60                       'then we are still in check and
    PRINT "CHECKMATE!": END             'can't move so resign.
    ELSEIF Best = -200 THEN             'if Best score is still -200
          LOCATE 17, 60                 'we are not in check but can't move
          PRINT "STALEMATE!": END       'so we resign.
  END IF
  F = FF: T = TT                        'save From - To
  Z1 = F: CP = 0                        'save from & set comp pawn to 0
'-------------------- Check pawn moves first --------------------------------
  IF ABS(ChessBoard(F)) > Pawn THEN GOTO Ex2 'if not pawn skip
  IF T < 30 THEN QP = 1: GOTO Ex6       'if in last square promote to queen
  IF F - 20 <> T THEN GOTO Ex1          'if not double move then skip
  CP = F + (T - F) / 2                  'save computer enpassant square
  GOTO Ex6                              'goto execute move
Ex1:                                    'the rest of pawn moves
  IF T <> HP THEN GOTO Ex6              'if not human enpassant square skip
  IF ChessBoard(T + 10) * Side = -Pawn THEN 'if human pawn then
    EP = HP + 10                        'we capture enpassant
  END IF
  GOSUB WholeMove                       'move computer's pawn
  D$ = E$                               'save ascii move
  F = EP                                'get human's pawns position
  GOSUB HalfMove                        'blank humans pawn square
  ChessBoard(EP) = 0                    'remove it from the board
  GOTO Ex7                              'goto reset board and human move
'-------------------- Check for rooks move ----------------------------------
Ex2:                   
  IF ABS(ChessBoard(F)) <> Rook THEN GOTO Ex3 'if man not a rook skip
  IF F = 91 THEN CL$ = "N": GOTO Ex6    'if rook move we can not castle left
  IF F = 98 THEN CR$ = "N": GOTO Ex6    'if rook move we can not castle right
'-------------------- Check for king move -----------------------------------
Ex3:
  IF ABS(ChessBoard(F)) <> King THEN GOTO Ex6 'if not a king then skip
  IF F + 2 = T THEN GOTO Ex4            'see if we are castling right
  IF F - 2 = T THEN GOTO Ex4            'see if we are castling left
  CC$ = "N"                             'so set castle flag to NO
  GOTO Ex6                              'goto execute regular king move
Ex4:
  GOSUB WholeMove                       'move king first for castling
  D$ = E$                               'save ascii move
  IF Side = White THEN GOTO Ex5         'if not white goto black
'-------------------- Make black rooks move ---------------------------------
  IF F + 2 = T THEN                     'if castling right then
    F = 98: T = 96                      'save from-to squares
    CC$ = "N"                           'set castle flag to NO
    GOSUB WholeMove                     'make rook's castling move
    GOTO Ex7                            'goto finish
  END IF
  IF F - 2 = T THEN                     'if castling left then
    F = 91: T = 94                      'save from-to squares
    CC$ = "N"                           'set castle flag to NO
    GOSUB WholeMove                     'make rook's castling move
    GOTO Ex7                            'goto finish
  END IF
'-------------------- Make white rooks move ---------------------------------
Ex5:                          
  IF F + 2 = T THEN                     'if castling right then
    F = 98: T = 95                      'save from-to squares
    CC$ = "N"                           'set castle flag to NO
    GOSUB WholeMove                     'make rook's castling move
    GOTO Ex7                            'goto finish
  END IF
  IF F - 2 = T THEN                     'if castling left then
    F = 91: T = 93                      'save from-to squares
    CC$ = "N"                           'set castle flag to NO
    GOSUB WholeMove                     'make rook's castling move
    GOTO Ex7                            'goto finish
  END IF
Ex6:
  GOSUB WholeMove                       'make regular move
  D$ = E$                               'save ascii move
Ex7:
  Side = -Side                          'switch sides
  L = 1                                 'switch pawn logic
  GOSUB Incheck                         'see if enemy king is in check
  LOCATE 17, 60                         'set message location
  IF Check = True THEN                  'if enemy in check then
    PRINT "CHECK!";                     'print message
    ELSE PRINT "      ";                'else erase message area
  END IF
  IF K$ = "W" THEN                      'if it is white's turn then print
    LOCATE 15, 58                       'move number,white's move and
    PRINT M; A$; ","; D$;               'print black's move on higest
    LOCATE 13, 60                       'location and tell human that
    PRINT "Your-Move";                  'it is his turm
    GOTO HumanInput                     'goto human input
  END IF
  LOCATE 16, 58:                        'if we are white then print
  PRINT M; D$; ",";                     'move number and our move
  LOCATE 13, 60
  PRINT "Your-Move";                    'tell opponent it is his turn
'--------------------- Human input -----------------------------------
HumanInput:
  L = 1                                 'set pawn logic switch
  G = 58                                'set graphic print @ location
  IF K$ = "W" THEN                      'if human is white then
    M = M + 1                           'increment move game move counter
    LOCATE 16, G                        'print move number and clear
    PRINT M; "        ";                'old area of moves on screen
  END IF
Hu1:
  IF K$ = "B" THEN                      'if human is black then
    G = 63
    LOCATE 16, G + 3
    PRINT "    ";                       'clear his input area
  END IF
  LOCATE 17, 60: PRINT "       ";       'clear check message area
  A$ = ""                               'set move input string to null
  O = 0                                 'set input counter to 0
Hu2:
  IF O = 0 THEN LOCATE 16, G + 3: PRINT "     "
  B$ = INKEY$                           'get input
  IF B$ = "" OR B$ = CHR$(13) THEN GOTO Hu2
  A$ = A$ + B$                          'add input to A$
  O = O + 1                             'increment input counter
  IF A$ = "S" THEN GOTO SaveGame        'if input = S then save game
  IF A$ = "L" THEN GOTO LoadGame        'if input = L then load game
  IF A$ = "Q" THEN END                  'if input = Q then quit
  LOCATE 16, G + 3: IF M > 9 THEN LOCATE 16, G + 4
  PRINT A$;           'print move on screen
  IF O < 4 THEN GOTO Hu2                'if less than 4 characters get more
  X1$ = RIGHT$(A$, 4): X1 = ASC(X1$) - 64 'convert to real numbers
  Y1$ = RIGHT$(A$, 3): Y1 = ASC(Y1$) - 48 'convert to real numbers
  X2$ = RIGHT$(A$, 2): X2 = ASC(X2$) - 64 'convert to real numbers
  Y2$ = RIGHT$(A$, 1): Y2 = ASC(Y2$) - 48 'convert to real numbers
  IF X1 < 1 OR X1 > 8 OR Y1 < 1 OR Y1 > 8 THEN GOTO Hu1 'bad input
  IF X2 < 1 OR X2 > 8 OR Y2 < 1 OR Y2 > 8 THEN GOTO Hu1 'bad input
  IF Side = Black THEN
    X1 = 9 - X1                         'change cooridinates for black
    Y1 = 9 - Y1                         '
    X2 = 9 - X2                         '
    Y2 = 9 - Y2                         '
  END IF
  F = 10 * Y1 + 10 + X1                 'change to board locations
  T = 10 * Y2 + 10 + X2                 '
  IF Side * ChessBoard(F) <= 0 THEN GOTO Hu1 'if empty square get new input
  IF Side * ChessBoard(T) > 0 THEN GOTO Hu1 'if enemy man get new input
  Sqrs = F: C = Sqrs                    'save move coordinates
  Legal$ = "Y"                          'set legal string to Yes
  P1 = ChessBoard(Sqrs)                 'get type man from chessboard
  ChessBoard(Sqrs) = 0                  'set location to 0
  P = ABS(P1)                           'save abs man type
  W = From(P): X2 = Too(P): Z = Steps(P) 'get index to moves
  IF P = Pawn THEN GOTO Hu6             'if man is a pawn goto pawn logic
  FOR D = W TO X2                       'increment directions
    FOR N = 1 TO Z                      'increment steps in direction
      C = C + Index(D)                  'increment move
      IF ChessBoard(C) = 99 THEN GOTO Hu5 'if off board get next direction
      IF ChessBoard(C) * Side > 0 THEN GOTO Hu5 'if enemy man next direction
      IF ChessBoard(C) = 0 THEN GOTO Hu3 'if square is empty try it
      IF ChessBoard(C) * Side < 0 THEN N = Z 'if his own man there next move
Hu3:
      IF C <> T THEN GOTO Hu4           'if this is not his move next step
      E = ChessBoard(C)                 'save contents of square
      ChessBoard(C) = P1                'put his man there
      GOSUB Incheck                     'see if he is in check
      ChessBoard(C) = E                 'reset board contents
      IF Check = False THEN GOTO Hu10   'if not in check goto make move
Hu4:
    NEXT N                              'next step
Hu5:
    C = Sqrs                            'reset to initial move position
  NEXT D                                'goto next direction
  IF P = King AND HC$ = "Y" THEN GOTO Hu11
'--------------- If we get to the next line the move was not found ----------
  GOTO Hu9                              'goto illegal flag
'-------------------- Pawn move checking starts here ------------------------
Hu6:
  FOR D = W TO W + 1                    'set direction index
    C = C + Index(D) * -1               'try capture move
    IF ChessBoard(C) = 99 THEN GOTO Hu7 'if off board get next direction
    IF ChessBoard(C) * Side > 0 THEN GOTO Hu7 'if his man is there next
    IF C = CP THEN GOTO Hu10            'human is capturing enpassant
    IF ChessBoard(C) = 0 THEN GOTO Hu7  'if square is empty try next direction
    IF C = T THEN GOTO Hu10             'if this is his move make it
Hu7:
    C = Sqrs                            'reset original position
  NEXT D                                'next direction
  FOR N = 1 TO 2                        'increment move counter
    C = C + Index(D) * -1               'try forward moves
    IF ChessBoard(C) <> 0 THEN          'if square not empty then
      N = 2                             'no more moves in this direction
      GOTO Hu8                          'try next step
    END IF
    IF C = T THEN GOTO Hu10             'if this is his move make it
    IF Sqrs > 40 THEN N = 2             'not on original square no double moves
Hu8:
  NEXT N                                'next step
Hu9:                               
  Legal$ = "N"                          'set legal move flag to No
Hu10:
  ChessBoard(Sqrs) = P1                 'put man back on chessboard
  IF Legal$ = "N" THEN                  'if not a legal move
    LOCATE 17, 60: PRINT "Illegal";     'print message and
    GOTO Hu1                            'goto back to human input
    ELSE GOTO Hu13                      'goto execute human moves
  END IF
Hu11:
  IF F + 2 = T THEN GOTO Hu12           'castling right
  IF F - 2 <> T THEN GOTO Hu9           'if not castling left then error
  IF HL$ = "N" THEN GOTO Hu9
  IF ChessBoard(22) <> 0 THEN GOTO Hu9
  IF ChessBoard(23) <> 0 THEN GOTO Hu9
  K = 22
  GOSUB Attackers
  IF Check = True THEN GOTO Hu9
  K = 23
  GOSUB Attackers
  IF Check = True THEN GOTO Hu9
  IF F = 24 THEN GOTO Hu10
  IF ChessBoard(24) <> 0 THEN GOTO Hu9
  K = 24
  GOSUB Attackers
  IF Check = True THEN GOTO Hu9
  GOTO Hu10

Hu12:
  IF HR$ = "N" THEN GOTO Hu9
  IF ChessBoard(26) <> 0 THEN GOTO Hu9
  IF ChessBoard(27) <> 0 THEN GOTO Hu9
   K = 26
   GOSUB Attackers
   IF Check = True THEN GOTO Hu9
   K = 27
   GOSUB Attackers
   IF Check = True THEN GOTO Hu9
   IF F = 25 THEN GOTO Hu10
   IF ChessBoard(25) <> 0 THEN GOTO Hu9
   K = 25
   GOSUB Attackers
   IF Check = True THEN GOTO Hu9
   GOTO Hu10
'-------------------- Human execute moves start here ------------------------
Hu13:
  HP = 0
  IF ABS(ChessBoard(F)) > Pawn THEN GOTO Hu15
  IF T > 90 THEN QP = Pawn: GOTO Hu20
  IF F + 20 <> T THEN GOTO Hu14
  HP = F + (T - F) / 2
  GOTO Hu20

Hu14:
  IF T <> CP THEN GOTO Hu20
  IF ChessBoard(T - 10) * Side = -Pawn THEN EP = CP - 10
  GOSUB WholeMove
  F = EP
  GOSUB HalfMove
  ChessBoard(EP) = 0
  GOTO Hu21
Hu15:
  IF ABS(ChessBoard(F)) <> Rook THEN GOTO Hu16
  IF F = 21 THEN HL$ = "N": GOTO Hu20
  IF F = 28 THEN HR$ = "N"
Hu16:
  IF ABS(ChessBoard(F)) <> King THEN GOTO Hu20
  IF F + 2 = T THEN GOTO Hu17
  IF F - 2 = T THEN GOTO Hu18
  GOTO Hu19
Hu17:
  GOSUB WholeMove
  IF F = 25 THEN F = 28: T = 26: GOTO Hu19
  F = 28: T = 25
  GOTO Hu19
Hu18:
  GOSUB WholeMove
  IF F = 24 THEN F = 21: T = 23: GOTO Hu19
  F = 21: T = 24

Hu19:
  HC$ = "N"
  HL$ = "N"
  HR$ = "N"
Hu20:
  GOSUB GetFromPos
  GOSUB MoveFromPos
  GOSUB GetToPos
  GOSUB MoveToPos


Hu21:
  Side = -Side
  L = -1
  GOSUB Incheck
  IF Check = True THEN Best = -400 ELSE Best = -200
  Side = -Side
  LOCATE 13, 60
  PRINT "         ";
  IF K$ = "B" THEN LOCATE 15, 58: PRINT M; D$; ","; A$; : LOCATE 16, 58: PRINT "         ";
  LOCATE 17, 60
  IF Best = -400 THEN PRINT "CHECK!";  ELSE PRINT "      ";
  GOTO Books

'-------------------- move pieces on the board ------------------------------
MoveFromPos:
  U = ChessBoard(F)                     'get contents of square
  GOSUB EmptySquare                     'remove it
  U = SC                                'get square color
  GOSUB FillSquare                      'repaint square
  COLOR 0, 3
  RETURN

MoveToPos:
  IF ChessBoard(T) <> 0 THEN
    SC = ChessBoard(T)
  END IF
  U = ABS(SC)
  ChessBoard(T) = ChessBoard(F)
  ChessBoard(F) = 0
  IF QP = Pawn THEN
    ChessBoard(T) = Side * Queen
    QP = 0
  END IF
  U = SC
  GOSUB FillSquare
  U = ChessBoard(T)
  GOSUB EmptySquare
  COLOR 0, 3
  RETURN

GetFromPos:
  X = F - INT(F / 10) * 10
  Y = INT((F - 10) / 10)
  IF Side = Black THEN
    E$ = CHR$(X + 64) + CHR$(Y + 48)
    GOTO Mp1
  END IF
  E$ = CHR$(73 - X) + CHR$(57 - Y)
  GOTO Mp1

GetToPos:
  X = T - INT(T / 10) * 10
  Y = INT((T - 10) / 10)
  IF Side = Black THEN
    E$ = E$ + CHR$(X + 64) + CHR$(Y + 48)
    GOTO Mp1
  END IF
  E$ = E$ + CHR$(73 - X) + CHR$(57 - Y)

Mp1:
  PA = 2 * (9 - Y) + 3
  PB = 5 * X + 3
  Q = (X + Y) \ 2
  Q1 = (X + Y + 1) \ 2
  IF Q = Q1 THEN SC = -10 ELSE SC = 10
  IF SC = 10 THEN CS = 7 ELSE CS = 3
  RETURN

EmptySquare:
  COLOR 15, CS
   IF U > 0 THEN
     LOCATE PA, PB: PRINT A$(U);
     LOCATE PA + 1, PB: PRINT D$(U)
     RETURN
   END IF
  COLOR 0, CS
  LOCATE PA, PB: PRINT A$(ABS(U));
  LOCATE PA + 1, PB: PRINT D$(ABS(U))
  RETURN

FillSquare:
  COLOR 7, CS
  U = SC
  IF U > 0 THEN
    LOCATE PA, PB: PRINT A$(U);
    LOCATE PA + 1, PB: PRINT D$(U)
    RETURN
  END IF
  COLOR 3, CS
  LOCATE PA, PB: PRINT A$(ABS(U));
  LOCATE PA + 1, PB: PRINT D$(ABS(U))
  RETURN

WholeMove:
  GOSUB GetFromPos
  GOSUB MoveFromPos
  GOSUB GetToPos
  GOSUB MoveToPos
  RETURN
HalfMove:
  GOSUB GetFromPos
  GOSUB MoveFromPos
  RETURN
'-------------------- Initialize the game -----------------------------------
Initialize:
  LOCATE 10, 25: PRINT "THE WARLORD x.1"
  LOCATE 12, 30: PRINT "A chess program"
  LOCATE 13, 30: PRINT "By Wm H Rogers"
  LOCATE 15, 14: PRINT "What is your color (B/W) ";
In1:
  K$ = INKEY$                           'get user choice
  IF K$ <> "W" AND K$ <> "B" THEN GOTO In1 'black or white only
  IF K$ = "W" THEN Side = 1 ELSE Side = -1 'set color of side selected
'-------------------- values of chessmen ------------------------------------
  Capture(0) = 0: Capture(Pawn) = 100: Capture(Knight) = 300: Capture(Bishop) = 320
  Capture(Rook) = 500: Capture(Queen) = 900: Capture(King) = 5000
'-------------------- logical variables -------------------------------------
  True = 1: False = 0: White = 1: Black = -1
  King = 6: Queen = 5: Rook = 4: Bishop = 3: Knight = 2: Pawn = 1
'-------------------- used to make chess books moves ------------------------
  B$(1) = "P": B$(2) = "N": B$(3) = "B": B$(4) = "R"
  B$(5) = "Q": B$(6) = "K": B$(8) = "M": B$(9) = "L"
  B$(10) = "C": B$(11) = "T": B$(12) = "H": B$(13) = "S"
'-------------------- create chess board ------------------------------------
  FOR K = 0 TO 119                      'first we fill board with 99's
   ChessBoard(K) = 99                   'as 99's are off the board
  NEXT
  FOR K = 1 TO 8                        'now we fill chessboard with men
    READ I                              'read men type
    ChessBoard(20 + K) = Side * I       'place white men
    ChessBoard(90 + K) = Side * -I      'place black men
    ChessBoard(30 + K) = Side * Pawn    'place white pawns
    ChessBoard(80 + K) = Side * -Pawn   'place black pawns
  NEXT K
  DATA 4,2,3,5,6,3,2,4
  FOR K = 40 TO 70 STEP 10              'now we fill the center squares
    FOR I = 1 TO 8                      'with 0's to represent empty
      ChessBoard(K + I) = 0             'squares.
    NEXT I
  NEXT K
  IF Side = Black THEN                  'if side is black then we
    ChessBoard(94) = King               'switch positions of Kings
    ChessBoard(95) = Queen              'and queens.
    ChessBoard(24) = -King              'the signs of the men were
    ChessBoard(25) = -Queen             'reversed at setup.
  END IF

  FOR E = 20 TO 90 STEP 10              'points for controlling the center
    FOR K = 1 TO 8                      'of the board.the values are based
      READ I                            'upon 1/10th of a pawn's value
      CentControl(E + K) = I            'they can be increased or decreased
    NEXT K                              'for experientmentation purposes.
  NEXT E
  DATA  0,  1,  3,  4,  4,  3,  1,  0
  DATA  2,  3,  5,  6,  6,  5,  3,  2
  DATA  4,  5,  7,  8,  8,  7,  5,  4
  DATA  6,  7,  9, 10, 10,  9,  7,  6
  DATA  6,  7,  9, 10, 10,  9,  7,  6
  DATA  4,  5,  7,  8,  8,  7,  5,  4
  DATA  2,  3,  5,  6,  6,  5,  3,  2
  DATA  0,  1,  3,  4,  4,  3,  1,  0

  FOR K = 1 TO 16                       'these are directions that the
    READ Index(K)                       'chessmen can move
  NEXT
  DATA 11,9,-11,-9,-10,-1,1,10,-21,-19,-8,-12,8,12,19,21
'-------------------- here are the graphic chessmen -------------------------
  A$(0) = "€€€€€": D$(0) = A$(0)        'need to print blank squares
  A$(1) = "  —  ": A$(2) = " ÕÀ  "      'pawn - knight
  D$(1) = "  œ  ": D$(2) = " Õ Õ "
  A$(10) = A$(0): D$(10) = A$(10)       'this is need also for black squares
  A$(3) = "  ≈  ": A$(4) = " …Àª "      'rook - bishop
  D$(3) = " ÛÒÚ ": D$(4) = " » º "
  A$(5) = " »Œº ": A$(6) = " ⁄Òø "      'queen - king
  D$(5) = " Õ Õ ": D$(6) = " ‘ æ "
  W1$ = "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª"
  W2$ = "∫                                                ∫"
  W3$ = "∫   ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø   ∫"
  W4$ = "∫   ≥                                        ≥   ∫"
  W5$ = "∫   ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ   ∫"
  W6$ = "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº"
  Y$ = "€€€€€     €€€€€     €€€€€     €€€€€     "
  Z$ = "     €€€€€     €€€€€     €€€€€     €€€€€"
  W8$ = "  A    B    C    D    E    F    G    H"
  W9$ = "  H    G    F    E    D    C    B    A"
  FOR I = 1 TO 6                        'used for locating move directions
    READ From(I), Too(I), Steps(I)      'in Index array for chessmen.
  NEXT
  DATA 3,4,1,9,16,1,1,4,7,5,8,7,1,8,7,1,8,1
  CLS
  COLOR 0, 6                            'set color to black on brown
  LOCATE 2, 3: PRINT W1$                'the following W#$'s are for
  LOCATE 3, 3: PRINT W2$                'printing a "wooden chess board"
  LOCATE 4, 3: PRINT W3$
  FOR I = 5 TO 20
    LOCATE I, 3                         'fill in the edges of the board
    PRINT W4$
  NEXT
  LOCATE 21, 3: PRINT W5$               'fill in the bottom of the board
  LOCATE 22, 3: PRINT W2$
  LOCATE 23, 3: PRINT W6$
  COLOR 7, 3
  GOSUB Init1
  CC$ = "Y": CL$ = "Y": CR$ = "Y"       'computer can castle flags
  HC$ = "Y": HL$ = "Y": HR$ = "Y"       'human can castle flags
  G = 63
  COLOR 0, 3                            'swap colors
  IF Side = White THEN
    GOTO HumanInput
    ELSE GOTO Books
  END IF
Init1:
  COLOR 7, 3                            'swap colors
  FOR I = 5 TO 17 STEP 4
    LOCATE I, 8: PRINT Y$
    LOCATE I + 1, 8: PRINT Y$
    LOCATE I + 2, 8: PRINT Z$
    LOCATE I + 3, 8: PRINT Z$
  NEXT I
  COLOR 0, 3                            'swap colors
  LOCATE 1, 60
  PRINT "WarlorD x.1"                   'print all headings
  LOCATE 7, 60
  PRINT "WarlorD",                      'pring clock headings
  LOCATE 8, 60
  PRINT "00:00:00"
  LOCATE 10, 60
  PRINT "Opponent";                     'pring clock headings
  LOCATE 11, 60
  PRINT "00:00:00";
  K = 99                                'this is where the man are put
  FOR Y = 8 TO 1 STEP -1                'on the visible chessboard
    FOR X = 8 TO 1 STEP -1
Init2:
      K = K - 1
      IF ChessBoard(K) = 99 THEN GOTO Init2 'if off the board then skip
      IF ChessBoard(K) = 0 THEN GOTO Init3  'if square is empty then skip
      GOSUB Mp1
      U = ChessBoard(K)                 'put man on the board
      GOSUB EmptySquare                 'draw man on the board
Init3:
    NEXT X
  NEXT Y
  COLOR 0, 6                            'swap colors
  IF K$ = "B" THEN GOTO Init4
  I = 5
  FOR J = 8 TO 1 STEP -1
    LOCATE I, 4: PRINT J;               'print ascii numbers for locating men
    LOCATE I, 49: PRINT J;
    I = I + 2
  NEXT
  LOCATE 3, 8: PRINT W8$;               'print ascii letter for locating men
  LOCATE 22, 8: PRINT W8$;
  COLOR 0, 3                            'swap colors
  RETURN
Init4:
  I = 5
  FOR J = 1 TO 8
    LOCATE I, 4: PRINT J;               'print ascii numbers for locating men
    LOCATE I, 49: PRINT J;
    I = I + 2
  NEXT
  LOCATE 3, 8: PRINT W9$;               'print ascii letter for locating men
  LOCATE 22, 8: PRINT W9$;
  COLOR 0, 3                            'swap colors
  RETURN
'-------------------- This is where we save a game --------------------------
SaveGame:
  OPEN "O", 1, "CHESS.DAT"
  FOR I = 20 TO 90 STEP 10
    FOR J = 1 TO 8
      PRINT #1, ChessBoard(I + J);
    NEXT
  NEXT
  PRINT #1, CC$; ","; CR$; ","; CL$; ","; HC$; ","; HR$; ","; HL$; ","; K$; ","; D$; ","; Side; ",";
  IF Side = White THEN M = M - 1
  PRINT #1, M
  CLOSE
  END
'-------------------- This is where we load a saved game --------------------
LoadGame:
  OPEN "I", 1, "CHESS.DAT"
  FOR I = 20 TO 90 STEP 10
    FOR J = 1 TO 8
      INPUT #1, ChessBoard(I + J)
    NEXT
  NEXT
  INPUT #1, CC$, CR$, CL$, HC$, HR$, HL$, K$, D$, Side, M
  CLOSE
  GOSUB Init1
  IF K$ = "B" THEN LOCATE 16, 58: PRINT M; D$; ",";
  GOTO HumanInput
'-------------------- This is where the chess books are stored --------------
  DATA"*CHTMLTHCSSSSSSSS32PPPPPPPPRNBKQBNR*1","E2E4","75","D2D4"
  DATA"*CHTMLTHCSSS1SSSS11S7P12PPP1PPPPRNBKQBNR*2","B1C3"
  DATA"*CHTMLT1CSSS1SSSS5H5S7P9N2PPP1PPPPRNBKQB1R*3","G1F3"
  DATA"*RNBQKBNRPPPP1PPP12P19SSSSSSSSCHTLMTHC*1","E7E5"
  DATA"*RNBQKB1RPPPP1PPP5N6P7S11SSSS1SSSCHTLMTHC*2","B8C6"
  DATA"*R1BQKB1RPPPP1PPP2N2N6P7S5H5SSSS1SSSC1TLMTHC*3","G8F6"
  DATA"*R1BQK2RPPPP1PPP2N2N4B1P7S5H2H2SSSS1SSSC1TLMT1C*4","F8C5"
  DATA"END"
'---------- Comments on the program -----------------------------------------
'     This program was orginally written in interpretive basic and as such
' it employs several things that are no longer in vogue. In Ibasic, a pro-
' gram could be made to run faster by two techinques.. 1. by ordering the
' variables in a Dim statement (the most used variables are accessed first.
' and 2. by putting the most use subroutines at the beginning of the program.
' Ibasic would always look for Goto's and Gosub by starting at the begining
' of the program until it fould the line number called for.
' I also found that, at least in QBasic, that Gosub's run faster than using
' Sub's.
' Here is a summary of the subroutines used in my program.
' 1. InCheck: is actuall two subs in one. First it locates the king and then
'     is finds all pieces attacking that square. It exits the sub upon finding
'     a attacking piece and that pieces location is in the variable "K".
'     This makes makes the program more useful as it can find attacks on other
'     men by setting their location to "K" and going to Attackers:
' 2. Evualuation: is just what the program infers, and can be changed as
'     by the operator/programmer as desired. The weights are for trial pur-
'     poses only and may not represent the Best.
' 3.  Books: is where the program looks to see if an opening book has been
'      defined by the program. It is not the most efficent, but it works.
'      The books can be expanded simply by hitting Control-Break after the
'      program leaves the book subroutine and generates a move on its own.
'      At this point pressing 'F6' and printing Bk$ you can see what the
'      chess board looked like at that point. Simply Edit/Copy that line,
'      then press 'F6' again the paste the line at the end of the program,
'      preceded by a "Data" statement. Then enclose you suggest move in
'      quotes. By adding a number in quotes after the move, you can suggest
'      an alternative move. The number is the percentage of the time the
'      program will chose the first move.
' 4.  Genmoves: is where the program generates all of its legal moves. It
'      castle when it can and make enpassant captures when it is possible and
'      they are advantageous. The first thing the program does is find a man
'      of its own color, then it goes to InCheck to see if that move puts its
'      king in check, if so it rejects the move. If not it then goes to the
'      Evualuate subroutine, rates the move, and stores it as Best if it is
'      determined to actually the best, if not it simply returns to GenMove.
'      After finding its best move it falls into the execute the move and
'      does just that. After making its move it switches sides and determines
'      if the enemy king is in check and goes to HumanInput.
'      In the begining of the computer moves "Best is set to 400 if the
'      the program is in check when it starts is move gen. or 200 if it is
'      not. If after trying to find a legal move and it can't it prints the
'      message CheckMate you win or Stalemate, and then quits.
' 5.  HumanInput: only accepts 4 commands: "Q" for quit, "S" for save the game
'      "L" for loading a previously saved game, or a standard move entered as
'      "E2E4" in caps without spaces, however, it in entering a move, you hit
'      a wrong key before the last digit is entered, you can hit "x" or "z" or
'      any other key and it will void the move and try again. It won't do that
'      unless 4 keystrokes have been entered and back spaces are not allowed.
'      It checks that you are moving your own man and that the move is legal.
'      If so, it makes the move, if not it prints "Illegal" goes back to
'      input again. My legal checking is not 100% true, but if you don't
'      cheat, it should work. After making its move it goes to see if its
'      king is in check and set the approiate flag before going to Books:.
'      If it has no more books stored it goes to GenMoves:.
' 6.   The subroutines following HumanInput are for calculating the position
'      of the chessmen on the board and putting them there. Because some
'      moves require moving more that one man "castling" or enpassant there
'      are some subroutines that only make half a move before making a full
'      move later. DON'T REMOVE THESE SUBROUTINES.
' 7. Initialize: creates the chess board and the centercontol board as:
'            chess board                    centercontrol board
'    99,99,99,99,99,99,99,99,99,99       0, 0, 0, 0, 0, 0, 0, 0, 0, 0
'    99, 0, 0, 0, 0, 0, 0, 0, 0,99       0, 0, 0, 0, 0, 0, 0, 0, 0, 0
'    99, 4, 2, 3, 5, 6, 3, 2, 4,99       0, 0, 1, 3, 4, 4, 3, 1, 0, 0
'    99, 1, 1, 1, 1, 1, 1, 1, 1,99       0, 2, 3, 5, 6, 6, 5, 3, 2, 0
'    99, 0, 0, 0, 0, 0, 0, 0, 0,99       0, 4, 5, 7, 8, 8, 7, 5, 4, 0
'    99, 0, 0, 0, 0, 0, 0, 0, 0,99       0, 6, 7, 9,10,10, 9, 7, 6, 0
'    99, 0, 0, 0, 0, 0, 0, 0, 0,99       0, 6, 7, 9,10,10, 9, 7, 6, 0
'    99, 0, 0, 0, 0, 0, 0, 0, 0,99       0, 4, 5, 7, 8, 8, 7, 5, 4, 0
'    99,-1,-1,-1,-1,-1,-1,-1,-1,99       0, 2, 3, 5, 6, 6, 5, 3, 2, 0
'    99,-4,-2,-3,-5,-6,-3,-2,-4,99       0, 0, 1, 3, 4, 4, 3, 1, 2, 0
'    99,99,99,99,99,99,99,99,99,99       0, 0, 0, 0, 0, 0, 0, 0, 0, 0
'    99,99,99,99,99,99,99,99,99,99       0, 0, 0, 0, 0, 0, 0, 0, 0, 0
'    If the computer is black only       The outside edges of this
'    the signs are refersed. The         board are really not needed as
'    computer is always at the top       only the center square witch
'    of the screen. The #'s 99 are       correspond to the real chess
'    always off the board.               board are accessed.
'                                        However. you can put in any values
'                                        that you want to try as these are
'                                        only starting values based upon
'                                        the value of one pawn = 100
'                                        You can try as high as 150 for the
'                                        center squares if you want.
' A final note:
' I have never taken a class on programming, I am self taught, so some of
' my coding may not be the best. If anyone who uses this program wants to
' makes changes, feel free to do so. If you make it play better, or optimize
' any of the coding, please forward the new version of the program so as I
' can record the changes for future releases. I am giving this program as
' freeware to use as you see fit. At the current time it is not very strong.
' It is only a one-ply program, however, it has been stated that the better
' a program plays at one-ply, the better it will play at depth (many-plys).
' You can Email me at: WROGERS824@AOL.COM any comments or changes.
' I deleted the clock subroutines as they messed up the on-board computer
' clock. I just could not figure out how to do it better at this time.
' The program as it stands now has been in existance for 19 years.
' Thanks to all of you. Bill Rogers.
                                         

