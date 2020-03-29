unit uOperacaoBD;



interface

uses System.SysUtils, FireDAC.Comp.Client;

type
  TOperacaoBD = class
    class function ContadorDac(Connection: TFDConnection; Campo:string; simbolo: string = '+'; cod_Old: Integer = 0;
  incremento: Integer = 1): Integer;
    class procedure GravalogDac(Connection: TFDConnection; DataAgora: TDateTime; idUsuario: Integer; NomeUsuario, Evento,Tabela, txtCaption, CampoChave:string; CampoChave1: string='';
      CampoChave2: string=''; Movimento: string=''; LocalMov : string='');
  end;

implementation

{ TOperacaoBD }

class function TOperacaoBD.ContadorDac(Connection: TFDConnection; Campo, simbolo: string; cod_Old,
  incremento: Integer): Integer;
var
  valor:Integer;
  TBCont: TFDQuery;
begin
  TBCont := TFDQuery.Create(nil);
  try
    TBCont.Connection := Connection;
    TBCont.SQL.Clear;
    TBCont.SQL.Add('select * from ncontador where coluna =:coluna');
    try
      valor := 0;
      TBCont.Close;
      TBCont.ParamByName('coluna').AsString := campo;
      TBCont.Open;
      try
        if TBCont.IsEmpty then
        begin
          TBCont.Append;
          valor := 1;
          TBCont.FieldByName('coluna').AsString := campo;
          TBCont.FieldByName('valor').AsInteger := valor+incremento;
          TBCont.Post;
        end
        else
        begin
          TBCont.Edit;
          valor := TBCont.FieldByName('valor').AsInteger;
          if simbolo = '+' then
          begin
            TBCont.FieldByName('valor').AsInteger := valor+incremento;
          end
          else if (simbolo = '-') and (valor = (cod_Old+incremento)) then
          begin
            TBCont.FieldByName('valor').AsInteger := valor-incremento;
            valor := -1;
          end;
          TBCont.Post;
        end;
      finally
        TBCont.Close;
      end;
    except
      valor := -1;
    end;
  finally
    FreeAndNil(TBCont);
  end;
  Result := valor;

end;

class procedure TOperacaoBD.GravalogDac(Connection: TFDConnection; DataAgora: TDateTime; idUsuario: Integer; NomeUsuario, Evento, Tabela, txtCaption, CampoChave,
  CampoChave1, CampoChave2, Movimento, LocalMov: string);
var
  LogDac: TFDQuery;
begin
  LogDac := TFDQuery.Create(nil);
  try
    LogDac.Connection := Connection;
    LogDac.SQL.Clear;
    LogDac.SQL.Add('INSERT INTO LogUsuario '+
           '(CodUsuario '+
           ',Usuario '+
           ',Evento '+
           ',Data '+
           ',Tabela '+
           ',Caption '+
           ',CampoChave '+
           ',CampoChave1 '+
           ',CampoChave2 '+
           ',Hora '+
           ',Movimento '+
           ',LocalMov) '+
     'VALUES '+
           '(:CodUsuario, '+
           ':Usuario, '+
           ':Evento, '+
           ':Data, '+
           ':Tabela, '+
           ':Caption, '+
           ':CampoChave, '+
           ':CampoChave1, '+
           ':CampoChave2, '+
           ':Hora, '+
           ':Movimento, '+
           ':LocalMov)');
    with LogDac do
    begin
      ParamByName('CodUsuario').asInteger := idUsuario;
      ParamByName('Usuario').asString     := NomeUsuario;
      ParamByName('Evento').asString      := Evento;
      ParamByName('Data').AsDateTime      := (DataAgora);
      ParamByName('Hora').asString        := FormatDateTime('HH:NN',(DataAgora));
      ParamByName('Tabela').asString      := Tabela;
      ParamByName('Caption').asString     := Copy(txtCaption,1,40) ;
      ParamByName('CampoChave').asString  := CampoChave;
      ParamByName('CampoChave1').asString := CampoChave1;
      ParamByName('CampoChave2').asString := CampoChave2;
      ParamByName('Movimento').asString   := Movimento;
      ParamByName('LocalMov').asString    := LocalMov;
      ExecSQL;
    end;
  finally
    FreeAndNil(LogDac);
  end;
end;

end.
