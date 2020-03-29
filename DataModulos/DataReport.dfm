object DMReport: TDMReport
  OldCreateOrder = False
  Height = 454
  Width = 422
  object frxReport1: TfrxReport
    Version = '4.15.10'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42109.629533588000000000
    ReportOptions.LastChange = 43403.399202928200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 40
    Top = 32
    Datasets = <
      item
        DataSet = frxVendasProdutos
        DataSetName = 'VendasProdutos'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'dataini'
        Value = #39#39
      end
      item
        Name = 'datafim'
        Value = #39#39
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        Height = 26.456710000000000000
        Top = 166.299320000000000000
        Width = 718.110700000000000000
        DataSet = frxVendasProdutos
        DataSetName = 'VendasProdutos'
        RowCount = 0
        object FarmaciaLucrocodproduto: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999994000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSetName = 'FarmaciaLucro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VendasProdutos."CODPRO"]')
          ParentFont = False
        end
        object FarmaciaLucrodespro: TfrxMemoView
          Left = 56.692950000000000000
          Top = 3.779529999999994000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSetName = 'FarmaciaLucro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VendasProdutos."DESPRO"]')
          ParentFont = False
        end
        object FarmaciaLucroqdetotal: TfrxMemoView
          Left = 272.126160000000000000
          Top = 3.779529999999994000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSetName = 'FarmaciaLucro'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VendasProdutos."QDETOTAL"]')
          ParentFont = False
        end
        object FarmaciaLucroMediavenda: TfrxMemoView
          Left = 340.157700000000000000
          Top = 3.779529999999994000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSetName = 'FarmaciaLucro'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VendasProdutos."MEDIAVENDA"]')
          ParentFont = False
        end
        object FarmaciaLucromediacusto: TfrxMemoView
          Left = 415.748300000000000000
          Top = 3.779529999999994000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSetName = 'FarmaciaLucro'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VendasProdutos."MEDIACUSTO"]')
          ParentFont = False
        end
        object FarmaciaLucrototvenda: TfrxMemoView
          Left = 487.559370000000000000
          Top = 3.779529999999994000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSetName = 'FarmaciaLucro'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VendasProdutos."TOTVENDA"]')
          ParentFont = False
        end
        object FarmaciaLucrototcusto: TfrxMemoView
          Left = 559.370440000000000000
          Top = 3.779529999999994000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSetName = 'FarmaciaLucro'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VendasProdutos."TOTCUSTO"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 634.181510000000000000
          Top = 3.779529999999994000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[100-<VendasProdutos."totcusto">/<VendasProdutos."totvenda">*100' +
              ']%')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 22.677180000000000000
        Top = 332.598640000000000000
        Width = 718.110700000000000000
      end
      object ColumnHeader1: TfrxColumnHeader
        Height = 86.929190000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 585.827150000000000000
          Top = 26.456710000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          ShowHint = False
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#] / [TotalPages#]')
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.252010000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 56.692950000000000000
          Top = 64.252010000000000000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Produto')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 272.126160000000000000
          Top = 64.252010000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quant.Total')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 340.937230000000000000
          Top = 64.252010000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Media Venda')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 419.527830000000000000
          Top = 64.252010000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Media Custo')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 491.338900000000000000
          Top = 64.252010000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Tot. Venda')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 563.149970000000000000
          Top = 64.252010000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Tot. Custo')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 83.149660000000000000
          Width = 714.331170000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo9: TfrxMemoView
          Left = 204.094620000000000000
          Top = 7.559059999999999000
          Width = 309.921460000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Relat'#243'rio Vendas Produtos')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 160.630025000000000000
          Top = 30.236240000000000000
          Width = 396.850650000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Periodo de [dataini]  at'#233' [datafim]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 559.370440000000000000
          Top = 3.779530000000001000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]  [Time]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 634.961040000000000000
          Top = 64.252010000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '% Margem')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        Height = 56.692950000000000000
        Top = 253.228510000000000000
        Width = 718.110700000000000000
        object Line2: TfrxLineView
          Left = 3.779530000000000000
          Width = 710.551640000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object SysMemo1: TfrxSysMemoView
          Left = 238.110390000000000000
          Top = 7.559060000000017000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<VendasProdutos."qdetotal">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo2: TfrxSysMemoView
          Left = 457.323130000000000000
          Top = 7.559060000000017000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<VendasProdutos."totvenda">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo3: TfrxSysMemoView
          Left = 559.370440000000000000
          Top = 7.559060000000017000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<VendasProdutos."totcusto">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo4: TfrxSysMemoView
          Left = 532.913730000000000000
          Top = 30.236239999999980000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<VendasProdutos."totvenda">,MasterData1)-SUM(<VendasProduto' +
              's."totcusto">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo5: TfrxSysMemoView
          Left = 627.401980000000000000
          Top = 7.559060000000017000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[100-SUM(<VendasProdutos."totcusto">,MasterData1)/SUM(<VendasPro' +
              'dutos."totvenda">,MasterData1)*100] %')
          ParentFont = False
        end
      end
    end
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 88
    Top = 32
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 160
    Top = 32
  end
  object frxHTMLExport1: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 200
    Top = 32
  end
  object frxXLSExport1: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 248
    Top = 32
  end
  object frxJPEGExport1: TfrxJPEGExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 296
    Top = 32
  end
  object frxRTFExport1: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 344
    Top = 32
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 344
    Top = 88
  end
  object FDQuery1: TFDQuery
    Connection = DM.DataBase
    Left = 280
    Top = 88
  end
  object frxProdutos: TfrxDBDataset
    UserName = 'Produtos'
    CloseDataSource = False
    DataSet = SQLProdutos
    BCDToCurrency = False
    Left = 104
    Top = 128
  end
  object SQLProdutos: TFDQuery
    Connection = DM.DataBase
    SQL.Strings = (
      
        'SELECT (select sum(S.Estoque) from saldoestoque S where S.codpro' +
        '=p.codpro group by S.codpro) Saldo, '
      'p.*, g.desGrupo'
      'FROM Produtos p INNER JOIN Grupos g ON p.CodGrupo = g.CodGrupo '
      'order by p.codgrupo, despro')
    Left = 40
    Top = 128
  end
  object frxRelEntradasResumido: TfrxDBDataset
    UserName = 'EntradasResumido'
    CloseDataSource = False
    DataSet = SQLRelEntradasResumido
    BCDToCurrency = False
    Left = 104
    Top = 192
  end
  object SQLRelEntradasResumido: TFDQuery
    Connection = DM.DataBase
    SQL.Strings = (
      'select e.*, f.fantasiafor, f.nomfor, f.cnpjfor from entradas e'
      'left outer join fornecedores f on f.codfor=e.codfor'
      'order by e.datacad, e.codentrada')
    Left = 40
    Top = 192
  end
  object frxRelEntradasDetalhado: TfrxDBDataset
    UserName = 'EntradasDetalhado'
    CloseDataSource = False
    DataSet = SQLRelEntradasDetalhado
    BCDToCurrency = False
    Left = 104
    Top = 248
  end
  object SQLRelEntradasDetalhado: TFDQuery
    Connection = DM.DataBase
    SQL.Strings = (
      
        'select e.*, p.despro, i.codpro, i.qde, i.valor, i.total, i.numer' +
        'olote, '
      'i.datavencimento, f.fantasiafor, f.nomfor, f.cnpjfor '
      'from entradas e'
      'left outer join fornecedores f on f.codfor=e.codfor'
      'left outer join entradasitens i on i.codentrada=e.codentrada'
      'left outer join produtos p on p.codpro=i.codpro'
      'order by e.datacad, e.codentrada, i.seq')
    Left = 40
    Top = 248
  end
  object frxVendasProdutos: TfrxDBDataset
    UserName = 'VendasProdutos'
    CloseDataSource = False
    DataSet = SQLVendasProdutos
    BCDToCurrency = False
    Left = 288
    Top = 224
  end
  object SQLVendasProdutos: TFDQuery
    Connection = DM.DataBase
    SQL.Strings = (
      
        'select i.codpro, max(pr.despro) as despro, sum(i.quantidade) as ' +
        'qdetotal, '
      'avg(i.prvenda) as Mediavenda, avg(i.prcompra) as mediacusto, '
      
        'sum(i.prvenda*i.quantidade) as totvenda, sum(i.quantidade*i.prco' +
        'mpra) as totcusto '
      
        'from pedidos p left outer join pedidositens i on i.codpedido=p.c' +
        'odpedido '
      'left outer join produtos pr on pr.codpro=i.codpro'
      'group by i.codpro order by qdetotal desc, despro')
    Left = 224
    Top = 224
  end
  object frxVendasResumido: TfrxDBDataset
    UserName = 'VendasResumido'
    CloseDataSource = False
    DataSet = SQLVendasResumido
    BCDToCurrency = False
    Left = 288
    Top = 288
  end
  object SQLVendasResumido: TFDQuery
    Connection = DM.DataBase
    SQL.Strings = (
      
        'select p.*, c.nomcli from pedidos p left outer join clientes c o' +
        'n c.codcli=p.codcli')
    Left = 224
    Top = 288
  end
  object frxVendasDetalhado: TfrxDBDataset
    UserName = 'VendasDetalhado'
    CloseDataSource = False
    DataSet = SQLVendasDetalhado
    BCDToCurrency = False
    Left = 104
    Top = 312
  end
  object SQLVendasDetalhado: TFDQuery
    Active = True
    Connection = DM.DataBase
    SQL.Strings = (
      'select p.*, c.nomcli, i.*, pr.despro'
      
        'from pedidos p left outer join pedidositens i on i.codpedido=p.c' +
        'odpedido '
      'left outer join produtos pr on pr.codpro=i.codpro '
      'left outer join clientes c on c.codcli=p.codcli')
    Left = 40
    Top = 312
  end
  object frxClientes: TfrxDBDataset
    UserName = 'Clientes'
    CloseDataSource = False
    DataSet = SQLClientes
    BCDToCurrency = False
    Left = 296
    Top = 160
  end
  object SQLClientes: TFDQuery
    Connection = DM.DataBase
    SQL.Strings = (
      'select c.*, cid.cidade, cid.estado '
      'from clientes c '
      'left outer join cidades cid on cid.codcidade=c.codcidcli'
      'order by c.nomcli')
    Left = 232
    Top = 160
  end
end
