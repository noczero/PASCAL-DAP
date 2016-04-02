/*=======================================================================
SureCrypt v1.02-CLI (command-line interface)              rev: 2004.09.17

Copyright (c) 2004 Dariusz Stanislawek
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
=========================================================================

SureCrypt is a file encryption program.

Cipher: Rc4
Key Size: max 512 bits (64 bytes)
IV: 16 bytes
Max File Size: unlimited
Cipher File Structure:
[plaindata CRC = 4 bytes] + [IV = 16 bytes] + [cipherdata]

The implementation addresses the theoretical weaknesses of Rc4 with:
- discarding initial bytes of keystream
- alternating the S-box and discarding a variable number of bytes on
  every keystream round

A fully compatible Windows-GUI executable can be downloaded from
http://www.ozemail.com.au/~nulifetv/freezip/freeware/
http://freezip.cjb.net/freeware/

The GUI version deploys Windows API directly and has its own,
better PRNG. The CLI version is open-source and intended to be
cross-platform portable.

Change Log
----------
v1.02
- mod gen_iv()
- add progress indicator
v1.01
- improved PRNG initialization resolves hypothetical issues with use
  in batch file applications, eg. [for %%f in (path\*.*) do sc key...]
v1.00
- released 2004.01.24

                                                  freezip(at)bigfoot,com
=======================================================================*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

#define BLOCKSIZE  (64 * 1024) // the optimal buffer size for sequential I/O on Windows NT/2k/XP
#define MAXKEYSIZE  64 // bytes (512 bits)
#define IVSIZE      16


unsigned long crc;
unsigned long crc_table[256];


void init_crc(void)
{
    int i, j;
    unsigned long crct;
    for(i = 0; i < 256; i++)
    {
        crct = (unsigned long)i;
        for(j = 8; j; j--)
            crct = crct & 1 ? 0xedb88320L ^ (crct >> 1) : crct >> 1;
        crc_table[i] = crct;
    }
}


void calc_crc(unsigned char *buf, unsigned long size)
{
    unsigned long i;
    for( i = 0;  i < size;  i++ )
        crc = (crc >> 8) ^ crc_table[(unsigned char)buf[i] ^ (crc & 0x000000FF)];
}


typedef struct rc4_key
{
    unsigned char state[256];
    unsigned char x;
    unsigned char y;
} rc4_key;


static void swap_byte(unsigned char *a, unsigned char *b)
{
    unsigned char swapByte;

    swapByte = *a;
    *a = *b;
    *b = swapByte;
}


void prepare_key(unsigned char *key_data_ptr, int key_data_len, rc4_key *key)
{
    unsigned char index1;
    unsigned char index2;
    unsigned char* state;
    int counter;

    state = &key->state[0];
    for(counter = 0; counter < 256; counter++) state[counter] = counter;
    key->x = 0;
    key->y = 0;
    index1 = 0;
    index2 = 0;

    for(counter = 0; counter < 256; counter++)
    {
        index2 = (key_data_ptr[index1] + state[counter] + index2) % 256;
        swap_byte(&state[counter], &state[index2]);
        index1 = (index1 + 1) % key_data_len;
    }
}


void rc4(unsigned char *buffer_ptr, int buffer_len, rc4_key *key)
{
    unsigned char x;
    unsigned char y;
    unsigned char* state;
    unsigned char xorIndex;
    int counter;

    x = key->x;
    y = key->y;
    state = &key->state[0];
    for(counter = 0; counter < buffer_len; counter ++)
    {
        x = (x + 1) % 256;
        y = (state[x] + y) % 256;
        swap_byte(&state[x], &state[y]);
        xorIndex = (state[x] + state[y]) % 256;
        buffer_ptr[counter] ^= state[xorIndex];
    }
    key->x = x;
    key->y = y;
}


void flip_mem(unsigned char *buf, int size)
{
    while(--size >= 0) buf[size] = ~buf[size];
}


void gen_iv(unsigned char *buf, int size)
{
    while(--size >= 0) buf[size] += rand();
}


char msg1[] = "%s: The data is invalid\n";
char msg2[] = "%s: The file exists\n";


/*=====================================================================*/


