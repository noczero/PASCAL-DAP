#include <stdio.h>

int main()
{
   int option;
   char name[18];
   char name2[25];
   char addr[50];
   char county[30];
   char town[30];
   char post[10];
   char phone[25];
   char text[50];
   char *line = { "\n---------------------------------------------- \n" };
   char *nameinput = { "First Name: " };
   char *nameinput2 = { "Second Name: " };
   char *addrinput = { "Address: " };
   char *countyinput = { "County: " };
   char *towninput = { "Town: " };               // Made by Logicport
   char *postinput = { "Postcode: " };
   char *phoneinput = { "Phone Number: " };
   char *newline = "\n";
   FILE *file_ptr;
   file_ptr = fopen("address.dat", "a");
   if(file_ptr != NULL)
   {
      system("cls");
      printf("Address Book V.1 (Made by Logicport) \n");
      printf(" \n");
      printf("Options Currently Available \n");
      printf(" \n");
      printf("1. Add a new Contact \n");
      printf("2. Current Addresses \n");
      printf("3. Delete all Contacts \n");
      printf("4. Exit \n");
      printf(newline);
      printf("Please Choose a Option: ");
      scanf("%d", &option);
      fclose(file_ptr);
   }
   if(option == 1)
   {
      file_ptr = fopen("address.dat", "a");
      if(file_ptr != NULL)
      {
         printf("Input Started \n");
         printf(newline);
         fputs(line, file_ptr);
	  
         printf("Please Enter First Name: ");
          fputs(nameinput, file_ptr);
          fflush(stdin);
	 fgets(name, 18, stdin);
	 fputs(name, file_ptr);
         
	 printf("Please Enter Second Name: ");
          fputs(nameinput2, file_ptr);
          fflush(stdin);
	 fgets(name2, 25, stdin);
          fputs(name2, file_ptr);
         
	 printf("Please Enter Address: ");
          fputs(addrinput, file_ptr);
           fflush(stdin);
	  fgets(addr, 50, stdin);
          fputs(addr, file_ptr);

	 printf("Please Enter Town: ");
          fputs(towninput, file_ptr);
           fflush(stdin);
	  fgets(town, 30, stdin);
          fputs(town, file_ptr);        

    
	 printf("Please Enter County: ");
          fputs(countyinput, file_ptr);
           fflush(stdin);
	  fgets(county, 30, stdin);
          fputs(county, file_ptr);

	 printf("Please Enter Postcode: ");
          fputs(postinput, file_ptr);
           fflush(stdin);
          fgets(post, 10, stdin);
          fputs(post, file_ptr);

         printf("Please Enter Phone Number: ");
          fputs(phoneinput, file_ptr);
           fflush(stdin);
	  fgets(phone, 25, stdin);
          fputs(phone, file_ptr);
         printf("Information Saved, Thankyou! \n");
         system("pause");
	}
      fclose(file_ptr);
   }
   else if(option == 2)
   {
      file_ptr = fopen("address.dat", "r");
      if(file_ptr != NULL)
      {
         system("cls"); 
	 printf("Current Entries: \n");
         while(fgets(text, 50, file_ptr) != NULL)
         {
            printf("%s", text);
            printf(newline);
         }
         printf("End of File \n");
	 system("Pause");
         fclose(file_ptr);
      }
   } 
   else if(option == 3)
   {
      system("del address.dat");
      printf("All contacts Deleted \n");
      system("Pause");
   }
   
   else if(option == 4)
   {
      exit(1);
   }
   else
   {
      printf("Incorrect Input!\n");
   }
   return 0;
}


