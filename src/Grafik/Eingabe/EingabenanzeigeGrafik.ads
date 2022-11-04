pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with RassenDatentypen;
with ZahlenDatentypen;
with GrafikDatentypen;

private with EinheitenRecords;
private with StadtRecords;
private with GrafikRecordKonstanten;

private with UmwandlungenAdaNachEigenes;

package EingabenanzeigeGrafik is
   pragma Elaborate_Body;
   
   procedure Fragenaufteilung
     (FrageExtern : in ZahlenDatentypen.EigenesPositive;
      EingabeExtern : in GrafikDatentypen.Eingaben_Fragen_Enum);
   
   -- Später KORREKTEN Contract einfügen. äöü
   procedure AnzeigeEinheitenStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AktuelleAuswahlExtern : in Integer);
   
private
   
   AktuelleAuswahl : Integer;
   
   Textbreite : Float;
   
   Text : Unbounded_Wide_Wide_String;
   
   WelcheAuswahl : EinheitenRecords.AuswahlRecord;
   
   StadtRasseNummer : StadtRecords.RasseStadtnummerRecord;
   
   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;

   procedure AnzeigeGanzeZahl;
   procedure AnzeigeText;
   procedure AnzeigeJaNein;
   
   
   
   function ZahlAlsStringNatural is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Natural);

end EingabenanzeigeGrafik;
