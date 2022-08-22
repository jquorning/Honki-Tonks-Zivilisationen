pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with KartenRecords;
private with KartengrundDatentypen;
private with KartenVerbesserungDatentypen;
private with TextaccessVariablen;
private with TextKonstanten;

package KarteAllgemeinesSFML is
   
   procedure Leer;

   procedure AllgemeineInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   KartenFluss : KartengrundDatentypen.Kartenfluss_Enum;
   
   KartenRessource : KartengrundDatentypen.Kartenressourcen_Enum;

   KartenVerbesserung : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
   KartenWeg : KartenVerbesserungDatentypen.Karten_Weg_Enum;
   
   Textbreite : Float;
   RealeYPosition : Float;
   
   VorhandenerGrund : KartenRecords.KartengrundRecord;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := TextKonstanten.StartpositionText;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type TextAnzeigenArray is array (TextaccessVariablen.KarteAllgemeinesAccessArray'Range) of Boolean;
   TextAnzeigen : TextAnzeigenArray;
   
end KarteAllgemeinesSFML;
