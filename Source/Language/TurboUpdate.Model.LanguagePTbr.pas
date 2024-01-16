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
{ Âû ìîæåòå çàêàçàòü ðàçðàáîòêó VCL/FMX êîìïîíåíòà íà çàêàç.                   }
{******************************************************************************}
{                                                                              }
{Adicionado por Renato Trevisan Fork=https://github.com/Rtrevisan20/TurboUpdate}
{added by Renato Trevisan Fork=https://github.com/Rtrevisan20/TurboUpdate      }
{******************************************************************************}
unit TurboUpdate.Model.LanguagePTbr;

interface

uses
  System.Classes,
  System.IniFiles,
  System.SysUtils,

  TurboUpdate.Model.Language.Interfaces;

type
  TMessageConstsPTbr = class(TInterfacedObject, IMessageConsts)
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

{ TMessageConstsPTbr }

function TMessageConstsPTbr.ConnectionError: string;
begin
  Result := 'Erro na conexão, cheque a sua conexão com a internet. Tentar novamente?';
end;

function TMessageConstsPTbr.CorruptedFilesError: string;
begin
  Result := 'Arquivos corrompidos. Tentar novamente?';
end;

constructor TMessageConstsPTbr.Create;
begin
end;

destructor TMessageConstsPTbr.Destroy;
begin
  inherited;
end;

function TMessageConstsPTbr.DoneMessage: string;
begin
  Result := 'Atualização bem-sucedida! Por favor, reinicie o aplicativo.';
end;

function TMessageConstsPTbr.DoneMessageRestart: string;
begin
  Result := 'Atualização bem-sucedida! O aplicativo será reiniciado.';
end;

function TMessageConstsPTbr.DoneStatus: string;
begin
  Result := 'Feito!';
end;

function TMessageConstsPTbr.DownloadError: string;
begin
  Result := 'Erro no Download. Tentar novamente?';
end;

function TMessageConstsPTbr.DownloadingStatus: string;
begin
  Result := 'Downloading...';
end;

function TMessageConstsPTbr.MsgBodyLastVersion: string;
begin
  Result := 'Sistema está na ultima versão. ';
end;

function TMessageConstsPTbr.MsgBodyUpdateVersion: string;
begin
  Result := 'Atualização disponível. ';
end;

function TMessageConstsPTbr.MsgQuestion: string;
begin
  Result := 'Deseja atualizar?'
end;

function TMessageConstsPTbr.MsgTitle: string;
begin
  Result := 'Atualização do sistema';
end;

class function TMessageConstsPTbr.New: IMessageConsts;
begin
  Result := Self.Create;
end;

function TMessageConstsPTbr.RenamingFilesStatus: string;
begin
  Result := 'Renomeando arquivos...';
end;

function TMessageConstsPTbr.UnpackingStatus: string;
begin
  Result := 'Desempacotando...';
end;

function TMessageConstsPTbr.Version: string;
begin
  Result := 'Versão %s';
end;

function TMessageConstsPTbr.WaitingStatus: string;
begin
  Result := 'Aguardando...';
end;

end.
