unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, TurboUpdate.Types;

type
  TFormMain = class(TForm)
    ButtonCheckUpdateOld: TButton;
    ButtonCheckUpdateCur: TButton;
    Label1: TLabel;
    ButtonCheckUpdateNew: TButton;
    procedure ButtonCheckUpdateOldClick(Sender: TObject);
    procedure ButtonCheckUpdateCurClick(Sender: TObject);
    procedure ButtonCheckUpdateNewClick(Sender: TObject);
  private
    procedure Check(Version: TFileVersion);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  TurboUpdate.Check, TurboUpdate.Utils, TurboUpdate.Update;

{$R *.dfm}

procedure TFormMain.ButtonCheckUpdateCurClick(Sender: TObject);
begin
  Check(TFileVersion.CreateForFile(ParamStr(0)));
end;

procedure TFormMain.ButtonCheckUpdateNewClick(Sender: TObject);
begin
  Check(TFileVersion.Create('2.0.0.0'));
end;

procedure TFormMain.ButtonCheckUpdateOldClick(Sender: TObject);
begin
  Check(TFileVersion.Create('1.9.3.0'));
end;

procedure TFormMain.Check(Version: TFileVersion);
const
  AppName = 'TurboUpdate.Vcl.Standalone';
var
  Info: TUpdateInfo;
  Urls: TStringArray;
begin
  Urls := ['https://raw.githubusercontent.com/errorcalc/TurboUpdate/master/Update.ini'];

  CheckUpdate(Urls, AppName, Version,
    procedure (UpdateAviable: Boolean; Version: TFileVersion)
    begin
      if UpdateAviable then
      begin
        if MessageDlg('Update aviable, Version: ' + Version.ToString + sLineBreak + 'Update?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          Info := Default(TUpdateInfo);
          Info.Urls := Urls;
          Info.ExeNames := ['VclStandalone.exe'];
          Info.Name := AppName;
          Info.Description := 'TurboUpdate/Vcl/Standalone';
          TurboUpdate.Update.Update(Info);
        end;
      end
      else
        MessageDlg('Updates not found!', mtInformation, [mbYes], 0);
    end);
end;

end.
