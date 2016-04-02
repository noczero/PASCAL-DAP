{Guessing game, for Turbo/FreePascal, http://rudih.info}

program GuessGame;

var num,count,guess,range:integer;

begin
  write('Guessing game -- enter range. e.g. 100: ');
  readln(range);
  writeln('Guess a number 1 to ',range,':');
  num:=random(range);
  num:=num+1;
  count:=0;
  repeat
    readln(guess);
    count:=count+1;
    if(guess<num) then writeln('It is greater');
    if(guess>num) then writeln('It is less');
  until(guess=num);
  writeln('You got it in ',count,' guesses');
  halt;
end.
