unit CadUsuarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls,
  DBCtrls, Grids, DBGrids, Mask,  Db, ModeloDiretoDac,
  Vcl.AppEvnts, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup, Vcl.ImgList, uAcoes, uSeek,
  FireDAC.Comp.Client;

type
  TfrmCadUsuarios = class(TfrmModeloDiretoDac)
    Panel5: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Panel6: TPanel;
    IncludeBtn: TSpeedButton;
    IncAllBtn: TSpeedButton;
    ExcludeBtn: TSpeedButton;
    ExAllBtn: TSpeedButton;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    Lista: TListBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBRadioGroup1: TDBRadioGroup;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    Label4: TLabel;
    DataSource1: TDataSource;
    procedure IncludeBtnClick(Sender: TObject);
    procedure IncAllBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure ExAllBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RxDBComboEdit2ButtonClick(Sender: TObject);
    procedure RxDBComboEdit2Exit(Sender: TObject);
  private
    seek: TSeek;
    procedure SetButtons;
    procedure MostraLista;
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ComplementoSaidaCampoChave; override;
    procedure ComplementoNaoIncluirSaidaCampoChave; override;
    procedure doGravaDataSets; override;
    procedure doFecharDataSets(erro: Boolean = False; cancel: Boolean = False); override;
    procedure Gravar; override;
  end;

var
  frmCadUsuarios: TfrmCadUsuarios;

implementation

uses DataModulo, Funcoes, uLib;

{$R *.DFM}

procedure TfrmCadUsuarios.IncludeBtnClick(Sender: TObject);
var
  I,x: Integer;
begin
  Lista.Items.BeginUpdate;
  for I := Lista.Items.Count - 1 downto 0 do
  begin
    if Lista.Selected[I] then
    begin
      DM.SqlProgramasUsuario.Insert;
      DM.SQlProgramasUsuario.FieldByName('btnincluir').AsString := '0';
      DM.SQlProgramasUsuario.FieldByName('btnalterar').AsString := '0';
      DM.SQlProgramasUsuario.FieldByName('btnexcluir').AsString := '0';
      DM.SQlProgramasUsuario.FieldByName('btnvisualizar').AsString := '0';
      DM.SQlProgramasUsuario.FieldByName('btnimprimir').AsString := '0';
      DM.SQlProgramasUsuario.FieldByName('btnchave1').AsString := '0';
      DM.SQlProgramasUsuario.FieldByName('btnchave2').AsString := '0';
      DM.SQlProgramasUsuario.FieldByName('btnchave3').AsString := '0';
      DM.SQlProgramasUsuario.FieldByName('btnchave4').AsString := '0';
//      for x:=0 to DM.SQlProgramasUsuario.FieldCount -1 do
//      begin
//        if DM.SQlProgramasUsuario.Fields[x].DataType = ftBoolean  then
//          DM.SQlProgramasUsuario.Fields[x].asBoolean := False;
//      end;
      DM.SqlProgramasUsuario.FieldByName('CodUsuario').asString := vQueryDac.FieldByName('CodUsuario').asString;

      seek := TSeek.Create(nil, FConnection, False);
      try
        if seek.Seek('Programas',1,['NomePrograma'],[Lista.Items[I]]) then
        begin
          DM.SQlProgramasUsuario.FieldByName('CodPrograma').asString :=
            seek.Qry.FieldByName('CodPrograma').asString;
          DM.SQlProgramasUsuario.FieldByName('NomePrograma').asString :=
            seek.Qry.FieldByName('NomePrograma').asString;
        end;
      finally
        FreeAndNil(seek);
      end;
      Lista.Items.Delete(I);
      DM.SqlProgramasUsuario.Post;
    end;
  end;
  Lista.Items.EndUpdate;
  SetButtons;
  inherited;
end;

procedure TfrmCadUsuarios.IncAllBtnClick(Sender: TObject);
var
  I, x:Integer;
begin
  Lista.Items.BeginUpdate;
  for I := Lista.Items.Count - 1 downto 0 do
  begin
    DM.SqlProgramasUsuario.Insert;
    for x:=0 to DM.SQlProgramasUsuario.FieldCount -1 do
    begin
      if DM.SQlProgramasUsuario.Fields[x].DataType = ftBoolean  then
         DM.SQlProgramasUsuario.Fields[x].asBoolean := False;
    end;
    DM.SqlProgramasUsuario.FieldByName('CodUsuario').asString :=
      vQueryDac.FieldByName('CodUsuario').asString;
    seek := TSeek.Create(nil, FConnection, false);
    try
      if seek.Seek('Programas',1,['NomePrograma'],[Lista.Items[I]]) then
      begin
        DM.SQlProgramasUsuario.FieldByName('CodPrograma').asString :=
           seek.Qry.FieldByName('CodPrograma').asString;
        DM.SQlProgramasUsuario.FieldByName('NomePrograma').asString :=
           seek.Qry.FieldByName('NomePrograma').asString;
      end;
    finally
      FreeAndNil(seek);
    end;
    Lista.Items.Delete(I);
    DM.SqlProgramasUsuario.Post;
  end;
  Lista.Items.EndUpdate;
  SetButtons;
  inherited;
end;

procedure TfrmCadUsuarios.ExcludeBtnClick(Sender: TObject);
begin
  Lista.Items.Add(DM.SqlProgramasUsuario.FieldByName('NomePrograma').asString);
  DM.SqlProgramasUsuario.Delete;
  SetButtons;
  inherited;
end;

