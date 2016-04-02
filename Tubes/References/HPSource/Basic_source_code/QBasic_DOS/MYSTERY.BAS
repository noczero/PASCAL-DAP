' Mystery calculator, for QBasic, http://rudih.info

' In this game the computer determines a secret number.
' The idea came from a card trick.

CLS
PRINT "---THE MYSTERY CALCULATOR---"
INPUT "Choose a card 1 to 6: ", usercard
IF usercard < 0 OR usercard > 6 THEN
  PRINT "Invalid input."
  SLEEP
  END
END IF
PRINT
PRINT "Choose any number from this card and remember it:"
IF usercard = 1 THEN GOSUB card1:
IF usercard = 2 THEN GOSUB card2:
IF usercard = 3 THEN GOSUB card3:
IF usercard = 4 THEN GOSUB card4:
IF usercard = 5 THEN GOSUB card5:
IF usercard = 6 THEN GOSUB card6:
INPUT "Press enter to continue...", x
answer = 0
GOSUB card1:
INPUT "Does your number appear on this card (Y/N)? ", card$
card$ = UCASE$(card$)
IF card$ = "Y" THEN answer = answer + 1
GOSUB card2:
INPUT "Does your number appear on this card (Y/N)? ", card$
card$ = UCASE$(card$)
IF card$ = "Y" THEN answer = answer + 2
GOSUB card3:
INPUT "Does your number appear on this card (Y/N)? ", card$
card$ = UCASE$(card$)
IF card$ = "Y" THEN answer = answer + 4
GOSUB card4:
INPUT "Does your number appear on this card (Y/N)? ", card$
card$ = UCASE$(card$)
IF card$ = "Y" THEN answer = answer + 8
GOSUB card5:
INPUT "Does your number appear on this card (Y/N)? ", card$
card$ = UCASE$(card$)
IF card$ = "Y" THEN answer = answer + 16
GOSUB card6:
INPUT "Does your number appear on this card (Y/N)? ", card$
card$ = UCASE$(card$)
IF card$ = "Y" THEN answer = answer + 32
PRINT "Your number is: "; answer; ". Press any key to exit."
SLEEP
END

card1:
PRINT
PRINT "1  3  5  7  9  11 13 15"
PRINT "17 19 21 23 25 27 29 31"
PRINT "33 35 37 39 41 43 45 47"
PRINT "49 51 53 55 57 59 61 63"
PRINT
RETURN

card2:
PRINT
PRINT "2  3  6  7  10 11 14 15"
PRINT "18 19 22 23 26 27 30 31"
PRINT "34 35 38 39 42 43 46 47"
PRINT "50 51 54 55 58 59 62 63"
PRINT
RETURN

card3:
PRINT
PRINT "4  5  6  7  12 13 14 15"
PRINT "20 21 22 23 28 29 30 31"
PRINT "36 37 38 39 44 45 46 47"
PRINT "52 53 54 55 60 61 62 63"
PRINT
RETURN

card4:
PRINT
PRINT "8  9  10 11 12 13 14 15"
PRINT "24 25 26 27 28 29 30 31"
PRINT "40 41 42 43 44 45 46 47"
PRINT "56 57 58 59 60 61 62 63"
PRINT
RETURN

card5:
PRINT
PRINT "16 17 18 19 20 21 22 23"
PRINT "24 25 26 27 28 29 30 31"
PRINT "48 49 50 51 52 53 54 55"
PRINT "56 57 58 59 60 61 62 63"
PRINT
RETURN

card6:
PRINT
PRINT "32 33 34 35 36 37 38 39"
PRINT "40 41 42 43 44 45 46 47"
PRINT "48 49 50 51 52 53 54 55"
PRINT "56 57 58 59 60 61 62 63"
PRINT
RETURN

