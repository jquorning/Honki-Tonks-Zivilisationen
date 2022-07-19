pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;
with GrafikDatentypen;
with OptionenVariablen;

with NachMusiktask;
with MusikSFML;
with MusikTerminal;
with Fehler;
with VonLogiktaskAnAlle;

package body StartMusik is

   procedure StartMusik
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      EinlesenAbwartenSchleife:
      while VonLogiktaskAnAlle.EinlesenAbgeschlossen = False loop
         
         delay ZeitKonstanten.WartezeitMusik;
         
      end loop EinlesenAbwartenSchleife;
      
      case
        NachMusiktask.AktuelleMusik
      is
         when TonDatentypen.Musik_SFML_Enum =>
            MusikSFML.MusikSFML;
            
         when TonDatentypen.Musik_Terminal_Enum =>
            MusikTerminal.MusikTerminal;
            
         when others =>
            Fehler.MusikFehler (FehlermeldungExtern => "StartMusik.StartMusik - Ungültige Musikwiedergabeart.");
      end case;
      
   end StartMusik;

end StartMusik;
