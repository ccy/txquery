unit ColorSet;

{$I XQ_FLAG.INC}
interface

uses Windows,
     SysUtils,
     Classes,
     Graphics,
     Forms,
     Controls,
     StdCtrls,
     Buttons,
     ExtCtrls,
     ColorGrd,
     XQLex,
     XQYacc,
     syntaxhi;

type
  TfrmColorSettings = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    ChkBold: TCheckBox;
    ChkItalic: TCheckBox;
    ChkUnderline: TCheckBox;
    ColorGrid1: TColorGrid;
    procedure ListBox1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
    FOriginalColorConfig: TColorConfig;
    FColorConfig: TColorConfig;
    FIgnoreChanges: Boolean;
    procedure RefreshInfo;
  public
    { Public declarations }
    function Enter(ColorConfig: TColorConfig):Word;
  end;

implementation

{$R *.DFM}

function TfrmColorSettings.Enter(ColorConfig: TColorConfig): Word;
begin
   FColorConfig:= TColorConfig.Create;
   FColorConfig.Assign(ColorConfig);
   FOriginalColorConfig:= ColorConfig;

   ListBox1.ItemIndex:= 0;
   ListBox1Click(nil);

   Result:= ShowModal;
end;


procedure TfrmColorSettings.RefreshInfo;
var
   Index, I: Integer;
   ColorElement: PColorElement;
begin
   FIgnoreChanges:= True;
   Index:= ListBox1.ItemIndex; if Index < 0 then Exit;
   I:= FColorConfig.IndexOfGroup(TElementGroup(Index));
   ColorElement:= PColorElement(Fcolorconfig.ColorSettings[I]);
   with ColorElement^ do
   begin
      ColorGrid1.ForeGroundIndex:= ColorGrid1.ColorToIndex(ForeColor);
      ColorGrid1.BackGroundIndex:= ColorGrid1.ColorToIndex(BackColor);
      ChkBold.Checked := fsBold in FontStyle;
      ChkItalic.Checked := fsItalic in FontStyle;
      ChkUnderline.Checked := fsUnderline in FontStyle;
   end;
   FIgnoreChanges:= False;
end;

procedure TfrmColorSettings.ListBox1Click(Sender: TObject);
begin
   RefreshInfo;
end;

procedure TfrmColorSettings.FormDestroy(Sender: TObject);
begin
   FColorConfig.Free;
end;

procedure TfrmColorSettings.OKBtnClick(Sender: TObject);
begin
   FOriginalColorConfig.Assign(FColorConfig);
end;

end.
