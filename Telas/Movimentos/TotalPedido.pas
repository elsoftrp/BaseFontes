unit TotalPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, uFormBaseDac, DB, Mask, DBCtrls,
  Menus, uSeek, JvExMask, JvToolEdit, JvDBControls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, ulib, uLocalizar;

type
  TfrmTotalPedido = class(TFormBaseDac)
    pnl: TPanel;
    pnlbottom: TPanel;
    BtnOk: TBitBtn;
    BtnCancelar: TBitBtn;
    Label1: TLabel;
    dinheiro: TDBEdit;
    DataSource1: TDataSource;
    Label2: TLabel;
    cartao: TDBEdit;
    Label3: TLabel;
    codcartao: TDBEdit;
    Label4: TLabel;
    vale: TDBEdit;
    Label5: TLabel;
    nrovale: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Bevel1: TBevel;
    DBText1: TDBText;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBText2: TDBText;
    Bevel2: TBevel;
    PopupMenu1: TPopupMenu;
    Localizar1: TMenuItem;
    datavale: TJvDBDateEdit;
    Label9: TLabel;
    desconto: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnCancelarClick(Sender: TObject);
    procedure dinheiroExit(Sender: TObject);
    procedure cartaoExit(Sender: TObject);
    procedure valeExit(Sender: TObject);
    procedure Localizar1Click(Sender: TObject);
    procedure codcartaoExit(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure nrovaleExit(Sender: TObject);
    procedure datavaleExit(Sender: TObject);
    procedure descontoExit(Sender: TObject);
    procedure descontoEnter(Sender: TObject);
  private
    { Private declarations }
    FForma: string;
    seek : TSeek;
    vQueryDac, vQueryI: TFDQuery;
    function SomaValores: Currency;
    procedure AtualizaValores;
    function ConsultaCreditoVale(codigo: Integer; data: TDateTime; valor: Currency; out mensagem: string): Boolean;
    procedure HabilitaDesabilitaCartao;
    procedure Atualiza_Desconto;
  protected
    procedure doConfigureForm(); override;
  public
    constructor Create(AOwer: TComponent; Forma: string); overload; virtual;
    { Public declarations }
  end;

var
  frmTotalPedido: TfrmTotalPedido;

implementation

uses Funcoes, DataModulo;

{$R *.dfm}

{ TfrmTotalPedido }

procedure TfrmTotalPedido.AtualizaValores;
var
  vdSoma: Currency;
begin
  vdSoma := 0;
  vdSoma := SomaValores;
  if vdSoma > vQueryDac.FieldByName('Total').AsCurrency then
  begin
    vQueryDac.FieldByName('Troco').AsCurrency := (vdSoma - vQueryDac.FieldByName('Total').AsCurrency );
  end
  else
  begin
    vQueryDac.FieldByName('Troco').AsCurrency := 0;
  end;
end;

function TfrmTotalPedido.SomaValores: Currency;
begin
  Result := vQueryDac.FieldByName('Dinheiro').AsCurrency + vQueryDac.FieldByName('Cartao').AsCurrency + vQueryDac.FieldByName('Vale').AsCurrency;
end;

procedure TfrmTotalPedido.Atualiza_Desconto;
begin
  vQueryDac.FieldByName('Total').AsCurrency := (vQueryDac.FieldByName('Total').AsCurrency-vQueryDac.FieldByName('Desconto').AsCurrency); 
end;

procedure TfrmTotalPedido.valeExit(Sender: TObject);
begin
  AtualizaValores;
end;

procedure TfrmTotalPedido.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTotalPedido.BtnOkClick(Sender: TObject);
var
  vsMensagem: string;
begin
  if vQueryDac.FieldByName('Vale').AsCurrency > 0 then
  begin
    if vQueryDac.FieldByName('codvale').AsString = '' then
    begin
      tlib.Mensagem('Aviso','Precisa ser informado o n�mero do vale.','!');
      nrovale.SetFocus;
      Exit;
    end;
    if vQueryDac.FieldByName('datavale').AsString = '' then
    begin
      tlib.Mensagem('Aviso','Precisa ser informado a data do vale.','!');
      datavale.SetFocus;
      Exit;
    end;
    if not ConsultaCreditoVale(vQueryDac.FieldByName('codvale').AsInteger,
              vQueryDac.FieldByName('datavale').AsDateTime,
              vQueryDac.FieldByName('vale').AsCurrency, vsMensagem ) then
    begin
      tlib.Mensagem('Aviso',vsMensagem,'!');
      vale.SetFocus;
      Exit;
    end;
  end;
  if vQueryDac.FieldByName('ValRestante').AsCurrency > 0 then
  begin
    tlib.Mensagem('Aviso','Precisa ser informado valores para pagamento.','!');
    dinheiro.SetFocus;
    Exit;
  end;
  ModalResult := mrOk;
end;

procedure TfrmTotalPedido.cartaoExit(Sender: TObject);
begin
  AtualizaValores;
end;

procedure TfrmTotalPedido.codcartaoExit(Sender: TObject);
begin
  if (btnCancelar.Focused) then exit;
  if cartao.Focused then Exit;
  if ((Sender as TDBEdit).Text = '') and (vQueryDac.FieldByName('cartao').AsCurrency = 0) then Exit;
  if ((Sender as TDBEdit).Text = '') and (vQueryDac.FieldByName('cartao').AsCurrency > 0) then
  begin
    tlib.Mensagem('Aviso','Operadora tem que ser informada.','!');
    codcartao.SetFocus;
    exit;
  end;
  seek := TSeek.Create(nil, DM.Database, False);
  try
    if not seek.Seek('CartaoCredito',1,['CodCartao'],[(Sender as TDBEdit).Text]) then
    begin
      ShowMessage('Aviso, Cart�o n�o encontrado!');
      (Sender as TDBEdit).SetFocus;
      exit;
    end;
    vQuerydac.FieldbyName('DesCartao').asString := seek.Qry.FieldByName('descartao').asString;
  finally
    FreeAndNil(seek);
  end;
end;

function TfrmTotalPedido.ConsultaCreditoVale(codigo: Integer; data: TDateTime; valor: Currency; out mensagem: string): Boolean;
var
  qry: TFDQuery;
begin
  Result := True;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := DM.DataBase;
    qry.SQL.clear;
    qry.SQL.Add('select * from peddevolucao where codpeddevolucao =:codpeddevolucao and data =:data');
    qry.ParamByName('data').AsDateTime := data;
    qry.ParamByName('codpeddevolucao').AsInteger := codigo;
    qry.Open;
    if qry.IsEmpty then
    begin
      mensagem := 'N�o existe devolu��o com este n�mero e data.';
      Result := False;
      Exit;
    end;
    if (qry.FieldByName('usado').AsCurrency >= qry.FieldByName('total').AsCurrency) then
    begin
      mensagem := 'Cr�dito total j� usado deste vale.';
      Result := False;
      Exit;
    end;
    if valor > (qry.FieldByName('total').AsCurrency-qry.FieldByName('usado').AsCurrency) then
    begin
      mensagem := 'Valor digitado � maior que o valor do vale.';
      Result := False;
      Exit;
    end;

  finally
    qry.Close;
    FreeAndNil(qry);
  end;
end;

constructor TfrmTotalPedido.Create(AOwer: TComponent; Forma: string);
begin
  inherited Create(AOwer);
  FForma       := Forma;
end;

procedure TfrmTotalPedido.dinheiroExit(Sender: TObject);
begin
  AtualizaValores;
end;

procedure TfrmTotalPedido.doConfigureForm;
begin
  //inherited;
end;

procedure TfrmTotalPedido.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    #13: Perform(Wm_NextDlgCtl, 0, 0);
    #27: btnCancelar.click;
  end;
  if Key in [#13] then key := #0;
end;

procedure TfrmTotalPedido.FormShow(Sender: TObject);
begin
  vQueryDac := DM.SQLPedidos;
  vQueryI   := DM.SQLItensPedidos;
  dinheiro.SetFocus;
  HabilitaDesabilitaCartao;
end;

procedure TfrmTotalPedido.HabilitaDesabilitaCartao;
var
  situacao: Boolean;
begin
  situacao := (FForma = 'V');
  vQueryDac.FieldByName('cartao').AsCurrency := 0;
  vQueryDac.FieldByName('codcartao').Value := Null;
  label2.Visible    := situacao;
  cartao.Visible    := situacao;
  Label3.Visible    := situacao;
  codcartao.Visible := situacao;
  DBText1.Visible   := situacao;
  Bevel1.Visible    := situacao;
end;

procedure TfrmTotalPedido.datavaleExit(Sender: TObject);
var
  vsMensagem: string;
begin
  if (btnCancelar.Focused) then exit;
  if nrovale.Focused then Exit;
  if vale.Focused then Exit;  
  if (nrovale.Text = '') and (vQueryDac.FieldByName('vale').AsCurrency = 0) then Exit;
  if (nrovale.Text <> '') and (vQueryDac.FieldByName('vale').AsCurrency = 0) then
  begin
    tlib.Mensagem('Aviso','Valor do vale tem que ser informado.','!');
    vale.SetFocus;
    nrovale.Text := '';
    exit;
  end;
  if (nrovale.Text = '') and (vQueryDac.FieldByName('vale').AsCurrency > 0) then
  begin
    tlib.Mensagem('Aviso','N� do vale tem que ser informado.','!');
    nrovale.SetFocus;
    Exit;
  end;
  if vQueryDac.FieldByName('datavale').AsString = '' then
  begin
    tlib.Mensagem('Aviso','Data do vale tem que ser informado.','!');
    datavale.SetFocus;
    Exit;
  end;
  if not ConsultaCreditoVale(vQueryDac.FieldByName('codvale').AsInteger,
        vQueryDac.FieldByName('datavale').AsDateTime,
        vQueryDac.FieldByName('vale').AsCurrency, vsMensagem ) then
  begin
    tlib.Mensagem('Aviso',vsMensagem,'!');
    vale.SetFocus;
    Exit;
  end;
end;

procedure TfrmTotalPedido.descontoEnter(Sender: TObject);
begin
  vQueryDac.FieldByName('Total').AsCurrency := vQueryDac.FieldByName('TotPro').AsCurrency;
end;

procedure TfrmTotalPedido.descontoExit(Sender: TObject);
begin
  if (vQueryDac.FieldByName('Desconto').AsCurrency > 0.99) then
  begin
    tlib.Mensagem('Aviso','Desconto excedido!','!');
    desconto.SetFocus;
    Exit;
  end;
  Atualiza_Desconto;
end;

procedure TfrmTotalPedido.Localizar1Click(Sender: TObject);
begin
  try
    if (ActiveControl is TDBEdit) then
      (ActiveControl as TDBEdit).Field.asString := TLocalizar.Busca((ActiveControl as TDBEdit).Field.FieldName);
  except
    ShowMessage('Consulta n�o foi localizada !');
  end;
end;

procedure TfrmTotalPedido.nrovaleExit(Sender: TObject);
begin
  if (btnCancelar.Focused) then exit;
  if ((Sender as TDBEdit).Text = '') and (vQueryDac.FieldByName('vale').AsCurrency = 0) then Exit;
  if ((Sender as TDBEdit).Text <> '') and (vQueryDac.FieldByName('vale').AsCurrency = 0) then
  begin
    tlib.Mensagem('Aviso','Valor do vale tem que ser informado.','!');
    vale.SetFocus;
    nrovale.Text := '';
    exit;
  end;
  if ((Sender as TDBEdit).Text = '') and (vQueryDac.FieldByName('vale').AsCurrency > 0) then
  begin
    tlib.Mensagem('Aviso','N� Vale tem que ser informado.','!');
    nrovale.SetFocus;
    exit;
  end;
end;

end.
