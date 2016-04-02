'begin note 1                                          
'No cool nicknames just By Alex(A|@*) Makris CRPY26C     
DECLARE SUB USA : DECLARE SUB SWITZERLAND
DECLARE SUB ROMANIA : DECLARE SUB COLOMBIA
DECLARE SUB BRAZIL : DECLARE SUB CAMEROON
DECLARE SUB SWEDEN : DECLARE SUB RUSSIA
DECLARE SUB GERMANY : DECLARE SUB SPAIN
DECLARE SUB SOUTHKOREA : DECLARE SUB BOLIVIA
DECLARE SUB ARGENTINA : DECLARE SUB NIGERIA
DECLARE SUB BULGARIA : DECLARE SUB GREECE
DECLARE SUB IRELAND : DECLARE SUB NORWAY
DECLARE SUB ITALY : DECLARE SUB MEXICO
DECLARE SUB BELGIUM : DECLARE SUB NETHERLANDS
DECLARE SUB SAUDIARABIA : DECLARE SUB MOROCCO
DECLARE SUB FLASHER : DECLARE SUB INTRO
DECLARE SUB LOGO : DECLARE SUB LOGOCOVER
DECLARE SUB MENU : DECLARE SUB LOGOFLASH
DECLARE SUB LOGOLETTERCOVER : DECLARE SUB STRIKER
DECLARE SUB SOCCERFIELD : DECLARE SUB PLAYER
DECLARE SUB INSTRUCTIONS : DECLARE SUB CONTROLS
DECLARE SUB SELECTION : DECLARE SUB DEMO
DECLARE SUB MAINGAME : DECLARE SUB DRAWSTUFF
DECLARE SUB INTERPRET : DECLARE SUB GOAL
                                                            
USANAME1$ = "Ernie Stewart": USANAME2$ = "Cobi Jones"
USAGOALIE$ = "Tony Meola"
SWITZERLANDNAME1$ = "Georges Bregy"
SWITZERLANDNAME2$ = "Adrian Knup"
SWITZERLANDGOALIE$ = "Marco Pasolo"
ROMANIANAME1$ = "Ion Vladoiu"
ROMANIANAME2$ = "Gheorghe Hagi"
ROMANIAGOALIE$ = "Bogdan Stelea"
COLOMBIANAME1$ = "Adolfo Valencia"
COLOMBIANAME2$ = "Faustino Asprilla"
COLOMBIAGOALIE$ = "Rene Higuita"
BRAZILNAME1$ = "Rai": BRAZILNAME2$ = "Romario"
BRAZILGOALIE$ = "Taffarel"
CAMEROONNAME1$ = "Stephen Tataw"
CAMEROONNAME2$ = "Raymond Kalla"
CAMEROONGOALIE$ = "Joseph-Antoine Bell"
SWEDENNAME1$ = "Martin 'Black Pearl' Dahlin"
SWEDENNAME2$ = "Tomas Brolin"
SWEDENGOALIE$ = "Thomas Ravelli"
RUSSIANAME1$ = "Victor Onopko"


RUSSIANAME2$ = "Sergei Yuran"
RUSSIAGOALIE$ = "Dmitri Kharine"
GERMANYNAME1$ = "Jurgen Klinsmann"
GERMANYNAME2$ = "Lothar Matthaus"
GERMANYGOALIE$ = "Bodo Illgner"
SPAINNAME1$ = "Juan Andoni Goicoechea"
SPAINNAME2$ = "Julio Salinas"
SPAINGOALIE$ = "Adoni Zubizarreta"
SOUTHKOREANAME1$ = "Jung-Won Seo"
SOUTHKOREANAME2$ = "Myung-Bo Hong"
SOUTHKOREAGOALIE$ = "In-Young Choi"
BOLIVIANAME1$ = "Luis Critaldo"
'End of note  1,begin note 2                             

 
'End of note  1,begin note 2                             
BOLIVIANAME2$ = "Julio Cesar Baldivieso"
BOLIVIAGOALIE$ = "Carlos Trucco"
ARGENTINANAME1$ = "Diego Maradona"
ARGENTINANAME2$ = "Gabriel Batistuta"
ARGENTINAGOALIE$ = "Sergio Goycochea"
NIGERIANAME1$ = "Rashidi Yekini"
NIGERIANAME2$ = "Daniel Amokachi"
NIGERIAGOALIE$ = "Peter Rufai"
BULGARIANAME1$ = "Hristo Stoichkov"
BULGARIANAME2$ = "Yordan Lechkov"
BULGARIAGOALIE$ = "Antonis Minou"
GREECENAME1$ = "Anastassios Mitropoulos"
GREECENAME2$ = "Dimitris Saravakos"
GREECEGOALIE$ = "Borislav Mikhailov"
IRELANDNAME1$ = "Tommy Coyne"
IRELANDNAME2$ = "Paul McGrath"
IRELANDGOALIE$ = "Patrick Bonner"
NORWAYNAME1$ = "Henning Berg"
NORWAYNAME2$ = "Oyvind Leonhardsen"
NORWAYGOALIE$ = "Erik Thorstvedt"
ITALYNAME1$ = "Roberto Baggio"
ITALYNAME2$ = "Pierluigi Casiraghi"
ITALYGOALIE$ = "Luca Marchegiani"
MEXICONAME1$ = "Alberto Garcia Aspe"
MEXICONAME2$ = "Luis Garcia"
MEXICOGOALIE$ = "Jorge Campos"
BELGIUMNAME1$ = "Marc Degryse"
BELGIUMNAME2$ = "Luc Nillis"
BELGIUMGOALIE$ = "Michel Prued'Homme"
NETHERLANDSNAME1$ = "Wim Jonk"
NETHERLANDSNAME2$ = "Gaston Taument"
NETHERLANDSGOALIE$ = "Ed de Goey"
SAUDIARABIANAME1$ = "Fuad Anwar Amin"
SAUDIARABIANAME2$ = "Majed Mohammed"
SAUDIARABIAGOALIE$ = "Mohammed Al-Deayea"
MOROCCONAME1$ = "Mohammed Lashaf"
MOROCCONAME2$ = "Mustapha El Hadaoui"
MOROCCOGOALIE$ = "Khalil Azmi"
SCREEN 9: DIM MINI%(1 TO 500)
PAINT (320, 175), 2
GET (100, 100)-(130, 115), MINI%
CLS : GOSUB INTRO
1 GOSUB MENU


X = 450: Y = 100
GOSUB STRIKER: BALLX = 100: BALLY = 100
GOSUB SELECTION: GOSUB MAINGAME
GOTO 1
END
USA:                                                     
STEAL = 45: SPEED = 8: HANDS = 46
CLS : LOCATE 1, 38: PRINT "USA"
FOR T = 15 TO 175: LINE (0, T)-(640, T), 4: NEXT T
FOR T = 27 TO 40: LINE (200, T)-(640, T), 15: NEXT T
FOR T = 52 TO 65: LINE (200, T)-(640, T), 15: NEXT T
'End of note 2 ,begin note 3                             

 
'End of note 2 ,begin note 3                             
FOR T = 77 TO 90: LINE (200, T)-(640, T), 15: NEXT T
FOR T = 102 TO 115: LINE (0, T)-(640, T), 15: NEXT T
FOR T = 127 TO 140: LINE (0, T)-(640, T), 15: NEXT T
FOR T = 152 TO 165: LINE (0, T)-(640, T), 15: NEXT T
FOR T = 15 TO 101: LINE (0, T)-(200, T), 1: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; USANAME1$
LOCATE 17, 25: PRINT "Player 2: "; USANAME2$
LOCATE 19, 27: PRINT "Goalie: "; USAGOALIE$
NAME1$ = USANAME1$: NAME2$ = USANAME2$
GOALIE$ = USAGOALIE$
RETURN
GREECE:                                                  
STEAL = 15: SPEED = 2: HANDS = 22
CLS : LOCATE 1, 36: PRINT "Greece"
FOR T = 15 TO 175: LINE (0, T)-(640, T), 9: NEXT T
FOR T = 27 TO 40: LINE (200, T)-(640, T), 15: NEXT T
FOR T = 77 TO 90: LINE (200, T)-(640, T), 15: NEXT T
FOR T = 102 TO 115: LINE (0, T)-(640, T), 15: NEXT T
FOR T = 127 TO 140: LINE (0, T)-(640, T), 15: NEXT T
FOR T = 152 TO 165: LINE (0, T)-(640, T), 15: NEXT T
FOR T = 15 TO 101: LINE (0, T)-(200, T), 9: NEXT T
FOR T = 52 TO 65: LINE (0, T)-(640, T), 15: NEXT T
FOR T = 92 TO 108: LINE (T, 15)-(T, 102), 15: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; GREECENAME1$
LOCATE 17, 25: PRINT "Player 2: "; GREECENAME2$
LOCATE 19, 27: PRINT "Goalie: "; GREECEGOALIE$
NAME1$ = GREECENAME1$: NAME2$ = GREECENAME2$
GOALIE$ = GREECEGOALIE$
RETURN
COLOMBIA:                                                
STEAL = 75: SPEED = 13: HANDS = 49
CLS : LOCATE 1, 35: PRINT "Colombia"
FOR T = 15 TO 88: LINE (0, T)-(640, T), 14: NEXT T
FOR T = 89 TO 122: LINE (0, T)-(640, T), 1: NEXT T
FOR T = 123 TO 175: LINE (0, T)-(640, T), 4: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; COLOMBIANAME1$
LOCATE 17, 25: PRINT "Player 2: "; COLOMBIANAME2$
LOCATE 19, 27: PRINT "Goalie: "; COLOMBIAGOALIE$
NAME1$ = COLOMBIANAME1$: NAME2$ = COLOMBIANAME2$
GOALIE$ = COLOMBIAGOALIE$
RETURN
RUSSIA:                                                  
STEAL = 35: SPEED = 6: HANDS = 37


CLS : LOCATE 1, 35: PRINT "Russia"
FOR T = 15 TO 68: LINE (0, T)-(640, T), 15: NEXT T
FOR T = 69 TO 122: LINE (0, T)-(640, T), 1: NEXT T
FOR T = 123 TO 175: LINE (0, T)-(640, T), 4: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; RUSSIANAME1$
LOCATE 17, 25: PRINT "Player 2: "; RUSSIANAME2$
LOCATE 19, 27: PRINT "Goalie: "; RUSSIAGOALIE$
NAME1$ = RUSSIANAME1$: NAME2$ = RUSSIANAME2$
GOALIE$ = RUSSIAGOALIE$
RETURN
BOLIVIA:                                                 
'End of note 3 ,begin note 4                             

 
'End of note 3 ,begin note 4                             
STEAL = 49: SPEED = 10: HANDS = 41
CLS : LOCATE 1, 36: PRINT "Bolivia"
FOR T = 15 TO 68: LINE (0, T)-(640, T), 12: NEXT T
FOR T = 69 TO 122: LINE (0, T)-(640, T), 14: NEXT T
FOR T = 123 TO 175: LINE (0, T)-(640, T), 10: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; BOLIVIANAME1$
LOCATE 17, 25: PRINT "Player 2: "; BOLIVIANAME2$
LOCATE 19, 27: PRINT "Goalie: "; BOLIVIAGOALIE$
NAME1$ = BOLIVIANAME1$: NAME2$ = BOLIVIANAME2$
GOALIE$ = BOLIVIAGOALIE$
RETURN
GERMANY:                                                 
STEAL = 93: SPEED = 17: HANDS = 70
CLS : LOCATE 1, 35: PRINT "Germany": FOR T = 15 TO 68
LINE (0, T)-(640, T), 0: NEXT T
FOR T = 69 TO 122: LINE (0, T)-(640, T), 4: NEXT T
FOR T = 123 TO 175: LINE (0, T)-(640, T), 14: NEXT T
LINE (0, 15)-(640, 15), 15: LINE (0, 15)-(0, 68), 15
LINE (639, 15)-(639, 68), 15
LOCATE 15, 25: PRINT "Player 1: "; GERMANYNAME1$
LOCATE 17, 25: PRINT "Player 2: "; GERMANYNAME2$
LOCATE 19, 27: PRINT "Goalie: "; GERMANYGOALIE$
NAME1$ = GERMANYNAME1$: NAME2$ = GERMANYNAME2$
GOALIE$ = GERMANYGOALIE$
RETURN
SPAIN:                                                   
STEAL = 63: SPEED = 13: HANDS = 54
CLS : LOCATE 1, 35: PRINT "Spain"
FOR T = 15 TO 68: LINE (0, T)-(640, T), 4: NEXT T
FOR T = 69 TO 122: LINE (0, T)-(640, T), 14: NEXT T
FOR T = 123 TO 175: LINE (0, T)-(640, T), 4: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; SPAINNAME1$
LOCATE 17, 25: PRINT "Player 2: "; SPAINNAME2$
LOCATE 19, 27: PRINT "Goalie: "; SPAINGOALIE$
NAME1$ = SPAINNAME1$: NAME2$ = SPAINNAME2$
GOALIE$ = SPAINGOALIE$
RETURN
ARGENTINA:                                               
STEAL = 74: SPEED = 13: HANDS = 61
CLS : LOCATE 1, 36: PRINT "Argentina"
FOR T = 15 TO 68: LINE (0, T)-(640, T), 9: NEXT T
FOR T = 69 TO 122: LINE (0, T)-(640, T), 15: NEXT T
FOR T = 123 TO 175: LINE (0, T)-(640, T), 9: NEXT T


