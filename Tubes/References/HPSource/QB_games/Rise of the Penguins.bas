SCREEN 12                                                                                                                                                                                                                                                                       '
CLS
LOCATE 14, 26: PRINT "Written by Andrew Morison"
LOCATE 25, 22: PRINT "* * * Press any key to begin * * *"
5 a$ = INKEY$
IF a$ = "" GOTO 5
8 CLS
LOCATE 10, 25: INPUT "Please enter your name- ", n$
10 CLS
DRAW "bu150 bl240 c10 u50 r20 f12 g12 l20 f26 br15 u50 br25 r25 l25 g12 f12"
DRAW "r20 f12 g13 l25 br50 u50 r30 l30 d25 r20 l20 d25 r30 br70 bu50 r20 f10"
DRAW "d30 g10 l20 h10 u30 e10 br45 d50 u25 r20 l20 u25 r30 br80 d50 u50 l20"
DRAW "r40 br10 d50 u25 r25 u25 d50 br10 u50 r30 l30 d25 r20 l20 d25 r30 bd100"
DRAW "bl350 u50 r20 f8 d10 g8 l20 br40 bd24 u50 r30 l30 d25 r20 l20 d25 r30"
DRAW "br10 u50 ta25 d55 ta0 u50 br20 r20 l20 g15 d20 f15 r20 e10 u10 l10 br20"
DRAW "bu30 d40 f10 r15 e10 u40 br10 d50 br10 u50 ta25 d55 ta0 u50"
LOCATE 28, 60: PRINT "By Andrew Morison"
LOCATE 18, 33: PRINT "S)tart"
LOCATE 20, 33: PRINT "I)nstructions"
LOCATE 22, 33: PRINT "Q)uit"
20 a$ = INKEY$
IF a$ = "s" GOTO 90
IF a$ = "i" GOTO 30
IF a$ = "q" THEN END
GOTO 20

30 CLS
PRINT "The aim of the game-"
PRINT
PRINT "It is the year 2000 and Antarctica is being used for the testing and disposal of"
PRINT "nuclear material. Nearly all of the penguin breeding sites have been built upon"
PRINT "or destroyed. Your mission is to take a petition signed by thousands of animals"
PRINT "and people from over the world to Parliament House in order to stop the"
PRINT "development. You must then return to your home in Antarctica."
PRINT
PRINT "You have 90 hours to do so. If you take too long, the whole of Antarctica will"
PRINT "be destroyed."
PRINT
PRINT "The keys-"
PRINT
PRINT "Type 'q' or 'quit' to quit."
PRINT "Type 'w' or 'west' to go west and 'e' or 'east' to go east."
PRINT
PRINT "Press any key to continue..."
ak: a$ = INKEY$
IF a$ = "" GOTO ak
GOTO 10

90 CLS
p = 110
d = 0
s = 0
t = 90
100 ' Main
DRAW "bl320 c9 u240 r639 d463 l639 u222 br20 u220 r599 d423 l599 u202 bl p9,9"
DRAW "bd201 br450 c9 u90 r149 d5 l144 d85 l5 be p9,9"
VIEW (22, 23)-(617, 250)
105
COLOR 15
LOCATE 18, 4: PRINT TAB(78); : LOCATE 19, 4: PRINT TAB(78); : LOCATE 20, 4: PRINT TAB(78); : LOCATE 21, 4: PRINT TAB(78); : LOCATE 22, 4: PRINT TAB(78);
IF t < 1 GOTO 200
LOCATE 24, 62: PRINT "Score:"; s
LOCATE 27, 62: PRINT "Time:"; t; "hours"
'LOCATE 1, 1
'FOR c = 0 TO 15
'COLOR c
'PRINT c
'NEXT c
IF p = 110 GOTO 110
IF p = 120 GOTO 120
IF p = 130 GOTO 130
IF p = 140 GOTO 140
IF p = 150 GOTO 150
IF p = 160 GOTO 160

