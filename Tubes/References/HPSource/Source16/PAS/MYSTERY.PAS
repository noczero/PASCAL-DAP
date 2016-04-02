{ Mystery calculator, for Turbo/FreePascal, http://rudih.info }

{ In this game the computer determines a secret number.
  The idea came from a card trick.}

program mystery;

var
 answer,usercard:integer;
 card:string[20];

procedure card1;
begin
 writeln;
 writeln ('1  3  5  7  9  11 13 15');
 writeln ('17 19 21 23 25 27 29 31');
 writeln ('33 35 37 39 41 43 45 47');
 writeln ('49 51 53 55 57 59 61 63');
 writeln;
end;

procedure card2;
begin
 writeln;
 writeln ('2  3  6  7  10 11 14 15');
 writeln ('18 19 22 23 26 27 30 31');
 writeln ('34 35 38 39 42 43 46 47');
 writeln ('50 51 54 55 58 59 62 63');
 writeln;
end;

procedure card3;
begin
 writeln;
 writeln ('4  5  6  7  12 13 14 15');
 writeln ('20 21 22 23 28 29 30 31');
 writeln ('36 37 38 39 44 45 46 47');
 writeln ('52 53 54 55 60 61 62 63');
 writeln;
end;

procedure card4;
begin
 writeln;
 writeln ('8  9  10 11 12 13 14 15');
 writeln ('24 25 26 27 28 29 30 31');
 writeln ('40 41 42 43 44 45 46 47');
 writeln ('56 57 58 59 60 61 62 63');
 writeln;
end;

procedure card5;
begin
 writeln;
 writeln ('16 17 18 19 20 21 22 23');
 writeln ('24 25 26 27 28 29 30 31');
 writeln ('48 49 50 51 52 53 54 55');
 writeln ('56 57 58 59 60 61 62 63');
 writeln;
end;

procedure card6;
begin
 writeln;
 writeln ('32 33 34 35 36 37 38 39');
 writeln ('40 41 42 43 44 45 46 47');
 writeln ('48 49 50 51 52 53 54 55');
 writeln ('56 57 58 59 60 61 62 63');
 writeln;
end;



begin
 writeln ('---THE MYSTERY CALCULATOR---');
 write ('Choose a card 1 to 6: ');
 readln (usercard);
 if (usercard < 0) OR (usercard > 6) then
  begin
    writeln ('Invalid input.');
    halt;
  end;
 writeln;
 writeln ('Choose any number from this card and remember it:');
 if (usercard = 1) then card1;
 if (usercard = 2) then card2;
 if (usercard = 3) then card3;
 if (usercard = 4) then card4;
 if (usercard = 5) then card5;
 if (usercard = 6) then card6;
 writeln ('Press enter to continue...');
 readln;
 answer := 0;
 card1;
 write ('Does your number appear on this card (Y/N)? ');
 readln (card);
 card := upcase(card);
 if card = 'Y' then answer := answer + 1;
 card2;
 write ('Does your number appear on this card (Y/N)? ');
 readln (card);
 card := upcase(card);
 if card = 'Y' then answer := answer + 2;
 card3;
 write ('Does your number appear on this card (Y/N)? ');
 readln (card);
 card := upcase(card);
 if card = 'Y' then answer := answer + 4;
 card4;
 write ('Does your number appear on this card (Y/N)? ');
 readln (card);
 card := upcase(card);
 if card = 'Y' then answer := answer + 8;
 card5;
 write ('Does your number appear on this card (Y/N)? ');
 readln (card);
 card := upcase(card);
 if card = 'Y' then answer := answer + 16;
 card6;
 write ('Does your number appear on this card (Y/N)? ');
 readln (card);
 card := upcase(card);
 if card = 'Y' then answer := answer + 32;
 writeln ('Your number is: ', answer, '. Press enter to exit.');
 readln;
 halt;
end.
