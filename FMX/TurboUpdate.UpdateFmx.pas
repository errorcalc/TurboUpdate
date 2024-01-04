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
unit TurboUpdate.UpdateFmx;

interface

uses
  Fmx.Forms,

  System.Classes,
  System.SysUtils,

  TurboUpdate.Model,
  TurboUpdate.Types,
  TurboUpdate.Update.Thread;

type
  TFmxUpdateThread = class(TUpdateThread)
  protected
    function CreateView: TCustomForm; virtual;
    procedure Work; override;
  end;

implementation

uses
  TurboUpdate.FormUpdateFmx;

{ TFmxUpdateThread }
function TFmxUpdateThread.CreateView: TCustomForm;
begin
  Result := TFormUpdateFmx.Create(Application);
end;
procedure TFmxUpdateThread.Work;
var
  Model: TUpdater;
  View: TCustomForm;
begin
  // need waiting start mainloop
  while ApplicationState = TApplicationState.None do Sleep(0);
  Sync(procedure
  begin
    View := CreateView;
  end);
  if Application.MainForm = nil then
    Application.MainForm := View;
  Model := nil;
  try
    Model := CreateModel(View as IUpdateView);
    if IsUpdateFromFile then
      Model.UpdateFromFile(FileName)
    else
      Model.Update;
  finally
    Model.Free;
    if View <> Application.MainForm then
      Sync(procedure
      begin
        View.Release;
      end)
    else
    begin
      IsUpdating := False;
      Sync(procedure
      begin
        View.Close;
      end)
    end;
  end;
end;
end.

