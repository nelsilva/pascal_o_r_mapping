object fAttente_Demarrage: TfAttente_Demarrage
  Left = 568
  Top = 312
  Width = 123
  Height = 62
  BorderIcons = [biHelp]
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    115
    28)
  PixelsPerInch = 96
  TextHeight = 13
  object lTimer: TLabel
    Left = 0
    Top = 5
    Width = 115
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'lTimer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object bStop: TButton
    Left = 69
    Top = 4
    Width = 40
    Height = 17
    Caption = 'Arr'#234'ter'
    TabOrder = 0
    OnClick = bStopClick
  end
end
