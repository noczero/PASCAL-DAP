{use Turbo Pascal v1.x to 3.x}


PROGRAM MyName;

CONST
  TotalTimes = 20;

VAR
  Name :           String[25];
  NumberOfTimes :  integer;

BEGIN
  WRITE('What is your name, please: ');
  READLN(Name);
  CLRSCR;
  FOR NumberOfTimes := 1 TO TotalTimes DO
    BEGIN
      WRITELN('Your name is: ',Name);
    END;
END.
                                                                                   LN('Your name is: ',Name);
    END;
END.
                                                                                   