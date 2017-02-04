unit TurboUpdate.Utils;

interface

uses
  System.SysUtils;

procedure LaunchUpdateApp(FileName: TFileName = 'Update.exe'; RunAsAdministrator: Boolean = True);

implementation

uses
  WinApi.Windows, WinApi.ShellAPI;

procedure LaunchUpdateApp(FileName: TFileName; RunAsAdministrator: Boolean);
var
  Info: TShellExecuteInfo;
begin
  if IsRelativePath(FileName) then
    FileName := ExtractFilePath(ParamStr(0)) + PathDelim + FileName;

  ZeroMemory(@Info, SizeOf(Info));
  Info.cbSize := SizeOf(Info);
  Info.Wnd := 0;
  if RunAsAdministrator then
    Info.lpVerb := 'runas';
  Info.lpFile := PChar(FileName);
  Info.lpParameters := '';
  Info.lpDirectory := PChar(ExtractFilePath(FileName));
  Info.nShow := SW_NORMAL;

  ShellExecuteEx(@Info);
end;

end.
