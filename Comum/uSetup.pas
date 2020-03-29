unit uSetup;

interface

uses
  Uni, SysUtils, Windows, DBCtrls ;

  const
    sql = 'select * from Setup where cont = 1 ';
type
  TIndice = (indRecolhimento, indEmpresa, indNulo);

type
  TSetup = class
  private
    FCodCaixaCabelo: Integer;
    FVersao: string;
    FLimMesesMensalidade: Integer;
    FLimMesesRecolhimento: Integer;
    FVersaoCatraca: string;
    FRetMesesRecolhimentoFicha: Integer;
    FMultaConvenio: Double;
    FMoraConvenio: Double;
    FCodCaixaConvenio: Integer;
    FMultaFuneraria: Double;
    FMoraFuneraria: Double;
    FCodCaixaFuneraria: Integer;
    FIntervaloDentista: string;
    FIndice: TIndice;
    FPathHomologacao: string;
    FConexao: TUniConnection;
    class var FInstance: TSetup;
    constructor CreatePrivate;
  protected

  public
    constructor Create;
    class function GetInstance: TSetup;
    procedure LoadSetup(Conexao: TUniConnection);
  published
    property CodCaixaCabelo: Integer read FCodCaixaCabelo;
    property Versao: string read FVersao;
    property LimMesesMensalidade: Integer read FLimMesesMensalidade;
    property LimMesesRecolhimento: Integer read FLimMesesRecolhimento;
    property VersaoCatraca: string read FVersaoCatraca;
    property RetMesesRecolhimentoFicha: Integer read FRetMesesRecolhimentoFicha ;
    property MultaConvenio: Double read FMultaConvenio;
    property MoraConvenio: Double read FMoraConvenio;
    property CodCaixaConvenio: Integer read FCodCaixaConvenio;
    property MultaFuneraria: Double read FMultaFuneraria;
    property MoraFuneraria: Double read FMoraFuneraria;
    property CodCaixaFuneraria: Integer read FCodCaixaFuneraria ;
    property IntervaloDentista: string read FIntervaloDentista;
    property PathHomologacao: string read FPathHomologacao;
    property TipoIndice: TIndice read FIndice;
  end;

implementation

{ TSetup }

constructor TSetup.Create;
begin
  raise Exception.Create
    ('Para obter uma instância de TSetup utilize TSetup.GetInstance !');
end;

constructor TSetup.CreatePrivate;
begin
  inherited Create;
end;

class function TSetup.GetInstance: TSetup;
begin
  if not Assigned(FInstance) then
    FInstance := TSetup.CreatePrivate;
  Result := FInstance;
end;

procedure TSetup.LoadSetup(Conexao: TUniConnection);
var
  FQuery: TUniQuery;
begin
  FConexao := Conexao;
  FQuery  := TUniQuery.Create(nil);
  FQuery.Connection := FConexao;
  try
    FQuery.SQL.Add(sql);
    FQuery.Open;
    if FQuery.IsEmpty then
    begin
      FCodCaixaCabelo       := -1;
      FVersao               := '';
      FLimMesesMensalidade  := -1;
      FLimMesesRecolhimento := -1;
      FVersaoCatraca        := '';
      FRetMesesRecolhimentoFicha := -1;
      FMultaConvenio        := 0;
      FMoraConvenio         := 0;
      FCodCaixaConvenio     := -1;
      FMultaFuneraria       := 0;
      FMoraFuneraria        := 0;
      FCodCaixaFuneraria    := -1;
      FIntervaloDentista    := '';
      FPathHomologacao      := '';
      FIndice               := indNulo;
      Exit;
    end
    else
    begin
      FCodCaixaCabelo       := FQuery.FieldByName('TipoCabelo').AsInteger;
      FVersao               := FQuery.FieldByName('Versao').asString;
      FLimMesesMensalidade  := FQuery.FieldByName('Dias').AsInteger;
      FLimMesesRecolhimento := FQuery.FieldByName('DiasEmp').AsInteger;
      FVersaoCatraca        := FQuery.FieldByName('VersaoCatraca').asString;
      FRetMesesRecolhimentoFicha := FQuery.FieldByName('DiasFicha').AsInteger;
      FMultaConvenio        := FQuery.FieldByName('MultaConv').AsFloat;
      FMoraConvenio         := FQuery.FieldByName('MoraConv').AsFloat;
      FCodCaixaConvenio     := FQuery.FieldByName('CodCaixaConv').AsInteger;
      FMultaFuneraria       := FQuery.FieldByName('MultaFunCli').AsFloat;
      FMoraFuneraria        := FQuery.FieldByName('MoraFunCli').AsFloat;
      FCodCaixaFuneraria    := FQuery.FieldByName('CodCaixaFunCli').AsInteger;
      FIntervaloDentista    := FQuery.FieldByName('IntervaloHora').asString;
      FIndice               := TIndice(FQuery.FieldByName('TipoIndice').AsInteger);
      FPathHomologacao      := FQuery.FieldByName('PathHomologacao').asString;
    end;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

end.
