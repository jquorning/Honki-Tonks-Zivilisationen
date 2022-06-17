pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with LadezeitenDatentypen;

with SchreibeKarten;

with Karten;
with Ladezeiten;

package body KartengeneratorWeltraum is

   procedure Weltraum
   is begin
      
      Multiplikator := 1;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartenparameter.Kartengröße.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartenparameter.Kartengröße.XAchse loop

            SchreibeKarten.GleicherGrund (KoordinatenExtern => (2, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengrundDatentypen.Weltraum_Enum);
               
         end loop XAchseSchleife;
            
         if
           ZahlenDatentypen.EigenesPositive (YAchseSchleifenwert) >= Multiplikator * ZahlenDatentypen.EigenesPositive (Karten.Kartenparameter.Kartengröße.YAchse) / 25
         then
            Ladezeiten.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
            Multiplikator := Multiplikator + 1;
               
         else
            null;
         end if;
         
      end loop YAchseSchleife;
      
   end Weltraum;

end KartengeneratorWeltraum;
