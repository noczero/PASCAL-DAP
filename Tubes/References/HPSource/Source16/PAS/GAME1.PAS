{use Turbo Pascal v1.x to 3.x}


program TrackDown;
{
       TrackDown     a simple find-and-shoot game
}
const
  XMin               =  1;
  XMax               = 32;
  YMin               =  1;
  YMax               = 24;

type
  XRange             = XMin..XMax;
  YRange             = YMin..YMax;
  CharSet            = set of Char;
  CommandType        = (Quit,Move,Fire,Search);
  Prompt             = string[80];

var
  X1,X2,Y1,Y2        : Integer;
  Command            : CommandType;

function Rand(Low,High : Integer) : Integer;
{
       purpose       returns random value in range Low..High
}
var
  Range              : Integer;
begin
  Range := (High - Low) + 1;
  Rand  := Low + Trunc(Range*Random)
end; { of proc Rand }

procedure UpCase(var Ch : Char);
begin
  if Ch in ['a'..'z']
    then Ch := Chr(Ord(Ch)-32)
end; { of proc UpCase }

procedure GetChar(var Ch : Char; Msg : Prompt; OKSet : CharSet);
{
       purpose       writes Prompt, accepts Ch from OKSet
}
begin
  repeat
    GotoXY(1,1); ClrEol;
    Write(Msg); Read(Kbd,Ch);
    UpCase(Ch)
  until Ch in OKSet
end; { of proc GetChar }

procedure GetCommand(Var Cmd : CommandType);
{
       purpose      allows user to select one of 4 commands
}
var
  Ch                : Char;
begin
  GetChar(Ch,'CMD> M)ove, F)ire, S)earch, Q)uit: ',['M','F','S','Q']);
  case Ch of
    'M'   : Cmd := Move;
    'F'   : Cmd := Fire;
    'S'   : Cmd := Search;
    'Q'   : Cmd := Quit
  end
end; { of proc GetCommand }

procedure Initialize;
{
       purpose      set everythin up for game
}
begin
  ClrScr;
  X1 := (XMin+XMax) div 2;
  Y1 := YMin;
  X2 := (XMin+XMax) div 2 + Rand(-5,5);
  Y2 := (Ymin+Ymax) div 2 + Rand(-5,5)
end; { of proc Initialize }

procedure UpdatePosition(var X,Y : Integer; DX,DY : Integer);
{
       purpose      updates X,Y
}

  procedure WrapAround(Min : Integer; var Val : Integer;
                       Max : Integer);
  {
      purpose       handles wrap-around cases for Val
  }
  begin
    if Val < Min
      then Val := Max
    else if Val > Max
      then Val := Min
  end; { of proc WrapAround }

begin { main body of proc UpdatePosition }
  X := X + DX;
  Y := Y + DY;
  WrapAround(XMin,X,XMax);
  WrapAround(Ymin,Y,YMax)
end; { of proc UpdatePosition }

procedure MoveOther;
{
       purpose      moves enemy about 50% of the time
}
begin
  if Rand(1,2) = 1
    then UpdatePosition(X2,Y2,Rand(-1,1),Rand(-1,1))
end; { of proc MoveOther }

procedure DoMove;
{
       purpose      allows player to move
}
var
  Ch                : Char;
  DX,DY             : Integer;
begin
  DX := 0; DY := 0;
  GetChar(Ch,'MOVE> U)p, D)own, L)eft, R)ight: ',['U','D','L','R']);
  case Ch of
    'U'   : DY :=  1;
    'D'   : DY := -1;
    'L'   : DX := -1;
    'R'   : DX :=  1
  end;
  UpdatePosition(X1,Y1,DX,DY);
  GotoXY(1,5); Write('Current location:  ',X1:3,',',Y1:3)
end; { of proc DoMove }

procedure DoSearch;
{
       purpose      searches for enemy in adjacent locations
}
var
  Found             : Boolean;
  DX,DY,TX,TY       : Integer;
begin
  Found := False;
  DX := -3;
  while not Found and (DX < 4) do begin
    DY := -3;
    while not Found and (DY < 4) do begin
      TX := X1; TY := Y1;
      UpdatePosition(TX,TY,DX,DY);
      if (TX = X2) AND (TY = Y2)
        then Found := True
        else DY := DY + 1
    end;
    if not Found
      then DX := DX + 1
  end;
  GotoXY(1,2); ClrEol;
  if Found then begin
    Write('Enemy spotted:  current location is ');
    if (DX = 0) and (DY = 0)
      then Write('the same as yours')
    else begin
      if DX < 0
        then Write('to the left of')
      else if DX > 0
        then Write('to the right of');
      if (DX <> 0) and (DY <> 0)
        then Write(' and ');
      if DY < 0
        then Write('below')
      else if DY > 0
        then Write('above');
      Write(' yours')
    end
  end
  else Write('Enemy not spotted')
end; { of proc DoSearch }

procedure DoFire(var Command : CommandType);
{
       purpose      allows player to fire at enemy
}
var
  Ch                : Char;
  DX,DY             : Integer;
begin
  GetChar(Ch,'FIRE> L)eft, R)ight, U)p, D)own, S)ame: ',
          ['L','R','U','D','S']);
  DX := 0; DY := 0;
  case Ch of
    'L'   : DX := -1;
    'R'   : DX :=  1;
    'U'   : DY :=  1;
    'D'   : DY := -1
  end;
  GotoXY(1,3); ClrEol;
  if (Ch = 'S') and (Rand(1,4) = 1) then begin
    Write('Oops...you shot yourself!  You lose!');
    Command := Quit
  end
  else if (X1+DX = X2) and (Y1+DY = Y2) and (Rand(1,DX+DY) < 2) then begin
    Write('You got it!  You win!');
    Command := Quit
  end
  else Write('You missed.  Better luck next shot.')
end; { of proc DoFire }

{        main body of program TrackDown          }
begin
  Initialize;
  repeat
    GetCommand(Command);
    case Command of
      Move       : DoMove;
      Fire       : DoFire(Command);
      Search     : DoSearch
    end;
    MoveOther
  until Command = Quit
end. { of program TrackDown }

                                                                                                                 ackDown }

                                                                                                                 