
//Assumes:Needs improved error checking of values that are not numerical
//
//Side Effects:none known so far.
//This code is copyrighted and has limited warranties.
//Please see http://www.Planet-Source-Code.com/xq/ASP/txtCodeId.5371/lngWId.3/qx/vb/scripts/ShowCode.htm
//for details.
//**************************************

// Program by: Anthony Bernardino
// Class & Section: Cosci506 -- Section 0277
// Lab 7bb ---- Date: 12/07/2002
// file enters number one at a time from a textfile
// the numbers are entered into an array
// the high number is determined
// the low number is determined
// the average number is determined
// the odd numbers are determined
// the even numbers are determined
// the values greater than the average of both odd and even arrays are determined
// the program uses three functions -- see prototypes below.
// please use MS VISUAL C++ TO RUN THE Program
#include <iostream.h>
#include <fstream.h> 
#include <windows.h>
void high(int array[], int count);		// prototype to get high of even numbers 
void low(int array[], int count);		// prototype to get high of odd numbers
int average(int array[], int count);	// prototype to get and return average
int main(void)


    {
    				///////////////////////////////////////////////////////
    				// filename declaration and information
    				///////////////////////////////////////////////////////
    	
    	fstream file;
    	char ch, filename [81];
    	cout << "Input File Processing.\n\n";
    	cout << "Please follow instructions carefully. The program prompts for your input file.\n\n";
    	cout << "The Program runs under certain conditions.\n";
    	cout << "\t 1.) The test numbers in your input file are greater than zero\n";
    	cout << "\t 2.) The test numbers in your input file are not negative numbers.\n";
    	cout << "\t 3.) The test numbers in your input file are \n\t\tactual numbers, i.e. 1,2,3 etc..\n";
    	cout << "If you enter an invalid path or an invalid file, the program will EXIT.\n";
    	cout << "A VALID filename is -- Example: c:\\test.dat \n\n";
    	cout << "You must enter your filename in the location you have it saved as.\n";
    	cout << "Enter a file name: ";
    	cin >> filename;
    	cout << "\n\n\n";
    	
    	file.open (filename, ios::in);
    	
    	if (!file)


        	{
        		cout << filename << "could not be opened.\n\n";
        		cout << filename << "Please re-execute the program.\n\n";
        		exit(0);
        	}
        				///////////////////////////////////////////////////////
        				// ARRAY DECLARATION
        				///////////////////////////////////////////////////////
        	
        		int n[1000]; // array to hold all numbers (maximum of 1,000 elements)
        		
        				///////////////////////////////////////////////////////
        				// Get all numbers and store into N.
        				///////////////////////////////////////////////////////
        		int count = 1;
        		for (int x = 1; (!file.eof()); x++)


            		{
            			file >> n[x];
            			file.ignore();// ignore any characters that could be represented as zero
            			
            			if (n[x] < - 10000) // if number being read looks off, make it zero
            				n[x] = 0;// if number being read looks off, make it zero
            								// remember to minus zero when averaging
            			if (n[x] > 0)
            				cout << "Confirmed Number read into Program -- " << n[x] << "\n";
            						//////////////////////////////////////////////
            			count++;	//
            		}				//	This count will hold the number of times
            						// data was read into the array
            						//
            						//////////////////////////////////////////////
            					
            						//////////////////////////////////////////////
            		file.close();	// close file that you just read
            						//////////////////////////////////////////////
            		//////////////////////////////////////////////
            		//
            		// how many numbers were read into the array?
            		//
            		//////////////////////////////////////////////
            		
            		cout << "\n\n";
            		cout << "Now checking for ODD OR EVEN numbers in the array ... \n\n";
            				///////////////////////////////////////////////////////
            				// check for odd or even
            				///////////////////////////////////////////////////////
            								////////////////////////////////////////////////
            		int NumExchange = 0;	// Value to read into integer from initial array
            								////////////////////////////////////////////////
            		int even [500]; 
            		int odd [500];
            		int x1a = 1;
            		int x1b = 1;
            		for (int x1 = 1; x1 < count; x1++)


                		{
                			NumExchange = n[x1];
                			
                			// cout << "\t";
                			// cout << "NumExchange --> " << NumExchange << "\tTracing use only.\n";
                			if (NumExchange % 2 == 0)


                    			{
                    				even[x1a] = NumExchange;	// Enter Even Numbers into Even Array
                    			}
                    			else if (NumExchange % 2 != 0)


                        			{
                        				odd[x1b] = NumExchange;	// Enter Odd Numbers into Odd Array
                        			}							/////////////////////////////////
                        			NumExchange = 0;			// reset exchange 
                        			x1a++;						/////////////////////////////////
                        			x1b++;
                        	
                        		}
                        		
                        				///////////////////////////////////////////////////////
                        				//	
                        				// what's in your array .... 
                        				//	Note: Numbers that are less than 0 are set to 0;
                        				//		 The FOR LOOP below checks the arrays for 
                        				// invalid numbers.
                        				//		 invalid numbers are less than 0.
                        				//
                        				///////////////////////////////////////////////////////
                        		cout << "Even Numbers: " << "\n";
                        		cout << " --> ";
                        		for (int x2 = 1; x2 < count; x2++)


                            		{
                            			if (even[x2] < 0)
                            				even[x2] = 0;
                            			
                            			
                            			if (even[x2] == 0)
                            				cout << ""; // Don't Print out Zeroes.
                            			else


                                			{
                                				cout << even[x2] ;
                                				cout << " | ";
                                			}
                                		
                                		}
                                		
                                		cout << "\n\n";
                                		cout << "Odd Numbers: " << "\n";
                                		cout << " --> ";
                                		for (int x3 = 1; x3 < count; x3++)


                                    		{
                                    			if (odd[x3] < 0)
                                    				odd[x3] = 0;
                                    			
                                    			
                                    			if (odd[x3] == 0)
                                    				cout << ""; // Don't Print out Zeroes.
                                    			else


                                        			{
                                        				cout << odd[x3] ;
                                        				cout << " | ";
                                        			}
                                        		
                                        		}
                                        		cout << "\n\n";
                                        				//////////////////////////////////////////////////////
                                        				//
                                        				//	Even and Odd Arrays hold the data from here on.
                                        				//
                                        				//
                                        				//////////////////////////////////////////////////////
                                        			////////////////////////////////////////////
                                        			//	CALL HIGH FUNCTION TO GET HIGH NUMBER
                                        			////////////////////////////////////////////
                                        			high(even, count);
                                        			high(odd, count);
                                        			
                                        			////////////////////////////////////////////
                                        			//	CALL LOW FUNCTION TO GET LOW NUMBER
                                        			////////////////////////////////////////////
                                        			low(even,count);
                                        			low(odd,count);
                                        			////////////////////////////////////////////
                                        			//	CALL AVERAGE FUNCTION TO GET AVERAGE NUMBER
                                        			////////////////////////////////////////////
                                        			
                                        			cout << "Average for Even Number Set is " << average(even,count);
                                        			
                                        			
                                        			cout << "\n\n";
                                        			cout << "Average for Odd Number Set is " << average(odd, count);
                                        			
                                        			cout << "\n\n";
                                        			
                                        			/////////////////////////////////////////////////////////////////
                                        			// Get Numbers greater than Average, and use Average Function
                                        			/////////////////////////////////////////////////////////////////
                                        				/////////////////////////////////////////////////////////////
                                        				// EVEN NUMBERS ANALYSIS FOR NUMBERS GREATER THAN AVERAGE 
                                        				/////////////////////////////////////////////////////////////
                                        			cout << "Even numbers that are greater than the average: \n";
                                        			cout << " --> ";
                                        			for (int x7 = 1; x7 < count; x7++)


                                            			{
                                            				if (even[x7] > average(even,count))
                                            					cout << even[x7] << " | ";
                                            			}
                                            			cout << "\n\n";
                                            				/////////////////////////////////////////////////////////////
                                            				// ODD NUMBERS ANALYSIS FOR NUMBERS GREATER THAN AVERAGE 
                                            				/////////////////////////////////////////////////////////////
                                            			cout << "Odd numbers that are greater than the average: \n";
                                            			cout << " --> ";
                                            			for (int x8 = 1; x8 < count; x8++)


                                                			{
                                                				if (odd[x8] > average(odd,count))
                                                					cout << odd[x8] << " | ";
                                                			}
                                                			cout << "\n\n";
                                            }
                                            	
                                            void high(int array[], int count)


                                                {	int highval = 0;
                                                	int exchange;
                                                	int temp;
                                                	int countval = count;
                                                	////////////////////////////////////////////////////
                                                	// 
                                                	// SORT ARRAY WITH HIGHEST VALUE SET TO ELEMENT 1
                                                	// 
                                                	////////////////////////////////////////////////////
                                                	do


                                                    	{
                                                    		exchange = 0;
                                                    		for (int n = 1; n < (count-1); n++)


                                                        		{
                                                        			if (array[n] < array[n+1])


                                                            			{
                                                            				temp = array[n];
                                                            				array[n] = array[n+1];
                                                            				array[n+1]=temp;
                                                            				exchange = 1;
                                                            			}
                                                            			
                                                            		}
                                                            	}while (exchange !=0);
                                                            	//////////////////////////////////////////////////
                                                            	//
                                                            	//	Print out the highest value
                                                            	//
                                                            	//////////////////////////////////////////////////
                                                            	
                                                            	highval = array[1];
                                                            	if ((highval%2) == 0)
                                                            	cout << "Highest Value of Even Numbers is " << highval <<"." << "\n\n";
                                                            	if ((highval%2) !=0)
                                                            	cout << "Highest Value of Odd Numbers is " << highval <<"." << "\n\n";
                                                        }
                                                        void low(int array[], int count)


                                                            {	int lowval = 0;
                                                            	int exchange;
                                                            	int temp;
                                                            	int countval = count;
                                                            	////////////////////////////////////////////////////
                                                            	// 
                                                            	// SORT ARRAY WITH LOWEST VALUE SET TO ELEMENT 1
                                                            	// 
                                                            	////////////////////////////////////////////////////
                                                            	do


                                                                	{
                                                                		exchange = 0;
                                                                		for (int n = 1; n < (count-1); n++)


                                                                    		{
                                                                    			if ((array[n] > array[n+1]) && (array[n] != 0) && (array[n+1] !=0)) 


                                                                        			{
                                                                        				temp = array[n];
                                                                        				array[n] = array[n+1];
                                                                        				array[n+1]=temp;
                                                                        				exchange = 1;
                                                                        			}
                                                                        			
                                                                        		}
                                                                        	}while (exchange !=0);
                                                                        	//////////////////////////////////////////////////
                                                                        	//
                                                                        	//	Print out the Lowest value
                                                                        	//
                                                                        	//////////////////////////////////////////////////
                                                                        		
                                                                        	
                                                                        	lowval = array[1];
                                                                        	if ((lowval%2) == 0)
                                                                        	cout << "Lowest Value of Even Numbers is " << lowval <<"."<< "\n\n";
                                                                        	if ((lowval%2) !=0)
                                                                        	cout << "Lowest Value of Odd Numbers is " << lowval <<"."<< "\n\n";
                                                                        	
                                                                    }
                                                                    			////////////////////////////////////////////
                                                                    			//
                                                                    			//	FUNCTION TO GET AVERAGE NUMBER
                                                                    			//
                                                                    			////////////////////////////////////////////
                                                                    int average(int array[], int count)


                                                                        {	int marker = 0;	// counter to use as divisor
                                                                        	int total = 0;	// total for numbers read
                                                                        	int avg = 0;	// end result
                                                                        	/////////////////////////////////////////////////
                                                                        	//	LOOP TO READ ARRAY AND AGGREGATE NUMBERS > 0
                                                                        	/////////////////////////////////////////////////
                                                                        	for (int i=1; i < count; i++)


                                                                            	{
                                                                            		if (array[i] > 0)


                                                                                		{
                                                                                			total += array[i];
                                                                                			marker++;
                                                                                			
                                                                                		}
                                                                                		
                                                                                	}
                                                                                	/////////////////////////////////////////////////////////
                                                                                	//	CALCULATE AVERAGE OF THE TOTAL DIVIDIED BY DIVISOR
                                                                                	/////////////////////////////////////////////////////////
                                                                                	avg = total / marker;
                                                                                	return avg; // return the average of the array
                                                                                	
                                                                            }

		
