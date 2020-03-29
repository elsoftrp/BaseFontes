object DM: TDM
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 598
  Width = 557
  object DataBase: TFDConnection
    Params.Strings = (
      'Database=D:\Edson\Vendas\Database\DB_VENDAS.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 16
  end
  object SQLProgramas: TFDQuery
    CachedUpdates = True
    Connection = DataBase
    UpdateObject = UPProgramas
    SQL.Strings = (
      'Select *'
      'from Programas'
      'Where CodPrograma = :CodPrograma')
    Left = 272
    Top = 64
    ParamData = <
      item
        Name = 'CODPROGRAMA'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object UPProgramas: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO PROGRAMAS'
      '(CODPROGRAMA, NOMEPROGRAMA, DESCRICAO, MENU, '
      '  ITEM, SUBITEM)'
      
        'VALUES (:NEW_CODPROGRAMA, :NEW_NOMEPROGRAMA, :NEW_DESCRICAO, :NE' +
        'W_MENU, '
      '  :NEW_ITEM, :NEW_SUBITEM)')
    ModifySQL.Strings = (
      'UPDATE PROGRAMAS'
      
        'SET CODPROGRAMA = :NEW_CODPROGRAMA, NOMEPROGRAMA = :NEW_NOMEPROG' +
        'RAMA, '
      
        '  DESCRICAO = :NEW_DESCRICAO, MENU = :NEW_MENU, ITEM = :NEW_ITEM' +
        ', '
      '  SUBITEM = :NEW_SUBITEM'
      'WHERE CODPROGRAMA = :OLD_CODPROGRAMA')
    DeleteSQL.Strings = (
      'DELETE FROM PROGRAMAS'
      'WHERE CODPROGRAMA = :OLD_CODPROGRAMA')
    FetchRowSQL.Strings = (
      'SELECT CODPROGRAMA, NOMEPROGRAMA, DESCRICAO, MENU, ITEM, SUBITEM'
      'FROM PROGRAMAS'
      'WHERE CODPROGRAMA = :CODPROGRAMA')
    Left = 336
    Top = 64
  end
  object SQLProgramasUsuario: TFDQuery
    CachedUpdates = True
    MasterSource = FDSUsuarios_Programas
    MasterFields = 'CodUsuario'
    DetailFields = 'CodUsuario'
    Connection = DataBase
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateObject = UPProgramasUsuario
    SQL.Strings = (
      
        'Select ProgramasUsuario.*, Programas.NomePrograma as NomeProgram' +
        'a'
      'from ProgramasUsuario LEFT JOIN Programas ON'
      'ProgramasUsuario.CodPrograma = Programas.CodPrograma'
      'Where CodUsuario = :CodUsuario '
      'Order by Programas.NomePrograma')
    Left = 272
    Top = 120
    ParamData = <
      item
        Name = 'CODUSUARIO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object SQLProgramasUsuarioCODUSUARIO: TIntegerField
      FieldName = 'CODUSUARIO'
      Origin = 'CODUSUARIO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLProgramasUsuarioCODPROGRAMA: TIntegerField
      FieldName = 'CODPROGRAMA'
      Origin = 'CODPROGRAMA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLProgramasUsuarioBTNINCLUIR: TStringField
      FieldName = 'BTNINCLUIR'
      Origin = 'BTNINCLUIR'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLProgramasUsuarioBTNALTERAR: TStringField
      FieldName = 'BTNALTERAR'
      Origin = 'BTNALTERAR'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLProgramasUsuarioBTNEXCLUIR: TStringField
      FieldName = 'BTNEXCLUIR'
      Origin = 'BTNEXCLUIR'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLProgramasUsuarioBTNVISUALIZAR: TStringField
      FieldName = 'BTNVISUALIZAR'
      Origin = 'BTNVISUALIZAR'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLProgramasUsuarioBTNIMPRIMIR: TStringField
      FieldName = 'BTNIMPRIMIR'
      Origin = 'BTNIMPRIMIR'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLProgramasUsuarioBTNCHAVE1: TStringField
      FieldName = 'BTNCHAVE1'
      Origin = 'BTNCHAVE1'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLProgramasUsuarioBTNCHAVE2: TStringField
      FieldName = 'BTNCHAVE2'
      Origin = 'BTNCHAVE2'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLProgramasUsuarioBTNCHAVE3: TStringField
      FieldName = 'BTNCHAVE3'
      Origin = 'BTNCHAVE3'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLProgramasUsuarioBTNCHAVE4: TStringField
      FieldName = 'BTNCHAVE4'
      Origin = 'BTNCHAVE4'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLProgramasUsuarioNOMEPROGRAMA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOMEPROGRAMA'
      Origin = 'NOMEPROGRAMA'
      ProviderFlags = []
      Size = 50
    end
  end
  object UPProgramasUsuario: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO PROGRAMASUSUARIO'
      '(CODUSUARIO, CODPROGRAMA, BTNINCLUIR, BTNALTERAR, '
      '  BTNEXCLUIR, BTNVISUALIZAR, BTNIMPRIMIR, BTNCHAVE1, '
      '  BTNCHAVE2, BTNCHAVE3, BTNCHAVE4)'
      
        'VALUES (:NEW_CODUSUARIO, :NEW_CODPROGRAMA, :NEW_BTNINCLUIR, :NEW' +
        '_BTNALTERAR, '
      
        '  :NEW_BTNEXCLUIR, :NEW_BTNVISUALIZAR, :NEW_BTNIMPRIMIR, :NEW_BT' +
        'NCHAVE1, '
      '  :NEW_BTNCHAVE2, :NEW_BTNCHAVE3, :NEW_BTNCHAVE4)')
    ModifySQL.Strings = (
      'UPDATE PROGRAMASUSUARIO'
      
        'SET CODUSUARIO = :NEW_CODUSUARIO, CODPROGRAMA = :NEW_CODPROGRAMA' +
        ', '
      '  BTNINCLUIR = :NEW_BTNINCLUIR, BTNALTERAR = :NEW_BTNALTERAR, '
      
        '  BTNEXCLUIR = :NEW_BTNEXCLUIR, BTNVISUALIZAR = :NEW_BTNVISUALIZ' +
        'AR, '
      '  BTNIMPRIMIR = :NEW_BTNIMPRIMIR, BTNCHAVE1 = :NEW_BTNCHAVE1, '
      '  BTNCHAVE2 = :NEW_BTNCHAVE2, BTNCHAVE3 = :NEW_BTNCHAVE3, '
      '  BTNCHAVE4 = :NEW_BTNCHAVE4'
      
        'WHERE CODUSUARIO = :OLD_CODUSUARIO AND CODPROGRAMA = :OLD_CODPRO' +
        'GRAMA')
    DeleteSQL.Strings = (
      'DELETE FROM PROGRAMASUSUARIO'
      
        'WHERE CODUSUARIO = :OLD_CODUSUARIO AND CODPROGRAMA = :OLD_CODPRO' +
        'GRAMA')
    FetchRowSQL.Strings = (
      
        'SELECT CODUSUARIO, CODPROGRAMA, BTNINCLUIR, BTNALTERAR, BTNEXCLU' +
        'IR, '
      '  BTNVISUALIZAR, BTNIMPRIMIR, BTNCHAVE1, BTNCHAVE2, BTNCHAVE3, '
      '  BTNCHAVE4'
      'FROM PROGRAMASUSUARIO'
      'WHERE CODUSUARIO = :CODUSUARIO AND CODPROGRAMA = :CODPROGRAMA')
    Left = 336
    Top = 120
  end
  object SQLUsuarios: TFDQuery
    CachedUpdates = True
    Connection = DataBase
    UpdateObject = UPUsuarios
    SQL.Strings = (
      'Select *'
      'from Usuarios'
      'Where CodUsuario = :CodUsuario')
    Left = 272
    Top = 168
    ParamData = <
      item
        Name = 'CODUSUARIO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object SQLUsuariosCODUSUARIO: TIntegerField
      FieldName = 'CODUSUARIO'
      Origin = 'CODUSUARIO'
      Required = True
    end
    object SQLUsuariosLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Required = True
      Size = 15
    end
    object SQLUsuariosSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 10
    end
    object SQLUsuariosNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 40
    end
    object SQLUsuariosTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLUsuariosPERFIL: TStringField
      FieldName = 'PERFIL'
      Origin = 'PERFIL'
      FixedChar = True
      Size = 15
    end
    object SQLUsuariosCODCIDADE: TIntegerField
      FieldName = 'CODCIDADE'
      Origin = 'CODCIDADE'
    end
    object SQLUsuariosHOSTSMTP: TStringField
      FieldName = 'HOSTSMTP'
      Origin = 'HOSTSMTP'
      Size = 80
    end
    object SQLUsuariosUSUARIOCONTA: TStringField
      FieldName = 'USUARIOCONTA'
      Origin = 'USUARIOCONTA'
      Size = 80
    end
    object SQLUsuariosSENHACONTA: TStringField
      FieldName = 'SENHACONTA'
      Origin = 'SENHACONTA'
    end
    object SQLUsuariosAUTENTICA: TStringField
      FieldName = 'AUTENTICA'
      Origin = 'AUTENTICA'
      FixedChar = True
      Size = 1
    end
    object SQLUsuariosEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 150
    end
  end
  object UPUsuarios: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO USUARIOS'
      '(CODUSUARIO, LOGIN, SENHA, NOME, TIPO, '
      '  PERFIL, CODCIDADE, HOSTSMTP, USUARIOCONTA, '
      '  SENHACONTA, AUTENTICA, EMAIL)'
      
        'VALUES (:NEW_CODUSUARIO, :NEW_LOGIN, :NEW_SENHA, :NEW_NOME, :NEW' +
        '_TIPO, '
      
        '  :NEW_PERFIL, :NEW_CODCIDADE, :NEW_HOSTSMTP, :NEW_USUARIOCONTA,' +
        ' '
      '  :NEW_SENHACONTA, :NEW_AUTENTICA, :NEW_EMAIL)')
    ModifySQL.Strings = (
      'UPDATE USUARIOS'
      
        'SET CODUSUARIO = :NEW_CODUSUARIO, LOGIN = :NEW_LOGIN, SENHA = :N' +
        'EW_SENHA, '
      '  NOME = :NEW_NOME, TIPO = :NEW_TIPO, PERFIL = :NEW_PERFIL, '
      
        '  CODCIDADE = :NEW_CODCIDADE, HOSTSMTP = :NEW_HOSTSMTP, USUARIOC' +
        'ONTA = :NEW_USUARIOCONTA, '
      '  SENHACONTA = :NEW_SENHACONTA, AUTENTICA = :NEW_AUTENTICA, '
      '  EMAIL = :NEW_EMAIL'
      'WHERE CODUSUARIO = :OLD_CODUSUARIO')
    DeleteSQL.Strings = (
      'DELETE FROM USUARIOS'
      'WHERE CODUSUARIO = :OLD_CODUSUARIO')
    FetchRowSQL.Strings = (
      
        'SELECT CODUSUARIO, LOGIN, SENHA, NOME, TIPO, PERFIL, CODCIDADE, ' +
        'HOSTSMTP, '
      '  USUARIOCONTA, SENHACONTA, AUTENTICA, EMAIL'
      'FROM USUARIOS'
      'WHERE CODUSUARIO = :CODUSUARIO')
    Left = 336
    Top = 168
  end
  object Menus: TFDQuery
    Connection = DataBase
    SQL.Strings = (
      'SELECT DISTINCT Programas.NomePrograma, Programas.Menu,'
      '    Programas.Item, Programas.SubItem'
      'FROM ProgramasUsuario INNER JOIN'
      '    Programas ON'
      '    ProgramasUsuario.CodPrograma = Programas.CodPrograma'
      'INNER JOIN Usuarios ON'
      '   ProgramasUsuario.CodUsuario = Usuarios.CodUsuario'
      'WHERE (Usuarios.Login = :Usuario) OR'
      '    (Usuarios.Login = :Perfil)'
      'ORDER BY Programas.Menu, Programas.Item, Programas.SubItem')
    Left = 144
    Top = 16
    ParamData = <
      item
        Name = 'USUARIO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PERFIL'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 32
    Top = 128
  end
  object Consulta: TFDQuery
    Connection = DataBase
    Left = 216
    Top = 16
  end
  object SQLPU: TFDQuery
    Connection = DataBase
    SQL.Strings = (
      'select * from programasusuario'
      'where codusuario=:codusuario and codprograma=:codprograma')
    Left = 456
    Top = 120
    ParamData = <
      item
        Name = 'CODUSUARIO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'CODPROGRAMA'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FDSUsuarios_Programas: TDataSource
    DataSet = SQLUsuarios
    Left = 400
    Top = 120
  end
  object Setup: TFDQuery
    CachedUpdates = True
    Connection = DataBase
    UpdateObject = UPSetup
    SQL.Strings = (
      'select * from setup Where Cont=:Cont')
    Left = 272
    Top = 16
    ParamData = <
      item
        Name = 'CONT'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object UPSetup: TFDUpdateSQL
    Connection = DataBase
    Left = 336
    Top = 16
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 32
    Top = 88
  end
  object SqlCidades: TFDQuery
    CachedUpdates = True
    Connection = DataBase
    UpdateObject = UPCidades
    SQL.Strings = (
      'select * from cidades'
      'where codcidade=:codcidade')
    Left = 160
    Top = 112
    ParamData = <
      item
        Name = 'CODCIDADE'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object SqlCidadesCODCIDADE: TIntegerField
      FieldName = 'CODCIDADE'
      Origin = 'CODCIDADE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SqlCidadesCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 70
    end
    object SqlCidadesESTADO: TStringField
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      Size = 2
    end
  end
  object UPCidades: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO CIDADES'
      '(CODCIDADE, CIDADE, ESTADO)'
      'VALUES (:NEW_CODCIDADE, :NEW_CIDADE, :NEW_ESTADO)')
    ModifySQL.Strings = (
      'UPDATE CIDADES'
      
        'SET CODCIDADE = :NEW_CODCIDADE, CIDADE = :NEW_CIDADE, ESTADO = :' +
        'NEW_ESTADO'
      'WHERE CODCIDADE = :OLD_CODCIDADE')
    DeleteSQL.Strings = (
      'DELETE FROM CIDADES'
      'WHERE CODCIDADE = :OLD_CODCIDADE')
    FetchRowSQL.Strings = (
      'SELECT CODCIDADE, CIDADE, ESTADO'
      'FROM CIDADES'
      'WHERE CODCIDADE = :CODCIDADE')
    Left = 192
    Top = 112
  end
  object FDUpdateSQL4: TFDUpdateSQL
    Connection = DataBase
    Left = 496
    Top = 24
  end
  object FDQuery4: TFDQuery
    Connection = DataBase
    Left = 448
    Top = 24
  end
  object UPGrupos: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO GRUPOS'
      '(CODGRUPO, DESGRUPO)'
      'VALUES (:NEW_CODGRUPO, :NEW_DESGRUPO)')
    ModifySQL.Strings = (
      'UPDATE GRUPOS'
      'SET CODGRUPO = :NEW_CODGRUPO, DESGRUPO = :NEW_DESGRUPO'
      'WHERE CODGRUPO = :OLD_CODGRUPO')
    DeleteSQL.Strings = (
      'DELETE FROM GRUPOS'
      'WHERE CODGRUPO = :OLD_CODGRUPO')
    FetchRowSQL.Strings = (
      'SELECT CODGRUPO, DESGRUPO'
      'FROM GRUPOS'
      'WHERE CODGRUPO = :CODGRUPO')
    Left = 88
    Top = 256
  end
  object SQLGrupos: TFDQuery
    CachedUpdates = True
    Connection = DataBase
    UpdateObject = UPGrupos
    SQL.Strings = (
      'Select * from Grupos'
      'where codgrupo =:codgrupo')
    Left = 40
    Top = 256
    ParamData = <
      item
        Name = 'CODGRUPO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object SQLGruposCODGRUPO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODGRUPO'
      Origin = 'CODGRUPO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLGruposDESGRUPO: TStringField
      DisplayLabel = 'Descri'#231#227'o do Grupo'
      FieldName = 'DESGRUPO'
      Origin = 'DESGRUPO'
      Size = 30
    end
  end
  object UPProdutos: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO PRODUTOS'
      '(CODPRO, DESPRO, CODGRUPO, INATIVO, CODBARRA, '
      '  PRCOMPRA, PRLUCRO, PRVENDA, ULTCOMPRA, '
      '  ULTVENDA, CADASTRO, CONTROLALOTE)'
      
        'VALUES (:NEW_CODPRO, :NEW_DESPRO, :NEW_CODGRUPO, :NEW_INATIVO, :' +
        'NEW_CODBARRA, '
      '  :NEW_PRCOMPRA, :NEW_PRLUCRO, :NEW_PRVENDA, :NEW_ULTCOMPRA, '
      '  :NEW_ULTVENDA, :NEW_CADASTRO, :NEW_CONTROLALOTE)')
    ModifySQL.Strings = (
      'UPDATE PRODUTOS'
      
        'SET CODPRO = :NEW_CODPRO, DESPRO = :NEW_DESPRO, CODGRUPO = :NEW_' +
        'CODGRUPO, '
      
        '  INATIVO = :NEW_INATIVO, CODBARRA = :NEW_CODBARRA, PRCOMPRA = :' +
        'NEW_PRCOMPRA, '
      
        '  PRLUCRO = :NEW_PRLUCRO, PRVENDA = :NEW_PRVENDA, ULTCOMPRA = :N' +
        'EW_ULTCOMPRA, '
      
        '  ULTVENDA = :NEW_ULTVENDA, CADASTRO = :NEW_CADASTRO, CONTROLALO' +
        'TE = :NEW_CONTROLALOTE'
      'WHERE CODPRO = :OLD_CODPRO')
    DeleteSQL.Strings = (
      'DELETE FROM PRODUTOS'
      'WHERE CODPRO = :OLD_CODPRO')
    FetchRowSQL.Strings = (
      
        'SELECT CODPRO, DESPRO, CODGRUPO, INATIVO, CODBARRA, PRCOMPRA, PR' +
        'LUCRO, '
      '  PRVENDA, ULTCOMPRA, ULTVENDA, CADASTRO, CONTROLALOTE'
      'FROM PRODUTOS'
      'WHERE CODPRO = :CODPRO')
    Left = 88
    Top = 312
  end
  object SQLProdutos: TFDQuery
    OnNewRecord = SQLProdutosNewRecord
    CachedUpdates = True
    Connection = DataBase
    UpdateObject = UPProdutos
    SQL.Strings = (
      'Select p.*, g.desgrupo from produtos p '
      'left outer join grupos g on g.codgrupo=p.codgrupo'
      'where p.codpro =:codpro')
    Left = 40
    Top = 312
    ParamData = <
      item
        Name = 'CODPRO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object SQLProdutosCODPRO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODPRO'
      Origin = 'CODPRO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLProdutosDESPRO: TStringField
      DisplayLabel = 'Descri'#231#227'o Produto'
      FieldName = 'DESPRO'
      Origin = 'DESPRO'
      Size = 40
    end
    object SQLProdutosCODGRUPO: TIntegerField
      DisplayLabel = 'Grupo'
      FieldName = 'CODGRUPO'
      Origin = 'CODGRUPO'
    end
    object SQLProdutosINATIVO: TStringField
      DisplayLabel = 'Inativo'
      FieldName = 'INATIVO'
      Origin = 'INATIVO'
      FixedChar = True
      Size = 1
    end
    object SQLProdutosCODBARRA: TStringField
      DisplayLabel = 'C'#243'digo Barras'
      FieldName = 'CODBARRA'
      Origin = 'CODBARRA'
      Size = 13
    end
    object SQLProdutosPRCOMPRA: TBCDField
      DisplayLabel = 'Pr.Compra'
      FieldName = 'PRCOMPRA'
      Origin = 'PRCOMPRA'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLProdutosPRLUCRO: TBCDField
      DisplayLabel = '% Lucro'
      FieldName = 'PRLUCRO'
      Origin = 'PRLUCRO'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLProdutosPRVENDA: TBCDField
      DisplayLabel = 'Pr.Venda'
      FieldName = 'PRVENDA'
      Origin = 'PRVENDA'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLProdutosULTCOMPRA: TDateField
      DisplayLabel = 'Ult. Compra'
      FieldName = 'ULTCOMPRA'
      Origin = 'ULTCOMPRA'
    end
    object SQLProdutosULTVENDA: TDateField
      DisplayLabel = 'Ult. Venda'
      FieldName = 'ULTVENDA'
      Origin = 'ULTVENDA'
    end
    object SQLProdutosCADASTRO: TDateField
      DisplayLabel = 'Cadastro'
      FieldName = 'CADASTRO'
      Origin = 'CADASTRO'
    end
    object SQLProdutosDESGRUPO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESGRUPO'
      Origin = 'DESGRUPO'
      ProviderFlags = []
      Size = 30
    end
    object SQLProdutosCONTROLALOTE: TStringField
      FieldName = 'CONTROLALOTE'
      Origin = 'CONTROLALOTE'
      FixedChar = True
      Size = 1
    end
  end
  object UPFornecedores: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO FORNECEDORES'
      '(CODFOR, DATACAD, CNPJFOR, INSESTFOR, NOMFOR, '
      '  FANTASIAFOR, ENDFOR, NUMFOR, COMPFOR, '
      '  BAIFOR, CEPFOR, CODCIDFOR, FONEFOR, '
      '  CELFOR, CONTATOFOR)'
      
        'VALUES (:NEW_CODFOR, :NEW_DATACAD, :NEW_CNPJFOR, :NEW_INSESTFOR,' +
        ' :NEW_NOMFOR, '
      '  :NEW_FANTASIAFOR, :NEW_ENDFOR, :NEW_NUMFOR, :NEW_COMPFOR, '
      '  :NEW_BAIFOR, :NEW_CEPFOR, :NEW_CODCIDFOR, :NEW_FONEFOR, '
      '  :NEW_CELFOR, :NEW_CONTATOFOR)')
    ModifySQL.Strings = (
      'UPDATE FORNECEDORES'
      
        'SET CODFOR = :NEW_CODFOR, DATACAD = :NEW_DATACAD, CNPJFOR = :NEW' +
        '_CNPJFOR, '
      
        '  INSESTFOR = :NEW_INSESTFOR, NOMFOR = :NEW_NOMFOR, FANTASIAFOR ' +
        '= :NEW_FANTASIAFOR, '
      
        '  ENDFOR = :NEW_ENDFOR, NUMFOR = :NEW_NUMFOR, COMPFOR = :NEW_COM' +
        'PFOR, '
      
        '  BAIFOR = :NEW_BAIFOR, CEPFOR = :NEW_CEPFOR, CODCIDFOR = :NEW_C' +
        'ODCIDFOR, '
      
        '  FONEFOR = :NEW_FONEFOR, CELFOR = :NEW_CELFOR, CONTATOFOR = :NE' +
        'W_CONTATOFOR'
      'WHERE CODFOR = :OLD_CODFOR')
    DeleteSQL.Strings = (
      'DELETE FROM FORNECEDORES'
      'WHERE CODFOR = :OLD_CODFOR')
    FetchRowSQL.Strings = (
      
        'SELECT CODFOR, DATACAD, CNPJFOR, INSESTFOR, NOMFOR, FANTASIAFOR,' +
        ' ENDFOR, '
      '  NUMFOR, COMPFOR, BAIFOR, CEPFOR, CODCIDFOR, FONEFOR, CELFOR, '
      '  CONTATOFOR'
      'FROM FORNECEDORES'
      'WHERE CODFOR = :CODFOR')
    Left = 88
    Top = 368
  end
  object SQLFornecedores: TFDQuery
    CachedUpdates = True
    Connection = DataBase
    UpdateObject = UPFornecedores
    SQL.Strings = (
      'select f.*, cid.cidade, cid.estado '
      'from fornecedores f '
      'left outer join cidades cid on cid.codcidade=f.codcidfor'
      'where f.codfor =:codfor')
    Left = 40
    Top = 368
    ParamData = <
      item
        Name = 'CODFOR'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object SQLFornecedoresCODFOR: TIntegerField
      FieldName = 'CODFOR'
      Origin = 'CODFOR'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLFornecedoresDATACAD: TDateField
      FieldName = 'DATACAD'
      Origin = 'DATACAD'
    end
    object SQLFornecedoresCNPJFOR: TStringField
      FieldName = 'CNPJFOR'
      Origin = 'CNPJFOR'
    end
    object SQLFornecedoresINSESTFOR: TStringField
      FieldName = 'INSESTFOR'
      Origin = 'INSESTFOR'
    end
    object SQLFornecedoresNOMFOR: TStringField
      FieldName = 'NOMFOR'
      Origin = 'NOMFOR'
      Size = 50
    end
    object SQLFornecedoresFANTASIAFOR: TStringField
      FieldName = 'FANTASIAFOR'
      Origin = 'FANTASIAFOR'
      Size = 50
    end
    object SQLFornecedoresENDFOR: TStringField
      FieldName = 'ENDFOR'
      Origin = 'ENDFOR'
      Size = 50
    end
    object SQLFornecedoresNUMFOR: TStringField
      FieldName = 'NUMFOR'
      Origin = 'NUMFOR'
      Size = 10
    end
    object SQLFornecedoresCOMPFOR: TStringField
      FieldName = 'COMPFOR'
      Origin = 'COMPFOR'
    end
    object SQLFornecedoresBAIFOR: TStringField
      FieldName = 'BAIFOR'
      Origin = 'BAIFOR'
      Size = 30
    end
    object SQLFornecedoresCEPFOR: TStringField
      FieldName = 'CEPFOR'
      Origin = 'CEPFOR'
      Size = 10
    end
    object SQLFornecedoresCODCIDFOR: TIntegerField
      FieldName = 'CODCIDFOR'
      Origin = 'CODCIDFOR'
    end
    object SQLFornecedoresFONEFOR: TStringField
      FieldName = 'FONEFOR'
      Origin = 'FONEFOR'
      Size = 30
    end
    object SQLFornecedoresCELFOR: TStringField
      FieldName = 'CELFOR'
      Origin = 'CELFOR'
      Size = 30
    end
    object SQLFornecedoresCONTATOFOR: TStringField
      FieldName = 'CONTATOFOR'
      Origin = 'CONTATOFOR'
      Size = 30
    end
    object SQLFornecedoresCIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      ProviderFlags = []
      Size = 60
    end
    object SQLFornecedoresESTADO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      ProviderFlags = []
      Size = 2
    end
  end
  object UPClientes: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO CLIENTES'
      '(CODCLI, NOMCLI, CPF, RG, ENDCLI, BAICLI, '
      '  CEPCLI, CODCIDCLI, FONCLI, CELCLI, EMAIL, '
      '  INATIVO, DATACAD, OBS)'
      
        'VALUES (:NEW_CODCLI, :NEW_NOMCLI, :NEW_CPF, :NEW_RG, :NEW_ENDCLI' +
        ', :NEW_BAICLI, '
      
        '  :NEW_CEPCLI, :NEW_CODCIDCLI, :NEW_FONCLI, :NEW_CELCLI, :NEW_EM' +
        'AIL, '
      '  :NEW_INATIVO, :NEW_DATACAD, :NEW_OBS)')
    ModifySQL.Strings = (
      'UPDATE CLIENTES'
      'SET CODCLI = :NEW_CODCLI, NOMCLI = :NEW_NOMCLI, CPF = :NEW_CPF, '
      '  RG = :NEW_RG, ENDCLI = :NEW_ENDCLI, BAICLI = :NEW_BAICLI, '
      
        '  CEPCLI = :NEW_CEPCLI, CODCIDCLI = :NEW_CODCIDCLI, FONCLI = :NE' +
        'W_FONCLI, '
      
        '  CELCLI = :NEW_CELCLI, EMAIL = :NEW_EMAIL, INATIVO = :NEW_INATI' +
        'VO, '
      '  DATACAD = :NEW_DATACAD, OBS = :NEW_OBS'
      'WHERE CODCLI = :OLD_CODCLI')
    DeleteSQL.Strings = (
      'DELETE FROM CLIENTES'
      'WHERE CODCLI = :OLD_CODCLI')
    FetchRowSQL.Strings = (
      
        'SELECT CODCLI, NOMCLI, CPF, RG, ENDCLI, BAICLI, CEPCLI, CODCIDCL' +
        'I, '
      '  FONCLI, CELCLI, EMAIL, INATIVO, DATACAD, OBS'
      'FROM CLIENTES'
      'WHERE CODCLI = :CODCLI')
    Left = 88
    Top = 424
  end
  object SQLClientes: TFDQuery
    CachedUpdates = True
    Connection = DataBase
    UpdateObject = UPClientes
    SQL.Strings = (
      'Select C.*, cid.cidade, cid.Estado'
      'from Clientes C '
      'LEFT OUTER JOIN Cidades cid ON C.CodCidCli=cid.CodCidade'
      'where CodCli =:CodCli')
    Left = 40
    Top = 424
    ParamData = <
      item
        Name = 'CODCLI'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object SQLClientesCODCLI: TIntegerField
      FieldName = 'CODCLI'
      Origin = 'CODCLI'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLClientesNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Origin = 'NOMCLI'
      Size = 50
    end
    object SQLClientesCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
    end
    object SQLClientesRG: TStringField
      FieldName = 'RG'
      Origin = 'RG'
    end
    object SQLClientesENDCLI: TStringField
      FieldName = 'ENDCLI'
      Origin = 'ENDCLI'
      Size = 50
    end
    object SQLClientesNUMCLI: TStringField
      FieldName = 'NUMCLI'
      Origin = 'NUMCLI'
      Size = 10
    end
    object SQLClientesBAICLI: TStringField
      FieldName = 'BAICLI'
      Origin = 'BAICLI'
      Size = 30
    end
    object SQLClientesCEPCLI: TStringField
      FieldName = 'CEPCLI'
      Origin = 'CEPCLI'
      Size = 10
    end
    object SQLClientesCODCIDCLI: TIntegerField
      FieldName = 'CODCIDCLI'
      Origin = 'CODCIDCLI'
    end
    object SQLClientesFONCLI: TStringField
      FieldName = 'FONCLI'
      Origin = 'FONCLI'
    end
    object SQLClientesCELCLI: TStringField
      FieldName = 'CELCLI'
      Origin = 'CELCLI'
    end
    object SQLClientesEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 150
    end
    object SQLClientesINATIVO: TStringField
      FieldName = 'INATIVO'
      Origin = 'INATIVO'
      FixedChar = True
      Size = 1
    end
    object SQLClientesDATACAD: TDateField
      FieldName = 'DATACAD'
      Origin = 'DATACAD'
    end
    object SQLClientesOBS: TBlobField
      FieldName = 'OBS'
      Origin = 'OBS'
    end
    object SQLClientesCIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      ProviderFlags = []
      Size = 60
    end
    object SQLClientesESTADO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      ProviderFlags = []
      Size = 2
    end
  end
  object UPEntradas: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO ENTRADAS'
      '(CODENTRADA, DATACAD, NRONOTA, NROCHAVE, '
      '  DATANOTA, CODFOR, TOTALNOTA, TOTALPRODUTO, '
      '  TIPOENTRADA, OBS, BAIXA, DATABAIXA)'
      
        'VALUES (:NEW_CODENTRADA, :NEW_DATACAD, :NEW_NRONOTA, :NEW_NROCHA' +
        'VE, '
      
        '  :NEW_DATANOTA, :NEW_CODFOR, :NEW_TOTALNOTA, :NEW_TOTALPRODUTO,' +
        ' '
      '  :NEW_TIPOENTRADA, :NEW_OBS, :NEW_BAIXA, :NEW_DATABAIXA)')
    ModifySQL.Strings = (
      'UPDATE ENTRADAS'
      
        'SET CODENTRADA = :NEW_CODENTRADA, DATACAD = :NEW_DATACAD, NRONOT' +
        'A = :NEW_NRONOTA, '
      
        '  NROCHAVE = :NEW_NROCHAVE, DATANOTA = :NEW_DATANOTA, CODFOR = :' +
        'NEW_CODFOR, '
      '  TOTALNOTA = :NEW_TOTALNOTA, TOTALPRODUTO = :NEW_TOTALPRODUTO, '
      
        '  TIPOENTRADA = :NEW_TIPOENTRADA, OBS = :NEW_OBS, BAIXA = :NEW_B' +
        'AIXA, '
      '  DATABAIXA = :NEW_DATABAIXA'
      'WHERE CODENTRADA = :OLD_CODENTRADA')
    DeleteSQL.Strings = (
      'DELETE FROM ENTRADAS'
      'WHERE CODENTRADA = :OLD_CODENTRADA')
    FetchRowSQL.Strings = (
      
        'SELECT CODENTRADA, DATACAD, NRONOTA, NROCHAVE, DATANOTA, CODFOR,' +
        ' TOTALNOTA, '
      '  TOTALPRODUTO, TIPOENTRADA, OBS, BAIXA, DATABAIXA'
      'FROM ENTRADAS'
      'WHERE CODENTRADA = :CODENTRADA')
    Left = 88
    Top = 480
  end
  object SQLEntradas: TFDQuery
    OnNewRecord = SQLEntradasNewRecord
    CachedUpdates = True
    Connection = DataBase
    UpdateObject = UPEntradas
    SQL.Strings = (
      
        'Select e.*, f.nomfor, f.cnpjfor from entradas e left outer join ' +
        'fornecedores f '
      'on f.codfor=e.codfor'
      'where e.codentrada =:codentrada')
    Left = 40
    Top = 480
    ParamData = <
      item
        Name = 'CODENTRADA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object SQLEntradasCODENTRADA: TIntegerField
      FieldName = 'CODENTRADA'
      Origin = 'CODENTRADA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLEntradasDATACAD: TDateField
      FieldName = 'DATACAD'
      Origin = 'DATACAD'
    end
    object SQLEntradasNRONOTA: TStringField
      FieldName = 'NRONOTA'
      Origin = 'NRONOTA'
    end
    object SQLEntradasNROCHAVE: TStringField
      FieldName = 'NROCHAVE'
      Origin = 'NROCHAVE'
      Size = 100
    end
    object SQLEntradasDATANOTA: TDateField
      FieldName = 'DATANOTA'
      Origin = 'DATANOTA'
    end
    object SQLEntradasCODFOR: TIntegerField
      FieldName = 'CODFOR'
      Origin = 'CODFOR'
    end
    object SQLEntradasTOTALNOTA: TBCDField
      FieldName = 'TOTALNOTA'
      Origin = 'TOTALNOTA'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLEntradasTOTALPRODUTO: TBCDField
      FieldName = 'TOTALPRODUTO'
      Origin = 'TOTALPRODUTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLEntradasTIPOENTRADA: TStringField
      FieldName = 'TIPOENTRADA'
      Origin = 'TIPOENTRADA'
      Size = 2
    end
    object SQLEntradasOBS: TMemoField
      FieldName = 'OBS'
      Origin = 'OBS'
      BlobType = ftMemo
    end
    object SQLEntradasBAIXA: TStringField
      FieldName = 'BAIXA'
      Origin = 'BAIXA'
      FixedChar = True
      Size = 1
    end
    object SQLEntradasDATABAIXA: TDateField
      FieldName = 'DATABAIXA'
      Origin = 'DATABAIXA'
    end
    object SQLEntradasNOMFOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOMFOR'
      Origin = 'NOMFOR'
      ProviderFlags = []
      Size = 50
    end
    object SQLEntradasCNPJFOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CNPJFOR'
      Origin = 'CNPJFOR'
      ProviderFlags = []
    end
  end
  object UPItensEntradas: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO ENTRADASITENS'
      '(CODENTRADA, SEQ, CODPRO, QDE, VALOR, '
      '  TOTAL, PRCOMPRA, PERLUCRO, PRVENDA, '
      '  CODEAN, NUMEROLOTE, DATAVENCIMENTO, MOTIVOPERDA)'
      
        'VALUES (:NEW_CODENTRADA, :NEW_SEQ, :NEW_CODPRO, :NEW_QDE, :NEW_V' +
        'ALOR, '
      '  :NEW_TOTAL, :NEW_PRCOMPRA, :NEW_PERLUCRO, :NEW_PRVENDA, '
      
        '  :NEW_CODEAN, :NEW_NUMEROLOTE, :NEW_DATAVENCIMENTO, :NEW_MOTIVO' +
        'PERDA)')
    ModifySQL.Strings = (
      'UPDATE ENTRADASITENS'
      
        'SET CODENTRADA = :NEW_CODENTRADA, SEQ = :NEW_SEQ, CODPRO = :NEW_' +
        'CODPRO, '
      '  QDE = :NEW_QDE, VALOR = :NEW_VALOR, TOTAL = :NEW_TOTAL, '
      
        '  PRCOMPRA = :NEW_PRCOMPRA, PERLUCRO = :NEW_PERLUCRO, PRVENDA = ' +
        ':NEW_PRVENDA, '
      
        '  CODEAN = :NEW_CODEAN, NUMEROLOTE = :NEW_NUMEROLOTE, DATAVENCIM' +
        'ENTO = :NEW_DATAVENCIMENTO, '
      '  MOTIVOPERDA = :NEW_MOTIVOPERDA'
      'WHERE CODENTRADA = :OLD_CODENTRADA AND SEQ = :OLD_SEQ')
    DeleteSQL.Strings = (
      'DELETE FROM ENTRADASITENS'
      'WHERE CODENTRADA = :OLD_CODENTRADA AND SEQ = :OLD_SEQ')
    FetchRowSQL.Strings = (
      
        'SELECT CODENTRADA, SEQ, CODPRO, QDE, VALOR, TOTAL, PRCOMPRA, PER' +
        'LUCRO, '
      '  PRVENDA, CODEAN, NUMEROLOTE, DATAVENCIMENTO, MOTIVOPERDA'
      'FROM ENTRADASITENS'
      'WHERE CODENTRADA = :CODENTRADA AND SEQ = :SEQ')
    Left = 88
    Top = 536
  end
  object SQLItensEntradas: TFDQuery
    OnNewRecord = SQLItensEntradasNewRecord
    CachedUpdates = True
    MasterSource = DSEntradas_ItensEntradas
    MasterFields = 'CODENTRADA'
    DetailFields = 'CODENTRADA'
    Connection = DataBase
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateObject = UPItensEntradas
    SQL.Strings = (
      
        'Select i.*, pr.despro, pr.prcompra as prcomprashow , pr.controla' +
        'lote'
      'from EntradasItens i '
      'left outer join produtos pr on pr.codpro=i.codpro'
      'where i.codentrada =:codentrada'
      'order by seq')
    Left = 40
    Top = 536
    ParamData = <
      item
        Name = 'CODENTRADA'
        DataType = ftInteger
        ParamType = ptInput
        Size = 4
        Value = Null
      end>
    object SQLItensEntradasCODENTRADA: TIntegerField
      FieldName = 'CODENTRADA'
      Origin = 'CODENTRADA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLItensEntradasSEQ: TIntegerField
      FieldName = 'SEQ'
      Origin = 'SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object SQLItensEntradasCODPRO: TIntegerField
      FieldName = 'CODPRO'
      Origin = 'CODPRO'
    end
    object SQLItensEntradasQDE: TBCDField
      FieldName = 'QDE'
      Origin = 'QDE'
      Precision = 18
      Size = 2
    end
    object SQLItensEntradasVALOR: TBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLItensEntradasTOTAL: TBCDField
      FieldName = 'TOTAL'
      Origin = 'TOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLItensEntradasPRCOMPRA: TBCDField
      FieldName = 'PRCOMPRA'
      Origin = 'PRCOMPRA'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLItensEntradasPERLUCRO: TBCDField
      FieldName = 'PERLUCRO'
      Origin = 'PERLUCRO'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLItensEntradasPRVENDA: TBCDField
      FieldName = 'PRVENDA'
      Origin = 'PRVENDA'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLItensEntradasCODEAN: TStringField
      FieldName = 'CODEAN'
      Origin = 'CODEAN'
      Size = 13
    end
    object SQLItensEntradasNUMEROLOTE: TStringField
      FieldName = 'NUMEROLOTE'
      Origin = 'NUMEROLOTE'
    end
    object SQLItensEntradasDATAVENCIMENTO: TDateField
      FieldName = 'DATAVENCIMENTO'
      Origin = 'DATAVENCIMENTO'
    end
    object SQLItensEntradasMOTIVOPERDA: TStringField
      FieldName = 'MOTIVOPERDA'
      Origin = 'MOTIVOPERDA'
      FixedChar = True
      Size = 1
    end
    object SQLItensEntradasDESPRO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESPRO'
      Origin = 'DESPRO'
      ProviderFlags = []
      Size = 40
    end
    object SQLItensEntradasPRCOMPRASHOW: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'PRCOMPRASHOW'
      Origin = 'PRCOMPRA'
      ProviderFlags = []
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLItensEntradasCONTROLALOTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CONTROLALOTE'
      Origin = 'CONTROLALOTE'
      ProviderFlags = []
      FixedChar = True
      Size = 1
    end
  end
  object DSEntradas_ItensEntradas: TDataSource
    DataSet = SQLEntradas
    Left = 144
    Top = 536
  end
  object SQLEstoqueLote: TFDQuery
    Connection = DataBase
    SQL.Strings = (
      
        'select p.despro, s.* from saldoestoque s left outer join produto' +
        's p on p.codpro=s.codpro'
      'where s.estoque > 0 and s.codpro =:codpro')
    Left = 40
    Top = 208
    ParamData = <
      item
        Name = 'CODPRO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object SQLEstoqueLoteDESPRO: TStringField
      FieldName = 'DESPRO'
      Origin = 'DESPRO'
      Size = 40
    end
    object SQLEstoqueLoteCODPRO: TIntegerField
      FieldName = 'CODPRO'
      Origin = 'CODPRO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLEstoqueLoteNUMEROLOTE: TStringField
      FieldName = 'NUMEROLOTE'
      Origin = 'NUMEROLOTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLEstoqueLoteDATAVENCIMENTO: TDateField
      FieldName = 'DATAVENCIMENTO'
      Origin = 'DATAVENCIMENTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLEstoqueLoteESTOQUE: TBCDField
      FieldName = 'ESTOQUE'
      Origin = 'ESTOQUE'
      Precision = 18
      Size = 2
    end
  end
  object UPPedidos: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO PEDIDOS'
      '(CODPEDIDO, CODCLI, NOME, "DATA", TOTAL, '
      '  ABATIMENTO, TOTPRO, DINHEIRO, CARTAO, '
      '  CODCARTAO, VALE, CODVALE, DATAVALE, '
      '  TROCO, DESCONTO)'
      
        'VALUES (:NEW_CODPEDIDO, :NEW_CODCLI, :NEW_NOME, :NEW_DATA, :NEW_' +
        'TOTAL, '
      '  :NEW_ABATIMENTO, :NEW_TOTPRO, :NEW_DINHEIRO, :NEW_CARTAO, '
      '  :NEW_CODCARTAO, :NEW_VALE, :NEW_CODVALE, :NEW_DATAVALE, '
      '  :NEW_TROCO, :NEW_DESCONTO)')
    ModifySQL.Strings = (
      'UPDATE PEDIDOS'
      
        'SET CODPEDIDO = :NEW_CODPEDIDO, CODCLI = :NEW_CODCLI, NOME = :NE' +
        'W_NOME, '
      
        '  "DATA" = :NEW_DATA, TOTAL = :NEW_TOTAL, ABATIMENTO = :NEW_ABAT' +
        'IMENTO, '
      
        '  TOTPRO = :NEW_TOTPRO, DINHEIRO = :NEW_DINHEIRO, CARTAO = :NEW_' +
        'CARTAO, '
      
        '  CODCARTAO = :NEW_CODCARTAO, VALE = :NEW_VALE, CODVALE = :NEW_C' +
        'ODVALE, '
      
        '  DATAVALE = :NEW_DATAVALE, TROCO = :NEW_TROCO, DESCONTO = :NEW_' +
        'DESCONTO'
      'WHERE CODPEDIDO = :OLD_CODPEDIDO')
    DeleteSQL.Strings = (
      'DELETE FROM PEDIDOS'
      'WHERE CODPEDIDO = :OLD_CODPEDIDO')
    FetchRowSQL.Strings = (
      
        'SELECT CODPEDIDO, CODCLI, NOME, "DATA" AS "DATA", TOTAL, ABATIME' +
        'NTO, '
      '  TOTPRO, DINHEIRO, CARTAO, CODCARTAO, VALE, CODVALE, DATAVALE, '
      '  TROCO, DESCONTO'
      'FROM PEDIDOS'
      'WHERE CODPEDIDO = :CODPEDIDO')
    Left = 352
    Top = 232
  end
  object SQLPedidos: TFDQuery
    OnCalcFields = SQLPedidosCalcFields
    OnNewRecord = SQLPedidosNewRecord
    CachedUpdates = True
    Connection = DataBase
    UpdateObject = UPPedidos
    SQL.Strings = (
      'select p.*, car.descartao '
      'from Pedidos p'
      'left outer join cartaocredito car on car.codcartao=p.codcartao '
      'where codpedido=:codpedido')
    Left = 304
    Top = 232
    ParamData = <
      item
        Name = 'CODPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object SQLPedidosCODPEDIDO: TIntegerField
      FieldName = 'CODPEDIDO'
      Origin = 'CODPEDIDO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLPedidosCODCLI: TIntegerField
      FieldName = 'CODCLI'
      Origin = 'CODCLI'
    end
    object SQLPedidosNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object SQLPedidosDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object SQLPedidosTOTAL: TBCDField
      FieldName = 'TOTAL'
      Origin = 'TOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLPedidosABATIMENTO: TBCDField
      FieldName = 'ABATIMENTO'
      Origin = 'ABATIMENTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLPedidosTOTPRO: TBCDField
      FieldName = 'TOTPRO'
      Origin = 'TOTPRO'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLPedidosDINHEIRO: TBCDField
      FieldName = 'DINHEIRO'
      Origin = 'DINHEIRO'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLPedidosCARTAO: TBCDField
      FieldName = 'CARTAO'
      Origin = 'CARTAO'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLPedidosCODCARTAO: TIntegerField
      FieldName = 'CODCARTAO'
      Origin = 'CODCARTAO'
    end
    object SQLPedidosVALE: TBCDField
      FieldName = 'VALE'
      Origin = 'VALE'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLPedidosCODVALE: TIntegerField
      FieldName = 'CODVALE'
      Origin = 'CODVALE'
    end
    object SQLPedidosDATAVALE: TDateField
      FieldName = 'DATAVALE'
      Origin = 'DATAVALE'
    end
    object SQLPedidosTROCO: TBCDField
      FieldName = 'TROCO'
      Origin = 'TROCO'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLPedidosDESCONTO: TBCDField
      FieldName = 'DESCONTO'
      Origin = 'DESCONTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLPedidosDESCARTAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCARTAO'
      Origin = 'DESCARTAO'
      ProviderFlags = []
    end
    object SQLPedidosVALRESTANTE: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'VALRESTANTE'
      Calculated = True
    end
  end
  object UPItensPedidos: TFDUpdateSQL
    Connection = DataBase
    InsertSQL.Strings = (
      'INSERT INTO PEDIDOSITENS'
      '(CODPEDIDO, SEQ, CODPRO, CODEAN, PRVENDA, '
      '  PRCOMPRA, QUANTIDADE, PRTOTAL, PORCDESC, '
      '  DESCONTO, NUMEROLOTE, DATAVENCIMENTO)'
      
        'VALUES (:NEW_CODPEDIDO, :NEW_SEQ, :NEW_CODPRO, :NEW_CODEAN, :NEW' +
        '_PRVENDA, '
      '  :NEW_PRCOMPRA, :NEW_QUANTIDADE, :NEW_PRTOTAL, :NEW_PORCDESC, '
      '  :NEW_DESCONTO, :NEW_NUMEROLOTE, :NEW_DATAVENCIMENTO)')
    ModifySQL.Strings = (
      'UPDATE PEDIDOSITENS'
      
        'SET CODPEDIDO = :NEW_CODPEDIDO, SEQ = :NEW_SEQ, CODPRO = :NEW_CO' +
        'DPRO, '
      
        '  CODEAN = :NEW_CODEAN, PRVENDA = :NEW_PRVENDA, PRCOMPRA = :NEW_' +
        'PRCOMPRA, '
      
        '  QUANTIDADE = :NEW_QUANTIDADE, PRTOTAL = :NEW_PRTOTAL, PORCDESC' +
        ' = :NEW_PORCDESC, '
      '  DESCONTO = :NEW_DESCONTO, NUMEROLOTE = :NEW_NUMEROLOTE, '
      '  DATAVENCIMENTO = :NEW_DATAVENCIMENTO'
      'WHERE CODPEDIDO = :OLD_CODPEDIDO AND SEQ = :OLD_SEQ')
    DeleteSQL.Strings = (
      'DELETE FROM PEDIDOSITENS'
      'WHERE CODPEDIDO = :OLD_CODPEDIDO AND SEQ = :OLD_SEQ')
    FetchRowSQL.Strings = (
      
        'SELECT CODPEDIDO, SEQ, CODPRO, CODEAN, PRVENDA, PRCOMPRA, QUANTI' +
        'DADE, '
      '  PRTOTAL, PORCDESC, DESCONTO, NUMEROLOTE, DATAVENCIMENTO'
      'FROM PEDIDOSITENS'
      'WHERE CODPEDIDO = :CODPEDIDO AND SEQ = :SEQ')
    Left = 352
    Top = 288
  end
  object SQLItensPedidos: TFDQuery
    OnNewRecord = SQLItensPedidosNewRecord
    CachedUpdates = True
    MasterSource = DSPedidos_ItensPedidos
    MasterFields = 'CODPEDIDO'
    DetailFields = 'CODPEDIDO'
    Connection = DataBase
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateObject = UPItensPedidos
    SQL.Strings = (
      'select i.*, pro.despro, pro.controlalote'
      'from pedidositens i '
      'left outer join produtos pro on i.codpro=pro.codpro'
      'where i.codpedido=:codpedido '
      'order by i.seq')
    Left = 304
    Top = 288
    ParamData = <
      item
        Name = 'CODPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Size = 4
        Value = Null
      end>
    object SQLItensPedidosCODPEDIDO: TIntegerField
      FieldName = 'CODPEDIDO'
      Origin = 'CODPEDIDO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLItensPedidosSEQ: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'SEQ'
      Origin = 'SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object SQLItensPedidosCODPRO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODPRO'
      Origin = 'CODPRO'
    end
    object SQLItensPedidosCODEAN: TStringField
      FieldName = 'CODEAN'
      Origin = 'CODEAN'
      Size = 13
    end
    object SQLItensPedidosPRVENDA: TBCDField
      DisplayLabel = 'Pr.Unit'#225'rio'
      FieldName = 'PRVENDA'
      Origin = 'PRVENDA'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLItensPedidosPRCOMPRA: TBCDField
      FieldName = 'PRCOMPRA'
      Origin = 'PRCOMPRA'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLItensPedidosQUANTIDADE: TBCDField
      DisplayLabel = 'Qde'
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      Precision = 18
      Size = 2
    end
    object SQLItensPedidosPRTOTAL: TBCDField
      DisplayLabel = 'Pr.Total'
      FieldName = 'PRTOTAL'
      Origin = 'PRTOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLItensPedidosPORCDESC: TBCDField
      FieldName = 'PORCDESC'
      Origin = 'PORCDESC'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLItensPedidosDESCONTO: TBCDField
      DisplayLabel = 'Desconto'
      FieldName = 'DESCONTO'
      Origin = 'DESCONTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLItensPedidosNUMEROLOTE: TStringField
      FieldName = 'NUMEROLOTE'
      Origin = 'NUMEROLOTE'
    end
    object SQLItensPedidosDATAVENCIMENTO: TDateField
      FieldName = 'DATAVENCIMENTO'
      Origin = 'DATAVENCIMENTO'
    end
    object SQLItensPedidosDESPRO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESPRO'
      Origin = 'DESPRO'
      ProviderFlags = []
      Size = 40
    end
    object SQLItensPedidosCONTROLALOTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CONTROLALOTE'
      Origin = 'CONTROLALOTE'
      ProviderFlags = []
      FixedChar = True
      Size = 1
    end
  end
  object DSPedidos_ItensPedidos: TDataSource
    DataSet = SQLPedidos
    Left = 408
    Top = 288
  end
  object SQLConsPro: TFDQuery
    Connection = DataBase
    SQL.Strings = (
      'SELECT P.CodPro, P.DesPro, P.PrVenda, P.Codbarra,'
      
        '(select sum(S.Estoque) from saldoestoque S where S.codpro=p.codp' +
        'ro group by S.codpro) Estoque'
      'FROM Produtos P'
      'WHERE P.inativo = '#39'A'#39
      'and (p.codpro||'#39' '#39'||p.despro||'#39' '#39'||p.codbarra) like :Entrada'
      'ORDER BY Despro')
    Left = 88
    Top = 208
    ParamData = <
      item
        Name = 'ENTRADA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object SQLCartao: TFDQuery
    CachedUpdates = True
    Connection = DataBase
    UpdateObject = UPCartao
    SQL.Strings = (
      'select * from cartaocredito'
      'where codcartao=:codcartao')
    Left = 152
    Top = 208
    ParamData = <
      item
        Name = 'CODCARTAO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object SQLCartaoCODCARTAO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODCARTAO'
      Origin = 'CODCARTAO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLCartaoDESCARTAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCARTAO'
      Origin = 'DESCARTAO'
    end
    object SQLCartaoTAXA: TBCDField
      DisplayLabel = 'Taxa'
      FieldName = 'TAXA'
      Origin = 'TAXA'
      Precision = 18
      Size = 2
    end
  end
  object UPCartao: TFDUpdateSQL
    Connection = DataBase
    Left = 200
    Top = 208
  end
end
