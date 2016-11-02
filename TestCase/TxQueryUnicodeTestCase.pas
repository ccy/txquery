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
{                   Francisco Dueñas Rodriguez (Mexico) <fduenas@gmail.com>   }
{                                                                             }
{              url: http://code.google.com/p/txquery/                         }
{                   http://groups.google.com/group/txquery                    }
{                                                                             }
{*****************************************************************************}

unit TxQueryUnicodeTestCase;

interface

uses Classes, SysUtils, TestFramework, DB, DBClient, xQuery, Character;

type
  TTest_TxQuery_Unicode = class(TTestCase)
  private
    FDate: TDateTime;
    FDetailDataSet: TClientDataSet;
  protected
    FMainDataSet: TClientDataSet;
    FQuery: TxQuery;
    procedure SetUp; override;
    procedure TearDown; override;
  end;

  TTest_Unicode_Delete = class(TTest_TxQuery_Unicode)
  published
    procedure Test_Delete_WithCondition;
  end;

  TTest_Unicode_Distinct = class(TTest_TxQuery_Unicode)
  published
    procedure Test_Distinct_Aggregate;
    procedure Test_Distinct_NullRecord;
    procedure Test_Distinct_Record;
  end;

  TTest_Unicode_GroupBy = class(TTest_TxQuery_Unicode)
  published
    procedure Test_GroupBy_SUMQty;
    procedure Test_GroupBy_Having;
    procedure Test_GroupBy_Division2;
    procedure Test_GroupBy_Division1;
    procedure Test_GroupBy_Division3;
  end;

  TTest_Unicode_Hardcode_String = class(TTest_TxQuery_Unicode)
  published
    procedure Test_Hardcode_String_Select;
  end;

  TTest_Unicode_IN = class(TTest_TxQuery_Unicode)
  published
    procedure TTest_IN_SQL;
  end;

  TTest_Unicode_Insert = class(TTest_TxQuery_Unicode)
  published
    procedure Test_Insert_WithSelectSQL;
    procedure Test_Insert_WithValues;
  end;

  TTest_Unicode_Join = class(TTest_TxQuery_Unicode)
  published
    procedure Test_EmptyKeyJoin_InnerJoin;
    procedure Test_EmptyKeyJoin_LeftOuterJoin;
    procedure Test_JoinTwoDataSets_WithShortAlias;
    procedure Test_JoinTwoDataSets_WithTableAlias;
    procedure Test_JoinTwoDataSets_InnerJoin;
    procedure Test_JoinTwoDataSets_LeftOuterJoin;
    procedure Test_JoinTwoDataSets_LeftOuterJoin_MoreCondition;
  end;

  TTest_Unicode_LIKE = class(TTest_TxQuery_Unicode)
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

  TTest_Unicode_Max = class(TTest_TxQuery_Unicode)
  published
    procedure Test_Max_WithCondition;
  end;

  TTest_Unicode_Min = class(TTest_TxQuery_Unicode)
  published
    procedure Test_Min_WithCondition;
  end;

  TTest_Unicode_OrderBy = class(TTest_TxQuery_Unicode)
  published
    procedure Test_OrderBy_Desc;
    procedure Test_OrderBy_SingleField_Desc;
    procedure Test_OrderBy_MultiField;
  end;

  TTest_Unicode_ParamByName = class(TTest_TxQuery_Unicode)
  published
    procedure Test_ParamByName;
  end;

  TTest_Unicode_SubQueries = class(TTest_TxQuery_Unicode)
  published
    procedure Test_SubQueries_IN_Case1;
    procedure Test_SubQueries_NOTIN_Case1;
  end;

  TTest_Unicode_Transform = class(TTest_TxQuery_Unicode)
  published
    procedure Test_Transform_Data;
    procedure Test_Transform_FormatDateTime;
  end;

  TTest_Unicode_Union = class(TTest_TxQuery_Unicode)
  published
    procedure Test_UnionSQL;
  end;

  TTest_Unicode_Update = class(TTest_TxQuery_Unicode)
  published
    procedure Test_UpdateSingleField;
    procedure Test_UpdateMultiField;
    procedure Test_Update_WithCondition;
    procedure Test_Update_WithSubQueries;
  end;

implementation

uses StrUtils, DateUtils, Variants, Provider;

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

procedure TTest_TxQuery_Unicode.SetUp;
var i: integer;
begin
  inherited;
  FDate := EncodeDate(2005, 5, 5);
  FQuery := TxQuery.Create(nil);

  //Main Data
  FMainDataSet := TClientDataSet.Create(nil);
  with FMainDataSet do begin
    FieldDefs.Clear;
    FieldDefs.Add('DocKey',    ftInteger, 0);
    FieldDefs.Add('Code',      ftWideString, 10);
    FieldDefs.Add('DocNo',     ftWideString, 20);
    FieldDefs.Add('DocDate',   ftDate,    0);
    FieldDefs.Add('Agent',     ftWideString, 10);
    FieldDefs.Add('Qty',       ftFmtBCD,  8);
    FieldDefs.Add('UnitPrice', ftFmtBCD,  8);
    FieldDefs.Add('Amount',    ftFmtBCD,  8);
    CreateDataSet;
  end;

  for i := 1 to 10 do begin
    FMainDataSet.Append;
    FMainDataSet['DocKey'] := i;
    FMainDataSet['Code'] := Format(Chr($987E)+Chr($5BA2) + '-%d', [i]);
    FMainDataSet['DocNo'] := Format(Chr($8BA2)+Chr($5355) + '-%.4d', [i]);
    FMainDataSet['DocDate'] := IncDay(FDate, i);
    if i <= 3 then
      FMainDataSet['Agent'] := Chr($4EE3)+Chr($7406)+'1'
    else if (i > 3) and (i < 8) then
      FMainDataSet['Agent'] := Chr($4EE3)+Chr($7406)+'2'
    else
      FMainDataSet['Agent'] := Chr($4EE3)+Chr($7406)+'3';
    FMainDataSet['Qty'] := i;
    FMainDataSet['UnitPrice'] := i * 2;
    FMainDataSet['Amount'] := FMainDataSet['Qty'] * FMainDataSet['UnitPrice'];
    FMainDataSet.Post;
  end;

  //Detail Data
  FDetailDataSet := TClientDataSet.Create(nil);
  with FDetailDataSet do begin
    FieldDefs.Add('DocKey',   ftInteger, 0);
    FieldDefs.Add('ItemCode', ftWideString, 30);
    CreateDataSet;
  end;

  for i := 1 to 5 do begin
    FDetailDataSet.Append;
    if (i <= 3) then
      FDetailDataSet['DocKey'] := 1
    else
      FDetailDataSet['DocKey'] := 7;
    FDetailDataSet['ItemCode'] := Format(Chr($8D27)+Chr($7269) + '%d', [i]);
    FDetailDataSet.Post;
  end;
end;

procedure TTest_TxQuery_Unicode.TearDown;
begin
  inherited;
  FMainDataSet.Free;
  FDetailDataSet.Free;
  FQuery.Free;
end;

procedure TTest_Unicode_Delete.Test_Delete_WithCondition;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('DELETE FROM Main');
    Add( 'WHERE DocNo=' + QuotedStr(Chr($8BA2)+Chr($5355) + '-0001'));
  end;
  FQuery.ExecSQL;
  CheckEquals(9, FMainDataSet.RecordCount, 'FMainDataSet Record Count incorrect');
  CheckFalse(FMainDataSet.Locate('DocNo', Chr($8BA2)+Chr($5355) + '-0001', []), 'Record still exists even has been deleted');
end;

procedure TTest_Unicode_Distinct.Test_Distinct_Aggregate;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.SQL.Text := 'SELECT COUNT(DISTINCT Agent) FROM Main';
  FQuery.Open;
  CheckEquals(3, FQuery.Fields[0].AsInteger, 'Distinct Agent Count is incorrect.');
  FQuery.Close;
end;

procedure TTest_Unicode_Distinct.Test_Distinct_NullRecord;
var D1: TClientDataSet;
begin
  D1 := TClientDataSet.Create(nil);
  try
    with D1 do begin
      FieldDefs.Add('Test1',    ftWideString, 10);
      CreateDataSet;
      AppendRecord([Null]);
      AppendRecord(['']);
      AppendRecord([Chr($6D4B)+Chr($8BD5)]);
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
    CheckEquals(Chr($6D4B)+Chr($8BD5), FQuery['Test1']);
  finally
    D1.Free;
  end;
end;

procedure TTest_Unicode_Distinct.Test_Distinct_Record;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.SQL.Text := 'SELECT DISTINCT Agent FROM Main ORDER BY Agent';
  FQuery.Open;

  FQuery.First;
  CheckEquals( Chr($4EE3)+Chr($7406)+'1', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals( Chr($4EE3)+Chr($7406)+'2', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals( Chr($4EE3)+Chr($7406)+'3', FQuery.Fields[0].AsString);
  FQuery.Close;
end;

procedure TTest_Unicode_GroupBy.Test_GroupBy_SUMQty;
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

procedure TTest_Unicode_GroupBy.Test_GroupBy_Having;
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

procedure TTest_Unicode_GroupBy.Test_GroupBy_Division2;
begin
  //this case will fail becoz Count(Code) -> code is a string field, TxQuery not support string field, only support numeric field, refer to Test_GroupBy_Division3
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT SUM(Amount) / Count(*) As Total, Agent');
    Add(  'FROM Main');
    Add( 'WHERE Agent=' + QuotedStr( Chr($4EE3)+Chr($7406)+'1'));
    Add( 'GROUP BY Agent');
    Add( 'ORDER BY Agent');
  end;
  FQuery.Open;
  CheckEquals(1,      FQuery.RecordCount,          'FQuery Record Count incorrect.');
  CheckEquals(9.3333, FQuery.Fields[0].AsCurrency, 'Total incorrect.');
  FQuery.Close;
end;

procedure TTest_Unicode_GroupBy.Test_GroupBy_Division1;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT SUM(Amount) / SUM(Qty) As Total, Agent');
    Add(  'FROM Main');
    Add( 'WHERE Agent=' + QuotedStr( Chr($4EE3)+Chr($7406)+'1' ) );
    Add( 'GROUP BY Agent');
    Add( 'ORDER BY Agent');
  end;

  FQuery.Open;
  CheckEquals(1,      FQuery.RecordCount,          'FQuery Record Count incorrect.');
  CheckEquals(4.6667, FQuery.Fields[0].AsCurrency, 'Total incorrect.');
  FQuery.Close;
end;

procedure TTest_Unicode_GroupBy.Test_GroupBy_Division3;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT SUM(Amount) / COUNT(Qty) As Total, Agent');
    Add(  'FROM Main');
    Add( 'WHERE Agent=' + QuotedStr( Chr($4EE3)+Chr($7406)+'1'));
    Add( 'GROUP BY Agent');
    Add( 'ORDER BY Agent');
  end;
  FQuery.Open;
  CheckEquals(1,      FQuery.RecordCount,          'FQuery Record Count incorrect.');
  CheckEquals(9.3333, FQuery.Fields[0].AsCurrency, 'Total incorrect.');
  FQuery.Close;
end;

procedure TTest_Unicode_Hardcode_String.Test_Hardcode_String_Select;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add(Format(   'SELECT "%s"', [Chr($6D4B)+Chr($8BD5)]));
    Add(           'FROM Main');
  end;
  FQuery.Open;
  CheckEquals(FMainDataSet.RecordCount, FQuery.RecordCount);
  FQuery.Close;
end;

procedure TTest_Unicode_IN.TTest_IN_SQL;
var lResult: boolean;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add(Format('WHERE Agent IN (%s, %s)', [QuotedStr( Chr($4EE3)+Chr($7406)+'1'), QuotedStr(Chr($4EE3)+Chr($7406)+'3')]));
  end;
  FQuery.Open;

  FQuery.First;
  while not FQuery.Eof do begin
    lResult := SameText(FQuery['Agent'],  Chr($4EE3)+Chr($7406)+'1') or SameText(FQuery['Agent'], Chr($4EE3)+Chr($7406)+'3');
    CheckTrue(lResult, 'Return result not true.');
    FQuery.Next;
  end;
  FQuery.Close;
end;

procedure TTest_Unicode_Insert.Test_Insert_WithSelectSQL;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('INSERT INTO Main (Code, DocNo, Agent, Amount)');
    Add('(SELECT Code, DocNo, Agent, Amount');
    Add(  'FROM Main');
    Add(Format( 'WHERE Agent=%s)', [QuotedStr( Chr($4EE3)+Chr($7406)+'1')]));
  end;
  FQuery.ExecSQL;
  CheckEquals(13, FMainDataSet.RecordCount, 'FMainDataSet RecordCount incorrect');
end;

procedure TTest_Unicode_Insert.Test_Insert_WithValues;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('INSERT INTO Main (Code, DocNo, Agent, Amount)');
    Add(Format('VALUES(%s, %s, %s, ''400'')', [QuotedStr(Chr($4F9B)+Chr($5E94)+Chr($55461)),
                                               QuotedStr(Chr($7380)+Chr($91D1)+Chr($9500)+Chr($552E)),
                                               QuotedStr(Chr($9648)+Chr($5148)+Chr($751F))]));
  end;
  FQuery.ExecSQL;
  CheckEquals(11, FMainDataSet.RecordCount, 'FMainDataSet RecordCount incorrect');
  CheckTrue(FMainDataSet.Locate('DocNo', Chr($7380)+Chr($91D1)+Chr($9500)+Chr($552E), []), Chr($7380)+Chr($91D1)+Chr($9500)+Chr($552E) + 'not found');
  //since the above statement CheckTrue is pass then the following record has been point to CS-0001
  CheckEquals(Chr($4F9B)+Chr($5E94)+Chr($55461), FMainDataSet.FindField('Code').AsString,     'Field "Code" incorrect');
  CheckEquals(Chr($9648)+Chr($5148)+Chr($751F),  FMainDataSet.FindField('Agent').AsString,    'Field "Agent" incorrect');
  CheckEquals(400,                 FMainDataSet.FindField('Amount').AsCurrency, 'Field "Amount" incorrect');
end;

procedure TTest_Unicode_Join.Test_EmptyKeyJoin_InnerJoin;
var D, D1, D2: TClientDataSet;
begin
  D := TClientDataSet.Create(nil);
  D1 := TClientDataSet.Create(nil);
  D2 := TClientDataSet.Create(nil);
  try
    with D1 do begin
      FieldDefs.Add('Test1',    ftWideString, 10);
      CreateDataSet;
      AppendRecord([Null]);
      AppendRecord(['']);
      AppendRecord([Chr($6D4B)+Chr($8BD5)]);
    end;

    with D2 do begin
      FieldDefs.Add('Test2',    ftWideString, 10);
      FieldDefs.Add('ItemCode', ftWideString, 10);
      CreateDataSet;
      AppendRecord([Null,         Chr($8D27)+Chr($7269)+'1']);
      AppendRecord(['',           Chr($8D27)+Chr($7269)+'2']);
      AppendRecord([Chr($6D4B)+Chr($8BD5), Chr($8D27)+Chr($7269)+'3']);
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
    CheckEquals(3,         D.RecordCount);
    D.First;
    CheckTrue(VarIsNull(D['Test1']));
    CheckEquals(Chr($8D27)+Chr($7269)+'1',   D['ItemCode']);
    D.Next;
    CheckEquals('',        D['Test1']);
    CheckEquals(Chr($8D27)+Chr($7269)+'2',   D['ItemCode']);
    D.Next;
    CheckEquals(Chr($6D4B)+Chr($8BD5), D['Test1']);
    CheckEquals(Chr($8D27)+Chr($7269)+'3',   D['ItemCode']);
  finally
    D.Free;
    D1.Free;
    D2.Free;
  end;
end;

procedure TTest_Unicode_Join.Test_EmptyKeyJoin_LeftOuterJoin;
var D, D1, D2: TClientDataSet;
begin
  D := TClientDataSet.Create(nil);
  D1 := TClientDataSet.Create(nil);
  D2 := TClientDataSet.Create(nil);
  try
    with D1 do begin
      FieldDefs.Add('Test1',    ftWideString, 10);
      CreateDataSet;
      AppendRecord([Null]);
      AppendRecord(['']);
      AppendRecord([Chr($6D4B)+Chr($8BD5)]);
    end;

    with D2 do begin
      FieldDefs.Add('Test2',    ftWideString, 10);
      FieldDefs.Add('ItemCode', ftWideString, 10);
      CreateDataSet;
      AppendRecord([Null, Chr($8D27)+Chr($7269)+'1']);
      AppendRecord(['',   Chr($8D27)+Chr($7269)+'2']);
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
    CheckEquals(Chr($8D27)+Chr($7269)+'1',   D['ItemCode']);
    D.Next;
    CheckEquals('',        D['Test1']);
    CheckEquals(Chr($8D27)+Chr($7269)+'2',   D['ItemCode']);
    D.Next;
    CheckEquals(Chr($6D4B)+Chr($8BD5), D['Test1']);
    CheckTrue(VarIsNull(D['ItemCode']));
  finally
    D.Free;
    D1.Free;
    D2.Free;
  end;
end;

procedure TTest_Unicode_Join.Test_JoinTwoDataSets_WithShortAlias;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet,   'Main');
  FQuery.AddDataSet(FDetailDataSet, 'Detail');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT A.DocNo, B.ItemCode');
    Add(  'FROM Main A, Detail B');
    Add( 'WHERE A.DocKey=B.DocKey');
    Add(   'AND A.DocNo=' + QuotedStr(Chr($8BA2)+Chr($5355) + '-0007'));
    Add( 'ORDER BY B.ItemCode');
  end;
  FQuery.Open;
  CheckEquals(2, FQuery.RecordCount, 'FQuery Record Count incorrect');
  FQuery.First;
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals(Chr($8D27)+Chr($7269)+'4', FQuery.FindField('ItemCode').AsString);
  FQuery.Next;
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals(Chr($8D27)+Chr($7269)+'5', FQuery.FindField('ItemCode').AsString);
  FQuery.Close;
end;

procedure TTest_Unicode_Join.Test_JoinTwoDataSets_WithTableAlias;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet,   'Main');
  FQuery.AddDataSet(FDetailDataSet, 'Detail');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT Main.DocNo, Detail.ItemCode');
    Add(  'FROM Main, Detail');
    Add( 'WHERE Main.DocKey=Detail.DocKey');
    Add(   'AND Main.DocNo=' + QuotedStr(Chr($8BA2)+Chr($5355) + '-0007'));
    Add( 'ORDER BY Detail.ItemCode');
  end;
  FQuery.Open;
  CheckEquals(2, FQuery.RecordCount, 'FQuery Record Count incorrect');
  FQuery.First;
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals(Chr($8D27)+Chr($7269)+'4', FQuery.FindField('ItemCode').AsString);
  FQuery.Next;
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals(Chr($8D27)+Chr($7269)+'5', FQuery.FindField('ItemCode').AsString);
  FQuery.Close;
end;

procedure TTest_Unicode_Join.Test_JoinTwoDataSets_InnerJoin;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet,   'Main');
  FQuery.AddDataSet(FDetailDataSet, 'Detail');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT A.DocNo, B.ItemCode');
    Add(  'FROM Main A INNER JOIN Detail B ON (A.DocKey=B.DocKey)');
    Add( 'WHERE A.DocNo=' + QuotedStr(Chr($8BA2)+Chr($5355) + '-0007'));
    Add( 'ORDER BY B.ItemCode');
  end;
  FQuery.Open;
  CheckEquals(2, FQuery.RecordCount, 'FQuery Record Count incorrect');
  FQuery.First;
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals(Chr($8D27)+Chr($7269)+'4', FQuery.FindField('ItemCode').AsString);
  FQuery.Next;
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0007', FQuery.FindField('DocNo').AsString);
  CheckEquals(Chr($8D27)+Chr($7269)+'5', FQuery.FindField('ItemCode').AsString);
  FQuery.Close;
end;

procedure TTest_Unicode_Join.Test_JoinTwoDataSets_LeftOuterJoin;
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

procedure TTest_Unicode_Join.Test_JoinTwoDataSets_LeftOuterJoin_MoreCondition;
var lDataSet: TClientDataSet;
begin
  lDataSet := TClientDataSet.Create(nil);
  try
    with lDataSet do begin
      FieldDefs.Add('DocKey',   ftInteger,  0);
      FieldDefs.Add('Agent',    ftWideString,  10);
      CreateDataSet;

      Append;
      FindField('DocKey').AsInteger := 2;
      FindField('Agent').AsString := Chr($8D27)+Chr($7269)+'1';
      Post;

      Append;
      FindField('DocKey').AsInteger := 4;
      FindField('Agent').AsString := Chr($8D27)+Chr($7269)+'2';
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

procedure TTest_Unicode_LIKE.Test_LIKE_EscapeChar_Mix;
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

procedure TTest_Unicode_LIKE.Test_LIKE_Mix;
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

procedure TTest_Unicode_LIKE.Test_LIKE_Multiple_Contains;
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
  CheckEquals(1,                      FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0002', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_Unicode_LIKE.Test_LIKE_Multiple_EndWith;
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
  CheckEquals(1,                      FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0001', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_Unicode_LIKE.Test_LIKE_Multiple_StartWith;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FMainDataSet.RecordCount;
  with FQuery.SQL do begin
    Clear;
    Add('SELECT DISTINCT Agent');
    Add(  'FROM Main');
    Add( Format('WHERE Agent LIKE ''%s%%''', [Chr($4EE3)+Chr($7406)]) );
  end;
  FQuery.SQL.Text;
  FQuery.Open;
  CheckEquals(3,     FQuery.RecordCount,        'FQuery Record Count incorrect.');
  FQuery.Close;
end;

procedure TTest_Unicode_LIKE.Test_LIKE_Single_Contains_Left;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add(Format( 'WHERE DocNo LIKE ''%s-000_''', [Chr($8BA2)+Chr($5355)]));
  end;
  FQuery.Open;
  CheckEquals(9,                      FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0001', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_Unicode_LIKE.Test_LIKE_Single_Contains_Middle;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add(Format( 'WHERE DocNo LIKE ''%s_0002''', [Chr($8BA2)+Chr($5355)]));
  end;
  FQuery.Open;
  CheckEquals(1,                      FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0002', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_Unicode_LIKE.Test_LIKE_Single_Contains_Right;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add(Format( 'WHERE DocNo LIKE ''_%s-0003''', [Chr($5355)]));
  end;
  FQuery.Open;
  CheckEquals(1,             FQuery.RecordCount,        'FQuery Record Count incorrect.');
  CheckEquals(Chr($8BA2)+Chr($5355)+'-0003', FQuery.Fields[0].AsString, 'DocNo incorrect.');
  FQuery.Close;
end;

procedure TTest_Unicode_Max.Test_Max_WithCondition;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT MAX(Amount)');
    Add(  'FROM Main');
    Add( 'WHERE Agent=' + QuotedStr( Chr($4EE3)+Chr($7406)+'1'));
  end;
  FQuery.Open;
  CheckEquals(18, FQuery.Fields[0].AsInteger, 'Max Result incorrect');
  FQuery.Close;
end;

procedure TTest_Unicode_Min.Test_Min_WithCondition;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT MIN(Amount)');
    Add(  'FROM Main');
    Add( 'WHERE Agent=' + QuotedStr(Chr($4EE3)+Chr($7406)+'3'));
  end;
  FQuery.Open;
  CheckEquals(128, FQuery.Fields[0].AsInteger, 'Min Result incorrect');
  FQuery.Close;
end;

procedure TTest_Unicode_OrderBy.Test_OrderBy_Desc;
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

procedure TTest_Unicode_OrderBy.Test_OrderBy_SingleField_Desc;
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

procedure TTest_Unicode_OrderBy.Test_OrderBy_MultiField;
var lLastDocNo: string;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT Code, DocNo, Agent');
    Add(  'FROM Main');
    Add( 'WHERE Agent=' + QuotedStr( Chr($4EE3)+Chr($7406)+'1'));
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

procedure TTest_Unicode_ParamByName.Test_ParamByName;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  FQuery.SQL.Text := 'UPDATE Main SET Agent=:Agent WHERE DocNo=:DocNo';
  FQuery.ParamByName('Agent').AsString := Chr($FF08) + Chr($4EE3) + Chr($7406) + '3' + Chr($FF09);
  FQuery.ParamByName('DocNo').AsString := Chr($8BA2) + Chr($5355) + '-0001';
  FQuery.ExecSQL;

  CheckTrue(FMainDataSet.Locate('DocNo', Chr($8BA2) + Chr($5355) + '-0001', []));
  CheckEquals(Chr($FF08) + Chr($4EE3) + Chr($7406) + '3' + Chr($FF09), FMainDataSet.FindField('Agent').AsString, 'Field "Agent" incorrect');
end;

procedure TTest_Unicode_SubQueries.Test_SubQueries_IN_Case1;
begin
  FQuery.DataSetS.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT DocNo');
    Add(  'FROM Main');
    Add( 'WHERE Agent IN (SELECT Agent');
    Add(                  'FROM Main');
    Add(Format(          'WHERE Agent NOT IN (%s, %s))', [QuotedStr( Chr($4EE3)+Chr($7406)+'1'), QuotedStr(Chr($4EE3)+Chr($7406)+'2')]));
  end;
  FQuery.Open;
  FQuery.First;
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0008', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0009', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0010', FQuery.Fields[0].AsString);
  FQuery.Close;
end;

procedure TTest_Unicode_SubQueries.Test_SubQueries_NOTIN_Case1;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT Agent');
    Add(  'FROM Main');
    Add( 'WHERE Agent NOT IN (SELECT DISTINCT Agent');
    Add(                       'FROM Main');
    Add(Format(               'WHERE Agent IN (%s, %s))', [QuotedStr( Chr($4EE3)+Chr($7406)+'1'), QuotedStr(Chr($4EE3)+Chr($7406)+'2')]));
  end;
  FQuery.Open;
  CheckEquals(3, FQuery.RecordCount);
  FQuery.First;
  CheckEquals(Chr($4EE3)+Chr($7406)+'3', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals(Chr($4EE3)+Chr($7406)+'3', FQuery.Fields[0].AsString);
  FQuery.Next;
  CheckEquals(Chr($4EE3)+Chr($7406)+'3', FQuery.Fields[0].AsString);
  FQuery.Close;
end;

procedure TTest_Unicode_Transform.Test_Transform_Data;
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
    Add(Format('PIVOT Agent IN ("%s", "%s", "%s")', [ Chr($4EE3)+Chr($7406)+'1', Chr($4EE3)+Chr($7406)+'2', Chr($4EE3)+Chr($7406)+'3']));
  end;
  FQuery.Open;
  CheckEquals(10, FQuery.RecordCount, 'FQuery Record Count incorrect.');

  FQuery.First;
  CheckEquals(2,         FQuery.FindField( Chr($4EE3)+Chr($7406)+'1').AsCurrency, 'Record 1 Field "'+ Chr($4EE3)+Chr($7406)+'1'+'" incorrect');
  CheckEquals(0,         FQuery.FindField(Chr($4EE3)+Chr($7406)+'2').AsCurrency, 'Record 1 Field "'+Chr($4EE3)+Chr($7406)+'2'+'" incorrect');
  CheckEquals(0,         FQuery.FindField(Chr($4EE3)+Chr($7406)+'3').AsCurrency, 'Record 1 Field "'+Chr($4EE3)+Chr($7406)+'3'+'" incorrect');
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0001', FQuery.FindField('DocNo').AsString, 'Record 1 Field "DocNo" incorrect');

  FQuery.Next;
  CheckEquals(8,         FQuery.FindField( Chr($4EE3)+Chr($7406)+'1').AsCurrency, 'Record 2 Field "'+ Chr($4EE3)+Chr($7406)+'1'+'" incorrect');
  CheckEquals(0,         FQuery.FindField(Chr($4EE3)+Chr($7406)+'2').AsCurrency, 'Record 2 Field "'+Chr($4EE3)+Chr($7406)+'2'+'" incorrect');
  CheckEquals(0,         FQuery.FindField(Chr($4EE3)+Chr($7406)+'3').AsCurrency, 'Record 2 Field "'+Chr($4EE3)+Chr($7406)+'3'+'" incorrect');
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0002', FQuery.FindField('DocNo').AsString, 'Record 2 Field "DocNo" incorrect');

  FQuery.RecNo := 5;
  CheckEquals(50,        FQuery.FindField(Chr($4EE3)+Chr($7406)+'2').AsCurrency, 'Record 5 Field "DEF" incorrect');
  CheckEquals(0,         FQuery.FindField( Chr($4EE3)+Chr($7406)+'1').AsCurrency, 'Record 5 Field "'+ Chr($4EE3)+Chr($7406)+'1'+'" incorrect');
  CheckEquals(0,         FQuery.FindField(Chr($4EE3)+Chr($7406)+'3').AsCurrency, 'Record 5 Field "'+Chr($4EE3)+Chr($7406)+'3'+'" incorrect');
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0005', FQuery.FindField('DocNo').AsString, 'Record 5 Field "DocNo" incorrect');

  FQuery.RecNo := 10;
  CheckEquals(200,       FQuery.FindField(Chr($4EE3)+Chr($7406)+'3').AsCurrency, 'Record 10 Field "'+Chr($4EE3)+Chr($7406)+'3'+'" incorrect');
  CheckEquals(0,         FQuery.FindField( Chr($4EE3)+Chr($7406)+'1').AsCurrency, 'Record 10 Field "'+ Chr($4EE3)+Chr($7406)+'1'+'" incorrect');
  CheckEquals(0,         FQuery.FindField(Chr($4EE3)+Chr($7406)+'2').AsCurrency, 'Record 10 Field "'+Chr($4EE3)+Chr($7406)+'2'+'" incorrect');
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0010', FQuery.FindField('DocNo').AsString, 'Record 10 Field "DocNo" incorrect');
  FQuery.Close;
end;

procedure TTest_Unicode_Transform.Test_Transform_FormatDateTime;
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
  CheckEquals( Chr($4EE3)+Chr($7406)+'1', FQuery.FindField('Agent').AsString,   'Record 1 Field "Agent" incorrect');
  FQuery.Next;
  CheckEquals(252,   FQuery.FindField('2005').AsCurrency,  'Record 2 Field "2005" incorrect');
  CheckEquals(Chr($4EE3)+Chr($7406)+'2', FQuery.FindField('Agent').AsString,   'Record 2 Field "Agent" incorrect');
  FQuery.Next;
  CheckEquals(490,   FQuery.FindField('2005').AsCurrency,  'Record 3 Field "2005" incorrect');
  CheckEquals(Chr($4EE3)+Chr($7406)+'3', FQuery.FindField('Agent').AsString,   'Record 3 Field "Agent" incorrect');
  FQuery.Close;
end;

procedure TTest_Unicode_Union.Test_UnionSQL;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'WHERE Agent=' + QuotedStr( Chr($4EE3)+Chr($7406)+'1'));
    Add( 'UNION');
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'WHERE Agent=' + QuotedStr( Chr($4EE3)+Chr($7406)+'2'));
  end;
  FQuery.Open;
  CheckEquals(7, FQuery.RecordCount, 'FQuery Record Count incorrect');
  FQuery.Close;
end;

procedure TTest_Unicode_Update.Test_UpdateSingleField;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('UPDATE Main');
    Add(   'SET Agent=' + QuotedStr(Chr($4EE3)+Chr($7406)));
  end;
  FQuery.ExecSQL;

  CheckEquals(10, FMainDataSet.RecordCount, 'FMainDataSet Record Count incorrect');

  FMainDataSet.First;
  while not FMainDataSet.Eof do begin
    CheckEquals(Chr($4EE3)+Chr($7406), FMainDataSet.FindField('Agent').AsString, 'Field "Agent" incorrect');
    FMainDataSet.Next;
  end;
end;

procedure TTest_Unicode_Update.Test_UpdateMultiField;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('UPDATE Main');
    Add(   'SET Agent=''SHERLYN''');
    Add(Format(', DocNo=%s', [QuotedStr(Chr($8BA2)+Chr($5355) + '-2000')]));
  end;
  FQuery.ExecSQL;

  CheckEquals(10, FMainDataSet.RecordCount, 'FMainDataSet Record Count incorrect');

  FMainDataSet.First;
  while not FMainDataSet.Eof do begin
    CheckEquals('SHERLYN', FMainDataSet.FindField('Agent').AsString, 'Field "Agent" incorrect');
    CheckEquals(Chr($8BA2)+Chr($5355) + '-2000', FMainDataSet.FindField('DocNo').AsString, 'Field "DocNo" incorrect');
    FMainDataSet.Next;
  end;
end;

procedure TTest_Unicode_Update.Test_Update_WithCondition;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');

  with FQuery.SQL do begin
    Clear;
    Add('UPDATE Main');
    Add(   'SET Agent=' + QuotedStr(Chr($4EE3)+Chr($7406)));
    Add(Format( 'WHERE DocNo=%s', [QuotedStr(Chr($8BA2)+Chr($5355) + '-0001')]));
  end;
  FQuery.ExecSQL;

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'WHERE Agent='+QuotedStr(Chr($4EE3)+Chr($7406)));
  end;
  FQuery.Open;
  CheckEquals(1,         FQuery.RecordCount,                 'FQuery Record Count incorrect');
  CheckEquals(Chr($4EE3)+Chr($7406),     FQuery.FindField('Agent').AsString, 'Field "Agent" incorrect');
  CheckEquals(Chr($8BA2)+Chr($5355) + '-0001', FQuery.FindField('DocNo').AsString, 'Field "DocNo" incorrect');
  FQuery.Close;
