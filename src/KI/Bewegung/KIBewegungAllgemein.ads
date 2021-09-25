pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleDatentypen, GlobaleVariablen, KartenRecords;
use GlobaleDatentypen;

with Karten;

package KIBewegungAllgemein is
   
   function FeldBetreten
     (FeldPositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.LoopRangeMinusEinsZuEins
     with
       Pre =>
         (FeldPositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            FeldPositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
private

   BlockierendeEinheit : GlobaleDatentypen.Rassen_Enum;
   BlockierendeStadt : GlobaleDatentypen.Rassen_Enum;
   
   function FeldAngreifen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     return GlobaleDatentypen.LoopRangeMinusEinsZuEins;

end KIBewegungAllgemein;
