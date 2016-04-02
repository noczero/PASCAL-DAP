RANDOMIZE TIMER

SCREEN 13

FOR b = 1 TO 63
  OUT 968, b
  OUT 969, b
  OUT 969, 0
  OUT 969, 0

  OUT 968, b + 63
  OUT 969, 63
  OUT 969, b
  OUT 969, 0

  OUT 968, b + 126
  OUT 969, 64 - b
  OUT 969, 64 - b
  OUT 969, b

  OUT 968, b + 189
  OUT 969, 63
  OUT 969, 0
  OUT 969, 63
NEXT b

DIM SHARED flame(64, 40) AS INTEGER

DO

  FOR x = 1 TO 62
    flame(x, 40) = CINT(RND * 251)
  NEXT x

  FOR x = 1 TO 63
    FOR y = 39 TO 0 STEP -1
      IF flame(x, y + 1) > 5 THEN flame(x, y) = (flame(x - 1, y) + flame(x, y + 1) + flame(x + 1, y + 1)) / 3 - 2.2
    NEXT y
  NEXT x

  FOR y = 0 TO 38
    FOR x = 0 TO 63
      IF flame(x, y) < 0 THEN flame(x, y) = 0
      LINE (x * 5, y * 5)-(x * 5 + 4, y * 5 + 4), flame(x, y), BF
    NEXT x
  NEXT y

  WAIT &H3DA, 8
  WAIT &H3DA, 8, 8

LOOP UNTIL INKEY$ <> ""

ner = 252
DO

  FOR x = 1 TO 62
    flame(x, 40) = CINT(RND * ner)
  NEXT x

  ner = ner - 10
  IF ner <= 0 THEN ner = 0

  FOR x = 1 TO 63
    FOR y = 39 TO 0 STEP -1
      flame(x, y) = (flame(x - 1, y) + flame(x, y + 1) + flame(x + 1, y + 1)) / 3 - 2.2
    NEXT y
  NEXT x
 
  FOR y = 0 TO 38
    FOR x = 0 TO 63
      IF flame(x, y) < 0 THEN flame(x, y) = 0
      LINE (x * 5, y * 5)-(x * 5 + 4, y * 5 + 4), flame(x, y), BF
    NEXT x
  NEXT y
 
  WAIT &H3DA, 8
  WAIT &H3DA, 8, 8

  f = 0
  FOR x = 1 TO 63
    FOR y = 39 TO 0 STEP -1
      IF flame(x, y) <= 0 THEN f = f + 1
    NEXT y
  NEXT x
 
LOOP UNTIL f > 2400

SCREEN 0
WIDTH 80

CLS
PRINT "By: Daniel Heds‚n (Quant)"
PRINT "E-mail: daniel.hedsen@mn.medstroms.se"
PRINT
PRINT "Visit: The Qbasic Site"
PRINT "http://hem.passagen.se/hedsen"
END

