{use Turbo Pascal v1.x to 3.x}


Program Filter;

{ This is an example of a simple MS-DOS filter written in Turbo Pascal.
  This filter copies its standard input to its standard output with all
  letters converted to lowercase.

  The MS-DOS facilities of redirection, piping, and simultaneous printing
  through the use of ^P or ^PrtSc will work on any program that has the 2
  procedure/functions used, and has the statements   ConInPtr:=Ofs(GetC);
  ConOutPtr:=Ofs(PutC);  in it.

  Input is read from Kbd to prevent echoing.

  Try FILTER <file.ext >newfile.ext.  The file file.ext should be copied
  to newfile.ext with all letters converted to lowercase.
 }

  Type
    RegisterSet=Record Case Integer Of
                  1: (AX,BX,CX,DX,BP,SI,DI,DS,ES,Flags: Integer);
                  2: (AL,AH,BL,BH,CL,CH,DL,DH: Byte);
                End;

  Var
    Regs: RegisterSet;


  Function GetC: Byte;

    Begin
      Regs.AH:=8;
      MsDos(Regs);
      GetC:=Regs.AL;
    End;

  Procedure PutC(C: Byte);

    Begin
      Regs.AH:=2;
      Regs.DL:=C;
      MsDos(Regs);
    End;

  Var
    S: String[255];
    I: Byte;

  Begin
    ConInPtr:=Ofs(GetC);
    ConOutPtr:=Ofs(PutC);
    While Not Eof(Kbd) Do
     Begin
      ReadLn(Kbd,S);
      For I:=1 To Length(S) Do
        If (S[I]>='A') And (S[I]<='Z') Then S[I]:=Chr(Ord(S[I])+32);
      WriteLn(S);
     End;
  End.
 To Length(S) Do
        If (S[I]>='A') And (S[I]<='Z') Then S[I]:=Chr(Ord(S[I])+32);
      WriteLn(S);
     End;
  End.
 