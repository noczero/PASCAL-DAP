#define STRICT
#include <windows.h>

#pragma hdrstop

#include <math.h>


#include "cube.h"





StaticVertex initCubeV[8] = { // coordinates of cube in 3D space
  {-50,50,50},  {50,50,50},
  {50,-50,50},  {-50,-50,50},
  {-50,50,-50}, {50,50,-50},
  {50,-50,-50}, {-50,-50,-50}
};

Vertex cubeV[8];

POLYGON cubePoly[6] = {
  {0,0,0xFF, {&cubeV[0],&cubeV[1],&cubeV[2],&cubeV[3]}},//the rear face
  {0,0xFF,0, {&cubeV[0],&cubeV[3],&cubeV[7],&cubeV[4]}}, //left face
  {0xFF,0,0, {&cubeV[0],&cubeV[4],&cubeV[5],&cubeV[1]}},//top face
  {0,0xFF,0xFF, {&cubeV[6],&cubeV[5],&cubeV[4],&cubeV[7]}}, //the front face
  {0xFF,0xFF,0, {&cubeV[6],&cubeV[2],&cubeV[1],&cubeV[5]}}, //right face
  {0xFF,0,0xFF, {&cubeV[6],&cubeV[7],&cubeV[3],&cubeV[2]}},//bottom face
};

OBJECT3D cube={
  0,0,200,      //the x,y,z  z mora biti veæi od polovice prostorne dijagonale
  0,0,0,        //the angles of rotation
  8,            //8 vertices in a cube shape
  6,            //6 polygons (faces) on a cube
  initCubeV,    //the original vertices for the cube
  cubeV,        //the space to store the rotated/transformed vertices
  cubePoly      //the list of polygons to use
};


void rotateVertex(StaticVertex *sv,Vertex *v,
		  int angle_x,int angle_y,int angle_z) {

// rotira u 3D prostoru


  int tempx,tempy,tempz,newx,newy,newz;
  newx=sv->x;
  newy=sv->y;
  newz=sv->z;

	// Change from degree to Radians
  float xAngleR = (float)angle_x*RADIANS;
  float yAngleR = (float)angle_y*RADIANS;
  float zAngleR = (float)angle_z*RADIANS;

  float xSin = sin(xAngleR);
  float xCos = cos(xAngleR);

  float ySin = sin(yAngleR);
  float yCos = cos(yAngleR);

  float zSin = sin(zAngleR);
  float zCos = cos(zAngleR);

// rotate coord around z axis
  tempx=(int)(newx*zCos-newy*zSin);
  tempy=(int)(newx*zSin+newy*zCos);
  newx=tempx;
  newy=tempy;

  //then y axis
  tempx=(int)(newx*yCos-newz*ySin);
  tempz=(int)(newx*ySin+newz*yCos);
  newx=tempx;
  newz=tempz;

  //then x axis
  tempy=(int)(newy*xCos-newz*xSin);
  tempz=(int)(newy*xSin+newz*xCos);

  v->x=newx;
  v->y=tempy;
  v->z=tempz;
}

short backfacing(POLYGON *poly) {

  long final,
       x1,x2,x3,
       y1,y2,y3,
       z1,z2,z3;

  x1=poly->vertex[0]->x;
  y1=poly->vertex[0]->y;
  z1=poly->vertex[0]->z;

  x2=poly->vertex[1]->x;
  y2=poly->vertex[1]->y;
  z2=poly->vertex[1]->z;

  x3=poly->vertex[2]->x;
  y3=poly->vertex[2]->y;
  z3=poly->vertex[2]->z;

  final=(x3*(z1*y2 - z2*y1))+
	(y3*(x1*z2 - x2*z1))+
	(z3*(y1*x2 - y2*x1));

  return((short)(final>0));
}

 void screenConvertVertex(Vertex *v,int x, int y, int zoom) {

  v->sx=((zoom*v->x)/v->z) + x;
  v->sy=-((zoom*v->y)/v->z) + y;
}


void drawPolygon(HDC hdc,POLYGON *poly,int i,BOOL patterndraw,HBITMAP *pattern)
{
	HBRUSH hBrush;
    if(patterndraw)
    	hBrush=CreatePatternBrush(pattern[i]);
    else
    	hBrush=CreateSolidBrush(RGB(poly->red,poly->green,poly->blue));

    HBRUSH oldBrush=(HBRUSH)SelectObject(hdc,hBrush);
	 POINT pt[4]={
			{poly->vertex[0]->sx,poly->vertex[0]->sy},
                     	{poly->vertex[1]->sx,poly->vertex[1]->sy},
                     	{poly->vertex[2]->sx,poly->vertex[2]->sy},
                     	{poly->vertex[3]->sx,poly->vertex[3]->sy}
		};

     Polygon(hdc,pt,4);

    SelectObject(hdc,oldBrush);
    DeleteObject(hBrush);



}
