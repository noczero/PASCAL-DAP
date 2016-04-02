/*****************************************************888
*Author      : AbhisekKr				*
*Description : To Beautify The C/C++ Code		*
*		Give proper indentation & comments      *
*Date Created: 14-OCTOBER-2007				*
*Date Edited : 18-OCTOBER-2007				*
*New Feature : File Handling, Text Parsing		*
********************************************************/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef struct Files2Correct
	{
		char sourceF[128], destF[128];
		struct Files2Correct *link;

	} iFile;
iFile *fhead, *flast;

typedef struct Comments
	{
		int Line;
		char Comment[50];
		struct Comments *link;
	} koment;
koment *khead, *klast;

int IndentComment(void);

int indentL1(char sourceFile[]);
int CSoptimize(void);
int indentL2(void);
//int indentSwitch(void);

int commentGREP();
int commentGEN(int Line, char Type[]);
int commenter();
void getstring(char String[]);

int FileNFO(void);

int main()
{
	iFile *ftmp;
	int retVal;
		khead=NULL;
		fhead=NULL;
	//INTRODUCTION
	printf("\n########################################");
	printf("\n#                                      #");
	printf("\n#          ABK 'C' Beautifier          #");
	printf("\n#             VERSION 1.0              #");
	printf("\n#                                      #");
	printf("\n########################################");
	printf("\n\nThis Application Is Designed For :  ");
	printf("\n   1.) Indenting Any 'C' Program CODE");
	printf("\n   2.) Basic Commenting that 'C' CODE");
	printf("\n\n########################################\n");
	printf("\n# http://abhikumar163.googlepages.com/ #\n");
	printf("\n########################################\n\n");
	
	//DATA INPUT
	retVal=FileNFO();
	if(retVal)
		printf("\n\n%d : Some ERROR in File Input Phase.",retVal);
	
	//DATA PROCESS
	retVal=IndentComment();
	if(retVal)
		printf("\n\n%d : Some ERROR in Indent-Comment Phase.",retVal);
	
	//RESULT OUTPUT	
	printf("\n########################################");
	printf("\n\nApplication Specific Indenting and");
	printf("\nCommenting has been performed.");
	printf("\nThe Processed Output File are:");
	ftmp=fhead;
	while(ftmp!=NULL)
	{
		printf("\n%s",ftmp->destF);
		ftmp=ftmp->link;
	}
	printf("\n\n########################################");
	remove("~tmpI1"); 
	remove("~tmpI2");
	return 0;
}

/***********************INDENTING AND COMMENTING*********************/
int IndentComment(void)
	{
		FILE *iptr, *optr;
		iFile *ftmp;

		char choice,c;

		for(ftmp=fhead; ftmp!=NULL; ftmp=ftmp->link)
		{
		//INDENTING SECTION
			if(indentL1(ftmp->sourceF)==0)
				printf("\n\nC Code Enhanced To LEVEL#1");
			if(CSoptimize()==0)
				printf("\n\nC Code :: Control Statements Optimized");
			if(indentL2()==0)
				printf("\n\nC Code Enhanced To LEVEL#2\n\n");
		
		//COMMENTING SECTIO
	//getc(stdin);
			printf("###############################################");
			printf("\n\nApplication has Basic Commenting available.");
			printf("\nDo you want to COMMENT the CODE");
			printf("\n\n\tTo Comment It Enter 'Y' or 'y'");
			printf("\n\tOr Any Other Key For NO Extra Comments\n\n");
			printf("###############################################");
			printf("\n\n\tCHOICE : ");
			choice=getc(stdin);
			if(choice == 'Y' || choice=='y')
			{
				if(commentGREP()==0)
					printf("\n\nLines GRABBED to CommentGenerator.");
				if(commenter()==0)
					printf("\n\nWrite Generated Comments.");
			}

		//preparing DESIRED File 'n DELETING TEMP FILEs
			if(choice == 'Y' || choice=='y')
				iptr=fopen("~tmpI2","r");
			else
				iptr=fopen("~tmpI1","r");
			optr=fopen(ftmp->destF,"w");
			while((c=getc(iptr)) != EOF)
				putc(c,optr);
			fclose(iptr);
			fclose(optr);
			remove("~tmpI1"); 
			remove("~tmpI2");
		}//for ftmp ends
		return 0;
	}
