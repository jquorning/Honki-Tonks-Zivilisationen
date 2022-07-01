pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Window.Keyboard;
with Sf.Window.Mouse;

private with Sf.Window.Event;

package EingabeSystemeSFML is

   ErfolgreichAbbruch : Boolean;

   MausRad : Float;

   TastaturTaste : Sf.Window.Keyboard.sfKeyCode;

   MausTaste : Sf.Window.Mouse.sfMouseButton;

   EingegebenerText : Unbounded_Wide_Wide_String;

   procedure TastenEingabe;
   procedure TextEingeben;

private


   EingegebenesZeichen : Wide_Wide_Character;

   CharacterZuText : Wide_Wide_String (1 .. 1);

   ZeichenEingeben : Sf.Window.Event.sfEvent;
   TextEingegeben : Sf.Window.Event.sfEvent;

   procedure TextPrüfen
     (UnicodeNummerExtern : in Sf.sfUint32);

   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character);

   procedure ZeichenEntfernen;

end EingabeSystemeSFML;
