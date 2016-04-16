program prog1_drawstars;
const maxstars = 20;
var
	i,numstars : Integer;


procedure draw_stars();
var
	i: Integer;
begin
	for i := 1 to numstars do
	write('*');
end;

begin
	for i:= 1 to maxstars do
	begin
		numstars := 30;
		if (i div 2 = 1) then
		draw_stars;
		writeln;
	end;
end.
