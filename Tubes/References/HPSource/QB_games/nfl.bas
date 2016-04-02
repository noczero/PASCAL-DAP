CLS
FOR y = 1 TO 10
LOCATE y, 30
COLOR 2
PRINT "N"
COLOR 0
SOUND 0, 1.5
LOCATE y, 30
PRINT " "
NEXT y
LOCATE y, 30
COLOR 2
PRINT "N"
FOR y = 22 TO 12 STEP -1
LOCATE y, 32
COLOR 3
PRINT "F"
COLOR 0
SOUND 0, 1.5
LOCATE y, 32
PRINT " "
NEXT y
LOCATE y, 32
COLOR 3
PRINT "F"
FOR y = 1 TO 10
LOCATE y, 34
COLOR 4
PRINT "L"
COLOR 0
SOUND 0, 1.5
LOCATE y, 34
PRINT " "
NEXT y
LOCATE y, 34
COLOR 4
PRINT "L"
FOR y = 22 TO 14 STEP -1
LOCATE y, 26
COLOR 15
PRINT "Created by:"
COLOR 0
SOUND 0, 2
LOCATE y, 26
PRINT "           "
NEXT y
LOCATE y, 26
COLOR 15
PRINT "Created by:"
FOR y = 1 TO 12
LOCATE y, 38
COLOR 10
PRINT "Brian Emmer"
COLOR 0
SOUND 0, 2
LOCATE y, 38
PRINT "           "
NEXT y
LOCATE y, 38
COLOR 10
PRINT "Brian Emmer"
SLEEP
CLS
COLOR 7
RANDOMIZE TIMER
kickingteam = 1
1 CLS
PRINT "1.  Detroit Lions"
PRINT "2.  Dallas Cowboys"
PRINT "3.  Green Bay Packers"
PRINT "4.  San Francisco 49ers"
PRINT "5.  Kansas City Chiefs"
PRINT "6.  Denver Broncos"
PRINT "7.  Miami Dolphins"
PRINT "8.  Buffalo Bills"
PRINT "9.  Oakland Raiders"
PRINT "10.  Philadelphia Eagles"
PRINT
FOR start = 1 TO 2
  IF start = 1 THEN
   INPUT "Select OPPONENT:", team
   ELSE
    INPUT "Select YOUR team:", team
   END IF
  ON team GOSUB lions, cowboys, packers, niners, chiefs, broncos, dolphins, bills, raiders, eagles
  IF team <> INT(team) OR team < 0 OR team > 30 OR team$ = opteam$ THEN GOTO 1
  IF start = 1 THEN GOSUB opteam
NEXT start
GOSUB changequarter
GOSUB cointoss
GOSUB kickoff
yardstogo = 10
down = 1
DO
IF ball = 0 THEN GOSUB offense
IF ball = 1 THEN GOSUB defense
LOOP UNTIL INKEY$ = CHR$(27)
END

offense:
WHILE ball = 0
2 CLS
time = INT(RND * 20) + 20
IF sec - time < 0 THEN
   min = min - 1
   sec = 60 - (time - sec)
  ELSE
   sec = sec - time
END IF
IF min < 0 THEN GOSUB changequarter
PRINT "Quarter:"; quarter, "Time:  "; min; ":";
IF sec < 10 THEN
  IF sec = 9 THEN PRINT " 09"
  IF sec = 8 THEN PRINT " 08"
  IF sec = 7 THEN PRINT " 07"
  IF sec = 6 THEN PRINT " 06"
  IF sec = 5 THEN PRINT " 05"
  IF sec = 4 THEN PRINT " 04"
  IF sec = 3 THEN PRINT " 03"
  IF sec = 2 THEN PRINT " 02"
  IF sec = 1 THEN PRINT " 01"
  IF sec = 0 THEN PRINT " 00"
 ELSE
  PRINT sec
END IF
IF side$ = "the other" AND yardstogo >= ln THEN
  PRINT "It is"; down; "down and goal to go."
 ELSE
  PRINT "It is"; down; "down with"; yardstogo; "yards to go."
