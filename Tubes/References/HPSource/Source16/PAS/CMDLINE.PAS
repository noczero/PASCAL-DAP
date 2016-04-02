{use Turbo Pascal v1.x to 3.x}


{ This program demonstrates how to get information off the command
  line.  One thing you must remember - 32 characters are always
  there for you to use - if you want to use the full 127, the first
  statement in your program must parse the command line and retrieve
  the information as any subsequent reads or writes will shorten the
  command line to 32 characters.}

program CommandLine;
type
  CommandString  = string[127];

var
  Buffer         : CommandString;
  CL             : CommandString absolute cseg:$80;

begin
  Buffer := CL;
  Gotoxy(20,12);
  WriteLn('|',Buffer, '|');
end. { of program CommandLine }

                                                                                                                          

                                                                                                                          