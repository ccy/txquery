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
{$IFDEF LEVEL6}
  , Variants
{$ENDIF}
  ;

Type

  {Buffered read/write class - used for fast sequencial reads/writes}
  PCharArray = ^TCharArray;
  TCharArray = Array[0..0] Of Char;

  TBufferedReadWrite = Class( TStream )
  Private
    FStream: TStream;
    FValidBytesInSector: Integer;
    FCurrentSector: Integer;
    FOffsetInSector: Integer;
    PBuffer: PCharArray;
    FSizeOfSector: Integer;
    FFreeStream: Boolean;
    FMustFlush: Boolean;
    Procedure FlushBuffer;
  Public
    Constructor Create( F: TStream; FreeStream: Boolean; BuffSize: Integer );
    Destructor Destroy; Override;
    Function Read( Var Buffer; Count: Longint ): Longint; Override;
    Function Seek( Offset: Longint; Origin: Word ): Longint; Override;
    Function Write( Const Buffer; Count: Longint ): Longint; Override;
    Procedure ResetPos;
  End;

  { Miscelaneous routines }
  Function TrimSquareBrackets( Const Ident: String ): String;
  Function AddSquareBrackets( Const Ident: String ): String;
  Function QualifiedFieldAddSquareBrackets( Const Ident: String ): String;
  Procedure FreeObject( Var Obj );
  Procedure ReplaceString( Var Work: String; Const Old, NNew: String );
  Function TrimCRLF( Const s: String ): String;
  Function MessageToUser( Const Msg: String; Atype: TMsgDlgtype ): Word;
  Function Max( Const A, B: Double ): Double;
  Function Min( Const A, B: Double ): Double;
  Function IMax( A, B: Integer ): Integer;
  Function IMin( A, B: Integer ): Integer;
  {$IFDEF FALSE}
  Function GetRecordNumber( DataSet: TDataSet ): Integer;
  Procedure SetRecordNumber( DataSet: TDataSet; RecNum: Integer );
  {$ENDIF}
  {$IFDEF XQDEMO}
  Function IsDelphiRunning: boolean;
  {$ENDIF}
  Function GetTemporaryFileName( Const Prefix: String ): String;
  Function AddSlash( Const Path: String ): String;
  Function RemoveSlash( Const Path: String ): String;
  Function Field2Exprtype( Datatype: TFieldtype ): TExprtype;
  Function SizeOfExprType( ExprType: TExprtype ): Integer;
  Function SizeOfFieldType( FieldType: TFieldtype ): Integer;
  Function RemoveStrDelim( Const S: String ): String;
  Function CountChars( const s: string; Ch: Char ): Integer;
  Function VarMin( const Value1, Value2: Variant): Variant;
  Function VarMax( const Value1, Value2: Variant): Variant;
  Function AddCorrectStrDelim(Const S: String) : String;

Implementation

Uses
  xqbase, xquery, xqconsts, qexprlex, CnvStrUtils, xqtypes;

Function VarMin( const Value1, Value2: Variant): Variant;
Begin
  If Value1 < Value2 then Result:= Value1 Else Result:= Value2;
End;

Function VarMax( const Value1, Value2: Variant): Variant;
Begin
  If Value1 > Value2 then Result:= Value1 Else Result:= Value2;
End;


// miscelaneous

Function Field2Exprtype( Datatype: TFieldtype ): TExprtype;
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
      ftFloat, ftCurrency, ftBCD, {$IFDEF LEVEL6}ftFMTBcd, {$ENDIF}ftDate, ftTime, ftDateTime:
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

Function SizeOfExprType( ExprType: TExprtype ):Integer ;
begin
 Result := SizeOf(Char);
   Case ExprType Of
    ttString: Result := SizeOf(AnsiChar);
    {$IFDEF LEVEL4}
    ttWideString: Result := SizeOf(WideChar);
    {$ENDIF}
    ttFloat: Result := SizeOf(Double);
    ttLargeInt: Result := SizeOf(Int64);
    ttInteger: Result := SizeOf(Integer);
   End;
