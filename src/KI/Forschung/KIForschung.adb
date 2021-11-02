pragma SPARK_Mode (On);

with EinheitStadtDatentypen;

with ForschungsDatenbank;

with SchreibeWichtiges;
with LeseWichtiges;

with ForschungAllgemein;

package body KIForschung is

   procedure Forschung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern)
      is
         when EinheitStadtDatentypen.ForschungIDMitNullWert'First =>
            NeuesForschungsprojekt (RasseExtern => RasseExtern);
            
         when others =>
            null;
      end case;
      
   end Forschung;
   
   
   
   procedure NeuesForschungsprojekt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
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
      
   end NeuesForschungsprojekt;

end KIForschung;
