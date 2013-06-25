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

program psolarext;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, glscene_runtime, glscene_designtime, UFrmcon, UFrmGL;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmcon, Frmcon);
  Application.CreateForm(TFrmGL, FrmGL);
  Application.Run;
end.
