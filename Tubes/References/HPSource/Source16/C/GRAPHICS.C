/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* Program to plot the parabola  y = x^2 + 5 in the range  -5 < x < +5   */
/*                                                                       */
/* As written it is only suitable for a VGA screen. See exercise at end. */
/*                                                                       */
/* GRAPHICS.C  written by R. Shaw  12.8.90                               */
/*_______________________________________________________________________*/

#include	<graphics.h>
#include	<stdio.h>
#include	<bios.h>
#include        <conio.h>

static int port=0;                  /* port to print too    */

/*   Function prototypes                                    */

static int PrintChar (int out);
void       setport (int portnum);
int        hardcopynorm (int gmode);
int        hardcopyland (int gmode);

/*   Main function                                            */

main()
{

   int    graphdriver, graphmode,grapherror;
   int    MaxX, MaxY, OX;
   long   PixelX1, PixelY1, PixelY2;
   float  x, dx;
   char   reply;

   clrscr();
   detectgraph(&graphdriver, &graphmode);
   if (graphdriver < 0)
   {
      printf("No graphics hardware detected \n");
      exit(1);
   }
   printf("Graph driver is %d and mode is %d\n\n",graphdriver,graphmode);
   printf("Press any key to continue\n\n");
   getch();
   printf("If hardcopy required enter p for portrait or l for landscape\n");
   printf("else enter n for no hardcopy - choice - ");
   reply = getche();

   initgraph(&graphdriver, &graphmode, "");    /* Initialize graphics */
   grapherror = graphresult();

   if (grapherror < 0)
   {
      printf("Initgraph error: %s.\n",grapherrormsg(graphmode));
      exit(1);
   }

   MaxX = getmaxx();                        /* These are all functions  */
   MaxY = getmaxy();                        /* available in header file */
   setviewport(0,0,MaxX,MaxY,1);            /* graphics.h               */


   OX = (int) ((MaxX - 1) / 2);             /* x origin at mid screen */

   line(69,MaxY-30,MaxX-70,MaxY-30);        /* draw x axis for -5<x<+5 */
   line(OX,29,OX,MaxY-30);                  /* draw y axis for  0<y<+30 */

   x = -5;
   dx = (float) 10/(MaxX-139);              /* change in x per pixel */

   while (x <= 5.0) {
      PixelX1 = (int) (OX + ((MaxX-139)/10) * x);
      PixelY1 = (int) (MaxY-30 - ((MaxY-59)/30) * ((x * x) + 5));
      PixelY2 = (int) (MaxY-30 - ((MaxY-59)/30) * ((x+dx)*(x+dx) + 5));

      line(PixelX1,PixelY1,PixelX1+1,PixelY2);  /* graph from x to x+dx */

      x += dx;                                  /* increment x by dx  */
                     }

   settextjustify( CENTER_TEXT, CENTER_TEXT );
   outtextxy( OX, 10, "Graph of y = x^2 + 5" );
   outtextxy( OX, MaxY - 10, "Press any key to continue" );

   if (reply == 'p') hardcopynorm(graphmode);
   if (reply == 'l') hardcopyland(graphmode);

   getch();                                     /* wait for any keypress */
   closegraph();
}

/*     End of function 'main'                        */


static int PrintChar (int out)

{ int a;
  a=biosprint (0,out,port);
  return (a!=16);
}

void    setport (int portnum)

{ port=portnum;
}

/*  hardcopynorm dumps a screen to the printer from     */
/*  any graphics mode using the current viewport        */
/*  Valid values for gmode:                             */
/*  -4 to -1 for Epson and IBM Graphic Printers         */
/*  0 to 7  for Epson Printers                          */

int  hardcopynorm(int gmode)

