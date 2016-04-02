#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char filename[_MAX_PATH];
char title[255];
char backgroundColor[255];
char heading[255];
bool horizontalRule;
char paragraph[1024];
bool list;
int	 numberOfListItems;
char **listItems;
bool image;
char imageURL[_MAX_PATH];
bool hyperlink;
char hyperlinkName[255];
char hyperlinkURL[_MAX_PATH];

void getFilename();
void getTitle();
void getBackgroundColor();
void getHeading();
void getHorizontalRule();
void getParagraph();
void getList();
void getImage();
void getHyperlink();
void generateWebPage();

int main()
{
	getFilename();

	getTitle();

	getBackgroundColor();

	getHeading();

	getHorizontalRule();

	getParagraph();

	getList();

	getImage();

	getHyperlink();

	generateWebPage();

	return 0;
}

void getFilename()
{
	printf("Enter the path and filename of the web page: ");

	gets(filename);

	system("CLS");
}

void getTitle()
{
	printf("Enter the title of the web page: ");

	gets(title);

	system("CLS");
}

void getBackgroundColor()
{
	int i;

	printf("Choose the background color of the web page\n");
	printf("1. Black\n");
	printf("2. Maroon\n");
	printf("3. Green\n");
	printf("4. Olive\n");
	printf("5. Navy\n");
	printf("6. Purple\n");
	printf("7. Teal\n");
	printf("8. Gray\n");
	printf("9. Silver\n");
	printf("10. Red\n");
	printf("11. Lime\n");
	printf("12. Yellow\n");
	printf("13. Blue\n");
	printf("14. Fuchsia\n");
	printf("15. Aqua\n");
	printf("16. White: ");

	scanf("%d", &i);

	fflush(stdin);

	switch(i)
	{
	case 1:
		strcpy(backgroundColor, "#000000");
		break;
	case 2:
		strcpy(backgroundColor, "#800000");
		break;
	case 3:
		strcpy(backgroundColor, "#008000");
		break;
	case 4:
		strcpy(backgroundColor, "#808000");
		break;
	case 5:
		strcpy(backgroundColor, "#000080");
		break;
	case 6:
		strcpy(backgroundColor, "#800080");
		break;
	case 7:
		strcpy(backgroundColor, "#008080");
		break;
	case 8:
		strcpy(backgroundColor, "#808080");
		break;
	case 9:
		strcpy(backgroundColor, "#C0C0C0");
		break;
	case 10:
		strcpy(backgroundColor, "#FF0000");
		break;
	case 11:
		strcpy(backgroundColor, "#00FF00");
		break;
	case 12:
		strcpy(backgroundColor, "#FFFF00");
		break;
	case 13:
		strcpy(backgroundColor, "#0000FF");
		break;
	case 14:
		strcpy(backgroundColor, "#FF00FF");
		break;
	case 15:
		strcpy(backgroundColor, "#00FFFF");
		break;
	case 16:
		strcpy(backgroundColor, "#FFFFFF");
		break;
	default:
		getBackgroundColor();
		break;
	}

	system("CLS");
}

void getHeading()
{
	printf("Enter the heading of the web page: ");

	gets(heading);

	system("CLS");
}

void getHorizontalRule()
{
	int c;

	printf("Do you want a horizontal rule on the web page [Y,N]? ");

	c = getchar();

	fflush(stdin);

	switch(c)
	{
	case 'Y':
	case 'y':
		horizontalRule = true;
		break;
	default:
		horizontalRule = false;
		break;
	}

	system("CLS");
}

void getParagraph()
{
	printf("Enter the body paragraph of the web page (enter a blank line when you're finished):\n");

	while(true)
	{
		char s[255];

		gets(s);

		if(strlen(s) > 0)
		{
			strcat(paragraph, s);
			strcat(paragraph, "<BR>\n");
		}
		else
		{
			break;
		}
	}

	system("CLS");
}

void getList()
{
	int c;

	printf("Do you want a list on the web page [Y,N]? ");

	c = getchar();

	fflush(stdin);

	switch(c)
	{
	case 'Y':
	case 'y':
		list = true;
		break;
	default:
		list = false;
		break;
	}

	if(list == true)
	{
		printf("How many items do you want the list to contain? ");

		scanf("%d", &numberOfListItems);

		fflush(stdin);

		listItems = new char*[numberOfListItems];

		printf("Enter each list item:\n");

		for(int i = 0; i < numberOfListItems; i ++)
		{
			listItems[i] = new char[255];

			gets(listItems[i]);
		}
	}

	system("CLS");
}

void getImage()
{
	int c;

	printf("Do you want an image on the web page [Y,N]? ");

	c = getchar();

	fflush(stdin);

	switch(c)
	{
	case 'Y':
	case 'y':
		image = true;
		break;
	default:
		image = false;
		break;
	}

	if(image == true)
	{
		printf("Enter the URL of the image: ");

		gets(imageURL);
	}

	system("CLS");
}

void getHyperlink()
{
	int c;

	printf("Do you want a hyperlink on the web page [Y,N]? ");

	c = getchar();

	fflush(stdin);

	switch(c)
	{
	case 'Y':
	case 'y':
		hyperlink = true;
		break;
	default:
		hyperlink = false;
		break;
	}

	if(hyperlink == true)
	{
		printf("Enter the name of the hyperlink: ");

		gets(hyperlinkName);

		printf("Enter the URL: ");

		gets(hyperlinkURL);
	}

	system("CLS");
}

void generateWebPage()
{
	FILE *stream;

	printf("Generating web page ... ");

	stream = fopen(filename, "w");

	if(stream != NULL)
	{
		fprintf(stream, "<HTML>\n");
		fprintf(stream, "<HEAD>\n");
		fprintf(stream, "<TITLE>%s</TITLE>\n", title);
		fprintf(stream, "</HEAD>\n");
		fprintf(stream, "<BODY BGCOLOR=%s>\n", backgroundColor);
		fprintf(stream, "<FONT FACE=Arial,Verdana,Helvectica>\n");
		fprintf(stream, "<H1 ALIGN=CENTER>%s</H1>\n", heading);

		if(horizontalRule == true)
		{
			fprintf(stream, "<HR>\n"); 
		}
		
		fprintf(stream, "<P>%s</P>\n", paragraph);

		if(list == true)
		{
			fprintf(stream, "<UL>\n");

			for(int i = 0; i < numberOfListItems; i ++)
			{
				fprintf(stream, "<LI>%s\n", listItems[i]);
			}

			fprintf(stream, "</UL>\n");
		}

		if(image == true)
		{
			fprintf(stream, "<IMG SRC=%s>\n", imageURL);
			fprintf(stream, "<BR>\n");
		}

		if(hyperlink == true)
		{
			fprintf(stream, "<A HREF=\"%s\">%s</A>\n", hyperlinkURL, hyperlinkName);
		}

		fprintf(stream, "</FONT>\n");
		fprintf(stream, "</BODY>\n");
		fprintf(stream, "</HTML>");

		fclose(stream);

		printf("Web page was created successfully ...");
	}

	system("PAUSE");

	delete listItems;
}
