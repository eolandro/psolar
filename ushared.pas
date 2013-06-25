unit Ushared;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils; 
type
  TControlSh = class(TObject)
    dead : boolean;
    procedure AfterDestruction;
  end;
var
  MCS : TControlSh;

implementation
procedure TControlSh.AfterDestruction;
begin
  dead:=false;
end;

end.