CIRCLE (320, 95), 20, 14: PAINT (320, 95), 14
LOCATE 15, 25: PRINT "Player 1: "; ARGENTINANAME1$
LOCATE 17, 25: PRINT "Player 2: "; ARGENTINANAME2$
LOCATE 19, 27: PRINT "Goalie: "; ARGENTINAGOALIE$
NAME1$ = ARGENTINANAME1$: NAME2$ = ARGENTINANAME2$
GOALIE$ = ARGENTINAGOALIE$
RETURN
BULGARIA:                                                
STEAL = 73: SPEED = 11: HANDS = 53
CLS : LOCATE 1, 35: PRINT "Bulgaria"
FOR T = 15 TO 68: LINE (0, T)-(640, T), 15: NEXT T
'End of note 4 ,begin note 5                             

 
'End of note 4 ,begin note 5                             
FOR T = 69 TO 122: LINE (0, T)-(640, T), 10: NEXT T
FOR T = 123 TO 175: LINE (0, T)-(640, T), 4: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; BULGARIANAME1$
LOCATE 17, 25: PRINT "Player 2: "; BULGARIANAME2$
LOCATE 19, 27: PRINT "Goalie: "; BULGARIAGOALIE$
NAME1$ = BULGARIANAME1$: NAME2$ = BULGARIANAME2$
GOALIE$ = BULGARIAGOALIE$
RETURN
NETHERLANDS:                                             
STEAL = 86: SPEED = 17: HANDS = 68
CLS : LOCATE 1, 33: PRINT "Netherlands"
FOR T = 15 TO 68: LINE (0, T)-(640, T), 4: NEXT T
FOR T = 69 TO 122: LINE (0, T)-(640, T), 15: NEXT T
FOR T = 123 TO 175: LINE (0, T)-(640, T), 1: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; NETHERLANDSNAME1$
LOCATE 17, 25: PRINT "Player 2: "; NETHERLANDSNAME2$
LOCATE 19, 27: PRINT "Goalie: "; NETHERLANDSGOALIE$
NAME1$ = NETHERLANDSNAME1$: NAME2$ = NETHERLANDSNAME2$
GOALIE$ = NETHERLANDSGOALIE$
RETURN
SAUDIARABIA:                                             
STEAL = 18: SPEED = 4: HANDS = 23
CLS : LOCATE 1, 32: PRINT "Saudi Arabia"
FOR T = 15 TO 175: LINE (0, T)-(640, T), 2: NEXT T
FOR H = 1 TO 50: LET R = INT(RND(1) * 400) + 120
LET S = INT(RND(1) * 30) + 65
LET R2 = INT(RND(1) * 400) + 120
LET S2 = INT(RND(1) * 30) + 95
LINE (R, S)-(R2, S2), 15: NEXT H
FOR T = 0 TO 7
LINE (140 + (8 * T), 135 + T)-(490, 135 + T): NEXT T
CIRCLE (490, 141), 8, 15: PAINT (492, 143), 15, 15
FOR T = 420 TO 425: LINE (T, 125)-(T, 152), 15: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; SAUDIARABIANAME1$
LOCATE 17, 25: PRINT "Player 2: "; SAUDIARABIANAME2$
LOCATE 19, 27: PRINT "Goalie: "; SAUDIARABIAGOALIE$
NAME1$ = SAUDIARABIANAME1$: NAME2$ = SAUDIARABIANAME2$
GOALIE$ = SAUDIARABIAGOALIE$
RETURN
ROMANIA:                                                 
STEAL = 32: SPEED = 8: HANDS = 42
CLS : LOCATE 1, 35: PRINT "Romania"
FOR T = 1 TO 213: LINE (T, 15)-(T, 175), 1: NEXT T


FOR T = 214 TO 427: LINE (T, 15)-(T, 175), 14: NEXT T
FOR T = 428 TO 640: LINE (T, 15)-(T, 175), 4: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; ROMANIANAME1$
LOCATE 17, 25: PRINT "Player 2: "; ROMANIANAME2$
LOCATE 19, 27: PRINT "Goalie: "; ROMANIAGOALIE$
NAME1$ = ROMANIANAME1$: NAME2$ = ROMANIANAME2$
GOALIE$ = ROMANIAGOALIE$
RETURN
CAMEROON:                                                
STEAL = 50: SPEED = 10: HANDS = 46
CLS : LOCATE 1, 36: PRINT "Cameroon"
'End of note  5,begin note 6                             

 
'End of note  5,begin note 6                             
FOR T = 1 TO 213: LINE (T, 15)-(T, 175), 10: NEXT T
FOR T = 214 TO 427: LINE (T, 15)-(T, 175), 12: NEXT T
FOR T = 428 TO 640: LINE (T, 15)-(T, 175), 14: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; CAMEROONNAME1$
LOCATE 17, 25: PRINT "Player 2: "; CAMEROONNAME2$
LOCATE 19, 27: PRINT "Goalie: "; CAMEROONGOALIE$
NAME1$ = CAMEROONNAME1$: NAME2$ = CAMEROONNAME2$
GOALIE$ = CAMEROONGOALIE$
RETURN
NIGERIA:                                                 
STEAL = 43: SPEED = 7: HANDS = 38
CLS : LOCATE 1, 36: PRINT "Nigeria"
FOR T = 1 TO 213: LINE (T, 15)-(T, 175), 2: NEXT T
FOR T = 214 TO 427: LINE (T, 15)-(T, 175), 15: NEXT T
FOR T = 428 TO 640: LINE (T, 15)-(T, 175), 2: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; NIGERIANAME1$
LOCATE 17, 25: PRINT "Player 2: "; NIGERIANAME2$
LOCATE 19, 27: PRINT "Goalie: "; NIGERIAGOALIE$
NAME1$ = NIGERIANAME1$: NAME2$ = NIGERIANAME2$
GOALIE$ = NIGERIAGOALIE$
RETURN
IRELAND:                                                 
STEAL = 69: SPEED = 15: HANDS = 58
CLS : LOCATE 1, 35: PRINT "Ireland"
FOR T = 1 TO 213: LINE (T, 15)-(T, 175), 2: NEXT T
FOR T = 214 TO 427: LINE (T, 15)-(T, 175), 15: NEXT T
FOR T = 428 TO 640: LINE (T, 15)-(T, 175), 12: NEXT T
FOR T = 428 TO 640 STEP 2: LINE (T, 15)-(T, 175), 14
NEXT T
LOCATE 15, 25: PRINT "Player 1: "; IRELANDNAME1$
LOCATE 17, 25: PRINT "Player 2: "; IRELANDNAME2$
LOCATE 19, 27: PRINT "Goalie: "; IRELANDGOALIE$
NAME1$ = IRELANDNAME1$: NAME2$ = IRELANDNAME2$
GOALIE$ = IRELANDGOALIE$
RETURN
ITALY:                                                   
STEAL = 92: SPEED = 20: HANDS = 70
CLS : LOCATE 1, 36: PRINT "Italy"
FOR T = 1 TO 213: LINE (T, 15)-(T, 175), 2: NEXT T
FOR T = 214 TO 427: LINE (T, 15)-(T, 175), 15: NEXT T
FOR T = 428 TO 640: LINE (T, 15)-(T, 175), 4: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; ITALYNAME1$
LOCATE 17, 25: PRINT "Player 2: "; ITALYNAME2$


LOCATE 19, 27: PRINT "Goalie: "; ITALYGOALIE$
NAME1$ = ITALYNAME1$: NAME2$ = ITALYNAME2$
GOALIE$ = ITALYGOALIE$
RETURN
MEXICO:                                                  
STEAL = 53: SPEED = 13: HANDS = 56
CLS : LOCATE 1, 36: PRINT "Mexico"
FOR T = 1 TO 213: LINE (T, 15)-(T, 175), 2: NEXT T
FOR T = 214 TO 427: LINE (T, 15)-(T, 175), 15: NEXT T
FOR T = 428 TO 640: LINE (T, 15)-(T, 175), 4: NEXT T
CIRCLE (320, 95), 20, 6: PAINT (320, 95), 6
'End of note 6 ,begin note 7                             

 
'End of note 6 ,begin note 7                             
LOCATE 15, 25: PRINT "Player 1: "; MEXICONAME1$
LOCATE 17, 25: PRINT "Player 2: "; MEXICONAME2$
LOCATE 19, 27: PRINT "Goalie: "; MEXICOGOALIE$
NAME1$ = MEXICONAME1$: NAME2$ = MEXICONAME2$
GOALIE$ = MEXICOGOALIE$
RETURN
BELGIUM:                                                 
STEAL = 57: SPEED = 14: HANDS = 55
CLS : LOCATE 1, 35: PRINT "Belgium"
FOR T = 1 TO 213: LINE (T, 15)-(T, 175), 0: NEXT T
FOR T = 214 TO 427: LINE (T, 15)-(T, 175), 14: NEXT T
FOR T = 428 TO 640: LINE (T, 15)-(T, 175), 4: NEXT T
LINE (0, 15)-(213, 15), 15: LINE (0, 15)-(0, 175), 15
LINE (0, 175)-(213, 175), 15
LOCATE 15, 25: PRINT "Player 1: "; BELGIUMNAME1$
LOCATE 17, 25: PRINT "Player 2: "; BELGIUMNAME2$
LOCATE 19, 27: PRINT "Goalie: "; BELGIUMGOALIE$
NAME1$ = BELGIUMNAME1$: NAME2$ = BELGIUMNAME2$
GOALIE$ = BELGIUMGOALIE$
RETURN
BRAZIL:                                                  
STEAL = 99: SPEED = 20: HANDS = 75
CLS : LOCATE 1, 37: PRINT "Brazil"
FOR T = 15 TO 175: LINE (0, T)-(640, T), 2: NEXT T
LINE (320, 35)-(600, 95), 14
LINE (600, 95)-(320, 155), 14
LINE (320, 155)-(40, 95), 14
LINE (40, 95)-(320, 35), 14: PAINT (320, 95), 14
CIRCLE (320, 95), 70, 9: PAINT (320, 95), 9
LOCATE 15, 25: PRINT "Player 1: "; BRAZILNAME1$
LOCATE 17, 25: PRINT "Player 2: "; BRAZILNAME2$
LOCATE 19, 27: PRINT "Goalie: "; BRAZILGOALIE$
NAME1$ = BRAZILNAME1$: NAME2$ = BRAZILNAME2$
GOALIE$ = BRAZILGOALIE$
RETURN
MOROCCO:                                                 
STEAL = 20: SPEED = 3: HANDS = 26
CLS : LOCATE 1, 34: PRINT "Morocco"
FOR T = 15 TO 175: LINE (0, T)-(640, T), 4: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; MOROCCONAME1$
LOCATE 17, 25: PRINT "Player 2: "; MOROCCONAME2$
LOCATE 19, 27: PRINT "Goalie: "; MOROCCOGOALIE$
NAME1$ = MOROCCONAME1$: NAME2$ = MOROCCONAME2$


