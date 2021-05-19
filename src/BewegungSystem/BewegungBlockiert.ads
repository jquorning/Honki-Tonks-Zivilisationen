pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen, GlobaleKonstanten;
use GlobaleDatentypen;

with Karten;

package BewegungBlockiert with
Abstract_State => Test
is

   function BlockiertStadtEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Bewegung_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0),
         Post =>
           (BlockiertStadtEinheit'Result = GlobaleDatentypen.Gegner_Blockiert
            or
              BlockiertStadtEinheit'Result = GlobaleDatentypen.Keine_Bewegung_Möglich
            or
              BlockiertStadtEinheit'Result = GlobaleDatentypen.Normale_Bewegung_Möglich),
     Global =>
       (Input => (GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch)),
       Depends =>
         (BlockiertStadtEinheit'Result => (EinheitRasseNummerExtern, NeuePositionExtern),
          null => (GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch));

private

   StadtWert : GlobaleRecords.RassePlatznummerRecord with Part_Of => Test;
   EinheitWert : GlobaleRecords.RassePlatznummerRecord with Part_Of => Test;

end BewegungBlockiert;
