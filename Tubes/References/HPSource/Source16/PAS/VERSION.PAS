{use Turbo Pascal v1.x to 3.x}


program DosVersion;

function DosVer : Real;
var
  Regs    : record
              AX,BX,CX,DX,BP,SI,DI,DS,ES,Flags : Integer;
            end;
  AL,AH   : Byte;

 begin
   Regs.AX := $3000;
   MSDos( Regs );
   AL := Regs.AX and $FF;
   AH := ( Regs.AX and $FF00 ) shr 8;
   DosVer := AL + AH/100;
 end; { of func DosVer }

begin { main body of program DosVersion }
  WriteLn;
  WriteLn;
  WriteLn( DosVer:4:2 );
end. { of program DosVersion }
                                           
  WriteLn;
  WriteLn;
  WriteLn( DosVer:4:2 );
end. { of program DosVersion }
                                           