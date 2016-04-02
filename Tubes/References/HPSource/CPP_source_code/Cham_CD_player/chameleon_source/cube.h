#ifndef CUBE
#define CUBE



#define MAX_POLY_VERTEX 6
#define RADIANS 3.141592/180


struct StaticVertex {
  short x,y,z;
};

struct Vertex {
  short x,y,z;           //the 3d world coords
  unsigned short sx,sy;  //the screen coords crated later
};



struct POLYGON {
  BYTE red,green,blue;
  Vertex *vertex[MAX_POLY_VERTEX];
};


struct OBJECT3D {
  short x,y,z, xAngle,yAngle,zAngle;

  unsigned short numVertex,numPoly;
  StaticVertex *originalVertex;
  Vertex *vertexList;
  POLYGON *polyList;
};



extern OBJECT3D cube;

void drawPolygon(HDC hdc,POLYGON *poly,int i,BOOL patterndraw,HBITMAP *pattern);
void screenConvertVertex(Vertex *v,int x, int y, int zoom);
short backfacing(POLYGON *poly);
void rotateVertex(StaticVertex *sv,Vertex *v,
		  int angle_x,int angle_y,int angle_z);




#endif
