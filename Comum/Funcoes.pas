unit Funcoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db,  StdCtrls, Mask, ComObj, IniFiles, variants;

type
  TF = class(TForm)
    function ChecaString(xStrings, xVar: string; vQdeCampo: Integer): boolean;
    Function Rounds(StrMask:Double;VDig:Integer):Double; {Arredonda valor com mascara para numero tipo Integer}
    Function Converte(letexto: string ):string; {Converte String p/ 1∫ maiusc e rest minusc}
    Function Extenso(Grana  : string ):String; {Converte Grana em extenso}
    Function AnalisaParte(Parte  : string ):String; { parte de conversao da grana para estenso}
    Function StrtoNum(StrMask:String):Double; {Converte valor com mascara para numero tipo double}
    function ValImp(vTam: Integer; vVal: Double): String;
  private
    { Private declarations }
  public
   { Public declarations }
    function AlinhaStrEsq(xCarac: String; vTam: Integer;vStr: String): String;
    function PadC(S: string; Len: byte): string;
    function BuscaGeral(Sentenca: String): String;
    Function StrRepeat(Qtde:Word;VStr:String):String;
    Function Strzero(N:String;Qtde:Integer):String;
    function RetiraAcentos(Texto: String): String;
    function PrimeiraParte(Sentenca: String): String;
  end;

var
  F: TF;

implementation

uses DataModulo, Localizar;


{$R *.DFM}

function TF.AlinhaStrEsq(xCarac : String; vTam: Integer; vStr: String): String;
Var xTexto,xIncr : String;
    Y,xTam,xAux : Integer;
begin
    xTexto := vStr;
    xTam:=0; xAux:=0;  xIncr:='';
    xAux:=Length(xTexto);
    xTam:=vTam-xAux;
    For Y:=1 to xTam do begin xIncr:=xIncr+xCarac; end;
    xTexto:=xTexto+xIncr;
    result := xTexto;
end;

Function TF.Rounds( StrMask : Double; VDig : Integer):Double; { converte string numerica formatada em double}
Var VStr,VInt,VRes:String;
    vInd,x,i:Integer;
begin
{vInd := 1;
For x := 1 to vDig do
   vInd := vInd*10;
if (StrMask = 0) or (FloatToStr(StrMask)= '') then
   exit;
Vstr := FloatToStr(StrMask);
while Pos(ThousandSeparator, VStr) > 0 do
   delete(VStr,Pos(ThousandSeparator,VStr),1);
//
for i:=1 to length(Vstr) do
   if copy(Vstr,i,1) <> DecimalSeparator then
      VInt := VInt + copy(Vstr,i,1)
   else
      begin
      VInt := VInt + copy(VStr,i,VDig+1);
      VRes := copy(Vstr,i+Vdig+1,1);
      break;
      end;
if (VRes = '') or (StrToInt(VRes)<5) then
   Rounds := strtofloat(VInt)
else
   Rounds := StrToFloat(VInt)+(1/vInd);}
end;

function TF.PadC(S:string;Len:byte):string;
// Centraliza uma string em um espaÁo determinado
var
 Str:String;
 L:byte;
begin
str :='';
if len < Length(s) then
   begin
   Result := '';
   Exit;
   end;
l:=(Len-Length(S)) div 2;
while l > 0 do
      begin
      str:=str+' ';
      dec(l);
      end;
for l:=1 to length(S) do
    begin
    str := str+s[L];
    end;
 Result := str;
end;

Function TF.StrRepeat(Qtde:Word;VStr:String):String;
var
i :integer;
S :String;
begin
S:='';
For i:=1 to Qtde do
  S:=Concat(S,VStr);
Result:= S;
end;

Function TF.Strzero(N:String;Qtde:Integer):String;
//i:integer;
//VStr:String;
Begin
{VStr := inttostr(N);
for i:=1 to Qtde - Length(Vstr)do
  VStr:=Concat('0',Vstr);}
if Length(N) < Qtde then
   Result := F.StrRepeat(Qtde-length(N),'0')+N
else
   Result := N;
end;

{Funcao que converte Valor de numero para extenso monet·rio}
Function TF.Extenso(Grana : String) : String;
var
 Y: Double;
 Cent, Simples, Milhar, Milhao, Bilhao, Trilhao : String;