END IF
PRINT "The ball is on "; side$; ln
PRINT "Pass"
PRINT "  1.  Quick Slant"
PRINT "  2.  Short Curl"
PRINT "  3.  Long pass"
PRINT "Run"
PRINT "  4.  Inside run"
PRINT "  5.  Sweep"
PRINT "  6.  Draw"
PRINT "Special Teams"
PRINT "  7.  Punt"
PRINT "  8.  Kick field goal"
INPUT "Select play"; pl
PRINT
PRINT
SELECT CASE pl
CASE 1
 GOSUB quickslant
CASE 2
 GOSUB quickslant
CASE 3
 GOSUB longpass
CASE 4
 GOSUB insiderun
CASE 5
 GOSUB insiderun
CASE 6
 GOSUB insiderun
CASE 7
 GOSUB punt
CASE 8
 GOSUB fieldgoal
CASE ELSE
 GOTO 2
END SELECT
IF yards >= yardstogo THEN
  yardstogo = 10
  down = 1
 ELSE yardstogo = yardstogo - yards: down = down + 1
  END IF
IF side$ = "own" THEN
  IF ln + yards > 50 THEN
   side$ = "the other"
   ln = 100 - (yards + ln)
  ELSE ln = ln + yards
   END IF
 ELSE ln = ln - yards
END IF
IF side$ = "the other" AND ln <= 0 THEN GOSUB touchdown
IF down = 5 THEN
  PRINT "Loss of downs."
  ball = 1
  GOSUB defense
  END IF
WEND
RETURN

defense:
down = 1
yardstogo = 10
IF ball = 0 THEN SLEEP: GOSUB offense
5 CLS
WHILE ball = 1
PRINT "It is"; down; "down with"; yardstogo; "yards to go."
PRINT "The ball is on "; side$; ln
time = INT(RND * 20) + 20
IF sec - time < 0 THEN
   min = min - 1
   sec = 60 - (time - sec)
  ELSE
   sec = sec - time
END IF
IF min < 0 THEN GOSUB changequarter
PRINT "Quarter:"; quarter, "Time:  "; min; ":";
IF sec < 10 THEN
  IF sec = 9 THEN PRINT " 09"
  IF sec = 8 THEN PRINT " 08"
  IF sec = 7 THEN PRINT " 07"
  IF sec = 6 THEN PRINT " 06"
  IF sec = 5 THEN PRINT " 05"
  IF sec = 4 THEN PRINT " 04"
  IF sec = 3 THEN PRINT " 03"
  IF sec = 2 THEN PRINT " 02"
  IF sec = 1 THEN PRINT " 01"
  IF sec = 0 THEN PRINT " 00"
 ELSE
  PRINT sec
END IF
IF down = 4 THEN
     IF side$ = "own" AND ln <= 38 THEN
          PRINT opteam$; " will attempt to kick a field goal."
          SLEEP
          GOSUB opfg
         ELSE
          PRINT opteam$; " decide to punt."
          SLEEP
          GOSUB punt
         END IF
END IF
PRINT "Defenses"
PRINT "  1.  Prevent"
PRINT "  2.  Goal line"
PRINT "  3.  Stop run"
PRINT "  4.  Tight coverage"
PRINT "  5.  Blitz"
INPUT "Select play"; pld
IF side$ = "own" AND min < 1 AND (quarter = 2 OR quarter = 4) AND sec < 40 THEN GOSUB opfg
SELECT CASE pld
CASE 1
 GOSUB prevent
CASE 2
 GOSUB blitz
CASE 3
 GOSUB blitz
CASE 4
 GOSUB blitz
CASE 5
 GOSUB blitz
CASE ELSE
 GOTO 5
END SELECT
IF yards >= yardstogo THEN
  yardstogo = 10
  down = 1
  ELSE yardstogo = yardstogo - yards: down = down + 1
  END IF
IF down = 5 THEN
  PRINT "Loss of downs."
  SLEEP
  down = 1
  yardstogo = 10
  ball = 0
  GOSUB offense
  END IF