end;

Function SizeOfFieldType( FieldType: TFieldType ):Integer ;
Begin
  Case FieldType Of
{$IFDEF LEVEL4}
    ftFixedChar,
{$ENDIF}
    ftString:
      Result := SizeOf(AnsiChar); { patched by fduenas }
    // this fixes some Float field values displayed wrongly
   {$IFDEF LEVEL4}
    ftWideString, ftFixedWideChar:
        Result := SizeOf(WideChar); { patched by fduenas }
   {$ENDIF}
    ftSmallInt:
      Result := SizeOf(SmallInt);
   {$IFDEF Delphi2009Up}
    ftShortInt:
      Result := SizeOf(ShortInt);
   {$ENDIF}
    ftInteger:
      Result := SizeOf(Integer);
{$IFDEF LEVEL4}
    ftLargeint:
      Result := SizeOf(Int64);
{$ENDIF}
    ftWord:
      Result := SizeOf(Word);
    ftBoolean:
      Result := SizeOf(WordBool);
    ftFloat:
      Result := SizeOf(Double);
    ftCurrency:
      Result := SizeOf(Double);
    ftDate:
      Result := SizeOf(TDateTimeRec);
    ftTime:
      Result := SizeOf(TDateTimeRec);
    ftDateTime:
      Result := SizeOf(TDateTimeRec);
    ftAutoInc:
      Result := SizeOf(Integer);
    ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle, {$IFDEF Delphi2009Up}ftStream, {$ENDIF}
      ftTypedBinary, ftBytes, ftVarBytes {$IFDEF Delphi2006Up}, ftWideMemo  {$ENDIF}:
      Result := SizeOf(Pointer);
    ftBCD{$IFDEF LEVEL6}, ftFMTBcd {$ENDIF}:
      Result := 34;
  Else
    Result := 0;
  End;
End;

