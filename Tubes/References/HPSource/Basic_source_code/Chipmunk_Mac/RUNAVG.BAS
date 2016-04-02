5 'Running average, for Chipmunk BASIC, web: http://rudih.info
10 usernumber = 0
20 PRINT "---Running average---"
30 DO WHILE (usernumber >= 0)
40    INPUT "Enter number or -1 to stop: ", usernumber
50    count = count + 1
60    total = total + usernumber
70    answer = total / count
80    PRINT answer
90 LOOP

