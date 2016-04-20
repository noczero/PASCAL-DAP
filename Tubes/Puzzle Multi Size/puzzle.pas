{File           : puzzle.pas         }
{Description    : Game Puzzle Multi Size}
{Date           : 2 March 2016       }
{Author         : Satrya Budi Pratama}
{====================================}
{====== Bismillahirahmanirahim ======}
{====================================}
program PuzzleMultiSize;
uses crt,sysutils;
const
	nmaks = 25;
	lvl1 = 9;
	lvl2 = 16;
	lvl3 = 25;

type
	size = array[1..nmaks] of String[2];
	size2 = array[1..nmaks] of word;

	sizeint = array[1..lvl1] of integer;

	sze3 = array[1..3,1..3] of integer;
	sze4 = array[1..4,1..4] of integer;
	sze5 = array[1..5,1..5] of integer;

	ceksize3 = array[1..3,1..3] of integer;
	ceksize4 = array[1..4,1..4] of integer;
	ceksize5 = array[1..5,1..5] of integer;


	username = record
		nama : String;
	end;

var
	b, i, j, k, l, m, idx0, baris, kolom, x, y, sama: Integer;
	a, jam, menit, detik, Milidetik : word;
	pilihMenu, pilihUkuran, press : Char;
	Level1,Level1_2, Level2,Level3 : size;
	checksize3 : ceksize3;
	checksize4 : ceksize4;
	checksize5 : ceksize5;
	size3 : sze3;
	size4 : sze4;
	size5 : sze5;

	convert : size2;
	usr : username;
	//detik,menit,jam : Integer;
    selesai,menang : boolean;
    baca : string;
    waktuawal,waktuakhir,totalwaktu : Longint;

    myfile : text;
    TS,TS2 : TTimeStamp;

   // f : file of username;


procedure cekmenang3();
begin
	m:=0;
	for k:= 1 to 3 do
	begin
		for l:= 1 to 3 do
		begin
			m := m + 1;
			checksize3[k,l] := m-1;
		end;
	end;

	//Misal
	m:=0;
	for k:= 1 to 3 do
	begin
		for l:= 1 to 3 do
		begin
			m := m + 1;
			size3[k,l] := m-1;
		end;
	end;

	for k:= 1 to 3 do
	begin
		for l:= 1 to 3 do
		begin
			write(checksize3[k,l]);
		end;
	end;
	sama := 0;
	for k := 1 to 3 do
	begin
		for l := 1 to 3 do
		begin
			if size3[k,l] = checksize3[k,l] then
				sama := sama + 1;
		end;
	end;
	writeln;
	writeln(sama);
	if sama = 9 then
	menang := true;

end;

procedure cekmenang4();
begin
	m:=0;
	for k:= 1 to 4 do
	begin
		for l:= 1 to 4 do
		begin
			m := m + 1;
			checksize4[k,l] := m-1;
		end;
	end;

	//Misal
	m:=0;
	for k:= 1 to 4 do
	begin
		for l:= 1 to 4 do
		begin
			m := m + 1;
			size4[k,l] := m-1;
		end;
	end;

	for k:= 1 to 4 do
	begin
		for l:= 1 to 4 do
		begin
			write(checksize4[k,l]);
		end;
	end;
	sama := 0;
	for k := 1 to 4 do
	begin
		for l := 1 to 4 do
		begin
			if size4[k,l] = checksize4[k,l] then
				sama := sama + 1;
		end;
	end;
	writeln;
	writeln(sama);
	if sama = 16 then
	menang := true;

end;

procedure cekmenang5();
begin
	m:=0;
	for k:= 1 to 5 do
	begin
		for l:= 1 to 5 do
		begin
			m := m + 1;
			checksize5[k,l] := m-1;
		end;
	end;

	//Misal
	m:=0;
	for k:= 1 to 5 do
	begin
		for l:= 1 to 5 do
		begin
			m := m + 1;
			size5[k,l] := m-1;
		end;
	end;

	for k:= 1 to 5 do
	begin
		for l:= 1 to 5 do
		begin
			write(checksize5[k,l]);
		end;
	end;

	sama := 0;
	for k := 1 to 5 do
	begin
		for l := 1 to 5 do
		begin
			if size4[k,l] = checksize4[k,l] then
				sama := sama + 1;
		end;
	end;
	writeln;
	writeln(sama);
	if sama = 25 then
	menang := true;

