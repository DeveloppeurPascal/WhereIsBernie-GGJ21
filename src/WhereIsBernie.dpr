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
  File last update : 2025-10-28T20:00:04.000+01:00
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
