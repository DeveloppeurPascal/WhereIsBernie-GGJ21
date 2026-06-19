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
  File last update : 2026-06-19T18:18:51.614+02:00
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