end;





procedure Keluar();
begin
	writeln;
	writeln('Keluar');
        selesai := TRUE;
	delay(500);
	clrscr;
end;

procedure search0(var T : size; n : integer);
var ilocal : integer;
begin
	ilocal := 1;
	while (ilocal < n) and (T[ilocal] <> ' ') do
	begin
		ilocal := ilocal + 1;
	end;

	if T[ilocal] = ' ' then
	begin
		idx0 := ilocal;
	end;
end;

procedure UpArrow();
begin

	if (idx0 = 0) or (idx0 = 2) or (idx0 = 3) then
	begin
		write('Tidak Bisa');
	end;

	if idx0 = 4  then
	begin
		GotoXY(x,y); write(Level1[idx0]);
		GotoXY(x,y+2); write(Level1[1]);
	end;

end;

procedure DownArrows();
begin
	
end;

procedure LeftArrow();
begin
	
end;


procedure RightArrow();
begin
	
end;


procedure startwaktu();

begin
   TS:=DateTimeToTimeStamp (Now);
	With TS do
    waktuawal := time ;
end;

procedure endwaktu();
begin
	TS2:=DateTimeToTimeStamp (Now);
	With TS2 do
    waktuakhir := time ;
end;

procedure hitungwaktu();
begin
	totalwaktu := waktuakhir - waktuawal;
	decodeTime(totalwaktu/1000/60/60/24, jam,menit,Detik,Milidetik);
end;

procedure Nama();
begin
	//HEADER
	writeln('=======================');
	writeln('=  Zero Puzzle Games  =');
	writeln('=======================');

	writeln('Masukkan Nama Users : '); readln(usr.nama);
	delay(1000);
	clrscr;
end;

procedure Ukuran_3x3();
begin
	baris := 3;
	kolom := 3;
	clrscr;
	Nama();
	convert[1]:=3;
	convert[2]:=2;
	convert[3]:=8;
	convert[4]:=7;
	convert[5]:=9;
	convert[6]:=6;
	convert[7]:=5;
	convert[8]:=1;
	convert[9]:=4;
	randomize;

	b:= random(9);
	{merandom angka}
			for a:=1 to 9 do
			begin
			convert[a]:=(b+convert[a]) mod 9;
			{memproses satu angka hasil random}
			end;
	randomize;
	b:= random(9);
	{merandom angka}
			for a:=1 to 9 do
			begin
			convert[a]:=(b+convert[a]) mod 9;
			{memproses satu angka hasil random}
			end;

			for b:=1 to 9 do
			begin
			str(convert[b],Level1[b]);
			if (Level1[b]='0') then Level1[b]:=' ';
			{merubah nilai nilai numerik ke string}
			end;

	//HEADER
	x := 4;
	y := 4;

	writeln('=======================');
	writeln('=  Zero Puzzle Games  =');
	writeln('=======================');

	 GotoXY(x,y); write(Level1[1]);
	 GotoXY(x+4,y); write(Level1[2]);
	 GotoXY(x+8,y); write(Level1[3]);
	 GotoXY(x,y+2); write(Level1[4]);
	 GotoXY(x+4,y+2); write(Level1[5]);
	 GotoXY(x+8,y+2); write(Level1[6]);
	 GotoXY(x,y+4); write(Level1[7]);
	 GotoXY(x+4,y+4); write(Level1[8]);
	 GotoXY(x+8,y+4); write(Level1[9]);
	
	writeln;

	search0(Level1, lvl1);
	writeln(idx0);

	//delay(100);

	//Press
	repeat
		
	press := readkey;
	case press of
	#00 :begin
	 case readkey of
		#72 : UpArrow();
		#75 : LeftArrow();
		#77 : RightArrow();
		#80 : DownArrows();
		end;
		end;

		#8 : Keluar();

	end;

	until menang = true ;

	// readln(baca);

	// case baca of
	// 	'nyerah': Keluar();
	// end;

