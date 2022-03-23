pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with KartenDatentypen;
with EinheitStadtDatentypen;
with KartenVerbesserungDatentypen;

with DatenbankRecords;

package LeseVerbesserungenDatenbank is

   function PassierbarkeitVerbesserung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean;
   
   function PassierbarkeitWeg
     (WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean;
   
   function BewertungVerbesserung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function BewertungWeg
     (WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function WirtschaftVerbesserung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function WirtschaftWeg
     (WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function KampfVerbesserung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function KampfWeg
     (WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
   function GanzerEintragVerbesserung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum)
      return DatenbankRecords.VerbesserungenWegeListeRecord;
   
   function GanzerEintragWeg
     (WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum)
      return DatenbankRecords.VerbesserungenWegeListeRecord;

end LeseVerbesserungenDatenbank;
