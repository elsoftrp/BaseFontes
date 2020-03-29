unit CadGrupos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ModeloDiretoDac, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup, Vcl.ImgList, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TfrmCadGrupos = class(TfrmModeloDiretoDac)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadGrupos: TfrmCadGrupos;

implementation

{$R *.dfm}

uses DataModulo;

procedure TfrmCadGrupos.FormShow(Sender: TObject);
begin
  FConnection := DM.DataBase;
  vQuerydac   := DM.SQLGrupos;
  FCampoChave := 'CodGrupo';
  FNomeTabela := 'Grupos';
  FFocoI := DBEdit1;
  FFocoA := DBEdit1;

  inherited;

end;

end.
