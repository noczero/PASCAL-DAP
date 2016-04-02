'Space PsYcHo!  (A cheap game by Hacksoft.)
'Requirements:
'386+
'2 MB RAM (I think)
'VGA

'Stuff:

'We are on the internet, with other wicked QBasic games like this!

'http://members.aol.com/jeffereys/index.htm
'
'Hacksoft is not responsible for any damage that this program
'may do to your computer.  We have tested this program constantly and no
'problems have occured on ours.
'
'Info for people that post Q-Basic games: Feel free to post this game and
'distribute it and stuff under one condition, it remains unedited.
'
'For those of you out there that want to use parts of the code, feel free,
'whether it be the "moving" subs or the graphics, but put in a word that
'the code was from Hacksoft.
'
'WHEW!  With that said, play this game.  It's pretty fun, and the graphics
'are better than some we've seen from other Q-Basic games.  There are three
'levels, and it's not the "same thing again just tougher"-type gameplay.
'Space Psycho comes with built-in instructions, a weak story, and three
'levels.  This game is kind of a twist between gore and humor.  Level 1 puts
'you in the heart of the police headquarters and you use your shotgun to
'blast your way out, taking civilians and other cyber-cops.  Level 2 takes
'you onto the streets of Washington D.C., to continue the onslaught.  And
'level 3, there you get to hunt down the president, and you'll be
'surprised to find out who the 24th century president is!  One of this
'game's cool features is that you can shoot up enemies again and again,
'blasting off body parts after each shot.  (If you're looking for a way
'to relieve your anxiety or not always be the "good guy" in a game, then
'give this one a try!)

DECLARE SUB graphicsload ()
DECLARE SUB title ()
DECLARE SUB story ()
DECLARE SUB copmoving ()
DECLARE SUB innocentmoving ()
DECLARE SUB ecopmoving ()
DECLARE SUB death ()
DECLARE SUB mainmenu ()
DECLARE SUB ending ()
DECLARE SUB thegame ()
DECLARE SUB hacksoft ()
DECLARE SUB presents ()
DECLARE SUB instructions ()

DIM SHARED move$, l, u, health, el, eu, pl, pu, copright(500), copleft(500)
DIM SHARED copdie(500), copdie2(500), position, shotleft(50), shotright(50)
DIM SHARED jump, innocent(500), innocentdie(500), innocentdie2(500)
DIM SHARED innocentdie3(500), il, iu, iposition, eposition
DIM SHARED ecopleft(500), ecopright(500), ecopdie(500), ecopdie2(500)

SCREEN 13

hacksoft
presents
graphicsload
title
mainmenu

SUB copmoving
        LINE (l, u)-(l + 30, u + 40), 0, BF
        IF position = 1 THEN
                move$ = INKEY$
                IF move$ = CHR$(0) + "K" THEN
                        IF POINT(l - 5, u) = 0 AND POINT(l - 5, u + 10) = 0 AND POINT(l - 5, u + 20) = 0 AND POINT(l - 5, u + 30) = 0 AND POINT(l - 5, u + 40) = 0 THEN
                                l = l - 5
                        END IF
                ELSEIF move$ = CHR$(0) + "M" THEN
                        position = 2
                ELSEIF move$ = CHR$(0) + "H" AND POINT(l, u + 41) > 0 OR POINT(l + 30, u + 41) > 0 AND move$ = CHR$(0) + "H" THEN
                        position = 3
                        jump = 50
                ELSEIF move$ = " " THEN
                        PUT (l, u), copleft
                        PUT (l - 7, u + 14), shotleft, XOR
                        FOR i = 1 TO 3
                                SOUND 200 - i * 25, 1
                        NEXT i
                        PUT (l - 7, u + 14), shotleft, XOR
                        LINE (l, u)-(l + 30, u + 40), 0, BF
                END IF
                FOR fall = 1 TO 5
                IF POINT(l, u + 41) = 0 AND POINT(l + 30, u + 41) = 0 AND POINT(l + 15, u + 41) = 0 THEN
                        u = u + 1
                END IF
                NEXT fall
                PUT (l, u), copleft, PSET
        ELSEIF position = 2 THEN
                move$ = INKEY$
                IF move$ = CHR$(0) + "M" THEN
                        IF POINT(l + 35, u) = 0 AND POINT(l + 35, u + 10) = 0 AND POINT(l + 35, u + 20) = 0 AND POINT(l + 35, u + 30) = 0 AND POINT(l + 35, u + 40) = 0 THEN
                                l = l + 5
                        END IF
                ELSEIF move$ = CHR$(0) + "K" THEN
                        position = 1
                ELSEIF move$ = CHR$(0) + "H" AND POINT(l, u + 41) > 0 OR POINT(l + 30, u + 41) > 0 AND move$ = CHR$(0) + "H" THEN
                        position = 4
                        jump = 50
                ELSEIF move$ = " " THEN
                        PUT (l, u), copright, PSET
                        PUT (l + 30, u + 14), shotright, XOR
                        FOR i = 1 TO 3
                                SOUND 200 - i * 25, 1
                        NEXT i
                        PUT (l + 30, u + 14), shotright, XOR
                        LINE (l, u)-(l + 30, u + 40), 0, BF
                END IF
                FOR fall = 1 TO 5
                IF POINT(l, u + 41) = 0 AND POINT(l + 30, u + 41) = 0 AND POINT(l + 15, u + 41) = 0 THEN
                        u = u + 1
                END IF
                NEXT fall
                PUT (l, u), copright, PSET
        ELSEIF position = 3 THEN
                IF POINT(l, u - 5) = 0 AND POINT(l + 15, u - 5) = 0 AND POINT(l + 30, u - 5) = 0 THEN
                        u = u - 5
                        jump = jump - 5
                ELSE
                        jump = 0
                END IF
                move$ = INKEY$
                IF move$ = CHR$(0) + "M" THEN
                        position = 4
                ELSEIF move$ = CHR$(0) + "K" THEN
                        IF POINT(l - 5, u) = 0 AND POINT(l - 5, u + 10) = 0 AND POINT(l - 5, u + 20) = 0 AND POINT(l - 5, u + 30) = 0 AND POINT(l - 5, u + 40) = 0 THEN
                                l = l - 5
                        END IF
                END IF
                IF jump = 0 THEN position = 1
                PUT (l, u), copleft, PSET
        ELSEIF position = 4 THEN
                IF POINT(l, u - 5) = 0 AND POINT(l + 15, u - 5) = 0 AND POINT(l + 30, u - 5) = 0 THEN
                        u = u - 5
                        jump = jump - 5
                ELSE
                        jump = 0
                END IF
                move$ = INKEY$
                IF move$ = CHR$(0) + "K" THEN
                        position = 3
                ELSEIF move$ = CHR$(0) + "M" THEN
                        IF POINT(l + 35, u) = 0 AND POINT(l + 35, u + 10) = 0 AND POINT(l + 35, u + 20) = 0 AND POINT(l + 35, u + 30) = 0 AND POINT(l + 35, u + 40) = 0 THEN
                                l = l + 5
                        END IF
                END IF
                IF jump = 0 THEN position = 2
                PUT (l, u), copright, PSET
        ELSEIF position > 99 THEN
                position = position + 1
                IF position < 120 THEN PUT (l, u), copdie
                IF position > 119 THEN PUT (l, u), copdie2
                IF position = 120 THEN
                        FOR i = 1 TO 3
                                SOUND 200 - i * 25, 1
                        NEXT i
                END IF
        END IF
        IF move$ = CHR$(27) THEN
                position = 100
                move$ = CHR$(0)
        END IF
        IF position = 140 THEN death
END SUB

SUB death
SLEEP 1
FOR i = 0 TO 50
        move$ = INKEY$
NEXT i
LINE (250, 115)-(70, 40), 0, BF
LINE (250, 115)-(70, 40), 15, B
LINE (251, 116)-(69, 39), 10, B
LINE (68, 38)-(252, 117), 2, B
PAINT (94, 51), 4, 15
LINE (84, 47)-(90, 47), 9
LINE (90, 47)-(97, 53), 9
LINE (97, 53)-(102, 46), 9
LINE (102, 46)-(109, 46), 9
LINE (109, 46)-(109, 50), 9
LINE (109, 50)-(121, 45), 9
LINE (121, 45)-(130, 51), 9
LINE (130, 51)-(130, 46), 9
LINE (130, 46)-(136, 46), 9
LINE (136, 46)-(136, 59), 9
LINE (136, 59)-(141, 62), 9
LINE (141, 62)-(145, 59), 9
LINE (145, 59)-(145, 47), 9
LINE (145, 47)-(151, 47), 9
LINE (151, 47)-(151, 60), 9
LINE (151, 60)-(144, 66), 9
LINE (144, 66)-(137, 66), 9
LINE (137, 66)-(130, 61), 9
LINE (130, 61)-(120, 66), 9
LINE (120, 66)-(109, 61), 9
LINE (109, 61)-(109, 55), 9
LINE (109, 55)-(100, 59), 9
LINE (100, 59)-(100, 65), 9
LINE (100, 65)-(94, 65), 9
LINE (94, 65)-(94, 57), 9
LINE (94, 57)-(84, 47), 9
LINE (119, 52)-(116, 54), 9
LINE (116, 54)-(119, 59), 9
LINE (119, 59)-(124, 55), 9
LINE (124, 55)-(119, 52), 9
PAINT (120, 50), 1, 9
LINE (171, 55)-(183, 55), 9
LINE (170, 55)-(170, 61), 9
LINE (170, 61)-(179, 60), 9
LINE (185, 63)-(185, 63), 9
LINE (185, 63)-(176, 67), 9
LINE (179, 60)-(170, 64), 9
LINE (176, 67)-(164, 67), 9
LINE (164, 67)-(164, 50), 9
LINE (164, 50)-(168, 47), 9
LINE (168, 47)-(179, 47), 9
LINE (179, 47)-(179, 51), 9
LINE (179, 51)-(168, 52), 9
LINE (168, 52)-(168, 62), 9
LINE (168, 62)-(170, 64), 9
LINE (182, 55)-(186, 55), 9
LINE (186, 55)-(186, 49), 9
LINE (186, 49)-(196, 45), 9
LINE (196, 45)-(205, 49), 9
LINE (205, 49)-(205, 46), 9
LINE (205, 46)-(225, 46), 9
LINE (225, 46)-(225, 51), 9
LINE (225, 51)-(218, 51), 9
LINE (218, 51)-(218, 66), 9
LINE (218, 66)-(214, 66), 9
LINE (214, 66)-(214, 52), 9
LINE (214, 52)-(214, 52), 9
LINE (206, 52)-(214, 52), 9
LINE (206, 52)-(206, 62), 9
LINE (206, 62)-(195, 67), 9
LINE (195, 67)-(185, 63), 9
LINE (195, 52)-(190, 57), 9
LINE (190, 57)-(195, 60), 9
LINE (195, 60)-(199, 56), 9
LINE (199, 56)-(195, 52), 9
PAINT (192, 51), 1, 9
LINE (87, 77)-(94, 77), 9
LINE (94, 77)-(94, 88), 9
LINE (94, 88)-(103, 79), 9
LINE (103, 79)-(107, 83), 9
LINE (107, 83)-(107, 83), 9
LINE (107, 83)-(97, 95), 9
LINE (97, 95)-(105, 103), 9
LINE (105, 103)-(101, 107), 9
LINE (101, 107)-(92, 98), 9
LINE (92, 98)-(92, 106), 9
LINE (92, 106)-(87, 106), 9
LINE (87, 106)-(86, 77), 9
LINE (117, 77)-(122, 77), 9
LINE (122, 77)-(120, 107), 9
LINE (120, 107)-(114, 107), 9
LINE (114, 107)-(116, 77), 9
LINE (131, 77)-(126, 107), 9
LINE (126, 107)-(146, 107), 9
LINE (146, 107)-(151, 102), 9
LINE (151, 102)-(136, 102), 9
LINE (136, 102)-(136, 77), 9
LINE (136, 77)-(131, 77), 9
LINE (161, 77)-(156, 77), 9
LINE (156, 77)-(161, 107), 9
LINE (161, 107)-(186, 107), 9
LINE (186, 107)-(181, 102), 9
LINE (181, 102)-(166, 102), 9
LINE (166, 102)-(161, 77), 9
LINE (186, 77)-(211, 77), 9
LINE (186, 77)-(191, 107), 9
LINE (191, 107)-(216, 107), 9
LINE (216, 107)-(211, 102), 9
LINE (211, 102)-(196, 102), 9
LINE (196, 102)-(196, 92), 9
LINE (196, 92)-(211, 92), 9
LINE (211, 92)-(206, 87), 9
LINE (206, 87)-(196, 87), 9
LINE (196, 87)-(196, 82), 9
LINE (196, 82)-(211, 82), 9
LINE (211, 82)-(211, 77), 9
LINE (221, 77)-(226, 107), 9
LINE (226, 107)-(241, 87), 9
LINE (241, 87)-(221, 77), 9
LINE (228, 87)-(230, 95), 9
LINE (230, 95)-(233, 89), 9
LINE (233, 89)-(228, 87), 9
PAINT (225, 84), 1, 9
PAINT (190, 84), 1, 9
PAINT (160, 84), 1, 9
PAINT (132, 84), 1, 9
PAINT (120, 84), 1, 9
PAINT (90, 84), 1, 9
move$ = CHR$(0)
DO
        move$ = INKEY$
LOOP UNTIL move$ = " "
CLS
title
END SUB

SUB ecopmoving
        RANDOMIZE TIMER
        LINE (el, eu)-(el + 30, eu + 40), 0, BF
        IF eposition < 3 THEN
                IF l < el THEN eposition = 1
                IF l > el THEN eposition = 2
        END IF
        FOR fall = 1 TO 5
                IF POINT(el, eu + 41) = 0 AND POINT(el + 30, eu + 41) = 0 THEN
                        eu = eu + 1
                END IF
        NEXT fall
        IF eposition = 1 THEN
                movement = INT(RND * 15)
                IF movement = 0 THEN
                        PUT (el, eu), ecopleft
                        PUT (el - 7, eu + 7), shotleft, XOR
                        FOR i = 1 TO 3
                                SOUND 200 - i * 25, 1
                        NEXT i
                        PUT (el - 7, eu + 7), shotleft, XOR
                        IF l > el - 100 AND eu + 20 > u AND eu + 20 < u + 40 THEN
                                IF position < 100 THEN position = 100
                        END IF
                ELSEIF movement = 1 THEN
                        IF POINT(el - 5, eu) = 0 AND POINT(el - 5, eu + 10) = 0 AND POINT(el - 5, eu + 20) = 0 AND POINT(el - 5, eu + 30) = 0 AND POINT(el - 5, eu + 40) = 0 THEN
                                el = el - 5
                        END IF
                ELSEIF movement = 2 THEN
                        IF POINT(el + 35, eu) = 0 AND POINT(el + 35, eu + 10) = 0 AND POINT(el + 35, eu + 20) = 0 AND POINT(el + 35, eu + 30) = 0 AND POINT(el + 35, eu + 40) = 0 THEN
                                el = el + 5
                        END IF
                END IF
                PUT (el, eu), ecopleft, PSET
        ELSEIF eposition = 2 THEN
                movement = INT(RND * 15)
                IF movement = 0 THEN
                        PUT (el, eu), ecopright, PSET
                        PUT (el + 30, eu + 7), shotright, XOR
                        FOR i = 1 TO 3
                                SOUND 200 - i * 25, 1
                        NEXT i
                        PUT (el + 30, eu + 7), shotright, XOR
                        IF l < el + 100 AND eu + 20 > u AND eu + 20 < u + 40 THEN
                                IF position < 100 THEN position = 100
                        END IF
                ELSEIF movement = 2 THEN
                        IF POINT(el - 5, eu) = 0 AND POINT(el - 5, eu + 10) = 0 AND POINT(el - 5, eu + 20) = 0 AND POINT(el - 5, eu + 30) = 0 AND POINT(el - 5, eu + 40) = 0 THEN
                                el = el - 5
                        END IF
                ELSEIF movement = 1 THEN
                        IF POINT(el + 35, eu) = 0 AND POINT(el + 35, eu + 10) = 0 AND POINT(el + 35, eu + 20) = 0 AND POINT(el + 35, eu + 30) = 0 AND POINT(el + 35, eu + 40) = 0 THEN
                                el = el + 5
                        END IF
                END IF
                PUT (el, eu), ecopright, PSET
        ELSEIF eposition = 3 THEN
                PUT (el, eu), ecopdie
        ELSEIF eposition = 4 THEN
                PUT (el, eu), ecopdie2
        END IF
        IF move$ = " " AND position = 1 AND el > l - 100 AND u + 20 > eu AND u + 20 < eu + 40 THEN
                IF eposition < 4 THEN eposition = eposition + 1
        ELSEIF move$ = " " AND position = 2 AND el < l + 100 AND u + 20 > eu AND u + 20 < eu + 40 THEN
                IF eposition = 1 THEN
                        eposition = 3
                ELSEIF eposition = 3 THEN
                        eposition = 4
                END IF
        END IF
END SUB

SUB ending
CLS
LINE (319, 145)-(1, 115), 12, B
PAINT (304, 130), 4, 12
FOR i = 1 TO 500
        x = INT(RND * 320)
        y = INT(RND * 29) + 116
        PSET (x, y), 12