GOALIE$ = MOROCCOGOALIE$
RETURN
SOUTHKOREA:                                              
STEAL = 18: SPEED = 4: HANDS = 27
CLS : LOCATE 1, 34: PRINT "South Korea"
FOR T = 15 TO 175: LINE (0, T)-(640, T), 15: NEXT T
CIRCLE (320, 95), 60, 0: CIRCLE (290, 95), 30, 4
CIRCLE (350, 95), 30, 1: PAINT (350, 95), 1
CIRCLE (290, 95), 30, 4: PAINT (290, 95), 4
CIRCLE (290, 95), 30, 0: CIRCLE (350, 95), 30, 0
PAINT (320, 65), 4, 0: PAINT (350, 125), 1, 0
'End of note 7 ,begin note 8                             

 
'End of note 7 ,begin note 8                             
CIRCLE (290, 95), 30, 4: CIRCLE (350, 95), 30, 1
LOCATE 15, 25: PRINT "Player 1: "; SOUTHKOREANAME1$
LOCATE 17, 25: PRINT "Player 2: "; SOUTHKOREANAME2$
LOCATE 19, 27: PRINT "Goalie: "; SOUTHKOREAGOALIE$
NAME1$ = SOUTHKOREANAME1$: NAME2$ = SOUTHKOREANAME2$
GOALIE$ = SOUTHKOREAGOALIE$
RETURN
SWEDEN:                                                  
STEAL = 68: SPEED = 13: HANDS = 59
CLS : LOCATE 1, 36: PRINT "Sweden"
FOR T = 15 TO 175: LINE (0, T)-(640, T), 9: NEXT T
FOR T = 90 TO 110: LINE (T, 15)-(T, 175), 14: NEXT T
FOR T = 85 TO 105: LINE (0, T)-(640, T), 14: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; SWEDENNAME1$
LOCATE 17, 25: PRINT "Player 2: "; SWEDENNAME2$
LOCATE 19, 27: PRINT "Goalie: "; SWEDENGOALIE$
NAME1$ = SWEDENNAME1$: NAME2$ = SWEDENNAME2$
GOALIE$ = SWEDENGOALIE$
RETURN
NORWAY:                                                  
STEAL = 74: SPEED = 11: HANDS = 53
CLS : LOCATE 1, 35: PRINT "Norway"
FOR T = 15 TO 175: LINE (0, T)-(640, T), 4: NEXT T
LINE (0, 84)-(640, 84), 15: LINE (0, 106)-(640, 106), 15
LINE (209, 15)-(209, 175), 15
LINE (231, 15)-(231, 175), 15
FOR T = 210 TO 230: LINE (T, 15)-(T, 175), 1: NEXT T
FOR T = 85 TO 105: LINE (0, T)-(640, T), 1: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; NORWAYNAME1$
LOCATE 17, 25: PRINT "Player 2: "; NORWAYNAME2$
LOCATE 19, 27: PRINT "Goalie: "; NORWAYGOALIE$
NAME1$ = NORWAYNAME1$: NAME2$ = NORWAYNAME2$
GOALIE$ = NORWAYGOALIE$
RETURN
SWITZERLAND:                                             
STEAL = 62: SPEED = 14: HANDS = 59
CLS : LOCATE 1, 34: PRINT "Switzerland"
FOR T = 190 TO 450: LINE (T, 15)-(T, 175), 4: NEXT T
FOR T = 300 TO 340: LINE (T, 35)-(T, 155), 15: NEXT T
FOR T = 80 TO 110: LINE (210, T)-(430, T), 15: NEXT T
LOCATE 15, 25: PRINT "Player 1: "; SWITZERLANDNAME1$
LOCATE 17, 25: PRINT "Player 2: "; SWITZERLANDNAME2$
LOCATE 19, 27: PRINT "Goalie: "; SWITZERLANDGOALIE$


NAME1$ = SWITZERLANDNAME1$: NAME2$ = SWITZERLANDNAME2$
GOALIE$ = SWITZERLANDGOALIE$
RETURN
FLASHER:                                                 
CLS : LET KO = INT(RND(1) * 15) + 1
PAINT (320, 175), KO
RETURN
INTRO:                                                   
INTROER = 1: CLS : SCREEN 9, , 0, 0: PCOPY 0, 1
BALLY = -220: FOR BALLX = -700 TO 800 STEP 50
SCREEN 9, , 0, 1: GOSUB SOCCERFIELD
'End of note 8 ,begin note 9                             

 
'End of note 8 ,begin note 9                             
LOCATE 12, 32: PRINT "By Alex Makris": SCREEN 9, , 0, 0
PCOPY 0, 1: NEXT BALLX
FOR BALLY = -220 TO -20 STEP 12.5: SCREEN 9, , 0, 1
GOSUB SOCCERFIELD: LOCATE 12, 32: PRINT "By Alex Makris"
SCREEN 9, , 0, 0: PCOPY 0, 1: NEXT BALLY
FOR BALLX = 800 TO -700 STEP -50: SCREEN 9, , 0, 1
GOSUB SOCCERFIELD: SCREEN 9, , 0, 0: PCOPY 0, 1
FOR T = 1 TO 200: NEXT T: NEXT BALLX
FOR BALLY = -20 TO 180 STEP 12.5: SCREEN 9, , 0, 1
GOSUB SOCCERFIELD: SCREEN 9, , 0, 0: PCOPY 0, 1
NEXT BALLY: FOR BALLX = -700 TO 800 STEP 50
SCREEN 9, , 0, 1: GOSUB SOCCERFIELD
LOCATE 12, 30: PRINT "World Cup Soccer 94"
SCREEN 9, , 0, 0: PCOPY 0, 1: NEXT BALLX
FOR BALLY = 180 TO 380 STEP 12.5: SCREEN 9, , 0, 1
GOSUB SOCCERFIELD
LOCATE 12, 30: PRINT "World Cup Soccer 94"
SCREEN 9, , 0, 0: PCOPY 0, 1: NEXT BALLY
FOR BALLX = 800 TO -900 STEP -50: SCREEN 9, , 0, 1
GOSUB SOCCERFIELD: SCREEN 9, , 0, 0: PCOPY 0, 1
NEXT BALLX: INTROER = 0
RETURN
LOGO:                                                    
LINE (X, Y)-(X + 40, Y), 0
LINE (X + 40, Y)-(X + 40, Y + 30), 0
LINE (X + 40, Y + 30)-(X + 20, Y + 30), 0
LINE (X + 20, Y + 30)-(X + 20, Y + 70), 0
LINE (X + 20, Y + 70)-(X + 40, Y + 70), 0
LINE (X + 40, Y + 70)-(X + 40, Y + 150), 0
LINE (X + 40, Y + 150)-(X, Y + 180), 0
LINE (X, Y + 180)-(X, Y + 140), 0
LINE (X, Y + 140)-(X + 20, Y + 130), 0
LINE (X + 20, Y + 130)-(X + 20, Y + 100), 0
LINE (X + 20, Y + 100)-(X, Y + 100), 0
LINE (X, Y + 100)-(X, Y), 0
LINE (X + 50, Y)-(X + 95, Y), 0
LINE (X + 95, Y)-(X + 95, Y + 110), 0
LINE (X + 95, Y + 110)-(X + 50, Y + 140), 0
LINE (X + 50, Y + 140)-(X + 50, Y), 0
LINE (X + 65, Y + 20)-(X + 80, Y + 20), 0
LINE (X + 80, Y + 20)-(X + 80, Y + 105), 0
LINE (X + 80, Y + 105)-(X + 65, Y + 114), 0
LINE (X + 65, Y + 114)-(X + 65, Y + 20), 0


LINE (X + 105, Y)-(X + 135, Y), 0
LINE (X + 135, Y)-(X + 135, Y + 20), 0
LINE (X + 135, Y + 20)-(X + 120, Y + 20), 0
LINE (X + 120, Y + 20)-(X + 120, Y + 85), 0
LINE (X + 120, Y + 85)-(X + 135, Y + 75), 0
LINE (X + 135, Y + 75)-(X + 135, Y + 92), 0
LINE (X + 135, Y + 92)-(X + 105, Y + 107), 0
LINE (X + 105, Y + 107)-(X + 105, Y), 0
LINE (X + 145, Y)-(X + 180, Y), 0
LINE (X + 180, Y)-(X + 180, Y + 20), 0
LINE (X + 180, Y + 20)-(X + 160, Y + 20), 0
'End of note  9,begin note 10                            

 
'End of note  9,begin note 10                            
LINE (X + 160, Y + 20)-(X + 160, Y + 75), 0
LINE (X + 160, Y + 75)-(X + 180, Y + 65), 0
LINE (X + 180, Y + 65)-(X + 180, Y + 80), 0
LINE (X + 180, Y + 80)-(X + 145, Y + 90), 0
LINE (X + 145, Y + 90)-(X + 145, Y), 0
LINE (X + 190, Y)-(X + 220, Y), 0
LINE (X + 220, Y)-(X + 220, Y + 20), 0
LINE (X + 220, Y + 20)-(X + 205, Y + 20), 0
LINE (X + 205, Y + 20)-(X + 205, Y + 30), 0
LINE (X + 205, Y + 30)-(X + 220, Y + 30), 0
LINE (X + 220, Y + 30)-(X + 220, Y + 40), 0
LINE (X + 220, Y + 40)-(X + 205, Y + 40), 0
LINE (X + 205, Y + 40)-(X + 205, Y + 65), 0
LINE (X + 205, Y + 65)-(X + 220, Y + 60), 0
LINE (X + 220, Y + 60)-(X + 220, Y + 70), 0
LINE (X + 220, Y + 70)-(X + 190, Y + 78), 0
LINE (X + 190, Y + 78)-(X + 190, Y), 0
LINE (X + 230, Y)-(X + 270, Y), 0
LINE (X + 270, Y)-(X + 270, Y + 40), 0
LINE (X + 270, Y + 40)-(X + 265, Y + 43), 0
LINE (X + 265, Y + 43)-(X + 270, Y + 65), 0
LINE (X + 270, Y + 65)-(X + 255, Y + 66), 0
LINE (X + 255, Y + 66)-(X + 250, Y + 40), 0
LINE (X + 250, Y + 40)-(X + 245, Y + 40), 0
LINE (X + 245, Y + 40)-(X + 244, Y + 66), 0
LINE (X + 244, Y + 66)-(X + 230, Y + 68), 0
LINE (X + 230, Y + 68)-(X + 230, Y), 0
LINE (X + 245, Y + 15)-(X + 255, Y + 15), 0
LINE (X + 255, Y + 15)-(X + 255, Y + 31), 0
LINE (X + 255, Y + 31)-(X + 245, Y + 32), 0
LINE (X + 245, Y + 32)-(X + 245, Y + 15), 0
RETURN
LOGOCOVER:                                               
LINE (X, Y)-(X + 40, Y), COVER
LINE (X + 40, Y)-(X + 40, Y + 30), COVER
LINE (X + 40, Y + 30)-(X + 20, Y + 30), COVER
LINE (X + 20, Y + 30)-(X + 20, Y + 70), COVER
LINE (X + 20, Y + 70)-(X + 40, Y + 70), COVER
LINE (X + 40, Y + 70)-(X + 40, Y + 150), COVER
LINE (X + 40, Y + 150)-(X, Y + 180), COVER
LINE (X, Y + 180)-(X, Y + 140), COVER
LINE (X, Y + 140)-(X + 20, Y + 130), COVER
LINE (X + 20, Y + 130)-(X + 20, Y + 100), COVER


LINE (X + 20, Y + 100)-(X, Y + 100), COVER
LINE (X, Y + 100)-(X, Y), COVER
LINE (X + 50, Y)-(X + 95, Y), COVER
LINE (X + 95, Y)-(X + 95, Y + 110), COVER
LINE (X + 95, Y + 110)-(X + 50, Y + 140), COVER
LINE (X + 50, Y + 140)-(X + 50, Y), COVER
LINE (X + 65, Y + 20)-(X + 80, Y + 20), COVER
LINE (X + 80, Y + 20)-(X + 80, Y + 105), COVER
LINE (X + 80, Y + 105)-(X + 65, Y + 114), COVER
LINE (X + 65, Y + 114)-(X + 65, Y + 20), COVER
LINE (X + 105, Y)-(X + 135, Y), COVER
'End of note 10 ,begin note 11                           

 
'End of note 10 ,begin note 11                           
LINE (X + 135, Y)-(X + 135, Y + 20), COVER
LINE (X + 135, Y + 20)-(X + 120, Y + 20), COVER
LINE (X + 120, Y + 20)-(X + 120, Y + 85), COVER
LINE (X + 120, Y + 85)-(X + 135, Y + 75), COVER
LINE (X + 135, Y + 75)-(X + 135, Y + 92), COVER
LINE (X + 135, Y + 92)-(X + 105, Y + 107), COVER
LINE (X + 105, Y + 107)-(X + 105, Y), COVER
LINE (X + 145, Y)-(X + 180, Y), COVER
LINE (X + 180, Y)-(X + 180, Y + 20), COVER
LINE (X + 180, Y + 20)-(X + 160, Y + 20), COVER
LINE (X + 160, Y + 20)-(X + 160, Y + 75), COVER
LINE (X + 160, Y + 75)-(X + 180, Y + 65), COVER
LINE (X + 180, Y + 65)-(X + 180, Y + 80), COVER
LINE (X + 180, Y + 80)-(X + 145, Y + 90), COVER
LINE (X + 145, Y + 90)-(X + 145, Y), COVER
LINE (X + 190, Y)-(X + 220, Y), COVER
LINE (X + 220, Y)-(X + 220, Y + 20), COVER
LINE (X + 220, Y + 20)-(X + 205, Y + 20), COVER
LINE (X + 205, Y + 20)-(X + 205, Y + 30), COVER
LINE (X + 205, Y + 30)-(X + 220, Y + 30), COVER
LINE (X + 220, Y + 30)-(X + 220, Y + 40), COVER
LINE (X + 220, Y + 40)-(X + 205, Y + 40), COVER
LINE (X + 205, Y + 40)-(X + 205, Y + 65), COVER
LINE (X + 205, Y + 65)-(X + 220, Y + 60), COVER
LINE (X + 220, Y + 60)-(X + 220, Y + 70), COVER
LINE (X + 220, Y + 70)-(X + 190, Y + 78), COVER
LINE (X + 190, Y + 78)-(X + 190, Y), COVER
LINE (X + 230, Y)-(X + 270, Y), COVER
LINE (X + 270, Y)-(X + 270, Y + 40), COVER
LINE (X + 270, Y + 40)-(X + 265, Y + 43), COVER
LINE (X + 265, Y + 43)-(X + 270, Y + 65), COVER
LINE (X + 270, Y + 65)-(X + 255, Y + 66), COVER
LINE (X + 255, Y + 66)-(X + 250, Y + 40), COVER
LINE (X + 250, Y + 40)-(X + 245, Y + 40), COVER
LINE (X + 245, Y + 40)-(X + 244, Y + 66), COVER
LINE (X + 244, Y + 66)-(X + 230, Y + 68), COVER
LINE (X + 230, Y + 68)-(X + 230, Y), COVER
LINE (X + 245, Y + 15)-(X + 255, Y + 15), COVER
LINE (X + 255, Y + 15)-(X + 255, Y + 31), COVER
LINE (X + 255, Y + 31)-(X + 245, Y + 32), COVER
LINE (X + 245, Y + 32)-(X + 245, Y + 15), COVER
RETURN
MENU:                                                    


