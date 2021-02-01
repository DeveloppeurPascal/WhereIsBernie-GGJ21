program WhereIsBernie;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMain in 'fMain.pas' {frmMain},
  fSceneRoot in 'fSceneRoot.pas' {frmSceneRoot: TFrame},
  fSceneMenu in 'fSceneMenu.pas' {frmSceneMenu: TFrame},
  fSceneGame in 'fSceneGame.pas' {frmSceneGame: TFrame},
  fSceneGameOver in 'fSceneGameOver.pas' {frmSceneGameOver: TFrame},
  fSceneScore in 'fSceneScore.pas' {frmSceneScore: TFrame},
  fSceneCredit in 'fSceneCredit.pas' {frmSceneCredit: TFrame},
  fSceneOptions in 'fSceneOptions.pas' {frmSceneOptions: TFrame},
  uScores in 'uScores.pas',
  uMusic in 'uMusic.pas',
  uGameData in 'uGameData.pas',
  uCommonTools in 'uCommonTools.pas',
  uDMImages in 'uDMImages.pas' {DMImages: TDataModule},
  uCharacterSprite in 'uCharacterSprite.pas' {CharacterSprite: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Landscape, TFormOrientation.InvertedLandscape];
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDMImages, DMImages);
  Application.Run;
end.
