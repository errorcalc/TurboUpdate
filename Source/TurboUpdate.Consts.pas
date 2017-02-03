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
unit TurboUpdate.Consts;

interface

var
  // status
  sWaitingStatus: string = 'Waiting...';
  sDownloadingStatus: string = 'Downloading...';
  sRenamingFilesStatus: string  = 'Renaming Files...';
  sUnpackingStatus: string  = 'Unpacking...';
  sDoneStatus: string  = 'Done!';

  // errors
  sConnectionError: string = 'Connection Error, Please Check Your Internet Connection, Try Again?';
  sDownloadError: string = 'Download Error, Try Again?';
  sCorruptedFilesError: string = 'Corrupted Files, Try Again?';

  // messages
  sDoneMessage: string = 'Successful!, Please Restart Application';

  // other
  sVersion: string = 'Ver. %s';

implementation

end.
