program Demo;
{$DEFINE MEMORY_CHECK}
uses
  MidasLib,
  Forms,
  AboutFrm in 'AboutFrm.pas' {frmAbout},
  MainFrm in 'MainFrm.pas' {frmMain};

{$R *.RES}


begin
{$IFDEF MEMORY_CHECK}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}
  Application.Initialize;
  Application.Title := 'TXQuery v3.0 Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
