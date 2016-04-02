{Calendar, for Turbo Pascal 3.x, http://rudih.info}

program Calendar(input, output);
{Displays a calendar layout of any month.}

var FirstDay, NumberOfDays: integer;
    Ans: char;

procedure DisplayMonth(NumberOfDays, FirstDay: integer);
{Displays the usual layout for a month with NumberOfDays days in it.
 FirstDay codes the first day of the month: 1 for Sunday, 2 for Monday, ect.}
   const Width = 4; {Field width for one day of the calendar}
         Blank = ' ';
   var WeekDay, DayCount: integer;
begin{DisplayMonth}
   writeln('Sun':Width, 'Mon':Width, 'Tue':Width,
           'Wed':Width, 'Tue':Width, 'Fri':Width, 'Sat':Width);
   for WeekDay := 1 to  FirstDay-1 do
       write(Blank:Width);
   WeekDay := FirstDay;
   for DayCount := 1 to NumberOfDays do
     begin{for}
       {WeekDay is the day of the week
       for day number DayCount.}
       write(DayCount:Width);
       if (WeekDay mod 7) = 0 then writeln;
       WeekDay := WeekDay + 1
     end; {for}
   writeln
end; {Display Month}

begin{program}
  writeln('I will display a calendar of a month.');
  repeat
    writeln('Enter the number of days in the month:');
    readln(NumberOfDays);
    writeln('Enter the first day of month, 1 for Sunday,');
    writeln('2 for Monday, 3 for Tuesday and so on.');
    readln(FirstDay);
    DisplayMonth(NumberOfDays, FirstDay);
    writeln('Do you want to see another month?');
    writeln('(y or n):');
    readln(Ans)
  until (Ans = 'N') or (Ans = 'n');
  writeln('Have a good month!')
end. {Program}
