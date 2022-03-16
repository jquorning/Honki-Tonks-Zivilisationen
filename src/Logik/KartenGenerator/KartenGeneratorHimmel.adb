pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen;

with SchreibeKarten;

with Karten;

package body KartenGeneratorHimmel is

   procedure Himmel
   is begin
               
      YAchseHimmelSchleife:
      for YAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseHimmelSchleife:
         for XAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            SchreibeKarten.Grund (KoordinatenExtern => (1, YAchseHimmelSchleifenwert, XAchseHimmelSchleifenwert),
                                  GrundExtern       => KartenGrundDatentypen.Wolken_Enum);
               
         end loop XAchseHimmelSchleife;
      end loop YAchseHimmelSchleife;
         
   end Himmel;

end KartenGeneratorHimmel;
