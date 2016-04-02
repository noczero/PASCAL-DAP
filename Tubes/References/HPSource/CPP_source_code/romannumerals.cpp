// Justin C. Miller
// 3-30-2001
// made for: http://www.geocities.com/neonprimetime.geo/index.html
// made on: Microsoft Visual C++ 6.0
// Title: scope again
// scope operator::

// FIGURE OUT WHAT THE OUTPUT SHOULD BE
// the answers are below

#include <iostream.h>

void function() ;

int i = 76 ;

int main(){
	cout << i << endl ;
	int i = 5 ;
	cout << i << endl ;
	cout << ::i << endl ;  // grabs the local variable
	::i = 67 ;  // adjust the local variable
	cout << i << endl ;
	function() ;
	cout << ::i << endl ;
	return 0 ;
}

void function(){
	cout << i << endl ;
	i = 23 ;
}

// OUTPUT IS THIS....IN THIS ORDER!
// 76, 5, 76, 5, 67, 23