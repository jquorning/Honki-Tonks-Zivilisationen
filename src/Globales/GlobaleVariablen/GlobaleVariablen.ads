pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with EinheitStadtRecords;
with SystemRecords;
with KartenRecords;
with WichtigeRecords;
with WichtigesKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with EinheitStadtDatentypen;
with GrafikTonDatentypen;
with TextKonstanten;

package GlobaleVariablen is

   -- Schreiben/Ausgabe
   -- Die einzelnen Textarrays hier rein oder in eine eigene Datei?
   type NutzerEinstellungenArray is array (1 .. 3) of Unbounded_Wide_Wide_String;
   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord := (
                                                                     -- Sprache
                                                                     TextKonstanten.LeerUnboundedString,
                                                                     -- Anzahl Autosaves
                                                                     10,
                                                                     -- Rundenanzahl bis Autosave
                                                                     10
                                                                    );
   
   AnzeigeArt : GrafikTonDatentypen.Anzeige_Art_Enum := GrafikTonDatentypen.Grafik_SFML_Enum;
   -- Schreiben/Ausgabe
   
   
   
   -- Schlechte Lösung für die Umbelegung der Steuerung
   UmbelegungNummer : Positive;
   -- Schlechte Lösung für die Umbelegung der Steuerung
   
   

   -- Cursor
   type CursorImSpielArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of KartenRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => WichtigesKonstanten.LeerCursor);
   -- Cursor
   
   

   -- Zeug
   Debug : Boolean := True;
   
   RundenAnzahl : Positive := Positive'First;
   Rundengrenze : Natural := Natural'First;

   -- Nicht belegt, Menschlicher Spieler, KI
   RassenImSpiel : SystemDatentypen.RassenImSpielArray := (others => SystemDatentypen.Leer_Spieler_Enum);
   RasseAmZugNachLaden : SystemDatentypen.Rassen_Enum := EinheitenKonstanten.LeerRasse;

   Schwierigkeitsgrad : SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum := SystemDatentypen.Schwierigkeit_Mittel_Enum;
   Gewonnen : Boolean := False;
   WeiterSpielen : Boolean := False;
   
   -- Später über Nutzereingaben neu belegbar machen.
   type GrenzenArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.GrenzenRecord;
   Grenzen : GrenzenArray := (others => WichtigesKonstanten.LeerGrenzen);
   
   IronmanName : Unbounded_Wide_Wide_String := TextKonstanten.LeerUnboundedString;
   -- Zeug
   

   
   -- Einheiten
   type EinheitenGebautArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.MaximaleEinheiten'Range) of EinheitStadtRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => EinheitenKonstanten.LeerEinheit));
   -- Einheiten
   
   

   -- Städte
   type StadtGebautArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.MaximaleStädte'Range) of EinheitStadtRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => StadtKonstanten.LeerStadt));
   -- Städte
   
   

   -- Wichtiges Zeug
   type WichtigesArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => WichtigesKonstanten.LeerWichtigesZeug);
   
   type DiplomatieArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.DiplomatieRecord;
   Diplomatie : DiplomatieArray := (others => (others => WichtigesKonstanten.LeerDiplomatie));
   -- Wichtiges Zeug
                                               
end GlobaleVariablen;
