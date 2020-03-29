unit Entradas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ModeloDiretoDac, DB, ActnList, Menus, ActnPopup, ImgList, Buttons,
  StdCtrls, ExtCtrls, Mask, DBCtrls, JvExMask, JvToolEdit, JvDBControls, Grids,
  DBGrids, uSeek, uAcoes, System.Actions, Vcl.PlatformDefaultStyleActnCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uLib,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmEntradas = class(TfrmModeloDiretoDac)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    DBEdit2: TJvDBDateEdit;
    DBEdit5: TJvDBDateEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    DBText1: TDBText;
    DBText4: TDBText;
    Label9: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel5: TPanel;
    SpeedButton6: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Panel6: TPanel;
    ActionList2: TActionList;
    acIncluirI: TAction;
    acAlterarI: TAction;
    acExcluirI: TAction;
    ImageList2: TImageList;
    DataSource1: TDataSource;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    SpeedButton11: TSpeedButton;
    Label10: TLabel;
    acConsultarI: TAction;
    SpeedButton12: TSpeedButton;
    DBEdit9: TDBMemo;
    procedure FormShow(Sender: TObject);
    procedure acIncluirIExecute(Sender: TObject);
    procedure acAlterarIExecute(Sender: TObject);
    procedure acExcluirIExecute(Sender: TObject);
    procedure DBEdit6Exit(Sender: TObject);
    procedure acConsultarIExecute(Sender: TObject);
  private
    FSeq : Integer;
    seek: TSeek;
    vQueryI: TFDQuery;
    procedure GetIdSeq;
    procedure doCalculaTotal;
    procedure doBaixaEstoque;
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LiberarBtn; override;
    procedure ComplementoSaidaCampoChave; override;
    procedure ComplementoNaoIncluirSaidaCampoChave; override;
    procedure doGravaDataSets; override;
    procedure doFecharDataSets(erro: Boolean = False; cancel: Boolean = False); override;
    procedure Gravar; override;

  end;

var
  frmEntradas: TfrmEntradas;

implementation

uses Funcoes, ItensEntradas, DataModulo;

{$R *.dfm}

procedure TfrmEntradas.acAlterarIExecute(Sender: TObject);
begin
  frmItensEntradas := TfrmItensEntradas.Create(Self, 0, aAlterar);
  try
    vQueryI.Edit;
    frmItensEntradas.ShowModal;
  finally
    frmItensEntradas.Release;
    doCalculaTotal();
  end;
end;

procedure TfrmEntradas.acConsultarIExecute(Sender: TObject);
begin
  frmItensEntradas := TfrmItensEntradas.Create(Self, 0, aConsultar);
  try
    frmItensEntradas.ShowModal;
  finally
    frmItensEntradas.Release;
  end;
end;

procedure TfrmEntradas.acExcluirIExecute(Sender: TObject);
begin
  if Application.messagebox('Confirma a EXCLUS�O deste Item?', vp, mb_yesno) = idyes then
  begin
    vQueryI.Delete;
    doCalculaTotal();
  end;
end;

procedure TfrmEntradas.acIncluirIExecute(Sender: TObject);
begin
  GetIdSeq;
  vQueryI.Append;
  vQueryI.FieldByName(FCampoChave).AsInteger  := vQuerydac.FieldByName(FCampoChave).asInteger;
  vQueryI.FieldByName('motivoperda').AsString := '0';
  frmItensEntradas := TfrmItensEntradas.Create(Self, FSeq, aIncluir);
  try
    frmItensEntradas.ShowModal;
  finally
    frmItensEntradas.Release;
    doCalculaTotal();
  end;
end;

procedure TfrmEntradas.ComplementoNaoIncluirSaidaCampoChave;
begin
  vQueryI.Open;
  if FAcao in [aAlterar, aBaixar] then
  begin
    if vQuerydac.FieldByName('Baixa').AsString = 'B' then
    begin
      tlib.Mensagem('Aviso','Movimento j� Baixado.','!');
      FFocoa.SetFocus;
      Exit;
    end;
  end;
end;

procedure TfrmEntradas.ComplementoSaidaCampoChave;
begin
  vQuerydac.FieldByName('DataCad').AsDateTime   := Int(FDireitos.DataHoje);
  vQuerydac.FieldByName('TipoEntrada').AsString := 'CP';
  vQueryI.Open;
