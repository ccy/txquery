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
{   The Original Code is: QBaseExpr.pas                                       }
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

Unit QBaseExpr;

{$I XQ_flag.Inc}
Interface

Uses
  SysUtils, Classes, QFormatSettings, XQTypes;
Type
  TExprType = ({$IFDEF LEVEL4}ttWideString,{$ENDIF} ttString,  ttFloat, ttLargeInt, ttInteger, ttBoolean );
  {to get a string representation of TExprType use NExprType[ExprType] }
Const
  NExprType: Array[TExprType] Of String =
  ( {$IFDEF LEVEL4}'WideString',{$ENDIF}'String',  'Float', 'Integer', 'Large Integer', 'Boolean' );
  NTypeCast: Array[TExprType] Of PChar =
  ({$IFDEF LEVEL4}'WIDESTRING',{$ENDIF}'STRING',  'FLOAT', 'LARGE INTEGER', 'INTEGER', 'BOOLEAN' );
  //NBoolean: Array[Boolean] Of String = ( 'FALSE', 'TRUE' ); duplicate definition, alreday defined in xqtypes.pas

//Type
//  TExprType = (ttString, {$IFDEF LEVEL4} ttWideString,{$ENDIF} ttFloat, ttLargeInt, ttInteger, ttBoolean );
//  {to get a string representation of TExprType use NExprType[ExprType] }
//Const
//  NExprType: Array[TExprType] Of String =
//  ( 'String', {$IFDEF LEVEL4}'WideString',{$ENDIF} 'Float', 'Integer', 'Large Integer', 'Boolean' );
//  NTypeCast: Array[TExprType] Of PChar =
// ('STRING', {$IFDEF LEVEL4}'WIDESTRING',{$ENDIF} 'FLOAT', 'LARGE INTEGER', 'INTEGER', 'BOOLEAN' );
//  //NBoolean: Array[Boolean] Of String = ( 'FALSE', 'TRUE' ); duplicate definition, alreday defined in xqtypes.pas

Type

  EExpression = Class( Exception );

  TExpression = Class
  Private
    Function GetMaxLen: Integer;
  Protected
    fExprName: TxNativeString;
    fRuntimeFormatSettings: TFormatSettings;
    fSystemFormatSettings: TFormatSettings;
    function GetExprName: TxNativeString;
    Function GetMaxString: String; Virtual;
    Function GetAsString: String; Virtual;
   {$IFDEF LEVEL4}
    Function GetMaxWideString: WideString; Virtual; {added by fduenas: added WideString (Delphi4Up) support}
    Function GetAsWideString: WideString; Virtual; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Function GetAsFloat: Double; Virtual;
    Function GetAsInteger: Integer; Virtual;
    Function GetAsLargeInt: Int64; Virtual; {added by fduenas: added LargeInt (Int64) support}
    Function GetAsBoolean: Boolean; Virtual;
    Function GetExprType: TExprType; Virtual;
    Function GetCastType: Integer;  Virtual;
    Function GetIsNull: boolean; Virtual;
    function StringCharSize: Integer; Virtual;  { patched by ccy } {removed the 'abstract' clause to prevent compiler warnings}
  Public
    Function CanReadAs( aExprType: TExprType ): Boolean;
    Function SetFormatSettings(aRuntimeSettings, aSystemSettings: TFormatSettings): TExpression;
    function SetExpresionName(const aName: TxNativeString): TExpression;
    {means 'can be interpreted as'. Sort of}
    Property MaxString: String Read GetMaxString;
   {$IFDEF LEVEL4}
    Property MaxWideString: WideString Read GetMaxWideString;
   {$ENDIF}
    Property AsString: String Read GetAsString;
   {$IFDEF LEVEL4}
    Property AsWideString: WideString Read GetAsWideString; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Property AsFloat: Double Read GetAsFloat;
    Property AsInteger: Integer Read GetAsInteger;
    Property AsLargeInt: Int64 Read GetAsLargeInt; {added by fduenas: added LargeInt (Int64) support}
    Property AsBoolean: Boolean Read GetAsBoolean;
    Property ExprType: TExprType Read GetExprType;
    Property IsNull: boolean Read GetIsNull;
    Property MaxLen: Integer Read GetMaxLen;
    property ExprName: TxNativeString read GetExprName write FExprName;
  End;

  TLiteralExpr = Class( TExpression );
  TStringLiteral = Class( TLiteralExpr )
  Private
    FAsString: String;
  Protected
    Function GetAsString: String; Override;
   {$IFDEF LEVEL4}
    Function GetAsWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( Const aAsString: String;
     aRuntimeSettings, aSystemSettings: TFormatSettings );
  End;

 {$IFDEF LEVEL4} {added by fduenas: added WideString (Delphi4Up) support}
  TWideStringLiteral = Class( TStringLiteral )
  Private
    FAsWideString: WideString;
  Protected
    Function GetAsString: String; Override;
    Function GetAsWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( Const aAsWideString: WideString;
     aRuntimeSettings, aSystemSettings: TFormatSettings );
  End;
 {$ENDIF}

  TFloatLiteral = Class( TLiteralExpr )
  Private
    FAsFloat: Double;
  Protected
    Function GetAsString: String; Override;
    Function GetAsFloat: Double; Override;
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( Const aAsFloat: Double;
     aRuntimeSettings, aSystemSettings: TFormatSettings );
  End;

  TIntegerLiteral = Class( TLiteralExpr )
  Private
    FAsInteger: Integer;
  Protected
    Function GetAsString: String; Override;
    Function GetAsFloat: Double; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aAsInteger: Integer; aRuntimeSettings, aSystemSettings: TFormatSettings );
  End;

  TLargeIntLiteral = Class( TLiteralExpr ) {added by fduenas: added LargeInt (Int64) support}
  Private
    FAsLargeInt: Int64;
  Protected
    Function GetAsString: String; Override;
    Function GetAsFloat: Double; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aAsLargeInt: Int64;
     aRuntimeSettings, aSystemSettings: TFormatSettings );
  End;

  TBooleanLiteral = Class( TLiteralExpr )
  Private
    FAsBoolean: Boolean;
  Protected
    Function GetMaxString: String; Override;
    Function GetAsString: String; Override;
    Function GetAsFloat: Double; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetAsBoolean: Boolean; Override;
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aAsBoolean: Boolean;
     aRuntimeSettings, aSystemSettings: TFormatSettings );
  End;

  TParameterList = Class( TList )
  Private
    Function GetAsString( i: Integer ): String;
   {$IFDEF LEVEL4}
    Function GetAsWideString( i: Integer ): WideString; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Function GetAsFloat( i: Integer ): Double;
    Function GetAsInteger( i: Integer ): Integer;
    Function GetAsLargeInt( i: Integer ): Int64; {added by fduenas: added LargeInt (Int64) support}
    Function GetAsBoolean( i: Integer ): Boolean;
    Function GetExprType( i: Integer ): TExprType;
    Function GetParam( i: Integer ): TExpression;
  protected
    fRuntimeFormatSettings: TFormatSettings;
    fSystemFormatSettings: TFormatSettings;
  Public
    function GetExprTypeIndex( aExprTypeToFind: TExprType; aStartIndex: Integer=0; aCount: Integer=0 ):  Integer;
    Constructor Create( aRuntimeSettings, aSystemSettings: TFormatSettings );
    Destructor Destroy; Override;
    Property Param[i: Integer]: TExpression Read GetParam;
    Property ExprType[i: Integer]: TExprType Read GetExprType;
    Property AsString[i: Integer]: String Read GetAsString;
    {$IFDEF LEVEL4}
     Property AsWideString[i: Integer]: WideString Read GetAsWideString;
    {$ENDIF}
    Property AsFloat[i: Integer]: Double Read GetAsFloat;
    Property AsInteger[i: Integer]: Integer Read GetAsInteger;
    Property AsLargeInt[i: Integer]: Int64 Read GetAsLargeInt; {added by fduenas: added LargeInt (Int64) support}
    Property AsBoolean[i: Integer]: Boolean Read GetAsBoolean;
    property RuntimeFormatSettings: TFormatSettings read fRuntimeFormatSettings write fRuntimeFormatSettings;
    property SystemFormatSettings: TFormatSettings read fSystemFormatSettings write fSystemFormatSettings;
  End;

  TFunctionExpr = Class( TExpression )
  Private
    FParameterList: TParameterList;
    Function GetParam( n: Integer ): TExpression; virtual;
  Protected
    function CheckParameters: Boolean; overload; virtual;
    function CheckParameters(var aErrorCode:Integer; var aErrorMsg: TxNativeString): Boolean; overload; virtual;
  Public
    Constructor Create( aParameterList: TParameterList ); overload; virtual;
    Constructor Create( aName: TxNativeString; aParameterList: TParameterList ); overload; virtual;
    Constructor Create( aName: TxNativeString; aParameterList: TParameterList;
     aRunTimeFormatsettings, aSystemFormatsettings: TFormatSettings ); overload;
    Destructor Destroy; Override;
    Function ParameterCount: Integer;
    Property Param[n: Integer]: TExpression Read GetParam;
  End;

  TTypeCastExpr = Class( TFunctionExpr )
  Private
    OperatorType: TExprType;  {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
  Protected
    Function GetMaxString: String; Override;
   {$IFDEF LEVEL4}
    Function GetMaxWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
    Function GetAsWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Function GetAsString: String; Override;
    Function GetAsFloat: Double; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetAsBoolean: Boolean; Override;
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aParameterList: TParameterList;
      aOperator: TExprType );
  End;

  TNumericFunctionExpr = Class( TFunctionExpr );

  TMF =
    ( mfTrunc, mfRound, mfAbs, mfArcTan, mfCos, mfExp, mfFrac, mfInt,
    mfLn, mfPi, mfSin, mfSqr, mfSqrt, mfPower );

  TMathFunctionExprLib = Class( TNumericFunctionExpr )
  Private
    OperatorType: TMF; {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
  Protected
    function CheckParameters: Boolean; override;
  Protected
    Function GetAsFloat: Double; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aName: string; aParameterList: TParameterList;
      aOperator: TMF );
  End;

  TStringFunctionExpr = Class( TFunctionExpr );

  TSF = ( sfUpper, sfLower, sfCopy, sfPos, sfLength, sfLTrim, sfRTrim, sfTrim, sfConcat, sfConcatWS, sfChr ); {added sConcat and sdfConcatWS for concatenating values}

  TStringFunctionExprLib = Class( TFunctionExpr )
  Private
    OperatorType: TSF;
    {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
  Protected
    function CheckParameters: Boolean; override;
  Protected
    {added function for Special Copy Behaviour} {fduenas}
    Function DoCopyString(aString: string;
                          aStartPos, aCount: Integer): String; virtual;
    function DoConcat( aSeparator: string; aGetMaxString: boolean ) : string;
    function DoChr( aCharCode: Integer ): Char;
   {$IFDEF LEVEL4}
    Function DoCopyStringW(aString: WideString;
                           aStartPos, aCount: Integer): WideString; virtual;
    function DoConcatW( aSeparator: Widestring; aGetMaxString: boolean ): WideString;
    function DoChrW( aCharCode: integer ): WideChar;
   {$ENDIF}
    Function GetMaxString: String; Override;
   {$IFDEF LEVEL4}
    Function GetMaxWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
    Function GetAsWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Function GetAsString: String; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create(aName: string; aParameterList: TParameterList; aOperator: TSF );
  End;

  TConditionalExpr = Class( TFunctionExpr )
  Private
    Function Rex: TExpression;
  Protected
    function CheckParameters: Boolean; override;
    Function GetMaxString: String; Override;
   {$IFDEF LEVEL4}
    Function GetMaxWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
    Function GetAsWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Function GetAsString: String; Override;
    Function GetAsFloat: Double; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetAsBoolean: Boolean; Override;
    Function GetExprType: TExprType; Override;
   public
    Constructor Create( aParameterList: TParameterList ); override;
  End;

Type
  TOperatorType = ( opNot,
    opExp,
    opMult, opDivide, opDiv, opMod, opAnd, opShl, opShr,
    opPlus, opMinus, opOr, opXor,
    opEq, opNEQ, opLT, opGT, opLTE, opGTE );

type

  TOperatorTypeSet = Set Of TOperatorType;

  TOperatorExpr = Class( TExpression );
  TUnaryOp = Class( TOperatorExpr )
  Private
    Operand: TExpression;
    OperandType: TExprType;
    OperatorType: TOperatorType; {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
  Protected
    Function GetAsFloat: Double; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetAsBoolean: Boolean; Override;
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aOperator: TOperatorType; aOperand: TExpression );
    Destructor Destroy; Override;
  End;

  TBinaryOp = Class( TOperatorExpr )
  Private
    Operand1, Operand2: TExpression;
    OperatorType: TOperatorType; {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    OperandType: TExprType;
  Protected
    Function GetMaxString: String; Override;
    Function GetAsString: String; Override;
   {$IFDEF LEVEL4}
    Function GetMaxWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
    Function GetAsWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Function GetAsFloat: Double; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetAsBoolean: Boolean; Override;
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aOperator: TOperatorType; aOperand1, aOperand2: TExpression );
    Destructor Destroy; Override;
  End;

  TRelationalOp = Class( TOperatorExpr )
  Private
    Operand1, Operand2: TExpression;
    OperatorType: TOperatorType; {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
  Protected
    Function GetMaxString: String; Override;
    Function GetAsString: String; Override;
    Function GetAsFloat: Double; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetAsBoolean: Boolean; Override;
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aOperator: TOperatorType; aOperand1, aOperand2: TExpression );
    Destructor Destroy; Override;
  End;

  { additional functions }
  TASCIIExpr = Class( TFunctionExpr )
  Protected
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aName: TxNativeString; ParameterList: TParameterList );  override; {patched by fduenas: added constructor to validate input parameters}
  End;

  TLeftExpr = Class( TFunctionExpr )
  Protected
    Function GetMaxString: String; Override;
    Function GetAsString: String; Override;
   {$IFDEF LEVEL4}
    Function GetMaxWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
    Function GetAsWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aName: TxNativeString; ParameterList: TParameterList ); override; {patched by fduenas: added constructor to validate input parameters}
  End;

  TRightExpr = Class( TFunctionExpr )
  Protected
    Function GetMaxString: String; Override;
    Function GetAsString: String; Override;
   {$IFDEF LEVEL4}
    Function GetMaxWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
    Function GetAsWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aName: TxNativeString; ParameterList: TParameterList ); override; {patched by fduenas: added constructor to validate input parameters}
  End;

  { This function is used exclusively for the LIKE predicate in SQL }
  TLikePos = ( lpNone, lpLeft, lpMiddle, lpRight );
  TLikeCode = ( lcSingle, lcMultiple, lcOnlyUnderscores );

  TLikeItem = Class( TObject )
  Public
    LikeText: String; { text to find }
    LikePos: TLikePos; { text must go at left, middle, right or on a column }
    LikeCode: TLikeCode;
  End;

  TLikeList = Class( TObject )
  Private
    fItems: TList;
    Function GetCount: Integer;
    Function GetItem( Index: Integer ): TLikeItem;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Function Add: TLikeItem;
    Procedure Clear;
    Procedure Delete( Index: Integer );
    Property Count: Integer Read GetCount;
    Property Items[Index: Integer]: TLikeItem Read GetItem; Default;
  End;

  TSQLLikeExpr = Class( TFunctionExpr )
  Private
    LikeList: TLIKEList;
    FIsNotLike: Boolean;
    Function SQLPos( Var Start: Integer; Const Substr, Str: String ): Integer;
  Protected
    Function GetAsBoolean: Boolean; Override;
    function GetExprType: TExprtype; override;
  Public
    Constructor Create( ParameterList: TParameterList; IsNotLike: Boolean ); overload;
    Constructor Create( aName: String; ParameterList: TParameterList; IsNotLike: Boolean ); overload;
    Destructor Destroy; Override;
    Procedure AddToList( Like: TLikeItem );
  End;

  { TSQLMatchLikeExpr }
  { New proposed TSQLLikeExpr replacement }
  { TxMatchmask is bases in TMask class }
  { You can use:
     *, %: As Multiple Match
     ?,_: as Single Match
     [0-9|a-z]: Character sets
  }
  TxMatchMask = class;
  TSQLMatchLikeExpr = Class( TFunctionExpr )
  Protected
    fMatchMask: TxMatchMask;
    fIsNotLike: Boolean;
    function GetAsBoolean: Boolean; Override;
    function GetExprType: TExprtype; override;
    procedure DoSetup; virtual;
  Public
    Constructor Create( ParameterList: TParameterList; IsNotLike: Boolean ); overload;
    Constructor Create( aName: String; ParameterList: TParameterList; IsNotLike: Boolean ); overload;
    Destructor Destroy; Override;
  End;

  { Helper Class For  TSQLMatchLikeExpr }
  TxMatchMask = class( TObject)
  protected
    const
     MaxCards = 30;
    type
     PMaskSet = ^TMaskSet;
     TMaskSet = set of AnsiChar;
     TMaskStates = (msLiteral, msAny, msSet, msMBCSLiteral);
     TMaskState = record
       SkipTo: Boolean;
       case State: TMaskStates of
         msLiteral: (Literal: Char);
         msAny: ();
         msSet: (
           Negate: Boolean;
           CharSet: PMaskSet);
         msMBCSLiteral: (LeadByte, TrailByte: Char);
     end;
     PMaskStateArray = ^TMaskStateArray;
     TMaskStateArray = array[0..128] of TMaskState;
  protected
   fExprName: string;
   fMask: string;
   fMaskPtr: Pointer;
   fSize: Integer;
   fEscapeChar, fAnyMultipleChar, fSingleChar,
   fAnyMultipleCharStrict, fSingleCharStrict: Char;
  protected
   function InitMaskStates(const AMask: string;
    var AMaskStates: array of TMaskState): Integer;
   function MatchesMaskStates(const AString: string;
    const AMaskStates: array of TMaskState): Boolean;
   procedure DoneMaskStates(var AMaskStates: array of TMaskState);
  public
    constructor Create(const AExprName, AMaskValue: string); reintroduce;
    constructor CreateWithParams(const AExprName, AMaskValue: string;
     AEscapeChar:char='\'; AAnyMultipleChar:char='*';
     ASingleChar:char='?'; AAnyMultipleCharStrict:char='%'; ASingleCharStrict:char='_');
    destructor Destroy; override;
    procedure Setup(const AMaskValue: string;
     AEscapeChar:char='\'; AAnyMultipleChar:char='*';
     ASingleChar:char='?'; AAnyMultipleCharStrict:char='%'; ASingleCharStrict:char='_');
    function Matches(const AString: string): Boolean;
  end;

  { TSQLInPredicateExpr }
  { This function is used exclusively for the IN predicate in SQL SELECT
     something like this : SELECT * FROM customer WHERE CustNo IN (1,10,8) }
  TSQLInPredicateExpr = Class( TFunctionExpr )
  Private
    FIsNotIn: Boolean;
  Protected
    Function GetAsBoolean: Boolean; Override;
    function GetExprType: TExprtype; override;
  Public
    Constructor Create( ParameterList: TParameterList; IsNotIn: Boolean );
  End;

  TBetweenExpr = Class( TFunctionExpr )
  Private
    FIsNotBetween: Boolean;
  Protected
    Function GetAsBoolean: Boolean; Override;
    function GetExprType: TExprtype; override;
  Public
    Constructor Create( ParameterList: TParameterList; IsNotBetween: Boolean );
  End;

  TCaseWhenElseExpr = Class( TFunctionExpr )
  Private
    FElseExpr: TExpression;
    FThenParamList: TParameterList;
  Protected
    function CheckParameters: Boolean; override;
    Function GetMaxString: String; Override;
    Function GetAsString: String; Override;
   {$IFDEF LEVEL4}
    Function GetMaxWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
    Function GetAsWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Function GetAsFloat: Double; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetAsBoolean: Boolean; Override;
    function GetExprType: TExprtype; override;
  Public
    Constructor Create( WhenParamList: TParameterList;
      ThenParamList: TParameterList; ElseExpr: TExpression );
    Destructor Destroy; Override;
  End;

  TDecodeExpr = Class( TFunctionExpr )
  Protected
    Function GetMaxString: String; Override;
    Function GetAsString: String; Override;
   {$IFDEF LEVEL4}
    Function GetMaxWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
    Function GetAsWideString: WideString; Override; {added by fduenas: added WideString (Delphi4Up) support}
   {$ENDIF}
    Function GetAsFloat: Double; Override;
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetAsBoolean: Boolean; Override;
    function GetExprType: TExprtype; override;
  Public
    Constructor Create( aName: TxNativeString; ParameterList: TParameterList ); override; {patched by fduenas: added constructor to validate input parameters}
  End;

  {Evaluate FormatDateTime('dd/mmm/yyyy', 32767)}
  TFormatDateTimeExpr = Class( TFunctionExpr )
  Protected
    Function GetMaxString: String; Override;
    Function GetAsString: String; Override;
    Function GetExprType: TExprType; Override;
  End;

  {Evaluate FormatFloat('###,###,##0.00', 12345.567)}
  TFormatFloatExpr = Class( TFunctionExpr )
  Protected
    Function GetMaxString: String; Override;
    Function GetAsString: String; Override;
    Function GetExprType: TExprType; Override;
  End;

  {Evaluate Format(Format,Args)}
  TFormatExpr = Class( TFunctionExpr )
  Protected
    Function GetMaxString: String; Override;
    Function GetAsString: String; Override;
    Function GetMaxWideString: WideString; Override;
   {$IFDEF LEVEL4}
    Function GetAsWideString: WideString; Override;
   {$ENDIF}
    Function GetExprType: TExprType; Override;
  End;

  TDecodeKind = ( dkYear, dkMonth, dkDay, dkHour, dkMin, dkSec, dkMSec, dkWeek );

  { supports syntax: YEAR(expr), MONTH(expr), DAY(expr), HOUR(expr), MIN(expr), SEC(expr), MSEC(expr)}
  TDecodeDateTimeExpr = Class( TFunctionExpr )
  Private
    FDecodeKind: TDecodeKind;
  Protected
    Function GetAsInteger: Integer; Override;
    Function GetAsLargeInt: Int64; Override; {added by fduenas: added LargeInt (Int64) support}
    Function GetExprType: TExprType; Override;
  Public
    Constructor Create( aName: string; ParameterList: TParameterList; DecodeKind: TDecodeKind );
  End;

  {  MINOF(arg1,arg2, ..., argn), MAXOF(ARG1,ARG2, ... ,argn)
      hint by: Fady Geagea
  }
  TMinMaxOfExpr = Class( TFunctionExpr )
  Private
    FIsMin: Boolean;
  Protected
    Function GetAsFloat: Double; Override;
    function GetExprType: TExprtype; override;
  Public
    Constructor Create( aName: string; ParameterList: TParameterList; IsMin: Boolean );
  End;
  function CreateStringLiteralObj(Const aAsString: {$IFDEF UNICODE}String{$ELSE}TxNativeWideString{$ENDIF};
     aRuntimeSettings, aSystemSettings: TFormatSettings): TStringLiteral;
