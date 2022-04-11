pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with SystemDatentypen;

package AuswahlMenue is

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

private

   Anfang : Positive;
   Ende : Positive;
   Ausgewählt : Positive;

   AktuelleAuswahl : Natural := 1;

   RückgabeWert : SystemDatentypen.Rückgabe_Werte_Enum;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   function Auswahl
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
      return Positive;

   function MausAuswahl
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
      return Natural;

end AuswahlMenue;