end;

procedure Ukuran_4x4();
begin
	clrscr;
	Nama();
	convert[1]:=3;
	convert[2]:=2;
	convert[3]:=8;
	convert[4]:=7;
	convert[5]:=9;
	convert[6]:=6;
	convert[7]:=5;
	convert[8]:=1;
	convert[9]:=4;
	convert[10]:=11;
	convert[11]:=12;
	convert[12]:=15;
	convert[13]:=13;
	convert[14]:=14;
	convert[15]:=16;
	convert[16]:=10;
	randomize;

	b:= random(16);
	{merandom angka}
			for a:=1 to 16 do
			begin
			convert[a]:=(b+convert[a]) mod 16;
			{memproses satu angka hasil random}
			end;

	randomize;
	b:= random(16);
	{merandom angka}
			for a:=1 to 16 do
			begin
			convert[a]:=(b+convert[a]) mod 16;
			{memproses satu angka hasil random}
			end;

	
			for b:=1 to 16 do
			begin
			str(convert[b],Level2[b]);
			if (Level2[b]='0') then Level2[b]:=' ';
			{merubah nilai nilai numerik ke string}
			end;

	//HEADER

	writeln('=======================');
	writeln('=  Zero Puzzle Games  =');
	writeln('=======================');

	 GotoXY(5,4); write(Level2[1]);
	 GotoXY(10,4); write(Level2[2]);
	 GotoXY(15,4); write(Level2[3]);
	 GotoXY(20,4); write(Level2[4]);

	 GotoXY(5,6); write(Level2[5]);
	 GotoXY(10,6); write(Level2[6]);
	 GotoXY(15,6); write(Level2[7]);
	 GotoXY(20,6); write(Level2[8]);

	 GotoXY(5,8); write(Level2[9]);
	 GotoXY(10,8); write(Level2[10]);
	 GotoXY(15,8); write(Level2[11]);
	 GotoXY(20,8); write(Level2[12]);

	 GotoXY(5,10); write(Level2[13]);
	 GotoXY(10,10); write(Level2[14]);
	 GotoXY(15,10); write(Level2[15]);
	 GotoXY(20,10); write(Level2[16]);
	
	writeln;

	delay(100);
	
	readln(baca);

	case baca of
		'nyerah': Keluar();
	end;
end;

procedure Ukuran_5x5();
begin
	clrscr;
	Nama();
	convert[1]:=3;
	convert[2]:=2;
	convert[3]:=8;
	convert[4]:=7;
	convert[5]:=9;
	convert[6]:=6;
	convert[7]:=5;
	convert[8]:=1;
	convert[9]:=4;
	convert[10]:=11;
	convert[11]:=12;
	convert[12]:=15;
	convert[13]:=13;
	convert[14]:=14;
	convert[15]:=16;
	convert[16]:=10;
	convert[17]:=17;
	convert[18]:=20;
	convert[19]:=18;
	convert[20]:=23;
	convert[21]:=19;
	convert[22]:=21;
	convert[23]:=24;
	convert[24]:=25;
	convert[25]:=22;
	randomize;

	b:= random(25);
	{merandom angka}
			for a:=1 to 25 do
			begin
			convert[a]:=(b+convert[a]) mod 25;
			{memproses satu angka hasil random}
			end;

	randomize;
	b:= random(25);
	{merandom angka}
			for a:=1 to 25 do
			begin
			convert[a]:=(b+convert[a]) mod 25;
			{memproses satu angka hasil random}
			end;

			for b:=1 to 25 do
			begin
			str(convert[b],Level3[b]);
			if (Level3[b]='0') then Level3[b]:=' ';

			{merubah nilai nilai numerik ke string}
			end;

	//HEADER
	writeln('=======================');
	writeln('=  Zero Puzzle Games  =');
	writeln('=======================');

	 GotoXY(5,4); write(Level3[1]);
	 GotoXY(10,4); write(Level3[2]);
	 GotoXY(15,4); write(Level3[3]);
	 GotoXY(20,4); write(Level3[4]);
	 GotoXY(25,4); write(Level3[5]);

	 GotoXY(5,6); write(Level3[6]);
	 GotoXY(10,6); write(Level3[7]);
	 GotoXY(15,6); write(Level3[8]);
	 GotoXY(20,6); write(Level3[9]);
	 GotoXY(25,6); write(Level3[10]);

	 GotoXY(5,8); write(Level3[11]);
	 GotoXY(10,8); write(Level3[12]);
	 GotoXY(15,8); write(Level3[13]);
	 GotoXY(20,8); write(Level3[14]);
	 GotoXY(25,8); write(Level3[15]);

	 GotoXY(5,10); write(Level3[16]);
	 GotoXY(10,10); write(Level3[17]);
	 GotoXY(15,10); write(Level3[18]);
	 GotoXY(20,10); write(Level3[19]);
	 GotoXY(25,10); write(Level3[20]);

	 GotoXY(5,12); write(Level3[21]);
	 GotoXY(10,12); write(Level3[22]);
	 GotoXY(15,12); write(Level3[23]);
	 GotoXY(20,12); write(Level3[24]);
	 GotoXY(25,12); write(Level3[25]);

	writeln;

	delay(100);
	
	readln(baca);

	case baca of
		'nyerah': Keluar();
	end;

