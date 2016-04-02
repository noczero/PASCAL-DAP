1 ' 	example contributed by H. Kaplan <hmk@nadn.navy.mil>
2 '
100 ' The famous sieve of Eratosthenes, using the modern features of
110 ' Chipmunk Basic.  This program is written as crudely as possible,
120 ' so as to make the algorithm obvious.
130 '
140 dim f(10000) : ' marks, 0 for prime and 1 for composite
150 '
160 let a = timer : ' starting time
170 let p = 0 ' no primes found yet
180 mat f = 0 ' no number is known to be composite, at first
190 let n = ubound(f) : ' how many marks there are
200 '
210 for j = 2 to n ' 1 cannot be a prime
220 '
230 if f(j) = 0
240 let p = p+1 ' one more prime
250 ' print j : ' suppress printing so as to time the program
260 '
270 for k = j+j to n step j ' mark the numbers divisible by j
280 let f(k) = 1 ' k is composite
290 next k
300 '
310 endif
320 '
330 next j
340 '
350 let b = timer : ' stopping time
360 print
370 print "It took ";b-a;"seconds to find ";p;"primes out of ";n;"numbers."
380 end
