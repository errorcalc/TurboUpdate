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
unit TurboUpdate;

interface

uses
  HDMessageDlg,
  HDMessageDlg.Interfaces,

  System.Classes,
  System.SysUtils,

  TurboUpdate.Check,
  TurboUpdate.Consts,
  TurboUpdate.FMX.Utils,
  TurboUpdate.Interfaces,
  TurboUpdate.Types,
  TurboUpdate.Utils,
  TurboUpdate.VCL.Utils;

type
  TTurboUpdate = class(TInterfacedObject, iTurboUpdate)
  private
    FConsts : IMessageConsts;
    MSG: iHDMessageDlg;
    FExeNames: TStringArray;
    FUrls: TStringArray;
    FAppName: string;
    FRootPath: string;
    FDescription: string;
    FPngRes: string;
    FVersion: TFileVersion;
    FExecUpdateApp: string;
    FKillTaskApp: TFileName;
    procedure CheckVCL(UpdateAviable: Boolean; Version: TFileVersion);
    procedure CheckFMX(UpdateAviable: Boolean; Version: TFileVersion);
    procedure CheckStandalone(UpdateAviable: Boolean; Version: TFileVersion);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iTurboUpdate;
    function ExeNames(aValue: TStringArray): iTurboUpdate;
    function Urls(aValue: TStringArray): iTurboUpdate;
    function AppName(aValue: string): iTurboUpdate;
    function RootPath(aValue: string): iTurboUpdate;
    function Description(aValue: string): iTurboUpdate;
    function PngRes(aValue: string): iTurboUpdate;
    function Version(aValue: TFileVersion) : iTurboUpdate;
    function ExecUpdateApp(aValue: string = 'Update.exe'): iTurboUpdate;
    function KillTaskApp(aValue: TFileName): iTurboUpdate;
    procedure UpdateThreadVCL;
    procedure UpdateThreadFMX;
    procedure Standalone;
    procedure UpdateVCL;
    procedure UpdateFMX;
  end;

implementation

{ TTurboUpdate }

procedure TTurboUpdate.CheckFMX(UpdateAviable: Boolean; Version: TFileVersion);
var
  FUpdateInfo: TUpdateInfo;
begin
 if UpdateAviable then
  begin
   if
    MSG.MsgTitle(FConsts.MsgTitle)
     .MsgQuestion(FConsts.MsgQuestion)
     .MsgBody(Format(FConsts.MsgBodyUpdateVersion + FConsts.Version, [Version.ToString]))
     .MsgIcon(iQuestion)
     .MsgType(tQuestion)
     .DisplayQuestion
   then
    begin
     FUpdateInfo := Default(TUpdateInfo);
     FUpdateInfo.Urls := FUrls;
     FUpdateInfo.ExeNames := FExeNames;
     FUpdateInfo.Name := FAppName;
     FUpdateInfo.Description := FDescription;
     TurboUpdate.FMX.Utils.FMXUpdate(FUpdateInfo);
    end;
  end else
   MSG.MsgTitle(FConsts.MsgTitle)
    .MsgQuestion('')
    .MsgBody(Format(FConsts.MsgBodyLastVersion + FConsts.Version, [Version.ToString]))
    .MsgIcon(iMessage)
    .MsgType(tOK)
    .DisplayMessage;
end;

procedure TTurboUpdate.CheckStandalone(UpdateAviable: Boolean; Version: TFileVersion);
begin
 if UpdateAviable then
  begin
   if
    MSG.MsgTitle(FConsts.MsgTitle)
     .MsgQuestion(FConsts.MsgQuestion)
     .MsgBody(Format(FConsts.MsgBodyUpdateVersion + FConsts.Version, [Version.ToString]))
     .MsgIcon(iQuestion)
     .MsgType(tQuestion)
     .DisplayQuestion
   then
    begin
     LaunchUpdateApp(FExecUpdateApp);
     Killtask(FKillTaskApp);
    end;
   end else
    MSG.MsgTitle(FConsts.MsgTitle)
     .MsgQuestion('')
     .MsgBody(Format(FConsts.MsgBodyLastVersion + FConsts.Version, [Version.ToString]))
     .MsgIcon(iMessage)
     .MsgType(tOK)
     .DisplayMessage;
