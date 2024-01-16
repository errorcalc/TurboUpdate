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
unit TurboUpdate.Model.Language.Interfaces;

interface

type
  IMessageConsts = interface // Adicionado por Renato Trevisan 02/01/24
    ['{CCEA3692-C90A-48DA-801E-0543F49C6CBC}']
    function WaitingStatus: string;
    function DownloadingStatus: string;
    function RenamingFilesStatus: string;
    function UnpackingStatus: string;
    function DoneStatus: string;
    function ConnectionError: string;
    function DownloadError: string;
    function CorruptedFilesError: string;
    function DoneMessage: string;
    function DoneMessageRestart: string;
    function Version: string;
    function MsgTitle: string;
    function MsgQuestion: string;
    function MsgBodyLastVersion: string;
    function MsgBodyUpdateVersion : string;
  end;

  IFactoryConsts = interface // Adicionado por Renato Trevisan 02/01/24
    ['{3DC0100B-59AB-4D25-B9F4-BA1E3945E664}']
    function Consts: IMessageConsts;
  end;

implementation

end.
