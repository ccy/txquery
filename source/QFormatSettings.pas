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

uses Windows, Classes, SysUtils{$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}, SyncObjs{$ENDIF};

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
  TQFormatActiveSource = (asCustom, asDefault, asSystem);

  TQCustomFormatSettings = Class;

  TQAbstractFormatItemList = Class Abstract( TPersistent )
  protected
    fCustomformatSettings: TQCustomFormatSettings;
  protected
    function GetItem01: string;
    function GetItem02: string;
    function GetItem03: string;
    function GetItem04: string;
    function GetItem05: string;
    function GetItem06: string;
    function GetItem07: string;
    procedure SetItem01(const Value: string);
    procedure SetItem02(const Value: string);
    procedure SetItem03(const Value: string);
    procedure SetItem04(const Value: string);
    procedure SetItem05(const Value: string);
    procedure SetItem06(const Value: string);
    procedure SetItem07(const Value: string);
  protected
    function HasCustomSettings: Boolean; virtual;
    function GetValue(aIndex: Integer): string; virtual; abstract;
    procedure SetValue(aIndex: Integer; const Value: string); virtual; abstract;
  public
    constructor Create( aFormatSettings: TQCustomFormatSettings ); virtual;
  end;

  TQAbstractFormatDayList = Class Abstract( TQAbstractFormatItemList )
  published
    property Day01: string read GetItem01 write SetItem01 stored HasCustomSettings;
    property Day02: string read GetItem02 write SetItem02 stored HasCustomSettings;
    property Day03: string read GetItem03 write SetItem03 stored HasCustomSettings;
    property Day04: string read GetItem04 write SetItem04 stored HasCustomSettings;
    property Day05: string read GetItem05 write SetItem05 stored HasCustomSettings;
    property Day06: string read GetItem06 write SetItem06 stored HasCustomSettings;
    property Day07: string read GetItem07 write SetItem07 stored HasCustomSettings;
  end;

  TQAbstractFormatMonthList = Class Abstract( TQAbstractFormatItemList )
  protected
    function GetItem08: string;
    function GetItem09: string;
    function GetItem10: string;
    function GetItem11: string;
    function GetItem12: string;
    procedure SetItem08(const Value: string);
    procedure SetItem09(const Value: string);
    procedure SetItem10(const Value: string);
    procedure SetItem11(const Value: string);
    procedure SetItem12(const Value: string);
  published
    property Month01: string read GetItem01 write SetItem01 stored HasCustomSettings;
    property Month02: string read GetItem02 write SetItem02 stored HasCustomSettings;
    property Month03: string read GetItem03 write SetItem03 stored HasCustomSettings;
    property Month04: string read GetItem04 write SetItem04 stored HasCustomSettings;
    property Month05: string read GetItem05 write SetItem05 stored HasCustomSettings;
    property Month06: string read GetItem06 write SetItem06 stored HasCustomSettings;
    property Month07: string read GetItem07 write SetItem07 stored HasCustomSettings;
    property Month08: string read GetItem08 write SetItem08 stored HasCustomSettings;
    property Month09: string read GetItem09 write SetItem09 stored HasCustomSettings;
    property Month10: string read GetItem10 write SetItem10 stored HasCustomSettings;
    property Month11: string read GetItem11 write SetItem11 stored HasCustomSettings;
    property Month12: string read GetItem12 write SetItem12 stored HasCustomSettings;
  end;

  TQCustomFormatLongDayNameList = Class( TQAbstractFormatDayList )
  protected
   function GetValue(aIndex: Integer): string; override;
   procedure SetValue(aIndex: Integer; const Value: string); override;
  End;

  TQCustomFormatShortDayNameList = Class( TQAbstractFormatDayList )
  protected
   function GetValue(aIndex: Integer): string; override;
   procedure SetValue(aIndex: Integer; const Value: string); override;
  End;

  TQCustomFormatLongMonthNameList = Class( TQAbstractFormatMonthList )
  protected
   function GetValue(aIndex: Integer): string; override;
   procedure SetValue(aIndex: Integer; const Value: string); override;
  End;

  TQCustomFormatShortMonthNameList = Class( TQAbstractFormatMonthList )
  protected
   function GetValue(aIndex: Integer): string; override;
   procedure SetValue(aIndex: Integer; const Value: string); override;
  End;

  TQCustomFormatSettings = Class( TPersistent )
  protected
    fActiveSource: TQFormatActiveSource;
    fAttachedSettings: TQCustomFormatSettings;
    fInnerFormatSettings: TFormatSettings;
    fOwner: TObject;
    fLongDayNames: TQCustomFormatLongDayNameList;
    fLongMonthNames: TQCustomFormatLongMonthNameList;
    fShortDayNames: TQCustomFormatShortDayNameList;
    fShortMonthNames: TQCustomFormatShortMonthNameList;
    function HasCustomSettings: boolean;
  protected
    function GetActiveSource: TQFormatActiveSource; virtual;
    function GetCurrencyDecimals: Byte;
    function GetCurrencyFormat: Byte;
    function GetCurrencyString: string;
    function GetDateSeparator: Char;
    function GetDecimalSeparator: Char;
    function GetListSeparator: Char;
    function GetLongDateFormat: string;
    function GetLongDayNamesArray(aIndex:Integer): string;
    function GetLongMonthNamesArray(aIndex:Integer): string;
    function GetLongTimeFormat: string;
    function GetNegCurrFormat: Byte;
    function GetShortDateFormat: string;
    function GetShortDayNamesArray(aIndex:Integer): string;
    function GetShortMonthNamesArray(aIndex:Integer): string;
    function GetShortTimeFormat: string;
    function GetThousandSeparator: Char;
    function GetTimeAMString: string;
    function GetTimePMString: string;
    function GetTimeSeparator: Char;
    function GetTwoDigitYearCenturyWindow: Word;
    procedure SetActiveSource(const Value: TQFormatActiveSource); virtual;
    procedure SetCurrencyDecimals(const Value: Byte); virtual;
    procedure SetCurrencyFormat(const Value: Byte); virtual;
    procedure SetCurrencyString(const Value: string); virtual;
    procedure SetDateSeparator(const Value: Char); virtual;
    procedure SetDecimalSeparator(const Value: Char); virtual;
    procedure SetListSeparator(const Value: Char); virtual;
    procedure SetLongDateFormat(const Value: string); virtual;
    procedure SetLongDayNamesArray(aIndex:Integer; const Value: string); virtual;
    procedure SetLongMonthNamesArray(aIndex:Integer; const Value: string); virtual;
    procedure SetLongTimeFormat(const Value: string); virtual;
    procedure SetNegCurrFormat(const Value: Byte); virtual;
    procedure SetShortDateFormat(const Value: string); virtual;
    procedure SetShortDayNamesArray(aIndex:Integer; const Value: string); virtual;
    procedure SetShortMonthNamesArray(aIndex:Integer; const Value: string); virtual;
    procedure SetShortTimeFormat(const Value: string);  virtual;
    procedure SetThousandSeparator(const Value: Char); virtual;
    procedure SetTimeAMString(const Value: string); virtual;
    procedure SetTimePMString(const Value: string); virtual;
    procedure SetTimeSeparator(const Value: Char); virtual;
    procedure SetTwoDigitYearCenturyWindow(const Value: Word); virtual;
  private
    function GetLongDayNames: TQCustomFormatLongDayNameList;
    function GetLongMonthNames: TQCustomFormatLongMonthNameList;
    function GetShortDayNames: TQCustomFormatShortDayNameList;
    function GetShortMonthNames: TQCustomFormatShortMonthNameList;
    procedure SetLongDayNames(const Value: TQCustomFormatLongDayNameList);
    procedure SetLongMonthNames(const Value: TQCustomFormatLongMonthNameList);
    procedure SetShortDayNames(const Value: TQCustomFormatShortDayNameList);
    procedure SetShortMonthNames(const Value: TQCustomFormatShortMonthNameList);
  protected
    property ActiveSource:  TQFormatActiveSource read GetActiveSource write SetActiveSource default asCustom;
    property CurrencyString: string read GetCurrencyString write SetCurrencyString stored HasCustomSettings;
    property CurrencyFormat: Byte read GetCurrencyFormat write SetCurrencyFormat stored HasCustomSettings;
    property CurrencyDecimals: Byte read GetCurrencyDecimals write SetCurrencyDecimals stored HasCustomSettings;
    property DateSeparator: Char read GetDateSeparator write SetDateSeparator stored HasCustomSettings;
    property TimeSeparator: Char read GetTimeSeparator write SetTimeSeparator stored HasCustomSettings;
    property ListSeparator: Char read GetListSeparator write SetListSeparator stored HasCustomSettings;
    property ShortDateFormat: string read GetShortDateFormat write SetShortDateFormat stored HasCustomSettings;
    property LongDateFormat: string read GetLongDateFormat write SetLongDateFormat  stored HasCustomSettings;
    property TimeAMString: string read GetTimeAMString write SetTimeAMString  stored HasCustomSettings;
    property TimePMString: string read GetTimePMString write SetTimePMString  stored HasCustomSettings;
    property ShortTimeFormat: string read GetShortTimeFormat write SetShortTimeFormat  stored HasCustomSettings;
    property LongTimeFormat: string read GetLongTimeFormat write SetLongTimeFormat  stored HasCustomSettings;
    property ShortMonthNamesArray[aIndex: Integer]: string read GetShortMonthNamesArray write SetShortMonthNamesArray stored false;
    property LongMonthNamesArray[aIndex: Integer]: string read GetLongMonthNamesArray write SetLongMonthNamesArray stored false;
    property ShortDayNamesArray[aIndex: Integer]: string read GetShortDayNamesArray write SetShortDayNamesArray stored false;
    property LongDayNamesArray[aIndex: Integer]: string read GetLongDayNamesArray write SetLongDayNamesArray stored false;

    property LongDayNames: TQCustomFormatLongDayNameList read GetLongDayNames write SetLongDayNames stored HasCustomSettings;
    property ShortDayNames: TQCustomFormatShortDayNameList read GetShortDayNames write SetShortDayNames stored HasCustomSettings;
    property LongMonthNames: TQCustomFormatLongMonthNameList read GetLongMonthNames write SetLongMonthNames stored HasCustomSettings;
    property ShortMonthNames: TQCustomFormatShortMonthNameList read GetShortMonthNames write SetShortMonthNames stored HasCustomSettings;

    property ThousandSeparator: Char read GetThousandSeparator write SetThousandSeparator stored HasCustomSettings;
    property DecimalSeparator: Char read GetDecimalSeparator write SetDecimalSeparator stored HasCustomSettings;
    property TwoDigitYearCenturyWindow: Word read GetTwoDigitYearCenturyWindow write SetTwoDigitYearCenturyWindow stored HasCustomSettings;
    property NegCurrFormat: Byte read GetNegCurrFormat write SetNegCurrFormat stored HasCustomSettings;
  public
    constructor Create( aOwner: TObject; aInitSettings: boolean );  overload; virtual;
   {$IFDEF Delphi7Up}
    constructor Create( aOwner: TObject{$IFDEF Delphi7Up}; aLocale: {$IFDEF DelphiXEUp}string{$ELSE}Cardinal{$ENDIF}{$ENDIF} ); overload;
   {$ENDIF}
    destructor Destroy; override;
    function GetSettings: TFormatSettings;
    function SetSettings( aNewFormatSettings: TFormatSettings ): TFormatSettings;
    function InitSettings({$IFDEF Delphi7Up} aLocale: {$IFDEF DelphiXEUp}string=''{$ELSE}Cardinal=0{$ENDIF}{$ENDIF} ): TFormatSettings; overload;
    function InitSettings( aActiveSource: TQFormatActiveSource ): TFormatSettings; overload;
    function AttachTo( aFormatSettings: TQCustomFormatSettings ): TQCustomFormatSettings;
    function IsAttached: Boolean;
    procedure RefreshAttachments;
  end;

  Procedure RefreshSystemFormatSettings;
  Procedure RefreshRuntimeFormatSettings;
  Procedure InitializeFormatSettings( var aFormatSettings: TFormatSettings;
   aGetRuntimeSettings: boolean=false {$IFDEF Delphi7Up}; aLocale: {$IFDEF DelphiXEUp}string=''{$ELSE}Cardinal=LOCALE_USER_DEFAULT{$ENDIF}{$ENDIF} );
  Function SaveFormatSettings( aSaveRuntimeSettings:boolean=false ): TFormatSettings;             // Nonn
  Function RestoreFormatSettings(aSFS: TFormatSettings;
   aSetRuntimeSettings: Boolean=false): TFormatSettings;   // Nonn

