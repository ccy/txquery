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
{   The Original Code is: XQMiscel.pas                                        }
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

Unit XQMiscel;

{$I XQ_FLAG.INC}
Interface

Uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IniFiles, ExtCtrls, DB, Qbaseexpr, QFormatSettings
{$IFDEF LEVEL4}, FMTBcd, SqlTimSt{$ENDIF}
{$IFDEF LEVEL6}, Variants{$ENDIF}
  , XQTypes
{$IFDEF UNICODE}, Character{$ENDIF};

Type

  {Buffered read/write class - used for fast sequencial reads/writes}
  PCharArray = ^TCharArray;
  TCharArray = Array[0..0] Of TxNativeChar;

  TBufferedReadWrite = Class( TStream )
  Private
    FStream: TStream;
    FValidBytesInSector: TxNativeInt;
    FCurrentSector: TxNativeInt;
    FOffsetInSector: TxNativeInt;
    PBuffer: PCharArray;
    FSizeOfSector: TxNativeInt;
    FFreeStream: Boolean;
    FMustFlush: Boolean;
    Procedure FlushBuffer;
  Public
    Constructor Create( F: TStream; FreeStream: Boolean; BuffSize: LongInt );
    Destructor Destroy; Override;
    Function Read( Var Buffer; Count: LongInt ): LongInt; Override;
    Function Seek( Offset: LongInt; Origin: Word ): LongInt; Override;
    Function Write( Const Buffer; Count: LongInt ): LongInt; Override;
    Procedure ResetPos;
  End;

  { Miscelaneous routines }
  Function TrimSquareBrackets( Const Ident: TxNativeString ): TxNativeString;
  Function AddSquareBrackets( Const Ident: TxNativeString ): TxNativeString;
  Function QualifiedFieldAddSquareBrackets( Const Ident: TxNativeString ): TxNativeString;
  Procedure FreeObject( Var Obj );
  Procedure ReplaceString( Var Work: TxNativeString; Const Old, NNew: TxNativeString );
  Function TrimCRLF( Const s: TxNativeString ): TxNativeString;
  Function MessageToUser( Const Msg: TxNativeString; Atype: TMsgDlgtype ): Word;
  Function Max( Const A, B: Double ): Double; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Function Min( Const A, B: Double ): Double; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Function IMax( A, B: TxNativeInt ): TxNativeInt; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Function IMin( A, B: TxNativeInt ): TxNativeInt; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  {$IFDEF FALSE}
  Function GetRecordNumber( DataSet: TDataSet ): TxNativeInt;
  Procedure SetRecordNumber( DataSet: TDataSet; RecNum: TxNativeInt );
  {$ENDIF}
  Function GetTemporaryFileName( Const Prefix: TxNativeString ): TxNativeString;
  Function AddSlash( Const Path: TxNativeString ): TxNativeString;
  Function RemoveSlash( Const Path: TxNativeString ): TxNativeString;
  Function Field2Exprtype( Datatype: TFieldtype ): TExprtype; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Function SizeOfExprType( ExprType: TExprtype ): TxNativeInt; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Function SizeOfFieldType( FieldType: TFieldtype ): TxNativeInt; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Function RemoveStrDelim( Const S: TxNativeString ): TxNativeString;
  Function CountChars( const s: TxNativeString; Ch: TxNativeChar ): TxNativeInt;
  Function VarMin( const Value1, Value2: Variant): Variant; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Function VarMax( const Value1, Value2: Variant): Variant; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Function AddCorrectStrDelim(Const S: TxNativeString) : TxNativeString;
  Function XQStringIsUnicode( const aString: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF} ): boolean;{$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Function XQStripTableFieldName( const aTableFieldName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};
                                  const aTrimSquareBrakets: boolean;
                                  var   aTableName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};
                                  var   aFieldName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF} ): boolean;{$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Function XQExtractTableName( const aTableFieldName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};
                               const aTrimSquareBrakets: boolean=true):{$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};{$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Function XQExtractFieldName( const aTableFieldName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};
                               const aTrimSquareBrakets: boolean=true):{$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};{$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
  Implementation

Uses
  xqbase, xquery, xqconsts, qexprlex, QCnvStrUtils;

Function VarMin( const Value1, Value2: Variant): Variant; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
Begin
  If Value1 < Value2 then Result:= Value1 Else Result:= Value2;
End;

Function VarMax( const Value1, Value2: Variant): Variant; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
Begin
  If Value1 > Value2 then Result:= Value1 Else Result:= Value2;
End;


// miscelaneous

Function Field2Exprtype( Datatype: TFieldtype ): TExprtype; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
Begin
  Result := ttString;
  If Datatype In ftNonTexttypes Then
    Result := ttString
  Else
    Case Datatype Of
      ftString{$IFDEF LEVEL4}, ftFixedChar{$ENDIF}{$IFDEF LEVEL5}, ftGUID{$ENDIF}:
        Result := ttString;
      {$IFDEF LEVEL4}
      ftWideString, ftFixedWideChar (*$IFDEF Delphi2006Up*), ftWideMemo(*$ENDIF*):
        Result := ttWideString;
      {$ENDIF}
      ftFloat, ftCurrency, ftBCD, {$IFDEF LEVEL6}ftFMTBcd, {$ENDIF}ftDate, ftTime, ftDateTime, ftTimeStamp: {ftTimeStamp added 2013-04-25}
        Result := ttFloat;
      ftAutoInc, ftSmallInt, ftInteger, {$IFDEF Delphi2009Up}ftShortint, {$ENDIF} ftWord: {added by fduenas: ftShortInt}
        Result := ttInteger;
{$IFDEF LEVEL4}
      ftLargeInt: Result := ttLargeInt;
{$ENDIF}
      ftBoolean:
        Result := ttBoolean;
    End;
End;

Function SizeOfExprType( ExprType: TExprtype ): TxNativeInt; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
begin
 Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Char){$ELSE}XQ_SizeOf_Char{$ENDIF};
   Case ExprType Of
    ttString: Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(AnsiChar){$ELSE}XQ_SizeOf_AnsiChar{$ENDIF};
    {$IFDEF LEVEL4}
    ttWideString: Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(TxNativeWideChar){$ELSE}XQ_SizeOf_NativeWideChar{$ENDIF};
    {$ENDIF}
    ttFloat: Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Double){$ELSE}XQ_SizeOf_Double{$ENDIF};
    ttLargeInt: Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Int64){$ELSE}XQ_SizeOf_Int64{$ENDIF};
    ttInteger: Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF};
    ttBoolean: Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(WordBool){$ELSE}XQ_SizeOf_WordBool{$ENDIF};
   End;
