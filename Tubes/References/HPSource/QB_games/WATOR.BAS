DECLARE SUB Center (Lin%, Text$)
DECLARE SUB ClearBot ()
DECLARE SUB Display ()
DECLARE SUB OkFishMoves (OkX%(), OkY%(), Fish%(), Shark%(), PossiblePositions%)
DECLARE SUB OkSharkMoves (OkX%(), OkY%(), Fish%(), Shark%(), PP%)

DEFINT A-Z      ' integers when possible: less space/increased speed

DIM SHARED X, Y, XDim, YDim
CONST False = 0, True = NOT False

SCREEN 0, 0, 0
COLOR 15, 1
CLS
COLOR 15, 5
PRINT "Wa-Tor:    ";
COLOR 14
PRINT "Sharks and fish wage an ecological war on the toroidal planet Wa - Tor."

ClearBot
LOCATE 3, 1
COLOR 7, 1

DO: INPUT "X Size of Wa-Tor [40]? ", X$
    X = VAL(X$)
    IF X = 0 THEN XDim = 40 ELSE XDim = X
LOOP UNTIL (XDim <= 40) AND (XDim > 1)

DO: INPUT "Y Size of Wa-Tor [23]? ", Y$
    Y = VAL(Y$)
    IF Y = 0 THEN YDim = 23 ELSE YDim = Y
LOOP UNTIL (YDim <= 23) AND (YDim > 1)

TotalSpots = XDim * YDim * 9 \ 10' total # of positions

NFish = TotalSpots \ 2      ' # of sharks in the beginning
NSharks = TotalSpots \ 20   ' # of fish in the beginning

DO: INPUT "Chronons required for fish to breed [8]? ", X$
    X = VAL(X$)
    IF X = 0 THEN FBreed = 8 ELSE FBreed = X
LOOP UNTIL FBreed >= 1

DO: INPUT "Chronons required for sharks to breed [10]? ", X$
    X = VAL(X$)
    IF X = 0 THEN SBreed = 10 ELSE SBreed = X
LOOP UNTIL SBreed >= 1

DO: INPUT "How long can a shark live without fish [3]? ", X$
    X = VAL(X$)
    IF X = 0 THEN Starve = 3 ELSE Starve = X
LOOP UNTIL Starve >= 1

PRINT
INPUT "Chronons per second (0 = not timed) [0]? ", X$
PerSecond = VAL(X$)
IF PerSecond THEN Interval! = 1 / PerSecond

COLOR 14, 5
Center 25, "Initializing..."

DIM Fish(1 TO XDim, 1 TO YDim)      ' presence or absense of a fish at point
DIM Shark(1 TO XDim, 1 TO YDim)     ' presence or absense of a shark at point
DIM FishMove(1 TO XDim, 1 TO YDim)  ' record of whether a fish has been  moved
                                    '   there during the current computational
                                    '   cycle
DIM SharkMove(1 TO XDim, 1 TO YDim) ' ditto
DIM Starve(1 TO XDim, 1 TO YDim)    ' registers the last time the sharks ate

FOR Dummy = 1 TO XDim
    FOR Dummy2 = 1 TO YDim
        Fish(Dummy, Dummy2) = -1    ' none here for the moment
        Shark(Dummy, Dummy2) = -1
    NEXT
NEXT

FOR Fill = 1 TO NFish       ' fill Wa-Tor with fish
    RANDOMIZE TIMER

    DO      ' make sure it's not occupied by another fish already
        LocX = INT(RND * XDim + 1)   ' positions
        LocY = INT(RND * YDim + 1)
    LOOP UNTIL (Fish(LocX, LocY) = -1)

    Fish(LocX, LocY) = INT(RND * FBreed)  ' say fish is here; stage of life
NEXT

FOR Fill = 1 TO NSharks
    RANDOMIZE TIMER

    DO      ' make sure it's not occupied by another fish or shark already
        LocX = INT(RND * XDim + 1)   ' positions
        LocY = INT(RND * YDim + 1)
    LOOP UNTIL (Fish(LocX, LocY) = -1) AND (Shark(LocX, LocY) = -1)

    Shark(LocX, LocY) = INT(RND * SBreed) ' say shark is here!; stage of life
    Starve(LocX, LocY) = INT(RND * Starve)       ' last time ate?
NEXT

ClearBot

VIEW PRINT 2 TO 24
LOCATE 24, 1
COLOR 7, 1
FOR Dummy = 1 TO 24: PRINT : NEXT
VIEW PRINT

Display

