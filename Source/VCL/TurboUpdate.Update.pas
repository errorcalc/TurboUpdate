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
unit TurboUpdate.Update;

interface

uses
  System.Classes,
  System.SysUtils,

  TurboUpdate.FormUpdate,
  TurboUpdate.Model.Interfaces,
  TurboUpdate.Model,
  TurboUpdate.Model.Types,
  TurboUpdate.Model.Update.Thread,

  Vcl.Dialogs,
  Vcl.Forms;
type
  TVclUpdateThread = class(TUpdateThread)
  protected
    View: TCustomForm;
    function CreateView: TCustomForm; virtual;
    procedure Work; override;
    procedure Prepare; override;
  end;

implementation

{ TVclUpdateThread }
function TVclUpdateThread.CreateView: TCustomForm;
begin
  Application.CreateForm(TFormUpdate, Result);
end;

procedure TVclUpdateThread.Prepare;
begin
  View := CreateView;
end;

procedure TVclUpdateThread.Work;
var
  Model: TUpdater;
begin
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
