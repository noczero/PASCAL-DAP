{File        : 03_mahasiswa.pas}
{Description : contoh penggunaan array untuk input data dan output data mahasiswa}
{Date        : 26 Maret '16}

program datamahasiswa;

type
	mahasiswa = record
	nama 	: String;
	nim 	: String;
	alamat 	: String;
	notlp	: String;
end;

var
	data : array[1..10] of mahasiswa;
	i : Integer;

procedure inputdata();
begin
	for i := 1 to 10 do
	begin
		writeln;
		writeln('Mahasiswa ', i);
		writeln('==================================');
		write('Masukkan Nama Mahasiswa : ')			;readln(data[i].nama);
		write('Masukkan NIM Mahasiswa 	: ')		;readln(data[i].nim);
		write('Masukkan Alamat Mahasiswa : ')		;readln(data[i].alamat);
		write('Masukkan Nomor Telepon Mahasiswa : ');readln(data[i].notlp);
		writeln('==================================');
	end;
end;

procedure showdata();
begin
	for i := 1 to 10 do
	begin
		writeln;
		writeln('Mahasiswa ', i);
		writeln('=================================');
		writeln('Nama Mahasiswa :', data[i].nama);
		writeln('NIM Mahasiswa :', data[i].nim);
		writeln('Alamat Mahasiswa :', data[i].alamat);
		writeln('Nomor Telepon Mahasiswa :', data[i].notlp);
		writeln('=================================');
	end;
end;

begin
	inputdata();
	showdata();
	readln;
end.