//main() ended

//indentL1() started
int indentL1(char SourceFile[])
	{
		FILE *iptr, *optr;
		char c, ifspace, lastC, check;
		char coment1, comentM;
		int NumSpaces, NumLines, NumSmBr, ifQuot, if1Quot, ifHash, ifCurly;
		printf("\nFile Processing Starts : %s\n",SourceFile);		
		iptr=fopen(SourceFile,"r");
		optr=fopen("~tmpI1","w"); 
		if(iptr==NULL || optr==NULL)
			{
				printf("\nFile Operation Faced Some Problem.");
				exit(0);
			}
		ifspace='n';
		ifQuot=0;
		ifHash=0;
		if1Quot=0;
		check='y';
		NumSmBr=0;
		ifCurly=0;
		NumLines=0;
		NumSpaces=0;
		coment1='n';
		comentM='n';
		while((c=getc(iptr)) != EOF)
			{

			    //handling proprocessor statements
			    if(ifHash==0 && c=='#' && ifQuot==0 && if1Quot==0 && coment1!='y' && comentM!='y')
					ifHash=1;
			    else if(ifHash==1 && ifQuot==0 && if1Quot==0 && coment1!='y' && comentM!='y')
			    {
					if(c=='\n' || lastC=='>')
							{	
								putc('\n',optr);
								ifHash=0;
								NumSpaces=0;
								NumLines++;
								ifHash=0;
							}
			    }     		
			    //handling single line comment
			    if(c=='/' && lastC=='/' && comentM=='n' && ifQuot==0 && if1Quot==0)
					coment1='y';
			    //handling multiple line comment
			    if(lastC=='/' && c=='*' && coment1=='n' && ifQuot==0 && if1Quot==0)
					comentM='y';
			    //regulating comments
			    if(coment1!='y' && comentM!='y')
			    {
				//squeezing whitespaces
					if(c=='	' || c=='\n' || c=='\t')
					{
						if(comentM!='S')
							c=' ';
						else
						{
							c='\n';
							comentM='n';
						}
					}
				//checking if double quote 'n single quote
					if(c=='\"' && ifQuot==0 && if1Quot==0 && lastC!='\\')
						{ifQuot=1;}//putc(ifQuot+48,optr);}
					else if(c=='\"' && ifQuot==1 && if1Quot==0  && lastC!='\\')
						{ifQuot=0;}//putc(ifQuot+48,optr);}
					if(c=='\'' && if1Quot==0 && ifQuot==0  && lastC!='\\')
						if1Quot=1;
					else if(c=='\'' && if1Quot==1 && ifQuot==0  && lastC!='\\')
						if1Quot=0;
					if(c!=' ')
					{
					//if Quote Not Started
						if(ifQuot==0 && if1Quot==0)
						{
						//if brackets then the counter
							if(lastC=='(')
								NumSmBr++;
							if(lastC==')')
								NumSmBr--;
							if(lastC=='{')
								ifCurly++;
							if(lastC=='}')
								ifCurly--;

							if(c=='#' || c=='{')
								if(lastC!=')' && NumSmBr<1)
								{	
								//printf("\n");
									putc('\n',optr);
									NumSpaces=0;
									NumLines++;
								}
							if(lastC==')' || lastC=='}')
								if(c==';' && NumSmBr<1)
									check='n';
							if(lastC==')' && ifCurly<1)
								if(NumSmBr<1 && check=='y' && c!=')' && ifHash==0)
								{	
								//printf("\n");
									putc('\n',optr);
									NumSpaces=0;
									NumLines++;
								}
							if(lastC=='{' || lastC=='}' || lastC==';') // || lastC==')' )
								if(NumSmBr<1 && check=='y' && c!=')' && ifHash==0)
								{	
								//printf("\n");
									putc('\n',optr);
									NumSpaces=0;
									NumLines++;
								}
					}//if QUOTE NOT ON
				//printing CHARACTER
			     		//printf("%c",c);
					putc(c,optr);
					ifspace='n';
					if(c!=' ')
						lastC=c;
					check='y';
				}// c is NOT SPACE
			   			
				if(c==' ' && ifspace=='n')
				{
					NumSpaces++;
					if(lastC!='{' || lastC!='}' || lastC!=')' || lastC!=';')//|| lastC!='>' )
						{
							//printf("%c",c);
							putc(c,optr);
						}
					ifspace='y';
				}//end if c is SPACE & no prev SPACE 
			   }//end handle commenting
			   else
			   {
				//handling single line comment end
				if(coment1 =='y' && c=='\n')
					coment1='n';
				//handling multiple line comment end
				if(comentM =='y' && lastC=='*' && c=='/')
					comentM='S';
				//printf("%c",c);
				putc(c,optr);
				ifspace='n';
				if(c!=' ')
					lastC=c;
				check='y';
			   }
				
			}//end while (read ch from file)
		fclose(iptr);
		fclose(optr);
		return 0;
	}
