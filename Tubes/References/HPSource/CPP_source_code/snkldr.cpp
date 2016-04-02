/*
Andrew Banas
text based snakes and ladders
*/

#include <cstdio>
#include <ctime>
#include <cstdlib>
using namespace std;

int main(int argc, char **argv){
//int main(){
        char kbuffer[4]; //keyboard buffer
        register int counter;
        register short int step;
        short int dest[100]; //destination
        register short int pos = 0; // current position
        //default destination = postion
        for(counter=99; counter>=0; --counter){
                dest[counter] = counter;
        }
        //special positions
        //destination > position --> ladder
        //destination < position --> snake
        //snakes
        dest[97] = 77;
        dest[94] = 74;
        dest[92] = 72;
        dest[86] = 23;
        dest[63] = 59;
        dest[61] = 18;
        dest[55] = 52;
        dest[48] = 10;
        dest[46] = 25;
        dest[15] = 5;
        
        dest[79] = 99;
        dest[70] = 90;
        dest[50] = 66;
        dest[35] = 43;
        dest[20] = 41;
        dest[27] = 83;
        dest[8] = 30;
        dest[3] = 14;
        dest[0] = 37;
        
        
        srand(time(NULL));
        //initial position
        step = (rand()%6 + 1);
        pos = dest[step - 1];
        counter = 0;
        printf("%d\tdice = %d\t position = %d\n", counter, step, pos);
        fgets(kbuffer,2,stdin);
        
        while(step != 99){
                counter ++;
                step = (rand()%6 + 1);
                pos += step;
                if(pos > 99)pos = 198 - pos; //backward for beyond end
                pos = dest[pos]; //apply position rule
                printf("%d\tdice = %d\t position = %d\n", counter, step, pos);
                step = pos;
                fgets(kbuffer,2,stdin);
        }
        printf("done in %d throws\n", counter);
        fgets(kbuffer,2,stdin);
}