end;

procedure TTest_Unicode_Update.Test_Update_WithSubQueries;
begin
  FQuery.DataSets.Clear;
  FQuery.AddDataSet(FMainDataSet, 'Main');
  FQuery.AddDataSet(FDetailDataSet, 'Detail');

  with FQuery.SQL do begin
    Clear;
    Add('UPDATE Main');
    Add(   'SET Agent=' + QuotedStr(Chr($4EE3)+Chr($7406)));
    Add( 'WHERE DocKey IN (SELECT DocKey FROM Detail)');
  end;
  FQuery.ExecSQL;

  with FQuery.SQL do begin
    Clear;
    Add('SELECT *');
    Add(  'FROM Main');
    Add( 'WHERE Agent=' + QuotedStr(Chr($4EE3)+Chr($7406)));
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

var TxQueryUnicodeTestSuite: TTestSuite;

initialization
  TxQueryUnicodeTestSuite := TTestSuite.Create('TxQuery Unicode Test Framework');

  with TxQueryUnicodeTestSuite do begin
    AddSuite(TTest_Unicode_Delete.Suite);
    AddSuite(TTest_Unicode_Distinct.Suite);
    AddSuite(TTest_Unicode_GroupBy.Suite);
    AddSuite(TTest_Unicode_Hardcode_String.Suite);
    AddSuite(TTest_Unicode_IN.Suite);
    AddSuite(TTest_Unicode_Insert.Suite);
    AddSuite(TTest_Unicode_Join.Suite);
    AddSuite(TTest_Unicode_LIKE.Suite);
    AddSuite(TTest_Unicode_Max.Suite);
    AddSuite(TTest_Unicode_Min.Suite);
    AddSuite(TTest_Unicode_OrderBy.Suite);
    AddSuite(TTest_Unicode_ParamByName.Suite);
    AddSuite(TTest_Unicode_SubQueries.Suite);
    AddSuite(TTest_Unicode_Transform.Suite);
    AddSuite(TTest_Unicode_Union.Suite);
    AddSuite(TTest_Unicode_Update.Suite);
  end;

  TestFramework.RegisterTest(TxQueryUnicodeTestSuite);
end.