//indentL1() ends

//CSoptimize() starts
int CSoptimize(void)
{
	FILE *iptr, *optr;
	char c, lastC, prevC, tmpC, *lastW;
	char fif, felse, ffor, fwhile, fdo;
	char coment1, comentM;
	int wLen, numSemi, index, NumSmBr, ifQuot, if1Quot;

	iptr=fopen("~tmpI1","r"); 
	optr=fopen("~tmpI2","w"); 
	if(iptr==NULL || optr==NULL)
	{
		printf("\nFile Operation Faced Some Problem.");
		exit(0);
	}

	wLen=0;
	lastW=(char *)malloc(sizeof(char));
	lastW[0]='\n';
	fif='n';
	ffor='n';
	fwhile='n';
	felse='n';
	fdo='n';
	NumSmBr=0;
	coment1='n';
	comentM='n';
	ifQuot=0;
	if1Quot=0;

	while((c=getc(iptr)) != EOF)
	{
	    //handling single line comment
	    if(c=='/' && lastC=='/' && comentM=='n')
		coment1='y';
	    //handling multiple line comment
	    if(lastC=='/' && c=='*' && coment1=='n')
		comentM='y';
	    //regulating comments
	    if(coment1!='y' && comentM!='y')
	    {     		
		
		//checking if double quote 'n single quote
			if(c=='\"' && ifQuot==0 && if1Quot==0 && lastC!='\\')
				{ifQuot=1;}//putc(ifQuot+48,optr);}
			else if(c=='\"' && ifQuot==1 && if1Quot==0  && lastC!='\\')
				{ifQuot=0;}//putc(ifQuot+48,optr);}
			if(c=='\'' && if1Quot==0 && ifQuot==0  && lastC!='\\')
				if1Quot=1;
			else if(c=='\'' && if1Quot==1 && ifQuot==0  && lastC!='\\')
				if1Quot=0;
			if(ifQuot==0 && if1Quot==0 && c!=' ')
			{
				if(c=='(')
					NumSmBr++;
				if(c==')')
					NumSmBr--;
				if(c>96 && c<123)
				{
					wLen++;
					realloc(lastW,wLen*sizeof(char));
					lastW[wLen-1]=c;
					lastW[wLen]='\0';
				}//if CURR CHAR is SMALL CASE
				else
				{
					if(c=='i')
						getchar();
					wLen=0;
					if(!strcmp(lastW,"if"))
						fif='i';
					if(!strcmp(lastW,"else"))
						felse='i';
					if(!strcmp(lastW,"for"))
						ffor='i';
					if(!strcmp(lastW,"while"))
						fwhile='i';
					if(!strcmp(lastW,"do"))
						fdo='i';
				//handling ELSE IF
					if(fif=='i' && felse!='n')
						felse='n';
				//reinit last word for no recheck
					lastW[0]='\0';
				}//checking if last word a CS

		//BEGIN :: if Control Statement Second Level
				if(fif=='2' && lastC==';')
				{
					fif='n';
					//printf("\n}");
					putc('\n',optr);
					putc('}',optr);
				}

				if(ffor=='2' && lastC==';')
				{
					ffor='n';
					//printf("\n}");
					putc('\n',optr);
					putc('}',optr);
				}

				if(fwhile=='2' && lastC==';')
				{
					fwhile='n';
					//printf("\n}");
					putc('\n',optr);
					putc('}',optr);
				}

				if(fdo=='2' && lastC==';')
				{
					fdo='n';
					//printf("\n}");
					putc('\n',optr);
					putc('}',optr);
				}

				if(felse=='2' && lastC==';')
				{
					felse='n';
					//printf("\n}");
					putc('\n',optr);
					putc('}',optr);
				}
			//END   :: if Control Statement Second Level

			//BEGIN :: if Control Statement Proceeded
				if(fif=='y' && (c=='{' || c==';') )
				{
					if(prevC!='\n' && c!=';')
						putc('\n',optr);
					
					fif='n';
				}
				else if(fif=='y' && c!=' ' && c!='\n' && c!='\t')
				{
					fif='2';
					//printf("{\n");
					putc('\n',optr);
					putc('{',optr);
					putc('\n',optr);
				}

				if(ffor=='y' && (c=='{' || c==';') )
				{
					if(prevC!='\n' && c!=';')
						putc('\n',optr);
					
					ffor='n';
				}
				else if(ffor=='y' && c!=' ' && c!='\n' && c!='\t')
				{
					ffor='2';
					//printf("{\n");
					putc('\n',optr);
					putc('{',optr);
					putc('\n',optr);
				}

				if(fwhile=='y' && (c=='{' || c==';') )
				{
					if(prevC!='\n' && c!=';')
						putc('\n',optr);
					
					fwhile='n';
				}
				else if(fwhile=='y' && c!=' ' && c!='\n' && c!='\t')
				{
					fwhile='2';
					//printf("{\n");
					putc('\n',optr);
					putc('{',optr);
					putc('\n',optr);
				}

				if(fdo=='y' && (c=='{' || c==';') )
				{
					if(prevC!='\n' && c!=';')
						putc('\n',optr);
					
					fdo='n';
				}
				else if(fdo=='y' && c!=' ' && c!='\n' && c!='\t')
				{
					fdo='2';
					//printf("{\n");
					putc('\n',optr);
					putc('{',optr);
					putc('\n',optr);
				}

				if(felse=='y' && (c=='{' || c==';') )
				{
					if(prevC!='\n' && c!=';')
						putc('\n',optr);
					
					felse='n';
				}
				else if(felse=='y' && c!=' ' && c!='\n' && c!='\t')
				{
					felse='2';
					//printf("{\n");
					putc('\n',optr);
					putc('{',optr);
					putc('\n',optr);
				}
			//END   :: if Control Statement Proceeded

			//BEGIN :: if Control Statement initiated process
				if(fif=='i' && c==')' && NumSmBr<1)
					fif='y';
				if(ffor=='i' && c==')' && NumSmBr<1)
					ffor='y';
				if(fwhile=='i' && c==')' && NumSmBr<1)
					fwhile='y';
				if(fdo=='i' && c=='\n')
					fdo='y';
				else if(fdo=='i' && c=='{')
					fdo='n';
			//special case 'else' also handling 'else if'
				if(felse=='i' && c!=' ' && c!='\n' && c!='\t' && c!='i')
				{
					felse='2';
					putc('\n',optr);
					putc('{',optr);
					putc('\n',optr);
				}
				else if(felse=='i' && c=='i')
				{
					tmpC=getc(iptr);
					if(tmpC=='f')
					{	
						felse='n';
						fif='i';
					}
					else
					{
						felse='2';
						putc('\n',optr);
						putc('{',optr);
						putc('\n',optr);
					}
					putc(c,optr);
					lastC=c;
					if(c!=' ' && c!='\t')
						prevC=c;
					c=tmpC;
				}
				else if(felse=='i' && c=='\n')
					felse='y';
				else if(felse=='i' && c=='{')
					felse='n';
			//END   :: if Control Statement initiated process
			}

		//writing to file
		if(!(ffor=='i' && c=='\n'))
			putc(c,optr);
		//printf("%c",c);
		if(c!=' ' && c!='\t' && c!='\n')
			lastC=c;
	    }
	    else
	    {
		//handling single line comment end
		if(coment1 =='y' && c=='\n')
			coment1='n';
		//handling multiple line comment end
		if(comentM =='y' && lastC=='*' && c=='/')
			comentM='n';
		//printf("%c",c);
		putc(c,optr);
		if(c!=' ')
			lastC=c;
	    }
		if(c!=' ' && c!='\t')
			prevC=c;
	}//end WHILE FILE EOF
	fclose(iptr);
	fclose(optr);
	return 0;
}
//CSoptimize() ends

