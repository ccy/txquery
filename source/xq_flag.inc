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
{   The Original Code is: XQ_Flag.inc                                         }
{   Compiling flags for TxQuery                                               }
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

{$DEFINE XQTESTING}  { Remove for the finished program
                       But be CAREFULL, disabling "XQTESTING" will prevent you from debugging
                       inside TXQuery Code (No break points will be allowed inside TxQuery Source code) }
//{$DEFINE XQDEMO}     { Remove for the finished program }

//OPTIMIZATION DIRECTIVES
{$DEFINE XQ_USE_THREAD_SAFE_FORMATSETTINGS}  {Used in QFormatSettings, Use a Thread TFormatSettings Variable}
{$DEFINE XQ_USE_FASTCOMPARE_FUNCTIONS}       {Used in XQBase.pas Use DoCompareFast intead of DoCompare}
{$DEFINE XQ_USE_OPTIMIZED_STRING_FIELD_SIZE} {Use to calculate the max size of a calculated string field (largest string obtained from a query string expression)}
{$DEFINE XQ_USE_INLINE_METHODS}              {Use The "InLine" Compiler Directive in Some Methods}
{$DEFINE XQ_USE_SIZEOF_CONSTANTS}            {Use The XQ_SizeOf_XXX constants}

{ ==== Determination of compiler and others (do NOT change) ==== }
{$IFDEF VER100}      // Delphi 3
  {$DEFINE LEVEL3}
  {$DEFINE DELPHI3}
  {$DEFINE DELPHI}
{$ENDIF}

{$IFDEF VER110}      // C++ Builder 3
  {$DEFINE LEVEL3}
  {$DEFINE BCB3}
  {$DEFINE BCB}
{$ENDIF}

{$IFDEF VER120}      // Delphi 4
  {$DEFINE LEVEL4}
  {$DEFINE DELPHI4}
  {$DEFINE DELPHI}
{$ENDIF}

{$IFDEF VER125}      // C++ Builder 4
  {$DEFINE LEVEL4}
  {$DEFINE BCB4}
  {$DEFINE BCB}
{$ENDIF}

{$IFDEF VER130}      // Delphi 5
  {$DEFINE LEVEL4}
  {$DEFINE LEVEL5}
  {$DEFINE DELPHI5}
  {$DEFINE DELPHI}
{$ENDIF}

{$IFDEF VER135}      // C++ Builder 5
  {$DEFINE LEVEL4}
  {$DEFINE LEVEL5}
  {$DEFINE BCB5}
  {$DEFINE BCB}
{$ENDIF}

{$IFDEF VER140}      // Delphi 6
  {$DEFINE LEVEL4}
  {$DEFINE LEVEL5}
  {$DEFINE LEVEL6}
  {$IFDEF BCB}
    {$DEFINE BCB6}
  {$ENDIF}
  {$DEFINE DELPHI6}
  {$DEFINE DELPHI}
{$ENDIF}

{$IFDEF VER145}      // C++ Builder 6
  {$DEFINE LEVEL4}
  {$DEFINE LEVEL5}
  {$DEFINE LEVEL6}
  {$DEFINE BCB6}
  {$DEFINE BCB}
{$ENDIF}

{$IFDEF VER150}      // Delphi 7
  {$DEFINE LEVEL4}
  {$DEFINE LEVEL5}
  {$DEFINE LEVEL6}
  {$DEFINE LEVEL7}
  {$DEFINE DELPHI7}
  {$DEFINE DELPHI}
{$ENDIF}

{$IFDEF VER160}      // Delphi 8
  {$DEFINE LEVEL4}
  {$DEFINE LEVEL5}
  {$DEFINE LEVEL6}
  {$DEFINE LEVEL7}
  {$DEFINE LEVEL8}
  {$DEFINE BDS2}
  {$DEFINE BDS}
  {$DEFINE DELPHI8}
  {$DEFINE DELPHI}
{$ENDIF}

