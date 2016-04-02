//Copyrights Jules Roman B. Polidario
//If you want to edit or use this application as a part of another program,
//please ask permission first and for what purpose...
//And please include my name as well as the original copyright holder in this code
//if you want to edit this after gaining permission. Other than that, enjoy! ^_^
//jrpolidario@yahoo.com

//note that the intro-animation is just self-made. No such group specifically
//"A Careless Production" nor "Bahay Kubo Studios" have ever been a part of this program
//Everything is made by me.

#include <iostream>
#include <windows.h>
#include <fstream>
#include <cstdlib>
#include <string>

using namespace std;

/*--------------------Global Variables---------------------*/
void new_game(), game_defaults(), load_game(), intro_animation();
void cmd_list(), cmd_set_a(), cmd_set_b(), cmd_set_c(), cmd_set_d();
void main_header(), main_screen(), hacking_screen(), decoding_screen(), security_screen(), trial_screen();
void day_off(), hack_house(), hack_bank(), hack_company(), hack_legal(), go_bank(), go_shop(), go_underground(), save_game(), go_help();
int char_intro, game_week; string name;
int lawyer;
int connect_success;
int placeselected;
float guilty_chance, total_guilty_chance; double hand_money, bank_money, weekly_expenses, fortune_money_weekly;
float choice_chance;
float random_money; float money_multiplier;
int folder=0; string dl_file_house[10000], dl_file_bank[10000], dl_file_company[10000];
int random_id;
string bank_choice, bank_name_choice, bank_name, bank_account_name[1100]; int bank_account_id;
string company_name_choice, company_name, tar_company; int company_quest;
int rndmfile, specialfile1, specialfile2, jokefile1, jokefile2, rndmfolder, rndmfolder_val, specialvpn, key_file, key_file_retry;
int shop_retry, house_retry, uground_retry, bank_retry, charity_retry, company_retry, legal_retry;
int cpu_speed, cpu_speed_reset, cpu_hacktime, cpu_hacktime_reset, cpu_item;
float criminal_chance; int hack_attempts;
int cpu_warning;
int chance_val;

/*--------------Command List--------------*/
int f_connect;
int f_open;
int f_exit;
int f_dir;
int f_decode;
int f_help;
int f_find;
int f_info;
int emerg_dc;
int zap_fwall;
int keydecode;
int meltdown;
/*---------------Underground List--------*/
int f_find_allow;
int f_info_allow;
int emerg_dc_allow;
int zap_fwall_allow;
int keydecode_allow;
int meltdown_allow;
/*----------------SHOP LIST--------------*/
int p3_allow;
int p4_allow;
int pdc_allow;
int icd_allow;
int c2q_allow;
int super_allow;
int fwallbreaker_allow;
int vpn_allow;

int accessory11, accessory11_counter;
int accessory12;


int main ()
{
    while (1)
    {
          intro_animation();
          system("cls");
            cout << "...,                 ....  :s,    ;ssssssssss: r; .siiiiiiiiiir  .rssssssssss: " << endl;
            cout << ";  ,.                :  ;  5@:    @@@@@@@@@@@s @@ r@@@@@@@@@@@@, B@@@@@@@@@@@@ " << endl;
            cout << "r  ::               ,;  r  3@;    s92225S22XG, @@ H@GsSX@@sSS@@2 @@srsssssiS@@;" << endl;
            cout << "r  ;:               ,r ,r  2@:         @2      @@ h@    @&    @i @@         A@," << endl;
            cout << "r..r:               .i.:s  5@:         @A      @# 9@    @#   ,@s @@@@@@@@@@@@@," << endl;
            cout << "r,,i:                S:;s  5@,         @M      @# h@.   @@   ,@s @@::;;;;;;:#@," << endl;
            cout << "s;;5:...............,2;iS  S@&riSSS5;  @#      @# &@.   @@   ,@s @H         S@:" << endl;
            cout << "r;rri2XXXXXXXXXXXX25Srris  2@@@@@@@@@  @@      @@ B@:   @@   :@5 @@         A@;" << endl;
            cout << ".                          ,5iiiiiSXs  2r      5r :9.   5i    X, is         :3." << endl;
            cout << "S9GGM###@@@@@@@@@####AGMX                                                      " << endl;
            cout << "5AA@;               ,#B@X  :2222222i  3HHGAH#G H5     :@ .&AHAGGABH 2BMMHAAAHMs" << endl;
            cout << "2AH@                 @#@X  @@3hGGG#@ ;@#BMMM@3 @G     @@ ;@A39999A2 @@X9333399A" << endl;
            cout << "2M#@.                @@@3  @2     s@ :@        @#:;r;r@. :@,        M#        H" << endl;
            cout << "X#@@,                @@@9  @@@@@@@@@ :@        @@@@@@@@  ,@@@@@@@@@ A@@@@@@@@@&" << endl;
            cout << "X@@@,                @@@G  @r     :@ :@        @3     @s ,@         @M       @r" << endl;
            cout << "&@@@;  .     ,       @@@#  @i     :@ :@@@@@@@@ @A     @@ ,@@@@@@@@@ @@       M@" << endl;
            cout << "r;;i  .@@@#  H@S     r;r:  2.     .X  i22222X; S:      h  iiiSSSS2r r;        i" << endl;
            cout << "        ;@@@i .@@:                                                             " << endl;
            cout << "          r@@@  r@@X3332Sis;           ;:        .sr r;:::,....     ,::;;;rrr;"  << endl;
            cout << "            X@@M         2@@@s         #@@      :@@r @@@@@@@@@@@   i@@@@@@@@@@9" << endl;
            cout << "              #@@@AAh25i    @@@@@@@@.   G@@    r@@.  .:;:::::r@@   X@i      r@M" << endl;
            cout << "               ,hHBB@@@@@S               h@@  5@@     A@@@@@@@@#   s@        @A" << endl;
            cout << "                      r@@@@@@@@@@@@@@@@i  H@@2@@       .     ,@@   s@r      ,@A" << endl;
            cout << "                        i#@@@@@@@@@@@@@@H; i@@G     .@@@@@@@@@@h @r @@@@@@@@@@r" << endl << endl;
/*-------------------MENU---------------------------*/
          string menu_choice;
          cout << endl << "\t\t[]----==Ultima_Hacker_Version_3.0==----[]" << endl;
          cout << "\t\t|                                       |" << endl;
          cout << "\t\t|   [1] New Game                        |" << endl;
          cout << "\t\t|   [2] Load Game                       |" << endl;
          cout << "\t\t|   [0] Exit                            |" << endl;
          cout << "\t\t|                                       |" << endl;
          cout << "\t\t[]----=============================----[]" << endl << endl;
          cout << "\t\tEnter your choice: ";
          cin >> menu_choice;
          if (menu_choice == "1")
          {
             new_game();
          }
          else if (menu_choice == "2")
          {
             load_game();
          }
          else if (menu_choice == "0")
          {
               return EXIT_SUCCESS;
          }
          else  
          {
               cout << "WRONG CHOICE OF NUMBER. TRY AGAIN" << endl;
               system ("pause");
          }
          
    }
}

/*---------------------------Functions----------------------------------------*/
/*-----------------Intro Animation---------*/
void intro_animation()
{
    Sleep(500);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" <<"  0  " << endl;
    cout << "\t\t" << " <[>  " << endl;
    cout << "\t\t" << " / \\  " << endl;
    Sleep(1500);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "   0  " << endl;
    cout << "\t\t" << " <[>  " << endl;
    cout << "\t\t" << " / \\  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "\ 0  " << endl;
    cout << "\t\t" << " :[>  " << endl;
    cout << "\t\t" << " / \\  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "  0 /  " << endl;
    cout << "\t\t" << " <]:  " << endl;
    cout << "\t\t" << " / |  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "  0  " << endl;
    cout << "\t\t" << "  [:  " << endl;
    cout << "\t\t" << "  |\\  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "    0  " << endl;
    cout << "\t\t" << "  ;['  " << endl;
    cout << "\t\t" << "  /|  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "      0  " << endl;
    cout << "\t\t" << "    :[:  " << endl;
    cout << "\t\t" << "    /\\  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "         0  " << endl;
    cout << "\t\t" << "        ;['  " << endl;
    cout << "\t\t" << "        /|  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "            0  " << endl;
    cout << "\t\t" << "           ;[=  " << endl;
    cout << "\t\t" << "           />  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "                0  " << endl;
    cout << "\t\t" << "               ;[=  " << endl;
    cout << "\t\t" << "                l>  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "                   0  " << endl;
    cout << "\t\t" << "                  :['  " << endl;
    cout << "\t\t" << "                   />  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "                     0           ==  " << endl;
    cout << "\t\t" << "                     ;]=  " << endl;
    cout << "\t\t" << "                      \\>  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "                       \\0/      [><]  " << endl;
    cout << "\t\t" << "                        {]:  " << endl;
    cout << "\t\t" << "                         \\\\  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "                          \\0/  [<><>]  " << endl;
    cout << "\t\t" << "                           {]  O    O  " << endl;
    cout << "\t\t" << "                           \\\\  " << endl;
    Sleep(300);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "                      .' ';\\([ < > < > ]  " << endl;
    cout << "\t\t" << "                      ,' :' /[ --===-- ]  " << endl;
    cout << "\t\t" << "                     ' ; ;{./()       ()  " << endl;
    Sleep(1500);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << "  __      __   __   ___  ___ _   ___  __   __  " << endl;
    cout << "\t\t" << " //\\\\   //    //\\\\  |__\\ |_  |   |_  /__  /__" << endl;
    cout << "\t\t" << "//  \\\\  \\\\__ //  \\\\ | \\\\ |__ |__ |__ __// __//" << endl;
    cout << "\t\t" << "  " << endl;
    cout << "\t\t" << "               P R O D U C T I O N  " << endl;
    Sleep(2000);
    system("cls");
    cout << endl << endl << endl << endl;
    cout << "\t\t" << " B>  A  :_:  A   \\y/     K_/  : :  B>  /o\\  " << endl;
    cout << "\t\t" << " B> / \\ :h: / \\   :      K \\  U_U  B>  \\o/  " << endl;
    cout << "\t\t" << "  " << endl;
    cout << "\t\t" << "                 S T U D I O S  " << endl;
    Sleep(2000);
    system("cls");
    cout << endl << endl << endl << endl << endl << endl << endl;
    cout << "\t\t" << "PLEASE MAXIMIZE THIS APPLICATION FIRST" << endl << endl;
    cout << "\t\t" << "TO ENJOY MAXIMUM EXPERIENCE. THANK YOU" << endl << endl << endl;
    cout << "\t\t";
    system("pause");
}
void game_defaults()
{
    folder=0;
    cpu_item=0;
    game_week=1;
    shop_retry=1;
    house_retry=1;
    uground_retry=1;
    bank_retry=1;
    company_retry=1;
    legal_retry=1;
    charity_retry=1;
    criminal_chance=0;
    hack_attempts=0;
    connect_success=0;
    lawyer=false;
    key_file_retry = true;
    company_quest = 0;
    /*------COMMANDS------*/
    f_connect=true;
    f_open=true;
    f_exit=true;
    f_dir=true;
    f_decode=true;
    f_help=true;
    f_find=false;
    f_info=false;
    emerg_dc=false;
    zap_fwall=false;
    keydecode=false;
    meltdown=false;
    /*------------------*/
}
/*-----------------New Game----------------*/
void new_game()
{
    game_defaults();
    string hacker_choice;
    srand(time(NULL));
    system("cls");
    cout << endl << "\t\t\t\tCHARACTERS:" <<endl << endl;
    cout << "\t[1] Congressman Buch \n\t(lower chance of being court guilty, high starting money, \n\tfew knowledge on commands)" << endl <<endl;
    cout << "\t[2] Devious Hashim \n\t(mediocre chance of being court guilty, mediocre starting money, \n\tmediocre knowledge on commands)" << endl << endl;
    cout << "\t[3] Inhumane Rex \n\t(higher chance of being court guilty, mediocre starting money, \n\thigh knowledge on commands)" << endl << endl;
    cout << "\t[4] School Girl Yui \n\t(lowest chance of being court guilty, low starting money, \n\tmediocre knowledge on commands)" << endl << endl << endl;
    cout << "\tSELECT YOUR HACKER: ";
    cin >> hacker_choice;
    
    if (hacker_choice == "1")
    {
        guilty_chance = 12;
        hand_money = 8000;
        bank_money = 2000;
        cmd_set_a();
        char_intro=1;
        name = "BUCH";
    }
    else if (hacker_choice == "2")
    {
        guilty_chance = 17;
        hand_money = 6000;
        bank_money = 0;
        cmd_set_b();
        char_intro=2;
        name = "HASHIM";
    }
    else if (hacker_choice == "3")
    {
        guilty_chance = 25;
        hand_money = 6500;
        bank_money = 0;
        cmd_set_c();
        char_intro=3;
        name = "REX";
    }
    else if (hacker_choice == "4")
    {
        guilty_chance = 5;
        hand_money = 2500;
        bank_money = 0;
        cmd_set_d();
        char_intro=4;
        name = "YUI";
    }
    else
    {
        cout << endl << "You've entered a wrong choice!" << endl;
        system("pause");
        system("cls");
        new_game();
    }
    /*---------------------Game Intro---------------*/
    system("cls");
    if (char_intro == 1)
    {
        cout << "/-----------------------------------------------------------------------------/" << endl
             << "You are a Congressman who is bored from all the activities and duties you have." << endl
             << "Tired from all the work, you decided to research about underground hacking and its basics." << endl
             << "This is the start of your reign towards becoming the Ultimate Hacker!" << endl;
    }
    if (char_intro == 2)
    {
        cout << "/-----------------------------------------------------------------------------/" << endl
             << "You are a retired terrorist from the ever popular" << endl
             << "and ever mighty Denla Bin movement." << endl
             << "You've become tired of all the fighting" << endl
             << "but still inhabited the hacking tricks you've learned from the group." << endl
             << "This is the start of your reign towards becoming the Ultimate Hacker!" << endl;
    }
    if (char_intro == 3)
    {
        cout << "/-----------------------------------------------------------------------------/" << endl
             << "You are the feared inhumane beast of the Zoviak Gang." << endl
             << "You enjoyed spending a fifth of your day doing anything, while the rest" << endl
             << "doing stuffs related to computer, and learning codes and tricks for your pleasure." << endl
             << "This is the start of your reign towards becoming the Ultimate Hacker!" << endl;
    }
    if (char_intro == 4)
    {
        cout << "/-----------------------------------------------------------------------------/" << endl
             << "You are the cutest gal of the Institute of Tokyo High." << endl
             << "Despite your lovable personality, you've become interested" << endl
             << "in the language of hacking." << endl
             << "This is the start of your reign towards becoming the Ultimate Hacker!" << endl;
    }
    system ("pause");
    system ("cls");
    main_screen();
}
/*-----------------Load Game---------------*/
void load_game()
{
    system("cls");
    char file_in[50];
    ifstream myload;
    string tempload[30];
    cout << "Enter the name of the file to load(file extension not included): ";
    cin >> file_in;
    myload.open(file_in);
    if (myload.fail())
    {
        cout << "There is no such file... Please Try Again." << endl;
        system("pause");
        main();
    }
    int i;
    for (i=0; i<30; i++)
    {
        getline (myload, tempload[i], '\n');
    }
    /*----Start of Loaded Variables----*/
    game_defaults();
    name = tempload[1];
    hand_money = atoi(tempload[2].c_str());
    bank_money = atoi(tempload[3].c_str());
    lawyer = atoi(tempload[4].c_str());
    game_week = atoi(tempload[5].c_str());
    hack_attempts = atoi(tempload[6].c_str());
    guilty_chance = atoi(tempload[7].c_str());
    criminal_chance = atoi(tempload[8].c_str());
    weekly_expenses = atoi(tempload[9].c_str());
    key_file_retry = atoi(tempload[10].c_str());
    cpu_item = atoi(tempload[11].c_str());
    cpu_speed = atoi(tempload[12].c_str());
    cpu_hacktime = atoi(tempload[13].c_str());
    company_quest = atoi(tempload[14].c_str());
    tar_company = tempload[15];
    fortune_money_weekly = atoi(tempload[16].c_str());
    f_find = atoi(tempload[17].c_str());
    f_info = atoi(tempload[18].c_str());
    emerg_dc = atoi(tempload[19].c_str());
    zap_fwall = atoi(tempload[20].c_str());
    keydecode = atoi(tempload[21].c_str());
    meltdown = atoi(tempload[22].c_str());
    accessory11 = atoi(tempload[23].c_str());
    accessory12 = atoi(tempload[24].c_str());
    cpu_speed_reset = atoi(tempload[25].c_str());
    cpu_hacktime_reset = atoi(tempload[26].c_str());
    /*----End of Loaded Variables----*/
    cout << "...G A M E   L O A D E D..." << endl;
    system("pause");
    main_screen();
}

