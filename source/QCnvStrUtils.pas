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
{   The Original Code is: CnvStrUtils.pas                                     }
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

unit QCnvStrUtils;

{$I XQ_FLAG.INC}
interface

uses
  SysUtils, Classes, XQTypes {$IFDEF UNICODE}, Character{$ENDIF};

type
  TxStringArray = Array of TxNativeString;
 { TSysCharSet = set of AnsiChar;} { patched by ccy }
  {$IFNDEF Delphi7Up}
    TSysCharSet = Set of AnsiChar;
  {$ENDIF}
  TAdvStringList = class (TxNativeTStringList)
  private
    FTokenSeparator: TxNativeChar;
    FQuoteChar: TxNativeChar;
    function GetTokenizedText: TxNativeString;
    procedure SetTokenizedText(const Value: TxNativeString);
  public
    constructor Create;
    property TokenizedText: TxNativeString read GetTokenizedText write SetTokenizedText;
    property TokenSeparator: TxNativeChar read FTokenSeparator write FTokenSeparator;
    property QuoteChar: TxNativeChar read FQuoteChar write FQuoteChar;
  end;

function RemoveEscapeChars(const s : TxNativeString; EscChar : TxNativeChar): TxNativeString;
function TextToBool(const Value : String) : boolean;
function BoolToText(Value : boolean) : Char;
function EliminateWhiteSpaces(const s : TxNativeString) : TxNativeString;
function EliminateChars(const s : TxNativeString; const Chars : TSysCharSet) : TxNativeString;
function LastPartOfName(const s : TxNativeString) : TxNativeString;
function FirstPartOfName(const s : TxNativeString): TxNativeString;
procedure MixTStrings(Source, Dest : TxNativeTStrings; FromIndex : Integer = 0);
function CommaList(const Items : TxNativeString): TxNativeString;
function ListOfItems(const Items : array of TxNativeString): TxNativeString;
procedure RemoveBlankItems(List : TxNativeTStringList);
function FirstNonEmptyString(const Strs : array of TxNativeString): TxNativeString;
function AddStrings(const Items : array of TxNativeString): TxNativeString; overload;
function AddStrings(const Items, Items2 : array of TxNativeString): TxNativeString; overload;
function IndexOf(const Items : array of TxNativeString; const Item : TxNativeString;
    CaseSensitive : boolean = false): Integer;

function HexDigitToInt(Ch : Char) : integer;
function HexToInt(Value : String) : integer;
function StringToHex(const s : String): String;
function HexToString(const s : String): String;

function StringListToTStringArray(l : TxNativeTStrings): TxStringArray;
function StrToIntEx(const s : String): Integer;
procedure StrCount(const s : TxNativeString; var Alpha, Numeric : Integer);

{$if CompilerVersion <= 18.5}
function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean; overload; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
function CharInSet(C: WideChar; const CharSet: TSysCharSet): Boolean; overload; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
{$ifend}

Function XQStringUpperCase( const aString: String ): String; Overload;
Function XQStringLowerCase( const aString: String ): String; Overload;
{$IFDEF LEVEL4}
Function XQStringUpperCase( const aString: WideString ): WideString; Overload;
Function XQStringLowerCase( const aString: WideString ): WideString; Overload;
{$ENDIF}

function XQEscapeString( const aString:TxNativeString; aSetOfchar: TSysCharSet;
 aUseCharCode: Boolean=true; aEscapeFMT: TxNativeString='Chr(%s)'): TxNativeString;



{$IFDEF UNICODE}
type
 TUniCodeCategorySet = Set of TUnicodeCategory;

 function CharInSet(C: AnsiChar; const CharSet: TSysCharSet{$IFDEF UNICODE}; UnicodeCategories: TUniCodeCategorySet{$ENDIF}): Boolean; overload; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
 function CharInSet(C: WideChar; const CharSet: TSysCharSet{$IFDEF UNICODE}; UnicodeCategories: TUniCodeCategorySet{$ENDIF}): Boolean; overload; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
{$ENDIF}

