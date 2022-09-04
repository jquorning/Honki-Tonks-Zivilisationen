pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartenRecordKonstanten;
with KartengeneratorRecordKonstanten;

package KartengeneratorVariablen is

   -- Alle Einstellungen in die Parameter schieben oder thematische Gruppen bilden? äöü
   Kartenparameter : KartenRecords.TemporäreKartenparameterRecord := KartenRecordKonstanten.Standardkartengeneratorparameter;

   Polgrößen : KartenDatentypen.PolregionenArray := KartengeneratorRecordKonstanten.Eisrand;
   Eisschild : KartenDatentypen.PolregionenArray := KartengeneratorRecordKonstanten.Eisschild;

   -- Alle Angaben sind Radien.
   Landgrößen : KartenRecords.LandgrößenRecord := KartengeneratorRecordKonstanten.Kontinentgröße;
   Abstände : KartenRecords.LandabständeRecord := KartengeneratorRecordKonstanten.Kontinentabstand;

   SchleifenanfangOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;
   SchleifenendeOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;

end KartengeneratorVariablen;
