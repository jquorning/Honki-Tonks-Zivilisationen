pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.Audio;
private with Sf.Audio.Sound;

package SoundStartEndeSFML is

   procedure SoundAbspielen;
   procedure SoundStoppen;
   procedure SoundEntfernen;

private

   SoundTest : constant Sf.Audio.sfSound_Ptr := Sf.Audio.Sound.create;

end SoundStartEndeSFML;