{$IFDEF UNICODE}   {This will allow the old parser to allow Unicode letters to be evaluated}
const
  CONST_XQ_ucIsLetter = [TUnicodeCategory.ucLowercaseLetter,
                         TUnicodeCategory.ucModifierLetter,
                         TUnicodeCategory.ucOtherLetter,
                         TUnicodeCategory.ucTitlecaseLetter,
                         TUnicodeCategory.ucUppercaseLetter,
                         TUnicodeCategory.ucNonSpacingMark];
  CONST_XQ_ucIsNumber = [TUnicodeCategory.ucDecimalNumber];
  CONST_XQ_ucIsDigit  = [TUnicodeCategory.ucDecimalNumber];
  CONST_XQ_ucIsAlpha  = CONST_XQ_ucIsLetter+CONST_XQ_ucIsNumber;
{$ENDIF}
implementation

uses
  Windows;

const
  _TextToBool : array ['0'..'1'] of Boolean = (False, True);
  _BoolToText : array [False..True] of Char = ('0', '1');

function RemoveEscapeChars(const s : TxNativeString; EscChar : TxNativeChar): TxNativeString;
var
  j : Integer;
begin
  Result := s;
  repeat
    j := {$IFNDEF XQ_USE_WIDESTRINGS}AnsiPos{$ELSE}Pos{$ENDIF}(EscChar, Result);
    if j > 0
      then System.Delete (Result, j, 2);
  until j <= 0;
end;

function TextToBool(const Value : String) : boolean;
begin
  if Trim (Value) <> EmptyStr then
    Result := _TextToBool[Value [1]]
  else
    Result := False;
end;

function BoolToText(Value : boolean) : Char;
begin
  Result := _BoolToText [Value];
end;

function EliminateChars(const s : TxNativeString; const chars : TSysCharSet) : TxNativeString;
var
  i : Integer;
begin
  Result := EmptyStr;
  for i := 1 to Length (s) do
    if not CharInSet(s [i], chars)
      then Result := Result + s [i];
end;

