pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with KartenRecords;
private with KartengrundDatentypen;
private with KartenVerbesserungDatentypen;
private with TextaccessVariablen;

package KarteAllgemeinesSFML is

   function AllgemeineInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 TextpositionExtern.x > 0.00
               and
                 TextpositionExtern.y > 0.00
              ),
   
       Post => (
                  AllgemeineInformationen'Result.x > 0.00
                and
                  AllgemeineInformationen'Result.y > 0.00
               );
   
private
   
   KartenFluss : KartengrundDatentypen.Kartenfluss_Enum;
   
   KartenRessource : KartengrundDatentypen.Kartenressourcen_Enum;

   KartenVerbesserung : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
   KartenWeg : KartenVerbesserungDatentypen.Karten_Weg_Enum;
   
   Zeilenabstand : Float;
   
   VorhandenerGrund : KartenRecords.KartengrundRecord;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type TextAnzeigenArray is array (TextaccessVariablen.KarteAllgemeinesAccessArray'Range) of Boolean;
   TextAnzeigen : TextAnzeigenArray;
   
end KarteAllgemeinesSFML;