end;

procedure TTurboUpdate.CheckVCL(UpdateAviable: Boolean; Version: TFileVersion);
var
  FUpdateInfo: TUpdateInfo;
begin
 if UpdateAviable then
  begin
   if
    MSG.MsgTitle(FConsts.MsgTitle)
     .MsgQuestion(FConsts.MsgQuestion)
     .MsgBody(Format(FConsts.MsgBodyUpdateVersion + FConsts.Version, [Version.ToString]))
     .MsgIcon(iQuestion)
     .MsgType(tQuestion)
     .DisplayQuestion
   then
    begin
     FUpdateInfo := Default(TUpdateInfo);
     FUpdateInfo.Urls := FUrls;
     FUpdateInfo.ExeNames := FExeNames;
     FUpdateInfo.Name := FAppName;
     FUpdateInfo.Description := FDescription;
     TurboUpdate.VCL.Utils.VCLUpdate(FUpdateInfo);
    end;
  end else
   MSG.MsgTitle(FConsts.MsgTitle)
    .MsgQuestion('')
    .MsgBody(Format(FConsts.MsgBodyLastVersion + FConsts.Version, [Version.ToString]))
    .MsgIcon(iMessage)
    .MsgType(tOK)
    .DisplayMessage;
end;

constructor TTurboUpdate.Create;
begin
  MSG := THDMessageDlg.New;
  FConsts := TFactoryConsts.New.Consts;
end;

function TTurboUpdate.Description(aValue: string): iTurboUpdate;
begin
  Result := Self;
  FDescription := aValue;
end;

destructor TTurboUpdate.Destroy;
begin

  inherited;
end;

function TTurboUpdate.ExeNames(aValue: TStringArray): iTurboUpdate;
begin
  Result := self;
  FExeNames := aValue;
end;

function TTurboUpdate.KillTaskApp(aValue: TFileName): iTurboUpdate;
begin
  Result := Self;
  FKillTaskApp := aValue;
end;

function TTurboUpdate.ExecUpdateApp(aValue: string): iTurboUpdate;
begin
  Result := Self;
  FExecUpdateApp := aValue;
end;

function TTurboUpdate.AppName(aValue: string): iTurboUpdate;
begin
  Result := Self;
  FAppName := aValue;
end;

class function TTurboUpdate.New: iTurboUpdate;
begin
  Result := Self.Create;
end;

function TTurboUpdate.PngRes(aValue: string): iTurboUpdate;
begin
  Result := Self;
  FPngRes := aValue;
end;

function TTurboUpdate.RootPath(aValue: string): iTurboUpdate;
begin
  Result := Self;
  FRootPath := aValue;
end;

procedure TTurboUpdate.Standalone;
begin
  CheckUpdate(FUrls, FAppName, FVersion, CheckStandalone);
end;

procedure TTurboUpdate.UpdateFMX;
begin
  CheckUpdate(FUrls, FAppName, FVersion, CheckFMX);
end;

procedure TTurboUpdate.UpdateThreadFMX;
var
  FUpdateInfo: TUpdateInfo;
begin
  FUpdateInfo.Urls := FUrls;
  FUpdateInfo.ExeNames := FExeNames;
  FUpdateInfo.Name := FAppName;
  FUpdateInfo.Description := FDescription;
  FMXUpdate(FUpdateInfo);
end;

procedure TTurboUpdate.UpdateThreadVCL;
var
  FUpdateInfo: TUpdateInfo;
begin
  FUpdateInfo.Urls := FUrls;
  FUpdateInfo.ExeNames := FExeNames;
  FUpdateInfo.Name := FAppName;
  FUpdateInfo.Description := FDescription;
  VCLUpdate(FUpdateInfo);

end;

procedure TTurboUpdate.UpdateVCL;
begin
  CheckUpdate(FUrls, FAppName, FVersion, CheckVCL);
end;

function TTurboUpdate.Urls(aValue: TStringArray): iTurboUpdate;
begin
  Result := Self;
  FUrls := aValue;
end;

function TTurboUpdate.Version(aValue: TFileVersion): iTurboUpdate;
begin
  Result := Self;
  FVersion := aValue;
end;

end.
