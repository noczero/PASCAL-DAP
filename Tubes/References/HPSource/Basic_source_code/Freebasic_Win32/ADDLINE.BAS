' Add Line Numbers, for BASIC, http://rudih.info
Dim upto AS Long
Dim filen As String
Dim lin As String
Dim x As String
Input "Enter filename: ", filen
Kill "output.bas"
OPEN filen FOR INPUT AS #1
OPEN "output.bas" FOR OUTPUT AS #2
DO WHILE NOT EOF(1)
    upto = upto + 10
    INPUT #1, lin
    x = STR$(upto) + " " + lin
    PRINT #2, x
LOOP
CLOSE #1
CLOSE #2
Print "Done."
END