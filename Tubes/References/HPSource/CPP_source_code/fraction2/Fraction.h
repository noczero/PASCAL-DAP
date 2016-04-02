//--------------------------------------------------------------
//
// F R A C T I O N  C L A S S
//
// F R A C T I O N . H
//
// Version 1.1, Copyright (C) 2001, by Daniel Pronych
//
// FREEDOM to USE and DISTRIBUTE is LIMITED ONLY TO THE
// EDITTING OF THIS TITLE ON THIS, and ALL ACCOMPANYING FILES.
// THIS FILE IS PLACED INTO PUBLIC DOMAIN in hopes that it
// might be found useful for others.  It is not FORCEFULLY 
// placed into public domain but with consent from the AUTHOR.
//
// C L A S S  D E S C R I P T I O N
// --------------------------------
//
// This file, declares the functions declared in Fraction.cpp 
// and must not be separated from it, lest it stop functioning 
// and benefit no one.
//
// This Fraction class allows extreme flexibility in working
// with fractions.  When a fraction is declared and the user
// and or client program implements a fraction with a negative
// denominator this class quickly distributes it to both the
// numinator and denominator to keep with what one would 
// normally do with Fractions in a Math class.  Operators are
// defined to work with extreme ease for the user of this class.
// A Reduce fraction is included to allow the user to use to
// simply the fraction that they are dealing with.
//
// Have fun with this class!
//--------------------------------------------------------------

/* 
	Note: If main program has not defined BIGGEST_INT declare 
	it here so that the program may be run without error or 
	complaint. The below may be changed from int to whatever
	classification of integer that the client wants to accept
	the Fraction as.
*/

#ifndef BIGGEST_INT 
	#define BIGGEST_INT int
#endif

#ifndef _FRACTION_
#define _FRACTION_

enum { 
	FRAC_ADD, FRAC_SUB, FRAC_MUL, FRAC_DIV 
};

class Fraction
{
	public:
   		Fraction(); // Constructor
		~Fraction(); // Deconstructor

		void SetNum(BIGGEST_INT newnum); // Set Numerator (Do only within program)
		void SetDen(BIGGEST_INT newden); // Set Denominator (Do only within program)
		
		void SetAll(int Fracnum); // Asks for user to input values for the numerator and denominator to the program (Do only when wanting the user to provide values for the Fraction)

		BIGGEST_INT Num(); // Returns Numerator of given Fraction
		BIGGEST_INT Den(); // Returns Denominator of given Fraction

		void Fraction::Reduce(); // Simplifies Fraction to it's lowest terms
		void Fraction::DisplayMixed(); // Displays the mixed value of the given fraction to the screen

		float FracDecVal(Fraction a); // Returns the value of the Fraction's numerator divided by Fraction's denominator

		BIGGEST_INT Fraction::GCD(int num1, int remainder); // Reduces the whole Fraction to 'lowest possible terms'

		Fraction Fraction::operator +(Fraction c); // Allows user to do a += for a set of Fractions
		Fraction Fraction::operator -(Fraction c); // Allows user to do a -= for a set of Fractions
		Fraction Fraction::operator *(Fraction c); // Allows user to do a *= for a set of Fractions
		Fraction Fraction::operator /(Fraction c); // Allows user to do a /= for a set of Fractions

		Fraction_Do_Op(int operation, Fraction a, Fraction b); // Does the given operation on the given Fractions

		BIGGEST_INT num; // Numerator of Fraction
		BIGGEST_INT den; // Denominator of Fraction
};



#include "Fraction.cpp"
#endif
