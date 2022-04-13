pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikTonDatentypen;
with ZeitKonstanten;
with GlobaleVariablen;

with SoundSFML;
with InteraktionLogiktask;
with SoundKonsole;
with Fehler;
with InteraktionSoundtask;

package body StartSound is

   procedure StartSound
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      EinlesenAbwartenSchleife:
      while InteraktionLogiktask.EinlesenAbgeschlossen = False loop
         
         delay ZeitKonstanten.WartezeitSound;
         
      end loop EinlesenAbwartenSchleife;
      
      case
        InteraktionSoundtask.AktuellenSoundAbfragen
      is
         when GrafikTonDatentypen.Sound_SFML_Enum =>
            SoundSFML.SoundSFML;
            
         when GrafikTonDatentypen.Sound_Konsole_Enum =>
            SoundKonsole.SoundKonsole;
            
         when others =>
            Fehler.SoundFehler (FehlermeldungExtern => "StartSound.StartSound - Ungültige Soundwiedergabeart.");
      end case;
      
   end StartSound;

end StartSound;
