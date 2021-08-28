pragma SPARK_Mode (On);

with ForschungsDatenbank;

with SchreibeWichtiges;
with LeseWichtiges;

with ForschungAllgemein;

package body KIForschung is

   procedure Forschung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern)
      is
         when GlobaleDatentypen.ForschungIDMitNullWert'First =>      
            ForschungSchleife:
            for TechnologieSchleifenwert in ForschungsDatenbank.ForschungListeArray'Range (2) loop
               
               case
                 ForschungAllgemein.ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                                                  ForschungIDExtern => TechnologieSchleifenwert)
               is
                  when True =>
                     SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                                          ForschungIDExtern => TechnologieSchleifenwert);
                     return;
                     
                  when False =>
                     null;
               end case;
               
            end loop ForschungSchleife;
            
         when others =>
            null;
      end case;
      
   end Forschung;

end KIForschung;
