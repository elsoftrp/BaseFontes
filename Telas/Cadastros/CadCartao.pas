unit CadCartao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ModeloDiretoDac, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup, Vcl.ImgList, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TfrmCadCartao = class(TfrmModeloDiretoDac)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCartao: TfrmCadCartao;

implementation

{$R *.dfm}

uses DataModulo;

procedure TfrmCadCartao.FormShow(Sender: TObject);
begin
  FConnection := DM.DataBase;
  vQuerydac   := DM.SQLCartao;
  FCampoChave := 'CodCartao';
  FNomeTabela := 'CartaoCredito';
  FFocoI := DBEdit1;
  FFocoA := DBEdit1;

  inherited;

end;

end.
