object frmConsultaMovEstoque: TfrmConsultaMovEstoque
  Left = 425
  Top = 139
  BorderStyle = bsSingle
  Caption = 'Consulta Movimenta'#231#227'o de Produtos'
  ClientHeight = 515
  ClientWidth = 796
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 796
    Height = 515
    Align = alClient
    BevelInner = bvRaised
    BorderStyle = bsSingle
    Caption = 'Panel1'
    TabOrder = 0
    object Panel3: TPanel
      Left = 2
      Top = 65
      Width = 788
      Height = 444
      Align = alClient
      TabOrder = 1
      object DBGrid1: TDBGrid
        Left = 1
        Top = 1
        Width = 786
        Height = 442
        Align = alClient
        Color = clWhite
        DataSource = DataSource1
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'SEQ'
            Width = 54
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CODDOC'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA'
            Width = 92
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TIPO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NUMEROLOTE'
            Width = 126
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATAVENCIMENTO'
            Width = 101
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENTRADA'
            Width = 71
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SAIDA'
            Width = 63
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SALDO'
            Width = 65
            Visible = True
          end>
      end
      object QuickRep1: TQuickRep
        Left = 808
        Top = 32
        Width = 794
        Height = 1123
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Functions.Strings = (
          'PAGENUMBER'
          'COLUMNNUMBER'
          'REPORTTITLE')
        Functions.DATA = (
          '0'
          '0'
          #39#39)
        Options = [FirstPageHeader, LastPageFooter]
        Page.Columns = 1
        Page.Orientation = poPortrait
        Page.PaperSize = A4
        Page.Values = (
          100.000000000000000000
          2970.000000000000000000
          100.000000000000000000
          2100.000000000000000000
          100.000000000000000000
          100.000000000000000000
          0.000000000000000000)
        PrinterSettings.Copies = 1
        PrinterSettings.OutputBin = Auto
        PrinterSettings.Duplex = False
        PrinterSettings.FirstPage = 0
        PrinterSettings.LastPage = 0
        PrinterSettings.UseStandardprinter = False
        PrinterSettings.UseCustomBinCode = False
        PrinterSettings.CustomBinCode = 0
        PrinterSettings.ExtendedDuplex = 0
        PrinterSettings.UseCustomPaperCode = False
        PrinterSettings.CustomPaperCode = 0
        PrinterSettings.PrintMetaFile = False
        PrinterSettings.PrintQuality = 0
        PrinterSettings.Collate = 0
        PrinterSettings.ColorOption = 0
        PrintIfEmpty = True
        SnapToGrid = True
        Units = MM
        Zoom = 100
        PrevFormStyle = fsNormal
        PreviewInitialState = wsMaximized
        PreviewHeight = 600
        PrevInitialZoom = qrZoomToFit
        object QRBand1: TQRBand
          Left = 38
          Top = 120
          Width = 718
          Height = 24
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = True
          Frame.DrawLeft = True
          Frame.DrawRight = True
          AlignToBottom = False
          Color = clWhite
          TransparentBand = False
          ForceNewColumn = False
          ForceNewPage = False
          Size.Values = (
            63.500000000000000000
            1899.708333333333000000)
          PreCaluculateBandHeight = False
          KeepOnOnePage = False
          BandType = rbDetail
          object QRDBText1: TQRDBText
            Left = 8
            Top = 3
            Width = 23
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.979166666666670000
              21.166666666666670000
              7.937500000000000000
              60.854166666666680000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Color = clWhite
            DataField = 'Data'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRDBText2: TQRDBText
            Left = 72
            Top = 3
            Width = 72
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.979166666666670000
              190.500000000000000000
              7.937500000000000000
              190.500000000000000000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Color = clWhite
            DataField = 'NroDocumento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRDBText3: TQRDBText
            Left = 152
            Top = 3
            Width = 289
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.979166666666670000
              402.166666666666700000
              7.937500000000000000
              764.645833333333200000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = False
            AutoStretch = False
            Color = clWhite
            DataField = 'Operacao'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRDBText4: TQRDBText
            Left = 498
            Top = 3
            Width = 38
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.979166666666670000
              1317.625000000000000000
              7.937500000000000000
              100.541666666666700000)
            Alignment = taRightJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Color = clWhite
            DataField = 'Entrada'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Mask = '#,##0'
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRDBText5: TQRDBText
            Left = 597
            Top = 3
            Width = 28
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.979166666666670000
              1579.562500000000000000
              7.937500000000000000
              74.083333333333320000)
            Alignment = taRightJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Color = clWhite
            DataField = 'Saida'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Mask = '#,##0'
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRDBText6: TQRDBText
            Left = 685
            Top = 3
            Width = 28
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.979166666666670000
              1812.395833333333000000
              7.937500000000000000
              74.083333333333320000)
            Alignment = taRightJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Color = clWhite
            DataField = 'Saldo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Mask = '#,##0'
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRShape1: TQRShape
            Left = 68
            Top = -1
            Width = 2
            Height = 25
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              66.145833333333320000
              179.916666666666700000
              -2.645833333333333000
              5.291666666666667000)
            Shape = qrsVertLine
            VertAdjust = 0
          end
          object QRShape2: TQRShape
            Left = 148
            Top = -1
            Width = 2
            Height = 25
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              66.145833333333320000
              391.583333333333300000
              -2.645833333333333000
              5.291666666666667000)
            Shape = qrsVertLine
            VertAdjust = 0
          end
          object QRShape3: TQRShape
            Left = 452
            Top = -1
            Width = 2
            Height = 25
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              66.145833333333320000
              1195.916666666667000000
              -2.645833333333333000
              5.291666666666667000)
            Shape = qrsVertLine
            VertAdjust = 0
          end
          object QRShape4: TQRShape
            Left = 540
            Top = -1
            Width = 2
            Height = 25
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              66.145833333333320000
              1428.750000000000000000
              -2.645833333333333000
              5.291666666666667000)
            Shape = qrsVertLine
            VertAdjust = 0
          end
          object QRShape5: TQRShape
            Left = 628
            Top = -1
            Width = 2
            Height = 25
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              66.145833333333320000
              1661.583333333333000000
              -2.645833333333333000
              5.291666666666667000)
            Shape = qrsVertLine
            VertAdjust = 0
          end
        end
        object QRBand2: TQRBand
          Left = 38
          Top = 38
          Width = 718
          Height = 82
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = True
          Frame.DrawLeft = False
          Frame.DrawRight = False
          AlignToBottom = False
          Color = clWhite
          TransparentBand = False
          ForceNewColumn = False
          ForceNewPage = False
          Size.Values = (
            216.958333333333400000
            1899.708333333333000000)
          PreCaluculateBandHeight = False
          KeepOnOnePage = False
          BandType = rbColumnHeader
          object QRLabel1: TQRLabel
            Left = 216
            Top = 8
            Width = 250
            Height = 19
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              50.270833333333330000
              571.500000000000000000
              21.166666666666670000
              661.458333333333200000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Caption = 'Relat'#243'rio do Movimento de Estoque'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 12
          end
          object lblCodigo: TQRLabel
            Left = 16
            Top = 40
            Width = 54
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.979166666666670000
              42.333333333333330000
              105.833333333333300000
              142.875000000000000000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Caption = 'lblCodigo'
            Color = clWhite
            Transparent = False
            WordWrap = True
            FontSize = 10
          end
          object lblNomProduto: TQRLabel
            Left = 80
            Top = 40
            Width = 86
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.979166666666670000
              211.666666666666700000
              105.833333333333300000
              227.541666666666700000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Caption = 'lblNomProduto'
            Color = clWhite
            Transparent = False
            WordWrap = True
            FontSize = 10
          end
          object QRLabel2: TQRLabel
            Left = 8
            Top = 64
            Width = 23
            Height = 15
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              39.687500000000000000
              21.166666666666670000
              169.333333333333300000
              60.854166666666680000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Caption = 'Data'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRLabel3: TQRLabel
            Left = 152
            Top = 64
            Width = 49
            Height = 15
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              39.687500000000000000
              402.166666666666700000
              169.333333333333300000
              129.645833333333300000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Caption = 'Opera'#231#227'o'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRLabel4: TQRLabel
            Left = 498
            Top = 64
            Width = 38
            Height = 15
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              39.687500000000000000
              1317.625000000000000000
              169.333333333333300000
              100.541666666666700000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Caption = 'Entrada'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRLabel5: TQRLabel
            Left = 596
            Top = 64
            Width = 28
            Height = 15
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              39.687500000000000000
              1576.916666666667000000
              169.333333333333300000
              74.083333333333320000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Caption = 'Saida'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRLabel6: TQRLabel
            Left = 684
            Top = 64
            Width = 28
            Height = 15
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              39.687500000000000000
              1809.750000000000000000
              169.333333333333300000
              74.083333333333320000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Caption = 'Saldo'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRLabel7: TQRLabel
            Left = 72
            Top = 64
            Width = 55
            Height = 15
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              39.687500000000000000
              190.500000000000000000
              169.333333333333300000
              145.520833333333300000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Caption = 'Documento'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 8
          end
          object QRSysData1: TQRSysData
            Left = 674
            Top = 27
            Width = 42
            Height = 11
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              29.104166666666670000
              1783.291666666667000000
              71.437500000000000000
              111.125000000000000000)
            Alignment = taRightJustify
            AlignToBand = False
            AutoSize = True
            Color = clWhite
            Data = qrsDateTime
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Text = ''
            Transparent = False
            FontSize = 6
          end
          object QRSysData2: TQRSysData
            Left = 687
            Top = 3
            Width = 29
            Height = 11
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              29.104166666666670000
              1817.687500000000000000
              7.937500000000000000
              76.729166666666680000)
            Alignment = taRightJustify
            AlignToBand = False
            AutoSize = True
            Color = clWhite
            Data = qrsPageNumber
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Text = ''
            Transparent = False
            FontSize = 6
          end
        end
        object QRBand3: TQRBand
          Left = 38
          Top = 144
          Width = 718
          Height = 24
          Frame.Color = clBlack
          Frame.DrawTop = True
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          AlignToBottom = False
          Color = clWhite
          TransparentBand = False
          ForceNewColumn = False
          ForceNewPage = False
          Size.Values = (
            63.500000000000000000
            1899.708333333333000000)
          PreCaluculateBandHeight = False
          KeepOnOnePage = False
          BandType = rbPageFooter
          object QRLabel8: TQRLabel
            Left = 5
            Top = 4
            Width = 124
            Height = 13
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              34.395833333333330000
              13.229166666666670000
              10.583333333333330000
              328.083333333333300000)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Caption = 'Industria de Aluminios Gallego Dias.'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 6
          end
        end
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 2
      Width = 788
      Height = 63
      Align = alTop
      TabOrder = 0
      object Label2: TLabel
        Left = 31
        Top = 36
        Width = 38
        Height = 13
        Caption = 'Produto'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblProduto: TStaticText
        Left = 131
        Top = 34
        Width = 332
        Height = 21
        AutoSize = False
        BorderStyle = sbsSunken
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object BtnOk: TBitBtn
        Left = 467
        Top = 34
        Width = 75
        Height = 25
        Cursor = crHandPoint
        Caption = '&Consultar'
        Glyph.Data = {
          26040000424D2604000000000000360000002800000012000000120000000100
          180000000000F0030000120B0000120B00000000000000000000C8D0D4C9D1D5
          CBD2D7B4B2B69B9491A4A2A1C6CBD0CDD8DCC8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D40000C8D0D4D0D9DDB5B4B37F7F83656C
          817571889E8F92C6CAC8D0D8DDC8CFD4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D40000C8D1D6D5E3E8BABEBF6E96A24399C7578AC986658CAB
          888FC4C9CBCED8DBC8D0D4C7CFD3C8D0D4C7CFD3C8CFD3C8D0D4C8D0D4C8D0D4
          0000CAD7DFC3CCD0B2AEAB74797E488AAD45ABEE5587CC71668E918C8FC3C9CC
          D2DDE1D3DDE3D0D9DFD1DAE0CFD8DDC9D1D6C7CFD3C8D0D40000BBA797AE7760
          BF6854BF5248A45B60708CB23FA7F04589D0726B88938B94B6B9BDB2B6B6ACAF
          ACAFB1AFBAC1C3CDD5DBCED6DBC7CFD30000AC6A40BA4015E5462EFF6352F960
          45B7685C669ABE4CADEC7483B273606992827E9F9587ABA48EAAA490A09D94AB
          AEAFC7CFD4CBD4D80000B3795BD9573BFD6B58FF866FF58554E18D53BAA28587
          939F818FA5998279B69F88D8CBADF0E9C9EAE6CDC2BBAB948D88A0A1A4CCD5DA
          0000BFB9B9D67167F87B60F3805CD9855CE8BD8AFBCC95C16846996E60DDC5A1
          FFF5CCFFFFDDFFFFE4FFFFF4FFFFFFD6D2CB867E79B5BABA0000CBD7DCBEA9AB
          D4765DC056379C5B5DA47B8EBE857FB26C51B98975FBEDB9FDEFB9FEF9CCFFFF
          E2FFFFEFFFFFFDF3F2EDBCB4A490897C0000D0DADEB0B5B95B4237250B111217
          5C10248D23206A613853D4AD9DFDEDBBF6E6AEFCF6C9FDFEE4FAFFEBFEFFE8FC
          FBDAD8CEB291766E000094999F2D2F3507040B0E1E4C16399E0F41B70D379037
          3E68C6AF9FFDF2C9F3E3B0F5EBBBFDFBD4FFFFDBFFFFD7FBFAD1D3CAB1867271
          000035352B0B0A090C14301749931C60C61F5AC91A51BD274A8F978A7EFFFADF
          FEF9D6FAE5B9FBE4B3FDEBB6FFFDC7F3F4C8B1A9949893960000110F04211F0D
          212B3D2466BC2885F7307AEC3071E32562BE4F536DC0B4AAFDF9E7FFFDDBFFEF
          BFFFF2BDFFF1BECDBF9A908A7EBDC4CA0000151519333827262F321F59A02586
          F63797FF429DFF2D8AE9385D93989497C6BCB5DACBBAE7D1B4E2D2AEC9BA9BA9
          9D8CAAACACCDD7DC000042424A383A3D3E363C35486A2560A12C73C3367ACD2C
          71B75C7FA1B5C0C5ADA8A9AFA09FBFAFAAB9B1A7A7A7A0B1B7B9CED7DDC9D2D6
          00009B9A9B403E485243466C5F5C62656E45516D22294E272B45959596D6DFE2
          CED7DCC0C9CEBDC5CBBFC8CEC8D1D7CED8DFCAD2D7C8D0D40000CDD7DB6E7D7A
          4A554675756DA39F9F878B83454C3F545756C6CCCECAD2D6CAD2D6CAD3D7CAD3
          D7CAD3D7C9D1D5C8D0D3C8D0D4C8D0D40000CCD4D9CBD4D7929497605F6C5451
          5A5958507B8178BDC4CACED7DBC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D40000}
        TabOrder = 2
        OnClick = BtnOkClick
      end
      object btnImprimir: TBitBtn
        Left = 661
        Top = 10
        Width = 53
        Height = 40
        Hint = 'Imprimir o Movimento'
        Glyph.Data = {
          360C0000424D360C000000000000360000002800000020000000200000000100
          180000000000000C0000120B0000120B00000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8CDD1C4C9CCC8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C9D0D49EA1A26062
          62505051989C9EA6A9ABC6CBCEC7CBCE888587514B4C6461628C8B8DB9BDBFC8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4BDC2C44646464D4D4D5D5D
          5D3838383939394343434E43454D42446D6566ADA5A66F696A39333458565683
          8485B3B7B9C9D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C7CDD06B6C6D464646979797F5F5F5C1C1
          C1A1A1A16B6B6B4E4E4E766B6DA3989AA1999AD7CFD0FFFEFFEDE7E886848444
          42424A4848656465B1B5B8C8CFD3C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8CFD38B8D8E3D3D3D828282E3E3E3F3F3F3EAEAEAB6B6
          B6BABABAB0B0B0B0B0B08F8486796E706F6768877F809D9798D9D3D4F4EFF0F6
          F1F2AAA8A8535151454343585656A1A3A5C8CED2C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4ADB1B3454545727272D6D6D6FCFCFCF1F1F1ECECECF1F1F1BDBD
          BDABABABAFAFAFA7A7A7483D3F564B4D6A6263797172847E7F948E8FA29D9ECD
          C8C9E9E7E7FFFFFFCECCCC7F7D7D454343ABAEAFC8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4898B8C646565C9C9C9F0F0F0FAFAFAEFEFEFEDEDEDEBEBEBE0E0E0B8B8
          B8A7A7A7A8A8A8B9B9B9908A8B706A6B5C57585E595A747272817F7F88888897
          9797AEB0B0C5C7C7E1E3E3F8FAFA6A6C6CA5A9ABC8D0D4C8D0D4C8D0D4C8D0D4
          AFB3B5B8BDBFFFFFFFFCFCFCF5F5F5F1F1F1ECECECEDEDEDE6E6E6E4E4E4A8A8
          A8A7A7A7B0B0B0A7A7A7B3ADAEBCB6B7B8B3B49E999A878585716F6F82828291
          91919B9D9DA5A7A78D8F8F6B6D6D494B4BB2B7B9C8D0D4C8D0D4C8D0D4C8D0D4
          B3B7B9D3D3D3F9F9F9F4F4F4F6F6F6EAEAEAEBEBEBE3E3E3BBBBBB7373736363
          63818181848484A3A3A3ADADADAEAEAEB0B2B2B5B7B7B4B9B8B0B5B49FA5A48C
          92914A504F2C3231B5BBBA747A79414746B6BDBFC8D0D4C8D0D4C8D0D4C8D0D4
          B8BDBFCACACAF9F9F9F5F5F5E8E8E8E6E6E6A9A9A9717171929292C3C3C3B0B0
          B0898989838383717171757575909090A4A6A6B1B3B3B7BCBBB7BCBBB4BAB9B9
          BFBEBDC3C2A0A6A5C2C8C7808685454B4ABAC1C3C8D0D4C8D0D4C8D0D4C8D0D4
          ADB1B3C9C9C9F2F2F2EAEAEAA2A2A2797979909090D3D3D3D6D6D6D7D7D7B4B4
          B49E9E9EA5A5A59F9F9F9395958082827378777479787F8584A0A6A5B9BFBEBA
          C0BFB5BDBC8C94938F9594797F7E414746B2B9BAC8D0D4C8D0D4C8D0D4C8D0D4
          9B9EA0BEBEBE9898986C6C6CAAAAAADADADAE3E3E3D4D4D4D8D8D8CFCFCFE8E8
          E8E2E2E2D3D3D3B7B7B7A8AAAAA9ABABA3A8A79EA3A28E94936D7372676D6C83
          8988A6AEAD8A92919399985A605F535958AEB5B7C8D0D4C8D0D4C8D0D4C8D0D4
          909394727272B6B6B6E6E6E6DCDCDCDFDFDFD6D6D6D9D9D9D4D4D4DFDFDFF3F3
          F3DDDDDDE0E0E0ECECECE6E6E6DADADACACACAB3B3B3A6A8A8B3B5B5AEB3B290
          95947F84835E63626469687A7F7E4A4C4CBBC1C3C8D0D4C8D0D4C8D0D4C8D0D4
          959899D9D9D9E6E6E6E2E2E2DFDFDFD9D9D9D5D5D5D2D2D2CECECEEFEFEFBEBE
          BEBDBDBDBCBCBCB6B6B6D4D4D4E0E0E0E5E5E5E8E8E8E4E6E6CED0D0B7BCBBB6
          BBBAB1B6B5AFB4B3969B9A6F7473484A4AB6BCBEC8D0D4C8D0D4C8D0D4C8D0D4
          9B9EA0E7E7E7DCDCDCE1E1E1DADADAD7D7D7D6D6D6CECECEF4F4F4D1D1D1C4C4
          C4EDEDEDEBEBEBE7E7E7D7D2D3C0BBBCB3B1B1BCBABACDCBCBE0DEDEE7E7E7E2
          E2E2D6D6D6D2D2D2C5C5C58E8E8E656465C3C8CBC8D0D4C8D0D4C8D0D4C8D0D4
          A6AAACD5D5D5E4E4E4D8D8D8D5D5D5D1D1D1CFCFCFEFEFEFCCCCCCBEBEBEF3F3
          F3F1F1F1EDEDEDF1F1F1EEE9EAF2EDEEEDEBEBE1DFDFCCCACAB9B7B7B3B3B3BB
          BBBBD3D3D3DBDBDBDEDEDE858585898A8BC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C9D0D4A4AAACDCDDE1D0D1D5D2D4D5D4D6D7DCDEDEADAFAF9C9E9ECCCECEF3F6
          FAEEF1F5E8EBF3EEF1F9F3F1F1EDEBEBEBEDEEE6E8E9DFE2E6E7EAEEE5E7E8DA
          DCDDC0BEBDB2B0AFD5D1D06D6A6AC8CED2C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C5CCCF8E9195B1B5B9939596A7A9AA999B9BAEB0B0ABADAD9698988588
          8C8A8D91A2A5ADB4B7BFD9D7D7EDEBEBEEF0F1ECEEEFECEFF3E2E5E9E1E3E4E2
          E4E5B8B6B5BEBCBB989999C3C8CBC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C9D0D4BABFC0E7E8E6F3F0E8EAE7DFC1BFB5A8A69CB4B5
          ACC5C6BDBBC1BCABB1ACA49C959A928BA29D9C9C9796C4C3C5E3E2E4DBDDDEB6
          B8B9C8CFD39A9D9EC5CACDC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4B3B7B8F6F7F5FBF8F0FBF8F0E2E0D6D0CEC4C4C5
          BCB4B5ACAEB4AFBEC4BFD1C9C2D7CFC8D3CECDE0DBDA9D9C9EABAAACBDC2C5B9
          BFC19A9D9EC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4B2ACAAC7C8C8DDB5A9E5BDB1ECB5A6F8C1B2FFDC
          CDFFE3D4FFE4D6FFE9DBF8E5D6EAD7C8E0D5CDE4D9D1BCC0C2848383BFC5C8C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C3C2C2E0B8ACF4CCC0FFC8B9F8C1B2F8C1
          B2F4BDAEECBBADEAB9ABD6C3B4E6D3C4E0D5CDD6CBC3A3A4A5C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4B5B2ADF0CFBBF8D7C3FFD5BAFFD6BBFFDD
          BFFFDBBDF8DCBDF5D9BAF4DBC7E7CEBAD0BFB274665AC9D0D3C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4A59F99FAD9C5FFDECAFFDCC1FFDBC0FFDD
          BFFFDCBEFDE1C2FBDFC0F7DECAF3DAC6B3A295807368C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4CAD1D4B2B1ABFAE2CCFBE3CDFFE6C9FFE5C8FEE5
          C5FFE6C6F6EAC8F3E7C5FDE2CEFFE6D2A8978AA49B94C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C3C5C2C9C0B3FEE6D0FFE8D2FFE8CBFFE6C9FFE8
          C8FFEACAF9EDCBF8ECCAFBE0CCFFE5D1847366C1BFBCC8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4B2ACAAE3D3CCFFEBDBFFEDDDFFECD7FFEAD5FFED
          D8FFEDD8FFECD8FFECD8FFF4E5EED9CA7E756FCAD0D3C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4ACA5A2FAEAE3FFEDDDFFEFDFFFEED9FFEED9FFF2
          DDFFF1DCFFEDD9FFEEDAFCE7D8D6C1B2918A85C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4BBBABDC8CBCEFFF5F3F9F8EEF9F8EEEFF8EBEFF8EBF1F9
          EEF0F8EDF2F6F0F3F7F1FFF5EFA9A6A4C4C8CBC8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4A09A9CFFF4F2FFF6F4FDFCF2F8F7EDF2FBEEF3FCEFEFF7
          ECF0F8EDF6FAF4F6FAF4F2E6E0928C89C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4B8AFB3C9D0D4FFF8FCFFF9FDFFFCFAFFF6F4FFFFFCFFFFFCFFF9
          FBFFF8FAFFF9FFC8D0D4B2B4B6C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4CCCDD1C8AFB3C8AFB3E6CDD1BDB1AFB8ACAAC3BEBBCCC7C4C5B7
          B9C2B4B6CFB4BEC7C4CAC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4}
        TabOrder = 3
        OnClick = btnImprimirClick
      end
      object btnCancelar: TBitBtn
        Left = 723
        Top = 10
        Width = 53
        Height = 40
        Cursor = crHandPoint
        Hint = 'Fechar a Janela'
        Glyph.Data = {
          360C0000424D360C000000000000360000002800000020000000200000000100
          180000000000000C0000120B0000120B00000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D599A0B35F63
          9D3C407A2330641A275B3420682E1A6234404A414D5768787197A7A0C9D1D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C9D1D4B0B6B4787F8C12192C060A
          440F134D0B184C03104417034B1E0A5204101A000A1400100915251E5F6159B5
          BAB8C9D0D6C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4BEC7D2585BAB00006E0C009403008B0900
          7F06007C0A00830D02860C02840E048601017505057900005F00005F0000320B
          0D437F8786C0C8CAC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4A0A8BB313A590B0C7C06077704008C06008E0F06
          850B028108008108008107007F00007704047808087C06086C0A0C700D0F4500
          0033060D0A474E4CB8BEC0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D48484B52628A800009600008900079300038C0000890000
          9900009A01009705009B0003A100009C00068C00018700008500008301008208
          028901023E00002F363E34B8C0BFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D48585B548458400019900009100079300008600089100068F0600
          A20800A407009D03009900009800009A00068C00068C00008300058A05008607
          0188181955060743020A003F473EBFC6C0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4A9B1C5302FA105028D0000900702990B08930805900102900405930000
          A50000A60004960005970002A90002A90804990000900E087F100A8100008600
          00820200860B048F06004A00003C6C6E74C8CFD3C8D0D4C8D0D4C8D0D4C8D0D4
          C3CBD74850740A079202008A09049B020094413EC94F4CD70607950708960000
          A90404AE000A9C000C9E0002A90002A90400950A069B5D57CE3C36AD08038E06
          018C0300870500891A135E01004518181EA9ADB2C8D0D4C8D0D4C8D0D4C8D0D4
          5150C10A059E0000AA0000AE1B10763A2F95FDFCF8FFFFFC5E51B32013750000
          A60300A90003B40000B00901AC0600A92012705D4FADF6F9FDFBFEFF342D9C0E
          077600028B00068F040088050089000014454C5FC8CED3C8D0D4C8D0D4C1C6CF
          2C29A90400980000B30000B241369CB4A9FFFFFEFAFFFFFCEBDEFF594CAE0704
          AD0603AC0000B10008B90901AC0901AC5446A4D7C9FFFBFEFFF9FCFFE2DBFF40
          39A800058E00048D06008A0B048F091024141B2FB4B6BDC8D0D4C8D0D47370A9
          0001A00A10AF0000A20002AA6B7890AAB7CFFFFAFFFFF7FFFFFAFFFFFAFF504B
          C41A158E0000AD0300B7211A6B5B54A5F0F7E2F7FEE9FFFFFCFEFFFBD3DBFF78
          80BB0003A000009D000093000598100C6B0000496D775DCAD2D4C9D0D7443F83
          0006A50002A1000BB30009B1202D4557647CC9B8C1FFFAFFFEF9FFFCF7FFDFDA
          FF504BC40300B70702BB635CADE0D9FFF0F7E2FFFFF1F9FAF6DFE0DC666EA915
          1D580005A20005A20002950002951A1675000050374221CBD6B57F86FB0E158A
          090CB50001AA0000BC0204C71004C80000B6495082A1A8DAFBFFFBFBFFFBF2FC
          F6F3FDF75154985D60A4FFF9FFF4EEFFF4FFF7F4FFF7C0CBFF5C679B0A00B412
          01BC0000B20000B40000B30000B2120E85020075202332AAADBC5E65DA091085
          0A0DB6070AB30406C90A0CCF0600BE180CD0232A5C535A8CB8BFB8F5FCF5F8FF
          FCF8FFFCE8EBFFE8EBFFFAF4FFFFF9FFF1FFF4D1E2D46A75A91F2A5E1302BD0A
          00B40102B60000B30000B70000B80E0A810D0980151827A0A3B22431CD0A17B3
          0900CB0B00CD0601D90500D80007C70008C80002C20005C56963A4C8C2FFFFFC
          EBFFFFF0FFFAFFFFFBFFFFFFF5FFFFF5CDD6FF747DBC0100BF0300C10407C005
          08C10307BA0001B40306AE0003AB0C019711069C07122098A3B11623BF000DA9
          1201D41706D90500D80904DC000FCF000ACA0308C80002C22A24658680C1FFFD
          ECFFFFEFFFFBFFFCF6FFFFFEF0FFFFF28790CF1F28670801C60801C60001BA05
          08C1060ABD0004B70609B10000A70F049A170CA206111F98A3B10A14C5020CBD
          0908CC0E0DD10B06DD0F0AE10A09DB0201D30300DC0A00E31A1B954344BEEBFF
          EBECFFECFFFEFFFFFEFFF4FFF7EFFFF24B41BD1D138F0000CB0000CA0004D400
          05D50D00D80400CF0A0DAF0609AB0C01A3150AAC1A1824A5A3AF121CCD0913C4
          1615D90A09CD110CE3130EE50A09DB0807D90800E10400DD4546C0C3C4FFEBFF
          EBF1FFF1FFFEFFFFFCFEF1FFF4F4FFF7DDD3FF5B51CD0105D00000C90000CD00
          03D30D00D80B00D60E11B30609AB1207A91106A8211F2BABA9B54236DC2115BB
          1E12DC1D11DB0D16E20E17E30510E40006DA1E248D4248B1ECE8DDFFFBF0FFFF
          F4FFFFF4E9F0FFF4FBFFFFFFFCFFFFFCFCFFF3F9FFF04949C51E1E9A0000D50D
          0AE20B00E20900E00B0FC10206B81108B60E05B3232940B4BAD16155FB2E22C8
          1E12DC281CE61821ED1821ED040FE30008DC5157C0BFC5FFFFFFF7FFFFF7FFFF
          F4F2EBDC8C93A2868D9CDAD1CEFFFFFCFDFFF4FDFFF4DADAFF4949C50100D606
          03DB1005E70900E00C10C2060ABC140BB90F06B4676D7FC9D0D57C86F82832A4
          1E1DE11A19DD2220FC211FFB2E2CA75553CEDCD4D4FFFEFEFFFFEBFFFFE9CBBF
          FF796DCD0300E60000E1726DABAFAAE8FFFAF7FFFFFCFBFFF2FBFFF25961CC1E
          2691100BE20E09E00712C7040FC41B17B30100999FAAAAC8D0D4C6CEDB3F49A6
          2C2BEF2D2CF02A28FF2927FF5F5DD8B2B0FFFFFEFEFFFEFEFFFFE8E7DAC0695D
          BD2E22820701EA0600E92F2A6856518FC6BFBCFFFFFCF7FFEEFAFFF1D8E0FF53
          5BC60E09E01611E80A15CA0510C51C18B408049DC3CCCEC8D0D4C8D0D47D84B2
          221AF5332BFF2D24FF2B22FF747EB4B2BCF2F7FFEFECFCE4BDC6FF5861B80000
          ED0600F30004D50006D70001E40004E74948909C9BE3FFFFEAFFFFE9A7A3FF73
          6FCF1616DE1818E01317D40D11CE252B747D84B3C8D0D4C8D0D4C8D0D4BFC6DC
          443FF1332BFF3F36FF3C33FF5B659B646EA4CADAC2CEDEC6525BB2242D840400
          F10701F40008D9000ADB0005E80000E133327A47468EB2B899BDC3A45C58B844
          40A02424EC1616DE1A1EDB1519D6383E7DBCC3DBC8D0D4C8D0D4C8D0D4C8D0D4
          797ADD3E3AD54947FE4745FC5D59E15E5AE2464FB1535CBE2728F41516E21116
          FF0A0FF80300EF0A02F6000DF0000AED2413EC2E1DF64436BD5244CB391EFF3B
          20FF282DF41D22E92D24D92C25C89DA2AFC8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C0C5DF6160D04240F74A48FF6D69F16D69F1717ADC626BCD4A4BFF4445FF1C21
          FF1217FF2119FF1D15FF1021FF1627FF3928FF3D2CFF594BD25446CD4328FF48
          2DFF272CF32126ED251CD14943D9C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4BECACB6358E25644FD5656FF6565FF7076FD7A80FF7F82F5777AED746E
          FD6963F24F53E1484CDA4F4AE95D58F75360F8505DF54E5AFE3E4AEE4144FF35
          38FE312BFC312BFC64768AC7D1D8C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4A39EE9685DE45252FE6464FF767CFF7E84FF8C8FFF9194FF928C
          FF8781FF767AFF797DFF746FFF6F6AFF5C69FF5966FE525EFF4551F54043FF30
          33F92A24F5302CE6C6D0D8C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4BBC5D15F60DF4A48F8656BFF767CFF9B94FD9F98FFADA6
          F7B1AAFB9F99FF958FFE988AFF8B7DFA6B7AFE6372F6524FFF4F4CFF5040EC68
          5EDF7F91A1C9D2D7C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4BDC3E07678EA757CDC5C62F78C85EE9790F9A69F
          F0AEA7F8A59FFFA19BFF9688FF9082FF6473F75E6DF1514EFF5959E7574CD69D
          98EBC8D0D4C9D1D6C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4BFC2D99B9AC18B8EC97776DE6C6E
          FF7678FF7380FF6370FF736DFF605AFB5363EC3F4FD847499DACB1D6C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C7CEDA8D8CF46365
          F95C5EF24C59F54C59F55B55F66660FF6979FF95A5FFE4E6FFC8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4}
        TabOrder = 4
        OnClick = btnCancelarClick
      end
      object CodPro: TEdit
        Left = 76
        Top = 34
        Width = 53
        Height = 21
        TabOrder = 0
        OnExit = CodProExit
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = SQLMovimento
    Left = 160
    Top = 9
  end
  object PopupMenu1: TPopupMenu
    Left = 33
    Top = 128
    object popLocalizar: TMenuItem
      Caption = '&Localizar'
      ShortCut = 121
      OnClick = popLocalizarClick
    end
  end
  object SQLMovimento: TFDQuery
    Connection = DM.DataBase
    SQL.Strings = (
      'select * from consultamov(:codpro)')
    Left = 226
    Top = 9
    ParamData = <
      item
        Name = 'CODPRO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object SQLMovimentoSEQ: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'SEQ'
      Origin = 'SEQ'
    end
    object SQLMovimentoNUMEROLOTE: TStringField
      DisplayLabel = 'Numero Lote'
      FieldName = 'NUMEROLOTE'
      Origin = 'NUMEROLOTE'
    end
    object SQLMovimentoDATAVENCIMENTO: TDateField
      DisplayLabel = 'Data Vencimento'
      FieldName = 'DATAVENCIMENTO'
      Origin = 'DATAVENCIMENTO'
    end
    object SQLMovimentoDATA: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object SQLMovimentoCODDOC: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'CODDOC'
      Origin = 'CODDOC'
      Size = 10
    end
    object SQLMovimentoTIPO: TStringField
      DisplayLabel = 'Opera'#231#227'o'
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object SQLMovimentoPRCOMPRA: TBCDField
      FieldName = 'PRCOMPRA'
      Origin = 'PRCOMPRA'
      Precision = 18
      Size = 2
    end
    object SQLMovimentoPRVENDA: TBCDField
      FieldName = 'PRVENDA'
      Origin = 'PRVENDA'
      Precision = 18
      Size = 2
    end
    object SQLMovimentoENTRADA: TBCDField
      DisplayLabel = 'Entrada'
      FieldName = 'ENTRADA'
      Origin = 'ENTRADA'
      Precision = 18
      Size = 2
    end
    object SQLMovimentoSAIDA: TBCDField
      DisplayLabel = 'Saida'
      FieldName = 'SAIDA'
      Origin = 'SAIDA'
      Precision = 18
      Size = 2
    end
    object SQLMovimentoSALDO: TBCDField
      DisplayLabel = 'Saldo'
      FieldName = 'SALDO'
      Origin = 'SALDO'
      Precision = 18
      Size = 2
    end
  end
end
