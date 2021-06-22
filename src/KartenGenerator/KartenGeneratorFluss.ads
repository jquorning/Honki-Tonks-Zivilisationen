pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package KartenGeneratorFluss is

   procedure GenerierungFlüsse;

private

   WahrscheinlichkeitFluss : constant Float := 0.75;

   Flusswert : Positive;

   BeliebigerFlusswert : Float;
   
   StandardFluss : constant GlobaleDatentypen.KartenGrund := 43;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   procedure FlussUmgebungTesten
     (YKoordinateExtern, XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure FlussBerechnung
     (YKoordinateExtern, XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            XKoordinateExtern <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartenGeneratorFluss;
