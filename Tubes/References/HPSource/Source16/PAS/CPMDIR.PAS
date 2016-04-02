{use Turbo Pascal v1.x to 3.x}


program CPM80Dir;
  { This program will give a directory of the logged drive. }
const
  Search_First         : Integer = $11;
  Search_Next          : Integer = $12;
  Set_DMA              : Integer = $1A;
var
  Error, Loop, Start   : Integer;
  FCB                  : array[0..25] of Byte absolute $005C;
  DMA                  : array[0..255] of Byte;

begin
  Error := BDos(Set_DMA,Addr(DMA));
  FCB[0] := 0;
  for Loop := 1 to 11 do
    FCB[Loop] := ord('?');
  Error := BDos(Search_First,Addr(FCB));
  if Error <> 255 then begin
    Start := Error * 32;
    for Loop:= Start to start+8 do
      Write(Char(Mem[Addr(DMA)+Loop]));
    Write(' ');
    for Loop:= Start+9 to Start+11 do
      Write(Char(Mem[Addr(DMA)+Loop]));
    WriteLn
  end;
  repeat
    Error := BDos(search_Next);
    Start := Error * 32;
    if Error <> 255 then begin
      for Loop:= Start to start+8 do
        Write(Char(Mem[Addr(DMA)+Loop]));
      Write(' ');
     for Loop:= Start+9 to Start+11 do
       Write(Char(Mem[Addr(DMA)+Loop]));
     WriteLn
  end
 until Error=255
end. { of program CPM80Dir }
                        ite(Char(Mem[Addr(DMA)+Loop]));
     WriteLn
  end
 until Error=255
end. { of program CPM80Dir }
                        