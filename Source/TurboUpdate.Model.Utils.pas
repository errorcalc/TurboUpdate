{******************************************************************************}
{                           ErrorSoft TurboUpdate                              }
{                          ErrorSoft(c)  2016-2017                             }
{                                                                              }
{                     More beautiful things: errorsoft.org                     }
{                                                                              }
{           errorsoft@mail.ru | vk.com/errorsoft | github.com/errorcalc        }
{              errorsoft@protonmail.ch | habrahabr.ru/user/error1024           }
{                                                                              }
{             Open this on github: github.com/errorcalc/TurboUpdate            }
{                                                                              }
{ You can order developing vcl/fmx components, please submit requests to mail. }
{ Вы можете заказать разработку VCL/FMX компонента на заказ.                   }
{******************************************************************************}
{                                                                              }
{Modidicado por Renato Trevisan Fork=https://github.com/Rtrevisan20/TurboUpdate}
{Modified by Renato Trevisan Fork=https://github.com/Rtrevisan20/TurboUpdate   }
{******************************************************************************}
unit TurboUpdate.Model.Utils;

interface

uses
  System.SysUtils,

  WinApi.ShellAPI,
  WinApi.Windows,

  Winapi.TlHelp32;

  procedure LaunchUpdateApp(FileName: TFileName = 'Update.exe'; RunAsAdministrator: Boolean = True);
  function Killtask(ExeFileName: TFileName): Integer; // Add by renato trevisan 02-01-2024
  function NormalizeFileName(FileName: string): string;

implementation

function NormalizeFileName(FileName: string): string;
begin
  Result := FileName.Replace('/', PathDelim);
end;

function Killtask(ExeFileName: TFileName): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
   begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
   end;

  CloseHandle(FSnapshotHandle);
end;

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
