/*
 * Compress - data compression program
 */
#define	min(a,b)	((a>b) ? b : a)

# define BITS   16
#define HSIZE 1L<<BITS
/*
 * a code_int must be able to hold 2**BITS values of type int, and also -1
 */
#if BITS > 15
typedef long int	code_int;
#else
typedef int		code_int;
#endif

#ifdef SIGNED_COMPARE_SLOW
typedef unsigned long int count_int;
typedef unsigned short int count_short;
#else
typedef long int	  count_int;
#endif

#ifdef NO_UCHAR
 typedef char	char_type;
#else
 typedef	unsigned char	char_type;
#endif /* UCHAR */
char_type magic_header[] = { "\037\235" };	/* 1F 9D */

/* Defines for third byte of header */
#define BIT_MASK	0x1f
#define BLOCK_MASK	0x80
/* Masks 0x40 and 0x20 are free.  I think 0x20 should mean that there is
   a fourth header byte (for expansion).
*/
#define INIT_BITS 9			/* initial number of bits/code */

/*
 * compress.c - File compression ala IEEE Computer, June 1984.
 *
 * Authors:	Spencer W. Thomas	(decvax!harpo!utah-cs!utah-gr!thomas)
 *		Jim McKie		(decvax!mcvax!jim)
 *		Steve Davies		(decvax!vax135!petsd!peora!srd)
 *		Ken Turkowski		(decvax!decwrl!turtlevax!ken)
 *		James A. Woods		(decvax!ihnp4!ames!jaw)
 *		Joe Orost		(decvax!vax135!petsd!joe)
 *
 * modified for MS-DOS, decompression only, by B.D. Ripley, 1/90
 *		b.d.ripley@uk.ac.strath.vaxa
 */

#include <stdio.h>
#include <ctype.h>
#include <alloc.h>
#include <sys/types.h>
#include <sys/stat.h>

#define ARGVAL() (*++(*argv) || (--argc && *++argv))

int n_bits;				/* number of bits/code */
int maxbits = BITS;			/* user settable max # bits/code */
code_int maxcode;			/* maximum code, given n_bits */
code_int maxmaxcode = 1L << BITS;	/* should NEVER generate this code */
# define MAXCODE(n_bits)	((1L << (n_bits)) - 1)

char_type huge *htab;
unsigned short huge *codetab;
count_int fsize, hsize;

#define tab_prefixof(i)	codetab[i]
#define tab_suffixof(i)	htab[i]

char_type *de_stack;

code_int free_ent = 0;			/* first unused entry */
int exit_stat = 0;

code_int getcode();

Usage() {
fprintf(stderr,"Usage: decomp infile outfile\n");
}

int nomagic = 0;	/* Use a 3-byte magic number header, unless old file */
int zcat_flg = 0;	/* Write output on stdout, suppress messages */
int quiet = 1;		/* don't tell me about compression */

/*
 * block compression parameters -- after all codes are used up,
 * and compression rate changes, start over.
 */
int block_compress = BLOCK_MASK;
int clear_flg = 0;
long int ratio = 0;
/*
 * the next two codes should not be changed lightly, as they must not
 * lie within the contiguous general code space.
 */
#define FIRST	257	/* first free entry */
#define	CLEAR	256	/* table clear output code */

char ifname[100], ofname [100];

char_type rmask[9] = {0x00, 0x01, 0x03, 0x07, 0x0f, 0x1f, 0x3f, 0x7f, 0xff};


/*****************************************************************
 * TAG( main )
 *
 * Algorithm from "A Technique for High Performance Data Compression",
 * Terry A. Welch, IEEE Computer Vol 17, No 6 (June 1984), pp 8-19.
 *
 * Algorithm:
 * 	Modified Lempel-Ziv method (LZW).  Basically finds common
 * substrings and replaces them with a variable size code.  This is
 * deterministic, and can be done on the fly.  Thus, the decompression
 * procedure needs no input table, but tracks the way the table was built.
 */

