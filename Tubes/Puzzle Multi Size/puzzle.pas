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

	username = record
		nama : String;
	end;

var
	b,i,j: Integer;
	a : word;
	pilihMenu,pilihUkuran : Char;
	Level1,Level2,Level3 : size;
	convert : size2;
	usr : username;
	detik,menit,jam : Integer;
    selesai,menang : boolean;
    baca : string;

    myfile : text;


   // f : file of username;



procedure Keluar();
begin
	writeln;
	writeln('Keluar');
        selesai := TRUE;
	delay(500);
	clrscr;
end;

procedure waktu(var s,m,h: integer);
var ms : Integer;
begin
	// //mm := 0;
 //       //ss := 0;
 //       for i := 1 to 1000 do
 //       begin
 //       	for j := 1 to 60 do
	//  		begin
	//  		 ss := ss + 1;
 //         	end;
 //          	mm := mm + 1;
 //       end;
	
	//  //mm := mm + 1;
	for i:= 1 to 60 do
	begin
		for j := 1 to 60 do
		begin
		 //
		  	ms := ms + 1;
            if (ms = 9) then
            	begin
            	ms := 0;
                s := s + 1;	
            	end;
                              
                if (s = 59) then
                    s := 0;
                    m := m + 1;
                    
                     if (m = 59) then
                    	begin
                    	m := 0;
                        h := h + 1;	
                    	end;
		end;		 
     end;
                        
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
	writeln('=======================');
	writeln('=  Zero Puzzle Games  =');
	writeln('=======================');

	 GotoXY(4,4); write(Level1[1]);
	 GotoXY(8,4); write(Level1[2]);
	 GotoXY(12,4); write(Level1[3]);
	 GotoXY(4,6); write(Level1[4]);
	 GotoXY(8,6); write(Level1[5]);
	 GotoXY(12,6); write(Level1[6]);
	 GotoXY(4,8); write(Level1[7]);
	 GotoXY(8,8); write(Level1[8]);
	 GotoXY(12,8); write(Level1[9]);
	
	writeln;

	delay(100);
	readln(baca);

	case baca of
		'nyerah': Keluar();
	end;
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
repeat

	Menu();
    waktu(jam,menit,detik);
	writeln('Jam : ', jam);
	writeln('menit : ', menit);
	writeln('Detik : ', detik);
    readln;

    if menang = true then
     begin
     rewrite(myfile);
     writeln(myfile, usr.nama);
     close(myfile);
     end;

until selesai = true;

end.
