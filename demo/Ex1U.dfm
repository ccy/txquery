object frmTest: TfrmTest
  Left = 89
  Top = 137
  Caption = 'TxQuery v1.86 Demo'
  ClientHeight = 538
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 780
    Height = 538
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
        Top = 491
        Width = 772
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
        Width = 772
        Height = 491
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
            Top = 31
            Width = 170
            Height = 432
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            TabOrder = 0
            object TreeView1: TTreeView
              Left = 1
              Top = 1
              Width = 168
              Height = 430
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
            Width = 764
            Height = 31
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alTop
            TabOrder = 1
            object Button2: TButton
              Left = 193
              Top = 3
              Width = 85
              Height = 25
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Color &settings...'
              TabOrder = 0
              OnClick = Button2Click
            end
            object Button5: TButton
              Left = 287
              Top = 3
              Width = 85
              Height = 25
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = '&Meanings...'
              TabOrder = 1
              OnClick = Button5Click
            end
            object BtnQBuilder: TButton
              Left = 99
              Top = 3
              Width = 85
              Height = 25
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Query Builder...'
              TabOrder = 2
              OnClick = BtnQBuilderClick
            end
            object ButtonRunSQL: TBitBtn
              Left = 10
              Top = 3
              Width = 85
              Height = 25
              Hint = 'Run SQL with Open method'
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Run SQL'
              Enabled = False
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
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              OnClick = ButtonRunSQLClick
            end
            object ChkParse: TCheckBox
              Left = 429
              Top = 7
              Width = 137
              Height = 13
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
            Left = 170
            Top = 31
            Width = 594
            Height = 432
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            TabOrder = 2
            object Splitter1: TSplitter
              Left = 1
              Top = 280
              Width = 592
              Height = 4
              Cursor = crVSplit
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alBottom
              Visible = False
            end
            object RichEdit1: TRichEdit
              Left = 1
              Top = 1
              Width = 592
              Height = 279
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -12
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
                ' ')
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
            end
            object Panel12: TPanel
              Left = 1
              Top = 284
              Width = 592
              Height = 147
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alBottom
              TabOrder = 1
              Visible = False
              object MemoParse: TMemo
                Left = 137
                Top = 1
                Width = 454
                Height = 145
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alClient
                Font.Charset = ANSI_CHARSET
                Font.Color = clMaroon
                Font.Height = -15
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ScrollBars = ssBoth
                TabOrder = 0
              end
              object TreeView2: TTreeView
                Left = 1
                Top = 1
                Width = 136
                Height = 145
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
          object Panel9: TPanel
            Left = 0
            Top = 0
            Width = 764
            Height = 463
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
              Width = 762
              Height = 439
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              DataSource = DataSource1
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
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
              Top = 440
              Width = 762
              Height = 22
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alBottom
              TabOrder = 1
              object SpeedButton1: TSpeedButton
                Left = 208
                Top = 1
                Width = 97
                Height = 21
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
                Width = 204
                Height = 20
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
                Left = 365
                Top = 1
                Width = 396
                Height = 20
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
                  Width = 396
                  Height = 20
                  Margins.Left = 2
                  Margins.Top = 2
                  Margins.Right = 2
                  Margins.Bottom = 2
                  Align = alClient
                  TabOrder = 0
                  Visible = False
                end
                object Button1: TButton
                  Left = 23
                  Top = 0
                  Width = 61
                  Height = 20
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
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 772
        Height = 63
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 96
          Top = 16
          Width = 81
          Height = 13
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Caption = 'Filter expression :'
        end
        object Label3: TLabel
          Left = 96
          Top = 39
          Width = 79
          Height = 13
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Caption = 'Find &expression :'
        end
        object Button3: TButton
          Left = 3
          Top = 3
          Width = 77
          Height = 25
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Filter'
          TabOrder = 0
          OnClick = Button3Click
        end
        object ComboBox1: TComboBox
          Left = 180
          Top = 8
          Width = 385
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabOrder = 1
          Items.Strings = (
            '(CustNo >= 1500) And (CustNo <= 3000)'
            'LIKE(Company,'#39'%Under%'#39','#39#39')'
            'NOT LIKE(Company,'#39'%Under%'#39','#39#39')'
            'LIKE(Company,'#39'A_%Under%'#39','#39#39')'
            
              'IN(City, '#39'Kapaa Kauai'#39', '#39'Freeport'#39', '#39'Bogota'#39', '#39'Sarasota'#39', '#39'Negri' +
              'l'#39', '#39'Largo'#39')'
            
              'NOT IN(City, '#39'Kapaa Kauai'#39', '#39'Freeport'#39', '#39'Bogota'#39', '#39'Sarasota'#39', '#39'N' +
              'egril'#39', '#39'Largo'#39')'
            'IN(CustNo, 1356, 1624, 1510, 2984, 2975)'
            'LastInvoiceDate < Now'
            'LastInvoiceDate > StrToDate('#39'12/31/94'#39')')
        end
        object Edit1: TEdit
          Left = 180
          Top = 31
          Width = 385
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabOrder = 2
          Text = 'Addr1 = '#39'32 Main St.'#39
        end
        object Button6: TButton
          Left = 3
          Top = 31
          Width = 77
          Height = 25
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
        Top = 63
        Width = 772
        Height = 447
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = DataSource1
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
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
      object DBGrid3: TDBGrid
        Left = 0
        Top = 400
        Width = 772
        Height = 110
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        DataSource = DataSource2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
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
        Top = 63
        Width = 772
        Height = 30
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 1
        object DBNavigator2: TDBNavigator
          Left = 8
          Top = 8
          Width = 224
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          DataSource = DataSource2
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          TabOrder = 0
        end
        object Button4: TButton
          Left = 240
          Top = 3
          Width = 141
          Height = 25
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
        Top = 93
        Width = 269
        Height = 307
        Hint = 'Scroll grid below to see other fish'
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        object DBLabel1: TDBText
          Left = 1
          Top = 282
          Width = 267
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alBottom
          DataField = 'Common_Name'
          DataSource = DataSource2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'MS Serif'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
        end
        object DBImage1: TDBImage
          Left = 1
          Top = 1
          Width = 267
          Height = 281
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
        Left = 269
        Top = 93
        Width = 446
        Height = 307
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        BevelOuter = bvLowered
        Caption = 'Panel6'
        TabOrder = 3
        object DBMemo1: TDBMemo
          Left = 1
          Top = 23
          Width = 444
          Height = 283
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
          Font.Height = -12
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
          Width = 444
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          TabOrder = 1
          object Label2: TLabel
            Left = 7
            Top = 4
            Width = 56
            Height = 13
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Caption = 'About the'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBLabel2: TDBText
            Left = 67
            Top = 4
            Width = 56
            Height = 13
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            AutoSize = True
            DataField = 'Common_Name'
            DataSource = DataSource2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      object RichEdit2: TRichEdit
        Left = 0
        Top = 0
        Width = 772
        Height = 63
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
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
      object Label4: TLabel
        Left = 4
        Top = 34
        Width = 98
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Caption = 'LOWRANGE value :'
      end
      object Label5: TLabel
        Left = 224
        Top = 34
        Width = 100
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Caption = 'HIGHRANGE value :'
      end
      object RichEdit3: TRichEdit
        Left = 0
        Top = 0
        Width = 772
        Height = 24
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
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
        Top = 137
        Width = 772
        Height = 373
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        DataSource = DataSource3
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
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
        Left = 112
        Top = 26
        Width = 85
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '1000'
      end
      object Edit3: TEdit
        Left = 332
        Top = 26
        Width = 85
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '3000'
      end
      object Button7: TButton
        Left = 438
        Top = 26
        Width = 109
        Height = 21
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
      object Label6: TLabel
        Left = 0
        Top = 251
        Width = 772
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Align = alTop
        Caption = 
          'In this query, the lowest DBGrid is connected to a TxQuery that ' +
          'is linked to Customers Table with DataSource property.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 772
        Height = 98
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 0
        object Button8: TButton
          Left = 562
          Top = 4
          Width = 73
          Height = 25
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
          Width = 558
          Height = 96
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alLeft
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
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
        Top = 98
        Width = 772
        Height = 153
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        DataSource = DataSource4
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
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
        Top = 282
        Width = 772
        Height = 228
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = DataSource5
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
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
        Top = 264
        Width = 772
        Height = 18
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        DataSource = DataSource4
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
        Align = alTop
        TabOrder = 3
      end
    end
  end
  object XQuery1: TxQuery
    ParamCheck = False
    About = 'TxQuery Version 2.0 (Ene 2009)'
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
    FormatSettings.System.DateSeparator = '/'
    FormatSettings.System.TimeSeparator = ':'
    FormatSettings.System.ListSeparator = ','
    FormatSettings.System.ShortDateFormat = 'm/d/yyyy'
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
        DataSet = Table1
      end
      item
        Alias = 'Orders'
        DataSet = Table2
      end
      item
        Alias = 'Items'
        DataSet = Table3
      end
      item
        Alias = 'Parts'
        DataSet = Table4
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
    Top = 218
  end
  object XQuery2: TxQuery
    SQL.Strings = (
      'SELECT * FROM Biolife;')
    About = 'TxQuery Version 2.0 (Ene 2009)'
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
    FormatSettings.System.DateSeparator = '/'
    FormatSettings.System.TimeSeparator = ':'
    FormatSettings.System.ListSeparator = ','
    FormatSettings.System.ShortDateFormat = 'm/d/yyyy'
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
        DataSet = Table5
      end>
    Left = 418
    Top = 150
  end
  object DataSource2: TDataSource
    DataSet = XQuery2
    Left = 418
    Top = 218
  end
  object Table5: TTable
    DatabaseName = 'DBDEMOS'
    SessionName = 'Default'
    TableName = 'biolife.db'
    Left = 576
    Top = 94
    object Table5SpeciesNo: TFloatField
      FieldName = 'Species No'
    end
    object Table5Category: TStringField
      FieldName = 'Category'
      Size = 15
    end
    object Table5Common_Name: TStringField
      FieldName = 'Common_Name'
      Size = 30
    end
    object Table5SpeciesName: TStringField
      FieldName = 'Species Name'
      Size = 40
    end
    object Table5Lengthcm: TFloatField
      FieldName = 'Length (cm)'
    end
    object Table5Length_In: TFloatField
      FieldName = 'Length_In'
    end
    object Table5Notes: TMemoField
      FieldName = 'Notes'
      BlobType = ftMemo
      Size = 50
    end
    object Table5Graphic: TGraphicField
      FieldName = 'Graphic'
      BlobType = ftGraphic
    end
  end
  object Table1: TTable
    DatabaseName = 'DBDEMOS'
    SessionName = 'Default'
    IndexName = 'ByCompany'
    TableName = 'customer.db'
    Left = 260
    Top = 94
    object Table1CustNo: TFloatField
      FieldName = 'CustNo'
    end
    object Table1Company: TStringField
      FieldName = 'Company'
      Size = 30
    end
    object Table1Addr1: TStringField
      FieldName = 'Addr1'
      Size = 30
    end
    object Table1Addr2: TStringField
      FieldName = 'Addr2'
      Size = 30
    end
    object Table1City: TStringField
      FieldName = 'City'
      Size = 15
    end
    object Table1State: TStringField
      FieldName = 'State'
    end
    object Table1Zip: TStringField
      FieldName = 'Zip'
      Size = 10
    end
    object Table1Country: TStringField
      FieldName = 'Country'
    end
    object Table1Phone: TStringField
      FieldName = 'Phone'
      Size = 15
    end
    object Table1FAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object Table1TaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object Table1Contact: TStringField
      FieldName = 'Contact'
    end
    object Table1LastInvoiceDate: TDateTimeField
      FieldName = 'LastInvoiceDate'
    end
  end
  object Table2: TTable
    DatabaseName = 'DBDEMOS'
    SessionName = 'Default'
    TableName = 'orders.db'
    Left = 307
    Top = 110
    object Table2OrderNo: TFloatField
      FieldName = 'OrderNo'
      DisplayFormat = #39'#'#39'0000'
    end
    object Table2CustNo: TFloatField
      Alignment = taLeftJustify
      CustomConstraint = 'CustNo IS NOT NULL'
      ConstraintErrorMessage = 'CustNo cannot be blank'
      FieldName = 'CustNo'
      Required = True
      DisplayFormat = 'CN 0000'
      MaxValue = 9999.000000000000000000
      MinValue = 1000.000000000000000000
    end
    object Table2SaleDate: TDateTimeField
      FieldName = 'SaleDate'
    end
    object Table2ShipDate: TDateTimeField
      FieldName = 'ShipDate'
    end
    object Table2EmpNo: TIntegerField
      CustomConstraint = 'Value > 0'
      ConstraintErrorMessage = 'EmpNo cannot be 0 or negative'
      FieldName = 'EmpNo'
      Required = True
      DisplayFormat = 'Emp'#39'#'#39' 0000'
      MaxValue = 9999
      MinValue = 1
    end
    object Table2ShipToContact: TStringField
      FieldName = 'ShipToContact'
    end
    object Table2ShipToAddr1: TStringField
      FieldName = 'ShipToAddr1'
      Size = 30
    end
    object Table2ShipToAddr2: TStringField
      FieldName = 'ShipToAddr2'
      Size = 30
    end
    object Table2ShipToCity: TStringField
      FieldName = 'ShipToCity'
      Size = 15
    end
    object Table2ShipToState: TStringField
      FieldName = 'ShipToState'
    end
    object Table2ShipToZip: TStringField
      FieldName = 'ShipToZip'
      Size = 10
    end
    object Table2ShipToCountry: TStringField
      FieldName = 'ShipToCountry'
    end
    object Table2ShipToPhone: TStringField
      FieldName = 'ShipToPhone'
      Size = 15
    end
    object Table2ShipVIA: TStringField
      FieldName = 'ShipVIA'
      Size = 7
    end
    object Table2PO: TStringField
      FieldName = 'PO'
      Size = 15
    end
    object Table2Terms: TStringField
      FieldName = 'Terms'
      Size = 6
    end
    object Table2PaymentMethod: TStringField
      FieldName = 'PaymentMethod'
      Size = 7
    end
    object Table2ItemsTotal: TCurrencyField
      FieldName = 'ItemsTotal'
    end
    object Table2TaxRate: TFloatField
      FieldName = 'TaxRate'
      DisplayFormat = '0.00%'
      MaxValue = 100.000000000000000000
    end
    object Table2Freight: TCurrencyField
      FieldName = 'Freight'
    end
    object Table2AmountPaid: TCurrencyField
      FieldName = 'AmountPaid'
    end
  end
  object Table3: TTable
    DatabaseName = 'DBDEMOS'
    SessionName = 'Default'
    TableName = 'items.db'
    Left = 418
    Top = 94
    object Table3OrderNo: TFloatField
      FieldName = 'OrderNo'
      DisplayFormat = #39'#'#39'0000'
    end
    object Table3ItemNo: TFloatField
      FieldName = 'ItemNo'
    end
    object Table3PartNo: TFloatField
      Alignment = taLeftJustify
      FieldName = 'PartNo'
      DisplayFormat = 'PN-00000'
    end
    object Table3Qty: TIntegerField
      FieldName = 'Qty'
    end
    object Table3Discount: TFloatField
      FieldName = 'Discount'
      DisplayFormat = '#%'
      MaxValue = 100.000000000000000000
    end
  end
  object Table4: TTable
    DatabaseName = 'DBDEMOS'
    SessionName = 'Default'
    TableName = 'parts.db'
    Left = 497
    Top = 94
    object Table4PartNo: TFloatField
      Alignment = taLeftJustify
      FieldName = 'PartNo'
      DisplayFormat = 'PN-00000'
    end
    object Table4VendorNo: TFloatField
      CustomConstraint = '(VendorNo > 1000) and (VendorNo < 9999)'
      ConstraintErrorMessage = 'Vendor No has to be between 1000 and 9999'
      FieldName = 'VendorNo'
      DisplayFormat = 'VN 0000'
      MaxValue = 9999.000000000000000000
      MinValue = 1000.000000000000000000
    end
    object Table4Description: TStringField
      FieldName = 'Description'
      Size = 30
    end
    object Table4OnHand: TFloatField
      FieldName = 'OnHand'
    end
    object Table4OnOrder: TFloatField
      FieldName = 'OnOrder'
    end
    object Table4Cost: TCurrencyField
      FieldName = 'Cost'
    end
    object Table4ListPrice: TCurrencyField
      FieldName = 'ListPrice'
    end
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
      object Howtobuy1: TMenuItem
        Caption = 'On line &registration...'
        OnClick = Howtobuy1Click
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
    OnPosChange = SyntaxHighlighter1PosChange
    Left = 655
    Top = 218
  end
  object xQuery3: TxQuery
    SQL.Strings = (
      
        'SELECT * FROM CUSTOMER WHERE CustNo BETWEEN :LOWRANGE AND  :HIGH' +
        'RANGE;')
    About = 'TxQuery Version 2.0 (Ene 2009)'
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
    FormatSettings.System.DateSeparator = '/'
    FormatSettings.System.TimeSeparator = ':'
    FormatSettings.System.ListSeparator = ','
    FormatSettings.System.ShortDateFormat = 'm/d/yyyy'
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
        DataSet = Table1
      end>
    Left = 497
    Top = 150
  end
  object DataSource3: TDataSource
    DataSet = xQuery3
    Left = 497
    Top = 218
  end
  object DataSource4: TDataSource
    DataSet = Table1
    Left = 260
    Top = 150
  end
  object DataSource5: TDataSource
    DataSet = xQuery4
    Left = 576
    Top = 218
  end
  object xQuery4: TxQuery
    DataSource = DataSource4
    SQL.Strings = (
      'SELECT * FROM Orders WHERE CustNo = :CustNo')
    About = 'TxQuery Version 2.0 (Ene 2009)'
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
    FormatSettings.System.DateSeparator = '/'
    FormatSettings.System.TimeSeparator = ':'
    FormatSettings.System.ListSeparator = ','
    FormatSettings.System.ShortDateFormat = 'm/d/yyyy'
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
        DataSet = Table2
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
end
