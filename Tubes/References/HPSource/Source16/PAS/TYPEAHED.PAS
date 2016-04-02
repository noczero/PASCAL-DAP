{use Turbo Pascal v1.x to 3.x}


{$U-,C-}
program Buffered;
{
       The $C- directive is necessary for type-ahead (buffered)
       input; otherwise, characters will be lost.  Also, since
       Read(Ch) require an end-of-line before processing, you
       must use the Read(Kbd,Ch).  Type "#" to end the program.
}
var
  Ch                   : Char;
  Indx,Jndx            : Integer;
begin
  repeat
    for Indx := 1 to 10000 do   { delay loop to show type-ahead }
      Jndx := Indx + Indx;
    Read(Kbd,Ch);               { get next character from buffer }
    Write(Ch)                   { and echo it back out to the screen }
  until Ch = '#'
end. { of program Buffered }

                                                                                                   { of program Buffered }

                                                                                                   