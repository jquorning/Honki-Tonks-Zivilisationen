pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;

package OptionenSound is

   function OptionenSound
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end OptionenSound;