/*****************************************************************************/
/*--------------Main Screen---------------*/
void main_screen()
{
    string main_choice;
    while (1)
    {
        srand(time(NULL));
        system("cls");
        if (hand_money < 0)
        {
            cout << "DON'T Let your MONEY be negative!" << endl;
            cout << "**YOU lose 1/10 of all the money you have" << endl;
            cout << "**DUE to the sickness you get from not eating food!" << endl << endl;
            if (hand_money + bank_money < 0)
            {
                hand_money += (hand_money + bank_money)/10;
            }
            else
            {
                hand_money -= (hand_money + bank_money)/10;
            }
            system("pause");
        }
        system ("cls");
        main_header();
        chance_val = rand()%100;
        string donealready = "You've already selected that choice. Try again next week.";
        cout <<"=---------------" << "+===========================================+-----------------=" << endl;
        cout <<" []==========[] " << "|| What do you want to do?                 ||      \\\\\\\\\\\\\\\\\\\\\\|" << endl;
        cout <<" ||          || " << "||                                         ||       \\\\\\\\\\\\\\\\\\\\|" << endl
             <<" || _ULTIMA_ || " << "||  [1] Hack a random house(low firewall)  ||        \\\\\\\\\\\\\\\\\\|" << endl
             <<" || |-|aCker || " << "||  [2] Hack a bank (medium firewall)      ||         \\\\\\\\\\\\\\\\|" << endl
             <<" ||  \\/ 3.0  || "<< "||  [3] Hack a company (high firewall)     ||          \\\\\\\\\\\\\\|" << endl
             <<" ||          || " << "||  [4] Hacking job from the government    ||           \\\\\\\\\\\\|" << endl
             <<" []==========[] " << "||  [5] Go to a bank                       ||            \\\\\\\\\\|" << endl
             <<"   ____||____   " << "||  [6] Go to computer shop                ||             \\\\\\\\|" << endl
             <<"  /::::::::::\\  "<< "||  [7] Go Underground                     ||              \\\\\\|" << endl
             <<" /::::::::::::\\ "<< "||                                         ||               \\\\|" << endl
             <<"|\               " << "||  [8] END WEEK                           ||                \\|" << endl
             <<"|\\\              " << "||  [9] SAVE GAME                          ||                 |" << endl
             <<"|\\\\\             " << "||  [99] HELP!                             ||                 |" << endl
             <<"|\\\\\\\            " << "||  [0] EXIT TO MAIN SCREEN                ||                /|" << endl
             <<"=---------------" << "+===========================================+-----------------=" << endl;
        cout <<"                " << "    Choice: ";
        cin >> main_choice;
        if (main_choice == "1")
        {
            if (house_retry == 1)
            {
                system("cls");
                hack_house();
            }
            else
            {
                cout << donealready << endl;
                system("pause");
            }
        }
        else if (main_choice == "2")
        {
            if (bank_retry == 1)
            {
                system("cls");
                hack_bank();
            }
            else
            {
                cout << donealready << endl;
                system("pause");
            }
        }
        else if (main_choice == "3")
        {
            if (company_retry == 1)
            {
                system("cls");
                hack_company();
            }
            else
            {
                cout << donealready << endl;
                system("pause");
            }
        }
        else if (main_choice == "4")
        {
            if (legal_retry == 1)
            {
                system("cls");
                hack_legal();
            }
            else
            {
                cout << donealready << endl;
                system("pause");
            }
        }
        else if (main_choice == "5")
        {
            system("cls");
            go_bank();
        }
        else if (main_choice == "6")
        {
            if (shop_retry == 1)
            {
                go_shop();
            }
            else
            {
                cout << donealready << endl;
                system("pause");
            }
        }
        else if (main_choice == "7")
        {
            if (uground_retry == 1)
            {
                go_underground();
            }
            else
            {
                cout << donealready << endl;
                system("pause");
            }
        }
        else if (main_choice == "8")
        {
            if (hand_money < 0)
            {
                while (1)
                {
                    char game_over;
                    cout << "You cannot end a turn with a negative MONEY!" << endl;
                    cout << "Do you want to forfeit your goal towards" << endl
                         << "becoming the ULTIMATE HACKER(game over)(y/n)?";
                    cin >> game_over;
                    if (game_over=='y'||game_over=='Y')
                    {
                        cout << endl << endl << endl << endl;
                        cout << "\t" << "G A M E" << endl << endl;
                        cout << "\t" << "     O V E R" << endl << endl << endl << endl;
                        system("pause");
                        system("cls");
                        main();
                    }
                    else if (game_over=='n'||game_over=='N')
                    {
                        main_screen();
                    }
                    else
                    {
                        cout << endl << "YOU'VE ENTERED A WRONG LETTER!" << endl << endl;
                    }
                }
            }
            chance_val = rand()%100;
            if (chance_val < criminal_chance)
            {
                system("cls");
                trial_screen();
            }
            if (cpu_item == 6)
            {
                criminal_chance -= criminal_chance*.2;
            }
            house_retry = 1;
            shop_retry = 1;
            uground_retry = 1;
            bank_retry = 1;
            company_retry = 1;
            legal_retry = 1;
            charity_retry = 1;
            if (game_week % 5 ==0)
            {
                string day_off_choice;
                while (1)
                {
                    system("cls");
                    cout << "Do You Want to take a DAY OFF?" << endl;
                    cout << "You wont be able to HACK any place for this week" << endl;
                    cout << "[1]Yes[2]No :";
                    cin >> day_off_choice;
                    cout << endl;
                    if (day_off_choice == "1")
                    {
                        system("cls");
                        day_off();
                        break;
                    }
                    else if (day_off_choice == "2")
                    {
                        break;
                    }
                    else
                    {
                        cout << "You entered a wrong choice! Please Try Again. " << endl;
                        system("pause");
                        system("cls");
                    }
                }
            }
            game_week++;
            hand_money -= (weekly_expenses - fortune_money_weekly);
            bank_money += bank_money*0.005;
            cout << endl << "\t" << "ONE WEEK PASSED...";
            system("pause");
        }
        else if (main_choice == "9")
        {
            if (game_week % 5 == 0)
            {
                system("cls");
                save_game();
            }
            else 
            {
                cout << "YOU CAN ONLY SAVE BEFORE DAY OFF(every 5 weeks)" << endl;
                system("pause");
            }
        }
        else if (main_choice == "99")
        {
            system("cls");
            go_help();
        }
        else if (main_choice == "0")
        {
            system("cls");
            break;
        }
        else
        {
            cout << "Wrong number of choice. Please Try Again" << endl;
            system("pause");
        }
    }
}
/*******************************COMMANDS***************************************/
/*--------------Commands Set A------------*/
void cmd_set_a()
{
}
/*--------------Commands Set B------------*/
void cmd_set_b()
{
    f_find=true;
}
/*--------------Commands Set C------------*/
void cmd_set_c()
{
    f_find=true;
    f_info=true;
    emerg_dc=true;
}
/*--------------Commands Set D------------*/
void cmd_set_d()
{
    f_find=true;
}
//*ALL COMMANDS*
//f_connect
//f_open
//f_exit
//f_dir
//f_find
//emerg_dc
//f_decode
//f_info
//zap_fwall
//meltdown
/*-------------------------------Main Header----------------------------------*/
void main_header()
{
    cout << "[)---------------------------------------------------------------------------(]" << endl;
    cout << "NAME: "<< name << "\t";
    cout << "WEEK: "<< game_week << "  ";
    cout << "MONEY: $"<< hand_money << "\t";
    cout << "BANK: $"<< bank_money << "\t";
    if (cpu_item == 0)
        cout << "No Computer";
    else if (cpu_item == 1)
        cout << "Pentium III";
    else if (cpu_item == 2)
        cout << "Pentium IV";
    else if (cpu_item == 3)
        cout << "PentiumDualCore";
    else if (cpu_item == 4)
        cout << "Intel Core Duo";
    else if (cpu_item == 5)
        cout << "Core 2 Quad";
    else if (cpu_item == 6)
        cout << "Supercom";
    cout << endl;
    cout << "CRIMINAL CHANCE: " << criminal_chance << "%\t\t\t";
    cout << "HACK ATTEMPTS: " << hack_attempts << "\t";
    if (company_quest == 1)
    {
        cout << "Hack Request";
    }
    cout << endl;
    if (accessory11 == true)
    {
        cout << "FwallPurger" << "\t";
    }
    if (accessory12 == true)
    {
        cout << "VPN";
    }
    cout << endl << "[)---------------------------------------------------------------------------(]" << endl; 
    cout << "f_connect f_open f_dir f_exit f_decode f_help ";
    if (f_find == true)
    {
        cout << "f_find ";
    }
    if (f_info == true)
    {    
        cout << "f_info ";
    }
    if (emerg_dc == true)
    {
        cout << "emerg_dc ";
    }
    if (zap_fwall == true)
    {
        cout << "zap_fwall ";
    }
    if (keydecode == true)
    {
        cout << "keydecode ";
    }
    if (meltdown == true)
    {
        cout << "meltdown ";
    }
    cout << endl;
    cout << "[)---------------------------------------------------------------------------(]" << endl << endl;
}
/*-----------------Day Off----------------*/
void day_off()
{
    main_header();
    int day_off_random = rand()%13;
    if (day_off_random == 0)
    {
        string random_0_choice;
        int random_feature = rand()%5-2;
        while (1)
        {
            cout << "You're walking along a street when you stumbled upon a computer store" << endl;
            cout << "that sells SAME COMPUTERS but at a VERY LOW PRICE" << endl << endl;
            cout << "Buy What:" << endl;
            cout << "[1]Intel Core Duo - 8 Hacking Time Limit, 4 minutes download/decode" << endl
                 << "         Price: $15000 -> $10000" << endl
                 << "[2]Core 2 Quad - 10 Hacking Time Limit, 3 minutes download/decode" << endl
                 << "         Price: $25000 -> $18000" << endl
                 << "[0]EXIT" << endl << endl
                 << "Choice: ";
            cin >> random_0_choice;
            if (random_0_choice == "1")
            {
                hand_money -= 10000;
                cpu_item = 4;
                cpu_hacktime = 8+random_feature;
                cpu_speed = 4-random_feature;
            }
            else if (random_0_choice == "2")
            {
                hand_money -= 18000;
                cpu_item = 5;
                cpu_hacktime = 10+random_feature;
                cpu_speed = 3-random_feature;
            }
            else if (random_0_choice == "0")
            {
                break;break;
            }
            else
            {
                cout << endl << "You entered a wrong choice..." << endl;
            }
            if (random_0_choice == "1" || random_0_choice == "2")
            {
                float auto_money = rand()%1000+500;
                cout << "You've bought the computer" << endl;
                cout << "You also found out that it has unique feature that ever week" << endl;
                cout << "you gain $" << auto_money <<" from its auto_hack capability" << endl << endl;
                weekly_expenses -= auto_money;
                if (random_feature > 0)
                {
                    cout << "ANOTHER GOOD THING: " << endl;
                    cout << "It performs better than your initial assumptions!" << endl;
                    cout << "RANDOM FEATURE:" << endl;
                    cout << "  Hacking Time Limit NOW  = " << cpu_hacktime << endl;
                    cout << "  CPU Download/Decode NOW = " << cpu_speed << " minutes" << endl;
                }
                else if (random_feature < 0)
                {
                    cout << "HOWEVER, BAD THING: " << endl;
                    cout << "It didn't function at the maximum level!" << endl;
                    cout << "RANDOM FEATURE:" << endl;
                    cout << "  Hacking Time Limit NOW  = " << cpu_hacktime << endl;
                    cout << "  CPU Download/Decode NOW = " << cpu_speed << " minutes" << endl;
                }
                system("pause");
                break;
            }
        }
    }
    else if (day_off_random == 1 & criminal_chance > 0)
    {
        float random_money_loss = rand()%500+500;
        cout << "You visited a mall to have a good time. However, an AGENT saw you while" << endl;
        cout << "you're eating lunch. You saw him and immediately sneaked away." << endl;
        cout << "Fortunately, your STEALTHY instincts made it easier for you to blend in" << endl;
        cout << "and escape from the crowd." << endl;
        cout << "HOWEVER, you left some cash on your table" << endl;
        cout << "   MONEY loss: $" << random_money_loss << endl;
        hand_money -= random_money_loss;
    }
    else if (day_off_random == 2)
    {
        cout << "You've wathed the movie STARS at WAR" << endl;
        cout << "After the show, you're surprised to see yourself" << endl;
        cout << "sobbing in tears due to the climax of the show" << endl;
    }
    else if (day_off_random == 3)
    {
        cout << "You walked along the streets, and suddenly realized that" << endl;
        cout << "someone is following you. In fear that he is a police, you" << endl;
        cout << "went inside a Mall. However, you're surprised by him suddenly" << endl;
        cout << "standing in front of you." << endl;
        cout << "THE PERSON said: 'You dropped your wallet'" << endl;
        cout << "You realized the situation, and gave him thanks..." << endl;
        cout << "To pay for his kindness, you treated him in lunch" << endl;
        cout << "    MONEY LOSS: $500" << endl;
        hand_money -= 500;
    }
    else if (day_off_random == 4)
    {
        if (name=="YUI")
        {
            cout << "Someone called you. <man>:'YUI, Let's go!'" << endl;
            cout << "After waiting a few minutes, your boyfriend has finally arrived." << endl;
            cout << "You spent your day together with your boyfriend." << endl;
            cout << "You're so lucky with a cool, handsome, and perfect guy." << endl;
            cout << "He also gave you MONEY for your shopping needs." << endl;
            cout << "    MONEY INCREASED: $5000" << endl;
            hand_money += 5000;
        }
        else
        {
            cout << "You checked your bank account, and found out that" << endl;
            cout << "your periodic investment profit already arrived" << endl;
            cout << "    MONEY INCREASED: $4000" << endl;
            bank_money += 4000;
        }
    }
    else if (day_off_random == 5)
    {
        int random_command = rand()%6;
        int random_command_price;
        string code_offer_answer;
        cout << "You visited the <Underground Hackers' Association>, and" << endl;
        cout << "found that the 'Infamous Hacker' is willing to teach you(50% off)" << endl;
        if (random_command == 0)
        {
             cout << "*f_find - automatic search of potential codes" << endl
                  << "     use: type anytime while in Hacking mode" << endl
                  << "     Price: $4000 -> $2000" << endl;
             random_command_price = 2000;
        }
        if (random_command == 1)
        {
             cout << "*f_info - displays helpful personal and system information" << endl
                  << "     use: type anytime while in Hacking mode" << endl
                  << "     Price: $3000 -> $1500" << endl;
             random_command_price = 1500;
        }
        if (random_command == 2)
        {
             cout << "*emerg_dc - automatic integrated emergency disconnection" << endl
                  << "     halved the CRIMINAL CHANCE gained from the firewall" << endl
                  << "     use: type after 'firewall security breach'" <<endl
                  << "     Price: $5000 -> $2500" << endl;
             random_command_price = 2500;
        }
        if (random_command == 3)
        {
             cout << "*zap_fwall - purges the firewall from the system" << endl
                  << "     halved the FIREWALL CHANCE from the system" << endl
                  << "     use: type anytime while in Hacking mode" << endl
                  << "     Price: $10000 -> $5000" << endl;
             random_command_price = 5000;
        }
        if (random_command == 4)
        {
             cout << "*keydecode - decodes .key files for large amount of money" << endl
                  << "     use: after using 'f_open ###' to .key file, type 'keydecode'" << endl
                  << "     Price: $5000 -> $2500" << endl;
             random_command_price = 2500;
        }
        if (random_command == 5)
        {
             cout << "*meltdown - automated link termination" << endl
                  << "     CRIMINAL CHANCE gained from firewall WILL NOT COUNT" << endl
                  << "     at the COST of COMPUTER DAMAGE(pay MONEY)" << endl
                  << "     use: type after 'firewall security breach'" << endl
                  << "     Price: $7000 -> $3500" << endl;
                  random_command_price = 3500;
        }
        cout << endl;
        cout << "Do you want to accept the offer?" << endl;
        cout << "[1]Yes [2]No" << endl;
        cout << "Choice: ";
        cin >> code_offer_answer;
        if (code_offer_answer == "1")
        {
            if (random_command == 0)
            {
                f_find = true;
            }
            if (random_command == 1)
            {
                f_info = true;
            }
            if (random_command == 2)
            {
                emerg_dc = true;
            }
            if (random_command == 3)
            {
                zap_fwall = true;
            }
            if (random_command == 4)
            {
                keydecode = true;
            }
            if (random_command == 5)
            {
                meltdown = true;
            }
            hand_money -= random_command_price;
        }
        else if (code_offer_answer == "2")
        {
            cout << "You declined the offer..." << endl;
        }
        else
        {
            cout << endl;
            cout << "You Entered a wrong choice!" << endl;
        }
        
    }
    else if (day_off_random == 6)
    {
        cout << "Not Much Happened Today..." << endl;
    }
    else if (day_off_random == 7)
    {
        cout << "You opened your lottery account" << endl;
        cout << "You were surprised to find out that unbelievably you WON $0.0000001" << endl;
        cout << "WWWOOOoooOOOWWW!!!! A M A Z I N G!!!! SO MANY ZEROOOS!!!" << endl;
        cout << "    MONEY INCREASED: $0.0000001" << endl;
        hand_money += 0.0000001;
    }
    else if (day_off_random == 8 & company_quest == 0)
    {
        int random_company_hack = rand()%4;
        if (random_company_hack == 0)
        {
            tar_company = "Hola Cola Company";
        }
        if (random_company_hack == 1)
        {
            tar_company = "McDonalDuck Corporation";
        }
        if (random_company_hack == 2)
        {
            tar_company = "MacroHard Corporation";
        }
        if (random_company_hack == 3)
        {
            tar_company = "Jollibig Corporation";
        }
        if (random_company_hack == 4)
        {
            tar_company = "Nesley Foods";
        }
        cout << "You were sitting beneath a tree when a man approached you" << endl;
        cout << "<man>: I'll give you a job..." << endl;
        cout << "       Hack the '" << tar_company << "'" << endl;
        cout << "       find and f_open the 'Production Statistics 2009.pdf'" << endl;
        cout << "       We need critical information about their Standings." << endl;
        cout << "       If you succeeded, you'll be paid $50,000" << endl << endl;
        company_quest = 1;
    }
    else if (day_off_random == 9)
    {
        float fortune_money = rand()%900-400;
        fortune_money_weekly += fortune_money;
        cout << "You now received the result of your FORTUNE application" << endl;
        cout << "Your FORTUNE will either be GOOD or BAD" << endl;
        cout << "NOTE: FORTUNE stack with each other" << endl;
        cout << "      You will pay or receive weekly TOTAL FORTUNE" << endl << endl;
        cout << "You opened the envelope" << endl;
        cout << "    <FORTUNE> =       $" << fortune_money << endl;
        cout << "    <TOTAL FORTUNE> = $" << fortune_money_weekly << endl;
    }
    else
    {
        cout << "Not Much Happened Today..." << endl;
    }
    house_retry=0;
    bank_retry=0;
    company_retry=0;
    system("pause");
    system("cls");
}
/***************************Main_Choices**************************************/
/*---------------Hack House---------------*/
void hack_house()
{
     main_header();
     placeselected=1;
     house_retry=0;
     folder = 0;
     choice_chance = rand()%15;
     rndmfile = rand()%1000 + 10;
     specialfile1 = rand()%100;
     specialfile2 = rand()%100;
     jokefile1 = rand()%100;
     jokefile2 = rand()%100;
     random_id = rand()%1000;
     rndmfolder = rand()%100;
     specialvpn = rand()%100;
     if (cpu_item == 0)
     {
         cout << "YOU NEED TO BUY A COMPUTER FIRST!" << endl;
         system("pause");
         system("cls");
     }
     else if (cpu_item > 0)
     {
         cout << "<HOUSE ID #" << random_id <<">"<< endl;
         hacking_screen();
     }
}
/*---------------Hack Bank----------------*/
void hack_bank()
{
     placeselected=2;
     bank_retry=0;
     folder = 0;
     choice_chance = rand()%30+20;
     rndmfile = rand()%1000 + 10;
     specialfile1 = rand()%100;
     specialfile2 = rand()%100;
     jokefile1 = rand()%100;
     jokefile2 = rand()%100;
     random_id = rand()%1000;
     rndmfolder = rand()%100;
     specialvpn = rand()%100;
     int bank_choice_retry = true;
     while (bank_choice_retry == true)
     {
         system("cls");
         main_header();
         if (cpu_item == 0)
         {
             cout << "YOU NEED TO BUY A COMPUTER FIRST!" << endl;
             system("pause");
             system("cls");
             bank_choice_retry = false;
         }
         else if (cpu_item > 0)
         {
             cout << "HACK WHICH BANK?" << endl << endl
                  << "[1] National Bank of Corporates" << endl
                  << "[2] Wall Street Bank" << endl
                  << "[3] The Purposeful Bank" << endl
                  << "[4] EverBank" << endl
                  << "[5] YOUR BANK" << endl;
             cout << "Choice: ";
             cin >> bank_name_choice;
             system("cls");
             main_header();
             if (bank_name_choice == "1")
             {
                 bank_name = "National Bank of Corporates";
             }
             else if (bank_name_choice == "2")
             {
                 bank_name = "Wall Street Bank";
             }
             else if (bank_name_choice == "3")
             {
                 bank_name = "The Purposeful Bank";
             }
             else if (bank_name_choice == "4")
             {
                 bank_name = "EverBank";
             }
             else if (bank_name_choice == "5")
             {
                 bank_name = "Universal Bank";
             }
             else
             {
                 cout << "YOU'VE TYPED A WRONG CHOICE! TRY AGAIN." << endl;
                 system ("pause");
                 hack_bank();
             }
             cout << "<" << bank_name << ">" << endl;
             bank_choice_retry = false;
             hacking_screen();
         }
     }
}
/*---------------Hack Company-------------*/
void hack_company()
{
     placeselected=3;
     company_retry=0;
     folder = 0;
     choice_chance = rand()%40+50;
     rndmfile = rand()%1000 + 10;
     specialfile1 = rand()%100;
     specialfile2 = rand()%100;
     jokefile1 = rand()%100;
     jokefile2 = rand()%100;
     random_id = rand()%1000;
     rndmfolder = rand()%100;
     int company_choice_retry = true;
     while (company_choice_retry == true)
     {
         system("cls");
         main_header();
         if (cpu_item == 0)
         {
             cout << "YOU NEED TO BUY A COMPUTER FIRST!" << endl;
             system("pause");
             system("cls");
             company_choice_retry = false;
         }
         else if (cpu_item > 0)
         {
             cout << "HACK WHICH COMPANY?" << endl << endl
                  << "[1] Hola Cola Company" << endl
                  << "[2] McDonalDuck Corporation" << endl
                  << "[3] MacroHard Corporation" << endl
                  << "[4] Jollibig Corporation" << endl
                  << "[5] Nesley Foods" << endl;
             cout << "Choice: ";
             cin >> company_name_choice;
             system("cls");
             main_header();
             if (company_name_choice == "1")
             {
                 company_name = "Hola Cola Company";
             }
             else if (company_name_choice == "2")
             {
                 company_name = "McDonalDuck Corporation";
             }
             else if (company_name_choice == "3")
             {
                 company_name = "MacroHard Corporation";
             }
             else if (company_name_choice == "4")
             {
                 company_name = "Jollibig Corporation";
             }
             else if (company_name_choice == "5")
             {
                 company_name = "Nesley Foods";
             }
             else
             {
                 cout << "YOU'VE TYPED A WRONG CHOICE! TRY AGAIN." << endl;
                 system ("pause");
                 hack_company();
             }
             cout << "<" << company_name << ">" << endl;
             company_choice_retry = false;
             hacking_screen();
         }
     }
}
/*---------------Hack Legal---------------*/
void hack_legal()
{
     legal_retry = 0;
     int random_legal = rand()%2;
     system("cls");
     cout << endl << endl << endl << endl;
     if (random_legal == 0)
     {
         cout << "\t" << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" << endl;
         cout << "\t" << "X                                                    X" << endl;
         cout << "\t" << "X        A NUCLEAR MISSILE HAS BEEN LAUNCHED         X" << endl;
         cout << "\t" << "X  BY TERRORISTS! HACK AND DEACTIVATE IT ALL COSTS!  X" << endl;
         cout << "\t" << "X                                                    X" << endl;
         cout << "\t" << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" << endl;
     }
     if (random_legal == 1)
     {
         cout << "\t" << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" << endl;
         cout << "\t" << "X                                                    X" << endl;
         cout << "\t" << "X   AN EVIL SYNDICATE PLANTED A BOMB INSIDE A MALL!  X" << endl;
         cout << "\t" << "X         HACK AND DEACTIVATE IT ALL COSTS!          X" << endl;
         cout << "\t" << "X                                                    X" << endl;
         cout << "\t" << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" << endl;
     }
     if (random_legal == 2)
     {
         cout << "\t" << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" << endl;
         cout << "\t" << "X                                                    X" << endl;
         cout << "\t" << "X        ALIENS INVADED YOUR COUNTRY! HACK AND       X" << endl;
         cout << "\t" << "X      DEACTIVATE THEIR MOTHERSHIP AT ALL COSTS!     X" << endl;
         cout << "\t" << "X                                                    X" << endl;
         cout << "\t" << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" << endl;
     }
     cout << endl;
     cout << "ABOUT:     You've successfully connected inside the system. You job now is" << endl;
     cout << "           to decode the flow of data and eventually disrupt the main system" << endl;
     cout << "OBJECTIVE: REMEMBER AT LEAST 8/10 LETTERS FOR DECODING PROCESS" << endl;
     cout << "           BEFORE THE TIME RUNS OUT" << endl << endl;
     cout << "Are you ready?" << endl;
     system("pause");
     system("cls");
     /*---MINI GAME Main---*/
     time_t start_time, cur_time;
     int randomizer, char_counter=0;
     char cout_char;
     int char_val[10];
     char char_temp[10];
     char_val[0] = rand()%2;
     char_val[1] = rand()%3+2;
     char_val[2] = rand()%3+5;
     char_val[3] = rand()%3+8;
     char_val[4] = rand()%3+11;
     char_val[5] = rand()%3+14;
     char_val[6] = rand()%2+17;
     char_val[7] = rand()%2+19;
     char_val[8] = rand()%2+21;
     char_val[9] = rand()%3+23;
     time(&start_time);
     while(1)
     {
         time(&cur_time);
         if (cur_time - start_time > 10)
         {
             break;
         }
         Sleep(30);
         cout << "XXXXXXX|]    TIME LEFT: " << start_time - cur_time + 10 << "\t\t";
         int x;
         for (x=0; x<10; x++)
         {
             randomizer=rand()%10;
             if (randomizer == 0)
             {
                 cout_char = static_cast<char>(char_val[0]+65);
             }
             if (randomizer == 1)
             {
                 cout_char = static_cast<char>(char_val[1]+65);
             }
             if (randomizer == 2)
             {
                 cout_char = static_cast<char>(char_val[2]+65);
             }
             if (randomizer == 3)
             {
                 cout_char = static_cast<char>(char_val[3]+65);
             }
             if (randomizer == 4)
             {
                 cout_char = static_cast<char>(char_val[4]+65);
             }
             if (randomizer == 5)
             {
                 cout_char = static_cast<char>(char_val[5]+65);
             }
             if (randomizer == 6)
             {
                 cout_char = static_cast<char>(char_val[6]+65);
             }
             if (randomizer == 7)
             {
                 cout_char = static_cast<char>(char_val[7]+65);
             }
             if (randomizer == 8)
             {
                 cout_char = static_cast<char>(char_val[8]+65);
             }
             if (randomizer == 9)
             {
                 cout_char = static_cast<char>(char_val[9]+65);
             }
             cout << cout_char << " ";
         }
         cout << "         [|XXXXXXXX" << endl;
     }
     system("cls");
     cout << "{)===---------------------------------------------------------------------===(}" << endl;
     cout << "||       NOW. PLEASE ENTER ALL THE LETTERS YOU SEE IN THE DEFUSING KIT       ||" << endl;
     cout << "||        YOU MUST DECODE AT LEAST 8 OUT OF 10 LETTERS (CAPITALS ONLY)       ||" << endl;
     cout << "{)===---------------------------------------------------------------------===(}" << endl;
     cout << endl;
    int y, z;
    for (y=0; y<10; y++)
    {
        cout << "Enter One Letter: ";
        cin >> char_temp[y];
        for (z=0; z<10; z++)
        {
            if (char_temp[y] == static_cast<char>(char_val[z]+65))
            {
                char_counter++;
                cout << "INPUT CORRECT!" << endl;
                cout << "CORRECT ANSWERS: " << char_counter << endl << endl;
                char_val[z]=false;
                break;
            }
        }
    }
    cout << endl;
    cout << "TOTAL CORRECT >>>>>>" << char_counter << "<<<<<<" << endl << endl;
    if (char_counter >= 8)
    {
        float reward_minigame = rand()%4000+1000;
        cout << "You have saved the people! You've become quite popular as a saviour," << endl;
        cout << "and you've noticed that your CRIMINAL CHANCE DROP by 25%" << endl;
        cout << "The agency also gave you a $" << reward_minigame << " reward" << endl;
        criminal_chance -= 0.25*criminal_chance;
        hand_money += reward_minigame;
    }
    else
    {
        cout << "You failed to decode and hack the system. Fortunately," << endl;
        cout << "there are also several HACKERS who tried to solve the" << endl;
        cout << "situation. Eventually, they succeeded." << endl << endl;
        cout << "TRY AGAIN NEXT WEEK" << endl;
    }
    system("pause");
}
/*---------------Go Bank------------------*/
void go_bank()
{
     while (1)
     {
         system("cls");
         main_header();
         string bank_choice;
         double bank_temp_val;
         cout << "<UNIVERSAL BANK>" << endl;
         cout << "<Accountant>Hello! Good day! What can I do for you?" << endl << endl;
         cout << "[1]Deposit Money(0.5% Weekly Interest)" << endl
              << "[2]Withdraw Money" << endl
              << "[3]Donate $5000 for charity(-1/4CRIMINAL CHANCE,ONCE max/week)" << endl
              << "[0]EXIT" << endl << endl;
         cout << "choice: ";
         cin >> bank_choice;
         cout << endl;
         if (bank_choice == "1")
         {
             cout << "Enter value: ";
             cin >> bank_temp_val;
             bank_money += bank_temp_val;
             hand_money -= bank_temp_val;
         }
         else if (bank_choice == "2")
         {
             cout << "Enter value: ";
             cin >> bank_temp_val;
             if (bank_temp_val <= bank_money)
             {
                 bank_money -= bank_temp_val;
                 hand_money += bank_temp_val;
             }
             else
             {
                 cout << endl << "YOU CANNOT WITHDRAW MORE THAN YOUR ACCOUNT!" << endl;
                 system("pause");
             }
         }
         else if (bank_choice == "3")
         {
             if (charity_retry == 1)
             {
                 cout << "<Accountant>You have a good heart! May God bless you!" << endl;
                 hand_money -= 5000;
                 criminal_chance -= criminal_chance*.25;
                 charity_retry = 0;
             }
             else
             {
                 cout << "YOU'VE ALREADY DONE THAT! YOU ARE SO TIRED OF" << endl;
                 cout << "ALL THE PAPERWORK. TRY AGAIN NEXT WEEK" << endl;
             }
             system("pause");
         }
         else if (bank_choice == "0")
         {
             break;
         }
         else
         {
             cout << "You've entered a wrong choice!" << endl;
             system("pause");
         }
     }
}