IF side$ = "the other" THEN
 IF ln + yards > 50 THEN
  side$ = "own"
  ln = 100 - (yards + ln)
  ELSE ln = ln + yards
  END IF
 ELSE ln = ln - yards
END IF
SLEEP
CLS
IF side$ = "own" AND ln <= 0 THEN GOSUB touchdown
IF side$ = "the other" AND ln <= 0 THEN GOSUB safety
WEND
RETURN

changequarter:
min = 15
sec = 0
quarter = quarter + 1
IF quarter = 3 THEN GOSUB halftime
IF quarter >= 5 THEN GOSUB endofgame
GOSUB scoreboard
CLS
RETURN

halftime:
CLS
LOCATE 12, 30
COLOR 31
PRINT "Halftime!"
COLOR 7
SLEEP
GOSUB gamestats
SLEEP
kickingteam = halfteam
GOSUB kickoff
RETURN


opfg:
PRINT opkicker$; " kicks it up and it is..."
SLEEP
chance = INT(RND * 100) + 1
IF ln < 20 THEN IF chance <= 85 THEN GOSUB opgood
IF ln > 20 AND ln <= 32 THEN IF chance <= 60 THEN GOSUB opgood
IF ln > 32 THEN IF chance <= 40 THEN GOSUB opgood
GOSUB opnogood
RETURN

opgood:
PRINT "  good!"
SLEEP
opscore = opscore + 3
GOSUB scoreboard
kickingteam = 1
GOSUB kickoff
RETURN

opnogood:
PRINT "  no good."
SLEEP
GOSUB scoreboard
GOSUB turnover
RETURN


PRINT opkicker$;


prevent:
PRINT "The defense settles back in prevent defense..."
SLEEP
PRINT "  ";
chance = INT(RND * 100) + 1
IF chance <= 5 THEN
  yards = 0
  GOSUB selectsec
  PRINT " comes up big with the interception!"
  GOSUB turnover
END IF
IF chance > 5 AND chance <= 15 THEN
  yards = INT(RND * 20) + 10
  IF side$ = "own" AND yards > ln THEN yards = ln
  GOSUB selectsec
  runorpass = INT(RND * 3) + 1
  IF runorpass = 1 THEN
    defrun = defrun + yards
    runorpass$ = "run"
   ELSE
    defpass = defpass + yards
    runorpass$ = "pass"
   END IF
  PRINT " nearly picks it off but the "; opteam$; " pick up"; yards; "."
END IF
IF chance > 15 AND chance < (.45 * defense) THEN
  yards = 0
  GOSUB selectsec
  PRINT " causes the incomplete pass."
END IF
IF chance > (.45 * defense) THEN
  yards = INT(RND * 9) + 2
  IF side$ = "own" AND yards > ln THEN yards = ln
  GOSUB selectsec
  PRINT " makes the tackle after a short gain of"; yards;
  runorpass = INT(RND * 3) + 1
  IF runorpass = 1 THEN
    defrun = defrun + yards
    PRINT "by "; oprb$; "."
   ELSE
    defpass = defpass + yards
    PRINT "on the pass from "; opqb$; "."
    seloprec = INT(RND * 2) + 1
   END IF
END IF
RETURN

turnover:
SLEEP
yardstogo = 10
down = 1
IF ball = 0 THEN ball = 1 ELSE ball = 0
IF ball = 1 THEN GOSUB defense ELSE GOSUB offense
RETURN

longpass:
PRINT qb$; " drops back looking deep down field..."
SLEEP
chance = INT(RND * 100) + 1
IF chance <= (.4 * qb) THEN
  yards = INT(RND * 35) + 25
  qbatt = qbatt + 1
  qbcomps = qbcomps + 1
  IF side$ = "the other" AND yards > ln THEN yards = ln
  PRINT "  and finds an open ";
  GOSUB selectrec
  PRINT " for a gain of"; yards; "yards."
  IF selrec = 1 THEN wr1yards = wr1yards + yards ELSE wr2yards = wr2yards + yards
  qbyards = qbyards + yards
  selrec = 0
 ELSE GOSUB sackorint
