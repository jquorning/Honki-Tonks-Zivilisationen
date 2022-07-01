pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;
private with Sf.Graphics;
private with Sf.Graphics.RectangleShape;
private with Sf.Graphics.Rect;
private with Sf.Graphics.View;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with EinheitenRecords;
private with KartenDatentypen;
private with KartenRecords;
private with KartenRecordKonstanten;
private with ProduktionDatentypen;
private with StadtRecords;

private with UmwandlungenAdaNachEigenes;

package KarteInformationenSFML is

   procedure KarteInformationenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;

   StadtRasseNummer : StadtRecords.RasseStadtnummerRecord;

   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;

   Zeilenabstand : Float;

   WertOhneTrennzeichen : Unbounded_Wide_Wide_String;
   YAchsenWert : Unbounded_Wide_Wide_String;
   XAchsenWert : Unbounded_Wide_Wide_String;

   LetzteKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord := KartenRecordKonstanten.LeerKoordinate;
   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

   StartpunktText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);

   FensterInformationen : Sf.System.Vector2.sfVector2f;
   ZeichenPosition : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;

   RechteckAcces : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   InformationenViewGröße : Sf.Graphics.Rect.sfFloatRect;

   InformationenViewAcces : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.createFromRect (rectangle => InformationenViewGröße);

   procedure StadtInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure EinheitInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure DebugInformationen;



   function ZahlAlsStringInteger is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Integer);

   function ZahlAlsStringKostenLager is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.Produktion);

   function ZahlAlsStringEbeneVorhanden is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.EbeneVorhanden);

   function ZahlAlsStringKartenfeldPositivMitNullwert is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.KartenfeldNatural);

end KarteInformationenSFML;
