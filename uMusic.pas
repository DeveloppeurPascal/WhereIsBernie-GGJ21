unit uMusic;

interface

procedure setMusicOnOff(isOn: boolean);
function isMusicOn: boolean;

function getMusicMP3FilePath: string;

implementation

uses
  System.IOUtils, uCommonTools;

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
  filename := '..\..\_assets-used\opengameart.com\AWinterTale.mp3';
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
