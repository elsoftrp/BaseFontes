unit ConsProduto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, ExtCtrls, Db, Mask, DBCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TCampoRetorno = (crCodEan, crCodigo);
  TfrmConsProdutos = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    DSBusca: TDataSource;
    Panel2: TPanel;
    Str: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StrChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    vQuery: TFDQuery;
    Flag: Boolean;
    FCampoRetorno: TCampoRetorno;
    FTipo: string;
    procedure Pesquisar;
    procedure ZeraPesquisa;
    { Private declarations }
  public
    valorRetorno: string;
    constructor Create(AOwer: TComponent; Tipo: string; CampoRetorno: TCampoRetorno  = crCodEan);

    { Public declarations }
  end;

var
  frmConsProdutos: TfrmConsProdutos;

implementation

uses Funcoes, Menu, Cadprodutos, DataModulo;

{$R *.DFM}

constructor TfrmConsProdutos.Create(AOwer: TComponent;
  Tipo: string; CampoRetorno: TCampoRetorno);
begin
  inherited Create(AOwer);
  FCampoRetorno := CampoRetorno;
  FTipo         := Tipo;
end;

procedure TfrmConsProdutos.DBGrid1DblClick(Sender: TObject);
begin
  if FCampoRetorno = crCodEan then
  begin
    valorRetorno := vQuery.FieldByName('Codbarra').asString;
    ModalResult  := mrOk;
    exit;
  end;
  if FCampoRetorno = crCodigo then
  begin
    valorRetorno := vQuery.FieldByName('CodPro').asString;
    ModalResult  := mrOk;
    exit;
  end;
end;

procedure TfrmConsProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmConsProdutos.FormDestroy(Sender: TObject);
begin
  vQuery.Close;
end;

procedure TfrmConsProdutos.StrChange(Sender: TObject);
begin
  ZeraPesquisa;
end;

procedure TfrmConsProdutos.StrKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Up then
  begin
    vQuery.Prior;
    //Str.Text := '';
  end;
  if Key = vk_Down then
  begin
    vQuery.Next;
    //Str.text := '';
  end;
  if Key = vk_Escape then
  begin
    Close;
  end;
  if Key = vk_return then
  begin
    if Flag = False then
    begin
      Pesquisar;
    end
    else
    begin
      if FCampoRetorno = crCodEan then
      begin
        valorRetorno := vQuery.FieldByName('Codbarra').asString;
        ModalResult  := mrOk;
        exit;
      end;
      if FCampoRetorno = crCodigo then
      begin
        valorRetorno := vQuery.FieldByName('CodPro').asString;
        ModalResult  := mrOk;
        exit;
      end;
    end;
  end;
end;

procedure TfrmConsProdutos.ZeraPesquisa;
begin
  Flag := False;
  vQuery.Close;
  vQuery.ParamByName('Entrada').Clear;
  vQuery.Open;
end;

procedure TfrmConsProdutos.FormShow(Sender: TObject);
begin
  vQuery := DM.SQLConsPro;
  ZeraPesquisa;
end;


procedure TfrmConsProdutos.Pesquisar;
var
  Entrada : String;
begin
  if Str.Text = '' then begin Entrada := ' '; end;
  if (Entrada <> EmptyStr) then // and ( Length(Entrada) >= 3)  then
  begin
    vQuery.Close;
    vQuery.ParamByName('Entrada').asString := '%'+Entrada+'%';
    vQuery.Open;
    if vQuery.IsEmpty then
    begin
      ShowMessage(' Nenhum registro Encontrado. ');
      Str.Text := ('');
      Str.SetFocus;
    end
    else
    begin
      Flag := True;
    end;
  end;
end;

end.
