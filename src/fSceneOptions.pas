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
  File last update : 2025-10-28T20:00:02.924+01:00
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
