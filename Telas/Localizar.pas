unit Localizar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db,  Grids, DBGrids, ExtCtrls, Buttons, Menus,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmLocalizar = class(TForm)
    DataSource1: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    BtnOk: TBitBtn;
    BtnCancelar: TBitBtn;
    Panel4: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    btnLocalizar: TBitBtn;
    cboFields: TComboBox;
    Label2: TLabel;
    btnNovo: TBitBtn;
    Query1: TFDQuery;
    procedure DefParamPesq(vCamposSelect:array of String; vvDisplay: array of String;vNomeTabela:String; filtro: string = '');
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLocalizarClick(Sender: TObject);
    procedure cboFieldsDropDown(Sender: TObject);
    procedure cboFieldsClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
    vTabela, FFiltro:String;
    vCampoChave:String;
    vCampos:array[0..10]  of String;
    vDisplay: array[0..10] of String;
  public
    { Public declarations }
    Flag:Boolean;
  end;

var
  frmLocalizar: TfrmLocalizar;

implementation

uses DataModulo, Funcoes, Menu;

{$R *.DFM}


procedure TfrmLocalizar.DefParamPesq(vCamposSelect:array of String; vvDisplay: array of String;vNomeTabela:String; filtro: string = '');
var x,i,vTam:integer;
    vSql:String;
begin
  FFiltro := filtro;
  vTabela := F.PrimeiraParte(vNomeTabela);
  x := 0;
  cboFields.Items.Clear;
  for x := 0 to High(vCamposSelect) do
  begin
    vCampos[x] := vCamposSelect[x];
    vDisplay[x] := vvDisplay[x];
    cboFields.Items.Add(vDisplay[x]);
  end;
  cboFields.ItemIndex := 0;
  with Query1 do
  begin
    Close;
    Sql.Clear;
    vCampoChave := vCampos[cboFields.ItemIndex];
    Sql.Add('Select '+vCampoChave);
    for x := 0 to (cboFields.Items.Count-1) do
    begin
      if vCampoChave = vCampos[x] then Continue;
      Sql.Add(','+vCampos[x]);
    end;
    Sql.Add('from '+vNomeTabela+' where '+vCampoChave+' like :'+vCampoChave+' '+FFiltro);
    Sql.Add('Order by '+vCampoChave);
    Query1.ParamByName(vCampoChave).asString := '0';
    Prepare;
    Open;
    //
    Query1.Fields[0].DisplayLabel := vDisplay[cboFields.ItemIndex];
    for x := 0 to (cboFields.Items.Count-1) do
    begin
      if vCampoChave = vCampos[x] then Continue;
      Query1.Fields[x].DisplayLabel := vDisplay[x];
    end;
  end;
  //
  vTam:=0;
  for i:=0 to DBGrid1.Columns.Count-1 do
    vTam := vTam+DBGrid1.Columns.Items[i].Width;
  //
  if vTam > 700 then
    frmLocalizar.Width := 700
  else if vTam < 530 then
    frmLocalizar.Width := 530
  else
    frmLocalizar.Width:=vTam+28;
  frmLocalizar.ShowModal;
end;

procedure TfrmLocalizar.FormShow(Sender: TObject);
begin
  Flag := False;
  Edit1.Text := '';
  Edit1.SetFocus;
end;

procedure TfrmLocalizar.DBGrid1DblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmLocalizar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfrmLocalizar.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_Down then
    Query1.Next
  else if key = vk_up then
    Query1.Prior
  else if key = vk_return then
  begin
    if Flag = True then
      btnOk.Click
    else
      btnLocalizar.Click;
  end;
end;

procedure TfrmLocalizar.btnLocalizarClick(Sender: TObject);
var
  vStr:String;
  x,y:Integer;
begin
  if Copy(Edit1.Text,1,1) = '*' then
  begin
    VStr := uppercase(Edit1.Text);
    while Pos('*', VStr) > 0 do
      delete(VStr,Pos('*',VStr),1);
    Query1.Close;
    Query1.Params[0].asString := '%'+VStr+'%';
  end
  else
  begin
    Query1.Close;
    Query1.Params[0].asString := uppercase(Edit1.Text)+'%';
  end;
  Query1.Prepare;
  Query1.Open;
  //
  Query1.Fields[0].DisplayLabel := vDisplay[cboFields.ItemIndex];
  Y := 1;
  for x := 0 to (cboFields.Items.Count-1) do
  begin
    if vCampoChave = vCampos[x] then Continue;
    Query1.Fields[y].DisplayLabel := vDisplay[x];
    Inc(Y);
  end;
  if Query1.IsEmpty then
  begin
    ShowMessage('N�o foi possivel Localizar');
    Edit1.SetFocus;
    exit;
  end;
  Query1.First;
  Flag := True;
end;

procedure TfrmLocalizar.cboFieldsDropDown(Sender: TObject);
begin
  //Query1.GetFieldNames(cboFields.Items);
end;

procedure TfrmLocalizar.cboFieldsClick(Sender: TObject);
var
  x,y:Integer;
begin
  Flag := False;
  Query1.Close;
  Query1.Sql.Clear;
  vCampoChave := vCampos[cboFields.ItemIndex];
  Query1.Sql.Add('Select '+vCampoChave);
  for x := 0 to (cboFields.Items.Count-1) do
  begin
    if vCampoChave = vCampos[x] then Continue;
    Query1.Sql.Add(','+vCampos[x]);
  end;
  Query1.Sql.Add('from '+vTabela+' where '+vCampoChave+' like :'+vCampoChave+' '+FFiltro);
  Query1.Sql.Add('Order by '+vCampoChave);
  Query1.ParamByName(vCampoChave).asString := '0';
  Query1.Prepare;
  Query1.Open;
  //
  Query1.Fields[0].DisplayLabel := vDisplay[cboFields.ItemIndex];
  Y := 1;
  for x := 0 to (cboFields.Items.Count-1) do
  begin
    if vCampoChave = vCampos[x] then Continue;
    Query1.Fields[y].DisplayLabel := vDisplay[x];
    Inc(Y);
  end;
  Edit1.SetFocus;
end;

procedure TfrmLocalizar.Edit1Change(Sender: TObject);
begin
  Flag := False;
end;

procedure TfrmLocalizar.btnNovoClick(Sender: TObject);
begin
  frmMenu.LocalizaMenu(vTabela);
end;

end.
