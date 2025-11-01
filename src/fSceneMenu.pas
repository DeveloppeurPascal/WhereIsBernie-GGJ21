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
