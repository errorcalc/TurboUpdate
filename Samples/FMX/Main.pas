unit Main;
interface

uses
  TurboUpdate,

  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.StdCtrls,
  FMX.Types,

  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants,

  TurboUpdate.Model.Interfaces,
  TurboUpdate.Interfaces,
  TurboUpdate.Model.Types;

type
  TFormMain = class(TForm)
    ButtonCheckUpdateOld: TButton;
    ButtonCheckUpdateNew: TButton;
    ButtonCheckUpdateCur: TButton;
    Label1: TLabel;
    procedure ButtonCheckUpdateCurClick(Sender: TObject);
    procedure ButtonCheckUpdateNewClick(Sender: TObject);
    procedure ButtonCheckUpdateOldClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FTurboUpdate : iTurboUpdate;
  public
  end;
var
  FormMain: TFormMain;

implementation
{$R *.fmx}

{ TFormMain }
procedure TFormMain.ButtonCheckUpdateCurClick(Sender: TObject);
begin
  FTurboUpdate
   .ExeNames(['FmxApplication.exe'])
   .Urls(['https://raw.githubusercontent.com/Rtrevisan20/TurboUpdate/master/Update.ini'])
   .AppName('TurboUpdate.Fmx.Standalone')
   .Description('TurboUpdate/Fmx/Standalone')
   .Version(TFileVersion.CreateForFile(ParamStr(0)))
   .UpdateFMX;
end;
procedure TFormMain.ButtonCheckUpdateNewClick(Sender: TObject);
begin
  FTurboUpdate
   .ExeNames(['FmxApplication.exe'])
   .Urls(['https://raw.githubusercontent.com/Rtrevisan20/TurboUpdate/master/Update.ini'])
   .AppName('TurboUpdate.Fmx.Standalone')
   .Description('TurboUpdate/Fmx/Standalone')
   .Version(TFileVersion.Create('2.0.0.0'))
   .UpdateFMX;
end;
procedure TFormMain.ButtonCheckUpdateOldClick(Sender: TObject);
begin
  FTurboUpdate
   .ExeNames(['FmxApplication.exe'])
   .Urls(['https://raw.githubusercontent.com/Rtrevisan20/TurboUpdate/master/Update.ini'])
   .AppName('TurboUpdate.Fmx.Standalone')
   .Description('TurboUpdate/Fmx/Standalone')
   .Version(TFileVersion.Create('1.9.3.0'))
   .UpdateFMX;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FTurboUpdate := TTurboUpdate.New;
end;

end.
