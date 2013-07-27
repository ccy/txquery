object frmAbout: TfrmAbout
  Left = 262
  Top = 198
  HelpContext = 10
  BorderStyle = bsDialog
  Caption = 'About TxQuery'
  ClientHeight = 347
  ClientWidth = 529
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    529
    347)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 10
    Top = 7
    Width = 430
    Height = 330
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object Label2: TLabel
    Left = 19
    Top = 292
    Width = 286
    Height = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Anchors = [akLeft, akBottom]
    Caption = 'For questions, comments and support issues, please go to: '
  end
  object lblProjectURL: TLabel
    Left = 19
    Top = 310
    Width = 202
    Height = 13
    Cursor = crHandPoint
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Anchors = [akLeft, akBottom]
    Caption = 'http://code.google.com/p/txquery/'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    OnClick = lblProjectURLClick
  end
  object btnOK: TButton
    Left = 447
    Top = 8
    Width = 75
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnHelp: TButton
    Left = 447
    Top = 40
    Width = 75
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akTop, akRight]
    Caption = '&Help'
    TabOrder = 1
    OnClick = btnHelpClick
  end
  object Memo1: TMemo
    Left = 17
    Top = 15
    Width = 415
    Height = 269
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clBtnFace
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'TxQuery Component Version 3.0'
      'The Initial Developer of the Original Code is Alfonso Moreno.'
      ''
      
        'Portions created by Alfonso Moreno are Copyright (C) <1999-2003>' +
        ' of Alfonso Moreno.'
      'All Rights Reserved.'
      ''
      
        'Open Source patch reviews (2009-2012) with permission from Alfon' +
        'so Moreno '
      ''
      '   Alfonso Moreno (Hermosillo, Sonora, Mexico)'
      
        '   email: luisarvayo@yahoo.com                                  ' +
        '            '
      '     url: http://www.ezsoft.com '
      
        '           http://www.sigmap.com/txquery.htm                    ' +
        '       '
      '                                                  '
      '   Contributor(s): '
      '                   Chee-Yang, CHAU (Malaysia) <cychau@gmail.com>'
      '                   Sherlyn CHEW (Malaysia)'
      
        '                   Francisco Armando Due'#241'as Rodriguez (Mexico) <' +
        'fduenas@gmail.com>'
      ''
      '              url: http://code.google.com/p/txquery/ '
      '                    http://groups.google.com/group/txquery/ ')
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
end
