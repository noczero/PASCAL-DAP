{File           : puzzle.pas         	}
{Description    : Game Puzzle Multi Size}
{Date           : 2 March 2016       	}
{Author         : Satrya Budi Pratama	}
{  ====================================	}
{  ====== Bismillahirahmanirahim ======	}
{  ====================================	}

program PuzzleMultiSize;	//Program Name
uses crt,sysutils;			//Unit Pascal

{Static Value}
const
	nmaks = 25;
	lvl1 = 3;	
	lvl2 = 4;
	lvl3 = 5;
{End Static Value}

{Type Bentukan}
type
	size = array[1..nmaks] of String[2];
	size2 = array[1..nmaks] of word;
	sze3 = array[1..lvl1,1..lvl1] of String[2];
	sze4 = array[1..lvl2,1..lvl2] of String[2];
	sze5 = array[1..lvl3,1..lvl3] of String[2];

	username = record
		nama : String;
	end;
{End Type Bentukan}

{Kamus Global}
var
	b, idx0, baris, kolom, langkah	: Integer;
	a, jam, menit, detik, Milidetik : word;
	pilihMenu, pilihUkuran			: Char;
	Level1,Level2,Level3 			: size;
	size3 							: sze3;
	size4 							: sze4;
	size5 							: sze5;
	convert 						: size2;
	usr 							: username;
    selesai,menang 					: boolean;
    waktuawal,waktuakhir,totalwaktu : Longint;
    myfile 							: text;
    TS,TS2 							: TTimeStamp;
{End Kamus GLobal}

{Check Menang Level 1}
function cekMenangLvl1: Boolean;
var
	i, j, k: Integer;
begin
	k := 1;
	cekMenangLvl1 := false;
	for i := 1 to lvl1 do
	begin
		for j := 1 to lvl1 do
		begin
			cekMenangLvl1 := IntToStr(k) = size3[i][j];
			k := k + 1;
			if (k = 9) or (not cekMenangLvl1) then
				begin
				menang := true;
				break;
				end;
		end;

		if (k = 9) or (not cekMenangLvl1) then
		begin
			menang := true;
			break;
		end;
	end;

end;
{End Check Menang Level 1}

{Check Menang Level 2}
function cekMenangLvl2: Boolean;
var
	i, j, k: integer;
begin
	k := 1;
	cekMenangLvl2 := false;
	for i := 1 to lvl2 do
	begin
		for j := 1 to lvl2 do
		begin
			cekMenangLvl2 := IntToStr(k) = size4[i][j];
			k := k + 1;
			if (k = 16)  then
				begin
				menang := true;
				break;
				end;
		end;

		if (k = 16) then
		begin
			menang := true;
			break;
		end;
	end;
end;
{End Check Menang Level 2}

{Check Menang Level 3}
function cekMenangLvl3: Boolean;
var
	i, j, k: integer;
begin
	k := 1;
	cekMenangLvl3 := false;
	for i := 1 to lvl3 do
	begin
		for j := 1 to lvl3 do
		begin
			cekMenangLvl3 := IntToStr(k) = size5[i][j];
			k := k + 1;
			if (k = 25) then
				begin
				menang := true;
				break;
				end;
				
		end;
		if (k = 25) then
			begin
				menang := True;
				break;
			end;
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

{Cetak Header Menang ke Layar}
procedure CetakMenang();
begin
	clrscr;
	writeln('[[[[[=======================]]]]]');
	writeln('-0-0-=  Zero Puzzle Games  =-0-0-');
	writeln('[[[[[=======================]]]]]');
	writeln;
	writeln('[[[[[=======================]]]]]');
	writeln('-0-0-=  Selamat Anda Menang =-0-0-');
	writeln('[[[[[=======================]]]]]');
	writeln;
	writeln('[[[[[=======================]]]]]');
	writeln('-0-0-=                     =-0-0-');
	writeln('[[[[[=======================]]]]]');
	writeln;
	gotoXY(15,10); write(langkah, ' Step');
	readln;
end;
{End Cetak Header Menang ke Layar}

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

{Time Stamp Waktu}
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

