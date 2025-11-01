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
