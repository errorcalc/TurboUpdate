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
unit TurboUpdate.Types;

{$SCOPEDENUMS ON}

interface

uses
  System.Classes, System.SysUtils;

type
  TUpdateState = (Waiting, Downloading, Unpacking, Done);

  TStringArray = TArray<string>;

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

  TFileVersion = record
  public
    Major: Word;
    Minor: Word;
    Release: Word;
    Build: Word;
    //
    class operator Equal(L, R: TFileVersion): Boolean;// =
    class operator NotEqual(L, R: TFileVersion): Boolean;//	<>
    class operator GreaterThan(L, R: TFileVersion): Boolean;// >
    class operator GreaterThanOrEqual(L, R: TFileVersion): Boolean;// >=
    class operator LessThan(L, R: TFileVersion): Boolean;// <
    class operator LessThanOrEqual(L, R: TFileVersion): Boolean;// <=
    //
    constructor Create(VersionStr: string);
    {$IFDEF MSWINDOWS}
    constructor CreateForFile(FileName: TFileName);
    {$ENDIF}
    function ToString: string;
  end;

  TUpdateInfo = record
    // Main
    ExeNames: TStringArray;
    Urls: TStringArray;
    Name: string;
    RootPath: string;
    // Optional
    Description: string;
    PngRes: string;
  end;

{$IFDEF MSWINDOWS}
function GetFileVersion(FileName: string; out Version: TFileVersion): Boolean;
{$ENDIF}

implementation

{$IFDEF MSWINDOWS}
uses
  WinApi.Windows;
{$ENDIF}

{$IFDEF MSWINDOWS}
function GetFileVersion(FileName: string; out Version: TFileVersion): Boolean;
var
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := False;
  UniqueString(FileName);
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
        if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
        begin
          Version.Major := HiWord(FI.dwFileVersionMS);
          Version.Minor := LoWord(FI.dwFileVersionMS);
          Version.Release := HiWord(FI.dwFileVersionLS);
          Version.Build := LoWord(FI.dwFileVersionLS);
          Result := True;
        end;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;
{$ENDIF}

{ TFileVersion }

constructor TFileVersion.Create(VersionStr: string);
var
  A: TArray<string>;
begin
  Major := 0;
  Minor := 0;
  Release := 0;
  Build := 0;
  A := VersionStr.Split(['.']);

  try
    if High(A) >= 0 then
      Major := A[0].Trim.ToInteger;
    if High(A) >= 1 then
      Minor := A[1].Trim.ToInteger;
    if High(A) >= 2 then
      Release := A[2].Trim.ToInteger;
    if High(A) >= 3 then
      Build := A[3].Trim.ToInteger;
  except
    on EConvertError do ;
  end;
end;

{$IFDEF MSWINDOWS}
constructor TFileVersion.CreateForFile(FileName: TFileName);
begin
  Self := Default(TFileVersion);
  GetFileVersion(FileName, Self);
end;
{$ENDIF}

class operator TFileVersion.Equal(L, R: TFileVersion): Boolean;
begin
  Result := (L.Major = R.Major) and (L.Minor = R.Minor) and (L.Release = R.Release) and (L.Build = R.Build);
end;

class operator TFileVersion.GreaterThan(L, R: TFileVersion): Boolean;
begin
  Result := R < L;
end;

class operator TFileVersion.GreaterThanOrEqual(L, R: TFileVersion): Boolean;
begin
  Result := R <= L;
end;

class operator TFileVersion.LessThan(L, R: TFileVersion): Boolean;
begin
  Result := False;

  // Major
  if L.Major > R.Major then Exit(False);
  if L.Major < R.Major then Exit(True);

  // Minor
  if L.Minor > R.Minor then Exit(False);
  if L.Minor < R.Minor then Exit(True);

  // Release
  if L.Release > R.Release then Exit(False);
  if L.Release < R.Release then Exit(True);

  // Build
  if L.Build > R.Build then Exit(False);
  if L.Build < R.Build then Exit(True);
end;

class operator TFileVersion.LessThanOrEqual(L, R: TFileVersion): Boolean;
begin
  Result := (L < R) or (L = R);
end;

class operator TFileVersion.NotEqual(L, R: TFileVersion): Boolean;
begin
  Result := not (L = R);
end;

function TFileVersion.ToString: string;
begin
  Result := Format('%d.%d.%d.%d', [Major, Minor, Release, Build]);
end;

end.
