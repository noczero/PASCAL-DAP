// Justin C. Miller
// for http://www.geocities.com/neonprimetime.geo/index.html
// 4-11-2001
// on Borland Builder 4.0
// Title : creating a calendar
// prints a calendar from
// reference date to user's date

#include <iostream.h>
#include <conio.h>

// sunday = 1, monday = 2, .... , friday = 7
int first_day = 4 ;  // wednesday
const int reference_month = 1 ;
const int reference_year = 1999 ;
char * monthNames[13] = {"" , "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"} ;

int getInteger() ;
int getUserMonth() ;
int getUserYear() ;
void printCalendar(int) ;


int main(){
        int final_year = getUserYear() ;
        int final_month = getUserMonth() ;

        int month = reference_month ;
        int year = reference_year ;
        cout << "Year: " << year << endl ;
        while(true){
                if(year == final_year && month == final_month)
                        break ;
                printCalendar(month) ;
                if(month == 12){
                        cout << "Year: " << year << endl ;
                        year++ ;
                        month = 1 ;
                }
                else
                        month++ ;
        }
        getch() ;
        return 0 ;
}

int getUserMonth(){
        cout << "Please enter the month to stop at..." ;
        return getInteger() ;
}

int getUserYear()  {
        cout << "Please enter the year to stop at..." ;
        return getInteger() ;
}

int getInteger(){
        int x ;
        cin >> x ;
        return x;
}

void printCalendar(int month){
        int days = 31 ;
        if(month == 2)
                days = 28 ;
        else if(month == 4 || month == 6 || month == 9 || month == 11)
                days = 30 ;

        cout << monthNames[month] << endl ;

        for(int j = 0 ; j <= first_day ; j++)
                cout << " " ;
        for(int i = 1 ; i <= days ; i++){
                cout << i << " " ;
                if((i + first_day) % 7 == 0)
                        cout << endl ;
        }
        cout << endl ;
        first_day = (days + first_day) % 7 + 1 ;
}
