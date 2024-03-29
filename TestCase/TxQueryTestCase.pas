{*****************************************************************************}
{   TxQuery DataSet                                                           }
{                                                                             }
{   The contents of this file are subject to the Mozilla Public License       }
{   Version 1.1 (the "License"); you may not use this file except in          }
{   compliance with the License. You may obtain a copy of the License at      }
{   http://www.mozilla.org/MPL/                                               }
{                                                                             }
{   Software distributed under the License is distributed on an "AS IS"       }
{   basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the   }
{   License for the specific language governing rights and limitations        }
{   under the License.                                                        }
{                                                                             }
{   The Original Code is: TxQueryTestCase.pas                                 }
{                                                                             }
{                                                                             }
{   The Initial Developer of the Original Code is Alfonso Moreno.             }
{   Portions created by Alfonso Moreno are Copyright (C) <1999-2003> of       }
{   Alfonso Moreno. All Rights Reserved.                                      }
{   Open Source patch reviews (2009-2012) with permission from Alfonso Moreno }
{                                                                             }
{   Alfonso Moreno (Hermosillo, Sonora, Mexico)                               }
{   email: luisarvayo@yahoo.com                                               }
{     url: http://www.ezsoft.com                                              }
{          http://www.sigmap.com/txquery.htm                                  }
{                                                                             }
{   Contributor(s): Chee-Yang, CHAU (Malaysia) <cychau@gmail.com>             }
{                   Sherlyn CHEW (Malaysia)                                   }
{                   Francisco Due�as Rodriguez (Mexico) <fduenas@gmail.com>   }
{                                                                             }
{              url: http://code.google.com/p/txquery/                         }
{                   http://groups.google.com/group/txquery                    }
{                                                                             }
{*****************************************************************************}

unit TxQueryTestCase;

{$I ..\source\xq_flag.inc}

interface

uses
  System.Classes, System.SyncObjs, System.SysUtils, Data.DB, Datasnap.DBClient,
  TestFramework,
  QFormatSettings, XQuery;

type{$M+}
  TTest_TxQuery = class(TTestCase)
  public
   procedure Test_OnCalcFieldsEvent( ADataset: TDataset ); virtual;
  protected
    FDate: TDateTime;
    FMainDataSet: TClientDataSet;
    FDetailDataSet: TClientDataSet;
    FQuery: TxQuery;
    function CanCreateTestData: boolean; virtual;
    function CanCreateCalcFields: boolean; virtual;
    procedure SetUp; override;
    procedure TearDown; override;
    procedure SetupDataSets(AppendTestData:Boolean=true; UseCalcFields:Boolean=false); virtual;
    procedure CreateTestData(UseCalcFields: Boolean=false); virtual;
  end;

  TTest_DataSet = class(TTest_TxQuery)
  published
    procedure Test_BookmarkValid;
  end;

  TTest_Between = class(TTest_TxQuery)
  private
    FShortDateFormat: string;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TTest_Between_SQL;
  end;

  TTest_FreeTxQuery = class(TTest_TxQuery)
  published
    procedure Test_FreeClientDataSetBeforeFreeTxQuery;
  end;

  TTest_Transform = class(TTest_TxQuery)
  published
    procedure Test_Transform_Data;
    procedure Test_Transform_FormatDateTime;
    procedure Test_Transform_Naming_1;
    procedure Test_Transform_Naming_2;
    procedure Test_Transform_SQL_WithoutOrderBy;
  end;

  TTest_Distinct = class(TTest_TxQuery)
  published
    procedure Test_Distinct_Aggregate;
    procedure Test_Distinct_NullRecord;
    procedure Test_Distinct_Record;
  end;

  TTest_IN = class(TTest_TxQuery)
  published
    procedure TTest_IN_SQL;
  end;

  TTest_OrderBy = class(TTest_TxQuery)
  published
    procedure Test_OrderBy_Desc;
    procedure Test_OrderBy_SingleField_Desc;
    procedure Test_OrderBy_MultiField;
  end;

  TTest_LIKE = class(TTest_TxQuery)
  published
    procedure Test_LIKE_Mix;
    procedure Test_LIKE_EscapeChar_Mix;
    procedure Test_LIKE_Multiple_Contains;
    procedure Test_LIKE_Multiple_EndWith;
    procedure Test_LIKE_Multiple_StartWith;
    procedure Test_LIKE_Single_Contains_Left;
    procedure Test_LIKE_Single_Contains_Middle;
    procedure Test_LIKE_Single_Contains_Right;
  end;

  TTest_Filter = class(TTest_TxQuery)
  published
   procedure Test_Filter_ISLIKE_Multiple_Contains; {ISLIKE and SQLLIKE, are the same as LIKE but
                                                    there is no need to enclose them in brakets }
   procedure Test_Filter_LIKE_Mix_InBrakets; {LIKE, When used in Filter must be used as function
                                              and to be enclosed in Brakets []}
   procedure Test_Filter_MATCH_EscapeChar_Mix;
   procedure Test_Filter_MATCH_Ranges_Mix;
  end;

  TTest_GroupBy = class(TTest_TxQuery)
  published
    procedure Test_GroupBy_SUMQty;
    procedure Test_GroupBy_Having;
    procedure Test_GroupBy_Division2;
    procedure Test_GroupBy_Division1;
    procedure Test_GroupBy_Division3;
  end;

  TTest_SubQueries = class(TTest_TxQuery)
  published
    procedure Test_SubQueries_IN_Case1;
    procedure Test_SubQueries_IN_Case2;
    procedure Test_SubQueries_NOTIN_Case1;
    procedure Test_SubQueries_NOTIN_Case2;
  end;

  TTest_Join = class(TTest_TxQuery)
  published
    procedure Test_EmptyKeyJoin_InnerJoin;
    procedure Test_EmptyKeyJoin_LeftOuterJoin;
    procedure Test_JoinTwoDataSets_WithShortAlias;
    procedure Test_JoinTwoDataSets_WithTableAlias;
    procedure Test_JoinTwoDataSets_InnerJoin;
    procedure Test_JoinTwoDataSets_LeftOuterJoin;
    procedure Test_JoinTwoDataSets_LeftOuterJoin_MoreCondition;
  end;

  TTest_Union = class(TTest_TxQuery)
  published
    procedure Test_UnionSQL;
  end;

  TTest_Update = class(TTest_TxQuery)
  published
    procedure Test_UpdateSingleField;
    procedure Test_UpdateMultiField;
    procedure Test_Update_WithCondition;
    procedure Test_Update_WithSubQueries;
    procedure Test_Update_Arithmetic;
    procedure Test_Update_OneCentDiffBug;
  end;

  TTest_Delete = class(TTest_TxQuery)
  published
    procedure Test_Delete_WithCondition;
    procedure Test_Delete_WithSubQueries;
  end;

  TTest_Insert = class(TTest_TxQuery)
  published
    procedure Test_Insert_AllFields;
    procedure Test_Insert_BlankDataSet;
    procedure Test_Insert_WithSelectSQL;
    procedure Test_Insert_WithValues;
  end;

  TTest_Clone = class(TTest_TxQuery)
  private
    FCloneDataSet: TClientDataSet;
  protected
    procedure Execute(const aFieldNames: string);
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Test_ByAsterisk;
    procedure Test_ByFieldNames;
  end;

  TTest_Min = class(TTest_TxQuery)
  published
    procedure Test_Min;
    procedure Test_Min_WithCondition;
    procedure Test_String;
  end;

  TTest_Max = class(TTest_TxQuery)
  published
    procedure Test_Max;
    procedure Test_Max_WithCondition;
    procedure Test_String;
  end;

  TTest_Extract = class(TTest_TxQuery)
  published
    procedure Test_ExtractSQL;
    procedure Test_ExtractSQL_Condition;
  end;

  TTest_ParamByName = class(TTest_TxQuery)
  published
    procedure Test_ParamByName;
  end;

  TTest_Fields = class(TTest_TxQuery)
  published
    procedure Test_Boolean_Fields_False;
    procedure Test_Boolean_Fields_True;
    procedure Test_String_Fields;
    procedure Test_MaxString;
    procedure Test_OrderBy_WideString_Field;
    procedure Test_Memo_Fields;
    procedure Test_LargeInteger_Fields;
    procedure Test_Calculated_Fields;
    procedure Test_Is_Null;
    procedure Test_Date;
    procedure Test_Required_Fields;
  end;

  TTest_DateTime = class(TTest_TxQuery)
  published
    procedure Test_SelectAll;
    procedure Test_ExtractDate;
    procedure Test_FormatDateTime1;
    procedure Test_FormatDateTime2;
    procedure Test_StrToDate;
    function CanCreateCalcFields: boolean; override;
  end;

  TTest_Hardcode_String = class(TTest_TxQuery)
  published
    procedure Test_Hardcode_String_Select;
  end;

  TTest_Select = class(TTest_TxQuery)
  published
    procedure Test_HasEmptyDataSet;
    procedure Test_MaxLengthPerLine;
  end;

  TTest_DirectAccess = class(TTest_TxQuery)
  protected
    procedure SetUp; override;
  published
    procedure Test_AnsiString;
    procedure Test_Boolean;
    procedure Test_Date;
    procedure Test_DateTime;
    procedure Test_FmtBcd;
    procedure Test_Integer;
    procedure Test_LargeInt;
    procedure Test_Memo;
    procedure Test_Time;
    procedure Test_TimeStamp;
    procedure Test_WideMemo;
    procedure Test_WideString;
  end;

  TTestCase_Float = class(TTest_TxQuery)
  published
    procedure Test_Max;
  end;

  TTest_TxQuery_Threading = class(TTestCase)
  published
    procedure Test_Case1;
  end;

implementation

uses
  System.DateUtils, System.StrUtils, System.Threading, System.Variants,
  Data.FMTBcd,
{$IFDEF LEVEL4}
  Data.SqlTimSt,
{$ENDIF}
  Datasnap.Provider;

type THackDataSet = Class(TDataSet); {Hack class needed to add calculated fields at runtime}

const SglEps = 1.1920928955e-07;

var TxQueryTestSuite: TTestSuite;

function GetDataPacket(DataSet: TDataSet): OleVariant;
var P: TDataSetProvider;
begin
  P := TDataSetProvider.Create(nil);
  DataSet.DisableControls;
  try
    if DataSet.Active then DataSet.First;
    P.DataSet := DataSet;
    Result := P.Data;
  finally
    P.Free;
    DataSet.EnableControls;
  end;
end;

function GetUSFormatSettings: TFormatSettings;
begin
  {$if CompilerVersion >= 22}
  Result := TFormatSettings.Create('en-us');
  {$else}
  GetLocaleFormatSettings(1033, Result);
  {$ifend}
  Result.DecimalSeparator := '.';
  Result.ThousandSeparator := ',';
end;

procedure TTest_TxQuery.SetupDataSets(AppendTestData:Boolean;
 UseCalcFields:Boolean);
var i: integer;
begin
 //Main Data
  if not assigned(FMainDataSet) then
     FMainDataSet := TClientDataSet.Create(nil)
  else
     FMainDataSet.Active := false;
  with FMainDataSet do begin
    FMaindataset.Name := 'MainDataSet';
    Fields.Clear;
    FieldDefs.Clear;
    FieldDefs.Add('DocKey',    ftInteger, 0);
    FieldDefs.Add('Code',      ftString, 10);
    FieldDefs.Add('DocNo',     ftString, 20);
    FieldDefs.Add('DocDate',   ftDate,    0);
    FieldDefs.Add('DocTime',   ftTime,    0);
    FieldDefs.Add('DocDateTime',ftDateTime,    0);
    {$IFDEF LEVEL4}
     FieldDefs.Add('DocTimeStamp',ftTimeStamp,  0);
    {$ENDIF}
    FieldDefs.Add('Agent',     ftString, 10);
    FieldDefs.Add('Qty',       ftFmtBCD,  8);
    FieldDefs.Add('UnitPrice', ftFmtBCD,  8);
    FieldDefs.Add('Amount',    ftFmtBCD,  8);
    FieldDefs.Add('WDocNo',    ftWideString, 20);
    FieldDefs.Add('Memo',      ftMemo,     80);
    FieldDefs.Add('WMemo',     ftWideMemo, 80);
    FieldDefs.Add('LargeKey',  ftLargeint, 0);
    FieldDefs.Add('RecordActive',    ftBoolean, 0);
    {Calculated fields}
    if UseCalcFields then
    begin
     THackDataSet(FMainDataSet).CreateFields;
     for i  := 0 to FieldDefs.Count-1 do
     begin
      if (FieldDefs[i].InternalCalcField) or (FieldDefs[i].DataType in ftNonTextTypes) or
         (FieldDefs[i].DataType = ftWideMemo) then
         continue;
      with FieldDefs[i].FieldClass.Create( FMainDataSet ) do
      begin
       Name := FMainDataSet.Name+'CALC_'+FieldDefs[i].DisplayName;
       FieldName := 'CALC_'+FieldDefs[i].DisplayName;
       FieldKind := fkCalculated;
       Size := FieldDefs[i].Size;
       DataSet := FMainDataSet
      end;
     end;
     FMainDataSet.OnCalcFields := Test_OnCalcFieldsEvent;
     FMainDataSet.AutoCalcFields := true;
    end
    else
    begin
     FMainDataSet.OnCalcFields := nil;
     FMainDataSet.AutoCalcFields := false;
    end;
    CreateDataSet;
  end;

  //Detail Data
  if not assigned(FDetailDataSet) then
     FDetailDataSet := TClientDataSet.Create(nil)
  else
     FDetailDataSet.Active := false;

  with FDetailDataSet do begin
    FieldDefs.Clear;
    FieldDefs.Add('DocKey',   ftInteger, 0);
    FieldDefs.Add('ItemCode', ftString, 30);
    CreateDataSet;
  end;

  if AppendTestData then
     CreateTestData( UseCalcFields );
end;

function TTest_TxQuery.CanCreateTestData: boolean;
begin
 result := true;
end;

function TTest_TxQuery.CanCreateCalcFields: boolean;
begin
 result := false;
end;

procedure TTest_TxQuery.CreateTestData(UseCalcFields: Boolean);
 var i: integer;
begin
  FMainDataSet.Active := true;
  FMainDataSet.EmptyDataSet;
  FMainDataSet.AutoCalcFields := UseCalcFields;
  if UseCalcFields then
   FMainDataSet.OnCalcFields := Test_OnCalcFieldsEvent
  else
    FMainDataSet.OnCalcFields := nil;
  for i := 1 to 10 do begin
    FMainDataSet.Append;
    FMainDataSet['DocKey'] := i;
    FMainDataSet['Code'] := Format('300-%d', [i]);
    FMainDataSet['DocNo'] := Format('IV-%.4d', [i]);
    FMainDataSet['WDocNo'] := Format('IV-%.4d', [i]);
    FMainDataSet['DocDate'] := IncDay(FDate, i);
    FMainDataSet['DocTime'] := IncHour(Fdate, i);
    FMainDataSet['DocDateTime'] := IncDay( IncHour(Fdate, i), i);
    {$IFDEF LEVEL4}
     FMainDataSet.FieldByName('DocTimeStamp').AsSQLTimeStamp := DateTimeToSQLTimeStamp( IncDay( IncHour(Fdate, i), i) );
    {$ENDIF}
    FMainDataSet['LargeKey'] := 123456789012345670+i;
    if i <= 3 then
       FMainDataSet['Agent'] := 'ABC'
    else if (i > 3) and (i < 8) then
      FMainDataSet['Agent'] := 'DEF'
    else
      FMainDataSet['Agent'] := 'GHI';
    FMainDataSet['Qty'] := i;
    FMainDataSet['UnitPrice'] := i * 2;
    FMainDataSet['Amount'] := FMainDataSet['Qty'] * FMainDataSet['UnitPrice'];
    FMainDataSet['RecordActive'] := (i Mod 2)=0;
    FMainDataSet.Post;
  end;

  FDetailDataSet.MasterSource := nil;
  FDetailDataSet.MasterFields := '';
  FDetailDataSet.Active := true;
  FDetailDataSet.EmptyDataSet;
  for i := 1 to 5 do begin
    FDetailDataSet.Append;
    if (i <= 3) then
      FDetailDataSet['DocKey'] := 1
    else
      FDetailDataSet['DocKey'] := 7;
    FDetailDataSet['ItemCode'] := Format('Item%d', [i]);
    FDetailDataSet.Post;
  end;
end;

procedure TTest_TxQuery.SetUp;
begin
  inherited;
  FDate := EncodeDate(2005, 5, 5);
  FQuery := TxQuery.Create(nil);
  SetupDataSets(CanCreateTestData, CanCreateCalcFields);
end;

procedure TTest_TxQuery.TearDown;
begin
  inherited;
  FMainDataSet.OnCalcFields := nil;
  FMainDataSet.Free;
  FMainDataSet := nil;
  FDetailDataSet.Free;
  FDetailDataSet := nil;
  FQuery.Free;
  FQuery := nil;
end;

procedure TTest_TxQuery.Test_OnCalcFieldsEvent(ADataset: TDataset);
var i: integer;
    fld: TField;
begin
 with ADataSet do
 begin
  for I := 0 to  Fields.Count-1 do
  begin
   if not (Fields[i].FieldKind=fkData) then
      continue;
   fld := FindField('CALC_'+Fields[i].FieldName);
   if not Assigned(fld) then
      Continue;
   fld.Value := Fields[i].Value;
  end;
 end;
end;

procedure TTest_DataSet.Test_BookmarkValid;
begin
  var M := TClientDataSet.Create(nil);
  var Q := TxQuery.Create(nil);
  try
    M.FieldDefs.Add('Field', ftInteger);
    M.CreateDataSet;

    Q.AddDataSet(M, 'Main');
    Q.SQL.Text := 'SELECT * FROM Main';
    Q.Open;
    var B := Q.GetBookmark;
    CheckFalse(Q.BookmarkValid(B));
  finally
    M.Free;
    Q.Free;
  end;
end;

procedure TTest_Between.SetUp;
begin
  inherited;
  FShortDateFormat := FQuery.DateFormat;
  FQuery.DateFormat := 'dd/mm/yyyy';
  FQuery.DateSeparator := '/';
  FQuery.FormatSettings.Parser.ShortDateFormat := 'dd/mm/yyyy';
  FQuery.FormatSettings.System.ShortDateFormat := 'dd/mm/yyyy';
  FQuery.FormatSettings.Parser.DateSeparator := '/';
  FQuery.FormatSettings.System.DateSeparator := '/';
end;

procedure TTest_Between.TearDown;
begin
 FQuery.DateFormat := FShortDateFormat;
 inherited;
end;

procedure TTest_Between.TTest_Between_SQL;
var lDataSet: TClientDataSet;
    i: integer;
    F: TFormatSettings;
begin
  lDataSet := TClientDataSet.Create(nil);
  try
    FQuery.DataSets.Clear;
    FQuery.AddDataSet(FMainDataSet, 'Main');

    F.DateSeparator := FQuery.DateSeparator;
    with FQuery.SQL do begin
      Clear;
      Add(      'SELECT *');
      Add(        'FROM Main');
      Add(Format('WHERE DocDate BETWEEN #%s# AND #%s#', [FormatDateTime('dd/mm/yyyy', IncDay(FDate, 3), F) , FormatDateTime('dd/mm/yyyy', IncDay(FDate, 6), F)]));
      Add(       'ORDER BY DocKey');
    end;
    lDataSet.Data := GetDataPacket(FQuery);

    //Check Record Count
    CheckEquals(4, lDataSet.RecordCount, 'Record Count incorrect');

    lDataSet.IndexFieldNames := 'DocKey';
    lDataSet.First;
    while not lDataSet.Eof do begin
      //if DocKey correct then the following code also correct
      CheckEquals(lDataSet.RecNo + 2, lDataSet.FindField('DocKey').AsInteger, 'DocKey incorrect');

      if FMainDataSet.Locate('DocKey', lDataSet['DocKey'], []) then begin
        for i := 0 to lDataSet.FieldCount - 1 do begin
          if lDataSet.Fields[i] is TStringField then
            CheckEquals(FMainDataSet.FindField(lDataSet.Fields[i].FieldName).AsString, lDataSet.Fields[i].AsString)
         {$IFDEF LEVEL4}
          else if lDataSet.Fields[i] is TWideStringField then
            CheckEquals(FMainDataSet.FindField(lDataSet.Fields[i].FieldName).AsWideString, lDataSet.Fields[i].AsWideString)
         {$ENDIF}
          else if lDataSet.Fields[i] is TIntegerField then
            CheckEquals(FMainDataSet.FindField(lDataSet.Fields[i].FieldName).AsInteger, lDataSet.Fields[i].AsInteger)
          else if lDataSet.Fields[i] is TFmtBCDField then
            CheckEquals(FMainDataSet.FindField(lDataSet.Fields[i].FieldName).AsCurrency, lDataSet.Fields[i].AsCurrency)
          else if lDataSet.Fields[i] is TDateField then
            CheckEquals(FMainDataSet.FindField(lDataSet.Fields[i].FieldName).AsDateTime, lDataSet.Fields[i].AsDateTime);
        end;
      end;
      lDataSet.Next;
    end;
  finally
    lDataSet.Free;
  end;
end;

procedure TTest_FreeTxQuery.Test_FreeClientDataSetBeforeFreeTxQuery;
var LQuery: TxQuery;
    lDataSet: TClientDataSet;
begin
  LQuery := TxQuery.Create(nil);
  lDataSet := TClientDataSet.Create(nil);
  try
    lDataSet.Data := FMainDataSet.Data;

    LQuery.DataSets.Clear;
    LQuery.AddDataSet(lDataSet, 'Main');
    LQuery.SQL.Text := 'SELECT * FROM Main';
    LQuery.Open;
  finally
    lDataSet.Free;
    LQuery.Free;
  end;
end;

procedure TTest_Transform.Test_Transform_Data;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('TRANSFORM SUM(Amount)');
    Add(   'SELECT DocNo');
    Add(     'FROM Main');
    Add(    'GROUP BY DocNo');
    Add(    'ORDER BY DocNo');
    Add(    'PIVOT Agent IN ("ABC", "DEF", "GHI")');
  end;
  FQuery.Open;
  CheckEquals(10, FQuery.RecordCount, 'FQuery Record Count incorrect.');

  FQuery.First;
  CheckEquals(2,         FQuery.FindField('ABC').AsCurrency, 'Record 1 Field "ABC" incorrect');
  CheckEquals(0,         FQuery.FindField('DEF').AsCurrency, 'Record 1 Field "DEF" incorrect');
  CheckEquals(0,         FQuery.FindField('GHI').AsCurrency, 'Record 1 Field "GHI" incorrect');
  CheckEquals('IV-0001', FQuery.FindField('DocNo').AsString, 'Record 1 Field "DocNo" incorrect');

  FQuery.Next;
  CheckEquals(8,         FQuery.FindField('ABC').AsCurrency, 'Record 2 Field "ABC" incorrect');
  CheckEquals(0,         FQuery.FindField('DEF').AsCurrency, 'Record 2 Field "DEF" incorrect');
  CheckEquals(0,         FQuery.FindField('GHI').AsCurrency, 'Record 2 Field "GHI" incorrect');
  CheckEquals('IV-0002', FQuery.FindField('DocNo').AsString, 'Record 2 Field "DocNo" incorrect');

  FQuery.RecNo := 5;
  CheckEquals(50,        FQuery.FindField('DEF').AsCurrency, 'Record 5 Field "DEF" incorrect');
  CheckEquals(0,         FQuery.FindField('ABC').AsCurrency, 'Record 5 Field "ABC" incorrect');
  CheckEquals(0,         FQuery.FindField('GHI').AsCurrency, 'Record 5 Field "GHI" incorrect');
  CheckEquals('IV-0005', FQuery.FindField('DocNo').AsString, 'Record 5 Field "DocNo" incorrect');

  FQuery.RecNo := 10;
  CheckEquals(200,       FQuery.FindField('GHI').AsCurrency, 'Record 10 Field "GHI" incorrect');
  CheckEquals(0,         FQuery.FindField('ABC').AsCurrency, 'Record 10 Field "ABC" incorrect');
  CheckEquals(0,         FQuery.FindField('DEF').AsCurrency, 'Record 10 Field "DEF" incorrect');
  CheckEquals('IV-0010', FQuery.FindField('DocNo').AsString, 'Record 10 Field "DocNo" incorrect');
  FQuery.Close;
end;

procedure TTest_Transform.Test_Transform_FormatDateTime;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  with FQuery.SQL do begin
    Clear;
    Add('TRANSFORM SUM(Amount)');
    Add(   'SELECT Agent');
    Add(     'FROM Main');
    Add(    'GROUP BY Agent');
    Add(   'PIVOT FormatDateTime("yyyy", DocDate)');
  end;
  FQuery.Open;
  CheckEquals(3, FQuery.RecordCount);

  FQuery.First;
  CheckEquals(28,    FQuery.FindField('2005').AsCurrency,  'Record 1 Field "2005" incorrect');
  CheckEquals('ABC', FQuery.FindField('Agent').AsString,   'Record 1 Field "Agent" incorrect');
  FQuery.Next;
  CheckEquals(252,   FQuery.FindField('2005').AsCurrency,  'Record 2 Field "2005" incorrect');
  CheckEquals('DEF', FQuery.FindField('Agent').AsString,   'Record 2 Field "Agent" incorrect');
  FQuery.Next;
  CheckEquals(490,   FQuery.FindField('2005').AsCurrency,  'Record 3 Field "2005" incorrect');
  CheckEquals('GHI', FQuery.FindField('Agent').AsString,   'Record 3 Field "Agent" incorrect');
  FQuery.Close;
end;

procedure TTest_Transform.Test_Transform_Naming_1;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  with FQuery.SQL do begin
    Clear;
    Add('TRANSFORM SUM(Amount)');
    Add(   'SELECT Agent');
    Add(     'FROM Main');
    Add(    'GROUP BY Agent');
    Add(    'PIVOT Agent IN ("ABC", "DEF", "GHI")');
  end;
  FQuery.Open;
  CheckEquals('Agent', FQuery.Fields[0].FieldName);
  CheckEquals('ABC', FQuery.Fields[1].FieldName);
  CheckEquals('DEF', FQuery.Fields[2].FieldName);
  CheckEquals('GHI', FQuery.Fields[3].FieldName);
end;

procedure TTest_Transform.Test_Transform_Naming_2;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  with FQuery.SQL do begin
    Clear;
    Add('TRANSFORM SUM(Amount), Max(Amount)');
    Add(   'SELECT Agent');
    Add(     'FROM Main');
    Add(    'GROUP BY Agent');
    Add(    'PIVOT Agent IN ("ABC", "DEF", "GHI")');
  end;
  FQuery.Open;
  CheckEquals('Agent', FQuery.Fields[0].FieldName);
  CheckEquals('ABC',   FQuery.Fields[1].FieldName);
  CheckEquals('ABC_1', FQuery.Fields[2].FieldName);
  CheckEquals('DEF',   FQuery.Fields[3].FieldName);
  CheckEquals('DEF_1', FQuery.Fields[4].FieldName);
  CheckEquals('GHI',   FQuery.Fields[5].FieldName);
  CheckEquals('GHI_1', FQuery.Fields[6].FieldName);
end;

procedure TTest_Transform.Test_Transform_SQL_WithoutOrderBy;
var lDataSet: TClientDataSet;
    i: integer;
begin
  //Purpose: To generate special kind of record, then transform the data without order by clause, this will generate recno out of range error
  //sometime "RecNo Out of range" error occur because of one of the field appear in transform -> group by part contain null data, in order to solve this, we update the field from null to ' ' (a space in between) before do the transformation (Note: if we set to empty '' string cant help, must set to ' ' (one space)
  lDataSet := TClientDataSet.Create(nil);
  try
    with lDataSet do begin
      FieldDefs.Clear;
      FieldDefs.Add('DocKey',    ftInteger, 0);
      FieldDefs.Add('Code',      ftString, 10);
      FieldDefs.Add('DocNo',     ftString, 20);
      FieldDefs.Add('DocDate',   ftDate,    0);
      FieldDefs.Add('Agent',     ftString, 10);
      FieldDefs.Add('Qty',       ftFmtBCD,  8);
      FieldDefs.Add('UnitPrice', ftFmtBCD,  8);
      FieldDefs.Add('Amount',    ftFmtBCD,  8);
      CreateDataSet;
    end;

    for i := 1 to 10 do begin
      lDataSet.Append;
      lDataSet['DocKey']   := i;
      if (i <= 5) or (i = 8) then //front 5 records and back one record same value
        lDataSet['Code']    := '500-1'
      else
        lDataSet['Code']    := Format('300-%d', [i]);
      if i <= 2 then  //front few records same value, and back few records same value
        lDataSet['DocNo']   := 'IV-0001'
      else
        lDataSet['DocNo']   := 'IV-0002';
      lDataSet['DocDate']   := IncDay(Date, i);
      lDataSet['Agent']     := 'ABC';
      lDataSet['Qty']       := i;
      lDataSet['UnitPrice'] := i * 2;
      lDataSet['Amount']    := lDataSet['Qty'] * lDataSet['UnitPrice'];
      lDataSet.Post;
    end;

    FQuery.DataSets.Clear;
    FQuery.AddDataSet(lDataSet, 'Main');

    with FQuery.SQL do begin
      Clear;
      Add('TRANSFORM SUM(Amount)');
      Add(   'SELECT Code, Agent');
      Add(     'FROM Main');
      Add(    'GROUP BY Code, Agent');
      Add(    'PIVOT DocNo IN ("IV-0001", "IV-0002")');
    end;
    FQuery.Open;

    CheckEquals(5, FQuery.RecordCount, 'FQuery Record Count incorrect');
    FQuery.First;
    CheckEquals(0,          FQuery.FindField('IV-0001').AsCurrency, 'Record 1 Field "IV-0001" incorrect');
    CheckEquals(200,        FQuery.FindField('IV-0002').AsCurrency, 'Record 1 Field "IV-0002" incorrect');
    CheckEquals('300-10',   FQuery.FindField('Code').AsString,      'Record 1 Field "Code" incorrect');

    FQuery.Next;
    CheckEquals(0,          FQuery.FindField('IV-0001').AsCurrency, 'Record 2 Field "IV-0001" incorrect');
    CheckEquals(72,         FQuery.FindField('IV-0002').AsCurrency, 'Record 2 Field "IV-0002" incorrect');
    CheckEquals('300-6',    FQuery.FindField('Code').AsString,      'Record 2 Field "Code" incorrect');

    FQuery.Next;
    CheckEquals(0,          FQuery.FindField('IV-0001').AsCurrency, 'Record 3 Field "IV-0001" incorrect');
    CheckEquals(98,         FQuery.FindField('IV-0002').AsCurrency, 'Record 3 Field "IV-0002" incorrect');
    CheckEquals('300-7',    FQuery.FindField('Code').AsString,      'Record 3 Field "Code" incorrect');

    FQuery.Next;
    CheckEquals(0,          FQuery.FindField('IV-0001').AsCurrency, 'Record 4 Field "IV-0001" incorrect');
    CheckEquals(162,        FQuery.FindField('IV-0002').AsCurrency, 'Record 4 Field "IV-0002" incorrect');
    CheckEquals('300-9',    FQuery.FindField('Code').AsString,      'Record 4 Field "Code" incorrect');

    FQuery.Next;
    CheckEquals(10,         FQuery.FindField('IV-0001').AsCurrency, 'Record 5 Field "IV-0001" incorrect');
    CheckEquals(228,        FQuery.FindField('IV-0002').AsCurrency, 'Record 5 Field "IV-0002" incorrect');
    CheckEquals('500-1',    FQuery.FindField('Code').AsString,      'Record 5 Field "Code" incorrect');

    FQuery.Close;
  finally
    lDataSet.Free;
  end;
end;

procedure TTest_Distinct.Test_Distinct_Aggregate;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.SQL.Text := 'SELECT COUNT(DISTINCT Agent) FROM Main';
  FQuery.Open;
  CheckEquals(3, FQuery.Fields[0].AsInteger, 'Distinct Agent Count is incorrect.');
  FQuery.Close;
end;

procedure TTest_Distinct.Test_Distinct_NullRecord;
var D1: TClientDataSet;
begin
  D1 := TClientDataSet.Create(nil);
  try
    with D1 do begin
      FieldDefs.Add('Test1',    ftString, 10);
      CreateDataSet;
      AppendRecord([Null]);
      AppendRecord(['']);
      AppendRecord(['Testing']);
    end;

    FQuery.DataSets.Clear;
    FQuery.AddDataSet(D1, 'Main');

    with FQuery.SQL do begin
      Clear;
      Add('SELECT DISTINCT Test1');
      Add(  'FROM Main');
    end;
    FQuery.Open;
    CheckEquals(2, FQuery.RecordCount);
    FQuery.First;
    CheckEquals('', FQuery['Test1']);
    FQuery.Next;
    CheckEquals('Testing', FQuery['Test1']);
  finally
    D1.Free;
  end;
end;

procedure TTest_Distinct.Test_Distinct_Record;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.SQL.Text := 'SELECT DISTINCT Agent FROM Main ORDER BY Agent';
  FQuery.Open;

  FQuery.First;
  CheckEquals('ABC', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals('DEF', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals('GHI', FQuery.Fields[0].AsString);
  FQuery.Close;
end;

procedure TTest_IN.TTest_IN_SQL;
var lResult: boolean;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'WHERE Agent IN (''ABC'', ''GHI'')');
  end;
  FQuery.Open;

  FQuery.First;
  while not FQuery.Eof do begin
    lResult := SameText(FQuery['Agent'], 'ABC') or SameText(FQuery['Agent'], 'GHI');
    CheckTrue(lResult, 'Return result not true.');
    FQuery.Next;
  end;
  FQuery.Close;
end;

procedure TTest_OrderBy.Test_OrderBy_Desc;
var lLastAgent: string;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'ORDER BY Agent Desc');
  end;
  FQuery.Open;
  FQuery.First;
  lLastAgent := FQuery.FindField('Agent').AsString;
  while not FQuery.Eof do begin
    CheckTrue(FQuery.FindField('Agent').AsString <= lLastAgent, 'Order By Agent Desc error.');
    lLastAgent := FQuery.FindField('Agent').AsString;
    FQuery.Next;
  end;
  FQuery.Close;
end;

procedure TTest_OrderBy.Test_OrderBy_SingleField_Desc;
var lLastDocNo: string;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT Code, DocNo, Agent');
    Add(  'FROM Main');
    Add( 'ORDER BY 2 Desc');
  end;
  FQuery.Open;
  FQuery.First;
  lLastDocNo := FQuery.FindField('DocNo').AsString;
  while not FQuery.Eof do begin
    CheckTrue(FQuery.FindField('DocNo').AsString <= lLastDocNo, 'Order By DocNo Desc error.');
    lLastDocNo := FQuery.FindField('DocNo').AsString;
    FQuery.Next;
  end;
  FQuery.Close;
end;

procedure TTest_OrderBy.Test_OrderBy_MultiField;
var lLastDocNo: string;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT Code, DocNo, Agent');
    Add(  'FROM Main');
    Add( 'WHERE Agent=''ABC''');
    Add( 'ORDER BY Agent, 2 Desc');
  end;
  FQuery.Open;
  FQuery.First;
  lLastDocNo := FQuery.FindField('DocNo').AsString;
  while not FQuery.Eof do begin
    CheckTrue(FQuery.FindField('DocNo').AsString <= lLastDocNo, 'Order By DocNo Desc error.');
    lLastDocNo := FQuery.FindField('DocNo').AsString;
    FQuery.Next;
  end;
  FQuery.Close;
end;

procedure TTest_LIKE.Test_LIKE_EscapeChar_Mix;
begin
  FMainDataSet.Append;
  FMainDataSet.FindField('DocNo').AsString := 'Under_water\Club';
  FMainDataSet.Post;

  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add( 'WHERE DocNo LIKE ''%der\_wa_er\\Club'' ESCAPE ''\'' ');
  end;
  FQuery.Open;
  CheckEquals(1,         FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals('Under_water\Club', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_LIKE.Test_LIKE_Mix;
begin
  FMainDataSet.Append;
  FMainDataSet.FindField('DocNo').AsString := 'Underwater Club';
  FMainDataSet.Post;

  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add( 'WHERE DocNo LIKE ''%Cl_b'' ');
  end;
  FQuery.Open;
  CheckEquals(1,         FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals('Underwater Club', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_LIKE.Test_LIKE_Multiple_Contains;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add( 'WHERE DocNo LIKE ''%002%''');
  end;
  FQuery.Open;
  CheckEquals(1,         FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals('IV-0002', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_LIKE.Test_LIKE_Multiple_EndWith;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add( 'WHERE DocNo LIKE ''%1''');
  end;
  FQuery.Open;
  CheckEquals(1,         FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals('IV-0001', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_LIKE.Test_LIKE_Multiple_StartWith;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DISTINCT Agent');
    Add(  'FROM Main');
    Add( 'WHERE Agent LIKE ''A%''');
  end;
  FQuery.Open;
  CheckEquals(1,     FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals('ABC', FQuery.Fields[0].AsString, 'Agent incorrect.');
  FQuery.Close;
end;

procedure TTest_LIKE.Test_LIKE_Single_Contains_Left;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add( 'WHERE DocNo LIKE ''IV-000_''');
  end;
  FQuery.Open;
  CheckEquals(9,         FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals('IV-0001', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_LIKE.Test_LIKE_Single_Contains_Middle;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add( 'WHERE DocNo LIKE ''I_-0002''');
  end;
  FQuery.Open;
  CheckEquals(1,         FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals('IV-0002', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_LIKE.Test_LIKE_Single_Contains_Right;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add( 'WHERE DocNo LIKE ''_V-0003''');
  end;
  FQuery.Open;
  CheckEquals(1,         FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals('IV-0003', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_GroupBy.Test_GroupBy_SUMQty;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT SUM(Qty) As TotalQty, Agent');
    Add(  'FROM Main');
    Add( 'GROUP BY Agent');
    Add( 'ORDER BY Agent');
  end;
  FQuery.Open;
  CheckEquals(3,  FQuery.RecordCount,         'FQuery Record Count incorrect.');
  FQuery.First;
  CheckEquals(6,  FQuery.Fields[0].AsInteger, 'Total Qty for first agent incorrect.');
  FQuery.Next;
  CheckEquals(22, FQuery.Fields[0].AsInteger, 'Total Qty for second agent incorrect.');
  FQuery.Next;
  CheckEquals(27, FQuery.Fields[0].AsInteger, 'Total Qty for third agent incorrect.');
  FQuery.Close;
end;

procedure TTest_GroupBy.Test_GroupBy_Having;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT SUM(Qty) As TotalQty, Agent');
    Add(  'FROM Main');
    Add( 'GROUP BY Agent');
    Add( 'HAVING SUM(Qty) > 25');
  end;
  FQuery.Open;
  CheckEquals(1,  FQuery.RecordCount,         'FQuery Record Count incorrect.');
  CheckEquals(27, FQuery.Fields[0].AsInteger, 'Total Qty for third agent incorrect.');
  FQuery.Close;
end;

procedure TTest_GroupBy.Test_GroupBy_Division2;
begin
  //this case will fail becoz Count(Code) -> code is a string field, TxQuery not support string field, only support numeric field, refer to Test_GroupBy_Division3
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT SUM(Amount) / Count(*) As Total, Agent');
    Add(  'FROM Main');
    Add( 'WHERE Agent=''ABC''');
    Add( 'GROUP BY Agent');
    Add( 'ORDER BY Agent');
  end;
  FQuery.Open;
  CheckEquals(1,      FQuery.RecordCount,          'FQuery Record Count incorrect.');
  CheckEquals(9.3333, FQuery.Fields[0].AsCurrency, 'Total incorrect.');
  FQuery.Close;
end;

procedure TTest_GroupBy.Test_GroupBy_Division1;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT SUM(Amount) / SUM(Qty) As Total, Agent');
    Add(  'FROM Main');
    Add( 'WHERE Agent=''ABC''');
    Add( 'GROUP BY Agent');
    Add( 'ORDER BY Agent');
  end;
  FQuery.Open;
  CheckEquals(1,      FQuery.RecordCount,          'FQuery Record Count incorrect.');
  CheckEquals(4.6667, FQuery.Fields[0].AsCurrency, 'Total incorrect.');
  FQuery.Close;
end;

procedure TTest_GroupBy.Test_GroupBy_Division3;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT SUM(Amount) / COUNT(Qty) As Total, Agent');
    Add(  'FROM Main');
    Add( 'WHERE Agent=''ABC''');
    Add( 'GROUP BY Agent');
    Add( 'ORDER BY Agent');
  end;
  FQuery.Open;
  CheckEquals(1,      FQuery.RecordCount,          'FQuery Record Count incorrect.');
  CheckEquals(9.3333, FQuery.Fields[0].AsCurrency, 'Total incorrect.');
  FQuery.Close;
end;

procedure TTest_SubQueries.Test_SubQueries_IN_Case1;
begin
  FQuery.DataSetS.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add( 'WHERE Agent IN (SELECT Agent');
    Add(                  'FROM Main');
    Add(                 'WHERE Agent NOT IN (''ABC'', ''DEF''))');
  end;
  FQuery.Open;
  FQuery.First;
  CheckEquals('IV-0008', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals('IV-0009', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals('IV-0010', FQuery.Fields[0].AsString);
  FQuery.Close;
end;

procedure TTest_SubQueries.Test_SubQueries_IN_Case2;
var lDataSet: TClientDataSet;
begin
  lDataSet := TClientDataSet.Create(nil);
  try
    FQuery.DataSets.Clear;
    FQuery.AddDataSet(FMainDataSet, 'Main');
    FQuery.AddDataSet(FDetailDataSet, 'Detail');

    with FQuery.SQL do begin
      Clear;
      Add('SELECT DocKey');
      Add(  'FROM Main');
      Add( 'WHERE DocKey IN (SELECT DISTINCT DocKey');
      Add(                    'FROM Detail)');
    end;
    lDataSet.Data := GetDataPacket(FQuery);
    CheckEquals(2, lDataSet.RecordCount);
    lDataSet.First;
    CheckEquals(1, lDataSet.Fields[0].AsInteger);
    lDataSet.Next;
    CheckEquals(7, lDataSet.Fields[0].AsInteger);
  finally
    lDataSet.Free;
  end;
end;

procedure TTest_SubQueries.Test_SubQueries_NOTIN_Case1;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT Agent');
    Add(  'FROM Main');
    Add( 'WHERE Agent NOT IN (SELECT DISTINCT Agent');
    Add(                       'FROM Main');
    Add(                      'WHERE Agent IN (''ABC'', ''DEF''))');
  end;
  FQuery.Open;
  CheckEquals(3, FQuery.RecordCount);
  FQuery.First;
  CheckEquals('GHI', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals('GHI', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals('GHI', FQuery.Fields[0].AsString);
  FQuery.Close;
end;

procedure TTest_SubQueries.Test_SubQueries_NOTIN_Case2;
var lDataSet: TClientDataSet;
begin
  lDataSet := TClientDataSet.Create(nil);
  try
    FQuery.DataSets.Clear;
    FQuery.AddDataSet(FMainDataSet, 'Main');
    FQuery.AddDataSet(FDetailDataSet, 'Detail');

    with FQuery.SQL do begin
      Clear;
      Add('SELECT DocKey');
      Add(  'FROM Main');
      Add( 'WHERE DocKey NOT IN (SELECT DISTINCT DocKey');
      Add(                        'FROM Detail)');
      Add( 'ORDER BY DocKey');
    end;
    lDataSet.Data := GetDataPacket(FQuery);
    CheckEquals(8, lDataSet.RecordCount, 'Record count incorrect.');
    lDataSet.First;
    CheckEquals(2, lDataSet.Fields[0].AsInteger);
    lDataSet.Next;
    CheckEquals(3, lDataSet.Fields[0].AsInteger);
    lDataSet.Next;
    CheckEquals(4, lDataSet.Fields[0].AsInteger);
    lDataSet.Next;
    CheckEquals(5, lDataSet.Fields[0].AsInteger);
    lDataSet.Next;
    CheckEquals(6, lDataSet.Fields[0].AsInteger);
    lDataSet.Next;
    CheckEquals(8, lDataSet.Fields[0].AsInteger);
    lDataSet.Next;
    CheckEquals(9, lDataSet.Fields[0].AsInteger);
    lDataSet.Next;
    CheckEquals(10, lDataSet.Fields[0].AsInteger);
  finally
    lDataSet.Free;
  end;
end;

procedure TTest_Join.Test_EmptyKeyJoin_InnerJoin;
var D, D1, D2: TClientDataSet;
begin
  D := TClientDataSet.Create(nil);
  D1 := TClientDataSet.Create(nil);
  D2 := TClientDataSet.Create(nil);
  try
    with D1 do begin
      FieldDefs.Add('Test1',    ftString, 10);
      CreateDataSet;
      AppendRecord([Null]);
      AppendRecord(['']);
      AppendRecord(['Testing']);
    end;

    with D2 do begin
      FieldDefs.Add('Test2',    ftString, 10);
      FieldDefs.Add('ItemCode', ftString, 10);
      CreateDataSet;
      AppendRecord([Null, 'Item1']);
      AppendRecord(['', 'Item2']);
      AppendRecord(['Testing', 'Item3']);
    end;

    FQuery.DataSets.Clear;
    FQuery.AddDataSet(D1, 'D1');
    FQuery.AddDataSet(D2, 'D2');

    with FQuery.SQL do begin
      Clear;
      Add('SELECT A.Test1, B.ItemCode');
      Add(  'FROM D1 A INNER JOIN D2 B ON (A.Test1=B.Test2)');
    end;
    D.Data := GetDataPacket(FQuery);
    CheckEquals(3,         D.RecordCount); {null values at left side are discarded automatically}
    D.First;
    CheckTrue(VarIsNull(D['Test1']));
    CheckEquals('Item1',   D['ItemCode']);
    D.Next;
    CheckEquals('',        D['Test1']);
    CheckEquals('Item2',   D['ItemCode']);
    D.Next;
    CheckEquals('Testing', D['Test1']);
    CheckEquals('Item3',   D['ItemCode']);
  finally
    D.Free;
    D1.Free;
    D2.Free;
  end;
end;

procedure TTest_Join.Test_EmptyKeyJoin_LeftOuterJoin;
var D, D1, D2: TClientDataSet;
begin
  D := TClientDataSet.Create(nil);
  D1 := TClientDataSet.Create(nil);
  D2 := TClientDataSet.Create(nil);
  try
    with D1 do begin
      FieldDefs.Add('Test1',    ftString, 10);
      CreateDataSet;
      AppendRecord([Null]);
      AppendRecord(['']);
      AppendRecord(['Testing']);
    end;

    with D2 do begin
      FieldDefs.Add('Test2',    ftString, 10);
      FieldDefs.Add('ItemCode', ftString, 10);
      CreateDataSet;
      AppendRecord([Null, 'Item1']);
      AppendRecord(['', 'Item2']);
    end;

    FQuery.DataSets.Clear;
    FQuery.AddDataSet(D1, 'D1');
    FQuery.AddDataSet(D2, 'D2');

    with FQuery.SQL do begin
      Clear;
      Add('SELECT A.Test1, B.ItemCode');
      Add(  'FROM D1 A LEFT OUTER JOIN D2 B ON (A.Test1=B.Test2)');
    end;
    D.Data := GetDataPacket(FQuery);
    CheckEquals(3,         D.RecordCount);
    D.First;
    CheckTrue(VarIsNull(D['Test1']));
    CheckEquals('Item1',   D['ItemCode']);
    D.Next;
    CheckEquals('',        D['Test1']);
    CheckEquals('Item2',   D['ItemCode']);
    D.Next;
    CheckEquals('Testing', D['Test1']);
    CheckTrue(VarIsNull(D['ItemCode']));
  finally
    D.Free;
    D1.Free;
    D2.Free;
  end;
end;

procedure TTest_Join.Test_JoinTwoDataSets_WithShortAlias;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet,   'Main');
  FQuery.AddDataSet(FDetailDataSet, 'Detail');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT A.DocNo, B.ItemCode');
    Add(  'FROM Main A, Detail B');
    Add( 'WHERE A.DocKey=B.DocKey');
    Add(   'AND A.DocNo=''IV-0007''');
    Add( 'ORDER BY B.ItemCode');
  end;
  FQuery.Open;
  CheckEquals(2, FQuery.RecordCount, 'FQuery Record Count incorrect');
  FQuery.First;
  CheckEquals('IV-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals('Item4', FQuery.FindField('ItemCode').AsString);
  FQuery.Next;
  CheckEquals('IV-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals('Item5', FQuery.FindField('ItemCode').AsString);
  FQuery.Close;
end;

procedure TTest_Join.Test_JoinTwoDataSets_WithTableAlias;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet,   'Main');
  FQuery.AddDataSet(FDetailDataSet, 'Detail');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT Main.DocNo, Detail.ItemCode');
    Add(  'FROM Main, Detail');
    Add( 'WHERE Main.DocKey=Detail.DocKey');
    Add(   'AND Main.DocNo=''IV-0007''');
    Add( 'ORDER BY Detail.ItemCode');
  end;
  FQuery.Open;
  CheckEquals(2, FQuery.RecordCount, 'FQuery Record Count incorrect');
  FQuery.First;
  CheckEquals('IV-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals('Item4', FQuery.FindField('ItemCode').AsString);
  FQuery.Next;
  CheckEquals('IV-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals('Item5', FQuery.FindField('ItemCode').AsString);
  FQuery.Close;
end;

procedure TTest_Join.Test_JoinTwoDataSets_InnerJoin;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet,   'Main');
  FQuery.AddDataSet(FDetailDataSet, 'Detail');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT A.DocNo, B.ItemCode');
    Add(  'FROM Main A INNER JOIN Detail B ON (A.DocKey=B.DocKey)');
    Add( 'WHERE A.DocNo=''IV-0007''');
    Add( 'ORDER BY B.ItemCode');
  end;
  FQuery.Open;
  CheckEquals(2, FQuery.RecordCount, 'FQuery Record Count incorrect');
  FQuery.First;
  CheckEquals('IV-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals('Item4', FQuery.FindField('ItemCode').AsString);
  FQuery.Next;
  CheckEquals('IV-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals('Item5', FQuery.FindField('ItemCode').AsString);
  FQuery.Close;
end;

procedure TTest_Join.Test_JoinTwoDataSets_LeftOuterJoin;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet,   'Main');
  FQuery.AddDataSet(FDetailDataSet, 'Detail');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT A.DocNo, B.ItemCode');
    Add(  'FROM Main A LEFT OUTER JOIN Detail B ON (A.DocKey=B.DocKey)');
    Add( 'ORDER BY B.ItemCode');
  end;
  FQuery.Open;
  CheckEquals(13, FQuery.RecordCount, 'FQuery Record Count incorrect');
  FQuery.Close;
end;

procedure TTest_Join.Test_JoinTwoDataSets_LeftOuterJoin_MoreCondition;
var lDataSet: TClientDataSet;
begin
  lDataSet := TClientDataSet.Create(nil);
  try
    with lDataSet do begin
      FieldDefs.Add('DocKey',   ftInteger,  0);
      FieldDefs.Add('Agent',    ftString,  10);
      CreateDataSet;

      Append;
      FindField('DocKey').AsInteger := 2;
      FindField('Agent').AsString := 'ABC';
      Post;

      Append;
      FindField('DocKey').AsInteger := 4;
      FindField('Agent').AsString := 'DEF';
      Post;
    end;

    FQuery.DataSets.Clear;
    FQuery.AddDataSet(FMainDataSet,   'Main');
    FQuery.AddDataSet(lDataSet,       'Detail');

    with FQuery.SQL do begin
      Clear;
      Add('SELECT A.DocNo, B.Agent');
      Add(  'FROM Main A LEFT OUTER JOIN Detail B ON (A.DocKey=B.DocKey) AND (A.Agent=B.Agent)');   //not support condition more than one when left outer join
    end;
    FQuery.Open;
    CheckEquals(10, FQuery.RecordCount, 'FQuery Record Count incorrect');
    FQuery.Close;
  finally
    lDataSet.Free;
  end;
end;

procedure TTest_Union.Test_UnionSQL;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'WHERE Agent=''ABC''');
    Add( 'UNION');
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'WHERE Agent=''DEF''');
  end;
  FQuery.Open;
  CheckEquals(7, FQuery.RecordCount, 'FQuery Record Count incorrect');
  FQuery.Close;
end;

procedure TTest_Update.Test_UpdateSingleField;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('UPDATE Main');
    Add(   'SET Agent=''XYZ''');
  end;
  FQuery.ExecSQL;

  CheckEquals(10, FMainDataSet.RecordCount, 'FMainDataSet Record Count incorrect');

  FMainDataSet.First;
  while not FMainDataSet.Eof do begin
    CheckEquals('XYZ', FMainDataSet.FindField('Agent').AsString, 'Field "Agent" incorrect');
    FMainDataSet.Next;
  end;
end;

procedure TTest_Update.Test_UpdateMultiField;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('UPDATE Main');
    Add(   'SET Agent=''SHERLYN''');
    Add(     ', DocNo=''IV-2000''');
  end;
  FQuery.ExecSQL;

  CheckEquals(10, FMainDataSet.RecordCount, 'FMainDataSet Record Count incorrect');

  FMainDataSet.First;
  while not FMainDataSet.Eof do begin
    CheckEquals('SHERLYN', FMainDataSet.FindField('Agent').AsString, 'Field "Agent" incorrect');
    CheckEquals('IV-2000', FMainDataSet.FindField('DocNo').AsString, 'Field "DocNo" incorrect');
    FMainDataSet.Next;
  end;
end;

procedure TTest_Update.Test_Update_WithCondition;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('UPDATE Main');
    Add(   'SET Agent=''XYZ''');
    Add( 'WHERE DocNo=''IV-0001''');
  end;
  FQuery.ExecSQL;

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'WHERE Agent=''XYZ''');
  end;
  FQuery.Open;
  CheckEquals(1,         FQuery.RecordCount,                 'FQuery Record Count incorrect');
  CheckEquals('XYZ',     FQuery.FindField('Agent').AsString, 'Field "Agent" incorrect');
  CheckEquals('IV-0001', FQuery.FindField('DocNo').AsString, 'Field "DocNo" incorrect');
  FQuery.Close;
end;

procedure TTest_Update.Test_Update_WithSubQueries;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.AddDataSet(FDetailDataSet, 'Detail');

  with FQuery.SQL do begin
    Clear;
    Add('UPDATE Main');
    Add(   'SET Agent=''XYZ''');
    Add( 'WHERE DocKey IN (SELECT DocKey FROM Detail)');
  end;
  FQuery.ExecSQL;

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'WHERE Agent=''XYZ''');
    Add(  'ORDER BY DocKey');
  end;
  FQuery.Open;

  CheckEquals(2, FQuery.RecordCount,                   'FQuery Record Count incorrect');
  FQuery.First;
  CheckEquals(1, FQuery.FindField('DocKey').AsInteger, 'Record 1 Field "DocKey" incorrect');
  FQuery.Next;
  CheckEquals(7, FQuery.FindField('DocKey').AsInteger, 'Record 2 Field "DocKey" incorrect');
  FQuery.Close;
end;

procedure TTest_Update.Test_Update_Arithmetic;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.AddDataSet(FDetailDataSet, 'Detail');

  with FQuery.SQL do begin
    Clear;
    Add('UPDATE Main');
    Add(   'SET Amount=Amount + 1');
    Add( 'WHERE DocKey IN (SELECT DocKey FROM Detail)');
  end;
  FQuery.ExecSQL;

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'WHERE DocKey IN (SELECT DISTINCT DocKey FROM Detail)');
    Add(  'ORDER BY DocKey');
  end;
  FQuery.Open;

  CheckEquals(2, FQuery.RecordCount,                   'FQuery Record Count incorrect');
  FQuery.First;
  CheckEquals(3, FQuery.FindField('Amount').AsCurrency, 'Record 1 Field "DocKey" incorrect');
  FQuery.Next;
  CheckEquals(99, FQuery.FindField('Amount').AsCurrency, 'Record 2 Field "DocKey" incorrect');
  FQuery.Close;
end;

procedure TTest_Update.Test_Update_OneCentDiffBug;
var D: TClientDataSet;
begin
  //Use FmtBcd will fail in this case
  D := TClientDataSet.Create(nil);
  try
    with D do begin
      FieldDefs.Add('Test1', ftFmtBcd, 0);
      FieldDefs.Add('Test2', ftFmtBcd, 0);
      FieldDefs.Add('Test3', ftFmtBcd, 0);
      with FieldDefs.Find('Test1') do begin
        Precision := 18;
        Size := 2;
      end;
      with FieldDefs.Find('Test2') do begin
        Precision := 18;
        Size := 2;
      end;
      with FieldDefs.Find('Test3') do begin
        Precision := 18;
        Size := 2;
      end;
      CreateDataSet;
      AppendRecord([31067.50, -30953.86, 0]);
    end;

    FQuery.DataSets.Clear;
    FQuery.AddDataSet(D, 'Main');

    with FQuery.SQL do begin
      Clear;
      Add('UPDATE Main');
      Add(   'SET Test3 = Test1 + Test2');
    end;
    FQuery.ExecSQL;

    CheckEquals(1, D.RecordCount);
    CheckEquals(113.64, D.FindField('Test3').Value, SglEps);
  finally
    D.Free;
  end;

  //Alternate solution for the problem above (use ftBcd)
  //Note: D.FindField('Test3').Value will return incorrect value, so use AsCurrency for this case
  D := TClientDataSet.Create(nil);
  try
    with D do begin
      FieldDefs.Add('Test1', ftBcd, 0);
      FieldDefs.Add('Test2', ftBcd, 0);
      FieldDefs.Add('Test3', ftBcd, 0);
      with FieldDefs.Find('Test1') do begin
        Precision := 18;
        Size := 2;
      end;
      with FieldDefs.Find('Test2') do begin
        Precision := 18;
        Size := 2;
      end;
      with FieldDefs.Find('Test3') do begin
        Precision := 18;
        Size := 2;
      end;
      CreateDataSet;
      AppendRecord([31067.50, -30953.86, 0]);
    end;

    FQuery.DataSets.Clear;
    FQuery.AddDataSet(D, 'Main');

    with FQuery.SQL do begin
      Clear;
      Add('UPDATE Main');
      Add(   'SET Test3 = Test1 + Test2');
    end;
    FQuery.ExecSQL;

    CheckEquals(1, D.RecordCount);
    CheckEquals(113.64, D.FindField('Test3').AsCurrency);
  finally
    D.Free;
  end;
end;

procedure TTest_Delete.Test_Delete_WithCondition;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('DELETE FROM Main');
    Add( 'WHERE DocNo=''IV-0001''');
  end;
  FQuery.ExecSQL;
  CheckEquals(9, FMainDataSet.RecordCount, 'FMainDataSet Record Count incorrect');
  CheckFalse(FMainDataSet.Locate('DocNo', 'IV-0001', []), 'Record still exists even has been deleted');
end;

procedure TTest_Delete.Test_Delete_WithSubQueries;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.AddDataSet(FDetailDataSet, 'Detail');

  with FQuery.SQL do begin
    Clear;
    Add('DELETE FROM Main');
    Add( 'WHERE DocKey IN (SELECT DocKey FROM Detail)');
  end;
  FQuery.ExecSQL;
  CheckEquals(8, FMainDataSet.RecordCount, 'FMainDataSet Record Count incorrect');
  CheckFalse(FMainDataSet.Locate('DocKey', 1, []), 'Record DocKey = 1 still exists even has been deleted');
  CheckFalse(FMainDataSet.Locate('DocKey', 7, []), 'Record DocKey = 7 still exists even has been deleted');
end;

procedure TTest_Insert.Test_Insert_AllFields;
var D: TClientDataSet;
begin
  D := TClientDataSet.Create(nil);
  try
    D.FieldDefs.Assign(FMainDataSet.FieldDefs);
    D.CreateDataSet;

    FQuery.DataSets.Clear;
    FQuery.AddDataSet(FMainDataSet, 'Main');
    FQuery.AddDataSet(D, 'Data');

    with FQuery.SQL do begin
      Clear;
      Add('INSERT INTO Data (*)');
      Add('(SELECT DocKey, "" Code, "" DocNo, DocDate, 0 DocTime,');
      Add(        '0 DocDateTime, 0 DocTimeStamp, "" Agent, 0 Qty, 0 UnitPrice, 0 Amount,');
      Add(        '"" WDocNo, "" Memo, "" WMemo, 0 LargeKey, false RecordActive' );
      Add( 'FROM Main)');
    end;
    FQuery.ExecSQL;

    FMainDataSet.Append;
    FMainDataSet.FindField('DocKey').AsInteger := 11;
    FMainDataSet.FindField('DocDate').AsDateTime := Date;
    FMainDataSet.FindField('DocDate').AsFloat;
    FMainDataSet.Post;

    FQuery.ExecSQL;
    CheckEquals(10 + FMainDataSet.RecordCount, D.RecordCount );

    D.Last;
    CheckEquals(Date, D.FindField('DocDate').AsDateTime);
    CheckEquals(11, D.FindField('DocKey').AsInteger);
  finally
    D.Free;
  end;
end;

procedure TTest_Insert.Test_Insert_BlankDataSet;
var D1, D2: TClientDataSet;
begin
  D1 := TClientDataSet.Create(nil);
  D2 := TClientDataSet.Create(nil);
  try
    with D1 do begin
      FieldDefs.Add('Code', ftString, 10);
      FieldDefs.Add('Qty',  ftCurrency, 0);
      CreateDataSet;
    end;
    D2.FieldDefs.Assign(D1.FieldDefs);
    D2.CreateDataSet;

    FQuery.DataSets.Clear;
    FQuery.AddDataSet(D1, 'Main');
    FQuery.AddDataSet(D2, 'Document');

    with FQuery.SQL do begin
      Clear;
      Add('INSERT INTO Main (Code, Qty)');
      Add('(SELECT Code, SUM(Qty)');
      Add(  'FROM Document');
      Add( 'GROUP BY Code)');
    end;
    FQuery.ExecSQL;
    CheckEquals(0, D1.RecordCount);
  finally
    D1.Free;
    D2.Free;
  end;
end;

procedure TTest_Insert.Test_Insert_WithSelectSQL;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('INSERT INTO Main (Code, DocNo, Agent, Amount)');
    Add('(SELECT Code, DocNo, Agent, Amount');
    Add(  'FROM Main');
    Add( 'WHERE Agent=''ABC'')');
  end;
  FQuery.ExecSQL;
  CheckEquals(13, FMainDataSet.RecordCount, 'FMainDataSet RecordCount incorrect');
end;

procedure TTest_Insert.Test_Insert_WithValues;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('INSERT INTO Main (Code, DocNo, Agent, Amount)');
    Add('VALUES(''400-000'', ''CS-0001'', ''XYZ'', ''400'')');
  end;
  FQuery.ExecSQL;
  CheckEquals(11, FMainDataSet.RecordCount, 'FMainDataSet RecordCount incorrect');
  CheckTrue(FMainDataSet.Locate('DocNo', 'CS-0001', []), 'CS-0001 not found');
  //since the above statement CheckTrue is pass then the following record has been point to CS-0001
  CheckEquals('400-000', FMainDataSet.FindField('Code').AsString,     'Field "Code" incorrect');
  CheckEquals('XYZ',     FMainDataSet.FindField('Agent').AsString,    'Field "Agent" incorrect');
  CheckEquals(400,       FMainDataSet.FindField('Amount').AsCurrency, 'Field "Amount" incorrect');
end;

procedure TTest_Max.Test_Max;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT MAX(Amount)');
    Add(  'FROM Main');
  end;
  FQuery.Open;
  CheckEquals(200, FQuery.Fields[0].AsInteger, 'Max Result incorrect');
  FQuery.Close;
end;

procedure TTest_Max.Test_Max_WithCondition;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT MAX(Amount)');
    Add(  'FROM Main');
    Add( 'WHERE Agent=''ABC''');
  end;
  FQuery.Open;
  CheckEquals(18, FQuery.Fields[0].AsInteger, 'Max Result incorrect');
  FQuery.Close;
end;


procedure TTest_Max.Test_String;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT MAX(Code)');
    Add(  'FROM Main');
  end;
  FQuery.Open;
  CheckEquals('300-9', FQuery.Fields[0].AsString);
  FQuery.Close;
end;

procedure TTest_Min.Test_Min;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT MIN(Amount)');
    Add(  'FROM Main');
  end;
  FQuery.Open;
  CheckEquals(2, FQuery.Fields[0].AsInteger, 'Min Result incorrect');
  FQuery.Close;
end;

procedure TTest_Min.Test_Min_WithCondition;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT MIN(Amount)');
    Add(  'FROM Main');
    Add( 'WHERE Agent=''GHI''');
  end;
  FQuery.Open;
  CheckEquals(128, FQuery.Fields[0].AsInteger, 'Min Result incorrect');
  FQuery.Close;
end;

procedure TTest_Min.Test_String;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT MIN(Code)');
    Add(  'FROM Main');
  end;
  FQuery.Open;
  CheckEquals('300-1', FQuery.Fields[0].AsString);
  FQuery.Close;
end;

procedure TTest_Extract.Test_ExtractSQL;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT EXTRACT(YEAR FROM DocDate) AS YY,');
    Add(       'EXTRACT(MONTH FROM DocDate) AS MM,');
    Add(       'EXTRACT(DAY FROM DocDate) AS DD');
    Add(  'FROM Main');
    Add( 'WHERE DocNo=''IV-0002''');
  end;
  FQuery.Open;
  CheckEquals(1,    FQuery.RecordCount,               'FQuery Record Count incorrect.');
  CheckEquals(2005, FQuery.FindField('YY').AsInteger, 'Field "YY" incorrect');
  CheckEquals(5,    FQuery.FindField('MM').AsInteger, 'Field "MM" incorrect');
  CheckEquals(7,    FQuery.FindField('DD').AsInteger, 'Field "DD" incorrect');
  FQuery.Close;
end;

procedure TTest_Extract.Test_ExtractSQL_Condition;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'WHERE (EXTRACT(DAY FROM DocDate)=8)');
  end;
  FQuery.Open;
  CheckEquals(1,         FQuery.RecordCount,                 'FQuery Record Count incorrect.');
  CheckEquals('IV-0003', FQuery.FindField('DocNo').AsString, 'Field "DocNo" incorrect');
  FQuery.Close;
end;

procedure TTest_ParamByName.Test_ParamByName;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  FQuery.SQL.Text := 'UPDATE Main SET Agent=:Agent WHERE DocNo=:DocParam';
  FQuery.ParamByName('Agent').AsString := 'XYZ';
  FQuery.ParamByName('DocParam').AsString := 'IV-0001';
  FQuery.ExecSQL;

  CheckTrue(FMainDataSet.Locate('DocNo', 'IV-0001', []));
  CheckEquals('XYZ', FMainDataSet.FindField('Agent').AsString, 'Field "Agent" incorrect');
end;

procedure TTest_Fields.Test_Boolean_Fields_False;
begin
 CreateTestData;
 FQuery.DataSets.Clear;
 FQuery.AddDataSet(FMainDataSet, 'Main');
 FQuery.SQL.Text := 'SELECT * From Main WHERE RecordActive=False';
 FQuery.Open;
 FQuery.First;
 CheckEquals(FQuery.RecordCount,5, 'RecordCount Where RecordActive=False');
 CheckEquals(Ord(ftBoolean), Ord(FQuery.FindField('RecordActive').DataType),'RecordCount Where Active=False');
 while not FQuery.Eof do
 begin
  CheckEquals(false, FQuery.FindField('RecordActive').AsBoolean, 'Record '+Inttostr(FQuery.Recno)+': [Boolean] Field Value');
  FQuery.Next;
 end;
end;

procedure TTest_Fields.Test_Boolean_Fields_True;
begin
 CreateTestData;
 FQuery.DataSets.Clear;
 FQuery.AddDataSet(FMainDataSet, 'Main');
 FQuery.SQL.Text := 'SELECT * From Main WHERE RecordActive';
 FQuery.Open;
 FQuery.First;
 CheckEquals(FQuery.RecordCount,5, 'RecordCount Where RecordActive=True');
 while not FQuery.Eof do
 begin
  CheckEquals(true, FQuery.FindField('RecordActive').AsBoolean, 'Record '+Inttostr(FQuery.Recno)+': [Boolean] Field Value');
  FQuery.Next;
 end;
end;

procedure TTest_Fields.Test_Calculated_Fields;
var i: integer;
    fld: TField;
    testMsg: string;
begin
 SetupDataSets(true, true);
 //CreateTestData(True);
 with FQuery do
 begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.SQL.Text := 'SELECT * From Main';
  FQuery.Open;
  First;
  while  not eof do
  begin
   for I := 0 to  Fields.Count-1 do
   begin
    if not (Fields[i].FieldKind=fkData) then
       continue;
    fld := FindField('CALC_'+Fields[i].FieldName);
    if not Assigned(fld) then
       Continue;
    testMsg := 'Record '+IntToStr(FQuery.RecNo)+ ': Comparing Fields ['+Fields[i].FieldName+']  Vs.  ['+fld.FieldName+']';
    if fld.DataType in [ftString, ftFixedChar] then
       CheckEquals( Fields[i].AsString, fld.AsString, testMsg );
    if fld.DataType in [ftWideString, ftFixedWideChar] then
       CheckEquals( Fields[i].AsWideString, fld.AsWideString, testMsg );
    if fld.DataType = ftDate then
       CheckEquals( FormatDateTime('yyyy-mm-dd', Fields[i].AsDateTime, GetUSFormatSettings),
                    FormatDateTime('yyyy-mm-dd', fld.AsDateTime, GetUSFormatSettings) , testMsg );
    if fld.DataType = ftTime then
       CheckEquals( FormatDateTime('HH:nn:ss', Fields[i].AsDateTime, GetUSFormatSettings),
                    FormatDateTime('HH:nn:ss', fld.AsDateTime, GetUSFormatSettings) , testMsg );
    if fld.DataType = ftDateTime then
       CheckEquals( FormatDateTime('yyyy-mm-dd HH:nn:ss', Fields[i].AsDateTime, GetUSFormatSettings),
                    FormatDateTime('yyyy-mm-dd HH:nn:ss', fld.AsDateTime, GetUSFormatSettings) , testMsg );
    if fld.DataType in [ftFloat, ftFMTBcd] then
       CheckEquals( Fields[i].AsFloat, fld.AsFloat, testMsg );
    if fld.DataType in [ftInteger{$IFDEF Delphi2010Up}, ftShortInt{$ENDIF}] then
       CheckEquals( Fields[i].AsInteger, fld.AsInteger, testMsg );
    if fld.DataType in [ftLargeint] then
       CheckTrue( Fields[i].{$IFDEF Delphi2010Up}AsLargeInt{$ELSE}Value{$ENDIF} = fld.{$IFDEF Delphi2010Up}AsLargeInt{$ELSE}Value{$ENDIF}, testMsg );
   end;
   Next;
  end;
 end;
 FMainDataSet.AutoCalcFields := false;
 FMainDataSet.OnCalcFields := nil;
end;

procedure TTest_Fields.Test_Date;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.SQL.Text := Format('SELECT * FROM Main WHERE DocDate = #%s#', [FormatDateTime(FQuery.DateFormat, FDate)]);
  FQuery.Open;
end;

procedure TTest_Fields.Test_Is_Null;
var i: integer;
    S: string;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  for i := 0 to FMainDataSet.Fields.Count - 1 do begin
    S := Format('SELECT * FROM Main WHERE (%s IS NULL) AND (%s IS NOT NULL)', [FMainDataSet.Fields[i].FieldName, FMainDataSet.Fields[i].FieldName]);
    FQuery.SQL.Text := S;
    FQuery.Open;
    FQuery.Close;
  end;
end;

procedure TTest_Fields.Test_LargeInteger_Fields;
begin
{$IFDEF Delphi2010Up}
 CreateTestData;
 FQuery.DataSets.Clear;
 FQuery.AddDataSet(FMainDataSet, 'Main');
 FQuery.SQL.Text := 'SELECT LargeKey From Main ORDER BY LargeKey DESC';
 FQuery.Open;
 FQuery.First;
 FMainDataSet.Last;
 while not FQuery.Eof do
 begin
  CheckEquals(FMainDataSet.FindField('LargeKey').AsLargeInt, FQuery.Fields[0].AsLargeInt, 'Record '+Inttostr(FQuery.recno)+': [LargeKey] Field Value');
  FQuery.Next;
  FMainDataSet.Prior;
 end;
 {$ENDIF}
end;

procedure TTest_Fields.Test_MaxString;
begin
  FMainDataSet.EmptyDataSet;
  FMainDataSet.Append;
  FMainDataSet.FindField('Code').AsString := DupeString('A', FMainDataSet.FindField('Code').Size);
  FMainDataSet.FindField('Agent').AsString := DupeString('B', FMainDataSet.FindField('Agent').Size);
  FMainDataSet.FindField('DocNo').AsString := DupeString('C', FMainDataSet.FindField('DocNo').Size);
  FMainDataSet.FindField('WDocNo').AsString := DupeString('D', FMainDataSet.FindField('WDocNo').Size);
  FMainDataSet.Post;

  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.SQL.Text := 'SELECT Code, Agent, DocNo, WDocNo From Main';
  FQuery.Open;
  CheckEquals(FMainDataSet.FindField('Code').AsString, FQuery.Fields[0].AsString);
  CheckEquals(FMainDataSet.FindField('Agent').AsString, FQuery.Fields[1].AsString);
  CheckEquals(FMainDataSet.FindField('DocNo').AsString, FQuery.Fields[2].AsString);
  CheckEquals(FMainDataSet.FindField('WDocNo').AsString, FQuery.Fields[3].AsString);
end;

procedure TTest_Fields.Test_Memo_Fields;
var F1, F2: TField;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  FQuery.SQL.Text := 'SELECT Memo, WMemo From Main';
  FQuery.Open;

  F1 := FMainDataSet.FindField('Memo');
  F2 := FQuery.Fields[0];
  CheckTrue(F1.DataType = F2.DataType, 'Memo DataType');
  CheckEquals(F1.DataSize, F2.DataSize, 'Memo DataSize');

  F1 := FMainDataSet.FindField('WMemo');
  F2 := FQuery.Fields[1];
  CheckTrue(F1.DataType = F2.DataType, 'Memo DataType');
  CheckEquals(F1.DataSize, F2.DataSize, 'WMemo DataSize');
end;

procedure TTest_Fields.Test_OrderBy_WideString_Field;
var i: integer;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet,   'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'ORDER BY WDocNo');
  end;
  FQuery.Open;
  CheckEquals(10, FQuery.RecordCount, 'FQuery Record Count incorrect');
  for i := 1 to FQuery.RecordCount do begin
    CheckEquals(Format('IV-%.4d', [i]), FQuery.FindField('WDocNo').AsString);
    FQuery.Next;
  end;
end;

procedure TTest_Fields.Test_Required_Fields;
var D: TClientDataSet;
begin
  D := TClientDataSet.Create(nil);
  try
    D.FieldDefs.Add('DocKey', ftInteger, 0, True);
    D.CreateDataSet;

    FQuery.DataSets.Clear;
    FQuery.AddDataSet(FMainDataSet, 'Main');
    FQuery.AddDataSet(D, 'Data');
    FQuery.SQL.Text := 'INSERT INTO Data (DocKey) (SELECT DocKey FROM Main)';
    FQuery.ExecSQL;
  finally
    D.Free;
  end;
end;

procedure TTest_Fields.Test_String_Fields;
var F1, F2: TField;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  FQuery.SQL.Text := 'SELECT DocNo, Agent, WDocNo From Main';
  FQuery.Open;

  F1 := FMainDataSet.FindField('DocNo');
  F2 := FQuery.Fields[0];
  CheckTrue(F1.DataType = F2.DataType, 'DocNo DataType');
  CheckEquals(F1.Size, F2.Size, 'DocNo Size');
  CheckEquals(F1.DataSize, F2.DataSize, 'DocNo DataSize');

  F1 := FMainDataSet.FindField('Agent');
  F2 := FQuery.Fields[1];
  CheckTrue(F1.DataType = F2.DataType, 'Agent DataType');
  CheckEquals(F1.Size, F2.Size, 'Agent Size');
  CheckEquals(F1.DataSize, F2.DataSize, 'Agent DataSize');

  F1 := FMainDataSet.FindField('WDocNo');
  F2 := FQuery.Fields[2];
  CheckTrue(F1.DataType = F2.DataType, 'WDocNo DataType');
  CheckEquals(F1.Size, F2.Size, 'WDocNo Size');
  CheckEquals(F1.DataSize, F2.DataSize, 'WDocNo DataSize');
end;

function TTest_DateTime.CanCreateCalcFields: boolean;
begin
 result := true;
end;

procedure TTest_DateTime.Test_ExtractDate;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
   with FQuery.SQL do begin
    Clear;
    Add(         'SELECT ''P'' || EXTRACT(YEAR FROM DocDate) || ''_'' || EXTRACT(MONTH FROM DocDate) AS Period');
    Add(           'FROM Main');
    Add(          'WHERE DocKey=1');
  end;
  FQuery.Open;
  CheckEquals(1, FQuery.RecordCount);
  CheckEquals('P2005_5', FQuery.Fields[0].AsString);
end;

procedure TTest_DateTime.Test_FormatDateTime1;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add(         'SELECT FormatDateTime("yyyy-mm", DocDate) AS Interval');
    Add(           'FROM Main');
    Add(          'WHERE DocKey=1');
  end;
  FQuery.Open;
  CheckEquals(1, FQuery.RecordCount);
  CheckEquals('2005-05', FQuery.Fields[0].AsString);
end;

procedure TTest_DateTime.Test_FormatDateTime2;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add(         'SELECT *');
    Add(           'FROM Main');
    Add(Format(   'WHERE FormatDateTime("yyyymmdd", DocDate) < %s', [FormatDateTime('yyyymmdd', IncDay(FDate, 2), GetUSFormatSettings)]));
  end;
  FQuery.Open;
  CheckEquals(1, FQuery.RecordCount);
end;

procedure TTest_DateTime.Test_SelectAll;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add(         'SELECT Main.*, FormatDateTime("yyyymmddHHnnsszzz", DocTimeStamp) as DocTimeStampFMT' ) ;
    Add(           'FROM Main');
    Add(Format(   'WHERE FormatDateTime("yyyymmdd", DocTimeStamp) < %s', [FormatDateTime('yyyymmdd', IncDay(FDate, 2), GetUSFormatSettings)]));
  end;
  FQuery.Open;
  CheckEquals(1, FQuery.RecordCount);
  CheckEquals(FQuery.FieldByName('DocTimeStamp').AsFloat, FQuery.FieldByName('CALC_DocTimeStamp').AsFloat);
end;

procedure TTest_DateTime.Test_StrToDate;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add(         'SELECT *');
    Add(           'FROM Main');
    Add(Format(   'WHERE DocDate >= StrToDate( ''%s'' )', [FormatDateTime(FQuery.DateFormat, IncDay(FDate, 6), FQuery.SystemFormatSettings)]));
  end;
  FQuery.Open;
  CheckEquals(5, FQuery.RecordCount);
end;

procedure TTest_Hardcode_String.Test_Hardcode_String_Select;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add(         'SELECT "a"');
    Add(           'FROM Main');
  end;
  FQuery.Open;
  CheckEquals(FMainDataSet.RecordCount, FQuery.RecordCount);
end;

procedure TTest_Select.Test_HasEmptyDataSet;
var D: TClientDataSet;
begin
  D := TClientDataSet.Create(nil);
  try
    D.FieldDefs.Assign(FMainDataSet.FieldDefs);
    D.CreateDataSet;

    FQuery.DataSets.Clear;
    FQuery.AddDataSet(FMainDataSet, 'Main');
    FQuery.AddDataSet(D, 'Data');
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT * FROM Main');
    FQuery.Open;

    CheckTrue(FQuery.Active);
  finally
    D.Free;
  end;
end;

procedure TTest_Select.Test_MaxLengthPerLine;
var S: string;
    i: integer;
begin
  // Max length per single line in SQL Statement define in "procedure readln" of unit QLexLib is 256 characters
  // The buffer size should increase automatically if it reach the limit
  
  S := FMainDataSet.Fields[0].FieldName;
  while Length(S) < 1024 do begin
    for i := 1 to FMainDataSet.Fields.Count - 1 do
      S := S + ', ' + FMainDataSet.Fields[i].FieldName;
  end;

  S := Format('SELECT %s FROM Main', [S]);

  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.SQL.Text := S;
  FQuery.Open;
end;

procedure TTest_DirectAccess.SetUp;
begin
  inherited;
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.SQL.Text := 'SELECT * FROM Main';
  FQuery.Open;
end;

procedure TTest_DirectAccess.Test_AnsiString;
begin
  FQuery.Edit;
  FQuery.FindField('DocNo').AsString := 'NewValue';
  FQuery.Post;
  CheckEquals('NewValue', FQuery.FindField('DocNo').AsString);
end;

procedure TTest_DirectAccess.Test_Boolean;
begin
  FQuery.Edit;
  FQuery.FindField('RecordActive').AsBoolean := True;
  FQuery.Post;
  CheckTrue(FQuery.FindField('RecordActive').AsBoolean);

  FQuery.Edit;
  FQuery.FindField('RecordActive').AsBoolean := False;
  FQuery.Post;
  CheckFalse(FQuery.FindField('RecordActive').AsBoolean);
end;

procedure TTest_DirectAccess.Test_Date;
begin
  FQuery.Edit;
  FQuery.FindField('DocDate').AsDateTime := Date;
  FQuery.Post;
  CheckEquals(Date, FQuery.FindField('DocDate').AsDateTime);
end;

procedure TTest_DirectAccess.Test_DateTime;
var T: TDateTime;
begin
  T := Now;
  FQuery.Edit;
  FQuery.FindField('DocDateTime').AsDateTime := T;
  FQuery.Post;
  CheckEquals(T, FQuery.FindField('DocDateTime').AsDateTime);
end;

procedure TTest_DirectAccess.Test_FmtBcd;
var B: TBcd;
begin
  B := StrToBcd('999');
  FQuery.Edit;
  FQuery.FindField('Qty').AsBCD := B;
  FQuery.Post;
  CheckEquals(0, BcdCompare(B, FQuery.FindField('Qty').AsBcd));
end;

procedure TTest_DirectAccess.Test_Integer;
begin
  FQuery.Edit;
  FQuery.FindField('DocKey').AsInteger := High(Integer);
  FQuery.Post;
  CheckEquals(High(Integer), FQuery.FindField('DocKey').AsInteger);
end;

procedure TTest_DirectAccess.Test_LargeInt;
var F: TLargeintField;
begin
  FQuery.Edit;
  F := FQuery.FindField('LargeKey') as TLargeintField;
  F.Value := High(Int64);
  FQuery.Post;
  CheckEquals(High(Int64), F.Value);
end;

procedure TTest_DirectAccess.Test_Memo;
begin
{$IFDEF XQ_USE_NEW_BLOB_STORAGE}
  FQuery.Edit;
  FQuery.FindField('Memo').AsString := 'NewValue';
  FQuery.Post;
  CheckEquals('NewValue', FQuery.FindField('Memo').AsString);
{$ENDIF}
end;

procedure TTest_DirectAccess.Test_Time;
var T: TDateTime;
begin
  T := Time;
  FQuery.Edit;
  FQuery.FindField('DocTime').AsDateTime := T;
  FQuery.Post;
  CheckEquals(T, FQuery.FindField('DocTime').AsDateTime);
end;

procedure TTest_DirectAccess.Test_TimeStamp;
{$ifdef Delphi2009}var T: TSQLTimeStamp;{$endif}
begin
{$ifdef Delphi2009}
  T := DateTimeToSQLTimeStamp(Now);
  FQuery.Edit;
  FQuery.FindField('DocTimeStamp').AsSQLTimeStamp := T;
  FQuery.Post;
  CheckEquals(SQLTimeStampToDateTime(T), SQLTimeStampToDateTime(FQuery.FindField('DocTimeStamp').AsSQLTimeStamp));
{$endif}
end;

procedure TTest_DirectAccess.Test_WideMemo;
begin
{$IFDEF XQ_USE_NEW_BLOB_STORAGE}
  FQuery.Edit;
  FQuery.FindField('WMemo').AsWideString := 'NewValue';
  FQuery.Post;
  CheckEquals('NewValue', FQuery.FindField('WMemo').AsWideString);
{$ENDIF}
end;

procedure TTest_DirectAccess.Test_WideString;
begin
  FQuery.Edit;
  FQuery.FindField('WDocNo').AsWideString := 'NewValue';
  FQuery.Post;
  CheckEquals('NewValue', FQuery.FindField('WDocNo').AsWideString);
end;

procedure TTest_Clone.Execute(const aFieldNames: string);
var i: integer;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.AddDataSet(FCloneDataSet, 'Data');
  FQuery.SQL.Text := Format('INSERT INTO Data (%s) (SELECT %s FROM Main)', [aFieldNames, aFieldNames]);
  FQuery.ExecSQL;

  CheckEquals(FMainDataSet.RecordCount, FCloneDataSet.RecordCount);

  FCloneDataSet.First;
  FMainDataset.First;
  while not FMainDataSet.Eof do begin
    CheckFalse(FCloneDataSet.Eof);
    for i := 0 to FMainDataSet.Fields.Count - 1 do
      CheckTrue(FMainDataSet.Fields[i].Value = FCloneDataSet.Fields[i].Value, Format('Fail at row %d fields %s', [FMainDataSet.RecNo, FMainDataSet.Fields[i].FieldName]));
    FMainDataSet.Next;
    FCloneDataSet.Next;
  end;
end;

procedure TTest_Clone.SetUp;
begin
  inherited;
  FCloneDataSet := TClientDataSet.Create(nil);
  FCloneDataSet.FieldDefs.Assign(FMainDataSet.FieldDefs);
  FCloneDataSet.CreateDataSet;
  FCloneDataSet.LogChanges := False;

  FMainDataSet.LogChanges := False;
end;

procedure TTest_Clone.TearDown;
begin
  inherited;
  FCloneDataSet.Free;
end;

procedure TTest_Clone.Test_ByAsterisk;
begin
  Execute('*');
end;

procedure TTest_Clone.Test_ByFieldNames;
var i: Integer;
    S: string;
begin
  S := FCloneDataSet.Fields[0].FieldName;
  for i := 1 to FCloneDataSet.Fields.Count - 1 do
    S := S + ', ' + FCloneDataSet.Fields[i].FieldName;

  Execute(S);
end;

{ TTest_Filter }

procedure TTest_Filter.Test_Filter_ISLIKE_Multiple_Contains;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
  end;
  FQuery.Open;
  FQuery.Filter := 'ISLIKE(DocNo, ''%002%'')';
  FQuery.Filtered := true;
  CheckEquals(1,         FQuery.RecordCount,        'IsLike: FQuery Record Count incorrect.');
  CheckEquals('IV-0002', FQuery.Fields[0].AsString, 'IsLike: DocNo incorrect.');

  FQuery.Filter := 'SQLLIKE(DocNo, ''%003%'')';
  FQuery.Filtered := true;
  CheckEquals(1,         FQuery.RecordCount,        'SqlLike: FQuery Record Count incorrect.');
  CheckEquals('IV-0003', FQuery.Fields[0].AsString, 'SqlLike: DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_Filter.Test_Filter_LIKE_Mix_InBrakets;
begin
  FMainDataSet.Append;
  FMainDataSet.FindField('DocNo').AsString := 'Underwater Club';
  FMainDataSet.Post;

  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
  end;
  FQuery.Open;
  FQuery.Filter := '[LIKE](DocNo, ''%Cl_b'')'; {LIKE, When used in Filter must be used as function
                                                and to be enclosed in Brakets []}
  FQuery.Filtered := true;
  CheckEquals(1,         FQuery.RecordCount,        'LIKE: FQuery Record Count incorrect.');
  CheckEquals('Underwater Club', FQuery.Fields[0].AsString, 'LIKE: DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_Filter.Test_Filter_MATCH_EscapeChar_Mix;
begin
  FMainDataSet.Append;
  FMainDataSet.FindField('DocNo').AsString := 'Under_water\Club';
  FMainDataSet.Append;
  FMainDataSet.FindField('DocNo').AsString := 'Under_water\Cpub';
  FMainDataSet.Append;
  FMainDataSet.FindField('DocNo').AsString := 'Under_water\Crub';
  FMainDataSet.Post;

  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
  end;
  FQuery.Open;
  FQuery.Filter := 'Match(DocNo, ''%der\_wa_er\\C[lr]ub'',''\'')';
  FQuery.Filtered := true;
  FQuery.First;

  CheckEquals(2,         FQuery.RecordCount,        'Match: FQuery Record Count incorrect.');
  CheckEquals('Under_water\Club', FQuery.Fields[0].AsString, 'Match: DocNo incorrect.');
  FQuery.Next;
  CheckEquals('Under_water\Crub', FQuery.Fields[0].AsString, 'Match: DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_Filter.Test_Filter_MATCH_Ranges_Mix;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    end;
  FQuery.Open;

  FQuery.Filter := 'Match(DocNo, ''%00[6-9]%'')'; {from DocNo IV-0006 to IV-0009}
  FQuery.Filtered := true;
  FQuery.First;
  CheckEquals(4,         FQuery.RecordCount,        'Match: FQuery Record Count incorrect.');
  CheckEquals('IV-0006', FQuery.Fields[0].AsString, 'Match: DocNo incorrect.');
  FQuery.Last;
  CheckEquals('IV-0009', FQuery.Fields[0].AsString, 'Match: DocNo incorrect.');
  FQuery.Close;
end;

procedure TTestCase_Float.Test_Max;
var D, D1: TClientDataSet;
    X: TxQuery;
begin
  D := TClientDataSet.Create(nil);
  D1 := TClientDataSet.Create(nil);
  X := TxQuery.Create(nil);
  try
    D.FieldDefs.Add('BasePrice', ftFmtBcd, 8);
    D.FieldDefs.Find('BasePrice').Precision := 19;
    D.CreateDataSet;
    D.AppendRecord([0.00005000]);
    X.AddDataSet(D, 'Main');
    X.SQL.Text := 'SELECT Max(BasePrice) FROM Main';
    X.Open;
    CheckEquals('0.00005', FloatToStrF(X.Fields[0].AsFloat, ffNumber, 18, 5));
  finally
    X.Free;
    D.Free;
    D1.Free;
  end;
end;

procedure TTest_TxQuery_Threading.Test_Case1;
begin
  var P := function(Index: Integer): TFunc<Integer>
  begin
    Result := function: Integer begin
      var D := TClientDataSet.Create(nil);
      var Q := TxQuery.Create(nil);
      try
        D.FieldDefs.Add('DocKey', ftInteger);
        D.FieldDefs.Add('DocAmt', ftInteger);
        D.CreateDataSet;
        D.AppendRecord([1, Index * 50]);
        D.AppendRecord([2, Index * 50]);

        Q.AddDataSet(D, 'Main');
        Q.SQL.Text := 'SELECT SUM(DocAmt) FROM Main';
        try
          Q.Open;
          Result := Q.Fields[0].AsInteger;
        except
          Result := -1;
        end;
      finally
        D.DisposeOf;
        Q.DisposeOf;
      end;
    end
  end;

  var A: TArray<IFuture<Integer>>;
  SetLength(A, 20);
  for var i := Low(A) to High(A) do
    A[i] := TTask.Future<Integer>(P(i)).Start;

  for var i := Low(A) to High(A) do begin
    Status(i.ToString);
    CheckEquals(i * 100, A[i].Value);
  end;
end;

initialization
  TxQueryTestSuite := TTestSuite.Create('TxQuery Test Framework');

  with TxQueryTestSuite do begin
    AddSuite(TTest_DataSet.Suite);
    AddSuite(TTest_Between.Suite);
    AddSuite(TTest_FreeTxQuery.Suite);
    AddSuite(TTest_Transform.Suite);
    AddSuite(TTest_Distinct.Suite);
    AddSuite(TTest_IN.Suite);
    AddSuite(TTest_OrderBy.Suite);
    AddSuite(TTest_LIKE.Suite);
    AddSuite(TTest_Filter.Suite);
    AddSuite(TTest_GroupBy.Suite);
    AddSuite(TTest_SubQueries.Suite);
    AddSuite(TTest_Join.Suite);
    AddSuite(TTest_Union.Suite);

    AddSuite(TTest_Update.Suite);
    AddSuite(TTest_Delete.Suite);
    AddSuite(TTest_Insert.Suite);
    AddSuite(TTest_Clone.Suite);

    AddSuite(TTest_Max.Suite);
    AddSuite(TTest_Min.Suite);
    AddSuite(TTest_Extract.Suite);
    AddSuite(TTest_ParamByName.Suite);
    AddSuite(TTest_Fields.Suite);

    AddSuite(TTest_DateTime.Suite);
    AddSuite(TTest_Hardcode_String.Suite);
    AddSuite(TTest_Select.Suite);

    AddSuite(TTest_DirectAccess.Suite);
    Addsuite(TTestCase_Float.Suite);

    AddSuite(TTest_TxQuery_Threading.Suite);
  end;

  TestFramework.RegisterTest(TxQueryTestSuite);
end.
