{use Turbo Pascal v1.x to 3.x}


program ScreenMap;

  {  program to Write to the screen map  }

const
  ColorSeg   = $B000;
  ColorOfs   = $8000;
  BWSeg      = $B000;
  BWOfs      = $0000;

var
  I,J        : Integer;
  C          : Char;
  RowNumber,ColNumber,Length,Dir
             : Integer;
  Direction  : Char;

procedure X(J,K : Integer);
begin
  Mem[ColorSeg:ColorOfs + J] := K    { Write to screen memory }
end; { of proc X }

procedure Y(R,C,N,Ch,D : Integer);    {r=row C=column n=length ch=char}
var
  I,J : Integer;
begin
  J :=((R-1)*160) + ((C-1)*2);      { compute starting location }
  for I := 1 to N do begin
    X(J,Ch);                        { loop n times }
    if D=0
      then J := J + 160
      else J:= J+2;
  end
end; { of proc Y }

begin
  ClrScr;
  GotoXY(20,10);
  Write('Do you want to play <Y/N> ? ');
  Read(kbd,C);
  if (C = 'y') or (C = 'Y') then begin
    repeat
      ClrScr;
      GotoXY(20,10);
      Write('Would you like to draw a line <Y/N> ? ');
      Read(kbd,C);
    until (C = 'y') or (C = 'Y') or (C = 'n') or (C = 'N');
    if (C = 'y') or (C = 'Y') then begin
      repeat
        ClrScr;
        Y(1,1,80,31,1);
        Y(2,1,24,16,0);
        Y(2,80,24,17,0);
        Y(25,2,78,30,1);
        GotoXY(20,10);
        Write('The line start at what row? ');
        Read(rownumber);
        GotoXY(20,12);
        Write('               what column? ');
        Read(colnumber);
        GotoXY(20,14);
        Write('     Line length in number? ');
        Read(length);
        GotoXY(20,16);
        Write('     What charactor to use? ');
        Read(Kbd,C); Write(C);
        repeat
          GotoXY(10,18); Write(' which direction <d>own or <a>cross ? ');
          Read(Direction)
        until (Direction='a') or (Direction='d');
        if Direction='a'
          then Dir:=1
          else Dir:=0;
        ClrScr;
        Y(rownumber,colnumber,length,ord(C),dir);
        GotoXY(40,24);
        Write('Your line. Try again? ');
        Read(Trm,C);
       until (C <> 'Y') and (C <> 'y');
       ClrScr
    end
  end
  else begin
    GotoXY(23,13);
    WriteLn('******** Bye ********')
  end
end. { of program ScreenMap }                                                                   ****** Bye ********')
  end
end. { of program ScreenMap }                                                                   