NEXT i
LINE (265, 94)-(215, 114), 6, B
LINE (270, 89)-(210, 94), 6, B
LINE (303, 113)-(295, 114), 8, B
LINE (302, 111)-(297, 112), 8, B
LINE (300, 30)-(299, 110), 8, B
LINE (298, 32)-(283, 34), 8
LINE (283, 34)-(268, 32), 8
LINE (268, 32)-(260, 33), 8
LINE (260, 33)-(260, 51), 8
LINE (260, 51)-(271, 50), 8
LINE (271, 50)-(282, 52), 8
LINE (282, 52)-(299, 49), 8
LINE (261, 41)-(272, 42), 8
LINE (272, 42)-(272, 33), 8
PAINT (268, 37), 1, 8
PAINT (267, 44), 4, 8
LINE (261, 48)-(267, 46), 15
LINE (267, 46)-(280, 48), 15
LINE (280, 48)-(298, 45), 15
LINE (298, 41)-(278, 45), 15
LINE (278, 45)-(266, 43), 15
LINE (266, 43)-(261, 44), 15
LINE (273, 41)-(277, 41), 15
LINE (277, 41)-(298, 38), 15
LINE (298, 34)-(281, 37), 15
LINE (281, 37)-(273, 37), 15
PSET (262, 34), 15
PSET (264, 34), 15
PSET (267, 34), 15
PSET (269, 35), 15
PSET (266, 36), 15
PSET (263, 36), 15
PSET (264, 37), 15
PSET (265, 40), 15
PSET (266, 38), 15
PSET (268, 37), 15
PSET (268, 39), 15
PSET (269, 40), 15
PSET (270, 38), 15
PSET (263, 38), 15
PSET (261, 39), 15
PSET (262, 36), 15
PAINT (233, 92), 42, 6
PAINT (233, 97), 42, 6
LINE (319, 171)-(1, 146), 8, B
PAINT (314, 166), 7, 8
LINE (141, 114)-(149, 114), 8
LINE (141, 114)-(145, 110), 8
LINE (145, 110)-(149, 110), 8
LINE (149, 110)-(149, 113), 8
PAINT (147, 112), 8, 8
LINE (159, 114)-(159, 110), 8
LINE (159, 110)-(164, 110), 8
LINE (164, 110)-(168, 114), 8
LINE (168, 114)-(160, 114), 8
PAINT (161, 112), 8, 8
LINE (159, 109)-(162, 109), 7
LINE (149, 109)-(146, 109), 7
LINE (145, 108)-(150, 108), 8
LINE (150, 108)-(154, 97), 8
LINE (154, 97)-(158, 108), 8
LINE (158, 108)-(163, 108), 8
LINE (163, 108)-(159, 89), 8
LINE (159, 89)-(150, 89), 8
LINE (150, 89)-(144, 108), 8
LINE (150, 89)-(137, 68), 8
LINE (137, 68)-(116, 80), 8
LINE (116, 80)-(111, 74), 8
LINE (111, 74)-(139, 61), 8
LINE (139, 61)-(149, 61), 8
LINE (149, 61)-(149, 57), 8
LINE (149, 57)-(154, 61), 8
LINE (149, 61)-(154, 64), 8
LINE (154, 64)-(154, 61), 8
LINE (154, 61)-(159, 57), 8
LINE (159, 58)-(159, 62), 8
LINE (159, 62)-(154, 64), 8
LINE (149, 61)-(155, 72), 8
LINE (155, 72)-(159, 62), 8
LINE (155, 72)-(152, 89), 8
LINE (159, 89)-(170, 68), 8
LINE (170, 68)-(176, 87), 8
LINE (176, 87)-(184, 87), 8
LINE (184, 87)-(175, 60), 8
LINE (175, 60)-(159, 61), 8
PAINT (152, 61), 15, 8
PAINT (157, 61), 15, 8
PAINT (155, 66), 15, 8
PAINT (150, 71), 7, 8
PAINT (158, 79), 7, 8
PAINT (156, 92), 7, 8
PSET (157, 77), 16
PSET (156, 81), 16
PSET (155, 85), 16
LINE (182, 89)-(178, 88), 14, B
LINE (178, 89)-(176, 91), 14
LINE (178, 89)-(178, 93), 14
LINE (180, 89)-(180, 93), 14
LINE (182, 89)-(182, 93), 14
LINE (183, 90)-(185, 92), 14
PSET (185, 92), 0
PSET (184, 92), 14
LINE (175, 92)-(175, 93), 14
LINE (94, 81)-(107, 74), 8
LINE (94, 81)-(97, 84), 8
LINE (97, 84)-(107, 79), 8
LINE (107, 79)-(111, 82), 8
LINE (111, 82)-(114, 80), 8
LINE (114, 80)-(107, 74), 8
LINE (105, 80)-(106, 82), 8
LINE (106, 82)-(108, 80), 8
PAINT (107, 77), 7, 8
LINE (107, 80)-(108, 79), 14
LINE (108, 81)-(110, 79), 14
LINE (109, 82)-(111, 80), 14
LINE (109, 76)-(106, 77), 14
LINE (111, 76)-(113, 78), 14
LINE (111, 75)-(113, 77), 14
LINE (151, 58)-(154, 60), 14
LINE (154, 60)-(157, 58), 14
LINE (151, 58)-(151, 56), 14
LINE (157, 58)-(157, 56), 14
LINE (151, 55)-(148, 55), 14
LINE (148, 55)-(148, 52), 14
LINE (148, 52)-(151, 52), 14
LINE (148, 50)-(151, 50), 14
LINE (151, 50)-(151, 52), 14
LINE (148, 49)-(148, 47), 14
LINE (148, 47)-(157, 47), 14
LINE (157, 47)-(157, 56), 14
PAINT (155, 55), 14, 14
PSET (147, 49), 14
PSET (148, 48), 16
PSET (149, 48), 15
LINE (157, 45)-(148, 46), 6, B
LINE (158, 53)-(157, 46), 6, B
PSET (148, 55), 0
LINE (135, 53)-(123, 43), 15
LINE (135, 53)-(130, 40), 15
CIRCLE (115, 29), 25, 15
PAINT (131, 47), 15, 15
PAINT (127, 43), 15, 15
LINE (100, 17)-(100, 21), 16
LINE (100, 17)-(103, 17), 16
LINE (101, 19)-(101, 19), 16
LINE (104, 21)-(104, 17), 16
LINE (104, 17)-(107, 19), 16
LINE (107, 19)-(104, 20), 16
LINE (104, 20)-(107, 21), 16
LINE (104, 21)-(104, 23), 16
LINE (107, 21)-(107, 23), 16
LINE (109, 23)-(109, 18), 16
LINE (109, 18)-(112, 18), 16
LINE (110, 20)-(112, 20), 16
LINE (109, 23)-(112, 23), 16
LINE (114, 23)-(114, 18), 16
LINE (114, 18)-(117, 18), 16
LINE (115, 20)-(117, 20), 16
LINE (115, 23)-(117, 23), 16
LINE (119, 18)-(123, 18), 16
LINE (123, 18)-(119, 23), 16
LINE (119, 23)-(123, 23), 16
LINE (125, 23)-(125, 18), 16
LINE (125, 18)-(128, 18), 16
LINE (126, 21)-(127, 21), 16
LINE (126, 23)-(129, 23), 16
LINE (132, 23)-(131, 22), 16, B
LINE (132, 24)-(132, 24), 16, B
LINE (131, 25)-(131, 25), 16, B
LINE (101, 27)-(101, 31), 16
LINE (101, 31)-(103, 31), 16
LINE (105, 31)-(105, 27), 16
LINE (107, 27)-(110, 27), 16
LINE (109, 27)-(109, 31), 16
LINE (112, 27)-(115, 27), 16
LINE (113, 27)-(113, 31), 16
LINE (117, 31)-(117, 27), 16
LINE (117, 31)-(120, 31), 16
LINE (122, 31)-(122, 27), 16
LINE (122, 27)-(125, 27), 16
LINE (123, 29)-(123, 29), 16
LINE (123, 31)-(126, 31), 16
LINE (106, 38)-(106, 35), 16
LINE (106, 35)-(108, 37), 16
LINE (108, 37)-(110, 35), 16
LINE (110, 35)-(110, 39), 16
LINE (112, 39)-(115, 35), 16
LINE (115, 35)-(118, 39), 16
LINE (117, 37)-(113, 38), 16
LINE (120, 39)-(120, 35), 16
LINE (120, 35)-(124, 39), 16
LINE (124, 39)-(124, 35), 16
LINE (126, 39)-(126, 39), 16
PUT (50, 74), copright, PSET
move$ = CHR$(0)
DO
        move$ = INKEY$
LOOP UNTIL move$ = " "
LINE (58, 66)-(49, 55), 15
LINE (58, 66)-(55, 52), 15
CIRCLE (45, 45), 14, 15
PAINT (54, 57), 15, 15
PAINT (51, 53), 15, 15
LINE (40, 42)-(40, 38), 16
LINE (40, 38)-(43, 38), 16
LINE (41, 40)-(42, 40), 16
LINE (40, 43)-(43, 43), 16
LINE (45, 43)-(46, 38), 16
LINE (46, 38)-(48, 43), 16
LINE (49, 38)-(52, 38), 16
LINE (51, 38)-(51, 43), 16
LINE (35, 45)-(39, 45), 16
LINE (37, 45)-(37, 50), 16
LINE (41, 50)-(41, 45), 16
LINE (41, 47)-(43, 47), 16
LINE (43, 45)-(43, 50), 16
LINE (46, 50)-(46, 45), 16
LINE (50, 45)-(48, 45), 16
LINE (48, 45)-(48, 48), 16
LINE (48, 48)-(50, 48), 16
LINE (50, 48)-(50, 50), 16
LINE (50, 50)-(48, 50), 16
LINE (53, 50)-(53, 50), 16
LINE (53, 48)-(53, 44), 16
move$ = CHR$(0)
DO
        move$ = INKEY$
LOOP UNTIL move$ = " "
LINE (94, 82)-(83, 83), 14
LINE (83, 83)-(87, 85), 14
LINE (87, 85)-(83, 88), 14
LINE (83, 88)-(89, 87), 14
LINE (89, 87)-(88, 91), 14
LINE (88, 91)-(96, 84), 14
LINE (96, 84)-(94, 82), 14
PAINT (92, 85), 14, 14
LINE (95, 82)-(88, 83), 4
LINE (88, 83)-(92, 84), 4
LINE (92, 84)-(90, 87), 4
LINE (90, 87)-(96, 84), 4
LINE (96, 84)-(94, 82), 4
PAINT (93, 83), 4, 4
FOR i = 1 TO 3
        SOUND 175 - i * 25, 1
NEXT i
move$ = CHR$(0)
DO
        move$ = INKEY$
LOOP UNTIL move$ = " "
CLS
LINE (25, 12)-(31, 20), 38
LINE (31, 20)-(36, 15), 38
LINE (36, 15)-(40, 19), 38
LINE (40, 19)-(46, 12), 38
LINE (50, 12)-(56, 12), 38
LINE (51, 12)-(50, 21), 38
LINE (50, 21)-(55, 21), 38
LINE (55, 16)-(51, 16), 38
LINE (59, 11)-(59, 21), 38
LINE (59, 21)-(64, 21), 38
LINE (69, 11)-(69, 21), 38
LINE (69, 21)-(74, 21), 38
LINE (80, 20)-(79, 21), 38, B
LINE (80, 22)-(80, 22), 38, B
LINE (79, 23)-(79, 23), 38, B
LINE (92, 11)-(102, 11), 38
LINE (97, 11)-(97, 21), 38
LINE (107, 21)-(107, 11), 38
LINE (107, 16)-(112, 16), 38
LINE (112, 11)-(112, 21), 38
LINE (117, 21)-(122, 11), 38
LINE (122, 11)-(127, 21), 38
LINE (117, 16)-(127, 16), 38
LINE (132, 11)-(142, 11), 38
LINE (137, 11)-(137, 21), 38
LINE (152, 21)-(152, 11), 38
LINE (152, 16)-(157, 11), 38
LINE (152, 16)-(157, 21), 38
LINE (162, 21)-(162, 11), 38
LINE (167, 21)-(167, 11), 38
LINE (167, 11)-(177, 21), 38
LINE (177, 21)-(177, 11), 38
LINE (182, 11)-(182, 21), 38
LINE (182, 21)-(187, 16), 38
LINE (187, 16)-(182, 11), 38
LINE (192, 21)-(197, 11), 38
LINE (197, 11)-(202, 21), 38
LINE (202, 16)-(192, 16), 38
LINE (222, 11)-(212, 16), 38
LINE (212, 16)-(222, 16), 38
LINE (222, 16)-(212, 21), 38
LINE (227, 11)-(227, 21), 38
LINE (227, 21)-(232, 21), 38
LINE (232, 21)-(232, 11), 38
LINE (242, 11)-(237, 16), 38
LINE (237, 16)-(242, 21), 38
LINE (247, 21)-(247, 11), 38
LINE (247, 16)-(252, 11), 38
LINE (247, 16)-(252, 21), 38
LINE (257, 21)-(257, 11), 38
LINE (257, 11)-(262, 11), 38
LINE (257, 16)-(262, 16), 38
LINE (257, 21)-(262, 21), 38
LINE (267, 21)-(267, 11), 38
LINE (267, 11)-(272, 16), 38
LINE (267, 21)-(267, 21), 38
LINE (272, 16)-(272, 16), 38
LINE (272, 16)-(267, 21), 38
LINE (277, 21)-(277, 21), 38
LINE (42, 126)-(67, 116), 32
LINE (57, 121)-(57, 151), 32
LINE (47, 156)-(72, 146), 32
LINE (82, 121)-(87, 121), 32
LINE (87, 121)-(87, 126), 32
LINE (87, 126)-(82, 131), 32
LINE (97, 111)-(97, 141), 32
LINE (97, 141)-(102, 141), 32
LINE (102, 141)-(107, 141), 32
LINE (117, 111)-(117, 141), 32
LINE (117, 141)-(127, 141), 32
LINE (157, 141)-(157, 106), 32
LINE (157, 111)-(172, 116), 32
LINE (172, 116)-(157, 126), 32
LINE (157, 126)-(172, 136), 32
LINE (172, 136)-(157, 141), 32
LINE (177, 141)-(177, 111), 32
LINE (177, 111)-(192, 111), 32
LINE (177, 126)-(187, 126), 32
LINE (177, 141)-(192, 141), 32
LINE (222, 116)-(217, 141), 32
LINE (222, 116)-(237, 121), 32
LINE (237, 121)-(222, 126), 32
LINE (222, 126)-(237, 136), 32
LINE (237, 136)-(217, 141), 32
LINE (242, 141)-(247, 116), 32
LINE (247, 116)-(252, 141), 32
LINE (252, 131)-(242, 131), 32
LINE (267, 116)-(262, 131), 32
LINE (262, 131)-(272, 141), 32
LINE (282, 141)-(282, 111), 32
LINE (282, 131)-(292, 121), 32
LINE (282, 131)-(292, 141), 32
LINE (302, 141)-(302, 141), 32
LINE (307, 141)-(307, 141), 32
LINE (312, 141)-(312, 141), 32
COLOR 10
LOCATE 5, 1: PRINT "As you lay there, collapsed, with"
LOCATE 6, 1: PRINT "blood pouring out of your chest,"
LOCATE 7, 1: PRINT "you gaze up at Arnold.  The only"
LOCATE 8, 1: PRINT "things that come to mind are "
LOCATE 9, 1: PRINT "three words:"
move$ = CHR$(0)
DO
        move$ = INKEY$
LOOP UNTIL move$ = " "
CLS
title
END SUB

SUB graphicsload
        CLS
'Copright
LINE (67, 101)-(62, 100), 6, B
LINE (67, 106)-(62, 102), 14, B
LINE (65, 107)-(63, 107), 14, B
PAINT (65, 104), 14, 14
PSET (68, 104), 14
PSET (67, 103), 12
PSET (66, 103), 15
LINE (57, 108)-(72, 108), 8
LINE (57, 108)-(54, 115), 8
LINE (54, 115)-(57, 120), 8
LINE (57, 120)-(62, 120), 8
LINE (62, 120)-(59, 115), 8
LINE (59, 115)-(61, 112), 8
LINE (72, 108)-(75, 112), 8
LINE (75, 112)-(72, 116), 8
LINE (69, 112)-(67, 116), 8
LINE (67, 116)-(69, 120), 8
LINE (69, 120)-(73, 120), 8
LINE (73, 120)-(72, 116), 8
LINE (60, 121)-(58, 135), 8
LINE (58, 135)-(64, 135), 8
LINE (64, 135)-(65, 125), 8
LINE (65, 125)-(68, 135), 8
LINE (68, 135)-(73, 135), 8
LINE (73, 135)-(70, 120), 8
LINE (53, 118)-(55, 118), 6
LINE (56, 119)-(53, 119), 6
LINE (53, 120)-(56, 120), 6
LINE (63, 119)-(63, 117), 6
LINE (62, 118)-(62, 117), 6
LINE (61, 117)-(61, 117), 6
PAINT (65, 114), 1, 8
LINE (62, 118)-(62, 117), 6
LINE (61, 117)-(61, 117), 6
LINE (63, 118)-(79, 118), 7
LINE (79, 117)-(63, 117), 7
LINE (77, 116)-(77, 116), 7
LINE (59, 135)-(57, 140), 8
LINE (57, 140)-(63, 140), 8
LINE (63, 140)-(62, 135), 8
LINE (69, 135)-(68, 140), 8
LINE (68, 140)-(73, 140), 8
LINE (73, 140)-(72, 135), 8
PAINT (60, 138), 1, 8
PAINT (70, 138), 1, 8
LINE (70, 119)-(72, 119), 14
GET (50, 100)-(80, 140), copright

LINE (80, 117)-(85, 114), 14
LINE (80, 117)-(87, 116), 14
LINE (80, 118)-(87, 119), 14
LINE (81, 117)-(86, 117), 14
LINE (80, 118)-(84, 121), 14
LINE (80, 117)-(84, 116), 42
LINE (80, 117)-(85, 117), 42
LINE (80, 117)-(84, 119), 42
LINE (80, 117)-(82, 116), 40
LINE (80, 117)-(83, 118), 40
GET (80, 114)-(87, 121), shotright

