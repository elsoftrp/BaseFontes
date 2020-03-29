unit RelVendas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ModeloRelNew, Menus, ImgList, ActnList, StdCtrls, Buttons, ExtCtrls,
  Mask, System.Actions, uLib, uLoadFileIni, JvExMask, JvToolEdit;

type
  TfrmRelVendas = class(TfrmModeloRelNew)
    rgTipo: TRadioGroup;
    DataIni: TJvDateEdit;
    DataFim: TJvDateEdit;
    Label3: TLabel;
    Bevel2: TBevel;
    lblcliente: TLabel;
    CodCli: TEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    lblProduto: TLabel;
    CodPro: TEdit;
    procedure FormShow(Sender: TObject);
    procedure CodCliExit(Sender: TObject);
    procedure CodProExit(Sender: TObject);
  private
    { Private declarations }
    procedure VendasResumido;
    procedure VendasDetalhado;
    procedure VendasProdutos;
  public
    { Public declarations }
  protected
    procedure doImprimir; override;
  end;

var
  frmRelVendas: TfrmRelVendas;

implementation

uses DataModulo, Funcoes, DataReport;

{$R *.dfm}

procedure TfrmRelVendas.CodCliExit(Sender: TObject);
begin
  if (btnFechar.Focused) then exit;
  if (Sender as TEdit).Text = '' then begin lblcliente.Caption :=''; Exit; end;
  if not FSeek.Seek('Clientes',1,['CodCli'],[(Sender as TEdit).Text]) then
  begin
    TLib.Mensagem('Aviso','Cliente não encontrado.','E');
    (Sender as TEdit).SetFocus;
    exit;
  end;
  lblcliente.Caption   := FSeek.Qry.FieldByName('nomcli').asString;
end;

procedure TfrmRelVendas.CodProExit(Sender: TObject);
begin
  if (btnFechar.Focused) then exit;
  if (Sender as TEdit).Text = '' then begin lblProduto.Caption :=''; Exit; end;
  if not FSeek.Seek('Produtos',1,['Codpro'],[(Sender as TEdit).Text]) then
  begin
    TLib.Mensagem('Aviso','Produto não encontrado.','E');
    (Sender as TEdit).SetFocus;
    exit;
  end;
  lblProduto.Caption   := FSeek.Qry.FieldByName('despro').asString;
end;

procedure TfrmRelVendas.doImprimir;
var
  vsSql : string;
begin
  if DataIni.Text = '  /  /    ' then
  begin
    tlib.Mensagem('Aviso','Digite a Data Inicial.','!');
    DataIni.SetFocus;
    exit;
  end;
  if DataFim.Text = '  /  /    ' then
  begin
    tlib.Mensagem('Aviso','Digite a Data Final.','!');
    DataFim.SetFocus;
    exit;
  end;
  if rgTipo.ItemIndex = 0 then
  begin
    VendasResumido;
  end;
  if rgTipo.ItemIndex = 1 then
  begin
    VendasDetalhado;
  end;
  if rgTipo.ItemIndex = 2 then
  begin
    VendasProdutos;
  end;
end;

procedure TfrmRelVendas.FormShow(Sender: TObject);
begin
  FConnection := DM.Database;
  FNomeTabela := 'RelVendas';
  inherited;

end;

procedure TfrmRelVendas.VendasDetalhado;
var
  vsSql: string;
begin
  with DMReport do
  begin
    try
      vsSql := 'select p.*, c.nomcli, i.*, pr.despro '+
              'from pedidos p left outer join pedidositens i on i.codpedido=p.codpedido '+
              'left outer join produtos pr on pr.codpro=i.codpro '+
              'left outer join clientes c on c.codcli=p.codcli '+
              'where 1=1 ';

      vsSql := vsSql+'and p.data >=:DataIni and p.data <=:DataFim ';
      if CodCli.Text <> '' then
        vsSql := vsSql+'and p.codcli =:codcli ';
      if CodPro.Text <> '' then
        vsSql := vsSql+'and i.codpro =:codpro ';
      vsSql := vsSql+'order by p.codpedido, i.seq ';
      SQLVendasDetalhado.Close;
      SQLVendasDetalhado.SQL.Clear;
      SQLVendasDetalhado.SQL.Add(vsSql);

      SQLVendasDetalhado.ParamByName('DataIni').asDateTime := DataIni.Date;
      SQLVendasDetalhado.ParamByName('DataFim').asDateTime := DataFim.Date;
      if CodCli.Text <> '' then
        SQLVendasDetalhado.ParamByName('codcli').AsInteger := StrToInt(CodCli.Text);
      if CodPro.Text <> '' then
        SQLVendasDetalhado.ParamByName('codpro').AsInteger := StrToInt(codpro.Text);
      SQLVendasDetalhado.Open;
      frxReport1.LoadFromFile(TLoadFileIni.GetInstance.PathRelat+'\frRelVendasDetalhado.fr3');
      frxReport1.Variables.Clear;
      frxReport1.Variables['Dataini'] := QuotedStr(Dataini.Text);
      frxReport1.Variables['Datafim'] := QuotedStr(Datafim.Text);
      frxReport1.ShowReport();
    finally
      SQLVendasDetalhado.Close;
    end;
  end;
