' this little hangman game by Jim Emptage
' Rouge Valley Software
' 1997
' 75504.2526@compuserve.com
' feel free to modify the program .... have fun
66
RESTORE
REDIM fred(200) AS STRING
FOR p = 1 TO 200
  READ fred(p)
NEXT
RANDOMIZE TIMER
FOR jj = 1 TO 1000                                ' shuffle the words in the array
  nn = 1 + (RND * 199)
  nnn = 1 + (RND * 199)
  IF nn <> nnn THEN SWAP fred(nn), fred(nnn)
NEXT
wcnt = 0
start:
wcnt = wcnt + 1
IF wcnt = 201 THEN GOTO 66
w$ = fred(wcnt)
CLS
SCREEN 13
COLOR 1
LOCATE 1, 24
PRINT "Rouge Valley"
LOCATE 2, 24
PRINT "  Hangman"
LOCATE 4, 24
PRINT "[Number Key]"
LOCATE 5, 24
PRINT "  To Exit"
'A-Z = asc 65 to 90
COLOR 15
LOCATE 12, 22
PRINT "Wins:   "; wins;
LOCATE 13, 22
PRINT "Losses: "; losses;

x = 105
y = 45
FOR xp = 0 TO 160 STEP 2                          ' little background effect
  FOR yp = 0 TO 160 STEP 2
    clr = 200 + ((ABS(xp - 80) + ABS(yp - 80)) MOD 45)
    PSET (xp, yp), clr
  NEXT
NEXT
'LINE (0, 0)-(160, 160), 8, BF
LINE (0, 0)-(160, 160), 6, B
LINE (x - 80, y - 30)-(x - 80, y + 95), 2         ' start of scaffold
LINE (x - 100, y + 95)-(x - 60, y + 95), 2
LINE (x - 80, y - 30)-(x, y - 30), 2
LINE (x, y - 18)-(x, y - 30), 7                   ' end of scaffold

w$ = UCASE$(w$)
lw = LEN(w$)
REDIM letters(65 TO 90) AS INTEGER                ' 65 to 90 is the ascii range for A to Z
m = 0                                             ' used this array to record letters tried
h$ = STRING$(lw, " ")
COLOR 88
LOCATE 22, 1
PRINT STRING$(lw, "*");
COLOR 15
DO
2
  DO
  LOOP WHILE INKEY$ <> ""
  c$ = UCASE$(INPUT$(1))
  IF c$ >= "1" AND c$ <= "9" THEN GOTO 56
  IF c$ < "A" OR c$ > "Z" THEN
    SOUND 40, 4
    GOTO 2
  END IF
  IF letters(ASC(c$)) <> 1 THEN
    letters(ASC(c$)) = 1
    IF INSTR(w$, c$) > 0 THEN
      FOR ll = 1 TO LEN(w$)
        IF MID$(w$, ll, 1) = c$ THEN
          LOCATE 22, ll
          PRINT c$;
          MID$(h$, ll) = c$
          IF h$ = w$ THEN
            wins = wins + 1
            COLOR 15
            LOCATE 12, 22
            PRINT "Wins:   "; wins
            LOCATE 24, 1
            COLOR 13
            PRINT "You Got It!!";
            COLOR 15
            GOTO 55
          END IF
        END IF
      NEXT
    ELSE
      m = m + 1
      GOSUB drawhim
      IF m = 6 THEN
        COLOR 10
        LOCATE 23, 1
        PRINT w$;
        losses = losses + 1
        COLOR 15
        LOCATE 13, 22
        PRINT "Losses: "; losses
        LOCATE 25, 1
        COLOR 13
        PRINT "Dead Man Hanging!!";
        COLOR 15
        GOTO 55
      END IF
    END IF
  ELSE
    COLOR 13
    LOCATE 24, 1
    PRINT "ALREADY TRIED: "; c$;
    SLEEP 1
    COLOR 0
    LOCATE 24, 1
    PRINT "                  ";
    COLOR 15
  END IF
LOOP
55
SLEEP 8
GOTO start
56
END
drawhim:
SELECT CASE m
  CASE 1
    CIRCLE (x, y), 20, 14                         ' start of head
    CIRCLE (x - 7, y - 5), 4, 14
    CIRCLE (x + 7, y - 5), 4, 14
    CIRCLE (x, y + 2), 2, 14
    LINE (x - 8, y + 9)-(x + 8, y + 9), 14
    PAINT (x - 9, y - 9), 4, 14
    PAINT (x - 7, y - 5), 1, 14
    PAINT (x + 7, y - 5), 1, 14                   ' end of head
  CASE 2
    LINE (x, y + 18)-(x, y + 58), 14
  CASE 3
    LINE (x, y + 58)-(x - 20, y + 88), 14         ' leg
  CASE 4
    LINE (x, y + 58)-(x + 20, y + 88), 14         ' leg
  CASE 5
    LINE (x, y + 38)-(x - 20, y + 28), 14         ' arm
  CASE 6
    LINE (x, y + 38)-(x + 20, y + 28), 14         ' arm
