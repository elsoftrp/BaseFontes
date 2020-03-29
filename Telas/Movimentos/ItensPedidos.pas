unit ItensPedidos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Variants,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, DBCtrls, uSeek, uAcoes,
  Mask,  Db,  Menus, uModelBase, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uLib;

type
  TfrmItensPedidos = class(TfrmModelBase)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnOk: TBitBtn;
    BtnCancelar: TBitBtn;
    PopupMenu1: TPopupMenu;
    Localizar1: TMenuItem;
    DataSource1: TDataSource;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit3: TDBEdit;
    DBText1: TDBText;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    DBText2: TDBText;
    Label2: TLabel;
    Bevel3: TBevel;
    DBText3: TDBText;
    Bevel4: TBevel;
    DBText4: TDBText;
    qde: TDBEdit;
    prtotal: TDBEdit;
    prunitario: TDBEdit;
    Label5: TLabel;
    desconto: TDBEdit;
    Label8: TLabel;
    perdesconto: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure Localizar1Click(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure qdeExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure perdescontoExit(Sender: TObject);
    procedure descontoExit(Sender: TObject);
  private
    { Private declarations }
    vQuerySql: TFDQuery;
    FCodigo: Integer;
    FAcao: TAcao;
    FAcaoExterno: TAcao;
    seek: TSeek;
    function SaldoEstoque(Codigo: Integer): Double;
    procedure Atualiza(campo: string);
  public
    constructor Create(AOwer: TComponent; Codigo: Variant;
      Acao: TAcao  = aAlterar);

    { Public declarations }
  end;

var
  frmItensPedidos: TfrmItensPedidos;

implementation

uses Funcoes, ConsProduto, EscolheLote, DataModulo;


{$R *.DFM}

constructor TfrmItensPedidos.Create(AOwer: TComponent; Codigo: Variant; Acao: TAcao = aAlterar);
begin
  inherited Create(AOwer);
  FCodigo       := Codigo;
  FAcaoExterno  := Acao;
end;

procedure TfrmItensPedidos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key of
    #13: Perform(Wm_NextDlgCtl, 0, 0);
    #38: Perform(Wm_NextDlgCtl, 1, 0);
    #27:btnCancelar.Click;
  end;
  if Key in [#27,#38,#13] then key := #0;
end;

procedure TfrmItensPedidos.FormShow(Sender: TObject);
begin
  vQuerySql := DM.SQLItensPedidos;
  BtnOk.Visible := False;
  BtnCancelar.Visible := False;
  BtnCancelar.Caption := '&Cancelar';
  if FAcaoExterno = aIncluir then
  begin
    BtnOk.Visible := True;
    BtnCancelar.Visible := True;
    //DBEdit3.SetFocus;
    FAcao := aIncluir;
  end
  else if FAcaoExterno = aAlterar then
  begin
    qde.SetFocus;
    DBEdit3.Enabled := False;
    BtnOk.Visible := True;
    BtnCancelar.Visible := True;
    FAcao := aAlterar;
  end
  else if FAcaoExterno = aConsultar then
  begin
    BtnCancelar.Caption := ' &Fechar';
    BtnCancelar.Visible := True;
    FAcao := aSemAcao;
  end;
end;

procedure TfrmItensPedidos.BtnOkClick(Sender: TObject);
var
  x:Integer;
begin
  if (FAcao = aIncluir) or (FAcao = aAlterar) then
  begin
    for x:=0 to vQuerySql.FieldCount -1 do
    begin
      if vQuerySql.Fields[x].required then
      begin
        if vQuerySql.Fields[x].AsString= '' then
        begin
          MessageDlg(Format('O Campo  "%s"  precisa ser prenchido.',[vQuerySql.Fields[x].DisplayLabel]),mtError,[mbOk],0);
          vQuerySql.Fields[x].FocusControl;
          exit;
        end;
      end;
    end;
  end;
  if FAcao = aIncluir then
  begin
    vQuerySql.FieldByName('Seq').AsInteger := FCodigo;
    Inc(FCodigo);
  end;
  if (FAcao = aAlterar) or (FAcao = aIncluir) then
  begin
    vQuerySql.Post;
  end;
  if FAcao = aIncluir then
  begin
    if tlib.Mensagem('Aviso', 'Deseja Continuar incluindo Produtos','?')=idYes then
    begin
      vQuerySql.Append;
      DBEdit3.SetFocus;
    end
    else
      Close;
  end
  else
    Close;
end;

procedure TfrmItensPedidos.BtnCancelarClick(Sender: TObject);
begin
  if (FAcao = aAlterar) or (FAcao = aIncluir) then
  begin
    try
      vQuerySql.Cancel;
      Close;
    except
    end;
  end
  else
    Close;
end;

procedure TfrmItensPedidos.DBEdit3Exit(Sender: TObject);
var
  viCodPro:String;
begin
  if (btnCancelar.Focused) then exit;
  if (Sender as TDBEdit).Text = '' then
  begin
    tlib.Mensagem('Aviso','Produto tem que ser informado.','!');
    (Sender as TDBEdit).SetFocus;
    exit;
  end;
  seek := TSeek.Create(nil, DM.DataBase, False);
  try
    if not seek.Seek('Produtos',1,['Codbarra'],[(Sender as TDBEdit).Text]) then
    begin
      tlib.Mensagem('Aviso','Produto n�o encontrado.','!');
      (Sender as TDBEdit).SetFocus;
      exit;
    end;
    if seek.Qry.FieldByName('inativo').AsBoolean = True then
    begin
      tlib.Mensagem('Aviso','Produto est� INATIVO.','!');
      (Sender as TDBEdit).SetFocus;
      Exit;
    end;
//    if seek.Qry.FieldByName('controlado').AsString = 'N' then
//    begin
//      // procure se produto ja esta incluido
//      viCodPro := (Sender as TDBEdit).Text;
//      vQuerySql.Cancel;
//      if (vQuerySql.Locate('CodEan',viCodPro,[])) and (FAcao = aIncluir) then
//      begin
//        F.Mensagem('Aviso','Produto j� lan�ado no Pedido.','!');
//        (Sender as TDBEdit).SetFocus;
//        vQuerySql.Insert;
//        vQuerySql.FieldByName('CodPedido').AsInteger := DFar.SQLPedidos.FieldByName('CodPedido').AsInteger;
//        exit;
//      end
//      else
//      begin
//        if FAcao = aIncluir then
//          vQuerySql.Append
//        else if FAcao = aAlterar then
//          vQuerySql.Edit;
//        vQuerySql.FieldByName('CodEan').AsString := viCodPro;
//        vQuerySql.FieldByName('UsoProlongado').AsString := 'N';
//      end;
//    end;
    //
    vQuerySql.FieldByName('despro').asString       := seek.Qry.FieldByName('Despro').asString;
    vQuerysql.FieldByName('codpro').asInteger      := seek.Qry.fieldbyname('codpro').asinteger;
    vquerysql.fieldbyname('prvenda').ascurrency    := seek.Qry.fieldbyname('prvenda').ascurrency;
    vquerysql.fieldbyname('prcompra').ascurrency   := seek.Qry.fieldbyname('prcompra').ascurrency;
    vQuerySql.FieldByName('controlalote').asString := seek.Qry.FieldByName('controlalote').asString;
    if vQuerySql.FieldByName('controlalote').asString <> 'S' then
    begin
      vquerysql.FieldByName('numerolote').AsString       := '0';
      vquerysql.FieldByName('DataVencimento').AsDateTime := StrToDate('01/01/2000');
    end
    else
    begin
      vquerysql.FieldByName('numerolote').Clear;
      vquerysql.FieldByName('DataVencimento').Clear;
    end;
  finally
    FreeAndNil(seek);
  end;
end;

procedure TfrmItensPedidos.descontoExit(Sender: TObject);
begin
  Atualiza('PRDESCONTO');
end;

procedure TfrmItensPedidos.qdeExit(Sender: TObject);
begin
  if btncancelar.Focused then exit;
  if qde.Field.AsCurrency <= 0 then
  begin
    tlib.Mensagem('Aviso','Quantidade tem que ser maior que Zero.','!');
    qde.SetFocus;
    exit;
  end;

  if vQuerySql.FieldByName('controlalote').asString = 'S' then
  begin
    frmEscolheLote := TfrmEscolheLote.Create(Self, vquerysql.FieldByName('codpro').asInteger);
    try
      DM.SQLEstoqueLote.close;
      DM.SQLEstoqueLote.SQL.Clear;
      DM.SQLEstoqueLote.SQL.Add('select p.despro, s.* from saldoestoque s left outer join produtos p on p.codpro=s.codpro '+
                                'where s.estoque > 0 and s.codpro =:codpro order by datavencimento');
      DM.SQLEstoqueLote.ParamByName('codpro').AsInteger := vquerysql.FieldByName('codpro').asInteger;
      DM.SQLEstoqueLote.Open;
      frmEscolheLote.ShowModal;

      if frmEscolheLote.ModalResult = mrOk then
      begin
        if vquerysql.FieldByName('quantidade').ascurrency > (DM.SQLEstoqueLote.FieldByName('estoque').asInteger) then
        begin
          tlib.Mensagem('Aviso','Quantidade Maior que do Estoque.'+#13+'VERIFIQUE','E');
          qde.SetFocus;
          exit;
        end;
        vquerysql.FieldByName('numerolote').AsString       := DM.SQLEstoqueLote.FieldByName('numerolote').AsString;
        vquerysql.FieldByName('DataVencimento').AsDateTime := DM.SQLEstoqueLote.FieldByName('DataVencimento').AsDateTime;
      end
      else
      begin
        tlib.Mensagem('Aviso','N�o foi escolhido o LOTE.'+#13+'VERIFIQUE','E');
        qde.SetFocus;
        Exit;
      end;
    finally
      DM.SQLEstoqueLote.Close;
      //frmEscolheLote.Release;
    end;
  end
  else
  begin
    if vquerysql.FieldByName('quantidade').ascurrency > SaldoEstoque(vquerysql.FieldByName('codpro').asInteger) then
    begin
      tlib.Mensagem('Aviso','Quantidade Maior que do Estoque.'+#13+'VERIFIQUE','E');
      qde.SetFocus;
      exit;
    end;
  end;
  Atualiza('QDE');
end;

procedure TfrmItensPedidos.Localizar1Click(Sender: TObject);
var
  valorRetorno: string;
begin
  frmConsProdutos := TfrmConsProdutos.Create(Self, 'ITEM', crCodEan);
  try
    frmConsProdutos.ShowModal;
    if frmConsProdutos.ModalResult = mrOk then
    begin
      vQuerySql.FieldByName('CodEan').asString := frmConsProdutos.valorRetorno;
    end;
  finally
    frmConsProdutos.release;
  end;
end;

procedure TfrmItensPedidos.perdescontoExit(Sender: TObject);
begin
  Atualiza('PERCDESCONTO');
end;

function TfrmItensPedidos.SaldoEstoque(Codigo: Integer): Double;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(Self);
  try
    Qry.Connection := DM.DataBase;
    Qry.Close;
    Qry.SQL.Add('Select estoque from saldoestoque where CodPro =:CodPro and numerolote=:numerolote and datavencimento=:datavencimento  ');
    Qry.ParamByName('CodPro').AsInteger          := Codigo;
    Qry.ParamByName('numerolote').AsString       := '0';
    Qry.ParamByName('datavencimento').AsDateTime := StrToDate('01/01/2000');
    Qry.Prepare;
    Qry.Open;
    if not Qry.IsEmpty then
    begin
      Result := Qry.FieldByName('Estoque').AsInteger;
    end
    else
    begin
      Result := 0;
    end;
  finally
    Qry.Close;
    FreeAndNil(Qry);
  end;
end;

procedure TfrmItensPedidos.Atualiza(campo: string);
begin
  if ((vQuerySql.State = dsEdit) or (vQuerySql.State = dsInsert)) then
  begin
    if campo = ('QDE') then
    begin
      vquerysql.fieldbyname('prtotal').ascurrency := ((vquerysql.fieldbyname('quantidade').ascurrency*(vquerysql.fieldbyname('prvenda').ascurrency-vquerysql.fieldbyname('desconto').ascurrency)));
    end;
    if campo = ('PRUNITARIO') then
    begin
      vquerysql.fieldbyname('prtotal').ascurrency := ((vquerysql.fieldbyname('quantidade').ascurrency*(vquerysql.fieldbyname('prvenda').ascurrency-vquerysql.fieldbyname('desconto').ascurrency)));
    end;

    if campo = ('PERCDESCONTO') then
    begin
      if (vQuerySql.FieldByName('PORCDESC').AsString <> '') and (vQuerySql.FieldByName('PORCDESC').AsCurrency > 0) then
      begin
        vQuerySql.FieldByName('desconto').AsCurrency := ((vQuerySql.FieldByName('PORCDESC').AsCurrency*vQuerySql.FieldByName('prvenda').AsCurrency)/100);
        vquerysql.fieldbyname('prtotal').ascurrency  := ((vquerysql.fieldbyname('quantidade').ascurrency*(vquerysql.fieldbyname('prvenda').ascurrency-vquerysql.fieldbyname('desconto').ascurrency)));
      end;
    end;

    if campo = ('PRDESCONTO') then
    begin
      if (vQuerySql.FieldByName('desconto').AsString <> '') and (vQuerySql.FieldByName('desconto').AsCurrency > 0) then
      begin
        vQuerySql.FieldByName('PORCDESC').AsCurrency := ((vQuerySql.FieldByName('desconto').AsCurrency/vQuerySql.FieldByName('prvenda').AsCurrency)*100);
        vquerysql.fieldbyname('prtotal').ascurrency  := ((vquerysql.fieldbyname('quantidade').ascurrency*(vquerysql.fieldbyname('prvenda').ascurrency-vquerysql.fieldbyname('desconto').ascurrency)));
      end;
    end;
  end;
end;


end.
