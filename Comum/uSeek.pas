unit uSeek;

interface

uses
  SysUtils, Forms, Windows, DBCtrls, FireDAC.Comp.Client;

type
  TSeek = class
  private
    FQuery :TFDQuery;
    FObject: TObject;
    FRetMen: Boolean;
  protected

  public
    constructor Create(Sender: TObject; Conexao: TFDConnection; RetornaMensagem: Boolean = True);
    destructor Destroy; override;
    function Seek(pEntidade:String; pQde:Integer; pCampos: array of String;
      pValores: array of variant): boolean;
  published
    property Qry:TFDQuery  read FQuery write FQuery;
  end;
implementation

{ TSeek }

constructor TSeek.Create(Sender: TObject; Conexao: TFDConnection; RetornaMensagem: Boolean);
begin
  FObject := Sender;
  FRetMen := RetornaMensagem;
  FQuery  := TFDQuery.Create(nil);
  FQuery.Connection := Conexao;
end;

destructor TSeek.Destroy;
begin
  FQuery.Close;
  Freeandnil(FQuery);
end;

function TSeek.Seek(pEntidade: String; pQde: Integer; pCampos: array of String;
  pValores: array of variant): boolean;
var
  x: integer;
  sql:String;
begin
  sql := 'Select * from '+pEntidade+' where ';
  for x:=0 to (pQde-1) do
  begin
    if x < (pQde-1) then
      sql := sql+pCampos[x]+ ' =  '+QuotedStr(pValores[x])+' and ' // '''+pValores[x]+''' and '
    else
      sql := sql+pCampos[x]+ ' =  '+QuotedStr(pValores[x])+' '; // '''+pValores[x]+'''' ;
  end;
  FQuery.Close;
  FQuery.Sql.Clear;
  FQuery.Sql.Add(sql);
  FQuery.Open;
  if FQuery.IsEmpty then
  begin
    Result := False;
    if FRetMen then
    begin
      if (FObject <> nil) and (FObject is TDBEdit) then
      begin
        Application.MessageBox(PChar((FObject as TDBEdit).Hint + ' não encontrado(a)'),PChar('Busca'),mb_IconExclamation+mb_Ok);
        (FObject as TDBEdit).SetFocus;
      end
      else
      begin
        Application.MessageBox(PChar('Resultado da busca não foi encontrado(a)'),PChar('Busca'),mb_IconExclamation+mb_Ok);
      end;
    end;
  end
  else
    Result := True;
end;

end.