{ int                   X,Y,YOfs;
  int                   BitData,MaxBits;
  unsigned int          Height,Width;
  struct viewporttype   Vport;

  getviewsettings (&Vport);
  Height=Vport.bottom-Vport.top;
  Width=(Vport.right+1)-Vport.left;
  if (PrintChar(27)!=0) return(1);
  if (PrintChar('3')!=0) return(1);
  if (PrintChar(24)!=0) return(1);
  Y=0;
  while (Y<Height)
  { if (PrintChar(27)!=0) return(1);
    switch (gmode)
    { case -1 : if (PrintChar('K')!=0) return(1);break;
      case -2 : if (PrintChar('L')!=0) return(1);break;
      case -3 : if (PrintChar('Y')!=0) return(1);break;
      case -4 : if (PrintChar('Z')!=0) return(1);break;
      case 0  :
      case 1  :
      case 2  :
      case 3  :
      case 4  :
      case 5  :
      case 6  :
      case 7  : if (PrintChar('*')!=0) return(1);
                if (PrintChar(gmode)!=0) return(1);break;
      default : return (1);
    };
    if (PrintChar (Width&0xff)!=0) return(1);
    if (PrintChar (Width>>8)!=0) return (1);
    for (X=0;X<Width;X++)
    { BitData=0;
      if ((Y+7)<=Height) MaxBits=7;
        else MaxBits=Height-Y;
      for(YOfs=0;YOfs<=MaxBits;YOfs++)
      { BitData=BitData<<1;
      if (getpixel(X,YOfs+Y)>0) BitData++;
      };
      if (PrintChar(BitData)!=0) return (1);
    };
    if (PrintChar('\r')!=0) return (1);
    if (PrintChar('\n')!=0) return (1);
    Y+=8;
  };
  return (0);
}
/*  hardcopyland dumps a screen to the printer from     */
/*  any graphics mode using the current viewport        */
/*  in a landscape format                               */
/*  Valid values for gmode:                             */
/*  -4 to -1 for Epson and IBM Graphic Printers         */
/*  0 to 7  for Epson Printers                          */

int   hardcopyland(int gmode)

{ int                   X,Y,YOfs;
  int                   BitData,MaxBits;
  unsigned int          Height,Width;
  struct viewporttype   Vport;

  getviewsettings (&Vport);
  Width=Vport.bottom-Vport.top;
  Height=(Vport.right+1)-Vport.left;
  if (PrintChar(27)!=0) return(1);
  if (PrintChar('3')!=0) return(1);
  if (PrintChar(24)!=0) return(1);
  Y=0;
  while (Y<Height)
  { if (PrintChar(27)!=0) return(1);
    switch (gmode)
    { case -1 : if (PrintChar('K')!=0) return(1);break;
      case -2 : if (PrintChar('L')!=0) return(1);break;
      case -3 : if (PrintChar('Y')!=0) return(1);break;
      case -4 : if (PrintChar('Z')!=0) return(1);break;
      case 0  :
      case 1  :
      case 2  :
      case 3  :
      case 4  :
      case 5  :
      case 6  :
      case 7  : if (PrintChar('*')!=0) return(1);
                if (PrintChar(gmode)!=0) return(1);break;
      default : return (1);
    };
    if (PrintChar (Width&0xff)!=0) return(1);
    if (PrintChar (Width>>8)!=0) return (1);
    for (X=Width-1;X>=0;X--)
    { BitData=0;
      if ((Y+7)<=Height) MaxBits=7;
        else MaxBits=Height-Y;
      for(YOfs=0;YOfs<=MaxBits;YOfs++)
      { BitData=BitData<<1;
        if (getpixel(YOfs+Y,X)>0) BitData++;
      };
      if (PrintChar(BitData)!=0) return (1);
    };
    if (PrintChar('\r')!=0) return (1);
    if (PrintChar('\n')!=0) return (1);
    Y+=8;
  };
  return (0);
}



/* A suitable exercise could be to generalise this program for any of    */
/* the following screens: cga (319x199), ega (639x349), herc (719x347)   */
/* as well as vga (639x479).                                             */
/* Another exercise would be to include scales on the graph with marks   */
/* at unit intervals on the x axis and at 5 unit intervals on the y axis */
/* and to label the axes appropriately.                                  */
