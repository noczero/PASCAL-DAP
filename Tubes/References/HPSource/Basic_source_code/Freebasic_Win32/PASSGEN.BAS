' Password generator, for FreeBASIC, http://rudih.info

DIM letter(26) As String
Dim scratch As String 
Dim ucletter As String
Dim z As string
Dim x As Integer
Dim y As Integer
Dim passlength As Integer

PRINT "---PASSWORD GENERATOR---"
INPUT "Enter length of password (e.g. 8): ", passlength
FOR x = 1 TO 26
  y = x + 96
  scratch = STRING$(1, y)
  letter(x) = scratch
NEXT x
RANDOMIZE TIMER
y = INT(RND * 26) + 1
scratch = letter(y)
scratch = UCASE$(scratch)
FOR x = 3 TO passlength
  y = INT(RND * 2) + 1
  y = y MOD 2 + 1
  IF y = 1 THEN
    y = INT(RND * 26) + 1
    scratch = scratch + letter(y)
  END IF
  IF y = 2 THEN
    y = INT(RND * 26) + 1
    ucletter = UCASE$(letter(y))
    scratch = scratch + ucletter
  END IF
NEXT x
y = INT(RND * 10)
z = STR$(y)
z = LTRIM$(z)
scratch = scratch + z
PRINT "Generated password: ";
PRINT scratch
OPEN "password.txt" FOR OUTPUT AS 1
PRINT #1, scratch
CLOSE 1
PRINT "Output saved as 'password.txt'."
PRINT "Press any key to exit."
SLEEP
END

