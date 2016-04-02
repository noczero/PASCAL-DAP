'Robert Anthony Moreno II
'Bob666@concentric.net
Randomize Timer
DefInt A-Z
Dim baddirection(10)
Dim badshoot(10)
Dim badshooting(10)
Dim badshotx(10)
Dim badshoty(10)
Dim badx(10)
Dim bady(10)
Dim dead(10)
Dim shooting(10)
Dim shotx(10)
Dim shoty(10)
Dim starc(100)
Dim stars(100)
Dim stari(100)
Dim starx(100)
Dim stary(100)
Cls
LOCATE 11, 26, 0
COLOR 11, 0
Print "Moreno Computer Development!"
LOCATE 13, 26, 0
COLOR 12, 0
Print "   P r e s e n t s . . .    "
SLEEP 3
start:
delay = Val(Command$)
If delay = 0 Then delay = 1000
Screen 13
Cls
PALETTE 31, 0
PALETTE 32, 0
LOCATE 11, 12, 0
COLOR 31
Print "Super"
LOCATE 12, 15, 0
COLOR 32
Print "Galactic Wars"
For c = 0 To 63
 PALETTE 32, c
Next c
For c = 0 To 63
 PALETTE 31, c
Next c
PLAY "MBL25CDEFGAB"
SLEEP 1
PALETTE 1, (63 * 1) + (63 * 256) + (63 * 65536)
PALETTE 2, (55 * 1) + (55 * 256) + (55 * 65536)
PALETTE 3, (45 * 1) + (45 * 256) + (45 * 65536)
PALETTE 4, (40 * 1) + (40 * 256) + (40 * 65536)
PALETTE 8, (50 * 1) + (25 * 256) + (25 * 65536)
PALETTE 9, (25 * 1) + (25 * 256) + (25 * 65536)
PALETTE 10, (40 * 1) + (40 * 256) + (40 * 65536)
PALETTE 11, (20 * 1) + (20 * 256) + (63 * 65536)
PALETTE 12, (63 * 1) + (0 * 256) + (0 * 65536)
PALETTE 20, 0
PALETTE 21, 20
PALETTE 22, 30
PALETTE 23, 40
PALETTE 24, 50
PALETTE 25, 60
For i = 100 To 110
 PALETTE i, 0
Next i
COLOR 11
Do
 If t = 0 Then
  d = 0
  c = 0
 End If
 If t = 100 Then
  d = 1
  c = 11
 End If
 If d = 0 Then t = t + 1
 If d = 1 Then t = t - 1
 COLOR c
 LOCATE 15, 10, 0
 Print "Press Enter To Start"
Loop Until INKEY$ = Chr$(13)
Do: Loop Until INKEY$ = ""
Cls
For i = 0 To 100
 starx(i) = (Rnd * 320)
 stary(i) = (Rnd * 179) + 10
 stars(i) = (Rnd * 3) + 2
 starc(i) = (Rnd * 3) + 1
Next i
For i = 1 To 10
 badx(i) = (Rnd * 195) + 100
 bady(i) = (Rnd * 150) + 25
 baddirection(i) = (Rnd * 3) + 1
