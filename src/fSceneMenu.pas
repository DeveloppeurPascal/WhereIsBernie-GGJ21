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
  File last update : 2026-06-19T18:18:51.617+02:00
  Signature : 4e86f0528bc43d29340a6892b3aef53b9ea5e056
  ***************************************************************************
*)

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
