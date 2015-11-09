unit uhAUT;
{                                                                               |
    Author: Jean SUZINEAU <Jean.Suzineau@wanadoo.fr>                            |
            http://www.mars42.com                                               |
                                                                                |
    Copyright 2015 Jean SUZINEAU - MARS42                                       |
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

{$mode delphi}

interface

uses
    uClean,
    uuStrings,
    u_sys_,
    uBatpro_StringList,
    uChampDefinition,
    uChampDefinitions,
    uChamp,
    uChamps,
    uTri_Ancetre,
    uhFiltre_Ancetre,

    uBatpro_Ligne,

    uHTTP_Interface,
    uLog,

  Classes, SysUtils, Controls;

type

 { ThAUT }
 // Gestionnaire pour angular-ui-tree
 //https://github.com/angular-ui-tree/angular-ui-tree
 //http://angular-ui-tree.github.io/angular-ui-tree/#/basic-example

 ThAUT
 =
  class
  //Gestion du cycle de vie
  public
    constructor Create( _sl : TBatpro_StringList;
                        _Tri   : TTri_Ancetre     = nil;
                        _Filtre: ThFiltre_Ancetre = nil);
    destructor Destroy; override;
  //Répertoire des fichiers
  public
    Repertoire: String;
  //Génération des modèles
  private
    function HTML_Header: String;
    function HTML_Node  : String;
  //Données au format JSON
  public
    function JSON: String;
  //Réaction au clic sur un titre de colonne
  private
    function Tri_Click( _Reset: Boolean; _NomChamp: String): String;
    function Filtre_Click( _Reset: Boolean; _Champ_Nom, _Champ_Valeur: String): String;
  //Gestion HTTP
  public
    procedure Traite_HTTP;
  //Liste de lignes
  public
    sl: TBatpro_StringList;
  //Gestion du tri
  public
    Tri: TTri_Ancetre;
  //Gestion du filtre
  public
    Filtre: ThFiltre_Ancetre;
  end;

implementation

{ ThAUT }

constructor ThAUT.Create( _sl: TBatpro_StringList;
                          _Tri: TTri_Ancetre;
                          _Filtre: ThFiltre_Ancetre);
begin
     sl    := _sl;
     Tri   := _Tri;
     Filtre:= _Filtre;

     Repertoire
     :=
        IncludeTrailingPathDelimiter( uClean_HTML_Repertoire)
       +ClassName+PathDelim;

     HTTP_Interface.slO.Ajoute( 'AUT/', Self, Traite_HTTP);
end;

destructor ThAUT.Destroy;
begin
     HTTP_Interface.slO.Enleve( 'AUT/');
     inherited Destroy;
end;

function ThAUT.HTML_Header: String;
   function Traite_Liste( _sl: TBatpro_StringList): String;
   var
      bl: TBatpro_Ligne;
      I: TIterateur_Champ;
      c: TChamp;
      cd: TChampDefinition;
      Nom: String;
      sTri: String;
   begin
        Result
        :=
           '<div>'#13#10
          +'  <div class="col-sm-1 text-left">Arbre</div>'#13#10;
        try
           bl:= Batpro_Ligne_from_sl( _sl, 0);
           if nil = bl then exit;

           I:= bl.Champs.sl.Iterateur;
           while I.Continuer
           do
             begin
             if I.not_Suivant( c) then continue;

             cd:= c.Definition;
             Nom:= cd.Nom;

             if Tri = nil
             then
                 sTri:= sys_Vide
             else
                 case Tri.ChampTri[ Nom]
                 of
                   -1:  sTri:= ' \';
                    0:  sTri:= sys_Vide;
                   +1:  sTri:= ' /';
                   else sTri:= sys_Vide;
                   end;

             Result
             :=
                Result
               +'  <div class="col-sm-1 text-left" ng-click="TriClick('''+cd.Nom+''')">'+cd.Libelle + sTri+'</div>'#13#10;
             //vtc.MinWidth:= cd.Longueur*10;
             end;
        finally
               Result
               :=
                  Result
                 +'  <div class="col-sm-1 text-left" ng-click="TriClick(''0'')">Reset Tri</div>'#13#10;
               Result:= Result + '</div>'#13#10;
               end;
   end;
begin
     Result:= Traite_Liste( sl);
end;

function ThAUT.HTML_Node: String;
   function Traite_Liste( _sl: TBatpro_StringList): String;
   var
      bl: TBatpro_Ligne;
      I: TIterateur_Champ;
      c: TChamp;
      cd: TChampDefinition;
      Nom: String;
   begin
        Result
        :=
           '<div ui-tree-handle>                                                                                     '#13#10
          //+'  <div class="col-sm-1 text-left">truc</div>'#13#10
          +'  <a class="btn btn-success col-sm-1" data-nodrag ng-click="toggle(this)">                               '#13#10
          +'     <span class="glyphicon"                                                                             '#13#10
          +'           ng-class="{''glyphicon-chevron-right'': collapsed, ''glyphicon-chevron-down'': !collapsed}">  '#13#10
          +'     </span>                                                                                             '#13#10
          +'  </a>                                                                                                   '#13#10
          ;

        try
           bl:= Batpro_Ligne_from_sl( _sl, 0);
           if nil = bl then exit;

           I:= bl.Champs.sl.Iterateur;
           while I.Continuer
           do
             begin
             if I.not_Suivant( c) then continue;

             cd:= c.Definition;
             Nom:= cd.Nom;

             Result
             :=
                Result
               +'  <div class="col-sm-1 text-left">{{node.'+Nom+'}}</div>'#13#10;
             end;
        finally
               Result
               :=
                  Result
                 +'</div>                                                                           '#13#10
                 +'<ol ui-tree-nodes="options" ng-model="node.Elements" ng-class="{hidden: collapsed}">'#13#10
                 +'  <li ng-repeat="node in node.Elements" ui-tree-node ng-include="''treeNode.html''"></li>'#13#10
                 +'</ol>'#13#10
                 +'<br>'#13#10
                 ;
               end;
   end;
begin
     Result:= Traite_Liste( sl);
end;

function ThAUT.JSON: String;
var
   Batpro_StringList: TBatpro_StringList;
begin
     if Tri.slSousDetails.Count > 0
     then
         Batpro_StringList:= Tri.slSousDetails
     else
         Batpro_StringList:= sl;
     Result:= Batpro_StringList.JSON;
end;

function ThAUT.Tri_Click( _Reset: Boolean; _NomChamp: String): String;
var
   NomChamp: String;
   NewChampTri: Integer;
begin
     if _Reset then Tri.Reset_ChampsTri;

     NomChamp:= _NomChamp;
     case Tri.ChampTri[ NomChamp]
     of
       -1:  NewChampTri:=  0;
        0:  NewChampTri:= +1;
       +1:  NewChampTri:= -1;
       else NewChampTri:=  0;
       end;
     Tri.ChampTri[ NomChamp]:= NewChampTri;
     Tri.Execute_et_Cree_SousDetails( sl);

     Result:= JSON;
end;

function ThAUT.Filtre_Click( _Reset: Boolean; _Champ_Nom, _Champ_Valeur: String): String;
begin
     if _Reset then Filtre.Clear;

     if _Champ_Valeur <> ''
     then
         Filtre.AjouteCritereCONTIENT( _Champ_Nom, _Champ_Valeur);
     Filtre.Execute;
     Tri.Execute_et_Cree_SousDetails( sl);//pas sûr que ce soit nécessaire
     Result:= JSON;
end;

procedure ThAUT.Traite_HTTP;
var
   uri: String;
  procedure Traite_Racine;
  var
     NomFichier: String;
     Extension: String;
     S: String;
  begin
       NomFichier:= Repertoire+SetDirSeparators( 'index.html');
       if FileExists( NomFichier)
       then
           begin
           S:= String_from_File( NomFichier);
           HTTP_Interface.Send_HTML( S);
           Log.PrintLn( 'Envoi racine ');
           end
       else
           begin
           HTTP_Interface.Send_Not_found;
           Log.PrintLn( '#### Fichier non trouvé :'#13#10+uri);
           end;
  end;
  procedure Traite_Tri;
  var
     Reset: Boolean;
     NomChamp: String;
     S: String;
  begin
       Reset:= HTTP_Interface.Prefixe('0');
       NomChamp:= HTTP_Interface.uri;
       S:= Tri_Click( Reset, NomChamp);
       HTTP_Interface.Send_JSON( S);
       Log.PrintLn( 'Tri_Click:'#13#10+S);
  end;
  procedure Traite_Header;
  var
     S: String;
  begin
       S:= HTML_Header;
       HTTP_Interface.Send_HTML( S);
       Log.PrintLn( 'HTML_Header:'#13#10+S);
  end;
  procedure Traite_Node;
  var
     S: String;
  begin
       S:= HTML_Node;
       HTTP_Interface.Send_HTML( S);
       Log.PrintLn( 'Envoi HTML_Node:'#13#10+S);
  end;
  procedure Traite_JSON;
  var
     S: String;
  begin
       S:= JSON;
       HTTP_Interface.Send_JSON( S);
       Log.PrintLn( 'Envoi JSON:'#13#10+S);
  end;
  procedure Traite_Fichier;
  var
     NomFichier: String;
     Extension: String;
     S: String;
  begin
       NomFichier:= Repertoire+SetDirSeparators( uri);
       if FileExists( NomFichier)
       then
           begin
           Log.PrintLn( 'Envoi fichier '#13#10+uri);
           Extension:= LowerCase(ExtractFileExt(uri));
           S:= String_from_File( NomFichier);
           HTTP_Interface.Send_MIME_from_Extension( S, Extension);
           end
       else
           begin
           HTTP_Interface.Send_Not_found;
           Log.PrintLn( '#### Fichier non trouvé :'#13#10+uri);
           end;
  end;
begin
     uri:= HTTP_Interface.uri;
          if '' = uri                                  then Traite_Racine
     else if HTTP_Interface.Prefixe( 'Tri/')            then Traite_Tri
     else if HTTP_Interface.Prefixe( 'AUT.json')       then Traite_JSON
     else if HTTP_Interface.Prefixe( 'treeHeader.html')then Traite_Header
     else if HTTP_Interface.Prefixe( 'treeNode.html')  then Traite_Node
     else                                                   Traite_Fichier;
end;

end.

