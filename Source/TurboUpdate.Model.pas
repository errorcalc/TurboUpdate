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
unit TurboUpdate.Model;

interface

uses
  TurboUpdate.Types, TurboUpdate.Utils, System.Classes;

type
  TUpdater = class(TInterfacedPersistent, IUpdateModel)
  protected type
    TUpdateResult = (Success, Fail, TryAgain, Abort);
  private
    DownloadPath: string;
    Urls: TStringArray;
    ExeNames: TStringArray;
    Name: string;
    IsAbort: Boolean;
    RootPath: string;
    UpdateFile: string;
  protected
    View: IUpdateView;
    // Internal routlines
    procedure SyncView(Proc: TThreadProcedure);// perfect
    procedure SyncShowView;// perfect
    procedure SyncCloseView;// perfect
    function SyncErrorMessage(Text: string): Boolean;// perfect
    function UpdateFileName: string;// perfect
    function DoUpdate: TUpdateResult; virtual;
    // ... routlines
    function GetDownloadInfo: Boolean; virtual;// perfect
    function Download: Boolean; virtual;// perfect
    // function GetUpdateInfo: Boolean; virtual;
    function Unpacking: Boolean; virtual;// perfect
    procedure DeleteFiles;// ...
    procedure Done; virtual;// perfect
    { IUpdateModel }
    procedure Cancel; virtual;// perfect
  public
    constructor Create(View: IUpdateView; UpdateInfo: TUpdateInfo); virtual;
    destructor Destroy; override;
    procedure Update;
    procedure UpdateFromFile(FileName: string);
  end;

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

uses
  System.SysUtils, System.Zip, System.IniFiles, System.Generics.Collections,
  TurboUpdate.Internet, TurboUpdate.Download, TurboUpdate.Consts, System.SyncObjs;

function NormalizeFileName(FileName: string): string;
begin
  Result := FileName.Replace('/', PathDelim);
end;

{$HINTS OFF}
function FileToOld(FileName: string): Boolean;
const
  Suffics = '.old';
begin
  if FileExists(FileName + Suffics) then
    if not DeleteFile(FileName + Suffics) then
      Exit(False);

  if FileExists(FileName) then
    if not RenameFile(FileName, FileName + Suffics) then
      Exit(False);

  Result := True;
end;
{$HINTS ON}

{ TUpdateModel }

procedure TUpdater.Cancel;
begin
  IsAbort := True;
end;

procedure TUpdater.SyncCloseView;
begin
  SyncView(procedure
  begin
    View.Close;
  end);
end;

constructor TUpdater.Create(View: IUpdateView; UpdateInfo: TUpdateInfo);
begin
  // Info
  Urls := UpdateInfo.Urls;
  Name := UpdateInfo.Name;
  ExeNames := UpdateInfo.ExeNames + [ExtractFileName(ParamStr(0))];
  RootPath := IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0)) + PathDelim + UpdateInfo.RootPath);

  // set View
  Self.View := View;

  SyncView(procedure
  begin
    // set Model
    View.Model := Self;

    // State
    View.State := TUpdateState.Waiting;
    // Description
    if UpdateInfo.Description <> '' then
      View.Description := UpdateInfo.Description
    else
      View.Description := UpdateInfo.Name;
    // PngRes
    if UpdateInfo.PngRes <> '' then
      View.PngRes := UpdateInfo.PngRes;
    // Progress
    View.Progress(0, 1);
    // Status
    View.Status := sWaitingStatus;
    // Version
    View.Version := '';
  end);
end;

procedure TUpdater.DeleteFiles;
begin
  if FileExists(UpdateFileName) then
    DeleteFile(UpdateFileName);
end;

destructor TUpdater.Destroy;
begin
  View.Model := nil;
  inherited;
end;

procedure TUpdater.Done;
begin
  // View
  SyncView(procedure
  begin
    View.State := TUpdateState.Done;
    View.Status := sDoneStatus;
    View.ShowMessage(sDoneMessage);
    TurboUpdate.Utils.LaunchUpdateApp( ExeNames[0] , true); //open new update by application or app in inno setup //add by Francisco Aurino in 17/12/2022 16:25:43
  end);
end;

function TUpdater.Download: Boolean;
begin
  // View
  SyncView(procedure
  begin
    View.State := TUpdateState.Downloading;
    View.Status := sDownloadingStatus;
  end);

  try
    Result := DowloadFile(DownloadPath, UpdateFileName,
      procedure (Length, Progress: Int64; var Abort: Boolean)
      begin
        Abort := IsAbort;
        // View
        SyncView(procedure
        begin
          View.Progress(Progress, Length);
        end);
      end);
  except
    Result := False;
  end;
end;

function TUpdater.GetDownloadInfo: Boolean;
var
  FileVersion: TFileVersion;
begin
  // View
  SyncView(procedure
  begin
    View.State := TUpdateState.Waiting;
    View.Status := sWaitingStatus;
  end);

  if GetUpdateVersion(Urls, Name, FileVersion) then
    SyncView(procedure
    begin
      View.Version := Format(sVersion, [FileVersion.ToString]);
    end);

  DownloadPath := GetUpdateUrl(Urls, Name);
  Result := DownloadPath <> '';