END SELECT
RETURN
' 200 random words from a 190,000 word list are listed here
' develop your own lists of words, perhaps by theme
' you could add a routine to randomly pick words from a large file as I did
' i did not include the large word data file so as to save space
DATA "primordial"
DATA "lasting"
DATA "sandlotter"
DATA "northeasterner"
DATA "umbilicus"
DATA "corroder"
DATA "hallucinogenic"
DATA "autonomic"
DATA "assurances"
DATA "sensualities"
DATA "meadowlands"
DATA "assaulted"
DATA "kinkiest"
DATA "rediscoveries"
DATA "yeshivoth"
DATA "towelled"
DATA "devaluation"
DATA "violoncellos"
DATA "mislead"
DATA "eyeglasses"
DATA "dither"
DATA "glowing"
DATA "legislatress"
DATA "incompressibility"
DATA "heretic"
DATA "envy"
DATA "homburgs"
DATA "fleabags"
DATA "mountings"
DATA "pledgers"
DATA "frighting"
DATA "greased"
DATA "multifunction"
DATA "unthroning"
DATA "stringing"
DATA "humphed"
DATA "reconsolidating"
DATA "heighten"
DATA "seismometric"
DATA "closest"
DATA "arose"
DATA "stethoscopically"
DATA "obsequy"
DATA "rumoring"
DATA "wrenched"
DATA "rescheduling"
DATA "unsatiable"
DATA "pollster"
DATA "possession"
DATA "disallowing"
DATA "thanklessly"
DATA "syntactical"
DATA "contingence"
DATA "excoriating"
DATA "corpulently"
DATA "versatilely"
DATA "snuggling"
DATA "refractures"
DATA "grasshoppers"
DATA "snippy"
DATA "gildhall"
DATA "interferences"
DATA "anoxic"
DATA "devalue"
DATA "perique"
DATA "timeserving"
DATA "topologies"
DATA "perpetual"
DATA "cognisance"
DATA "obsequiousness"
DATA "nationalist"
DATA "blastier"
DATA "zombie"
DATA "barbarianism"
DATA "flirtatiousness"
DATA "housesits"
DATA "triggered"
DATA "hydroelectricity"
DATA "impressionists"
DATA "extra"
DATA "praseodymium"
DATA "liberalized"
DATA "tuber"
DATA "haltered"
DATA "detoxication"
DATA "cytologists"
DATA "incipiencies"
DATA "roundabout"
DATA "armer"
DATA "stockpot"
DATA "overcompensate"
DATA "sentimentalist"
DATA "director"
DATA "affiliation"
DATA "nonpreservable"
DATA "paged"
DATA "dined"
DATA "reminiscent"
DATA "miscreants"
DATA "forayed"
DATA "untested"
DATA "caravel"
DATA "trystes"
DATA "tensiometer"
DATA "wetbacks"
DATA "immunogenetics"
DATA "motorcycles"
DATA "chorister"
DATA "weekly"
DATA "vibrations"
DATA "easies"
DATA "cherish"
DATA "anthropologic"
DATA "malapertly"
DATA "sisters"
DATA "pottering"
DATA "moldering"
DATA "oneness"
DATA "woolsorter"
DATA "millivolts"
DATA "overdevelopment"
DATA "skidways"
DATA "renews"
DATA "deliverance"
DATA "respecter"
DATA "drones"
DATA "iiaaeeuuttnnss"
DATA "peaceful"
DATA "deadline"
DATA "perturbs"
DATA "radiographer"
DATA "arrowed"
DATA "misfiling"
DATA "assort"
DATA "kinetic"
DATA "gazelles"
DATA "recenter"
DATA "hankered"
DATA "speedboat"
DATA "moveability"
DATA "sachems"
DATA "taurus"
DATA "sightseeing"
DATA "hypochondriasis"
DATA "rectifier"
DATA "animality"
DATA "conservationism"
DATA "eyehooks"
DATA "librettos"
DATA "unworkably"
DATA "stultify"
DATA "intercalations"
DATA "tabouret"
DATA "gerontologies"
DATA "marquess"
DATA "whiskeys"
DATA "occurred"
DATA "lingered"
DATA "luxury"
DATA "killjoy"
DATA "imprecator"
DATA "chickweeds"
DATA "earflaps"
DATA "horoscopes"
DATA "reimpose"
DATA "parimutuel"
DATA "overdone"
DATA "reequipping"
DATA "schoolmistresses"
DATA "jubilant"
DATA "upsurges"
DATA "mackerel"
DATA "belonging"
DATA "bagwig"
DATA "recharged"
DATA "moola"
DATA "glamorizes"
DATA "cosecant"
DATA "interrupting"
DATA "instantaneous"
DATA "cancers"
DATA "busts"
DATA "gyromagnetic"
DATA "treatise"
DATA "befallen"
DATA "faceless"
DATA "subrules"
DATA "decisively"
DATA "snorted"
DATA "emaciated"
DATA "succours"
DATA "pedicab"
DATA "stickman"
DATA "refried"
DATA "friendship"
DATA "holiday"
DATA "french"
DATA "vacation"
DATA "mondays"
DATA "trainer"

