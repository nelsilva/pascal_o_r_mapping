object fBatpro_MySQL: TfBatpro_MySQL
  Left = 192
  Top = 107
  Caption = 'fBatpro_MySQL'
  ClientHeight = 134
  ClientWidth = 195
  Color = clBtnFace

  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 48
    Height = 13
    Caption = 'Hostname'
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 46
    Height = 13
    Caption = 'Database'
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 50
    Height = 13
    Caption = 'UserName'
  end
  object Label4: TLabel
    Left = 8
    Top = 80
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object eHostName: TEdit
    Left = 64
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'eHostName'
  end
  object eDatabase: TEdit
    Left = 64
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'eDatabase'
  end
  object eUser_Name: TEdit
    Left = 64
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'eUser_Name'
  end
  object ePassWord: TEdit
    Left = 64
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'ePassWord'
  end
  object bOK: TBitBtn
    Left = 8
    Top = 104
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 4
    OnClick = bOKClick
  end
  object bCancel: TBitBtn
    Left = 112
    Top = 104
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 5
    OnClick = bCancelClick
  end
end
