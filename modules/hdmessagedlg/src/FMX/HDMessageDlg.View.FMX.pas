unit HDMessageDlg.View.FMX;

interface

uses
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Effects,
  FMX.Forms,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,

  HDMessageDlg.Consts,
  HDMessageDlg.Interfaces,

  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants,

  Winapi.Windows;

type
  THDMessageDlgFMX = class(TForm)
    RecBackGround: TRectangle;
    LayoutContainer: TLayout;
    LayoutTop: TLayout;
    ReclblTitle: TRectangle;
    lbl_Title: TLabel;
    LayoutContainerMessage: TLayout;
    LayoutIMG: TLayout;
    imgMenssage: TImage;
    LayoutMessage: TLayout;
    lbl_Question: TLabel;
    lbl_BodyMessage: TLabel;
    LayoutButtons: TLayout;
    LayoutYes: TLayout;
    BackbtnYes: TRectangle;
    btnYes: TButton;
    ShadowEffectBtnSim: TShadowEffect;
    LayoutNo: TLayout;
    BackbtnNo: TRectangle;
    btnNo: TButton;
    ShadowEffectBtnNao: TShadowEffect;
    StyleBook: TStyleBook;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnNoClick(Sender: TObject);
    procedure btnYesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FMsgTitle: string;
    FMsgQuestion: string;
    FMsgBody: string;
    FMsgType: TType;
    FMsgIcon: string;
    procedure SetMsgIcon(const Value: string);
    procedure SetMsgBody(const Value: string);
    procedure SetMsgQuestion(const Value: string);
    procedure SetMsgType(const Value: TType);
    procedure SetMsgTitle(const Value: string);
    procedure TypeOk;
    procedure TypeQuestion;
    procedure SetNo;
    procedure SetYes;
  public
    MsgResponse : Boolean;
  published
    property MsgTitle : string read FMsgTitle write SetMsgTitle;
    property MsgQuestion : string read FMsgQuestion write SetMsgQuestion;
    property MsgBody : string read FMsgBody write SetMsgBody;
    property MsgIcon : string read FMsgIcon write SetMsgIcon;
    property MsgType : TType read FMsgType write SetMsgType;
  end;

implementation

{$R *.fmx}

{ TViewMensagem }

procedure THDMessageDlgFMX.btnNoClick(Sender: TObject);
begin
  SetNo;
end;

procedure THDMessageDlgFMX.btnYesClick(Sender: TObject);
begin
  SetYes;
end;

procedure THDMessageDlgFMX.FormCreate(Sender: TObject);
begin
  // Set Color
  ReclblTitle.Fill.Color     := TAlphaColor(FMXColorTop);
  RecBackGround.Fill.Color   := TAlphaColor(FMXColorBackuground);
  BackbtnNo.Fill.Color       := TAlphaColor(FMXColorButtonNo);
  BackbtnYes.Fill.Color      := TAlphaColor(FMXColorButtonYes);
  lbl_Title.FontColor        := TAlphaColor(FMXLabelTitle);
  lbl_Question.FontColor     := TAlphaColor(FMXLabelQuestion);
  lbl_BodyMessage.FontColor  := TAlphaColor(FMXLabelQuestion);
  btnNo.FontColor            := TAlphaColor(FMXTextButtonNo);
  btnYes.FontColor           := TAlphaColor(FMXTextButtonYes);
end;

procedure THDMessageDlgFMX.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if LayoutYes.Visible then
   if key = VK_RETURN then
    SetYes;

 if LayoutNo.Visible then
   if key = VK_ESCAPE then
    SetNo;
end;

procedure THDMessageDlgFMX.FormShow(Sender: TObject);
begin
  MsgResponse          := False;
  btnNo.Text           := TextButtonNo;
  lbl_Title.Text       := FMsgTitle;
  lbl_Question.Text    := FMsgQuestion;
  lbl_BodyMessage.Text := FMsgBody;

  case FMsgType of
   tOK: TypeOk;
   tQuestion: TypeQuestion;
  end;

  imgMenssage.Bitmap   := imgMenssage.MultiResBitmap.Items[FMsgIcon.ToInteger].Bitmap;
end;

procedure THDMessageDlgFMX.SetMsgIcon(const Value: string);
begin
  FMsgIcon := Value;
end;

procedure THDMessageDlgFMX.SetMsgBody(const Value: string);
begin
  FMsgBody := Value;
end;

procedure THDMessageDlgFMX.SetNo;
begin
  MsgResponse := False;
  Close;
end;

procedure THDMessageDlgFMX.SetMsgQuestion(const Value: string);
begin
  FMsgQuestion := Value;
end;

procedure THDMessageDlgFMX.SetYes;
begin
  MsgResponse := True;
  Close;
end;

procedure THDMessageDlgFMX.SetMsgType(const Value: TType);
begin
  FMsgType := Value;
end;

procedure THDMessageDlgFMX.SetMsgTitle(const Value: string);
begin
  FMsgTitle := Value;
end;

procedure THDMessageDlgFMX.TypeOk;
begin
  LayoutNo.Visible := False;
  btnYes.Text := TextButtonOK;
end;

procedure THDMessageDlgFMX.TypeQuestion;
begin
  LayoutNo.Visible := True;
  btnYes.Text := TextButtonYes;
  BackbtnYes.Fill.Color := TAlphaColor($FFEF553B);
end;

end.