10000 CLS : PAINT (320, 175), 2: Y = 42
FOR X = -250 TO 190 STEP 20: GOSUB LOGO
GOSUB LOGOFLASH: COVER = 2
SCREEN 9, , 0, 0: PCOPY 0, 1
IF X <> 190 THEN GOSUB LOGOCOVER: GOSUB LOGOLETTERCOVER
PLAY "O2 L64 G": NEXT X: PLAY "O0 L10 C"
FOR T = 1 TO 10000: NEXT T: PLAY "O4 L64 CBAGFED"
LOCATE 4, 22: PRINT "W": LOCATE 5, 22: PRINT "o"
LOCATE 6, 22: PRINT "r": LOCATE 7, 22: PRINT "l"
LOCATE 8, 22: PRINT "d": LOCATE 10, 22
PRINT "C": LOCATE 11, 22: PRINT "u": LOCATE 12, 22
'End of note 11,begin note 12                            

 
'End of note 11,begin note 12                            
PRINT "p": LOCATE 14, 22: PRINT "9": LOCATE 15, 22
PRINT "4": FOR T = 1 TO 10000: NEXT T
FOR T = 3000 TO 100 STEP -1000: SOUND T, 1: NEXT T
LOCATE 16, 35: PRINT "Main Menu"
LOCATE 18, 26: PRINT "1) Instructions            "
LOCATE 19, 26: PRINT "2) Print operation controls"
LOCATE 20, 26: PRINT "3) Start playing           "
LOCATE 21, 26: PRINT "4) Quit                    "
X = 450: Y = 100: GOSUB STRIKER
PRINT "Enter choice:"
A$ = " "
10001 A$ = INKEY$
IF A$ <> "1" AND A$ <> "2" AND A$ <> "3" AND A$ <> "4" THEN GOTO 10001
IF A$ = "1" THEN GOSUB INSTRUCTIONS: GOTO 10000
IF A$ = "2" THEN GOSUB CONTROLS: GOTO 10000
IF A$ = "4" THEN END
IF A$ <> "3" THEN GOTO 10000
RETURN
LOGOFLASH:                                               
LET H = INT(RND(1) * 14) + 1: IF X = 190 THEN H = 14
PAINT (X + 10, Y + 3), H, 0: PAINT (X + 60, Y + 3), H, 0
PAINT (X + 110, Y + 3), H, 0: PAINT (X + 155, Y + 3), H, 0
PAINT (X + 200, Y + 3), H, 0: PAINT (X + 240, Y + 3), H, 0
RETURN
LOGOLETTERCOVER:                                         
PAINT (X + 10, Y + 3), COVER, 0
PAINT (X + 60, Y + 3), COVER, 0
PAINT (X + 110, Y + 3), COVER, 0
PAINT (X + 155, Y + 3), COVER, 0
PAINT (X + 200, Y + 3), COVER, 0
PAINT (X + 240, Y + 3), COVER, 0
RETURN
STRIKER:                                                 
LINE (X + 27, Y + 41)-(X + 35, Y + 49), 0
LINE (X + 35, Y + 49)-(X + 29, Y + 48), 0
LINE (X + 29, Y + 48)-(X + 25, Y + 50), 0
LINE (X + 25, Y + 50)-(X + 27, Y + 41), 0
PAINT (X + 29, Y + 46), 0, 0
LINE (X, Y + 100)-(X + 5, Y + 95), 0
LINE (X + 5, Y + 95)-(X + 20, Y + 90), 0
LINE (X + 20, Y + 90)-(X + 30, Y + 100), 0
LINE (X + 30, Y + 100)-(X + 25, Y + 110), 0
LINE (X + 25, Y + 110)-(X + 20, Y + 115), 0


LINE (X + 20, Y + 115)-(X + 10, Y + 110), 0
LINE (X + 10, Y + 110)-(X, Y + 100), 0
PAINT (X + 15, Y + 100), 0, 0
LINE (X + 25, Y + 61)-(X + 31, Y + 54), 0
LINE (X + 31, Y + 54)-(X + 36, Y + 58), 0
LINE (X + 36, Y + 58)-(X + 37, Y + 64), 0
LINE (X + 37, Y + 64)-(X + 35, Y + 70), 0
LINE (X + 35, Y + 70)-(X + 28, Y + 69), 0
LINE (X + 28, Y + 69)-(X + 25, Y + 61), 0
PAINT (X + 32, Y + 62), 15, 0
LINE (X + 25, Y + 61)-(X + 32, Y + 60), 0
'End of note 12,begin note 13                            

 
'End of note 12,begin note 13                            
LINE (X + 32, Y + 60)-(X + 35, Y + 70), 0
PAINT (X + 30, Y + 63), 0, 0
LINE (X + 5, Y + 95)-(X + 20, Y + 65), 0
LINE (X + 20, Y + 65)-(X + 30, Y + 50), 0
LINE (X + 30, Y + 50)-(X + 38, Y + 45), 0
LINE (X + 38, Y + 45)-(X + 47, Y + 55), 0
LINE (X + 47, Y + 55)-(X + 52, Y + 70), 0
LINE (X + 52, Y + 70)-(X + 50, Y + 80), 0
LINE (X + 50, Y + 80)-(X + 45, Y + 90), 0
LINE (X + 45, Y + 90)-(X + 45, Y + 100), 0
LINE (X + 45, Y + 100)-(X + 40, Y + 112), 0
LINE (X + 40, Y + 112)-(X + 30, Y + 118), 0
LINE (X + 30, Y + 118)-(X + 20, Y + 115), 0
PAINT (X + 30, Y + 80), 6, 0
LINE (X + 45, Y + 90)-(X + 38, Y + 79), 0
LINE (X + 38, Y + 79)-(X + 43, Y + 80), 0
LINE (X + 38, Y + 79)-(X + 34, Y + 81), 0
LINE (X + 25, Y + 20)-(X + 32, Y + 6), 0
LINE (X + 32, Y + 6)-(X + 37, Y + 7), 0
LINE (X + 37, Y + 7)-(X + 32, Y + 20), 0
LINE (X + 32, Y + 20)-(X + 33, Y + 38), 0
LINE (X + 33, Y + 38)-(X + 26, Y + 31), 0
LINE (X + 26, Y + 31)-(X + 25, Y + 20), 0
PAINT (X + 29, Y + 20), 0, 0
LINE (X + 41, Y + 44)-(X + 55, Y + 29), 0
LINE (X + 55, Y + 29)-(X + 65, Y + 31), 0
LINE (X + 65, Y + 31)-(X + 74, Y + 44), 0
LINE (X + 74, Y + 44)-(X + 55, Y + 40), 0
LINE (X + 55, Y + 40)-(X + 41, Y + 44), 0
PAINT (X + 57, Y + 33), 0, 0
LINE (X + 50, Y + 80)-(X + 60, Y + 90), 0
LINE (X + 60, Y + 90)-(X + 59, Y + 95), 0
LINE (X + 59, Y + 95)-(X + 60, Y + 100), 0
LINE (X + 60, Y + 100)-(X + 45, Y + 90), 0
PAINT (X + 55, Y + 90), 6, 0
LINE (X + 60, Y + 90)-(X + 79, Y + 82), 0
LINE (X + 79, Y + 82)-(X + 81, Y + 89), 0
LINE (X + 81, Y + 89)-(X + 76, Y + 90), 0
LINE (X + 76, Y + 90)-(X + 72, Y + 90), 0
LINE (X + 72, Y + 90)-(X + 71, Y + 100), 0
LINE (X + 71, Y + 100)-(X + 75, Y + 105), 0
LINE (X + 75, Y + 105)-(X + 77, Y + 100), 0
LINE (X + 77, Y + 100)-(X + 80, Y + 106), 0


LINE (X + 80, Y + 106)-(X + 75, Y + 110), 0
LINE (X + 75, Y + 110)-(X + 65, Y + 105), 0
LINE (X + 65, Y + 105)-(X + 66, Y + 96), 0
LINE (X + 66, Y + 96)-(X + 64, Y + 97), 0
LINE (X + 64, Y + 97)-(X + 62, Y + 106), 0
LINE (X + 62, Y + 106)-(X + 60, Y + 107), 0
LINE (X + 60, Y + 107)-(X + 60, Y + 100), 0
PAINT (X + 67, Y + 97), 4, 0
LINE (X + 60, Y + 107)-(X + 61, Y + 120), 0
LINE (X + 61, Y + 120)-(X + 70, Y + 130), 0
LINE (X + 70, Y + 130)-(X + 75, Y + 129), 0
'End of note 13,begin note 14                            

 
'End of note 13,begin note 14                            
LINE (X + 75, Y + 129)-(X + 80, Y + 120), 0
LINE (X + 80, Y + 120)-(X + 83, Y + 113), 0
LINE (X + 83, Y + 113)-(X + 80, Y + 106), 0
PAINT (X + 70, Y + 115), 15, 0
LINE (X + 83, Y + 113)-(X + 87, Y + 119), 0
LINE (X + 87, Y + 119)-(X + 85, Y + 122), 0
LINE (X + 85, Y + 122)-(X + 90, Y + 125), 0
LINE (X + 90, Y + 125)-(X + 99, Y + 121), 0
LINE (X + 99, Y + 121)-(X + 101, Y + 141), 0
LINE (X + 101, Y + 141)-(X + 92, Y + 151), 0
LINE (X + 92, Y + 151)-(X + 71, Y + 148), 0
LINE (X + 71, Y + 148)-(X + 46, Y + 152), 0
LINE (X + 46, Y + 152)-(X + 50, Y + 139), 0
LINE (X + 50, Y + 139)-(X + 48, Y + 130), 0
LINE (X + 48, Y + 130)-(X + 40, Y + 121), 0
LINE (X + 40, Y + 121)-(X + 51, Y + 122), 0
LINE (X + 51, Y + 122)-(X + 61, Y + 120), 0
PAINT (X + 70, Y + 137), 1, 0
LINE (X + 48, Y + 130)-(X + 36, Y + 138), 0
LINE (X + 36, Y + 138)-(X + 37, Y + 126), 0
LINE (X + 37, Y + 126)-(X + 40, Y + 121), 0
PAINT (X + 42, Y + 130), 0, 0
LINE (X + 36, Y + 138)-(X + 30, Y + 141), 0
LINE (X + 30, Y + 141)-(X + 35, Y + 150), 0
LINE (X + 35, Y + 150)-(X + 47, Y + 147), 0
PAINT (X + 40, Y + 140), 6, 0
LINE (X + 35, Y + 150)-(X + 30, Y + 152), 0
LINE (X + 30, Y + 152)-(X + 25, Y + 144), 0
LINE (X + 25, Y + 144)-(X + 30, Y + 141), 0
PAINT (X + 31, Y + 146), 15, 0
LINE (X + 30, Y + 152)-(X + 25, Y + 154), 0
LINE (X + 25, Y + 154)-(X + 20, Y + 145), 0
LINE (X + 20, Y + 145)-(X + 25, Y + 144), 0
PAINT (X + 22, Y + 145), 4, 0
LINE (X + 25, Y + 154)-(X + 20, Y + 155), 0
LINE (X + 20, Y + 155)-(X + 15, Y + 147), 0
LINE (X + 15, Y + 147)-(X + 20, Y + 145), 0
PAINT (X + 16, Y + 147), 15, 0
LINE (X + 20, Y + 155)-(X + 16, Y + 162), 0
LINE (X + 16, Y + 162)-(X + 7, Y + 164), 0
LINE (X + 7, Y + 164)-(X + 4, Y + 150), 0
LINE (X + 4, Y + 150)-(X + 4, Y + 140), 0
LINE (X + 4, Y + 140)-(X + 14, Y + 126), 0


