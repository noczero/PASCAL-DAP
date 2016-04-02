'QBasic NoBreak v1.0a

'Copyright (c)1995 by Daniel Trimble

'Public Domain - use at your own risk.



CLS

DO

   KEY 15, CHR$(4 + 128 + 32 + 64) + CHR$(70)

   ON KEY(15) GOSUB NoBreak: KEY(15) ON

   KEY 16, CHR$(4 + 128) + CHR$(70): ON KEY(16) GOSUB NoBreak: KEY(16) ON

   KEY 17, CHR$(4 + 128 + 32) + CHR$(70): ON KEY(17) GOSUB NoBreak

   KEY(17) ON: KEY 18, CHR$(4 + 128 + 64) + CHR$(70): ON KEY(18) GOSUB NoBreak

   KEY(18) ON: KEY 19, CHR$(4) + CHR$(70): ON KEY(21) GOSUB NoBreak

   KEY(21) ON: KEY 22, CHR$(4 + 64) + CHR$(70)

   ON KEY(22) GOSUB NoBreak: KEY(22) ON: KEY 23, CHR$(4 + 32) + CHR$(46)

   ON KEY(23) GOSUB NoBreak: KEY(23) ON: KEY 24, CHR$(4 + 64) + CHR$(46)

   ON KEY(24) GOSUB NoBreak: KEY(24) ON

   KEY 25, CHR$(4 + 32 + 64) + CHR$(46): ON KEY(25) GOSUB NoBreak: KEY(25) ON

  

   LOCATE 1, 1, 0: PRINT "QBasic NoBreak v1.0a"

   LOCATE 2, 1, 0: PRINT "Copyright (c)1995 by Daniel Trimble"

   LOCATE 4, 1, 0: PRINT "This program and all source is public domain.  I will not be held responsible"

   LOCATE 5, 1, 0: PRINT "for any damage this program may cause.  I am not at fault; use this at your"

   LOCATE 6, 1, 0: PRINT "own risk - period!"

   LOCATE 15, 1, 0: PRINT "Try pressing either CTRL-BREAK or CTRL-C.  Nothing will happen!"

   LOCATE 16, 1, 0: PRINT "To end the program, hit ENTER."

   IF INKEY$ = CHR$(13) THEN END

LOOP



NoBreak: RETURN

                                                           

                                                           

'ctrl =4          extended keys=128

'num lock=32      c=46

'cap lock=64



