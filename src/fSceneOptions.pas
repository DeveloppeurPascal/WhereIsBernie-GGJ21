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
  File last update : 2026-06-19T18:18:51.617+02:00
  Signature : a9f2948458721e0b24aff84c352e5f94bef77e51
  ***************************************************************************
*)

unit fSceneOptions;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  fSceneRoot, FMX.Controls.Presentation, FMX.Ani, FMX.Layouts;

type
  TfrmSceneOptions = class(TfrmSceneRoot)
    Label1: TLabel;
    lblMusicOption: TLabel;
    swMusicOnOff: TSwitch;
    zoneMusic: TLayout;
    procedure swMusicOnOffSwitch(Sender: TObject);
  private
    { Déclarations privées }
  protected
    class function getSceneref: TfrmSceneRoot; override;
  public
    { Déclarations publiques }
  end;

var
  frmSceneOptions: TfrmSceneOptions;

implementation

{$R *.fmx}

uses uMusic;

{ TfrmSceneOptions }

class function TfrmSceneOptions.getSceneref: TfrmSceneRoot;
begin
  if not assigned(frmSceneOptions) then
    frmSceneOptions := TfrmSceneRoot.SceneCreate<TfrmSceneOptions>;
  frmSceneOptions.swMusicOnOff.ischecked := isMusicOn;
  result := frmSceneOptions;
end;

procedure TfrmSceneOptions.swMusicOnOffSwitch(Sender: TObject);
begin
  setMusicOnOff(swMusicOnOff.ischecked);
end;

end.
