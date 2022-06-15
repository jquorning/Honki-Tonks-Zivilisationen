pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with ZahlenDatentypen;

with Karten;

package KartengeneratorKueste is

   procedure GenerierungKüstenSeeGewässer;

private
   
   Multiplikator : ZahlenDatentypen.EigenesPositive;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

end KartengeneratorKueste;
