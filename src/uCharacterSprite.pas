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
  File last update : 2026-06-19T18:18:51.625+02:00
  Signature : c7b96e5cd088b69ebeb8e119beb2a005af7dcc44
  ***************************************************************************
*)

unit uCharacterSprite;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  uDMImages,
  FMX.ImgList;

type
  TCharacterSprite = class(TFrame)
    CharacterImage: TGlyph;
    AutoRemove: TTimer;
    procedure FrameClick(Sender: TObject);
    procedure AutoRemoveTimer(Sender: TObject);
  private
    FonOtherCharacterClick: TNotifyEvent;
    FonBernieClick: TNotifyEvent;
    FonMissedBernieClick: TNotifyEvent;
    procedure SetonBernieClick(const Value: TNotifyEvent);
    procedure SetonOtherCharacterClick(const Value: TNotifyEvent);
    procedure SetonMissedBernieClick(const Value: TNotifyEvent);
    { Déclarations privées }
    class var NbCharacterSinceLastBernie: integer;
  public
    { Déclarations publiques }
    constructor initSprite(AOwner: TComponent; BernieClick, NotBernieClick,
      MissedBernieClick: TNotifyEvent);
    property onBernieClick: TNotifyEvent read FonBernieClick
    write SetonBernieClick;
    property onOtherCharacterClick: TNotifyEvent read FonOtherCharacterClick
    write SetonOtherCharacterClick;
    property onMissedBernieClick: TNotifyEvent read FonMissedBernieClick
    write SetonMissedBernieClick;
  end;

implementation

{$R *.fmx}

uses
  System.Math,
  uGameData,
  fSceneGame;
{ TspritePersonnage }

procedure TCharacterSprite.AutoRemoveTimer(Sender: TObject);
begin
  if isgamestarted then
  begin
    // TODO : vérifier que le personnage ne déborde pas de l'écran, dans le cas contraire le repositionner
    if (CharacterImage.ImageIndex = 0) and assigned(onMissedBernieClick) then
      onMissedBernieClick(self);
    // Free;
    AutoRemove.enabled := false;
    tthread.ForceQueue(nil,
      procedure
      begin
        self.Free;
      end);
  end;
end;

procedure TCharacterSprite.FrameClick(Sender: TObject);
begin
  if (CharacterImage.ImageIndex = 0) and assigned(onBernieClick) then
    onBernieClick(self)
  else if (CharacterImage.ImageIndex > 0) and assigned(onOtherCharacterClick) then
    onOtherCharacterClick(Sender);
  // Free;
  tthread.ForceQueue(nil,
    procedure
    begin
      self.Free;
    end);
end;

constructor TCharacterSprite.initSprite(AOwner: TComponent;
  BernieClick, NotBernieClick, MissedBernieClick: TNotifyEvent);
var
  //  ctrl: tcontrol;
  HeightDiv3, posy: single;
  scy: integer;
begin
  create(AOwner);
  CharacterImage.ImageIndex :=
  random(min(gamelevel + 1, DMImages.imgPersonnages.Destination.Count));
  if CharacterImage.ImageIndex = 0 then
    NbCharacterSinceLastBernie := 0
  else
    inc(NbCharacterSinceLastBernie);
  if (NbCharacterSinceLastBernie > 10) then
  begin // 1 Bernie for each 10 characters max
    CharacterImage.ImageIndex := 0;
    NbCharacterSinceLastBernie := 0;
  end;
  name := '';
  onBernieClick := BernieClick;
  onOtherCharacterClick := NotBernieClick;
  onMissedBernieClick := MissedBernieClick;
  // if (AOwner is tfmxobject) then
  // parent := (AOwner as tfmxobject);
  // if (AOwner is tcontrol) then
  // begin
  // ctrl := (AOwner as tcontrol);
  // HeightDiv3 := ctrl.Height / 3;
  HeightDiv3 := application.mainform.Height / 3;
  scy := random(8) + 3; // random 0-7, we had 3 to have 3-10 values
  posy := HeightDiv3 * (scy - 1) / 10;
  scale.X := scy / 10;
  scale.Y := scale.X;
  // position.X := min(random(trunc(ctrl.Width)), ctrl.Width - Width * scale.X);
  position.X := min(random(trunc(application.mainform.Width)),
    application.mainform.Width - Width * scale.X);
  position.Y := HeightDiv3 * 2 + posy - Height * scale.Y;
  if (AOwner is tfrmscenegame) then
    parent := (AOwner as tfrmscenegame).CharacterLayers[scy - 1];
  // end;
  AutoRemove.Interval := min(max(random(gamelevel * 1000), 3 * 1000),
    30 * 1000);
  AutoRemove.enabled := true;
end;

procedure TCharacterSprite.SetonBernieClick(const Value: TNotifyEvent);
begin
  FonBernieClick := Value;
end;

procedure TCharacterSprite.SetonMissedBernieClick(const Value: TNotifyEvent);
begin
  FonMissedBernieClick := Value;
end;

procedure TCharacterSprite.SetonOtherCharacterClick(const Value: TNotifyEvent);
begin
  FonOtherCharacterClick := Value;
end;

initialization

  TCharacterSprite.NbCharacterSinceLastBernie := 0;

  // TODO : gérer zones de transparence sur les personnages lors du clic
  // TODO : faire animation sur personnages (mouvement et suppression)
end.

