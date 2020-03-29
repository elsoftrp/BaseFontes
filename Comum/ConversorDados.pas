unit ConversorDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ModeloRelNew, Vcl.Menus,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Comp.Client, Vcl.Samples.Gauges;

type
  TfrmConversorDados = class(TfrmModeloRelNew)
    Button1: TButton;
    Gauge1: TGauge;
    lblcodigo: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    btnFornecedores: TButton;
    btnLaboratorios: TBitBtn;
    btnProdutos: TBitBtn;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btnFornecedoresClick(Sender: TObject);
    procedure btnLaboratoriosClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    uDest, uOrig: TFDQuery;
    procedure camposclientes;
    function cidade_codigo(nome_cidade, estado: string): Integer;
    procedure camposContatoclientes;
    procedure campostransportadoras;
    procedure camposcidades;
    procedure camposFornecedores;
    function codigo_Laboratorio(valor: string): Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConversorDados: TfrmConversorDados;

implementation

{$R *.dfm}

uses DataModuloR, uLib;

procedure TfrmConversorDados.btnFornecedoresClick(Sender: TObject);
var xOrig,xDest:String;
    x:Integer;
begin
  xorig := 'select * from Cliente where xarope ='+QuotedStr('F');
  xdest := 'select * from Fornecedores ';
  uOrig := DMR.qrOrigem;
  uDest := DMR.qrDestino;
  uOrig.SQL.Clear;
  uDest.Sql.Clear;
  uOrig.Sql.add(xorig);
  uDest.sql.add(xdest);
  uDest.open;
  uOrig.open;
  gauge1.Progress := 0;
  gauge1.MaxValue := uOrig.RecordCount;
  uOrig.first;
  uOrig.DisableControls;
  x:=1;
  uDest.Close;
  uDest.Open;
  while not uOrig.eof do
  begin
    lblcodigo.caption := uOrig.FieldByName('CodigoCLiente').asString;
    uDest.Append;
    camposfornecedores;
    uDest.Post;
    uOrig.Next;
    x := x+1;
    gauge1.progress := gauge1.Progress+1;
  end;
  uOrig.enableControls;
  uOrig.close;
  uDest.close;
  showmessage('Concluido Fornecedores');
end;

procedure TfrmConversorDados.btnLaboratoriosClick(Sender: TObject);
var xOrig,xDest:String;
    x:Integer;
begin
  xorig := 'select nomedogrupo from estoque group by nomedogrupo order by nomedogrupo ';
  xdest := 'select * from laboratorios ';
  uOrig := DMR.qrOrigem;
  uDest := DMR.qrDestino;
  uOrig.SQL.Clear;
  uDest.Sql.Clear;
  uOrig.Sql.add(xorig);
  uDest.sql.add(xdest);
  uDest.open;
  uOrig.open;
  gauge1.Progress := 0;
  gauge1.MaxValue := uOrig.RecordCount;
  uOrig.first;
  uOrig.DisableControls;
  x:=1;
  uDest.Close;
  uDest.Open;
  while not uOrig.eof do
  begin
    lblcodigo.caption := uOrig.FieldByName('nomedogrupo').asString;
    uDest.Append;
    //
    uDest.FieldByName('codlab').AsInteger := x;
    uDest.FieldByName('nomlab').AsString  := uOrig.FieldByName('nomedogrupo').AsString;
    //
    uDest.Post;
    uOrig.Next;
    x := x+1;
    gauge1.progress := gauge1.Progress+1;
  end;
  uOrig.enableControls;
  uOrig.close;
  uDest.close;
  showmessage('Concluido laboratorios');
end;

procedure TfrmConversorDados.btnProdutosClick(Sender: TObject);
var xOrig,xDest:String;
    x,viCod:Integer;
