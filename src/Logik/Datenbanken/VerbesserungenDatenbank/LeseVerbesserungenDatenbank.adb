pragma SPARK_Mode (On);

with VerbesserungenDatenbank;

package body LeseVerbesserungenDatenbank is

   function VerbesserungGrafik
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
      return Wide_Wide_Character
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).VerbesserungGrafik;
      
   end VerbesserungGrafik;
   
   
   
   function Passierbarkeit
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
   
   function Bewertung
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).Bewertung (RasseExtern);
      
   end Bewertung;
   
      
   
   function Wirtschaft
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).Wirtschaft (RasseExtern, WelcherWertExtern);
      
   end Wirtschaft;
   
      
   
   function Kampf
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).Kampf (RasseExtern, WelcherWertExtern);
      
   end Kampf;
   
   
   
   function GanzerEintrag
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
      return DatenbankRecords.VerbesserungListeRecord
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern);
      
   end GanzerEintrag;

end LeseVerbesserungenDatenbank;