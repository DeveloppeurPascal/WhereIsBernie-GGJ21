unit uCommonTools;

interface

function getFolderName: string;

implementation

uses
  System.IOUtils;

function getFolderName: string;
begin
  result := tpath.Combine(tpath.GetDocumentsPath,
    tpath.GetFileNameWithoutExtension(paramstr(0)));
  if not TDirectory.Exists(result) then
    TDirectory.CreateDirectory(result);
end;

end.
