pragma SPARK_Mode (On);

with GlobaleDatentypen, DatenbankRecords, GlobaleVariablen;
use GlobaleDatentypen;

package ForschungsDatenbank is

   -- Hier noch hinschreiben welcher Wert was ist!
   LeererWertForschungListe : constant DatenbankRecords.ForschungListeRecord := (0, (others => 0)); -- 1. Wert = PreisForschung, 2. Wert = AnforderungForschung

   type ForschungListeArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.ForschungID'Range) of DatenbankRecords.ForschungListeRecord;
   ForschungListe : ForschungListeArray := (others => (1 => (100, (others => 0)),
                                                       2 => (100, (others => 0)),
                                                       3 => (100, (others => 0)),

                                                       4 => (250, (1, 2, 0, 0)),
                                                       5 => (250, (2, 3, 0, 0)),
                                                       6 => (250, (4, 0, 0, 0)),

                                                       others => LeererWertForschungListe));

   type RassenAufschlagArray is array (GlobaleDatentypen.Rassen'Range) of Natural;
   RassenAufschlagForschung : constant RassenAufschlagArray := (1 => 0,
                                                                2 => 0,
                                                                3 => 0,
                                                                4 => 0,
                                                                5 => 0,
                                                                6 => 0,
                                                                7 => 0,
                                                                8 => 0,
                                                                9 => 0,
                                                                10 => 0,
                                                                11 => 0,
                                                                12 => 0,
                                                                13 => 0,
                                                                14 => 0,
                                                                15 => 0,
                                                                16 => 0,
                                                                17 => 0,
                                                                18 => 0);

   procedure Beschreibung (IDExtern : in GlobaleDatentypen.ForschungIDMitNullWert);
   procedure Forschung (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   procedure ForschungFortschritt;
   procedure ForschungZeit (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

private

   AnforderungenErfüllt : Boolean;

   Taste : Wide_Wide_Character;

   WasErforschtWerdenSoll : GlobaleDatentypen.ForschungIDMitNullWert;

   AktuelleAuswahl : GlobaleDatentypen.KartenverbesserungEinheitenID;
   Ende : GlobaleDatentypen.ForschungID;

   function AuswahlForschungNeu (RasseExtern : in GlobaleDatentypen.Rassen) return GlobaleDatentypen.ForschungIDMitNullWert with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

end ForschungsDatenbank;
