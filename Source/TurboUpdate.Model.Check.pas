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
unit TurboUpdate.Model.Check;

interface

uses
  TurboUpdate.Model.Types;

type
  TUpdateCheckResultProc = reference to procedure(UpdateAviable: Boolean; Version: TFileVersion);

procedure CheckUpdate(Urls: TStringArray; AppName: string;
  UpdateCheckResultProc: TUpdateCheckResultProc); overload;

procedure CheckUpdate(Urls: TStringArray; AppName: string;
  Version: TFileVersion;
  UpdateCheckResultProc: TUpdateCheckResultProc); overload;

implementation

uses
  System.Classes, TurboUpdate.Model.Internet;

var
  IsChecking: Boolean = False;

procedure CheckUpdate(Urls: TStringArray; AppName: string;
  Version: TFileVersion; UpdateCheckResultProc: TUpdateCheckResultProc);
begin
  if IsChecking then
    Exit;

  TThread.CreateAnonymousThread(
    procedure
    var
      Url: string;
      UpdateVersion: TFileVersion;
    begin
     IsChecking := True;
      try
        for Url in Urls do
        begin
          if GetUpdateVersion(Url, AppName, UpdateVersion) then
          begin
            TThread.Synchronize(nil,
              procedure
              begin
                if UpdateVersion > Version then
                  UpdateCheckResultProc(True, UpdateVersion)
                else
                  UpdateCheckResultProc(False, UpdateVersion);
              end);
            break;
          end;
        end;
      finally
        IsChecking := False;
      end;
    end).Start;
end;

procedure CheckUpdate(Urls: TStringArray; AppName: string;
UpdateCheckResultProc: TUpdateCheckResultProc);
begin
  CheckUpdate(Urls, AppName, TFileVersion.CreateForFile(ParamStr(0)),
    UpdateCheckResultProc);
end;

end.
