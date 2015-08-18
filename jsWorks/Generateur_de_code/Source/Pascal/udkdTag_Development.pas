unit udkdTag_Development;
{                                                                               |
    Author: Jean SUZINEAU <Jean.Suzineau@wanadoo.fr>                            |
            partly as freelance: http://www.mars42.com                          |
        and partly as employee : http://www.batpro.com                          |
    Contact: gilles.doutre@batpro.com                                           |
                                                                                |
    Copyright 2014 Jean SUZINEAU - MARS42                                       |
    Copyright 2014 Cabinet Gilles DOUTRE - BATPRO                               |
                                                                                |
    This program is free software: you can redistribute it and/or modify        |
    it under the terms of the GNU Lesser General Public License as published by |
    the Free Software Foundation, either version 3 of the License, or           |
    (at your option) any later version.                                         |
                                                                                |
    This program is distributed in the hope that it will be useful,             |
    but WITHOUT ANY WARRANTY; without even the implied warranty of              |
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               |
    GNU Lesser General Public License for more details.                         |
                                                                                |
    You should have received a copy of the GNU Lesser General Public License    |
    along with this program.  If not, see <http://www.gnu.org/licenses/>.       |
                                                                                |
|                                                                               }

interface

uses
    uBatpro_StringList,
    uDataUtilsU,
    uChamp,

    uBatpro_Ligne,

    udkdBase,

    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, DBCtrls, Grids, DBGrids, ActnList, StdCtrls, ComCtrls, Buttons,
    ExtCtrls, DB,
    ucChampsGrid, ucBatpro_Shape;

type
 TdkdTag_Development
 =
  class(TdkdBase)
    procedure FormCreate(Sender: TObject);
    procedure bImprimerClick(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    procedure Accroche( _bl: TBatpro_Ligne; _sl: TBatpro_StringList; _pc: TPageControl); override;
    procedure Decroche( _bl: TBatpro_Ligne; _sl: TBatpro_StringList; _pc: TPageControl); override;
  end;

function dkdTag_Development: TdkdTag_Development;

implementation

uses
    uClean,

{dkd_implementation_uses_key}
    uBatpro_Ligne_Printer,
    upoolTag_Development;

{$R *.dfm}

var
   FdkdTag_Development: TdkdTag_Development;

function dkdTag_Development: TdkdTag_Development;
begin
     Clean_Get( Result, FdkdTag_Development, TdkdTag_Development);
end;

{ TdkdTag_Development }

procedure TdkdTag_Development.FormCreate(Sender: TObject);
begin
     pool:= poolTag_Development;
     Nom:= 'Tag_Development';
     inherited;
end;

procedure TdkdTag_Development.bImprimerClick(Sender: TObject);
var
   cLibelle: TChamp;
   sLibelle: String;
begin
     inherited;
     cLibelle:= bl.Champs.Champ[ 'Libelle'];
     if Assigned( cLibelle)
     then
         sLibelle:= 'Tag_Development de '+cLibelle.Chaine
     else
         sLibelle:= 'Tag_Development';

     Batpro_Ligne_Printer.Execute( 'dkdTag_Development.stw',
                                   sLibelle,[],[],[],[],
                                   ['Tag_Development'],
                                   [sl],
                                   [ nil],
                                   [ nil]);
end;

procedure TdkdTag_Development.Accroche( _bl: TBatpro_Ligne; _sl: TStringList; _pc: TPageControl);
begin
     inherited;
end;

procedure TdkdTag_Development.Decroche( _bl: TBatpro_Ligne; _sl: TStringList; _pc: TPageControl);
begin
     inherited;
end;


initialization
              Clean_Create ( FdkdTag_Development, TdkdTag_Development);
finalization
              Clean_Destroy( FdkdTag_Development);
end.