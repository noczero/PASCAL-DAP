{use Turbo Pascal v1.x to 3.x}


program PassFunc;
{
       This routine expects the assembly language routine 'Pass'
       to reside in the file 'PASS.COM'
}
var
  Var1, Var2, Var3: Integer;

function Pass(VarX, VarY: Integer): Integer; external 'PASS.COM';


begin { main body of program PassFunc }
 repeat
    ReadLn(Var1);
    if Var1<>0 then begin
      ReadLn(Var2);
      Var3 := Pass(Var1,Var2);
      WriteLn(Var1,' + ',Var2,' = ',Var3);
      WriteLn
    end
 until Var1 = 0
end. { of program PassFunc }

   r2);
      WriteLn(Var1,' + ',Var2,' = ',Var3);
      WriteLn
    end
 until Var1 = 0
end. { of program PassFunc }

   