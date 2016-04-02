' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
' VS Mouse Support
' Copyright by Stefan Vogt 1995 - 1997
' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
' 컴컴횯eclare subs & functions컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
DECLARE SUB LoadConfiguration ()
DECLARE SUB MouseArea (x1%, x2%, y1%, y2%)
DECLARE SUB MousePointer (OnOrOff$)
DECLARE SUB MouseSpeed (Speed%)
DECLARE SUB MouseSet (x%, y%)
DECLARE SUB MouseWait ()
DECLARE FUNCTION MouseInterr% (num%, ax%, bx%, cx%, dx%)
' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'컴컴횯im Arrays컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
DIM Mouse%(0 TO 45)
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
'컴컴횺ain컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
LoadConfiguration
SCREEN 12
CLS
 MousePointer "Off"
 ' ========= Screen Base Color  =============
 COLOR 4
LINE (1, 1)-(640, 480), 4, BF
'==============END OF Screen Base Color =======
REM ========= TITLE ===============================
LINE (222, 7)-(418, 38), 8, BF
LINE (222, 7)-(418, 38), 0, B
LINE (223, 38)-(418, 38), 12, BF
LINE (418, 7)-(418, 38), 12, BF
PSET (228, 22), 0
DRAW "R12U12L2R4L2D25L2R15"                       'I
DRAW "U25L7R14L7D25R18"                           'T
DRAW "BU23H2L3G3D19F3R3E3R5"                      'C
DRAW "D3U25D13R9U13D25U13R7 "                     'H
DRAW "BD2D11U22E3R5F3D10L11R11D12U15D7R7"         'A
DRAW "U2L2R12U1L12R12L2U1R9"                        '-
DRAW "H3U7E3R3F3BD10BL11R9F2D7G3L4H3U2"           'S
DRAW "BD5BR7R10U25D15R3E5U10D10G5E2F5D7R6"        'K
DRAW "U25L2R4L2D25L2R15"                          'I
DRAW "U25L7R14L7D25R18"                           'T
DRAW "BU23H2L3G3D19F3R3E3R5"                      'C
DRAW "D3U25D13R9U13D25U13R7 "                     'H
PSET (229, 22), 0
DRAW "R12U12L2R4L2D25L2R15"                       'I
DRAW "U25L7R14L7D25R18"                           'T
DRAW "BU23H2L3G3D19F3R3E3R5"                      'C
DRAW "D3U25D13R9U13D25U13R7 "                     'H
DRAW "BD2D11U22E3R5F3D10L11R11D12U15D7R7"         'A
DRAW "U2L2R12L12R12L2U2R9"                        '-
DRAW "H3U7E3R3F3BD10BL11R9F2D7G3L4H3U2"           'S
DRAW "BD5BR7R10U25D15R3E5U10D10G5E2F5D7R6"        'K
DRAW "U25L2R4L2D25L2R15"                          'I
DRAW "U25L7R14L7D25R18"                           'T
DRAW "BU23H2L3G3D19F3R3E3R5"                      'C
DRAW "D3U25D13R9U13D25U13R7 "                     'H

REM ===== LETTERS HIGH LIGHT
LINE (18, 454)-(18, 454), 12
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                               'R
DRAW "U4E1R2F1D4G1L2H1BR8"                                     'o
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                               'R
DRAW "U2E1R3U1H1L2G1E1R2F1D4G1L2H1F1BR2E1U2D3BR4BU1"           'a
DRAW "BU5D5F1R2E1U5D8G1L2H1BU3BR8"                             'y
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "BR2BU7D1G1BD5BR4"                                        ''
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "U5D5F1R2E1U5D5BR4"                                      'u
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BU5D5F1R2E1U5D8G1L2H1BU3BR8"                             'y
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U4E1R2F1D4G1L2H1BR8"                                     'o
DRAW "U4E1R2F1D4G1L2H1BD3F1R2E1U3BR4"                          'g
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U2E1R3U1H1L2G1E1R2F1D4G1L2H1F1BR2E1U2D3BR4BU1"           'a
DRAW "BD1U6D1E1R1F1D5U5E1R1F1D5BU1BR4"                         'm
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BR1BU7D2L2R4L2D5F1R1E1BR4"                               't
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BR1U1BU2U1BD4BR3"                                        ':
DRAW "BR4"                                                     'space
DRAW "BD1BR3U8L1R2L1D8L1R2BR4BU1"                             'I
DRAW "BR3BD1BU8L4R6L3D8BR6BU1"                                'T
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8D4R4U4D8BR4BU1"                                    'H
DRAW "BD1U7E1R3F1D3L5R5D4BR4BU1"                              'A
DRAW "BR1BU3R3L3BD3BR5"                                       '-
DRAW "BD1BU5U2E1R3F1BD2BL5F1R3F1D2G1L3H1BR9"                  'S
DRAW "BD1BU8D8U4R1E4G4F4BR4BU1"                               'K
DRAW "BD1BR3U8L1R2L1D8L1R2BR4BU1"                             'I
DRAW "BR3BD1BU8L4R6L3D8BR6BU1"                                'T
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8D4R4U4D8BR4BU1"                                    'H
LINE (19, 455)-(19, 455), 0
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                               'R
DRAW "U4E1R2F1D4G1L2H1BR8"                                     'o
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                               'R
DRAW "U2E1R3U1H1L2G1E1R2F1D4G1L2H1F1BR2E1U2D3BR4BU1"           'a
DRAW "BU5D5F1R2E1U5D8G1L2H1BU3BR8"                             'y
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "BR2BU7D1G1BD5BR4"                                        ''
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "U5D5F1R2E1U5D5BR4"                                      'u
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BU5D5F1R2E1U5D8G1L2H1BU3BR8"                             'y
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U4E1R2F1D4G1L2H1BR8"                                     'o
DRAW "U4E1R2F1D4G1L2H1BD3F1R2E1U3BR4"                          'g
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U2E1R3U1H1L2G1E1R2F1D4G1L2H1F1BR2E1U2D3BR4BU1"           'a
DRAW "BD1U6D1E1R1F1D5U5E1R1F1D5BU1BR4"                         'm
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BR1BU7D2L2R4L2D5F1R1E1BR4"                               't
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BR1U1BU2U1BD4BR3"                                        ':
DRAW "BR4"                                                     'space
DRAW "BD1BR3U8L1R2L1D8L1R2BR4BU1"                             'I
DRAW "BR3BD1BU8L4R6L3D8BR6BU1"                                'T
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8D4R4U4D8BR4BU1"                                    'H
DRAW "BD1U7E1R3F1D3L5R5D4BR4BU1"                              'A
DRAW "BR1BU3R3L3BD3BR5"                                       '-
DRAW "BD1BU5U2E1R3F1BD2BL5F1R3F1D2G1L3H1BR9"                  'S
DRAW "BD1BU8D8U4R1E4G4F4BR4BU1"                               'K
DRAW "BD1BR3U8L1R2L1D8L1R2BR4BU1"                             'I
DRAW "BR3BD1BU8L4R6L3D8BR6BU1"                                'T
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8D4R4U4D8BR4BU1"                                    'H

