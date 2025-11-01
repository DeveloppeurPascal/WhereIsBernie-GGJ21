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
  File last update : 2025-10-28T20:00:02.914+01:00
  Signature : fa3201a4d5333a77908f7e46c710f23070949891
  ***************************************************************************
*)

unit fSceneCredit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  fSceneRoot, FMX.Controls.Presentation, FMX.Ani, FMX.Layouts;

type
  TfrmSceneCredit = class(TfrmSceneRoot)
    Label1: TLabel;
    lblCredits: TLabel;
    VertScrollBox1: TVertScrollBox;
  private
    { Déclarations privées }
  protected
    class function getSceneref: TfrmSceneRoot; override;
  public
    { Déclarations publiques }
  end;

var
  frmSceneCredit: TfrmSceneCredit;

implementation

{$R *.fmx}

{ TfrmSceneCredit }
// TODO : activer liens sur texte
class function TfrmSceneCredit.getSceneref: TfrmSceneRoot;
begin
  if not assigned(frmSceneCredit) then
  begin
    frmSceneCredit := TfrmSceneRoot.SceneCreate<TfrmSceneCredit>;
    frmSceneCredit.lblCredits.text :=
      '"Where is Bernie ?" was inspired by the POTUS 46 (Joe Biden) Inauguration Day'
      + ' Thanks to Bernie Sanders for his fairplay in front of the success of his photo sitting in the cold.'
      + LineFeed + LineFeed +
      'This game has been created for the Global Game Jam 21. Its source are available on globalgamejam.org website and on a GitHub repository.'
      + LineFeed + LineFeed +
      'The program itself is available on https://gamolf.itch.io/' + LineFeed +
      LineFeed +
      'Developped in Delphi with FireMonkey framework by Patrick Prémartin from developpeur-pascal.fr'
      + LineFeed + LineFeed +
      'Music by Johan Brodd (Jobromedia) from https://opengameart.org/content/a-winter-tale '
      + LineFeed + LineFeed +
      'Background image and cartoons charaters by Kenney from https://kenney.nl/'
      + LineFeed + LineFeed +
      'Button icons by Google and Austin Andrews (Templarian) from https://materialdesignicons.com/';
  end;
  result := frmSceneCredit;
end;

end.
