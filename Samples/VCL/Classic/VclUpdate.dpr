program VclUpdate;

uses
  Vcl.Forms, System.SysUtils, TurboUpdate.Update, TurboUpdate.Types;

{$R *.res}

var
  Info: TUpdateInfo;

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Info.Urls := ['https://raw.githubusercontent.com/errorcalc/TurboUpdate/master/Update.ini'];
  Info.ExeNames := ['VclApplication.exe', 'VclUpdate.exe'];
  Info.Name := 'TurboUpdate.Vcl.Classic';
  Info.Description := 'TurboUpdate/Vcl/Classic';

  Update(Info);

  Application.Run;
end.

