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
{   The Original Code is: QFormatSettings.pas                                 }
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

unit QFormatSettings;
{$I XQ_FLAG.INC}
interface

uses Classes, SysUtils{$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}, SyncObjs{$ENDIF};

Type
{$IFNDEF LEVEL7}  {Delphi 6 or older}
  { from SysUtils }
  TFormatSettings = record
    CurrencyString: string;
    CurrencyFormat: Byte;
    CurrencyDecimals: Byte;
    DateSeparator: Char;
    TimeSeparator: Char;
    ListSeparator: Char;
    ShortDateFormat: string;
    LongDateFormat: string;
    TimeAMString: string;
    TimePMString: string;
    ShortTimeFormat: string;
    LongTimeFormat: string;
    ShortMonthNames: array[1..12] of string;
    LongMonthNames: array[1..12] of string;
    ShortDayNames: array[1..7] of string;
    LongDayNames: array[1..7] of string;
    ThousandSeparator: Char;
    DecimalSeparator: Char;
    TwoDigitYearCenturyWindow: Word;
    NegCurrFormat: Byte;
  end;
{$ENDIF}
  {Persistent Class To Mimic TFormatSettings Record,  that can be used within a
   component to save/load settings within a DFM, or anyother streaming system}
  TQCustomFormatSettings = Class( TPersistent )
  protected
    fAttachedSettings: TQCustomFormatSettings;
    fInnerFormatSettings: TFormatSettings;
    fOwner: TObject;
  protected
    function GetCurrencyDecimals: Byte;
    function GetCurrencyFormat: Byte;
    function GetCurrencyString: string;
    function GetDateSeparator: Char;
    function GetDecimalSeparator: Char;
    function GetListSeparator: Char;
    function GetLongDateFormat: string;
    function GetLongDayNames(aIndex:Integer): string;
    function GetLongMonthNames(aIndex:Integer): string;
    function GetLongTimeFormat: string;
    function GetNegCurrFormat: Byte;
    function GetShortDateFormat: string;
    function GetShortDayNames(aIndex:Integer): string;
    function GetShortMonthNames(aIndex:Integer): string;
    function GetShortTimeFormat: string;
    function GetThousandSeparator: Char;
    function GetTimeAMString: string;
    function GetTimePMString: string;
    function GetTimeSeparator: Char;
    function GetTwoDigitYearCenturyWindow: Word;
    procedure SetCurrencyDecimals(const Value: Byte); virtual;
    procedure SetCurrencyFormat(const Value: Byte); virtual;
    procedure SetCurrencyString(const Value: string); virtual;
    procedure SetDateSeparator(const Value: Char); virtual;
    procedure SetDecimalSeparator(const Value: Char); virtual;
    procedure SetListSeparator(const Value: Char); virtual;
    procedure SetLongDateFormat(const Value: string); virtual;
    procedure SetLongDayNames(aIndex:Integer; const Value: string); virtual;
    procedure SetLongMonthNames(aIndex:Integer; const Value: string); virtual;
    procedure SetLongTimeFormat(const Value: string); virtual;
    procedure SetNegCurrFormat(const Value: Byte); virtual;
    procedure SetShortDateFormat(const Value: string); virtual;
    procedure SetShortDayNames(aIndex:Integer; const Value: string); virtual;
    procedure SetShortMonthNames(aIndex:Integer; const Value: string); virtual;
    procedure SetShortTimeFormat(const Value: string);  virtual;
    procedure SetThousandSeparator(const Value: Char); virtual;
    procedure SetTimeAMString(const Value: string); virtual;
    procedure SetTimePMString(const Value: string); virtual;
    procedure SetTimeSeparator(const Value: Char); virtual;
    procedure SetTwoDigitYearCenturyWindow(const Value: Word); virtual;
  protected
    property CurrencyString: string read GetCurrencyString write SetCurrencyString;
    property CurrencyFormat: Byte read GetCurrencyFormat write SetCurrencyFormat;
    property CurrencyDecimals: Byte read GetCurrencyDecimals write SetCurrencyDecimals;
    property DateSeparator: Char read GetDateSeparator write SetDateSeparator;
    property TimeSeparator: Char read GetTimeSeparator write SetTimeSeparator;
    property ListSeparator: Char read GetListSeparator write SetListSeparator;
    property ShortDateFormat: string read GetShortDateFormat write SetShortDateFormat;
    property LongDateFormat: string read GetLongDateFormat write SetLongDateFormat;
    property TimeAMString: string read GetTimeAMString write SetTimeAMString;
    property TimePMString: string read GetTimePMString write SetTimePMString;
    property ShortTimeFormat: string read GetShortTimeFormat write SetShortTimeFormat;
    property LongTimeFormat: string read GetLongTimeFormat write SetLongTimeFormat;
    property ShortMonthNames[aIndex: Integer]: string read GetShortMonthNames write SetShortMonthNames;
    property LongMonthNames[aIndex: Integer]: string read GetLongMonthNames write SetLongMonthNames;
    property ShortDayNames[aIndex: Integer]: string read GetShortDayNames write SetShortDayNames;
    property LongDayNames[aIndex: Integer]: string read GetLongDayNames write SetLongDayNames;
    property ThousandSeparator: Char read GetThousandSeparator write SetThousandSeparator;
    property DecimalSeparator: Char read GetDecimalSeparator write SetDecimalSeparator;
    property TwoDigitYearCenturyWindow: Word read GetTwoDigitYearCenturyWindow write SetTwoDigitYearCenturyWindow;
    property NegCurrFormat: Byte read GetNegCurrFormat write SetNegCurrFormat;
  public
    constructor Create( aOwner: TObject; aInitSettings: boolean=true );  overload; virtual;
   {$IFDEF Delphi7Up}
    constructor Create( aOwner: TObject{$IFDEF Delphi7Up}; aLocale: {$IFDEF DelphiXEUp}string{$ELSE}Cardinal{$ENDIF}{$ENDIF} ); overload;
   {$ENDIF}
    destructor Destroy; override;
    function GetSettings: TFormatSettings;
    function SetSettings( aNewFormatSettings: TFormatSettings ): TFormatSettings;
    function InitSettings({$IFDEF Delphi7Up} aLocale: {$IFDEF DelphiXEUp}string{$ELSE}Cardinal{$ENDIF}{$ENDIF} ): TFormatSettings;
    function AttachTo( aFormatSettings: TQCustomFormatSettings ): TQCustomFormatSettings;
    function IsAttached: Boolean;
    procedure RefreshAttachments;
  end;

  Procedure RefreshSystemFormatSettings;
  Procedure RefreshRuntimeFormatSettings;
  Procedure InitializeFormatSettings( var aFormatSettings: TFormatSettings;
   aGetRuntimeSettings: boolean=false {$IFDEF Delphi7Up}; aLocale: {$IFDEF DelphiXEUp}string=''{$ELSE}Cardinal=0{$ENDIF}{$ENDIF} );
  Function SaveFormatSettings( aSaveRuntimeSettings:boolean=false ): TFormatSettings;             // Nonn
  function RestoreFormatSettings(aSFS: TFormatSettings;
   aSetRuntimeSettings: Boolean=false): TFormatSettings;   // Nonn

