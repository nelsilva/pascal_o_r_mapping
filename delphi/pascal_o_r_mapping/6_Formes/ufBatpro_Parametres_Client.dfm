object fBatpro_Parametres_Client: TfBatpro_Parametres_Client
  Left = 305
  Top = 114
  Caption = 'fBatpro_Parametres_Client'
  ClientHeight = 661
  ClientWidth = 1008
  Color = clBtnFace

  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object m: TMemo
    Left = 0
    Top = 41
    Width = 1008
    Height = 620
    Align = alClient

    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier'
    Font.Style = []
    Lines.Strings = (
      'm')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 1016
    object bSaveAs: TButton
      Left = 40
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Enregistrer sous'
      TabOrder = 0
      OnClick = bSaveAsClick
    end
  end
  object sd: TSaveDialog
    Left = 152
    Top = 8
  end
end
