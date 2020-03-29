object DMR: TDMR
  OldCreateOrder = False
  Height = 529
  Width = 467
  object FDOrig: TFDConnection
    Params.Strings = (
      'Database=D:\Vacinas\database\VACINAS.FDB'
      'User_Name=sysdba'
      'Password=aranha'
      'DriverID=FB')
    LoginPrompt = False
    Left = 80
    Top = 72
  end
  object FDDest: TFDConnection
    Params.Strings = (
      'Database=C:\CasaVacinas\Database\DB_VACINAS.FDB'
      'User_Name=sysdba'
      'Password=aranha'
      'Server=localhost'
      'DriverID=FB')
    LoginPrompt = False
    Left = 248
    Top = 72
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 80
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 336
    Top = 16
  end
  object qrOrigem: TFDQuery
    Connection = FDOrig
    Left = 80
    Top = 168
  end
  object qrDestino: TFDQuery
    Connection = FDDest
    Left = 256
    Top = 168
  end
  object SQLCidades: TFDQuery
    Connection = FDOrig
    SQL.Strings = (
      'select * from cidades'
      'where cidade =:cidade and uf =:uf')
    Left = 312
    Top = 72
    ParamData = <
      item
        Name = 'CIDADE'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'UF'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qrDestinoContato: TFDQuery
    Connection = FDDest
    SQL.Strings = (
      'Select * from clientes'
      'where codcliente =:CodCliente')
    Left = 256
    Top = 224
    ParamData = <
      item
        Name = 'CODCLIENTE'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object qrOrigemContato: TFDQuery
    Connection = FDOrig
    SQL.Strings = (
      'Select * from ContatosCliente'
      'where ligacao >0'
      'order by ligacao')
    Left = 80
    Top = 224
  end
  object SQLLaboratorios: TFDQuery
    Connection = FDDest
    SQL.Strings = (
      'select * from laboratorios'
      'where nomlab =:nomlab')
    Left = 384
    Top = 72
    ParamData = <
      item
        Name = 'NOMLAB'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qrOrigemContatoF: TFDQuery
    Connection = FDOrig
    Left = 352
    Top = 152
  end
  object qrDestinoContatoF: TFDQuery
    Connection = FDDest
    Left = 392
    Top = 152
  end
  object FDImg: TFDConnection
    Params.Strings = (
      'Database=C:\CasaVacinas\Database\DB_PRODUTOS.FDB'
      'User_Name=sysdba'
      'Password=aranha'
      'Server=localhost'
      'Protocol=TCPIP'
      'DriverID=FB')
    LoginPrompt = False
    Left = 88
    Top = 336
  end
  object qryImgOrig: TFDQuery
    Connection = FDImg
    Left = 88
    Top = 400
  end
  object qryImgDest: TFDQuery
    Connection = FDImg
    Left = 144
    Top = 400
  end
end
