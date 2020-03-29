unit DataReport;

interface

uses
  System.SysUtils, System.Classes, frxExportRTF, frxExportImage, frxExportXLS,
  frxExportHTML, frxClass, frxExportPDF, frxDesgn, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxDBSet;

type
  TDMReport = class(TDataModule)
    frxReport1: TfrxReport;
    frxDesigner1: TfrxDesigner;
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxXLSExport1: TfrxXLSExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxRTFExport1: TfrxRTFExport;
    frxDBDataset1: TfrxDBDataset;
    FDQuery1: TFDQuery;
    frxProdutos: TfrxDBDataset;
    SQLProdutos: TFDQuery;
    frxRelEntradasResumido: TfrxDBDataset;
    SQLRelEntradasResumido: TFDQuery;
    frxRelEntradasDetalhado: TfrxDBDataset;
    SQLRelEntradasDetalhado: TFDQuery;
    frxVendasProdutos: TfrxDBDataset;
    SQLVendasProdutos: TFDQuery;
    frxVendasResumido: TfrxDBDataset;
    SQLVendasResumido: TFDQuery;
    frxVendasDetalhado: TfrxDBDataset;
    SQLVendasDetalhado: TFDQuery;
    frxClientes: TfrxDBDataset;
    SQLClientes: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMReport: TDMReport;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses DataModulo;

{$R *.dfm}

end.
