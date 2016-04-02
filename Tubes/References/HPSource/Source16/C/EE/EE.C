/* ee.c, Yijun Ding, Copyright 1991

Compile with TC: tcc ee.c
Compile in unix: gcc ee.c -lcursesX

Prototype are listed in the order defined. They are essentially grouped
as cursor move, screen, search, files, misc, mainloop, main.

*/
#include <stdio.h>
#include <string.h>

#define EOL '\0'    /* end of line marker */
#define BLK ' '     /* blank */
#define LF  '\n'    /* new line */
#define NLEN  80    /* buffer line for file name */
#define LMAX  10000 /* max line length */
#define XINC  20    /* increament of x */
#define HLP 28

#define CHG 0
#define FIL 1   /* fill */
#define OVR 2   /* insert */
#define CAS 3   /* case sensative */
#define TAB 4   /* tab */
#define POS 5   /* show pos */
#define ALT 6   /* meta_key */
#define SHW 7   /* screen */
#define NEW 8   /* new file */
#define EDT 9   /* quit edit */
#define WIN 10  /* window */
#define NTS 11  /* note posted */
#define ALL 12  /* last flag, quit */
char  flag[ALL+1];
char  fsym[]="|foctp~";

typedef struct {
  char name[NLEN];
  int  jump;
} MWIN;      	/* my window structure */

/* order of \n\r is important for curses */
#define HELP_STR "\n\
Usage: ee [-+line(def=1) -ttab(def=2) file(def=Notes)]\n\r\
\n\
A set mark, append file;    B format, right margin;\n\r\
C shell, execute line;      D cursor right, line end;\n\r\
E cursor up, file top;      F forward search, backward search;\n\r\
G goto line, goto column;   H delete before, delete under;\n\r\
I tab, tab insert;          J play macro, record;\n\r\
K block copy, block cut;    L refresh screen, status;\n\r\
M return;                   N toggle insert mode;\n\r\
O toggle mode;              P command prefix;\n\r\
Q command prefix;           R replace, replace all;\n\r\
S cursor left, line begin;  T delete word, del eol;\n\r\
U block paste, block write; V page down, page up;\n\r\
W window, window cancel;    X cursor down, file bottom;\n\r\
Y block delete line;        Z exit, edit other file;\n\r\
\n\
Each letter represent a control key. Each key corresponds one or two\n\r\
editing commands (seperated by comma). Press the control key for the\n\r\
first editing function, or control-P and the control key for the second\n\r\
editing function.\n\n\r\
Press any key to continue ..."

#ifdef __TURBOC__
#define AMAX  0xD000  /* main buffer size */
#define BMAX  0x400   /* block size */
#define YTOP  1

#define ttopen()    sww=76;swhfull=23
/* #define highvideo() textattr(0x30)
#define lowvideo()  textattr(0x1F)
#define ttclose()   textattr(0x07) */
#define ttclose()   normvideo()

/* honest get a key */
int get_key()
{
  static  char k1[]="GHIKMOPQRS";
  static  char k2[]="sEvSDdXVNh";
  int  key;
  char *s;

  if((key=getch()) == 0) {
    if((s=strchr(k1, getch())) == 0)
      return HLP;
    if((key = k2[s-k1]) > 'a')
      flag[ALT]++;
    return key&0x1F;
  }
  return key;
}
#else
#include "eeibm.c"
#endif

char  bbuf[10];               /* backup file name */
char  sbuf[NLEN], rbuf[NLEN]; /* search buffer, replace buffer */
char  *ae, aa[AMAX];          /* main buffer */
char  bb[BMAX], *mk;          /* block buffer, mark */
unsigned blen;
char  *dp, *ewb;              /* current pos, line */

int xtru, ytru;               /* file position */
int ytot;                     /* 0 <= ytru <= ytot */

int swhfull;                  /* screen physical height */
int x, sww;                   /* screen position 1 <= x <= sww */
int y, swh;                   /* screen size 0 <= y <= swh */
int y1, y2;                   /* 1st, 2nd line of window */
int tabsize=8;                /* tab size */

