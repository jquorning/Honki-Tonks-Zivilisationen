pragma SPARK_Mode (On);

with GlobaleKonstanten;
  
with Eingabe, LeseStadtGebaut;

package body StadtSuchen is

   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert))
         is
            when GlobaleKonstanten.LeerStadtID =>
               null;
               
            when others =>
               if
                 LeseStadtGebaut.Position (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert)) = KoordinatenExtern
               then
                  return StadtNummerSchleifenwert;
            
               else
                  null;
               end if;
         end case;
         
      end loop StadtSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenStadtOhneRasseSuchen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
            
                  case
                    LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert))
                  is
                     when GlobaleKonstanten.LeerStadtID =>
                        null;
                        
                     when others =>
                        if
                          LeseStadtGebaut.Position (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert)) = KoordinatenExtern
                        then
                           return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
                        else
                           null;
                        end if;
                  end case;
            
               end loop StadtSchleife;
         end case;
         
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenStadtOhneSpezielleRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
         
         if
           RasseExtern = RasseSchleifenwert
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
            
         else
            StadtSchleife:
            for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop

               case
                 LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert))
               is
                  when GlobaleKonstanten.LeerStadtID =>
                     null;
                     
                  when others =>
                     if
                       LeseStadtGebaut.Position (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert)) = KoordinatenExtern
                     then
                        return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
                     else
                        null;
                     end if;
               end case;
            
            end loop StadtSchleife;
         end if;
         
      end loop RasseSchleife;
   
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end KoordinatenStadtOhneSpezielleRasseSuchen;
   
   
   
   function AnzahlStädteErmitteln
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      AnzahlStädte := 0;
      
      StädteSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert))
         is
            when GlobaleDatentypen.Leer =>
               null;
            
            when others =>
               AnzahlStädte := AnzahlStädte + 1;
         end case;
         
      end loop StädteSchleife;
         
      return AnzahlStädte;
      
   end AnzahlStädteErmitteln;
   

   
   function StadtNachNamenSuchen
     return GlobaleRecords.RassePlatznummerRecord
   is begin
      
      StadtName := Eingabe.StadtName;
      
      RasseSchleife:
      for RasseSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  case
                    LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert))
                  is
                     when GlobaleKonstanten.LeerStadtID =>
                        null;
                        
                     when others =>
                        if
                          LeseStadtGebaut.Name (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert)) = StadtName
                        then
                           return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
                        else
                           null;
                        end if;
                  end case;
            
               end loop StadtSchleife;
         end case;
         
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end StadtNachNamenSuchen;

end StadtSuchen;
