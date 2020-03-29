unit uFormBaseDac;

interface

uses Forms, SysUtils, Windows, Classes, DBCtrls, StdCtrls,
   Variants, Graphics, TypInfo, ExtCtrls, DBClient, Grids;

const
   CORFOCO = '$00F3D1D8' ;
type
  TFormBaseDac = class(TForm)
  private
    FComponente: TComponent;
    FCorComp: TColor;
    { private declarations }
  protected
    procedure DoShow; override;
    procedure DoDestroy; override;
    procedure DoClose(var Action: TCloseAction); override;
    procedure Activate; override;
    procedure doConfigureForm(); virtual;
    procedure MudaCor(Sender: TObject); virtual;
    { protected declarations }
  public
    { public declarations }
    constructor Create(Aowner:TComponent); override;
  published
    { published declarations }
  end;


implementation

uses uLoadFileIni;

{ TFormBase }

procedure TFormBaseDac.Activate;
begin
  inherited;
  Screen.OnActiveControlChange := MudaCor;
end;

constructor TFormBaseDac.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  KeyPreview  := True;
  Position    := poScreenCenter;
  //FormStyle   := fsMDIChild;
  //BorderStyle := bsSingle;
  //BorderIcons := [biSystemMenu];
end;

procedure TFormBaseDac.DoClose(var Action: TCloseAction);
begin
  inherited;
  Release;
end;

procedure TFormBaseDac.doConfigureForm;
var
  x: Integer;
begin
  for x := 0 to ComponentCount - 1 do
  begin
    if TLoadFileIni.GetInstance.CorEdit <> '' then
    begin
      if (Components[x] is TDBEdit) then
      begin
        (Components[x] as TDBEdit).Color :=
          StringToColor(TLoadFileIni.GetInstance.CorEdit);
        (Components[x] as TDBEdit).Font.Color :=
          StringToColor(TLoadFileIni.GetInstance.CorFontEdit);
        (Components[x] as TDBEdit).CharCase := ecUpperCase;
      end
      else if (Components[x] is TEdit) then
      begin
        (Components[x] as TEdit).Color :=
          StringToColor(TLoadFileIni.GetInstance.CorEdit);;
        (Components[x] as TEdit).Font.Color :=
          StringToColor(TLoadFileIni.GetInstance.CorFontEdit);;
        (Components[x] as TEdit).CharCase := ecUpperCase;
      end
      //else if (Components[x] is TJvDBDateEdit) then
      //begin
      //  (Components[x] as TJvDBDateEdit).Color :=
      //    StringToColor(TLoadFileIni.GetInstance.CorEdit);
      //  (Components[x] as TJvDBDateEdit).Font.Color :=
      //    StringToColor(TLoadFileIni.GetInstance.CorFontEdit);
      //end
    end;
    if TLoadFileIni.GetInstance.CorLabel <> '' then
    begin
      if (Components[x] is TLabel) then
        (Components[x] as TLabel).Font.Color        := StringToColor(TLoadFileIni.GetInstance.CorLabel);
      if (Components[x] is TDBCheckBox)then
        (Components[x] as TDBCheckBox).Font.Color   := StringToColor(TLoadFileIni.GetInstance.CorLabel);
      if (Components[x] is TCheckBox)then
        (Components[x] as TCheckBox).Font.Color     := StringToColor(TLoadFileIni.GetInstance.CorLabel);
      if (Components[x] is TGroupBox)then
        (Components[x] as TGroupBox).Font.Color     := StringToColor(TLoadFileIni.GetInstance.CorLabel);
      if (Components[x] is TDBRadioGroup) then
        (Components[x] as TDBRadioGroup).Font.Color := StringToColor(TLoadFileIni.GetInstance.CorLabel);
      if (Components[x] is TRadioGroup) then
        (Components[x] as TRadioGroup).Font.Color   := StringToColor(TLoadFileIni.GetInstance.CorLabel);
    end
  end;
end;

procedure TFormBaseDac.DoDestroy;
begin
  Screen.OnActiveControlChange := nil;
  inherited;
end;

procedure TFormBaseDac.DoShow;
begin
  inherited;
  doConfigureForm();
end;

procedure TFormBaseDac.MudaCor(Sender: TObject);
begin
  if Assigned(FComponente) then
    TEdit(FComponente).Color := FCorComp; // cor original do FComponente

  if (ActiveControl <> nil) and (IsPublishedProp(ActiveControl, 'Color'))  then
  begin
    if not (ActiveControl is TCustomGrid)  then
    begin
      FCorComp := TEdit(ActiveControl).Color;
      TEdit(ActiveControl).Color :=  StringToColor(CorFoco); // cor com foco
      FComponente := ActiveControl;
    end;
  end;
end;


end.
