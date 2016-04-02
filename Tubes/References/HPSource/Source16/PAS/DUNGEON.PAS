{Dungeon, for Turbo/FreePascal, http://rudih.info
 This game is a text-based RPG which has:
 A random dungeon, hit points, an inventory,
 merchants, enemies, money.}

program Dungeon;

type dunarray = array[1..100] of byte;
var room: dunarray;
    column, row, y, scratch, count, GP, HP, enemyhp: integer;
    user, enemyname: string[20];
    armour, knife: byte; {0=not avail 1=possess}


procedure normal;
begin
 writeln('You are in a dungeon room. HP = ',HP);
 writeln('[Q]uit - [I]nventory - [M]ap - Move [N],[S],[E],[W]?');
 readln(user);
 if (length(user)=1) then user:=upcase(user);
 if user='Q' then halt;
 if user='I' then
  begin
   write('Inventory: GP=',GP);
   if armour=1 then write(' -Armour');
   if knife=1 then write(' -Knife');
   writeln;
  end;
 if user='N' then
  begin
   scratch:=y-10;
   if (row=0) or(room[scratch]=0) or(room[scratch]=2) then
     begin
      writeln('North is blocked.');
     end
    else y:=y-10;
  end;
 if user='S' then
  begin
   scratch:=y+10;
   if (row=9) or(room[scratch]=0) or(room[scratch]=2) then
     begin
      writeln('South is blocked.');
     end
    else y:=y+10;
  end;
 if user='E' then
  begin
   scratch:=y+1;
   if (column=9) or(room[scratch]=0) or(room[scratch]=2) then
     begin
      writeln('East is blocked.');
     end
    else y:=y+1;
  end;
  if user='W' then
  begin
   scratch:=y-1;
   if (column=0) or(room[scratch]=0) or(room[scratch]=2) then
     begin
      writeln('West is blocked.');
     end
    else y:=y-1;
  end;
end; {normal}

procedure shop;
begin
  writeln('There is a prisoner here.');
  writeln('He asks you if you want to buy something [y/n]:');
  readln(user);
  if (length(user)=1) then user:=upcase(user);
  if user='Y' then
   begin
     writeln('Which item:');
     writeln('[1]armour-5GP [2]knife-10GP [3]potion-3GP');
     readln(scratch);
     if (length(user)=1) then user:=upcase(user);
     if (scratch=1) and (gp>4) then
      begin
        Writeln('You buy the armour.');
        GP:=GP-5;
        armour:=1;
       end;
     if (scratch=2) and (gp>9) then
      begin
        writeln('You buy the knife.');
        GP:=GP-10;
        knife:=1;
      end;
     if (scratch=3) and (gp>2) then
      begin
        writeln('You buy the potion & drink it (+6HP).');
        GP:=GP-3;
        HP:=HP+6;
      end;
   end;
  writeln('The prisoner disappears.');
  room[y]:=1;
end; {shop}

procedure makedun;
begin
  {the dungeon is laid out 10x10 so 2 is row 0 column 1
   Key:-
   0=walled out      1=ordinary room
   2=walled out      3=room with 3GP
   4=enemy: snake    5=enemy: guard
   6=enemy: skeleton 7=merchant
   8=beginning       9=end}
  randomize;
  scratch:=0;
  for count:=1 to 100 do {randomly generate dungeon}
   begin
    scratch:=random(8);
    room[count]:=scratch;
   end;
  scratch:=random(100);
  room[scratch]:=8;
  y:=scratch; {mark beginning}
  scratch:=random(100);
  room[scratch]:=9; {mark end}
end; {makedun}

procedure drawmap;
begin
  for count:=1 to 100 do {draw dungeon}
   begin
    if count=y then write('* ') else write('. ');
    if count mod 10=0 then writeln;
   end;
end; {drawmap}

procedure getcoord; {the coords including 0}
begin
 if y<10 then row:=0;
 scratch:=0;
 while scratch<10 do
  begin
   if y>=scratch*10 then row:=scratch;
   scratch:=scratch+1;
  end;
 column:=(y mod 10)-1;
 if column=-1 then column:=9;
end; {getcoord}

procedure combat;
begin
  if room[y]=4 then
   begin
    enemyname:='snake';
    enemyhp:=1;
   end;
  if room[y]=5 then
   begin
    enemyname:='gaurd';
    enemyhp:=2;
   end;
  if room[y]=6 then
   begin
    enemyname:='skeleton';
    enemyhp:=6;
   end;
  writeln('You are attacked by a ',enemyname,' with ',enemyhp,' HP.');
  randomize;
  while enemyhp>0 do
   begin
    scratch:=random(2);
    if scratch=1 then
      begin
       writeln('You attack the ',enemyname,'.');
       scratch:=random(3)+1;
       if knife=1 then scratch:=scratch+3;
       writeln('The ',enemyname,' loses ',scratch,' HP.');
       enemyhp:=enemyhp-scratch;
      end
     else
      begin
       writeln('The ',enemyname,' attacks.');
       scratch:=random(3)+1;
       if (armour=1) and (scratch>1) then scratch:=scratch-2;
       writeln('You lose ',scratch,' HP.');
       hp:=hp-scratch;
       if hp<1 then
        begin
         writeln('You have been killed. Game over. Enter quits.');
         readln(user);
         halt;
        end;
     end;
   end;
  writeln('You killed the ',enemyname,'.');
  writeln('The enemy drops 1 GP - Press enter.');
  readln(user);
  GP:=GP+1;
  room[y]:=1;
end; {combat}


begin
  writeln('---DUNGEON---');
  write('[E]asy or [H]ard game> ');
  readln(user);
  if length(user)=1 then user:=upcase(user);
  if user='E' then HP:=16;
  if user='H' then HP:=12;
  if (user<>'E') and (user<>'H') then halt;
  GP:=0;
  armour:=0;
  knife:=0;
  makedun;
  drawmap;
  while(user<>'Q') do
   begin
    user:='';
    getcoord;
    writeln('column=',column,' row=',row);
    if (room[y]=1) or (room[y]=8) then normal;
    if user='M' then drawmap;
    if room[y]=3 then
     begin
      writeln('You find 2 gold piece on the floor.');
      GP:=GP+2;
      room[y]:=1;
     end;
    if (room[y]=4) or (room[y]=5) or (room[y]=6) then combat;
    if room[y]=7 then shop;
    if room[y]=9 then
     begin
      writeln('You have found the way out! -THE END- enter quits');
      readln(user);
      halt;
     end;
   end;
end. {program}
