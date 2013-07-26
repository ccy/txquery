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
{   The Original Code is: xqbase.pas                                          }
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

Unit XQBase;

{$I XQ_FLAG.INC}
Interface

Uses
  Windows, Classes, Db, SysUtils,
  XQMiscel, XQSparseArray, QbaseExpr, QExprYacc
{$IFDEF WITHBDE}
  , DBTables, bde
{$ENDIF}
{$IF RTLVersion >= 20}
    , Generics.Collections
{$IFEND}
  , XQTypes ;
  {-------------------------------------------------------------------------------}
  {                      These Definitions where moved to xqtypes.pas             }
  {                                                                               }
  { Const                                                                         }
  {  SQuote = ['''', '"'];                                                        }
  {  NBoolean: Array[Boolean] Of String = ( 'FALSE', 'TRUE' );                    }
  {                                                                               }
  { Type                                                                          }
  {  ExQueryError = Class( Exception );                                           }
  {  PFloat = ^Double;                                                            }
  {  PInteger = ^Integer;                                                         }
  {  PWordBool = ^WordBool;                                                       }
  {                                                                               }
  {-------------------------------------------------------------------------------}
Type

  {-------------------------------------------------------------------------------}
  {                          Forward declarations                                 }
  {-------------------------------------------------------------------------------}
  TCreateFields = Class;
  TColumnList = Class;
  TTableList = Class;
  TOrderByList = Class;
  TUpdateList = Class;
  TWhereOptimizeList = Class;
  TCreateTableList = Class;
  TInsertList = Class;
  TSrtFields = Class;
  TxqSortList = Class;
  TAggregateList = Class;
  TMemMapFile = Class;

  {-------------------------------------------------------------------------------}
  {                          Declare enumerations                                 }
  {-------------------------------------------------------------------------------}

  TRelOperator = ( roNone, roAnd, roOr );

  TAggregateKind = ( akSUM,
                     akAVG,
                     akSTDEV,
                     akMIN,
                     akMAX,
                     akCOUNT );

  TRelationalOperator = ( ropBETWEEN,
                          ropGT,
                          ropGE,
                          ropLT,
                          ropLE,
                          ropNEQ );

  TSubQueryKind = ( skAny,
                    skAll );

  TSQLStatement = ( ssSelect,
                    ssUpdate,
                    ssDelete,
                    ssInsert,
                    ssUnion,
                    ssCreateTable,
                    ssAlterTable,
                    ssCreateIndex,
                    ssDropTable,
                    ssDropIndex,
                    ssPackTable,
                    ssZapTable,
                    ssReindexTable );

  {TMemorizeJoin = ( mjNone,
                    mjUsingMemory,
                    mjUsingFile );  }

  {-------------------------------------------------------------------------------}
  {                  Defines TAggregateItem                                       }
  {-------------------------------------------------------------------------------}

  TAggregateItem = Class
  Private
    FAggregateList: TAggregateList; { belongs to }
    FAggregateStr: String; { the expression as it is issued in the SQL statement }
    FColIndex: Integer; { the index in the ColumnList where this aggregate is temporary evaluated }
    FAggregate: TAggregateKind; { used if ColumnKind = ckAggregate                          }
    FIsDistinctAg: Boolean; { syntax is SELECT COUNT(distinct pricelist) FROM customer }
    FSparseList: TAggSparseList; { a sparse array for aggregates values in every record }
  Public
    Constructor Create( AggregateList: TAggregateList );
    Destructor Destroy; Override;
    Property AggregateStr: String Read FAggregateStr Write FAggregateStr;
    Property ColIndex: Integer Read FColIndex Write FColIndex;
    Property Aggregate: TAggregateKind Read FAggregate Write FAggregate;
    Property IsDistinctAg: Boolean Read FIsDistinctAg Write FIsDistinctAg;
    Property SparseList: TAggSparseList Read FSparseList Write FSparseList;
  End;

  {-------------------------------------------------------------------------------}
  {                  Defines TAggregateList                                       }
  {-------------------------------------------------------------------------------}

  TAggregateList = Class
  Private
    FItems: TList;
    Function GetCount: Integer;
    Function GetItem( Index: Integer ): TAggregateItem;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Function Add: TAggregateItem;
    Procedure Clear;
    Procedure Delete( Index: Integer );
    Procedure Assign( AggregateList: TAggregateList );
    Property Count: Integer Read GetCount;
    Property Items[Index: Integer]: TAggregateItem Read GetItem; Default;
  End;

  {-------------------------------------------------------------------------------}
  {                  SELECT section data                                          }
  {-------------------------------------------------------------------------------}

  TColumnItem = Class
  Private
    FColumnList: TColumnList; { the column list that this column item belongs to }
    FColumnExpr: String; { the expression in this column }
    FAsAlias: String; { column Name (used later in where, group by, etc), default is FieldName   }
    { also is used as title in browse                                          }
    FResolver: TExprParser; { object used to evaluate ColumnExpr                                       }
    FIsAsExplicit: Boolean; { explicity defined in SQL (ex.: SELECT Sales+Bonus As TotalSales FROM...) }
    FAutoFree: Boolean; { Auto free FResolver class                                                }
    FIsTemporaryCol: Boolean; { Is a column used for some calculations (temporarily)                     }
    FCastType: Word; { column must be casted to this type (CAST expr AS DATE)                   }
    FCastLen: Word; { only used if casting to CHAR(n) n=CastLen                                }
    FAggregateList: TAggregateList; { the list of aggregates for this column: SUM(expression) / SUM(expression) }
    FSubQueryList: TList; { the list of subqueries for this column (SELECT AMOUNTPAID FROM custno WHERE custno=1000) / (SELECT AMOUNTPAID FROM custno WHERE custno=2000) }
  Public
    Constructor Create( ColumnList: TColumnList );
    Destructor Destroy; Override;
    procedure ReleaseResolver;
    Property ColumnExpr: String Read FColumnExpr Write FColumnExpr;
    Property AsAlias: String Read FAsAlias Write FAsAlias;
    Property IsAsExplicit: Boolean Read FIsAsExplicit Write FIsAsExplicit;
    Property IsTemporaryCol: Boolean Read FIsTemporaryCol Write FIsTemporaryCol;
    Property CastType: Word Read FCastType Write FCastType;
    Property CastLen: Word Read FCastLen Write FCastLen;
    Property Resolver: TExprParser Read FResolver Write FResolver;
    Property AutoFree: Boolean Read FAutoFree Write FAutoFree;
    Property AggregateList: TAggregateList Read FAggregateList Write FAggregateList;
    Property SubqueryList: TList Read FSubQueryList Write FSubQueryList;
  End;

  TColumnList = Class
  Private
    FItems: TList;
    Function GetCount: Integer;
    Function GetItem( Index: Integer ): TColumnItem;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Function Add: TColumnItem;
    Procedure Clear;
    Procedure Delete( Index: Integer );
    Procedure DeleteAggregate( RecNo: Integer );
    Procedure SortAggregateWithList( SortList: TxqSortList );
    Property Count: Integer Read GetCount;
    Property Items[Index: Integer]: TColumnItem Read GetItem; Default;
  End;

  {-------------------------------------------------------------------------------}
  {                  FROM section data                                            }
  {-------------------------------------------------------------------------------}

  TTableItem = Class
  Private
    FTableList: TTableList;
    FTableName: TxNativeString;
    FAlias: TxNativeString;
    FDataSet: TDataSet; { the attached dataset }
    FIsFullPath: Boolean;
    { for using in syntax like: SELECT * FROM subquery1, a, subquery2, ... etc}
    FNumSubquery: Integer;
  Public
    Constructor Create( TableList: TTableList );

    Property TableName: TxNativeString Read FTableName Write FTableName;
    Property Alias: TxNativeString Read FAlias Write FAlias;
    Property DataSet: TDataSet Read FDataSet Write FDataSet;
    Property IsFullPath: Boolean Read FIsFullPath Write FIsFullPath;
    Property NumSubquery: Integer read FNumSubquery write FNumSubquery;
  End;

  TTableList = Class
    FItems: TList;
    Function GetCount: Integer;
    Function GetItem( Index: Integer ): TTableItem;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Function Add: TTableItem;
    Procedure Clear;
    Procedure Delete( Index: Integer );
    Function IndexOFDataSet( DataSet: TDataSet ): Integer;
    Function IndexOFTableName( Const tableName: String ): Integer; // 1.56 fix
    Function IndexOFAlias( Const Alias: String ): Integer; // 1.56 fix

    Property Count: Integer Read GetCount;
    Property Items[Index: Integer]: TTableItem Read GetItem; Default;
  End;

  {-------------------------------------------------------------------------------}
  {   ORDER BY section data - used in ORDER BY and GROUP BY                       }
  {-------------------------------------------------------------------------------}

  TOrderByItem = Class
  Private
    FOrderByList: TOrderByList;
    FColIndex: Integer;
    FAlias: String; { field name used to order                                   }
    FDesc: Boolean; { Descending? default = false = Ascending;                   }
  Public
    Constructor Create( OrderByList: TOrderByList );
    Property ColIndex: Integer Read FColIndex Write FColIndex;
    Property Alias: String Read FAlias Write FAlias;
    Property Desc: Boolean Read FDesc Write FDesc;
  End;

  TOrderByList = Class
    FItems: TList;
    Function GetCount: Integer;
    Function GetItem( Index: Integer ): TOrderByItem;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Function Add: TOrderByItem;
    Procedure Clear;
    Procedure Delete( Index: Integer );
    Property Count: Integer Read GetCount;
    Property Items[Index: Integer]: TOrderByItem Read GetItem; Default;
  End;

  {-------------------------------------------------------------------------------}
  {                  UPDATE statement section data                                }
  {-------------------------------------------------------------------------------}

  TUpdateItem = Class
  Private
    FUpdateList: TUpdateList;
    FColName: String;
    FColExpr: String;
    FResolver: TExprParser;
    FField: TField;
  Public
    Constructor Create( UpdateList: TUpdateList );
    Destructor Destroy; Override;
    procedure ReleaseResolver;
    Property ColName: String Read FColName Write FColName;
    Property ColExpr: String Read FColExpr Write FColExpr;
    Property Resolver: TExprParser Read FResolver Write FResolver;
    Property Field: TField Read FField Write FField;
  End;

  TUpdateList = Class
    FItems: TList;
    { the following can be one of the following supported syntax only:
      0 = RW_UPDATE table_identifier RW_SET list_update_columns where_clause end_statement
      1 = RW_UPDATE table_identifier RW_SET list_update_columns _EQ subquery end_statement }
    FSyntaxUsed: Integer;
    Function GetCount: Integer;
    Function GetItem( Index: Integer ): TUpdateItem;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Function Add: TUpdateItem;
    Procedure Clear;
    Procedure Delete( Index: Integer );
    Property SyntaxUsed: Integer read FSyntaxUsed write FSyntaxUsed;
    Property Count: Integer Read GetCount;
    Property Items[Index: Integer]: TUpdateItem Read GetItem; Default;
  End;

  {-------------------------------------------------------------------------------}
  {                  WHERE optimization section data                              }
  {-------------------------------------------------------------------------------}

  TWhereOptimizeItem = Class
  Private
    FWhereOptimizeList: TWhereOptimizeList;
    FDataSet: TDataSet;
    FFieldNames: String;
    FRangeStart: String;
    FRangeEnd: String;
    FRelOperator: TRelationalOperator;
    FCanOptimize: Boolean; { Can optimize the result set generation with this config. }
  Public
    Constructor Create( WhereOptimizeList: TWhereOptimizeList );

    Property DataSet: TDataSet Read FDataSet Write FDataSet;
    Property FieldNames: String Read FFieldNames Write FFieldNames;
    Property RangeStart: String Read FRangeStart Write FRangeStart;
    Property RangeEnd: String Read FRangeEnd Write FRangeEnd;
    Property RelOperator: TRelationalOperator Read FRelOperator Write FRelOperator;
    Property CanOptimize: Boolean Read FCanOptimize Write FCanOptimize;
  End;

  TWhereOptimizeList = Class
    FItems: TList;
    Function GetCount: Integer;
    Function GetItem( Index: Integer ): TWhereOptimizeItem;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Procedure Assign( OptimizeList: TWhereOptimizeList );
    Function Add: TWhereOptimizeItem;
    Procedure Clear;
    Procedure Delete( Index: Integer );
    Property Count: Integer Read GetCount;
    Property Items[Index: Integer]: TWhereOptimizeItem Read GetItem; Default;
  End;

  {-------------------------------------------------------------------------------}
  {                  CREATE TABLE section data                                    }
  {-------------------------------------------------------------------------------}

  TCreateField = Class
  Private
    FCreateFields: TCreateFields;
    FFieldName: String;
    FFieldType: Integer;
    FScale: Integer;
    FPrecision: Integer;
    FSize: Integer;
    FBlobType: Integer;
    FMustDrop: Boolean; // used only in DROP TABLE
  Public
    Constructor Create( CreateFields: TCreateFields );
    Property FieldName: String Read FFieldName Write FFieldName;
    Property FieldType: Integer Read FFieldType Write FFieldType;
    Property Scale: Integer Read FScale Write FScale;
    Property Precision: Integer Read FPrecision Write FPrecision;
    Property Size: Integer Read FSize Write FSize;
    Property BlobType: Integer Read FBlobType Write FBlobType;
    Property MustDrop: Boolean Read FMustDrop Write FMustDrop; // used only in DROP TABLE
  End;

  TCreateFields = Class
  Private
    FList: TList;
    Function Get( Index: Integer ): TCreateField;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Procedure Clear;
    Procedure AddField( Const AName: String; AFieldType, AScale, APrecision,
      ASize, ABlobType: Integer; AMustDrop: Boolean );
    Function Count: Integer;
    Property Items[Index: Integer]: TCreateField Read Get; Default;
  End;

  TCreateTableItem = Class
  Private
    FCreateTableList: TCreateTableList;
    FFields: TCreateFields;
    FTableName: String;
    FPrimaryKey: TStringList;
  Public
    Constructor Create( CreateTableList: TCreateTableList );
    Destructor Destroy; Override;
    Function FieldCount: Integer;
    Property Fields: TCreateFields Read FFields;
    Property TableName: String Read FTableName Write FTableName;
    Property PrimaryKey: TStringList Read FPrimaryKey;
  End;

  TCreateTableList = Class
    FItems: TList;
    Function GetCount: Integer;
    Function GetItem( Index: Integer ): TCreateTableItem;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Function Add: TCreateTableItem;
    Procedure Clear;
    Procedure Delete( Index: Integer );
    Property Count: Integer Read GetCount;
    Property Items[Index: Integer]: TCreateTableItem Read GetItem; Default;
  End;

  {-------------------------------------------------------------------------------}
  {                  INSERT INTO section data                                     }
  {-------------------------------------------------------------------------------}

  TInsertItem = Class
  Private
    FInsertList: TInsertList;
    FTableName: String;
    FIsFullPath: Boolean;
    FFieldNames: TStringList;
    FExprList: TStringList;
    FResolverList: TList;
    FDataSet: TDataSet;
  Public
    Constructor Create( InsertList: TInsertList );
    Destructor Destroy; Override;

    Property TableName: String Read FTableName Write FTableName;
    Property IsFullPath: Boolean Read FIsFullPath Write FIsFullPath;
    Property FieldNames: TStringList Read FFieldNames;
    Property ExprList: TStringList Read FExprList;
    Property DataSet: TDataSet Read FDataSet Write FDataSet;
    Property ResolverList: TList Read FResolverList;
  End;

  TInsertList = Class
    FItems: TList;
    Function GetCount: Integer;
    Function GetItem( Index: Integer ): TInsertItem;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Function Add: TInsertItem;
    Procedure Clear;
    Procedure Delete( Index: Integer );
    Property Count: Integer Read GetCount;
    Property Items[Index: Integer]: TInsertItem Read GetItem; Default;
  End;

  {-------------------------------------------------------------------------------}
  {                  TSrtField to sort with variable type columns                 }
  {-------------------------------------------------------------------------------}

  TSrtField = Class( TObject )
  Private
    FFields: TSrtFields;
    FDataType: TExprType;
    FDataSize: Integer;
    FDesc: Boolean;
    FBufferOffset: Integer;
    Function GetData( Buffer: Pointer ): Boolean;
    Procedure SetData( Buffer: Pointer );
  Protected
    Function GetAsString: String; Virtual; Abstract;
    Procedure SetAsString( Const Value: String ); Virtual; Abstract;
   {$IFDEF LEVEL4}
    Function GetAsWideString: WideString; Virtual; Abstract;
    Procedure SetAsWideString( Const Value: WideString ); Virtual; Abstract;
   {$ENDIF}
    Function GetAsFloat: double; Virtual; Abstract;
    Procedure SetAsFloat( Value: double ); Virtual; Abstract;
    Function GetAsInteger: Longint; Virtual; Abstract;
    Procedure SetAsInteger( Value: Longint ); Virtual; Abstract;
    function GetAsLargeInt: Int64; Virtual; Abstract; {added by fduenas: fix for ftLargeInt issues}
    procedure SetAsLargeInt(const Value: Int64); Virtual; Abstract; {added by fduenas: fix for ftLargeInt issues}
    Function GetAsBoolean: Boolean; Virtual; Abstract;
    Procedure SetAsBoolean( Value: Boolean ); Virtual; Abstract;
    Procedure SetDataType( Value: TExprType );
    function NativeExprTypeSize: integer; Virtual; { patched by ccy }
  Public
    Constructor Create( Fields: TSrtFields ); Virtual;

    Property DataType: TExprType Read FDataType Write SetDataType;
    Property DataSize: Integer Read FDataSize Write FDataSize;
    Property Desc: Boolean Read FDesc Write FDesc;
    Property BufferOffset: Integer Read FBufferOffset Write FBufferOffset;

    Property AsString: String Read GetAsString Write SetAsString;
   {$IFDEF LEVEL4}
    Property AsWideString: WideString Read GetAsWideString Write SetAsWideString;
   {$ENDIF}
    Property AsFloat: Double Read GetAsFloat Write SetAsFloat;
    Property AsInteger: Longint Read GetAsInteger Write SetAsInteger;
    Property AsLargeInt: Int64 Read GetAsLargeInt Write SetAsLargeInt; {added by fduenas: fix for ftLargeInt issues}
    Property AsBoolean: Boolean Read GetAsBoolean Write SetAsBoolean;
  End;

  {-------------------------------------------------------------------------------}
  {                  TSrtStringField                                              }
  {-------------------------------------------------------------------------------}

  TSrtStringField = Class( TSrtField )
  Private
    Function GetValue( Var Value: String ): Boolean;
   {$IFDEF LEVEL4}
    Function GetWideValue( Var Value: WideString ): Boolean;
   {$ENDIF}
  Protected
    Function GetAsString: String; Override;
    Procedure SetAsString( Const Value: String ); Override;
   {$IFDEF LEVEL4}
    Function GetAsWideString: WideString; Override;
    Procedure SetAsWideString( Const Value: WideString ); Override;
   {$ENDIF}
    Function GetAsFloat: double; Override;
    Procedure SetAsFloat( Value: double ); Override;
    Function GetAsInteger: Longint; Override;
    Procedure SetAsInteger( Value: Longint ); Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: fix for ftLargeInt issues}
    Procedure SetAsLargeInt(const Value: Int64); Override; {added by fduenas: fix for ftLargeInt issues}
    Function GetAsBoolean: Boolean; Override;
    Procedure SetAsBoolean( Value: Boolean ); Override;
  Public
    Constructor Create( Fields: TSrtFields ); Override;
  End;

  {-------------------------------------------------------------------------------}
  {                  TSrtWideStringField                                          }
  {-------------------------------------------------------------------------------}
 {$IFDEF LEVEL4}
  TSrtWideStringField = Class( TSrtStringField )
  Private
    Function GetValue( Var Value: WideString ): Boolean;
  Protected
    Function GetAsString: String; Override;
    Procedure SetAsString( Const Value: String ); Override;
    Function GetAsWideString: WideString; Override;
    Procedure SetAsWideString( Const Value: WideString ); Override;
    Function GetAsFloat: double; Override;
    Procedure SetAsFloat( Value: double ); Override;
    Function GetAsInteger: Longint; Override;
    Procedure SetAsInteger( Value: Longint ); Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: fix for ftLargeInt issues}
    Procedure SetAsLargeInt(const Value: Int64); Override; {added by fduenas: fix for ftLargeInt issues}
    Function GetAsBoolean: Boolean; Override;
    Procedure SetAsBoolean( Value: Boolean ); Override;
  Public
    Constructor Create( Fields: TSrtFields ); Override;
  End;
 {$ENDIF}
  {-------------------------------------------------------------------------------}
  {                  Define TsrtFloatField                                        }
  {-------------------------------------------------------------------------------}

  TSrtFloatField = Class( TSrtField )
  Protected
    Function GetAsString: String; Override;
    Procedure SetAsString( Const Value: String ); Override;
   {$IFDEF LEVEL4}
    Function GetAsWideString: WideString; Override;
    Procedure SetAsWideString( Const Value: WideString ); Override;
   {$ENDIF}
    Function GetAsFloat: double; Override;
    Procedure SetAsFloat( Value: double ); Override;
    Function GetAsInteger: Longint; Override;
    Procedure SetAsInteger( Value: Longint ); Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: fix for ftLargeInt issues}
    Procedure SetAsLargeInt(const Value: Int64); Override; {added by fduenas: fix for ftLargeInt issues}
    Function GetAsBoolean: Boolean; Override;
    Procedure SetAsBoolean( Value: Boolean ); Override;
  Public
    Constructor Create( Fields: TSrtFields ); Override;
  End;

  {-------------------------------------------------------------------------------}
  {                  Define TsrtIntegerField                                      }
  {-------------------------------------------------------------------------------}

  TSrtIntegerField = Class( TSrtField )
  Protected
    Function GetAsString: String; Override;
    Procedure SetAsString( Const Value: String ); Override;
   {$IFDEF LEVEL4}
    Function GetAsWideString: WideString; Override;
    Procedure SetAsWideString( Const Value: WideString ); Override;
   {$ENDIF}
    Function GetAsInteger: Longint; Override;
    Procedure SetAsInteger( Value: Longint ); Override;
    Function GetAsLargeInt: Largeint; Override; {added by fduenas: fix for ftLargeInt issues}
    Procedure SetAsLargeInt(const Value: Largeint); Override; {added by fduenas: fix for ftLargeInt issues}
    Function GetAsFloat: double; Override;
    Procedure SetAsFloat( Value: double ); Override;
    Function GetAsBoolean: Boolean; Override;
    Procedure SetAsBoolean( Value: Boolean ); Override;
  Public
    Constructor Create( Fields: TSrtFields ); Override;
  End;

  {-------------------------------------------------------------------------------}
  {                  Define TsrtLargeIntField                                     }
  {-------------------------------------------------------------------------------}

  TSrtLargeIntField = Class( TSrtField )   {added by fduenas: added LargeInt (Int64) support}
  Protected
    Function GetAsString: String; Override;
    Procedure SetAsString( Const Value: String ); Override;
   {$IFDEF LEVEL4}
    Function GetAsWideString: WideString; Override;
    Procedure SetAsWideString( Const Value: WideString ); Override;
   {$ENDIF}
    Function GetAsInteger: Longint; Override;
    Procedure SetAsInteger( Value: Longint ); Override;
    Function GetAsLargeInt: Largeint; Override; {added by fduenas: fix for ftLargeInt issues}
    Procedure SetAsLargeInt(const Value: Largeint); Override; {added by fduenas: fix for ftLargeInt issues}
    Function GetAsFloat: double; Override;
    Procedure SetAsFloat( Value: double ); Override;
    Function GetAsBoolean: Boolean; Override;
    Procedure SetAsBoolean( Value: Boolean ); Override;
  Public
    Constructor Create( Fields: TSrtFields ); Override;
  End;

  {-------------------------------------------------------------------------------}
  {                  Define TSrtBooleanField                                      }
  {-------------------------------------------------------------------------------}

  TSrtBooleanField = Class( TSrtField )
  Protected
    Function GetAsString: String; Override;
    Procedure SetAsString( Const Value: String ); Override;
   {$IFDEF LEVEL4}
    Function GetAsWideString: WideString; Override;
    Procedure SetAsWideString( Const Value: WideString ); Override;
   {$ENDIF}
    Function GetAsBoolean: Boolean; Override;
    Procedure SetAsBoolean( Value: Boolean ); Override;
    Function GetAsInteger: Longint; Override;
    Procedure SetAsInteger( Value: Longint ); Override;
    Function GetAsLargeInt: Largeint; Override; {added by fduenas: fix for ftLargeInt issues}
    Procedure SetAsLargeInt(const Value: Largeint); Override; {added by fduenas: fix for ftLargeInt issues}
    Function GetAsFloat: double; Override;
    Procedure SetAsFloat( Value: double ); Override;
  Public
    Constructor Create( Fields: TSrtFields ); Override;
  End;

  {-------------------------------------------------------------------------------}
  {                  Define TSrtFields                                            }
  {-------------------------------------------------------------------------------}

  TSrtFields = Class
    FSortList: TxqSortList;
    FItems: TList;
    Function GetCount: Integer;
    Function GetItem( Index: Integer ): TSrtField;
  protected
    fRuntimeFormatSettings: TFormatSettings;
    fSystemFormatSettings: TFormatSettings;
  Public
    Constructor Create( SortList: TxqSortList );
    Destructor Destroy; Override;
    Function Add( DataType: TExprType ): TSrtField;
    Procedure Clear;

    Property Count: Integer Read GetCount;
    Property Items[Index: Integer]: TSrtField Read GetItem; Default;
    Property SortList: TxqSortList Read FSortList;
  End;

  {-------------------------------------------------------------------------------}
  {                  Define TxqSortList                                           }
  {-------------------------------------------------------------------------------}
  TxqSortList = Class( TObject )
  Private
    FFields: TSrtFields;
    FRecNo: Integer;
    FRecordBufferSize: Integer;
    FUsingBookmark: Boolean;
    FBookmarkedDataset: TDataset;
    FSelected: TList;
    FBofCrack: Boolean;
    FEofCrack: Boolean;
    FFilterRecno: Integer;

    function ActiveBuffer: TxBuffer; virtual; abstract;  {patched by fduenas}
  {$IFNDEF XQ_USE_FASTCOMPARE_FUNCTIONS}
    Function DoCompare( N: Integer; Const KeyValue: Variant ): Integer; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  {$ELSE}
    Function DoCompareFast( N: Integer; Const KeyValue: Variant ): Integer; {added by fduenas, obtimized} {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  {$ENDIF}
    Function Find( Const KeyValue: Variant; Var Index: Integer ): Boolean;
    procedure SetBookmarkedDataset(const Value: TDataset);
  Protected
    fRuntimeFormatSettings: TFormatSettings;
    fSystemFormatSettings: TFormatSettings;
    Function GetFieldData( Field: TSrtField; Buffer: Pointer ): Boolean; Virtual; Abstract;
    Procedure SetFieldData( Field: TSrtField; Buffer: Pointer ); Virtual; Abstract;
    Procedure SetRecno( Value: Integer );
    Function GetRecno: Integer;
    Procedure SetSourceRecno( Value: Integer ); Virtual; Abstract;
    Function GetSourceRecno: Integer; Virtual; Abstract;
    Function GetRecordCount: Integer; Virtual; Abstract;
    {$if RtlVersion >= 20}
    function GetSourceBookmark: TBookmark; virtual; abstract; { patched by ccy }
    procedure SetSourceBookmark(const Value: TBookmark); virtual; abstract; { patched by ccy }
    {$ifend}
  Public
    Constructor Create( UsingBookmark: Boolean;
     aRuntimeSettings, aSystemSettings: TFormatSettings  );

    Destructor Destroy; Override;
    Procedure AddField( pDataType: TExprType; pDataSize: Integer;
      pDescending: Boolean );
    Procedure Insert; Virtual; Abstract;
    Procedure Sort;
    Procedure Exchange( Recno1, Recno2: Integer ); Virtual; Abstract;
    Procedure Clear; Virtual;
    Function IsEqual( Recno1, Recno2: Integer ): Boolean;
    Procedure Filter( Const KeyValue: Variant );
    Procedure First;
    Procedure Next;
    Function Eof: Boolean;
    Function Bof: Boolean;

    Property Count: Integer Read GetRecordCount;
    Property Recno: Integer Read GetRecno Write SetRecno;
    Property FilterRecno: Integer Read FFilterRecno Write FFilterRecno;
    Property SourceRecno: Integer Read GetSourceRecno Write SetSourceRecno;
    {$if RtlVersion >= 20}
    property SourceBookmark: TBookmark read GetSourceBookmark write
        SetSourceBookmark; { patched by ccy }
    {$ifend}
    Property Fields: TSrtFields Read FFields;
    property BookmarkedDataset: TDataset read FBookmarkedDataset write
        SetBookmarkedDataset; { patched by ccy }
    Property UsingBookmark: Boolean read FUsingBookmark write FUsingBookmark;
  End;

  TMemSortList = Class( TxqSortList )
  Private
    FBufferList: TList{$IF RtlVersion>20}<TxBuffer>{$IFEND}; { patched by fduenas }
    function ActiveBuffer: TxBuffer; override; {patched by fduenas}
  Protected
    Function GetFieldData( Field: TSrtField; Buffer: Pointer ): Boolean; Override;
    Procedure SetFieldData( Field: TSrtField; Buffer: Pointer ); Override;
    Function GetRecordCount: Integer; Override;
    Procedure SetSourceRecno( Value: Integer ); Override;
    Function GetSourceRecno: Integer; Override;
    {$if RtlVersion >= 20}
    function GetSourceBookmark: TBookmark; override;
    procedure SetSourceBookmark(const Value: TBookmark); override;
    {$ifend}
  Public
    Constructor Create( UsingBookmark: Boolean;
     aRuntimeSettings, aSystemSettings: TFormatSettings  );
    Destructor Destroy; Override;
    Procedure Insert; Override;
    Procedure Exchange( Recno1, Recno2: Integer ); Override;
    Procedure Clear; Override;
  End;

  TFileSortList = Class( TxqSortList )
  Private
    FBufferList: TList{$IF RtlVersion>20}<TxBuffer>{$IFEND}; { patched by fduenas }
    FMemMapFile: TMemMapFile;
    FTmpFile: String;
    FBuffer: TxBuffer; {patched by fduenas}
    function ActiveBuffer: TxBuffer; override; {patched by fduenas}
  Protected
    Function GetFieldData( Field: TSrtField; Buffer: Pointer ): Boolean; Override;
    Procedure SetFieldData( Field: TSrtField; Buffer: Pointer ); Override;
    Function GetRecordCount: Integer; Override;
    Procedure SetSourceRecno( Value: Integer ); Override;
    Function GetSourceRecno: Integer; Override;
    {$if RtlVersion >= 20}
    function GetSourceBookmark: TBookmark; override;
    procedure SetSourceBookmark(const Value: TBookmark); override;
    {$ifend}
  Public
    Constructor Create( UsingBookmark: Boolean; MapFileSize: Longint;
     aRuntimeSettings, aSystemSettings: TFormatSettings  );
    Destructor Destroy; Override;
    Procedure Insert; Override;
    Procedure Exchange( Recno1, Recno2: Integer ); Override;
    Procedure Clear; Override;
  End;

  {-------------------------------------------------------------------------------}
  {                  Define TUserDefinedRange                                     }
  {-------------------------------------------------------------------------------}

  { this class is used for handling this kind of syntax:
    SELECT * FROM MOVES SET RANGE FROM 1000 TO 3000 USING INDEX "CUSTNO_INDEX" ;

    and is implemented only in certain situations where it is possible to
    optimize by end-user .
  }

  TUserDefinedRange = Class
  Private
    FForFields: TxNativeTStrings;
    FStartValues: TxNativeTStrings;
    FEndValues: TxNativeTStrings;
    FUsingIndex: TxNativeString;
    FStartResolvers: TList;
    FEndResolvers: TList;
    Procedure ClearResolvers;
  Public
    Constructor Create;
    Destructor Destroy; Override;

    Property ForFields: TxNativeTStrings Read FForFields;
    Property StartValues: TxNativeTStrings Read FStartValues;
    Property EndValues: TxNativeTStrings Read FEndValues;
    Property UsingIndex: TxNativeString Read FUsingIndex Write FUsingIndex;
  End;

  {-------------------------------------------------------------------------------}
  {                  Define TMemMapFile                                           }
  {-------------------------------------------------------------------------------}

  TMemMapFile = Class( TObject )
  Private
    FFileName: String;
    FSize: Longint;
    FFileSize: Longint;
    FFileMode: Integer;
    FFileHandle: Integer;
    FMapHandle: Integer;
    FData: PChar;
    FMapNow: Boolean;
    FPosition: Longint;
    FVirtualSize: Longint;

    Procedure AllocFileHandle;
    Procedure AllocFileMapping;
    Procedure AllocFileView;
    Function GetSize: Longint;
  Public
    Constructor Create( FileName: String; FileMode: integer;
      Size: integer; MapNow: Boolean ); Virtual;
    Destructor Destroy; Override;
    Procedure FreeMapping;
    Procedure Read( Var Buffer; Count: Longint );
    Procedure Write( Const Buffer; Count: Longint );
    Procedure Seek( Offset: Longint; Origin: Word );

    Property Data: PChar Read FData;
    Property Size: Longint Read GetSize;
    Property VirtualSize: Longint Read FVirtualSize;
    Property Position: Longint Read FPosition;
    Property FileName: String Read FFileName;
    Property FileHandle: Integer Read FFileHandle;
    Property MapHandle: Integer Read FMapHandle;
  End;

  {---------------------------------------------------------------------------}
  {                  Define TParamsAsFieldsItem                               }
  {---------------------------------------------------------------------------}

  TParamsAsFieldsItem = Class( TCollectionItem )
  Private
    FName: string;
    FValue: string;
    Procedure SetName( const Value: string );
    Procedure SetValue( Const Value: String );
  Protected
    Function GetDisplayName: String; Override;
  Public
    Procedure Assign( Source: TPersistent ); Override;
  Published
    Property Name: String Read FName Write SetName;
    Property Value: String Read FValue Write SetValue;
  End;

  {----------------------------------------------------------------------------}
  {                  Define TParamsAsFields                                    }
  {----------------------------------------------------------------------------}

  TParamsAsFields = Class( TOwnedCollection )
  Private
    Function GetItem( Index: Integer ): TParamsAsFieldsItem;
    Procedure SetItem( Index: Integer; Value: TParamsAsFieldsItem );
  Public
    Constructor Create( AOwner: TPersistent );
    Function Add: TParamsAsFieldsItem;
    function ParamByName(const Value: string): TParamsAsFieldsItem;
    Property Items[Index: Integer]: TParamsAsFieldsItem Read GetItem Write SetItem; Default;
  End;

  { TIntegerList class }

  TxqIntegerList = Class
  Private
    FList: TList;
    Function Get( Index: Integer ): Integer;
    Procedure Put( Index: Integer; Value: Integer );
    Function GetCapacity: Integer;
    Procedure SetCapacity( Value: Integer );
    Function GetCount: Integer;
    Procedure SetCount( Value: Integer );
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Procedure Assign( AList: TxqIntegerList );
    Function Add( Item: Integer ): Integer;
    Procedure Clear;
    Procedure Delete( Index: Integer );
    Procedure Insert( Index: Integer; Value: Integer );
    Function IndexofValue( Item: Integer ): Integer;
    Procedure Sort;
    Function Find(Value: Integer; var Index: Integer): Boolean;
    procedure LoadFromStream( Stream: TStream );
    Procedure SaveToStream( Stream: TStream );
    Procedure LoadFromFile( const FileName: string );
    Procedure SaveToFile( const FileName: string );
    Procedure Reindex;

    Property Items[Index: Integer]: Integer Read Get Write Put; Default;
    Property Capacity: Integer Read GetCapacity Write SetCapacity;
    Property Count: Integer Read GetCount Write SetCount;
  End;


Implementation

Uses
  XQuery, XQConsts, QCnvStrUtils
{$IFDEF LEVEL6}
  , Variants
{$ENDIF}
  , StrUtils, Math;

{-------------------------------------------------------------------------------}
{                  Implement TColumnItem                                        }
{-------------------------------------------------------------------------------}

Constructor TColumnItem.Create( ColumnList: TColumnList );
Begin
  Inherited Create;
  FColumnList := ColumnList;
  FAggregateList := TAggregateList.Create;
  FSubQueryList := TList.Create;
  FAutoFree := True;
End;

Destructor TColumnItem.Destroy;
Var
  i: Integer;
Begin
  FAggregateList.Free;
  If FAutoFree And Assigned( FResolver ) Then
     FreeAndNil(FResolver);
  For i := 0 To FSubQueryList.Count - 1 Do
    TSqlAnalizer( FSubQueryList[i] ).Free;
  FSubQueryList.Free;
  Inherited Destroy;
End;

procedure TColumnItem.ReleaseResolver;
begin
 FreeAndNil(FResolver);
end;

{-------------------------------------------------------------------------------}
{                  Implement TColumnList                                        }
{-------------------------------------------------------------------------------}

Constructor TColumnList.Create;
Begin
  Inherited Create;
  FItems := TList.Create;
End;

Destructor TColumnList.Destroy;
Begin
  Clear;
  FItems.Free;
  Inherited Destroy;
End;

Function TColumnList.GetCount;
Begin
  Result := FItems.Count;
End;

Function TColumnList.GetItem( Index: Integer ): TColumnItem;
Begin
  Result := FItems[Index];
End;

Function TColumnList.Add: TColumnItem;
Begin
  Result := TColumnItem.Create( Self );
  FItems.Add( Result );
End;

Procedure TColumnList.Clear;
Var
  I: Integer;
Begin
  For I := 0 To FItems.Count - 1 Do
      TColumnItem( FItems[I] ).Free;
  FItems.Clear;
End;

Procedure TColumnList.Delete( Index: Integer );
Begin
  TColumnItem( FItems[Index] ).Free;
  FItems.Delete( Index );
End;

Procedure TColumnList.DeleteAggregate( RecNo: Integer );
Var
  I, J: Integer;
Begin
  For I := 0 To FItems.Count - 1 Do
    With TColumnItem( FItems[I] ) Do
      For J := 0 To AggregateList.Count - 1 Do
        AggregateList[J].SparseList.Delete( RecNo );
End;

Procedure TColumnList.SortAggregateWithList( SortList: TxqSortList );
Var
  I, J, K,
    Index: Integer;
  SparseList: TAggSparseList;
Begin
  For I := 0 To FItems.Count - 1 Do
    With TColumnItem( FItems[I] ) Do
      For J := 0 To AggregateList.Count - 1 Do
      Begin
        { if this columns contains aggregate functions, the value for every
          record is saved on TColumnItem(FItems[I]).AggregateList[J].SparseList.Values[Index]
          where J is the No. of aggregate (several aggregates accepted on every column)
          and Index is the number of record on the result set}
        SparseList := TAggSparseList.Create( 1000 );
        For K := 1 To SortList.Count Do
        Begin
          SortList.Recno := K;
          Index := SortList.SourceRecno;
          If AggregateList[J].SparseList.HasData(Index) Then
          Begin
            SparseList.Values[K] := AggregateList[J].SparseList.Values[Index];
            SparseList.Count[K] := AggregateList[J].SparseList.Count[Index];
          End;
        End;
        AggregateList[J].SparseList.Free;
        AggregateList[J].SparseList := SparseList;
      End;
End;

{-------------------------------------------------------------------------------}
{                  Implement TTableItem                                         }
{-------------------------------------------------------------------------------}

Constructor TTableItem.Create( TableList: TTableList );
Begin
  Inherited Create;
  FTableList := TableList;
  FNumSubquery:= -1;  // means no subquery defined for this
End;

{-------------------------------------------------------------------------------}
{                  Implement TTableList                                         }
{-------------------------------------------------------------------------------}

Constructor TTableList.Create;
Begin
  Inherited Create;
  FItems := TList.Create;
End;

Destructor TTableList.Destroy;
Begin
  Clear;
  FItems.Free;
  Inherited Destroy;
End;

Function TTableList.GetCount;
Begin
  Result := FItems.Count;
End;

Function TTableList.GetItem( Index: Integer ): TTableItem;
Begin
  Result := FItems[Index];
End;

Function TTableList.Add: TTableItem;
Begin
  Result := TTableItem.Create( Self );
  FItems.Add( Result );
End;

Procedure TTableList.Clear;
Var
  I: Integer;
Begin
  For I := 0 To FItems.Count - 1 Do
    TTableItem( FItems[I] ).Free;
  FItems.Clear;
End;

Procedure TTableList.Delete( Index: Integer );
Begin
  TTableItem( FItems[Index] ).Free;
  FItems.Delete( Index );
End;

Function TTableList.IndexOFDataSet( DataSet: TDataSet ): Integer;
Var
  Idx: Integer;
Begin
  Result := -1;
  For Idx := 0 To FItems.Count - 1 Do
    If TTableItem( FItems[Idx] ).DataSet = DataSet Then
    Begin
      Result := Idx;
      Exit;
    End;
End;

Function TTableList.IndexOFTableName( Const tableName: String ): Integer; // 1.56 fix
Var
  Idx: Integer;
Begin
  Result := -1;
  For Idx := 0 To FItems.Count - 1 Do
    If AnsiCompareText( TTableItem( FItems[Idx] ).TableName, TableName ) = 0 Then
    Begin
      Result := Idx;
      Exit;
    End;
End;

Function TTableList.IndexOFAlias( Const Alias: String ): Integer; // 1.56 fix
Var
  Idx: Integer;
Begin
  Result := -1;
  For Idx := 0 To FItems.Count - 1 Do
    If AnsiCompareText( TTableItem( FItems[Idx] ).Alias, Alias ) = 0 Then
    Begin
      Result := Idx;
      Exit;
    End;
End;

{-------------------------------------------------------------------------------}
{                  Implement TOrderByItem                                       }
{-------------------------------------------------------------------------------}

Constructor TOrderByItem.Create( OrderByList: TOrderByList );
Begin
  Inherited Create;
  FOrderByList := OrderByList;
End;

{-------------------------------------------------------------------------------}
{                  Implement TOrderByList                                       }
{-------------------------------------------------------------------------------}

Constructor TOrderByList.Create;
Begin
  Inherited Create;
  FItems := TList.Create;
End;

Destructor TOrderByList.Destroy;
Begin
  Clear;
  FItems.Free;
  Inherited Destroy;
End;

Function TOrderByList.GetCount;
Begin
  Result := FItems.Count;
End;

Function TOrderByList.GetItem( Index: Integer ): TOrderByItem;
Begin
  Result := FItems[Index];
End;

Function TOrderByList.Add: TOrderByItem;
Begin
  Result := TOrderByItem.Create( Self );
  FItems.Add( Result );
End;

Procedure TOrderByList.Clear;
Var
  I: Integer;
Begin
  For I := 0 To FItems.Count - 1 Do
    TOrderByItem( FItems[I] ).Free;
  FItems.Clear;
End;

Procedure TOrderByList.Delete( Index: Integer );
Begin
  TOrderByItem( FItems[Index] ).Free;
  FItems.Delete( Index );
End;

{-------------------------------------------------------------------------------}
{                  Implement TUpdateItem                                        }
{-------------------------------------------------------------------------------}

Constructor TUpdateItem.Create( UpdateList: TUpdateList );
Begin
  Inherited Create;
  FUpdateList := UpdateList;
End;

Destructor TUpdateItem.Destroy;
Begin
  If Assigned( FResolver ) Then
    FreeAndNil(FResolver);
  Inherited Destroy;
End;

procedure TUpdateItem.ReleaseResolver;
begin
 FreeAndNil(FResolver);
end;

{-------------------------------------------------------------------------------}
{                  Implement TUpdateList                                        }
{-------------------------------------------------------------------------------}

Function TUpdateList.GetCount;
Begin
  Result := FItems.Count;
End;

Function TUpdateList.GetItem( Index: Integer ): TUpdateItem;
Begin
  Result := FItems[Index];
End;

Constructor TUpdateList.Create;
Begin
  Inherited Create;
  FItems := TList.Create;
End;

Destructor TUpdateList.Destroy;
Begin
  Clear;
  FItems.Free;
  Inherited Destroy;
End;

Function TUpdateList.Add: TUpdateItem;
Begin
  Result := TUpdateItem.Create( Self );
  FItems.Add( Result );
End;

Procedure TUpdateList.Clear;
Var
  I: Integer;
Begin
  For I := 0 To FItems.Count - 1 Do
    TUpdateItem( FItems[I] ).Free;
  FItems.Clear;
End;

Procedure TUpdateList.Delete( Index: Integer );
Begin
  TUpdateItem( FItems[Index] ).Free;
  FItems.Delete( Index );
End;

{-------------------------------------------------------------------------------}
{                  Implement TWhereOptimizeItem                                 }
{-------------------------------------------------------------------------------}

Constructor TWhereOptimizeItem.Create( WhereOptimizeList: TWhereOptimizeList );
Begin
  Inherited Create;
  FWhereOptimizeList := WhereOptimizeList;
End;

{-------------------------------------------------------------------------------}
{                  Implement TWhereOptimizeList                                 }
{-------------------------------------------------------------------------------}

Function TWhereOptimizeList.GetCount;
Begin
  Result := FItems.Count;
End;

Function TWhereOptimizeList.GetItem( Index: Integer ): TWhereOptimizeItem;
Begin
  Result := FItems[Index];
End;

Constructor TWhereOptimizeList.Create;
Begin
  Inherited Create;
  FItems := TList.Create;
End;

Destructor TWhereOptimizeList.Destroy;
Begin
  Clear;
  FItems.Free;
  Inherited Destroy;
End;

Procedure TWhereOptimizeList.Assign( OptimizeList: TWhereOptimizeList );
Var
  Item: TWhereOptimizeItem;
  I: Integer;
Begin
  Clear;
  For I := 0 To OptimizeList.Count - 1 Do
  Begin
    Item := Self.Add;
    With OptimizeList[I] Do
    Begin
      Item.DataSet := Dataset;
      Item.FieldNames := Fieldnames;
      Item.RangeStart := Rangestart;
      Item.Rangeend := Rangeend;
      Item.RelOperator := Reloperator;
      Item.CanOptimize := Canoptimize;
    End;
  End;
End;

Function TWhereOptimizeList.Add: TWhereOptimizeItem;
Begin
  Result := TWhereOptimizeItem.Create( Self );
  FItems.Add( Result );
End;

Procedure TWhereOptimizeList.Clear;
Var
  I: Integer;
Begin
  For I := 0 To FItems.Count - 1 Do
    TWhereOptimizeItem( FItems[I] ).Free;
  FItems.Clear;
End;

Procedure TWhereOptimizeList.Delete( Index: Integer );
Begin
  TWhereOptimizeItem( FItems[Index] ).Free;
  FItems.Delete( Index );
End;

{-------------------------------------------------------------------------------}
{                  Implement TCreateField                                       }
{-------------------------------------------------------------------------------}

Constructor TCreateField.Create( CreateFields: TCreateFields );
Begin
  Inherited Create;
  FCreateFields := CreateFields;
End;

{-------------------------------------------------------------------------------}
{                  Implement TCreateFields                                      }
{-------------------------------------------------------------------------------}

Constructor TCreateFields.Create;
Begin
  Inherited Create;
  FList := TList.Create;
End;

Destructor TCreateFields.Destroy;
Begin
  Clear;
  FList.Free;
  Inherited;
End;

Procedure TCreateFields.AddField( Const AName: String;
  AFieldType,
  AScale,
  APrecision,
  ASize,
  ABlobType: Integer;
  AMustDrop: Boolean );
Var
  NewField: TCreateField;
Begin
  NewField := TCreateField.Create( Self );
  With NewField Do
  Begin
    FieldName := AName;
    FieldType := AFieldType;
    Scale := AScale;
    Precision := APrecision;
    Size := ASize;
    BlobType := ABlobType;
    MustDrop := AMustDrop;
  End;
  FList.Add( NewField );
End;

Procedure TCreateFields.Clear;
Var
  I: Integer;
Begin
  For I := 0 To FList.Count - 1 Do
    TCreateField( FList[I] ).Free;
  FList.Clear;
End;

Function TCreateFields.Get( Index: Integer ): TCreateField;
Begin
  Result := Nil;
  If ( Index < 0 ) Or ( Index > FList.Count - 1 ) Then
    exit;
  Result := TCreateField( FList[Index] );
End;

Function TCreateFields.Count: Integer;
Begin
  Result := FList.Count;
End;

{-------------------------------------------------------------------------------}
{                  Implement TCreateTableItem                                   }
{-------------------------------------------------------------------------------}

Constructor TCreateTableItem.Create( CreateTableList: TCreateTableList );
Begin
  Inherited Create;
  FCreateTableList := CreateTableList;
  FFields := TCreateFields.Create;
  FPrimaryKey := TStringList.Create;
End;

Destructor TCreateTableItem.Destroy;
Begin
  FFields.Free;
  FPrimaryKey.Free;
  Inherited Destroy;
End;

Function TCreateTableItem.FieldCount: Integer;
Begin
  Result := FFields.Count;
End;

{-------------------------------------------------------------------------------}
{                  Implement TCreateTableList                                   }
{-------------------------------------------------------------------------------}

Constructor TCreateTableList.Create;
Begin
  Inherited Create;
  FItems := TList.Create;
End;

Destructor TCreateTableList.Destroy;
Begin
  Clear;
  FItems.Free;
  Inherited Destroy;
End;

Function TCreateTableList.GetCount;
Begin
  Result := FItems.Count;
End;

Function TCreateTableList.GetItem( Index: Integer ): TCreateTableItem;
Begin
  Result := FItems[Index];
End;

Function TCreateTableList.Add: TCreateTableItem;
Begin
  Result := TCreateTableItem.Create( Self );
  FItems.Add( Result );
End;

Procedure TCreateTableList.Clear;
Var
  I: Integer;
Begin
  For I := 0 To FItems.Count - 1 Do
    TCreateTableItem( FItems[I] ).Free;
  FItems.Clear;
End;

Procedure TCreateTableList.Delete( Index: Integer );
Begin
  TCreateTableItem( FItems[Index] ).Free;
  FItems.Delete( Index );
End;

{-------------------------------------------------------------------------------}
{                  Implement TInsertItem                                        }
{-------------------------------------------------------------------------------}

Constructor TInsertItem.Create( InsertList: TInsertList );
Begin
  Inherited Create;
  FInsertList := InsertList;
  FFieldNames := TStringList.Create;
  FExprList := TStringList.Create;
  FResolverList := TList.Create;
End;

Destructor TInsertItem.Destroy;
Var
  I: Integer;
  Resolver: TExprParser;
Begin
  FFieldNames.Free;
  FExprList.Free;
  For I := 0 To FResolverList.Count - 1 Do
  Begin
    Resolver := TExprParser( FResolverList[I] );
    If Assigned( Resolver ) Then
      FreeAndNil(Resolver);
  End;
  FResolverList.Free;
  Inherited Destroy;
End;

{-------------------------------------------------------------------------------}
{                  Implement TInsertList                                        }
{-------------------------------------------------------------------------------}

Constructor TInsertList.Create;
Begin
  Inherited Create;
  FItems := TList.Create;
End;

Destructor TInsertList.Destroy;
Begin
  Clear;
  FItems.Free;
  Inherited Destroy;
End;

Function TInsertList.GetCount;
Begin
  Result := FItems.Count;
End;

Function TInsertList.GetItem( Index: Integer ): TInsertItem;
Begin
  Result := FItems[Index];
End;

Function TInsertList.Add: TInsertItem;
Begin
  Result := TInsertItem.Create( Self );
  FItems.Add( Result );
End;

Procedure TInsertList.Clear;
Var
  I: Integer;
Begin
  For I := 0 To FItems.Count - 1 Do
    TInsertItem( FItems[I] ).Free;
  FItems.Clear;
End;

Procedure TInsertList.Delete( Index: Integer );
Begin
  TInsertItem( FItems[Index] ).Free;
  FItems.Delete( Index );
End;

{-------------------------------------------------------------------------------}
{                  implements TSrtField                                         }
{-------------------------------------------------------------------------------}

Constructor TSrtField.Create( Fields: TSrtFields );
Begin
  Inherited Create;
  FFields := Fields;
End;

Function TSrtField.GetData( Buffer: Pointer ): Boolean;
Begin
  Result := FFields.FSortList.GetFieldData( Self, Buffer );
End;

function TSrtField.NativeExprTypeSize: integer;
begin
 Result := SizeOfExprType( FDataType );
end;

Procedure TSrtField.SetData( Buffer: Pointer );
Begin
  FFields.FSortList.SetFieldData( Self, Buffer );
End;

Procedure TSrtField.SetDataType( Value: TExprType );
Begin
  FDataType := Value;
End;

{-------------------------------------------------------------------------------}
{                  implements TSrtStringField                                   }
{-------------------------------------------------------------------------------}

Constructor TSrtStringField.Create( Fields: TSrtFields );
Begin
  Inherited Create( Fields );
  SetDataType( ttString );
End;

Function TSrtStringField.GetValue( Var Value: String ): Boolean;
Var
  Buffer: Array[0..dsMaxStringSize] Of Char;
Begin
  FillChar( Buffer, dsMaxStringSize, #0 ); {added by fduenas} {this prevents some DISTINCT errors}
  Result := GetData( @Buffer );
  If Result Then
    Value := Buffer;
End;
{$IFDEF LEVEL4}
function TSrtStringField.GetWideValue(var Value: WideString): Boolean;
Var
  Buffer: Array[0..dsMaxStringSize] Of AnsiChar;
Begin
  FillChar( Buffer, dsMaxStringSize, #0 ); {added by fduenas} {this prevents some DISTINCT errors}
  Result := GetData( @Buffer );
  If Result Then
     Value := WideString( Buffer );
End;
{$ENDIF}

Function TSrtStringField.GetAsString: String;
Begin
  If Not GetValue( Result ) Then
    Result := '';
End;
{$IFDEF LEVEL4}
function TSrtStringField.GetAsWideString: WideString;
begin
 If Not GetWideValue( Result ) Then
    Result := '';
end;
{$ENDIF}
Procedure TSrtStringField.SetAsString( Const Value: String );
Var
  Buffer: Array[0..dsMaxStringSize] Of Char;
  //AnsiBuffer: Array[0..dsMaxStringSize] Of AnsiChar;
  //AnsiValue : AnsiString;
  //L: Integer;
Begin
  {FillChar( Buffer, FDataSize, 0 );}
  FillChar( Buffer, dsMaxStringSize, #0 ); {pacthed by fduenas} {added by fduenas} {this prevents some DISTINCT errors}
  //FillChar( AnsiBuffer, dsMaxStringSize, #0 ); {pacthed by fduenas} {added by fduenas} {this prevents some DISTINCT errors}
  //AnsiValue := ansistring( Value );
  //L := Length( Value );
  {StrLCopy( Buffer, PChar( Value ), L );}
  //StrLCopy(AnsiBuffer, PAnsiChar(AnsiValue), L);
  CopyMemory(@Buffer[0], PChar(Value), Length( Value ) * {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Char){$ELSE}XQ_SizeOf_Char{$ENDIF} ); { changed by fduenas }
  SetData( @Buffer );
End;
{$IFDEF LEVEL4}
procedure TSrtStringField.SetAsWideString(const Value: WideString);
Var
  Buffer: Array[0..dsMaxStringSize] Of WideChar;
  //L: Integer;
Begin
  {FillChar( Buffer, FDataSize, 0 );}
  FillChar( Buffer, dsMaxStringSize, #0 ); {pacthed by fduenas} {added by fduenas} {this prevents some DISTINCT errors}
  //L := Length( Value );
  {StrLCopy( Buffer, PChar( Value ), L );}
  CopyMemory(@Buffer[0], PWideChar(Value), Length( Value ) * NativeExprTypeSize); { changed by fduenas }
  SetData( @Buffer );
End;
{$ENDIF}
Function TSrtStringField.GetAsFloat: Double;
Begin
  Result := StrToFloat( GetAsString {$IFDEF Delphi7Up}, FFields.fRuntimeFormatSettings{$ENDIF} );
End;

Procedure TSrtStringField.SetAsFloat( Value: double );
Begin
 SetAsString( FloatToStr(Value{$IFDEF Delphi7Up}, FFields.fRuntimeFormatSettings{$ENDIF}) );
End;

Function TSrtStringField.GetAsInteger: Longint;
Begin
  Result := StrToInt(GetAsString);
End;

function TSrtStringField.GetAsLargeInt: Int64;
begin
  Result := StrToInt64(GetAsString);
end;

Procedure TSrtStringField.SetAsInteger( Value: Longint );
Begin
 SetAsString( IntToStr(Value) );
End;

procedure TSrtStringField.SetAsLargeInt(const Value: Int64);
begin
 SetAsString( IntToStr(Value) );
end;

Function TSrtStringField.GetAsBoolean: Boolean;
Var
  S: String;
Begin
  S := GetAsString;
  Result := (Length(S) > 0) And
   (CharInSet(S[1], xqtypes.SBooleanValues) OR
    SameText(Trim(S), xqtypes.NBoolean[True]) ) ;
End;

Procedure TSrtStringField.SetAsBoolean( Value: Boolean );
Begin
 SetAsWideString(Copy(xqtypes.NBoolean[Value], 1, 1));
End;
{$IFDEF LEVEL4}
{ TSrtWideStringField }

constructor TSrtWideStringField.Create(Fields: TSrtFields);
Begin
  Inherited Create( Fields );
  SetDataType( ttWideString );
End;

function TSrtWideStringField.GetAsBoolean: Boolean;
Var
  S: WideString;
Begin
  S := GetAsWideString;
  Result := (Length(S) > 0) And
   (CharInSet(S[1], xqtypes.SBooleanValues) OR
    WideSameText(Trim(S), xqtypes.NBoolean[True]) ) ;
End;

function TSrtWideStringField.GetAsFloat: double;
begin
 result := StrToFloat( GetAsWideString {$IFDEF Delphi7Up}, FFields.fRuntimeFormatSettings{$ENDIF});
end;

function TSrtWideStringField.GetAsInteger: Longint;
begin
 result := StrToInt( GetAsWideString );
end;

function TSrtWideStringField.GetAsLargeInt: Int64;
begin
 result := StrToInt64( GetAsWideString );
end;

function TSrtWideStringField.GetAsString: String;
var _result: WideString;
begin
 If Not GetValue( _result ) Then
    _result := '';
 Result := _result;
end;

function TSrtWideStringField.GetAsWideString: WideString;
begin
   If Not GetValue( Result ) Then
    Result := '';
end;

function TSrtWideStringField.GetValue(var Value: WideString): Boolean;
Var
  Buffer: Array[0..dsMaxStringSize] Of WideChar;
Begin
  FillChar( Buffer, dsMaxStringSize, #0 ); {added by fduenas} {this prevents some DISTINCT errors}
  Result := GetData( @Buffer );
  If Result Then
    Value := Buffer;
End;

procedure TSrtWideStringField.SetAsBoolean(Value: Boolean);
begin
  SetAsWideString(Copy(xqtypes.NBoolean[Value], 1, 1));
end;

procedure TSrtWideStringField.SetAsFloat(Value: double);
begin
 SetAsWideString( FloatToStr(Value{$IFDEF Delphi7Up}, FFields.fRuntimeFormatSettings{$ENDIF}) );
end;

procedure TSrtWideStringField.SetAsInteger(Value: Integer);
begin
 SetAsWideString( IntToStr(Value) );
end;

procedure TSrtWideStringField.SetAsLargeInt(const Value: Int64);
begin
 SetAsWideString( IntToStr(Value) );
end;

procedure TSrtWideStringField.SetAsString(const Value: String);
Var
  Buffer: Array[0..dsMaxStringSize] Of WideChar;
  //L: Integer;
Begin
  {FillChar( Buffer, FDataSize, 0 );}
  FillChar( Buffer, dsMaxStringSize, #0 ); {pacthed by fduenas} {added by fduenas} {this prevents some DISTINCT errors}
  //L := Length( Value );
  {StrLCopy( Buffer, PChar( Value ), L );}
  CopyMemory(@Buffer[0], PWideChar(Value), Length( Value ) * NativeExprTypeSize); { changed by fduenas }
  SetData( @Buffer );
End;

procedure TSrtWideStringField.SetAsWideString(const Value: WideString);
Var
  Buffer: Array[0..dsMaxStringSize] Of WideChar;
  //L: Integer;
Begin
  {FillChar( Buffer, FDataSize, 0 );}
  FillChar( Buffer, dsMaxStringSize, #0 ); {pacthed by fduenas} {added by fduenas} {this prevents some DISTINCT errors}
  //L := Length( Value );
  {StrLCopy( Buffer, PChar( Value ), L );}
  CopyMemory(@Buffer[0], PWideChar(Value), Length( Value ) * NativeExprTypeSize); { changed by fduenas }
  SetData( @Buffer );
End;
{$ENDIF}
{-------------------------------------------------------------------------------}
{                  implements TSrtFloatField                                        }
{-------------------------------------------------------------------------------}

Constructor TSrtFloatField.Create( Fields: TSrtFields );
Begin
  Inherited Create( Fields );
  SetDataType( ttFloat );
End;

Function TSrtFloatField.GetAsFloat: double;
Begin
  If Not GetData( @Result ) Then
    Result := 0;
End;

Procedure TSrtFloatField.SetAsFloat( Value: double );
Begin
  SetData( @Value );
End;

Function TSrtFloatField.GetAsString: String;
Var
  F: Double;
Begin
  If GetData( @F ) Then
    Result := FloatToStr( F{$IFDEF Delphi7Up}, FFields.fRuntimeFormatSettings{$ENDIF} )
  Else
    Result := '';
End;

function TSrtFloatField.GetAsWideString: WideString;
begin
 Result := GetAsString;
End;

Procedure TSrtFloatField.SetAsString( Const Value: String );
Var
  F: Extended;
Begin
  If Value = '' Then
    SetAsFloat( 0 )
  Else
  Begin
    If Not TextToFloat( PChar( Value ), F, fvExtended{$IFDEF Delphi7Up}, FFields.fRuntimeFormatSettings{$ENDIF} ) Then
      raise EXQueryError.CreateFmt( SIsInvalidFloatValue, [Value] );
    SetAsFloat( F );
  End;
End;

procedure TSrtFloatField.SetAsWideString(const Value: WideString);
Var
  F: Extended;
Begin
  If Value = '' Then
    SetAsFloat( 0 )
  Else
  Begin
    If Not TextToFloat( {$IFDEF Delphi2009Up}PChar{$ELSE}PChar{$ENDIF}( Value ), F, fvExtended{$IFDEF Delphi7Up}, FFields.fRuntimeFormatSettings{$ENDIF} ) Then
      raise EXQueryError.CreateFmt( SIsInvalidFloatValue, [Value] );
    SetAsFloat( F );
  End;
End;

Function TSrtFloatField.GetAsInteger: Longint;
Begin
 Result := Trunc( GetAsFloat );
End;

function TSrtFloatField.GetAsLargeInt: Largeint;
begin
 result := Trunc( GetAsFloat );
end;

Procedure TSrtFloatField.SetAsInteger( Value: Longint );
Begin
 SetAsFloat(Value);
End;

procedure TSrtFloatField.SetAsLargeInt(const Value: Largeint);
begin
 SetAsFloat(Value);
end;

Function TSrtFloatField.GetAsBoolean: Boolean;
Begin
 Result := (GetAsLargeInt<>0);
End;

Procedure TSrtFloatField.SetAsBoolean( Value: Boolean );
Begin
 if Value then
    SetAsFloat(1)
 else
    SetAsFloat(0);
End;

{-------------------------------------------------------------------------------}
{                  implements TsrtIntegerField                                      }
{-------------------------------------------------------------------------------}

Constructor TSrtIntegerField.Create( Fields: TSrtFields );
Begin
  Inherited Create( Fields );
  SetDataType( ttInteger );
End;

Function TSrtIntegerField.GetAsInteger: Longint;
Begin
  If Not GetData( @Result ) Then
    Result := 0;
End;

function TSrtIntegerField.GetAsLargeInt: Int64;
begin
   If Not GetData( @Result ) Then
    Result := 0;
end;

Procedure TSrtIntegerField.SetAsInteger( Value: Longint );
Begin
  SetData( @Value );
End;

procedure TSrtIntegerField.SetAsLargeInt(const Value: Int64);
begin
 SetData( @Value );
end;

Function TSrtIntegerField.GetAsString: String;
Var
  L: Longint;
Begin
  If GetData( @L ) Then
    Result := IntToStr(L)  { patched by ccy }
  Else
    Result := '';
End;

function TSrtIntegerField.GetAsWideString: WideString;
begin
 result := GetAsString;
end;

Procedure TSrtIntegerField.SetAsString( Const Value: String );
Var
  E: Integer;
  L: LongInt;
Begin
  Val( Value, L, E );
  If E <> 0 Then
     raise EXQueryError.CreateFmt( SIsInvalidIntegerValue, [Value] );
  SetAsInteger( L );
End;

procedure TSrtIntegerField.SetAsWideString(const Value: WideString);
begin
 SetAsString( Value );
end;

Function TSrtIntegerField.GetAsFloat: double;
Begin
  Result := GetAsInteger;
End;

Procedure TSrtIntegerField.SetAsFloat( Value: double );
Begin
 SetAsInteger( Trunc(value) );
End;

Function TSrtIntegerField.GetAsBoolean: Boolean;
Begin
 Result := (GetAsInteger<>0);
End;

Procedure TSrtIntegerField.SetAsBoolean( Value: Boolean );
Begin
  if Value then
     SetAsLargeInt(1)
  else
     SetAsLargeInt(0);
End;

{ TSrtLargeIntField }

constructor TSrtLargeIntField.Create(Fields: TSrtFields);
begin
  Inherited Create( Fields );
  SetDataType( ttLargeInt );
end;

function TSrtLargeIntField.GetAsBoolean: Boolean;
begin
 Result := (GetAsInteger<>0);
end;

function TSrtLargeIntField.GetAsFloat: double;
begin
 result := GetAsLargeInt;
end;

function TSrtLargeIntField.GetAsInteger: Longint;
begin
  If Not GetData( @Result ) Then
     Result := 0;
end;

function TSrtLargeIntField.GetAsLargeInt: Int64;
begin
  If Not GetData( @Result ) Then
     Result := 0;
end;

function TSrtLargeIntField.GetAsString: String;
Var
  L: Int64;
Begin
  If GetData( @L ) Then
    Result := IntToStr(L)  { patched by ccy }
  Else
    Result := '';
End;

function TSrtLargeIntField.GetAsWideString: WideString;
begin
 result := GetAsString;
end;

procedure TSrtLargeIntField.SetAsBoolean(Value: Boolean);
begin
 if  Value then
     SetAsLargeInt(1)
 else
    SetAsLargeInt(0);
end;

procedure TSrtLargeIntField.SetAsFloat(Value: double);
begin
 SetAsLargeInt(Trunc(Value));
end;

procedure TSrtLargeIntField.SetAsInteger(Value: Integer);
begin
  SetData( @Value );
end;

procedure TSrtLargeIntField.SetAsLargeInt(const Value: Largeint);
begin
 SetData( @Value );
end;

procedure TSrtLargeIntField.SetAsString(const Value: String);
Var
  E: Integer;
  L: Int64;
Begin
  Val( Value, L, E );
  If E <> 0 Then
    raise EXQueryError.CreateFmt( SIsInvalidIntegerValue, [Value] );
  SetAsLargeInt( L );
End;

procedure TSrtLargeIntField.SetAsWideString(const Value: WideString);
begin
 SetAsString(Value);
end;

{-------------------------------------------------------------------------------}
{                  implements TSrtBooleanField                                      }
{-------------------------------------------------------------------------------}

Constructor TSrtBooleanField.Create( Fields: TSrtFields );
Begin
  Inherited Create( Fields );
  SetDataType( ttBoolean );
End;

Function TSrtBooleanField.GetAsBoolean: Boolean;
Var
  B: WordBool;
Begin
  If GetData( @B ) Then
    Result := B
  Else
    Result := False;
End;

Procedure TSrtBooleanField.SetAsBoolean( Value: Boolean );
Var
  B: WordBool;
Begin
  If Value Then
    Word( B ) := 1
  Else
    Word( B ) := 0;
  SetData( @B );
End;

Function TSrtBooleanField.GetAsString: String;
Var
  B: WordBool;
Begin
  If GetData( @B ) Then
    Result := Copy( xqtypes.NBoolean[B], 1, 1 )
  Else
    Result := '';
End;

function TSrtBooleanField.GetAsWideString: WideString;
begin
 Result := GetAsString;
end;

Procedure TSrtBooleanField.SetAsString( Const Value: String );
Var
  L: Integer;
Begin
  L := Length( Value );
  If L = 0 Then
  Begin
    SetAsBoolean( False );
  End
  Else
  Begin
    If AnsiCompareText( Value, Copy( xqtypes.NBoolean[False], 1, L ) ) = 0 Then
      SetAsBoolean( False )
    Else If AnsiCompareText( Value, Copy( xqtypes.NBoolean[True], 1, L ) ) = 0 Then
      SetAsBoolean( True )
    Else
      raise EXQueryError.CreateFmt( SIsInvalidBoolValue, [Value] );
  End;
End;

procedure TSrtBooleanField.SetAsWideString(const Value: WideString);
begin
 SetAsString( Value );
end;

Function TSrtBooleanField.GetAsInteger: Longint;
Begin
  if GetAsBoolean then
     Result := 1
  else
     Result := 0;
End;

function TSrtBooleanField.GetAsLargeInt: Largeint;
begin
  if GetAsBoolean then
     Result := 1
  else
     Result := 0;
end;

Procedure TSrtBooleanField.SetAsInteger( Value: Longint );
Begin
 SetAsBoolean( Value<>0 );
End;

procedure TSrtBooleanField.SetAsLargeInt(const Value: Largeint);
begin
 SetAsBoolean( Value<>0 );
end;

Function TSrtBooleanField.GetAsFloat: double;
Begin
 Result := GetAsInteger;
End;

Procedure TSrtBooleanField.SetAsFloat( Value: double );
Begin
 SetAsBoolean( Trunc(Value) <> 0 );
End;

{-------------------------------------------------------------------------------}
{                  implements TSrtFields                                            }
{-------------------------------------------------------------------------------}

Constructor TSrtFields.Create( SortList: TxqSortList );
Begin
  Inherited Create;
  FSortList := SortList;
  FItems := TList.Create;
  fRuntimeFormatSettings := FSortList.fRuntimeFormatSettings;
  fSystemFormatSettings  := FSortList.fSystemFormatSettings;
End;

Destructor TSrtFields.Destroy;
Begin
  Clear;
  FItems.Free;
  Inherited Destroy;
End;

Function TSrtFields.GetCount: Integer;
Begin
  Result := FItems.Count;
End;

Function TSrtFields.GetItem( Index: Integer ): TSrtField;
Begin
  Result := FItems[Index];
End;

Function TSrtFields.Add( DataType: TExprType ): TSrtField;
Begin
  Result := Nil;
  Case DataType Of
    ttString: Result := TSrtStringField.Create( Self );
   {$IFDEF LEVEL4}
    ttWideString: Result := TSrtWideStringField.Create( Self );
   {$ENDIF}
    ttFloat: Result := TSrtFloatField.Create( Self );
    ttInteger: Result := TSrtIntegerField.Create( Self );
    ttLargeInt: Result := TSrtLargeIntField.Create( Self );
    ttBoolean: Result := TSrtBooleanField.Create( Self );
  End;
  FItems.Add( Result );
End;

Procedure TSrtFields.Clear;
Var
  I: Integer;
Begin
  For I := 0 To FItems.Count - 1 Do
    TSrtField( FItems[I] ).Free;
  FItems.Clear;
End;

{-------------------------------------------------------------------------------}
{                  Define TxqSortList                                           }
{-------------------------------------------------------------------------------}

Constructor TxqSortList.Create( UsingBookmark: Boolean;
     aRuntimeSettings, aSystemSettings: TFormatSettings  );
Begin
  Inherited Create;
  FFields := TSrtFields.Create( Self );
  FRecNo := -1;
  FRecordBufferSize := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF}; { first data is the SourceRecNo property }
  FUsingBookmark := UsingBookmark;
  fRuntimeFormatSettings := aRuntimeSettings;
  fSystemFormatSettings := aSystemSettings;
End;

Destructor TxqSortList.Destroy;
Begin
  Clear();
  FreeAndNil(FFields);
  If Assigned( FSelected ) Then
    FreeAndNil(FSelected);
  Inherited;
End;

Procedure TxqSortList.Clear;
Var
  I: Integer;
begin
  If FUsingBookmark And Assigned( FBookmarkedDataset ) Then
  Begin
    For I := 1 To GetRecordCount Do
    Begin
      SetRecno( I );
      {$if RtlVersion <= 18.5}FBookmarkedDataset.FreeBookmark( TBookmark( SourceRecno ) );{$ifend} // patched by ccy
    End;
  End;
  FBookmarkedDataset:= nil;
end;

Procedure TxqSortList.SetRecno( Value: Integer );
Begin
  If ( Value < 1 ) Or ( Value > GetRecordCount ) Then
    Raise EXQueryError.Create( SRecnoInvalid );
  FRecNo := Value;
End;

Function TxqSortList.GetRecno: Integer;
Begin
  Result := FRecNo;
End;

Procedure TxqSortList.AddField( pDataType: TExprType;
  pDataSize: Integer; pDescending: Boolean );
Begin
  With FFields.Add( pDataType ) Do
  Begin
    BufferOffset := FRecordBufferSize;
    DataType := pDataType;
    Case DataType Of
      ttString: DataSize := (pDataSize) * {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Char){$ELSE}XQ_SizeOf_Char{$ENDIF};  { patched by ccy} {patched by fduenas}
     {$IFDEF LEVEL4}
      ttWideString: DataSize := (pDataSize) * {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(TxNativeWideChar){$ELSE}XQ_SizeOf_NativeWideChar{$ENDIF};  { patched by ccy} {patched by fduenas}
     {$ENDIF}
      ttFloat: DataSize := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Double){$ELSE}XQ_SizeOf_Double{$ENDIF};
      ttInteger: DataSize := IMax( {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF}, pDataSize ); {added by fduenas: fix for ftLargeInt Issue}
      ttLargeInt: DataSize := IMax( {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Int64){$ELSE}XQ_SizeOf_Int64{$ENDIF}, pDataSize ); {added by fduenas: fix for ftLargeInt Issue}
      ttBoolean: DataSize := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(WordBool){$ELSE}XQ_SizeOf_WordBool{$ENDIF};
    End;
    Desc := pDescending;
    Inc( FRecordBufferSize, DataSize );
  End;
End;

Function TxqSortList.IsEqual( Recno1, Recno2: Integer ): Boolean;
Var
  Buffer: TxBuffer; {patched by fduenas}
  Buffer1: TxBuffer; {patched by fduenas}
  Buffer2: TxBuffer; {patched by fduenas}
Begin
  SetRecno( Recno1 );
  Buffer := ActiveBuffer;

  {
  GetMem( Buffer1, FRecordBufferSize );
  Move( Buffer^, Buffer1^, FRecordBufferSize );
  }

 {$IF RtlVersion <= 18.5}
  GetMem(Buffer1, FRecordBufferSize);
  FillChar(Buffer1^, FRecordBufferSize, #0);
 {$ELSE}
   SetLength(Buffer1, FRecordBufferSize); { patched by fduenas }
   FillChar(Buffer1[0], FRecordBufferSize, #0); { patched by fduenas }
 {$IFEND}

 {$IF RTLVersion <= 18.5}
   Move( Buffer^, Buffer1^, FRecordBufferSize );
 {$ELSE}
   Move( Buffer[0], Buffer1[0], Length(Buffer)  ); { patched by fduenas }
 {$IFEND}

  SetRecno( Recno2 );
  Buffer := ActiveBuffer;

  {
  GetMem( Buffer2, FRecordBufferSize );
  Move( Buffer^, Buffer2^, FRecordBufferSize );
  }

 {$IF RtlVersion <= 18.5}
  GetMem(Buffer2, FRecordBufferSize);
  //FillChar(Buffer2^, FRecordBufferSize, 0);
 {$ELSE}
   SetLength(Buffer2, FRecordBufferSize); { patched by fduenas }
   FillChar(Buffer2[0], FRecordBufferSize, #0); { patched by fduenas }
 {$IFEND}

 {$IF RTLVersion <= 18.5}
   Move( (Buffer+0)^, Buffer2^, FRecordBufferSize );
 {$ELSE}
   Move( Buffer[0], Buffer2[0], Length(Buffer)  ); { patched by fduenas }
 {$IFEND}

  { the first SizeOf(Integer) bytes is the source recno and always is different }

 {$IF RTLVersion <= 18.5}
   if FRecordBufferSize > {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} then
      Result := Comparemem( ( Buffer1 + {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} ),
                ( Buffer2 + {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} ), FRecordBufferSize -
                            {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} ) { patched by fduenas }
   Else
      Result := True;
 {$ELSE}
   if FRecordBufferSize > {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} then
      Result := CompareMem( @Buffer1[{$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF}] ,
                 @Buffer2[{$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF}], FRecordBufferSize - {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} ) { patched by fduenas }
   else
      Result := True;
 {$IFEND}

 {$IF RTLVersion <= 18.5}
  //FreeMem( Buffer,  FRecordBufferSize );
  FreeMem( Buffer1, FRecordBufferSize );
  FreeMem( Buffer2, FRecordBufferSize );
 {$ELSE}
  SetLength(Buffer, 0); { patched by fduenas }
  SetLength(Buffer1, 0); { patched by fduenas }
  SetLength(Buffer2, 0); { patched by fduenas }
 {$IFEND}

End;

{$IFNDEF XQ_USE_FASTCOMPARE_FUNCTIONS}
Function TxqSortList.DoCompare( N: Integer; Const KeyValue: Variant ): Integer;
{ returns -1, 0 or 1 for a<b, a=b, a>b}
Var
  DataType: TExprType;
  s: String;
 {$IFDEF LEVEL4}
  ws: WideString;
 {$ENDIF}
  f: Double;
  i: Integer;
  li: Int64;
  b, cb: Boolean;
  CompareValueV: Variant;
  CompareValueS: String;
 {$IFDEF LEVEL4}
  CompareValueWS: WideString;
 {$ENDIF}
  CompareValueF: Double;
  CompareValueI: Integer;
  CompareValueLI: Int64;
  CompareValueB: Boolean;
Begin
  Result := 0;
  SetRecno( N );
  DataType := FFields[0].DataType;
  If VarIsNull( KeyValue ) Then
  Begin
    { solo por si se ofrece, se prueba tambien al recibir un valor NULL }
    Case DataType Of
      ttString: CompareValueS := '';
     {$IFDEF LEVEL4}
      ttWideString: CompareValueWS := '';
     {$ENDIF}
      ttFloat: CompareValueF := 0;
      ttInteger: CompareValueI := 0;
      ttLargeInt: CompareValueLI := 0;
      ttBoolean: CompareValueB := False ;
    End;
  End Else
  begin
   CompareValueV := KeyValue;
   Case DataType Of
      ttString: CompareValueS := KeyValue;
     {$IFDEF LEVEL4}
      ttWideString: CompareValueWS := KeyValue;
     {$ENDIF}
      ttFloat: CompareValueF := KeyValue;
      ttInteger: CompareValueI := KeyValue;
      ttLargeInt: CompareValueLI := KeyValue;
      ttBoolean: CompareValueB := KeyValue ;
    End;
  end;
  Case DataType Of
    ttString:
      Begin
        s := FFields[0].AsString;
        If s = CompareValueS Then
        Begin
          Result := 0;
          Exit;
        End;
        If FFields[0].Desc Then
        Begin
          If s < CompareValueS Then
            Result := 1
          Else
            Result := -1;
        End
        Else
        Begin
          If s < CompareValueS Then
            Result := -1
          Else
            Result := 1;
        End;
      End;
   {$IFDEF LEVEL4}
    ttWideString:
      Begin
        ws := FFields[0].AsWideString;
        If ws = CompareValueWS Then
        Begin
          Result := 0;
          Exit;
        End;
        If FFields[0].Desc Then
        Begin
          If ws < CompareValueWS Then
            Result := 1
          Else
            Result := -1;
        End
        Else
        Begin
          If ws < CompareValueWS Then
            Result := -1
          Else
            Result := 1;
        End;
      End;
   {$ENDIF}
    ttFloat:
      Begin
        f := FFields[0].AsFloat;
        If f = CompareValueF Then
        Begin
          Result := 0;
          Exit;
        End;
        If FFields[0].Desc Then
        Begin
          If f < CompareValueF Then
            Result := 1
          Else
            Result := -1;
        End
        Else
        Begin
          If f < CompareValueF Then
            Result := -1
          Else
            Result := 1;
        End;
      End;
    ttInteger:
      Begin
        i := FFields[0].AsInteger;
        If i = CompareValueI Then
        Begin
          Result := 0;
          Exit;
        End;
        If FFields[0].Desc Then
        Begin
          If i < CompareValueI Then
            Result := 1
          Else
            Result := -1;
        End
        Else
        Begin
          If i < CompareValueI Then
            Result := -1
          Else
            Result := 1;
        End;
      End;
    ttLargeInt:
      Begin
        li := FFields[0].AsLargeInt;
        If li = CompareValueLI Then
        Begin
          Result := 0;
          Exit;
        End;
        If FFields[0].Desc Then
        Begin
          If li < CompareValueLI Then
            Result := 1
          Else
            Result := -1;
        End
        Else
        Begin
          If li < CompareValueLI Then
            Result := -1
          Else
            Result := 1;
        End;
      End;
    ttBoolean:
      Begin
        b := FFields[0].AsBoolean;
        cb := CompareValueB;
        If ord( b ) = ord( cb ) Then
        Begin
          Result := 0;
          Exit;
        End;
        If FFields[0].Desc Then
        Begin
          If Ord( b ) < Ord( cb ) Then
            Result := 1
          Else
            Result := -1;
        End
        Else
        Begin
          If Ord( b ) < Ord( cb ) Then
            Result := -1
          Else
            Result := 1;
        End;
      End;
  End;
End;
{$ELSE ~XQ_USE_FASTCOMPARE_FUNCTIONS}
function TxqSortList.DoCompareFast(N: Integer;
  const KeyValue: Variant): Integer;
{ returns -1, 0 or 1 for a<b, a=b, a>b}
Var
  DataType: TExprType;
  CompareValueVar: Variant;
  //CompareValueS: String;
 {$IFDEF LEVEL4}
  //CompareValueWS: WideString;
 {$ENDIF}
  //CompareValueF: Double;
  //CompareValueI: Integer;
  //CompareValueLI: Int64;
  //CompareValueB: Boolean;
Begin
  Result := 0;
  SetRecno( N );
  DataType := FFields[0].DataType;
  CompareValueVar := KeyValue;
  {Initialize compare values}
  {
  CompareValueF :=0;
  CompareValueI:=0;
  CompareValueLI:=0;
  CompareValueB:=false;
  }
  If VarIsNull( CompareValueVar ) Then
  Begin
    { solo por si se ofrece, se prueba tambien al recibir un valor NULL }
    Case DataType Of
      ttString: CompareValueVar := '';
     {$IFDEF LEVEL4}
      ttWideString: CompareValueVar := '';
     {$ENDIF}
      ttFloat: CompareValueVar := 0;
      ttInteger: CompareValueVar := 0;
      ttLargeInt: CompareValueVar := 0;
      ttBoolean: CompareValueVar := False;
    End;
  End{ Else
  begin
   Case DataType Of
      ttString: CompareValueS := KeyValue;
     {$IFDEF LEVEL4}
      {ttWideString: CompareValueWS := KeyValue;
     {$ENDIF}
      {ttFloat: CompareValueF := KeyValue;
      ttInteger: CompareValueI := KeyValue;
      ttLargeInt: CompareValueLI := KeyValue;
      ttBoolean: CompareValueB := KeyValue ;
    End;
  end};
  Case DataType Of
    ttString:
       Result := AnsiCompareStr(FFields[0].AsString, CompareValueVar);
   {$IFDEF LEVEL4}
    ttWideString:
       Result := WideCompareStr(FFields[0].AsWideString, CompareValueVar);
   {$ENDIF}
    ttFloat:
        Result := CompareValue(FFields[0].AsFloat, CompareValueVar);
    ttInteger:
        Result := CompareValue(FFields[0].AsInteger, CompareValueVar);
    ttLargeInt:
        Result := CompareValue(FFields[0].AsLargeInt, CompareValueVar);
    ttBoolean:
        Result := CompareValue(Ord(FFields[0].AsBoolean), Ord(Boolean(CompareValueVar)));
  End;
  If FFields[0].Desc Then
      Result := Result * -1;
End;
{$ENDIF ~XQ_USE_FASTCOMPARE_FUNCTIONS}
Function TxqSortList.Find( Const KeyValue: Variant; Var Index: Integer ): Boolean;
Var
  L, H, I, C: Integer;
Begin
  Result := False;
  L := 1;
  H := GetRecordCount;
  While L <= H Do
  Begin
    I := ( L + H ) Shr 1;
    C := {$IFDEF XQ_USE_FASTCOMPARE_FUNCTIONS}DoCompareFast{$ELSE}DoCompare{$ENDIF}( I, KeyValue );
    If C < 0 Then
      L := I + 1
    Else
    Begin
      H := I - 1;
      If C = 0 Then
      Begin
        Result := True;
        //if Duplicates <> dupAccept then L := I;
      End;
    End;
  End;
  Index := L;
End;

{ this methods filter only by the first data column of the sort }

Procedure TxqSortList.Filter( Const KeyValue: Variant );
Var
  I, Index: Integer;
Begin
  If FSelected = Nil Then
    FSelected := TList.Create
  Else
    FSelected.Clear;
  { the first value must be on the database }
  If Self.Find( KeyValue, Index ) Then
  Begin
    For I := Index To GetRecordCount Do
      If {$IFDEF XQ_USE_FASTCOMPARE_FUNCTIONS}DoCompareFast{$ELSE}DoCompare{$ENDIF}( I, KeyValue ) = 0 Then
        FSelected.Add( Pointer( I ) )
      Else
        Break;
  End;
  FFilterRecno := -1;
End;

Procedure TxqSortList.First;
Begin
  If FSelected = Nil Then Exit;
  If FSelected.Count > 0 Then
  Begin
    FFilterRecno := 0;
    FBofCrack := false;
    FEofCrack := false;
    SetRecno( TxNativeInt( FSelected[FFilterRecno] ) );
  End
  Else
  Begin
    FBofCrack := true;
    FEofCrack := true;
  End
End;

Procedure TxqSortList.Next;
Begin
  If FSelected = Nil Then Exit;
  If FSelected.Count > 0 Then
  Begin
    If FFilterRecno < FSelected.Count - 1 Then
    Begin
      Inc( FFilterRecno );
      FBofCrack := false;
      FEofCrack := false;
    End
    Else
    Begin
      FFilterRecno := FSelected.Count - 1;
      FBofCrack := false;
      FEofCrack := true;
    End;
    SetRecno( TxNativeInt( FSelected[FFilterRecno] ) );
  End
  Else
  Begin
    FBofCrack := true;
    FEofCrack := true;
  End
End;

Function TxqSortList.Eof: Boolean;
Begin
  result := FEofCrack;
End;

Function TxqSortList.Bof: Boolean;
Begin
  result := FBofCrack;
End;

type
  TDataSetAccess = class(TDataSet);

procedure TxqSortList.SetBookmarkedDataset(const Value: TDataset);
begin
  FBookmarkedDataset := Value;
  fRecordBufferSize := TDataSetAccess(FBookmarkedDataset).BookmarkSize;
end;

Procedure TxqSortList.Sort;
Var
  I, Idx: Integer;
  Index: Integer;
  Pivot: Integer;
  DataType: TExprType;
  IsDesc: Boolean;
  TempL, TempR: String;

  Function SortCompare_S( Recno: Integer; Const Value: String ): Integer;
  Begin
    SetRecno( Recno );
    Result := AnsiCompareStr(FFields[Idx].AsString, Value); {fduenas: should it stay as AnsiCompareStr or just CompareStr?}
    if IsDesc then Result := - Result;
  End;
 {$IFDEF LEVEL4}
  Function SortCompare_W( Recno: Integer; Const Value: WideString ): Integer;
  Begin
    SetRecno( Recno );
    Result := WideCompareStr(FFields[Idx].AsWideString, Value); {fduenas: should it stay as AnsiCompareStr or just CompareStr?}
    if IsDesc then Result := - Result;
  End;
 {$ENDIF}
  Function SortCompare_F( Recno: Integer; Const Value: Double ): Integer;
  Begin
    SetRecno( Recno );
    Result := CompareValue(FFields[Idx].AsFloat, Value);
    if IsDesc then Result := - Result;
  End;

  Function SortCompare_I( Recno: Integer; Value: Integer ): Integer;
  Begin
    SetRecno( Recno );
    Result := CompareValue(FFields[Idx].AsInteger, Value);
    if IsDesc then Result := - Result;
  End;

  Function SortCompare_LI( Recno: Int64; Value: Int64 ): Int64;
  Begin
    SetRecno( Recno );
    Result := CompareValue(FFields[Idx].AsLargeInt, Value);
    if IsDesc then Result := - Result;
  End;

  Function SortCompare_B( Recno: Integer; Value: Boolean ): Integer;
  Begin
    SetRecno( Recno );
    Result := CompareValue(Ord(FFields[Idx].AsBoolean), Ord(Value));
    if IsDesc then Result := - Result;
  End;

  Procedure QuickSort( L, R: Integer );
  Var
    I, J, P: Integer;
    s1: String;
    ws1: String;
    f1: Double;
    i1: Integer;
    li1: Int64;
    b1: Boolean;
  Begin
    Repeat
      I := L;
      J := R;
      P := ( L + R ) Shr 1;
      SetRecno( P );
      f1 := 0;
      i1 := 0;
      li1 := 0;
      b1 := False;
      Case DataType Of
        ttString: s1 := FFields[Idx].AsString;
       {$IFDEF LEVEL4}
        ttWideString: ws1 := FFields[Idx].AsWideString;
       {$ENDIF}
        ttFloat: f1 := FFields[Idx].AsFloat;
        ttInteger: i1 := FFields[Idx].AsInteger;
        ttLargeInt: li1 := FFields[Idx].AsLargeInt;
        ttBoolean: b1 := FFields[Idx].AsBoolean;
      End;
      Repeat
        Case DataType Of
          ttString:
            Begin
              While SortCompare_S( I, s1 ) < 0 Do
                Inc( I );
              While SortCompare_S( J, s1 ) > 0 Do
                Dec( J );
            End;
       {$IFDEF LEVEL4}
          ttWideString:
            Begin
              While SortCompare_W( I, ws1 ) < 0 Do
                Inc( I );
              While SortCompare_W( J, ws1 ) > 0 Do
                Dec( J );
            End;
       {$ENDIF}
          ttFloat:
            Begin
              While SortCompare_F( I, f1 ) < 0 Do
                Inc( I );
              While SortCompare_F( J, f1 ) > 0 Do
                Dec( J );
            End;
          ttInteger:
            Begin
              While SortCompare_I( I, i1 ) < 0 Do
                Inc( I );
              While SortCompare_I( J, i1 ) > 0 Do
                Dec( J );
            End;
          ttLargeInt:
            Begin
              While SortCompare_LI( I, li1 ) < 0 Do
                Inc( I );
              While SortCompare_LI( J, li1 ) > 0 Do
                Dec( J );
            End;
          ttBoolean:
            Begin
              While SortCompare_B( I, b1 ) < 0 Do
                Inc( I );
              While SortCompare_B( J, b1 ) > 0 Do
                Dec( J );
            End;
        End;
        If I <= J Then
        Begin
          Exchange( I, J );
          Inc( I );
          Dec( J );
        End;
      Until I > J;
      If L < J Then
         QuickSort( L, J );
      L := I;
    Until I >= R;
  End;

Begin
  If ( FFields.Count = 0 ) Or ( GetRecordCount = 0 ) Then Exit;
  Idx := 0;
  DataType := FFields[0].DataType;
  IsDesc := FFields[0].Desc;
  QuickSort( 1, GetRecordCount );
  For Idx := 1 To FFields.Count - 1 Do
  Begin
    SetRecno( 1 );
    DataType := FFields[Idx].DataType;
    IsDesc := FFields[Idx].Desc;
    Index := 1;
    Pivot := 1;
    TempL := '';
    For I := 0 To Idx - 1 Do
      TempL := TempL + FFields[I].AsString;
    While Index <= GetRecordCount Do
    Begin
      SetRecno( Index );
      TempR := '';
      For I := 0 To Idx - 1 Do
          TempR := TempR + FFields[I].AsString;
      If TempL <> TempR Then
      Begin
        If Index - 1 > Pivot Then
           QuickSort( Pivot, Index - 1 );

        Pivot := Index;
        SetRecno( Pivot );
        TempL := TempR;
        Index := Pivot - 1;
      End;
      Inc( Index );
    End;
    If ( ( Index - 1 ) <= GetRecordCount ) And ( Index - 1 > Pivot ) Then
       QuickSort( Pivot, Index - 1 );
  End;
End;

{-------------------------------------------------------------------------------}
{                  implements TMemSortList                                      }
{-------------------------------------------------------------------------------}

Constructor TMemSortList.Create( UsingBookmark: Boolean;
     aRuntimeSettings, aSystemSettings: TFormatSettings  );
Begin
  Inherited Create( UsingBookmark, aRuntimeSettings, aSystemSettings  );
  FBufferList := TList{$IF RtlVersion>20}<TxBuffer>{$IFEND}.Create;
End;

Destructor TMemSortList.Destroy;
Begin
  Clear();
  FreeAndNil(FBufferList);
  Inherited Destroy;
End;

Procedure TMemSortList.Clear;
Var
  I: Integer;
  Buffer: TxBuffer;
Begin
  inherited Clear();
  if(FBufferList<>nil)then
  begin
    For I := 0 To FBufferList.Count - 1 Do
    Begin
      Buffer := FBufferList[I];
      // Start Modified by CCY: Fixed memory leak. Free the Bookmark allocated
//      if fUsingBookMark then
//        Move( ( Buffer + 0 )^, L, SizeOf(L));
      // End Modified by CCY
     {$IF RTLVersion <= 18.5}
      FreeMem( Buffer, FRecordBufferSize ); { patched by fduenas }
     {$ELSE}
      SetLength( Buffer, 0);{ patched by fduenas }
     {$IFEND}
    End;
    FBufferList.Clear();
  end;
  if(FFields<>nil) then FFields.Clear();
  FRecordBufferSize := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF};
  FRecNo := -1;
End;

function TMemSortList.ActiveBuffer: TxBuffer; {patched by fduenas}
Begin
  Result := Nil;
  If ( FRecNo < 1 ) Or ( FRecNo > FBufferList.Count ) Then Exit;
  Result := FBufferList[FRecNo - 1];
End;

Function TMemSortList.GetFieldData( Field: TSrtField; Buffer: Pointer ): Boolean;
Var
  RecBuf: TxBuffer; {patched by fduenas}
Begin
  Result := False;
  RecBuf := ActiveBuffer;
  If (RecBuf = Nil) Or (Buffer = Nil) Then exit; {patched by fduenas}
 {$IF RTLVersion <= 18.5}
  Move((RecBuf + Field.BufferOffset)^, Buffer^, Field.DataSize);
 {$ELSE}
  Move(RecBuf[Field.BufferOffset], Buffer^, Field.DataSize);
  { patched by fduenas }
 {$IFEND}

  Result := True;
End;

Procedure TMemSortList.SetFieldData( Field: TSrtField; Buffer: Pointer );
Var
  RecBuf: TxBuffer; {patched by fduenas}
Begin
  RecBuf := ActiveBuffer;
  If ( RecBuf = Nil ) Or ( Buffer = Nil ) Then Exit;
 {$IF RTLVersion <= 18.5}
  Move( Buffer^, ( RecBuf + Field.BufferOffset )^, Field.DataSize );
 {$ELSE}
  Move(Buffer^, RecBuf[Field.BufferOffset], Field.DataSize);
  { patched by fduenas }
 {$IFEND}

End;

Procedure TMemSortList.Insert;
Var
  Buffer: TxBuffer;
Begin
{$IF RtlVersion <= 18.5}
  GetMem(Buffer, FRecordBufferSize);
  FillChar(Buffer^, FRecordBufferSize, #0); {patched by fduenas, added the '#' to the Null value '0', for better understanding}
{$ELSE}
  SetLength(Buffer, FRecordBufferSize); { patched by fduenas }
  FillChar(Buffer[0], FRecordBufferSize, #0); { patched by fduenas }
{$IFEND}
  FBufferList.Add( Buffer );
  FRecNo := FBufferList.Count;
End;

Function TMemSortList.GetRecordCount: Integer;
Begin
  Result := FBufferList.Count;
End;

Procedure TMemSortList.Exchange( Recno1, Recno2: Integer );
Begin
  FBufferList.Exchange( Recno1 - 1, Recno2 - 1 );
End;

{$if RtlVersion >= 20}
function TMemSortList.GetSourceBookmark: TBookmark;
Var
  Buffer: TxBuffer; {patched by fduenas}
Begin
  Result := nil;
  If ( fRecNo < 1 ) Or ( fRecNo > GetRecordCount ) Then
    Exit;
  Buffer := TxBuffer( fBufferList[fRecNo - 1] );
  {
  SetLength(Result, 20);
  Move( ( Buffer + 0 )^, Result[0], 20 );
  }
  SetLength(Result, Length(Buffer) );  {patched by fduenas}
  Move(Buffer[0], Result[0], Length(Buffer) ); {patched by fduenas}
End;
{$ifend}

Function TMemSortList.GetSourceRecno: Integer;
Var
  Buffer: TxBuffer; {patched by fduenas}
Begin
  Result := 0;
  If ( FRecNo < 1 ) Or ( FRecNo > GetRecordCount ) Then Exit;
{$IF RtlVersion <= 18.5}
  Buffer := PAnsiChar( FBufferList[FRecNo - 1] );
  Move( ( Buffer + 0 )^, Result, {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} ); {patched by fduenas}
{$ELSE}
  Buffer := FBufferList[FRecNo - 1] ;
  Move( Buffer[0], Result, {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} ); {patched by fduenas}
{$IFEND}

End;

{$if RtlVersion >= 20}
procedure TMemSortList.SetSourceBookmark(const Value: TBookmark);
Var
  Buffer: TxBuffer;
Begin
  If ( fRecNo < 1 ) Or ( fRecNo > GetRecordCount ) Then Exit;
  Buffer := TxBuffer( fBufferList[fRecNo - 1] );
  FillChar(Buffer[0], Length(Buffer), #0); { patched by fduenas }
  Move( Value[0], Buffer[0], Length(Value) ); { patched by fduenas }
End;
{$ifend}

Procedure TMemSortList.SetSourceRecno( Value: Integer );
Var
  Buffer: TxBuffer; {patched by fduenas}
Begin
 If ( FRecNo < 1 ) Or ( FRecNo > GetRecordCount ) Then Exit;

{$IF RtlVersion <= 18.5}
  Buffer := PAnsiChar( FBufferList[FRecNo - 1] );
  Move( Value, ( Buffer + 0 )^, {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} );
{$ELSE}
  Buffer := FBufferList[FRecNo - 1] ;
  Move( Value, Buffer[0], {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} ); {patched by fduenas}
{$IFEND}

End;

{-------------------------------------------------------------------------------}
{                  implements TFileSortList                                     }
{-------------------------------------------------------------------------------}

Constructor TFileSortList.Create( UsingBookmark: Boolean; MapFileSize: Longint;
     aRuntimeSettings, aSystemSettings: TFormatSettings  );
Begin
  Inherited Create( UsingBookmark, aRuntimeSettings, aSystemSettings );
  FBufferList := TList{$IF RtlVersion>20}<TxBuffer>{$IFEND}.Create;
  FTmpFile := GetTemporaryFileName( '~xq' );
  FMemMapFile := TMemMapFile.Create( FTmpFile, fmCreate, MapFileSize, True );
End;

Destructor TFileSortList.Destroy;
Begin
  Clear;
  FreeObject( FMemMapFile );
  SysUtils.DeleteFile( FTmpFile );
  FBufferList.Free;

  {$IF RtlVersion <= 18.5}
  If Assigned(FBuffer) Then
    FreeMem( FBuffer, FRecordBufferSize ); { patched by fduenas based on ccy }
  {$ELSE}
    SetLength(FBuffer, 0); { patched by fduenas based on ccy }
  {$IFEND}

  Inherited Destroy;
End;

Procedure TFileSortList.Clear;
var I: Integer;
    Buffer : TxBuffer;
Begin
  inherited Clear;

  if(FFields<>nil) then FFields.Clear();
  FRecordBufferSize := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF};
  FRecNo := -1;

  FMemMapFile.Seek( 0, 0 );

  {added by fduenas, code to prevent memory leaks, taken from CCY}
  if Assigned(FBufferList)then
  begin
    For I := 0 To FBufferList.Count - 1 Do
    Begin
     Buffer := FBufferList[I];
      // Start Modified by CCY: Fixed memory leak. Free the Bookmark allocated
//      if fUsingBookMark then
//        Move( ( Buffer + 0 )^, L, SizeOf(L));
      // End Modified by CCY
     {$IF RTLVersion <= 18.5}
      FreeMem( Buffer, FRecordBufferSize ); { patched by fduenas }
     {$ELSE}
      SetLength( Buffer, 0);{ patched by fduenas }
     {$IFEND}
    End;
    FBufferList.Clear;
  end;

  FFields.Clear;
  FRecordBufferSize := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF};
  FRecNo := -1;

End;

function TFileSortList.ActiveBuffer: TxBuffer;
Begin
  Result := Nil;
  If ( FRecNo < 1 ) Or ( FRecNo > FBufferList.Count ) Then
    Exit;

{$IF RtlVersion <= 18.5}
  If Not Assigned(FBuffer) Then
    GetMem(FBuffer, FRecordBufferSize); { patched by fduenas based on ccy }
{$ELSE}
  SetLength(FBuffer, 0); { patched by fduenas based on ccy }
  SetLength(FBuffer, FRecordBufferSize); { patched by fduenas based on ccy }
{$IFEND}

  FMemMapFile.Seek(TxNativeInt(FBufferList[FRecNo - 1]), 0);

{$IF RtlVersion <= 18.5}
  FMemMapFile.Read(FBuffer^, FRecordBufferSize);
  { patched by fduenas based on ccy }
{$ELSE}
  FMemMapFile.Read(FBuffer[0], FRecordBufferSize);
  { patched by fduenas based on ccy }
{$IFEND}

  Result := FBuffer;
End;

Function TFileSortList.GetFieldData( Field: TSrtField; Buffer: Pointer ): Boolean;
Var
  RecBuf: TxBuffer;
Begin
  Result := False;
  RecBuf := ActiveBuffer;
  If (RecBuf = Nil)  Or (Buffer = Nil) Then
    Exit;

 {$IF RTLVersion <= 18.5}
  Move((RecBuf + Field.BufferOffset)^, Buffer^,  Field.DataSize);
{$ELSE}
  Move(RecBuf[Field.BufferOffset], Buffer^, Field.DataSize);
  { patched by ccy }
{$IFEND}

  Result := True;
End;

Procedure TFileSortList.SetFieldData( Field: TSrtField; Buffer: Pointer );
Var
  RecBuf: TxBuffer;
Begin
  RecBuf := ActiveBuffer;
  If (RecBuf = Nil)  Or (Buffer = Nil) Then
      Exit;

{$IF RTLVersion <= 18.5}
  Move(Buffer^, (RecBuf + Field.BufferOffset)^, Field.DataSize);
{$ELSE}
  Move(Buffer^, RecBuf[Field.BufferOffset], Field.DataSize);
  { patched by fduenas based on ccy }
{$IFEND}

  FMemMapFile.Seek(TxNativeInt(FBufferList[Recno - 1]), 0);

{$IF RTLVersion <= 18.5}
  FMemMapFile.Write(RecBuf^, FRecordBufferSize);
{$ELSE}
  FMemMapFile.Write(RecBuf[0], FRecordBufferSize);
  { patched by fduenas based on ccy }
{$IFEND}

End;

Procedure TFileSortList.Insert;
Var
  Offset: Integer;
Begin

{$IF RtlVersion <= 18.5}
  If Not Assigned(FBuffer) Then
    GetMem(FBuffer, FRecordBufferSize);
  FillChar(FBuffer^, FRecordBufferSize, #0);
{$ELSE}
  SetLength(FBuffer, 0); { patched by fduenas based on ccy }
  SetLength(FBuffer, FRecordBufferSize); { patched by fduenas }
  FillChar(FBuffer[0], FRecordBufferSize, #0); { patched by fduenas }
{$IFEND}

  Offset := FMemMapFile.VirtualSize;

  FMemMapFile.Seek(Offset, 0);

{$IF RtlVersion <= 18.5}
  FMemMapFile.Write(FBuffer^, FRecordBufferSize);
{$ELSE}
  FMemMapFile.Write(FBuffer[0], FRecordBufferSize);
{$IFEND}

  FBufferList.Add(TxBuffer(Offset)); { the address in temp file is saved }
  FRecNo := FBufferList.Count;
End;

Function TFileSortList.GetRecordCount: Integer;
Begin
  Result := FBufferList.Count;
End;

Procedure TFileSortList.Exchange( Recno1, Recno2: Integer );
Begin
  FBufferList.Exchange( Recno1 - 1, Recno2 - 1 );
End;

{$if RtlVersion >= 20}
function TFileSortList.GetSourceBookmark: TBookmark;
begin
  Result := nil;
end;
{$ifend}

Procedure TFileSortList.SetSourceRecno( Value: Integer );
Begin
  If ( FRecNo < 1 ) Or ( FRecNo > GetRecordCount ) Then
    Exit;
  FMemMapFile.Seek( TxNativeInt( FBufferList[FRecNo - 1] ), 0 );
  FMemMapFile.Write( Value, {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} );
End;

Function TFileSortList.GetSourceRecno: Integer;
Var
  RecBuf: TxBuffer;
Begin
  Result := -1;
  RecBuf := ActiveBuffer;
  If (RecBuf = Nil) Then
    Exit;
{$IF RtlVersion <= 18.5}
  Move( ( RecBuf + 0 )^, Result, {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} );
{$ELSE}
  Move( RecBuf[0], Result, {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF} );
{$IFEND}

End;

{$if RtlVersion >= 20}
procedure TFileSortList.SetSourceBookmark(const Value: TBookmark);
begin

end;
{$ifend}

{-------------------------------------------------------------------------------}
{ Implementation of TAggregateItem                                              }
{-------------------------------------------------------------------------------}

Constructor TAggregateItem.Create( AggregateList: TAggregateList );
Begin
  Inherited Create;
  FAggregateList := AggregateList;

  FSparseList := TAggSparseList.Create( 1000 );
End;

Destructor TAggregateItem.Destroy;
Begin
  FSparseList.Free;
  Inherited Destroy;
End;

{-------------------------------------------------------------------------------}
{ Implementation of TAggregateList                                              }
{-------------------------------------------------------------------------------}

Constructor TAggregateList.Create;
Begin
  Inherited Create;
  FItems := TList.Create;
End;

Destructor TAggregateList.Destroy;
Begin
  Clear;
  FItems.Free;
  Inherited Destroy;
End;

Function TAggregateList.GetCount;
Begin
  Result := FItems.Count;
End;

Function TAggregateList.GetItem( Index: Integer ): TAggregateItem;
Begin
  Result := FItems[Index];
End;

Function TAggregateList.Add: TAggregateItem;
Begin
  Result := TAggregateItem.Create( Self );
  FItems.Add( Result );
End;

Procedure TAggregateList.Clear;
Var
  I: Integer;
Begin
  For I := 0 To FItems.Count - 1 Do
    TAggregateItem( FItems[I] ).Free;
  FItems.Clear;
End;

Procedure TAggregateList.Delete( Index: Integer );
Begin
  TAggregateItem( FItems[Index] ).Free;
  FItems.Delete( Index );
End;

Procedure TAggregateList.Assign( AggregateList: TAggregateList );
Var
  I: Integer;
  Aggr: TAggregateItem;
Begin
  Clear;
  For I := 0 To AggregateList.Count - 1 Do
  Begin
    Aggr := AggregateList[I];
    With Self.Add Do
    Begin
      AggregateStr := Aggr.AggregateStr;
      ColIndex := Aggr.ColIndex;
      Aggregate := Aggr.Aggregate;
      IsDistinctAg := Aggr.IsDistinctAg;
    End;
  End;
End;

{-------------------------------------------------------------------------------}
{  Implements TMemMapFile                                                       }
{-------------------------------------------------------------------------------}

Constructor TMemMapFile.Create( FileName: String; FileMode: integer;
  Size: integer; MapNow: Boolean );
{ Creates Memory Mapped view of FileName file.
  FileName: Full pathname of file.
  FileMode: Use fmXXX constants.
  Size: size of memory map.  Pass zero as the size to use the
        file's own size.
}
Begin

  { Initialize private fields }
  FMapNow := MapNow;
  FFileName := FileName;
  FFileMode := FileMode;

  AllocFileHandle; // Obtain a file handle of the disk file.
  { Assume file is < 2 gig  }

  FFileSize := GetFileSize( FFileHandle, Nil );
  FSize := Size;

  Try
    AllocFileMapping; // Get the file mapping object handle.
  Except
    On ExQueryError Do
    Begin
      CloseHandle( FFileHandle ); // close file handle on error
      FFileHandle := 0; // set handle back to 0 for clean up
      Raise; // re-raise exception
    End;
  End;
  If FMapNow Then
    AllocFileView; // Map the view of the file
End;

Destructor TMemMapFile.Destroy;
Begin

  If FFileHandle <> 0 Then
    CloseHandle( FFileHandle ); // Release file handle.

  { Release file mapping object handle }
  If FMapHandle <> 0 Then
    CloseHandle( FMapHandle );

  FreeMapping; { Unmap the file mapping view . }
  Inherited Destroy;
End;

Procedure TMemMapFile.FreeMapping;
{ This method unmaps the view of the file from this process's address space }
Begin
  If FData <> Nil Then
  Begin
    UnmapViewOfFile( FData );
    FData := Nil;
  End;
End;

Function TMemMapFile.GetSize: Longint;
Begin
  If FSize <> 0 Then
    Result := FSize
  Else
    Result := FFileSize;
End;

Procedure TMemMapFile.AllocFileHandle;
{ creates or opens disk file before creating memory mapped file }
Begin
  If FFileMode = fmCreate Then
    FFileHandle := FileCreate( FFileName )
  Else
    FFileHandle := FileOpen( FFileName, FFileMode );

  If FFileHandle < 0 Then
    Raise ExQueryError.Create( SFailOpenFile );
End;

Procedure TMemMapFile.AllocFileMapping;
Var
  ProtAttr: DWORD;
Begin
  If FFileMode = fmOpenRead Then // obtain correct protection attribute
    ProtAttr := Page_ReadOnly
  Else
    ProtAttr := Page_ReadWrite;
  { attempt to create file mapping of disk file.
    Raise exception on error. }
  FMapHandle := CreateFileMapping( FFileHandle, Nil, ProtAttr,
    0, FSize, Nil );
  If FMapHandle = 0 Then
    Raise ExQueryError.Create( SFailCreateMapping );
End;

Procedure TMemMapFile.AllocFileView;
Var
  Access: Longint;
Begin
  If FFileMode = fmOpenRead Then // obtain correct file mode
    Access := File_Map_Read
  Else
    Access := File_Map_All_Access;
  FData := MapViewOfFile( FMapHandle, Access, 0, 0, FSize );
  If FData = Nil Then
    Raise ExQueryError.Create( SFailMapView );
End;

Procedure TMemMapFile.Read( Var Buffer; Count: Longint );
Begin
  If FPosition + Count > GetSize Then
    Raise ExQueryError.Create( SBeyondEOF );
  Move( ( FData + FPosition )^, Buffer, Count );
  Inc( FPosition, Count );
End;

Procedure TMemMapFile.Write( Const Buffer; Count: Longint );
Begin
  Move( Buffer, ( FData + FPosition )^, Count );
  Inc( FPosition, Count );
  FVirtualSize := IMax( FPosition, FVirtualSize );
End;

Procedure TMemMapFile.Seek( Offset: Longint; Origin: Word );
Begin
  FPosition := Offset; // only from beginning supported (Origin = 0)
End;

{ TUserDefinedRange }

Constructor TUserDefinedRange.Create;
Begin
  Inherited Create;
  FForFields := TxNativeTStringList.Create;
  FStartValues := TxNativeTStringList.Create;
  FEndValues := TxNativeTStringList.Create;
  FStartResolvers := TList.create;
  FEndResolvers := TList.create;
End;

Destructor TUserDefinedRange.Destroy;
Begin
  FForFields.Free;
  FStartValues.Free;
  FEndValues.Free;
  ClearResolvers;
  FStartResolvers.free;
  FEndResolvers.free;
  Inherited Destroy;
End;

Procedure TUserDefinedRange.ClearResolvers;
Var
  I: Integer;
Begin
  For I := 0 To FStartResolvers.Count - 1 Do
    TExprParser( FStartResolvers[I] ).Free;
  FStartResolvers.Clear;
  For I := 0 To FEndResolvers.Count - 1 Do
    TExprParser( FEndResolvers[I] ).Free;
  FEndResolvers.Clear;
End;

{ TParamsAsFieldsItem }

procedure TParamsAsFieldsItem.Assign(Source: TPersistent);
begin
  If Source Is TParamsAsFieldsItem Then
  Begin
    FName := TParamsAsFieldsItem( Source ).Name;
    FValue := TParamsAsFieldsItem( Source ).Value;
  End
  Else
    Inherited Assign( Source );
end;

procedure TParamsAsFieldsItem.SetName(const Value: string);
begin
  { check if param already exists }
  if (Collection as TParamsAsFields).ParamByName(Value) <> Nil then
    Raise EXQueryError.Create( SDupParamsAsFields );
  FName:= value;
end;

procedure TParamsAsFieldsItem.SetValue(const Value: String);
begin
  FValue:= Value;
end;

Function TParamsAsFieldsItem.GetDisplayName: String;
begin
  if (Length(Name) <> 0) Or (Length(Value) <> 0) then
    Result:= Name + ' - ' + Value
  else
    Result:= inherited GetDisplayName;
end;

{ TParamsAsFields }

constructor TParamsAsFields.Create(AOwner: TPersistent);
begin
  Inherited Create( AOwner, TParamsAsFieldsItem );
end;

function TParamsAsFields.Add: TParamsAsFieldsItem;
begin
  Result := TParamsAsFieldsItem( Inherited Add );
end;

function TParamsAsFields.GetItem(Index: Integer): TParamsAsFieldsItem;
begin
  Result := TParamsAsFieldsItem( Inherited GetItem( Index ) );
end;

procedure TParamsAsFields.SetItem(Index: Integer; Value: TParamsAsFieldsItem);
begin
  Inherited SetItem( Index, Value );
end;

function TParamsAsFields.ParamByName(const Value: string): TParamsAsFieldsItem;
var
  I: Integer;
begin
  Result:= Nil;
  for I:= 0 to Count - 1 do
    if GetItem( I ).Name = Value then
    begin
      Result:= GetItem( I );
      Exit;
    end;
end;



{ TxqIntegerList }

Constructor TxqIntegerList.Create;
Begin
  Inherited Create;
  FList := TList.Create;
End;

Destructor TxqIntegerList.Destroy;
Begin
  FList.Free;
  Inherited;
End;

Procedure TxqIntegerList.Assign( AList: TxqIntegerList );
{$IFNDEF LEVEL6}
Var
  I: Integer;
{$ENDIF}
begin
{$IFDEF LEVEL6}
  FList.Assign( AList.FList );
{$ELSE}
  FList.Clear;
  For I:= 0 to AList.Count-1 do
    FList.Add( AList.FList[I] );
{$ENDIF}
end;

Function TxqIntegerList.Add( Item: Integer ): Integer;
Begin
  result := FList.Add( Pointer( Item ) );
End;

Procedure TxqIntegerList.Clear;
Begin
  FList.Clear;
End;

Procedure TxqIntegerList.Delete( Index: Integer );
Begin
  FList.Delete( Index );
End;

Function TxqIntegerList.GetCount: Integer;
Begin
  result := FList.Count;
End;

Procedure TxqIntegerList.SetCount( Value: Integer );
Begin
  FList.Count := Value;
End;

Function TxqIntegerList.Get( Index: Integer ): Integer;
Begin
  result := LongInt( FList[Index] );
End;

Procedure TxqIntegerList.Insert( Index, Value: Integer );
Begin
  FList.Insert( Index, Pointer( Value ) );
End;

Procedure TxqIntegerList.Put( Index, Value: Integer );
Begin
  FList[Index] := Pointer( Value );
End;

Function TxqIntegerList.IndexofValue( Item: Integer ): Integer;
Begin
  Result := FList.IndexOf( Pointer( item ) );
End;

Function TxqIntegerList.GetCapacity: Integer;
Begin
  result := FList.Capacity;
End;

Procedure TxqIntegerList.SetCapacity( Value: Integer );
Begin
  FList.Capacity := Value;
End;

Procedure TxqIntegerList.Sort;

  Procedure QuickSort( L, R: Integer );
  Var
    I, J: Integer;
    P, T: Integer;
  Begin
    Repeat
      I := L;
      J := R;
      P := LongInt( FList[( L + R ) Shr 1] );
      Repeat
        While LongInt( FList[I] ) < P Do
          Inc( I );
        While LongInt( FList[J] ) > P Do
          Dec( J );
        If I <= J Then
        Begin
          T := LongInt( FList[I] );
          FList[I] := Pointer( LongInt( FList[J] ) );
          FList[J] := Pointer( T );
          Inc( I );
          Dec( J );
        End;
      Until I > J;
      If L < J Then
        QuickSort( L, J );
      L := I;
    Until I >= R;
  End;

Begin
  If FList.Count > 1 Then
    QuickSort( 0, FList.Count - 1 );
End;

procedure TxqIntegerList.LoadFromStream( Stream: TStream );
var
  I, N, Value: Integer;
Begin
  FList.Clear;
  with Stream do
  begin
    Read(N,SizeOf(N));
    for I:= 1 to N do
    Begin
      Read( Value, SizeOf(Value));
      FList.Add( Pointer(Value) );
    End;
  end;
End;

Procedure TxqIntegerList.SaveToStream( Stream: TStream );
var
  I, N, Value: Integer;
Begin
  N:= FList.Count;
  with Stream do
  begin
    Write(N,SizeOf(N));
    for I:= 0 to FList.Count-1 do
    Begin
      Value:= Integer( FList[I] );
      Write( Value, SizeOf(Value));
    End;
  end;
End;

Procedure TxqIntegerList.LoadFromFile( const FileName: string );
var
  s: TStream;
Begin
  if Not FileExists( FileName ) then Exit;
  s:= TFileStream.Create( FileName, fmOpenRead or fmShareDenyNone );
  Try
    LoadFromStream( s );
  Finally
    s.Free;
  End;
End;

Procedure TxqIntegerList.SaveToFile( const FileName: string );
var
  s: TStream;
Begin
  s:= TFileStream.Create( FileName, fmCreate );
  Try
    SaveToStream( s );
  Finally
    s.Free;
  End;
End;

function TxqIntegerList.Find(Value: Integer; var Index: Integer): Boolean;
var
  nLow: Integer;
  nHigh: Integer;
  nCheckPos: Integer;
begin
  nLow:= 0;
  nHigh:= FList.Count-1;
  Index := -1;
  Result:=False;
  // keep searching until found or
  // no more items to search
  while nLow <= nHigh do
  begin
     nCheckPos := (nLow + nHigh) div 2;
     if Longint(FList[nCheckPos]) < Value then       // less than
        nHigh := nCheckPos - 1
     else if Longint(FList[nCheckPos]) > Value then  // greater than
        nLow := nCheckPos + 1
      else                                  // equal to
      begin
        Index:= nCheckPos;
        Result:= true;
        Exit;
      end;
  end;
end;

procedure TxqIntegerList.Reindex;
Var
  I, n, Last: Integer;
begin
  { this method is only used in conjunction with a TEzVector Parts property }
  If FList.Count = 0 Then Exit;
  { it is needed to reindex with repeated values }
  n := 0;
  Last := Integer( FList.Items[0] );
  I := 0;
  While I <= FList.Count - 1 Do
  Begin
    If Last <> Integer( FList.Items[I] ) Then
    Begin
      Inc( n );
      Last := Integer( FList.Items[I] );
    End;
    FList.Items[I] := Pointer( n );
    Inc( I );
  End;
end;

End.