procedure TfrmCadUsuarios.ExAllBtnClick(Sender: TObject);
begin
  Lista.Items.BeginUpdate;
  DM.SqlProgramasUsuario.DisableControls;
  DM.SqlProgramasUsuario.First;
  While not DM.SqlProgramasUsuario.eof Do
  begin
    Lista.Items.Add(DM.SqlProgramasUsuario.FieldByName('NomePrograma').asString);
    DM.SqlProgramasUsuario.Delete;
  end;
  DM.SqlProgramasUsuario.EnableControls;
  Lista.Items.EndUpdate;
  SetButtons;
  inherited;
end;

procedure TfrmCadUsuarios.FormShow(Sender: TObject);
begin
  FConnection := DM.Database;
  vQueryDac   := DM.SqlUsuarios;
  FNomeTabela := 'Usuarios';
  FCampoChave := 'CodUsuario';
  FFocoI := DBEdit1;
  FFocoA := DBEdit1;
  inherited;
end;

procedure TfrmCadUsuarios.Gravar;
begin
  if FAcao in [aAlterar, aIncluir] then
  begin
    //vQuerydac.FieldByName('senha').AsString := TLib.Criptar(vQuerydac.FieldByName('senha').AsString);
  end;
  inherited;

end;

procedure TfrmCadUsuarios.SetButtons;
var
  SrcEmpty, DstEmpty: Boolean;
begin
  SrcEmpty := Lista.Items.Count = 0;
  DstEmpty := DM.SqlProgramasUsuario.RecordCount = 0;
  IncludeBtn.Enabled := not SrcEmpty;
  IncAllBtn.Enabled := not SrcEmpty;
  ExcludeBtn.Enabled := not DstEmpty;
  ExAllBtn.Enabled := not DstEmpty;
end;

procedure TfrmCadUsuarios.ComplementoNaoIncluirSaidaCampoChave;
begin
  DM.SqlProgramasUsuario.Close;
  DM.SqlProgramasUsuario.Open;
  vQueryDac.FieldByName('Tipo').asString := 'U';
  DM.SqlProgramasUsuario.Close;
  DM.SqlProgramasUsuario.Open;
  MostraLista;
  SetButtons;

  if FAcao = aAlterar then
  begin
    //vQuerydac.FieldByName('senha').AsString := TLib.DeCriptar(vQuerydac.FieldByName('senha').AsString);
  end;
end;

procedure TfrmCadUsuarios.ComplementoSaidaCampoChave;
begin
  vQueryDac.FieldByName('Tipo').asString := 'U';
  DM.SqlProgramasUsuario.Close;
  DM.SqlProgramasUsuario.Open;
  MostraLista;
  SetButtons;
end;

procedure TfrmCadUsuarios.doFecharDataSets(erro, cancel: Boolean);
begin
  if erro then
  begin
    DM.SqlProgramasUsuario.Cancel;
  end;
  if (not cancel) and (FAcao in [aIncluir, aAlterar, aBaixar]) then
  begin
    DM.SqlProgramasUsuario.CommitUpdates;
  end;
  DM.SqlProgramasUsuario.Close;
end;

procedure TfrmCadUsuarios.doGravaDataSets;
begin
  if FAcao in[aIncluir, aAlterar, aBaixar] then
  begin
    DM.SqlProgramasUsuario.ApplyUpdates;
  end
  else if FAcao = aExcluir then
  begin
    DM.SqlProgramasUsuario.First;
    while not DM.SqlProgramasUsuario.Eof do
    begin
      DM.SqlProgramasUsuario.Delete;
    end;
    DM.SqlProgramasUsuario.ApplyUpdates;
  end;
end;

procedure TfrmCadUsuarios.MostraLista;
var
  Qry: TFDQuery;
begin
  Lista.Items.BeginUpdate;
  Lista.Items.Clear;
  Qry := TFDQuery.Create(nil);
  Qry.Connection := FConnection;
  try
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add('Select NomePrograma from Programas where (CodPrograma Not in '+
       '(Select Programas.CodPrograma from ProgramasUsuario INNER JOIN Programas ON '+
       'ProgramasUsuario.CodPrograma = Programas.CodPrograma  where CodUsuario = :CodUsuario))');
    Qry.ParamByName('CodUsuario').asInteger := vQueryDac.FieldByName('CodUsuario').asInteger;
    Qry.Prepare;
    Qry.Open;
    Qry.DisableControls;
    Qry.First;
    while not Qry.EOF do
    begin
      Lista.Items.Add(Qry.FieldByName('NomePrograma').asString);
      Qry.Next;
    end;
    Qry.EnableControls;
  finally
    Qry.Close;
    freeAndNil(Qry);
  end;
  Lista.Items.EndUpdate;
end;

procedure TfrmCadUsuarios.btnCancelarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DM.SqlProgramasUsuario.Close;
  Lista.Items.Clear;
  inherited;
end;

procedure TfrmCadUsuarios.btnCancelarClick(Sender: TObject);
begin
  inherited;
  Lista.Items.Clear;
  DM.SqlProgramasUsuario.Close;
end;

procedure TfrmCadUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
  DM.SqlProgramasUsuario.Close;
end;

procedure TfrmCadUsuarios.RxDBComboEdit2ButtonClick(Sender: TObject);
begin
  //(Sender as TRxDBComboEdit).Text :=
  //   F.Consultas('Select Login from Usuarios Where Tipo = '+'''P'''+' Order by Login',
  //      'Login',Sender,12);
  inherited;
end;

procedure TfrmCadUsuarios.RxDBComboEdit2Exit(Sender: TObject);
begin
//  if (btnCancelar.Focused) or (vStatus = '') then exit;
//  if (Sender as TRxDBComboEdit).Text = '' then exit;
//  if not F.Seek('Usuarios',1,['Login'],[(Sender as TRxDBComboEdit).Text]) then
//  begin
//    F.Mensagem('Aviso','Perfil não encontrado.','E');
//    (Sender as TRxDBComboEdit).SetFocus;
//    exit;
//  end;
  inherited;
end;

end.