DO
    IF PerSecond THEN T! = TIMER

    REDIM OkX(1 TO 4), OkY(1 TO 4)

    FOR X = 1 TO XDim      ' moving fish
        FOR Y = 1 TO YDim
            IF Fish(X, Y) > -1 THEN    ' there's a fish here
                IF FishMove(X, Y) = 0 THEN  ' and hasn't been moved yet

                    OkFishMoves OkX(), OkY(), Fish(), Shark(), NumPos
                            ' find the ok positions to move to
                    IF NumPos > 0 THEN   ' a place to move to!
                        RANDOMIZE TIMER
                        Choice = INT(NumPos * RND) + 1

                        NewX = OkX(Choice)  ' new pos.
                        NewY = OkY(Choice)

                        IF Fish(X, Y) >= FBreed THEN    ' breeding time?
                            Fish(NewX, NewY) = 0        ' reset life
                            Fish(X, Y) = 0

                            NFish = NFish + 1
                            FishMove(X, Y) = 1          ' say we have changed
                            FishMove(NewX, NewY) = 1        ' already
                        ELSE
                            Fish(NewX, NewY) = Fish(X, Y) + 1
                            Fish(X, Y) = -1
                            FishMove(NewX, NewY) = 1
                        END IF
                    END IF  ' none possible
                END IF  ' moved already
            END IF  ' no fish there
        NEXT
    NEXT


'shark time -- complications...
    FOR X = 1 TO XDim
        FOR Y = 1 TO YDim
            IF Shark(X, Y) > -1 THEN    ' there's a shark here
                IF SharkMove(X, Y) = 0 THEN     ' it hasn't been moved yet
                    NewX = 0
                    NewY = 0

                    OkSharkMoves OkX(), OkY(), Fish(), Shark(), NumPos

                    RANDOMIZE TIMER
                    IF NumPos > 0 THEN      ' places with fish to move to
                        Choice = INT(NumPos * RND) + 1

                        NewX = OkX(Choice)
                        NewY = OkY(Choice)

                        IF Shark(X, Y) = SBreed THEN    ' breeding time?
                            Shark(NewX, NewY) = 0
                            Shark(X, Y) = 0
                            Starve(NewX, NewY) = 0
                            Starve(X, Y) = 0
                            Fish(NewX, NewY) = -1
                           
                            NSharks = NSharks + 1
                            NFish = NFish - 1
                            SharkMove(NewX, NewY) = 1
                            SharkMove(X, Y) = 1
                        ELSE
                            Shark(NewX, NewY) = Shark(X, Y) + 1
                            Shark(X, Y) = -1
                            Starve(NewX, NewY) = 0
                            Starve(X, Y) = -1
                            Fish(NewX, NewY) = -1

                            NFish = NFish - 1
                            SharkMove(NewX, NewY) = 1
                        END IF
                    ELSEIF NumPos < 0 THEN ' no fish positions, but just move
                        Choice = INT(ABS(NumPos) * RND) + 1

                        NewX = OkX(Choice)
                        NewY = OkY(Choice)

                        IF Shark(X, Y) = SBreed THEN    ' breeding time?
                            Shark(NewX, NewY) = 0
                            Shark(X, Y) = 0
                            Starve(NewX, NewY) = Starve(X, Y) + 1
' *********** Should the baby be full when born? Or should it new food?
                        
                            Starve(X, Y) = Starve - 2

                            NSharks = NSharks + 1
                            SharkMove(NewX, NewY) = 1
                            SharkMove(X, Y) = 1
                        ELSE
                            Shark(NewX, NewY) = Shark(X, Y) + 1
                            Shark(X, Y) = -1
                            Starve(NewX, NewY) = Starve(X, Y) + 1
                            Starve(X, Y) = -1

                            SharkMove(NewX, NewY) = 1
                        END IF
                    ELSE    ' can't move at all!
                        Shark(X, Y) = Shark(X, Y) + 1
                        Starve(X, Y) = Starve(X, Y) + 1
                        'SharkMove(X,Y)=1
                    END IF

                    IF Starve(X, Y) >= Starve THEN
                        Shark(X, Y) = -1  ' died
                        NSharks = NSharks - 1
                    END IF
                    IF NewX > 0 THEN
                        IF Starve(NewX, NewY) >= Starve THEN
                            Shark(NewX, NewY) = -1  ' died
                            NSharks = NSharks - 1
                        END IF
                    END IF
                END IF  ' moved already
            END IF  ' no shark here
        NEXT
    NEXT

    Chronons = Chronons + 1     ' next year

    REDIM FishMove(1 TO XDim, 1 TO YDim)    ' clear moved flags
    REDIM SharkMove(1 TO XDim, 1 TO YDim)

    Display         ' display progress (YESSS!!!)

    IF SingleStep = 1 THEN
        DO: I$ = INKEY$: LOOP UNTIL LEN(I$)
        IF UCASE$(I$) = "P" THEN SingleStep = 0
        IF UCASE$(I$) = "E" THEN EXIT DO
    ELSE
        I$ = UCASE$(INKEY$)

        IF I$ = "P" THEN
            DO: I$ = INKEY$: LOOP UNTIL LEN(I$)
            IF UCASE$(I$) <> "P" THEN SingleStep = 1
        ELSEIF I$ = "E" THEN
            EXIT DO
        END IF
    END IF

    IF PerSecond AND (SingleStep = 0) THEN
        E! = TIMER
        IF (E! - T!) < Interval! THEN
            DO: LOOP UNTIL ((TIMER - T!) >= Interval!) OR (TIMER < T!)
        END IF
    END IF