begin
  xorig := 'select * from estoque order by codigofinal ';
  xdest := 'select * from produtos ';
  uOrig := DMR.qrOrigem;
  uDest := DMR.qrDestino;
  uOrig.SQL.Clear;
  uDest.Sql.Clear;
  uOrig.Sql.add(xorig);
  uDest.sql.add(xdest);
  uDest.open;
  uOrig.open;
  gauge1.Progress := 0;
  gauge1.MaxValue := uOrig.RecordCount;
  uOrig.first;
  uOrig.DisableControls;
  x:=1;
  uDest.Close;
  uDest.Open;
  while not uOrig.eof do
  begin
    lblcodigo.caption := uOrig.FieldByName('codigofinal').asString;
    uDest.Append;
    //
    uDest.FieldByName('codpro').AsInteger    := uOrig.FieldByName('codigofinal').AsInteger;
    uDest.FieldByName('despro').AsString     := uOrig.FieldByName('nome').AsString;
    uDest.FieldByName('venda').AsCurrency    := uOrig.FieldByName('venda').AsCurrency;
    uDest.FieldByName('obs').AsString        := uOrig.FieldByName('observacoes').AsString;
    uDest.FieldByName('aplicacao').AsString  := uOrig.FieldByName('aplicacao').AsString;
    uDest.FieldByName('principioativo').AsString  := uOrig.FieldByName('principioativo1').AsString;
    uDest.FieldByName('barras').AsString     := uOrig.FieldByName('barras').AsString;
    uDest.FieldByName('status').AsString     := Copy(uOrig.FieldByName('status').AsString,1,1);

    viCod := codigo_Laboratorio( uOrig.FieldByName('nomedogrupo').AsString );
    if viCod <> 0 then
    begin
      uDest.FieldByName('codlab').AsInteger    := viCod;
    end;
    //
    uDest.Post;
    uOrig.Next;
    x := x+1;
    gauge1.progress := gauge1.Progress+1;
  end;
  uOrig.enableControls;
  uOrig.close;
  uDest.close;
  showmessage('Concluido laboratorios');
end;

function TfrmConversorDados.codigo_Laboratorio(valor: string):Integer;
begin
  Result := 0;
  if valor <> '' then
  begin
    try
      DMR.SQLLaboratorios.Close;
      DMR.SQLLaboratorios.ParamByName('nomlab').AsString := valor;
      DMR.SQLLaboratorios.Open;
      if not DMR.SQLLaboratorios.IsEmpty then
      begin
        Result:= DMR.SQLLaboratorios.FieldByName('codlab').AsInteger;
      end;
    finally
      DMR.SQLLaboratorios.Close;
    end;
  end;
end;

procedure TfrmConversorDados.Button1Click(Sender: TObject);
var xOrig,xDest:String;
    x:Integer;
begin
  xorig := 'select * from Cliente where xarope ='+QuotedStr('C');
  xdest := 'select * from Clientes ';
  uOrig := DMR.qrOrigem;
  uDest := DMR.qrDestino;
  uOrig.SQL.Clear;
  uDest.Sql.Clear;
  uOrig.Sql.add(xorig);
  uDest.sql.add(xdest);
  uDest.open;
  uOrig.open;
  gauge1.Progress := 0;
  gauge1.MaxValue := uOrig.RecordCount;
  uOrig.first;
  uOrig.DisableControls;
  x:=1;
  uDest.Close;
  uDest.Open;
  while not uOrig.eof do
  begin
    lblcodigo.caption := uOrig.FieldByName('CodigoCliente').asString;
    uDest.Append;
    camposclientes;
    uDest.Post;
    uOrig.Next;
    x := x+1;
    gauge1.progress := gauge1.Progress+1;
  end;
  uOrig.enableControls;
  uOrig.close;
  uDest.close;
  showmessage('Concluido clientes');
end;

procedure TfrmConversorDados.Button2Click(Sender: TObject);
begin
dmr.qrOrigemContato.Close;
dmr.qrDestinoContato.Close;
dmr.qrOrigemContato.open;
dmr.qrOrigemContato.first;
while not dmr.qrOrigemContato.eof do
 begin
 lblcodigo.Caption := dmr.qrOrigemContato.FieldByName('ligacao').AsString;
 dmr.qrDestinoContato.Close;
 dmr.qrDestinoContato.ParamByName('CodCliente').AsString := dmr.qrOrigemContato.FieldByName('ligacao').AsString;
 dmr.qrDestinoContato.open;
   if dmr.qrDestinoContato.IsEmpty then
     begin
     dmr.qrOrigemContato.Next;
     end
   else
     begin
     dmr.qrDestinoContato.Edit;
     dmr.qrDestinoContato.FieldByName('Contato').AsString := dmr.qrOrigemContato.FieldByName('Nome').AsString;
     dmr.qrDestinoContato.Append;
     dmr.qrOrigemContato.Next;
     end;



 end;
