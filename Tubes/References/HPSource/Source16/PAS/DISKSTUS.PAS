{use Turbo Pascal v1.x to 3.x}


program ShowDiskStatus;

{
       ShowDiskStatus uses MSDos and the functions therein to get
       Drive information on either the current Drive or the Drive
       specified on the command line.
}
{$I-,U-,C-}

type                            { TYPE declarations }
  RegRec =
    record           { register pack Used in MSDos call }
      AX, BX, CX, DX, BP, SI, DI, DS, ES, Flags : Integer;
    end;

var
  Tracks,                              { number of available Tracks }
  TotalTracks,                         { number of total Tracks }
  Drive,                               { Drive number }
  Bytes,                               { number of Bytes in one sector }
  Sectors              : Integer;      { number of total Sectors }
  Used,TotalBytes      : Real;
  Regs                 : RegRec;


procedure DiskStatus( Drive : integer;  var Tracks, TotalTracks,
                      Bytes, Sectors : integer );
{
       makes MSDos call to read status of Drive; returns data
       in Tracks, TotalTracks, Bytes, and Sectors
}
begin
  Regs.AX := $3600;               { Get Disk free space }
  Regs.DX := Drive;               { Store Drive number }
  MSDos( Regs );                  { Call MSDos to get disk info }
  Tracks := Regs.BX;              { Get number of Tracks Used }
  TotalTracks := Regs.DX;         {  "    "    "  total Tracks }
  Bytes := Regs.CX;               {  "    "    "  Bytes per sector }
  Sectors := Regs.AX              {  "    "    "  Sectors per cluster }
END; { of proc DiskStatus }

function DefaultDrive : integer;
{
       makes MSDos call to find out what current default drive is
}
var
  Regs : RegRec;
begin
  Regs.AX := $1900;                      { Get current Drive number }
  MSDos( Regs );                         { Call MSDos }
  DefaultDrive := (Regs.AX and $FF) + 1  { Return value via function }
END; { of func DefaultDrive }

begin { main body of program ShowDiskStatus }
  Drive := 0;                             { Initialize Drive }
  If (Mem[Cseg:$80]) > 0                  { Get command line }
    then Drive := Mem[Cseg:$82] and $1F;
  If not ( Drive in [ 1..6 ] )            { If nothing on command line }
    then Drive := 0;                      { or bad drive specified, then }
                                          { then logged drive }
  DiskStatus( Drive, Tracks, TotalTracks, Bytes, Sectors );
  WriteLn;
  WriteLn;
  Write( '       ' );
  If ( Drive = 0 ) then
    Drive := DefaultDrive;
  WriteLn( 'DSCST on Drive ', chr( Drive + $40 ), ':');
  WriteLn;
  { Write disk information }
  WriteLn( Tracks:7, '  available tracks.' );
  WriteLn( TotalTracks:7, '  total tracks.' );
  Used :=  (( TotalTracks - Tracks ) / TotalTracks ) * 100;
  WriteLn( Used:7:2, '% used.' );
  WriteLn( Sectors:7, '  sectors per cluster.' );
  WriteLn( Bytes:7, '  bytes per sector.' );
  TotalBytes := (( Sectors * Bytes * 1.0 ) * Tracks );
  WriteLn( TotalBytes:7:0, '  total bytes available on disk.' );
  WriteLn
end. { of program ShowDiskStatus }

                                                                                                                skStatus }

                                                                                                                