//indentL2() starts
int indentL2(void)
{
	FILE *iptr, *optr;
	char c, lastC;//, check;
	char *lastW, *currW;
	char bfor, bcase, coment1, comentM, caseSpace;
	int wLen, numsemi, numcase;
	int NumSpaces, index, NumSmBr;   //, NumLines
	iptr=fopen("~tmpI2","r");
	optr=fopen("~tmpI1","w"); 
	if(iptr==NULL || optr==NULL)
	{
		//printf("\nFile Operation Faced Some Problem.");
		exit(0);
	}
	wLen=0;
	//check='y';
	//NumLines=0;
	NumSpaces=0;
	NumSmBr=0;
	numsemi=0;
	numcase=0;
	bfor='n';
	coment1='n';
	comentM='n';
	caseSpace='n';
	lastW=(char *)malloc(sizeof(char));
	lastW[0]='\0';
	while((c=getc(iptr)) != EOF)
	{
	    //handling single line comment
	    if(c=='/' && lastC=='/' && comentM!='y')
		coment1='y';
	    //handling multiple line comment
	    if(lastC=='/' && c=='*' && coment1!='y')
		comentM='y';
	    //regulating comments
	    if(coment1!='y' && comentM!='y')
	    {
		//counting Small Brackets
		if(c=='(')
			NumSmBr++;
		if(c==')')
			NumSmBr--;
		//SPACING DONE
		if(lastC=='{')
			NumSpaces++;
		else if(c=='}')
			NumSpaces--;
		//if case proceeds
		if(bcase=='s' && c!=' ' && c!='\n' && c!='\t' && c!=':')
		{
			bcase='2';
printf("\n",c);
			putc('\n',optr);
			lastC='\n';
		}
		else if(bcase=='s' && c=='\n')
		{	
			bcase='2';
			lastC='\n';
		}
		if(lastC=='\n' && bfor=='n')
		{
			for(index=0;index<NumSpaces;index++)
			{
				putc('\t',optr);
printf("\t");
			}
		}
			
		//CODE FEEDED WITH NO EXTRA NEWLINE
		if(c>96 && c<123)
		{
printf("%c",c);
			putc(c,optr);
			wLen++;
			realloc(lastW,wLen*sizeof(char));
			lastW[wLen-1]=c;
			lastW[wLen]='\0';
		}
		else
		{
			//if LastWord is FOR
			if(!strcmp(lastW,"for"))
			{
				bfor='y';
				numsemi=0;
			}
			//if LastWord is CASE or BREAK
			if((!strcmp(lastW,"case")) || (!strcmp(lastW,"default")))
			{
				bcase='i';
				lastW[0]='\n';
				if(numcase==0)
				{
					numcase++;
					caseSpace='y';
				}
			}
			if(!strcmp(lastW,"break"))
			{
				bcase='n';
				NumSpaces-=numcase;
				numcase=0;
				caseSpace='n';
				lastW[0]='\0';
			}
			if(c=='}' && bcase=='2')
			{
				bcase='n';
				NumSpaces-=numcase;
				numcase=0;
				caseSpace='n';
				lastW[0]='\0';
			}
			//if case: starts
			if(bcase=='i' && c==':')
			{
				bcase='s';
				if(numcase==1 && caseSpace=='y')	
				{
					caseSpace='n';
					NumSpaces+=numcase;
				}
			}
			
			//printing char
			if(c!='\n')
			{
				putc(c,optr);
printf("%c",c);
			}
			else
			{
				if(bfor!='y' || lastC!=';')
					{
						putc(c,optr);
printf("%c",c);
					}
			}
			//checking for setting noNewL
			if(bfor=='y')
			{
				if(c==';')
				{
					if(numsemi<2)
						numsemi++;
					else
						bfor='n';
				}
				else if(c==')' && NumSmBr<1)
				{
					numsemi=0;
					bfor='n';
				}
			}
			
			//refreshing the last word var
			realloc(lastW,sizeof(char));
			wLen=0;
		}//end of if...else c>96....
		lastC=c;
	    }
	    else
	    {
	    	//handling single line comment ends
	    	if(coment1=='y' && c=='\n')
			coment1='n';
	    	//handling multiple line comment ends
	    	if(comentM=='y' && lastC=='*' && c=='/')
			comentM='n';
		putc(c,optr);
printf("%c",c);
		lastC=c;
	    }
	    
	}//end of while
	fclose(iptr);
	fclose(optr);
	return 0;
}
//indentL2() ends

