pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;

package Auswahl is

   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return RueckgabeDatentypen.Ja_Nein_Enum;
   
end Auswahl;
