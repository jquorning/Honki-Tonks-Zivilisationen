pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with GlobaleVariablen;
with KartenRecords;

with Karten;

package BewegungLadenEntladen is

   procedure TransporterBeladen
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in EinheitStadtDatentypen.MaximaleEinheiten)
     with
       Pre =>
         (TransporterExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure EinheitAusTransporterEntfernen
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in EinheitStadtDatentypen.MaximaleEinheiten)
     with
       Pre =>
         (TransporterExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure TransporterladungVerschieben
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            NeueKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            NeueKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);
   
   procedure TransporterStadtEntladen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            NeueKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            NeueKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);
   
private
   
   TransporterNummer : EinheitStadtDatentypen.MaximaleEinheiten;
   
   EinheitAusladen : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   FreierPlatzNummer : EinheitStadtDatentypen.Transportwerte;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   function FreienPlatzErmitteln
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Transportwerte
     with
       Pre =>
         (TransporterExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

end BewegungLadenEntladen;