end;

procedure TfrmEntradas.DBEdit6Exit(Sender: TObject);
begin
  if (btnCancelar.Focused) then exit;
  if (Sender as TDBEdit).Text = '' then Exit;
  if not fseek.Seek('Fornecedores',1,['CodFor'],[(Sender as TDBEdit).Text]) then
  begin
    tlib.Mensagem('Aviso','Fornecedor n�o encontrado.','E');
    (Sender as TDBEdit).SetFocus;
    exit;
  end;
  vQuerydac.FieldByName('NomFor').asString  := fseek.Qry.FieldByName('NomFor').asString;
  vQuerydac.FieldByName('CnpjFor').asString := fseek.Qry.FieldByName('CnpjFor').asString;
end;

procedure TfrmEntradas.doBaixaEstoque;
var
  qry, qryP: TFDQuery;
  vsSql, vsSqlP: string;
begin
  qry  := TFDQuery.Create(nil);
  qryP := TFDQuery.Create(nil);
  try
    if vQuerydac.FieldByName('TipoEntrada').AsString = 'CP' then
      vsSqlP := 'update produtos set  Prcompra =:prcompra, PrLucro =:prlucro, Prvenda =:prvenda, UltCompra =:ultcompra '+
                'where codpro =:codpro '
    else
      vsSqlP := 'update produtos set  Prcompra =:prcompra, PrLucro =:prlucro, Prvenda =:prvenda '+
                'where codpro =:codpro ';

    vsSql  := 'insert into movestoque (codpro, numerolote, datavencimento, quantidade, prcompra, prvenda, tipo, data, coddoc) values '+
              '(:codpro, :numerolote, :datavencimento, :quantidade, :prcompra, :prvenda, :tipo, :data, :coddoc)';
    qry.Connection  := FConnection;
    qryP.Connection := FConnection;

    qryP.SQL.Clear;
    qryP.SQL.Add(vsSqlP);

    qry.SQL.clear;
    qry.SQL.Add(vsSql);

    vQueryI.First;
    while not vQueryI.Eof do
    begin
      qryP.ParamByName('codpro').AsInteger      := vQueryI.FieldByName('codpro').AsInteger;
      qryP.ParamByName('prcompra').AsCurrency   := vQueryI.FieldByName('prcompra').AsCurrency;
      qryP.ParamByName('prlucro').AsCurrency    := vQueryI.FieldByName('perlucro').AsCurrency;
      qryP.ParamByName('prvenda').AsCurrency    := vQueryI.FieldByName('prvenda').AsCurrency;
      //
      qry.ParamByName('codpro').AsInteger      := vQueryI.FieldByName('codpro').AsInteger;
      if vQueryI.FieldByName('controlalote').AsString = 'N' then
      begin
        qry.ParamByName('numerolote').AsString       := '0';
        qry.ParamByName('datavencimento').AsDateTime := StrToDate('01/01/2000');
      end
      else
      begin
        qry.ParamByName('numerolote').AsString   := vQueryI.FieldByName('numerolote').AsString;
        qry.ParamByName('datavencimento').AsDateTime  := vQueryI.FieldByName('datavencimento').AsDateTime;
      end;
      qry.ParamByName('quantidade').AsCurrency := vQueryI.FieldByName('qde').AsCurrency;
      qry.ParamByName('prcompra').AsCurrency   := vQueryI.FieldByName('valor').AsCurrency;
      qry.ParamByName('prvenda').AsCurrency    := vQueryI.FieldByName('prvenda').AsCurrency;
      qry.ParamByName('data').AsDateTime       := vQuerydac.FieldByName('DataBaixa').AsDateTime;
      qry.ParamByName('coddoc').AsInteger      := vQuerydac.FieldByName(FCampoChave).AsInteger;
      if vQuerydac.FieldByName('TipoEntrada').AsString = 'CP' then
      begin
        qry.ParamByName('tipo').AsString          := 'E';
        qryP.ParamByName('ultcompra').AsDateTime  := vQuerydac.FieldByName('DataBaixa').AsDateTime;
      end
      else if vQuerydac.FieldByName('TipoEntrada').AsString = 'AE' then
      begin
        qry.ParamByName('tipo').AsString         := 'E';
      end
      else if vQuerydac.FieldByName('TipoEntrada').AsString = 'AS' then
      begin
        qry.ParamByName('tipo').AsString         := 'S';
      end;

      qry.ExecSQL;
      qryP.ExecSQL;

      vQueryI.Next;
    end;
  finally
    FreeAndNil(qry);
    FreeAndNil(qryP);
  end;
