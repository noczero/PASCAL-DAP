' List, for QBasic/QuickBasic, web: http://rudih.info

load:
CLS
INPUT "Enter filename to list: ", filen$
page = 0
CLOSE 1
ON ERROR GOTO load
OPEN filen$ FOR INPUT AS #1

feed:
CLS
page = page + 1
PRINT "Press <O>pen to reload or <Esc> to exit - page:";
PRINT page
feed = 21
WHILE feed <> 0
 IF EOF(1) THEN
    PRINT "---End of file---"
    x$ = ""
    WHILE x$ = ""
       x$ = INKEY$
    WEND
    END
 END IF
 LINE INPUT #1, line$
 PRINT line$
 feed = feed - 1
WEND
PRINT "Press any key to continue..."

x$ = ""
WHILE x$ = ""
 x$ = INKEY$
WEND
x$ = UCASE$(x$)
IF x$ = "O" THEN GOTO load:
IF x$ = "" THEN
 END
END IF
GOTO feed:

