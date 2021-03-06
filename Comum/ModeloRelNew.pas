unit ModeloRelNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uModelBase, ExtCtrls, ActnList, ImgList, StdCtrls, Buttons, DBCtrls,
  Menus, uDireitos,  System.Actions, FireDAC.Comp.Client, uSeek;

type
  TfrmModeloRelNew = class(TfrmModelBase)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnImprimir: TBitBtn;
    btnFechar: TBitBtn;
    ActionList1: TActionList;
    ImageList1: TImageList;
    acImprimir: TAction;
    acFechar: TAction;
    acLocalizar: TAction;
    PopupMenu1: TPopupMenu;
    Localizar1: TMenuItem;
    procedure acFecharExecute(Sender: TObject);
    procedure acImprimirExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure acLocalizarExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    FConnection: TFDConnection;
    FTipo: string;
    FCodigo: string;
    FDireitos: TDireitos;
    FNomeTabela: string;
    FSeek: TSeek;
    procedure ClicaAutomatico; virtual;
    procedure doImprimir; virtual;
    procedure doFechar; virtual;
    procedure doLocalizar; virtual;
  public
    { Public declarations }
    constructor Create(AOwer: TComponent; Tipo: string; Codigo: Variant); overload; virtual;
  end;

var
  frmModeloRelNew: TfrmModeloRelNew;

implementation

uses Funcoes, uUsuario, uLocalizar;

{$R *.dfm}

procedure TfrmModeloRelNew.acFecharExecute(Sender: TObject);
begin
  doFechar;
end;

procedure TfrmModeloRelNew.acImprimirExecute(Sender: TObject);
begin
  doImprimir;
end;

procedure TfrmModeloRelNew.acLocalizarExecute(Sender: TObject);
begin
  doLocalizar;
end;

procedure TfrmModeloRelNew.ClicaAutomatico;
begin

end;

constructor TfrmModeloRelNew.Create(AOwer: TComponent; Tipo: string;
  Codigo: Variant);
begin
  inherited Create(AOwer);
  FTipo        := Tipo;
  FCodigo      := Codigo;
end;

procedure TfrmModeloRelNew.doFechar;
begin
  Close;
end;
           
procedure TfrmModeloRelNew.doImprimir;
begin

end;

procedure TfrmModeloRelNew.doLocalizar;
begin
  if (ActiveControl is TDBEdit) then
    (ActiveControl as TDBEdit).Field.asString := TLocalizar.Busca((ActiveControl as TDBEdit).Field.FieldName)
  else if (ActiveControl is TEdit) then
    (ActiveControl as TEdit).Text := TLocalizar.Busca((ActiveControl as TEdit).Name );
end;

procedure TfrmModeloRelNew.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FSeek);
  FreeAndNil(FDireitos);
  inherited;

end;

procedure TfrmModeloRelNew.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key of
    #13: Perform(Wm_NextDlgCtl, 0, 0);
    #38: Perform(Wm_NextDlgCtl, 1, 0);
    #27: acFechar.Execute;
  end;
  if Key in [#13,#27,#38] then key := #0;
end;

procedure TfrmModeloRelNew.FormShow(Sender: TObject);
begin
  {
  FConnection := DC.;
  FNomeTabela := '';
  }
  FDireitos := TDireitos.Create(FNomeTabela, TUsuario.GetInstance.Login , TUsuario.GetInstance.Perfil, FConnection);
  Caption   := FDireitos.Descricao;
  btnImprimir.Left := round((Sender as TForm).Width/3)-round(btnImprimir.Width/2);
  btnFechar.Left := btnImprimir.Left+round((Sender as TForm).Width/3);
  FSeek         := TSeek.Create(nil,FConnection, False);
  ClicaAutomatico;
end;

end.
