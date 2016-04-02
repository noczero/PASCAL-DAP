{use Turbo Pascal v1.x to 3.x}


{$U+}

  var
    Port,Baud,StopBits,DataBits,Par: Integer;
    Message: String[80];

  type
    String19=String[19];

{ A set of routines to enable COM1 and COM2 to be accessed from Turbo Pascal.
  The following procedures are meant to be called by your programs:
 
  AssignAux(PortNumber in [1,2]) assigns Aux to COM1 or COM2
  AssignUsr(PortNumber in [1,2]) assigns Usr to COM1 or COM2
  SetSerial(PortNumber in [1,2],
            BaudRate in [110,150,300,600,1200,2400,4800,9600],
            StopBits in [1,2],
            DataBits in [7,8],
            Parity in [None,Even,Odd]) sets the baud rate, stop bits, data
                               bits, and parity of one of the serial ports.
 
  The arrays InError and OutError may be examined to detect errors.  The bits
  are as follows:
     Bit 7 (128)        Time out (no device connected)
     Bit 3 (8)          Framing error
     Bit 2 (4)          Parity error
     Bit 1 (2)          Overrun error

  Function SerialStatus(PortNumber in [1,2]) returns a more complete status:
     Bit 15 (negative)  Time out (no device connected)
     Bit 14 (16384)     Transmission shift register empty
     Bit 13 (8192)      Transmission holding register empty
     Bit 12 (4096)      Break detect
     Bit 11 (2048)      Framing error
     Bit 10 (1024)      Parity error
     Bit 9  (512)       Overrun error
     Bit 8  (256)       Data ready
     Bit 7  (128)       Received line signal detect
     Bit 6  (64)        Ring indicator
     Bit 5  (32)        Data set ready
     Bit 4  (16)        Clear to send
     Bit 3  (8)         Delta receive line signal detect
     Bit 2  (4)         Trailing edge ring detector
     Bit 1  (2)         Delta data set ready
     Bit 0  (1)         Delta clear to send
 
  Identifiers starting with "__" are not meant to be used by the user program.
}
 
  Type
    __RegisterSet=Record case Integer of
                  1: (AX,BX,CX,DX,BP,DI,SE,DS,ES,Flags: Integer);
                  2: (AL,AH,BL,BH,CL,CH,DL,DH: Byte);
                end;
    __ParityType=(None,Even,Odd);
 
  var
    __Regs: __RegisterSet;
    InError,OutError: Array [1..2] of Byte;
 
  procedure __Int14(PortNumber,Command,Parameter: Integer);
  { do a BIOS COM driver interrupt }
 
    begin
      with __Regs do
       begin
        DX:=PortNumber-1;
        AH:=Command;
        AL:=Parameter;
        Flags:=0;
        Intr($14,__Regs);
       end;
    end;

 
  procedure SetSerial(PortNumber,BaudRate,StopBits,DataBits: Integer;
                      Parity: __ParityType);
  { Set serial parameters on a COM port }
 
    var
      Parameter: Integer;
 
    begin
      case BaudRate of
        110: BaudRate:=0;
        150: BaudRate:=1;
        300: BaudRate:=2;
        600: BaudRate:=3;
        1200: BaudRate:=4;
        2400: BaudRate:=5;
        4800: BaudRate:=6;
        else BaudRate:=7; { Default to 9600 baud }
       end;
      if StopBits=2 then StopBits:=1
      else StopBits:=0; { Default to 1 stop bit }
      if DataBits=7 then DataBits:=2
      else DataBits:=3; { Default to 8 data bits }
      Parameter:=(BaudRate Shl 5)+(StopBits Shl 2)+DataBits;
      case Parity of
        Odd: Parameter:=Parameter+8;
        Even: Parameter:=Parameter+24;
        else; { Default to no parity }
       end;
      __Int14(PortNumber,0,Parameter);
    end;
 
 
  Function SerialStatus(PortNumber: Integer): Integer;
  { Return the status of a COM port }
 
    begin
      __Int14(PortNumber,3,0);
      SerialStatus:=__Regs.AX;
    end;
 
 
  procedure __OutPort1(C: Byte);
  { Called by Write to Aux or Usr when assigned to COM1 }
 
    begin
      while (SerialStatus(1) and $30)=0 do ;
      __Int14(1,1,C);
      OutError[1]:=OutError[1] Or (__Regs.AH and $8E);
    end;
 
 
  procedure __OutPort2(C: Byte);
  { Called by Write to Aux or Usr when assigned to COM2 }
 
    begin
      while (SerialStatuS(2) and $30)=0 do ;
      __Int14(2,1,C);
      OutError[2]:=OutError[2] Or (__Regs.AH and $8E);
    end;
 
 
  Function __InPort1: Char;
  { Called by Read from Aux or Usr when assigned to COM1 }
 
    begin
      __Int14(1,2,0);
      __InPort1:=Chr(__Regs.AL);
      InError[1]:=InError[1] Or (__Regs.AH and $8E);
    end;
 
 
  Function __InPort2: Char;
  { Called by Read from Aux or Usr when assigned to COM2 }
 
    begin
      __Int14(2,2,0);
      __InPort2:=Chr(__Regs.AL);
      InError[2]:=InError[2] Or (__Regs.AH and $8E);
    end;
 
 
  procedure __AssignPort(PortNumber: Integer; var InPtr,OutPtr: Integer);
  { Assign either Aux or Usr to either COM1 or COM2 }
 
    begin
      if PortNumber=2 then
       begin
        OutPtr:=Ofs(__OutPort2);
        InPtr:=Ofs(__InPort2);
       end
      else { Default to port 1 }
       begin
        OutPtr:=Ofs(__OutPort1);
        InPtr:=Ofs(__InPort1);
       end;
      InError[PortNumber]:=0;
      OutError[PortNumber]:=0;
    end;
 
 
  procedure AssignAux(PortNumber: Integer);
  { Assign Aux to either COM1 or COM2 }
 
    begin
      __AssignPort(PortNumber,AuxInPtr,AuxOutPtr);
    end;
 
 
  procedure AssignUsr(PortNumber: Integer);
  { Assign Usr to either COM1 or COM2 }


    begin
      __AssignPort(PortNumber,UsrInPtr,UsrOutPtr);
    end;

 
  Function Binary(V: Integer): String19;
 
    var
      I: Integer;
      B: Array [0..3] of String[4];
 
    begin
      For I:=0 To 15 do
        if (V and (1 Shl (15-I)))<>0 then B[I Div 4][(I Mod 4)+1]:='1'
        else B[I Div 4][(I Mod 4)+1]:='0';
      For I:=0 To 3 do B[I][0]:=Chr(4);
      Binary:=B[0]+' '+B[1]+' '+B[2]+' '+B[3];
    end;
 
 
  begin
    Write('Enter port number:                    ');
    ReadLn(Port);
    AssignUsr(Port);
    Write('Enter baud rate:                      ');
    ReadLn(Baud);
    Write('Enter stop bits:                      ');
    ReadLn(StopBits);
    Write('Enter data bits:                      ');
    ReadLn(DataBits);
    Write('Enter parity (0=none, 1=even, 2=odd): ');
    ReadLn(Par);
    Write('Enter message to print:               ');
    ReadLn(Message);
    SetSerial(1,Baud,StopBits,DataBits,__ParityType(Par));
    WriteLn(Usr,Message);
    WriteLn('OutError[',Port,']: ',Binary(OutError[Port]));
    WriteLn('SerialStatus(',Port,'): ',Binary(SerialStatus(Port)));
  end.
                                              ;
    WriteLn('SerialStatus(',Port,'): ',Binary(SerialStatus(Port)));
  end.
                                              