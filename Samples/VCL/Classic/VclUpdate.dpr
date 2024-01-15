Program VclUpdate;

uses
  Vcl.Forms,
  System.SysUtils,
  TurboUpdate;

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  TTurboUpdate.New
   .ExeNames(['VclApplication.exe', 'VclUpdate.exe'])
   .Urls(['https://raw.githubusercontent.com/Rtrevisan20/TurboUpdate/master/Update.ini'])
   .AppName('TurboUpdate.Vcl.Classic')
   .Description('TurboUpdate/Vcl/Classic')
   .UpdateThreadVCL;

  Application.Run;
end.

