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
  File last update : 2025-11-01T11:22:38.000+01:00
  Signature : c13c99ddb017d9b4c37cbc379b24ccf2f26973e1
  ***************************************************************************
*)

unit uMusic;

interface

procedure setMusicOnOff(isOn: boolean);
function isMusicOn: boolean;

function getMusicMP3FilePath: string;

implementation

uses
  System.IOUtils,
  System.SysUtils,
  uCommonTools;

var
  MusicOnOff: boolean;
  MusicFileExists: boolean;

function getMusicDataFilePath: string;
begin
  result := tpath.Combine(getFolderName, 'music.dat');
end;

procedure save;
var
  f: file;
begin
  assignfile(f, getMusicDataFilePath);
{$I-}
  rewrite(f, 1);
{$I+}
  blockwrite(f, MusicOnOff, sizeof(MusicOnOff));
  closefile(f);
end;

procedure load;
var
  f: file;
begin
  MusicOnOff := true;
  if tfile.Exists(getMusicDataFilePath) then
  begin
    assignfile(f, getMusicDataFilePath);
{$I-}
    reset(f, 1);
{$I+}
    if not eof(f) then
      blockread(f, MusicOnOff, sizeof(MusicOnOff));
    closefile(f);
  end;
  setMusicOnOff(MusicOnOff);
end;

procedure setMusicOnOff(isOn: boolean);
begin
  if (MusicOnOff <> isOn) then
  begin
    MusicOnOff := isOn;
    save;
  end;
end;

function isMusicOn: boolean;
begin
  result := MusicOnOff and MusicFileExists;
end;

function getMusicMP3FilePath: string;
var
  filename: string;
begin
{$IF Defined(ANDROID)}
  filename := tpath.Combine(tpath.GetDocumentsPath, 'AWinterTale.mp3');
{$ELSEIF Defined(IOS)}
  filename := tpath.Combine(tpath.GetDirectoryName(paramstr(0)),
    'AWinterTale.mp3');
{$ELSEIF Defined(MSWINDOWS)}
{$IFDEF DEBUG}
  filename := '..\..\..\assets\opengameart.com\AWinterTale.mp3';
{$ELSE}
  filename := tpath.Combine(tpath.GetDirectoryName(paramstr(0)),
    'AWinterTale.mp3');
{$ENDIF}
{$ELSEIF Defined(MACOS)}
  filename := tpath.Combine(tpath.GetDirectoryName(paramstr(0)),
    'AWinterTale.mp3');
{$ELSEIF Defined(LINUX)}
  filename := tpath.Combine(tpath.GetDirectoryName(paramstr(0)),
    'AWinterTale.mp3');
{$ELSE}
{$MESSAGE FATAL 'not available'}
{$ENDIF}
  MusicFileExists := tfile.Exists(filename);
  if MusicFileExists then
    result := filename
  else
    result := '';
end;

initialization

  MusicOnOff := true;
  load;

end.