{
procedure LeftSet(var S1: String; const S2: String);
var
  N,N1,N2: Integer;
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

Procedure ReplaceString( Var Work: String; Const Old, NNew: String );
Var
  OldLen, p: Integer;
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

Function TrimCRLF( Const s: String ): String;
Begin
  result := Trim( s );
  ReplaceString( result, #13, '' );
  ReplaceString( result, #10, '' );
  ReplaceString( result, #11, '' ); {added by fduenas}
End;

Function MessageToUser( Const Msg: String; Atype: TMsgDlgtype ): Word;
Begin
  Result := MessageDlg( Msg, Atype, [mbOk], 0 );
End;

Function IMax( A, B: Integer ): Integer;
Begin
  If A > B Then
    Result := A
  Else
    Result := B;
End;

Function IMin( A, B: Integer ): Integer;
Begin
  If A < B Then
    Result := A
  Else
    Result := B;
End;

Function Max( Const A, B: Double ): Double;
Begin
  If A > B Then
    Result := A
  Else
    Result := B;
End;

Function Min( Const A, B: Double ): Double;
Begin
  If A < B Then
    Result := A
  Else
    Result := B;
End;

Function RemoveStrDelim( Const S: String ): String;
Begin
  If ( Length( S ) >= 2 ) And
    CharInSet( S[1], xqtypes.SQuote ) And CharInSet( S[Length( S )], xqtypes.SQuote ) Then
    Result := Copy( S, 2, Length( S ) - 2 )
  Else
    Result := S;
End;

Function AddCorrectStrDelim(Const S: String) : String;
Begin
  if AnsiPos('''', S) > 0 then
    Result := '"' + S + '"'
  else
    Result := '''' + S + '''';
End;

Function CountChars( const s: string; Ch: Char ): Integer;
var
  I: Integer;
Begin
  Result:= 0;
  for I:= 1 to Length(s) do
    if s[I] = Ch then Inc(Result);
End;

{$IFDEF XQDEMO}
Const
  A2 = 'TAlignPalette';
  A3 = 'TPropertyInspector';
  A4 = 'TAppBuilder';

Function IsDelphiRunning: boolean;
Var
  H2, {H3, }H4: Hwnd;
Begin
  H2 := FindWindow( A2, Nil );
  //H3 := FindWindow( A3, Nil );
  H4 := FindWindow( A4, Nil );
  Result := ( H2 <> 0 ) {And ( H3 <> 0 )} And ( H4 <> 0 );
End;
{$ENDIF}

Function AddSlash( Const Path: String ): String;
Begin
  result := Path;
  If ( Length( result ) > 0 ) And ( result[length( result )] <> '\' ) Then
    result := result + '\'
End;

Function RemoveSlash( Const Path: String ): String;
Var
  rlen: integer;
Begin
  result := Path;
  rlen := length( result );
  If ( rlen > 0 ) And ( result[rlen] = '\' ) Then
    Delete( result, rlen, 1 );
End;

{$IFDEF FALSE}

Function GetRecordNumber( DataSet: TDataSet ): Integer;
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

Procedure SetRecordNumber( DataSet: TDataSet; RecNum: Integer );
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

Constructor TBufferedReadWrite.Create( F: TStream; FreeStream: Boolean; BuffSize: integer );
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

Function TBufferedReadWrite.Seek( Offset: Longint; Origin: Word ): Longint;
Var
  TmpSector: LongInt;
Begin
  Result := 0;
  If Origin = soFromBeginning Then
    { from start of file }
    Result := Offset
  Else If Origin = soFromCurrent Then
    { from current position }
    Result := ( FCurrentSector * FSizeOfSector + FOffsetInSector ) + Offset
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

Function TBufferedReadWrite.Read( Var Buffer; Count: Longint ): Longint;
Var
  N, Diff: Longint;
  { I cannot read more data than dsMaxStringSize chars at a time (take care with text) }
  Temp: Array[0..dsMaxStringSize - 1] Of char Absolute Buffer;

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

Function TBufferedReadWrite.Write( Const Buffer; Count: Longint ): Longint;
Var
  N, Diff: Longint;
  { I cannot read more data than dsMaxStringSize chars at a time (take care with text) }
  Temp: Array[0..dsMaxStringSize - 1] Of char Absolute Buffer;

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

Function GetTemporaryFileName( Const Prefix: String ): String;
Var
  TempPath: Array[0..1023] Of char;
  FileName: Array[0..1023] Of char;
Begin
  GetTempPath( 1023, TempPath );
  GetTempFileName( TempPath, PChar( Prefix ), 0, FileName );
  result := FileName;
End;

Function TrimSquareBrackets( Const Ident: String ): String;
Begin
  Result := Ident;
  If Length( Ident ) < 2 Then Exit;
  If Not ( ( Ident[1] = '[' ) And ( Ident[Length( Ident )] = ']' ) ) Then Exit;
  result := Copy( Ident, 2, Length( Ident ) - 2 );
End;

Function AddSquareBrackets( Const Ident: String ): String;
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
    end else If Not CharInSet( Ident[I], ['A'..'Z', 'a'..'z', '0'..'9', '_'] ) Then
    Begin
      Result := '[' + Ident + ']';
      Exit;
    End;
  End;
End;

{ adds square brackes to full qualified fields table.fieldname }
Function QualifiedFieldAddSquareBrackets( Const Ident: String ): String;
Var
  P: Integer;
Begin
  P:= AnsiPos('.', Ident);
  If P > 0 then
    Result:= AddSquareBrackets(Copy(Ident,1,P-1)) + '.' +
      AddSquareBrackets(Copy(Ident,P+1, Length(Ident)))
  else
    Result:= AddSquareBrackets(Ident);
End;

Initialization

End.

