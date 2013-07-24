program Demo;
{$DEFINE MEMORY_CHECK}
uses
  FastMM4 in '..\..\..\extra\FastMM4\FastMM4.pas',
  Forms,
  DemoAb in '..\source\DemoAb.pas' {frmAbout},
  Ex1U in '..\source\Ex1U.pas' {frmTest},
  FastMM4Messages in '..\..\..\extra\FastMM4\FastMM4Messages.pas',
  XQSyntaxHi in '..\..\..\source\XQSyntaxHi.pas',
  XQColorSet in '..\..\..\source\XQColorSet.pas' {frmColorSettings};

{$R *.RES}


begin
{$IFDEF MEMORY_CHECK}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}
  Application.Initialize;
  Application.CreateForm(TfrmTest, frmTest);
  Application.Run;
end.
