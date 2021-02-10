pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen, GlobaleRecords;

package Karte is

   procedure AnzeigeKarte (RasseExtern : in GlobaleDatentypen.Rassen);

private

   StehtDrauf : Boolean;

   -- MöglicheAngriffsfelder : constant Wide_Wide_Character := '■'; -- Später für Fernkampfeinheiten wieder einbauen?
   Verteidigungsbonus : GlobaleDatentypen.GrundwerteNRGWVA;
   Nahrungsgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Ressourcengewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Geldgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Wissensgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   SichtweiteFestlegen : Integer;
   BewegungsfeldFestlegen : Integer;

   Kartenwert : GlobaleRecords.AchsenAusKartenfeldRecord;

   RasseUndPlatznummer : GlobaleRecords.RasseUndPlatznummerRecord;

   type SichtweiteArray is array (1 .. 3) of GlobaleRecords.AchsenAusKartenfeldPositivRecord;

   Sichtweite : constant SichtweiteArray := (1 => (0, 6, 10), -- Hier noch was für die Sichtweite einfügen, vor allem in den Himmel. Eventuell auch von der Technologie abhängig machen.
                                             2 => (0, 6, 22),
                                             3 => (0, 6, 35));

   Bewegungsfeld : constant SichtweiteArray := (1 => (0, 5, 9), -- Hier noch was für die Bewegung einfügen und von der Technologie abhängig machen.
                                                2 => (0, 5, 21),
                                                3 => (0, 5, 34));

   procedure Information (RasseExtern : in GlobaleDatentypen.Rassen);

end Karte;
