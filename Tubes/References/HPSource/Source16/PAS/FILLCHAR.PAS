{use Turbo Pascal v1.x to 3.x}



program DemoFillChar;
{
       This program demonstrates how the built-in procedure FillChar
       works
}
var
  Seg1:    Integer;
  Ofs1:    Integer;
  Count:   Integer;
  OutWord: Integer;
  Num:     Integer;
  Var1:    Integer;
  Value:   Char;

begin
  ClrScr;
  GotoXY(20,5);
  Write('enter Value for starting address');
  ReadLn(Var1);
  Seg1 := Seg(Var1);
  Ofs1 := Ofs(Var1);
  WriteLn;
  WriteLn('This variable is at segment: ',Seg1,' with an offset of: ',Ofs1);
  WriteLn;
  Write('Now put in a Value(single char) that you wish memory loaded with: ');
  ReadLn(Value);
  Write('Put in how many words you want filled: ');
  ReadLn(Num);
  FillChar(Var1,Num,Value);
  ClrScr;
  WriteLn('Now we print our memory starting with ',Seg1,':',Ofs1);
  for Count := 1 to Num do begin
    OutWord := Mem[Seg1:Ofs1];
    WriteLn(Seg1,':',Ofs1,' has value ',OutWord);
    Ofs1 := Ofs1 + 1;
  end
end. { of program DemoFillChar }

                                                     ord);
    Ofs1 := Ofs1 + 1;
  end
end. { of program DemoFillChar }

                                                     