{Player Nyerah}
procedure Nyerah();
begin
	//goto kembaliexit;
	clrscr;
	endwaktu();
	hitungwaktu();
	//HEADER
	writeln('`````````[[[[[=======================]]]]]```````');
	writeln('-0-0-0-0-0-0-=  Zero Puzzle Games  =-0-0-0-0-0-0-');
	writeln('_________[[[[[=======================]]]]]_______');
	writeln;
	writeln('Kamu Nyerah :( , Coba lagi ya .. ');
	writeln(format('Waktu Bermain : %d Jam %d Menit %d Detik %d MiliDetik',[jam,menit,detik,Milidetik]));
	readln;
	halt;
end;
{End Player Nyerah}

procedure Menu();
	//Nested Procedure
	{Proses Puzzle Lvl1}
	{Folding Pindah Keyboard}
	{Pindah Angka Untuk Level 1}
	procedure UpArrowLvl1(); 	//Atas
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

	procedure DownArrowLvl1();	//Bawah
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

	procedure LeftArrowLvl1();	//Kiri
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

	procedure RightArrowLvl1();	//Kanan
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
	{End Pindah Angka Lvl 1}

	
	{Pindah Angka Untuk Level 2}
	procedure UpArrowLvl2();	//Atas
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

	procedure DownArrowLvl2();	//Bawah
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

	procedure LeftArrowLvl2();	//Kiri
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

	procedure RightArrowLvl2();	//Kanan
	var
		temp: String[2];
	begin
		langkah := langkah + 1;
		if kolom <> 1 then
		begin
		temp := size4[baris][kolom];
		size4[baris][kolom] := size4[baris][kolom-1];
		size4[baris][kolom-1] := temp;
		kolom := kolom - 1;
		end;
	end;
	{End Pindah Angka Lvl 2}


	{Pindah Angka Untuk Level 3}
	procedure UpArrowLvl3();	//Atas
	var
		temp: String[2];
	begin
		langkah := langkah + 1;
		if baris <> 5 then
		begin
		temp := size5[baris][kolom];
		size5[baris][kolom] := size5[baris+1][kolom];
		size5[baris+1][kolom] := temp;
		baris := baris + 1;
		end;
	end;

	procedure DownArrowLvl3();	//Bawah
	var
		temp: String[2];
	begin
		langkah := langkah + 1;
		if baris <> 1 then
		begin
		temp := size5[baris][kolom];
		size5[baris][kolom] := size5[baris-1][kolom];
		size5[baris-1][kolom] := temp;
		baris := baris - 1;
		end;
	end;

	procedure LeftArrowLvl3();	//Kiri
	var
		temp: String[2];
	begin
		langkah := langkah + 1;
		if kolom <> 5 then
		begin
		temp := size5[baris][kolom];
		size5[baris][kolom] := size5[baris][kolom+1];
		size5[baris][kolom+1] := temp;
		kolom := kolom + 1;
		end;
	end;

	procedure RightArrowLvl3();	//Kanan
	var
		temp: String[2];
	begin
		langkah := langkah + 1;
		if kolom <> 1 then
		begin
		temp := size5[baris][kolom];
		size5[baris][kolom] := size5[baris][kolom-1];
		size5[baris][kolom-1] := temp;
		kolom := kolom - 1;
		end;
	end;
	{End Pindah Keyboard}

	{Procedure Pindah-Pindah Keyboard}
	procedure MoveLvl1(ditekan : Char);
	begin
		case ditekan of
			#72 : UpArrowLvl1();
			#75 : LeftArrowLvl1();
			#77 : RightArrowLvl1();
			#80 : DownArrowLvl1();
			#8 	: Nyerah();
		end;
	end;

	procedure MoveLvl2(ditekan : Char);
	begin
		case ditekan of
			#72 : UpArrowLvl2();
			#75 : LeftArrowLvl2();
			#77 : RightArrowLvl2();
			#80 : DownArrowLvl2();
			#8 	: Nyerah();
		end;
	end;

	procedure MoveLvl3(ditekan : Char);
	begin
		case ditekan of
			#72 : UpArrowLvl3();
			#75 : LeftArrowLvl3();
			#77 : RightArrowLvl3();
			#80 : DownArrowLvl3();
			#8	: Nyerah();
		end;
	end;
	{End Pindah Keyboard}

	{Input Nama}
	procedure Nama();
	begin
		//HEADER
		writeln('[[[[[=======================]]]]]');
		writeln('-0-0-=  Zero Puzzle Games  =-0-0-');
		writeln('[[[[[=======================]]]]]');
		writeln;
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
		//header
		writeln('[[[[[=======================]]]]]');
		writeln('-0-0-=  Zero Puzzle Games  =-0-0-');
		writeln('[[[[[=======================]]]]]');
		writeln;
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
		writeln('[[[[[=======================]]]]]');
		gotoXY(24,12); writeln('Step : ' ,langkah);
		gotoXY(1,12); writeln('Player : ' ,usr.nama);
		writeln('[[[[[=======================]]]]]');
	end;
	{End Cetak Puzzle lvl 1}

	{Cetak Puzzle Lvl 2}
	procedure Cetaklvl2();
	var
		i, j : Integer;
	begin
		clrscr;
		writeln('[[[[[[[=======================]]]]]]]');
		writeln('-0-0-0-=  Zero Puzzle Games  =-0-0-0-');
		writeln('[[[[[[[=======================]]]]]]]');
		writeln;
		for i := 1 to lvl2 do
		begin
			for j := 1 to lvl2 do
			begin
				write(size4[i][j], '    ');
			end;
			writeln;
			writeln;
			writeln;
		end;
		//writeln;
		writeln('[[[[[[[=======================]]]]]]]');
		gotoXY(24,18); writeln('Step : ' ,langkah);
		gotoXY(5,18); writeln('Player : ' ,usr.nama);
		writeln('[[[[[[[=======================]]]]]]]');
	end;
	{End Cetak Puzzle lvl 2}

	{Cetak Puzzle Lvl 3}
	procedure Cetaklvl3();
	var
		i, j : Integer;
	begin
		clrscr;
		writeln('[[[[[[[[[[[[[[[=======================]]]]]]]]]]]]]]]');
		writeln('0-0-0-0-0-0-0-0-=  Zero Puzzle Games  =-0-0-0-0-0-0-0');
		writeln('[[[[[[[[[[[[[[[=======================]]]]]]]]]]]]]]]');
		writeln;
		for i := 1 to lvl3 do
		begin
			for j := 1 to lvl3 do
			begin
				 write(size5[i][j], '        ');
			end;
			writeln;
			writeln;
			writeln;
		end;
		writeln('[[[[[[[[[[[[[[[=======================]]]]]]]]]]]]]]]');
		gotoXY(34,21); writeln('Step : ' ,langkah);
		gotoXY(13,21); writeln('Player : ' ,usr.nama);
		writeln('[[[[[[[[[[[[[[[=======================]]]]]]]]]]]]]]]');
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

		{Check Kondisi Menang lvl1}
		// size3[1][1] := '1';
		// size3[1][2] := '2';
		// size3[1][3] := '3';
		// size3[2][1] := '4';
		// size3[2][2] := '5';
		// size3[2][3] := '6';
		// size3[3][1] := '7';
		// size3[3][2] := ' ';
		// size3[3][3] := '8';

		{Cari Indeks ' ' Untuk Baris dan Kolom }
		search0(Level1, 9 ,idx0);
		
		//idx0 := 8; //Check Menang
		
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

		{Panggil Perulangan}

		while (not cekMenangLvl1) or (menang = false)  do
		begin
			Cetaklvl1;
			MoveLvl1(readkey);
		//	writeln(baris, ' ',kolom);
		end;
		{ cek Menang Lvl1 = True }
		CetakMenang();
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

		{Check Menang lvl 2}
		// size4[1][1] := '1';
		// size4[1][2] := '2';
		// size4[1][3] := '3';
		// size4[1][4] := '4';

		// size4[2][1] := '5';
		// size4[2][2] := '6';
		// size4[2][3] := '7';
		// size4[2][4] := '8';

		// size4[3][1] := '9';
		// size4[3][2] := '10';
		// size4[3][3] := '11';
		// size4[3][4] := '12';

		// size4[4][1] := '13';
		// size4[4][2] := '14';
		// size4[4][3] := ' ';
		// size4[4][4] := '15';

		{End Check Menang}

		{Cari Indeks ' ' Untuk Baris dan Kolom }
		search0(Level2, 16 ,idx0);

		//idx0 := 15; //Check menang
		
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

		while (not cekMenangLvl2) or (menang = false) do
		begin
			Cetaklvl2;
			MoveLvl2(readkey);
		end;
		{ cek Menang Lvl2 = True }
		CetakMenang();
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

		{Assign Angka RAndom ke Array 2 Dimensi}
		size5[1][1] := Level3[1];
		size5[1][2] := Level3[2];
		size5[1][3] := Level3[3];
		size5[1][4] := Level3[4];
		size5[1][5] := Level3[5];

		size5[2][1] := Level3[6];
		size5[2][2] := Level3[7];
		size5[2][3] := Level3[8];
		size5[2][4] := Level3[9];
		size5[2][5] := Level3[10];

		size5[3][1] := Level3[11];
		size5[3][2] := Level3[12];
		size5[3][3] := Level3[13];
		size5[3][4] := Level3[14];
		size5[3][5] := Level3[15];

		size5[4][1] := Level3[16];
		size5[4][2] := Level3[17];
		size5[4][3] := Level3[18];
		size5[4][4] := Level3[19];
		size5[4][5] := Level3[20];

		size5[5][1] := Level3[21];
		size5[5][2] := Level3[22];
		size5[5][3] := Level3[23];
		size5[5][4] := Level3[24];
		size5[5][5] := Level3[25];

		{Check Menang}
		// size5[1][1] := '1';
		// size5[1][2] := '2';
		// size5[1][3] := '3';
		// size5[1][4] := '4';
		// size5[1][5] := '5';

		// size5[2][1] := '6';
		// size5[2][2] := '7';
		// size5[2][3] := '8';
		// size5[2][4] := '9';
		// size5[2][5] := '10';

		// size5[3][1] := '11';
		// size5[3][2] := '12';
		// size5[3][3] := '13';
		// size5[3][4] := '14';
		// size5[3][5] := '15';

		// size5[4][1] := '16';
		// size5[4][2] := '17';
		// size5[4][3] := '18';
		// size5[4][4] := '19';
		// size5[4][5] := '20';

		// size5[5][1] := '21';
		// size5[5][2] := '22';
		// size5[5][3] := '23';
		// size5[5][4] := ' ';
		// size5[5][5] := '24';
		{End Check Menang}
		{Cari Indeks ' ' Untuk Baris dan Kolom }
		search0(Level3, 25 ,idx0);
		//idx0 := 24;
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
				baris := 1;
				kolom := 5;
			end;

			6: begin
				baris := 2;
				kolom := 1;
			end;
			7: begin
				baris := 2;
				kolom := 2;
			end;
			8: begin
				baris := 2;
				kolom := 3;
			end;
			9: begin
				baris := 2;
				kolom := 4;
			end;
			10: begin
				baris := 2;
				kolom := 5;
			end;

			11: begin
				baris := 3;
				kolom := 1;
			end;
			12: begin
				baris := 3;
				kolom := 2;
			end;
			13: begin
				baris := 3;
				kolom := 3;
			end;
			14: begin
				baris := 3;
				kolom := 4;
			end;
			15: begin
				baris := 3;
				kolom := 5;
			end;

			16: begin
				baris := 4;
				kolom := 1;
			end;
			17: begin
				baris := 4;
				kolom := 2;
			end;
			18: begin
				baris := 4;
				kolom := 3;
			end;
			19: begin
				baris := 4;
				kolom := 4;
			end;
			20: begin
				baris := 4;
				kolom := 5;
			end;

			21: begin
				baris := 5;
				kolom := 1;
			end;
			22: begin
				baris := 5;
				kolom := 2;
			end;
			23: begin
				baris := 5;
				kolom := 3;
			end;
			24: begin
				baris := 5;
				kolom := 4;
			end;
			25: begin
				baris := 5;
				kolom := 5;
			end;
		end;

		{Panggi Perulangan}

		while (not cekMenangLvl3) or (menang = false) do
		begin
			Cetaklvl3;
			MoveLvl3(readkey);
		end;
		{ cek Menang Lvl1 = True }
		CetakMenang();

	end;
	{End Inisialisasi Puzzle lvl3}

	{Proedure Tampil Peraturan}
	procedure Peraturan();
	begin
		clrscr;
		//header
		writeln('[[[[[=======================]]]]]');
		writeln('-0-0-=  Zero Puzzle Games  =-0-0-');
		writeln('[[[[[=======================]]]]]');
		writeln('-0-0-= Peraturen Permainan =-0-0-');
		writeln('[[[[[=======================]]]]]');
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
	{End Procedure Peraturan}

	{Procedure Mulai}
	procedure Mulai();
	begin
		clrscr;
		writeln('[[[[[=======================]]]]]');
		writeln('-0-0-=  Zero Puzzle Games  =-0-0-');
		writeln('[[[[[=======================]]]]]');
		writeln('-0-0-=  Pilih Level Games  =-0-0-');
		writeln('[[[[[=======================]]]]]');;
		writeln('[[[[[==== 1. 3 x 3      ====]]]]]');
		writeln('[[[[[==== 2. 4 x 4      ====]]]]]');
		writeln('[[[[[==== 3. 5 x 5      ====]]]]]');
		writeln('[[[[[==== 4. Menu Utama ====]]]]]');
		writeln('[[[[[==== 5. Keluar     ====]]]]]');
		writeln('[[[[[=======================]]]]]');
		writeln;
		writeln('    -0-0-= Pilih menu -0-0-=     ');
		gotoXY(17,14); readln(pilihUkuran);
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
	{End Procedure Mulai}

