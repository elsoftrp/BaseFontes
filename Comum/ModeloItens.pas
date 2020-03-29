unit ModeloItens;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Variants,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, DBCtrls, uSeek, uModelBase, Data.DB,
  Vcl.Menus, Mask,  uAcoes, JvExMask, JvToolEdit,
  JvMaskEdit, JvDBFindEdit, JvDBControls, FireDAC.Comp.Client;

type
  TfrmModeloItens = class(TfrmModelBase)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnOk: TBitBtn;
    BtnCancelar: TBitBtn;
    PopupMenu1: TPopupMenu;
    Localizar1: TMenuItem;
    DataSource1: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Localizar1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    FConnection: TFDConnection;
    vQuerySql: TFDQuery;
    vCampoChave, vSeq: string;
    FAcao: TAcao;
    FCodigo, FSequencia: Integer;
    FContinua:Boolean;
    FFocoI, FFocoA: TDBEdit;
    FSeek: TSeek;
    function doAcaoIncluirAntesGravar: Boolean; virtual;
    function doAcaoAlterarAntesGravar: Boolean; virtual;
    procedure doGravaDataSets; virtual;
    procedure doFecharDataSets(erro: Boolean = False; cancel: Boolean = False); virtual;
    procedure DoShow; override;
    procedure doLocalizar; virtual;
    procedure doComplementoContinuarIncluindo; virtual;
  public
    { Public declarations }
    constructor Create(AOwer: TComponent; Codigo, Sequencia: Variant; Acao: TAcao; continuaIncluindo: Boolean = True); overload; virtual;
  end;

var
  frmModeloItens: TfrmModeloItens;

implementation

uses Funcoes, uLib, uLocalizar;


{$R *.DFM}

procedure TfrmModeloItens.FormCreate(Sender: TObject);
begin
  //FConnection :=
  //vQuerySql := ;
  //FFocoA := ;
  //FFocoI := ;
  //vCampoChave := '';
  //vSeq := '';
  FSeek         := TSeek.Create(nil,FConnection, False);
end;

procedure TfrmModeloItens.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FSeek);
  inherited;
end;

procedure TfrmModeloItens.FormShow(Sender: TObject);
begin
  BtnOk.Visible       := False;
  BtnCancelar.Visible := False;
  BtnCancelar.Caption := '&Cancelar';
  if FAcao = aIncluir then
  begin
    BtnOk.Visible       := True;
    BtnCancelar.Visible := True;
    if Assigned(FFocoI) then
    begin
      FFocoI.SetFocus;
    end
    else Panel1.SetFocus;
  end
  else if FAcao = aAlterar then
  begin
    if (Assigned(FFocoI)) and (Assigned(FFocoA)) then
    begin
      FFocoI.Enabled      := False;
      FFocoA.Enabled      := True;
      FFocoA.SetFocus;
    end
    else Panel1.SetFocus;
    BtnOk.Visible       := True;
    BtnCancelar.Visible := True;
  end
  else if (FAcao = aConsultar) then
  begin
    BtnCancelar.Caption := ' &Fechar';
    BtnCancelar.Visible := True;
    BtnCancelar.SetFocus;
    Panel1.Enabled      := False;
  end;
end;

procedure TfrmModeloItens.BtnOkClick(Sender: TObject);
var
  x:Integer;
begin
  if (vQuerySql.State = dsInsert) or (vQuerySql.State = dsEdit) then
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
    if not doAcaoIncluirAntesGravar() then
    begin
      Exit;
    end;
  end;
  if FAcao = aAlterar then
  begin
    if not doAcaoAlterarAntesGravar() then
    begin
      Exit;
    end;
  end;
  if (vQuerySql.state = dsEdit) or (vQuerySql.state = dsInsert) then
  begin
    vQuerySql.Post;
    doGravaDataSets();
  end;
  if (FAcao = aIncluir) and (FContinua) then
  begin
    if TLib.Mensagem('Aviso', 'Deseja Continuar incluindo Itens','?')=idYes then
    begin
      vQuerySql.Append;
      vQuerySql.FieldByName(vCampoChave).AsInteger := FCodigo;
      doComplementoContinuarIncluindo();
      FFocoI.SetFocus;
    end
    else
    begin
      doFecharDataSets();
      Close;
    end;
  end
  else
  begin
    doFecharDataSets();
    Close;
  end;
end;

constructor TfrmModeloItens.Create(AOwer: TComponent; Codigo, Sequencia: Variant;
  Acao: TAcao; continuaIncluindo: Boolean = True);
begin
  inherited Create(AOwer);
  FCodigo      := Codigo;
  FSequencia   := Sequencia;
  FAcao        := Acao;
  FContinua    := continuaIncluindo;
end;

function TfrmModeloItens.doAcaoAlterarAntesGravar: Boolean;
begin

end;

function TfrmModeloItens.doAcaoIncluirAntesGravar: Boolean;
begin
  Result := True;
  if vSeq <> '' then
  begin
    vQuerySql.FieldByName(vSeq).AsInteger := FSequencia;
    Inc(FSequencia);
  end;
end;

procedure TfrmModeloItens.doComplementoContinuarIncluindo;
begin

end;

procedure TfrmModeloItens.doFecharDataSets(erro, cancel: Boolean);
begin

end;

procedure TfrmModeloItens.doGravaDataSets;
begin

end;

procedure TfrmModeloItens.doLocalizar;
begin
  if (ActiveControl is TDBEdit) then
    (ActiveControl as TDBEdit).Field.asString := TLocalizar.Busca((ActiveControl as TDBEdit).Field.FieldName)
  else if (ActiveControl is TEdit) then
    (ActiveControl as TEdit).Text := TLocalizar.Busca((ActiveControl as TEdit).Name );
end;

procedure TfrmModeloItens.DoShow;
begin
  doConfigureForm();
  inherited;
end;

procedure TfrmModeloItens.BtnCancelarClick(Sender: TObject);
begin
  if (vQuerySql.state = dsEdit) or (vQuerySql.state = dsInsert) then
  begin
    try
      vQuerySql.Cancel;
      doFecharDataSets(False, True);
      Close;
    except
    end;
  end
  else
    Close;
end;

procedure TfrmModeloItens.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key of
    #13: Perform(Wm_NextDlgCtl, 0, 0);
    #38: Perform(Wm_NextDlgCtl, 1, 0);
    #27:btnCancelar.Click;
  end;
  if Key in [#27,#38,#13] then key := #0;
end;

procedure TfrmModeloItens.Localizar1Click(Sender: TObject);
begin
  doLocalizar();
end;


end.