LINE (119, 101)-(113, 100), 6, B
LINE (119, 106)-(114, 102), 14, B
LINE (116, 107)-(118, 107), 14, B
PAINT (116, 105), 14, 14
PSET (113, 104), 14
PSET (114, 103), 12
PSET (115, 103), 15
LINE (109, 108)-(125, 108), 8
LINE (125, 108)-(127, 116), 8
LINE (127, 116)-(123, 120), 8
LINE (123, 120)-(119, 120), 8
LINE (119, 120)-(122, 115), 8
LINE (122, 115)-(120, 112), 8
LINE (109, 108)-(107, 110), 8
LINE (106, 111)-(109, 117), 8
LINE (109, 117)-(108, 120), 8
LINE (108, 120)-(112, 120), 8
LINE (112, 120)-(111, 112), 8
LINE (111, 121)-(109, 135), 8
LINE (109, 135)-(114, 135), 8
LINE (114, 135)-(117, 125), 8
LINE (117, 125)-(119, 135), 8
LINE (119, 135)-(123, 135), 8
LINE (123, 135)-(121, 120), 8
LINE (110, 136)-(109, 140), 8
LINE (109, 140)-(114, 140), 8
LINE (114, 140)-(113, 135), 8
LINE (120, 135)-(119, 140), 8
LINE (119, 140)-(124, 140), 8
LINE (124, 140)-(123, 135), 8
PAINT (121, 131), 1, 8
PAINT (121, 138), 1, 8
PAINT (112, 138), 1, 8
LINE (124, 120)-(128, 120), 6
LINE (125, 119)-(128, 119), 6
LINE (126, 118)-(128, 118), 6
LINE (119, 119)-(119, 117), 6
LINE (120, 117)-(120, 117), 6
LINE (118, 118)-(100, 118), 7
LINE (100, 117)-(118, 117), 7
LINE (103, 116)-(103, 116), 7
GET (100, 100)-(130, 140), copleft

LINE (109, 119)-(111, 119), 14
LINE (100, 117)-(96, 114), 14
LINE (100, 117)-(93, 116), 14
LINE (100, 118)-(94, 119), 14
LINE (100, 118)-(96, 121), 14
LINE (99, 117)-(96, 116), 42
LINE (99, 117)-(95, 118), 42
LINE (99, 118)-(96, 119), 42
LINE (99, 118)-(97, 117), 40
LINE (99, 117)-(96, 118), 40
LINE (96, 115)-(94, 115), 14
GET (93, 114)-(100, 121), shotleft

LINE (160, 109)-(165, 115), 8
LINE (165, 115)-(171, 113), 8
LINE (171, 113)-(174, 117), 8
LINE (174, 117)-(164, 119), 8
LINE (164, 119)-(156, 110), 8
LINE (156, 110)-(160, 109), 8
LINE (157, 111)-(157, 123), 8
LINE (158, 124)-(156, 135), 8
LINE (156, 135)-(161, 135), 8
LINE (161, 135)-(163, 124), 8
LINE (163, 124)-(162, 116), 8
LINE (157, 136)-(160, 136), 8
LINE (160, 136)-(163, 139), 8
LINE (157, 136)-(157, 140), 8
LINE (157, 140)-(163, 140), 8
PAINT (159, 139), 1, 8
PAINT (159, 133), 1, 8
PAINT (164, 117), 1, 8
LINE (172, 118)-(176, 122), 6
LINE (173, 118)-(176, 121), 6
LINE (174, 118)-(176, 120), 6
LINE (158, 108)-(161, 109), 14
LINE (158, 107)-(160, 105), 14
LINE (160, 105)-(163, 106), 14
LINE (160, 105)-(163, 105), 14
LINE (161, 104)-(162, 104), 14
LINE (161, 103)-(163, 105), 6
LINE (162, 103)-(164, 105), 6
LINE (163, 107)-(163, 107), 14
LINE (168, 113)-(164, 109), 7
LINE (164, 110)-(167, 113), 7
LINE (166, 110)-(166, 110), 7
PSET (163, 106), 12
PSET (162, 105), 15
GET (150, 100)-(180, 140), copdie

LINE (207, 110)-(212, 110), 8
LINE (207, 110)-(215, 118), 8
LINE (215, 118)-(221, 114), 8
LINE (221, 114)-(218, 111), 8
LINE (218, 111)-(215, 113), 8
LINE (215, 113)-(212, 111), 8
LINE (207, 111)-(208, 122), 8
LINE (208, 122)-(206, 133), 8
LINE (206, 134)-(206, 135), 8
LINE (206, 135)-(211, 135), 8
LINE (211, 135)-(213, 126), 8
LINE (213, 126)-(213, 115), 8
LINE (207, 136)-(210, 136), 8
LINE (210, 136)-(213, 140), 8
LINE (213, 140)-(207, 140), 8
LINE (207, 140)-(207, 136), 8
PAINT (209, 139), 1, 8
PAINT (209, 133), 1, 8
PAINT (214, 115), 1, 8
LINE (219, 116)-(223, 120), 6
LINE (220, 116)-(223, 119), 6
LINE (220, 115)-(224, 119), 6
LINE (216, 111)-(213, 108), 7
LINE (213, 107)-(216, 110), 7
LINE (215, 108)-(215, 108), 7
LINE (212, 108)-(208, 107), 14
LINE (212, 107)-(209, 105), 14
LINE (213, 107)-(212, 104), 14
LINE (212, 107)-(210, 107), 4
LINE (212, 108)-(212, 106), 4
LINE (208, 109)-(207, 108), 4
LINE (210, 109)-(211, 108), 4
LINE (204, 106)-(204, 108), 4
LINE (203, 107)-(205, 107), 4
LINE (204, 106)-(206, 104), 4
LINE (222, 105)-(222, 107), 4
LINE (221, 107)-(221, 105), 4
LINE (220, 106)-(223, 106), 4
LINE (220, 105)-(218, 104), 4
LINE (219, 104)-(219, 104), 4
GET (200, 100)-(230, 140), copdie2
CLS
LINE (61, 121)-(71, 121), 9
LINE (71, 121)-(74, 135), 9
LINE (74, 135)-(69, 135), 9
LINE (69, 135)-(66, 126), 9
LINE (66, 126)-(62, 135), 9
LINE (62, 135)-(57, 135), 9
LINE (57, 135)-(61, 121), 9
PAINT (63, 124), 9, 9
PAINT (58, 136), 6, 0
LINE (58, 136)-(61, 136), 6
LINE (62, 140)-(57, 137), 6, B
PAINT (60, 139), 6, 6
LINE (70, 136)-(73, 136), 6
LINE (74, 140)-(69, 137), 6, B
PAINT (73, 139), 6, 6
LINE (61, 121)-(71, 121), 6
LINE (71, 122)-(61, 122), 6
LINE (66, 122)-(65, 121), 14, B
LINE (62, 120)-(70, 120), 12
LINE (62, 120)-(59, 111), 12
LINE (59, 111)-(52, 108), 12
LINE (52, 108)-(52, 103), 12
LINE (52, 103)-(57, 103), 12
LINE (57, 103)-(57, 106), 12
LINE (57, 106)-(62, 108), 12
LINE (62, 108)-(65, 109), 12
LINE (65, 109)-(69, 108), 12
LINE (69, 108)-(74, 107), 12
LINE (70, 120)-(73, 111), 12
LINE (73, 111)-(78, 110), 12
LINE (75, 106)-(74, 103), 12
LINE (78, 110)-(79, 103), 12
LINE (79, 103)-(75, 103), 12
PAINT (77, 107), 4, 12
LINE (67, 108)-(64, 108), 14, B
LINE (68, 102)-(63, 107), 14, B
PAINT (65, 104), 14, 14
LINE (68, 100)-(63, 101), 6, B
LINE (56, 102)-(53, 100), 14, B
LINE (54, 101)-(55, 101), 14, B
LINE (76, 100)-(78, 102), 14, B
LINE (77, 101)-(77, 101), 14, B
LINE (64, 103)-(64, 103), 16, B
PSET (67, 103), 16
LINE (66, 107)-(65, 106), 16, B
GET (50, 100)-(80, 140), innocent
CLS
LINE (118, 101)-(113, 100), 6, B
LINE (118, 106)-(113, 102), 14, B
LINE (117, 107)-(114, 107), 14, B
PAINT (116, 103), 14, 14
PAINT (107, 108), 12, 0
LINE (107, 108)-(123, 108), 12
LINE (123, 108)-(126, 105), 12
LINE (126, 105)-(126, 102), 12
LINE (126, 102)-(130, 102), 12
LINE (130, 102)-(130, 107), 12
LINE (130, 107)-(123, 113), 12
LINE (123, 113)-(120, 120), 12
LINE (120, 120)-(110, 120), 12
LINE (110, 120)-(107, 112), 12
LINE (107, 108)-(104, 105), 12
LINE (104, 105)-(104, 102), 12
LINE (104, 102)-(100, 102), 12
LINE (100, 102)-(100, 107), 12
LINE (100, 108)-(107, 112), 12
PAINT (112, 117), 4, 12
LINE (120, 122)-(110, 121), 6, B
LINE (116, 121)-(115, 122), 14, B
LINE (110, 123)-(108, 129), 9
LINE (108, 130)-(115, 130), 9
LINE (115, 130)-(116, 127), 9
LINE (117, 127)-(119, 136), 9
LINE (119, 136)-(125, 136), 9
LINE (125, 136)-(120, 123), 9
LINE (120, 123)-(110, 123), 9
PAINT (121, 132), 9, 9
LINE (121, 137)-(124, 137), 6
LINE (125, 140)-(120, 138), 6, B
LINE (121, 139)-(125, 139), 6, B
LINE (111, 131)-(111, 136), 15
PSET (110, 137), 15
PSET (112, 137), 15
LINE (109, 131)-(107, 135), 4
LINE (113, 131)-(115, 134), 4
LINE (114, 131)-(113, 133), 1
LINE (108, 131)-(109, 133), 1
PSET (106, 137), 4
PSET (108, 139), 4
PSET (112, 139), 4
PSET (114, 136), 4
PSET (116, 137), 4
PSET (117, 135), 4
PSET (114, 139), 4
PSET (109, 136), 4
PSET (105, 139), 4
PSET (114, 103), 16
PSET (117, 103), 16
LINE (117, 106)-(114, 105), 16, B
LINE (103, 101)-(101, 100), 14, B
LINE (129, 101)-(127, 101), 14, B
LINE (127, 100)-(129, 100), 14, B
GET (100, 100)-(130, 140), innocentdie

LINE (167, 101)-(163, 100), 6, B
LINE (167, 106)-(163, 102), 14, B
LINE (164, 107)-(166, 107), 14, B
PAINT (165, 104), 14, 14
LINE (158, 108)-(173, 108), 12
LINE (173, 108)-(175, 106), 12
LINE (175, 105)-(175, 102), 12
LINE (175, 102)-(180, 102), 12
LINE (180, 102)-(180, 108), 12
LINE (180, 109)-(172, 113), 12
LINE (172, 113)-(170, 120), 12
LINE (170, 120)-(160, 120), 12
LINE (160, 120)-(157, 112), 12
LINE (158, 108)-(156, 106), 12
LINE (155, 105)-(155, 102), 12
LINE (155, 102)-(150, 102), 12
LINE (150, 102)-(150, 108), 12
LINE (150, 108)-(157, 112), 12
PAINT (163, 118), 4, 12
LINE (170, 122)-(160, 121), 6, B
LINE (166, 121)-(165, 122), 14, B
LINE (158, 114)-(163, 114), 0
LINE (163, 114)-(165, 116), 0
LINE (164, 117)-(162, 118), 0
LINE (162, 119)-(159, 119), 0
LINE (163, 118)-(163, 118), 0
PAINT (161, 116), 0, 0
LINE (162, 114)-(160, 111), 0
LINE (160, 111)-(155, 112), 0
PAINT (159, 112), 0, 0
LINE (160, 111)-(157, 111), 15
LINE (161, 111)-(161, 114), 15
LINE (161, 114)-(163, 114), 15
LINE (161, 114)-(161, 116), 15
LINE (161, 116)-(164, 116), 15
LINE (162, 113)-(160, 115), 4
LINE (164, 116)-(161, 117), 4
LINE (159, 111)-(158, 115), 1
PSET (157, 118), 4
PSET (156, 117), 4
PSET (155, 113), 4
PSET (153, 115), 4
PSET (154, 118), 4
PSET (156, 122), 4
PSET (153, 121), 4
LINE (154, 100)-(151, 101), 14, B
LINE (179, 100)-(176, 101), 14, B
LINE (160, 123)-(170, 123), 9
LINE (170, 123)-(173, 136), 9
LINE (173, 136)-(168, 136), 9
LINE (168, 136)-(165, 128), 9
LINE (165, 128)-(162, 131), 9
LINE (162, 131)-(157, 131), 9
LINE (157, 131)-(160, 123), 9
PAINT (163, 126), 9, 9
LINE (159, 132)-(159, 136), 15
PSET (158, 137), 15
PSET (160, 137), 15
LINE (157, 132)-(156, 135), 4
LINE (161, 132)-(162, 134), 4
LINE (161, 132)-(160, 134), 1
LINE (158, 132)-(159, 134), 1
PSET (154, 137), 4
PSET (156, 138), 4
PSET (156, 136), 4
PSET (159, 139), 4
PSET (162, 137), 4
PSET (162, 139), 4
PSET (165, 137), 4
LINE (169, 137)-(172, 137), 6
LINE (173, 140)-(168, 138), 6, B
LINE (169, 139)-(172, 139), 6, B
PSET (164, 103), 16
PSET (166, 103), 16
LINE (166, 106)-(164, 105), 16, B
GET (150, 100)-(180, 140), innocentdie2

LINE (223, 121)-(212, 120), 6, B
LINE (218, 120)-(217, 121), 14, B
LINE (212, 122)-(209, 128), 9
LINE (209, 128)-(216, 128), 9
LINE (216, 128)-(218, 125), 9
LINE (218, 125)-(220, 136), 9
LINE (220, 136)-(226, 136), 9
LINE (226, 136)-(223, 122), 9
LINE (223, 122)-(212, 122), 9
PAINT (214, 125), 9, 9
LINE (221, 137)-(224, 137), 6
LINE (225, 140)-(220, 138), 6, B
LINE (221, 139)-(224, 139), 6, B
LINE (213, 129)-(213, 134), 15
PSET (212, 135), 15
PSET (214, 135), 15
LINE (210, 129)-(209, 131), 4
LINE (212, 129)-(214, 130), 4
LINE (215, 129)-(216, 131), 4
LINE (211, 129)-(210, 132), 1
LINE (215, 129)-(215, 132), 1
LINE (217, 119)-(218, 112), 15
LINE (218, 112)-(218, 106), 15
LINE (224, 108)-(211, 106), 15, B
LINE (211, 110)-(224, 108), 15, B
LINE (223, 112)-(212, 110), 15, B
LINE (210, 107)-(205, 104), 15
LINE (205, 104)-(205, 101), 15
PSET (204, 100), 15
PSET (206, 100), 15
LINE (225, 107)-(229, 105), 15
LINE (229, 105)-(229, 101), 15
PSET (228, 100), 15
PSET (230, 100), 15
LINE (218, 105)-(218, 104), 15
LINE (219, 100)-(217, 103), 15, B
PSET (218, 101), 15
GET (200, 100)-(230, 140), innocentdie3
CLS
'ecopright
LINE (67, 101)-(63, 100), 6, B
LINE (67, 105)-(63, 102), 14, B
LINE (66, 106)-(64, 106), 14, B
PAINT (65, 104), 14, 14
PSET (68, 103), 14
PSET (67, 102), 16
PSET (66, 102), 15
LINE (58, 107)-(71, 107), 9
LINE (71, 107)-(71, 111), 9
LINE (71, 111)-(68, 118), 9
LINE (68, 119)-(71, 135), 9
LINE (71, 135)-(66, 135), 9
LINE (66, 135)-(63, 124), 9
LINE (63, 124)-(60, 135), 9
LINE (60, 135)-(55, 135), 9
LINE (55, 135)-(59, 119), 9
LINE (59, 119)-(57, 111), 9
LINE (58, 107)-(53, 108), 9
LINE (57, 111)-(55, 118), 9
LINE (55, 118)-(51, 118), 9
LINE (51, 118)-(53, 108), 9
PAINT (62, 111), 9, 9
LINE (79, 111)-(72, 107), 7, B
LINE (80, 106)-(80, 112), 7, B
PAINT (75, 109), 8, 7
PAINT (74, 109), 12, 8
PSET (74, 109), 32
PSET (75, 109), 33
PSET (76, 109), 34
PSET (77, 109), 35
LINE (53, 119)-(53, 120), 7
LINE (53, 120)-(51, 123), 7
LINE (53, 121)-(53, 123), 7
LINE (53, 121)-(56, 121), 7
LINE (56, 121)-(55, 123), 7
LINE (59, 119)-(68, 119), 16
LINE (52, 108)-(60, 106), 1
LINE (52, 108)-(53, 111), 1
LINE (53, 111)-(60, 109), 1
LINE (60, 109)-(60, 106), 1
PAINT (58, 108), 1, 1
LINE (68, 106)-(71, 107), 1
LINE (71, 107)-(71, 110), 1
LINE (71, 110)-(67, 109), 1
LINE (67, 109)-(67, 106), 1
PAINT (69, 109), 1, 1
LINE (66, 128)-(70, 128), 1
LINE (70, 128)-(71, 135), 1
LINE (71, 135)-(68, 135), 1
LINE (68, 135)-(66, 129), 1
PAINT (69, 131), 1, 1
LINE (57, 128)-(60, 128), 1
LINE (60, 128)-(57, 135), 1
LINE (57, 135)-(55, 135), 1
LINE (55, 135)-(57, 128), 1
PAINT (58, 130), 1, 1
LINE (67, 136)-(71, 136), 1
LINE (66, 137)-(72, 137), 1
LINE (72, 137)-(75, 140), 1
LINE (75, 140)-(67, 140), 1
LINE (67, 140)-(66, 137), 1
PAINT (69, 138), 1, 1
LINE (56, 136)-(59, 136), 1
LINE (54, 137)-(59, 137), 1
LINE (59, 137)-(59, 140), 1
LINE (59, 140)-(51, 140), 1
LINE (51, 140)-(54, 137), 1
PAINT (55, 139), 1, 1
LINE (59, 121)-(69, 120), 1, B
LINE (64, 121)-(63, 120), 14, B
LINE (68, 113)-(67, 112), 14, B
LINE (69, 111)-(66, 111), 14, B
GET (50, 100)-(80, 140), ecopright

