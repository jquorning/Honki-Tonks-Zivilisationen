pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);
   
private
   
   FeldPassierbar : Boolean;
   ZwischenWert : Boolean;
   
   EinheitAufFeld : GlobaleRecords.RassePlatznummerRecord;
   
   Änderung : GlobaleRecords.AchsenKartenfeldRecord;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   type Bewegung_Noch_Möglich_Enum is (Zurück, Bewegbar);
   AktuellerStatus : Bewegung_Noch_Möglich_Enum;
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Bewegung_Noch_Möglich_Enum
     with
       Pre =>
         (NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function FremderAufFeld
     (EinheitRasseNummerExtern, FremdeEinheitExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean;
     
   function EigeneEinheitAufFeld
     (EinheitRasseNummerExtern, EigeneEinheitExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean;

end BewegungssystemEinheiten;
