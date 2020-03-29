unit uLocalizar;

interface

uses
  System.SysUtils, Winapi.Windows, Vcl.Controls;

type
  TLocalizar = class
    class function Busca(campo: string; filtro: string = '' ): string;
  private
    class function ChamaForm(campos, display: array of String; tabela, fieldRetorno: string; filtro: string = ''): string;
  end;

implementation

{ TLocalizar }

uses Localizar;

class function TLocalizar.Busca(campo: string; filtro: string): string;
var
  vsCampos:array  of String;
  vsDisplay: array of String;
  vsTabela, vsCampoRetorno: string;
begin
  if UpperCase(campo) = UpperCase('CodUsuario') then
  begin
    vsTabela       := 'Usuarios';
    vsCampoRetorno := 'CodUsuario';
    vsCampos       := ['Login',vsCampoRetorno];
    vsDisplay      := ['Login','C�digo'];
  end
  else if UpperCase(campo) = UpperCase('CodGrupo') then
  begin
    vsTabela       := 'Grupos';
    vsCampoRetorno := 'CodGrupo';
    vsCampos       := ['DesGrupo',vsCampoRetorno];
    vsDisplay      := ['Descri��o do Grupo','C�digo'];
  end
  else if UpperCase(campo) = UpperCase('CodCartao') then
  begin
    vsTabela       := 'CartaoCredito';
    vsCampoRetorno := 'CodCartao';
    vsCampos       := ['DesCartao',vsCampoRetorno];
    vsDisplay      := ['Descri��o do Cart�o','C�digo'];
  end
  else if UpperCase(campo) = UpperCase('CodPro') then
  begin
    vsTabela       := 'Produtos LEFT OUTER JOIN Grupos on Grupos.codgrupo=Produtos.Codgrupo';
    vsCampoRetorno := 'CodPro';
    vsCampos       := ['Despro','desgrupo',vsCampoRetorno];
    vsDisplay      := ['Produto','Grupo','C�digo'];
  end
  else if UpperCase(campo) = UpperCase('CodEan') then
  begin
    vsTabela       := 'Produtos LEFT OUTER JOIN Grupos on Grupos.codgrupo=Produtos.Codgrupo';
    vsCampoRetorno := 'CodBarra';
    vsCampos       := ['Despro','desgrupo',vsCampoRetorno];
    vsDisplay      := ['Produto','Grupo','C�d.Ean'];
  end
  else if UpperCase(campo) = UpperCase('CodCli') then
  begin
    vsTabela       := 'Clientes';
    vsCampoRetorno := 'CodCli';
    vsCampos       := ['NomCli','cpf',vsCampoRetorno];
    vsDisplay      := ['Nome Cliente','CPF','C�digo'];
  end
  else if UpperCase(campo) = UpperCase('CodEvento') then
  begin
    vsTabela       := 'Eventos';
    vsCampoRetorno := 'CodEvento';
    vsCampos       := ['DesEvento','CodEvento'];
    vsDisplay      := ['Tipo Adicional','C�digo'];
  end
  else if (UpperCase(campo) = UpperCase('CodCidade')) or
          (UpperCase(campo) = UpperCase('CodCidFor')) or
          (UpperCase(campo) = UpperCase('CodCidCli')) then
  begin
    vsTabela       := 'Cidades';
    vsCampoRetorno := 'CodCidade';
    vsCampos       := ['Cidade','Estado',vsCampoRetorno];
    vsDisplay      := ['Cidade','UF','C�digo'];
  end
  else if UpperCase(campo) = UpperCase('CodFor') then
  begin
    vsTabela       := 'Fornecedores';
    vsCampoRetorno := 'CodFor';
    vsCampos       := ['Nomfor','FantasiaFor',vsCampoRetorno];
    vsDisplay      := ['Raz�o Social','Fantasia','C�digo'];
  end

  ;Result := ChamaForm(vsCampos, vsDisplay, vsTabela, vsCampoRetorno);
end;

class function TLocalizar.ChamaForm(campos, display: array of String; tabela, fieldRetorno: string; filtro: string = ''): string;
begin
  frmLocalizar :=  TfrmLocalizar.Create(nil);
  try
    frmLocalizar.DefParamPesq(campos ,display, tabela, filtro);
    if frmLocalizar.ModalResult = mrOk then
    begin
      Result := frmLocalizar.Query1.FieldByName(fieldRetorno).asString;
      keybd_event(vk_Tab,0,0,0);
    end;
  finally
    frmLocalizar.Query1.Close;
    frmLocalizar.Release;
  end;
end;

end.