{$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}
Var CSQFormatSettings: TCriticalSection;
{$ENDIF}
//{$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}ThreadVar{$ELSE}Var{$ENDIF} SFQRunTimeFormatSettings:TFormatSettings;
Var SFQRunTimeFormatSettings:TFormatSettings;

const
  {Default date and number format values when creating a new txquery object
   This values are used by the SQL parser to detect dates and number values specified
   direclty in the sql Srcipt.
     Ex: SELECT * FROM Orders WHERE (InvoiceDate >= #2012-02-27#) and (InvoiceAmount >= 120.99);

   It is better to change the old default 'm/d/yyyy' to a new standard like 'yyyy-mm-dd'
   meanwhile if you want to change the default short date format you have to make
   sure to also change the Date Separator if you will not use the '/' in the ShortDateFormat string
  }
  CxFmtDefaultCurrencyDecimals:Byte = 2;
  CxFmtDefaultCurrencyFormat:Byte   = 0;
  CxFmtDefaultCurrencyString:Char   = '$';
  CxFmtDefaultDateSeparator:Char = '-';
  CxFmtDefaultDecimalSeparator:Char = '.';
  CxFmtDefaultListSeparator:Char     = ',';
  CxFmtDefaultLongDateFormat: string = 'dddd, MMMM dd, yyyy' {For Spanish-Mexico set: 'dddd, dd'+''' of '''+'MMMM'+''' of '''+'yyyy'};
  CxFmtDefaultLongTimeFormat:string = 'HH:nn:ss';{defines 24 hr clock} {could also be 'hh:nn:ss AMPM' (12hr clock)}
  CxFmtDefaultNegCurrFormat:Byte = 1;
  CxFmtDefaultShortDateFormat: String = 'yyyy-mm-dd'; {recommended setting is: 'yyyy-mm-dd', the original value is 'm/d/yyyy'}
  CxFmtDefaultShortTimeFormat: String = 'HH:nn';{defines 24 hr clock}  {could also be 'hh:nn AMPM' (12hr clock)}
  CxFmtDefaultThousandSeparator:Char = ',';
  CxFmtDefaultTimeAMString:String = 'a.m.';
  CxFmtDefaultTimePMString:String = 'p.m.';
  CxFmtDefaultTimeSeparator:Char = ':';
  CxFmtDefaultTwoDigitYearCenturyWindow: Word = 50;
  CxFmtDefaultShortMonthNames: array[1..12] of string = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
  CxFmtDefaultLongMonthNames: array[1..12] of string = ('January','February','March','April','May','June','July','August','September','October','November','December');
  CxFmtDefaultShortDayNames: array[1..7] of string = ('Sun','Mon','Tue','Wed','Thu','Fri','Sat');
  CxFmtDefaultLongDayNames: array[1..7] of string = ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
(*resourcestring
  SxFmtDefaultCurrencyDecimals = '2';
  SxFmtDefaultCurrencyFormat   = '2';
  SxFmtDefaultShortDateFormat = 'yyyy-mm-dd'; {recommended setting is: 'yyyy-mm-dd', the original value is 'm/d/yyyy'}
  SxFmtDefaultShortTimeFormat = 'HH:nn';{defines 24 hr clock}  {could also be 'hh:nn AMPM' (12hr clock)}
  SxFmtDefaultLongTimeFormat = 'HH:nn:ss';{defines 24 hr clock} {could also be 'hh:nn:ss AMPM' (12hr clock)}
  SxFmtDefaultDateSeparator = '/';
  SxFmtDefaultTimeSeparator = ':';
  SxFmtDefaultDecimalSeparator = '.';
  SxFmtDefaultThousandSeparator = ',';
  SxFmtDefaultTimeAMString = 'a.m.';
  SxFmtDefaultTimePMString = 'p.m.';*)
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
 {$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}
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
 {$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}
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
 {$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}
   CSQFormatSettings.Enter;
 {$ENDIF}
  Result := SFQRunTimeFormatSettings;
 {$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}
  CSQFormatSettings.Leave;
 {$ENDIF}
 end
 else
 begin
  {$IFDEF DelphiXEUp}
   Result :=  TFormatSettings.Create;
  {$ELSE}
   GetLocaleFormatSettings(LOCALE_USER_DEFAULT, Result);
  {$ENDIF}
 end;
End;


Procedure RefreshRuntimeFormatSettings;
begin
 InitializeFormatSettings( SFQRunTimeFormatSettings, true);
end;

procedure RefreshSystemFormatSettings;
begin
 {$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}
  CSQFormatSettings.Enter;
 {$ENDIF}
  SysUtils.GetFormatSettings;
 {$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}
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
 {$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}
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
   GetLocaleFormatSettings(LOCALE_USER_DEFAULT,  Result);
 {$ENDIF}
 {$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}
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
 fActiveSource := asCustom;
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
 Result := Self;
end;

constructor TQCustomFormatSettings.Create(aOwner: TObject{$IFDEF Delphi7Up}; aLocale: {$IFDEF DelphiXEUp}string{$ELSE}Cardinal{$ENDIF}{$ENDIF});
begin
 inherited Create;
 fActiveSource := asCustom;
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

function TQCustomFormatSettings.GetActiveSource: TQFormatActiveSource;
begin
 result := fActiveSource;
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

function TQCustomFormatSettings.GetLongDayNames: TQCustomFormatLongDayNameList;
begin
 result := fLongDayNames;
end;

function TQCustomFormatSettings.GetLongDayNamesArray(aIndex: Integer): string;
begin
 result := fInnerFormatSettings.LongDayNames[aIndex];
end;

function TQCustomFormatSettings.GetLongMonthNames: TQCustomFormatLongMonthNameList;
begin
 result := fLongMonthNames;
end;

function TQCustomFormatSettings.GetLongMonthNamesArray(aIndex: Integer): string;
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

function TQCustomFormatSettings.GetShortDayNames: TQCustomFormatShortDayNameList;
begin
 result := fShortDayNames;
end;

function TQCustomFormatSettings.GetShortDayNamesArray(aIndex: Integer): string;
begin
 result := fInnerFormatSettings.ShortDayNames[aIndex];
end;

function TQCustomFormatSettings.GetShortMonthNames: TQCustomFormatShortMonthNameList;
begin
 result := fShortMonthNames;
end;

function TQCustomFormatSettings.GetShortMonthNamesArray(aIndex: Integer): string;
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

function TQCustomFormatSettings.HasCustomSettings: boolean;
begin
 result := (fActiveSource=asCustom);
end;

function TQCustomFormatSettings.InitSettings({$IFDEF Delphi7Up} aLocale: {$IFDEF DelphiXEUp}string{$ELSE}Cardinal{$ENDIF}{$ENDIF} ): TFormatSettings;
begin
 Result := fInnerFormatSettings;
 InitializeFormatSettings( fInnerFormatSettings, false {$IFDEF Delphi7Up}, aLocale{$ENDIF} );
end;

function TQCustomFormatSettings.InitSettings(aActiveSource: TQFormatActiveSource): TFormatSettings;
begin
 case ActiveSource of
   asDefault:
   begin
    InitSettings;
    fInnerFormatSettings.CurrencyString     := CxFmtDefaultCurrencyString;
    fInnerFormatSettings.CurrencyDecimals   := CxFmtDefaultCurrencyDecimals;
    fInnerFormatSettings.CurrencyFormat     := CxFmtDefaultCurrencyFormat;
    fInnerFormatSettings.CurrencyString     := CxFmtDefaultCurrencyString;
    fInnerFormatSettings.DateSeparator      := CxFmtDefaultDateSeparator;
    fInnerFormatSettings.DecimalSeparator   := CxFmtDefaultDecimalSeparator;
    fInnerFormatSettings.ListSeparator      := CxFmtDefaultListSeparator;
    fInnerFormatSettings.LongDateFormat     := CxFmtDefaultLongDateFormat;
    fInnerFormatSettings.LongTimeFormat     := CxFmtDefaultLongTimeFormat;
    fInnerFormatSettings.NegCurrFormat      := CxFmtDefaultNegCurrFormat;
    fInnerFormatSettings.ShortDateFormat    := CxFmtDefaultShortDateFormat;
    fInnerFormatSettings.ShortTimeFormat    := CxFmtDefaultShortTimeFormat;
    fInnerFormatSettings.ThousandSeparator  := CxFmtDefaultThousandSeparator;
    fInnerFormatSettings.TimeAMString       := CxFmtDefaultTimeAMString;
    fInnerFormatSettings.TimePMString       := CxFmtDefaultTimePMString;
    fInnerFormatSettings.TimeSeparator      := CxFmtDefaultTimeSeparator;
    fInnerFormatSettings.TwoDigitYearCenturyWindow := CxFmtDefaultTwoDigitYearCenturyWindow;
   end;
   asSystem: InitSettings;
 end;
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

procedure TQCustomFormatSettings.SetActiveSource(const Value: TQFormatActiveSource);
begin
 fActiveSource := Value;
 InitSettings(Value);
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


procedure TQCustomFormatSettings.SetLongDayNames(const Value: TQCustomFormatLongDayNameList);
begin
 fLongDayNames.Assign( Value );
end;

procedure TQCustomFormatSettings.SetLongDayNamesArray(aIndex: Integer;
  const Value: string);
begin
 fInnerFormatSettings.LongDayNames[aIndex] := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetLongMonthNames(const Value: TQCustomFormatLongMonthNameList);
begin
 fLongMonthNames.Assign( Value );
end;

procedure TQCustomFormatSettings.SetLongMonthNamesArray(aIndex: Integer;
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


procedure TQCustomFormatSettings.SetShortDayNames(const Value: TQCustomFormatShortDayNameList);
begin
 fShortDayNames.Assign( Value );
end;

procedure TQCustomFormatSettings.SetShortDayNamesArray(aIndex: Integer;
  const Value: string);
begin
 fInnerFormatSettings.ShortDayNames[aIndex] := Value;
 RefreshAttachments;
end;

procedure TQCustomFormatSettings.SetShortMonthNames(const Value: TQCustomFormatShortMonthNameList);
begin
 fShortMonthNames.Assign( Value );
end;

procedure TQCustomFormatSettings.SetShortMonthNamesArray(aIndex: Integer;
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


{ TQCustomItemListNames }

function TQAbstractFormatItemList.HasCustomSettings: Boolean;
begin
 result := fCustomformatSettings.HasCustomSettings;
end;

constructor TQAbstractFormatItemList.Create(aFormatSettings: TQCustomFormatSettings);
begin
 inherited Create;
 fCustomformatSettings := aFormatSettings;
end;

function TQAbstractFormatItemList.GetItem01: string;
begin
 result := GetValue(01);
end;

function TQAbstractFormatItemList.GetItem02: string;
begin
  result := GetValue(02);
end;

function TQAbstractFormatItemList.GetItem03: string;
begin
   result := GetValue(03);
end;

function TQAbstractFormatItemList.GetItem04: string;
begin
   result := GetValue(04);
end;

function TQAbstractFormatItemList.GetItem05: string;
begin
   result := GetValue(05);
end;

function TQAbstractFormatItemList.GetItem06: string;
begin
   result := GetValue(06);
end;

function TQAbstractFormatItemList.GetItem07: string;
begin
   result := GetValue(07);
end;

procedure TQAbstractFormatItemList.SetItem01(const Value: string);
begin
 SetValue(01, Value);
end;

procedure TQAbstractFormatItemList.SetItem02(const Value: string);
begin
 SetValue(02, Value);
end;

procedure TQAbstractFormatItemList.SetItem03(const Value: string);
begin
 SetValue(03, Value);
end;

procedure TQAbstractFormatItemList.SetItem04(const Value: string);
begin
 SetValue(04, Value);
end;

procedure TQAbstractFormatItemList.SetItem05(const Value: string);
begin
 SetValue(05, Value);
end;

procedure TQAbstractFormatItemList.SetItem06(const Value: string);
begin
 SetValue(06, Value);
end;

procedure TQAbstractFormatItemList.SetItem07(const Value: string);
begin
 SetValue(07, Value);
end;

{ TQCustomtMonthListNames }
function TQAbstractFormatMonthList.GetItem08: string;
begin
   result := GetValue(08);
end;

function TQAbstractFormatMonthList.GetItem09: string;
begin
   result := GetValue(09);
end;

function TQAbstractFormatMonthList.GetItem10: string;
begin
   result := GetValue(10);
end;

function TQAbstractFormatMonthList.GetItem11: string;
begin
   result := GetValue(11);
end;

function TQAbstractFormatMonthList.GetItem12: string;
begin
   result := GetValue(12);
end;

procedure TQAbstractFormatMonthList.SetItem08(const Value: string);
begin
 SetValue(08, Value);
end;

procedure TQAbstractFormatMonthList.SetItem09(const Value: string);
begin
 SetValue(09, Value);
end;

procedure TQAbstractFormatMonthList.SetItem10(const Value: string);
begin
 SetValue(10, Value);
end;

procedure TQAbstractFormatMonthList.SetItem11(const Value: string);
begin
 SetValue(11, Value);
end;

procedure TQAbstractFormatMonthList.SetItem12(const Value: string);
begin
 SetValue(12, Value);
end;

{ TQCustomFormatLongDayNameList }

function TQCustomFormatLongDayNameList.GetValue(aIndex: Integer): string;
begin
 result := fCustomformatSettings.LongDayNamesArray[aIndex];
end;

procedure TQCustomFormatLongDayNameList.SetValue(aIndex: Integer; const Value: string);
begin
 fCustomformatSettings.LongDayNamesArray[aIndex] := Value;
end;

{ TQCustomFormatShortDayNameList }

function TQCustomFormatShortDayNameList.GetValue(aIndex: Integer): string;
begin
 result := fCustomformatSettings.ShortDayNamesArray[aIndex];
end;

procedure TQCustomFormatShortDayNameList.SetValue(aIndex: Integer; const Value: string);
begin
  fCustomformatSettings.ShortDayNamesArray[aIndex] := Value;
end;

{ TQCustomFormatLongMonthNameList }

function TQCustomFormatLongMonthNameList.GetValue(aIndex: Integer): string;
begin
 result := fCustomformatSettings.LongMonthNamesArray[aIndex];
end;

procedure TQCustomFormatLongMonthNameList.SetValue(aIndex: Integer; const Value: string);
begin
 fCustomformatSettings.LongMonthNamesArray[aIndex] := Value;
end;

{ TQCustomFormatShortMonthNameList }

function TQCustomFormatShortMonthNameList.GetValue(aIndex: Integer): string;
begin
 result := fCustomformatSettings.ShortMonthNamesArray[aIndex];
end;

procedure TQCustomFormatShortMonthNameList.SetValue(aIndex: Integer; const Value: string);
begin
  fCustomformatSettings.ShortMonthNamesArray[aIndex] := Value;
end;

Initialization;
{$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}
 CSQFormatSettings := TCriticalSection.Create;
{$ENDIF}
 InitializeFormatSettings( SFQRunTimeFormatSettings, false );
Finalization;
{$IFDEF XQ_USE_THREAD_SAFE_FORMATSETTINGS}
 CSQFormatSettings.Leave;
 FreeAndNil(CSQFormatSettings);
{$ENDIF}
end.
