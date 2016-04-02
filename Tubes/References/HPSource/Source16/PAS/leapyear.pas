{Leap year, for Turbo Pascal 3.x, http://rudih.info}

program BetterLeapyear(input, output);

var Year: integer;

LABEL
 loop1;

procedure RegularCalc(Year: integer);
{determines if year is a leap year.
 Only works for years not div by 100.}
  begin{RegularCalc}
   case (Year mod 4) of
    0: writeln('That year is a leap year.');
    3: writeln('The next year might be a leap year.');
    1, 2: writeln ('That year is not a leap year.')
   end {case}
  end;{regular calc}

procedure CenturyCalc(Year: integer);
{determines if year is a leap year.
 Only works for years div by 100.}
  begin{century calc}
   if (Year mod 400) = 0
     then writeln('That year is a leap year.')
     else writeln('Not even close to a leap year.')
  end; {century calc}

begin{program}
 loop1:;
 writeln('Enter a year. 0 exits.');
 readln(Year);
  if (Year mod 100) = 0
   then CenturyCalc(Year)
   else RegularCalc(Year);
 if (Year <> 0) then 
   goto loop1;
end. {program}