REM ======= letter shadows

LINE (20, 456)-(20, 456), 0
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                               'R
DRAW "U4E1R2F1D4G1L2H1BR8"                                     'o
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                               'R
DRAW "U2E1R3U1H1L2G1E1R2F1D4G1L2H1F1BR2E1U2D3BR4BU1"           'a
DRAW "BU5D5F1R2E1U5D8G1L2H1BU3BR8"                             'y
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "BR2BU7D1G1BD5BR4"                                        ''
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "U5D5F1R2E1U5D5BR4"                                      'u
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BU5D5F1R2E1U5D8G1L2H1BU3BR8"                             'y
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U4E1R2F1D4G1L2H1BR8"                                     'o
DRAW "U4E1R2F1D4G1L2H1BD3F1R2E1U3BR4"                          'g
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U2E1R3U1H1L2G1E1R2F1D4G1L2H1F1BR2E1U2D3BR4BU1"           'a
DRAW "BD1U6D1E1R1F1D5U5E1R1F1D5BU1BR4"                         'm
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BR1BU7D2L2R4L2D5F1R1E1BR4"                               't
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BR1U1BU2U1BD4BR3"                                        ':
DRAW "BR4"                                                     'space
DRAW "BD1BR3U8L1R2L1D8L1R2BR4BU1"                             'I
DRAW "BR3BD1BU8L4R6L3D8BR6BU1"                                'T
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8D4R4U4D8BR4BU1"                                    'H
DRAW "BD1U7E1R3F1D3L5R5D4BR4BU1"                              'A
DRAW "BR1BU3R3L3BD3BR5"                                       '-
DRAW "BD1BU5U2E1R3F1BD2BL5F1R3F1D2G1L3H1BR9"                  'S
DRAW "BD1BU8D8U4R1E4G4F4BR4BU1"                               'K
DRAW "BD1BR3U8L1R2L1D8L1R2BR4BU1"                             'I
DRAW "BR3BD1BU8L4R6L3D8BR6BU1"                                'T
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8D4R4U4D8BR4BU1"                                    'H
LINE (19, 455)-(19, 455), 12
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                               'R
DRAW "U4E1R2F1D4G1L2H1BR8"                                     'o
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                               'R
DRAW "U2E1R3U1H1L2G1E1R2F1D4G1L2H1F1BR2E1U2D3BR4BU1"           'a
DRAW "BU5D5F1R2E1U5D8G1L2H1BU3BR8"                             'y
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "BR2BU7D1G1BD5BR4"                                        ''
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "U5D5F1R2E1U5D5BR4"                                      'u
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BU5D5F1R2E1U5D8G1L2H1BU3BR8"                             'y
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U4E1R2F1D4G1L2H1BR8"                                     'o
DRAW "U4E1R2F1D4G1L2H1BD3F1R2E1U3BR4"                          'g
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U2E1R3U1H1L2G1E1R2F1D4G1L2H1F1BR2E1U2D3BR4BU1"           'a
DRAW "BD1U6D1E1R1F1D5U5E1R1F1D5BU1BR4"                         'm
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BD1U8R4F1D2G1L4D4BR9BU1"                                 'P
DRAW "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7"                           'r
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "U4E1R2F1D2L4D2F1R2E1BR4"                                 'e
DRAW "BD1U6D1E1R2F1D5U4BD3BR4"                                 'n
DRAW "BR1BU7D2L2R4L2D5F1R1E1BR4"                               't
DRAW "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8"                    's
DRAW "BR4"                                                     'space
DRAW "BR1U1BU2U1BD4BR3"                                        ':
DRAW "BR4"                                                     'space
DRAW "BD1BR3U8L1R2L1D8L1R2BR4BU1"                             'I
DRAW "BR3BD1BU8L4R6L3D8BR6BU1"                                'T
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8D4R4U4D8BR4BU1"                                    'H
DRAW "BD1U7E1R3F1D3L5R5D4BR4BU1"                              'A
DRAW "BR1BU3R3L3BD3BR5"                                       '-
DRAW "BD1BU5U2E1R3F1BD2BL5F1R3F1D2G1L3H1BR9"                  'S
DRAW "BD1BU8D8U4R1E4G4F4BR4BU1"                               'K
DRAW "BD1BR3U8L1R2L1D8L1R2BR4BU1"                             'I
DRAW "BR3BD1BU8L4R6L3D8BR6BU1"                                'T
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8D4R4U4D8BR4BU1"                                    'H
REM ========  CLEAR SCREEN SHADO ====================================
LINE (46, 431)-(46, 431), 0
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1BU8D8R4BU1BR4"                                       'L
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U7E1R3F1D3L5R5D4BR4BU1"                              'A
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                              'R
DRAW "BR4"                                                     'space
DRAW "BD1BU5U2E1R3F1BD2BL5F1R3F1D2G1L3H1BR9"                  'S
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                              'R
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U8F7D1U8D8BR4BU1"                                    'N

