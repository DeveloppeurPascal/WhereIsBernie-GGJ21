unit fSceneMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  fSceneRoot, FMX.Controls.Presentation, FMX.Ani, FMX.Layouts;

type
  TfrmSceneMenu = class(TfrmSceneRoot)
    lblTitle: TLabel;
    btnPlay: TButton;
    btnContinue: TButton;
    btnScores: TButton;
    btnOptions: TButton;
    btnQuit: TButton;
    btnCredits: TButton;
    VertScrollBox1: TVertScrollBox;
    procedure btnQuitClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure btnScoresClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure btnCreditsClick(Sender: TObject);
  private
    { Déclarations privées }
  protected
    class function getSceneref: TfrmSceneRoot; override;
  public
    { Déclarations publiques }
  end;

var
  frmSceneMenu: TfrmSceneMenu;

implementation

{$R *.fmx}

uses fSceneCredit, fSceneGame, fSceneOptions, fSceneScore, uGameData;

procedure TfrmSceneMenu.btnContinueClick(Sender: TObject);
begin
  gameresume;
end;

procedure TfrmSceneMenu.btnCreditsClick(Sender: TObject);
begin
  TfrmSceneCredit.SceneShow<TfrmSceneCredit>;
end;

procedure TfrmSceneMenu.btnOptionsClick(Sender: TObject);
begin
  TfrmSceneOptions.SceneShow<TfrmSceneOptions>;
end;

procedure TfrmSceneMenu.btnPlayClick(Sender: TObject);
begin
  gamestart;
end;

procedure TfrmSceneMenu.btnQuitClick(Sender: TObject);
begin
  fsceneparent.Close;
end;

procedure TfrmSceneMenu.btnScoresClick(Sender: TObject);
begin
  TfrmSceneScore.SceneShow<TfrmSceneScore>;
end;

class function TfrmSceneMenu.getSceneref: TfrmSceneRoot;
begin
  if not assigned(frmSceneMenu) then
  begin
    frmSceneMenu := TfrmSceneRoot.SceneCreate<TfrmSceneMenu>;
{$IF Defined(IOS) or Defined(ANDROID)}
    frmSceneMenu.btnQuit.Visible := false;
{$ENDIF}
  end;
  frmSceneMenu.btnContinue.Visible := isGamePaused;
  result := frmSceneMenu;
end;

end.
