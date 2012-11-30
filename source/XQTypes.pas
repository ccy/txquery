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

interface

uses SysUtils;

const
  SQuote = ['''', '"'];
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

  TNativeInt = {$ifdef Delphi2009Up}NativeInt{$else}Integer{$endif};
  TNativeUInt = {$ifdef Delphi2009Up}NativeUInt{$else}Cardinal{$endif};

  TNativeInt32 = {$ifdef DelphiXE2Up}Int32{$else}Integer{$endif};
  TNativeUInt32 = {$ifdef DelphiXE2Up}UInt32{$else}Cardinal{$endif};

  TNativeInt64 = {$ifdef DelphiXE2Up}NativeInt{$else}Int64{$endif};
  TNativeUInt64 = {$ifdef DelphiXE2Up}NativeUInt{$else}UInt64{$endif};

  TxBuffer = {$if RtlVersion <= 18.5}PAnsiChar{$else}TBytes{$ifend}; { patched by ccy } {moved from xqbase}

  {$if RTLVersion <= 18.5}TRecordBuffer = PChar;{$ifend}

  {-------------------------------------------------------------------------------}
  {                          Main exception                                       }
  {-------------------------------------------------------------------------------}

  ExQueryError = Class( Exception );

implementation

end.