FILE  *fi, *fo;
MWIN  win, winnext, wincopy;  /* current, next, other windows */

void cursor_up(), cursor_down(), cursor_left(), cursor_right();
void show_rest(int len, char *s);
void show_scr(int fr, int to);
void show_sup(int line), show_sdn(int line);
void show_flag(int x, int g);
void show_note(char *prp);
int  show_gets(char *prp, char *buf);
void show_top(), show_help(), show_mode(), show_status();
void file_read();
char *file_ltab(char *s);
int  file_write(FILE *fp, char *s, char *e);
int  file_fout();
void file_save(int f_all, int f_win);
void file_more();
void file_rs(char *s, char *d);
void goto_x(int xx), goto_y(int yy);
void goto_ptr(char *s);
void goto_row(), goto_col();
int  str_cmp(char *s);
char *goto_find(char *s, int  back);
void goto_search(int back);
void goto_replace(int whole);
void window_other(), window_cancel(), window_size();
void block_put(), block_get(), block_mark();
void block_copy(int delete);
void block_paste(), block_write(), block_line();
int  block_fill();
void block_format();
void key_return(), key_deleol(char *s), key_delete();
void key_backspace(), key_delword(int eol);
void key_tab(int tabi);
void key_normal(int key);
void key_shell(int line);
void key_macros(int record);
void main_meta(int key), main_exec(int key);
void main_loop(), main(int argc, char **argv);

/* cursor movement ----------------------------------------- */
void cursor_up()
{
  if(ytru == 0) return;
  ytru--;
  while(*--ewb != EOL) ;
  y--;
}

void cursor_down()
{
  if(ytru == ytot) return;
  ytru++;
  while(*++ewb != EOL) ;
  y++;
}

/* cursor left & right: x, xtru */
void cursor_left()
{
  if(xtru == 1) return;
  xtru--;
  if(--x < 1) {
    x += XINC;
    flag[SHW]++;
  }
}

void cursor_right()
{
  if(xtru == LMAX) return;
  xtru++;
  if(++x > sww) {
    x -= XINC;
    flag[SHW]++;
  }
}

#define cursor_pageup() {int i; for(i=1; i<swh; ++i) cursor_up();}
#define cursor_pagedown(){int i; for(i=1; i<swh; ++i) cursor_down();}

/* dispaly --------------------------------------------------------*/
/* assuming cursor in correct position: show_rest(sww-x,ewb+xtru) */
void show_rest(len, s)
int  len;
char *s;
{
  char save;
  save = s[len];
  s[len] = 0;
  cputs(s);
  s[len] = save;
  clreol();
}

/* ewb and y correct */
void show_scr(fr,to)
int fr, to;
{
  char *s=ewb;
  int  len=sww-1, i=fr;
  unsigned xl=xtru-x;

  /* calculate s */
  for(; i<y; i++) while(*--s != EOL) ;
  for(; i>y; i--) while(*++s != EOL) ;

  /* first line */
  s++;
  do {
    gotoxy(1, fr+y2);
    if(s<ae && strlen(s) > xl) show_rest(len, s+xl);
    else clreol();
    while(*s++) ;
  } while(++fr <= to);
}

void show_sup(line)
int line;
{
  gotoxy(1, y2+line);
  delline();
  show_scr(swh, swh);
}

void show_sdn(line)
int line;
{
  gotoxy(1, y2+line);
  insline();
  show_scr(line, line);
}

void show_flag(x, g)
int x, g;
{
  gotoxy(14+x, y1);
  putch(g? fsym[x]: '.');
  flag[x] = g;
}

void show_note(prp)
char *prp;
{
  gotoxy(17+ALT, y1);
  cputs(prp);
  clreol();
  flag[NTS]++;
}

