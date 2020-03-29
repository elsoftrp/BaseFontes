unit RelProdutosLote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ModeloRelNew, Menus, ImgList, ActnList, StdCtrls, Buttons, ExtCtrls,
  uSeek, uAcoes, Uni;

type
  TfrmRelProdutosLote = class(TfrmModeloRelNew)
    Label3: TLabel;
    lblGrupo: TStaticText;
    codGrupo: TEdit;
    rgTipo: TRadioGroup;
    rgOrdem: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure codGrupoExit(Sender: TObject);
    procedure rgTipoClick(Sender: TObject);
  private
    seek: TSeek;
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure doImprimir; override;
  end;

var
  frmRelProdutosLote: TfrmRelProdutosLote;

implementation

uses DMCadastro, DMFarmacia, Funcoes, uDMReport;

{$R *.dfm}

{ TfrmRelProdutosLote }

procedure TfrmRelProdutosLote.codGrupoExit(Sender: TObject);
begin
  if btnFechar.Focused then exit;
  if (Sender as TEdit).Text = '' then begin  lblGrupo.Caption := ' '; exit; end;
  seek := TSeek.Create(nil, FConnection, False);
  try
    if not seek.Seek('Grupos',1,['CodGrupo'],[(Sender as TEdit).Text]) then
    begin
      F.Mensagem('Aviso','Grupo não encontrado.','!');
      (Sender as TEdit).SetFocus;
      exit;
    end;
    lblGrupo.Caption := seek.Qry.FieldByName('desgrupo').asString;
  finally
    FreeAndNil(seek);
  end;
end;

procedure TfrmRelProdutosLote.doImprimir;
var
  vsSql: string;
begin
  with DFar do
  begin
    try
      vsSql := 'select p.codproduto, p.despro, p.registroms, s.estoque as saldo, s.numerolote, s.datavencimento '+
               'from produtos p left outer join saldoestoque s on s.codproduto=p.codproduto '+
               'where s.estoque > 0  ';
      if codGrupo.Text <> '' then
        vsSql := vsSql+' and p.codgrupo =:codgrupo ';

      if rgTipo.ItemIndex = 0 then
        vsSql := vsSql+' and p.tipocontrolado = '+QuotedStr('AM')+' '
      else if rgTipo.ItemIndex = 1 then
        vsSql := vsSql+' and p.tipocontrolado = '+QuotedStr('PS')+' '
      else if rgTipo.ItemIndex = 2 then
        vsSql := vsSql+' and p.tipocontrolado = '+QuotedStr('OU')+' ';

      if rgOrdem.ItemIndex = 0 then
        vsSql := vsSql+' order by p.codproduto '
      else if rgOrdem.ItemIndex = 1 then
        vsSql := vsSql+' order by p.despro '
      else if rgOrdem.ItemIndex = 2 then
        vsSql := vsSql+' order by s.datavencimento '
      else if rgOrdem.ItemIndex = 3 then
        vsSql := vsSql+' order by s.estoque ';

      SQLRelProdutosLote.Close;
      SQLRelProdutosLote.SQL.Clear;
      SQLRelProdutosLote.SQL.Add(vsSql);
      if codGrupo.Text <> '' then
        SQLRelProdutosLote.ParamByName('codgrupo').asInteger := StrToInt(codGrupo.Text);
      SQLRelProdutosLote.Open;
      DMReport.frxReport1.LoadFromFile(F.vPathRelat+'\frRelProdutosLote.fr3');
      DMReport.frxReport1.Variables.Clear;
      DMReport.frxReport1.Variables['titulo']  := QuotedStr(lblGrupo.Caption);
      DMReport.frxReport1.ShowReport();
    finally
      SQLRelProdutosLote.Close;
    end;
  end;
end;

procedure TfrmRelProdutosLote.FormShow(Sender: TObject);
begin
  FConnection := DC.DataDac;
  FNomeTabela := 'RelProdutosLote';
  inherited;

end;

procedure TfrmRelProdutosLote.rgTipoClick(Sender: TObject);
begin
  lblGrupo.Visible := (rgTipo.ItemIndex = 2);
  Label3.Visible   := (rgTipo.ItemIndex = 2);
  codGrupo.Visible := (rgTipo.ItemIndex = 2);
end;

end.
