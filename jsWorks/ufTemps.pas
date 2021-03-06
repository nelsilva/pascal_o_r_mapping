unit ufTemps;

{$mode delphi}

interface

uses
    uClean,
    ucDockableScrollbox,

    ublTag,
    upoolTag,
    udkTag_LABEL_od,

    uodWork_from_Period,

    ublCalendrier,
    uodSession,
    ublSession,
    uhdmSession,
    udkSession, uodCalendrier,
 Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
 StdCtrls, Buttons, ExtCtrls,LCLIntf, dateutils,Clipbrd;

type

 { TfTemps }

 TfTemps
 =
 class(TForm)
  b0_Now: TButton;
  bodCalendrier_Modele: TButton;
  bOK: TBitBtn;
  bSession: TButton;
  bTo_log: TButton;
  bodSession: TButton;
  bodCalendrier: TButton;
  bCurrentWeek: TButton;
  bCurrentMonth: TButton;
  bPreviousWeek: TButton;
  bPreviousMonth: TButton;
  bNextMonth: TButton;
  bNextWeek: TButton;
  bodSession_Modele: TButton;
  cbRestreindre_a_un_Tag: TCheckBox;
  cbEcrire_arrondi: TCheckBox;
  cbHeures_Supplementaires: TCheckBox;
  deDebut: TDateEdit;
  deFin: TDateEdit;
  ds: TDockableScrollbox;
  dsbTag: TDockableScrollbox;
  Label1: TLabel;
  Label2: TLabel;
  Label3: TLabel;
  Label4: TLabel;
  mResume: TMemo;
  Panel1: TPanel;
  Splitter1: TSplitter;
  procedure b0_NowClick(Sender: TObject);
  procedure bCurrentMonthClick(Sender: TObject);
  procedure bNextMonthClick(Sender: TObject);
  procedure bNextWeekClick(Sender: TObject);
  procedure bodCalendrierClick(Sender: TObject);
  procedure bodCalendrier_ModeleClick(Sender: TObject);
  procedure bodSessionClick(Sender: TObject);
  procedure bodSession_ModeleClick(Sender: TObject);
  procedure bOKClick(Sender: TObject);
  procedure bCurrentWeekClick(Sender: TObject);
  procedure bPreviousMonthClick(Sender: TObject);
  procedure bPreviousWeekClick(Sender: TObject);
  procedure bSessionClick(Sender: TObject);
  procedure bTo_logClick(Sender: TObject);
  procedure cbEcrire_arrondiChange(Sender: TObject);
  procedure cbHeures_SupplementairesChange(Sender: TObject);
  procedure cbRestreindre_a_un_TagClick(Sender: TObject);
  procedure dsClick(Sender: TObject);
  procedure FormCreate(Sender: TObject);
  procedure FormDestroy(Sender: TObject);
  procedure mResumeEnter(Sender: TObject);
 private
   function idTag: Integer;
 public
   hdmSession: ThdmSession;
 //Gestion bornes période
 private
   procedure Semaine( _D: TDateTime; _Delta: Integer=0);
   procedure Mois   ( _D: TDateTime; _Delta: Integer=0);

 end;

function fTemps: TfTemps;

implementation

{$R *.lfm}

{ TfTemps }

var
   FfTemps: TfTemps= nil;

function fTemps: TfTemps;
begin
     Clean_Get( Result, FfTemps, TfTemps);
end;

procedure TfTemps.FormCreate(Sender: TObject);
begin
     deDebut.Date:= Date;
     deFin  .Date:= deDebut.Date;

     ds.Classe_dockable:= TdkSession;
     ds.Classe_Elements:= TblSession;

     dsbTag.Classe_dockable:= TdkTag_LABEL_od;
     dsbTag.Classe_Elements:= TblTag;

     hdmSession:= ThdmSession.Create;
     cbEcrire_arrondi.Checked:= ublSession_Ecrire_arrondi;
     cbHeures_Supplementaires.Checked:= ublCalendrier_Heures_Supplementaires;
end;

procedure TfTemps.FormDestroy(Sender: TObject);
begin
     Free_nil( hdmSession);
end;

procedure TfTemps.mResumeEnter(Sender: TObject);
begin
     Clipboard.AsText:= mResume.Text;
end;

function TfTemps.idTag: Integer;
var
   blTag: TblTag;
begin
     Result:= 0;

     if not cbRestreindre_a_un_Tag.Checked then exit;

     dsbTag.Get_bl( blTag);
     if nil = blTag then exit;

     Result:= blTag.id;
end;

procedure TfTemps.bOKClick(Sender: TObject);
var
   Resultat: String;
begin
     odWork_from_Period.Init( deDebut.Date, deFin.Date, idTag);
     Resultat:= odWork_from_Period.Visualiser;
     if not OpenDocument( Resultat)
     then
         ShowMessage( 'OpenDocument failed on '+Resultat);
end;