begin
 Try
  Y := StrtoNum(grana);
 except
  raise exception.create('N„o posso converter ' + Grana + 'para valor');
 end;
 if y = 0 then
  begin
  Result := '';
  exit; { Cai fora da funÁ„o}
  end;
 Grana := FormatFloat('000,000,000,000,000.00', Strtofloat(Grana));
 Trilhao := Copy(Grana,1,3);
 Bilhao  := Copy(grana,5,3);
 Milhao  := Copy(Grana,9,3);
 Milhar  := Copy(Grana,13,3);
 Simples := Copy(grana,17,3);
 Cent    := Copy(grana,21,2);
{Centavos}
 if Cent <> '00'      then Cent    := F.AnalisaParte(Cent)
  else Cent := '';
 if Cent = ' e um'    then Cent    := Cent + ' centavo.'
  else if Cent <> ''  then Cent    := Cent + ' centavos.';
{Centenas}
 if Simples <>'000'   then Simples := F.AnalisaParte(Simples)
  else Simples := '';
 if Simples = ' e um' then Simples := Simples + ' real'
  else if Simples <> '' then Simples := Simples + ' reais';
 {Trilhoes,bilhoes,milhoes,Milhar}
 if (Trilhao = '000') and (Bilhao = '000') and (Milhao = '000') and (Copy(Simples,1,1)= ',') then
  begin
  Simples := Copy(Simples,2,Length(Simples));
  Simples := ' e' + Simples;
  end;
  {Milhar}
 if (Milhar<> '000') then Milhar := F.AnalisaParte(Milhar)
  else Milhar := '';
 if Milhar <> ''then Milhar := Milhar + ' mil';
 if (Simples = '') then Milhar := Milhar + ' reais';
  {Milhoes}
 if Milhao<>'000' then Milhao := F.AnalisaParte(Milhao)
  else Milhao := '';
 if Milhao = ' e um' then
  begin
   If (Milhar = ' reais') and (Simples = '') then
   Milhao := Milhao + ' milh„o de'
   else Milhao := Milhao + ' milh„o'  {;}
  end
 else if Milhao <> '' then
  begin
   if (Milhar = ' reais') and (Simples = '') then
   Milhao := Milhao + ' milhıes de'
   else Milhao := Milhao + ' milhıes'
  end;
 {Bilhoes}
 if Bilhao<>'000' then Bilhao := F.AnalisaParte(Bilhao)
  else Bilhao := '';
 if Bilhao = ' e um' then
  begin
   If (Milhao = '') and (Milhar = ' reais') and (Simples = '') then
   Bilhao := Bilhao + ' bilh„o de'
   else Bilhao := Bilhao + ' bilh„o'  {;}
  end
 else if Bilhao <> '' then
  begin
   if (Milhao = '') and (Milhar = ' reais') and (Simples = '') then
   Bilhao := Bilhao + ' bilhıes de'
   else bilhao := bilhao + ' bilhıes'
  end;
  {Trilhoes}
 if Trilhao <>'000' then Trilhao := F.AnalisaParte(Trilhao)
  else Trilhao := '';
 if Trilhao = ' e um' then
  begin
   If (Bilhao = '') and (Milhao = '') and (Milhar = ' reais') and (Simples = '') then
   Trilhao := Trilhao + ' trilh„o de'
   else Trilhao := Trilhao + ' trilh„o'  {;}
  end
 else if Trilhao <> '' then
  begin
   if (Bilhao = '') and (Milhao = '') and (Milhar = ' reais') and (Simples = '') then
   Trilhao := Trilhao + ' trilhıes de'
   else Trilhao := Trilhao + ' trilhıes'
  end;
  {Concatena as unidades}
 Result := Trilhao + Bilhao + Milhao + Milhar + Simples + Cent;
 if cent = '' then Result := Result + '.';
 if Copy(Result,1,6) = ' reais' then Result := Copy(Result,7,length(Result));
 {Retira o espaco inicial}
 Result := Copy(Result,3, Length(Result));
 if Copy(Result,1,1) = #32 then Result:= Copy(Result, 2, length(Result));
 Result := F.Converte(Result);
end;

{ FunÁ„o que analisa parte a parte tres digitos de um valor}
Function TF.AnalisaParte(Parte : String) : String;
const
Unidade: Array[1..9] of string[6] = ('um','dois','tres','quatro','cinco','seis',
                                     'sete','oito','nove');
Dez    : Array[1..9] of string[9] = ('onze','doze','treze','quatorze','quinze',
                                     'dezesseis','dezessete','dezoito','dezenove');
Dezena : Array[1..9] of string[9] = ('dez','vinte','trinta','quarenta','cinquenta',
                                     'sessenta','setenta','oitenta','noventa');
Centena: Array[1..9] of string[12]= ('cento','duzentos','trezentos','quatrocentos',
                                     'quinhentos','seiscentos','setecentos','oitocentos','novecentos');
var
U,D,C : String[1];
begin
 Result := '';
 if length(parte) = 2 then
  begin
   U := Copy(Parte,2,1);
   D := Copy(Parte,1,1);
   C := '' ;
  end
 else
  begin
   U := Copy(Parte,3,1);
   D := Copy(Parte,2,1);
   C := Copy(Parte,1,1);
  end;
 if D = '0' then Result := ' e '+ Unidade[Strtoint(U)];
 if (D = '1') and (U <> '0') then Result := ' e '+ Dez[StrToInt(U)];
 if (D <> '0') and (U = '0') then Result := ' e '+ Dezena[StrtoInt(D)];
 if (D <> '0') and (D <> '1') and (U <> '0') then
 Result := ' e ' + Dezena[StrtoInt(D)] + ' e ' + Unidade[StrtoInt(U)];
 if (C <> '0') and (C <> '') then
  begin
  if (C = '1') and (D = '0') and (U = '0') then Result := ', cem' + Copy(Result,4,length(Result))
  else if (D = '0') and (U = '0') then Result := ', '+ Centena[Strtoint(C)] + Copy(Result,4,length(Result))
  else Result := ', '+ Centena[Strtoint(C)] + Result;
  end;
