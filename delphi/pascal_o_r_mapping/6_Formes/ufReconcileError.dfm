object fReconcileError: TfReconcileError
  Left = 282
  Top = 151
  Caption = 'Erreur de mise '#224' jour'
  ClientHeight = 300
  ClientWidth = 544
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = DisplayFieldValues
  PixelsPerInch = 96
  TextHeight = 13
  object UpdateData: TStringGrid
    Left = 0
    Top = 137
    Width = 544
    Height = 122
    Align = alClient
    ColCount = 4
    DefaultColWidth = 119
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goThumbTracking]
    TabOrder = 0
    OnSelectCell = UpdateDataSelectCell
    OnSetEditText = UpdateDataSetEditText
    ExplicitWidth = 552
    ExplicitHeight = 134
  end
  object Panel1: TPanel
    Left = 0
    Top = 259
    Width = 544
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 271
    ExplicitWidth = 552
    object ConflictsOnly: TCheckBox
      Left = 11
      Top = 10
      Width = 174
      Height = 17
      Caption = 'Champs en conflit uniquement'
      TabOrder = 0
      OnClick = DisplayFieldValues
    end
    object ChangedOnly: TCheckBox
      Left = 201
      Top = 10
      Width = 168
      Height = 17
      Caption = 'Champs modifi'#233's uniquement'
      TabOrder = 1
      OnClick = DisplayFieldValues
    end
    object OKBtn: TButton
      Left = 382
      Top = 9
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
    object CancelBtn: TButton
      Left = 470
      Top = 9
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Annuler'
      ModalResult = 2
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 544
    Height = 137
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 552
    object Label1: TLabel
      Left = 54
      Top = 13
      Width = 101
      Height = 13
      Caption = 'Type de mise '#224' jour :'
    end
    object UpdateType: TLabel
      Left = 155
      Top = 13
      Width = 69
      Height = 13
      Caption = 'Modification'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 54
      Top = 33
      Width = 90
      Height = 13
      Caption = 'Message d'#39'erreur :'
    end
    object IconImage: TImage
      Left = 9
      Top = 12
      Width = 34
      Height = 34
      Picture.Data = {
        055449636F6E0000010002002020100000000000E80200002600000020200200
        00000000300100000E0300002800000020000000400000000100040000000000
        0002000000000000000000000000000000000000000000000000800000800000
        00808000800000008000800080800000C0C0C000808080000000FF0000FF0000
        00FFFF00FF000000FF00FF00FFFF0000FFFFFF00000008888888888888888888
        8888880000008888888888888888888888888880003000000000000000000000
        0008888803BBBBBBBBBBBBBBBBBBBBBBBB7088883BBBBBBBBBBBBBBBBBBBBBBB
        BBB708883BBBBBBBBBBBBBBBBBBBBBBBBBBB08883BBBBBBBBBBBB7007BBBBBBB
        BBBB08803BBBBBBBBBBBB0000BBBBBBBBBB7088003BBBBBBBBBBB0000BBBBBBB
        BBB0880003BBBBBBBBBBB7007BBBBBBBBB708800003BBBBBBBBBBBBBBBBBBBBB
        BB088000003BBBBBBBBBBB0BBBBBBBBBB70880000003BBBBBBBBB707BBBBBBBB
        B08800000003BBBBBBBBB303BBBBBBBB7088000000003BBBBBBBB000BBBBBBBB
        0880000000003BBBBBBB70007BBBBBB708800000000003BBBBBB30003BBBBBB0
        88000000000003BBBBBB00000BBBBB70880000000000003BBBBB00000BBBBB08
        800000000000003BBBBB00000BBBB7088000000000000003BBBB00000BBBB088
        0000000000000003BBBB00000BBB708800000000000000003BBB70007BBB0880
        00000000000000003BBBBBBBBBB70880000000000000000003BBBBBBBBB08800
        000000000000000003BBBBBBBB7088000000000000000000003BBBBBBB088000
        0000000000000000003BBBBBB708800000000000000000000003BBBBB0880000
        00000000000000000003BBBB70800000000000000000000000003BB700000000
        0000000000000000000003330000000000000000F8000003F0000001C0000000
        80000000000000000000000000000001000000018000000380000003C0000007
        C0000007E000000FE000000FF000001FF000001FF800003FF800003FFC00007F
        FC00007FFE0000FFFE0000FFFF0001FFFF0001FFFF8003FFFF8003FFFFC007FF
        FFC007FFFFE00FFFFFE01FFFFFF07FFFFFF8FFFF280000002000000040000000
        0100010000000000800000000000000000000000000000000000000000000000
        FFFFFF000000000000000000000000003FFFFFC07FFFFFE07FFFFFF07FFCFFF0
        7FF87FE03FF87FE03FFCFFC01FFFFFC01FFDFF800FFDFF800FFDFF0007F8FF00
        07F8FE0003F8FE0003F07C0001F07C0001F0780000F0780000F070000078F000
        007FE000003FE000003FC000001FC000001F8000000F8000000F000000060000
        00000000FFFFFFFFFFFFFFFFC000001F8000000F000000070000000700000007
        000000078000000F8000000FC000001FC000001FE000003FE000003FF000007F
        F000007FF80000FFF80000FFFC0001FFFC0001FFFE0003FFFE0003FFFF0007FF
        FF0007FFFF800FFFFF800FFFFFC01FFFFFC01FFFFFE03FFFFFE03FFFFFF07FFF
        FFF8FFFF}
    end
    object ActionGroup: TRadioGroup
      Left = 407
      Top = 10
      Width = 135
      Height = 113
      Caption = ' Action de conciliation '
      TabOrder = 0
      OnClick = DisplayFieldValues
    end
    object ErrorMsg: TMemo
      Left = 53
      Top = 52
      Width = 342
      Height = 71
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
  end
end
