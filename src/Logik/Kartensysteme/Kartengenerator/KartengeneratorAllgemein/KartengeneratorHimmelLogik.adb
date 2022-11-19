with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;
with Weltkarte;

with SchreibeWeltkarte;
with LeseWeltkarteneinstellungen;

with LadezeitenLogik;

package body KartengeneratorHimmelLogik is

   procedure Himmel
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Kartenzeitwert := (LeseWeltkarteneinstellungen.YAchse + (25 - 1)) / 25;
               
      YAchseSchleife:
      for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. LeseWeltkarteneinstellungen.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. LeseWeltkarteneinstellungen.XAchse loop
               
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.HimmelKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                          GrundExtern       => KartengrundDatentypen.Wolken_Enum);
               
         end loop XAchseSchleife;
         
         case
           YAchseSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
               
            when others =>
               null;
         end case;
         
      end loop YAchseSchleife;
         
   end Himmel;

end KartengeneratorHimmelLogik;
