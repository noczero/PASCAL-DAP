'                                 Hang Man
'                         by Gary N. Wilkerson Jr.
'
'                          For one or two players
'
'     For two player games, one player enters the word and the other
'                          tries to guess the word.
'
'For one player, the computer selects the word for you out of its vocabulary.

DEFINT A-Z

'Constants
CONST TRUE = -1
CONST FALSE = NOT TRUE

' Procedure module prototypes
DECLARE SUB Center (row, text$)
DECLARE SUB Hide ()
DECLARE SUB KeyPause ()
DECLARE SUB MemorySearch ()
DECLARE SUB PlayGame ()
DECLARE SUB Search (char$)
DECLARE FUNCTION IntroScreen ()
DECLARE FUNCTION Yes ()

'Global variables
DIM SHARED SearchFile$
DIM SHARED HiddenWord$, GoalWord$
DIM SHARED LetterUsed$, Chances%, FileName$

' ****************************The main module******************************
     'Sets aside enough space for strings
     CLEAR 500

     DO
          LetterUsed$ = ""
          PlayGame
          KeyPause
          CLS : LOCATE 11, 1
          PRINT "Play again";
     LOOP WHILE Yes
     SYSTEM
' ***************************End of main module****************************

'The computer's vocabulary

DATA Win,Lose,Draw,Bell,Tell,Lie,Spell,Laser,Radio,Stereo
DATA Game,Keys,Donkey,Bubbles,Apples,Oranges,Beans,Rice,Cheese,Bread
DATA Cassette,Ham,Spam,Tuna,Bacon,Eggs,Globe,Shoe,Box,Fox
DATA Calculator,Fat,Television,Movies,White,Shark,Cardboard,Brown,Red,Black
DATA Blue,Peach,Pears,Orange,Yellow,Green,Maze,Pig,Dog,Cat
DATA Mouse,House,Trees,Grass,Porch,Horse,Camel,Zebra,Carpet,Drawers
DATA Christmas,Merry Christmas,Easter,Halloween,Labor Day,Independance Day,Thanksgiving,Flag Day,Mothers Day,Fathers Day
DATA George Washington,Abraham Lincoln,John Kennedy,Theodore Roosevelt,John Adams,Jimmy Carter,Ronald Reagan,Richard Nixon,Gerald Ford,Grover Cleveland
DATA Virginia,North Carolina,South Carolina,Georgia,Florida,Maryland,West Virginia,Maine,Tennessee,Mississippi
DATA United States,Mexico,Canada,Spain,Italy,Russia,Germany,India,England,Gary N. Wilkerson Jr.

' *******************************Center************************************
' Centers the text on a given row
SUB Center (row, text$)
     LOCATE row, 40 - LEN(text$) / 2
     PRINT text$
END SUB

' ***********************************Hide***********************************
' Hides all the letters of the Goal String with dashes on the Hidden String
SUB Hide
     ' Make the hidden word a string of hyphens
     HiddenWord$ = STRING$(LEN(GoalWord$), "-")

     ' Search and replace every character that is non-alphabetic
     FOR t = 1 TO LEN(GoalWord$)
          b$ = UCASE$(MID$(GoalWord$, t, 1))
          IF b$ < "A" OR b$ > "Z" THEN
               MID$(HiddenWord$, t, 1) = MID$(GoalWord$, t, 1)
          END IF
     NEXT t
END SUB

DEFSNG A-Z
' *******************************IntroScreen*******************************
' Displays the intro screen and returns number of players selected
FUNCTION IntroScreen%
     SCREEN 0, , 0: WIDTH 80, 25: CLS     ' Initialize screen

     COLOR 31, 0
     Center 9, "Hang Man!!!"
     COLOR 4
     Center 11, "by Gary N. Wilkerson Jr."
     COLOR 2
     Center 13, "One Player press <1>"
     COLOR 9
     Center 15, "Two player press <2>"
     COLOR 15

     ' Get number of players
     DO: a$ = INPUT$(1): LOOP WHILE a$ < "1" OR a$ > "2"
     IntroScreen% = VAL(a$)
END FUNCTION

DEFINT A-Z
' *******************************KeyPause*********************************
' Suspends program activity until key is pressed
SUB KeyPause
     WHILE INKEY$ <> "": WEND        ' Clears keyboard
     Center CSRLIN, "Press any key to continue"
     WHILE INKEY$ = "": WEND       ' Waits for a key
END SUB

' *****************************Memory Search*******************************
' Searches the computer's vocabulary for a random word
SUB MemorySearch
     RESTORE
     RANDOMIZE TIMER
     FOR t = 1 TO RND * 100
          READ GoalWord$
     NEXT t
END SUB

DEFSNG A-Z
' *******************************PlayGame**********************************
' This is where most of the activity takes place
SUB PlayGame
     ' IntroScreen returns the number of players
     IF IntroScreen = 1 THEN
          MemorySearch
          Hide
     ELSE
          ' Loops while player enters non-alphabetic strings
          DO
               ' Loops while the player enters nothing
               DO
                    PRINT : PRINT "Enter word"
                    LINE INPUT GoalWord$
               LOOP WHILE GoalWord$ = ""
               Hide
          LOOP WHILE HiddenWord$ = GoalWord$
     END IF

     Chances% = 10
    
     ' Do a loop until player wins
     DO UNTIL HiddenWord$ = GoalWord$
          CLS
          PRINT HiddenWord$
          Center 11, "Tries" + STR$(Chances%)
          LOCATE 20, 1
          PRINT LetterUsed$
          Search INPUT$(1)
         
          ' Break the loop if player loses
          IF Chances% < 1 THEN EXIT DO
     LOOP

     CLS
     IF Chances% < 1 THEN
          ' Computer wins if player runs out of tries
          PRINT GoalWord$
          COLOR 20
          Center 22, "I win."
          COLOR 15
     ELSE
          ' Player wins if HiddenWord$ and GoalWord$ are exact
          PRINT HiddenWord$
          COLOR 30
          Center 22, "You win!"
          COLOR 15
     END IF
END SUB

' ********************************Search**********************************
' Searches the Goal String for a character
' and replaces the Hidden String if any characters are found
'
SUB Search (char$)
     'Character must be A-Z
     IF UCASE$(char$) < "A" OR UCASE$(char$) > "Z" THEN EXIT SUB

     LetterUsed$ = LetterUsed$ + char$

     IF INSTR(UCASE$(GoalWord$), UCASE$(char$)) = 0 THEN
          Chances% = Chances% - 1           'Lose one chance if character
          EXIT SUB                        'was not found
     END IF

     'Search and replace every matched character
     FOR t = 1 TO LEN(GoalWord$)
          IF UCASE$(MID$(GoalWord$, t, 1)) = UCASE$(char$) THEN
               MID$(HiddenWord$, t, 1) = MID$(GoalWord$, t, 1)
          END IF
     NEXT t

     ' Play a victory sound
     PLAY "MBt255l64o3cdefgabcdefgabcdefgab"
END SUB

DEFINT A-Z
' ********************************Yes************************************
' Returns TRUE for yes, FALSE for no
FUNCTION Yes
     WHILE INKEY$ <> "": WEND        ' Clear keyboard
    
     ' Get response
     PRINT " (y/n)"
     DO
          a$ = UCASE$(INPUT$(1))
     LOOP UNTIL a$ = "Y" OR a$ = "N"
    
     IF a$ = "Y" THEN Yes = TRUE ELSE Yes = FALSE
END FUNCTION