{$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}
Var CSQFormatSettings: TCriticalSection;
{$ENDIF}
//{$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}ThreadVar{$ELSE}Var{$ENDIF} SFQRunTimeFormatSettings:TFormatSettings;
Var SFQRunTimeFormatSettings:TFormatSettings;

resourcestring
  {Default date and number format values when creating a new txquery object
   This values are used by the SQL parser to detect dates and number values specified
   direclty in the sql Srcipt.
     Ex: SELECT * FROM Orders WHERE (InvoiceDate >= #2012-02-27#) and (InvoiceAmount >= 120.99);

   It is better to change the old default 'm/d/yyyy' to a new standard like 'yyyy-mm-dd'
   meanwhile if you want to change the default short date format you have to make
   sure to also change the Date Separator if you will not use the '/' in the ShortDateFormat string
  }
  SFmtDefaultShortDateFormat = 'm/d/yyyy';
  SFmtDefaultDateSeparator = '/';
  SFmtDefaultDecimalSeparator = '.';
  SFmtDefaultThousandSeparator = ',';
implementation

{ Initialize the Global SFFormatSettings }
procedure InitializeFormatSettings( var aFormatSettings: TFormatSettings;
   aGetRuntimeSettings: boolean {$IFDEF Delphi7Up}; aLocale: {$IFDEF DelphiXEUp}string{$ELSE}Cardinal{$ENDIF}{$ENDIF} );
{$IFNDEF LEVEL7}
 Var
   I: Integer;
{$ENDIF}
Begin
{$IFNDEF LEVEL7}
 aGetRuntimeCurrentSettings := true; {Force to get current locale, Only delphi 6 or older}
{$ENDIF}
 if aGetRuntimeSettings then
 begin
 {$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}
  CSQFormatSettings.Enter;
 {$ENDIF}
 {$IFNDEF LEVEL7}
  aFormatSettings.CurrencyFormat        := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}CurrencyFormat;
  aFormatSettings.NegCurrFormat         := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}NegCurrFormat;
  aFormatSettings.ThousandSeparator     := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}ThousandSeparator;
  aFormatSettings.DecimalSeparator      := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}DecimalSeparator;
  aFormatSettings.CurrencyDecimals      := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}CurrencyDecimals;
  aFormatSettings.DateSeparator         := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}DateSeparator;
  aFormatSettings.TimeSeparator         := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}TimeSeparator;
  aFormatSettings.ListSeparator         := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}ListSeparator;
  aFormatSettings.CurrencyString        := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}CurrencyString;
  aFormatSettings.ShortDateFormat       := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}ShortDateFormat;
  aFormatSettings.LongDateFormat        := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}LongDateFormat;
  aFormatSettings.TimeAMString          := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}TimeAMString;
  aFormatSettings.TimePMString          := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}TimePMString;
  aFormatSettings.ShortTimeFormat       := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}ShortTimeFormat;
  aFormatSettings.LongTimeFormat        := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}LongTimeFormat;
  For I := 1 To 12 Do
      aFormatSettings.ShortMonthNames[I] := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}ShortMonthNames[I];
  For I := 1 To 12 Do
      aFormatSettings.LongMonthNames[I] := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}LongMonthNames[I];
  For I := 1 To 7 Do
      aFormatSettings.ShortDayNames[I] := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}ShortDayNames[I];
  For I := 1 To 7 Do
      aFormatSettings.LongDayNames[I] :=  SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}LongDayNames[I];

  aFormatSettings.TwoDigitYearCenturyWindow := SysUtils.{$IFDEF LEVEL7}FormatSettings.{$ENDIF}TwoDigitYearCenturyWindow;
 {$ELSE}
   {$IFDEF DelphiXEUp}
     aFormatSettings := SysUtils.FormatSettings;
   {$ELSE}
     GetLocaleFormatSettings(aLocale, aFormatSettings);
   {$ENDIF}
 {$ENDIF}
 {$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}
  CSQFormatSettings.Leave;
 {$ENDIF}
 end
 else
 begin
 {$IFDEF DelphiXEUp}
   aFormatSettings := TFormatSettings.Create(aLocale);
 {$ELSE}
   GetLocaleFormatSettings(aLocale, aFormatSettings);
 {$ENDIF}
 end;