int show_gets(prp, buf)
char *prp, *buf;
{
  int key;
  int col=(-1);
  show_note(prp);
  cputs(": ");
  cputs(buf);
  for(;;) {
    key = get_key();
    if(key >= BLK) {
      if(col < 0) {
        col++;
        show_note(prp);
        cputs(": ");
      }
      buf[col++] = key;
    }
    else if(key == 8) {
      if(col < 0) col = strlen(buf);
      if(col == 0) continue;
      col--;
    }
    else break;
    putch(key);
  }
  flag[ALT] = 0;
  if(col > 0) buf[col] = 0;
  return (key == 27 || *buf == 0);
}

void show_top()
{
  int i;
  gotoxy(1, y1);
  highvideo();
  cputs(win.name);
  lowvideo();
  clreol();
  for(i=0; i<=ALT; i++)
    show_flag(i, flag[i]);
  flag[NTS]++;
}

void show_help()
{
  clrscr();
  cputs(HELP_STR);
  get_key();
  show_top();
  flag[SHW]++;
}

void show_mode()
{
  char *d;
  int  k;
  show_note(fsym);
  putch(BLK);
  k = get_key()|0x60;
  if((d=strchr(fsym, k)) != 0) {
    k = d-fsym;
    show_flag(k, !flag[k]);
  }
}

void show_status()
{
  char tbuf[80];
  sprintf(tbuf, "line %d/%d, col %d, char %u/%u/%u+%u",
    ytru+1, ytot, xtru, dp-aa, ae-aa, BMAX, AMAX);
  show_note(tbuf);
  sleep(1);
}

/* file operation ---*/
void file_read()
{
  int  c;
  char *col;
  ewb = aa;
  ae = mk = col = aa+1;
  xtru = x = 1;
  ytru = y = ytot = 0;
  if(fi == 0) return;

  /* read complete line */
  do {
    c = fgetc(fi);
    if(c == EOF) {
      fclose(fi);
      fi = 0;   /* no more read */
      break;
    }
    if(c == 9) {    /* tab */
      if(flag[TAB] == 0) show_flag(TAB, 1);
      do (*ae++ = BLK);
      while( ((ae-col) % tabsize) != 0);
    }
    else if(c == LF) {
      *ae++ = EOL;
      col = ae;
      ytot++;
    }
    else *ae++ = c;
  } while(ae < aa+AMAX-BMAX || c != LF);
  for(; win.jump>1; win.jump--) cursor_down();
}

/* compress one line from end */
char *file_ltab(s)
char *s;
{
  char *d, *e;
  e = d = strchr(s--, EOL);
  while(*--e == BLK) ;  /* trailing blank */
  while(e > s) {
    if(e[0] == BLK && (e-s)%tabsize == 0 && e[-1] == BLK) {
      *--d = 9;
      while(*--e == BLK && (e-s)%tabsize != 0) ;
    }
    else *--d = *e--;
  }
  return d;
}

/* routine used for write block file also, this makes it more complicated */
int file_write(fp, s, e)
FILE *fp;
char *s, *e;
{
  if(fp == 0) return 1; /* no write */
  do {
    if(flag[TAB] && *s != EOL) s = file_ltab(s);
    /* if s="", TC return 0, TC++ return -1 */
    if(*s && fputs(s, fp) <= 0) return 1;
    fputc(LF, fp);
    while(*s++ != EOL) ;
  } while(s < e);
  return 0;
}

int file_fout()
{
  if(fo == 0) {
    strcpy(bbuf, "YEXXXXXX");
    if(win.name[1] == ':') memcpy(bbuf, win.name, 2);
    fo=fopen((char *)mktemp(bbuf), "w");
  }
  return file_write(fo, aa+1, ae);
}

void file_save(f_all, f_win)
int f_all, f_win;
{
  int k='n';
  /* flag[CHG] = 0;  DEBUG*/
  if(flag[CHG] )
  do {
    show_note("Save file (yes/no/cancel): ");
    k = tolower(get_key());
    if(k == 'c') return;
  } while(k != 'y' && k != 'n');
  flag[CHG] = 0;
  flag[EDT]++;
  flag[ALL] = f_all;
  flag[WIN] = f_win;
  if(k == 'n') {
    if(fo ) {
      fclose(fo);
      unlink(bbuf);
      fo = 0;
    }
    return;
  }
  if(file_fout() ) return; /* no write */
  while(fi != 0 ) {
    file_read();
    file_fout();
  }
  fclose(fo);
#if !VMS
  if(flag[NEW] == 0) unlink(win.name);
#endif
  rename(bbuf, win.name);
  fo = 0;
}

