unit DataModuloR;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MSSQLDef, FireDAC.Phys.FBDef,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDMR = class(TDataModule)
    FDOrig: TFDConnection;
    FDDest: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qrOrigem: TFDQuery;
    qrDestino: TFDQuery;
    SQLCidades: TFDQuery;
    qrDestinoContato: TFDQuery;
    qrOrigemContato: TFDQuery;
    SQLLaboratorios: TFDQuery;
    qrOrigemContatoF: TFDQuery;
    qrDestinoContatoF: TFDQuery;
    FDImg: TFDConnection;
    qryImgOrig: TFDQuery;
    qryImgDest: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMR: TDMR;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