LINE (117, 101)-(113, 100), 6, B
LINE (117, 105)-(113, 102), 14, B
LINE (117, 106)-(113, 106), 14, B
LINE (114, 107)-(116, 107), 14, B
LINE (116, 103)-(114, 104), 14, B
LINE (112, 104)-(112, 104), 14, B
PSET (113, 103), 16
PSET (114, 103), 15
LINE (109, 108)-(123, 108), 9
LINE (124, 108)-(127, 118), 9
LINE (127, 118)-(121, 118), 9
LINE (121, 118)-(119, 113), 9
LINE (119, 113)-(117, 119), 9
LINE (117, 119)-(121, 135), 9
LINE (121, 135)-(116, 135), 9
LINE (116, 135)-(113, 123), 9
LINE (113, 123)-(110, 135), 9
LINE (110, 135)-(106, 135), 9
LINE (106, 135)-(110, 119), 9
LINE (110, 119)-(108, 112), 9
LINE (108, 112)-(109, 108), 9
PAINT (113, 112), 9, 9
LINE (119, 115)-(121, 118), 0
LINE (119, 114)-(121, 116), 0
LINE (119, 113)-(121, 115), 0
LINE (108, 111)-(101, 108), 7, B
LINE (100, 112)-(100, 107), 7, B
LINE (107, 109)-(102, 110), 8, B
PSET (106, 109), 32
PSET (105, 109), 33
PSET (104, 109), 34
PSET (103, 109), 35
LINE (125, 119)-(125, 120), 7
LINE (125, 120)-(127, 122), 7
LINE (125, 120)-(125, 122), 7
LINE (125, 120)-(122, 120), 7
LINE (122, 120)-(123, 122), 7
PSET (123, 121), 16
PSET (122, 121), 7
LINE (120, 107)-(127, 108), 1
LINE (120, 107)-(120, 110), 1
LINE (120, 110)-(127, 111), 1
LINE (127, 111)-(127, 108), 1
PAINT (124, 109), 1, 1
LINE (112, 107)-(109, 108), 1
LINE (109, 108)-(109, 110), 1
LINE (109, 110)-(112, 109), 1
LINE (112, 109)-(112, 107), 1
LINE (112, 108)-(110, 108), 1
LINE (110, 119)-(118, 119), 0
LINE (118, 121)-(110, 120), 1, B
LINE (115, 120)-(114, 121), 14, B
LINE (108, 128)-(111, 128), 1
LINE (111, 128)-(108, 135), 1
LINE (108, 135)-(105, 135), 1
LINE (105, 135)-(108, 128), 1
PAINT (109, 130), 1, 1
LINE (117, 128)-(120, 128), 1
LINE (120, 128)-(122, 135), 1
LINE (122, 135)-(119, 135), 1
LINE (119, 135)-(117, 128), 1
PAINT (120, 130), 1, 1
LINE (117, 136)-(121, 136), 1
LINE (121, 136)-(124, 140), 1
LINE (124, 140)-(117, 140), 1
LINE (117, 140)-(117, 136), 1
PAINT (119, 138), 1, 1
LINE (109, 136)-(106, 136), 1
LINE (106, 136)-(103, 140), 1
LINE (103, 140)-(109, 140), 1
LINE (110, 140)-(110, 136), 1
PAINT (108, 138), 1, 1
LINE (113, 111)-(110, 111), 14, B
LINE (112, 113)-(111, 112), 14, B
GET (100, 100)-(130, 140), ecopleft

LINE (167, 101)-(163, 100), 6, B
LINE (167, 106)-(163, 102), 14, B
LINE (164, 107)-(166, 107), 14, B
PAINT (165, 105), 14, 14
PSET (164, 103), 16
PSET (166, 103), 16
PSET (165, 106), 16
LINE (158, 108)-(173, 108), 9
LINE (173, 108)-(177, 117), 9
LINE (177, 117)-(171, 117), 9
LINE (171, 117)-(169, 112), 9
LINE (169, 112)-(167, 119), 9
LINE (167, 119)-(171, 134), 9
LINE (171, 134)-(171, 135), 9
LINE (171, 135)-(166, 135), 9
LINE (166, 135)-(163, 126), 9
LINE (163, 126)-(161, 135), 9
LINE (161, 135)-(156, 135), 9
LINE (156, 135)-(160, 119), 9
LINE (160, 119)-(159, 112), 9
LINE (159, 112)-(158, 108), 9
LINE (158, 110)-(157, 110), 15
LINE (158, 111)-(157, 113), 4
LINE (158, 109)-(157, 107), 4
LINE (158, 111)-(155, 112), 1
PSET (152, 110), 4
PSET (154, 112), 4
PSET (153, 113), 4
PSET (155, 115), 4
PSET (155, 109), 4
PSET (152, 107), 4
PSET (153, 108), 4
PSET (155, 108), 4
PAINT (164, 112), 9, 9
LINE (168, 119)-(158, 119), 16
LINE (168, 121)-(160, 120), 1, B
LINE (165, 120)-(164, 121), 14, B
LINE (169, 107)-(176, 108), 1
LINE (176, 108)-(176, 110), 1
LINE (176, 110)-(169, 109), 1
LINE (169, 109)-(169, 107), 1
LINE (170, 108)-(170, 108), 1
LINE (171, 109)-(175, 109), 1
LINE (174, 118)-(174, 119), 7
LINE (174, 119)-(171, 122), 7
LINE (174, 119)-(174, 122), 7
LINE (174, 120)-(177, 120), 7
LINE (158, 130)-(161, 130), 1
LINE (161, 130)-(160, 135), 1
LINE (160, 135)-(157, 135), 1
LINE (157, 135)-(158, 130), 1
PAINT (159, 132), 1, 1
LINE (159, 129)-(162, 129), 1
LINE (166, 129)-(167, 135), 1
LINE (167, 135)-(171, 135), 1
LINE (171, 135)-(169, 129), 1
LINE (169, 129)-(166, 129), 1
PAINT (168, 130), 1, 1
PAINT (157, 136), 1, 0
LINE (157, 136)-(159, 136), 1
LINE (160, 140)-(156, 137), 1, B
LINE (169, 136)-(167, 136), 1, B
LINE (170, 140)-(166, 137), 1, B
LINE (169, 138)-(167, 139), 1, B
LINE (157, 139)-(159, 138), 1, B
GET (150, 100)-(180, 140), ecopdie

LINE (209, 107)-(223, 107), 9
LINE (223, 107)-(228, 116), 9
LINE (228, 116)-(223, 116), 9
LINE (223, 116)-(221, 112), 9
LINE (221, 112)-(219, 118), 9
LINE (219, 118)-(213, 118), 9
LINE (213, 118)-(209, 111), 9
LINE (209, 111)-(209, 107), 9
LINE (208, 109)-(207, 109), 15
LINE (208, 108)-(207, 106), 4
LINE (209, 110)-(207, 112), 4
PSET (209, 110), 9
LINE (208, 108)-(205, 107), 1
PSET (203, 109), 4
PSET (205, 111), 4
PSET (203, 113), 4
PSET (204, 114), 4
PSET (206, 114), 4
PSET (201, 111), 4
PSET (202, 107), 4
PSET (204, 105), 4
PAINT (213, 111), 9, 9
LINE (220, 121)-(213, 120), 1, B
LINE (217, 120)-(216, 121), 14, B
LINE (213, 122)-(220, 122), 9
LINE (220, 122)-(223, 136), 9
LINE (223, 136)-(219, 136), 9
LINE (219, 136)-(216, 127), 9
LINE (216, 127)-(213, 136), 9
LINE (213, 136)-(209, 136), 9
LINE (209, 136)-(213, 122), 9
PAINT (216, 125), 9, 9
LINE (225, 117)-(225, 118), 7
LINE (225, 119)-(228, 119), 7
LINE (225, 119)-(225, 121), 7
LINE (225, 119)-(222, 121), 7
LINE (217, 106)-(217, 105), 15
LINE (215, 106)-(213, 104), 4
LINE (219, 106)-(220, 105), 4
LINE (214, 106)-(215, 104), 1
PSET (213, 102), 4
PSET (210, 103), 4
PSET (210, 101), 4
PSET (215, 100), 4
PSET (216, 102), 4
PSET (220, 101), 4
PSET (222, 103), 4
PSET (219, 103), 4
LINE (219, 106)-(226, 107), 1
LINE (226, 107)-(226, 110), 1
LINE (226, 110)-(219, 109), 1
LINE (219, 109)-(219, 106), 1
PAINT (222, 108), 1, 1
LINE (212, 130)-(214, 130), 1
LINE (215, 130)-(213, 136), 1
LINE (213, 136)-(210, 136), 1
LINE (210, 136)-(212, 130), 1
PAINT (213, 132), 1, 1
LINE (219, 130)-(221, 130), 1
LINE (219, 130)-(220, 136), 1
LINE (220, 136)-(223, 136), 1
LINE (223, 136)-(221, 130), 1
PAINT (221, 132), 1, 1
LINE (220, 137)-(222, 137), 1
LINE (223, 140)-(219, 138), 1, B
LINE (220, 139)-(223, 139), 1, B
LINE (212, 137)-(210, 137), 1, B
LINE (213, 140)-(209, 138), 1, B
LINE (210, 139)-(212, 139), 1, B
GET (200, 100)-(230, 140), ecopdie2
CLS
END SUB

SUB hacksoft
        CLS
        LOCATE 5, 10: PRINT "HACKSOFT"
        SLEEP 2
END SUB

SUB innocentmoving
        LINE (il, iu)-(il + 30, iu + 40), 0, BF
        IF iposition = 0 THEN
                PUT (il, iu), innocent
        ELSEIF iposition = 1 THEN
                PUT (il, iu), innocentdie
        ELSEIF iposition = 2 THEN
                PUT (il, iu), innocentdie2
        ELSEIF iposition = 3 THEN
                PUT (il, iu), innocentdie3
        END IF
        IF move$ = " " AND position = 2 AND l > il - 100 AND l < il AND u + 20 > iu AND u + 20 < iu + 40 THEN
                IF iposition < 3 THEN
                        iposition = iposition + 1
                END IF
        ELSEIF move$ = " " AND position = 1 AND l < il + 100 AND l > il AND u + 20 > iu AND u + 20 < iu + 40 THEN
                IF iposition < 3 THEN
                        iposition = iposition + 1
                END IF
        END IF
END SUB

SUB instructions
LINE (95, 5)-(105, 5), 1
LINE (100, 5)-(100, 11), 1
LINE (96, 11)-(106, 11), 1
LINE (109, 11)-(112, 7), 1
LINE (112, 7)-(116, 10), 1
LINE (123, 6)-(119, 8), 1
LINE (119, 8)-(124, 10), 1
LINE (124, 10)-(120, 12), 1
LINE (129, 12)-(130, 4), 1
LINE (128, 7)-(133, 7), 1
LINE (137, 11)-(137, 7), 1
LINE (137, 8)-(142, 7), 1
LINE (146, 7)-(149, 11), 1
LINE (149, 11)-(152, 8), 1
LINE (159, 8)-(156, 10), 1
LINE (156, 10)-(158, 12), 1
LINE (164, 12)-(165, 5), 1
LINE (162, 8)-(167, 8), 1
LINE (169, 11)-(170, 8), 1
LINE (170, 5)-(170, 5), 1
LINE (178, 12)-(174, 8), 1, B
LINE (182, 8)-(182, 12), 1, B
LINE (186, 8)-(182, 9), 1, B
LINE (186, 12)-(186, 9), 1, B
LINE (193, 8)-(189, 9), 1
LINE (189, 9)-(194, 11), 1
LINE (194, 11)-(189, 13), 1
LINE (198, 15)-(93, 15), 1
LINE (39, 41)-(29, 31), 7, B
PAINT (34, 36), 7, 7
LINE (29, 41)-(39, 41), 8
LINE (39, 41)-(39, 31), 8
LINE (32, 35)-(37, 35), 16
LINE (37, 35)-(35, 33), 16
LINE (35, 33)-(35, 37), 16
LINE (35, 37)-(37, 35), 16
LINE (46, 34)-(50, 34), 15
LINE (60, 38)-(60, 31), 15
LINE (60, 31)-(64, 35), 15
LINE (64, 35)-(67, 31), 15
LINE (67, 31)-(67, 38), 15
LINE (76, 38)-(72, 34), 15, B
LINE (81, 36)-(84, 39), 15
LINE (84, 39)-(87, 34), 15
LINE (96, 36)-(91, 34), 15, B
LINE (91, 36)-(91, 38), 15
LINE (91, 38)-(96, 39), 15
LINE (106, 39)-(106, 29), 15
LINE (106, 29)-(111, 33), 15
LINE (111, 33)-(106, 35), 15
LINE (106, 35)-(111, 40), 15
LINE (115, 40)-(115, 36), 15
LINE (115, 34)-(115, 34), 15
LINE (123, 38)-(119, 36), 15, B
LINE (123, 41)-(123, 35), 15, B
LINE (119, 42)-(123, 42), 15, B
LINE (126, 39)-(126, 28), 15
LINE (126, 36)-(131, 34), 15
LINE (131, 34)-(131, 38), 15
LINE (136, 38)-(136, 29), 15
LINE (134, 34)-(138, 34), 15
LINE (39, 61)-(29, 51), 7, B
PAINT (34, 56), 7, 7
LINE (29, 61)-(39, 61), 8
LINE (39, 61)-(39, 51), 8
LINE (32, 56)-(37, 56), 16
LINE (32, 56)-(34, 54), 16
LINE (34, 54)-(34, 58), 16
LINE (34, 58)-(32, 56), 16
LINE (46, 56)-(51, 56), 15
LINE (61, 61)-(61, 51), 15
LINE (61, 51)-(66, 56), 15
LINE (66, 56)-(71, 51), 15
LINE (71, 51)-(71, 61), 15
LINE (81, 61)-(76, 56), 15, B
LINE (85, 56)-(89, 61), 15
LINE (89, 61)-(92, 56), 15
LINE (100, 58)-(95, 56), 15, B
LINE (95, 58)-(95, 59), 15
LINE (95, 60)-(100, 62), 15
LINE (111, 50)-(111, 62), 15
LINE (111, 62)-(118, 62), 15
LINE (127, 58)-(122, 56), 15, B
LINE (122, 59)-(122, 58), 15, B
LINE (122, 60)-(127, 62), 15
LINE (132, 62)-(132, 51), 15
LINE (132, 51)-(137, 48), 15
LINE (130, 56)-(135, 56), 15
LINE (142, 62)-(143, 51), 15
LINE (140, 55)-(147, 56), 15
LINE (39, 81)-(29, 71), 7, B
PAINT (34, 76), 7, 7
LINE (29, 81)-(39, 81), 8
LINE (39, 81)-(39, 71), 8
LINE (34, 78)-(34, 74), 16
LINE (34, 73)-(32, 75), 16
LINE (32, 75)-(36, 75), 16
LINE (36, 75)-(34, 73), 16
LINE (47, 75)-(52, 75), 15
LINE (62, 71)-(72, 71), 15
LINE (67, 71)-(67, 81), 15
LINE (67, 81)-(62, 76), 15
LINE (72, 76)-(72, 81), 15
LINE (72, 81)-(77, 81), 15
LINE (77, 81)-(77, 76), 15
LINE (82, 81)-(82, 76), 15
LINE (82, 76)-(92, 76), 15
LINE (92, 76)-(92, 81), 15
LINE (87, 76)-(87, 81), 15
LINE (97, 76)-(97, 86), 15
LINE (102, 81)-(97, 77), 15, B
LINE (39, 101)-(29, 91), 7, B
PAINT (30, 100), 7, 7
LINE (29, 101)-(39, 101), 8
LINE (39, 101)-(39, 91), 8
LINE (31, 94)-(30, 94), 16
LINE (30, 94)-(30, 96), 16
LINE (30, 96)-(31, 96), 16
LINE (31, 96)-(31, 98), 16
LINE (31, 98)-(30, 98), 16
LINE (33, 98)-(33, 94), 16
LINE (33, 94)-(35, 94), 16
LINE (35, 94)-(35, 96), 16
LINE (35, 96)-(34, 96), 16
LINE (38, 94)-(37, 94), 16
LINE (37, 94)-(37, 98), 16
LINE (37, 98)-(39, 98), 16
PSET (39, 98), 8
LINE (47, 95)-(52, 95), 15
LINE (72, 90)-(62, 90), 15
LINE (62, 90)-(62, 95), 15
LINE (62, 95)-(67, 95), 15
LINE (67, 95)-(67, 100), 15
LINE (67, 100)-(62, 100), 15
LINE (77, 90)-(77, 100), 15
LINE (77, 95)-(82, 95), 15
LINE (82, 100)-(82, 95), 15
LINE (92, 100)-(87, 95), 15, B
LINE (102, 100)-(97, 95), 15, B
LINE (107, 90)-(107, 100), 15, B
LINE (104, 93)-(111, 95), 15
COLOR 12
LOCATE 15, 4: PRINT "Note: If you are shot you will"
LOCATE 16, 4: PRINT "automatically commit suicide. "
LOCATE 17, 4: PRINT "To make things worse, psychos "
LOCATE 18, 4: PRINT "only get one chance to go out "
LOCATE 19, 4: PRINT "on a killing spree meaning:   "
LOCATE 20, 4: PRINT "Once you're dead, you're dead!"
move$ = CHR$(0)
DO
        move$ = INKEY$
LOOP UNTIL move$ = " "
CLS
mainmenu
END SUB