END IF
SLEEP
CLS
RETURN

sackorint:
soi = INT(RND * 10) + 1
  IF soi = 1 THEN
        yards = 0
        qbatt = qbatt + 1
        qbint = qbint + 1
        PRINT "  and is intercepted!"
        GOSUB turnover
  END IF
  IF soi = 2 THEN
        yards = 0 - (INT(RND * 4) + 4)
        PRINT "  and is sacked for a loss of"; -1 * yards
  END IF
  IF NOT soi = 1 AND NOT soi = 2 THEN GOSUB incomplete
RETURN

incomplete:
yards = 0
incchance = INT(RND * 3) + 1
IF incchance = 1 THEN
  PRINT "  and overthrows ";
  GOSUB selectrec
  PRINT "."
END IF
IF incchance = 2 THEN
  PRINT "  and throws an incomplete pass toward ";
  GOSUB selectrec
  PRINT "."
END IF
IF incchance = 3 THEN
  PRINT "  and just misses ";
  GOSUB selectrec
  PRINT ", incomplete pass."
END IF
qbatt = qbatt + 1
RETURN

selectrec:
selrec = INT(RND * 2) + 1
IF selrec = 1 THEN PRINT rec1$;  ELSE PRINT rec2$;
RETURN

insiderun:
PRINT rb$; " takes the hand-off..."
SLEEP
chance = INT(RND * 100) + 1
IF chance <= 10 THEN
  badchance = INT(RND * 4) + 1
  IF badchance = 1 THEN GOSUB fumble ELSE GOSUB loss
  END IF
IF chance > 10 AND chance <= 20 THEN
  yards = INT(RND * 30) + 10
  yards = INT(rb * .01 * yards)
  IF side$ = "the other" AND yards > ln THEN yards = ln
  PRINT "  and bursts through the hole for a big gain of"; yards; "yards."
  END IF
IF chance > 20 THEN
  yards = INT(RND * 8) + 2
  yards = INT(rb * .01 * yards)
  IF side$ = "the other" AND yards > ln THEN yards = ln
  PRINT "  and runs for a gain of"; yards; "yards."
  END IF
rbyards = rbyards + yards
rbruns = rbruns + 1
SLEEP
CLS
RETURN

loss:
yards = -1 - INT(RND * 5)
PRINT "  and is brought down in the backfield for a loss of"; -1 * yards; "yards."
RETURN

fumble:
yards = 0
PRINT " the ball is stripped.  Fumble!"
GOSUB turnover
RETURN

quickslant:
PRINT qb$; " drops back looking for an open receiver..."
SLEEP
chance = INT(RND * 100) + 1
IF chance <= 60 THEN GOSUB comp
IF chance > 60 AND chance <= 70 THEN GOSUB sackorint
IF chance > 70 THEN GOSUB incomplete
SLEEP
CLS
RETURN

comp:
yards = INT(RND * 10) + 5
IF side$ = "the other" AND yards > ln THEN yards = ln
PRINT "  and finds ";
GOSUB selectrec
PRINT " for a gain of"; yards; "yards."
IF selrec = 1 THEN wr1yards = wr1yards + yards ELSE wr2yards = wr2yards + yards
qbyards = qbyards + yards
selrec = 0
qbatt = qbatt + 1
qbcomps = qbcomps + 1
RETURN

touchdown:
CLS
LOCATE 15, 30
PRINT "TOUCHDOWN!"
SLEEP
IF ball = 0 THEN score = score + 6 ELSE opscore = opscore + 6
GOSUB scoreboard
pat = 1
distance = 0
IF ball = 1 THEN GOSUB oppat ELSE GOSUB kick
pat = 0
kickingteam = ball
GOSUB kickoff
RETURN

