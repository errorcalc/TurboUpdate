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
  TurboUpdate.Check,
  TurboUpdate.Types;

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
