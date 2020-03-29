unit CadClientes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, uAcoes,
  DBCtrls, Mask, ModeloDiretoDac, DB, ActnList, ActnPopup, ImgList, uSeek,
  System.Actions, Vcl.PlatformDefaultStyleActnCtrls, uLib;

type
  TfrmCadClientes = class(TfrmModeloDiretoDac)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
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
    DBRadioGroup1: TDBRadioGroup;
    Bevel4: TBevel;
    Bevel5: TBevel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBEdit9: TDBEdit;
    Label9: TLabel;
    DBEdit10: TDBEdit;
    Label10: TLabel;
    DBEdit11: TDBEdit;
    Label11: TLabel;
    DBEdit12: TDBEdit;
    DBMemo1: TDBMemo;
    Label12: TLabel;
    procedure FormShow(Sender: TObject);
    procedure DBEdit7Exit(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure DBEdit3Enter(Sender: TObject);
    procedure DBEdit3KeyPress(Sender: TObject; var Key: Char);
  private
    seek: TSeek;
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ComplementoSaidaCampoChave; override;

  end;

var
  frmCadClientes: TfrmCadClientes;

implementation

uses Funcoes, DataModulo;

{$R *.DFM}

procedure TfrmCadClientes.FormShow(Sender: TObject);
begin
  FConnection := DM.Database;
  VQueryDac   := DM.SQLClientes;
  FCampoChave := 'CodCli';
  FNomeTabela := 'Clientes';
  FFocoI := DBEdit1;
  FFocoA := DBEdit1;

  inherited;
  DBEdit8.OnKeyUp  := tlib.FormatarFone;
  DBEdit11.OnKeyUp := tlib.FormatarCelular;
end;

procedure TfrmCadClientes.ComplementoSaidaCampoChave;
begin
  vQuerydac.FieldByName('Inativo').asString := 'A';
end;

procedure TfrmCadClientes.DBEdit3Enter(Sender: TObject);
begin
  vQuerydac.FieldByName('Cpf').EditMask := '';
end;

procedure TfrmCadClientes.DBEdit3Exit(Sender: TObject);
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
      vQuerydac.FieldByName('Cpf').EditMask :=  '99.999.999/9999-99;0; '
    else if length((Sender as TDBEdit).Text) = 11 then
      vQuerydac.FieldByName('Cpf').EditMask :=  '999.999.999-99;0; '
    else
      vQuerydac.FieldByName('Cpf').EditMask :=  '';
  end;
  if Fseek.Seek('Clientes',1,['Cpf'],[(Sender as TDBEdit).Text]) then
  begin
    if fseek.Qry.FieldByName(FCampoChave).asInteger = vQuerydac.FieldByname(FCampoChave).asInteger then
      exit
    else
    begin
      tlib.Mensagem('Aviso','CPF/CNPJ j� Cadastrado.','!');
      (Sender as TDBEdit).SetFocus;
      exit;
    end;
  end;
end;

procedure TfrmCadClientes.DBEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8,#3,#22]) then
    key := #0;
end;

procedure TfrmCadClientes.DBEdit7Exit(Sender: TObject);
begin
  if (btnCancelar.Focused) or (FAcao = aSemAcao) then exit;
  if (Sender as TDBEdit).Text = '' then exit;
  if not Fseek.Seek('Cidades',1,['CodCidade'],[(Sender as TDBEdit).Text]) then
  begin
    ShowMessage('Aviso, Cidade n�o Encontrada!');
    (Sender as TDBEdit).SetFocus;
    exit;
  end;
  vQuerydac.FieldbyName('cidade').asString := Fseek.Qry.FieldByName('cidade').asString;
  vQuerydac.FieldbyName('estado').asString := Fseek.Qry.FieldByName('Estado').asString;
end;

end.