Next i
COLOR 1
shield = 5
x = 40
y = 100
Line (0, 9)-(320, 9), 1
Line (0, 190)-(320, 190), 1
LOCATE 25, 1, 0
Print "<Esc> Exit : <P> Pause";
LOCATE 1, 1, 0
Print " Shields:"; shield; " Score:"; score
Do
 For i = 1 To 100
  PSet (starx(i), stary(i)), 0
  stari(i) = stari(i) + 1
  If stari(i) = stars(i) Then
   starx(i) = starx(i) - 1
   stari(i) = 0
  End If
  If starx(i) < 0 Then
   starx(i) = (Rnd * 50) + 320
   stary(i) = (Rnd * 179) + 10
   stars(i) = (Rnd * 3) + 2
   starc(i) = (Rnd * 3) + 1
  End If
  PSet (starx(i), stary(i)), starc(i)
 Next i
 Key$ = INKEY$
 Select Case UCase$(Key$)
  Case Chr$(27): GoTo quit
  Case "P"
   LOCATE 25, 1, 0
   Print String$(40, Chr$(32));
   LOCATE 25, 1, 0
   Print "Game Paused... Press Enter";
   Do: Loop Until INKEY$ = Chr$(13)
   LOCATE 25, 1, 0
   Print String$(40, Chr$(32));
   LOCATE 25, 1, 0
   Print "<Esc> Exit : <P> Pause";
  Case Chr$(13): If shooting = 0 Then shoot = 1
  Case Chr$(0) + "H": direction = 1
  Case Chr$(0) + "P": direction = 2
  Case Chr$(0) + "K": direction = 3
  Case Chr$(0) + "M": direction = 4
  Case Chr$(32): direction = 0
 End Select
 Line (x + 7, y - 4)-(x - 4, y - 4), 0
 Line (x + 7, y + 4)-(x - 4, y + 4), 0
 Line (x + 6, y - 3)-(x + 6, y + 3), 0
 Line (x + 7, y - 3)-(x + 7, y + 3), 0
 Line (x + 8, y - 3)-(x + 8, y + 3), 0
 Line (x + 1, y)-(x - 2, y - 3), 0
 Line (x + 1, y)-(x - 2, y + 3), 0
 Line (x - 4, y - 3)-(x + 3, y - 3), 0
 Line (x - 4, y + 3)-(x + 3, y + 3), 0
 Line (x - 1, y)-(x + 5, y), 0
 Circle (x, y), 10, 0, , , 0.6
 If direction = 1 And y > 25 Then y = y - 1
 If direction = 2 And y < 174 Then y = y + 1
 If direction = 3 And x > 25 Then x = x - 1
 If direction = 4 And x < 295 Then x = x + 1
 If direction = 1 Or direction = 2 Then
  If y = 25 Then direction = 0
  If y = 174 Then direction = 0
 End If
 If direction = 3 Or direction = 4 Then
  If x = 25 Then direction = 0
  If x = 295 Then direction = 0
 End If
 Line (x + 7, y - 4)-(x - 4, y - 4), 100
 Line (x + 7, y + 4)-(x - 4, y + 4), 100
 Line (x + 6, y - 3)-(x + 6, y + 3), 100
 Line (x + 7, y - 3)-(x + 7, y + 3), 100
 Line (x + 8, y - 3)-(x + 8, y + 3), 100
 Line (x + 1, y)-(x - 2, y - 3), 9
 Line (x + 1, y)-(x - 2, y + 3), 9
 Line (x - 4, y - 3)-(x + 3, y - 3), 11
 Line (x - 4, y + 3)-(x + 3, y + 3), 11
 Line (x - 1, y)-(x + 5, y), 10
 Circle (x, y), 10, (shield + 20), , , 0.6
 If shoot = 1 Then
  For i = 1 To 10
   If shooting(i) = 0 Then
    shooting(i) = 1
    shotx(i) = x + 8
    shoty(i) = y
    SOUND 100, 0.05
    Exit For
   End If
  Next i
  shoot = 0
 End If
 For ii = 1 To 10
  If shooting(ii) = 1 Then
   PSet (shotx(ii), shoty(ii)), 0
   shotx(ii) = shotx(ii) + 2
   If shotx(ii) > 320 Then shooting(ii) = 0
   pixel = Point(shotx(ii), shoty(ii))
   If pixel > 100 Then
    die = pixel - 100
    For i = 1 To 10
     Circle (badx(die), bady(die)), i, 12
    Next i
    PLAY "MFL50DC"
    For i = 1 To 10
     Circle (badx(die), bady(die)), i, 0
     SOUND 100, 0.05
    Next i
    score = score + (badx(die) - x)
    LOCATE 1, 1, 0
    Print " Shields:"; shield; " Score:"; score
    i = die
    PSet (shotx(ii), shoty(ii)), 0
    Line (badx(i) - 7, bady(i) + 4)-(badx(i) + 4, bady(i) + 4), 0
    Line (badx(i) - 7, bady(i) - 4)-(badx(i) + 4, bady(i) - 4), 0
    Line (badx(i) - 6, bady(i) + 3)-(badx(i) - 6, bady(i) - 3), 0
    Line (badx(i) - 7, bady(i) + 3)-(badx(i) - 7, bady(i) - 3), 0
    Line (badx(i) - 8, bady(i) + 3)-(badx(i) - 8, bady(i) - 3), 0
    Line (badx(i) + 3, bady(i) + 3)-(badx(i) - 3, bady(i) - 3), 0
    Line (badx(i) + 3, bady(i) - 3)-(badx(i) - 3, bady(i) + 3), 0
    Line (badx(i) - 5, bady(i))-(badx(i) + 2, bady(i)), 0
    dead(i) = 1
    shotx(ii) = 325
   End If
   PSet (shotx(ii), shoty(ii)), 12
  End If
 Next ii
 For i = 1 To 10
  If dead(i) = 0 Then
   If badshooting(i) = 0 And x < badx(i) Then
    If y > bady(i) And direction = 1 Then
     If (y - bady(i)) * 2 <= (badx(i) - x) Then badshoot(i) = 1
    End If
    If y < bady(i) And direction = 2 Then
     If (bady(i) - y) * 2 <= (badx(i) - x) Then badshoot(i) = 1
    End If
    If y = bady(i) And direction = 0 Then badshoot(i) = 1
   End If
   If badshoot(i) = 1 Then
    badshooting(i) = 1
    badshotx(i) = badx(i) - 8
    badshoty(i) = bady(i)
    badshoot(i) = 0
    SOUND 100, 0.05
   End If
   Line (badx(i) - 7, bady(i) + 4)-(badx(i) + 4, bady(i) + 4), 0
   Line (badx(i) - 7, bady(i) - 4)-(badx(i) + 4, bady(i) - 4), 0
   Line (badx(i) - 6, bady(i) + 3)-(badx(i) - 6, bady(i) - 3), 0
   Line (badx(i) - 7, bady(i) + 3)-(badx(i) - 7, bady(i) - 3), 0
   Line (badx(i) - 8, bady(i) + 3)-(badx(i) - 8, bady(i) - 3), 0
   Line (badx(i) + 3, bady(i) + 3)-(badx(i) - 3, bady(i) - 3), 0
   Line (badx(i) + 3, bady(i) - 3)-(badx(i) - 3, bady(i) + 3), 0
   Line (badx(i) - 5, bady(i))-(badx(i) + 2, bady(i)), 0
   If baddirection(i) = 1 And bady(i) > 25 Then bady(i) = bady(i) - 1
   If baddirection(i) = 2 And bady(i) < 174 Then bady(i) = bady(i) + 1
   If baddirection(i) = 3 And badx(i) > 100 Then badx(i) = badx(i) - 1
   If baddirection(i) = 4 And badx(i) < 295 Then badx(i) = badx(i) + 1
   r = (Rnd * 4)
   If baddirection(i) = r Then baddirection(i) = (Rnd * 4)
   If i <= 5 Then
    If direction = 0 And x < badx(i) Then
     If y < bady(i) Then baddirection(i) = 1
     If y > bady(i) Then baddirection(i) = 2
     If y = bady(i) Then baddirection(i) = 0
    End If
    For ii = 1 To 10
     If shotx(ii) > badx(i) - 25 And shotx(ii) < badx(i) + 10 Then
      If shoty(ii) > bady(i) And shoty(ii) < bady(i) + 25 Then baddirection(i) = 1
      If shoty(ii) < bady(i) And shoty(ii) > bady(i) - 25 Then baddirection(i) = 2
      If shoty(ii) = bady(i) Then baddirection(i) = ((Rnd * 1) + 1)
     End If
    Next ii
   End If
   Line (badx(i) - 7, bady(i) + 4)-(badx(i) + 4, bady(i) + 4), (100 + i)
   Line (badx(i) - 7, bady(i) - 4)-(badx(i) + 4, bady(i) - 4), (100 + i)
   Line (badx(i) - 6, bady(i) + 3)-(badx(i) - 6, bady(i) - 3), (100 + i)
   Line (badx(i) - 7, bady(i) + 3)-(badx(i) - 7, bady(i) - 3), (100 + i)
   Line (badx(i) - 8, bady(i) + 3)-(badx(i) - 8, bady(i) - 3), (100 + i)
   Line (badx(i) + 3, bady(i) + 3)-(badx(i) - 3, bady(i) - 3), 11
   Line (badx(i) + 3, bady(i) - 3)-(badx(i) - 3, bady(i) + 3), 11
   Line (badx(i) - 5, bady(i))-(badx(i) + 2, bady(i)), 8
   If Point(x + 8, y - 4) = (100 + i) Then
    For ii = 1 To 10
     Circle (x, y), ii, 12
    Next ii
    PLAY "MFL50C"
    For ii = 1 To 10
     Circle (x, y), ii, 0
     SOUND 100, 0.5
    Next ii
    GoTo lose
   End If
   If Point(x + 8, y + 4) = (100 + i) Then
    For ii = 1 To 10
     Circle (x, y), ii, 12
    Next ii
    PLAY "MFL50C"
    For ii = 1 To 10
     Circle (x, y), ii, 0
     SOUND 100, 0.5
    Next ii
    GoTo lose
   End If
   If Point(x - 4, y - 4) = (100 + i) Then
    For ii = 1 To 10
     Circle (x, y), ii, 12
    Next ii
    PLAY "MFL50C"
    For ii = 1 To 10
     Circle (x, y), ii, 0
     SOUND 100, 0.5
    Next ii
    GoTo lose
   End If
   If Point(x - 4, y + 4) = (100 + i) Then
    For ii = 1 To 10
     Circle (x, y), ii, 12
    Next ii
    PLAY "MFL50C"
    For ii = 1 To 10
     Circle (x, y), ii, 0
     SOUND 100, 0.5
    Next ii
    GoTo lose
   End If
  End If
  If badshooting(i) = 1 Then
   PSet (badshotx(i), badshoty(i)), 0
   badshotx(i) = badshotx(i) - 2
   If badshotx(i) < 0 Then badshooting(i) = 0
   pixel = Point(badshotx(i), badshoty(i))
   If pixel = 100 Then
    PSet (badshotx(i), badshoty(i)), 0
    shield = shield - 1
    badshotx(i) = -5
    If shield = -1 Then
     For ii = 1 To 10
      Circle (x, y), ii, 12
     Next ii
     PLAY "MFL50C"
     For ii = 1 To 15
      Circle (x, y), ii, 0
      SOUND 100, 0.5
     Next ii
    End If
    If shield = 0 Then PLAY "MBL25DCDCDC" Else PLAY "MBL25C"
    LOCATE 1, 1, 0
    Print " Shields:"; shield; " Score:"; score
   End If
   PSet (badshotx(i), badshoty(i)), 12
  End If
  done = done + dead(i)
 Next i
 If done = 10 Then GoTo win Else done = 0
 If shield = -1 Then GoTo lose
 For i = 0 To 50
  For ii = 0 To delay: Next ii
 Next i
