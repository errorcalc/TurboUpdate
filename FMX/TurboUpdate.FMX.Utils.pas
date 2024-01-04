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
{ �� ������ �������� ���������� VCL/FMX ���������� �� �����.                   }
{******************************************************************************}
{                                                                              }
{Adicionado por Renato Trevisan Fork=https://github.com/Rtrevisan20/TurboUpdate}
{added by Renato Trevisan Fork=https://github.com/Rtrevisan20/TurboUpdate      }
{******************************************************************************}
unit TurboUpdate.FMX.Utils;

interface

uses
  TurboUpdate.Types,
  TurboUpdate.UpdateFmx;

procedure Update(const UpdateInfo: TUpdateInfo);
procedure UpdateFromFile(const UpdateInfo: TUpdateInfo; FileName: string);

implementation

procedure Update(const UpdateInfo: TUpdateInfo);
begin
  TFmxUpdateThread.Create(UpdateInfo).Update;
end;

procedure UpdateFromFile(const UpdateInfo: TUpdateInfo; FileName: string);
begin
  TFmxUpdateThread.Create(UpdateInfo).UpdateFromFile(FileName);
end;

end.