ShowMessage('Fim.');
end;

procedure TfrmConversorDados.Button3Click(Sender: TObject);
var xOrig,xDest:String;
    x:Integer;
begin
  xorig := 'select * from Transp';
  xdest := 'select * from Transportadoras';
  uOrig := DMR.qrOrigem;
  uDest := DMR.qrDestino;
  uOrig.SQL.Clear;
  uDest.Sql.Clear;
  uOrig.Sql.add(xorig);
  uDest.sql.add(xdest);
  uDest.open;
  uOrig.open;
  gauge1.Progress := 0;
  gauge1.MaxValue := uOrig.RecordCount;
  uOrig.first;
  uOrig.DisableControls;
  x:=1;
  uDest.Close;
  uDest.Open;
  while not uOrig.eof do
  begin
    lblcodigo.caption := uOrig.FieldByName('CodigoTransportadora').asString;
    uDest.Append;
    camposTransportadoras;
    uDest.Post;
    uOrig.Next;
    x := x+1;
    gauge1.progress := gauge1.Progress+1;
  end;
  uOrig.enableControls;
  uOrig.close;
  uDest.close;
  showmessage('Concluido Transportadora');
end;

procedure TfrmConversorDados.Button4Click(Sender: TObject);
var xOrig,xDest:String;
    x:Integer;
begin
  xorig := 'select * from CidadesIbge3';
  xdest := 'select * from Cidades';
  uOrig := DMR.qrOrigem;
  uDest := DMR.qrDestino;
  uOrig.SQL.Clear;
  uDest.Sql.Clear;
  uOrig.Sql.add(xorig);
  uDest.sql.add(xdest);
  uDest.open;
  uOrig.open;
  gauge1.Progress := 0;
  gauge1.MaxValue := uOrig.RecordCount;
  uOrig.first;
  uOrig.DisableControls;
  x:=1;
  uDest.Close;
  uDest.Open;
  while not uOrig.eof do
  begin
    lblcodigo.caption := uOrig.FieldByName('Codigo').asString;
    uDest.Append;
    camposCidades;
    uDest.Post;
    uOrig.Next;
    x := x+1;
    gauge1.progress := gauge1.Progress+1;
  end;
  uOrig.enableControls;
  uOrig.close;
  uDest.close;
  showmessage('Concluido Cidades');
end;



procedure TfrmConversorDados.Button5Click(Sender: TObject);
begin
dmr.qrOrigemContatoF.Close;
dmr.qrDestinoContatoF.Close;
dmr.qrOrigemContatoF.open;
dmr.qrOrigemContatoF.first;
while not dmr.qrOrigemContatoF.eof do
 begin
 lblcodigo.Caption := dmr.qrOrigemContatoF.FieldByName('ligacao').AsString;
 dmr.qrDestinoContatoF.Close;
 dmr.qrDestinoContatoF.ParamByName('CodFornecedor').AsString := dmr.qrOrigemContatoF.FieldByName('ligacao').AsString;
 dmr.qrDestinoContatoF.open;
   if dmr.qrDestinoContatoF.IsEmpty then
     begin
     dmr.qrOrigemContatoF.Next;
     end
   else
     begin
     dmr.qrDestinoContatoF.Edit;
     dmr.qrDestinoContatoF.FieldByName('Contato').AsString := dmr.qrOrigemContatoF.FieldByName('Nome').AsString;
     dmr.qrDestinoContatoF.Append;
     dmr.qrOrigemContatoF.Next;
     end;



 end;
ShowMessage('Fim.');
end;

procedure TfrmConversorDados.Button6Click(Sender: TObject);
var xOrig,xDest:String;
    x:Integer;
