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
