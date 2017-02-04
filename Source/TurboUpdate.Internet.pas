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
unit TurboUpdate.Internet;

interface

uses
  TurboUpdate.Types;

function GetUpdateUrl(IniFileUrl: string; Name: string): string; overload;
function GetUpdateVersion(IniFileUrl: string; Name: string; out Version: TFileVersion): Boolean; overload;
function GetUpdateUrl(Urls: TStringArray; AppName: string): string; overload;
function GetUpdateVersion(Urls: TStringArray; AppName: string; out Version: TFileVersion): Boolean; overload;

type
  TReceiveDataEventRef = reference to procedure(Length: Int64; Progress: Int64; var Abort: Boolean);

function DowloadFile(Url: string; Path: string; DownloadProgress: TReceiveDataEventRef): Boolean;

implementation

uses
  System.Net.HttpClient, System.IniFiles, System.Classes, System.SysUtils;

function GetStream(Url: string): TStream;
var
  Http: THttpClient;
  Stream: TMemoryStream;
begin
  Result := nil;

  Stream := TMemoryStream.Create;
  try
    Http := THttpClient.Create;
    try
      // Http.ConnectTimeout := 10 * 1000;// 10 sec
      if Http.Get(Url, Stream).StatusCode >= 300 then
        FreeAndNil(Stream);

      Result := Stream;
    finally
      Http.Free;
    end;
  except
    FreeAndNil(Stream);
  end;
end;

function GetIniFile(Url: string): TMemIniFile;
var
  Stream: TStream;
  Strings: TStringList;
begin
  Result := nil;

  Stream := GetStream(Url);
  if Stream = nil then
    Exit;
  try

    Strings := TStringList.Create;
    try
      Strings.LoadFromStream(Stream);
      Result := TMemIniFile.Create('');
      Result.SetStrings(Strings);
    finally
      Strings.Free;
    end;

  finally
    Stream.Free;
  end;
end;

function GetUpdateUrl(IniFileUrl: string; Name: string): string;
var
  Ini: TMemIniFile;
begin
  Result := '';

  Ini := GetIniFile(IniFileUrl);
  if Ini = nil then
    Exit;
  try
    Result := Ini.ReadString(Name, 'Download', '');
  finally
    Ini.Free;
  end;
end;

function GetUpdateVersion(IniFileUrl: string; Name: string; out Version: TFileVersion): Boolean;
var
  Ini: TMemIniFile;
begin
  Result := False;

  Ini := GetIniFile(IniFileUrl);
  if Ini = nil then
    Exit;
  try
    Version := TFileVersion.Create(Ini.ReadString(Name, 'Version', ''));
    Result := True;
  finally
    Ini.Free;
  end;
end;

function GetUpdateUrl(Urls: TStringArray; AppName: string): string;
var
  Url: string;
begin
  Result := '';
  for Url in Urls do
  begin
    Result := GetUpdateUrl(Url, AppName);
    if Result <> '' then
      break;
  end;
end;

function GetUpdateVersion(Urls: TStringArray; AppName: string; out Version: TFileVersion): Boolean;
var
  Url: string;
begin
  for Url in Urls do
  begin
    if GetUpdateVersion(Url, AppName, Version) then
      Exit(True);
  end;

  Exit(False)
end;

type
  IHttpClientHook = interface
    procedure SetOnResiveData(OnResiveData: TReceiveDataEventRef);
    function GetResiveDataProc: TReceiveDataEvent;
    // ---
    property OnResiveData: TReceiveDataEventRef write SetOnResiveData;
    property ResiveDataProc: TReceiveDataEvent read GetResiveDataProc;
  end;

  THttpClientHook = class(TInterfacedObject, IHttpClientHook)
  private
    FOnResiveData: TReceiveDataEventRef;
    procedure ReceiveDataProc(const Sender: TObject; AContentLength: Int64; AReadCount: Int64; var Abort: Boolean);
  public
    destructor Destroy; override;
    { IHttpClientHook }
    procedure SetOnResiveData(OnResiveData: TReceiveDataEventRef);
    function GetResiveDataProc: TReceiveDataEvent;
  end;

{ THttpClientHook }

destructor THttpClientHook.Destroy;
begin
  inherited;
end;

function THttpClientHook.GetResiveDataProc: TReceiveDataEvent;
begin
  Result := ReceiveDataProc;
end;

procedure THttpClientHook.ReceiveDataProc(const Sender: TObject; AContentLength, AReadCount: Int64; var Abort: Boolean);
begin
  if Assigned(FOnResiveData) then
    FOnResiveData(AContentLength, AReadCount, Abort);
end;

procedure THttpClientHook.SetOnResiveData(OnResiveData: TReceiveDataEventRef);
begin
  FOnResiveData := OnResiveData;
end;

{$HINTS OFF}
function DowloadFile(Url: string; Path: string; DownloadProgress: TReceiveDataEventRef): Boolean;
var
  Http: THttpClient;
  Stream: TStream;
  Hook: IHttpClientHook;
  Response: IHTTPResponse;
  Time: Cardinal;
begin
  Result := False;

  Time := 0;
  Hook := THttpClientHook.Create;
  Hook.OnResiveData :=
  procedure(Length, Progress: Int64; var Abort: Boolean)
  begin
    if (Time < TThread.GetTickCount) or (Length = Progress) then
    begin
      DownloadProgress(Length, Progress, Abort);
      Time := TThread.GetTickCount + 1000 div 30;// 30 per second
    end;
    // if Abort then
    //   raise ENetHTTPException.Create('Aborted');
  end;

  Stream := TFileStream.Create(Path, fmCreate);
  try
    Http := THttpClient.Create;
    Http.OnReceiveData := Hook.ResiveDataProc;
    try
      //Http.DownloadProgressProc := DownloadProgress;
      // Http.ConnectTimeout := 10 * 1000;// 10 sec
      try
        Response := Http.Get(Url, Stream);
        Result := (Response.StatusCode <= 299) and (Response.ContentLength = Stream.Size);
      except
        on ENetHTTPException do
          Result := False;
      end;
    finally
      Http.Free;
    end;
  finally
    Stream.Free;
  end;
end;
{$HINTS ON}

end.