LINE (X + 14, Y + 126)-(X + 27, Y + 130), 0
LINE (X + 27, Y + 130)-(X + 27, Y + 135), 0
LINE (X + 27, Y + 135)-(X + 15, Y + 147), 0
PAINT (X + 10, Y + 150), 0, 0
LINE (X + 101, Y + 141)-(X + 108, Y + 160), 0
LINE (X + 108, Y + 160)-(X + 104, Y + 164), 0
LINE (X + 104, Y + 164)-(X + 90, Y + 160), 0
LINE (X + 90, Y + 160)-(X + 85, Y + 153), 0
LINE (X + 85, Y + 153)-(X + 92, Y + 154), 0
LINE (X + 92, Y + 154)-(X + 92, Y + 151), 0
PAINT (X + 100, Y + 155), 6, 0
'End of note  14,begin note 15                           

 
'End of note  14,begin note 15                           
LINE (X + 85, Y + 153)-(X + 79, Y + 154), 0
LINE (X + 79, Y + 154)-(X + 90, Y + 160), 0
PAINT (X + 85, Y + 155), 15, 0
LINE (X + 90, Y + 160)-(X + 95, Y + 169), 0
LINE (X + 95, Y + 169)-(X + 99, Y + 180), 0
LINE (X + 99, Y + 180)-(X + 96, Y + 190), 0
LINE (X + 96, Y + 190)-(X + 85, Y + 190), 0
LINE (X + 85, Y + 190)-(X + 79, Y + 179), 0
LINE (X + 79, Y + 179)-(X + 72, Y + 160), 0
LINE (X + 72, Y + 160)-(X + 76, Y + 151), 0
LINE (X + 76, Y + 151)-(X + 80, Y + 155), 0
PAINT (X + 85, Y + 170), 0, 0
LINE (X + 72, Y + 90)-(X + 90, Y + 88), 0
LINE (X + 90, Y + 88)-(X + 85, Y + 75), 0
LINE (X + 85, Y + 75)-(X + 90, Y + 71), 0
LINE (X + 90, Y + 71)-(X + 92, Y + 72), 0
LINE (X + 92, Y + 72)-(X + 96, Y + 65), 0
LINE (X + 96, Y + 65)-(X + 100, Y + 61), 0
LINE (X + 100, Y + 61)-(X + 106, Y + 69), 0
LINE (X + 106, Y + 69)-(X + 115, Y + 75), 0
LINE (X + 115, Y + 75)-(X + 113, Y + 83), 0
LINE (X + 113, Y + 83)-(X + 108, Y + 86), 0
LINE (X + 108, Y + 86)-(X + 106, Y + 93), 0
LINE (X + 106, Y + 93)-(X + 101, Y + 92), 0
LINE (X + 101, Y + 92)-(X + 99, Y + 96), 0
LINE (X + 99, Y + 96)-(X + 95, Y + 96), 0
LINE (X + 95, Y + 96)-(X + 92, Y + 92), 0
LINE (X + 92, Y + 92)-(X + 77, Y + 100), 0
PAINT (X + 100, Y + 80), 6, 0
LINE (X + 92, Y + 72)-(X + 97, Y + 78), 0
LINE (X + 97, Y + 78)-(X + 95, Y + 81), 0
LINE (X + 95, Y + 81)-(X + 90, Y + 79), 0
LINE (X + 105, Y + 70)-(X + 97, Y + 75), 0
LINE (X + 107, Y + 85)-(X + 101, Y + 84), 0
LINE (X + 101, Y + 84)-(X + 98, Y + 80), 0
LINE (X + 101, Y + 84)-(X + 97, Y + 86), 0
LINE (X + 97, Y + 86)-(X + 97, Y + 91), 0
LINE (X + 97, Y + 91)-(X + 100, Y + 92), 0
LINE (X + 68, Y + 87)-(X + 62, Y + 73), 0
LINE (X + 62, Y + 73)-(X + 67, Y + 71), 0
LINE (X + 67, Y + 71)-(X + 67, Y + 67), 0
LINE (X + 67, Y + 67)-(X + 61, Y + 60), 0
LINE (X + 61, Y + 60)-(X + 58, Y + 55), 0


LINE (X + 58, Y + 55)-(X + 55, Y + 58), 0
LINE (X + 55, Y + 58)-(X + 56, Y + 61), 0
LINE (X + 56, Y + 61)-(X + 52, Y + 62), 0
LINE (X + 52, Y + 62)-(X + 58, Y + 71), 0
LINE (X + 58, Y + 71)-(X + 57, Y + 86), 0
PAINT (X + 62, Y + 80), 6, 0
RETURN
SOCCERFIELD:                                             
CLS
IF INTROER = 0 THEN
 CIRCLE (320, 175), 5, 15: PAINT (320, 175), 15, 15
'End of note 15 ,begin note 16                           

 
'End of note 15 ,begin note 16                           
END IF
FOR U = -20 TO 580 STEP 200
LINE (-200 - BALLX, U - BALLY)-(1000 - BALLX, U - BALLY), 2
NEXT U
FOR U = -200 TO 1000 STEP 300
LINE (U - BALLX, -20 - BALLY)-(U - BALLX, 580 - BALLY), 2
NEXT U
LINE (-200 - BALLX, -20 - BALLY)-(-200 - BALLX, -40 - BALLY), 15
LINE (-200 - BALLX, -40 - BALLY)-(-185 - BALLX, -40 - BALLY), 4
LINE (-185 - BALLX, -40 - BALLY)-(-200 - BALLX, -60 - BALLY), 4
LINE (-200 - BALLX, -60 - BALLY)-(-200 - BALLX, -40 - BALLY), 4
PAINT (-195 - BALLX, -45 - BALLY), 4, 4
LINE (1000 - BALLX, -20 - BALLY)-(1000 - BALLX, -40 - BALLY), 15
LINE (1000 - BALLX, -40 - BALLY)-(1015 - BALLX, -40 - BALLY), 4
LINE (1015 - BALLX, -40 - BALLY)-(1000 - BALLX, -60 - BALLY), 4
LINE (1000 - BALLX, -60 - BALLY)-(1000 - BALLX, -40 - BALLY), 4
PAINT (1005 - BALLX, -45 - BALLY), 4, 4
LINE (-200 - BALLX, 580 - BALLY)-(-200 - BALLX, 560 - BALLY), 15
LINE (-200 - BALLX, 560 - BALLY)-(-185 - BALLX, 560 - BALLY), 4
LINE (-185 - BALLX, 560 - BALLY)-(-200 - BALLX, 540 - BALLY), 4
LINE (-200 - BALLX, 540 - BALLY)-(-200 - BALLX, 560 - BALLY), 4
PAINT (-195 - BALLX, 555 - BALLY), 4, 4
LINE (1000 - BALLX, 580 - BALLY)-(1000 - BALLX, 560 - BALLY), 15
LINE (1000 - BALLX, 560 - BALLY)-(1015 - BALLX, 560 - BALLY), 4
LINE (1015 - BALLX, 560 - BALLY)-(1000 - BALLX, 540 - BALLY), 4
LINE (1000 - BALLX, 540 - BALLY)-(1000 - BALLX, 560 - BALLY), 4
PAINT (1005 - BALLX, 555 - BALLY), 4, 4
LINE (398 - BALLX, -20 - BALLY)-(398 - BALLX, 580 - BALLY), 15
LINE (400 - BALLX, -20 - BALLY)-(400 - BALLX, 580 - BALLY), 15
LINE (402 - BALLX, -20 - BALLY)-(402 - BALLX, 580 - BALLY), 15
CIRCLE (400 - BALLX, 280 - BALLY), 100, 15
CIRCLE (400 - BALLX, 280 - BALLY), 103, 15
LINE (0 - BALLX, 80 - BALLY)-(0 - BALLX, 480 - BALLY), 15
LINE (-2 - BALLX, 80 - BALLY)-(-2 - BALLX, 480 - BALLY), 15
LINE (2 - BALLX, 80 - BALLY)-(2 - BALLX, 480 - BALLY), 15
LINE (800 - BALLX, 80 - BALLY)-(800 - BALLX, 480 - BALLY), 15
LINE (798 - BALLX, 80 - BALLY)-(798 - BALLX, 480 - BALLY), 15
LINE (802 - BALLX, 80 - BALLY)-(802 - BALLX, 480 - BALLY), 15
LINE (-200 - BALLX, 82 - BALLY)-(2 - BALLX, 82 - BALLY), 15
LINE (-200 - BALLX, 80 - BALLY)-(2 - BALLX, 80 - BALLY), 15
LINE (-200 - BALLX, 78 - BALLY)-(2 - BALLX, 78 - BALLY), 15
LINE (798 - BALLX, 82 - BALLY)-(1000 - BALLX, 82 - BALLY), 15
LINE (798 - BALLX, 80 - BALLY)-(1000 - BALLX, 80 - BALLY), 15


LINE (798 - BALLX, 78 - BALLY)-(1000 - BALLX, 78 - BALLY), 15
LINE (-200 - BALLX, 482 - BALLY)-(2 - BALLX, 482 - BALLY), 15
LINE (-200 - BALLX, 480 - BALLY)-(2 - BALLX, 480 - BALLY), 15
LINE (-200 - BALLX, 478 - BALLY)-(2 - BALLX, 478 - BALLY), 15
LINE (798 - BALLX, 482 - BALLY)-(1000 - BALLX, 482 - BALLY), 15
LINE (798 - BALLX, 480 - BALLY)-(1000 - BALLX, 480 - BALLY), 15
LINE (798 - BALLX, 478 - BALLY)-(1000 - BALLX, 478 - BALLY), 15
FOR U = 1000 TO 1075 STEP 25
LINE (U - BALLX, 180 - BALLY + ((U - 1000) / 3) - 25)-(U - BALLX, 380 - BALLY + ((U - 1000) / 3) - 25), 14
NEXT U: FOR U = 155 TO 355 STEP 50
LINE (1000 - BALLX, U - BALLY)-(1075 - BALLX, U - BALLY + 25), 14
'End of note 16 ,begin note 17                           

 
'End of note 16 ,begin note 17                           
NEXT U
LINE (1000 - BALLX, 180 - BALLY)-(1075 - BALLX, 180 - BALLY), 14
LINE (1000 - BALLX, 380 - BALLY)-(1075 - BALLX, 380 - BALLY), 14
LINE (1000 - BALLX, 355 - BALLY)-(1000 - BALLX, 380 - BALLY), 14
FOR U = -200 TO -275 STEP -25
LINE (U - BALLX, 180 - BALLY - ((U - -200) / 3) - 25)-(U - BALLX, 380 - BALLY - ((U - -200) / 3) - 25), 14
NEXT U: FOR U = 155 TO 355 STEP 50
LINE (-200 - BALLX, U - BALLY)-(-275 - BALLX, U - BALLY + 25), 14
NEXT U
LINE (-200 - BALLX, 180 - BALLY)-(-275 - BALLX, 180 - BALLY), 14
LINE (-200 - BALLX, 380 - BALLY)-(-275 - BALLX, 380 - BALLY), 14
LINE (-200 - BALLX, 355 - BALLY)-(-200 - BALLX, 380 - BALLY), 14
IF INTROER = 0 THEN PUT (305, 1), MINI%, PSET
CIRCLE (((FIELDER11X + 200) / 40) + 305, ((FIELDER11Y + 20) / 40) + 1), 2, SHIRT1
CIRCLE (((FIELDER12X + 200) / 40) + 305, ((FIELDER12Y + 20) / 40) + 1), 2, SHIRT1
CIRCLE (((FIELDER21X + 200) / 40) + 305, ((FIELDER21Y + 20) / 40) + 1), 2, SHIRT2
CIRCLE (((FIELDER22X + 200) / 40) + 305, ((FIELDER22Y + 20) / 40) + 1), 2, SHIRT2
CIRCLE (((-280 + 200) / 40) + 305, ((GOALY1 + 20) / 40) + 1), 2, SHIRT1
CIRCLE (((1000 + 200) / 40) + 305, ((GOALY2 + 20) / 40) + 1), 2, SHIRT2
RETURN
PLAYER:                                                  
LINE (X - 10 - BALLX, Y - 69 - BALLY)-(X + 15 - BALLX, Y - 67 - BALLY), 8
LINE (X + 15 - BALLX, Y - 67 - BALLY)-(X + 20 - BALLX, Y - 58 - BALLY), 8
LINE (X + 20 - BALLX, Y - 58 - BALLY)-(X + 25 - BALLX, Y - 55 - BALLY), 8
LINE (X + 25 - BALLX, Y - 55 - BALLY)-(X + 25 - BALLX, Y - 50 - BALLY), 8
LINE (X + 25 - BALLX, Y - 50 - BALLY)-(X + 20 - BALLX, Y - 51 - BALLY), 8
LINE (X + 20 - BALLX, Y - 51 - BALLY)-(X + 18 - BALLX, Y - 42 - BALLY), 8
LINE (X + 18 - BALLX, Y - 42 - BALLY)-(X + 11 - BALLX, Y - 39 - BALLY), 8
LINE (X + 11 - BALLX, Y - 39 - BALLY)-(X - BALLX, Y - 38 - BALLY), 8
LINE (X - BALLX, Y - 38 - BALLY)-(X - 9 - BALLX, Y - 41 - BALLY), 8
LINE (X - 9 - BALLX, Y - 41 - BALLY)-(X - 14 - BALLX, Y - 44 - BALLY), 8
LINE (X - 14 - BALLX, Y - 44 - BALLY)-(X - 18 - BALLX, Y - 50 - BALLY), 8
LINE (X - 18 - BALLX, Y - 50 - BALLY)-(X - 19 - BALLX, Y - 61 - BALLY), 8
LINE (X - 19 - BALLX, Y - 61 - BALLY)-(X - 14 - BALLX, Y - 65 - BALLY), 8
LINE (X - 14 - BALLX, Y - 65 - BALLY)-(X - 10 - BALLX, Y - 69 - BALLY), 8
LINE (X - 12 - BALLX, Y - 40 - BALLY)-(X - 10 - BALLX, Y - 39 - BALLY), 8
PAINT (X - BALLX, Y - 55 - BALLY), 12, 8
LINE (X + 13 - BALLX, Y - 50 - BALLY)-(X + 7 - BALLX, Y - 44 - BALLY), 8