110
IF l = 1 GOTO 250
LOCATE 18, 4: PRINT "You are standing on a large flat area of ice. There is a crabeater seal"
LOCATE 19, 4: PRINT "nearby as well as a big iceberg. Exits are east and west."
112 IF d = 1 GOTO 115
DRAW "l298 d113 r595 u113 l296 bd p15,15 bu2 c9 l299 u113 r595 d113 l295 bu p9,9"
DRAW "bl170 bd10 c7 l10 ta10 l10 ta30 l15 ta10 l10 ta0 l10 ta10 l10 ta15 l10"
DRAW "ta20 l10 ta-5 l30 ta0 d5 ta-10 r25 l22 ta0 d5 ta-10 r20 ta-15 r20 ta-5"
DRAW "r10 ta0 r10 ta10 r20 ta15 r15 ta20 r10 ta25 r10 ta40 r10 ta70 r5 ta120"
DRAW "r2 ta150 r5 ta155 r8 ta0 u2 bd8 p7,7 br2 c0 r d l u bd5 ta-10 r8 ta0"
DRAW "bd10 bl100 ta-10 l21 ta0 br75 bd5 ta70 l10 ta0 e2 f2 e2 f2 e2 f2 e2"
DRAW "ta70 r10 ta0 bl5 bd9 p7,0 br100 bu10 c0 u20 ta-10 u20 ta-20 u20 ta-30"
DRAW "u20 ta-40 u20 ta-60 u20 ta0 r10 ta-100 u20 ta-120 u20 ta-140 u20 ta-160"
DRAW "u20 ta-165 u20 ta-170 u20 ta-180 u15 ta0 l126 br5 bu35 p15,0"
COLOR 14: CIRCLE (500, 55), 30
DRAW "p14,14 u50 d100 u50 l50 r100 l50 g35 e35 f35 h70 f35 e35"
d = 1
115
COLOR 15: LOCATE 17, 4: PRINT TAB(78); : LOCATE 17, 4: INPUT a$:
IF a$ = "w" OR a$ = "west" THEN t = t - 1: CLS 1: p = 120: d = 0: GOTO 105
IF a$ = "e" OR a$ = "east" THEN t = t - 1: CLS 1: p = 130: d = 0: GOTO 105
IF a$ = "q" OR a$ = "quit" THEN END
SOUND 1000, 1
GOTO 115

