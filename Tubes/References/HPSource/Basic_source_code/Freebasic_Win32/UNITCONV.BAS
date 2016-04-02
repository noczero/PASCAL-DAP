' Unit converter, for FreeBASIC, web: http://rudih.info

DIM result AS SINGLE
DIM num AS SINGLE
DIM conv AS Integer
Dim x As String

main:
CLS
PRINT "---Unit converter---"
PRINT "Enter conversion type, or <0> to quit:"
PRINT "<1>inch-centimetre <2>centimetre-inch <3>foot-metre <4>metre-foot"
PRINT "<5>mile-kilometre <6>kilometre-mile"
PRINT "<7>pound-kilogram <8>kilogram-pound <9>ounce-gram <10>gram-ounce"
PRINT "<11>acre-metre square <12>metre square-acre"
PRINT "<13>pint-litre <14>litre-pint"
PRINT "<15>fahrenheit-celsius <16>celsius-fahrenheit"
INPUT conv
IF conv = 0 OR conv > 16 THEN END
INPUT "Enter unit measure: ", num

IF conv = 1 THEN result = num * 2.54           'to cent
IF conv = 2 THEN result = num * .393           'to inch
IF conv = 3 THEN result = num * .348           'to met
IF conv = 4 THEN result = num * 3.28           'to foot
IF conv = 5 THEN result = num * 1.6093         'to mile
IF conv = 6 THEN result = num * .625           'to km
IF conv = 7 THEN result = num * .4536          'to pound
IF conv = 8 THEN result = num * 2.2075         'to kgram
IF conv = 9 THEN result = num * 28.3495        'to oz
IF conv = 10 THEN result = num / 28.3495       'to gram
IF conv = 11 THEN result = num * 4046.8        'to acre
IF conv = 12 THEN result = num / 4046.8        'to m2
IF conv = 13 THEN result = num * .568          'to litre
IF conv = 14 THEN result = num / .568          'to pint
IF conv = 15 THEN result = (num - 32) * 5 / 9  'to cel
IF conv = 16 THEN result = (num * 9 / 5) + 32  'to fah
PRINT "Result = ", result
PRINT "Press any key to continue..."
x = ""
WHILE x = ""
  x = INKEY$
WEND
GOTO main:

