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
	lvl1 = 3;	
	lvl2 = 4;
	lvl3 = 5;

type
	size = array[1..nmaks] of String[2];
	size2 = array[1..nmaks] of word;

	sizeint = array[1..9] of integer;

	sze3 = array[1..3,1..3] of String[2];
	sze4 = array[1..4,1..4] of String[2];
	sze5 = array[1..5,1..5] of String[2];

	ceksize3 = array[1..3,1..3] of integer;
	ceksize4 = array[1..4,1..4] of integer;
	ceksize5 = array[1..5,1..5] of integer;

	username = record
		nama : String;
	end;

var
	b, i, j, k, l, m, idx0, baris, kolom, x, y, sama,langkah: Integer;
	a, jam, menit, detik, Milidetik : word;
	pilihMenu, pilihUkuran, press : Char;
	Level1,Level1_2, Level2,Level3 : size;
	checksize3 : ceksize3;
	checksize4 : ceksize4;
	checksize5 : ceksize5;
	size3 : sze3;
	size4 : sze4;
	size5 : sze5;
	dat : array[1..100] of integer;
	dat1,code1 : integer;

	convert : size2;
	usr : username;
	//detik,menit,jam : Integer;
    selesai,menang : boolean;
    baca : string;
    waktuawal,waktuakhir,totalwaktu : Longint;

    myfile : text;
    TS,TS2 : TTimeStamp;

   // f : file of username;
   
{Check Menang Level 1}
function cekMenangLvl1(): Boolean;
var
	i, j, k: Integer;
begin
	k := 0;
	for i := 1 to lvl1 do
	begin
		for j := 1 to lvl1 do
		begin
			k := k + 1;
			cekMenangLvl1 := IntToStr(k) = size3[i][j];
			if (k = 9) then
				break;
		end;

		if (k = 9) then
			break;
	end;

end;
{End Check Menang Level 1}

{Check Menang Level 2}
function cekMenangLvl2(): Boolean;
var 
	i, j, k: integer;
begin
	k := 0;
	for i := 1 to lvl2 do
	begin
		for j := 1 to lvl2 do
		begin
			k := k + 1;
			cekMenangLvl2 := IntToStr(k) = size4[i][j];
			if (k = 16)  then
				break;
		end;

		if (k = 16) then
			break;
	end;
end;
{End Check Menang Level 2}

{Check Menang Level 3}
function cekMenangLvl3(): Boolean;
var 
	i, j, k: integer;
begin
	k := 0;
	for i := 1 to lvl3 do
	begin
		for j := 1 to lvl3 do
		begin
			k := k + 1;
			cekMenangLvl3 := IntToStr(k) = size5[i][j];
			if (k = 25) then
				break;
		end;

		if (k = 25) then
			break;
	end;
end;
{End Check Menang Level 3}

{Keluar}
procedure Keluar();
begin
	writeln;
	writeln('Keluar');
        selesai := TRUE;
	delay(500);
	clrscr;
end;
{End Keluar}

{Search Index 0}
procedure search0(var T : size; n : integer ;var idx : integer );
var 
	ilocal : integer;
begin
	ilocal := 1;
	while (ilocal < n) and (T[ilocal] <> ' ') do
	begin
		ilocal := ilocal + 1;
	end;

	if T[ilocal] = ' ' then
	begin
		idx := ilocal;
	end;
end;
{End Search }

{Folding Pindah Keyboard}
{Pindah Angka Untuk Level 1}
procedure UpArrowLvl1(); 	//Atas
var
	temp: String[2];
begin
	langkah := langkah + 1;
	if baris <> 1 then
	begin
		temp := size3[baris][kolom];
		size3[baris][kolom] := size3[baris-1][kolom];
		size3[baris-1][kolom] := temp;
		baris := baris - 1;
	end;		
end;

procedure DownArrowLvl1();	//Bawah
var
	temp: String[2];	
begin
	langkah := langkah + 1;
	if baris <> 3 then
	begin
		temp := size3[baris][kolom];
		size3[baris][kolom] := size3[baris+1][kolom];
		size3[baris+1][kolom] := temp;
		baris := baris + 1;

	end;
end;

procedure LeftArrowLvl1();	//Kiri
var
	temp: String[2];
begin
	langkah := langkah + 1;
	if kolom <> 1 then
	begin
		temp := size3[baris][kolom];
		size3[baris][kolom] := size3[baris][kolom-1];
		size3[baris][kolom-1] := temp;
		kolom := kolom - 1;
	end;
end;


procedure RightArrowLvl1();	//Kanan
var
	temp: String[2];
begin
	langkah := langkah + 1;
	if kolom <> 3 then
	begin
		temp := size3[baris][kolom];
		size3[baris][kolom] := size3[baris][kolom+1];
		size3[baris][kolom+1] := temp;
		kolom := kolom + 1;
	end;
end;
{End Pindah Angka Lvl 1}

{Pindah Angka Untuk Level 2}
procedure UpArrowLvl2();	//Atas
var
	temp: String[2];
begin
	langkah := langkah + 1;
	if baris <> 1 then
	begin
	temp := size4[baris][kolom];
	size4[baris][kolom] := size4[baris-1][kolom];
	size4[baris-1][kolom] := temp;
	baris := baris - 1;
	end;
end;

procedure DownArrowLvl2();	//Bawah
var
	temp: String[2];
begin
	langkah := langkah + 1;
	if baris <> 4 then
	begin
	temp := size4[baris][kolom];
	size4[baris][kolom] := size4[baris+1][kolom];
	size4[baris+1][kolom] := temp;
	baris := baris + 1;
	end;
end;

procedure LeftArrowLvl2();	//Kiri
var
	temp: String[2];
begin
	langkah := langkah + 1;
	if kolom <> 1 then
	begin
	temp := size4[baris][kolom];
	size4[baris][kolom] := size4[baris][kolom-1];
	size4[baris-1][kolom] := temp;
	kolom := kolom - 1;
	end;
end;

procedure RightArrowLvl2();	//Kanan
var
	temp: String[2];
begin
	langkah := langkah + 1;
	if kolom <> 4 then
	begin
	temp := size4[baris][kolom];
	size4[baris][kolom] := size4[baris][kolom+1];
	size4[baris][kolom+1] := temp;
	kolom := kolom + 1;
	end;
end;
{End Pindah Angka Lvl 2}

{Pindah Angka Untuk Level 3}

procedure UpArrowLvl3();	//Atas
var
	temp: String[2];
begin
	temp := size5[baris][kolom];
	size5[baris][kolom] := size5[baris-1][kolom];
	size5[baris-1][kolom] := temp;
	baris := baris - 1;
end;

procedure DownArrowLvl3();	//Bawah
var
	temp: String[2];
begin
	temp := size5[baris][kolom];
	size5[baris][kolom] := size5[baris+1][kolom];
	size5[baris+1][kolom] := temp;
	baris := baris + 1;
end;

procedure LeftArrowLvl3();	//Kiri
var
	temp: String[2];
begin
	temp := size5[baris][kolom];
	size5[baris][kolom] := size5[baris][kolom-1];
	size5[baris-1][kolom] := temp;
	kolom := kolom - 1;
end;

procedure RightArrowLvl3();	//Kanan
var
	temp: String[2];
begin
	temp := size5[baris][kolom];
	size5[baris][kolom] := size5[baris][kolom+1];
	size5[baris][kolom+1] := temp;
	kolom := kolom + 1;
end;
{End Pindah Keyboard}

{End Pindah Keyboard}

{Procedure Pindah-Pindah Keyboard}
procedure MoveLvl1(ditekan : Char);
begin
	case ditekan of
		#72 : UpArrowLvl1();
		#75 : LeftArrowLvl1();
		#77 : RightArrowLvl1();
		#80 : DownArrowLvl1();
		#8 	: Keluar();
	end;
end;

procedure MoveLvl2(ditekan : Char);
begin
	case ditekan of
		#72 : UpArrowLvl2();
		#75 : LeftArrowLvl2();
		#77 : RightArrowLvl2();
		#80 : DownArrowLvl2();
		#8 	: Keluar(); 
	end;
end;

procedure MoveLvl3(ditekan : Char);
begin
	case ditekan of
		#72 : UpArrowLvl3();
		#75 : LeftArrowLvl3();
		#77 : RightArrowLvl3();
		#80 : DownArrowLvl3();
		#8	: Keluar();
	end;
end;
{End Pindah Keyboard}

{Folding Waktu}
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
{End Waktu}

{Input Nama}
procedure Nama();
begin
	//HEADER
	writeln('=======================');
	writeln('=  Zero Puzzle Games  =');
	writeln('=======================');

	write('Masukkan Nama Users : '); readln(usr.nama);
	delay(100);
	clrscr;
end;
{End Input Nama}
{Cetak Puzzle Lvl 1}
procedure Cetaklvl1();
var
	i, j : Integer;
begin
	clrscr;
	writeln('=======================');
	writeln('=  Zero Puzzle Games  =');
	writeln('=======================');
	for i := 1 to lvl1 do
	begin
		for j := 1 to lvl1 do
		begin
			 write(size3[i][j],'   ');
		end;
		writeln;
		writeln;
	end;
	//langkah := langkah + 1;
	gotoXY(8,10); writeln('Step : ' ,langkah);
end;
{End Cetak Puzzle lvl 1}

{Cetak Puzzle Lvl 2}
procedure Cetaklvl2();
var
	i, j : Integer;
begin
	clrscr;
	writeln('=======================');
	writeln('=  Zero Puzzle Games  =');
	writeln('=======================');
	for i := 1 to lvl2 do
	begin
		for j := 1 to lvl2 do
		begin
			write(size4[i][j], '   ');
		end;
		writeln;
		writeln;
	end;
end;
{End Cetak Puzzle lvl 2}

{Cetak Puzzle Lvl 3}
procedure Cetaklvl3();
var
	i, j : Integer;
begin
	clrscr;
	writeln('=======================');
	writeln('=  Zero Puzzle Games  =');
	writeln('=======================');
	for i := 1 to lvl3 do
	begin
		for j := 1 to lvl3 do
		begin
			 write(size5[i][j], '   ');
		end;
		writeln;
		writeln;
	end;
end;
{End Cetak Puzzle lvl 3}

{Inisialisasi Puzzle lvl1}
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

	{Assign Angka RAndom ke Array 2 Dimensi}
	
	size3[1][1] := Level1[1];
	size3[1][2] := Level1[2];
	size3[1][3] := Level1[3];
	size3[2][1] := Level1[4];
	size3[2][2] := Level1[5];
	size3[2][3] := Level1[6];
	size3[3][1] := Level1[7];
	size3[3][2] := Level1[8];
	size3[3][3] := Level1[9];

	{Cari Indeks ' ' Untuk Baris dan Kolom }
	search0(Level1, 9 ,idx0);

	{Konversi Indeksnya ke Baris dan Kolom}
	case idx0 of
		1: begin
			baris := 1;
			kolom := 1;
		end;
		2: begin
			baris := 1;
			kolom := 2;
		end;
		3: begin
			baris := 1;
			kolom := 3;
		end;
		4: begin
			baris := 2;
			kolom := 1;
		end;
		5: begin
			baris := 2;
			kolom := 2;
		end;
		6: begin
			baris := 2;
			kolom := 3;
		end;
		7: begin
			baris := 3;
			kolom := 1;
		end;
		8: begin
			baris := 3;
			kolom := 2;
		end;
		9: begin
			baris := 3;
			kolom := 3;
		end;
	end;

	{Panggi Perulangan}

	while (not cekMenangLvl1) or selesai = true do
	begin
		Cetaklvl1;
		MoveLvl1(readkey);
	end;
end;
{End Inisialisai Puzzle lvl1}

