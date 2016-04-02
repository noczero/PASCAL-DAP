{Unit converter, for Turbo/FreePascal, http://rudih.info}

var
  result,num:real;
  conv:byte;
  scratch:string[20];

begin
   writeln('---Unit converter---');
   writeln('Enter conversion type, or <0> to quit:');
   writeln('<1>inch-centimetre <2>centimetre-inch');
   writeln('<3>foot-metre <4>metre-foot');
   writeln('<5>mile-kilometre <6>kilometre-mile');
   writeln('<7>pound-kilogram <8>kilogram-pound');
   writeln('<9>ounce-gram <10>gram-ounce');
   writeln('<11>acre-metre square <12>metre square-acre');
   writeln('<13>pint-litre <14>litre-pint');
   writeln('<15>fahrenheit-celsius <16>celsius-fahrenheit');
   readln(conv);
   if(conv<=0) or(conv>16) then halt;
   write('Enter unit measure: ');
   readln(num);
   if(conv=1) then result:=num * 2.54;           {to cent}
   if(conv=2) then result:=num * 0.393;          {to inch}
   if(conv=3) then result:=num * 0.348;          {to met}
   if(conv=4) then result:=num * 3.28;           {to foot}
   if(conv=5) then result:=num * 1.6093;         {to mile}
   if(conv=6) then result:=num * 0.625;          {to km}
   if(conv=7) then result:=num * 0.4536;         {to pound}
   if(conv=8) then result:=num * 2.2075;         {to kgram}
   if(conv=9) then result:=num * 28.3495;        {to oz}
   if(conv=10) then result:=num / 28.3495;       {to gram}
   if(conv=11) then result:=num * 4046.8;        {to acre}
   if(conv=12) then result:=num / 4046.8;        {to m2}
   if(conv=13) then result:=num * 0.568;         {to litre}
   if(conv=14) then result:=num / 0.568;         {to pint}
   if(conv=15) then result:=(num - 32) * 5 / 9;  {to cel}
   if(conv=16) then result:=(num * 9 / 5) + 32;  {to fah}
   writeln('The result is ',result);
   writeln('Press enter to continue...');
   readln(scratch);
end.
