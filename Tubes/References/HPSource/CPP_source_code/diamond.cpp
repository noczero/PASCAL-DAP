// Justin C. Miller
// 3-27-2001
// made for: http://www.geocities.com/neonprimetime.geo/index.html
// made on: Unix Lab g++ compiler
// Title : creating a diamond shape
// Description: simple diamond shape using * 's 

#include <iostream.h>
#include <iomanip.h>

int main(){
	int i , j ;
	int maxWidth = 11 ; // max width of the diamond
	
	// top half of diamond
	for(i = 0 ; i < (maxWidth/2 + 1) ; i++){
		for(j = i ; j < (maxWidth/2) ; j++)    // used to align, putting in spaces
			cout << " " ;
		for(j = 1 ; j <= (i*2 + 1) ; j++)  // puts in the actual astericks
			cout << "*" ;
		cout << endl ;
	}

	// bottom half of diamond
	for(i = (maxWidth/2) ; i > 0 ; i--){
		for(j = (maxWidth/2 + 1) ; j > i ; j--)  // used to align, putting in spaces
			cout << " " ;
		for(j = (i*2 - 1) ; j > 0 ; j--) // puts in the actual astericks
			cout << "*" ;
		cout << endl ;
	}

	cout << endl ;

	// PUTTING THE 2 HALVES TOGETHER!!!
	for(i = 0 ; i < maxWidth ; i++){
		if(i <= (maxWidth/2)){
			for(j = i ; j < (maxWidth/2) ; j++)    // used to align, putting in spaces
                       		cout << " " ;
                	for(j =	 1 ; j <= (i*2 + 1) ; j++)  // puts in the actual astericks
                       		 cout << "*" ;
                	cout << endl ; 
		}
		else{
               		for(j = (maxWidth/2 + 1) ; j > (maxWidth-i) ; j--)  // used to align, putting in spaces
               	        	cout << " " ;
                	for(j = ((maxWidth-i)*2 - 1) ; j > 0 ; j--) // puts in the actual astericks
                        	cout << "*" ;
                	cout << endl ;
		}    
	}

	return 0 ;
}
   