End;

{ saves the formatsettings from SysUtils }
Function SaveFormatSettings( aSaveRuntimeSettings:Boolean ): TFormatSettings;         // Nonn ...
Begin
 {$IFNDEF LEVEL7}
  aSaveRuntimeSettings := true;
 {$ENDIF}
 if aSaveRuntimeSettings then
 begin
 {$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}
   CSQFormatSettings.Enter;
 {$ENDIF}
  Result := SFQRunTimeFormatSettings;
 {$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}
  CSQFormatSettings.Leave;
 {$ENDIF}
 end
 else
 begin
  {$IFDEF LEVEL15}
   Result :=  TFormatSettings.Create;
  {$ELSE}
   GetLocaleFormatSettings(0, Result);
  {$ENDIF}
 end;
End;


Procedure RefreshRuntimeFormatSettings;
begin
 InitializeFormatSettings( SFQRunTimeFormatSettings, true);
end;

procedure RefreshSystemFormatSettings;
begin
 {$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}
  CSQFormatSettings.Enter;
 {$ENDIF}
  SysUtils.GetFormatSettings;
 {$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}
  CSQFormatSettings.Leave;
 {$ENDIF}
 InitializeFormatSettings( SFQRunTimeFormatSettings );
end;

{ restores the formatsettings in SysUtils }
function RestoreFormatSettings(aSFS: TFormatSettings;
 aSetRuntimeSettings: Boolean): TFormatSettings;
{$IFNDEF LEVEL7}
 Var
   I: Integer;
{$ENDIF}
Begin
 {$IFNDEF LEVEL7}
  aSetCurrentSettings := true;
 {$ENDIF}
 if aSetRuntimeSettings then
 begin
 {$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}
  CSQFormatSettings.Enter;
 {$ENDIF}
 {$IFNDEF LEVEL7}
  result := SFQRunTimeFormatSettings;
  SFQRunTimeFormatSettings := aSFS;
  SysUtils.CurrencyFormat        := aSFS.CurrencyFormat;
  SysUtils.NegCurrFormat         := aSFS.NegCurrFormat;
  SysUtils.ThousandSeparator     := aSFS.ThousandSeparator;
  SysUtils.DecimalSeparator      := aSFS.DecimalSeparator;
  SysUtils.CurrencyDecimals      := aSFS.CurrencyDecimals;
  SysUtils.DateSeparator         := aSFS.DateSeparator;
  SysUtils.TimeSeparator         := aSFS.TimeSeparator;
  SysUtils.ListSeparator         := aSFS.ListSeparator;
  SysUtils.CurrencyString        := aSFS.CurrencyString;
  SysUtils.ShortDateFormat       := aSFS.ShortDateFormat;
  SysUtils.LongDateFormat        := aSFS.LongDateFormat;
  SysUtils.TimeAMString          := aSFS.TimeAMString;
  SysUtils.TimePMString          := aSFS.TimePMString;
  SysUtils.ShortTimeFormat       := aSFS.ShortTimeFormat;
  SysUtils.LongTimeFormat        := aSFS.LongTimeFormat;

  For I := 1 To 12 Do
    SysUtils.ShortMonthNames[I] := aSFS.ShortMonthNames[I];
  For I := 1 To 12 Do
    SysUtils.LongMonthNames[I] := aSFS.LongMonthNames[I];
  For I := 1 To 7 Do
    SysUtils.ShortDayNames[I] := aSFS.ShortDayNames[I];
  For I := 1 To 7 Do
    SysUtils.LongDayNames[I] :=  aSFS.LongDayNames[I];

  SysUtils.TwoDigitYearCenturyWindow := aSFS.TwoDigitYearCenturyWindow;
 {$ELSE}
  {$IFDEF DelphiXEUp}
     Result := SysUtils.FormatSettings;
  {$ELSE}
  {$ENDIF}

 {$ENDIF}
 {$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}
  CSQFormatSettings.Leave;
 {$ENDIF}
 end;
  {
  SysLocale.DefaultLCID := aSFS.SL.DefaultLCID;
  SysLocale.PriLangID   := aSFS.SL.PriLangID;
  SysLocale.SubLangID   := aSFS.SL.SubLangID;
  SysLocale.FarEast     := aSFS.SL.FarEast;
  SysLocale.MiddleEast  := aSFS.SL.MiddleEast;
 }
 { TxFormatSettings }