oppat:
CLS
PRINT opkicker$; " gets set to kick the extra point.  It's up and it is..."
SLEEP
chance = INT(RND * 100) + 1
IF chance <= 98 THEN
  PRINT "  good!"
  opscore = opscore + 1
 ELSE
  PRINT "  is blocked by ";
  GOSUB selectdef
  PRINT " .  No good!"
 END IF
SLEEP
GOSUB scoreboard
kickingteam = 1
GOSUB kickoff
RETURN



safety:
SLEEP
CLS
PRINT "SAFETY!!!"
IF ball = 0 THEN opscore = opscore + 2 ELSE score = score + 2
GOSUB scoreboard
kickingteam = ball
GOSUB kickoff
RETURN

kickoff:
CLS
IF kickingteam = 1 THEN PRINT opteam$;  ELSE PRINT team$;
PRINT " get set to kick off..."
SLEEP
ln = INT(RND * 20) + 15
PRINT "  the kick sails deep where it is caught and returned to the"; ln; "yard line."
SLEEP
down = 1
yardstogo = 10
IF kickingteam = 1 THEN
  ball = 0
  side$ = "own"
  GOSUB offense
 ELSE
  ball = 1
  side$ = "the other"
  GOSUB defense
END IF
RETURN

blitz:
PRINT "The defense blitzes..."
SLEEP
PRINT "  ";
chance = INT(RND * 100) + 1
IF chance <= 10 THEN
  yards = INT(RND * 25) + 10
  IF side$ = "own" AND yards > ln THEN yards = ln
  GOSUB selectsec
  PRINT " is burnt for a big gain of"; yards; "yards."
  END IF
IF defense <= 100 THEN deflim = 50
IF defense <= 90 THEN deflim = 45
IF defense <= 80 THEN deflime = 40
IF defense <= 70 THEN deflim = 35
IF defense <= 60 THEN deflim = 30
IF chance > 10 AND chance <= 16 THEN GOSUB opfumble
IF chance > 16 AND chance <= 20 THEN GOSUB opint
IF chance > 20 AND chance <= deflim THEN GOSUB stuff
IF chance > deflim THEN GOSUB beaten
RETURN

opint:
PRINT "  ";
GOSUB selectsec
PRINT " picks off the pass by "; opqb$; " .  Interception!"
GOSUB turnover
RETURN


opfumble:
yards = 0
GOSUB selectdef
PRINT " smashes "; opqb$; " knocking the ball loose and ";
GOSUB selectsec
PRINT " picks up the loose ball!"
GOSUB turnover
RETURN

beaten:
yards = INT(RND * 10) + 5
GOSUB selectsec
PRINT "  makes the tackle after a"; yards; "yard gain."
rop = INT(RND * 3) + 1
IF rop <> 2 THEN defpass = defpass + yards ELSE defrun = defrun + yards
RETURN

selectsec:
selsec = INT(RND * 2) + 1
IF selsec = 1 THEN PRINT sec1$;  ELSE PRINT sec2$;
RETURN

stuff:
GOSUB selectdef
stuffchance = INT(RND * 2) + 1
IF stuffchance = 1 THEN
  yards = -1 - INT(RND * 3)
  PRINT " stuffs the run for a loss of"; -1 * yards
  defrun = defrun + yards
 ELSE
  yards = -3 - INT(RND * 4)
  PRINT " hammers "; opqb$; " for a"; -1 * yards; "yard loss."
  defpass = defpass + yards
 END IF
RETURN

selectdef:
seldef = INT(RND * 3) + 1
IF seldef = 1 THEN PRINT defline1$;
IF seldef = 2 THEN PRINT defline2$;
IF seldef = 3 THEN PRINT lb1$;
RETURN

cointoss:
CLS
PRINT "The referee flips the coin and indicates that the ";
coin = INT(RND * 2) + 1
IF coin = 1 THEN
  PRINT team$
  kickingteam = 0
  halfteam = 1
 ELSE
  PRINT opteam$
  kickingteam = 1
  halfteam = 0
 END IF
PRINT " will kick off."
SLEEP
GOSUB kickoff
RETURN

