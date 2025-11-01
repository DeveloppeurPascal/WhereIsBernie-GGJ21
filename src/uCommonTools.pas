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
  File last update : 2025-11-01T11:21:14.000+01:00
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