{Main Procedure}
begin
	clrscr;
	writeln('[[[[[=======================]]]]]');
	writeln('-0-0-=  Zero Puzzle Games  =-0-0-');
	writeln('[[[[[=======================]]]]]');
	writeln('-0-0-=   Selamat Bermain   =-0-0-');
	writeln('[[[[[=======================]]]]]');
	writeln('[[[[[==== 1. Mulai      ====]]]]]');
	writeln('[[[[[==== 2. Peraturan  ====]]]]]');
	writeln('[[[[[==== 3. Keluar     ====]]]]]');
	writeln('[[[[[=======================]]]]]');
	writeln;
	writeln('    -0-0-= Pilih menu -0-0-=     ');
	gotoXY(17,12); readln(pilihMenu);
	
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

{Main Program}
begin
    selesai := false;
    menang := false;
    menit := 0;
    detik := 0;
    jam := 0;
	assign(myfile,'history.txt');
	startwaktu();
	TextBackground(cyan);
	TextColor(white);

repeat
	langkah := 0;
	Menu();
	
    if menang = true then
     begin
     rewrite(myfile);
     write(myfile, 'Pemenang : ');
     writeln(myfile, usr.nama);
     close(myfile);
     end;

until selesai = true;

//HEADER
writeln('`````````[[[[[=======================]]]]]```````');
writeln('-0-0-0-0-0-0-=  Zero Puzzle Games  =-0-0-0-0-0-0-');
writeln('_________[[[[[=======================]]]]]_______');
writeln;
endwaktu();
hitungwaktu();
writeln(format('Waktu Bermain : %d Jam %d Menit %d Detik %d MiliDetik',[jam,menit,detik,Milidetik]));
writeln('-------------------------------------------------');
writeln('Terima Kasih sudah Bermain, Jangan Lupa Waktu ya ');
writeln('-------------------------------------------------');
writeln('   Created by Satrya Budi Pratama, Salam Hangat  ');
writeln('  . .| Zero Puzzle * 2016 | Made with Love | . . ');
writeln('-------------------------------------------------');
readln;
end.
{End Program}
{Alhamdulillah}