LINE (X + 7 - BALLX, Y - 44 - BALLY)-(X - 4 - BALLX, Y - 44 - BALLY), 8
LINE (X - 4 - BALLX, Y - 44 - BALLY)-(X - 10 - BALLX, Y - 50 - BALLY), 8
LINE (X - BALLX, Y - 51 - BALLY)-(X - 10 - BALLX, Y - 52 - BALLY), 8
LINE (X - 10 - BALLX, Y - 52 - BALLY)-(X - 15 - BALLX, Y - 59 - BALLY), 8
LINE (X - 15 - BALLX, Y - 59 - BALLY)-(X - 9 - BALLX, Y - 57 - BALLY), 8
LINE (X - 9 - BALLX, Y - 57 - BALLY)-(X - BALLX, Y - 54 - BALLY), 8
LINE (X - BALLX, Y - 54 - BALLY)-(X + 3 - BALLX, Y - 63 - BALLY), 8
CIRCLE (X - 3 - BALLX, Y - 60 - BALLY), 3, 8
CIRCLE (X + 7 - BALLX, Y - 60 - BALLY), 3, 8
PAINT (X - 3 - BALLX, Y - 60 - BALLY), 1, 8
PAINT (X + 7 - BALLX, Y - 60 - BALLY), 1, 8
LINE (X + 15 - BALLX, Y - 67 - BALLY)-(X + 11 - BALLX, Y - 74 - BALLY), 8
LINE (X + 11 - BALLX, Y - 74 - BALLY)-(X + 2 - BALLX, Y - 81 - BALLY), 8
LINE (X + 2 - BALLX, Y - 81 - BALLY)-(X + 4 - BALLX, Y - 73 - BALLY), 8
LINE (X + 4 - BALLX, Y - 73 - BALLY)-(X - 6 - BALLX, Y - 80 - BALLY), 8
LINE (X - 6 - BALLX, Y - 80 - BALLY)-(X - 10 - BALLX, Y - 76 - BALLY), 8
'End of note 17 ,begin note 18                           

 
'End of note 17 ,begin note 18                           
LINE (X - 10 - BALLX, Y - 76 - BALLY)-(X - 2 - BALLX, Y - 71 - BALLY), 8
LINE (X - 2 - BALLX, Y - 71 - BALLY)-(X - 14 - BALLX, Y - 73 - BALLY), 8
LINE (X - 14 - BALLX, Y - 73 - BALLY)-(X - 15 - BALLX, Y - 70 - BALLY), 8
LINE (X - 15 - BALLX, Y - 70 - BALLY)-(X - 10 - BALLX, Y - 69 - BALLY), 8
PAINT (X - BALLX, Y - 70 - BALLY), 14, 8
LINE (X + 8 - BALLX, Y - 38 - BALLY)-(X + 10 - BALLX, Y - 20 - BALLY), 8
LINE (X + 10 - BALLX, Y - 20 - BALLY)-(X - 13 - BALLX, Y - 20 - BALLY), 8
LINE (X - 13 - BALLX, Y - 20 - BALLY)-(X - 9 - BALLX, Y - 39 - BALLY), 8
PAINT (X - BALLX, Y - 30 - BALLY), SHIRT, 8
LINE (X - 9 - BALLX, Y - 39 - BALLY)-(X - 15 - BALLX, Y - 36 - BALLY), 8
LINE (X - 15 - BALLX, Y - 36 - BALLY)-(X - 11 - BALLX, Y - 30 - BALLY), 8
PAINT (X - 12 - BALLX, Y - 35 - BALLY), SHIRT, 8
LINE (X + 11 - BALLX, Y - 39 - BALLY)-(X + 15 - BALLX, Y - 36 - BALLY), 8
LINE (X + 15 - BALLX, Y - 36 - BALLY)-(X + 10 - BALLX, Y - 32 - BALLY), 8
PAINT (X + 10 - BALLX, Y - 34 - BALLY), SHIRT, 8
LINE (X - 9 - BALLX, Y - 20 - BALLY)-(X - 12 - BALLX, Y - 14 - BALLY), 8
LINE (X - 12 - BALLX, Y - 14 - BALLY)-(X - BALLX, Y - 11 - BALLY), 8
LINE (X - BALLX, Y - 11 - BALLY)-(X - BALLX, Y - 20 - BALLY), 8
PAINT (X - 5 - BALLX, Y - 15 - BALLY), PANTS, 8
LINE (X - BALLX, Y - 20 - BALLY)-(X + 3 - BALLX, Y - 11 - BALLY), 8
LINE (X + 3 - BALLX, Y - 11 - BALLY)-(X + 11 - BALLX, Y - 12 - BALLY), 8
LINE (X + 11 - BALLX, Y - 12 - BALLY)-(X + 9 - BALLX, Y - 20 - BALLY), 8
PAINT (X + 5 - BALLX, Y - 15 - BALLY), PANTS, 8
LINE (X - 9 - BALLX, Y - 12 - BALLY)-(X - 7 - BALLX, Y - 5 - BALLY), 8
LINE (X - 7 - BALLX, Y - 5 - BALLY)-(X - BALLX, Y - 2 - BALLY), 8
LINE (X - BALLX, Y - 2 - BALLY)-(X - 1 - BALLX, Y - 10 - BALLY), 8
PAINT (X - 3 - BALLX, Y - 6 - BALLY), 12, 8
LINE (X - BALLX, Y - 3 - BALLY)-(X - 4 - BALLX, Y + 1 - BALLY), 8
LINE (X - BALLX, Y - 2 - BALLY)-(X - 4 - BALLX, Y + 2 - BALLY), 8
LINE (X - BALLX, Y - 1 - BALLY)-(X - 4 - BALLX, Y + 3 - BALLY), 8
LINE (X + 6 - BALLX, Y - 11 - BALLY)-(X + 3 - BALLX, Y - 3 - BALLY), 8
LINE (X + 3 - BALLX, Y - 3 - BALLY)-(X + 10 - BALLX, Y - 6 - BALLY), 8
LINE (X + 10 - BALLX, Y - 6 - BALLY)-(X + 11 - BALLX, Y - 11 - BALLY), 8
PAINT (X + 8 - BALLX, Y - 7 - BALLY), 12, 8
LINE (X + 3 - BALLX, Y - 3 - BALLY)-(X + 8 - BALLX, Y + 1 - BALLY), 8
LINE (X + 3 - BALLX, Y - 2 - BALLY)-(X + 8 - BALLX, Y + 2 - BALLY), 8
LINE (X + 3 - BALLX, Y - 1 - BALLY)-(X + 8 - BALLX, Y + 3 - BALLY), 8
LINE (X - 14 - BALLX, Y - 35 - BALLY)-(X - 18 - BALLX, Y - 30 - BALLY), 8
LINE (X - 18 - BALLX, Y - 30 - BALLY)-(X - 20 - BALLX, Y - 32 - BALLY), 8
LINE (X - 20 - BALLX, Y - 32 - BALLY)-(X - 22 - BALLX, Y - 30 - BALLY), 8
LINE (X - 22 - BALLX, Y - 30 - BALLY)-(X - 25 - BALLX, Y - 31 - BALLY), 8
LINE (X - 25 - BALLX, Y - 31 - BALLY)-(X - 25 - BALLX, Y - 28 - BALLY), 8
LINE (X - 25 - BALLX, Y - 28 - BALLY)-(X - 20 - BALLX, Y - 26 - BALLY), 8


LINE (X - 20 - BALLX, Y - 26 - BALLY)-(X - 23 - BALLX, Y - 24 - BALLY), 8
LINE (X - 23 - BALLX, Y - 24 - BALLY)-(X - 20 - BALLX, Y - 22 - BALLY), 8
LINE (X - 20 - BALLX, Y - 22 - BALLY)-(X - 16 - BALLX, Y - 25 - BALLY), 8
LINE (X - 16 - BALLX, Y - 25 - BALLY)-(X - 12 - BALLX, Y - 20 - BALLY), 8
LINE (X - 13 - BALLX, Y - 25 - BALLY)-(X - 15 - BALLX, Y - 28 - BALLY), 8
LINE (X - 15 - BALLX, Y - 28 - BALLY)-(X - 10 - BALLX, Y - 32 - BALLY), 8
PAINT (X - 18 - BALLX, Y - 28 - BALLY), 12, 8
LINE (X + 14 - BALLX, Y - 35 - BALLY)-(X + 19 - BALLX, Y - 31 - BALLY), 8
LINE (X + 19 - BALLX, Y - 31 - BALLY)-(X + 20 - BALLX, Y - 35 - BALLY), 8
LINE (X + 20 - BALLX, Y - 35 - BALLY)-(X + 22 - BALLX, Y - 31 - BALLY), 8
LINE (X + 22 - BALLX, Y - 31 - BALLY)-(X + 25 - BALLX, Y - 32 - BALLY), 8
'End of note  18,begin note 19                           

 
'End of note  18,begin note 19                           
LINE (X + 25 - BALLX, Y - 32 - BALLY)-(X + 23 - BALLX, Y - 29 - BALLY), 8
LINE (X + 23 - BALLX, Y - 29 - BALLY)-(X + 25 - BALLX, Y - 26 - BALLY), 8
LINE (X + 25 - BALLX, Y - 26 - BALLY)-(X + 18 - BALLX, Y - 25 - BALLY), 8
LINE (X + 18 - BALLX, Y - 25 - BALLY)-(X + 15 - BALLX, Y - 23 - BALLY), 8
LINE (X + 15 - BALLX, Y - 23 - BALLY)-(X + 15 - BALLX, Y - 26 - BALLY), 8
LINE (X + 15 - BALLX, Y - 26 - BALLY)-(X + 11 - BALLX, Y - 31 - BALLY), 8
PAINT (X + 15 - BALLX, Y - 31 - BALLY), 12, 8
RETURN
INSTRUCTIONS:                                            
CLS : PAINT (320, 175), 15: X = 250: Y = 0
GOSUB STRIKER: LOCATE 15, 7
PRINT "Hi there!  I'm Striker, the U.S. ";
PRINT "Soccer Team's mascot.  But enough"
LOCATE 16, 7: PRINT "with the small-talk, I'm ";
PRINT "here to teach you how to play World Cup  "
LOCATE 17, 7: PRINT "94.  World Cup 94 is played ";
PRINT "like a regular soccer game in which   "
LOCATE 18, 7: PRINT "players try to kick the soccer ";
PRINT "ball into the opposing teams goal. "
LOCATE 19, 7: PRINT "Each time the ball is kicked ";
PRINT "into the opposing teams goal, the    "
LOCATE 20, 7: PRINT "player who kicked the ball's ";
PRINT "team will receive a point.  Whichever"
LOCATE 21, 7: PRINT "team receives three points ";
PRINT "first;wins!.                           "
LOCATE 23, 7: INPUT "Press return", A$: CLS
PAINT (320, 175), 15: X = 250: Y = 0
GOSUB STRIKER: LOCATE 15, 7
PRINT "In World Cup 94 each team consists ";
PRINT "of 3 players; 2 field players  "
LOCATE 16, 7: PRINT "and 1 goalie.  You can ";
PRINT "select from 24 different teams to play as. "
LOCATE 17, 7: PRINT "All teams have actual player's ";
PRINT "names that played in World Cup 94. "
LOCATE 23, 7: INPUT "Press return", A$: CLS
PAINT (320, 175), 15: X = 250: Y = -9
GOSUB STRIKER: LOCATE 14, 7
PRINT "The controls for all 6 players ";
PRINT "are as follows:                    "
LOCATE 15, 7: PRINT "   control   |   1   |   2 ";
PRINT "   |   3    |   4   |   5    |   6     "
LOCATE 16, 7: PRINT "             |goalie1|fielder1";
PRINT "|fielder1|goalie2|fielder2|fielder2 "


