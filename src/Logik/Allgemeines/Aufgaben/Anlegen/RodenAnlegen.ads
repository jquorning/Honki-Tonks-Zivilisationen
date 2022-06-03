pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;

with Karten;

package RodenAnlegen is

   procedure RodenAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
end RodenAnlegen;
