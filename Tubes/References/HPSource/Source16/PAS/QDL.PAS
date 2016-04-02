{use Turbo Pascal v1.x to 3.x}


program QDL;

{------------------------------------------------------------------------------

     QDL uses MSDos to get a listing of an IBM formated diskette.
  The function calls used can be found in the DOS Technical Reference Manual.
  This program saves the current Data Transfer Area ( DTA ) in the variables
  DTAseg and DTAofs.  The DTA is then reset to the Segment and Offset of
  a Buffer variable 'DTA'.

------------------------------------------------------------------------------}
{$I-,U-,C-}


type                            { TYPE declarations }
  Registers =
    record           { register pack used in MSDos call }
      AX, BX, CX, DX, BP, SI, DI, DS, ES, Flags : Integer;
    end;
  Char80arr     = array [ 1..80 ] of Char;
  String80      = string[ 80 ];

var                              { VARIABLE declarations }
  DTA : array [ 1..43 ] of Byte;       { Data Transfer Area Buffer }
  DTAseg,                              { DTA Segment before exicution }
  DTAofs,                              { DTA Offset    "        "     }
  SetDTAseg,                           { DTA Segment and Offset set after }
  SetDTAofs,                           { start of program }
  Error,                               { Error return }
  I, J,                                { used as counters }
  Option : Integer;                    { used to specify file types }
  Regs : registers;                    { register pack for the DOS call }
  Buffer,                              { generic Buffer }
  NamR : String80;                     { file name }
  Mask : Char80arr;                    { file Mask }

{------------------------------------------------------------------------------
     SetDTA resets the current DTA to the new address specified in the
parameters 'SEGMENT' and 'OFFSET'.
------------------------------------------------------------------------------}

