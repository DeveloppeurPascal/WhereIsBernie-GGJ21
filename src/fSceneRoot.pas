(* C2PP
  ***************************************************************************

  Where is Bernie ?
  Copyright (c) 2021-2026 Patrick PREMARTIN

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://whereisbernie.gamolf.fr

  Project site :
  https://github.com/DeveloppeurPascal/WhereIsBernie-GGJ21

  ***************************************************************************
  File last update : 2026-06-19T18:18:51.619+02:00
  Signature : a1a906024dd63660b6258d8e2fe3ad530288040b
  ***************************************************************************
*)

unit fSceneRoot;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Ani, fMain;

type
  TfrmSceneRoot = class(TFrame)
    btnMenu: TButton;
    aniShowScene: TFloatAnimation;
    aniHideScene: TFloatAnimation;
    procedure btnMenuClick(Sender: TObject);
    procedure aniHideSceneFinish(Sender: TObject);
    procedure aniShowSceneFinish(Sender: TObject);
  private
    { Déclarations privées }
  protected
    fSceneParent: TfrmMain;
    class function getSceneref: TfrmSceneRoot; virtual; abstract;
    class function SceneCreate<T: TfrmSceneRoot>: T;
  public
    { Déclarations publiques }
    class procedure SceneShow<T: TfrmSceneRoot>;
    procedure ShowScene;
    procedure HideScene;
  end;

procedure GoToScene(NewScene: TfrmSceneRoot);
function getCurrentScene: TfrmSceneRoot;

implementation

{$R *.fmx}

uses fSceneMenu;

var
  CurrentScene: TfrmSceneRoot;

procedure GoToScene(NewScene: TfrmSceneRoot);
begin
  if assigned(NewScene) then
  begin
    if assigned(CurrentScene) then
      CurrentScene.HideScene;
    CurrentScene := NewScene;
    CurrentScene.ShowScene;
  end;
end;

function getCurrentScene: TfrmSceneRoot;
begin
  result := CurrentScene;
end;

{ TfrmSceneRoot }

procedure TfrmSceneRoot.aniHideSceneFinish(Sender: TObject);
begin
  visible := false;
  aniHideScene.Enabled := false;
end;

procedure TfrmSceneRoot.aniShowSceneFinish(Sender: TObject);
begin
  aniShowScene.Enabled := false;
  align := TAlignLayout.Client;
end;

procedure TfrmSceneRoot.btnMenuClick(Sender: TObject);
begin
  TfrmSceneMenu.SceneShow<TfrmSceneMenu>;
end;

procedure TfrmSceneRoot.HideScene;
begin
  align := TAlignLayout.None;
  aniHideScene.StartValue := 0;
  aniHideScene.StopValue := fSceneParent.Height;
  aniHideScene.Enabled := true;
end;

class function TfrmSceneRoot.SceneCreate<T>: T;
begin
  result := T.Create(application.mainform);
  result.Parent := application.mainform;
  if (application.mainform is TfrmMain) then
    result.fSceneParent := application.mainform as TfrmMain
  else
    raise exception.Create('Wrong parent form for this scene.');
  result.name := '';
end;

class procedure TfrmSceneRoot.SceneShow<T>;
var
  SceneRef: TfrmSceneRoot;
begin
  SceneRef := getSceneref;
  if assigned(SceneRef) then
    GoToScene(SceneRef)
  else
    raise exception.Create('Can''t schow scene.');
end;

procedure TfrmSceneRoot.ShowScene;
begin
  align := TAlignLayout.None;
  position.x := 0;
  position.y := -fSceneParent.Height;
  width := fSceneParent.width;
  Height := fSceneParent.Height;
  visible := true;
  aniShowScene.Enabled := true;
end;

end.