main( argc, argv )
register int argc; char **argv;
{
    struct stat statbuf;


    if (argc <  3) {Usage(); exit(1);}
    strcpy (ifname , argv[1]);
    strcpy (ofname , argv[2]);

    if(maxbits < INIT_BITS) maxbits = INIT_BITS;
    if (maxbits > BITS) maxbits = BITS;
    maxmaxcode = 1L << maxbits;

		/* Open input file */
		if ((freopen(ifname, "rb", stdin)) == NULL) {
			perror(ifname); exit(1);
		}
		stat(ifname, &statbuf);
		fsize = statbuf.st_size;
		/* Another Turbo C bug -- can return wrong file sizes*/
		if (fsize < 0) fsize = 1000000;
		/* Check the magic number */
		if (nomagic == 0) {
		    if ((getchar() != (magic_header[0] & 0xFF))
		     || (getchar() != (magic_header[1] & 0xFF))) {
			fprintf(stderr, "%s: not in compressed format\n",
			    ifname);
		    exit(1);
		    }
		    maxbits = getchar();	/* set -b from file */
		    block_compress = maxbits & BLOCK_MASK;
		    maxbits &= BIT_MASK;
		    maxmaxcode = 1L << maxbits;
		    if(maxbits > BITS) {
			fprintf(stderr,
			"%s: compressed with %d bits, can only handle %d bits\n",
			ifname, maxbits, BITS);
			exit(1);
		    }
		}
	    /* Check for overwrite of existing file */
		if (stat(ofname, &statbuf) == 0) {
		    char response[2];
		    response[0] = 'n';
		    fprintf(stderr, "%s already exists;", ofname);
			fprintf(stderr, " do you wish to overwrite %s (y or n)? ",
			ofname);
			fflush(stderr);
			read(2, response, 2);
			while (response[1] != '\n') {
			    if (read(2, response+1, 1) < 0) {	/* Ack! */
				perror("stderr"); break;
			    }
			}
		    if (response[0] != 'y') {
			fprintf(stderr, "\tnot overwritten\n");
			exit(1);
		    }
		}
		if (freopen(ofname, "wb", stdout) == NULL) {
		    perror(ofname);
		    exit(1);
		}

    hsize = min(HSIZE, fsize); /* cannot have more codes than file size */
    htab = (char_type huge*)farcalloc(hsize, sizeof(char_type));
    if (htab == NULL) {
	fprintf(stderr,"Not enough memory\n");
	fprintf(stderr,"Far heap size %lu hsize %u\n",farcoreleft(), hsize);
	exit(1);
	}
    codetab = (unsigned short huge*)farcalloc(hsize, sizeof(unsigned short));
    if(codetab == NULL) {
	fprintf(stderr, "Not enough memory\n");
	fprintf(stderr,"Far heap size %lu hsize %u\n",farcoreleft(), hsize);
	exit(1);
	}
    de_stack = (char_type *)malloc(8000);

    decompress();
    exit(0);
}


/*
 * Decompress stdin to stdout.  This routine adapts to the codes in the
 * file building the "string" table on-the-fly; requiring no table to
 * be stored in the compressed file.  The tables used herein are shared
 * with those of the compress() routine.  See the definitions above.
 */

