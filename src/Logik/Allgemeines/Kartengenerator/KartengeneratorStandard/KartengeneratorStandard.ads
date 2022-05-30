pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;

with Karten;

package KartengeneratorStandard is

   procedure OberflächeGenerieren;

private
   
   BeliebigerLandwert : KartenDatentypen.WahrscheinlichkeitKartengenerator;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type WahrscheinlichkeitenRecord is record
      
      Anfangswert : KartenDatentypen.WahrscheinlichkeitKartengenerator;
      Endwert : KartenDatentypen.WahrscheinlichkeitKartengenerator;
      
   end record;
   
   ---------------------------- Später Nutzereinstellbar machen.
   WahrscheinlichkeitLandmasse : constant WahrscheinlichkeitenRecord := (25, 80);
   WahrscheinlichkeitLandInLandmasse : constant WahrscheinlichkeitenRecord := (0, 85);
   WahrscheinlichkeitWasser : constant WahrscheinlichkeitenRecord := (0, 95);

   procedure LandVorhanden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure LandmasseGenerieren
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure AbstandGenerieren
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   procedure GrundSchreiben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      MasseAbstandExtern : in Boolean)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

end KartengeneratorStandard;
