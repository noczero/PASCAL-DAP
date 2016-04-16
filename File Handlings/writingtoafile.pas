program DataFiles;

type StudentRecord = record
	s_name : String;
	s_addr : String;
	s_NIM : String;
end;

var
	Student : array [1..10] of StudentRecord;
	f : file of StudentRecord;
	i : Integer;

begin
	Assign(f,'students.txt');
	rewrite(f);

	// student.s_name := 'Satrya Budi ';
	// student.s_addr := 'Asrama Gedung 4';
	// student.s_NIM := '1301154428';
	for i := 1 to 3 do
	begin
	writeln('Mahasiswa ',i);
	write('Masukkan Nama Mahasiswa   :'); readln(student[i].s_name);
	write('Masukkan Alamat Mahasiswa :'); readln(student[i].s_addr);
	write('Masukkan NIM mahasiswa    :'); readln(student[i].s_NIM);
	writeln;
	write(f,student[i]);
	end;
	
	close(f);

end.