void file_more()
{
  if(fi != 0) {
    file_fout();
    file_read();
    flag[SHW]++;
  }
}

void file_rs(s, d)
char  *d, *s;
{
  char  *e = ae;
  unsigned i = e-s;

  /* immediate problem only when block buffer on disk too big */
  if((ae += (d-s)) >= aa+AMAX) {
    show_note("Main buffer full");
    return;
  }
  if(s < d) { /* expand */
    d += e - s;
    s = e;
    while(i-- > 0) *--d = *--s;
    /* while(j-- > 0) if((*--d = *--str) == EOL) ytot++; */
  }
  else {
    /* adjust ytot when shrink */
    for(e=d; e<s; e++) if(*e == EOL) ytot--;
    while(i-- > 0) *d++ = *s++;
  }
  *ae = EOL;  /* last line may not complete */
  if(!flag[CHG] ) {
    show_flag(CHG, 1);
    gotoxy(x, y+y2);
  }
}

/* search and goto */
/* xx >= 1, yy >= 0 */
void goto_x(xx)
int  xx;
{
  int i, n;
  n = xtru;
  for(i=xx; i<n; i++) cursor_left();
  for(i=n; i<xx; i++) cursor_right();
}

void goto_y(yy)
int  yy;
{
  int i, n;
  n = ytru;
  for(i=yy; i<n; i++) cursor_up();
  for(i=n; i<yy; i++) cursor_down();
}

void goto_ptr(s)
char *s;
{
  /* find ewb <= s */
  char  *s1 = s;
  while(*--s1 != EOL) ;
  while(ewb > s) cursor_up();
  while(ewb < s1) cursor_down();
  goto_x(s-ewb);
  if(y > swh) y = flag[SHW] = swh/4;
}

void goto_row()
{
  static char rbuf[6];
  show_gets("Goto line", rbuf);
  goto_y(atoi(rbuf)-1);
}

void goto_col()
{
  static char cbuf[6];
  show_gets("Goto Column", cbuf);
  goto_x(atoi(cbuf) );
}

/* compare to sbuf. used by search */
int str_cmp(s)
char *s;
{
  char  *d = sbuf;
  if(flag[CAS] ) {
    while(*d ) if(*s++ != *d++ ) return 1;
    return 0;
  }
  while(*d ) if(tolower(*s++) != tolower(*d++)) return 1;
  return 0;
}

/* back / forward search */
char *goto_find(s, back)
char *s;
int  back;
{
  do {
    if(back ) {
      if(--s <= aa) return 0;
    }
    else if(++s >= ae) return 0;
  } while(str_cmp(s) );
  goto_ptr(s);
  return s;
}

void goto_search(back)
int  back;
{
  if(show_gets("Search for", sbuf) ) return;
  goto_find(dp, back);
}

void goto_replace(whole)
int whole;
{
  char  *s=dp;
  int rlen, slen = strlen(sbuf);
  if(str_cmp(s) || str_cmp(rbuf) == 0 ||
  show_gets("Replace with", rbuf) ) return;
  rlen = strlen(rbuf);
  do {
    file_rs(s+slen, s+rlen);
    memcpy(s, rbuf, rlen);
  }
  while(whole && (s=goto_find(s, 0)) != 0) ;
  if(whole) flag[SHW]++;
  else {
    gotoxy(x, y+y2);
    show_rest(sww-x, s);
  }
}

/* windows ---*/
void window_other()
{
  int i;
  wincopy = win;
  win = winnext;
  winnext = wincopy;
  winnext.jump = ++ytru;
  if(y1 > YTOP + 2) {
    gotoxy(1, YTOP);
    for(i=0; i<swhfull/2; i++) delline();
  }
  else {
    y1 += swhfull/2;
    swh -= swhfull/2;
  }
}

