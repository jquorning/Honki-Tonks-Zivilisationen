pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KIEinheitUmsetzenNichts is

   function NichtsTun
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      -- Platzhalter
      case
        EinheitRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      return True;
      
   end NichtsTun;

end KIEinheitUmsetzenNichts;
