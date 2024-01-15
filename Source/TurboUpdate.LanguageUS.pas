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
unit TurboUpdate.LanguageUS;

interface

uses
  System.Classes,
  System.IniFiles,
  System.SysUtils,

  TurboUpdate.Interfaces;

type
  TMessageConstsUS = class(TInterfacedObject, IMessageConsts)
  private
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IMessageConsts;
    function WaitingStatus: string;
    function DownloadingStatus: string;
    function RenamingFilesStatus: string;
    function UnpackingStatus: string;
    function DoneStatus: string;
    function ConnectionError: string;
    function DownloadError: string;
    function CorruptedFilesError: string;
    function DoneMessage: string;
    function DoneMessageRestart : string;
    function Version: string;
    function MsgTitle: string;
    function MsgQuestion: string;
    function MsgBodyLastVersion: string;
    function MsgBodyUpdateVersion : string;
  end;

implementation

{ TMessageConstsUS }

function TMessageConstsUS.ConnectionError: string;
begin
  Result := 'Connection Error, Please Check Your Internet Connection, Try Again?';
end;

function TMessageConstsUS.CorruptedFilesError: string;
begin
  Result := 'Corrupted Files, Try Again?';
end;

constructor TMessageConstsUS.Create;
begin
end;

destructor TMessageConstsUS.Destroy;
begin
  inherited;
end;

function TMessageConstsUS.DoneMessage: string;
begin
  Result := 'Successful! Please Restart Application';
end;

function TMessageConstsUS.DoneMessageRestart: string;
begin
  Result := 'Successful! The app will be restarted';
end;

function TMessageConstsUS.DoneStatus: string;
begin
  Result := 'Done!';
end;

function TMessageConstsUS.DownloadError: string;
begin
  Result := 'Download Error, Try Again?';
end;

function TMessageConstsUS.DownloadingStatus: string;
begin
  Result := 'Downloading...';
end;

function TMessageConstsUS.MsgBodyLastVersion: string;
begin
  Result := 'System is in the latest version. ';
end;

function TMessageConstsUS.MsgBodyUpdateVersion: string;
begin
  Result := 'Update available. ';
end;

function TMessageConstsUS.MsgQuestion: string;
begin
  Result := 'Do you want to update?'
end;

function TMessageConstsUS.MsgTitle: string;
begin
  Result := 'System update';
end;

class function TMessageConstsUS.New: IMessageConsts;
begin
  Result := Self.Create;
end;

function TMessageConstsUS.RenamingFilesStatus: string;
begin
  Result := 'Renaming Files...';
end;

function TMessageConstsUS.UnpackingStatus: string;
begin
  Result := 'Unpacking...';
end;

function TMessageConstsUS.Version: string;
begin
  Result := 'Version %s';
end;

function TMessageConstsUS.WaitingStatus: string;
begin
  Result := 'Waiting...';
end;

end.
