//PhoneBook 1.0 By Mark Miller Under GPL have fun thanks Richard Montgomery
//For dos and freedos i used visual c++ to compile im not sure how well it will work under others.
//I want to add a delete all function and some more cosmetics
//compiler directives
#include<fstream.h>
#include<conio.h>
#include<iostream.h>
#include<iomanip.h>
#include<string.h>
#include<stdlib.h>
//global structures and variables
  struct friend_node
    {
     char last_name[20];
     char first_name[15];
     char phone_num[12];
     friend_node *next;
    };
  friend_node *head_ptr;
  friend_node *current_ptr;
//function prototypes
void handle_choice(int choice);
void add_record();
void insert_node(friend_node *new_rec_ptr);
friend_node *position_insertion_point(char lastname[20]);
void make_node_new_head(friend_node *new_rec_ptr);
void add_node_to_end(friend_node *new_rec_ptr);
void move_current_to_end();
void display_list();
void delete_record();
void delete_head_of_list();
void delete_end_of_list(friend_node *previous_ptr);
void delete_from_middle_of_list(friend_node *previous_ptr);
int verify_delete();
void delete_node(friend_node *previous_ptr);
void delete_list();
void search_by_lastname();
void write_list_to_file();
void load_list_from_file();
void help_me();
char pause;
//main function
int main()
{
  cout << "Welcome to PhoneBook 1.0 for dos and freedos\n";
  cout << "Press Enter To Continue\n";
  cin.get(pause);
  system("cls");
  int choice;
  head_ptr = NULL;       // Initialize head pointer to NULL.
  load_list_from_file(); // Load data from the disk file into linked list.
  do
   { // Display menu.
    cout << "1 - Add record\n";
    cout << "2 - Display all records\n";
    cout << "3 - Search for friend by last name\n";
    cout << "4 - Delete record\n";
	cout << "5 - Help\n";
	cout << "6 - Exit program\n";
    cout << "Enter choice: ";
    cin >> choice;
    handle_choice(choice); // Call function to direct flow based on choice.
   } while(choice != 6);  // Repeat menu until user chooses to exit.
   return 0;
} // end of main function
// Function to direct program flow based on user's choice.
void handle_choice(int choice)
 {
  switch(choice) // choice is passed into the function by value.
   {
    case 1:  // If choice was to add a record to the database,
     add_record();  // call function to add a record to the linked list.
     break;
    case 2:  // If choice was to display all records in the database,
     display_list(); // call function to display all records in
     break;          // the linked list.
  	case 3:  // If choice was to search for a record in the database,
     search_by_lastname(); // call function to search for record by
     break;                // last name.
    case 4:  // If choice was to delete a record in the database,
     delete_record(); // call a function that searched for record
     break;	 // by last name and deletes it.
	case 5:  // If choice is for help
     help_me();
	 break;
	case 6:  // If choice was to exit,
     write_list_to_file();  // save database to a file and
     if(head_ptr != NULL)   // delete the list from memory.
      { 
       delete_list(); 
      }
     break;
	default : // If any other (invalid) choice was entered,
     cout <<"Invalid choice\n"; // display error message.
     break;
   }
 } // end of function handle_choice
// Function to add record to the linked list.
void add_record()
 {
  friend_node *new_rec_ptr; // Declare temporary pointer for the new node.
  new_rec_ptr = new friend_node; // Allocate memory for a new node and
                         // initialize pointer to point to it.
  if(new_rec_ptr != NULL) // If no error allocating memory, get data
   {  system("cls");                    // and insert node.
    // Get name and phone number from the user.
    cin.ignore(20,'\n');
    cout << "First Name: ";
    cin.get(new_rec_ptr->first_name,15);
    cin.ignore(20,'\n');
	cout << "Last Name: ";
    cin.get(new_rec_ptr->last_name,20);
    cin.ignore(20,'\n');
    cout << "Phone Number: ";
    cin.get(new_rec_ptr->phone_num,15);
    cin.ignore(20,'\n');
    insert_node(new_rec_ptr);
   }	
  else  // If error occurred allocating memory, display warning
   {    // and do not create node.
    cout << "WARNING: Memory error. New record cannot be added.\n";
   }system("cls");
 } // end of function add_record
