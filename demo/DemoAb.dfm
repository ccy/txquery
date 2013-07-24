object frmAbout: TfrmAbout
  Left = 262
  Top = 198
  HelpContext = 10
  BorderStyle = bsDialog
  Caption = 'About TxQuery'
  ClientHeight = 260
  ClientWidth = 466
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object Bevel1: TBevel
    Left = 10
    Top = 10
    Width = 346
    Height = 239
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Shape = bsFrame
  end
  object Label2: TLabel
    Left = 30
    Top = 192
    Width = 235
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Caption = ' With questions and comments email to: '
  end
  object Label4: TLabel
    Left = 30
    Top = 217
    Width = 161
    Height = 16
    Cursor = crHandPoint
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Caption = 'amoreno@sigmap.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    OnClick = Label4Click
  end
  object OKBtn: TButton
    Left = 369
    Top = 10
    Width = 93
    Height = 31
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object HelpBtn: TButton
    Left = 369
    Top = 49
    Width = 93
    Height = 31
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '&Help'
    TabOrder = 1
    OnClick = HelpBtnClick
  end
  object Memo1: TMemo
    Left = 20
    Top = 20
    Width = 326
    Height = 163
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Color = clBtnFace
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'TxQuery Component Version 1.86'
      '(c) 2003 Alfonso Moreno'
      ''
      'This is an evaluation version of TxQuery. If you intend '
      'to use TxQuery after the trial period of 30 days, you '
      'must register your copy of TxQuery or stop using it. '
      'When you register TxQuery, you are eligible to '
      'receive '
      'Technical support as well as features for registered '
      'users can be used from then.'
      '')
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
end
