'===========================================================================
' Subject: SIMULATE CHAT W/MARTIANS           Date: 07-07-97 (15:17)       
'  Author: Chris McKenzie                     Code: QB, QBasic, PDS        
'  Origin: mckenze@earthlink.net            Packet: AI.ABC
'===========================================================================
DECLARE SUB delay (Seconds!)
DECLARE SUB text (lctx, lcty, txt$, enp)
COMMON SHARED variable AS INTEGER
COMMON SHARED name$
RANDOMIZE TIMER
CLS
SCREEN 0
text 11, 10, "Establishing Inter-Galactic Network...", 0
delay (1.3)
CLS
COLOR 2
PRINT "         cHAT oNLINE wITH rEAL mARTIANS"
PRINT "-----------------------------------------------"
text 3, 1, "Hello, what is your name?", 0
KEY(16) OFF
LINE INPUT ; "Your Name: "; name$
KEY(16) ON
KEY 1, name$
text 5, 1, "Nice name, I am ž‰xŒ LŒsh 3Dà", 0
text 6, 1, "ž‰xŒ LŒsh 3Dà: Are you a humanoid?", 1
text 8, 1, "ž‰xŒ LŒsh 3Dà: How long have you had this disease?", 1
text 10, 1, "ž‰xŒ LŒsh 3Dà: What do you look like?", 1
text 12, 1, "ž‰xŒ LŒsh 3Dà: Too scary for me, I'm outta here.", 0
COLOR 18
PRINT "...CONNECTION TERMINATED"
COLOR 2
PRINT "ATH0"
PRINT "OK"
PRINT "+++"
PRINT "OK"
FOR a = 1 TO 1000 STEP 2
FOR x = 1 TO 7 STEP .2
xr = RND * 150 * 2
yr = RND * 250 * 2
SOUND SIN(x) * 20 + 180 + a, .0228
NEXT x
NEXT a
donewa:
variable = 1
RETURN

SUB delay (Seconds!)
Begin! = TIMER
DO UNTIL (TIMER - Begin! > Seconds!) OR (TIMER - Begin! < 0)
LOOP
END SUB

SUB text (lctx, lcty, txt$, enp)
variable = 0
KEY 16, CHR$(0) + CHR$(28)
KEY(16) ON
COLOR 2 + 16
FOR x = 1 TO LEN(txt$)
LOCATE lctx, lcty + x - 1
delay .005
PRINT CHR$(RND * 235 + 20)
SOUND 1000, .0228
NEXT x
COLOR 2
FOR x = 1 TO LEN(txt$)
LOCATE lctx, lcty
letter$ = LEFT$(txt$, x + 2)
lettera$ = RIGHT$(letter$, x)
delay .005
PRINT letter$
SOUND 10000, .0228
NEXT x
IF enp = 1 THEN
DO
IF UCASE$(answer$) = "BYE" THEN GOTO donew
LOCATE lctx + 1, 1
PRINT name$; ":"
IF variable = 1 THEN EXIT DO
LOCATE lctx + 1, LEN(answer$) + lcty + LEN(name$) + 1, 1, 2, 4
key$ = INKEY$
IF key$ = CHR$(27) THEN GOTO donew
ON KEY(16) GOSUB donewa
IF key$ <> "" THEN
IF key$ = CHR$(8) THEN
answer$ = LEFT$(answer$, LEN(answer$) - 1)
LOCATE lctx + 1, lcty + LEN(name$) + 1
PRINT "                                                                 "
LOCATE lctx + 1, lcty + LEN(name$) + 1
PRINT answer$
GOTO done
END IF
answer$ = answer$ + key$
SOUND 1000, .0228
LOCATE lctx + 1, lcty + LEN(name$) + 1
PRINT answer$
END IF
done:
LOOP
FOR x = 1 TO LEN(answer$)
LOCATE lctx + 1, lcty + x + LEN(name$)
delay .005
PRINT CHR$(RND * 235 + 20)
SOUND 1000, .0228
NEXT x
END IF
GOTO ener
donew:
SYSTEM
ener:
END SUB
