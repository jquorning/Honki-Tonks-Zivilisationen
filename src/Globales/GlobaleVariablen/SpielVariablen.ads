pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with KartenRecords;
with SpielRecords;
with StadtDatentypen;
with EinheitenDatentypen;
with EinheitenRecords;
with StadtRecords;
with SystemRecords;
with EinheitenRecordKonstanten;
with StadtRecordKonstanten;
with WichtigesRecordKonstanten;

-- Die Zugriffe auf das alles hier auch mal in Funktionen/Prozeduren auslagern? äö
package SpielVariablen is
   
   RassenImSpiel : RassenDatentypen.RassenImSpielArray := (others => RassenDatentypen.Leer_Spieler_Enum);
   
   Debug : SystemRecords.DebugRecord := (others => False);
   
   Allgemeines : SpielRecords.AllgemeinesRecord := WichtigesRecordKonstanten.LeerAllgemeines;
      
   type CursorImSpielArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => WichtigesRecordKonstanten.LeerCursor);
   
   --------------------------------------- Später über Nutzereingaben neu belegbar machen.
   type GrenzenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of SpielRecords.GrenzenRecord;
   Grenzen : GrenzenArray := (others => WichtigesRecordKonstanten.LeerGrenzen);

   type EinheitenGebautArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitenDatentypen.MaximaleEinheiten'Range) of EinheitenRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => EinheitenRecordKonstanten.LeerEinheit));
      
   type StadtGebautArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, StadtDatentypen.MaximaleStädte'Range) of StadtRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => StadtRecordKonstanten.LeerStadt));
      
   type WichtigesArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of SpielRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => WichtigesRecordKonstanten.LeerWichtigesZeug);
   
   type DiplomatieArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, RassenDatentypen.Rassen_Verwendet_Enum'Range) of SpielRecords.DiplomatieRecord;
   Diplomatie : DiplomatieArray := (others => (others => WichtigesRecordKonstanten.LeerDiplomatie));

end SpielVariablen;
