pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;

package SpieleinstellungenSonstiges is

   procedure SchwierigkeitsgradFestlegen;
   
private
   
   SchwierigkeitAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end SpieleinstellungenSonstiges;
