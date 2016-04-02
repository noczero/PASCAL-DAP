' Arithmetic questioner, for QBasic/QuickBasic, web: http://rudih.info

CLS
PRINT "Arithmetic Questioner - enter a negative number to quit"
INPUT "Set greatest number to add or subtract (1-15990): ", upperadd
IF upperadd <= 0 THEN END
INPUT "Set greatest number to multiply or divide (1-178): ", uppermul
IF uppermul <= 0 THEN END
IF uppermul > 178 OR upperadd > 15990 THEN PRINT "Number too large error"
RANDOMIZE TIMER
user = 1
WHILE user >= 0
    num = INT(RND * 32700)
    den = INT(RND * 32700)
    operat = INT(RND * 4)
    IF operat < 2 THEN
        num = num MOD upperadd
        den = den MOD upperadd
        IF den >= num THEN
            operat = 0
            PRINT num; " + "; den; " = ";
        ELSE
            operat = 1
            PRINT num; " - "; den; " = ";
        END IF
    END IF
    IF operat = 2 THEN
        num = num MOD uppermul
        den = den MOD uppermul
        num = num + 1
        den = den + 1
        PRINT num; " * "; den; " = ";
    END IF
    IF operat = 3 THEN
        num = num MOD uppermul
        den = den MOD uppermul
        num = num + 1
        den = den + 1
        division = num * den
        PRINT division; " / "; den; " = ";
    END IF
    INPUT "", user
    IF operat = 0 THEN
        result = num + den
        IF user = result THEN
           PRINT "Correct"
        ELSE
           PRINT "Incorrect, it's "; result
        END IF
    END IF
    IF operat = 1 THEN
        result = num - den
        IF user = result THEN
           PRINT "Correct"
        ELSE
           PRINT "Incorrect, it's "; result
        END IF
    END IF
    IF operat = 2 THEN
        result = num * den
        IF user = result THEN
           PRINT "Correct"
        ELSE
           PRINT "Incorrect, it's "; result
        END IF
    END IF
    IF operat = 3 THEN
        result = division / den
        IF user = result THEN
           PRINT "Correct"
        ELSE
           PRINT "Incorrect, it's "; result
        END IF
    END IF
WEND
END

