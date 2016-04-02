' Write, for FreeBASIC, web: http://rudih.info

Dim filen As String
Dim txt As String

INPUT "Enter name of new file to write: ", filen
OPEN filen FOR OUTPUT AS #1
CLS
PRINT "Enter text or <end> to exit:-"
main:
   INPUT "", txt
   IF txt = "end" OR txt = "END" THEN
     CLOSE #1
     END
   END IF
   PRINT #1, txt
GOTO main:

