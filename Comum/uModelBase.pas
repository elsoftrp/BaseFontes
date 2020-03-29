unit uModelBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormBaseDac ;

type
  TfrmModelBase = class(TFormBaseDac)
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    FNomeJanela: string;
  end;

var
  frmModelBase: TfrmModelBase;

implementation

{$R *.dfm}

procedure TfrmModelBase.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    #13: Perform(Wm_NextDlgCtl, 0, 0);
  end;
  if Key in [#13] then key := #0;
end;

end.
