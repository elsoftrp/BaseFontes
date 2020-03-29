unit Senha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Gauges, ExtCtrls, Db, IniFiles,
  Buttons, jpeg, uSeek;

type
  TfrmSenha = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    txtSenha: TEdit;
    txtUsuario: TEdit;
    Image1: TImage;
    btnOk: TSpeedButton;
    btnCancelar: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtSenhaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    seek: TSeek;
    Qde:Integer;
  public
    { Public declarations }
  end;

var
  frmSenha: TfrmSenha;

implementation

uses DataModulo, Funcoes, Menu, Splash, uUsuario, uLib;

{$R *.DFM}

procedure TfrmSenha.btnCancelarClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja Realmente Sair do Sistema?',
      vp, mb_IconQuestion+mb_YesNo) = idYes then
    Application.Terminate;
end;

procedure TfrmSenha.btnOkClick(Sender: TObject);
begin
  if (txtUsuario.Text = 'CRIA��O') and (txtSenha.Text = '123456') then
  begin
    frmMenu.CadProgramas;
    txtUsuario.Text :=  '';
    txtSenha.Text   := '';
    txtUsuario.SetFocus;
  exit;
  end;
  seek := TSeek.Create(nil, DM.Database, False);
  try
    if seek.Seek('Usuarios',1,['Login'], [txtUsuario.Text]) then
    begin
      if txtSenha.Text = {TLib.DeCriptar}UpperCase(seek.Qry.FieldByName('Senha').asString) then
      begin
        if TUsuario.GetInstance.Acessar(txtUsuario.Text, {TLib.Criptar}UpperCase(txtSenha.Text), DM.Database) then
        begin
          frmMenu.StatusBar1.Panels[3].Text:='Usu�rio: '+ TUsuario.GetInstance.Login;
          DM.Menus.Close;
          DM.Menus.ParamByName('Usuario').asString:= TUsuario.GetInstance.Login;
          DM.Menus.ParamByName('Perfil').asString := TUsuario.GetInstance.Perfil;
          DM.Menus.Prepare;
          DM.Menus.Open;
          frmSenha.Hide;
          frmSenha.Close;
          frmMenu.CriaMenu;
          exit;
        end;
      end
      else
      begin
        frmSenha.txtSenha.Text:='';
        Application.MessageBox('Senha Invalida, Digite nova senha.','Aviso', mb_Ok);
        if Qde > 2 then
        begin
           Application.Terminate;
           exit;
        end;
        Inc(Qde);
        txtSenha.SetFocus;
        exit;
      end;
    end
    else
    begin
      txtSenha.Text:='';
      Application.MessageBox('Usuario n�o cadastrado.','Aviso', mb_Ok);
      if Qde > 2 then
      begin
        Application.Terminate;
        exit;
      end;
      txtUsuario.SetFocus;
      Inc(Qde);
    end;
  finally
    FreeAndNil(seek);
  end;
end;

procedure TfrmSenha.FormShow(Sender: TObject);
begin
  txtUsuario.SetFocus;
end;

procedure TfrmSenha.FormCreate(Sender: TObject);
begin
  Qde := 1;
end;

procedure TfrmSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TfrmSenha.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key of
    vk_Return: Perform(Wm_NextDlgCtl, 0, 0);
    vk_Up: Perform(Wm_NextDlgCtl, 1, 0);
    vk_Escape: btnCancelar.Click;
  end
end;

procedure TfrmSenha.txtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnOk.Click;
end;

end.