LINE (45, 431)-(45, 431), 0
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1BU8D8R4BU1BR4"                                       'L
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U7E1R3F1D3L5R5D4BR4BU1"                              'A
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                              'R
DRAW "BR4"                                                     'space
DRAW "BD1BU5U2E1R3F1BD2BL5F1R3F1D2G1L3H1BR9"                  'S
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                              'R
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U8F7D1U8D8BR4BU1"                                    'N
REM ========  CLEAR SCREEN HI LIGHT ==============================
LINE (47, 432)-(47, 432), 12
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1BU8D8R4BU1BR4"                                       'L
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U7E1R3F1D3L5R5D4BR4BU1"                              'A
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                              'R
DRAW "BR4"                                                     'space
DRAW "BD1BU5U2E1R3F1BD2BL5F1R3F1D2G1L3H1BR9"                  'S
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                              'R
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U8F7D1U8D8BR4BU1"                                    'N
PSET (85, 431), 0
DRAW "F1"
PSET (112, 429), 0
DRAW "F3"
PSET (135, 425), 0
DRAW "F5"
PSET (135, 427), 12
DRAW "F5"

REM ========  CLEAR SCREEN DEPTH AREA =================================
LINE (46, 432)-(46, 432), 4
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1BU8D8R4BU1BR4"                                       'L
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U7E1R3F1D3L5R5D4BR4BU1"                              'A
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                              'R
DRAW "BR4"                                                     'space
DRAW "BD1BU5U2E1R3F1BD2BL5F1R3F1D2G1L3H1BR9"                  'S
DRAW "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1"                      'C
DRAW "BD1U8R4F1D2G1L4R1F4BR4BU1"                              'R
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U8R4L4D4R3L3D4R4BU1BR4"                              'E
DRAW "BD1U8F7D1U8D8BR4BU1"                                    'N
REM ==== QUIT LETTERS
PSET (54, 34), 0
DRAW "BD1BU1U6E1R3F1BD6G1L3H1BR5U6BL3BD5F3BG3BR7BU5"          'Q
DRAW "BD1BU1U7D7F1R3E1U7D7BR4"                                'U
DRAW "BD1BR3U8L1R2L1D8L1R2BR4BU1"                             'I
DRAW "BR3BD1BU8L4R6L3D8BR6BU1"                                'T
REM =============== QUIT LETTER HI LIGHT
PSET (55, 35), 12
DRAW "BD1BU1U6E1R3F1BD6G1L3H1BR5U6BL3BD5F3BG3BR7BU5"          'Q
DRAW "BD1BU1U7D7F1R3E1U7D7BR4"                                'U
DRAW "BD1BR3U8L1R2L1D8L1R2BR4BU1"                             'I
DRAW "BR3BD1BU8L4R6L3D8BR6BU1"                                'T
REM ========== QUIT LETTERS MID AREA
PSET (56, 36), 4
DRAW "BD1BU1U6E1R3F1BD6G1L3H1BR5U6BL3BD5F3BG3BR7BU5"          'Q
DRAW "BD1BU1U7D7F1R3E1U7D7BR4"                                'U
DRAW "BD1BR3U8L1R2L1D8L1R2BR4BU1"                             'I
DRAW "BR3BD1BU8L4R6L3D8BR6BU1"                                'T

 REM ================== LOWERED AREABASE ==========
LINE (19 - 1, 43 - 1)-(611 + 1, 379 + 1), 0, BF' LABOX1
LINE (19, 43)-(611, 379), 4, BF    ' LABOX2
LINE (19, 43)-(611, 43 + 1), 0, BF   ' LABOX3
LINE (19, 43)-(19 + 1, 379), 0, BF     ' LABOX4
LINE (611 - 1, 43)-(611, 379), 4 + 8, BF   ' LABOX5
LINE (19, 379 - 1)-(611, 379), 4 + 8, BF  ' LABOX1
REM =============END OF LOWERED AREA + LANAME$ =============
REM ============== FLAT AREA - DRAWAREA ===========
LINE (21, 44)-(608, 376), 8, BF    'FLATAREA
REM ===== END OF FLAT AREA - DRAWAREA ========
 REM ================== RAISED AREABASE ==========
