unit uLib;

interface

uses
  System.Classes, Vcl.Forms, Vcl.Controls, Data.DB, System.SysUtils,
  Winapi.Windows, System.Variants, Vcl.Dialogs, FireDAC.Comp.Client,
  Vcl.DBCtrls;


type
  TLib = class
    class function Mensagem(vTitulo,vTexto,vTipo: String): Integer;
    class function DataServidor(Conexao: TFDConnection): TDateTime;
    class function FCgcCpf(vCgcCpf: String): Boolean;
    class procedure AbreForm(Classe: TComponentClass; Form: TForm); overload;
    class procedure AbreForm(Classe: TComponentClass; Form: TForm; out retorno: TModalResult); overload;
    class function CampoChave(DataSet: TDataSet; Campo: String): string;
    class function Criptar(VStr: String): String;
    class function DeCriptar(VStr: String): String;
    class function RetiraAcentos(Texto:String): String;
    class procedure Compartilhamento(login, senha, compartilhamento: string);
    class function Idade(vDatNas: Double):Integer;
    class procedure FormatarFone(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    class procedure FormatarCelular(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  end;

const
  vp = 'Sistema Vendas';

implementation

{ TLib }

class procedure TLib.AbreForm(Classe: TComponentClass; Form: TForm);
begin
  Application.CreateForm(Classe, Form);
  try
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

class procedure TLib.AbreForm(Classe: TComponentClass; Form: TForm;
  out retorno: TModalResult);
begin
  Application.CreateForm(Classe, Form);
  try
      retorno := Form.ShowModal;
  finally
      Form.Free;
  end;
end;

class function TLib.CampoChave(DataSet:TDataSet;Campo:String):string;
begin
  if Campo <> EmptyStr then
  begin
    try
      Result := DataSet.FieldByName(Campo).asString;
    except
      Result := ''
    end;
  end
  else
    Result := '';
end;


class function TLib.DataServidor(Conexao: TFDConnection): TDateTime;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := Conexao;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add('Select current_timestamp as Data from rdb$database ');
    Qry.Prepare;
    Qry.Open;
    Result := Qry.FieldByName('Data').asDateTime;
  finally
    Qry.Close;
    FreeAndNil(Qry);
  end;
end;

class function TLib.Criptar(VStr:String):String;
var
i : integer;
Resp : String;
begin
 Resp:= '';
 for i:=1 to length(Vstr) do
    Resp := Resp + Chr(Ord(VStr[i])+100+Length(vStr));
 Result := Resp;
end;

class function TLib.DeCriptar(VStr:String):String;
var
i : integer;
Resp : String;
begin
 Resp:= '';
 for i:=1 to length(Vstr) do Resp := Resp + Chr(Ord(VStr[i])-100-Length(vStr));
 Result := Resp;
end;


class function TLib.FCgcCpf(vCgcCpf: String): Boolean;
var x:Integer;
    A:Variant;
    D1,Pd,Sd:Integer;
begin
if Length(vCgcCpf) = 14 then
   begin
   A := VarArrayCreate([0,12], VarVariant);
   for x := 1 to 12 do
      A[x]:=Copy(vCgcCpf,x,1);
   //
   D1:=(5*A[1])+(4*A[2])+(3*A[3])+(2*A[4])+(9*A[5])+(8*A[6])+(7*A[7])+(6*A[8])+(5*A[9])+(4*A[10])+(3*A[11])+(2*A[12]);
   D1:=(D1 mod 11);
   if (D1=0) or (D1=1) then
      Pd:=0
   else
      Pd:=(11-D1);
   //
   A:=VarArrayCreate([0,12], VarVariant);
   for x:= 1 to 12 do
      A[x]:=Copy(vCgcCpf,x,1);
   //
   D1 := (6*A[1])+(5*A[2])+(4*A[3])+(3*A[4])+(2*A[5])+(9*A[6])+(8*A[7])+(7*A[8])+(6*A[9])+(5*A[10])+(4*A[11])+(3*A[12])+(2*Pd);
   D1 := (D1 mod 11);
   if (D1=0) or (D1=1) then
      Sd:=0
   else
     Sd := (11-D1);
   //
   if ( IntToStr(Pd) = Copy(vCgcCpf,13,1) ) and ( IntToStr(Sd) = Copy(vCgcCpf,14,1) ) then
      result := True
   else
      begin
      ShowMessage('               C.G.C Inv�lido               ');
      result := False;
      exit;
      end;
   end
else if length(vCgcCpf) = 11 then
   begin
   A:=VarArrayCreate([0,9], VarVariant);
   for x:= 1 to 9 do
      A[x]:=Copy(vCgcCpf,x,1);
   //
   D1 := (10*A[1])+(9*A[2])+(8*A[3])+(7*A[4])+(6*A[5])+(5*A[6])+(4*A[7])+(3*A[8])+(2*A[9]);
   D1 := (D1 mod 11);
   if (D1=0) or (D1=1) then
      Pd:=0
   else
      Pd:=(11-D1);
   //
   A:=VarArrayCreate([0,9], VarVariant);
   for x := 1 to 9 do
      A[x]:=Copy(vCgcCpf,x,1);
   //
   D1 := (11*A[1])+(10*A[2])+(9*A[3])+(8*A[4])+(7*A[5])+(6*A[6])+(5*A[7])+(4*A[8])+(3*A[9])+(2*Pd);
   D1 := (D1 mod 11);
   if (D1=0) or (D1=1) then
      Sd:=0
   else
      Sd:=(11-D1);
   //
   if ( IntToStr(Pd) = Copy(vCgcCpf,10,1) ) and (IntToStr(Sd) = Copy(vCgcCpf,11,1) ) then
      result := True
   else
      begin
      ShowMessage('               CPF Inv�lido               ');
      result := False;
      exit;
      end;
   end
else
   begin
   ShowMessage('               CGC/CPF Inv�lido               ');
   result := False;
   exit;
   end;
end;

class function TLib.Mensagem(vTitulo, vTexto, vTipo: String): Integer;
begin
  if vTipo='!' then
    Result:=Application.MessageBox(PChar(vTexto),PChar(vTitulo),
    mb_IconExclamation+mb_Ok);
  if vTipo='?' then
    Result:=Application.MessageBox(PChar(vTexto),PChar(vTitulo),
    mb_IconQuestion+mb_YesNo);
  if vTipo='E' then
    Result:=Application.MessageBox(PChar(vTexto),PChar(vTitulo),
    mb_IconError+mb_Ok);
end;

class function TLib.RetiraAcentos(Texto:String): String;
Const
  comAcento = '��������������������������������������';
  SemAcento = 'aeiouaeiouaoaeioucuAEIOUAEIOUAOAEIOUCU';
Var
  i : Integer;
begin
  for i := 1 to Length(Texto) do
  begin
    if Pos(Texto[i],ComAcento) <> 0 then
    begin
      Texto[i] := SemAcento[Pos(Texto[i],ComAcento)];
    end;
  end;
  Result := Texto;
end;

class procedure TLib.Compartilhamento(login, senha, compartilhamento: string);
var
  NetResource: TNetResource;
begin
  NetResource.dwType := RESOURCETYPE_DISK;
  NetResource.lpRemoteName := PChar(compartilhamento);
  NetResource.lpLocalName := '';
  NetResource.lpProvider  := '';
  WNetAddConnection2(NetResource,PChar(senha),PChar(login),CONNECT_UPDATE_RECENT);
  //CopyFile( origem + arquivo , destino + arquivo ,False);
end;

class function TLib.Idade(vDatNas: Double):Integer;
var
Dia, Mes, Ano: Word;
DiaN, MesN, AnoN: Word;
VAno: Integer;
begin
DecodeDate(Date, Ano, Mes, Dia);
DecodeDate(VDatNas, AnoN, MesN, DiaN);
VAno := Ano-AnoN;
if Mes < MesN then
   VAno := VAno-1
else if Mes = MesN then
   begin
   if Dia < DiaN then
      VAno := VAno-1;
   end;
Result := VAno;
end;

class procedure TLib.FormatarFone(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  campo: TDBEdit;
begin
  if (Sender is TDBEdit) then
  begin
    campo := (Sender as TDBEdit);
    if Trim(campo.Text) <> '' then
    begin
      if Length(campo.Text) = 2 then
      begin
        campo.Text := '('+campo.Text+') ';
        campo.SelStart := Length(campo.Text);
      end
      else
      if Length(campo.Text) = 9 then
      begin
        campo.Text := campo.Text+'-';
        campo.SelStart := Length(campo.Text);
      end;
    end;
  end;
end;

class procedure TLib.FormatarCelular(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  campo: TDBEdit;
begin
  if (Sender is TDBEdit) then
  begin
    campo := (Sender as TDBEdit);
    if Trim(campo.Text) <> '' then
    begin
      if Length(campo.Text) = 2 then
      begin
        campo.Text := '('+campo.Text+') ';
        campo.SelStart := Length(campo.Text);
      end
      else
      if Length(campo.Text) = 10 then
      begin
        campo.Text := campo.Text+'-';
        campo.SelStart := Length(campo.Text);
      end;
    end;
  end;
end;

end.
