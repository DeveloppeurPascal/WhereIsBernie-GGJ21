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
  File last update : 2026-06-19T18:18:51.667+02:00
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