LINE (450 - 1, 383 - 1)-(588 + 1, 440 + 1), 0, BF' RABOX1 'Outer boxline
LINE (450, 380)-(587, 440), 4, BF    ' RABOX2 'Face
LINE (450, 380)-(587, 380 + 1), 4 + 8, BF    ' RABOX3 'Top high light
LINE (450, 380)-(450 + 1, 440), 4 + 8, BF      ' RABOX4 'Left edge high light
LINE (587 - 1, 380)-(587, 440), 0, BF    ' RABOX5 'Right edge shadow
LINE (450, 440 - 1)-(587, 440), 0, BF ' RABOX1 'Bottom edge shadow
LINE (449, 381 - 1)-(449, 440), 0, BF ' RABOX1 'Bottom edge shadow
REM =============END OF RAISED AREA + RANAME$ =============
REM ============== BUTTON - LEFT ===========
LINE (454 - 1, 401 - 1)-(494 + 1, 421 + 1), 0, BF'BASEBOX
LINE (454, 401)-(494, 421), 7, BF    'BUTTNBODY
LINE (454, 401)-(494, 401 + 3), 15, BF   'TLIGHT
LINE (454, 401)-(454 + 3, 421), 15, BF     ' FHILIT
LINE (494, 401)-(494, 421), 8, BF     'BBSHADO
LINE (494 - 2, 401 + 1)-(494, 421), 8, BF   'BBSHADO3
LINE (494 - 3, 401 + 3)-(494, 421), 8, BF    'BBSHADO4
LINE (454 + 3, 421)-(494, 421), 8, BF     'SSHADO
LINE (454 + 2, 421 - 3)-(494, 421), 8, BF     'SSHADO2
LINE (454, 421 - 1)-(494, 421), 8, BF     'SSHADO4
PSET (460, 412), 15
DRAW "E5G5F5"
PSET (466, 407), 15
DRAW "R1"
PSET (467, 417), 0
DRAW "u11r0d11"
PSET (465, 417), 8
DRAW "R2"
PSET (459, 412), 0
DRAW "E5G5F5"
PSET (465, 406), 0
DRAW "R2"
REM ==== END OF LATENT BUTTON LEFT =======
REM ============== BUTTON - UPGO ===========
LINE (498 - 1, 387 - 1)-(538 + 1, 407 + 1), 0, BF'BASEBOX
LINE (498, 387)-(538, 407), 7, BF    'BUTTNBODY
LINE (498, 387)-(538, 387 + 3), 15, BF   'TLIGHT
LINE (498, 387)-(498 + 3, 407), 15, BF     ' FHILIT
LINE (538, 387)-(538, 407), 8, BF     'BBSHADO
LINE (538 - 2, 387 + 1)-(538, 407), 8, BF   'BBSHADO3
LINE (538 - 3, 387 + 3)-(538, 407), 8, BF    'BBSHADO4
LINE (498 + 3, 407)-(538, 407), 8, BF     'SSHADO
LINE (498 + 2, 407 - 3)-(538, 407), 8, BF     'SSHADO2
LINE (498, 407 - 1)-(538, 407), 8, BF     'SSHADO4
PSET (518, 393), 15
DRAW "F3H3G5D2"
PSET (517, 392), 0
DRAW "G5D3R12U3H5"
PSET (513, 399), 8
DRAW "R10U2H2"
REM ==== END OF LATENT BUTTON UPGO =======
REM ============== BUTTON - DOWNGO ===========
LINE (498 - 1, 417 - 1)-(538 + 1, 436 + 1), 0, BF'BASEBOX
LINE (498, 417)-(538, 436), 7, BF    'BUTTNBODY
LINE (498, 417)-(538, 417 + 3), 15, BF   'TLIGHT
LINE (498, 417)-(498 + 3, 436), 15, BF     ' FHILIT
LINE (538, 417)-(538, 436), 8, BF     'BBSHADO
LINE (538 - 2, 417 + 1)-(538, 436), 8, BF   'BBSHADO3
LINE (538 - 3, 417 + 3)-(538, 436), 8, BF    'BBSHADO4
LINE (498 + 3, 436)-(538, 436), 8, BF     'SSHADO
LINE (498 + 2, 436 - 3)-(538, 436), 8, BF     'SSHADO2
LINE (498, 436 - 1)-(538, 436), 8, BF     'SSHADO4
PSET (513, 427), 15
DRAW "U2R10D2"
PSET (517, 432), 0
DRAW "H5U3R12D3G5"
PSET (518, 432), 8
DRAW "E5U1"

REM ==== END OF LATENT BUTTON DOWNGO =======
REM ============== BUTTON - RIGHTGO ===========
LINE (543 - 1, 401 - 1)-(583 + 1, 421 + 1), 0, BF'BASEBOX
LINE (543, 401)-(583, 421), 7, BF    'BUTTNBODY
LINE (543, 401)-(583, 401 + 3), 15, BF   'TLIGHT
LINE (543, 401)-(543 + 3, 421), 15, BF     ' FHILIT
LINE (583, 401)-(583, 421), 8, BF     'BBSHADO
LINE (583 - 2, 401 + 1)-(583, 421), 8, BF   'BBSHADO3
LINE (583 - 3, 401 + 3)-(583, 421), 8, BF    'BBSHADO4
LINE (543 + 3, 421)-(583, 421), 8, BF     'SSHADO
LINE (543 + 2, 421 - 3)-(583, 421), 8, BF     'SSHADO2
LINE (543, 421 - 1)-(583, 421), 8, BF     'SSHADO4
PSET (578, 412), 8
DRAW "H5F5G5"
PSET (577, 412), 8
DRAW "H5F5G5"
PSET (571, 407), 15
DRAW "L1"
PSET (570, 416), 15
DRAW "U10"
PSET (569, 417), 0
DRAW "U11"
PSET (572, 417), 0
DRAW "L2"
PSET (578, 412), 0
DRAW "H5F5G5"
PSET (572, 406), 0
DRAW "L2"
REM ==== END OF LATENT BUTTON RIGHTGO =======
REM ============== BUTTON - CLEARIT ===========
LINE (18 - 1, 410 - 1)-(39 + 1, 433 + 1), 0, BF'BASEBOX
LINE (18, 410)-(39, 433), 7, BF    'BUTTNBODY
LINE (18, 410)-(39, 410 + 3), 15, BF   'TLIGHT
LINE (18, 410)-(18 + 3, 433), 15, BF     ' FHILIT
LINE (39, 410)-(39, 433), 8, BF     'BBSHADO
LINE (39 - 2, 410 + 1)-(39, 433), 8, BF   'BBSHADO3
LINE (39 - 3, 410 + 3)-(39, 433), 8, BF    'BBSHADO4
LINE (18 + 3, 433)-(39, 433), 8, BF     'SSHADO
LINE (18 + 2, 433 - 3)-(39, 433), 8, BF     'SSHADO2
LINE (18, 433 - 1)-(39, 433), 8, BF     'SSHADO4
REM ==== END OF LATENT BUTTON CLEARIT =======
REM ============== BUTTON - QUIT ===========
LINE (18 - 1, 16 - 1)-(48 + 1, 38 + 1), 0, BF'BASEBOX
LINE (18, 16)-(48, 38), 4, BF    'BUTTNBODY
LINE (18, 16)-(48, 16 + 3), 12, BF   'TLIGHT
LINE (18, 16)-(18 + 3, 38), 12, BF     ' FHILIT
LINE (48, 16)-(48, 38), 8, BF     'BBSHADO
LINE (48 - 2, 16 + 1)-(48, 38), 0, BF   'BBSHADO3
LINE (48 - 3, 16 + 3)-(48, 38), 0, BF    'BBSHADO4
LINE (18 + 3, 38)-(48, 38), 0, BF     'SSHADO
LINE (18 + 2, 38 - 3)-(48, 38), 0, BF     'SSHADO2
LINE (18, 38 - 1)-(48, 38), 0, BF     'SSHADO4
LINE (28, 22)-(40, 34), 12, B
PSET (28, 22), 12
DRAW "F11H6G6E12G7H5F11"
LINE (27, 21)-(39, 33), 0, B
PSET (27, 21), 0
DRAW "F12H6G6E12"
REM ==== END OF LATENT BUTTON QUIT =======
LINEHRZ = 310
LINEVRT = 210
DO
 MousePointer "On"