end;

procedure TfrmEntradas.doCalculaTotal;
var
  ponteiro: TBookmark;
begin
  if vQueryI.RecordCount > 0 then
  begin
      vQuerydac.FieldByName('TotalProduto').AsCurrency := 0;
      ponteiro := vQueryI.Bookmark;
      vQueryI.First;
      while not vQueryI.Eof do
      begin
        vQuerydac.FieldByName('TotalProduto').AsCurrency := (vQuerydac.FieldByName('TotalProduto').AsCurrency+vQueryI.FieldByName('Total').AsCurrency);
        vQueryI.Next;
      end;
      vQueryI.Bookmark := ponteiro;
  end;
end;

procedure TfrmEntradas.doFecharDataSets(erro: Boolean = False; cancel: Boolean = False);
begin
  if erro then
  begin
    vQueryI.Cancel;
  end;
  if (not cancel) and (FAcao in [aIncluir, aAlterar, aBaixar]) then
  begin
    vQueryI.CommitUpdates;
  end;
  vQueryI.Close;
end;

procedure TfrmEntradas.doGravaDataSets;
begin
  if FAcao = aBaixar then
  begin
    doBaixaEstoque;
  end;
  if FAcao in[aIncluir, aAlterar, aBaixar] then
  begin
    vQueryI.ApplyUpdates;
  end
  else if FAcao = aExcluir then
  begin
    vQueryI.First;
    while not vQueryI.Eof do
    begin
      vQueryI.Delete;
    end;
    vQueryI.ApplyUpdates;
  end;
end;

procedure TfrmEntradas.GetIdSeq;
begin
  if not vQueryI.IsEmpty then
  begin
    vQueryI.First;
    vQueryI.Last;
    FSeq := vQueryI.FieldByName('Seq').AsInteger+1;
  end
  else
    FSeq := 1;
end;

procedure TfrmEntradas.FormShow(Sender: TObject);
begin
  FConnection := DM.DataBase;
  vQuerydac   := DM.SQLEntradas;
  vQueryI     := DM.SQLItensEntradas;
  FNomeTabela := 'Entradas';
  FCampoChave := 'CodEntrada';
  FFocoI      := DBEdit1;
  FFocoA      := DBEdit1;

  inherited;

end;

procedure TfrmEntradas.Gravar;
begin
  if FAcao in [aIncluir,aAlterar] then
  begin
    if vQuerydac.FieldByName('TotalNota').AsCurrency <> vQuerydac.FieldByName('TotalProduto').AsCurrency then
    begin
      tlib.Mensagem('Aviso','Valor da nota n�o confere com o total de produtos lan�ados.','!');
      DBEdit7.SetFocus;
      Exit;
    end;
  end;
  if FAcao = aBaixar then
  begin
    vQuerydac.FieldByName('Baixa').AsString := 'B';
    vQuerydac.FieldByName('DataBaixa').AsDateTime := Int(FDireitos.DataHoje);
  end;
  inherited;

end;

procedure TfrmEntradas.LiberarBtn;
begin
  if (vQuerydac.State = DsEdit) or (vQuerydac.State = DsInsert) then
  begin
    if FAcao in[aIncluir, aAlterar]  then
    begin
      acIncluirI.Enabled   := FDireitos.Incluir;
      acAlterarI.Enabled   := FDireitos.Alterar;
      acExcluirI.Enabled   := FDireitos.Alterar;
      acConsultarI.Enabled := FDireitos.Visualizar;
    end;
    if FAcao = aBaixar then
    begin
      acConsultarI.Enabled := FDireitos.Visualizar;
    end;
  end
  else
  begin
    acIncluirI.Enabled   := False;
    acAlterarI.Enabled   := False;
    acExcluirI.Enabled   := False;
    acConsultarI.Enabled := False;
  end;
  inherited;
end;

end.