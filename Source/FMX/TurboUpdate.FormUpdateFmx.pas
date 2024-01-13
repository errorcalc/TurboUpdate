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
unit TurboUpdate.FormUpdateFmx;
interface
uses
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,
  HDMessageDlg.Interfaces,
  HDMessageDlg,
  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants,

  TurboUpdate.Types;
type
  TFormUpdateFmx = class(TForm, IUpdateView)
    LayoutMain: TLayout;
    LayoutFotter: TLayout;
    ButtonCancel: TButton;
    LineFotterSeparator: TLine;
    ProgressBar: TProgressBar;
    LayoutImage: TLayout;
    Image: TImage;
    LayoutInfo: TLayout;
    LabelDescription: TLabel;
    LabelState: TLabel;
    LabelVersion: TLabel;
    LayoutForm: TLayout;
    LabelWaiting: TLabel;
    LayoutProgress: TLayout;
    LabelTurboUpdate: TLabel;
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LabelTurboUpdateClick(Sender: TObject);
  private
    Model: IUpdateModel;
  public
    { IUpdateView }
    procedure SetVersion(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetStatus(const Value: string);
    procedure SetPngRes(const Value: string);
    procedure SetModel(Model: IUpdateModel);
    procedure SetUpdateState(Value: TUpdateState);
    procedure ShowMessage(Message: string);
    function ShowErrorMessage(Message: string): Boolean;
    procedure Progress(Progress, Length: Integer);
    procedure IUpdateView.Close = ViewClose;
      procedure ViewClose;
    procedure IUpdateView.Show = ViewShow;
      procedure ViewShow;
  end;
implementation
uses
  Winapi.ShellApi;
{$R *.fmx}

{ TFormUpdateFmx }
procedure TFormUpdateFmx.ButtonCancelClick(Sender: TObject);
begin
  Model.Cancel;
end;
procedure TFormUpdateFmx.ViewClose;
begin
  OnClose := nil;
  inherited Close;
end;
procedure TFormUpdateFmx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caNone;
  Model.Cancel;
end;
procedure TFormUpdateFmx.LabelTurboUpdateClick(Sender: TObject);
begin
  ShellExecute(0, 'Open', PChar('http://github.com/errorcalc/TurboUpdate'), nil, nil, 0);
end;
procedure TFormUpdateFmx.Progress(Progress, Length: Integer);
begin
  ProgressBar.Max := Length;
  ProgressBar.Value := Progress;
end;
procedure TFormUpdateFmx.SetDescription(const Value: string);
begin
  LabelDescription.Text := Value;
end;
procedure TFormUpdateFmx.SetModel(Model: IUpdateModel);
begin
  Self.Model := Model;
end;
procedure TFormUpdateFmx.SetPngRes(const Value: string);
var
  Stream: TResourceStream;
begin
  Stream := TResourceStream.Create(HInstance, Value, RT_RCDATA);
  try
    Image.Bitmap.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;
procedure TFormUpdateFmx.SetStatus(const Value: string);
begin
  LabelState.Text := Value;
end;
procedure TFormUpdateFmx.SetUpdateState(Value: TUpdateState);
begin
  case Value of
    TUpdateState.Waiting:
      begin
        LabelWaiting.Visible := True;
        ButtonCancel.Enabled := False;
      end;
    TUpdateState.Downloading:
      begin
        ButtonCancel.Enabled := True;
        LabelWaiting.Visible := False;
      end;
    TUpdateState.Unpacking:
      begin
        ButtonCancel.Enabled := False;
        LabelWaiting.Visible := False;
      end;
    TUpdateState.Done:
      begin
        LabelWaiting.Visible := False;
      end;
  end;
end;
procedure TFormUpdateFmx.SetVersion(const Value: string);
begin
  LabelVersion.Text := Value;
end;
procedure TFormUpdateFmx.ViewShow;
begin
  Self.Position := TFormPosition.ScreenCenter;  // Add by Renato Trevisan
  inherited Show;
end;
function TFormUpdateFmx.ShowErrorMessage(Message: string): Boolean;
var
 Msg : iHDMessageDlg;
begin
  Msg := THDMessageDlg.New;
  Result :=
   Msg
    .MsgTitle('Update')
    .MsgQuestion('')
    .MsgBody(Message)
    .MsgIcon(iError)
    .MsgType(tQuestion)
    .DisplayQuestion;  // add by Renato Trevisan 12-1-24
//  Result := MessageDlg(Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes;
end;
procedure TFormUpdateFmx.ShowMessage(Message: string);
var
 Msg : iHDMessageDlg;
begin
  Msg := THDMessageDlg.New;
   Msg
    .MsgTitle('Update')
    .MsgQuestion('')
    .MsgBody(Message)
    .MsgIcon(iError)
    .MsgType(tOK)
    .DisplayMessage; // add by Renato Trevisan 12-1-24
//  MessageDlg(Message, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
end;
end.
