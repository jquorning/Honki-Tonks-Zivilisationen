pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package EinheitVerschieben is

   procedure VonEigenemLandWerfen
     (RasseExtern, KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure EinheitVerschieben
     (RasseLandExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
private
   
   UmgebungPrüfen : GlobaleDatentypen.Sichtweite;
   BereitsGeprüft : GlobaleDatentypen.SichtweiteMitNullwert;
   
   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWertVerschieben : GlobaleRecords.AchsenKartenfeldPositivRecord;

end EinheitVerschieben;