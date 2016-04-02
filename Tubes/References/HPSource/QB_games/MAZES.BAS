'        I was reading  a message a  while ago asking  about a maze
'drawing algorithm.  I've been  working on this  algorithm since last
'night and it's now ready to be sent. It draws a one-solution two-exits
'maze.  From one of the to exit/entrance, you can reach any 'square' in
'the maze.
'
'        It works in three phases. First it draws the paths and waits for
'a key. This is the main drawing  algorithm. Then it clears the screen,
'draws the walls (outlined paths),  and waits for a  key. Finally, the
'third part finds and draws the unique solution of  the maze and then
'waits for a key. You can exit at any time by pressing [Esc].

' Maze
' By Jean Cr*peau

DEFINT A-Z
DECLARE FUNCTION num (x, y)
DECLARE SUB vdctr (x$)
RANDOMIZE TIMER
DO
    SCREEN 0, 0: CLS
    COLOR 15: vdctr "Maze": COLOR 7
    vdctr "By Jean Cr*peau"
    PRINT
    INPUT "X,Y: ", nx, ny
    nx = nx - 1: ny = ny - 1
    IF nx <= 0 THEN nx = 31
    IF ny <= 0 THEN ny = 31
' Initialization
   SCREEN 1, 0: CLS : wx = 320 - 1: wy = 200 - 1' CGA4
    'SCREEN 2, 0: CLS : wx = 640 - 1: wy = 200 - 1' CGA2
    'SCREEN 3, 0: CLS : wx = 720 - 1: wy = 348 - 1' HERC
    xi = wx \ nx: yi = wy \ ny
    mx = (wx - xi * nx) / 2: my = (wy - yi * ny) / 2
    REDIM SHARED ar(nx, ny), avl(3), bit(7)
    bit(0) = 1: bit(1) = 2: bit(2) = 4: bit(3) = 8
    bit(4) = 1: bit(5) = 3: bit(6) = 7: bit(7) = 15
' Maze computation
    tt = (nx + 1) * (ny + 1): t = 0: ox = 0: oy = 0
    DO
        IF t = 0 THEN
            t = tt: cx = 0: cy = RND * ny
            sy0 = cy
        ELSE
            cx = ox: cy = oy: DO
                IF ar(cx, cy) THEN
                    IF num(cx, cy) > 0 THEN EXIT DO
                END IF
                cy = cy + 1: IF cy > ny THEN : cy = 0: cx = cx + 1: IF cx = nx THEN cx = 0
            LOOP
            ox = cx: oy = cy
        END IF
        DO
            px = cx * xi: py = cy * yi
            n = 4
            avl(0) = 1: avl(1) = 2: avl(2) = 3: avl(3) = 4
            IF cx = nx THEN avl(0) = 0 ELSE IF ar(cx + 1, cy) THEN avl(0) = 0
            IF cy = ny THEN avl(1) = 0 ELSE IF ar(cx, cy + 1) THEN avl(1) = 0
            IF cx = 0 THEN avl(2) = 0 ELSE IF ar(cx - 1, cy) THEN avl(2) = 0
            IF cy = 0 THEN avl(3) = 0 ELSE IF ar(cx, cy - 1) THEN avl(3) = 0
            DO
                IF avl(0) = 0 AND n > 0 THEN
                    n = n - 1: SWAP avl(0), avl(n)
                ELSEIF avl(1) = 0 AND n > 1 THEN
                    n = n - 1: SWAP avl(1), avl(n)
                ELSEIF avl(2) = 0 AND n > 2 THEN
                    n = n - 1: SWAP avl(2), avl(n)
                ELSEIF avl(3) = 0 AND n > 3 THEN
                    n = n - 1: SWAP avl(3), avl(n)
                ELSE
                    EXIT DO
                END IF
            LOOP UNTIL n = 0
            IF n = 0 THEN EXIT DO
            q = avl(INT(RND * n)) - 1
            IF ar(cx, cy) = 0 THEN t = t - 1
            ar(cx, cy) = ar(cx, cy) OR bit(q)
            SELECT CASE q
            CASE 0: cx = cx + 1
            CASE 1: cy = cy + 1
            CASE 2: cx = cx - 1
            CASE 3: cy = cy - 1
            END SELECT
            ar(cx, cy) = ar(cx, cy) OR bit(q XOR 2): t = t - 1
            LINE (mx + px, my + py)-(mx + cx * xi, my + cy * yi)

            IF cx = nx THEN sy1 = cy
        LOOP
        IF INKEY$ = CHR$(27) THEN GOTO quit
    LOOP UNTIL t = 0
    ar(nx, sy1) = ar(nx, sy1) OR bit(0)
    ar(0, sy0) = ar(0, sy0) OR bit(2)
    a$ = INPUT$(1)
