object frmConsProdutos: TfrmConsProdutos
  Left = 408
  Top = 193
  BorderStyle = bsNone
  Caption = 'frmConsProdutos'
  ClientHeight = 415
  ClientWidth = 793
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 793
    Height = 415
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvNone
    BevelWidth = 3
    BorderStyle = bsSingle
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 3
      Top = 32
      Width = 783
      Height = 376
      TabStop = False
      Align = alClient
      Color = clInfoBk
      DataSource = DSBusca
      FixedColor = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'CODPRO'
          Width = 52
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESPRO'
          Width = 396
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRVENDA'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESTOQUE'
          Width = 43
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODBARRA'
          Width = 122
          Visible = True
        end>
    end
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 783
      Height = 29
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Str: TEdit
        Left = 1
        Top = 1
        Width = 779
        Height = 24
        CharCase = ecUpperCase
        Color = 16777192
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = StrChange
        OnKeyDown = StrKeyDown
      end
    end
  end
  object DSBusca: TDataSource
    DataSet = DM.SQLConsPro
    Left = 698
    Top = 66
  end
end
