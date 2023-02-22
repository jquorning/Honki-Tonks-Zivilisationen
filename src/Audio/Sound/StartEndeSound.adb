with Sf.Audio.SoundStatus;
with Sf.Audio.Sound;
with Sf.Audio.SoundBuffer;

with EingeleseneSounds;

package body StartEndeSound is

   -- Sound wird direkt parallel aufgerufen. Steht auch im SFML Tutorial und der Beschreibung der ASFML.
   procedure Abspielen
     (SoundExtern : in TonDatentypen.Sound_Vorhanden_Enum)
   is
      use type Sf.Audio.sfSoundBuffer_Ptr;
      use type Sf.Audio.SoundStatus.sfSoundStatus;
      use type Sf.Audio.sfSound_Ptr;
   begin
      
      if
        EingeleseneSounds.Sound (SoundExtern) = null
      then
         null;
         
      elsif
        EingeleseneSounds.Soundaccesse (SoundExtern) = null
      then
         null;
         
      elsif
        Sf.Audio.Sound.getStatus (sound => EingeleseneSounds.Soundaccesse (SoundExtern)) = Sf.Audio.SoundStatus.sfPlaying
      then
         null;
         
      else
         Sf.Audio.Sound.play (sound => EingeleseneSounds.Soundaccesse (SoundExtern));
      end if;
      
   end Abspielen;
   
   
   
   procedure Stoppen
     (SoundExtern : in TonDatentypen.Sound_Vorhanden_Enum)
   is
      use type Sf.Audio.sfSoundBuffer_Ptr;
      use type Sf.Audio.sfSound_Ptr;
   begin
      
      if
        EingeleseneSounds.Sound (SoundExtern) = null
      then
         null;
         
      elsif
        EingeleseneSounds.Soundaccesse (SoundExtern) = null
      then
         null;
         
      else
         Sf.Audio.Sound.stop (sound => EingeleseneSounds.Soundaccesse (SoundExtern));
      end if;
      
   end Stoppen;
   
   
   
   procedure Entfernen
   is begin
      
      
      SoundSchleife:
      for SoundSchleifenwert in EingeleseneSounds.SoundaccesseArray'Range loop
         
         Sf.Audio.SoundBuffer.destroy (soundBuffer => EingeleseneSounds.Sound (SoundSchleifenwert));
         -- Das hier ist auf jeden Fall notwendig um die Fehlermeldung "AL lib: (EE) alc_cleanup: 1 device not closed" beim Beenden des Programms zu verhindern. Da oben drüber auch? äöü
         Sf.Audio.Sound.destroy (sound => EingeleseneSounds.Soundaccesse (SoundSchleifenwert));
         
      end loop SoundSchleife;
      
   end Entfernen;

end StartEndeSound;
