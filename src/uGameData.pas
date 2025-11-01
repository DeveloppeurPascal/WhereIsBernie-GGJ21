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
  File last update : 2025-11-01T11:21:12.000+01:00
  Signature : 6f9c9f763c4541406860fcebd8cbc0a87d4538ac
  ***************************************************************************
*)

unit uGameData;

interface

var
  GameScore, GameLevel, GameLevelMax: cardinal;

function isGamePaused: boolean;
function isGameStarted: boolean;
procedure PauseGame;
procedure GameStart;
procedure GameResume;
procedure GameOver;

implementation

uses
  FMX.Types,
  System.SysUtils,
  system.ioutils,
  uCommonTools,
  fSceneGame,
  uCharacterSprite;

var
  GameStarted: boolean;

function getGameFilePath: string;
begin
  result := tpath.Combine(getFolderName, 'game.dat');
end;

procedure save;
var
  f: file;
  NbCharactersToCreate: integer;
  i, j: integer;
  SceneGame: TfrmSceneGame;
begin
  NbCharactersToCreate := 0;
  SceneGame := TfrmSceneGame.getsceneref as TfrmSceneGame;
  for i := 0 to length(SceneGame.CharacterLayers) - 1 do
    for j := SceneGame.CharacterLayers[i].ChildrenCount - 1 downto 0 do
      if (SceneGame.CharacterLayers[i].Children[j] is tcharactersprite) then
        inc(NbCharactersToCreate);
  assignfile(f, getGameFilePath);
{$I-}
  rewrite(f, 1);
{$I+}
  blockwrite(f, GameScore, sizeof(GameScore));
  blockwrite(f, GameLevel, sizeof(GameLevel));
  blockwrite(f, GameLevelMax, sizeof(GameLevelMax));
  blockwrite(f, NbCharactersToCreate, sizeof(NbCharactersToCreate));
  closefile(f);
end;

procedure load;
var
  f: file;
  NbCharactersToCreate: integer;
  i: integer;
  SceneGame: TfrmSceneGame;
begin
  GameScore := 0;
  GameLevel := 1;
  GameLevelMax := 1;
  NbCharactersToCreate := 0;
  if tfile.Exists(getGameFilePath) then
  begin
    assignfile(f, getGameFilePath);
{$I-}
    reset(f, 1);
{$I+}
    if not eof(f) then
      blockread(f, GameScore, sizeof(GameScore));
    if not eof(f) then
      blockread(f, GameLevel, sizeof(GameLevel));
    if not eof(f) then
      blockread(f, GameLevelMax, sizeof(GameLevelMax));
    if not eof(f) then
      blockread(f, NbCharactersToCreate, sizeof(NbCharactersToCreate));
    closefile(f);
  end;
  SceneGame := TfrmSceneGame.getsceneref as TfrmSceneGame;
  for i := 0 to NbCharactersToCreate do
    tcharactersprite.initSprite(SceneGame, SceneGame.onBernieClick,
      SceneGame.onNotBernieClick, SceneGame.onMissedBernieClick);
end;

function isGamePaused: boolean;
begin
  result := tfile.Exists(getGameFilePath);
end;

function isGameStarted: boolean;
begin
  result := GameStarted;
end;

procedure PauseGame;
begin
  if GameStarted then
  begin
    GameStarted := false;
    save;
  end;
end;

procedure GameStart;
var
  SceneGame: TfrmSceneGame;
  i, j: integer;
begin
  GameStarted := true;
  SceneGame := TfrmSceneGame.getsceneref as TfrmSceneGame;
  for i := 0 to length(SceneGame.CharacterLayers) - 1 do
    for j := SceneGame.CharacterLayers[i].ChildrenCount - 1 downto 0 do
      if (SceneGame.CharacterLayers[i].Children[j] is tcharactersprite) then
        (SceneGame.CharacterLayers[i].Children[j] as tcharactersprite).Free;
  GameScore := 0;
  GameLevel := 1;
  GameLevelMax := 1;
  SceneGame.SceneGameInitAndStart;
  TfrmSceneGame.SceneShow<TfrmSceneGame>;
end;

procedure GameResume;
var
  SceneGame: TfrmSceneGame;
  i, j: integer;
begin
  GameStarted := true;
  SceneGame := TfrmSceneGame.getsceneref as TfrmSceneGame;
  for i := 0 to length(SceneGame.CharacterLayers) - 1 do
    for j := SceneGame.CharacterLayers[i].ChildrenCount - 1 downto 0 do
      if (SceneGame.CharacterLayers[i].Children[j] is tcharactersprite) then
        (SceneGame.CharacterLayers[i].Children[j] as tcharactersprite).Free;
  load;
  SceneGame.SceneGameInitAndStart;
  TfrmSceneGame.SceneShow<TfrmSceneGame>;
end;

procedure GameOver;
begin
  GameStarted := false;
  if tfile.Exists(getGameFilePath) then
    tfile.Delete(getGameFilePath);
end;

initialization

  GameStarted := false;

end.

