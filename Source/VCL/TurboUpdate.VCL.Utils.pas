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
{Adicionado por Renato Trevisan Fork=https://github.com/Rtrevisan20/TurboUpdate}
{added by Renato Trevisan Fork=https://github.com/Rtrevisan20/TurboUpdate      }
{******************************************************************************}
unit TurboUpdate.VCL.Utils;

interface

uses
  TurboUpdate.Types,
  TurboUpdate.Update;

procedure VCLUpdate(const UpdateInfo: TUpdateInfo);
procedure VCLUpdateFromFile(const UpdateInfo: TUpdateInfo; FileName: string);

implementation

procedure VCLUpdate(const UpdateInfo: TUpdateInfo);
begin
  TVclUpdateThread.Create(UpdateInfo).Update;
end;

procedure VCLUpdateFromFile(const UpdateInfo: TUpdateInfo; FileName: string);
begin
  TVclUpdateThread.Create(UpdateInfo).UpdateFromFile(FileName);
end;

end.
