pragma SPARK_Mode (On);

with SystemDatentypen;

package SpielEinstellungenKarten is
   
   function KartengrößeWählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartenartWählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartenformWählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartentemperaturWählen
     return SystemDatentypen.Rückgabe_Werte_Enum;
   
   function KartenressourcenWählen
     return SystemDatentypen.Rückgabe_Werte_Enum;
   
private
         
   KartengrößeAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   KartenartAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   KartenformAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   KartentemperaturAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   KartenressourcenAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   
   BenutzerdefinierteGröße : Integer;
   
   function GrößeSelbstBestimmen
     return SystemDatentypen.Rückgabe_Werte_Enum;

end SpielEinstellungenKarten;
