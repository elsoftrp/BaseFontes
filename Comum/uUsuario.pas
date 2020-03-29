unit uUsuario;

interface

uses
  SysUtils, Windows, DBCtrls, FireDAC.Comp.Client ;

  const
    sql = 'select * from Usuarios u where u.login =:login ';
type
  TUsuario = class
  private
    FId: Integer;
    FNome: string;
    FLogin: string;
    FSenha: string;
    FTipo: string;
    FPerfil: string;
    FCidade: Integer;
    FConexao: TFDConnection;
    class var FInstance: TUsuario;
    constructor CreatePrivate;
  protected

  public
    constructor Create;
    class function GetInstance: TUsuario;
    function Acessar(Usuario, Senha: string; Conexao: TFDConnection): Boolean;
    destructor Destroy; override;
  published
     property Id: Integer read FId;
     property Nome: string read FNome;
     property Login: string read FLogin;
     property Senha: string read FSenha;
     property Tipo: string read FTipo;
     property Perfil: string read FPerfil;
     property Cidade: Integer read FCidade;
  end;
implementation

{ TUsuario }

function TUsuario.Acessar(Usuario, Senha: string;
  Conexao: TFDConnection): Boolean;
var
  FQuery: TFDQuery;
begin
  FId     := -1;
  FNome   := '';
  FSenha  := '';
  FTipo   := '';
  FPerfil := '';
  FCidade := -1;
  FLogin := Usuario;
  FConexao := Conexao;
  FQuery  := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
  try
    FQuery.SQL.Add(sql);
    FQuery.ParamByName('login').AsString  := FLogin;
    FQuery.Open;
    if FQuery.IsEmpty then
    begin
      Result  := False;
      Exit;
    end
    else if (Senha = UpperCase( FQuery.FieldByName('Senha').AsString )  ) then
    begin
      FId     := FQuery.FieldByName('CodUsuario').AsInteger;
      FNome   := FQuery.FieldByName('Nome').asString;
      FLogin  := FQuery.FieldByName('Login').asString;
      FSenha  := FQuery.FieldByName('Senha').asString;
      FTipo   := FQuery.FieldByName('Tipo').asString;
      if FQuery.FieldByName('Perfil').asString = EmptyStr then
        FPerfil := FQuery.FieldByName('Login').asString
      else
        FPerfil := FQuery.FieldByName('Perfil').asString;
      FCidade := FQuery.FieldByName('CodCidade').AsInteger;
      Result := True;
    end
    else
    begin
      Result := False;
    end;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

constructor TUsuario.Create;
begin
  raise Exception.Create
    ('Para obter uma inst�ncia de TUsuario utilize TUsuario.GetInstance !');
end;

constructor TUsuario.CreatePrivate;
begin
  inherited Create;
end;

destructor TUsuario.Destroy;
begin

  inherited;
end;

class function TUsuario.GetInstance: TUsuario;
begin
  if not Assigned(FInstance) then
    FInstance := TUsuario.CreatePrivate;
  Result := FInstance;

end;

end.