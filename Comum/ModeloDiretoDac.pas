unit ModeloDiretoDac;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, ExtCtrls, Menus, Mask, DBCtrls,
  Variants, ImgList, ActnList, ActnMan,  ActnCtrls,
  ActnPopup, DBClient, ComCtrls, uFormBaseDac,
  uAcoes, uDireitos, uSeek, System.Actions, Vcl.PlatformDefaultStyleActnCtrls,
  FireDAC.Comp.Client;

type
  TfrmModeloDiretoDac = class(TFormBaseDac)
    Panel1: TPanel;
    Panel3: TPanel;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    Panel4: TPanel;
    ImageList1: TImageList;
    PopupActionBar1: TPopupActionBar;
    Incluir1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Consultar1: TMenuItem;
    Localizar1: TMenuItem;
    ActionList1: TActionList;
    acIncluir: TAction;
    acAlterar: TAction;
    acExcluir: TAction;
    acConsultar: TAction;
    acLocalizar: TAction;
    acImprimir: TAction;
    acFechar: TAction;
    DS: TDataSource;
    pnlBar: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    pnlSeparador: TPanel;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton5: TSpeedButton;
    acBaixar: TAction;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure acIncluirExecute(Sender: TObject);
    procedure acAlterarExecute(Sender: TObject);
    procedure acExcluirExecute(Sender: TObject);
    procedure acConsultarExecute(Sender: TObject);
    procedure acLocalizarExecute(Sender: TObject);
    procedure acFecharExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acImprimirExecute(Sender: TObject);
    procedure acBaixarExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    FDireitos : TDireitos;
    FTipo: String;
    FCodigo: String;
    FAcaoExterno: TAcao;
    FAcao: TAcao;
    FSomLeitura: Boolean;
    FSeek: TSeek;
    FConnection: TFDConnection;
    vQuerydac:TFDQuery;
    vCancel:Boolean;
    FCampoChave, FCampoChave2, FCampoChave3, FNomeTabela, FCaption:string;
    FFocoI, FFocoA, FFocoAtend:TDBEdit;
    procedure ClicaAutomatico; virtual;
    function ExisteDescricao(campo: string): Boolean; virtual;
    // CRUD
    procedure SaidaCampoChave(Sender: TObject); virtual;
    procedure ComplementoSaidaCampoChave; virtual;
    procedure ComplementoNaoIncluirSaidaCampoChave; virtual;
    procedure AntesDeGravarConfirmado; virtual;
    procedure doAbrirJanela; virtual;
    procedure LiberarBtn; virtual;
    procedure Incluir;    virtual;
    procedure Alterar;    virtual;
    procedure Consultar;  virtual;
    procedure Excluir;    virtual;
    procedure Baixar;     virtual;
    procedure Localizar;  virtual;
    procedure Imprimir;   virtual;
    procedure Fechar;     virtual;
    procedure Gravar;     virtual;
    procedure Cancelar;   virtual;
    procedure doGravaDataSets; virtual;
    procedure doFecharDataSets(erro: Boolean = False; cancel: Boolean = False); virtual;
    procedure doLiberarDataSetFechado; virtual;
    procedure doLiberarDataSetAberto; virtual;
    procedure doAntesFecharDataSetsIncluir; virtual;
    function doLookup(Sender: TObject; pObrigatorio: Boolean = False): Boolean; virtual;
  public
    { Public declarations }
    constructor Create(AOwer: TComponent; Tipo: string; Codigo: Variant; Acao: TAcao = aAlterar); overload; virtual;
  end;

var
  frmModeloDiretoDac: TfrmModeloDiretoDac;


implementation

uses uOperacaoBD, uUsuario, uLocalizar, uLib;

{$R *.DFM}

procedure TfrmModeloDiretoDac.FormShow(Sender: TObject);
begin
  {  campos p/ serem mudados em cadastros comuns alterar estes campos
  FConnection := DM.;
  vQuerydac   := DM.;
  FCampoChave := ;
  FNomeTabela := ;
  FFocoI := DBEdit1;
  FFocoA := DBEdit1;
  }
  //
  //doAbrirJanela;
  FDireitos     := TDireitos.Create(FNomeTabela, TUsuario.GetInstance.Login, TUsuario.GetInstance.Perfil, FConnection);
  FCaption      := FDireitos.Descricao;
  FSomLeitura   := True;
  FFocoI.OnExit := SaidaCampoChave;
  (Sender as TForm).Caption := FCaption;
  btnOk.Left       := round((Sender as TForm).Width/3)-round(btnOk.Width/2);
  btnCancelar.Left := btnOk.Left+round((Sender as TForm).Width/3);
  LiberarBtn;
  FSeek         := TSeek.Create(nil,FConnection, False);
  ClicaAutomatico;
