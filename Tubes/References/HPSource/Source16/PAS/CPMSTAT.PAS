{use Turbo Pascal v1.x to 3.x}


program CPMstatus;
{
       Reads and writes out CP/M status information
}
const
  CPMversion           =   12;
  CurDisk              =   25;
  AllocVector          =   27;
  DiskParam            =   31;
  GetUser              =   32;


type
  Word                 = Integer;
  HexStr               = string[4];

  DPBREC =
    record
      SPT              : Integer;    { SECTORS PER TRACK }
      BSH              : Byte;       { DATA ALLOCATION BLOCK SHIFT FACTOR }
      BLM              : Byte;
      EXM              : Byte;
(*    DSM              : Integer;    { TOTAL STORAGE CAPACITY } *)
      DSMlo            : Byte;
      DSMhi            : Byte;
      DRM              : Integer;    { NO of DIRECTORY ENTRIES }
      AL0,AL1          : Byte;
      CKS              : Integer;
      OFF              : Integer
    end; { DPBREC }


var
  DPB                  : ^DPBREC;
  RecsPrBlock          : Integer;
  RecsPrDrive          : Real;
  TrksPrDrive          : Real;

  BIOSaddr             : Integer absolute 1;
  BDOSaddr             : Integer absolute 6;

  TPA                  : Real;
  Version              : Integer;
  Result               : Integer;


function Hex(Number: Integer;  Bytes: Integer): HexStr;
const
  T                    : array[0..15] of Char = '0123456789ABCDEF';
var
  D                    : Integer;
  H                    : HexStr;
begin
   H[0]:=Chr(Bytes+Bytes);
   for D:=Bytes+Bytes downto 1 do begin
     H[D]:=T[Number and 15];
     Number:=Number shr 4
   end;
   Hex:=H
end; { of proc Hex }


begin { main body of program CPMStatus }
   ClrScr;
   writeln(
'- Logged -   ---- Records ----   - Tracks -   --- Capacity ---   --- TPA ---');  writeln(
'Drive User   Block Track Drive   Sys. Drive   Directory Drive    Bytes     K');
{  x:   xxx   xxxxx xxxxx xxxxx   xxx  xxxxx   xxxx/xxxx xxxxxK   xxxxx  xx.x }

   Write('  ', Chr(Bdos(CurDisk) + Ord('A')), ':   ',
         Bdos(GetUser,$FFFF):3, '   ');
   DPB:=Ptr(BdosHL(DiskParam));
   with DPB^ do begin
     RecsPrBlock:=BLM+1;
     Write(RecsPrBlock:5);
     Write(SPT:6);
     RecsPrDrive:=(DSMhi*256.0 + DSMlo + 1.0)*RecsPrBlock;
     Write(RecsPrDrive:6:0,'   ');
     Write(OFF:3);
     TrksPrDrive:=RecsPrDrive/SPT + OFF;
     if TrksPrDrive <> Trunc(TrksPrDrive)
       then TrksPrDrive:=TrksPrDrive+1;
     Write(Trunc(TrksPrDrive):7,'   ');
     Write(DRM+1:4,'/',CKS*4:4,Trunc(RecsPrDrive/8):6,'K');
   end;
   TPA:=2.0*(BDOSaddr SHR 1) - $100;
   WriteLn(TPA:8:0,'',TPA/1024:6:1);
   WriteLn;
   writeln('- Operating System -');
   writeln(' Version  BDOS  BIOS');
           {xxxx x.x  xxxx  xxxx}
   Result:=BdosHL(CPMversion);
   Version:=Hi(Result);
   if Version = 0
     then Write('CP/M ')
   else if Version = 1
     then Write('MP/M ')
     else Write('???? ');
   Version:=Lo(Result);
   if Version = 0
     then Write('1.x')
     else Write(Version div $10, '.', Version mod $10);
   WriteLn(Hex(BDOSaddr, 2):6, Hex(BIOSaddr-3, 2):6);
end. { of program CPMStatus }

                                                                                                  { of program CPMStatus }

                                                                                                  