Loop
win:
PLAY "MBL25CDEFGAB"
Cls
LOCATE 11, 18, 0
Print "Wow!"
LOCATE 12, 16, 0
Print "You Won!"
LOCATE 14, 15, 0
Print "Press  Esc"
Do: Loop Until INKEY$ = Chr$(27)
Cls
LOCATE 11, 11
Print "Play Again? (Y,N):"
pa$ = INPUT$(1)
If UCase$(pa$) = "Y" Then
 Clear
 GoTo start
End If
End
lose:
PLAY "MBL25BAGFEDC"
Cls
LOCATE 11, 16, 0
Print "Ha Ha Ha"
LOCATE 12, 16, 0
Print "You Died"
LOCATE 14, 15, 0
Print "Press  Esc"
Do: Loop Until INKEY$ = Chr$(27)
Cls
LOCATE 11, 11
Print "Play Again? (Y,N):"
pa$ = INPUT$(1)
If UCase$(pa$) = "Y" Then
 Clear
 GoTo start
End If
End
quit:
PLAY "MBL25BAGFEDC"
Cls
LOCATE 11, 4, 0
Print "Quiters Never Amount To Anything!"
LOCATE 13, 15, 0
Print "Press Enter"
Do: Loop Until INKEY$ = Chr$(13)
End