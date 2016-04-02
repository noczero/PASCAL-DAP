// *****************************************
//        cplusplus language tutorial
//                section 3.1
//
//          "One-way swapping sort"
// Shows:
//   - arrays
//   - arrays as function parameters
//   - get size of arrays
//
// Briefing:
//  The program sorts a series of numbers.
//  The sorting method used is to
//  repetitively swap list items, the
//  higher ones to the end, the lowers to
//  the beginning until the list is sorted.
// *****************************************

#include <iostream.h>

void SwapMembers (int items[], int index1, int index2)
{
	int temp;
	temp=items[index1];
	items[index1]=items[index2];
	items[index2]=temp;
}

main ()
{
	int n,m;
    int numbers [] = {102,21,83,42,11,10,9,3,20,27,15,92,2};

	// now a trick to get the number of items in an ARRAY:
	// divide the size of the array by the size of one of its members:
	const int size = sizeof(numbers) / sizeof(numbers[0]);

	// n: specifies the location in the array that has to be adequately set,
	//    starting from the end (the greater)
	// m: each iteration of m stores in position n the greater number found
	//    form position 0 to position n.
	for (n=size-1; n>0; n--)
		for (m=0; m<n; m++)
			if ( numbers[m] > numbers[m+1] )
				SwapMembers (numbers, m, m+1 );

	// Output the sequence
	for (n=0;n<size;n++)
		cout << numbers[n] << ", ";

	return 0;
}