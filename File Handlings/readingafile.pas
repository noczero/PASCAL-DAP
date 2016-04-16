program BacaFIle;

type mahasiswa = record
	Nama : String;
	Alamat : String;
	NIM : String;
	
end;

var
	mhs : mahasiswa;
	f : file of mahasiswa;

begin
	assign(f,'students.txt');
	reset(f);

	while not eof(f) do
	begin
		read(f,mhs);
		writeln('Nama : ', mhs.Nama);
		writeln('Alamat : ', mhs.Alamat);
		writeln('NIM : ', mhs.NIM);
	end;

	close(f);
end.
