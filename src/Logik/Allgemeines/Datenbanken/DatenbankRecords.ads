pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with EinheitStadtDatentypen;
with KartenDatentypen;
with KartengrundDatentypen;
with RassenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with StadtRecords;

package DatenbankRecords is

   -- EinheitenDatenbank
   type PassierbarkeitArray is array (EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum'Range) of Boolean;

   type EinheitenlisteRecord is record
      
      ----------------------- Solche Benennungen auch mal anpassen.
      EinheitArt : EinheitStadtDatentypen.Einheit_Art_Enum;
      PreisGeld : ProduktionDatentypen.KostenLager;
      PreisRessourcen : ProduktionDatentypen.KostenLager;
      PermanenteKosten : StadtRecords.PermanenteKostenArray;
      Anforderungen : ForschungenDatentypen.ForschungIDNichtMöglich;

      Passierbarkeit : PassierbarkeitArray;
      
      MaximaleLebenspunkte : EinheitStadtDatentypen.LebenspunkteVorhanden;
      MaximaleBewegungspunkte : EinheitStadtDatentypen.VorhandeneBewegungspunkte;
      WirdVerbessertZu : EinheitStadtDatentypen.EinheitenIDMitNullWert;

      Beförderungsgrenze : EinheitStadtDatentypen.Kampfwerte;
      MaximalerRang : EinheitStadtDatentypen.Kampfwerte;
      Reichweite : EinheitStadtDatentypen.Kampfwerte;
      Angriff : EinheitStadtDatentypen.Kampfwerte;
      Verteidigung : EinheitStadtDatentypen.Kampfwerte;

      KannTransportieren : EinheitStadtDatentypen.Transport_Enum;
      KannTransportiertWerden : EinheitStadtDatentypen.Transport_Enum;
      Transportkapazität : EinheitStadtDatentypen.Transportplätze;
      
   end record;
   
   type EinheitenlisteArray is array (EinheitStadtDatentypen.EinheitenID'Range) of EinheitenlisteRecord;
   -- EinheitenDatenbank
   
   

   -- ForschungenDatenbank
   type ForschungslisteRecord is record

      PreisForschung : ProduktionDatentypen.KostenLager;
      AnforderungForschung : ForschungenDatentypen.AnforderungForschungArray;

   end record;
   
   type ForschungslisteArray is array (ForschungenDatentypen.ForschungID'Range) of ForschungslisteRecord;
   -- ForschungenDatenbank


   
   -- GebäudeDatenbank
   type BonusWirtschaftArray is array (KartenDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.ProduktionFeld;
   type BonusKampfArray is array (KartenDatentypen.Kampf_Enum'Range) of EinheitStadtDatentypen.Kampfwerte;
   
   type GebäudelisteRecord is record
      
      PreisGeld : ProduktionDatentypen.KostenLager;
      PreisRessourcen : ProduktionDatentypen.KostenLager;
      PermanenteKosten : StadtRecords.PermanenteKostenArray;
      
      Anforderungen : ForschungenDatentypen.ForschungIDNichtMöglich;
      
      BonusWirtschaft : BonusWirtschaftArray;
      BonusKampf : BonusKampfArray;
      
      GrundBenötigt : KartengrundDatentypen.Kartengrund_Enum;
      FlussBenötigt : Boolean;
      RessourceBenötigt : KartengrundDatentypen.Karten_Ressourcen_Enum;
      --------------------- UndOderGrundFlussBenötigt : Boolean; -- In ein Enum einbauen?
      --------------------- Auch noch Abhängigkeit von anderen Gebäuden einbauen.
      
      GebäudeSpezielleEigenschaft : EinheitStadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum;

   end record;
   
   type GebäudelisteArray is array (EinheitStadtDatentypen.GebäudeID'Range) of GebäudelisteRecord;
   -- GebäudeDatenbank



   type BewertungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenDatentypen.BewertungFeld;
   type WirtschaftArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KartenDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.ProduktionElement;
   type KampfArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KartenDatentypen.Kampf_Enum'Range) of EinheitStadtDatentypen.KampfwerteAllgemein;
      
   -- KartenDatenbank
   type KartenlisteRecord is tagged record
            
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
   end record;
   
   type KartengrundlisteRecord is new KartenlisteRecord with record
      
      Passierbarkeit : PassierbarkeitArray;
      
   end record;
   -- KartenDatenbank



   -- VerbesserungenDatenbank
   type VerbesserungenWegeListeRecord is tagged record
      
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
      Passierbarkeit : PassierbarkeitArray;
      
   end record;
   
   -- type VerbesserungenListeRecord is new WegeListeRecord with record
                 
   --    Passierbarkeit : PassierbarkeitArray;
      
   -- end record;
   -- VerbesserungenDatenbank
   
   
   
   -- RassenDatenbank
   type RassenListeRecord is record
      
      Aggressivität : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Expansion : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Wissenschaft : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Produktion : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Wirtschaft : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Bewirtschaftung : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
      GültigeStaatsformen : SystemDatentypen.StaatsformenArray;
      -- Besondere Eigenschaften hinzufügen, als Enum? oder was Anderes?
      
   end record;
   -- RassenDatenbank
   
end DatenbankRecords;
