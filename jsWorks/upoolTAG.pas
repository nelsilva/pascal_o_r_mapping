unit upoolTAG;
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
  uClean,
  uBatpro_StringList,
{implementation_uses_key}

  ublTAG,

  udmDatabase,
  udmBatpro_DataModule,
  uPool,
  

  uhfTAG,
  SysUtils, Classes, DB, SqlDB;

type

 { TpoolTAG }

 TpoolTAG
 =
  class( TPool)
    procedure DataModuleCreate(Sender: TObject);
  //Filtre
  public
    hfTAG: ThfTAG;
  //Acc�s g�n�ral
  public
    idType: Integer;
    Name: String;
    function Get( _id: integer): TblTAG;
    function Get_by_Cle( _idType: Integer;  _Name: String): TblTAG;
    function Assure( _idType: Integer; _Name: String): TblTAG;
  //M�thode de cr�ation de test
  public
    function Test( _id: Integer;  _Name: String;  _idType: Integer):Integer;
  //Chargement des tags d'un Work
  public
    procedure Charge_Work( _idWork: Integer; _slLoaded: TBatpro_StringList);
  end;

function poolTAG: TpoolTAG;

implementation

{$R *.dfm}

var
   FpoolTAG: TpoolTAG;

function poolTAG: TpoolTAG;
begin
     Clean_Get( Result, FpoolTAG, TpoolTAG);
end;

{ TpoolTAG }

procedure TpoolTAG.DataModuleCreate(Sender: TObject);
begin
     NomTable:= 'Tag';
     Classe_Elements:= TblTAG;
     Classe_Filtre:= ThfTAG;

     inherited;

     hfTAG:= hf as ThfTAG;
end;

function TpoolTAG.Get( _id: integer): TblTAG;
begin
     Get_Interne_from_id( _id, Result);
end;

function TpoolTAG.Get_by_Cle( _idType: Integer;  _Name: String): TblTAG;
begin
     idType:=  _idType;
     Name:=  _Name;
     sCle:= TblTAG.sCle_from_( idType, Name);
     Get_Interne( Result);
end;

function TpoolTAG.Assure( _idType: Integer; _Name: String): TblTAG;
begin
     try
        Creer_si_non_trouve:= True;
        Result:= Get_by_Cle( _idType, _Name);
     finally
            Creer_si_non_trouve:= False;
            end;
end;

function TpoolTAG.Test( _id: Integer;  _Name: String;  _idType: Integer):Integer;
var                                                 
   bl: TblTAG;                          
begin                                               
          Nouveau_Base( bl);                        
       bl.id             := _id           ;
       bl.Name           := _Name         ;
       bl.idType         := _idType       ;
     bl.Save_to_database;                            
     Result:= bl.id;                                 
end;

procedure TpoolTAG.Charge_Work( _idWork: Integer; _slLoaded: TBatpro_StringList);
var
   SQL: String;
begin
     SQL
     :=
 'select                                          '#13#10
+'      Tag.*                                     '#13#10
+'from                                            '#13#10
+'    Tag                                         '#13#10
+'right join Tag_Work                             '#13#10
+'on                                              '#13#10
+'      (Tag_Work.idTag  = Tag.id               ) '#13#10
+'  and (Tag_Work.idWork = '+IntToStr(_idWork)+') '#13#10
+'where                                           '#13#10
+'         Tag.id is not null                     '#13#10
+'     and Tag_Work.id is not null                '#13#10;
     Load( SQL, _slLoaded);
end;


initialization
              Clean_Create ( FpoolTAG, TpoolTAG);
finalization
              Clean_destroy( FpoolTAG);
end.
