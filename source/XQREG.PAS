unit xqreg;

{$I XQ_FLAG.INC}
interface
{Thanks to : Steve Garland who created most of this unit
 Date: Jun 30, 2003}

{$R xqresour.dcr}

procedure Register;

implementation

uses
   Classes, xQuery, Db, SysUtils, SyntaxHi, xQBase
{$IFDEF LEVEL6}
   , DesignIntf, DesignEditors, Variants
{$ELSE}
   , DsgnIntf
{$ENDIF}
   ;

type
  TDataSetsPropEditor = class(TComponentProperty)
  private
    FProc : TGetStrProc;
    procedure getProc(const s : string);
  public
    procedure GetValues(Proc : TGetStrProc); override;
  end;

  TParamPropEditor = class(TComponentProperty)
  private
    FProc : TGetStrProc;
    procedure getProc(const s : string);
  public
    procedure GetValues(Proc : TGetStrProc); override;
  end;

procedure Register;
begin
   RegisterComponents('XQuery', [TxQuery, TSyntaxHighlighter]);
   RegisterPropertyEditor(TypeInfo(TComponent), TxDataSetItem,
      'DataSets', TDataSetsPropEditor);
  RegisterPropertyEditor(TypeInfo(TComponent), TParam,
      'Params', TParamPropEditor);
end;

{ TDataSetsPropEditor - class implementation }
procedure TDataSetsPropEditor.getProc(const s : string);
var
  i    : integer;
  item : TxDataSetItem;
begin
  item := TxDataSetItem(GetComponent(0));
  with item, Collection do
    for i := 0 to Count - 1 do
      if Assigned(TxDataSetItem(Items[i]).DataSet) and
         (CompareText(s, TxDataSetItem(Items[i]).DataSet.Name) = 0) then
        exit;

  FProc(s);
end;

procedure TDataSetsPropEditor.GetValues(Proc : TGetStrProc);
begin
  FProc := Proc;
  inherited GetValues(getProc);
end;

{TParamPropEditor - class implementation}

procedure TParamPropEditor.getProc(const s : string);
var
  i    : integer;
  item : TParam;
begin
  item := TParam(GetComponent(0));
  with item, Collection do
    for i := 0 to Count - 1 do
      if CompareText(s, TParam(Items[i]).Name) = 0 then
        exit;

  FProc(s);
end;

procedure TParamPropEditor.GetValues(Proc : TGetStrProc);
begin
  FProc := Proc;
  inherited GetValues(getProc);
end;

end.
