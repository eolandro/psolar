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
unit UFrmGL;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, GLScene,
  GLCadencer, GLMaterial, GLObjects, GLSkydome, GLVectorFileObjects,
  GLLCLViewer, GLFileJPEG, types, GLFileOBJ, GLMesh, GLFireFX, GLGeomObjects,
  BaseClasses, Math;

type

  { TFrmGL }

  TFrmGL = class(TForm)
    GLCamcom: TGLCamera;
    GLDCura: TGLDummyCube;
    GLDCnep: TGLDummyCube;
    GLDCcom: TGLDummyCube;
    GLProcom: TGLProxyObject;
    GLring: TGLAnnulus;
    GLCad1: TGLCadencer;
    GLCam1: TGLCamera;
    GLCamast: TGLCamera;
    GLDCSol: TGLDummyCube;
    GLDCmer: TGLDummyCube;
    GLDCven: TGLDummyCube;
    GLDCTie: TGLDummyCube;
    GLDCLun: TGLDummyCube;
    GLDCMar: TGLDummyCube;
    GLDCast: TGLDummyCube;
    GLDCcast: TGLDummyCube;
    GLDCFlame: TGLDummyCube;
    GLDCJup: TGLDummyCube;
    GLDCsat: TGLDummyCube;
    GLESD: TGLEarthSkyDome;
    glast: TGLFreeForm;
    GLFFXM1: TGLFireFXManager;
    GLLSsol1: TGLLightSource;
    GLMa: TGLMaterialLibrary;
    GLS1: TGLScene;
    GLSol: TGLSphere;
    GLmer: TGLSphere;
    GLLun: TGLSphere;
    GLMar: TGLSphere;
    GLJup: TGLSphere;
    GLsat: TGLSphere;
    GLnep: TGLSphere;
    GLura: TGLSphere;
    GLtie: TGLSphere;
    GLVen: TGLSphere;
    GLSV1: TGLSceneViewer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GLCad1Progress(Sender: TObject; const deltaTime, newTime: Double);
    procedure GLSV1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GLSV1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure GLSV1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);



  private
    olFL: single;
    ox: single;
    oy: single;
    oz: single;
    xAnt,yAnt:integer;
    //oldPick: TGLCustomSceneObject;
    oldPick: TGLBaseSceneObject;

    { private declarations }
  public
    { public declarations }
    GLLScam: array [0..5] of TGLLightSource;
    GLPObast: array [0..18] of TGLProxyObject;
    lock : boolean;

  end; 

var
  FrmGL: TFrmGL;
  ran: integer;
  time: integer;
  ch: boolean;


implementation

{$R *.lfm}

{ TFrmGL }

procedure TFrmGL.FormCreate(Sender: TObject);
var
  path: UTF8String;
  i: integer;
  j: integer;
  d: integer;
