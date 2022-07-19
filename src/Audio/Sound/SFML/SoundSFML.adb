pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;

with NachSoundtask;
with Fehler;
with SoundStartEndeSFML;

package body SoundSFML is

   procedure SoundSFML
   is begin
      
      -- Sound wird direkt parallel aufgerufen. Steht auch im SFML Tutorial und der Beschreibung der ASFML.
      SoundStartEndeSFML.SoundAbspielen;
      
      SoundSchleife:
      loop
         
         case
           NachSoundtask.AktuellerSound
         is
            when TonDatentypen.Sound_Terminal_Enum =>
               Fehler.SoundFehler (FehlermeldungExtern => "SoundSFML.SoundSFML - Terminal wird bei SFML aufgerufen.");
               
            when TonDatentypen.Sound_SFML_Enum =>
               delay ZeitKonstanten.WartezeitSound;
               
            when TonDatentypen.Sound_Ende_Enum =>
               exit SoundSchleife;
         end case;
         
      end loop SoundSchleife;
      
      SoundStartEndeSFML.SoundStoppen;
      SoundStartEndeSFML.SoundEntfernen;
      
   end SoundSFML;

end SoundSFML;