int crypt(char *keyfile, int encrypt, char *src, char *dst)
{
    rc4_key key;
    FILE *fkey, *fsrc, *fdst;
    unsigned char keydata[MAXKEYSIZE + IVSIZE], membuf[BLOCKSIZE], iv[IVSIZE];
    unsigned long filecrc, keysize, sread, status = 1, round = 0;

    if((fdst = fopen(dst, "r")) != NULL) // check if file exists
    {
        printf(msg2, dst);
        fclose(fdst);
        return 1;
    }

    if((fkey = fopen(keyfile, "rb")) == NULL)
    {
        perror(keyfile);
        return 1;
    }

    if((fsrc = fopen(src, "rb")) == NULL)
    {
        perror(src);
        goto quit;
    }

    if((fdst = fopen(dst, "wb")) == NULL)
    {
        perror(dst);
        goto quit;
    }


    keysize = fread(keydata, 1, MAXKEYSIZE + 1, fkey);
    if(!keysize || keysize > MAXKEYSIZE)
    {
        printf(msg1, keyfile);
        goto quit;
    }

    init_crc();

    if(encrypt)
    {
        calc_crc(membuf, BLOCKSIZE); // get something from the fresh stack,
        calc_crc((unsigned char*)src, strlen(src)); // continue on source file name,
        srand(time(NULL) ^ crc); // then initialize PRNG
        gen_iv(iv, IVSIZE); // PRNG
        fseek(fdst, 4 + IVSIZE, SEEK_SET);
    }
    else
        if(4 != fread(&filecrc, 1, 4, fsrc) || IVSIZE != fread(iv, 1, IVSIZE, fsrc))
        {
            printf(msg1, src);
            goto quit;
        }

    memcpy(keydata + keysize, iv, IVSIZE);
    prepare_key(keydata, keysize + IVSIZE, &key);
    rc4(membuf, keysize + 256, &key); // discard first 256+ bytes of keystream (in the easy way)
    crc = 0xFFFFFFFF;


    while((sread = fread(membuf, 1, BLOCKSIZE, fsrc)) > 0)
    {
        if(encrypt)
        {
            calc_crc(membuf, sread);
            rc4(membuf, sread, &key);
        }
        else
        {
            rc4(membuf, sread, &key);
            calc_crc(membuf, sread);
        }
        if(sread != fwrite(membuf, 1, sread, fdst))
        {
            printf(msg1, dst);
            goto quit;
        }
        flip_mem(key.state, 256); // bitwise reverse the S-box (cryptanalysis countermeasure)
        rc4(membuf, crc % 8192, &key); // discard up to 8kB of keystream (balanced for min performance hit)
        round++;
        if(!(round % 16)) printf("."); // progress indicator
    }


    rc4((unsigned char*)&crc, 4, &key);

    if(encrypt)
    {
        rewind(fdst);
        if(4 != fwrite(&crc, 1, 4, fdst) || IVSIZE != fwrite(iv, 1, IVSIZE, fdst))
        {
            printf(msg1, dst);
            goto quit;
        }
    }
    else
        if(crc != filecrc)
        {
            printf(msg1, src);
            goto quit;
        }

    printf("OK %uMB\n", round / 16);
    status = 0; // SUCCESS

quit:
    fclose(fkey);
    if(fsrc) fclose(fsrc);
    if(fdst)
    {
        fclose(fdst);
        if(status) remove(dst);
    }
    if(!encrypt) memset(membuf, 0, sizeof(membuf)); // sensitive data memory cleanup
    memset(&key, 0, sizeof(key));
    memset(keydata, 0, sizeof(keydata));
    return status;
}


/*=====================================================================*/


int main(int argc, char *argv[])
{
    if(argc == 5)
    {
        *argv[2] = toupper(*argv[2]);
        switch (*argv[2])
        {
            case 'E':
            case 'D':
            return crypt(argv[1], *argv[2] == 'E', argv[3], argv[4]);
        }
    }
    printf("SureCrypt v1.02-CLI, Freeware - use at your own risk.\n"
           "(c)2004 Dariusz Stanislawek, http://freezip.cjb.net/freeware/\n\n"
           "Usage: sc keyfile e|d source destination\n\n"
           "Max keyfile size is 64 bytes.\n"
           "Encryption example: sc a:\\my.key e d:\\x\\data.zip data.enc\n"
           "Decryption example: sc my.key d data.enc c:\\tmp\\data.zip\n");
    return 1;
}

