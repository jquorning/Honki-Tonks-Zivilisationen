pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;

package AuswahlMenuesStringsSetzen is

   function StringSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
      return Wide_Wide_String;
   
   function RassenbeschreibungSetzen
     (WelcheZeileExtern : in Positive)
      return Wide_Wide_String;
   
private
   
   AktuellerText : Unbounded_Wide_Wide_String;

end AuswahlMenuesStringsSetzen;