void window_cancel()
{
  if(y1 > YTOP+2) {
    y1 -= swhfull/2;
    y2 = y1 + 1;
    swh += swhfull/2;
    show_top();
    flag[SHW]++;
  }
}

void window_size()
{
  static char wbuf[8]="68";
  if(show_gets("Right margin",wbuf) == 0) {
    sww = atoi(wbuf);
    flag[SHW]++;
  }
}

/* block and format ---*/
/* use blen, mk, bb */
FILE *fb;
void block_put()
{
  if(blen < BMAX) memcpy(bb, mk, blen);
  else {
    if(fb == 0 && (fb = tmpfile()) == 0) return;
    fseek(fb, 0L, 0);
    fwrite(mk, 1, blen, fb);
  }
  show_note("Block copied");
}

void block_get()
{
  int i;
  if(blen < BMAX) memcpy(mk, bb, blen);
  else {
    if(fb == 0) return;
    fseek(fb, 0L, 0);
    fread(mk, 1, blen, fb);
  }
  /* calculate ytot */
  for(i=0; i<blen; i++) if(mk[i] == EOL) ytot++;
}

void block_mark()
{
  if(*dp == EOL)
    show_note("Invalid Pos.");
  else {
    show_note("Mark Set");
    mk = dp;
  }
}

void block_copy(delete)
int delete;
{
  blen = dp - mk;
  block_put();
  if(delete) {
    goto_ptr(mk);
    file_rs(dp, mk);
    flag[SHW]++;
  }
}

void block_paste()
{
  mk = dp;
  file_rs(mk, mk+blen);
  block_get();    /* disk file ??? */
  /* if it is a line */
  if(xtru == 1 && strlen(mk) == blen-1) show_sdn(y);
  else {
    show_scr(y, swh);
    goto_ptr(mk+blen);
  }
}

/* copy block to file, not to block buffer */
void block_write()
{
  FILE  *fp;
  static char fbuf[20] = "tmp.tmp";
  if(mk >= dp) return;
  if(show_gets("Write to file", fbuf) ) return;
  fp = fopen(fbuf, "w");
  file_write(fp, mk, dp);
}

void block_line()
{
  if(ytru == ytot) return;
  goto_x(1 );
  for(blen = 0; ewb[++blen] != EOL; ) ;
  mk = ewb+1;
  block_put();
  file_rs(ewb+blen, ewb);
  show_sup(y);
}

/* fill current line; does not change corsur or file len */
int block_fill()
{
  int i=sww;
  while(ewb[--i] > BLK) ;
  if(i == 0) i = sww-1;
  ewb[i] = EOL;
  ytot++;
  cursor_down();
  return i;
  /* screen position to clreol() */
}

/* format paragraph */
void block_format()
{
  char  *s=ewb;
  int ytmp = y;
  goto_x(1);
  while(s = strchr(++s, EOL), ytru < ytot && s[1] != EOL) {
    s[0] = BLK;
    ytot--;
  }
  while(strlen(ewb+1) >= sww) block_fill();
  while(ewb[xtru] ) cursor_right();
  if( flag[SHW] == 0) show_scr(ytmp, swh);
}

/* key actions ---*/
/* update file part, then screen ... */
void key_return()
{
  char  *s=dp;
  if(flag[OVR] ) {
    cursor_down();
    goto_x(1);
    return;
  }
  file_rs(s, s+1);
  goto_x(1);
  *s = EOL;
  ytot++;
  cursor_down();
  if(flag[SHW] == 0) {
    clreol();
    if(y < sww) show_sdn(y);
  }
}

/* used by next two */
void key_deleol(s)
char *s;
{
  if(ytru == ytot) return;
  goto_x(s-ewb);
  file_rs(s+1, s);
  if(flag[SHW] ) return;
  if(y < 0) {   /* y = -1 */
    y = 0;
    show_scr(0,0);
  }
  else {
    gotoxy(x, y+y2);
    show_rest(sww-x, s);
    show_sup(y+1);
  }
}

