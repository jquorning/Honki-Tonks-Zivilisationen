pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Rect;

package GrafikKonstanten is

   -- Da das ja Records sind, müsste das eher nach GrafikRecordKonstanten. äöü
   StandardAnzeigebereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 1.00);
   
   -- Später einbauen, wenn die Kartenberechnung überarbeitet wird. äöü
   KarteAnzeigebereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.80, 1.00);
   SeitenleisteAnzeigebereich : constant Sf.Graphics.Rect.sfFloatRect := (0.80, 0.00, 0.20, 1.00);

end GrafikKonstanten;