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
{   The Original Code is: xqtypes.pas                                         }
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

unit XQTypes;

{$I XQ_FLAG.INC}

interface
 Uses SysUtils, Db, Classes{$IFDEF Delphi4Up}, WideStrings, FMTBcd, SqlTimSt{$ENDIF};

 Const
  SQuote = [#39{'}, #34{"}];
  NBoolean: Array[Boolean] Of String = ( 'FALSE', 'TRUE' );
  SBooleanValues = ['T', 't', 'Y', 'y'];

 type
  {-------------------------------------------------------------------------------}
  {                          Some base types needed                               }
  {-------------------------------------------------------------------------------}

  PFloat = ^Double;
  PInteger = ^Integer;
  PWordBool = ^WordBool;
  PPointer = ^Pointer;

  TxNativeChar = {$ifdef Delphi2009Up}Char{$else}{$IFDEF XQ_USE_WIDESTRINGS}WideChar{$else}Char{$endif}{$endif};
  TxNativePChar = {$ifdef Delphi2009Up}PChar{$else}{$IFDEF XQ_USE_WIDESTRINGS}PWideChar{$else}PChar{$endif}{$endif};
  TxNativeString = {$ifdef Delphi2009Up}String{$else}{$IFDEF XQ_USE_WIDESTRINGS}WideString{$else}String{$endif}{$endif};

  TxNativeWideChar = {$ifdef Delphi4Up}WideChar{$else}Char{$endif};
  TxNativePWideChar = {$ifdef Delphi4Up}PWideChar{$else}PChar{$endif};
  TxNativeWideString = {$ifdef Delphi2009Up}WideString{$else}{$ifdef Delphi4Up}WideString{$else}String{$endif}{$endif};
  TxNativeUnicodeString = {$ifdef Delphi2009Up}UnicodeString{$else}{$ifdef Delphi4Up}WideString{$else}String{$endif}{$endif};

  TxNativeTStrings = {$ifdef Delphi2009Up}TStrings{$else}{$IFDEF XQ_USE_WIDESTRINGS}TWideStrings{$else}TStrings{$endif}{$endif};
  TxNativeTStringList = {$ifdef Delphi2009Up}TStringList{$else}{$IFDEF XQ_USE_WIDESTRINGS}TWideStringList{$else}TStringList{$endif}{$endif};

  TxNativeTWideStrings = {$ifdef Delphi4Up}TWideStrings{$else}TStrings{$endif};
  TxNativeTWideStringList = {$ifdef Delphi4Up}TWideStringList{$else}TStringList{$endif};

  TxNativeInt = {$ifdef Delphi2009Up}NativeInt{$else}Integer{$endif};
  TxNativeUInt = {$ifdef Delphi2009Up}NativeUInt{$else}Cardinal{$endif};

  TxNativeInt32 = {$ifdef DelphiXE2Up}Int32{$else}Integer{$endif};
  TxNativeUInt32 = {$ifdef DelphiXE2Up}UInt32{$else}Cardinal{$endif};

  TxNativeInt64 = {$ifdef DelphiXE2Up}NativeInt{$else}Int64{$endif};
  TxNativeUInt64 = {$ifdef DelphiXE2Up}NativeUInt{$else}UInt64{$endif};

  TxBuffer = {$if RtlVersion <= 18.5}PAnsiChar{$else}TBytes{$ifend}; { patched by ccy } {moved from xqbase}

  {$if RTLVersion <= 18.5}TRecordBuffer = PAnsiChar;{$ifend}

  {$ifdef DelphiXE3Up}
  PxqSetFieldDataBuffer = TValueBuffer;
  PxqGetFieldDataBuffer = TValueBuffer;
  {$ELSE}
  PxqSetFieldDataBuffer = pointer;
  PxqGetFieldDataBuffer = pointer;
  {$ENDIF}

  {-------------------------------------------------------------------------------}
  {                          Main exception                                       }
  {-------------------------------------------------------------------------------}

  ExException  = Class( Exception );
  ExQueryError = Class( ExException );
  ExMatchMaskError = Class( ExException );

  {Custom Types}
  TxByteBool         = ByteBool;
  TxFieldBoolSep     = WordBool;
  TxCalcFieldBoolSep = ByteBool;
const
  //Constants To store the SizeOf(x) for faster access.
  XQ_SizeOf_Char             = SizeOf(Char);
  XQ_SizeOf_NativeChar       = SizeOf(TxNativeChar);
  XQ_SizeOf_AnsiChar         = SizeOf(AnsiChar);
  XQ_SizeOf_WideChar         = SizeOf(WideChar);
  XQ_SizeOf_NativeWideChar   = SizeOf(TxNativeWideChar);

  XQ_SizeOf_SmallInt         = SizeOf(SmallInt);
  XQ_SizeOf_ShortInt         = SizeOf(ShortInt);
  XQ_SizeOf_Integer          = SizeOf(Integer);
  XQ_SizeOf_Int64            = SizeOf(Int64);
  XQ_SizeOf_Word             = SizeOf(Word);

  XQ_SizeOf_Boolean          = SizeOf(WordBool);
  XQ_SizeOf_WordBool         = SizeOf(WordBool);
  XQ_SizeOf_ByteBool         = SizeOf(ByteBool);
  XQ_SizeOf_FieldBoolSep     = SizeOf(TxFieldBoolSep);
  XQ_SizeOf_CalcFieldBoolSep = SizeOf(TxCalcFieldBoolSep);

  XQ_SizeOf_Double           = SizeOf(Double);
  XQ_SizeOf_TDateTime        = SizeOf(Double);
  XQ_SizeOf_TSQLTimeStamp    = SizeOf(TSQLTimeStamp);

  XQ_SizeOf_Pointer          = SizeOf(Pointer);
  XQ_SizeOf_TBCD             = {$ifdef Delphi4Up}SizeOf(TBCD){$else}34{$endif}; {before was 34, why that value????}
  XQ_SizeOf_Currency         = SizeOf(Currency);
implementation

end.
