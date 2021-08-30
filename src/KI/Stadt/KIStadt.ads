pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

with KIRecords;

package KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

private

   ProduktionÄndernNotwendig : Boolean;
   FeindNahe : Boolean;

   NotfallEinheit : GlobaleDatentypen.EinheitenIDMitNullWert;

   FremdeEinheit : GlobaleRecords.RassePlatznummerRecord;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

   procedure NeuesBauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitBauenExtern : in KIRecords.EinheitIDBewertungRecord;
      GebäudeBauenExtern : in KIRecords.GebäudeIDBewertungRecord;
      NotfallExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

   procedure NotfallEinheitBauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitIDExtern : in GlobaleDatentypen.EinheitenID)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);



   function GefahrStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

end KIStadt;
