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
unit TurboUpdate.Update.Thread;

interface

uses
  System.Classes,
  System.SysUtils,

  TurboUpdate.Interfaces,
  TurboUpdate.Model,
  TurboUpdate.Types;

type
  TUpdateThread = class(TThread)
  class var
    IsUpdating: Boolean;
  private
    class function IsDone: Boolean; static;
  protected
    UpdateInfo: TUpdateInfo;
    IsUpdateFromFile: Boolean;
    FileName: string;
    procedure Execute; override;
    procedure Work; virtual; abstract;
    function CreateModel(View: IUpdateView): TUpdater; virtual;
    procedure Sync(Proc: TThreadProcedure);
    procedure Prepare; virtual;
    procedure Start;
  public
    constructor Create(UpdateInfo: TUpdateInfo);
    procedure Update;
    procedure UpdateFromFile(FileName: string);
  end;

implementation

{ TUpdateThread }

constructor TUpdateThread.Create(UpdateInfo: TUpdateInfo);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  Self.UpdateInfo := UpdateInfo;
end;

function TUpdateThread.CreateModel(View: IUpdateView): TUpdater;
begin
  Result := TUpdater.Create(View, UpdateInfo);
end;

procedure TUpdateThread.Execute;
begin
  inherited;
  if IsUpdating then
    Exit;
  IsUpdating := True;
  try
    Work;
  finally
    IsUpdating := False;
  end;
end;

class function TUpdateThread.IsDone: Boolean;
begin
  Result := not IsUpdating;
end;

procedure TUpdateThread.Prepare;
begin
  // Create view and others
end;

procedure TUpdateThread.Start;
begin
  Prepare;
  inherited Start;
end;

procedure TUpdateThread.Sync(Proc: TThreadProcedure);
begin
  TThread.Synchronize(nil, Proc);
end;

procedure TUpdateThread.Update;
begin
  Start;
end;

procedure TUpdateThread.UpdateFromFile(FileName: string);
begin
  IsUpdateFromFile := True;
  Self.FileName := FileName;
  Start;
end;

initialization
  AddTerminateProc(TUpdateThread.IsDone);

finalization

end.
