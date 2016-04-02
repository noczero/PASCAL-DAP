{use Turbo Pascal v1.x to 3.x}


program InLineSample;
{
       The following program example divides even integers by two.
       For odd integers this program returns -32768 + the value
       divided by two (integer division)
}
var
  Value : Integer;

procedure VInLine(var Value:Integer);
begin
  inline
    ($C4/$BE/VALUE/             { LES     DI,VALUE[BP]     }
     $F8/                       { CLC                      }
     $26/$D0/$1D/               { RCR     ES:BYTE PTR [DI] }
     $47/                       { INC     DI               }
     $26/$D0/$1D);              { RCR     ES:BYTE PTR [DI] }
end; { of proc VInLine }

begin { main body of program InLineSample }
  ClrScr;
  repeat
    Write('Enter a number, <0> to quit: ');
    ReadLn(Value);
    VInLine(Value);
    WriteLn('Return Value is:            ',Value);
  until Value = 0;
  ClrScr;
end. { of program InLineSample }

                                                                                                                             
                                                                                                                             