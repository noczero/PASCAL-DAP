/* Abraham Ishaq  */


/* This program allows the user to enter to fraction and then.
   the program will print the fraction added together and reduced */


#include<iostream.h>


void ReadFraction(int &Num, int &Denom, int &Num2, int &Denom2)
/* This function will allow the user to enter two fraction. */
{
        cout << "Enter the numerator for the first fraction: ";
        cin >> Num;
        cout << "Enter the denominator for the first fraction: ";
        cin >> Denom;
        cout << endl;
        cout << "Enter the numerator for the second fraction: ";
        cin >> Num2;
        cout << "Enter the denominator for the second fraction: ";
        cin >> Denom2;
        cout << endl;
        
}


//-------------------------------------------------------------------


void Reduce(int &Num, int &Denom, int &Num2, int &Denom2)
/* This function is called after ReadFraction(). This function will 
   reduce the two fractions.
   Pre: Two Fractions
   Post: Two reduced fractions */
{
        int a, b, c, d, i, j = 0;
        
        a = Denom;
        b = Num;
        c = Denom2;
        d = Num2;


        for (i = a * b; i > 1; i--)
        {
                if ((a % i == 0) && (b % i == 0))
                {
                        a /= i;
                        b /= i;
                }
        }
        
        for (j = 50; j > 1; j--)
        {
                if ((c % j == 0) && (d % j == 0))
                {
                        c /= j;
                        d /= j;
                }
        }
        
        Denom = a;
        Num = b;
        Denom2 = c;
        Num2 = d;

}


//-------------------------------------------------------------------


void Reduce(int &Num, int &Denom)
/* This function is called from AddFraction(). The fraction added in 
   AddFraction() is reduced here.
   Pre: One fraction added from two
   Post: A reduced fraction  */
{
        int a = 0;
        int b = 0;
        int i = 0;


        a = Denom;
        b = Num;


        for (i = 50; i > 1; i--)
        {
                if ((a % i == 0) && (b % i == 0))
                {
                        a /= i;
                        b /= i;
                }
        }


        Denom = a;
        Num = b;
}


//-------------------------------------------------------------------


void AddFraction(int &Num, int &Denom, int &Num2, int &Denom2)
/* This function is called after Reduce. This function adds the two 
   fractions Reduce() reduced
   Pre: Two Fractions
   Post: One reduced fraction  */
{
        if (Denom != Denom2) 
        {


                Num = Num * Denom2;
                Num2 = Num2 * Denom;
                Denom = Denom * Denom2;
                Denom2 = Denom2 * Denom;
                Num = Num + Num2;
        }
        else
        {
                Num = Num + Num2;
        }
        
        Reduce(Num, Denom);
}


//-------------------------------------------------------------------


void DisplayFraction(int &Num, int &Denom)
/* This function displays the reduced and added fraction. This 
   function is called after AddFraction()
   Post: Prints fraction */
{
        cout << "The reduced and added fraction is " << Num << "/" << Denom << endl;
}


//-------------------------------------------------------------------


int main()
{
        char an;
        
        do
        {
                int Num, Denom, Num2, Denom2 = 0;

                ReadFraction(Num, Denom,Num2,Denom2);
                Reduce(Num, Denom, Num2, Denom2);
                AddFraction(Num, Denom, Num2, Denom2);
                DisplayFraction(Num, Denom);
                cout << endl;
                
                cout <<"Would you like to do another fraction? ";
                cin >> an;
                cout << endl;
        } while ((an == 'y') || (an == 'Y'));


        return(0);
}
