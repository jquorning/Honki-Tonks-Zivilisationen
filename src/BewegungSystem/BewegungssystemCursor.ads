pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package BewegungssystemCursor is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      RichtungExtern : in Positive;
      RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
     
   procedure GeheZuCursor
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

private

   Position : GlobaleRecords.AchsenKartenfeldPositivRecord;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   
   Änderung : GlobaleRecords.AchsenKartenfeldRecord;

   Wert : Integer;
   
   procedure BewegungCursorBerechnen
     (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         ((ÄnderungExtern.EAchse /= 0
          or
            ÄnderungExtern.YAchse /= 0
          or
            ÄnderungExtern.XAchse /= 0)
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   procedure BewegungCursorBerechnenStadt
     (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         ((ÄnderungExtern.EAchse /= 0
          or
            ÄnderungExtern.YAchse /= 0
          or
            ÄnderungExtern.XAchse /= 0)
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

end BewegungssystemCursor;