// Function to insert new node into correct position in list.
void insert_node(friend_node *new_rec_ptr)
 {
system("cls");
  friend_node *before_ptr;
  friend_node *after_ptr;
  if(head_ptr == NULL)
   {                             // If no nodes exist, make the node
    new_rec_ptr->next = NULL;    // the head.
    head_ptr = new_rec_ptr;
   }
  else
   {
    if(strcmp(new_rec_ptr->last_name, head_ptr->last_name) < 0)
     {                                  // If new record comes before head,
      make_node_new_head(new_rec_ptr);  // make it the new head.
     }
    else                                // Else, determine where the new node
     {                                  // should be inserted.
      current_ptr = position_insertion_point(new_rec_ptr->last_name);
      before_ptr = current_ptr;      // Use pointers to keep track of nodes
      after_ptr = current_ptr->next; // on each side of the insertion point.
      if(after_ptr == NULL) // If after_ptr is NULL, the node needs to be
       {                    // added to the end of the list.
        add_node_to_end(new_rec_ptr);
       }
      else                  // Else add the node between the nodes pointed to
       {                    // by before_ptr and after_ptr.
        before_ptr->next = new_rec_ptr;
        new_rec_ptr->next = after_ptr;
       }
     }
    }
 } // end of function insert_node
// Function that positions current_ptr at the node before the position
// where the new node should be inserted.
friend_node *position_insertion_point(char lastname[20])
 {
  char temp_name[20];
  friend_node *temp_ptr;
  int tempint;
  if(head_ptr->next != NULL) // If more than one node exists, search the
   {                         // list for the correct insertion point.
    current_ptr = head_ptr;
    temp_ptr = current_ptr->next;
    strcpy(temp_name, temp_ptr->last_name);
    // Loop until the proper insertion point is located.
    tempint = strcmp(lastname,temp_name);
    while((tempint > 0) && (current_ptr->next !=NULL))
     {
      current_ptr = temp_ptr;
	  // check to see if the current node is the last node
	  if(current_ptr->next != NULL)
	  {
       temp_ptr = current_ptr->next;
       strcpy(temp_name, temp_ptr->last_name);
       tempint = strcmp(lastname,temp_name);
	  }
     }
   }
  else  // If only one node exists in the list, current_ptr is the same
   {    // as head_ptr. New node will be added to the end of the list.
    current_ptr = head_ptr;
   }
  return(current_ptr);
 } // end of function position_insertion_point
// Function that makes the node pointed to by new_rec_ptr the new
// head of the linked list. It handles the special case of inserting at
// the front of the list.
void make_node_new_head(friend_node *new_rec_ptr)
 {
  friend_node *temp_ptr;  // temporary pointer to keep track of the head

  temp_ptr = head_ptr;  // Set temp_ptr to point at the current head.
  new_rec_ptr->next = temp_ptr; // Make new nodes next pointer point to
  head_ptr = new_rec_ptr;       // current head and make new node the head.
 } // end of function make_node_new_head
// Function that adds a node to the end of the linked list. It handles
// the special case of inserting at the end of the list.
void add_node_to_end(friend_node *new_rec_ptr)
 {
  new_rec_ptr->next = NULL;  // Set next node pointer of new node to NULL.
  move_current_to_end();       // Make sure current_ptr is at end of list.
  current_ptr->next = new_rec_ptr; // Place new node at the end of the list.
 } // end of function add_node_to_end