/*---------------Go Shop------------------*/
void go_shop()
{
     int p3_chance;
     int p4_chance;
     int pdc_chance;
     int icd_chance;
     int c2q_chance;
     int super_chance;
     int fwallbreaker_chance;
     int vpn_chance;
     
     string shop_choice;
     shop_retry = 0;
     p3_chance = rand()%10 + 85;
     srand(time(NULL));
     p4_chance = rand()%50 + 50;
     srand(time(NULL));
     pdc_chance = rand()%30 + 40;
     srand(time(NULL));
     icd_chance = rand()%10 + 30;
     srand(time(NULL));
     c2q_chance = rand()%30;
     srand(time(NULL));
     super_chance = rand()%5 + 5;
     srand(time(NULL));
     fwallbreaker_chance = rand()%70 + 30;
     srand(time(NULL));
     vpn_chance = rand()%50 + 20;
     srand(time(NULL));
     chance_val = rand()%100;
     while (1)
     {
         system("cls");
         main_header();
         cout << "<TOBY'S COMPUTER SHOP AND SERVICES>" << endl <<endl;
         cout << "<shopkeeper>Good day, Sir! What can I do for you?" << endl;
         cout << "            These are the available items for this week." << endl << endl;
         if (chance_val < p3_chance)
         {
             p3_allow=true;
             cout << "[1]Pentium III - 3 Hacking Time Limit, 8 minutes download/decode" << endl
                  << "     Price: $2000" << endl;
         }
         if (chance_val < p4_chance)
         {
             p4_allow=true;
             cout << "[2]Pentium IV - 4 Hacking Time Limit, 7 minutes download/decode" << endl
                  << "     Price: $4000" << endl;
         }
         if (chance_val < pdc_chance)
         {
             pdc_allow=true;
             cout << "[3]Pentium Dual Core - 6 Hacking Time Limit, 5 minutes download/decode" << endl
                  << "     Price: $8000" << endl;
         }
         if (chance_val < icd_chance)
         {
             icd_allow=true;
             cout << "[4]Intel Core Duo - 8 Hacking Time Limit, 4 minutes download/decode" << endl
                  << "     Price: $15000" << endl;
         }
         if (chance_val < c2q_chance)
         {
             c2q_allow=true;
             cout << "[5]Core 2 Quad - 10 Hacking Time Limit, 3 minutes download/decode" << endl
                  << "     Price: $25000" << endl;
         }
         if (chance_val < super_chance)
         {
             super_allow=true;
             cout << "[6]Supercom - 15 Hacking Time Limit, 1 minute download/decode," << endl
                  << "     Decreases CRIMINAL CHANCE by 1/5 every week" << endl
                  << "     Price: $70000" << endl;
         }
         if (chance_val < fwallbreaker_chance)
         {
             fwallbreaker_allow=true;
             cout << "[11]Firewallpurger - nullifies firewall from system" << endl
                  << "     (no firewall threat within the first 3 hacking time)" << endl
                  << "     Price: $12000" << endl;
         }
         if (chance_val < vpn_chance)
         {
             vpn_allow=true;
             cout << "[12]Virtual Private Network - secured and anonymous outbound connection" << endl
                  << "     (decreases the TOTAL chance of getting caught(~50%)" << endl
                  << "      Price: $4000/week" << endl;
         }
         cout << "[0]EXIT" << endl;
         cout << endl;
         cout << "Choice: ";
         cin >> shop_choice;
         if (shop_choice == "1" && p3_allow==true)
         {
             cpu_item = 1;
             cpu_hacktime = 3;
             cpu_speed = 8;
             hand_money -= 2000;
         }
         else if (shop_choice == "2" && p4_allow==true)
         {
             cpu_item = 2;
             cpu_hacktime = 4;
             cpu_speed = 7;
             hand_money -= 4000;
         }
         else if (shop_choice == "3" && pdc_allow==true)
         {
             cpu_item = 3;
             cpu_hacktime = 6;
             cpu_speed = 5;
             hand_money -= 8000;
         }
         else if (shop_choice == "4" && icd_allow==true)
         {
             cpu_item = 4;
             cpu_hacktime = 8;
             cpu_speed = 4;
             hand_money -= 15000;
         }
         else if (shop_choice == "5" && c2q_allow==true)
         {
             cpu_item = 5;
             cpu_hacktime = 10;
             cpu_speed = 3;
             hand_money -= 25000;
         }
         else if (shop_choice == "6" && super_allow==true)
         {
             cpu_item = 6;
             cpu_hacktime = 15;
             cpu_speed = 1;
             hand_money -= 70000;
         }
         else if (shop_choice == "11" && fwallbreaker_allow==true)
         {
             accessory11 = true;
             hand_money -= 12000;
         }
         else if (shop_choice == "12" && vpn_allow==true)
         {
             accessory12 = true;
             weekly_expenses += 2000;
         }
         else if (shop_choice == "0")
         {
              break;
         }
         else
         {
             cout << "Either you've entered a wrong choice or the item is not available this week" << endl;
             system ("pause");
         }
         p3_allow=false;
         p4_allow=false;
         pdc_allow=false;
         icd_allow=false;
         c2q_allow=false;
         super_allow=false;
         fwallbreaker_allow=false;
         vpn_allow=false;
         cpu_hacktime_reset=cpu_hacktime;
         cpu_speed_reset=cpu_speed;
     }
}
/*--------------Go Underground------------*/
void go_underground()
{
     int f_find_chance;
     int f_info_chance;
     int emerg_dc_chance;
     int zap_fwall_chance;
     int keydecode_chance;
     int meltdown_chance;
     
     string uground_choice;
     uground_retry = 0;
     f_find_chance = rand()%10 + 85;
     srand(time(NULL));
     f_info_chance = rand()%50 + 50;
     srand(time(NULL));
     emerg_dc_chance = rand()%30 + 40;
     srand(time(NULL));
     zap_fwall_chance = rand()%40 + 30;
     srand(time(NULL));
     keydecode_chance = rand()%40;
     srand(time(NULL));
     meltdown_chance = rand()%40;
     chance_val = rand()%100;
     while (1)
     {
         system("cls");
         main_header();
         cout << "<THE HACKERS' UNDERGROUND ASSOCIATION>" << endl <<endl;
         cout << "<Guard>Where's your ID?!" << endl;
         cout << "       ... Ok! You may pass..." << endl;
         cout << "<infamous hacker>These are the codes and commands I can teach" << endl ;
         cout << "                 you this week." << endl << endl;
         if (chance_val < f_find_chance)
         {
             f_find_allow=true;
             cout << "[1]f_find - automatic search of potential codes" << endl
                  << "     use: type anytime while in Hacking mode" << endl
                  << "     Price: $4000" << endl;
         }
         if (chance_val < f_info_chance)
         {
             f_info_allow=true;
             cout << "[2]f_info - displays helpful personal and system information" << endl
                  << "     use: type anytime while in Hacking mode" << endl
                  << "     Price: $3000" << endl;
         }
         if (chance_val < emerg_dc_chance)
         {
             emerg_dc_allow=true;
             cout << "[3]emerg_dc - automatic integrated emergency disconnection" << endl
                  << "     halved the CRIMINAL CHANCE gained from the firewall" << endl
                  << "     use: type after 'firewall security breach'" <<endl
                  << "     Price: $5000" << endl;
         }
         if (chance_val < zap_fwall_chance)
         {
             zap_fwall_allow=true;
             cout << "[4]zap_fwall - purges the firewall from the system" << endl
                  << "     halved the FIREWALL CHANCE from the system" << endl
                  << "     use: type anytime while in Hacking mode" << endl
                  << "     Price: $10000" << endl;
         }
         if (chance_val < keydecode_chance)
         {
             keydecode_allow=true;
             cout << "[5]keydecode - decodes .key files for large amount of money" << endl
                  << "     use: after using 'f_open ###' to .key file, type 'keydecode'" << endl
                  << "     Price: $5000" << endl;
         }
         if (chance_val < meltdown_chance)
         {
             meltdown_allow=true;
             cout << "[6]meltdown - automated link termination" << endl
                  << "     CRIMINAL CHANCE gained from firewall WILL NOT COUNT" << endl
                  << "     at the COST of COMPUTER DAMAGE(pay MONEY)" << endl
                  << "     use: type after 'firewall security breach'" << endl
                  << "     Price: $7000" << endl;
         }
         cout << "[0]EXIT" << endl;
         cout << endl;
         cout << "Choice: ";
         cin >> uground_choice;
         if (uground_choice == "1" && f_find_allow==true)
         {
             f_find = true;
             cout << endl << "THANKS! GOOD LUCK IN YOUR HACKING!" << endl;
             hand_money -= 4000;
         }
         else if (uground_choice == "2" && f_info_allow==true)
         {
             f_info = true;
             cout << endl << "THANKS! GOOD LUCK IN YOUR HACKING!" << endl;
             hand_money -= 3000;
         }
         else if (uground_choice == "3" && emerg_dc_allow==true)
         {
             emerg_dc = true;
             cout << endl << "THANKS! GOOD LUCK IN YOUR HACKING!" << endl;
             hand_money -= 5000;
         }
         else if (uground_choice == "4" && zap_fwall_allow==true)
         {
             zap_fwall = true;
             cout << endl << "THANKS! GOOD LUCK IN YOUR HACKING!" << endl;
             hand_money -= 10000;
         }
         else if (uground_choice == "5" && keydecode_allow==true)
         {
             keydecode = true;
             cout << endl << "THANKS! GOOD LUCK IN YOUR HACKING!" << endl;
             hand_money -= 5000;
         }
         else if (uground_choice == "6" && meltdown_allow==true)
         {
             meltdown = true;
             cout << endl << "THANKS! GOOD LUCK IN YOUR HACKING!" << endl;
             hand_money -= 7000;
         }
         else if (uground_choice == "0")
         {
              break;
         }
         else
         {
             cout << "Either you've entered a wrong choice or the item is not available this week" << endl;
             system ("pause");
         }
         f_find_allow=false;
         f_info_allow=false;
         emerg_dc_allow=false;
         zap_fwall_allow=false;
         keydecode_allow=false;
         meltdown_allow=false;
     }
}
/*---------------Save Game----------------*/
void save_game()
{
     char file_out[50]; 
     cout << "Enter the file to save(file extension not included): ";
     cin >> file_out;
     ofstream mysave;
     mysave.open(file_out);
     /*-----Start of Saved Variables----*/
     mysave << "--==Ultima_Hacker_V3==--" << endl;
     mysave << name << endl;
     mysave << hand_money << endl;
     mysave << bank_money << endl;
     mysave << lawyer << endl;
     mysave << game_week << endl;
     mysave << hack_attempts << endl;
     mysave << guilty_chance << endl;
     mysave << criminal_chance << endl;
     mysave << weekly_expenses << endl;
     mysave << key_file_retry << endl;
     mysave << cpu_item << endl;
     mysave << cpu_speed << endl;
     mysave << cpu_hacktime << endl;
     mysave << company_quest << endl;
     mysave << tar_company << endl;
     mysave << fortune_money_weekly << endl;
     mysave << f_find << endl;
     mysave << f_info << endl;
     mysave << emerg_dc << endl;
     mysave << zap_fwall << endl;
     mysave << keydecode << endl;
     mysave << meltdown << endl;
     mysave << accessory11 << endl;
     mysave << accessory12 << endl;
     mysave << cpu_speed_reset << endl;
     mysave << cpu_hacktime_reset << endl;
     /*-------End of Saved Variables-----*/
     cout << "G A M E   S A V E D !!" << endl;
     system("pause");
}
/*--------------HELP SCREEN---------------*/
void go_help()
{
     while (1)
     {
         system("cls");
         main_header();
         string help_choice;
         cout << endl;
         cout << "<Rod Michael> I'M THE WORLD'S BEST PROGRAMMER, ^_^!" << endl
              << "              WITH MY OVERWHELMING KNOWLEDGE, I CAN ALSO HELP" << endl
              << "              YOU IN YOUR QUESTIONS ABOUT HACKING. ^_^" << endl << endl;
         cout << "\tWhat can I do for you?" << endl << endl;
         cout << "\t[1] Basic COMMANDS" << endl;
         cout << "\t[2] About COMMANDS" << endl;
         cout << "\t[3] About COMPUTERS" << endl;
         cout << "\t[4] Objective and Game Over" << endl;
         cout << "\t[5] Gameplay" << endl;
         cout << "\t[6] FIREWALL and Chances" << endl;
         cout << "\t[0] EXIT" << endl << endl;
         cout << "\tChoice: ";
         cin >> help_choice;
         cout << endl;
         if (help_choice == "1")
         {
             cout << "* FOLDER = NO FILE EXTENSION ex. user files, program files" << endl
                  << "* FILE = WITH FILE EXTENSION ex. money.bat, mycodes.txt, myvideo.avi" << endl << endl
                  << "* When in HACKING mode, type 'f_connect' first to connect to the system" << endl
                  << "* When connected, type 'f_dir' to browse files in the main directory" << endl
                  << "* Use 'f_dir' to browse other directories as well" << endl
                  << "* Use 'f_open #' to open file/folder" << endl
                  << "* Ex. f_open 4 or f_open 315" << endl
                  << "* You can only use 'f_open' to a FILE if you already used 'f_dir',but if you're" << endl
                  << "  opening a FOLDER, no need to type 'f_dir'" << endl
                  << "* HELPFUL TIP: You can also directly type 'f_open #' if you still remember the" << endl
                  << "  FOLDER# you have accessed before. Ex (this directs to FOLDER 111)'f_open 111'" << endl
                  << "  even if you are still in the main directory/are still not using 'f_dir'" << endl
                  << "* HELPFUL TIP: To go back to the main directory or to go back a previous" << endl
                  << "  FOLDER, type 'f_open #' where # is the FOLDER's code; however" << endl
                  << "  type 'f_open 0' to go to main directory" << endl << endl
                  << "* HACKING MONEY!:" << endl
                  << "* Use 'f_open #' to VERIFY POTENTIAL FILES" << endl
                  << "* After using 'f_open #' to a FILE and then the command display" << endl
                  << "  VERIFIED its potential for hacking, then, type 'f_decode' to decode the file" << endl
                  << "* However, if you use 'f_open #' to a FILE, but the command display showed" << endl
                  << "  nothing, then that FILE has no POTENTIAL for hacking money." << endl
                  << "* You can only use 'f_decode' after a POTENTIAL 'f_open' of a FILE" << endl
                  << "* HELPFUL TIP: 'f_find' command will automatically give you money" << endl << endl;
             system("pause");
         }
         else if (help_choice == "2")
         {
             cout << "* You can learn commands in the 'Underground'" << endl
                  << "* You can learn random commands in the 'Underground' every week"  << endl
                  << "* You can gain information on how to use the advance" << endl
                  << "  commands in the 'Underground'" << endl
                  << "* If you're in luck you might even receive free tutorials on a DAY OFF" << endl << endl;
             system("pause");
         }
         else if (help_choice == "3")
         {
             cout << "* You can buy computers at the shop" << endl
                  << "* You can buy random computers and upgrades every week" << endl
                  << "* HACKING TIME is the number of commands you can use while in the hacking mode" << endl
                  << "* The Better your PC, the faster and the better it can handle COMMANDS" << endl
                  << "* The faster the CPU speed(minutes decoding) , the faster you can decode files" << endl
                  << "* If you're in luck you can buy cheaper computers on a DAY OFF" << endl << endl;
             system("pause");
         }
         else if (help_choice == "4")
         {
              cout << "*NO OBJECTIVES! JUST HAVE FUN HACKING! ^_^" << endl;
              cout << "*GAME OVER - If you chose to end your WEEK with a negative MONEY in hand" << endl << endl;
              system("pause");
         }
         else if (help_choice == "5")
         {
              cout << "* You can also be a GOOD hacker if you were accepted in hacking" << endl
                   << "  jobs by government. You help in military missions by hacking into" << endl
                   << "  terrorist and milita computers and electronics" << endl
                   << "* You can be JAILED and be JUDGED on a trial if ever you will be" << endl
                   << "  captured by the police!" << endl
                   << "  You'll pay a lot of money if you are proven GUILTY" << endl
                   << "* When in hacking mode, you can hack special files that give other" << endl
                   << "  benefits other than money" << endl
                   << "* DON't Ever let your MONEY in hand reach negative!" << endl
                   << "  You will lose 1/10 of all your money due to sickness" << endl
                   << "  from not eating anything." << endl << endl;
              system("pause");
         }
         else if (help_choice == "6")
         {
              cout << "* CRIMINAL CHANCE: increases as you get caught by Firewalls" << endl
                   << "           Higher CRIMINAL CHANCE = higher chance to be captured" << endl
                   << "           by the police(every end of a week)" << endl
                   << "* GUILTY CHANCE: The Higher the chance to be judged GUILTY" << endl
                   << "           (there are other factors as well)" << endl
                   << "* FIREWALL: after each command you use, there's always a chance that you'll" << endl
                   << "           be tracked by the system SECURITY(FIREWALL). In each 'firewall" << endl
                   << "           security breach' you received, you'll gain CRIMINAL CHANCE equal to" << endl
                   << "           the FIREWALL CHANCE" << endl
                   << "           : also, after every MINUTE you wait for the DECODING of a file," << endl
                   << "           there's always a chance that you'll also be tracked by the FIREWALL" << endl
                   << "* HELPFUL TIP: command 'f_info' displays helpful information about the chance" << endl
                   << "           a FIREWALL will caught you. It also displays chances of specialfiles" << endl
                   << "           to appear while hacking" << endl << endl;
              system("pause");
         }
         else if (help_choice == "0")
         {
              break;
         }
         else
         {
             cout << endl << "YOU'VE ENTERED A WRONG CHOICE!" << endl << endl;
             system("pause");
         }
     }
}
/**************************START OF Hacking Screen*****************************/
void hacking_screen()
{
     int hack_time = 0;
     int f_find_retry = true;
     int zap_fwall_retry = 1;
     srand(time(NULL));
     random_money = rand()%400 + 400;
     string hack_cmd;
     cout << "\a\a";
     while (hack_time <= cpu_hacktime)
     {
         cout << "<hack time limit left = "<<cpu_hacktime<<">" << endl;
         if (cpu_hacktime == 0)
         {
              cout << endl << "You've used all available hacking time." << endl
                   << "Now disconnecting..." << endl;
              system("pause");
              break;
         }
         cout << endl << "<cmd_ultimav3:> ";
         cin >> hack_cmd;
         if (hack_cmd == "f_connect" & f_connect == true & connect_success == 0)
         {
             srand(time(NULL));
             int connect_chance = rand()%30 + 60;
             chance_val = rand()%100;
             cout << "Connecting...";
             system ("pause");
             if (chance_val < connect_chance)
             {
                 cout << endl << "\tCONNECTION SUCCESSFUL!" << endl;
                 connect_success = 1;
                 cout << "\t" << connect_chance << "%<<<<<<<" << endl;
                 cout << "\tNEED HELP? ENTER 'f_help'" << endl << endl;
             }
             else
             {
                 cout << endl << "\tSYSTEM BLOCKED!";
                 cout << endl << "\tUNABLE TO CONNECT!" << endl;
                 cout << "\t" << connect_chance << "%<<<<<<<" << endl << endl;
                 system("pause");
                 break; break;
             }
         }
         else if (hack_cmd == "f_connect" & f_connect == true & connect_success == 1)
         {
             cout << "You are already connected..." << endl;
         }
         else if (hack_cmd == "f_open" & f_open == true & connect_success == 1)
         {
             security_screen();
             cpu_hacktime--;
             cin >> folder;
             if (dl_file_company[21]=="true" & folder == 21 & placeselected==3 & company_quest==1 & company_name==tar_company)
             {
                 cout << "YOU'VE FOUND THE FILE!! YOU IMMEDIATELY CLOSED YOUR PROGRAM!!" << endl;
                 cout << "AND RECEIVED THE $50,000 reward" << endl;
                 hand_money += 50000;
                 dl_file_company[21]="false";
                 company_quest=0;
             }
             if (dl_file_company[155]=="true" & folder == 155 & placeselected==3)
             {
                 string lawyer_offer_choice;
                 cout << "FILE OPENED!" << endl;
                 cout << "Do you wish to hire a lawyer for ONE future court trial at 50%" << endl;
                 cout << "reduced payment ($20000->$10000)?" << endl;
                 cout << "[1]Yes" << endl;
                 cout << "[2]No" << endl << endl;
                 cout << "Choice: ";
                 cin >> lawyer_offer_choice;
                 cout << endl;
                 if (lawyer_offer_choice == "1")
                 {
                     cout << "You've accepted the offer" << endl;
                     hand_money -= 10000;
                     lawyer = true;
                 }
                 else if (lawyer_offer_choice == "2")
                 {
                     cout << "You've rejected the offer" << endl;
                 }
                 else
                 {
                     cout << "You've entered a wrong choice" << endl;
                 }
                 dl_file_company[155]="false";
             }
             if (folder == 2 & placeselected == 3)
             {
                 int fatal_effect;
                 for (fatal_effect=0; fatal_effect < 3000; fatal_effect++)
                 {
                     cout << "FATAL!!!ERROR!!!";
                 }
                 system("cls");
                 cout << "************************************************" << endl
                      << "DATA LINK TERMINATED!" << endl
                      << "50% of your BANK MONEY is lost!" << endl
                      << "UNKNOWN CAUSE! DATA ERROR!" << endl << endl;
                 system("pause");
                 bank_money -= 0.5*bank_money;
             }
             if (folder == 1017 & bank_account_name[1017] == name)
             {
                 float bank_money_temp;
                 cout << "***************************************************************" << endl
                      << "YOU ARE ABOUT TO EDIT YOUR BANK ACCOUNT!" << endl
                      << "WARNING: The higher the amount of money increased, the higher" << endl
                      << "         the CRIMINAL CHANCE you will gain(exponential)" << endl << endl;
                 cout << "MONEY:" << hand_money << "\t" << "BANK: " << bank_money << endl;
                 cout << "Enter New total BANK money(MAX added money = 10000): $";
                 cin >> bank_money_temp;
                 if (bank_money_temp - bank_money <= 10000)
                 {
                     if (bank_money_temp > bank_money)
                     {
                         cout << endl;
                         cout << "***YOU'VE CHANGED YOUR CREDIT!***" << endl;
                         criminal_chance += (((bank_money_temp - bank_money)/1000)*((bank_money_temp - bank_money)/1000))/5;
                         bank_money = bank_money_temp;
                     }
                     else if (bank_money_temp < bank_money)
                     {
                         cout << endl;
                         cout << "***NO HACKER WOULD WANT TO LOWER THEIR BANK CREDIT!TRY AGAIN***" << endl;
                     }
                     else if (bank_money_temp == bank_money)
                     {
                         cout << endl;
                         cout << "***YOU DIDN'T CHANGE YOUR CREDIT!***" << endl;
                     }
                 }
                 else
                 {
                     cout << endl;
                     cout << "YOU CANNOT ADD MORE THAN $10000!" << endl;
                 }
             }
             else if (dl_file_house[folder]=="true" || dl_file_bank[folder]=="true" || dl_file_company[folder]=="true")
             {
                 cout << "OPENING File..." << endl
                      << "VERIFYING Hacking Validity..." << endl
                      << "PROCESSING Queries..." << endl;
                 system("pause");
                 cout << "FILE now available for download/decode!" << endl;
                 dl_file_house[folder]="dltrue";
                 dl_file_bank[folder]="dltrue";
                 dl_file_company[folder]="dltrue";
             }
             else if (dl_file_house[folder]=="fake" || dl_file_bank[folder]=="fake" || dl_file_company[folder]=="fake")
             {
                 cout << "OPENING File..." << endl
                      << "VERIFYING Hacking Validity..." << endl
                      << "PROCESSING Queries..." << endl;
                 system("pause");
                 cout << "FILE now available for download/decode!" << endl;
                 dl_file_house[folder]="dlfake";
                 dl_file_bank[folder]="dlfake";
                 dl_file_company[folder]="dlfake";
             }
         }
         else if (hack_cmd == "f_decode" & f_decode == true & connect_success == 1 & ((dl_file_house[folder]=="dltrue" || dl_file_house[folder]=="dlfake") || (dl_file_bank[folder]=="dltrue" || dl_file_bank[folder]=="dlfake") || (dl_file_company[folder]=="dltrue" || dl_file_company[folder]=="dlfake")))
         {
             security_screen();
             cpu_hacktime--;
             decoding_screen();
         }
         else if (hack_cmd == "f_decode" & f_decode == true & connect_success == 1 & ((dl_file_house[folder]!="dltrue" || dl_file_house[folder]!="dlfake") || (dl_file_bank[folder]!="dltrue" || dl_file_bank[folder]!="dlfake") || (dl_file_company[folder]!="dltrue" || dl_file_company[folder]!="dlfake")))
         {
             security_screen();
             cout << "YOU Need to type 'f_open' to a potential FILE first" << endl;
         }
         else if (hack_cmd == "f_help" & f_help == true)
         {
             cout << endl << "f_help initializing........." << endl;
             system("pause");
             go_help();
             system("cls");
             main_header();
             cout << endl;
         }
         else if (hack_cmd == "f_dir" & f_dir == true & connect_success == 1)
         {
             security_screen();
             cpu_hacktime--;
             dl_file_house[folder]="false";
             dl_file_bank[folder]="false";
             dl_file_company[folder]="false";
             /*----------------------House Folders------------------*/
             if (placeselected==1 & folder==0)
             {
                 cout << "  [1]Program Files" << endl
                      << "  [2]User Files" << endl
                      << "  [3]Windows" << endl
                      << "  [4]free_monetary_aid"<<rndmfile<<".dat"<< endl
                      << "  [5]windowsantivirus.exe" << endl;
                 if (rndmfolder > 60)
                 {
                     rndmfolder_val = true;
                     cout << "  [6]Downloads" << endl;
                 }
                 dl_file_house[4]="true";
                 money_multiplier=1.2;
             }
             if (placeselected==1 & folder==6 & rndmfolder_val == true)
             {
                 cout << "  [61]Honey My Love So Sweet.avi" << endl
                      << "  [62][DvdRip][The Lord Of The Rings - Return of the King]Axxo.avi" << endl;
                 if (specialfile2 > 80)
                 {
                     cout << "  [63]alliedbankaccountmail.doc" << endl;
                     dl_file_house[63]="true";
                     money_multiplier=10;
                 }
             }
             if (placeselected==1 & folder==1)
             {
                 cout << "  [11]AVG" << endl
                      << "  [12]Microsoft Office" << endl
                      << "  [13]WinRar" << endl
                      << "  [14]Utorrent" << endl;
             }
             if (placeselected==1 & folder==2)
             {
                 cout << "  [21]favs" << endl
                      << "  [22]videos" << endl
                      << "  [23]documents" << endl
                      << "  [24]private" << endl;
                 if (specialfile1 > 50)
                 {
                     cout << "  [25]mykeys.txt" << endl;
                     dl_file_house[25]="true";
                     money_multiplier=3.6;
                 }
             }
             if (placeselected==1 & folder==3)
             {
                 cout << "  [31]System" << endl
                      << "  [32]Temp" << endl
                      << "  [33]Downloaded Program Files" << endl
                      << "  [34]system32.ini" << endl
                      << "  [35]setupapi.ini" << endl;
                 if (jokefile1>50)
                 {
                     cout << "  [36]keyslog.cfg" << endl;
                     dl_file_house[36]="fake";
                 }
             }
             if (placeselected==1 & folder==11)
             {
                 cout << "  [111]vault" << endl
                      << "  [112]AVG.exe" << endl
                      << "  [113]update.exe" << endl
                      << "  [114]download.cfg" << endl
                      << "  [115]2031x34899342.dat" << endl;
             }
             if (placeselected==1 & folder==111)
             {
                 cout << "  [1111]reader_s.exe" << endl
                      << "  [1112]NDISIO.sys" << endl
                      << "  [1113]AntiVirus2009.exe" << endl
                      << "  [1114]booter.exe" << endl
                      << "  [1115]pornhere.exe" << endl;
                 if (specialfile2 > 80)
                 {
                     cout << "  [1118]casino2kgen.exe" << endl;
                     dl_file_house[1118]="true";
                     money_multiplier = 9.1;
                 }
             }
             if (placeselected==1 & folder==12)
             {
                 cout << "  [121]powerpoint.exe" << endl
                      << "  [122]word.exe" << endl
                      << "  [123]publisher.exe" << endl
                      << "  [124]excel.exe" << endl
                      << "  [125]access.exe" << endl;
             }
             if (placeselected==1 & folder==13)
             {
                 cout << "  [131]uninstall.exe" << endl
                      << "  [133]winrar.hlp" << endl
                      << "  [134]order.html" << endl
                      << "  [135]winrar.exe" << endl
                      << "  [136]default.sfx" << endl;
             }
             if (placeselected==1 & folder==14)
             {
                 cout << "  [141]utorrent.exe" << endl;
                 if (jokefile2 > 50)
                 {
                     cout << "  [142]hackedkeys.txt" << endl;
                     dl_file_house[142]="fake";
                 }
                 cout << "  [143]update.exe" << endl
                      << "  [144]download.cfg" << endl
                      << "  [145]2031x34899342.dat" << endl;
                 if (specialfile1 > 20)
                 {
                     cout << "  [146]paypalaccount"<<rndmfile<<".info"<< endl;
                     dl_file_house[146]="true";
                     money_multiplier = 4.4;
                 }
             }
             if (placeselected==1 & folder==21)
             {
                 cout << "  [211]dailybread.html" << endl
                      << "  [212]Chris Brown - With You.mp3" << endl;
                 if (specialvpn > 80)
                 {
                     cout << "  [213]howtogetafreevpn.php" << endl;
                     dl_file_house[213]="true";
                     money_multiplier = 0;
                 }
             }
             if (placeselected==1 & folder==22)
             {
                 cout << "Folder is empty..." << endl;
             }
             if (placeselected==1 & folder==23)
             {
                 cout << "  [231]companyassingments.doc" << endl
                      << "  [232]project1.doc" << endl
                      << "  [233]how to dance ballet.pdf" << endl;
                 if (specialfile1 > 30)
                 {
                     cout << "  [234]serials.doc" << endl;
                     dl_file_house[234]="true";
                     money_multiplier = 4.1;
                 }
                 cout << "  [235]familyletter.doc" << endl;
             }
             if (placeselected==1 & folder==24)
             {
                 if (specialfile1 > 20)
                 {
                     cout << "  [241]mynudepic.jpg" << endl;
                     cout << "  [242]chocolatesyrup.mpg" << endl;
                 }
                 if (specialfile2 > 50)
                 {
                     cout << "  [243]myuseraccounts.key" << endl;
                     key_file = true;
                     dl_file_house[243]="true";
                     money_multiplier = 0;
                 }
                 if (jokefile1 > 40)
                 {
                     cout << "  [244]onlineaccounts.txt" << endl;
                 }
             }
             if (placeselected==1 & folder==31)
             {
                 cout << "  [311]avicap.dll" << endl
                      << "  [312]SHELL.dll" << endl
                      << "  [313]system.drv" << endl
                      << "  [314]mouse.drv" << endl
                      << "  [315]"<<rndmfile<<".dat" << endl;
             }
             if (placeselected==1 & folder==32)
             {
                 if (specialfile1 > 80)
                 {
                     cout << "  [321]bankaccountofmyfriend.txt" << endl;
                     dl_file_house[321]="true";
                     money_multiplier = 10;
                 }
                 else
                     cout << "Folder is empty..." << endl;
             }
             if (placeselected==1 & folder==33)
             {
                 cout << "  [331]Java Runtime Environment.cab" << endl
                      << "  [332]codebase"<<rndmfile<<".db"<< endl;
                 cout << "  [333]macromediaflash.exe" << endl;
                 if (jokefile2 > 50)
                 {
                     cout << "  [334]structbasetemp.special" << endl;
                     dl_file_house[334]="fake";
                 }
             }
             /*----------------------Bank Folders-------------------*/
             if (placeselected==2 & folder==0)
             {
                 cout << "  [1]Accounts" << endl
                      << "  [2]Corporates and Investments"<<rndmfile<< endl
                      << "  [3]" << bank_name << " Documents" << endl
                      << "  [4]Ultimate Firewall +++ (security center)" << endl;
                 cout << "  [5]" << rndmfile << ".secured" << endl;
                 rndmfile = rand()%10000 + 1000;
                 cout << "  [6]" << rndmfile << ".bat" << endl;
                 rndmfile = rand()%10000 + 1000;
                 cout << "  [7]" << rndmfile << ".exe" << endl;
                 rndmfile = rand()%10000 + 1000;
                 cout << "  [8]" << rndmfile << ".exe" << endl;
                 if (specialfile2 > 50)
                 {
                     cout << "  [9]Codes_Keys_data.exe" << endl;
                     dl_file_bank[9]="true";
                     money_multiplier=7.3;
                 }
             }
             if (placeselected==2 & folder==1)
             {
                 //--------BANK ACCOUNT LIST----------//
                 bank_account_name[1000] = "%10$SYSTEM";
                 bank_account_name[1001] = "Roro, Ros";
                 bank_account_name[1002] = "Ginza, Mira";
                 bank_account_name[1003] = "Aladdin, Jini";
                 bank_account_name[1004] = "Tinkeringbell, FairyGodmother";
                 bank_account_name[1005] = "Potter, Hairy";
                 bank_account_name[1006] = "Juliet, Romeo";
                 bank_account_name[1007] = "Rose, Jack";
                 bank_account_name[1008] = "Terminator, Van, the Third (III)";
                 bank_account_name[1009] = "Puss, Boots";
                 bank_account_name[1010] = "Ogre, Shrek";
                 bank_account_name[1011] = "Magneto, Bolt";
                 bank_account_name[1012] = "Psyclopz, Sored Eyes";
                 bank_account_name[1013] = "Roshan, Do da do ta dance";
                 bank_account_name[1014] = "The Lich King, Elshkafar";
                 bank_account_name[1015] = "Ddddtheacornonafly?, Chicken Little";
                 bank_account_name[1016] = "Finding Emo, Emo";
                 bank_account_name[1017] = "Duckling, Ugly";
                 bank_account_name[1018] = "Pigs, Three Little";
                 bank_account_name[1019] = "Beanstalk, and d Jack";
                 bank_account_name[1020] = "Wondering, Alice in";
                 bank_account_name[1021] = "Big Blue House, Pooh in the";
                 bank_account_name[1022] = "Big Blue House, Big Bird in the";
                 bank_account_name[1023] = "Big Blue House, Big Brother in the";
                 bank_account_name[1024] = "Lelouch, Rampage";
                 bank_account_name[1025] = "Naruto, Hinata";
                 bank_account_name[1026] = "Kaede, Rin";
                 bank_account_name[1027] = "Chii, Hideki";
                 bank_account_name[1028] = "Kotomi, Tomoya";
                 bank_account_name[1029] = "Nemu, Junichi";
                 bank_account_name[1030] = "Yagami, Light";
                 bank_account_name[1031] = "Elfen, Lid";
                 bank_account_name[1032] = "Simon, Nia,";
                 bank_account_name[1033] = "Yukino Miyazawa, Soujiro Arima";
                 bank_account_name[1034] = "Teletubbies, Tinky Winky Dipsy Lala Po(pow)";
                 bank_account_name[1035] = "Suzumiya, Haruhi";
                 bank_account_name[1036] = "Beast, Beauty and";
                 bank_account_name[1037] = "Shakugan no Saske";
                 bank_account_name[1038] = "Lockheart, Tifa";
                 bank_account_name[1039] = "Chipmunks, Alvin and the";
                 bank_account_name[1040] = "Pudge, The Doom Bringer";
                 bank_account_name[1041] = "Godzilla, vs Voltes V";
                 bank_account_name[1042] = "Pajamas, in Bananas";
                 bank_account_name[1043] = "Kung fu Papa";
                 bank_account_name[1044] = "Happy Feet, Penguins unleashed";
                 bank_account_name[1045] = "Ratatatouille = Ratatat";
                 bank_account_name[1046] = "The sun grows the food, the ants pick the food";
                 bank_account_name[1047] = "The Bug's Story";
                 bank_account_name[1048] = "Buzz Lightyear, Woody Woodpecker";
                 bank_account_name[1049] = "Wally, Eva";
                 bank_account_name[1050] = "Milo, Kida";
                 //-----------------------------------//
                 if (bank_name_choice == "5")
                 {
                     bank_account_name[1017] = name;
                 }
                 for (bank_account_id = 1000; bank_account_id <= 1050; bank_account_id++)
                 {
                     cout << "  ["<<bank_account_id<<"]001x"<<bank_account_id<<"_"<<bank_account_name[bank_account_id]<<".account"<< endl;
                     dl_file_bank[bank_account_id] = "true";
                 }
                 cout << "  [1051]allaccounts.info";
             }
             if (placeselected==2 & folder==2)
             {
                 cout << "  [21]Z Oil Company trade TOP_SECRET" << endl
                      << "  [22]Stock holders' terms and agreement.superdoc" << endl
                      << "  [23]Jollibig's investment documents.doc" << endl
                      << "  [24]TSFE.co(The Search for ExtraTerrestrial.co).doc" << endl;
                 if (specialfile1 > 80)
                 {
                     cout << "  [25]Wall-E Street statistics and influence 2009.superdoc" << endl;
                     dl_file_bank[25]="true";
                     money_multiplier = 20;
                 }
             }
             if (placeselected==2 & folder==21)
             {
                 cout << "  [211]The Secret Meeting.pptx" << endl
                      << "  [212]Confidential Terms and Agreement.secured" << endl;
                 if (specialfile1 > 50)
                 {
                     cout << "  [213]TOP SECRET(THE SECRET BID).secured" << endl;
                     dl_file_bank[213]="true";
                     money_multiplier = 14;
                 }
             }
             if (placeselected==2 & folder==31)
             {
                 if (specialfile2 > 40)
                 {
                     cout << "  [311]Z Oil Company production and statistics.graph" << endl;
                 }
                 if (jokefile1 > 50)
                 {
                     cout << "  [312]Company Market Records.doc" << endl;
                 }
                 if (jokefile2 > 50)
                 {
                     cout << "  [313]Management and Company Breakdown.info" << endl;
                 }
                 if (specialfile1 > 40)
                 {
                     cout << "  [314]Finance Record and Company Keys(Classified).xfile" << endl;
                     dl_file_bank[31]="true";
                     money_multiplier = 14.8;
                 }
             }
             if (placeselected==2 & folder==3)
             {
                 cout << "  [31]Employment and Administration System.doc" << endl
                      << "  [32]Bank's TOP SECRETS.secured" << endl
                      << "  [33]UPDATED_GEN_Accounts and Services.doc" << endl
                      << "  [34]Company's Market Strategy 2010-2015.graph" << endl
                      << "  [35]Company Deals and Agreements.doc" << endl;
                 if (specialfile2 > 10)
                 {
                     cout << "  [36]Company BankID#" << rndmfile << " Vault.doc" << endl;
                     dl_file_bank[36]="true";
                     money_multiplier = rand()%13+3;
                 }
             }
             if (placeselected==2 & folder==4)
             {
                 cout << "  [41]Ultimate Firewall.system" << endl
                      << "  [42]Codebase00x0012300293800289091.secured" << endl
                      << "  [43]Ultimantihack.system" << endl
                      << "  [44]" << rndmfile <<".exe" << endl;
             }
             /*----------------------Company Folders-----------------*/
             if (placeselected==3 & folder==0)
             {
                 cout << "  [1]" << company_name << " Documents" << endl
                      << "  [2]WARNING!Hackers DONT OPEN THIS FOLDER!._." << endl
                      << "  [3]ZProtect Premium Security Suite" << endl
                      << "  [4]Integrated Employment System.system" << endl
                      << "  [5]$0 file.exe" << endl
                      << "  [6]" << rndmfile << company_name << "___.omg" << endl;
                 if (specialfile2 > 75)
                 {
                     cout << "  [7]SUPERCOM-Only at $45000!.securedlink" << endl;
                     dl_file_company[7]="true";
                 }
                 else if (jokefile2 > 30)
                 {
                     cout << "  [8]Company KEYS!(do not open!).doc" << endl;
                     dl_file_company[8]="fake";
                 }
             }
             if (placeselected==3 & folder==1)
             {
                 cout << "  [11]Production and Sales" << endl
                      << "  [12]Employment and Management" << endl
                      << "  [13]Stocks System" << endl
                      << "  [14]Contracts, Deals, and Agreements" << endl;
                 if (rndmfolder > 70)
                 {
                     cout << "  [15]Lawyers and Legality" << endl;
                     rndmfolder_val = true;
                 }
                 cout << "  [16]About " << company_name << ".info" << endl
                      << "  [17]Web_Content04-09-09-1431.rar" << endl
                      << "  [18]_database__0X3_401" << rndmfile << ".exe" << endl
                      << "  [19]Company Logo.jpg" << endl;
                 dl_file_company[18]="true";
                 money_multiplier = rand()%5 + 10;
             }
             if (placeselected==3 & folder==2)
             {
                 if (specialfile1 > 80)
                 {
                     cout << "  [21]Production Statistics 2009.pdf"<< endl;
                     dl_file_company[21]="true";
                     money_multiplier = 0;
                 }
                 else
                 {
                     cout << "Folder is empty..." << endl;
                 }
             }
             if (placeselected==3 & folder==15 & rndmfolder_val==true)
             {
                 cout << "  [151]Worldwide Lawyers List.html" << endl
                      << "  [152]The Best at Lowest Price.html" << endl
                      << "  [153]Transforming Illegal to Legal.help" << endl
                      << "  [154]10 Things to Prepare Yourself from the Court.pdf" << endl;
                 if (specialfile2 > 80)
                 {
                     cout << "  [155]50%Off Lawyer(GET ONE NOW!).exe" << endl;
                     dl_file_company[155]="true";
                 }
                 cout << "  [156]Company Issues and Legality.pdf" << endl;
             }
             if (placeselected==3 & folder==11)
             {
                 cout << "  [111]Production Statistics 2005.doc" << endl
                      << "  [112]Production Statistics 2006.doc" << endl
                      << "  [113]Production Statistics 2007.doc" << endl
                      << "  [114]Production Statistics 2008.doc" << endl
                      << "  [115]Sales Output and Revenue.ppt" << endl
                      << "  [116]Discussion Meeting - Procuring of Raw Materials.ppt" << endl
                      << "  [118]Suggested Resolutions on Production Level.ppt" << endl;
             }
             if (placeselected==3 & folder==12)
             {
                 cout << "  [121]Employees List (Updated).xls" << endl
                      << "  [122]Job Interview (GUIDELINES).doc" << endl
                      << "  [123]Workload Breakdown.xls" << endl
                      << "  [124]Discussion Meeting - Accepting Potential Applicants.ppt" << endl
                      << "  [125]Staff Assignment and Occupations.xls" << endl;
                 if (jokefile1 > 30)
                 {
                     cout << "  [126]MONEY Hacked by a Company Employee(guilty).doc" << endl;
                     dl_file_company[126]="fake";
                 }
             }
             if (placeselected==3 & folder==13)
             {
                 cout << "  [131]Stock Holders.xls" << endl
                      << "  [132]Stock Market(Self-Updating).exe" << endl
                      << "  [133]Featured Stock Holders and Investors.xls" << endl
                      << "  [134]Global Market - Overview.graph" << endl;
                 if (specialfile1 > 60)
                 {
                     cout << "  [135]Stock HOLDERS BANK_KEYS.doc" << endl;
                     dl_file_company[135]="true";
                     money_multiplier = rand()%25 + 10;
                 }
             }
             if (placeselected==3 & folder==14)
             {
                 cout << "  [141]Employment Contracts.zip" << endl
                      << "  [142]Business Deals.db" << endl
                      << "  [143]Sales Contracts.db" << endl
                      << "  [144]Tax Payments 2008.doc" << endl;
                 if (specialfile1 > 75)
                 {
                     cout << "  [145]virus.trojan.worm.adware.spyware.bug.exe" << endl;
                     dl_file_company[145]="true";
                     money_multiplier = rand()%70 - 35;
                 }
                 else if (specialfile2 > 60)
                 {
                     cout << "  [146]Bank Accounts.secret" << endl;
                     dl_file_company[146]="true";
                     money_multiplier = rand()%25 + 10;
                 }
             }
             if (placeselected==3 & folder==3)
             {
                 cout << "  [31]Firewall.exe" << endl
                      << "  [32]Anti-Hacker.exe" << endl
                      << "  [33]Security Center.system" << endl
                      << "  [34]" << rndmfile << ".dll" << endl
                      << "  [35]" << company_name << " activation key.txt" << endl;
             }
             /*------------------------------------------------------*/
         }
         else if (hack_cmd == "keydecode" & keydecode == true & key_file_retry == true & key_file == true & (dl_file_house[folder]=="dltrue" || dl_file_bank[folder]=="dltrue" || dl_file_company[folder]=="dltrue") & connect_success == 1)
         {
              security_screen();
              cpu_hacktime--;
              cout << "@#!!$@$*&!@#(*&!*@DECODING KEYS#&*$&!*@#&*)!@&$" << endl;
              system("pause");
              cout << "958459829-5819035819358349538745801743" << endl;
              system("pause");
              cout << "3849285912-11514665873536-676231516894" << endl;
              system("pause");
              cout << "237182405415-15451-5-5-551-5235-235214" << endl;
              system("pause");
              cout << "8319-298591-2591823509182359-819235816" << endl;
              system("pause");
              cout << "84320483909019009204910384012039488058" << endl;
              system("pause");
              cout << endl << ">>>>SUPREME HACK!!!!!!<<<<<" << endl;
              cout << "Cash Hacked: $40,000" << endl;
              hand_money += 40000;
              key_file_retry == false;
              dl_file_house[folder]="false";
              dl_file_bank[folder]="false";
              dl_file_company[folder]="false";
         }    
         else if (hack_cmd == "f_find" & f_find == true & f_find_retry == true & connect_success == 1)
         {
              security_screen();
              cpu_hacktime--;
              chance_val = rand()%100;
              if (chance_val < (90-choice_chance))
              {
                  int random_hacked_file;
                  cout << "Integrated AutoHack Complete!" << endl;
                  cout << "Hacked coded files found: ";
                  if ((10 - cpu_speed)>=2 & (10 - cpu_speed)< 5 & chance_val <= 80)
                  {
                      cout << "1" << endl;
                      random_hacked_file = rand ()%100000 + 10000;
                      cout << "  " << random_hacked_file << ".code" << endl;
                      cout << "TOTAL MONEY HACKED: $" << (((choice_chance*3)/4)*100) << endl;
                      hand_money += (((choice_chance*3)/4)*100)*((chance_val/100)+1);
                  }
                  else if ((10 - cpu_speed)>=5 & (10 - cpu_speed)< 7 & chance_val <= 50)
                  {
                      cout << "2" << endl;
                      random_hacked_file = rand ()%100000 + 10000;
                      cout << "  " << random_hacked_file << ".code" << endl;
                      random_hacked_file = rand ()%100000 + 10000;
                      cout << "  " << random_hacked_file << ".code" << endl;
                      cout << "TOTAL MONEY HACKED: $" << (((choice_chance*3)/4)*100)*2 << endl;
                      hand_money += (((choice_chance*3)/4)*100)*2*((chance_val/100)+1);
                  }
                  else if ((10 - cpu_speed)>=7 & chance_val <= 20)
                  {
                      cout << "3" << endl;
                      random_hacked_file = rand ()%100000 + 10000;
                      cout << "  " << random_hacked_file << ".code" << endl;
                      random_hacked_file = rand ()%100000 + 10000;
                      cout << "  " << random_hacked_file << ".code" << endl;
                      random_hacked_file = rand ()%100000 + 10000;
                      cout << "  " << random_hacked_file << ".code" << endl;
                      cout << "TOTAL MONEY HACKED: $" << (((choice_chance*3)/4)*100)*3 << endl;
                      hand_money += (((choice_chance*3)/4)*100)*3*((chance_val/100)+1);
                  }
                  else
                  {
                      cout << "0" << endl;
                      cout << "TRY AGAIN NEXT TIME..." << endl;
                  }
              }
              else
              {
                  cout << "CANNOT EXECUTE f_find!" << endl;
                  cout << "SYSTEM Conflict!" << endl;
                  cout << "TRY AGAIN NEXT WEEK" << endl;
              }
              f_find_retry = false;
         }
         else if (hack_cmd == "f_find" & f_find == true & f_find_retry == false & connect_success == 1)
         {
              cout << "You've already used this command. Try again next session." << endl;
         }
         else if (hack_cmd == "f_info" & f_info == true & connect_success == 1)
         {
              security_screen();
              cpu_hacktime--;
              cout << endl << "PROCESSING BINARIES..." << endl;
              cout << "SEARCHING DATABASE..." << endl;
              cout << "FUNCTION complete!" << endl << endl;
              cout << "  [1]System FIREWALL CHANCE                     = " << choice_chance << "%" << endl;
              cout << "  [2]Your GUILTY CHANCE                         = " << guilty_chance << "%" << endl;
              cout << "  TOTAL Detection Chance per HACK TIME([1]&[2]) = " << (guilty_chance+choice_chance+choice_chance)/4 << "%" << endl;
              if (accessory12 == true)
              {
              cout << "  VPN connection! TOTAL Detection Chance now    = " << (guilty_chance+choice_chance+choice_chance)/8 << "%" << endl;
              }
              cout << "  specialfiles1 Chance appearance               = " << specialfile1 << "%" << endl;
              cout << "  specialfiles2 Chance appearance               = " << specialfile2 << "%" << endl;
              cout << "  fakefiles1 Chance appearance                  = " << jokefile1 << "%" << endl;
              cout << "  fakefiles2 Chance appearance                  = " << jokefile2 << "%" << endl;
         }
         else if (hack_cmd == "zap_fwall" & zap_fwall == true & connect_success == 1)
         {
              if (zap_fwall_retry == 1)
              {
                  cpu_hacktime--;
                  cout << endl << "\tPurging Firewall..." << endl;
                  cout << "\tDebuffing Syntax..." << endl;
                  cout << "\tFirewall Purging Complete! " << endl;
                  choice_chance -= choice_chance/2;
                  zap_fwall_retry = 0;
              }
              else
              {
                  cout << "You've already used 'zap_fwall'" << endl;
              }
         }
         else if (hack_cmd == "meltdown" & meltdown == true & cpu_warning == true & connect_success == 1)
         {
              cpu_hacktime--;
              cout << endl << "Commencing MELTDOWN!" << endl;
              cout << "WARNING! Please STEP away from your computer!" << endl;
              cout << "DANGER of risk from explosion!" << endl;
              system("pause");
              cout << "3" << endl;
              system("pause");
              cout << "2" << endl;
              system("pause");
              cout << "1" << endl;
              system("pause");
              cout << endl << "MELTDOWN Success!" << endl;
              cout << "- CRIMINAL CHANCE gained disappeared." << endl;
              cout << "Cost of Computer Damage(BETTER PC, HIGHER COSTS): $" << (hand_money/5)+(cpu_hacktime*500) << endl;
              criminal_chance = (100*(criminal_chance-choice_chance))/(100-choice_chance);
              hand_money -= (hand_money/5)+(cpu_hacktime*500);
              cpu_warning = false;
         }
         else if (hack_cmd == "emerg_dc" & emerg_dc == true & cpu_warning == true & connect_success == 1)
         {
              cpu_hacktime--;
              cout << ">*<%#!@#^&EMERGENCY%10DISCONNECTION%10ACTIVATED!@#*!@#" << endl;
              cout << "$*(#$*($&)!@#*&$)@*$^!^@#&@#^&$^&*$$#*)*($*@(&#*(!*($#" << endl;
              cout << "Please stand by..." << endl;
              cout << "$#@(" << endl;
              cout << "*$#*$84291849014501-509813058329580324-19481941-491" << endl;
              cout << "*#$&*&738401283701872480375835127459-195-1850151555" << endl;
              system("pause");
              system("cls");
              int random_number_effect=2;
              while (random_number_effect > 0)
              {
                  int random_number_effect2=1000;
                  while (random_number_effect2 > 0)
                  {
                      cout << rand()%10;
                      cout << "....................................";
                      random_number_effect2--;
                  }
                  random_number_effect--;
                  system("cls");
              }
              cout << "<computer>LINK TERMINATED!" << endl;
              cout << "          PHYSICAL AND ELECTRONIC IDENTITY MINIMIZED" << endl;
              cout << "          EMERGENCY ANONYMIZING COMPLETE!" << endl << endl;
              cout << "- CRIMINAL CHANCE gained is halved." << endl;
              criminal_chance += (((100*(criminal_chance-choice_chance))/(100-choice_chance))-criminal_chance)/2;
              cpu_warning = false;
              system("pause");
         }
         else if (hack_cmd == "f_exit" & f_exit == true)
         {
             cout << "Disconnecting..." << endl;
             security_screen();
             system("pause");
             break;
         }
         else
         {
             security_screen();
             cout << "Either [1] You're not connected yet" << endl
                  << "       [2] You typed a wrong command" << endl
                  << "       [3] You haven't learned that command yet" << endl;
         }
     }
     if (placeselected == 2)
     {
         for (bank_account_id = 1000; bank_account_id <= 1050; bank_account_id++)
         {
             dl_file_bank[bank_account_id] = "false";
         }
     }
     int i;
     for (i = 1100; i > 0; i--)
     {
         dl_file_house[i]="false";
         dl_file_bank[i]="false";
         dl_file_company[i]="false";
     }
     if (accessory11 == true)
        {
            accessory11_counter = 3;
        }
     cpu_hacktime = cpu_hacktime_reset;
     folder = 0;
     connect_success = 0;
     hack_attempts++;
     rndmfolder_val = false;
     cpu_warning = false;
}
/**************************START OF Decoding Screen****************************/
void decoding_screen()
{
     cout << "******************************************************************" << endl;
     cout << "WARNING! DECODING INCREASES THE CHANCE OF GETTING CAUGHT!" << endl;
     cout << "******************************************************************" << endl;
     cout << "Please wait while the program finishes all queries..." << endl;
//     if (placeselected == 2 || placeselected == 3)
//     {
//         money_multiplier = rand()%3 + 1.0;
//     }
     while (cpu_speed > 0)
     {
         security_screen();
         cout << "Minutes Left: "<< cpu_speed << endl;
         system("pause");
         cpu_speed --;
     }
     if (cpu_speed == 0)
     {
         cout << endl << "Downloading/Decoding complete!" << endl;
         if (dl_file_house[folder]=="dltrue" || dl_file_bank[folder]=="dltrue" || dl_file_company[folder] == "dltrue")
         {
             if (dl_file_house[213]=="dltrue" & placeselected == 1)
             {
                 cout << "YOU FOUND A WAY TO GET A FREE VPN!!!" << endl;
                 cout << "Note: VPN dercreases the chance of getting caught by" << endl
                      << "      the firewall by 1/2" << endl;
                 accessory12 = true;
                 dl_file_house[213]=="false";
             }
             else 
             {
                 cout << "Money Hacked: $" << random_money*money_multiplier << endl;
                 hand_money += random_money*money_multiplier;
                 cout << "Returning to command..." << endl;
                 system("pause");
                 dl_file_house[folder]="false";
                 dl_file_bank[folder]="false";
                 dl_file_company[folder]="false";
             }
         }
         else if (dl_file_house[folder]=="dlfake" || dl_file_bank[folder]=="dlfake" || dl_file_company[folder] == "dlfake")
         {
             cout << "Downloaded file does not contain possible monetary code." << endl;
             cout << "Try again next time or try another file" << endl;
             cout << "Returning to command..." << endl;
             system("pause");
             dl_file_house[folder]="false";
             dl_file_bank[folder]="false";
             dl_file_company[folder]="false";
         }
     }
     cpu_speed = cpu_speed_reset;
}
/*---------------------------SECURITY SCREEN----------------------------------*/
void security_screen()
{
     srand(time(NULL));
     chance_val = rand()%100;
     if (accessory11 == true)
     {
         if ((guilty_chance+choice_chance+choice_chance)/4 > chance_val & accessory11_counter == 0 & accessory12 != true)
         {
             int number_effect2 = 2;
             while (number_effect2 > 0)
             {
                 int number_effect = 1000;
                 while (number_effect > 0)
                 {
                     cout << rand()%10;
                     cout << "!!!!WARNING! UNAUTHORIZED ACCESS!!!!";
                     number_effect--;
                 }
             number_effect2--;
             }
             
             system("cls");
             cout << "!!!!WARNING! UNAUTHORIZED ACCESS!!!!      _____   " << endl;
             cout << "*$#PROCESSING COMPUTER SHUTDOWN...       /     \\  " << endl;
             cout << "*$#TERMINATING CONNECTION...!           /       \\ " << endl;
             cout << "*$#YOUR SYSTEM HAS BEEN TRACKED        | S T O P |" << endl;
             cout << "*$#DENYING ALL DATA                    |         |" << endl;
             cout << "                                        \\       / " << endl;
             cout << "- Suprema Antivirus and Firewall V8.6    \\_____/  " << endl;
             system("pause");
             cout << endl;
             if (cpu_hacktime >= 2)
             {
                 cpu_hacktime = 2;
             }
             criminal_chance = criminal_chance+(choice_chance*((100-criminal_chance)/100));
             cpu_warning = true;
             accessory11_counter = 4;
         }
         if ((guilty_chance+choice_chance+choice_chance)/8 > chance_val & accessory11_counter == 0 & accessory12 == true)
         {
             int number_effect2 = 2;
             while (number_effect2 > 0)
             {
                 int number_effect = 1000;
                 while (number_effect > 0)
                 {
                     cout << rand()%10;
                     cout << "!!!!WARNING! UNAUTHORIZED ACCESS!!!!";
                     number_effect--;
                 }
             number_effect2--;
             }
             
             system("cls");
             cout << "!!!!WARNING! UNAUTHORIZED ACCESS!!!!      _____   " << endl;
             cout << "*$#PROCESSING COMPUTER SHUTDOWN...       /     \\  " << endl;
             cout << "*$#TERMINATING CONNECTION...!           /       \\ " << endl;
             cout << "*$#YOUR SYSTEM HAS BEEN TRACKED        | S T O P |" << endl;
             cout << "*$#DENYING ALL DATA                    |         |" << endl;
             cout << "                                        \\       / " << endl;
             cout << "- Suprema Antivirus and Firewall V8.6    \\_____/  " << endl;
             system("pause");
             cout << endl;
             if (cpu_hacktime >= 2)
             {
                 cpu_hacktime = 2;
             }
             criminal_chance = criminal_chance+(choice_chance*((100-criminal_chance)/100));
             accessory11_counter = 3;
             cpu_warning = true;
         }
         accessory11_counter--;
     }
     else if (accessory11 != true)
     {
         if ((guilty_chance+choice_chance+choice_chance)/4 > chance_val & accessory12 != true)
         {
             int number_effect2 = 2;
             while (number_effect2 > 0)
             {
                 int number_effect = 1000;
                 while (number_effect > 0)
                 {
                     cout << rand()%10;
                     cout << "!!!!WARNING! UNAUTHORIZED ACCESS!!!!";
                     number_effect--;
                 }
             number_effect2--;
             cout << "\a";
             }
             
             system("cls");
             cout << "!!!!WARNING! UNAUTHORIZED ACCESS!!!!      _____   " << endl;
             cout << "*$#PROCESSING COMPUTER SHUTDOWN...       /     \\  " << endl;
             cout << "*$#TERMINATING CONNECTION...!           /       \\ " << endl;
             cout << "*$#YOUR SYSTEM HAS BEEN TRACKED        | S T O P |" << endl;
             cout << "*$#DENYING ALL DATA                    |         |" << endl;
             cout << "                                        \\       / " << endl;
             cout << "- Suprema Antivirus and Firewall V8.6    \\_____/  " << endl;
             system("pause");
             cout << endl;
             if (cpu_hacktime >= 2)
             {
                 cpu_hacktime = 2;
             }
             criminal_chance = criminal_chance+(choice_chance*((100-criminal_chance)/100));
             cpu_warning = true;
         }
         if ((guilty_chance+choice_chance+choice_chance)/8 > chance_val & accessory12 == true)
         {
             int number_effect2 = 2;
             while (number_effect2 > 0)
             {
                 int number_effect = 1000;
                 while (number_effect > 0)
                 {
                     cout << rand()%10;
                     cout << "!!!!WARNING! UNAUTHORIZED ACCESS!!!!";
                     number_effect--;
                 }
             number_effect2--;
             cout << "\a";
             }
             
             system("cls");
             cout << "!!!!WARNING! UNAUTHORIZED ACCESS!!!!      _____   " << endl;
             cout << "*$#PROCESSING COMPUTER SHUTDOWN...       /     \\  " << endl;
             cout << "*$#TERMINATING CONNECTION...!           /       \\ " << endl;
             cout << "*$#YOUR SYSTEM HAS BEEN TRACKED        | S T O P |" << endl;
             cout << "*$#DENYING ALL DATA                    |         |" << endl;
             cout << "                                        \\       / " << endl;
             cout << "- Suprema Antivirus and Firewall V8.6    \\_____/  " << endl;
             system("pause");
             cout << endl;
             if (cpu_hacktime >= 2)
             {
                 cpu_hacktime = 2;
             }
             criminal_chance = criminal_chance+(choice_chance*((100-criminal_chance)/100));
             cpu_warning = true;
         }
     }
}
/*-------------------------TRIAL_SCREEN---------------------------------------*/
void trial_screen()
{
    char lawyer_answer;
    cout << "\t*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*" << endl;
    cout << "\t*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*" << endl;
    cout << "\t*#                                                       #*" << endl;
    cout << "\t*#         YOU HAVE BEEN CAPTURED AND IMPRISONED!        #*" << endl;
    cout << "\t*#          NOW, YOU'RE ONLY WAITING FOR THE TRIAL       #*" << endl;
    cout << "\t*#               TO JUDGE YOUR INNOCENCE...              #*" << endl;
    cout << "\t*#                                                       #*" << endl;
    cout << "\t*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*" << endl;
    cout << "\t*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*" << endl;
    cout << endl;
    cout << "MONEY+BANK = $" << hand_money+bank_money << endl;
    cout << "GUILTY CHANCE = " << guilty_chance << "%" << endl;
    cout << "CRIMINAL CHANCE = " << criminal_chance << "%" << endl;
    cout << "TOTAL GUILTY CHANCE w/o LAWYER= " << (guilty_chance*0.3)+(criminal_chance*0.7) << "%" << endl << endl;
    cout << "Note: (a)PROVEN GUILTY = 1/2 MONEY+BANK Payment+$10,000 Payment+1/2 year prison" << endl;
    cout << "      (b)TOTAL GUILTY CHANCE is based on (30%)GUILTY CHANCE," << endl
         << "         (%70)CRIMINAL CHANCE & LAWYER" << endl;
    cout << "      (c)Hiring a lawyer: DECREASES TOTAL GUILTY CHANCE by 1/2" << endl;
    cout << "                          $20,000 Payment" << endl;
    cout << "      (d)After the TRIAL, CRIMINAL CHANCE will decrease by 1/4"<< endl;
    cout << endl;
    if (lawyer == true)
    {
        cout << "You already have a lawyer" << endl;
        cout << "TOTAL GUILTY CHANCE now = " << ((guilty_chance*0.3)+(criminal_chance*0.7))/2 << "%" << endl;
        total_guilty_chance = ((guilty_chance*0.3)+(criminal_chance*0.7))/2;
        system("pause");
        lawyer = false;
    }
    else if (lawyer != true)
    {
        while (1)
        {
            cout << "Do you want to hire a lawyer(y/n)? ";
            cin >> lawyer_answer;
            if (lawyer_answer=='y'||lawyer_answer=='Y')
            {
                cout << "You've hired a lawyer" << endl;
                cout << "TOTAL GUILTY CHANCE now = " << ((guilty_chance*0.3)+(criminal_chance*0.7))/2 << "%" << endl;
                total_guilty_chance = ((guilty_chance*0.3)+(criminal_chance*0.7))/2;
                hand_money -= 20000;
                break;
            }
            else if (lawyer_answer=='n'||lawyer_answer=='N')
            {
                cout << "You chose not to hire a lawyer." << endl;
                cout << "TOTAL GUILTY CHANCE now = " << ((guilty_chance*0.3)+(criminal_chance*0.7)) << "%" << endl;
                total_guilty_chance = ((guilty_chance*0.3)+(criminal_chance*0.7));
                break;
            }
            else
            {
                cout << "Wrong input! Please Try Again." << endl;
            }
        }
    }
    cout << endl;
    cout << "THE JUDGEMENT NOW HAS BEGUN!" << endl;
    cout << "Trial in progress..." << endl;
    system("pause");
    cout << endl << "<Judge>The verdict is now passed..." << endl;
    cout << "UPON DUE CONSIDERATION, IT IS HEREBY ORDERED," << endl
         << "ADJUDGED AND DECREED that the judgement of said district court, "<< endl 
         << "for the accused suspect, ";
    chance_val = rand()%100;
    if (chance_val < total_guilty_chance)
    {
        cout << "GUILTY beyond unreasonable doubts for criminal" << endl
             << "record of continuous hacking and tresspassing in private sectors." << endl;
        game_week += 24;
        hand_money = hand_money/2;
        bank_money = bank_money/2;
        hand_money -= 10000;
        float bank_interest_jailed = 24;
        while (bank_interest_jailed > 0)
        {
            bank_money += bank_money*0.005;
            bank_interest_jailed--;
        }
    }
    else if (chance_val > total_guilty_chance)
    {
        cout << "NOT GUILTY and lack necessary proofs and" << endl
             << "supports to verify and to hold concise judgement." << endl;
    }
    criminal_chance -= criminal_chance*.25;
    system("pause");
    system("cls");
}