SUB mainmenu
CLS
LINE (40, 10)-(30, 15), 1
LINE (30, 15)-(45, 25), 1
LINE (45, 25)-(30, 30), 1
LINE (55, 30)-(55, 10), 1
LINE (55, 10)-(65, 15), 1
LINE (65, 15)-(55, 20), 1
LINE (70, 30)-(80, 10), 1
LINE (80, 10)-(90, 30), 1
LINE (85, 20)-(75, 20), 1
LINE (100, 20)-(115, 10), 1
LINE (100, 20)-(115, 30), 1
LINE (125, 30)-(125, 10), 1
LINE (125, 10)-(135, 10), 1
LINE (125, 20)-(130, 20), 1
LINE (125, 30)-(135, 30), 1
LINE (160, 40)-(170, 10), 4
LINE (170, 10)-(185, 20), 4
LINE (185, 20)-(165, 25), 4
LINE (205, 10)-(190, 25), 4
LINE (190, 25)-(205, 20), 4
LINE (205, 20)-(190, 35), 4
LINE (215, 10)-(230, 25), 4
LINE (235, 10)-(225, 40), 4
LINE (255, 10)-(240, 25), 4
LINE (240, 25)-(240, 35), 4
LINE (240, 35)-(255, 30), 4
LINE (265, 10)-(260, 35), 4
LINE (260, 20)-(280, 20), 4
LINE (275, 10)-(280, 35), 4
LINE (295, 10)-(290, 30), 4
LINE (290, 30)-(305, 30), 4
LINE (305, 30)-(305, 5), 4
LINE (305, 5)-(295, 10), 4
LINE (105, 50)-(105, 56), 10
LINE (105, 50)-(110, 53), 10
LINE (110, 53)-(114, 50), 10
LINE (114, 50)-(114, 57), 10
LINE (121, 57)-(126, 49), 10
LINE (130, 57)-(130, 57), 10
LINE (130, 57)-(126, 49), 10
LINE (124, 53)-(128, 53), 10
LINE (134, 49)-(142, 49), 10
LINE (139, 49)-(139, 56), 10
LINE (134, 56)-(144, 56), 10
LINE (148, 56)-(148, 48), 10
LINE (148, 48)-(155, 56), 10
LINE (155, 56)-(155, 48), 10
LINE (170, 56)-(170, 48), 10
LINE (170, 48)-(176, 52), 10
LINE (176, 52)-(180, 48), 10
LINE (180, 48)-(180, 56), 10
LINE (184, 56)-(184, 48), 10
LINE (184, 48)-(189, 48), 10
LINE (185, 53)-(188, 53), 10
LINE (184, 56)-(189, 56), 10
LINE (194, 56)-(194, 47), 10
LINE (194, 47)-(200, 57), 10
LINE (200, 57)-(200, 47), 10
LINE (206, 47)-(206, 53), 10
LINE (206, 53)-(211, 56), 10
LINE (211, 56)-(214, 53), 10
LINE (214, 53)-(214, 46), 10
LINE (224, 61)-(99, 61), 10
LINE (74, 79)-(78, 75), 13
LINE (78, 75)-(78, 85), 13
LINE (75, 85)-(82, 85), 13
LINE (85, 74)-(91, 80), 13
LINE (91, 80)-(87, 86), 13
LINE (102, 71)-(112, 71), 13
LINE (102, 71)-(102, 86), 13
LINE (102, 78)-(112, 71), 13
LINE (117, 71)-(117, 84), 13
LINE (124, 79)-(127, 76), 13
LINE (127, 76)-(130, 79), 13
LINE (124, 79)-(127, 83), 13
LINE (127, 83)-(130, 79), 13
LINE (131, 76)-(131, 82), 13
LINE (132, 83)-(132, 83), 13
LINE (138, 76)-(144, 82), 13
LINE (148, 75)-(143, 87), 13
LINE (73, 97)-(83, 99), 13
LINE (83, 99)-(75, 107), 13
LINE (75, 107)-(83, 107), 13
LINE (88, 96)-(94, 102), 13
LINE (94, 102)-(88, 108), 13
LINE (110, 96)-(104, 103), 13
LINE (104, 103)-(111, 103), 13
LINE (111, 103)-(105, 109), 13
LINE (120, 109)-(119, 96), 13
LINE (116, 103)-(124, 103), 13
LINE (135, 108)-(129, 103), 13, B
LINE (139, 102)-(139, 108), 13, B
PSET (140, 104), 13
LINE (141, 103)-(145, 103), 13
LINE (149, 103)-(153, 107), 13
LINE (156, 102)-(150, 111), 13
LINE (75, 118)-(86, 122), 13
LINE (86, 122)-(80, 125), 13
LINE (80, 125)-(85, 127), 13
LINE (85, 127)-(76, 130), 13
LINE (91, 119)-(96, 124), 13
LINE (96, 124)-(90, 130), 13
LINE (104, 119)-(112, 119), 13
LINE (108, 119)-(108, 129), 13
LINE (103, 129)-(113, 129), 13
LINE (117, 129)-(121, 123), 13
LINE (121, 123)-(126, 128), 13
LINE (135, 122)-(130, 124), 13
LINE (130, 124)-(136, 127), 13
LINE (136, 127)-(130, 130), 13
LINE (141, 130)-(141, 115), 13
LINE (138, 124)-(145, 121), 13
LINE (147, 129)-(147, 124), 13
LINE (147, 125)-(153, 123), 13
LINE (158, 124)-(159, 128), 13
LINE (159, 128)-(163, 128), 13
LINE (163, 128)-(163, 123), 13
LINE (169, 125)-(173, 121), 13
LINE (169, 125)-(173, 129), 13
LINE (178, 129)-(178, 116), 13
LINE (175, 124)-(181, 124), 13
LINE (187, 124)-(187, 129), 13
LINE (187, 121)-(187, 121), 13
LINE (198, 128)-(193, 123), 13, B
LINE (203, 128)-(203, 122), 13
LINE (203, 124)-(209, 121), 13
LINE (209, 121)-(209, 128), 13
LINE (219, 121)-(214, 124), 13
LINE (214, 124)-(219, 125), 13
LINE (219, 125)-(215, 129), 13
LINE (75, 139)-(75, 144), 13
LINE (75, 144)-(84, 144), 13
LINE (81, 139)-(81, 148), 13
LINE (90, 139)-(95, 145), 13
LINE (95, 145)-(89, 151), 13
LINE (110, 148)-(102, 140), 13, B
LINE (107, 145)-(109, 150), 13
LINE (115, 143)-(115, 148), 13
LINE (115, 148)-(120, 148), 13
LINE (120, 148)-(120, 142), 13
LINE (125, 142)-(125, 147), 13
PSET (125, 140), 13
LINE (129, 147)-(130, 137), 13
LINE (127, 141)-(133, 141), 13
move$ = CHR$(0)
DO
        move$ = INKEY$
LOOP UNTIL move$ = "1" OR move$ = "2" OR move$ = "3" OR move$ = "4"
CLS
IF move$ = "1" THEN
        thegame
ELSEIF move$ = "2" THEN
        story
ELSEIF move$ = "3" THEN
        instructions
ELSEIF move$ = "4" THEN
        END
END IF
END SUB

SUB presents
CLS
LINE (30, 95)-(30, 60), 34
LINE (30, 60)-(50, 60), 34
LINE (50, 60)-(56, 69), 34
LINE (56, 69)-(51, 76), 34
LINE (51, 76)-(36, 76), 34
LINE (36, 76)-(36, 96), 34
LINE (36, 96)-(30, 96), 34
LINE (36, 70)-(36, 65), 34
LINE (36, 65)-(48, 65), 34
LINE (48, 65)-(50, 68), 34
LINE (50, 68)-(48, 70), 34
LINE (48, 70)-(37, 70), 34
LINE (62, 96)-(62, 60), 34
LINE (62, 60)-(77, 60), 34
LINE (77, 60)-(84, 67), 34
LINE (84, 67)-(77, 75), 34
LINE (77, 75)-(69, 76), 34
LINE (69, 76)-(83, 96), 34
LINE (83, 96)-(73, 96), 34
LINE (73, 96)-(68, 86), 34
LINE (68, 86)-(68, 96), 34
LINE (68, 96)-(62, 96), 34
LINE (69, 65)-(69, 70), 34
LINE (69, 70)-(75, 70), 34
LINE (75, 70)-(77, 67), 34
LINE (77, 67)-(75, 65), 34
LINE (75, 65)-(69, 65), 34
LINE (89, 59)-(89, 96), 34
LINE (89, 96)-(109, 96), 34
LINE (109, 96)-(109, 91), 34
LINE (109, 91)-(94, 91), 34
LINE (94, 91)-(94, 76), 34
LINE (94, 76)-(104, 76), 34
LINE (104, 76)-(104, 71), 34
LINE (104, 71)-(94, 71), 34
LINE (94, 71)-(94, 62), 34
LINE (94, 62)-(109, 62), 34
LINE (109, 62)-(109, 57), 34
LINE (109, 57)-(89, 57), 34
LINE (89, 57)-(89, 59), 34
LINE (139, 59)-(119, 59), 34
LINE (119, 59)-(119, 79), 34
LINE (119, 79)-(119, 79), 34
LINE (134, 79)-(119, 79), 34
LINE (119, 79)-(134, 79), 34
LINE (134, 79)-(134, 89), 34
LINE (134, 89)-(119, 89), 34
LINE (119, 89)-(119, 95), 34
LINE (119, 95)-(140, 95), 34
LINE (140, 95)-(140, 73), 34
LINE (140, 73)-(125, 73), 34
LINE (125, 73)-(125, 63), 34
LINE (125, 63)-(140, 63), 34
LINE (140, 63)-(140, 59), 34
LINE (146, 59)-(146, 94), 34
LINE (146, 94)-(166, 94), 34
LINE (166, 94)-(166, 89), 34
LINE (166, 89)-(151, 89), 34
LINE (151, 89)-(151, 74), 34
LINE (151, 74)-(161, 74), 34
LINE (161, 74)-(161, 69), 34
LINE (161, 69)-(151, 69), 34
LINE (151, 69)-(151, 64), 34
LINE (151, 64)-(166, 64), 34
LINE (166, 64)-(166, 59), 34
LINE (166, 59)-(146, 59), 34
LINE (171, 94)-(171, 59), 34
LINE (171, 59)-(181, 59), 34
LINE (181, 59)-(191, 79), 34
LINE (191, 79)-(191, 59), 34
LINE (191, 59)-(201, 59), 34
LINE (201, 59)-(201, 94), 34
LINE (201, 94)-(191, 94), 34
LINE (191, 94)-(181, 74), 34
LINE (181, 74)-(181, 94), 34
LINE (181, 94)-(171, 94), 34
LINE (206, 59)-(236, 59), 34
LINE (236, 59)-(236, 64), 34
LINE (236, 64)-(226, 64), 34
LINE (226, 64)-(226, 94), 34
LINE (221, 94)-(226, 94), 34
LINE (221, 94)-(221, 64), 34
LINE (221, 64)-(206, 64), 34
LINE (206, 64)-(206, 59), 34
LINE (241, 59)-(271, 59), 34
LINE (271, 59)-(271, 64), 34
LINE (271, 64)-(246, 64), 34
LINE (246, 64)-(246, 74), 34
LINE (246, 74)-(271, 74), 34
LINE (271, 74)-(271, 94), 34
LINE (271, 94)-(241, 94), 34
LINE (241, 89)-(241, 94), 34
LINE (241, 89)-(266, 89), 34
LINE (266, 89)-(266, 79), 34
LINE (266, 79)-(241, 79), 34
LINE (241, 79)-(241, 59), 34
CIRCLE (282, 93), 3, 34
CIRCLE (292, 93), 3, 34
CIRCLE (302, 93), 3, 34
PAINT (32, 91), 38, 34
PAINT (67, 81), 38, 34
PAINT (92, 81), 38, 34
PAINT (137, 81), 38, 34
PAINT (148, 81), 38, 34
PAINT (173, 81), 38, 34
PAINT (223, 81), 38, 34
PAINT (268, 81), 38, 34
PAINT (282, 93), 38, 34
PAINT (292, 93), 38, 34
PAINT (302, 93), 38, 34
SLEEP 2
END SUB

SUB story
CLS
'Happy guy.
LINE (114, 40)-(144, 45), 6
LINE (144, 45)-(174, 40), 6
LINE (114, 40)-(114, 55), 6
LINE (114, 55)-(144, 60), 6
LINE (144, 60)-(174, 55), 6
LINE (174, 55)-(174, 40), 6
PAINT (134, 55), 6, 6
LINE (118, 56)-(118, 36), 16
LINE (123, 61)-(123, 41), 16
LINE (128, 61)-(128, 41), 16
LINE (133, 61)-(133, 41), 16
LINE (138, 41)-(138, 61), 16
LINE (143, 61)-(143, 41), 16
LINE (148, 61)-(148, 41), 16
LINE (148, 41)-(153, 41), 16
LINE (153, 41)-(153, 61), 16
LINE (158, 61)-(158, 41), 16
LINE (163, 41)-(163, 56), 16
LINE (168, 61)-(168, 36), 16
LINE (173, 36)-(173, 56), 16
LINE (115, 56)-(143, 61), 14
LINE (143, 61)-(173, 56), 14
LINE (173, 56)-(168, 96), 14
LINE (168, 96)-(143, 101), 14
LINE (143, 101)-(118, 96), 14
LINE (118, 96)-(113, 56), 14
PSET (114, 56), 14
PAINT (119, 63), 14, 14
LINE (123, 65)-(134, 67), 15
LINE (134, 67)-(134, 72), 15
LINE (134, 72)-(124, 71), 15
LINE (124, 71)-(124, 66), 15
PAINT (128, 69), 15, 15
LINE (150, 67)-(159, 65), 15
LINE (159, 65)-(159, 70), 15
LINE (159, 70)-(150, 72), 15
LINE (150, 72)-(150, 67), 15
PAINT (154, 69), 15, 15
LINE (150, 62)-(158, 61), 16
LINE (158, 61)-(161, 64), 16
LINE (136, 63)-(125, 61), 16
LINE (125, 61)-(119, 63), 16
LINE (130, 70)-(128, 68), 9, B
LINE (156, 69)-(154, 67), 9, B
PSET (155, 68), 16
PSET (129, 69), 16
LINE (142, 70)-(136, 80), 16
LINE (136, 80)-(143, 81), 16
LINE (128, 85)-(132, 89), 16
LINE (132, 89)-(141, 91), 16
LINE (141, 91)-(149, 89), 16
LINE (149, 89)-(152, 85), 16
LINE (118, 96)-(143, 101), 1
LINE (143, 101)-(168, 96), 1
LINE (168, 96)-(233, 106), 1
LINE (233, 106)-(248, 151), 1
LINE (248, 151)-(198, 151), 1
LINE (198, 151)-(193, 126), 1
LINE (193, 126)-(183, 151), 1
LINE (118, 96)-(53, 106), 1
LINE (53, 106)-(33, 151), 1
LINE (33, 151)-(83, 151), 1
LINE (83, 151)-(93, 126), 1
LINE (93, 126)-(103, 151), 1
LINE (103, 151)-(183, 151), 1
PAINT (173, 136), 1, 1
LINE (117, 96)-(112, 103), 0
LINE (112, 103)-(142, 108), 0
LINE (142, 108)-(169, 102), 0
LINE (169, 102)-(168, 96), 0
LINE (148, 106)-(136, 115), 0
LINE (136, 115)-(139, 151), 0
LINE (146, 123)-(144, 121), 0, B
LINE (146, 135)-(144, 133), 0, B
LINE (147, 146)-(145, 144), 0, B
LINE (165, 127)-(180, 127), 14
LINE (180, 127)-(176, 131), 14
LINE (165, 127)-(168, 131), 14
LINE (168, 131)-(165, 138), 14
LINE (165, 138)-(172, 141), 14
LINE (172, 141)-(178, 139), 14
LINE (178, 139)-(176, 132), 14
PAINT (173, 132), 14, 14
LINE (172, 133)-(172, 137), 16
LINE (172, 137)-(169, 139), 16
LINE (172, 137)-(174, 139), 16
LINE (172, 137)-(175, 135), 16
LINE (172, 137)-(169, 135), 16
LINE (168, 128)-(170, 129), 16
LINE (171, 128)-(172, 129), 16
LINE (174, 128)-(174, 128), 16
LINE (175, 129)-(176, 128), 16
LINE (177, 128)-(176, 129), 16
LINE (174, 129)-(172, 128), 16
LINE (169, 128)-(169, 128), 16
LINE (1, 152)-(319, 152), 15
COLOR 15: LOCATE 21, 1: PRINT "You are a loyal man that has served a"
          LOCATE 22, 1: PRINT "24th century police for many years."
          LOCATE 23, 1: PRINT "Suddenly, your brain just 'clicks'."
          
move$ = CHR$(0)
DO
        move$ = INKEY$