procedure TfTemps.Semaine(_D: TDateTime; _Delta: Integer);
begin
          if _Delta < 0 then _D:= StartOfTheWeek( _D)-1
     else if _Delta > 0 then _D:=   EndOfTheWeek( _D)+1;

     deDebut.Date:= StartOfTheWeek( _D);
     deFin  .Date:=   EndOfTheWeek( _D);
end;

procedure TfTemps.Mois(_D: TDateTime; _Delta: Integer);
begin
          if _Delta < 0 then _D:= StartOfTheMonth( _D)-1
     else if _Delta > 0 then _D:=   EndOfTheMonth( _D)+1;

     deDebut.Date:= StartOfTheMonth( _D);
     deFin  .Date:=   EndOfTheMonth( _D);
end;

procedure TfTemps.bCurrentWeekClick(Sender: TObject);
begin
     Semaine( Now);
end;

procedure TfTemps.bPreviousWeekClick(Sender: TObject);
begin
     Semaine( deDebut.Date, -1);
end;

procedure TfTemps.bNextWeekClick(Sender: TObject);
begin
     Semaine( deDebut.Date, +1);
end;

procedure TfTemps.bCurrentMonthClick(Sender: TObject);
begin
     Mois( Now);
end;

procedure TfTemps.bPreviousMonthClick(Sender: TObject);
begin
     Mois( deDebut.Date, -1);
end;

procedure TfTemps.bNextMonthClick(Sender: TObject);
begin
     Mois( deDebut.Date, +1);
end;

procedure TfTemps.bSessionClick(Sender: TObject);
begin
     ds.sl:= nil;
     hdmSession.Execute( deDebut.Date, deFin.Date, idTag);
     ds.sl:= hdmSession.sl;
     mResume.Text:= hdmSession.Text;
end;

procedure TfTemps.bTo_logClick(Sender: TObject);
begin
     hdmSession.To_log;
end;

procedure TfTemps.cbEcrire_arrondiChange(Sender: TObject);
begin
     ublSession_Ecrire_arrondi:= cbEcrire_arrondi.Checked;
end;

procedure TfTemps.cbHeures_SupplementairesChange(Sender: TObject);
begin
     ublCalendrier_Heures_Supplementaires:= cbHeures_Supplementaires.Checked;
end;

procedure TfTemps.cbRestreindre_a_un_TagClick(Sender: TObject);
begin
     if not cbRestreindre_a_un_Tag.Checked then exit;

     poolTag.ToutCharger;
     poolTag.TrierFiltre;
     dsbTag.sl:= poolTag.slFiltre;
end;

procedure TfTemps.dsClick(Sender: TObject);
begin

end;

procedure TfTemps.b0_NowClick(Sender: TObject);
var
   Resultat: String;
begin
     odWork_from_Period.Init( 0, Now, idTag);
     Resultat:= odWork_from_Period.Visualiser;
     if not OpenDocument( Resultat)
     then
         ShowMessage( 'OpenDocument failed on '+Resultat);
end;

procedure TfTemps.bodCalendrierClick(Sender: TObject);
var
   od: TodCalendrier;
   Resultat: String;
begin
     od:= TodCalendrier.Create;
     try
        od.Init( hdmSession.hdmCalendrier);
        Resultat:= od.Visualiser;
        if not OpenDocument( Resultat)
        then
            ShowMessage( 'OpenDocument failed on '+Resultat);
     finally
            FreeAndNil( od);
            end;
end;

procedure TfTemps.bodCalendrier_ModeleClick(Sender: TObject);
var
   od: TodCalendrier;
   Resultat: String;
begin
     od:= TodCalendrier.Create;
     try
        od.Init( hdmSession.hdmCalendrier);
        Resultat:= od.Editer_Modele_Impression;
        if not OpenDocument( Resultat)
        then
            ShowMessage( 'OpenDocument failed on '+Resultat);
     finally
            FreeAndNil( od);
            end;
end;

procedure TfTemps.bodSessionClick(Sender: TObject);
var
   odSession: TodSession;
   Resultat: String;
begin
     odSession:= TodSession.Create;
     try
        odSession.Init( hdmSession);
        Resultat:= odSession.Visualiser;
     finally
            FreeAndNil( odSession);
            end;
     if not OpenDocument( Resultat)
     then
         ShowMessage( 'OpenDocument failed on '+Resultat);
end;

procedure TfTemps.bodSession_ModeleClick(Sender: TObject);
var
   odSession: TodSession;
   Resultat: String;
begin
     odSession:= TodSession.Create;
     try
        odSession.Init( hdmSession);
        Resultat:= odSession.Editer_Modele_Impression;
     finally
            FreeAndNil( odSession);
            end;
     if not OpenDocument( Resultat)
     then
         ShowMessage( 'OpenDocument failed on '+Resultat);
end;

initialization
finalization
            Clean_Destroy( FfTemps);
end.

