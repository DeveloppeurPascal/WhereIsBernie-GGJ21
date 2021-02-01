unit uScores;

interface

const
  CNbMaxScore = 50;

type
  TScore = record
    pseudo: string;
    score: cardinal;
    level: cardinal;
  end;

  TScoresList = array of TScore;

procedure ScoreAdd(pseudo: string; score: cardinal; level: cardinal;
  savescorelist: boolean = true);
function getScoresList: TScoresList;

implementation

uses
  system.Types, system.IOUtils, system.sysutils, uCommonTools;

var
  ScoresList: TScoresList;

function getScoreFilePath: string;
begin
  result := tpath.Combine(getFolderName, 'scores.dat');
end;

procedure Save;
var
  i: integer;
  f: textfile;
begin
  assignfile(f, getScoreFilePath);
{$I-}
  Rewrite(f);
{$I+}
  for i := 0 to length(ScoresList) - 1 do
    if (ScoresList[i].score > 0) then
      writeln(f, ScoresList[i].pseudo, tabulator, ScoresList[i].score,
        tabulator, ScoresList[i].level);
  closefile(f);
end;

procedure Load;
var
  f: textfile;
  FileName: string;
  ch: string;
  tab: tarray<string>;
begin
  setlength(ScoresList, 0);
  FileName := getScoreFilePath;
  if tfile.Exists(FileName) then
  begin
    assignfile(f, FileName);
{$I-}
    Reset(f);
{$I+}
    while not eof(f) do
    begin
      readln(f, ch);
      tab := ch.Split([tabulator]);
      if length(tab) = 3 then
        ScoreAdd(tab[0], StrToUInt64(tab[1]), StrToUInt64(tab[2]), false);
    end; // TODO : verifier UInt64 et Cardinal
    closefile(f);
  end;
end;

procedure ScoreAdd(pseudo: string; score: cardinal; level: cardinal;
  savescorelist: boolean = true);
var
  i, i_NewScore: integer;
  newscore: TScore;
begin
  if (not pseudo.Trim.isempty) and (not pseudo.Contains(tabulator)) and
    (score > 0) then
  begin
    newscore.pseudo := pseudo;
    newscore.score := score;
    newscore.level := level;
    if length(ScoresList) < CNbMaxScore then
      setlength(ScoresList, length(ScoresList) + 1);
    i := 0;
    while (i <= length(ScoresList) - 2) and
      (ScoresList[i].score > newscore.score) do
      inc(i);
    i_NewScore := i;
    i := length(ScoresList) - 1;
    while (i > i_NewScore) do
    begin
      ScoresList[i] := ScoresList[i - 1];
      dec(i);
    end;
    ScoresList[i_NewScore] := newscore;
    if savescorelist then
      Save;
  end;
end;

function getScoresList: TScoresList;
begin
  result := ScoresList;
end;

initialization

Load;

end.