end;
constructor TQCustomFormatSettings.Create(aOwner: TObject; aInitSettings: boolean);
begin
 inherited Create;
 fOwner := aOwner;
 if aInitSettings then
    InitializeFormatSettings(fInnerFormatSettings);
end;

function TQCustomFormatSettings.AttachTo(
  aFormatSettings: TQCustomFormatSettings): TQCustomFormatSettings;
begin
 if Assigned( fAttachedSettings ) then
    fAttachedSettings.fAttachedSettings:= nil;
 fAttachedSettings := aFormatSettings;
 if Assigned( aFormatSettings ) then
    aFormatSettings.fAttachedSettings := self;
 RefreshAttachments;
end;

constructor TQCustomFormatSettings.Create(aOwner: TObject{$IFDEF Delphi7Up}; aLocale: {$IFDEF DelphiXEUp}string{$ELSE}Cardinal{$ENDIF}{$ENDIF});
begin
 inherited Create;
 fOwner := aOwner;
 InitializeFormatSettings(fInnerFormatSettings, false{$IFDEF Delphi7Up},aLocale{$ENDIF});
end;

destructor TQCustomFormatSettings.Destroy;
begin
 fOwner := nil;
 if IsAttached then
    fAttachedSettings.fAttachedSettings := nil;
 fAttachedSettings := nil;
 inherited;
