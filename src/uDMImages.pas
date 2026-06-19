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
  Signature : 1acf33f7f9a6e77b05671b95789f42928f7248fb
  ***************************************************************************
*)

unit uDMImages;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, FMX.ImgList;

type
  TDMImages = class(TDataModule)
    imgPersonnages: TImageList;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMImages: TDMImages;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
