with RassenDatentypen;
with WichtigesRecordKonstanten;

with LeseWichtiges;
with SchreibeAllgemeines;
with LeseRassenbelegung;
with SchreibeRassenbelegung;

with AbspannLogik;
with NachGrafiktask;

package body SiegbedingungenLogik is

   function Siegbedingungen
     return SystemDatentypen.Ende_Enum
   is begin
      
      case
        RasseBesiegt
      is
         when False =>
            null;
            
         when True =>
            return SystemDatentypen.Verloren_Enum;
      end case;
            
      if
        SiegbedingungEins = True
      then
         Sieg := GrafikDatentypen.Gewonnen_Enum;
      
      elsif
        SiegbedingungZwei = True
      then
         Sieg := GrafikDatentypen.Gewonnen_Enum;
            
      else
         Sieg := GrafikDatentypen.Leer_Hintergrund_Enum;
      end if;
      
      case
        Sieg
      is 
         when GrafikDatentypen.Abspann_Enum'Range =>
            NachGrafiktask.AktuelleRasse := RassenDatentypen.Ekropa_Enum;
            AbspannLogik.Abspann (AbspannExtern => Sieg);
            NachGrafiktask.AktuelleRasse := RassenDatentypen.Keine_Rasse_Enum;
            return SystemDatentypen.Gewonnen_Enum;
            
         when others =>
            return SystemDatentypen.Leer_Enum;
      end case;
      
   end Siegbedingungen;
   
   
   
   function RasseBesiegt
     return Boolean
   is
      use type RassenDatentypen.Spieler_Enum;
   begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           LeseRassenbelegung.Besiegt (RasseExtern => RasseSchleifenwert)
         is
            when True =>
               SchreibeRassenbelegung.GanzerEintrag (RasseExtern   => RasseSchleifenwert,
                                                     EintragExtern => WichtigesRecordKonstanten.LeerRassenbelegung);
               
               if
                 LeseRassenbelegung.Belegung (RasseExtern => RasseSchleifenwert) = RassenDatentypen.Mensch_Spieler_Enum
               then
                  return True;
                  
               else
                  return False;
               end if;
               
            when False =>
               null;
         end case;
         
      end loop RassenSchleife;
      
      return False;
      
   end RasseBesiegt;
      
      
      
   function SiegbedingungEins
     return Boolean
   is begin
         
      VorhandeneRassen := 0;
      
      RassenSchleife:
      for RassenSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
          LeseRassenbelegung.Belegung (RasseExtern => RassenSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               VorhandeneRassen := VorhandeneRassen + 1;
         end case;
         
      end loop RassenSchleife;
      
      case
        VorhandeneRassen
      is
         when 0 =>
            -- Was mache ich denn in diesem Fall? Kann eventuell im neuen System auftreten, auf True lassen bis ich was besseres für die Enden gebaut habe. äöü
            return True;
            
         when 1 =>
            SchreibeAllgemeines.Gewonnen;
            return True;
            
         when others =>
            return False;
      end case;
      
   end SiegbedingungEins;
   
   
   
   function SiegbedingungZwei
     return Boolean
   is
      use type RassenDatentypen.Spieler_Enum;
   begin
      
      RassenGeldSchleife:
      for RassenGeldSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           LeseRassenbelegung.Belegung (RasseExtern => RassenGeldSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           LeseWichtiges.Geldmenge (RasseExtern => RassenGeldSchleifenwert) = Integer'Last
         then
            SchreibeAllgemeines.Gewonnen;
            return True;
            
         else
            null;
         end if;
         
      end loop RassenGeldSchleife;
      
      return False;
      
   end SiegbedingungZwei;

end SiegbedingungenLogik;