{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 17.0}       // Delphi 2005, 2006
    {$DEFINE LEVEL4}
    {$DEFINE LEVEL5}
    {$DEFINE LEVEL6}
    {$DEFINE LEVEL7}
    {$DEFINE LEVEL8}
    {$DEFINE LEVEL9}
    {$DEFINE LEVEL10}
    {$DEFINE BDS}
    {$DEFINE BDS3}
    {$DEFINE DELPHI9}
    {$DEFINE DELPHI2005}
    {$DEFINE DELPHI}
  {$IFEND}

  {$IF CompilerVersion >= 18.0}       // Delphi 10
    {$IFDEF BCB}
      {$DEFINE BCB11}
    {$ENDIF}
    {$DEFINE BDS}
    {$IFDEF CLR}
      {$DEFINE CLR11}
      {$DEFINE LEVEL11Net}
    {$ENDIF CLR}
    {$IF CompilerVersion >= 18.5}
      {$DEFINE LEVEL11}
      {$DEFINE BDS5}
      {$DEFINE DELPHI11}
      {$DEFINE DELPHI2007} // synonym to DELPHI11
      {$IFDEF BCB}
        {$DEFINE BCB11}
      {$ENDIF}
    {$ELSE ~~VER185}
      {$DEFINE BDS4}
      {$DEFINE DELPHI10}
      {$DEFINE DELPHI2006} // synonym to DELPHI10
      {$IFDEF BCB}
        {$DEFINE BCB10}
      {$ENDIF}
    {$IFEND ~VER185}
  {$IFEND}

  {$IF CompilerVersion >= 19.0}  // Delphi 2007 for .NET
    {$IFDEF CLR}
      {$DEFINE CLR20}
      {$DEFINE LEVEL11Net}
    {$ENDIF CLR}
    {$DEFINE DELPHI11}
    {$DEFINE DELPHI2007} // synonym to DELPHI11
  {$IFEND VER190}

  {$IF CompilerVersion >= 20.0}       // Delphi 12
    {$DEFINE LEVEL12}
    {$DEFINE BDS6}
    {$IFDEF BCB}
      {$DEFINE BCB12}
    {$ENDIF}
    {$IFDEF CLR}
      {$DEFINE CLR20}
    {$ENDIF CLR}
    {$DEFINE DELPHI12}
    {$DEFINE DELPHI2009}
    {$DEFINE DELPHI}
  {$IFEND}

  {$IF CompilerVersion >= 21.0}      // Delphi 14
    {$DEFINE LEVEL13}
    {$DEFINE LEVEL14}
    {$DEFINE BDS7}
    {$IFDEF BCB}
      {$DEFINE BCB14}
    {$ENDIF}
    {$DEFINE DELPHI14}
    {$DEFINE DELPHI2010}
    {$DEFINE DELPHI}
  {$IFEND}

  {$IF CompilerVersion >= 22.0}      // Delphi 15, XE
    {$DEFINE LEVEL15}
    {$DEFINE BDS8}
    {$IFDEF BCB}
      {$DEFINE BCB15}
    {$ENDIF}
    {$DEFINE DELPHI15}
    {$DEFINE DELPHIXE}
    {$DEFINE DELPHI}
  {$IFEND}

  {$IF CompilerVersion >= 23.0}      // Delphi 16, XE2
    {$DEFINE LEVEL16}
    {$DEFINE BDS9}
    {$IFDEF BCB}
      {$DEFINE BCB16}
    {$ENDIF}
    {$DEFINE DELPHI16}
    {$DEFINE DELPHIXE2}
    {$DEFINE DELPHI}
  {$IFEND}

  {$IF CompilerVersion >= 24.0}      // Delphi 17, XE3
    {$DEFINE LEVEL17}
    {$DEFINE BDS10}
    {$IFDEF BCB}
      {$DEFINE BCB17}
    {$ENDIF}
    {$DEFINE DELPHI17}
    {$DEFINE DELPHIXE3}
    {$DEFINE DELPHI}
  {$IFEND}

  {$IF CompilerVersion >= 25.0}      // Delphi 18, XE4
    {$DEFINE LEVEL18}
    {$DEFINE BDS11}
    {$IFDEF BCB}
      {$DEFINE BCB18}
    {$ENDIF}
    {$DEFINE DELPHI18}
    {$DEFINE DELPHIXE4}
    {$DEFINE DELPHI}
  {$IFEND}
{$ENDIF}

{$IFDEF LEVEL1}       {$DEFINE Delphi1}         {$ENDIF}
{$IFDEF LEVEL2}       {$DEFINE Delphi2}         {$ENDIF}
{$IFDEF LEVEL3}       {$DEFINE Delphi3}         {$ENDIF}
{$IFDEF LEVEL4}       {$DEFINE Delphi4Up}       {$ENDIF}
{$IFDEF LEVEL5}       {$DEFINE Delphi5Up}       {$ENDIF}
{$IFDEF LEVEL6}       {$DEFINE Delphi6Up}       {$ENDIF}
{$IFDEF LEVEL7}       {$DEFINE Delphi7Up}       {$ENDIF}
{$IFDEF LEVEL8}       {$DEFINE Delphi8Up}       {$ENDIF}
{$IFDEF LEVEL10}      {$DEFINE Delphi2005Up}    {$ENDIF}
{$IFDEF LEVEL10}      {$DEFINE Delphi2006Up}    {$ENDIF}
{$IFDEF LEVEL11}      {$DEFINE Delphi2007Up}    {$ENDIF}
{$IFDEF LEVEL11Net}   {$DEFINE Delphi2007NetUp} {$ENDIF}
{$IFDEF LEVEL12}      {$DEFINE Delphi2009Up}    {$ENDIF}
{$IFDEF LEVEL14}      {$DEFINE Delphi2010Up}    {$ENDIF}
{$IFDEF LEVEL15}      {$DEFINE DelphiXEUp}      {$ENDIF}
{$IFDEF LEVEL16}      {$DEFINE DelphiXE2Up}     {$ENDIF}
{$IFDEF LEVEL17}      {$DEFINE DelphiXE3Up}     {$ENDIF}
{$IFDEF LEVEL18}      {$DEFINE DelphiXE4Up}     {$ENDIF}

