{use Turbo Pascal v1.x to 3.x}


program RandomTest;
{
       This program tests out the Randomize procedure.  It also
       calculates a chi-square value as a test of Random itself.
       Chi-square values between 3 and 16 are desirable, with
       values close to 8.3 being optimum.
}
var
  S1,S2,Indx,Jndx,Count  : Integer;
  Sum,T,NP               : Real;
  Tally                  : array[0..9] of Integer;
{
   Randomize Procedure For MS-DOS & PC-DOS Turbo Pascal

   This new Randomize has two Integer parameters.  If they are both 0, then
the random number seed is set randomly.  If either of the parameters is
nonzero, then they are both stored directly into the 32 bit seed.

   To set the seed randomly (Randomize(0,0)), the procedure calls MS-DOS
to get the current time.  This is a 32 bit value, which is also stored
directly into the seed.  On some systems, (i.e. the NCR Decision Mate V),
the clock does not tick, so the time never changes.  Randomize checks this,
and if the clock hasn't changed after a Delay(100), it asks the user to hit
a key.  While waiting for the key, it continuously increments two counters.
These are then stored into the seed.

{ Please note:  This routine is for MS-Dos/PC-Dos Turbo ONLY! }

procedure Randomize(I,J: Integer);

var
  RSet    : record
              AX,BX,CX,DX,BP,SI,DI,DS,ES,Flags: Integer;
            end;
  Ch      : Char;

begin
  if (I=0) and (J=0) then begin     { Generate a random random number seed }
    RSet.AX:=$2C00;                             { DOS time of day function }
    MSDos(RSet);
    I:=RSet.CX;                           { Set I and J to the system time }
    J:=RSet.DX;
    Delay(100);   { This delay may have to be increased for faster systems }
    MSDos(RSet);
    if (I=RSet.CX) and (J=RSet.DX) then begin        { Clock isn't ticking }
      I := 0;
      J := 0;
      while KeyPressed do
        Read(Kbd,Ch);                              { Clear keyboard buffer }
      Write('Hit any key to set the random number generator: ');
      repeat
        I := I+13;
        J := J+17
      until Keypressed;
      Read(Kbd,Ch);                                 { Absorb the character }
      WriteLn
    end
  end;
  MemW[DSeg:$129]:=I;  { This is the core of the routine: store a 32 bit }
  MemW[DSeg:$12B]:=J;  {  seed at locations DSeg:$0129...DSeg:$012C      }
end; { of procedure Randomize }

begin  { main body of program RandomTest }
  Writeln('Enter count <= 0 to end program');
  repeat
    Write('Enter count:          ');           { get # of samples }
    ReadLn(Count);
    if Count > 0 then begin                    { do random number test }
      Write('Enter seeds (S1 S2):  ');         { get 2 integers for seed }
      ReadLn(S1,S2);
      Randomize(S1,S2);                        { set random number seed }
      FillChar(Tally,SizeOf(Tally),0);         { clear tally array }
      for Indx := 1 to Count do begin          { generate Count numbers }
        Jndx := Random(10);                    { range is 0..9 }
        Tally[Jndx] := Tally[Jndx] + 1         { count how many of each }
      end;
      Sum := 0.0;                              { clear sum for X^2 }
      NP := Count/10.0;                        { theoretical number for each }
      for Indx := 0 to 9 do begin              { for each possible result do }
        Write(Tally[Indx]:5);                  { write total for that value }
        Sum := Sum + Sqr(Tally[Indx]-NP)/NP    { and calculate X^2 }
      end;
      WriteLn;
      WriteLn('Chi-Square (9 degrees of freedom) = ',Sum:8:3)
    end
  until Count <= 0
end. { of program RandomTest }


                     re (9 degrees of freedom) = ',Sum:8:3)
    end
  until Count <= 0
end. { of program RandomTest }


                     