pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with VerbesserungenDatenbank;

package body LeseVerbesserungenDatenbank is

   function PassierbarkeitVerbesserung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return VerbesserungenDatenbank.VerbesserungenListe (VerbesserungExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end PassierbarkeitVerbesserung;
   
   

   function PassierbarkeitWeg
     (WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return VerbesserungenDatenbank.WegeListe (WegExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end PassierbarkeitWeg;
   
   
   
   function BewertungVerbesserung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungenListe (VerbesserungExtern).Bewertung (RasseExtern);
      
   end BewertungVerbesserung;
   
   
   
   function BewertungWeg
     (WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return VerbesserungenDatenbank.WegeListe (WegExtern).Bewertung (RasseExtern);
      
   end BewertungWeg;
   
      
   
   function WirtschaftVerbesserung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return VerbesserungenDatenbank.VerbesserungenListe (VerbesserungExtern).Wirtschaft (RasseExtern, WelcherWertExtern);
      
   end WirtschaftVerbesserung;
   
      
   
   function WirtschaftWeg
     (WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return VerbesserungenDatenbank.WegeListe (WegExtern).Wirtschaft (RasseExtern, WelcherWertExtern);
      
   end WirtschaftWeg;
   
      
   
   function KampfVerbesserung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
   is begin
      
      return VerbesserungenDatenbank.VerbesserungenListe (VerbesserungExtern).Kampf (RasseExtern, WelcherWertExtern);
      
   end KampfVerbesserung;
   
      
   
   function KampfWeg
     (WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
   is begin
      
      return VerbesserungenDatenbank.WegeListe (WegExtern).Kampf (RasseExtern, WelcherWertExtern);
      
   end KampfWeg;
   
   
   
   function GanzerEintragVerbesserung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum)
      return DatenbankRecords.VerbesserungenWegeListeRecord
   is begin
      
      return VerbesserungenDatenbank.VerbesserungenListe (VerbesserungExtern);
      
   end GanzerEintragVerbesserung;
   
   
   
   function GanzerEintragWeg
     (WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum)
      return DatenbankRecords.VerbesserungenWegeListeRecord
   is begin
      
      return VerbesserungenDatenbank.WegeListe (WegExtern);
      
   end GanzerEintragWeg;

end LeseVerbesserungenDatenbank;