{$IFDEF UNICODE}
  {.$DEFINE XQ_UNICODE_TO_ANSI_SCRIPT} //This option convert the SQL script to ANSI chars
{$ELSE}
  {$IFDEF Delphi4Up}
    {.$DEFINE XQ_USE_WIDESTRINGS} //For use only with No-Unicode IDEs (D2007 and older)
                                  //Enable it and test it please.
    {$IFDEF XQ_USE_WIDESTRINGS}
      {$DEFINE XQ_USE_WIDESTRINGS_IN_SCRIPT}
    {$ENDIF}      
  {$ENDIF}
{$ENDIF}

//***********************************************************************

{$IFDEF BCB}
 {$ObjExportAll On}
 {$ASSERTIONS ON}
{$ENDIF}

{$G+}
{$A-}

{$BOOLEVAL OFF}   // no complete boolean eval
{$IFDEF XQTESTING}
 {$ASSERTIONS ON}
 {$D+} {Enables and disables the generation of debug information}
 {$L+} {Enables or disables the generation of local symbol information}
{$ELSE}
 {$ASSERTIONS OFF}
 {$D-} {Enables and disables the generation of debug information}
 {$L-} {Enables or disables the generation of local symbol information}
{$ENDIF}

{==== Global fixed compiler options (do NOT change) ====}
{---Delphi 3---}
  {$IFDEF DELPHI3}
   {$B- Incomplete boolean evaluation}
   {$H+ Long string support}
   {$J+ Writeable typed constants}
   {$P- No open string parameters}
   {$Q- No arithmetic overflow checking}
   {$R- No range checking}
   {$T- No type-checked pointers}
   {$V- No var string checking}
   {$X+ Extended syntax}
   {$Z1 Enumerations are word sized}
  {$ENDIF}
{---Delphi 4---}
  {$IFDEF DELPHI4}
   {$B- Incomplete boolean evaluation}
   {$H+ Long string support}
   {$J+ Writeable typed constants}
   {$P- No open string parameters}
   {$Q- No arithmetic overflow checking}
   {$R- No range checking}
   {$T- No type-checked pointers}
   {$V- No var string checking}
   {$X+ Extended syntax}
   {$Z1 Enumerations are word sized}
  {$ENDIF}
{---Delphi 5---}
  {$IFDEF DELPHI5}
   {$B- Incomplete boolean evaluation}
   {$H+ Long string support}
   {$J+ Writeable typed constants}
   {$P- No open string parameters}
   {$Q- No arithmetic overflow checking}
   {$R- No range checking}
   {$T- No type-checked pointers}
   {$V- No var string checking}
   {$X+ Extended syntax}
   {$Z1 Enumerations are word sized}
  {$ENDIF}
{---Delphi 6---}
  {$IFDEF DELPHI6}
   {$B- Incomplete boolean evaluation}
   {$H+ Long string support}
   {$J+ Writeable typed constants}
   {$P- No open string parameters}
   {$Q- No arithmetic overflow checking}
   {$R- No range checking}
   {$T- No type-checked pointers}
   {$V- No var string checking}
   {$X+ Extended syntax}
   {$Z1 Enumerations are word sized}
  {$ENDIF}
{---C++Builder 3---}
  {$IFDEF BCB3}
   {$B- Incomplete boolean evaluation}
   {$H+ Long string support}
   {$J+ Writeable typed constants}
   {$P- No open string parameters}
   {$Q- No arithmetic overflow checking}
   {$R- No range checking}
   {$T- No type-checked pointers}
   {$V- No var string checking}
   {$X+ Extended syntax}
   {$Z1 Enumerations are word sized}
  {$ENDIF}
{---C++Builder 4---}
  {$IFDEF BCB4}
   {$B- Incomplete boolean evaluation}
   {$H+ Long string support}
   {$J+ Writeable typed constants}
   {$P- No open string parameters}
   {$Q- No arithmetic overflow checking}
   {$R- No range checking}
   {$T- No type-checked pointers}
   {$V- No var string checking}
   {$X+ Extended syntax}
   {$Z1 Enumerations are word sized}
  {$ENDIF}
{---C++Builder 5---}
  {$IFDEF BCB5}
   {$B- Incomplete boolean evaluation}
   {$H+ Long string support}
   {$J+ Writeable typed constants}
   {$P- No open string parameters}
   {$Q- No arithmetic overflow checking}
   {$R- No range checking}
   {$T- No type-checked pointers}
   {$V- No var string checking}
   {$X+ Extended syntax}
   {$Z1 Enumerations are word sized}
  {$ENDIF}
{---C++Builder 6---}
  {$IFDEF BCB6}
   {$B- Incomplete boolean evaluation}
   {$H+ Long string support}
   {$J+ Writeable typed constants}
   {$P- No open string parameters}
   {$Q- No arithmetic overflow checking}
   {$R- No range checking}
   {$T- No type-checked pointers}
   {$V- No var string checking}
   {$X+ Extended syntax}
   {$Z1 Enumerations are word sized}
  {$ENDIF}

