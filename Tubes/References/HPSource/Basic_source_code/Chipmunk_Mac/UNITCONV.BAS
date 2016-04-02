10 'Unit converter, for Chipmunk BASIC, web: http://rudih.info
15  CLS
20  PRINT "---Unit converter---"
30  PRINT "Enter conversion type, or <0> to quit:"
40  PRINT "<1>inch-centimetre <2>centimetre-inch <3>foot-metre <4>metre-foot"
50  PRINT "<5>mile-kilometre <6>kilometre-mile"
60  PRINT "<7>pound-kilogram <8>kilogram-pound <9>ounce-gram <10>gram-ounce"
70  PRINT "<11>acre-metre square <12>metre square-acre"
80  PRINT "<13>pint-litre <14>litre-pint"
90  PRINT "<15>fahrenheit-celsius <16>celsius-fahrenheit"
100 INPUT conv
110 IF conv = 0 OR conv > 16 THEN END
120 INPUT "Enter unit measure: ", num
130 IF conv = 1 THEN result = num * 2.54           'to cent
140 IF conv = 2 THEN result = num * .393           'to inch
150 IF conv = 3 THEN result = num * .348           'to met
160 IF conv = 4 THEN result = num * 3.28           'to foot
170 IF conv = 5 THEN result = num * 1.6093         'to mile
180 IF conv = 6 THEN result = num * .625           'to km
190 IF conv = 7 THEN result = num * .4536          'to pound
200 IF conv = 8 THEN result = num * 2.2075         'to kgram
210 IF conv = 9 THEN result = num * 28.3495        'to oz
220 IF conv = 10 THEN result = num / 28.3495       'to gram
230 IF conv = 11 THEN result = num * 4046.8        'to acre
240 IF conv = 12 THEN result = num / 4046.8        'to m2
250 IF conv = 13 THEN result = num * .568          'to litre
260 IF conv = 14 THEN result = num / .568          'to pint
270 IF conv = 15 THEN result = (num - 32) * 5 / 9  'to cel
280 IF conv = 16 THEN result = (num * 9 / 5) + 32  'to fah
290 PRINT "Result = ", result
300 x$ = ""
310 WHILE x$ = ""
320   x$ = INKEY$
330 WEND
340 GOTO 15

