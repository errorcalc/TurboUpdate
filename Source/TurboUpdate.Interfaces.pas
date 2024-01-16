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
unit TurboUpdate.Interfaces;

interface

uses
  System.SysUtils,
  TurboUpdate.Model.Types;

type
  iTurboUpdate = interface // Adicionado por Renato Trevisan 15/01/24
    ['{55822428-30FE-41B2-A9F4-4A03CC04C2AB}']
    function ExeNames(aValue: TStringArray): iTurboUpdate;
    function Urls(aValue: TStringArray): iTurboUpdate;
    function AppName(aValue: string): iTurboUpdate;
    function RootPath(aValue: string): iTurboUpdate;
    function Description(aValue: string): iTurboUpdate;
    function PngRes(aValue: string): iTurboUpdate;
    function Version(aValue: TFileVersion): iTurboUpdate;
    function ExecUpdateApp(aValue: string = 'Update.exe'): iTurboUpdate;
    function KillTaskApp(aValue: TFileName): iTurboUpdate;
    procedure UpdateThreadVCL;
    procedure UpdateThreadFMX;
    procedure Standalone;
    procedure UpdateVCL;
    procedure UpdateFMX;
  end;

implementation

end.