end;

procedure Menu();
	//Nested Procedure
	procedure Peraturan();
	begin
		clrscr;

		writeln('=======================');
		writeln('=  Zero Puzzle Games  =');
		writeln('=======================');
		writeln('= Peraturen Permainan =');
		writeln('=======================');
		writeln;
		writeln('1. Susun angka sesuai  ');
		writeln('   urutan terkecil ke  ');
		writeln('   terbesar. Contohnya ');
		writeln('   1-2-3-4-5-6-7-8-9-10');
		writeln;
		writeln('2. Tekan Keyboard untuk');
		writeln('   Memindahkan angka   ');
		writeln;
		writeln(' Press any key ...');
		readln;
		Menu();

	end;
	procedure Mulai();
	begin
		clrscr;
		writeln('=======================');
		writeln('=  Zero Puzzle Games  =');
		writeln('=======================');
		writeln('= Pilih Ukuran Puzzle =');
		writeln('=======================');
		writeln('==== 1. 3 x 3      ====');
		writeln('==== 2. 4 x 4      ====');
		writeln('==== 3. 5 x 5      ====');
		writeln('==== 4. Menu Utama ====');
		writeln('==== 5. Keluar     ====');
		writeln('=======================');
		write('Pilih menu : ');
		readln(pilihUkuran);


		case pilihUkuran of
			'1' : Ukuran_3x3();
			'2'	: Ukuran_4x4();
			'3' : Ukuran_5x5();
			'4' : Menu();
			'5' : Keluar();
			else
				begin
				writeln('Pilihan Tidak Sesuai');
				delay(1000);
				Mulai();
				end;
		end;

	end;
begin

	clrscr;
	writeln('=======================');
	writeln('=  Zero Puzzle Games  =');
	writeln('=======================');
	writeln('= Tekan 1 untuk Mulai =');
	writeln('=======================');
	writeln('==== 1. Mulai      ====');
	writeln('==== 2. Peraturan  ====');
	writeln('==== 3. Keluar     ====');
	writeln('=======================');
	write('Pilih menu : ');
	readln(pilihMenu);

	case pilihMenu of
		'1': Mulai();
		'2': Peraturan();
		'3': Keluar();
		else
			begin
			writeln('Pilihan Tidak Sesuai');
			delay(1000);
			Menu();
			end;
	end;

end;

begin
    selesai := false;
    menang := false;
    menit := 0;
    detik := 0;
    jam := 0;
	assign(myfile,'history.txt');

	startwaktu();
repeat

	Menu();
   // waktu(jam,menit,detik);
	

    if menang = true then
     begin
     rewrite(myfile);
     writeln(myfile, usr.nama);
     close(myfile);
     end;

until selesai = true;
cekmenang3();
cekmenang4();
cekmenang5();
writeln;

endwaktu();
hitungwaktu();
Writeln(format('Waktu Bermain  %d Jam %d Menit %d.%d Detik',[jam,menit,detik,Milidetik]));
readln;
end.
