//initializing the header files
#include<stdio.h>
#include<ctype.h>
#include<string.h>
#include<stdlib.h>

//defining the properties of the fields used in the program
#define NAMES 50
#define EMAIL 20
#define PHONE 20
#define ADDRESS 8
#define TOWN 10
#define SIZE 500
//declaring the functions
void welcome_note();
void record();
void view();
void search();
void del_rec();
void help();
void bye();
char info[SIZE];
//using stuctures that represent the fields in the program
struct addressbk
{
	char name [NAMES] ;
	char sname [NAMES] ;
	char emailadd [EMAIL] ;
	char address [ADDRESS];
	char town [TOWN];
	char phone [PHONE];
	char postcode [PHONE];
	char country[TOWN];
	char Target[NAMES];

} addressbk;
 
//initializing the files used in the program
FILE *Records;
FILE *rectemp;
FILE *Help;


//initializing of the main function
/****************************************************************************************************/
void main()
{		
	int choice=0;
		//using the system() statement to clear the screen
		system("cls");
		//using the sysytem (color) to create a user interface
		system("color 17");
		fflush(stdin);
		//initializing the welcome note
		welcome_note();
		printf("\nEnter your Choice here \t");
		scanf("%i",&choice);
		fflush(stdin);
		//!!using the switch statement to give an option to initialize the functions
	
	switch (choice)
	{	
	
			case 1:
				{
					system("cls");
					view(); 
				break;
				}

			case 2:
				{
					system("cls");
					record();
				break;
				}
			
			case 3:
				{	system("cls");
					search();
				break;
				}

			case 4:
				{	system("cls");
					del_rec();
				break;
				}

		case 5:
			{
				system("cls");
				system("color 47");
				help(); 
			break;
			}


		case 6:
			{
				system("cls");
				bye();
			break;
			}
		default:
			{
				
				printf("Please Only Choose Between NO. 1-6\n"); system("pause");
				system("cls");
				main();
			}


	}

}
/******************************************************************************************************/
//initializing the record function
void record()
{
		char choice2;
  
	printf("\n\t     @   @ @@@@@  @    @    @@@     @  @@@@@@@   @     ");
	printf("\n\t=====@@  @ @      @    @    @   @  @ @    @     @ @  =====");
	printf("\n\t=====@ @ @ @@@@   @ @@ @    @   @ @@@@@   @    @@@@@ =====");
	printf("\n\t=====@  @@ @      @@  @@    @   @ @   @   @    @   @ =====");
	printf("\n\t     @   @ @@@@@  @    @    @@@   @   @   @    @   @ \n\n\n\n");
	

	do
	{		//opening the Records file
			Records = fopen("Records.txt","a+");

	
			
			printf("Enter Name\n");
			fflush(stdin);
			scanf("%s",addressbk.name);
			

			printf("Enter Second Name\n");
			fflush(stdin);
			scanf("%s",addressbk.sname);
			

			printf("Enter E-mail address\n");
			fflush(stdin);
			scanf("%s",addressbk.emailadd);
			
			printf("Enter address\n");
			fflush(stdin);
			scanf("%s",addressbk.address);
			

			printf("Enter town\n");
			fflush(stdin);
			scanf("%s",addressbk.town);
			
			printf("Enter Country\n");
			fflush(stdin);
			scanf("%s",addressbk.country);
			

			printf("Enter Post Code no\n");
			fflush(stdin);
			scanf("%s",addressbk.postcode);
			

			printf("Enter Phone Number no\n");
			fflush(stdin);
			scanf("%s",addressbk.phone);
			
			//printing all the entries to the main file (Records.txt)
			fprintf(Records,"%s %s %s %s %s %s %s %s \n",addressbk.name,addressbk.sname,addressbk.emailadd,addressbk.address,addressbk.town,addressbk.country,addressbk.postcode,addressbk.phone);

			fflush(stdin);
			//closure of the records file.
			fclose(Records);
		
		
			
		//initializing the choice character to give on optin to continue
			printf("WOULD LIKE TO CONTINUE? Y/N \n");
			scanf("%c",&choice2);
			fflush(stdin);


		if (choice2=='n'||choice2=='N')
		{
			system("cls");
			main();
			
		}
	}while(choice2=='y'||choice2=='Y');
		




}
/****************************************************************************************************************/
//the view function
void view()
{
		
		char choice3;

	printf("\n\t          @    @@@  @@@  @@@@   @@@@@  @@@@  @@@@ @@@@@  @@@@    ");
	printf("\n\t=====    @ @   @  @ @  @ @   @  @     @     @     @     @   =====");
	printf("\n\t=====   @@@@@  @  @ @  @ @@@@   @@@@   @@@   @@@  @@@@   @@@   =====");
	printf("\n\t=====   @   @  @  @ @  @ @  @   @         @     @ @         @=====");
	printf("\n\t        @   @  @@@  @@@  @   @  @@@@@ @@@@  @@@@  @@@@@ @@@@\n\n\n\n");




   
//opening the Records file
		Records = fopen("Records.txt","a+");
		do
		{

			fgets(info,SIZE,Records);
			printf("%s\n",info);

		}while(!feof(Records));
			//closing the records file
			fclose(Records);
		//using the system() to pause the program until the user types in any key
		system("pause");

		printf("Search for records??(Y/N)\n");
		scanf("%c",&choice3);
		fflush(stdin);
		//using the toupper statemrnt to ensure that the character input in read in upper
		if (toupper(choice3)=='Y')
		{
			
		search();
		}

		else if(toupper(choice3)=='N')
		{
			fclose(Records);
			system("pause");
			system("cls");
			main();
		}

		else 
		{
			fclose(Records);
			system("cls");
			bye();
		}
		



}
/********************************************************************************************/
//the main menu/welcome function
void welcome_note()
{

	  
		printf("\n\t       @   @   @    @  @   @       @   @ @@@@@ @   @ @   @       ");
		printf("\n\t=====  @@ @@  @ @   @  @@  @       @@ @@ @     @@  @ @   @  =====");
		printf("\n\t=====  @ @ @ @@@@@  @  @ @ @       @ @ @ @@@@  @ @ @ @   @  =====");
		printf("\n\t=====  @   @ @   @  @  @  @@       @   @ @     @  @@ @   @  =====");
		printf("\n\t       @   @ @   @  @  @   @       @   @ @@@@@ @   @  @@@\n\n\n\n");
		
	//this statement displays the system time and date
	system("DATE/t");
	system("TIME/T");
		printf("\t\t*_*_*_*_*_*-^ADDRESS BOOK^-*_*_*_*_*_*_*\n\n\n");
		printf("\t\t ****************************************\n");
		printf("\t\t *	CHOOSE ONE BETWEEN (1-6)	*\n");
		printf("\t\t *--------------------------------------*\n");
	
		printf("\t\t *	1	=VIEW RECORDS		*\n");
	
		printf("\t\t *	2	=MAKE NEW ENTRIES	*\n");
	
		printf("\t\t *	3	=SEARCH RECORDS		*\n");
		
		printf("\t\t *	4	=DELETE RECORDS		*\n");
	
		printf("\t\t *	5	=HELP?			*\n");
	
		printf("\t\t *	6	=EXIT			*\n");
	
		printf("\t\t ****************************************\n");
		
		
}
/**************************************************************************************************/
//the help function
void help()
{	
int choice4;
		printf("\n\t\t          ?   ?  ?????  ?     ????      ");
		printf("\n\t\t   =====  ?   ?  ?      ?     ?   ?  ===");
		printf("\n\t\t   =====  ?????  ????   ?     ????  ====");
		printf("\n\t\t   =====  ?   ?  ?      ?     ?    =====");
		printf("\n\t\t          ?   ?  ?????  ????  ?   \n\n");
	
	
		printf("\t\t*?---------------------------------------?*\n\n\n");
		printf("\t\t*	How Can We Help You?              *\n\n");
		printf("\t\t*	1--About Record Viewer ver0.1     *\n\n");
		printf("\t\t*	2--Quick Help				      *\n\n");
		printf("\t\t*	3--Technical Support              *\n\n");
		printf("\t\t*	4-- Quit                          *\n\n\n");
		printf("\t\t*?***************************************?*\n\n");
		printf("\nEnter your Choice here \t");
		scanf("%i",&choice4);
		fflush(stdin);
		switch (choice4)
		{
				case 1:
				{	system("cls");
					printf("?????????????HELP!!!!!!!!!!!!!\n\n\n");
					printf("Address Book version 1.00\n");
					printf("Product Id 000-000-001\n");
					printf("This Product is lincenced to:\t");
					printf("********************\n");
					
					
					fflush(stdin);
					system("pause");
					system("cls");
						help();
					break;
				
				}

				case 2:
				{			system("cls");
							printf("Help File Found "); system("pause");system("cls");
							Help=fopen("Help.txt","r");

							do
							{
								fgets(info,SIZE,Help);
								printf("%s\n",info);
							}while(!feof(Help));

								fclose(Help);

								
								system("pause");
								fflush(stdin);
								system("cls");
								help();

					break;						
				}

				case 3:
				{
							system("cls");
							printf(" Contacts\n");
							printf("----------\n");
							printf("email:\t");
							printf("jonan's_prog*hotmail.com:\t\n");
							printf("tel:\t");
							printf("+254-733-787-624\n");
							printf("	+254-624-787-733\n");
							printf("Mailing Address\n");
							printf("Jonan's Programing\n");
							printf("   P.O. BOX,\n");
							printf("   1234,ELDORET,\n");
							printf("   KENYA\n\n\n");


							
							system("pause");
							system("cls");
							system ("color 47");
							help();
								
					break;
				}

				case 4:
				{				system("cls");
								printf("You Have Chosen To exit \n");
								printf("In order to view help at any time while using the \n");
								printf("the program press 5 in the main menu! \n");
								system("pause");
								system("cls");
								main();
								
					break;
				}
				default:
				{
				
							printf("Please Only Choose Between NO. 1-4\n"); system("pause");
							system("cls");
							help();
				}

		}

}