CALL MouseWait
IF mousex% > 454 AND mousex% < 494 AND mousey% > 401 AND mousey% < 421 AND MouseB% = 1 THEN
REM === START OF - IN - BUTTON LEFT ==========
MousePointer "Off"
LINE (454, 401)-(494, 421), 8, BF    'ACTBUTTN
LINE (454, 401)-(494, 401 + 2), 0, BF   'ACTTSHADO
LINE (454, 401)-(454 + 2, 421), 0, BF     'ACTFSHADO
LINE (494 - 4, 401)-(494, 421), 0, BF    'BBHLIT2
LINE (454, 421 - 4)-(494 - 1, 421), 0, BF   'WHATZIT
LINE (494, 401)-(494, 421), 12, BF     'BBHLIT'SIDE SLOT EDGE ULTRA HI-LIGHT
LINE (454, 421)-(494, 421), 12, BF      'SSHLIT4
PSET (463, 412), 7
DRAW "E5G5F5"
PSET (464, 412), 8
DRAW "E5G5F5"
PSET (465, 412), 8
DRAW "E5G5F5"
PSET (466, 412), 8
DRAW "E4G4F4"
PSET (467, 412), 8
DRAW "E2G2F2"
PSET (468, 412), 8
DRAW "E1G1F1"
PSET (469, 412), 8
DRAW "E1G1F1"
PSET (469, 407), 7
DRAW "R1"
PSET (470, 417), 0
DRAW "u11r0d11"
PSET (468, 417), 0
DRAW "R2"
PSET (462, 412), 0
DRAW "E5G5F5"
PSET (468, 406), 0
DRAW "R2"
LINE (LINEHRZ, LINEVRT)-(LINEHRZ, LINEVRT), 0
FOR linego = 1 TO 5
LINEHRZ = LINEHRZ - 1
Xpos = LINEHRZ
Ypos = LINEVRT
IF LINEHRZ < 24 THEN
LINEHRZ = 24
Xpos = 24
DRAW "BR4"
END IF
DRAW "L1"
IF linego = 5 THEN
PSET (Xpos, Ypos), 3
DRAW "L0"
END IF
NEXT linego
FOR HOLD = 1 TO 8000
NEXT HOLD
REM === END OF PRESSED - IN - BUTTON LEFT =====
REM ==== START OF RELEASED BUTTON LEFT ========
LINE (454 - 1, 401 - 1)-(494 + 1, 421 + 1), 0, BF'BASEBOX
LINE (454, 401)-(494, 421), 7, BF    'BUTTNBODY
LINE (454, 401)-(494, 401 + 3), 15, BF   'TLIGHT
LINE (454, 401)-(454 + 3, 421), 15, BF     ' FHILIT
LINE (494, 401)-(494, 421), 8, BF     'BBSHADO
LINE (494 - 2, 401 + 1)-(494, 421), 8, BF   'BBSHADO3
LINE (494 - 3, 401 + 3)-(494, 421), 8, BF    'BBSHADO4
LINE (454 + 3, 421)-(494, 421), 8, BF     'SSHADO
LINE (454 + 2, 421 - 3)-(494, 421), 8, BF     'SSHADO2
LINE (454, 421 - 1)-(494, 421), 8, BF     'SSHADO4
PSET (460, 412), 15
DRAW "E5G5F5"
PSET (466, 407), 15
DRAW "R1"
PSET (467, 417), 0
DRAW "u11r0d11"
PSET (465, 417), 8
DRAW "R2"
PSET (459, 412), 0
DRAW "E5G5F5"
PSET (465, 406), 0
DRAW "R2"
MousePointer "On"
REM ===== END OF RELEASED BUTTON LEFT =========
END IF
IF mousex% > 498 AND mousex% < 538 AND mousey% > 387 AND mousey% < 407 AND MouseB% = 1 THEN
REM === START OF - IN - BUTTON UPGO ==========
MousePointer "Off"
LINE (498, 387)-(538, 407), 8, BF    'ACTBUTTN
LINE (498, 387)-(538, 387 + 2), 0, BF   'ACTTSHADO
LINE (498, 387)-(498 + 2, 407), 0, BF     'ACTFSHADO
LINE (538 - 4, 387)-(538, 407), 0, BF    'BBHLIT2
LINE (498, 407 - 4)-(538 - 1, 407), 0, BF   'WHATZIT
LINE (538, 387)-(538, 407), 4, BF     'BBHLIT'SIDE SLOT EDGE ULTRA HI-LIGHT
LINE (498, 407)-(538, 407), 4, BF      'SSHLIT4
PSET (518, 395), 7
DRAW "F3H3G5D2"
PSET (517, 394), 0
DRAW "G5D3R12U3H5"
PSET (513, 401), 0
DRAW "R10U2H2"
LINE (LINEHRZ, LINEVRT)-(LINEHRZ, LINEVRT), 0
FOR linego = 1 TO 5
LINEVRT = LINEVRT - 1
Xpos = LINEHRZ
Ypos = LINEVRT
IF LINEVRT < 47 THEN
LINEVRT = 47
Ypos = 47
DRAW "BD4"
END IF
DRAW "U1"
IF linego = 5 THEN
PSET (Xpos, Ypos), 3
DRAW "L0"
END IF
NEXT linego
FOR HOLD = 1 TO 8000
NEXT HOLD
REM === END OF PRESSED - IN - BUTTON UPGO =====
REM ==== START OF RELEASED BUTTON UPGO ========
LINE (498 - 1, 387 - 1)-(538 + 1, 407 + 1), 0, BF'BASEBOX
LINE (498, 387)-(538, 407), 7, BF    'BUTTNBODY
LINE (498, 387)-(538, 387 + 3), 15, BF   'TLIGHT
LINE (498, 387)-(498 + 3, 407), 15, BF     ' FHILIT
LINE (538, 387)-(538, 407), 8, BF     'BBSHADO
LINE (538 - 2, 387 + 1)-(538, 407), 8, BF   'BBSHADO3
LINE (538 - 3, 387 + 3)-(538, 407), 8, BF    'BBSHADO4
LINE (498 + 3, 407)-(538, 407), 8, BF     'SSHADO
LINE (498 + 2, 407 - 3)-(538, 407), 8, BF     'SSHADO2
LINE (498, 407 - 1)-(538, 407), 8, BF     'SSHADO4
PSET (518, 393), 15
DRAW "F3H3G5D2"
PSET (517, 392), 0
DRAW "G5D3R12U3H5"
PSET (513, 399), 8
DRAW "R10U2H2"
MousePointer "On"
REM ===== END OF RELEASED BUTTON UPGO =========
END IF
IF mousex% > 498 AND mousex% < 538 AND mousey% > 417 AND mousey% < 436 AND MouseB% = 1 THEN
REM === START OF - IN - BUTTON DOWNGO ==========
MousePointer "Off"
LINE (498, 417)-(538, 436), 8, BF    'ACTBUTTN
LINE (498, 417)-(538, 417 + 2), 0, BF   'ACTTSHADO
LINE (498, 417)-(498 + 2, 436), 0, BF     'ACTFSHADO
LINE (538 - 4, 417)-(538, 436), 0, BF    'BBHLIT2
LINE (498, 436 - 4)-(538 - 1, 436), 0, BF   'WHATZIT
LINE (538, 417)-(538, 436), 4, BF     'BBHLIT'SIDE SLOT EDGE ULTRA HI-LIGHT
LINE (498, 436)-(538, 436), 4, BF      'SSHLIT4
PSET (513, 425), 7
DRAW "U2R10D2"
PSET (517, 430), 0
DRAW "H5U3R12D3G5"
PSET (518, 430), 0
DRAW "E5U1"

