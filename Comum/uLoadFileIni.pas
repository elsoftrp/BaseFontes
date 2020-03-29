unit uLoadFileIni;

interface

uses IniFiles, SysUtils, Forms;

type
  TLoadFileIni = class
  private
    FCorEdit: string;
    FCorFontEdit: string;
    FCorLabel: string;
    FCorFoco: string;
    FServer: string;
    FDataBase: string;
    FDataBaseImg: string;
    FPathRelat: string;
    class var FInstance: TLoadFileIni;
    constructor CreatePrivate;
    { private declarations }
  protected
    { protected declarations }
  public
    constructor Create;
    class function GetInstance: TLoadFileIni;
    procedure ReadIni(arquivo: string);
    property CorEdit: string read FCorEdit;
    property CorFontEdit: string read FCorFontEdit;
    property CorLabel: string read FCorLabel;
    property CorFoco: string read FCorFoco;
    property Server: string read FServer;
    property DataBaseFile: string read FDataBase;
    property DataBaseImg: string read FDataBaseImg;
    property PathRelat: string read FPathRelat;
    { public declarations }
  end;


implementation


{ TArquivoIni }

constructor TLoadFileIni.Create;
begin
  raise Exception.Create
    ('Para obter uma inst�ncia de TLoadFileIni utilize TLoadFileIni.GetInstance !');
end;

constructor TLoadFileIni.CreatePrivate;
begin
  inherited Create;
end;

class function TLoadFileIni.GetInstance: TLoadFileIni;
begin
  if not Assigned(FInstance) then
    FInstance := TLoadFileIni.CreatePrivate;
  Result := FInstance;
end;

procedure TLoadFileIni.ReadIni(arquivo: string);
var
  AIni: TiniFile;
begin
  AIni := TiniFile.Create(ExtractFilePath(Application.ExeName) + arquivo);
  try
    FCorLabel := AIni.ReadString('CORES', 'CORLABEL', 'x');
    FCorEdit := AIni.ReadString('CORES', 'COREDIT', 'x');
    FCorFontEdit := AIni.ReadString('CORES', 'CORFONTEDIT', 'x');
    //FCorFoco := AIni.ReadString('CORES', 'CORFOCO', 'x');
    FServer := AIni.ReadString('PARAMETROS', 'SERVER', 'x');
    FDataBase := AIni.ReadString('PARAMETROS', 'DATABASE', 'x');
    FPathRelat := AIni.ReadString('PARAMETROS', 'PATHRELAT', 'x');
  finally
    FreeAndNil(AIni);
  end;
end;

end.