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
  File last update : 2025-10-28T20:00:02.912+01:00
  Signature : 7eacb58772901c1c01980bf32f9a2d35ffe85001
  ***************************************************************************
*)

unit fMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Media;

type
  TfrmMain = class(TForm)
    musicPlayer: TMediaPlayer;
    musicPlayerCheck: TTimer;
    StyleBook1: TStyleBook;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure musicPlayerCheckTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormSaveState(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses fSceneMenu, fSceneRoot, uMusic, uGameData, System.IOUtils;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pausegame;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  CurrentScene: tfrmsceneroot;
begin
  if ((Key = vkHardwareBack) or (Key = vkEscape)) then
  begin
    Key := 0;
    CurrentScene := getcurrentscene;
    if assigned(CurrentScene.btnMenu.OnClick) then
      CurrentScene.btnMenu.OnClick(Sender);
  end; // TODO : traiter le ESC lorsqu'un changement d'écran est en cours
end;

procedure TfrmMain.FormSaveState(Sender: TObject);
begin
  pausegame;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  FileName: string;
begin
  TfrmSceneMenu.SceneShow<TfrmSceneMenu>;
  FileName := getMusicMP3FilePath;
  if (not FileName.IsEmpty) and (tfile.Exists(FileName)) then
  begin
    musicPlayer.FileName := FileName;
    musicPlayerCheck.Enabled := true;
  end
  else
    musicPlayerCheck.Enabled := false;
end;

procedure TfrmMain.musicPlayerCheckTimer(Sender: TObject);
begin
  if isMusicOn then
  begin
    if (musicPlayer.State <> tmediastate.Playing) then
      musicPlayer.Play
    else if (musicPlayer.CurrentTime >= musicPlayer.Duration) then
      musicPlayer.CurrentTime := 0;
  end
  else if (musicPlayer.State = tmediastate.Playing) then
    musicPlayer.Stop;
end;

// TODO : SaveState non activé lors de la mise en background de l'application sur iPhone SE.
end.
