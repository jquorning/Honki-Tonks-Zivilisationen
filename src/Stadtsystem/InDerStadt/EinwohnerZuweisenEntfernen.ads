pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleVariablen, SonstigeDatentypen, KartenRecords, KartenDatentypen;
use SonstigeDatentypen;

package EinwohnerZuweisenEntfernen is

   procedure EinwohnerZuweisenEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch);
   
private
   
   NutzbarerBereich : KartenDatentypen.Kartenfeld;
   RelativeCursorPositionY : KartenDatentypen.Kartenfeld;
   RelativeCursorPositionX : KartenDatentypen.Kartenfeld;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure EinwohnerBelegungÄndern
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure EinwohnerEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure EinwohnerZuweisen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end EinwohnerZuweisenEntfernen;