LINE (LINEHRZ, LINEVRT)-(LINEHRZ, LINEVRT), 0
FOR linego = 1 TO 5
LINEVRT = LINEVRT + 1
Xpos = LINEHRZ
Ypos = LINEVRT
IF LINEVRT > 374 THEN
LINEVRT = 374
Ypos = 374
DRAW "BU4"
END IF
DRAW "D1"
IF linego = 5 THEN
PSET (Xpos, Ypos), 3
DRAW "L0"
END IF
NEXT linego
FOR HOLD = 1 TO 8000
NEXT HOLD
REM === END OF PRESSED - IN - BUTTON DOWNGO =====
REM ==== START OF RELEASED BUTTON DOWNGO ========
LINE (498 - 1, 417 - 1)-(538 + 1, 436 + 1), 0, BF'BASEBOX
LINE (498, 417)-(538, 436), 7, BF    'BUTTNBODY
LINE (498, 417)-(538, 417 + 3), 15, BF   'TLIGHT
LINE (498, 417)-(498 + 3, 436), 15, BF     ' FHILIT
LINE (538, 417)-(538, 436), 8, BF     'BBSHADO
LINE (538 - 2, 417 + 1)-(538, 436), 8, BF   'BBSHADO3
LINE (538 - 3, 417 + 3)-(538, 436), 8, BF    'BBSHADO4
LINE (498 + 3, 436)-(538, 436), 8, BF     'SSHADO
LINE (498 + 2, 436 - 3)-(538, 436), 8, BF     'SSHADO2
LINE (498, 436 - 1)-(538, 436), 8, BF     'SSHADO4
PSET (513, 427), 15
DRAW "U2R10D2"
PSET (517, 432), 0
DRAW "H5U3R12D3G5"
PSET (518, 432), 8
DRAW "E5U1"

