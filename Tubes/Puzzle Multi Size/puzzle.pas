{File 			: puzzle.pas}
{Description 	: Game Puzzle Multi Size}
{Date 			: 2 March 2016}
{Author			: Satrya Budi Pratama}
{====================================}
{====== Bismillahirahmanirahim ======}
{====================================}

program PuzzleMultiSize;
uses crt;

var
	variableName: Integer;
	pilihMenu,pilihUkuran : Char;


procedure Menu();

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

	// case pilihMenu of
	// 	'1': Mulai;
	// 	'2': Peraturan
	// 	else
	// 		Keluar();
	// end;

end;

procedure Mulai();
begin
	clrscr;
	writeln('=======================');
	writeln('=  Zero Puzzle Games  =');
	writeln('=======================');
	writeln('= Pilih Ukuran Puzzle =');
	writeln('=======================');
	writeln('==== 1. 4 x 4      ====');
	writeln('==== 2. 5 x 5      ====');
	writeln('==== 3. 6 x 6      ====');
	writeln('==== 4. Menu Utama ====');
	writeln('==== 5. Keluar     ====');
	writeln('=======================');
	write('Pilih menu : ');
	readln(pilihUkuran);


	// case pilihUkuran of
	// 	'1' : Ukuran_4x4();
	// 	'2'	: Ukuran_5x5();
	// 	'3' : Ukuran_6x6()
	// 	else
	// 		writeln('Pilihan Tidak Sesuai');
	// end;

end;

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
	readln;
	Menu();

end;

// function pilihanMenu(pilihnya : char): Boolean;
// begin
// 	case pilihnya of
// 		'1': pilihanMenu := True;
// 		'2'
// 		else 
// 			statement;
// 	end;
// end;

// function pilihanUkuran(pilihnya : char): Boolean;
// begin
	
// end;

procedure Keluar();
begin
	writeln('Keluar');	
end;

procedure Ukuran_4x4();
begin
	clrscr;
	writeln('4x4');	
	writeln;

	GotoXY(4,2); write(' ');
	GotoXY(8,2); write('1');
	GotoXY(12,2); write('2');
	GotoXY(16,2); write('3');
	GotoXY(4,4); write('4');
	GotoXY(8,4); write('5');
	GotoXY(12,4); write('6');
	GotoXY(16,4); write('7');
	GotoXY(4,6); write('8');
	GotoXY(8,6); write('9');
	GotoXY(12,6); write('10');
	GotoXY(16,6); write('11');
	GotoXY(4,8); write('12');
	GotoXY(8,8); write('13');	 
	GotoXY(12,8); write('14');
	GotoXY(16,8); write('15');
	writeln;
	delay(100);
	readln;
end;

procedure Ukuran_5x5();
begin
	clrscr;
	writeln('5x5');
end;

procedure Ukuran_6x6();
begin
	clrscr;
	writeln('6x6');
end;


begin
	
	Menu();

	case pilihMenu of
		'1': Mulai();
		'2': Peraturan();
		'3': Keluar();
	end;


	case pilihUkuran of
		'1' : Ukuran_4x4();
		'2'	: Ukuran_5x5();
		'3' : Ukuran_6x6();
		'4' : Menu();
		'5' : Keluar();
		// else
		// 	begin
		// 	writeln('Pilihan Tidak Sesuai');
		// 	delay(300);	
		// 	Mulai();
		// 	end;
			
	end;

end.
