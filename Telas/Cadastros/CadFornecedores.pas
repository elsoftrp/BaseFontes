unit CadFornecedores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ModeloDiretoDac, DB, ActnList, Menus, ActnPopup, ImgList, Buttons,
  StdCtrls, ExtCtrls, Mask, DBCtrls, JvExMask, JvToolEdit, JvDBControls, uSeek, uAcoes,
  System.Actions, Vcl.PlatformDefaultStyleActnCtrls, ulib;

type
  TfrmCadFornecedores = class(TfrmModeloDiretoDac)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label15: TLabel;
    DBEdit15: TDBEdit;
    Label16: TLabel;
    DBEdit16: TDBEdit;
    DBEdit2: TJvDBDateEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    DBText1: TDBText;
    DBText4: TDBText;
    procedure FormShow(Sender: TObject);
    procedure DBEdit12Exit(Sender: TObject);
    procedure DBEdit3Enter(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure DBEdit3KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ComplementoSaidaCampoChave; override;
  end;

var
  frmCadFornecedores: TfrmCadFornecedores;

implementation

uses Funcoes, DataModulo;

{$R *.dfm}

procedure TfrmCadFornecedores.ComplementoSaidaCampoChave;
begin
  vQuerydac.FieldByName('DataCad').AsDateTime := FDireitos.DataHoje;
end;

procedure TfrmCadFornecedores.DBEdit12Exit(Sender: TObject);
begin
  if (btnCancelar.Focused) then exit;
  if (Sender as TDBEdit).Text = '' then Exit;
  if not fseek.Seek('Cidades',1,['CodCidade'],[(Sender as TDBEdit).Text]) then
  begin
    tlib.Mensagem('Aviso','Cidade n�o encontrada.','E');
    (Sender as TDBEdit).SetFocus;
    exit;
  end;
  vQuerydac.FieldByName('cidade').asString   := fseek.Qry.FieldByName('cidade').asString;
  vQuerydac.FieldByName('Estado').asString   := fseek.Qry.FieldByName('Estado').asString;
end;

procedure TfrmCadFornecedores.DBEdit3Enter(Sender: TObject);
begin
  vQuerydac.FieldByName('CnpjFor').EditMask := '';
end;

procedure TfrmCadFornecedores.DBEdit3Exit(Sender: TObject);
begin
  if (btnCancelar.Focused) or (FAcao = aSemAcao) then exit;
  if (Sender as TDBEdit).Text = '' then exit;
  if (length((Sender as TDBEdit).Text) = 11) or (length((Sender as TDBEdit).Text) = 14) then
  begin
    if tlib.FCgcCpf((Sender as TDBEdit).Text) = False then
    begin
      (Sender as TDBEdit).SetFocus;
      exit;
    end;
    if length((Sender as TDBEdit).Text) = 14 then
      vQuerydac.FieldByName('CnpjFor').EditMask :=  '99.999.999/9999-99;0; '
    else if length((Sender as TDBEdit).Text) = 11 then
      vQuerydac.FieldByName('CnpjFor').EditMask :=  '999.999.999-99;0; '
    else
      vQuerydac.FieldByName('CnpjFor').EditMask :=  '';
  end;
  if Fseek.Seek('Fornecedores',1,['CnpjFor'],[(Sender as TDBEdit).Text]) then
  begin
    if fseek.Qry.FieldByName(FCampoChave).asInteger = vQuerydac.FieldByname(FCampoChave).asInteger then
      exit
    else
    begin
      tlib.Mensagem('Aviso','CNPJ j� Cadastrado.','!');
      (Sender as TDBEdit).SetFocus;
      exit;
    end;
  end;
end;

procedure TfrmCadFornecedores.DBEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8,#3,#22]) then
    key := #0;
end;

procedure TfrmCadFornecedores.FormShow(Sender: TObject);
begin
  FConnection := DM.DataBase;
  vQuerydac   := DM.SQLFornecedores;
  FNomeTabela := 'Fornecedores';
  FCampoChave := 'CodFor';
  FFocoI := DBEdit1;
  FFocoA := DBEdit1;

  DBEdit13.OnKeyUp  := tlib.FormatarFone;
  DBEdit15.OnKeyUp  := tlib.FormatarCelular;
  inherited;

end;

end.