end;

procedure TfrmRelVendas.VendasProdutos;
var
  vsSql: string;
begin
  with DMReport do
  begin
    try
      vsSql := 'select i.codpro, max(pr.despro) as despro, sum(i.quantidade) as qdetotal, '+
              'avg(i.prvenda-i.desconto) as Mediavenda, avg(i.prcompra) as mediacusto, '+
              'sum((i.prvenda-i.desconto)*i.quantidade) as totvenda, sum(i.quantidade*i.prcompra) as totcusto '+
              'from pedidos p left outer join pedidositens i on i.codpedido=p.codpedido '+
              'left outer join produtos pr on pr.codpro=i.codpro '+
              'where 1=1 ';

      vsSql := vsSql+'and p.data >=:DataIni and p.data <=:DataFim ';
      if CodCli.Text <> '' then
        vsSql := vsSql+'and p.codcli =:codcli ';
      if CodPro.Text <> '' then
        vsSql := vsSql+'and i.codpro =:codpro ';
      vsSql := vsSql+'group by i.codpro order by qdetotal desc, despro ';
      SQLVendasProdutos.Close;
      SQLVendasProdutos.SQL.Clear;
      SQLVendasProdutos.SQL.Add(vsSql);

      SQLVendasProdutos.ParamByName('DataIni').asDateTime := DataIni.Date;
      SQLVendasProdutos.ParamByName('DataFim').asDateTime := DataFim.Date;
      if CodCli.Text <> '' then
        SQLVendasProdutos.ParamByName('codcli').AsInteger := StrToInt(CodCli.Text);
      if CodPro.Text <> '' then
        SQLVendasProdutos.ParamByName('codpro').AsInteger := StrToInt(codpro.Text);
      SQLVendasProdutos.Open;
      frxReport1.LoadFromFile(TLoadFileIni.GetInstance.PathRelat+'\frRelVendasProdutos.fr3');
      frxReport1.Variables.Clear;
      frxReport1.Variables['Dataini'] := QuotedStr(Dataini.Text);
      frxReport1.Variables['Datafim'] := QuotedStr(Datafim.Text);
      frxReport1.ShowReport();
    finally
      SQLVendasProdutos.Close;
    end;
  end;
end;

procedure TfrmRelVendas.VendasResumido;
var
  vsSql: string;
begin
  with DMReport do
  begin
    try
      vsSql := 'select p.*, c.nomcli from pedidos p left outer join clientes c on c.codcli=p.codcli  '+
               'where 1=1 ';

      vsSql := vsSql+'and p.data >=:DataIni and p.data <=:DataFim ';
      if CodCli.Text <> '' then
        vsSql := vsSql+'and p.codcli =:codcli ';
      vsSql := vsSql+'order by p.codpedido ';
      SQLVendasResumido.Close;
      SQLVendasResumido.SQL.Clear;
      SQLVendasResumido.SQL.Add(vsSql);

      SQLVendasResumido.ParamByName('DataIni').asDateTime := DataIni.Date;
      SQLVendasResumido.ParamByName('DataFim').asDateTime := DataFim.Date;
      if CodCli.Text <> '' then
        SQLVendasResumido.ParamByName('codcli').AsInteger := StrToInt(CodCli.Text);
      SQLVendasResumido.Open;
      frxReport1.LoadFromFile(TLoadFileIni.GetInstance.PathRelat+'\frRelVendasResumido.fr3');
      frxReport1.Variables.Clear;
      frxReport1.Variables['Dataini'] := QuotedStr(Dataini.Text);
      frxReport1.Variables['Datafim'] := QuotedStr(Datafim.Text);
      frxReport1.ShowReport();
    finally
      SQLVendasResumido.Close;
    end;
  end;
end;

end.
