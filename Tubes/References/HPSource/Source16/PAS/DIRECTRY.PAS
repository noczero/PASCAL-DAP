{use Turbo Pascal v1.x to 3.x}


program DirList;
{
       This is a simple program to list out the directory of the
       current (logged) drive.
}
type
  Char12arr            = array [ 1..12 ] of Char;
  String20             = string[ 20 ];
  RegRec =
    record
      AX, BX, CX, DX, BP, SI, DI, DS, ES, Flags : Integer;
    end;

var
  Regs                 : RegRec;
  DTA                  : array [ 1..43 ] of Byte;
  Mask                 : Char12arr;
  NamR                 : String20;
  Error, I             : Integer;

begin { main body of program DirList }

  FillChar(DTA,SizeOf(DTA),0);        { Initialize the DTA buffer }
  FillChar(Mask,SizeOf(Mask),0);      { Initialize the mask }
  FillChar(NamR,SizeOf(NamR),0);      { Initialize the file name }

  WriteLn( 'Directory list program for MS-Dos.' );
  WriteLn;
  Regs.AX := $1A00;         { Function used to set the DTA }
  Regs.DS := Seg(DTA);      { store the parameter segment in DS }
  Regs.DX := Ofs(DTA);      {   "    "      "     offset in DX }
  MSDos(Regs);              { Set DTA location }
  Error := 0;
  Mask := '????????.???';    { Use global search }
  Regs.AX := $4E00;          { Get first directory entry }
  Regs.DS := Seg(Mask);      { Point to the file Mask }
  Regs.DX := Ofs(Mask);
  Regs.CX := 22;             { Store the option }
  MSDos(Regs);               { Execute MSDos call }
  Error := Regs.AX and $FF;  { Get Error return }
  I := 1;                    { initialize 'I' to the first element }
  if (Error = 0) then
    repeat
      NamR[I] := Chr(Mem[Seg(DTA):Ofs(DTA)+29+I]);
      I := I + 1;
    until not (NamR[I-1] in [' '..'~']) or (I>20);

  NamR[0] := Chr(I-1);          { set string length because assigning }
                                { by element does not set length }
  while (Error = 0) do begin
    Error := 0;
    Regs.AX := $4F00;           { Function used to get the next }
                                { directory entry }
    Regs.CX := 22;              { Set the file option }
    MSDos( Regs );              { Call MSDos }
    Error := Regs.AX and $FF;   { get the Error return }
    I := 1;
    repeat
      NamR[I] := Chr(Mem[Seg(DTA):Ofs(DTA)+29+I]);
      I := I + 1;
    until not (NamR[I-1] in [' '..'~'] ) or (I > 20);
    NamR[0] := Chr(I-1);
    if (Error = 0)
      then WriteLn(NamR)
  end
end. { of program DirList  }
                                    I-1);
    if (Error = 0)
      then WriteLn(NamR)
  end
end. { of program DirList  }
                                    