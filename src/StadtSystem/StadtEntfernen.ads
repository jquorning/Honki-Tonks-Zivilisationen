pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package StadtEntfernen is

   procedure StadtEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
private
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;   
   
   procedure BelegteStadtfelderFreigeben
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure HeimatstädteEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

end StadtEntfernen;