decompress() {
    register char_type *stackp;
    register code_int finchar;
    register code_int code, oldcode, incode;

    /*
     * As above, initialize the first 256 entries in the table.
     */
    maxcode = MAXCODE(n_bits = INIT_BITS);
    for ( code = 255; code >= 0; code-- ) {
	tab_prefixof(code) = 0;
	tab_suffixof(code) = (char_type)code;
    }
    free_ent = ((block_compress) ? FIRST : 256 );

    finchar = oldcode = getcode();
    if(oldcode == -1)	/* EOF already? */
	return;			/* Get out of here */
    putchar( (char)finchar );		/* first code must be 8 bits = char */
    if(ferror(stdout))		/* Crash if can't write */
	writeerr();
    stackp = de_stack;

    while ( (code = getcode()) > -1 ) {

	if ( (code == CLEAR) && block_compress ) {
	    for ( code = 255; code >= 0; code-- )
		tab_prefixof(code) = 0;
	    clear_flg = 1;
	    free_ent = FIRST - 1;
	    if ( (code = getcode ()) == -1 )	/* O, untimely death! */
		break;
	}
	incode = code;
	/*
	 * Special case for KwKwK string.
	 */
	if ( code >= free_ent ) {
            *stackp++ = finchar;
	    code = oldcode;
	}

	/*
	 * Generate output characters in reverse order
	 */
#ifdef SIGNED_COMPARE_SLOW
	while ( ((unsigned long)code) >= ((unsigned long)256) ) {
#else
	while ( code >= 256 ) {
#endif
	    *stackp++ = tab_suffixof(code);
	    code = tab_prefixof(code);
	}
	*stackp++ = finchar = tab_suffixof(code);

	/*
	 * And put them out in forward order
	 */
	do
	    putchar ( *--stackp );
	while ( stackp > de_stack );

	/*
	 * Generate the new entry.
	 */
	if ( (code=free_ent) < maxmaxcode ) {
	    tab_prefixof(code) = (unsigned short)oldcode;
	    tab_suffixof(code) = finchar;
	    free_ent = code+1;
	}
	/*
	 * Remember previous code.
	 */
	oldcode = incode;
    }
    fflush( stdout );
    if(ferror(stdout))
	writeerr();
}

/*****************************************************************
 * TAG( getcode )
 *
 * Read one code from the standard input.  If EOF, return -1.
 * Inputs:
 * 	stdin
 * Outputs:
 * 	code or -1 is returned.
 */

code_int
getcode() {
    register code_int code;
    static long int offset = 0, size = 0;
    static char_type buf[BITS];
    register int r_off, bits;
    register char_type *bp = buf;

    if ( clear_flg > 0 || offset >= size || free_ent > maxcode ) {
	/*
	 * If the next entry will be too big for the current code
	 * size, then we must increase the size.  This implies reading
	 * a new buffer full, too.
	 */
	if ( free_ent > maxcode ) {
	    n_bits++;
	    if ( n_bits == maxbits )
		maxcode = maxmaxcode;	/* won't get any bigger now */
	    else
		maxcode = MAXCODE(n_bits);
	}
	if ( clear_flg > 0) {
    	    maxcode = MAXCODE (n_bits = INIT_BITS);
	    clear_flg = 0;
	}
	size = fread( buf, 1, n_bits, stdin );
	if ( size <= 0 )
	    return -1;			/* end of file */
	offset = 0;
	/* Round size down to integral number of codes */
	size = (size << 3) - (n_bits - 1);
    }
    r_off = offset;
    bits = n_bits;
	/*
	 * Get to the first byte.
	 */
	bp += (r_off >> 3);
	r_off &= 7;
	/* Get first part (low order bits) */
#ifdef NO_UCHAR
	code = ((*bp++ >> r_off) & rmask[8 - r_off]) & 0xff;
#else
	code = (*bp++ >> r_off);
#endif /* NO_UCHAR */
	bits -= (8 - r_off);
	r_off = 8 - r_off;		/* now, offset into code word */
	/* Get any 8 bit parts in the middle (<=1 for up to 16 bits). */
	if ( bits >= 8 ) {
#ifdef NO_UCHAR
	    code |= (*bp++ & 0xff) << r_off;
#else
	    code |= *bp++ << r_off;
#endif /* NO_UCHAR */
	    r_off += 8;
	    bits -= 8;
	}
	/* high order bits. */
	code |= (*bp & rmask[bits]) << r_off;
    offset += n_bits;
/* Turbo C sign extends, so correct this bug (?) */
#if BITS > 15
    code &= 0xffff;
#endif
    return code;
}

writeerr()
{
    perror ( ofname );
    unlink ( ofname );
    exit ( 1 );
}