120
LOCATE 18, 4: PRINT "You are standing in the middle of an industrial area. There is smoke in"
LOCATE 19, 4: PRINT "the air. Exit is east.": IF ti = 0 THEN LOCATE 19, 27: PRINT "There is a ticket on the ground."
122 IF d = 1 GOTO 125
DRAW "bd113 l298 u100 r595 d100 l595 u90 br p15,15 bl u11 c9 r595 u126 l595"
DRAW "d126 be p9,9 bd100 br400 c8 u200 r100 d200 l100 be p8,8 bg br40 c15 u30"
DRAW "r20 d30 bl13 bu15 r bu30 bl38 c7 u20 r20 d20 l20 be p7,7 bg br30 u20"
DRAW "r20 d20 l20 be p7,7 bg br30 u20 r20 d20 l20 be p7,7 bg br20 bu30 u20 l20"
DRAW "d20 r20 bh p7,7 bf bl30 u20 l20 d20 r20 bh p7,7 bf bl30 u20 l20 d20 r20"
DRAW "bh p7,7 bf bu30 bl20 u20 r20 d20 l20 be p7,7 bg br30 u20 r20 d20 l20 be"
DRAW "p7,7 bg br30 u20 r20 d20 l20 be p7,7 bg br20 bu30 u20 l20 d20 r20 bh p7,7"
DRAW "bf bl30 u20 l20 d20 r20 bh p7,7 bf bl30 u20 l20 d20 r20 bh p7,7 bf bu30"
DRAW "bl20 u20 r20 d20 l20 be p7,7 bg br30 u20 r20 d20 l20 be p7,7 bg br30 u20"
DRAW "r20 d20 l20 be p7,7 bg c8 bu35 bl70 e20 r100 d200 g20 bu be p8,8 bd bg"
DRAW "c7 u200 l100 d200 r100 e20 u200 g20 e20 l100 g20"
COLOR 0
CIRCLE (210, 190), 10: CIRCLE (260, 190), 10: CIRCLE (210, 190), 6: CIRCLE (260, 190), 6
DRAW "bl8 p0,0 bl50 p0,0 bl5 ta65 c4 r13 ta0 r15 ta-65 r13 ta0 r24 ta65 r13 ta0 r15 ta-65 r13 ta0 r5 ta65 r5 ta0 u20 ta-5 l30 ta0 u10 l25 d20 l28 d18 bu5 br p4,4 br32 bu20 c9 u8 r15 d8 l15 be p9,9 bl35 bd20 c0 l5 d3 r5 u3 bg p0,0 bu14 br10 c6 u15 r15 d15 l15 be p6,6"
CIRCLE (310, 190), 10: CIRCLE (360, 190), 10: CIRCLE (310, 190), 6: CIRCLE (360, 190), 6
DRAW "bl8 p0,0 bl50 p0,0 bl5 ta65 c1 r13 ta0 r15 ta-65 r13 ta0 r24 ta65 r13 ta0 r15 ta-65 r13 ta0 r5 ta65 r5 ta0 u20 ta-5 l30 ta0 u10 l25 d20 l28 d18 bu5 br p1,1 br32 bu20 c9 u8 r15 d8 l15 be p9,9 bl35 bd20 c0 l5 d3 r5 u3 bg p0,0 bu14 br10 bl280 bd40 c6 u80 e20 r100 d80 g20 l100 be p6,6 bg c7 u80 r100 d80 l100 u80 e20 r100 g20 e20 d80 g20 bu80 bl90 be10 c8 u60 r20 d60 l20 be p8,8 bg br30 u60 r20 d60 l20 be p8,8 bg br30 u60 r20 d60 l20 be p8,8 bg br15 u70 ta10 u20 ta20 u10 ta30 u10 ta40 u10 ta0 bd55 br12 u10 ta10 u20 ta20 u10 ta30 u10 ta40 u10 ta0 bd55 br12 u10 ta10 u20 ta20 u10 ta30 u10 ta40 u10 ta0 br3 bd55 u10 ta10 u20 ta20 u10 ta30 u10 ta40 u10 ta0 bd58 br12 u10 ta10 u20 ta20 u10 ta30 u10 ta40 u10 ta0 bd58 br12 u10 ta10 u20 ta20 u10 ta30 u10 ta40 u10 ta0 bd52 ta10 u20 ta20 u10 ta30 u10 ta40 u10 ta0 bd55 br12 u10 ta10 u20 ta20 u10 ta30 u10 ta40 u10 ta0 bd55 br12 u10 ta10 u20 ta20 u10 ta30 u10 ta40 u10"
DRAW "ta0 bd196 br30 c7 u30 r20 d30 l20 be5 bu7 u"
COLOR 15
d = 1
125
COLOR 15: LOCATE 17, 4: PRINT TAB(78); : LOCATE 17, 4: INPUT a$:
IF a$ = "e" OR a$ = "east" THEN t = t - 1: CLS 1: p = 110: d = 0: GOTO 105
IF ti = 0 THEN IF a$ = "get ticket" OR a$ = "take ticket" OR a$ = "pick up ticket" THEN ti = 1: s = s + 1000: GOTO 105
IF a$ = "q" OR a$ = "quit" THEN END
SOUND 1000, 1
GOTO 125

