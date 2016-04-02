{Word scramble, for Free Pascal, http://rudih.info}

program Scamble;

type yarray=array[1..30] of integer;
     warray=array[1..100] of string[30];
var y: yarray;
   words: warray;
   xs,ds,gs,hs: string[30];
   xl,a,x,b: integer;
label again,rep;

begin
 {begin word list}
 words[1]:=('time');
 words[2]:=('issue');
 words[3]:=('year');
 words[4]:=('side');
 words[5]:=('people');
 words[6]:=('kind');
 words[7]:=('cat');
 words[8]:=('dog');
 words[9]:=('way');
 words[10]:=('man');
 words[11]:=('friend');
 words[12]:=('woman');
 words[13]:=('father');
 words[14]:=('student');
 words[15]:=('child');
 words[16]:=('life');
 words[17]:=('hour');
 words[18]:=('hand');
 words[19]:=('car');
 words[20]:=('house');
 words[21]:=('week');
 words[22]:=('kid');
 words[23]:=('company');
 words[24]:=('face');
 words[25]:=('body');
 words[26]:=('program');
 words[27]:=('minute');
 words[28]:=('team');
 words[29]:=('parent');
 words[30]:=('question');
 words[31]:=('back');
 words[32]:=('water');
 words[33]:=('pizza');
 words[34]:=('hotdog');
 words[35]:=('cola');
 words[36]:=('coffee');
 words[37]:=('mug');
 words[38]:=('happy');
 words[39]:=('sad');
 words[40]:=('tree');
 words[41]:=('ocean');
 words[42]:=('computer');
 words[43]:=('girl');
 words[44]:=('teacher');
 words[45]:=('monkey');
 words[46]:=('study');
 words[47]:=('book');
 words[48]:=('air');
 words[49]:=('juxtapose');
 words[50]:=('gorilla');
 words[51]:=('apple');
 words[52]:=('animal');
 words[53]:=('bank');
 words[54]:=('beauty');
 words[55]:=('bell');
 words[56]:=('bread');
 words[57]:=('milk');
 words[58]:=('brother');
 words[59]:=('clock');
 words[60]:=('cloud');
 words[61]:=('cold');
 words[62]:=('character');
 words[63]:=('corn');
 words[64]:=('division');
 words[65]:=('multiply');
 words[66]:=('addition');
 words[67]:=('dollar');
 words[68]:=('death');
 words[69]:=('drink');
 words[70]:=('egg');
 words[71]:=('dream');
 words[72]:=('earth');
 words[73]:=('kangaroo');
 words[74]:=('science');
 words[75]:=('love');
 words[76]:=('bird');
 words[77]:=('mammal');
 words[78]:=('plant');
 words[79]:=('class');
 words[80]:=('green');
 words[81]:=('red');
 words[82]:=('yellow');
 words[83]:=('blue');
 words[84]:=('morning');
 words[85]:=('circle');
 words[86]:=('square');
 words[87]:=('triangle');
 words[88]:=('heart');
 words[89]:=('orange');
 words[90]:=('banana');
 words[91]:=('moon');
 words[92]:=('sun');
 words[93]:=('fast');
 words[94]:=('slow');
 words[95]:=('hair');
 words[96]:=('leaf');
 words[97]:=('sand');
 words[98]:=('reason');
 words[99]:=('thought');
 words[100]:=('logic');
 {end word list}

 writeln('---Word guessing game---');
 rep:;
 ds:='';
 for b:=1 to 30 do
  begin
   y[b]:=0
  end;
 randomize;
 x:=random(100)+1;
 xs:=words[x];
 xs:=upcase(xs);
 xl:=length(xs);
 if (xl<1) then halt;
 for a:=1 to xl do
  begin
  randomize;
  again:;
   x:=random(xl)+1;
   for b:=1 to 30 do
    begin
     if (x=y[b]) then goto again;
    end;
   ds:=ds+copy(xs,x,1);
   y[a]:=x;
 end;
 writeln('Here is a scrambled word:');
 writeln(ds);
 while(gs<>xs) do
  begin
   write('Enter guess (or "hint","quit","answer"): ');
   readln(gs);
   gs:=upcase(gs);
   if (gs='QUIT') then halt;
   if (gs='ANSWER') then
    begin
     writeln('It was: ',xs);
     goto rep;
    end;
   if (gs='HINT') then
    begin
     hs:=copy(xs,1,1);
     writeln('It begins with the letter ',hs,'.');
    end;
  end;
 writeln('You got it.');
 goto rep;
end.