end;

procedure TfrmModeloDiretoDac.acFecharExecute(Sender: TObject);
begin
  Fechar;
end;

procedure TfrmModeloDiretoDac.acAlterarExecute(Sender: TObject);
begin
  Alterar;
end;

procedure TfrmModeloDiretoDac.acBaixarExecute(Sender: TObject);
begin
  Baixar;
end;

procedure TfrmModeloDiretoDac.acConsultarExecute(Sender: TObject);
begin
  Consultar;
end;

procedure TfrmModeloDiretoDac.acExcluirExecute(Sender: TObject);
begin
  Excluir;
end;

procedure TfrmModeloDiretoDac.acImprimirExecute(Sender: TObject);
begin
  Imprimir;
end;

procedure TfrmModeloDiretoDac.acIncluirExecute(Sender: TObject);
begin
  Incluir;
end;

procedure TfrmModeloDiretoDac.acLocalizarExecute(Sender: TObject);
begin
  Localizar;
end;

procedure TfrmModeloDiretoDac.btnOkClick(Sender: TObject);
begin
  Gravar;
end;

constructor TfrmModeloDiretoDac.Create(AOwer: TComponent; Tipo: string; Codigo: Variant; Acao: TAcao = aAlterar);
begin
  inherited Create(AOwer);
  FTipo        := Tipo;
  FCodigo      := Codigo;
  FAcaoExterno := Acao;
end;

procedure TfrmModeloDiretoDac.doAbrirJanela;
begin

end;

procedure TfrmModeloDiretoDac.doAntesFecharDataSetsIncluir;
begin

end;

procedure TfrmModeloDiretoDac.doFecharDataSets(erro: Boolean; cancel: Boolean);
begin

end;

procedure TfrmModeloDiretoDac.doGravaDataSets;
begin

end;

procedure TfrmModeloDiretoDac.doLiberarDataSetAberto;
begin

end;

procedure TfrmModeloDiretoDac.doLiberarDataSetFechado;
begin

end;

function TfrmModeloDiretoDac.doLookup(Sender: TObject; pObrigatorio: Boolean): Boolean;
begin
  Result := False;
  if (btnCancelar.Focused) or (FAcao = aSemAcao) then exit;
  if (Sender is TDBEdit) then
  begin
    if ((Sender as TDBEdit).Text = '') and (not (Sender as TDBEdit).Field.Required) then exit
    else if ((Sender as TDBEdit).Text = '') and ((Sender as TDBEdit).Field.Required) then
    begin
      TLib.Mensagem('Aviso', (Sender as TDBEdit).Hint + ' tem que ser informado(a).','!');
      (Sender as TDBEdit).SetFocus;
      exit;
    end;
    Result := True;
  end;
end;

procedure TfrmModeloDiretoDac.LiberarBtn;
begin
  if (vQuerydac.State = DsEdit) or (vQuerydac.State = DsInsert) then
  begin
    acIncluir.Enabled   := False;
    acAlterar.Enabled   := False;
    acExcluir.Enabled   := False;
    acConsultar.Enabled := False;
    acBaixar.Enabled    := False;
    acLocalizar.Enabled := True;
    btnOk.Caption       := '&Ok';
    btnOk.Enabled       := True;
    btnCancelar.Caption := '&Cancelar';
    btnCancelar.Enabled := True;
    doLiberarDataSetAberto();
  end
  else
  begin
    FAcao := aSemAcao;
    acIncluir.Enabled   := FDireitos.Incluir;
    acAlterar.Enabled   := FDireitos.Alterar;
    acExcluir.Enabled   := FDireitos.Excluir;
    acConsultar.Enabled := FDireitos.Visualizar;
    acBaixar.Enabled    := FDireitos.Chave1;
    btnOk.Caption       := '&Ok';
    btnOk.Enabled       := False;
    btnCancelar.Caption := '&Cancelar';
    btnCancelar.Enabled := False;
    Panel4.Enabled      := False;
    Caption             := FCaption;
    acLocalizar.Enabled := False;
    doLiberarDataSetFechado();
  end
end;

procedure TfrmModeloDiretoDac.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vQuerydac.Cancel;
  vQuerydac.Close;
  doFecharDataSets;
  inherited;
end;