130
LOCATE 18, 4: PRINT "You are standing inside the Antarctica National Airport. Type 'board' to"
LOCATE 19, 4: PRINT "board the plane. Exit is west."
132 IF d = 1 GOTO 135
DRAW "c7 l298 u114 r595 d114 l296 bu p7,7 bu110 bl295 c8 d44 r90 u44 l90 br200"
DRAW "bd20 d50 r80 u50 l80 bd5 br5 d40 r70 u40 l70 bh p8,8 bf10 p9,8 bd8 br10"
DRAW "ta-10 c15 r25 u6 e4 f4 d10 g2 l31 h2 u2 e2 bd p15,15 bd6 br8 c0 d r d2"
DRAW "l2 u2 r u br18 d r d2 l2 u2 r br5 bu3 c4 r bu4 bl10 c9 l2 g d2 f r2 e u2"
DRAW "h bd p9,9 bl6 bu l2 g d2 f r2 e u2 h bd p9,9 bl7 bu l2 g d2 f r2 e u2 h"
DRAW "bd p9,9 ta0 bd66 c9 r358 d112 l595 u112 r236 bd p9,9"
COLOR 0: CIRCLE (400, 150), 15: CIRCLE (400, 150), 5: CIRCLE (520, 150), 15: CIRCLE (520, 150), 5
DRAW "br6 p0,0 bl115 p0,0 u2 r100 d5 l100 r50 bu p8,0 br54 c0 u80 e20 r5 g20"
DRAW "d70 l bu10 p8,0 bl20 bd15 c6 l80 u60 e5 r70 f5 d60 bh p6,6 bu64 bl25 c0"
DRAW "u10 h3 l20 g3 d10 r3 u10 r20 d10 r3 bh p0,0 bl300 c8 d100 l100 u100 r100"
DRAW "bg p8,8 bd10 bl79 c12 l5 g2 d8 f2 r5 br3 bu12 d10 f2 r4 e2 u10 br3 r3 f2"
DRAW "d4 g2 l3 f4 bl4 u12 br8 r3 f2 d4 g2 l3 f4 bl4 u12 br8 d12 r5 l5 u6 r4 l4"
DRAW "u6 r5 br3 d12 u12 ta25 d13 ta0 u12 br3 bd2 d8 f2 r5 l5 h2 u8 e2 r5 br3 f5"
DRAW "d7 u7 e5 bd30 bl26 c0 l20 d5 r20 u5 bg p0,0 bd30 br11 l40 d10 r40 u10 bg"
DRAW "p0,0 bd20 br15 c10 u6 r6 d6 l6 be p10,10 br2 c1 u2 r2 d2 l2"
COLOR 15: LOCATE 3, 5: PRINT "ANTARCTICA"
LOCATE 4, 5: PRINT "AIRPORT"
d = 1
135
COLOR 15: LOCATE 17, 4: PRINT TAB(78); : LOCATE 17, 4: INPUT a$:
IF a$ = "w" OR a$ = "west" THEN t = t - 1: CLS 1: p = 110: d = 0: GOTO 105
IF a$ = "board" AND ti = 1 THEN t = t - 10: s = s + 1000: CLS 1: p = 140: d = 0: GOTO 105
IF a$ = "board" AND ti = 0 THEN LOCATE 19, 35: PRINT "Sorry, you don't have the ticket."
IF a$ = "q" OR a$ = "quit" THEN END
SOUND 1000, 1
GOTO 135

140
LOCATE 18, 4: PRINT "You are standing inside the Canberra Airport. Exit is west. Type 'board'"
LOCATE 19, 4: PRINT "to board the plane."
142 IF d = 1 GOTO 145
DRAW "c7 l298 u114 r595 d114 l296 bu p7,7 bu110 bl295 c8 d44 r90 u44 l90 br200"
DRAW "bd20 d50 r80 u50 l80 bd5 br5 d40 r70 u40 l70 bh p8,8 bf10 p9,8 bd8 br10"
DRAW "ta-10 c15 r25 u6 e4 f4 d10 g2 l31 h2 u2 e2 bd p15,15 bd6 br8 c0 d r d2"
DRAW "l2 u2 r u br18 d r d2 l2 u2 r br5 bu3 c4 r bu4 bl10 c9 l2 g d2 f r2 e u2"
DRAW "h bd p9,9 bl6 bu l2 g d2 f r2 e u2 h bd p9,9 bl7 bu l2 g d2 f r2 e u2 h"
DRAW "bd p9,9 ta0 bd66 c9 r358 d112 l595 u112 r236 bd p9,9"
COLOR 0: CIRCLE (200, 150), 15: CIRCLE (200, 150), 5: CIRCLE (320, 150), 15: CIRCLE (320, 150), 5
DRAW "br6 p0,0 bl115 p0,0 u2 r100 d5 l100 r50 bu p8,0 br54 c0 u80 e20 r5 g20"
DRAW "d70 l bu10 p8,0 bl200 bd15 c6 l80 u60 e5 r70 f5 d60 bh p6,6 bu64 bl25 c0"
DRAW "u10 h3 l20 g3 d10 r3 u10 r20 d10 r3 bh p0,0 br400 c8 d100 l100 u100 r100"
DRAW "bg p8,8 bd10 bl79 c12 l5 g2 d8 f2 r5 br3 bu12 d10 f2 r4 e2 u10 br3 r3 f2"
DRAW "d4 g2 l3 f4 bl4 u12 br8 r3 f2 d4 g2 l3 f4 bl4 u12 br8 d12 r5 l5 u6 r4 l4"
DRAW "u6 r5 br3 d12 u12 ta25 d13 ta0 u12 br3 bd2 d8 f2 r5 l5 h2 u8 e2 r5 br3 f5"
DRAW "d7 u7 e5 bd30 bl26 c0 l20 d5 r20 u5 bg p0,0 bd30 br11 l40 d10 r40 u10 bg"
DRAW "p0,0 bd20 br15 c10 u6 r6 d6 l6 be p10,10 br2 c1 u2 r2 d2 l2"
COLOR 15: LOCATE 3, 5: PRINT "CANBERRA"
LOCATE 4, 5: PRINT "AIRPORT"
d = 1
145
COLOR 15: LOCATE 17, 4: PRINT TAB(78); : LOCATE 17, 4: INPUT a$
IF a$ = "w" OR a$ = "west" THEN t = t - 1: CLS 1: p = 150: d = 0: GOTO 105
IF a$ = "board" THEN t = t - 10: s = s + 1000: CLS 1: p = 130: d = 0: GOTO 105
IF a$ = "q" OR a$ = "quit" THEN END
SOUND 1000, 1
GOTO 145

