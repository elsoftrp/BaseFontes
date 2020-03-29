unit uDireitos;

interface

uses
  SysUtils, Windows, DBCtrls, FireDAC.Comp.Client ;

  const
    sql = 'select pu.*, p.descricao from ProgramasUsuario pu INNER JOIN Programas p ON p.CodPrograma = pu.CodPrograma '+
           'INNER JOIN Usuarios u ON u.CodUsuario = pu.CodUsuario where p.nomeprograma =:nomeprograma and u.login =:login ';

type
  TDireitos = class
  private
    FIncluir: Boolean;
    FAlterar: Boolean;
    FExcluir: Boolean;
    FVisualizar: Boolean;
    FImprimir: Boolean;
    FChave1: Boolean;
    FChave2: Boolean;
    FChave3: Boolean;
    FChave4: Boolean;
    FPermite: Boolean;
    FCaption: string;
    FNomeJanela: string;
    FUsuario: string;
    FPerfil: string;
    FDataHoje: TDateTime;
    FConexao: TFDConnection;
  protected
     function DataServidor: TDateTime;
  public
    constructor Create(NomeJanela, Usuario, Perfil: string; Conexao: TFDConnection);
    destructor Destroy; override;
    function PodeVerJanela(NomeJanela: string): Boolean;
  published
     property Incluir: Boolean read FIncluir;
     property Alterar: Boolean read FAlterar;
     property Excluir: Boolean read FExcluir;
     property Visualizar: Boolean read FVisualizar;
     property Imprimir: Boolean read FImprimir;
     property Chave1: Boolean read FChave1;
     property Chave2: Boolean read FChave2;
     property Chave3: Boolean read FChave3;
     property Chave4: Boolean read FChave4;
     property Permite: Boolean  read FPermite;
     property Descricao: string read FCaption;
     property DataHoje: TDateTime read FDataHoje;
  end;

implementation

{ TDireitos }

constructor TDireitos.Create(NomeJanela, Usuario, Perfil: string; Conexao: TFDConnection);
var
  FQuery: TFDQuery;
begin
  FNomeJanela := NomeJanela;
  FUsuario    := Usuario;
  FPerfil     := Perfil;
  FConexao    := Conexao;
  FDataHoje   := DataServidor;
  FQuery      := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
  try
    FQuery.SQL.Add(sql);
    FQuery.ParamByName('nomeprograma').AsString := FNomeJanela;
    FQuery.ParamByName('login').AsString        := FUsuario;
    FQuery.Open;
    if FQuery.IsEmpty then
    begin
      FQuery.Close;
      FQuery.ParamByName('nomeprograma').AsString := FNomeJanela;
      FQuery.ParamByName('login').AsString        := FPerfil;
      FQuery.Open;
    end;
    if FQuery.IsEmpty then
    begin
      FIncluir := False;
      FAlterar := False;
      FExcluir := False;
      FVisualizar := False;
      FImprimir := False;
      FChave1 := False;
      FChave2 := False;
      FChave3 := False;
      FChave4 := False;
      FCaption := '';
      FPermite := False;
      Exit;
    end;
    FIncluir   := (FQuery.FieldByName('btnIncluir').AsInteger = 1);
    FAlterar   := (FQuery.FieldByName('btnAlterar').AsInteger = 1);
    FExcluir   := (FQuery.FieldByName('btnExcluir').AsInteger = 1);
    FVisualizar:= (FQuery.FieldByName('btnVisualizar').AsInteger = 1);
    FImprimir  := (FQuery.FieldByName('btnImprimir').AsInteger = 1);
    FChave1    := (FQuery.FieldByName('btnChave1').AsInteger = 1);
    FChave2    := (FQuery.FieldByName('btnChave2').AsInteger = 1);
    FChave3    := (FQuery.FieldByName('btnChave3').AsInteger = 1);
    FChave4    := (FQuery.FieldByName('btnChave4').AsInteger = 1);
    FPermite   := True;
    FCaption   := FQuery.FieldByName('Descricao').asString;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

function TDireitos.DataServidor: TDateTime;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConexao;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add('Select current_timestamp as Data from rdb$database ');
    Qry.Prepare;
    Qry.Open;
    Result := Int(Qry.FieldByName('Data').asDateTime);
  finally
    Qry.Close;
    FreeAndNil(Qry);
  end;
end;

destructor TDireitos.Destroy;
begin
  inherited;
end;

function TDireitos.PodeVerJanela(NomeJanela: string): Boolean;
var
  FQuery: TFDQuery;
begin
  Result  := True;
  FQuery  := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
  try
    FQuery.SQL.Add(sql);
    FQuery.ParamByName('nomeprograma').AsString := NomeJanela;
    FQuery.ParamByName('login').AsString        := FUsuario;
    FQuery.Open;
    if FQuery.IsEmpty then
    begin
      FQuery.Close;
      FQuery.ParamByName('nomeprograma').AsString := NomeJanela;
      FQuery.ParamByName('login').AsString        := FPerfil;
      FQuery.Open;
    end;
    if FQuery.IsEmpty then
    begin
      Result := False;
    end;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

end.
