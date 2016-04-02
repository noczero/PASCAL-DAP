1 ' 			contributed by H. Kaplan <hmk@nadn.navy.mil>
2 '
100 ' This file contains a sub called matinv which takes inverse of a square
110 ' matrix by the famous complete-pivoting method of Gauss, using the
120 ' condensed tableau familiar from linear programming.  The first argument
130 ' is the matrix to be inverted.  The second is the answer.  The others
140 ' are merely local variables and local arrays.
150 '
160 ' Also, the file contains a main program to show how good Gauss's method
170 ' is.  It takes a random edge size and a random square matrix and calls
180 ' the matinv sub.  Then the result is tested in the most obvious way, by
190 ' multiplying back and subtracting off the identity matrix.  The biggest
200 ' (in absolute value) entry is then found.  The print statement finally
210 ' shows the edge size and the biggest absolute value.
220 '
230 ' Yes, matrix inversions take time; the time required is proportional
240 ' to the cube of the edge size.  Gauss's method take more time than
250 ' most, but it is worth it.
260 '
270 randomize timer
280 let n = int(50*rnd(1))+1
290 dim x(n,n)
300 dim y(n,n)
310 '
320 for j = 1 to n
330 '
340 for eye = 1 to n
350 let x(eye,j) = rnd(1)
360 next eye
370 '
380 next j
390 '
400 call matinv(x,y)
410 mat y = y*x
420 '
430 for eye = 1 to n
440 let y(eye,eye) = y(eye,eye)-1
450 next eye
460 '
470 let big = 0
480 '
490 for eye = 1 to n
500 '
510 for j = 1 to n
520 let t = abs(y(eye,j))
530 if t > big then let big = t
540 next j
550 '
560 next eye
570 '
580 print n,big
590 end
600 '
610 ' 
620 sub matinv(inmatrix,answer,work,ins,outs,edge,eye,k,big,j,a,prow,pcol,t)
630 let edge = ubound(inmatrix,1)' Get the edge-size.
640 dim work(edge,edge)' Dimension the work area.
650 dim ins(edge)' Dimension the in-labels array.
660 dim outs(edge)' Dimension the out-labels array.
670 mat work = inmatrix ' Load the work area.
680 '  
690 for eye = 1 to edge ' Begin labels loop.
700 let ins(eye) = +eye ' Initialize in-labels.
710 let outs(eye) = -eye ' Initialize out-labels.
720 next eye ' End of labels loop.
730 ' 
740 for k = 1 to edge ' Begin outer loop.
750 let big = 0 ' The biggest pivot (in absolute value) seen so far.
760 ' 
770 for eye = 1 to edge ' Begin row search loop.
780 '
790 if outs(eye) < 0
800 rem This row is not used yet.
810 ' 
820 for j = 1 to edge ' Begin column search loop.
830 '
840 if ins(j) > 0
850 rem This column is not used yet.
860 let a = abs(work(eye,j))' Try another pivot.
870 '
880 if a > big
890 rem It is the biggest so far.
900 let big = a ' Yes.
910 let prow = eye ' Copy its row.
920 let pcol = j ' Copy its column.
930 endif
940 '
950 endif
960 '
970 next j ' End of column search loop.
980 '
990 endif
1000 ' 
1010 next eye ' End of row search loop.
1020 ' 
1030 if big = 0
1040 rem We failed to find a pivot.
1050 print "Bad matrix." : ' We failed.  Print diagnostic.
1060 stop " Bomb out."
1070 endif
1080 ' 
1090 for eye = 1 to edge ' For other
1100 '
1110 if eye <> prow
1120 rem rows
1130 ' 
1140 for j = 1 to edge ' and other
1150 '
1160 if j <> pcol
1170 rem columns,
1180 let work(eye,j) = work(eye,j)-work(eye,pcol)*work(prow,j)/work(prow,pcol)' pivot.
1190 endif
1200 '
1210 next j
1220 ' 
1230 endif
1240 '
1250 next eye
1260 '
1270 for eye = 1 to edge ' In the pivot column.
1280 '
1290 if eye <> prow
1300 rem but not at the pivot itself.
1310 let work(eye,pcol) = -work(eye,pcol)/work(prow,pcol)' pivot.
1320 endif
1330 '
1340 next eye
1350 ' 
1360 for j = 1 to edge ' In the pivot row,
1370 '
1380 if j <> pcol
1390 rem but not at the pivot itself,
1400 let work(prow,j) = work(prow,j)/work(prow,pcol)' pivot.
1410 endif
1420 '
1430 next j
1440 ' 
1450 let work(prow,pcol) = 1/work(prow,pcol)' Finally the pivot itself.
1460 let t = ins(pcol)' Exchange
1470 let ins(pcol) = outs(prow)' the row and column
1480 let outs(prow) = t ' labels.
1490 next k ' End of outer loop.
1500 ' 
1510 for eye = 1 to edge ' Beginning of
1520 '  
1530 for j = 1 to edge ' permutation loop.
1540 let answer(eye,j) = work(-ins(eye),+outs(j))' Permute into answer.
1550 next j ' Ending of
1560 '  
1570 next eye ' permutation loop.
1580 ' 
1590 end sub ' And we are done.
9990 end