/* delete under */
void key_delete()
{
  char  *s=dp;
  if( *s == EOL) {
    key_deleol(s);
    return;
  }
  file_rs(s+1, s);
  show_rest(sww-x, s);
}

void key_backspace()
{
  char  *s=dp;
  if(*--s == EOL) { /* delete EOL */
    if(ytru == 0) return;
    cursor_up();
    key_deleol(s);
    return;
  }
  while(ewb+xtru > s) cursor_left();
  /* delete tab space */
  if(*s == BLK) {
    while(*--s == BLK && (xtru%tabsize) != 1) cursor_left();
    s++;
  }
  file_rs(dp, s);
  if(!flag[SHW] ) {
    gotoxy(x, y+y2);
    show_rest(sww-x, s);
  }
}

void key_delword(eol)
int  eol;
{
  char  *d=dp;
  if(*d == EOL) {
    key_deleol(d);
    return;
  }
  if(eol) while(*d != EOL) d++;
  else {
    while(*d > BLK) d++;
    while(*d == BLK) d++;
  }
  show_rest(sww-x, d);
  file_rs(d, dp);
}

void key_tab(tabi)
int tabi;
{
  char  *s = ewb+xtru;
  int xtmp=x;
  do cursor_right();
  while((xtru%tabsize) != 1);
  if(!tabi && s==dp) {
    s = ewb+xtru;
    file_rs(dp, s); /* may change cursor_position */
    while(s > dp) *--s = BLK;
    gotoxy(xtmp, y+y2);
    show_rest(sww-xtmp, s);
  }
}

void key_normal(key)
int key;
{
  char  *s=ewb+xtru;
  int xtmp;
  if(dp < s) {
    file_rs(dp, s);
    while(dp < s) *dp++ = BLK;
  }
  if(flag[OVR] && *s != EOL) {
    putch(*s = key);
    flag[CHG] = 1;
  }
  else {
    file_rs(s, ++dp);
    *s = key;
    show_rest(sww-x, s);
  }
  cursor_right();
  if(!flag[FIL] || xtru<sww) return;

  xtmp = block_fill();  /* cursor_down */
  if(xtru > sww) flag[SHW]++;
  xtru = x = xtru - xtmp;
  if(flag[SHW] == 0) {
    gotoxy(xtmp, y2+y-1);
    clreol();
    show_sdn(y);
  }
}

void key_shell(line)  /* shell: `sh' on Unix, RET on MS-DOS or VMS */
int line;
{
  static char mbuf[40];
  if(line ) strcpy(mbuf, ewb+1);
  else if(show_gets("Cmd", mbuf) ) return;
  clrscr();
  ttclose();
  system(mbuf);
  ttopen();
  get_key();
  show_top();
  flag[SHW]++;
}

void key_macros(record)
int record;
{
  static char mbuf[60];
  char  *s=mbuf;
  void  main_exec();
  int k;
  if(!record) {
    while(*s != 0) main_exec(*s++);
    return;
  }
  show_note("^Z to end: ");
  while( (k = get_key()) != 'Z'-'@') {
    *s++ = k;
    if(k < BLK) {
      putch('^');
      k |= 0x40;
    }
    putch(k);
  }
  *s = 0;
  s = mbuf;
}

/* main function */
void main_meta(key)
int key;
{
  switch(key | 0x60) {
  case 'a': file_more(); break;
  case 'b': window_size(); break;
  case 'c': key_shell(1); break;
  case 'd': goto_x(strlen(ewb+1)+1); break;
  case 'e': goto_y(0); break;
  case 'f': goto_search(1); break;
  case 'g': goto_col(); break;
  case 'h': key_delete(); break;
  case 'i': key_tab(0); break;
  case 'j': key_macros(1); break;
  case 'k': block_copy(1); break;
  case 'l': show_status(); break;
  case 'm':
  case 'n':
  case 'o':
  case 'p': key_normal(get_key() ); break;
  case 'q': break;
  case 'r': goto_replace(1); break;
  case 's': goto_x(1); break;
  case 't': key_delword(1); break;
  case 'u': block_write(); break;
  case 'v': cursor_pageup(); break;
  case 'w': window_cancel(); break;
  case 'x': goto_y(ytot); break;
  case 'y': break;
  case 'z': file_save(0, -1); break;
  }
  show_flag(ALT, 0);
}

