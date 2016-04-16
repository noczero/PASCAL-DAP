program puzzle;
uses crt,dos;

type masuk=record

nama:string[12];

end;

{deklarasi variabel global}

var

z:masuk;

input,tanya,tanya2:char;

temp:string[1];

x:array[1..9] of string[1];

y:array[1..9] of word;

b,j2,m2,n2,temp2,maks1,langkah,temp1:integer;

a,h,j,m,n,d,j1,m1,n1,d1:word;

mriksa:boolean;

best:text;

temp3,maks2:string[12];

namaplayer:array[1..10] of string[12];

moves:array [1..10] of integer;

times:array [1..10] of integer;


procedure waktu;
	begin

j2:=j1-j;
m2:=m1-m;
n2:=n1-n;;

if (n2<0) and (m2<0)then

begin 
	n2:=(60+n1)-n; 
	m2:=(60+m1)-m; 
	j2:=j2-1; 
	end

else

if (n2<0) then

begin 
	n2:=(60+n1)-n; 
	m2:=m2-1; 
end;

writeln(j2,':',m2,':',n2);

end;


procedure acak1;

begin

	clrscr;

	y[1]:=3;y[2]:=2;y[3]:=8;y[4]:=7;y[5]:=9;y[6]:=6;y[7]:=5;y[8]:=1;y[9]:=4;

	randomize;

	b:= random(9);

	{merandom angka}

		begin

			for a:=1 to 9 do

			begin

			y[a]:=(b+y[a]) mod 9;

			{memproses satu angka hasil random}

			end;

		end;

end;

{Merandom ankga yang dihasilkan oleh Pocedure acak1}

procedure acak2;

begin

	randomize;

	b:= random(9);

	{merandom angka}

	begin

	for a:=1 to 9 do

		begin

		y[a]:=(b+y[a]) mod 9;

		{memproses satu angka hasil random}

		end;

	end;

for b:=1 to 9 do

	begin

	str(y[b],x[b]);
	if (x[b]='0') then x[b]:=' ';

	{merubah nilai nilai numerik ke string}

	end;

end;

procedure puzzle;

begin

	for a:=1 to 45 do

		begin

		gotoxy(1,a);writeln('%%%');

		gotoxy(70,a);writeln('%%%');

		end;

	for a:=1 to 70 do

		begin

		gotoxy(a,1);writeln('%'); gotoxy(a,2);writeln('%');

		gotoxy(a,3);writeln('%'); gotoxy(a,43);writeln('%');

		gotoxy(a,44);writeln('%');gotoxy(a,45);writeln('%');

		end;

	for a:=1 to 13 do

	begin

	gotoxy(a+30,11);writeln('*');

	gotoxy(a+30,23);writeln('*');

	gotoxy(43,a+10);writeln('*');

	gotoxy(31,a+10);writeln('*');

	gotoxy(a+30,15);writeln('*');

	gotoxy(a+30,19);writeln('*');

	gotoxy(39,a+10);writeln('*');

	gotoxy(35,a+10);writeln('*');

	end;

	gotoxy(20,15);writeln('Up = ',#24);{Tanda panah ke atas}

	gotoxy(20,16);writeln('Left = ',#27);{Tanda panah ke kiri}

	gotoxy(20,17);writeln('Down = ',#25);{Tanda panah ke bawah}

	gotoxy(20,18);Writeln('Right = ',#26);{tanda panah ke kanan}

	gotoxy(20,19);writeln('Stop =End');

	begin

	gotoxy(33,13);writeln(x[1]);

	gotoxy(33,17);writeln(x[2]);

	gotoxy(33,21);writeln(x[3]);

	gotoxy(37,13);writeln(x[4]);

	gotoxy(37,17);writeln(x[5]);

	gotoxy(37,21);writeln(x[6]);

	gotoxy(41,13);writeln(x[7]);

	gotoxy(41,17);writeln(x[8]);

	gotoxy(41,21);writeln(x[9]);

	end;

end;

procedure login;

	begin

	gotoxy(33,25);write('Input Nama:');readln(z.nama);

	end;


begin
	login;
	acak1;
	acak2;
	puzzle;
	readln;
end.
