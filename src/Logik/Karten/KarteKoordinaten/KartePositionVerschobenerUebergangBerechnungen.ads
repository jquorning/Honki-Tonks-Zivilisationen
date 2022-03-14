pragma SPARK_Mode (On);

with KartenDatentypen;
with KartenRecords;

package KartePositionVerschobenerUebergangBerechnungen is
   
   function PositionBestimmenYAchse
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositivMitNullwert;
   
   function PositionBestimmenXAchse
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenDatentypen.KartenfeldPositivMitNullwert;
   
private
   
   HalberWert : constant Float := 0.50;

end KartePositionVerschobenerUebergangBerechnungen;