begin
  xorig := 'select * from produtosimagens order by ligacaoprodutos ';
  xdest := 'select * from prodfoto ';
  uOrig := DMR.qryImgOrig;
  uDest := DMR.qryImgDest;
  uOrig.SQL.Clear;
  uDest.Sql.Clear;
  uOrig.Sql.add(xorig);
  uDest.sql.add(xdest);
  uDest.open;
  uOrig.open;
  gauge1.Progress := 0;
  gauge1.MaxValue := uOrig.RecordCount;
  uOrig.first;
  uOrig.DisableControls;
  x:=1;
  uDest.Close;
  uDest.Open;
  while not uOrig.eof do
  begin
    lblcodigo.caption := uOrig.FieldByName('ligacaoprodutos').asString;
    uDest.Append;
    //
    uDest.FieldByName('codpro').AsInteger := uOrig.FieldByName('ligacaoprodutos').AsInteger ;
    uDest.FieldByName('seq').AsInteger    := 1;
    uDest.FieldByName('nomearquivo').AsString := uOrig.FieldByName('ligacaoprodutos').AsString+'.jpg';
    uDest.FieldByName('status').AsString := 'A';
    uDest.FieldByName('imagem').Value     := uOrig.FieldByName('imagemprincipal').Value;
    uDest.FieldByName('descricao').Value  := uOrig.FieldByName('descritivo').Value;
    //
    uDest.Post;
    uOrig.Next;
    x := x+1;
    gauge1.progress := gauge1.Progress+1;
  end;
  uOrig.enableControls;
  uOrig.close;
  uDest.close;
  showmessage('Concluido imagens ');

end;

procedure TfrmConversorDados.campostransportadoras;
begin
  uDest.Fieldbyname('CodTransp').asString        := trim( uOrig.FieldByName('CodigoTransportadora').asString);
  uDest.Fieldbyname('Nome').asString             := trim( uOrig.FieldByName('NomeFantasia').asString);
  uDest.Fieldbyname('Razao').asString            := trim( uOrig.FieldByName('Nome').asString);
  uDest.Fieldbyname('Status').asString           := trim( uOrig.FieldByName('Status').asString);
  uDest.Fieldbyname('Endereco').asString         := trim( uOrig.FieldByName('Ende').asString);
  uDest.Fieldbyname('Bairro').asString           := trim( uOrig.FieldByName('Bair').asString);
  uDest.Fieldbyname('email').asString            := trim( uOrig.FieldByName('email').asString);
  uDest.Fieldbyname('CodCidade').asString        := trim( uOrig.FieldByName('CodigoCidade').asString);
  uDest.Fieldbyname('Cep').asString              := trim( uOrig.FieldByName('Cep').asString);
  uDest.Fieldbyname('Telefone').asString         := trim( uOrig.FieldByName('Tele').asString);
  uDest.Fieldbyname('Telefone2').asString        := trim( uOrig.FieldByName('Tele1').asString);
  uDest.Fieldbyname('Contato').asString          := trim( uOrig.FieldByName('Cont').asString);
  uDest.Fieldbyname('IE').asString               := trim( uOrig.FieldByName('Insc').asString);
  uDest.Fieldbyname('CNPJ').asString             := trim( uOrig.FieldByName('CGC').asString);
  uDest.Fieldbyname('Obs').asString              := trim( uOrig.FieldByName('Observacoes').asString);
  uDest.Fieldbyname('FretePorc').asString        := trim( uOrig.FieldByName('ComissaoOutros').asString);
  uDest.Fieldbyname('FreteMinimo').asString      := trim( uOrig.FieldByName('FreteMinimo').asString);
  uDest.Fieldbyname('DataAtu').asString          := trim( uOrig.FieldByName('DataSincro').asString);
  uDest.Fieldbyname('HoraAtu').asString          := trim( uOrig.FieldByName('HoraSincro').asString);
end;