MousePointer "On"
REM ===== END OF RELEASED BUTTON DOWNGO =========
END IF
IF mousex% > 543 AND mousex% < 583 AND mousey% > 401 AND mousey% < 421 AND MouseB% = 1 THEN
REM === START OF - IN - BUTTON RIGHTGO ==========
MousePointer "Off"
LINE (543, 401)-(583, 421), 8, BF    'ACTBUTTN
LINE (543, 401)-(583, 401 + 2), 0, BF   'ACTTSHADO
LINE (543, 401)-(543 + 2, 421), 0, BF     'ACTFSHADO
LINE (583 - 4, 401)-(583, 421), 0, BF    'BBHLIT2
LINE (543, 421 - 4)-(583 - 1, 421), 0, BF   'WHATZIT
LINE (583, 401)-(583, 421), 4, BF     'BBHLIT'SIDE SLOT EDGE ULTRA HI-LIGHT
LINE (543, 421)-(583, 421), 4, BF      'SSHLIT4
PSET (573, 412), 0
DRAW "H5F5G5"
PSET (568, 407), 7
DRAW "L1"
PSET (567, 416), 7
DRAW "U10"
PSET (566, 417), 0
DRAW "U11"
PSET (565, 417), 0
DRAW "L2"
PSET (574, 412), 0
DRAW "H5F5G5"
PSET (568, 406), 0
DRAW "L2"

LINE (LINEHRZ, LINEVRT)-(LINEHRZ, LINEVRT), 0
FOR linego = 1 TO 5
LINEHRZ = LINEHRZ + 1
Xpos = LINEHRZ
Ypos = LINEVRT
IF LINEHRZ > 605 THEN
LINEHRZ = 605
Xpos = 605
DRAW "BL4"
END IF
DRAW "R1"
IF linego = 5 THEN
PSET (Xpos, Ypos), 3
DRAW "L0"
END IF
NEXT linego
FOR HOLD = 1 TO 8000
NEXT HOLD
REM === END OF PRESSED - IN - BUTTON RIGHTGO =====
REM ==== START OF RELEASED BUTTON RIGHTGO ========
LINE (543 - 1, 401 - 1)-(583 + 1, 421 + 1), 0, BF'BASEBOX
LINE (543, 401)-(583, 421), 7, BF    'BUTTNBODY
LINE (543, 401)-(583, 401 + 3), 15, BF   'TLIGHT
LINE (543, 401)-(543 + 3, 421), 15, BF     ' FHILIT
LINE (583, 401)-(583, 421), 8, BF     'BBSHADO
LINE (583 - 2, 401 + 1)-(583, 421), 8, BF   'BBSHADO3
LINE (583 - 3, 401 + 3)-(583, 421), 8, BF    'BBSHADO4
LINE (543 + 3, 421)-(583, 421), 8, BF     'SSHADO
LINE (543 + 2, 421 - 3)-(583, 421), 8, BF     'SSHADO2
LINE (543, 421 - 1)-(583, 421), 8, BF     'SSHADO4
PSET (578, 412), 8
DRAW "H5F5G5"
PSET (577, 412), 8
DRAW "H5F5G5"
PSET (571, 407), 15
DRAW "L1"
PSET (570, 416), 15
DRAW "U10"
PSET (569, 417), 0
DRAW "U11"
PSET (572, 417), 0
DRAW "L2"
PSET (578, 412), 0
DRAW "H5F5G5"
PSET (572, 406), 0
DRAW "L2"

MousePointer "On"
REM ===== END OF RELEASED BUTTON RIGHTGO =========
END IF
 MousePointer "On"
