object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Test standalone'
  ClientHeight = 89
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 68
    Width = 133
    Height = 13
    Caption = 'On GitHub - version 2.0.0.0'
  end
  object ButtonCheckUpdateOld: TButton
    Left = 9
    Top = 32
    Width = 153
    Height = 25
    Caption = 'Check Update (1.9.3.0)'
    TabOrder = 0
    OnClick = ButtonCheckUpdateOldClick
  end
  object ButtonCheckUpdateCur: TButton
    Left = 327
    Top = 32
    Width = 153
    Height = 25
    Caption = 'Check Update (for this exe)'
    TabOrder = 2
    OnClick = ButtonCheckUpdateCurClick
  end
  object ButtonCheckUpdateNew: TButton
    Left = 168
    Top = 32
    Width = 153
    Height = 25
    Caption = 'Check Update (2.0.0.0)'
    TabOrder = 1
    OnClick = ButtonCheckUpdateNewClick
  end
end
