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
  File last update : 2025-10-28T20:00:02.921+01:00
  Signature : 801422edbcbba2ee4b35a1305ade514aaae69ca4
  ***************************************************************************
*)

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
