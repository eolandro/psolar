{
psolar v1.0
Copyright (C) 2013, Leonardo Valdes Arteaga <leonardo.valdes@eolansoft.net> 
(eolandro). All rights reserved. 

This file is part of psolar

psolar is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

psolar is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with psolar.  If not, see <http://www.gnu.org/licenses/>.
}

unit UFrmcon;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, UFrmGL, GLObjects;

type

  { TFrmcon }

  TFrmcon = class(TForm)
    Btnexit: TButton;
    cbbox: TComboBox;
    ckb1: TCheckBox;
    CkB: TCheckBox;
    procedure BtnexitClick(Sender: TObject);
    procedure cbboxChange(Sender: TObject);
    procedure ckb1Change(Sender: TObject);
    procedure CkBChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Frmcon: TFrmcon;
  olFL: single;
  ox: single;
  oy: single;
  oz: single;

implementation

{$R *.lfm}

{ TFrmcon }

procedure TFrmcon.BtnexitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmcon.cbboxChange(Sender: TObject);
begin
  FrmGL.GLCam1.FocalLength:=olFL;
  FrmGL.GLCam1.Position.X:=ox;
  FrmGL.GLCam1.Position.Y:=oy;
  FrmGL.GLCam1.Position.Z:=oz;


  case cbbox.ItemIndex of
  0:FrmGL.GLCam1.TargetObject:=FrmGL.GLSol;
  1:begin
    FrmGL.GLCam1.Position.X:=FrmGL.GLmer.Position.X;
    FrmGL.GLCam1.TargetObject:=FrmGL.GLmer;
    FrmGL.GLCam1.FocalLength:=FrmGL.GLCam1.FocalLength*3;
    end;
  2:Begin
    FrmGL.GLCam1.Position.X:=FrmGL.GLven.Position.X;
    FrmGL.GLCam1.TargetObject:=FrmGL.GLVen;
    FrmGL.GLCam1.FocalLength:=FrmGL.GLCam1.FocalLength*2;
    end;
  3:Begin
    FrmGL.GLCam1.Position.X:=FrmGL.GLTie.Position.X;
    FrmGL.GLCam1.TargetObject:=FrmGL.GLTie;
    FrmGL.GLCam1.FocalLength:=FrmGL.GLCam1.FocalLength*4;
    end;
  4:Begin
    FrmGL.GLCam1.Position.X:=FrmGL.GLMar.Position.X;
    FrmGL.GLCam1.TargetObject:=FrmGL.GLMar;
    FrmGL.GLCam1.FocalLength:=FrmGL.GLCam1.FocalLength*4;
    end;
  5:Begin
    FrmGL.GLCam1.Position.X:=FrmGL.GLast.Position.X;
    FrmGL.GLCam1.TargetObject:=FrmGL.GLast;
    FrmGL.GLCam1.FocalLength:=FrmGL.GLCam1.FocalLength*8;
    end;
  6:Begin
    FrmGL.GLCam1.Position.X:=FrmGL.GLjup.Position.X;
    FrmGL.GLCam1.TargetObject:=FrmGL.GLjup;
    FrmGL.GLCam1.FocalLength:=FrmGL.GLCam1.FocalLength*8;
    end;
  7:Begin
    FrmGL.GLCam1.Position.X:=FrmGL.GLsat.Position.X;
    FrmGL.GLCam1.TargetObject:=FrmGL.GLsat;
    FrmGL.GLCam1.FocalLength:=FrmGL.GLCam1.FocalLength*8;
    end;
  8:Begin
    FrmGL.GLCam1.Position.X:=FrmGL.GLura.Position.X;
    FrmGL.GLCam1.TargetObject:=FrmGL.GLura;
    FrmGL.GLCam1.FocalLength:=FrmGL.GLCam1.FocalLength*8;
    end;
  9:Begin
    FrmGL.GLCam1.Position.X:=FrmGL.GLnep.Position.X;
    FrmGL.GLCam1.TargetObject:=FrmGL.GLnep;
    FrmGL.GLCam1.FocalLength:=FrmGL.GLCam1.FocalLength*8;
    end;

  end;
end;

procedure TFrmcon.ckb1Change(Sender: TObject);
begin
  if Ckb1.State = cbChecked then
     begin
     ckb.Enabled:=false;
     FrmGL.lock:=true;
     FrmGL.GLSV1.camera:=FrmGL.GLCamcom;
     end
     else
     begin
     ckb.Enabled:=true;
     FrmGL.lock:=False;
     FrmGL.GLSV1.camera:=FrmGL.GLCam1;
     end;

end;

procedure TFrmcon.CkBChange(Sender: TObject);
begin
     if Ckb.State = cbChecked then
     begin
     ckb1.Enabled:=false;
     FrmGL.lock:=true;
     FrmGL.GLSV1.camera:=FrmGL.GLCamast;
     end
     else
     begin
     ckb1.Enabled:=true;
     FrmGL.lock:=False;
     FrmGL.GLSV1.camera:=FrmGL.GLCam1;
     end;
end;

procedure TFrmcon.FormActivate(Sender: TObject);
begin

end;
procedure TFrmcon.FormCreate(Sender: TObject);
begin

end;

procedure TFrmcon.FormShow(Sender: TObject);
begin
   FrmGl.Show;
   olFL:=FrmGL.GLCam1.FocalLength;
   ox:=FrmGL.GLCam1.Position.X;
   oy:=FrmGL.GLCam1.Position.Y;
   oz:=FrmGL.GLCam1.Position.Z;
end;



end.