//commentGREP() starts
int commentGREP()
{

	FILE *iptr, *optr;
	char c, lastC;//, check;
	char *lastW;
	char bcase, coment1, comentM;    // bfor,
	int wLen, ifQuot, if1Quot, NumCrBr;
	int NumLines, index;   //NumSpaces,
	iptr=fopen("~tmpI1","r");
	if(iptr==NULL)
	{
		printf("\nFile Operation Faced Some Problem.");
		exit(0);
	}
	wLen=0;
	//check='y';
	NumCrBr=0;
	NumLines=0;
	//NumSpaces=0;
	//bfor='n';
	coment1='n';
	comentM='n';
	if1Quot=0;
	ifQuot=0;
	lastW=(char *)malloc(sizeof(char));
	lastW[0]='\0';
	while((c=getc(iptr)) != EOF)
	{//printf("%c",c);
	    //handling single line comment
	    if(c=='/' && lastC=='/' && comentM!='y')
		coment1='y';
	    //handling multiple line comment
	    if(lastC=='/' && c=='*' && coment1!='y')
		comentM='y';

	    if(c=='\n')		
		NumLines++;

	    if(coment1!='y' && comentM!='y' && if1Quot==0 && ifQuot==0)
	    {
		if(c>96 && c<123)
		{
	//		printf("%c",c);
			
			wLen++;
			realloc(lastW,wLen*sizeof(char));
			lastW[wLen-1]=c;
			lastW[wLen]='\0';
		}
		else
		{
			wLen=0;
		/*	if(lastW!=NULL) 
			{
				getchar();
				puts(lastW);
			}
		*/	
			lastW[0]='\0';
		}

		//GENERATING COMMENT -[FOR]-
			if(!strcmp(lastW,"for"))
				if(commentGEN(NumLines,lastW))
					printf("\n%d Line's FOR not Commented", NumLines);
		
		//GENERATING COMMENT -[IF]-
			if(!strcmp(lastW,"if"))
				if(commentGEN(NumLines,lastW))
					printf("\n%d Line's IF not Commented", NumLines);
				
		//GENERATING COMMENT -[WHILE]-
			if(!strcmp(lastW,"while"))
				if(commentGEN(NumLines,lastW))
					printf("\n%d Line's WHILE not Commented", NumLines);

		//GENERATING COMMENT -[DO]-
			if(!strcmp(lastW,"do"))
				if(commentGEN(NumLines,lastW))
					printf("\n%d Line's DO not Commented", NumLines);

		//GENERATING COMMENT -[SWITCH]-
			if(!strcmp(lastW,"switch"))
				if(commentGEN(NumLines,lastW))
					printf("\n%d Line's SWITCH not Commented", NumLines);

			//lastW[0]='\0';
		//}
			    
		//checking if double quote 'n single quote
	    	if(c=='\"' && ifQuot==0 && if1Quot==0)
			ifQuot=1;
	    	else if(c=='\"' && ifQuot==1 && if1Quot==0)
			ifQuot=0;
	    	if(c=='\'' && if1Quot==0 && ifQuot==0)
			if1Quot=1;
	    	else if(c=='\'' && if1Quot==1 && ifQuot==0)
			if1Quot=0;
			    
		//counting curly braces
	    	if(c=='{')
			NumCrBr++;
	    	else if(c=='}')
			NumCrBr--;
		lastC=c;
	    }
	    else
	    {
	    	//handling single line comment ends
	    	if(coment1=='y' && c=='\n')
			coment1='n';
	    	//handling multiple line comment ends
	    	if(comentM=='y' && lastC=='*' && c=='/')
			comentM='n';
		lastC=c;
	    }

	   //checking if double quote 'n single quote
	   if(c=='\"' && ifQuot==0 && if1Quot==0)
		ifQuot=1;
	   else if(c=='\"' && ifQuot==1 && if1Quot==0)
	 	ifQuot=0;
	   if(c=='\'' && if1Quot==0 && ifQuot==0)
		if1Quot=1;
	   else if(c=='\'' && if1Quot==1 && ifQuot==0)
		if1Quot=0;
	    
	}//end of while
	fclose(iptr);
	return 0;	
}
//commentGREP() starts