procedure TfrmConversorDados.camposclientes;
begin
  uDest.Fieldbyname('CodCliente').asString        := trim( uOrig.FieldByName('CodigoCliente').asString);
  uDest.Fieldbyname('CodRepresentante').asString  := trim( uOrig.FieldByName('CodigoVendedor').asString);
  uDest.Fieldbyname('DataAtu').asString           := trim( uOrig.FieldByName('DataSincro').asString);
  uDest.Fieldbyname('HoraAtu').asString           := trim( uOrig.FieldByName('HoraSincro').asString);
  uDest.Fieldbyname('CodTransp').asString         := trim( uOrig.FieldByName('CodigoTransportadora').asString);
  uDest.Fieldbyname('CodTransp2').asString        := trim( uOrig.FieldByName('CodigoTransportadora2').asString);
  uDest.Fieldbyname('Status').asString            := trim( uOrig.FieldByName('negativado').asString);   //colocar maiuscula
  if uOrig.FieldByName('Tipo').asString = 'C' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'CLINICA';
    end
  else if uOrig.FieldByName('Tipo').asString = 'F' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'PESSOA FISICA';
    end
  else if uOrig.FieldByName('Tipo').asString = 'J' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'PESSOA JURIDICA';
    end
  else if uOrig.FieldByName('Tipo').asString = 'P' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'PRODUTOR';
    end
    else if uOrig.FieldByName('Tipo').asString = 'E' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'ORGAO PUBLICO';
    end
    else if uOrig.FieldByName('Tipo').asString = 'N' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'NOVO PRODUTOR';
    end
    else if uOrig.FieldByName('Tipo').asString = 'V' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'VETERINARIO';
    end
    else if uOrig.FieldByName('Tipo').asString = 'D' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'ATIVIDADE <>';
    end;
  uDest.Fieldbyname('Banco').asString             := trim( uOrig.FieldByName('Banco').asString);
  uDest.Fieldbyname('Nome').asString              := trim( uOrig.FieldByName('NomeFantasia').asString);
  uDest.Fieldbyname('Razao').asString             := trim( uOrig.FieldByName('Nome').asString);
  uDest.Fieldbyname('Endereco').asString          := trim( uOrig.FieldByName('Ende').asString);
  uDest.Fieldbyname('Numero').asString            := trim( uOrig.FieldByName('EndeNumero').asString);
  uDest.Fieldbyname('Cep').asString               := trim( uOrig.FieldByName('Cep').asString);
  uDest.Fieldbyname('Bairro').asString            := trim( uOrig.FieldByName('Bair').asString);
  uDest.Fieldbyname('Cidade').asString            := trim( uOrig.FieldByName('Cida').asString);
  uDest.Fieldbyname('Estado').asString            := trim( uOrig.FieldByName('Esta').asString);
  uDest.Fieldbyname('Telefone1').asString         := trim( uOrig.FieldByName('Telefone1').asString);
  uDest.Fieldbyname('Telefone2').asString         := trim( uOrig.FieldByName('Telefone2').asString);
  uDest.Fieldbyname('Celular').asString           := trim( uOrig.FieldByName('Celular').asString);
  uDest.Fieldbyname('Fax').asString               := trim( uOrig.FieldByName('Fax').asString);
  uDest.Fieldbyname('email').asString             := trim( uOrig.FieldByName('email').asString);
  uDest.Fieldbyname('site').asString              := trim( uOrig.FieldByName('www').asString);
  if uOrig.FieldByName('Insc').asString <> '' then
    begin
    uDest.Fieldbyname('rgie').asString := trim(StringReplace(uOrig.FieldByName('Insc').asstring,'.','',[rfReplaceall]));
    end;
  if uOrig.FieldByName('Rg').asString <> '' then
    begin
    uDest.Fieldbyname('rgie').asString := trim(StringReplace(uOrig.FieldByName('rg').asstring,'.','',[rfReplaceall]));
    end;
  if uOrig.FieldByName('Cpf').asString <> '' then
    begin
    uDest.Fieldbyname('cpfcnpj').asString := trim(StringReplace(uOrig.FieldByName('cpf').asstring,'.','',[rfReplaceall]));
    end;
  if uOrig.FieldByName('cgc').asString <> '' then
    begin
    uDest.Fieldbyname('cpfcnpj').asstring := trim(StringReplace(uOrig.FieldByName('Cgc').asstring,'.','',[rfReplaceall]));
    end;
  uDest.Fieldbyname('Limite').asString            := trim( uOrig.FieldByName('Limite').asString);
  uDest.Fieldbyname('RefEntrega').asString        := trim( uOrig.FieldByName('ReferenciaEntrega').asString);
  uDest.Fieldbyname('Obs').asString                  := trim( uOrig.FieldByName('ObservacoesGerais').asString);
  uDest.Fieldbyname('EnderecoE').asString          := trim( uOrig.FieldByName('EndeEntrega').asString);
  uDest.Fieldbyname('NumeroE').asString          := trim( uOrig.FieldByName('EndeNumeroEntrega').asString);
  uDest.Fieldbyname('CepE').asString               := trim( uOrig.FieldByName('CepEntrega').asString);
  uDest.Fieldbyname('BairroE').asString            := trim( uOrig.FieldByName('BairEntrega').asString);
  uDest.Fieldbyname('CidadeE').asString            := trim( uOrig.FieldByName('CidaEntrega').asString);
  uDest.Fieldbyname('EstadoE').asString            := trim( uOrig.FieldByName('EstaEntrega').asString);
  uDest.Fieldbyname('CxPostal').asString             := trim( uOrig.FieldByName('cPosta').asString);
