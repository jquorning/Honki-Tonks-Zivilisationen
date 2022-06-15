pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with LadezeitenDatentypen;

with SchreibeKarten;

with Karten;
with Ladezeiten;

package body KartengeneratorHimmel is

   procedure Himmel
   is begin
      
      Multiplikator := 1;
               
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
               
            SchreibeKarten.GleicherGrund (KoordinatenExtern => (1, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengrundDatentypen.Wolken_Enum);
               
         end loop XAchseSchleife;
            
         if
           ZahlenDatentypen.EigenesPositive (YAchseSchleifenwert) >= Multiplikator * ZahlenDatentypen.EigenesPositive (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse) / 25
         then
            Ladezeiten.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
            Multiplikator := Multiplikator + 1;
               
         else
            null;
         end if;
         
      end loop YAchseSchleife;
         
   end Himmel;

end KartengeneratorHimmel;
