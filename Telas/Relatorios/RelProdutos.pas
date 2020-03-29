unit RelProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ModeloRelNew, StdCtrls, ExtCtrls, Menus, ImgList, ActnList, Buttons, uSeek, Uni,
  System.Actions, uLib, uLoadFileIni;

type
  TfrmRelProdutos = class(TfrmModeloRelNew)
    Label3: TLabel;
    Label1: TLabel;
    lblGrupo: TStaticText;
    RadioGroup2: TRadioGroup;
    Edit1: TEdit;
    codGrupo: TEdit;
    procedure codGrupoExit(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure doImprimir; override;
  end;

var
  frmRelProdutos: TfrmRelProdutos;

implementation

uses Funcoes, DataModulo, DataReport;

{$R *.dfm}

procedure TfrmRelProdutos.codGrupoExit(Sender: TObject);
begin
  if (btnFechar.Focused) then exit;
  if (Sender as TEdit).Text = '' then Exit;
  if not Fseek.Seek('Grupos',1,['CodGrupo'],[(Sender as TEdit).Text]) then
  begin
    TLib.Mensagem('Aviso','Grupo não encontrado.','E');
    (Sender as TEdit).SetFocus;
    exit;
  end;
  lblGrupo.Caption  := Fseek.Qry.FieldByName('DesGrupo').asString;
end;

procedure TfrmRelProdutos.doImprimir;
var
  vsSql: string;
begin
  with DMReport do
  begin
    try
      vsSql := 'SELECT (select sum(S.Estoque) from saldoestoque S where S.codpro=p.codpro group by S.codpro) Saldo, p.*, g.desGrupo  '+
      ' FROM Produtos p INNER JOIN Grupos g ON p.CodGrupo = g.CodGrupo Where 1=1 ';

      if codGrupo.Text <> '' then
        vsSql := vsSql+' and p.CodGrupo =:CodGrupo ';
      if RadioGroup2.ItemIndex = 1 then
         vsSql := vsSql+' and (select sum(S.Estoque) from saldoestoque S where S.codpro=p.codpro group by S.codpro) = :Qde '
      else if RadioGroup2.ItemIndex = 2 then
         vsSql := vsSql+' and (select sum(S.Estoque) from saldoestoque S where S.codpro=p.codpro group by S.codpro) >= :Qde '
      else if RadioGroup2.ItemIndex = 3 then
         vsSql := vsSql+' and (select sum(S.Estoque) from saldoestoque S where S.codpro=p.codpro group by S.codpro) <= :Qde '
      else if RadioGroup2.ItemIndex = 4 then
         vsSql := vsSql+' and (select sum(S.Estoque) from saldoestoque S where S.codpro=p.codpro group by S.codpro) > :Qde '
      else if RadioGroup2.ItemIndex = 5 then
         vsSql := vsSql+' and (select sum(S.Estoque) from saldoestoque S where S.codpro=p.codpro group by S.codpro) < :Qde ';
      //
      vsSql := vsSql+'Order by g.desGrupo, DesPro';


      SQLProdutos.Close;
      SQLProdutos.SQL.Clear;
      SQLProdutos.SQL.Add(vsSql);
      if codGrupo.Text <> '' then
        SqlProdutos.ParamByName('CodGrupo').asInteger := StrToInt(codGrupo.Text);
      if RadioGroup2.ItemIndex > 0 then
      begin
        SqlProdutos.ParamByName('Qde').Value := StrToFloat(Edit1.Text);
      end;
      SQLProdutos.Open;
      frxReport1.LoadFromFile(TLoadFileIni.GetInstance.PathRelat+'\frProdutos.fr3');
      frxReport1.Variables.Clear;
      //frxReport1.Variables['Dataini'] := QuotedStr(Dataini.Text);
      //frxReport1.Variables['Datafim'] := QuotedStr(Datafim.Text);
      frxReport1.ShowReport();                       
    finally
      SQLProdutos.Close;
    end;
  end;
end;

procedure TfrmRelProdutos.FormShow(Sender: TObject);
begin
  FConnection := DM.DataBase;
  FNomeTabela := 'RelEstoque';
  inherited;

end;

procedure TfrmRelProdutos.RadioGroup2Click(Sender: TObject);
begin
  if RadioGroup2.ItemIndex > 0 then
    Edit1.Enabled := True
  else
    Edit1.Enabled := False;
end;

end.