//  uDest.Fieldbyname('fantasia').asString      := trim( uOrig.FieldByName('esc_fantas').asString);
//  uDest.Fieldbyname('Endereco').asString      := trim(uOrig.FieldByName('esc_endere').asString);
//  uDest.Fieldbyname('Bairro').asString        := trim(uOrig.FieldByName('esc_bairro').asString);
//  uDest.Fieldbyname('Cep').asString           := trim(uOrig.FieldByName('esc_cep').asString);
//  uDest.Fieldbyname('CodCidade').asinteger    := cidade_codigo(uOrig.FieldByName('esc_cidade').asString, uOrig.FieldByName('esc_estado').asString);

end;

procedure TfrmConversorDados.camposFornecedores;
begin
  uDest.Fieldbyname('CodFornecedor').asString        := trim( uOrig.FieldByName('CodigoCliente').asString);
  uDest.Fieldbyname('CodRepresentante').asString  := trim( uOrig.FieldByName('CodigoVendedor').asString);
  uDest.Fieldbyname('DataAtu').asString           := trim( uOrig.FieldByName('DataSincro').asString);
  uDest.Fieldbyname('HoraAtu').asString           := trim( uOrig.FieldByName('HoraSincro').asString);
  uDest.Fieldbyname('CodTransp').asString         := trim( uOrig.FieldByName('CodigoTransportadora').asString);
  uDest.Fieldbyname('CodTransp2').asString        := trim( uOrig.FieldByName('CodigoTransportadora2').asString);
  uDest.Fieldbyname('Status').asString            := trim( uOrig.FieldByName('negativado').asString);   //colocar maiuscula
  if uOrig.FieldByName('Tipo').asString = 'C' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'CLINICA';
    end
  else if uOrig.FieldByName('Tipo').asString = 'F' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'PESSOA FISICA';
    end
  else if uOrig.FieldByName('Tipo').asString = 'J' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'PESSOA JURIDICA';
    end
  else if uOrig.FieldByName('Tipo').asString = 'P' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'PRODUTOR';
    end
    else if uOrig.FieldByName('Tipo').asString = 'E' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'ORGAO PUBLICO';
    end
    else if uOrig.FieldByName('Tipo').asString = 'N' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'NOVO PRODUTOR';
    end
    else if uOrig.FieldByName('Tipo').asString = 'V' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'VETERINARIO';
    end
    else if uOrig.FieldByName('Tipo').asString = 'D' then
    begin
      uDest.Fieldbyname('Tipo').asString := 'ATIVIDADE <>';
    end;
  uDest.Fieldbyname('Banco').asString             := trim( uOrig.FieldByName('Banco').asString);
  uDest.Fieldbyname('Nome').asString              := trim( uOrig.FieldByName('NomeFantasia').asString);
  uDest.Fieldbyname('Razao').asString             := trim( uOrig.FieldByName('Nome').asString);
  uDest.Fieldbyname('Endereco').asString          := trim( uOrig.FieldByName('Ende').asString);
  uDest.Fieldbyname('Numero').asString            := trim( uOrig.FieldByName('EndeNumero').asString);
  uDest.Fieldbyname('Cep').asString               := trim( uOrig.FieldByName('Cep').asString);
  uDest.Fieldbyname('Bairro').asString            := trim( uOrig.FieldByName('Bair').asString);
  uDest.Fieldbyname('Cidade').asString            := trim( uOrig.FieldByName('Cida').asString);
  uDest.Fieldbyname('Estado').asString            := trim( uOrig.FieldByName('Esta').asString);
  uDest.Fieldbyname('Telefone1').asString         := trim( uOrig.FieldByName('Telefone1').asString);
  uDest.Fieldbyname('Telefone2').asString         := trim( uOrig.FieldByName('Telefone2').asString);
  uDest.Fieldbyname('Celular').asString           := trim( uOrig.FieldByName('Celular').asString);
  uDest.Fieldbyname('Fax').asString               := trim( uOrig.FieldByName('Fax').asString);
  uDest.Fieldbyname('email').asString             := trim( uOrig.FieldByName('email').asString);
  uDest.Fieldbyname('site').asString              := trim( uOrig.FieldByName('www').asString);
  if uOrig.FieldByName('Insc').asString <> '' then
    begin
    uDest.Fieldbyname('rgie').asString := trim(StringReplace(uOrig.FieldByName('Insc').asstring,'.','',[rfReplaceall]));
    end;
  if uOrig.FieldByName('Rg').asString <> '' then
    begin
    uDest.Fieldbyname('rgie').asString := trim(StringReplace(uOrig.FieldByName('rg').asstring,'.','',[rfReplaceall]));
    end;
  if uOrig.FieldByName('Cpf').asString <> '' then
    begin
    uDest.Fieldbyname('cpfcnpj').asString := trim(StringReplace(uOrig.FieldByName('cpf').asstring,'.','',[rfReplaceall]));
    end;
  if uOrig.FieldByName('cgc').asString <> '' then
    begin
    uDest.Fieldbyname('cpfcnpj').asstring := trim(StringReplace(uOrig.FieldByName('Cgc').asstring,'.','',[rfReplaceall]));
    end;
  uDest.Fieldbyname('Limite').asString            := trim( uOrig.FieldByName('Limite').asString);
  uDest.Fieldbyname('RefEntrega').asString        := trim( uOrig.FieldByName('ReferenciaEntrega').asString);
  uDest.Fieldbyname('Obs').asString                  := trim( uOrig.FieldByName('ObservacoesGerais').asString);
  uDest.Fieldbyname('EnderecoE').asString          := trim( uOrig.FieldByName('EndeEntrega').asString);
  uDest.Fieldbyname('NumeroE').asString          := trim( uOrig.FieldByName('EndeNumeroEntrega').asString);
  uDest.Fieldbyname('CepE').asString               := trim( uOrig.FieldByName('CepEntrega').asString);
  uDest.Fieldbyname('BairroE').asString            := trim( uOrig.FieldByName('BairEntrega').asString);
  uDest.Fieldbyname('CidadeE').asString            := trim( uOrig.FieldByName('CidaEntrega').asString);
  uDest.Fieldbyname('EstadoE').asString            := trim( uOrig.FieldByName('EstaEntrega').asString);
  uDest.Fieldbyname('CxPostal').asString             := trim( uOrig.FieldByName('cPosta').asString);
