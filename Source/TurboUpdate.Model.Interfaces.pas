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
unit TurboUpdate.Model.Interfaces;

interface

uses
  System.SysUtils,
  TurboUpdate.Model.Check,
  TurboUpdate.Model.Types;

type
  IUpdateModel = interface
    ['{CEAD1A55-AF8B-4003-B1C2-84D7371D2CE1}']
    procedure Cancel;
  end;

  IUpdateView = interface
    ['{D7D57022-217A-4D79-944F-6D3112D674D9}']
    procedure SetVersion(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetStatus(const Value: string);
    procedure SetPngRes(const Value: string);
    procedure SetModel(Model: IUpdateModel);
    procedure SetUpdateState(Value: TUpdateState);
    // routliness
    procedure ShowMessage(Message: string);
    function ShowErrorMessage(Message: string): Boolean;
    procedure Progress(Progress, Length: Integer);
    procedure Close;
    procedure Show;
    // properties
    property Version: string write SetVersion;
    property Status: string write SetStatus;
    property Description: string write SetDescription;
    property PngRes: string write SetPngRes;
    property Model: IUpdateModel write SetModel;
    property State: TUpdateState write SetUpdateState;
  end;

implementation

end.
