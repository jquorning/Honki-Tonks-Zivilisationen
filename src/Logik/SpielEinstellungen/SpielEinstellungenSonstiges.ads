pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package SpielEinstellungenSonstiges is

   function SchwierigkeitsgradFestlegen
     return SystemDatentypen.Rückgabe_Werte_Enum;
   
private
   
   SchwierigkeitAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;

end SpielEinstellungenSonstiges;