end;

{function TUpdater.GetUpdateInfo: Boolean;
  procedure Load(Ini: TCustomIniFile);
  begin
    RootPath := Ini.ReadString('main', 'RootPath', '');
  end;
var
  ZipFile: TZipFile;
  Ini: TMemIniFile;
  Stream: TBytesStream;
  Strings: TStringList;
  Header: TZipHeader;
  Bytes: TBytes;
begin
  Stream := nil;
  Ini := nil;
  Strings := nil;
  ZipFile := TZipFile.Create;
  try
    ZipFile.Open(ExtractFileDir(ParamStr(0)) + PathDelim + 'Update.zip', TZipMode.zmRead);
    if ZipFile.IndexOf('TurboUpdate.ini') <> -1 then
    begin
      // Load to stream
      ZipFile.Read(ZipFile.IndexOf('TurboUpdate.ini'), Bytes);
      Stream := TBytesStream.Create(Bytes);

      // Load to strings
      Strings := TStringList.Create;
      Strings.LoadFromStream(Stream);

      // Load to ini
      Ini := TMemIniFile.Create('');
      Ini.SetStrings(Strings);

      Load(Ini);
    end;
  finally
    ZipFile.Free;
    Strings.Free;
    Ini.Free;
    Stream.Free;
  end;
end;}

function TUpdater.SyncErrorMessage(Text: string): Boolean;
var
  R: Boolean;
begin
  SyncView(procedure
  begin
    R := View.ShowErrorMessage(Text);
  end);

  Result := R;
end;

procedure TUpdater.SyncShowView;
begin
  SyncView(procedure
  begin
    View.Show;
  end);
end;

procedure TUpdater.SyncView(Proc: TThreadProcedure);
begin
  if View <> nil then
    TThread.Synchronize(nil, Proc);
end;

function TUpdater.Unpacking: Boolean;
var
  ZipFile: TZipFile;
  I: Integer;
  FullFileName, FileName, ExeName: string;
begin
  Result := True;

  // View
  SyncView(procedure
  begin
    View.State := TUpdateState.Unpacking;
    View.Status := sUnpackingStatus;
  end);

  ZipFile := TZipFile.Create;
  try
    try
      ZipFile.Open(UpdateFileName, TZipMode.zmRead);

      for I := 0 to ZipFile.FileCount - 1 do
      begin
        for ExeName in ExeNames do
        begin
          FileName := ExtractFileName(NormalizeFileName(ZipFile.FileName[I]));
          if ExeName.ToUpper = FileName.ToUpper then
          begin
            FullFileName := RootPath + NormalizeFileName(ZipFile.FileName[I]);

            if not FileToOld(FullFileName) then
              Exit(False);

            Break;
          end;
        end;

        ZipFile.Extract(ZipFile.FileNames[I], RootPath);

        // View
        SyncView(procedure
        begin
          View.Progress(I, ZipFile.FileCount - 1);
        end);
      end;
    except
      on EZipException do
        Exit(False);
      on EFOpenError do
        Exit(False);
    end;
  finally
    ZipFile.Free;
  end;
end;

function TUpdater.DoUpdate: TUpdateResult;
begin  
  // GetInfo
  if not GetDownloadInfo then
    if IsAbort then
      Exit(TUpdateResult.Abort)
    else
      if SyncErrorMessage(sConnectionError) then
        Exit(TUpdateResult.TryAgain)
      else
        Exit(TUpdateResult.Fail);   

  // Download
  if not Download then
    if IsAbort then
      Exit(TUpdateResult.Abort)
    else
      if SyncErrorMessage(sDownloadError) then
        Exit(TUpdateResult.TryAgain)
      else
        Exit(TUpdateResult.Fail);

  // GetUpdateInfo;

  // Unpacking
  if not Unpacking then
    if SyncErrorMessage(sCorruptedFilesError) then
      Exit(TUpdateResult.TryAgain)
    else
      Exit(TUpdateResult.Fail);

  DeleteFiles;

  Done;

  Result := TUpdateResult.Success;
end;

procedure TUpdater.Update;
var
  Result: TUpdateResult;
begin
  IsAbort := False;
  SyncShowView; 
  try
    //exit;
    repeat
      Result := DoUpdate;
    until Result <> TUpdateResult.TryAgain;
  finally
    SyncCloseView;
  end;
end;

function TUpdater.UpdateFileName: string;
const
  ArchiveName = 'Update.zip';
begin
  if UpdateFile = '' then
    Result := ExtractFileDir(ParamStr(0)) + PathDelim + ArchiveName
  else
    Result := UpdateFile;
end;

procedure TUpdater.UpdateFromFile(FileName: string);
var
  TryAgain: Boolean;
begin
  UpdateFile := FileName;
  try
    SyncShowView;
    try
      TryAgain := False;
      repeat
        // Unpacking
        if Unpacking then
        begin
          Done;
        end else
          TryAgain := SyncErrorMessage(sCorruptedFilesError);
      until not TryAgain;
    finally
      SyncCloseView;
    end;
  finally
    UpdateFile := '';
  end;
end;


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
