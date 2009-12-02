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

Unit QYACCLIB;

(* Yacc Library Unit for TP Yacc Version 3.0, 6-17-91 AG *)
(* adapted to Delphi 3,4,5,6 6/8/2003 *)

{$I XQ_FLAG.INC}
Interface

Uses QLexLib;

Const
  yymaxdepth = 1048;
  (* default stack size of parser *)

Type
  YYSType = Integer;
  TYYFlag = ( yyfnone, yyfaccept, yyfabort, yyferror );

  (* default value type, may be redefined in Yacc output file *)
  TCustomParser = Class( TObject )
  Public
    yychar: Integer; (* current lookahead character *)
    yynerrs: Integer; (* current number of syntax errors reported by the
    parser *)
    yydebug: Boolean; (* set to true to enable debugging output of parser *)

    yyLexer: TCustomLexer; (* Lexer used to lex input *)

    yyerrormsg: String; (* Last error message in string format *)

    Procedure yyerror( msg: String );
    (* error message printing routine used by the parser *)

    Procedure yyclearin;
    (* delete the current lookahead token *)

    Procedure yyaccept;
    (* trigger accept action of the parser; yyparse accepts returning 0, as if
       it reached end of input *)

    Procedure yyabort;
    (* like yyaccept, but causes parser to return with value 1, as if an
       unrecoverable syntax error had been encountered *)

    Procedure yyerrlab;
    (* causes error recovery to be started, as if a syntax error had been
       encountered *)

    Procedure yyerrok;
    (* when in error mode, resets the parser to its normal mode of
       operation *)

    Function yyparse: integer; Virtual; Abstract;

    (* Flags used internally by the parser routine: *)

  Protected
    yyerrflag: Integer;
    yyflag: TYYFlag;
  End; (* TCustomParser *)

Implementation

Procedure TCustomParser.yyerror( msg: String );
Begin
  yyerrormsg := msg;
  //writeln(yyLexer.yyerrorfile, msg);
End (*yyerrmsg*);

Procedure TCustomParser.yyclearin;
Begin
  yychar := -1;
End (*yyclearin*);

Procedure TCustomParser.yyaccept;
Begin
  yyflag := yyfaccept;
End (*yyaccept*);

Procedure TCustomParser.yyabort;
Begin
  yyflag := yyfabort;
End (*yyabort*);

Procedure TCustomParser.yyerrlab;
Begin
  yyflag := yyferror;
End (*yyerrlab*);

Procedure TCustomParser.yyerrok;
Begin
  yyerrflag := 0;
End (*yyerrork*);

End (*YaccLib*).
