unit CadProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ModeloDiretoDac, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup, Vcl.ImgList, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, JvExMask, JvToolEdit, JvDBControls, uLib;

type
  TfrmCadProdutos = class(TfrmModeloDiretoDac)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Bevel1: TBevel;
    DBText1: TDBText;
    Bevel2: TBevel;
    DBText2: TDBText;
    Bevel3: TBevel;
    DBText3: TDBText;
    DBEdit11: TJvDBDateEdit;
    DBRadioGroup1: TDBRadioGroup;
    DBRadioGroup2: TDBRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure DBEdit6Exit(Sender: TObject);
    procedure DBEdit7Exit(Sender: TObject);
    procedure DBEdit8Exit(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
  private
    procedure Atualiza(campo: string);
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ComplementoSaidaCampoChave; override;
  end;

var
  frmCadProdutos: TfrmCadProdutos;

implementation

{$R *.dfm}

uses DataModulo;

procedure TfrmCadProdutos.Atualiza(campo: string);
begin
  if ((vQuerydac.State = dsEdit) or (vQuerydac.State = dsInsert)) then
  begin
    if campo = ('PRCOMPRA') then
    begin
      if (vQuerydac.FieldByName('prcompra').AsString <> '') and (vQuerydac.FieldByName('prcompra').AsCurrency > 0) then
      begin
        vQuerydac.FieldByName('prvenda').AsCurrency := (vQuerydac.FieldByName('prcompra').AsCurrency+((vQuerydac.FieldByName('prcompra').AsCurrency*vQuerydac.FieldByName('prlucro').AsCurrency)/100));
      end;
    end;
    if campo = ('PRLUCRO') then
    begin
      if (vQuerydac.FieldByName('prcompra').AsString <> '') and (vQuerydac.FieldByName('prcompra').AsCurrency > 0) then
      begin
        vQuerydac.FieldByName('prvenda').AsCurrency := (vQuerydac.FieldByName('prcompra').AsCurrency+((vQuerydac.FieldByName('prcompra').AsCurrency*vQuerydac.FieldByName('prlucro').AsCurrency)/100));
      end;
    end;
    if campo = ('PRVENDA') then
    begin
      if ((vQuerydac.FieldByName('prvenda').AsString <> '')  and (vQuerydac.FieldByName('prvenda').AsCurrency > 0)) and
         ((vQuerydac.FieldByName('prcompra').AsString <> '') and (vQuerydac.FieldByName('prcompra').AsCurrency > 0)) then
      begin
        vQuerydac.FieldByName('prlucro').AsCurrency := (((vQuerydac.FieldByName('prvenda').AsCurrency-vQuerydac.FieldByName('prcompra').AsCurrency) / vQuerydac.FieldByName('prcompra').AsCurrency  )*100);
      end;
    end;
  end;
end;

procedure TfrmCadProdutos.ComplementoSaidaCampoChave;
begin
  vQuerydac.FieldByName('cadastro').asDateTime := FDireitos.DataHoje;
  vQuerydac.FieldByName('Inativo').AsString    := 'A';
  vQuerydac.FieldByName('controlalote').AsString    := 'N';
end;

procedure TfrmCadProdutos.DBEdit3Exit(Sender: TObject);
begin
  if (btnCancelar.Focused) then exit;
  if (Sender as TDBEdit).Text = '' then Exit;
  if not Fseek.Seek('Grupos',1,['CodGrupo'],[(Sender as TDBEdit).Text]) then
  begin
    TLib.Mensagem('Aviso','Grupo n�o encontrado.','E');
    (Sender as TDBEdit).SetFocus;
    exit;
  end;
  vQuerydac.FieldByName('desgrupo').AsString  := Fseek.Qry.FieldByName('DesGrupo').asString;
end;

procedure TfrmCadProdutos.DBEdit6Exit(Sender: TObject);
begin
  Atualiza('PRCOMPRA');
end;

procedure TfrmCadProdutos.DBEdit7Exit(Sender: TObject);
begin
  Atualiza('PRLUCRO');
end;

procedure TfrmCadProdutos.DBEdit8Exit(Sender: TObject);
begin
  Atualiza('PRVENDA');
end;

procedure TfrmCadProdutos.FormShow(Sender: TObject);
begin
  FConnection := DM.DataBase;
  vQuerydac   := DM.SQLProdutos;
  FCampoChave := 'CodPro';
  FNomeTabela := 'Produtos';
  FFocoI := DBEdit1;
  FFocoA := DBEdit1;

  inherited;

end;

end.