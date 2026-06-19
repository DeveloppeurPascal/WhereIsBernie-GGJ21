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
  File last update : 2026-06-19T18:18:51.592+02:00
  Signature : 767d5a288c731de665e91be56642f9d85e897ed7
  ***************************************************************************
*)

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
