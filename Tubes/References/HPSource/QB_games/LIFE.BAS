'===========================================================================
' Subject: LIFE CELL EXAMPLE                  Date: 12-01-95 (11:30)       
'  Author: Ben Ashley                         Code: QB, QBasic, PDS        
'  Origin: alt.lang.basic                   Packet: DEMOS.ABC
'===========================================================================
'>   I am a little dumfounded as to how to search the array. Should I look 
'> for "*" and the count or should I bubble search one space at a time with 
'> a series of 'IF' statements and counting the amount of stars??

'After a bit of tinkering around in QB45, I came up with the following.  Its
'not perfect, but I think it will do the job:

'-----

' Dimension our cell array:

DIM cell$(81, 41)

WIDTH 80, 43

DO
   CLS

   ' Fill in some contents, otherwise there will be no initial growth.  What
   ' values we put here, is all important.

   RANDOMIZE TIMER

   LOCATE 1, 1
   COLOR 15
   PRINT "Life Cell Example - By Ben Ashley 1995,(R) Restarts (ESC) Ends"
   COLOR 12

   FOR f = 0 TO 81: FOR j = 0 TO 41: cell$(f, j) = " ": NEXT j: NEXT f

   FOR f = 1 TO 300
      x = INT(RND(1) * 79) + 1
      y = INT(RND(1) * 39) + 2
      LOCATE y, x
      cell$(x, y) = "*"
      PRINT cell$(x, y)
   NEXT f


   ' Life Loop:


   DO
      FOR f = 1 TO 80
         FOR j = 2 TO 40

               ' Calculate neighbours of cell:

               neighbours = 0
               IF cell$(f - 1, j) = "*" THEN neighbours = neighbours + 1
               IF cell$(f + 1, j) = "*" THEN neighbours = neighbours + 1
               IF cell$(f, j - 1) = "*" THEN neighbours = neighbours + 1
               IF cell$(f, j + 1) = "*" THEN neighbours = neighbours + 1
               IF cell$(f - 1, j - 1) = "*" THEN neighbours = neighbours + 1
               IF cell$(f + 1, j - 1) = "*" THEN neighbours = neighbours + 1
               IF cell$(f - 1, j + 1) = "*" THEN neighbours = neighbours + 1
               IF cell$(f + 1, j + 1) = "*" THEN neighbours = neighbours + 1

               ' What Happens
               '
               ' Neighbours is 2 or 3, it lives.
               ' = 3 born
               ' >=4 Death
               ' <2 Death

               IF cell$(f, j) = " " AND neighbours = 3 THEN cell$(f, j) = "*"
               IF cell$(f, j) = "*" AND neighbours < 2 THEN cell$(f, j) = " "
               IF cell$(f, j) = "*" AND neighbours >= 4 THEN cell$(f, j) = " "
               LOCATE j, f: PRINT cell$(f, j)
        
               ' Check for keypresses

               key$ = INKEY$
               IF key$ <> "" THEN
                  SELECT CASE LCASE$(key$)
                     CASE "r"
                        restart = 1
                        EXIT DO
                     CASE CHR$(27)
                        quit = 1
                        EXIT DO
                  END SELECT
               END IF
         NEXT j
      NEXT f

      IF restart = 1 THEN restart = 0: EXIT DO
      IF quit = 1 THEN EXIT DO
   LOOP
   IF quit = 1 THEN EXIT DO
LOOP
CLS

'------

'Concerning the death rule, (2 or less), I found that killed too many cells,
'so I changed it to LESS than 2.  Any comments?
