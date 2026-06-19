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
  Signature : 8b97d65798d3d6a4f863adf007887a5c46a50b4c
  ***************************************************************************
*)

unit uCommonTools;

interface

function getFolderName: string;

implementation

uses
  System.SysUtils,
  System.IOUtils;

function getFolderName: string;
begin
  result := tpath.Combine(tpath.GetDocumentsPath,
    tpath.GetFileNameWithoutExtension(paramstr(0)));
  if not TDirectory.Exists(result) then
    TDirectory.CreateDirectory(result);
end;

end.

