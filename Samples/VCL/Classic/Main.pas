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
  TurboUpdate.Check, TurboUpdate.Utils;

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
begin
  CheckUpdate(['https://raw.githubusercontent.com/errorcalc/TurboUpdate/master/Update.ini'],
    'TurboUpdate.Vcl.Classic', Version,
    procedure (UpdateAviable: Boolean; Version: TFileVersion)
    begin
      if UpdateAviable then
      begin
        if MessageDlg('Update aviable, Version: ' + Version.ToString + sLineBreak + 'Update?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          LaunchUpdateApp('VclUpdate.exe');
      end
      else
        MessageDlg('Updates not found!', mtInformation, [mbYes], 0);
    end);
end;

end.