LOOP UNTIL move$ = " "
'The psycho guy add-on.
LINE (156, 69)-(154, 68), 4, B
LINE (154, 67)-(156, 67), 4, B
LINE (130, 70)-(129, 68), 4, B
LINE (128, 68)-(128, 70), 4, B
LINE (136, 63)-(141, 68), 0
LINE (141, 68)-(141, 68), 0
LINE (146, 67)-(150, 62), 0
LINE (119, 63)-(120, 62), 14
LINE (120, 62)-(122, 62), 14
LINE (122, 61)-(126, 61), 14
LINE (152, 61)-(158, 61), 14
LINE (159, 62)-(161, 64), 14
LINE (152, 62)-(157, 61), 0
LINE (128, 85)-(128, 81), 0
LINE (128, 81)-(141, 85), 0
LINE (141, 85)-(152, 82), 0
LINE (152, 82)-(152, 85), 0
LINE (128, 84)-(140, 88), 0
LINE (140, 88)-(152, 84), 0
LINE (140, 85)-(140, 91), 0
LINE (144, 90)-(144, 84), 0
LINE (147, 83)-(147, 89), 0
LINE (150, 88)-(150, 82), 0
LINE (137, 84)-(137, 90), 0
LINE (134, 90)-(134, 83), 0
LINE (131, 82)-(131, 88), 0
CIRCLE (196, 58), 8, 15
CIRCLE (221, 42), 10, 15
CIRCLE (276, 32), 35, 15
PAINT (196, 62), 15, 15
PAINT (221, 42), 15, 15
PAINT (266, 42), 15, 15
LINE (266, 37)-(279, 41), 1
LINE (279, 41)-(275, 53), 1
LINE (275, 53)-(269, 50), 1
LINE (269, 50)-(271, 43), 1
LINE (271, 43)-(265, 47), 1
LINE (265, 47)-(261, 43), 1
LINE (261, 43)-(267, 37), 1
PAINT (266, 41), 1, 1
LINE (264, 47)-(256, 39), 6
LINE (256, 39)-(260, 48), 6
LINE (260, 48)-(264, 47), 6
PAINT (261, 46), 6, 6
LINE (269, 50)-(279, 56), 6
LINE (279, 56)-(268, 54), 6
LINE (268, 54)-(270, 51), 6
PAINT (271, 53), 6, 6
PAINT (275, 55), 6, 6
LINE (271, 25)-(274, 15), 3
LINE (274, 15)-(265, 21), 3
LINE (265, 21)-(262, 17), 3
LINE (262, 17)-(274, 10), 3
LINE (274, 10)-(279, 11), 3
LINE (271, 25)-(282, 29), 3
LINE (282, 29)-(284, 18), 3
LINE (284, 18)-(288, 27), 3
LINE (288, 27)-(293, 25), 3
LINE (293, 25)-(286, 13), 3
LINE (286, 13)-(279, 11), 3
PAINT (279, 14), 3, 3
LINE (279, 11)-(283, 12), 14
LINE (279, 10)-(283, 11), 14
LINE (279, 8)-(281, 10), 14
LINE (281, 10)-(286, 10), 14
LINE (286, 10)-(286, 7), 14
LINE (281, 5)-(279, 8), 14
LINE (281, 5)-(286, 6), 14
PAINT (284, 8), 14, 14
LINE (281, 5)-(286, 6), 8
LINE (281, 6)-(286, 7), 8
PSET (281, 8), 16
PSET (284, 9), 16
PSET (282, 10), 16
LINE (273, 27)-(271, 29), 4
LINE (279, 29)-(280, 33), 4
LINE (275, 27)-(275, 33), 16
LINE (275, 33)-(279, 28), 16
LINE (272, 26)-(273, 31), 1
LINE (269, 38)-(269, 35), 1
LINE (273, 40)-(277, 36), 1
LINE (277, 41)-(281, 37), 1
LINE (273, 40)-(270, 34), 4
LINE (276, 40)-(279, 35), 4
CIRCLE (258, 32), 5, 4
CIRCLE (292, 40), 6, 4
LINE (293, 35)-(289, 31), 4
LINE (289, 31)-(282, 30), 4
LINE (282, 30)-(286, 33), 4
LINE (286, 33)-(286, 38), 4
PAINT (288, 34), 4, 4
PAINT (291, 38), 4, 4
LINE (260, 28)-(268, 27), 4
LINE (263, 33)-(268, 27), 4
PAINT (264, 29), 4, 4
PAINT (260, 31), 4, 4
COLOR 15: LOCATE 21, 1: PRINT "                                        "
          LOCATE 22, 1: PRINT "                                        "
          LOCATE 23, 1: PRINT "                                        "
          LOCATE 21, 1: PRINT "You go psycho!  Your only thought is to "
          LOCATE 22, 1: PRINT "go out and kill some people.  And not   "
          LOCATE 23, 1: PRINT "just any people, innocent ones..."
move$ = CHR$(0)
DO
        move$ = INKEY$
LOOP UNTIL move$ = " "
CLS
mainmenu
END SUB

SUB thegame
        CLS
        COLOR 15: LOCATE 6, 10: PRINT "Level One:"
                  LOCATE 7, 10: PRINT "HQ Massacre"
                  LOCATE 15, 4: PRINT "Your first psychotic thought is"
                  LOCATE 16, 4: PRINT "to begin your killing spree right"
                  LOCATE 17, 4: PRINT "in the police headquarters."
                  move$ = CHR$(0)
                  DO
                        move$ = INKEY$
                  LOOP UNTIL move$ = " "
                  CLS
LINE (115, 1)-(115, 12), 6
LINE (155, 12)-(155, 1), 6
LINE (162, 23)-(107, 13), 4, B
PAINT (142, 18), 12, 4
LINE (112, 20)-(112, 16), 15
LINE (112, 16)-(114, 16), 15
LINE (114, 16)-(114, 18), 15
LINE (114, 18)-(113, 18), 15
LINE (118, 20)-(116, 16), 15, B
LINE (120, 20)-(120, 16), 15, B
LINE (122, 20)-(120, 20), 15, B
LINE (124, 16)-(124, 20), 15, B
LINE (126, 16)-(127, 16), 15, B
LINE (126, 20)-(126, 16), 15, B
PSET (127, 20), 15
LINE (129, 20)-(129, 16), 15
LINE (129, 16)-(130, 16), 15
LINE (130, 18)-(130, 18), 15
LINE (130, 20)-(130, 20), 15
LINE (141, 16)-(141, 20), 15
LINE (141, 18)-(144, 18), 15
LINE (144, 16)-(144, 20), 15
LINE (149, 19)-(146, 16), 15, B
LINE (148, 18)-(150, 20), 15
LINE (1, 129)-(319, 129), 7
LINE (1, 143)-(1, 129), 7
LINE (1, 143)-(319, 143), 7
LINE (319, 143)-(319, 129), 7
PAINT (304, 134), 7, 7
LINE (141, 103)-(121, 128), 15, B
PAINT (131, 108), 15, 15
LINE (137, 118)-(125, 118), 16, B
LINE (125, 121)-(137, 118), 16, B
LINE (135, 112)-(127, 118), 16, B
LINE (132, 114)-(130, 112), 16, B
LINE (138, 85)-(124, 102), 1, B
PAINT (132, 91), 9, 1
LINE (124, 89)-(138, 89), 1
LINE (138, 96)-(124, 96), 1
LINE (126, 107)-(124, 105), 22, B
LINE (126, 109)-(124, 107), 22, B
LINE (128, 109)-(128, 105), 22
LINE (130, 107)-(128, 105), 22, B
LINE (128, 107)-(130, 109), 22
LINE (132, 109)-(132, 105), 22
LINE (134, 105)-(136, 105), 22
LINE (135, 105)-(135, 109), 22
LINE (138, 109)-(138, 105), 22
LINE (138, 105)-(140, 105), 22
LINE (140, 105)-(140, 109), 22
LINE (140, 106)-(138, 106), 22
LINE (138, 108)-(139, 108), 22
CIRCLE (134, 92), 2, 15
CIRCLE (128, 99), 2, 15
CIRCLE (128, 93), 1, 15
CIRCLE (135, 99), 1, 15
CIRCLE (130, 87), 1, 15
LINE (319, 103)-(211, 128), 6, B
LINE (319, 103)-(204, 103), 6, B
LINE (204, 93)-(319, 103), 6, B
PAINT (209, 98), 42, 6
PAINT (219, 107), 42, 6
FOR i = 1 TO 319 STEP 3
        PSET (i, 130), 16
NEXT i
position = 2
l = 20
u = 60
DO
        copmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
LINE (319, 143)-(1, 129), 7, B
PAINT (304, 134), 7, 7
LINE (76, 103)-(1, 128), 6, B
LINE (86, 93)-(1, 103), 6, B
PAINT (76, 98), 42, 6
PAINT (66, 106), 42, 6
LINE (86, 92)-(87, 92), 6
LINE (87, 92)-(87, 110), 6
LINE (87, 120)-(86, 110), 15, B
FOR i = 1 TO 319 STEP 3
        PSET (i, 130), 16
NEXT i
l = 0
il = 200
iu = 88
iposition = 0
DO
        copmoving
        innocentmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
LINE (319, 143)-(1, 129), 7, B
PAINT (314, 138), 7, 7
LINE (319, 58)-(239, 43), 7, B
PAINT (294, 48), 7, 7
LINE (312, 56)-(247, 46), 15, B
PAINT (282, 51), 8, 15
LINE (254, 49)-(251, 49), 15
LINE (251, 49)-(251, 53), 15
LINE (251, 53)-(254, 53), 15
LINE (256, 53)-(256, 49), 15
LINE (256, 51)-(258, 51), 15
LINE (258, 51)-(258, 49), 15
LINE (258, 51)-(258, 53), 15
LINE (260, 53)-(261, 49), 15
LINE (261, 49)-(264, 53), 15
LINE (262, 52)-(263, 52), 15
LINE (266, 53)-(266, 49), 15
LINE (266, 49)-(269, 53), 15
LINE (269, 53)-(269, 49), 15
LINE (273, 51)-(274, 51), 15
LINE (274, 51)-(274, 53), 15
LINE (274, 53)-(271, 53), 15
LINE (271, 53)-(271, 49), 15
LINE (271, 49)-(274, 49), 15
LINE (276, 49)-(276, 53), 15
LINE (276, 53)-(279, 53), 15
LINE (277, 51)-(277, 51), 15
LINE (277, 49)-(279, 49), 15
LINE (281, 52)-(281, 49), 15
LINE (281, 53)-(281, 53), 15
LINE (281, 49)-(284, 49), 15
LINE (284, 49)-(284, 51), 15
LINE (284, 51)-(282, 51), 15
LINE (282, 52)-(284, 53), 15
LINE (288, 53)-(286, 49), 15, B
LINE (292, 49)-(290, 53), 15, B
LINE (294, 53)-(294, 49), 15
LINE (296, 51)-(294, 49), 15
LINE (296, 51)-(298, 49), 15
LINE (298, 49)-(298, 53), 15
LINE (303, 49)-(300, 49), 15
LINE (300, 49)-(300, 51), 15
LINE (300, 51)-(303, 51), 15
LINE (303, 51)-(303, 53), 15
LINE (303, 53)-(300, 53), 15
LINE (255, 42)-(259, 39), 15
LINE (256, 42)-(271, 42), 15
LINE (271, 42)-(268, 39), 15
LINE (268, 39)-(268, 39), 15
CIRCLE (263, 31), 10, 15
PAINT (263, 41), 15, 15
PAINT (263, 37), 15, 15
CIRCLE (263, 31), 8, 16
PSET (263, 26), 16
PSET (266, 27), 16
PSET (268, 29), 16
PSET (269, 31), 16
PSET (268, 33), 16
PSET (266, 35), 16
PSET (263, 36), 16
PSET (260, 35), 16
PSET (258, 34), 16
PSET (257, 31), 16
PSET (258, 29), 16
PSET (260, 27), 16
LINE (263, 31)-(263, 28), 16
LINE (263, 31)-(268, 35), 16
LINE (305, 51)-(310, 51), 15
LINE (310, 51)-(308, 49), 15
LINE (308, 49)-(308, 53), 15
LINE (308, 53)-(310, 51), 15
FOR i = 1 TO 319 STEP 3
        PSET (i, 130), 16
NEXT i
l = 0
DO
        copmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
LINE (319, 143)-(1, 129), 7, B
PAINT (314, 138), 7, 7
LINE (104, 113)-(54, 123), 6, B
LINE (64, 128)-(59, 123), 6, B
LINE (94, 128)-(99, 123), 6, B
PAINT (99, 118), 6, 6
PAINT (98, 125), 6, 6
PAINT (63, 125), 6, 6
LINE (64, 113)-(64, 117), 3
LINE (64, 117)-(60, 120), 3
LINE (60, 120)-(62, 122), 3
LINE (62, 122)-(68, 118), 3
LINE (68, 118)-(67, 113), 3
LINE (67, 113)-(65, 113), 3
PAINT (66, 116), 3, 3
PAINT (64, 114), 4, 3
LINE (64, 114)-(67, 114), 4
LINE (64, 116)-(68, 116), 4
LINE (89, 113)-(95, 119), 16
LINE (95, 119)-(99, 116), 16
LINE (99, 116)-(99, 113), 16
LINE (97, 117)-(93, 113), 16
LINE (93, 113)-(89, 113), 16
LINE (93, 113)-(98, 113), 16
PAINT (97, 115), 15, 16
PAINT (94, 116), 15, 16
LINE (90, 113)-(92, 113), 15
LINE (94, 113)-(98, 113), 15
FOR x = 0 TO 60 STEP 15
        LINE (215 + x, 88)-(200 + x, 128), 8, B
        PAINT (205 + x, 98), 7, 8
        LINE (204 + x, 93)-(211 + x, 93), 8
        LINE (211 + x, 95)-(204 + x, 95), 8
        LINE (204 + x, 97)-(211 + x, 97), 8
        LINE (207 + x, 110)-(202 + x, 106), 8, B
        LINE (204 + x, 107)-(204 + x, 110), 8, B
NEXT x
FOR i = 1 TO 319 STEP 3
        PSET (i, 130), 16
NEXT i
el = 150
eu = 88
eposition = 1
l = 0
DO
        copmoving
        ecopmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
PUT (169, 88), innocent
LINE (319, 143)-(1, 129), 7, B
PAINT (314, 138), 7, 7
LINE (164, 88)-(159, 128), 8, B
LINE (169, 88)-(159, 88), 8, B
LINE (204, 83)-(159, 88), 8, B
LINE (209, 128)-(204, 83), 8, B
LINE (174, 128)-(169, 88), 8, B
LINE (184, 88)-(179, 128), 8, B
LINE (194, 128)-(189, 88), 8, B
LINE (199, 128)-(199, 88), 8
LINE (204, 128)-(164, 128), 8
LINE (160, 88)-(163, 88), 0
LINE (204, 87)-(204, 84), 0
PAINT (202, 85), 7, 8
LINE (259, 83)-(209, 83), 8, B
LINE (259, 128)-(209, 83), 8, B
LINE (254, 88)-(214, 128), 8, B
LINE (224, 128)-(219, 88), 8, B
LINE (234, 88)-(229, 128), 8, B
LINE (244, 128)-(239, 88), 8, B
LINE (249, 128)-(249, 88), 8
PAINT (249, 87), 7, 8
LINE (239, 72)-(179, 82), 12, B
PAINT (234, 77), 4, 12
LINE (182, 75)-(182, 79), 14
LINE (182, 77)-(184, 77), 14
LINE (184, 75)-(184, 79), 14
LINE (188, 75)-(186, 79), 14, B
LINE (190, 75)-(190, 79), 14
LINE (190, 79)-(192, 79), 14
LINE (194, 79)-(194, 75), 14
LINE (194, 75)-(196, 77), 14
LINE (196, 77)-(194, 79), 14
LINE (198, 79)-(198, 75), 14
LINE (200, 79)-(200, 75), 14
LINE (200, 75)-(203, 79), 14
LINE (203, 79)-(203, 75), 14
LINE (207, 77)-(208, 77), 14
LINE (208, 77)-(208, 79), 14
LINE (208, 79)-(205, 79), 14
LINE (205, 79)-(205, 75), 14
LINE (205, 75)-(208, 75), 14
LINE (212, 75)-(212, 79), 14
LINE (212, 79)-(214, 79), 14
LINE (213, 75)-(214, 75), 14
LINE (216, 75)-(216, 79), 14
LINE (216, 79)-(218, 79), 14
LINE (217, 77)-(217, 77), 14
LINE (217, 75)-(218, 75), 14
LINE (220, 75)-(220, 79), 14
LINE (220, 79)-(222, 79), 14
LINE (224, 79)-(224, 75), 14
LINE (224, 79)-(226, 79), 14
LINE (228, 79)-(231, 79), 14
LINE (231, 79)-(231, 77), 14
LINE (231, 77)-(228, 77), 14
LINE (228, 77)-(228, 75), 14
LINE (228, 75)-(232, 75), 14
LINE (299, 38)-(319, 35), 8, B
LINE (318, 36)-(300, 37), 7, B
LINE (286, 35)-(290, 39), 8
LINE (290, 39)-(288, 41), 8
LINE (288, 41)-(284, 37), 8
LINE (284, 37)-(286, 35), 8
LINE (287, 36)-(294, 29), 8
LINE (289, 38)-(296, 31), 8
LINE (296, 31)-(294, 29), 8
LINE (294, 29)-(294, 26), 8
LINE (296, 31)-(299, 34), 8
LINE (294, 26)-(307, 26), 8
LINE (307, 26)-(307, 29), 8
LINE (307, 29)-(313, 35), 8
PAINT (306, 32), 7, 8
PAINT (292, 33), 7, 8
PAINT (286, 37), 7, 8
LINE (308, 28)-(313, 29), 8
LINE (313, 29)-(316, 31), 8
LINE (316, 31)-(319, 33), 8
LINE (298, 28)-(298, 31), 8
LINE (298, 31)-(299, 31), 8
LINE (299, 28)-(299, 28), 8
LINE (301, 32)-(301, 29), 8
LINE (301, 29)-(303, 29), 8
LINE (303, 29)-(303, 32), 8
LINE (303, 31)-(301, 31), 8
LINE (305, 33)-(305, 31), 8
LINE (305, 31)-(308, 31), 8
LINE (308, 31)-(308, 33), 8
LINE (307, 32)-(307, 32), 8
FOR i = 1 TO 319 STEP 3
        PSET (i, 130), 16
NEXT i
l = 0
DO
        copmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