procedure SetDTA( Segment, Offset : Integer; var Error : Integer );
begin
  Regs.AX := $1A00;         { Function used to set the DTA }
  Regs.DS := Segment;       { store the parameter Segment in DS }
  Regs.DX := Offset;        {   "    "      "     Offset in DX }
  MSDos( Regs );            { Set DTA location }
  Error := Regs.AX and $FF; { get Error return }
end; { of proc SetDTA }

{------------------------------------------------------------------------------
     GetCurrentDTA is used to get the current Disk Transfer Area ( DTA )
address.  A function code of $2F is stored in the high Byte of the AX
register and a call to the predefined procedure MSDos is made.  This can
also be accomplished by using the "Intr" procedure with the same register
record and a $21 specification for the interrupt.
------------------------------------------------------------------------------}

procedure GetCurrentDTA( var Segment, Offset : Integer;
                         var Error : Integer );
begin
  Regs.AX := $2F00;    { Function used to get current DTA address }
                       { $2F00 is used instead of $2F shl 8 to save
                         three assembly instructions.  An idea for
                         optimization. }
  MSDos( Regs );       { Exicute MSDos function request }
  Segment := Regs.ES;  { Segment of DTA returned by DOS }
  Offset := Regs.BX;   { Offset of DTA returned }
  Error := Regs.AX and $FF;
end; { of proc GetCurrentDTA }


{------------------------------------------------------------------------------
     GetOption returns the code used to find the file names on the current
directory ( ie. hidden, standard, or directory ).
------------------------------------------------------------------------------}

procedure GetOption( var Option : Integer );
var
  Ch : Char;
begin
  Ch := '?';
  Option := 1;
  while ( Ch = '?' ) do begin
    Write( 'File Option to use, [ ? ] for list : ' );
    ReadLn( Ch );
    WriteLn;
    case ( Ch ) of
      '1' : Option := 1;        { -\                             }
      '2' : Option := 7;        {   \                            }
      '3' : Option := 8;        {    - These are the options.    }
      '4' : Option := 16;       {    - Look below for an expla-  }
      '5' : Option := 22;       {   /  of each.                  }
      '6' : Option := 31;       { -/                             }
      '?' : begin               { gives list of possible options }
              WriteLn( 'File options are : ' );
              WriteLn;
              WriteLn( ' [ 1 ] for standard files [ default ].' );
              Write( ' [ 2 ] for system or hidden files ' );
              WriteLn( 'and standard files.' );
              WriteLn( ' [ 3 ] for volume label.' );
              Write( ' [ 4 ] for directories and ' );
              WriteLn( 'standard files.' );
              WriteLn( ' [ 5 ] for directories, hidden or ' );
              Write( '       system files, and standard' );
              WriteLn( ' files.' );
              Write( ' [ 6 ] same as 5, but with volume' );
              WriteLn( ' label included.' );
              WriteLn;
           end;
    else Option := 1;     { if nothing is typed or an }
    end;                     { incorrect entry is made the Option }
  end
end; { of proc GetOption }

{------------------------------------------------------------------------------
     GetFirst gets the first directory entry of a particular file Mask.  The
Mask is passed as a parameter 'Mask' and,  the Option was previosly specified
in the SpecifyOption procedure.
------------------------------------------------------------------------------}

procedure GetFirst( Mask : Char80arr; var NamR : String80;
                    Segment, Offset : Integer; Option : Integer;
                    var Error : Integer );
var
  I : Integer;
begin
  Error := 0;
  Regs.AX := $4E00;          { Get first directory entry }
  Regs.DS := Seg( Mask );    { Point to the file Mask }
  Regs.DX := Ofs( Mask );
  Regs.CX := Option;         { Store the Option }
  MSDos( Regs );             { Exicute MSDos call }
  Error := Regs.AX and $FF;  { Get Error return }
  I := 1;                    { initialize 'I' to the first element }
  repeat                     { Enter the loop that reads in the }
                             { first file entry }
    NamR[ I ] := Chr( mem[ Segment : Offset + 29 + I ] );
    I := I + 1;
  until ( not ( NamR[ I - 1 ] in [ ' '..'~' ] ));
  NamR[ 0 ] := Chr( I - 1 );  { set string length because assigning }
                              { by element does not set length }
end; { of proc GetFirst }

{------------------------------------------------------------------------------
     GetNextEntry uses the first bytes of the DTA for the file Mask, and
returns the next file entry on disk corresponding to the file Mask.
------------------------------------------------------------------------------}

procedure GetNextEntry( var NamR : String80; Segment, Offset : Integer;
                        Option : Integer; var Error : Integer );
var
  I : Integer;
begin
  Error := 0;
  Regs.AX := $4F00;           { Function used to get the next }
                              { directory entry }
  Regs.CX := Option;          { Set the file option }
  MSDos( Regs );              { Call MSDos }
  Error := Regs.AX and $FF;   { get the Error return }
  I := 1;
  repeat
    NamR[ I ] := Chr( mem[ Segment : Offset + 29 + I ] );
    I := I + 1;
  until ( not ( NamR[ I - 1 ] in [ ' '..'~' ] ));
  NamR[ 0 ] := Chr( I - 1 );
end; { of proc GetNextEntry }

{
              main body of program QDL
}

begin
  for I := 1 to 21 do DTA[ I ] := 0;  { Initialize the DTA Buffer }
    for I := 1 to 80 do begin         { Initialize the Mask and }
      Mask[ I ] := Chr( 0 );        { file name buffers }
      NamR[ I ] := Chr( 0 );
    end;
  NamR[ 0 ] := Chr( 0 );              { Set the file name length to 0 }
  WriteLn( 'QDL version 2.00A' );
  WriteLn;
  GetCurrentDTA( DTAseg, DTAofs, Error );  { Get the current DTA address }
  if ( Error <> 0 ) then begin             { Check for errors }
    WriteLn( 'Unable to get current DTA' );
    WriteLn( 'Program aborting.' );         { and abort. }
    Halt;                                   { end program now }
  end;
  SetDTAseg := Seg( DTA );
  SetDTAofs := Ofs( DTA );
  SetDTA( SetDTAseg, SetDTAofs, Error );        { Reset DTA addresses }
  if ( Error <> 0 ) then begin                  { Check for errors }
    WriteLn( 'Cannot reset DTA' );          { Error message }
    WriteLn( 'Program aborting.' );
    Halt;                                   { end program }
  end;
  Error := 0;
  Buffer[ 0 ] := Chr( 0 );                      { Set Buffer length to 0 }
  GetOption( Option );                          { Get file Option }
  if ( Option <> 8 ) then begin
    Write( 'File Mask : ' );                { prompt }
    ReadLn( Buffer );
    WriteLn;
  end;
  if ( length( Buffer ) = 0 ) then              { if nothing was entered }
    Buffer := '????????.???';                  { then use global search }
  for I := 1 to length( Buffer ) do       { Assign Buffer to Mask }
    Mask[ I ] := Buffer[ I ];
  GetFirst( Mask, NamR, SetDTAseg, SetDTAofs, Option, Error );
  if ( Error = 0 ) then begin            { Get the first directory entry }
    if ( Option <> 8 ) then begin        { if not volume label }
      WriteLn( 'Directory of : ', Buffer ); { Write directory message }
      WriteLn;
    end;
    WriteLn( NamR )
  end
  else if ( Option = 8 ) then
    WriteLn( 'Volume label not found.' )
  else WriteLn( 'File ''', Buffer, ''' not found.' );
  while ( Error = 0 ) do begin
    GetNextEntry( NamR, SetDTAseg, SetDTAofs, Option, Error );
    if ( Error = 0 ) then WriteLn( NamR );
  end;
  SetDTA( DTAseg, DTAofs, Error );
end. { end Main }


                                      en WriteLn( NamR );
  end;
  SetDTA( DTAseg, DTAofs, Error );
end. { end Main }


                                      