void main_exec(key)
int key;
{
  int i = xtru;
  dp = ewb;
  while(*++dp && --i>0) ;
  if(flag[ALT] ) main_meta(key);
  else if(key >= BLK) key_normal(key);
  else switch(key|0x60) {
  case 'a': block_mark(); break;
  case 'b': block_format(); break;
  case 'c': key_shell(0); break;
  case 'd': cursor_right(); break;
  case 'e': cursor_up(); break;
  case 'f': goto_search(0); break;
  case 'g': goto_row(); break;
  case 'h': key_backspace(); break;
  case 'i': key_tab(1); break;
  case 'j': key_macros(0); break;
  case 'k': block_copy(0); break;
  case 'l': if(ytru > swh/4) { y = swh/4; flag[SHW]++; } break;
  case 'm': key_return(); break;
  case 'n': show_flag(OVR, !flag[OVR]); break;
  case 'o': show_mode(); break;
  case 'p':
  case 'q': show_flag(ALT, 1); break;
  case 'r': goto_replace(0); break;
  case 's': cursor_left(); break;
  case 't': key_delword(0); break;
  case 'u': block_paste(); break;
  case 'v': cursor_pagedown(); break;
  case 'w': file_save(0, 1); break;
  case 'x': cursor_down(); break;
  case 'y': block_line(); break;
  case 'z':
  case '{': file_save(1, 0); break;
  case HLP|0x60: show_help();   /* | */
  }
}

/* win is only thing it knows */
void main_loop()
{
  int  yold, xold;

  show_top();
  if((fi = fopen(win.name, "r")) == 0) {
    show_note("New file");
    flag[NEW]++;
  }
  file_read();

  while(flag[EDT] == 0) {
    if(y <= -1 || y >= swh) {      /* change here if no hardware scroll */
      if(y == -1) {
        y++; show_sdn(0);
      }
      else if(y == swh) {
        y--; show_sup(0);
      }
      else {
        y = y < 0? 0: swh-1;
        show_scr(0, swh);
        flag[SHW] = 0;
      }
    }
    else if(flag[SHW] ) {
      show_scr(0, swh);
      flag[SHW] = 0;
    }
    if(flag[NTS] ) {
      show_note(flag[POS]? "Line      Col": "F1-Help");
      yold = xold = (-1);
      flag[NTS] = 0;
    }
    if(flag[POS] ) {
      if(ytru != yold) {
        yold = ytru;
        gotoxy(22+ALT, y1);
        cprintf("%-4d", ytru+1);
      }
      if(xtru != xold) {
        xold = xtru;
        gotoxy(31+ALT, y1);
        cprintf("%-3d", xtru);
      }
    }
    gotoxy(x, y+y2);
    main_exec(get_key() );
  }
  /* fo = 0; */
}

void main(argc, argv)
int  argc;
char **argv;
{
  /* set command line */
  while(--argc && **++argv == '-') switch(*++*argv) {
    case 't': tabsize = atoi(++*argv); break;
    case '+': win.jump = atoi(++*argv); break;
  }
  strcpy(win.name, argc == 0? "Notes": *argv);
  aa[0] = EOL;

  ttopen();
  swh = swhfull;
  y1 = YTOP;

  do {
    y2 = y1+1;
    flag[SHW]++;
    flag[NEW] = flag[EDT] = flag[ALL] = 0;
    main_loop();
    if(flag[WIN] > 0) window_other(win);
    if(flag[WIN] < 0 || *win.name == 0)
      show_gets("File name", win.name);
    flag[WIN] = 0;
  } while(flag[ALL] == 0) ;

  gotoxy(1, swhfull+2);
  ttclose();
}

