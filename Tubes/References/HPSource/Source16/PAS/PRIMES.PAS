{Test Primes, for Turbo/FreePascal, http://rudih.info}

program TestPrimes(input, output);

var N: integer;

function Prime(N: integer): boolean;
{Returns true if N is a prime; otherwise, returns false.
 Precondition: N > 0.}
   var I: integer;
begin{Prime}
   if N = 1 then Prime := false
   else if N = 2 then Prime := true
   else
     begin{N > 2}
       Prime := true; {tentatively}
       for I := 2 to N-1 do
         if (N mod I = 0) then Prime := false
     end{N > 2}
end; {Prime}

begin{Program}
  writeln('Enter a positive integer and');
  writeln('I will tell you if it is prime.');
  writeln('Enter a zero to quit.');

  writeln('Enter an integer:');
  readln(N);
  while N > 0 do
  begin{while}
    if Prime(N) then writeln(N, ' is a prime.')
                else writeln(N, ' is not a prime.');
    writeln('Enter an integer:');
    readln(N)
  end; {while}

  writeln('End of program.')
end. {Program}

