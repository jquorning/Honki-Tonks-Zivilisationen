pragma SPARK_Mode (On);

with GlobaleTexte;
with SystemKonstanten;

with OptionenSteuerung;
with Auswahl;
with OptionenSound;
with OptionenGrafik;
with OptionenSonstiges;
with AuswahlMenue;

package body Optionen is

   function Optionen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      RückgabeWert := 1_000;

      OptionenSchleife:
      loop
         
         AuswahlWert := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Optionen_Menü);

         case
           AuswahlWert
         is
            when SystemDatentypen.Zurück | SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return AuswahlWert;
               
               -- Grafik
            when 1 =>
               RückgabeWert := OptionenGrafik.OptionenGrafik;
               
               -- Sound
            when 2 =>
               RückgabeWert := OptionenSound.OptionenSound;
               
               -- Steuerung
            when 3 =>
               RückgabeWert := OptionenSteuerung.SteuerungBelegen;
               
               -- Sonstiges
            when 4 =>
               RückgabeWert := OptionenSonstiges.Sonstiges;
               
            when others =>
               null;
         end case;

         case
           RückgabeWert
         is
            when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return RückgabeWert;
                     
            when others =>
               null;
         end case;

      end loop OptionenSchleife;
      
   end Optionen;

end Optionen;
