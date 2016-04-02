/*
This file copy program has the additional feature of allowing the user to specify what part of the file he or she wants to copy.

This is especially useful when only some part of an audio or a video file has to be copied (except when the file is not being copied from the beginning).

It's one of my first programs, so please comment on how I may improve it (like avoiding the overwriting of existing files and including a copy progress indicator).

I hope that beginners like me will find this code useful.
*/

/*filecopy.c : can copy files partly*/
#include <stdio.h>
#include <stdlib.h>

int file_copy(char *oldname, char *newname, long bytes1, long bytes2);
long get_bytes(float percent, char *source);
main()
{
	char source[80], destination[80];
	float percent1, percent2;
			
	/*Get the file names*/
	puts("Enter source file:");
	printf("\t");
	gets(source);
	puts("\nEnter destination file \(WARNING: If the file exists, it will be OVERWRITTEN\): ");	
	printf("\t");
	gets(destination);
	
	/*Get the positions in percentage*/
	puts("\nEnter start percentage (recommended: 0): ");
	printf("\t");
	scanf("%f", &percent1);
	do
	{
		puts("\nEnter end percentage:");
		printf("\t");
		scanf("%f", &percent2);
	} while ( percent2 < percent1 );


	if ( file_copy( source, destination, get_bytes(percent1, source), get_bytes(percent2, source) ) == 1 )
		puts("\nCopy operation SUCCESSFUL");
	else
		fprintf(stderr, "\nError during copy operation");

	fflush(stdin);
	puts("\nPress any key to exit . . . ");
	getchar();
	return(0);
}

/*Function for actual copying of file, return 1 on success, 0 otherwise*/
int file_copy( char *oldname, char *newname, long bytes1, long bytes2)
/*bytes1 denotes the start position in bytes, bytes2 denotes the end position*/
{
	FILE *fold, *fnew;
	int c;

	if ( ( fold = fopen( oldname, "rb" ) ) == NULL )
		return 0;

	if ( ( fnew = fopen( newname, "wb" ) ) == NULL  )
	{
		fclose ( fold );
		return 0;
	}
		
	/*Set file pointer to proper start location, as specified by user*/
	if ( ( fseek(fold, bytes1, SEEK_SET) != 0 ) )
	{
		fprintf(stderr, "\nError using fseek().");
		exit(1);
	}

	while (1)
	{
		c=fgetc(fold);

		/*Continue copying until end of file or until the requested limit has been reached*/
		if ( !feof( fold ) && ftell(fold) <= bytes2)
			fputc( c, fnew );
		else
			break;
	}

	fclose ( fnew );
	fclose ( fold );

	return 1;
}


/*This function finds how many bytes need to copied, calculating it from the percentage inputted by the user*/
long get_bytes(float percent, char *source)
{
	long bytes;
	FILE *fold;

	if (percent<=100)
	{
		if ( ( fold = fopen( source, "rb" ) ) == NULL )
		{
			puts("Error opening source file");
			exit(1);
		}
		if ( (fseek(fold, 0, SEEK_END))!=0)
		{
			fprintf(stderr, "\nError using fseek().");
			exit(1);
		}

		bytes=ftell(fold);
		bytes*=(percent/100);
	}
	else 
	{
		fprintf(stderr, "Error in input");
		exit(1);
	}

	fclose(fold);
	return bytes;
}