Implementation

Uses
  XQMiscel, QExprYacc, XQConsts, QCnvStrUtils, Math;

Const
  NOperatorType: Array[TOperatorType] Of String =
  ( 'opNot',
    'opExp',
    'opMult', 'opDivide', 'opDiv', 'opMod', 'opAnd', 'opShl', 'opShr',
    'opPlus', 'opMinus', 'opOr', 'opXor',
    'opEq', 'opNEQ', 'opLT', 'opGT', 'opLTE', 'opGTE' );

  RelationalOperators = [opEQ, opNEQ, opLT, opGT, opLTE, opGTE];

function CreateStringLiteralObj(Const aAsString: {$IFDEF UNICODE}String{$ELSE}TxNativeWideString{$ENDIF};
     aRuntimeSettings, aSystemSettings: TFormatSettings): TStringLiteral;
begin
   if XQStringIsUnicode(aAsString)  then
      result := TWideStringLiteral.Create( aAsString, aRuntimeSettings, aSystemSettings )
   else
      result := TStringLiteral.Create( aAsString, aRuntimeSettings, aSystemSettings );
end;
Function ResultType( OperatorType: TOperatorType; OperandType: TExprType ): TExprType; {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }

  Procedure NotAppropriate;
  Begin
    Result := ttString;
    Raise EExpression.CreateFmt( SEXPR_OPERATORINCOMPAT,
      [NOperatorType[OperatorType], NExprType[OperandType]] ) {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
  End;

Begin
  Case OperandType Of
    ttString:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opPlus: Result := ttString;
        opEq..opGTE: Result := ttBoolean;
      Else
        NotAppropriate;
      End;
   {$IFDEF LEVEL4}
    ttWideString:  {added by fduenas: added WideString (Delphi4Up) support}
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opPlus: Result := ttWideString;
        opEq..opGTE: Result := ttBoolean;
      Else
        NotAppropriate;
      End;
   {$ENDIF}
    ttFloat:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opExp, opMult, opDivide, opPlus, opMinus: Result := ttFloat;
        opEq..opGTE: Result := ttBoolean;
      Else
        NotAppropriate;
      End;
    ttInteger:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opNot, opMult, opDiv, opMod, opAnd, opShl, opShr, opPlus, opMinus,
          opOr, opXor: Result := ttInteger;
        opExp, opDivide: Result := ttFloat;
        opEq..opGTE: Result := ttBoolean;
      Else
        NotAppropriate;
      End;
     ttLargeInt:  {added by fduenas: added LargeInt (Int64) support}
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opNot, opMult, opDiv, opMod, opAnd, opShl, opShr, opPlus, opMinus,
          opOr, opXor: Result := ttLargeInt;
        opExp, opDivide: Result := ttFloat;
        opEq..opGTE: Result := ttBoolean;
      Else
        NotAppropriate;
      End;
    ttBoolean:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opNot, opAnd, opOr, opXor, opEq, opNEQ: Result := ttBoolean;
      Else
        NotAppropriate;
      End;
  End
End;

Function CommonType( Op1Type, Op2Type: TExprType ): TExprType;
Begin
  If Op1Type < Op2Type Then
    Result := Op1Type
  Else
    Result := Op2Type
End;

Procedure Internal( Code: Integer );
Begin
  Raise EExpression.CreateFmt( 'Internal parser error. Code %d', [Code] )
End;

Function TExpression.GetIsNull: boolean;
Begin
  //Result := AsString = '';
  Result := False;
End;

Function TExpression.GetMaxLen: Integer;
Begin
  Result:= 0;
  If (ExprType = ttString) then
    Result:= Length( GetMaxString ) {* SizeOf(Char)};  { patched by ccy } {patched by fduenas: prevents duplication of original string size}
 {$IFDEF LEVEL4}
  If (ExprType = ttWideString) then {added by fduenas: added WideString (Delphi4Up) support}
    Result:= Length( GetMaxWideString ); {* SizeOf(Char)};  { patched by ccy } {patched by fduenas: prevents duplication of original string size}
 {$ENDIF}
End;

Function TExpression.GetMaxString: String;
Begin
  Result:= AsString;  { the same string as default }
End;
{$IFDEF LEVEL4}
function TExpression.GetMaxWideString: WideString;
begin
  Result := GetMaxString; { the same string as default }
end;
{$ENDIF}
function TExpression.SetExpresionName(const aName: TxNativeString): TExpression;
begin
 fExprName := aName;
 Result := Self;
end;

function TExpression.SetFormatSettings(aRuntimeSettings,
  aSystemSettings: TFormatSettings): TExpression;
begin
 fRuntimeFormatSettings := aRuntimeSettings;
 fSystemFormatSettings  := aSystemSettings;
 result := self;
end;

function TExpression.StringCharSize: Integer;
begin
 {$IFDEF LEVEL4}
  if ExprType=ttWideString then {added by fduenas: added WideString (Delphi4Up) support}
     result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(TxNativeWideChar){$ELSE}XQ_SizeOf_NativeWideChar{$ENDIF}
  else
 {$ENDIF}
     result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(AnsiChar){$ELSE}XQ_SizeOf_AnsiChar{$ENDIF};
end;

Function TExpression.GetAsString: String;
Begin
  Case ExprType Of
    ttString: Raise EExpression.CreateFmt( SEXPR_CANNOTCASTTOSTRING,
        [NExprType[ExprType]] );
    {$IFDEF LEVEL4}
    ttWideString: Raise EExpression.CreateFmt( SEXPR_CANNOTCASTTOWIDESTRING,
        [NExprType[ExprType]] );
    {$ENDIF}
    ttFloat: Result := FloatToStr( AsFloat{$IFDEF Delphi7Up}, fSystemFormatSettings{$ENDIF} );
    ttInteger: Result := IntToStr( AsInteger );
    ttLargeInt: Result := IntToStr( AsLargeInt ); {added by fduenas: added LargeInt (Int64) support}
    ttBoolean: Result := NBoolean[AsBoolean];
  End
End;
function TExpression.GetCastType: Integer;
begin
 result := 0;
end;

function TExpression.GetExprName: TxNativeString;
begin
 result := fExprName;
end;

function TExpression.GetExprType: TExprType;
begin
 result := ttString;
end;

{$IFDEF LEVEL4}
function TExpression.GetAsWideString: WideString;
begin
 result := GetAsString;
end;
{$ENDIF}
Function TExpression.GetAsFloat: Double;
Begin
  Result := 0;
  Case ExprType Of
    ttString{$IFDEF LEVEL4}, ttWideString {$ENDIF}:
      begin
        try
          Result := StrToFloat(AsString{$IFDEF Delphi7Up}, fRuntimeFormatSettings{$ENDIF});
        except
          on EConvertError do
            Result := StrToDateTime(AsString{$IFDEF Delphi7Up}, fRuntimeFormatSettings{$ENDIF});
        end;
      end;
    ttFloat:
      Raise EExpression.CreateFmt( SEXPR_CANNOTCASTTOFLOAT, [NExprType[ExprType]] );
    ttInteger, ttBoolean: Result := AsInteger;
    ttLargeInt: Result := AsLargeInt; {added by fduenas: added LargeInt (Int64) support}
  End
End;

Function TExpression.GetAsInteger: Integer;
Begin
  Result := 0;
  Case ExprType Of
    // Allow cast expression to string
    ttString {$IFDEF LEVEL4}, ttWideString {$ENDIF} : Result := StrToInt(AsString);

    //ttFloat : Result := FloatToStr (AsFloat{$IFDEF Delphi7Up}, fSystemFormatSettings{$ENDIF});
    ttFloat, ttInteger: raise EExpression.CreateFmt(SEXPR_CANNOTCASTTOINTEGER,
                               [NExprType[ExprType]]);
    ttLargeInt: raise EExpression.CreateFmt(SEXPR_CANNOTCASTTOINTEGER,
                               [NExprType[ExprType]]); {added by fduenas: added LargeInt (Int64) support}
    ttBoolean: Result := Integer( AsBoolean );
  End;
End;

function TExpression.GetAsLargeInt: Int64; {added by fduenas: added LargeInt (Int64) support}
begin
  Result := 0;
  Case ExprType Of
    // Allow cast expression to string
    ttString {$IFDEF LEVEL4}, ttWideString {$ENDIF}: Result := StrToInt64(AsString);
    //ttFloat : Result := FloatToStr (AsFloat{$IFDEF Delphi7Up}, fSystemFormatSettings{$ENDIF});
    ttFloat, ttInteger: raise EExpression.CreateFmt(SEXPR_CANNOTCASTTOLARGEINTEGER,
                               [NExprType[ExprType]]);
    ttLargeInt: raise EExpression.CreateFmt(SEXPR_CANNOTCASTTOLARGEINTEGER,
                               [NExprType[ExprType]]);
    ttBoolean: Result := Int64( AsBoolean );
  End;
end;

Function TExpression.GetAsBoolean: Boolean;
Begin
  Raise EExpression.CreateFmt( SEXPR_CANNOTCASTTOBOOLEAN,
    [NExprType[ExprType]] )
End;

Function TExpression.CanReadAs( aExprType: TExprType ): Boolean;
Begin
  Result := Ord( ExprType ) >= Ord( aExprType )
End;

{ TStringLiteral }
Function TStringLiteral.GetAsString: String;
Begin
  Result := FAsString
End;
{$IFDEF LEVEL4}
function TStringLiteral.GetAsWideString: WideString;
begin
 result := GetAsString;
end;
{$ENDIF}
Function TStringLiteral.GetExprType: TExprType;
Begin
  Result := ttString
End;

Constructor TStringLiteral.Create( Const aAsString: String;
 aRuntimeSettings, aSystemSettings: TFormatSettings );
Begin
  Inherited Create;
  FAsString := aAsString;
  SetFormatSettings(aRuntimeSettings, aSystemSettings);
End;

{$IFDEF LEVEL4}
{ TWideStringLiteral }

constructor TWideStringLiteral.Create(const aAsWideString: WideString;
 aRuntimeSettings, aSystemSettings: TFormatSettings);
begin
 Inherited Create( aAsWideString, aRuntimeSettings, aSystemSettings );
 FAsWideString := aAsWideString;
end;

function TWideStringLiteral.GetAsString: String;
begin
 Result := FAsWideString;
end;

function TWideStringLiteral.GetAsWideString: WideString;
begin
 result := FAsWideString;
end;

function TWideStringLiteral.GetExprType: TExprType;
begin
 result := ttWideString;
end;
{$ENDIF}

{ TFloatLiteral }
Function TFloatLiteral.GetAsString: String;
Begin
 Result := FloatToStr( FAsFloat{$IFDEF Delphi7Up}, fRuntimeFormatSettings{$ENDIF} )
End;

Function TFloatLiteral.GetAsFloat: Double;
Begin
  Result := FAsFloat
End;

Function TFloatLiteral.GetExprType: TExprType;
Begin
  Result := ttFloat
End;

Constructor TFloatLiteral.Create( Const aAsFloat: Double;
 aRuntimeSettings, aSystemSettings: TFormatSettings );
Begin
  Inherited Create;
  FAsFloat := aAsFloat;
  SetFormatSettings(aRuntimeSettings, aSystemSettings);
End;

Function TIntegerLiteral.GetAsString: String;
Begin
  Result := IntToStr( FAsInteger ); //FloatToStr( FAsInteger{$IFDEF Delphi7Up}, fSystemFormatSettings{$ENDIF} )
End;

Function TIntegerLiteral.GetAsFloat: Double;
Begin
  Result := FAsInteger
End;

Function TIntegerLiteral.GetAsInteger: Integer;
Begin
  Result := FAsInteger
End;

function TIntegerLiteral.GetAsLargeInt: Int64; {added by fduenas: added LargeInt (Int64) support}
begin
 result := FAsInteger;
end;

Function TIntegerLiteral.GetExprType: TExprType;
Begin
  Result := ttInteger
End;

Constructor TIntegerLiteral.Create( aAsInteger: Integer;
 aRuntimeSettings, aSystemSettings: TFormatSettings );
Begin
  Inherited Create;
  FAsInteger := aAsInteger;
  SetFormatSettings(aRuntimeSettings, aSystemSettings);
End;

{ TLargeIntLiteral }

constructor TLargeIntLiteral.Create(aAsLargeInt: Int64;
 aRuntimeSettings, aSystemSettings: TFormatSettings);
begin
 Inherited Create;
 FAsLargeInt := aAsLargeInt;
 SetFormatSettings(aRuntimeSettings, aSystemSettings);
end;

function TLargeIntLiteral.GetAsFloat: Double;
begin
 result := FAsLargeInt;
end;

function TLargeIntLiteral.GetAsInteger: Integer;
begin
 result := Integer( FAsLargeInt );
end;

function TLargeIntLiteral.GetAsLargeInt: Int64;
begin
 result := FAsLargeInt;
end;

function TLargeIntLiteral.GetAsString: String;
begin
   Result := IntToStr( FAsLargeInt );// FloatToStr( FAsLargeInt{$IFDEF Delphi7Up}, fSystemFormatSettings{$ENDIF} )
end;

function TLargeIntLiteral.GetExprType: TExprType;
begin
   Result := ttLargeInt
end;

function TBooleanLiteral.GetMaxString: String;
begin
  Result:=NBoolean[False];
end;

Function TBooleanLiteral.GetAsString: String;
Begin
  Result := NBoolean[FAsBoolean];
End;

Function TBooleanLiteral.GetAsFloat: Double;
Begin
  Result := GetAsInteger;
End;

Function TBooleanLiteral.GetAsInteger: Integer;
Begin
  Result := Integer( FAsBoolean );
End;

function TBooleanLiteral.GetAsLargeInt: Int64;
begin
 result := Int64( FAsBoolean );
end;

Function TBooleanLiteral.GetAsBoolean: Boolean;
Begin
 Result := FAsBoolean;
End;

Function TBooleanLiteral.GetExprType: TExprType;
Begin
  Result := ttBoolean
End;

Constructor TBooleanLiteral.Create( aAsBoolean: Boolean; aRuntimeSettings, aSystemSettings: TFormatSettings
 );
Begin
  Inherited Create;
  FAsBoolean := aAsBoolean;
  SetFormatSettings(aRuntimeSettings, aSystemSettings);
End;

Function TUnaryOp.GetAsFloat: Double;
Begin
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    opMinus: Result := -Operand.AsFloat;
    opPlus: Result := Operand.AsFloat;
  Else
    Result := Inherited GetAsFloat;
  End
End;

Function TUnaryOp.GetAsInteger: Integer;
Begin
  Result := 0;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    opMinus: Result := -Operand.AsInteger;
    opPlus: Result := Operand.AsInteger;
    opNot:
      Case OperandType Of
        ttInteger: Result := Not Operand.AsInteger;
        ttLargeInt: Result := Not Operand.AsLargeInt; {added by fduenas: added LargeInt (Int64) support}
        ttBoolean: Result := Integer( AsBoolean );
      Else
        Internal( 6 );
      End;
  Else
    Result := Inherited GetAsInteger;
  End
End;

function TUnaryOp.GetAsLargeInt: Int64; {added by fduenas: added LargeInt (Int64) support}
Begin
  Result := 0;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    opMinus: Result := -Operand.AsLargeInt;
    opPlus: Result := Operand.AsLargeInt;
    opNot:
      Case OperandType Of
        ttInteger: Result := Not Operand.AsInteger;
        ttLargeInt: Result := Not Operand.AsLargeInt;
        ttBoolean: Result := Int64( AsBoolean );
      Else
        Internal( 6 );
      End;
  Else
    Result := Inherited GetAsLargeInt;
  End
End;

Function TUnaryOp.GetAsBoolean: Boolean;
Begin
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    opNot: Result := Not ( Operand.AsBoolean )
  Else
    Result := Inherited GetAsBoolean;
  End
End;

Function TUnaryOp.GetExprType: TExprType;
Begin
  Result := ResultType( OperatorType, OperandType ) {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
End;

Constructor TUnaryOp.Create( aOperator: TOperatorType; aOperand: TExpression );
Begin
  Inherited Create;
  Operand := aOperand;
  fExprName :=  NOperatorType[aOperator];
  fRuntimeFormatSettings := aOperand.fRuntimeFormatSettings;
  fSystemFormatSettings := aOperand.fSystemFormatSettings;
  OperatorType := aOperator; {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
  OperandType := Operand.ExprType;
  If Not ( OperatorType In [opNot, opPlus, opMinus] ) Then {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    Raise EExpression.CreateFmt( SEXPR_WRONGUNARYOP,
      [NOperatorType[OperatorType]] ) {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
End;

Destructor TUnaryOp.Destroy;
Begin
  Operand.Free;
  Inherited Destroy
End;

Function TBinaryOp.GetMaxString: String;
begin
  If ExprType in [ttString{$IFDEF LEVEL4}, ttWideString{$ENDIF}] then
  begin
    Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
      opPlus: Result := Operand1.GetMaxString + Operand2.GetMaxString;
    Else
      Internal( 10 );
    End;
  end else
    Result:= GetAsString;
end;
{$IFDEF LEVEL4}
function TBinaryOp.GetMaxWideString: WideString;
begin
  If ExprType in [ttString, ttWideString] then
  begin
    Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
      opPlus: Result := Operand1.GetMaxWideString + Operand2.GetMaxWideString;
    Else
      Internal( 10 );
    End;
  end else
    Result:= GetAsWideString;
end;
{$ENDIF}
Function TBinaryOp.GetAsString: String;
Begin
  Result := '';
  Case ExprType Of
    ttString:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opPlus: Result := Operand1.AsString + Operand2.AsString;
      Else
        Internal( 10 );
      End;
   {$IFDEF LEVEL4}
    ttWideString:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opPlus: Result := Operand1.AsWideString + Operand2.AsWideString;
      Else
        Internal( 10 );
      End;
   {$ENDIF}
    ttFloat:
      Result := FloatToStr( AsFloat{$IFDEF Delphi7Up}, fSystemFormatSettings{$ENDIF} );
    ttInteger:
      Result := IntToStr( AsInteger );
    ttLargeInt:
      Result := IntToStr( AsLargeInt ); {added by fduenas: added LargeInt (Int64) support}
    ttBoolean:
      Result := NBoolean[AsBoolean];
  End
End;
{$IFDEF LEVEL4}
function TBinaryOp.GetAsWideString: WideString;
Begin
  Result := '';
  Case ExprType Of
    ttString:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opPlus: Result := Operand1.AsString + Operand2.AsString;
      Else
        Internal( 10 );
      End;
    ttWideString:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opPlus: Result := Operand1.AsWideString + Operand2.AsWideString;
      Else
        Internal( 10 );
      End;
    ttFloat:
      Result := FloatToStr( AsFloat{$IFDEF Delphi7Up}, fSystemFormatSettings{$ENDIF} );
    ttInteger:
      Result := IntToStr( AsInteger );
    ttLargeInt:
      Result := IntToStr( AsLargeInt ); {added by fduenas: added LargeInt (Int64) support}
    ttBoolean:
      Result := NBoolean[AsBoolean];
  End
End;
{$ENDIF}

Function TBinaryOp.GetAsFloat: Double;
Begin
  Result := 0;
  Case ExprType Of
    ttFloat:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opExp: Result := Exp( Operand2.AsFloat * Ln( Operand1.AsFloat ) );
        opPlus: Result := Operand1.AsFloat + Operand2.AsFloat;
        opMinus: Result := Operand1.AsFloat - Operand2.AsFloat;
        opMult: Result := Operand1.AsFloat * Operand2.AsFloat;
        opDivide: Result := Operand1.AsFloat / Operand2.AsFloat;
      Else
        Internal( 11 );
      End;
    ttInteger:
      Result := AsInteger;
    ttLargeInt:
      Result := AsLargeInt; {added by fduenas: added LargeInt (Int64) support}
    ttBoolean:
      Result := Integer( AsBoolean );
  End
End;

Function TBinaryOp.GetAsInteger: Integer;
Begin
  Result := 0;
  Case ExprType Of
    ttInteger:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opPlus: Result := Operand1.AsInteger + Operand2.AsInteger;
        opMinus: Result := Operand1.AsInteger - Operand2.AsInteger;
        opMult: Result := Operand1.AsInteger * Operand2.AsInteger;
        opDiv: Result := Operand1.AsInteger Div Operand2.AsInteger;
        opMod: Result := Operand1.AsInteger Mod Operand2.AsInteger;
        opShl: Result := Operand1.AsInteger Shl Operand2.AsInteger;
        opShr: Result := Operand1.AsInteger Shr Operand2.AsInteger;
        opAnd: Result := Operand1.AsInteger And Operand2.AsInteger;
        opOr: Result := Operand1.AsInteger Or Operand2.AsInteger;
        opXor: Result := Operand1.AsInteger Xor Operand2.AsInteger;
      Else
        Internal( 12 );
      End;
    ttLargeInt:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opPlus: Result := Operand1.AsLargeInt + Operand2.AsLargeInt;
        opMinus: Result := Operand1.AsLargeInt - Operand2.AsLargeInt;
        opMult: Result := Operand1.AsLargeInt * Operand2.AsLargeInt;
        opDiv: Result := Operand1.AsLargeInt Div Operand2.AsLargeInt;
        opMod: Result := Operand1.AsLargeInt Mod Operand2.AsLargeInt;
        opShl: Result := Operand1.AsLargeInt Shl Operand2.AsLargeInt;
        opShr: Result := Operand1.AsLargeInt Shr Operand2.AsLargeInt;
        opAnd: Result := Operand1.AsLargeInt And Operand2.AsLargeInt;
        opOr: Result := Operand1.AsLargeInt Or Operand2.AsLargeInt;
        opXor: Result := Operand1.AsLargeInt Xor Operand2.AsLargeInt;
      Else
        Internal( 12 );
      End;
    ttBoolean:
      Result := Integer( GetAsBoolean );
  End
End;

function TBinaryOp.GetAsLargeInt: Int64;
begin
Begin
  Result := 0;
  Case ExprType Of
    ttInteger:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opPlus: Result := Operand1.AsInteger + Operand2.AsInteger;
        opMinus: Result := Operand1.AsInteger - Operand2.AsInteger;
        opMult: Result := Operand1.AsInteger * Operand2.AsInteger;
        opDiv: Result := Operand1.AsInteger Div Operand2.AsInteger;
        opMod: Result := Operand1.AsInteger Mod Operand2.AsInteger;
        opShl: Result := Operand1.AsInteger Shl Operand2.AsInteger;
        opShr: Result := Operand1.AsInteger Shr Operand2.AsInteger;
        opAnd: Result := Operand1.AsInteger And Operand2.AsInteger;
        opOr: Result := Operand1.AsInteger Or Operand2.AsInteger;
        opXor: Result := Operand1.AsInteger Xor Operand2.AsInteger;
      Else
        Internal( 12 );
      End;
    ttLargeInt:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opPlus: Result := Operand1.AsLargeInt + Operand2.AsLargeInt;
        opMinus: Result := Operand1.AsLargeInt - Operand2.AsLargeInt;
        opMult: Result := Operand1.AsLargeInt * Operand2.AsLargeInt;
        opDiv: Result := Operand1.AsLargeInt Div Operand2.AsLargeInt;
        opMod: Result := Operand1.AsLargeInt Mod Operand2.AsLargeInt;
        opShl: Result := Operand1.AsLargeInt Shl Operand2.AsLargeInt;
        opShr: Result := Operand1.AsLargeInt Shr Operand2.AsLargeInt;
        opAnd: Result := Operand1.AsLargeInt And Operand2.AsLargeInt;
        opOr: Result := Operand1.AsLargeInt Or Operand2.AsLargeInt;
        opXor: Result := Operand1.AsLargeInt Xor Operand2.AsLargeInt;
      Else
        Internal( 12 );
      End;
    ttBoolean:
      Result := Int64( GetAsBoolean );
  End
End;
end;

Function TBinaryOp.GetAsBoolean: Boolean;
Begin
  Result := false;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    opAnd: Result := Operand1.AsBoolean And Operand2.AsBoolean;
    opOr: Result := Operand1.AsBoolean Or Operand2.AsBoolean;
    opXor: Result := Operand1.AsBoolean Xor Operand2.AsBoolean;
  Else
    Internal( 13 );
  End
End;

Function TBinaryOp.GetExprType: TExprType;
Begin
  result := ResultType( OperatorType, OperandType ) {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
End;

Constructor TBinaryOp.Create( aOperator: TOperatorType; aOperand1, aOperand2: TExpression );
Begin
  Inherited Create;
  OperatorType := aOperator; {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
  fExprName :=  NOperatorType[aOperator];
  Operand1 := aOperand1;
  Operand2 := aOperand2;
  OperandType := CommonType( Operand1.ExprType, Operand2.ExprType );
  fRuntimeFormatSettings := aOperand1.fRuntimeFormatSettings;
  fSystemFormatSettings := aOperand1.fSystemFormatSettings;
  If Not ( OperatorType In [opExp, opMult..opXor] ) Then {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    Raise EExpression.CreateFmt( SEXPR_WRONGBINARYOP,
      [NOperatorType[OperatorType]] ) {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
End;

Destructor TBinaryOp.Destroy;
Begin
  Operand1.Free;
  Operand2.Free;
  Inherited Destroy
End;

Function TRelationalOp.GetMaxString: String;
Begin
  Result := NBoolean[False];
End;

Function TRelationalOp.GetAsString: String;
Begin
  Result := NBoolean[AsBoolean]
End;

Function TRelationalOp.GetAsFloat: Double;
Begin
  Result := Integer( AsBoolean )
End;

Function TRelationalOp.GetAsInteger: Integer;
Begin
  Result := Integer( AsBoolean )
End;

function TRelationalOp.GetAsLargeInt: Int64;
begin
 Result := Int64( AsBoolean )
end;

Function TRelationalOp.GetAsBoolean: Boolean;
Begin
  Result := false;

  If ( Operand1.IsNull ) and ( Operand2.IsNull ) and (OperatorType=opEQ) Then {added by fduenas: NULL=NULL must return true}
  begin
   result := true;
   exit;
  end
  else If ( Operand1.IsNull ) Or ( Operand2.IsNull ) Then
       Exit;
  Case CommonType( Operand1.ExprType, Operand2.ExprType ) Of
    ttBoolean:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opEQ: Result := Operand1.AsBoolean = Operand2.AsBoolean;
        opNEQ: Result := Operand1.AsBoolean <> Operand2.AsBoolean;
      Else
        Raise EExpression.CreateFmt( SEXPR_WRONGBOOLEANOP,
          [NOperatorType[OperatorType]] ); {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
      End;

    ttInteger:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opLT: Result := Operand1.AsInteger < Operand2.AsInteger;
        opLTE: Result := Operand1.AsInteger <= Operand2.AsInteger;
        opGT: Result := Operand1.AsInteger > Operand2.AsInteger;
        opGTE: Result := Operand1.AsInteger >= Operand2.AsInteger;
        opEQ: Result := Operand1.AsInteger = Operand2.AsInteger;
        opNEQ: Result := Operand1.AsInteger <> Operand2.AsInteger;
      End;

    ttLargeInt:  {added by fduenas: added LargeInt (Int64) support}
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opLT: Result := Operand1.AsLargeInt < Operand2.AsLargeInt;
        opLTE: Result := Operand1.AsLargeInt <= Operand2.AsLargeInt;
        opGT: Result := Operand1.AsLargeInt > Operand2.AsLargeInt;
        opGTE: Result := Operand1.AsLargeInt >= Operand2.AsLargeInt;
        opEQ: Result := Operand1.AsLargeInt = Operand2.AsLargeInt;
        opNEQ: Result := Operand1.AsLargeInt <> Operand2.AsLargeInt;
      End;

    ttFloat:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opLT: Result := Operand1.AsFloat < Operand2.AsFloat;
        opLTE: Result := Operand1.AsFloat <= Operand2.AsFloat;
        opGT: Result := Operand1.AsFloat > Operand2.AsFloat;
        opGTE: Result := Operand1.AsFloat >= Operand2.AsFloat;
        opEQ: Result := Operand1.AsFloat = Operand2.AsFloat;
        opNEQ: Result := Operand1.AsFloat <> Operand2.AsFloat;
      End;

    ttString:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opLT: Result := Operand1.AsString < Operand2.AsString;
        opLTE: Result := Operand1.AsString <= Operand2.AsString;
        opGT: Result := Operand1.AsString > Operand2.AsString;
        opGTE: Result := Operand1.AsString >= Operand2.AsString;
        opEQ: Result := Operand1.AsString = Operand2.AsString;
        opNEQ: Result := Operand1.AsString <> Operand2.AsString;
      End;
   {$IFDEF LEVEL4}
    ttWideString:
      Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
        opLT: Result := Operand1.AsWideString < Operand2.AsWideString;
        opLTE: Result := Operand1.AsWideString <= Operand2.AsWideString;
        opGT: Result := Operand1.AsWideString > Operand2.AsWideString;
        opGTE: Result := Operand1.AsWideString >= Operand2.AsWideString;
        opEQ: Result := Operand1.AsWideString = Operand2.AsWideString;
        opNEQ: Result := Operand1.AsWideString <> Operand2.AsWideString;
      End;
   {$ENDIF}
  End
End;

Function TRelationalOp.GetExprType: TExprType;
Begin
  Result := ttBoolean
End;

Constructor TRelationalOp.Create( aOperator: TOperatorType; aOperand1, aOperand2: TExpression );
Begin
  Inherited Create;
  OperatorType := aOperator; {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
  fExprName :=  NOperatorType[aOperator];
  Operand1 := aOperand1;
  Operand2 := aOperand2;
  fRuntimeFormatSettings := aOperand1.fRuntimeFormatSettings;
  fSystemFormatSettings := aOperand1.fSystemFormatSettings;
  If Not ( OperatorType In RelationalOperators ) Then {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    Raise EExpression.CreateFmt( SEXPR_WRONGRELATIONALOP,
      [NOperatorType[OperatorType]] ) {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
End;

Destructor TRelationalOp.Destroy;
Begin
  Operand1.Free;
  Operand2.Free;
  Inherited Destroy
End;

Function TParameterList.GetAsString( i: Integer ): String;
Begin
  Result := Param[i].AsString
End;

{$IFDEF LEVEL4}
function TParameterList.GetAsWideString(i: Integer): WideString;
begin
  Result := Param[i].AsWideString
end;
{$ENDIF}

Function TParameterList.GetAsFloat( i: Integer ): Double;
Begin
  Result := Param[i].AsFloat
End;

Function TParameterList.GetAsInteger( i: Integer ): Integer;
Begin
  Result := Param[i].AsInteger
End;

function TParameterList.GetAsLargeInt(i: Integer): Int64; {added by fduenas: added LargeInt (Int64) support}
begin
 Result := Param[i].AsLargeInt;
end;

Function TParameterList.GetAsBoolean( i: Integer ): Boolean;
Begin
  Result := Param[i].AsBoolean
End;

Function TParameterList.GetExprType( i: Integer ): TExprType;
Begin
  Result := Param[i].ExprType
End;

function TParameterList.GetExprTypeIndex(aExprTypeToFind: TExprType;
  aStartIndex: Integer; aCount: Integer): Integer;
var i, _end: Integer;
begin
 result := -1;
 if aCount=0 then
    _end := Count-1
 else
    _end := Min(aStartIndex+aCount-1, Count-1);

 for i :=  aStartIndex to _end do
 begin
  if Param[i].ExprType = aExprTypeToFind then
  begin
    Result := i;
    break;
  end;
 end;
end;

Function TParameterList.GetParam( i: Integer ): TExpression;
Begin
  Result := TExpression( Items[i] )
End;

constructor TParameterList.Create(aRuntimeSettings,
  aSystemSettings: TFormatSettings);
begin
 inherited Create;
 fRuntimeFormatSettings := aRuntimeSettings;
 fSystemFormatSettings := aSystemSettings;
end;

Destructor TParameterList.Destroy;
Var
  i: Integer;
Begin
  For i := 0 To ( Count - 1 ) Do
    TObject( Items[i] ).Free;
  Inherited Destroy
End;

{ TFunction }

Function TFunctionExpr.GetParam( n: Integer ): TExpression;
Begin
  Result := FParameterList.Param[n]
End;

Function TFunctionExpr.ParameterCount: Integer;
Begin
  If ( FParameterList <> Nil ) Then
    ParameterCount := FParameterList.Count
  Else
    ParameterCount := 0
End;

function TFunctionExpr.CheckParameters: Boolean;
begin
 result := true;
end;

function TFunctionExpr.CheckParameters(var aErrorCode: Integer; var aErrorMsg: TxNativeString): Boolean;
begin
 result := true;
end;

constructor TFunctionExpr.Create(aName: TxNativeString; aParameterList: TParameterList;
  aRunTimeFormatsettings, aSystemFormatsettings: TFormatSettings);
begin
 inherited Create;
 fExprName := aName;
 FParameterList := aParameterList;
 fRuntimeFormatSettings := aRuntimeFormatSettings;
 fSystemFormatSettings := aSystemFormatSettings;
end;

constructor TFunctionExpr.Create(aName: TxNativeString; aParameterList: TParameterList);
begin
 inherited Create;
 fExprName := aName;
 FParameterList := aParameterList;
 if assigned( aParameterList ) then
 begin
  fRuntimeFormatSettings := aParameterList.fRuntimeFormatSettings;
  fSystemFormatSettings := aParameterList.fSystemFormatSettings;
 end;
end;

Constructor TFunctionExpr.Create( aParameterList: TParameterList );
Begin
  Inherited Create;
  FParameterList := aParameterList;
  if assigned( aParameterList ) then
  begin
   fRuntimeFormatSettings := aParameterList.fRuntimeFormatSettings;
   fSystemFormatSettings := aParameterList.fSystemFormatSettings;
  end;
End;

Destructor TFunctionExpr.Destroy;
Begin
  if Assigned(FParameterList) then
     FParameterList.Free;
  Inherited Destroy
End;

Const
  NMF: Array[TMF] Of PChar =
  ( 'TRUNC', 'ROUND', 'ABS', 'ARCTAN', 'COS', 'EXP', 'FRAC', 'INT',
    'LN', 'PI', 'SIN', 'SQR', 'SQRT', 'POWER' );
  NSF: Array[TSF] Of PChar = ( 'UPPER', 'LOWER', 'COPY', 'POS', 'LENGTH', 'LTRIM', 'RTRIM', 'TRIM', 'CONCAT', 'CONCAT_WS', 'CHR' );

function TStringFunctionExprLib.DoChr(aCharCode: Integer): Char;
begin
 result := Char(aCharCode);
end;
function TStringFunctionExprLib.DoChrW(aCharCode: Integer): WideChar;
begin
 result := WideChar(aCharCode);
end;
{ DoCopyString Adds a Special Behaviour to Copy(str, start, count) function
  If _startPos or _count
}
function TStringFunctionExprLib.DoConcat(aSeparator: string; aGetMaxString: boolean): string;
var _string: string;
    _count, _start: integer;
begin
 _string := '';
 _start := 0;
 if aSeparator<>'' then
    Inc(_start);
 for _count  := _start to FParameterList.Count-1 do
 begin
  if _string <> '' then
     _string := _string+aSeparator;
  if aGetMaxString then
     _string := _string+Param[_count].MaxString
  else
     _string := _string+Param[_count].AsString
 end;
 result := _string;
end;
{$IFDEF LEVEL4}
function TStringFunctionExprLib.DoConcatW(aSeparator: WideString; aGetMaxString: boolean): WideString;
var _string: WideString;
    _count, _start: integer;
begin
 _string := '';
 _start := 0;
if aSeparator<>'' then
    Inc(_start);
 for _count  := _start to FParameterList.Count-1 do
 begin
  if _string <> '' then
     _string := _string+aSeparator;
  if aGetMaxString then
     _string := _string+Param[_count].MaxWideString
  else
     _string := _string+Param[_count].AsWideString
 end;
 result := _string;
end;
{$ENDIF}
Function TStringFunctionExprLib.DoCopyString(aString: string; aStartPos, aCount: Integer): String;
Begin
 if aStartPos < 0 then {if aStartPos < 0, position start from rigth to left}
     aStartPos := (Length(aString) - Abs(aStartPos))+1;
  if aCount < 0 then {if aCount < 0, copy will start from rigth to left}
  begin
   aCount := Abs(aCount);
   aStartPos := (aStartPos-aCount)+1;
  end;
  Result :=  Copy( aString, aStartPos, aCount );
End;

function TStringFunctionExprLib.DoCopyStringW(aString: WideString; aStartPos,
  aCount: Integer): WideString;
Begin
 if aStartPos < 0 then {if aStartPos < 0, position start from rigth to left}
     aStartPos := (Length(aString) - Abs(aStartPos))+1;
  if aCount < 0 then {if aCount < 0, copy will start from rigth to left}
  begin
   aCount := Abs(aCount);
   aStartPos := (aStartPos-aCount)+1;
  end;
  Result := Copy( aString, aStartPos, aCount );
End;

Function TStringFunctionExprLib.GetMaxString: String;
Begin
  CheckParameters;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    sfUpper, sfLower, sfLTrim, sfRTrim, sfTrim: Result := Param[0].MaxString;
    sfCopy:  Result := DoCopyString( Param[0].MaxString, Param[1].AsInteger, Param[2].AsInteger ); {Special Copy Function}
    sfConcat: Result := DoConcat('', true);
    sfConcatWS: result := DoConcat(Param[0].MaxString, true);
    sfChr : Result := DoChr( Param[0].asInteger );
  Else
    Result := Inherited GetAsString;
  End
End;
{$IFDEF LEVEL4}
function TStringFunctionExprLib.GetMaxWideString: WideString;
begin
  CheckParameters;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    sfUpper, sfLower, sfLTrim, sfRTrim, sfTrim: Result := Param[0].MaxWideString;
    sfCopy:  Result := DoCopyStringW( Param[0].MaxWideString, Param[1].AsInteger, Param[2].AsInteger ); {Special Copy Function}
    sfConcat: Result := DoConcatW('', true);
    sfConcatWS: result := DoConcatW(Param[0].MaxWideString, true);
    sfChr : Result := DoChrW( Param[0].asInteger );
  Else
    Result := Inherited GetAsWideString;
  End
end;
{$ENDIF}
Function TStringFunctionExprLib.GetAsString: String;
Begin
  CheckParameters;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    sfUpper: Result := XQStringUpperCase( Param[0].AsString );
    sfLower:
      Result := XQStringLowerCase( Param[0].AsString );
    sfCopy:
    begin
      if not (FParameterList.GetExprTypeIndex(ttWideString)> -1) then
         Result := DoCopyString( Param[0].AsString, Param[1].AsInteger, Param[2].AsInteger ) {patched by fduenas: Copy( Param[0].AsString, Param[1].AsInteger, Param[2].AsInteger );}
      else
         Result := DoCopyString( Param[0].AsWideString, Param[1].AsInteger, Param[2].AsInteger ); {patched by fduenas: Copy( Param[0].AsString, Param[1].AsInteger, Param[2].AsInteger );}
    end;
    sfLTrim: Result := TrimLeft( Param[0].AsString );
    sfRTrim: Result := TrimRight( Param[0].AsString );
    sfTrim: Result := Trim( Param[0].AsString );
    sfConcat: Result := DoConcat('', false);
    sfConcatWS: result := DoConcat(Param[0].AsString, false);
    sfChr : Result := DoChr( Param[0].asInteger );
  Else
    Result := Inherited GetAsString;
  End
End;
{$IFDEF LEVEL4}
function TStringFunctionExprLib.GetAsWideString: WideString;
Begin
  CheckParameters;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    sfUpper: Result := XQStringUpperCase( Param[0].AsWideString );
    sfLower:
      Result := XQStringLowerCase( Param[0].AsWideString );
    sfCopy:
      Result := DoCopyStringW( Param[0].AsWideString, Param[1].AsInteger, Param[2].AsInteger ); {patched by fduenas: Copy( Param[0].AsString, Param[1].AsInteger, Param[2].AsInteger );}
    sfLTrim: Result := TrimLeft( Param[0].AsWideString );
    sfRTrim: Result := TrimRight( Param[0].AsWideString );
    sfTrim: Result := Trim( Param[0].AsWideString );
    sfConcat: Result := DoConcatW('', false);
    sfConcatWS: Result := DoConcatW(Param[0].AsWideString, false);
    sfChr : Result := DoChrW( Param[0].asInteger );
  Else
    Result := Inherited GetAsWideString;
  End
End;
{$ENDIF}
Function TStringFunctionExprLib.GetAsInteger: Integer;
Begin
  CheckParameters;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    sfPos: Result := Pos( Param[0].AsString, Param[1].AsString ); {patched by fduenas: unicode version}
    sfLength: Result := Length( Param[0].AsString );
  Else
    Result := Inherited GetAsInteger
  End
End;

function TStringFunctionExprLib.GetAsLargeInt: Int64; {added by fduenas: added LargeInt (Int64) support}
Begin
  CheckParameters;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    sfPos: Result := Pos( Param[0].AsString, Param[1].AsString ); {patched by fduenas: unicode version}
    sfLength: Result := Length( Param[0].AsString );
  Else
    Result := Inherited GetAsLargeInt;
  End
End;

Function TStringFunctionExprLib.GetExprType: TExprType;
Begin
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    sfUpper, sfLower, sfCopy, sfLTrim, sfRTrim, sfTrim, sfConcat, sfConcatWS:
    begin
    {$IFDEF LEVEL4}
     if FParameterList.GetExprTypeIndex(ttWideString) > -1 then
        Result := ttWideString
     else
    {$ENDIF}
      Result := ttString;
    end;
   sfChr:
   begin
    {$IFDEF LEVEL4}
    if (FParameterList.Count>0) and  (FParameterList.Param[0].AsInteger > $FF) then
       Result := ttWideString    
    {$ENDIF}
    else
      Result := ttString;
   end
  Else
    Result := ttInteger;
  End
End;

function TStringFunctionExprLib.CheckParameters: Boolean;
Var
  OK: Boolean;
Begin
  OK := false;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    sfUpper, sfLower, sfLength, sfLTrim, sfRTrim, sfTrim:
      OK := ( ParameterCount = 1 ) And
        ( Param[0].ExprType >= ttString );
    sfCopy:
      OK := ( ParameterCount = 3 ) And
        ( Param[0].ExprType >= ttWideString ) And
        ( Param[1].ExprType >= ttInteger ) And
        ( Param[2].ExprType >= ttInteger );
    sfPos:
      OK := ( ParameterCount = 2 ) And
        ( Param[0].ExprType >= ttWideString ) And
        ( Param[1].ExprType >= ttString );
    sfConcat:
      OK := ( ParameterCount >= 1 );
    sfConcatWS:
      OK := ( ParameterCount >= 2 ) And
        ( Param[0].ExprType in [ttString{$IFDEF LEVEL4}, ttWideString{$ENDIF}] );
    sfChr:
      OK := ( ParameterCount = 1 ) And
        ( Param[0].ExprType in [ttInteger, ttLargeInt] )
  End;
  result := OK;
  If Not OK Then
    raise EExpression.CreateFmt( SEXPR_WRONGPARAMETER,
      [NSF[OperatorType]] ) {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
End;

Constructor TStringFunctionExprLib.Create( aName: string; aParameterList: TParameterList;
  aOperator: TSF );
Begin
  Inherited Create(aName, aParameterList );
  OperatorType := aOperator {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
End;

Function TMathFunctionExprLib.GetAsFloat: Double;
Begin
  CheckParameters;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    mfAbs: Result := Abs( Param[0].AsFloat );
    mfArcTan: Result := ArcTan( Param[0].AsFloat );
    mfCos: Result := Cos( Param[0].AsFloat );
    mfExp: Result := Exp( Param[0].AsFloat );
    mfFrac: Result := Frac( Param[0].AsFloat );
    mfInt: Result := Int( Param[0].AsFloat );
    mfLn: Result := Ln( Param[0].AsFloat );
    mfPi: Result := System.Pi;
    mfSin: Result := Sin( Param[0].AsFloat );
    mfSqr: Result := Sqr( Param[0].AsFloat );
    mfSqrt: Result := Sqrt( Param[0].AsFloat );
    mfPower: Result := Exp( Param[1].AsFloat * Ln( Param[0].AsFloat ) );
    mfTrunc: Result := Trunc(Param[0].AsFloat);  {added by fduenas}
    mfRound:
    begin
     if ParameterCount=1 then
        Result := Round( Param[0].AsFloat )
     else
        result := RoundTo(Param[0].AsFloat, abs( Param[1].AsInteger )*-1);
    end;
  Else
    Result := Inherited GetAsFloat;
  End
End;

Function TMathFunctionExprLib.GetAsInteger: Integer;
Begin
  CheckParameters;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    mfTrunc: Result := Trunc( Param[0].AsFloat );
    mfRound:
    begin
     if ParameterCount=1 then
        Result := Round( Param[0].AsFloat )
     else
        result := Trunc( RoundTo(Param[0].AsFloat, abs( Param[1].AsInteger )*-1) );
    end;
    mfAbs: Result := Abs( Param[0].AsInteger );
  Else
    Result := Inherited GetAsInteger;
  End
End;

function TMathFunctionExprLib.GetAsLargeInt: Int64; {added by fduenas: added LargeInt (Int64) support}
begin
  CheckParameters;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    mfTrunc: Result := Trunc( Param[0].AsFloat );
    mfRound:
    begin
     if ParameterCount=1 then
        Result := Round( Param[0].AsFloat )
     else
        result := Trunc( RoundTo(Param[0].AsFloat, abs( Param[1].AsInteger )*-1) );
    end;
    mfAbs: Result := Abs( Param[0].AsLargeInt );
  Else
    Result := Inherited GetAsLargeInt;
  End
end;

function TMathFunctionExprLib.CheckParameters: Boolean;
Var
  OK: Boolean;
Begin
  OK := True;
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    mfTrunc, mfArcTan, mfCos, mfExp, mfFrac, mfInt,
      mfLn, mfSin, mfSqr, mfSqrt, mfAbs:
      Begin
        OK := ( ParameterCount = 1 ) And
          ( Param[0].ExprType >= ttFloat );
      End;
    mfRound:
      begin
       OK := ( ( ParameterCount = 1 ) or
               ((ParameterCount = 2) and (Param[1].ExprType = ttInteger)) ) and
             ( Param[0].ExprType >= ttFloat );
      end;
    mfPower:
      Begin
        OK := ( ParameterCount = 2 ) And
          ( Param[0].ExprType >= ttFloat ) And
          ( Param[1].ExprType >= ttFloat );
      End;
  End;
  result := OK;
  If Not OK Then
    Raise EExpression.CreateFmt( SEXPR_INVALIDPARAMETERTO, [NMF[OperatorType]] ) {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
End;

Function TMathFunctionExprLib.GetExprType: TExprType;
Begin
  Case OperatorType Of {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
    mfTrunc:
    begin
     if Param[0].ExprType in [ttLargeInt, ttFloat] then  {added by fduenas: added LargeInt (Int64) support}
        Result := ttFloat
     else
        Result := ttInteger;
    end;
    mfRound:
    begin
     if (Param[0].ExprType in [ttLargeInt, ttFloat]) or (ParamCount=2) then  {added by fduenas: added LargeInt (Int64) support}
        Result := ttFloat
     else
        Result := ttInteger;
    end
  Else
    Result := ttFloat;
  End
End;

Constructor TMathFunctionExprLib.Create( aName: string; aParameterList: TParameterList;
  aOperator: TMF );
Begin
  Inherited Create( aName, aParameterList );
  OperatorType := aOperator {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
End;

function TTypeCastExpr.GetMaxString: String;
begin
  Result := Param[0].GetMaxString
end;
{$IFDEF LEVEL4}
function TTypeCastExpr.GetMaxWideString: WideString;
begin
 Result := Param[0].GetMaxWideString
end;
{$ENDIF}
Function TTypeCastExpr.GetAsString: String;
Begin
  Result := Param[0].AsString
End;
{$IFDEF LEVEL4}
function TTypeCastExpr.GetAsWideString: WideString;
begin
 Result := Param[0].AsWideString
end;
{$ENDIF}
Function TTypeCastExpr.GetAsFloat: Double;
Begin
  If Param[0].ExprType = ttString Then
    Result := StrToFloat( Param[0].AsString{$IFDEF Delphi7Up}, fSystemFormatSettings{$ENDIF} )
 {$IFDEF LEVEL4}
  Else If Param[0].ExprType = ttWideString Then
    Result := StrToFloat( Param[0].AsWideString{$IFDEF Delphi7Up}, fSystemFormatSettings{$ENDIF} )
 {$ENDIF}
  Else
    Result := Param[0].AsFloat
End;

Function TTypeCastExpr.GetAsInteger: Integer;
Begin
  If Param[0].ExprType = ttString Then
    Result := StrToInt( Param[0].AsString )
 {$IFDEF LEVEL4}
  Else If Param[0].ExprType = ttWideString Then
    Result := StrToInt( Param[0].AsWideString )
 {$ENDIF}
  Else If Param[0].ExprType = ttFloat Then
    Result := Trunc( Param[0].AsFloat )
  Else
    Result := Param[0].AsInteger
End;

function TTypeCastExpr.GetAsLargeInt: Int64; {added by fduenas: added LargeInt (Int64) support}
Begin
  If Param[0].ExprType = ttString Then
    Result := StrToInt64( Param[0].AsString )
 {$IFDEF LEVEL4}
  Else If Param[0].ExprType = ttWideString Then
    Result := StrToInt64( Param[0].AsWideString )
 {$ENDIF}
  Else If Param[0].ExprType = ttFloat Then
    Result := Trunc( Param[0].AsFloat )
  Else
    Result := Param[0].AsLargeInt;
end;

Function TTypeCastExpr.GetAsBoolean: Boolean;
Begin
  Result := Param[0].AsBoolean
End;

Function TTypeCastExpr.GetExprType: TExprType;
Begin
  Result := OperatorType {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
End;

Constructor TTypeCastExpr.Create( aParameterList: TParameterList;
  aOperator: TExprType );
Begin
  Inherited Create('CAST', aParameterList );
  OperatorType := aOperator {patched by fduenas: Renamed from 'Operator' to OperatorType to prevent excepetion with IDE Editor }
End;

Function TConditionalExpr.Rex: TExpression;
Begin
  CheckParameters;
  If Param[0].AsBoolean Then
    Result := Param[1]
  Else
    Result := Param[2]
End;

function TConditionalExpr.CheckParameters: Boolean;
Begin
 result := ( ( ParameterCount = 3 ) And
    ( Param[0].ExprType = ttBoolean ) );
  If Not result Then
    Raise EExpression.Create( 'IF: Invalid parameters' )
End;

Function TConditionalExpr.GetMaxString: String;
Begin
  If Length( Param[1].AsString ) > Length( Param[2].AsString ) Then
    Result := Param[1].AsString
  Else
    Result := Param[2].AsString;
End;

{$IFDEF LEVEL4}
function TConditionalExpr.GetMaxWideString: WideString;
Begin
  If Length( Param[1].AsWideString ) > Length( Param[2].AsWideString ) Then
    Result := Param[1].AsWideString
  Else
    Result := Param[2].AsWideString;
End;
{$ENDIF}

Function TConditionalExpr.GetAsString: String;
Begin
  Result := Rex.AsString;
End;
{$IFDEF LEVEL4}
function TConditionalExpr.GetAsWideString: WideString;
begin
  Result := Rex.AsWideString;
end;
{$ENDIF}
Function TConditionalExpr.GetAsFloat: Double;
Begin
  Result := Rex.AsFloat
End;

Function TConditionalExpr.GetAsInteger: Integer;
Begin
  Result := Rex.AsInteger
End;

function TConditionalExpr.GetAsLargeInt: Int64;
begin
 result := Rex.AsLargeInt;
end;

constructor TConditionalExpr.Create(aParameterList: TParameterList);
begin
 inherited Create('IF', aParameterList);
end;

Function TConditionalExpr.GetAsBoolean: Boolean;
Begin
  Result := Rex.AsBoolean
End;

Function TConditionalExpr.GetExprType: TExprType;
Begin
  Result := Rex.ExprType
End;

{TASCIIExpr}

Constructor TASCIIExpr.Create( aName: TxNativeString; ParameterList: TParameterList );
Begin
  Inherited Create( aName, ParameterList );
  If ( ParameterList.Count <> 1 ) Or ( not (ParameterList.ExprType[0] in [ttString{$IFDEF LEVEL4}, ttWideString{$ENDIF}]) ) Then
    Raise EExpression.Create( ExprName+': Incorrect argument' );
End;

Function TASCIIExpr.GetAsInteger: Integer;
Begin
  If Length( Param[0].AsString ) = 0 Then
    Result := 0
  Else
    Result := Ord( Param[0].AsString[1] );
End;

function TASCIIExpr.GetAsLargeInt: Int64;
Begin
  If Length( Param[0].AsString ) = 0 Then
    Result := 0
  Else
    Result := Ord( Param[0].AsString[1] );
End;

Function TASCIIExpr.GetExprType: TExprType;
Begin
  result := ttInteger;
End;

{ TLeftExpr }

constructor TLeftExpr.Create(aName: TxNativeString; ParameterList: TParameterList); {patched by fduenas: added constructor to validate input parameters}
begin
 Inherited Create( aName, ParameterList );
 If ( ParameterList.Count <> 2 ) Then
    Raise EExpression.Create(ExprName+': Incorrect Number of arguments' );
 If ( ParameterList.ExprType[1] <> ttInteger ) and
    ( ParameterList.ExprType[1] <> ttFloat ) then
    Raise EExpression.Create( ExprName+': Incorrect argument[2] type. Must be of type number' );
end;

Function TLeftExpr.GetMaxString: String;
Begin
  Result := Copy( Param[0].GetMaxString, 1, Param[1].AsInteger );
End;
{$IFDEF LEVEL4}
function TLeftExpr.GetMaxWideString: WideString;
begin
 Result := Copy( Param[0].GetMaxWideString, 1, Param[1].AsInteger );
end;
{$ENDIF}
Function TLeftExpr.GetAsString: String;
Begin
  Result := Copy( Param[0].AsString, 1, Param[1].AsInteger );
End;
{$IFDEF LEVEL4}
function TLeftExpr.GetAsWideString: WideString;
begin
 Result := Copy( Param[0].AsWideString, 1, Param[1].AsInteger );
end;
{$ENDIF}
Function TLeftExpr.GetExprType: TExprType;
Begin
 {$IFDEF LEVEL4}
  if Param[0].ExprType=ttWideString then
     Result := ttWideString
  else
 {$ENDIF}
     Result := ttString;
End;

Function imax( a, b: integer ): integer;
Begin
  If a > b Then
    result := a
  Else
    result := b;
End;

Function imin( a, b: integer ): integer;
Begin
  If a < b Then
    result := a
  Else
    result := b;
End;

{ TRightExpr }

constructor TRightExpr.Create(aName: TxNativeString; ParameterList: TParameterList); {patched by fduenas: added constructor to validate input parameters}
begin
 Inherited Create( aName, ParameterList );
 If ( ParameterList.Count <> 2 ) Then
    Raise EExpression.Create( ExprName+': Incorrect Number of arguments' );
 If ( ParameterList.ExprType[1] <> ttInteger ) and
    ( ParameterList.ExprType[1] <> ttFloat ) then
    Raise EExpression.Create( ExprName+': Incorrect argument[2] type. Must be of type number' );
end;

Function TRightExpr.GetMaxString: String;
Var
  p: Integer;
Begin
  p := IMax( 1, Length( Param[0].GetMaxString ) - Param[1].AsInteger + 1 );
  Result := Copy( Param[0].GetMaxString, p, Param[1].AsInteger );
End;
{$IFDEF LEVEL4}
function TRightExpr.GetMaxWideString: WideString;
Var
  p: Integer;
Begin
  p := IMax( 1, Length( Param[0].GetMaxWideString ) - Param[1].AsInteger + 1 );
  Result := Copy( Param[0].GetMaxWideString, p, Param[1].AsInteger );
End;
{$ENDIF}
Function TRightExpr.GetAsString: String;
Var
  p: Integer;
Begin
  p := IMax( 1, Length( Param[0].AsString ) - Param[1].AsInteger + 1 );
  Result := Copy( Param[0].AsString, p, Param[1].AsInteger );
End;
{$IFDEF LEVEL4}
function TRightExpr.GetAsWideString: WideString;
Var
  p: Integer;
Begin
  p := IMax( 1, Length( Param[0].AsWideString ) - Param[1].AsInteger + 1 );
  Result := Copy( Param[0].AsWideString, p, Param[1].AsInteger );
End;
{$ENDIF}
Function TRightExpr.GetExprType: TExprType;
Begin
 {$IFDEF LEVEL4}
  if Param[0].ExprType=ttWideString then
     Result := ttWideString
  else
 {$ENDIF}
     Result := ttString;
End;

{ TLikeList implementaton}

Constructor TLikeList.Create;
Begin
  Inherited Create;
  fItems := TList.Create;
End;

Destructor TLikeList.Destroy;
Begin
  Clear;
  fItems.Free;
  Inherited Destroy;
End;

Function TLikeList.GetCount;
Begin
  Result := fItems.Count;
End;

Function TLikeList.GetItem( Index: Integer ): TLikeItem;
Begin
  Result := fItems[Index];
End;

Function TLikeList.Add: TLikeItem;
Begin
  Result := TLikeItem.Create;
  fItems.Add( Result );
End;

Procedure TLikeList.Clear;
Var
  I: Integer;
Begin
  For I := 0 To fItems.Count - 1 Do
    TLikeItem( fItems[I] ).Free;
  fItems.Clear;
End;

Procedure TLikeList.Delete( Index: Integer );
Begin
  TLikeItem( fItems[Index] ).Free;
  fItems.Delete( Index );
End;

{ TSQLLikeExpr implementation }

Constructor TSQLLikeExpr.Create( ParameterList: TParameterList; IsNotLike: Boolean );
Var
  s, Work: String;
  p, n: Integer;
  Previous: Char;
  EscapeChar: Char;
  Accept: Boolean;
  Found, FoundPerc: Boolean;
Begin
  Inherited Create( 'LIKE', ParameterList );
  LIKEList := TLikeList.Create;
  FIsNotLike := IsNotLike;
  If ( ParameterCount > 2 ) And ( Length( Param[2].AsString ) > 0 ) Then
    EscapeChar := Param[2].AsString[1]
  Else
    EscapeChar := #0;

  s := Param[1].AsString;
  If ( Length( s ) = 0 ) Or ( ( Pos( '%', s ) = 0 ) And ( Pos( '_', s ) = 0 ) ) Then
  Begin
    With LikeList.Add Do
    Begin
      LikeText := s;
      LikePos := lpNone;
    End;
  End
  Else
  Begin
    // verifica si solo son "_"
    Found:=false;
    FoundPerc:=false;
    for p:= 1 to Length(s) do
    begin
      if s[p]='%' then
      begin
        FoundPerc:=true;
        break;
      end;
      if s[p]='_' then
      begin
        Found:=true;
      end;
    end;
    if Found and not FoundPerc then
    begin
      With LikeList.Add Do
      Begin
        LikeText := s;
        LikePos := lpLeft;
        LikeCode := lcOnlyUnderscores;
      End;
      exit;
    end;
    work := '';
    p := 1;
    n := 0;
    Previous := #0;
    While p <= Length( s ) Do
    Begin
      Accept := ( ( s[p] = '%' ) And ( EscapeChar = #0 ) ) Or
        ( ( s[p] = '%' ) And ( Previous <> EscapeChar ) ) Or
        ( ( s[p] = '_' ) And ( Previous <> EscapeChar ) );
      If Accept Then
      Begin
        If ( Length( Work ) > 0 ) Then
        Begin
          If (n = 0) and (p = Length(s)) Then   { patched by ccy }
          Begin
            // text must start with Work
            With LikeList.Add Do
            Begin
              LikeText := Work;
              LikePos := lpLeft;
              If s[p] = '_' Then
                LikeCode := lcSingle
              Else
                LikeCode := lcMultiple
            End;
          End
          Else
          Begin
            // el texto debe tener en medio work
            (*With LikeList.Add Do //
            Begin
              LikeText := Work;
              LikePos := lpMiddle;
              If s[p] = '_' Then
                LikeCode := lcSingle
              Else
                LikeCode := lcMultiple
            End; *)
            with LikeList.Add Do begin
              LikePos := lpMiddle;
              if s[p] = '_' then begin
                LikeCode := lcSingle;
                LikeText := s;
              end else begin
                LikeText := Work;
                LikeCode := lcMultiple;
              end;
            end;
          End;
        End;
        work :=  '';
        inc( n );
        if s[p] = '_' then Break; { patched by ccy }
      End
      Else
      Begin
        If ( EscapeChar = #0 ) Or Not ( s[p] = EscapeChar ) Then
          work := work + s[p];
      End;
      Previous := s[p];

      Inc( p );
    End;
    If Length( work ) > 0 Then
    Begin
      { texto deber terminar en Work }
      With LikeList.Add Do
      Begin
        LikePos := lpRight;
        LikeText := Work;
        If s[1] = '_' Then           { patched by ccy }
          LikeCode := lcSingle       { patched by ccy }
        else                         { patched by ccy }
          LikeCode := lcMultiple     { patched by ccy }
      End;
    End;
  End;
End;

constructor TSQLLikeExpr.Create(aName: String; ParameterList: TParameterList; IsNotLike: Boolean);
begin
 Create( ParameterList, IsNotLike );
 fExprName := aName;
end;

Destructor TSQLLikeExpr.Destroy;
Begin
  LIKEList.Free;
  Inherited Destroy;
End;

Function TSQLLikeExpr.SQLPos( Var Start: Integer; Const Substr, Str: String ): Integer;
Var
  I, Pivot, NumValid, L1, L2: Integer;
  Accept: Boolean;
Begin
  Result := Low( Integer );
  L1 := Length( Str );
  L2 := Length( Substr );
  If ( L1 = 0 ) Or ( L2 = 0 ) Or ( L2 > L1 ) Then Exit;
  If ( Start = 1 ) And ( Pos( '_', Substr ) = 0 ) Then
  Begin
    Result := Pos( Substr, Str ); // speed up result
    If Result > 0 Then
      Inc( Start, Length( Substr ) );
  End Else
  Begin
    For I := Start To L1 Do
    Begin
      NumValid := 0;
      Pivot := 1;
      Accept := true;
      While Accept And ( I + Pivot - 1 <= L1 ) And ( Pivot <= L2 ) And
        ( ( Substr[Pivot] = '_' ) Or ( Str[I + Pivot - 1] = Substr[Pivot] ) ) Do
      Begin
        Inc( NumValid );
        Inc( Pivot );
      End;
      If NumValid = L2 Then
      Begin
        Inc( Start, Length( Substr ) );
        Result := I;
        Exit;
      End;
    End;
  End;
  If Result = 0 Then
    Result := Low( Integer );
End;

Procedure TSQLLikeExpr.AddToList( Like: TLikeItem );
Begin
  With LikeList.Add Do
  Begin
    LikePos := Like.LikePos;
    LikeCode := Like.LikeCode;
    LikeText := Like.LikeText;
  End;
End;

Function TSQLLikeExpr.GetAsBoolean: Boolean;
Var
  I, n, Start, p: Integer;
  Like: TLikeItem;
  s0, s1: String;
  Accept: Boolean;
Begin
  s0 := Param[0].AsString;
  Start := 1;
  if LIKEList.Count=1 then
  begin
    Like := LIKEList[0];
    if Like.LikeCode=lcOnlyUnderscores then
    begin
      s1 := Like.LikeText;
      Accept := ( SQLPos( Start, s1, s0 ) = 1 );
      If Accept And ( Length( s1 ) <> Length( s0 ) ) Then
        Accept := false;
      Result := Accept;
      If FIsNotLike Then
        Result := Not Result;
      exit;
    end;
  end;

  n := 0;
  Accept := False;
  For I := 0 To LIKEList.Count - 1 Do
  Begin
    Like := LIKEList[I];
    s1 := Like.LikeText;
    Case Like.LikePos Of
      lpNone: Accept := ( s0 = s1 );
      lpLeft:
        Begin
          Start := 1;
          If Like.LikeCode = lcSingle Then
            s1 := s1 + '_';
          Accept := ( SQLPos( Start, s1, s0 ) = 1 );
          If Accept And ( Like.LikeCode = lcSingle ) And
            ( Length( s1 ) <> Length( s0 ) ) Then
            Accept := false;
        End;
      lpMiddle:
        Accept := ( SQLPos( Start, s1, s0 ) > 0 );
      lpRight:
        Begin
          p := Length( s0 ) - Length( s1 ) + 1;
          If Start <= p Then
          Begin
            Start := p;
            //If Like.LikeCode = lcSingle Then   { patched by ccy }    {uncommented by fduenas: why was commented}
            //   s1 := '_' + s1;                  { patched by ccy } {uncommented by fduenas: why was commented}
            Accept := ( SQLPos( Start, s1, s0 ) = p );
            If Accept And ( Like.LikeCode = lcSingle ) And
              ( Length( s1 ) <> Length( s0 ) ) Then
              Accept := false;
          End
          Else
            Accept := False;
        End;
    End;
    If Accept Then
      Inc( n );
  End;
  Result := ( n = LIKEList.Count );
  If FIsNotLike Then
    Result := Not Result;
End;

function TSQLLikeExpr.GetExprType: TExprtype;
Begin
  Result := ttBoolean;
End;

{ TBetweenExpr }

Constructor TBetweenExpr.Create( ParameterList: TParameterList; IsNotBetween: Boolean );
Begin
  Inherited Create( ParameterList );
  FIsNotBetween := IsNotBetween;
End;

Function TBetweenExpr.GetAsBoolean: Boolean;
Var
  s: String;
  f: Double;
  i: Integer;
  li: Int64;
  b: Boolean;
Begin
  Result := False;
  { We'll compare expressions like
      CustNo BETWEEN 10 AND 30
  }
  Case Param[0].Exprtype Of
    ttString:
      Begin
        s := Param[0].AsString;
        result := ( s >= Param[1].AsString ) And ( s <= Param[2].AsString );
      End;
   {$IFDEF LEVEL4}
    ttWideString:
      Begin
        s := Param[0].AsWideString;
        result := ( s >= Param[1].AsWideString ) And ( s <= Param[2].AsWideString );
      End;
   {$ENDIF}
    ttFloat:
      Begin
        f := Param[0].AsFloat;
        result := ( f >= Param[1].AsFloat ) And ( f <= Param[2].AsFloat );
      End;
    ttInteger:
      Begin
        i := Param[0].AsInteger;
        result := ( i >= Param[1].AsInteger ) And ( i <= Param[2].AsInteger );
      End;
    ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
      Begin
        li := Param[0].AsLargeInt;
        result := ( li >= Param[1].AsLargeInt ) And ( li <= Param[2].AsLargeInt );
      End;
    ttBoolean:
      Begin
        b := Param[0].AsBoolean;
        result := ( b >= Param[1].AsBoolean ) And ( b <= Param[2].AsBoolean );
      End;
  End;
  If FIsNotBetween Then
    Result := Not Result;
End;

function TBetweenExpr.GetExprType: TExprtype;
Begin
  Result := ttBoolean;
End;

{ TSQLInPredicateExpr - class implementation}

Constructor TSQLInPredicateExpr.Create( ParameterList: TParameterList; IsNotIn: Boolean );
Begin
  Inherited Create( ParameterList );
  FIsNotIn := IsNotIn;
End;

Function TSQLInPredicateExpr.GetAsBoolean: Boolean;
Var
  t: Integer;
  s: String;
 {$IFDEF LEVEL4}
  ws: WideString;
 {$ENDIF}
  f: Double;
  i: integer;
  li: Integer; {added by fduenas: added LargeInt (Int64) support}
  b: Boolean;
Begin
  Result := False;
  { We'll compare expressions like :
      COUNTRY IN ('USA','SPAIN','MEXICO','ENGLAND')
      CUSTID not IN (1,10,25)
      ISMARRIED IN (TRUE)
      Combination of parameters like:
      CUSTID IN ('USA', 2, 'MEXICO', 2.54)
      where CUSTID is integer, is invalid
  }
  Case Param[0].Exprtype Of
    ttString:
      Begin
        s := Param[0].AsString;
        For t := 1 To ParameterCount - 1 Do
          If s = Param[t].AsString Then
          Begin
            Result := True;
            Break;
          End;
      End;
   {$IFDEF LEVEL4}
    ttWideString:
      Begin
        ws := Param[0].AsWideString;
        For t := 1 To ParameterCount - 1 Do
          If ws = Param[t].AsWideString Then
          Begin
            Result := True;
            Break;
          End;
      End;
   {$ENDIF}
    ttFloat:
      Begin
        f := Param[0].AsFloat;
        For t := 1 To ParameterCount - 1 Do
          If f = Param[t].AsFloat Then
          Begin
            Result := True;
            Break;
          End;
      End;
    ttInteger:
      Begin
        i := Param[0].AsInteger;
        For t := 1 To ParameterCount - 1 Do
          If i = Param[t].AsInteger Then
          Begin
            Result := True;
            Break;
          End;
      End;
    ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
      Begin
        li := Param[0].AsLargeInt;
        For t := 1 To ParameterCount - 1 Do
          If li = Param[t].AsLargeInt Then
          Begin
            Result := True;
            Break;
          End;
      End;
    ttBoolean:
      Begin
        b := Param[0].AsBoolean;
        For t := 1 To ParameterCount - 1 Do
          If b = Param[t].AsBoolean Then
          Begin
            Result := True;
            Break;
          End;
      End;
  End;
  If FIsNotIn Then
    Result := Not Result;
End;

function TSQLInPredicateExpr.GetExprType: TExprtype;
Begin
  Result := ttBoolean;
End;

{ TCaseWhenElseExpr }

Constructor TCaseWhenElseExpr.Create( WhenParamList: TParameterList;
  ThenParamList: TParameterList; ElseExpr: TExpression );
Begin
  Inherited Create( WhenParamList );
  FThenParamList := ThenParamList;
  FElseExpr := ElseExpr;
End;

function TCaseWhenElseExpr.CheckParameters: Boolean;
Var
  I: Integer;
Begin
  { check that WHEN expression be of type boolean}
  result := true;
  For I := 0 To ParameterCount - 1 Do
  Begin
    If (Param[I].ExprType <> ttBoolean) Then
      Raise EExpression.Create( SEXPR_WRONGWHENEXPR );
  End;
  { check that all expression in THEN be of same type }
  For I := 1 To FThenParamList.Count - 1 Do
  Begin
    If Not FThenParamList.Param[I].CanReadAs( FThenParamList.Param[0].ExprType ) Then
      Raise EExpression.Create( SEXPR_WRONGTHENEXPR );
  End;
  If ( FElseExpr <> Nil ) And Not FElseExpr.CanReadAs( FThenParamList.Param[0].ExprType ) Then
    Raise EExpression.Create( SEXPR_WRONGTHENEXPR );
End;

Destructor TCaseWhenElseExpr.Destroy;
Begin
  FThenParamList.Free;
  If FElseExpr <> Nil Then
    FElseExpr.Free;
  Inherited Destroy;
End;

Function TCaseWhenElseExpr.GetAsBoolean: Boolean;
Var
  I: Integer;
Begin
  CheckParameters;
  Result := FALSE;
  For I := 0 To ParameterCount Do
    If Param[I].AsBoolean Then
    Begin
      Result := FThenParamList.AsBoolean[I];
      Exit;
    End;
  If FElseExpr <> Nil Then
    Result := FElseExpr.AsBoolean;
End;

Function TCaseWhenElseExpr.GetAsFloat: Double;
Var
  I: Integer;
Begin
  CheckParameters;
  Result := 0;
  For I := 0 To ParameterCount - 1 Do
    If Param[I].AsBoolean Then
    Begin
      Result := FThenParamList.AsFloat[I];
      Exit;
    End;
  If FElseExpr <> Nil Then
    Result := FElseExpr.AsFloat;
End;

Function TCaseWhenElseExpr.GetAsInteger: Integer;
Var
  I: Integer;
Begin
  CheckParameters;
  Result := 0;
  For I := 0 To ParameterCount Do
    If Param[I].AsBoolean Then
    Begin
      Result := FThenParamList.AsInteger[I];
      Exit;
    End;
  If FElseExpr <> Nil Then
    Result := FElseExpr.AsInteger;
End;

function TCaseWhenElseExpr.GetAsLargeInt: Int64; {added by fduenas: added LargeInt (Int64) support}
Var
  I: Integer;
Begin
  CheckParameters;
  Result := 0;
  For I := 0 To ParameterCount Do
    If Param[I].AsBoolean Then
    Begin
      Result := FThenParamList.AsLargeInt[I];
      Exit;
    End;
  If FElseExpr <> Nil Then
    Result := FElseExpr.AsLargeInt;
End;

Function TCaseWhenElseExpr.GetMaxString: String;
var
  I: Integer;
Begin
  Result:= '';
  if not (GetExprType in [ttString{$IFDEF LEVEL4}, ttWideString{$ENDIF}]) then Exit;
  For I := 0 To ParameterCount - 1 Do
    if Length( FThenParamList.AsString[I] ) > Length( Result ) then
      Result:= FThenParamList.AsString[I];
  If ( FElseExpr <> Nil ) And ( Length( FElseExpr.AsString ) > Length( Result ) ) then
    Result := FElseExpr.AsString;
End;
{$IFDEF LEVEL4}
function TCaseWhenElseExpr.GetMaxWideString: WideString;
var
  I: Integer;
Begin
  Result:= '';
  if not (GetExprType in [ttString, ttWideString]) then Exit;
  For I := 0 To ParameterCount - 1 Do
    if Length( FThenParamList.AsWideString[I] ) > Length( Result ) then
      Result:= FThenParamList.AsWideString[I];
  If ( FElseExpr <> Nil ) And ( Length( FElseExpr.AsWideString ) > Length( Result ) ) then
    Result := FElseExpr.AsWideString;
End;
{$ENDIF}
Function TCaseWhenElseExpr.GetAsString: String;
Var
  I: Integer;
Begin
  CheckParameters;
  Result := '';
  For I := 0 To ParameterCount - 1 Do
    If Param[I].AsBoolean Then
    Begin
      Result := FThenParamList.AsString[I];
      Exit;
    End;
  If FElseExpr <> Nil Then
    Result := FElseExpr.AsString;
End;
{$IFDEF LEVEL4}
function TCaseWhenElseExpr.GetAsWideString: WideString;
Var
  I: Integer;
Begin
  CheckParameters;
  Result := '';
  For I := 0 To ParameterCount - 1 Do
    If Param[I].AsBoolean Then
    Begin
      Result := FThenParamList.AsWideString[I];
      Exit;
    End;
  If FElseExpr <> Nil Then
    Result := FElseExpr.AsWideString;
End;
{$ENDIF}
function TCaseWhenElseExpr.GetExprType: TExprtype;
Begin
  { the expression type is the type of the first expression }
  Result := FThenParamList.ExprType[0];
End;

{TFormatDateTimeExpr - class implementation}
Function TFormatDateTimeExpr.GetMaxString: String;
Begin
  Result := FormatDateTime( Param[0].GetMaxString, Param[1].AsFloat{$IFDEF Delphi7Up},fSystemFormatSettings{$ENDIF} );
End;

Function TFormatDateTimeExpr.GetAsString: String;
Begin
  Result := FormatDateTime( Param[0].AsString, Param[1].AsFloat{$IFDEF Delphi7Up},fSystemFormatSettings{$ENDIF} );
End;

Function TFormatDateTimeExpr.GetExprType: TExprType;
Begin
  Result := ttString;
End;

{TFormatFloatExpr - class implementation
 FORMATFLOAT('###,###,##0.00', 32767)}

Function TFormatFloatExpr.GetMaxString: String;
Begin
  Result := FormatFloat( Param[0].GetMaxString, Param[1].AsFloat{$IFDEF Delphi7Up},fSystemFormatSettings{$ENDIF} );
End;

Function TFormatFloatExpr.GetAsString: String;
Begin
  Result := FormatFloat( Param[0].AsString, Param[1].AsFloat{$IFDEF Delphi7Up},fSystemFormatSettings{$ENDIF} );
End;

Function TFormatFloatExpr.GetExprType: TExprType;
Begin
  Result := ttString;
End;

{ TFormatExpr - class implementation
  Format('%d %s ...', 1234, 'ABC', ..., etc) }
Function TFormatExpr.GetMaxString: String;
Const
  MAXARGS = 20; {maximum number of arguments allowed (increase if needed)}
Var
  cnt, n: integer;
  ss: Array[0..MAXARGS] Of String;
 {$IFDEF LEVEL4}
  ws: Array[0..MAXARGS] Of WideString;
 {$ENDIF}
  ea: Array[0..MAXARGS] Of Extended;
  Vars: Array[0..MAXARGS] Of TVarRec;
  //Args: Array[0..1] Of TVarRec = ('hello');
Begin
  n := imin( ParameterCount - 1, MAXARGS );
  { first parameter is the format string and the rest are the args}
  For cnt := 1 To n Do
  Begin
    Case Param[cnt].ExprType Of
      ttString:
        Begin
          Vars[cnt - 1].VType := {$if RtlVersion <= 18.5} vtString {$else} vtPWideChar {$ifend} ; {patched by fduenas for Unicode enabling}
          ss[cnt - 1] := Param[cnt].GetMaxString; {patched by fduenas changed frpm AsString to GetMaxString to prevent data truncation}
          {$if RtlVersion <= 18.5}
           Vars[cnt - 1].VString := @ss[cnt - 1]; {patched by fduenas for Unicode enabling}
          {$else}
           Vars[cnt - 1].VPWideChar := PWideChar( ss[cnt - 1] ); {patched by fduenas for Unicode enabling}
          {$ifend}
        End;
     {$IFDEF LEVEL4}
      ttWideString:
        Begin
          Vars[cnt - 1].VType := {$if RtlVersion <= 18.5} vtString {$else} vtPWideChar {$ifend} ; {patched by fduenas for Unicode enabling}
          ws[cnt - 1] := Param[cnt].GetMaxWideString; {patched by fduenas changed frpm AsString to GetMaxString to prevent data truncation}
          {$if RtlVersion <= 18.5}
           Vars[cnt - 1].VString := @ws[cnt - 1]; {patched by fduenas for Unicode enabling}
          {$else}
           Vars[cnt - 1].VPWideChar := PWideChar( ws[cnt - 1] ); {patched by fduenas for Unicode enabling}
          {$ifend}
        End;
     {$ENDIF}
      ttFloat:
        Begin
          Vars[cnt - 1].VType := vtExtended;
          ea[cnt - 1] := Param[cnt].AsFloat;
          Vars[cnt - 1].VExtended := @ea[cnt - 1];
        End;
      ttInteger:
        Begin
          Vars[cnt - 1].VType := vtInteger;
          Vars[cnt - 1].VInteger := Param[cnt].AsInteger;
        End;
      ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
        Begin
          Vars[cnt - 1].VType := vtInt64;
          ea[cnt - 1] := Param[cnt].AsLargeInt;
          Vars[cnt - 1].VInt64 := @ea[cnt - 1];
        End;
      ttBoolean:
        Begin
          Vars[cnt - 1].VType := vtBoolean;
          Vars[cnt - 1].VBoolean := Param[cnt].AsBoolean;
        End;
    End;
  End;
  result :=  Format( Param[0].AsString,  Vars{$IFDEF Delphi7Up}, fSystemFormatSettings {$ENDIF});
End;
{$IFDEF LEVEL4}
function TFormatExpr.GetMaxWideString: WideString;
Const
  MAXARGS = 20; {maximum number of arguments allowed (increase if needed)}
Var
  cnt, n: integer;
  ss: Array[0..MAXARGS] Of String;
  ws: Array[0..MAXARGS] Of WideString;
  ea: Array[0..MAXARGS] Of Extended;
  Vars: Array[0..MAXARGS] Of TVarRec;
  //Args: Array[0..1] Of TVarRec = ('hello');
Begin
  n := imin( ParameterCount - 1, MAXARGS );
  { first parameter is the format string and the rest are the args}
  For cnt := 1 To n Do
  Begin
    Case Param[cnt].ExprType Of
      ttString:
        Begin
          Vars[cnt - 1].VType := {$if RtlVersion <= 18.5} vtString {$else} vtPWideChar {$ifend} ; {patched by fduenas for Unicode enabling}
          ss[cnt - 1] := Param[cnt].GetMaxString; {patched by fduenas changed frpm AsString to GetMaxString to prevent data truncation}
          {$if RtlVersion <= 18.5}
           Vars[cnt - 1].VString := @ss[cnt - 1]; {patched by fduenas for Unicode enabling}
          {$else}
           Vars[cnt - 1].VPWideChar := PWideChar( ss[cnt - 1] ); {patched by fduenas for Unicode enabling}
          {$ifend}
        End;
      ttWideString:
        Begin
          Vars[cnt - 1].VType := {$if RtlVersion <= 18.5} vtString {$else} vtPWideChar {$ifend} ; {patched by fduenas for Unicode enabling}
          ws[cnt - 1] := Param[cnt].GetMaxWideString; {patched by fduenas changed frpm AsString to GetMaxString to prevent data truncation}
          {$if RtlVersion <= 18.5}
           Vars[cnt - 1].VString := @ws[cnt - 1]; {patched by fduenas for Unicode enabling}
          {$else}
           Vars[cnt - 1].VPWideChar := PWideChar( ws[cnt - 1] ); {patched by fduenas for Unicode enabling}
          {$ifend}
        End;
      ttFloat:
        Begin
          Vars[cnt - 1].VType := vtExtended;
          ea[cnt - 1] := Param[cnt].AsFloat;
          Vars[cnt - 1].VExtended := @ea[cnt - 1];
        End;
      ttInteger:
        Begin
          Vars[cnt - 1].VType := vtInteger;
          Vars[cnt - 1].VInteger := Param[cnt].AsInteger;
        End;
      ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
        Begin
          Vars[cnt - 1].VType := vtInt64;
          ea[cnt - 1] := Param[cnt].AsLargeInt;
          Vars[cnt - 1].VInt64 := @ea[cnt - 1];
        End;
      ttBoolean:
        Begin
          Vars[cnt - 1].VType := vtBoolean;
          Vars[cnt - 1].VBoolean := Param[cnt].AsBoolean;
        End;
    End;
  End;
  result :=  WideFormat( Param[0].AsWideString,  Vars{$IFDEF Delphi7Up}, fSystemFormatSettings {$ENDIF} );
End;
{$ENDIF}
Function TFormatExpr.GetAsString: String;
Const
  MAXARGS = 20; {maximum number of arguments allowed (increase if needed)}
Var
  cnt, n: integer;
  ss: Array[0..MAXARGS] Of String;
 {$IFDEF LEVEL4}
  ws: Array[0..MAXARGS] Of WideString;
 {$ENDIF}
  ea: Array[0..MAXARGS] Of Extended;
  Vars: Array[0..MAXARGS] Of TVarRec;
 {$IFNDEF Delphi7Up}
  SFS: TFormatSettings;
 {$ENDIF}
Begin
  n := imin( ParameterCount - 1, MAXARGS );
  { first parameter is the format string and the rest are the args}
  For cnt := 1 To n Do
  Begin
    Case Param[cnt].ExprType Of
      ttString:
        Begin
          Vars[cnt - 1].VType := {$if RtlVersion <= 18.5} vtString {$else} vtPWideChar {$ifend} ; {patched by fduenas for Unicode enabling}
          ss[cnt - 1] := Param[cnt].AsString; {patched by fduenas changed frpm AsString to GetMaxString to prevent data truncation}
          {$if RtlVersion <= 18.5}
           Vars[cnt - 1].VString := @ss[cnt - 1]; {patched by fduenas for Unicode enabling}
          {$else}
           Vars[cnt - 1].VPWideChar := PWideChar( ss[cnt - 1] ); {patched by fduenas for Unicode enabling}
          {$ifend}
        End;
     {$IFDEF LEVEL4}
      ttWideString:
        Begin
          Vars[cnt - 1].VType := {$if RtlVersion <= 18.5} vtString {$else} vtPWideChar {$ifend} ; {patched by fduenas for Unicode enabling}
          ws[cnt - 1] := Param[cnt].AsWideString; {patched by fduenas changed frpm AsString to GetMaxString to prevent data truncation}
          {$if RtlVersion <= 18.5}
           Vars[cnt - 1].VWideString := @ws[cnt - 1]; {patched by fduenas for Unicode enabling}
          {$else}
           Vars[cnt - 1].VPWideChar := PWideChar( ws[cnt - 1] ); {patched by fduenas for Unicode enabling}
          {$ifend}
        End;
     {$ENDIF}
      ttFloat:
        Begin
          Vars[cnt - 1].VType := vtExtended;
          ea[cnt - 1] := Param[cnt].AsFloat;
          Vars[cnt - 1].VExtended := @ea[cnt - 1];
        End;
      ttInteger:
        Begin
          Vars[cnt - 1].VType := vtInteger;
          Vars[cnt - 1].VInteger := Param[cnt].AsInteger;
        End;
      ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
        Begin
          Vars[cnt - 1].VType := vtInt64;
          ea[cnt - 1] := Param[cnt].AsLargeInt;
          Vars[cnt - 1].VInt64 := @ea[cnt - 1];
        End;
      ttBoolean:
        Begin
          Vars[cnt - 1].VType := vtBoolean;
          Vars[cnt - 1].VBoolean := Param[cnt].AsBoolean;
        End;
    End;
  End;
  try
  {$IFNDEF Delphi7Up}
   SaveFormatSettings( SFS );
   RefreshSystemFormatSettings; {Reset to windows settings}
  {$ENDIF}
   result := Format( Param[0].AsString, Vars{$IFDEF Delphi7Up}, fSystemFormatSettings {$ENDIF});
  finally
   {$IFNDEF Delphi7Up}
    RestoreFormatSettings(SFS);
   {$ENDIF}
  end;
End;

{$IFDEF LEVEL4}
function TFormatExpr.GetAsWideString: WideString;
Const
  MAXARGS = 20; {maximum number of arguments allowed (increase if needed)}
Var
  cnt, n: integer;
  ss: Array[0..MAXARGS] Of String;
  ws: Array[0..MAXARGS] Of WideString;
  ea: Array[0..MAXARGS] Of Extended;
  Vars: Array[0..MAXARGS] Of TVarRec;
 {$IFNDEF Delphi7Up}
  SFS: TFormatSettings;
 {$ENDIF}
Begin
  n := imin( ParameterCount - 1, MAXARGS );
  { first parameter is the format string and the rest are the args}
  For cnt := 1 To n Do
  Begin
    Case Param[cnt].ExprType Of
      ttString:
        Begin
          Vars[cnt - 1].VType := {$if RtlVersion <= 18.5} vtString {$else} vtPWideChar {$ifend} ; {patched by fduenas for Unicode enabling}
          ss[cnt - 1] := Param[cnt].AsString; {patched by fduenas changed frpm AsString to GetMaxString to prevent data truncation}
          {$if RtlVersion <= 18.5}
           Vars[cnt - 1].VString := @ss[cnt - 1]; {patched by fduenas for Unicode enabling}
          {$else}
           Vars[cnt - 1].VPWideChar := PWideChar( ss[cnt - 1] ); {patched by fduenas for Unicode enabling}
          {$ifend}
        End;
      ttWideString:
        Begin
          Vars[cnt - 1].VType := {$if RtlVersion <= 18.5} vtString {$else} vtPWideChar {$ifend} ; {patched by fduenas for Unicode enabling}
          ws[cnt - 1] := Param[cnt].AsWideString; {patched by fduenas changed frpm AsString to GetMaxString to prevent data truncation}
          {$if RtlVersion <= 18.5}
           Vars[cnt - 1].VWideString := @ws[cnt - 1]; {patched by fduenas for Unicode enabling}
          {$else}
           Vars[cnt - 1].VPWideChar := PWideChar( ws[cnt - 1] ); {patched by fduenas for Unicode enabling}
          {$ifend}
        End;
      ttFloat:
        Begin
          Vars[cnt - 1].VType := vtExtended;
          ea[cnt - 1] := Param[cnt].AsFloat;
          Vars[cnt - 1].VExtended := @ea[cnt - 1];
        End;
      ttInteger:
        Begin
          Vars[cnt - 1].VType := vtInteger;
          Vars[cnt - 1].VInteger := Param[cnt].AsInteger;
        End;
      ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
        Begin
          Vars[cnt - 1].VType := vtInt64;
          ea[cnt - 1] := Param[cnt].AsLargeInt;
          Vars[cnt - 1].VInt64 := @ea[cnt - 1];
        End;
      ttBoolean:
        Begin
          Vars[cnt - 1].VType := vtBoolean;
          Vars[cnt - 1].VBoolean := Param[cnt].AsBoolean;
        End;
    End;
  End;
  try
  {$IFNDEF Delphi7Up}
   SaveFormatSettings( SFS );
   RefreshSystemFormatSettings; {Reset to windows settings}
  {$ENDIF}
   result := WideFormat( Param[0].AsString, Vars{$IFDEF Delphi7Up}, fSystemFormatSettings{$ENDIF} );
  finally
   {$IFNDEF Delphi7Up}
    RestoreFormatSettings(SFS);
   {$ENDIF}
  end;
End;
{$ENDIF}

Function TFormatExpr.GetExprType: TExprType;
Begin
  result := ttString;
End;

// TDecodeDateTimeExpr implementation

Constructor TDecodeDateTimeExpr.Create( aName: string; ParameterList: TParameterList;
  DecodeKind: TDecodeKind );
Begin
  Inherited Create( aName, ParameterList );
  FDecodeKind := DecodeKind;
End;

Function TDecodeDateTimeExpr.GetExprType: TExprType;
Begin
  Result := ttInteger;
End;

Function TDecodeDateTimeExpr.GetAsInteger: Integer;
Var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
Begin

  Result := 0;
  Case FDecodeKind Of
    dkYear, dkMonth, dkDay: DecodeDate( Param[0].AsFloat, Year, Month, Day );
    dkHour, dkMin, dkSec, dkMSec:
      DecodeTime( Param[0].AsFloat, Hour, Min, Sec, MSec );
  End;
  Case FDecodeKind Of
    dkYear: Result := Year;
    dkMonth: Result := Month;
    dkDay: Result := Day;
    dkHour: Result := Hour;
    dkMin: Result := Min;
    dkSec: Result := Sec;
    dkMSec: Result := MSec;
  End;
End;

function TDecodeDateTimeExpr.GetAsLargeInt: Int64;
begin
 result := GetAsInteger;
end;

{ TDecodeExpr
  DECODE('abc', 'a', 1,
                'b', 2,
                'abc', 3,
                'd', 4,
                -1 )
 }

Constructor TDecodeExpr.Create( aName: TxNativeString; ParameterList: TParameterList );
Begin
  Inherited Create( aName, ParameterList );
  { check for valid expressions }
  If ( ParameterList = Nil ) Or ( ( ParameterList.Count Mod 2 ) <> 0 ) Then
    Raise EExpression.Create( 'DECODE: Incorrect number of arguments' );
End;

Function TDecodeExpr.GetAsBoolean: Boolean;
Var
  I: Integer;
  Found: Boolean;
Begin
  Result := False;
  Found := false;
  I := 1;
  While I < ParameterCount - 1 Do
  Begin
    Case Param[0].ExprType Of
      ttString:
        If Param[0].AsString = Param[I].AsString Then
           Found := true;
     {$IFDEF LEVEL4}
      ttWideString:
        If Param[0].AsWideString = Param[I].AsWideString Then
           Found := true;
     {$ENDIF}
      ttFloat:
        If Param[0].AsFloat = Param[I].AsFloat Then
          Found := true;
      ttInteger:
        If Param[0].AsInteger = Param[I].AsInteger Then
          Found := true;
      ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
        If Param[0].AsLargeInt = Param[I].AsLargeInt Then
          Found := true;
      ttBoolean:
        If Param[0].AsBoolean = Param[I].AsBoolean Then
          Found := true;
    End;
    If found Then
    Begin
      Result := Param[I + 1].AsBoolean;
      break;
    End;
    Inc( I, 2 );
  End;
  If Not found Then
    Result := Param[ParameterCount - 1].AsBoolean;
End;

Function TDecodeExpr.GetAsFloat: Double;
Var
  I: Integer;
  Found: Boolean;
Begin
  Result := 0;
  Found := false;
  I := 1;
  While I < ParameterCount - 1 Do
  Begin
    Case Param[0].ExprType Of
      ttString:
        If Param[0].AsString = Param[I].AsString Then
          Found := true;
     {$IFDEF LEVEL4}
      ttWideString:
        If Param[0].AsWideString = Param[I].AsWideString Then
          Found := true;
     {$ENDIF}
      ttFloat:
        If Param[0].AsFloat = Param[I].AsFloat Then
          Found := true;
      ttInteger:
        If Param[0].AsInteger = Param[I].AsInteger Then
          Found := true;
      ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
        If Param[0].AsLargeInt = Param[I].AsLargeInt Then
          Found := true;
      ttBoolean:
        If Param[0].AsBoolean = Param[I].AsBoolean Then
          Found := true;
    End;
    If found Then
    Begin
      Result := Param[I + 1].AsFloat;
      break;
    End;
    Inc( I, 2 );
  End;
  If Not found Then
    Result := Param[ParameterCount - 1].AsFloat;
End;

Function TDecodeExpr.GetAsInteger: Integer;
Var
  I: Integer;
  Found: Boolean;
Begin
  Result := 0;
  Found := false;
  I := 1;
  While I < ParameterCount - 1 Do
  Begin
    Case Param[0].ExprType Of
      ttString:
        If Param[0].AsString = Param[I].AsString Then
          Found := true;
     {$IFDEF LEVEL4}
      ttWideString:
        If Param[0].AsWideString = Param[I].AsWideString Then
          Found := true;
     {$ENDIF}
      ttFloat:
        If Param[0].AsFloat = Param[I].AsFloat Then
          Found := true;
      ttInteger:
        If Param[0].AsInteger = Param[I].AsInteger Then
           Found := true;
      ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
        If Param[0].AsLargeInt = Param[I].AsLargeInt Then
           Found := true;
      ttBoolean:
        If Param[0].AsBoolean = Param[I].AsBoolean Then
          Found := true;
    End;
    If found Then
    Begin
      Result := Param[I + 1].AsInteger;
      break;
    End;
    Inc( I, 2 );
  End;
  If Not found Then
    Result := Param[ParameterCount - 1].AsInteger;
End;

function TDecodeExpr.GetAsLargeInt: Int64;
Var
  I: Integer;
  Found: Boolean;
Begin
  Result := 0;
  Found := false;
  I := 1;
  While I < ParameterCount - 1 Do
  Begin
    Case Param[0].ExprType Of
      ttString:
        If Param[0].AsString = Param[I].AsString Then
          Found := true;
     {$IFDEF LEVEL4}
      ttWideString:
        If Param[0].AsWideString = Param[I].AsWideString Then
          Found := true;
     {$ENDIF}
      ttFloat:
        If Param[0].AsFloat = Param[I].AsFloat Then
          Found := true;
      ttInteger:
        If Param[0].AsInteger = Param[I].AsInteger Then
           Found := true;
      ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
        If Param[0].AsLargeInt = Param[I].AsLargeInt Then
           Found := true;
      ttBoolean:
        If Param[0].AsBoolean = Param[I].AsBoolean Then
          Found := true;
    End;
    If found Then
    Begin
      Result := Param[I + 1].AsLargeInt;
      break;
    End;
    Inc( I, 2 );
  End;
  If Not found Then
    Result := Param[ParameterCount - 1].AsLargeInt;
End;

Function TDecodeExpr.GetMaxString: String;
var
  I, L, MaxL: Integer;
Begin
  L := 2;
  MaxL := Length( Param[L].AsString );
  I := 2;
  While I <= ParameterCount - 1 Do
  Begin
    If Length( Param[I].AsString ) > MaxL Then
    Begin
      L := I;
      MaxL := Length( Param[I].AsString );
    End;
    Inc( I, 2 );
  End;
  Result := Param[L].AsString;
End;
{$IFDEF LEVEL4}
function TDecodeExpr.GetMaxWideString: WideString;
var
  I, L, MaxL: Integer;
Begin
  L := 2;
  MaxL := Length( Param[L].AsWideString );
  I := 2;
  While I <= ParameterCount - 1 Do
  Begin
    If Length( Param[I].AsWideString ) > MaxL Then
    Begin
      L := I;
      MaxL := Length( Param[I].AsWideString );
    End;
    Inc( I, 2 );
  End;
  Result := Param[L].AsWideString;
End;
{$ENDIF}
Function TDecodeExpr.GetAsString: String;
Var
  I: Integer;
  Found: Boolean;
Begin
  Found := False;
  I := 1;
  While I < ParameterCount - 1 Do
  Begin
    Case Param[0].ExprType Of
      ttString:
        If Param[0].AsString = Param[I].AsString Then
          Found := true;
     {$IFDEF LEVEL4}
      ttWideString:
        If Param[0].AsWideString = Param[I].AsWideString Then
          Found := true;
     {$ENDIF}
      ttFloat:
        If Param[0].AsFloat = Param[I].AsFloat Then
          Found := true;
      ttInteger:
        If Param[0].AsInteger = Param[I].AsInteger Then
          Found := true;
      ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
        If Param[0].AsLargeInt = Param[I].AsLargeInt Then
          Found := true;
      ttBoolean:
        If Param[0].AsBoolean = Param[I].AsBoolean Then
          Found := true;
    End;
    If found Then
    Begin
      Result := Param[I + 1].AsString;
      break;
    End;
    Inc( I, 2 );
  End;
  If Not found Then
    Result := Param[ParameterCount - 1].AsString;
End;
{$IFDEF LEVEL4}
function TDecodeExpr.GetAsWideString: WideString;
Var
  I: Integer;
  Found: Boolean;
Begin
  Found := False;
  I := 1;
  While I < ParameterCount - 1 Do
  Begin
    Case Param[0].ExprType Of
      ttString:
        If Param[0].AsString = Param[I].AsString Then
          Found := true;
      ttWideString:
        If Param[0].AsWideString = Param[I].AsWideString Then
          Found := true;
      ttFloat:
        If Param[0].AsFloat = Param[I].AsFloat Then
          Found := true;
      ttInteger:
        If Param[0].AsInteger = Param[I].AsInteger Then
          Found := true;
      ttLargeInt: {added by fduenas: added LargeInt (Int64) support}
        If Param[0].AsLargeInt = Param[I].AsLargeInt Then
          Found := true;
      ttBoolean:
        If Param[0].AsBoolean = Param[I].AsBoolean Then
          Found := true;
    End;
    If found Then
    Begin
      Result := Param[I + 1].AsWideString;
      break;
    End;
    Inc( I, 2 );
  End;
  If Not found Then
    Result := Param[ParameterCount - 1].AsWideString;
End;
{$ENDIF}
function TDecodeExpr.GetExprType: TExprtype;
Begin
  Result := Param[2].ExprType;
End;

{ MINOF, MAXOF functions support}

Constructor TMinMaxOfExpr.Create( aName: string; ParameterList: TParameterList; IsMin: Boolean );
Begin
  Inherited Create( aName, ParameterList );
  { check for valid expressions }
  If ( ParameterList = Nil ) Or ( ParameterList.Count < 1 ) Then
    Raise EExpression.Create( 'MINOF, MAXOF: Incorrect number of arguments' );
  FIsMin := IsMin;
End;

Function TMinMaxOfExpr.GetAsFloat: Double;
Var
  i: Integer;
Begin
  Result := Param[0].AsFloat;
  For i := 1 To ParameterCount - 1 Do
  Begin
    If FIsMin Then
      Result := Min( Result, Param[i].AsFloat )
    Else
      Result := Max( Result, Param[i].AsFloat );
  End;
End;

function TMinMaxOfExpr.GetExprType: TExprtype;
Begin
  Result := ttFloat;
End;

{ TxMatchMask }

constructor TxMatchMask.Create(const AExprName, AMaskValue: string);
begin
 fExprName := AExprName;
 Setup( AMaskValue );
end;

constructor TxMatchMask.CreateWithParams(const AExprName, AMaskValue: string; AEscapeChar, AAnyMultipleChar,
  ASingleChar, AAnyMultipleCharStrict, ASingleCharStrict: char);
begin
 fExprName := AExprName;
 Setup( AMaskValue, AEscapeChar, AAnyMultipleChar,
        ASingleChar, AAnyMultipleCharStrict, ASingleCharStrict );
end;

destructor TxMatchMask.Destroy;
begin
 if fMaskPtr <> nil then
 begin
   DoneMaskStates(Slice(PMaskStateArray(fMaskPtr)^, fSize));
   FreeMem(fMaskPtr, fSize * SizeOf(TMaskState));
 end;
 inherited;
end;

procedure TxMatchMask.DoneMaskStates(var AMaskStates: array of TMaskState);
var
  I: Integer;
begin
  for I := Low(AMaskStates) to High(AMaskStates) do
    if AMaskStates[I].State = msSet then Dispose(AMaskStates[I].CharSet);
end;

procedure TxMatchMask.Setup(const AMaskValue: string; AEscapeChar, AAnyMultipleChar, ASingleChar,
  AAnyMultipleCharStrict, ASingleCharStrict: char);
var
  A: array[0..0] of TMaskState;
begin
  fMask := AMaskValue;
  fEscapeChar := AEscapeChar;
  fAnyMultipleChar :=  AAnyMultipleChar;
  fAnyMultipleCharStrict := AAnyMultipleCharStrict;
  fSingleChar := ASingleChar;
  fSingleCharStrict := ASingleCharStrict;

  fSize := InitMaskStates(AMaskValue, A);
  DoneMaskStates(A);

  fMaskPtr := AllocMem(fSize * SizeOf(TMaskState));
  InitMaskStates(AMaskValue, Slice(PMaskStateArray(fMaskPtr)^, fSize));
end;

function TxMatchMask.InitMaskStates(const AMask: string;
  var AMaskStates: array of TMaskState): Integer;
var
  I: Integer;
  SkipTo, Accept: Boolean;
  Literal: Char;
  LeadByte, TrailByte: Char;
  P: PChar;
  Negate: Boolean;
  CharSet: TMaskSet;
  Cards: Integer;
  PreviousChar: Char;
  procedure InvalidMask;
  begin
    raise ExMatchMaskError.CreateResFmt(@SEXPR_MATCHINVALIDMASK, [fExprName, AMask,
      P - PChar(AMask) + 1]);
  end;

  procedure Reset;
  begin
    SkipTo := False;
    Negate := False;
    CharSet := [];
  end;

  procedure WriteScan(MaskState: TMaskStates);
  begin
    if I <= High(AMaskStates) then
    begin
      if SkipTo then
      begin
        Inc(Cards);
        if Cards > MaxCards then InvalidMask;
      end;
      AMaskStates[I].SkipTo := SkipTo;
      AMaskStates[I].State := MaskState;
      case MaskState of
        msLiteral: AMaskStates[I].Literal := UpCase(Literal);
        msSet:
          begin
            AMaskStates[I].Negate := Negate;
            New(AMaskStates[I].CharSet);
            AMaskStates[I].CharSet^ := CharSet;
          end;
        msMBCSLiteral:
          begin
            AMaskStates[I].LeadByte := LeadByte;
            AMaskStates[I].TrailByte := TrailByte;
          end;
      end;
    end;
    Inc(I);
    Reset;
  end;

  procedure ScanSet;
  var
    LastChar: Char;
    C: Char;
  begin
    Inc(P);
    if P^ = '!' then
    begin
      Negate := True;
      Inc(P);
    end;
    LastChar := #0;
    while not CharInSet(P^, [#0, ']']) do
    begin
      // MBCS characters not supported in msSet!
      if {$IFDEF Unicode}IsLeadChar(P^){$ELSE}False{$ENDIF} then
         Inc(P)
      else
      case P^ of
        '-':
          if LastChar = #0 then InvalidMask
          else
          begin
            Inc(P);
            for C := LastChar to UpCase(P^) do

              Include(CharSet, AnsiChar(C));
          end;
      else
        LastChar := UpCase(P^);

        Include(CharSet, AnsiChar(LastChar));
      end;
      Inc(P);
    end;
    if (P^ <> ']') or (CharSet = []) then InvalidMask;
    WriteScan(msSet);
  end;

begin
  P := PChar(AMask);
  I := 0;
  Cards := 0;
  Reset;
  PreviousChar:=#0;
  while P^ <> #0 do
  begin
    Accept := ( (( P^ = fAnyMultipleChar ) or ( P^ = fAnyMultipleCharStrict )) And ( fEscapeChar = #0 ) ) Or
        ( (( P^ = fAnyMultipleChar ) or ( P^ = fAnyMultipleCharStrict )) And ( PreviousChar <> fEscapeChar ) and (not SkipTo) ) Or
        ( (( P^ = fSingleChar ) or ( P^ = fSingleCharStrict )) And ( fEscapeChar = #0 ) and (not SkipTo) ) Or
        ( (( P^ = fSingleChar ) or ( P^ = fSingleCharStrict )) And ( PreviousChar <> fEscapeChar ) ) Or
        ( ( P^ = '[' ) And ( PreviousChar <> fEscapeChar ) );
    if Accept  then
    begin
     if (P^ = fAnyMultipleChar) or (P^ = fAnyMultipleCharStrict) then
        SkipTo := True
     else if ((P^ = fSingleChar) or (P^ = fSingleCharStrict)) and (not SkipTo) then
              WriteScan(msAny)
     else if (P^ = '[') then  ScanSet;
    end
    else
    begin
      if {$IFDEF Unicode}IsLeadChar(P^){$ELSE}False{$ENDIF} then
      begin
        LeadByte := P^;
        Inc(P);
        TrailByte := P^;
        If ( fEscapeChar = #0 ) Or Not ( (P^ = fEscapeChar) and (PreviousChar<>fEscapeChar) ) Then
            WriteScan(msMBCSLiteral);
      end
      else
      begin
        Literal := P^;
        If ( fEscapeChar = #0 ) Or Not ( (P^ = fEscapeChar )and (PreviousChar<>fEscapeChar) ) Then
           WriteScan(msLiteral);
      end;
    end;
    if ( (P^ = fEscapeChar) and (PreviousChar=fEscapeChar) ) then
       PreviousChar := #0
    else
       PreviousChar := P^;
    Inc(P);
  end;
  Literal := #0;
  WriteScan(msLiteral);
  Result := I;
end;

function TxMatchMask.Matches(const AString: string): Boolean;
begin
 Result := MatchesMaskStates(AString, Slice(PMaskStateArray(fMaskPtr)^, fSize));
end;

function TxMatchMask.MatchesMaskStates(const AString: string;
  const AMaskStates: array of TMaskState): Boolean;
type
  TStackRec = record
    sP: PChar;
    sI: Integer;
  end;
var
  T: Integer;
  S: array[0..MaxCards - 1] of TStackRec;
  I: Integer;
  P: PChar;

  procedure Push(P: PChar; I: Integer);
  begin
    with S[T] do
    begin
      sP := P;
      sI := I;
    end;
    Inc(T);
  end;

  function Pop(var P: PChar; var I: Integer): Boolean;
  begin
    if T = 0 then
      Result := False
    else
    begin
      Dec(T);
      with S[T] do
      begin
        P := sP;
        I := sI;
      end;
      Result := True;
    end;
  end;

  function Matches(P: PChar; Start: Integer): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := Start to High(AMaskStates) do
      with AMaskStates[I] do
      begin
        if SkipTo then
        begin
          case State of
            msLiteral:
              while (P^ <> #0) and (UpCase(P^) <> Literal) do Inc(P);
            msSet:
              while (P^ <> #0) and not (Negate xor CharInSet(UpCase(P^), CharSet^)) do Inc(P);
            msMBCSLiteral:
              while (P^ <> #0) do
              begin
                if (P^ <> LeadByte) then Inc(P, 2)
                else
                begin
                  Inc(P);
                  if (P^ = TrailByte) then Break;
                  Inc(P);
                end;
              end;
          end;
          if P^ <> #0 then
            Push(@P[1], I);
        end;
        case State of
          msLiteral: if UpCase(P^) <> Literal then Exit;
          msSet: if not (Negate xor CharInSet(UpCase(P^), CharSet^)) then Exit;
          msMBCSLiteral:
            begin
              if P^ <> LeadByte then Exit;
              Inc(P);
              if P^ <> TrailByte then Exit;
            end;
          msAny:
            if P^ = #0 then
            begin
              Result := False;
              Exit;
            end;
        end;
        Inc(P);
      end;
    Result := True;
  end;

begin
  Result := True;
  T := 0;
  P := PChar(AString);
  I := Low(AMaskStates);
  repeat
    if Matches(P, I) then Exit;
  until not Pop(P, I);
  Result := False;
end;

{ TSQLMatchLikeExpr }

constructor TSQLMatchLikeExpr.Create(ParameterList: TParameterList; IsNotLike: Boolean);
begin
  Inherited Create('LIKE', ParameterList );
  fIsNotLike := IsNotLike;
  DoSetup;
end;

constructor TSQLMatchLikeExpr.Create(aName: String; ParameterList: TParameterList;
  IsNotLike: Boolean);
begin
 inherited Create( fExprName, ParameterList);
 fIsNotLike := IsNotLike;
 fExprName := aName;
 DoSetup;
end;

destructor TSQLMatchLikeExpr.Destroy;
begin
  fMatchMask.Free;
  inherited;
end;

function TSQLMatchLikeExpr.GetAsBoolean: Boolean;
begin
 result := fMatchMask.Matches(Param[0].AsString);
 if fIsNotLike then
    result := not result;
end;

function TSQLMatchLikeExpr.GetExprType: TExprtype;
begin
 Result := ttBoolean;
end;

procedure TSQLMatchLikeExpr.DoSetup;
var LEscapeChar: Char;
begin
  If ( ParameterCount > 2 ) And ( Length( Param[2].AsString ) > 0 ) Then
    LEscapeChar := Param[2].AsString[1]
  Else
    LEscapeChar := #0;
  if not Assigned(fMatchMask) then
     fMatchMask := TxMatchMask.CreateWithParams(fExprName, Param[1].AsString, LEscapeChar)
  else
     fMatchMask.Setup(Param[1].AsString, LEscapeChar);
end;

End.
