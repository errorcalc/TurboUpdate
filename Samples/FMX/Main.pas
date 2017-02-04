unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, TurboUpdate.Types;

type
  TFormMain = class(TForm)
    ButtonCheckUpdateOld: TButton;
    ButtonCheckUpdateNew: TButton;
    ButtonCheckUpdateCur: TButton;
    Label1: TLabel;
    procedure ButtonCheckUpdateCurClick(Sender: TObject);
    procedure ButtonCheckUpdateNewClick(Sender: TObject);
    procedure ButtonCheckUpdateOldClick(Sender: TObject);
  private
    { Private declarations }
    procedure Check(Version: TFileVersion);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses
  TurboUpdate.Check, TurboUpdate.Utils, TurboUpdate.UpdateFMX;

{ TFormMain }

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
  AppName = 'TurboUpdate.Fmx.Standalone';
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
        if MessageDlg('Update aviable, Version: ' + Version.ToString + sLineBreak + 'Update?', TMsgDlgType.mtConfirmation,
          [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
        begin
          Info := Default(TUpdateInfo);
          Info.Urls := Urls;
          Info.ExeNames := ['FmxApplication.exe'];
          Info.Name := AppName;
          Info.Description := 'TurboUpdate/Fmx/Standalone';
          TurboUpdate.UpdateFMX.Update(Info);
        end;
      end
      else
        MessageDlg('Updates not found!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbYes], 0);
    end);
end;

end.
