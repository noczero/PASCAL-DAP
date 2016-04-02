{use Turbo Pascal v1.x to 3.x}


program MouseSketch;
{
       This program shows how to read the Microsoft Mouse.
                       ***WARNING***
       Be sure that you have loaded the mouse driver (by
       running MOUSE.COM) before executing this program.
}

type
  RegPack =
    record
      AX,BX,CX,DX,BP,SI,DI,DS,ES,Flags : Integer;
    end;

var
  OldX,OldY,X,Y : Integer;
  M1,M2,M3,M4 :   Integer;
  RegPak :        RegPack;

procedure Mouse(var M1,M2,M3,M4 : Integer);
var
  Regs : RegPack;

begin
  with Regs do begin
    AX := M1;                { Set up ax,bx,cx,dx for interrupt }
    BX := M2;
    CX := M3;
    DX := M4
  end;
  Intr(51,Regs);             { Trip interrupt 51 }
  with Regs do begin
    M1 := AX;
    M2 := BX;
    M3 := CX;
    M4 := DX
  end
end; { of proc Mouse }


begin { main body of program MouseSketch }
  M1 := 0;
  M2 := 0;
  M3 := 0;
  M4 := 0;
  HiRes;                     { Choose graphics mode and color }
  HiResColor(Yellow);
  M1 := 0;                   { Initialize mouse driver }
  Mouse(M1,M2,M3,M4);
  M1 := 1;                   { Turn on Mouse cursor }
  Mouse(M1,M2,M3,M4);
  M1 := 3;
  OldX := 0;
  OldY := 0;
  while not KeyPressed do begin   { Exit mouse when any key pressed }
    Mouse(M1,M2,M3,M4);
    if M2 <> 0
      then Draw(OldX,OldY,M3,M4,1); { Draw if button pushed }
    OldX := M3;
    OldY := M4
  end
end. { of program MouseSketch }

                                                                                        d
end. { of program MouseSketch }

                                                                                        