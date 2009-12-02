{**************************************************************************}
{   TxQuery DataSet                                                        }
{                                                                          }
{   Copyright (C) <1999-2003> of                                           }
{   Alfonso Moreno (Hermosillo, Sonora, Mexico)                            }
{   email: luisarvayo@yahoo.com                                            }
{     url: http://www.ezsoft.com                                           }
{          http://www.sigmap.com/txquery.htm                               }
{                                                                          }
{   Open Source patch review (2009) with permission from Alfonso Moreno by }
{   Chee-Yang CHAU and Sherlyn CHEW (Klang, Selangor, Malaysia)            }
{   email: cychau@gmail.com                                                }
{   url: http://code.google.com/p/txquery/                                 }
{        http://groups.google.com/group/txquery                            }
{                                                                          }
{   This program is free software: you can redistribute it and/or modify   }
{   it under the terms of the GNU General Public License as published by   }
{   the Free Software Foundation, either version 3 of the License, or      }
{   (at your option) any later version.                                    }
{                                                                          }
{   This program is distributed in the hope that it will be useful,        }
{   but WITHOUT ANY WARRANTY; without even the implied warranty of         }
{   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          }
{   GNU General Public License for more details.                           }
{                                                                          }
{   You should have received a copy of the GNU General Public License      }
{   along with this program.  If not, see <http://www.gnu.org/licenses/>.  }
{                                                                          }
{**************************************************************************}

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
