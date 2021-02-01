unit fSceneGame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  fSceneRoot, FMX.Controls.Presentation, FMX.Ani, FMX.Objects, FMX.Layouts;

const
  CNbSnowflakes = 100;
  CScoreByLevel = 10;

type
  TfrmSceneGame = class(TfrmSceneRoot)
    GridPanelLayout1: TGridPanelLayout;
    txtScore: TText;
    txtLevel: TText;
    MoveSnow: TTimer;
    NPCLoop: TTimer;
    zoneBoutons: TLayout;
    btnMusicOnOff: TCircle;
    btnPause: TCircle;
    btnPauseSVG: TPath;
    btnMusicOnSVG: TPath;
    btnMusicOffSVG: TPath;
    procedure btnMenuClick(Sender: TObject);
    procedure MoveSnowTimer(Sender: TObject);
    procedure NPCLoopTimer(Sender: TObject);
    procedure btnMusicOnOffClick(Sender: TObject);
  private
    { Déclarations privées }
    procedure initSnowflakes;
    procedure initSnowflaskesCoord(i: Integer; InitScene: boolean = false);
  protected
    Snowflakes: array [0 .. CNbSnowflakes - 1] of TCircle;
    procedure setScore(score, level: cardinal);
  public
    { Déclarations publiques }
    CharacterLayers: array [0 .. 9] of TLayout;
    class function getSceneref: TfrmSceneRoot; override;
    procedure SceneGameInitAndStart;
    procedure onBernieClick(Sender: TObject);
    procedure onNotBernieClick(Sender: TObject);
    procedure onMissedBernieClick(Sender: TObject);
  end;

var
  frmSceneGame: TfrmSceneGame;

implementation

{$R *.fmx}

uses
  uGameData, System.Math, ucharactersprite, fSceneGameOver, uMusic;

{ TfrmSceneGame }

procedure TfrmSceneGame.btnMenuClick(Sender: TObject);
begin
  MoveSnow.Enabled := false;
  NPCLoop.Enabled := false;
  pausegame;
  inherited;
end;

procedure TfrmSceneGame.btnMusicOnOffClick(Sender: TObject);
begin
  // TODO : si arrêt de la musique, ne pas attendre le timer suivant, mais le faire tout de suite
  setMusicOnOff(not ismusicon);
  btnMusicOnSVG.visible := ismusicon;
  btnMusicOffSVG.visible := not btnMusicOnSVG.visible;
end;

class function TfrmSceneGame.getSceneref: TfrmSceneRoot;
var
  i: Integer;
begin
  if not assigned(frmSceneGame) then
  begin
    frmSceneGame := TfrmSceneRoot.SceneCreate<TfrmSceneGame>;
    frmSceneGame.btnMenu.visible := false;
    for i := 0 to 9 do
    begin
      frmSceneGame.CharacterLayers[i] := TLayout.Create(frmSceneGame);
      frmSceneGame.CharacterLayers[i].parent := frmSceneGame;
      frmSceneGame.CharacterLayers[i].align := talignlayout.Contents;
      frmSceneGame.CharacterLayers[i].hittest := false;
    end;
    frmSceneGame.zoneBoutons.bringtofront;
  end;
  randomize;
  frmSceneGame.SceneGameInitAndStart;
  result := frmSceneGame;
end;

procedure TfrmSceneGame.SceneGameInitAndStart;
begin
  frmSceneGame.setScore(GameScore, gamelevel);
  frmSceneGame.initSnowflakes;
  frmSceneGame.NPCLoop.Enabled := true;
  frmSceneGame.btnMusicOnSVG.visible := ismusicon;
  frmSceneGame.btnMusicOffSVG.visible := not frmSceneGame.btnMusicOnSVG.visible;
end;

procedure TfrmSceneGame.initSnowflakes;
var
  i: Integer;
begin
  for i := 0 to CNbSnowflakes - 1 do
  begin
    if not assigned(Snowflakes[i]) then
    begin
      Snowflakes[i] := TCircle.Create(Self);
      // Snowflakes[i].parent := Self;
      Snowflakes[i].hittest := false;
      Snowflakes[i].Fill.Color := talphacolors.Ivory;
      Snowflakes[i].Stroke.kind := tbrushkind.None;
      initSnowflaskesCoord(i, true);
    end;
  end;
  MoveSnow.Enabled := true;
end;

procedure TfrmSceneGame.MoveSnowTimer(Sender: TObject);
var
  i: Integer;
  num: Integer;
begin
  if not isgamestarted then
    exit;
  for i := 1 to min(20, CNbSnowflakes div 5) do
  begin
    num := random(CNbSnowflakes);
    Snowflakes[num].Position.X := Snowflakes[num].Position.X +
      Snowflakes[num].Tag;
    Snowflakes[num].Position.Y := Snowflakes[num].Position.Y + Snowflakes[num]
      .height / 2;
    if (Snowflakes[num].Position.X + Snowflakes[num].width < 0) or
      (Snowflakes[num].Position.X > width) or
      (Snowflakes[num].Position.Y + Snowflakes[num].height < 0) or
      (Snowflakes[num].Position.Y > height) then
      initSnowflaskesCoord(num);
  end;
end;

procedure TfrmSceneGame.NPCLoopTimer(Sender: TObject);
begin
  if not isgamestarted then
    exit;
  if (random(100) < 10) then
    TCharacterSprite.initSprite(Self, onBernieClick, onNotBernieClick,
      onMissedBernieClick);
end;

procedure TfrmSceneGame.onBernieClick(Sender: TObject);
begin
  if not isgamestarted then
    exit;
  GameScore := GameScore + gamelevel;
  if (GameScore / CScoreByLevel > gamelevel) then
    inc(gamelevel);
  if gamelevel > gamelevelmax then
    gamelevelmax := gamelevel;
  setScore(GameScore, gamelevel);
end;

procedure TfrmSceneGame.onMissedBernieClick(Sender: TObject);
var
  pts: Integer;
begin
  if not isgamestarted then
    exit;
  pts := gamelevel div 2 + 1;
  if GameScore > pts then
    GameScore := GameScore - pts
  else
    GameScore := 0;
  setScore(GameScore, gamelevel);
end;

procedure TfrmSceneGame.onNotBernieClick(Sender: TObject);
begin
  if not isgamestarted then
    exit;
  if (gamelevel > 1) then
  begin
    dec(gamelevel);
    setScore(GameScore, gamelevel);
  end
  else
  begin
    MoveSnow.Enabled := false;
    NPCLoop.Enabled := false;
    gameover;
    TfrmSceneGameOver.SceneShow<TfrmSceneGameOver>;
  end;
end;

procedure TfrmSceneGame.setScore(score, level: cardinal);
begin
  txtScore.text := score.ToString;
  txtLevel.text := level.ToString;
end;

procedure TfrmSceneGame.initSnowflaskesCoord(i: Integer;
  InitScene: boolean = false);
begin
  Snowflakes[i].Position.X := random(fSceneParent.width);
  if InitScene then
    Snowflakes[i].Position.Y := random(fSceneParent.height)
  else
    Snowflakes[i].Position.Y := 0;
  Snowflakes[i].width := random(5) + 5;
  Snowflakes[i].height := Snowflakes[i].width;
  Snowflakes[i].Tag := random(11) - 5;
  Snowflakes[i].parent := CharacterLayers[random(10)];
end;

end.