end;

Function TF.StrtoNum( StrMask : String):Double; { converte string numerica formatada em double}
begin
{while Pos(ThousandSeparator, StrMask) > 0 do
   delete(StrMask,Pos(ThousandSeparator,StrMask),1);
StrtoNum := strtofloat(StrMask);}
end;

{funÁ„o que converte texto de minuscula ou maiuscula em 1letra maiuscula e restte minuscula, palavra a palavra}
function TF.Converte(letexto : string):string;
var
 caso, retorno : string;
begin
 retorno := '';
while length(letexto) >0 do
begin
  caso := Lowercase(copy(letexto,1,Pos(' ',letexto)));
  if caso = 'das ' then
   begin
   retorno := retorno + 'das ';
   Delete(letexto,1,Pos(' ',letexto));
   end;
  if caso = 'dos ' then
   begin
   retorno := retorno + 'dos ';
   Delete(letexto,1,Pos(' ',letexto));
   end;
  if caso = 'do '  then
   begin
   retorno := retorno + 'do ';
   Delete(letexto,1,Pos(' ',letexto));
   end;
  if caso = 'da '  then
   begin
   retorno := retorno + 'da ';
   Delete(letexto,1,Pos(' ',letexto));
   end;
  if caso = 'de '  then
   begin
   retorno := retorno + 'de ';
   Delete(letexto,1,Pos(' ',letexto));
   end;
  if caso = 'e '   then
   begin
   retorno := retorno + 'e ';
   Delete(letexto,1,Pos(' ',letexto));
   end;
  if (Pos(' ',letexto)) > 0 then
   retorno := retorno + UpperCase(Copy(letexto,1,1)) + LowerCase(Copy(letexto,2,Pos(' ',letexto)-1))
  else
   retorno := retorno + UpperCase(Copy(letexto,1,1)) + LowerCase(Copy(letexto,2,Length(letexto)-1));
  if (Pos(' ',letexto)) > 0 then
   Delete(letexto,1,Pos(' ',letexto))
  else
   Delete(letexto,1,Length(letexto));
end;
 converte := retorno;
end;

function TF.PrimeiraParte(Sentenca : String) : String;
var Tamanho, i : Integer;
    Caracter   : String[1];
    Palavra    : String;
begin
    Tamanho := Length(Sentenca);
    i := 1;
    Palavra := '';
    Repeat
       Caracter := Copy(Sentenca,i,1);
       Palavra := Palavra + Caracter;
       i := i + 1;
    Until (Caracter = ' ') or (i > Tamanho);
    PrimeiraParte := Trim(Palavra);
end;

function TF.ValImp(vTam: Integer; vVal: Double): String;
Var xValImp,xIncr : String;
    Y,xTam,xAux : Integer;
begin
    xValImp := FormatFloat('##,##0.00',vVal);
    xTam:=0; xAux:=0;  xIncr:='';
    xAux:=Length(xValImp);
    xTam:=vTam-xAux;
    For Y:=1 to xTam do begin xIncr:=xIncr+' '; end;
    xValImp:=xIncr+xValImp;
    result := xValImp;
end;

function TF.RetiraAcentos(Texto:String): String;
Const
  comAcento = '‡ËÏÚ˘‚ÍÓÙ˚„ı·ÈÌÛ˙Á¸¿»Ã“Ÿ¬ Œ‘€√’¡…Õ”⁄«‹';
  SemAcento = 'aeiouaeiouaoaeioucuAEIOUAEIOUAOAEIOUCU';
Var
  i : Integer;
Begin
For i := 1 to Length(Texto) do
   Begin
   if Pos(Texto[i],ComAcento) <> 0 then
      begin
      Texto[i] := SemAcento[Pos(Texto[i],ComAcento)];
      end;
   end;
Result := Texto;
end;

Function TF.BuscaGeral(Sentenca : String) : String;
var i,x : Integer;
    Palavra    : String;
Begin
Palavra := '';
for x:=1 to Length(Sentenca) do
   begin
   if Sentenca[x]= ' ' then Sentenca[x] := '%';
      Palavra := Palavra + Sentenca[x];
   end;
result := Palavra;
end;

function TF.ChecaString(xStrings:String; xVar : string; vQdeCampo : Integer ) : boolean;
var
  Y : integer;
begin
Result := False;
if xVar <> '' then
   begin
     for y:=1 to length(xStrings) do
     begin
       if xVar = xStrings[y] then
          begin
            Result := True;
            break;
            exit;
          end;
     end;
   end;
end;

end.