/***********************************************************************************************/
//the search funtion 
void search()
{
		
	//declaring the target variable Target 
    char Target[SIZE];
	//
	int Found=0;
	if((Records=fopen("Records.txt","r"))==NULL)
	
				printf("NO RECORDS THE FILE EMPTY!!!\n\n");
	
						else
						{
											system("cls");
							printf("\n\t\t        @@@@ @@@@@   @   @@@@   @@@  @   @       ");
							printf("\n\t\t=====  @     @      @ @  @   @ @   @ @   @  =====");
							printf("\n\t\t=====   @@@  @@@@  @@@@@ @@@@  @     @@@@@  =====");
							printf("\n\t\t=====      @ @     @   @ @  @  @   @ @   @  =====");
							printf("\n\t\t       @@@@  @@@@@ @   @ @   @  @@@  @   @ \n\n\n");

							printf("\n\n");
							printf("\t************** THE SEARCH MENU**********");
							printf("\n\n");
							printf("\tEnter Name to search:");
							fflush(stdin);
							//gets(Target);
							scanf("%s",Target);
										while(!feof(Records)&& Found==0)
												{
													fscanf(Records,"%s %s %s %s %s %s %s %s ",addressbk.name,addressbk.sname,addressbk.emailadd,addressbk.address,addressbk.town,addressbk.country,addressbk.postcode,addressbk.phone);
													if(strcmp(Target,addressbk.name)==0)
													Found=1;
												}
													if(Found)
													{
														printf(".......FILE FOUND\n");
														system("pause");
														system("cls");
														printf("1 FILE FOUND : \n\n\n");
														printf("First Name: %s\n",addressbk.name);
														printf("Second Name: %s\n",addressbk.sname);
														printf("E-mail: %s\n",addressbk.emailadd);
														printf("P.O. BOX : %s\n",addressbk.address);
														printf("Town: %s\n",addressbk.town);
														printf("Country: %s\n",addressbk.country);
														printf("Post Code: %s\n",addressbk.postcode);
														printf("Phone Number: %s\n",addressbk.phone);	
														system("pause");
														main();
													}	
													else if(!Found)
													{
														printf("SORRY FILE NOT FOUND\n");
														system("pause");
														main();
													}





													

														fclose(Records);

		
}
}
/*************************************************************************************************/						
//the delete function
/*void del_rec()
{


    char Target[SIZE];
	int Found=0;
							system("cls");
							printf("\n\t\t       @@@@   @@@@@  @    @@@@@ @@@@@@@ @@@@@        ");
							printf("\n\t\t=====  @   @  @      @    @        @    @       =====");
							printf("\n\t\t=====  @    @ @@@@   @    @@@@     @	@@@@    =====");
							printf("\n\t\t=====  @   @  @      @    @        @    @       =====");
							printf("\n\t\t       @@@@   @@@@@  @@@@ @@@@@    @    @@@@@  \n\n\n");

	//opening the temporary file
	rectemp=fopen("rectemp.txt","w");
	//checking if the Records file acctually contains data
	if((Records=fopen("Records.txt","r"))==NULL)
		printf("NO RECORDS FILE EMPTY!!!\n\n");
	
	else{
		
			printf("\n\n");
			printf("\t********* DELETE MENU***********\n\n");
			printf("\tEnter Name to Delete:");
			fflush(stdin);
			gets(Target);
			
			while(!feof(Records))
				{
						fscanf(Records,"%s %s %s %s %s %s %s %s ",addressbk.name,addressbk.sname,addressbk.emailadd,addressbk.address,addressbk.town,addressbk.country,addressbk.postcode,addressbk.phone);
						if (feof(Records))
							break;
					

							if(strcmp(Target,addressbk.name)!=0)
							//printing to the temporary file
							fprintf(rectemp,"%s %s %s %s %s %s %s %s  \n",addressbk.name,addressbk.sname,addressbk.emailadd,addressbk.address,addressbk.town,addressbk.country,addressbk.postcode,addressbk.phone);
						
						else
						{
							//when the file is found
							Found=1;
							printf(".......FILE FOUND\n");
							system("pause");
							printf("First Name:%s\n",addressbk.name);
							printf("Second Name:%s\n",addressbk.sname);
							printf("E-mail:%s\n",addressbk.emailadd);
							printf("P.O. BOX : %s\n",addressbk.address);
							printf("Town: %s\n",addressbk.town);
							printf("Country: %s\n",addressbk.country);
							printf("Post Code: %s\n",addressbk.postcode);
							printf("Phone Number: %s\n",addressbk.phone);	
							fflush(stdin);
							
							system("pause");
							system("cls");
							main();
						}
						
				}
							
									//incase the file does not exist
									 if(!Found)	
										printf("SORRY  NOT FOUND\n");
										system("pause");									
										
	}
		
		printf("\nRecord deleted");	
	fclose(Records);
		fclose(rectemp);
		remove("Records.txt");
		rename ("rectemp.txt","Records.txt");	
		main();								
									 
		
	
	
	
										//break;
									
										
									
		
		
											
}*/