//commentGEN() starts
int commentGEN(int Line, char Type[])
{
	koment *ktmp;
	ktmp=(koment *)malloc(sizeof(koment));
	if(ktmp==NULL)
	{
		puts("Memory Allocation Problem Occured.");
		exit(0);
	}
	if(khead==NULL)
	{
		khead=ktmp;
		klast=ktmp;
	}
	klast->link=ktmp;
	ktmp->Line=Line;
	if(!strcmp(Type,"for"))
		strcpy(ktmp->Comment,"//LOOP :: for -> ");
	if(!strcmp(Type,"if"))
		strcpy(ktmp->Comment,"//CONDITION :: if -> ");
	if(!strcmp(Type,"while"))
		strcpy(ktmp->Comment,"//LOOP :: while -> ");
	if(!strcmp(Type,"do"))
		strcpy(ktmp->Comment,"//LOOP :: do -> ");
	if(!strcmp(Type,"switch"))
		strcpy(ktmp->Comment,"//LOOP :: switch -> ");
	if(!strcmp(Type,"else"))
		strcpy(ktmp->Comment,"//CONDITION :: else -> ");
	ktmp->link=NULL;
	klast=ktmp;
	return 0;
}
//commentGEN ends

//commenter() starts
int commenter()
{
	FILE *iptr, *optr;
	koment *ktmp;
	int NumLines, index;//, choice;
	char c, LineChange, choice;
	char Author[50],Description[180];
	char DCreated[11],NFeature[180];
	ktmp=khead;
	NumLines=0;
	LineChange='n';
	choice='x';
	iptr=fopen("~tmpI1","r"); 
	optr=fopen("~tmpI2","w"); 
	if(iptr==NULL && optr==NULL)
	{
		printf("\nFile Operation Faced Some Problem.");
		exit(0);
	}
	//ENTERING PROGRAM DETAIL
getc(stdin);
	do{
		printf("\n\nWanna feed AUTHOR's SIGNATURE in CODE (y/n) : ");
		choice=getc(stdin);//scanf(" %d",&choice);
	}while(choice!='y' && choice!='n');//120 && choice!=110);
	if(choice==121)
	{
getc(stdin);
		printf("\nEnter Author's Name (Limit: 50 chars): ");
		getstring(Author);
		printf("\nEnter Code's Description (Limit: 180 chars): ");
		getstring(Description);
		printf("\nEnter Date of Creation (Limit: 16 chars): ");
		getstring(DCreated);
		printf("\nEnter Code's Feature (Limit: 180 chars): ");
		getstring(NFeature);
		//WRITING to FILE
		fputc('/',optr);
		for(index=0;index<79;index++)
			fputc('*',optr);
		fputc('\n',optr);
		fputs(" :: AUTHOR       :: ",optr);
		fputs(Author,optr);
		fputc('\n',optr);
		fputs(" :: DESCRIPTION  :: ",optr);
		fputs(Description,optr);
		fputc('\n',optr);
		fputs(" :: DATE CREATED :: ",optr);
		fputs(DCreated,optr);
		fputc('\n',optr);
		fputs(" :: CODE FEATURE :: ",optr);
		fputs(NFeature,optr);
		fputc('\n',optr);
		for(index=0;index<79;index++)
			fputc('*',optr);
		fputc('/',optr);
		fputc('\n',optr);
		fputc('\n',optr);
	}

	//COMMENTING STARTS
	while((c=getc(iptr)) != EOF)
	{
		if(c=='\n')
		{
			NumLines++;
			LineChange='y';
		}
		if(NumLines==ktmp->Line && LineChange=='y')
		{
			putc('\n',optr);
			fputs(ktmp->Comment,optr);
			if(ktmp->link!=NULL)
				ktmp=ktmp->link;
			LineChange='n';
		}
		putc(c,optr);
	}
	fclose(iptr);
	fclose(optr);
	return 0;
}
//commenter() ends