IF mousex% > 18 AND mousex% < 39 AND mousey% > 410 AND mousey% < 433 AND MouseB% = 1 THEN
REM === START OF - IN - BUTTON CLEARIT ==========
MousePointer "Off"
LINE (18, 410)-(39, 433), 8, BF    'ACTBUTTN
LINE (18, 410)-(39, 410 + 2), 0, BF   'ACTTSHADO
LINE (18, 410)-(18 + 2, 433), 0, BF     'ACTFSHADO
LINE (39 - 4, 410)-(39, 433), 0, BF    'BBHLIT2
LINE (18, 433 - 4)-(39 - 1, 433), 0, BF   'WHATZIT
LINE (39, 410)-(39, 433), 4, BF     'BBHLIT'SIDE SLOT EDGE ULTRA HI-LIGHT
LINE (18, 433)-(39, 433), 4, BF      'SSHLIT4
FOR HOLD = 1 TO 8000
NEXT HOLD
REM ============== FLAT AREA - DRAWAREA ===========
LINE (21, 44)-(608, 376), 8, BF    'FLATAREA
REM ===== END OF FLAT AREA - DRAWAREA ========
REM === END OF PRESSED - IN - BUTTON CLEARIT =====
REM ==== START OF RELEASED BUTTON CLEARIT ========
LINE (18 - 1, 410 - 1)-(39 + 1, 433 + 1), 0, BF'BASEBOX
LINE (18, 410)-(39, 433), 7, BF    'BUTTNBODY
LINE (18, 410)-(39, 410 + 3), 15, BF   'TLIGHT
LINE (18, 410)-(18 + 3, 433), 15, BF     ' FHILIT
LINE (39, 410)-(39, 433), 8, BF     'BBSHADO
LINE (39 - 2, 410 + 1)-(39, 433), 8, BF   'BBSHADO3
LINE (39 - 3, 410 + 3)-(39, 433), 8, BF    'BBSHADO4
LINE (18 + 3, 433)-(39, 433), 8, BF     'SSHADO
LINE (18 + 2, 433 - 3)-(39, 433), 8, BF     'SSHADO2
LINE (18, 433 - 1)-(39, 433), 8, BF     'SSHADO4
MousePointer "On"
REM ===== END OF RELEASED BUTTON CLEARIT =========
END IF
IF mousex% > 18 AND mousex% < 48 AND mousey% > 16 AND mousey% < 38 AND MouseB% = 1 THEN
REM === START OF - IN - BUTTON QUIT ==========
QUIT = 1
MousePointer "Off"
LINE (18, 16)-(48, 38), 0, BF    'ACTBUTTN
LINE (18, 16)-(48, 16 + 2), 0, BF   'ACTTSHADO
LINE (18, 16)-(18 + 2, 38), 0, BF     'ACTFSHADO
LINE (48 - 4, 16)-(48, 38), 0, BF    'BBHLIT2
LINE (18, 38 - 4)-(48 - 1, 38), 0, BF   'WHATZIT
LINE (48, 16)-(48, 38), 4, BF     'BBHLIT'SIDE SLOT EDGE ULTRA HI-LIGHT
LINE (18, 38)-(48, 38), 4, BF      'SSHLIT4
LINE (28, 22)-(40, 34), 4, B
PSET (28, 22), 4
DRAW "F12H6G6E12G7H5F11"
LINE (27, 21)-(39, 33), 0, B
PSET (27, 21), 0
DRAW "F12H6G6E12"
FOR HOLD = 1 TO 7000
NEXT HOLD
REM === END OF PRESSED - IN - BUTTON QUIT =====
REM ==== START OF RELEASED BUTTON QUIT ========
LINE (18 - 1, 16 - 1)-(48 + 1, 38 + 1), 0, BF'BASEBOX
LINE (18, 16)-(48, 38), 4, BF    'BUTTNBODY
LINE (18, 16)-(48, 16 + 3), 12, BF   'TLIGHT
LINE (18, 16)-(18 + 3, 38), 12, BF     ' FHILIT
LINE (48, 16)-(48, 38), 8, BF     'BBSHADO
LINE (48 - 2, 16 + 1)-(48, 38), 0, BF   'BBSHADO3
LINE (48 - 3, 16 + 3)-(48, 38), 0, BF    'BBSHADO4
LINE (18 + 3, 38)-(48, 38), 0, BF     'SSHADO
LINE (18 + 2, 38 - 3)-(48, 38), 0, BF     'SSHADO2
LINE (18, 38 - 1)-(48, 38), 0, BF     'SSHADO4
LINE (28, 22)-(40, 34), 12, B
PSET (28, 22), 12
DRAW "F11H6G6E12G7H5F11"
LINE (27, 21)-(39, 33), 0, B
PSET (27, 21), 0
DRAW "F12H6G6E12"
MousePointer "On"
REM ===== END OF RELEASED BUTTON QUIT =========
END IF
LOOP WHILE QUIT <> 1
SYSTEM
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 
'컴컴횯ata for Mouse컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
DATA.Mouse:
DATA 55,8b,ec,56,57,8b,76,0c,8b,04,8b,76,0a,8b,1c,8b,76,08,8b,0c,8b,76,06,8b
DATA 14,cd,21,8b,76,0c,89,04,8b,76,0a,89,1c,8b,76,08,89,0c,8b,76,06,89,14,5f
DATA 5e,5d,ca,08,00
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

SUB LoadConfiguration
'컴컴훁hared Variables컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SHARED Mouse%()
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 
'컴컴훀ead DATA컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
RESTORE DATA.Mouse
DEF SEG = VARSEG(Mouse%(0))
 
FOR i% = 0 TO 52
 READ Byte$
 POKE VARPTR(Mouse%(0)) + i%, VAL("&H" + Byte$)
NEXT
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
'컴컴횯efine Mouse컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
MouseArea 0, 638, 0, 479
MouseSpeed 30
MouseSet 200, 100
MousePointer "On"
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
END SUB

SUB MouseArea (x1%, x2%, y1%, y2%)
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
R% = MouseInterr%(&H33, 7, 0, x1%, x2%)
R% = MouseInterr%(&H33, 8, bx%, y1%, y2%)
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
END SUB

FUNCTION MouseInterr% (num%, ax%, bx%, cx%, dx%)
'컴컴훁hared Variables컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SHARED Mouse%()
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
 IF Mouse%(0) = 0 THEN
  PRINT "Mouse error, program stopped"
  SYSTEM
 END IF

 DEF SEG = VARSEG(Mouse%(0))
 POKE VARPTR(Mouse%(0)) + 26, num%

 CALL ABSOLUTE(ax%, bx%, cx%, dx%, VARPTR(Mouse%(0)))

 MouseInterr% = ax%
END FUNCTION

SUB MousePointer (OnOrOff$)
'컴컴횾ointer On/Off컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SELECT CASE OnOrOff$
  CASE "On": R% = MouseInterr%(&H33, 1, bx%, cx%, dx%)
  CASE "Off": R% = MouseInterr%(&H33, 2, bx%, cx%, dx%)
END SELECT
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
END SUB

SUB MouseSet (x%, y%)
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
R% = MouseInterr%(&H33, 4, bx%, x%, y%)
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
END SUB

SUB MouseSpeed (Speed%)
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
'Speed 0 = extremly fast, Speed 100 = extremly slow
R% = MouseInterr%(&H33, 15, bx%, Speed%, Speed% * 2)
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
END SUB

SUB MouseWait
'컴컴훁hared Variables컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SHARED mousex%, mousey%, MouseB%
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

'컴컴횺ouseWait컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
OldMX% = mousex%
OldMY% = mousey%
OldMB% = MouseB%
WHILE OldMX% = mousex% AND OldMY% = mousey% AND OldMB% = MouseB%
  R% = MouseInterr%(&H33, 3, MouseB%, mousex%, mousey%)
WEND
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
END SUB