/*************************************************************************************************/
	void bye()
	{
							printf("Thanks For Using This Program\n");
							printf("Contact us at 1234@5678.com   \n");

							printf("\n\t\t       @@@@  @   @ @@@@@ ");
							printf("\n\t\t=====  @   @  @ @  @      =====");
							printf("\n\t\t=====  @@ @    @   @@@@   =====");
							printf("\n\t\t=====  @   @   @   @      =====");
							printf("\n\t\t       @@@@    @   @@@@@ \n\n\n");
							printf("\n\t\t\t\t      program created by -_JoNaN AgWa_-\n");
							


	}
							
			
/***************************************************************************************************/
	void del_rec()
{
	
	
	//char name[NAMES];
    char Target[SIZE];
	int Found=0;
		system("cls");
							printf("\n\t\t       @@@@   @@@@@  @    @@@@@ @@@@@@@ @@@@@        ");
							printf("\n\t\t=====  @   @  @      @    @        @    @       =====");
							printf("\n\t\t=====  @    @ @@@@   @    @@@@     @	@@@@    =====");
							printf("\n\t\t=====  @   @  @      @    @        @    @       =====");
							printf("\n\t\t       @@@@   @@@@@  @@@@ @@@@@    @    @@@@@  \n\n\n");
	rectemp=fopen("rectemp.txt","w");
	if((Records=fopen("Records.txt","r"))==NULL)
		printf("NO RECORDS FILE EMPTY!!!\n\n");
	
					else{
		
							printf("\n\n");
							printf("\t***********THE DELETE MENU***********");
							printf("\n\n");
							printf("\tEnter Name to Delete: ");
							fflush(stdin);
							gets(Target);
			while(!feof(Records))
			{
			
			fscanf(Records,"%s %s %s %s %s %s %s %s ",addressbk.name,addressbk.sname,addressbk.emailadd,addressbk.address,addressbk.town,addressbk.country,addressbk.postcode,addressbk.phone);
			if(feof(Records))
			break;
		if(strcmp(Target,addressbk.name)!=0)
			
			fprintf(rectemp,"%s %s %s %s %s %s %s %s  \n",addressbk.name,addressbk.sname,addressbk.emailadd,addressbk.address,addressbk.town,addressbk.country,addressbk.postcode,addressbk.phone);
						else {
		
								Found=1;
							printf(".......FILE FOUND\n");
							system("pause");
							printf("First Name:%s\n",addressbk.name);
							printf("Second Name:%s\n",addressbk.sname);
							printf("E-mail:%s\n",addressbk.emailadd);
							printf("P.O. BOX : %s\n",addressbk.address);
							printf("Town: %s\n",addressbk.town);
							printf("Country: %s\n",addressbk.country);
							printf("Post Code: %s\n",addressbk.postcode);
							printf("Phone Number: %s\n",addressbk.phone);	
							fflush(stdin);
							system("pause");
							}
							}
			if (!Found)
			{
			printf("\tRECORD NOT FOUND\n");//incase no files are located
			}
		printf("\tRECORD DELETED!!\n");
		
		fclose(Records);
		fclose(rectemp);
		remove("Records.txt");
		
		rename("rectemp.txt","Records.txt");
		
				
				main();	}
				
	}
//}


