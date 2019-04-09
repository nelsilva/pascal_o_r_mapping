unit uAngular_TypeScript_ApplicationHandler;
{                                                                               |
    Author: Jean SUZINEAU <Jean.Suzineau@wanadoo.fr>                            |
            http://www.mars42.com                          |
                                                                                |
    Copyright 2019 Jean SUZINEAU - MARS42                                       |
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
    uuStrings,
    uGenerateur_de_code_Ancetre,
    uBatpro_StringList,
    uContexteClasse,
    uPatternHandler,
    SysUtils, Classes;

type

 { TAngular_TypeScript_ApplicationHandler }

 TAngular_TypeScript_ApplicationHandler
 =
  class
  //Gestion du cycle de vie
  public
    constructor Create( _g: TGenerateur_de_code_Ancetre);
    destructor Destroy; override;
  //Attributs
  private
    g: TGenerateur_de_code_Ancetre;
    APP_ROUTING_MODULE_TS: TPatternHandler;
  public
    sAPP_ROUTING_MODULE_TS_IMPORT_LIST: String;
    sAPP_ROUTING_MODULE_TS_ROUTES: String;
    slParametres: TBatpro_StringList;
    procedure Init;
    procedure Add( _cc: TContexteClasse; IsRelation: Boolean);
    procedure Produit;
  end;

implementation

const
     s_APP_ROUTING_MODULE_TS_IMPORT_LIST_Key= '//APP_ROUTING_MODULE_TS_IMPORT_LIST';
     s_APP_ROUTING_MODULE_TS_ROUTES_Key     = '//APP_ROUTING_MODULE_TS_ROUTES';

{ TAngular_TypeScript_ApplicationHandler }

constructor TAngular_TypeScript_ApplicationHandler.Create( _g: TGenerateur_de_code_Ancetre);
begin
     g:= _g;

     slParametres:= TBatpro_StringList.Create;
     APP_ROUTING_MODULE_TS:=TPatternHandler.Create( g, s_RepertoireAngular_TypeScript+'app-routing.module.ts',slParametres);
     Init;
end;

destructor TAngular_TypeScript_ApplicationHandler.Destroy;
begin
     FreeAndNil( APP_ROUTING_MODULE_TS);
     FreeAndNil( slParametres);
     inherited;
end;

procedure TAngular_TypeScript_ApplicationHandler.Init;
begin
     sAPP_ROUTING_MODULE_TS_IMPORT_LIST:= '';
     sAPP_ROUTING_MODULE_TS_ROUTES     := '';
end;

procedure TAngular_TypeScript_ApplicationHandler.Add( _cc: TContexteClasse; IsRelation: Boolean);
begin
     Formate_Liste
      (
      sAPP_ROUTING_MODULE_TS_IMPORT_LIST,
      #13#10,
      'import { App'+_cc.Nom_de_la_classe+'Component     } from ''./component/app-'+_cc.NomTableMinuscule+'.component'';'
      );
     Formate_Liste
      (
      sAPP_ROUTING_MODULE_TS_ROUTES,
      #13#10'    ',
      '    { path: '''+_cc.NomTableMinuscule+'''   , component: App'+_cc.Nom_de_la_classe+'Component   },'
      );
end;

procedure TAngular_TypeScript_ApplicationHandler.Produit;
begin
     if sAPP_ROUTING_MODULE_TS_IMPORT_LIST <> '' then sAPP_ROUTING_MODULE_TS_IMPORT_LIST:= sAPP_ROUTING_MODULE_TS_IMPORT_LIST+#13#10;
     if sAPP_ROUTING_MODULE_TS_ROUTES      <> '' then sAPP_ROUTING_MODULE_TS_ROUTES     := sAPP_ROUTING_MODULE_TS_ROUTES     +#13#10'    ';

     slParametres.Clear;
     slParametres.Values[s_APP_ROUTING_MODULE_TS_IMPORT_LIST_Key]:= sAPP_ROUTING_MODULE_TS_IMPORT_LIST;
     slParametres.Values[s_APP_ROUTING_MODULE_TS_ROUTES_Key     ]:= sAPP_ROUTING_MODULE_TS_ROUTES     ;

     APP_ROUTING_MODULE_TS.Produit;
end;

end.