punt:
CLS
dist = INT(RND * 15) + 35
IF ball = 1 AND dist + ln > 50 AND side$ = "own" THEN
  dist = ln
  PRINT "Touchback"
  ln = 20
  side$ = "own"
END IF
IF ball = 0 AND dist + ln > 50 AND side$ = "the other" THEN
  dist = ln
  PRINT "Touchback"
  ln = 20
  side$ = "the other"
END IF
IF ball = 1 AND dist + ln > 50 AND side$ = "the other" THEN
  ln = 100 - (dist + ln)
  side$ = "own"
END IF
IF ball = 0 AND dist + ln > 50 AND side$ = "own" THEN
  ln = 100 - (dist + ln)
  side$ = "the other"
END IF
IF NOT dist + ln > 50 THEN ln = ln + dist
IF ball = 0 THEN PRINT city$;  ELSE PRINT opcity$;
PRINT " kicks it deep where it is returned to "; side$; " "; ln; "yard line."
PRINT "  A"; dist; "yard punt."
GOSUB turnover
RETURN

fieldgoal:
IF side$ = "own" THEN distance = 50 + (50 - ln) ELSE distance = ln
IF distance >= 35 THEN speed = kicker * .01 * .2
IF distance < 35 AND distance >= 25 THEN speed = kicker * .01 * .25
IF distance < 25 THEN speed = kicker * .01 * .3
pat = 0
GOSUB kick
IF x >= 30 AND x <= 40 THEN
  kickingteam = ball
  GOSUB kickoff
  END IF
GOSUB turnover
RETURN




kick:
CLS
PRINT
FOR a = 1 TO 5
PRINT TAB(30); "|         |"
NEXT a
PRINT TAB(30); "-----------"
FOR a = 1 TO 3
PRINT TAB(30); "     |"
NEXT a
LOCATE 25, 25
PRINT "Press (K) to kick"
x = 20
b = 0
DO
IF b = 0 THEN x = x + 1 ELSE x = x - 1
LOCATE 15, x
PRINT "^"
IF pat = 0 THEN SOUND 0, speed ELSE SOUND 0, .25
LOCATE 15, x
PRINT "  "
IF x = 60 THEN b = 1
IF x = 20 THEN b = 0
LOOP UNTIL INKEY$ = "k"
LOCATE 15, x
PRINT "^"
FOR y = 15 TO 5 STEP -1
LOCATE y, x
PRINT "o"
SOUND 0, 2
LOCATE y, x
PRINT " "
NEXT y
LOCATE y, x
PRINT "o"
IF distance > 45 THEN x = 10: LOCATE 22, 10: PRINT kicker$; " leaves it short.  He's no Tom Dempsey."
IF x >= 30 AND x <= 40 THEN
   LOCATE 1, 32
   PRINT "It's good!"
   IF pat = 1 THEN
     score = score + 1
    ELSE
     score = score + 3
    END IF
  ELSE
   LOCATE 1, 32
   PRINT "No good."
END IF
IF x = 35 THEN
   FOR y = 9 TO 7 STEP -1
     LOCATE y, 30
     PRINT "     |"
   NEXT y
END IF
SLEEP
pat = 0
GOSUB scoreboard
RETURN

scoreboard:
CLS
LOCATE 3, 10
FOR count = 1 TO 60
PRINT "*";
NEXT count
FOR c = 1 TO 15
PRINT "         *                                                          *"
NEXT c
LOCATE 19, 10
FOR count = 1 TO 60
PRINT "*";
NEXT count
LOCATE 6, 25
PRINT opteam$
LOCATE 6, 45
PRINT team$
LOCATE 8, 27
PRINT opscore
LOCATE 8, 47
PRINT score
LOCATE 15, 30
IF final = 1 THEN PRINT "GAME OVER"
IF NOT final = 1 THEN
PRINT "Quarter: "; quarter
LOCATE 16, 30
PRINT "Time: "; min; ":";
IF sec < 10 THEN
  IF sec = 9 THEN PRINT " 09"
  IF sec = 8 THEN PRINT " 08"
  IF sec = 7 THEN PRINT " 07"
  IF sec = 6 THEN PRINT " 06"
  IF sec = 5 THEN PRINT " 05"
  IF sec = 4 THEN PRINT " 04"
  IF sec = 3 THEN PRINT " 03"
  IF sec = 2 THEN PRINT " 02"
  IF sec = 1 THEN PRINT " 01"
  IF sec = 0 THEN PRINT " 00"
 ELSE
  PRINT sec