150
LOCATE 18, 4: PRINT "You are standing outside Parliament House. The door is directly in front"
LOCATE 19, 4: PRINT "of you. Exit is east."
152 IF d = 1 GOTO 155
DRAW "bu114 c9 r297 d227 l595 u10 u217 r297 bd p9,9 bd226 c15 r170 u10 l340 d10"
DRAW "r169 bu p15,15 bu110 c7 u100 r3 d100 r f100 l5 h100 br2 p7,7 bl2 g100 r5"
DRAW "e97 bl p7,7 bu104 br4 c1 r50 d32 l50 u32 bf p1,1 blbd c4 bd6 r20 d3 l20"
DRAW "u3 bf p4,4 bd9 br7 r4 u17 l4 d6 be p4,4 bg d10 be p4,4 u8 br4 e7 l2 g7 br"
DRAW "e7 g7 br bd3 f7 l h7 l f7 h7 bl2 g7 e7 l g7 e7 l g7 e7 r3 h7 bl3 bu3 f7"
DRAW "r h7 r f7 bd17 br c15 ta10 u3 ta-10 d3 ta10 l3 ta-10 r3 ta10 d3 ta-10 u3"
DRAW "ta10 r3 ta-10 l3 bl p15,15 br22 bu22 ta10 u2 ta-10 d2 ta10 l2 ta-10 r2"
DRAW "ta10 d2 ta-10 u2 ta10 r2 ta-10 l2 bl p15,15 bd7 br10 ta10 u2 ta-10 d2"
DRAW "ta10 l2 ta-10 r2 ta10 d2 ta-10 u2 ta10 r2 ta-10 l2 bl p15,15 bd2 bl12 ta10"
DRAW "u2 ta-10 d2 ta10 l2 ta-10 r2 ta10 d2 ta-10 u2 ta10 r2 ta-10 l2 bl p15,15"
DRAW "br9 bd10 ta10 u2 ta-10 d2 ta10 l2 ta-10 r2 ta10 d2 ta-10 u2 ta10 r2 ta-10"
DRAW "l2 bl p15,15 ta0 bu5 br3 u"
COLOR 14: CIRCLE (500, 55), 30
DRAW "p14,14 u50 d100 u50 l50 r100 l50 g35 e35 f35 h70 f35 e35 bd195 bl300 c8 u8 l4 u6 r10 d6 l4 d8 l2 be p8,8"
d = 1
155
COLOR 15: LOCATE 17, 4: PRINT TAB(78); : LOCATE 17, 4: INPUT a$
IF a$ = "e" OR a$ = "east" THEN t = t - 1: CLS 1: p = 140: d = 0: GOTO 105
IF a$ = "forward" OR a$ = "go forward" OR a$ = "go inside" OR a$ = "walk forward" OR a$ = "walk inside" OR a$ = "go inside parliament house" OR a$ = "enter" OR a$ = "enter parliament house" THEN CLS 1: p = 160: d = 0: GOTO 105
IF a$ = "q" OR a$ = "quit" THEN END
SOUND 1000, 1
GOTO 155

