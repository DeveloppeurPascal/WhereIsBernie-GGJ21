(* C2PP
  ***************************************************************************

  Where is Bernie ?

  Copyright 2021-2025 Patrick PREMARTIN under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://whereisbernie.gamolf.fr

  Project site :
  https://github.com/DeveloppeurPascal/WhereIsBernie-GGJ21

  ***************************************************************************
  File last update : 2025-10-28T20:00:02.926+01:00
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