end;

function TQCustomFormatSettings.GetCurrencyDecimals: Byte;
begin
 result := fInnerFormatSettings.CurrencyDecimals;
end;

function TQCustomFormatSettings.GetCurrencyFormat: Byte;
begin
  result := fInnerFormatSettings.CurrencyFormat;
end;

function TQCustomFormatSettings.GetCurrencyString: string;
begin
  result := fInnerFormatSettings.CurrencyString
end;

function TQCustomFormatSettings.GetDateSeparator: Char;
begin
  result := fInnerFormatSettings.DateSeparator;
end;

function TQCustomFormatSettings.GetDecimalSeparator: Char;
begin
  result := fInnerFormatSettings.DecimalSeparator;
end;

function TQCustomFormatSettings.GetSettings: TFormatSettings;
begin
 result := fInnerFormatSettings;
end;

function TQCustomFormatSettings.GetListSeparator: Char;
begin
 result := fInnerFormatSettings.ListSeparator;
end;

function TQCustomFormatSettings.GetLongDateFormat: string;
begin
 result := fInnerFormatSettings.LongDateFormat;
end;

function TQCustomFormatSettings.GetLongDayNames(aIndex: Integer): string;
begin
 result := fInnerFormatSettings.LongDayNames[aIndex];
end;

function TQCustomFormatSettings.GetLongMonthNames(aIndex: Integer): string;
begin
 result := fInnerFormatSettings.LongMonthNames[aIndex];
end;

function TQCustomFormatSettings.GetLongTimeFormat: string;
begin
 result := fInnerFormatSettings.LongTimeFormat;
end;

function TQCustomFormatSettings.GetNegCurrFormat: Byte;
begin
 result := fInnerFormatSettings.NegCurrFormat;
end;

function TQCustomFormatSettings.GetShortDateFormat: string;
begin
 result := fInnerFormatSettings.ShortDateFormat;
end;

function TQCustomFormatSettings.GetShortDayNames(aIndex: Integer): string;
begin
 result := fInnerFormatSettings.ShortDayNames[aIndex];
end;

function TQCustomFormatSettings.GetShortMonthNames(aIndex: Integer): string;
begin
 result := fInnerFormatSettings.ShortMonthNames[aIndex];
end;

function TQCustomFormatSettings.GetShortTimeFormat: string;
begin
 result := fInnerFormatSettings.ShortTimeFormat;
end;

function TQCustomFormatSettings.GetThousandSeparator: Char;
begin
 result := fInnerFormatSettings.ThousandSeparator;
end;

function TQCustomFormatSettings.GetTimeAMString: string;
begin
 result := fInnerFormatSettings.TimeAMString;
end;

function TQCustomFormatSettings.GetTimePMString: string;
begin
 result := fInnerFormatSettings.TimePMString;
end;

function TQCustomFormatSettings.GetTimeSeparator: Char;
begin
 result := fInnerFormatSettings.TimeSeparator;
end;

function TQCustomFormatSettings.GetTwoDigitYearCenturyWindow: Word;
begin
 result := fInnerFormatSettings.TwoDigitYearCenturyWindow;
