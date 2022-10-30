pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with AufgabenDatentypen;
with KampfDatentypen;
with ProduktionDatentypen;

with KIDatentypen;

package EinheitenRecords is
   pragma Pure;

   type RasseEinheitnummerRecord is tagged record
      
      Rasse : RassenDatentypen.Rassen_Enum;
      Nummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;
   
   
   
   type RasseIDRecord is record
      
      Rasse : RassenDatentypen.Rassen_Enum;
      ID : EinheitenDatentypen.EinheitenIDMitNullWert;
      
   end record;
   
   
   
   type ArbeitRecord is tagged record
      
      Aufgabe : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      Arbeitszeit : ProduktionDatentypen.Arbeitszeit;
      
   end record;
   
   
   
   type ArbeitVorleistungRecord is new ArbeitRecord with record
     
      Vorarbeit : Boolean;
   
   end record;
   
   
   
   type KIBewegungPlanArray is array (EinheitenDatentypen.Bewegungsplan'Range) of KartenRecords.AchsenKartenfeldNaturalRecord;
   type TransporterArray is array (EinheitenDatentypen.TransportplätzeVorhanden'Range) of EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   type EinheitMeldungenArray is array (EinheitenDatentypen.Einheit_Meldung_Art_Enum'Range) of EinheitenDatentypen.Einheit_Meldung_Enum;

   type EinheitenGebautRecord is record
      
      ID : EinheitenDatentypen.EinheitenIDMitNullWert;
      KoordinatenAktuell : KartenRecords.AchsenKartenfeldNaturalRecord;
      Heimatstadt : StadtDatentypen.MaximaleStädteMitNullWert;
      
      Lebenspunkte : EinheitenDatentypen.Lebenspunkte;
      Bewegungspunkte : EinheitenDatentypen.VorhandeneBewegungspunkte;
      Erfahrungspunkte : KampfDatentypen.Erfahrungspunkte;
      Rang : KampfDatentypen.Rang;
      
      Beschäftigung : ArbeitRecord;
      BeschäftigungNachfolger : ArbeitRecord;
      
      KIZielKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
      KIBeschäftigt : KIDatentypen.Einheit_Aufgabe_Enum;
      KIZielKoordinatenNachfolger : KartenRecords.AchsenKartenfeldNaturalRecord;
      KIBeschäftigtNachfolger : KIDatentypen.Einheit_Aufgabe_Enum;
      KIVerbesserung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      KIBewegungPlan : KIBewegungPlanArray;
      
      Transportiert : TransporterArray;
      WirdTransportiert : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      
      Meldungen : EinheitMeldungenArray;
      
   end record;
   
   
   
   type MöglicheAuswahlenArray is array (0 .. TransporterArray'Last) of EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   type AuswahlRecord is record
      
      StadtEinheit : Boolean;
      MöglicheAuswahlen : MöglicheAuswahlenArray;
      
   end record;

end EinheitenRecords;
