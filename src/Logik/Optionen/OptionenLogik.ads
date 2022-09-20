pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;

package OptionenLogik is

   function Optionen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end OptionenLogik;