//getstring() starts
void getstring(char String[])
{ 
//lastC is used so that it can check */ is not entered anywhere avoiding COMMENT Limit
	char c, lastC;
	int index;
	index=0;
	while((c=getc(stdin)) != '\n')	
	{
		if(lastC=='*' && c=='/')
			String[index++]='|';
		else
			String[index++]=c;
		
		lastC=c;
	}
	String[index]='\0';
}
//getstring() ends

/***********************INDENTING AND COMMENTING*********************/


/**************************** FILE NFO ******************************/

//FileNFO() starts
int FileNFO(void)
{
	char choice;
	FILE *CHK;
	iFile *ftmp;
	choice='y';
	//reading Files NFO
	do{
		ftmp=(iFile *)malloc(sizeof(iFile));
		if(ftmp==NULL)
		{
			puts("Memory Allocation Problem Occured.");
			exit(0);
		}
		if(fhead==NULL)
		{
			fhead=ftmp;
			flast=ftmp;
		}
		flast->link=ftmp;
		printf("\n\nEnter NAME of SOURCE 'C' File: ");
		getstring(ftmp->sourceF);
		CHK=fopen(ftmp->sourceF,"r");
		if(CHK==NULL)
		{
			printf("\n\n\nERROR: No Such File In Current Directory.");
			printf("\nEnter VALID FILE Name.\n");
			if(fhead==ftmp)
			{
				fhead=NULL;
				flast=NULL;
			}
			free(ftmp);
			continue;	
		}
		fclose(CHK);
		printf("\n\nEnter NAME of DESTINATION 'C' File: ");
		getstring(ftmp->destF);

		ftmp->link=NULL;
		flast=ftmp;

		printf("\n\nDo you wanna process more files?");
		printf("\n\nEnter 'Y' or 'y' to Queue more files.");
		printf("\nEnter any other choice to proceed.");
		printf("\n\n\t\tChoice : ");
		choice=getc(stdin);
		getc(stdin);
	}while(choice=='y' || choice=='Y');	

	return 0;
}
//FileNFO() ends

/**************************** FILE NFO ******************************/
