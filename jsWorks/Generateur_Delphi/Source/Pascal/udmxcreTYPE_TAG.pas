unit udmxcreTYPE_TAG;
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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB,

  udmBatpro_DataModule,
  udmxCreator,  FMTBcd, SqlExpr;

type
 TdmxcreTYPE_TAG
 =
  class(TdmxCreator)
    sqlq: TSQLQuery;
  private
    function Traite_Index( NomChamp: String): Boolean;
  public
    { Déclarations publiques }
    function Ouverture(Edition: Boolean): Boolean; override;
  end;

function dmxcreTYPE_TAG: TdmxcreTYPE_TAG;

implementation

uses
    uClean,
    udmDatabase;

{$R *.dfm}

var
   FdmxcreTYPE_TAG: TdmxcreTYPE_TAG;

function dmxcreTYPE_TAG: TdmxcreTYPE_TAG;
begin
     Clean_Get( Result, FdmxcreTYPE_TAG, TdmxcreTYPE_TAG);
end;

{ TdmxcreTYPE_TAG }

function TdmxcreTYPE_TAG.Ouverture(Edition: Boolean): Boolean;
begin
     Result:= Traite_Table( '', 'Type_Tag', sqlq, sqlq);

end;

function TdmxcreTYPE_TAG.Traite_Index(NomChamp: String): Boolean;
begin
     //inutile pour l'instant
     Result:= True;
end;

initialization
              Clean_Create ( FdmxcreTYPE_TAG, TdmxcreTYPE_TAG);
finalization
              Clean_Destroy( FdmxcreTYPE_TAG);
end.

