pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;

with SchreibeEinheitenGebaut;
  
with AufgabenAllgemein;

package body VerbesserungRoden is

   function VerbesserungRoden
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      case
        GrundExtern
      is
         when KartenGrundDatentypen.Wald_Enum | KartenGrundDatentypen.Dschungel_Enum | KartenGrundDatentypen.Sumpf_Enum =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => TastenbelegungDatentypen.Roden_Trockenlegen_Enum);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);
              
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      return True;
      
   end VerbesserungRoden;

end VerbesserungRoden;