end;

Function SizeOfFieldType( FieldType: TFieldType ): TxNativeInt ; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
Begin
  Case FieldType Of
{$IFDEF LEVEL4}
    ftFixedChar,
{$ENDIF}
    ftString:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(AnsiChar){$ELSE}XQ_SizeOf_AnsiChar{$ENDIF}; { patched by fduenas }
    // this fixes some Float field values displayed wrongly
   {$IFDEF LEVEL4}
    ftWideString, ftFixedWideChar:
        Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(TxNativeWideChar){$ELSE}XQ_SizeOf_NativeWideChar{$ENDIF}; { patched by fduenas }
   {$ENDIF}
    ftSmallInt:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(SmallInt){$ELSE}XQ_SizeOf_SmallInt{$ENDIF};
   {$IFDEF Delphi2009Up}
    ftShortInt:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(ShortInt){$ELSE}XQ_SizeOf_ShortInt{$ENDIF};
   {$ENDIF}
    ftInteger:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF};
{$IFDEF LEVEL4}
    ftLargeint:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Int64){$ELSE}XQ_SizeOf_Int64{$ENDIF};
{$ENDIF}
    ftWord:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Word){$ELSE}XQ_SizeOf_Word{$ENDIF};
    ftBoolean:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(WordBool){$ELSE}XQ_SizeOf_WordBool{$ENDIF};
    ftFloat:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Double){$ELSE}XQ_SizeOf_Double{$ENDIF};
    ftCurrency:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Double){$ELSE}XQ_SizeOf_Double{$ENDIF};
    ftDate:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(TDateTimeRec){$ELSE}XQ_SizeOf_TDateTime{$ENDIF};
    ftTime:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(TDateTimeRec){$ELSE}XQ_SizeOf_TDateTime{$ENDIF};
    ftDateTime:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(TDateTimeRec){$ELSE}XQ_SizeOf_TDateTime{$ENDIF};

    ftTimeStamp: {ftTimeStamp added 2013-04-25}
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(TDateTimeRec){$ELSE}XQ_SizeOf_TDateTime{$ENDIF};

    ftAutoInc:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Integer){$ELSE}XQ_SizeOf_Integer{$ENDIF};
    ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle, {$IFDEF Delphi2009Up}ftStream, {$ENDIF}
      ftTypedBinary, ftBytes, ftVarBytes {$IFDEF Delphi2006Up}, ftWideMemo  {$ENDIF}:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(Pointer){$ELSE}XQ_SizeOf_Pointer{$ENDIF};
    ftBCD{$IFDEF LEVEL6}, ftFMTBcd {$ENDIF}:
      Result := {$IFNDEF XQ_USE_SIZEOF_CONSTANTS}SizeOf(TBcd){$ELSE}XQ_SizeOf_TBCD{$ENDIF};
  Else
    Result := 0;
  End;