END IF
END IF
SLEEP
RETURN

ot:
LOCATE 12, 30
PRINT "Overtime!!!"
SLEEP
GOSUB cointoss
RETURN


endofgame:
GOSUB gamestats
GOSUB scoreboard
IF score = opscore THEN GOSUB ot
END
RETURN

gamestats:
CLS
PRINT "GAME STATISTICS"
PRINT
PRINT "Quarterback"
PRINT qb$
PRINT " Yards", " Completions", "Attempts", "Percentage";
PRINT TAB(60); "Average"
IF qbatt > 0 THEN qbper = 100 * (qbcomps / qbatt) ELSE qbper = 0
PRINT qbyards, qbcomps, qbatt,
PRINT USING "###.##"; qbper;
IF qbcomps > 0 THEN qbave = qbyards / qbcomps ELSE qbave = 0
PRINT TAB(60); USING "###.##"; qbave;
PRINT " yards"
PRINT
PRINT "Wide Receivers"
PRINT rec1$;
PRINT TAB(40); rec2$
PRINT wr1yards; "yards";
PRINT TAB(40); wr2yards; "yards"
PRINT
PRINT "Running Back"
PRINT rb$
PRINT "yards", "attempts", "average"
IF rbruns > 0 THEN rbave = rbyards / rbruns ELSE rbave = 0
PRINT rbyards, rbruns,
PRINT USING "###.##"; rbave
PRINT
PRINT "Team Totals"
PRINT , "Offense", , "Defense"
PRINT "Running", rbyards, , defrun
PRINT "Passing", qbyards, , defpass
SLEEP
IF quarter > 4 AND score <> opscore THEN final = 1
RETURN

opteam:
oprb$ = rb$
oprb = rb
opqb$ = qb$
opqb = qb
oprec1$ = rec1$
oprec2$ = rec2$
opdefline1$ = defline1$
opdefline2$ = defline2$
oplb1$ = lb$
opsec1$ = sec1$
opsec2$ = sec2$
opdefense = defense
opcity$ = city$
opteam$ = team$
opkicker$ = kicker$
RETURN

lions:
rb$ = "Barry Sanders"
rb = 99
qb$ = "Scott Mitchell"
qb = 75
rec1$ = "Herman Moore"
rec2$ = "Brett Perriman"
defline1$ = "Henry Thomas"
defline2$ = "Robert Porcher"
lb1$ = "Pepper Johnson"
sec1$ = "Ryan McNeil"
sec2$ = "Bennie Blades"
defense = 65
city$ = "Detroit"
team$ = "Lions"
kicker$ = "Jason Hanson"
kicker = 90
RETURN

cowboys:
rb$ = "Emmitt Smith"
rb = 70
qb$ = "Troy Aikman"
qb = 80
rec1$ = "Michael Irvin"
rec2$ = "Deion Sanders"
defline1$ = "Tony Tolbert"
defline2$ = "Leon Lett"
lb1$ = "Charles Haley"
sec1$ = "Deion Sanders"
sec2$ = "Darren Woodson"
defense = 85
city$ = "Dallas"
team$ = "Cowboys"
kicker$ = "Chris Boniol"
kicker = 80
RETURN

packers:
rb$ = "Edgar Bennett"
rb = 60
qb$ = "Brett Favre"
qb = 95
rec1$ = "Robert Brooks"
rec2$ = "Anthony Morgan"
defline1$ = "Reggie White"
defline2$ = "Sean Jones"
lb1$ = "George Koonce"
sec1$ = "Le Roy Butler"
sec2$ = "Eugene Robinson"
defense = 85
city$ = "Green Bay"
team$ = "Packers"
kicker$ = "Chris Jacke"
kicker = 80
RETURN

