pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenRecords;

with KIDatentypen;

with Karten;

package KIBewegungAllgemein is
   
   function FeldBetreten
     (FeldKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KIDatentypen.Bewegung_Enum
     with
       Pre =>
         (FeldKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            FeldKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
private

   BlockierendeEinheit : RassenDatentypen.Rassen_Enum;
   BlockierendeStadt : RassenDatentypen.Rassen_Enum;
   
   function FeldAngreifen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     return KIDatentypen.Bewegung_Enum;

end KIBewegungAllgemein;
