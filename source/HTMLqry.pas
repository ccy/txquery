{**************************************************************************}
{   TxQuery DataSet                                                        }
{                                                                          }
{   Copyright (C) <1999-2003> of                                           }
{   Alfonso Moreno (Hermosillo, Sonora, Mexico)                            }
{   email: luisarvayo@yahoo.com                                            }
{     url: http://www.ezsoft.com                                           }
{          http://www.sigmap.com/txquery.htm                               }
{                                                                          }
{   Open Source patch review (2009) with permission from Alfonso Moreno by }
{   Chee-Yang CHAU and Sherlyn CHEW (Klang, Selangor, Malaysia)            }
{   email: cychau@gmail.com                                                }
{   url: http://code.google.com/p/txquery/                                 }
{        http://groups.google.com/group/txquery                            }
{                                                                          }
{   This program is free software: you can redistribute it and/or modify   }
{   it under the terms of the GNU General Public License as published by   }
{   the Free Software Foundation, either version 3 of the License, or      }
{   (at your option) any later version.                                    }
{                                                                          }
{   This program is distributed in the hope that it will be useful,        }
{   but WITHOUT ANY WARRANTY; without even the implied warranty of         }
{   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          }
{   GNU General Public License for more details.                           }
{                                                                          }
{   You should have received a copy of the GNU General Public License      }
{   along with this program.  If not, see <http://www.gnu.org/licenses/>.  }
{                                                                          }
{**************************************************************************}

Unit HTMLqry;

{$I XQ_FLAG.INC}
Interface

Uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Graphics, Db;

{ this unit is for exporting a dataset to HTML }

Type
  THTMLExport = Class( TComponent )
  Private
    FFooter: TStrings;
    FHeader: TStrings;
    FTitle: TStrings;
    FDataSet: TDataSet;
    FBodyColor: TColor;
    FTableHeaderColor: TColor;
    FTableBodyColor: TColor;
    FTableOddRowColor: TColor;
    Procedure SetDataSet( Value: TDataSet );
  Protected
    Procedure Notification( AComponent: TComponent; Operation: toperation ); Override;
  Public
    Constructor Create( AOwner: TComponent ); Override;
    Destructor Destroy; Override;
    Procedure SaveToFile( Const FileName: String );
  Published
    Property Footer: TStrings Read FFooter;
    Property Header: TStrings Read FHeader;
    Property Title: TStrings Read FTitle;
    Property DataSet: TDataSet Read FDataSet Write SetDataSet;
    Property BodyColor: TColor Read FBodyColor Write FBodyColor;
    Property TableHeaderColor: TColor Read FTableHeaderColor Write FTableHeaderColor;
    Property TableBodyColor: TColor Read FTableBodyColor Write FTableBodyColor;
    Property TableOddRowColor: TColor Read FTableOddRowColor Write FTableOddRowColor;
  End;

Implementation

Uses xquery;

Constructor THTMLExport.Create( AOwner: TComponent );
Begin
  Inherited Create( AOwner );
  FFooter := TStringList.Create;
  FHeader := TStringList.Create;
  FTitle := TStringList.Create;
  FBodyColor := 16777194;
  FTableHeaderColor := 3394815;
  FTableBodyColor := 16777194;
  FTableOddRowColor := 3394764;
End;

Destructor THTMLExport.Destroy;
Begin
  FFooter.Free;
  FHeader.Free;
  FTitle.Free;
  Inherited Destroy;
End;

Procedure THTMLExport.SetDataSet( Value: TDataSet );
Begin
  If Value <> FDataSet Then
  Begin
    FDataSet := Value;
    Value.FreeNotification( Self );
  End;
End;

Procedure THTMLExport.Notification( AComponent: TComponent; Operation: toperation );
Begin
  Inherited Notification( AComponent, Operation );
  If ( Operation = opRemove ) And ( Acomponent = FDataSet ) Then
    FDataSet := Nil;
End;

Procedure THTMLExport.SaveToFile( Const FileName: String );
Var
  f: TextFile;
  i, Count: Integer;
  s, Align: String;
Begin
  If Not Assigned( FDataSet ) Or Not FDataSet.Active Then
    Exit;
  AssignFile( f, FileName );
  Rewrite( f );
  Try
    WriteLn( f, '<HTML>' );
    If ( Length( FHeader.Text ) > 0 ) Or ( Length( FTitle.Text ) > 0 ) Then
    Begin
      WriteLn( f, '<HEAD>' );
      If Length( FTitle.Text ) > 0 Then
      Begin
        Write( f, '<TITLE>' );
        For i := 0 To FTitle.Count - 1 Do
          WriteLn( f, FTitle[i] );
        WriteLn( f, '</TITLE>' );
      End;
      WriteLn( f, '<H3>' );
      For i := 0 To FHeader.Count - 1 Do
        WriteLn( f, FHeader[i], '<BR>' );
      WriteLn( f, '</H3>' );
      WriteLn( f, '</HEAD>' );
      WriteLn( f, '<HR>' );
    End;
    WriteLn( f, Format( '<BODY BGCOLOR="#%s">', [IntToHex( FBodyColor, 6 )] ) );
    WriteLn( f, Format( '<TABLE BGCOLOR="#%s" BORDER>', [IntToHex( FTableBodyColor, 6 )] ) );
    { The title }
    WriteLn( f, Format( '<TR BGCOLOR="#%s" NOWRAP>', [IntToHex( FTableHeaderColor, 6 )] ) );
    For i := 0 To FDataSet.FieldCount - 1 Do
      WriteLn( f, Format( '  <TH NOWRAP>%s</TH>', [FDataSet.Fields[i].FieldName] ) );
    WriteLn( f, '</TR>' );
    { now write all the rows }
    FDataSet.First;
    Count := 0;
    While Not FDataSet.EOF Do
    Begin
      Inc( Count );
      { write all this row }
      If ( Count Mod 2 ) = 0 Then
      Begin
        WriteLn( f, Format( '<TR BGCOLOR ="#%s">', [IntToHex( FTableOddRowColor, 6 )] ) );
      End
      Else
        WriteLn( f, '<TR>' );
      ;
      For i := 0 To FDataSet.FieldCount - 1 Do
      Begin
        If FDataSet.Fields[i].DataType In ftNonTextTypes Then
        Begin
          s := '(Blob/Memo)';
        End
        Else
        Begin
          Align := '';
          Case FDataSet.Fields[i].DataType Of
            ftFloat, ftCurrency, ftBCD,
              ftAutoInc, ftSmallInt, ftInteger, ftWord
{$IFNDEF LEVEL3}, ftLargeInt{$ENDIF}
            : Align := ' ALIGN=RIGHT';
          End;
          s := FDataSet.Fields[i].AsString;
        End;
        Write( f, Format( '  <TD NOWRAP%s>%s', [Align, s] ) );
        If Length( s ) = 0 Then
          WriteLn( f, '<BR></TD>' )
        Else
          WriteLn( f, '</TD>' )
      End;
      WriteLn( f, '</TR>' );
      FDataSet.Next;
    End;
    WriteLn( f, '</TABLE>' );
    If Length( FFooter.Text ) > 0 Then
    Begin
      WriteLn( f, '<HR>' );
      Write( f, '<P>' );
      For i := 0 To FFooter.Count - 1 Do
        WriteLn( f, FFooter[i], '<BR>' );
      WriteLn( f, '</P>' );
    End;
    WriteLn( f, '</BODY>' );
    WriteLn( f, '</HTML>' );
  Finally
    CloseFile( f );
  End;
End;

End.
