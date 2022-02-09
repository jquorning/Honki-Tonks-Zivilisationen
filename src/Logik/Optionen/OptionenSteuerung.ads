pragma SPARK_Mode (On);

with Sf.Window.Keyboard;

with SystemDatentypen;

package OptionenSteuerung is

   function SteuerungBelegen
     return SystemDatentypen.Rückgabe_Werte_Enum;

private

   NeueTasteKonsole : Wide_Wide_Character;

   NeueAuswahl : SystemDatentypen.Tastenbelegung_Enum;

   NeueTasteSFML : Sf.Window.Keyboard.sfKeyCode;

   AuswahlWert : SystemDatentypen.Rückgabe_Werte_Enum;

   procedure AlteTasteEntfernen;
   procedure NeueTasteFestlegen;
   procedure AlteTasteEntfernenKonsole;
   procedure AlteTasteEntfernenSFML;
   procedure NeueTasteFestlegenKonsole;
   procedure NeueTasteFestlegenSFML;

end OptionenSteuerung;