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
{   The Original Code is: DemoAb.pas                                          }
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

unit AboutFrm;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TfrmAbout = class(TForm)
    Bevel1: TBevel;
    btnOK: TButton;
    btnHelp: TButton;
    Memo1: TMemo;
    Label2: TLabel;
    lblProjectURL: TLabel;
    procedure btnHelpClick(Sender: TObject);
    procedure lblProjectURLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure JumpToURL(const s : string);
  end;

implementation

{$R *.DFM}

uses ShellAPI;

procedure TfrmAbout.btnHelpClick(Sender: TObject);
begin
   Application.HelpCommand(3,0);
end;

procedure TfrmAbout.JumpToURL(const s: string);
begin
  ShellExecute(Application.Handle, nil, PChar(s), nil, nil, SW_SHOW);
end;

procedure TfrmAbout.lblProjectURLClick(Sender: TObject);
begin
  JumpToURL(TLabel(Sender).Caption);
end;

end.