// Function that moves current_ptr to end of the linked list.
void move_current_to_end()
 {
  current_ptr = head_ptr;  // Move temp_ptr to head of the list.
  while(current_ptr->next != NULL)
   {                             // Traverse list until NULL is reached.
    current_ptr = current_ptr->next;
   }
 } // end of function move_current_to_end
// Function that displays entire linked list.
void display_list()
 {
  char fullname[36];  // used to combine names into one array

  current_ptr = head_ptr;   // Move current_ptr to head of list.
  if(current_ptr != NULL)
   {
    cout << endl;
    cout << "Name                                Phone Number\n";
    cout << "----------------------------------- ------------\n";
    do
     {
      strcpy(fullname,""); // Clear fullname.
      strcat(fullname, current_ptr->last_name);  // Put last name, then a
      strcat(fullname, ", ");                    // comma, then the
      strcat(fullname, current_ptr->first_name); // first name into fullname.
      cout.setf(ios::left);
      cout << setw(36) << fullname;
	  cout.unsetf(ios::left);
      cout.setf(ios::right);
      cout << setw(12) << current_ptr->phone_num << endl;
      current_ptr = current_ptr->next; // Set current_ptr to next node.
	  cout <<  endl;
     } while(current_ptr != NULL); // Loop until end of list.
	 cout << "Press Enter to continue \n";
	 cin.get(pause);
	 cin.ignore(1,pause);
  system("cls"); }
  else  // If list is empty, display message.
   {
    cout << "\nNO RECORDS TO DISPLAY\n";
   }
 } // end of function display_list
// Function that searches linked list for the first occurrence of a given
// last name and displays the record to the screen.
void search_by_lastname()
 {
	system("cls");
  char search_string[20];  // Character array for last name to search for.
  current_ptr = head_ptr;  // Move current_ptr to head of list
                          // to begin search.
  cin.ignore(20,'\n');
  cout << "\nEnter the last name for which you want to search: ";
  cin.get(search_string,20);
  cin.ignore(20,'\n');
  // Loop until search_string is found or end of list is reached.
  while((current_ptr != NULL) && 
	   (strcmp(current_ptr->last_name, search_string) != 0))
   {
    current_ptr = current_ptr->next;
   }
  if(current_ptr != NULL) // If current_ptr is not NULL, then match was
   {                      // found.
    cout << "\nRECORD FOUND\n";
    cout << current_ptr->first_name << ' '
         << current_ptr->last_name << endl;
    cout << current_ptr->phone_num << endl;
   }
  else
   {
    cout << "NO MATCH FOUND\n";
	cout << "Press Enter to Contiune\n";
	cin.get(pause);
	system("cls");
   }
 } // end of function search_by_lastname
// Function that deletes individual nodes from the linked list.
void delete_record()
 {
	system("cls");
  char search_string[20];
  friend_node *previous_ptr;
  previous_ptr = NULL;     // Initialize previous_ptr to NULL.
  current_ptr = head_ptr;  // Move current_ptr to head of list
                           // to begin search.
  cin.ignore(20,'\n');
  cout << "\nEnter the last name of the friend you want to delete: ";
  cin.get(search_string,20);
  cin.ignore(20,'\n');
  // Loop to find matching record.
  while((current_ptr != NULL) && 
	   (strcmp(current_ptr->last_name, search_string) != 0))
   {
    previous_ptr = current_ptr;      // A pointer must be maintained that
    current_ptr = current_ptr->next; // points to the node before the node
   }                                 // to be deleted.
  if(current_ptr != NULL) // If current_ptr is not NULL, then match was
   {                      // found.
    cout << "\nRECORD FOUND\n";
    cout << current_ptr->first_name << ' '
         << current_ptr->last_name << endl;
    cout << current_ptr->phone_num << endl;
    if(verify_delete()) // Ask user if he/she wants to delete the record.
     {                               // If user wants to delete the record,
      delete_node(previous_ptr);     // delete the node that follows the
      cout << "\nRECORD DELETED\n";  // one pointed to by previous_ptr.
     }
    else                             // Otherwise, do nothing.
     {
      cout << "\nRECORD NOT DELETED\n";
     }
   }
  else // If no match for the record found, display message.
   {
    cout << "\nNO MATCH FOUND. NO RECORD DELETED.\n";
   }system("cls");
 } // end of function delete_record
