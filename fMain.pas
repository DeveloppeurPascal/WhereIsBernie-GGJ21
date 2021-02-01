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