end;

function TQCustomFormatSettings.InitSettings({$IFDEF Delphi7Up} aLocale: {$IFDEF DelphiXEUp}string{$ELSE}Cardinal{$ENDIF}{$ENDIF} ): TFormatSettings;
begin
 Result := fInnerFormatSettings;
 InitializeFormatSettings( fInnerFormatSettings, false {$IFDEF Delphi7Up}, aLocale{$ENDIF} );
end;

function TQCustomFormatSettings.IsAttached: Boolean;
begin
 result := Assigned( fAttachedSettings ) and
  (fAttachedSettings.fAttachedSettings=Self);
end;

procedure TQCustomFormatSettings.RefreshAttachments;
begin
 if IsAttached then
    fAttachedSettings.fInnerFormatSettings := fInnerFormatSettings;
end;

procedure TQCustomFormatSettings.SetCurrencyDecimals(const Value: Byte);
begin
 fInnerFormatSettings.CurrencyDecimals := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetCurrencyFormat(const Value: Byte);
begin
 fInnerFormatSettings.CurrencyFormat := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetCurrencyString(const Value: string);
begin
 fInnerFormatSettings.CurrencyString := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetDateSeparator(const Value: Char);
begin
 fInnerFormatSettings.DateSeparator := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetDecimalSeparator(const Value: Char);
begin
 fInnerFormatSettings.DecimalSeparator := Value;
 RefreshAttachments;
end;

function TQCustomFormatSettings.SetSettings(
  aNewFormatSettings: TFormatSettings): TFormatSettings;
begin
 result := fInnerFormatSettings;
 fInnerFormatSettings := aNewFormatSettings;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetListSeparator(const Value: Char);
begin
 fInnerFormatSettings.ListSeparator := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetLongDateFormat(const Value: string);
begin
 fInnerFormatSettings.LongDateFormat := Value;
 RefreshAttachments;
end;


procedure TQCustomFormatSettings.SetLongDayNames(aIndex: Integer;
  const Value: string);
begin
 fInnerFormatSettings.LongDayNames[aIndex] := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetLongMonthNames(aIndex: Integer;
  const Value: string);
begin
 fInnerFormatSettings.LongMonthNames[aIndex] := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetLongTimeFormat(const Value: string);
begin
 fInnerFormatSettings.LongTimeFormat := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetNegCurrFormat(const Value: Byte);
begin
 fInnerFormatSettings.NegCurrFormat := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetShortDateFormat(const Value: string);
begin
 fInnerFormatSettings.ShortDateFormat := Value;
 RefreshAttachments;
end;


procedure TQCustomFormatSettings.SetShortDayNames(aIndex: Integer;
  const Value: string);
begin
 fInnerFormatSettings.ShortDayNames[aIndex] := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetShortMonthNames(aIndex: Integer;
  const Value: string);
begin
 fInnerFormatSettings.ShortMonthNames[aIndex] := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetShortTimeFormat(const Value: string);
begin
 fInnerFormatSettings.ShortTimeFormat := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetThousandSeparator(const Value: Char);
begin
 fInnerFormatSettings.ThousandSeparator := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetTimeAMString(const Value: string);
begin
 fInnerFormatSettings.TimeAMString := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetTimePMString(const Value: string);
begin
 fInnerFormatSettings.TimePMString := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetTimeSeparator(const Value: Char);
begin
  fInnerFormatSettings.TimeSeparator := Value;
  RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetTwoDigitYearCenturyWindow(const Value: Word);
begin
  fInnerFormatSettings.TwoDigitYearCenturyWindow := Value;
  RefreshAttachments;
end;


Initialization;
{$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}
 CSQFormatSettings := TCriticalSection.Create;
{$ENDIF}
 InitializeFormatSettings( SFQRunTimeFormatSettings, false );
Finalization;
{$IFDEF XQ_THREAD_SAFE_FORMATSETTINGS}
 CSQFormatSettings.Leave;
 FreeAndNil(CSQFormatSettings);
{$ENDIF}
end.