//Function that delete's the file for reset.
void help_me()
{
help:
	int choice2;
	system("cls");
	cout << "Welcome to help please choose help type\n";
	cout << "1: What happened to my records\n";
	cout << "2: How do I clear all records\n";
	cout << "3: When will there be a new version\n";
	cout << "4: What will be in the new versions\n";
	cout << "5: Exit\n";
	cin >>  choice2;
	switch(choice2) //Menu for help 
	{
	case 1:
		cout << "Check the directory with the executable for a file named Friends.dat\n";
		cout << "If its not there its gone forever if renamed rename it to Friends.dat\n";
		cout << "Press enter to contiune\n";
		pause=getch();
		system("cls");
		goto help;
		break;
	case 2:
		cout << "Delete The file Friends.dat\n";
		cout << "Press Enter to contiune\n";
		pause=getch();
		system("cls");
		goto help;
		break;
	case 3:
		cout << "When I get time\n";
		cout << "Press Enter to contiune\n";
		pause=getch();
		system("cls");
		goto help;
		break;
	case 4:
		cout << "I hope to add the following\n";
		cout << "Multi User's and passwords\n";
		cout << "Encryption \n";
		cout << "Clear all records command\n";
		cout << "Bug fixes\n";
		cout << "Press Enter to contiune\n";
		pause=getch();
		system("cls");
		goto help;
		break;
	default:
		cout << "Press Enter To exit";
		cout << "Press Enter to contiune\n";
		break;
	}
} // end of function delete_all
// Function to ask user to verify intention to delete the node.
int verify_delete()
 {
  char YesNo;
  cout << "\nAre you sure (Y/N) ";
  cin >> YesNo;
  if((YesNo == 'Y') || (YesNo == 'y'))
   {
    return(1); // Return TRUE if user want to delete.
   }
  else
   {
    return(0); // Return FALSE if user does not want to delete.
   }
 } // end of function verify_delete
// Function that deletes node pointed to by current_ptr.
void delete_node(friend_node *previous_ptr)
 {
  if(current_ptr == head_ptr)  // If node to be deleted is the head of the
   {                           // list, call a special function that
    delete_head_of_list();     // deletes the first node in the list.
   }
  else
   {                           // Otherwise:
    if(current_ptr->next == NULL)       // If node to be deleted is at the
     {                                  // end of the list, call a special
      delete_end_of_list(previous_ptr); // function to delete that node.
     }
    else                       // Otherwise:
     {                                          // Delete the node from the
      delete_from_middle_of_list(previous_ptr); // middle of the list using
     }                                          // a function that does that.
   }
 } // end of function delete_node
//Function that deletes the head of the list.
void delete_head_of_list()
 {
  current_ptr = head_ptr;  // Make current_ptr point to the head of the list.
  if(head_ptr->next != NULL)
   {                              // If more than one node is in the list,
    head_ptr = current_ptr->next; // make second node in list the new head.
   }
  else                            // Otherwise, just set head_ptr to NULL
   {                              // to signal that the list is empty.
    head_ptr = NULL;
   }
  delete current_ptr; // Deallocate memory used by the deleted node.
 } // end of function delete_head_of_list
// Function that deletes the last node of the linked list.
void delete_end_of_list(friend_node *previous_ptr)
 {
  delete current_ptr; // Deallocate memory used by the deleted node.
  previous_ptr->next = NULL; // Make node before deleted node the end of list.
  current_ptr = head_ptr; // Set current_ptr to head to give it a value.
 } // end of function delete_end_of_list