procedure TfrmModeloDiretoDac.btnCancelarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  btnCancelar.Click;
end;

procedure TfrmModeloDiretoDac.btnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmModeloDiretoDac.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ((vQuerydac.State = dsEdit) or (vQuerydac.State = dsInsert)) and (vCancel = False) then
  begin
    if Application.messagebox('Deseja Abandonar a Opera��o ? ? ?', vp, mb_YesNo) = idYes then
      vQuerydac.Cancel
    else
      CanClose:=false;
  end;
end;

procedure TfrmModeloDiretoDac.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDireitos);
  FreeAndNil(FSeek);
end;

procedure TfrmModeloDiretoDac.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key of
    #13: Perform(Wm_NextDlgCtl, 0, 0);
    #38: Perform(Wm_NextDlgCtl, 1, 0);
    #27:begin
          if btnCancelar.Enabled = True then
          begin
            btnCancelar.SetFocus;
            btnCancelar.Click;
          end
          else
            acFechar.Execute;
        end;
  end;
  if Key in [#27,#38,#13] then key := #0;
end;

procedure TfrmModeloDiretoDac.Incluir;
var
  vContador, Y, x:Integer;
begin
  vCancel := True;
  Caption := Caption+' - "Inclus�o"';
  FAcao := aIncluir;
  Panel4.Enabled := True;
  vQuerydac.Close;
  for x:=0 to (vQuerydac.Params.Count-1) do
  begin
    vQuerydac.Params[x].Clear;
  end;
  vQuerydac.Open;
  vQuerydac.Insert;
  if (vQuerydac.Params.Count = 1) and (vQuerydac.Fields[0].DataType = ftInteger) then
  begin
    y := 0;
    While y < 6 do
    begin
      if y = 5 then
      begin
        vQuerydac.Close;
        ShowMessage('N�o Possivel Concluir a Inclus�o.'+chr(13)+'Tente Novamente');
        LiberarBtn;
        exit;
      end;
      try
        vContador :=  TOperacaoBD.ContadorDac(FConnection, FCampochave);
        break;
      except
        Inc(y);
        Continue;
      end;
      Inc(y);
    end;
    vQuerydac.FieldByName(FCampoChave).Value := IntToStr(vContador);
  end;
  for x:=0 to vQuerydac.FieldCount -1 do
  begin
    if vQuerydac.Fields[x].DataType = ftCurrency  then
       vQuerydac.Fields[x].AsCurrency := 0;
  end;
  //
  //vFocoA.Enabled := False;
  if FFocoI.Text <> '' then
    FFocoI.ReadOnly := FSomLeitura;
  vCancel := False;
  FFocoI.SetFocus;
  LiberarBtn;
end;

procedure TfrmModeloDiretoDac.Alterar;
var
  x:Integer;
begin
  vCancel := True;
  Caption := Caption+' - "Altera��o"';
  FAcao := aAlterar;
  Panel4.Enabled := True;
  vQuerydac.Close;
  for x:=0 to (vQuerydac.Params.Count-1) do
  begin
    vQuerydac.Params[x].Clear;
  end;
  vQuerydac.Open;
  vQuerydac.Edit;
  FFocoA.Enabled := True;
  FFocoA.SetFocus;
  LiberarBtn;
end;

procedure TfrmModeloDiretoDac.AntesDeGravarConfirmado;
begin

end;

procedure TfrmModeloDiretoDac.Baixar;
var
  x:Integer;
begin
  vCancel := True;
  Caption := Caption+' - "Baixar"';
  FAcao := aBaixar;
  Panel4.Enabled := True;
  vQuerydac.Close;
  for x:=0 to (vQuerydac.Params.Count-1) do
  begin
    vQuerydac.Params[x].Clear;
  end;
  vQuerydac.Open;
  vQuerydac.Edit;
  FFocoA.Enabled := True;
  FFocoA.SetFocus;
  LiberarBtn;
end;

procedure TfrmModeloDiretoDac.ComplementoNaoIncluirSaidaCampoChave;
begin

end;

procedure TfrmModeloDiretoDac.ComplementoSaidaCampoChave;
begin

end;

procedure TfrmModeloDiretoDac.Consultar;
var
  x:Integer;
begin
  vCancel := True;
  Caption := Caption+' - "Consultar" ';
  FAcao := aConsultar;
  Panel4.Enabled := True;
  vQuerydac.Close;
  for x:=0 to (vQuerydac.Params.Count-1) do
  begin
    vQuerydac.Params[x].Clear;
  end;
  vQuerydac.Open;
  vQuerydac.Edit;
  FFocoA.Enabled := True;
  FFocoA.SetFocus;
  LiberarBtn;
  //btnOk.Enabled := False;
  btnCancelar.Caption := '&Fechar';
end;

procedure TfrmModeloDiretoDac.Excluir;
var
  x:Integer;
begin
  vCancel := True;
  Caption := Caption+' - "Exclus�o"';
  Panel4.Enabled := True;
  vQuerydac.Close;
  for x:=0 to (vQuerydac.Params.Count-1) do
  begin
    vQuerydac.Params[x].Clear;
  end;
  vQuerydac.Open;
  vQuerydac.Edit;
  FFocoA.Enabled := True;
  FFocoA.SetFocus;
  FAcao := aExcluir;
  LiberarBtn;
  btnOk.Caption := '&Excluir';
end;

function TfrmModeloDiretoDac.ExisteDescricao(campo: string): Boolean;
begin
  Result := False;
  if DS.DataSet.FieldByName(campo).AsString <> EmptyStr then
  begin
    if FSeek.Seek(FNomeTabela,1,[campo],[ DS.DataSet.FieldByName(campo).AsString ]) then
    begin
      if vQuerydac.FieldByName(FCampoChave).asInteger <> FSeek.Qry.FieldByName(FCampoChave).asInteger then
      begin
        Result := True;
      end;
    end;
  end;
end;

procedure TfrmModeloDiretoDac.Localizar;
begin
  try
    if (ActiveControl is TDBEdit) then
      (ActiveControl as TDBEdit).Field.asString := TLocalizar.Busca((ActiveControl as TDBEdit).Field.FieldName);
  except
    ShowMessage('Consulta n�o foi localizada !');
  end;
end;

procedure TfrmModeloDiretoDac.SaidaCampoChave(Sender: TObject);
var
  vChave: Integer;
begin
  if (btnCancelar.Focused) or (FAcao = aSemAcao) then exit;
  if (Sender as TDBEdit).Text = '' then
  begin
    TLib.Mensagem('Aviso','C�digo tem que ser informado.','!');
    (Sender as TDBEdit).SetFocus;
    exit;
  end;
  vChave := StrToInt((Sender as TDBEdit).Text);
  vQuerydac.Close;
  vQuerydac.ParamByName(FCampoChave).AsInteger := vChave;
  vQuerydac.Open;
  if vQuerydac.IsEmpty = False then
  begin
    if FAcao = aExcluir then
    begin
      vCancel := False;
      vQuerydac.Cancel;
      Panel4.Enabled := False;
    end
    else if FAcao = aConsultar then
    begin
      Panel4.Enabled := False;
    end
    else if FAcao = aBaixar then
    begin
      Panel4.Enabled := False;
      vQuerydac.Edit;
    end
    else if FAcao = aAlterar then
    begin
      vCancel := False;
      vQuerydac.Edit;
    end
    else
    begin
      vQuerydac.Close;
      vQuerydac.ParamByName(FCampoChave).Clear;
      vQuerydac.Open;
      vQuerydac.Append;
      TLib.Mensagem('Aviso','C�digo j� Cadastrado.','!');
      FFocoI.SetFocus;
    end;
    ComplementoNaoIncluirSaidaCampoChave;
  end
  else
  begin
    if FAcao <> aIncluir then
    begin
      vQuerydac.Close;
      vQuerydac.ParamByName(FCampoChave).Clear;
      vQuerydac.Open;
      vQuerydac.Append;
      TLib.Mensagem('Aviso','C�digo n�o Cadastrado.','!');
      FFocoA.SetFocus;
    end
    else
    begin
      vCancel := False;
      vQuerydac.Append;
      vQuerydac.FieldByName(FCampoChave).AsInteger   := vChave;
      ComplementoSaidaCampoChave;
      FFocoI.Enabled := False;
    end;
  end;
end;

procedure TfrmModeloDiretoDac.Imprimir;
begin

end;

procedure TfrmModeloDiretoDac.Fechar;
var
  Y:Integer;
begin
  if (vQuerydac.State = dsInsert) and (vQuerydac.Params.Count = 1) and (vQuerydac.Fields[0].DataType = ftInteger) then
  begin
    y := 0;
    While y < 6 do
    begin
      try
        if TOperacaoBD.ContadorDac(FConnection,FCampoChave,'-',vQuerydac.FieldByName(FCampoChave).asInteger) = -1 then
           Break
        else
           Break;
      except
        Inc(y);
        Continue;
      end;
      Inc(y);
    end;
  end;
  Close;
end;

procedure TfrmModeloDiretoDac.Gravar;
var x:Integer;
begin
  if (FAcao = aIncluir) or (FAcao = aAlterar) then //(vQuerydac.State = dsInsert) or (vQuerydac.State = dsEdit) then
  begin
    for x:=0 to vQuerydac.FieldCount -1 do
      With vQuerydac do
      begin
        if (Fields[x].required) then
        begin
          if (Fields[x].AsString= '') then
          begin
            MessageDlg(Format('O Campo  "%s"  precisa ser prenchido.',[Fields[x].DisplayLabel]),mtError,[mbOk],0);
            Fields[x].FocusControl;
            exit;
          end;
        end;
      end;
  end;
  if FAcao = aIncluir then
  Begin
    if Application.messagebox('Confirma Inclus�o?', vp, mb_okcancel) = idok then
    begin
      AntesDeGravarConfirmado();
      FConnection.StartTransaction;
      try
        vQuerydac.Post;
        //Grava Log
        TOperacaoBD.GravalogDac(FConnection,TLib.DataServidor(FConnection), TUsuario.GetInstance.Id , TUsuario.GetInstance.Login ,'Inclus�o',FNomeTabela,Caption,TLib.CampoChave(vQuerydac,FCampoChave),
           Tlib.CampoChave(vQuerydac,FCampoChave2), TLib.CampoChave(vQuerydac,FCampoChave3));
        //
        doGravaDataSets;
        vQuerydac.ApplyUpdates;
        FConnection.Commit;
      except
        FConnection.Rollback;
        doFecharDataSets(True);
        vQuerydac.Close;
        ShowMessage('N�o foi possivel concluir esta Inclus�o');
        LiberarBtn;
        Application.Terminate;
      end;
      vQuerydac.CommitUpdates;
      doAntesFecharDataSetsIncluir;
      vQuerydac.Close;
      doFecharDataSets;
      LiberarBtn;
      FFocoI.Enabled  := True;
      FFocoI.ReadOnly := False;
      if FTipo <> '' then
      begin
        ModalResult := mrOk;
        exit;
      end;
      //acIncluir.Execute;
    end
    else
      Exit;
  end
  else if FAcao = aAlterar then
  begin
    if Application.messagebox('Confirma Altera��o?', vp, mb_okcancel) = idOk then
    begin
      FConnection.StartTransaction;
      try
        vQuerydac.Post;
        //Grava Log
        TOperacaoBD.GravalogDac(FConnection,TLib.DataServidor(FConnection), TUsuario.GetInstance.Id , TUsuario.GetInstance.Login,'Alterar',FNomeTabela,Caption,TLib.CampoChave(vQuerydac,FCampoChave),
           TLib.CampoChave(vQuerydac,FCampoChave2), TLib.CampoChave(vQuerydac,FCampoChave3));
        //
        doGravaDataSets;
        vQuerydac.ApplyUpdates;
        FConnection.Commit;
      except
        FConnection.Rollback;
        doFecharDataSets(True);
        vQuerydac.Close;
        ShowMessage('N�o foi possivel concluir esta Altera��o');
        LiberarBtn;
        Application.Terminate;
      end;
      vQuerydac.CommitUpdates;
      vQuerydac.Close;
      doFecharDataSets;
      LiberarBtn;
      if FTipo <> '' then
      begin
        ModalResult := mrOk;
        exit;
      end;
      //acAlterar.Execute;
    end
    else
      Exit;
  end
  else if FAcao = aBaixar then
  begin
    if Application.messagebox('Confirma Baixa?', vp, mb_okcancel) = idOk then
    begin
      FConnection.StartTransaction;
      try
        vQuerydac.Post;
        //Grava Log
        TOperacaoBD.GravalogDac(FConnection,TLib.DataServidor(FConnection), TUsuario.GetInstance.Id , TUsuario.GetInstance.Login,'Baixa',FNomeTabela,Caption,TLib.CampoChave(vQuerydac,FCampoChave),
           TLib.CampoChave(vQuerydac,FCampoChave2), TLib.CampoChave(vQuerydac,FCampoChave3));
        //
        doGravaDataSets;
        vQuerydac.ApplyUpdates;
        FConnection.Commit;
      except
        FConnection.Rollback;
        doFecharDataSets(True);
        vQuerydac.Close;
        ShowMessage('N�o foi possivel concluir esta Baixa');
        LiberarBtn;
        Application.Terminate;
        raise;
      end;
      vQuerydac.CommitUpdates;
      vQuerydac.Close;
      doFecharDataSets;
      LiberarBtn;
    end
    else
      Exit;
  end
  else
  begin
    if FAcao = aExcluir then
    begin
      if Application.messagebox('Confirma Exclus�o?', vp, mb_okcancel) = idOk then
      begin
        FConnection.StartTransaction;
        try
          //Grava Log
        TOperacaoBD.GravalogDac(FConnection,TLib.DataServidor(FConnection), TUsuario.GetInstance.Id , TUsuario.GetInstance.Login,'Exclus�o',FNomeTabela,Caption,TLib.CampoChave(vQuerydac,FCampoChave),
           TLib.CampoChave(vQuerydac,FCampoChave2), TLib.CampoChave(vQuerydac,FCampoChave3));
          //
          doGravaDataSets;
          vQuerydac.Delete;
          vQuerydac.ApplyUpdates;
          FConnection.Commit;
        except
          FConnection.Rollback;
          doFecharDataSets(True);
          vQuerydac.Cancel;
          vQuerydac.Close;
          ShowMessage('N�o foi possivel concluir esta Exclus�o');
          liberarbtn;
          Application.Terminate;
        end;
        vQuerydac.CommitUpdates;
        vQuerydac.Close;
        doFecharDataSets;
        liberarBtn;
      end
      else
      begin
        doFecharDataSets;
        vQuerydac.Close;
        Liberarbtn;
      end;
    end
    else if FAcao = aConsultar then
    begin
      vQuerydac.Close;
      doFecharDataSets;
      Liberarbtn;
      //acConsultar.Execute;
    end;
  end;
end;

procedure TfrmModeloDiretoDac.Cancelar;
var
  Y:Integer;
begin
  if vCancel = True then
  begin
    if (vQuerydac.State = dsInsert) and (vQuerydac.Params.Count = 1) and (vQuerydac.Fields[0].DataType = ftInteger) then
    begin
      y := 0;
      While y < 6 do
      begin
        try
        if TOperacaoBD.ContadorDac(FConnection, FCampoChave,'-',vQuerydac.FieldByName(FCampoChave).asInteger) = -1 then
           break
        else
           break;
        except
        Inc(y);
        Continue;
        end;
        Inc(y);
      end;
    end;
  end
  else if ((vQuerydac.State = dsEdit) or (vQuerydac.State = dsInsert)) then
  begin
    if Application.messagebox('Deseja Abandonar a Opera��o ? ? ?', vp, mb_YesNo) = idYes then
    begin
      //
      if FAcao = aIncluir then //vQuerydac.State = dsInsert then
      begin
        y := 0;
        While y < 6 do
        begin
          try
            if TOperacaoBD.ContadorDac(FConnection, FCampoChave,'-',vQuerydac.FieldByName(FCampoChave).asInteger) = -1 then
            break
            else
            break;
          except
            Inc(y);
            Continue;
          end;
          Inc(y);
        end;
      end;
      //
    end
    else
    Exit;
  end;
  FFocoI.Enabled  := True;
  FFocoI.ReadOnly := False;
  doFecharDataSets(False, True);
  vQuerydac.Close;
  LiberarBtn;
  if FTipo <> '' then
  begin
    Close;
    exit;
  end;
end;

procedure TfrmModeloDiretoDac.ClicaAutomatico;
begin
  if FTipo <> '' then
  begin
    case FAcaoExterno of
      aIncluir: if acIncluir.Enabled then
                begin
                  acIncluir.Execute;
                  //vQuerydac.FieldByName(vCampoChave).Value := FCodigo;
                  keybd_event(vk_Tab,0,0,0);
                end;
      aAlterar: if acAlterar.Enabled then
                begin
                  acAlterar.Execute;
                  vQuerydac.FieldByName(FCampoChave).Value := FCodigo;
                  keybd_event(vk_Tab,0,0,0);
                end;

      aConsultar: if acConsultar.Enabled then
                  begin
                    acConsultar.Execute;
                    vQuerydac.FieldByName(FCampoChave).Value := FCodigo;
                    keybd_event(vk_Tab,0,0,0);
                  end;
      aExcluir: if acExcluir.Enabled then
                begin
                  acExcluir.Execute;
                  vQuerydac.FieldByName(FCampoChave).Value := FCodigo;
                  keybd_event(vk_Tab,0,0,0);
                end;
    end;
  end;
end;

end.


