package body EingeleseneSounds is

   procedure SoundsFestlegen
   is
      use type Sf.Audio.sfSoundBuffer_Ptr;
      use type Sf.Audio.sfSound_Ptr;
   begin
      
      -- Sollte ich den Buffer am Anfang schon für alle Sounds festlegen? äöü
      -- Ist das sinnvoll und funktioniert das so? äöü
      SoundSchleife:
      for SoundSchleifenwert in SoundaccesseArray'Range loop
         
         if
           Sound (SoundSchleifenwert) = null
         then
            null;
         
         elsif
           Soundaccesse (SoundSchleifenwert) = null
         then
            null;
            
         else
            Sf.Audio.Sound.setBuffer (sound  => Soundaccesse (SoundSchleifenwert),
                                      buffer => Sound (SoundSchleifenwert));
         end if;
         
      end loop SoundSchleife;
      
   end SoundsFestlegen;

end EingeleseneSounds;
