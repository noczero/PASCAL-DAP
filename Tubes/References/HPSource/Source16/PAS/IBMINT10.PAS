{use Turbo Pascal v1.x to 3.x}


program IBMpcScreen;

    { This program shows the use of direct Video on the IBM-PC. }
    { Interrupt 10 is used for all Video I/O                    }

const
  Video                =  $10;  { Set Video I/O Interrupt }
  SetVideo             =    0;  { Set Video mode }
  SetCurPosition       = $200;  { Set cursor position }
  ReadCursor           = $300;  { Read cursor position }
  WriteChar            = $E00;  { Write character to sceen }
  VideoBW80x25A        =    2;  { Mode 80x25 B/W, Alpha }
  VideoColor80x25A     =    3;  { Mode 80x25 Color, Alpha }

type
  Result =                      { Register pack }
    record
      AX,BX,CX,DX,BP,SI,DI,DS,ES,Flags: Integer;
    end;

var
  Rec                  : Result;
  Row,Col              : Integer;

begin
  Rec.AX := SetVideo + VideoBW80x25A;              { assumes BW 80x25 display }
  Rec.BX := 15;
  Intr(Video,Rec);                                           { Set Video Mode }
  Rec.AX := WriteChar + Ord('A');
  Intr(Video,Rec);                                           { Output 'A'     }
  Rec.AX := ReadCursor;
  Intr(Video,Rec);                                 { Read the cursor position }
  Row := Rec.DX and $FF00 shr 8;
  Col := Rec.DX and $FF;
  Write('Row =',Row,' Column = ',Col);              { Show the Row and column }
  Rec.AX := SetCurPosition;
  Rec.DX := $0A0A;
  Intr(Video,Rec);                   { Set the cursor to Row 10 and column 10 }
  Rec.AX := WriteChar + Ord('#');
  Intr(Video,Rec);                                           { Output '#'     }
  Rec.AX := ReadCursor;
  Intr(Video,Rec);                                 { Read the cursor position }
  Row := Rec.DX and $FF00 shr 8;
  Col := Rec.DX and $FF;
  Write('Row =',Row,' Column = ',Col);              { Show the Row and column }
  Rec.AX := SetCurPosition;
  Rec.DX := $1414;
  Intr(Video,Rec);                   { Set the cursor to Row 20 and column 20 }
end. { of program IBMpcScreen }

                                                     the cursor to Row 20 and column 20 }
end. { of program IBMpcScreen }

                                                    