' "Outline" maze
    CLS
    xi = wx \ (nx + 1): yi = wy \ (ny + 1)
    mx = (wx - (nx + 1) * xi) / 2: my = (wy - (ny + 1) * yi) / 2
    LINE (mx, my)-(mx, my + yi * (ny + 1))
    py = (sy0 + 1) * yi: LINE (mx, my + py)-(mx, my + py - yi), 0
    LINE (mx, my)-(mx + xi * (nx + 1), my)
    FOR y = 0 TO ny
        FOR x = 0 TO nx
            px = mx + (x + 1) * xi: py = my + (y + 1) * yi
            IF (ar(x, y) AND bit(0)) = 0 THEN LINE (px, py)-(px, py - yi)
            IF (ar(x, y) AND bit(1)) = 0 THEN LINE (px, py)-(px - xi, py)
        NEXT
        IF INKEY$ = CHR$(27) THEN GOTO quit
    NEXT
    a$ = INPUT$(1)
' Solution computation
    cx = 0: cy = sy0: t = 1: ld = 2: d = 0: u$ = "0"
    DO
        q = ar(cx, cy) AND NOT bit(ld)
        IF q = bit(0) THEN
            d = 0
        ELSEIF q = bit(1) THEN
            d = 1
        ELSEIF q = bit(2) THEN
            d = 2
        ELSEIF q = bit(3) THEN
            d = 3
        ELSEIF t = 1 THEN
            IF q AND bit(0) THEN
                u$ = u$ + CHR$(48 + d): d = 0
            ELSEIF q AND bit(1) THEN
                u$ = u$ + CHR$(48 + d): d = 1
            ELSEIF q AND bit(2) THEN
                u$ = u$ + CHR$(48 + d): d = 2
            ELSEIF q AND bit(3) THEN
                u$ = u$ + CHR$(48 + d): d = 3
            ELSE
                d = ld: t = 0
            END IF
        ELSE
            nd = ASC(RIGHT$(u$, 1)) AND 3
            q = ar(cx, cy) AND NOT bit(nd XOR 2) AND NOT bit(ld + 4)
            IF q AND bit(1) THEN
                t = 1: d = 1
            ELSEIF q AND bit(2) THEN
                t = 1: d = 2
            ELSEIF q AND bit(3) THEN
                t = 1: d = 3
            ELSE
                u$ = LEFT$(u$, LEN(u$) - 1)
                d = nd XOR 2
            END IF
        END IF
        px = mx + cx * xi: py = my + cy * yi
        LINE (px + 2, py + 2)-(px + xi - 2, py + yi - 2), t, BF
        SELECT CASE d
        CASE 0: cx = cx + 1: LINE (px + xi - 2, py + 2)-(px + xi + 2, py + yi - 2), t, BF
        CASE 1: cy = cy + 1: LINE (px + 2, py + yi - 2)-(px + xi - 2, py + yi + 2), t, BF
        CASE 2: cx = cx - 1: LINE (px - 2, py + 2)-(px + 2, py + yi - 2), t, BF
        CASE 3: cy = cy - 1: LINE (px + 2, py - 2)-(px + xi - 2, py + 2), t, BF
        END SELECT
        ld = d XOR 2
        IF INKEY$ = CHR$(27) THEN GOTO quit
    LOOP UNTIL cx = nx AND cy = sy1
    px = mx + cx * xi: py = my + cy * yi: LINE (px + 2, py + 2)-(px + xi - 2, py + yi - 2), t, BF
LOOP UNTIL INPUT$(1) = CHR$(27)
quit: SCREEN 0
END

FUNCTION num (x, y)
  SHARED nx, ny
  n = 4
  IF x >= nx THEN n = n - 1 ELSE IF ar(x + 1, y) THEN n = n - 1
  IF y >= ny THEN n = n - 1 ELSE IF ar(x, y + 1) THEN n = n - 1
  IF x <= 0 THEN n = n - 1 ELSE IF ar(x - 1, y) THEN n = n - 1
  IF y <= 0 THEN n = n - 1 ELSE IF ar(x, y - 1) THEN n = n - 1
  num = n
END FUNCTION

SUB vdctr (x$)
    PRINT SPACE$(40 - LEN(x$) / 2); x$
END SUB

