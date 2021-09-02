pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert))
         is
            when GlobaleKonstanten.LeerEinheitenID =>
               null;
               
            when others =>
               if
                 LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) = KoordinatenExtern
               then
                  return EinheitNummerSchleifenwert;
            
               else
                  null;
               end if;
         end case;
         
      end loop EinheitSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end KoordinatenEinheitMitRasseSuchen;



   function KoordinatenTransporterMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert))
         is
            when GlobaleKonstanten.LeerEinheitenID =>
               null;
               
            when others =>
               if
                 LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) = KoordinatenExtern
                 and
                   LeseEinheitenDatenbank.KannTransportieren (RasseExtern => RasseExtern,
                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)))
                 /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
               then
                  return EinheitNummerSchleifenwert;
            
               else
                  null;
               end if;
         end case;
         
      end loop EinheitSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end KoordinatenTransporterMitRasseSuchen;



   -- Zu beachten, wenn die Einheit sich in einem Transporter befindet, dann wird immer die Nummer des Transporters zurückgegeben.
   function KoordinatenEinheitOhneRasseSuchen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               EinheitSchleife:
               for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
            
                  if
                    LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert)) = GlobaleKonstanten.LeerEinheitenID
                  then
                     null;
                     
                  elsif
                    LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert)) = KoordinatenExtern
                  then
                     case
                       LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert))
                     is
                        when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
                           return (RasseSchleifenwert, EinheitNummerSchleifenwert);
                  
                        when others =>
                           return (RasseSchleifenwert, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert)));
                     end case;
               
                  else
                     null;
                  end if;
            
               end loop EinheitSchleife;
         end case;
         
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end KoordinatenEinheitOhneRasseSuchen;



   -- Sucht ohne die Rasse die hineingegeben wird.
   function KoordinatenEinheitOhneSpezielleRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (1) loop
         
         if
           RasseExtern = RasseSchleifenwert
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
           
         else
            EinheitSchleife:
            for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop

               case
                 LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert))
               is
                  when GlobaleKonstanten.LeerEinheitenID =>
                     null;
                     
                  when others =>
                     if
                       LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert)) = KoordinatenExtern
                     then
                        return (RasseSchleifenwert, EinheitNummerSchleifenwert);
               
                     else
                        null;
                     end if;
               end case;
            
            end loop EinheitSchleife;
         end if;
         
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end KoordinatenEinheitOhneSpezielleRasseSuchen;



   function EinheitAufTransporterSuchen
     (TransporterExtern : in GlobaleRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin

      TransporterSchleife:
      for TransporterPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop
         
         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => TransporterPlatzSchleifenwert) = LadungExtern
         then
            return TransporterPlatzSchleifenwert;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end EinheitAufTransporterSuchen;



   function HatTransporterLadung
     (EinheitRassePlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      TransporterSchleife:
      for TransporterPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRassePlatznummerExtern.Rasse,
                                                                                                                                IDExtern    =>
                                                                                                                                  LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRassePlatznummerExtern)) loop
         
         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRassePlatznummerExtern,
                                              PlatzExtern              => TransporterPlatzSchleifenwert) /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
         then
            return True;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return False;
      
   end HatTransporterLadung;
   
   
   
   function MengeEinesEinheitenTypsSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      EinheitTypExtern : in GlobaleDatentypen.Einheit_Art_Verwendet_Enum;
      GesuchteMengeExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      AnzahlEinheitTyp := 0;
      
      EinheitSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         if
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert)) = GlobaleKonstanten.LeerEinheit.ID
         then
            null;
         
         elsif
           LeseEinheitenDatenbank.EinheitArt (RasseExtern => RasseExtern,
                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert))) = EinheitTypExtern
         then
            AnzahlEinheitTyp := AnzahlEinheitTyp + 1;
            
         else
            null;
         end if;
         
         if
           GesuchteMengeExtern > 0
           and
             AnzahlEinheitTyp >= GesuchteMengeExtern
         then
            return AnzahlEinheitTyp;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return AnzahlEinheitTyp;
      
   end MengeEinesEinheitenTypsSuchen;
   
   
   
   function AnzahlEinheitenSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      GesuchteMengeExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      AnzahlEinheiten := 0;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         if
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitenSchleifenwert)) /= GlobaleKonstanten.LeerEinheit.ID
         then
            AnzahlEinheiten := AnzahlEinheiten + 1;
            
         else
            null;
         end if;
         
         if
           GesuchteMengeExtern > 0
           and
             AnzahlEinheiten >= GesuchteMengeExtern
         then
            return AnzahlEinheiten;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end AnzahlEinheitenSuchen;     

end EinheitSuchen;