object frmColorSettings: TfrmColorSettings
  Left = 172
  Top = 123
  BorderStyle = bsDialog
  Caption = 'Color settings'
  ClientHeight = 242
  ClientWidth = 511
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 55
    Height = 16
    Caption = '&Element :'
  end
  object Label2: TLabel
    Left = 212
    Top = 10
    Width = 39
    Height = 16
    Caption = '&Color :'
  end
  object OKBtn: TButton
    Left = 156
    Top = 202
    Width = 93
    Height = 31
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 255
    Top = 202
    Width = 92
    Height = 31
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ListBox1: TListBox
    Left = 10
    Top = 34
    Width = 188
    Height = 159
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
    Left = 374
    Top = 30
    Width = 124
    Height = 119
    Caption = 'Text attributes'
    TabOrder = 3
    object ChkBold: TCheckBox
      Left = 10
      Top = 25
      Width = 90
      Height = 21
      Caption = '&Bold'
      TabOrder = 0
    end
    object ChkItalic: TCheckBox
      Left = 10
      Top = 54
      Width = 60
      Height = 21
      Caption = '&Italic'
      TabOrder = 1
    end
    object ChkUnderline: TCheckBox
      Left = 10
      Top = 84
      Width = 90
      Height = 21
      Caption = '&Underline'
      TabOrder = 2
    end
  end
  object ColorGrid1: TColorGrid
    Left = 207
    Top = 34
    Width = 160
    Height = 156
    BackgroundEnabled = False
    TabOrder = 4
  end
end
