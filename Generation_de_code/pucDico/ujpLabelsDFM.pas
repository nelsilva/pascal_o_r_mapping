unit ujpLabelsDFM;
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
    SysUtils, Classes,
    uGlobal,
    uContexteClasse,
    uContexteMembre,
    uJoinPoint;

type
 TjpLabelsDFM
 =
  class( TJoinPoint)
  //Attributs
  public
  //Gestion du cycle de vie
  public
    constructor Create;
  //Gestion de la visite d'une classe
  public
    procedure Initialise(_cc: TContexteClasse); override;
    procedure VisiteMembre(_cm: TContexteMembre); override;
    procedure Finalise; override;
  //Comptage des appels
  private
    Numero: Integer;
  //Gestion du positionnement sur la fiche en 2 colonnes
  private
    function Colonne2: Boolean;
    function GetLeft: Integer;
    function GetTop: String;
  end;

var
   jpLabelsDFM: TjpLabelsDFM;

implementation

{ TjpLabelsDFM }

constructor TjpLabelsDFM.Create;
begin
     Cle:= '    object lNomChamp: TLabel';

end;

procedure TjpLabelsDFM.Initialise(_cc: TContexteClasse);
begin
     inherited;
     Numero:= 0;
end;

function TjpLabelsDFM.Colonne2: Boolean;
begin
     Result:= Numero > ( cc.NbChamps div 2);
end;

function TjpLabelsDFM.GetLeft: Integer;
begin
     if Colonne2
     then
         Result:= 258
     else
         Result:= 0;
end;

function TjpLabelsDFM.GetTop: String;
var
   jtop: Integer;
   top: Integer;
begin
     if Colonne2
     then
         jtop:= Numero- (cc.NbChamps div 2)
     else
         jtop:= Numero;
     top:= 4+22 * (1+jtop);
     Result:= IntToStr( top);
end;

procedure TjpLabelsDFM.VisiteMembre(_cm: TContexteMembre);
begin
     inherited;
     Valeur
     :=
        Valeur
       +'    object l'+UpperCase(_cm.sNomChamp)+': TLabel'#13#10
       +'      Caption = '+QuotedStr( _cm.sLibelle)+'    '#13#10
       +'      Left = '+IntToStr(16+GetLeft)+'           '#13#10
       +'      Top = '+GetTop+'                          '#13#10
       +'      Height = 13                               '#13#10
       +'    end                                         '#13#10;
     Inc( Numero);
end;

procedure TjpLabelsDFM.Finalise;
begin
     inherited;
     Valeur:= Valeur + Cle;
end;

initialization
              jpLabelsDFM:= TjpLabelsDFM.Create;
finalization
              FreeAndNil( jpLabelsDFM);
end.