LINE (319, 143)-(1, 129), 7, B
PAINT (314, 138), 7, 7
LINE (84, 1)-(84, 11), 6
LINE (119, 1)-(119, 11), 6
LINE (124, 21)-(79, 11), 1, B
PAINT (114, 16), 9, 1
LINE (82, 18)-(82, 14), 14
LINE (82, 16)-(84, 16), 14
LINE (84, 14)-(84, 18), 14
LINE (88, 14)-(86, 18), 14, B
LINE (90, 14)-(92, 18), 14
LINE (92, 18)-(94, 14), 14
LINE (96, 14)-(96, 18), 14
LINE (96, 18)-(97, 18), 14
LINE (97, 16)-(97, 16), 14
LINE (97, 14)-(97, 14), 14
LINE (99, 14)-(99, 18), 14
LINE (99, 16)-(101, 18), 14
LINE (100, 14)-(100, 15), 14
LINE (107, 14)-(106, 14), 14
LINE (106, 14)-(106, 18), 14
LINE (106, 18)-(107, 18), 14
LINE (109, 18)-(109, 14), 14
LINE (110, 14)-(111, 14), 14
LINE (111, 14)-(111, 18), 14
LINE (111, 16)-(110, 16), 14
LINE (113, 18)-(113, 14), 14
LINE (114, 14)-(114, 15), 14
LINE (114, 17)-(115, 18), 14
LINE (124, 10)-(124, 22), 0
LINE (121, 16)-(119, 14), 14, B
LINE (121, 18)-(119, 16), 14, B
LINE (131, 11)-(124, 21), 1, B
LINE (130, 12)-(124, 20), 9, B
PAINT (128, 14), 9, 9
LINE (123, 18)-(124, 14), 14
LINE (124, 14)-(125, 18), 14
LINE (127, 14)-(128, 15), 14
LINE (128, 15)-(129, 14), 14
LINE (128, 16)-(128, 18), 14
LINE (154, 38)-(214, 23), 8
LINE (214, 23)-(244, 38), 8
LINE (244, 38)-(244, 48), 8
LINE (244, 48)-(169, 48), 8
LINE (169, 48)-(154, 38), 8
LINE (174, 33)-(214, 33), 8
LINE (214, 33)-(214, 23), 8
LINE (184, 53)-(174, 48), 8, B
LINE (174, 51)-(184, 53), 0, B
LINE (184, 51)-(174, 51), 8, B
LINE (204, 51)-(194, 48), 8, B
LINE (224, 51)-(214, 48), 8, B
LINE (244, 51)-(234, 48), 8, B
PAINT (179, 50), 9, 8
PAINT (199, 50), 9, 8
PAINT (219, 50), 9, 8
PAINT (239, 50), 9, 8
PAINT (234, 45), 15, 8
PAINT (209, 30), 1, 8
LINE (189, 33)-(192, 28), 15
LINE (198, 33)-(201, 26), 15
LINE (206, 33)-(210, 24), 15
LINE (183, 33)-(185, 30), 15
LINE (227, 29)-(231, 31), 4
LINE (227, 29)-(231, 25), 4
LINE (231, 25)-(234, 27), 4
LINE (234, 27)-(230, 31), 4
PAINT (230, 29), 12, 4
LINE (233, 26)-(235, 27), 1
LINE (235, 27)-(232, 31), 1
LINE (184, 42)-(184, 38), 1
LINE (187, 40)-(184, 38), 1, B
LINE (193, 42)-(190, 38), 1, B
LINE (196, 42)-(196, 38), 1
LINE (196, 42)-(199, 42), 1
LINE (202, 42)-(202, 38), 1
LINE (205, 38)-(208, 38), 1
LINE (205, 38)-(205, 42), 1
LINE (205, 42)-(208, 42), 1
LINE (211, 42)-(211, 38), 1
LINE (211, 38)-(214, 38), 1
LINE (212, 40)-(214, 40), 1
LINE (211, 42)-(214, 42), 1
LINE (319, 46)-(283, 38), 8, B
PAINT (299, 41), 8, 8
LINE (314, 44)-(287, 40), 15, B
LINE (314, 45)-(287, 39), 15, B
PAINT (308, 42), 15, 15
LINE (289, 40)-(289, 44), 16
LINE (289, 44)-(292, 44), 16
LINE (290, 42)-(291, 42), 16
LINE (289, 40)-(292, 40), 16
LINE (294, 44)-(297, 40), 16
LINE (294, 40)-(297, 44), 16
LINE (300, 44)-(300, 40), 16
LINE (303, 40)-(306, 40), 16
LINE (305, 40)-(305, 44), 16
LINE (308, 42)-(313, 42), 16
LINE (313, 42)-(311, 40), 16
LINE (311, 40)-(311, 44), 16
LINE (311, 44)-(313, 42), 16
LINE (319, 47)-(282, 37), 8, B
FOR i = 1 TO 319 STEP 3
        PSET (i, 130), 16
NEXT i

l = 0
el = 60
eu = 88
eposition = 1
DO
        copmoving
        ecopmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
LINE (41, 139)-(1, 129), 7, B
LINE (61, 149)-(31, 139), 7, B
LINE (81, 159)-(51, 149), 7, B
LINE (101, 169)-(71, 159), 7, B
PAINT (31, 134), 7, 7
PAINT (39, 143), 7, 7
PAINT (62, 156), 7, 7
PAINT (82, 161), 7, 7
CIRCLE (207, 26), 20, 14
PAINT (212, 26), 14, 14
CIRCLE (212, 26), 20, 16
PAINT (217, 26), 16, 16
LINE (319, 169)-(102, 159), 2, B
PAINT (309, 164), 2, 2
LINE (101, 169)-(101, 159), 0
LINE (76, 1)-(1, 36), 8, B
PAINT (66, 6), 7, 8
LINE (71, 31)-(6, 6), 8, B
PAINT (16, 11), 15, 8
LINE (16, 10)-(16, 14), 8
LINE (18, 12)-(16, 10), 8, B
LINE (24, 14)-(21, 10), 8, B
LINE (27, 10)-(27, 14), 8, B
LINE (31, 14)-(27, 14), 8, B
LINE (34, 10)-(34, 14), 8, B
LINE (42, 10)-(38, 10), 8, B
LINE (38, 14)-(38, 10), 8, B
LINE (42, 14)-(38, 14), 8, B
LINE (45, 10)-(45, 14), 8, B
LINE (49, 10)-(45, 10), 8, B
LINE (48, 12)-(45, 12), 8, B
LINE (49, 14)-(45, 14), 8, B
LINE (10, 17)-(10, 24), 8, B
LINE (13, 20)-(10, 20), 8, B
LINE (13, 24)-(13, 17), 8, B
LINE (16, 17)-(16, 24), 8, B
LINE (19, 17)-(16, 17), 8, B
LINE (18, 20)-(16, 20), 8, B
LINE (19, 24)-(16, 24), 8, B
LINE (21, 17)-(21, 24), 8, B
LINE (23, 19)-(21, 17), 8, B
LINE (23, 24)-(23, 19), 8, B
LINE (25, 17)-(25, 24), 8, B
LINE (25, 17)-(28, 20), 8
LINE (28, 20)-(25, 24), 8
LINE (33, 23)-(30, 17), 8, B
LINE (32, 22)-(34, 24), 8
LINE (36, 17)-(36, 23), 8
LINE (36, 23)-(39, 23), 8
LINE (39, 23)-(39, 17), 8
LINE (41, 24)-(43, 17), 8
LINE (43, 17)-(44, 24), 8
LINE (44, 21)-(42, 21), 8
LINE (46, 24)-(46, 17), 8
LINE (49, 19)-(46, 17), 8, B
LINE (47, 20)-(49, 24), 8
LINE (51, 17)-(54, 17), 8
LINE (52, 17)-(52, 23), 8
LINE (57, 23)-(57, 17), 8
LINE (57, 17)-(60, 17), 8
LINE (57, 20)-(58, 20), 8
LINE (57, 23)-(60, 23), 8
LINE (62, 23)-(62, 17), 8
LINE (62, 17)-(65, 17), 8
LINE (65, 17)-(62, 20), 8
LINE (62, 20)-(64, 23), 8
LINE (69, 17)-(67, 17), 8
LINE (67, 17)-(67, 20), 8
LINE (67, 20)-(69, 20), 8
LINE (69, 21)-(69, 24), 8
LINE (69, 24)-(66, 24), 8
l = 0
il = 200
iu = 118
iposition = 0
DO
        copmoving
        innocentmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
COLOR 15: LOCATE 6, 10: PRINT "Level Two:"
          LOCATE 7, 10: PRINT "City Killin' Spree"
          LOCATE 15, 4: PRINT "Eventually, your killing spree"
          LOCATE 16, 4: PRINT "takes you to the city of "
          LOCATE 17, 4: PRINT "Washington D.C., where you continue"
          LOCATE 18, 4: PRINT "the onslaught."
          move$ = CHR$(0)
          DO
                move$ = INKEY$
          LOOP UNTIL move$ = " "
        CLS
LINE (121, 174)-(1, 115), 2, B
PAINT (96, 159), 2, 2
LINE (121, 115)-(106, 170), 8
LINE (106, 170)-(105, 174), 8
LINE (105, 174)-(205, 174), 8
LINE (205, 174)-(186, 115), 8
LINE (186, 115)-(121, 115), 8
PAINT (156, 130), 7, 8
LINE (187, 115)-(206, 174), 2
LINE (206, 174)-(319, 174), 2
LINE (319, 174)-(319, 115), 2
LINE (319, 115)-(187, 115), 2
PAINT (192, 119), 2, 2
LINE (153, 173)-(152, 116), 14, B
LINE (110, 82)-(95, 114), 16, B
PAINT (105, 89), 16, 16
LINE (102, 94)-(103, 114), 21, B
LINE (98, 93)-(107, 93), 15
LINE (107, 93)-(110, 90), 15
LINE (110, 90)-(110, 86), 15
LINE (110, 86)-(108, 83), 15
LINE (108, 83)-(98, 83), 15
LINE (98, 83)-(96, 85), 15
LINE (96, 85)-(96, 91), 15
LINE (96, 91)-(97, 93), 15
PAINT (102, 90), 4, 15
LINE (100, 86)-(99, 86), 15
LINE (99, 86)-(99, 88), 15
LINE (99, 88)-(100, 88), 15
LINE (100, 88)-(100, 90), 15
LINE (100, 90)-(99, 90), 15
LINE (102, 86)-(103, 86), 15
LINE (103, 86)-(103, 90), 15
LINE (106, 90)-(105, 86), 15, B
LINE (108, 90)-(108, 86), 15
LINE (109, 86)-(109, 87), 15
l = 0
u = 74
il = 140
iu = 74
iposition = 0
el = 250
eu = 74
eposition = 1
DO
        copmoving
        innocentmoving
        ecopmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
LINE (0, 115)-(320, 180), 2, BF
l = 0
el = 200
eu = 74
eposition = 1
DO
        copmoving
        ecopmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
LINE (319, 170)-(1, 115), 2, B
PAINT (314, 165), 2, 2
LINE (54, 115)-(54, 105), 8
LINE (54, 105)-(64, 105), 8
LINE (64, 105)-(64, 95), 8
LINE (64, 95)-(74, 95), 8
LINE (74, 95)-(74, 85), 8
LINE (74, 85)-(84, 85), 8
LINE (84, 85)-(84, 75), 8
LINE (84, 75)-(94, 75), 8
LINE (94, 75)-(94, 65), 8
LINE (94, 65)-(119, 65), 8
LINE (119, 65)-(119, 75), 8
LINE (119, 75)-(109, 75), 8
LINE (109, 75)-(69, 115), 8
LINE (69, 115)-(54, 115), 8
PAINT (59, 110), 7, 8
LINE (120, 65)-(120, 75), 4
LINE (120, 75)-(150, 105), 4
LINE (120, 65)-(155, 100), 4
LINE (155, 100)-(175, 105), 4
LINE (150, 105)-(170, 110), 4
LINE (170, 110)-(185, 110), 4
LINE (185, 110)-(185, 105), 4
LINE (185, 105)-(175, 105), 4
LINE (140, 95)-(130, 115), 4
PAINT (130, 80), 12, 4
LINE (107, 140)-(137, 130), 16
LINE (137, 130)-(147, 160), 16
LINE (107, 140)-(82, 150), 16
LINE (82, 150)-(92, 170), 16
LINE (92, 170)-(152, 170), 16
LINE (152, 170)-(147, 160), 16
LINE (137, 130)-(134, 138), 16
LINE (134, 138)-(146, 171), 16
LINE (134, 138)-(84, 155), 16
PAINT (86, 152), 6, 16
PAINT (141, 152), 6, 16
PAINT (126, 162), 6, 16
LINE (117, 156)-(119, 154), 16
LINE (119, 154)-(124, 152), 16
LINE (124, 152)-(129, 154), 16
LINE (129, 154)-(131, 157), 16
LINE (100, 162)-(102, 161), 16
LINE (102, 161)-(105, 162), 16
LINE (115, 167)-(119, 166), 16
LINE (119, 166)-(123, 167), 16
LINE (108, 157)-(110, 155), 16
LINE (110, 156)-(112, 157), 16
LINE (226, 69)-(221, 114), 8, B
LINE (266, 74)-(226, 69), 8, B
LINE (271, 114)-(266, 69), 8, B
PAINT (269, 99), 7, 8
PAINT (258, 73), 7, 8
PAINT (223, 78), 7, 8
l = 0
il = 232
iu = 74
iposition = 0
DO
        copmoving
        innocentmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
LINE (319, 174)-(1, 115), 2, B
PAINT (309, 164), 2, 2
LINE (76, 114)-(86, 120), 3
LINE (76, 114)-(76, 92), 3
LINE (76, 92)-(86, 99), 3
LINE (86, 99)-(86, 120), 3
LINE (86, 120)-(97, 115), 3
LINE (76, 92)-(87, 87), 3
LINE (87, 87)-(96, 95), 3
LINE (96, 95)-(86, 99), 3
LINE (96, 95)-(96, 115), 3
PAINT (92, 112), 11, 3
PAINT (83, 108), 11, 3
PAINT (86, 95), 3, 3
LINE (87, 87)-(96, 96), 6
LINE (96, 96)-(97, 114), 6
LINE (97, 114)-(247, 114), 6
LINE (247, 114)-(247, 54), 6
LINE (247, 54)-(87, 54), 6
LINE (87, 54)-(87, 89), 6
PAINT (102, 84), 6, 6
LINE (239, 76)-(94, 61), 15, B
PAINT (209, 71), 7, 15
LINE (101, 74)-(101, 64), 9
LINE (101, 64)-(108, 64), 9
LINE (106, 69)-(102, 69), 9
LINE (112, 64)-(112, 74), 9
LINE (112, 74)-(117, 74), 9
LINE (117, 74)-(117, 64), 9
LINE (122, 64)-(132, 64), 9
LINE (127, 64)-(127, 74), 9
LINE (137, 64)-(137, 74), 9
LINE (137, 74)-(142, 74), 9
LINE (142, 74)-(142, 64), 9
LINE (147, 64)-(147, 74), 9
LINE (147, 64)-(152, 69), 9
LINE (152, 69)-(147, 69), 9
LINE (147, 69)-(152, 74), 9
LINE (157, 74)-(157, 64), 9
LINE (157, 64)-(162, 64), 9
LINE (157, 69)-(162, 69), 9
LINE (157, 74)-(162, 74), 9
LINE (172, 74)-(172, 64), 9
LINE (172, 64)-(177, 69), 9
LINE (177, 69)-(172, 74), 9
LINE (182, 74)-(182, 64), 9
LINE (182, 64)-(187, 64), 9
LINE (187, 74)-(182, 74), 9
LINE (187, 74)-(187, 64), 9
LINE (192, 64)-(192, 74), 9
LINE (192, 64)-(197, 74), 9
LINE (197, 74)-(197, 64), 9
LINE (202, 64)-(202, 74), 9
LINE (202, 74)-(207, 74), 9
LINE (207, 74)-(207, 64), 9
LINE (212, 64)-(217, 64), 9
LINE (214, 64)-(214, 74), 9
LINE (227, 64)-(222, 64), 9
LINE (222, 64)-(222, 69), 9
LINE (222, 69)-(227, 69), 9
LINE (227, 69)-(227, 74), 9
LINE (227, 74)-(222, 74), 9
LINE (177, 89)-(157, 114), 8, B
LINE (167, 89)-(167, 114), 8, B
PAINT (162, 99), 9, 8
PAINT (172, 99), 9, 8
LINE (164, 100)-(164, 103), 8
LINE (170, 103)-(170, 100), 8
LINE (162, 113)-(165, 109), 15
LINE (166, 104)-(158, 109), 15
LINE (158, 102)-(166, 97), 15
LINE (166, 91)-(158, 94), 15
LINE (168, 95)-(175, 90), 15
LINE (168, 101)-(176, 96), 15
LINE (168, 108)-(175, 104), 15
LINE (172, 113)-(176, 110), 15
LINE (136, 103)-(111, 88), 16, B
LINE (141, 108)-(106, 103), 16, B
LINE (226, 103)-(196, 88), 16, B
LINE (231, 108)-(191, 103), 16, B
PAINT (131, 93), 9, 16
PAINT (201, 93), 9, 16
LINE (112, 99)-(120, 89), 15
LINE (120, 102)-(127, 89), 15
LINE (130, 102)-(135, 92), 15
LINE (200, 102)-(206, 89), 15
LINE (210, 102)-(215, 89), 15
LINE (220, 102)-(225, 92), 15
LINE (87, 89)-(87, 88), 3
l = 0
el = 30
eu = 74
eposition = 1
DO
        copmoving
        ecopmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
COLOR 15: LOCATE 6, 10: PRINT "Level 3:"
          LOCATE 7, 10: PRINT "Raid at the Whitehouse"
          LOCATE 15, 4: PRINT "As your destruction continues, you"
          LOCATE 16, 4: PRINT "find that the ultimate psychotic"
          LOCATE 17, 4: PRINT "thing to do is break into the"
          LOCATE 18, 4: PRINT "Whitehouse and kill the president,"
          LOCATE 19, 4: PRINT "Arnold Schwarzenegger."
          move$ = CHR$(0)
          DO
                move$ = INKEY$
          LOOP UNTIL move$ = " "
          CLS
