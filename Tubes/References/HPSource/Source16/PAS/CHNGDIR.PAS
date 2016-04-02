{use Turbo Pascal v1.x to 3.x}

program TestChangeDirectory;
{
       Allows you to change the current logged directory.
       You can specify it as a parameter on the command
       line; if you don't, it will prompt you for it.
}

type
  Int                  = -32767..32767;
  String80             = string[ 80 ];
  RegRec =
    record
      AX,BX,CX,DX,BP,SI,DI,DS,ES,Flags : Integer;
    end;

var
  Error                : Int;
  Buffer               : string80;
  Command              : string80 absolute cseg : $80;

procedure ChangeDir(Segment, Offset : Integer;
                    var Error : Int );
var
 Regs                  : RegRec;
begin
  Regs.DS := segment;
  Regs.DX := offset;
  Regs.AX:= $3B00;
  MSDos( Regs );
  Error := Regs.AX and $FF;
end; { of proc ChangeDir }

{    main body of program TestChangeDir   }
begin
  if ( Length( Command ) <= 0 ) then begin
    GotoXY( 10, 10 );
    Write( 'Directory to change to : ' );
    ReadLn( Buffer );
  end
  else Buffer := Command;
  if ( Length( Buffer ) < 80 )
    then Buffer[ Length( Buffer ) + 1 ] := Chr( 0 )
    else Buffer[ 80 ] := Chr( 0 );
  ChangeDir( Dseg, Ofs( Buffer ) + 1, Error );
  if ( Error <> 0 )
    then WriteLn( 'Directory not found.' );
end. { of program TestChangeDir }

                                                                                                                             
                                                                                                                             