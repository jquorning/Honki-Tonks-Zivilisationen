pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with KartenDatentypen;

package KartengeneratorWeltraumLogik is
   pragma Elaborate_Body;

   procedure Weltraum;

private

   Kartenzeitwert : KartenDatentypen.KartenfeldNatural;

end KartengeneratorWeltraumLogik;