niners:
rb$ = "Terry Kirby"
rb = 60
qb$ = "Steve Young"
qb = 85
rec1$ = "Jerry Rice"
rec2$ = "J.J. Stokes"
defline1$ = "Bryant Young"
defline2$ = "Chris Doleman"
lb1$ = "Ken Norton"
sec1$ = "Merton Hanks"
sec2$ = "Tim McDonald"
defense = 85
city$ = "San Francisco"
team$ = "49ers"
kicker$ = "Jeff Wilkins"
kicker = 75
RETURN

chiefs:
rb$ = "Marcus Allen"
rb = 80
qb$ = "Steve Bono"
qb = 75
rec1$ = "Tamarick Vanover"
rec2$ = "Chris Penn"
defline1$ = "Neil Smith"
defline2$ = "Dan Saleaumua"
lb1$ = "Derrick Thomas"
sec1$ = "Dale Carter"
sec2$ = "Mark Collins"
defense = 85
city$ = "Kansas City"
team$ = "Chiefs"
kicker$ = "Pete Stoyanavich"
kicker = 70
RETURN

broncos:
rb$ = "Terrell Davis"
rb = 85
qb$ = "John Elway"
qb = 95
rec1$ = "Anthony Miller"
rec2$ = "Shannon Sharpe"
defline1$ = "Michael Dean Perry"
defline2$ = "Jeff Robinson"
lb1$ = "Bill Romanowski"
sec1$ = "Steve Atwater"
sec2$ = "Ray Crockett"
defense = 80
city$ = "Denver"
team$ = "Broncos"
kicker$ = "Jason Elam"
kicker = 75
RETURN

dolphins:
rb$ = "Karim Abdul-Jabbar"
rb = 80
qb$ = "Dan Marino"
qb = 90
rec1$ = "Fred Barnett"
rec2$ = "O.J. McDuffie"
defline1$ = "Trace Armstrong"
defline2$ = "Shane Burton"
lb1$ = "Zach Thomas"
sec1$ = "Terrell Buckley"
sec2$ = "J.B. Brown"
defense = 80
city$ = "Miami"
team$ = "Dolphins"
kicker$ = "Joe Nedney"
kicker = 70
RETURN

bills:
rb$ = "Thurman Thomas"
rb = 80
qb$ = "Jim Kelly"
qb = 75
rec1$ = "Andre Reed"
rec2$ = "Russell Copeland"
defline1$ = "Bruce Smith"
defline2$ = "Bryce Paup"
lb1$ = "Chris Spielman"
sec1$ = "Jeff Burris"
sec2$ = "Kurt Schulz"
defense = 75
city$ = "Buffalo"
team$ = "Bills"
kicker$ = "Steve Christie"
kicker = 75
RETURN

raiders:
rb$ = "Napolean Kaufman"
rb = 70
qb$ = "Jeff Hostetler"
qb = 80
rec1$ = "James Jett"
rec2$ = "Tim Brown"
defline1$ = "Chester McGlockton"
defline2$ = "Anthony Smith"
lb1$ = "Pat Swilling"
sec1$ = "Terry McDaniel"
sec2$ = "Albert Lewis"
defense = 80
city$ = "Oakland"
team$ = "Raiders"
kicker$ = "Cole Ford"
kicker = 70
RETURN

eagles:
rb$ = "Ricky Watters"
rb = 80
qb$ = "Ty Detmer"
qb = 75
rec1$ = "Irving Fryar"
rec2$ = "Mark Ingram"
defline1$ = "William Fuller"
defline2$ = "Mike Mamula"
lb1$ = "Joe Kelly"
sec1$ = "Troy Vincent"
sec2$ = "Mike Zordich"
defense = 80
city$ = "Philadelphia"
team$ = "Eagles"
kicker$ = "Gary Anderson"
kicker = 80
RETURN