LOCATE 17, 7: PRINT "-------------------------------";
PRINT "-----------------------------------"
LOCATE 18, 7: PRINT "     up      |   1   |   E    ";
PRINT "|   U    |   -   |   [    |   8     "
LOCATE 19, 7: PRINT "    left     |  N/A  |   ";
PRINT "S    |   H    |  N/A  |   ;    |   4     "
LOCATE 20, 7: PRINT "    down     |   Q   |   ";
PRINT "X    |   N    |   +   |   /    |   2     "
LOCATE 21, 7: PRINT "   right     |  N/A  |   ";
PRINT "D    |   J    |  N/A  |   '    |   6     "
LOCATE 22, 7: PRINT " shoot/kick  |   `   |   ";
'End of note 19 ,begin note 20                           

 
'End of note 19 ,begin note 20                           
PRINT "R    |   I    |   *   |   ]    |   9     "
LOCATE 23, 7: PRINT "    pass     |  N/A  |   ";
PRINT "W    |   Y    |  N/A  |   P    |   7     "
LOCATE 24, 7: INPUT "Press return", A$
RETURN
CONTROLS:                                                
LPRINT "The controls for all 6 players ";
LPRINT "are as follows:                    "
LPRINT "   control   |   1   |   2 ";
LPRINT "   |   3    |   4   |   5    |   6     "
LPRINT "             |goalie1|fielder1";
LPRINT "|fielder1|goalie2|fielder2|fielder2 "
LPRINT "-------------------------------";
LPRINT "-----------------------------------"
LPRINT "     up      |   1   |   E    ";
LPRINT "|   U    |   -   |   [    |   8     "
LPRINT "    left     |  N/A  |   ";
LPRINT "S    |   H    |  N/A  |   ;    |   4     "
LPRINT "    down     |   Q   |   ";
LPRINT "X    |   N    |   +   |   /    |   2     "
LPRINT "   right     |  N/A  |   ";
LPRINT "D    |   J    |  N/A  |   '    |   6     "
LPRINT " shoot/kick  |   `   |   ";
LPRINT "R    |   I    |   *   |   ]    |   9     "
LPRINT "    pass     |  N/A  |   ";
LPRINT "W    |   Y    |  N/A  |   P    |   7     "
RETURN
SELECTION:                                               
CLS : FOR G = 1 TO 100: LOCATE 12, 33
PRINT "Team Selection": FOR T = 1 TO 50: NEXT T
LOCATE 12, 33: PRINT "              ": FOR T = 1 TO 50
NEXT T: NEXT G: CLS : PL = 1: NUMBER = 1: PICKED = 0
10010 K = 0
IF NUMBER = PICKED THEN
 IF A$ = "4" THEN
  NUMBER = NUMBER - 1
 ELSE
  NUMBER = NUMBER + 1
 END IF
END IF
IF NUMBER < 1 THEN NUMBER = 24
IF NUMBER > 24 THEN NUMBER = 1
IF NUMBER = PICKED THEN


 IF A$ = "4" THEN
  NUMBER = NUMBER - 1
 ELSE
  NUMBER = NUMBER + 1
 END IF
END IF
IF NUMBER < 1 THEN NUMBER = 23
IF NUMBER > 24 THEN NUMBER = 2
IF NUMBER = 1 THEN COUNTRY$ = "U.S.A.": GOSUB USA
IF NUMBER = 2 THEN COUNTRY$ = "Switzerland": GOSUB SWITZERLAND
IF NUMBER = 3 THEN COUNTRY$ = "Romania": GOSUB ROMANIA
'End of note 20 ,begin note 21                           

 
'End of note 20 ,begin note 21                           
IF NUMBER = 4 THEN COUNTRY$ = "Colombia": GOSUB COLOMBIA
IF NUMBER = 5 THEN COUNTRY$ = "Brazil": GOSUB BRAZIL
IF NUMBER = 6 THEN COUNTRY$ = "Cameroon": GOSUB CAMEROON
IF NUMBER = 7 THEN COUNTRY$ = "Sweden": GOSUB SWEDEN
IF NUMBER = 8 THEN COUNTRY$ = "Russia": GOSUB RUSSIA
IF NUMBER = 9 THEN COUNTRY$ = "Germany": GOSUB GERMANY
IF NUMBER = 10 THEN COUNTRY$ = "Spain": GOSUB SPAIN
IF NUMBER = 11 THEN COUNTRY$ = "South Korea": GOSUB SOUTHKOREA
IF NUMBER = 12 THEN COUNTRY$ = "Bolivia": GOSUB BOLIVIA
IF NUMBER = 13 THEN COUNTRY$ = "Argentina": GOSUB ARGENTINA
IF NUMBER = 14 THEN COUNTRY$ = "Nigeria": GOSUB NIGERIA
IF NUMBER = 15 THEN COUNTRY$ = "Bulgaria": GOSUB BULGARIA
IF NUMBER = 16 THEN COUNTRY$ = "Greece": GOSUB GREECE
IF NUMBER = 17 THEN COUNTRY$ = "Ireland": GOSUB IRELAND
IF NUMBER = 18 THEN COUNTRY$ = "Norway": GOSUB NORWAY
IF NUMBER = 19 THEN COUNTRY$ = "Italy": GOSUB ITALY
IF NUMBER = 20 THEN COUNTRY$ = "Mexico": GOSUB MEXICO
IF NUMBER = 21 THEN COUNTRY$ = "Belgium": GOSUB BELGIUM
IF NUMBER = 22 THEN COUNTRY$ = "Netherlands": GOSUB NETHERLANDS
IF NUMBER = 23 THEN COUNTRY$ = "Saudi Arabia": GOSUB SAUDIARABIA
IF NUMBER = 24 THEN COUNTRY$ = "Morocco": GOSUB MOROCCO
LOCATE 22, 11: PRINT "'4' or '6' to see a different ";
PRINT "team, '5' to select this team"
LOCATE 24, 20: PRINT "What is your choice, player"; PL;
A$ = " "
10015 A$ = INKEY$
IF A$ <> "4" AND A$ <> "5" AND A$ <> "6" THEN GOTO 10015
IF A$ = "4" THEN NUMBER = NUMBER - 1: GOTO 10010
IF A$ = "6" THEN NUMBER = NUMBER + 1: GOTO 10010
IF A$ = "5" THEN
 IF PL = 1 THEN
  HANDS1 = HANDS: NAME11$ = NAME1$: NAME12$ = NAME2$
  GOALIE1$ = GOALIE$: STEAL1 = STEAL: SPEED1 = SPEED
  K = 1: COUNTRY1$ = COUNTRY$: PICKED = NUMBER
 ELSE
  NAME21$ = NAME1$: NAME22$ = NAME2$
  GOALIE2$ = GOALIE$: COUNTRY2$ = COUNTRY$
  STEAL2 = STEAL: SPEED2 = SPEED: HANDS2 = HANDS: K = 2
 END IF
END IF
IF K = 1 THEN PL = 2: NUMBER = 1
IF K <> 2 THEN GOTO 10010
CLS : FOR G = 1 TO 100


LOCATE 12, 31: PRINT "Uniform Selection"
FOR T = 1 TO 40: NEXT T
LOCATE 12, 32: PRINT "                 "
FOR T = 1 TO 40: NEXT T: NEXT G: CLS : PL = 1
10020 CLS : LOCATE 2, 31: PRINT "Color number chart"
LOCATE 3, 20
PRINT "-----------------------------------------"
LOCATE 4, 20: PRINT "0 = black             |   6 = brown"
LOCATE 5, 20: PRINT "1 = blue              |   8 = gray"
LOCATE 6, 20
PRINT "2=green(only w/shorts)|   9 = light blue"
'End of note 21 ,begin note 22                           

 
'End of note 21 ,begin note 22                           
LOCATE 7, 20
PRINT "3 = cyan              |  10 = light green"
LOCATE 8, 20
PRINT "4 = red               |  11 = light cyan"
LOCATE 9, 20
PRINT "5 = magenta           |  14 = yellow"
LOCATE 10, 20: PRINT "                      |  15 = white"
LOCATE 12, 20
PRINT "-----------------------------------------"
LOCATE 13, 20
PRINT "What color jersey do you want player"; PL;
INPUT SHIRT: LOCATE 14, 20
PRINT "What color shorts do you want player"; PL;
INPUT PANTS
IF SHIRT <> 15 AND SHIRT <> 0 AND SHIRT <> 1 AND SHIRT <> 3 AND SHIRT <> 4 AND SHIRT <> 5 AND SHIRT <> 8 AND SHIRT <> 9 AND SHIRT <> 10 AND SHIRT <> 11 AND SHIRT <> 14 AND SHIRT <> 6 THEN LOCATE 16, 25: PRINT "You entered a non-valid shirt color": INPUT A$: GOTO 10020
IF PANTS <> 15 AND PANTS <> 0 AND PANTS <> 1 AND PANTS <> 2 AND PANTS <> 3 AND PANTS <> 4 AND PANTS <> 5 AND PANTS <> 8 AND PANTS <> 9 AND PANTS <> 10 AND PANTS <> 11 AND PANTS <> 14 AND PANTS <> 6 THEN LOCATE 16, 25: PRINT "You entered a non-valid shorts color": INPUT A$: GOTO 10020
10030 CLS : GOSUB DEMO: LOCATE 17, 23
PRINT "Does this look okay, player"; PL; : INPUT A$
IF A$ = "N" OR A$ = "NO" THEN GOTO 10020
IF A$ = "Y" OR A$ = "YE" OR A$ = "YES" THEN GOTO 10040
GOTO 10030
10040 IF PL = 1 THEN
 SHIRT1 = SHIRT: PANTS1 = PANTS: PL = 2: BALLX = -320
 BALLY = -175: DIM GUY1%(1 TO 2000)
 GET (290, 90)-(350, 180), GUY1%: GOTO 10020
END IF
DIM GUY2%(1 TO 2000): GET (290, 90)-(350, 180), GUY2%
SHIRT2 = SHIRT: PANTS2 = PANTS: SCORE1 = 0: SCORE2 = 0
CLS : LOCATE 12, 18
PRINT "Make sure that Caps Lock and Num Lock are on"
FOR T = 1 TO 15000: NEXT T
RETURN
DEMO:                                                    
BALLX = -320: BALLY = -175: X = 0: Y = 0: GOSUB PLAYER
RETURN
MAINGAME:                                                


12000 BALLX = 80: BALLY = 105: GOALY1 = 280
GOALY2 = 280: FIELDER11X = 300: FIELDER12X = 300
FIELDER11Y = 230: FIELDER12Y = 330: FIELDER21X = 500
FIELDER22X = 500: FIELDER21Y = 230: FIELDER22Y = 330
CONTROL = 0: POWER = 0: PREV = 0: GOAL1 = 0: GOAL2 = 0
SCREEN 9, , 0, 0: CLS : PCOPY 0, 1
20000 SCREEN 9, , 0, 1: GOSUB DRAWSTUFF
IF GOAL1 = 1 OR GOAL2 = 1 THEN SCREEN 9, , 0, 0: GOTO 50000
SCREEN 9, , 0, 0: PCOPY 0, 1
C$ = " "
C$ = INKEY$
20010 IF C$ <> " " THEN GOSUB INTERPRET
IF POWER < 0 THEN PREV = 0
IF POWER > 0 THEN BALLX = BALLX + DX: BALLY = BALLY + DY
IF POWER > -4 THEN POWER = POWER - 1
LET NUM = INT(RND(1) * 125) + 1
'End of note 22 ,begin note 23                           

 
'End of note 22 ,begin note 23                           
IF BALLX + 320 > FIELDER11X - 16 AND BALLX + 320 < FIELDER11X + 16 AND BALLY + 175 > FIELDER11Y - 16 AND BALLY + 175 < FIELDER11Y + 16 AND NUM < STEAL1 THEN CONTROL = 2
IF BALLX + 320 > FIELDER12X - 16 AND BALLX + 320 < FIELDER12X + 16 AND BALLY + 175 > FIELDER12Y - 16 AND BALLY + 175 < FIELDER12Y + 16 AND NUM < STEAL1 THEN CONTROL = 3
IF BALLX + 320 > FIELDER21X - 16 AND BALLX + 320 < FIELDER21X + 16 AND BALLY + 175 > FIELDER21Y - 16 AND BALLY + 175 < FIELDER21Y + 16 AND NUM < STEAL2 THEN CONTROL = 5
IF BALLX + 320 > FIELDER22X - 16 AND BALLX + 320 < FIELDER22X + 16 AND BALLY + 175 > FIELDER22Y - 16 AND BALLY + 175 < FIELDER22Y + 16 AND NUM < STEAL2 THEN CONTROL = 6
IF (NUM - 40) < HANDS1 AND BALLX + 320 > -180 - 40 AND BALLX + 320 < -180 + 60 AND BALLY + 175 > GOALY1 - 100 AND BALLY + 175 < GOALY1 + 40 THEN CONTROL = 1
IF (NUM - 40) < HANDS2 AND BALLX + 320 > 980 - 60 AND BALLX + 320 < 980 + 40 AND BALLY + 175 > GOALY2 - 100 AND BALLY + 175 < GOALY2 + 40 THEN CONTROL = 4
IF CONTROL = 2 AND PREV <> 2 THEN
 BALLX = FIELDER11X - 320
 BALLY = FIELDER11Y - 175: DX = 0: DY = 0