begin
  ch:=true;
  ran:=170;
  xAnt:=0 ;
  yAnt:=0;
  path := ExtractFilePath(ParamStrUTF8(0));
  path := IncludeTrailingPathDelimiter(path) + 'texture';
  path := IncludeTrailingPathDelimiter(path);
  glast.LoadFromFile(path + 'asteroide.obj');
  d:=trunc(glast.Position.X*glast.Position.X);
  GLESD.Stars.AddRandomStars(1000,clwhite);
  for i:=0 to 18 do
  begin
      GLPObast[i]:=TGLProxyObject(GLDCcast.AddNewChild(TGLProxyObject));
      GLPObast[i].MasterObject:=glast;
      GLPobast[i].Name:='GLPobast'+inttostr(i);
      GLPObast[i].ProxyOptions:=[pooObjects];
  end;
  j:=200;
  for i:=0 to 8 do
  begin
      GLPObast[i].Position.x:=j;
      GLPObast[i].Position.z:=trunc(sqrt(d-(j*j)));
      j:=j-50;
  end;

  for i:=9 to 18 do
  begin
      GLPObast[i].Position.x:=j;
      GLPObast[i].Position.z:=-1*trunc(sqrt(d-(j*j)));
      j:=j+50;
  end;


  for i:=0 to 5 do
  begin
      GLLScam[i]:=TGLLightSource(GLDCFlame.AddNewChild(TGLLightSource));
      GLLScam[i].ConstAttenuation:=0.1;
  end;
  GLLScam[0].Position.Y:=30;
  GLLScam[0].SpotDirection.Y:=-1;
  GLLScam[0].SpotDirection.Z:=0;
  GLLScam[1].Position.Y:=-30;
  GLLScam[1].SpotDirection.Y:=1;
  GLLScam[1].SpotDirection.Z:=0;
  GLLScam[2].Position.X:=-30;
  GLLScam[2].SpotDirection.X:=1;
  GLLScam[2].SpotDirection.Z:=0;
  GLLScam[3].Position.X:=30;
  GLLScam[3].SpotDirection.X:=-1;
  GLLScam[3].SpotDirection.Z:=0;
  GLLScam[4].Position.Z:=-30;
  GLLScam[4].SpotDirection.Z:=1;
  GLLScam[5].Position.Z:=30;
  GLLScam[5].SpotDirection.Z:=-1;

  olFL:=FrmGL.GLCam1.FocalLength;
  ox:=FrmGL.GLCam1.Position.X;
  oy:=FrmGL.GLCam1.Position.Y;
  oz:=FrmGL.GLCam1.Position.Z;

  GLSV1.Update;
end;

procedure TFrmGL.FormDestroy(Sender: TObject);
begin

end;

procedure TFrmGL.GLCad1Progress(Sender: TObject; const deltaTime,
  newTime: Double);
begin
  if ((time mod 4) = 0) then
    begin
       Glprocom.Position.x:=ran;
       if not Glprocom.Visible then
        Glprocom.Visible:=true;

       if(ch) then
        begin
        Glprocom.Position.z:=-1*((100/170)*sqrt(28900-power(Glprocom.Position.x,2)));
        end
       else
       begin
        Glprocom.Position.z:=1*((100/170)*sqrt(28900-power(Glprocom.Position.x,2)));
        end;
       if(ch) then
              ran:=ran-1
       else
              ran:=ran+1;


       if(ran=-170) then
              ch:= not ch;

       if(ran=170) then
              ch:= not ch;
    end;
    time :=time+1;
    if time =1000 then
        time:=0

end;

procedure TFrmGL.GLSV1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pick:TGLBaseSceneObject;
begin
  if not lock then
  begin
  // find what's under the mouse
  try
    pick := ( GLSV1.Buffer.GetPickedObject(x, y) as TGLBaseSceneObject);
  except
    pick:=oldPick;
  end;
  // if it has changed since last MouseMove...
  if (pick <> oldPick)  then
  begin
  GLCam1.FocalLength:=olFL;
  GLCam1.Position.X:=ox;
  GLCam1.Position.Y:=oy;
  GLCam1.Position.Z:=oz;
  if Assigned(pick) then
  begin
        if (pick.Name <> 'GLESD') then
        begin
             GLCam1.Position.X:=pick.Position.X;
             GLCam1.TargetObject:=pick;
             GLCam1.FocalLength:=GLCam1.FocalLength*3;
             if pick.Name = 'GLSol' then
                GLCam1.FocalLength:=GLCam1.FocalLength/3;
             FrMGL.Caption:=pick.Name;

        end;
  end;
  end;
  oldPick := pick;
  end;
end;

procedure TFrmGL.GLSV1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if not lock then
  begin
  if ssLeft in Shift then
    GLcam1.MoveAroundTarget(yAnt-y,xAnt-x);
  xAnt:=x;
  yAnt:=y;

  end;
end;

procedure TFrmGL.GLSV1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if not lock then
  begin
     if WheelDelta>0 then
     begin
     GLcam1.FocalLength:=GLcam1.FocalLength+10;
     end
     else
     begin
     GLcam1.FocalLength:=GLcam1.FocalLength-10;
     end;
  end;
end;

end.