end;

procedure TfrmConversorDados.camposcidades;
begin
  uDest.Fieldbyname('CodCidade').asString        := trim( uOrig.FieldByName('Codigo').asString);
  uDest.Fieldbyname('Cidade').asString           := trim( uOrig.FieldByName('Cidade').asString);
  uDest.Fieldbyname('Estado').asString           := trim( uOrig.FieldByName('Estado').asString);
end;

procedure TfrmConversorDados.camposContatoclientes;
begin
  uDest.Fieldbyname('Contato').asString        := trim( uOrig.FieldByName('Nome').asString);
end;

function TfrmConversorDados.cidade_codigo(nome_cidade, estado: string):Integer;
var
  nome: string;
begin
  Result := 0;
  if nome_cidade <> '' then
  begin
    nome := trim( uppercase(  TLib.RetiraAcentos(  nome_cidade ) ) );
    try
      DMR.SQLCidades.ParamByName('cidade').AsString := nome;
      DMR.SQLCidades.ParamByName('uf').AsString     := estado;
      DMR.SQLCidades.Open;
      if not DMR.SQLCidades.IsEmpty then
      begin
        Result:= DMR.SQLCidades.FieldByName('codcidade').AsInteger;
      end;
    finally
      DMR.SQLCidades.Close;
    end;
  end;
end;

procedure TfrmConversorDados.FormShow(Sender: TObject);
begin
dmr.FDOrig.Connected := true;
dmr.FDDest.Connected := true;
  //inherited;

end;

end.
