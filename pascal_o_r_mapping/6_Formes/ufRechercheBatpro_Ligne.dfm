inherited fRechercheBatpro_Ligne: TfRechercheBatpro_Ligne
  Left = 192
  Caption = 'fRechercheBatpro_Ligne'
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited sLog: TSplitter
    Top = 429
  end
  inherited pBas: TPanel
    Top = 435
    Height = 55
    inherited pFermer: TPanel
      Height = 53
      inherited bValidation: TBitBtn
        Default = True
      end
    end
    object gbSaisie: TGroupBox
      Left = 8
      Top = 0
      Width = 178
      Height = 48
      Caption = 'Saisie'
      TabOrder = 1
      object bCreationModification: TButton
        Left = 8
        Top = 16
        Width = 121
        Height = 25
        Caption = 'Cr'#233'ation / Modification'
        TabOrder = 0
      end
    end
  end
  object pHaut: TPanel [3]
    Left = 0
    Top = 18
    Width = 815
    Height = 41
    Align = alTop
    ParentBackground = False
    TabOrder = 4
  end
  object pSG: TPanel [6]
    Left = 0
    Top = 59
    Width = 815
    Height = 370
    Align = alClient
    Caption = 'pSG'
    ParentBackground = False
    TabOrder = 5
    object lTri: TLabel
      Left = 1
      Top = 1
      Width = 813
      Height = 13
      Align = alTop
      Caption = 'lTri'
      Visible = False
    end
    object sg: TStringGrid
      Left = 1
      Top = 14
      Width = 813
      Height = 355
      Align = alClient
      ColCount = 2
      FixedCols = 0
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      TabOrder = 0
      OnDblClick = sgDblClick
    end
  end
end
