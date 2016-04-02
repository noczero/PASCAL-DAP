{use Turbo Pascal v1.x to 3.x}


program Scalars;
{
       This program illustrates the use of declared scalar
       types (DSTs) and subranges.  It also makes use of
       arrays, strings, and sets.
}
const
  XMax                 =  8;
  YMax                 = 10;
type
  XRange               = 1..XMax;
  YRange               = 1..YMax;
  ShipType             = (NoShip,Constitution,Enterprise,Reliant,
                          Loknar,Larson,Chandley,Excelsior,Baker);
  Names                = string[12];
  Prompt               = string[80];
var
  ShipName             : array[ShipType] of Names;
  Sector               : array[XRange,YRange] of ShipType;
  Ship                 : ShipType;
  SX                   : XRange;
  SY                   : YRange;


procedure ShowSector(SX,SY : Integer);
{
       Writes type of ship at appropriate location on screen
}
begin
  GotoXY(4*SX,10+SY);
  if Sector[SX,SY] = NoShip
    then Write('***')            { if no ship there }
    else Write(Copy(ShipName[Sector[SX,SY]],1,3))
end;

procedure Initialize;
{
       Performs initialization of various items, most notably
       the array ShipName
}
begin
  { set each element in array to appropriate string }
  ShipName[NoShip]       := '';                { null string }
  ShipName[Constitution] := 'Constitution';
  ShipName[Enterprise]   := 'Enterprise';
  ShipName[Reliant]      := 'Reliant';
  ShipName[Loknar]       := 'Loknar';
  ShipName[Larson]       := 'Larson';
  ShipName[Chandley]     := 'Chandley';
  ShipName[Excelsior]    := 'Excelsior';
  ShipName[Baker]        := 'Baker';
  { fill sector map with "no ships" }
  FillChar(Sector,SizeOf(Sector),Ord(NoShip));
  { display sector map on screen }
  for SX := 1 to XMax do
    for SY := 1 to YMax do
      ShowSector(SX,SY)
end; { of proc Initialize }

procedure WritePrompt(Line : Byte; Msg : Prompt);
{
       Goes to Line, clears it, writes out prompt
}
begin
  GotoXY(1,Line);
  ClrEol;
  Write(Msg)
end; { of proc WritePrompt }

procedure ReadShip(Line : Byte; Msg : prompt; var Ship : ShipType);
{
       Prompts user for ship class; reads it in; check for match;
       repeats entire process if no match
       Note that just hitting <return> decodes as NoShip
}
var
  SName                : Names;
  Sndx                 : ShipType;
  Found                : Boolean;
begin
  repeat
    WritePrompt(Line,Msg);             { write out prompt }
    ReadLn(SName);                     { read in name of ship }
    Found := False;                    { set up for loop }
    for Sndx := NoShip to Baker do     { check for match }
      if ShipName[Sndx] = SName then   { if strings match...}
      begin
        Found := True;                 { then set flag }
        Ship := Sndx;                  { and set Ship }
      end
  until Found                          { do this until a match }
end; { of proc ReadShip }

procedure ReadCoords(Line : Byte; Msg : Prompt;
                     var SX : XRange; var SY : Yrange);
{
       Prompts user to enter in SX,SY coordinates; ensures that
       both values are within range; turns off I/O, range checking
       to avoid bombing on illegal input
}
begin
  {$I-,R-}
  repeat
    WritePrompt(Line,Msg);
    ReadLn(SX,SY)
  until (SX in [1..XMax]) and (SY in [1..YMax]) and (IOresult = 0);
  WritePrompt(Line,'');   { clear line when done }
  {$I+,R+}
end; { of proc ReadCoords }

begin { main body of program Scalars }
  Initialize;
  WritePrompt(1,'Place ships at sector locations.  Hit <CR> when done.');
  repeat
    ReadShip(2,'Enter ship class:  ',Ship);
    if Ship <> NoShip then begin
      ReadCoords(3,'Enter sector for ship:  ',SX,SY);
      Sector[SX,SY] := Ship;
      ShowSector(SX,SY)
    end
  until Ship = NoShip
end. { of program Scalars }








                                                                                        of program Scalars }








                                                                                       