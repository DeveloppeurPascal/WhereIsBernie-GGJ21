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