function EliminateWhiteSpaces (const s : TxNativeString) : TxNativeString;
begin
  Result := EliminateChars (s, [' ', #255, #13, #10, #11]); {added by fduenas: added the #11 char}
end;

function LastPartOfName (const s : TxNativeString) : TxNativeString;
var
  i : Integer;
begin
  Result := EmptyStr;
  for i := Length (s) downto 1 do
   if s [i] = '.'
     then
     begin
       Result := system.Copy (s, i + 1, Length (s) - i);
       Exit;
     end;
  Result := s;
end;

procedure MixTStrings(Source, Dest : TxNativeTStrings; FromIndex : Integer = 0);
var
  i, j : Integer;
begin
  if (Source <> nil) and (Dest <> nil)
    then
    begin
      Dest.BeginUpdate;
      try
        for i := FromIndex to Source.Count - 1 do
          begin
            j := Dest.IndexOfName (Source.Names[i]);
            if j < 0
              then
              begin
                j := Dest.IndexOf (Source [i]);
                if j < 0
                  then Dest.Add (Source [i]);
              end;
          end;
      finally
        Dest.EndUpdate;
      end;
    end;
end;

function CommaList(const Items : TxNativeString): TxNativeString;
begin
  if Items <> ''
    then Result := ',' + Items
    else Result := '';
end;

function ListOfItems(const Items : array of TxNativeString): TxNativeString;
var
  i : integer;
begin
  Result := '';
  for i := Low(Items) to High(Items) do
    Result := Result + Items [i] + ',';
  system.Delete (Result, Length (Result), 1);
end;

procedure RemoveBlankItems(List : TxNativeTStringList);
var
  i : Integer;
begin
  List.BeginUpdate;
  try
    i := 0;
    while i < List.Count do
      if Trim (List [i]) = EmptyStr
        then List.Delete (i)
        else Inc (i);
  finally
    List.EndUpdate;
  end;
end;

function FirstNonEmptyString(const Strs : array of TxNativeString): TxNativeString;
var
  i : Integer;
begin
  Result := '';
  for i := Low (Strs) to High (Strs) do
    if Strs [i] <> ''
      then
      begin
        Result := Strs [i];
        Exit;
      end;
end;

function AddStrings(const Items : array of TxNativeString): TxNativeString;
var
  i : integer;
begin
  Result := '';
  for i := Low (Items) to High (Items) do
    Result := Result + Items[i];
end;

function AddStrings(const Items, Items2 : array of TxNativeString): TxNativeString;
var
  i : integer;
begin
  Result := '';
  for i := Low (Items) to High (Items) do
    Result := Result + Items [i] + Items2 [i];
end;

function IndexOf(const Items : array of TxNativeString; const Item : TxNativeString;
    CaseSensitive : boolean = false): Integer;
var
  i : Integer;
  UpItem : string;
begin
  if not CaseSensitive
    then UpItem := UpperCase (Item)
    else UpItem := '';
  Result := -1;
  for i := Low (Items) to High (Items) do
    if (CaseSensitive and (Items [i] = Item)) or
       ((not CaseSensitive) and (UpperCase (Items [i]) = UpItem))
      then
      begin
        Result := i;
        Exit;
      end;
end;

function HexDigitToInt(Ch : Char) : integer;
var
  sb : byte;
begin
  sb := ord(ch);
  if (sb >= ord('A')) and (sb <= ord('F')) then
    Result := sb - ord('A') + 10
  else if (sb >= ord('a')) and (sb <= ord('f')) then
    Result := sb - ord('a') + 10
  else if (sb >= ord('0')) and (sb <= ord('9')) then
    Result := sb - ord('0')
  else
    raise Exception.Create(ch + ' is not a hex digit');
end;

function HexToInt(Value : string) : integer;
var
  i : integer;
  base : integer;
begin
  Result := 0;
  Value := UpperCase(Value);
  base := 1;
  for i := Length(Value) downto 1 do
  begin
    Result := Result + HexDigitToInt(Value[i])*base;
    base := base*16
  end;
end;

function StringToHex(const s : String): String;
var
  j : Integer;
  Hex : string;
begin
  SetLength(Result, Length(s) * 2);
  for j := 1 to Length (s) do
    begin
      Hex := IntToHex (Ord (s [j]), 2);
      Move(Hex[1], Result [(j - 1) * 2 + 1], 2);
    end;
end;

function HexToString(const s : String): String;
var
  i : Integer;
  c : Char;
  Hex : string;
begin
  SetLength(Hex, 2);
  SetLength(Result, Length (s) div 2);
  i := 1;
  while i <= Length (s)  do
    begin
      Move(s [i], Hex [1], 2);
      c := Char(HexToInt(Hex));
      Move(c, Result [(i + 1) div 2], 1);
      Inc(i, 2);
    end;
end;

function FirstPartOfName(const s : TxNativeString): TxNativeString;
var
  i : Integer;
begin
  Result := '';
  for i := 1 to Length (s) do
   if s [i] = '.'
     then
     begin
       Result := system.Copy (s, 1, i - 1);
       Exit;
     end;
  Result := s;
end;

function StringListToTStringArray(l : TxNativeTStrings): TxStringArray;
var
  i : Integer;
begin
  SetLength (Result, l.Count);
  for i := 0 to l.Count - 1 do
    Result [i] := l [i];
end;

function StrToIntEx(const s : String): Integer;
begin
  if s <> ''
    then
    try
      Result := StrToInt(s);
    except
      on EConvertError do Result := 0;
    end
    else Result := 0;
end;

procedure StrCount(const s : TxNativeString; var Alpha, Numeric : Integer);
var
  i : Integer;
begin
  Alpha := 0;
  Numeric := 0;
  for i := 0 to Length(s) do
    if CharInSet(s [i], ['0'..'9'])
      then Inc (Numeric)
      else Inc (Alpha);
end;

{$if CompilerVersion <= 18.5}
function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean; overload; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
begin
  Result := (C in CharSet);
end;
function CharInSet(C: WideChar; const CharSet: TSysCharSet): Boolean; overload; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
begin
  Result := (AnsiChar(C) in CharSet);
end;
{$ifend}

{$IFDEF UNICODE}
 function CharInSet(C: AnsiChar; const CharSet: TSysCharSet; UnicodeCategories: TUniCodeCategorySet): Boolean; overload; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
 begin
   Result := ({(UnicodeCategories<>[]) and} ({$IFDEF DelphiXE4Up}WideChar(C).GetUnicodeCategory{$ELSE}TCharacter.GetUnicodeCategory(WideChar(C)){$ENDIF} in UnicodeCategories)) or CharInSet(C, CharSet);
 end;

 function CharInSet(C: WideChar; const CharSet: TSysCharSet; UnicodeCategories: TUniCodeCategorySet): Boolean; overload; {$IFDEF XQ_USE_INLINE_METHODS}inline;{$ENDIF}
 begin
   Result := ({$IFDEF DelphiXE4Up}C.GetUnicodeCategory{$ELSE}TCharacter.GetUnicodeCategory(C){$ENDIF} in UnicodeCategories) or CharInSet(C, CharSet);
 end;
{$ENDIF}
Function XQStringUpperCase( const aString: String ): String; Overload;
{$IFDEF UNICODE}
 var _count: integer;
     _strBuilder: TStringBuilder;
{$ENDIF}
begin
{$IFDEF UNICODE}
 _strBuilder := TStringBuilder.Create;
 for _count := 1 to Length(aString) do
     _strBuilder.Append( {$IFDEF DelphiXE4Up}aString[_count].ToUpper{$ELSE}TCharacter.ToUpper(aString[_count]){$ENDIF} );
 result := _strBuilder.ToString;
 FreeAndNil(_strBuilder);
 {$ELSE}
 Result := UpperCase(aString);
{$ENDIF}
end;

Function XQStringLowerCase( const aString: String ): String; Overload;
{$IFDEF UNICODE}
 var _count: integer;
{$ENDIF}
begin
{$IFDEF UNICODE}
 result := '';
 for _count := 1 to Length(aString) do
     result := result + {$IFDEF DelphiXE4Up}aString[_count].ToLower{$ELSE}TCharacter.ToLower(aString[_count]){$ENDIF};
{$ELSE}
 Result := LowerCase(aString);
{$ENDIF}
end;

{$IFDEF LEVEL4}
Function XQStringUpperCase( const aString: WideString ): WideString; Overload;
{$IFDEF UNICODE}
 var _count: integer;
{$ENDIF}
begin
{$IFDEF UNICODE}
 result := '';
 for _count := 1 to Length(aString) do
     result := result + {$IFDEF DelphiXE4Up}aString[_count].ToUpper{$ELSE}TCharacter.ToUpper(aString[_count]){$ENDIF};
{$ELSE}
 Result := WideUpperCase(aString);
{$ENDIF}
end;

Function XQStringLowerCase( const aString: WideString ): WideString; Overload;
{$IFDEF UNICODE}
 var _count: integer;
{$ENDIF}
begin
{$IFDEF UNICODE}
 result := '';
 for _count := 1 to Length(aString) do
     result := result + {$IFDEF DelphiXE4Up}aString[_count].ToLower{$ELSE}TCharacter.ToLower(aString[_count]){$ENDIF};
{$ELSE}
 Result := WideLowerCase(aString);
{$ENDIF}
end;
{$ENDIF}

function XQEscapeString( const aString:TxNativeString; aSetOfchar: TSysCharSet;
 aUseCharCode: Boolean=true; aEscapeFMT: TxNativeString='Chr(%s)'): TxNativeString;
begin
 aEscapeFMT := '';
end;
{ TAdvStringList }
constructor TAdvStringList.Create;
begin
  inherited Create;
  FQuoteChar := '"';
  FTokenSeparator := ',';
end;

function TAdvStringList.GetTokenizedText:TxNativeString;
var
  S: TxNativeString;
  P: TxNativePChar;
  I, Count: Integer;
begin
  Count := GetCount;
  if (Count = 1) and (Get(0) = '')
    then Result := FQuoteChar + FQuoteChar
    else
    begin
      Result := '';
      for I := 0 to Count - 1 do
        begin
          S := Get(I);
          P := TxNativePChar(S);
          while not CharInSet(P^, [#0, FQuoteChar, FTokenSeparator]) do
            P := CharNext(P);
          if P^ <> #0
            then S := AnsiQuotedStr(S, FQuoteChar); {previous was ANSI: fduenas}
          Result := Result + S + FTokenSeparator;
        end;
      System.Delete(Result, Length(Result), 1);
    end;
end;

procedure TAdvStringList.SetTokenizedText(const Value: TxNativeString);
var
  P, P1: TxNativePChar;
  S: TxNativeString;
begin
  BeginUpdate;
  try
    Clear;
    P := TxNativePChar(Value);
    while P^ <> #0 do
      begin
        if P^ = FQuoteChar
          then S := AnsiExtractQuotedStr(P, FQuoteChar)
          else
          begin
            P1 := P;
            while (P^ <> #0) and (P^ <> FTokenSeparator) do
              P := CharNext(P);
            SetString(S, P1, P - P1);
          end;
        Add(S);
        while P^ = FTokenSeparator do
          P := CharNext(P);
        if P^ = FTokenSeparator
          then
          repeat
            P := CharNext(P);
          until P^ <> FTokenSeparator;
      end;
  finally
    EndUpdate;
  end;
end;

end.