LOOP UNTIL (NSharks = 0) OR (NFish = 0)


COLOR 14, 5
LOCATE 1, 12
PRINT "Press any key to exit..."; SPACE$(81 - POS(0));

DO: LOOP UNTIL LEN(INKEY$)

END

SUB Center (Lin, Text$)

    LOCATE Lin, (81 - LEN(Text$)) \ 2
    PRINT Text$;

END SUB

SUB ClearBot

    COLOR 15, 3
    LOCATE 25, 1
    PRINT STRING$(80, 0);

END SUB

SUB Display

SHARED Fish(), Shark(), XDim, YDim, Chronons, NFish, NSharks

    Temp$ = SPACE$(XDim + XDim)
   
    COLOR 7, 1
    FOR Y = 1 TO YDim
        Counter = 1
        FOR X = 2 TO XDim + XDim STEP 2
            IF Fish(Counter, Y) > -1 THEN   ' fish?
                MID$(Temp$, X) = "o"
            ELSEIF Shark(Counter, Y) > -1 THEN  ' shark?
                MID$(Temp$, X) = CHR$(254)
            ELSE                            ' nope, it's just blank
                MID$(Temp$, X) = CHR$(250)
            END IF
            Counter = Counter + 1
        NEXT

        LOCATE Y + 1, 1
        PRINT Temp$;
    NEXT

    LOCATE 25, 1

    IF SCREEN(25, 1) <> 179 THEN
        COLOR 15, 3
'                        22v            37v            42v
PRINT "³Status³  Chronons:      Fish pop (o):      Shark pop(þ):  ³";
PRINT "        P     E";
        COLOR 14
        LOCATE , 70
        PRINT "ause/";
        LOCATE , POS(0) + 1
        PRINT "xit";
    END IF
   
    LOCATE , 20, 0

    COLOR 14, 3
    PRINT Chronons;
    LOCATE , 39
    PRINT NFish;
    LOCATE , 58
    PRINT NSharks;
END SUB

SUB OkFishMoves (OkX(), OkY(), Fish(), Shark(), PP)
        ' PP=Possible Positions
    PP = 0
    
    ' left
    IF X = 1 THEN tempX = XDim ELSE tempX = X - 1
    tempY = Y
    GOSUB CheckF
    
    ' right
    IF X = XDim THEN tempX = 1 ELSE tempX = X + 1
    GOSUB CheckF

    ' up
    IF Y = 1 THEN tempY = YDim ELSE tempY = Y - 1
    tempX = X
    GOSUB CheckF

    ' down
    IF Y = YDim THEN tempY = 1 ELSE tempY = Y + 1
    GOSUB CheckF
EXIT SUB

CheckF:
    IF (Fish(tempX, tempY) = -1) AND (Shark(tempX, tempY) = -1) THEN
        PP = PP + 1
        OkX(PP) = tempX
        OkY(PP) = tempY
    END IF
RETURN
END SUB

SUB OkSharkMoves (OkX(), OkY(), Fish(), Shark(), PP) STATIC
    ' PP=Possible Positions
    ' if will be returned negated if only no-fish places are found...

    IF NOT Inited THEN
        DIM NoFishX(1 TO XDim), NoFishY(1 TO YDim)  ' we will store values
        Inited = True                               ' when the
    END IF
                        ' shark moves and doensn't find a fish at position.
      ' We will store the positions where sharks are found in the "Ok" array.
    PP = 0
    PPnF = 0    ' positions w/o fish

    ' left
    IF X = 1 THEN tempX = XDim ELSE tempX = X - 1
    tempY = Y
    GOSUB CheckS

    ' right
    IF X = XDim THEN tempX = 1 ELSE tempX = X + 1
    GOSUB CheckS

    ' up
    IF Y = 1 THEN tempY = YDim ELSE tempY = Y - 1
    tempX = X
    GOSUB CheckS

    ' down
    IF Y = YDim THEN tempY = 1 ELSE tempY = Y + 1
    GOSUB CheckS

    IF PP = 0 THEN  ' since there is no fish around me, just move on
        IF PPnF > 0 THEN    ' other places not occupied
            PP = -PPnF

            FOR Copy = 1 TO PPnF
                OkX(Copy) = NoFishX(Copy)
                OkY(Copy) = NoFishY(Copy)
            NEXT
        END IF  ' no place to go!!
    END IF
EXIT SUB

CheckS:
    IF Shark(tempX, tempY) = -1 THEN    ' make sure there's no shark
        IF Fish(tempX, tempY) > -1 THEN   'fish found in this place
            PP = PP + 1
            OkX(PP) = tempX
            OkY(PP) = tempY
        ELSE    ' ohh, no fish.  Anybody for tuna I bought at the grocers?
            PPnF = PPnF + 1
            NoFishX(PPnF) = tempX

            NoFishY(PPnF) = tempY
        END IF
    END IF
RETURN

END SUB

