object frmMain: TfrmMain
  Left = 89
  Top = 137
  ActiveControl = TreeView1
  Caption = 'TxQuery v3.0 Demo Application'
  ClientHeight = 662
  ClientWidth = 960
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 960
    Height = 662
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ActivePage = TabSheet1
    Align = alClient
    HotTrack = True
    MultiLine = True
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'SQL statements'
      object StatusBar1: TStatusBar
        Left = 0
        Top = 612
        Width = 952
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Panels = <>
        SimplePanel = True
      end
      object PageControlSQLExamples: TPageControl
        Left = 0
        Top = 0
        Width = 952
        Height = 612
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ActivePage = TabSheetSQLString
        Align = alClient
        TabOrder = 1
        OnChange = PageControlSQLExamplesChange
        object TabSheetSQLString: TTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'SQL String'
          object Panel8: TPanel
            Left = 0
            Top = 38
            Width = 267
            Height = 543
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            TabOrder = 0
            object TreeView1: TTreeView
              Left = 1
              Top = 1
              Width = 265
              Height = 541
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              Indent = 19
              TabOrder = 0
              OnChange = TreeView1Change
              OnClick = TreeView1Click
            end
          end
          object PanelSideButtons: TPanel
            Left = 0
            Top = 0
            Width = 944
            Height = 38
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alTop
            TabOrder = 1
            object Button2: TButton
              Left = 238
              Top = 4
              Width = 104
              Height = 30
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Color &settings...'
              TabOrder = 0
              OnClick = Button2Click
            end
            object Button5: TButton
              Left = 353
              Top = 4
              Width = 105
              Height = 30
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = '&Meanings...'
              TabOrder = 1
              OnClick = Button5Click
            end
            object BtnQBuilder: TButton
              Left = 122
              Top = 4
              Width = 104
              Height = 30
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Query Builder...'
              TabOrder = 2
              OnClick = BtnQBuilderClick
            end
            object ButtonRunSQL: TBitBtn
              Left = 12
              Top = 4
              Width = 105
              Height = 30
              Hint = 'Run SQL with Open method'
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Run SQL'
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              OnClick = ButtonRunSQLClick
              Glyph.Data = {
                2E060000424D2E06000000000000360400002800000015000000150000000100
                080000000000F801000000000000000000000001000000010000000000000000
                80000080000000808000800000008000800080800000C0C0C000688DA200BBCC
                D500000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000DDE6EA00A4A0A000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
                FDFDFDFDFDFDFDFDFDFDFDFDFDFDFD01B602FDFDFDFDFDFDFDFDFDFDFDFDFDFD
                FDFDFDFDFDFDFD000400FDFDFDFDFDFDFDFD00F8FDFDFDFDFDFDFDFDFDFDFD00
                8401FDFDFDFDFDFDFDFD0000F8FDFDFDFDFDFDFDFDFDFD013301FDFDFDFDFDFD
                FDFDFD0000F8FDFDFDFDFDFDFDFDFD007200FDFDFDFDFDFDFDFDFD00FB00F8FD
                FDFDFDFDFDFDFD00DB00FDFDFDFDFDFDFD00000000FB00F8FDFDFDFDFDFDFD02
                B602FDFDFDFDFDFDFD00FBFBFFFBFB00F8FDFDFDFDFDFD00DB00FDFDFDFDFDFD
                FDFD00FFFB00000000FDFDFDFDFDFD01B701FDFDFDFDFDFDFDFD00FBFFFB00F8
                FDFDFDFDFDFDFD02B602FDFDFDFDFD0000000000FBFFFB00F8FDFDFDFDFDFD01
                6901FDFDFDFDFD00FFFBFFFBFFFBFFFB00F8FDFDFDFDFD000200FDFDFDFDFDFD
                00FFFBFFFB00000000FDFDFDFDFDFD4EB781FDFDFDFDFDFD00FBFFFBFFFB00F8
                FDFDFDFDFDFDFD015201FDFDFDFDFDFDFD00FBFFFBFFFB00F8FDFDFDFDFDFD01
                5201FDFDFDFDFDFDFD00FFFFFFFBFFFF00F8FDFDFDFDFD01C202FDFDFDFDFDFD
                FDFD00FFFBFFFFFBFF00F8FDFDFDFD005201FDFDFDFDFDFDFDFD000000000000
                000000FDFDFDFD00AA00FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD02
                F102FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD000600FDFDFDFDFDFD
                FDFDFDFDFDFDFDFDFDFDFDFDFDFDFD74B681}
            end
            object ChkParse: TCheckBox
              Left = 528
              Top = 9
              Width = 169
              Height = 16
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = '&Parse SQL'
              TabOrder = 4
              OnClick = ChkParseClick
            end
          end
          object Panel11: TPanel
            Left = 267
            Top = 38
            Width = 677
            Height = 543
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            TabOrder = 2
            object Splitter1: TSplitter
              Left = 1
              Top = 356
              Width = 675
              Height = 5
              Cursor = crVSplit
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alBottom
              Visible = False
              ExplicitTop = 337
              ExplicitWidth = 671
            end
            object RichEdit1: TRichEdit
              Left = 1
              Top = 1
              Width = 675
              Height = 355
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -15
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              Lines.Strings = (
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' '
                ' ')
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
            end
            object Panel12: TPanel
              Left = 1
              Top = 361
              Width = 675
              Height = 181
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alBottom
              TabOrder = 1
              Visible = False
              object MemoParse: TMemo
                Left = 169
                Top = 1
                Width = 505
                Height = 179
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alClient
                Font.Charset = ANSI_CHARSET
                Font.Color = clMaroon
                Font.Height = -18
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ScrollBars = ssBoth
                TabOrder = 0
              end
              object TreeView2: TTreeView
                Left = 1
                Top = 1
                Width = 168
                Height = 179
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alLeft
                Indent = 19
                TabOrder = 1
                OnClick = TreeView2Click
              end
            end
          end
        end
        object TabSheetResultDataSet: TTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Result Set'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel9: TPanel
            Left = 0
            Top = 0
            Width = 940
            Height = 570
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            Caption = 'Panel9'
            TabOrder = 0
            object DBGrid1: TDBGrid
              Left = 1
              Top = 1
              Width = 938
              Height = 541
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              DataSource = DataSource1
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
              ParentFont = False
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
            end
            object Panel10: TPanel
              Left = 1
              Top = 542
              Width = 938
              Height = 27
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alBottom
              TabOrder = 1
              object SpeedButton1: TSpeedButton
                Left = 256
                Top = 1
                Width = 119
                Height = 26
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Caption = 'To &HTML...'
                Flat = True
                OnClick = SpeedButton1Click
              end
              object DBNavigator1: TDBNavigator
                Left = 1
                Top = 1
                Width = 251
                Height = 25
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                DataSource = DataSource1
                VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbPost, nbCancel, nbRefresh]
                Align = alLeft
                TabOrder = 0
              end
              object Panel1: TPanel
                Left = 449
                Top = 1
                Width = 488
                Height = 25
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alRight
                BevelOuter = bvNone
                TabOrder = 1
                object Bar1: TProgressBar
                  Left = 0
                  Top = 0
                  Width = 487
                  Height = 25
                  Margins.Left = 2
                  Margins.Top = 2
                  Margins.Right = 2
                  Margins.Bottom = 2
                  Align = alClient
                  TabOrder = 0
                  Visible = False
                end
                object Button1: TButton
                  Left = 28
                  Top = 0
                  Width = 75
                  Height = 25
                  Margins.Left = 2
                  Margins.Top = 2
                  Margins.Right = 2
                  Margins.Bottom = 2
                  Caption = 'Delete'
                  TabOrder = 1
                  OnClick = Button1Click
                end
              end
            end
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Filtering and Finding'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 952
        Height = 78
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 950
        object Label1: TLabel
          Left = 118
          Top = 20
          Width = 104
          Height = 16
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Caption = 'Filter expression :'
        end
        object Label3: TLabel
          Left = 118
          Top = 48
          Width = 101
          Height = 16
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Caption = 'Find &expression :'
        end
        object Button3: TButton
          Left = 4
          Top = 4
          Width = 94
          Height = 30
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Filter'
          TabOrder = 0
          OnClick = Button3Click
        end
        object ComboBox1: TComboBox
          Left = 222
          Top = 10
          Width = 473
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          DropDownCount = 10
          ItemHeight = 0
          TabOrder = 1
          Items.Strings = (
            '(CustNo >= 1500) And (CustNo <= 3000)'
            '[LIKE](Company,'#39'%Under%'#39','#39#39')'
            'NOT SQLLIKE(Company,'#39'%Under%'#39','#39#39')'
            'ISLIKE(Company,'#39'A_%Under%'#39','#39#39')'
            
              '[IN](City, '#39'Kapaa Kauai'#39', '#39'Freeport'#39', '#39'Bogota'#39', '#39'Sarasota'#39', '#39'Neg' +
              'ril'#39', '#39'Largo'#39')'
            
              'NOT [IN](City, '#39'Kapaa Kauai'#39', '#39'Freeport'#39', '#39'Bogota'#39', '#39'Sarasota'#39', ' +
              #39'Negril'#39', '#39'Largo'#39')'
            'InSet(CustNo, 1356, 1624, 1510, 2984, 2975)'
            'LastInvoiceDate < Now')
        end
        object Edit1: TEdit
          Left = 222
          Top = 38
          Width = 473
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabOrder = 2
          Text = 'Addr1 = '#39'32 Main St.'#39
        end
        object Button6: TButton
          Left = 4
          Top = 38
          Width = 94
          Height = 31
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '&Find'
          TabOrder = 3
          OnClick = Button6Click
        end
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 78
        Width = 952
        Height = 553
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = DataSource1
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object TabSheet3: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Extended identifiers and blob fields'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBGrid3: TDBGrid
        Left = 0
        Top = 496
        Width = 952
        Height = 135
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        DataSource = DataSource2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Panel3: TPanel
        Left = 0
        Top = 78
        Width = 952
        Height = 36
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 1
        ExplicitWidth = 950
        object DBNavigator2: TDBNavigator
          Left = 10
          Top = 10
          Width = 276
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          DataSource = DataSource2
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          TabOrder = 0
        end
        object Button4: TButton
          Left = 295
          Top = 4
          Width = 174
          Height = 30
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Create result set'
          TabOrder = 1
          OnClick = Button4Click
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 114
        Width = 331
        Height = 382
        Hint = 'Scroll grid below to see other fish'
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        ExplicitHeight = 375
        object DBLabel1: TDBText
          Left = 1
          Top = 347
          Width = 329
          Height = 30
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alBottom
          DataField = 'Common_Name'
          DataSource = DataSource2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -23
          Font.Name = 'MS Serif'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
        end
        object DBImage1: TDBImage
          Left = 1
          Top = 1
          Width = 329
          Height = 346
          Hint = 'Scroll grid below to see other fish'
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          DataField = 'Graphic'
          DataSource = DataSource2
          TabOrder = 0
        end
      end
      object Panel6: TPanel
        Left = 331
        Top = 114
        Width = 549
        Height = 382
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        BevelOuter = bvLowered
        Caption = 'Panel6'
        TabOrder = 3
        ExplicitHeight = 375
        object DBMemo1: TDBMemo
          Left = 1
          Top = 28
          Width = 547
          Height = 349
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          BorderStyle = bsNone
          Color = clSilver
          Ctl3D = False
          DataField = 'Notes'
          DataSource = DataSource2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object Panel5: TPanel
          Left = 1
          Top = 1
          Width = 547
          Height = 27
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          TabOrder = 1
          object Label2: TLabel
            Left = 9
            Top = 5
            Width = 66
            Height = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Caption = 'About the'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBLabel2: TDBText
            Left = 82
            Top = 5
            Width = 69
            Height = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            AutoSize = True
            DataField = 'Common_Name'
            DataSource = DataSource2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      object RichEdit2: TRichEdit
        Left = 0
        Top = 0
        Width = 952
        Height = 78
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        Lines.Strings = (
          
            'SELECT [Species No], Category, Common_Name, [Species Name], [Len' +
            'gth (cm)], '
          'Length_In, '
          'Notes, Graphic'
          'FROM Biolife ;')
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
    end
    object TabSheet4: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Params'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label4: TLabel
        Left = 5
        Top = 42
        Width = 120
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Caption = 'LOWRANGE value :'
      end
      object Label5: TLabel
        Left = 276
        Top = 42
        Width = 123
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Caption = 'HIGHRANGE value :'
      end
      object RichEdit3: TRichEdit
        Left = 0
        Top = 0
        Width = 952
        Height = 30
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        Lines.Strings = (
          
            'SELECT * FROM CUSTOMER WHERE CustNo BETWEEN :LOWRANGE AND  :HIGH' +
            'RANGE;')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object DBGrid4: TDBGrid
        Left = 0
        Top = 172
        Width = 952
        Height = 459
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        DataSource = DataSource3
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Edit2: TEdit
        Left = 138
        Top = 32
        Width = 104
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '1000'
      end
      object Edit3: TEdit
        Left = 409
        Top = 32
        Width = 104
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '3000'
      end
      object Button7: TButton
        Left = 539
        Top = 32
        Width = 134
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Create result set'
        TabOrder = 4
        OnClick = Button7Click
      end
    end
    object TabSheet5: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'DataSource property'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label6: TLabel
        Left = 0
        Top = 309
        Width = 952
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Align = alTop
        Caption = 
          'In this query, the lowest DBGrid is connected to a TxQuery that ' +
          'is linked to Customers Table with DataSource property.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 692
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 952
        Height = 121
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 950
        object Button8: TButton
          Left = 692
          Top = 5
          Width = 90
          Height = 31
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Open query'
          TabOrder = 0
          OnClick = Button8Click
        end
        object RichEdit4: TRichEdit
          Left = 1
          Top = 1
          Width = 687
          Height = 119
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alLeft
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Verdana'
          Font.Style = []
          Lines.Strings = (
            'SELECT * FROM Orders WHERE CustNo = :CustNo;')
          ParentFont = False
          TabOrder = 1
        end
      end
      object DBGrid5: TDBGrid
        Left = 0
        Top = 121
        Width = 952
        Height = 188
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        DataSource = DataSource4
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object DBGrid6: TDBGrid
        Left = 0
        Top = 347
        Width = 952
        Height = 284
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = DataSource5
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object DBNavigator3: TDBNavigator
        Left = 0
        Top = 325
        Width = 952
        Height = 22
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        DataSource = DataSource4
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
        Align = alTop
        TabOrder = 3
        ExplicitWidth = 950
      end
    end
  end
  object XQuery1: TxQuery
    ParamCheck = False
    About = 'TxQuery Version 3.0'
    AutoDisableControls = False
    ParamsAsFields = <>
    FormatSettings.Parser.DateSeparator = '-'
    FormatSettings.Parser.TimeSeparator = ':'
    FormatSettings.Parser.ShortDateFormat = 'yyyy-mm-dd'
    FormatSettings.Parser.LongDateFormat = 'dddd, dd'#39' de '#39'MMMM'#39' de '#39'yyyy'
    FormatSettings.Parser.LongTimeFormat = 'hh:mm:ss AMPM'
    FormatSettings.Parser.TimeAMString = 'a.m.'
    FormatSettings.Parser.TimePMString = 'p.m.'
    FormatSettings.Parser.ShortTimeFormat = 'hh:mm AMPM'
    FormatSettings.Parser.ThousandSeparator = ','
    FormatSettings.Parser.DecimalSeparator = '.'
    FormatSettings.System.CurrencyString = '$'
    FormatSettings.System.CurrencyFormat = 0
    FormatSettings.System.CurrencyDecimals = 2
    FormatSettings.System.DateSeparator = '-'
    FormatSettings.System.TimeSeparator = ':'
    FormatSettings.System.ListSeparator = ','
    FormatSettings.System.ShortDateFormat = 'yyyy-mm-dd'
    FormatSettings.System.LongDateFormat = 'dddd, dd'#39' de '#39'MMMM'#39' de '#39'yyyy'
    FormatSettings.System.TimeAMString = 'a.m.'
    FormatSettings.System.TimePMString = 'p.m.'
    FormatSettings.System.ShortTimeFormat = 'hh:mm AMPM'
    FormatSettings.System.LongTimeFormat = 'hh:mm:ss AMPM'
    FormatSettings.System.ThousandSeparator = ','
    FormatSettings.System.DecimalSeparator = '.'
    FormatSettings.System.TwoDigitYearCenturyWindow = 50
    FormatSettings.System.NegCurrFormat = 1
    OnUDFCheck = XQuery1UDFCheck
    OnUDFSolve = XQuery1UDFSolve
    OnProgress = XQuery1Progress
    OnSyntaxError = XQuery1SyntaxError
    OnCancelQuery = XQuery1CancelQuery
    OnResolveDataset = XQuery1ResolveDataset
    DataSets = <
      item
        Alias = 'Customer'
        DataSet = customer
      end
      item
        Alias = 'Orders'
        DataSet = orders
      end
      item
        Alias = 'Items'
        DataSet = items
      end
      item
        Alias = 'Parts'
        DataSet = parts
      end>
    OnIndexNeededFor = XQuery1IndexNeededFor
    OnSetRange = XQuery1SetRange
    OnCancelRange = XQuery1CancelRange
    OnCreateTable = XQuery1CreateTable
    OnCreateIndex = XQuery1CreateIndex
    OnDropTable = XQuery1DropTable
    OnDropIndex = XQuery1DropIndex
    OnSetFilter = XQuery1SetFilter
    OnCancelFilter = XQuery1CancelFilter
    Left = 339
    Top = 150
  end
  object DataSource1: TDataSource
    DataSet = XQuery1
    Left = 339
    Top = 210
  end
  object XQuery2: TxQuery
    SQL.Strings = (
      'SELECT * FROM Biolife;')
    About = 'TxQuery Version 3.0'
    AutoDisableControls = False
    ParamsAsFields = <>
    FormatSettings.Parser.DateSeparator = '-'
    FormatSettings.Parser.TimeSeparator = ':'
    FormatSettings.Parser.ShortDateFormat = 'yyyy-mm-dd'
    FormatSettings.Parser.LongDateFormat = 'dddd, dd'#39' de '#39'MMMM'#39' de '#39'yyyy'
    FormatSettings.Parser.LongTimeFormat = 'hh:mm:ss AMPM'
    FormatSettings.Parser.TimeAMString = 'a.m.'
    FormatSettings.Parser.TimePMString = 'p.m.'
    FormatSettings.Parser.ShortTimeFormat = 'hh:mm AMPM'
    FormatSettings.Parser.ThousandSeparator = ','
    FormatSettings.Parser.DecimalSeparator = '.'
    FormatSettings.System.CurrencyString = '$'
    FormatSettings.System.CurrencyFormat = 0
    FormatSettings.System.CurrencyDecimals = 2
    FormatSettings.System.DateSeparator = '-'
    FormatSettings.System.TimeSeparator = ':'
    FormatSettings.System.ListSeparator = ','
    FormatSettings.System.ShortDateFormat = 'yyyy-mm-dd'
    FormatSettings.System.LongDateFormat = 'dddd, dd'#39' de '#39'MMMM'#39' de '#39'yyyy'
    FormatSettings.System.TimeAMString = 'a.m.'
    FormatSettings.System.TimePMString = 'p.m.'
    FormatSettings.System.ShortTimeFormat = 'hh:mm AMPM'
    FormatSettings.System.LongTimeFormat = 'hh:mm:ss AMPM'
    FormatSettings.System.ThousandSeparator = ','
    FormatSettings.System.DecimalSeparator = '.'
    FormatSettings.System.TwoDigitYearCenturyWindow = 50
    FormatSettings.System.NegCurrFormat = 1
    DataSets = <
      item
        Alias = 'Biolife'
        DataSet = biolife
      end>
    Left = 418
    Top = 150
  end
  object DataSource2: TDataSource
    DataSet = XQuery2
    Left = 418
    Top = 210
  end
  object MainMenu1: TMainMenu
    Left = 655
    Top = 94
    object File1: TMenuItem
      Caption = '&File'
      object Saveresultsetastext1: TMenuItem
        Caption = '&Save result set as text...'
        OnClick = Saveresultsetastext1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object Contents1: TMenuItem
        Caption = '&Contents...'
        OnClick = Contents1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object About1: TMenuItem
        Caption = '&About...'
        OnClick = About1Click
      end
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 363
    Top = 318
  end
  object SyntaxHighlighter1: TSyntaxHighlighter
    UpdateMode = umLine
    Editor = RichEdit1
    XQuery = XQuery1
    FormatSettings.Parser.DateSeparator = '-'
    FormatSettings.Parser.TimeSeparator = ':'
    FormatSettings.Parser.ShortDateFormat = 'yyyy-mm-dd'
    FormatSettings.Parser.LongDateFormat = 'dddd, dd'#39' de '#39'MMMM'#39' de '#39'yyyy'
    FormatSettings.Parser.LongTimeFormat = 'hh:mm:ss AMPM'
    FormatSettings.Parser.TimeAMString = 'a.m.'
    FormatSettings.Parser.TimePMString = 'p.m.'
    FormatSettings.Parser.ShortTimeFormat = 'hh:mm AMPM'
    FormatSettings.Parser.ThousandSeparator = ','
    FormatSettings.Parser.DecimalSeparator = '.'
    OnPosChange = SyntaxHighlighter1PosChange
    Left = 655
    Top = 218
  end
  object xQuery3: TxQuery
    SQL.Strings = (
      
        'SELECT * FROM CUSTOMER WHERE CustNo BETWEEN :LOWRANGE AND  :HIGH' +
        'RANGE;')
    About = 'TxQuery Version 3.0'
    AutoDisableControls = False
    ParamsAsFields = <>
    FormatSettings.Parser.DateSeparator = '/'
    FormatSettings.Parser.TimeSeparator = ':'
    FormatSettings.Parser.ShortDateFormat = 'm/d/yyyy'
    FormatSettings.Parser.LongDateFormat = 'dddd, dd'#39' de '#39'MMMM'#39' de '#39'yyyy'
    FormatSettings.Parser.LongTimeFormat = 'hh:mm:ss AMPM'
    FormatSettings.Parser.TimeAMString = 'a.m.'
    FormatSettings.Parser.TimePMString = 'p.m.'
    FormatSettings.Parser.ShortTimeFormat = 'hh:mm AMPM'
    FormatSettings.Parser.ThousandSeparator = ','
    FormatSettings.Parser.DecimalSeparator = '.'
    FormatSettings.System.CurrencyString = '$'
    FormatSettings.System.CurrencyFormat = 0
    FormatSettings.System.CurrencyDecimals = 2
    FormatSettings.System.DateSeparator = '-'
    FormatSettings.System.TimeSeparator = ':'
    FormatSettings.System.ListSeparator = ','
    FormatSettings.System.ShortDateFormat = 'yyyy-mm-dd'
    FormatSettings.System.LongDateFormat = 'dddd, dd'#39' de '#39'MMMM'#39' de '#39'yyyy'
    FormatSettings.System.TimeAMString = 'a.m.'
    FormatSettings.System.TimePMString = 'p.m.'
    FormatSettings.System.ShortTimeFormat = 'hh:mm AMPM'
    FormatSettings.System.LongTimeFormat = 'hh:mm:ss AMPM'
    FormatSettings.System.ThousandSeparator = ','
    FormatSettings.System.DecimalSeparator = '.'
    FormatSettings.System.TwoDigitYearCenturyWindow = 50
    FormatSettings.System.NegCurrFormat = 1
    DataSets = <
      item
        Alias = 'Customer'
        DataSet = customer
      end>
    Left = 497
    Top = 150
  end
  object DataSource3: TDataSource
    DataSet = xQuery3
    Left = 497
    Top = 210
  end
  object DataSource4: TDataSource
    DataSet = customer
    Left = 260
    Top = 158
  end
  object DataSource5: TDataSource
    DataSet = xQuery4
    Left = 576
    Top = 210
  end
  object xQuery4: TxQuery
    DataSource = DataSource4
    SQL.Strings = (
      'SELECT * FROM Orders WHERE CustNo = :CustNo')
    About = 'TxQuery Version 3.0'
    AutoDisableControls = False
    ParamsAsFields = <>
    FormatSettings.Parser.DateSeparator = '/'
    FormatSettings.Parser.TimeSeparator = ':'
    FormatSettings.Parser.ShortDateFormat = 'm/d/yyyy'
    FormatSettings.Parser.LongDateFormat = 'dddd, dd'#39' de '#39'MMMM'#39' de '#39'yyyy'
    FormatSettings.Parser.LongTimeFormat = 'hh:mm:ss AMPM'
    FormatSettings.Parser.TimeAMString = 'a.m.'
    FormatSettings.Parser.TimePMString = 'p.m.'
    FormatSettings.Parser.ShortTimeFormat = 'hh:mm AMPM'
    FormatSettings.Parser.ThousandSeparator = ','
    FormatSettings.Parser.DecimalSeparator = '.'
    FormatSettings.System.CurrencyString = '$'
    FormatSettings.System.CurrencyFormat = 0
    FormatSettings.System.CurrencyDecimals = 2
    FormatSettings.System.DateSeparator = '-'
    FormatSettings.System.TimeSeparator = ':'
    FormatSettings.System.ListSeparator = ','
    FormatSettings.System.ShortDateFormat = 'yyyy-mm-dd'
    FormatSettings.System.LongDateFormat = 'dddd, dd'#39' de '#39'MMMM'#39' de '#39'yyyy'
    FormatSettings.System.TimeAMString = 'a.m.'
    FormatSettings.System.TimePMString = 'p.m.'
    FormatSettings.System.ShortTimeFormat = 'hh:mm AMPM'
    FormatSettings.System.LongTimeFormat = 'hh:mm:ss AMPM'
    FormatSettings.System.ThousandSeparator = ','
    FormatSettings.System.DecimalSeparator = '.'
    FormatSettings.System.TwoDigitYearCenturyWindow = 50
    FormatSettings.System.NegCurrFormat = 1
    BeforeInsert = xQuery4BeforeInsert
    DataSets = <
      item
        Alias = 'Orders'
        DataSet = orders
      end>
    Left = 576
    Top = 150
    ParamData = <
      item
        DataType = ftString
        Name = 'CustNo'
        ParamType = ptUnknown
      end>
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.TXT)|*.txt'
    Title = 'Save result set to text file'
    Left = 655
    Top = 150
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = 'htm'
    Filter = 'HTM files (*.htm)|*.htm'
    Title = 'Export to HTML'
    Left = 344
    Top = 376
  end
  object customer: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CustNo'
        Attributes = [faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'Company'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Addr1'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Addr2'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'City'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'State'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Zip'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Country'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Phone'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'FAX'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'TaxRate'
        Attributes = [faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'Contact'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LastInvoiceDate'
        Attributes = [faUnNamed]
        DataType = ftDateTime
      end>
    IndexDefs = <
      item
        Name = 'ByCompany'
        Fields = 'company'
      end>
    IndexName = 'ByCompany'
    ObjectView = False
    Params = <>
    StoreDefs = True
    Left = 336
    Top = 96
    object customerCustNo: TFloatField
      FieldName = 'CustNo'
    end
    object customerCompany: TStringField
      FieldName = 'Company'
      Size = 30
    end
    object customerAddr1: TStringField
      FieldName = 'Addr1'
      Size = 30
    end
    object customerAddr2: TStringField
      FieldName = 'Addr2'
      Size = 30
    end
    object customerCity: TStringField
      FieldName = 'City'
      Size = 15
    end
    object customerState: TStringField
      FieldName = 'State'
    end
    object customerZip: TStringField
      FieldName = 'Zip'
      Size = 10
    end
    object customerCountry: TStringField
      FieldName = 'Country'
    end
    object customerPhone: TStringField
      FieldName = 'Phone'
      Size = 15
    end
    object customerFAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object customerTaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object customerContact: TStringField
      FieldName = 'Contact'
    end
    object customerLastInvoiceDate: TDateTimeField
      FieldName = 'LastInvoiceDate'
    end
  end
  object orders: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'OrderNo'
        Attributes = [faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'CustNo'
        Attributes = [faRequired, faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'SaleDate'
        Attributes = [faUnNamed]
        DataType = ftDateTime
      end
      item
        Name = 'ShipDate'
        Attributes = [faUnNamed]
        DataType = ftDateTime
      end
      item
        Name = 'EmpNo'
        Attributes = [faRequired, faUnNamed]
        DataType = ftInteger
      end
      item
        Name = 'ShipToContact'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ShipToAddr1'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ShipToAddr2'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ShipToCity'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'ShipToState'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ShipToZip'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ShipToCountry'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ShipToPhone'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'ShipVIA'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 7
      end
      item
        Name = 'PO'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Terms'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 6
      end
      item
        Name = 'PaymentMethod'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 7
      end
      item
        Name = 'ItemsTotal'
        Attributes = [faUnNamed]
        DataType = ftCurrency
      end
      item
        Name = 'TaxRate'
        Attributes = [faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'Freight'
        Attributes = [faUnNamed]
        DataType = ftCurrency
      end
      item
        Name = 'AmountPaid'
        Attributes = [faUnNamed]
        DataType = ftCurrency
      end>
    IndexDefs = <>
    ObjectView = False
    Params = <>
    StoreDefs = True
    Left = 408
    Top = 96
    object ordersOrderNo: TFloatField
      FieldName = 'OrderNo'
    end
    object ordersCustNo: TFloatField
      FieldName = 'CustNo'
      Required = True
    end
    object ordersSaleDate: TDateTimeField
      FieldName = 'SaleDate'
    end
    object ordersShipDate: TDateTimeField
      FieldName = 'ShipDate'
    end
    object ordersEmpNo: TIntegerField
      FieldName = 'EmpNo'
      Required = True
    end
    object ordersShipToContact: TStringField
      FieldName = 'ShipToContact'
    end
    object ordersShipToAddr1: TStringField
      FieldName = 'ShipToAddr1'
      Size = 30
    end
    object ordersShipToAddr2: TStringField
      FieldName = 'ShipToAddr2'
      Size = 30
    end
    object ordersShipToCity: TStringField
      FieldName = 'ShipToCity'
      Size = 15
    end
    object ordersShipToState: TStringField
      FieldName = 'ShipToState'
    end
    object ordersShipToZip: TStringField
      FieldName = 'ShipToZip'
      Size = 10
    end
    object ordersShipToCountry: TStringField
      FieldName = 'ShipToCountry'
    end
    object ordersShipToPhone: TStringField
      FieldName = 'ShipToPhone'
      Size = 15
    end
    object ordersShipVIA: TStringField
      FieldName = 'ShipVIA'
      Size = 7
    end
    object ordersPO: TStringField
      FieldName = 'PO'
      Size = 15
    end
    object ordersTerms: TStringField
      FieldName = 'Terms'
      Size = 6
    end
    object ordersPaymentMethod: TStringField
      FieldName = 'PaymentMethod'
      Size = 7
    end
    object ordersItemsTotal: TCurrencyField
      FieldName = 'ItemsTotal'
    end
    object ordersTaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object ordersFreight: TCurrencyField
      FieldName = 'Freight'
    end
    object ordersAmountPaid: TCurrencyField
      FieldName = 'AmountPaid'
    end
  end
  object items: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'OrderNo'
        DataType = ftFloat
      end
      item
        Name = 'ItemNo'
        DataType = ftFloat
      end
      item
        Name = 'PartNo'
        DataType = ftFloat
      end
      item
        Name = 'Qty'
        DataType = ftInteger
      end
      item
        Name = 'Discount'
        DataType = ftFloat
      end>
    IndexDefs = <>
    ObjectView = False
    Params = <>
    StoreDefs = True
    Left = 496
    Top = 96
    object itemsOrderNo: TFloatField
      FieldName = 'OrderNo'
    end
    object itemsItemNo: TFloatField
      FieldName = 'ItemNo'
    end
    object itemsPartNo: TFloatField
      FieldName = 'PartNo'
    end
    object itemsQty: TIntegerField
      FieldName = 'Qty'
    end
    object itemsDiscount: TFloatField
      FieldName = 'Discount'
    end
  end
  object parts: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PartNo'
        Attributes = [faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'VendorNo'
        Attributes = [faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'Description'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'OnHand'
        Attributes = [faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'OnOrder'
        Attributes = [faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'Cost'
        Attributes = [faUnNamed]
        DataType = ftCurrency
      end
      item
        Name = 'ListPrice'
        Attributes = [faUnNamed]
        DataType = ftCurrency
      end>
    IndexDefs = <>
    ObjectView = False
    Params = <>
    StoreDefs = True
    Left = 568
    Top = 96
    object partsPartNo: TFloatField
      FieldName = 'PartNo'
    end
    object partsVendorNo: TFloatField
      FieldName = 'VendorNo'
    end
    object partsDescription: TStringField
      FieldName = 'Description'
      Size = 30
    end
    object partsOnHand: TFloatField
      FieldName = 'OnHand'
    end
    object partsOnOrder: TFloatField
      FieldName = 'OnOrder'
    end
    object partsCost: TCurrencyField
      FieldName = 'Cost'
    end
    object partsListPrice: TCurrencyField
      FieldName = 'ListPrice'
    end
  end
  object biolife: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Species No'
        Attributes = [faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'Category'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Common_Name'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Species Name'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 40
      end
      item
        Name = 'Length (cm)'
        Attributes = [faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'Length_In'
        Attributes = [faUnNamed]
        DataType = ftFloat
      end
      item
        Name = 'Notes'
        Attributes = [faUnNamed]
        DataType = ftMemo
        Size = 50
      end
      item
        Name = 'Graphic'
        Attributes = [faUnNamed]
        DataType = ftGraphic
      end>
    IndexDefs = <>
    ObjectView = False
    Params = <>
    StoreDefs = True
    Left = 336
    Top = 272
    object biolifeSpeciesNo: TFloatField
      FieldName = 'Species No'
    end
    object biolifeCategory: TStringField
      FieldName = 'Category'
      Size = 15
    end
    object biolifeCommon_Name: TStringField
      FieldName = 'Common_Name'
      Size = 30
    end
    object biolifeSpeciesName: TStringField
      FieldName = 'Species Name'
      Size = 40
    end
    object biolifeLengthcm: TFloatField
      FieldName = 'Length (cm)'
    end
    object biolifeLength_In: TFloatField
      FieldName = 'Length_In'
    end
    object biolifeNotes: TMemoField
      FieldName = 'Notes'
      BlobType = ftMemo
      Size = 50
    end
    object biolifeGraphic: TGraphicField
      FieldName = 'Graphic'
      BlobType = ftGraphic
    end
  end
end
