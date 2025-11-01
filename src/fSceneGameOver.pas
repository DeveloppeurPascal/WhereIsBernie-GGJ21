unit fSceneGameOver;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  fSceneRoot, FMX.Controls.Presentation, FMX.Ani, FMX.Edit, FMX.Objects,
  FMX.Layouts;

type
  TfrmSceneGameOver = class(TfrmSceneRoot)
    Label1: TLabel;
    txtLevelMax: TText;
    txtScore: TText;
    edtPseudo: TEdit;
    btnSaveScore: TButton;
    GridPanelLayout1: TGridPanelLayout;
    procedure btnSaveScoreClick(Sender: TObject);
  private
    { Déclarations privées }
  protected
    class function getSceneref: TfrmSceneRoot; override;
  public
    { Déclarations publiques }
  end;

var
  frmSceneGameOver: TfrmSceneGameOver;

implementation

{$R *.fmx}

uses uGameData, uScores, fSceneScore, System.IOUtils, uCommonTools;

function getPseudoFilePath: string;
begin
  result := tpath.Combine(getFolderName, 'pseudo.dat');
end;

{ TfrmSceneGameOver }

procedure TfrmSceneGameOver.btnSaveScoreClick(Sender: TObject);
begin
  if edtPseudo.Text.IsEmpty then
  begin
    showmessage('Please give your name or pseudo.');
    edtPseudo.SetFocus;
  end
  else
  begin
    ScoreAdd(edtPseudo.Text.Trim, gamescore, gamelevelmax);
    tfile.WriteAllText(getPseudoFilePath, edtPseudo.Text.Trim, tencoding.UTF8);
    tfrmscenescore.SceneShow<tfrmscenescore>;
  end;
end;

class function TfrmSceneGameOver.getSceneref: TfrmSceneRoot;
begin
  if not assigned(frmSceneGameOver) then
    frmSceneGameOver := TfrmSceneRoot.SceneCreate<TfrmSceneGameOver>;
  frmSceneGameOver.txtScore.Text := 'Score : ' + gamescore.ToString;
  frmSceneGameOver.txtLevelMax.Text := 'High level : ' + gamelevelmax.ToString;
  if tfile.Exists(getPseudoFilePath) then
    frmSceneGameOver.edtPseudo.Text := tfile.ReadAllText(getPseudoFilePath,
      tencoding.UTF8)
  else
    frmSceneGameOver.edtPseudo.Text := '';
  result := frmSceneGameOver;
end;

end.