LINE (176, 160)-(1, 115), 8, B
PAINT (165, 128), 7, 8
LINE (2, 138)-(175, 139), 14, B
LINE (192, 75)-(177, 160), 15, B
PAINT (182, 95), 15, 15
LINE (202, 65)-(167, 75), 15, B
PAINT (192, 70), 15, 15
LINE (177, 76)-(192, 76), 16
LINE (92, 99)-(91, 114), 6, B
LINE (127, 114)-(126, 99), 6, B
LINE (136, 73)-(81, 98), 4, B
PAINT (96, 88), 12, 4
LINE (85, 76)-(86, 80), 9
LINE (86, 80)-(88, 78), 9
LINE (88, 78)-(90, 80), 9
LINE (90, 80)-(90, 76), 9
LINE (92, 76)-(92, 79), 9
LINE (92, 80)-(93, 80), 9
LINE (93, 78)-(93, 78), 9
LINE (93, 76)-(93, 76), 9
LINE (95, 76)-(95, 80), 9
LINE (95, 80)-(96, 80), 9
LINE (98, 80)-(98, 76), 9
LINE (99, 76)-(99, 76), 9
LINE (99, 80)-(99, 80), 9
LINE (101, 80)-(101, 76), 9
LINE (101, 76)-(103, 76), 9
LINE (103, 77)-(103, 77), 9
LINE (103, 77)-(103, 80), 9
LINE (103, 80)-(102, 80), 9
LINE (105, 80)-(105, 76), 9
LINE (105, 76)-(107, 78), 9
LINE (107, 78)-(108, 76), 9
LINE (108, 76)-(108, 81), 9
LINE (110, 81)-(110, 76), 9
LINE (111, 76)-(111, 76), 9
LINE (111, 78)-(111, 78), 9
LINE (111, 80)-(111, 80), 9
LINE (116, 76)-(119, 76), 9
LINE (118, 76)-(118, 80), 9
LINE (120, 80)-(120, 76), 9
LINE (120, 76)-(122, 76), 9
LINE (122, 76)-(122, 80), 9
LINE (122, 80)-(120, 80), 9
LINE (102, 83)-(104, 83), 9
LINE (103, 83)-(103, 85), 9
LINE (105, 85)-(105, 83), 9
LINE (106, 84)-(106, 84), 9
LINE (107, 85)-(107, 83), 9
LINE (109, 83)-(109, 85), 9
LINE (110, 85)-(110, 84), 9
LINE (110, 83)-(110, 83), 9
LINE (83, 89)-(85, 93), 9
LINE (85, 93)-(87, 90), 9
LINE (87, 90)-(89, 93), 9
LINE (89, 93)-(91, 89), 9
LINE (93, 89)-(93, 93), 9
LINE (93, 91)-(95, 91), 9
LINE (95, 89)-(95, 93), 9
LINE (97, 93)-(97, 89), 9
LINE (99, 89)-(101, 89), 9
LINE (100, 89)-(100, 93), 9
LINE (103, 93)-(103, 89), 9
LINE (103, 89)-(105, 89), 9
LINE (105, 91)-(103, 91), 9
LINE (103, 93)-(105, 93), 9
LINE (107, 93)-(107, 89), 9
LINE (107, 91)-(109, 91), 9
LINE (109, 89)-(109, 93), 9
LINE (111, 93)-(111, 89), 9
LINE (111, 89)-(114, 89), 9
LINE (114, 89)-(114, 93), 9
LINE (114, 93)-(111, 93), 9
LINE (116, 89)-(116, 93), 9
LINE (116, 93)-(119, 93), 9
LINE (119, 93)-(119, 89), 9
LINE (123, 89)-(121, 89), 9
LINE (121, 89)-(121, 91), 9
LINE (121, 91)-(123, 91), 9
LINE (123, 91)-(123, 93), 9
LINE (123, 93)-(121, 93), 9
LINE (125, 93)-(125, 89), 9
LINE (126, 89)-(128, 89), 9
LINE (127, 91)-(125, 91), 9
LINE (125, 93)-(129, 93), 9
LINE (319, 158)-(193, 115), 2, B
LINE (193, 160)-(319, 159), 2, B
PAINT (198, 150), 2, 2
l = 0
u = 74
el = 260
eu = 74
eposition = 1
DO
        copmoving
        ecopmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
LINE (141, 174)-(1, 115), 2, B
PAINT (136, 164), 2, 2
LINE (142, 115)-(142, 174), 8
LINE (142, 174)-(318, 174), 8
LINE (318, 174)-(318, 80), 8
LINE (318, 80)-(213, 80), 8
LINE (213, 80)-(213, 90), 8
LINE (213, 90)-(188, 90), 8
LINE (188, 90)-(188, 100), 8
LINE (188, 100)-(163, 100), 8
LINE (163, 100)-(163, 110), 8
LINE (163, 110)-(163, 114), 8
LINE (163, 114)-(142, 115), 8
PAINT (212, 110), 15, 8
LINE (319, 21)-(141, 1), 8, B
PAINT (309, 11), 15, 8
LINE (145, 5)-(210, 5), 4
LINE (210, 6)-(255, 6), 4
LINE (255, 5)-(300, 5), 4
LINE (300, 6)-(315, 6), 4
LINE (315, 6)-(315, 16), 4
LINE (315, 16)-(300, 16), 4
LINE (300, 15)-(255, 15), 4
LINE (255, 16)-(210, 16), 4
LINE (210, 15)-(145, 15), 4
LINE (145, 15)-(145, 5), 4
PAINT (150, 10), 12, 4
LINE (148, 12)-(148, 7), 14
LINE (151, 9)-(148, 7), 14, B
LINE (154, 7)-(154, 12), 14
LINE (154, 12)-(156, 12), 14
LINE (155, 9)-(155, 9), 14
LINE (155, 7)-(156, 7), 14
LINE (158, 12)-(158, 7), 14
LINE (160, 9)-(158, 7), 14, B
LINE (160, 12)-(160, 9), 14, B
LINE (163, 12)-(163, 7), 14
LINE (163, 7)-(165, 7), 14
LINE (164, 12)-(165, 12), 14
LINE (167, 12)-(167, 7), 14
LINE (167, 7)-(169, 7), 14
LINE (168, 9)-(168, 9), 14
LINE (168, 12)-(169, 12), 14
LINE (174, 12)-(174, 7), 14
LINE (174, 7)-(176, 7), 14
LINE (175, 12)-(176, 12), 14
LINE (180, 7)-(178, 12), 14, B
LINE (182, 12)-(182, 7), 14
LINE (182, 7)-(185, 12), 14
LINE (185, 12)-(185, 7), 14
LINE (187, 7)-(187, 12), 14
LINE (187, 7)-(189, 7), 14
LINE (188, 9)-(188, 9), 14
LINE (191, 7)-(191, 12), 14
LINE (191, 12)-(193, 12), 14
LINE (192, 9)-(192, 9), 14
LINE (192, 7)-(193, 7), 14
LINE (195, 12)-(195, 7), 14
LINE (197, 9)-(195, 7), 14, B
LINE (196, 10)-(197, 12), 14
LINE (199, 12)-(199, 7), 14
LINE (199, 7)-(201, 7), 14
LINE (200, 9)-(200, 9), 14
LINE (200, 12)-(201, 12), 14
LINE (203, 12)-(203, 7), 14
LINE (206, 12)-(203, 7), 14
LINE (206, 11)-(206, 7), 14
LINE (208, 7)-(208, 12), 14
LINE (209, 8)-(211, 8), 14
LINE (209, 13)-(211, 13), 14
LINE (213, 13)-(213, 8), 14
LINE (213, 8)-(216, 8), 14
LINE (214, 10)-(214, 10), 14
LINE (214, 13)-(216, 13), 14
LINE (218, 10)-(220, 10), 14
LINE (223, 8)-(225, 13), 14
LINE (225, 13)-(228, 8), 14
LINE (230, 8)-(230, 13), 14
LINE (234, 8)-(232, 8), 14
LINE (232, 8)-(232, 10), 14
LINE (232, 10)-(234, 10), 14
LINE (234, 10)-(234, 13), 14
LINE (234, 13)-(232, 13), 14
LINE (236, 13)-(236, 8), 14
LINE (238, 8)-(240, 8), 14
LINE (239, 8)-(239, 13), 14
LINE (244, 8)-(242, 13), 14, B
LINE (246, 8)-(246, 13), 14
LINE (248, 10)-(246, 8), 14, B
LINE (247, 11)-(248, 13), 14
LINE (252, 8)-(250, 8), 14
LINE (250, 8)-(250, 10), 14
LINE (250, 10)-(252, 10), 14
LINE (252, 10)-(252, 14), 14
LINE (252, 14)-(250, 13), 14
LINE (258, 7)-(260, 12), 14
LINE (260, 12)-(263, 9), 14
LINE (263, 9)-(265, 12), 14
LINE (265, 12)-(267, 7), 14
LINE (269, 7)-(269, 12), 14
LINE (269, 12)-(272, 12), 14
LINE (270, 9)-(270, 9), 14
LINE (270, 7)-(272, 7), 14
LINE (274, 7)-(274, 11), 14
LINE (274, 12)-(276, 12), 14
LINE (278, 12)-(278, 7), 14
LINE (278, 7)-(281, 7), 14
LINE (279, 12)-(281, 12), 14
LINE (285, 7)-(283, 12), 14, B
LINE (287, 7)-(287, 12), 14
LINE (287, 7)-(289, 9), 14
LINE (289, 9)-(291, 7), 14
LINE (291, 7)-(291, 12), 14
LINE (293, 12)-(293, 7), 14
LINE (293, 7)-(297, 7), 14
LINE (295, 9)-(294, 9), 14
LINE (294, 12)-(297, 12), 14
LINE (299, 7)-(299, 10), 14
PSET (299, 12), 14
PSET (302, 13), 14
PSET (305, 13), 14
PSET (308, 13), 14
PSET (311, 13), 14
LINE (302, 11)-(302, 8), 14
LINE (305, 8)-(305, 11), 14
LINE (308, 11)-(308, 8), 14
LINE (311, 8)-(311, 11), 14
l = 0
il = 50
iu = 74
eposition = 1
el = 100
eu = 74
iposition = 0
DO
        copmoving
        innocentmoving
        ecopmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
LINE (319, 145)-(1, 115), 12, B
PAINT (304, 135), 4, 12
FOR i = 1 TO 500
        x = INT(RND * 320)
        y = INT(RND * 29) + 116
        PSET (x, y), 12
NEXT i
LINE (319, 174)-(1, 146), 15, B
PAINT (313, 170), 7, 15
LINE (251, 1)-(250, 16), 6, B
LINE (282, 16)-(281, 1), 6, B
LINE (294, 31)-(237, 16), 12, B
PAINT (289, 26), 4, 12
LINE (241, 20)-(239, 18), 14, B
LINE (239, 22)-(239, 20), 14, B
LINE (245, 20)-(243, 18), 14, B
LINE (243, 22)-(243, 20), 14, B
LINE (244, 21)-(245, 22), 14
LINE (247, 22)-(247, 18), 14
LINE (247, 18)-(248, 18), 14
LINE (248, 20)-(248, 20), 14
LINE (248, 22)-(248, 22), 14
LINE (251, 18)-(250, 18), 14
LINE (250, 18)-(250, 20), 14
LINE (250, 20)-(251, 20), 14
LINE (251, 20)-(251, 22), 14
LINE (251, 22)-(250, 22), 14
LINE (253, 22)-(253, 18), 14
LINE (255, 18)-(255, 22), 14
LINE (255, 22)-(257, 20), 14
LINE (257, 20)-(255, 18), 14
LINE (259, 18)-(259, 22), 14
LINE (259, 22)-(260, 22), 14
LINE (260, 20)-(260, 20), 14
LINE (260, 18)-(260, 18), 14
LINE (262, 22)-(262, 18), 14
LINE (262, 18)-(265, 22), 14
LINE (265, 22)-(265, 18), 14
LINE (267, 18)-(269, 18), 14
LINE (268, 18)-(268, 22), 14
LINE (272, 18)-(271, 18), 14
LINE (271, 18)-(271, 20), 14
LINE (271, 20)-(272, 20), 14
LINE (272, 20)-(272, 22), 14
LINE (272, 22)-(271, 22), 14
LINE (253, 29)-(250, 25), 14, B
LINE (255, 29)-(255, 25), 14
LINE (255, 25)-(258, 25), 14
LINE (256, 27)-(256, 27), 14
LINE (260, 25)-(260, 29), 14
LINE (260, 25)-(264, 25), 14
LINE (261, 27)-(261, 27), 14
LINE (266, 25)-(266, 29), 14
LINE (269, 29)-(269, 25), 14
LINE (269, 25)-(272, 25), 14
LINE (270, 29)-(272, 29), 14
LINE (275, 29)-(275, 25), 14
LINE (275, 25)-(278, 25), 14
LINE (276, 27)-(276, 27), 14
LINE (276, 29)-(278, 29), 14
LINE (287, 21)-(287, 27), 14
LINE (287, 27)-(290, 24), 14
LINE (290, 24)-(287, 21), 14
LINE (288, 25)-(288, 22), 14
LINE (289, 24)-(289, 24), 14
LINE (282, 24)-(286, 24), 14
l = 0
u = 74
el = 175
eu = 74
eposition = 1
DO
        copmoving
        ecopmoving
        SOUND 0, 1
LOOP UNTIL l > 280
CLS
ending
END SUB

SUB title
CLS
LINE (260, 140)-(60, 30), 1, B
LINE (265, 145)-(55, 25), 1, B
PAINT (262, 140), 9, 1
PAINT (247, 135), 15, 1
LINE (72, 35)-(92, 35), 1
LINE (72, 35)-(72, 45), 1
LINE (72, 45)-(87, 45), 1
LINE (87, 45)-(87, 50), 1
LINE (87, 50)-(72, 50), 1
LINE (72, 50)-(72, 55), 1
LINE (72, 55)-(92, 55), 1
LINE (92, 55)-(92, 40), 1
LINE (92, 40)-(77, 40), 1
LINE (92, 40)-(92, 35), 1
LINE (97, 35)-(97, 55), 1
LINE (97, 35)-(107, 35), 1
LINE (107, 35)-(107, 45), 1
LINE (107, 45)-(102, 45), 1
LINE (102, 45)-(102, 55), 1
LINE (102, 55)-(97, 55), 1
LINE (102, 38)-(102, 41), 1
LINE (112, 35)-(112, 55), 1
LINE (112, 35)-(122, 35), 1
LINE (122, 35)-(122, 55), 1
LINE (122, 55)-(112, 55), 1
LINE (117, 55)-(117, 45), 1
LINE (117, 42)-(117, 38), 1
LINE (127, 35)-(137, 35), 1
LINE (127, 35)-(127, 55), 1
LINE (127, 55)-(137, 55), 1
LINE (137, 55)-(137, 50), 1
LINE (137, 50)-(132, 50), 1
LINE (132, 50)-(132, 40), 1
LINE (132, 40)-(137, 40), 1
LINE (137, 35)-(137, 40), 1
LINE (142, 35)-(142, 55), 1
LINE (142, 55)-(152, 55), 1
LINE (152, 55)-(152, 50), 1
LINE (152, 50)-(147, 50), 1
LINE (147, 50)-(147, 45), 1
LINE (147, 45)-(152, 45), 1
LINE (152, 45)-(152, 40), 1
LINE (152, 40)-(147, 40), 1
LINE (147, 40)-(147, 40), 1
LINE (142, 35)-(152, 35), 1
LINE (152, 35)-(152, 40), 1
LINE (87, 125)-(72, 95), 12
LINE (72, 95)-(92, 85), 12
LINE (92, 85)-(102, 100), 12
LINE (102, 100)-(87, 110), 12
LINE (87, 110)-(92, 120), 12
LINE (92, 120)-(87, 125), 12
LINE (82, 95)-(92, 95), 12
LINE (92, 95)-(86, 103), 12
LINE (86, 103)-(82, 95), 12
LINE (108, 81)-(133, 76), 12
LINE (108, 81)-(115, 96), 12
LINE (115, 96)-(128, 92), 12
LINE (128, 92)-(133, 100), 12
LINE (133, 100)-(121, 105), 12
LINE (121, 105)-(126, 111), 12
LINE (126, 111)-(144, 99), 12
LINE (144, 99)-(133, 86), 12
LINE (133, 86)-(120, 84), 12
LINE (120, 84)-(133, 76), 12
LINE (146, 74)-(155, 87), 12
LINE (155, 87)-(152, 102), 12
LINE (152, 102)-(161, 99), 12
LINE (161, 99)-(165, 69), 12
LINE (165, 69)-(157, 78), 12
LINE (157, 78)-(153, 72), 12
LINE (153, 72)-(146, 74), 12
LINE (195, 75)-(173, 70), 12
LINE (173, 70)-(173, 96), 12
LINE (173, 96)-(193, 106), 12
LINE (193, 106)-(188, 96), 12
LINE (188, 96)-(178, 91), 12
LINE (178, 91)-(178, 81), 12
LINE (178, 81)-(195, 75), 12
LINE (205, 75)-(200, 105), 12
LINE (200, 105)-(210, 103), 12
LINE (210, 103)-(211, 93), 12
LINE (211, 93)-(217, 95), 12
LINE (217, 95)-(218, 102), 12
LINE (218, 102)-(222, 106), 12
LINE (222, 106)-(224, 76), 12
LINE (224, 76)-(214, 81), 12
LINE (214, 81)-(205, 75), 12
LINE (235, 80)-(250, 85), 12
LINE (250, 85)-(246, 107), 12
LINE (246, 107)-(231, 97), 12
LINE (231, 97)-(235, 80), 12
LINE (240, 87)-(243, 89), 12
LINE (243, 89)-(238, 96), 12
LINE (238, 96)-(239, 87), 12
LINE (213, 81)-(215, 87), 12
PAINT (144, 50), 9, 1
PAINT (135, 52), 9, 1
PAINT (120, 52), 9, 1
PAINT (100, 52), 9, 1
PAINT (90, 52), 9, 1
PAINT (85, 92), 4, 12
PAINT (115, 87), 4, 12
PAINT (160, 87), 4, 12
PAINT (175, 87), 4, 12
PAINT (205, 87), 4, 12
PAINT (235, 87), 4, 12
move$ = CHR$(0)
DO
        move$ = INKEY$
LOOP UNTIL move$ = " "
CLS
mainmenu
END SUB