// Function that deletes a node from the middle of the list.
void delete_from_middle_of_list(friend_node *previous_ptr)
 {
  // Set pointers of the nodes before and after the node to be deleted to
  // skip the node that is to be deleted.
  previous_ptr->next = current_ptr->next;
  delete current_ptr; // Deallocate memory used by the deleted node.
  current_ptr = head_ptr; // Set current_ptr to head to give it a value.
 } // end of function delete_from_middle_of_list
// Function that frees the memory used by the linked list.
void delete_list()
 {
  friend_node *temp_ptr;  // pointer used for temporary storage
  current_ptr = head_ptr;  // Move current_ptr to head of the list.
  do    // Traverse list, deleting as we go.
   {
    temp_ptr = current_ptr->next;   // Set temporary pointer to point
                                   // to the remainder of the list.
    delete current_ptr;   // Delete current node.
    current_ptr = temp_ptr;   // Set current_ptr to next node after the
   } while(temp_ptr != NULL); // deleted one.
 } // end of function delete_list
// Function to write linked list data to the data file.
void write_list_to_file()
 {
  ofstream outfile;  // output file pointer
  outfile.open("FRIENDS.DAT",ios::out);  // Open file for output.
  if (outfile)  // If no error occurred while opening the file,
   {            // it is okay to write the data to the file.
    current_ptr = head_ptr;  // Set current_ptr to head of list.
    if(head_ptr != NULL)  // If the list is not empty, begin
     {                    // writing data to the file.
      do    // Traverse list until the end is reached.
       {
        // Write the nodes data to the file.
        outfile << current_ptr->last_name << endl;
        outfile << current_ptr->first_name << endl;
        outfile << current_ptr->phone_num << endl;
        current_ptr = current_ptr->next;  // Move current_ptr to next node.
       } while(current_ptr != NULL); // Loop until end of list is reached.
     }
    // The word END OF FILE are written to the end of the file to make it
    // easy to locate the end of the file when the data is read back in.
    outfile << "END OF FILE" << endl;
    outfile.close(); // Close the file.
   }
  else // If an error occurs while opening the file, display a message.
   {
    cout << "Error opening file.\n";
   }
 } // end of function write_list_to_file
// Function to load the linked list from the data file.
void load_list_from_file()
 {
  friend_node *new_rec_ptr;
  ifstream infile;  // input file pointer
  int end_loop = 0;
  infile.open("FRIENDS.DAT",ios::in);  // Open file for input.
  if (infile)  // If no error occurred while opening file
   {           // input the data from the file.
    do
     {
      new_rec_ptr = new friend_node; // Allocate memory for a node.
      if(new_rec_ptr != NULL) // Check for allocation error.
       {
        // Get the next last name from the file.
        infile.get(new_rec_ptr->last_name,20);
        infile.ignore(20,'\n');
        // If the end of the file has not yet been reached, get other data.
	if((strcmp(new_rec_ptr->last_name, "") != 0) &&
	   (strcmp(new_rec_ptr->last_name, "END OF FILE") != 0))
         {
          infile.get(new_rec_ptr->first_name, 15);
          infile.ignore(20,'\n');
          infile.get(new_rec_ptr->phone_num, 15);
          infile.ignore(20,'\n');
          insert_node(new_rec_ptr);
         }
        else // If end of file has been reached, delete the most recently
         {   // created node and set the flag that ends the loop.
          delete new_rec_ptr;
          end_loop = 1;
         }
       }
      else  // If a memory allocation error occurs, display a message and
       {    // set the flag that ends the loop.
        cout << "WARNING: Memory error. Load from disk was unsuccessful.\n";
        end_loop = 1;
       }
     } while(end_loop == 0); // Loop until the end_loop flag becomes TRUE.
     infile.close(); // Close the file.
   }
  else  // If error occurred opening file, display message.
   {
    cout << "No usable data file located. List is empty.\n";
   }
 } // end of function load_list_from_file