End;

{
procedure LeftSet(var S1: String; const S2: String);
var
  N,N1,N2: TxNativeInt;
begin
  N1 := Length(S1); if N1 = 0 then Exit;
  N2 := Length(S2);
  N := N2; if N1 < N then N := N1;
  Move(S2[1], S1[1], N);
end; }

Procedure FreeObject( Var Obj ); {patched by fduenas: Make FreeObject Work as Standard FreeAndNil}
var
  Temp: TObject;
begin
  Temp := TObject(Obj);
  Pointer(Obj) := nil;
  if assigned(Temp) then
     Temp.Free;
end;

Procedure ReplaceString( Var Work: TxNativeString; Const Old, NNew: TxNativeString );
Var
  OldLen, p: TxNativeInt;
Begin

  If AnsiCompareText( Old, NNew ) = 0 Then Exit;
  OldLen := Length( Old );
  p := AnsiPos( UpperCase(Old), UpperCase(Work) );
  While p > 0 Do
  Begin
    Delete( Work, p, OldLen );
    Insert( NNew, Work, p );
    p := AnsiPos( UpperCase(Old), UpperCase(Work) );
  End;
End;

Function TrimCRLF( Const s: TxNativeString ): TxNativeString;
Begin
  result := Trim( s );
  ReplaceString( result, #13, '' );
  ReplaceString( result, #10, '' );
  ReplaceString( result, #11, '' ); {added by fduenas}
End;

Function MessageToUser( Const Msg: TxNativeString; Atype: TMsgDlgtype ): Word;
Begin
  Result := MessageDlg( Msg, Atype, [mbOk], 0 );
End;

Function IMax( A, B: TxNativeInt ): TxNativeInt; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
Begin
  If A > B Then
    Result := A
  Else
    Result := B;
End;

Function IMin( A, B: TxNativeInt ): TxNativeInt;  {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
Begin
  If A < B Then
    Result := A
  Else
    Result := B;
End;

Function Max( Const A, B: Double ): Double; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
Begin
  If A > B Then
    Result := A
  Else
    Result := B;
End;

Function Min( Const A, B: Double ): Double; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
Begin
  If A < B Then
    Result := A
  Else
    Result := B;
End;

Function RemoveStrDelim( Const S: TxNativeString ): TxNativeString;
Begin
  If ( Length( S ) >= 2 ) And
    CharInSet( S[1], xqtypes.SQuote ) And CharInSet( S[Length( S )], xqtypes.SQuote ) Then
    Result := Copy( S, 2, Length( S ) - 2 )
  Else
    Result := S;
End;

Function AddCorrectStrDelim(Const S: TxNativeString) : TxNativeString;
Begin
  if AnsiPos('''', S) > 0 then
    Result := '"' + S + '"'
  else
    Result := '''' + S + '''';
End;

Function CountChars( const s: TxNativeString; Ch: TxNativeChar ): TxNativeInt;
var
  I: TxNativeInt;
Begin
  Result:= 0;
  for I:= 1 to Length(s) do
    if s[I] = Ch then Inc(Result);
End;

Function AddSlash( Const Path: TxNativeString ): TxNativeString;
Begin
  result := Path;
  If ( Length( result ) > 0 ) And ( result[length( result )] <> '\' ) Then
    result := result + '\'
End;

Function RemoveSlash( Const Path: TxNativeString ): TxNativeString;
Var
  rlen: TxNativeInt;
Begin
  result := Path;
  rlen := length( result );
  If ( rlen > 0 ) And ( result[rlen] = '\' ) Then
    Delete( result, rlen, 1 );
End;

{$IFDEF FALSE}

Function GetRecordNumber( DataSet: TDataSet ): TxNativeInt;
{$IFDEF WITHBDE}
Var
  CursorProps: CurProps;
  RecordProps: RECProps;
{$ENDIF}
Begin
  Result := 0;
{$IFDEF WITHBDE}
  If DataSet Is TBDEDataSet Then
  Begin
    With TBDEDataSet( DataSet ) Do
    Begin
      If ( State = dsInactive ) Then
        exit;
      Check( DbiGetCursorProps( Handle, CursorProps ) );
      UpdateCursorPos;
      Check( DbiGetRecord( Handle, dbiNOLOCK, Nil, @RecordProps ) );
      Case CursorProps.iSeqNums Of
        0: Result := RecordProps.iPhyRecNum;
        1: Result := RecordProps.iSeqNum;
      End;
    End;
  End
  Else
  Begin
{$ENDIF}
    If ( DataSet.State = dsInactive ) Then
      Exit;
    Result := DataSet.RecNo; // dataset must support recno property
{$IFDEF WITHBDE}
  End;
{$ENDIF}
End;

Procedure SetRecordNumber( DataSet: TDataSet; RecNum: TxNativeInt );
{$IFDEF WITHBDE}
Var
  CursorProps: CurProps;
{$ENDIF}
Begin
{$IFDEF WITHBDE}
  If DataSet Is TBDEDataSet Then
  Begin
    With TBDEDataSet( DataSet ) Do
    Begin
      If ( State = dsInactive ) Then
        exit;

      Check( DbiGetCursorProps( Handle, CursorProps ) );

      Case CursorProps.iSeqNums Of
        0: Check( DBISetToRecordNo( Handle, RecNum ) );
        1: Check( DBISetToSeqNo( Handle, RecNum ) );
      End;
    End;
  End
  Else
  Begin
{$ENDIF}
    If ( DataSet.State = dsInactive ) Then
      Exit;
    DataSet.RecNo := RecNum;
{$IFDEF WITHBDE}
  End;
{$ENDIF}
  DataSet.ReSync( [] );
End;
{$ENDIF}

{ TBufferedReadWrite - class implementation
   used for fast buffered readings/writing from files }

Constructor TBufferedReadWrite.Create( F: TStream; FreeStream: Boolean; BuffSize: LongInt );
Begin
  Inherited Create;

  FStream := F;
  FFreeStream := FreeStream;
  If BuffSize < dsMaxStringSize Then
    FSizeOfSector := dsMaxStringSize
  Else
    FSizeOfSector := BuffSize;

  GetMem( PBuffer, FSizeOfSector );

  FCurrentSector := -1; { any sector available }

  Seek( F.Position, 0 );

End;

Destructor TBufferedReadWrite.Destroy;
Begin
  FlushBuffer;
  FreeMem( PBuffer, FSizeOfSector );
  If FFreeStream Then
    FStream.Free;
  Inherited Destroy;
End;

Procedure TBufferedReadWrite.ResetPos;
Begin
  FlushBuffer;
  FCurrentSector := -1;
End;

Function TBufferedReadWrite.Seek( Offset: LongInt; Origin: Word ): LongInt;
Var
  TmpSector: TxNativeInt;
Begin
  Result := 0;
  If Origin = soFromBeginning Then
    { from start of file }
    Result := Offset
  Else If Origin = soFromCurrent Then
    { from current position }
    Result := ( (FCurrentSector * FSizeOfSector) + FOffsetInSector ) + Offset
  Else If Origin = soFromEnd Then
  Begin
    { flush the buffer in order to detect the size of the file }
    FlushBuffer;
    Result := FStream.Size + Offset;
  End;
  TmpSector := Result Div FSizeOfSector;
  FOffsetInSector := Result Mod FSizeOfSector;
  If FCurrentSector = TmpSector Then
    Exit;

  FlushBuffer;
  FStream.Seek( TmpSector * FSizeOfSector, soFromBeginning );
  FValidBytesInSector := FStream.Read( PBuffer^, FSizeOfSector );
  FCurrentSector := TmpSector;
End;

Function TBufferedReadWrite.Read( Var Buffer; Count: LongInt ): LongInt;
Var
  N, Diff: TxNativeInt;
  { I cannot read more data than dsMaxStringSize chars at a time (take care with text) }
  Temp: Array[0..dsMaxStringSize - 1] Of Char Absolute Buffer;

  Function ReadNextBuffer: Boolean;
  Begin
    { write the buffer if not flushed to disk }
    FlushBuffer;
    { read next buffer and return false if cannot }
    FValidBytesInSector := FStream.Read( PBuffer^, FSizeOfSector );
    Inc( FCurrentSector );
    FOffsetInSector := 0;
    Result := ( FValidBytesInSector > 0 );
  End;

Begin
  Result := 0;
  If ( Count < 1 ) Or ( Count > SizeOf( Temp ) ) Then
    Exit;
  If FOffsetInSector + Count <= FValidBytesInSector Then
  Begin
    { in the buffer is full data }
    Move( PBuffer^[FOffsetInSector], Buffer, Count );
    Inc( FOffsetInSector, Count );
    Result := Count;
  End
  Else
  Begin
    { in the current buffer is partial data }
    N := FValidBytesInSector - FOffsetInSector;
    Move( PBuffer^[FOffsetInSector], Buffer, N );
    Result := N;
    If Not ReadNextBuffer Then
      Exit;
    Diff := Count - N;
    Move( PBuffer^[FOffsetInSector], Temp[N], Diff );
    Inc( FOffsetInSector, Diff );
    Inc( Result, Diff );
  End;
End;

Function TBufferedReadWrite.Write( Const Buffer; Count: LongInt ): LongInt;
Var
  N, Diff: TxNativeInt;
  { I cannot read more data than dsMaxStringSize chars at a time (take care with text) }
  Temp: Array[0..dsMaxStringSize - 1] Of Char Absolute Buffer;

  Procedure WriteFullBuffer;
  Begin
    FStream.Seek( FCurrentSector * FSizeOfSector, 0 );
    FStream.Write( PBuffer^, FSizeOfSector );
    Inc( FCurrentSector );
    FMustFlush := True; { is a flag indicating that the current buffer is not begin written yet }
    FOffsetInSector := 0;
  End;

Begin
  Result := 0;
  If ( Count < 1 ) Or ( Count > SizeOf( Temp ) ) Then
    Exit;
  If FOffsetInSector + Count <= FValidBytesInSector Then
  Begin
    { in the buffer is full data }
    Move( Buffer, PBuffer^[FOffsetInSector], Count );
    Inc( FOffsetInSector, Count );
    FMustFlush := True;
    Result := Count;
  End
  Else
  Begin
    { in the current buffer will write partial data }
    N := FValidBytesInSector - FOffsetInSector;
    Move( Buffer, PBuffer^[FOffsetInSector], N );
    Result := N;
    WriteFullBuffer;
    Diff := Count - N;
    Move( Temp[N], PBuffer^[FOffsetInSector], Diff );
    Inc( FOffsetInSector, Diff );
    Inc( Result, Diff );
    //Result := Count;
  End;
End;

Procedure TBufferedReadWrite.FlushBuffer;
Begin
  If ( FCurrentSector >= 0 ) And FMustFlush And ( FOffsetInSector > 0 ) Then
  Begin
    FStream.Seek( FCurrentSector * FSizeOfSector, 0 );
    FStream.Write( PBuffer^, FOffsetInSector );
    FMustFlush := False;
  End;
End;

{ miscellaneous procedures }

Function GetTemporaryFileName( Const Prefix: TxNativeString ): TxNativeString;
Var
  TempPath: Array[0..1023] Of TxNativeChar;
  FileName: Array[0..1023] Of TxNativeChar;
Begin
  GetTempPath( 1023, TempPath );
  GetTempFileName( TempPath, TxNativePChar( Prefix ), 0, FileName );
  result := FileName;
End;

Function TrimSquareBrackets( Const Ident: TxNativeString ): TxNativeString;
Begin
  Result := Ident;
  If Length( Ident ) < 2 Then Exit;
  If Not ( ( Ident[1] = '[' ) And ( Ident[Length( Ident )] = ']' ) ) Then Exit;
  result := Copy( Ident, 2, Length( Ident ) - 2 );
End;

Function AddSquareBrackets( Const Ident: TxNativeString ): TxNativeString;
Var
  I: Integer;
Begin
  Result := Ident;
  if ( Length(Ident) > 1 ) And ( Ident[1] = '[' ) And
     ( Ident[Length(Ident)] = ']' ) then Exit;
  for I:= Low(qexprlex.rwords) to high(qexprlex.rwords) do
  begin
    if AnsiCompareText(qexprlex.rwords[I].rword, Ident) = 0 then
    begin
      Result := '[' + Ident + ']';
      Exit;
    end;
  end;
  For I := 1 To Length( Ident ) Do
  Begin
    if (I = 1) and CharInSet(Ident[I], ['0'..'9']) then
    begin
      Result := '[' + Ident + ']';
      Exit;
    end else If Not (CharInSet(Ident[I], ['A'..'Z', 'a'..'z', '0'..'9', '_']{$IFDEF UNICODE}, CONST_XQ_ucIsAlpha{$ENDIF})) Then
    Begin
      Result := '[' + Ident + ']';
      Exit;
    End;
  End;
End;

{ adds square brackes to full qualified fields table.fieldname }
Function QualifiedFieldAddSquareBrackets( Const Ident: TxNativeString ): TxNativeString;
Var
  P: Integer;
Begin
  P:= Pos('.', Ident);
  If P > 0 then
    Result:= AddSquareBrackets(Copy(Ident,1,P-1)) + '.' +
      AddSquareBrackets(Copy(Ident,P+1, Length(Ident)))
  else
    Result:= AddSquareBrackets(Ident);
End;

Function XQStringIsUnicode( const aString: {$IFDEF UNICODE}String{$ELSE}TxNativeWideString{$ENDIF} ): boolean;{$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
var _count: Integer;
begin
 result := false;
 for _count := 01 to Length( aString ) do
 begin
  result := (Integer( aString[_count] ) > $FF);
  if result then
     Break;
 end;
end;

Function XQStripTableFieldName( const aTableFieldName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};
                                const aTrimSquareBrakets: boolean;
                                  var   aTableName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};
                                  var   aFieldName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF} ): boolean;{$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
var P: Integer;
begin
  P:= AnsiPos('.', aTableFieldName);
  If P > 0 then
  begin
   aTableName := Copy(aTableName,1,P-1);
   aFieldName := Copy(aTableFieldName,P+1, Length(aTableFieldName));
  end
  else
  begin
   aTableName := '';
   aFieldName := aTableFieldName;
  end;
  if  aTrimSquareBrakets then
  begin
   aTableName := TrimSquareBrackets(aTableName);
   aFieldName := TrimSquareBrackets(aFieldName);
  end;
  result := (aTableName <> '') or (aFieldName <> '')
end;

Function XQExtractTableName( const aTableFieldName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};
                             const aTrimSquareBrakets: boolean=true):{$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};{$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
var  aFieldName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};
begin
 XQStripTableFieldName(aTableFieldName, aTrimSquareBrakets, Result, aFieldName);
end;

Function XQExtractFieldName( const aTableFieldName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};
                               const aTrimSquareBrakets: boolean=true):{$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};{$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
var  aTableName: {$IFDEF UNICODE}string{$ELSE}TxNativeWideString{$ENDIF};
begin
 XQStripTableFieldName(aTableFieldName, aTrimSquareBrakets, aTableName, Result);
end;

End.