160
LOCATE 18, 4: PRINT "You are standing in the marbled foyer of Parliament house. There is a"
LOCATE 19, 4: PRINT "mailbox in front of you that says 'To the P.M.' You are surrounded by"
LOCATE 20, 4: PRINT "marble pillars. There are lots of pictures and plaques on the walls."
IF l = 1 THEN LOCATE 20, 73: PRINT "The": LOCATE 21, 4: PRINT "petition is in the mailbox."
162 IF d = 1 GOTO 165
DRAW "c7 r297 d113 l595 u113 r297 bd p7,7 bu2 c3 r298 u113 l595 d113 r296 bu"
DRAW "p3,3 bd100 br150 c5 u211 r80 d211 l80 be p5,5 bl150 bu200 c6 r80 f5 d60"
DRAW "g5 l80 h5 u60 e5 bd5 d60 r80 u60 l80 bl p6,6 br11 bd5 p15,6 c0 r60 bd5"
DRAW "l60 bd5 r60 bd5 l60 bd5 r60 bd5 l60 bd5 r10 br35 c1 r5 f3 d5 g3 l5 h3 u5"
DRAW "e3 bd p1,1 bd10 ta-10 d10 ta0 r8 ta17 u10 ta0 bl2 bd p1,1 bl10 c0 l10"
DRAW "bl200 c6 u30 r40 d30 l40 be p6,6 bu20 br9 c0 r20 d5 l20 u5 bf p0,0"
DRAW "bl30 r15 g5 e5 h5 f5 bl75 u10 l3 r6 br6 r4 f2 d6 g2 l4 h2 u6 e2 br25"
DRAW "d10 u10 l4 r8 br3 d10 u5 r7 d5 u10 br3 d10 r6 l6 u5 r4 l4 u5 r6"
DRAW "bd15 bl40 d10 u5 r4 e2 u h2 l4 d10 br9 r br3 u10 ta25 d10 ta-25 u10 ta0 d10 br3 r"
d = 1
165
COLOR 15: LOCATE 17, 4: PRINT TAB(78); : LOCATE 17, 4: INPUT a$
IF l = 0 THEN IF a$ = "put letter in box" OR a$ = "put letter" OR a$ = "place letter in box" OR a$ = "place letter" OR a$ = "put letter in mailbox" OR a$ = "place letter in mailbox" OR a$ = "put petition in box" OR a$ = "put petition" OR a$ = "place petition in box" OR a$ = "place petition" OR a$ = "put petition in mailbox" OR a$ = "place petition in mailbox" THEN s = s + 2000: l = 1: GOTO 105: LOCATE 19, 32: PRINT "The petition is now in the box."
IF a$ = "go outside" OR a$ = "go out" OR a$ = "backward" OR a$ = "walk outside" OR a$ = "leave" OR a$ = "leave parliament house" OR a$ = "walk outside parliament house" THEN CLS 1: p = 150: d = 0: GOTO 105
IF a$ = "q" THEN END
SOUND 1000, 1
GOTO 165

200 CLS 0
LOCATE 10, 8: PRINT "You have run out of time. Antarctica has been completely destroyed."
LOCATE 12, 35: PRINT "Game over."
END

250 CLS 0
SOUND 600, 1: SOUND 0, 2: SOUND 600, 1: SOUND 0, 1: SOUND 600, 1: SOUND 0, 1: SOUND 800, 6
LOCATE 10, 10: PRINT "Congratulations! You have saved Antarctica! Would you like to"
260
LOCATE 13, 29: INPUT "print your scorecard? ", a$
IF a$ = "y" GOTO 270
IF a$ = "n" THEN END
GOTO 260
270
ON ERROR GOTO 275
LPRINT "                     Thankyou for playing Rise of the Penguin!"
LPRINT
LPRINT "         Name: "; n$
LPRINT
LPRINT "         Score: "; s
LPRINT
LPRINT "                                  Congratulations!"
275 END

