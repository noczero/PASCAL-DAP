100 rem Chipmunk Basic 3.5.x random file i/o example
110 '
190 rem create record type variable
200 type tt
210   s1 as string *10 : rem 10 char max string
220   s2 as string *4 : rem 4 char max string
230   i as integer : rem 16-bit integer
240   j as longint : rem 32-bit integer
250   x as double : rem floating point
260 end type
270 '
280 dim a as tt : rem create typed var a
290 '
300 open "foo" for random as #1 len = len(a)
380 '
390 rem initialize file (otherwise reads will return junk)
400 for i = 1 to 10
410   a.s1 = str$(i)+"X"+str$(i)
420   a.s2 = str$(int(i/2))
430   a.i = 48*256+59-i
440   a.j = i
450   a.x = 1/i
470   put #1,i,a : rem write typed var a into file
480 next i
490 '
500 rem write a random record
510 a.s1 = "44Y44" : a.s2 = "newnew"
520 a.i = -4 : a.j = -4 : a.x = -pi
530 put #1,4,a : rem write record #4
580 close #1
590 '
600 rem some read random records
610 open "foo" for random as #1 len = len(a)
620 dim bbb as tt, ccc as tt  : rem create typed vars aaa and ccc
630 get #1,6,bbb : rem read record 6 into type var b
640 print 6, bbb.s1, bbb.s2, len(bbb.s2),
650 print bbb.i, bbb.j, bbb.x
690 '
710 get #1,4,ccc
720 print 4, ccc.s1, ccc.s2, len(ccc.s2),
730 print ccc.i, ccc.j, ccc.x
900 '
910 close #1
990 end