END IF
IF CONTROL = 3 AND PREV <> 3 THEN
 BALLX = FIELDER12X - 320
 BALLY = FIELDER12Y - 175: DX = 0: DY = 0
END IF
IF CONTROL = 5 AND PREV <> 5 THEN
 BALLX = FIELDER21X - 320
 BALLY = FIELDER21Y - 175: DX = 0: DY = 0
END IF
IF CONTROL = 6 AND PREV <> 6 THEN
 BALLX = FIELDER22X - 320
 BALLY = FIELDER22Y - 175: DX = 0: DY = 0
END IF
IF CONTROL = 4 AND PREV <> 4 THEN
 BALLX = 920 - 320: BALLY = GOALY2 - 175
END IF
IF CONTROL = 1 AND PREV <> 1 THEN
 BALLX = -120 - 320: BALLY = GOALY1 - 175
END IF
IF GOALY1 > 580 THEN GOALY1 = 580
IF GOALY1 < -20 THEN GOALY1 = -20
IF GOALY2 > 580 THEN GOALY2 = 580


IF GOALY2 < -20 THEN GOALY2 = -20
IF FIELDER11X > 1000 THEN FIELDER11X = 1000
IF FIELDER11X < -200 THEN FIELDER11X = -200
IF FIELDER11Y > 580 THEN FIELDER11Y = 580
IF FIELDER11Y < -20 THEN FIELDER11Y = -20
IF FIELDER12X > 1000 THEN FIELDER12X = 1000
IF FIELDER12X < -200 THEN FIELDER12X = -200
IF FIELDER12Y > 580 THEN FIELDER12Y = 580
IF FIELDER12Y < -20 THEN FIELDER12Y = -20
IF FIELDER21X > 1000 THEN FIELDER21X = 1000
IF FIELDER21X < -200 THEN FIELDER21X = -200
IF FIELDER21Y > 580 THEN FIELDER21Y = 580
IF FIELDER21Y < -20 THEN FIELDER21Y = -20
IF FIELDER22X > 1000 THEN FIELDER22X = 1000
IF FIELDER22X < -200 THEN FIELDER22X = -200
IF FIELDER22Y > 580 THEN FIELDER22Y = 580
IF FIELDER22Y < -20 THEN FIELDER22Y = -20
'End of note 23 ,begin note 24                           

 
'End of note 23 ,begin note 24                           
IF BALLY < -195 THEN BALLY = -195
IF BALLY > 405 THEN BALLY = 405
IF BALLY < 5 AND BALLX < -520 THEN BALLX = -520
IF BALLY > 205 AND BALLX < -520 THEN BALLX = -520
IF BALLY < 5 AND BALLX > 680 THEN BALLX = 680
IF BALLY > 205 AND BALLX > 680 THEN BALLX = 680
IF BALLX < -520 THEN GOAL1 = 1
IF BALLX > 680 THEN GOAL2 = 1
GOTO 20000
RETURN
DRAWSTUFF:                                               
GOSUB SOCCERFIELD
IF FIELDER11X > BALLX + 35 AND FIELDER11X < BALLX + 605 AND FIELDER11Y > BALLY + 90 AND FIELDER11Y < BALLY + 340 THEN
 PUT (FIELDER11X - 30 - BALLX, FIELDER11Y - 90 - BALLY), GUY1%, OR
END IF
IF FIELDER12X > BALLX + 35 AND FIELDER12X < BALLX + 605 AND FIELDER12Y > BALLY + 90 AND FIELDER12Y < BALLY + 340 THEN
 PUT (FIELDER12X - 30 - BALLX, FIELDER12Y - 90 - BALLY), GUY1%, OR
END IF
IF FIELDER21X > BALLX + 35 AND FIELDER21X < BALLX + 605 AND FIELDER21Y > BALLY + 90 AND FIELDER21Y < BALLY + 340 THEN
 PUT (FIELDER21X - 30 - BALLX, FIELDER21Y - 90 - BALLY), GUY2%, OR
END IF
IF FIELDER22X > BALLX + 35 AND FIELDER22X < BALLX + 605 AND FIELDER22Y > BALLY + 90 AND FIELDER22Y < BALLY + 340 THEN
 PUT (FIELDER22X - 30 - BALLX, FIELDER22Y - 90 - BALLY), GUY2%, OR
END IF
IF -180 > BALLX + 35 AND -180 < BALLX + 605 AND GOALY1 > BALLY + 90 AND GOALY1 < BALLY + 340 THEN
 PUT (-180 - 30 - BALLX, GOALY1 - 90 - BALLY), GUY1%, OR
END IF
IF 980 > BALLX + 35 AND 980 < BALLX + 605 AND GOALY2 > BALLY + 90 AND GOALY2 < BALLY + 340 THEN
 PUT (980 - 30 - BALLX, GOALY2 - 90 - BALLY), GUY2%, OR
END IF
RETURN
INTERPRET:                                               
LET NU = INT(RND(1) * 5) + 1


IF NU = 1 THEN NUM = -99
IF NU = 2 THEN NUM = 99
IF NU = 3 THEN NUM = 0
IF NU = 4 THEN NUM = 50
IF NU = 5 THEN NUM = -50
IF C$ = "1" THEN GOALY1 = GOALY1 - 10 - SPEED1
IF C$ = "Q" THEN GOALY1 = GOALY1 + 10 + SPEED1
IF C$ = "`" AND CONTROL = 1 THEN
 POWER = 40: DX = 20
 LET DY = ((INT(RND(1) * 600)) - 300) / POWER
 CONTROL = 0: PREV = 1: BALLX = BALLX + 20
END IF
IF C$ = "E" THEN FIELDER11Y = FIELDER11Y - 10 - SPEED1
IF C$ = "S" THEN FIELDER11X = FIELDER11X - 10 - SPEED1
IF C$ = "X" THEN FIELDER11Y = FIELDER11Y + 10 + SPEED1
IF C$ = "D" THEN FIELDER11X = FIELDER11X + 10 + SPEED1
IF C$ = "W" AND CONTROL = 2 THEN
'End of note 24 ,begin note 25                           

 
'End of note 24 ,begin note 25                           
 POWER = 15
 DX = (FIELDER11X - FIELDER12X) / (POWER * -1)
 DY = (FIELDER11Y - FIELDER12Y) / (POWER * -1): PREV = 2
 CONTROL = 0
END IF
IF C$ = "R" AND CONTROL = 2 THEN
 POWER = 17
 DX = (FIELDER11X - 1010) / (POWER * -1)
 DY = (FIELDER11Y - 280 + NUM) / (POWER * -1)
 PREV = 2: CONTROL = 0
END IF
IF C$ = "U" THEN FIELDER12Y = FIELDER12Y - 10 - SPEED1
IF C$ = "H" THEN FIELDER12X = FIELDER12X - 10 - SPEED1
IF C$ = "N" THEN FIELDER12Y = FIELDER12Y + 10 + SPEED1
IF C$ = "J" THEN FIELDER12X = FIELDER12X + 10 + SPEED1
IF C$ = "Y" AND CONTROL = 3 THEN
 POWER = 15
 DX = (FIELDER12X - FIELDER11X) / (POWER * -1)
 DY = (FIELDER12Y - FIELDER11Y) / (POWER * -1)
 PREV = 3: CONTROL = 0
END IF
IF C$ = "I" AND CONTROL = 3 THEN
 POWER = 17: DX = (FIELDER12X - 1010) / (POWER * -1)
 DY = (FIELDER12Y - 280 + NUM) / (POWER * -1)
 PREV = 3: CONTROL = 0
END IF
IF C$ = "-" THEN GOALY2 = GOALY2 - 10 - SPEED2
IF C$ = "+" THEN GOALY2 = GOALY2 + 10 + SPEED2
IF C$ = "*" AND CONTROL = 4 THEN
 POWER = 40: DX = -20
 LET DY = ((INT(RND(1) * 600)) - 300) / POWER
 CONTROL = 0: PREV = 4: BALLX = BALLX - 20
END IF
IF C$ = "[" THEN FIELDER21Y = FIELDER21Y - 10 - SPEED2
IF C$ = ";" THEN FIELDER21X = FIELDER21X - 10 - SPEED2
IF C$ = "/" THEN FIELDER21Y = FIELDER21Y + 10 + SPEED2
IF C$ = "'" THEN FIELDER21X = FIELDER21X + 10 + SPEED2
IF C$ = "P" AND CONTROL = 5 THEN
 POWER = 15
 DX = (FIELDER21X - FIELDER22X) / (POWER * -1)
 DY = (FIELDER21Y - FIELDER22Y) / (POWER * -1)
 PREV = 5: CONTROL = 0
END IF


IF C$ = "]" AND CONTROL = 5 THEN
 POWER = 17: DX = (FIELDER21X + 210) / (POWER * -1)
 DY = (FIELDER21Y - 280 + NUM) / (POWER * -1)
 PREV = 5: CONTROL = 0
END IF
IF C$ = "8" THEN FIELDER22Y = FIELDER22Y - 10 - SPEED2
IF C$ = "4" THEN FIELDER22X = FIELDER22X - 10 - SPEED2
IF C$ = "2" THEN FIELDER22Y = FIELDER22Y + 10 + SPEED2
IF C$ = "6" THEN FIELDER22X = FIELDER22X + 10 + SPEED2
IF C$ = "7" AND CONTROL = 6 THEN
 POWER = 15
 DX = (FIELDER22X - FIELDER21X) / (POWER * -1)
 DY = (FIELDER22Y - FIELDER21Y) / (POWER * -1)
 PREV = 6: CONTROL = 0
END IF
IF C$ = "9" AND CONTROL = 6 THEN
 POWER = 17: DX = (FIELDER22X + 210) / (POWER * -1)
 DY = (FIELDER22Y - 280 + NUM) / (POWER * -1): PREV = 6: CONTROL = 0
END IF
40000 REM                                                
IF ABS(DX) > 30 THEN DX = DX * .95: DY = DY * .95
IF ABS(DY) > 30 THEN DX = DX * .95: DY = DY * .95
IF ABS(DX) > 30 OR ABS(DY) > 30 THEN GOTO 40000
RETURN
50000 REM GOAL                                           
SCORER$ = "Z%": IF PREV = 1 THEN SCORER$ = GOALIE1$
IF PREV = 2 THEN SCORER$ = NAME11$
IF PREV = 3 THEN SCORER$ = NAME12$
IF PREV = 4 THEN SCORER$ = GOALIE2$
IF PREV = 5 THEN SCORER$ = NAME21$
IF PREV = 6 THEN SCORER$ = NAME22$
IF SCORER$ = "Z%" AND CONTROL = 1 THEN SCORER$ = GOALIE1$
IF SCORER$ = "Z%" AND CONTROL = 2 THEN SCORER$ = NAME11$
IF SCORER$ = "Z%" AND CONTROL = 3 THEN SCORER$ = NAME12$
IF SCORER$ = "Z%" AND CONTROL = 4 THEN SCORER$ = GOALIE2$
IF SCORER$ = "Z%" AND CONTROL = 5 THEN SCORER$ = NAME21$
IF SCORER$ = "Z%" AND CONTROL = 6 THEN SCORER$ = NAME22$
LOCATE 12, 36: PRINT "Goal!!!!": LOCATE 14, 25
IF SCORER$ <> "Z" THEN PRINT "Goal scored by ";
IF SCRORE$ <> "Z" THEN PRINT SCORER$; " !!!!!!"
FOR T1 = 1 TO 5: FOR T2 = 37 TO 14000 STEP 1000
SOUND T2, 1: NEXT T2: NEXT T1: FOR T1 = 1 TO 30
LET T2 = INT(RND(1) * 500) + 2000: SOUND T2, 1
NEXT T1: CLS : SCORE1 = SCORE1 + GOAL2
SCORE2 = SCORE2 + GOAL1: LOCATE 12, 30
PRINT COUNTRY1$; SCORE1; "-"; SCORE2; COUNTRY2$
FOR T3 = 1 TO 60000: NEXT T3
GOAL1 = 0: GOAL2 = 0
IF SCORE1 > 2 OR SCORE2 > 2 THEN GOTO 60000
GOTO 12000
60000 RETURN
END


'End of note 26                                          
'That's all Folks     By A|@* Makris at CRPY26C          

