unit EscolheLote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uLib,
  Dialogs, uModelBase, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DBCtrls, DB;

type
  TfrmEscolheLote = class(TfrmModelBase)
    pnlBottom: TPanel;
    pnlMain: TPanel;
    BtnOk: TBitBtn;
    BtnCancelar: TBitBtn;
    DBGrid1: TDBGrid;
    Bevel1: TBevel;
    DBText1: TDBText;
    Bevel2: TBevel;
    DBText2: TDBText;
    DataSource1: TDataSource;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    FCodigo: Integer;
    { Private declarations }
  public
    constructor Create(AOwer: TComponent; Codigo: Variant);
    { Public declarations }
  end;

var
  frmEscolheLote: TfrmEscolheLote;

implementation

uses DataModulo;

{$R *.dfm}

{ TfrmEscolheLote }

procedure TfrmEscolheLote.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEscolheLote.BtnOkClick(Sender: TObject);
begin
  if not DBGrid1.DataSource.DataSet.IsEmpty then
  begin
    ModalResult := mrOk;
  end;
end;

constructor TfrmEscolheLote.Create(AOwer: TComponent; Codigo: Variant);
begin
  inherited Create(AOwer);
  FCodigo      := Codigo;
end;

procedure TfrmEscolheLote.DBGrid1DblClick(Sender: TObject);
begin
  BtnOk.Click;
end;

procedure TfrmEscolheLote.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key of
    #13: Perform(Wm_NextDlgCtl, 0, 0);
    #27:btnCancelar.Click;
  end;
  if Key in [#27,#38,#13] then key := #0;
end;

end.
