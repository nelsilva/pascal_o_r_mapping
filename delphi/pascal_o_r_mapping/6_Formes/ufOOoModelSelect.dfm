object fOOoModelSelect: TfOOoModelSelect
  Left = 256
  Top = 114
  Width = 503
  Height = 286
  Caption = 'Choix d'#39'un mod'#232'le'
  Color = clBtnFace

  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lRepertoire: TLabel
    Left = 0
    Top = 239
    Width = 495
    Height = 13
    Align = alBottom
    Caption = 'lRepertoire'
  end
  object Panel1: TPanel
    Left = 0
    Top = 196
    Width = 495
    Height = 43
    Align = alBottom
    TabOrder = 0
    object bModifier: TButton
      Left = 8
      Top = 8
      Width = 121
      Height = 25
      Caption = 'Modifier ce mod'#232'le'
      TabOrder = 0
      OnClick = bModifierClick
    end
    object Panel2: TPanel
      Left = 322
      Top = 1
      Width = 172
      Height = 41
      Align = alRight
      TabOrder = 1
      object BitBtn2: TBitBtn
        Left = 88
        Top = 8
        Width = 75
        Height = 25
        TabOrder = 0
        Kind = bkCancel
      end
      object bOK: TBitBtn
        Left = 8
        Top = 8
        Width = 75
        Height = 25
        TabOrder = 1
        Kind = bkOK
      end
    end
  end
  object flb: TFileListBox
    Left = 0
    Top = 0
    Width = 495
    Height = 196
    Align = alClient
    ItemHeight = 16
    Mask = '*.ott'
    ShowGlyphs = True
    TabOrder = 1
    OnChange = flbChange
    OnDblClick = flbDblClick
  end
end
