object frmColorSettings: TfrmColorSettings
  Left = 172
  Top = 123
  BorderStyle = bsDialog
  Caption = 'Color settings'
  ClientHeight = 197
  ClientWidth = 415
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 55
    Height = 16
    Caption = '&Element :'
  end
  object Label2: TLabel
    Left = 172
    Top = 8
    Width = 39
    Height = 16
    Caption = '&Color :'
  end
  object OKBtn: TButton
    Left = 127
    Top = 164
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 207
    Top = 164
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ListBox1: TListBox
    Left = 8
    Top = 28
    Width = 153
    Height = 129
    ItemHeight = 16
    Items.Strings = (
      'Whitespace'
      'Comment'
      'Reserved word'
      'Identifier'
      'Table'
      'Field'
      'String'
      'Number'
      'Comma'
      'Parenthesis'
      'Operator'
      'Semicolon'
      'Period')
    TabOrder = 2
    OnClick = ListBox1Click
  end
  object GroupBox1: TGroupBox
    Left = 304
    Top = 24
    Width = 101
    Height = 97
    Caption = 'Text attributes'
    TabOrder = 3
    object ChkBold: TCheckBox
      Left = 8
      Top = 20
      Width = 73
      Height = 17
      Caption = '&Bold'
      TabOrder = 0
    end
    object ChkItalic: TCheckBox
      Left = 8
      Top = 44
      Width = 49
      Height = 17
      Caption = '&Italic'
      TabOrder = 1
    end
    object ChkUnderline: TCheckBox
      Left = 8
      Top = 68
      Width = 73
      Height = 17
      Caption = '&Underline'
      TabOrder = 2
    end
  end
  object ColorGrid1: TColorGrid
    Left = 168
    Top = 28
    Width = 132
    Height = 128
    BackgroundEnabled = False
    TabOrder = 4
  end
end
