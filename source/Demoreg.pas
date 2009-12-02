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

unit DemoReg;

{$I XQ_FLAG.INC}
interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, shellapi, ExtCtrls;

type
  TfrmRegister = class(TForm)
    OKBtn: TButton;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Memo1: TMemo;
    procedure Label2Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure WriteToUs;
  procedure WriteToUs2;
  procedure WriteToUs3;
  procedure HomePage;

var
  frmRegister: TfrmRegister;

implementation

{$R *.DFM}

const
  RegistrationURL = 'https://secure.element5.com/register.html?productid=143123&language=English';
  WriteToUsURL='mailto: amoreno@sigmap.com';
  WriteToUsURL2='mailto: luisarvayo@yahoo.com';
  WriteToUsURL3='mailto: gismap@hmo.megared.net.mx';
  HomePageURL= 'http://www.sigmap.com/txquery.htm';

procedure JumpToURL(const s : string);
begin
  ShellExecute(Application.Handle, nil, PChar(s), nil, nil, SW_SHOW);
end;

procedure WriteToUs;
begin
  JumpToURL(WriteToUsURL);
end;

procedure WriteToUs2;
begin
  JumpToURL(WriteToUsURL2);
end;

procedure WriteToUs3;
begin
  JumpToURL(WriteToUsURL3);
end;

procedure HomePage;
begin
  JumpToURL(HomePageURL);
end;

procedure OnlineRegistration;
begin
  JumpToURL(RegistrationURL);
end;

procedure TfrmRegister.Label2Click(Sender: TObject);
begin
   OnlineRegistration;
end;

procedure TfrmRegister.Label4Click(Sender: TObject);
begin
   WriteToUs;
end;

procedure TfrmRegister.Label5Click(Sender: TObject);
begin
   WriteToUs2;
end;

procedure TfrmRegister.Label6Click(Sender: TObject);
begin
   WriteToUs3;
end;

procedure TfrmRegister.Label7Click(Sender: TObject);
begin
  HomePage;
end;

end.
