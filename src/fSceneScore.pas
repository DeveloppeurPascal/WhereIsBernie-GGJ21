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
  File last update : 2026-06-19T18:18:51.623+02:00
  Signature : eb1b255c2d78cfd2bc97dbe1bc742c7c1adcde73
  ***************************************************************************
*)

unit fSceneScore;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  fSceneRoot, FMX.Controls.Presentation, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, FMX.Ani, FMX.Layouts;

type
  TfrmSceneScore = class(TfrmSceneRoot)
    Label1: TLabel;
    sgScores: TStringGrid;
    StringColumn1: TStringColumn;
    IntegerColumn1: TIntegerColumn;
    IntegerColumn2: TIntegerColumn;
    Layout1: TLayout;
  private
    { Déclarations privées }
  protected
    class function getSceneref: TfrmSceneRoot; override;
  public
    { Déclarations publiques }
    procedure DisplayScores;
  end;

var
  frmSceneScore: TfrmSceneScore;

implementation

{$R *.fmx}

uses uScores;
{ TfrmSceneScore }

procedure TfrmSceneScore.DisplayScores;
var
  scoreslist: tscoreslist;
  i: integer;
begin
  scoreslist := getScoresList;
  sgScores.RowCount := length(scoreslist) + 1;
  for i := 0 to length(scoreslist) - 1 do
  begin
    sgScores.Cells[0, i] := scoreslist[i].pseudo;
    sgScores.Cells[1, i] := scoreslist[i].score.tostring;
    sgScores.Cells[2, i] := scoreslist[i].level.tostring;
  end;
end;

class function TfrmSceneScore.getSceneref: TfrmSceneRoot;
begin
  if not assigned(frmSceneScore) then
    frmSceneScore := TfrmSceneRoot.SceneCreate<TfrmSceneScore>;
  frmSceneScore.DisplayScores;
  result := frmSceneScore;
end;

end.