{Inisialisasi Puzzle Lvl2}
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

	{Assign Angka RAndom ke Array 2 Dimensi}
	size4[1][1] := Level2[1];
	size4[1][2] := Level2[2];
	size4[1][3] := Level2[3];
	size4[1][4] := Level2[4];

	size4[2][1] := Level2[5];
	size4[2][2] := Level2[6];
	size4[2][3] := Level2[7];
	size4[2][4] := Level2[8];

	size4[3][1] := Level2[9];
	size4[3][2] := Level2[10];
	size4[3][3] := Level2[11];
	size4[3][4] := Level2[12];

	size4[4][1] := Level2[13];
	size4[4][2] := Level2[14];
	size4[4][3] := Level2[15];
	size4[4][4] := Level2[16];

	{Cari Indeks ' ' Untuk Baris dan Kolom }
	search0(Level2, 16 ,idx0);

	{Konversi Indeksnya ke Baris dan Kolom}
	case idx0 of
		1: begin
			baris := 1;
			kolom := 1;
		end;
		2: begin
			baris := 1;
			kolom := 2;
		end;
		3: begin
			baris := 1;
			kolom := 3;
		end;
		4: begin
			baris := 1;
			kolom := 4;
		end;
		5: begin
			baris := 2;
			kolom := 1;
		end;
		6: begin
			baris := 2;
			kolom := 2;
		end;
		7: begin
			baris := 2;
			kolom := 3;
		end;
		8: begin
			baris := 2;
			kolom := 4;
		end;
		9: begin
			baris := 3;
			kolom := 1;
		end;
		10: begin
			baris := 3;
			kolom := 2;
		end;
		11: begin
			baris := 3;
			kolom := 3;
		end;
		12: begin
			baris := 3;
			kolom := 4;
		end;
		13: begin
			baris := 4;
			kolom := 1;
		end;
		14: begin
			baris := 4;
			kolom := 2;
		end;
		15: begin
			baris := 4;
			kolom := 3;
		end;
		16: begin
			baris := 4;
			kolom := 4;
		end;
	end;

	{Panggi Perulangan}

	while (not cekMenangLvl2) or selesai = true do
	begin
		Cetaklvl2;
		MoveLvl2(readkey);
	end;


	// writeln('=======================');
	// writeln('=  Zero Puzzle Games  =');
	// writeln('=======================');

	//  GotoXY(5,4); write(Level2[1]);
	//  GotoXY(10,4); write(Level2[2]);
	//  GotoXY(15,4); write(Level2[3]);
	//  GotoXY(20,4); write(Level2[4]);

	//  GotoXY(5,6); write(Level2[5]);
	//  GotoXY(10,6); write(Level2[6]);
	//  GotoXY(15,6); write(Level2[7]);
	//  GotoXY(20,6); write(Level2[8]);

	//  GotoXY(5,8); write(Level2[9]);
	//  GotoXY(10,8); write(Level2[10]);
	//  GotoXY(15,8); write(Level2[11]);
	//  GotoXY(20,8); write(Level2[12]);

	//  GotoXY(5,10); write(Level2[13]);
	//  GotoXY(10,10); write(Level2[14]);
	//  GotoXY(15,10); write(Level2[15]);
	//  GotoXY(20,10); write(Level2[16]);
	
	// writeln;

	// delay(100);
	
	// readln(baca);

	// case baca of
	// 	'nyerah': Keluar();
	// end;
end;
{End Inisialisasi Puzzle Lvl2}

{Inisialisasi Puzzle lvl3}
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
{End Inisialisasi Puzzle lvl3}





procedure Menu();
	//Nested Procedure
	{Proses Puzzle Lvl1}
	

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
	langkah := 0;

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

//cekmenang3();
//cekmenang4();
//cekmenang5();
writeln;

endwaktu();
hitungwaktu();
Writeln(format('Waktu Bermain  %d Jam %d Menit %d Detik %d MiliDetik',[jam,menit,detik,Milidetik]));
readln;
end.
